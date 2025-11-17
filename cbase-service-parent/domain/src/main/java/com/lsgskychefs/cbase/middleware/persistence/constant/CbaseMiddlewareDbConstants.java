/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutCheckpt;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmProdLabel;

/**
 * Constants for DB function names
 *
 * @author Ingo Rietzschel - U125742
 */
public final class CbaseMiddlewareDbConstants {

	/** The String 'Default' */
	public static final String DEFAULT = "Default";

	public static final String AI_FORCEPRINT = "ai_forceprint";

	public static final String AI_PRINTED = "ai_printed";

	public static final String AN_BATCH_SEQ = "an_batch_seq";

	public static final String AN_RESULT_KEY = "an_result_key";

	public static final String ARG_CMSG = "arg_cmsg";

	public static final String ARG_NBATCH_SEQ = "arg_nbatch_seq";

	public static final String ARG_NRESULT_KEY = "arg_nresult_key";

	public static final String ARG_NRET = "arg_nret";

	/**
	 * Constants for JPA {@link javax.persistence.NamedQueries}
	 *
	 * @author Ingo Rietzschel - U125742
	 */
	public static final class NamedQueries {
		public static final String LOC_PPS_PROD_BOM_BY_CONTAINER = "LOC_PPS_PROD_BOM_BY_CONTAINER";

		public static final String CEN_PPS_CATERING_ORDER_BY_CONTAINER = "CEN_PPS_CATERING_ORDER_BY_CONTAINER";

		/** Constructor */
		private NamedQueries() {
		}
	}

	/**
	 * Constants for entity graphen, to handle use case specific loading
	 *
	 * @author Ingo Rietzschel - U125742
	 */
	public static final class EntityGraphen {

		/** attribute SysEuAllergens.sysEuAllergensTexts */
		public static final String SYS_EU_ALLERGENS_SYS_EU_ALLERGENS_TEXTS = "SysEuAllergens.sysEuAllergensTexts";

		/** Constructor */
		private EntityGraphen() {
		}
	}

	/**
	 * Constants for DB procedure 'pf_update_checkpt_relevance'
	 *
	 * @author Ingo Rietzschel - U125742
	 */
	public static final class PfUpdateCheckptRelevance {
		/**
		 * function name:<br>
		 * 1. update checkpoint state on {@link CenOutCheckpt} in terms of relevance for all checkpoint of current unit<br>
		 * 2. update checkpoint state on {@link CenOutCheckpt} in terms of relevance for given Checkpoint
		 */
		public static final String PF_UPDATE_CHECKPT_RELEVANCE = "p_update_checkpt_relevance";

		/** ad_date_to */
		public static final String AD_DATE_TO = "ad_date_to";

		/** ad_date_from */
		public static final String AD_DATE_FROM = "ad_date_from";

		/** ac_unit */
		public static final String AC_UNIT = "ac_unit";

		/** an_checkpoint_key */
		public static final String AN_CHECKPOINT_KEY = "an_checkpoint_key";

		/** Constructor */
		private PfUpdateCheckptRelevance() {
		}
	}

	/**
	 * Constants for DB procedure 'pf_archive_flight'
	 *
	 * @author Alex Schaab
	 */
	public static final class PfArchiveFlight {

		/** procedure name */
		public static final String PF_ARCHIVE_FLIGHT = "pf_archive_flight";

		/** Flight's primary key */
		public static final String P_NRESULT_KEY = "p_nresult_key";

		/** Flight's transaction key */
		public static final String P_TRANSAKTION_KEY = "p_transaktion_key";

		/** INOUT Parameter, but not used currently */
		public static final String NRETURN = "nreturn";

		/** Constructor */
		private PfArchiveFlight() {
		}
	}

	/**
	 * Constants for DB procedure 'PF_CALC_IF203'. SAP IF203 procedure API.
	 *
	 * @author Ingo Rietzschel - U125742
	 */
	public static final class PfIf203 {
		/** procedure name */
		public static final String PF_IF203_NAME = "pf_calc_if203";

		/** IN-Parameter - name in GTT_PARAMETER for list of result keys. */
		public static final String P_CPARM_RESULT_KEY = "arg_cparm_result_key";

		/** IN-Parameter - date. */
		public static final String P_DDEPARTURE_FROM = "arg_ddeparture_from";

		/** IN-Parameter - date. */
		public static final String P_DDEPARTURE_TO = "arg_ddeparture_to";

		/** IN-Parameter - name in GTT_PARAMETER for area keys . */
		public static final String P_CPARM_AREA_KEY = "arg_cparm_area_key";

		/** IN-Parameter - number - work station key from. */
		public static final String P_NWS_FROM = "arg_nws_from";

		/** IN-Parameter - number - work stattion key to. */
		public static final String P_NWS_TO = "arg_nws_to";

		/** IN-Parameter - name in GTT_PARAMETER for material index keys. */
		public static final String P_CPARM_MATERIAL_INDEX_KEY = "arg_cparm_material_index_key";

		/** IN-Parameter - number. */
		public static final String P_NALL = "arg_nall";

		/** IN-Parameter - name in GTT_PARAMETER for reckonings. */
		public static final String P_CPARM_RECKONING = "arg_cparm_reckoning";

		/** IN-Parameter - name in GTT_PARAMETER PL-Kind keys. */
		public static final String P_CPARM_PL_KIND_KEY = "arg_cparm_pl_kind_key";

		/** IN-Parameter - name in GTT_PARAMETER for PL-Type keys. */
		public static final String P_CPARM_PLTYPE_KEY = "arg_cparm_pltype_key";

		/** IN-Parameter - string. */
		public static final String P_CSAPUNIT = "arg_csapunit";

		/** IN-Parameter - string. */
		public static final String P_CSAP_SERIAL = "arg_csapserial";

		/** IN-Parameter - name in GTT_PARAMETER for SAP kind keys. */
		public static final String P_CPARM_NSAP_KIND_KEY = "arg_cparm_sap_kind_key";

		/** IN-Parameter - string. */
		public static final String P_CCLIENT = "arg_cclient";

		/** OUT-Parameter - string. */
		public static final String P_MSG = "arg_msg";

		/** Constructor */
		private PfIf203() {
		}

	}

	/**
	 * Constants for DB procedure 'PF_PRODLABEL_DATACHANGED' on package 'CBASE_LABEL'.
	 *
	 * @author Alex Schaab - U524036
	 */
	public static final class PfProdlabelDatachanged {
		/** procedure name */
		public static final String PF_PRODLABEL_DATACHANGED = "pf_prodlabel_datachanged";

		/** IN-Parameter - Long the nbatchSeq to create the prod label data */
		public static final String P_BACTH_SEQ = CbaseMiddlewareDbConstants.AN_BATCH_SEQ;

		/** OUT-Parameter - Long indicating the type of change */
		public static final String P_DATACHANGED = "ai_datachanged";

		private PfProdlabelDatachanged() {
			/** Constructor */
		}
	}

	/**
	 * Constants for DB procedure 'PP_GET_PPM_SCHED' on package 'CBASE_PPM'.
	 * 
	 * @author Dirk Bunk - U200035
	 */
	public static final class PpGetPpmSched {
		/** procedure name */
		public static final String PP_GET_PPM_SCHED = "pp_get_ppm_sched";

		/** IN-Parameter - date the production date. */
		public static final String P_PROD_DATE = "arg_dprod_date";

		/** IN-Parameter - Long the workschedule index key. */
		public static final String P_WORKSCHEDULE_INDEX = "arg_nworkschedule_index";

		/** OUT-Parameter - Long the id for ppm_sched */
		public static final String P_PPM_SCHED_KEY = "arg_nppm_sched_key";

		/** Constructor */
		private PpGetPpmSched() {
		}
	}

	/**
	 * Constants for DB procedure 'PF_PLAN_SHIFT' on package 'CBASE_PPM'.
	 * 
	 * @author Heiko Rothenbach
	 */
	public static final class PpPlanShift {

		/** procedure name */
		public static final String PP_PLAN_SHIFT = "pf_plan_shift";

		/** IN-Parameter - date the production date. */
		public static final String P_PROD_DATE = "arg_dprod_date";

		/** IN-Parameter - Long the workschedule index key. */
		public static final String P_WORKSCHEDULE_INDEX = "arg_nworkschedule_index";

		/** OUT-Parameter - 1 okay / -1 bei Fehler */
		public static final String P_RET_VALUE = CbaseMiddlewareDbConstants.ARG_NRET;

		/** Constructor */
		private PpPlanShift() {
		}
	}

	/**
	 * Constants for DB procedure 'PF_' on package 'CBASE_PPM_XX'.
	 * 
	 * @author U009907
	 */
	public static final class PpUpdateSequences {

		/** procedure name */
		public static final String PP_UPDATE_SEQUENCES = "pp_update_sequence";

		/** IN-Parameter - date the production date. */
		public static final String P_PPM_SCHED_KEY = "arg_nppm_sched_key ";

		/** OUT-Parameter - 1 okay / -1 bei Fehler */
		public static final String P_RET_VALUE = "arg_iret";

		public static final String P_RET_MESSAGE = "arg_cmsg";

		/** Constructor */
		private PpUpdateSequences() {
		}
	}

	/**
	 * Constants for DB procedure 'PP_WORKORDER_PRINT' on package 'CBASE_LABEL'.
	 * 
	 * @author Dirk Bunk - U200035
	 */
	public static final class PpWorkOrderPrint {

		/** procedure name */
		public static final String PP_WORKORDER_PRINT = "pp_workorder_print";

		/** IN-Parameter - String the name of the app making the call. */
		public static final String P_CALLER = "as_caller";

		/** IN-Parameter - Long the result key. */
		public static final String P_RESULT_KEY = CbaseMiddlewareDbConstants.AN_RESULT_KEY;

		/** IN-Parameter - Long the batch sequence. */
		public static final String P_BATCH_SEQ = CbaseMiddlewareDbConstants.AN_BATCH_SEQ;

		/** IN-Parameter - 0 don't recreate the labels / 1 do recreate the labels . */
		public static final String P_FORCE_NEW = "ai_forcenew";

		/** IN-Parameter - 0 normal process / 1 only generate the labels . */
		public static final String P_SHOW_ONLY = "ai_showonly";

		/** IN-Parameter - -1 Default Label Printing Group / >0 Specific Label Printing Group . */
		public static final String P_LABEL_PRINTING_GROUP = "an_labelprintinggroup";

		/** OUT-Parameter - >=0 okay / -1 bei Fehler */
		public static final String P_RET_VALUE = "ai_ret";

		/** Constructor */
		private PpWorkOrderPrint() {
		}
	}

	/**
	 * Constants for DB procedure 'PP_WORKORDER_PRINT_INCREASES' on package 'CBASE_LABEL'.
	 * 
	 * @author Dirk Bunk - U200035
	 */
	public static final class PpWorkOrderPrintIncreases {

		/** procedure name */
		public static final String PP_WORKORDER_PRINT_INCREASES = "pp_print_increases";

		/** IN-Parameter - String the name of the app making the call. */
		public static final String P_CALLER = "as_caller";

		/** IN-Parameter - Long the ppm sched key. */
		public static final String P_PPM_SCHED_KEY = "an_ppm_sched_key";

		/** IN-Parameter - -1 Default Label Printing Group / >0 Specific Label Printing Group . */
		public static final String P_LABEL_PRINTING_GROUP = "an_labelprintinggroup";

		/** OUT-Parameter - >=0 okay / -1 bei Fehler */
		public static final String P_RET_VALUE = "ai_ret";

		/** Constructor */
		private PpWorkOrderPrintIncreases() {
		}
	}

	/**
	 * Constants for DB procedure 'PF_CALC_DURATION' on package 'CBASE_PPM'.
	 * 
	 * @author Heiko Rothenbach
	 */
	public static final class PfCalcDuration {

		/** procedure name */
		public static final String PF_CALC_DURATION = "pf_calc_duration";

		/** IN-Parameter - date the production date. */
		public static final String P_BATCH_SEQ = CbaseMiddlewareDbConstants.ARG_NBATCH_SEQ;

		/** OUT-Parameter - the new calculated duration for all batch -> ppm entries / -1 bei Fehler */
		public static final String P_RET_DURATION = "arg_nduration";

		/** Constructor */
		private PfCalcDuration() {
		}
	}

	/**
	 * Constants for DB procedure 'PP_CHK_UPD_PPM_TRAILPOINT' on package 'CBASE_TRAIL'. Defined in {@link CenOutPpmProdLabel}
	 * 
	 * @author Alex Schaab - U524036
	 */
	public static final class PpProdLabelTracking {

		/** procedure name */
		public static final String PP_PROD_LABEL_TRACKING = "pp_prod_label_tracking";

		/** IN-Parameter - the trailpoint id. */
		public static final String P_TRAILPOINT_KEY = "arg_ntrailpoint_key";

		/** OUT-Parameter - the error message if fails */
		public static final String P_RET_MSG = CbaseMiddlewareDbConstants.ARG_CMSG;

		/** Constructor */
		private PpProdLabelTracking() {
		}
	}

	/**
	 * Constants for DB procedure 'PP_COPY_CO' on package 'CBASE_PPM'.
	 * 
	 * @author Dirk Bunk
	 */
	public static final class PpCopyCo {

		/** procedure name */
		public static final String PP_COPY_CO = "pp_copy_co";

		/** IN-Parameter - Long the old batch sequence. */
		public static final String P_BATCH_SEQ_OLD = "arg_nbatch_seq_old";

		/** IN-Parameter - Long the new batch sequence. */
		public static final String P_BATCH_SEQ_NEW = "arg_nbatch_seq_new";

		/** OUT-Parameter - 1 okay / -1 bei Fehler */
		public static final String P_RET_VALUE = CbaseMiddlewareDbConstants.ARG_NRET;

		/** OUT-Parameter - error message (if an error occurred). */
		public static final String P_RET_MSG = CbaseMiddlewareDbConstants.ARG_CMSG;

		/** Constructor */
		private PpCopyCo() {
		}
	}

	/**
	 * Constants for DB procedure 'PP_HAS_DISTRIBUTION_ERRORS' on package 'CBASE_DISTRIBUTION'.
	 * 
	 * @author Dirk Bunk
	 */
	public static final class PpHasDistributionErrors {

		/** procedure name */
		public static final String PP_HAS_DISTRIBUTION_ERRORS = "pp_has_distribution_errors";

		/** IN-Parameter - Long the result key. */
		public static final String P_RESULT_KEY = CbaseMiddlewareDbConstants.ARG_NRESULT_KEY;

		/** IN-Parameter - Long the transaction. */
		public static final String P_TRANSACTION = "arg_ntransaction";

		/** IN-Parameter - Long the ppm sched key. */
		public static final String P_PPM_SCHED_KEY = "nppm_sched_key";

		/** OUT-Parameter - 1 okay / -1 bei Fehler */
		public static final String P_RET_VALUE = "arg_iret";

		/** Constructor */
		private PpHasDistributionErrors() {
		}
	}

	/**
	 * Constants for DB procedure 'PP_UPDATE_STORAGE' on package 'CBASE_PPM_UK'.
	 * 
	 * @author U009907
	 */
	public static final class PpUpdateStorage {

		/** procedure name */
		public static final String PP_UPDATE_STORAGES = "pp_update_stowages";

		/** IN-Parameter - Long the flight key. */
		public static final String P_NRESULT_KEY = CbaseMiddlewareDbConstants.ARG_NRESULT_KEY;

		/** IN-Parameter - Long the new batch sequence. */
		public static final String P_TRANSACTION = "arg_ntransaction";

		/** OUT-Parameter - error message (if an error occurred). */
		public static final String P_RET_MSG = CbaseMiddlewareDbConstants.ARG_CMSG;

		/** Constructor */
		private PpUpdateStorage() {
		}
	}

	/**
	 * Constants for DB procedure 'PP_INCREASE' on package 'CBASE_PPM_UK'.
	 * 
	 * @author U009907
	 */
	public static final class PpIncrease {

		/** procedure name */
		public static final String PP_INCREASE = "pp_increase";

		/** IN-Parameter - Long the flight key. */
		public static final String P_NRESULT_KEY = CbaseMiddlewareDbConstants.ARG_NRESULT_KEY;

		/** IN-Parameter - Long the PackinglistKey. */
		public static final String P_NPL_INDEX_KEY = "arg_npl_index_key";

		/** IN-Parameter - Long the PackinglistKey. */
		public static final String P_NQUANTITY = "arg_nquantity";

		/** IN-Parameter - Long the Resonkey. */
		public static final String P_NSHORTAGEWATE_KEY = "arg_nshortagewastage_key";

		/** OUT-Parameter - error message (if an error occurred). */
		public static final String P_NBATCH_SEQ = CbaseMiddlewareDbConstants.ARG_NBATCH_SEQ;

		/** OUT-Parameter - error message (if an error occurred). */
		public static final String P_MSG = "arg_msg";

		/** Constructor */
		private PpIncrease() {
		}
	}

	/**
	 * Constants for DB procedure 'set_context_user' on package 'CONTEXT_PACKAGE'.
	 * 
	 * @author U009907
	 */
	public static final class PpContextUser {

		/** procedure name */
		public static final String PP_CONTEXT_USER = "set_context_user";

		/** IN-Parameter - Long the User-ID. */
		public static final String P_USER_ID = "p_nuser_id";

		/** Constructor */
		private PpContextUser() {
		}
	}

	/**
	 * Constants for DB procedure 'set_context_role' on package 'CONTEXT_PACKAGE'.
	 * 
	 * @author U009907
	 */
	public static final class PpContextRole {

		/** procedure name */
		public static final String PP_CONTEXT_ROLE = "set_context_role";

		/** IN-Parameter - Long the User-ID. */
		public static final String P_ROLE_ID = "p_nrole_id";

		/** Constructor */
		private PpContextRole() {
		}
	}

	/**
	 * Constants for DB procedure 'reset_context_user_role' on package 'CONTEXT_PACKAGE'.
	 * 
	 * @author U009907
	 */
	public static final class PpContextResetUserRole {

		/** procedure name */
		public static final String PP_CONTEXT_RESET_USERROLE = "reset_context_user_role";

		/** Constructor */
		private PpContextResetUserRole() {
		}
	}

	/**
	 * Constants for DB procedure 'pp_get_changeovertime' on package 'CBASE_PPM'.
	 * 
	 * @author U009907
	 */
	public static final class PpGetChangeovertime {
		/** procedure name */
		public static final String PP_GET_CHANGEOVERTIME = "pp_get_changeovertime";

		/** IN-Parameter - Long the nbatchSeq to create the prod label data */
		public static final String P_BACTH_SEQ = "arg_nbatch_seq";

		/** IN-Parameter - DATE indicating the type of change */
		public static final String P_START_DATE = "arg_dstart_date";

		/** OUT-Parameter - Integer Seconds diff to pref Stop */
		public static final String P_RET = "arg_nret";

		private PpGetChangeovertime() {
			/** Constructor */
		}
	}

	/**
	 * Constants for DB procedure 'pp_get_next_sched' on package 'CBASE_PPM'.
	 * 
	 * @author U009907
	 */
	public static final class PpGetNextSched {
		/** procedure name */
		public static final String PP_GET_NEXT_SCHED = "pp_get_next_sched";

		/** IN-Parameter - Long the nbatchSeq to create the prod label data */
		public static final String P_NPPM_SCHED_KEY = "arg_nppm_sched_key";

		/** OUT-Parameter - Long key of the following shift */
		public static final String P_NPPM_SCHED_KEY_NEXT = "arg_nppm_sched_key_next ";

		private PpGetNextSched() {
			/** Constructor */
		}
	}

	/**
	 * Constants for DB procedure 'pf_get_position_by_rule' on package 'CBASE_CHILLER'.
	 * 
	 * @author Paola Lera - U116198
	 */
	public static final class PpGetPositionByRule {
		/** procedure name */
		public static final String PP_GET_POSITION_BY_RULE = "pp_get_position_by_rule";

		/** IN-Parameter - Long the warehouseKey to read the rules */
		public static final String P_WAREHOUSE_KEY = "arg_warehouse_key";

		/** IN-Parameter - Long the scannedKey, prod label or trolley key */
		public static final String P_SCANNED_KEY = "arg_scanned_key";

		/** IN-Parameter - Long the labelType, type of prod label or trolley key */
		public static final String P_LABEL_TYPE = "arg_key_type";

		/** OUT-Parameter - Long storageBinKey, the found storage location */
		public static final String P_STORAGE_BIN_KEY = "an_storage_bin_key";

		private PpGetPositionByRule() {
			/** Constructor */
		}
	}

	/** Constructor */
	private CbaseMiddlewareDbConstants() {
	}
}
