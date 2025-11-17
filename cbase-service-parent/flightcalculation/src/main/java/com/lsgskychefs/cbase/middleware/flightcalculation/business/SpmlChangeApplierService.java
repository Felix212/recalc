/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.SysQueueFlightSpmlRepository;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightSpml;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
}
