package com.lsgskychefs.cbase.middleware.citp.services;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafuq.CabinClassDesignationType;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafuq.CabinDetailsType;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafuq.DCSFLTSetCateringFigures;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafuq.FlightDetailsResponseType;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafuq.FreeTextDetailsType;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafuq.FreeTextInformationType;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafuq.MealInformationType;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafuq.NumberOfUnitDetailsType;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafuq.NumberOfUnitsType;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafuq.OutboundCarrierDetailsTypeI;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafuq.OutboundFlightNumberDetailstypeI;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafuq.ProductFacilitiesType;
import com.lsgskychefs.cbase.middleware.citp.common.request.RequestOutLogic;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestFlight;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestOutPax;

@Service
public class CateringFiguresService {

	private static final Logger LOGGER = LoggerFactory.getLogger(CateringFiguresService.class);

	private final String FORMAT_PATTERN_DEPARTUREDATE = "yyyyMMdd";
	private final SimpleDateFormat DEP_DATE_FORMATTER = new SimpleDateFormat(FORMAT_PATTERN_DEPARTUREDATE);

	@Autowired
	private CenRequestOutPaxService cenRequestOutPaxService;

	public DCSFLTSetCateringFigures buildSetCateringFiguresRequest(final RequestOutLogic theRequest) {
		if (LOGGER.isTraceEnabled()) {
			LOGGER.trace(String.format("%s.buildSetCateringFiguresRequest(*) BEGIN", this.getClass().getSimpleName()));
		}
		// the resulting object...
		final DCSFLTSetCateringFigures dcsfltSetCateringFigures = new DCSFLTSetCateringFigures();
		// the flight details...
		final FlightDetailsResponseType flightDetailsResponseType = new FlightDetailsResponseType();
		final OutboundCarrierDetailsTypeI outboundCarrierDetailsTypeI = new OutboundCarrierDetailsTypeI();
		outboundCarrierDetailsTypeI.setOperatingCarrier(/* String */theRequest.getAirlineCode());
		flightDetailsResponseType.setCarrierDetails(/* OutboundCarrierDetails */outboundCarrierDetailsTypeI);
		final OutboundFlightNumberDetailstypeI outboundFlightNumberDetailstypeI = new OutboundFlightNumberDetailstypeI();
		outboundFlightNumberDetailstypeI.setFlightNumber(/* String */theRequest.getFlightNumber());
		outboundFlightNumberDetailstypeI.setOperationalSuffix(/* String */theRequest.getOperationalSuffix());
		flightDetailsResponseType.setFlightDetails(/* OutboundFlightNumberDetails */outboundFlightNumberDetailstypeI);
		flightDetailsResponseType.setBoardPoint(/* String */theRequest.getBoardPoint());
		flightDetailsResponseType
				.setDepartureDate(/* String */DEP_DATE_FORMATTER.format(theRequest.getDepartureDate()));
		flightDetailsResponseType.setOffPoint(/* String */theRequest.getOffPoint());
		dcsfltSetCateringFigures.setOperatingFlightDetails(/* FlightDetailsResponse */flightDetailsResponseType);
		// the catering figures...
		dcsfltSetCateringFigures.getCabinCateringFigures().addAll(
				/* SetCateringFiguresRequest_cabinCateringFigures[] */
				createCabinCateringFigures(theRequest));
		// that's it
		if (LOGGER.isTraceEnabled()) {
			LOGGER.trace(String.format("%s.buildSetCateringFiguresRequest(*) END", this.getClass().getSimpleName()));
		}
		return dcsfltSetCateringFigures;
	}

	private List<DCSFLTSetCateringFigures.CabinCateringFigures> createCabinCateringFigures(
			final RequestOutLogic theRequest) {

		final List<DCSFLTSetCateringFigures.CabinCateringFigures> cabinCateringFigures = new ArrayList<>();

		try {

			// 1.) read the cabin data from the CBASE database for the specific job number
			final List<CenRequestOutPax> cateringFiguresObjects = readCateringFigures(theRequest.getNJobNumber());
			// 2.) convert CenRequestOutPax to CabinCateringFigures
			if (!CollectionUtils.isEmpty(cateringFiguresObjects)) {
				for (final CenRequestOutPax cenRequestOutPax : cateringFiguresObjects) {

					cabinCateringFigures.add(convertToCabinCaterignFigures(cenRequestOutPax));
				}
			}

		} catch (final Exception e) {
			LOGGER.error(e.getMessage(), e);
		}

		return cabinCateringFigures;
	}

	private DCSFLTSetCateringFigures.CabinCateringFigures convertToCabinCaterignFigures(
			final CenRequestOutPax cenRequestOutPax) {
		if (LOGGER.isTraceEnabled()) {
			LOGGER.trace(String.format("%s.convert(*) BEGIN", this.getClass().getSimpleName()));
		}

		final DCSFLTSetCateringFigures.CabinCateringFigures cabinCateringFigures = new DCSFLTSetCateringFigures.CabinCateringFigures();

		// the Cabin Class, e.g. First or Business or Economy or ...
		final CabinDetailsType cabinDetailsType = new CabinDetailsType();

		final CabinClassDesignationType cabinClassDesignationType = new CabinClassDesignationType();
		cabinClassDesignationType.setClassDesignator(cenRequestOutPax.getCclass());

		cabinDetailsType.setCabinDetails(cabinClassDesignationType);

		cabinCateringFigures.setCodeOfCabin(cabinDetailsType);

		// Number of PAX per Cabin Class
		if ((RequestOutLogic.FUNCTION_SET_CATERING_FIGURES_PAX_ONLY == cenRequestOutPax.getNfunction())
				|| (RequestOutLogic.FUNCTION_SET_CATERING_FIGURES_PAX_AND_COMMENT == cenRequestOutPax.getNfunction())
				|| (RequestOutLogic.FUNCTION_SET_CATERING_FIGURES_COMMENT_ONLY == cenRequestOutPax.getNfunction()) // necessary,
																													// because
																													// even
																													// with
																													// "comment
																													// only"
																													// the
																													// CabinDetails
																													// are
																													// mandatory!
		) {
			final NumberOfUnitsType numberOfUnitsType = new NumberOfUnitsType();
			final NumberOfUnitDetailsType numberOfUnitDetailsType = new NumberOfUnitDetailsType();
			numberOfUnitDetailsType.setNumberOfUnit(/* Integer */cenRequestOutPax.getNpax());
			numberOfUnitDetailsType
					.setUnitQualifier(/* String */RequestOutLogic.UNIT_QUALIFIER_CATERING_FIGURES); /* "CAT" */
			numberOfUnitsType.getQuantityDetails().add(/* NumberOfUnitDetailsType[] */numberOfUnitDetailsType);
			cabinCateringFigures.setCateringFigures(/* NumberOfUnitsType */numberOfUnitsType);
		}

		// the Comment per Cabin Class
		if ((RequestOutLogic.FUNCTION_SET_CATERING_FIGURES_COMMENT_ONLY == cenRequestOutPax.getNfunction())
				|| (RequestOutLogic.FUNCTION_SET_CATERING_FIGURES_PAX_AND_COMMENT == cenRequestOutPax.getNfunction())) {
			final FreeTextInformationType freeTextInformationType = new FreeTextInformationType();
			final FreeTextDetailsType freeTextDetailsType = new FreeTextDetailsType();
			freeTextDetailsType.setEncoding(
					/* String */RequestOutLogic.FREE_TEXT_INFORMATION_ENCODING); /*
																					 * 1 2 3 4 5 6 7 8 ZZZ, see page 94,
																					 * DCSFLT 06.2
																					 */
			freeTextDetailsType.setSource(
					/* String */RequestOutLogic.FREE_TEXT_INFORMATION_SOURCE); /* A F M S, see page 111, DCSFLT 06.2 */
			freeTextDetailsType.setTextSubjectQualifier(
					/* String */RequestOutLogic.FREE_TEXT_INFORMATION_TEXTSUBJECTQUALIFIER); /*
																								 * 3 1 , see page 118f,
																								 * DCSFLT 06.2
																								 */
			freeTextInformationType.setFreeTextDetails(/* FreeTextDetailsType */freeTextDetailsType);
			final String freeText = cenRequestOutPax.getCcomment(); // (CBASE database limit is 40 chars.) <
																	// (ZR6-Service limit is 70 chars.)
			freeTextInformationType.setFreeText(/* String[] */freeText);
			cabinCateringFigures.setCateringComments(/* FreeTextInformationType */freeTextInformationType);
		}

		if (LOGGER.isTraceEnabled()) {
			LOGGER.trace(String.format("%s.convert(*) END", this.getClass().getSimpleName()));
		}

		final CenRequestFlight cenRequestFlight = new CenRequestFlight();
		cenRequestFlight.setNreqFlightKey(cenRequestOutPax.getCenRequestOut().getNflightNumber());

		final MealInformationType mealInformationType = new MealInformationType();

		final ProductFacilitiesType productFacilitiesType = new ProductFacilitiesType();
		productFacilitiesType.setCode("ML");

		mealInformationType.setMeal(productFacilitiesType);

		cabinCateringFigures.setMealServiceType(mealInformationType);

		return cabinCateringFigures;
	}

	private List<CenRequestOutPax> readCateringFigures(final long nJobNumber) {

		if (LOGGER.isTraceEnabled()) {
			LOGGER.trace(String.format("%s.readCateringFigures(*) BEGIN", this.getClass().getSimpleName()));
		}

		final List<CenRequestOutPax> cenRequestOutPaxes = cenRequestOutPaxService.getCateringFiguresByJobNr(nJobNumber);

		if (LOGGER.isTraceEnabled()) {
			LOGGER.trace(String.format("%s.readCateringFigures(*) END", this.getClass().getSimpleName()));
		}

		return cenRequestOutPaxes;
	}
}
