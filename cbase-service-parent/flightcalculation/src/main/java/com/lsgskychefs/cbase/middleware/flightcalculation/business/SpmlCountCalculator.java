/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutSpml;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service for calculating SPML counts per service class.
 *
 * <p>PowerBuilder equivalent: uf_get_spml_count() - Lines 15557-15602
 *
 * <p>This calculation is performed ONCE per service class, then the count is used
 * for all components in that class that have nspml_deduction = 1.
 *
 * @author Migration Team
 */
@Service
public class SpmlCountCalculator {

	private static final Logger LOGGER = LoggerFactory.getLogger(SpmlCountCalculator.class);

	/**
	 * Calculate SPML count for a service class.
	 *
	 * <p>PowerBuilder: uf_get_spml_count() lines 15557-15602
	 *
	 * <p>Rules:
	 * <ul>
	 *   <li>Only count SPMLs for the specified class</li>
	 *   <li>Exclude SPMLs with ntopoff = 1 (TopOff SPMLs don't affect regular meals)</li>
	 *   <li>Exclude preorder SPMLs if configured (future enhancement)</li>
	 * </ul>
	 *
	 * <p>PowerBuilder code:
	 * <pre>
	 * for j = 1 to dsSPML.RowCount()
	 *     if dsSPML.GetItemNumber(j,"nclass_number") = lClassNumber then
	 *         // TopOff-SPML dürfen keinen Abzug erfahren
	 *         if dsSPML.GetItemNumber(j,"ntopoff") = 0 then
	 *             lSpml += dsSPML.GetItemNumber(j,"nquantity")
	 *         end if
	 *     end if
	 * next
	 * </pre>
	 *
	 * @param spmlData All SPML records for the flight
	 * @param classCode Service class code (Y, C, F, etc.)
	 * @return Total SPML count for this class
	 */
	public int calculateSpmlCount(List<CenOutSpml> spmlData, String classCode) {
		if (spmlData == null || spmlData.isEmpty()) {
			return 0;
		}

		if (classCode == null || classCode.trim().isEmpty()) {
			LOGGER.warn("Class code is null or empty, returning 0 SPML count");
			return 0;
		}

		int spmlCount = 0;

		for (CenOutSpml spml : spmlData) {
			// Only count SPMLs for this class
			if (!classCode.equals(spml.getCclass())) {
				continue;
			}

			// Exclude TopOff SPMLs (ntopoff = 1)
			// PowerBuilder line 15588: if dsSPML.GetItemNumber(j,"ntopoff") = 0
			Integer topoff = spml.getNtopoff();
			if (topoff != null && topoff == 1) {
				LOGGER.debug("Excluding TopOff SPML: class={}, spml={}, quantity={}",
						classCode, spml.getCspml(), spml.getNquantity());
				continue;
			}

			// TODO: Handle preorder exclusion if needed
			// PowerBuilder line 15591-15595: Check for preorder key

			// Add SPML quantity to count
			BigDecimal quantity = spml.getNquantity();
			if (quantity != null) {
				spmlCount += quantity.intValue();
			}
		}

		LOGGER.debug("Calculated SPML count for class {}: {} SPMLs",
				classCode, spmlCount);

		return spmlCount;
	}

	/**
	 * Calculate SPML counts for all service classes.
	 *
	 * <p>Returns a map of class code to SPML count, useful for processing
	 * multiple classes in a single operation.
	 *
	 * @param spmlData All SPML records for the flight
	 * @return Map of class code to SPML count
	 */
	public Map<String, Integer> calculateSpmlCountsByClass(List<CenOutSpml> spmlData) {
		Map<String, Integer> result = new HashMap<>();

		if (spmlData == null || spmlData.isEmpty()) {
			return result;
		}

		// Group by class and calculate counts
		for (CenOutSpml spml : spmlData) {
			String classCode = spml.getCclass();
			if (classCode == null) {
				continue;
			}

			// Calculate count for this class if not already done
			if (!result.containsKey(classCode)) {
				int count = calculateSpmlCount(spmlData, classCode);
				result.put(classCode, count);
			}
		}

		LOGGER.info("Calculated SPML counts for {} classes: {}",
				result.size(), result);

		return result;
	}
}
