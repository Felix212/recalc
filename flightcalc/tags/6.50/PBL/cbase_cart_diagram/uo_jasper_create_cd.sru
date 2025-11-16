HA$PBExportHeader$uo_jasper_create_cd.sru
$PBExportComments$From Cart Diagram
forward
global type uo_jasper_create_cd from nonvisualobject
end type
end forward

global type uo_jasper_create_cd from nonvisualobject
end type
global uo_jasper_create_cd uo_jasper_create_cd

type prototypes


FUNCTION long uuidCreate(ref s_uuid astr_uuid) LIBRARY "Rpcrt4.dll"    ALIAS FOR "UuidCreate"

end prototypes

type variables

String		is_crlf = "~r~n"
String		is_jasperfile = ""

String		is_jasper_sub_reports[]
String		is_jasper_sub_picture_reports[]
String		is_jasper_sub_picture_xml[]

Long			il_band_height

PUBLIC	Boolean		ib_Componentlist = TRUE

Date			idt_reference_date

Long			il_jasper_key_mainreport

Boolean		ib_Replace_Font_With_Arial = TRUE

Boolean		ib_Replace_Image_Path = TRUE

Boolean		ib_Replace_Subreport_Path = TRUE

Boolean		ib_Include_Drawer_Content = FALSE

Boolean		ib_Include_ALL_Content = FALSE //TRUE

// Scaling Factor PB Pixel to Jasper Pixel
Double		id_Pixel_Factor =  0.8 // 80% or 75%  4/5 3/4


PUBLIC	Long			il_PL_Index_Key
PUBLIC	Long			il_PL_Detail_Key
PUBLIC	Long			il_Airline_Key

PUBLIC	Boolean		ib_Overflow_on_Main = FALSE
PUBLIC	Boolean		ib_Moved_to_the_Left = FALSE

PUBLIC	Boolean		ib_Header_Footer_Switch = FALSE
PUBLIC	Boolean		ib_Sub_Barcode = TRUE

Long		il_Detail_Height
Long		il_Detail_Width


Boolean		ib_Additional_Shrink = FALSE


end variables

forward prototypes
private function integer of_write (string as_text)
public function string of_create_query ()
public function string of_hex (unsignedlong aul_decimal)
public function string of_uuid ()
public function string of_create_distributed_components ()
public function integer of_export_datawindow (datawindow adw_source)
public function string of_create_line (datawindow adw_ref, string as_object)
public function string of_create_rectangle (datawindow adw_ref, string as_object)
public function string of_create_static_text (datawindow adw_ref, string as_object)
public function string of_create_bitmap (datawindow adw_ref, string as_object)
public function string of_create_column (datawindow adw_ref, string as_object)
public function string of_create_round_rect (datawindow adw_ref, string as_object)
public function string of_zzz_create_barcode (long al_row)
public function string of_create_bitmap (datastore adw_ref, string as_object)
public function string of_create_line (datastore adw_ref, string as_object)
public function string of_create_rectangle (datastore adw_ref, string as_object)
public function string of_create_round_rect (datastore adw_ref, string as_object)
public function string of_create_static_text (datastore adw_ref, string as_object)
public function string of_create_query_empty ()
public function string of_create_compute (datastore adw_ref, string as_object)
public function string of_create_compute (datawindow adw_ref, string as_object)
public function string of_create_sub_componentlist (string as_filename)
public function string of_create_ellipse (datastore adw_ref, string as_object)
public function string of_convert_rgb (long al_rgb)
public function string of_long2hex (long al_number, integer ai_digit)
public function integer of_convert_pixels (long al_pixels, integer ai_roundmode)
public function integer of_convert_pixels (long al_pixels)
public function string of_create_sub_components (string as_filename)
public function string of_object_key (string as_object)
public function string of_create_static_text (datawindow adw_ref, string as_object, boolean ab_empty)
public function integer of_export_painter_dw (datawindow adw_source, string as_pl)
public function integer of_save_to_db (string as_jaspername, string as_text, integer ai_is_mainreport)
public function string of_create_bitmap_subreport (datawindow adw_ref, string as_object)
public function string of_create_query_backlog_count ()
public function string of_create_query_original ()
public function string of_create_query_backog_count_original ()
public function integer of_shrink_all (ref datawindow adw_source)
end prototypes

private function integer of_write (string as_text);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_write (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// string as_text
//
// Beschreibung:		Write text to file
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: integer
//
// --------------------------------------------------------------------------------


Integer  li_file
Long		ll_Bytes
Integer	li_Succ


li_file  = FileOpen(is_jasperfile, LineMode!, Write!, LockWrite!, Replace!, EncodingUTF8!)

//li_file  = FileOpen(is_jasperfile, LineMode!, Write!, LockWrite!, Replace!)
ll_Bytes = FileWriteEX(li_file, as_text)
li_Succ  = FileClose(li_file)

return 0


end function

public function string of_create_query ();
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_query (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// none
//
// Beschreibung:		Select cen_out join cen_out_md_lo join sd2xxxx
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
// 1.1 			O.Hoefer	26.04.2018		Neu: Select aus Package
//
//
// Return: string
//
// --------------------------------------------------------------------------------

String	ls_return


ls_Return += '   <queryString>' + is_crlf 
ls_Return += '      <![CDATA[Select     cairline,' + is_crlf 
ls_Return += '                    ddeparture,' + is_crlf 
ls_Return += '                    nflight_number,' + is_crlf 
ls_Return += '                    cdeparture_time,' + is_crlf 
ls_Return += '                    cramp_time,' + is_crlf 
ls_Return += '                    cactype,' + is_crlf 
ls_Return += '                    cflight,' + is_crlf 
ls_Return += '                  ' + is_crlf 
ls_Return += '                    cstposition,' + is_crlf 
ls_Return += '                    nresult_key,' + is_crlf 
ls_Return += '                    ntransaction,' + is_crlf 
ls_Return += '                    nrecord_count,' + is_crlf 
ls_Return += '                    cstowage,' + is_crlf 
ls_Return += '                    cplace,' + is_crlf 
ls_Return += '                    nsort_stow,' + is_crlf 
ls_Return += '                    npage,' + is_crlf 
ls_Return += '                    nxpos,' + is_crlf 
ls_Return += '                    nypos,' + is_crlf 
ls_Return += '                    cgalley,' + is_crlf 
ls_Return += '                    nsort_gal,' + is_crlf 
ls_Return += '                    nequipment_width,' + is_crlf 
ls_Return += '                    nequipment_height,' + is_crlf 
ls_Return += '                    nloadinglist_index_key_lo,' + is_crlf 
ls_Return += '                    cpackinglist,' + is_crlf 
ls_Return += '                    cloadinglist,' + is_crlf 
ls_Return += '                    ctext_pckl,' + is_crlf 
ls_Return += '                    cunit,' + is_crlf 
ls_Return += '                    nloadinglist_key,' + is_crlf 
ls_Return += '                    dvalid_from,' + is_crlf 
ls_Return += '                    dvalid_to,' + is_crlf 
ls_Return += '                    cfrequency,' + is_crlf 
ls_Return += '                    ctime_from,' + is_crlf 
ls_Return += '                    ctime_to,' + is_crlf 
ls_Return += '                    cclass,' + is_crlf 
ls_Return += '                    cadd_on_text,' + is_crlf 
ls_Return += '                    cactioncode,' + is_crlf 
ls_Return += '                    nbelly_container,' + is_crlf 
ls_Return += '                    nquantity,' + is_crlf 
ls_Return += '                    nlabel_quantity,' + is_crlf 
ls_Return += '                    nlabel_type_key,' + is_crlf 
ls_Return += '                    cmeal_control_code,' + is_crlf 
ls_Return += '                    nstowage_key,' + is_crlf 
ls_Return += '                    cfontname,' + is_crlf 
ls_Return += '                    nfontbold,' + is_crlf 
ls_Return += '                    nfontitalic,' + is_crlf 
ls_Return += '                    nfontcolor,' + is_crlf 
ls_Return += '                    nobjectborder,' + is_crlf 
ls_Return += '                    nobjectcolor,' + is_crlf 
ls_Return += '                    nobjectbackgroundcolor,' + is_crlf 
ls_Return += '                    nfontsize,' + is_crlf 
ls_Return += '                    nobjectlinewidth,' + is_crlf 
ls_Return += '                    npackinglist_key,' + is_crlf 
ls_Return += '                    ctext_short,' + is_crlf 
ls_Return += '                    ngalley_key,' + is_crlf 
ls_Return += '                    ctext_stow,' + is_crlf 
ls_Return += '                    nequipment_resize,' + is_crlf 
ls_Return += '                    nweight_stow,' + is_crlf 
ls_Return += '                    nfor_to_code,' + is_crlf 
ls_Return += '                    ntlc_key,' + is_crlf 
ls_Return += '                    ctlc,' + is_crlf 
ls_Return += '                    npackinglist_index_key,' + is_crlf 
ls_Return += '                    nloadinglist_detail_key,' + is_crlf 
ls_Return += '                    nloadinglist_index_key_loi,' + is_crlf 
ls_Return += '                    dtimestamp_modification,' + is_crlf 
ls_Return += '                    npackinglist_detail_key,' + is_crlf 
ls_Return += '                    ngalley_group,' + is_crlf 
ls_Return += '                    ncatering_leg,' + is_crlf 
ls_Return += '                    nranking,' + is_crlf 
ls_Return += '                    nlimit,' + is_crlf 
ls_Return += '                    nranking_spml,' + is_crlf 
ls_Return += '                    nlimit_spml,' + is_crlf 
ls_Return += '                    nreckoning,' + is_crlf 
ls_Return += '                    nweight_pckl,' + is_crlf 
ls_Return += '                    nweight_gal,' + is_crlf 
ls_Return += '                    cclass1,' + is_crlf 
ls_Return += '                    cclass2,' + is_crlf 
ls_Return += '                    cclass3,' + is_crlf 
ls_Return += '                    npl_kind_key,' + is_crlf 
ls_Return += '                    nseparator,' + is_crlf 
ls_Return += '                    ccustomer_pl,' + is_crlf 
ls_Return += '                    ccustomer_text,' + is_crlf 
ls_Return += '                    naccount_key,' + is_crlf 
ls_Return += '                    caccount,' + is_crlf 
ls_Return += '                    ntransporter_cart,' + is_crlf 
ls_Return += '                    csales_rel,' + is_crlf 
ls_Return += '                    cdef_storage_location,' + is_crlf 
ls_Return += '                    cgoods_recipient,' + is_crlf 
ls_Return += '                    cclass4,' + is_crlf 
ls_Return += '                    cclass5,' + is_crlf 
ls_Return += '                    cclass6,' + is_crlf 
ls_Return += '                    ncom_actioncode,' + is_crlf 
ls_Return += '                    ncom_fontheight,' + is_crlf 
ls_Return += '                    ncom_usefontsize,' + is_crlf 
ls_Return += '                    ncom_rowprinted,' + is_crlf 
ls_Return += '                    ccom_classname,' + is_crlf 
ls_Return += '                    ccom_zustautext,' + is_crlf 
ls_Return += '                    ncom_exclude,' + is_crlf 
ls_Return += '                    ccom_qaq_actioncode,' + is_crlf 
ls_Return += '                    ccom_sicodes,' + is_crlf 
ls_Return += '                    ncom_handling_key,' + is_crlf 
ls_Return += '                    ncom_calcweight,' + is_crlf 
ls_Return += '                    ncom_nlabel_type,' + is_crlf 
ls_Return += '                    ncom_nprint,' + is_crlf 
ls_Return += '                    ncom_labelprinting,' + is_crlf 
ls_Return += '                    ncom_stationinstruction,' + is_crlf 
ls_Return += '                    ncom_nworkstationkey,' + is_crlf 
ls_Return += '                    ccom_cworkstation,' + is_crlf 
ls_Return += '                    ncom_nareakey,' + is_crlf 
ls_Return += '                    ccom_carea,' + is_crlf 
ls_Return += '                    ccom_carea_code,' + is_crlf 
ls_Return += '                    ncom_npltype,' + is_crlf 
ls_Return += '                    ccom_pldetail_text,' + is_crlf 
ls_Return += '                    ccom_pldetail_label_counter,' + is_crlf 
ls_Return += '                    ncom_ndistribution_detail_key,' + is_crlf 
ls_Return += '                    ncom_ndistribution_key,' + is_crlf 
ls_Return += '                    ncom_nunit_priority,' + is_crlf 
ls_Return += '                    ccom_cdistributed_components,' + is_crlf 
ls_Return += '                    ncom_nclass_number,' + is_crlf 
ls_Return += '                    ncom_nremove,' + is_crlf 
ls_Return += '                    ccom_cworkstation_text,' + is_crlf 
ls_Return += '                    ncom_nduplicated,' + is_crlf 
ls_Return += '                    ccom_cunit_time,' + is_crlf 
ls_Return += '                    ncom_nmodified,' + is_crlf 
ls_Return += '                    ccom_crampbox,' + is_crlf 
ls_Return += '                    ccom_carea_list,' + is_crlf 
ls_Return += '                    ccom_cws_list,' + is_crlf 
ls_Return += '                    ccom_pldetail_explosion,' + is_crlf 
ls_Return += '                    ccom_pl_to_explode,' + is_crlf 
ls_Return += '                    ncom_nrowid,' + is_crlf 
ls_Return += '                    ncom_nramp_box_mode,' + is_crlf 
ls_Return += '                    ccom_crampbox2,' + is_crlf 
ls_Return += '                    ccom_crtn_components,' + is_crlf 
ls_Return += '                    cppsunit,' + is_crlf 
ls_Return += '                    cppscoldstore,' + is_crlf 
ls_Return += '                    nppslotnr,' + is_crlf 
ls_Return += '                    cppscontainer,' + is_crlf 
ls_Return += '                    cppsehb,' + is_crlf 
ls_Return += '                    cppsbox,' + is_crlf 
ls_Return += '                    cppsumstau,' + is_crlf 
ls_Return += '                    cppsab,' + is_crlf 
ls_Return += '                    nflight_label,' + is_crlf 
ls_Return += '                    napproved,' + is_crlf 
ls_Return += '                    ccreated_by,' + is_crlf 
ls_Return += '                    dcreated_date,' + is_crlf 
ls_Return += '                    ctext_ll,' + is_crlf 
ls_Return += '                  ' + is_crlf 
ls_Return += '                    chealthmark1,' + is_crlf 
ls_Return += '                    chealthmark2,' + is_crlf 
ls_Return += '                    chealthmark3,' + is_crlf 
ls_Return += '                    ' + is_crlf 
ls_Return += '                    cmulti_ws_1,' + is_crlf 
ls_Return += '                    ' + is_crlf 
ls_Return += '                    crampbox,' + is_crlf 
ls_Return += '                    ' + is_crlf 
ls_Return += '                    nnumbacklog,' + is_crlf 
ls_Return += '                    ncompoverflow,' + is_crlf 
ls_Return += '                    nprint_overflow_on_main,' + is_crlf 
ls_Return += '                    ' + is_crlf 
ls_Return += '                    bbarcode,' + is_crlf 
ls_Return += '                    blogo,' + is_crlf 
ls_Return += '                    ' + is_crlf 
ls_Return += '                    cwatermark_big,' + is_crlf 
ls_Return += '                    cwatermark_small' + is_crlf 
ls_Return += '' + is_crlf 
ls_Return += '            from table(cbase_cartdiagram.pf_cart_main($P{arg_result_key}, $P{arg_stowage}))]]>' + is_crlf 
ls_Return += '   </queryString>' + is_crlf 
ls_Return += '   <field name="CAIRLINE" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="DDEPARTURE" class="java.sql.Timestamp"/>' + is_crlf 
ls_Return += '   <field name="NFLIGHT_NUMBER" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CDEPARTURE_TIME" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CRAMP_TIME" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CACTYPE" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CFLIGHT" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CSTPOSITION" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NRESULT_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NTRANSACTION" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NRECORD_COUNT" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CSTOWAGE" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CPLACE" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NSORT_STOW" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NPAGE" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NXPOS" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NYPOS" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CGALLEY" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NSORT_GAL" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NEQUIPMENT_WIDTH" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NEQUIPMENT_HEIGHT" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NLOADINGLIST_INDEX_KEY_LO" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CPACKINGLIST" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CLOADINGLIST" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CTEXT_PCKL" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CUNIT" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NLOADINGLIST_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="DVALID_FROM" class="java.sql.Timestamp"/>' + is_crlf 
ls_Return += '   <field name="DVALID_TO" class="java.sql.Timestamp"/>' + is_crlf 
ls_Return += '   <field name="CFREQUENCY" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CTIME_FROM" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CTIME_TO" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCLASS" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CADD_ON_TEXT" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CACTIONCODE" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NBELLY_CONTAINER" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NQUANTITY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NLABEL_QUANTITY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NLABEL_TYPE_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CMEAL_CONTROL_CODE" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NSTOWAGE_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CFONTNAME" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NFONTBOLD" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NFONTITALIC" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NFONTCOLOR" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NOBJECTBORDER" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NOBJECTCOLOR" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NOBJECTBACKGROUNDCOLOR" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NFONTSIZE" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NOBJECTLINEWIDTH" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NPACKINGLIST_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CTEXT_SHORT" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NGALLEY_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CTEXT_STOW" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NEQUIPMENT_RESIZE" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NWEIGHT_STOW" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NFOR_TO_CODE" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NTLC_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CTLC" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NPACKINGLIST_INDEX_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NLOADINGLIST_DETAIL_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NLOADINGLIST_INDEX_KEY_LOI" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="DTIMESTAMP_MODIFICATION" class="java.sql.Timestamp"/>' + is_crlf 
ls_Return += '   <field name="NPACKINGLIST_DETAIL_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NGALLEY_GROUP" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCATERING_LEG" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NRANKING" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NLIMIT" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NRANKING_SPML" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NLIMIT_SPML" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NRECKONING" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NWEIGHT_PCKL" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NWEIGHT_GAL" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CCLASS1" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCLASS2" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCLASS3" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NPL_KIND_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NSEPARATOR" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CCUSTOMER_PL" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCUSTOMER_TEXT" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NACCOUNT_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CACCOUNT" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NTRANSPORTER_CART" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CSALES_REL" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CDEF_STORAGE_LOCATION" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CGOODS_RECIPIENT" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCLASS4" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCLASS5" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCLASS6" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NCOM_ACTIONCODE" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCOM_FONTHEIGHT" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCOM_USEFONTSIZE" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCOM_ROWPRINTED" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CCOM_CLASSNAME" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCOM_ZUSTAUTEXT" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NCOM_EXCLUDE" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CCOM_QAQ_ACTIONCODE" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCOM_SICODES" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NCOM_HANDLING_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCOM_CALCWEIGHT" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCOM_NLABEL_TYPE" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCOM_NPRINT" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCOM_LABELPRINTING" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCOM_STATIONINSTRUCTION" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCOM_NWORKSTATIONKEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CCOM_CWORKSTATION" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NCOM_NAREAKEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CCOM_CAREA" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCOM_CAREA_CODE" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NCOM_NPLTYPE" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CCOM_PLDETAIL_TEXT" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCOM_PLDETAIL_LABEL_COUNTER" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NCOM_NDISTRIBUTION_DETAIL_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCOM_NDISTRIBUTION_KEY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCOM_NUNIT_PRIORITY" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CCOM_CDISTRIBUTED_COMPONENTS" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NCOM_NCLASS_NUMBER" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCOM_NREMOVE" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CCOM_CWORKSTATION_TEXT" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NCOM_NDUPLICATED" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CCOM_CUNIT_TIME" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NCOM_NMODIFIED" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CCOM_CRAMPBOX" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCOM_CAREA_LIST" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCOM_CWS_LIST" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCOM_PLDETAIL_EXPLOSION" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCOM_PL_TO_EXPLODE" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NCOM_NROWID" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCOM_NRAMP_BOX_MODE" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CCOM_CRAMPBOX2" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CCOM_CRTN_COMPONENTS" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CPPSUNIT" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CPPSCOLDSTORE" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NPPSLOTNR" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CPPSCONTAINER" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CPPSEHB" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CPPSBOX" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CPPSUMSTAU" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CPPSAB" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NFLIGHT_LABEL" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NAPPROVED" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="CCREATED_BY" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="DCREATED_DATE" class="java.sql.Timestamp"/>' + is_crlf 
ls_Return += '   <field name="CTEXT_LL" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CHEALTHMARK1" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CHEALTHMARK2" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CHEALTHMARK3" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CMULTI_WS_1" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CRAMPBOX" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="NNUMBACKLOG" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NCOMPOVERFLOW" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="NPRINT_OVERFLOW_ON_MAIN" class="java.lang.Long"/>' + is_crlf 
ls_Return += '   <field name="BBARCODE" class="java.awt.Image"/>' + is_crlf 
ls_Return += '   <field name="BLOGO" class="java.awt.Image"/>' + is_crlf 
ls_Return += '   <field name="CWATERMARK_BIG" class="java.lang.String"/>' + is_crlf 
ls_Return += '   <field name="CWATERMARK_SMALL" class="java.lang.String"/>' + is_crlf 


return ls_return


end function

public function string of_hex (unsignedlong aul_decimal);

String ls_hex
Character lch_hex[0 TO 15] = &
 {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', &
  'c', 'd', 'e', 'f'}

// Check parameters
IF IsNull(aul_decimal) THEN
 SetNull(ls_hex)
 RETURN ls_hex
END IF
 
DO
 ls_hex = lch_hex[Mod(aul_decimal, 16)] + ls_hex
 aul_decimal /= 16
LOOP UNTIL aul_decimal = 0
 
RETURN ls_hex


end function

public function string of_uuid ();

long  ll_rc
s_uuid lstr_uuid
string ls_guid = ""

constant long RPC_S_OK = 0
constant long RPC_S_UUID_LOCAL_ONLY = 1824
constant long RPC_S_UUID_NO_ADDRESS = 1739

ll_rc = uuidCreate(lstr_uuid)
//  returns 
//   RPC_S_OK - The call succeeded.
//   RPC_S_UUID_LOCAL_ONLY - 
//     The UUID is guaranteed to be unique to this computer only.
//   RPC_S_UUID_NO_ADDRESS - 
//     Cannot get Ethernet/token-ring hardware address for this computer.
IF ll_rc <> RPC_S_OK THEN
    setNull(ls_GUID)
    // MessageBox("", "uuid create not ok ?!?")
ELSE
    ls_GUID = right("00000000" + of_hex(lstr_uuid.data1), 8)
    ls_GUID += "-" + right("0000" + of_hex(lstr_uuid.data2), 4)
    ls_GUID += "-" + right("0000" + of_hex(lstr_uuid.data3), 4)
    ls_GUID += "-" + right("0000" + of_hex(lstr_uuid.data4[1]), 4)
    ls_GUID += "-" + right("0000" + of_hex(lstr_uuid.data4[2]), 4) &
          + right("0000" + of_hex(lstr_uuid.data4[3]), 4) &
          + right("0000" + of_hex(lstr_uuid.data4[4]), 4)
    ls_GUID = upper(ls_GUID)
    // MessageBox("", ls_guid)
    // output example : 00003B93-2641-477A-C99E-A2FFEBEB214A
END IF

return ls_GUID


end function

public function string of_create_distributed_components ();
string ls_return 
Integer li_file

ls_return = "<?xml version='1.0' encoding='UTF-8'?>" + is_crlf
ls_return += "<!-- Created with Jaspersoft Studio version 6.2.0.final using JasperReports Library version 6.2.0  -->"
ls_return += "<!-- 2016-05-02T17:01:43 -->"
ls_return += "<jasperReport xmlns='http://jasperreports.sourceforge.net/jasperreports' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xsi:schemaLocation='http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd' name='Blank_A4' pageWidth='595' pageHeight='842' columnWidth='595' leftMargin='0' rightMargin='0' topMargin='0' bottomMargin='0' uuid='d0492cde-b760-463a-a903-dac2640b2c0f'>"
ls_return += "	<property name='com.jaspersoft.studio.unit.' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.pageHeight' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.pageWidth' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.topMargin' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.bottomMargin' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.leftMargin' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.rightMargin' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.columnWidth' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.columnSpacing' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.data.sql.tables' value=''/>" + is_crlf
ls_return += "	<parameter name='arg_sub_result_key' class='java.lang.Integer'>" + is_crlf
ls_return += "		<parameterDescription><![CDATA[]]></parameterDescription>" + is_crlf
ls_return += "		<defaultValueExpression><![CDATA[78391048]]></defaultValueExpression>" + is_crlf
ls_return += "	</parameter>" + is_crlf
ls_return += "	<parameter name='arg_sub_transaction' class='java.lang.Integer'>" + is_crlf
ls_return += "		<parameterDescription><![CDATA[]]></parameterDescription>" + is_crlf
ls_return += "		<defaultValueExpression><![CDATA[76105898]]></defaultValueExpression>" + is_crlf
ls_return += "	</parameter>" + is_crlf
ls_return += "	<parameter name='arg_sub_stowage_key' class='java.lang.Integer'>" + is_crlf
//ls_return += "		<defaultValueExpression><![CDATA[478597]]></defaultValueExpression>" + is_crlf
ls_return += "	</parameter>" + is_crlf
ls_return += "	<queryString>" + is_crlf
ls_return += "		<![CDATA[SELECT cen_out_md_co.nquantity nquantity,   " + is_crlf
ls_return += "         cen_out_md_co.cpackinglist cpackinglist,   " + is_crlf
ls_return += "         cen_out_md_co.ctext ctext,   " + is_crlf
ls_return += "         cen_out_md_co.cclass cclass,   " + is_crlf
ls_return += "         cen_out_md_co.cmeal_control_code cmeal_control_code,   " + is_crlf
ls_return += "         cen_out_md_co.nclass_number nclass_number,   " + is_crlf
ls_return += "         cen_out_md_co.nspml nspml,   " + is_crlf
ls_return += "         cen_out_md_co.npl_distribution_key npl_distribution_key,  " + is_crlf
ls_return += "         cen_out_md.nstowagekey nstowagekey," + is_crlf
ls_return += "		cen_out_md.cstowage cstowage" + is_crlf
ls_return += "    FROM cen_out_md,   " + is_crlf
ls_return += "         cen_out_md_co  " + is_crlf
ls_return += "   WHERE  cen_out_md.nresult_key = cen_out_md_co.nresult_key  and  " + is_crlf
ls_return += "          cen_out_md.ntransaction = cen_out_md_co.ntransaction  and  " + is_crlf
ls_return += "          cen_out_md.narray_count = cen_out_md_co.narray_count  and  " + is_crlf
ls_return += "         cen_out_md.nresult_key = $P{arg_sub_result_key}  AND  " + is_crlf
ls_return += "         cen_out_md.ntransaction = $P{arg_sub_transaction}  AND  " + is_crlf
ls_return += "         cen_out_md.nstowagekey = $P{arg_sub_stowage_key}]]>" + is_crlf
ls_return += "	</queryString>" + is_crlf
ls_return += "	<field name='NQUANTITY' class='java.math.BigDecimal'/>" + is_crlf
ls_return += "	<field name='CPACKINGLIST' class='java.lang.String'/>" + is_crlf
ls_return += "	<field name='CTEXT' class='java.lang.String'/>" + is_crlf
ls_return += "	<field name='CCLASS' class='java.lang.String'/>" + is_crlf
ls_return += "	<field name='CMEAL_CONTROL_CODE' class='java.lang.String'/>" + is_crlf
ls_return += "	<field name='NCLASS_NUMBER' class='java.math.BigDecimal'/>" + is_crlf
ls_return += "	<field name='NSPML' class='java.math.BigDecimal'/>" + is_crlf
ls_return += "	<field name='NPL_DISTRIBUTION_KEY' class='java.math.BigDecimal'/>" + is_crlf
ls_return += "	<field name='NSTOWAGEKEY' class='java.math.BigDecimal'/>" + is_crlf
ls_return += "	<field name='CSTOWAGE' class='java.lang.String'/>" + is_crlf
ls_return += "	<background>" + is_crlf
ls_return += "		<band splitType='Stretch'/>" + is_crlf
ls_return += "	</background>" + is_crlf


 ls_return += '<detail>'  + is_crlf
 ls_return += '		<band height="26" splitType="Prevent">' + is_crlf
 ls_return += '			<textField>' + is_crlf
 ls_return += '				<reportElement x="3" y="0" width="27" height="24" uuid="d35ae247-fdf2-445b-a819-7a4f1f293f1d">' + is_crlf
 ls_return += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>' + is_crlf
 ls_return += '				</reportElement>' + is_crlf
 ls_return += '				<textElement>' + is_crlf
 ls_return += '					<font fontName="Arial" size="18"/>' + is_crlf
// <font fontName="Arial" size
 
 ls_return += '				</textElement>' + is_crlf
 ls_return += '				<textFieldExpression><![CDATA[$F{NQUANTITY}]]></textFieldExpression>' + is_crlf
 ls_return += '			</textField>' + is_crlf
 ls_return += '			<textField>' + is_crlf
 ls_return += '				<reportElement mode="Transparent" x="33" y="11" width="156" height="14" backcolor="#0099FF" uuid="34c16169-d405-4981-bce7-56b3ca249d11">' + is_crlf
 ls_return += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>' + is_crlf
 ls_return += '				</reportElement>' + is_crlf
 ls_return += '				<textElement>' + is_crlf
 ls_return += '					<font fontName="Arial" size="8"/>' + is_crlf
 ls_return += '				</textElement>' + is_crlf
 ls_return += '				<textFieldExpression><![CDATA[$F{CTEXT}]]></textFieldExpression>' + is_crlf
 ls_return += '			</textField>' + is_crlf
 ls_return += '			<textField>' + is_crlf
 ls_return += '				<reportElement mode="Transparent" x="33" y="0" width="149" height="14" backcolor="#FF9933" uuid="62017005-26f3-49a9-8ce5-cbdc37b1916b">' + is_crlf
 ls_return += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>' + is_crlf
 ls_return += '					<property name="com.jaspersoft.studio.unit.x" value="pixel"/>' + is_crlf
 ls_return += '				</reportElement>' + is_crlf
 ls_return += '				<textElement>' + is_crlf
 ls_return += '					<font fontName="Arial" size="8"/>' + is_crlf
 ls_return += '				</textElement>' + is_crlf
 ls_return += '				<textFieldExpression><![CDATA[$F{CPACKINGLIST}]]></textFieldExpression>' + is_crlf
 ls_return += '			</textField>' + is_crlf
 ls_return += '		</band>' + is_crlf
 ls_return += '	</detail>' + is_crlf
ls_return += "</jasperReport>" + is_crlf


//li_file	= FileOpen(is_jasper_sub_report_file, LineMode!, Write!, LockWrite!, Append!)
//FileWrite(li_file, ls_return)
//FileClose(li_file)


return ls_return 

end function

public function integer of_export_datawindow (datawindow adw_source);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_export_datawindow (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datawindow adw_source
//
// Beschreibung:		Export DW to Jasper
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: integer
//
// --------------------------------------------------------------------------------

String	ls_xml
String	ls_quote 
String	ls_crlf
long 		ll_rows
integer 	li_object_type
String	ls_Object_Array[]
String	ls_DWObjects
Long		ll_Counter, ll_ArrayCount
String	ls_Temp
Double	ld_Factor_H = 1
Double	ld_Factor_V = 1
String	ls_Object
String	ls_Band
String	ls_type
String	ls_Logo = "AA_colour.png"
Long		ll_Height_Header   = 104
Long		ll_Height_Detail   = 640
Long		ll_Height_Footer   =  65
Long		ll_Page_Height
Long		ll_Xpos
Long		ll_Ypos
Integer	li_UseLetterFormat


ld_Factor_V =  640 / 850
ld_Factor_H =  595 / 720
//<DW Control Name>.Describe("DataWindow.Header.Height")
ll_Height_Header = Long(adw_source.Describe("DataWindow.header.height"))	

ll_Height_Header = 100

ll_Height_Detail = Long(adw_source.Describe("DataWindow.detail.height"))	
ll_Height_Footer = Long(adw_source.Describe("DataWindow.footer.height"))	

ll_Page_Height = ll_Height_Header + ll_Height_Detail + ll_Height_Footer

li_UseLetterFormat = integer(f_mandant_profilestring(sqlca, s_app.smandant, "PaperFormat", "UseLetterFormat", "0"))

ls_xml = ""
ls_xml += '<?xml version="1.0" encoding="UTF-8"?>'+ is_crlf
ls_xml += '<!-- Created with Jaspersoft Studio version 6.3.0.final using JasperReports Library version 6.3.0  -->'+ is_crlf
ls_xml += '<!-- 2017-03-07T12:28:55 -->'+ is_crlf
ls_xml += '<jasperReport xmlns="http://jasperreports.sourceforge.net/jasperreports" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd" '
ls_xml += ' name="Cart_Diagram_V01" '
//ls_xml += ' pageWidth="595" pageHeight="842" columnWidth="575" '
if li_UseLetterFormat = 1 then
	ls_xml += ' pageWidth="720" pageHeight="' + String(ll_Page_Height) + '" columnWidth="715" '
Else
	ls_xml += ' pageWidth="720" pageHeight="1100" columnWidth="715" '
End If
ls_xml += ' leftMargin="1" rightMargin="1" topMargin="1" bottomMargin="1" uuid="f3e31c49-3082-49f1-b22e-3f0284456ade">'
ls_xml += '	<property name="com.jaspersoft.studio.data.sql.tables" value=""/>'+ is_crlf
ls_xml += '	<property name="com.jaspersoft.studio.data.defaultdataadapter" value="MAINTUS"/>'+ is_crlf
ls_xml += '	<property name="com.jaspersoft.studio.unit." value="pixel"/>'+ is_crlf
//ls_xml += '	<parameter name="arg_result_key" class="java.lang.Long"/>'
//ls_xml += '	<parameter name="arg_stowage" class="java.lang.String"/>'

ls_xml += '	<parameter name="arg_result_key" class="java.lang.Long">'+ is_crlf
ls_xml += '			<defaultValueExpression><![CDATA[82951474]]></defaultValueExpression>'+ is_crlf
ls_xml += '		</parameter>'+ is_crlf
ls_xml += '		<parameter name="arg_stowage" class="java.lang.Long">'+ is_crlf
//ls_xml += '			<defaultValueExpression><![CDATA[5-20]]></defaultValueExpression>'+ is_crlf
ls_xml += '		</parameter>'+ is_crlf

ls_xml += of_create_query()

ls_DWObjects = adw_source.describe("datawindow.objects")

for ll_Counter = 1 to len(ls_DWObjects)
	if Mid(ls_DWObjects, ll_Counter, 1) <> char(9) then
		ls_Temp += Mid(ls_DWObjects, ll_Counter, 1)
	else
		ll_ArrayCount ++
		ls_Object_Array[ll_ArrayCount] = ls_Temp
		ls_Temp = ""
	end if
next
if len(ls_Temp) > 0 then		
	ll_ArrayCount ++
	ls_Object_Array[ll_ArrayCount] = ls_Temp
end if

	
//ls_xml += "	<background>" + is_crlf+ is_crlf
//ls_xml += "		<band splitType='Stretch'/>" + is_crlf
//ls_xml += "	</background>" + is_crlf

ls_xml += "<pageHeader>"+ is_crlf
ls_xml += '		<band height="' + string(ll_Height_Header ) + '" splitType="Stretch">'+ is_crlf
//ls_xml += '		<band height="' + string(ll_Height_Header ) + '" splitType="Stretch">'+ is_crlf

for ll_rows = 1 to upperbound(ls_Object_Array)
	ls_Object = ls_Object_Array[ll_rows]
	if pos(	ls_Object,"marker") > 0 then
		continue
	end if
	ls_Band = adw_source.Describe(ls_Object_Array[ll_rows] + ".band")	
	if ls_Band <> "header" then 
		continue
	end if
	
	ls_Temp = adw_source.Describe(ls_Object_Array[ll_rows] + ".visible")	
	if ls_Temp <> "1" then 
		continue
	end if
		
	If ls_Object = "h_departuredate" OR &
		ls_Object = "h_packinglist"   OR &
		ls_Object = "h_description"   OR &
		ls_Object = "h_loadinglist"   OR &
		ls_Object = "f_departure" OR &
		ls_Object = "f_ramptime" OR &
		ls_Object = "f_flightnumber" OR &
		ls_Object = "f_stowageposition" OR &
		ls_Object = "h_actype" then	
		
		ls_xml += of_create_column( adw_source, ls_Object)
		
	Else
	
		ls_type = adw_source.Describe(ls_Object_Array[ll_rows] + ".Type")		
		choose case ls_type
			//	Solumn
			case "column"
			//	ls_xml += of_create_column(ll_rows)
	
			case "text"
				ll_Ypos = Long(adw_source.Describe(ls_Object_Array[ll_rows] + ".y"))
				if ll_Ypos > ll_Height_Header Then
					CONTINUE		
				End If
				ls_xml += of_create_static_text(adw_source, ls_Object)
				
			// Rectangle	
			case "rectangle" 
				ll_Ypos = Long(adw_source.Describe(ls_Object_Array[ll_rows] + ".y"))
				if ll_Ypos > ll_Height_Header Then
					CONTINUE		
				End If
				ls_xml += of_create_rectangle(adw_source, ls_Object)
	
	
			// Line
			CASE "line"		
				ll_Ypos = Long(adw_source.Describe(ls_Object_Array[ll_rows] + ".y1"))
				if ll_Ypos > ll_Height_Header Then
					CONTINUE		
				End If
				ls_xml += of_create_line(adw_source, ls_Object)
				
			//	Picture
			CASE "bitmap"	
				
				ls_xml += of_create_bitmap( adw_source, ls_Object)
	//			ls_xml += of_create_barcode(ll_rows)
	
			CASE "compute"
				ls_xml +=  of_create_compute( adw_source, ls_Object)

			CASE ELSE
				// Nothing to do
				//CONTINUE
		end choose
	End If
next

ls_xml += "</band>"+ is_crlf
ls_xml += "</pageHeader>"+ is_crlf

ls_xml += "	<detail>" + is_crlf
//ls_xml += "		<band height='" + string(il_band_height) + "' splitType='Stretch'>" + is_crlf
ls_xml += "		<band height='" + string(ll_Height_Detail ) + "' splitType='Stretch'>" + is_crlf

for ll_rows = 1 to upperbound(ls_Object_Array)
	ls_Object = ls_Object_Array[ll_rows]
	if pos(	ls_Object,"marker") > 0 then
		continue
	end if
	ls_Band = adw_source.Describe(ls_Object_Array[ll_rows] + ".band")	
	if ls_Band <> "detail" then 
		continue
	end if
	ls_Temp = adw_source.Describe(ls_Object_Array[ll_rows] + ".visible")	
	if ls_Temp <> "1" then 
		continue
	end if
	ls_type = adw_source.Describe(ls_Object_Array[ll_rows] + ".Type")		
	
	If ls_Object = "h_departuredate" OR &
		ls_Object = "h_packinglist"   OR &
		ls_Object = "h_description"   OR &
		ls_Object = "h_loadinglist"   OR &
		ls_Object = "f_departure" OR &
		ls_Object = "f_ramptime" OR &
		ls_Object = "f_flightnumber" OR &
		ls_Object = "f_stowageposition" OR &
		ls_Object = "h_actype" then	
		
		ls_xml += of_create_column( adw_source, ls_Object)
		//ls_xml += of_create_rectangle(adw_source, ls_Object)
		
	Else
	
		choose case ls_type
			//	Solumn
			case "column"
			//	ls_xml += of_create_column(ll_rows)
	
			case "text"
				ls_xml += of_create_static_text(adw_source, ls_Object)
				
			// Rectangle	
			case "rectangle" 
				ls_xml += of_create_rectangle(adw_source, ls_Object)
	
			// Rectangle	
			case "roundrectangle" 
				ls_xml += of_create_round_rect(adw_source, ls_Object)
	
			// Line
			CASE "line"		
				ls_xml += of_create_line(adw_source, ls_Object)
				
			//	Picture
			CASE "bitmap"	
				ls_xml += of_create_bitmap( adw_source, ls_Object)
	
			CASE "compute"
				ls_xml +=  of_create_compute( adw_source, ls_Object)
		
			CASE ELSE
				// Nothing to do
				//CONTINUE
		end choose
	End If
next

ls_xml += "		</band>" + is_crlf
ls_xml += "	</detail>" + is_crlf

ls_xml += "<pageFooter>"+ is_crlf
ls_xml += '		<band height="' + String(ll_Height_Footer )  + '" splitType="Stretch">'+ is_crlf

for ll_rows = 1 to upperbound(ls_Object_Array)
	ls_Object = ls_Object_Array[ll_rows]
	if pos(	ls_Object,"marker") > 0 then
		continue
	end if
	ls_Band = adw_source.Describe(ls_Object_Array[ll_rows] + ".band")	
	if ls_Band <> "footer" then 
		continue
	end if
	
	ls_Temp = adw_source.Describe(ls_Object_Array[ll_rows] + ".visible")	
	if ls_Temp <> "1" then 
		continue
	end if
		
	ls_type = adw_source.Describe(ls_Object_Array[ll_rows] + ".Type")	
	
	If ls_Object = "h_departuredate" OR &
		ls_Object = "h_packinglist"   OR &
		ls_Object = "h_description"   OR &
		ls_Object = "h_loadinglist"   OR &
		ls_Object = "f_departure" OR &
		ls_Object = "f_ramptime" OR &
		ls_Object = "f_flightnumber" OR &
		ls_Object = "f_stowageposition" OR &
		ls_Object = "h_actype" then	
		
		ls_xml += of_create_column( adw_source, ls_Object)
		
	Else
	
		choose case ls_type
			//	Solumn
			case "column"
			//	ls_xml += of_create_column(ll_rows)
	
			case "text"
				ll_Ypos = Long(adw_source.Describe(ls_Object_Array[ll_rows] + ".y"))
				if ll_Ypos > ll_Height_Footer Then
					CONTINUE		
				End If
				ls_xml += of_create_static_text(adw_source, ls_Object)
				
			// Rectangle	
			case "rectangle" 
				ll_Ypos = Long(adw_source.Describe(ls_Object_Array[ll_rows] + ".y"))
				if ll_Ypos > ll_Height_Footer Then
					CONTINUE		
				End If
				ls_xml += of_create_rectangle(adw_source, ls_Object)
	
			// Line
			CASE "line"		
				ll_Ypos = Long(adw_source.Describe(ls_Object_Array[ll_rows] + ".y1"))
				if ll_Ypos > ll_Height_Footer Then
					CONTINUE		
				End If
				ls_xml += of_create_line(adw_source, ls_Object)
				
			//	Picture
			CASE "bitmap"	
				
				ls_xml += of_create_bitmap( adw_source, ls_Object)
	
			CASE "compute"
					ls_xml +=  of_create_compute( adw_source, ls_Object)
		
			CASE ELSE
				// Nothing to do
				//CONTINUE
		end choose
	
end if
next


ls_xml += "		</band>"+ is_crlf
ls_xml += "	</pageFooter>"+ is_crlf

ls_xml += "</jasperReport>" + is_crlf

this.of_write(ls_xml)

//Messagebox("", "File: " + is_crlf + is_crlf + is_jasperfile + is_crlf + is_crlf + "created!")

return 0


end function

public function string of_create_line (datawindow adw_ref, string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_line (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datastore adw_ref
//	 string as_object
//
// Beschreibung:		Create a Line Object
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

string	ls_return
string	ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic, ls_column
Long		ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border


ll_x = Long(adw_ref.Describe(as_Object + ".x1"))
ll_y = Long(adw_ref.Describe(as_Object + ".y1"))
ll_height = (Long(adw_ref.Describe(as_Object + ".y2")) )
ll_width = (Long(adw_ref.Describe(as_Object + ".x2")) )

ll_x = of_convert_pixels( ll_x )
ll_y = of_convert_pixels( ll_y )
ll_width = of_convert_pixels( ll_width )
ll_height = of_convert_pixels( ll_height )

ls_return ="		<line>" + is_crlf

if ll_y = ll_height then // waagerechte Linie
	ls_return +="				<reportElement x='" + string(ll_x) + "' y='" + string(ll_y) + "' width='" + string(ll_width - ll_x) + "' height='" + string(1) + "' uuid='9e17210d-" + string(Rand(9999), "0000") + "-" + string(Rand(9999), "0000") + "-9e26-b9b2573c40cd'/>" + is_crlf
elseif  ll_x = ll_width then //senkrechte Linie
	ls_return +="				<reportElement x='" + string(ll_x) + "' y='" + string(ll_y) + "' width='" + string(1) + "' height='" + string(ll_height - ll_y) + "' uuid='9e17210d-" + string(Rand(9999), "0000") + "-" + string(Rand(9999), "0000") + "-9e26-b9b2573c40cd'/>" + is_crlf
end if

ls_return +="	</line>" + is_crlf

return ls_return


end function

public function string of_create_rectangle (datawindow adw_ref, string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_rectangle (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datawindow adw_ref
//	 string as_object
//
// Beschreibung:		create a rectangle object
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

string		ls_return
string		ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic, ls_column
Long			ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border
Long			ll_BackGroundColour, ll_BackGroundMode
String		ls_PenStyle


ll_x = Long(adw_ref.Describe(as_Object + ".x"))
ll_y = Long(adw_ref.Describe(as_Object + ".y"))
ll_height = (Long(adw_ref.Describe(as_Object + ".height")) )
ll_width = (Long(adw_ref.Describe(as_Object + ".width")) )

ll_x = of_convert_pixels( ll_x )
ll_y = of_convert_pixels( ll_y )
ll_width = of_convert_pixels( ll_width )
ll_height = of_convert_pixels( ll_height )

If ll_width < 0 OR ll_height < 0 Then
	//lb_Breakpoint = TRUE
	return ""
End If

ls_PenStyle =adw_ref.Describe(as_Object + ".Pen.Style")
//	<rectangle>
//				<reportElement key="guckmalhier" x="520" y="13" width="22" height="50" backcolor="#FFFF33" uuid="210ac338-2b5a-4c0b-8cd8-44a81b626491"/>
//				<graphicElement>
//					<pen lineWidth="0.0" lineColor="#FFFFFF"/>
//				</graphicElement>
//			</rectangle>

ls_return ="			<rectangle>" + is_crlf

ll_BackGroundMode = Long(adw_ref.Describe(as_Object + ".Background.Mode"))
if ll_BackGroundMode <> 1 then 
	ll_BackGroundColour = Long(adw_ref.Describe(as_Object + ".Background.color"))
	ll_BackGroundColour = rgb(200,200,200)
	ls_return += "<reportElement mode='Opaque' x='" + string(ll_x) + "' y='" + string(ll_y)+ "' width='" + string(ll_width) + "' height='" + string(ll_height) + "' " 
	ls_return += " backcolor='#C8C8C8' " 
	ls_return += 			"uuid='" + string(Rand(9999), "0000") + "-" +  string(Rand(9999), "0000") + "-49bd-8b0c-157e72d1978c'/>"+ is_crlf
	
	If ls_PenStyle = "5" Then
		ls_return += "<graphicElement>"
		ls_return += '				<pen lineWidth="0.0" lineColor="#FFFFFF"/>'
		ls_return += "			</graphicElement>"
	End If
Else
	ls_return += "<reportElement mode='Transparent' x='" + string(ll_x) + "' y='" + string(ll_y)+ "' width='" + string(ll_width) + "' height='" + string(ll_height) + "' uuid='" + string(Rand(9999), "0000") + "-" +  string(Rand(9999), "0000") + "-49bd-8b0c-157e72d1978c'/>"+ is_crlf
	
End If

ls_return +="		</rectangle>" + is_crlf

return ls_return

end function

public function string of_create_static_text (datawindow adw_ref, string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_static_text (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datawindow adw_ref
//	 string as_object
//
// Beschreibung:		Create a Static Text Object
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

string	ls_return, ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic
String	ls_error
Long 		ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border
Long		ll_BackGroundMode
Long		ll_BackGroundColour
String	ls_Temp
String	ls_BackGroundColour
Long		ll_TextColour
String	ls_TextColour
String	ls_Object_Key
Boolean  lb_Breakpoint

ll_x = Long(adw_ref.Describe(as_Object + ".x"))
ll_y = Long(adw_ref.Describe(as_Object + ".y"))
ll_height = (Long(adw_ref.Describe(as_Object + ".height")) )
ll_width = (Long(adw_ref.Describe(as_Object + ".width")) )

ll_x = of_convert_pixels( ll_x )
ll_y = of_convert_pixels( ll_y )
ll_width = of_convert_pixels( ll_width )
ll_height = of_convert_pixels( ll_height )

If ll_width < 0 OR ll_height < 0 Then
	lb_Breakpoint = TRUE
	return ""
End If

If ll_width + ll_x > il_detail_width OR ll_height + ll_y > il_Detail_Height Then
	lb_Breakpoint = TRUE
	return ""
End If


ll_height += 5
ll_width  += 2

ll_border 		= Long(adw_ref.Describe(as_Object + ".Border")) 
ls_Fontname 	= adw_ref.Describe(as_Object + ".font.face") 

If ib_Replace_Font_With_Arial Then
	//f_trace("Font: " + ls_Fontname + " => Arial" )
	ls_Fontname = "Arial"
End If

ll_fontsize 	= Long(adw_ref.Describe(as_Object + ".font.height"))
if ll_fontsize < 0 then ll_fontsize = ll_fontsize * -1
ll_fontweight 	= Long(adw_ref.Describe(as_Object + ".font.weight")) 
ll_align 			= Long(adw_ref.Describe(as_Object + ".alignment"))
ll_underline 		= Long(adw_ref.Describe(as_Object + ".font.underline"))
ll_italic 			= Long(adw_ref.Describe(as_Object + ".Font.Italic")) 
ls_text 			= adw_ref.Describe(as_Object + ".text") 

// $$HEX1$$1920$$ENDHEX$$
ls_text = f_replace(ls_text, "$$HEX1$$1920$$ENDHEX$$", "'")


ls_text = f_replace(ls_text, "$$HEX1$$1320$$ENDHEX$$", "-")

//ls_text = f_replace(ls_text, "$$HEX1$$c900$$ENDHEX$$", "E")
if pos (ls_text, "$$HEX1$$c900$$ENDHEX$$") > 0 then
	ls_text = ls_text
End If

ls_text = f_replace(ls_text, "$$HEX1$$c900$$ENDHEX$$", "E")

ls_text = f_replace(ls_text, "$$HEX1$$e900$$ENDHEX$$", "e")

ls_text = f_replace(ls_text, "$$HEX1$$d700$$ENDHEX$$", "x")


//ls_text = f_replace(ls_text, '"', "")

ls_text = f_replace(ls_text, '$$HEX1$$1c20$$ENDHEX$$', '"')

ls_text = f_replace(ls_text, '$$HEX1$$1d20$$ENDHEX$$', '"')


ll_TextColour  = Long(adw_ref.Describe(as_Object + ".color"))
ls_TextColour = of_convert_rgb( ll_TextColour )

if pos(as_Object, "_content_") > 0 Then
	ll_TextColour = 0 
	ls_TextColour = of_convert_rgb( ll_TextColour )
End If

ls_return  = "		<staticText>"+ is_crlf
ls_return += "			<reportElement "


//key="t_content_1_col_01_row_01"
//<printWhenExpression><![CDATA[false]]></printWhenExpression>
// p_bottom_tray_col_01_row_04
// p_lane_left_col_1_row_14
// p_lane_right_col_2_row_10

ls_Object_Key = of_object_key(as_object)

ls_return += "	key='" + ls_Object_Key + "'"


ll_BackGroundMode = Long(adw_ref.Describe(as_Object + ".Background.Mode"))
if ll_BackGroundMode <> 1 then 
	ll_BackGroundColour = Long(adw_ref.Describe(as_Object + ".Background.color"))
	
	//ll_BackGroundColour = rgb(200,200,200)
	
	ls_Temp = (adw_ref.Describe(as_Object + ".Background.color"))
	
	If pos(ls_Temp, "~t") > 0 then
		ls_Temp = mid(ls_Temp, pos(ls_Temp, "~t") + 1) 
		if right(ls_Temp, 1) = '"' or right(ls_Temp, 1) = "'" Then
			ls_Temp = left(ls_Temp, len(ls_Temp) -1)
		End If
	
		ls_error = (adw_ref.Describe("evaluate(' " + ls_Temp) + "', 0)")
		
		ls_Temp = "evaluate('" + ls_Temp + "', 0)"
		ls_error = 	adw_ref.Describe(ls_Temp)
		
		ll_BackGroundColour = rgb(200,200,200)
		
		if isnumber(ls_error) then
			//ll_BackGroundColour = long(ls_Temp)
			ll_BackGroundColour = long(ls_error)
		End If
		
	Else
		If isnumber(ls_Temp) then
			ll_BackGroundColour = long(ls_Temp)
		end if
		
	End If
	//ll_BackGroundColour = rgb(200,200,200)
	//ls_return += ' mode="Opaque" backcolor="#C8C8C8" '
	
	ls_BackGroundColour = of_convert_rgb( ll_BackGroundColour )
	
	ls_return += ' mode="Opaque" backcolor="' + ls_BackGroundColour + '" '
	
end if


If pos(as_object , "t_rungnumber_") > 0 then
	ls_textColour = "#000000"
end if

ls_return += "	x='" + String(ll_x) + "' y='" + String(ll_y) + "' width='" + String(ll_width) + "' height='" + String(ll_height) + "'"
ls_return += "	forecolor='" + ls_textColour + "'"

// height="20" forecolor="#0000FF"

ls_return += "	uuid='092d53ea-" + string(Rand(9999), "0000") + "-40a3-a9d6-" + string(cpu()) + "'/>"+ is_crlf

if ll_border <> 0 then
	ls_return += "				<box padding='2' topPadding='0' leftPadding='0' bottomPadding='0' rightPadding='0'>"+ is_crlf
	ls_return += "					<topPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>"+ is_crlf
	ls_return += "					<leftPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>"+ is_crlf
	ls_return += "					<bottomPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>"+ is_crlf
	ls_return += "					<rightPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>"+ is_crlf
	ls_return += "				</box>"
end if

Choose case ll_align
	case 0
		ls_alignment = "Left"
	case 1
		ls_alignment = "Right"
	case 2
		ls_alignment = "Center"
	case else
		ls_alignment = ""
end choose

if ll_fontweight = 700 then
	ls_bold = "true"
else
	ls_bold = "false"
end if

if ll_italic = 1 then
	ls_italic = "true"
else
	ls_italic = "false"
end if

if ll_underline = 1 then
	ls_underline = "true"
else
	ls_underline = "false"
end if

ls_return += "				<textElement textAlignment='" + ls_alignment+ "'>"+ is_crlf
ls_return += "					<font fontName='" + ls_Fontname + "' size='" + String(ll_fontsize) + "' isBold='" + ls_bold + "' isItalic='" + ls_italic + "' isUnderline='" + ls_underline + "'/>"+ is_crlf
ls_return += "				</textElement>"+ is_crlf
ls_return += "				<text><![CDATA[" + ls_text + "]]></text>"+ is_crlf
ls_return += "			</staticText>"+ is_crlf


return ls_return 


end function

public function string of_create_bitmap (datawindow adw_ref, string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_bitmap (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datawindow adw_ref
//	 string as_object
//
// Beschreibung:		Create Bitmap
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

string	ls_return
string	ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic, ls_column
Long		ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border
String	ls_Picture
String	ls_PIC_Orig
String	ls_Object_Key

ll_x = Long(adw_ref.Describe(as_Object + ".x"))
ll_y = Long(adw_ref.Describe(as_Object + ".y"))
ll_height = Long(adw_ref.Describe(as_Object + ".height")) 
ll_width = Long(adw_ref.Describe(as_Object + ".width")) 
ls_Picture = adw_ref.Describe(as_Object + ".filename")

ls_PIC_Orig = ls_Picture

if pos(ls_Picture, "\") > 0 then
	ls_Picture = mid(ls_Picture, lastpos(ls_Picture, "\") + 1)
end if

ll_x = of_convert_pixels( ll_x )
ll_y = of_convert_pixels( ll_y )
ll_width = of_convert_pixels( ll_width )
ll_height = of_convert_pixels( ll_height )

If ll_width < 0 OR ll_height < 0 Then
	//lb_Breakpoint = TRUE
	return ""
End If

//if not fileexists( "C:\Users\U112878\JaspersoftWorkspace\MyReports\images\" + ls_Picture) then
//	FileCopy(ls_PIC_Orig, "C:\Users\U112878\JaspersoftWorkspace\MyReports\images\" + ls_Picture)
//end if

ls_return   ='		<image scaleImage="FillFrame">' + is_crlf
ls_return += "			<reportElement "

ls_Object_Key = of_object_key(as_object)

ls_return += "	key='" + ls_Object_Key + "' "

ls_return +="x='" + string(ll_x) + "' y='" + string(ll_y)+ "' width='" + string(ll_width) + "' height='" + string(ll_height) + "' uuid='" + string(Rand(9999), "0000") + "-" +  string(Rand(9999), "0000") + "-49bd-8b0c-157e72d1978c'/>"+ is_crlf

If ib_Replace_Image_Path Then
	//	<imageExpression><![CDATA[$P{SUBREPORT_DIR} + "images/drawer_bottom.jpg"]]></imageExpression>
	ls_return += '			<imageExpression><![CDATA[$P{SUBREPORT_DIR} + "images/' + ls_Picture + '"]]></imageExpression>'+ is_crlf
Else
	ls_return += '			<imageExpression><![CDATA["' + "images/" + ls_Picture + '"]]></imageExpression>'+ is_crlf
End If

ls_return += "		</image>" + is_crlf

return ls_return


end function

public function string of_create_column (datawindow adw_ref, string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_column (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datawindow adw_ref
//	 string as_object
//
// Beschreibung:		Create a "real" DB column
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

string	ls_return, ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic, ls_column
Long		ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border
String	ls_Pattern


CHOOSE CASE as_object
	CASE "h_departuredate" 
		ls_column = "DDEPARTURE"
		ls_pattern = "MMM dd"

	CASE "h_packinglist" 
		ls_column = "CPACKINGLIST"

	CASE "h_description" 
		ls_column = "CTEXT_PCKL"
		
	CASE "h_loadinglist" 
		ls_column = "CLOADINGLIST"
		
	CASE "f_departure" 
		ls_column = "CDEPARTURE_TIME"
		
	CASE "f_ramptime" 
		ls_column = "CRAMP_TIME"
		
	CASE "f_flightnumber" 
		ls_column = "CFLIGHT"
		//cairline  || ' ' || to_char(nflight_number) CFLIGHT
		
	CASE "f_stowageposition" 
		ls_column = "CSTPOSITION"
		
	CASE "h_actype" 
		ls_column = "CACTYPE"
		
	CASE "f_workstation" 
		ls_column = "CMULTI_WS_1" //"CCOM_CAREA_CODE"
		
	CASE "f_rampbox" 
		ls_column = "CRAMPBOX"


CASE ELSE
	RETURN ""

END CHOOSE


//	<textField isBlankWhenNull="true">


If ls_pattern > "" Then
	ls_return = '					<textField pattern="' + ls_pattern + '">' + is_crlf	
Else
	//ls_return = "					<textField>" + is_crlf
	ls_return = '					<textField isBlankWhenNull="true">' + is_crlf
	
	//	<textField isBlankWhenNull="true">

End If

ll_x = Long(adw_ref.Describe(as_Object + ".x"))
ll_y = Long(adw_ref.Describe(as_Object + ".y"))
ll_height = (Long(adw_ref.Describe(as_Object + ".height")) )
ll_width = (Long(adw_ref.Describe(as_Object + ".width")) )

ll_x = of_convert_pixels( ll_x )
ll_y = of_convert_pixels( ll_y )
ll_width = of_convert_pixels( ll_width )
ll_height = of_convert_pixels( ll_height )


If ll_width < 0 OR ll_height < 0 Then
	//lb_Breakpoint = TRUE
	return ""
End If

If ls_column = "DDEPARTURE" Then 
	//ll_fontsize 	= 12
	ll_height += 7
End If


//<DW Control Name>.Modify("<Columnname>.Border='
//<0 - None, 1- Shadow, 2 - Box, 3 - Resize, 4 - Underline, 5 - 3D Lowered, 6 - 3D Raised>'")

ll_border 		= Long(adw_ref.Describe(as_Object + ".Border")) 
ls_Fontname 	= adw_ref.Describe(as_Object + ".font.face") 

If ib_Replace_Font_With_Arial Then
	//f_trace("Font: " + ls_Fontname + " => Arial" )
	ls_Fontname = "Arial"
End If

ll_fontsize 	= Long(adw_ref.Describe(as_Object + ".font.height"))

If ls_column = "CRAMPBOX" Then 
	ll_fontsize 	= 12
End If

If ls_column = "CLOADINGLIST" Then 
	ll_fontsize 	= 11
End If

If ls_column = "CTEXT_PCKL" Then 
	ll_fontsize 	= 11
End If

if ll_fontsize < 0 then ll_fontsize = ll_fontsize * -1
ll_fontweight 	= Long(adw_ref.Describe(as_Object + ".font.weight")) 
ll_align 		= Long(adw_ref.Describe(as_Object + ".alignment"))
ll_underline 	= Long(adw_ref.Describe(as_Object + ".font.underline"))
ll_italic 		= Long(adw_ref.Describe(as_Object + ".Font.Italic")) 
ls_text 			= adw_ref.Describe(as_Object + ".text")


ll_fontsize -= 1
ll_height += 1

If as_object =  "h_departuredate" then
	ll_fontsize -= 1
	ll_height += 1
End If

If ls_column = "CRAMPBOX" Then 
	ls_return += "				<reportElement x='" + String(ll_x) + "' y='" + String(ll_y) + "' width='" + String(ll_width) + "' height='" + String(ll_height) + "' uuid='092d53ea-" + string(Rand(9999), "0000") + "-40a3-a9d6-" + string(cpu()) + "'>" + is_crlf
	ls_return += "				<printWhenExpression><![CDATA[LEN( $F{CRAMPBOX}) != 1]]></printWhenExpression>"
	ls_return += "				</reportElement>"
Else
	ls_return += "				<reportElement x='" + String(ll_x) + "' y='" + String(ll_y) + "' width='" + String(ll_width) + "' height='" + String(ll_height) + "' uuid='092d53ea-" + string(Rand(9999), "0000") + "-40a3-a9d6-" + string(cpu()) + "'/>" + is_crlf
End If

if ll_border <> 0 then
	ls_return += "				<box padding='2' topPadding='0' leftPadding='0' bottomPadding='0' rightPadding='0'>" + is_crlf
	ls_return += "					<topPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>" + is_crlf
	ls_return += "					<leftPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>" + is_crlf
	ls_return += "					<bottomPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>" + is_crlf
	ls_return += "					<rightPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>" + is_crlf
	ls_return += "				</box>" + is_crlf
end if

Choose case ll_align
	case 0
		ls_alignment = "Left"
	case 1
		ls_alignment = "Right"
	case 2
		ls_alignment = "Center"
	case else
		ls_alignment = ""
end choose

if ll_fontweight = 700 then
	ls_bold = "true"
else
	ls_bold = "false"
end if

if ll_italic = 1 then
	ls_italic = "true"
else
	ls_italic = "false"
end if

if ll_underline = 1 then
	ls_underline = "true"
else
	ls_underline = "false"
end if

ls_return += "				<textElement textAlignment='" + ls_alignment+ "'>" + is_crlf
ls_return += "					<font fontName='" + ls_Fontname + "' size='" + String(ll_fontsize) + "' isBold='" + ls_bold + "' isItalic='" + ls_italic + "' isUnderline='" + ls_underline + "'/>" + is_crlf
ls_return += "				</textElement>" + is_crlf
ls_return += "				<textFieldExpression><![CDATA[$F{" + Upper(ls_column) + "}]]></textFieldExpression>" + is_crlf
ls_return += "			</textField>" + is_crlf


//<textField>
//				<reportElement mode="Transparent" x="240" y="13" width="62" height="30" backcolor="#FFFF66" uuid="889a80f7-c728-49aa-a71d-4766ee5141ce">
//					<printWhenExpression><![CDATA[LEN( $F{CRAMPBOX}) != 1]]></printWhenExpression>
//				</reportElement>
//				<textElement textAlignment="Center"/>
//				<textFieldExpression><![CDATA[$F{CRAMPBOX}]]></textFieldExpression>
//			</textField>

return ls_return 

end function

public function string of_create_round_rect (datawindow adw_ref, string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_round_rect (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datawindow adw_ref
//	 string as_object
//
// Beschreibung:		create round rect (Cart Diagram "Wheels")
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

string		ls_return
string		ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic, ls_column
Long			ll_x, ll_y, ll_width, ll_height, ll_align, ll_border


ll_x = Long(adw_ref.Describe(as_Object + ".x"))
ll_y = Long(adw_ref.Describe(as_Object + ".y"))
ll_height = (Long(adw_ref.Describe(as_Object + ".height")) )
ll_width  = (Long(adw_ref.Describe(as_Object + ".width")) )

If ll_width < 0 OR ll_height < 0 Then
	//lb_Breakpoint = TRUE
	return ""
End If

ll_x = of_convert_pixels( ll_x )
ll_y = of_convert_pixels( ll_y )
ll_width = of_convert_pixels( ll_width )
ll_height = of_convert_pixels( ll_height )

ls_return = '<rectangle radius="5">' + is_crlf
ls_return += '	<reportElement x="'+ string(ll_x) + '" y="' + string(ll_y) +'" width="'+ string(ll_width) + '" height="'+ string(ll_height) + '"'
ls_return += ' forecolor="#646464" backcolor="#646464" uuid="abdfb14f-1f34-4368-8327-e41f975bfc91">' + is_crlf
ls_return += '		<property name="com.jaspersoft.studio.unit.height" value="pixel"/>' + is_crlf
ls_return +="		</reportElement>" + is_crlf
ls_return +="		</rectangle>" + is_crlf

return ls_return

end function

public function string of_zzz_create_barcode (long al_row);
string ls_return

string	ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic, ls_column
Long ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border


ls_return ="			<image>" + is_crlf
ls_return += "			<reportElement x='" + string(ll_x) + "' y='" + string(ll_y)+ "' width='" + string(ll_width) + "' height='" + string(ll_height) + "' uuid='" + string(Rand(9999), "0000") + "-" +  string(Rand(9999), "0000") + "-49bd-8b0c-157e72d1978c'/>"
ls_return += "			<imageExpression><![CDATA[$F{BBARCODE}]]></imageExpression>"
ls_return +="		</image>" + is_crlf

return ls_return

end function

public function string of_create_bitmap (datastore adw_ref, string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_bitmap (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datastore adw_ref
//	 string as_object
//
// Beschreibung:		Cresate Bitmap 
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

string	ls_return
string	ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic, ls_column
Long		ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border
String	ls_Picture
String	ls_PIC_Orig


ll_x			= Long(adw_ref.Describe(as_Object + ".x"))
ll_y			= Long(adw_ref.Describe(as_Object + ".y"))
ll_height	= Long(adw_ref.Describe(as_Object + ".height")) 
ll_width		= Long(adw_ref.Describe(as_Object + ".width")) 
ls_Picture	=      adw_ref.Describe(as_Object + ".filename")
ls_PIC_Orig	= ls_Picture

if pos(ls_Picture, "\") > 0 then
	ls_Picture = mid(ls_Picture, lastpos(ls_Picture, "\") + 1)
end if

//if not fileexists( "C:\Users\U112878\JaspersoftWorkspace\MyReports\images\" + ls_Picture) then
//	FileCopy(ls_PIC_Orig, "C:\Users\U112878\JaspersoftWorkspace\MyReports\images\" + ls_Picture)
//end if

//<image scaleImage="FillFrame">
ls_return   ='		<image scaleImage="FillFrame">' + is_crlf
//ls_return   ="		<image>" + is_crlf
ls_return += "			<reportElement x='" + string(ll_x) + "' y='" + string(ll_y)+ "' width='" + string(ll_width) + "' height='" + string(ll_height) + "' uuid='" + string(Rand(9999), "0000") + "-" +  string(Rand(9999), "0000") + "-49bd-8b0c-157e72d1978c'/>"
//ls_return += '			<imageExpression><![CDATA["' + "images/" + ls_Picture + '"]]></imageExpression>'

If ib_Replace_Image_Path Then
	//	<imageExpression><![CDATA[$P{SUBREPORT_DIR} + "images/drawer_bottom.jpg"]]></imageExpression>
	ls_return += '			<imageExpression><![CDATA[$P{SUBREPORT_DIR} + "images/' + ls_Picture + '"]]></imageExpression>'+ is_crlf
Else
	ls_return += '			<imageExpression><![CDATA["' + "images/" + ls_Picture + '"]]></imageExpression>'+ is_crlf
End If


ls_return += "		</image>" + is_crlf

return ls_return


end function

public function string of_create_line (datastore adw_ref, string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_line (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datastore adw_ref
//	 string as_object
//
// Beschreibung:		Create a Line Object
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

string	ls_return
string	ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic, ls_column
Long		ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border


ll_x = Long(adw_ref.Describe(as_Object + ".x1"))
ll_y = Long(adw_ref.Describe(as_Object + ".y1"))
ll_height = (Long(adw_ref.Describe(as_Object + ".y2")) )
ll_width = (Long(adw_ref.Describe(as_Object + ".x2")) )


ls_return ="		<line>" + is_crlf

if ll_y = ll_height then // waagerechte Linie
		ls_return +="				<reportElement x='" + string(ll_x) + "' y='" + string(ll_y) + "' width='" + string(ll_width - ll_x) + "' height='" + string(1) + "' uuid='9e17210d-" + string(Rand(9999), "0000") + "-" + string(Rand(9999), "0000") + "-9e26-b9b2573c40cd'/>" + is_crlf
elseif  ll_x = ll_width then //senkrechte Linie
	
		ls_return +="				<reportElement x='" + string(ll_x) + "' y='" + string(ll_y) + "' width='" + string(1) + "' height='" + string(ll_height - ll_y) + "' uuid='9e17210d-" + string(Rand(9999), "0000") + "-" + string(Rand(9999), "0000") + "-9e26-b9b2573c40cd'/>" + is_crlf
end if


ls_return +="	</line>" + is_crlf

return ls_return


end function

public function string of_create_rectangle (datastore adw_ref, string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_rectangle (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datastore adw_ref
//	 string as_object
//
// Beschreibung:		create a rectangle object
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

string	ls_return
string	ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic, ls_column
Long		ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border
Long		ll_BackGroundMode, ll_BackGroundColour


ll_x = Long(adw_ref.Describe(as_Object + ".x"))
ll_y = Long(adw_ref.Describe(as_Object + ".y"))
ll_height = (Long(adw_ref.Describe(as_Object + ".height")) )
ll_width = (Long(adw_ref.Describe(as_Object + ".width")) )

If ll_width < 0 OR ll_height < 0 Then
	//lb_Breakpoint = TRUE
	return ""
End If

ls_return ="			<rectangle>" + is_crlf

ll_BackGroundMode = Long(adw_ref.Describe(as_Object + ".Background.Mode"))
if ll_BackGroundMode <> 1 then 
	ll_BackGroundColour = Long(adw_ref.Describe(as_Object + ".Background.color"))
	ll_BackGroundColour = rgb(200,200,200)
	ls_return += "<reportElement mode='Opaque' x='" + string(ll_x) + "' y='" + string(ll_y)+ "' width='" + string(ll_width) + "' height='" + string(ll_height) + "' " 
	ls_return += " backcolor='#C8C8C8' " 
	ls_return += 			"uuid='" + string(Rand(9999), "0000") + "-" +  string(Rand(9999), "0000") + "-49bd-8b0c-157e72d1978c'/>"+ is_crlf
	
Else
	ls_return += "<reportElement mode='Transparent' x='" + string(ll_x) + "' y='" + string(ll_y)+ "' width='" + string(ll_width) + "' height='" + string(ll_height) + "' uuid='" + string(Rand(9999), "0000") + "-" +  string(Rand(9999), "0000") + "-49bd-8b0c-157e72d1978c'/>"+ is_crlf
	
End If

ls_return +="		</rectangle>" + is_crlf

return ls_return

end function

public function string of_create_round_rect (datastore adw_ref, string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_round_rect (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datastore adw_ref
//	 string as_object
//
// Beschreibung:		create round rect (Cart Diagram "Wheels")
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

string	ls_return
string	ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic, ls_column
Long		ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border


ll_x = Long(adw_ref.Describe(as_Object + ".x"))
ll_y = Long(adw_ref.Describe(as_Object + ".y"))
ll_height = (Long(adw_ref.Describe(as_Object + ".height")) )
ll_width = (Long(adw_ref.Describe(as_Object + ".width")) )

If ll_width < 0 OR ll_height < 0 Then
	//lb_Breakpoint = TRUE
	return ""
End If

ls_return = '<rectangle radius="5">' + is_crlf
ls_return += '	<reportElement x="'+ string(ll_x) + '" y="' + string(ll_y) +'" width="'+ string(ll_width) + '" height="'+ string(ll_height) + '"'
ls_return += ' forecolor="#646464" backcolor="#646464" uuid="abdfb14f-1f34-4368-8327-e41f975bfc91">' + is_crlf
ls_return += '		<property name="com.jaspersoft.studio.unit.height" value="pixel"/>' + is_crlf
ls_return +="		</reportElement>" + is_crlf
ls_return +="		</rectangle>" + is_crlf

return ls_return

end function

public function string of_create_static_text (datastore adw_ref, string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_static_text (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datastore adw_ref
//	 string as_object
//
// Beschreibung:		Create a Static Text Object
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------


Long		ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border
Long		ll_BackGroundMode, ll_BackGroundColour
String	ls_Error, ls_Temp
string	ls_return, ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic
Boolean	lb_Watermark = FALSE
Boolean	lb_Breakpoint = FALSE


If pos(as_object , "watermark") > 0 OR pos(as_object , "t_wtrmrk_dwnln") > 0 then
	lb_Breakpoint = TRUE
	lb_Watermark = TRUE
End If

ll_x = Long(adw_ref.Describe(as_Object + ".x"))
ll_y = Long(adw_ref.Describe(as_Object + ".y"))
ll_height = (Long(adw_ref.Describe(as_Object + ".height")) )
ll_width = (Long(adw_ref.Describe(as_Object + ".width")) )

If ll_width < 0 OR ll_height < 0 Then
	lb_Breakpoint = TRUE
	return ""
End If

ll_x = of_convert_pixels( ll_x )
ll_y = of_convert_pixels( ll_y )
ll_width = of_convert_pixels( ll_width )
ll_height = of_convert_pixels( ll_height )


If ll_width + ll_x > il_detail_width OR ll_height + ll_y > il_Detail_Height Then
	lb_Breakpoint = TRUE
	return ""
End If


ll_height += 2

ll_border 		= Long(adw_ref.Describe(as_Object + ".Border")) 
ls_Fontname 	= adw_ref.Describe(as_Object + ".font.face") 

If ib_Replace_Font_With_Arial Then
	//f_trace("Font: " + ls_Fontname + " => Arial" )
	ls_Fontname = "Arial"
End If

ll_fontsize 	= Long(adw_ref.Describe(as_Object + ".font.height")) 

if abs(ll_fontsize) > 170 then
	ll_fontsize = 170
end if 

if ll_fontsize < 0 then ll_fontsize = ll_fontsize * -1
ll_fontweight 	= Long(adw_ref.Describe(as_Object + ".font.weight")) 
ll_align 			= Long(adw_ref.Describe(as_Object + ".alignment")) 
ll_underline 		= Long(adw_ref.Describe(as_Object + ".font.underline")) 
ll_italic 			= Long(adw_ref.Describe(as_Object + ".Font.Italic")) 
ls_text 			= adw_ref.Describe(as_Object + ".text") 

// $$HEX1$$1920$$ENDHEX$$
ls_text = f_replace(ls_text, "$$HEX1$$1920$$ENDHEX$$", "'")

ls_text = f_replace(ls_text, "$$HEX1$$1320$$ENDHEX$$", "-")

ls_text = f_replace(ls_text, "$$HEX1$$c900$$ENDHEX$$", "E")

ls_text = f_replace(ls_text, "$$HEX1$$e900$$ENDHEX$$", "e")

// $$HEX1$$d700$$ENDHEX$$
ls_text = f_replace(ls_text, "$$HEX1$$d700$$ENDHEX$$", "x")

//ls_text = f_replace(ls_text, "$$HEX1$$c900$$ENDHEX$$", "E")

//ls_text = f_replace(ls_text, '"', "")

ls_text = f_replace(ls_text, '$$HEX1$$1c20$$ENDHEX$$', '"')

ls_text = f_replace(ls_text, '$$HEX1$$1d20$$ENDHEX$$', '"')

//$$HEX2$$1c201d20$$ENDHEX$$

ls_return = "					<staticText>" + is_crlf
If lb_Watermark then
	ls_return += "				<reportElement x='" + String(ll_x) + "' y='" + String(ll_y) + "' width='" + String(ll_width) + &
								"' height='" + String(ll_height) + "' forecolor='#C8C8C8' " +  &
								" uuid='092d53ea-" + string(Rand(9999), "0000") + "-40a3-a9d6-" + string(cpu()) + "'/>" + is_crlf
	
Else

	ls_return += "				<reportElement "

	ll_BackGroundMode = Long(adw_ref.Describe(as_Object + ".Background.Mode"))
	if ll_BackGroundMode <> 1 then 
		ll_BackGroundColour = Long(adw_ref.Describe(as_Object + ".Background.color"))
		
		ll_BackGroundColour = rgb(200,200,200)
		
		ls_Temp = (adw_ref.Describe(as_Object + ".Background.color"))
		
		If pos(ls_Temp, "~t") > 0 then
			ls_Temp = mid(ls_Temp, pos(ls_Temp, "~t") + 1) 
			if right(ls_Temp, 1) = '"' or right(ls_Temp, 1) = "'" Then
				ls_Temp = left(ls_Temp, len(ls_Temp) -1)
			End If
		
			ls_error = (adw_ref.Describe("evaluate(' " + ls_Temp) + "', 0)")
			
			ls_Temp = "evaluate('" + ls_Temp + "', 0)"
			ls_error = 	adw_ref.Describe(ls_Temp)
		Else
			If isnumber(ls_Temp) then
				ll_BackGroundColour = long(ls_Temp)
			end if
			
		End If
		ll_BackGroundColour = rgb(200,200,200)
		ls_return += ' mode="Opaque" backcolor="#C8C8C8" '
	end if
	ls_return += "	x='" + String(ll_x) + "' y='" + String(ll_y) + "' width='" + String(ll_width) + "' height='" + String(ll_height) + "'"
	ls_return += "	uuid='092d53ea-" + string(Rand(9999), "0000") + "-40a3-a9d6-" + string(cpu()) + "'/>"+ is_crlf

end if

if ll_border <> 0 then
	ls_return += "				<box padding='2' topPadding='0' leftPadding='0' bottomPadding='0' rightPadding='0'>"+ is_crlf
	ls_return += "					<topPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>"+ is_crlf
	ls_return += "					<leftPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>"+ is_crlf
	ls_return += "					<bottomPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>"+ is_crlf
	ls_return += "					<rightPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>"+ is_crlf
	ls_return += "				</box>"+ is_crlf
end if

Choose case ll_align
	case 0
		ls_alignment = "Left"
	case 1
		ls_alignment = "Right"
	case 2
		ls_alignment = "Center"
	case else
		ls_alignment = ""
end choose

if ll_fontweight = 700 then
	ls_bold = "true"
else
	ls_bold = "false"
end if

if ll_italic = 1 then
	ls_italic = "true"
else
	ls_italic = "false"
end if

if ll_underline = 1 then
	ls_underline = "true"
else
	ls_underline = "false"
end if

If ll_fontsize < 80 then
	ls_return += "				<textElement textAlignment='" + ls_alignment+ "'>" + is_crlf
Else
	ls_return += "				<textElement textAlignment='" + ls_alignment+ "' verticalAlignment='Middle'>" + is_crlf
End If

ls_return += "					<font fontName='" + ls_Fontname + "' size='" + String(ll_fontsize) + "' isBold='" + ls_bold + "' isItalic='" + ls_italic + "' isUnderline='" + ls_underline + "'/>"+ is_crlf
ls_return += "				</textElement>"+ is_crlf
ls_return += "				<text><![CDATA[" + ls_text + "]]></text>"+ is_crlf
ls_return += "			</staticText>"+ is_crlf

return ls_return 

end function

public function string of_create_query_empty ();
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_query_empty (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// none
//
// Beschreibung:		Empty Dummy select - alles zeichnen, nichts aus Datenbank holen
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

String	ls_return

ls_return += '<queryString>'                  + is_crlf
ls_return += '<![CDATA[Select 1 From dual]]>' + is_crlf
ls_return += '</queryString>'                 + is_crlf

return ls_return 
end function

public function string of_create_compute (datastore adw_ref, string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_compute (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datastore adw_ref
//	 string as_object
//
// Beschreibung:		Translate Compted Field ("Today") to Jasper Compute
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

string	ls_return
string	ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic, ls_column
Long		ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border


ll_x = Long(adw_ref.Describe(as_Object + ".x"))
ll_y = Long(adw_ref.Describe(as_Object + ".y"))
ll_height = (Long(adw_ref.Describe(as_Object + ".height")) )
ll_width = (Long(adw_ref.Describe(as_Object + ".width")) )

if as_object	= "compute_report_run_date" then
	
	ls_return  = '<textField pattern="dd.MM.yyyy HH:mm:ss ">' + is_crlf
	ls_return += "	<reportElement mode='Transparent' x='" + string(ll_x) + "' y='" + string(ll_y)+ "' width='" + string(ll_width) + "' height='" + string(ll_height) + "' uuid='" + string(Rand(9999), "0000") + "-" +  string(Rand(9999), "0000") + "-49bd-8b0c-157e72d1978c'/>" + is_crlf
	ls_return += '	<textElement>' + is_crlf
	ls_return += '		<font fontName="Arial" size="6"/>' + is_crlf
	ls_return += '	</textElement>' + is_crlf
	ls_return += '	<textFieldExpression><![CDATA[new java.util.Date()]]></textFieldExpression>' + is_crlf
	ls_return += '</textField>	' + is_crlf
	
End If

return ls_return

end function

public function string of_create_compute (datawindow adw_ref, string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_compute (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datawindow adw_ref
//	 string as_object
//
// Beschreibung:		Create a japser computed field for DataWindow "Today"
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

string	ls_return
string	ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic, ls_column
Long		ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border


ll_x = Long(adw_ref.Describe(as_Object + ".x"))
ll_y = Long(adw_ref.Describe(as_Object + ".y"))
ll_height = (Long(adw_ref.Describe(as_Object + ".height")) )
ll_width = (Long(adw_ref.Describe(as_Object + ".width")) )

ll_x = of_convert_pixels( ll_x )
ll_y = of_convert_pixels( ll_y )
ll_width = of_convert_pixels( ll_width )
ll_height = of_convert_pixels( ll_height )

If ll_width < 0 OR ll_height < 0 Then
	//lb_Breakpoint = TRUE
	return ""
End If

if as_object	= "compute_report_run_date" then
	
	ls_return  = '<textField pattern="dd.MM.yyyy HH:mm:ss ">' + is_crlf
	ls_return += "	<reportElement mode='Transparent' x='" + string(ll_x) + "' y='" + string(ll_y)+ "' width='" + string(ll_width) + "' height='" + string(ll_height) + "' uuid='" + string(Rand(9999), "0000") + "-" +  string(Rand(9999), "0000") + "-49bd-8b0c-157e72d1978c'/>"+ is_crlf
	ls_return += '	<textElement>' + is_crlf
	ls_return += '			<font fontName="Arial" size="6"/>' + is_crlf
	ls_return += '	</textElement>' + is_crlf
	ls_return += '	<textFieldExpression><![CDATA[new java.util.Date()]]></textFieldExpression>' + is_crlf
	ls_return += '</textField>	' + is_crlf
	
End If


return ls_return

end function

public function string of_create_sub_componentlist (string as_filename);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_sub_componentlist (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 09.03.2017
//
// Argument(e):
// string as_filename
//
// Beschreibung:		SubReport Components
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	09.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

String	ls_XML
Integer	li_File
Long		ll_Bytes
Integer	li_Succ


ls_XML += '<?xml version="1.0" encoding="UTF-8"?>'
ls_XML += '<!-- Created with Jaspersoft Studio version 6.3.0.final using JasperReports Library version 6.3.0  -->'
ls_XML += '<!-- 2017-04-07T08:01:53 -->'
ls_XML += '<jasperReport xmlns="http://jasperreports.sourceforge.net/jasperreports" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd" name="Sub_Components_V01" pageWidth="190" pageHeight="599" columnWidth="180" leftMargin="1" rightMargin="1" topMargin="1" bottomMargin="1" uuid="a311ffe9-4f1f-4335-beb7-9be174f3c7e7">'
ls_XML += '	<property name="com.jaspersoft.studio.data.sql.tables" value=""/>'
ls_XML += '	<property name="com.jaspersoft.studio.data.defaultdataadapter" value="MAINTUS"/>'
ls_XML += '	<property name="com.jaspersoft.studio.unit." value="pixel"/>'
ls_XML += '	<property name="com.jaspersoft.studio.unit.pageHeight" value="cm"/>'
ls_XML += '	<property name="com.jaspersoft.studio.unit.pageWidth" value="cm"/>'
ls_XML += '	<parameter name="arg_result_key" class="java.lang.Long"/>'
ls_XML += '	<parameter name="arg_stowage" class="java.lang.String"/>'
ls_XML += '	<queryString>'
ls_XML += '		<![CDATA[Select co.cairline, co.ddeparture, co.nflight_number,xx.cstowage, md.*'
ls_XML += '  From cen_out co, cen_out_md_co md, cen_out_md xx'
ls_XML += ' Where co.nresult_key = md.nresult_key'
ls_XML += '   And co.ntransaction = md.ntransaction'
ls_XML += '   and co.nresult_key = xx.nresult_key'
ls_XML += '   And co.ntransaction = xx.ntransaction'
ls_XML += '   and xx.narray_count = md.narray_count'
ls_XML += '   And co.nresult_key =    $P{arg_result_key} '
ls_XML += '   and trim(xx.cstowage) =  $P{arg_stowage}]]>'
ls_XML += '	</queryString>'
ls_XML += '	<field name="CPACKINGLIST" class="java.lang.String"/>'
ls_XML += '	<field name="NQUANTITY" class="java.math.BigDecimal"/>'
ls_XML += '	<field name="CTEXT" class="java.lang.String"/>'
ls_XML += '	<sortField name="CPACKINGLIST"/>'
ls_XML += '	<group name="CPACKINGLIST">'
ls_XML += '		<groupExpression><![CDATA[$F{CPACKINGLIST}]]></groupExpression>'
ls_XML += '	</group>'
ls_XML += '	<group name="NQUANTITY">'
ls_XML += '		<groupExpression><![CDATA[$F{NQUANTITY}]]></groupExpression>'
ls_XML += '	</group>'
ls_XML += '	<group name="CTEXT">'
ls_XML += '		<groupExpression><![CDATA[$F{CTEXT}]]></groupExpression>'
ls_XML += '	</group>'
ls_XML += '	<background>'
ls_XML += '		<band splitType="Stretch"/>'
ls_XML += '	</background>'
ls_XML += '	<title>'
ls_XML += '		<band splitType="Stretch"/>'
ls_XML += '	</title>'
ls_XML += '	<pageHeader>'
ls_XML += '		<band height="16" splitType="Stretch">'
ls_XML += '			<textField>'
ls_XML += '				<reportElement x="0" y="0" width="100" height="14" uuid="4156248c-690f-4e89-8311-8e69bd3bc4fe">'
ls_XML += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>'
ls_XML += '				</reportElement>'
ls_XML += '				<textFieldExpression><![CDATA["Meal Components"]]></textFieldExpression>'
ls_XML += '			</textField>'
ls_XML += '		</band>'
ls_XML += '	</pageHeader>'
ls_XML += '	<columnHeader>'
ls_XML += '		<band splitType="Stretch"/>'
ls_XML += '	</columnHeader>'
ls_XML += '	<detail>'
ls_XML += '		<band height="26" splitType="Prevent">'
ls_XML += '			<textField>'
ls_XML += '				<reportElement x="3" y="0" width="27" height="24" uuid="d35ae247-fdf2-445b-a819-7a4f1f293f1d">'
ls_XML += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>'
ls_XML += '				</reportElement>'
ls_XML += '				<textElement>'
ls_XML += '					<font fontName="Arial" size="18"/>'
ls_XML += '				</textElement>'
ls_XML += '				<textFieldExpression><![CDATA[$F{NQUANTITY}]]></textFieldExpression>'
ls_XML += '			</textField>'
ls_XML += '			<textField>'
ls_XML += '				<reportElement mode="Transparent" x="33" y="11" width="156" height="14" backcolor="#0099FF" uuid="34c16169-d405-4981-bce7-56b3ca249d11">'
ls_XML += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>'
ls_XML += '				</reportElement>'
ls_XML += '				<textFieldExpression><![CDATA[$F{CTEXT}]]></textFieldExpression>'
ls_XML += '			</textField>'
ls_XML += '			<textField>'
ls_XML += '				<reportElement mode="Transparent" x="33" y="0" width="149" height="14" backcolor="#FF9933" uuid="62017005-26f3-49a9-8ce5-cbdc37b1916b">'
ls_XML += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>'
ls_XML += '					<property name="com.jaspersoft.studio.unit.x" value="pixel"/>'
ls_XML += '				</reportElement>'
ls_XML += '				<textFieldExpression><![CDATA[$F{CPACKINGLIST}]]></textFieldExpression>'
ls_XML += '			</textField>'
ls_XML += '		</band>'
ls_XML += '	</detail>'
ls_XML += '	<columnFooter>'
ls_XML += '		<band splitType="Stretch"/>'
ls_XML += '	</columnFooter>'
ls_XML += '	<pageFooter>'
ls_XML += '		<band splitType="Stretch"/>'
ls_XML += '	</pageFooter>'
ls_XML += '	<summary>'
ls_XML += '		<band splitType="Stretch"/>'
ls_XML += '	</summary>'
ls_XML += '</jasperReport>'



//ls_XML += '<?xml version="1.0" encoding="UTF-8"?>' + is_crlf
//ls_XML += '<!-- Created with Jaspersoft Studio version 6.3.0.final using JasperReports Library version 6.3.0  -->' + is_crlf
//ls_XML += '<!-- 2017-03-09T10:45:45 -->' + is_crlf
//ls_XML += '<jasperReport xmlns="http://jasperreports.sourceforge.net/jasperreports" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd" name="Sub_Components_V01" pageWidth="198" pageHeight="566" columnWidth="196" leftMargin="1" rightMargin="1" topMargin="1" bottomMargin="1" uuid="a311ffe9-4f1f-4335-beb7-9be174f3c7e7">' + is_crlf
//ls_XML += '<property name="com.jaspersoft.studio.data.sql.tables" value=""/>' + is_crlf
//ls_XML += '<property name="com.jaspersoft.studio.data.defaultdataadapter" value="MAINTUS"/>' + is_crlf
//ls_XML += '<property name="com.jaspersoft.studio.unit." value="pixel"/>' + is_crlf
//ls_XML += '<property name="com.jaspersoft.studio.unit.pageHeight" value="cm"/>' + is_crlf
//ls_XML += '<property name="com.jaspersoft.studio.unit.pageWidth" value="cm"/>' + is_crlf
//ls_XML += '<parameter name="arg_result_key" class="java.lang.Long"/>' + is_crlf
//ls_XML += '<parameter name="arg_stowage" class="java.lang.String"/>' + is_crlf
//ls_XML += '<queryString>' + is_crlf
//ls_XML += '<![CDATA[Select co.cairline, co.ddeparture, co.nflight_number,xx.cstowage, md.*' + is_crlf
//ls_XML += 'From cen_out co, cen_out_md_co md, cen_out_md xx' + is_crlf
//ls_XML += 'Where co.nresult_key = md.nresult_key' + is_crlf
//ls_XML += 'And co.ntransaction = md.ntransaction' + is_crlf
//ls_XML += 'and co.nresult_key = xx.nresult_key' + is_crlf
//ls_XML += 'And co.ntransaction = xx.ntransaction' + is_crlf
//ls_XML += 'and xx.narray_count = md.narray_count' + is_crlf
//ls_XML += 'And co.nresult_key =    $P{arg_result_key} ' + is_crlf
//ls_XML += 'and trim(xx.cstowage) =  $P{arg_stowage}]]>' + is_crlf
//ls_XML += '</queryString>' + is_crlf
//ls_XML += '<field name="CPACKINGLIST" class="java.lang.String"/>' + is_crlf
//ls_XML += '<field name="NQUANTITY" class="java.math.BigDecimal"/>' + is_crlf
//ls_XML += '<field name="CTEXT" class="java.lang.String"/>' + is_crlf
//ls_XML += '<sortField name="CPACKINGLIST"/>' + is_crlf
//ls_XML += '<group name="CPACKINGLIST">' + is_crlf
//ls_XML += '<groupExpression><![CDATA[$F{CPACKINGLIST}]]></groupExpression>' + is_crlf
//ls_XML += '</group>' + is_crlf
//ls_XML += '<group name="NQUANTITY">' + is_crlf
//ls_XML += '<groupExpression><![CDATA[$F{NQUANTITY}]]></groupExpression>' + is_crlf
//ls_XML += '</group>' + is_crlf
//ls_XML += '<group name="CTEXT">' + is_crlf
//ls_XML += '<groupExpression><![CDATA[$F{CTEXT}]]></groupExpression>' + is_crlf
//ls_XML += '</group>' + is_crlf
////ls_XML += '<background>' + is_crlf
////ls_XML += '<band splitType="Stretch"/>' + is_crlf
////ls_XML += '</background>' + is_crlf
//ls_XML += '<title>' + is_crlf
//ls_XML += '<band splitType="Stretch"/>' + is_crlf
//ls_XML += '</title>' + is_crlf
//ls_XML += '<pageHeader>' + is_crlf
//ls_XML += '<band height="23" splitType="Stretch">' + is_crlf
//ls_XML += '<textField>' + is_crlf
//ls_XML += '<reportElement x="0" y="6" width="100" height="14" uuid="4156248c-690f-4e89-8311-8e69bd3bc4fe"/>' + is_crlf
//ls_XML += '<textFieldExpression><![CDATA["Meal Components"]]></textFieldExpression>' + is_crlf
//ls_XML += '</textField>' + is_crlf
//ls_XML += '</band>' + is_crlf
//ls_XML += '</pageHeader>' + is_crlf
//ls_XML += '<columnHeader>' + is_crlf
//ls_XML += '<band splitType="Stretch"/>' + is_crlf
//ls_XML += '</columnHeader>' + is_crlf
//ls_XML += '<detail>' + is_crlf
//ls_XML += '<band height="30" splitType="Stretch">' + is_crlf
//ls_XML += '<textField>' + is_crlf
//ls_XML += '<reportElement x="1" y="0" width="27" height="28" uuid="d35ae247-fdf2-445b-a819-7a4f1f293f1d">' + is_crlf
//ls_XML += '<textElement>' + is_crlf
//ls_XML += '<font fontName="Arial" size="18"/>' + is_crlf
//ls_XML += '</textElement>' + is_crlf
//ls_XML += '<textFieldExpression><![CDATA[$F{NQUANTITY}]]></textFieldExpression>' + is_crlf
//ls_XML += '</textField>' + is_crlf
//ls_XML += '<textField>' + is_crlf
//ls_XML += '<reportElement x="40" y="13" width="156" height="16" uuid="34c16169-d405-4981-bce7-56b3ca249d11"/>' + is_crlf
////<reportElement x="41" y="13" width="156" height="16" uuid="34c16169-d405-4981-bce7-56b3ca249d11"/>
//ls_XML += '<textFieldExpression><![CDATA[$F{CTEXT}]]></textFieldExpression>' + is_crlf
//ls_XML += '</textField>' + is_crlf
//ls_XML += '<textField>' + is_crlf
//ls_XML += '<reportElement x="41" y="2" width="149" height="14" uuid="62017005-26f3-49a9-8ce5-cbdc37b1916b"/>' + is_crlf
////<reportElement x="41" y="2" width="149" height="14" uuid="62017005-26f3-49a9-8ce5-cbdc37b1916b"/>
//ls_XML += '<textFieldExpression><![CDATA[$F{CPACKINGLIST}]]></textFieldExpression>' + is_crlf
//ls_XML += '</textField>' + is_crlf
//ls_XML += '</band>' + is_crlf
//ls_XML += '</detail>' + is_crlf
//ls_XML += '</jasperReport>' + is_crlf
//

//<?xml version="1.0" encoding="UTF-8"?>
//<!-- Created with Jaspersoft Studio version 6.3.0.final using JasperReports Library version 6.3.0  -->
//<!-- 2017-03-20T11:58:14 -->
//<jasperReport xmlns="http://jasperreports.sourceforge.net/jasperreports" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd" name="Sub_Components_V01" pageWidth="198" pageHeight="566" columnWidth="196" leftMargin="1" rightMargin="1" topMargin="1" bottomMargin="1" uuid="a311ffe9-4f1f-4335-beb7-9be174f3c7e7">
//	<property name="com.jaspersoft.studio.data.sql.tables" value=""/>
//	<property name="com.jaspersoft.studio.data.defaultdataadapter" value="MAINTUS"/>
//	<property name="com.jaspersoft.studio.unit." value="pixel"/>
//	<property name="com.jaspersoft.studio.unit.pageHeight" value="cm"/>
//	<property name="com.jaspersoft.studio.unit.pageWidth" value="cm"/>
//	<parameter name="arg_result_key" class="java.lang.Long"/>
//	<parameter name="arg_stowage" class="java.lang.String"/>
//	<queryString>
//		<![CDATA[Select co.cairline, co.ddeparture, co.nflight_number,xx.cstowage, md.*
//From cen_out co, cen_out_md_co md, cen_out_md xx
//Where co.nresult_key = md.nresult_key
//And co.ntransaction = md.ntransaction
//and co.nresult_key = xx.nresult_key
//And co.ntransaction = xx.ntransaction
//and xx.narray_count = md.narray_count
//And co.nresult_key =    $P{arg_result_key} 
//and trim(xx.cstowage) =  $P{arg_stowage}]]>
//	</queryString>
//	<field name="CPACKINGLIST" class="java.lang.String"/>
//	<field name="NQUANTITY" class="java.math.BigDecimal"/>
//	<field name="CTEXT" class="java.lang.String"/>
//	<sortField name="CPACKINGLIST"/>
//	<group name="CPACKINGLIST">
//		<groupExpression><![CDATA[$F{CPACKINGLIST}]]></groupExpression>
//	</group>
//	<group name="NQUANTITY">
//		<groupExpression><![CDATA[$F{NQUANTITY}]]></groupExpression>
//	</group>
//	<group name="CTEXT">
//		<groupExpression><![CDATA[$F{CTEXT}]]></groupExpression>
//	</group>
//	<background>
//		<band splitType="Stretch"/>
//	</background>
//	<title>
//		<band splitType="Stretch"/>
//	</title>
//	<pageHeader>
//		<band height="23" splitType="Stretch">
//			<textField>
//				<reportElement x="0" y="6" width="100" height="14" uuid="4156248c-690f-4e89-8311-8e69bd3bc4fe"/>
//				<textFieldExpression><![CDATA["Meal Components"]]></textFieldExpression>
//			</textField>
//		</band>
//	</pageHeader>
//	<detail>
//		<band height="30">
//			<textField>
//				<reportElement x="1" y="0" width="27" height="28" uuid="d35ae247-fdf2-445b-a819-7a4f1f293f1d">
//					<property name="com.jaspersoft.studio.unit.height" value="pixel"/>
//					<property name="com.jaspersoft.studio.unit.x" value="pixel"/>
//				</reportElement>
//				<textElement>
//					<font fontName="Arial" size="18"/>
//				</textElement>
//				<textFieldExpression><![CDATA[$F{NQUANTITY}]]></textFieldExpression>
//			</textField>
//			<textField>
//				<reportElement x="41" y="13" width="156" height="16" uuid="34c16169-d405-4981-bce7-56b3ca249d11"/>
//				<textFieldExpression><![CDATA[$F{CTEXT}]]></textFieldExpression>
//			</textField>
//			<textField>
//				<reportElement x="41" y="2" width="149" height="14" uuid="62017005-26f3-49a9-8ce5-cbdc37b1916b"/>
//				<textFieldExpression><![CDATA[$F{CPACKINGLIST}]]></textFieldExpression>
//			</textField>
//		</band>
//	</detail>
//</jasperReport>

li_file  = FileOpen(as_filename  , LineMode!, Write!, LockWrite!, Replace!)
ll_Bytes = FileWriteEX(li_file, ls_XML)
li_Succ  = FileClose(li_file)


Return ls_XML

end function

public function string of_create_ellipse (datastore adw_ref, string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_ellipse (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datastore adw_ref
//	 string as_object
//
// Beschreibung:		Create ellipse (e.g. for UK Health Mark)
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

//<DW Control Name>.Modify( &
//"create ellipse(band=<Detail, Footer, Header, Header.<group #>, Summary, Trailer.<group #>, Background, Foreground>"  +  &
//" x='<an integer>' y='<an integer>' height='<an integer>' width='<an integer>' name=<string>" + &
//" tag='<string>' brush.hatch='<0 - Horiz, 1 - BDiagonal, 2 - Vertical, 3 - Cross, 4 - FDiagonal, 5 - DiagCross, 6 - Solid, 7 - Transparent>'" + &
//" brush.color='<a long>' pen.style='<0 - Solid, 1 - Dash, 2 - Dot, 3 - DashDot, 4 - DashDotDot, 5 - Null>' pen.width='<an integer>' pen.color='<a long>' background.mode='<0 - Opaque, 1 - Transparent>' background.color='<a long>')")

string		ls_return
string		ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic, ls_column
Long			ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border

//	<ellipse>
//		<reportElement mode="Transparent" x="153" y="37" width="100" height="50" uuid="770c3a60-c0e0-4d0f-83cc-c99b5f96749a"/>
//	</ellipse>

ll_x = Long(adw_ref.Describe(as_Object + ".x"))
ll_y = Long(adw_ref.Describe(as_Object + ".y"))
ll_height = (Long(adw_ref.Describe(as_Object + ".height")) )
ll_width = (Long(adw_ref.Describe(as_Object + ".width")) )

If ll_width < 0 OR ll_height < 0 Then
	//lb_Breakpoint = TRUE
	return ""
End If

ls_return  = '<ellipse>' + is_crlf
ls_return += '		<reportElement mode="Transparent" x="'+ string(ll_x) +'" y="'+ string(ll_y) + '" width="' + string(ll_width) +'" height="'+ string(ll_height) +'" uuid="770c3a60-c0e0-4d0f-83cc-c99b5f96749a"/>'
ls_return += "</ellipse>" + is_crlf

return ls_return

end function

public function string of_convert_rgb (long al_rgb);
/* 
* Function: 			of_convert_rgb
* Beschreibung: 	...
* Besonderheit: 	...
*
* Argumente:
* 		arg_name 	Beschreibung
*
* Aenderungshistorie:
* 	Version 	Wer					Wann				Was und warum
*	1.0 		Thomas Schaefer	30.03.2017		Erstellung
*
* Return Codes:
*	 ...
*/

Integer		li_red
Integer		li_green
Integer		li_blue
Long			ll_rgb_converted = 0
String			ls_color

li_blue = al_rgb / (256 * 256)
li_green = Mod(al_rgb, 256 * 256) / 256
li_red = Mod(al_rgb, 256)
ll_rgb_converted = li_red * 256 * 256 + li_green * 256 + li_blue

ls_color = "#" + of_long2hex(ll_rgb_converted, 6)

Return ls_color

end function

public function string of_long2hex (long al_number, integer ai_digit);
long ll_temp0, ll_temp1
char lc_ret

IF ai_digit > 0 THEN
   ll_temp0 = abs(al_number / (16 ^ (ai_digit - 1)))
   ll_temp1 = ll_temp0 * (16 ^ (ai_digit - 1))
   IF ll_temp0 > 9 THEN
      lc_ret = char(ll_temp0 + 55)
   ELSE
      lc_ret = char(ll_temp0 + 48)
   END IF
   RETURN lc_ret + &
          of_long2hex(al_number - ll_temp1 , ai_digit - 1)
END IF
RETURN ""

end function

public function integer of_convert_pixels (long al_pixels, integer ai_roundmode);
/* 
* Function: 			of_convert_pixels
* Beschreibung: 	...
* Besonderheit: 	...
*
* Argumente:
* 		al_pixels 				Beschreibung
*		ai_roundmode		0: Cut, 1: Kaufm$$HEX1$$e400$$ENDHEX$$nnisch, 2:Ceiling
*
* Aenderungshistorie:
* 	Version 	Wer					Wann				Was und warum
*	1.0 		Thomas Schaefer	29.03.2017		Erstellung
*
* Return Codes:
*	 ...
*/
Decimal	ldc_pixels

//ldc_pixels = al_pixels * 3 / 4

ldc_pixels = al_pixels * id_Pixel_Factor


CHOOSE CASE ai_roundmode
	CASE 0
		ldc_pixels = Long(ldc_pixels)
	CASE 2
		ldc_pixels = Ceiling(ldc_pixels)
	CASE ELSE
		ldc_pixels = Round(ldc_pixels, ai_roundmode)
END CHOOSE

Return ldc_pixels

end function

public function integer of_convert_pixels (long al_pixels);

return of_convert_pixels( al_pixels, 0)
end function

public function string of_create_sub_components (string as_filename);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_sub_componentlist (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 09.03.2017
//
// Argument(e):
// string as_filename
//
// Beschreibung:		SubReport Components
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	09.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

String	ls_XML
Integer	li_File
Long		ll_Bytes
Integer	li_Succ


ls_XML += '<?xml version="1.0" encoding="UTF-8"?>' + is_crlf
ls_XML += '<!-- Created with Jaspersoft Studio version 6.3.0.final using JasperReports Library version 6.3.0  -->' + is_crlf
ls_XML += '<!-- 2017-04-07T08:01:53 -->' + is_crlf
ls_XML += '<jasperReport xmlns="http://jasperreports.sourceforge.net/jasperreports" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd" name="Sub_Components_V01" pageWidth="190" pageHeight="599" columnWidth="180" leftMargin="1" rightMargin="1" topMargin="1" bottomMargin="1" uuid="a311ffe9-4f1f-4335-beb7-9be174f3c7e7">' + is_crlf
ls_XML += '	<property name="com.jaspersoft.studio.data.sql.tables" value=""/>' + is_crlf
ls_XML += '	<property name="com.jaspersoft.studio.data.defaultdataadapter" value="MAINTUS"/>' + is_crlf
ls_XML += '	<property name="com.jaspersoft.studio.unit." value="pixel"/>' + is_crlf
ls_XML += '	<property name="com.jaspersoft.studio.unit.pageHeight" value="cm"/>' + is_crlf
ls_XML += '	<property name="com.jaspersoft.studio.unit.pageWidth" value="cm"/>' + is_crlf
ls_XML += '	<parameter name="arg_result_key" class="java.lang.Long"/>' + is_crlf
ls_XML += '	<parameter name="arg_stowage" class="java.lang.String"/>' + is_crlf
ls_XML += '	<queryString>' + is_crlf
ls_XML += '		<![CDATA[Select co.cairline, co.ddeparture, co.nflight_number,xx.cstowage, md.*' + is_crlf
ls_XML += '  From cen_out co, cen_out_md_co md, cen_out_md xx' + is_crlf
ls_XML += ' Where co.nresult_key = md.nresult_key' + is_crlf
ls_XML += '   And co.ntransaction = md.ntransaction' + is_crlf
ls_XML += '   and co.nresult_key = xx.nresult_key' + is_crlf
ls_XML += '   And co.ntransaction = xx.ntransaction' + is_crlf
ls_XML += '   and xx.narray_count = md.narray_count' + is_crlf
ls_XML += '   And co.nresult_key =    $P{arg_result_key} ' + is_crlf
ls_XML += '   and trim(xx.cstowage) =  $P{arg_stowage}]]>' + is_crlf
ls_XML += '	</queryString>' + is_crlf
ls_XML += '	<field name="CPACKINGLIST" class="java.lang.String"/>' + is_crlf
ls_XML += '	<field name="NQUANTITY" class="java.math.BigDecimal"/>' + is_crlf
ls_XML += '	<field name="CTEXT" class="java.lang.String"/>' + is_crlf
ls_XML += '	<sortField name="CPACKINGLIST"/>' + is_crlf
ls_XML += '	<group name="CPACKINGLIST">' + is_crlf
ls_XML += '		<groupExpression><![CDATA[$F{CPACKINGLIST}]]></groupExpression>' + is_crlf
ls_XML += '	</group>' + is_crlf
ls_XML += '	<group name="NQUANTITY">' + is_crlf
ls_XML += '		<groupExpression><![CDATA[$F{NQUANTITY}]]></groupExpression>' + is_crlf
ls_XML += '	</group>' + is_crlf
ls_XML += '	<group name="CTEXT">' + is_crlf
ls_XML += '		<groupExpression><![CDATA[$F{CTEXT}]]></groupExpression>' + is_crlf
ls_XML += '	</group>' + is_crlf
ls_XML += '	<background>' + is_crlf
ls_XML += '		<band splitType="Stretch"/>' + is_crlf
ls_XML += '	</background>' + is_crlf
ls_XML += '	<title>' + is_crlf
ls_XML += '		<band splitType="Stretch"/>' + is_crlf
ls_XML += '	</title>' + is_crlf
ls_XML += '	<pageHeader>' + is_crlf
ls_XML += '		<band height="16" splitType="Stretch">' + is_crlf
ls_XML += '			<textField>' + is_crlf
ls_XML += '				<reportElement x="0" y="0" width="100" height="14" uuid="4156248c-690f-4e89-8311-8e69bd3bc4fe">' + is_crlf
ls_XML += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>' + is_crlf
ls_XML += '				</reportElement>' + is_crlf
ls_XML += '				<textElement>' + is_crlf
ls_XML += '					<font fontName="Arial" size="8"/>' + is_crlf
ls_XML += '				</textElement>' + is_crlf
ls_XML += '				<textFieldExpression><![CDATA["Meal Components"]]></textFieldExpression>' + is_crlf
ls_XML += '			</textField>' + is_crlf
ls_XML += '		</band>' + is_crlf
ls_XML += '	</pageHeader>' + is_crlf

//ls_XML += '	<columnHeader>'
//ls_XML += '		<band splitType="Stretch"/>'
//ls_XML += '	</columnHeader>'

 ls_XML += '<detail>'  + is_crlf
 ls_XML += '		<band height="26" splitType="Prevent">' + is_crlf
 ls_XML += '			<textField>' + is_crlf
 ls_XML += '				<reportElement x="3" y="0" width="27" height="24" uuid="d35ae247-fdf2-445b-a819-7a4f1f293f1d">' + is_crlf
 ls_XML += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>' + is_crlf
 ls_XML += '				</reportElement>' + is_crlf
 ls_XML += '				<textElement>' + is_crlf
 ls_XML += '					<font fontName="Arial" size="18"/>' + is_crlf
 ls_XML += '				</textElement>' + is_crlf
 ls_XML += '				<textFieldExpression><![CDATA[$F{NQUANTITY}]]></textFieldExpression>' + is_crlf
 ls_XML += '			</textField>' + is_crlf
 ls_XML += '			<textField>' + is_crlf
 ls_XML += '				<reportElement mode="Transparent" x="33" y="11" width="156" height="14" backcolor="#0099FF" uuid="34c16169-d405-4981-bce7-56b3ca249d11">' + is_crlf
 ls_XML += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>' + is_crlf
 ls_XML += '				</reportElement>' + is_crlf
 ls_XML += '				<textElement>' + is_crlf
 ls_XML += '					<font fontName="Arial" size="8"/>' + is_crlf
 ls_XML += '				</textElement>' + is_crlf
 ls_XML += '				<textFieldExpression><![CDATA[$F{CTEXT}]]></textFieldExpression>' + is_crlf
 ls_XML += '			</textField>' + is_crlf
 ls_XML += '			<textField>' + is_crlf
 ls_XML += '				<reportElement mode="Transparent" x="33" y="0" width="149" height="14" backcolor="#FF9933" uuid="62017005-26f3-49a9-8ce5-cbdc37b1916b">' + is_crlf
 ls_XML += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>' + is_crlf
 ls_XML += '					<property name="com.jaspersoft.studio.unit.x" value="pixel"/>' + is_crlf
 ls_XML += '				</reportElement>' + is_crlf
 ls_XML += '				<textElement>' + is_crlf
 ls_XML += '					<font fontName="Arial" size="8"/>' + is_crlf
 ls_XML += '				</textElement>' + is_crlf
 ls_XML += '				<textFieldExpression><![CDATA[$F{CPACKINGLIST}]]></textFieldExpression>' + is_crlf
 ls_XML += '			</textField>' + is_crlf
 ls_XML += '		</band>' + is_crlf
 ls_XML += '	</detail>' + is_crlf
ls_XML += "</jasperReport>" + is_crlf


//ls_XML += '	<detail>'
//ls_XML += '		<band height="26" splitType="Prevent">'
//ls_XML += '			<textField>'
//ls_XML += '				<reportElement x="3" y="0" width="27" height="24" uuid="d35ae247-fdf2-445b-a819-7a4f1f293f1d">'
//ls_XML += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>'
//ls_XML += '				</reportElement>'
//ls_XML += '				<textElement>'
//ls_XML += '					<font fontName="Arial" size="18"/>'
//ls_XML += '				</textElement>'
//ls_XML += '				<textFieldExpression><![CDATA[$F{NQUANTITY}]]></textFieldExpression>'
//ls_XML += '			</textField>'
//ls_XML += '			<textField>'
//ls_XML += '				<reportElement mode="Transparent" x="33" y="11" width="156" height="14" backcolor="#0099FF" uuid="34c16169-d405-4981-bce7-56b3ca249d11">'
//ls_XML += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>'
//ls_XML += '				</reportElement>'
//ls_XML += '				<textFieldExpression><![CDATA[$F{CTEXT}]]></textFieldExpression>'
//ls_XML += '			</textField>'
//ls_XML += '			<textField>'
//ls_XML += '				<reportElement mode="Transparent" x="33" y="0" width="149" height="14" backcolor="#FF9933" uuid="62017005-26f3-49a9-8ce5-cbdc37b1916b">'
//ls_XML += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>'
//ls_XML += '					<property name="com.jaspersoft.studio.unit.x" value="pixel"/>'
//ls_XML += '				</reportElement>'
//ls_XML += '				<textFieldExpression><![CDATA[$F{CPACKINGLIST}]]></textFieldExpression>'
//ls_XML += '			</textField>'
//ls_XML += '		</band>'
//ls_XML += '	</detail>'
//ls_XML += '	<columnFooter>'
//ls_XML += '		<band splitType="Stretch"/>'
//ls_XML += '	</columnFooter>'
//ls_XML += '	<pageFooter>'
//ls_XML += '		<band splitType="Stretch"/>'
//ls_XML += '	</pageFooter>'
//ls_XML += '	<summary>'
//ls_XML += '		<band splitType="Stretch"/>'
//ls_XML += '	</summary>'
//ls_XML += '</jasperReport>'
//


//ls_XML += '<?xml version="1.0" encoding="UTF-8"?>' + is_crlf
//ls_XML += '<!-- Created with Jaspersoft Studio version 6.3.0.final using JasperReports Library version 6.3.0  -->' + is_crlf
//ls_XML += '<!-- 2017-03-09T10:45:45 -->' + is_crlf
//ls_XML += '<jasperReport xmlns="http://jasperreports.sourceforge.net/jasperreports" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd" name="Sub_Components_V01" pageWidth="198" pageHeight="566" columnWidth="196" leftMargin="1" rightMargin="1" topMargin="1" bottomMargin="1" uuid="a311ffe9-4f1f-4335-beb7-9be174f3c7e7">' + is_crlf
//ls_XML += '<property name="com.jaspersoft.studio.data.sql.tables" value=""/>' + is_crlf
//ls_XML += '<property name="com.jaspersoft.studio.data.defaultdataadapter" value="MAINTUS"/>' + is_crlf
//ls_XML += '<property name="com.jaspersoft.studio.unit." value="pixel"/>' + is_crlf
//ls_XML += '<property name="com.jaspersoft.studio.unit.pageHeight" value="cm"/>' + is_crlf
//ls_XML += '<property name="com.jaspersoft.studio.unit.pageWidth" value="cm"/>' + is_crlf
//ls_XML += '<parameter name="arg_result_key" class="java.lang.Long"/>' + is_crlf
//ls_XML += '<parameter name="arg_stowage" class="java.lang.String"/>' + is_crlf
//ls_XML += '<queryString>' + is_crlf
//ls_XML += '<![CDATA[Select co.cairline, co.ddeparture, co.nflight_number,xx.cstowage, md.*' + is_crlf
//ls_XML += 'From cen_out co, cen_out_md_co md, cen_out_md xx' + is_crlf
//ls_XML += 'Where co.nresult_key = md.nresult_key' + is_crlf
//ls_XML += 'And co.ntransaction = md.ntransaction' + is_crlf
//ls_XML += 'and co.nresult_key = xx.nresult_key' + is_crlf
//ls_XML += 'And co.ntransaction = xx.ntransaction' + is_crlf
//ls_XML += 'and xx.narray_count = md.narray_count' + is_crlf
//ls_XML += 'And co.nresult_key =    $P{arg_result_key} ' + is_crlf
//ls_XML += 'and trim(xx.cstowage) =  $P{arg_stowage}]]>' + is_crlf
//ls_XML += '</queryString>' + is_crlf
//ls_XML += '<field name="CPACKINGLIST" class="java.lang.String"/>' + is_crlf
//ls_XML += '<field name="NQUANTITY" class="java.math.BigDecimal"/>' + is_crlf
//ls_XML += '<field name="CTEXT" class="java.lang.String"/>' + is_crlf
//ls_XML += '<sortField name="CPACKINGLIST"/>' + is_crlf
//ls_XML += '<group name="CPACKINGLIST">' + is_crlf
//ls_XML += '<groupExpression><![CDATA[$F{CPACKINGLIST}]]></groupExpression>' + is_crlf
//ls_XML += '</group>' + is_crlf
//ls_XML += '<group name="NQUANTITY">' + is_crlf
//ls_XML += '<groupExpression><![CDATA[$F{NQUANTITY}]]></groupExpression>' + is_crlf
//ls_XML += '</group>' + is_crlf
//ls_XML += '<group name="CTEXT">' + is_crlf
//ls_XML += '<groupExpression><![CDATA[$F{CTEXT}]]></groupExpression>' + is_crlf
//ls_XML += '</group>' + is_crlf
////ls_XML += '<background>' + is_crlf
////ls_XML += '<band splitType="Stretch"/>' + is_crlf
////ls_XML += '</background>' + is_crlf
//ls_XML += '<title>' + is_crlf
//ls_XML += '<band splitType="Stretch"/>' + is_crlf
//ls_XML += '</title>' + is_crlf
//ls_XML += '<pageHeader>' + is_crlf
//ls_XML += '<band height="23" splitType="Stretch">' + is_crlf
//ls_XML += '<textField>' + is_crlf
//ls_XML += '<reportElement x="0" y="6" width="100" height="14" uuid="4156248c-690f-4e89-8311-8e69bd3bc4fe"/>' + is_crlf
//ls_XML += '<textFieldExpression><![CDATA["Meal Components"]]></textFieldExpression>' + is_crlf
//ls_XML += '</textField>' + is_crlf
//ls_XML += '</band>' + is_crlf
//ls_XML += '</pageHeader>' + is_crlf
//ls_XML += '<columnHeader>' + is_crlf
//ls_XML += '<band splitType="Stretch"/>' + is_crlf
//ls_XML += '</columnHeader>' + is_crlf
//ls_XML += '<detail>' + is_crlf
//ls_XML += '<band height="30" splitType="Stretch">' + is_crlf
//ls_XML += '<textField>' + is_crlf
//ls_XML += '<reportElement x="1" y="0" width="27" height="28" uuid="d35ae247-fdf2-445b-a819-7a4f1f293f1d">' + is_crlf
//ls_XML += '<textElement>' + is_crlf
//ls_XML += '<font fontName="Arial" size="18"/>' + is_crlf
//ls_XML += '</textElement>' + is_crlf
//ls_XML += '<textFieldExpression><![CDATA[$F{NQUANTITY}]]></textFieldExpression>' + is_crlf
//ls_XML += '</textField>' + is_crlf
//ls_XML += '<textField>' + is_crlf
//ls_XML += '<reportElement x="40" y="13" width="156" height="16" uuid="34c16169-d405-4981-bce7-56b3ca249d11"/>' + is_crlf
////<reportElement x="41" y="13" width="156" height="16" uuid="34c16169-d405-4981-bce7-56b3ca249d11"/>
//ls_XML += '<textFieldExpression><![CDATA[$F{CTEXT}]]></textFieldExpression>' + is_crlf
//ls_XML += '</textField>' + is_crlf
//ls_XML += '<textField>' + is_crlf
//ls_XML += '<reportElement x="41" y="2" width="149" height="14" uuid="62017005-26f3-49a9-8ce5-cbdc37b1916b"/>' + is_crlf
////<reportElement x="41" y="2" width="149" height="14" uuid="62017005-26f3-49a9-8ce5-cbdc37b1916b"/>
//ls_XML += '<textFieldExpression><![CDATA[$F{CPACKINGLIST}]]></textFieldExpression>' + is_crlf
//ls_XML += '</textField>' + is_crlf
//ls_XML += '</band>' + is_crlf
//ls_XML += '</detail>' + is_crlf
//ls_XML += '</jasperReport>' + is_crlf
//

//<?xml version="1.0" encoding="UTF-8"?>
//<!-- Created with Jaspersoft Studio version 6.3.0.final using JasperReports Library version 6.3.0  -->
//<!-- 2017-03-20T11:58:14 -->
//<jasperReport xmlns="http://jasperreports.sourceforge.net/jasperreports" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd" name="Sub_Components_V01" pageWidth="198" pageHeight="566" columnWidth="196" leftMargin="1" rightMargin="1" topMargin="1" bottomMargin="1" uuid="a311ffe9-4f1f-4335-beb7-9be174f3c7e7">
//	<property name="com.jaspersoft.studio.data.sql.tables" value=""/>
//	<property name="com.jaspersoft.studio.data.defaultdataadapter" value="MAINTUS"/>
//	<property name="com.jaspersoft.studio.unit." value="pixel"/>
//	<property name="com.jaspersoft.studio.unit.pageHeight" value="cm"/>
//	<property name="com.jaspersoft.studio.unit.pageWidth" value="cm"/>
//	<parameter name="arg_result_key" class="java.lang.Long"/>
//	<parameter name="arg_stowage" class="java.lang.String"/>
//	<queryString>
//		<![CDATA[Select co.cairline, co.ddeparture, co.nflight_number,xx.cstowage, md.*
//From cen_out co, cen_out_md_co md, cen_out_md xx
//Where co.nresult_key = md.nresult_key
//And co.ntransaction = md.ntransaction
//and co.nresult_key = xx.nresult_key
//And co.ntransaction = xx.ntransaction
//and xx.narray_count = md.narray_count
//And co.nresult_key =    $P{arg_result_key} 
//and trim(xx.cstowage) =  $P{arg_stowage}]]>
//	</queryString>
//	<field name="CPACKINGLIST" class="java.lang.String"/>
//	<field name="NQUANTITY" class="java.math.BigDecimal"/>
//	<field name="CTEXT" class="java.lang.String"/>
//	<sortField name="CPACKINGLIST"/>
//	<group name="CPACKINGLIST">
//		<groupExpression><![CDATA[$F{CPACKINGLIST}]]></groupExpression>
//	</group>
//	<group name="NQUANTITY">
//		<groupExpression><![CDATA[$F{NQUANTITY}]]></groupExpression>
//	</group>
//	<group name="CTEXT">
//		<groupExpression><![CDATA[$F{CTEXT}]]></groupExpression>
//	</group>
//	<background>
//		<band splitType="Stretch"/>
//	</background>
//	<title>
//		<band splitType="Stretch"/>
//	</title>
//	<pageHeader>
//		<band height="23" splitType="Stretch">
//			<textField>
//				<reportElement x="0" y="6" width="100" height="14" uuid="4156248c-690f-4e89-8311-8e69bd3bc4fe"/>
//				<textFieldExpression><![CDATA["Meal Components"]]></textFieldExpression>
//			</textField>
//		</band>
//	</pageHeader>
//	<detail>
//		<band height="30">
//			<textField>
//				<reportElement x="1" y="0" width="27" height="28" uuid="d35ae247-fdf2-445b-a819-7a4f1f293f1d">
//					<property name="com.jaspersoft.studio.unit.height" value="pixel"/>
//					<property name="com.jaspersoft.studio.unit.x" value="pixel"/>
//				</reportElement>
//				<textElement>
//					<font fontName="Arial" size="18"/>
//				</textElement>
//				<textFieldExpression><![CDATA[$F{NQUANTITY}]]></textFieldExpression>
//			</textField>
//			<textField>
//				<reportElement x="41" y="13" width="156" height="16" uuid="34c16169-d405-4981-bce7-56b3ca249d11"/>
//				<textFieldExpression><![CDATA[$F{CTEXT}]]></textFieldExpression>
//			</textField>
//			<textField>
//				<reportElement x="41" y="2" width="149" height="14" uuid="62017005-26f3-49a9-8ce5-cbdc37b1916b"/>
//				<textFieldExpression><![CDATA[$F{CPACKINGLIST}]]></textFieldExpression>
//			</textField>
//		</band>
//	</detail>
//</jasperReport>

li_file  = FileOpen(as_filename  , LineMode!, Write!, LockWrite!, Replace!)
ll_Bytes = FileWriteEX(li_file, ls_XML)
li_Succ  = FileClose(li_file)


Return ls_XML

end function

public function string of_object_key (string as_object);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_object_key (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 11.04.2017
//
// Argument(e):
// string as_object
//
// Beschreibung:		Object Key
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	11.04.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------


String	ls_Return 
String	ls_Find
String	ls_Dont_Find


ls_Return = as_Object

// t_content_tray_1_col_01_row_13
// t_content_text_5_col_01_row_01
// t_content_text_1_col_01_row_07

ls_Find = "t_content"
ls_Dont_Find =  "t_freetext_content_"

if left(as_Object, len(ls_Dont_Find)) = ls_Dont_Find then
	Return as_object
End If

if left(as_Object, len(ls_Find)) = ls_Find then
	
	If pos(as_Object, "_header_") > 0 then
		ls_Return = f_replace(as_Object, "_header_", "_" )
	End If	

	If pos(as_Object, "_std_text") > 0 then
		ls_Return = f_replace(as_Object, "_std_text", "_" )
	End If	
	
	If pos(as_Object, "_tray_") > 0 then
		ls_Return = f_replace(as_Object, "_tray_", "_" )
	End If
	
	If pos(as_Object, "_text_") > 0 then
		ls_Return = f_replace(as_Object, "_text_", "_" )
	End If
	
	If pos(as_Object, "_std_") > 0 then
		ls_Return = f_replace(as_Object, "_std_", "_" )
	End If
	
	If pos(as_Object, "_content_std_text_") > 0 then
		ls_Return = f_replace(as_Object, "_content_std_text_", "_content_" )
	End If
	
	If pos(as_Object, "_content_text_") > 0 then
		ls_Return = f_replace(as_Object, "_content_text_", "_content_" )
	End If

	
End If

If left(ls_Return, len("t_content_0")) = "t_content_0" then
	ls_Return = f_replace(ls_Return, "t_content_0",  "t_content_" )
End If

return ls_Return

end function

public function string of_create_static_text (datawindow adw_ref, string as_object, boolean ab_empty);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_static_text (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datawindow adw_ref
//	 string as_object
//
// Beschreibung:		Create a Static Text Object
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------

string	ls_return, ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic
String	ls_error
Long 		ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border
Long		ll_BackGroundMode
Long		ll_BackGroundColour
String	ls_Temp
String	ls_BackGroundColour
Long		ll_TextColour
String	ls_TextColour
String	ls_Object_Key
Boolean	lb_Breakpoint

ll_x = Long(adw_ref.Describe(as_Object + ".x"))
ll_y = Long(adw_ref.Describe(as_Object + ".y"))
ll_height = (Long(adw_ref.Describe(as_Object + ".height")) )
ll_width = (Long(adw_ref.Describe(as_Object + ".width")) )

If ll_width < 0 OR ll_height < 0 Then
	lb_Breakpoint = TRUE
	return ""
End If

ll_x = of_convert_pixels( ll_x )
ll_y = of_convert_pixels( ll_y )
ll_width = of_convert_pixels( ll_width )
ll_height = of_convert_pixels( ll_height )

If ll_width + ll_x > il_detail_width OR ll_height + ll_y > il_Detail_Height Then
	lb_Breakpoint = TRUE
	return ""
End If

ll_height += 2

ll_border 		= Long(adw_ref.Describe(as_Object + ".Border")) 
ls_Fontname 	= adw_ref.Describe(as_Object + ".font.face")

If ib_Replace_Font_With_Arial Then
	//f_trace("Font: " + ls_Fontname + " => Arial" )
	ls_Fontname = "Arial"
End If

ll_fontsize 	= Long(adw_ref.Describe(as_Object + ".font.height"))
if ll_fontsize < 0 then ll_fontsize = ll_fontsize * -1
ll_fontweight 	= Long(adw_ref.Describe(as_Object + ".font.weight")) 
ll_align 			= Long(adw_ref.Describe(as_Object + ".alignment"))
ll_underline 		= Long(adw_ref.Describe(as_Object + ".font.underline"))
ll_italic 			= Long(adw_ref.Describe(as_Object + ".Font.Italic")) 
ls_text 			= adw_ref.Describe(as_Object + ".text") 

// $$HEX1$$1920$$ENDHEX$$
ls_text = f_replace(ls_text, "$$HEX1$$1920$$ENDHEX$$", "'")

ls_text = f_replace(ls_text, "$$HEX1$$1320$$ENDHEX$$", "-")

// $$HEX1$$c900$$ENDHEX$$
ls_text = f_replace(ls_text, "$$HEX1$$c900$$ENDHEX$$", "E")

// $$HEX1$$e900$$ENDHEX$$
ls_text = f_replace(ls_text, "$$HEX1$$e900$$ENDHEX$$", "e")

ls_text = f_replace(ls_text, "$$HEX1$$d700$$ENDHEX$$", "x")


//ls_text = f_replace(ls_text, '"', "")

ls_text = f_replace(ls_text, '$$HEX1$$1c20$$ENDHEX$$', '"')

ls_text = f_replace(ls_text, '$$HEX1$$1d20$$ENDHEX$$', '"')


If pos(as_object , "t_rungnumber_") > 0 then
	ls_textColour = "#000000"
	ab_Empty = FALSE
end if


//if ib_componentlist Then

	if ab_Empty Then
		ls_text =" "
	End If
	
//Else
//	// Keine Componentlist => fixed content
//End If


if pos(as_Object, "_content_") > 0 Then
	ll_TextColour = 0 
	ls_TextColour = of_convert_rgb( ll_TextColour )
End If

ll_TextColour  = Long(adw_ref.Describe(as_Object + ".color"))
ls_TextColour = of_convert_rgb( ll_TextColour )


ls_return  = "		<staticText>"+ is_crlf
ls_return += "			<reportElement "


//key="t_content_1_col_01_row_01"
//<printWhenExpression><![CDATA[false]]></printWhenExpression>
// p_bottom_tray_col_01_row_04
// p_lane_left_col_1_row_14
// p_lane_right_col_2_row_10

ls_Object_Key = of_object_key(as_object)

ls_return += "	key='" + ls_Object_Key + "'"


ll_BackGroundMode = Long(adw_ref.Describe(as_Object + ".Background.Mode"))
if ll_BackGroundMode <> 1 then 
	ll_BackGroundColour = Long(adw_ref.Describe(as_Object + ".Background.color"))
	
	//ll_BackGroundColour = rgb(200,200,200)
	
	ls_Temp = (adw_ref.Describe(as_Object + ".Background.color"))
	
	If pos(ls_Temp, "~t") > 0 then
		ls_Temp = mid(ls_Temp, pos(ls_Temp, "~t") + 1) 
		if right(ls_Temp, 1) = '"' or right(ls_Temp, 1) = "'" Then
			ls_Temp = left(ls_Temp, len(ls_Temp) -1)
		End If
	
		ls_error = (adw_ref.Describe("evaluate(' " + ls_Temp) + "', 0)")
		
		ls_Temp = "evaluate('" + ls_Temp + "', 0)"
		ls_error = 	adw_ref.Describe(ls_Temp)
		
		ll_BackGroundColour = rgb(200,200,200)
		
		if isnumber(ls_error) then
			//ll_BackGroundColour = long(ls_Temp)
			ll_BackGroundColour = long(ls_error)
		End If
		
	Else
		If isnumber(ls_Temp) then
			ll_BackGroundColour = long(ls_Temp)
		end if
		
	End If
	//ll_BackGroundColour = rgb(200,200,200)
	//ls_return += ' mode="Opaque" backcolor="#C8C8C8" '
	
	ls_BackGroundColour = of_convert_rgb( ll_BackGroundColour )
	
	ls_return += ' mode="Opaque" backcolor="' + ls_BackGroundColour + '" '
	
end if

ls_return += "	x='" + String(ll_x) + "' y='" + String(ll_y) + "' width='" + String(ll_width) + "' height='" + String(ll_height) + "'"
ls_return += "	forecolor='" + ls_textColour + "'"

// height="20" forecolor="#0000FF"

ls_return += "	uuid='092d53ea-" + string(Rand(9999), "0000") + "-40a3-a9d6-" + string(cpu()) + "'/>"+ is_crlf

if ll_border <> 0 then
	ls_return += "				<box padding='2' topPadding='0' leftPadding='0' bottomPadding='0' rightPadding='0'>"+ is_crlf
	ls_return += "					<topPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>"+ is_crlf
	ls_return += "					<leftPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>"+ is_crlf
	ls_return += "					<bottomPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>"+ is_crlf
	ls_return += "					<rightPen lineWidth='1.0' lineStyle='Solid' lineColor='#000000'/>"+ is_crlf
	ls_return += "				</box>"
end if

Choose case ll_align
	case 0
		ls_alignment = "Left"
	case 1
		ls_alignment = "Right"
	case 2
		ls_alignment = "Center"
	case else
		ls_alignment = ""
end choose

if ll_fontweight = 700 then
	ls_bold = "true"
else
	ls_bold = "false"
end if

if ll_italic = 1 then
	ls_italic = "true"
else
	ls_italic = "false"
end if

if ll_underline = 1 then
	ls_underline = "true"
else
	ls_underline = "false"
end if

ls_return += "				<textElement textAlignment='" + ls_alignment+ "'>"+ is_crlf
ls_return += "					<font fontName='" + ls_Fontname + "' size='" + String(ll_fontsize) + "' isBold='" + ls_bold + "' isItalic='" + ls_italic + "' isUnderline='" + ls_underline + "'/>"+ is_crlf
ls_return += "				</textElement>"+ is_crlf
ls_return += "				<text><![CDATA[" + ls_text + "]]></text>"+ is_crlf
ls_return += "			</staticText>"+ is_crlf


return ls_return 


end function

public function integer of_export_painter_dw (datawindow adw_source, string as_pl);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_export_painter_dw (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// datawindow adw_source
//
// Beschreibung:		Export Cart Diagram Masterdata plus Query for Flight Info & Meal Components
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
// 1.1 			O.Hoefer	13.03.2018		Overflow on Main - Subreport
// 1.2 			O.Hoefer	02.05.2018		NEU: select aus package, weniger subreports
//
//
// Return: integer
//
// --------------------------------------------------------------------------------


String	ls_xml
String	ls_quote 
String	ls_crlf
long	 	ll_rows
Integer	li_Succ
integer 	li_object_type
String	ls_Object_Array[]
String	ls_DWObjects
Long		ll_Counter, ll_ArrayCount
String	ls_Temp
Double	ld_Factor_H = 1
Double	ld_Factor_V = 1
String	ls_Object
String	ls_Band
String	ls_type
Long		ll_Height_Header   = 109
Long		ll_Height_Detail   = 840
Long		ll_Height_Footer   =  65
Long		ll_SubLeg_W = 74, ll_SubLeg_H = 72
Long		ll_Page_Height, ll_Page_Width
Long		ll_Xpos
Long		ll_Ypos
Integer	li_UseLetterFormat	
String	ls_Sub_Componentlist
String	ls_Sub_File
Boolean	lb_Create_Sub_Componentlist = TRUE
String	ls_PL
String	ls_Tag
Long		ll_Col_Count, ll_Rowcount, ll_TMP


ib_Additional_Shrink = FALSE


lb_Create_Sub_Componentlist = ib_componentlist


li_UseLetterFormat = integer(f_mandant_profilestring(sqlca, s_app.smandant, "PaperFormat", "UseLetterFormat", "0"))

//ld_Factor_V =  3/4  // 640 / 850
//ld_Factor_H =  3/4  // 595 / 720

// Scaling Factor
ld_Factor_V =  id_pixel_factor //3/4  // 640 / 850
ld_Factor_H =  id_pixel_factor  //  3/4  // 595 / 720



ll_Height_Header = Long(adw_source.Describe("DataWindow.header.height"))	
ll_Height_Detail = Long(adw_source.Describe("DataWindow.detail.height"))	
ll_Height_Footer = Long(adw_source.Describe("DataWindow.footer.height"))	


//ls_PL = adw_source.Describe("h_packinglist.text")

Select Max(ld.ncolumn), Max(ld.nrow)
into :ll_Col_Count, :ll_Rowcount
   From cen_pl_layout_detail   ld,
        cen_packinglist_layout ll,
        cen_packinglists       pl,
        cen_packinglist_index  pi
  Where ld.nlayout_key = ll.nlayout_key
    And pl.npackinglist_index_key = ll.npackinglist_index_key
//    And Sysdate Between pl.dvalid_from And pl.dvalid_to
    And pi.npackinglist_index_key = pl.npackinglist_index_key
    And pi.cpackinglist = :as_PL; 
	//'KQFF220';

If ll_Rowcount > 14 then
	// Skalierung (z.B. NZ 16 Rungs)
	//li_Succ = of_shrink_all( adw_source  )
//	ld_Factor_V =  0.75
//	ld_Factor_H =  0.75
	
End If

If li_UseLetterFormat = 1 then
	ld_Factor_V =  0.75
	ld_Factor_H =  0.75
End If

ll_Page_Height = ll_Height_Header + ll_Height_Detail + ll_Height_Footer

ll_Page_Height = of_convert_pixels( ll_Page_Height )

If li_UseLetterFormat = 1 then
	// Page = LETTER
	ll_Page_Height = 792
Else
	// Page = A4
	ll_Page_Height = 842
End If

ll_Height_Header = of_convert_pixels( ll_Height_Header )
ll_Height_Header += 4

ll_Height_Footer = of_convert_pixels( ll_Height_Footer )


ll_Height_Detail = of_convert_pixels( ll_Height_Detail )

//ll_Height_Detail = 657

ll_Height_Detail = ll_Page_Height - ll_Height_Header - ll_Height_Footer


ll_Height_Detail -= 4


li_UseLetterFormat = integer(f_mandant_profilestring(sqlca, s_app.smandant, "PaperFormat", "UseLetterFormat", "0"))

//luo_jasper.il_PL_Detail_Key

If li_UseLetterFormat = 1 then
	// Page = LETTER
	ll_Page_Height = 792
	ll_Page_Width = 612
	ll_Height_Detail = ll_Page_Height - ll_Height_Header -ll_Height_Footer - 2
	is_jasperfile  = Left(is_jasperfile , lastpos(is_jasperfile, ".") - 1) +Mid(is_jasperfile , lastpos(is_jasperfile, "."))
	//is_jasperfile  = Left(is_jasperfile , lastpos(is_jasperfile, ".") - 1) + "_LETTER" +  Mid(is_jasperfile , lastpos(is_jasperfile, "."))
Else
	// Page = A4
	ll_Page_Height = 842
	ll_Page_Width = 595
	//ll_Height_Detail = ll_Page_Height - ll_Height_Header -ll_Height_Footer - 2
	is_jasperfile  = Left(is_jasperfile , lastpos(is_jasperfile, ".") - 1) + Mid(is_jasperfile , lastpos(is_jasperfile, "."))	
	//is_jasperfile  = Left(is_jasperfile , lastpos(is_jasperfile, ".") - 1) + "_A4" +  Mid(is_jasperfile , lastpos(is_jasperfile, "."))	
End If

If ib_header_footer_switch Then
	ll_TMP = ll_Height_Footer
	ll_Height_Footer = ll_Height_Header
	ll_Height_Header = ll_TMP
//Else
//	ll_Height_Header = ll_Height_Header
//	ll_Height_Footer = ll_Height_Footer
End If
	
If li_UseLetterFormat = 1 AND ll_Rowcount > 14 Then	
	ib_Additional_Shrink = TRUE	
End If
	
If ll_Rowcount > 14 then
	// Skalierung (z.B. NZ 16 Rungs)
	li_Succ = of_shrink_all( adw_source  )	
ElseIf li_UseLetterFormat = 1 AND ll_Rowcount > 10 then
	// Bei Letter weniger Platz 
	li_Succ = of_shrink_all( adw_source  )	
End If
	
	
il_Detail_Height	= ll_Height_Detail
il_Detail_Width	= ll_Page_Width	
	
//ll_Height_Detail = 839	

// NEU f$$HEX1$$fc00$$ENDHEX$$r verbesserte selects / packe functions
ls_Sub_Componentlist = "Sub_Components_02.jasper"

ls_xml = ""

ls_xml += '<?xml version="1.0" encoding="UTF-8"?>'+ is_crlf
ls_xml += '<!-- Created with Jaspersoft Studio version 6.3.0.final using JasperReports Library version 6.3.0  -->'+ is_crlf
//ls_xml += '<!-- 2017-03-07T12:28:55 -->'+ is_crlf

ls_xml += '<!-- ' + String(today(), "yyyy-mm-dd") + 'T' + String(Now(), "hh:mm:ss") + ' -->'+ is_crlf

ls_xml += '<jasperReport xmlns="http://jasperreports.sourceforge.net/jasperreports" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd" '
ls_xml += ' name="Cart_Diagram_V02" '
//ls_xml += ' pageWidth="595" pageHeight="842" columnWidth="575" '
//If li_UseLetterFormat = 1 then

//If ll_Rowcount > 14 then
	// #############################################################
//	ls_xml += ' pageWidth="'+String(ll_Page_Width)+'" pageHeight="' + String(ll_Page_Height + 40) + '" columnWidth="'+String(ll_Page_Width - 5)+'" '
//Else
	ls_xml += ' pageWidth="'+String(ll_Page_Width)+'" pageHeight="' + String(ll_Page_Height) + '" columnWidth="'+String(ll_Page_Width - 5)+'" '
//End If 

//Else
//	ls_xml += ' pageWidth="'+String(ll_Page_Width)+'" pageHeight="' + String(ll_Page_Height) + '" columnWidth="'+String(ll_Page_Width - 5)+'" '
//End If
ls_xml += ' leftMargin="1" rightMargin="1" topMargin="1" bottomMargin="1" uuid="f3e31c49-3082-49f1-b22e-3f0284456ade">'
ls_xml += '	<property name="com.jrxmlsoft.studio.data.sql.tables" value=""/>'+ is_crlf
ls_xml += '	<property name="com.jrxmlsoft.studio.data.defaultdataadapter" value="MAINTUS"/>'+ is_crlf
ls_xml += '	<property name="com.jrxmlsoft.studio.unit." value="pixel"/>'+ is_crlf
//ls_xml += '	<parameter name="arg_result_key" class="java.lang.Long"/>'
//ls_xml += '	<parameter name="arg_stowage" class="java.lang.String"/>'

ls_xml += '	<parameter name="arg_result_key" class="java.lang.Long">'+ is_crlf
ls_xml += '			<defaultValueExpression><![CDATA[23904890]]></defaultValueExpression>'+ is_crlf
ls_xml += '		</parameter>'+ is_crlf
ls_xml += '		<parameter name="arg_stowage" class="java.lang.Long">'+ is_crlf
//ls_xml += '			<defaultValueExpression><![CDATA[376809]]></defaultValueExpression>'+ is_crlf
ls_xml += '		</parameter>'+ is_crlf

//<parameter name="SUBREPORT_DIR" class="java.lang.String"/>
ls_xml += '		<parameter name="SUBREPORT_DIR" class="java.lang.String"/>'+ is_crlf

ls_xml += of_create_query()

ls_DWObjects = adw_source.describe("datawindow.objects")

for ll_Counter = 1 to len(ls_DWObjects)
	if Mid(ls_DWObjects, ll_Counter, 1) <> char(9) then
		ls_Temp += Mid(ls_DWObjects, ll_Counter, 1)
	else
		ll_ArrayCount ++
		ls_Object_Array[ll_ArrayCount] = ls_Temp
		ls_Temp = ""
	end if
next
if len(ls_Temp) > 0 then		
	ll_ArrayCount ++
	ls_Object_Array[ll_ArrayCount] = ls_Temp
end if

// --------------------------------------------------------------------------------
// Wasserzeichen NEU ohne Subreport
// --------------------------------------------------------------------------------
ls_xml += '	<background>'+ is_crlf
ls_xml += '		<band height="500">'+ is_crlf
ls_xml += '			<textField isBlankWhenNull="true">'+ is_crlf
ls_xml += '				<reportElement x="14" y="270" width="500" height="200" forecolor="#C0C0C0" uuid="092d53ea-4303-40a3-a9d6-000000698105"/>'+ is_crlf
ls_xml += '				<textElement textAlignment="Center">'+ is_crlf
ls_xml += '					<font fontName="Arial" size="150" isBold="false" isItalic="false" isUnderline="false"/>'+ is_crlf
ls_xml += '				</textElement>'+ is_crlf
ls_xml += '				<textFieldExpression><![CDATA[$F{CWATERMARK_BIG}]]></textFieldExpression>'+ is_crlf
ls_xml += '			</textField>'+ is_crlf
ls_xml += '			<textField isBlankWhenNull="true">'+ is_crlf
ls_xml += '				<reportElement x="14" y="270" width="500" height="200" forecolor="#C0C0C0" uuid="092d53ea-4303-40a3-a9d6-000000698105"/>'+ is_crlf
ls_xml += '				<textElement textAlignment="Center">'+ is_crlf
ls_xml += '					<font fontName="Arial" size="100" isBold="false" isItalic="false" isUnderline="false"/>'+ is_crlf
ls_xml += '				</textElement>'+ is_crlf
ls_xml += '				<textFieldExpression><![CDATA[$F{CWATERMARK_SMALL}]]></textFieldExpression>'+ is_crlf
ls_xml += '			</textField>'+ is_crlf
ls_xml += '		</band>'+ is_crlf
ls_xml += '	</background>'+ is_crlf

ls_xml += "<pageHeader>"+ is_crlf
ls_xml += '		<band height="' + string(ll_Height_Header ) + '">'+ is_crlf

f_trace("Band Header height " + + string(ll_Height_Header ))

for ll_rows = 1 to upperbound(ls_Object_Array)
	ls_Object = ls_Object_Array[ll_rows]
	if pos(	ls_Object,"marker") > 0 then
		continue
	end if
	ls_Band = adw_source.Describe(ls_Object_Array[ll_rows] + ".band")	
	if ls_Band <> "header" then 
		continue
	end if
	
	//t_content_order
	ls_Object = ls_Object_Array[ll_rows]
	if pos(	ls_Object,"t_content_order") > 0 then
		continue
	end if
	
	ls_Temp = adw_source.Describe(ls_Object_Array[ll_rows] + ".visible")	
	if ls_Temp <> "1" then 
		continue
	end if
			
	If ls_Object = "h_departuredate" OR &
		ls_Object = "h_packinglist"   OR &
		ls_Object = "h_description"   OR &
		ls_Object = "h_loadinglist"   OR &
		ls_Object = "f_departure" OR &
		ls_Object = "f_ramptime" OR &
		ls_Object = "f_workstation"   OR &
		ls_Object = "f_rampbox" OR &
		ls_Object = "f_flightnumber" OR &
		ls_Object = "f_stowageposition" OR &
		ls_Object = "h_actype" then	
		
		ls_xml += of_create_column( adw_source, ls_Object)
		
	Else
	
		ls_type = adw_source.Describe(ls_Object_Array[ll_rows] + ".Type")		
		choose case ls_type
			//	Solumn
			case "column"
			//	ls_xml += of_create_column(ll_rows)
	
			case "text"
				ll_Ypos = Long(adw_source.Describe(ls_Object_Array[ll_rows] + ".y"))
				if ll_Ypos > ll_Height_Header Then
					CONTINUE		
				End If
				ls_xml += of_create_static_text(adw_source, ls_Object)
				
			// Rectangle	
			case "rectangle" 
				ll_Ypos = Long(adw_source.Describe(ls_Object_Array[ll_rows] + ".y"))
				if ll_Ypos > ll_Height_Header Then
					CONTINUE		
				End If
				ls_xml += of_create_rectangle(adw_source, ls_Object)
			
			// Line
			CASE "line"		
				ll_Ypos = Long(adw_source.Describe(ls_Object_Array[ll_rows] + ".y1"))
				
				ll_Ypos = of_convert_pixels( ll_Ypos )
				
				if ll_Ypos > ll_Height_Header Then
					CONTINUE		
				End If
				ls_xml += of_create_line(adw_source, ls_Object)
				
			//	Picture
			CASE "bitmap"	
				ls_xml += of_create_bitmap( adw_source, ls_Object)
	
			CASE "compute"
				ls_xml +=  of_create_compute( adw_source, ls_Object)
		
			CASE ELSE
				// Nothing to do
				//CONTINUE
		end choose
	End If
next


if ib_Header_Footer_Switch = FALSE then
	f_trace("Header Footer Switch = FALSE")
	// --------------------------------------------------------------------------------
	// Airline Logo NEU Blob Inline statt Subreport
	// --------------------------------------------------------------------------------
	ls_xml += '	<image scaleImage="RetainShape">'+ is_crlf
	ls_xml += '		<reportElement isPrintRepeatedValues="false" x="7" y="1" width="115" height="38" uuid="c5020bf3-d4a9-4109-37ba-8dc792895eba"/>'+ is_crlf
	ls_xml += '		<imageExpression><![CDATA[$F{BLOGO}]]></imageExpression>'+ is_crlf
	ls_xml += '	</image>'+ is_crlf
	
	
	ls_xml += '<ellipse>'+ is_crlf
	ls_xml += '				<reportElement mode="Transparent" x="108" y="36" width="70" height="35" uuid="6d96a356-8944-4bfb-a977-ce9936278736">'+ is_crlf
	ls_xml += '					<property name="com.jrxmlsoft.studio.unit.width" value="pixel"/>'+ is_crlf
	ls_xml += '					<property name="com.jrxmlsoft.studio.unit.height" value="pixel"/>'+ is_crlf
	ls_xml += '					<printWhenExpression><![CDATA[( $F{CHEALTHMARK1}  != null)]]></printWhenExpression>'+ is_crlf
	ls_xml += '				</reportElement>'+ is_crlf
	ls_xml += '			</ellipse>'+ is_crlf
	ls_xml += '			<textField>'+ is_crlf
	ls_xml += '				<reportElement x="108" y="36" width="70" height="15" uuid="5258e347-7b44-4524-b417-93afee025735">'+ is_crlf
	ls_xml += '					<printWhenExpression><![CDATA[( $F{CHEALTHMARK1}  != null)]]></printWhenExpression>'+ is_crlf
	ls_xml += '				</reportElement>'+ is_crlf
	ls_xml += '				<textElement textAlignment="Center">'+ is_crlf
	ls_xml += '					<font fontName="Arial" size="8" isBold="true"/>'+ is_crlf
	ls_xml += '				</textElement>'+ is_crlf
	ls_xml += '				<textFieldExpression><![CDATA[$F{CHEALTHMARK1}]]></textFieldExpression>'+ is_crlf
	ls_xml += '			</textField>'+ is_crlf
	ls_xml += '			<textField>'+ is_crlf
	ls_xml += '				<reportElement x="108" y="49" width="70" height="14" uuid="3b922a9c-a484-409b-85af-dab7dd699646">'+ is_crlf
	ls_xml += '					<printWhenExpression><![CDATA[( $F{CHEALTHMARK1}  != null)]]></printWhenExpression>'+ is_crlf
	ls_xml += '				</reportElement>'+ is_crlf
	ls_xml += '				<textElement textAlignment="Center">'+ is_crlf
	ls_xml += '					<font fontName="Arial" size="8" isBold="true"/>'+ is_crlf
	ls_xml += '				</textElement>'+ is_crlf
	ls_xml += '				<textFieldExpression><![CDATA[$F{CHEALTHMARK2}]]></textFieldExpression>'+ is_crlf
	ls_xml += '			</textField>'+ is_crlf
	ls_xml += '			<textField>'+ is_crlf
	ls_xml += '				<reportElement x="108" y="59" width="70" height="16" uuid="05dd8e39-f2f7-43f0-9c37-644c090f745a">'+ is_crlf
	ls_xml += '					<printWhenExpression><![CDATA[( $F{CHEALTHMARK1}  != null)]]></printWhenExpression>'+ is_crlf
	ls_xml += '				</reportElement>'+ is_crlf
	ls_xml += '				<textElement textAlignment="Center">'+ is_crlf
	ls_xml += '					<font fontName="Arial" size="8" isBold="true"/>'+ is_crlf
	ls_xml += '				</textElement>'+ is_crlf
	ls_xml += '				<textFieldExpression><![CDATA[$F{CHEALTHMARK3}]]></textFieldExpression>'+ is_crlf
	ls_xml += '			</textField>'+ is_crlf
		
	// --------------------------------------------------------------------------------
	// Leg 1
	// --------------------------------------------------------------------------------
	ls_xml += '			<subreport>'+ is_crlf
	ls_xml += '				<reportElement x="177" y="2" width="'+String(ll_SubLeg_W)+'" height="'+String(ll_SubLeg_H)+'" forecolor="#33CCCC" backcolor="#99FF00" uuid="2e3d0096-2b9e-4915-8599-1c180e4a52dc"/>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_result_key">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_leg">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[LONG_VALUE("1")]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>'+ is_crlf
	
	If ib_Replace_Subreport_Path Then
		ls_xml += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	Else
		ls_xml += '				<subreportExpression><![CDATA["Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	End If
		
	ls_xml += '			</subreport>'+ is_crlf
	
	// --------------------------------------------------------------------------------
	// Leg 2
	// --------------------------------------------------------------------------------
	ls_xml += '			<subreport>'+ is_crlf
	ls_xml += '				<reportElement x="250" y="1" width="'+String(ll_SubLeg_W)+'" height="'+String(ll_SubLeg_H)+'" forecolor="#33CCCC" backcolor="#99FF00" uuid="5eb20d48-2c15-400e-af57-4f7f8a2d2111"/>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_result_key">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_leg">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[LONG_VALUE("2")]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>'+ is_crlf
	If ib_Replace_Subreport_Path Then
		ls_xml += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	Else
		ls_xml += '				<subreportExpression><![CDATA["Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	End If
	
	ls_xml += '			</subreport>'+ is_crlf
	
	// --------------------------------------------------------------------------------
	// Leg 3
	// --------------------------------------------------------------------------------
	ls_xml += '			<subreport>'+ is_crlf
	ls_xml += '				<reportElement x="323" y="1" width="'+String(ll_SubLeg_W)+'" height="'+String(ll_SubLeg_H)+'" forecolor="#33CCCC" backcolor="#99FF00" uuid="5eb20d48-2c15-400e-af57-4f7f8a2d2111"/>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_result_key">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_leg">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[LONG_VALUE("3")]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>'+ is_crlf
	If ib_Replace_Subreport_Path Then
		ls_xml += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	Else
		ls_xml += '				<subreportExpression><![CDATA["Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	End If
	ls_xml += '			</subreport>'+ is_crlf
	
	// --------------------------------------------------------------------------------
	// Leg 4
	// --------------------------------------------------------------------------------
	ls_xml += '			<subreport>'+ is_crlf
	ls_xml += '				<reportElement x="396" y="1" width="'+String(ll_SubLeg_W)+'" height="'+String(ll_SubLeg_H)+'" forecolor="#33CCCC" backcolor="#99FF00" uuid="5eb20d48-2c15-400e-af57-4f7f8a2d2111"/>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_result_key">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_leg">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[LONG_VALUE("4")]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>'+ is_crlf
	If ib_Replace_Subreport_Path Then
		ls_xml += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	Else
		ls_xml += '				<subreportExpression><![CDATA["Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	End If
	ls_xml += '			</subreport>'+ is_crlf
End If



// --------------------------------------------------------------------------------
// Barcode
// --------------------------------------------------------------------------------
If ib_Sub_Barcode then
	If ib_Header_Footer_Switch = TRUE Then
		
		ls_xml += '		<image> '+ is_crlf
		If id_Pixel_Factor =  0.8 then
			ls_xml += '			<reportElement x="269" y="1" width="42" height="42" uuid="8a9e29b4-1b3f-4c04-0b97-e0b71c7475e7"/> '+ is_crlf
		Else
			ls_xml += '			<reportElement x="248" y="1" width="42" height="42" uuid="8a9e29b4-1b3f-4c04-0b97-e0b71c7475e7"/> '+ is_crlf
		End If
		ls_xml += '			<imageExpression><![CDATA[$F{BBARCODE}]]></imageExpression> '+ is_crlf
		ls_xml += '		</image> '+ is_crlf

	End If
End If

ls_xml += "</band>"+ is_crlf
ls_xml += "</pageHeader>"+ is_crlf

ls_xml += "	<detail>" + is_crlf
//ls_xml += "		<band height='" + string(il_band_height) + "' splitType='Stretch'>" + is_crlf
ls_xml += "		<band height='" + string(ll_Height_Detail ) + "'>" + is_crlf

f_trace("Band detail height " + + string(ll_Height_Detail ))

//ls_xml += "		<band height='" + string(ll_Height_Detail ) + "' splitType='Stretch'>" + is_crlf

for ll_rows = 1 to upperbound(ls_Object_Array)
	ls_Object = ls_Object_Array[ll_rows]
	if pos(	ls_Object,"marker") > 0 then
		continue
	end if
	ls_Object = ls_Object_Array[ll_rows]
	if pos(	ls_Object,"t_content_order") > 0 then
		continue
	end if
	ls_Band = adw_source.Describe(ls_Object_Array[ll_rows] + ".band")	
	if ls_Band <> "detail" then 
		continue
	end if
	ls_Temp = adw_source.Describe(ls_Object_Array[ll_rows] + ".visible")	
	if ls_Temp <> "1" then 
		continue
	end if
	ls_type = adw_source.Describe(ls_Object_Array[ll_rows] + ".Type")		
	
	If ls_Object = "h_departuredate" OR &
		ls_Object = "h_packinglist"   OR &
		ls_Object = "h_description"   OR &
		ls_Object = "h_loadinglist"   OR &
		ls_Object = "f_departure" OR &
		ls_Object = "f_workstation"   OR &
		ls_Object = "f_rampbox" OR &
		ls_Object = "f_ramptime" OR &
		ls_Object = "f_flightnumber" OR &
		ls_Object = "f_stowageposition" OR &
		ls_Object = "h_actype" then	
		
		ls_xml += of_create_column( adw_source, ls_Object)
		
	Else
	
		choose case ls_type
			//	column
			case "column"
			//	ls_xml += of_create_column(ll_rows)
	
			case "text"
				if left(ls_Object, len( "t_rungnumber_") )  = "t_rungnumber_" then
					ls_xml += of_create_static_text(adw_source, ls_Object, FALSE)				
				elseif left(ls_Object, len( "t_text_") )  = "t_text_" then
					ls_xml += of_create_static_text(adw_source, ls_Object)
				Elseif left(ls_Object, len("t_front_")) = "t_front_" OR left(ls_Object, len("t_rear_")) = "t_rear_" then
					ls_xml += of_create_static_text(adw_source, ls_Object, FALSE)				
				Elseif left(ls_Object, len( "t_content_") )  = "t_content_" then
					ls_xml += of_create_static_text(adw_source, ls_Object, TRUE)
				Else
					ls_xml += of_create_static_text(adw_source, ls_Object, TRUE)
				End If			
			// Rectangle	
			case "rectangle" 
				ls_xml += of_create_rectangle(adw_source, ls_Object)
	
			// Rectangle	
			case "roundrectangle" 
				ls_xml += of_create_round_rect(adw_source, ls_Object)
	
			// Line
			CASE "line"		
				ls_xml += of_create_line(adw_source, ls_Object)
				
			//	Picture
			CASE "bitmap"	
				
				ls_Tag = adw_source.Describe(ls_Object + ".tag")
				If Left(ls_Tag, len("nadd_object_key=")) = "nadd_object_key=" Then
					ls_xml += of_create_bitmap_subreport(adw_source, ls_Object)
				Else
					ls_xml += of_create_bitmap( adw_source, ls_Object)
				End If							
	
			CASE "compute"
				ls_xml +=  of_create_compute( adw_source, ls_Object)

			CASE ELSE
				// Nothing to do
				//CONTINUE
		end choose
	End If
next


If lb_Create_Sub_Componentlist then
			
	// --------------------------------------------------------------------------------
	// Component List
	// --------------------------------------------------------------------------------			
	ls_xml += '			<subreport>'  + is_crlf
	//ls_xml += '				<reportElement x="2" y="1" width="158" height="626" uuid="e62c0996-8ce4-4efb-9d59-d0a3b35f15a6"/>'  + is_crlf
	//ls_xml += '				<reportElement x="2" y="1" width="148" height="' + String(ll_Height_Detail - 5 ) + '" uuid="e62c0996-8ce4-4efb-9d59-d0a3b35f15a6"/>'  + is_crlf
	//ls_xml += '				<reportElement x="2" y="1" width="148" height="' + String(639 ) + '" uuid="e62c0996-8ce4-4efb-9d59-d0a3b35f15a6"/>'  + is_crlf
	
	If li_UseLetterFormat = 1 Then
		ls_xml += '				<reportElement x="2" y="1" width="148" height="' + String(615 ) + '" uuid="e62c0996-8ce4-4efb-9d59-d0a3b35f15a6"/>'  + is_crlf
	Else	
		ls_xml += '				<reportElement x="2" y="1" width="148" height="' + String(639 ) + '" uuid="e62c0996-8ce4-4efb-9d59-d0a3b35f15a6"/>'  + is_crlf
	End If
	
	ls_xml += '				<subreportParameter name="arg_result_key">'  + is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>'  + is_crlf
	ls_xml += '				</subreportParameter>'  + is_crlf
	ls_xml += '				<subreportParameter name="arg_stowage">'  + is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[$P{arg_stowage}]]></subreportParameterExpression>'  + is_crlf
	ls_xml += '				</subreportParameter>'  + is_crlf
	ls_xml += '				<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>'  + is_crlf
	If ib_Replace_Subreport_Path Then
		ls_xml += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "' + ls_Sub_Componentlist  + '"]]></subreportExpression>'  + is_crlf
	Else
		ls_xml += '				<subreportExpression><![CDATA["' + ls_Sub_Componentlist  + '"]]></subreportExpression>'  + is_crlf
	End If
	ls_xml += '			</subreport>'  + is_crlf

End If

If lb_Create_Sub_Componentlist then
	if ib_Include_Drawer_Content Then
		ls_xml += '						<subreport>'  + is_crlf
		ls_xml += '							<reportElement x="157" y="42" width="180" height="548" uuid="24efdef5-8318-4c86-af21-65047827633e"/>'  + is_crlf
		ls_xml += '							<subreportParameter name="arg_result_key">'  + is_crlf
		ls_xml += '								<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>'  + is_crlf
		ls_xml += '							</subreportParameter>'  + is_crlf
		ls_xml += '							<subreportParameter name="arg_stowage">'  + is_crlf
		ls_xml += '								<subreportParameterExpression><![CDATA[$P{arg_stowage}]]></subreportParameterExpression>'  + is_crlf
		ls_xml += '							</subreportParameter>'  + is_crlf
		ls_xml += '							<subreportParameter name="arg_column">'  + is_crlf
		ls_xml += '								<subreportParameterExpression><![CDATA[LONG_VALUE("1")]]></subreportParameterExpression>'  + is_crlf
		ls_xml += '							</subreportParameter>'  + is_crlf
		ls_xml += '							<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>'  + is_crlf
	
		//ls_xml += '							<subreportExpression><![CDATA["sub_drawer_content_col.jasper"]]></subreportExpression>'  + is_crlf
		
		If ib_Replace_Subreport_Path Then
			ls_xml += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "sub_drawer_content_col.jasper"]]></subreportExpression>'+ is_crlf
		Else
			ls_xml += '				<subreportExpression><![CDATA["sub_drawer_content_col.jasper"]]></subreportExpression>'+ is_crlf
		End If
		
		ls_xml += '						</subreport>'  + is_crlf
		
	end if
End If

If lb_Create_Sub_Componentlist  AND	ll_Col_Count > 1 Then
	if ib_Include_Drawer_Content then			
		ls_xml += '				<subreport>'  + is_crlf
		ls_xml += '					<reportElement x="347" y="42" width="180" height="548" uuid="0e24f4bf-1982-41b8-99b0-582249a6249f"/>'  + is_crlf
		ls_xml += '					<subreportParameter name="arg_result_key">'  + is_crlf
		ls_xml += '						<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>'  + is_crlf
		ls_xml += '					</subreportParameter>'  + is_crlf
		ls_xml += '					<subreportParameter name="arg_stowage">'  + is_crlf
		ls_xml += '						<subreportParameterExpression><![CDATA[$P{arg_stowage}]]></subreportParameterExpression>'  + is_crlf
		ls_xml += '					</subreportParameter>'  + is_crlf
		ls_xml += '					<subreportParameter name="arg_column">'  + is_crlf
		ls_xml += '						<subreportParameterExpression><![CDATA[LONG_VALUE("2")]]></subreportParameterExpression>'  + is_crlf
		ls_xml += '					</subreportParameter>'  + is_crlf
		ls_xml += '					<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>'  + is_crlf
		If ib_Replace_Subreport_Path Then
			ls_xml += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "sub_drawer_content_col.jasper"]]></subreportExpression>'+ is_crlf
		Else
			ls_xml += '				<subreportExpression><![CDATA["sub_drawer_content_col.jasper"]]></subreportExpression>'+ is_crlf
		End If
		ls_xml += '				</subreport>'  + is_crlf
	end if
End If

//If lb_Create_Sub_Componentlist then
	if ib_Include_ALL_Content Then
		ls_xml += '						<subreport>'  + is_crlf
		ls_xml += '							<reportElement x="157" y="42" width="180" height="548" uuid="24efdef5-8318-4c86-af21-65047827633e"/>'  + is_crlf
		ls_xml += '							<subreportParameter name="arg_result_key">'  + is_crlf
		ls_xml += '								<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>'  + is_crlf
		ls_xml += '							</subreportParameter>'  + is_crlf
		ls_xml += '							<subreportParameter name="arg_stowage">'  + is_crlf
		ls_xml += '								<subreportParameterExpression><![CDATA[$P{arg_stowage}]]></subreportParameterExpression>'  + is_crlf
		ls_xml += '							</subreportParameter>'  + is_crlf
		ls_xml += '							<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>'  + is_crlf
		If ib_Replace_Subreport_Path Then
			ls_xml += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "sub_cart_content_all.jasper"]]></subreportExpression>'+ is_crlf
		Else
			ls_xml += '				<subreportExpression><![CDATA["sub_cart_content_all.jasper"]]></subreportExpression>'+ is_crlf
		End If		
		ls_xml += '						</subreport>'  + is_crlf
		
	end if
//End If

//ls_xml += "		</band>" + is_crlf


// --------------------------------------------------------------------------------
// Backlog on Main?
// --------------------------------------------------------------------------------
If ib_Overflow_on_Main AND ll_Col_Count = 1 Then
	If ib_componentlist Then
		// nicht schieben	
		// kein Backlog auf eigener Seite
		ls_xml += '	<subreport>' + is_crlf
		ls_xml += '			<reportElement x="382" y="27" width="156" height="554" uuid="831ca5b9-4740-446c-9b48-db3a379e41e1"/>' + is_crlf
		ls_xml += '			<subreportParameter name="arg_result_key">' + is_crlf
		ls_xml += '				<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>' + is_crlf
		ls_xml += '			</subreportParameter>' + is_crlf
		ls_xml += '			<subreportParameter name="arg_stowage_key">' + is_crlf
		ls_xml += '				<subreportParameterExpression><![CDATA[$P{arg_stowage}]]></subreportParameterExpression>' + is_crlf
		ls_xml += '			</subreportParameter>' + is_crlf
		ls_xml += '			<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>' + is_crlf
		ls_xml += '			<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "Sub_Backlog_on_Main_01.jasper"]]></subreportExpression>' + is_crlf
		ls_xml += '		</subreport>' + is_crlf
		
		//CDATA[$P{SUBREPORT_DIR} + "
		
	Else
		
		// Beh$$HEX1$$e400$$ENDHEX$$lter nach links schieben NZBH201 
		
		ls_xml += "		<subreport>" + is_crlf
		ls_xml += '				<reportElement x="310" y="27" width="270" height="554" uuid="259c98b3-f410-49f1-8971-8b83d37315d5"/>' + is_crlf
		//ls_xml += '				<reportElement x="280" y="27" width="270" height="554" uuid="259c98b3-f410-49f1-8971-8b83d37315d5"/>' + is_crlf
		ls_xml += '				<subreportParameter name="arg_result_key">' + is_crlf
		ls_xml += "					<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>" + is_crlf
		ls_xml += "				</subreportParameter>" + is_crlf
		ls_xml += '				<subreportParameter name="arg_stowage_key">' + is_crlf
		ls_xml += "					<subreportParameterExpression><![CDATA[$P{arg_stowage}]]></subreportParameterExpression>" + is_crlf
		ls_xml += "				</subreportParameter>" + is_crlf
		ls_xml += "				<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>" + is_crlf
		ls_xml += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "Sub_Backlog_on_Main_01.jasper"]]></subreportExpression>' + is_crlf
		ls_xml += "			</subreport>" + is_crlf
				
	End If
	ls_xml += "		</band>" + is_crlf

Else
	ls_xml += "		</band>" + is_crlf
	// --------------------------------------------------------------------------------
	// Overflow Detail Band
	// --------------------------------------------------------------------------------			
	
	ls_xml += '	<band height="550">'  + is_crlf
	f_trace("Band Overflow detail height " + + string(550 ))

	ls_xml += '			<property name="com.jaspersoft.studio.unit.height" value="pixel"/>'  + is_crlf
	//ls_xml += '			<printWhenExpression><![CDATA[$F{NNUMBACKLOG} > 0]]></printWhenExpression>'  + is_crlf
	
	// Vor$$HEX1$$fc00$$ENDHEX$$bergehend deaktiviert 
	ls_xml += '			<printWhenExpression><![CDATA[$F{NNUMBACKLOG} > 0 || $F{NCOMPOVERFLOW} > 24]]></printWhenExpression>'  + is_crlf
	//ls_xml += '			<printWhenExpression><![CDATA[$F{NNUMBACKLOG} > 900 || $F{NCOMPOVERFLOW} > 924]]></printWhenExpression>'  + is_crlf
	//ls_xml += '			<printWhenExpression><![CDATA[$F{NNUMBACKLOG} > 0 || $F{NCOMPOVERFLOW} > 24]]></printWhenExpression>'  + is_crlf
	
	ls_xml += '			<break>'  + is_crlf
	ls_xml += '				<reportElement x="0" y="0" width="100" height="1" uuid="97588233-da55-47b9-8d91-64726d440f09">'  + is_crlf
	ls_xml += '					<property name="com.jaspersoft.studio.unit.y" value="pixel"/>'  + is_crlf
	ls_xml += '					<printWhenExpression><![CDATA[$F{NNUMBACKLOG} > 0]]></printWhenExpression>'  + is_crlf
	ls_xml += '				</reportElement>'  + is_crlf
	ls_xml += '			</break>'  + is_crlf
	
	ls_xml += '			<textField>'  + is_crlf
	ls_xml += '				<reportElement mode="Opaque" x="168" y="22" width="100" height="88" backcolor="#FFFF00" uuid="5bc10a9e-e01a-4845-a307-3adef767e6bc">'  + is_crlf
	ls_xml += '					<printWhenExpression><![CDATA[1==2]]></printWhenExpression>'  + is_crlf
	ls_xml += '				</reportElement>'  + is_crlf
	ls_xml += '				<textElement textAlignment="Center">'  + is_crlf
	ls_xml += '					<font fontName="Arial" size="26" isBold="true"/>'  + is_crlf
	ls_xml += '				</textElement>'  + is_crlf
	ls_xml += '				<textFieldExpression><![CDATA[$F{NNUMBACKLOG}]]></textFieldExpression>'  + is_crlf
	ls_xml += '			</textField>'  + is_crlf
	ls_xml += '			<subreport>'  + is_crlf
	ls_xml += '				<reportElement x="10" y="1" width="528" height="526" uuid="31b097ec-2e59-48d6-b263-b3c9b177269f"/>'  + is_crlf
	ls_xml += '				<subreportParameter name="arg_result_key">'  + is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>'  + is_crlf
	ls_xml += '				</subreportParameter>'  + is_crlf
	ls_xml += '				<subreportParameter name="arg_stowage_key">'  + is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[$P{arg_stowage}]]></subreportParameterExpression>'  + is_crlf
	ls_xml += '				</subreportParameter>'  + is_crlf
	ls_xml += '				<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>'  + is_crlf
	If ib_Replace_Subreport_Path Then
		ls_xml += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "Sub_Backlog_01.jasper"]]></subreportExpression>'+ is_crlf
	Else
		ls_xml += '				<subreportExpression><![CDATA["Sub_Backlog_01.jasper"]]></subreportExpression>'+ is_crlf
	End If
	ls_xml += '			</subreport>'  + is_crlf
	ls_xml += '	</band>'  + is_crlf

End If

ls_xml += "	</detail>" + is_crlf

ls_xml += "<pageFooter>"+ is_crlf
ls_xml += '		<band height="' + String(ll_Height_Footer )  + '">'+ is_crlf

	f_trace("Band pageFooter height " + + string(ll_Height_Footer ))


for ll_rows = 1 to upperbound(ls_Object_Array)
	ls_Object = ls_Object_Array[ll_rows]
	if pos(	ls_Object,"marker") > 0 then
		continue
	end if
	ls_Band = adw_source.Describe(ls_Object_Array[ll_rows] + ".band")	
	if ls_Band <> "footer" then 
		continue
	end if
	
	ls_Temp = adw_source.Describe(ls_Object_Array[ll_rows] + ".visible")	
	if ls_Temp <> "1" then 
		continue
	end if
	
	
	ls_type = adw_source.Describe(ls_Object_Array[ll_rows] + ".Type")	
	
	If ls_Object = "h_departuredate" OR &
		ls_Object = "h_packinglist"   OR &
		ls_Object = "h_description"   OR &
		ls_Object = "h_loadinglist"   OR &
		ls_Object = "f_departure" OR &
		ls_Object = "f_ramptime" OR &
		ls_Object = "f_workstation"   OR &
		ls_Object = "f_rampbox" OR &
		ls_Object = "f_flightnumber" OR &
		ls_Object = "f_stowageposition" OR &
		ls_Object = "h_actype" then	
		
		ls_xml += of_create_column( adw_source, ls_Object)
		
	Else
	
		choose case ls_type
			//	Column
			case "column"
			//	ls_xml += of_create_column(ll_rows)
	
			case "text"
				ll_Ypos = Long(adw_source.Describe(ls_Object_Array[ll_rows] + ".y"))
				if ll_Ypos > ll_Height_Footer Then
					CONTINUE		
				End If
				ls_xml += of_create_static_text(adw_source, ls_Object)
				
			// Rectangle	
			case "rectangle" 
				ll_Ypos = Long(adw_source.Describe(ls_Object_Array[ll_rows] + ".y"))
				if ll_Ypos > ll_Height_Footer Then
					CONTINUE		
				End If
				ls_xml += of_create_rectangle(adw_source, ls_Object)
	
			// Line
			CASE "line"		
				ll_Ypos = Long(adw_source.Describe(ls_Object_Array[ll_rows] + ".y1"))
				ll_Ypos = of_convert_pixels( ll_Ypos)
				if ll_Ypos > ll_Height_Footer Then
					CONTINUE		
				End If
				ls_xml += of_create_line(adw_source, ls_Object)
				
			//	Picture
			CASE "bitmap"	
				
				ls_xml += of_create_bitmap( adw_source, ls_Object)
	
			CASE "compute"
				ls_xml +=  of_create_compute( adw_source, ls_Object)

		
			CASE ELSE
				// Nothing to do
				//CONTINUE
		end choose
	
	end if
next

if ib_Header_Footer_Switch = TRUE then
	f_trace("ib_Header_Footer_Switch=TRUE")
	// --------------------------------------------------------------------------------
	// Airline Logo
	// --------------------------------------------------------------------------------
	ls_xml += '	<image scaleImage="RetainShape">'+ is_crlf
	ls_xml += '		<reportElement isPrintRepeatedValues="false" x="7" y="1" width="115" height="38" uuid="c5020bf3-d4a9-4109-37ba-8dc792895eba"/>'+ is_crlf
	ls_xml += '		<imageExpression><![CDATA[$F{BLOGO}]]></imageExpression>'+ is_crlf
	ls_xml += '	</image>'+ is_crlf

	
	ls_xml += '<ellipse>'+ is_crlf
	ls_xml += '				<reportElement mode="Transparent" x="108" y="29" width="70" height="35" uuid="6d96a356-8944-4bfb-a977-ce9936278736">'+ is_crlf
	ls_xml += '					<property name="com.jrxmlsoft.studio.unit.width" value="pixel"/>'+ is_crlf
	ls_xml += '					<property name="com.jrxmlsoft.studio.unit.height" value="pixel"/>'+ is_crlf
	ls_xml += '					<printWhenExpression><![CDATA[( $F{CHEALTHMARK1}  != null)]]></printWhenExpression>'+ is_crlf
	ls_xml += '				</reportElement>'+ is_crlf
	ls_xml += '			</ellipse>'+ is_crlf
	ls_xml += '			<textField>'+ is_crlf
	ls_xml += '				<reportElement x="108" y="29" width="70" height="15" uuid="5258e347-7b44-4524-b417-93afee025735">'+ is_crlf
	ls_xml += '					<printWhenExpression><![CDATA[( $F{CHEALTHMARK1}  != null)]]></printWhenExpression>'+ is_crlf
	ls_xml += '				</reportElement>'+ is_crlf
	ls_xml += '				<textElement textAlignment="Center">'+ is_crlf
	ls_xml += '					<font fontName="Arial" size="8" isBold="true"/>'+ is_crlf
	ls_xml += '				</textElement>'+ is_crlf
	ls_xml += '				<textFieldExpression><![CDATA[$F{CHEALTHMARK1}]]></textFieldExpression>'+ is_crlf
	ls_xml += '			</textField>'+ is_crlf
	ls_xml += '			<textField>'+ is_crlf
	ls_xml += '				<reportElement x="108" y="42" width="70" height="14" uuid="3b922a9c-a484-409b-85af-dab7dd699646">'+ is_crlf
	ls_xml += '					<printWhenExpression><![CDATA[( $F{CHEALTHMARK1}  != null)]]></printWhenExpression>'+ is_crlf
	ls_xml += '				</reportElement>'+ is_crlf
	ls_xml += '				<textElement textAlignment="Center">'+ is_crlf
	ls_xml += '					<font fontName="Arial" size="8" isBold="true"/>'+ is_crlf
	ls_xml += '				</textElement>'+ is_crlf
	ls_xml += '				<textFieldExpression><![CDATA[$F{CHEALTHMARK2}]]></textFieldExpression>'+ is_crlf
	ls_xml += '			</textField>'+ is_crlf
	ls_xml += '			<textField>'+ is_crlf
	ls_xml += '				<reportElement x="108" y="52" width="70" height="16" uuid="05dd8e39-f2f7-43f0-9c37-644c090f745a">'+ is_crlf
	ls_xml += '					<printWhenExpression><![CDATA[( $F{CHEALTHMARK1}  != null)]]></printWhenExpression>'+ is_crlf
	ls_xml += '				</reportElement>'+ is_crlf
	ls_xml += '				<textElement textAlignment="Center">'+ is_crlf
	ls_xml += '					<font fontName="Arial" size="8" isBold="true"/>'+ is_crlf
	ls_xml += '				</textElement>'+ is_crlf
	ls_xml += '				<textFieldExpression><![CDATA[$F{CHEALTHMARK3}]]></textFieldExpression>'+ is_crlf
	ls_xml += '			</textField>'+ is_crlf
End If
	
If ib_Header_Footer_Switch = TRUE Then
	// --------------------------------------------------------------------------------
	// Leg 1
	// --------------------------------------------------------------------------------
	ls_xml += '			<subreport>'+ is_crlf
	ls_xml += '				<reportElement x="177" y="2" width="'+String(ll_SubLeg_W)+'" height="'+String(ll_SubLeg_H)+'" forecolor="#33CCCC" backcolor="#99FF00" uuid="2e3d0096-2b9e-4915-8599-1c180e4a52dc"/>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_result_key">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_leg">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[LONG_VALUE("1")]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>'+ is_crlf
	
	If ib_Replace_Subreport_Path Then
		ls_xml += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	Else
		ls_xml += '				<subreportExpression><![CDATA["Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	End If
	
	
	ls_xml += '			</subreport>'+ is_crlf
	
	// --------------------------------------------------------------------------------
	// Leg 2
	// --------------------------------------------------------------------------------
	ls_xml += '			<subreport>'+ is_crlf
	ls_xml += '				<reportElement x="250" y="1" width="'+String(ll_SubLeg_W)+'" height="'+String(ll_SubLeg_H)+'" forecolor="#33CCCC" backcolor="#99FF00" uuid="5eb20d48-2c15-400e-af57-4f7f8a2d2111"/>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_result_key">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_leg">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[LONG_VALUE("2")]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>'+ is_crlf
	If ib_Replace_Subreport_Path Then
		ls_xml += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	Else
		ls_xml += '				<subreportExpression><![CDATA["Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	End If
	
	ls_xml += '			</subreport>'+ is_crlf
	
	// --------------------------------------------------------------------------------
	// Leg 3
	// --------------------------------------------------------------------------------
	ls_xml += '			<subreport>'+ is_crlf
	ls_xml += '				<reportElement x="323" y="1" width="'+String(ll_SubLeg_W)+'" height="'+String(ll_SubLeg_H)+'" forecolor="#33CCCC" backcolor="#99FF00" uuid="5eb20d48-2c15-400e-af57-4f7f8a2d2111"/>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_result_key">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_leg">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[LONG_VALUE("3")]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>'+ is_crlf
	If ib_Replace_Subreport_Path Then
		ls_xml += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	Else
		ls_xml += '				<subreportExpression><![CDATA["Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	End If
	ls_xml += '			</subreport>'+ is_crlf
	
	// --------------------------------------------------------------------------------
	// Leg 4
	// --------------------------------------------------------------------------------
	ls_xml += '			<subreport>'+ is_crlf
	ls_xml += '				<reportElement x="396" y="1" width="'+String(ll_SubLeg_W)+'" height="'+String(ll_SubLeg_H)+'" forecolor="#33CCCC" backcolor="#99FF00" uuid="5eb20d48-2c15-400e-af57-4f7f8a2d2111"/>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_result_key">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[$P{arg_result_key}]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<subreportParameter name="arg_leg">'+ is_crlf
	ls_xml += '					<subreportParameterExpression><![CDATA[LONG_VALUE("4")]]></subreportParameterExpression>'+ is_crlf
	ls_xml += '				</subreportParameter>'+ is_crlf
	ls_xml += '				<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>'+ is_crlf
	If ib_Replace_Subreport_Path Then
		ls_xml += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} + "Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	Else
		ls_xml += '				<subreportExpression><![CDATA["Sub_Cart_Header_per_Leg_01.jasper"]]></subreportExpression>'+ is_crlf
	End If
	ls_xml += '			</subreport>'+ is_crlf

End If


if ib_Sub_Barcode then
	If ib_Header_Footer_Switch = FALSE Then
		ls_xml += '		<image> '+ is_crlf
		If id_Pixel_Factor =  0.8 then
			ls_xml += '			<reportElement x="269" y="1" width="42" height="42" uuid="8a9e29b4-1b3f-4c04-0b97-e0b71c7475e7"/> '+ is_crlf
		Else
			ls_xml += '			<reportElement x="248" y="1" width="42" height="42" uuid="8a9e29b4-1b3f-4c04-0b97-e0b71c7475e7"/> '+ is_crlf
		End If
		ls_xml += '			<imageExpression><![CDATA[$F{BBARCODE}]]></imageExpression> '+ is_crlf
		ls_xml += '		</image> '+ is_crlf
	End If
end if

ls_xml += "		</band>"+ is_crlf
ls_xml += "	</pageFooter>"+ is_crlf
ls_xml += "</jasperReport>" + is_crlf

this.of_write(ls_xml)

// --------------------------------------------------------------------------------
// Datenbank (Main Report)
// --------------------------------------------------------------------------------
li_Succ = of_save_to_db( is_jasperfile, ls_xml, 1)

//Messagebox("Export", "File: " + is_crlf + is_crlf + is_jasperfile + is_crlf + is_crlf + "created!")

return 0

end function

public function integer of_save_to_db (string as_jaspername, string as_text, integer ai_is_mainreport);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_save_to_db (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 05.02.2018
//
// Argument(e):
// string as_jaspername
//	 string as_text
//	 integer ai_is_mainreport
//
// Beschreibung:		INSERT INTO cen_jasper_report
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	05.02.2018		Erstellung
// 1.1 			O.Hoefer	07.03.2018		Hinzu: Subreport pro Bild
//
//
// Return: integer
//
// --------------------------------------------------------------------------------

Integer		li_file
Long			ll_rc
Long			ll_jasper_key
DateTime		ldtm_now
Blob			lblb_jasper_xml
String		ls_File_Short
String		ls_Path
Long			ll_Counter
String		ls_Filename_Sub
Blob			lblb_jasper
Boolean		lb_Error
String		ls_XML
Long			ll_Old_Key


//"D:\Projekt\JasperSoftWorkspace\MyReports\CartDiagram\"


ls_Path = Left(as_jaspername, lastpos(as_jaspername, "\") )

//ls_Sub_Reports[upperbound(ls_Sub_Reports) + 1] = "Sub_Watermark_01.jasper"
//ls_Sub_Reports[upperbound(ls_Sub_Reports) + 1] = "Sub_Airline_Logo_01.jasper"
//ls_Sub_Reports[upperbound(ls_Sub_Reports) + 1] = "Sub_Cart_Header_per_Leg_01.jasper"
//ls_Sub_Reports[upperbound(ls_Sub_Reports) + 1] = "Sub_Components_02.jasper"
//ls_Sub_Reports[upperbound(ls_Sub_Reports) + 1] = "Sub_Backlog_01.jasper"

//ls_Sub_Reports[upperbound(ls_Sub_Reports) + 1] = "sub_cart_content_all.jasper"


//IF ii_save_in_db = 1 THEN
	ldtm_now = DateTime(Today(), Now())
	// Wenn Subreport, dann neuen Key holen, ansonsten den vom Mainreport nehmen
	IF ai_is_mainreport = 1 THEN
//		ll_jasper_key = il_jasper_key_mainreport
//	ELSE
		ll_jasper_key = f_Sequence ("seq_cen_jasper_report", sqlca)
		il_jasper_key_mainreport = ll_jasper_key
		IF ll_jasper_key = -1 THEN
			uf.mBox("Datenbankfehler", "Fehler bei Sequence ${seq_cen_jasper_report: " + sqlca.sqlerrtext + "}", StopSign!)
			Rollback;
			Return -1
		END IF
		
	ELSE
		//ll_jasper_key = il_jasper_key_mainreport
		ll_jasper_key = f_Sequence ("seq_cen_jasper_report", sqlca)
		//il_jasper_key_mainreport = ll_jasper_key
		IF ll_jasper_key = -1 THEN
			uf.mBox("Datenbankfehler", "Fehler bei Sequence ${seq_cen_jasper_report: " + sqlca.sqlerrtext + "}", StopSign!)
			Rollback;
			Return -1
		END IF
	END IF
	
	ls_File_Short = Mid(as_jaspername, lastpos(as_jaspername, "\") +1 )
	
	// Insert
	INSERT INTO cen_jasper_report (njasper_key, njasper_group_key, nis_main_report, dupdated_date, cname)
	VALUES (:ll_jasper_key, :il_jasper_key_mainreport, :ai_is_mainreport, :ldtm_now, :ls_File_Short);
	IF SQLCA.SQLCode <> 0 THEN
		uf.mBox("Datenbankfehler", "Error Insert cen_jasper_report: " + String(sqlca.sqldbcode) + " - " + sqlca.sqlerrtext + "}", StopSign!)
		Rollback;
		Return -1
	END IF

	// Jetzt noch das Clob...
	lblb_jasper_xml = Blob(as_text)
	UPDATEBLOB	cen_jasper_report
	SET		clb_jasper_xml = :lblb_jasper_xml
	WHERE	njasper_key = :ll_jasper_key;
	IF SQLCA.SQLCode <> 0 THEN
		uf.mBox("Datenbankfehler", "Error Updateblob cen_jasper_report: " + String(sqlca.sqldbcode) + " - " + sqlca.sqlerrtext + "}", StopSign!)
		Rollback;
		Return -1
	END IF
	
	If il_PL_Index_Key > 0 and il_PL_Detail_Key > 0 Then
		// Evtl. vorhandenen Report entfernen
		Select njasper_key
		INTO :ll_Old_Key
		FROM cen_packinglists
		WHERE npackinglist_index_key  = :il_PL_Index_Key
		AND   npackinglist_detail_key = :il_PL_Detail_Key;
		If NOT IsNULL(ll_Old_Key) AND ll_Old_Key > 0 Then
			// inkl. Sub Rep
			DELETE FROM cen_jasper_report
			WHERE  njasper_group_key = :ll_Old_Key;
					
		End If
		
		// Neuen Key Setzen
		UPDATE cen_packinglists 
		SET njasper_key = :il_jasper_key_mainreport 
		WHERE npackinglist_index_key = :il_PL_Index_Key
		AND npackinglist_detail_key = :il_PL_Detail_Key;
		IF SQLCA.SQLCode <> 0 THEN
			uf.mBox("Datenbankfehler", "Error Update cen_packinglists: " + String(sqlca.sqldbcode) + " - " + sqlca.sqlerrtext + "}", StopSign!)
			Rollback;
			Return -1
		END IF
	
	End If

COMMIT;

If Upperbound(is_jasper_sub_picture_reports) > 0 Then
	For ll_Counter = 1 To Upperbound(is_jasper_sub_picture_reports)
		ll_jasper_key = f_Sequence ("seq_cen_jasper_report", sqlca)

		ls_Filename_Sub = is_jasper_sub_picture_reports[ll_Counter]
		
		ls_XML = is_jasper_sub_picture_xml[ll_Counter]
		
		ls_Filename_Sub = is_jasper_sub_picture_reports[ll_Counter]
		ls_Filename_Sub = mid(ls_Filename_Sub, lastpos(ls_Filename_Sub, "\") + 1)
		
		lblb_jasper_xml = Blob( ls_XML )
			
		If NOT lb_Error Then
			// Insert
			ls_Filename_Sub = mid(ls_Filename_Sub, lastpos(ls_Filename_Sub,"\") + 1)
			
			ls_Filename_Sub = left(ls_Filename_Sub, len(ls_Filename_Sub) - 6)
			
			INSERT INTO cen_jasper_report (njasper_key, njasper_group_key, nis_main_report, dupdated_date, cname)
			VALUES (:ll_jasper_key, :il_jasper_key_mainreport, 0, :ldtm_now, :ls_Filename_Sub);
			IF SQLCA.SQLCode <> 0 THEN
				uf.mBox("Datenbankfehler", "Error Insert cen_jasper_report: " + String(sqlca.sqldbcode) + " - " + sqlca.sqlerrtext + "}", StopSign!)
				Rollback;
				Return -1
			END IF
	
			UPDATEBLOB	cen_jasper_report
			SET		clb_jasper_xml = :lblb_jasper_xml
			WHERE	njasper_key = :ll_jasper_key;
			IF SQLCA.SQLCode <> 0 THEN
				uf.mBox("Datenbankfehler", "Error Updateblob cen_jasper_report: " + String(sqlca.sqldbcode) + " - " + sqlca.sqlerrtext + "}", StopSign!)
				Rollback;
				Return -1
			END IF
		End If
		
		COMMIT;
		
		SetNULL(lblb_jasper)
		
	Next
End If

//If FALSE Then
//	For ll_Counter = 1 To Upperbound(ls_Sub_Reports)
//		ll_jasper_key = f_Sequence ("seq_cen_jasper_report", sqlca)
//		//ls_Sub_Reports[ll_Counter]
//		ls_Filename_Sub = ls_Path + ls_Sub_Reports[ll_Counter]
//		
//		if f_file_to_blob(ls_Filename_Sub, lblb_jasper, True) > 0 then
//			// OK Blob vorhanden
//		Else
//			// Error
//			lb_Error = TRUE
//		End If
//		
//			//lblb_jasper
//		If NOT lb_Error Then
//			// Insert
//			INSERT INTO cen_jasper_report (njasper_key, njasper_group_key, nis_main_report, dupdated_date, cname)
//			VALUES (:ll_jasper_key, :il_jasper_key_mainreport, 0, :ldtm_now, :ls_Sub_Reports[ll_Counter]);
//			IF SQLCA.SQLCode <> 0 THEN
//				uf.mBox("Datenbankfehler", "Error Insert cen_jasper_report: " + String(sqlca.sqldbcode) + " - " + sqlca.sqlerrtext + "}", StopSign!)
//				Rollback;
//				Return -1
//			END IF
//	
//			////	SET		clb_jasper_xml = :lblb_jasper_xml
//			// BLOB.
//			lblb_jasper_xml = Blob(as_text)
//			UPDATEBLOB	cen_jasper_report
//			SET		blb_jasper = :lblb_jasper
//			WHERE	njasper_key = :ll_jasper_key;
//			IF SQLCA.SQLCode <> 0 THEN
//				uf.mBox("Datenbankfehler", "Error Updateblob cen_jasper_report: " + String(sqlca.sqldbcode) + " - " + sqlca.sqlerrtext + "}", StopSign!)
//				Rollback;
//				Return -1
//			END IF
//		End If
//		
//		COMMIT;
//		
//		SetNULL(lblb_jasper)
//		
//	Next
//End If


Return 1

end function

public function string of_create_bitmap_subreport (datawindow adw_ref, string as_object);String		ls_return 
Integer	li_file
Integer	li_pos
Long		ll_label_detail_key
String		ls_jasper_subreport_name
//Long		ll_x, ll_y, ll_width, ll_height
String		ls_Tag

//string	ls_return
string	ls_alignment, ls_Fontname, ls_text, ls_bold, ls_underline, ls_italic, ls_column
Long		ll_x, ll_y, ll_width, ll_height, ll_align, ll_fontsize, ll_underline, ll_italic, ll_fontweight, ll_border
String	ls_Picture
String	ls_PIC_Orig
String	ls_Object_Key
Long		ll_Key
Integer	li_Succ
Long		ll_Bytes

ll_x = Long(adw_ref.Describe(as_Object + ".x"))
ll_y = Long(adw_ref.Describe(as_Object + ".y"))
ll_height = Long(adw_ref.Describe(as_Object + ".height")) 
ll_width = Long(adw_ref.Describe(as_Object + ".width")) 
ls_Picture = adw_ref.Describe(as_Object + ".filename")

ls_PIC_Orig = ls_Picture

if pos(ls_Picture, "\") > 0 then
	ls_Picture = mid(ls_Picture, lastpos(ls_Picture, "\") + 1)
end if

ll_x = of_convert_pixels( ll_x )
ll_y = of_convert_pixels( ll_y )
ll_width = of_convert_pixels( ll_width )
ll_height = of_convert_pixels( ll_height )


ls_Tag = adw_ref.Describe(as_Object + ".tag")

//ls_mod = sObjectName + ".tag='nadd_object_key=" + String(lAddKey) + "'"
//of_modify(ls_mod , false)

If Left(ls_Tag, len("nadd_object_key=")) = "nadd_object_key=" Then
	// Use Key in Subreport
	ls_Tag = Mid(ls_Tag,  len("nadd_object_key=") + 1)
	ll_Key = Long(ls_Tag)
End If

//if not fileexists( "C:\Users\U112878\JaspersoftWorkspace\MyReports\images\" + ls_Picture) then
//	FileCopy(ls_PIC_Orig, "C:\Users\U112878\JaspersoftWorkspace\MyReports\images\" + ls_Picture)
//end if


//Select bbitmap
//  From cen_pl_layout_add_obj
// Where nlayout_key = 1
//   And nadd_object_key = 1


//ls_return   ='		<image scaleImage="FillFrame">' + is_crlf
//ls_return += "			<reportElement "
//ls_Object_Key = of_object_key(as_object)
//ls_return += "	key='" + ls_Object_Key + "' "
//ls_return +="x='" + string(ll_x) + "' y='" + string(ll_y)+ "' width='" + string(ll_width) + "' height='" + string(ll_height) + "' uuid='" + string(Rand(9999), "0000") + "-" +  string(Rand(9999), "0000") + "-49bd-8b0c-157e72d1978c'/>"+ is_crlf
//If ib_Replace_Image_Path Then
//	ls_return += '			<imageExpression><![CDATA[$P{SUBREPORT_DIR} + "images/' + ls_Picture + '"]]></imageExpression>'+ is_crlf
//Else
//	ls_return += '			<imageExpression><![CDATA["' + "images/" + ls_Picture + '"]]></imageExpression>'+ is_crlf
//End If
//ls_return += "		</image>" + is_crlf


//return ls_return


//ll_label_detail_key = ids_label_details.GetItemNumber(al_row, "nlabel_detail_key")
//ll_x 			= ids_label_details.GetItemNumber(al_row, "nxpos")
//ll_y 			= ids_label_details.GetItemNumber(al_row, "nypos")
//ll_height	 	= ids_label_details.GetItemNumber(al_row, "nheight")
//ll_width 		= ids_label_details.GetItemNumber(al_row, "nwidth")
//
//// Warum auch immer: es gibt Objekte, die H$$HEX1$$f600$$ENDHEX$$he oder Breite = 0 haben. Die k$$HEX1$$f600$$ENDHEX$$nnen wir hier ignorieren
//IF ll_height = 0 OR ll_width = 0 THEN Return ""
//
// Erstmal den Subreport als Extra Jasper-XML erstellen
ls_return += "<?xml version='1.0' encoding='UTF-8'?>" + is_crlf
ls_return += "<!-- Created with Jaspersoft Studio version 6.3.0.final using JasperReports Library version 6.3.0  -->"
ls_return += "<!-- 2016-07-07T10:47:14 -->"
ls_return += "<jasperReport xmlns='http://jasperreports.sourceforge.net/jasperreports' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xsi:schemaLocation='http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd' name='Blank_A4' pageWidth='595' pageHeight='842' columnWidth='595' leftMargin='0' rightMargin='0' topMargin='0' bottomMargin='0' uuid='" + of_uuid() + "'>"
ls_return += "	<property name='com.jaspersoft.studio.unit.' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.pageHeight' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.pageWidth' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.topMargin' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.bottomMargin' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.leftMargin' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.rightMargin' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.columnWidth' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.unit.columnSpacing' value='pixel'/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.data.sql.tables' value=''/>" + is_crlf
ls_return += "	<property name='com.jaspersoft.studio.data.defaultdataadapter' value='Data Adapter MAINT_US.xml'/>" + is_crlf

// Query 
ls_return += "	<queryString>" + is_crlf
ls_return += "<![CDATA[Select BBITMAP from cen_pl_layout_add_obj Where nadd_object_key = " + String(ll_Key) + "]]> " + is_crlf	

//<![CDATA[Select BBITMAP from cen_pl_layout_add_obj Where nadd_object_key = 4352932 ]]>
//ls_return += "	<Select bbitmap From cen_pl_layout_add_obj Where nadd_object_key = " + String(ll_Key) + ">" + is_crlf	

ls_return += "	</queryString>" + is_crlf

ls_return += "	<field name='BBITMAP' class='java.awt.Image'/>" + is_crlf
ls_return += "	<background>" + is_crlf
ls_return += "		<band splitType='Stretch'/>" + is_crlf
ls_return += "	</background>" + is_crlf
ls_return += "	<detail>" + is_crlf
ls_return += "		<band height='" + String(ll_height) + "' splitType='Stretch'>" + is_crlf
ls_return += "			<property name='com.jaspersoft.studio.unit.height' value='pixel'/>" + is_crlf
ls_return += "			<image>" + is_crlf
ls_return += "				<reportElement x='0' y='0' width='" + String(ll_width) + "' height='" + String(ll_height) + "' uuid='" + of_uuid() + "'/>" + is_crlf
ls_return += "				<imageExpression><![CDATA[$F{BBITMAP}]]></imageExpression>" + is_crlf
ls_return += "			</image>" + is_crlf
ls_return += "		</band>" + is_crlf
ls_return += "	</detail>" + is_crlf
ls_return += "</jasperReport>" + is_crlf

// Subreport speichern
//ls_jasper_subreport_name = Replace(is_jasper_subreport_name, Pos(is_jasper_subreport_name, "<nlabel_detail_key>"), Len("<nlabel_detail_key>"), String(ll_label_detail_key))
ls_jasper_subreport_name =  f_gettemppath() + "sub_picture_" + String(ll_Key) + ".jrxml"
//ii_rc = of_write(ls_jasper_subreport_name, ls_return, 0)

li_file  = FileOpen(ls_jasper_subreport_name, LineMode!, Write!, LockWrite!, Replace!)
ll_Bytes =  FileWriteEX(li_file, ls_return)
li_Succ  = FileClose(li_file)

is_jasper_sub_picture_reports[upperbound(is_jasper_sub_picture_reports) + 1] = ls_jasper_subreport_name

is_jasper_sub_picture_xml[upperbound(is_jasper_sub_picture_xml) + 1] = ls_return


// Ohne Pfad
if pos(ls_jasper_subreport_name, "\") > 0 then
	ls_jasper_subreport_name = mid(ls_jasper_subreport_name, lastpos(ls_jasper_subreport_name, "\") + 1)
end if


//is_jasper_sub_picture_reports[upperbound(is_jasper_sub_picture_reports) + 1] = ls_jasper_subreport_name

//// Einen Parameter f$$HEX1$$fc00$$ENDHEX$$r den Subreport zuf$$HEX1$$fc00$$ENDHEX$$gen
////is_xml_parameter += of_add_subreport_parameter(ls_jasper_subreport_name)

ls_jasper_subreport_name =  left(ls_jasper_subreport_name, lastpos(ls_jasper_subreport_name, ".") - 1)

// Dann den Sub-Report-Teil f$$HEX1$$fc00$$ENDHEX$$r das Haupt-Label zusammenbauen
ls_return = "			<subreport>" + is_crlf
ls_return += "				<reportElement x='"+ String(ll_x) +"' y='"+ String(ll_y) +"' width='"+ String(ll_width) +"' height='"+ String(ll_height) +"' uuid='" + of_uuid() +"'>" + is_crlf
ls_return += "					<property name='com.jaspersoft.studio.unit.x' value='pixel'/>" + is_crlf
ls_return += "					<property name='com.jaspersoft.studio.unit.y' value='pixel'/>" + is_crlf
ls_return += "					<property name='com.jaspersoft.studio.unit.width' value='pixel'/>" + is_crlf
ls_return += "				</reportElement>" + is_crlf
ls_return += "				<connectionExpression><![CDATA[$P{REPORT_CONNECTION}]]></connectionExpression>" + is_crlf
ls_return += '				<subreportExpression><![CDATA[$P{SUBREPORT_DIR} +"' + ls_jasper_subreport_name + '.jasper"]]></subreportExpression>' + is_crlf
ls_return += "			</subreport>" + is_crlf

Return ls_return

end function

public function string of_create_query_backlog_count ();
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_query_backlog_count (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 14.03.2018
//
// Argument(e):
// none
//
// Beschreibung:		Sub Query Count Backlog
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	14.03.2018		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------


String	ls_Query



ls_Query += ' select count(*) from ( '  + is_crlf
ls_Query += ' Select tab_bl.ncolumn, tab_bl.nrow, tab_bl.nmaxcontent, Count(cpackinglist) '  + is_crlf
ls_Query += '   From (        '  + is_crlf
ls_Query += "         Select 'DISTRIBUTED' ccarttype, "  + is_crlf
ls_Query += '                 dr.ncolumn ncolumn, '  + is_crlf
ls_Query += '                 dr.nrung nrow, '  + is_crlf
ls_Query += '                 dr.ntype,               '  + is_crlf
ls_Query += '                 co.cparent, '  + is_crlf
ls_Query += '                 co.ncount, '  + is_crlf
ls_Query += '                 co.cpackinglist, '  + is_crlf
ls_Query += '                 co.citem, '  + is_crlf
ls_Query += '                 rownum nsort, '  + is_crlf
ls_Query += '                 co.ncontent, '  + is_crlf
ls_Query += '                 co.nsd_content_key, '  + is_crlf
ls_Query += '                 Case '  + is_crlf
ls_Query += '                    When dr.nwidth Is Null Then '  + is_crlf
ls_Query += ' 1 '  + is_crlf
ls_Query += '                    Else '  + is_crlf
ls_Query += '                     dr.nwidth '  + is_crlf
ls_Query += '                 End nwidth, '  + is_crlf
ls_Query += '                 Case '  + is_crlf
ls_Query += '                    When dr.nheight Is Null Then '  + is_crlf
ls_Query += ' 1 '  + is_crlf
ls_Query += '                    Else '  + is_crlf
ls_Query += '                     dr.nheight '  + is_crlf
ls_Query += '                 End nheight, '  + is_crlf
ls_Query += '                 co.nbold, '  + is_crlf
ls_Query += "                 co.ncount || ' x ' || co.citem cdisplay, "  + is_crlf
ls_Query += '                 Case dr.ntype '  + is_crlf
ls_Query += '                    When 2 Then '  + is_crlf
ls_Query += ' 2 '  + is_crlf
ls_Query += '                    When 4 Then '  + is_crlf
ls_Query += ' 2 '  + is_crlf
ls_Query += '                    When 3 Then '  + is_crlf
ls_Query += ' 5 '  + is_crlf
ls_Query += '                    When 1 Then '  + is_crlf
ls_Query += ' 6 '  + is_crlf
ls_Query += '                    When 9 Then '  + is_crlf
ls_Query += ' 0 '  + is_crlf
ls_Query += '                    When 13 Then '  + is_crlf
ls_Query += '                     (Case '  + is_crlf
ls_Query += '                    When dr.nheight = 1 Then '  + is_crlf
ls_Query += '                     ((dr.nheight * 3) - 1) * dr.nwidth '  + is_crlf
ls_Query += '                    When dr.nheight = 2 Then '  + is_crlf
ls_Query += '                     (dr.nheight * 3) * dr.nwidth '  + is_crlf
ls_Query += '                    When dr.nheight = 3 Then '  + is_crlf
ls_Query += '                     (dr.nheight * 3) * dr.nwidth '  + is_crlf
ls_Query += '                    When dr.nheight = 4 Then '  + is_crlf
ls_Query += '                     ((dr.nheight * 3) + 1) * dr.nwidth '  + is_crlf
ls_Query += '                    When dr.nheight = 5 Then '  + is_crlf
ls_Query += '                     ((dr.nheight * 3) + 2) * dr.nwidth '  + is_crlf
ls_Query += '                    When dr.nheight = 6 Then '  + is_crlf
ls_Query += '                     ((dr.nheight * 3) + 2) * dr.nwidth '  + is_crlf
ls_Query += '                    When dr.nheight > 6 Then '  + is_crlf
ls_Query += '                     ((dr.nheight * 3) + 4) * dr.nwidth '  + is_crlf
ls_Query += '                 End) Else 0 End nmaxcontent '  + is_crlf
ls_Query += '           From cen_out_sd sd, cen_out_sd_drawer dr, cen_out_sd_content co '  + is_crlf
ls_Query += '          Where sd.nresult_key =  $P{arg_result_key} '  + is_crlf
ls_Query += "            And Replace(sd.cstowage, ' ', '') =  $P{arg_stowage} "  + is_crlf
ls_Query += '            And dr.nrowid = sd.nrowid '  + is_crlf
ls_Query += '            And dr.nresult_key = sd.nresult_key '  + is_crlf
ls_Query += '            And co.nresult_key = dr.nresult_key '  + is_crlf
ls_Query += '            And co.nsd_drawer_key = dr.nsd_drawer_key '  + is_crlf
ls_Query += '            And co.ndistributed = 1         '  + is_crlf
ls_Query += '         Union '  + is_crlf
ls_Query += "         Select 'CONTENT' ctype, "  + is_crlf
ls_Query += '                ld.ncolumn, '  + is_crlf
ls_Query += '                ld.nrow, '  + is_crlf
ls_Query += '                ld.ntype, '  + is_crlf
ls_Query += '                pi.cpackinglist, '  + is_crlf
ls_Query += '                pd.nquantity, '  + is_crlf
ls_Query += '                pi.cpackinglist, '  + is_crlf
ls_Query += '                pl.ctext, '  + is_crlf
ls_Query += '                0 nsort, '  + is_crlf
ls_Query += '                ld.ncontent, '  + is_crlf
ls_Query += '                ld.norder, '  + is_crlf
ls_Query += '                Case '  + is_crlf
ls_Query += '                   When ld.ncolumns Is Null Then '  + is_crlf
ls_Query += ' 1 '  + is_crlf
ls_Query += '                   Else '  + is_crlf
ls_Query += '                    ld.ncolumns '  + is_crlf
ls_Query += '                End, '  + is_crlf
ls_Query += '                Case '  + is_crlf
ls_Query += '                   When ld.nrungs Is Null Then '  + is_crlf
ls_Query += ' 1 '  + is_crlf
ls_Query += '                   Else '  + is_crlf
ls_Query += '                    ld.nrungs '  + is_crlf
ls_Query += '                End,                '  + is_crlf
ls_Query += '                pc.nheader_flag, '  + is_crlf
ls_Query += "                pd.nquantity || ' x ' || pl.ctext cdisplay, "  + is_crlf
ls_Query += '                Case ld.ntype '  + is_crlf
ls_Query += '                   When 2 Then '  + is_crlf
ls_Query += ' 2 '  + is_crlf
ls_Query += '                   When 4 Then '  + is_crlf
ls_Query += ' 2 '  + is_crlf
ls_Query += '                   When 3 Then '  + is_crlf
ls_Query += ' 5 '  + is_crlf
ls_Query += '                   When 1 Then '  + is_crlf
ls_Query += ' 6 '  + is_crlf
ls_Query += '                   When 9 Then '  + is_crlf
ls_Query += ' 0 '  + is_crlf
ls_Query += '                   When 13 Then '  + is_crlf
ls_Query += '                    (Case '  + is_crlf
ls_Query += '                   When ld.nrungs = 1 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) - 1) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 2 Then '  + is_crlf
ls_Query += '                    (ld.nrungs * 3) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 3 Then '  + is_crlf
ls_Query += '                    (ld.nrungs * 3) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 4 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 1) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 5 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 2) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 6 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 2) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs > 6 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 4) * ld.ncolumns '  + is_crlf
ls_Query += '                End) Else 0 End nmaxcontent '  + is_crlf
ls_Query += '           From cen_pl_layout_detail   ld, '  + is_crlf
ls_Query += '                cen_pl_layout_contents pc, '  + is_crlf
ls_Query += '                cen_packinglist_index  pi, '  + is_crlf
ls_Query += '                cen_packinglist_detail pd, '  + is_crlf
ls_Query += '                cen_packinglist_layout ll, '  + is_crlf
ls_Query += '                cen_packinglists       pl, '  + is_crlf
ls_Query += '                cen_out_sd             xx '  + is_crlf
ls_Query += '          Where ll.npackinglist_index_key = xx.nindex_key '  + is_crlf
ls_Query += '            And ll.npackinglist_detail_key = xx.ndetail_key '  + is_crlf
ls_Query += '            And ll.nlayout_key = ld.nlayout_key '  + is_crlf
ls_Query += '            And pc.nlayout_detail_key = ld.nlayout_detail_key '  + is_crlf
ls_Query += '            And pi.npackinglist_index_key = pd.ndetail_key '  + is_crlf
ls_Query += '            And pd.nlayout_content_key = pc.nlayout_content_key '  + is_crlf
ls_Query += '            And pl.npackinglist_index_key = pd.ndetail_key '  + is_crlf
ls_Query += '            And (Sysdate Between pl.dvalid_from And pl.dvalid_to) '  + is_crlf
ls_Query += '            And xx.nresult_key =  $P{arg_result_key} '  + is_crlf
ls_Query += "            And Replace(xx.cstowage, ' ', '') =  $P{arg_stowage} "  + is_crlf
ls_Query += '            And Not Exists (Select dr.nsd_drawer_key '  + is_crlf
ls_Query += '                   From cen_out_sd sd, cen_out_sd_drawer dr '  + is_crlf
ls_Query += '                  Where sd.nresult_key =  $P{arg_result_key} '  + is_crlf
ls_Query += "                    And Replace(sd.cstowage, ' ', '') =  $P{arg_stowage} "  + is_crlf
ls_Query += '                    And dr.nrowid = sd.nrowid '  + is_crlf
ls_Query += '                    And ld.ncolumn = dr.ncolumn '  + is_crlf
ls_Query += '                    And ld.nrow = dr.nrung '  + is_crlf
ls_Query += '                    And dr.nresult_key = sd.nresult_key '  + is_crlf
ls_Query += '                    And dr.nempty = 1) '  + is_crlf
ls_Query += '         Union '  + is_crlf
ls_Query += "         Select 'EXPLOSION', "  + is_crlf
ls_Query += '                ld.ncolumn, '  + is_crlf
ls_Query += '                ld.nrow, '  + is_crlf
ls_Query += '                ld.ntype,              '  + is_crlf
ls_Query += '                pi.cpackinglist, '  + is_crlf
ls_Query += '                ex.nquantity, '  + is_crlf
ls_Query += '                pe.cpackinglist, '  + is_crlf
ls_Query += '                et.ctext, '  + is_crlf
ls_Query += '                ex.nsort, '  + is_crlf
ls_Query += '                ld.ncontent, '  + is_crlf
ls_Query += '                ld.norder,                '  + is_crlf
ls_Query += '                Case '  + is_crlf
ls_Query += '                   When ld.ncolumns Is Null Then '  + is_crlf
ls_Query += ' 1 '  + is_crlf
ls_Query += '                   Else '  + is_crlf
ls_Query += '                    ld.ncolumns '  + is_crlf
ls_Query += '                End, '  + is_crlf
ls_Query += '                Case '  + is_crlf
ls_Query += '                   When ld.nrungs Is Null Then '  + is_crlf
ls_Query += ' 1 '  + is_crlf
ls_Query += '                   Else '  + is_crlf
ls_Query += '                    ld.nrungs '  + is_crlf
ls_Query += '                End,                '  + is_crlf
ls_Query += '                pc.nheader_flag, '  + is_crlf
ls_Query += "                ex.nquantity || ' x ' || et.ctext cdisplay, "  + is_crlf
ls_Query += '                Case ld.ntype '  + is_crlf
ls_Query += '                   When 2 Then '  + is_crlf
ls_Query += ' 2 '  + is_crlf
ls_Query += '                   When 4 Then '  + is_crlf
ls_Query += ' 2 '  + is_crlf
ls_Query += '                   When 3 Then '  + is_crlf
ls_Query += ' 5 '  + is_crlf
ls_Query += '                   When 1 Then '  + is_crlf
ls_Query += ' 6 '  + is_crlf
ls_Query += '                   When 9 Then '  + is_crlf
ls_Query += ' 0 '  + is_crlf
ls_Query += '                   When 13 Then '  + is_crlf
ls_Query += '                    (Case '  + is_crlf
ls_Query += '                   When ld.nrungs = 1 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) - 1) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 2 Then '  + is_crlf
ls_Query += '                    (ld.nrungs * 3) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 3 Then '  + is_crlf
ls_Query += '                    (ld.nrungs * 3) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 4 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 1) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 5 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 2) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 6 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 2) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs > 6 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 4) * ld.ncolumns '  + is_crlf
ls_Query += '                End) Else 0 End nmaxcontent '  + is_crlf
ls_Query += '           From cen_pl_layout_detail   ld, '  + is_crlf
ls_Query += '                cen_pl_layout_contents pc, '  + is_crlf
ls_Query += '                cen_packinglist_index  pi, '  + is_crlf
ls_Query += '                cen_packinglist_detail pd, '  + is_crlf
ls_Query += '                cen_packinglist_layout ll, '  + is_crlf
ls_Query += '                cen_packinglist_detail ex, '  + is_crlf
ls_Query += '                cen_packinglist_index  pe, '  + is_crlf
ls_Query += '                cen_packinglists       et, '  + is_crlf
ls_Query += '                cen_out_sd             xx '  + is_crlf
ls_Query += '          Where ll.npackinglist_index_key = xx.nindex_key '  + is_crlf
ls_Query += '            And ll.npackinglist_detail_key = xx.ndetail_key '  + is_crlf
ls_Query += '            And ll.nlayout_key = ld.nlayout_key '  + is_crlf
ls_Query += '            And xx.nresult_key =  $P{arg_result_key} '  + is_crlf
ls_Query += "            And Replace(xx.cstowage, ' ', '') =  $P{arg_stowage} "  + is_crlf
ls_Query += '            And pc.nlayout_detail_key = ld.nlayout_detail_key '  + is_crlf
ls_Query += '            And pi.npackinglist_index_key = pd.ndetail_key '  + is_crlf
ls_Query += '            And pd.nlayout_content_key = pc.nlayout_content_key '  + is_crlf
ls_Query += '            And (ld.ncontent = 2 Or pc.nheader_flag = 1) '  + is_crlf
ls_Query += '            And ex.npackinglist_index_key = pd.ndetail_key '  + is_crlf
ls_Query += '            And pe.npackinglist_index_key = ex.ndetail_key '  + is_crlf
ls_Query += '            And (Sysdate Between ex.dvalid_from And ex.dvalid_to) '  + is_crlf
ls_Query += '            And et.npackinglist_index_key = ex.ndetail_key '  + is_crlf
ls_Query += '            And (Sysdate Between et.dvalid_from And et.dvalid_to)         '  + is_crlf
ls_Query += '         Union         '  + is_crlf
ls_Query += "         Select 'SECDISERR', "  + is_crlf
ls_Query += ' 0 nzero1, '  + is_crlf
ls_Query += ' 0 nzero2, '  + is_crlf
ls_Query += '                mm.ntype, '  + is_crlf
ls_Query += "                ' ' cparent, "  + is_crlf
ls_Query += ' 1 none1, '  + is_crlf
ls_Query += '                mm.ccomponent, '  + is_crlf
ls_Query += '                mm.ctext, '  + is_crlf
ls_Query += '                mm.nsd_msg_key, '  + is_crlf
ls_Query += '                0 ncontent, '  + is_crlf
ls_Query += '                mm.nsd_msg_key, '  + is_crlf
ls_Query += '                0 nwidth, '  + is_crlf
ls_Query += '                0 nheight, '  + is_crlf
ls_Query += '                0 nbold, '  + is_crlf
ls_Query += '                mm.ctext cdisplay, '  + is_crlf
ls_Query += '                0 nmaxcontent '  + is_crlf
ls_Query += '           From cen_out_sd_message mm '  + is_crlf
ls_Query += '          Where mm.nresult_key =  $P{arg_result_key} '  + is_crlf
ls_Query += "            And mm.cgalley || '-' || Replace(mm.cstowage, ' ', '') =  $P{arg_stowage} "  + is_crlf
ls_Query += '            And mm.ndistribution = 0 '  + is_crlf
ls_Query += '          Order By ncolumn, nrow, nsort) tab_bl '  + is_crlf
ls_Query += '  Group By tab_bl.ncolumn, tab_bl.nrow, tab_bl.nmaxcontent '  + is_crlf
ls_Query += ' Having nmaxcontent < Count(cpackinglist)) '  + is_crlf

return ls_Query
end function

public function string of_create_query_original ();
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_query (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 13.03.2017
//
// Argument(e):
// none
//
// Beschreibung:		Select cen_out join cen_out_md_lo 
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	13.03.2017		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------


String	ls_return

ls_return += '<queryString>' +is_crlf
ls_return += '<![CDATA[Select co.cairline,' +is_crlf
ls_return += '       co.ddeparture,' +is_crlf
ls_return += '       co.nflight_number,' +is_crlf
ls_return += '       co.cdeparture_time,' +is_crlf
ls_return += '       co.cramp_time,' +is_crlf
ls_return += '       co.cactype,' +is_crlf
ls_return += "       co.cairline || ' ' || to_char(co.nflight_number) CFLIGHT," + is_crlf
ls_return += "       md.cgalley || '-' || md.cstowage || Trim(md.cplace) CSTPOSITION," +is_crlf
ls_return += '       md.nresult_key,' +is_crlf
ls_return += '       md.ntransaction,' +is_crlf
ls_return += '       md.nrecord_count,' +is_crlf
ls_return += '       md.cstowage,' +is_crlf
ls_return += '       md.cplace,' +is_crlf
ls_return += '       md.nsort_stow,' +is_crlf
ls_return += '       md.npage,' +is_crlf
ls_return += '       md.nxpos,' +is_crlf
ls_return += '       md.nypos,' +is_crlf
ls_return += '       md.cgalley,' +is_crlf
ls_return += '       md.nsort_gal,' +is_crlf
ls_return += '       md.nequipment_width,' +is_crlf
ls_return += '       md.nequipment_height,' +is_crlf
ls_return += '       md.nloadinglist_index_key_lo,' +is_crlf
ls_return += '       md.cpackinglist,' +is_crlf
ls_return += '       md.cloadinglist,' +is_crlf
ls_return += '       md.ctext_pckl,' +is_crlf
ls_return += '       md.cunit,' +is_crlf
ls_return += '       md.nloadinglist_key,' +is_crlf
ls_return += '       md.dvalid_from,' +is_crlf
ls_return += '       md.dvalid_to,' +is_crlf
ls_return += '       md.cfrequency,' +is_crlf
ls_return += '       md.ctime_from,' +is_crlf
ls_return += '       md.ctime_to,' +is_crlf
ls_return += '       md.cclass,' +is_crlf
ls_return += '       md.cadd_on_text,' +is_crlf
ls_return += '       md.cactioncode,' +is_crlf
ls_return += '       md.nbelly_container,' +is_crlf
ls_return += '       md.nquantity,' +is_crlf
ls_return += '       md.nlabel_quantity,' +is_crlf
ls_return += '       md.nlabel_type_key,' +is_crlf
ls_return += '       md.cmeal_control_code,' +is_crlf
ls_return += '       md.nstowage_key,' +is_crlf
ls_return += '       md.cfontname,' +is_crlf
ls_return += '       md.nfontbold,' +is_crlf
ls_return += '       md.nfontitalic,' +is_crlf
ls_return += '       md.nfontcolor,' +is_crlf
ls_return += '       md.nobjectborder,' +is_crlf
ls_return += '       md.nobjectcolor,' +is_crlf
ls_return += '       md.nobjectbackgroundcolor,' +is_crlf
ls_return += '       md.nfontsize,' +is_crlf
ls_return += '       md.nobjectlinewidth,' +is_crlf
ls_return += '       md.npackinglist_key,' +is_crlf
ls_return += '       md.ctext_short,' +is_crlf
ls_return += '       md.ngalley_key,' +is_crlf
ls_return += '       md.ctext_stow,' +is_crlf
ls_return += '       md.nequipment_resize,' +is_crlf
ls_return += '       md.nweight_stow,' +is_crlf
ls_return += '       md.nfor_to_code,' +is_crlf
ls_return += '       md.ntlc_key,' +is_crlf
ls_return += '       md.ctlc,' +is_crlf
ls_return += '       md.npackinglist_index_key,' +is_crlf
ls_return += '       md.nloadinglist_detail_key,' +is_crlf
ls_return += '       md.nloadinglist_index_key_loi,' +is_crlf
ls_return += '       md.dtimestamp_modification,' +is_crlf
ls_return += '       md.npackinglist_detail_key,' +is_crlf
ls_return += '       md.ngalley_group,' +is_crlf
ls_return += '       md.ncatering_leg,' +is_crlf
ls_return += '       md.nranking,' +is_crlf
ls_return += '       md.nlimit,' +is_crlf
ls_return += '       md.nranking_spml,' +is_crlf
ls_return += '       md.nlimit_spml,' +is_crlf
ls_return += '       md.nreckoning,' +is_crlf
ls_return += '       md.nweight_pckl,' +is_crlf
ls_return += '       md.nweight_gal,' +is_crlf
ls_return += '       md.cclass1,' +is_crlf
ls_return += '       md.cclass2,' +is_crlf
ls_return += '       md.cclass3,' +is_crlf
ls_return += '       md.npl_kind_key,' +is_crlf
ls_return += '       md.nseparator,' +is_crlf
ls_return += '       md.ccustomer_pl,' +is_crlf
ls_return += '       md.ccustomer_text,' +is_crlf
ls_return += '       md.naccount_key,' +is_crlf
ls_return += '       md.caccount,' +is_crlf
ls_return += '       md.ntransporter_cart,' +is_crlf
ls_return += '       md.csales_rel,' +is_crlf
ls_return += '       md.cdef_storage_location,' +is_crlf
ls_return += '       md.cgoods_recipient,' +is_crlf
ls_return += '       md.cclass4,' +is_crlf
ls_return += '       md.cclass5,' +is_crlf
ls_return += '       md.cclass6,' +is_crlf
ls_return += '       md.ncom_actioncode,' +is_crlf
ls_return += '       md.ncom_fontheight,' +is_crlf
ls_return += '       md.ncom_usefontsize,' +is_crlf
ls_return += '       md.ncom_rowprinted,' +is_crlf
ls_return += '       md.ccom_classname,' +is_crlf
ls_return += '       md.ccom_zustautext,' +is_crlf
ls_return += '       md.ncom_exclude,' +is_crlf
ls_return += '       md.ccom_qaq_actioncode,' +is_crlf
ls_return += '       md.ccom_sicodes,' +is_crlf
ls_return += '       md.ncom_handling_key,' +is_crlf
ls_return += '       md.ncom_calcweight,' +is_crlf
ls_return += '       md.ncom_nlabel_type,' +is_crlf
ls_return += '       md.ncom_nprint,' +is_crlf
ls_return += '       md.ncom_labelprinting,' +is_crlf
ls_return += '       md.ncom_stationinstruction,' +is_crlf
ls_return += '       md.ncom_nworkstationkey,' +is_crlf
ls_return += '       md.ccom_cworkstation,' +is_crlf
ls_return += '       md.ncom_nareakey,' +is_crlf
ls_return += '       md.ccom_carea,' +is_crlf
ls_return += '       md.ccom_carea_code,' +is_crlf
ls_return += '       md.ncom_npltype,' +is_crlf
ls_return += '       md.ccom_pldetail_text,' +is_crlf
ls_return += '       md.ccom_pldetail_label_counter,' +is_crlf
ls_return += '       md.ncom_ndistribution_detail_key,' +is_crlf
ls_return += '       md.ncom_ndistribution_key,' +is_crlf
ls_return += '       md.ncom_nunit_priority,' +is_crlf
ls_return += '       md.ccom_cdistributed_components,' +is_crlf
ls_return += '       md.ncom_nclass_number,' +is_crlf
ls_return += '       md.ncom_nremove,' +is_crlf
ls_return += '       md.ccom_cworkstation_text,' +is_crlf
ls_return += '       md.ncom_nduplicated,' +is_crlf
ls_return += '       md.ccom_cunit_time,' +is_crlf
ls_return += '       md.ncom_nmodified,' +is_crlf
ls_return += '       md.ccom_crampbox,' +is_crlf
ls_return += '       md.ccom_carea_list,' +is_crlf
ls_return += '       md.ccom_cws_list,' +is_crlf
ls_return += '       md.ccom_pldetail_explosion,' +is_crlf
ls_return += '       md.ccom_pl_to_explode,' +is_crlf
ls_return += '       md.ncom_nrowid,' +is_crlf
ls_return += '       md.ncom_nramp_box_mode,' +is_crlf
ls_return += '       md.ccom_crampbox2,' +is_crlf
ls_return += '       md.ccom_crtn_components,' +is_crlf
ls_return += '       md.cppsunit,' +is_crlf
ls_return += '       md.cppscoldstore,' +is_crlf
ls_return += '       md.nppslotnr,' +is_crlf
ls_return += '       md.cppscontainer,' +is_crlf
ls_return += '       md.cppsehb,' +is_crlf
ls_return += '       md.cppsbox,' +is_crlf
ls_return += '       md.cppsumstau,' +is_crlf
ls_return += '       md.cppsab,' +is_crlf
ls_return += '       md.nflight_label,' +is_crlf
ls_return += '       md.napproved,' +is_crlf
ls_return += '       md.ccreated_by,' +is_crlf
ls_return += '       md.dcreated_date,' +is_crlf
ls_return += '       md.ctext_ll, ' +is_crlf
ls_return += '       su.chealthmark1,' +is_crlf
ls_return += '       su.chealthmark2,' +is_crlf
ls_return += '       su.chealthmark3,' +is_crlf
ls_return += '       sd.cmulti_ws_1,' +is_crlf
ls_return += "      co.cbox_from || '-' || co.cbox_to CRAMPBOX," +is_crlf

//ls_return += ' (  Select count(*)' +is_crlf
//ls_return += '  From cen_out_sd_message mm, cen_out_sd sd' +is_crlf
//ls_return += ' Where mm.nresult_key =   $P{arg_result_key}' +is_crlf
//ls_return += '   And sd.nresult_key = mm.nresult_key' +is_crlf
//ls_return += '   And sd.ntransaction = mm.ntransaction' +is_crlf
//ls_return += "   And replace(sd.cstowage, ' ', '') =  $P{arg_stowage}" +is_crlf
//ls_return += '   And mm.nrowid = sd.nrowid' +is_crlf
//ls_return += '    And mm.ntype is not null) nnumbacklog,' +is_crlf

//################# BACKLOG COUNT

ls_return +=  '('  + of_create_query_backlog_count() + ') nnumbacklog,' + is_crlf

//####################

ls_return += '       (Select Count(*)' +is_crlf
ls_return += '       From cen_out co, cen_out_md_co md, cen_out_md xx' +is_crlf
ls_return += '      Where co.nresult_key = md.nresult_key' +is_crlf
ls_return += '        And co.ntransaction = md.ntransaction' +is_crlf
ls_return += '        And co.nresult_key = xx.nresult_key' +is_crlf
ls_return += '        And co.ntransaction = xx.ntransaction' +is_crlf
ls_return += '        And xx.narray_count = md.narray_count' +is_crlf
ls_return += '        And co.nresult_key = $P{arg_result_key}' +is_crlf
ls_return += "        And Replace(xx.cstowage, ' ', '') =  $P{arg_stowage}  ) ncompoverflow" +is_crlf  

ls_return += '        , ca.nprint_overflow_on_main' +is_crlf

ls_return += '   From cen_out co, cen_out_md_lo md, sys_units su, cen_out_sd sd, cen_airlines ca' +is_crlf
//ls_return += '   From cen_out co, cen_out_md_lo md, sys_units su, cen_out_sd sd' +is_crlf
ls_return += '   Where co.nresult_key = md.nresult_key' +is_crlf
ls_return += '   and su.cunit = co.cunit' +is_crlf
ls_return += '   And co.ntransaction = md.ntransaction' +is_crlf
ls_return += '   And co.nresult_key =  $P{arg_result_key}' +is_crlf

ls_return += '   And co.nairline_key =  ca.nairline_key' +is_crlf

ls_return += "   And md.cgalley || '-' || md.cstowage || Trim(md.cplace) = $P{arg_stowage}" +is_crlf
ls_return += '    And sd.nresult_key (+)= co.nresult_key' +is_crlf
ls_return += '   And sd.ntransaction (+)= co.ntransaction' +is_crlf

ls_return += "   And ( replace (sd.cstowage, ' ', '') =  $P{arg_stowage}  OR  sd.cstowage is null ) ]]>" +is_crlf


//ls_return += '    And sd.nresult_key = co.nresult_key' +is_crlf
//ls_return += '   And sd.ntransaction = co.ntransaction' +is_crlf
//
//ls_return += '   And Trim(sd.cstowage) =  $P{arg_stowage}]]>' +is_crlf

// AND replace (sd.cstowage, ' ', '') = 'G4-70F'
//ls_return += "   And  replace (sd.cstowage, ' ', '') =  $P{arg_stowage}]]>" +is_crlf

//ls_return += '       su.chealthmark1, su.chealthmark2, su.chealthmark3' +is_crlf
//ls_return += '   From cen_out co, cen_out_md_lo md, sys_units su' +is_crlf
//ls_return += '   Where co.nresult_key = md.nresult_key' +is_crlf
//ls_return += '   and su.cunit = co.cunit' +is_crlf
//ls_return += '   And co.ntransaction = md.ntransaction' +is_crlf
//ls_return += '   And co.nresult_key =  $P{arg_result_key}' +is_crlf
//ls_return += "   And md.cgalley || '-' || md.cstowage || Trim(md.cplace) = $P{arg_stowage}]]>" +is_crlf

//ls_return += "   And md.cgalley || '-' || md.cstowage || Trim(md.cplace) = '$P{arg_stowage}']]>" +is_crlf
//ls_return += '   And co.nresult_key = 82951474' +is_crlf
//ls_return += "			and cen_out.nresult_key = $P{arg_result_key}"+ is_crlf 
//ls_return += "   And md.cgalley || '-' || md.cstowage || Trim(md.cplace) = '5-20']]>" +is_crlf

ls_return += '</queryString>' +is_crlf
ls_return += '<field name="CAIRLINE" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="DDEPARTURE" class="java.sql.Timestamp"/>' +is_crlf
ls_return += '<field name="NFLIGHT_NUMBER" class="java.math.BigDecimal"/>' +is_crlf
ls_return += '<field name="CDEPARTURE_TIME" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CRAMP_TIME" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CACTYPE" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CFLIGHT" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CSTPOSITION" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CUNIT" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CPACKINGLIST" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CLOADINGLIST" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CTEXT_PCKL" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CCLASS" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CADD_ON_TEXT" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CCOM_CAREA" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CCOM_CWORKSTATION" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CCOM_CAREA_CODE" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CHEALTHMARK1" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CHEALTHMARK2" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CHEALTHMARK3" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CMULTI_WS_1" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="CRAMPBOX" class="java.lang.String"/>' +is_crlf
ls_return += '<field name="NNUMBACKLOG" class="java.lang.Long"/>	' +is_crlf
ls_return += '<field name="NCOMPOVERFLOW" class="java.lang.Long"/>	' +is_crlf
ls_return += '<field name="NPRINT_OVERFLOW_ON_MAIN" class="java.lang.Long"/>	' +is_crlf


return ls_return 
end function

public function string of_create_query_backog_count_original ();
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_create_query_backlog_count (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 14.03.2018
//
// Argument(e):
// none
//
// Beschreibung:		Sub Query Count Backlog
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	14.03.2018		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------


String	ls_Query



ls_Query += ' select count(*) from ( '  + is_crlf
ls_Query += ' Select tab_bl.ncolumn, tab_bl.nrow, tab_bl.nmaxcontent, Count(cpackinglist) '  + is_crlf
ls_Query += '   From (        '  + is_crlf
ls_Query += "         Select 'DISTRIBUTED' ccarttype, "  + is_crlf
ls_Query += '                 dr.ncolumn ncolumn, '  + is_crlf
ls_Query += '                 dr.nrung nrow, '  + is_crlf
ls_Query += '                 dr.ntype,               '  + is_crlf
ls_Query += '                 co.cparent, '  + is_crlf
ls_Query += '                 co.ncount, '  + is_crlf
ls_Query += '                 co.cpackinglist, '  + is_crlf
ls_Query += '                 co.citem, '  + is_crlf
ls_Query += '                 rownum nsort, '  + is_crlf
ls_Query += '                 co.ncontent, '  + is_crlf
ls_Query += '                 co.nsd_content_key, '  + is_crlf
ls_Query += '                 Case '  + is_crlf
ls_Query += '                    When dr.nwidth Is Null Then '  + is_crlf
ls_Query += ' 1 '  + is_crlf
ls_Query += '                    Else '  + is_crlf
ls_Query += '                     dr.nwidth '  + is_crlf
ls_Query += '                 End nwidth, '  + is_crlf
ls_Query += '                 Case '  + is_crlf
ls_Query += '                    When dr.nheight Is Null Then '  + is_crlf
ls_Query += ' 1 '  + is_crlf
ls_Query += '                    Else '  + is_crlf
ls_Query += '                     dr.nheight '  + is_crlf
ls_Query += '                 End nheight, '  + is_crlf
ls_Query += '                 co.nbold, '  + is_crlf
ls_Query += "                 co.ncount || ' x ' || co.citem cdisplay, "  + is_crlf
ls_Query += '                 Case dr.ntype '  + is_crlf
ls_Query += '                    When 2 Then '  + is_crlf
ls_Query += ' 2 '  + is_crlf
ls_Query += '                    When 4 Then '  + is_crlf
ls_Query += ' 2 '  + is_crlf
ls_Query += '                    When 3 Then '  + is_crlf
ls_Query += ' 5 '  + is_crlf
ls_Query += '                    When 1 Then '  + is_crlf
ls_Query += ' 6 '  + is_crlf
ls_Query += '                    When 9 Then '  + is_crlf
ls_Query += ' 0 '  + is_crlf
ls_Query += '                    When 13 Then '  + is_crlf
ls_Query += '                     (Case '  + is_crlf
ls_Query += '                    When dr.nheight = 1 Then '  + is_crlf
ls_Query += '                     ((dr.nheight * 3) - 1) * dr.nwidth '  + is_crlf
ls_Query += '                    When dr.nheight = 2 Then '  + is_crlf
ls_Query += '                     (dr.nheight * 3) * dr.nwidth '  + is_crlf
ls_Query += '                    When dr.nheight = 3 Then '  + is_crlf
ls_Query += '                     (dr.nheight * 3) * dr.nwidth '  + is_crlf
ls_Query += '                    When dr.nheight = 4 Then '  + is_crlf
ls_Query += '                     ((dr.nheight * 3) + 1) * dr.nwidth '  + is_crlf
ls_Query += '                    When dr.nheight = 5 Then '  + is_crlf
ls_Query += '                     ((dr.nheight * 3) + 2) * dr.nwidth '  + is_crlf
ls_Query += '                    When dr.nheight = 6 Then '  + is_crlf
ls_Query += '                     ((dr.nheight * 3) + 2) * dr.nwidth '  + is_crlf
ls_Query += '                    When dr.nheight > 6 Then '  + is_crlf
ls_Query += '                     ((dr.nheight * 3) + 4) * dr.nwidth '  + is_crlf
ls_Query += '                 End) Else 0 End nmaxcontent '  + is_crlf
ls_Query += '           From cen_out_sd sd, cen_out_sd_drawer dr, cen_out_sd_content co '  + is_crlf
ls_Query += '          Where sd.nresult_key =  $P{arg_result_key} '  + is_crlf
ls_Query += "            And Replace(sd.cstowage, ' ', '') =  $P{arg_stowage} "  + is_crlf
ls_Query += '            And dr.nrowid = sd.nrowid '  + is_crlf
ls_Query += '            And dr.nresult_key = sd.nresult_key '  + is_crlf
ls_Query += '            And co.nresult_key = dr.nresult_key '  + is_crlf
ls_Query += '            And co.nsd_drawer_key = dr.nsd_drawer_key '  + is_crlf
ls_Query += '            And co.ndistributed = 1         '  + is_crlf
ls_Query += '         Union '  + is_crlf
ls_Query += "         Select 'CONTENT' ctype, "  + is_crlf
ls_Query += '                ld.ncolumn, '  + is_crlf
ls_Query += '                ld.nrow, '  + is_crlf
ls_Query += '                ld.ntype, '  + is_crlf
ls_Query += '                pi.cpackinglist, '  + is_crlf
ls_Query += '                pd.nquantity, '  + is_crlf
ls_Query += '                pi.cpackinglist, '  + is_crlf
ls_Query += '                pl.ctext, '  + is_crlf
ls_Query += '                0 nsort, '  + is_crlf
ls_Query += '                ld.ncontent, '  + is_crlf
ls_Query += '                ld.norder, '  + is_crlf
ls_Query += '                Case '  + is_crlf
ls_Query += '                   When ld.ncolumns Is Null Then '  + is_crlf
ls_Query += ' 1 '  + is_crlf
ls_Query += '                   Else '  + is_crlf
ls_Query += '                    ld.ncolumns '  + is_crlf
ls_Query += '                End, '  + is_crlf
ls_Query += '                Case '  + is_crlf
ls_Query += '                   When ld.nrungs Is Null Then '  + is_crlf
ls_Query += ' 1 '  + is_crlf
ls_Query += '                   Else '  + is_crlf
ls_Query += '                    ld.nrungs '  + is_crlf
ls_Query += '                End,                '  + is_crlf
ls_Query += '                pc.nheader_flag, '  + is_crlf
ls_Query += "                pd.nquantity || ' x ' || pl.ctext cdisplay, "  + is_crlf
ls_Query += '                Case ld.ntype '  + is_crlf
ls_Query += '                   When 2 Then '  + is_crlf
ls_Query += ' 2 '  + is_crlf
ls_Query += '                   When 4 Then '  + is_crlf
ls_Query += ' 2 '  + is_crlf
ls_Query += '                   When 3 Then '  + is_crlf
ls_Query += ' 5 '  + is_crlf
ls_Query += '                   When 1 Then '  + is_crlf
ls_Query += ' 6 '  + is_crlf
ls_Query += '                   When 9 Then '  + is_crlf
ls_Query += ' 0 '  + is_crlf
ls_Query += '                   When 13 Then '  + is_crlf
ls_Query += '                    (Case '  + is_crlf
ls_Query += '                   When ld.nrungs = 1 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) - 1) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 2 Then '  + is_crlf
ls_Query += '                    (ld.nrungs * 3) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 3 Then '  + is_crlf
ls_Query += '                    (ld.nrungs * 3) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 4 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 1) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 5 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 2) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 6 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 2) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs > 6 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 4) * ld.ncolumns '  + is_crlf
ls_Query += '                End) Else 0 End nmaxcontent '  + is_crlf
ls_Query += '           From cen_pl_layout_detail   ld, '  + is_crlf
ls_Query += '                cen_pl_layout_contents pc, '  + is_crlf
ls_Query += '                cen_packinglist_index  pi, '  + is_crlf
ls_Query += '                cen_packinglist_detail pd, '  + is_crlf
ls_Query += '                cen_packinglist_layout ll, '  + is_crlf
ls_Query += '                cen_packinglists       pl, '  + is_crlf
ls_Query += '                cen_out_sd             xx '  + is_crlf
ls_Query += '          Where ll.npackinglist_index_key = xx.nindex_key '  + is_crlf
ls_Query += '            And ll.npackinglist_detail_key = xx.ndetail_key '  + is_crlf
ls_Query += '            And ll.nlayout_key = ld.nlayout_key '  + is_crlf
ls_Query += '            And pc.nlayout_detail_key = ld.nlayout_detail_key '  + is_crlf
ls_Query += '            And pi.npackinglist_index_key = pd.ndetail_key '  + is_crlf
ls_Query += '            And pd.nlayout_content_key = pc.nlayout_content_key '  + is_crlf
ls_Query += '            And pl.npackinglist_index_key = pd.ndetail_key '  + is_crlf
ls_Query += '            And (Sysdate Between pl.dvalid_from And pl.dvalid_to) '  + is_crlf
ls_Query += '            And xx.nresult_key =  $P{arg_result_key} '  + is_crlf
ls_Query += "            And Replace(xx.cstowage, ' ', '') =  $P{arg_stowage} "  + is_crlf
ls_Query += '            And Not Exists (Select dr.nsd_drawer_key '  + is_crlf
ls_Query += '                   From cen_out_sd sd, cen_out_sd_drawer dr '  + is_crlf
ls_Query += '                  Where sd.nresult_key =  $P{arg_result_key} '  + is_crlf
ls_Query += "                    And Replace(sd.cstowage, ' ', '') =  $P{arg_stowage} "  + is_crlf
ls_Query += '                    And dr.nrowid = sd.nrowid '  + is_crlf
ls_Query += '                    And ld.ncolumn = dr.ncolumn '  + is_crlf
ls_Query += '                    And ld.nrow = dr.nrung '  + is_crlf
ls_Query += '                    And dr.nresult_key = sd.nresult_key '  + is_crlf
ls_Query += '                    And dr.nempty = 1) '  + is_crlf
ls_Query += '         Union '  + is_crlf
ls_Query += "         Select 'EXPLOSION', "  + is_crlf
ls_Query += '                ld.ncolumn, '  + is_crlf
ls_Query += '                ld.nrow, '  + is_crlf
ls_Query += '                ld.ntype,              '  + is_crlf
ls_Query += '                pi.cpackinglist, '  + is_crlf
ls_Query += '                ex.nquantity, '  + is_crlf
ls_Query += '                pe.cpackinglist, '  + is_crlf
ls_Query += '                et.ctext, '  + is_crlf
ls_Query += '                ex.nsort, '  + is_crlf
ls_Query += '                ld.ncontent, '  + is_crlf
ls_Query += '                ld.norder,                '  + is_crlf
ls_Query += '                Case '  + is_crlf
ls_Query += '                   When ld.ncolumns Is Null Then '  + is_crlf
ls_Query += ' 1 '  + is_crlf
ls_Query += '                   Else '  + is_crlf
ls_Query += '                    ld.ncolumns '  + is_crlf
ls_Query += '                End, '  + is_crlf
ls_Query += '                Case '  + is_crlf
ls_Query += '                   When ld.nrungs Is Null Then '  + is_crlf
ls_Query += ' 1 '  + is_crlf
ls_Query += '                   Else '  + is_crlf
ls_Query += '                    ld.nrungs '  + is_crlf
ls_Query += '                End,                '  + is_crlf
ls_Query += '                pc.nheader_flag, '  + is_crlf
ls_Query += "                ex.nquantity || ' x ' || et.ctext cdisplay, "  + is_crlf
ls_Query += '                Case ld.ntype '  + is_crlf
ls_Query += '                   When 2 Then '  + is_crlf
ls_Query += ' 2 '  + is_crlf
ls_Query += '                   When 4 Then '  + is_crlf
ls_Query += ' 2 '  + is_crlf
ls_Query += '                   When 3 Then '  + is_crlf
ls_Query += ' 5 '  + is_crlf
ls_Query += '                   When 1 Then '  + is_crlf
ls_Query += ' 6 '  + is_crlf
ls_Query += '                   When 9 Then '  + is_crlf
ls_Query += ' 0 '  + is_crlf
ls_Query += '                   When 13 Then '  + is_crlf
ls_Query += '                    (Case '  + is_crlf
ls_Query += '                   When ld.nrungs = 1 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) - 1) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 2 Then '  + is_crlf
ls_Query += '                    (ld.nrungs * 3) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 3 Then '  + is_crlf
ls_Query += '                    (ld.nrungs * 3) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 4 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 1) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 5 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 2) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs = 6 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 2) * ld.ncolumns '  + is_crlf
ls_Query += '                   When ld.nrungs > 6 Then '  + is_crlf
ls_Query += '                    ((ld.nrungs * 3) + 4) * ld.ncolumns '  + is_crlf
ls_Query += '                End) Else 0 End nmaxcontent '  + is_crlf
ls_Query += '           From cen_pl_layout_detail   ld, '  + is_crlf
ls_Query += '                cen_pl_layout_contents pc, '  + is_crlf
ls_Query += '                cen_packinglist_index  pi, '  + is_crlf
ls_Query += '                cen_packinglist_detail pd, '  + is_crlf
ls_Query += '                cen_packinglist_layout ll, '  + is_crlf
ls_Query += '                cen_packinglist_detail ex, '  + is_crlf
ls_Query += '                cen_packinglist_index  pe, '  + is_crlf
ls_Query += '                cen_packinglists       et, '  + is_crlf
ls_Query += '                cen_out_sd             xx '  + is_crlf
ls_Query += '          Where ll.npackinglist_index_key = xx.nindex_key '  + is_crlf
ls_Query += '            And ll.npackinglist_detail_key = xx.ndetail_key '  + is_crlf
ls_Query += '            And ll.nlayout_key = ld.nlayout_key '  + is_crlf
ls_Query += '            And xx.nresult_key =  $P{arg_result_key} '  + is_crlf
ls_Query += "            And Replace(xx.cstowage, ' ', '') =  $P{arg_stowage} "  + is_crlf
ls_Query += '            And pc.nlayout_detail_key = ld.nlayout_detail_key '  + is_crlf
ls_Query += '            And pi.npackinglist_index_key = pd.ndetail_key '  + is_crlf
ls_Query += '            And pd.nlayout_content_key = pc.nlayout_content_key '  + is_crlf
ls_Query += '            And (ld.ncontent = 2 Or pc.nheader_flag = 1) '  + is_crlf
ls_Query += '            And ex.npackinglist_index_key = pd.ndetail_key '  + is_crlf
ls_Query += '            And pe.npackinglist_index_key = ex.ndetail_key '  + is_crlf
ls_Query += '            And (Sysdate Between ex.dvalid_from And ex.dvalid_to) '  + is_crlf
ls_Query += '            And et.npackinglist_index_key = ex.ndetail_key '  + is_crlf
ls_Query += '            And (Sysdate Between et.dvalid_from And et.dvalid_to)         '  + is_crlf
ls_Query += '         Union         '  + is_crlf
ls_Query += "         Select 'SECDISERR', "  + is_crlf
ls_Query += ' 0 nzero1, '  + is_crlf
ls_Query += ' 0 nzero2, '  + is_crlf
ls_Query += '                mm.ntype, '  + is_crlf
ls_Query += "                ' ' cparent, "  + is_crlf
ls_Query += ' 1 none1, '  + is_crlf
ls_Query += '                mm.ccomponent, '  + is_crlf
ls_Query += '                mm.ctext, '  + is_crlf
ls_Query += '                mm.nsd_msg_key, '  + is_crlf
ls_Query += '                0 ncontent, '  + is_crlf
ls_Query += '                mm.nsd_msg_key, '  + is_crlf
ls_Query += '                0 nwidth, '  + is_crlf
ls_Query += '                0 nheight, '  + is_crlf
ls_Query += '                0 nbold, '  + is_crlf
ls_Query += '                mm.ctext cdisplay, '  + is_crlf
ls_Query += '                0 nmaxcontent '  + is_crlf
ls_Query += '           From cen_out_sd_message mm '  + is_crlf
ls_Query += '          Where mm.nresult_key =  $P{arg_result_key} '  + is_crlf
ls_Query += "            And mm.cgalley || '-' || Replace(mm.cstowage, ' ', '') =  $P{arg_stowage} "  + is_crlf
ls_Query += '            And mm.ndistribution = 0 '  + is_crlf
ls_Query += '          Order By ncolumn, nrow, nsort) tab_bl '  + is_crlf
ls_Query += '  Group By tab_bl.ncolumn, tab_bl.nrow, tab_bl.nmaxcontent '  + is_crlf
ls_Query += ' Having nmaxcontent < Count(cpackinglist)) '  + is_crlf

return ls_Query
end function

public function integer of_shrink_all (ref datawindow adw_source);
// --------------------------------------------------------------------------------
// Objekt : uo_jasper_create_cd
// Methode: of_shrink_all (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 23.04.2018
//
// Argument(e):
// ref datawindow adw_source
//
// Beschreibung:		Diagramme mit 16 Einsch$$HEX1$$fc00$$ENDHEX$$ben schrumpfen, sonst Jasper Error
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	23.04.2018		Erstellung
//
//
// Return: integer
//
// --------------------------------------------------------------------------------


Long			ll_Counter, ll_ArrayCount
Long			ll_rows
String		ls_DWObjects, ls_Temp
String		ls_Object_Array[]
String		ls_Object, ls_Band, ls_type
Long			ll_Y1, ll_Y2
Long			ll_Width, ll_Height
String		ls_Mod_Error, ls_Modify
Double 		ld_Factor = 0.9

If ib_Additional_Shrink Then
	ld_Factor = 0.8
End If

ls_DWObjects = adw_source.describe("datawindow.objects")


for ll_Counter = 1 to len(ls_DWObjects)
	if Mid(ls_DWObjects, ll_Counter, 1) <> char(9) then
		ls_Temp += Mid(ls_DWObjects, ll_Counter, 1)
	else
		ll_ArrayCount ++
		ls_Object_Array[ll_ArrayCount] = ls_Temp
		ls_Temp = ""
	end if
next
if len(ls_Temp) > 0 then		
	ll_ArrayCount ++
	ls_Object_Array[ll_ArrayCount] = ls_Temp
end if


for ll_rows = 1 to upperbound(ls_Object_Array)
	ls_Object = ls_Object_Array[ll_rows]

	ls_Band = adw_source.Describe(ls_Object_Array[ll_rows] + ".band")	
	if ls_Band <> "detail" then 
		continue
	end if
	
	ls_Temp = adw_source.Describe(ls_Object_Array[ll_rows] + ".visible")	
	if ls_Temp <> "1" then 
		continue
	end if
	ls_type = adw_source.Describe(ls_Object_Array[ll_rows] + ".Type")		

		choose case ls_type
				
			// Line
			CASE "line"		
				//	ll_X1 = Long(adw_source.Describe(ls_Object + ".X1"))
				//	ll_X2 = Long(adw_source.Describe(ls_Object + ".X2"))
					ll_Y1 = Long(adw_source.Describe(ls_Object + ".Y1"))
					ll_Y2 = Long(adw_source.Describe(ls_Object + ".Y2"))
					
					ll_Y1 *= ld_Factor
					ll_Y2 *= ld_Factor
					
					ls_Modify = (ls_Object + ".Y1=" +  String(ll_Y1))
					ls_Mod_Error = adw_source.Modify(ls_Modify)
					ls_Modify = (ls_Object + ".Y2=" +  String(ll_Y2))
					ls_Mod_Error = adw_source.Modify(ls_Modify)
		
			
			//	Sonst
			case "column", "text", "rectangle" , "roundrectangle" , "bitmap"	, "compute"
				//	ll_X1 = Long(adw_source.Describe(ls_Object + ".X"))
					ll_Y1 = Long(adw_source.Describe(ls_Object + ".Y"))
				//	ll_Width = Long(adw_source.Describe(ls_Object + ".width"))
					ll_Height = Long(adw_source.Describe(ls_Object + ".height"))
				
					ll_Y1 *= ld_Factor
					ll_Height *= ld_Factor
					
					ls_Modify = (ls_Object + ".Y=" +  String(ll_Y1))
					ls_Mod_Error = adw_source.Modify(ls_Modify)
					ls_Modify = (ls_Object + ".Height=" +  String(ll_Height))
					ls_Mod_Error = adw_source.Modify(ls_Modify)
		
			CASE ELSE
				// Nothing to do
				f_trace("Shrink NO " + ls_Object)
				//CONTINUE
		end choose
//	End If
next


Return 1
end function

on uo_jasper_create_cd.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_jasper_create_cd.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

