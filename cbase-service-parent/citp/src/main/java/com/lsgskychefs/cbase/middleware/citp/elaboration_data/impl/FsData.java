package com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl;

import com.dlh.zambas.aws.wbsinv.wrapper.ConfigurationDetailsType;
import com.dlh.zambas.aws.wbsinv.wrapper.DateAndTimeDetailsTypeI272157C;
import com.dlh.zambas.aws.wbsinv.wrapper.FlightDetailsResponseType;
import com.dlh.zambas.aws.wbsinv.wrapper.InvAdvancedGetFlightDataReply;
import com.lsgskychefs.cbase.middleware.citp.common.request.RequestLogic;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.FlightDataLogic;
import com.lsgskychefs.cbase.middleware.citp.utils.DataHelper;

import lombok.Data;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

/**
 * Holds the information about the flight
 *
 * @author U185502
 */
@Data
public class FsData implements FlightDataLogic {

    private static final Logger LOGGER = LoggerFactory.getLogger(FsData.class);

    private static final String SALEABLE_CONFIG = "S";
    // 03.02.14, Dirk Bunk: Anpassung/Erweiterung für Premium Economy
    private static final int CABIN_CODES = 4;

    private String cflightKey;
    private String cairline;
    private int nflightNumber;
    private final String csuffix = " ";
    private String ddeparture;
    private String ddepartureUTC;
    private int ndepartureOffset;
    private String cdepStation;
    private String darrival;
    private String darrivalUTC;
    private int narrivalOffset;
    private String carrStation;
    private String cacType;
    private String cacConfiguration;
    private String crange;
    private String dtimestamp;

    private String ctlcFrom;
    private String ctlcTo;

    private String cairlineOwner;
    private String jobNumber;

    // columns of the Table cbase.cen_request_flight
    private Long qpKey;

    public FsData() {
    }

    /**
     * Constructor with parameters
     *
     * @param flightDateDesignator
     * @param leg
     * @param myRequest
     */
    public FsData(final FlightDetailsResponseType flightDateDesignator,
                  final InvAdvancedGetFlightDataReply.FlightDateInformation.Legs leg,
                  final RequestLogic myRequest) {
        populateColumns(flightDateDesignator, leg, myRequest);
    }

    /**
     * Populate the variables of the class
     *
     * @param flightDateDesignator
     * @param leg
     * @param myRequest
     */
    private void populateColumns(
            final FlightDetailsResponseType flightDateDesignator,
            final InvAdvancedGetFlightDataReply.FlightDateInformation.Legs leg,
            final RequestLogic myRequest) {

        this.nflightNumber = flightDateDesignator.getFlightReference()
                .getFlightNumber();

        this.cairline = flightDateDesignator.getAirlineInformation()
                .getAirlineCode();
        this.jobNumber = Long.toString(myRequest.getNJobNumber());

        this.ctlcFrom = leg.getLeg().getLegDetails().getInitLocations().get(0);
        this.ctlcTo = leg.getLeg().getLegDetails().getInitLocations().get(1);

        List<DateAndTimeDetailsTypeI272157C> dateAndTimeDetails = leg.getScheduledTiming()
                .getDateAndTimeDetails();
        for (DateAndTimeDetailsTypeI272157C dateAndTimeDetail : dateAndTimeDetails) {
            if ("708".equalsIgnoreCase(dateAndTimeDetail.getQualifier())) {
                this.ddeparture = dateAndTimeDetail.getDate();
                this.ddepartureUTC = humanReadableTime(dateAndTimeDetail.getTime());
            } else if ("707".equalsIgnoreCase(dateAndTimeDetail.getQualifier())) {
                this.darrival = dateAndTimeDetail.getDate();
                this.darrivalUTC = humanReadableTime(dateAndTimeDetail.getTime());
            }
        }

        this.cacType = leg.getAircraftInformation().getEquipmentDetails()
                .getAircraftType();
        try {
            this.cairlineOwner = leg.getAircraftInformation().getCompanyDetails().getAircraftOwner();
        } catch (NullPointerException ex) {
            LOGGER.error(ex.getMessage(), ex);
        }
        this.cacConfiguration = getCConfiguration(leg);

        this.qpKey = myRequest.getQpKey();
        this.cflightKey = myRequest.getFlightKey();

    }

    /**
     * Extract the configuration about the cabin capacity
     *
     * @param leg
     * @return
     */
    private String getCConfiguration(
            InvAdvancedGetFlightDataReply.FlightDateInformation.Legs leg) {

        // the order in the string is F C M
        String[] cabinCapacities = new String[CABIN_CODES];

        List<InvAdvancedGetFlightDataReply.FlightDateInformation.Legs.LegCabins> legCabins = leg
                .getLegCabins();
        for (InvAdvancedGetFlightDataReply.FlightDateInformation.Legs.LegCabins legCabin : legCabins) {
            List<ConfigurationDetailsType> fittedConfiguration = legCabin.getLegCabin()
                    .getFittedConfiguration();

            for (ConfigurationDetailsType configurationDetails : fittedConfiguration) {
                if (SALEABLE_CONFIG.equalsIgnoreCase(configurationDetails.getQualifier())) {
                    String cabinCode = configurationDetails.getCabinCode();
                    String cabinCapacity = configurationDetails.getCabinCapacity().toString();
                    cabinCapacity = DataHelper.fillWithZeros(cabinCapacity);
                    // 03.02.14, Dirk Bunk: Anpassung/Erweiterung für Premium Economy
                    if ("F".equalsIgnoreCase(cabinCode)) {
                        cabinCapacities[0] = cabinCapacity;
                    } else if ("C".equalsIgnoreCase(cabinCode)) {
                        cabinCapacities[1] = cabinCapacity;
                    } else if ("E".equalsIgnoreCase(cabinCode)) {
                        cabinCapacities[2] = cabinCapacity;
                    } else if ("M".equalsIgnoreCase(cabinCode)) {
                        cabinCapacities[3] = cabinCapacity;
                    }
                }
            }

        }
        if (cabinCapacities[0] == null) {
            cabinCapacities[0] = "000";
        }
        if (cabinCapacities[1] == null) {
            cabinCapacities[1] = "000";
        }
        if (cabinCapacities[2] == null) {
            cabinCapacities[2] = "000";
        }
        // 03.02.14, Dirk Bunk: Adaptation / extension for Premium Economy
        if (cabinCapacities[3] == null) {
            cabinCapacities[3] = "000";
        }

        StringBuilder stringBuilder = new StringBuilder();
        for (int i = 0; i < CABIN_CODES; i++) {
            stringBuilder.append(cabinCapacities[i]);
            if (i < (CABIN_CODES - 1)) {
                stringBuilder.append("-");
            }
        }

        return stringBuilder.toString();
    }

    /**
     * Adds a colon between the second and the third character of the given String.
     *
     * @param time The time-String to be converted. [TTMM]
     * @return The time-String containing a colon. [TT:MM]
     */
    private String humanReadableTime(String time) {
        if ((time != null) && (time.length() > 3)) {
            String hours = time.substring(0, 2);
            String minutes = time.substring(2);
            time = hours + ":" + minutes;
        }
        return time;
    }

    @Override
    public Long getNreqFlightKey() {
        return qpKey;
    }
}
