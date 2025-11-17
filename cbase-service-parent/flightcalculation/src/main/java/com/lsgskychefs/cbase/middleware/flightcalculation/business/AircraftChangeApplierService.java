/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.SysQueueFlightActypeRepository;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightActype;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

/**
 * Service for applying aircraft type changes from SYS_QUEUE_FLIGHT_ACTYPE.
 *
 * <p>PowerBuilder equivalent: of_get_sys_flight_actype() method
 *
 * <p>This service reads aircraft changes queued for a job and applies them to
 * the flight's master data. Changes include:
 * <ul>
 *   <li>Aircraft type key</li>
 *   <li>Registration (tail number)</li>
 *   <li>Configuration key</li>
 *   <li>Version information</li>
 * </ul>
 *
 * <p>Return codes:
 * <ul>
 *   <li>0 = No change</li>
 *   <li>1 = Aircraft type changed (triggers master change)</li>
 *   <li>2 = Registration changed only</li>
 * </ul>
 *
 * @author Migration Team
 */
@Service
public class AircraftChangeApplierService {

	private static final Logger LOGGER = LoggerFactory.getLogger(AircraftChangeApplierService.class);

	@Autowired
	private SysQueueFlightActypeRepository actypeRepository;

	/**
	 * Result of aircraft change application.
	 */
	public enum ChangeType {
		/** No change */
		NO_CHANGE(0),
		/** Aircraft type changed (master change required) */
		AIRCRAFT_TYPE_CHANGED(1),
		/** Registration changed only */
		REGISTRATION_CHANGED(2);

		private final int code;

		ChangeType(int code) {
			this.code = code;
		}

		public int getCode() {
			return code;
		}
	}

	/**
	 * Get aircraft change for a job.
	 *
	 * <p>PowerBuilder logic:
	 * <pre>
	 * dsSysQueueFlightACType.Retrieve(ljob_nr)
	 * if dsSysQueueFlightACType.RowCount() > 0 then
	 *    dw_single.SetItem(1, "naircrafttype_key", new_aircraft_key)
	 *    dw_single.SetItem(1, "cregistration", new_registration)
	 *    return 1  // Aircraft changed
	 * end if
	 * </pre>
	 *
	 * @param jobNr Job number
	 * @return Optional aircraft change
	 */
	public Optional<SysQueueFlightActype> getAircraftChange(Long jobNr) {
		LOGGER.debug("Retrieving aircraft change for job_nr={}", jobNr);

		Optional<SysQueueFlightActype> change = actypeRepository.findFirstByJobNr(jobNr);

		if (change.isPresent()) {
			SysQueueFlightActype actype = change.get();
			LOGGER.info("Found aircraft change for job_nr={}: aircraftKey={}, registration={}",
					jobNr, actype.getNaircrafttypeKey(), actype.getCregistration());
		} else {
			LOGGER.debug("No aircraft change found for job_nr={}", jobNr);
		}

		return change;
	}

	/**
	 * Check if there is an aircraft change for a job.
	 *
	 * @param jobNr Job number
	 * @return true if aircraft change exists
	 */
	public boolean hasAircraftChange(Long jobNr) {
		return getAircraftChange(jobNr).isPresent();
	}

	/**
	 * Determine the type of aircraft change.
	 * Compares queued change with current flight data.
	 *
	 * @param queuedChange Queued aircraft change
	 * @param currentAircraftKey Current aircraft type key
	 * @param currentRegistration Current registration
	 * @return Type of change
	 */
	public ChangeType determineChangeType(
			SysQueueFlightActype queuedChange,
			Long currentAircraftKey,
			String currentRegistration) {

		boolean aircraftChanged = !equals(queuedChange.getNaircrafttypeKey(), currentAircraftKey);
		boolean registrationChanged = !equals(queuedChange.getCregistration(), currentRegistration);

		if (aircraftChanged) {
			LOGGER.info("Aircraft type changed: {} -> {}",
					currentAircraftKey, queuedChange.getNaircrafttypeKey());
			return ChangeType.AIRCRAFT_TYPE_CHANGED;
		} else if (registrationChanged) {
			LOGGER.info("Registration changed: {} -> {}",
					currentRegistration, queuedChange.getCregistration());
			return ChangeType.REGISTRATION_CHANGED;
		} else {
			LOGGER.debug("No aircraft change detected");
			return ChangeType.NO_CHANGE;
		}
	}

	/**
	 * Helper method to compare objects (handles nulls).
	 */
	private boolean equals(Object a, Object b) {
		if (a == null && b == null) return true;
		if (a == null || b == null) return false;
		return a.equals(b);
	}
}
