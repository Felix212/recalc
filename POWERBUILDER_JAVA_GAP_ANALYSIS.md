# PowerBuilder to Java Migration - Comprehensive Gap Analysis

**Date:** 2025-11-17
**PowerBuilder Source:** `uo_meal_calculation.sru` (18,838 lines, 220 functions)
**Java Implementation:** 13 Service classes

---

## Executive Summary

**CRITICAL FINDING:** Only ~15% of PowerBuilder functions have been verified/migrated

- **PowerBuilder Functions:** 220 total
- **Verified Functions:** ~10 (4.5%)
- **Migrated Functions:** ~30-40 (13-18% estimated)
- **Gap:** ~180-190 functions (82-86% NOT VERIFIED)

---

## PowerBuilder Function Inventory

### Core Calculation Functions (Priority 1 - CRITICAL)

#### ✅ VERIFIED & FIXED
1. **Lines 7212-7348**: Reserve/TopOff calculation - `applyReserves()`, `applyTopOffs()`
2. **Lines 3080-3098**: SPML deduction during calculation - `calculateComponentQuantity()`
3. **Lines 4700-5070**: Component processing - `calculateMealQuantitiesWithComponents()`
4. **Lines 15557-15602**: `uf_get_spml_count()` - `SpmlCountCalculator.calculateSpmlCount()`
5. **Lines 4019-4164**: `uf_compile_spml()` - `SpmlDistributionService.distributeSpecialMeals()`

#### ⚠️ PARTIALLY IMPLEMENTED (Need Verification)
6. `uf_calculate()` (line 642) - Core calculation orchestration
   - **Java:** `MealCalculationService.calculate()`
   - **Status:** EXISTS but needs line-by-line verification

7. `uf_compile()` (line 622) - Meal compilation
   - **Java:** `MealQuantityCalculationService` (partially)
   - **Status:** Basic implementation, needs verification

8. `uf_insert_cen_out_meals()` (line 620) - Output record creation
   - **Java:** `MealPersistenceService.saveMealCalculationResults()`
   - **Status:** EXISTS but needs verification

9. `uf_set_meal_properties()` (line 618) - Meal property setting
   - **Java:** Part of `calculateComponentQuantity()`
   - **Status:** Partially implemented

10. `uf_set_spml_properties()` (line 633) - SPML property setting
    - **Java:** Part of `SpmlDistributionService`
    - **Status:** Partially implemented

#### ❌ NOT VERIFIED / MISSING
11. `uf_get_calc_basis()` (line 632) - Calculation basis determination
    - **Status:** UNKNOWN if implemented

12. `uf_calculate4paula()` (line 649) - Paula-specific calculation
    - **Status:** MISSING

13. `uf_get_detail_key()` (line 588) - Detail key generation
    - **Java:** Using `AtomicLong` in services
    - **Status:** Different approach, needs verification

### Percentage Calculation Functions (Priority 2)

#### ❌ NOT VERIFIED
14. `uf_calc_percent()` (line 673) - Base percentage calculation
15. `uf_calc_percent_com()` (line 643) - Commercial percentage
16. `uf_calc_percent_abs()` (line 592) - Absolute percentage
17. `uf_calc_percent_abs_minus()` (line 626) - Absolute minus percentage
18. `uf_calc_percent_zero()` (line 628) - Zero percentage
19. `uf_calc_percent_multiple()` (line 587, 700) - Multiple percentage
20. `uf_calc_percent_multiple_for_groups()` (line 640) - Group percentage
21. `uf_calc_percent_by_cp()` (line 650) - City pair percentage
22. `uf_calc_percent_round_down()` (line 648) - Round down percentage
23. `uf_calc_percent_round_off_with_absolute()` (line 676) - Round off with absolute
24. `uf_calc_percent_version_cutoff()` (line 669) - Version cutoff percentage
25. `uf_calc_n_percent_for_class_lh()` (line 645) - LH class percentage
26. `uf_calc_version_n_classes_percent_lh()` (line 647) - LH multi-class percentage
27. `uf_calc_bob_percent()` (line 651) - BOB percentage
28. `uf_calc_bob_percent_round_down()` (line 652) - BOB round down
29. `uf_calc_bob_percent_com()` (line 653) - BOB commercial percentage
30. `uf_calc_percent_aa()` (line 671) - AA percentage (subroutine)
31. `uf_calc_percent_com_no_null()` (line 646) - Commercial no null

**Status:** HandlingCalculationService has 4 calculation types (0-3), but PowerBuilder has 17+ percentage calculation methods!

### Multiple/Fixed Calculation Functions (Priority 2)

#### ❌ NOT VERIFIED
32. `uf_calc_multiple()` (line 607) - Multiple calculation
33. `uf_calc_multiple_m()` (line 627) - Multiple M
34. `uf_calc_multiple_w_zero()` (line 690) - Multiple with zero
35. `uf_calc_multiple_m_cp()` (line 682) - Multiple M city pair
36. `uf_calc_fixed_cp()` (line 655) - Fixed city pair
37. `uf_calc_fixed_ac_version()` (line 666) - Fixed aircraft version
38. `uf_calc_fixed_acver_tlcfrom()` (line 680) - Fixed AC version TLC from
39. `uf_calc_integer()` (line 621) - Integer calculation
40. `uf_calc_bob_fixed()` (line 654) - BOB fixed
41. `uf_calc_bob_multiple()` (line 675) - BOB multiple
42. `uf_calc_linked_aa()` (line 672) - Linked AA
43. `uf_calc_multiple_fixed_aa()` (line 674) - Multiple fixed AA
44. `uf_calc_linked_multiple()` (line 688) - Linked multiple
45. `uf_calc_linked_percent()` (line 689) - Linked percent

**Status:** HandlingCalculationService may have some of this, but needs verification

### Ratio-Based Calculation Functions (Priority 2)

#### ❌ NOT VERIFIED
46. `uf_calc_ratiolist()` (line 625) - Ratio list calculation
47. `uf_calc_ratiolist2()` (line 623) - Ratio list 2
48. `uf_calc_ratiolist_percentage()` (line 662) - Ratio list percentage
49. `uf_get_value_from_ratio()` (line 657) - Value from ratio
50. `uf_get_percentage_from_ratio()` (line 670) - Percentage from ratio
51. `uf_replace_ratiolist3()` (line 635) - Replace ratio list

**Status:** LIKELY MISSING - no ratio-based calculation in Java services

### Class-Based Calculation Functions (Priority 2)

#### ❌ NOT VERIFIED
52. `uf_calc_classes()` (line 637) - Calculate classes
53. `uf_calc_classes_percentage()` (line 638) - Calculate classes percentage
54. `uf_calc_classes_multiple()` (line 694) - Calculate classes multiple (private)
55. `uf_calc_booking_classes()` (line 603) - Booking classes
56. `uf_calc_multi_class_sum()` (line 639) - Multi-class sum
57. `uf_calc_multiclass_sum_ratiolist()` (line 664) - Multi-class sum ratio list
58. `uf_calc_multiclass_sum_ratiolist_spml()` (line 665) - Multi-class sum ratio SPML
59. `uf_get_booking_classes()` (line 630) - Get booking classes
60. `uf_get_booking_class_1_2()` (line 631) - Get booking class 1-2
61. `uf_add_number_for_classes()` (line 658) - Add number for classes
62. `uf_get_max_classes()` (line 659) - Get max classes
63. `uf_ask4number_per_class()` (line 660) - Ask for number per class

**Status:** LIKELY PARTIAL - Java has class handling but not all variations

### PAX Calculation Functions (Priority 1)

#### ❌ NOT VERIFIED
64. `uf_ask4passenger()` (line 624) - Ask for passenger count
65. `uf_ask4passenger_old()` (line 629) - Old passenger count
66. `uf_ask4passenger_flightcalc()` (line 685) - Flight calc passenger
67. `uf_get_pax_manual()` (line 608) - Manual PAX
68. `uf_calc_paxconcdiff()` (line 644) - PAX concession difference
69. `uf_calc_pax_via_forecast_ratio()` (line 663) - PAX via forecast ratio
70. `uf_calc_pax_via_forecast_ratio_mass()` (line 678) - PAX forecast ratio mass
71. `uf_add_return_flight_pax()` (line 661) - Add return flight PAX

**Status:** CRITICAL - PAX calculation is fundamental, needs verification

### BOSTA (BOard STAtus) Functions (Priority 2)

#### ❌ NOT VERIFIED
72. `uf_calc_bosta_minus()` (line 604) - BOSTA minus
73. `uf_calc_bosta_plus()` (line 605) - BOSTA plus
74. `uf_calc_bosta_plus_reserve()` (line 683) - BOSTA plus reserve

**Status:** MISSING - No BOSTA logic in Java

### Difference Calculation Functions (Priority 2)

#### ❌ NOT VERIFIED
75. `uf_calc_difference_fullhouse()` (line 606) - Difference full house
76. `uf_calc_difference_gallyregion_perpax()` (line 692) - Difference galley region per PAX

**Status:** MISSING

### Overload Management Functions (Priority 2)

#### ❌ NOT VERIFIED
77. `uf_check_overload()` (line 593) - Check overload
78. `uf_reduce_overload()` (line 594) - Reduce overload
79. `uf_manual_rescue()` (line 595) - Manual rescue

**Status:** MISSING - No overload management in Java

### Comparison Functions (Priority 3)

#### ❌ NOT VERIFIED
80. `uf_compare_new_old()` (line 596) - Compare new vs old
81. `uf_compare_new_current()` (line 597) - Compare new vs current

**Status:** MISSING

### Start/Initialization Functions (Priority 1)

#### ⚠️ PARTIALLY IMPLEMENTED
82. `uf_start_from_scratch()` (line 612) - Start from scratch
    - **Java:** `MealCalculationService.calculateFromScratch()`
    - **Status:** EXISTS but needs verification

83. `uf_start_change()` (line 610) - Start change
    - **Java:** `FlightCalculationService` orchestration
    - **Status:** EXISTS but needs verification

84. `uf_start_change_on_cen_out()` (line 611) - Start change on output
    - **Java:** Change applier services
    - **Status:** PARTIAL implementation

85. `uf_start_simulation()` (line 616) - Start simulation
86. `uf_start_mco_simulation()` (line 636) - MCO simulation
87. `uf_new_flight()` (line 684) - New flight
88. `uf_start_change_on_cen_out_650()` (line 697) - Change 650

**Status:** Core orchestration exists but specific modes need verification

### Lookup/Getter Functions (Priority 2)

#### ❌ NOT VERIFIED
89. `uf_get_packinglist()` (line 598) - Get packing list
90. `uf_get_packinglist_unit()` (line 615) - Get packing list unit
91. `uf_get_handling_text()` (line 600) - Get handling text
92. `uf_get_account_code()` (line 602) - Get account code
93. `uf_get_rotation()` (line 613) - Get rotation
94. `uf_get_pl_type_key()` (line 619) - Get PL type key
95. `uf_get_foreign_object()` (line 634) - Get foreign object
96. `uf_get_customer_id()` (line 668) - Get customer ID (protected)
97. `uf_get_flight_parm_diff()` (line 679) - Get flight parameter difference
98. `uf_get_overrides()` (line 691) - Get overrides
99. `uf_get_preorder_spmls()` (line 687) - Get preorder SPMLs
100. `uf_get_calc_basis_650()` (line 695) - Get calc basis 650

**Status:** LIKELY MISSING - No equivalent lookup methods in Java services

### Item List Explosion Functions (Priority 3)

#### ❌ NOT VERIFIED
101. `uf_item_list_explosion()` (line 591) - Item list explosion
102. `uf_item_list_explosion_old()` (line 589) - Old item list explosion

**Status:** UNKNOWN

### Filter/Switch Functions (Priority 3)

#### ❌ NOT VERIFIED
103. `uf_filter_actype()` (line 601) - Filter aircraft type
104. `uf_switch_datasource()` (line 590) - Switch datasource
105. `uf_change_flightdataobject()` (line 656) - Change flight data object

**Status:** UNKNOWN

### Persistence Functions (Priority 1)

#### ⚠️ PARTIALLY IMPLEMENTED
106. `uf_write_cen_out_meals()` (line 599) - Write output meals
     - **Java:** `MealPersistenceService.saveMealCalculationResults()`
     - **Status:** EXISTS but needs verification

107. `uf_insert_cen_out_spml_detail()` (line 617) - Insert SPML detail
     - **Java:** Part of persistence service
     - **Status:** PARTIAL

#### ❌ NOT VERIFIED
108. `uf_retrieve_accounts()` (line 609) - Retrieve accounts
109. `uf_retrieve_local_subst()` (line 677) - Retrieve local substitution

**Status:** PARTIAL - basic persistence exists

### Override Functions (Priority 2)

#### ❌ NOT VERIFIED
110. `uf_overrite_reserve_topoff()` (line 693) - Override reserve/topoff
111. `uf_replace_pl_for_aircraft()` (line 681) - Replace PL for aircraft

**Status:** MISSING

### Helper/Utility Functions (Priority 3)

#### ❌ NOT VERIFIED
112. `uf_percent_multiple()` (line 641) - Percent multiple helper
113. `uf_cen_profilestring()` (line 667) - Profile string
114. `uf_calculate_650()` (line 696) - Calculate 650

**Status:** UNKNOWN

---

## Java Service Coverage Analysis

### MealCalculationService.java (Main Orchestrator)
- **PowerBuilder Equivalent:** `uf_calculate()`, `uf_start_from_scratch()`
- **Coverage:** ~10-15% of orchestration logic
- **Verified:** Basic flow only
- **Missing:** Multiple calculation modes, simulation modes, override handling

### MealQuantityCalculationService.java
- **PowerBuilder Equivalent:** `uf_compile()`, reserve/topoff, component processing
- **Coverage:** ~20% of calculation logic
- **Verified:** Reserve/topoff (FIXED), component processing (FIXED)
- **Missing:** 17+ percentage calculation types, ratio-based calculations, class-based variations

### HandlingCalculationService.java
- **PowerBuilder Equivalent:** Multiple `uf_calc_*` functions
- **Coverage:** ~5-10% of handling logic
- **Verified:** NONE
- **Missing:** Most specialized calculation types

### SpmlDistributionService.java
- **PowerBuilder Equivalent:** `uf_compile_spml()`, `uf_set_spml_properties()`
- **Coverage:** ~30% of SPML logic
- **Verified:** Basic compilation (lines 4019-4164)
- **Missing:** SPML topoff, preorder SPMLs, detailed property setting

### MealDefinitionLookupService.java
- **PowerBuilder Equivalent:** Multiple lookup functions
- **Coverage:** ~10% of lookup logic
- **Verified:** Basic meal lookup with components
- **Missing:** Packing list lookups, account codes, handling text, rotation, etc.

### MealLayoutGenerationService.java
- **PowerBuilder Equivalent:** Unknown (may be separate in PowerBuilder)
- **Coverage:** UNKNOWN
- **Verified:** NONE

### MealPersistenceService.java
- **PowerBuilder Equivalent:** `uf_write_cen_out_meals()`, `uf_insert_*` functions
- **Coverage:** ~30% of persistence logic
- **Verified:** NONE
- **Missing:** Detailed property setting, SPML detail insertion

### Change Applier Services (3 services)
- **PowerBuilder Equivalent:** `uf_start_change()`, `uf_start_change_on_cen_out()`
- **Coverage:** ~20% of change logic
- **Verified:** NONE

### FlightLockingService.java
- **PowerBuilder Equivalent:** Unknown
- **Coverage:** UNKNOWN

### FunctionConfigurationService.java
- **PowerBuilder Equivalent:** Unknown
- **Coverage:** UNKNOWN

---

## Critical Gaps Identified

### 1. **Calculation Type Diversity** ⚠️ CRITICAL
**PowerBuilder has 40+ specialized calculation methods**
**Java has ~4 basic calculation types**

**Missing:**
- Ratio-based calculations (6 functions)
- Class-specific calculations (13 functions)
- BOB (Board) calculations (5 functions)
- BOSTA calculations (3 functions)
- Percentage variations (17 functions)
- Multiple/Fixed variations (14 functions)

### 2. **PAX Calculation** ⚠️ CRITICAL
**PowerBuilder has 7+ PAX-related functions**
**Java verification: NONE**

**Impact:** If PAX calculation is wrong, ALL meal calculations are wrong

### 3. **Overload Management** ⚠️ HIGH
**PowerBuilder has overload checking and reduction**
**Java: MISSING**

**Impact:** Cannot handle aircraft capacity constraints properly

### 4. **Lookup Functions** ⚠️ MEDIUM
**PowerBuilder has 12+ lookup functions**
**Java: Minimal implementation**

**Impact:** Missing data references, cannot retrieve auxiliary data

### 5. **Override/Customization** ⚠️ MEDIUM
**PowerBuilder has override and customization functions**
**Java: MISSING**

**Impact:** Cannot handle special cases or manual adjustments

### 6. **Simulation Modes** ⚠️ MEDIUM
**PowerBuilder has simulation and MCO modes**
**Java: MISSING**

**Impact:** Cannot run what-if scenarios

---

## Recommended Action Plan

### IMMEDIATE (Next 2-3 Days)

1. **Verify PAX Calculation** ⚠️ CRITICAL
   - Locate PowerBuilder PAX calculation logic
   - Verify Java implementation
   - Test with real flight data

2. **Map Calculation Types** ⚠️ CRITICAL
   - Create complete mapping of PowerBuilder calculation types
   - Identify which are used in production
   - Verify Java coverage

3. **Verify Core Orchestration** ⚠️ CRITICAL
   - Line-by-line verification of `uf_calculate()`
   - Compare with `MealCalculationService.calculate()`
   - Identify missing logic

### SHORT TERM (Next 1-2 Weeks)

4. **Verify Handling Calculation**
   - Map HandlingCalculationService to PowerBuilder functions
   - Verify calculation type coverage
   - Add missing types

5. **Verify Persistence**
   - Verify `uf_write_cen_out_meals()` implementation
   - Check field mapping completeness
   - Verify SPML detail insertion

6. **Add Overload Management**
   - Implement `uf_check_overload()`
   - Implement `uf_reduce_overload()`
   - Test capacity constraints

### MEDIUM TERM (Next 3-4 Weeks)

7. **Implement Missing Calculation Types**
   - Ratio-based calculations
   - Class-specific variations
   - BOB/BOSTA calculations

8. **Implement Missing Lookups**
   - Packing list lookups
   - Account code lookups
   - Override lookups

9. **Add Override/Customization Support**
   - Manual adjustments
   - Override handling
   - Special cases

---

## Risk Assessment

### ✅ LOW RISK (Verified & Fixed)
- Component-level processing
- Reserve/TopOff calculation
- SPML deduction timing
- SPML count calculation

### ⚠️ HIGH RISK (Exists But Not Verified)
- PAX calculation - **If wrong, ALL calculations wrong**
- Core orchestration - **If wrong, process flow broken**
- Persistence - **If wrong, data loss or corruption**
- Change handling - **If wrong, updates fail**

### ❌ CRITICAL RISK (Missing or Unknown)
- Calculation type diversity - **Cannot handle all business cases**
- Overload management - **Cannot enforce capacity constraints**
- Ratio-based calculations - **Missing business logic**
- BOB/BOSTA calculations - **Missing business logic**
- Lookup functions - **Missing data access**

---

## Conclusion

**Status:** INCOMPLETE MIGRATION

**Verified Coverage:** ~5-10% of PowerBuilder functionality
**Implemented Coverage:** ~15-20% of PowerBuilder functionality (estimated)
**Critical Gaps:** ~80-85% of functions not verified

**Recommendation:**
1. **DO NOT deploy to production** until PAX calculation and core orchestration are verified
2. **Prioritize PAX and calculation type verification** in next 2-3 days
3. **Create comprehensive test suite** comparing PowerBuilder vs Java outputs
4. **Plan 4-8 week completion timeline** for missing functionality

**Next Steps:**
1. Verify PAX calculation (CRITICAL)
2. Verify core orchestration logic (CRITICAL)
3. Map and verify calculation types (CRITICAL)
4. Continue systematic function-by-function verification

---

**Document Version:** 1.0
**Created:** 2025-11-17
**Author:** Claude (AI Assistant) - Migration Verification
