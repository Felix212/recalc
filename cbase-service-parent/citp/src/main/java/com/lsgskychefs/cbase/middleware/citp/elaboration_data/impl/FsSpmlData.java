package com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl;

import com.dlh.zambas.aws.wbspnr.wrapper.ReferenceInfoType5;
import com.dlh.zambas.aws.wbspnr.wrapper.ReferencingDetailsType45508C;
import com.dlh.zambas.aws.wbspnr.wrapper.ReferencingDetailsType9;
import com.dlh.zambas.aws.wbspnr.wrapper.SpecialRequirementsTypeDetailsTypeI45504C2;
import com.dlh.zambas.aws.wbspnr.wrapper.StructuredBookingRecordImageType2;
import com.dlh.zambas.aws.wbspnr.wrapper.TravellerDetailsTypeI8;
import com.dlh.zambas.aws.wbspnr.wrapper.TravellerInformationTypeI7;
import com.lsgskychefs.cbase.middleware.citp.common.pojo.SpmlObject;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.DataLogic;
import com.lsgskychefs.cbase.middleware.citp.utils.CabinMatcher;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;

/**
 * Representation of a row in the FsSpml
 *
 * @author U185502
 */
public class FsSpmlData implements DataLogic {

    private static final Logger LOGGER = LoggerFactory.getLogger(FsSpmlData.class);

    private Long nreqFlightKey;
    private String flightKey;

    private List<SpmlObject> mySpmls;

    public Long getNreqFlightKey() {
        return nreqFlightKey;
    }

    public String getFlightKey() {
        return flightKey;
    }

    public List<SpmlObject> getMySpmls() {
        return mySpmls;
    }

    public FsSpmlData() {
    }

    /**
     * populates the pojo with values.
     *
     * @param aSsr
     * @param aRef
     * @param aTravellerInfos
     * @param aOrgDes
     * @param aCabin
     * @param aFlightKey
     * @param flightKey
     * @param aIsGroupBooking
     */
    public FsSpmlData(SpecialRequirementsTypeDetailsTypeI45504C2 aSsr, ReferenceInfoType5 aRef,
                      List<StructuredBookingRecordImageType2.TravellerInfo> aTravellerInfos,
                      StructuredBookingRecordImageType2.OriginDestinationDetails aOrgDes,
                      String aCabin, Long aFlightKey, String flightKey, boolean aIsGroupBooking) {

        boolean theMultiPax = false;
        mySpmls = new ArrayList<SpmlObject>();

        this.nreqFlightKey = aFlightKey;
        this.flightKey = flightKey;

        if ((aCabin == null) || (aCabin.equalsIgnoreCase(""))) {
            List<StructuredBookingRecordImageType2.OriginDestinationDetails.ItineraryInfo> theItInfos = aOrgDes.getItineraryInfo();
            aCabin = getCabinFromClassOfService(aCabin, theItInfos, LOGGER);
        }

        List<String> theFreeTexts = aSsr.getFreeText();
        String theText;

        if (theFreeTexts != null) {
            StringBuffer theBuf = new StringBuffer();
            for (String theFreeText : theFreeTexts) {
                theBuf.append(theFreeText);
            }
            if (theBuf.length() > 80) {
                theText = theBuf.substring(0, 80);
            } else {
                theText = theBuf.toString();
            }
        } else {
            theText = null;
        }

        // G. Brosch, 14.01.2013: aRef could be zero, since this is a C field (vgl. TR_SBRList_1 21.pdf S.18
        // referenceForDataElement). This sometimes leads to null pointer exceptions.
        List<ReferencingDetailsType45508C> theRefDetails;
        if (aRef != null) {
            theRefDetails = aRef.getInitReference();
        } else {
            // Otherwise, we refer to an array of length 0. Then, the for loops will not go through!
            // This seems to me the least invasive way to get rid of the problem.
            LOGGER.debug("G. Brosch: Case: aRef = null. Setting reference to empty Vector!");
            theRefDetails = new ArrayList<>();
        }

        int thePaxReferenceCounter = 0;
        if (!aIsGroupBooking) {
            for (ReferencingDetailsType45508C theRefDetail : theRefDetails) {
                if (theRefDetail.getQualifier().equalsIgnoreCase("PT")) {
                    for (StructuredBookingRecordImageType2.TravellerInfo theTravellerInfos : aTravellerInfos) {
                        List<StructuredBookingRecordImageType2.TravellerInfo.PassengerData> theTravellerInfo = theTravellerInfos.getPassengerData();
                        ReferencingDetailsType9 theTravellerDetails = theTravellerInfos.getElementManagementPassenger().getElementReference();
                        if (theRefDetail.getQualifier().equalsIgnoreCase(theTravellerDetails.getQualifier()) &&
                                theRefDetail.getNumber().equalsIgnoreCase(String.valueOf(theTravellerDetails.getNumber()))) {
                            thePaxReferenceCounter++;
                            SpmlObject theSpmlObject = new SpmlObject();
                            theSpmlObject.setCspml(aSsr.getType());
                            theSpmlObject.setCaddText(theText);
                            String theName = "";
                            String theType = null;
                            for (StructuredBookingRecordImageType2.TravellerInfo.PassengerData theInfo : theTravellerInfo) {
                                List<TravellerDetailsTypeI8> theDetails = theInfo.getInitTravellerInformation().getInitPassenger();
                                TravellerInformationTypeI7 theSurnameInfo = theInfo.getInitTravellerInformation();
                                if (theDetails != null && theDetails.size() > 0) {
                                    theType = theDetails.get(0).getType();
                                }
                                if (theType == null || !theType.equalsIgnoreCase("INF")) {
                                    if (theSurnameInfo != null) {
                                        theName = theSurnameInfo.getInitTraveller().getSurname();
                                    }
                                    if (theDetails != null && theDetails.size() > 0) {
                                        theName += ", " + theDetails.get(0).getFirstName();
                                    }
                                }
                            }
                            theMultiPax = true;
                            theSpmlObject.setCname(theName);
                            theSpmlObject.setCclass(aCabin);
                            // 03.02.14, Dirk Bunk: Adaptation / extension for Premium Economy
                            if ("F".equalsIgnoreCase(aCabin)) {
                                theSpmlObject.setNClassNumber(1);
                            } else if ("C".equalsIgnoreCase(aCabin)) {
                                theSpmlObject.setNClassNumber(2);
                            } else if ("E".equalsIgnoreCase(aCabin)) {
                                theSpmlObject.setNClassNumber(3);
                            } else if ("M".equalsIgnoreCase(aCabin)) {
                                theSpmlObject.setNClassNumber(4);
                            }

                            // 12.09.14, Dirk Bunk: Checking for NumberFormatException because the Zambas service sometimes returns the string "null"
                            int theQuantity = 1;
                            try {
                                theQuantity = (aSsr.getQuantity());
                                if (LOGGER.isDebugEnabled()) {
                                    LOGGER.debug("SPML (" + aSsr.getType() + ") in SSR: " + theQuantity);
                                }
                            } catch (NumberFormatException ex) {
                                LOGGER.warn("Caught NumberFormatException when getting Quantity of SPML (" + aSsr.getType() + ") in SSR: " + ex.getMessage(), ex);
                            }
                            theSpmlObject.setNquantity(theQuantity);

                            // G. Brosch, 11.08.2011: implementing of status
                            theSpmlObject.setCStatus(aSsr.getStatus());

                            LOGGER.debug("Flight-Key = " + this.nreqFlightKey + ", SPML-2: Name = " + theSpmlObject.getCname());
                            LOGGER.debug("Flight-Key = " + this.nreqFlightKey + ", SPML-2: Setting status to: " + theSpmlObject.getCStatus());

                            mySpmls.add(theSpmlObject);
                        }
                    }
                }
            }//G. Brosch, 14.01.2013: for all theRefDetail
            if (!theMultiPax) {
                if (aTravellerInfos.size() > 1) {
                    theMultiPax = true;
                }
                for (StructuredBookingRecordImageType2.TravellerInfo theTravellerInfos : aTravellerInfos) {
                    List<StructuredBookingRecordImageType2.TravellerInfo.PassengerData> theTravellerInfo = theTravellerInfos.getPassengerData();
                    SpmlObject theSpmlObject = new SpmlObject();
                    theSpmlObject.setCspml(aSsr.getType());
                    theSpmlObject.setCaddText(theText);

                    String theName = "";
                    String theType = null;
                    for (StructuredBookingRecordImageType2.TravellerInfo.PassengerData theInfo : theTravellerInfo) {
                        List<TravellerDetailsTypeI8> theDetails = theInfo.getInitTravellerInformation().getInitPassenger();
                        TravellerInformationTypeI7 theSurnameInfo = theInfo.getInitTravellerInformation();
                        if (theDetails != null && theDetails.size() > 0) {
                            theType = theDetails.get(0).getType();
                        }
                        if (theType == null || !theType.equalsIgnoreCase("INF")) {
                            if (theSurnameInfo != null) {
                                theName = theSurnameInfo.getInitTraveller().getSurname();
                            }
                            if (null != theDetails && theDetails.size() > 0) {
                                theName += ", " + theDetails.get(0).getFirstName();
                            }
                        }
                    }
                    theSpmlObject.setCname(theName);
                    theSpmlObject.setCclass(aCabin);
                    // 03.02.14, Dirk Bunk: Adaptation / extension for Premium Economy
                    if ("F".equalsIgnoreCase(aCabin)) {
                        theSpmlObject.setNClassNumber(1);
                    } else if ("C".equalsIgnoreCase(aCabin)) {
                        theSpmlObject.setNClassNumber(2);
                    } else if ("E".equalsIgnoreCase(aCabin)) {
                        theSpmlObject.setNClassNumber(3);
                    } else if ("M".equalsIgnoreCase(aCabin)) {
                        theSpmlObject.setNClassNumber(4);
                    }


                    // 26.02.2016: G. Brosch, as with Dirk, also at this point
                    // 12.09.14, Dirk Bunk: Checking for NumberFormatException because the Zambas service sometimes returns the string "null"
                    int theQuantity = 1;
                    try {
                        theQuantity = (aSsr.getQuantity());
                        if (LOGGER.isDebugEnabled()) {
                            LOGGER.debug("SPML (" + aSsr.getType() + ") in SSR: " + theQuantity);
                        }
                    } catch (NumberFormatException ex) {
                        LOGGER.warn("Caught NumberFormatException when getting Quantity of SPML (" + aSsr.getType() + ") in SSR: " + ex.getMessage(), ex);
                    }

                    if (!theMultiPax) {
                        theSpmlObject.setNquantity(Integer.valueOf(theQuantity).intValue());

                    } else {
                        int theQuant = Integer.valueOf(theQuantity).intValue() / aTravellerInfos.size();
                        theSpmlObject.setNquantity(theQuant);
                    }

                    // G. Brosch, 11.08.2011: implementing of status
                    theSpmlObject.setCStatus(aSsr.getStatus());

                    LOGGER.debug("Flight-Key = " + this.nreqFlightKey + ", SPML-4: Name = " + theSpmlObject.getCname());
                    LOGGER.debug("Flight-Key = " + this.nreqFlightKey + ", SPML-4: Setting status to: " + theSpmlObject.getCStatus());

                    mySpmls.add(theSpmlObject);
                }
            } else {
                for (SpmlObject theObj : mySpmls) {
                    int theQuant = theObj.getNquantity();
                    theQuant = theQuant / thePaxReferenceCounter;
                    theObj.setNquantity(theQuant);
                }
            }
        } else { // Is a group Booking

            int theNumberOfGroupMembers = 0;
            boolean theMultiPaxWithRelation = false;
            for (ReferencingDetailsType45508C theRefDetail : theRefDetails) {
                if (theRefDetail.getQualifier().equalsIgnoreCase("PT")) {
                    System.out.println("Detail: " + theRefDetail.getQualifier() + ", " + theRefDetail.getNumber());
                    theNumberOfGroupMembers++;
                    theMultiPaxWithRelation = true;
                }
            }// G. Brosch, 14.01.2013: for all theRefDetail
            if (theNumberOfGroupMembers == 0) {
                for (StructuredBookingRecordImageType2.TravellerInfo theCountTravellerInfos : aTravellerInfos) {
                    if ((theCountTravellerInfos.getElementManagementPassenger() != null) && (theCountTravellerInfos.getElementManagementPassenger().getElementReference() != null)) {

                        String theQualifier = theCountTravellerInfos.getElementManagementPassenger().getElementReference().getQualifier();
                        if ((theQualifier != null) && (theQualifier.equalsIgnoreCase("PT"))) {
                            theNumberOfGroupMembers++;
                        }
                    }
                }
            }

            if (!theMultiPaxWithRelation) {
                for (StructuredBookingRecordImageType2.TravellerInfo theTravellerInfos : aTravellerInfos) {
                    List<StructuredBookingRecordImageType2.TravellerInfo.PassengerData> theTravellerInfo = theTravellerInfos.getPassengerData();
                    if ((theTravellerInfos.getElementManagementPassenger() != null) && (theTravellerInfos.getElementManagementPassenger().getElementReference() != null)) {

                        String theQualifier = theTravellerInfos.getElementManagementPassenger().getElementReference().getQualifier();
                        if ((theQualifier != null) && (theQualifier.equalsIgnoreCase("PT"))) {
                            String theName = "";
                            String theType = null;
                            for (StructuredBookingRecordImageType2.TravellerInfo.PassengerData theInfo : theTravellerInfo) {
                                List<TravellerDetailsTypeI8> theDetails = theInfo.getInitTravellerInformation().getInitPassenger();
                                TravellerInformationTypeI7 theSurnameInfo = theInfo.getInitTravellerInformation();
                                if (theDetails != null && theDetails.size() > 0) {
                                    theType = theDetails.get(0).getType();
                                }
                                if (theType == null || !theType.equalsIgnoreCase("INF")) {
                                    if (theSurnameInfo != null) {
                                        theName = theSurnameInfo.getInitTraveller().getSurname();
                                    }
                                    if (theDetails != null && theDetails.size() > 0) {
                                        theName += ", " + theDetails.get(0).getFirstName();
                                    }
                                }
                            }
                            SpmlObject theSpmlObject = new SpmlObject();
                            theSpmlObject.setCspml(aSsr.getType());
                            theSpmlObject.setCaddText(theText);
                            theSpmlObject.setCname(theName);
                            theSpmlObject.setCclass(aCabin);
                            // 03.02.14, Dirk Bunk: Adaptation / extension for Premium Economy
                            if ("F".equalsIgnoreCase(aCabin)) {
                                theSpmlObject.setNClassNumber(1);
                            } else if ("C".equalsIgnoreCase(aCabin)) {
                                theSpmlObject.setNClassNumber(2);
                            } else if ("E".equalsIgnoreCase(aCabin)) {
                                theSpmlObject.setNClassNumber(3);
                            } else if ("M".equalsIgnoreCase(aCabin)) {
                                theSpmlObject.setNClassNumber(4);
                            }


                            // 12.09.14, Dirk Bunk: Checking for NumberFormatException because the Zambas service sometimes returns the string "null"
                            int theQuantity = 1;
                            try {
                                theQuantity = (aSsr.getQuantity());
                                if (LOGGER.isDebugEnabled()) {
                                    LOGGER.debug("SPML (" + aSsr.getType() + ") in SSR: " + theQuantity);
                                }
                            } catch (NumberFormatException ex) {
                                LOGGER.warn("Caught NumberFormatException when getting Quantity of SPML (" + aSsr.getType() + ") in SSR: " + ex.getMessage(), ex);
                            }

                            if (theNumberOfGroupMembers > 0) {
                                int quant = Integer.valueOf(theQuantity).intValue();
                                quant = quant / theNumberOfGroupMembers;
                                theSpmlObject.setNquantity(quant);
                            } else {
                                theSpmlObject.setNquantity(Integer.valueOf(theQuantity).intValue());
                            }

                            //G. Brosch, 11.08.2011: implementing of status
                            theSpmlObject.setCStatus(aSsr.getStatus());

                            LOGGER.debug("Flight-Key = " + this.nreqFlightKey + ", SPML-3: Name = " + theSpmlObject.getCname());
                            LOGGER.debug("Flight-Key = " + this.nreqFlightKey + ", SPML-3: Setting status to: " + theSpmlObject.getCStatus());

                            mySpmls.add(theSpmlObject);
                        }
                    }
                }
            } else {
                for (ReferencingDetailsType45508C theRefDetail : theRefDetails) {
                    if (theRefDetail.getQualifier().equalsIgnoreCase("PT")) {
                        for (StructuredBookingRecordImageType2.TravellerInfo theTravellerInfos : aTravellerInfos) {
                            List<StructuredBookingRecordImageType2.TravellerInfo.PassengerData> theTravellerInfo = theTravellerInfos.getPassengerData();
                            ReferencingDetailsType9 theTravellerDetails = theTravellerInfos.getElementManagementPassenger().getElementReference();
                            if (theRefDetail.getQualifier().equalsIgnoreCase(theTravellerDetails.getQualifier()) &&
                                    theRefDetail.getNumber().equalsIgnoreCase(String.valueOf(theTravellerDetails.getNumber()))) {

                                SpmlObject theSpmlObject = new SpmlObject();
                                theSpmlObject.setCspml(aSsr.getType());
                                theSpmlObject.setCaddText(theText);
                                String theName = "";
                                String theType = null;
                                for (StructuredBookingRecordImageType2.TravellerInfo.PassengerData theInfo : theTravellerInfo) {
                                    List<TravellerDetailsTypeI8> theDetails = theInfo.getInitTravellerInformation().getInitPassenger();
                                    TravellerInformationTypeI7 theSurnameInfo = theInfo.getInitTravellerInformation();
                                    if (theDetails != null && theDetails.size() > 0) {
                                        theType = theDetails.get(0).getType();
                                    }
                                    if (theType == null || !theType.equalsIgnoreCase("INF")) {
                                        if (theSurnameInfo != null) {
                                            theName = theSurnameInfo.getInitTraveller().getSurname();
                                        }
                                        if (theDetails != null && theDetails.size() > 0) {
                                            theName += ", " + theDetails.get(0).getFirstName();
                                        }
                                    }
                                }
                                theSpmlObject.setCname(theName);
                                theSpmlObject.setCclass(aCabin);
                                // 03.02.14, Dirk Bunk: Adaptation / extension for Premium Economy
                                if ("F".equalsIgnoreCase(aCabin)) {
                                    theSpmlObject.setNClassNumber(1);
                                } else if ("C".equalsIgnoreCase(aCabin)) {
                                    theSpmlObject.setNClassNumber(2);
                                } else if ("E".equalsIgnoreCase(aCabin)) {
                                    theSpmlObject.setNClassNumber(3);
                                } else if ("M".equalsIgnoreCase(aCabin)) {
                                    theSpmlObject.setNClassNumber(4);
                                }


                                // 12.09.14, Dirk Bunk: Checking for NumberFormatException because the Zambas service sometimes returns the string "null"
                                int theQuantity = 1;
                                try {
                                    theQuantity = (aSsr.getQuantity());
                                    if (LOGGER.isDebugEnabled()) {
                                        LOGGER.debug("SPML (" + aSsr.getType() + ") in SSR: " + theQuantity);
                                    }
                                } catch (NumberFormatException ex) {
                                    LOGGER.warn("Caught NumberFormatException when getting Quantity of SPML (" + aSsr.getType() + ") in SSR: " + ex.getMessage(), ex);
                                }

                                if (theNumberOfGroupMembers > 0) {
                                    int quant = Integer.valueOf(theQuantity).intValue();
                                    quant = quant / theNumberOfGroupMembers;
                                    theSpmlObject.setNquantity(quant);
                                } else {
                                    theSpmlObject.setNquantity(Integer.valueOf(theQuantity).intValue());
                                }

                                // G. Brosch, 11.08.2011: implementing of status
                                theSpmlObject.setCStatus(aSsr.getStatus());

                                LOGGER.debug("Flight-Key = " + this.nreqFlightKey + ", SPML-1: Name = " + theSpmlObject.getCname());
                                LOGGER.debug("Flight-Key = " + this.nreqFlightKey + ", SPML-1: Setting status to: " + theSpmlObject.getCStatus());

                                mySpmls.add(theSpmlObject);
                            }
                        }
                    }
                }// G. Brosch, 14.01.2013: for all theRefDetail
            }
        }
    }

    protected static String getCabinFromClassOfService(String aCabin, List<StructuredBookingRecordImageType2.OriginDestinationDetails.ItineraryInfo> theItInfos, Logger logger) {
        String theClassOfService = null;
        for (StructuredBookingRecordImageType2.OriginDestinationDetails.ItineraryInfo theItInfo : theItInfos) {
            if ((theItInfo.getTravelProduct() != null) && (theItInfo.getTravelProduct().getProductDetails() != null)) {
                theClassOfService = theItInfo.getTravelProduct().getProductDetails().getClassOfService();
                aCabin = CabinMatcher.matchCompartment(theClassOfService);

            }
            if (logger.isDebugEnabled()) {
                logger.debug("Matched Class " + theClassOfService + " to Compartment " + aCabin);
            }
        }
        return aCabin;
    }
}
