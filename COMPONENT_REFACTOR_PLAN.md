# Component-Level Architecture Refactoring Plan

**Date:** 2025-11-17
**Issue:** Critical architectural discrepancy - missing component-level processing
**Reference:** CODE_VERIFICATION_REPORT.md - Issue #2

---

## Executive Summary

The current meal calculation implementation treats `CenMeals` as single entities, missing the fundamental PowerBuilder architecture where each meal has multiple components (`CenMealsDetail`) that are processed individually. This refactor addresses the core architectural issue.

**Scope:** Complete refactoring of meal calculation to support component-level processing
**Estimated Effort:** High - Affects all calculation services
**Risk:** High if not done correctly - will break all meal calculations

---

## PowerBuilder Architecture (Target State)

### Data Model

```
CenMeals (Meal Definition Header)
├─ nhandling_meal_key (PK)
├─ cclass (Y, C, F)
├─ nreserve_quantity
├─ nreserve_type
├─ ntopoff_quantity
├─ ntopoff_type
└─ CenMealsDetail[] (ONE-TO-MANY)
    ├─ nhandling_detail_key (PK)
    ├─ nhandling_meal_key (FK to CenMeals)
    ├─ ncomponent_group (Component grouping)
    ├─ nprio (Priority/sequence)
    ├─ nspml_deduction (0=no deduct, 1=deduct SPML)
    ├─ npercentage (Component percentage)
    ├─ ncalc_id (Calculation type)
    └─ npackinglist_index_key (What item this component is)

CenOutMeals (Output - ONE RECORD PER COMPONENT)
├─ nresult_key + ndetail_key (PK)
├─ cclass
├─ nquantity (Component quantity)
├─ nspml_deduction (Flag: was SPML deducted?)
├─ nspml_quantity (How many SPMLs deducted)
├─ ncomponent_group
├─ nprio
└─ ... (50+ other fields)
```

### Calculation Flow (PowerBuilder)

```
For each CenMeals (meal definition):
    For each CenMealsDetail (component):
        1. Get calc basis (PAX count or meal count)
        2. If component.nspml_deduction = 1:
           - Calculate SPML count for class (ONCE per class)
           - calcBasis -= spmlCount
           - if calcBasis < 0 then calcBasis = 0
        3. Apply component percentage
        4. Apply reserves (from meal header)
        5. Apply topoffs (from meal header)
        6. Create CenOutMeals record for THIS COMPONENT
        7. Set nspml_quantity = spmlCount (for tracking)
```

---

## Current Java Implementation (Problem)

### What's Wrong

1. **MealDefinitionLookupService**
   - Only loads `CenMeals` headers
   - Does NOT load `CenMealsDetail` components
   - Returns single meal, not meal + components

2. **MealQuantityCalculationService**
   - Processes each `CenMeals` as single entity
   - Creates ONE `CenOutMeals` record per meal (should be one per component)
   - No SPML deduction during calculation
   - No component grouping or priority

3. **SpmlDistributionService**
   - Wrong timing - deducts AFTER calculation (should be DURING)
   - Wrong granularity - deducts from meals, not components
   - Never sets `nspml_deduction` or `nspml_quantity` fields

4. **Missing**
   - `CenMealsDetailRepository` - doesn't exist
   - Component-level DTO/model classes
   - SPML count calculation per class

---

## Refactoring Steps

### Phase 1: Repository and Data Access

#### Step 1.1: Create CenMealsDetailRepository

**File:** `cbase-service-parent/flightcalculation/src/main/java/.../persistence/CenMealsDetailRepository.java`

```java
@Repository
public interface CenMealsDetailRepository extends JpaRepository<CenMealsDetail, Long> {

    /**
     * Find all components for a meal definition.
     *
     * @param handlingMealKey The meal definition key
     * @param validDate The date for validity check
     * @return List of meal components
     */
    @Query("SELECT d FROM CenMealsDetail d " +
           "WHERE d.cenMeals.nhandlingMealKey = :handlingMealKey " +
           "AND d.dvalidFrom <= :validDate " +
           "AND d.dvalidTo >= :validDate " +
           "ORDER BY d.nprio ASC")
    List<CenMealsDetail> findByMealKeyAndDate(
        @Param("handlingMealKey") Long handlingMealKey,
        @Param("validDate") Date validDate);

    /**
     * Find all components for multiple meal definitions.
     *
     * @param handlingMealKeys List of meal definition keys
     * @param validDate The date for validity check
     * @return List of meal components
     */
    @Query("SELECT d FROM CenMealsDetail d " +
           "WHERE d.cenMeals.nhandlingMealKey IN :handlingMealKeys " +
           "AND d.dvalidFrom <= :validDate " +
           "AND d.dvalidTo >= :validDate " +
           "ORDER BY d.cenMeals.nhandlingMealKey ASC, d.nprio ASC")
    List<CenMealsDetail> findByMealKeysAndDate(
        @Param("handlingMealKeys") List<Long> handlingMealKeys,
        @Param("validDate") Date validDate);
}
```

**Test Creation:**
- Create `CenMealsDetailRepositoryTest.java`
- Test finding components by meal key
- Test date validity filtering
- Test ordering by priority

#### Step 1.2: Update MealDefinitionLookupService

**Changes:**
```java
@Service
public class MealDefinitionLookupService {

    private final CenMealsRepository mealsRepository;
    private final CenMealsDetailRepository mealsDetailRepository;  // NEW

    /**
     * Find meal definitions WITH components for route/class/period.
     *
     * @param context Calculation context
     * @return List of meal definitions with components loaded
     */
    public List<MealDefinitionWithComponents> findMealDefinitions(
            MealCalculationContext context) {

        // 1. Find meal headers (existing logic)
        List<CenMeals> mealHeaders = findMealHeaders(context);

        // 2. Load components for each meal (NEW)
        List<MealDefinitionWithComponents> result = new ArrayList<>();
        for (CenMeals meal : mealHeaders) {
            List<CenMealsDetail> components = mealsDetailRepository
                .findByMealKeyAndDate(
                    meal.getNhandlingMealKey(),
                    context.getDepartureDate());

            if (components.isEmpty()) {
                LOGGER.warn("Meal {} has no components, skipping",
                    meal.getNhandlingMealKey());
                continue;
            }

            result.add(new MealDefinitionWithComponents(meal, components));
        }

        return result;
    }
}
```

**New DTO:**
```java
public class MealDefinitionWithComponents {
    private final CenMeals mealHeader;
    private final List<CenMealsDetail> components;

    // Constructor, getters
}
```

---

### Phase 2: SPML Count Calculation

#### Step 2.1: Add SPML Count Calculator

**File:** `SpmlCountCalculator.java` (new service)

```java
@Service
public class SpmlCountCalculator {

    /**
     * Calculate SPML count for a service class.
     *
     * PowerBuilder: uf_get_spml_count() lines 15557-15602
     *
     * Rules:
     * - Only count SPMLs for the specified class
     * - Exclude SPMLs with ntopoff = 1 (TopOff SPMLs)
     * - Exclude preorder SPMLs if configured
     *
     * @param spmlData All SPML records
     * @param classCode Service class (Y, C, F)
     * @return Total SPML count for this class
     */
    public int calculateSpmlCount(List<CenOutSpml> spmlData, String classCode) {
        if (spmlData == null || spmlData.isEmpty()) {
            return 0;
        }

        int spmlCount = 0;

        for (CenOutSpml spml : spmlData) {
            // Only count SPMLs for this class
            if (!classCode.equals(spml.getCclass())) {
                continue;
            }

            // Exclude TopOff SPMLs (ntopoff = 1)
            if (spml.getNtopoff() != null && spml.getNtopoff() == 1) {
                continue;
            }

            // TODO: Handle preorder exclusion if needed
            // if (spml.getNspmlKey().equals(preorderKey)) continue;

            spmlCount += spml.getNquantity().intValue();
        }

        LOGGER.debug("Calculated SPML count for class {}: {} SPMLs",
            classCode, spmlCount);

        return spmlCount;
    }
}
```

---

### Phase 3: Component-Level Calculation

#### Step 3.1: Refactor MealQuantityCalculationService

**Major Changes:**

```java
@Service
public class MealQuantityCalculationService {

    private final SpmlCountCalculator spmlCountCalculator;  // NEW

    /**
     * Calculate meal quantities at COMPONENT level.
     *
     * PowerBuilder: Lines 3080-3098, 4700-5070
     *
     * CRITICAL: One CenOutMeals record per COMPONENT, not per meal!
     *
     * @param context Calculation context (includes PAX, SPML data)
     * @param mealDefinitions Meal definitions WITH components
     * @return List of CenOutMeals records (one per component)
     */
    public List<CenOutMeals> calculateMealQuantities(
            MealCalculationContext context,
            List<MealDefinitionWithComponents> mealDefinitions) {

        List<CenOutMeals> allComponents = new ArrayList<>();

        // Group PAX by class
        Map<String, Integer> paxByClass = groupPaxByClass(context.getPaxData());

        // Calculate SPML count per class (ONCE per class)
        Map<String, Integer> spmlByClass = calculateSpmlByClass(
            context.getSpmlData());

        // Process each meal definition
        for (MealDefinitionWithComponents mealDef : mealDefinitions) {
            CenMeals mealHeader = mealDef.getMealHeader();
            List<CenMealsDetail> components = mealDef.getComponents();

            String classCode = mealHeader.getCclass();
            int paxCount = paxByClass.getOrDefault(classCode, 0);
            int spmlCount = spmlByClass.getOrDefault(classCode, 0);

            // Process EACH component individually
            for (CenMealsDetail component : components) {
                CenOutMeals componentRecord = calculateComponent(
                    context,
                    mealHeader,
                    component,
                    paxCount,
                    spmlCount);

                allComponents.add(componentRecord);
            }
        }

        LOGGER.info("Calculated {} component records from {} meal definitions",
            allComponents.size(), mealDefinitions.size());

        return allComponents;
    }

    /**
     * Calculate a single component quantity.
     *
     * PowerBuilder: Lines 3080-3098 (SPML deduction)
     *               Lines 7212-7348 (reserves/topoffs)
     *
     * @param context Calculation context
     * @param mealHeader Meal definition header (for reserves/topoffs)
     * @param component Component detail
     * @param paxCount PAX count for this class
     * @param spmlCount SPML count for this class
     * @return CenOutMeals record for this component
     */
    private CenOutMeals calculateComponent(
            MealCalculationContext context,
            CenMeals mealHeader,
            CenMealsDetail component,
            int paxCount,
            int spmlCount) {

        // Step 1: Calculate basis (PAX or meal count)
        int calcBasis = paxCount;  // Simplified - may vary by calc type

        // Step 2: SPML deduction (DURING calculation, not after!)
        boolean spmlDeducted = false;
        if (component.getNspmlDeduction() == 1) {
            calcBasis -= spmlCount;
            if (calcBasis < 0) {
                calcBasis = 0;
            }
            spmlDeducted = true;

            LOGGER.debug("Component {}: SPML deduction applied, basis {} -> {}",
                component.getNhandlingDetailKey(), paxCount, calcBasis);
        }

        // Step 3: Apply component percentage
        int componentQuantity = applyComponentPercentage(
            calcBasis, component.getNpercentage());

        // Step 4: Apply reserves (from meal header)
        int reserveQuantity = applyReserves(
            componentQuantity,
            paxCount,
            mealHeader.getNreserveQuantity(),
            mealHeader.getNreserveType(),
            context.getAircraftVersion());

        componentQuantity += reserveQuantity;

        // Step 5: Apply topoffs (from meal header)
        int topoffQuantity = applyTopOffs(
            componentQuantity,
            paxCount,
            mealHeader.getNtopoffQuantity(),
            mealHeader.getNtopoffType(),
            context.getAircraftVersion());

        componentQuantity += topoffQuantity;

        // Step 6: Create CenOutMeals record for this component
        CenOutMeals outMeal = new CenOutMeals();

        // Set IDs
        CenOutMealsId id = new CenOutMealsId();
        id.setNresultKey(context.getResultKey());
        id.setNdetailKey(generateDetailKey());  // Sequential per flight
        outMeal.setId(id);

        // Set class and quantity
        outMeal.setCclass(mealHeader.getCclass());
        outMeal.setNquantity(BigDecimal.valueOf(componentQuantity));

        // Set SPML tracking fields
        outMeal.setNspmlDeduction(spmlDeducted ? 1 : 0);
        outMeal.setNspmlQuantity(spmlDeducted ? spmlCount : 0);

        // Set component fields
        outMeal.setNcomponentGroup(component.getNcomponentGroup());
        outMeal.setNprio(component.getNprio());
        outMeal.setNhandlingDetailKey(component.getNhandlingDetailKey());

        // Copy other fields from component...

        return outMeal;
    }

    private Map<String, Integer> calculateSpmlByClass(List<CenOutSpml> spmlData) {
        // Use SpmlCountCalculator for each class
        Map<String, Integer> result = new HashMap<>();

        // Get unique classes from SPML data
        Set<String> classes = spmlData.stream()
            .map(CenOutSpml::getCclass)
            .collect(Collectors.toSet());

        for (String classCode : classes) {
            int count = spmlCountCalculator.calculateSpmlCount(spmlData, classCode);
            result.put(classCode, count);
        }

        return result;
    }

    private int applyComponentPercentage(int calcBasis, int percentage) {
        if (percentage == 100 || percentage == 0) {
            return calcBasis;
        }
        return (int) Math.ceil((calcBasis * percentage) / 100.0);
    }
}
```

---

### Phase 4: Update Services

#### Step 4.1: Remove SPML Post-Processing

**SpmlDistributionService Changes:**

```java
@Service
public class SpmlDistributionService {

    /**
     * Distribute special meals - RESOLUTION ONLY.
     *
     * SPML deduction is now handled DURING component calculation,
     * not as post-processing.
     *
     * This method now only:
     * - Resolves SPML codes to definitions
     * - Validates SPML quantities
     * - Creates SPML distribution metadata
     *
     * @param context Calculation context
     * @param componentRecords Component records (already calculated with SPML deduction)
     * @return SPML distribution metadata
     */
    public List<SpmlDistribution> distributeSpecialMeals(
            MealCalculationContext context,
            List<CenOutMeals> componentRecords) {

        // No longer modifies componentRecords quantities!
        // Just resolves and validates

        List<SpmlDistribution> distributions = new ArrayList<>();

        for (CenOutSpml spml : context.getSpmlData()) {
            Optional<CenMealsSpml> spmlDef = resolveSpmlCode(
                spml.getCspml(), context.getRotationKey());

            SpmlDistribution dist = new SpmlDistribution();
            dist.setSpmlCode(spml.getCspml());
            dist.setSpmlQuantity(spml.getNquantity().intValue());
            dist.setClassCode(spml.getCclass());
            dist.setSpmlDefinition(spmlDef.orElse(null));

            distributions.add(dist);
        }

        return distributions;
    }

    // REMOVE: deductFromRegularMeals() method - no longer needed!
}
```

#### Step 4.2: Update Orchestrator

**MealCalculationService Changes:**

```java
@Transactional
public MealCalculationResult calculateMeals(
        CenOutPpmFlights flight,
        boolean forceRecalculation) {

    // ... validation, context building ...

    // Step 4: Find meal definitions WITH components
    List<MealDefinitionWithComponents> mealDefinitions =
        mealDefinitionLookupService.findMealDefinitions(context);

    // Step 5: Calculate component quantities (SPML deduction integrated)
    List<CenOutMeals> componentRecords =
        mealQuantityCalculationService.calculateMealQuantities(
            context, mealDefinitions);

    // Step 6: SPML resolution (no quantity modification)
    if (context.getSpmlData() != null && !context.getSpmlData().isEmpty()) {
        List<SpmlDistribution> distributions =
            spmlDistributionService.distributeSpecialMeals(
                context, componentRecords);
        // Store distributions for reporting if needed
    }

    // Step 7: Generate meal layout
    List<CenOutMeals> layoutMeals =
        mealLayoutGenerationService.generateMealLayout(
            context, componentRecords);

    // ... rest of workflow ...
}
```

---

### Phase 5: Testing

#### Step 5.1: Update Unit Tests

**MealQuantityCalculationServiceTest:**

```java
@Test
@DisplayName("Calculate components with SPML deduction per component")
void testComponentLevelCalculationWithSpml() {
    // Given: Meal with 3 components, 2 with SPML deduction
    CenMeals mealHeader = createMealHeader();
    mealHeader.setNreserveQuantity(10);
    mealHeader.setNreserveType(0);

    List<CenMealsDetail> components = new ArrayList<>();

    // Appetizer: SPML deduction = 1
    CenMealsDetail appetizer = createComponent();
    appetizer.setNspmlDeduction(1);
    appetizer.setNpercentage(100);
    components.add(appetizer);

    // Main: SPML deduction = 1
    CenMealsDetail main = createComponent();
    main.setNspmlDeduction(1);
    main.setNpercentage(100);
    components.add(main);

    // Dessert: SPML deduction = 0 (no deduction)
    CenMealsDetail dessert = createComponent();
    dessert.setNspmlDeduction(0);
    dessert.setNpercentage(100);
    components.add(dessert);

    MealDefinitionWithComponents mealDef =
        new MealDefinitionWithComponents(mealHeader, components);

    // Context with 150 PAX, 10 SPML
    MealCalculationContext context = createContext(150, 10);

    // When
    List<CenOutMeals> result = service.calculateMealQuantities(
        context, List.of(mealDef));

    // Then: Should have 3 component records
    assertEquals(3, result.size());

    // Appetizer: (150 - 10) + 10 reserve = 150
    CenOutMeals appetizerOut = result.get(0);
    assertEquals(150, appetizerOut.getNquantity().intValue());
    assertEquals(1, appetizerOut.getNspmlDeduction());
    assertEquals(10, appetizerOut.getNspmlQuantity());

    // Main: (150 - 10) + 10 reserve = 150
    CenOutMeals mainOut = result.get(1);
    assertEquals(150, mainOut.getNquantity().intValue());
    assertEquals(1, mainOut.getNspmlDeduction());
    assertEquals(10, mainOut.getNspmlQuantity());

    // Dessert: 150 + 10 reserve = 160 (NO SPML deduction)
    CenOutMeals dessertOut = result.get(2);
    assertEquals(160, dessertOut.getNquantity().intValue());
    assertEquals(0, dessertOut.getNspmlDeduction());
    assertEquals(0, dessertOut.getNspmlQuantity());
}
```

#### Step 5.2: Integration Tests

**MealCalculationServiceIntegrationTest:**

```java
@Test
@DisplayName("Complete workflow with component-level processing")
void testCompleteWorkflowWithComponents() {
    // Given: Flight with meal definition that has multiple components

    // Mock meal definition lookup to return meal with 3 components
    CenMeals meal = createMeal();
    List<CenMealsDetail> components = createThreeComponents();
    when(mealDefinitionLookupService.findMealDefinitions(any()))
        .thenReturn(List.of(new MealDefinitionWithComponents(meal, components)));

    // When
    MealCalculationResult result = service.calculateMeals(flight, false);

    // Then: Should create 3 component records, not 1 meal record
    assertTrue(result.isSuccess());
    assertEquals(3, result.getMealsGenerated());

    // Verify component-level calculation was called
    verify(mealQuantityCalculationService).calculateMealQuantities(
        any(), argThat(list ->
            list.get(0).getComponents().size() == 3));
}
```

---

### Phase 6: Migration Path

#### Step 6.1: Feature Flag (Optional)

Add feature flag to toggle between old and new implementation:

```java
@Value("${meal.calculation.use-component-level:false}")
private boolean useComponentLevel;

public MealCalculationResult calculateMeals(...) {
    if (useComponentLevel) {
        return calculateMealsComponentLevel(...);
    } else {
        return calculateMealsLegacy(...);
    }
}
```

#### Step 6.2: Data Verification

Before deploying, verify with production data:

```sql
-- Check component counts
SELECT
    cm.nhandling_meal_key,
    cm.cmeal_code,
    COUNT(cmd.nhandling_detail_key) as component_count
FROM cen_meals cm
LEFT JOIN cen_meals_detail cmd ON cm.nhandling_meal_key = cmd.nhandling_meal_key
WHERE cm.dvalid_from <= SYSDATE
  AND cm.dvalid_to >= SYSDATE
GROUP BY cm.nhandling_meal_key, cm.cmeal_code
HAVING COUNT(cmd.nhandling_detail_key) = 0;

-- Should return 0 rows (all meals should have components)
```

---

## Implementation Order

### Week 1: Foundation
1. ✅ Create `CenMealsDetailRepository`
2. ✅ Create `MealDefinitionWithComponents` DTO
3. ✅ Create `SpmlCountCalculator` service
4. ✅ Write unit tests for repository and calculator

### Week 2: Service Refactoring
5. ✅ Refactor `MealDefinitionLookupService.findMealDefinitions()`
6. ✅ Refactor `MealQuantityCalculationService.calculateMealQuantities()`
7. ✅ Implement `calculateComponent()` method
8. ✅ Update unit tests for both services

### Week 3: Integration
9. ✅ Update `SpmlDistributionService` (remove deduction logic)
10. ✅ Update `MealCalculationService` orchestration
11. ✅ Write integration tests
12. ✅ Test with sample PowerBuilder data

### Week 4: Validation & Deployment
13. ✅ Compare outputs with PowerBuilder using real data
14. ✅ Fix any discrepancies found
15. ✅ Update all documentation
16. ✅ Deploy to test environment
17. ✅ Production deployment

---

## Success Criteria

### Functional
- ✅ Each `CenMealsDetail` creates exactly one `CenOutMeals` record
- ✅ SPML deduction happens DURING calculation, not after
- ✅ Component-level `nspml_deduction` flags are respected
- ✅ `nspml_quantity` field is correctly populated
- ✅ Component grouping and priority are preserved
- ✅ Meal quantities match PowerBuilder for same input data

### Technical
- ✅ All unit tests pass (100% coverage of new code)
- ✅ Integration tests pass
- ✅ Performance acceptable (<2sec for typical flight)
- ✅ No regressions in existing functionality
- ✅ Code review approved
- ✅ Documentation complete

---

## Risks & Mitigation

### Risk 1: Breaking Existing Tests
**Mitigation:** Update tests incrementally, keep old tests for reference

### Risk 2: Performance Degradation
**Mitigation:** Load components in batch, not per meal; add caching if needed

### Risk 3: Data Model Mismatch
**Mitigation:** Verify CenMealsDetail entity has all required fields

### Risk 4: Complex Calculation Types
**Mitigation:** Start with simple calc types, add complex ones incrementally

---

## Rollback Plan

If issues found in production:

1. **Immediate:** Revert to previous deployment using feature flag
2. **Short-term:** Fix issues in separate branch, re-test thoroughly
3. **Long-term:** If unfixable, keep old implementation until resolved

---

**Document Version:** 1.0
**Last Updated:** 2025-11-17
**Status:** Ready for Implementation
