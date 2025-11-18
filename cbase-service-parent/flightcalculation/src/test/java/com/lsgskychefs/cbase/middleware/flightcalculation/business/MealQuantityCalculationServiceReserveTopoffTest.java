/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for reserve and topoff calculation logic.
 *
 * <p>Tests PowerBuilder lines 7212-7348 (reserve/topoff calculation)
 *
 * <p>CRITICAL: All types use FIXED quantities, not percentages!
 */
@DisplayName("Reserve and TopOff Calculation Tests")
class MealQuantityCalculationServiceReserveTopoffTest {

	private MealQuantityCalculationService service;

	@BeforeEach
	void setUp() {
		service = new MealQuantityCalculationService(new SpmlCountCalculator());
	}

	//===================================================================================
	// RESERVE TESTS - All types use FIXED quantities
	//===================================================================================

	@Test
	@DisplayName("Reserve Type 0: Always add fixed quantity")
	void testReserveType0() {
		// Given: 150 PAX, reserve=10, type=0
		int baseMeals = 150;
		int paxCount = 150;
		int reserveQuantity = 10;
		int reserveType = 0;
		int aircraftVersion = 180;

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType, aircraftVersion);

		// Then: Type 0 always adds fixed quantity
		assertEquals(10, reserve, "Type 0: Always add 10");
	}

	@Test
	@DisplayName("Reserve Type 1: Add fixed quantity, capped at aircraft version")
	void testReserveType1WithinCapacity() {
		// Given: 150 PAX, reserve=10, type=1, capacity=180
		// 150 + 10 = 160 < 180 (within capacity)
		int baseMeals = 150;
		int paxCount = 150;
		int reserveQuantity = 10;
		int reserveType = 1;
		int aircraftVersion = 180;

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType, aircraftVersion);

		// Then: Within capacity, add full reserve
		assertEquals(10, reserve, "Type 1: Add 10 (within capacity)");
	}

	@Test
	@DisplayName("Reserve Type 1: Capped at aircraft version when exceeding")
	void testReserveType1ExceedsCapacity() {
		// Given: 175 PAX, reserve=10, type=1, capacity=180
		// 175 + 10 = 185 > 180 (exceeds capacity)
		int baseMeals = 175;
		int paxCount = 175;
		int reserveQuantity = 10;
		int reserveType = 1;
		int aircraftVersion = 180;

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType, aircraftVersion);

		// Then: Capped at capacity, only add 5 to reach 180
		assertEquals(5, reserve, "Type 1: Add 5 to cap at 180 (175+5=180)");
	}

	@Test
	@DisplayName("Reserve Type 1: Already at capacity")
	void testReserveType1AtCapacity() {
		// Given: 180 PAX, reserve=10, type=1, capacity=180
		// Already at capacity
		int baseMeals = 180;
		int paxCount = 180;
		int reserveQuantity = 10;
		int reserveType = 1;
		int aircraftVersion = 180;

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType, aircraftVersion);

		// Then: Already at capacity, add 0
		assertEquals(0, reserve, "Type 1: Add 0 (already at capacity)");
	}

	@Test
	@DisplayName("Reserve Type 2: Add fixed quantity only if PAX > 0")
	void testReserveType2WithPax() {
		// Given: 150 PAX, reserve=10, type=2
		int baseMeals = 150;
		int paxCount = 150;
		int reserveQuantity = 10;
		int reserveType = 2;
		int aircraftVersion = 180;

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType, aircraftVersion);

		// Then: PAX > 0, add reserve
		assertEquals(10, reserve, "Type 2: Add 10 (PAX > 0)");
	}

	@Test
	@DisplayName("Reserve Type 2: No reserve if PAX = 0")
	void testReserveType2NoPax() {
		// Given: 0 PAX, reserve=10, type=2
		int baseMeals = 0;
		int paxCount = 0;
		int reserveQuantity = 10;
		int reserveType = 2;
		int aircraftVersion = 180;

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType, aircraftVersion);

		// Then: PAX = 0, no reserve
		assertEquals(0, reserve, "Type 2: Add 0 (PAX = 0)");
	}

	@Test
	@DisplayName("Reserve Type 3: Add fixed if PAX > 0 AND cap at version")
	void testReserveType3WithPaxWithinCapacity() {
		// Given: 150 PAX, reserve=10, type=3, capacity=180
		int baseMeals = 150;
		int paxCount = 150;
		int reserveQuantity = 10;
		int reserveType = 3;
		int aircraftVersion = 180;

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType, aircraftVersion);

		// Then: PAX > 0 and within capacity, add 10
		assertEquals(10, reserve, "Type 3: Add 10 (PAX > 0, within capacity)");
	}

	@Test
	@DisplayName("Reserve Type 3: Capped at version when exceeding")
	void testReserveType3WithPaxExceedsCapacity() {
		// Given: 175 PAX, reserve=10, type=3, capacity=180
		int baseMeals = 175;
		int paxCount = 175;
		int reserveQuantity = 10;
		int reserveType = 3;
		int aircraftVersion = 180;

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType, aircraftVersion);

		// Then: PAX > 0 but would exceed capacity, cap at 5
		assertEquals(5, reserve, "Type 3: Add 5 to cap at 180 (175+5=180)");
	}

	@Test
	@DisplayName("Reserve Type 3: No reserve if PAX = 0")
	void testReserveType3NoPax() {
		// Given: 0 PAX, reserve=10, type=3
		int baseMeals = 0;
		int paxCount = 0;
		int reserveQuantity = 10;
		int reserveType = 3;
		int aircraftVersion = 180;

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType, aircraftVersion);

		// Then: PAX = 0, no reserve
		assertEquals(0, reserve, "Type 3: Add 0 (PAX = 0)");
	}

	@Test
	@DisplayName("Reserve with zero quantity")
	void testReserveZeroQuantity() {
		// Given: reserve=0 (any type)
		int baseMeals = 150;
		int paxCount = 150;
		int reserveQuantity = 0;
		int reserveType = 0;
		int aircraftVersion = 180;

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType, aircraftVersion);

		// Then: Zero quantity, add 0
		assertEquals(0, reserve, "Zero quantity: Add 0");
	}

	//===================================================================================
	// TOPOFF TESTS - All types use FIXED quantities
	//===================================================================================

	@Test
	@DisplayName("TopOff Type 0: Always add fixed quantity")
	void testTopOffType0() {
		// Given: 160 meals (after reserve), 150 PAX, topoff=20, type=0
		int mealQuantity = 160;
		int paxCount = 150;
		int topoffQuantity = 20;
		int topoffType = 0;
		int aircraftVersion = 200;

		// When
		int topoff = service.applyTopOffs(mealQuantity, paxCount, topoffQuantity, topoffType, aircraftVersion);

		// Then: Type 0 always adds fixed quantity
		assertEquals(20, topoff, "Type 0: Always add 20");
	}

	@Test
	@DisplayName("TopOff Type 1: Add fixed quantity, capped at version")
	void testTopOffType1WithinCapacity() {
		// Given: 160 meals, topoff=20, type=1, capacity=200
		int mealQuantity = 160;
		int paxCount = 150;
		int topoffQuantity = 20;
		int topoffType = 1;
		int aircraftVersion = 200;

		// When
		int topoff = service.applyTopOffs(mealQuantity, paxCount, topoffQuantity, topoffType, aircraftVersion);

		// Then: Within capacity, add 20
		assertEquals(20, topoff, "Type 1: Add 20 (within capacity)");
	}

	@Test
	@DisplayName("TopOff Type 1: Capped at aircraft version")
	void testTopOffType1ExceedsCapacity() {
		// Given: 185 meals, topoff=20, type=1, capacity=200
		int mealQuantity = 185;
		int paxCount = 150;
		int topoffQuantity = 20;
		int topoffType = 1;
		int aircraftVersion = 200;

		// When
		int topoff = service.applyTopOffs(mealQuantity, paxCount, topoffQuantity, topoffType, aircraftVersion);

		// Then: Capped at capacity, only add 15
		assertEquals(15, topoff, "Type 1: Add 15 to cap at 200 (185+15=200)");
	}

	@Test
	@DisplayName("TopOff Type 2: Add fixed only if PAX > 0")
	void testTopOffType2WithPax() {
		// Given: 160 meals, 150 PAX, topoff=20, type=2
		int mealQuantity = 160;
		int paxCount = 150;
		int topoffQuantity = 20;
		int topoffType = 2;
		int aircraftVersion = 200;

		// When
		int topoff = service.applyTopOffs(mealQuantity, paxCount, topoffQuantity, topoffType, aircraftVersion);

		// Then: PAX > 0, add topoff
		assertEquals(20, topoff, "Type 2: Add 20 (PAX > 0)");
	}

	@Test
	@DisplayName("TopOff Type 2: No topoff if PAX = 0")
	void testTopOffType2NoPax() {
		// Given: 0 PAX, topoff=20, type=2
		int mealQuantity = 10;
		int paxCount = 0;
		int topoffQuantity = 20;
		int topoffType = 2;
		int aircraftVersion = 200;

		// When
		int topoff = service.applyTopOffs(mealQuantity, paxCount, topoffQuantity, topoffType, aircraftVersion);

		// Then: PAX = 0, no topoff
		assertEquals(0, topoff, "Type 2: Add 0 (PAX = 0)");
	}

	@Test
	@DisplayName("TopOff Type 3: Add fixed if PAX > 0 AND cap at version")
	void testTopOffType3WithPaxWithinCapacity() {
		// Given: 160 meals, 150 PAX, topoff=20, type=3, capacity=200
		int mealQuantity = 160;
		int paxCount = 150;
		int topoffQuantity = 20;
		int topoffType = 3;
		int aircraftVersion = 200;

		// When
		int topoff = service.applyTopOffs(mealQuantity, paxCount, topoffQuantity, topoffType, aircraftVersion);

		// Then: PAX > 0 and within capacity, add 20
		assertEquals(20, topoff, "Type 3: Add 20 (PAX > 0, within capacity)");
	}

	@Test
	@DisplayName("TopOff Type 3: No topoff if PAX = 0")
	void testTopOffType3NoPax() {
		// Given: 0 PAX, topoff=20, type=3
		int mealQuantity = 10;
		int paxCount = 0;
		int topoffQuantity = 20;
		int topoffType = 3;
		int aircraftVersion = 200;

		// When
		int topoff = service.applyTopOffs(mealQuantity, paxCount, topoffQuantity, topoffType, aircraftVersion);

		// Then: PAX = 0, no topoff
		assertEquals(0, topoff, "Type 3: Add 0 (PAX = 0)");
	}

	@Test
	@DisplayName("TopOff not applied if flight is overbooked")
	void testTopOffWithOverbooking() {
		// Given: Overbooked flight (PAX > aircraft version)
		int mealQuantity = 160;
		int paxCount = 200;  // Overbooked
		int topoffQuantity = 20;
		int topoffType = 0;
		int aircraftVersion = 180;  // PAX exceeds capacity

		// When
		int topoff = service.applyTopOffs(mealQuantity, paxCount, topoffQuantity, topoffType, aircraftVersion);

		// Then: Overbooked, no topoff
		assertEquals(0, topoff, "Overbooked: No topoff applied");
	}

	@Test
	@DisplayName("TopOff with zero quantity")
	void testTopOffZeroQuantity() {
		// Given: topoff=0 (any type)
		int mealQuantity = 160;
		int paxCount = 150;
		int topoffQuantity = 0;
		int topoffType = 0;
		int aircraftVersion = 200;

		// When
		int topoff = service.applyTopOffs(mealQuantity, paxCount, topoffQuantity, topoffType, aircraftVersion);

		// Then: Zero quantity, add 0
		assertEquals(0, topoff, "Zero quantity: Add 0");
	}

	//===================================================================================
	// EDGE CASES
	//===================================================================================

	@Test
	@DisplayName("Reserve with large quantity")
	void testReserveLargeQuantity() {
		// Given: Large reserve quantity
		int baseMeals = 100;
		int paxCount = 100;
		int reserveQuantity = 500;
		int reserveType = 0;
		int aircraftVersion = 200;

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType, aircraftVersion);

		// Then: Type 0 adds full quantity (even if large)
		assertEquals(500, reserve, "Type 0: Add large quantity 500");
	}

	@Test
	@DisplayName("Reserve Type 1 with very small aircraft")
	void testReserveType1SmallAircraft() {
		// Given: Small aircraft, already at capacity
		int baseMeals = 50;
		int paxCount = 50;
		int reserveQuantity = 10;
		int reserveType = 1;
		int aircraftVersion = 50;  // Already at capacity

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType, aircraftVersion);

		// Then: Already at capacity, add 0
		assertEquals(0, reserve, "Type 1: Add 0 (at capacity)");
	}

	@Test
	@DisplayName("Unknown reserve type defaults to 0")
	void testUnknownReserveType() {
		// Given: Unknown reserve type
		int baseMeals = 150;
		int paxCount = 150;
		int reserveQuantity = 10;
		int reserveType = 99;  // Unknown type
		int aircraftVersion = 180;

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType, aircraftVersion);

		// Then: Unknown type, add 0 (defensive)
		assertEquals(0, reserve, "Unknown type: Add 0");
	}
}
