package com.lsgskychefs.cbase.middleware.citp.common.response.impl;


import com.dlh.zambas.aws.wbsinv.wrapper.InvAdvancedGetFlightDataReply;
import com.dlh.zambas.aws.wbspnr.wrapper.LevelIndicationTypeU;
import com.dlh.zambas.aws.wbspnr.wrapper.PNRListPassengersByFlightReply;
import com.dlh.zambas.aws.wbspnr.wrapper.PositionIdentificationTypeU;
import com.dlh.zambas.aws.wbspnr.wrapper.SelectionDetailsInformationTypeI4;
import com.dlh.zambas.aws.wbspnr.wrapper.SelectionDetailsTypeI3;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.lsgskychefs.cbase.middleware.citp.common.pojo.CounterObject;
import com.lsgskychefs.cbase.middleware.citp.common.pojo.SpmlObject;
import com.lsgskychefs.cbase.middleware.citp.common.pojo.SsrObject;
import com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response.FsQp;
import com.lsgskychefs.cbase.middleware.citp.common.request.RequestLogic;
import com.lsgskychefs.cbase.middleware.citp.common.response.ResponseLogic;
import com.lsgskychefs.cbase.middleware.citp.config.CITPCustomProperties;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.DataFactory;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.DataLogic;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl.DataFactoryLogic;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl.FsData;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl.FsPaxData;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl.FsSpmlData;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl.SeatData;
import com.lsgskychefs.cbase.middleware.citp.utils.DateHelper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Collect the information about the flight detail.
 * Implements the ResponseLogic.
 *
 * @author U185502
 */
public class Response implements ResponseLogic {

    private static final Logger LOGGER = LoggerFactory.getLogger(Response.class);
    // TO BE MOVED TO SOMEWHERE CENTRAL AND USED IN REQUEST.JAVA
    private static final String SORTCRITERIA_1 = "LEG";
    private static final String SORTCRITERIA_2 = "CAB";

    @JsonProperty("flightData")
    private List<FsData> flightData;
    @JsonProperty("fsPaxData")
    private List<FsPaxData> fsPaxData;
    @JsonProperty("fsSpmlData")
    private List<FsSpmlData> fsSpmlData;
    @JsonProperty("seatData")
    private List<SeatData> seatData;
    @JsonProperty("fsQp")
    private FsQp fsQp;
    @JsonProperty("fsData")
    private com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response.FsData fsData;


    private List<CounterObject> myChldCounterObjs;
    private String mySBRListYear;
    private String mySBRListMonth;
    private String mySBRListDay;

    public Response() {
    }

    /**
     * Creates a response Object. Inside it will create a List of
     * <code>DaoLogic</code> Objects which will be used to fill the Database
     * with the information delivered by the
     * <code>ProvideCompleteDataForAFlightResponseMessage</code>
     *
     * @param requestLogic
     * @param flightDataReply
     * @param dataFactory
     */
    public Response(final RequestLogic requestLogic,
                    final InvAdvancedGetFlightDataReply flightDataReply,
                    final DataFactory dataFactory) {

        if (flightDataReply == null) {
            return;
        }

        this.flightData = new ArrayList<FsData>();
        this.fsPaxData = new ArrayList<FsPaxData>();
        this.fsSpmlData = null;
        this.myChldCounterObjs = null;

        // DaoFactoryLogic daoFactory = DaoFactory.getDAOFactory();

        /*
         * For a multilegflight sbrlist retrieval the departure date of the
         * first leg is needed As it is no necessarily available with the flight
         * data it has to be read from the IFLIRR
         */
        String myDepartureDate = flightDataReply.getFlightDateInformation()
                .getFlightDateDesignator().getDepartureDate();
        String myDateFirstLeg = DateHelper.convert(myDepartureDate, "ddMMyy",
                "ddMMyyyy");
        setMySBRListDay(myDateFirstLeg.substring(0, 2));
        setMySBRListMonth(myDateFirstLeg.substring(2, 4));
        setMySBRListYear(myDateFirstLeg.substring(4));

        final List<FsData> flightData = dataFactory.createFlightData(requestLogic, flightDataReply);
        this.flightData.addAll(flightData);
        for (FsData fsData : flightData) {
            final Long nreq_flight_key = fsData.getNreqFlightKey();
            final List<DataLogic> fsPaxDatas = dataFactory.createFsPaxData(
                    requestLogic, flightDataReply, nreq_flight_key);

            this.fsPaxData.addAll(
                    fsPaxDatas.stream().map(fsPaxData -> (FsPaxData)fsPaxData).collect(Collectors.toList())
            );
        }
    }

    @Override
    public FsQp getFsQp() {
        return fsQp;
    }

    @Override
    public void setFsQp(FsQp fsQp) {
        this.fsQp = fsQp;
    }

    @Override
    public com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response.FsData getFsData() {
        return fsData;
    }

    @Override
    public void setFsData(com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response.FsData fsData) {
        this.fsData = fsData;
    }

    public String getMySBRListYear() {
        return mySBRListYear;
    }

    public void setMySBRListYear(String aSBRListYear) {
        this.mySBRListYear = aSBRListYear;
    }

    public String getMySBRListMonth() {
        return mySBRListMonth;
    }

    public void setMySBRListMonth(String aSBRListMonth) {
        this.mySBRListMonth = aSBRListMonth;
    }

    public String getMySBRListDay() {
        return mySBRListDay;
    }

    public void setMySBRListDay(String aSBRListDay) {
        this.mySBRListDay = aSBRListDay;
    }

    @Override
    public void setSBRListData(PNRListPassengersByFlightReply listPassengersByFlightReply,
                               RequestLogic requestLogic, DataFactoryLogic dataFactoryLogic, CITPCustomProperties citpCustomProperties) {

        if (listPassengersByFlightReply == null) {
            return;
        }

        String theSegmentOrigin = "";
        String theSegmentDestination = "";
        String theCabin;
        boolean theSingleLeg = false;
        this.fsSpmlData = new ArrayList<FsSpmlData>();
        this.myChldCounterObjs = new ArrayList<CounterObject>();
        this.seatData = new ArrayList<SeatData>();

        List<PNRListPassengersByFlightReply.AggregatedOutput> theAggregatedOutputs = listPassengersByFlightReply
                .getAggregatedOutput();

        if (null != theAggregatedOutputs) {
            /*
             * Check if just the first leg, the second leg or the entire legs
             * are needed
             */
            for (PNRListPassengersByFlightReply.AggregatedOutput theAggregatedOutput : theAggregatedOutputs) {
                PNRListPassengersByFlightReply.AggregatedOutput.OutputAggregationOption theOutputAggregationOption = theAggregatedOutput
                        .getOutputAggregationOption();
                if (theOutputAggregationOption != null) {
                    SelectionDetailsTypeI3 theAggregationKey = theOutputAggregationOption
                            .getAggregationKey();
                    LevelIndicationTypeU theAggregationLevel = theOutputAggregationOption
                            .getAggregationLevel();
                    if (null != theAggregationKey
                            && null != theAggregationLevel) {
                        SelectionDetailsInformationTypeI4 theSelectionDetails = theAggregationKey
                                .getSelectionDetails();
                        PositionIdentificationTypeU thePosition = theAggregationLevel
                                .getPosition();
                        if (null != theSelectionDetails && null != thePosition) {
                            String theOption = theSelectionDetails.getOption();
                            String theValue = String.valueOf(thePosition.getValue());
                            if (null != theOption && null != theValue) {
                                if (theOption.equalsIgnoreCase(SORTCRITERIA_1)
                                        && theValue.equalsIgnoreCase("1")) {
                                    PNRListPassengersByFlightReply.AggregatedOutput.OutputAggregationOption.AggregationValue theAggregationValue = theOutputAggregationOption
                                            .getAggregationValue();
                                    if (theAggregationValue.getSegmentValue() != null) {
                                        theSegmentDestination = theAggregationValue
                                                .getSegmentValue()
                                                .getDestination();
                                        theSegmentOrigin = theAggregationValue
                                                .getSegmentValue().getOrigin();
                                    } else { // Should not happen, i take everything for the first time
                                        theSingleLeg = false;
                                    }

                                    if (LOGGER.isDebugEnabled()) {
                                        LOGGER.debug("SEGMENT: "
                                                + theSegmentOrigin + " - "
                                                + theSegmentDestination);
                                    }
                                    if ((requestLogic.getBoardPoint()
                                            .equalsIgnoreCase(theSegmentOrigin))
                                            && (requestLogic.getOffPoint()
                                            .equalsIgnoreCase(theSegmentDestination))) {
                                        theSingleLeg = true;
                                        if (LOGGER.isDebugEnabled()) {
                                            LOGGER.debug("Is Single Leg: " + theSingleLeg);
                                        }
                                    }

                                }
                            }
                        }
                    }
                }
            }

            /*
             * Store the adequate data
             */
            boolean theDataToAdd = true;
            for (PNRListPassengersByFlightReply.AggregatedOutput theAggregatedOutput : theAggregatedOutputs) {
                theCabin = "";

                if (theAggregatedOutput.getOutputAggregationOption() != null) {
                    if (theAggregatedOutput.getOutputAggregationOption()
                            .getAggregationKey().getSelectionDetails()
                            .getOption().equalsIgnoreCase(SORTCRITERIA_1)
                            && theAggregatedOutput.getOutputAggregationOption()
                            .getAggregationLevel().getPosition()
                            .getValue().compareTo(1) == 0) {

                        //G.Brosch, 04.06.2012:  SegmentValue ist Conditionales Feld>>>
                        if (theSingleLeg
                                && theAggregatedOutput.getOutputAggregationOption().getAggregationValue().getSegmentValue() != null) {
                            //if (theSingleLeg) {
                            //<<<
                            theSegmentDestination = theAggregatedOutput
                                    .getOutputAggregationOption()
                                    .getAggregationValue().getSegmentValue()
                                    .getDestination();
                            theSegmentOrigin = theAggregatedOutput
                                    .getOutputAggregationOption()
                                    .getAggregationValue().getSegmentValue()
                                    .getOrigin();
                            //G. Brosch, 04.06.2012: Origin, Destination is also conditional >>>
                            if (theSegmentOrigin != null && theSegmentDestination != null) {
                                //<<<
                                if (LOGGER.isDebugEnabled()) {
                                    LOGGER.debug("SEGMENT: " + theSegmentOrigin + " - " + theSegmentDestination);
                                }
                                theDataToAdd = (requestLogic.getBoardPoint().equalsIgnoreCase(theSegmentOrigin))
                                        && (requestLogic.getOffPoint()
                                        .equalsIgnoreCase(theSegmentDestination));
                            }//
                        } else {
                            theDataToAdd = true;
                        }
                    } else {
                        if (theAggregatedOutput.getOutputAggregationOption()
                                .getAggregationKey().getSelectionDetails()
                                .getOption().equalsIgnoreCase(SORTCRITERIA_2)
                                && theAggregatedOutput
                                .getOutputAggregationOption()
                                .getAggregationLevel().getPosition()
                                .getValue().compareTo(2) == 0) {
                            if ((theAggregatedOutput
                                    .getOutputAggregationOption()
                                    .getAggregationValue() != null)
                                    && (theAggregatedOutput
                                    .getOutputAggregationOption()
                                    .getAggregationValue()
                                    .getCabinValue() != null)) {
                                theCabin = theAggregatedOutput
                                        .getOutputAggregationOption()
                                        .getAggregationValue().getCabinValue()
                                        .getCabinCode();
                            }
                        }
                    }

                    if (LOGGER.isDebugEnabled()) {
                        LOGGER.debug("CABIN is: " + theCabin);
                    }
                    if (theDataToAdd) {
                        if (LOGGER.isDebugEnabled()) {
                            LOGGER.debug(" Added Data For : " + theSegmentOrigin
                                    + ", " + theSegmentDestination
                                    + ", Class: " + theCabin);
                        }

                        Long theFlightKey = null;
                        //G. Brosch, 08.03.2012: also need the ACTYPE >>>
                        String theAcType = null;

                        for (DataLogic dataLogic : flightData) {
                            if (theSegmentOrigin != null && theSegmentDestination != null &&
                                    theSegmentOrigin
                                            .equalsIgnoreCase(((FsData) dataLogic)
                                                    .getCtlcFrom())
                                    && theSegmentDestination
                                    .equalsIgnoreCase(((FsData) dataLogic)
                                            .getCtlcTo())) {
                                theFlightKey = ((FsData) dataLogic)
                                        .getNreqFlightKey();

                                //G. Brosch, 08.03.2012: also need the ACTYPE >>>
                                theAcType = ((FsData) dataLogic).getCacType();

                                break;
                            }
                        }

                        List<PNRListPassengersByFlightReply.AggregatedOutput.PnrViews> thePNRViews = theAggregatedOutput
                                .getPnrViews();
                        if ((thePNRViews != null) && (theFlightKey != null)) {
                            SsrObject theSsrObject = dataFactoryLogic.createSpmlData(
                                    thePNRViews, theCabin, theFlightKey, requestLogic.getFlightKey());
                            this.fsSpmlData.addAll(
                                    theSsrObject.getMySpmls().stream().map(ssrObject -> (FsSpmlData)ssrObject).collect(Collectors.toList())

                            );
                            this.myChldCounterObjs.add(theSsrObject
                                    .getMyChlds());
                        }

                        //6.3.2012, G. Brosch: Seats only at the ACTYPEs in the citpCustomProperties >>>
                        // TODO
                        String acTypes = citpCustomProperties.getAcTypes();
                        if (acTypes != null && !acTypes.equalsIgnoreCase("") &&
                                Arrays.asList(acTypes.split(",")).contains(theAcType)) {
                            LOGGER.info("*** READING ALL SEATS FOR " + theAcType + " ***");

                            if ((thePNRViews != null) && (theFlightKey != null)) {
                                SsrObject theSsrObject = dataFactoryLogic.createSeatData(thePNRViews, theFlightKey);
                                this.seatData.addAll(
                                        theSsrObject.getMySeats().stream().map(seatObject -> (SeatData)seatObject).collect(Collectors.toList())
                                );
                            }
                        } else {
                            LOGGER.info("*** NO SEATS FOR " + theAcType + " ***");
                        }

                    }//there are DataToADD
                }
            }//foreach theAggregatedOutput

            setPaxAndChildCounter();

        }//theAggregatedOutputs != null
    }

    private void setPaxAndChildCounter() {
        Long theFlightKey;
        for (DataLogic flightData : flightData) {
            theFlightKey = ((FsData) flightData).getNreqFlightKey();
            CounterObject theSpmlCounterObject = countAllSpmls(theFlightKey);
            CounterObject theChldCounterObject = countAllChld(theFlightKey);

            for (DataLogic theFsPaxData : fsPaxData) {
                if (((FsPaxData) theFsPaxData).getQpKey().equals(theFlightKey) ||
                        (((FsPaxData) theFsPaxData).getQpKey() == null && theFlightKey == null)) {
                    switch (((FsPaxData) theFsPaxData).getNclassNumber()) {
                        case 1:
                            ((FsPaxData) theFsPaxData).setNchild(theChldCounterObject.getFirstClassCounter());

                            ((FsPaxData) theFsPaxData).setNspml(theSpmlCounterObject.getFirstClassCounter());
                            break;
                        case 2:
                            ((FsPaxData) theFsPaxData).setNchild(theChldCounterObject.getBizClassCounter());

                            ((FsPaxData) theFsPaxData).setNspml(theSpmlCounterObject.getBizClassCounter());
                            break;
                        // 03.02.14, Dirk Bunk: Anpassung/Erweiterung für Premium Economy
                        case 3:
                            ((FsPaxData) theFsPaxData).setNchild(theChldCounterObject.getPremiumEcoClassCounter());

                            ((FsPaxData) theFsPaxData).setNspml(theSpmlCounterObject.getPremiumEcoClassCounter());
                            break;
                        case 4:
                            ((FsPaxData) theFsPaxData).setNchild(theChldCounterObject.getEcoClassCounter());

                            ((FsPaxData) theFsPaxData).setNspml(theSpmlCounterObject.getEcoClassCounter());
                            break;
                        default:
                            break;
                    }
                }
            }
        }
    }

    private CounterObject countAllSpmls(Long aFlightKey) {
        CounterObject theCounterObj = new CounterObject();

        for (DataLogic dataLogic : this.fsSpmlData) {
            if (((FsSpmlData) dataLogic).getNreqFlightKey().equals(aFlightKey)) {
                List<SpmlObject> theSpmls = ((FsSpmlData) dataLogic).getMySpmls();
                for (SpmlObject theSpml : theSpmls) {
                    switch (theSpml.getNClassNumber()) {
                        case 1:
                            theCounterObj.incrementMyFirstClassCounter();
                            break;
                        case 2:
                            theCounterObj.incrementMyBizClassCounter();
                            break;
                        // 03.02.14, Dirk Bunk: Anpassung/Erweiterung für Premium Economy
                        case 3:
                            theCounterObj.incrementMyPremiumEcoClassCounter();
                            break;
                        case 4:
                            theCounterObj.incrementMyEcoClassCounter();
                            break;
                        default:
                            break;
                    }
                }
            }
        }

        return theCounterObj;
    }

    private CounterObject countAllChld(Long aFlightKey) {
        CounterObject theCounterObj = new CounterObject();

        for (CounterObject theObj : this.myChldCounterObjs) {
            if (theObj.getFlightKey().equals(aFlightKey)) {
                if (LOGGER.isDebugEnabled()) {
                    // 03.02.14, Dirk Bunk: Anpassung/Erweiterung für Premium Economy
                    LOGGER.debug("Adding to Counter: "
                            + theObj.getFirstClassCounter() + ", "
                            + theObj.getBizClassCounter() + ", "
                            + theObj.getPremiumEcoClassCounter() + ", "
                            + theObj.getEcoClassCounter());
                }
                // 03.02.14, Dirk Bunk: Anpassung/Erweiterung für Premium Economy
                theCounterObj.addToAllCounters(theObj.getFirstClassCounter(),
                        theObj.getBizClassCounter(),
                        theObj.getPremiumEcoClassCounter(),
                        theObj.getEcoClassCounter());
            }
        }
        return theCounterObj;
    }

    public List<FsData> getFlightData() {
        return flightData;
    }

    public List<FsPaxData> getFsPaxData() {
        return fsPaxData;
    }

    public List<FsSpmlData> getFsSpmlData() {
        return fsSpmlData;
    }

    public List<SeatData> getSeatData() {
        return seatData;
    }
}
