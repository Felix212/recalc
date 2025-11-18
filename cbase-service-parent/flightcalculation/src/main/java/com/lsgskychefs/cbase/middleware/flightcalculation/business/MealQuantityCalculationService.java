/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.dto.MealCalculationContext;
import com.lsgskychefs.cbase.middleware.flightcalculation.dto.MealDefinitionWithComponents;
import com.lsgskychefs.cbase.middleware.persistence.domain.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;

/**
 * Service for calculating meal quantities based on PAX counts.
 *
 * <p>PowerBuilder equivalent methods from uo_meal_calculation:
 * <ul>
 *   <li>uf_calculate_meals() - Main calculation</li>
 *   <li>uf_calculate_base_quantity() - Base meal calc</li>
 *   <li>uf_apply_reserves() - Apply reserve quantities</li>
 *   <li>uf_apply_topoffs() - Apply top-off quantities</li>
 *   <li>uf_calculate_ratio() - Meals per PAX ratio</li>
 * </ul>
 *
 * @author Migration Team
 */
@Service
public class MealQuantityCalculationService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MealQuantityCalculationService.class);

	private final SpmlCountCalculator spmlCountCalculator;
	private final AtomicLong detailKeySequence = new AtomicLong(1);

	@Autowired
	public MealQuantityCalculationService(SpmlCountCalculator spmlCountCalculator) {
		this.spmlCountCalculator = spmlCountCalculator;
	}

	/**
	 * Calculate meal quantities for all service classes.
	 *
	 * <p>PowerBuilder: uf_calculate_meals()
	 *
	 * @param paxData List of PAX counts per class
	 * @param mealDefinitions List of meal definitions
	 * @param mealCovers List of meal covers (optional)
	 * @param aircraftVersion Aircraft seating capacity (use 999 if unknown)
	 * @return Map of class code to meal quantities
	 */
	public Map<String, MealQuantityResult> calculateMealQuantities(
			List<CenOutPax> paxData,
			List<CenMeals> mealDefinitions,
			List<CenMealCover> mealCovers,
			int aircraftVersion) {

		Map<String, MealQuantityResult> results = new HashMap<>();

		LOGGER.info("Calculating meal quantities for {} PAX records and {} meal definitions (aircraft version={})",
				paxData.size(), mealDefinitions.size(), aircraftVersion);

		// Group PAX by class
		Map<String, Integer> paxByClass = groupPaxByClass(paxData);

		// Calculate for each class
		for (Map.Entry<String, Integer> entry : paxByClass.entrySet()) {
			String classCode = entry.getKey();
			int paxCount = entry.getValue();

			LOGGER.debug("Processing class={}, pax={}", classCode, paxCount);

			// Find meal definition for this class
			Optional<CenMeals> mealDef = findMealDefinitionForClass(
					mealDefinitions, classCode);

			if (mealDef.isPresent()) {
				MealQuantityResult result = calculateForClass(
						paxCount, mealDef.get(), mealCovers, aircraftVersion);  // FIXED: Added aircraftVersion
				results.put(classCode, result);

				LOGGER.info("Class {}: {} PAX -> {} meals (base={}, reserve={}, topoff={})",
						classCode, paxCount, result.getFinalQuantity(),
						result.getBaseQuantity(), result.getReserveQuantity(),
						result.getTopoffQuantity());
			} else {
				LOGGER.warn("No meal definition found for class={}", classCode);
			}
		}

		return results;
	}

	/**
	 * Calculate meal quantity for a single class.
	 *
	 * @param paxCount PAX count for the class
	 * @param mealDef Meal definition
	 * @param mealCovers Meal covers (optional)
	 * @param aircraftVersion Aircraft seating capacity (default: 999 if not available)
	 * @return Calculation result
	 */
	private MealQuantityResult calculateForClass(
			int paxCount,
			CenMeals mealDef,
			List<CenMealCover> mealCovers,
			int aircraftVersion) {

		MealQuantityResult result = new MealQuantityResult();
		result.setPaxCount(paxCount);

		// Step 1: Calculate base quantity
		int baseQuantity = calculateBaseQuantity(paxCount, mealCovers);
		result.setBaseQuantity(baseQuantity);

		// Step 2: Apply reserves
		int reserveQuantity = applyReserves(
				baseQuantity,
				paxCount,
				mealDef.getNreserveQuantity(),
				mealDef.getNreserveType(),
				aircraftVersion);  // FIXED: Added aircraftVersion parameter
		result.setReserveQuantity(reserveQuantity);

		int quantityWithReserve = baseQuantity + reserveQuantity;

		// Step 3: Apply top-offs
		int topoffQuantity = applyTopOffs(
				quantityWithReserve,
				paxCount,
				mealDef.getNtopoffQuantity(),
				mealDef.getNtopoffType(),
				aircraftVersion);  // FIXED: Added aircraftVersion parameter
		result.setTopoffQuantity(topoffQuantity);

		// Step 4: Final quantity
		int finalQuantity = quantityWithReserve + topoffQuantity;
		result.setFinalQuantity(finalQuantity);

		// Step 5: Calculate ratio
		BigDecimal ratio = calculateRatio(finalQuantity, paxCount);
		result.setRatio(ratio);

		return result;
	}

	/**
	 * Calculate base meal quantity.
	 *
	 * <p>PowerBuilder: uf_calculate_base_quantity()
	 *
	 * <p>Base calculation logic:
	 * <ul>
	 *   <li>If meal covers exist: Use cover ratio * PAX</li>
	 *   <li>Otherwise: 1:1 ratio (1 meal per PAX)</li>
	 * </ul>
	 *
	 * @param paxCount PAX count
	 * @param mealCovers Meal covers (optional)
	 * @return Base meal quantity
	 */
	public int calculateBaseQuantity(int paxCount, List<CenMealCover> mealCovers) {
		if (paxCount == 0) {
			return 0;
		}

		// If no meal covers, use 1:1 ratio
		if (mealCovers == null || mealCovers.isEmpty()) {
			LOGGER.debug("No meal covers, using 1:1 ratio: {} PAX -> {} meals",
					paxCount, paxCount);
			return paxCount;
		}

		// Use meal cover ratio (typically the first cover)
		CenMealCover primaryCover = mealCovers.get(0);
		// Note: Meal cover ratio logic would go here if the entity has a ratio field
		// For now, use 1:1 as default
		int baseQuantity = paxCount;

		LOGGER.debug("Base quantity calculated: {} meals for {} PAX",
				baseQuantity, paxCount);

		return baseQuantity;
	}

	/**
	 * Apply reserve quantities.
	 *
	 * <p>PowerBuilder: Lines 7212-7277 in uo_meal_calculation.sru
	 *
	 * <p><strong>IMPORTANT:</strong> All reserve types use FIXED quantities, not percentages!
	 * The difference is in the APPLICATION RULES:
	 * <ul>
	 *   <li>Type 0: Always add fixed reserve quantity</li>
	 *   <li>Type 1: Add fixed reserve, capped at aircraft capacity (version)</li>
	 *   <li>Type 2: Add fixed reserve only if PAX > 0</li>
	 *   <li>Type 3: Add fixed reserve if PAX > 0, capped at aircraft capacity</li>
	 * </ul>
	 *
	 * @param baseMealQuantity Base meal quantity (typically equals paxCount)
	 * @param paxCount PAX count
	 * @param reserveQuantity Reserve amount (ALWAYS A FIXED NUMBER)
	 * @param reserveType Reserve type (0, 1, 2, or 3)
	 * @param aircraftVersion Aircraft seating capacity/version
	 * @return Additional reserve quantity
	 */
	public int applyReserves(
			int baseMealQuantity,
			int paxCount,
			int reserveQuantity,
			int reserveType,
			int aircraftVersion) {

		if (reserveQuantity == 0) {
			return 0;
		}

		int calcBasis = baseMealQuantity; // Start with base (typically = PAX)
		int reserve;

		// PowerBuilder: Lines 7221-7277
		switch (reserveType) {
			case 0:
				// Type 0: Always add fixed reserve
				// PowerBuilder: lCalcBasis = lPax + lReserveQuantity
				reserve = reserveQuantity;
				LOGGER.debug("Reserve Type 0 (always add): {} + {} = {}",
						baseMealQuantity, reserve, calcBasis + reserve);
				break;

			case 1:
				// Type 1: Add reserve but cap at aircraft version
				// PowerBuilder: if lPax + lReserveQuantity > iVersion then lCalcBasis = iVersion
				if (baseMealQuantity + reserveQuantity > aircraftVersion) {
					// Would exceed capacity - only add enough to reach capacity
					reserve = Math.max(0, aircraftVersion - baseMealQuantity);
					LOGGER.debug("Reserve Type 1 (capped at version): {} + {} would exceed {}, capping at {}",
							baseMealQuantity, reserveQuantity, aircraftVersion, reserve);
				} else {
					reserve = reserveQuantity;
					LOGGER.debug("Reserve Type 1 (add with version check): {} + {} = {} (< version {})",
							baseMealQuantity, reserve, calcBasis + reserve, aircraftVersion);
				}
				break;

			case 2:
				// Type 2: Add reserve only if PAX > 0
				// PowerBuilder: if lPax > 0 then lCalcBasis = lPax + lReserveQuantity else lCalcBasis = 0
				if (paxCount > 0) {
					reserve = reserveQuantity;
					LOGGER.debug("Reserve Type 2 (PAX > 0): {} + {} = {}",
							baseMealQuantity, reserve, calcBasis + reserve);
				} else {
					reserve = 0;
					LOGGER.debug("Reserve Type 2: No PAX, no reserve");
				}
				break;

			case 3:
				// Type 3: Add reserve if PAX > 0 AND cap at version
				// PowerBuilder: if lPax > 0 then check version cap else 0
				if (paxCount > 0) {
					if (baseMealQuantity + reserveQuantity > aircraftVersion) {
						reserve = Math.max(0, aircraftVersion - baseMealQuantity);
						LOGGER.debug("Reserve Type 3 (PAX > 0, capped): {} + {} would exceed {}, capping at {}",
								baseMealQuantity, reserveQuantity, aircraftVersion, reserve);
					} else {
						reserve = reserveQuantity;
						LOGGER.debug("Reserve Type 3 (PAX > 0, add): {} + {} = {}",
								baseMealQuantity, reserve, calcBasis + reserve);
					}
				} else {
					reserve = 0;
					LOGGER.debug("Reserve Type 3: No PAX, no reserve");
				}
				break;

			default:
				LOGGER.warn("Unknown reserve type: {}, using 0", reserveType);
				reserve = 0;
		}

		return reserve;
	}

	/**
	 * Apply top-off quantities.
	 *
	 * <p>PowerBuilder: Lines 7280-7348 in uo_meal_calculation.sru
	 *
	 * <p><strong>IMPORTANT:</strong> All topoff types use FIXED quantities, not percentages!
	 * The difference is in the APPLICATION RULES:
	 * <ul>
	 *   <li>Type 0: Always add fixed topoff quantity</li>
	 *   <li>Type 1: Add fixed topoff, capped at aircraft capacity (version)</li>
	 *   <li>Type 2: Add fixed topoff only if PAX > 0</li>
	 *   <li>Type 3: Add fixed topoff if PAX > 0, capped at aircraft capacity</li>
	 * </ul>
	 *
	 * <p>Note: TopOffs are NOT applied if PAX exceeds aircraft version (overbooked)
	 *
	 * @param mealQuantity Current meal quantity (base + reserves)
	 * @param paxCount PAX count
	 * @param topoffQuantity Top-off amount (ALWAYS A FIXED NUMBER)
	 * @param topoffType Top-off type (0, 1, 2, or 3)
	 * @param aircraftVersion Aircraft seating capacity/version
	 * @return Additional top-off quantity
	 */
	public int applyTopOffs(
			int mealQuantity,
			int paxCount,
			int topoffQuantity,
			int topoffType,
			int aircraftVersion) {

		if (topoffQuantity == 0) {
			return 0;
		}

		// PowerBuilder: Lines 7283-7286
		// If overbooked (PAX > version), don't apply topoff
		// TopOff rule must not cause reduction
		if (paxCount > aircraftVersion) {
			LOGGER.debug("TopOff skipped: PAX ({}) exceeds aircraft version ({}), no topoff to prevent reduction",
					paxCount, aircraftVersion);
			return 0;
		}

		int topoff;

		// PowerBuilder: Lines 7288-7316
		switch (topoffType) {
			case 0:
				// Type 0: Always add fixed topoff
				// PowerBuilder: lCalcBasis = lCalcBasis + lTopOffQuantity
				topoff = topoffQuantity;
				LOGGER.debug("TopOff Type 0 (always add): {} + {} = {}",
						mealQuantity, topoff, mealQuantity + topoff);
				break;

			case 1:
				// Type 1: Add topoff but cap at aircraft version
				// PowerBuilder: if lCalcBasis + lTopOffQuantity > iVersion then lCalcBasis = iVersion
				if (mealQuantity + topoffQuantity > aircraftVersion) {
					// Would exceed capacity - only add enough to reach capacity
					topoff = Math.max(0, aircraftVersion - mealQuantity);
					LOGGER.debug("TopOff Type 1 (capped at version): {} + {} would exceed {}, capping at {}",
							mealQuantity, topoffQuantity, aircraftVersion, topoff);
				} else {
					topoff = topoffQuantity;
					LOGGER.debug("TopOff Type 1 (add with version check): {} + {} = {} (< version {})",
							mealQuantity, topoff, mealQuantity + topoff, aircraftVersion);
				}
				break;

			case 2:
				// Type 2: Add topoff only if PAX > 0
				// PowerBuilder: if lPax > 0 then lCalcBasis = lCalcBasis + lTopOffQuantity
				if (paxCount > 0) {
					topoff = topoffQuantity;
					LOGGER.debug("TopOff Type 2 (PAX > 0): {} + {} = {}",
							mealQuantity, topoff, mealQuantity + topoff);
				} else {
					topoff = 0;
					LOGGER.debug("TopOff Type 2: No PAX, no topoff");
				}
				break;

			case 3:
				// Type 3: Add topoff if PAX > 0 AND cap at version
				// PowerBuilder: if lPax > 0 then check version cap
				if (paxCount > 0) {
					if (mealQuantity + topoffQuantity > aircraftVersion) {
						topoff = Math.max(0, aircraftVersion - mealQuantity);
						LOGGER.debug("TopOff Type 3 (PAX > 0, capped): {} + {} would exceed {}, capping at {}",
								mealQuantity, topoffQuantity, aircraftVersion, topoff);
					} else {
						topoff = topoffQuantity;
						LOGGER.debug("TopOff Type 3 (PAX > 0, add): {} + {} = {}",
								mealQuantity, topoff, mealQuantity + topoff);
					}
				} else {
					topoff = 0;
					LOGGER.debug("TopOff Type 3: No PAX, no topoff");
				}
				break;

			default:
				LOGGER.warn("Unknown topoff type: {}, using 0", topoffType);
				topoff = 0;
		}

		return topoff;
	}

	/**
	 * Calculate meal ratio (meals per passenger).
	 *
	 * <p>PowerBuilder: uf_calculate_ratio()
	 *
	 * @param mealQuantity Total meal quantity
	 * @param paxCount PAX count
	 * @return Ratio with 3 decimal places
	 */
	public BigDecimal calculateRatio(int mealQuantity, int paxCount) {
		if (paxCount == 0) {
			return BigDecimal.ZERO;
		}

		BigDecimal ratio = BigDecimal.valueOf(mealQuantity)
				.divide(BigDecimal.valueOf(paxCount), 3, RoundingMode.HALF_UP);

		LOGGER.debug("Calculated ratio: {} meals / {} PAX = {}",
				mealQuantity, paxCount, ratio);

		return ratio;
	}

	/**
	 * Group PAX data by service class.
	 *
	 * @param paxData List of PAX records
	 * @return Map of class code to total PAX count
	 */
	private Map<String, Integer> groupPaxByClass(List<CenOutPax> paxData) {
		Map<String, Integer> grouped = new HashMap<>();

		for (CenOutPax pax : paxData) {
			String classCode = pax.getCclass();
			int paxCount = pax.getNpax() != null ? pax.getNpax().intValue() : 0;

			grouped.merge(classCode, paxCount, Integer::sum);
		}

		return grouped;
	}

	/**
	 * Find meal definition for a service class.
	 *
	 * @param mealDefinitions List of meal definitions
	 * @param classCode Service class code
	 * @return Meal definition if found
	 */
	private Optional<CenMeals> findMealDefinitionForClass(
			List<CenMeals> mealDefinitions,
			String classCode) {

		return mealDefinitions.stream()
				.filter(m -> Objects.equals(String.valueOf(m.getNclassNumber()), classCode))
				.findFirst();
	}

	//===================================================================================
	// COMPONENT-LEVEL CALCULATION METHODS (PowerBuilder-compliant architecture)
	//===================================================================================

	/**
	 * Calculate meal quantities at COMPONENT level.
	 *
	 * <p>PowerBuilder: Lines 3080-3098 (SPML deduction), 4700-5070 (component processing)
	 *
	 * <p>CRITICAL: This method creates ONE CenOutMeals record PER COMPONENT, not per meal!
	 *
	 * <p>Process:
	 * <ol>
	 *   <li>Calculate SPML count per service class (once per class)</li>
	 *   <li>For each meal definition with components:</li>
	 *   <ul>
	 *     <li>For each component:</li>
	 *     <ul>
	 *       <li>Get calc basis (PAX count)</li>
	 *       <li>If component.nspml_deduction = 1: Deduct SPMLs from basis</li>
	 *       <li>Apply component percentage</li>
	 *       <li>Apply reserves (from meal header)</li>
	 *       <li>Apply topoffs (from meal header)</li>
	 *       <li>Create CenOutMeals record for this component</li>
	 *     </ul>
	 *   </ul>
	 * </ol>
	 *
	 * @param context Calculation context (includes PAX, SPML data, aircraft version)
	 * @param mealDefinitions Meal definitions WITH components
	 * @return List of CenOutMeals records (one per component)
	 */
	public List<CenOutMeals> calculateMealQuantitiesWithComponents(
			MealCalculationContext context,
			List<MealDefinitionWithComponents> mealDefinitions) {

		List<CenOutMeals> allComponentRecords = new ArrayList<>();

		LOGGER.info("Calculating meal quantities at component level for result_key={}, {} meal definitions",
				context.getResultKey(), mealDefinitions.size());

		// Group PAX by class
		Map<String, Integer> paxByClass = groupPaxByClass(context.getPaxData());

		// Calculate SPML count per class (ONCE per class)
		Map<String, Integer> spmlByClass = spmlCountCalculator
				.calculateSpmlCountsByClass(context.getSpmlData());

		LOGGER.debug("PAX by class: {}", paxByClass);
		LOGGER.debug("SPML by class: {}", spmlByClass);

		// Reset detail key sequence for this flight
		detailKeySequence.set(1);

		// Process each meal definition
		for (MealDefinitionWithComponents mealDef : mealDefinitions) {
			CenMeals mealHeader = mealDef.getMealHeader();
			List<CenMealsDetail> components = mealDef.getComponents();

			String classCode = mealHeader.getCclass();
			int paxCount = paxByClass.getOrDefault(classCode, 0);
			int spmlCount = spmlByClass.getOrDefault(classCode, 0);

			LOGGER.debug("Processing meal {}: class={}, {} components, PAX={}, SPML={}",
					mealHeader.getNhandlingMealKey(), classCode, components.size(), paxCount, spmlCount);

			// Process EACH component individually
			for (CenMealsDetail component : components) {
				CenOutMeals componentRecord = calculateComponentQuantity(
						context,
						mealHeader,
						component,
						paxCount,
						spmlCount);

				allComponentRecords.add(componentRecord);
			}
		}

		LOGGER.info("Created {} component records from {} meal definitions for result_key={}",
				allComponentRecords.size(), mealDefinitions.size(), context.getResultKey());

		return allComponentRecords;
	}

	/**
	 * Calculate quantity for a single component.
	 *
	 * <p>PowerBuilder: Lines 3080-3098 (SPML deduction), 7212-7348 (reserves/topoffs)
	 *
	 * <p>This method implements the PowerBuilder component-level calculation logic:
	 * <pre>
	 * // Get calculation basis
	 * uf_get_calc_basis()  // Sets lCalcBasis = PAX count
	 *
	 * // SPML deduction (DURING calculation, not after!)
	 * lNumberOfSPML = uf_get_spml_count()
	 * if iSPMLDeduction = 1 then
	 *     lCalcBasis -= lNumberOfSPML
	 *     if lCalcBasis < 0 then lCalcBasis = 0
	 * end if
	 *
	 * // Calculate component quantity from adjusted basis
	 * // Apply percentage, reserves, topoffs...
	 *
	 * // Store SPML quantity on component
	 * dsCenOutMeals.SetItem(lRow,"nspml_quantity", lNumberOfSPML)
	 * </pre>
	 *
	 * @param context Calculation context
	 * @param mealHeader Meal definition header (for reserves/topoffs)
	 * @param component Component detail
	 * @param paxCount PAX count for this class
	 * @param spmlCount SPML count for this class (pre-calculated)
	 * @return CenOutMeals record for this component
	 */
	private CenOutMeals calculateComponentQuantity(
			MealCalculationContext context,
			CenMeals mealHeader,
			CenMealsDetail component,
			int paxCount,
			int spmlCount) {

		// Step 1: Calculate basis (PAX or meal count depending on calc type)
		// For now, simplified to PAX count
		int calcBasis = paxCount;

		// Step 2: SPML deduction (DURING calculation, not after!)
		// PowerBuilder lines 3085-3098
		boolean spmlDeducted = false;
		if (component.getNspmlDeduction() == 1 && spmlCount > 0) {
			calcBasis -= spmlCount;
			if (calcBasis < 0) {
				calcBasis = 0;
			}
			spmlDeducted = true;

			LOGGER.debug("Component {}: SPML deduction applied, {} PAX - {} SPML = {} basis",
					component.getNhandlingDetailKey(), paxCount, spmlCount, calcBasis);
		}

		// Step 3: Apply component percentage
		// PowerBuilder: various calculation types based on ncalc_id
		int componentQuantity = applyComponentPercentage(calcBasis, component.getNpercentage());

		LOGGER.debug("Component {}: After percentage {}: {} basis * {}% = {}",
				component.getNhandlingDetailKey(), component.getNpercentage(),
				calcBasis, component.getNpercentage(), componentQuantity);

		// Step 4: Apply reserves (from meal header)
		// PowerBuilder lines 7212-7277
		int reserveQuantity = applyReserves(
				componentQuantity,
				paxCount,
				mealHeader.getNreserveQuantity(),
				mealHeader.getNreserveType(),
				context.getAircraftVersion());

		componentQuantity += reserveQuantity;

		// Step 5: Apply topoffs (from meal header)
		// PowerBuilder lines 7280-7348
		int topoffQuantity = applyTopOffs(
				componentQuantity,
				paxCount,
				mealHeader.getNtopoffQuantity(),
				mealHeader.getNtopoffType(),
				context.getAircraftVersion());

		componentQuantity += topoffQuantity;

		LOGGER.debug("Component {}: Final quantity = {} (reserve={}, topoff={})",
				component.getNhandlingDetailKey(), componentQuantity, reserveQuantity, topoffQuantity);

		// Step 6: Create CenOutMeals record for this component
		CenOutMeals outMeal = createComponentRecord(
				context,
				mealHeader,
				component,
				componentQuantity,
				spmlDeducted ? 1 : 0,
				spmlDeducted ? spmlCount : 0);

		return outMeal;
	}

	/**
	 * Apply component percentage to calc basis.
	 *
	 * <p>PowerBuilder: Various calculation types based on cen_meals_detail.ncalc_id
	 *
	 * @param calcBasis Calculation basis (PAX count after SPML deduction)
	 * @param percentage Component percentage (0-100, or special values)
	 * @return Component quantity
	 */
	private int applyComponentPercentage(int calcBasis, int percentage) {
		if (percentage == 0) {
			return 0;
		}

		if (percentage == 100) {
			// 100% = 1:1 ratio
			return calcBasis;
		}

		// Apply percentage
		return (int) Math.ceil((calcBasis * percentage) / 100.0);
	}

	/**
	 * Create CenOutMeals record for a component.
	 *
	 * <p>PowerBuilder: Lines 4700-5070 (uf_insert_cen_out_meals)
	 *
	 * @param context Calculation context
	 * @param mealHeader Meal header
	 * @param component Component detail
	 * @param quantity Final quantity for this component
	 * @param spmlDeduction SPML deduction flag (0 or 1)
	 * @param spmlQuantity SPML quantity that was deducted
	 * @return CenOutMeals record
	 */
	private CenOutMeals createComponentRecord(
			MealCalculationContext context,
			CenMeals mealHeader,
			CenMealsDetail component,
			int quantity,
			int spmlDeduction,
			int spmlQuantity) {

		CenOutMeals outMeal = new CenOutMeals();

		// Set composite key
		CenOutMealsId id = new CenOutMealsId();
		id.setNresultKey(context.getResultKey());
		id.setNdetailKey(detailKeySequence.getAndIncrement());  // Sequential per flight
		outMeal.setId(id);

		// Set quantity
		outMeal.setNquantity(BigDecimal.valueOf(quantity));

		// Set SPML tracking fields (CRITICAL - missing in old implementation)
		outMeal.setNspmlDeduction(spmlDeduction);
		outMeal.setNspmlQuantity(spmlQuantity);

		// Set component fields
		outMeal.setNcomponentGroup(component.getNcomponentGroup());
		outMeal.setNprio(component.getNprio());
		outMeal.setNhandlingDetailKey(component.getNhandlingDetailKey());

		// Set class
		outMeal.setCclass(mealHeader.getCclass());

		// Set meal code
		outMeal.setCmealCode(mealHeader.getCmealCode());

		// Copy other fields from component
		if (component.getCenPackinglistIndex() != null) {
			outMeal.setNpackinglistIndexKey(
					component.getCenPackinglistIndex().getNpackinglistIndexKey());
		}

		outMeal.setCpackinglist(component.getCproductionText());

		// Set creation tracking
		outMeal.setCupdatedBy("SYSTEM");
		outMeal.setDupdatedDate(new Date());

		LOGGER.debug("Created CenOutMeals: result_key={}, detail_key={}, quantity={}, " +
						"component_group={}, spml_deduction={}, spml_quantity={}",
				id.getNresultKey(), id.getNdetailKey(), quantity,
				component.getNcomponentGroup(), spmlDeduction, spmlQuantity);

		return outMeal;
	}

	/**
	 * Group PAX data by service class.
	 *
	 * @param paxData PAX records
	 * @return Map of class code to total PAX count
	 */
	private Map<String, Integer> groupPaxByClass(List<CenOutPax> paxData) {
		if (paxData == null || paxData.isEmpty()) {
			return Collections.emptyMap();
		}

		return paxData.stream()
				.collect(Collectors.groupingBy(
						CenOutPax::getCclass,
						Collectors.summingInt(pax ->
								pax.getNpax() != null ? pax.getNpax().intValue() : 0)));
	}

	/**
	 * Result of meal quantity calculation for a class.
	 */
	public static class MealQuantityResult {
		private int paxCount;
		private int baseQuantity;
		private int reserveQuantity;
		private int topoffQuantity;
		private int finalQuantity;
		private BigDecimal ratio;

		// Getters and setters

		public int getPaxCount() {
			return paxCount;
		}

		public void setPaxCount(int paxCount) {
			this.paxCount = paxCount;
		}

		public int getBaseQuantity() {
			return baseQuantity;
		}

		public void setBaseQuantity(int baseQuantity) {
			this.baseQuantity = baseQuantity;
		}

		public int getReserveQuantity() {
			return reserveQuantity;
		}

		public void setReserveQuantity(int reserveQuantity) {
			this.reserveQuantity = reserveQuantity;
		}

		public int getTopoffQuantity() {
			return topoffQuantity;
		}

		public void setTopoffQuantity(int topoffQuantity) {
			this.topoffQuantity = topoffQuantity;
		}

		public int getFinalQuantity() {
			return finalQuantity;
		}

		public void setFinalQuantity(int finalQuantity) {
			this.finalQuantity = finalQuantity;
		}

		public BigDecimal getRatio() {
			return ratio;
		}

		public void setRatio(BigDecimal ratio) {
			this.ratio = ratio;
		}
	}
}
