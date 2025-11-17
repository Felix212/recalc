/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseMiddlewareService;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenAirlineUnit;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenAirlineUnitId;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenDocGenQueue;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenDocGenUd;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOut;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutDocuments;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutLabels;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMd;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdBlob;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdDe;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdLo;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdPs;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocSetup;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLogin;
import com.lsgskychefs.cbase.middleware.persistence.general.CenDocGenQueueRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutDocumentsRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutLabelsRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutMdBlobRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutMdCoRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutMdDeRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutMdLoRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutMdPsRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutMdRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.LocSetupRepository;

/**
 * Service class for the documents generation jobs.
 *
 * @author Ingo Rietzschel - U125742
 */
@Service
public class DocumentsJobService extends AbstractCbaseMiddlewareService {

	/** DOCBROWSER */
	private static final String DOCBROWSER = "DOCBROWSER";
	/** length of DOCBROWSER string. */
	private static final int DOCBROWSER_LENGTH = DOCBROWSER.length();

	/** Repository for {@link LocSetup} entities. */
	@Autowired
	private LocSetupRepository locSetupRepository;

	/** Repository for {@link CenDocGenQueue} entities. */
	@Autowired
	private CenDocGenQueueRepository cenDocGenQueueRepository;

	/** Repository for {@link CenOutDocuments} entities. */
	@Autowired
	private CenOutDocumentsRepository cenOutDocumentsRepository;

	/** Repository for {@link CenOutLabels} entities. */
	@Autowired
	private CenOutLabelsRepository cenOutLabelsRepository;

	/** Repository for {@link CenOutMd} entities. */
	@Autowired
	private CenOutMdRepository cenOutMdRepository;

	/** Repository for {@link CenOutMdBlob} entities. */
	@Autowired
	private CenOutMdBlobRepository cenOutMdBlobRepository;

	/** Repository for {@link cenOutMdCo} entities. */
	@Autowired
	private CenOutMdCoRepository cenOutMdCoRepository;

	/** Repository for {@link CenOutMdDe} entities. */
	@Autowired
	private CenOutMdDeRepository cenOutMdDeRepository;

	/** Repository for {@link CenOutMdLo} entities. */
	@Autowired
	private CenOutMdLoRepository cenOutMdLoRepository;

	/** Repository for {@link CenOutMdPs} entities. */
	@Autowired
	private CenOutMdPsRepository cenOutMdPsRepository;

	/**
	 * Insert a entry on queue, for generating documents job.
	 *
	 * @param jobType the documents generation job type
	 * @param csection relevant section, only used on {@link GenerationJobType#USER_DEFINED}
	 * @param deleteOldDocuments should the old documents be deleted
	 * @param flightKeys the ids for handled flights {@link CenOut}
	 * @return informations about handling of given flights (OLD - departure is in the past, INACTIVE - document generation is
	 *         inactive,EXIST - Documents generation job already exist,CREATE - Insert/create documents job )
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#PARAM_INCONSITENT} if GenerationType is 'USER_DEFINED', but no settings
	 *             found for current user(%s) and given csection(%s)!
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID}
	 *             <ul>
	 *             <li>if no flight ({@link CenOut}) for given flight key(nresultKey) is found
	 *             <li>no {@link CenAirlineUnit} for flight is found (no settings for document generation)
	 *             </ul>
	 *             </ul>
	 */
	public Map<Long, String> createDocumentsJob(final GenerationJobType jobType,
			final String csection,
			final boolean deleteOldDocuments,
			final List<Long> flightKeys) throws CbaseMiddlewareBusinessException {
		if (GenerationJobType.SECONDARY_DISTRIBUTION == jobType) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					"SECONDARY_DISTRIBUTION is currently not supported ");
		}
		// user defined documents job handled
		if (GenerationJobType.USER_DEFINED == jobType) {
			return userDefinedJob(flightKeys, deleteOldDocuments, csection);
		}
		// generic documents job handled
		return genericDocJob(flightKeys, deleteOldDocuments);

	}

	/**
	 * Create generic document jobs.
	 *
	 * @param flightKeys the ids for handled flights {@link CenOut}
	 * @param deleteOldDocuments should the old documents be deleted
	 * @param csection relevant section for user settings
	 * @return informations about handling of given flights
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#PARAM_INCONSITENT} if GenerationType is 'USER_DEFINED', but no settings
	 *             found for current user(%s) and given csection(%s)!
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID} if no flight ({@link CenOut}) for given flight
	 *             key(nresultKey) is found
	 *             </ul>
	 */
	private Map<Long, String> userDefinedJob(final List<Long> flightKeys, final boolean deleteOldDocuments,
			final String csection) throws CbaseMiddlewareBusinessException {

		// user defined generation handle
		final SysLogin login = getLoginUser().getLogin();
		final List<LocSetup> userSettings = locSetupRepository.findBySysLoginAndIdCsection(login, csection);

		List<LocSetup> defaultUserSettings = new ArrayList<>();
		// CartDiagram-Settings use another section, load this additionally
		if (StringUtils.startsWithIgnoreCase(csection, DOCBROWSER)) {
			final String defaultSection = "Default" + csection.substring(DOCBROWSER_LENGTH);
			defaultUserSettings = locSetupRepository.findBySysLoginAndIdCsection(login, defaultSection);
		}

		// USER_DEFINED type, but no user settings found -> CbaseMiddlewareBusinessException
		if (userSettings.isEmpty() && defaultUserSettings.isEmpty()) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.PARAM_INCONSITENT,
					String.format(
							"GenerationType is 'USER_DEFINED', but no settings found for current user(%s) and given csection(%s)!",
							login.getCusername(), csection));
		}
		final Map<Long, String> returnInfo = new HashMap<>();
		for (final Long flightKey : flightKeys) {
			final CenOut flight = findOne(CenOut.class, flightKey);
			if (existJob(flightKey, returnInfo)) {
				continue;
			}
			deleteDocumentEntries(deleteOldDocuments, flight);
			final CenDocGenQueue docGenJob = createJob(flight, GenerationJobType.USER_DEFINED, flight, returnInfo);
			saveSettings(userSettings, docGenJob);
			saveSettings(defaultUserSettings, docGenJob);
		}
		return returnInfo;
	}

	/**
	 * Save user settings as {@link CenDocGenUd}(user settings for job) on given {@link CenDocGenQueue}(Documents-Engine-Job).
	 *
	 * @param settings the user settings
	 * @param docJob the documents engine job
	 */
	private void saveSettings(final List<LocSetup> settings, final CenDocGenQueue docJob) {
		for (final LocSetup locSetup : settings) {
			final CenDocGenUd ud = new CenDocGenUd();
			ud.setCenDocGenQueue(docJob);
			ud.setCsection(locSetup.getId().getCsection());
			ud.setCkey(locSetup.getId().getCkey());
			ud.setCvalue(locSetup.getCvalue());
			save(ud);
		}
	}

	/**
	 * Create generic document jobs.
	 *
	 * @param flightKeys the ids for handled flights {@link CenOut}
	 * @param deleteOldDocuments should the old documents be deleted
	 * @return informations about handling of given flights
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID}
	 *             <ul>
	 *             <li>if no flight ({@link CenOut}) for given flight key(nresultKey) is found
	 *             <li>no {@link CenAirlineUnit} for flight is found (no settings for document generation)
	 *             </ul>
	 *             </ul>
	 */
	private Map<Long, String> genericDocJob(final List<Long> flightKeys, final boolean deleteOldDocuments)
			throws CbaseMiddlewareBusinessException {
		final Date today = DateUtils.truncate(now(), Calendar.DAY_OF_MONTH);
		final Map<Long, String> returnInfo = new HashMap<>();
		for (final Long flightKey : flightKeys) {
			final CenOut flight = findOne(CenOut.class, flightKey);

			if (flight.getDdeparture().before(today)) {
				returnInfo.put(flightKey, "OLD - DEPARTURE before TODAY!");
				continue;
			}
			final CenAirlineUnitId airlineUnitId = new CenAirlineUnitId(flight.getNairlineKey(), flight.getCunit());
			final CenAirlineUnit airlineUnit = findOne(CenAirlineUnit.class, airlineUnitId);

			// check if generation is enabled
			if (!airlineUnit.isNenableDocGen()) {
				returnInfo.put(flightKey, "INACTIVE - Documents generation for Airline & Company inactive!");
				continue;
			}

			// check whether the first leg exist and create the job if necessary (convention: first leg nresultKey = NresultKeyGroup)
			final Long nresultKeyGroup = flight.getNresultKeyGroup();
			if (!flightKey.equals(nresultKeyGroup)) { // current leg is not first leg -> check first leg
				if (!existJob(nresultKeyGroup, returnInfo)) { // no job for first leg -> create job
					final CenOut flightGroup = findOne(CenOut.class, nresultKeyGroup);
					// Bei Änderungen ab 2. Leg müssen wir die gespeicherten MZ-Verteilungen löschen, damit diese neu erstellt werden
					deleteMZV(nresultKeyGroup);
					createJob(flight, GenerationJobType.GENERIC, flightGroup, returnInfo);
				}
			}

			if (!existJob(flightKey, returnInfo)) {
				deleteDocumentEntries(deleteOldDocuments, flight);
				createJob(flight, GenerationJobType.GENERIC, flight, returnInfo);
			}

		}
		return returnInfo;
	}

	/**
	 * Checks weather a documents job with given nresultKey exist.
	 *
	 * @param nresultKey the ids for handled flights {@link CenOut}
	 * @param returnInfo informations about handling of given flights (EXIST - Documents generation job already exist)
	 * @return {@code true} if a documents job exist, otherwise {@code false}
	 */
	private boolean existJob(final long nresultKey, final Map<Long, String> returnInfo) {
		final List<CenDocGenQueue> jobs = cenDocGenQueueRepository.findByNresultKeyAndNgenStatus(nresultKey, 0);
		if (!jobs.isEmpty()) {
			returnInfo.put(nresultKey, "EXIST - Documents generation job already exist.");
			return true;
		}
		return false;
	}

	/**
	 * Delete document entries from given flight {@link CenOutDocuments}
	 *
	 * @param deleteOldDocuments if the delete is required
	 * @param flight current handled flight (to delete
	 */
	private void deleteDocumentEntries(final boolean deleteOldDocuments, final CenOut flight) {
		if (deleteOldDocuments) {
			final long ntransaction = flight.getNtransaction();
			final long nresultKey = flight.getNresultKey();
			cenOutDocumentsRepository.deleteByIdNresultKeyAndIdNtransaction(nresultKey, ntransaction);
			cenOutLabelsRepository.deleteByIdNresultKeyAndIdNtransaction(nresultKey, ntransaction);
		}
	}

	/**
	 * Delete all 'MZ-Verteilungen'.
	 *
	 * @param nresultKey the key to delete
	 */
	private void deleteMZV(final Long nresultKey) {
		cenOutMdRepository.deleteByIdNresultKey(nresultKey);
		cenOutMdBlobRepository.deleteByIdNresultKey(nresultKey);
		cenOutMdCoRepository.deleteByIdNresultKey(nresultKey);
		cenOutMdDeRepository.deleteByIdNresultKey(nresultKey);
		cenOutMdLoRepository.deleteByIdNresultKey(nresultKey);
		cenOutMdPsRepository.deleteByIdNresultKey(nresultKey);

	}

	/**
	 * Create the documents job for given flight and type
	 *
	 * @param flight the data for job
	 * @param jobType the generation type
	 * @param flightGroup (usedNresultKey) the relevant nresultKey (can differ from flight nresultKey - 1. leg)
	 * @param returnInfo informations about handling of given flights (CREATE - Insert/create documents job)
	 * @return the created documents job
	 */
	private CenDocGenQueue createJob(final CenOut flight, final GenerationJobType jobType, final CenOut flightGroup,
			final Map<Long, String> returnInfo) {
		final CenDocGenQueue job = new CenDocGenQueue();
		job.setCenOut(flightGroup);
		job.setNgenStatus(0);
		job.setCairline(flight.getCairline());
		job.setCunit(flight.getCunit());
		job.setNjobType(jobType.getTypeValue());
		if (GenerationJobType.USER_DEFINED == jobType) {
			job.setCusername(getLoginUser().getUsername());
			job.setNuserId(getLoginUser().getLogin().getNuserId());
		}
		save(job);
		returnInfo.put(flightGroup.getNresultKey(), "CREATE - Insert/create documents job");
		return job;
	}
}
