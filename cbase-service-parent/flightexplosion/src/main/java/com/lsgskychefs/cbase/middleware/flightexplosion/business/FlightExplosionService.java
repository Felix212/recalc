/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.flightexplosion.business;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.*;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StopWatch;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseMiddlewareService;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.common.persistence.constant.CbaseReckoningType;
import com.lsgskychefs.cbase.middleware.common.profile.business.ProfileService;
import com.lsgskychefs.cbase.middleware.flightexplosion.persistence.FlightExplosionRepository;
import com.lsgskychefs.cbase.middleware.flightexplosion.pojo.FlightLoadingEntry;
import com.lsgskychefs.cbase.middleware.flightexplosion.pojo.PackinglistExplosionDetailEntry;
import com.lsgskychefs.cbase.middleware.flightexplosion.pojo.PackinglistExplosionDetailParameter;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenAirlineAccounts;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenClassName;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOut;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutAddDelivery;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutHandling;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMaster;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMeals;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutSpmlDetail;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglists;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistsId;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocPlTimeFrame;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocPlTimeFrameFlight;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitPlAreas;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitPlReserve;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitPpmValidities;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysPackinglistKinds;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysProductCategory;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysUnits;
import com.lsgskychefs.cbase.middleware.persistence.general.CenAirlineAccountsRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenClassNameRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutAddDeliveryRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutHandlingRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutMasterRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutMealsRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutSpmlDetailRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenPackinglistsRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.LocPlTimeFrameFlightRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.LocPlTimeFrameRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.LocUnitPlAreasRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.LocUnitPlReserveRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.SysPackinglistKindsRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.SysProductCategoryRepository;
import com.lsgskychefs.cbase.middleware.persistence.utils.CbaseSequence;

/**
 * Service class for the flight explosion.
 *
 * @author Dirk Bunk - U200035
 */
@Service
public class FlightExplosionService extends AbstractCbaseMiddlewareService {
	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(FlightExplosionService.class);

	/** The profile section */
	private static final String SECTION = "OnlineExplosion";

	/** Repository for {@link CenOut} entity. */
	@Autowired
	private CenOutRepository cenOutRepository;

	/** Repository for {@link CenPackinglists} entity. */
	@Autowired
	private CenPackinglistsRepository cenPackinglistsRepository;

	/** Repository for {@link CenOutMeals} entity. */
	@Autowired
	private CenOutMealsRepository cenOutMealsRepository;

	/** Repository for {@link CenOutSpmlDetail} entity. */
	@Autowired
	private CenOutSpmlDetailRepository cenOutSpmlDetailRepository;

	/** Repository for {@link CenOutMaster} entity. */
	@Autowired
	private CenOutMasterRepository cenOutMasterRepository;

	/** Repository for {@link CenClassName} entity. */
	@Autowired
	private CenClassNameRepository cenClassNameRepository;

	/** Repository for {@link CenAirlineAccounts} entity. */
	@Autowired
	private CenAirlineAccountsRepository cenAirlineAccountsRepository;

	/** Repository for {@link CenOutAddDelivery} entity. */
	@Autowired
	private CenOutAddDeliveryRepository cenOutAddDeliveryRepository;

	/** Repository for {@link CenOutHandling} */
	@Autowired
	private CenOutHandlingRepository cenOutHandlingRepository;

	/** Repository for {@link LocUnitPlAreas} entity. */
	@Autowired
	private LocUnitPlAreasRepository locUnitPlAreasRepository;

	/** Repository for {@link LocUnitPlReserve} entity. */
	@Autowired
	private LocUnitPlReserveRepository locUnitPlReserveRepository;

	/** Repository for {@link LocPlTimeFrame} entity. */
	@Autowired
	private LocPlTimeFrameRepository locPlTimeFrameRepository;

	/** Repository for {@link LocPlTimeFrameFlight} entity. */
	@Autowired
	private LocPlTimeFrameFlightRepository locPlTimeFrameFlightRepository;

	/** Repository for {@link SysPackinglistKinds} entity. */
	@Autowired
	private SysPackinglistKindsRepository sysPackinglistKindsRepository;

	/** Repository for {@link SysProductCategory} entity. */
	@Autowired
	private SysProductCategoryRepository sysProductCategoryRepository;

	/** Flight Explosion repository. */
	@Autowired
	private FlightExplosionRepository flightExplosionRepository;

	/** Profile service */
	@Autowired
	private ProfileService profileService;

	/** Storage for previous Sap Codes (Key = airlineKey + Account) */
	private final Map<String, String> sapCodes = new HashMap<>();

	/** Storage for profile values (Key = profileKey) */
	private final Map<String, String> profileValues = new HashMap<>();

	/** The iso offset (in days) */
	private int isoOffset;

	private static final String PROFILE_NO_0_FOR_CX_FLIGHTS = "DoNotSet0ForCxFlights";

	private static final String PROFILE_GROUP_PL_BY_SSL = "GroupPlBySslZblAc2";

	private static final String PROFILE_WITH_BILLING_ONLY = "WithBillingOnly";

	/**
	 * Explodes one specific flight and stores the results in cen_out_master (if needed)
	 *
	 * @param resultKey the key of the flight to explode
	 * @param isGetNewDetailKey set to <code>true</code> to get a new value for plDetailKey
	 * @throws CbaseMiddlewareBusinessException
	 */
	public void explodeFlight(final Long resultKey, final boolean isGetNewDetailKey)
			throws CbaseMiddlewareBusinessException {
		final StopWatch watch = new StopWatch("Explode Flight");
		final List<CenOutMaster> cenOutMasterEntries = new ArrayList<>();
		final Optional<CenOut> flight = cenOutRepository.findById(resultKey);
		final List<Long> cenOutMasterSequences = new ArrayList<>();

		if (!flight.isPresent()) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.UNKNOWN_ID,
					String.format("Could not find flight for nresultKey = %s!", resultKey));
		}

		final boolean isCnxFlag = flight.get().getNflightStatus() == 1;
		final boolean isDoNotSet0ForCxFlights = getProfileFlag(PROFILE_NO_0_FOR_CX_FLIGHTS);

		// Set up additional logging properties for Graylog
		if (flight.isPresent()) {
			MDC.put("flight", flight.get().getCflightKey());
			MDC.put("resultkey", String.valueOf(flight.get().getNresultKey()));
		}

		// Clear SAP Codes storage
		sapCodes.clear();

		// Clear Profile Flag storage
		profileValues.clear();

		// Get current ISO offset (in days)
		isoOffset = flightExplosionRepository.getIsoOffset();

		// check if flight was cancelled
		if (isCnxFlag && !isDoNotSet0ForCxFlights) {
			cenOutMasterEntries.addAll(cenOutMasterRepository.findByNresultKey(resultKey));
			for (final CenOutMaster cenOutMasterEntry : cenOutMasterEntries) {
				cenOutMasterEntry.setNquantity(BigDecimal.ZERO);
				save(cenOutMasterEntry);
			}
		} else {
			final String flightText = String.format("%s %03d", flight.get().getCairline(), flight.get().getNflightNumber());
			final boolean isExplAddDelivery = getProfileFlag("ExplodeAdditionalDelivery");

			// generate flight loading (standard load / supplemental load)
			watch.start("[" + flightText + "] Generate Flight Loading");
			cenOutMasterEntries.addAll(generateFlightLoading(cenOutMasterSequences, flight.get()));
			watch.stop();

			// generate meal loading
			watch.start("[" + flightText + "] Generate Meal Loading");
			cenOutMasterEntries.addAll(generateMealLoading(cenOutMasterSequences, flight.get(), isGetNewDetailKey));
			watch.stop();

			// generate spml loading
			watch.start("[" + flightText + "] Generate SPML Loading");
			cenOutMasterEntries.addAll(generateSpmlLoading(cenOutMasterSequences, flight.get(), isGetNewDetailKey));
			watch.stop();

			// generate additional delivery
			if (isExplAddDelivery) {
				watch.start("[" + flightText + "] Generate Additional Delivery");
				cenOutMasterEntries.addAll(generateAdditionalDelivery(cenOutMasterSequences, flight.get()));
				watch.stop();
			}

			// explode packinglists
			watch.start("[" + flightText + "] Explode Packinglists");
			explodePackinglists(cenOutMasterSequences, cenOutMasterEntries, flight.get());
			watch.stop();

			// delete Cen Out Master entries
			watch.start("[" + flightText + "] Delete old CEN OUT MASTER entries");
			cenOutMasterRepository.deleteByNresultKey(resultKey);
			watch.stop();

			// save loading
			watch.start("[" + flightText + "] Save CEN OUT MASTER entries");
			for (final CenOutMaster cenOutMasterEntry : cenOutMasterEntries) {
				save(cenOutMasterEntry);
			}
			flush();
			watch.stop();

			// TODO: Enqueue flight for INT007_LOAD processing?
		}

		LOGGER.info(watch.prettyPrint());

		// Reset additional logging properties for Graylog
		MDC.clear();
	}

	/**
	 * Generates Flight Loading
	 *
	 * @param flight
	 * @return
	 */
	private List<CenOutMaster> generateFlightLoading(final List<Long> cenOutMasterSequences, final CenOut flight) {
		final List<CenOutMaster> cenOutMasterEntries = new ArrayList<>();
		final List<FlightLoadingEntry> flightLoadingEntries = getFlightLoading(flight);
		final Long customerKey = flight.getNcustomerKey() > 0 ? flight.getNcustomerKey() : flight.getNairlineKey();
		final boolean isLlWithClass = getProfileFlag("LL_With_Class");
		final boolean isGroupPlBySslZblAc2 = getProfileFlag(PROFILE_GROUP_PL_BY_SSL);
		final boolean isCnxFlag = flight.getNflightStatus() == 1;
		final boolean isFillForecastFields = getProfileFlag("FillForcastFields");

		for (final FlightLoadingEntry flightLoadingEntry : flightLoadingEntries) {
			final CenOutHandling flightHandling =
					cenOutHandlingRepository.findByIdNresultKeyAndCloadinglist(flight.getNresultKey(),
							flightLoadingEntry.getCenLlIdxCloadinglist());
			final CenOutMaster comNew = prepareNewCenOutMasterEntry(cenOutMasterSequences, flight);

			comNew.setNplIndexKey(flightLoadingEntry.getCenPlIdxNplIndexKey());
			comNew.setNplDetailKey(flightLoadingEntry.getCenPlNpackinglistDetailKey());
			comNew.setNreckoning(nvl(flightLoadingEntry.getCenLlNreckoning(), 0L));
			comNew.setCclass(flightLoadingEntry.getCenLlCclass());
			comNew.setNclassNumber(getClassNumber(flight.getNairlineKey(), flightLoadingEntry.getCenLlCclass()));
			comNew.setCsalesRel(flightLoadingEntry.getCenLlCsalesRel());
			comNew.setCgoodsRecipient(flightLoadingEntry.getCenLlCgoodsRecipient());
			comNew.setNquantity(flightLoadingEntry.getCenLlNquantity());
			comNew.setNquantityVersion(flightLoadingEntry.getCenLlNquantity());
			comNew.setCaccount(flightLoadingEntry.getCenAirCaccount());
			comNew.setNaccountKey(flightLoadingEntry.getCenPlNaccountKey());
			comNew.setCloadinglist(flightLoadingEntry.getCenLlIdxCloadinglist());

			if (flightHandling != null) {
				// set the quantity to 0, if the quantity of one of the handlings was set to 0 in billing browser
				if (flightHandling.getNquantity() == 0) {
					comNew.setNquantity(BigDecimal.ZERO);
				}

				// set posting type short
				comNew.setCpostTypeShort(getPostingTypeShort(flightHandling.getNpostingType()));

				// set additional account
				comNew.setCadditionalAccount(flightHandling.getCadditionalAccount());
				if (comNew.getCadditionalAccount() == null) {
					comNew.setCadditionalAccount(" ");
				}

				// set account
				if (comNew.getCaccount() == null) {
					comNew.setCaccount(flightHandling.getCaccount());
					comNew.setNaccountKey(flightHandling.getNaccountKey());
				}

				// set goods recipient
				setGoodsRecipient(comNew, flightHandling.getCaccount(), customerKey, flight.getCaccount(), true);
			}

			// reset the class if it is not needed for the loading list
			if (!isLlWithClass) {
				comNew.setCclass(" ");
				comNew.setNclassNumber(0L);
			}

			// handle cancelled flights
			if (isCnxFlag) {
				setValuesForCancelledFlight(comNew, false);
			}

			// check if the entry is already in cen out master
			final CenOutMaster com = findInCenOutMasterEntries(cenOutMasterEntries, comNew, isGroupPlBySslZblAc2, false);

			if (com != null) {
				// update existing entry in cen out master
				com.setNquantity(com.getNquantity().add(comNew.getNquantity()));
				com.setNquantityVersion(com.getNquantityVersion().add(comNew.getNquantityVersion()));
			} else {
				comNew.setNancestorIndexKey(flightLoadingEntry.getCenPlIdxNplIndexKey());
				comNew.setCtext(StringUtils.isBlank(flightLoadingEntry.getCenPlCtext()) ? "n/a" : flightLoadingEntry.getCenPlCtext());
				comNew.setCtextShort(getShortText(flightLoadingEntry.getCenPlCtext(), flightLoadingEntry.getCenPlCtextShort()));
				comNew.setCpackinglist(flightLoadingEntry.getCenPlIdxCpackinglist());
				comNew.setCunit(flightLoadingEntry.getCenPlCunit());
				comNew.setNhandlingId(flightLoadingEntry.getCenLlIdxNloadinglistKey());
				comNew.setNplKindKey(flightLoadingEntry.getCenPlIdxNplKindKey());
				comNew.setNpackinglistKey(flightLoadingEntry.getCenPlNpackinglistKey());
				comNew.setNmasterIndexKey(flightLoadingEntry.getCenPlIdxNplIndexKey());
				comNew.setCcustomerPl(flightLoadingEntry.getCenPlCcustomerPl());
				comNew.setCcustomerPlText(flightLoadingEntry.getCenPlCcustomerText());
				comNew.setCdefStorageLocation(flightLoadingEntry.getCenPlCdefStorageLocation());
				comNew.setCprodCatText(flightLoadingEntry.getSysProdCprodCatText());
				comNew.setNpartialsubstitution(0);

				// set forecast fields
				setForecastFields(comNew, isFillForecastFields);

				cenOutMasterEntries.add(comNew);
			}
		}

		return cenOutMasterEntries;
	}

	/**
	 * Generates Meal Loading
	 *
	 * @param flight
	 * @return
	 */
	private List<CenOutMaster> generateMealLoading(final List<Long> cenOutMasterSequences, final CenOut flight,
												   final boolean isGetNewDetailKey) {
		final List<CenOutMaster> cenOutMasterEntries = new ArrayList<>();
		final List<CenOutMeals> meals =
				cenOutMealsRepository.findByNresultKeyOrderByNclassNumberAscNcoverPrioAscNprioAsc(flight.getNresultKey());
		final Long customerKey = flight.getNcustomerKey() > 0 ? flight.getNcustomerKey() : flight.getNairlineKey();
		final int explWithBillingOnly = getProfileIntValue(PROFILE_WITH_BILLING_ONLY);
		final boolean isGroupPlByClass = getProfileFlag("GroupPlByClass");
		final boolean isGroupPlBySslZblAc2 = getProfileFlag(PROFILE_GROUP_PL_BY_SSL);
		final boolean isCnxFlag = flight.getNflightStatus() == 1;
		final boolean isFillForecastFields = getProfileFlag("FillForcastFields");

		for (final CenOutMeals meal : meals) {
			final CenOutMaster comNew = prepareNewCenOutMasterEntry(cenOutMasterSequences, flight);

			comNew.setNplIndexKey(meal.getNpackinglistIndexKey());
			comNew.setCclass(nvl(meal.getCclass(), " "));
			comNew.setNclassNumber(getClassNumber(flight.getNairlineKey(), meal.getCclass()));
			comNew.setCpackinglistXsl(nvl(meal.getCpackinglistXsl(), ""));
			comNew.setNserviceSequence(nvl(meal.getNserviceSequence(), 0));
			comNew.setCsapCode(meal.getCsapCode());
			comNew.setNquantity(meal.getNquantity());
			comNew.setNquantityVersion(meal.getNquantityVersion());
			comNew.setCaccount(meal.getCaccount());
			comNew.setNaccountKey(meal.getNaccountKey()); // in PB this is set to the last account key from flight loading o_0
			comNew.setCadditionalAccount(nvl(meal.getCadditionalAccount(), " "));

			// set new pl detail key, if needed
			if (isGetNewDetailKey) {
				setPlDetailKey(comNew, flight);
			}

			// check if detail key is set, if not get the data from db
			if (meal.getNpackinglistDetailKey() == null || meal.getNpackinglistDetailKey() <= 0) {
				final CenPackinglists packinglist = cenPackinglistsRepository
						.findPackinglistByNpackinglistIndexKeyAndDdate(meal.getNpackinglistIndexKey(), flight.getDdeparture());

				comNew.setNplDetailKey(packinglist.getId().getNpackinglistDetailKey());
				comNew.setNplKindKey(packinglist.getCenPackinglistIndex().getNplKindKey());
				comNew.setNpackinglistKey(packinglist.getNpackinglistKey());
				comNew.setCtext(StringUtils.isBlank(packinglist.getCtext()) ? "n/a" : packinglist.getCtext());
				comNew.setCunit(packinglist.getCunit());
			} else {
				comNew.setNplDetailKey(meal.getNpackinglistDetailKey());
				comNew.setNplKindKey(meal.getNplKindKey());
				comNew.setNpackinglistKey(meal.getNpackinglistKey());
				comNew.setCtext(StringUtils.isBlank(meal.getCtext()) ? "n/a" : meal.getCtext());
				comNew.setCunit(meal.getCunit());
			}

			if (explWithBillingOnly == 0) {
				comNew.setNreckoning(0L);
				if (meal.getNbillingStatus() == 2) {
					continue;
				}
			} else {
				comNew.setNreckoning(nvl(Long.valueOf(meal.getNbillingStatus()), 0L));
			}

			// set posting type short
			comNew.setCpostTypeShort(getPostingTypeShort(meal.getNpostingType()));

			// set goods recipient
			setGoodsRecipient(comNew, meal.getCaccount(), customerKey, flight.getCaccount(), false);

			// reset the class if it is not needed for the grouping
			if (!isGroupPlByClass) {
				comNew.setCclass(" ");
				comNew.setNclassNumber(0L);
			}

			// handle cancelled flights
			if (isCnxFlag) {
				setValuesForCancelledFlight(comNew, true);
			}

			// look for if the entry is already in cen out master
			final CenOutMaster com = findInCenOutMasterEntries(cenOutMasterEntries, comNew, isGroupPlBySslZblAc2, false);

			if (com != null) {
				// update existing entry in cen out master
				com.setNquantity(com.getNquantity().add(comNew.getNquantity()));
				com.setNquantityVersion(com.getNquantityVersion().add(comNew.getNquantityVersion()));

				// update forecast fields
				updateForecastFields(com, comNew);
			} else {
				comNew.setNancestorIndexKey(meal.getNpackinglistIndexKey());
				comNew.setCtextShort(getShortText(meal.getCtext(), meal.getCproductionText()));
				comNew.setCpackinglist(meal.getCpackinglist());
				comNew.setNhandlingId(meal.getNmoduleType() == 0 ? 11L : 5L); // 11=Meal Loading;5=Additional Loading
				comNew.setNmasterIndexKey(meal.getNpackinglistIndexKey());
				comNew.setCcustomerPl(meal.getCcustomerPl());
				comNew.setCcustomerPlText(meal.getCcustomerText());

				// set forecast fields
				setForecastFields(comNew, isFillForecastFields);

				final Optional<CenPackinglists> packinglist =
						cenPackinglistsRepository.findById(new CenPackinglistsId(comNew.getNplIndexKey(), comNew.getNplDetailKey()));
				final String defStorageLocation = packinglist.isPresent() ? nvl(packinglist.get().getCdefStorageLocation(), " ") : " ";
				comNew.setCdefStorageLocation(defStorageLocation);

				if (!packinglist.isPresent() || packinglist.get().getCprodCat() == null) {
					comNew.setCprodCatText("");
				} else {
					final SysProductCategory productCategory = sysProductCategoryRepository.findFirstByCsapCode(packinglist.get().getCprodCat());
					comNew.setCprodCatText(productCategory.getCtext());
				}

				// set partial substitution
				if (meal.getNlocalSub() == 1 && meal.getCpackinglistOri().equals(meal.getCpackinglist())) {
					comNew.setNpartialsubstitution(1);
				} else {
					comNew.setNpartialsubstitution(0);
				}

				cenOutMasterEntries.add(comNew);
			}
		}

		return cenOutMasterEntries;
	}

	/**
	 * Generates SPML Loading
	 *
	 * @param flight
	 * @return
	 */
	private List<CenOutMaster> generateSpmlLoading(
			final List<Long> cenOutMasterSequences,
			final CenOut flight,
			final boolean isGetNewDetailKey) {
		final List<CenOutMaster> cenOutMasterEntries = new ArrayList<>();
		final List<CenOutSpmlDetail> spmls =
				cenOutSpmlDetailRepository.findByCenOutSpmlNresultKey(flight.getNresultKey());
		cenOutMealsRepository.findByNresultKeyOrderByNclassNumberAscNcoverPrioAscNprioAsc(flight.getNresultKey());
		final Long customerKey = flight.getNcustomerKey() > 0 ? flight.getNcustomerKey() : flight.getNairlineKey();
		final int explWithBillingOnly = getProfileIntValue(PROFILE_WITH_BILLING_ONLY);
		final boolean isGroupPlByClass = getProfileFlag("GroupPlByClass");
		final boolean isGroupPlBySslZblAc2 = getProfileFlag(PROFILE_GROUP_PL_BY_SSL);
		final boolean isCnxFlag = flight.getNflightStatus() == 1;

		for (final CenOutSpmlDetail spml : spmls) {
			final CenOutMaster comNew = prepareNewCenOutMasterEntry(cenOutMasterSequences, flight);

			comNew.setNplIndexKey(spml.getNpackinglistIndexKey());
			comNew.setNplDetailKey(spml.getNpackinglistDetailKey());
			comNew.setCclass(nvl(spml.getCenOutSpml().getCclass(), " "));
			comNew.setNclassNumber(getClassNumber(flight.getNairlineKey(), spml.getCenOutSpml().getCclass()));
			comNew.setCpackinglistXsl(nvl(spml.getCpackinglistXsl(), ""));
			comNew.setNquantity(spml.getNquantity());
			comNew.setNquantityVersion(spml.getNquantity());
			comNew.setCaccount(spml.getCaccount());
			comNew.setNaccountKey(spml.getNaccountKey()); // in PB this is set to the last account key from flight loading o_0
			comNew.setCadditionalAccount(nvl(spml.getCadditionalAccount(), " "));

			// set new pl detail key, if needed
			if (isGetNewDetailKey) {
				setPlDetailKey(comNew, flight);
			}

			if (explWithBillingOnly == 0) {
				comNew.setNreckoning(0L);
				if (spml.getNbillingStatus() == 2) {
					continue;
				}
			} else {
				comNew.setNreckoning(nvl((long) spml.getNbillingStatus(), 0L));
			}

			// set posting type short
			comNew.setCpostTypeShort(getPostingTypeShort(spml.getNpostingType()));

			// set goods recipient
			setGoodsRecipient(comNew, spml.getCaccount(), customerKey, flight.getCaccount(), true);

			// reset the class if it is not needed for the grouping
			if (!isGroupPlByClass) {
				comNew.setCclass(" ");
				comNew.setNclassNumber(0L);
			}

			// handle cancelled flights
			if (isCnxFlag) {
				setValuesForCancelledFlight(comNew, false);
			}

			// look for if the entry is already in cen out master
			final CenOutMaster com = findInCenOutMasterEntries(cenOutMasterEntries, comNew, isGroupPlBySslZblAc2, false);

			if (com != null) {
				// update existing entry in cen out master
				com.setNquantity(com.getNquantity().add(comNew.getNquantity()));
				com.setNquantityVersion(com.getNquantityVersion().add(comNew.getNquantityVersion()));
			} else {
				// add new cen out master entry if it is not in the list, yet
				comNew.setCunit(spml.getCunit());
				comNew.setNancestorIndexKey(spml.getNpackinglistIndexKey());
				comNew.setNplKindKey(spml.getNplKindKey());
				comNew.setNpackinglistKey(spml.getNpackinglistKey());
				comNew.setCtext(spml.getCtext());
				comNew.setCtextShort(getShortText(null, spml.getCproductionText()));
				comNew.setCpackinglist(spml.getCpackinglist());
				comNew.setNhandlingId(14L);
				comNew.setNmasterIndexKey(spml.getNpackinglistIndexKey());
				comNew.setCcustomerPl(spml.getCcustomerPl());
				comNew.setCcustomerPlText(spml.getCcustomerText());

				// set forecast fields
				setForecastFields(comNew, false);

				final Optional<CenPackinglists> packinglist =
						cenPackinglistsRepository.findById(new CenPackinglistsId(comNew.getNplIndexKey(), comNew.getNplDetailKey()));
				if (packinglist.isPresent()) {
					comNew.setCdefStorageLocation(nvl(packinglist.get().getCdefStorageLocation(), " "));
				}

				// set partial substitution
				if (spml.getNlocalSub() == 1 && spml.getCpackinglistOri().equals(spml.getCpackinglist())) {
					comNew.setNpartialsubstitution(1);
				} else {
					comNew.setNpartialsubstitution(0);
				}

				cenOutMasterEntries.add(comNew);
			}
		}

		return cenOutMasterEntries;
	}

	/**
	 * Generates Additional Delivery
	 *
	 * @param flight
	 * @return
	 */
	private List<CenOutMaster> generateAdditionalDelivery(
			final List<Long> cenOutMasterSequences,
			final CenOut flight) {
		final List<CenOutMaster> cenOutMasterEntries = new ArrayList<>();
		final List<CenOutAddDelivery> addDeliveryEntries =
				cenOutAddDeliveryRepository.findByCenOutNresultKey(flight.getNresultKey());
		cenOutMealsRepository.findByNresultKeyOrderByNclassNumberAscNcoverPrioAscNprioAsc(flight.getNresultKey());
		final Long customerKey = flight.getNcustomerKey() > 0 ? flight.getNcustomerKey() : flight.getNairlineKey();
		final boolean isGroupPlBySslZblAc2 = getProfileFlag(PROFILE_GROUP_PL_BY_SSL);

		for (final CenOutAddDelivery addDeliveryEntry : addDeliveryEntries) {
			final CenPackinglists packinglist = cenPackinglistsRepository
					.findPackinglistByNpackinglistIndexKeyAndDdate(addDeliveryEntry.getNpackinglistIndexKey(), flight.getDdeparture());
			if (addDeliveryEntry.getNonReqQuantity() <= 0 || packinglist == null) {
				continue;
			}
			final CenOutMaster comNew = prepareNewCenOutMasterEntry(cenOutMasterSequences, flight);

			comNew.setNplIndexKey(packinglist.getId().getNpackinglistIndexKey());
			comNew.setNplDetailKey(packinglist.getId().getNpackinglistDetailKey());
			comNew.setCclass(" ");
			comNew.setNclassNumber(0L);
			comNew.setNquantity(BigDecimal.valueOf(addDeliveryEntry.getNonReqQuantity()));
			comNew.setNquantityVersion(BigDecimal.valueOf(addDeliveryEntry.getNonReqQuantity()));
			comNew.setCaccount(null);
			comNew.setNaccountKey(null);
			comNew.setNreckoning(0L);

			// set goods recipient
			setGoodsRecipient(comNew, null, customerKey, flight.getCaccount(), false);

			// look for if the entry is already in cen out master
			final CenOutMaster com = findInCenOutMasterEntries(cenOutMasterEntries, comNew, isGroupPlBySslZblAc2, false);

			if (com != null) {
				// update existing entry in cen out master
				com.setNquantity(com.getNquantity().add(comNew.getNquantity()));
				com.setNquantityVersion(com.getNquantityVersion().add(comNew.getNquantityVersion()));

				// update forecast fields
				updateForecastFields(com, comNew);
			} else {
				comNew.setCunit(packinglist.getCunit());
				comNew.setNancestorIndexKey(packinglist.getId().getNpackinglistIndexKey());
				comNew.setNplKindKey(packinglist.getSysPackinglistTypes().getNpltypeKey());
				comNew.setNpackinglistKey(packinglist.getNpackinglistKey());
				comNew.setCtext(packinglist.getCtext());
				comNew.setCtextShort(getShortText(packinglist.getCtext(), packinglist.getCtext()));
				comNew.setCpackinglist(addDeliveryEntry.getCpackinglist());
				comNew.setNhandlingId(5L);
				comNew.setNmasterIndexKey(packinglist.getId().getNpackinglistIndexKey());
				comNew.setCcustomerPl(packinglist.getCcustomerPl());
				comNew.setCcustomerPlText(packinglist.getCcustomerText());
				comNew.setCdefStorageLocation(" ");
				comNew.setNpartialsubstitution(0);

				// set forecast fields
				setForecastFields(comNew, false);

				cenOutMasterEntries.add(comNew);
			}
		}

		return cenOutMasterEntries;
	}

	/**
	 * Explode the first level packinglists
	 *
	 * @param cenOutMasterEntries
	 * @param flight
	 */
	private void explodePackinglists(
			final List<Long> cenOutMasterSequences,
			final List<CenOutMaster> cenOutMasterEntries,
			final CenOut flight) {
		final List<CenOutMaster> explosionEntries = new ArrayList<>();
		final boolean isUseRampTime =
				"1".equals(profileService.getUnitProfileValue(flight.getCunit(), "Default", "USE_RAMPTIME_FOR_PRODUCTION", "0"));
		final boolean isFillEmptyCustomerPl = getProfileFlag("FillEmptyCustomerPL");
		final Date calcDate = isUseRampTime && compareTimes(flight.getCrampTime(), flight.getCdepartureTime()) > 0
				? relativeDate(flight.getDdeparture(), -1) : flight.getDdeparture();
		final String calcTime = isUseRampTime ? flight.getCrampTime() : flight.getCdepartureTime();
		final int language = getLanguage(flight.getCunit());

		for (final CenOutMaster masterPackinglist : cenOutMasterEntries) {
			final LocUnitPlAreas plArea =
					locUnitPlAreasRepository.findByCunitAndNpackinglistIndexKeyAndDate(masterPackinglist.getNplIndexKey(),
							flight.getDdeparture(), flight.getCunit());
			final SysPackinglistKinds plKind = sysPackinglistKindsRepository.findByNpackinglistIndexKey(masterPackinglist.getNplIndexKey());
			final boolean isUseReserve = plKind == null || nvl(plKind.getNuseReserve(), 0) == 1;
			final boolean isXsl = plKind != null && plKind.getNxsl() != 0;

			if (plArea != null) {
				masterPackinglist.setNworkstationKey(plArea.getNworkstationKey());
				masterPackinglist.setNareaKey(plArea.getLocUnitAreas().getNareaKey());

				// set reserve
				setReserve(masterPackinglist, masterPackinglist, flight, plArea.getNplAreaKey(), isUseReserve);
			}

			// set time frame
			setTimeframe(masterPackinglist, flight);

			// set the customer pl and text
			final CenPackinglists packinglist = cenPackinglistsRepository
					.findPackinglistByNpackinglistIndexKeyAndDdate(masterPackinglist.getNplIndexKey(), flight.getDdeparture());
			if (packinglist != null) {
				masterPackinglist.setCcustomerPl(packinglist.getCcustomerPl());
				masterPackinglist.setCcustomerPlText(packinglist.getCcustomerText());
			}

			// set empty customer pl
			if (isFillEmptyCustomerPl) {
				setEmptyCustomerPl(masterPackinglist);
			}

			// switch texts according to language
			setShortText(masterPackinglist, language);

			// add self
			explosionEntries.add(masterPackinglist);

			// explode sub packinglists if it is not a service packinglist
			if (!isXsl) {
				final List<CenOutMaster> subPackinglists = new ArrayList<>();
				final List<CenOutMaster> ancestors = new ArrayList<>(Collections.singletonList(masterPackinglist));
				explodeSubPackinglists(cenOutMasterSequences, subPackinglists, masterPackinglist, ancestors, flight, calcDate, calcTime,
						language, true);

				if (!subPackinglists.isEmpty()) {
					explosionEntries.addAll(subPackinglists);
				}
			}
		}

		// round the quantities to 3 decimal places
		for (final CenOutMaster explosionEntry : explosionEntries) {
			explosionEntry.setNquantity(roundDecimal(explosionEntry.getNquantity(), 3));
			explosionEntry.setNquantityVersion(roundDecimal(explosionEntry.getNquantityVersion(), 3));
		}

		cenOutMasterEntries.clear();
		cenOutMasterEntries.addAll(explosionEntries);
	}

	private BigDecimal truncDecimal(final BigDecimal value) {
		return value.setScale(0, RoundingMode.DOWN);
	}

	private BigDecimal roundDecimal(final BigDecimal value, final int newScale) {
		// TODO: no special rounding for now, because it is unclear how exactly the old explosion is rounding
		// some example of values and how they are rounded in the old explosion process
		// 0,0195 --> 0.02 = HALF_EVEN
		// 0,2855 --> 0.285 = HALF_ODD
		// 0,1035 --> 0.104 = HALF_EVEN
		return value;

		// if (value.scale() <= newScale) {
		// return value;
		// }

		// // using a HALF_ODD rounding, which is not implemented in Java by default
		// final String valueAsString = value.setScale(newScale, RoundingMode.DOWN).toString();
		// final Integer leftToDiscaredDigitDigit = Integer.valueOf(valueAsString.substring(valueAsString.length() - 1));
		// final boolean isLeftToDiscaredDigitEven = leftToDiscaredDigitDigit % 2 == 0;
		// if (isLeftToDiscaredDigitEven) {
		// return value.setScale(newScale, RoundingMode.HALF_UP);
		// } else {
		// return value.setScale(newScale, RoundingMode.HALF_DOWN);
		// }

		// return value.setScale(newScale, RoundingMode.HALF_UP);
	}

	/**
	 * Helper function to recursively explode one packinglist
	 *
	 * @param cenOutMasterEntries
	 * @param masterPackinglist
	 * @param ancestorPackinglists
	 * @param flight
	 * @param calcDate
	 * @param calcTime
	 * @param language
	 * @param isFirstLevel
	 */
	private void explodeSubPackinglists(
			final List<Long> cenOutMasterSequences,
			final List<CenOutMaster> cenOutMasterEntries,
			final CenOutMaster masterPackinglist,
			final List<CenOutMaster> ancestorPackinglists,
			final CenOut flight,
			final Date calcDate,
			final String calcTime,
			final int language,
			final boolean isFirstLevel) {

		// if the list of ancestor packinglists is empty, there is nothing to do
		if (ancestorPackinglists.isEmpty()) {
			return;
		}

		// get some profile flags for later processing
		final boolean isFillEmptyCustomerPl = getProfileFlag("FillEmptyCustomerPL");
		final boolean isGroupPlBySslZblAc2 = getProfileFlag(PROFILE_GROUP_PL_BY_SSL);
		final boolean isConvertGrToKgAndMlToLt = getProfileFlag("ConvertGtoKG");
		final boolean isDoNotSet0ForCxFlights = getProfileFlag(PROFILE_NO_0_FOR_CX_FLIGHTS);
		final boolean isCnxFlag = flight.getNflightStatus() == 1;

		// fill the list of packinglist index keys to explode
		final List<Long> plIndexKeys = new ArrayList<>();
		for (final CenOutMaster ancestorPackinglist : ancestorPackinglists) {
			plIndexKeys.add(ancestorPackinglist.getNplIndexKey());
		}

		// get the explosion data for all ancestor packinglists
		final PackinglistExplosionDetailParameter param = new PackinglistExplosionDetailParameter();
		param.setIndexKeys(plIndexKeys);
		param.setResultKey(flight.getNresultKey());
		param.setAirlineKey(flight.getNairlineKey());
		param.setRefDate(flight.getDdeparture());
		param.setCsc(flight.getCunit());
		param.setCalcDate(calcDate);
		param.setCalcTime(calcTime);
		param.setIsoOffset(isoOffset);
		param.setCheckBoardingUnit(isFirstLevel);
		final List<PackinglistExplosionDetailEntry> plDetails = flightExplosionRepository.findPackinglistExplosionDetailData(param);

		// process all ancestor packinglists
		final List<CenOutMaster> newAncestorPackinglists = new ArrayList<>();
		for (final CenOutMaster ancestorPackinglist : ancestorPackinglists) {
			// check for the maximum recursion level
			final int level = ancestorPackinglist.getNlevel() + 1;
			if (level > 100) {
				LOGGER.debug("Maximum recursion level reached!");
				return;
			}

			// get all explosion details for the currently processed ancestor packinglist
			final List<PackinglistExplosionDetailEntry> currentPlDetails = new ArrayList<>();
			for (final PackinglistExplosionDetailEntry plDetail : plDetails) {
				if (plDetail.getNpackinglistIndexKey() == ancestorPackinglist.getNplIndexKey()) {
					currentPlDetails.add(plDetail);
				}
			}

			// process every explosion detail of the currently processed ancestor packinglist
			for (final PackinglistExplosionDetailEntry plDetail : currentPlDetails) {
				final boolean isUseReserve = nvl(plDetail.getNuseReserve(), 0) == 1;
				final CenOutMaster comNew = prepareNewCenOutMasterEntry(cenOutMasterSequences, flight);

				comNew.setNmasterDetailKey(masterPackinglist.getNmasterDetailKey());
				comNew.setNmasterIndexKey(masterPackinglist.getNplIndexKey());
				comNew.setNhandlingId(masterPackinglist.getNhandlingId());
				comNew.setNfreqKey(masterPackinglist.getNfreqKey());
				comNew.setCloadinglist(masterPackinglist.getCloadinglist());
				comNew.setCadditionalAccount(masterPackinglist.getCadditionalAccount());
				comNew.setCclass(masterPackinglist.getCclass());
				comNew.setNclassNumber(masterPackinglist.getNclassNumber());
				comNew.setNparamsKey1(masterPackinglist.getNparamsKey1());
				comNew.setNparamsKey2(masterPackinglist.getNparamsKey2());
				comNew.setNparamsKey3(masterPackinglist.getNparamsKey3());
				comNew.setNparamsMin(masterPackinglist.getNparamsMin());
				comNew.setCpostTypeShort(masterPackinglist.getCpostTypeShort());
				comNew.setNpartialsubstitution(masterPackinglist.getNpartialsubstitution());
				comNew.setNserviceSequence(masterPackinglist.getNserviceSequence());
				comNew.setCsapCode(masterPackinglist.getCsapCode());
				comNew.setCpackinglistXsl(masterPackinglist.getCpackinglistXsl());

				comNew.setNancestorDetailKey(ancestorPackinglist.getNdetailKey());
				comNew.setNancestorIndexKey(ancestorPackinglist.getNplIndexKey());
				comNew.setNquantity(
						plDetail.getNquantity().multiply(nvl(ancestorPackinglist.getNquantity(), BigDecimal.ZERO)));
				comNew.setNquantityVersion(
						plDetail.getNquantity().multiply(nvl(ancestorPackinglist.getNquantityVersion(), BigDecimal.ZERO)));

				comNew.setNplIndexKey(plDetail.getNdetailKey());
				comNew.setNplDetailKey(plDetail.getNpackinglistDetailKey());
				comNew.setCpackinglist(plDetail.getCpackinglist());
				comNew.setNportion(plDetail.getNquantity());
				comNew.setNreckoning(plDetail.getNreckoning());
				comNew.setCunit(plDetail.getCunit());
				comNew.setNstatus(99);
				comNew.setNareaKey(nvl(plDetail.getNareaKey(), ancestorPackinglist.getNareaKey()));
				comNew.setNworkstationKey(nvl(plDetail.getNworkstationKey(), ancestorPackinglist.getNworkstationKey()));
				comNew.setNplKindKey(plDetail.getNplKindKey());
				comNew.setNpackinglistKey(plDetail.getNpackinglistKey());
				comNew.setCcustomerPl(plDetail.getCcustomerPl());
				comNew.setCcustomerPlText(plDetail.getCcustomerText());
				comNew.setCsalesRel(nvl(plDetail.getCsalesRel(), ancestorPackinglist.getCsalesRel()));
				comNew.setCgoodsRecipient(nvl(plDetail.getCgoodsRecipient(), ancestorPackinglist.getCgoodsRecipient()));
				comNew.setCdefStorageLocation(
						StringUtils.isBlank(plDetail.getCdefStorageLocation()) ? null : ancestorPackinglist.getCdefStorageLocation());
				comNew.setCprodCatText(plDetail.getCprodCatText());
				comNew.setCaccount(nvl(plDetail.getCaccount(), ancestorPackinglist.getCaccount()));
				comNew.setNaccountKey(plDetail.getCaccount() == null ? ancestorPackinglist.getNaccountKey() : plDetail.getNaccountKey());

				comNew.setNlevel(level);

				// adjust quantities according to package size
				if (nvl(plDetail.getNnumberPackages(), 0) > 0) {
					comNew.setNquantity(comNew.getNquantity().multiply(BigDecimal.valueOf(plDetail.getNnumberPackages())));
					comNew.setNquantityVersion(comNew.getNquantityVersion().multiply(BigDecimal.valueOf(plDetail.getNnumberPackages())));
				}

				// convert Gr to Kg and Ml to Lt if needed
				if (isConvertGrToKgAndMlToLt) {
					convertGrToKgAndMlToLt(comNew);
				}

				// handle cancelled flights
				if (isCnxFlag && isDoNotSet0ForCxFlights) {
					if (comNew.getNreckoning() == 1) {
						comNew.setNquantity(BigDecimal.ZERO);
						comNew.setNquantityVersion(BigDecimal.ZERO);
					} else if (comNew.getNreckoning() == 0) {
						comNew.setNreckoning(2L);
					}
				}

				// switch texts according to language
				if (language == 2) {
					comNew.setCtext(plDetail.getCplTextShort());
				} else if (language == 3) {
					comNew.setCtext(plDetail.getCplTextShort2());
				} else {
					comNew.setCtext(plDetail.getCplText());
				}
				comNew.setCtextShort(getShortText(comNew.getCtext(), plDetail.getCplTextShort()));

				// set reckoning
				setReckoning(comNew, CbaseReckoningType.getEnum(ancestorPackinglist.getNreckoning().intValue()));

				// set time frame
				if (plDetail.getNflightOffset() == null) {
					if (plDetail.getNoffset() != null) {
						comNew.setNpltimeframeIndex(plDetail.getNpltimeframeIndex());
						comNew.setNbatch(plDetail.getNbatch());
						comNew.setDprodDate(relativeDate(calcDate, -plDetail.getNoffset()));
						comNew.setNworkscheduleIndex(plDetail.getNworkscheduleIndex());
					}
				} else {
					comNew.setDprodDate(relativeDate(calcDate, -plDetail.getNflightOffset()));
					comNew.setNworkscheduleIndex(plDetail.getNflightWorkscheduleIndex());
					comNew.setNpltfFlightIndex(plDetail.getNpltfFlightIndex());
					comNew.setNpltfFlightIndexGroup(plDetail.getNpltfFlightIndexGroup());
				}

				// trim goods recipient
				if (comNew.getCgoodsRecipient() != null && comNew.getCgoodsRecipient().length() > 7) {
					comNew.setCgoodsRecipient(comNew.getCgoodsRecipient().substring(comNew.getCgoodsRecipient().length() - 7));
				}

				// adjust account codes for deviant goods recipient
				if ("1".equals(plDetail.getCsalesRel())) {
					setAccountCodeByGoodsRecipient(comNew, flight.getNairlineKey());
				}

				// set reserve
				setReserve(masterPackinglist, comNew, flight, plDetail.getNplAreaKey(), isUseReserve);

				// look for if the entry is already in cen out master
				final CenOutMaster com = findInCenOutMasterEntries(cenOutMasterEntries, comNew, isGroupPlBySslZblAc2, true);

				if (com != null) {
					// update existing entry in cen out master
					com.setNquantity(com.getNquantity().add(comNew.getNquantity()));
					com.setNquantityVersion(com.getNquantityVersion().add(comNew.getNquantityVersion()));
					com.setNreserve(com.getNreserve().add(comNew.getNreserve()));
					com.setNreserveVersion(com.getNreserveVersion().add(comNew.getNreserveVersion()));
					com.setNstatus(98);
					com.setNlevel(comNew.getNlevel());

					// note: the COM entries in the list of new newAncestorPackinglists get updated automatically
					// because we are working on references here
				} else {
					// set empty customer pl
					if (isFillEmptyCustomerPl) {
						setEmptyCustomerPl(comNew);
					}

					cenOutMasterEntries.add(comNew);
					newAncestorPackinglists.add(comNew);
				}
			}
		}

		// explode all new ancestor packinglists
		explodeSubPackinglists(cenOutMasterSequences, cenOutMasterEntries, masterPackinglist, newAncestorPackinglists, flight, calcDate,
				calcTime, language,
				false);
	}

	/**
	 * Helper function to look for an already existing {@link CenOutMaster} entity in a list
	 *
	 * @param cenOutMasterEntries the list of {@link CenOutMaster} entities
	 * @param comNew the {@link CenOutMaster} entity to check
	 * @param isGroupPlBySslZblAc2 set {@code true} to add checks for cloadinglist and cadditionalAccount
	 * @param isExplosionCheck set {@code true} to add checks for nmasterIndexKey and nancestorIndexKey
	 * @return the already existing {@link CenOutMaster} entity or {@code null}
	 */
	private CenOutMaster findInCenOutMasterEntries(
			final List<CenOutMaster> cenOutMasterEntries,
			final CenOutMaster comNew,
			final boolean isGroupPlBySslZblAc2,
			final boolean isExplosionCheck) {
		for (final CenOutMaster com : cenOutMasterEntries) {
			if (Objects.equals(comNew.getNaction(), com.getNaction())
					&& Objects.equals(comNew.getNplType(), com.getNplType())
					&& Objects.equals(comNew.getNplIndexKey(), com.getNplIndexKey())
					&& Objects.equals(comNew.getNplDetailKey(), com.getNplDetailKey())
					&& (!isExplosionCheck || (Objects.equals(comNew.getNmasterIndexKey(), com.getNmasterIndexKey())
					&& Objects.equals(comNew.getNancestorIndexKey(), com.getNancestorIndexKey())))
					&& Objects.equals(comNew.getNresultKey(), com.getNresultKey())
					&& Objects.equals(comNew.getNfreqKey(), com.getNfreqKey())
					&& Objects.equals(comNew.getNreckoning(), com.getNreckoning())
					&& Objects.equals(comNew.getCclass(), com.getCclass())
					&& Objects.equals(comNew.getNclassNumber(), com.getNclassNumber())
					&& Objects.equals(comNew.getCsalesRel(), com.getCsalesRel())
					&& Objects.equals(comNew.getCpostTypeShort(), com.getCpostTypeShort())
					&& Objects.equals(comNew.getCgoodsRecipient(), com.getCgoodsRecipient())
					&& Objects.equals(comNew.getCpackinglistXsl(), com.getCpackinglistXsl())
					&& Objects.equals(comNew.getNserviceSequence(), com.getNserviceSequence())
					&& Objects.equals(comNew.getCsapCode(), com.getCsapCode())
					&& (!isGroupPlBySslZblAc2 || (Objects.equals(comNew.getCloadinglist(), com.getCloadinglist())
					&& Objects.equals(comNew.getCadditionalAccount(), com.getCadditionalAccount())))) {
				return com;
			}
		}

		return null;
	}

	/**
	 * Creates a new {@link CenOutMaster} entity and sets some default values
	 *
	 * @param cenOutMasterSequences
	 * @param flight
	 * @return
	 */
	private CenOutMaster prepareNewCenOutMasterEntry(final List<Long> cenOutMasterSequences, final CenOut flight) {
		final CenOutMaster comNew = new CenOutMaster();
		final Long sequence = getNextCenOutMasterSequence(cenOutMasterSequences);

		comNew.setNdetailKey(sequence);
		comNew.setNmasterDetailKey(sequence);
		comNew.setNancestorDetailKey(sequence);

		comNew.setNresultKey(flight.getNresultKey());
		comNew.setNtransaction(flight.getNtransaction());
		comNew.setCpartUnit(flight.getCunit());

		comNew.setNstatus(0);
		comNew.setNlevel(1);
		comNew.setNaction(1);
		comNew.setNplType(1);
		comNew.setNfreqKey(0);
		comNew.setDtimestamp(now());
		comNew.setCadditionalAccount(" ");
		comNew.setCpostTypeShort(" ");
		comNew.setCsalesRel(" ");
		comNew.setCsapCode("");
		comNew.setCloadinglist("");
		comNew.setCpackinglistXsl("");
		comNew.setNserviceSequence(0);
		comNew.setNreserve(BigDecimal.ZERO);

		return comNew;
	}

	/**
	 * Helper function to get all the standard and supplemental loading for a flight
	 *
	 * @param flight
	 * @return
	 */
	private List<FlightLoadingEntry> getFlightLoading(final CenOut flight) {
		final List<FlightLoadingEntry> flightLoadingEntries = new ArrayList<>();
		final Long resultKey = flight.getNresultKey();
		final Date refDate = flight.getDdeparture();
		final String refTime = flight.getCdepartureTime();

		// get standard loading (CBASE_LOADING.pf_get_ll_details_by_resultkey)
		final List<FlightLoadingEntry> stdLoadingEntries =
				flightExplosionRepository.findFlightLoading(resultKey, refDate, refTime, 1, false, "");

		// get supplemental loading (CBASE_LOADING.pf_get_ll_details_by_resultkey)
		final List<FlightLoadingEntry> supLoadingEntries =
				flightExplosionRepository.findFlightLoading(resultKey, refDate, refTime, 2, false, "");

		// process supplemental loading
		final Iterator<FlightLoadingEntry> supLoadingEntriesItr = supLoadingEntries.iterator();

		while (supLoadingEntriesItr.hasNext()) {
			final FlightLoadingEntry supLoadingEntry = supLoadingEntriesItr.next();
			final String supActionCode = supLoadingEntry.getCenLlCactioncode();
			final Long supBellyContainer = supLoadingEntry.getCenLlNbellyContainer();
			final String supGalley = supLoadingEntry.getCenGalCgalley();
			final String supStowage = supLoadingEntry.getCenStowCstowage();
			final String supPlace = supLoadingEntry.getCenStowCplace();

			// offload
			if ("O".equals(supActionCode)) {
				final Iterator<FlightLoadingEntry> stdLoadingEntriesItr = stdLoadingEntries.iterator();

				while (stdLoadingEntriesItr.hasNext()) {
					final FlightLoadingEntry stdLoadingEntry = stdLoadingEntriesItr.next();
					final Long stdBellyContainer = stdLoadingEntry.getCenLlNbellyContainer();
					final String stdGalley = stdLoadingEntry.getCenGalCgalley();
					final String stdStowage = stdLoadingEntry.getCenStowCstowage();
					final String stdPlace = stdLoadingEntry.getCenStowCplace();

					if (stdBellyContainer.equals(supBellyContainer)
							&& stdGalley.equals(supGalley)
							&& stdStowage.equals(supStowage)
							&& stdPlace.equals(supPlace)) {
						stdLoadingEntriesItr.remove();
					}
				}

				supLoadingEntriesItr.remove();
			}

			// exchange
			else if ("R".equals(supActionCode) || "X".equals(supActionCode)) {
				final Iterator<FlightLoadingEntry> stdLoadingEntriesItr = stdLoadingEntries.iterator();

				while (stdLoadingEntriesItr.hasNext()) {
					final FlightLoadingEntry stdLoadingEntry = stdLoadingEntriesItr.next();
					final Long stdBellyContainer = stdLoadingEntry.getCenLlNbellyContainer();
					final String stdGalley = stdLoadingEntry.getCenGalCgalley();
					final String stdStowage = stdLoadingEntry.getCenStowCstowage();
					final String stdPlace = stdLoadingEntry.getCenStowCplace();

					if (stdBellyContainer.equals(supBellyContainer)
							&& stdGalley.equals(supGalley)
							&& stdStowage.equals(supStowage)
							&& stdPlace.equals(supPlace)) {
						stdLoadingEntriesItr.remove();
					}
				}

				supLoadingEntry.setCenLlCactioncode("L");
			}

			// onload
			else if ("Z".equals(supActionCode) && supBellyContainer == 0) {
				String onloadTextA = nvl(supLoadingEntry.getCenPlCtext(), "");
				String onloadTextB = nvl(supLoadingEntry.getCenPlCtextShort(), "");
				final BigDecimal supQuantity = supLoadingEntry.getCenLlNquantity();
				final Long supStowageKey = supLoadingEntry.getCenStowNstowageKey();

				if (supQuantity.compareTo(BigDecimal.ONE) > 0) {
					onloadTextA = String.format("%s x %s", supQuantity.toString(), onloadTextA);
					onloadTextB = String.format("%s x %s", supQuantity.toString(), onloadTextB);
				}

				if (onloadTextB.length() < onloadTextA.length()) {
					onloadTextA = onloadTextB;
				}

				for (final FlightLoadingEntry stdLoadingEntry : stdLoadingEntries) {
					final Long stdStowageKey = stdLoadingEntry.getCenStowNstowageKey();

					if (stdStowageKey.equals(supStowageKey)) {
						if (onloadTextA.length() <= 127) {
							stdLoadingEntry.setComputeOnloadText(onloadTextA);
						} else {
							stdLoadingEntry.setComputeOnloadText(onloadTextA.substring(0, 127));
						}
					}
				}
			}

			// no-action
			else if ("N".equals(supActionCode)) {
				for (final FlightLoadingEntry stdLoadingEntry : stdLoadingEntries) {
					final Long stdBellyContainer = stdLoadingEntry.getCenLlNbellyContainer();
					final String stdGalley = stdLoadingEntry.getCenGalCgalley();
					final String stdStowage = stdLoadingEntry.getCenStowCstowage();
					final String stdPlace = stdLoadingEntry.getCenStowCplace();

					if (stdBellyContainer.equals(supBellyContainer)
							&& stdGalley.equals(supGalley)
							&& stdStowage.equals(supStowage)
							&& stdPlace.equals(supPlace)) {
						stdLoadingEntry.setCenLlCaddOnText("No Action");
					}
				}
				supLoadingEntriesItr.remove();
			}
		}

		// add all remaining entries to the result
		flightLoadingEntries.addAll(stdLoadingEntries);
		flightLoadingEntries.addAll(supLoadingEntries);

		// sort the result list
		Comparator<FlightLoadingEntry> comparator = Comparator.comparing(FlightLoadingEntry::getCenGalNsort);
		comparator = comparator.thenComparing(Comparator.comparing(FlightLoadingEntry::getCenStowNsort));
		flightLoadingEntries.sort(comparator);

		// process the result list some more
		for (final FlightLoadingEntry flightLoadingEntry : flightLoadingEntries) {
			// empty all actioncode = L and set record count
			if ("L".equals(flightLoadingEntry.getCenLlCactioncode())) {
				flightLoadingEntry.setCenLlCactioncode("");
			}
		}

		return flightLoadingEntries;
	}

	private int compareTimes(final String timeA, final String timeB) {
		final LocalTime start = LocalTime.parse(timeA);
		final LocalTime stop = LocalTime.parse(timeB);

		return start.compareTo(stop);
	}

	private boolean getProfileFlag(final String key) {
		String profileValue = profileValues.get(key);

		if (profileValue == null) {
			profileValue = nvl(profileService.getClientProfileValue(SECTION, key), "0");
			profileValues.put(key, profileValue);
		}

		return "1".equals(profileValue);
	}

	private Integer getProfileIntValue(final String key) {
		String profileValue = profileValues.get(key);

		if (profileValue == null) {
			profileValue = nvl(profileService.getClientProfileValue(SECTION, key), "0");
			profileValues.put(key, profileValue);
		}

		return Integer.valueOf(profileValue);
	}

	private int getLanguage(final String unit) {
		final String profileValue = nvl(profileService.getClientProfileValue("General", "UseAddLanguage"), "0");
		final boolean isUseAddLanguage = "1".equals(profileValue);

		if (isUseAddLanguage) {
			try {
				final SysUnits sysUnit = findOne(SysUnits.class, unit);
				return sysUnit == null ? 1 : nvl(sysUnit.getNdefaultPlLanguage(), 1);
			} catch (final CbaseMiddlewareBusinessException e) {
				LOGGER.debug("Failed to find SysUnit entity for unit: {}", unit, e);
				return 1;
			}
		} else {
			return 1;
		}
	}

	private String getPostingTypeShort(final Integer postingType) {
		switch (postingType) {
			case 1:
				return "1";
			case 2:
				return "2";
			default:
				return " ";
		}
	}

	private Long getClassNumber(final Long airlineKey, final String llClass) {
		String searchClass = llClass;

		while (searchClass.length() > 0) {
			final CenClassName cenClassName = cenClassNameRepository.findByIdNairlineKeyAndIdCclass(airlineKey, searchClass);

			if (cenClassName == null) {
				searchClass = searchClass.substring(0, searchClass.length() - 1);
			} else {
				return cenClassName.getNclassNumber();
			}
		}

		return 0L;
	}

	private void setShortText(final CenOutMaster com, final int language) {
		final Optional<CenPackinglists> cenPackinglists = cenPackinglistsRepository
				.findById(new CenPackinglistsId(com.getNplIndexKey(), com.getNplDetailKey()));

		if (cenPackinglists.isPresent()) {
			// switch texts according to language
			if (language == 2) {
				com.setCtext(cenPackinglists.get().getCtextShort());
			} else if (language == 3) {
				com.setCtext(cenPackinglists.get().getCtextShort2());
			} else {
				com.setCtext(cenPackinglists.get().getCtext());
			}
			com.setCtextShort(getShortText(com.getCtext(), cenPackinglists.get().getCtextShort()));
		}
	}

	private String getShortText(final String text, final String shortText) {
		if (StringUtils.isBlank(text) || (!StringUtils.isBlank(shortText) && shortText.equals(text))) {
			return shortText;
		} else if (StringUtils.isBlank(shortText)) {
			return text;
		} else {
			return shortText + " " + text;
		}
	}

	private void setPlDetailKey(final CenOutMaster com, final CenOut flight) {
		final CenPackinglists packinglist =
				cenPackinglistsRepository.findPackinglistByNpackinglistIndexKeyAndDdate(com.getNplIndexKey(), flight.getDdeparture());
		com.setNplDetailKey(packinglist == null ? -1L : packinglist.getId().getNpackinglistDetailKey());
	}

	private void setGoodsRecipient(
			final CenOutMaster com,
			final String account,
			final Long airlineKey,
			final String accountFlight,
			final boolean isAdjustAccountCodes) {
		if (com.getCgoodsRecipient() == null) {
			if (com.getCaccount() == null) {
				if (StringUtils.isBlank(account)) {
					com.setCgoodsRecipient(getGoodsRecipient(airlineKey, accountFlight));
				} else {
					com.setCgoodsRecipient(getGoodsRecipient(airlineKey, account));
				}
			} else {
				com.setCgoodsRecipient(getGoodsRecipient(airlineKey, com.getCaccount()));
			}
		} else if (isAdjustAccountCodes && "1".equals(com.getCsalesRel())) {
			// adjust account codes for deviant goods recipient
			setAccountCodeByGoodsRecipient(com, airlineKey);
		}
	}

	private String getGoodsRecipient(final Long airlineKey, final String account) {
		final String sapCodeKey = airlineKey.toString() + account;
		String sapCode = sapCodes.get(sapCodeKey);

		if (sapCode == null) {
			final CenAirlineAccounts airlineAccount =
					cenAirlineAccountsRepository.findByCenAirlinesNairlineKeyAndCaccount(airlineKey, account);

			if (airlineAccount != null) {
				sapCode = nvl(airlineAccount.getCsapCode(), "n/a");
				sapCodes.put(sapCodeKey, sapCode);
			} else {
				LOGGER.info("SAP code not found for airline key: {} and account: {}", airlineKey, account);
				sapCode = "n/a";
				sapCodes.put(sapCodeKey, sapCode);
			}
		}

		return sapCode;
	}

	/**
	 * @param com
	 * @param airlineKey
	 */
	private void setAccountCodeByGoodsRecipient(final CenOutMaster com, final Long airlineKey) {
		final String goodsRecipient = com.getCgoodsRecipient();
		final String sapCode = goodsRecipient.length() > 7 ? goodsRecipient.substring(goodsRecipient.length() - 7) : goodsRecipient;
		final CenAirlineAccounts airlineAccount =
				cenAirlineAccountsRepository.findFirstByCenAirlinesNairlineKeyAndCsapCode(airlineKey, sapCode);

		if (airlineAccount != null) {
			com.setCaccount(airlineAccount.getCaccount());
			com.setNaccountKey(airlineAccount.getNaccountKey());
		} else {
			LOGGER.warn("Account info not found for airline key: {} and sap code: {}", airlineKey, sapCode);
			com.setCaccount(" ");
			com.setNaccountKey(null);
		}
	}

	/**
	 * Set the ccustomerPl and ccustomerPlText for a {@link CenOutMaster} entity
	 *
	 * @param com the {@link CenOutMaster} entity to set the ccustomerPl and ccustomerPlText for
	 */
	private void setEmptyCustomerPl(final CenOutMaster com) {
		if (StringUtils.isBlank(com.getCcustomerPl())) {
			com.setCcustomerPl(com.getCpackinglist());
		}

		if (StringUtils.isBlank(com.getCcustomerPlText())) {
			com.setCcustomerPlText(com.getCtext());
		}
	}

	private int getFrequency(final Date date) {
		final LocalDate refDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

		switch (refDate.getDayOfWeek()) {
			case MONDAY:
				return 1;
			case TUESDAY:
				return 2;
			case WEDNESDAY:
				return 3;
			case THURSDAY:
				return 4;
			case FRIDAY:
				return 5;
			case SATURDAY:
				return 6;
			case SUNDAY:
				return 7;
			default:
				return 0;
		}
	}

	private LocPlTimeFrameFlight getLocPlTimeFrameFlight(final CenOutMaster com, final CenOut flight) {
		final Integer frequency = getFrequency(flight.getDdeparture());
		final List<LocPlTimeFrameFlight> locPlTimeFrameFlights =
				locPlTimeFrameFlightRepository.findByPlIndexKeyAndFlightInfo(com.getNplIndexKey(), flight.getCunit(), flight.getCairline(),
						flight.getNflightNumber(), flight.getCsuffix(), flight.getCtlcFrom(), flight.getCtlcTo(), frequency);

		for (final LocPlTimeFrameFlight locPlTimeFrameFlight : locPlTimeFrameFlights) {
			final Date refDate = relativeDate(flight.getDdeparture(), -locPlTimeFrameFlight.getNoffset());
			final LocUnitPpmValidities locUnitPpmValidity = locPlTimeFrameFlight.getLocUnitWsSchedule().getLocUnitPpmValidities();

			if (refDate.compareTo(locUnitPpmValidity.getDvalidFrom()) >= 0 && refDate.compareTo(locUnitPpmValidity.getDvalidTo()) <= 0) {
				return locPlTimeFrameFlight;
			}
		}

		return null;
	}

	private LocPlTimeFrame getLocPlTimeFrame(final CenOutMaster com, final CenOut flight) {
		final int frequency = getFrequency(flight.getDdeparture());
		final List<LocPlTimeFrame> locPlTimeFrames =
				locPlTimeFrameRepository.findByNpackinglistIndexKeyAndCunitAndNairlineKey(com.getNplIndexKey(),
						flight.getCunit(), flight.getNairlineKey());

		for (final LocPlTimeFrame locPlTimeFrame : locPlTimeFrames) {
			final Date refDate = relativeDate(flight.getDdeparture(), -locPlTimeFrame.getNoffset());
			final LocUnitPpmValidities locUnitPpmValidity = locPlTimeFrame.getLocUnitWsSchedule().getLocUnitPpmValidities();

			final boolean isMatchingFrequency;
			switch (frequency) {
				case 1:
					isMatchingFrequency = locPlTimeFrame.getLocPlTimeFrameVariant().getNfreq1() == 1;
					break;
				case 2:
					isMatchingFrequency = locPlTimeFrame.getLocPlTimeFrameVariant().getNfreq2() == 1;
					break;
				case 3:
					isMatchingFrequency = locPlTimeFrame.getLocPlTimeFrameVariant().getNfreq3() == 1;
					break;
				case 4:
					isMatchingFrequency = locPlTimeFrame.getLocPlTimeFrameVariant().getNfreq4() == 1;
					break;
				case 5:
					isMatchingFrequency = locPlTimeFrame.getLocPlTimeFrameVariant().getNfreq5() == 1;
					break;
				case 6:
					isMatchingFrequency = locPlTimeFrame.getLocPlTimeFrameVariant().getNfreq6() == 1;
					break;
				case 7:
					isMatchingFrequency = locPlTimeFrame.getLocPlTimeFrameVariant().getNfreq7() == 1;
					break;
				default:
					isMatchingFrequency = false;
			}

			if (isMatchingFrequency && refDate.compareTo(locUnitPpmValidity.getDvalidFrom()) >= 0
					&& refDate.compareTo(locUnitPpmValidity.getDvalidTo()) <= 0) {
				return locPlTimeFrame;
			}
		}

		return null;
	}

	private void setTimeframe(final CenOutMaster com, final CenOut flight) {
		final LocPlTimeFrameFlight pltff = getLocPlTimeFrameFlight(com, flight);

		if (pltff != null) {
			com.setNpltimeframeIndex(null);
			com.setNbatch(null);
			com.setDprodDate(relativeDate(flight.getDdeparture(), -pltff.getNoffset()));
			com.setNworkscheduleIndex(pltff.getLocUnitWsSchedule().getNworkscheduleIndex());
			com.setNpltfFlightIndexGroup(pltff.getNpltfFlightIndexGroup());
			com.setNpltfFlightIndex(pltff.getNpltfFlightIndex());
		} else {
			final LocPlTimeFrame pltf = getLocPlTimeFrame(com, flight);

			if (pltf != null) {
				com.setNpltimeframeIndex(pltf.getNpltimeframeIndex());
				com.setNbatch(pltf.getNbatch());
				com.setDprodDate(relativeDate(flight.getDdeparture(), -pltf.getNoffset()));
				com.setNworkscheduleIndex(pltf.getLocUnitWsSchedule().getNworkscheduleIndex());
				com.setNpltfFlightIndexGroup(null);
				com.setNpltfFlightIndex(null);
			} else {
				com.setNpltimeframeIndex(null);
				com.setNbatch(null);
				com.setDprodDate(null);
				com.setNworkscheduleIndex(null);
				com.setNpltfFlightIndexGroup(null);
				com.setNpltfFlightIndex(null);
			}
		}
	}

	private void setForecastFields(final CenOutMaster com, final boolean isFillForecastFields) {
		if (isFillForecastFields) {
			// TODO: Fill forecast fields
		} else {
			com.setNparamsKey1(-1L);
			com.setNparamsKey2(-1L);
			com.setNparamsKey3(-1L);
			com.setNparamsMin(-1L);
		}
	}

	private void updateForecastFields(final CenOutMaster com, final CenOutMaster comNew) {
		// TODO: update forecast fields
		// dsCenOutMaster.SetItem(lFind,"nparams_key1", of_min_forcast(il_FC_Parm1, dsCenOutMaster.GetItemNumber(lFind,"nparams_key1")))
		// dsCenOutMaster.SetItem(lFind,"nparams_key2", of_min_forcast(il_FC_Parm2, dsCenOutMaster.GetItemNumber(lFind,"nparams_key2")))
		// dsCenOutMaster.SetItem(lFind,"nparams_key3", of_min_forcast(il_FC_Parm3, dsCenOutMaster.GetItemNumber(lFind,"nparams_key3")))
		// dsCenOutMaster.SetItem(lFind,"nparams_min",of_min_forcast(dsCenOutMaster.GetItemNumber(lFind,"nparams_key1"),
		// dsCenOutMaster.GetItemNumber(lFind,"nparams_key2")))
		// dsCenOutMaster.SetItem(lFind,"nparams_min",of_min_forcast(dsCenOutMaster.GetItemNumber(lFind,"nparams_min"),
		// dsCenOutMaster.GetItemNumber(lFind,"nparams_key3")))
	}

	/**
	 * Set the nreckoning on a {@link CenOutMaster} entity by a given master reckoning type
	 *
	 * @param com the {@link CenOutMaster} entity to set the reckoning type for
	 * @param masterReckoning the master reckoning type as {@link CbaseReckoningType}
	 */
	private void setReckoning(final CenOutMaster com, final CbaseReckoningType masterReckoning) {
		final int billingOnly = getProfileIntValue(PROFILE_WITH_BILLING_ONLY);
		final CbaseReckoningType childReckoning = CbaseReckoningType.getEnum(com.getNreckoning().intValue());

		if (masterReckoning == CbaseReckoningType.PRODUCTION) {
			if (billingOnly == 1 || billingOnly == 2) {
				if (childReckoning == CbaseReckoningType.BILLING_AND_PRODUCTION) {
					com.setNreckoning((long) CbaseReckoningType.PRODUCTION.getTypeValue());
				} else if (childReckoning == CbaseReckoningType.BILLING) {
					com.setNreckoning((long) CbaseReckoningType.INFORMATION.getTypeValue());
				}
			}
		} else if (masterReckoning == CbaseReckoningType.BILLING) {
			if (billingOnly == 0 || billingOnly == 1) {
				if (childReckoning != CbaseReckoningType.INFORMATION && childReckoning != CbaseReckoningType.REQUEST) {
					com.setNreckoning((long) CbaseReckoningType.BILLING.getTypeValue());
				}
			} else if (billingOnly == 2) {
				if (childReckoning == CbaseReckoningType.BILLING_AND_PRODUCTION) {
					com.setNreckoning((long) CbaseReckoningType.BILLING.getTypeValue());
				} else if (childReckoning == CbaseReckoningType.PRODUCTION) {
					com.setNreckoning((long) CbaseReckoningType.INFORMATION.getTypeValue());
				}
			}
		} else if (masterReckoning == CbaseReckoningType.INFORMATION || masterReckoning == CbaseReckoningType.REQUEST) {
			com.setNreckoning((long) masterReckoning.getTypeValue());
		}
	}

	/**
	 * Sets npercent, nreserve and nreserveVersion on a {@link CenOutMaster} entity
	 *
	 * @param masterPackinglist
	 * @param com
	 * @param flight
	 * @param plAreaKey
	 * @param isUseReserve
	 */
	private void setReserve(
			final CenOutMaster masterPackinglist,
			final CenOutMaster com,
			final CenOut flight,
			final Long plAreaKey,
			final boolean isUseReserve) {

		// calculate reserve
		if (isUseReserve) {
			final LocalDate refDate = flight.getDdeparture().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			final LocUnitPlReserve reserve = locUnitPlReserveRepository.findByPlAreaKeyAndRefTimeAndRefDate(plAreaKey,
					flight.getCdepartureTime(), flight.getDdeparture());

			if (reserve != null) {
				switch (refDate.getDayOfWeek()) {
					case MONDAY:
						com.setNreserve(nvl(reserve.getNday1(), BigDecimal.ZERO));
						break;
					case TUESDAY:
						com.setNreserve(nvl(reserve.getNday2(), BigDecimal.ZERO));
						break;
					case WEDNESDAY:
						com.setNreserve(nvl(reserve.getNday3(), BigDecimal.ZERO));
						break;
					case THURSDAY:
						com.setNreserve(nvl(reserve.getNday4(), BigDecimal.ZERO));
						break;
					case FRIDAY:
						com.setNreserve(nvl(reserve.getNday5(), BigDecimal.ZERO));
						break;
					case SATURDAY:
						com.setNreserve(nvl(reserve.getNday6(), BigDecimal.ZERO));
						break;
					case SUNDAY:
						com.setNreserve(nvl(reserve.getNday7(), BigDecimal.ZERO));
						break;
					default:
						break;
				}

				com.setNreserveVersion(com.getNreserve());
				com.setNpercent(reserve.getNpercent());
				com.setNareaKey(reserve.getLocUnitPlAreas().getLocUnitAreas().getNareaKey());
				com.setNworkstationKey(reserve.getLocUnitPlAreas().getNworkstationKey());

				if (nvl(com.getNpercent(), 0) == 1 && nvl(com.getNreserve(), BigDecimal.ZERO).equals(BigDecimal.ZERO)) {
					com.setNpercent(0);
				}
			} else {
				// com.setNpercent(masterPackinglist.getNpercent()); // TODO: Das ist in PB manchmal auch NULL o_0
				com.setNreserve(BigDecimal.ZERO);
				com.setNreserveVersion(BigDecimal.ZERO);
			}

			if (com.getNlevel() > 1) {
				final BigDecimal masterPackinglistNreserve = nvl(masterPackinglist.getNreserve(), BigDecimal.ZERO);
				final BigDecimal masterPackinglistNreserveVersion = nvl(masterPackinglist.getNreserveVersion(), BigDecimal.ZERO);
				final BigDecimal comNreserve = nvl(com.getNreserve(), BigDecimal.ZERO);
				final BigDecimal comNreserveVersion = nvl(com.getNreserveVersion(), BigDecimal.ZERO);

				if (nvl(masterPackinglist.getNpercent(), 0) == 1) {
					if (masterPackinglistNreserve.compareTo(comNreserve) > 0) {
						com.setNreserve(masterPackinglistNreserve);
					}

					if (masterPackinglistNreserveVersion.compareTo(comNreserveVersion) > 0) {
						com.setNreserveVersion(masterPackinglistNreserveVersion);
					}
				} else {
					if (nvl(com.getNpercent(), 0) != 1) {
						if (com.getNquantity().equals(truncDecimal(com.getNquantity()))) {
							if (masterPackinglistNreserve.compareTo(comNreserve) > 0) {
								com.setNreserve(masterPackinglistNreserve);
							}
						} else {
							com.setNreserve(BigDecimal.ZERO);
						}

						if (com.getNquantityVersion().equals(truncDecimal(com.getNquantityVersion()))) {
							if (masterPackinglistNreserveVersion.compareTo(comNreserveVersion) > 0) {
								com.setNreserve(masterPackinglistNreserveVersion);
							}
						} else {
							com.setNreserve(BigDecimal.ZERO);
						}
					}
				}
			}
		} else {
			com.setNpercent(0);
			com.setNreserve(BigDecimal.ZERO);
			com.setNreserveVersion(BigDecimal.ZERO);
		}
	}

	/**
	 * Sets nquantity, nquantityVersion and nreckoning on a {@link CenOutMaster} entity for cancelled flights
	 *
	 * @param com
	 * @param isSetQuantityVersion
	 */
	private void setValuesForCancelledFlight(final CenOutMaster com, final boolean isSetQuantityVersion) {
		final boolean isDoNotSet0ForCxFlights = getProfileFlag(PROFILE_NO_0_FOR_CX_FLIGHTS);
		if (isDoNotSet0ForCxFlights) {
			final CbaseReckoningType reckoning = CbaseReckoningType.getEnum(com.getNreckoning().intValue());
			if (reckoning == CbaseReckoningType.PRODUCTION) {
				com.setNquantity(BigDecimal.ZERO);
				if (isSetQuantityVersion) {
					com.setNquantityVersion(BigDecimal.ZERO);
				}
			} else if (reckoning == CbaseReckoningType.BILLING_AND_PRODUCTION) {
				com.setNreckoning((long) CbaseReckoningType.BILLING.getTypeValue());
			}
		}
	}

	/**
	 * Helper to convert GR to KG and ML to LT
	 *
	 * @param com
	 */
	private void convertGrToKgAndMlToLt(final CenOutMaster com) {
		switch (com.getCunit().toUpperCase()) {
			// convert GR -> KG
			case "GR":
				com.setNquantity(com.getNquantity().divide(BigDecimal.valueOf(1000)));
				com.setNquantityVersion(com.getNquantityVersion().divide(BigDecimal.valueOf(1000)));
				com.setCunit("KG");
				break;
			// convert ML -> LT
			case "ML":
				com.setNquantity(com.getNquantity().divide(BigDecimal.valueOf(1000)));
				com.setNquantityVersion(com.getNquantityVersion().divide(BigDecimal.valueOf(1000)));
				com.setCunit("LT");
				break;
			default:
				break;
		}
	}

	/**
	 * Helper - gets a new sequence out of a pool of sequences which is read in batches to increase performance
	 *
	 * @return the next free sequence for CenOutMaster
	 */
	private Long getNextCenOutMasterSequence(final List<Long> cenOutMasterSequences) {
		if (cenOutMasterSequences.isEmpty()) {
			LOGGER.debug("Get 100 new sequences for CEN_OUT_MASTER");
			cenOutMasterSequences.addAll(nativeQueryProvider.getNextSeqValues(CbaseSequence.SEQ_CEN_OUT_MASTER, 100));
		}
		return cenOutMasterSequences.remove(cenOutMasterSequences.size() - 1);
	}

	/**
	 * Helper - Null Value Logic
	 *
	 * @param value a value to check for null
	 * @param fallbackValue a fallback value
	 * @return the first value or the fallback value in case the first value is null
	 */
	private <T> T nvl(final T value, final T fallbackValue) {
		return value == null ? fallbackValue : value;
	}

	/**
	 * Helper - calculates the relative date using a offset in days
	 *
	 * @param originalDate the date to start the calculation from
	 * @param offsetInDays the offset to add in days
	 * @return a new date representing the original date + the offset
	 */
	private Date relativeDate(final Date originalDate, final int offsetInDays) {
		final long millisOfOneDay = 24L * 60L * 60L * 1000L;
		return new Date(originalDate.getTime() + offsetInDays * millisOfOneDay);
	}
}