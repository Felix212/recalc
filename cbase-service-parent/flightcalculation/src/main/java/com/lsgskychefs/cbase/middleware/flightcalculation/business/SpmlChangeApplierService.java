/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.CenOutSpmlRepository;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.SysQueueFlightSpmlRepository;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmFlights;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutSpml;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightSpml;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

/**
 * Service for applying SPML (Special Meals) changes from SYS_QUEUE_FLIGHT_SPML.
 *
 * <p>PowerBuilder equivalent: of_get_sys_flight_spml() method
 *
 * <p>This service reads SPML changes queued for a job and applies them to
 * the flight's SPML data. Changes include:
 * <ul>
 *   <li>SPML codes and quantities</li>
 *   <li>Class assignments</li>
 *   <li>SPML types</li>
 * </ul>
 *
 * @author Migration Team
 */
@Service
public class SpmlChangeApplierService {

	private static final Logger LOGGER = LoggerFactory.getLogger(SpmlChangeApplierService.class);

	@Autowired
	private SysQueueFlightSpmlRepository spmlRepository;

	@Autowired
	private CenOutSpmlRepository cenOutSpmlRepository;

	/**
	 * Get SPML changes from queue.
	 *
	 * <p>PowerBuilder logic:
	 * <pre>
	 * dsSysQueueFlightSPML.Retrieve(ljob_nr)
	 * For lrow = 1 to dsSysQueueFlightSPML.RowCount()
	 *    // Update or insert SPML rows
	 *    dw_spml.SetItem(target_row, "nquantity", new_quantity)
	 *    dw_spml.SetItem(target_row, "cclass", new_class)
	 * Next
	 * </pre>
	 *
	 * @param jobNr Job number
	 * @return List of SPML changes to apply
	 */
	public List<SysQueueFlightSpml> getSpmlChanges(Long jobNr) {
		LOGGER.debug("Retrieving SPML changes for job_nr={}", jobNr);

		List<SysQueueFlightSpml> spmlChanges = spmlRepository.findByJobNr(jobNr);

		if (spmlChanges.isEmpty()) {
			LOGGER.debug("No SPML changes found for job_nr={}", jobNr);
		} else {
			LOGGER.info("Found {} SPML change(s) for job_nr={}", spmlChanges.size(), jobNr);
			spmlChanges.forEach(change ->
					LOGGER.debug("  SPML change: class={}, code={}, quantity={}",
							change.getCclass(),
							change.getCspmlCode(),
							change.getNquantity()));
		}

		return spmlChanges;
	}

	/**
	 * Check if there are any SPML changes for a job.
	 *
	 * @param jobNr Job number
	 * @return true if SPML changes exist
	 */
	public boolean hasSpmlChanges(Long jobNr) {
		return !getSpmlChanges(jobNr).isEmpty();
	}

	/**
	 * Get SPML change for a specific class and SPML code.
	 *
	 * @param jobNr Job number
	 * @param classCode Class code
	 * @param spmlCode SPML code
	 * @return SPML change, or null if not found
	 */
	public SysQueueFlightSpml getSpmlChangeForClassAndCode(
			Long jobNr, String classCode, String spmlCode) {
		return spmlRepository.findByJobNrAndClassAndSpml(jobNr, classCode, spmlCode);
	}

	/**
	 * Apply SPML changes from queue to flight SPML data.
	 *
	 * <p>PowerBuilder logic:
	 * <pre>
	 * // Read SPML changes from queue
	 * dsSysQueueFlightSPML.Retrieve(ljob_nr)
	 *
	 * // Apply each change
	 * For lrow = 1 to dsSysQueueFlightSPML.RowCount()
	 *    cclass = dsSysQueueFlightSPML.GetItemString(lrow, "cclass")
	 *    cspml = dsSysQueueFlightSPML.GetItemString(lrow, "cspml_code")
	 *
	 *    // Find matching row in dw_spml
	 *    lfound = dw_spml.Find("cclass = '" + cclass + "' AND cspml = '" + cspml + "'", ...)
	 *
	 *    if lfound > 0 then
	 *       // Update existing SPML row
	 *       dw_spml.SetItem(lfound, "nquantity", new_quantity)
	 *       dw_spml.SetItem(lfound, "nquantity_old", old_quantity)
	 *    end if
	 * Next
	 * </pre>
	 *
	 * @param flight Flight entity
	 * @param spmlChanges List of SPML changes from queue
	 * @return Number of SPML records updated
	 */
	public int applySpmlChanges(CenOutPpmFlights flight, List<SysQueueFlightSpml> spmlChanges) {
		if (spmlChanges == null || spmlChanges.isEmpty()) {
			LOGGER.debug("No SPML changes to apply for result_key={}", flight.getId().getNresultKey());
			return 0;
		}

		Long resultKey = flight.getId().getNresultKey();
		int updatedCount = 0;

		LOGGER.info("Applying {} SPML change(s) to flight result_key={}", spmlChanges.size(), resultKey);

		for (SysQueueFlightSpml change : spmlChanges) {
			String classCode = change.getCclass();
			String spmlCode = change.getCspmlCode();

			LOGGER.debug("Processing SPML change for class={}, spml={}, quantity={}",
					classCode, spmlCode, change.getNquantity());

			// Find existing SPML record for this class and code
			Optional<CenOutSpml> spmlOpt = cenOutSpmlRepository.findByResultKeyAndClassAndCode(
					resultKey, classCode, spmlCode);

			if (spmlOpt.isPresent()) {
				CenOutSpml spml = spmlOpt.get();

				// Save old value for comparison (PowerBuilder keeps history)
				if (spml.getNquantity() != null) {
					spml.setNquantityOld(spml.getNquantity());
				}

				// Apply new quantity from queue
				if (change.getNquantity() != null) {
					spml.setNquantity(BigDecimal.valueOf(change.getNquantity()));
					LOGGER.debug("  Updated nquantity: {} -> {} for class={}, spml={}",
							spml.getNquantityOld(), change.getNquantity(), classCode, spmlCode);
				}

				// Update timestamp
				spml.setDtimestamp(new java.util.Date());

				// Save the updated SPML record
				cenOutSpmlRepository.save(spml);
				updatedCount++;

				LOGGER.debug("  Successfully applied SPML change for class={}, spml={}", classCode, spmlCode);
			} else {
				LOGGER.warn("  SPML record not found for class={}, spml={}, result_key={} - skipping change",
						classCode, spmlCode, resultKey);
			}
		}

		LOGGER.info("Applied {} out of {} SPML change(s) for result_key={}",
				updatedCount, spmlChanges.size(), resultKey);

		return updatedCount;
	}
}
