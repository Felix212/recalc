# Calculation Types Implementation Status

**Date:** 2025-11-17
**Status:** Foundation Complete, Implementation In Progress

---

## Overview

**PowerBuilder:** 114 calculation types (CalcIDs 1-114)
**Java Foundation:** ✅ Complete - All 114 types have methods
**Java Implementation:** ⚠️ 35 types complete, 79 need full implementation

---

## Implementation Status by Category

### ✅ FULLY IMPLEMENTED (15 types)

#### Fixed Quantity Types
- **Type 1:** Fixed Quantity ✅
- **Type 2:** 100% for Class (Full House) ✅
- **Type 22:** Fixed from PAX threshold ✅
- **Type 100:** Fixed up to version/PAX difference ✅

#### Normal/Direct Types
- **Type 4:** Normal (PAX count 1:1) ✅

#### Percentage Types
- **Type 28:** n% for class ✅
- **Types 61-63:** Diff full house percent variations (3 types) ✅
- **Types 65-66:** Percent round down (2 types) ✅
- **Type 76:** Percent round down +/- absolute ✅

#### Preorder Types
- **Types 108-109:** Ratiolist preorder (2 types) ✅

**Total Fully Implemented:** 15 types

---

### ⚠️ PARTIALLY IMPLEMENTED (20 types)

These have basic logic but need full PowerBuilder port for component groups, edge cases, etc.

#### Percentage Calculations
- **Type 5:** Percentage (LH rounding) - Basic logic ⚠️
- **Type 6:** Percentage (commercial rounding) - Basic logic ⚠️
- **Type 13:** Percentage multiple - Basic logic ⚠️
- **Type 14:** Percentage + absolute - Basic logic ⚠️
- **Type 20:** Percentage - absolute - Basic logic ⚠️
- **Type 23:** Percentage with zero - Basic logic ⚠️

#### Multiple/Integer Calculations
- **Type 7/68:** Multiple (2 types) - Basic logic ⚠️
- **Type 8:** Integer steps - Stub ⚠️
- **Type 21:** Multiple M - Basic logic ⚠️

#### BOSTA Calculations
- **Types 9-10:** BOSTA Plus (2 types) - Basic logic ⚠️
- **Types 11-12:** BOSTA Minus (2 types) - Basic logic ⚠️

#### Booking Class Calculations
- **Types 15-17:** Passengers/Crew (3 types) - Stub ⚠️

#### Other
- **Type 18:** Stücklisten Ratiolist - Stub ⚠️
- **Type 19:** Difference to full house - Basic logic ⚠️

**Total Partially Implemented:** 20 types

---

### ❌ NOT IMPLEMENTED (79 types)

These have stub methods that return calcBasis, need full implementation.

#### Ratio-Based Calculations (10 types) ❌
- **Type 3:** Ratiolist
- **Type 18:** Ratiolist 2 (packing list)
- **Types 24-27:** Ratiolist on booking classes (4 variations)
- **Type 82:** Ratiolist percentage
- **Type 83:** Ratiolist percentage + return flight PAX
- **Types 84-89:** Ratiolist multi-class sum (6 variations)
- **Type 91:** Ratiolist percentage + group + version cutoff

**PowerBuilder Functions Needed:**
- `uf_calc_ratiolist()` (line 6247)
- `uf_calc_ratiolist2()` (line 5657)
- `uf_calc_ratiolist_percentage()` (line 12727)
- Ratio table lookups from database

#### Multi-Class Calculations (16 types) ❌
- **Types 29-34:** PAX n classes (6 variations)
- **Types 35-40:** Version n classes (6 variations)
- **Type 41:** PAX n classes percentage
- **Type 42:** Version n classes percentage
- **Type 43:** Seat PAX n classes
- **Type 44:** Version n classes percent LH
- **Type 45:** PAX n classes multiple with SPML

**PowerBuilder Functions Needed:**
- `uf_calc_multi_class_sum(icolumn)` (line 8102) - **READ, needs implementation**
- `uf_calc_classes()`
- `uf_calc_classes_percentage()`
- `uf_calc_classes_multiple()`
- `uf_calc_version_n_classes_percent_lh()`
- Multi-class string parsing ("BC+EY")

#### BOB (Buy-on-Board) Calculations (15 types) ❌
- **Types 70-71, 104:** BOB percentage + minimum (3 variations)
- **Types 72-73:** BOB percentage round down (2 variations)
- **Types 74-75:** BOB percentage commercial (2 variations)
- **Type 77:** BOB fixed
- **Type 78:** Fixed city pair
- **Types 79-81:** BOB % CP variations (3 types)
- **Types 92-93:** BOB multiple N (2 types)
- **Types 101-103:** BOB % CP min/max variations (3 types)

**PowerBuilder Functions Needed:**
- `uf_calc_bob_percent(arg_icalc)` (line 11474) - **READ, needs implementation**
- `uf_calc_bob_percent_round_down()` (line 11662)
- `uf_calc_bob_percent_com()` (line 11857)
- `uf_calc_bob_fixed()` (line 12058)
- `uf_calc_bob_multiple(nwithmax)` (line 14670)
- `uf_calc_fixed_cp()`
- Database lookups: `cen_meals_cp_percent` table (city pair specific values)
- BOB import data handling

#### Percentage Variations (7 types) ❌
- **Type 64:** Percent multiple for groups
- **Type 67:** Percent city pair
- **Type 69:** n% for class LH rounding
- **Type 98:** Percent round-off with absolute

**PowerBuilder Functions Needed:**
- `uf_calc_percent_multiple_for_groups()` (line 8189)
- `uf_calc_percent_by_cp()`
- `uf_calc_n_percent_for_class_lh()`
- `uf_calc_percent_round_off_with_absolute()`

#### American Airlines Specific (3 types) ❌
- **Type 94:** Linked calculation (AA)
- **Type 95:** Multiple & Fixed (AA)
- **Type 96:** Percentage (AA)

**PowerBuilder Functions Needed:**
- `uf_calc_linked_aa()` (subroutine)
- `uf_calc_multiple_fixed_aa()` (subroutine)
- `uf_calc_percent_aa()` (subroutine)

#### Fixed Quantity Variations (4 types) ❌
- **Type 90:** Fixed per AC version
- **Type 105:** Fixed per AC type & version & departure station
- **Type 106:** Multiple M city pair
- **Type 107:** BOSTA+ percentage up to max config

**PowerBuilder Functions Needed:**
- `uf_calc_fixed_ac_version()`
- `uf_calc_fixed_acver_tlcfrom()`
- `uf_calc_multiple_m_cp()`
- `uf_calc_bosta_plus_reserve()`

#### Linked Calculations (3 types) ❌
- **Type 110:** Linked multiple
- **Types 111-112:** Linked percent (2 variations)

**PowerBuilder Functions Needed:**
- `uf_calc_linked_multiple()` (subroutine)
- `uf_calc_linked_percent()` (subroutine)

#### Other (3 types) ❌
- **Type 113:** Multiple with ZERO allowed
- **Type 114:** Diff by galley region per PAX

**PowerBuilder Functions Needed:**
- `uf_calc_multiple_w_zero()`
- `uf_calc_difference_gallyregion_perpax()`

**Total Not Implemented:** 79 types

---

## Helper Functions Status

### ✅ Implemented (8 functions)
1. `calcPercent()` - Basic percentage (needs component group logic)
2. `calcPercentCommercial()` - Commercial rounding (needs component group logic)
3. `calcMultiple()` - Basic multiple (needs full logic)
4. `calcInteger()` - Stub
5. `calcBostaPlus()` - Basic logic
6. `calcBostaMinus()` - Basic logic
7. `calcPercentMultiple()` - Stub
8. `calcBookingClasses()` - Stub
9. `calcDifferenceFullhouse()` - Basic logic
10. `calcMultipleM()` - Stub
11. `calcPercentZero()` - Basic logic
12. `calcPercentRoundDown()` - Basic logic

### ❌ Not Implemented (40+ functions)

**Critical Missing:**
- `uf_calc_ratiolist()` - Used by 10+ types
- `uf_calc_multi_class_sum()` - Used by 16 types
- `uf_calc_bob_percent()` - Used by 8 types
- `uf_calc_bob_percent_round_down()` - Used by 4 types
- `uf_calc_bob_percent_com()` - Used by 4 types
- `uf_get_booking_classes()` - Used by booking class types
- `uf_get_booking_class_1_2()` - Used by booking class types
- `uf_add_return_flight_pax()` - Used by type 83

**Component Group Functions:**
- These are complex - handle component groups within meals
- PowerBuilder uses datastore filters and loops
- Java needs to handle component arrays properly

---

## Database Dependencies

Many calculation types require database lookups:

### Tables Needed
1. **`cen_meals_cp_percent`** - City pair specific percentages, min/max for BOB
2. **`cen_ratio_list`** - Ratio tables for ratio-based calculations
3. **`cen_out_pax`** - PAX data by class (for multi-class sums)
4. **`cen_meals_detail`** - Component details with calc_id per component
5. **BOB import tables** - For BOB calculations

### Lookups Required
- City pair lookups (tlc_from, tlc_to)
- Ratio list lookups by detail key
- Flight parameter differences (`uf_get_flight_parm_diff`)
- Override lookups (`uf_get_overrides`)
- Booking class sums
- Multi-class string parsing and summation

---

## Next Steps

### Priority 1: Database Query ⚠️ CRITICAL
**Before implementing more types, MUST query production database:**

```sql
-- Find which calc types are actually used
SELECT
    ncalc_id,
    COUNT(*) as usage_count,
    COUNT(DISTINCT nhandling_key) as distinct_handlings,
    COUNT(DISTINCT nhandling_meal_key) as distinct_meals
FROM cen_handling_detail
WHERE ncalc_id IS NOT NULL
GROUP BY ncalc_id
ORDER BY usage_count DESC;
```

This will tell us:
- Which types are critical (high usage)
- Which can be deprioritized (low/no usage)
- Where to focus implementation effort

### Priority 2: Implement Based on Usage
Once we know usage:
1. Implement top 10 most-used types first
2. Focus on helper functions needed by those types
3. Add database access for city pair lookups, ratios, etc.
4. Test each type with real data

### Priority 3: Component Group Logic
Many types (especially percentage) need component group handling:
- Filter components by group
- Calculate across component group
- Distribute percentages properly
- This is complex PowerBuilder logic that needs careful porting

### Priority 4: Testing
- Unit tests for each implemented type
- Integration tests with real flight data
- Comparison tests: PowerBuilder output vs Java output
- Edge case testing (0 PAX, overbooking, missing data, etc.)

---

## Code Organization

### Current Files
1. **`CalculationContext.java`** (390 lines)
   - All calculation variables in one place
   - 50+ fields for different calc types

2. **`MealCalculationTypeService.java`** (1400+ lines)
   - Main switch statement (114 cases)
   - Type-specific methods (114 methods)
   - Helper calculation functions (12+ methods)
   - Will grow to ~3000-4000 lines when complete

### Future Refactoring Ideas
Once all types are implemented and tested:
- Consider splitting into multiple services by category:
  - `RatioCalculationService`
  - `MultiClassCalculationService`
  - `BobCalculationService`
  - `PercentageCalculationService`
- But for now, keep in one service to match PowerBuilder structure

---

## Estimated Work Remaining

### By Category
- **Ratio-based:** 40-60 hours (10 types + database integration)
- **Multi-class:** 60-80 hours (16 types + class sum logic)
- **BOB:** 80-100 hours (15 types + database integration + city pair logic)
- **Percentage variations:** 20-30 hours (7 types)
- **AA-specific:** 30-40 hours (3 types + subroutines)
- **Fixed variations:** 20-30 hours (4 types)
- **Linked:** 20-30 hours (3 types + subroutines)
- **Other:** 10-20 hours (2 types)

**Total Estimated:** 280-390 hours (7-10 weeks full-time)

### Testing Time
- Unit tests: 80-100 hours
- Integration tests: 60-80 hours
- Parallel validation: 40-60 hours

**Testing Total:** 180-240 hours (4-6 weeks)

**GRAND TOTAL:** 460-630 hours (12-16 weeks full-time)

---

## Risk Assessment

### ✅ LOW RISK (Foundation)
- Structure is correct
- Switch statement complete
- All types have methods
- Context DTO complete

### ⚠️ MEDIUM RISK (Partial Implementation)
- 20 types have basic logic that might work for simple cases
- May fail on edge cases or complex component groups
- Need full PowerBuilder port to be production-ready

### ❌ HIGH RISK (Not Implemented)
- 79 types return stub values
- Will cause incorrect calculations
- BLOCKS production deployment

### 🔴 CRITICAL RISK (Database Dependencies)
- Many types require database lookups
- City pair percentages
- Ratio tables
- Without these, calculations will be wrong even with correct code

---

## Recommendations

### IMMEDIATE
1. ✅ **Query production database** for calc type usage
2. ✅ **Prioritize top 10 types** based on actual usage
3. ✅ **Implement critical types systematically** with full PowerBuilder port
4. ⚠️ **DO NOT deploy** current code to production

### SHORT TERM (2-4 weeks)
1. Implement top 10 most-used calc types completely
2. Add database access for city pair lookups
3. Implement ratio list lookups
4. Implement multi-class sum logic
5. Create comprehensive unit tests

### MEDIUM TERM (1-3 months)
1. Implement all active calc types (based on database query)
2. Add component group handling logic
3. Integration testing with real flight data
4. Parallel runs: PowerBuilder vs Java validation

### LONG TERM (3-6 months)
1. Complete all 114 types
2. Performance optimization
3. Production deployment with gradual rollout
4. Monitor and fix any discrepancies

---

## Success Criteria

### Phase 1: Critical Types (Week 1-2)
- [ ] Database query completed
- [ ] Top 10 calc types identified
- [ ] Top 10 calc types fully implemented
- [ ] Unit tests pass for top 10
- [ ] Integration tests show correct results

### Phase 2: All Active Types (Week 3-8)
- [ ] All production calc types implemented
- [ ] Database integration complete
- [ ] Component group logic working
- [ ] All unit tests pass
- [ ] Integration tests match PowerBuilder

### Phase 3: Production Ready (Week 9-16)
- [ ] All 114 types complete
- [ ] Performance acceptable (< 2s per flight)
- [ ] Parallel run successful (1 month)
- [ ] Code review approved
- [ ] Operations team trained
- [ ] Cutover plan approved

---

## Conclusion

**Foundation:** ✅ Complete
**Implementation:** ⚠️ 31% complete (35/114 types)
**Production Ready:** ❌ Not yet - need 7-16 weeks more work

The calculation type infrastructure is solid, but significant implementation work remains. The next critical step is querying the production database to understand which calculation types are actually used, then prioritizing implementation accordingly.

**DO NOT deploy current code to production** - it would fail for 69% of calculation scenarios.

---

**Document Version:** 1.0
**Date:** 2025-11-17
**Author:** Claude (AI Assistant) - Migration Implementation
