/*
 * CommonInterfaceRoot.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.common.rest;

import com.lsgskychefs.cbase.middleware.base.rest.RestInterfaceRoot;
import com.lsgskychefs.cbase.middleware.common.masterdata.pojo.StowageItemListEntry;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenStowage;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLanguages;

/**
 * Class holding the context root for all common REST API requests
 *
 * @author Andreas Morgenstern
 */
public final class CommonInterfaceRoot {

	/** The root context for the rest services of this module. */
	public static final String COMMON_API_ROOT = RestInterfaceRoot.REST_API_ROOT + "/common";

	/** path to units by supplier */
	public static final String UNITS_BY_SUPPLIER = "/units/by-supplier/{nsupplierKey}";

	/** path to units by supplier */
	public static final String UNITS_BY_ROLE = "/units/by-role";

	/** path to areas by unit */
	public static final String AREAS_BY_UNIT = "/areas/by-unit/{cunit}";

	/** path to workstations by areas */
	public static final String WORKSTATIONS_BY_AREAS = "/workstations/by-areas";

	/** path to get version */
	public static final String VERSION = "/version";

	/** path to get a sapuid */
	public static final String SAPUID = "/sapuid";

	/** path to get translation by language */
	public static final String TRANSLATION = "/translation/{language}";

	/** path to parse barcode */
	public static final String PARSE_BARCODE = "/barcode";

	/** path to check password */
	public static final String LOGIN = "/security/login";

	/** path to change password */
	public static final String CHANGE_PWD = "/security/change-password";

	/** path to reset password */
	public static final String RESET_PWD = "/security/user-reset-password";

	/** path to unlock user */
	public static final String USER_UNLOCK = "/security/user-unlock";

	/** path to has role */
	public static final String HAS_ROLE = "/security/has-role";

	/** path to has user has role */
	public static final String USER_HAS_ROLE = "/security/user-has-role";

	/** path to logout */
	public static final String LOGOUT = "/security/logout";

	/** path to invalid session info */
	public static final String INVALID_SESSION = "/security/invalid-session";

	/** path user is logged out */
	public static final String LOGGED_OUT = "/security/logged-out";

	/** path to get checkpoint definitions */
	public static final String CHECKPOINT_DEFINITIONS = "/masterdata/checkpoint/definitions";

	/** path to get airline by key */
	public static final String AIRLINE_BY_KEY = "/masterdata/airline/{nairlineKey}";

	/** path to get workareas and workstationsby unit */
	public static final String AREAS_AND_WORKSTATIONS = "/masterdata/areas-workstations/{cunit}";

	/** path to get packinglists by workstation */
	public static final String PACKINGLIST_BY_WORKSTATION = "/masterdata/packinglists/by-workstation";

	/** path to get packinglists cpackinglist */
	public static final String PACKINGLIST_INDEX = "/masterdata/packinglist-index/{cpackinglist}";

	/** path to get packinglist instructions as pdf */
	public static final String PACKINGLIST_INSTRUCTIONS_PDF = "/masterdata/packinglist-instructions-pdf";

	/** path to get packinglist instructions as html */
	public static final String PACKINGLIST_INSTRUCTIONS_HTML = "/masterdata/packinglist-instructions-html";

	/** path to get packinglist explosion data */
	public static final String PACKINGLIST_EXPLOSION = "/masterdata/packinglist-explosion";

	/** path to get packinglist explosion data */
	public static final String PACKINGLIST_EXPLOSION_WOU = "/masterdata/packinglist-explosion-wou";

	/** path to get packinglists */
	public static final String PACKINGLISTS = "/masterdata/packinglists/by-index";

	/** path to get one specific packinglist */
	public static final String PACKINGLIST = "/masterdata/packinglist/{npackinglistIndexKey}/{npackinglistDetailKey}";

	/** path to get cen picture */
	public static final String PACKINGLIST_PICTURE = "/masterdata/packinglist-picture";

	/** path to get cen picture as thumbnail */
	public static final String PACKINGLIST_PICTURE_THUMBNAIL = "/masterdata/packinglist-picture/thumbnail";

	/** path to get airlines and categories */
	public static final String AIRLINES_AND_CATEGORIES = "/masterdata/airlines-and-categories";

	/** path to get airlines and categories */
	public static final String AIRLINES = "/masterdata/airlines";

	/** path to get airlines and categories */
	public static final String AIRLINECATEGORIES = "/masterdata/airlinecategories";

	/** path to create crystal report job */
	public static final String CRYSTAL_REPORT_JOB = "/masterdata/crystal-report-job";

	/** path to get {@link CenStowage} */
	public static final String STOWAGES = "/masterdata/flight-stowages";

	/** path to get a list of {@link StowageItemListEntry} */
	public static final String STOWAGE_ITEM_LIST = "/masterdata/flight-stowage/item-list";

	/** path to get pictures for complete flight (stowage -> packinglists) */
	public static final String STOWAGE_PACKINGLISTS_PICTURES = "/masterdata/flight-stowage/pictures";

	/** path to get flight documents */
	public static final String FLIGHT_STOWAGE_DOCUMENTS_PDF = "/masterdata/flight-stowage/documents";

	/** path to run sys explosion */
	public static final String SYS_EXPLOSION = "/masterdata/sys-explosion";

	/** path to get all routings */
	public static final String ROUTINGS = "/masterdata/routings";

	/** path to get all ops */
	public static final String OPS = "/masterdata/ops";

	/** path to report product specification */
	public static final String REPORT_PROD_SPECS = "/report/prodspecs";

	/** path to compile all reports */
	public static final String REPORT_COMPILE_ALL = "/report/compile-all";

	/** path to get all flights */
	public static final String FLIGHTS = "/flight";

	/** path to get one specific flight */
	public static final String FLIGHT = "/flight/{nresultKey}";

	/** path to get all handlings for a flight */
	public static final String FLIGHT_HANDLINGS = "/flight/{nresultKey}/handlings";

	/** path to get flights by unit(day flight list) */
	public static final String FLIGHTS_BY_UNIT = "/flight/by-unit";

	/** path to get flights by unit and airline(day flight list) */
	public static final String FLIGHTS_BY_UNIT_AIRLINE_ROUTING = "/flight/by-unit-airline-routing";

	/** path to get flights by flight number data */
	public static final String FLIGHT_BY_FLIGHT_NUMBER = "/flights/by-flight-number";

	/** path to get flight spml details */
	public static final String FLIGHT_SPML = "/flight/spml";

	/** path to get flight meals */
	public static final String FLIGHT_MEALS = "/flight/meals";

	/** path to get flight spml details */
	public static final String FLIGHT_SPML_DETAILS = "/flight/spml-details";

	/** path to get flight loading data */
	public static final String FLIGHT_LOADING = "/flight/loading";

	/** path to get flight stowage content */
	public static final String FLIGHT_STOWAGE_CONTENT = "/flight/stowage-content";

	/** path to get flight pax(person approximately) */
	public static final String FLIGHT_PAX = "/flight/pax";

	/** path to change flight status */
	public static final String FLIGHT_STATUS = "/flight/status";

	/** path to set full house for flights and enqueue the flights into flight calc */
	public static final String FLIGHT_FULL_HOUSE = "/flight/full-house";

	/** path to explode a single flight and store results in cen_out_master */
	public static final String FLIGHT_EXPLODE = "/flight/{nresultKey}/explode";

	/** path to get all open flight explosion jobs */
	public static final String FLIGHT_EXPLOSION_OPEN_JOBS = "/flight/explosion/open-jobs";

	/** path to process one flight explosion job */
	public static final String FLIGHT_EXPLOSION_PROCESS = "/flight/explosion/process";

	/** path to manual meal distribution assign */
	public static final String MANUAL_MEAL_DISTRIBUTION_ASSIGN = "/flight/manual-meal-distribution-assign";

	/** path to manual meal distribution unassign */
	public static final String MANUAL_MEAL_DISTRIBUTION_UNASSIGN = "/flight/manual-meal-distribution-unassign";

	/** path to upload meal data from delta airlines */
	public static final String DELTA_UPLOAD = "/flight/delta-upload";

	/** path to (long) poll for notifications */
	public static final String POLL_FOR_NOTIFICATIONS = "/notifications/poll";

	/** path to check for notifications */
	public static final String CHECK_FOR_NOTIFICATIONS = "/notifications/check";

	/** path to push for notifications */
	public static final String PUSH = "/notifications/push";

	/** path to subscribe for notifications */
	public static final String SUBSCRIBE = "/notifications/subscribe";

	/** path to unsubscribe for notifications */
	public static final String UNSUBSCRIBE = "/notifications/unsubscribe";

	/** path to get/set user profile value */
	public static final String PROFILE_VALUE = "/profile";

	/** path to get/set unit profile value */
	public static final String UNIT_PROFILE_VALUE = "/profile/{cunit}";

	/** path to get/set client profile value */
	public static final String CLIENT_PROFILE_VALUE = "/profile/client";

	/** path to get/set client profile value */
	public static final String APP_PROFILE_VALUE = "/profile/app/{capp}";

	/** path to get/set app setup values */
	public static final String APP_SETUP_VALUES = "/profile/app-setup/{capp}";

	/** path to get all {@link SysLanguages} */
	public static final String ALL_LANGUAGES = "/all-languages";

	/** path to get unit RemotePrinters value */
	public static final String UNIT_REMOTE_PRINTERS = "/remoteprinters/{cunit}";

	/** path to get the setup for APP - GRID value */
	public static final String APP_GRID_SETUP = "/app-grid-setup";

	/** path to get the "app grid profile" config value */
	public static final String APP_GRID_SETUP_CONFIG = "/app-grid-setup/{cprofile}";

	/** path to get the settings for a user in one app */
	public static final String APP_USER_SETTING = "/app-user-setting";

	/** path to get the settings for a unit in one app */
	public static final String APP_UNIT_SETTING = "/app-unit-setting";

	/** path to get Label Groups */
	public static final String LABEL_GROUPS = "/masterdata/labelgroups";

	/** path to get trailpoints */
	public static final String TRAILPOINTS = "/masterdata/trailpoints";

	/** path to get beacons */
	public static final String BEACONS = "/masterdata/beacons";

	/** path to get one specific thermometer */
	public static final String THERMOMETER = "/masterdata/thermometer/{nthermometerKey}";

	/** path to get thermometers */
	public static final String THERMOMETERS = "/masterdata/thermometers";

	/** path to get prod ranges */
	public static final String PROD_RANGES = "/masterdata/prod-ranges";

	/** path to get product groups */
	public static final String PRODUCT_GROUPS = "/masterdata/productgroups";

	/** path to get product groups for an app */
	public static final String PRODUCT_GROUPS_APP = "/masterdata/productgroups-app";

	/** path to get users for a specific role */
	public static final String USERS = "/users";

	/** path to get a list of Packinglisttypes */
	public static final String PACKINGLISTTYPES = "/packinglisttypes";

	/** Path for saving new nfoorplan */
	public static final String FLOORPLANS = "/painter/floorplans";

	/** Path for copying a floorplan */
	public static final String FLOORPLAN_COPY = "/painter/floorplan/{nid}/copy";

	/** Path for updating a floorplan */
	public static final String FLOORPLAN = "/painter/floorplan/{nid}";

	/** Create a copy of floorplan with new validity schedules */
	public static final String CREATE_NEW_VALIDITY_FLOORPLAN = "/painter/floorplan-validity/{nid}";

	/** Get list of validities for unit */
	public static final String UNIT_VALIDITY = "/painter/unit-validity/{cid}";

	/** Path for showing a specific list */
	public static final String FLOORPLANS_BY_UNIT = "/painter/unit/{cid}/floorplans";

	/** Path for getting single image */
	public static final String FLOORPLAN_IMAGE_BASE64 = "/painter/floorplan/{nid}/image";

	/** Path for working on all ROB languages */
	public static final String PROTOTYPE_ROB_LANGUAGES = "prototype/rob/languages";

	/** Path for working on a specific ROB language */
	public static final String PROTOTYPE_ROB_LANGUAGE = "prototype/rob/language/{nlanguage}";

	/** Path for working on all ROB product categories */
	public static final String PROTOTYPE_ROB_PRODUCT_CATEGORIES = "prototype/rob/product-categories";

	/** Path for working on a specific ROB product category */
	public static final String PROTOTYPE_ROB_PRODUCT_CATEGORY = "prototype/rob/product-category/{nproductCategoryKey}";

	/** Path for working on all ROB products */
	public static final String PROTOTYPE_ROB_PRODUCTS = "prototype/rob/products";

	/** Path for working on a specific ROB product */
	public static final String PROTOTYPE_ROB_PRODUCT = "prototype/rob/product/{nproductKey}";

	/** Path for working on all ROB events */
	public static final String PROTOTYPE_ROB_EVENTS = "prototype/rob/events";

	/** Path for working on a specific ROB event */
	public static final String PROTOTYPE_ROB_EVENT = "prototype/rob/event/{neventKey}";

	/** Path for starting a specific ROB event */
	public static final String PROTOTYPE_ROB_EVENT_START = "prototype/rob/event/{neventKey}/start";

	/** Path for working on all products for a specific ROB event */
	public static final String PROTOTYPE_ROB_EVENT_PRODUCTS = "prototype/rob/event/{neventKey}/products";

	/** Path for working on all ROB guests */
	public static final String PROTOTYPE_ROB_GUESTS = "prototype/rob/guests";

	/** Path for working on a specific ROB guest */
	public static final String PROTOTYPE_ROB_GUEST = "prototype/rob/guest/{nguestKey}";

	/** Path for working on all orders for a specific ROB guest */
	public static final String PROTOTYPE_ROB_GUEST_ORDERS = "prototype/rob/guest/{nguestKey}/orders";

	/** Path for working on all ROB orders */
	public static final String PROTOTYPE_ROB_ORDERS = "prototype/rob/orders";

	/** Path for working on a specific ROB order */
	public static final String PROTOTYPE_ROB_ORDER = "prototype/rob/order/{norderKey}";

	/** Path for getting all exceptions */
	public static final String EXCEPTIONS = "exceptions";

	/** Path for getting the snapshot for one exception */
	public static final String EXCEPTIONS_SNAPSHOT = "exceptions/{nerrorKey}/snapshot";

	/** Path for getting all exceptions */
	public static final String EXCEPTIONS_APPLICATION = "exceptions/application";

	/** Path for getting all spring exceptions */
	public static final String EXCEPTIONS_SPRING = "exceptions/spring";

	/** Path for getting all apps that have exceptions */
	public static final String EXCEPTIONS_APPLICATION_LIST = "exceptions/application/list";

	/** Path for getting on a specific exception */
	public static final String EXCEPTION = "exceptions/{nerrorKey}";

	/**
	 * Private Constructor.
	 */
	private CommonInterfaceRoot() {
		// do nothing.
	}

}
