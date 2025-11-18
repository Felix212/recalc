# CRITICAL FINDING: Missing 110+ Calculation Types

**Date:** 2025-11-17
**Severity:** ⚠️ **CRITICAL - BLOCKS PRODUCTION**
**Impact:** Java implementation cannot handle 96% of PowerBuilder calculation types

---

## Executive Summary

**PowerBuilder has 114 calculation types (CalcIDs 1-114)**
**Java has 4 calculation types (0-3)**
**Gap: 110 missing calculation types (96% missing!)**

This means the Java implementation can only handle ~4% of the calculation scenarios that PowerBuilder supports.

---

## PowerBuilder Implementation

### Location
- **File:** `uo_meal_calculation.sru`
- **Function:** `uf_calculate()` (line 8598)
- **Switch Statement:** Lines 9006+ (Choose Case lCalcID)
- **Documentation:** Lines 8620-8743 (complete list of 114 types)

### Calculation Types Found (Partial List)

```powerbuilder
Choose Case lCalcID
    case 1
        // Feste Menge (Fixed Quantity)
        dcQuantity = dcValue

    case 2
        // 100% für Klasse (Full House)
        dcQuantity = iVersion

    case 3
        // Ratiolist
        uf_calc_ratiolist()

    case 4
        // Normal (PAX count 1:1)
        dcQuantity = lCalcBasis

    case 5
        // Prozent (Percentage with LH rounding)
        uf_calc_percent(0)

    case 6
        // Prozent kfm. (Percentage commercial rounding)
        uf_calc_percent_com()

    case 7, 68
        // Vielfaches (Multiple)
        uf_calc_multiple()

    case 8
        // Ganzzahliges (Integer steps)
        uf_calc_integer()

    case 9, 10
        // Bosta-Plus (PAX + percentage/absolute)
        uf_calc_bosta_plus()

    case 11, 12
        // Bosta-Minus (PAX - percentage/absolute)
        uf_calc_bosta_minus()

    case 13
        // Prozent-Vielfach (Percentage multiple)
        uf_calc_percent_multiple()

    case 14
        // Prozent absolut (Percentage + absolute)
        uf_calc_percent(dcValue)

    case 15, 16, 17
        // Gesamtpassagierzahl (Total PAX / PAX+Crew / Crew only)
        uf_calc_booking_classes()

    case 18
        // Stücklisten Ratiolist (Packing list ratio)
        uf_calc_ratiolist2()

    case 19
        // Differenz zu Full-House
        uf_calc_difference_fullhouse()

    case 20
        // Prozent minus absolut
        uf_calc_percent(dcValue * -1)

    case 21
        // Vielfaches m
        uf_calc_multiple_m()

    case 22
        // Feste Menge ab i Paxe (Fixed if PAX >= threshold)
        if lCalcBasis >= iPercentage then
            dcQuantity = dcValue
        else
            dcQuantity = 0
        end if

    case 23
        // Prozent inkl. Ergebnis 0 (Percentage allowing zero)
        uf_calc_percent_zero()

    case 24-27
        // Ratiolist auf Buchungsklassen (Ratio on booking classes)
        // Multiple variations

    case 28
        // n% für Klasse (n% for class)
        dcQuantity = Round((iVersion - lNumberOfSPML) * iPercentage / 100, 0)

    case 29-34
        // Paxe n Klassen (Multi-class PAX calculations)
        // +Prozent, Vielfach, Absolut, -Absolut, -Prozent variations
        uf_calc_multi_class_sum(1)

    ... (continues to case 114)
```

---

## Java Implementation

### Current State

**File:** `HandlingCalculationService.java`
**Method:** `calculateQuantity()`

```java
switch (calculationType) {
    case 0: // Fixed quantity
        quantity = handlingQuantity;
        break;

    case 1: // Per PAX
        quantity = (int) Math.ceil((paxCount * handlingQuantity) / 100.0);
        break;

    case 2: // Per meal
        quantity = mealCount * handlingQuantity;
        break;

    case 3: // Per PAX rounded
        quantity = (int) ((paxCount + handlingQuantity - 1) / handlingQuantity);
        break;

    default:
        quantity = handlingQuantity;
}
```

**That's it. Only 4 types.**

---

## Gap Analysis

### Missing Calculation Type Categories

#### 1. **Percentage Calculations** (17+ variations)
- Type 5: Percentage with LH rounding
- Type 6: Percentage commercial rounding
- Type 13: Percentage multiple
- Type 14: Percentage + absolute
- Type 20: Percentage - absolute
- Type 23: Percentage including zero
- Type 28: n% for class
- Type 41: PAX n classes percentage
- Type 42: Version n classes percentage
- Type 44: Version n classes - percentage LH rounding
- Type 61-63: Diff full house percentage variations
- Type 64: Percentage multiple for groups
- Type 65-66: Percentage round down variations
- Type 67: Percentage city pair
- Type 69: n% for class LH rounding
- Type 76: Percentage round down +/- absolute
- Type 98: Percentage round-off with absolute

**Java Equivalent:** NONE (Type 1 is just simple percentage)

#### 2. **Ratio-Based Calculations** (10+ variations)
- Type 3: Ratiolist
- Type 18: Packing list ratiolist
- Type 24-27: Ratiolist on booking classes (4 variations)
- Type 82: Ratiolist percentage
- Type 83: Ratiolist percentage + return flight PAX
- Type 90: Ratiolist percentage + group + version cutoff
- Type 108-109: Ratio list preorder variations

**Java Equivalent:** NONE

#### 3. **Multi-Class Calculations** (16 variations)
- Type 29: PAX n classes
- Type 30: PAX n classes + percentage
- Type 31: PAX n classes multiple
- Type 32: PAX n classes absolute
- Type 33: PAX n classes - absolute
- Type 34: PAX n classes - percentage
- Type 35-40: Version n classes variations (6 types)
- Type 41: PAX n classes percentage
- Type 42: Version n classes percentage
- Type 43: Seat PAX n classes
- Type 45: PAX n classes multiple with SPML deduction

**Java Equivalent:** NONE

#### 4. **BOSTA Calculations** (8+ variations)
- Type 9-10: BOSTA + (absolute/percentage)
- Type 11-12: BOSTA - (absolute/percentage)
- Type 107: BOSTA+ percentage up to max config for class

**Java Equivalent:** NONE

#### 5. **BOB Calculations** (15+ variations)
- Type 70: BOB percentage + minimum
- Type 71: BOB percentage - xx%
- Type 72: BOB percentage + minimum (always round down)
- Type 73: BOB percentage - xx% (always round down)
- Type 74: BOB percentage + minimum (commercial rounding)
- Type 75: BOB percentage - xx% (commercial rounding)
- Type 77: Fixed quantity BOB
- Type 79: BOB % CP round up with max
- Type 80: BOB % CP round down with max
- Type 81: BOB % CP com with max
- Type 92: BOB multiple N
- Type 93: BOB multiple N with max
- Type 101: BOB % CP round off with min/max
- Type 102: BOB % CP round down with min/max
- Type 103: BOB % CP round up with min/max
- Type 104: BOB %-xx% CP round up with max

**Java Equivalent:** NONE

#### 6. **Multiple/Integer Calculations** (10+ variations)
- Type 7: Multiple (all n PAX one portion)
- Type 8: Integer (in n steps until PAX reached)
- Type 21: Multiple n (all i PAX n portions)
- Type 68: Multiple with max
- Type 92-93: BOB multiple variations
- Type 95: Multiple & Fixed (American Airlines)
- Type 106: Multiple n per city pair
- Type 110: Linked multiple
- Type 113: Multiple with ZERO

**Java Equivalent:** Type 3 is vaguely similar but different logic

#### 7. **Booking Class Calculations** (6+ variations)
- Type 15: Passengers
- Type 16: Passengers + crew
- Type 17: Crew only
- Type 24-27: Ratio on booking classes

**Java Equivalent:** NONE

#### 8. **Difference Calculations** (5 variations)
- Type 19: Difference to full house
- Type 61: Diff full house percentage
- Type 62: Diff full house percentage commercial
- Type 63: Diff full house percentage incl. 0
- Type 114: Diff by galley region per PAX

**Java Equivalent:** NONE

#### 9. **Fixed Quantity Variations** (8+ variations)
- Type 1: Fixed quantity
- Type 22: Fixed quantity from PAX threshold
- Type 77: Fixed quantity BOB
- Type 78: Fixed quantity city pair
- Type 90: Value per AC type + version
- Type 100: Fixed up to version/PAX difference
- Type 105: Fixed per AC type & version & departure station

**Java Equivalent:** Type 0 is basic fixed, others MISSING

#### 10. **American Airlines Specific** (3 variations)
- Type 95: Multiple & Fixed (AA)
- Type 96: Percentage (AA)
- Type 94: Link (AA)

**Java Equivalent:** NONE

#### 11. **Linked Calculations** (3 variations)
- Type 94: Linked (AA)
- Type 110: Linked multiple
- Type 111: Linked percent round commercial
- Type 112: Linked percent round up

**Java Equivalent:** NONE

#### 12. **Full House Variations** (1 variation)
- Type 2: 100% for class (full house)

**Java Equivalent:** PARTIAL (could use fixed quantity = version)

---

## Impact Assessment

### Critical Business Impact

**Production Deployment is BLOCKED** until calculation types are properly implemented.

#### Scenarios That WILL FAIL:

1. **Any ratio-based meal calculation**
   - Ratiolists are commonly used for meal distribution
   - 0% coverage in Java

2. **Any multi-class calculation**
   - Premium cabins often combine classes
   - 0% coverage in Java

3. **Any BOSTA calculation**
   - Board status adjustments
   - 0% coverage in Java

4. **Any BOB calculation**
   - Buy-on-board products
   - 0% coverage in Java

5. **Any percentage variation beyond basic**
   - LH rounding, commercial rounding, with minimums, etc.
   - 96% of percentage types missing

6. **Crew-only items**
   - Type 17: Crew only
   - 0% coverage

7. **City-pair specific calculations**
   - Multiple city-pair calculation types
   - 0% coverage

8. **Airline-specific calculations**
   - American Airlines (3 types)
   - 0% coverage

### Data Validation Required

**CRITICAL:** We need to query production database to find which calculation types are actually used:

```sql
SELECT
    ncalc_id,
    COUNT(*) as usage_count,
    COUNT(DISTINCT nhandling_key) as distinct_handlings
FROM cen_handling_detail
GROUP BY ncalc_id
ORDER BY usage_count DESC;
```

This will tell us:
- Which calc types are critical (high usage)
- Which can be deprioritized (low/no usage)
- How many unique handlings use each type

---

## PowerBuilder Functions Called by Calculation Types

### Functions Called in uf_calculate()

From the switch statement, these PowerBuilder functions are called:

1. **`uf_calc_ratiolist()`** - Called by types 3, 24, 26
2. **`uf_calc_percent()`** - Called by types 5, 14, 20
3. **`uf_calc_percent_com()`** - Called by type 6
4. **`uf_calc_multiple()`** - Called by types 7, 31, 68
5. **`uf_calc_integer()`** - Called by type 8
6. **`uf_calc_bosta_plus()`** - Called by types 9, 10
7. **`uf_calc_bosta_minus()`** - Called by types 11, 12
8. **`uf_calc_percent_multiple()`** - Called by type 13
9. **`uf_calc_booking_classes()`** - Called by types 15, 16, 17
10. **`uf_calc_ratiolist2()`** - Called by types 18, 25, 27
11. **`uf_calc_difference_fullhouse()`** - Called by type 19
12. **`uf_calc_multiple_m()`** - Called by type 21
13. **`uf_calc_percent_zero()`** - Called by type 23
14. **`uf_get_booking_classes()`** - Called by types 24, 25
15. **`uf_get_booking_class_1_2()`** - Called by types 26, 27
16. **`uf_get_spml_count()`** - Called by type 28, many others
17. **`uf_calc_multi_class_sum()`** - Called by types 29-34, 45
18. **`uf_calc_classes()`** - Called by types 35+
19. **`uf_calc_classes_percentage()`**
20. **`uf_calc_classes_multiple()`**
21. **`uf_calc_bob_percent()`**
22. **`uf_calc_bob_percent_round_down()`**
23. **`uf_calc_bob_percent_com()`**
24. **`uf_calc_bob_fixed()`**
25. **`uf_calc_bob_multiple()`**
26. **Many more...**

**ALL of these functions need to be implemented in Java!**

---

## Recommended Action Plan

### IMMEDIATE (Next 24 Hours) ⚠️ CRITICAL

1. **Query Production Database for Calc Type Usage**
   ```sql
   -- Find which calc types are actually used
   SELECT ncalc_id, COUNT(*) as count
   FROM cen_handling_detail
   GROUP BY ncalc_id
   ORDER BY count DESC;
   ```

2. **Prioritize by Usage**
   - Identify top 10 most-used calc types
   - Document expected behavior for each
   - Create test cases with real data

3. **DO NOT DEPLOY TO PRODUCTION**
   - Current implementation will fail for 96% of calculation scenarios
   - Would cause massive data corruption and incorrect meal quantities

### SHORT TERM (Next 1 Week)

4. **Implement Top 10 Calc Types**
   - Start with most-used types from database query
   - Create one Java method per type
   - Write comprehensive unit tests for each

5. **Create Calc Type Service**
   ```java
   @Service
   public class MealCalculationTypeService {
       public int calculateType1(CalcContext ctx) { ... }
       public int calculateType2(CalcContext ctx) { ... }
       public int calculateType3(CalcContext ctx) { ... }
       ...
   }
   ```

6. **Refactor HandlingCalculationService**
   - Delegate to MealCalculationTypeService
   - Map PowerBuilder CalcID to Java methods

### MEDIUM TERM (Next 2-4 Weeks)

7. **Implement All Active Calc Types**
   - Based on database query results
   - Implement all calc types found in production
   - Skip unused/reserved types (46-60, etc.)

8. **Integration Testing**
   - Run parallel: PowerBuilder vs Java
   - Compare outputs for 1000+ real flights
   - Verify exact matches for all calc types

9. **Performance Optimization**
   - Profile calculation performance
   - Optimize slow calc types
   - Ensure < 2 seconds per flight

---

## Success Criteria

### Phase 1: Critical Types (Week 1)
- [ ] Database query completed
- [ ] Top 10 calc types identified
- [ ] Top 10 calc types implemented
- [ ] Unit tests pass for top 10
- [ ] Integration tests pass for top 10

### Phase 2: All Active Types (Weeks 2-4)
- [ ] All production calc types implemented
- [ ] All unit tests pass (100%)
- [ ] Integration tests pass (matches PowerBuilder)
- [ ] Performance acceptable (< 2s per flight)

### Phase 3: Production Ready (Week 5+)
- [ ] Code review complete
- [ ] Documentation complete
- [ ] Operations team trained
- [ ] Parallel run successful (1 month)
- [ ] Cutover plan approved

---

## Risk Assessment

### ⚠️ CRITICAL RISK - BLOCKS PRODUCTION

**Current State:** Java implementation cannot handle 96% of PowerBuilder calculation scenarios.

**Risk:** Deploying current code would cause:
- Incorrect meal quantities for most flights
- Missing items for crew, BOB, special services
- Wrong quantities for premium cabins
- Data corruption in output tables
- Potential flight disruptions

**Mitigation:**
1. DO NOT deploy until calc types implemented
2. Query database to find critical types
3. Prioritize and implement systematically
4. Validate with parallel runs

---

## Conclusion

**The Java migration is fundamentally incomplete.**

While the component-level architecture has been fixed (critical issue #2), and reserve/topoff logic has been fixed (critical issue #1), the underlying calculation type system is **96% missing**.

This is not a minor gap—this is a fundamental architectural issue that makes the current Java implementation unusable for production.

**Estimated Additional Work:**
- **Immediate (Top 10 types):** 40-60 hours
- **Complete (All active types):** 120-200 hours
- **Testing & Validation:** 80-120 hours

**Total:** 240-380 additional hours (6-10 weeks at full capacity)

---

**Document Version:** 1.0
**Date:** 2025-11-17
**Author:** Claude (AI Assistant) - Migration Verification
**Status:** ⚠️ **PRODUCTION BLOCKED** ⚠️
