/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.SysQueueFlightPaxRepository;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightPax;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Service for applying PAX changes from SYS_QUEUE_FLIGHT_PAX to flight data.
 *
 * <p>PowerBuilder equivalent: of_get_sys_flight_pax() method
 *
 * <p>This service reads PAX changes queued for a job and applies them to the
 * flight's PAX data structure. Changes include:
 * <ul>
 *   <li>Passenger counts (NPAX)</li>
 *   <li>Forecast numbers (NFORECAST)</li>
 *   <li>Seat versions</li>
 *   <li>Class configurations</li>
 * </ul>
 *
 * @author Migration Team
 */
@Service
public class PaxChangeApplierService {

	private static final Logger LOGGER = LoggerFactory.getLogger(PaxChangeApplierService.class);

	@Autowired
	private SysQueueFlightPaxRepository paxRepository;

	/**
	 * Apply PAX changes from queue to flight data.
	 *
	 * <p>PowerBuilder logic:
	 * <pre>
	 * dsSysQueueFlightPax.Retrieve(ljob_nr)
	 * For lrow = 1 to dsSysQueueFlightPax.RowCount()
	 *    cclass = dsSysQueueFlightPax.GetItemString(lrow, "cclass")
	 *    lfound = dw_pax.Find("cclass = '" + cclass + "'", ...)
	 *    if lfound > 0 then
	 *       dw_pax.SetItem(lfound, "npax", new_npax)
	 *       ...
	 * Next
	 * </pre>
	 *
	 * @param jobNr Job number
	 * @return List of PAX changes to apply
	 */
	public List<SysQueueFlightPax> getPaxChanges(Long jobNr) {
		LOGGER.debug("Retrieving PAX changes for job_nr={}", jobNr);

		List<SysQueueFlightPax> paxChanges = paxRepository.findByJobNr(jobNr);

		if (paxChanges.isEmpty()) {
			LOGGER.debug("No PAX changes found for job_nr={}", jobNr);
		} else {
			LOGGER.info("Found {} PAX change(s) for job_nr={}", paxChanges.size(), jobNr);
			paxChanges.forEach(change ->
					LOGGER.debug("  PAX change: class={}, npax={}, forecast={}",
							change.getCclass(),
							change.getNpax(),
							change.getNforecast()));
		}

		return paxChanges;
	}

	/**
	 * Check if there are any PAX changes for a job.
	 *
	 * @param jobNr Job number
	 * @return true if PAX changes exist
	 */
	public boolean hasPaxChanges(Long jobNr) {
		return !getPaxChanges(jobNr).isEmpty();
	}

	/**
	 * Get PAX change for a specific class.
	 *
	 * @param jobNr Job number
	 * @param classCode Class code
	 * @return PAX change for the class, or null if not found
	 */
	public SysQueueFlightPax getPaxChangeForClass(Long jobNr, String classCode) {
		return paxRepository.findByJobNrAndClass(jobNr, classCode);
	}
}
