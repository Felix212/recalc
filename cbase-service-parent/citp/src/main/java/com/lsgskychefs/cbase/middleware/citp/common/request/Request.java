package com.lsgskychefs.cbase.middleware.citp.common.request;

import com.dlh.zambas.aws.wbsinv.wrapper.FlightDetailsQueryType4;
import com.dlh.zambas.aws.wbsinv.wrapper.OutboundCarrierDetailsTypeI5;
import com.dlh.zambas.aws.wbsinv.wrapper.OutboundFlightNumberDetailstypeI5;
import com.dlh.zambas.aws.wbspnr.wrapper.ElementManagementSegmentType16;
import com.dlh.zambas.aws.wbspnr.wrapper.OutboundCarrierDetailsTypeI4;
import com.dlh.zambas.aws.wbspnr.wrapper.PNRListPassengersByFlight;
import com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response.FsData;
import com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response.FsQp;
import com.lsgskychefs.cbase.middleware.citp.config.CITPCustomProperties;
import com.lsgskychefs.cbase.middleware.citp.utils.DateHelper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Arrays;
import java.util.Date;

/**
 * Collect the information about the flight detail.
 * Implements the RequestLogic
 *
 * @author U185502
 */
public class Request implements RequestInLogic {

    private static final Logger LOGGER = LoggerFactory.getLogger(Request.class);

    private String airlineCode;
    private Integer flightNumber;
    private String operationalSuffix;
    private String boardPoint;
    private String offPoint;
    private long requestType;
    private Date departureDate;
    private long nJobNumber;
    private String errorMsg;
    private long locResultKey;
    private String flightKey;
    private Long qpKey;
    private Long reqFlightKey;

    private FsQp fsQp;
    private FsData fsData;

    @Override
    public FsQp getFsQp() {
        return fsQp;
    }

    @Override
    public void setFsQp(FsQp fsQp) {
        this.fsQp = fsQp;
    }

    @Override
    public FsData getFsData() {
        return fsData;
    }

    @Override
    public void setFsData(FsData fsData) {
        this.fsData = fsData;
    }

    @Override
    public int getRequestDirection() {
        return REQUEST_DIRECTION_IN;
    }

    public String getAirlineCode() {
        return airlineCode;
    }

    public void setAirlineCode(String airlineCode) {
        this.airlineCode = airlineCode;
    }

    public String getBoardPoint() {
        return boardPoint;
    }

    public void setBoardPoint(String boardPoint) {
        this.boardPoint = boardPoint;
    }

    public Date getDepartureDate() {
        return departureDate;
    }

    public void setDepartureDate(Date departureDate) {
        this.departureDate = departureDate;
    }

    /**
     * test request of flight
     */
    @Override
    public void prepareTestQuery() {
        setAirlineCode("LH");
        setFlightNumber(28);
        setOperationalSuffix(null);
        setBoardPoint("FRA");
        setOffPoint("HAM");
        DateHelper dateHelper = new DateHelper();
        setDepartureDate(dateHelper.parseDate("20.04.08", dateHelper.DATE_FORMAT_0));
    }

    public Integer getFlightNumber() {
        return flightNumber;
    }

    public void setFlightNumber(Integer flightNumber) {
        this.flightNumber = flightNumber;
    }

    public String getOffPoint() {
        return offPoint;
    }

    public void setOffPoint(String offPoint) {
        this.offPoint = offPoint;
    }

    public String getOperationalSuffix() {
        return operationalSuffix;
    }

    public void setOperationalSuffix(String operationalSuffix) {
        this.operationalSuffix = operationalSuffix;
    }

    public long getNJobNumber() {
        return this.nJobNumber;
    }

    public void setNJobNumber(long number) {
        this.nJobNumber = number;
    }


    public String getErrorMsg() {
        return this.errorMsg;
    }


    public void setErrorMsg(String anErrorMsg) {
        this.errorMsg = anErrorMsg;

    }

    public long getRequestType() {
        return requestType;
    }

    public void setRequestType(long requestType) {
        this.requestType = requestType;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + (int) (nJobNumber ^ (nJobNumber >>> 32));
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        final Request other = (Request) obj;
        return nJobNumber == other.nJobNumber;
    }

    public long getResult_Key() {
        return locResultKey;
    }

    public void setResult_Key(long Result_Key) {
        locResultKey = Result_Key;
    }

    public String getFlightKey() {
        return flightKey;
    }

    public void setFlightKey(String flightKey) {
        this.flightKey = flightKey;
    }

    public Long getQpKey() {
        return qpKey;
    }

    public void setQpKey(Long qpKey) {
        this.qpKey = qpKey;
    }

    @Override
    public Long getReqFlightKey() {
        return reqFlightKey;
    }

    @Override
    public void setReqFlightKey(Long reqFlightKey) {
        this.reqFlightKey = reqFlightKey;
    }

    /**
     * Creates the flight query in order to make the request to Amadeus WS
     *
     * @return detail flight information about the passengers
     */
    @Override
    public FlightDetailsQueryType4 createQuery() {
        FlightDetailsQueryType4 theQuery = new FlightDetailsQueryType4();

        OutboundCarrierDetailsTypeI5 crDetails = new OutboundCarrierDetailsTypeI5();
        crDetails.setAirlineCode(getAirlineCode()); // Carrier identification.
        // (Mandatory)
        theQuery.setAirlineInformation(crDetails);

        OutboundFlightNumberDetailstypeI5 fliDetails = new OutboundFlightNumberDetailstypeI5();
        fliDetails.setFlightNumber(getFlightNumber()); // Flight number.
        // (Mandatory)
        String item = getOperationalSuffix();
        if (item != null) {
            fliDetails.setOperationalSuffix(item); // Operational suffix to the
        }
        // carrier code. (Optional)
        theQuery.setFlightReference(fliDetails);
        item = getBoardPoint();
        if (item != null) {
            theQuery.setBoardPoint(item);
        }
        item = getOffPoint(); // Place of departure (Optional)
        if (item != null) {
            theQuery.setOffPoint(item); // Place of destination (Optional)
        }
        theQuery.setDepartureDate(DateHelper.formatDate(getDepartureDate())); // Departure

        return theQuery;
    }

    /**
     * Creates the query to retrieve detail information about the class, seat and smpl
     *
     * @param aYear
     * @param aMonth
     * @param aDay
     * @return detail information about the class and smpl for the list of the passengers for the flight
     */
    @Override
    public PNRListPassengersByFlight createSBRListQuery(String aYear, String aMonth, String aDay, CITPCustomProperties citpCustomProperties) {

        PNRListPassengersByFlight myFlight = new PNRListPassengersByFlight();

        PNRListPassengersByFlight.FlightDateQuery flightDateQuery = new PNRListPassengersByFlight.FlightDateQuery();

        com.dlh.zambas.aws.wbspnr.wrapper.FlightDetailsQueryType4 flightDetailsQueryType4 = new com.dlh.zambas.aws.wbspnr.wrapper.FlightDetailsQueryType4();

        OutboundCarrierDetailsTypeI4 outboundCarrierDetailsTypeI4 = new OutboundCarrierDetailsTypeI4();
        flightDetailsQueryType4.setCarrierDetails(outboundCarrierDetailsTypeI4);

        flightDateQuery.setFlightIdentification(flightDetailsQueryType4);
        myFlight.setFlightDateQuery(flightDateQuery);

        //FDQ
        myFlight.getInitFlightDateQuery().getInitFlightIdentification().getInitCarrierDetails().setMarketingCarrier(getAirlineCode());

        myFlight.getInitFlightDateQuery().getInitFlightIdentification().getInitFlightDetails().setFlightNumber(getFlightNumber());

        //SDI
        myFlight.getInitFlightDateQuery().getInitDateIdentification().setBusinessSemantic("FLD");

        //DATE
        myFlight.getInitFlightDateQuery().getInitDateIdentification().getInitDateTime().setYear(aYear);
        myFlight.getInitFlightDateQuery().getInitDateIdentification().getInitDateTime().setMonth(aMonth);
        myFlight.getInitFlightDateQuery().getInitDateIdentification().getInitDateTime().setDay(aDay);

        PNRListPassengersByFlight.FlightDateQuery.OutputSelectionOption outputSelectionOption = new PNRListPassengersByFlight.FlightDateQuery.OutputSelectionOption();


        myFlight.getInitFlightDateQuery().setOutputSelectionOption(outputSelectionOption);

        //SDT + EMS
        myFlight.getInitFlightDateQuery().getInitOutputSelectionOption().getInitOutputType().getInitSelectionDetails().setOption("IMG");
        ElementManagementSegmentType16 emst1 = new ElementManagementSegmentType16();
        emst1.setSegmentName("SSR");
        ElementManagementSegmentType16 emst2 = new ElementManagementSegmentType16();
        emst2.setSegmentName("SEA");
        myFlight.getInitFlightDateQuery().getInitOutputSelectionOption().getElementType().add(emst1);
        myFlight.getInitFlightDateQuery().getInitOutputSelectionOption().getElementType().add(emst2);

        //SCHC
        myFlight.getInitFlightDateQuery().getInitSearchCriteria(0).getInitPrimarySearchCriterion().getInitSelectionDetails().setOption("SSR");
        myFlight.getInitFlightDateQuery().getInitSearchCriteria(0).getInitNegativeMode().getInitBooleanExpression().setCodeOperator("NOP");
        myFlight.getInitFlightDateQuery().getInitSearchCriteria(0).getInitAssociationMode().getInitBooleanExpression().setCodeOperator("OR");
        myFlight.getInitFlightDateQuery().getInitSearchCriteria(0).getInitSecondarySearchCriteria(0).getInitTriggerMarker();
        myFlight.getInitFlightDateQuery().getInitSearchCriteria(0).getInitSecondarySearchCriteria(0).getInitSsrOsiSkValue().getInitSpecialRequirementsInfo().setServiceType("SSR");
        myFlight.getInitFlightDateQuery().getInitSearchCriteria(0).getInitSecondarySearchCriteria(0).getInitSsrOsiSkValue().getInitSpecialRequirementsInfo().setSsrCode("**ML");

        //KIDS SSR
        myFlight.getInitFlightDateQuery().getInitSearchCriteria(0).addSecondarySearchCriteria(new PNRListPassengersByFlight.FlightDateQuery.SearchCriteria.SecondarySearchCriteria());
        myFlight.getInitFlightDateQuery().getInitSearchCriteria(0).getInitSecondarySearchCriteria(1).getInitTriggerMarker();
        myFlight.getInitFlightDateQuery().getInitSearchCriteria(0).getInitSecondarySearchCriteria(1).getInitSsrOsiSkValue().getInitSpecialRequirementsInfo().setServiceType("SSR");
        myFlight.getInitFlightDateQuery().getInitSearchCriteria(0).getInitSecondarySearchCriteria(1).getInitSsrOsiSkValue().getInitSpecialRequirementsInfo().setSsrCode("CHLD");

        //G. Brosch SEATS SSR, Correction 31.05.2012: Request Seats only if needed!!! Reduce transmitted data
        String acTypes = citpCustomProperties.getAcTypes();
        if (acTypes != null && !acTypes.equalsIgnoreCase("") &&
                Arrays.asList(acTypes.split(",")).contains(getFlightNumber())) {
            LOGGER.info("*** Requesting all seats for " + getFlightNumber() + " ***");
            myFlight.getInitFlightDateQuery().getInitSearchCriteria(0).getInitSecondarySearchCriteria(2).getInitTriggerMarker();
            myFlight.getInitFlightDateQuery().getInitSearchCriteria(0).getInitSecondarySearchCriteria(2).getInitSsrOsiSkValue().getInitSpecialRequirementsInfo().setServiceType("SSR");
            myFlight.getInitFlightDateQuery().getInitSearchCriteria(0).getInitSecondarySearchCriteria(2).getInitSsrOsiSkValue().getInitSpecialRequirementsInfo().setSsrCode("**ST");
        } else {
            LOGGER.info("*** Please no seats for " + getFlightNumber() + " ***");
        }

        // OUTPUT AGGREGATION
        myFlight.getInitFlightDateQuery().getInitOutputAggregationOption(0).getInitAggregationKey().getInitSelectionDetails().setOption("LEG");
        myFlight.getInitFlightDateQuery().getInitOutputAggregationOption(0).getInitAggregationLevel().getInitPosition().setValue(1);
        myFlight.getInitFlightDateQuery().addOutputAggregationOption(new PNRListPassengersByFlight.FlightDateQuery.OutputAggregationOption());
        myFlight.getInitFlightDateQuery().getInitOutputAggregationOption(1).getInitAggregationKey().getInitSelectionDetails().setOption("CAB");
        myFlight.getInitFlightDateQuery().getInitOutputAggregationOption(1).getInitAggregationLevel().getInitPosition().setValue(2);

        return myFlight;
    }
}
