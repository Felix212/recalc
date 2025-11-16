HA$PBExportHeader$uo_cart_diagram.sru
$PBExportComments$Cart Diagramme erzeugen
forward
global type uo_cart_diagram from nonvisualobject
end type
end forward

global type uo_cart_diagram from nonvisualobject
end type
global uo_cart_diagram uo_cart_diagram

type prototypes

end prototypes

type variables

// 09.02.2010 Ulrich Paudler [UP] vor$$HEX1$$fc00$$ENDHEX$$bergehend deaktiviert
boolean			bFloatingContent = FALSE
boolean			bHasDimensions = FALSE

Long				iCurrentRow
Long				iCurrentColumn

uo_cart_datastore		dsPLContents
uo_cart_datastore		dsLayoutAddObjects
uo_cart_datastore		dsLayoutDimension
uo_cart_datastore		dsObjects

CONSTANT Long EMPTY = 0
CONSTANT Long DRAWER = 1
CONSTANT Long TRAY = 2
CONSTANT Long DRAWERFOOD = 3
CONSTANT Long TRAYNONFOOD= 4
CONSTANT Long FLOATING = 5
CONSTANT Long CONTENTTEXT = 6
CONSTANT Long BLOCKED = 9
CONSTANT Long PACKINGLIST = 10
CONSTANT Long DRAWER_3RUNG = 11
CONSTANT Long DRAWERFOOD_3RUNG = 12
CONSTANT Long DRAWER_MULTI_RUNG = 13

CONSTANT Long LISTOFCOMPONENTS = 99

// 20.10.2009 Ulrich Paudler [UP]
CONSTANT Long KEEPORDER = 0
CONSTANT Long COLUMNORDER		= 1
CONSTANT Long ROWORDER			= 2
CONSTANT Long COLUMNORDERINV	= 3
CONSTANT Long ROWORDERINV		= 4

// 26.10.2009 Ulrich Paudler [UP]
CONSTANT Long CONTAINER			= 0
CONSTANT Long TROLLEY			= 1

CONSTANT Long CONTENT			= 1
CONSTANT Long EXPLOSION			= 2
CONSTANT Long DISTRIBUTION		= 3


Datastore			oDs
Datawindow			oDw
Datawindow			oDwBacklog
Datastore			oDsBacklog

Public	DataStore			ids_TR_Exclusions
// ---------------------------------------------------
// 22.04.2010, KF
// Stauort, zum gezielteren debuggen
// ---------------------------------------------------
string				isStowage	= ""
Long					iTrace		= 1

PUBLIC	String		is_TR_Name

Private:
Long					lLayoutKey
Long					il_IndexKey
Long					lDetailKey
Long					il_AirlineKey 
String				sUnit						= ""
Long					lXOffSet 				=  50
Long					lYOffSet 				=  30
Long					lDefaultWidth 			= 322
Long					lDefaultWidthSmall 	= 255
Long					lDefaultHeight 		=  52
Long 					lErrorCount				=   0
String				sError
String				sTempPath
String				sRegisteredFiles[]
String				is_LogFile = "cart_diagram.log"
Long					iMaxContent							=  4
Long					iMaxContentDrawer					= 10
Long					iMaxRowsContent					=  6
Long					iMaxRowsContentExplosion	 	=  5

Long					iMaxContentTray					=  2
Long					iMaxContentDrawerFood			=  5

Long					iMaxContentDrawer3Rung			= 18
Long					iMaxRowsContent3Rung				= 10
Long					iMaxRowsContentExplosion3Rung =  9

Long					iMaxRowsContentTray				=  2
Long					iMaxRowsContentTrayNF			=  2
Long					iMaxRowsContentExplosionTray	=  1

Long					iMaxRowsContentTRExplosion		=  7

// TSC: AuditTrai: zum merken, ob ein reset angefordert wurde, damit er kurz vor dem commit getrackt werden kann
Long					il_audit_reset = -1

//Datetime				dDeparture

PUBLIC	Date			idt_Departure

uo_cart_datastore 	dsAirlineEq
uo_cart_datastore 	dsLayout
PUBLIC	uo_cart_datastore 	dsLayoutDetail
PUBLIC	uo_cart_datastore 	dsLayoutContents

uo_cart_datastore 	dsPL

// 03.09.2009 Ulrich Paudler [UP]
uo_cart_datastore		dsBacklog
boolean					bBacklog = false
Long						iCachedInitValue = 0

// 23.09.2009 Ulrich Paudler [UP]
long						ilCachedAirlineKey
string					isCachedUnit

// 05.10.2009 Ulrich Paudler [UP] Groessenpruefung
uo_cart_datastore 	dsPLSize
Long						llMaxContentLength = 6000

// 20.10.2009 Ulrich Paudler [UP]
string 					isContainerShortName
long 						ilContainerType
Long						il_Equipment_Width = 1

// 05.11.2009 Ulrich Paudler [UP] Distribution mit aufgenommen
uo_cart_distribution 	iuo_CartDistribution

// Cache f$$HEX1$$fc00$$ENDHEX$$r Profilestring
String sCachedUser 	= ""
String sCachedSection= ""
String sCachedKey		= ""
String sCachedValue	= ""

// 18.01.2010 Ulrich Paudler [UP]
CONSTANT Long	INITIALWIDTH 			= 322
CONSTANT Long	INITIALWIDTHSMALL 	= 255

CONSTANT Long	INITIALOFFSET1			= 186
CONSTANT Long	INITIALOFFSET2			=  40

CONSTANT Long	INITIALOFFSETSMALL1	= 186
CONSTANT Long	INITIALOFFSETSMALL2	= 200

CONSTANT Long	TEXTWIDTH1				= 280
CONSTANT Long	TEXTWIDTH2				= 322
CONSTANT Long	TEXTWIDTHSMALL1		= 255
CONSTANT Long	TEXTWIDTHSMALL2		= 255

CONSTANT Long	TEXTWIDTHTRSMALL		= 240



Boolean		ibEdit = FALSE
Long			ilColumnCount				= 0

//cacheing
String isCartDiagramFooter = ""
String isCartDiagramDistribution = ""
String isCartDiagramComponentList = ""
String isCartDiagramComponentDisplay = ""

String isTRCartDiagramFooter = ""
String isTRCartDiagramDistribution = ""
String isTRCartDiagramComponentList = ""
String isTRCartDiagramComponentDisplay = ""

String isCartDiagramBacklog = ""
String isCartDiagramBacklogSection = ""
Long   ilCartDiagramBacklogCounter = 0
Long   ilCartDiagramCompListCounter = 0

String isCartDiagramDownlineSetting = ""
Long   ilCartDiagramDownlineCounter = 0
//String isCartDiagramDownlineSetting = ""


// 02.02.2010 Ulrich Paudler [UP]
CONSTANT Long TEXTOBJECT							= 1
CONSTANT Long BITMAPOBJECT							= 2
CONSTANT Long RECTANGLEOBJECT						= 3
CONSTANT Long CONTENTOBJECT						= 4
CONSTANT Long FLOATCONTENTOBJECT					= 5
CONSTANT Long CONTENT_TEXT_OBJECT				= 6
CONSTANT Long CONTENT_TEXT_OBJECT_EXPLODED	= 7
// 1 = text, 2 = bitmap, 3 = rectangle, 4 = content

// ---------------------------------------------------
// 22.04.2010, KF
// 
// ---------------------------------------------------
Long	ilColumnWidth[]
Long 	ilColumnX[]
Long 	ilColumnY[]


CONSTANT		Integer			BORDER_NONE						= 0
CONSTANT		Integer			BORDER_SHADOW					= 1
CONSTANT		Integer			BORDER_BOX						= 2
CONSTANT		Integer			BORDER_RESIZE					= 3
CONSTANT		Integer			BORDER_UNDERLINE				= 4
CONSTANT		Integer			BORDER_LOWERED					= 5
CONSTANT		Integer			BORDER_RAISED					= 6

CONSTANT		Long				TR_CART							= 2
CONSTANT		Integer			AISLE_FLAG						= 6
CONSTANT		Integer			FONT_BOLD						= 700
CONSTANT		Integer			FONT_NORMAL						= 400
CONSTANT		Integer			WATERMARK_CLASS				= 100
CONSTANT		Integer			WATERMARK_DOWNLINE			= 101
CONSTANT		Integer			WATERMARK_FLIGHT_NUMBER		= 102
CONSTANT		Integer			WATERMARK_KITCHEN_TIME		= 103
CONSTANT		Integer			WATERMARK_RAMP_TIME			= 104
CONSTANT		Integer			WATERMARK_OPS					= 105
CONSTANT		Integer			WATERMARK_PRODRANGE			= 106
PUBLIC	CONSTANT		Integer			ALIGN_LEFT						= 0
PUBLIC	CONSTANT		Integer			ALIGN_CENTER					= 2
PUBLIC	CONSTANT		Integer			ALIGN_RIGHT						= 1

Public		Long				il_TR_DefaultHeight			= 52
Public		Long				il_TR_YOffset					= 10
PUBLIC		Long				il_Routing_ID					= -1
PUBLIC		Integer			ii_Catering_Leg				=  0
PROTECTED	Integer			ii_PL_Leg_Number				=  0

String							is_Ac_Type
String							is_Packinglist
String							is_Loadinglist
String							is_Description
String							is_TR_Cart_Description
String							is_RampBoxFrom
String							is_RampBoxTo
Long								il_Rungs, il_Columns
Long								il_Multiply
Boolean							ib_TR_Use_Class
Boolean							ib_TR_Fill_Top_Down			= FALSE
Boolean							ib_Expand_TR_Cart				= TRUE
Boolean							ib_Discard_Status_Billing	= TRUE
Long								il_Result_Key
Long								il_Transaction

uo_cart_datastore				ids_TR_Cart_Allocation

// Gr$$HEX1$$f600$$ENDHEX$$sse f$$HEX1$$fc00$$ENDHEX$$r neuen Header Footer
// Gr$$HEX1$$f600$$ENDHEX$$sse f$$HEX1$$fc00$$ENDHEX$$r neuen Header Footer
Long								il_Header_Height_Normal = 133
Long								il_Footer_Height_Normal =  76
Long								il_Header_Height_H_in_F = 145
Long								il_Footer_Height_H_in_F =  70

Integer							ii_TR_Cart_Left
Integer							ii_TR_Cart_Width
Integer							ii_TR_Cart_Top
Integer							ii_TR_Cart_Height

Integer							ii_Std_Cart_Left
Integer							ii_Std_Cart_Width
Integer							ii_Std_Cart_Top
Integer							ii_Std_Cart_Height

String							is_CSC

// Font Calc
ulong lTwipsPerPixelY
ulong lTwipsPerPixelX
uint ihDC

str_label_print istr_values[]


Public	Boolean	ib_Remove_Empty_Drawer = TRUE // FALSE

// --------------------------------------------------------
// 05.05.2011: Cart Wunschliste #133
// wenn bei Distribution eine Komponente mit einem Leg >1
// (Mealcode pos. 1) verteilt wird, soll der Drawer das
// Downline-Watermark bekommen (hier abschaltbar)
// -------------------------------------------------------
Public		Boolean	ib_Downline_by_Mealcode = TRUE // FALSE
Public		Long		il_Disable_Debug = 1 //0
Protected	String	is_User
Protected	String	is_Section					= ""
Public		String	is_TR_Cart_Area_WS		= ""

Protected	n_doc_gen_settings	inv_doc_gen_settings
Public		n_copy_Settings		inv_copy_settings
Public		Boolean					ib_use_doc_gen_settings = FALSE
PUBLIC		Boolean					ib_secondary_distribution_only = FALSE
PUBLIC		Boolean					ib_Mode_TR_Cart = FALSE

PUBLIC		Boolean					ib_Overflow
PUBLIC		Boolean					ib_Content_Spec

Protected	String					is_Overflow_MSG_1	// use content spec
Protected	String					is_Overflow_MSG_2 // see overflow
Protected	String					is_Overflow_MSG_3 // see cs and overflow
PUBLIC		Boolean					ib_Disable_Content_Spec_MSG = FALSE


// -----------------------------------------------------------------------
// Secondary Distribution in DataStores, um Speichern zu erm$$HEX1$$f600$$ENDHEX$$glichen
// 
// -----------------------------------------------------------------------
Public	uo_CBASE_DataStore	ids_SD_Master				// dsCartDiagramSheet
Public	uo_CBASE_DataStore	ids_SD_Components			// Component List
Public	uo_CBASE_DataStore	ids_SD_Cart					// Diagram Page
Public	uo_CBASE_DataStore	ids_SD_Cart_Drawer		// Cart Position - Einschub
Public	uo_CBASE_DataStore	ids_SD_Drawer_Content	// Inhalt des Drawer / Tray
Public	uo_CBASE_DataStore	ids_SD_Message				// Distr. Errors

Protected		Boolean			ib_require_exact_match	= FALSE
Protected		Boolean			ib_suppress_qty_1			= FALSE
Protected		Integer			ii_Current_Page			= 0
Protected		Boolean			ib_exact_match_ignore_SPML
CONSTANT			Integer			MSG_BACKLOG					= 1
CONSTANT			Integer			MSG_ERROR					= 2
CONSTANT			Integer			MSG_UNASSIGNED				= 3

Boolean	ib_Enable_Secondary_Distr_Saving = TRUE
Boolean	ib_Enable_Multirung_Cover_White = TRUE //FALSE

// ------------------------------------------------------------------------------------------------
// NAM-CR-12071 Master Data View - Create CD while ignoring local settings (e.g. Area Allocation)
// ------------------------------------------------------------------------------------------------
Public            Boolean   ib_Enable_Masterdata_View = FALSE

Protected         Boolean   ib_Force_Overflow = FALSE
Protected         Boolean   ib_Print_Overflow = FALSE


CONSTANT			String			FONT_MS_SANS_SERIF					= "MS Sans Serif"
CONSTANT			String			FONT_MICROSOFT_SANS_SERIF			= "Microsoft Sans Serif"

CONSTANT Long EXPLOSION_ON		=  1
CONSTANT Long EXPLOSION_OFF	=  0
CONSTANT Long EXPLOSION_DEF	= -1

CONSTANT Long DEFAULT			= -1

Boolean		ib_Healthmark = FALSE

// CBASE-UK-CR-2013-012
Boolean		ib_Belly_Watermark = FALSE

// CBASE-UK-CR-2013-013
Boolean		ib_Draw_Add_Text = FALSE

// CBASE-UK-CR-2013-006
Boolean		ib_Overflow_on_Main = FALSE

// CBASE-UK-CR-2013-002
Boolean		ib_Extended_TR_Handling = FALSE
Long			il_Workstations[]

uo_CBASE_DataStore	ids_Diagram_Pages


String		is_PL			= ""	
String		is_PL_Desc	= ""

String		is_TR_Area	= ""
String		is_TR_WS  	= ""
PUBLIC	String		is_TR_Freetext	= ""

Public	Integer		ii_tr_counter = 1	
end variables
forward prototypes
public function long of_create_defaults ()
public function long of_create_line (string sobjectname, long lx1, long ly1, long lx2, long ly2, long lcolor)
public function long of_draw_cart ()
public function long of_register (string sobject, long lrow, long lcolumn)
public function long of_unregister (string sobject)
public function long of_unregister_all ()
public function long of_remove_drawer (long irow, long icolumn)
public function long of_remove_tray (long irow, long icolumn)
public function long of_set_marker (long irow, long icolumn)
public function long of_remove ()
public function long of_add_content_explosion (long irow, long icolumn, long ldetail, long lsort)
public function long of_modified (datastore omodified)
public function long of_create_text (long lrow)
public function long of_update_objects ()
public function long of_set_position ()
public function long of_blob_to_file (string sfilename, blob bfilebuffer)
public function long of_file_to_blob (string sfilename, ref blob bfilebuffer)
public function long of_add_picture (string sfile, long lx, long ly, long lheight, long lwidth)
public function long of_create_picture (string sobjectname, string spicturename, long lx, long ly, long lheight, long lwidth, long ivisible, long iresize, long imove)
public function long of_get_type (long irow, long icolumn)
public function long of_get_detail_key (long irow, long icolumn)
public function long of_move_object (long inewrow, long inewcolumn, long ioldrow, long ioldcolumn)
public function long of_log (string smessage)
public function long of_remove_object (string sobject, long itype)
public function long of_update ()
public function string of_get_error ()
public function long of_set_file_to_blob (long arg_laddkey, string arg_sfile)
public function long of_remove_all ()
public function long of_remove_content (long irow, long icolumn)
public function long of_remove_content ()
public function long of_string2array (string sstring, string sseparator, ref string soutputarray[])
public function long of_get_blob_to_file (long arg_laddkey, string arg_stemppath, string arg_sfile)
public function long of_blob_save_bitmap (ref datawindow arg_dw)
public function long of_delete_layout (long arg_indexkey, long arg_detailkey)
public function long of_copy_layout (s_cartdiagram arg_str_cartdiagram, long arg_oldllayoutkey, long arg_newllayoutkey, ref s_layout_detail_mapper arg_str_layout_mapper_rework[])
public function long of_copy_layout_rework (s_cartdiagram arg_str_cartdiagram_rework, ref s_layout_detail_mapper arg_str_layout_mapper_rework[])
public function string of_generate_filename (string arg_prefix, string arg_suffix)
public function long of_copy_object (long inewrow, long inewcolumn, long ioldrow, long ioldcolumn)
public function long of_update (blob arg_b_datawindow, blob arg_b_backlog)
public function long of_modify_dw (string arg_s_mod)
public subroutine of_chc_trace (long iarg_level, string sarg_trace_text)
public function long of_register_file (string arg_s_file)
public function long of_set_order (long lrow, long lcolumn, long lorder)
public function string of_get_order (long lrow, long lcolumn)
public function long of_renumber_order (long arg_l_style)
public function long of_print_hide ()
public function long of_create_text (string sobjectname, string stext, string sfont, long ifontsize, long ifontweight, long lx, long ly, long lheight, long lwidth, long iborder, long ialign, long lcolor, long ivisible)
public function long of_create_ellipse (string sobjectname, long lx, long ly, long lh, long lw, long lcolor)
public function long of_get_container_type ()
public function string of_get_container_short_name ()
public function long of_create_wheel (string sobjectname, long lx, long ly, long lh, long lw, long lcolor)
public function boolean of_is_componentlist_enabled ()
public function boolean of_is_componentlist_available ()
public function long of_fill_backlog_page ()
public function boolean of_is_backlog_enabled ()
public function long of_print_init ()
public function long of_print_backlog ()
public function long of_print ()
public function long of_init (long arg_lindexkey, long arg_ldetailkey, long arg_lairlinekey, string arg_sunit, datastore arg_ods, datetime arg_ddeparture, datastore arg_odsbacklog)
public function long of_modify_dw_backlog (string arg_s_mod)
public function long of_set_position (string arg_s_mod, boolean arg_b_flag)
public function long of_getfullstate (ref blob arg_blob)
public function long of_getfullstate_backlog (ref blob arg_blob)
public function long of_get_backlog_rowcount ()
public function string of_profilestring (string suser, string ssection, string skey, string sdefault)
public function string of_setprofilestring (string suser, string ssection, string skey, string svalue)
public function long of_get_item_properties (long arg_l_row, long arg_l_column, ref s_distrib_items ref_str_item[])
public function long of_reset_backlog_page (long arg_l_type)
public function long of_copy_text (string arg_l_object)
public function long of_copy_picture (string arg_s_object)
public function long of_create_picture (long lrow, blob arg_b_blob)
public function long of_create_picture (long lrow)
public function long of_draw_tray (long arg_irow, long arg_icolumn, long arg_itype, boolean arg_bnew)
public function long of_draw_drawer (long arg_irow, long arg_icolumn, long arg_itype, boolean arg_bnew)
public function long of_draw_content_tray (long arg_llayoutdetailkey, long arg_irow, long arg_icolumn, ref long arg_ltype)
public function long of_get_maxcontent (long arg_l_row, long arg_l_column)
public function boolean of_is_distribution_enabled ()
public function string of_get_item_description (s_component arg_str_component)
public function long of_modify_text (string arg_s_object, string arg_s_text)
public function boolean of_is_editmode ()
public function long of_set_editmode (boolean arg_b_flag)
public function long of_create_component_list (s_component arg_component[])
public function boolean of_is_header_in_footer ()
public function long of_set_xposition (long arg_l_pos)
public function long of_print_deinit ()
public function long of_print_backlog_deinit ()
public function long of_add_backlog (long arg_l_row, long arg_l_column, string arg_s_object, decimal arg_dec_items, string arg_s_unit, string arg_s_text, long arg_l_counter, long arg_l_type, string arg_s_packinglist)
public function long of_draw_content_backlog_drawer (long arg_l_counter, long arg_i_row, long arg_i_column, datastore arg_ds_data, long arg_l_type, string arg_s_header)
public function long of_init (long arg_lindexkey, long arg_ldetailkey, long arg_lairlinekey, string arg_sunit, datawindow arg_odw, datetime arg_ddeparture, datawindow arg_odwbacklog)
public function long of_check_layout (long arg_l_indexkey, long arg_l_detailkey)
public function long of_get_detail_height (datawindow arg_dw)
public function long of_get_detail_height (datastore arg_ds)
public function boolean of_check_boundary (long arg_l_x, long arg_l_y, long arg_l_height, long arg_l_widht)
public function boolean of_check_string (string arg_s_string, string arg_s_check)
public function long of_add_text (string stext, long lx, long ly, long lheight, long lwidth)
public function long of_add_content_floating (long arg_l_x, long arg_l_y, long arg_l_detail, long arg_l_sort)
public function long of_draw_floating (long arg_irow, long arg_icolumn, long arg_itype, boolean arg_bnew)
public function long of_draw_content_floating (long arg_llayoutdetailkey, long arg_irow, long arg_icolumn)
public function long of_draw_content_backlog_tray (long arg_l_counter, long arg_i_row, long arg_i_column, string arg_s_text, long arg_l_type)
public function integer of_check_object_width ()
public function long of_get_xposition (long arg_l_pos, string arg_s_object)
public function long of_create_content_freetext (long lrow)
public function long of_add_content_freetext (long lx, long ly, long lheight, long lwidth, long ldetail, long lsort)
public function integer of_get_objects (ref string sobjects[])
public function integer of_explode_content_remove_subs (string sancestorobject)
public function long of_get_object_x (string sobject)
public function long of_get_object_y (string sobject)
public function long of_get_object_height (string sobject)
public function long of_get_object_width (string sobject)
public function integer of_explode_content_freetext (string sobject, integer icreate)
public function long of_draw_drawer_3_rung (long arg_irow, long arg_icolumn, long arg_itype, boolean arg_bnew)
public function integer of_is_position_change (integer arg_itype, long arg_inewrow, long arg_inewcolumn)
public function datastore of_request_datastore (integer arg_itype)
public function long of_add_rect (long lx, long ly, long lheight, long lwidth)
public function long of_create_rect (long lrow)
public function long of_draw_drawer_multi_rung (long arg_irow, long arg_icolumn, long arg_itype, long arg_no_of_rungs, long arg_no_of_cols, boolean arg_b_init)
public function long of_check_position (long itype, long inewrow, long inewcolumn, integer arg_no_of_rungs, integer arg_no_of_cols)
public function long of_set_marker_insert (long itype, long irow, long icolumn, long lmarkercolor, integer arg_no_of_rungs, integer arg_no_of_cols)
public function long of_draw_header (long al_result_key)
public function long of_create_text (string sobjectname, string stext, string sfont, long ifontsize, long ifontweight, long lx, long ly, long lheight, long lwidth, long iborder, long ialign, long lcolor, long ivisible, string sband)
public function long of_print_prepare_backlog (string arg_s_printer, string arg_s_airline, long arg_l_flightnumber, string arg_s_suffix, string arg_s_header, string arg_s_from, string arg_s_to, string arg_s_actype, string arg_s_stowage, long arg_l_page, long arg_l_belly, date arg_d_departure, string arg_s_time, string arg_s_class, string arg_s_container, string arg_s_owner, string arg_s_version, string arg_s_area, string arg_s_workstation, string arg_s_loadinglist)
public function long of_draw_footer (long al_result_key)
public function long of_init_tr (long arg_lindexkey, long arg_ldetailkey, long arg_lairlinekey, string arg_sunit, datastore arg_ods, datetime arg_ddeparture, datastore arg_odsbacklog)
public function long of_get_tr_cart_type (string as_client, string as_unit, long al_airline_key, long al_routing_id)
public function long of_create_text (string sobjectname, string stext, string sfont, long ifontsize, long ifontweight, long lx, long ly, long lheight, long lwidth, long iborder, long ialign, long lcolor, long ivisible, string sband, boolean ab_backlog)
public function long of_draw_footer (long al_result_key, boolean ab_backlog)
public function long of_draw_header (long al_result_key, boolean ab_backlog)
public function integer of_clean_band (string as_band, boolean ab_backlog)
public function long of_set_position (string arg_s_mod, boolean arg_b_flag, boolean ab_backlog)
public function long of_print_prepare_new_h_f (string arg_s_loadinglist, string arg_s_packinglist, string arg_s_pl_description, string arg_s_rampbox, string arg_s_stowage, string arg_s_class, string arg_s_workstation, string arg_s_currentpage, boolean ab_backlog)
public function integer of_check_object_sizes (boolean ab_backlog)
public function integer zzz_debug_box (boolean ab_backlog)
public function integer of_modify (string as_modify, boolean ab_backlog)
public function integer of_get_multiply ()
public function integer of_get_rungs ()
public function integer of_get_columns ()
public function string of_get_tr_cart_description ()
public function boolean of_is_use_class_enabled ()
public function boolean of_is_fill_top_down_enabled ()
public function long of_draw_tr_stowage_pos (long arg_irow, long arg_icolumn, long arg_itype, string arg_stowage)
public function long of_draw_watermark_downline (long arg_irow, long arg_icolumn, integer arg_ltype)
public function long of_draw_segment_indicator (long arg_irow, long arg_icolumn, long arg_itype, long arg_lnumber)
public function integer of_move_objects (string as_band, integer ai_offset_v, integer ai_offset_h, boolean ab_backlog)
public function integer of_get_min_offset (string as_band, boolean ab_backlog)
public function integer of_remove_contents_billing (ref datastore rads_contents)
public function boolean of_is_tr_componentlist_enabled ()
public function long of_create_line (string sobjectname, long lx1, long ly1, long lx2, long ly2, long lcolor, long al_width)
public function long of_draw_tr_background_col (long arg_irow, long arg_icolumn, long arg_color)
public function long of_draw_tr_segment_indicator (long arg_irow, long arg_icolumn, long arg_itype, long arg_lnumber)
public function integer of_move_to_background (boolean ab_backlog)
public function long of_draw_tr_drawer (long arg_irow, long arg_icolumn, long arg_itype, boolean arg_bnew, string as_description)
public function string of_describe_dw_backlog (string arg_s_mod)
public function string of_describe_dw (string arg_s_mod)
public function string of_describe (string as_modify, boolean ab_backlog)
public function boolean of_suppress_class_watermark (long al_airline_key, string as_unit, long al_routing, string as_class)
public function boolean of_is_downline_enabled (long al_airline_key, long al_routing_id, string as_unit)
public function boolean of_is_backcol_enabled (long al_airline_key, long al_routing_id, string as_unit)
public function integer of_get_watermark_type (long al_airline_key, long al_routing_id, string as_unit)
public function long of_draw_tr_cart (string as_unit)
public function long of_init_tr (string as_unit)
public function integer of_get_explosion_setting (long al_pl_index_key, string as_unit)
public function long of_draw_content (long irow, long icolumn, string as_unit)
public function boolean of_is_aisle_enabled (long al_index_key, long al_detail_key)
public function long of_draw_watermark_aisle (boolean ab_tr_cart)
public function long of_draw_watermark_downline (long arg_irow, long arg_icolumn, integer arg_ltype, boolean ab_transporter)
public function long of_init ()
public function long of_draw_watermark (integer ai_type, long al_flight_number, string as_ramp_time, string as_kitchen_time, string as_ops, string as_class, string as_prodrange, long al_airline_key, string as_unit, long al_routing, boolean ab_tr_cart)
public function integer of_get_print_width (string as_text, string as_font, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref integer rai_height, ref integer rai_width)
protected function boolean of_is_downline_enabled (string as_unit)
public function integer of_get_rungs_and_cols (long al_row, long al_column, ref long ral_rungs, ref long ral_columns)
public function integer of_get_relevant_row_column (long al_row, long al_column, ref long ral_master_row, ref long ral_master_column)
public function integer of_is_position_in_use (integer arg_itype, long arg_inewrow, long arg_inewcolumn, integer arg_irungs, integer arg_icolumns)
public function long of_get_content_length (long arg_l_index, long arg_l_detail)
public function boolean of_explode (long al_index_key, string as_unit, integer ai_parent_setting, integer ai_content)
public function long of_draw_content_drawer_multi (long arg_llayoutdetailkey, long arg_icontent, long arg_irow, long arg_icolumn, long arg_ltype, string arg_cunit)
public function boolean of_valid_airline_equipment (long al_airline_key, long al_packinglist_index_key, long al_packinglist_detail_key)
public function boolean of_check_eq (long al_airline_key, string as_unit_of_measure)
public function boolean of_has_contents (long arg_irow, long arg_icolumn)
public function long of_add_content (long irow, long icolumn, long ldetail, long lsort, long lheader_flag)
public function boolean of_is_content_sheet_header (long al_layout_detail_key, string as_cpackinglist)
public function long of_get_content_sheet_contents (long arg_llayoutdetailkey, long arg_irow, long arg_icolumn, string arg_cunit, long arg_start_pos, ref s_distrib_items astr_items[], boolean ab_header_flag)
public function integer of_align_objects (string as_match, long al_align_mode, boolean ab_backlog)
public function long of_get_explosion_content (long arg_llayoutdetailkey, long arg_irow, long arg_icolumn, string arg_cunit, long arg_start_pos, ref s_distrib_items astr_items[])
public function boolean of_is_explosion_enabled (long al_index_key, string as_unit, date ad_departure)
public function boolean of_exists_content_sheet_header (long al_column, long al_row)
public function long of_get_fixed_content (long arg_llayoutdetailkey, long arg_icontent, long arg_irow, long arg_icolumn, long arg_ltype, string arg_cunit, long arg_start_pos, ref s_distrib_items astr_items[], boolean ab_do_not_explode)
protected function long of_draw_content_drawer (long arg_llayoutdetailkey, long arg_icontent, long arg_irow, long arg_icolumn, long arg_ltype, string arg_sunit)
public function long of_draw_content_backlog_tray (long arg_l_counter, long arg_i_row, long arg_i_column, string arg_s_text, long arg_l_type, decimal arg_dec_qty)
public function long of_print_prepare (string arg_s_printer, string arg_s_airline, long arg_l_flightnumber, string arg_s_suffix, string arg_s_header, string arg_s_from, string arg_s_to, string arg_s_actype, string arg_s_stowage, long arg_l_page, long arg_l_belly, date arg_d_departure, string arg_s_time, string arg_s_class, string arg_s_container, string arg_s_owner, string arg_s_version, string arg_s_area, string arg_s_workstation, string arg_s_loadinglist, long arg_l_leg)
public function integer of_fill_component_list (ref uo_distribution rauodistribution, ref s_component rastr_component[], string arg_s_stowage, string arg_s_pl, long arg_l_lbelly)
public function integer of_init_slot (ref uo_cart_distribution rauocartdistribution, long al_row, long al_column, long al_maxlength)
public function integer of_distr_content_4_contentsheet (ref datastore rads_distribution_contents, ref uo_cart_distribution rauocartdistribution, long al_row, long al_column, long al_content_master_row_id)
public function long of_draw_watermark_downline (long arg_irow, long arg_icolumn, integer arg_ltype, long arg_lcolour)
public function long of_remove_distribution (long irow, long icolumn)
public function long of_remove_distribution ()
public function long of_remove_content (long irow, long icolumn, boolean ab_remove_distr_parms_4_multi)
public function integer of_handle_empty_contents (long al_row, long al_column, ref boolean rab_empty, ref boolean rab_entire_container_empty)
public function boolean of_set_user (string as_user)
protected function long of_adjust_xposition (long arg_l_pos, string arg_s_object)
public function integer of_clean_tr_diagram (ref datastore rads_diagramm)
public function long of_draw_watermark (integer ai_type, long al_flight_number, string as_ramp_time, string as_kitchen_time, string as_ops, string as_class, string as_prodrange, long al_airline_key, string as_unit, long al_routing, boolean ab_tr_cart, string as_suffix)
public function integer of_use_doc_gen_settings (n_doc_gen_settings anv_doc_gen_settings)
public function boolean of_set_section (string as_section)
public function integer of_sd_fill_component_list (ref uo_distribution rauodistribution, long al_row_id, string arg_s_stowage, string arg_s_pl, long arg_l_lbelly)
public function long of_sd_create_component_list (long al_row_id)
public function integer of_sd_save_distr_contents (s_distrib_items astr_distrib_items[], long al_rowid, long al_sd_cart_key, long al_page, long al_sd_drawer_key)
public function long of_sd_draw_distributed_components (uo_distribution arg_uo_distribution, string arg_s_stowage, string arg_s_pl, long arg_l_lbelly, string arg_s_carttype, string arg_unit, date arg_departure, boolean arg_bexplode_parent, ref uo_content_sheet rauo_content_sheet, boolean ab_content_sheet, long al_content_master_row_id, datastore rads_distribution_contents)
public function integer of_sd_init (string as_unit, long al_index_key, long al_detail_key, long al_airline_key, date adt_departure)
public function long of_sd_init ()
public function integer of_sd_get_distr_content (long al_column, long al_row, ref s_distrib_items astr_item[])
protected function integer of_sd_handle_empty_contents (long al_row, long al_column, ref boolean rab_empty, ref boolean rab_entire_container_empty, long al_sd_rowid, long al_sd_cart_key)
public function long of_sd_add_backlog (long arg_l_row, long arg_l_column, string arg_s_object, decimal arg_dec_items, string arg_s_unit, string arg_s_text, long arg_l_counter, long arg_l_type, string arg_s_packinglist, long arg_l_row_id)
public function integer of_sd_fill_backlog_data (long arg_l_row_id)
public function long of_sd_add_content_backlog_tray (long arg_l_counter, long arg_i_row, long arg_i_column, string arg_s_text, long arg_l_type, decimal arg_dec_qty, long arg_l_row_id)
public function long of_sd_add_content_backlog_drawer (long arg_l_counter, long arg_i_row, long arg_i_column, datastore arg_ds_data, long arg_l_type, string arg_s_header, long arg_l_rowid)
public function long of_sd_distribute_components (uo_distribution arg_uo_distribution, string arg_s_galley, string arg_s_stowage_only, string arg_s_stowage, string arg_s_pl, long arg_l_lbelly, string arg_s_carttype, string arg_unit, date arg_departure, boolean arg_bexplode_parent, ref uo_content_sheet rauo_content_sheet, boolean ab_content_sheet, long al_content_master_row_id, datastore rads_distribution_contents, long al_sd_rowid, long al_sd_cart_key, long al_page, string as_loadinglist)
public function long of_sd_add_error (long al_row_id, string as_galley, string as_stowage, string as_cart, string as_loadinglist, string as_component, string as_text, long al_distribution, string as_parameter, string as_definition, string as_unit, string as_information)
public function integer of_sd_set_filter_rowid (long al_content_master_row_id)
public function integer of_sd_add_content_sheet_header (string arg_s_carttype, string arg_unit, uo_content_sheet rauo_content_sheet, long al_content_master_row_id, datastore rads_distribution_contents)
protected function integer of_sd_distribute_components_alloc (long al_min_fit_factor_setting, date arg_departure, string arg_unit, long al_content_master_row_id, long al_sd_cart_key, string arg_s_galley, string arg_s_stowage_only, string arg_s_pl, string as_loadinglist, ref boolean ab_entire_container_empty)
public function integer of_sd_distribute_components_tray (long al_column, long al_row, string arg_unit, ref datastore rads_distribution_contents, long al_content_master_row_id, long al_sd_cart_key, long al_page, ref boolean rab_watermark_downline, ref boolean rab_suppress_watermark_downline)
public function integer of_sd_distribute_components_multi (long al_column, long al_row, string arg_unit, ref datastore rads_distribution_contents, long al_content_master_row_id, long al_sd_cart_key, long al_page, ref boolean rab_watermark_downline, ref boolean rab_suppress_watermark_downline)
public function integer of_sd_distribute_components_disabled (string arg_s_carttype, string arg_s_pl, string arg_s_stowage)
protected function integer of_sd_distribute_components_empty (ref boolean rab_entire_container_empty, long al_maxcolumns, long al_maxrows, ref uo_cart_distribution rauo_cart_distribution, long al_sd_rowid, long al_sd_cart_key, boolean ab_no_components, string arg_s_pl, date arg_departure, string arg_s_stowage)
public function string of_get_ramp_box (string as_box_from, string as_box_to, long al_box_mode)
public function integer of_sd_remove_empty_drawers (long al_row_id)
public function integer of_sd_draw_comp_tray (long al_column, long al_row, ref datastore rads_distribution_contents, long al_content_master_row_id, string arg_unit)
public function integer of_init_cd_tripticket (string as_unit, long al_airline_key, ref uo_tripticket rauo_tripticket)
public function integer of_count_cart_diagram_pages (string as_unit, long al_airline_key, ref datastore rads_unassigned, ref datastore rads_eq, ref datastore rads_cartdiagramsheet, ref uo_tripticket rauo_tripticket)
public function integer of_create_or_load_sec_distr (long al_result_key, long al_transaction, ref uo_distribution rauo_distribution, long al_airline_key, string as_unit, ref datastore rads_unassigned, ref datastore rads_eq, boolean ab_contentsheet, ref datastore rads_cartdiagramsheet, ref uo_tripticket rauo_tripticket, ref uo_content_sheet rauo_contentsheet)
public function integer of_create_acrobat (ref datastore dsacrobat, string as_file_name)
public function integer of_cart_diagram_merge (ref uo_documents rauo_product, string as_pdffiles[], boolean ab_printdirectly, boolean ab_use_printer_allocation, string as_printer_cart_diagram)
public function integer of_cart_diagram_content_sheet (boolean ab_contentsheet, long al_rowid, ref uo_content_sheet rauo_contentsheet)
public function integer of_create_cd_backlog_page (ref long ral_backlogpages, long al_row, long al_cartpages, ref long ral_filecounter, ref string ras_pdffiles[], ref uo_documents rauo_product, string as_rampbox, string as_stowage, string as_packinglist, string as_pl_description, string as_loadinglist, string as_class, string as_workstation, string as_version, string as_container, integer ai_flightnumber, string as_suffix, string as_header, string as_from, string as_to, string as_actype, long al_belly, string as_time, string as_owner, string as_area, string as_class_string, long al_backlogpages, string as_current_printer_1)
public function integer of_create_cart_diagram_page (long al_row, long al_rowid, long al_airline_key, string as_unit, ref long ral_cartpages, boolean ab_contentsheet, string as_current_printer_1, ref uo_documents rauo_product, long al_flightnumber, string as_suffix, string as_from, string as_to, string as_actype, string as_time, string as_owner, string as_version, long al_leg_nr, long al_number_of_pages, string as_fbox_from, string as_fbox_to, long al_watermark, string as_ramp_time, string as_kitchen_time, string as_ops, long al_routing_id, ref long ral_filecounter, ref string ras_pdffiles[], ref long ral_backlogpages, ref uo_content_sheet rauo_contentsheet, ref uo_distribution rauo_distribution)
public function integer of_tr_remove_entries (ref uo_distribution rauo_distribution, string as_unit, datastore ads_exclusions, ref datastore rads_cartdiagramsheet)
public function integer of_count_tr_cart_pages (string as_unit, ref uo_tr_cart_allocation rauo_tr_alloc, long al_airline_key, long al_routing_id, integer ai_fill_type, ref datastore rads_cartdiagramsheet)
public function integer of_create_tr_cartdigram_cs (boolean ab_content_sheet, long al_result_key, ref uo_distribution rauo_distribution, ref uo_content_sheet rauo_contentsheet, ref datastore rads_loading)
public function integer of_create_unassigned_cart_report (boolean ab_unassignedcarts, ref datastore rads_unassigned, ref uo_documents rauo_product, ref long ral_filecounter, ref string ras_pdffiles[])
public function boolean of_is_tr_header_in_footer ()
public function integer of_get_level_of_service (ref string ras_los[])
public function boolean of_is_content_spec_enabled (long arg_l_index, string arg_s_unit, date arg_d_departure)
public function integer of_distr_content_4_cs (ref datastore rads_distribution_contents, long al_row, long al_column, long al_content_master_row_id)
public function string of_overflow_message (string as_packinglist)
public function long of_adjust_font (string arg_s_object[], long arg_l_size, boolean arg_b_bold, boolean arg_b_italic)
public function long of_adjust_text_size (string arg_s_object[], long arg_l_height_factor)
public function integer of_calc_font_size (string as_text, ref long al_height, ref long al_width, string as_font_name, boolean ab_bold, boolean ab_italic, boolean ab_underline, boolean ab_wrap)
public function integer of_delete_secondary_distribution (long al_result_key, long al_transaction)
public function long of_is_cartdiagram_enabled (long arg_l_index, string arg_s_client, string arg_s_unit, ref boolean rab_no_entry)
public function long of_print (string as_printer, boolean ab_preview)
public function long of_get_fixed_content_drawer (long arg_llayoutdetailkey, long arg_icontent, long arg_irow, long arg_icolumn, long arg_ltype, string arg_cunit, long arg_start_pos, ref s_distrib_items astr_items[], boolean ab_do_not_explode)
public function boolean of_check_explode (long al_index_key, string as_unit)
public function boolean of_check_workstation_exclude (long al_workstation_key, long al_airline_key)
public function long of_draw_tr_content_drawer (long arg_index_key, long arg_detailkey, long arg_irow, long arg_icolumn, long arg_ltype, boolean ab_explode, string as_unit, string as_distribution_items[], string as_suppressed_items[])
public function long of_adjust_text_size_small_big (string arg_s_object[], long arg_l_height_factor)
public function integer of_sd_draw_comp_multi (long al_row, long al_column, string arg_unit, long al_master_row_id)
public function long of_get_fixed_content_tray (long arg_llayoutdetailkey, long arg_icontent, long arg_irow, long arg_icolumn, long arg_ltype, string arg_cunit, long arg_start_pos, ref s_distrib_items astr_items[], boolean ab_do_not_explode)
public function boolean of_check_center_setting ()
public function string of_get_item_description (s_component arg_str_component, boolean ab_fixed)
public function integer of_vertical_center_text_within_drawer (string as_object[], long al_column, long al_row)
public function integer of_apply_tr_workstation_exclusions (string as_unit, ref uo_tr_cart_allocation rauo_tr_alloc, long al_airline_key, long al_routing_id, integer ai_fill_type, ref datastore rads_cartdiagramsheet)
public function integer of_sd_draw_comp_drawer (long al_column, long al_row, ref datastore rads_distribution_contents, long al_content_master_row_id, string arg_unit, long al_master_content_setting)
public function boolean of_is_backlog_enabled_by_setup ()
public function long of_sd_create_tr_component_list (long al_row_id[], ref uo_distribution rauo_distribution, ref datastore rads_trcartdiagram)
public function integer of_sd_init_flight (long al_result_key, long al_transaction, boolean ab_require_exact_match, string as_csc, long al_airline_key)
public function boolean of_exists_tr_cart_per_unit (string as_unit)
public function long of_add_content_explosion (long irow, long icolumn, long ldetail, long lsort, boolean ab_header_flag)
public function integer of_create_tr_backlog_page (ref long ral_backlogpages, long al_row, long al_cartpages, ref long ral_filecounter, ref string ras_pdffiles[], string as_rampbox, string as_stowage, string as_packinglist, string as_pl_description, string as_loadinglist, string as_class, string as_workstation, string as_version, string as_container, integer ai_flightnumber, string as_suffix, string as_header, string as_from, string as_to, string as_actype, long al_belly, string as_time, string as_owner, string as_area, string as_class_string, long al_backlogpages, string as_current_printer_1, string as_unit, string as_airline)
public function integer of_create_unassigned_tr_cart_report (ref datastore rads_unassigned, ref long ral_filecounter, ref string ras_pdffiles[], long al_flight_number, string as_airline)
public function long of_draw_additional_text (string as_text_1, string as_label_text_2)
public function long of_draw_backlog_on_main ()
public function integer of_draw_healthmark (string as_unit, boolean ab_backlog)
public function integer of_get_label_group (string as_unit)
public function integer of_set_pl (string as_pl, string as_pl_desc)
public function long of_draw_tr_add_text_indicator (long arg_irow, long arg_icolumn, string arg_text)
public function long of_draw_tr_freetext (string as_text)
public function long of_draw_watermark_belly (long al_belly)
public function long of_get_tr_cart_key (string as_unit, long al_index_key, date adt_ref_date, ref long ral_number_of_rungs, ref long ral_number_of_columns, ref long ral_number_of_pages)
public function long of_sd_add_backlog (long arg_l_row, long arg_l_column, string arg_s_object, decimal arg_dec_items, string arg_s_unit, string arg_s_text, long arg_l_counter, long arg_l_type, string arg_s_packinglist, long arg_l_row_id, string arg_s_stowage)
public function long of_sd_find_backlog (long arg_l_row, long arg_l_column, string arg_s_object, decimal arg_dec_items, string arg_s_unit, string arg_s_text, long arg_l_counter, long arg_l_type, string arg_s_packinglist, long arg_l_row_id)
public function string of_get_additional_label_text (long al_packinglist_index_key, string as_unit, date adt_departure)
public function boolean of_is_add_on_text_enabled ()
public function boolean of_is_healthmark_enabled (string as_unit)
end prototypes

public function long of_create_defaults ();
return 1
end function

public function long of_create_line (string sobjectname, long lx1, long ly1, long lx2, long ly2, long lcolor);
return 1

end function

public function long of_draw_cart ();
Return 1
end function

public function long of_register (string sobject, long lrow, long lcolumn);
return 1

end function

public function long of_unregister (string sobject);
return 1
end function

public function long of_unregister_all ();
return 1
end function

public function long of_remove_drawer (long irow, long icolumn);
return 1
end function

public function long of_remove_tray (long irow, long icolumn);
return 1
end function

public function long of_set_marker (long irow, long icolumn);
return 1
end function

public function long of_remove ();
return 1

end function

public function long of_add_content_explosion (long irow, long icolumn, long ldetail, long lsort);
return 1
end function

public function long of_modified (datastore omodified);/*************************************************************
* Objekt : uo_cart_diagram
* Methode: of_modified (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 23.11.2009
* Argument(e):
* datastore omodified
*
* Return: long
*
*
*
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
* ???			1.0          ???				Erstellung
*
*************************************************************/


return 0
end function

public function long of_create_text (long lrow);
return 1

end function

public function long of_update_objects ();
return 1
end function

public function long of_set_position ();
return 1
end function

public function long of_blob_to_file (string sfilename, blob bfilebuffer);
return 1

end function

public function long of_file_to_blob (string sfilename, ref blob bfilebuffer);
return 0

end function

public function long of_add_picture (string sfile, long lx, long ly, long lheight, long lwidth);
return 1
end function

public function long of_create_picture (string sobjectname, string spicturename, long lx, long ly, long lheight, long lwidth, long ivisible, long iresize, long imove);
return 1

end function

public function long of_get_type (long irow, long icolumn);
return -1
end function

public function long of_get_detail_key (long irow, long icolumn);
return -1

end function

public function long of_move_object (long inewrow, long inewcolumn, long ioldrow, long ioldcolumn);
return 0

end function

public function long of_log (string smessage);
return 0

end function

public function long of_remove_object (string sobject, long itype);
return 0
end function

public function long of_update ();
return 1

end function

public function string of_get_error ();/*************************************************************
* Objekt : uo_cart_diagram
* Methode: of_get_error (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 16.04.2009
*
* Argument(e):	none
* Return: string
*
*
*
*
*
*************************************************************
* Modifikationen:
* Datum    Version        Autor              Kommentar
*------------------------------------------------------------
*
*************************************************************/


return sError
end function

public function long of_set_file_to_blob (long arg_laddkey, string arg_sfile);
return 1
end function

public function long of_remove_all ();
return 1

end function

public function long of_remove_content (long irow, long icolumn);// --------------------------------------------------------------------------------
// Objekt : uo_cart_diagram
// Methode: of_remove_content (Function)
// Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
// --------------------------------------------------------------------------------
// Argument(e):
// long llayoutdetailkey
// --------------------------------------------------------------------------------
// Return: Long
// --------------------------------------------------------------------------------
//  Beschreibung:
//  L$$HEX1$$f600$$ENDHEX$$schen der zugeordneten Inhalte eines Einschubs/Tabletts
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  04.12.2008	           Klaus F$$HEX1$$f600$$ENDHEX$$rster     Erstellung
//  17.04.2009		      U.Paudler		Filter zur$$HEX1$$fc00$$ENDHEX$$cksetzen, Postion als $$HEX1$$dc00$$ENDHEX$$bergabeparameter
//  03.09.2009			Ulrich Paudler	Backlog hinzugef$$HEX1$$fc00$$ENDHEX$$gt
//  08.02.2010			Ulrich Paudler	Formatierungen zur$$HEX1$$fc00$$ENDHEX$$cksetzen
//  23.05.2011            Funktionsvariante mit Boolean Parameter (Erzwinge Entfernen der Distribution Parms f$$HEX1$$fc00$$ENDHEX$$r Multirungs)
// --------------------------------------------------------------------------------


Return of_remove_content(irow, icolumn, FALSE)


end function

public function long of_remove_content ();/*************************************************************
* Objekt : uo_cart_diagram
* Methode: of_remove_content (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 17.04.2009
*
* Argument(e):	none
* Return: Long
*
*
*
* Entfernen des Contents an der aktuellen Stelle
*
*************************************************************
* Modifikationen:
* Datum    Version        Autor              Kommentar
*------------------------------------------------------------
*
*************************************************************/


return of_remove_content(iCurrentRow, iCurrentColumn)
end function

public function long of_string2array (string sstring, string sseparator, ref string soutputarray[]);
RETURN 1
end function

public function long of_get_blob_to_file (long arg_laddkey, string arg_stemppath, string arg_sfile);
return 1

end function

public function long of_blob_save_bitmap (ref datawindow arg_dw);
return 0
end function

public function long of_delete_layout (long arg_indexkey, long arg_detailkey);
return 1
end function

public function long of_copy_layout (s_cartdiagram arg_str_cartdiagram, long arg_oldllayoutkey, long arg_newllayoutkey, ref s_layout_detail_mapper arg_str_layout_mapper_rework[]);
return 1
end function

public function long of_copy_layout_rework (s_cartdiagram arg_str_cartdiagram_rework, ref s_layout_detail_mapper arg_str_layout_mapper_rework[]);
return 1


end function

public function string of_generate_filename (string arg_prefix, string arg_suffix);
Return "."
end function

public function long of_copy_object (long inewrow, long inewcolumn, long ioldrow, long ioldcolumn);
return 0
end function

public function long of_update (blob arg_b_datawindow, blob arg_b_backlog);
return 1 

end function

public function long of_modify_dw (string arg_s_mod);			
return 0

end function

public subroutine of_chc_trace (long iarg_level, string sarg_trace_text);
return
end subroutine

public function long of_register_file (string arg_s_file);
Return 0

end function

public function long of_set_order (long lrow, long lcolumn, long lorder);
return 0
end function

public function string of_get_order (long lrow, long lcolumn);
return " "

end function

public function long of_renumber_order (long arg_l_style);
return 0

end function

public function long of_print_hide ();
return 0

end function

public function long of_create_text (string sobjectname, string stext, string sfont, long ifontsize, long ifontweight, long lx, long ly, long lheight, long lwidth, long iborder, long ialign, long lcolor, long ivisible);
return 1

end function

public function long of_create_ellipse (string sobjectname, long lx, long ly, long lh, long lw, long lcolor);
return 1

end function

public function long of_get_container_type ();/*************************************************************
* Objekt : uo_cart_diagram
* Methode: of_get_container_type (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 26.10.2009
* Argument(e):
* none
*
* Return: long
*
*
*
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  26.10.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/


return ilContainerType

end function

public function string of_get_container_short_name ();/*************************************************************
* Objekt : uo_cart_diagram
* Methode: of_get_container_short_name (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 26.10.2009
* Argument(e):
* none
*
* Return: string
*
*
*
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  26.10.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/


return isContainerShortName

end function

public function long of_create_wheel (string sobjectname, long lx, long ly, long lh, long lw, long lcolor);
return 1

end function

public function boolean of_is_componentlist_enabled ();
Return TRUE

end function

public function boolean of_is_componentlist_available ();
return false


end function

public function long of_fill_backlog_page ();
return 0

end function

public function boolean of_is_backlog_enabled ();
return False

end function

public function long of_print_init ();
return 0

end function

public function long of_print_backlog ();
return 0

end function

public function long of_print ();
return 0

end function

public function long of_init (long arg_lindexkey, long arg_ldetailkey, long arg_lairlinekey, string arg_sunit, datastore arg_ods, datetime arg_ddeparture, datastore arg_odsbacklog);
return 1


end function

public function long of_modify_dw_backlog (string arg_s_mod);
			
return 0
end function

public function long of_set_position (string arg_s_mod, boolean arg_b_flag);/*************************************************************
* Objekt : uo_cart_diagram
* Methode: of_set_position (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 29.10.2009
* Argument(e):
* string arg_s_mod
*
* Return: long
*
*
*
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  29.10.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/


Return of_set_position( arg_s_mod, arg_b_flag, FALSE)
end function

public function long of_getfullstate (ref blob arg_blob);
return 1
end function

public function long of_getfullstate_backlog (ref blob arg_blob);
return 1

end function

public function long of_get_backlog_rowcount ();
return 0

end function

public function string of_profilestring (string suser, string ssection, string skey, string sdefault);
return ""

end function

public function string of_setprofilestring (string suser, string ssection, string skey, string svalue);
return "0"

end function

public function long of_get_item_properties (long arg_l_row, long arg_l_column, ref s_distrib_items ref_str_item[]);
return 1

end function

public function long of_reset_backlog_page (long arg_l_type);
return 0
end function

public function long of_copy_text (string arg_l_object);
return 1
end function

public function long of_copy_picture (string arg_s_object);
return 1
end function

public function long of_create_picture (long lrow, blob arg_b_blob);
return 1

end function

public function long of_create_picture (long lrow);
return 1

end function

public function long of_draw_tray (long arg_irow, long arg_icolumn, long arg_itype, boolean arg_bnew);
return 1

end function

public function long of_draw_drawer (long arg_irow, long arg_icolumn, long arg_itype, boolean arg_bnew);
Return 1

end function

public function long of_draw_content_tray (long arg_llayoutdetailkey, long arg_irow, long arg_icolumn, ref long arg_ltype);
return 0
end function

public function long of_get_maxcontent (long arg_l_row, long arg_l_column);
Return 0

end function

public function boolean of_is_distribution_enabled ();
return False

end function

public function string of_get_item_description (s_component arg_str_component);

Return " "

end function

public function long of_modify_text (string arg_s_object, string arg_s_text);			
return 0

end function

public function boolean of_is_editmode ();/*************************************************************
* Objekt : uo_cart_diagram
* Methode: of_is_editmode (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 18.01.2010
* Argument(e):
* none
*
* Return: boolean
*
*
*
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  18.01.2010	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/


return ibEdit

end function

public function long of_set_editmode (boolean arg_b_flag);
return 0


end function

public function long of_create_component_list (s_component arg_component[]);return 1

end function

public function boolean of_is_header_in_footer ();
return False

end function

public function long of_set_xposition (long arg_l_pos);
return 0


end function

public function long of_print_deinit ();
return 0
end function

public function long of_print_backlog_deinit ();

return 0
end function

public function long of_add_backlog (long arg_l_row, long arg_l_column, string arg_s_object, decimal arg_dec_items, string arg_s_unit, string arg_s_text, long arg_l_counter, long arg_l_type, string arg_s_packinglist);

return 1


end function

public function long of_draw_content_backlog_drawer (long arg_l_counter, long arg_i_row, long arg_i_column, datastore arg_ds_data, long arg_l_type, string arg_s_header);
return 1

end function

public function long of_init (long arg_lindexkey, long arg_ldetailkey, long arg_lairlinekey, string arg_sunit, datawindow arg_odw, datetime arg_ddeparture, datawindow arg_odwbacklog);
return 1


end function

public function long of_check_layout (long arg_l_indexkey, long arg_l_detailkey);
return 0
end function

public function long of_get_detail_height (datawindow arg_dw);
return 1083

end function

public function long of_get_detail_height (datastore arg_ds);
return 1083

end function

public function boolean of_check_boundary (long arg_l_x, long arg_l_y, long arg_l_height, long arg_l_widht);
return true
end function

public function boolean of_check_string (string arg_s_string, string arg_s_check);
return FALSE
end function

public function long of_add_text (string stext, long lx, long ly, long lheight, long lwidth);
return 1
end function

public function long of_add_content_floating (long arg_l_x, long arg_l_y, long arg_l_detail, long arg_l_sort);
return 1


end function

public function long of_draw_floating (long arg_irow, long arg_icolumn, long arg_itype, boolean arg_bnew);
return 1

end function

public function long of_draw_content_floating (long arg_llayoutdetailkey, long arg_irow, long arg_icolumn);
return 0

end function

public function long of_draw_content_backlog_tray (long arg_l_counter, long arg_i_row, long arg_i_column, string arg_s_text, long arg_l_type);
return 1
end function

public function integer of_check_object_width ();
return 1
end function

public function long of_get_xposition (long arg_l_pos, string arg_s_object);
return 0


end function

public function long of_create_content_freetext (long lrow);
return 1

end function

public function long of_add_content_freetext (long lx, long ly, long lheight, long lwidth, long ldetail, long lsort);
return 1
end function

public function integer of_get_objects (ref string sobjects[]);
return 0

end function

public function integer of_explode_content_remove_subs (string sancestorobject);
return 1

end function

public function long of_get_object_x (string sobject);
return 0
end function

public function long of_get_object_y (string sobject);
			
return 0
end function

public function long of_get_object_height (string sobject);	
return 0

end function

public function long of_get_object_width (string sobject);
return 0
end function

public function integer of_explode_content_freetext (string sobject, integer icreate);
return 0
end function

public function long of_draw_drawer_3_rung (long arg_irow, long arg_icolumn, long arg_itype, boolean arg_bnew);
return 1

end function

public function integer of_is_position_change (integer arg_itype, long arg_inewrow, long arg_inewcolumn);
return 1

end function

public function datastore of_request_datastore (integer arg_itype);return  this.dsLayoutDetail
	
end function

public function long of_add_rect (long lx, long ly, long lheight, long lwidth);	
return 1

end function

public function long of_create_rect (long lrow);
return 1

end function

public function long of_draw_drawer_multi_rung (long arg_irow, long arg_icolumn, long arg_itype, long arg_no_of_rungs, long arg_no_of_cols, boolean arg_b_init);
Return 1

end function

public function long of_check_position (long itype, long inewrow, long inewcolumn, integer arg_no_of_rungs, integer arg_no_of_cols);
return EMPTY

end function

public function long of_set_marker_insert (long itype, long irow, long icolumn, long lmarkercolor, integer arg_no_of_rungs, integer arg_no_of_cols);
return 1
end function

public function long of_draw_header (long al_result_key);/*
* Objekt : uo_cart_diagram
* Methode: of_draw_header (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 21.07.2010
*
* Argument(e):
* long al_result_key
*
* Beschreibung:		Zeichne neuen Header gem$$HEX3$$e400df002000$$ENDHEX$$CBASE-NAM-CR-0029
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	21.07.2010		Erstellung
*
*
* Return: long
*
*/

Return of_draw_header(al_result_key, FALSE)


end function

public function long of_create_text (string sobjectname, string stext, string sfont, long ifontsize, long ifontweight, long lx, long ly, long lheight, long lwidth, long iborder, long ialign, long lcolor, long ivisible, string sband);
Return of_create_text(sobjectname,stext,sfont, ifontsize, ifontweight, lx, ly, lheight, lwidth, iborder, ialign, lcolor, ivisible, sband, FALSE)


end function

public function long of_print_prepare_backlog (string arg_s_printer, string arg_s_airline, long arg_l_flightnumber, string arg_s_suffix, string arg_s_header, string arg_s_from, string arg_s_to, string arg_s_actype, string arg_s_stowage, long arg_l_page, long arg_l_belly, date arg_d_departure, string arg_s_time, string arg_s_class, string arg_s_container, string arg_s_owner, string arg_s_version, string arg_s_area, string arg_s_workstation, string arg_s_loadinglist);
return 0

end function

public function long of_draw_footer (long al_result_key);/*
* Objekt : uo_cart_diagram
* Methode: of_draw_footer (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 28.07.2010
*
* Argument(e):
* long al_result_key
*
* Beschreibung:		Footer zeichnen
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	28.07.2010		Erstellung
*
*
* Return: long
*
*/

Return of_draw_footer(al_result_key, FALSE)


end function

public function long of_init_tr (long arg_lindexkey, long arg_ldetailkey, long arg_lairlinekey, string arg_sunit, datastore arg_ods, datetime arg_ddeparture, datastore arg_odsbacklog);
return 1

end function

public function long of_get_tr_cart_type (string as_client, string as_unit, long al_airline_key, long al_routing_id);
Return -1

end function

public function long of_create_text (string sobjectname, string stext, string sfont, long ifontsize, long ifontweight, long lx, long ly, long lheight, long lwidth, long iborder, long ialign, long lcolor, long ivisible, string sband, boolean ab_backlog);
return 1

end function

public function long of_draw_footer (long al_result_key, boolean ab_backlog);	
Return 1

end function

public function long of_draw_header (long al_result_key, boolean ab_backlog);
Return 1

end function

public function integer of_clean_band (string as_band, boolean ab_backlog);
Return 1
end function

public function long of_set_position (string arg_s_mod, boolean arg_b_flag, boolean ab_backlog);
return 0
end function

public function long of_print_prepare_new_h_f (string arg_s_loadinglist, string arg_s_packinglist, string arg_s_pl_description, string arg_s_rampbox, string arg_s_stowage, string arg_s_class, string arg_s_workstation, string arg_s_currentpage, boolean ab_backlog);
Return 0

end function

public function integer of_check_object_sizes (boolean ab_backlog);
Return 1
end function

public function integer zzz_debug_box (boolean ab_backlog);
Return 1
end function

public function integer of_modify (string as_modify, boolean ab_backlog);

Return 1

end function

public function integer of_get_multiply ();
Return il_Multiply
end function

public function integer of_get_rungs ();
return il_Rungs
end function

public function integer of_get_columns ();
Return il_columns
end function

public function string of_get_tr_cart_description ();/*
* Objekt : uo_cart_diagram
* Methode: of_get_tr_cart_description (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 09.08.2010
*
* Argument(e):
* none
*
* Beschreibung:		TR Cart Description
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	09.08.2010		Erstellung
*
*
* Return: string
*
*/


return is_TR_Cart_Description
end function

public function boolean of_is_use_class_enabled ();/*
* Objekt : uo_cart_diagram
* Methode: of_is_use_class_enabled (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 09.08.2010
*
* Argument(e):
* none
*
* Beschreibung:		Stammdaten TR Cart - Schalter "Use Class" (bef$$HEX1$$fc00$$ENDHEX$$llen nach Class getrennt)
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	09.08.2010		Erstellung
*
*
* Return: boolean
*
*/


Return 	ib_TR_Use_Class 
end function

public function boolean of_is_fill_top_down_enabled ();/*
* Objekt : uo_cart_diagram
* Methode: of_is_fill_top_down_enabled (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 09.08.2010
*
* Argument(e):
* none
*
* Beschreibung:		Stammdaten TR Cart - Schalter "Fill Top - Down"
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	qq.08.2010		Erstellung
*
*
* Return: boolean
*
*/


Return 	ib_TR_Fill_Top_Down 
end function

public function long of_draw_tr_stowage_pos (long arg_irow, long arg_icolumn, long arg_itype, string arg_stowage);
Return 1

end function

public function long of_draw_watermark_downline (long arg_irow, long arg_icolumn, integer arg_ltype);
return 0
end function

public function long of_draw_segment_indicator (long arg_irow, long arg_icolumn, long arg_itype, long arg_lnumber);
Return 1

end function

public function integer of_move_objects (string as_band, integer ai_offset_v, integer ai_offset_h, boolean ab_backlog);	
Return 1

end function

public function integer of_get_min_offset (string as_band, boolean ab_backlog);	
Return 0

end function

public function integer of_remove_contents_billing (ref datastore rads_contents);
Return 1
end function

public function boolean of_is_tr_componentlist_enabled ();
return False

end function

public function long of_create_line (string sobjectname, long lx1, long ly1, long lx2, long ly2, long lcolor, long al_width);
return 1

end function

public function long of_draw_tr_background_col (long arg_irow, long arg_icolumn, long arg_color);
Return 1

end function

public function long of_draw_tr_segment_indicator (long arg_irow, long arg_icolumn, long arg_itype, long arg_lnumber);
Return 1

end function

public function integer of_move_to_background (boolean ab_backlog);		
Return 1

end function

public function long of_draw_tr_drawer (long arg_irow, long arg_icolumn, long arg_itype, boolean arg_bnew, string as_description);
Return 1

end function

public function string of_describe_dw_backlog (string arg_s_mod);
return " "
end function

public function string of_describe_dw (string arg_s_mod);
return " "
end function

public function string of_describe (string as_modify, boolean ab_backlog);
Return  " "

end function

public function boolean of_suppress_class_watermark (long al_airline_key, string as_unit, long al_routing, string as_class);
Return FALSE
end function

public function boolean of_is_downline_enabled (long al_airline_key, long al_routing_id, string as_unit);
Return FALSE

end function

public function boolean of_is_backcol_enabled (long al_airline_key, long al_routing_id, string as_unit);
Return FALSE

end function

public function integer of_get_watermark_type (long al_airline_key, long al_routing_id, string as_unit);
Return 0

end function

public function long of_draw_tr_cart (string as_unit);
Return 1

end function

public function long of_init_tr (string as_unit);
return 1
end function

public function integer of_get_explosion_setting (long al_pl_index_key, string as_unit);
Return 0

end function

public function long of_draw_content (long irow, long icolumn, string as_unit);
return 1
end function

public function boolean of_is_aisle_enabled (long al_index_key, long al_detail_key);
Return false

end function

public function long of_draw_watermark_aisle (boolean ab_tr_cart);
Return 0
end function

public function long of_draw_watermark_downline (long arg_irow, long arg_icolumn, integer arg_ltype, boolean ab_transporter);	
return 0

end function

public function long of_init ();
return 1

end function

public function long of_draw_watermark (integer ai_type, long al_flight_number, string as_ramp_time, string as_kitchen_time, string as_ops, string as_class, string as_prodrange, long al_airline_key, string as_unit, long al_routing, boolean ab_tr_cart);		
Return 0

end function

public function integer of_get_print_width (string as_text, string as_font, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref integer rai_height, ref integer rai_width);
Return 0

end function

protected function boolean of_is_downline_enabled (string as_unit);
Return FALSE

end function

public function integer of_get_rungs_and_cols (long al_row, long al_column, ref long ral_rungs, ref long ral_columns);
Return 1

end function

public function integer of_get_relevant_row_column (long al_row, long al_column, ref long ral_master_row, ref long ral_master_column);
Return 1

end function

public function integer of_is_position_in_use (integer arg_itype, long arg_inewrow, long arg_inewcolumn, integer arg_irungs, integer arg_icolumns);
return 1

end function

public function long of_get_content_length (long arg_l_index, long arg_l_detail);

return 0

end function

public function boolean of_explode (long al_index_key, string as_unit, integer ai_parent_setting, integer ai_content);
Return true

end function

public function long of_draw_content_drawer_multi (long arg_llayoutdetailkey, long arg_icontent, long arg_irow, long arg_icolumn, long arg_ltype, string arg_cunit);
Return 0

end function

public function boolean of_valid_airline_equipment (long al_airline_key, long al_packinglist_index_key, long al_packinglist_detail_key);
Return TRUE
end function

public function boolean of_check_eq (long al_airline_key, string as_unit_of_measure);
RETURN TRUE

end function

public function boolean of_has_contents (long arg_irow, long arg_icolumn);

Return false

end function

public function long of_add_content (long irow, long icolumn, long ldetail, long lsort, long lheader_flag);
return 1
end function

public function boolean of_is_content_sheet_header (long al_layout_detail_key, string as_cpackinglist);		
Return false

end function

public function long of_get_content_sheet_contents (long arg_llayoutdetailkey, long arg_irow, long arg_icolumn, string arg_cunit, long arg_start_pos, ref s_distrib_items astr_items[], boolean ab_header_flag);
Return 0

end function

public function integer of_align_objects (string as_match, long al_align_mode, boolean ab_backlog);
Return 1
end function

public function long of_get_explosion_content (long arg_llayoutdetailkey, long arg_irow, long arg_icolumn, string arg_cunit, long arg_start_pos, ref s_distrib_items astr_items[]);
Return 0

end function

public function boolean of_is_explosion_enabled (long al_index_key, string as_unit, date ad_departure);
Return false
end function

public function boolean of_exists_content_sheet_header (long al_column, long al_row);		
Return true

end function

public function long of_get_fixed_content (long arg_llayoutdetailkey, long arg_icontent, long arg_irow, long arg_icolumn, long arg_ltype, string arg_cunit, long arg_start_pos, ref s_distrib_items astr_items[], boolean ab_do_not_explode);
Return 0

end function

protected function long of_draw_content_drawer (long arg_llayoutdetailkey, long arg_icontent, long arg_irow, long arg_icolumn, long arg_ltype, string arg_sunit);
return 0
end function

public function long of_draw_content_backlog_tray (long arg_l_counter, long arg_i_row, long arg_i_column, string arg_s_text, long arg_l_type, decimal arg_dec_qty);
return 1
end function

public function long of_print_prepare (string arg_s_printer, string arg_s_airline, long arg_l_flightnumber, string arg_s_suffix, string arg_s_header, string arg_s_from, string arg_s_to, string arg_s_actype, string arg_s_stowage, long arg_l_page, long arg_l_belly, date arg_d_departure, string arg_s_time, string arg_s_class, string arg_s_container, string arg_s_owner, string arg_s_version, string arg_s_area, string arg_s_workstation, string arg_s_loadinglist, long arg_l_leg);
return 0

end function

public function integer of_fill_component_list (ref uo_distribution rauodistribution, ref s_component rastr_component[], string arg_s_stowage, string arg_s_pl, long arg_l_lbelly);
Return 1

end function

public function integer of_init_slot (ref uo_cart_distribution rauocartdistribution, long al_row, long al_column, long al_maxlength);

Return 1
end function

public function integer of_distr_content_4_contentsheet (ref datastore rads_distribution_contents, ref uo_cart_distribution rauocartdistribution, long al_row, long al_column, long al_content_master_row_id);
Return 1

end function

public function long of_draw_watermark_downline (long arg_irow, long arg_icolumn, integer arg_ltype, long arg_lcolour);
return 0

end function

public function long of_remove_distribution (long irow, long icolumn);
return 0
end function

public function long of_remove_distribution ();/*
* Objekt : uo_cart_diagram
* Methode: of_remove_distribution (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 06.05.2011
*
* Argument(e):
* none
*
* Beschreibung:		Entfernen der Distribution Parameter an der aktuellen Stelle
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	06.05.2011		Erstellung
*
*
* Return: long
*
*/


return of_remove_distribution(iCurrentRow, iCurrentColumn)
end function

public function long of_remove_content (long irow, long icolumn, boolean ab_remove_distr_parms_4_multi);
return 0
end function

public function integer of_handle_empty_contents (long al_row, long al_column, ref boolean rab_empty, ref boolean rab_entire_container_empty);

Return 1

end function

public function boolean of_set_user (string as_user);


Return true
end function

protected function long of_adjust_xposition (long arg_l_pos, string arg_s_object);
return 0


end function

public function integer of_clean_tr_diagram (ref datastore rads_diagramm);
Return 1
end function

public function long of_draw_watermark (integer ai_type, long al_flight_number, string as_ramp_time, string as_kitchen_time, string as_ops, string as_class, string as_prodrange, long al_airline_key, string as_unit, long al_routing, boolean ab_tr_cart, string as_suffix);		
Return 0

end function

public function integer of_use_doc_gen_settings (n_doc_gen_settings anv_doc_gen_settings);

Return 1
end function

public function boolean of_set_section (string as_section);
Return true
end function

public function integer of_sd_fill_component_list (ref uo_distribution rauodistribution, long al_row_id, string arg_s_stowage, string arg_s_pl, long arg_l_lbelly);
return 1

end function

public function long of_sd_create_component_list (long al_row_id);
Return 0

end function

public function integer of_sd_save_distr_contents (s_distrib_items astr_distrib_items[], long al_rowid, long al_sd_cart_key, long al_page, long al_sd_drawer_key);
Return 1

end function

public function long of_sd_draw_distributed_components (uo_distribution arg_uo_distribution, string arg_s_stowage, string arg_s_pl, long arg_l_lbelly, string arg_s_carttype, string arg_unit, date arg_departure, boolean arg_bexplode_parent, ref uo_content_sheet rauo_content_sheet, boolean ab_content_sheet, long al_content_master_row_id, datastore rads_distribution_contents);
Return 1

end function

public function integer of_sd_init (string as_unit, long al_index_key, long al_detail_key, long al_airline_key, date adt_departure);
Return 1


end function

public function long of_sd_init ();
return 1
end function

public function integer of_sd_get_distr_content (long al_column, long al_row, ref s_distrib_items astr_item[]);
Return 1

end function

protected function integer of_sd_handle_empty_contents (long al_row, long al_column, ref boolean rab_empty, ref boolean rab_entire_container_empty, long al_sd_rowid, long al_sd_cart_key);

Return 1
end function

public function long of_sd_add_backlog (long arg_l_row, long arg_l_column, string arg_s_object, decimal arg_dec_items, string arg_s_unit, string arg_s_text, long arg_l_counter, long arg_l_type, string arg_s_packinglist, long arg_l_row_id);
Return 1


end function

public function integer of_sd_fill_backlog_data (long arg_l_row_id);
Return 1


end function

public function long of_sd_add_content_backlog_tray (long arg_l_counter, long arg_i_row, long arg_i_column, string arg_s_text, long arg_l_type, decimal arg_dec_qty, long arg_l_row_id);Return 1

end function

public function long of_sd_add_content_backlog_drawer (long arg_l_counter, long arg_i_row, long arg_i_column, datastore arg_ds_data, long arg_l_type, string arg_s_header, long arg_l_rowid);
return 1

end function

public function long of_sd_distribute_components (uo_distribution arg_uo_distribution, string arg_s_galley, string arg_s_stowage_only, string arg_s_stowage, string arg_s_pl, long arg_l_lbelly, string arg_s_carttype, string arg_unit, date arg_departure, boolean arg_bexplode_parent, ref uo_content_sheet rauo_content_sheet, boolean ab_content_sheet, long al_content_master_row_id, datastore rads_distribution_contents, long al_sd_rowid, long al_sd_cart_key, long al_page, string as_loadinglist);
Return 1

end function

public function long of_sd_add_error (long al_row_id, string as_galley, string as_stowage, string as_cart, string as_loadinglist, string as_component, string as_text, long al_distribution, string as_parameter, string as_definition, string as_unit, string as_information);
Return 1

end function

public function integer of_sd_set_filter_rowid (long al_content_master_row_id);
Return 1

end function

public function integer of_sd_add_content_sheet_header (string arg_s_carttype, string arg_unit, uo_content_sheet rauo_content_sheet, long al_content_master_row_id, datastore rads_distribution_contents);
Return 1

end function

protected function integer of_sd_distribute_components_alloc (long al_min_fit_factor_setting, date arg_departure, string arg_unit, long al_content_master_row_id, long al_sd_cart_key, string arg_s_galley, string arg_s_stowage_only, string arg_s_pl, string as_loadinglist, ref boolean ab_entire_container_empty);
Return 1
end function

public function integer of_sd_distribute_components_tray (long al_column, long al_row, string arg_unit, ref datastore rads_distribution_contents, long al_content_master_row_id, long al_sd_cart_key, long al_page, ref boolean rab_watermark_downline, ref boolean rab_suppress_watermark_downline);
Return 1
end function

public function integer of_sd_distribute_components_multi (long al_column, long al_row, string arg_unit, ref datastore rads_distribution_contents, long al_content_master_row_id, long al_sd_cart_key, long al_page, ref boolean rab_watermark_downline, ref boolean rab_suppress_watermark_downline);
Return 1
end function

public function integer of_sd_distribute_components_disabled (string arg_s_carttype, string arg_s_pl, string arg_s_stowage);
Return 1

end function

protected function integer of_sd_distribute_components_empty (ref boolean rab_entire_container_empty, long al_maxcolumns, long al_maxrows, ref uo_cart_distribution rauo_cart_distribution, long al_sd_rowid, long al_sd_cart_key, boolean ab_no_components, string arg_s_pl, date arg_departure, string arg_s_stowage);
Return 1

end function

public function string of_get_ramp_box (string as_box_from, string as_box_to, long al_box_mode);						
Return ""

end function

public function integer of_sd_remove_empty_drawers (long al_row_id);
Return 1
end function

public function integer of_sd_draw_comp_tray (long al_column, long al_row, ref datastore rads_distribution_contents, long al_content_master_row_id, string arg_unit);
Return 1

end function

public function integer of_init_cd_tripticket (string as_unit, long al_airline_key, ref uo_tripticket rauo_tripticket);	
Return 1

end function

public function integer of_count_cart_diagram_pages (string as_unit, long al_airline_key, ref datastore rads_unassigned, ref datastore rads_eq, ref datastore rads_cartdiagramsheet, ref uo_tripticket rauo_tripticket);	
Return 1

end function

public function integer of_create_or_load_sec_distr (long al_result_key, long al_transaction, ref uo_distribution rauo_distribution, long al_airline_key, string as_unit, ref datastore rads_unassigned, ref datastore rads_eq, boolean ab_contentsheet, ref datastore rads_cartdiagramsheet, ref uo_tripticket rauo_tripticket, ref uo_content_sheet rauo_contentsheet);
Return 1

end function

public function integer of_create_acrobat (ref datastore dsacrobat, string as_file_name);
return 0
end function

public function integer of_cart_diagram_merge (ref uo_documents rauo_product, string as_pdffiles[], boolean ab_printdirectly, boolean ab_use_printer_allocation, string as_printer_cart_diagram);
Return 1
end function

public function integer of_cart_diagram_content_sheet (boolean ab_contentsheet, long al_rowid, ref uo_content_sheet rauo_contentsheet);
Return 1

end function

public function integer of_create_cd_backlog_page (ref long ral_backlogpages, long al_row, long al_cartpages, ref long ral_filecounter, ref string ras_pdffiles[], ref uo_documents rauo_product, string as_rampbox, string as_stowage, string as_packinglist, string as_pl_description, string as_loadinglist, string as_class, string as_workstation, string as_version, string as_container, integer ai_flightnumber, string as_suffix, string as_header, string as_from, string as_to, string as_actype, long al_belly, string as_time, string as_owner, string as_area, string as_class_string, long al_backlogpages, string as_current_printer_1);
Return 1
end function

public function integer of_create_cart_diagram_page (long al_row, long al_rowid, long al_airline_key, string as_unit, ref long ral_cartpages, boolean ab_contentsheet, string as_current_printer_1, ref uo_documents rauo_product, long al_flightnumber, string as_suffix, string as_from, string as_to, string as_actype, string as_time, string as_owner, string as_version, long al_leg_nr, long al_number_of_pages, string as_fbox_from, string as_fbox_to, long al_watermark, string as_ramp_time, string as_kitchen_time, string as_ops, long al_routing_id, ref long ral_filecounter, ref string ras_pdffiles[], ref long ral_backlogpages, ref uo_content_sheet rauo_contentsheet, ref uo_distribution rauo_distribution);
Return 1

end function

public function integer of_tr_remove_entries (ref uo_distribution rauo_distribution, string as_unit, datastore ads_exclusions, ref datastore rads_cartdiagramsheet);
Return 1

end function

public function integer of_count_tr_cart_pages (string as_unit, ref uo_tr_cart_allocation rauo_tr_alloc, long al_airline_key, long al_routing_id, integer ai_fill_type, ref datastore rads_cartdiagramsheet);
Return 1
end function

public function integer of_create_tr_cartdigram_cs (boolean ab_content_sheet, long al_result_key, ref uo_distribution rauo_distribution, ref uo_content_sheet rauo_contentsheet, ref datastore rads_loading);
Return 1

end function

public function integer of_create_unassigned_cart_report (boolean ab_unassignedcarts, ref datastore rads_unassigned, ref uo_documents rauo_product, ref long ral_filecounter, ref string ras_pdffiles[]);
Return 1

end function

public function boolean of_is_tr_header_in_footer ();
return False

end function

public function integer of_get_level_of_service (ref string ras_los[]);
Return 0
end function

public function boolean of_is_content_spec_enabled (long arg_l_index, string arg_s_unit, date arg_d_departure);
return FALSE

end function

public function integer of_distr_content_4_cs (ref datastore rads_distribution_contents, long al_row, long al_column, long al_content_master_row_id);
Return 1

end function

public function string of_overflow_message (string as_packinglist);
Return ""
end function

public function long of_adjust_font (string arg_s_object[], long arg_l_size, boolean arg_b_bold, boolean arg_b_italic);
return 0
end function

public function long of_adjust_text_size (string arg_s_object[], long arg_l_height_factor);
return 0
end function

public function integer of_calc_font_size (string as_text, ref long al_height, ref long al_width, string as_font_name, boolean ab_bold, boolean ab_italic, boolean ab_underline, boolean ab_wrap);
	return -1

end function

public function integer of_delete_secondary_distribution (long al_result_key, long al_transaction);
Return 1
end function

public function long of_is_cartdiagram_enabled (long arg_l_index, string arg_s_client, string arg_s_unit, ref boolean rab_no_entry);
return 0

end function

public function long of_print (string as_printer, boolean ab_preview);
return 0
end function

public function long of_get_fixed_content_drawer (long arg_llayoutdetailkey, long arg_icontent, long arg_irow, long arg_icolumn, long arg_ltype, string arg_cunit, long arg_start_pos, ref s_distrib_items astr_items[], boolean ab_do_not_explode);
Return 0

end function

public function boolean of_check_explode (long al_index_key, string as_unit);
Return false

end function

public function boolean of_check_workstation_exclude (long al_workstation_key, long al_airline_key);
Return false

end function

public function long of_draw_tr_content_drawer (long arg_index_key, long arg_detailkey, long arg_irow, long arg_icolumn, long arg_ltype, boolean ab_explode, string as_unit, string as_distribution_items[], string as_suppressed_items[]);
return 0


end function

public function long of_adjust_text_size_small_big (string arg_s_object[], long arg_l_height_factor);
return 0
end function

public function integer of_sd_draw_comp_multi (long al_row, long al_column, string arg_unit, long al_master_row_id);
Return 1

end function

public function long of_get_fixed_content_tray (long arg_llayoutdetailkey, long arg_icontent, long arg_irow, long arg_icolumn, long arg_ltype, string arg_cunit, long arg_start_pos, ref s_distrib_items astr_items[], boolean ab_do_not_explode);
Return 0

end function

public function boolean of_check_center_setting ();
Return FALSE

end function

public function string of_get_item_description (s_component arg_str_component, boolean ab_fixed);

Return " "

end function

public function integer of_vertical_center_text_within_drawer (string as_object[], long al_column, long al_row);
Return 1
end function

public function integer of_apply_tr_workstation_exclusions (string as_unit, ref uo_tr_cart_allocation rauo_tr_alloc, long al_airline_key, long al_routing_id, integer ai_fill_type, ref datastore rads_cartdiagramsheet);
Return 1 //ll_TRCartPagesMax
end function

public function integer of_sd_draw_comp_drawer (long al_column, long al_row, ref datastore rads_distribution_contents, long al_content_master_row_id, string arg_unit, long al_master_content_setting);
Return 1

end function

public function boolean of_is_backlog_enabled_by_setup ();
return False

end function

public function long of_sd_create_tr_component_list (long al_row_id[], ref uo_distribution rauo_distribution, ref datastore rads_trcartdiagram);
Return 0

end function

public function integer of_sd_init_flight (long al_result_key, long al_transaction, boolean ab_require_exact_match, string as_csc, long al_airline_key);
Return 1
end function

public function boolean of_exists_tr_cart_per_unit (string as_unit);
Return true
end function

public function long of_add_content_explosion (long irow, long icolumn, long ldetail, long lsort, boolean ab_header_flag);
return 1
end function

public function integer of_create_tr_backlog_page (ref long ral_backlogpages, long al_row, long al_cartpages, ref long ral_filecounter, ref string ras_pdffiles[], string as_rampbox, string as_stowage, string as_packinglist, string as_pl_description, string as_loadinglist, string as_class, string as_workstation, string as_version, string as_container, integer ai_flightnumber, string as_suffix, string as_header, string as_from, string as_to, string as_actype, long al_belly, string as_time, string as_owner, string as_area, string as_class_string, long al_backlogpages, string as_current_printer_1, string as_unit, string as_airline);
Return 1
end function

public function integer of_create_unassigned_tr_cart_report (ref datastore rads_unassigned, ref long ral_filecounter, ref string ras_pdffiles[], long al_flight_number, string as_airline);
Return 1
end function

public function long of_draw_additional_text (string as_text_1, string as_label_text_2);
return 1
end function

public function long of_draw_backlog_on_main ();
return 1
end function

public function integer of_draw_healthmark (string as_unit, boolean ab_backlog);
return 1
end function

public function integer of_get_label_group (string as_unit);
return 1
end function

public function integer of_set_pl (string as_pl, string as_pl_desc);
return 1
end function

public function long of_draw_tr_add_text_indicator (long arg_irow, long arg_icolumn, string arg_text);
return 1
end function

public function long of_draw_tr_freetext (string as_text);
return 1
end function

public function long of_draw_watermark_belly (long al_belly);
return 1
end function

public function long of_get_tr_cart_key (string as_unit, long al_index_key, date adt_ref_date, ref long ral_number_of_rungs, ref long ral_number_of_columns, ref long ral_number_of_pages);
return 1
end function

public function long of_sd_add_backlog (long arg_l_row, long arg_l_column, string arg_s_object, decimal arg_dec_items, string arg_s_unit, string arg_s_text, long arg_l_counter, long arg_l_type, string arg_s_packinglist, long arg_l_row_id, string arg_s_stowage);
return 1
end function

public function long of_sd_find_backlog (long arg_l_row, long arg_l_column, string arg_s_object, decimal arg_dec_items, string arg_s_unit, string arg_s_text, long arg_l_counter, long arg_l_type, string arg_s_packinglist, long arg_l_row_id);
return 1
end function

public function string of_get_additional_label_text (long al_packinglist_index_key, string as_unit, date adt_departure);
return " "
end function

public function boolean of_is_add_on_text_enabled ();
return true
end function

public function boolean of_is_healthmark_enabled (string as_unit);
return true
end function

on uo_cart_diagram.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cart_diagram.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;/*************************************************************
* Objekt : uo_cart_diagram
* Methode: constructor (Event)
* Autor  : Ulrich Paudler [UP]
* Datum  : 15.04.2009
*
* Argument(e):	none
* Return: long
*
*
*
*
*
*************************************************************
* Modifikationen:
* Datum    Version        Autor              Kommentar
*------------------------------------------------------------
* 15.04.2009 1.1		Ulrich Paudler		Logfile in Temppath legen
* 03.09.2009 1.2		Ulrich Paudler		Backlog hinzugef$$HEX1$$fc00$$ENDHEX$$gt
* 30.09.2009 1.3		Ulrich Paudler		Cache Objekte leeren
* 05.10.2009 1.4		Ulrich Paudler		Groessenpruefung hinzu
*************************************************************/
String	ls_Temp
Integer	li_Ret

// Initialisieren f$$HEX1$$fc00$$ENDHEX$$r of_generate_filename()
Randomize(0)

this.is_Logfile = this.sTemppath + "cart_diagram.log"

dsAirlineEq = create uo_cart_datastore 
dsAirlineEq.of_set_log_file(this.is_Logfile)
dsAirlineEq.Dataobject = "dw_uo_airline_eq"
dsAirlineEq.Settransobject(sqlca)

dsLayout = create uo_cart_datastore 
dsLayout.Dataobject = "dw_uo_packinglist_layout"
dsLayout.of_set_log_file(this.is_Logfile)
dsLayout.Settransobject(sqlca)

dsLayoutDetail = create uo_cart_datastore 
dsLayoutDetail.of_set_log_file(this.is_Logfile)
dsLayoutDetail.Dataobject = "dw_uo_packinglist_layout_detail"
dsLayoutDetail.Settransobject(sqlca)
dsLayoutDetail.iDebug = 0

dsLayoutContents = create uo_cart_datastore 
dsLayoutContents.of_set_log_file(this.is_Logfile)
dsLayoutContents.Dataobject = "dw_uo_packinglist_layout_contents"
dsLayoutContents.Settransobject(sqlca)

dsLayoutDimension = create uo_cart_datastore 
dsLayoutDimension.of_set_log_file(this.is_Logfile)
dsLayoutDimension.Dataobject = "dw_uo_packinglist_layout_dimensions"
dsLayoutDimension.Settransobject(sqlca)
dsLayoutDimension.iDebug = 0

dsLayoutAddObjects = create uo_cart_datastore 
dsLayoutAddObjects.of_set_log_file(this.is_Logfile)
dsLayoutAddObjects.Dataobject = "dw_uo_packinglist_layout_add_objects"
dsLayoutAddObjects.Settransobject(sqlca)

dsPL = create uo_cart_datastore 
dsPL.of_set_log_file(this.is_Logfile)
dsPL.Dataobject = "dw_uo_packinglist"
dsPL.Settransobject(sqlca)

dsPLContents = create uo_cart_datastore 
dsPLContents.of_set_log_file(this.is_Logfile)
dsPLContents.Dataobject = "dw_uo_packinglist_detail"
dsPLContents.Settransobject(sqlca)
dsPLContents.iDebug = 0

dsObjects = create uo_cart_datastore 
dsObjects.of_set_log_file(this.is_Logfile)
dsObjects.Dataobject = "dw_uo_registered_objects"
dsObjects.Settransobject(sqlca)

// 03.09.2009 Ulrich Paudler [UP]
dsBacklog = create uo_cart_datastore 
dsBacklog.of_set_log_file(this.is_Logfile)
dsBacklog.Dataobject = "dw_uo_layout_backlog" 
dsBacklog.Settransobject(sqlca)

// 30.09.2009 Ulrich Paudler [UP]
ilCachedAirlineKey = 0
isCachedUnit = ""

// 05.10.2009 Ulrich Paudler [UP]
dsPLSize = create uo_cart_datastore 
dsPLSize.of_set_log_file(this.is_Logfile)
dsPLSize.Dataobject = "dw_uo_cart_packinglist_size" 
dsPLSize.Settransobject(sqlca)

ids_TR_Exclusions = CREATE DataStore
ids_TR_Exclusions.DataObject = "dw_ext_3_cols"

ls_Temp = f_mandant_profilestring(sqlca, s_app.smandant, "CartDiagram", "ExpandTRCart", "0")
If ls_Temp = "1" Then
	ib_Expand_TR_Cart = TRUE
End If


// ---------------------------------------------------
// CR NAM 12008 Drei verschiedene overfloe messages
// ---------------------------------------------------
// Use Content Spec to display all Items
// See Overflow for more details
// See Content Spec and Overflow Report
is_Overflow_MSG_1	= uf.translate("weitere auf Inhaltsansicht") 
is_Overflow_MSG_2 = uf.translate("$$HEX1$$dc00$$ENDHEX$$berlaufprotokoll mit weiteren Daten")
is_Overflow_MSG_3 = uf.translate("siehe $$HEX1$$dc00$$ENDHEX$$berlaufprotokoll/Inhaltsansicht") 
ls_Temp = f_mandant_profilestring(sqlca, s_app.smandant, "CartDiagram", "DisableContentSpecMSG", "0")
If ls_Temp = "1" Then
	ib_Disable_Content_Spec_MSG = TRUE
End If


// ---------------------------------------
// Secondary Distribution DataStores
// ---------------------------------------
ids_SD_Master							= CREATE uo_CBASE_DataStore
ids_SD_Master.DataObject			= "dw_uo_sec_dis_master"
ids_SD_Master.SetTransObject(SQLCA)
ids_SD_Components						= CREATE uo_CBASE_DataStore
ids_SD_Components.DataObject		= "dw_uo_sec_dis_comp"
ids_SD_Components.SetTransObject(SQLCA)
ids_SD_Cart								= CREATE uo_CBASE_DataStore	
ids_SD_Cart.DataObject				= "dw_uo_sec_dis_cart"
ids_SD_Cart.SetTransObject(SQLCA)
ids_SD_Cart_Drawer					= CREATE uo_CBASE_DataStore
ids_SD_Cart_Drawer.DataObject		= "dw_uo_sec_dis_drawer"
ids_SD_Cart_Drawer.SetTransObject(SQLCA)
ids_SD_Drawer_Content				= CREATE uo_CBASE_DataStore
ids_SD_Drawer_Content.DataObject = "dw_uo_sec_dis_content"
ids_SD_Drawer_Content.SetTransObject(SQLCA)
ids_SD_Message							= CREATE uo_CBASE_DataStore
ids_SD_Message.DataObject			= "dw_uo_sec_dis_message"
ids_SD_Message.SetTransObject(SQLCA)

If isnull( s_app.sMandant) or  s_app.sMandant = "" then 
   s_app.sMandant = "002"
End If

end event

event destructor;/*************************************************************
* Objekt : uo_cart_diagram
* Methode: destructor (Event)
* Autor  : Ulrich Paudler [UP]
* Datum  : 03.09.2009
* Argument(e):
* none
*
* Return: long
*
*
*
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.10.2009 1.1		Ulrich Paudler	Groessenpruefung hinzu
*
*************************************************************/
Long	i

DESTROY dsAirlineEq
DESTROY dsLayout
DESTROY dsLayoutDetail
DESTROY dsLayoutContents
DESTROY dsLayoutDimension
DESTROY dsLayoutAddObjects
DESTROY dsPL
DESTROY dsPLContents
DESTROY dsObjects
DESTROY	ids_TR_Exclusions
For i = 1 to Upperbound(sRegisteredFiles)
	Filedelete(sRegisteredFiles[i])
Next

// 03.09.2009 Ulrich Paudler [UP]
DESTROY dsBacklog

// 05.10.2009 Ulrich Paudler [UP]
DESTROY dsPLSize

// ---------------------------------------
// Secondary Distribution DataStores
// ---------------------------------------
DESTROY	ids_SD_Master			
DESTROY	ids_SD_Components		
DESTROY	ids_SD_Cart				
DESTROY	ids_SD_Cart_Drawer	
DESTROY	ids_SD_Drawer_Content	
DESTROY	ids_SD_Message


// 05.11.2009 Ulrich Paudler [UP]
if isvalid(iuo_CartDistribution) Then destroy iuo_CartDistribution

//if isvalid(uoDistribution) Then destroy uoDistribution

// Document Engine st$$HEX1$$fc00$$ENDHEX$$rzt bei GarbageCollect() ab
If getApplication().AppName = "cbase" Then GarbageCollect()

of_chc_trace(10,"destroy")
end event

