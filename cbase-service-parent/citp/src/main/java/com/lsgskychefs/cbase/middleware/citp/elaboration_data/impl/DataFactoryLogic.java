package com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.dlh.zambas.aws.wbsinv.wrapper.InvAdvancedGetFlightDataReply;
import com.dlh.zambas.aws.wbspnr.wrapper.CodedAttributeInformationType4;
import com.dlh.zambas.aws.wbspnr.wrapper.ElementManagementSegmentType9;
import com.dlh.zambas.aws.wbspnr.wrapper.PNRListPassengersByFlightReply;
import com.dlh.zambas.aws.wbspnr.wrapper.ReferencingDetailsType9;
import com.dlh.zambas.aws.wbspnr.wrapper.SeatEntityType2;
import com.dlh.zambas.aws.wbspnr.wrapper.StructuredBookingRecordImageType2;
import com.dlh.zambas.aws.wbspnr.wrapper.TravellerDetailsTypeI8;
import com.dlh.zambas.aws.wbspnr.wrapper.TravellerInformationTypeI7;
import com.dlh.zambas.aws.wbspnr.wrapper.TravellerSurnameInformationTypeI8;
import com.lsgskychefs.cbase.middleware.citp.common.pojo.CounterObject;
import com.lsgskychefs.cbase.middleware.citp.common.pojo.SeatObject;
import com.lsgskychefs.cbase.middleware.citp.common.pojo.SsrObject;
import com.lsgskychefs.cbase.middleware.citp.common.request.RequestLogic;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.DataFactory;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.DataLogic;

/**
 * Converting Fight data information form Amadeus to LH Business logic data
 * information
 *
 * @author U185502
 */
public final class DataFactoryLogic implements DataFactory {

	private static final Logger LOGGER = LoggerFactory.getLogger(DataFactoryLogic.class);

	public DataFactoryLogic() {
	}

	/**
	 * Collection information about the flight
	 *
	 * @param myRequest the id of the current row in the table cen_request.
	 * @param res       CITP response.
	 * @return list of {@link FsData}
	 */
	@Override
	public List<FsData> createFlightData(final RequestLogic myRequest, final InvAdvancedGetFlightDataReply res) {

		final List<InvAdvancedGetFlightDataReply.FlightDateInformation.Legs> legs = res.getFlightDateInformation()
				.getLegs();

		boolean theAddAll = true;
		int theCounter = -1;

		for (final InvAdvancedGetFlightDataReply.FlightDateInformation.Legs leg : legs) {
			theCounter++;
			if ((leg.getLeg() != null) && (leg.getLeg().getInitLegDetails() != null)) {
				final String theOrigin = leg.getLeg().getInitLegDetails().getLocations().get(0);
				final String theDestination = leg.getLeg().getInitLegDetails().getLocations().get(1);
				if ((theOrigin != null) && (theOrigin.equalsIgnoreCase(myRequest.getBoardPoint())
						&& (theDestination != null) && (theDestination.equalsIgnoreCase(myRequest.getOffPoint())))) {
					theAddAll = false;
					break;
				}
			}
		}

		final List<FsData> retList = new ArrayList<FsData>();

		if (!theAddAll) {
			final InvAdvancedGetFlightDataReply.FlightDateInformation.Legs leg = legs.get(theCounter);
			final FsData flightDao = new FsData(res.getFlightDateInformation().getFlightDateDesignator(), leg,
					myRequest);
			retList.add(flightDao);
		} else {
			for (final InvAdvancedGetFlightDataReply.FlightDateInformation.Legs leg : legs) {
				final FsData flightDao = new FsData(res.getFlightDateInformation().getFlightDateDesignator(), leg,
						myRequest);
				retList.add(flightDao);
			}
		}

		return retList;
	}

	/**
	 * Converter method of data retrieved by Amadeus
	 *
	 * @param myRequest     the id of the current row in the table cen_request.
	 * @param res           CITP response.
	 * @param nreqFlightKey the reference / foreign key to the table flight.
	 * @return list of passenger data
	 */
	@Override
	public List<DataLogic> createFsPaxData(final RequestLogic myRequest, final InvAdvancedGetFlightDataReply res,
			final Long nreqFlightKey) {

		final List<InvAdvancedGetFlightDataReply.FlightDateInformation.Legs> legs = res.getFlightDateInformation()
				.getLegs();

		boolean theAddAll = true;
		int theCounter = -1;
		for (final InvAdvancedGetFlightDataReply.FlightDateInformation.Legs leg : legs) {
			theCounter++;
			if ((leg.getLeg() != null) && (leg.getLeg().getLegDetails() != null)) {
				final String theOrigin = leg.getLeg().getLegDetails().getInitLocations().get(0);
				final String theDestination = leg.getLeg().getLegDetails().getInitLocations().get(1);
				if ((theOrigin != null) && (theOrigin.equalsIgnoreCase(myRequest.getBoardPoint())
						&& (theDestination != null) && (theDestination.equalsIgnoreCase(myRequest.getOffPoint())))) {
					theAddAll = false;
					break;
				}
			}
		}
		final List<DataLogic> retList = new ArrayList<DataLogic>();

		if (!theAddAll) {
			final InvAdvancedGetFlightDataReply.FlightDateInformation.Legs leg = legs.get(theCounter);
			final List<InvAdvancedGetFlightDataReply.FlightDateInformation.Legs.LegCabins> cabins = leg.getLegCabins();
			for (final InvAdvancedGetFlightDataReply.FlightDateInformation.Legs.LegCabins legCabin : cabins) {
				final FsPaxData paxDao = new FsPaxData(legCabin, myRequest);
				retList.add(paxDao);
			}
		} else {
			for (final InvAdvancedGetFlightDataReply.FlightDateInformation.Legs leg : legs) {
				final List<InvAdvancedGetFlightDataReply.FlightDateInformation.Legs.LegCabins> cabins = leg
						.getLegCabins();
				for (final InvAdvancedGetFlightDataReply.FlightDateInformation.Legs.LegCabins legCabin : cabins) {
					final FsPaxData fsPaxData = new FsPaxData(legCabin, myRequest);
					retList.add(fsPaxData);
				}
			}
		}

		return retList;
	}

	/**
	 * Creates Ssr object to collect the Spml information
	 *
	 * @param aPNRViews
	 * @param aCabin
	 * @param aFlightKey
	 * @param flightKey
	 * @return
	 */
	@Override
	public SsrObject createSpmlData(final List<PNRListPassengersByFlightReply.AggregatedOutput.PnrViews> aPNRViews,
			final String aCabin, final Long aFlightKey, final String flightKey) {

		final List<DataLogic> theRetList = new ArrayList<DataLogic>();
		final SsrObject theSsrObject = new SsrObject();
		final CounterObject theCounterObject = new CounterObject();
		theCounterObject.setFlightKey(aFlightKey);
		boolean theIsGroupBooking = false;

		for (final PNRListPassengersByFlightReply.AggregatedOutput.PnrViews thePNRView : aPNRViews) {
			if (thePNRView.getPnrView() != null) {
				/*
				 * Check if PNR is a group booking as handling has to be different
				 */
				if (thePNRView.getPnrView().getDataElementsMaster().getDataElementsIndiv() != null) {
					if ((thePNRView.getPnrView().getPnrHeader() != null)
							&& (thePNRView.getPnrView().getPnrHeader().getSbrAttributes() != null)
							&& (thePNRView.getInitPnrView().getPnrHeader().getSbrAttributes()
									.getAttributeDetails() != null)) {
						final List<CodedAttributeInformationType4> theAttrs = thePNRView.getPnrView().getPnrHeader()
								.getSbrAttributes().getAttributeDetails();
						for (final CodedAttributeInformationType4 theAttr : theAttrs) {
							final String theAttrType = theAttr.getAttributeType();
							if ((theAttrType != null) && (theAttrType.equalsIgnoreCase("GRP"))) {
								theIsGroupBooking = true;
							}
						}
					}
				} else {
					theIsGroupBooking = false;
				}

				if (thePNRView.getPnrView().getDataElementsMaster().getDataElementsIndiv() != null) {
					final List<StructuredBookingRecordImageType2.DataElementsMaster.DataElementsIndiv> thePnrData = thePNRView
							.getPnrView().getDataElementsMaster().getDataElementsIndiv();
					for (final StructuredBookingRecordImageType2.DataElementsMaster.DataElementsIndiv theData : thePnrData) {
						if (theData.getServiceRequest().getSsr() != null) {
							if (theData.getServiceRequest().getSsr().getType().endsWith("ML")
									&& (theData.getServiceRequest().getSsr().getCompanyId() != null)
									// avoid missing SPMLs
									&& (theData.getServiceRequest().getSsr().getStatus() != null)
									&& (theData.getServiceRequest().getSsr().getStatus().equalsIgnoreCase("HK")
											|| theData.getServiceRequest().getSsr().getStatus()
													.equalsIgnoreCase("KK"))) {

								if (LOGGER.isDebugEnabled()) {
									LOGGER.debug("==> MEAL: " + theData.getServiceRequest().getSsr().getType() + ", "
											+ theData.getServiceRequest().getSsr().getQuantity() + ", "
											+ theData.getServiceRequest().getSsr().getStatus());
								}

								final FsSpmlData spmlDao = new FsSpmlData(theData.getServiceRequest().getSsr(),
										theData.getReferenceForDataElement(),
										thePNRView.getPnrView().getTravellerInfo(),
										thePNRView.getPnrView().getOriginDestinationDetails(), aCabin, aFlightKey,
										flightKey, theIsGroupBooking);
								theRetList.add(spmlDao);

							} else {
								String theCabin = "";
								if (theData.getServiceRequest().getSsr().getType().equalsIgnoreCase("CHLD")
										&& (theData.getServiceRequest().getSsr().getCompanyId() != null)
								// avoid missing CHILDs
								) {
									if ((aCabin == null) || (aCabin.equalsIgnoreCase(""))) {
										final List<StructuredBookingRecordImageType2.OriginDestinationDetails.ItineraryInfo> theItInfos = thePNRView
												.getPnrView().getOriginDestinationDetails().getItineraryInfo();
										theCabin = FsSpmlData.getCabinFromClassOfService(theCabin, theItInfos, LOGGER);
									} else {
										theCabin = aCabin;
									}

									// 12.09.14, Dirk Bunk: Checking for NumberFormatException because the Zambas
									// service sometimes returns the string "null"
									int theQuantity = 1;
									try {
										theQuantity = theData.getServiceRequest().getSsr().getQuantity();
										if (LOGGER.isDebugEnabled()) {
											LOGGER.debug("KIDS in SSR: " + theQuantity);
										}
									} catch (final NumberFormatException ex) {
										LOGGER.warn(
												"Caught NumberFormatException when getting Quantity of KIDS in SSR: "
														+ ex.getMessage(),
												ex);
									}

									if (theCabin.equalsIgnoreCase("M")) {
										for (int i = 0; i < theQuantity; i++) {
											theCounterObject.incrementMyEcoClassCounter();
										}
									} else if (theCabin.equalsIgnoreCase("E")) {
										for (int i = 0; i < theQuantity; i++) {
											theCounterObject.incrementMyPremiumEcoClassCounter();
										}
									} else if (theCabin.equalsIgnoreCase("C")) {
										for (int i = 0; i < theQuantity; i++) {
											theCounterObject.incrementMyBizClassCounter();
										}
									} else if (theCabin.equalsIgnoreCase("F")) {
										for (int i = 0; i < theQuantity; i++) {
											theCounterObject.incrementMyFirstClassCounter();
										}
									}

								}
							}
						} // if there exists ssr's (G. Brosch, 04.07.2011)
					} // for all dataElementsIndiv (G. Brosch, 04.07.2011)
				}
			}
		}
		theSsrObject.setMySpmls(theRetList);
		theSsrObject.setMyChlds(theCounterObject);
		return theSsrObject;
	}

	/**
	 * Creates Ssr object to collect the Seat information
	 *
	 * @param aPNRViews
	 * @param aFlightKey
	 * @return
	 */
	@Override
	public SsrObject createSeatData(final List<PNRListPassengersByFlightReply.AggregatedOutput.PnrViews> aPNRViews,
			final Long aFlightKey) {

		final List<DataLogic> theRetList = new ArrayList<DataLogic>();
		final SsrObject theSsrObject = new SsrObject();
		final SeatData seatData = new SeatData(aFlightKey);

		if (aPNRViews != null) {
			for (final PNRListPassengersByFlightReply.AggregatedOutput.PnrViews thePnrView : aPNRViews) {
				final StructuredBookingRecordImageType2 theBooking = thePnrView.getPnrView();
				final List<StructuredBookingRecordImageType2.DataElementsMaster.DataElementsStruct> theSeatElements = theBooking
						.getDataElementsMaster().getDataElementsStruct();

				if (theSeatElements != null) {
					for (final StructuredBookingRecordImageType2.DataElementsMaster.DataElementsStruct theSeatElement : theSeatElements) {

						if (theSeatElement.getSeatData() != null) {
							final List<SeatEntityType2.IndividualSeatGroup> theSeatRequestParameters = theSeatElement
									.getSeatData().getIndividualSeatGroup();

							if (theSeatRequestParameters != null) {

								for (final SeatEntityType2.IndividualSeatGroup theSeatRequestParameter : theSeatRequestParameters) {
									final Integer seatRow = theSeatRequestParameter.getSeatPassenger()
											.getRangeOfRowsDetails().getSeatRowNumber();
									final String refNumberPassenger = theSeatRequestParameter.getSeatPassenger()
											.getReferenceNumber();

									final List<String> theSeatColumns = theSeatRequestParameter.getSeatPassenger()
											.getRangeOfRowsDetails().getSeatColumn();

									if (theSeatColumns != null) {
										for (final String theSeatColumn : theSeatColumns) {

											// Lookup the Passenger name
											final String theName = lookupPassenger(refNumberPassenger, theBooking);
											LOGGER.info("*** [" + seatRow + theSeatColumn + ": " + theName + "]");
											seatData.add(new SeatObject(seatRow, theSeatColumn, theName));
										}
									}
								} // foreach theSeatRequestParameter
							} // theSeatRequestParameters != null
						} // getSeatData() != null
					} // foreach theSeatElement
				} // getSeatElements() != null
			} // foreach theBooking
		} // thePNRViews != null

		theRetList.add(seatData);
		theSsrObject.setMySeats(theRetList);

		return theSsrObject;
	}

	/**
	 * Construct the full name of passanger based on the information of the flight
	 *
	 * @param aReferenceNumber
	 * @param aPnrView
	 * @return
	 */
	private String lookupPassenger(final String aReferenceNumber, final StructuredBookingRecordImageType2 aPnrView) {

		boolean bRecordFound = false;
		String theSurname = "";
		String theFirstName = "";

		StructuredBookingRecordImageType2.TravellerInfo theTravellerInfo1 = null;
		final List<StructuredBookingRecordImageType2.TravellerInfo> travellerInfos = aPnrView.getTravellerInfo();

		if (travellerInfos != null) {

			for (final StructuredBookingRecordImageType2.TravellerInfo theTravellerInfo : travellerInfos) {
				final ElementManagementSegmentType9 theElementManagementPassenger = theTravellerInfo
						.getInitElementManagementPassenger();

				final ReferencingDetailsType9 theElementReference = theElementManagementPassenger.getElementReference();

				if (theElementReference != null) {
					if (theElementReference.getQualifier().equalsIgnoreCase("PT")
							&& theElementReference.getNumber().compareTo(Integer.valueOf(aReferenceNumber)) == 0) {
						// Haben den TravellerInfo-Record gefunden. Jetzt Namen lesen...
						theTravellerInfo1 = theTravellerInfo;
						bRecordFound = true;
						break;
					}
				}
			}
		}

		if (travellerInfos != null && bRecordFound) {

			final List<TravellerInformationTypeI7> theTravellerInformations = theTravellerInfo1.getInitPassengerData()
					.stream().map(passengerData -> passengerData.getTravellerInformation())
					.collect(Collectors.toList());

			for (final TravellerInformationTypeI7 theTravellerInformation : theTravellerInformations) {
				final TravellerSurnameInformationTypeI8 theTraveller = theTravellerInformation.getTraveller();

				if (theTraveller != null) {
					theSurname = theTraveller.getSurname();
					// LOGGER.info("theSurname = " + theSurname);
				}

				final List<TravellerDetailsTypeI8> thePassengers = theTravellerInformation.getPassenger();

				if (thePassengers != null) {

					for (final TravellerDetailsTypeI8 thePassenger : thePassengers) {
						if (thePassenger.getInfantIndicator() == null || (thePassenger.getInfantIndicator() != null
								&& !thePassenger.getInfantIndicator().equals(1))) {

							theFirstName = thePassenger.getFirstName();
						} else {
							LOGGER.info("=========> GOT CHLD: theFirstName = " + theFirstName + "****<=========");
						}
					}
				}
			}
		} else {
			LOGGER.info("************ ...Could NOT Found Record! ***");
		}
		return theSurname + ", " + theFirstName;
	}
}
