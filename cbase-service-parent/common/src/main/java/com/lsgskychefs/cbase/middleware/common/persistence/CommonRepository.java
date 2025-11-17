/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.persistence;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;
import javax.persistence.StoredProcedureQuery;
import javax.persistence.TemporalType;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.persistence.metamodel.SingularAttribute;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.lsgskychefs.cbase.middleware.common.masterdata.pojo.FlightStowageDocsEntry;
import com.lsgskychefs.cbase.middleware.common.masterdata.pojo.StowageItemListEntry;
import com.lsgskychefs.cbase.middleware.common.pojo.AircraftEntry;
import com.lsgskychefs.cbase.middleware.common.pojo.ExplodedPackinglistEntry;
import com.lsgskychefs.cbase.middleware.common.pojo.FlightMdLoadingEntry;
import com.lsgskychefs.cbase.middleware.common.pojo.FlightMealsEntry;
import com.lsgskychefs.cbase.middleware.common.pojo.FlightMealsGroupedEntry;
import com.lsgskychefs.cbase.middleware.common.pojo.FlightSpmlDetailEntry;
import com.lsgskychefs.cbase.middleware.common.pojo.FlightStowageContentEntry;
import com.lsgskychefs.cbase.middleware.common.pojo.PackinglistExplosionEntry;
import com.lsgskychefs.cbase.middleware.common.pojo.PackinglistExplosionParameter;
import com.lsgskychefs.cbase.middleware.persistence.CbaseMiddlewareRepository;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseLoginHistKind;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.NamedQueries;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PfArchiveFlight;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOut;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutSpml;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPpsCateringOrder;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPpsContainer;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocPpsProdBom;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLogin;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLoginHistory;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLoginHistory_;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysMsgDelivery;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysMsgSubscriber;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysTranslate;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysTranslate_;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysUnits;
import com.lsgskychefs.cbase.middleware.persistence.pojo.Translation;
import com.lsgskychefs.cbase.middleware.persistence.query.CbaseMiddlewareNativeQuery;
import com.lsgskychefs.cbase.middleware.persistence.query.CbaseMiddlewareQuery;

/**
 * Common repository class. For special query/jpa functionality.
 *
 * @author Ingo Rietzschel - U125742
 */
@Repository
public class CommonRepository extends CbaseMiddlewareRepository {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(CommonRepository.class);

	/** 1 - German language representing int value */
	private static final int GERMAN_LANGUAGE = 1;

	/** 2 - English language representing int value */
	private static final int ENGLISH_LANGUAGE = 2;

	/** 3 - Russian language representing int value */
	private static final int RUSSIAN_LANGUAGE = 3;

	/** 4 - Spain language representing int value */
	private static final int SPAIN_LANGUAGE = 4;

	/** 5 - German language representing int value */
	private static final int FREE5_LANGUAGE = 5;

	/** 6 - German language representing int value */
	private static final int FREE6_LANGUAGE = 6;

	/** 7 - German language representing int value */
	private static final int FREE7_LANGUAGE = 7;

	/** 8 - German language representing int value */
	private static final int FREE8_LANGUAGE = 8;

	/** 9 - German language representing int value */
	private static final int FREE9_LANGUAGE = 9;

	/** Native query argument key - arg_include_self */
	public static final String ARG_INCLUDE_SELF = "arg_include_self";

	/** query for flight spml details loaded and inject as String. */
	@Value("#{fileHelper.getSqlQuery('flight-spml-details-query.sql')}")
	private CbaseMiddlewareNativeQuery flightSpmlDetailsQuery;

	/** query for flight meals loaded and inject as String. */
	@Value("#{fileHelper.getSqlQuery('flight-meals-query.sql')}")
	private CbaseMiddlewareNativeQuery flightMealsQuery;

	/** query for flight meals grouped by packinglist and inject as String. */
	@Value("#{fileHelper.getSqlQuery('flight-meals-grouped-query.sql')}")
	private CbaseMiddlewareNativeQuery flightMealsGroupedQuery;

	/** query for flight md loadings loaded and inject as String. */
	@Value("#{fileHelper.getSqlQuery('flight-loading-md-lo-query.sql')}")
	private CbaseMiddlewareNativeQuery flightMdLoadingQuery;

	/** query for flight stowage contents loaded and inject as String. */
	@Value("#{fileHelper.getSqlQuery('flight-stowage-md-co-query.sql')}")
	private CbaseMiddlewareNativeQuery flightMdStowageQuery;

	/** query for flight stowages loaded and inject as String. */
	@Value("#{fileHelper.getSqlQuery('flight-stowage-packinglist-detail-query.sql')}")
	private CbaseMiddlewareNativeQuery flightStowagePackinglistDetailQuery;

	/** query for packinglist explosions with ori unit loaded and inject as String. */
	@Value("#{fileHelper.getSqlQuery('packinglist-explosion-with-ori-unit-query.sql')}")
	private CbaseMiddlewareNativeQuery packinglistExplosionWOUQuery;

	/** query for packinglist explosions loaded and inject as String. */
	@Value("#{fileHelper.getSqlQuery('packinglist-explosion-query.sql')}")
	private CbaseMiddlewareNativeQuery packinglistExplosionQuery;

	/** query for general packinglist explosions loaded and inject as String. */
	@Value("#{fileHelper.getSqlQuery('packinglist-general-explosion-query.sql')}")
	private CbaseMiddlewareNativeQuery packinglistGeneralExplosionQuery;

	/** query for units by context and inject as String. */
	@Value("#{fileHelper.getSqlQuery('units-by-context-query.sql')}")
	private CbaseMiddlewareNativeQuery unitsByContextQuery;

	/** query for units by context and inject as String. */
	@Value("#{fileHelper.getSqlQuery('delta-upload/aircraft-config-by-registration-query.sql')}")
	private CbaseMiddlewareNativeQuery aircraftConfigByRegistrationQuery;

	/** query for stowage itemlist and inject as String. */
	@Value("#{fileHelper.getSqlQuery('masterdata/stowage-itemlist-query.sql')}")
	private CbaseMiddlewareNativeQuery stowageItemListQuery;

	/** query for flight stowage documents and inject as String. */
	@Value("#{fileHelper.getSqlQuery('masterdata/flight-stowage-docs-query.sql')}")
	private CbaseMiddlewareNativeQuery flightStowageDocsQuery;

	/**
	 * Gets the flight spml details.
	 *
	 * @param nmasterKey id for {@link CenOutSpml}
	 * @return the flight spml details
	 */
	public List<FlightSpmlDetailEntry> findFlightSpmlDetails(final long nmasterKey) {
		final CbaseMiddlewareQuery<FlightSpmlDetailEntry> query =
				nativeQueryProvider.createNativeQuery(flightSpmlDetailsQuery, FlightSpmlDetailEntry.class)
						.setParameter("arg_master_key", nmasterKey);
		return query.getResultList();
	}

	/**
	 * Gets the flight meals.<br>
	 * cbase_data_layer.uo_cbase_data_layer.of_get_flight_meals
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @param nmoduleType 0 for Meals, 1 for Additional loading
	 * @param cclass -1 if not wanted
	 * @return the flight meals
	 */
	public List<FlightMealsEntry> findFlightMeals(final long nresultKey, final long nmoduleType, final String cclass) {
		final CbaseMiddlewareQuery<FlightMealsEntry> query =
				nativeQueryProvider.createNativeQuery(flightMealsQuery, FlightMealsEntry.class)
						.setParameter(ARG_RESULT_KEY, nresultKey)
						.setParameter("arg_module", nmoduleType)
						.setParameter("arg_class", cclass);
		return query.getResultList();
	}

	/**
	 * Gets the flight meals aggregated.
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @param nmoduleType 0 for Meals, 1 for Additional loading
	 * @param cclass -1 if not wanted
	 * @return the flight meals GROUPED
	 */
	public List<FlightMealsGroupedEntry> findFlightMealsGrouped(final long nresultKey, final long nmoduleType, final String cclass) {
		final CbaseMiddlewareQuery<FlightMealsGroupedEntry> query =
				nativeQueryProvider.createNativeQuery(flightMealsGroupedQuery, FlightMealsGroupedEntry.class)
						.setParameter(ARG_RESULT_KEY, nresultKey)
						.setParameter("arg_module", nmoduleType)
						.setParameter("arg_class", cclass);
		return query.getResultList();
	}

	/**
	 * Gets the flight loading data.<br>
	 * cbase_data_layer.uo_cbase_data_layer.of_get_flight_loading
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @param ntransaction transaction id
	 * @param nstowageKey stowage id
	 * @return the flight loading data
	 */
	public List<FlightMdLoadingEntry> findFlightMdLoading(final long nresultKey, final long ntransaction, final Long nstowageKey) {
		final CbaseMiddlewareQuery<FlightMdLoadingEntry> query =
				nativeQueryProvider.createNativeQuery(flightMdLoadingQuery, FlightMdLoadingEntry.class)
						.setParameter(ARG_RESULT_KEY, nresultKey)
						.setParameter("arg_transaction", ntransaction)
						.setParameter("arg_stowage_key", nstowageKey, Long.class);
		return query.getResultList();
	}

	/**
	 * Get the flight MDCo stowage content.
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @param ntransaction transaction id
	 * @param nstowageKey stowage id
	 * @param nbelly flight belly
	 * @param date date
	 * @return the flight stowage content
	 */
	public List<FlightStowageContentEntry> findFlightMdStowageContents(
			final long nresultKey,
			final long ntransaction,
			final Long nstowageKey,
			final long nbelly,
			final Date date) {

		final CbaseMiddlewareQuery<FlightStowageContentEntry> query =
				nativeQueryProvider.createNativeQuery(flightMdStowageQuery, FlightStowageContentEntry.class)
						.setParameter(ARG_RESULT_KEY, nresultKey)
						.setParameter("arg_transaction", ntransaction)
						.setParameter("arg_stowage_key", nstowageKey, Long.class)
						.setParameter("arg_belly", nbelly)
						.setParameter(ARG_DATE, date, TemporalType.TIMESTAMP);
		return query.getResultList();
	}

	/**
	 * Get the flight stowage packinglist content.
	 *
	 * @param npackinglistIndexKey key for packinglist
	 * @param date date
	 * @return the flight stowage content
	 */
	public List<FlightStowageContentEntry> findFlightStowagePackinglistContents(final long npackinglistIndexKey, final Date date) {
		final List<Long> reckoning = new ArrayList<>();
		reckoning.add(0L);
		final CbaseMiddlewareQuery<FlightStowageContentEntry> query =
				nativeQueryProvider.createNativeQuery(flightStowagePackinglistDetailQuery, FlightStowageContentEntry.class)
						.setParameter(ARG_INDEX, npackinglistIndexKey)
						.setParameter(ARG_RECKONING, reckoning)
						.setParameter(ARG_DATE, date, TemporalType.TIMESTAMP);
		return query.getResultList();
	}

	/**
	 * Load the explosion entries.
	 *
	 * @param param the parameter values
	 * @return the explosion entries
	 */
	public List<PackinglistExplosionEntry> findPackinglistExplosionData(final PackinglistExplosionParameter param) {
		final CbaseMiddlewareQuery<PackinglistExplosionEntry> query =
				nativeQueryProvider.createNativeQuery(packinglistExplosionQuery, PackinglistExplosionEntry.class)
						.setParameter(ARG_INDEX, param.getIndex())
						.setParameter(ARG_DATE, param.getDate(), TemporalType.TIMESTAMP)
						.setParameter(ARG_INCLUDE_SELF, param.getIncludeSelf())
						.setParameter(ARG_CSC, param.getCsc())
						.setParameter("arg_quantity", param.getQuantity())
						.setParameter("arg_billing_only", param.getBillingOnly())
						.setParameter(ARG_RECKONING, param.getReckoning())
						.setParameter("arg_time", param.getTime())
						.setParameter("arg_with_z", param.getWithZ());
		return query.getResultList();
	}

	/**
	 * Explode a packinglist.
	 *
	 * @param param the parameter values
	 * @return the explosion entries
	 */
	public List<ExplodedPackinglistEntry> explodePackinglist(final PackinglistExplosionParameter param) {
		final CbaseMiddlewareQuery<ExplodedPackinglistEntry> query =
				nativeQueryProvider.createNativeQuery(packinglistGeneralExplosionQuery, ExplodedPackinglistEntry.class)
						.setParameter(ARG_INDEX, param.getIndex())
						.setParameter(ARG_DATE, param.getDate(), TemporalType.TIMESTAMP)
						.setParameter(ARG_INCLUDE_SELF, param.getIncludeSelf())
						.setParameter("arg_base_quantity", param.getQuantity());
		return query.getResultList();
	}

	/**
	 * Load the explosion entries.
	 *
	 * @param param the parameter values
	 * @return the explosion entries
	 */
	public List<PackinglistExplosionEntry> findPackinglistExplosionWOUData(final PackinglistExplosionParameter param) {
		final CbaseMiddlewareQuery<PackinglistExplosionEntry> query =
				nativeQueryProvider.createNativeQuery(packinglistExplosionWOUQuery, PackinglistExplosionEntry.class)
						.setParameter(ARG_INDEX, param.getIndex())
						.setParameter(ARG_DATE, param.getDate(), TemporalType.TIMESTAMP)
						.setParameter(ARG_INCLUDE_SELF, param.getIncludeSelf())
						.setParameter(ARG_CSC, param.getCsc())
						.setParameter("arg_quantity", param.getQuantity())
						.setParameter("arg_billing_only", param.getBillingOnly())
						.setParameter(ARG_RECKONING, param.getReckoning())
						.setParameter("arg_time", param.getTime());
		return query.getResultList();
	}

	/**
	 * Get the last change password history entries({@link SysLoginHistory}) for given user({@link SysLogin})
	 *
	 * @param sysLogin user to get last change password history entries.
	 * @param maxResult the result size
	 * @return the last last password history entries.
	 */
	public List<SysLoginHistory> findLastPwdChanges(final SysLogin sysLogin, final int maxResult) {
		final CriteriaBuilder cb = em.getCriteriaBuilder();
		final CriteriaQuery<SysLoginHistory> cq = cb.createQuery(SysLoginHistory.class);
		final Root<SysLoginHistory> root = cq.from(SysLoginHistory.class);

		final Predicate isChangePwd = cb.equal(root.get(SysLoginHistory_.sysLoginHistkind), CbaseLoginHistKind.PASSWORD_CHANGED.getId());
		final Predicate isUser = cb.equal(root.get(SysLoginHistory_.sysLogin), sysLogin);

		cq.where(cb.and(isChangePwd, isUser));
		return em.createQuery(cq).setMaxResults(maxResult).getResultList();
	}

	/**
	 * Load units by Context.
	 *
	 * @param cclient current client
	 * @param nsupplierKey the supplier
	 * @param nuserId current user id
	 * @param nroleId relevant role id
	 * @return units by context
	 */
	@SuppressWarnings("unchecked")
	public List<SysUnits> findUnityByContext(final String cclient, final Long nsupplierKey, final long nuserId, final int nroleId) {
		final Query query = em.createNativeQuery(unitsByContextQuery.getQuery(), SysUnits.class)
				.setParameter("arg_cclient", cclient)
				.setParameter("arg_nuser", nuserId)
				.setParameter("arg_nsupplier", nsupplierKey)
				.setParameter("arg_nrole", nroleId);
		return query.getResultList();

	}

	/**
	 * Find {@link CenPpsCateringOrder} by {@link CenPpsContainer}.
	 *
	 * @param ncontainerKey PK from {@link CenPpsContainer}
	 * @return the {@link CenPpsContainer}
	 */
	public CenPpsCateringOrder findCenPpsCateringOrder(final long ncontainerKey) {
		final TypedQuery<CenPpsCateringOrder> query =
				em.createNamedQuery(NamedQueries.CEN_PPS_CATERING_ORDER_BY_CONTAINER, CenPpsCateringOrder.class)
						.setMaxResults(1)
						.setParameter("ncontainerKey", ncontainerKey);
		final List<CenPpsCateringOrder> list = query.getResultList();
		if (list.isEmpty()) {
			return null;
		}
		return list.get(0);

	}

	/**
	 * Find {@link CenPpsCateringOrder} by {@link CenPpsContainer}.
	 *
	 * @param ncontainerKey PK from {@link CenPpsContainer}
	 * @return the {@link CenPpsContainer}
	 */
	public LocPpsProdBom findLocPpsProdBom(final long ncontainerKey) {
		final TypedQuery<LocPpsProdBom> query = em.createNamedQuery(NamedQueries.LOC_PPS_PROD_BOM_BY_CONTAINER, LocPpsProdBom.class)
				.setMaxResults(1)
				.setParameter("ncontainerKey", ncontainerKey);
		final List<LocPpsProdBom> list = query.getResultList();
		if (list.isEmpty()) {
			return null;
		}
		return list.get(0);
	}

	/**
	 * Log the aircraft configuration with registration info
	 *
	 * @param cregistration the registration info
	 * @return the aircraft configurations
	 */
	public List<AircraftEntry> findAircraftConfigByRegistration(final String cregistration) {
		final CbaseMiddlewareQuery<AircraftEntry> query =
				nativeQueryProvider.createNativeQuery(aircraftConfigByRegistrationQuery, AircraftEntry.class)
						.setParameter("arg_cregistration", cregistration);
		return query.getResultList();
	}

	/**
	 * Return the translation for given language.
	 *
	 * @param languageColumnPosition the language column position to select
	 * @return the translation for given language.
	 */
	public List<Translation> getTranlations(final int languageColumnPosition) {
		final SingularAttribute<SysTranslate, String> id = SysTranslate_.cpurpose;
		final SingularAttribute<SysTranslate, String> clanguage = getLanguageColumn(languageColumnPosition);

		final CriteriaBuilder builder = em.getCriteriaBuilder();
		final CriteriaQuery<Translation> cq = builder.createQuery(Translation.class);

		final Root<SysTranslate> root = cq.from(SysTranslate.class);
		cq.multiselect(root.get(id), root.get(clanguage));
		cq.orderBy(builder.asc(root.get(id)));
		return em.createQuery(cq).getResultList();

	}

	/**
	 * Get the current database instance name.
	 *
	 * @return the current database instance name.
	 */
	public String getDBInfo() {
		return nativeQueryProvider.getDBInfo();
	}

	/**
	 * Writes the History for given flight. Currently this procedure has no functional checks. If Procedure fails the SQL exception will be
	 * raised! Writes: FlightHistory PaxHistory AdditionalLoadingHistory MealHistory SpecialMealHistory
	 *
	 * @param nresultKey the flight's primary key
	 * @param ntransaction the flight's new transaction key. (Usually generated by Sequence)
	 */
	public void writeFlightHistory(final Long nresultKey, final Long ntransaction) {
		final StoredProcedureQuery query = this.em.createNamedStoredProcedureQuery(PfArchiveFlight.PF_ARCHIVE_FLIGHT)
				.setParameter(PfArchiveFlight.P_NRESULT_KEY, nresultKey)
				.setParameter(PfArchiveFlight.P_TRANSAKTION_KEY, ntransaction);

		query.execute();
	}

	/**
	 * Gets the flight stowage item list data.<br>
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @return the flight stowage item list data
	 */
	public List<StowageItemListEntry> findStowageItemList(final long nresultKey) {
		final CbaseMiddlewareQuery<StowageItemListEntry> query =
				nativeQueryProvider.createNativeQuery(stowageItemListQuery, StowageItemListEntry.class)
						.setParameter(ARG_RESULT_KEY, nresultKey);
		return query.getResultList();
	}

	/**
	 * Gets the flight stowage documents data order by nprio.<br>
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @return the flight stowage documents data
	 */
	public List<FlightStowageDocsEntry> findFlightStowageDocs(final long nresultKey) {
		final CbaseMiddlewareQuery<FlightStowageDocsEntry> query =
				nativeQueryProvider.createNativeQuery(flightStowageDocsQuery, FlightStowageDocsEntry.class)
						.setParameter(ARG_RESULT_KEY, nresultKey);
		return query.getResultList();
	}

	/**
	 * Change the given database user password to the given new password.
	 *
	 * @param userName the user whose password is to be changed
	 * @param newPwd the new password
	 */
	public void changeDbUserPwd(final String userName, final String newPwd) {
		// query to change db user password.
		final String q = "ALTER USER " + userName + " IDENTIFIED BY \"" + newPwd + "\"";
		final Query query = em.createNativeQuery(q);
		query.executeUpdate();
	}

	/**
	 * Delete all {@link SysMsgSubscriber} without {@link SysMsgDelivery}.
	 *
	 * @return the deleted count
	 */
	public int deleteUnusedSubscriber() {
		final Query query = em.createQuery(
				"DELETE FROM SysMsgSubscriber s WHERE s.id.cqueue NOT IN (SELECT d.id.cqueue FROM SysMsgDelivery d) ");
		return query.executeUpdate();
	}

	private SingularAttribute<SysTranslate, String> getLanguageColumn(final int languageColumnPosition) {
		switch (languageColumnPosition) {
		case GERMAN_LANGUAGE:
			return SysTranslate_.cgerman;
		case ENGLISH_LANGUAGE:
			return SysTranslate_.cenglish;
		case RUSSIAN_LANGUAGE:
			return SysTranslate_.clanguage3;
		case SPAIN_LANGUAGE:
			return SysTranslate_.clanguage4;
		case FREE5_LANGUAGE:
			return SysTranslate_.clanguage5;
		case FREE6_LANGUAGE:
			return SysTranslate_.clanguage6;
		case FREE7_LANGUAGE:
			return SysTranslate_.clanguage7;
		case FREE8_LANGUAGE:
			return SysTranslate_.clanguage8;
		case FREE9_LANGUAGE:
			return SysTranslate_.clanguage9;

		default:
			LOGGER.warn("Unsupported language {} - default language used", languageColumnPosition);
			return SysTranslate_.cgerman;
		}
	}

}
