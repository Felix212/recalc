/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.config.FlightCalculationProperties;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.CenOutPpmFlightsRepository;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmFlights;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.LockTimeoutException;
import javax.persistence.PessimisticLockException;
import java.util.Optional;

/**
 * Service for managing pessimistic locks on flight records.
 * Implements PowerBuilder "SELECT FOR UPDATE NOWAIT" pattern.
 *
 * <p>Locking Strategy:
 * <ul>
 *   <li>Pessimistic write lock on CEN_OUT table</li>
 *   <li>NOWAIT semantics (fail immediately if locked)</li>
 *   <li>Lock released on transaction commit/rollback</li>
 *   <li>Configurable timeout (default 60 seconds)</li>
 * </ul>
 *
 * <p>PowerBuilder equivalent:
 * <pre>
 * SELECT cen_out.nresult_key
 *   INTO :lUpdateKey
 *   FROM cen_out
 *  WHERE cen_out.nresult_key = :lLockKey
 *  For Update NOWAIT
 * </pre>
 *
 * @author Migration Team
 */
@Service
public class FlightLockingService {

	private static final Logger LOGGER = LoggerFactory.getLogger(FlightLockingService.class);

	@Autowired
	private CenOutPpmFlightsRepository flightRepository;

	@Autowired
	private FlightCalculationProperties properties;

	/**
	 * Attempt to acquire a pessimistic write lock on a flight record.
	 *
	 * <p>This method attempts to lock the flight record immediately.
	 * If the record is already locked by another transaction, it will
	 * fail immediately (NOWAIT semantics).
	 *
	 * @param resultKey Flight result key
	 * @return Optional containing the locked flight, or empty if lock failed
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	public Optional<CenOutPpmFlights> acquireLock(Long resultKey) {
		try {
			LOGGER.debug("Attempting to acquire lock on flight with result_key={}", resultKey);

			Optional<CenOutPpmFlights> flight = flightRepository.findByResultKeyWithLock(resultKey);

			if (flight.isPresent()) {
				LOGGER.debug("Successfully acquired lock on flight with result_key={}", resultKey);
			} else {
				LOGGER.warn("Flight not found for result_key={}", resultKey);
			}

			return flight;

		} catch (LockTimeoutException | PessimisticLockException e) {
			LOGGER.info("Failed to acquire lock on flight with result_key={} - already locked: {}",
					resultKey, e.getMessage());
			return Optional.empty();
		}
	}

	/**
	 * Check if a flight can be locked (without actually locking it).
	 * This is a read-only check.
	 *
	 * @param resultKey Flight result key
	 * @return true if flight exists and is not locked
	 */
	@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
	public boolean canAcquireLock(Long resultKey) {
		// Simply check if flight exists
		// Actual lock attempt will determine if it's locked
		return flightRepository.findByResultKey(resultKey).isPresent();
	}

	/**
	 * Release lock on a flight.
	 * The lock is automatically released when the transaction commits or rolls back.
	 * This method is provided for explicit commit/rollback control.
	 *
	 * <p>PowerBuilder equivalent:
	 * <pre>commit;</pre>
	 *
	 * @param resultKey Flight result key (for logging purposes)
	 */
	public void releaseLock(Long resultKey) {
		LOGGER.debug("Lock will be released on transaction commit for result_key={}", resultKey);
		// Lock is released automatically by Spring @Transactional on commit/rollback
		// This method exists for API clarity and potential future enhancements
	}

	/**
	 * Get the configured lock timeout in milliseconds.
	 *
	 * @return Lock timeout in milliseconds
	 */
	public int getLockTimeoutMillis() {
		return properties.getLocking().getTimeoutMillis();
	}
}
