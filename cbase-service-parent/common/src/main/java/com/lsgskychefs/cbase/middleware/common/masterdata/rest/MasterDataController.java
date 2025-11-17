/*
 * MasterdataController.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.common.masterdata.rest;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletResponse;
import javax.swing.text.BadLocationException;
import javax.validation.Valid;

import org.apache.commons.beanutils.BeanComparator;
import org.apache.commons.collections4.comparators.ComparatorChain;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.codahale.metrics.annotation.Timed;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.base.rest.AbstractCbaseMiddlewareController;
import com.lsgskychefs.cbase.middleware.base.rest.ResponseCollection;
import com.lsgskychefs.cbase.middleware.base.rest.ResponseElement;
import com.lsgskychefs.cbase.middleware.common.masterdata.business.MasterDataFlightStowageService;
import com.lsgskychefs.cbase.middleware.common.masterdata.business.MasterDataReportService;
import com.lsgskychefs.cbase.middleware.common.masterdata.business.MasterDataService;
import com.lsgskychefs.cbase.middleware.common.masterdata.pojo.GalleyResponse;
import com.lsgskychefs.cbase.middleware.common.masterdata.pojo.StowageItemListEntry;
import com.lsgskychefs.cbase.middleware.common.pojo.PackinglistExplosionEntry;
import com.lsgskychefs.cbase.middleware.common.pojo.PackinglistExplosionParameter;
import com.lsgskychefs.cbase.middleware.common.rest.CommonInterfaceRoot;
import com.lsgskychefs.cbase.middleware.persistence.constant.CenPictureResolutionType;
import com.lsgskychefs.cbase.middleware.persistence.constant.report.ReportType;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenAirlCategories;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenAirlines;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenAirlines_;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenGalley;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenObjectEquipment;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOut;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMeals_;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistIndex;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistIndex_;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistInstructions;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistPictures;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistTypes;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglists;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistsId;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistsId_;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglists_;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPictureResolution;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPictures;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPictures_;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenStowage;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocOperations;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitAreas;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitAreas_;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitCheckpt;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitLabelGroups;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitTrailpoint;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitWorkstation;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitWorkstation_;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysAirlineCat;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysAirlineCat_;
import com.lsgskychefs.cbase.middleware.persistence.global.FormatConstants;
import com.lsgskychefs.cbase.middleware.persistence.query.MetaModelHelper;
import com.lsgskychefs.cbase.middleware.persistence.utils.CMMetaModelUtils;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;

/**
 * This class provides a REST interface for interacting with the {@link MasterDataService}.
 *
 * @author Andreas Morgenstern
 */
@RestController
@RequestMapping(CommonInterfaceRoot.COMMON_API_ROOT)
public class MasterDataController extends AbstractCbaseMiddlewareController {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(MasterDataController.class);

	/** The {@link MasterDataService} that interacts with the underlying database repositories */
	@Autowired
	private MasterDataService masterDataService;

	/** The {@link MasterDataReportService} to handle crystal report jobs */
	@Autowired
	private MasterDataReportService masterDataReportService;

	/** The {@link MasterDataFlightStowageService} that interacts with the underlying database repositories */
	@Autowired
	private MasterDataFlightStowageService masterDataFlightStowageService;

	/** Helper class for MetaModel functionality */
	@Autowired
	private MetaModelHelper metaModelHelper;

	/**
	 * Returns a {@link CenAirlines} matching to the given airline key.
	 *
	 * @param nairlineKey The key of the airline.
	 * @return The data of the {@link CenAirlines} found.
	 * @throws CbaseMiddlewareBusinessException of type {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID} if no {@link CenAirlines}
	 *             for given id is found
	 */
	@Timed
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.AIRLINE_BY_KEY)
	public ResponseElement getAirline(@PathVariable final Long nairlineKey)
			throws CbaseMiddlewareBusinessException {
		final CenAirlines cenAirlines = masterDataService.getAirlineById(nairlineKey);

		return new ResponseElement()
				.put(cenAirlines,
						CenAirlines_.nairlineKey,
						CenAirlines_.cclient,
						CenAirlines_.cairline,
						CenAirlines_.ctext,
						CenAirlines_.nownerId,
						CenAirlines_.nuse4web,
						CenAirlines_.nscheduleImport,
						CenAirlines_.nlogo,
						CenAirlines_.nairlineType,
						CenAirlines_.nbcImport,
						CenAirlines_.nscheduleHeader,
						CenAirlines_.nscheduleFooter,
						CenAirlines_.nregistrationCheck,
						CenAirlines_.ncustomBbill,
						CenAirlines_.nuseOwnerForTraffic,
						CenAirlines_.nskyskopeVisible,
						CenAirlines_.nusePricingDefault,
						CenAirlines_.nroleId);

	}

	/**
	 * Returns a list of area and workstation data matching the given <code>cunit</code> string.
	 *
	 * @param cunit The cunit key to be used to find area and workstation data.
	 * @return The area and workstation data found.
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.AREAS_AND_WORKSTATIONS)
	public ResponseCollection getAreasAndWorkstations(@PathVariable final String cunit) {

		final List<LocUnitAreas> locUnitAreas = masterDataService.getAreasAndWorkstations(cunit);

		final ResponseCollection result = new ResponseCollection();
	
		for (final LocUnitAreas area : locUnitAreas) {
			final List<LocUnitWorkstation> sortedWorkstations = new ArrayList<>(area.getLocUnitWorkstations());

			Collections.sort(sortedWorkstations, Comparator.comparing(LocUnitWorkstation::getCworkstation)
		            .thenComparing(LocUnitWorkstation::getCtext));
			
			final ResponseCollection workstations = new ResponseCollection();
			for (final LocUnitWorkstation workstation : sortedWorkstations) {
				workstations.creatAndAdd()
						.put(workstation,
								LocUnitWorkstation_.ctext,
								LocUnitWorkstation_.cworkstation,
								LocUnitWorkstation_.nworkstationKey);
			}

			result.creatAndAdd()
					.put(area,
							LocUnitAreas_.carea,
							LocUnitAreas_.ctext,
							LocUnitAreas_.nareaKey)
					.put("workstations", workstations);
		}
		return result;
	}

	/**
	 * Get defined checkpoints, for given unit.<br>
	 * cbase_checkpoint_manager.n_checkpoint_manager.of_get_checkpoint_definitions
	 *
	 * @param cunit company of the region
	 * @param filter specified the desired fields
	 * @return the desired fields for defined checkpoints (List of {@link LocUnitCheckpt})
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.CHECKPOINT_DEFINITIONS)
	public ResponseCollection getCheckpointDefinitions(
			@RequestParam final String cunit,
			@RequestParam(required = false) final String... filter) {
		final List<LocUnitCheckpt> checkpointDefinitions = masterDataService.findCheckpointDefinitions(cunit);
		return buildResponseCollectionDO(checkpointDefinitions, filter);
	}

	/**
	 * Get the packinglists for given workstation id
	 *
	 * @param nworkstationKey id of workstation
	 * @param date filter date for validFrom <-> validTo
	 * @param filter specified the desired fields
	 * @return packinglists
	 */
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.PACKINGLIST_BY_WORKSTATION)
	public ResponseCollection getPackinglistByWorkstation(
			@RequestParam final long nworkstationKey,
			@RequestParam final Date date,
			@RequestParam(required = false) final String... filter) {

		final List<CenPackinglists> cenPackinglists = masterDataService.getPackinglistByWorkstation(nworkstationKey, date);
		final ResponseCollection col = new ResponseCollection();
		for (final CenPackinglists cenPackinglist : cenPackinglists) {
			final CenPackinglistIndex cenPackinglistIndex = cenPackinglist.getCenPackinglistIndex();
			col.creatAndAdd(filter)
					.put(cenPackinglist.getId(),
							CenPackinglistsId_.npackinglistIndexKey,
							CenPackinglistsId_.npackinglistDetailKey)
					.put(cenPackinglist,
							CenPackinglists_.ctext,
							CenPackinglists_.ctextShort,
							CenPackinglists_.caddOnText)
					.put(cenPackinglistIndex,
							CenPackinglistIndex_.cpackinglist);
		}
		return col;
	}

	/**
	 * Get {@link CenPackinglistIndex} filtered by cpackinglist. <br>
	 * cbase_data_layer.uo_cbase_data_layer.of_get_packinglist_index
	 *
	 * @param cpackinglist the packinglist identifier
	 * @param filter specified the desired fields
	 * @return the packinglist index {@link CenPackinglistIndex}
	 */
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.PACKINGLIST_INDEX)
	public ResponseElement getPackinglistIndex(
			@PathVariable final String cpackinglist,
			@RequestParam(required = false) final String... filter) {
		return new ResponseElement(filter).putAll(masterDataService.getPackinglistIndex(cpackinglist));
	}


	/**
	 * Get the Instruction for a Packinglist as HTML Text
	 * 
	 * @param npackinglistIndexKey
	 * @param npackinglistDetailKey
	 * @return Instruction in HTML Text
	 * @throws IOException
	 * @throws CbaseMiddlewareBusinessException
	 * @throws SQLException
	 * @throws BadLocationException
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.PACKINGLIST_INSTRUCTIONS_HTML)
	public String getPackinglistInstructionsHtml(@RequestParam final long npackinglistIndexKey,
			@RequestParam final long npackinglistDetailKey)
			throws IOException, CbaseMiddlewareBusinessException, SQLException, BadLocationException {

		return masterDataService.getPackinglistInstructionsHtml(npackinglistIndexKey, npackinglistDetailKey);

	}

	/**
	 * Checks if an instruction text exists for the given {@link CenPackinglists}.
	 *
	 * @param npackinglistIndexKey the first part of the PK
	 * @param npackinglistDetailKey the second part of the PK
	 * @return true or false
	 * @throws CbaseMiddlewareBusinessException if no CenPackinglist is found {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID}
	 */
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.PACKINGLIST)
	public boolean hasPackinglistInstruction(
			@PathVariable final Long npackinglistIndexKey,
			@PathVariable final Long npackinglistDetailKey) throws CbaseMiddlewareBusinessException {

		return masterDataService.hasPackinglistInstruction(npackinglistIndexKey, npackinglistDetailKey);
	}

	/**
	 * Load the explosion entries.
	 *
	 * @param param the parameter values
	 * @param filter specified the desired fields
	 * @return the explosion entries (List of {@link PackinglistExplosionEntry})
	 */
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.PACKINGLIST_EXPLOSION)
	public ResponseCollection getPackinglistExplosionData(
			@Valid final PackinglistExplosionParameter param,
			@RequestParam(required = false) final String... filter) {
		return buildResponseCollectionPojo(masterDataService.getPackinglistExplosionData(param), filter);
	}

	/**
	 * Load the explosion entries.
	 *
	 * @param param the parameter values
	 * @param filter specified the desired fields
	 * @return the explosion entries (List of {@link PackinglistExplosionEntry})
	 */
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.PACKINGLIST_EXPLOSION_WOU)
	public ResponseCollection getPackinglistExplosionWOUData(
			@Valid final PackinglistExplosionParameter param,
			@RequestParam(required = false) final String... filter) {
		return buildResponseCollectionPojo(masterDataService.getPackinglistExplosionWOUData(param), filter);
	}

	/**
	 * Get the list of {@link CenPackinglists} for given index key(The validity).
	 *
	 * <pre>
	 * {
	 *  "NPACKINGLIST_INDEX_KEY":
	 *  "NPACKINGLIST_DETAIL_KEY":
	 *  "DVALID_FROM, DVALID_TO":
	 *  "NPACKINGLIST_KEY":
	 *  "NPACKINGLIST_KEY":
	 * }
	 * </pre>
	 *
	 * @param npackinglistIndexKey the index key
	 * @param filter specified the desired fields
	 * @return the list of {@link CenPackinglists}
	 */
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.PACKINGLISTS)
	public ResponseCollection getPackinglists(
			@RequestParam final long npackinglistIndexKey,
			@RequestParam(required = false) final String... filter) {

		final ResponseCollection col = new ResponseCollection();
		final List<CenPackinglists> packinglists = masterDataService.getPackinglists(npackinglistIndexKey);
		for (final CenPackinglists packinglist : packinglists) {
			col.creatAndAdd(filter)
					.put(packinglist.getId(),
							CenPackinglistsId_.npackinglistIndexKey,
							CenPackinglistsId_.npackinglistDetailKey)
					.put(packinglist,
							CenPackinglists_.dvalidFrom,
							CenPackinglists_.dvalidTo,
							CenPackinglists_.npackinglistKey);
		}

		return col;
	}

	/**
	 * Get the {@link CenPictures} and relevant fields.<br>
	 * cbase_data_layer#of_get_packinglist_picture
	 *
	 * @param indexKey key for {@link CenPackinglistIndex}
	 * @param detailKey key for {@link CenPackinglists}
	 * @param date reference date to get the right validity
	 * @param filter specified the desired fields
	 * @return the desired fields of {@link CenPictures}, {@link CenPackinglists} and {@link CenPackinglistIndex}
	 * @throws CbaseMiddlewareBusinessException if no CenPackinglists or picture is found
	 *             {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID}
	 */
	@ApiOperation(value = "Get packinglist information with picture as Base64 String", notes = "either detailKey or date is required!", code = 200)
	@ApiResponses(value = { @ApiResponse(code = 409, message = "If the quality type is unknown") })
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.PACKINGLIST_PICTURE)
	public ResponseElement getPackinglistPicture(
			@RequestParam final Long indexKey,
			@RequestParam(required = false) final Long detailKey,
			@RequestParam(required = false) final Date date,
			@RequestParam(required = false) final String... filter) throws CbaseMiddlewareBusinessException {

		final CenPackinglists packinglist;

		if (detailKey != null) {
			final CenPackinglistsId pk = new CenPackinglistsId(indexKey, detailKey);
			packinglist = masterDataService.getCenPackinglist(pk);

		} else if (date != null) {
			packinglist = masterDataService.getPackinglist(indexKey, date);
		} else {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.PARAM_INCONSITENT,
					"either detailKey or date is required!");
		}

		final CenPackinglistPictures packinglistPicture = packinglist.getCenPackinglistPictures();
		if (packinglistPicture == null) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.UNKNOWN_ID,
					String.format("Could not found picture for packinglist with pk=%s ", packinglist.getId().asString()));
		}
		return new ResponseElement(filter)
				.put(packinglistPicture.getCenPictures(),
						CenPictures_.npictureIndexKey,
						CenPictures_.cpictureName,
						CenPictures_.cfileName,
						CenPictures_.cdescription,
						CenPictures_.bpicture)
				.put(packinglist, CenPackinglists_.ctext)
				.put(packinglist.getCenPackinglistIndex(), CenPackinglistIndex_.cpackinglist);
	}

	/**
	 * Provides a packinglist picture in different quality/size dimensions. Should be used for thumbnail purpose.
	 * 
	 * @param indexKey key for {@link CenPackinglistIndex}
	 * @param detailKey key for {@link CenPackinglists}
	 * @param refDate reference date to get the right validity if no detailKey is present
	 * @param quality @see {@link CenPictureResolutionType}
	 * @return Base64 String
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT - if the quality is not known
	 *             </ul>
	 */
	@ApiOperation(value = "Get a packinglist picture thumbnail as Base64 String", notes = "Either detailKey or date is required! You must define the quality & size!", code = 200, response = String.class)
	@ApiResponses(value = {
			@ApiResponse(code = 400, message = "No validity defined. Either detailKey or date is required!"),
			@ApiResponse(code = 400, message = "Could not find picture thumbnail for packinglist"),
			@ApiResponse(code = 409, message = "If the quality type is unknown") })
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.PACKINGLIST_PICTURE_THUMBNAIL)
	public String getPackinglistPictureThumbnailBase64(
			@ApiParam(value = "Part of Primary Key") @RequestParam final Long indexKey,
			@ApiParam(value = "Part of Primary Key (Validity)") @RequestParam(required = false) final Long detailKey,
			@ApiParam(value = "Optional way to match validity if no detailKey is present") @RequestParam(required = false) final Date refDate,
			@ApiParam(value = "LOW/MEDIUM") @RequestParam final String quality) throws CbaseMiddlewareBusinessException {
		final CenPackinglists packinglist;
		final CenPictureResolutionType resolutionType;
		final CenPictureResolution pictureThumbnail;
		final String base64EncodedImage;
		Long packinglistDetailKey = detailKey;

		// try to find the right validity, if no detailKey is present
		if (packinglistDetailKey == null) {
			if (refDate != null) {
				packinglist = masterDataService.getPackinglist(indexKey, refDate);
				if (packinglist != null) {
					packinglistDetailKey = packinglist.getId().getNpackinglistDetailKey();
				} else {
					throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.UNKNOWN_ID,
							String.format("Could not find validity for packinglist with indexKey=%s refDate=%s", indexKey, refDate));
				}
			} else {
				throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.PARAM_INCONSITENT,
						"either detailKey or date is required!");
			}
		}

		// check if given quality string exists
		try {
			resolutionType = CenPictureResolutionType.valueOf(quality);
		} catch (final IllegalArgumentException e) {
			final String message = String.format("Picture resolution type for the given quality '%s' not found ", quality);
			MasterDataController.LOGGER.warn(message, e);
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT, message);
		}

		// get the picture thumbnail in the matching quality
		pictureThumbnail = masterDataService.getPackinglistPictureThumbnail(indexKey, packinglistDetailKey, resolutionType.getValue());
		if (pictureThumbnail != null) {
			base64EncodedImage = Base64.getEncoder().encodeToString(pictureThumbnail.getBpicture());
		} else {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.UNKNOWN_ID,
					String.format("Could not find picture thumbnail for packinglist with indexKey=%s detailKey=%s quality=%s", indexKey,
							packinglistDetailKey, quality));
		}

		return base64EncodedImage;
	}


	/**
	 * All Airline-Categories
	 * 
	 * @return all airline categories
	 */
	@Transactional(readOnly = true)
	@JsonView(View.Simple.class)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.AIRLINECATEGORIES)
	public List<SysAirlineCat> getAirlineCategories() {
		return masterDataService.getAirlineCategories();
	}

	/**
	 * Create crystal report job.
	 *
	 * @param nreportKey the report key
	 * @param reportType type of report
	 * @param parameterMap parameter map (key,value)
	 * @return the ID of generated job.
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} wrong or illegal parameter values
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID} if airline or unit not found for given id
	 *             </ul>
	 */
	@Timed
	@RequestMapping(method = RequestMethod.POST, value = CommonInterfaceRoot.CRYSTAL_REPORT_JOB)
	public Long createCrystalReportJob(
			@RequestParam final Long nreportKey,
			@RequestParam final ReportType reportType,
			@RequestBody final Map<String, String> parameterMap)
			throws CbaseMiddlewareBusinessException {
		return masterDataReportService.createCrystalReportJob(nreportKey, reportType, parameterMap);
	}

	/**
	 * Call this method to request a list of all routings.
	 *
	 * @return all routings
	 */
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.ROUTINGS)
	public ResponseCollection getRoutings() {
		return buildResponseCollectionDO(masterDataService.getCenRouting());
	}

	/**
	 * All Operation Times for the given unit
	 * 
	 * @param cunit the unit
	 * @return List of {@link LocOperations}
	 */
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.OPS)
	public List<LocOperations> getOps(@RequestParam final String cunit) {
		return masterDataService.getOps(cunit);
	}

	/**
	 * Gets all {@link CenStowage} containing the size values {@link CenObjectEquipment} in a List of {@link CenGalley}
	 *
	 * @param cairline the Airline
	 * @param cactype the Aircraft Type
	 * @param cgalleyversion the Version for Aircraft type
	 * @return all storages
	 * @throws InvocationTargetException
	 * @throws IllegalAccessException
	 */
	@Timed
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.STOWAGES)
	public List<GalleyResponse> getStowages(@RequestParam final String cairline,
			@RequestParam final String cactype,
			@RequestParam final String cgalleyversion) {
		return masterDataFlightStowageService.getStowagesWithSizeInformation(cairline, cactype, cgalleyversion);
	}

	/**
	 * Load and return the flight stowage item list data.<br>
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @return the flight stowage item list data
	 */
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.STOWAGE_ITEM_LIST)
	public List<StowageItemListEntry> getStowageItemList(@RequestParam final long nresultKey) {
		return masterDataFlightStowageService.getStowageItemList(nresultKey);
	}

	/**
	 * Load all pictures for given flight (stowage -> packinglists)
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @return List of {@link ResponseElement} ({@link CenPictures} attributes and cpackinglist)
	 */
	@Timed
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.STOWAGE_PACKINGLISTS_PICTURES)
	public ResponseCollection getStowagePackinglistsPictures(@RequestParam final long nresultKey) {
		final ResponseCollection responsePictures = new ResponseCollection();
		final Map<String, CenPictures> packinglistPictureMap = masterDataFlightStowageService.getStowagePackinglistsPictures(nresultKey);
		for (final Entry<String, CenPictures> entry : packinglistPictureMap.entrySet()) {
			responsePictures.creatAndAdd()
					.put(CMMetaModelUtils.convertToUnderScore(CenOutMeals_.cpackinglist), entry.getKey())
					.put(entry.getValue(),
							CenPictures_.npictureIndexKey,
							CenPictures_.cpictureName,
							CenPictures_.cfileName,
							CenPictures_.cdescription,
							CenPictures_.bpicture);

		}
		return responsePictures;
	}

	/**
	 * Load all documents for flight. And write the result PDF into response output stream.
	 *
	 * @param response current response - injected by spring
	 * @param nresultKey id for flight {@link CenOut}
	 * @throws IOException on any error on response handling
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>CbaseMiddlewareBusinessExceptionType.UNKNOWN_ID - if no flight is found
	 *             <li>CbaseMiddlewareBusinessExceptionType.NOT_FOUND - No documents(FlightStowageDocsEntry) or documents
	 *             data(CenCateringUoPdf) for this flight event
	 *             <li>CbaseMiddlewareBusinessExceptionType.UNKNOWN - Error to merge PDF the files.
	 *             </ul>
	 */
	@Timed
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.FLIGHT_STOWAGE_DOCUMENTS_PDF, produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public void getFlightStowagePdf(final HttpServletResponse response,
			@RequestParam final long nresultKey) throws IOException, CbaseMiddlewareBusinessException {

		// set Header informations
		response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
		/*
		 * "Content-Disposition : inline" will show viewable types [like images/text/pdf/anything viewable by browser] right on browser
		 * while others(zip e.g) will be directly downloaded [may provide save as popup, based on browser setting.]
		 */
		response.setHeader("Content-Disposition",
				String.format("inline; filename=\"FlightStowageDocuments-%s-%s.pdf\"", nresultKey,
						DateFormatUtils.format(new Date(), "yyyy-MM-dd_HH-mm")));

		// write report into output stream
		masterDataFlightStowageService.getFlightStowagePdf(nresultKey, response.getOutputStream());
	}

	/**
	 * List of Trailpoints for given Unit
	 * 
	 * @param cunit the unit
	 * @return List of {@link LocUnitTrailpoint}
	 */
	@ApiOperation(value = "List of Trailpoints for given Unit", code = 200)
	@JsonView(View.SimpleWithReferences.class)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.TRAILPOINTS)
	public List<LocUnitTrailpoint> getTrailpoints(
			@RequestParam final String cunit) {
		return masterDataService.getTrailpoints(cunit);
	}

	/**
	 * List of Label Groups for given Unit
	 * 
	 * @param cunit the unit
	 * @return List of {@link LocUnitLabelGroups}
	 */
	@ApiOperation(value = "List of Label Groups for given Unit", code = 200)
	@JsonView(View.Simple.class)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.LABEL_GROUPS)
	public List<LocUnitLabelGroups> getLabelGroups(
			@RequestParam final String cunit) {
		return masterDataService.getLabelGroups(cunit);
	}

	/**
	 * List of PackonglistTypes
	 * 
	 * @return List<CenPackinglistTypes>
	 */
	@JsonView(View.Simple.class)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.PACKINGLISTTYPES)
	public List<CenPackinglistTypes> getPackinglistTypes() {
		return masterDataService.getPackinglistTypes();
	}

}
