package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistance.FlightCalculationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseMiddlewareService;

/**
 * Service class for the flight calculation.
 *
 * @author Dirk Bunk - U200035
 */
@Service
public class FlightCalculationService extends AbstractCbaseMiddlewareService {
    /**
     * The logger.
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(FlightCalculationService.class);

    /** Flight Calculation repository. */
    @Autowired
    private FlightCalculationRepository flightCalculationRepository;

    public void calculateFlight(final Long resultKey)
            throws CbaseMiddlewareBusinessException {

        LOGGER.info("Calculate flight with result key: {}", resultKey);
    }
}