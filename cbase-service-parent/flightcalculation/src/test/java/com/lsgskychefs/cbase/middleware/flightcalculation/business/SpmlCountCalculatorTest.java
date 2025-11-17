/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutSpml;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for SpmlCountCalculator.
 *
 * <p>Tests PowerBuilder uf_get_spml_count() logic (lines 15557-15602)
 */
@DisplayName("SpmlCountCalculator Tests")
class SpmlCountCalculatorTest {

	private SpmlCountCalculator calculator;

	@BeforeEach
	void setUp() {
		calculator = new SpmlCountCalculator();
	}

	@Test
	@DisplayName("Calculate SPML count for single class")
	void testCalculateSpmlCountSingleClass() {
		// Given: 3 SPMLs for class Y, total 15 meals
		List<CenOutSpml> spmlData = Arrays.asList(
				createSpml("Y", "VGML", 5, 0),
				createSpml("Y", "KSML", 7, 0),
				createSpml("Y", "GFML", 3, 0)
		);

		// When
		int count = calculator.calculateSpmlCount(spmlData, "Y");

		// Then: Should sum all quantities for class Y
		assertEquals(15, count, "Should sum 5+7+3=15");
	}

	@Test
	@DisplayName("Calculate SPML count excludes TopOff SPMLs")
	void testCalculateSpmlCountExcludesTopOff() {
		// Given: 2 regular SPMLs + 1 TopOff SPML for class C
		List<CenOutSpml> spmlData = Arrays.asList(
				createSpml("C", "VGML", 5, 0),  // Regular
				createSpml("C", "KSML", 7, 1),  // TopOff (ntopoff=1) - EXCLUDED
				createSpml("C", "GFML", 3, 0)   // Regular
		);

		// When
		int count = calculator.calculateSpmlCount(spmlData, "C");

		// Then: Should exclude TopOff SPML (ntopoff=1)
		// PowerBuilder line 15588: if dsSPML.GetItemNumber(j,"ntopoff") = 0
		assertEquals(8, count, "Should count only 5+3=8, excluding TopOff");
	}

	@Test
	@DisplayName("Calculate SPML count for specific class only")
	void testCalculateSpmlCountFiltersByClass() {
		// Given: SPMLs for multiple classes
		List<CenOutSpml> spmlData = Arrays.asList(
				createSpml("Y", "VGML", 10, 0),  // Economy
				createSpml("C", "VGML", 5, 0),   // Business
				createSpml("F", "VGML", 2, 0)    // First
		);

		// When: Calculate for Business class only
		int count = calculator.calculateSpmlCount(spmlData, "C");

		// Then: Should count only Business class SPMLs
		assertEquals(5, count, "Should count only class C");
	}

	@Test
	@DisplayName("Calculate SPML count with empty list")
	void testCalculateSpmlCountEmpty() {
		// Given: Empty SPML list
		List<CenOutSpml> spmlData = Collections.emptyList();

		// When
		int count = calculator.calculateSpmlCount(spmlData, "Y");

		// Then: Should return 0
		assertEquals(0, count, "Empty list should return 0");
	}

	@Test
	@DisplayName("Calculate SPML count with null list")
	void testCalculateSpmlCountNull() {
		// When
		int count = calculator.calculateSpmlCount(null, "Y");

		// Then: Should return 0 (defensive)
		assertEquals(0, count, "Null list should return 0");
	}

	@Test
	@DisplayName("Calculate SPML count with null class code")
	void testCalculateSpmlCountNullClass() {
		// Given: Valid SPML data
		List<CenOutSpml> spmlData = Arrays.asList(
				createSpml("Y", "VGML", 5, 0)
		);

		// When: Calculate with null class
		int count = calculator.calculateSpmlCount(spmlData, null);

		// Then: Should return 0 (defensive)
		assertEquals(0, count, "Null class should return 0");
	}

	@Test
	@DisplayName("Calculate SPML counts by class returns all classes")
	void testCalculateSpmlCountsByClass() {
		// Given: SPMLs for 3 classes
		List<CenOutSpml> spmlData = Arrays.asList(
				createSpml("Y", "VGML", 10, 0),
				createSpml("Y", "KSML", 5, 0),
				createSpml("C", "VGML", 8, 0),
				createSpml("C", "GFML", 2, 1),  // TopOff - excluded
				createSpml("F", "VGML", 3, 0)
		);

		// When
		Map<String, Integer> countsByClass = calculator.calculateSpmlCountsByClass(spmlData);

		// Then: Should have counts for all 3 classes
		assertEquals(3, countsByClass.size(), "Should have 3 classes");
		assertEquals(15, countsByClass.get("Y"), "Y: 10+5=15");
		assertEquals(8, countsByClass.get("C"), "C: 8 (excluding TopOff)");
		assertEquals(3, countsByClass.get("F"), "F: 3");
	}

	@Test
	@DisplayName("Calculate SPML counts by class with empty list")
	void testCalculateSpmlCountsByClassEmpty() {
		// Given: Empty list
		List<CenOutSpml> spmlData = Collections.emptyList();

		// When
		Map<String, Integer> countsByClass = calculator.calculateSpmlCountsByClass(spmlData);

		// Then: Should return empty map
		assertTrue(countsByClass.isEmpty(), "Empty list should return empty map");
	}

	@Test
	@DisplayName("Calculate SPML count with zero quantity")
	void testCalculateSpmlCountWithZeroQuantity() {
		// Given: SPML with zero quantity
		List<CenOutSpml> spmlData = Arrays.asList(
				createSpml("Y", "VGML", 0, 0),
				createSpml("Y", "KSML", 5, 0)
		);

		// When
		int count = calculator.calculateSpmlCount(spmlData, "Y");

		// Then: Should include zero (0+5=5)
		assertEquals(5, count, "Should handle zero quantity");
	}

	@Test
	@DisplayName("Calculate SPML count with large quantities")
	void testCalculateSpmlCountLargeQuantities() {
		// Given: Large SPML quantities
		List<CenOutSpml> spmlData = Arrays.asList(
				createSpml("Y", "VGML", 150, 0),
				createSpml("Y", "KSML", 200, 0),
				createSpml("Y", "GFML", 100, 0)
		);

		// When
		int count = calculator.calculateSpmlCount(spmlData, "Y");

		// Then: Should sum correctly
		assertEquals(450, count, "Should sum large quantities: 150+200+100=450");
	}

	// Helper method to create SPML test data
	private CenOutSpml createSpml(String classCode, String spmlCode, int quantity, int topoff) {
		CenOutSpml spml = new CenOutSpml();
		spml.setCclass(classCode);
		spml.setCspml(spmlCode);
		spml.setNquantity(BigDecimal.valueOf(quantity));
		spml.setNtopoff(topoff);
		return spml;
	}
}
