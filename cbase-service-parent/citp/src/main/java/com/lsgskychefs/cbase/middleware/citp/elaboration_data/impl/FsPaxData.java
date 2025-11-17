package com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl;

import com.dlh.zambas.aws.wbsinv.wrapper.ConfigurationDetailsType;
import com.dlh.zambas.aws.wbsinv.wrapper.InvAdvancedGetFlightDataReply;
import com.lsgskychefs.cbase.middleware.citp.common.request.RequestLogic;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.DataLogic;

import lombok.Data;

import java.util.List;

/**
 * Representation of a row in the FsPax
 *
 * @author U185502
 */
@Data
public class FsPaxData implements DataLogic {

    private static final String SALEABLE_CONFIG = "S";
    private String cclass;
    private String nversion;

    private int npax;
    private String nexpected;
    private String npad;
    //    private String NREQ_PAX_KEY;
    private String flightKey;
    private Long qpKey;
    private int nclassNumber;
    private int nspml;
    private int nchild;


    public FsPaxData() {
    }

    /**
     * populates the pojo with values.
     *
     * @param legCabin
     * @param myRequest
     */
    public FsPaxData(
            final InvAdvancedGetFlightDataReply.FlightDateInformation.Legs.LegCabins legCabin,
            final RequestLogic myRequest) {
        populateColumns(legCabin, myRequest);
    }

    /**
     * fills the properties
     *
     * @param legCabin
     * @param myRequest
     */
    private void populateColumns(InvAdvancedGetFlightDataReply.FlightDateInformation.Legs.LegCabins legCabin,
                                 RequestLogic myRequest) {

        this.flightKey = myRequest.getFlightKey();
        this.qpKey = myRequest.getQpKey();

        List<ConfigurationDetailsType> fittedConfiguration = legCabin.getLegCabin()
                .getFittedConfiguration();
        for (ConfigurationDetailsType configurationDetails : fittedConfiguration) {
            if (SALEABLE_CONFIG.equalsIgnoreCase(configurationDetails.getQualifier())) {
                this.nversion = configurationDetails.getCabinCapacity().toString();
                this.cclass = configurationDetails.getCabinCode();
                // 03.02.14, Dirk Bunk: Anpassung/Erweiterung für Premium Economy
                if ("F".equalsIgnoreCase(this.cclass)) {
                    this.nclassNumber = 1;
                } else if ("C".equalsIgnoreCase(this.cclass)) {
                    this.nclassNumber = 2;
                } else if ("E".equalsIgnoreCase(this.cclass)) {
                    this.nclassNumber = 3;
                } else if ("M".equalsIgnoreCase(this.cclass)) {
                    this.nclassNumber = 4;
                }
            }

        }
        this.npax = legCabin.getCabinAvailabilities().getBookingsCounter();
        this.nexpected = legCabin.getCabinAvailabilities().getExpectedToBoard();
        this.npad = legCabin.getCabinAvailabilities().getStaffStandbyCounter().toString();
    }

}
