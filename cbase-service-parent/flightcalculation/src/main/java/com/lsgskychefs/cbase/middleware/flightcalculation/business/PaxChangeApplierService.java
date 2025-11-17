/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.CenOutPaxRepository;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.SysQueueFlightPaxRepository;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPax;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmFlights;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightPax;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

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

	@Autowired
	private CenOutPaxRepository cenOutPaxRepository;

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

	/**
	 * Apply PAX changes from queue to flight PAX data.
	 *
	 * <p>PowerBuilder logic:
	 * <pre>
	 * // Read PAX changes from queue
	 * dsSysQueueFlightPax.Retrieve(ljob_nr)
	 *
	 * // Apply each change
	 * For lrow = 1 to dsSysQueueFlightPax.RowCount()
	 *    cclass = dsSysQueueFlightPax.GetItemString(lrow, "cclass")
	 *    lfound = dw_pax.Find("cclass = '" + cclass + "'", ...)
	 *
	 *    if lfound > 0 then
	 *       // Update existing PAX row
	 *       dw_pax.SetItem(lfound, "npax", new_npax)
	 *       dw_pax.SetItem(lfound, "npax_forecast", new_forecast)
	 *       dw_pax.SetItem(lfound, "nversion", new_version)
	 *       // Save old values for comparison
	 *       dw_pax.SetItem(lfound, "npax_old", old_npax)
	 *    end if
	 * Next
	 * </pre>
	 *
	 * @param flight Flight entity
	 * @param paxChanges List of PAX changes from queue
	 * @return Number of PAX records updated
	 */
	public int applyPaxChanges(CenOutPpmFlights flight, List<SysQueueFlightPax> paxChanges) {
		if (paxChanges == null || paxChanges.isEmpty()) {
			LOGGER.debug("No PAX changes to apply for result_key={}", flight.getId().getNresultKey());
			return 0;
		}

		Long resultKey = flight.getId().getNresultKey();
		int updatedCount = 0;

		LOGGER.info("Applying {} PAX change(s) to flight result_key={}", paxChanges.size(), resultKey);

		for (SysQueueFlightPax change : paxChanges) {
			String classCode = change.getCclass();

			LOGGER.debug("Processing PAX change for class={}, npax={}, forecast={}",
					classCode, change.getNpax(), change.getNforecast());

			// Find existing PAX record for this class
			Optional<CenOutPax> paxOpt = cenOutPaxRepository.findByResultKeyAndClass(resultKey, classCode);

			if (paxOpt.isPresent()) {
				CenOutPax pax = paxOpt.get();

				// Save old values for comparison (PowerBuilder keeps history)
				pax.setNpaxOld(pax.getNpax());
				pax.setNpaxSpmlOld(pax.getNpaxSpml());

				// Apply new values from queue
				if (change.getNpax() != null) {
					pax.setNpax(change.getNpax());
					LOGGER.debug("  Updated npax: {} -> {} for class={}",
							pax.getNpaxOld(), change.getNpax(), classCode);
				}

				if (change.getNforecast() != null) {
					pax.setNpaxForecast(change.getNforecast());
					LOGGER.debug("  Updated npax_forecast: {} for class={}", change.getNforecast(), classCode);
				}

				if (change.getNversion() != null) {
					pax.setNversion(change.getNversion());
					LOGGER.debug("  Updated nversion: {} for class={}", change.getNversion(), classCode);
				}

				// Update timestamp
				pax.setDtimestamp(new java.util.Date());

				// Save the updated PAX record
				cenOutPaxRepository.save(pax);
				updatedCount++;

				LOGGER.debug("  Successfully applied PAX change for class={}", classCode);
			} else {
				LOGGER.warn("  PAX record not found for class={}, result_key={} - skipping change",
						classCode, resultKey);
			}
		}

		LOGGER.info("Applied {} out of {} PAX change(s) for result_key={}",
				updatedCount, paxChanges.size(), resultKey);

		return updatedCount;
	}
}
