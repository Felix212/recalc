HA$PBExportHeader$uo_client_label.sru
$PBExportComments$Object zur Erstellung der Produkte im Dokumentenbrowser
forward
global type uo_client_label from nonvisualobject
end type
end forward

global type uo_client_label from nonvisualobject
end type
global uo_client_label uo_client_label

type variables
// ------------------------------------
//
// Folgende Variablen sind zu setzen
//
// ------------------------------------
Long		lResultKey
Long		lLegNumber = 1
Long		lResultKeys[]
Long		lTransaction
String	sLocalPrinters[]
String	sLocalBellyPrinters[]
Long		lLocalLabelTypes[]
Integer	iPrinterType, &
			iLabelSort, 	&
			iLabelPageBreak, &
			iCheckSheetStyle, &
			iAddLabelOption
			
boolean	bDivideByWorkstation
			
integer 		iPrintFlightLabel, &
				iPrintNewspaperLabel, &
				iCaller
long			lPrintNewspaper[] //MB 09.06.2010		
Integer		iRampBoxShow
Integer		iRampBoxZieh
blob			bBox_r[]
blob			bBox_l[]
Integer 		iReckoning[], iLegs[]

String		sUnit			

Long				il_Current_TR_Comp[] 			
			
Datastore 	dsNewspaperReport

CONSTANT STRING	cs_Xporter = "XPORTER"

// ------------------------------------
//
// Verteilungsapparatur
//
// ------------------------------------
Boolean				bLabel
Boolean			 	bDistribution
Boolean			 	bLocationSheet
Boolean				bManuelDistribution
Boolean				bManuelDistributionOnError
Boolean				bSPMLSummary
Boolean				bCheckSheet
Boolean				bCheckSheetOnlyUsed
Boolean				bAddLoad
Boolean				bSecondaryDistribution

Boolean				bRampBoxSheet

uo_distribution 	uoDistribution
Blob					blbLocationSheet
Blob					blbDistributionError
Blob					blbSPMLSummary
Integer				iSPMLTextType

Integer 				iManualInput				= 0
Integer				iUseExclusion				= 0

String				sManualAirline
String				sManualFlightNumber
String				sManualAC
String				sManualOwner


Datastore		dsLoadinglists, dsLoadinglistsHistory, dsCenOut, dsCenOutHistory, dsLoading
Datastore 		dsWorkstations, dsCheckSheet
Datastore		dsExternalLoadinglists
Datastore		dsLabelType
Datastore		dsSPMLDetails
Datastore		dsLoadinglistsInfoOnly	// nur zur info f$$HEX1$$fc00$$ENDHEX$$r Checksheet usw.
// 19.08.2009 Ulrich Paudler [UP]
Datastore 		dsCartdiagramSheet

// --------------------------------------------------------
// Datastore der Objekte im Label
// --------------------------------------------------------
datastore dsLabelObjects

uo_label_other	uoLabel, uoEmptyLabel
str_labeltypes	strLabelTypes[]
String			sErrorMessage
String			sSPMLLabelType
Date				dDeparture
String			sWeekdays[]

// --------------------------------------------------------
// Neue Variablen f$$HEX1$$fc00$$ENDHEX$$r Webservice
// --------------------------------------------------------
Integer			iWebService = 0
String			isMandant
String			isUnit
uo_pdf_handler	uoPDF

// ----------------------------------------------------
// 10.3.2011, KF
// ----------------------------------------------------
uo_content_sheet 		iuoContentSheet

Integer		ii_Do_NOT_Trace = 1 //0

String		is_Leg_Routing_From[]
String		is_Leg_Routing_To[]

Boolean		bFill_Ramp_box_mode = FALSE

Public		Long			il_KPI_Cart_Diagram

// Trip Ticket
uo_tripticket	iuo_tripticket

DataStore	ids_TR_Exclusions

PUBLIC	Boolean					ib_Use_Doc_Gen_Settings = FALSE
PUBLIC	n_doc_gen_settings	inv_doc_gen_settings
PUBLIC	n_copy_settings		inv_copy_settings

PUBLIC	Boolean	ib_Secondary_Distribution_ONLY = FALSE
PUBLIC	Boolean	ib_Enable_Secondary_Distr_Saving = TRUE

PRIVATE:
// Objekt zur Berechnung von Schriftgr$$HEX2$$f600df00$$ENDHEX$$en
uo_font_calc iuo_FontCalc

/////////////////////////////////////
// 11.05.2012, DB                  //
// Konstanten f$$HEX1$$fc00$$ENDHEX$$r das Product Log, //
// zwecks besserer $$HEX1$$dc00$$ENDHEX$$bersicht       //
/////////////////////////////////////
constant uint PRODUCT_LABEL               =  1
constant uint PRODUCT_GRAPHIC             =  2
constant uint PRODUCT_DOCUMENTS           =  3
constant uint PRODUCT_FLIGHT_INFO         =  4
constant uint PRODUCT_CART_DIAGRAM        =  5
constant uint PRODUCT_DELIVERY_NOTE       =  6
constant uint PRODUCT_TR_CART_DIAGRAM     =  7
constant uint PRODUCT_TRIP_TICKET_SHEET   =  8
constant uint PRODUCT_CONTENT_SHEET       =  9
constant uint PRODUCT_CONTAINER_EQUIPMENT = 10
constant uint PRODUCT_CUSTOMER_REPORT     = 11
constant uint PRODUCT_NEWSPAPER           = 12

// ------------------------------------------------------------------------------------------------
// NAM-CR-12071 Master Data View - Create CD while ignoring local settings (e.g. Area Allocation)
// ------------------------------------------------------------------------------------------------
Public	Boolean	ib_Enable_Masterdata_View = FALSE

end variables

forward prototypes
public function integer of_get_newspaper_loading ()
public function integer of_create_loading ()
public function integer of_log (string smsg)
public function integer of_set_labeltype ()
public function integer of_distribution ()
public function integer of_production_label (ref uo_label_return uolabelreturn[])
public function integer of_get_standard_loading ()
public function integer of_get_standard_loading_from_history ()
public function integer of_create_comparison (ref uo_label_return uolabelreturn[])
public function string of_checknull (string sVal)
public function integer of_add_workstations ()
public function integer of_reckoning ()
public function integer of_legs ()
public function integer of_check_sheet ()
public function long of_get_loadinglist_index_key (string sloadinglist)
public function integer of_create_additional_label ()
public function integer of_get_standard_loading_userdefined (string sll[], string ssll[], datetime ddeparturedate, string stime)
public function datetime of_find_valid_label (long llabeltype, datetime dtsearch)
public function long of_rowcount (string svalue)
public function string of_cleanup_components (string scomponents, datetime dtdeparture, string sarea, string sworkstation, ref string squantities[], ref string sitemtext[], ref string spackinglists[])
public function integer of_get_local_standard_loading ()
public function integer of_label ()
public function integer of_create ()
public function integer of_spml_label ()
public function integer of_add_workstations_to_spml ()
public function integer of_dump_pps (datastore ods)
public function integer of_check_sheet_prepare_text ()
public function integer of_check_sheet_reload ()
public function integer of_get_local_additional_loading ()
public function integer of_rampbox (boolean argbzieh)
public function integer of_create_acrobat (ref datastore dsacrobat, string as_file_name)
public function integer of_fill_tripticket_fields (ref datastore rads_tripticket, integer al_flight_number, string as_ramp_box, date adt_daparture, string as_airline, string as_ac_type, string as_tail_no, string as_dep_time, string as_loading_list_line_1, string as_loading_list_line_2, string as_kdt, string as_handling_type_description, string as_tlc_from, long al_num_tr_carts)
public function long of_get_handlings (long al_result_key, ref string ras_handling_list[])
public function string of_get_production_range (long al_airline, string as_unit, string as_dep_time)
public function integer of_tripticket_sheet (string arg_s_labelfilter)
public function integer of_create_tripticket (long al_result_key, ref string ras_file_name, string as_unit, integer ai_useexclusionlabel, long al_result_keys[], string as_currentprinter, string as_labelfilter, boolean ab_printdirectly, ref uo_tripticket rauo_tripticket)
public function integer of_create_content_sheet (ref string ras_file_name)
public function string of_remove_cr (string svalue)
public function integer of_add_ramp_box_mode ()
public function long of_containerequipment (ref string ras_filename, string as_currentprinter, boolean ab_printdirectly)
protected function long of_get_bestbefore_minutes (string as_client, string as_unit, long al_airlinekey)
public function integer of_product_log (s_product_log astr_log)
public function integer of_create_flight_documents (long al_result_key, string as_label_filter, ref uo_documents rauo_product, boolean ab_cart_diagram, boolean ab_contentsheet, boolean ab_tripticket, boolean ab_tr_cart, boolean ab_unassignedcarts, boolean ab_printdirectly, boolean ab_use_printer_allocation, string as_printer_cart_diagram, string as_printer_trip_ticket, string as_current_printer_1, string as_printer_tr_carts, string as_printer_content_spec)
protected function integer of_tr_cartdiagram_sheet (string arg_s_labelfilter, boolean ab_distribution)
public function integer of_cartdiagram_sheet (string as_labelfilter, boolean ab_distribution)
protected function integer of_create_tr_cart_diagram_cs_distr (boolean ab_content_sheet, long al_row, s_component astr_component_single, ref uo_distribution rauo_distribution, string as_stowage, ref uo_cart_diagram rauo_cart_diagram, ref string ras_distribution_items[])
protected function integer of_create_tr_diagram_empty (long al_empty_page, boolean ab_tt_without_tr, ref long ral_trcartpages, ref uo_cart_diagram rauo_cart_diagram, long al_trcartpagesmax, ref string ras_pdffiles[], string as_currentprinter, string as_airline, long al_flight_number, long al_belly, string as_dep_time, string as_suffix, string as_header, string ls_from, string ls_to, string ls_ac_type, string as_container, string as_owner, string as_config, string as_area, string as_workstation, string as_multi_ws_1, string as_loadinglist, long al_legnumber, string as_class, long al_cart_counter, string as_cbox_from, string as_cbox_to, long al_airline_key, long al_routing_id, string as_unit, string as_ramp_time, string as_kitchen_time, string as_ops, string as_production_range, ref long ral_filecounter)
public function integer of_get_flight_details (long al_result_key, ref long ral_flight_number, ref string ras_suffix, ref string ras_from, ref string ras_to, ref long ral_airline_key, ref string ras_airline, ref string ras_ac_type, ref string ras_dep_time, ref string ras_ramp_time, ref string ras_unit, ref long ral_leg_number, ref long ral_routing_id, ref string ras_owner, ref string ras_config, ref string ras_cbox_from, ref string ras_cbox_to, ref string ras_kitchen_time, ref long ral_transaction, ref string ras_tail_no)
public function integer of_create_tripticket_class (long al_count_pl, string as_class, string as_tt_class_1, string as_tt_class_2, string as_tt_class_3, string ls_unitarea, ref datastore radstripticket, ref uo_tripticket rauo_tripticket, ref long ral_tt_row)
public function integer of_create_tr_cartidagram_main (long al_row, ref uo_cart_diagram rauo_cart_diagram, long al_airline_key, string as_unit, string as_dep_time, long al_routing_id, ref datastore rads_backlog, ref datastore rads_cartdiagram, ref uo_tr_cart_allocation rauo_tr_alloc, boolean ab_content_sheet, ref uo_distribution rauo_distribution, boolean ab_tt_without_tr, long al_catering_leg, long al_trcartpagesmax, ref long ral_cart_counter, long al_highest_class, string as_highest_class, string as_currentprinter, string as_airline, long al_flight_number, string as_suffix, string as_header, string as_from, string as_to, string as_ac_type, string as_owner, string as_config, string as_production_range, string as_ops, string as_ramp_time, string as_kitchen_time, ref long ral_filecounter, ref string ras_pdffiles[], string as_cbox_from, string as_cbox_to, long al_leg_number, ref boolean rab_first, ref long ral_trcartpages)
protected function integer of_create_tripticket_main (long al_result_key, string as_handling_list[], long al_flight_number, string as_ramp_box, string as_airline, string as_ac_type, string as_tail_no, string as_dep_time, string as_ramp_time, string as_handling_type_text, string as_handling_type_description, string as_from, ref uo_tripticket rauo_tripticket, long al_airline_key, ref string ras_pdffiles[])
public function integer of_create_cart_diagram (long al_result_key, string as_label_filter, ref uo_documents rauo_product, boolean ab_cart_diagram, boolean ab_contentsheet, boolean ab_tripticket, boolean ab_tr_cart, boolean ab_unassignedcarts, boolean ab_printdirectly, boolean ab_use_printer_allocation, string as_printer_cart_diagram, string as_current_printer_1)
public function integer of_create_tr_cartdiagram (long al_result_key, ref string ras_file_name, string as_unit, integer ai_useexclusionlabel, long al_result_keys[], string as_currentprinter, string as_labelfilter, boolean ab_printdirectly, ref long ral_cart_pages, datastore ads_exclusions, boolean ab_content_sheet, ref boolean rab_distr_done, boolean ab_tt_without_tr)
protected function integer of_create_tr_cartdiagram_distr_comp (boolean ab_content_sheet, long al_row, s_component astr_component_single, ref uo_distribution rauo_distribution, string as_stowage, ref uo_cart_diagram rauo_cart_diagram, ref string ras_distribution_items[], ref string ras_suppressed_items[])
public function integer of_get_healthmark_info (string asunit, ref string asheader, ref string asdetail, ref string asfooter)
public function string of_remove_mealcode (string svalue)
end prototypes

public function integer of_get_newspaper_loading ();uo_label_newspaper uoNewspaper 
s_all_flight_infos strFlight

integer	iBostaF, iBostaC, iBostaM

// ----------------------------------------
// 
// Wir ermitteln die Zeitungsbeladung
// 
// ----------------------------------------
if iPrintNewspaperLabel = 1 then
	//
	// Merker: npackinglist_type mu$$HEX2$$df002000$$ENDHEX$$ins Result-Set
	// Zur sp$$HEX1$$e400$$ENDHEX$$teren Unterscheidung, ob es eine Zeitungs- oder normale
	// Einzelst$$HEX1$$fc00$$ENDHEX$$ckliste ist
	//
	// lPlType = 1 (normale St$$HEX1$$fc00$$ENDHEX$$ckliste)
	// lPlType = 2 (Zeitungsst$$HEX1$$fc00$$ENDHEX$$ckliste)
	// Datastore: npltype (default = 1)
	//
	
	//
	// Sollen auch Label f$$HEX1$$fc00$$ENDHEX$$rs Lesematerial gedruckt werden?
	//
	uoNewspaper = create uo_label_newspaper
	
	//
	// Verweis auf Datastore im Fenster???
	//
	
	//f_print_datastore(dsCenOut)
	
	strFlight.sDeparturedate			= String(dsCenOut.GetItemDateTime(1, "ddeparture"), s_app.sDateFormat)
	strFlight.lroutingplan_key			= dsCenOut.GetItemNumber(1, "nroutingdetail_key")
	strFlight.lroutingplan_key_cp		= dsCenOut.GetItemNumber(1, "nroutingdetail_key_cp")
	strFlight.lairline_key				= dsCenOut.GetItemNumber(1, "nairline_key")
	strFlight.sAirline					= dsCenOut.GetItemString(1, "cairline")
	strFlight.sflightnumber				= String(dsCenOut.GetItemNumber(1, "nflight_number"))
	strFlight.sSuffix						= dsCenOut.GetItemString(1, "csuffix")
	strFlight.lAircraft_key				= dsCenOut.GetItemNumber(1, "naircraft_key")	
	strFlight.cdeparturetime			= dsCenOut.GetItemString(1, "cdeparture_time")
	strFlight.sclient						= s_app.sMandant
	
	uoNewspaper.dsNewspaperReport = dsNewspaperReport
	uoNewspaper.sAirline				= strFlight.sAirline
	uoNewspaper.lFlightnumber		= long(strFlight.sflightnumber)
	uoNewspaper.sSuffix				= strFlight.ssuffix
	uoNewspaper.sDepartureTime		= strFlight.cdeparturetime
	uoNewspaper.sOwner				= strFlight.sOwner
	uoNewspaper.sActype				= strFlight.sActype
	uoNewspaper.sAirline				= strFlight.sAirline
	uoNewspaper.lNewsPL-Type = lPrintNewspaper //MB 09.06.2010
	select npax
	  into :iBostaF
	  from cen_out_pax
	 where nresult_key = :lResultKey
	   and nclass_number = 1;
		
	select npax
	  into :iBostaC
	  from cen_out_pax
	 where nresult_key = :lResultKey
	   and nclass_number = 2;
		
	select npax
	  into :iBostaM
	  from cen_out_pax
	 where nresult_key = :lResultKey
	   and nclass_number = 3;
		
	uoNewspaper.iBostaF				= iBostaF
	uoNewspaper.iBostaC				= iBostaC
	uoNewspaper.iBostaM				= iBostaM
	
	uoNewspaper.of_start_label(strFlight)
	//
	// Append von uoNewspaper.dsResult an ds_loadinglist
	//
	uoNewspaper.dsResult.RowsCopy(1,uoNewspaper.dsResult.RowCount(),Primary!,this.dsLoading,this.dsLoading.RowCount() + 1, Primary!)
	
	
	destroy uoNewspaper
	
end if

return 0
end function

public function integer of_create_loading ();// -----------------------------------------------------
// 
// Einstiegsfunktion
// 
// -----------------------------------------------------

// -----------------------------------------------------------
// Kein ResultKey = Fehler
// -----------------------------------------------------------
if isNull(this.lResultKey) or this.lResultKey = 0 then
	sErrorMessage = uf.translate("Flugdaten k$$HEX1$$f600$$ENDHEX$$nnen nicht ermittelt werden!")
	return -1
end if

// -----------------------------------------------------------
// Die Fluginformationen die zum ResultKey geh$$HEX1$$f600$$ENDHEX$$ren einlesen
// -----------------------------------------------------------
dsCenOut.Retrieve(this.lResultKey)
if dsCenOut.RowCount() <= 0 then
	sErrorMessage = uf.translate("Keine Flugdaten gefunden!")
	return -1
elseif dsCenOut.RowCount() > 1 then
	sErrorMessage = uf.translate("Flugdaten konnten nicht ermittelt werden!")
	return -1
end if

// -----------------------------------------------------------
// Die Beladung ermitteln
// -----------------------------------------------------------
if this.of_get_standard_loading() <> 0 then
	sErrorMessage = uf.translate("Keine Standardbeladung gefunden!")
	return -1
end if
	
// -----------------------------------------------------------
// Die Lokalen Informationen zuspielen
// -----------------------------------------------------------
this.of_add_workstations()

// -----------------------------------------------------------
// Check Sheet f$$HEX1$$fc00$$ENDHEX$$llen
// -----------------------------------------------------------



return 0

end function

public function integer of_log (string smsg);//----------------------------------------------------
// 
// LogFile schreiben
//
//----------------------------------------------------

integer iFile

// -----------------------------------------
// l$$HEX1$$e400$$ENDHEX$$uft Lokal
// -----------------------------------------
iFile = FileOpen(f_gettemppath() + "cbase_label.log", LineMode!, Write!, Shared!)
FileWrite(iFile, string(today(), "dd.mm.yyyy") + "-" + string(now(), "hh:mm:ss") + " " + sMsg)
FileClose(iFile)

return 0

end function

public function integer of_set_labeltype ();// -----------------------------------------------------
// 
// Zuspielen der lokalen Bereichszuordnung
// 
// -----------------------------------------------------
Datastore	ds_temp
Long 			i, j, k, l, &
				lPL_Keys[], &
				lQuantity, lFound

Long 			lKey, lLabelTypeKey , lPrint, lType, lLabelQuantity

String		sText, sArea, sWorkStation, sAddOnText

String		sFoodValue, sNonFoodValue, sKitchenTime, sRampTime, sDeparturetime
	
	
long 			l1, l1_1, l2, l2_2, l3, l3_3

datetime		dtDeparture

ds_temp = Create Datastore
ds_temp.DataObject = 'dw_loading_list_result'

dsWorkstations.SetTransObject(sqlca)

// -------------------------------------------------------
// Betriebliche Parameter f$$HEX1$$fc00$$ENDHEX$$r die Zeitanzeige auslesen
// -------------------------------------------------------
sFoodValue 		= f_unitprofilestring("Default","FoodTime","2", isUnit) 
sNonFoodValue 	= f_unitprofilestring("Default","NonFoodTime","2", isUnit) 

sKitchenTime	= dsCenOut.GetItemString(1, "ckitchen_time")
sRampTime		= dsCenOut.GetItemString(1, "cramp_time")
sDeparturetime	= dsCenOut.GetItemString(1, "cdeparture_time")

// ---------------------------------------------
// Erstellen Number Array
// und wenn wir schon mal am
// duchlaufen sind dann packen wir
// auch gleich die Mengen zu den Texten
// ---------------------------------------------
For i = 1 to dsLoading.RowCount()
	
	lPL_Keys[i] = dsLoading.GetItemNumber(i,"cen_packinglist_index_npackinglist_index_key")
	dsLoading.SetItem(i,"carea", "")  
	dsLoading.SetItem(i,"cworkstation", "")  
	
Next 

dtDeparture = dsCenOut.GetItemDateTime(1, "ddeparture")

dsWorkstations.retrieve(isMandant, this.sUnit , lPL_Keys, dtDeparture)

if dsWorkstations.RowCount() > 0 then
	
	// ---------------------------------------------
	// Lokal
	// ---------------------------------------------
	dsLabelType.Retrieve()
	
	For j = 1 to dsLoading.RowCount()
		dsLoading.RowsCopy(j,j,Primary!,ds_temp,ds_temp.RowCount() + 1,Primary!)
		ds_temp.SetItem(ds_temp.RowCount(),"carea_code","")  // Bereichsbezeichnung blank setzen
		
		// --------------------------------------------
		// Die PL aus der Beladung in der lokalen
		// Bereichszuordnung rausfiltern
		// --------------------------------------------
		lKey = dsLoading.GetItemNumber(j,"cen_packinglist_index_npackinglist_index_key")
		dsWorkstations.SetFilter("npackinglist_index_key = " + string(lKey))
		dsWorkstations.Filter()
		
		If dsWorkstations.RowCount() <= 0 then continue
		
		sArea 				= dsWorkstations.GetItemString(1,"carea")
		sWorkStation 		= dsWorkstations.GetItemString(1,"cworkstation")
		lLabelTypeKey 		= dsWorkstations.GetItemNumber(1,"nlabel_type_key")
		lLabelQuantity    = dsWorkstations.GetItemNumber(1,"nquantity")
		sAddOnText			= dsWorkstations.GetItemString(1,"loc_unit_pl_flight_label_ctext")
		sText					= dsWorkstations.GetItemString(1,"loc_unit_pl_flight_label_ctext2")
		lType					= 0  /// 0=Masterlabel, 1=Dupliziertes Label
		lPrint 				= dsWorkstations.GetItemNumber(1,"nlabel_print")  
		
		// -------------------------------------------------------------------
		// Thema "Br$$HEX1$$f600$$ENDHEX$$tchent$$HEX1$$fc00$$ENDHEX$$ten nach Bedarf"
		// Verhalten wir bei gem$$HEX1$$e400$$ENDHEX$$ss Menge nur, dass Menge auf 10 gesetzt wird
		// und das Drucken abgestellt wird. (Hat den Effekt, dass nur die
		// gedruckt werden, die auch von der MZV gef$$HEX1$$fc00$$ENDHEX$$llt w$$HEX1$$fc00$$ENDHEX$$rden)
		// -------------------------------------------------------------------
		if lLabelQuantity = 3 then 
			lPrint = 0
		end if
		
		// --------------------------------------------------------------
		// Bereiche setzen
		// --------------------------------------------------------------
		ds_temp.SetItem(ds_temp.RowCount(),"carea_code",Trim(sArea) + "-" + Trim(sWorkStation))  // Bereichsbezeichnung
		ds_temp.SetItem(ds_temp.RowCount(),"cen_packinglists_nlabel_type_key", lLabelTypeKey) // Labeltype
		ds_temp.SetItem(ds_temp.RowCount(),"nlabel_type", lType)  // Master oder dupliziertes Label
		ds_temp.SetItem(ds_temp.RowCount(),"nprint", lPrint)  // Druck on-off
		ds_temp.SetItem(ds_temp.RowCount(),"carea", sArea)  
		ds_temp.SetItem(ds_temp.RowCount(),"cworkstation", sWorkStation)  
		
		
		lFound = dsLabelType.Find("nlabel_type_key=" + string(lLabelTypeKey), 1, dsLabelType.RowCount())
		// --------------------------------------------------------------
		// Treffer, es ist ein Food Label
		// 
		// In dsLabelType stehen alle Labeltypen die das Feld 
		// 'cdistributed_components' haben. 
		// --------------------------------------------------------------
		if lFound > 0 then
			
			choose case sFoodValue
				case "0"
					ds_temp.SetItem(ds_temp.RowCount(), "cunit_time", sDepartureTime)
				case "1"
					ds_temp.SetItem(ds_temp.RowCount(), "cunit_time", sKitchenTime)
				case "2"
					ds_temp.SetItem(ds_temp.RowCount(), "cunit_time", sRampTime)
			end choose
			
		else
			
			choose case sNonFoodValue
				case "0"
					ds_temp.SetItem(ds_temp.RowCount(), "cunit_time", sDepartureTime)
				case "1"
					ds_temp.SetItem(ds_temp.RowCount(), "cunit_time", sKitchenTime)
				case "2"
					ds_temp.SetItem(ds_temp.RowCount(), "cunit_time", sRampTime)
			end choose
			
		end if
		
	Next
	// --------------------------------------------------------------
	// Tempor$$HEX1$$e400$$ENDHEX$$rer Datastore zur$$HEX1$$fc00$$ENDHEX$$ckkopieren
	// --------------------------------------------------------------
	dsLoading.Reset()
	ds_temp.RowsCopy(1,ds_temp.RowCount(),Primary!,dsLoading,1,Primary!)

end if



dsWorkstations.SetFilter("")
dsWorkstations.Filter()

return 0
end function

public function integer of_distribution ();// --------------------------------------------------------------
// 
// Die Verteilung anwerfen
//
// --------------------------------------------------------------

Long						lKey, lSize, lRet
Integer 					iRet
Long						ll_Count_1, ll_Count_2
String	ls_temp

if isvalid(uoDistribution) then
	setnull(uoDistribution.dsLoadinglist)
	destroy uoDistribution
end if

If isvalid(this.dsLoading) Then
	f_trace("uo_client_label.of_distribution() BEFORE Create uo_distribution: dsLoading IS VALID")
Else
	f_trace("uo_client_label.of_distribution() BEFORE Create uo_distribution: dsLoading IS NOT VALID")
End If

uoDistribution = Create uo_distribution		

If isvalid(this.dsLoading) Then
	f_trace("uo_client_label.of_distribution() AFTER Create uo_distribution: dsLoading IS VALID")
Else
	f_trace("uo_client_label.of_distribution() AFTER Create uo_distribution: dsLoading IS NOT VALID")
End If

If isvalid(uoDistribution.dsLoadinglist) Then
	f_trace("uo_client_label.of_distribution() (1) uoDistribution.dsLoadinglist IS VALID")
Else
	f_trace("uo_client_label.of_distribution() (1) uoDistribution.dsLoadinglist IS NOT VALID")
End If

uoDistribution.dsLoadinglist 					= this.dsLoading

If isvalid(uoDistribution.dsLoadinglist) Then
	f_trace("uo_client_label.of_distribution() (2) uoDistribution.dsLoadinglist IS VALID")
Else
	f_trace("uo_client_label.of_distribution() (2) uoDistribution.dsLoadinglist IS NOT VALID")
End If

uoDistribution.lResultKey 						= this.lResultKey
uoDistribution.lResultKeys 					= this.lResultKeys
uoDistribution.iWebService						= this.iWebService
uoDistribution.iTrace 							= s_app.iTrace
uoDistribution.bLocationSheet 				= bLocationSheet
uoDistribution.bSPMLSummary 					= bSPMLSummary
uoDistribution.bManuelDistribution 			= bManuelDistribution
uoDistribution.bManuelDistributionOnError = this.bManuelDistributionOnError
uoDistribution.bCheckSheetOnlyUsed			= this.bCheckSheetOnlyUsed
uoDistribution.iSPMLTextType					= this.iSPMLTextType
uoDistribution.iAddLabelOption				= this.iAddLabelOption
uoDistribution.uoPDF								= this.uoPDF
//this.dsLoading.SetFilter("cen_packinglist_index_cpackinglist = '5*40216'")
//this.dsLoading.Filter()
//f_print_datastore(this.dsLoading)
//return -1

//f_view_datastore(this.dsLoading)

this.dsCheckSheet.RowsCopy(1, this.dsCheckSheet.RowCount(), Primary!, uoDistribution.dsCheckSheet, 1, Primary!)

iRet = uoDistribution.of_run()

if iRet < 0 then
	If ii_Do_NOT_Trace = 0 Then
		f_trace("uoDistribution.of_run() < 0")
	end if
	
	SetNull(this.blbLocationSheet)
	SetNull(this.blbDistributionError)
	
	// User hat abgebrochen
	if iRet = -1000 then return -1000
	
else
	If ii_Do_NOT_Trace = 0 Then
		f_trace("uoDistribution.of_run() OK")
	end if
	
	lSize = len(this.blbLocationSheet)

	this.blbLocationSheet 		= uoDistribution.blbLocationSheet
	this.blbDistributionError 	= uoDistribution.blbDistributionErrors
	this.blbSPMLSummary 	= uoDistribution.blbSPMLSummary
	
	this.uoLabel.dsDistributionErrors.SetFullState(uoDistribution.blbDistributionErrors)
	
	this.dsCheckSheet.Reset()
	uoDistribution.dsCheckSheet.RowsCopy(1, uoDistribution.dsCheckSheet.RowCount(), Primary!, this.dsCheckSheet, 1, Primary!)
//	f_print_datastore(uoDistribution.dsLoadinglist)
	
//	if this.iAddLabelOption = 1 then
//		this.dsLoading.Reset()
//		uoDistribution.dsLoadinglist.RowsCopy(1, uoDistribution.dsLoadinglist.RowCount(), Primary!, this.dsLoading, 1, Primary!)
//	end if
	
end if

If ii_Do_NOT_Trace = 0 Then
	if isvalid(uoDistribution) then
		f_trace("########### Nach Distribution ###########")
		f_trace("of_Distribution upperbound(uodistribution.uoStowages) " + String(upperbound(uodistribution.uoStowages)))
//		For ll_Count_1 = 1 to upperbound(uoDistribution.uoStowages)
//			f_trace("Next Stowage ")
//				For ll_Count_2= 1 to uoDistribution.uoStowages[ll_Count_1].dsContent.Rowcount()
//	//				lstr_component[ll_Count_3].stext = uoDistribution.uoStowages[llIndex].dsContent.getitemstring(ll_Count_2,"ctext")
//	//				lstr_component[ll_Count_3].ssnr = uoDistribution.uoStowages[llIndex].dsContent.getitemstring(ll_Count_2,"cpackinglist")
//	//				lstr_component[ll_Count_3].lquantity = uoDistribution.uoStowages[llIndex].dsContent.getitemnumber(ll_Count_2,"nquantity") 
//					ls_temp = "uo_client_label.of_distribution " +  uoDistribution.uoStowages[ll_Count_1].dsContent.getitemstring(ll_Count_2,"cpackinglist")
//					ls_temp += " Qty " +  String(uoDistribution.uoStowages[ll_Count_1].dsContent.getitemnumber(ll_Count_2,"nquantity") )
//					f_trace(ls_temp)
//					
//				next
//		next
	end if
end if


return 0


end function

public function integer of_production_label (ref uo_label_return uolabelreturn[]);// -----------------------------------------------------
// 
// Labels bauen
// 
// -----------------------------------------------------
str_bitmaps 		strBMP[]
integer 				iRet, i
blob 					bXMLDok, bXMLFragment
Long					lIndex

String				sPrintBefore, sPrintAfter, sBoxFrom, sBoxTo
s_Flight 			sFlight

uoLabel = create uo_label_other
	
uoLabel.sLocalPrinters			= this.sLocalPrinters
uoLabel.sLocalBellyPrinters	= this.sLocalBellyPrinters
uoLabel.lLocalLabelTypes		= this.lLocalLabelTypes
uoLabel.strLabelTypes			= this.strLabelTypes
uoLabel.sPrintWeekDay			= this.sWeekdays[DayNumber(Today())]
uoLabel.lResultKey				= this.lResultKey

sFlight.dtDepartureDate			= DateTime(this.dDeparture)

iRet = uoLabel.of_label_production(this.dsLoading, this.iPrinterType, this.iLabelSort, this.iLabelPageBreak, sFlight, uoLabelReturn[], strBMP[]) 

Choose case iRet 
	case -1		
		this.sErrorMessage = "No data available"
		return -1
	case -2
		this.sErrorMessage = "No valid label found"
		return -1
	case -3
		this.sErrorMessage = "Unknown printer-type"
		return -1
	case is < -4
		this.sErrorMessage = "Internal error " + String(iRet)
		return -1
end choose

this.strLabelTypes = uoLabel.strLabelTypes

return 0

end function

public function integer of_get_standard_loading ();// -----------------------------------------------------
// 
// Beladung ermitteln
// 
// -----------------------------------------------------
integer					iTrafficDay
string					sLL
integer					iCounter,i
Long						ll_ntransaction
uo_flight_explosion	uo_explosion

uo_explosion = create uo_flight_explosion
// ---------------------------------------------------------------------
// Die $$HEX1$$dc00$$ENDHEX$$bergabestruktur f$$HEX1$$fc00$$ENDHEX$$llen
// ---------------------------------------------------------------------
uo_explosion.dtDepartureDate	= dsCenOut.GetItemDateTime(1,"ddeparture")
uo_explosion.sDepartureTime	= dsCenOut.GetItemString(1,"cdeparture_time")

this.dDeparture = Date(uo_explosion.dtDepartureDate)

// ------------------------------------------
// Verkehrstag ermitteln
// ------------------------------------------	
iTrafficDay = DayNumber(Date(uo_explosion.dtDepartureDate))
iTrafficDay --
if iTrafficDay = 0 then iTrafficDay = 7	
uo_explosion.sVerkehrstag		= string(iTrafficDay)

// ---------------------------------------------------------------------
// Das Arrays mit Loadinglistkeys f$$HEX1$$fc00$$ENDHEX$$r den Retrieve f$$HEX1$$fc00$$ENDHEX$$llen
// 05.11.07: Da in dsLoadinglists gel$$HEX1$$f600$$ENDHEX$$scht wird, dsLoadinglistsInfoOnly verwenden
// ---------------------------------------------------------------------	
if dsExternalLoadinglists.RowCount() = 0 then
	dsLoadingLists.Retrieve(this.lResultKey)
	dsLoadinglistsInfoOnly.Retrieve(this.lResultKey)
else
	dsLoadingLists.Reset()
	dsExternalLoadinglists.RowsCopy(1, dsExternalLoadinglists.RowCount(), Primary!, dsLoadingLists, 1, Primary!)
	dsExternalLoadinglists.RowsCopy(1, dsExternalLoadinglists.RowCount(), Primary!, dsLoadinglistsInfoOnly, 1, Primary!)
end if

// -----------------------------------------------------------
// Ggf. die Negativliste ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
// -----------------------------------------------------------
String sNumber
String sResult
if iUseExclusion = 1 then
	
	For i = dsLoadingLists.Rowcount() to 1 step -1
		sNumber = dsLoadingLists.GetitemString(i,"cloadinglist")
		
		select cloadinglist into :sResult 
		from loc_unit_ll_exclude 
		where cloadinglist = :sNumber and
				cunit = :this.sUnit and
				dvalid_from <= :this.ddeparture and
				dvalid_to >= :this.ddeparture ;
				
		// ------------------------------------------		
		// St$$HEX1$$fc00$$ENDHEX$$ckliste ist definiert, dann l$$HEX1$$f600$$ENDHEX$$schen		
		// ------------------------------------------
		if sqlca.sqlcode = 0 then
			dsLoadingLists.DeleteRow(i)
		elseif sqlca.sqlcode < 0 then
			f_db_error(sqlca, "LL: " + sNumber )
		end if
		
	Next
	
end if

iCounter = 0

For i = 1 to dsLoadingLists.Rowcount()
	If dsLoadingLists.Getitemnumber(i,"nhandling_id") = 1 Then
		
		// 20.11.2009 HR:
		if i>1 then
			if dsLoadingLists.find("cloadinglist='"+dsLoadingLists.GetitemString(i,"cloadinglist")+"'",1, i - 1)>0 then continue
		end if

		
		iCounter ++
		//uo_explosion.lFirstArgRetrieve[iCounter] = dsLoadingLists.Getitemnumber(i,"nloadinglist_index_key")
		uo_explosion.lFirstArgRetrieve[iCounter] = of_get_loadinglist_index_key(dsLoadingLists.GetitemString(i,"cloadinglist"))
	End if	
Next	

// ---------------------------------------------------------------------
// Das Arrays mit Supplement Loadinglistkeys f$$HEX1$$fc00$$ENDHEX$$r den Retrieve f$$HEX1$$fc00$$ENDHEX$$llen
// ---------------------------------------------------------------------
iCounter = 0
For i = 1 to dsLoadingLists.Rowcount()
	If dsLoadingLists.Getitemnumber(i,"nhandling_id") = 2 Then
		// 20.11.2009 HR:
		if i>1 then
			if dsLoadingLists.find("cloadinglist='"+dsLoadingLists.GetitemString(i,"cloadinglist")+"'",1, i - 1)>0 then continue
		end if
		
		iCounter ++
		//uo_explosion.lSecondArgRetrieve[iCounter] = dsLoadingLists.Getitemnumber(i,"nloadinglist_index_key")		
		uo_explosion.lSecondArgRetrieve[iCounter] = of_get_loadinglist_index_key(dsLoadingLists.GetitemString(i,"cloadinglist"))
	End if	
Next	


// Keys f$$HEX1$$fc00$$ENDHEX$$r Speichern Loading zuweisen ...
uo_explosion.lResultKey = this.lResultKey

// Transaction aus CEN_OUT holen ...
SELECT 		NTRANSACTION
INTO			:ll_ntransaction
FROM 		CEN_OUT
WHERE		NRESULT_KEY = :this.lResultKey;

// ... und zuweisen.
uo_explosion.lTransaction = ll_ntransaction

// ---------------------------------------------------------------------
// Daten holen
// ---------------------------------------------------------------------
if uo_explosion.uf_retrieve() <= 0 then
	destroy(uo_explosion)	
	return -1
else

	if uo_explosion.ds_loadinglist.RowsCopy(1, uo_explosion.ds_loadinglist.RowCount(), Primary!, this.dsLoading, this.dsLoading.RowCount() + 1, Primary!) <> 1 then
		this.sErrorMessage = "Rowscopy failed!"
		destroy(uo_explosion)	
		return -1
	end if	

end if

For I = 1 to this.dsLoading.RowCount()
	
	if this.dsLoading.GetItemString(i,"cen_loadinglists_cactioncode") = "L" then
		this.dsLoading.SetItem(i,"cen_loadinglists_cactioncode", "") 
	end if
	
Next

// -------------------------------------------------------------------------
// Alle Datens$$HEX1$$e400$$ENDHEX$$tze mit unerw$$HEX1$$fc00$$ENDHEX$$nschtem Status l$$HEX1$$f600$$ENDHEX$$schen
// 20.02.2006
// -------------------------------------------------------------------------
this.of_reckoning()

destroy(uo_explosion)	

return 0
end function

public function integer of_get_standard_loading_from_history ();// -----------------------------------------------------
// 
// Beladung ermitteln
// 
// -----------------------------------------------------
integer					iTrafficDay
integer					iCounter,i
uo_flight_explosion	uo_explosion

uo_explosion = create uo_flight_explosion


// ---------------------------------------------------------------------
// Kopfinfos
// ---------------------------------------------------------------------
dsCenOutHistory.Retrieve(this.lResultKey, this.lTransaction)

// ---------------------------------------------------------------------
// Die $$HEX1$$dc00$$ENDHEX$$bergabestruktur f$$HEX1$$fc00$$ENDHEX$$llen
// ---------------------------------------------------------------------
uo_explosion.dtDepartureDate	= dsCenOut.GetItemDateTime(1,"ddeparture")
uo_explosion.sDepartureTime	= dsCenOut.GetItemString(1,"cdeparture_time")

this.dDeparture = Date(uo_explosion.dtDepartureDate)

// ------------------------------------------
// Verkehrstag ermitteln
// ------------------------------------------	
iTrafficDay = DayNumber(Date(uo_explosion.dtDepartureDate))
iTrafficDay --
if iTrafficDay = 0 then iTrafficDay = 7	
uo_explosion.sVerkehrstag		= string(iTrafficDay)

// ---------------------------------------------------------------------
// Das Arrays mit Loadinglistkeys f$$HEX1$$fc00$$ENDHEX$$r den Retrieve f$$HEX1$$fc00$$ENDHEX$$llen
// ---------------------------------------------------------------------	
dsLoadingListsHistory.Retrieve(this.lResultKey, this.lTransaction)

// -----------------------------------------------------------
// Ggf. die Negativliste ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
// -----------------------------------------------------------
String sNumber
String sResult
if iUseExclusion = 1 then
	
	For i = dsLoadingListsHistory.Rowcount() to 1 step -1
		sNumber = dsLoadingListsHistory.GetitemString(i,"cloadinglist")
		
		select cloadinglist into :sResult 
		from loc_unit_ll_exclude 
		where cloadinglist = :sNumber and
				cunit = :this.sUnit and
				dvalid_from <= :this.ddeparture and
				dvalid_to >= :this.ddeparture ;
				
		// ------------------------------------------		
		// St$$HEX1$$fc00$$ENDHEX$$ckliste ist definiert, dann l$$HEX1$$f600$$ENDHEX$$schen		
		// ------------------------------------------
		if sqlca.sqlcode = 0 then
			dsLoadingListsHistory.DeleteRow(i)
		elseif sqlca.sqlcode < 0 then
			f_db_error(sqlca, "History LL: " + sNumber )
		end if
		
	Next
	
end if

iCounter = 0
For i = 1 to dsLoadingListsHistory.Rowcount()
	If dsLoadingListsHistory.Getitemnumber(i,"nhandling_id") = 1 Then
		iCounter ++
		//uo_explosion.lFirstArgRetrieve[iCounter] = dsLoadingListsHistory.Getitemnumber(i,"nloadinglist_index_key")
		uo_explosion.lFirstArgRetrieve[iCounter] = of_get_loadinglist_index_key(dsLoadingListsHistory.GetitemString(i,"cloadinglist"))
	End if	
Next	

// ---------------------------------------------------------------------
// Das Arrays mit Supplement Loadinglistkeys f$$HEX1$$fc00$$ENDHEX$$r den Retrieve f$$HEX1$$fc00$$ENDHEX$$llen
// ---------------------------------------------------------------------
iCounter = 0
For i = 1 to dsLoadingListsHistory.Rowcount()
	If dsLoadingListsHistory.Getitemnumber(i,"nhandling_id") = 2 Then
		iCounter ++
		// uo_explosion.lSecondArgRetrieve[iCounter] = dsLoadingListsHistory.Getitemnumber(i,"nloadinglist_index_key")		
		uo_explosion.lSecondArgRetrieve[iCounter] = of_get_loadinglist_index_key(dsLoadingListsHistory.GetitemString(i,"cloadinglist"))
	End if	
Next	

// ---------------------------------------------------------------------
// Daten holen
// ---------------------------------------------------------------------
if uo_explosion.uf_retrieve() <= 0 then
	return -1
else

	if uo_explosion.ds_loadinglist.RowsCopy(1, uo_explosion.ds_loadinglist.RowCount(), Primary!, this.dsLoading, this.dsLoading.RowCount() + 1, Primary!) <> 1 then
		this.sErrorMessage = "Rowscopy failed!"
		return -1
	end if	

end if

For I = 1 to this.dsLoading.RowCount()
	
	if this.dsLoading.GetItemString(i,"cen_loadinglists_cactioncode") = "L" then
		this.dsLoading.SetItem(i,"cen_loadinglists_cactioncode", "") 
	end if
	
Next

destroy(uo_explosion)	

return 0
end function

public function integer of_create_comparison (ref uo_label_return uolabelreturn[]);// -----------------------------------------------------------
// 
// Einstiegsfunktion
// 
// -----------------------------------------------------------
Long 	lStart, lEnde, lPos
Long	I
uo_label_return	uoTemp[], uoDiff[]

lStart = CPU()

// -----------------------------------------------------------
// Kein ResultKey = Fehler
// -----------------------------------------------------------
if isNull(this.lResultKey) or this.lResultKey = 0 then
	sErrorMessage = uf.translate("Flugdaten k$$HEX1$$f600$$ENDHEX$$nnen nicht ermittelt werden!")
	return -1
end if

// -----------------------------------------------------------
// Die Fluginformationen die zum ResultKey geh$$HEX1$$f600$$ENDHEX$$ren einlesen
// -----------------------------------------------------------
dsCenOut.Retrieve(this.lResultKey)
if dsCenOut.RowCount() <= 0 then
	sErrorMessage = uf.translate("Keine Flugdaten f$$HEX1$$fc00$$ENDHEX$$r Vergleich gefunden ! " + String(this.lResultKey))
	return -1
elseif dsCenOut.RowCount() > 1 then
	sErrorMessage = uf.translate("Flugdaten konnten nicht ermittelt werden!")
	return -1
end if

// -----------------------------------------------------------
// Die Fluginformationen die zum ResultKey geh$$HEX1$$f600$$ENDHEX$$ren einlesen
// -----------------------------------------------------------
dsCenOutHistory.Retrieve(this.lResultKey, this.lTransaction)
if dsCenOutHistory.RowCount() <= 0 then
	sErrorMessage = uf.translate("Keine History Flugdaten f$$HEX1$$fc00$$ENDHEX$$r Vergleich gefunden!")
	return -1

elseif dsCenOutHistory.RowCount() > 1 then
	sErrorMessage = uf.translate("History Flugdaten konnten nicht ermittelt werden!")
	return -1
end if

// -----------------------------------------------------------
// Zuerst die, die dazugekommen sind
// -----------------------------------------------------------
//uoTemp = uoEmpty

dsLoading.SetFilter("nremove=0")
dsLoading.Filter()

if dsLoading.RowCount() > 0 then

	if this.of_label() <> 0 then
		return -1
	else
		uoTemp = this.uoLabel.uoResult
	end if
	
	For I = 1 to UpperBound(uoTemp)
		lPos = UpperBound(uoLabelReturn) + 1
		uoLabelReturn[lPos] = Create uo_label_return
		uoLabelReturn[lPos].sLabel 					= uoTemp[I].sLabel
		uoLabelReturn[lPos].bLabel 					= uoTemp[I].bLabel
		uoLabelReturn[lPos].lLabelType 				= uoTemp[I].lLabelType
		uoLabelReturn[lPos].bLocationSheet 			= uoTemp[I].bLocationSheet
		uoLabelReturn[lPos].bDistributionErrors 	= uoTemp[I].bDistributionErrors
		uoLabelReturn[lPos].sLabelComment 			= uoTemp[I].sLabelComment
		uoLabelReturn[lPos].isBelly 					= uoTemp[I].isBelly
		uoLabelReturn[lPos].iPrinterType 			= uoTemp[I].iPrinterType
		uoLabelReturn[lPos].iLabelSort 				= uoTemp[I].iLabelSort
		uoLabelReturn[lPos].iLabelPageBreak 		= uoTemp[I].iLabelPageBreak
		uoLabelReturn[lPos].sGeneratedForPrinter 	= uoTemp[I].sGeneratedForPrinter
	Next

end if

// -----------------------------------------------------------
// Dann die Labels, die entfallen sollen,  erstellen
// -----------------------------------------------------------
dsLoading.SetFilter("nremove=1")
dsLoading.Filter()

dsCenOut.Reset()
dsCenOut.InsertRow(0)

f_sync_rows_datastore(dsCenOutHistory, dsCenOut, 1, 1)

if dsLoading.RowCount() > 0 then

	if this.of_label() <> 0 then
		return -1
	else
		uoDiff = this.uoLabel.uoResult
	end if
	
	For I = 1 to UpperBound(uoDiff)
		
		lPos = UpperBound(uoLabelReturn) + 1
		uoLabelReturn[lPos] 								= Create uo_label_return
		uoLabelReturn[lPos].sLabel 					= uf.translate("ENTF$$HEX1$$c400$$ENDHEX$$LLT - ") + uoDiff[I].sLabel
		uoLabelReturn[lPos].bLabel 					= uoDiff[I].bLabel
		uoLabelReturn[lPos].lLabelType 				= uoDiff[I].lLabelType
		uoLabelReturn[lPos].bLocationSheet 			= uoDiff[I].bLocationSheet
		uoLabelReturn[lPos].bDistributionErrors 	= uoDiff[I].bDistributionErrors
		uoLabelReturn[lPos].sLabelComment 			= uoDiff[I].sLabelComment
		uoLabelReturn[lPos].isBelly 					= uoDiff[I].isBelly
		uoLabelReturn[lPos].iPrinterType 			= uoDiff[I].iPrinterType
		uoLabelReturn[lPos].iLabelSort 				= uoDiff[I].iLabelSort
		uoLabelReturn[lPos].iLabelPageBreak 		= uoDiff[I].iLabelPageBreak
		uoLabelReturn[lPos].sGeneratedForPrinter 	= uoDiff[I].sGeneratedForPrinter
		
	Next

end if

return 0

end function

public function string of_checknull (string sVal);if isnull(sVal) then return ""

return sVal
end function

public function integer of_add_workstations ();/*
* Objekt : uo_client_label
* Methode: of_add_workstations (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 25.05.2011
*
* Argument(e):
* none
*
* Beschreibung:		Zuspielen der lokalen Bereichszuordnung
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0          <unknown>
* 1.1 			O.Hoefer	25.05.2011		Erstkommentar; R$$HEX1$$fc00$$ENDHEX$$ckg$$HEX1$$e400$$ENDHEX$$ngig Anforderung "mehrere Ws & Area" (Cart Diagramm Header)
*
*
* Return: integer
*
*/

// -----------------------------------------------------
// 
// Zuspielen der lokalen Bereichszuordnung
// 
// -----------------------------------------------------
Datastore	ds_temp
Long 			i, j, k, l, &
				lPL_Keys[], &
				lQuantity
Long 			lKey, lLabelTypeKey , lPrint, lType, lLabelQuantity
String		sText, sArea, sWorkStation, sAddOnText, sWorkstationText, sDistribitionText, sPL
	
datetime		dtDeparture
Integer	li_succ 
ds_temp = Create Datastore
ds_temp.DataObject = "dw_loading_list_result"

dsWorkstations.SetTransObject(sqlca)
dsWorkstations.SetFilter("")
dsWorkstations.Filter()
// ---------------------------------------------
// Erstellen Number Array
// und wenn wir schon mal am
// duchlaufen sind dann packen wir
// auch gleich die Mengen zu den Texten
// ---------------------------------------------
For i = 1 to dsLoading.RowCount()
	
	lPL_Keys[i] = dsLoading.GetItemNumber(i,"cen_packinglist_index_npackinglist_index_key")
	dsLoading.SetItem(i,"carea", "")  
	dsLoading.SetItem(i,"cworkstation", "")  
	dsLoading.SetItem(i,"cworkstation_text", "")
	
Next 

dtDeparture = dsCenOut.GetItemDateTime(1, "ddeparture")
dsWorkstations.Retrieve(isMandant, this.sUnit , lPL_Keys, dtDeparture)

if dsWorkstations.RowCount() > 0 then
	// ---------------------------------------------
	// Lokal
	// ---------------------------------------------
	For j = 1 to dsLoading.RowCount()
		dsLoading.RowsCopy(j,j,Primary!,ds_temp,ds_temp.RowCount() + 1,Primary!)
		ds_temp.SetItem(ds_temp.RowCount(),"carea_code","")  // Bereichsbezeichnung blank setzen
		// --------------------------------------------
		// Die PL aus der Beladung in der lokalen
		// Bereichszuordnung rausfiltern
		// --------------------------------------------
		lKey = dsLoading.GetItemNumber(j,"cen_packinglist_index_npackinglist_index_key")
		dsWorkstations.SetFilter("npackinglist_index_key = " + string(lKey))
		dsWorkstations.Filter()
		
		sPL = dsLoading.GetItemString(j, "cen_packinglist_index_cpackinglist")
		
		if  dsWorkstations.RowCount() > 0 then

			// -------------------------------------------------
			Long		ll_Count
			String	ls_Temp_Area, ls_Temp_WS, ls_Area_List
			
			
			// -------------------------------------------------
			// 25.05.2011 Issue 159 nut EINE WS & Area
			// -------------------------------------------------
			
			Long 		ll_Max_WS
			ll_Max_WS = 1			
			dsWorkstations.Sort()
			//ll_Max_WS = dsWorkstations.RowCount()
			
			// -------------------------------------------------
			// ENDE 25.05.2011 Issue 159 nut EINE WS & Area
			// -------------------------------------------------
			
			ls_Area_List= ""
			For ll_Count = 1 To ll_Max_WS 
				If ll_Count > 1 Then
					li_Succ = 0			
				End If
				ls_Temp_Area = dsWorkstations.GetItemString(ll_Count,"carea")
				ls_Temp_WS 		= dsWorkstations.GetItemString(ll_Count,"loc_unit_workstation_ctext")
				If IsNULL(ls_Temp_Area) Then ls_Temp_Area = ""
				If IsNULL(ls_Temp_WS) Then ls_Temp_WS = ""
				If Trim(ls_Temp_Area + ls_Temp_WS) > "" Then
					If Trim(ls_Area_List) > "" Then ls_Area_List += " "
					ls_Area_List += Trim(ls_Temp_Area) + "-" + Trim(ls_Temp_WS)
				End If
				if ii_Do_NOT_Trace= 0 then
					f_trace("uo_client_label.of_add_workstations Area Workstation " + String(lKey) + " " + ls_Area_List)
				End If
			Next
			If Trim(ls_Area_List) > "" Then
				li_Succ = ds_temp.SetItem(ds_temp.RowCount(),"carea_list", Left(ls_Area_List, 254))
				If Len(ls_Area_List) > 254 Then
					li_Succ = ds_temp.SetItem(ds_temp.RowCount(),"cws_list", Mid(ls_Area_List, 255, 254))
				Else
					li_Succ = ds_temp.SetItem(ds_temp.RowCount(),"cws_list", "")
				End If
			End If
			// -------------------------------------------------

			k = 1
			
			sArea 				= dsWorkstations.GetItemString(k,"carea")
			sWorkStation 		= dsWorkstations.GetItemString(k,"cworkstation")
			sWorkStationText  = dsWorkstations.GetItemString(k,"loc_unit_workstation_ctext")
			lLabelTypeKey 		= dsWorkstations.GetItemNumber(k,"nlabel_type_key")
			lLabelQuantity    = dsWorkstations.GetItemNumber(k,"nquantity")
			sAddOnText			= dsWorkstations.GetItemString(k,"loc_unit_pl_flight_label_ctext")
			sText					= dsWorkstations.GetItemString(k,"loc_unit_pl_flight_label_ctext2")
			lType					= 0  // 0=Masterlabel, 1=Dupliziertes Label
			lPrint 				= dsWorkstations.GetItemNumber(k,"nlabel_print")  
			
			// -------------------------------------------------------------------
			// Thema "Br$$HEX1$$f600$$ENDHEX$$tchent$$HEX1$$fc00$$ENDHEX$$ten nach Bedarf"
			// Verhalten wir bei gem$$HEX1$$e400$$ENDHEX$$ss Menge nur, dass Menge auf 10 gesetzt wird
			// und das Drucken abgestellt wird. (Hat den Effekt, dass nur die
			// gedruckt werden, die auch von der MZV gef$$HEX1$$fc00$$ENDHEX$$llt w$$HEX1$$fc00$$ENDHEX$$rden)
			// -------------------------------------------------------------------
			if lLabelQuantity = 3 then 
				lPrint = 0
			end if
			// --------------------------------------------------------------
			// Bereiche setzen
			// --------------------------------------------------------------
			li_Succ = ds_temp.SetItem(ds_temp.RowCount(),"carea_code",Trim(sArea) + "-" + Trim(sWorkStation))  // Bereichsbezeichnung
			ds_temp.SetItem(ds_temp.RowCount(),"cen_packinglists_nlabel_type_key", lLabelTypeKey) // Labeltype
			ds_temp.SetItem(ds_temp.RowCount(),"nlabel_type", lType)  // Master oder dupliziertes Label
			ds_temp.SetItem(ds_temp.RowCount(),"nprint", lPrint)  // Druck on-off

			li_succ = ds_temp.SetItem(ds_temp.RowCount(),"carea", sArea)  
			li_succ = ds_temp.SetItem(ds_temp.RowCount(),"cworkstation", sWorkStation)  
			li_succ = ds_temp.SetItem(ds_temp.RowCount(),"cworkstation_text",Trim(sWorkStationText))
			// --------------------------------------------------------------
			// AddOn Text tauschen
			// --------------------------------------------------------------
			if len(trim(sAddOnText)) > 0 or not isnull(sAddOnText) then
					ds_temp.SetItem(ds_temp.RowCount() ,"cen_loadinglists_cadd_on_text",sAddOnText)
			end if
			// --------------------------------------------------------------
			// Ganz zum Schluss dann entweder 1 Label mit der Menge oder
			// n - Label gem. der Menge aus der SSL erstellen
			//
			// lLabelQuantity = 1 = 1 Label
			// lLabelQuantity = 2 = Anzahl Label gem. Menge der St$$HEX1$$fc00$$ENDHEX$$ckliste
			// lLabelQuantity = 3 = Anzahl Label nach Bedarf (Br$$HEX1$$f600$$ENDHEX$$tchent$$HEX1$$fc00$$ENDHEX$$ten)
			// --------------------------------------------------------------
//			if sPL = "5*50912" then
//				Messagebox("", lLabelQuantity)
//			end if
			
			lQuantity = ds_temp.GetItemNumber(ds_temp.RowCount(),"cen_loadinglists_nquantity")	
			
			if lLabelQuantity = 1 then	
				if lQuantity > 1 then
					ds_temp.SetItem(ds_temp.RowCount(),"cen_packinglists_ctext_short", String(lQuantity) + " x " + ds_temp.GetItemString(ds_temp.RowCount(),"cen_packinglists_ctext_short"))
					ds_temp.SetItem(ds_temp.RowCount(),"cen_packinglists_ctext", String(lQuantity) + " x " +  ds_temp.GetItemString(ds_temp.RowCount(),"cen_packinglists_ctext"))
				end if	
			elseif lLabelQuantity = 2 then	
				
				ds_temp.SetItem(ds_temp.RowCount(),"nmodified", 1)
				
				For l = 1 to lQuantity - 1
					ds_temp.RowsCopy(ds_temp.RowCount(),ds_temp.RowCount(),Primary!,ds_temp,ds_temp.RowCount() + 1,Primary!)
					ds_temp.SetItem(ds_temp.RowCount(),"nmodified", l + 1)
				Next
			elseif lLabelQuantity = 3 then	
				
				ds_temp.SetItem(ds_temp.RowCount(),"nmodified", 1)
				
				For l = 1 to 9
					ds_temp.RowsCopy(ds_temp.RowCount(),ds_temp.RowCount(),Primary!,ds_temp,ds_temp.RowCount() + 1,Primary!)
					// ds_temp.SetItem(ds_temp.RowCount(),"nlabel_type", 1)
					ds_temp.SetItem(ds_temp.RowCount(),"nprint", 0)
					ds_temp.SetItem(ds_temp.RowCount(),"nmodified", l + 1)
				Next
			end if

		End if
		
	Next
	// --------------------------------------------------------------
	// Tempor$$HEX1$$e400$$ENDHEX$$rer Datastore zur$$HEX1$$fc00$$ENDHEX$$ckkopieren
	// --------------------------------------------------------------
	dsLoading.Reset()
	ds_temp.RowsCopy(1,ds_temp.RowCount(),Primary!,dsLoading,1,Primary!)

end if

return 1
end function

public function integer of_reckoning ();// -------------------------------------------------------------------------
// of_reckoning
// -------------------------------------------------------------------------
// Alle Datens$$HEX1$$e400$$ENDHEX$$tze mit unerw$$HEX1$$fc00$$ENDHEX$$nschtem Status l$$HEX1$$f600$$ENDHEX$$schen
// -------------------------------------------------------------------------
Long 		lRow, I
Integer  iValue, iHit


// -------------------------------------------------------------------------
// Array ist nicht gef$$HEX1$$fc00$$ENDHEX$$llt, kann zwar nicht sein, in diesem Fall dann aber
// lieber alle Label erstellen, als keine !!!
// -------------------------------------------------------------------------
if Upperbound(this.iReckoning) = 0 then
	this.iReckoning[1] = 0
	this.iReckoning[2] = 1
	this.iReckoning[3] = 2
	this.iReckoning[4] = 3
	this.iReckoning[5] = 4
end if


For lRow = this.dsLoading.RowCount() to 1 step -1
	
	iHit = 0 
	iValue = this.dsLoading.GetItemNumber(lRow, "nreckoning")
	if isnull(iValue) then iValue = 1
	
	For i = 1 to Upperbound(this.iReckoning)
		
		if iValue = this.iReckoning[i] then
			iHit = 1 
			exit
		end if 
		
	Next
	
	if iHit = 0 then
		this.dsLoading.DeleteRow(lRow)
	end if	
	
Next

return 0
end function

public function integer of_legs ();datastore 	dsLeg
Long			lRows, lMaxLeg
Integer		iTemp[]
String		ls_Empty[]

iLegs = iTemp

dsLeg			= create datastore
dsLeg.dataobject = "dw_uo_cen_out_leg"
dsLeg.SetTransObject(sqlca)
dsLeg.Retrieve(this.lResultKey)


is_Leg_Routing_from = ls_Empty
is_Leg_Routing_to = ls_Empty
for lRows = 1 to dsLeg.RowCount()
	
	this.iLegs[lRows] =  dsLeg.GetItemNumber(lRows, "nflight_number")
	is_Leg_Routing_from[lRows] = dsLeg.GetItemString(lRows, "ctlc_from") 
	is_Leg_Routing_to[lRows] = dsLeg.GetItemString(lRows, "ctlc_to") 
next

destroy(dsLeg)

return 0
end function

public function integer of_check_sheet ();// -----------------------------------------------------------
// 
// Beladung ermitteln
// 
// -----------------------------------------------------------
Long 		lStart, lEnde, I
Long		lStowages
Long		lContents
Long		lLabels, lBosta
Long		a, j, k, lCount, lPos
String	sFlight, sDeparture, sAircraft, sVersion, sHandling, sFetch, sClasses, sBosta, sPLType, sClass
String	sTLCFrom, sTLCTo, sReg,sComponents,sChecker
String	sHandling_Type
Integer	li_Succ

lStart = CPU()

//messagebox("this.iAddLabelOption", this.iAddLabelOption)

// -----------------------------------------------------------
// Kein ResultKey = Fehler
// -----------------------------------------------------------
if isNull(this.lResultKey) or this.lResultKey = 0 then
	sErrorMessage = uf.translate("Flugdaten k$$HEX1$$f600$$ENDHEX$$nnen nicht ermittelt werden!")
	return -1
end if

// -----------------------------------------------------------
// Die Fluginformationen die zum ResultKey geh$$HEX1$$f600$$ENDHEX$$ren einlesen
// -----------------------------------------------------------
if dsCenOut.RowCount() <= 0 then

	dsCenOut.Retrieve(this.lResultKey)
	if dsCenOut.RowCount() <= 0 then
		sErrorMessage = uf.translate("Keine Flugdaten gefunden!")
		return -1
	elseif dsCenOut.RowCount() > 1 then
		sErrorMessage = uf.translate("Flugdaten konnten nicht ermittelt werden!")
		return -1
	end if
	
end if

// -----------------------------------------------------------
// 19.08.2005
// Die Beladung ermitteln, bei Abfertigungsart DLV
// in cen_out_local_ssl (Der Scheich fliegt) nachschaun.
// -----------------------------------------------------------
if dsCenOut.GetItemString(1, "chandling_type_text") <> "DLV" then

	if this.of_get_standard_loading() <> 0 then
		sErrorMessage = uf.translate("Keine Standardbeladung gefunden!")
		return -1
	end if

else

	if this.of_get_local_standard_loading() <= 0 then
		sErrorMessage = uf.translate("Keine individuelle Standardbeladung gefunden!")
		return -1
	end if
	
end if

// -----------------------------------------------------------
// Sollen die Zustaulabel auf der Liste erscheinen, dann
// die Labeltype zuspielen, damit of_create_additional_label
// funktioniert
// -----------------------------------------------------------	
if this.iAddLabelOption = 1 then
	this.of_set_labeltype()
end if 
	
// -----------------------------------------------------------
// Die Lokalen Informationen zuspielen
// -----------------------------------------------------------	
this.of_add_workstations()

//of_dump_pps(dsLoading)

// -----------------------------------------------------------
// 21.08.2008
// Eventuelle zus$$HEX1$$e400$$ENDHEX$$tzliche lokale Beladung ermitteln
// -----------------------------------------------------------
if bAddLoad and dsCenOut.GetItemString(1, "chandling_type_text") <> "REQ" then
	long ll_rc = -1
	ll_rc = this.of_get_local_additional_loading()
//	MessageBox("of_check_sheet: lokale Sonderbeladung geholt", string(ll_rc))
end if

//this.dsLoading.saveas("c:\temp\cbase\out1.xls", Excel5!, True)

// -----------------------------------------------------------
// Die Komponentenverteilung
// -----------------------------------------------------------
if bLabel = false then
	
	if bDistribution then
	
		if this.of_distribution() = -1000 then
			If ii_Do_NOT_Trace = 0 Then
				f_trace("uo_client_label.of_check_sheet of_distribution() = -1000")
			end if

			return -1000
		end if
			If ii_Do_NOT_Trace = 0 Then
				f_trace("uo_client_label.of_check_sheet of_distribution() OK")
			end if
		
		if dsCenOut.RowCount() > 0 and uoDistribution.dsFlight.RowCount() > 0 then
			
			dsCenOut.SetItem(1, "cairline_owner", uoDistribution.dsFlight.GetItemString(1, "cairline_owner"))
			dsCenOut.SetItem(1, "cactype", uoDistribution.dsFlight.GetItemString(1, "cactype"))
			
		end if
		
	end if
	
	// -----------------------------------------------------------
	// Die Zustaulabel erstellen 
	// -----------------------------------------------------------	
	if this.iAddLabelOption = 1 then
		// this.of_check_sheet_prepare_text()
		this.of_create_additional_label()
	
		// ---------------------------------------------------------------
		// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob Mahlzeiten in den Stauort verteilt wurden,
		// wenn ja, dann den Stauort immer drucken, auch wenn lokal
		// die St$$HEX1$$fc00$$ENDHEX$$ckliste auf "no print" gesetzt ist
		// ---------------------------------------------------------------
		For I = 1 to this.dsLoading.RowCount()
			if Len(Trim(this.of_checknull(this.dsLoading.GetItemString(I, "cdistributed_components")))) > 0 then
				this.dsLoading.SetItem(I,"nprint", 1)
			end if
		Next
		
	end if
	
end if


//this.dsLoading.saveas("c:\temp\cbase\out2.xls", Excel5!, True)


// --------------------------------------------------------
// 
// Das CHECK Sheet f$$HEX1$$fc00$$ENDHEX$$llen
// 
// --------------------------------------------------------
// Header
// --------------------------------------------------------


if iManualInput = 0 then
	sFlight 			= dsCenOut.GetItemString(1, "cairline") + " " + String(dsCenOut.GetItemNumber(1, "nflight_number"), "000") + " " + dsCenOut.GetItemString(1, "csuffix")
else
	sFlight			= sManualAirline + " " + sManualFlightNumber
end if

sDeparture 		= String(dsCenOut.GetItemDateTime(1, "ddeparture"), s_app.sDateFormat) + "/" + dsCenOut.GetItemString(1, "cdeparture_time")
sAircraft		= dsCenOut.GetItemString(1, "cairline_owner") + " " + dsCenOut.GetItemString(1, "cactype") + " [" + dsCenOut.GetItemString(1, "cgalleyversion") + "]"
sVersion 		= dsCenOut.GetItemString(1, "cconfiguration")

sTLCFrom			= dsCenOut.GetItemString(1, "ctlc_from")
sTLCTo			= dsCenOut.GetItemString(1, "ctlc_to")
sReg				= dsCenOut.GetItemString(1, "cregistration")

// 12.03.2013 Handling Type added (CBASE-DE-CR-2013-002)
sHandling_Type	= dsCenOut.GetItemString(1, "chandling_type_description") // chandling_type_text

// ---------------------------------------------------------
// LL und SLL f$$HEX1$$fc00$$ENDHEX$$r den Header einsammeln
// 05.11.07: Da in dsLoadinglists gel$$HEX1$$f600$$ENDHEX$$scht wird, dsLoadinglistsInfoOnly verwenden
// ---------------------------------------------------------
sHandling = ""

//For I = 1 to dsLoadinglists.RowCount()
//	sHandling += dsLoadinglists.GetItemString(I, "cloadinglist") + " / " 
//Next

For I = 1 to dsLoadinglistsInfoOnly.RowCount()
	// 20.11.2009 HR:
	if i>1 then
		if dsLoadinglistsInfoOnly.find("cloadinglist='"+dsLoadinglistsInfoOnly.GetitemString(i,"cloadinglist")+"'",1, i - 1)>0 then continue
	end if

	sHandling += dsLoadinglistsInfoOnly.GetItemString(I, "cloadinglist") + " / " 
Next

sHandling = Mid(sHandling, 1, Len(sHandling) - 3)

// ---------------------------------------------------------
// BOSTA f$$HEX1$$fc00$$ENDHEX$$r den Header einsammeln
// ---------------------------------------------------------
DECLARE GetBosta CURSOR FOR  
select cclass, npax from cen_out_pax where nresult_key = :this.lResultkey and nbooking_class = 1 order by nclass_number;

open GetBosta;

If sqlca.sqlcode = 0 then
	
	sClasses = "("
	sBosta	= ""
	
	do While sqlca.sqlcode = 0
		Fetch GetBosta into :sFetch, :lBosta;
		if sqlca.sqlcode = 0 then
			
			sClasses  += sFetch + "/"
			sBosta  	 += String(lBosta, "000") + "-"
			
		end if
	loop
	
	sBosta	 	= Mid(sBosta, 1, Len(sBosta) - 1)
	sClasses 	= Mid(sClasses, 1, Len(sClasses) - 1)
	sClasses 	= sClasses + ")"
	
else

	this.of_log("ERROR CURSOR: [ " + string(sqlca.sqlcode) + " ] - " + sqlca.sqlerrtext )
	close GetBosta;
	return 0
	
end if


close GetBosta;

//this.dsLoading.saveas("c:\temp\cbase\out3.xls", Excel5!, True)
//
For I = 1 to this.dsLoading.RowCount()
	
	if this.dsLoading.GetItemNumber(I, "nprint") = 0 and &
		Len(Trim(this.of_checknull(this.dsLoading.GetItemString(I, "cdistributed_components")))) = 0 then
		
		continue
		
	end if

//	if this.dsLoading.GetItemNumber(I, "nprint") = 0  then
//		
//		continue
//		
//	end if
	
	a = this.dsCheckSheet.InsertRow(0)
	
	this.dsCheckSheet.SetItem(a, "sflight", sFlight)
	this.dsCheckSheet.SetItem(a, "sdeparture", sDeparture)
	this.dsCheckSheet.SetItem(a, "saircraft", sAircraft)
	this.dsCheckSheet.SetItem(a, "sversion", sVersion)
	this.dsCheckSheet.SetItem(a, "sbosta", sBosta)
	this.dsCheckSheet.SetItem(a, "sHandling", sHandling)
	
	this.dsCheckSheet.SetItem(a, "stlc_from", sTLCFrom)
	this.dsCheckSheet.SetItem(a, "stlc_to", sTLCTo)
	this.dsCheckSheet.SetItem(a, "sreg", sReg)
		
	this.dsCheckSheet.SetItem(a, "ngalley_pos", this.dsLoading.GetItemNumber(i, "ngalley_group"))
	this.dsCheckSheet.SetItem(a, "cpackinglist", this.dsLoading.GetItemString(i, "cen_packinglist_index_cpackinglist"))
	this.dsCheckSheet.SetItem(a, "cgalley", this.dsLoading.GetItemString(i, "cen_galley_cgalley") )
	this.dsCheckSheet.SetItem(a, "cstowage", this.dsLoading.GetItemString(i, "cen_stowage_cstowage"))
	this.dsCheckSheet.SetItem(a, "cplace", this.dsLoading.GetItemString(i, "cen_stowage_cplace"))
	this.dsCheckSheet.SetItem(a, "cunit", this.dsLoading.GetItemString(i, "cen_packinglists_cunit")) 
	this.dsCheckSheet.SetItem(a, "ctext", "[" + this.dsLoading.GetItemString(i, "cen_packinglist_index_cpackinglist") + "] - " + this.dsLoading.GetItemString(i, "cen_packinglists_ctext")) 
	this.dsCheckSheet.SetItem(a, "sworkstation", this.dsLoading.GetItemString(i, "carea") + " - " + this.dsLoading.GetItemString(i, "cworkstation_text"))  
	this.dsCheckSheet.SetItem(a, "carea", f_check_null(this.dsLoading.GetItemString(i, "carea")) )
	this.dsCheckSheet.SetItem(a, "cworkstation", f_check_null(this.dsLoading.GetItemString(i, "cworkstation")))
	this.dsCheckSheet.SetItem(a, "ngalley_sort", this.dsLoading.GetItemNumber(i, "cen_galley_nsort")) 
	this.dsCheckSheet.SetItem(a, "nstowage_sort", this.dsLoading.GetItemNumber(i, "cen_stowage_nsort")) 
	this.dsCheckSheet.SetItem(a, "nbelly", this.dsLoading.GetItemNumber(i, "cen_loadinglists_nbelly_container")) 
	this.dsCheckSheet.SetItem(a, "nmodified", this.dsLoading.GetItemNumber(i, "nmodified")) 
	this.dsCheckSheet.SetItem(a, "cdistributed", this.dsLoading.GetItemString(i, "cdistributed_components")) 
	this.dsCheckSheet.SetItem(a, "nduplicated", this.dsLoading.GetItemNumber(i, "nlabel_type")) 
	// 12.03.2013 Handling Type added (CBASE-DE-CR-2013-002)
	li_Succ = this.dsCheckSheet.SetItem(a, "chandling_type", sHandling_Type)
		
	// ------------------------------------------------------------------------------
	// 04.03.2013 MealCode Stelle 1-2 entfernen
	// ------------------------------------------------------------------------------	
	sComponents = Trim(this.of_checknull(this.dsCheckSheet.GetItemString(a, "cdistributed")))
	sComponents = of_remove_mealcode( sComponents)
	this.dsCheckSheet.SetItem(a, "cdistributed", sComponents)
	
Next

// 2012-08-30 nicht speichern
If s_app.itrace > 0 then
	this.dsCheckSheet.saveas(f_gettemppath()+"CheckSheet-1.xls", Excel5!, True)
end if


//if this.iAddLabelOption = 1 then
this.of_check_sheet_prepare_text()
//end if

if bCheckSheetOnlyUsed and not blabel then

	for a = this.dsCheckSheet.RowCount() to 1 Step -1
		
		sComponents = Trim(this.of_checknull(this.dsCheckSheet.GetItemString(a, "cdistributed")))
		sChecker 	= Trim(this.of_checknull(this.of_remove_cr(sComponents))) // CR/LF's entfernen
		
		// Messagebox("L  E  N  ", len(sChecker))
		// ... ist nix drin ???
		if len(sChecker) = 0 then
			
			this.dsCheckSheet.DeleteRow(a)
			
		end if
		
	next
	
end if

this.dsCheckSheet.Sort()
this.dsCheckSheet.GroupCalc()
// 2012-08-30 nicht speichern
if s_app.itrace > 0 then
	this.dsCheckSheet.saveas(f_gettemppath()+"CheckSheet-2.xls", Excel5!, True)
end if

// f_print_datastore(dschecksheet)


return 0
end function

public function long of_get_loadinglist_index_key (string sloadinglist);Long lIndex
  
SELECT cen_loadinglist_index.nloadinglist_index_key  
 INTO :lIndex  
 FROM cen_loadinglist_index  
WHERE ( cen_loadinglist_index.cloadinglist = :sLoadinglist ) AND  
		( cen_loadinglist_index.dvalid_from <= :this.dDeparture ) AND  
		( cen_loadinglist_index.dvalid_to >= :this.dDeparture )   ;

if sqlca.sqlcode = 100 then 
	uf.mbox("Achtung", "Keinen g$$HEX1$$fc00$$ENDHEX$$ltigen Schl$$HEX1$$fc00$$ENDHEX$$ssel f$$HEX1$$fc00$$ENDHEX$$r St$$HEX1$$fc00$$ENDHEX$$ckliste: ${" + sLoadinglist + "} f$$HEX1$$fc00$$ENDHEX$$r den ${" + String(this.dDeparture)+ "} gefunden!", StopSign!)
	return -1
elseif sqlca.sqlcode < 0 then 	
	f_db_error(sqlca, "")
	return -1	
end if

return lIndex
end function

public function integer of_create_additional_label ();// -----------------------------------------------------
// 
// Zuspielen der lokalen Bereichszuordnung
// 
// -----------------------------------------------------

Datastore	ds_temp
Long 			i, j, k, l, lLabelCounter, &
				lPL_Keys[], &
				lQuantity, &
				lDuplicated, &
				lRows, &
				lCounter, &
				lStart, &
				lEnd

Long 			lKey, lLabelTypeKey , lPrint, lType, lLabelQuantity
String		sNewUnit, sArea, sWorkStation, sAddOnText, sWorkstationText
String		sDistribitionText, sBelly
String		sFilter, sGalley, sStowage, sPlace, sOut, sText

String		sPackingLists[], &
				sItemText[], &
				sQuantities[],  &
				sEmpty[]

datetime		dtDeparture

long ll_TextHeight, ll_TextWidth

boolean lb_Bold

ds_temp = Create Datastore
ds_temp.DataObject = "dw_loading_list_result"

lStart = CPU()

// ---------------------------------------------
// Erstellen Number Array
// und wenn wir schon mal am
// duchlaufen sind dann packen wir
// auch gleich die Mengen zu den Texten
// ---------------------------------------------
For i = 1 to dsLoading.RowCount()
	
	lPL_Keys[i] = dsLoading.GetItemNumber(i,"cen_packinglist_index_npackinglist_index_key")
	
Next 

dtDeparture = dsCenOut.GetItemDateTime(1, "ddeparture")

dsWorkstations.dataobject = "dw_workstations_local"
dsWorkstations.SetTransObject(sqlca)
dsWorkstations.retrieve(isMandant, this.sUnit , lPL_Keys, dtDeparture)

// f_print_datastore(dsWorkstations)

if dsWorkstations.RowCount() > 0 then
	
	// ---------------------------------------------
	// Lokal
	// ---------------------------------------------
	For j = 1 to dsLoading.RowCount()
		
		dsLoading.RowsCopy(j,j,Primary!,ds_temp,ds_temp.RowCount() + 1,Primary!)
		
		sOut = dsLoading.GetItemString(j,"cen_galley_cgalley") + "-" + dsLoading.GetItemString(j,"cen_stowage_cstowage") + " " + dsLoading.GetItemString(j,"cen_stowage_cplace")
		sBelly = String(ds_temp.GetItemNumber(j,"cen_loadinglists_nbelly_container"))
		
		// -----------------------------------------------------------------
		// f$$HEX1$$fc00$$ENDHEX$$r ein dupliziertes Label ( 2 of 3 ....) wird kein Zustaulabel
		// erstellt ...
		// -----------------------------------------------------------------
		lDuplicated = dsLoading.GetItemNumber(j, "nduplicated")
		if isnull(lDuplicated) then lDuplicated = 0
		
		// -----------------------------------------------------------------
		// Das Label wurde dupliziert
		// -----------------------------------------------------------------
		if lDuplicated = 1 then continue

		// --------------------------------------------
		// Die PL aus der Beladung in der lokalen
		// Bereichszuordnung rausfiltern
		// --------------------------------------------
		lKey = dsLoading.GetItemNumber(j,"cen_packinglist_index_npackinglist_index_key")
		dsWorkstations.SetFilter("npackinglist_index_key = " + string(lKey))
		dsWorkstations.Filter()

		if dsWorkstations.RowCount() <= 1 then continue
		
//		if sOut = "27-17C F" then
//			messagebox("", sOut + " Belly: " + sBelly )
//		end if
		
		For k = 2 to dsWorkstations.RowCount()
			
			sArea 				= dsWorkstations.GetItemString(k,"carea")
			sWorkStation 		= dsWorkstations.GetItemString(k,"cworkstation")
			sWorkStationText  = dsWorkstations.GetItemString(k,"loc_unit_workstation_ctext")
			lLabelTypeKey 		= dsWorkstations.GetItemNumber(k,"nlabel_type_key")
			lLabelQuantity    = dsWorkstations.GetItemNumber(k,"nquantity")
			sAddOnText			= dsWorkstations.GetItemString(k,"loc_unit_pl_flight_label_ctext")
			sNewUnit				= f_check_null(dsWorkstations.GetItemString(k,"loc_unit_pl_flight_label_ctext2"))
			lType					= 0  // 0=Masterlabel, 1=Dupliziertes Label
			lPrint 				= dsWorkstations.GetItemNumber(k,"nlabel_print")  
			
			if k > 1 then
				dsLoading.RowsCopy(j,j,Primary!,ds_temp,ds_temp.RowCount() + 1,Primary!)
				lType = 1  // 0=Masterlabel, 1=Dupliziertes Label
			end if

			// --------------------------------------------------------------
			// Bereiche & Zusatzinfos setzen 
			// --------------------------------------------------------------
			ds_temp.SetItem(ds_temp.RowCount(),"carea_code",Trim(sArea) + "-" + Trim(sWorkStation))  // Bereichsbezeichnung
			ds_temp.SetItem(ds_temp.RowCount(),"cen_packinglists_nlabel_type_key", lLabelTypeKey) // Labeltype
			ds_temp.SetItem(ds_temp.RowCount(),"nlabel_type", lType)  // Master oder dupliziertes Label
			ds_temp.SetItem(ds_temp.RowCount(),"nprint", lPrint)  // Druck on-off
			ds_temp.SetItem(ds_temp.RowCount(),"pldetail_label_counter", " ")	
			ds_temp.SetItem(ds_temp.RowCount(),"carea", sArea)  
			ds_temp.SetItem(ds_temp.RowCount(),"cworkstation", sWorkStation)  
			ds_temp.SetItem(ds_temp.RowCount(),"cworkstation_text",Trim(sWorkStationText))
			// --------------------------------------------------------------
			// Nur wenn es ein dupliziertes Label ist
			// den AddOn Text / Beh$$HEX1$$e400$$ENDHEX$$ltnis tauschen
			// --------------------------------------------------------------
			if lType = 1 then			
				
				if len(trim(sAddOnText)) > 0 or not isnull(sAddOnText) then
						ds_temp.SetItem(ds_temp.RowCount() ,"cen_loadinglists_cadd_on_text",sAddOnText)
				end if
				
				if len(trim(sNewUnit)) > 0 or not isnull(sNewUnit) then
						ds_temp.SetItem(ds_temp.RowCount() ,"cen_packinglists_cunit",sNewUnit)
				end if
				
				
			end if
			
			// --------------------------------------------------------------
			// Ganz zum Schluss dann entweder 1 Label mit der Menge oder
			// n - Label gem. der Menge aus der SSL erstellen
			//
			// lLabelQuantity = 1 = 1 Label
			// lLabelQuantity = 2 = Anzahl Label gem. Menge der St$$HEX1$$fc00$$ENDHEX$$ckliste
			// --------------------------------------------------------------
			lQuantity = ds_temp.GetItemNumber(ds_temp.RowCount(),"cen_loadinglists_nquantity")	
			
			if lLabelQuantity = 1 then	
				if lQuantity > 1 then
					ds_temp.SetItem(ds_temp.RowCount(),"cen_packinglists_ctext_short", String(lQuantity) + " x " + ds_temp.GetItemString(ds_temp.RowCount(),"cen_packinglists_ctext_short"))
					ds_temp.SetItem(ds_temp.RowCount(),"cen_packinglists_ctext", String(lQuantity) + " x " +  ds_temp.GetItemString(ds_temp.RowCount(),"cen_packinglists_ctext"))
				end if	
			else
				For l = 1 to lQuantity - 1
					ds_temp.RowsCopy(ds_temp.RowCount(),ds_temp.RowCount(),Primary!,ds_temp,ds_temp.RowCount() + 1,Primary!)
				Next
			end if

		Next
		
	Next
	// --------------------------------------------------------------
	// Tempor$$HEX1$$e400$$ENDHEX$$rer Datastore zur$$HEX1$$fc00$$ENDHEX$$ckkopieren
	// --------------------------------------------------------------
	dsLoading.Reset()
	ds_temp.RowsCopy(1,ds_temp.RowCount(),Primary!,dsLoading,1,Primary!)

end if

// -------------------------------------------------------
//
// Zum Schluss noch die Komponenten auf Zustaulabel 
// bringen, die in den Bereich geh$$HEX1$$f600$$ENDHEX$$ren, bzw. die 
// Komponenten wieder entfernen, die in andere Bereiche
// geh$$HEX1$$f600$$ENDHEX$$ren
// -------------------------------------------------------
ds_temp.reset()
dsLoading.RowsCopy(1,dsLoading.RowCount(),Primary!,ds_temp,1,Primary!)
string sComponents, sTemp

dsWorkstations.dataobject = "dw_workstations_local"
dsWorkstations.SetTransObject(sqlca)

For i = 1 to ds_temp.RowCount()
	
	// -----------------------------------------------------
	// nlabel_type = 1 = Zustaulabel ---> Treffer
	// -----------------------------------------------------
	if ds_temp.GetItemNumber(i,"nlabel_type") = 1  and ds_temp.GetItemNumber(i,"nduplicated") = 0 then 
		
		sArea				= ds_temp.GetItemString(i, "carea")  
		sWorkStation	= ds_temp.GetItemString(i, "cworkstation") 

		sGalley 			= ds_temp.GetItemString(i,"cen_galley_cgalley")
		sStowage 		= ds_temp.GetItemString(i,"cen_stowage_cstowage")
		sPlace 			= ds_temp.GetItemString(i,"cen_stowage_cplace")
		sBelly			= String(ds_temp.GetItemNumber(i,"cen_loadinglists_nbelly_container"))
		sOut 				= sGalley + "-" + sStowage + " " + sPlace
		
		// -----------------------------------------------------
		// Alle Masterlabel des gleichen Stauorts
		// aus der Beladung anzeigen
		// -----------------------------------------------------
		sFilter 	= "cen_galley_cgalley = '" + sGalley + "' and "
		sFilter 	+= "cen_stowage_cstowage = '" + sStowage + "' and "
		sFilter 	+= "cen_stowage_cplace = '" + sPlace + "' and "
		sFilter 	+= "cen_loadinglists_nbelly_container = " + sBelly + " and "
		sFilter 	+= "nlabel_type = 0"
		
		//Messagebox("", sFilter)
		
		dsLoading.SetFilter(sFilter)
		dsLoading.Filter()

		sTemp			= ""
		sComponents = ""
		
		// -----------------------------------------------------
		// Da durch die beste Mahlzeitenverteilung aller Zeiten
		// mittlerweile mehrere Label f$$HEX1$$fc00$$ENDHEX$$r einen Stauort m$$HEX1$$f600$$ENDHEX$$glich
		// sind, erstmal alle Komponente der Labels "zusammen-
		// addieren" ...
		// -----------------------------------------------------
		
		for j = 1 to dsLoading.RowCount()
			
			sTemp  		= this.of_checknull(dsLoading.GetItemString(j, "cdistributed_components"))
			
			if len(sTemp) > 0 then
				sComponents +=  sTemp
			end if
			
		next
					
		if len(sComponents) > 2 then 
			
			sPackingLists 	= sEmpty
			sItemText		= sEmpty
			sQuantities		= sEmpty
			// --------------------------------------------------------------------------
			// of_cleanup_components
			// --------------------------------------------------------------------------
			// hier werden die Komponenten aud dem String sComponents entfernt
			// die nicht in den Bereich geh$$HEX1$$f600$$ENDHEX$$ren. Die Komponenten (Menge, Text, Nummer)
			// stehen nochmal in den Array's
			// --------------------------------------------------------------------------
			sComponents = this.of_cleanup_components(sComponents, dtDeparture, sArea, sWorkStation, sQuantities, sItemText, sPackingLists)
			lRows 		= Upperbound(sQuantities) //this.of_rowcount(sComponents)
			
			
			
			// ------------------------------------------------------------------------------------
			// So die Komponenten sind drauf, jetzt gilt es festzustellen, ob sie auch alle 
			// drauf passen. Wenn nicht, dann die das Label entsprechend duplizieren
			// ------------------------------------------------------------------------------------
			String sFontname
			Long 	lFontweight, lFontsize, lObjectHeight, lTextHeight, lTextRows, lMaxLabels, lLabelType
			Long	lWrap
			
			lLabelType = ds_temp.GetItemNumber(i, "cen_packinglists_nlabel_type_key")
			this.dsLabelObjects.Retrieve(lLabelType, this.of_find_valid_label(lLabelType, Datetime(this.dDeparture)))
				
			if this.dsLabelObjects.RowCount() = 0 then 	// das Feld cdistributed_components ist nicht vorhanden
																		// die Verteilten Komponenten erscheinen nicht auf dem Label
				ds_temp.SetItem(i, "cdistributed_components", "")
				continue
			else
				lWrap         = this.dsLabelObjects.Getitemnumber(1,"nwrap")
				sFontname     = this.dsLabelObjects.Getitemstring(1,"cfontname")
				lFontweight   = this.dsLabelObjects.Getitemnumber(1,"nfontweight")
				lFontsize     = this.dsLabelObjects.Getitemnumber(1,"nfontsize") 
				lObjectHeight = this.dsLabelObjects.Getitemnumber(1,"nheight")
				lb_Bold       = (lFontweight = 700)
				
				iuo_FontCalc.of_GetTextSize("Calculate", sFontName, lFontSize * -1, lb_Bold, false, false, ll_TextHeight, ll_TextWidth)
				lTextHeight = ll_TextHeight
				
				if lWrap = 1 then
					lObjectHeight = lObjectHeight / 2
				end if
				
				lTextRows				= lObjectHeight / lTextHeight
				//Messagebox("+++ UO_DISTRIBUTION +++", "lHeight: "  + string(lObjectHeight) + "~r~rlTextHeight: " + string(lTextHeight) +  "~r~rlTextRows: " +  string(lTextRows))
			end if

			lMaxLabels				= ceiling(lRows / lTextRows)
			
			// --------------------------------------------------------------------------
			// so ... wir wissen nun, dass:
			//                               lTextRows  = die Anzahl der Zeilen die auf 
			//                                            das label passen
			//
			//                               lRows      = die Anzahl verteilter Komponenten
			//                                            ist
			// 
			// 										lMaxLabels = die Anzahl der Label, die erstellt 
			//                                            werden muss
			// --------------------------------------------------------------------------
			
			lCounter = 0
			lLabelCounter = 1
			sText = ""
	
			//Messagebox("      ", "MaxLabels: " + String(lMaxLabels) + "~nlRows: "  + string(lRows) +  + "~nlTextRows: " + string(lTextRows) + "~nComponents: " + sComponents)	
			
			// --------------------------------------------------------------------------
			// Komponenten erstmal entfernen
			// --------------------------------------------------------------------------
			ds_temp.SetItem(i, "cdistributed_components", "")
			
			for l = 1 to lRows
				
				sText = sQuantities[l] + "~t"
				sText += sItemText[l]   + "~t"
				sText += sPackingLists[l] + "~n"
				
				// ----------------------------------------------------------------------
				// pr$$HEX1$$fc00$$ENDHEX$$fen, dass wenn die maximal zul$$HEX1$$e400$$ENDHEX$$ssige Anzahl an Texten eingetragen
				// wurde ein Rowscopy passiert
				// ----------------------------------------------------------------------
				lCounter ++
				
				sText = this.of_checknull(ds_temp.GetItemString(i, "cdistributed_components")) + sText
				
				//Messagebox("", sText)
				
				ds_temp.SetItem(i, "cdistributed_components", sText)
				ds_temp.SetItem(i, "pldetail_label_counter", string(lLabelCounter) + " of " + string(lMaxLabels))
				
				if lCounter = lTextRows then
					// ---------------------------------------------------------------------------
					// Watermark "lTextrows ist erreicht, jetzt muss das Label dupliziert werden
					// ---------------------------------------------------------------------------
					
					ds_temp.SetItem(i, "pldetail_label_counter", string(lLabelCounter) + " of " + string(lMaxLabels))
					if lLabelCounter > 1 then ds_temp.SetItem(i, "nduplicated", 1)
					
					lLabelCounter ++								
					lCounter = 0
					// --------------------------------------------------------------------
					// Zeile (aus Komponenten) kopieren, nat$$HEX1$$fc00$$ENDHEX$$rlich nur wenn es 
					// nicht die letzte ist 
					// --------------------------------------------------------------------
					if l <> lRows then
						ds_temp.RowsCopy(i, i, Primary!, ds_temp, i + 1, Primary!)
						ds_temp.SetItem(i + 1, "cdistributed_components", "")
						ds_temp.SetItem(i + 1, "pldetail_label_counter", "")
						ds_temp.SetItem(i + 1, "nduplicated", 1)
						i ++
						
						if i > ds_temp.RowCount() then exit
						
					else
						exit
					end if
					
				end if	
				
			next
			
			
		end if
		
		// Alt & falsch, ber$$HEX1$$fc00$$ENDHEX$$cksichtigt den $$HEX1$$dc00$$ENDHEX$$berlauf nicht !!!
		// ds_temp.SetItem(i,"cdistributed_components", sComponents)
		
	end if
	
	sFilter = ""
	dsLoading.SetFilter(sFilter)
	dsLoading.Filter()
	
Next

sFilter = ""
dsLoading.SetFilter(sFilter)
dsLoading.Filter()

dsLoading.Reset()
ds_temp.RowsCopy(1,ds_temp.RowCount(),Primary!,dsLoading,1,Primary!)

lEnd = CPU()
// Messagebox("", "of_create_additional_label took: " + string(lEnd - lStart, "0.00") + " seconds!") 

return 0
end function

public function integer of_get_standard_loading_userdefined (string sll[], string ssll[], datetime ddeparturedate, string stime);// -----------------------------------------------------
// 
// Beladung ermitteln
// 
// -----------------------------------------------------
integer					iTrafficDay
integer					iCounter,i
uo_flight_explosion	uo_explosion

uo_explosion = create uo_flight_explosion
// ---------------------------------------------------------------------
// Die $$HEX1$$dc00$$ENDHEX$$bergabestruktur f$$HEX1$$fc00$$ENDHEX$$llen
// ---------------------------------------------------------------------
uo_explosion.dtDepartureDate	= dDepartureDate
uo_explosion.sDepartureTime	= sTime

this.dDeparture = Date(uo_explosion.dtDepartureDate)

// ------------------------------------------
// Verkehrstag ermitteln
// ------------------------------------------	
iTrafficDay = DayNumber(Date(uo_explosion.dtDepartureDate))
iTrafficDay --
if iTrafficDay = 0 then iTrafficDay = 7	
uo_explosion.sVerkehrstag		= string(iTrafficDay)

// ---------------------------------------------------------------------
// Das Arrays mit Loadinglistkeys f$$HEX1$$fc00$$ENDHEX$$r den Retrieve f$$HEX1$$fc00$$ENDHEX$$llen
// ---------------------------------------------------------------------	
iCounter = 0
For i = 1 to UpperBound(sLL)
	iCounter ++
	uo_explosion.lFirstArgRetrieve[iCounter] = of_get_loadinglist_index_key(sLL[i])
Next	

// ---------------------------------------------------------------------
// Das Arrays mit Supplement Loadinglistkeys f$$HEX1$$fc00$$ENDHEX$$r den Retrieve f$$HEX1$$fc00$$ENDHEX$$llen
// ---------------------------------------------------------------------
iCounter = 0
For i = 1 to UpperBound(sSLL)
	iCounter ++
	uo_explosion.lSecondArgRetrieve[iCounter] = of_get_loadinglist_index_key(sSLL[i])
Next	

// ---------------------------------------------------------------------
// Daten holen
// ---------------------------------------------------------------------
if uo_explosion.uf_retrieve() <= 0 then
	return -1
else

	if uo_explosion.ds_loadinglist.RowsCopy(1, uo_explosion.ds_loadinglist.RowCount(), Primary!, this.dsLoading, this.dsLoading.RowCount() + 1, Primary!) <> 1 then
		this.sErrorMessage = "Rowscopy failed!"
		return -1
	end if	

end if

For I = 1 to this.dsLoading.RowCount()
	
	if this.dsLoading.GetItemString(i,"cen_loadinglists_cactioncode") = "L" then
		this.dsLoading.SetItem(i,"cen_loadinglists_cactioncode", "") 
	end if
	
Next

destroy(uo_explosion)	

return 0
end function

public function datetime of_find_valid_label (long llabeltype, datetime dtsearch);// -----------------------------------------
// Suchen des g$$HEX1$$fc00$$ENDHEX$$ltigen Labels
// -----------------------------------------

datetime dtvalid

SELECT cen_label_type_detail.dvalid_from
 INTO :dtValid
 FROM cen_label_type,   
		cen_label_type_detail  
WHERE ( cen_label_type_detail.nlabel_type_key = cen_label_type.nlabel_type_key ) and  
		(( cen_label_type_detail.dvalid_from <= :dtSearch ) AND  
		( cen_label_type_detail.dvalid_to >= :dtSearch )   AND 
		( cen_label_type_detail.nLabel_type_key = :lLabelType ));
		 
		 
if sqlca.sqlcode <> 0 then
	of_log("Error -2, no valid Label found")
	of_log("Error -2, arguments: dtSearch = " + String(dtSearch) + " lLabelType = " + string(lLabelType))
	of_log("Error -2,    SQLCODE: " + string(sqlca.sqlcode))
	of_log("Error -2, SQLERRTEXT: " + sqlca.sqlerrtext) 
	SetNull(dtValid)
end if


return dtValid
end function

public function long of_rowcount (string svalue);// ------------------------------------
// ~n Zahlen
// ------------------------------------
Integer 	I
long		lCount
String 	sReturn, sTemp

lCount = 0

for i = 1 to Len(sValue) 
	
	sTemp = Mid(sValue, i, 1)
	
	if sTemp = "~n" then
		lCount ++
	end if
	
next

return lCount
end function

public function string of_cleanup_components (string scomponents, datetime dtdeparture, string sarea, string sworkstation, ref string squantities[], ref string sitemtext[], ref string spackinglists[]);// --------------------------------------------------------
// Bei Zustaulabel, in die Componenten verteilt wurden
// die "bereichsfremden" entfernen
// --------------------------------------------------------
Long 		lPL_Keys[], &
			i, j, &
			lHits[]

Integer 	iStartPos, &
			iEndPos, &
			iPos, &
			iPosText, &
			iPosPLNumber, &
			iCount, &
			iItem

string 	sToken, &
			sText, &
			sPLNumber, &
			sQuantity, &
			sOut, &
			sReturn, &
			sEmpty[], &
			sTempQuantities[], &
			sTempItemtext[], &
			sTempPackinglists[]

// ----------------------------------------------------
// Tab getrennte Text aufsplitten
// ----------------------------------------------------
iEndPos		= 1
iStartPos 	= 1

do while iEndPos > 0
			
	iEndPos	 = Pos(sComponents, "~n",  iStartPos)
				
	if iEndPos > 0 then
				
		sToken 			= Mid(sComponents, iStartPos, iEndPos - iStartPos)
				
		iPos 				= Pos(sToken, "~t")
		iPosText			= Pos(sToken, "~t", iPos + 1)
		
		// -------------------------------------------------------------------
		// Die Werte je Zeile in Arrays schreiben
		// -------------------------------------------------------------------
		sTempQuantities[UpperBound(sTempQuantities) + 1] 		= Mid(sToken, 1, iPos -1)
		sTempItemText[UpperBound(sTempItemText) + 1]  		= Mid(sToken, iPos + 1, iPosText - iPos - 1)
		sTempPackingLists[UpperBound(sTempPackingLists) + 1]	= Mid(sToken, iPosText + 1) 
	
		iStartPos = iEndPos + 1			
					
	end if
	
	iCount ++
	if iCount > 1000 then exit
	
loop

// -------------------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r die vorliegenden St$$HEX1$$fc00$$ENDHEX$$cklisten die IndexKeys ermitteln
// -------------------------------------------------------------------
sOut = ""
For I = 1 to UpperBound(sTempPackingLists)
	lPL_Keys[Upperbound(lPL_Keys) + 1] = f_get_packinglist_key(sTempPackingLists[i])
	sOut += string(lPL_Keys[i]) + " - " + sTempPackingLists[i] + "~n"
Next

// -------------------------------------------------------------------
// Die Arbeitspl$$HEX1$$e400$$ENDHEX$$tze der St$$HEX1$$fc00$$ENDHEX$$cklisten retrieven
// -------------------------------------------------------------------
dsWorkstations.retrieve(isMandant, this.sUnit , lPL_Keys, dtDeparture)

//f_print_datastore(dsWorkstations)
//Messagebox(sArea + "-" + sWorkstation + "    ", "IN:~n" + sComponents + "~n~nOUT:~n" + sOut)
if dsWorkstations.RowCount() <= 0 then 
	
	squantities[]		= sEmpty[]
	sitemtext[]			= sEmpty[]
	spackinglists[]	= sEmpty[]	
	return ""
	
end if

For i = 1 to UpperBound(lPL_Keys)
	
	for j = 1 to dsWorkstations.RowCount()
		// ------------------------------------------------------------------------
		// St$$HEX1$$fc00$$ENDHEX$$ckliste/Bereich/Arbeitsplatz passen, dann merken wir uns die Zeile
		// ------------------------------------------------------------------------		
		if lPL_Keys[i] 	= dsWorkstations.GetItemNumber(j, "npackinglist_index_key") and &
			sArea				= dsWorkstations.GetItemString(j, "carea") and &
			sWorkstation	= dsWorkstations.GetItemString(j, "cworkstation") then
			lHits[UpperBound(lHits) + 1] = i
			exit
		end if 
	next 
	
Next

// -------------------------------------------------------------------
// Aus den Treffern einen neuen String basten
// -------------------------------------------------------------------
sReturn = ""
For i = 1 to UpperBound(lHits)
	sReturn += sTempQuantities[lHits[i]] + "~t" + sTempItemText[lHits[i]] + "~t" + sTempPackingLists[lHits[i]] + "~n" 
	
	sQuantities[UpperBound(sQuantities) + 1] 		= sTempQuantities[lHits[i]]
	sItemText[UpperBound(sItemText) + 1]			= sTempItemText[lHits[i]]
	sPackingLists[UpperBound(sPackingLists) + 1] = sTempPackingLists[lHits[i]]	
Next

//Messagebox(sArea + "-" + sWorkstation + "    ", "IN:~n" + sComponents + "~n~nOUT:~n" + sOut)
//Messagebox(sArea + "-" + sWorkstation + "    ", sReturn)

return sReturn


end function

public function integer of_get_local_standard_loading ();
/* 
* Funktion:			of_get_local_standard_loading
* Beschreibung: 	holen der eventuell vorhandenen lokalen Beladungen zum flug
*						(aus loc_unit_add_load & loc_unit_add_detail)
* Besonderheit: 	
*
* Argumente: 
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			???			xx.xx.xxxx		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		26.11.2008		setzen class1, class2, class3 erg$$HEX1$$e400$$ENDHEX$$nzt 
*
* Return Codes:
*	0		alles ok, nichts gefunden
*	> 0	alles ok, Anzahl S$$HEX1$$e400$$ENDHEX$$tze im datastore
*/


Long			lRow, lLoop, lFound
String			 sClass
Datastore 	dsLocal

// ------------------------------------------
// Daten lesen
// ------------------------------------------	
dsLocal = create datastore
dsLocal.dataobject = "dw_local_loading_edit"
dsLocal.Settransobject(sqlca)
dsLocal.Retrieve(this.lResultKey)

if dsLocal.RowCount() = 0 then return -1

// ------------------------------------------
// gelesene Daten eintragen
// ------------------------------------------	
For lLoop = 1 to dsLocal.RowCount()
	
	lRow = this.dsLoading.InsertRow(0)
	
	sClass = dsLocal.GetItemString(lLoop, "cclass")
	
	this.dsLoading.SetItem(lRow, "cen_galley_cgalley", dsLocal.GetItemString(lLoop, "cgalley"))
	this.dsLoading.SetItem(lRow, "cen_stowage_cstowage", dsLocal.GetItemString(lLoop, "cstowage"))
	this.dsLoading.SetItem(lRow, "cen_loadinglists_cclass", sClass)
	// klasse aufsplitten, falls mehrere
	if len(sClass) > 0 then this.dsLoading.SetItem(lRow, "cclass1", mid(sClass,1,1))
	if len(sClass) > 1 then this.dsLoading.SetItem(lRow, "cclass2", mid(sClass,2,1))
	if len(sClass) > 2 then this.dsLoading.SetItem(lRow, "cclass3", mid(sClass,3,1))

	this.dsLoading.SetItem(lRow, "cen_packinglists_cunit", dsLocal.GetItemString(lLoop, "cunit"))
	this.dsLoading.SetItem(lRow, "cen_packinglist_index_cpackinglist", dsLocal.GetItemString(lLoop, "cpackinglist"))
	this.dsLoading.SetItem(lRow, "cen_packinglists_ctext", dsLocal.GetItemString(lLoop, "ctext"))
	this.dsLoading.SetItem(lRow, "cen_loadinglists_cadd_on_text", dsLocal.GetItemString(lLoop, "cadd_on_text"))
	this.dsLoading.SetItem(lRow, "cen_packinglists_nlabel_type_key", dsLocal.GetItemNumber(lLoop, "nlabel_type_key"))
	this.dsLoading.SetItem(lRow, "cen_galley_nsort", dsLocal.GetItemNumber(lLoop, "ngalley_sort"))
	this.dsLoading.SetItem(lRow, "cen_galley_ngalley_key", dsLocal.GetItemNumber(lLoop, "ngalley_sort"))
	this.dsLoading.SetItem(lRow, "cen_stowage_nsort", dsLocal.GetItemNumber(lLoop, "nstowage_sort"))
	this.dsLoading.SetItem(lRow, "cen_stowage_nstowage_key", dsLocal.GetItemNumber(lLoop, "nstowage_sort"))
	
	this.dsLoading.SetItem(lRow,"cen_loadinglists_nbelly_container", 0)
	this.dsLoading.SetItem(lRow, "cen_loadinglist_index_cloadinglist", "")
	this.dsLoading.SetItem(lRow, "cen_stowage_cplace", "")
	this.dsLoading.SetItem(lRow, "cen_loadinglists_cmeal_control_code", "")
	this.dsLoading.SetItem(lRow, "cen_loadinglists_nlabel_quantity", 1)
	this.dsLoading.SetItem(lRow, "nprint", 1)
	this.dsLoading.SetItem(lRow, "stationinstruction", 1)
	this.dsLoading.SetItem(lRow, "carea_code", "")
	this.dsLoading.SetItem(lRow, "cworkstation", "")
	this.dsLoading.SetItem(lRow, "carea", "")
	this.dsLoading.SetItem(lRow, "ndistribution_detail_key", lLoop)
	
	
Next


return this.dsLoading.RowCount()
end function

public function integer of_label ();
/*
* Objekt: 	uo_client_label
* Methode:	of_label (Function)
*
* Argument(e):
*
* Beschreibung:		Labels bauen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				??? 				xx.xx.xxxx		Erstellung
* 1.1 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		29.05.2012		bestbefore bestimmen und $$HEX1$$fc00$$ENDHEX$$bergeben erg$$HEX1$$e400$$ENDHEX$$nzt
* 1.2				M.Barfknecht	21.01.2013		Healhtmarkinfos f$$HEX1$$fc00$$ENDHEX$$r UK erg$$HEX1$$e400$$ENDHEX$$nzt
*
*
* Return: integer
*	0 	alles geklappt
*	-1 fehler
*/

// hilfsvariable
str_bitmaps 		strBMP[]
integer 				iRet, i
blob 					bXMLDok, bXMLFragment
Long					lIndex

String				sPrintBefore, sPrintAfter, sBoxFrom, sBoxTo, sRampBox,sflightunit
string				shealth_header,shealth_detail,shealth_footer
s_Flight 			sFlight

// hilfsvariable berechnung bestbefore
uo_datetime_functions luo_DateFunctions
Datetime ldt_help
Long 	ll_BestBeforeMinutes = 0

f_trace("uo_client_label.of_label START")

uoLabel.sLocalPrinters		 = this.sLocalPrinters
uoLabel.sLocalBellyPrinters = this.sLocalBellyPrinters
uoLabel.lLocalLabelTypes	 = this.lLocalLabelTypes
uoLabel.strLabelTypes		 = this.strLabelTypes
uoLabel.sPrintWeekDay		 = this.sWeekdays[DayNumber(Today())]


if bDistribution then

	f_trace("uo_client_label.of_label BEFORE uoLabel.dsDistributionErrors.SetFullState(this.blbDistributionError)")

	
	uoLabel.dsDistributionErrors.SetFullState(this.blbDistributionError)
	
end if

	f_trace("uo_client_label.of_label BEFORE  dsCenOut.Rowcount() ")


// 19.08.2009 Ulrich Paudler [UP] Nothalt wenn dsCenOut leer!
if dsCenOut.Rowcount() < 1 then
	this.sErrorMessage = "CEN_OUT: No data available"
	return -1
end if

f_trace("uo_client_label.of_label BEFORE of_get_bestbefore_minutes ")

// hole offset f$$HEX1$$fc00$$ENDHEX$$r Best Before
ll_BestBeforeMinutes = of_get_bestbefore_minutes(dsCenOut.GetItemString(1, "cClient"), dsCenOut.GetItemString(1, "cUnit"), dsCenOut.GetItemNumber(1, "nAirline_Key"))

f_trace("uo_client_label.of_label BEFORE cbox_from ")


sBoxFrom = f_check_null(dsCenOut.GetItemString(1, "cbox_from"))
sBoxTo 	= f_check_null(dsCenOut.GetItemString(1, "cbox_to"))

if f_check_null(sBoxFrom) <> "" or f_check_null(sBoxTo) <> "" then
	if sBoxFrom = sBoxTo then
		sRampBox		=  "B: " + sBoxFrom
	else
		sRampBox		=  "B: " + sBoxFrom + " - " + sBoxTo
	end if
end if	

uoLabel.sbox_from  = sBoxFrom
uoLabel.sbox_to    = sBoxTo

uoLabel.sRampTime	 				= dsCenOut.GetItemString(1, "cramp_time")
uoLabel.sKitchenTime				= dsCenOut.GetItemString(1, "ckitchen_time")
uoLabel.sRampBox					= sRampBox
uoLabel.lResultKey					= this.lResultKey
// -------------------------------------------------------------------------
// Alle Datens$$HEX1$$e400$$ENDHEX$$tze mit unerw$$HEX1$$fc00$$ENDHEX$$nschtem Status l$$HEX1$$f600$$ENDHEX$$schen
// -------------------------------------------------------------------------
// this.of_reckoning()
// -------------------------------------------------------------------------
// Array mit Flugnummern der Legs f$$HEX1$$fc00$$ENDHEX$$llen
// -------------------------------------------------------------------------
f_trace("uo_client_label.of_label BEFORE of_legs ")


this.of_legs()
uoLabel.iLegs = this.iLegs
uoLabel.is_Leg_Routing_From = this.is_Leg_Routing_From
uoLabel.is_Leg_Routing_To = this.is_Leg_Routing_to

//--------------------------------------------------------------
// MB 21.01.2013: Healthmarkinfos f$$HEX1$$fc00$$ENDHEX$$r UK ermitteln
//--------------------------------------------------------------

sflightunit = dsCenOut.GetItemString(1, "cunit")

f_trace("uo_client_label.of_label BEFORE of_get_healthmark_info ")

of_get_healthmark_info( sflightunit,shealth_header,shealth_detail,shealth_footer)

uoLabel.ishealthmark_header = shealth_header
uoLabel.ishealthmark_detail = shealth_detail
uoLabel.ishealthmark_footer = shealth_footer
// -------------------------------------------------------------------------
// wir generieren das Label
// -------------------------------------------------------------------------
if iManualInput = 0 then
	sFlight.sAirline						= dsCenOut.GetItemString(1, "cairline")
	sFlight.sFlightNumber				= Trim(String(dsCenOut.GetItemNumber(1, "nflight_number"), "000") + " " + trim(dsCenOut.GetItemString(1, "csuffix")))
else
	sFlight.sAirline						= sManualAirline
	sFlight.sFlightNumber				= sManualFlightNumber
end if

sFlight.dtDepartureDate				= dsCenOut.GetItemDateTime(1, "ddeparture")
sFlight.cDepartureTime				= dsCenOut.GetItemString(1, "cdeparture_time")
sFlight.sDestination					= dsCenOut.GetItemString(1, "ctlc_to")

sFlight.sOwner							= dsCenOut.GetItemString(1, "cairline_owner")
sFlight.sActype						= dsCenOut.GetItemString(1, "cactype")
sFlight.sConfiguration				= dsCenOut.GetItemString(1, "cconfiguration")

// bestbefore bestimmen: f$$HEX1$$fc00$$ENDHEX$$r k$$HEX1$$fc00$$ENDHEX$$chenzeit tag erg$$HEX1$$e400$$ENDHEX$$nzen
ldt_help = datetime(date(sFlight.dtDepartureDate), time(this.of_checknull(uoLabel.sKitchenTime)))
// abflug-termin kleiner als gleicher tag + k$$HEX1$$fc00$$ENDHEX$$chenzeit: tag um 1 reduzieren

f_trace("uo_client_label.of_label BEFORE of_rel_datetime_minutes ")

if datetime(date(sFlight.dtDepartureDate), time(sFlight.cDepartureTime)) < ldt_help then ldt_help = datetime(relativedate(date(sFlight.dtDepartureDate),-1), time(uoLabel.sKitchenTime))
sFlight.dtBestBeforeTime = luo_DateFunctions.of_rel_datetime_minutes(ldt_help, ll_BestBeforeMinutes)

// 16.08.2010 - Neues Labelfeld Departure
sFlight.sDeparture					= dsCenOut.GetItemString(1, "ctlc_from")

f_trace("uo_client_label.of_label BEFORE uoLabel.of_label")


iRet = uoLabel.of_label(this.dsLoading, this.iPrinterType, this.iLabelSort, this.iLabelPageBreak, sFlight, strBMP[]) 

f_trace("uo_client_label.of_label AFTER uoLabel.of_label ")


Choose case iRet 
	case -1		
		this.sErrorMessage = "No data available"
		return -1
	case -2

		this.sErrorMessage = "No valid label found"
		return -1
	case -3
		this.sErrorMessage = "Unknown printer-type"
		return -1
	case is < -4
		this.sErrorMessage = "Internal error " + String(iRet)
		return -1
end choose

f_trace("uo_client_label.of_label AFTER uoLabel.of_label")


this.strLabelTypes 	= uoLabel.strLabelTypes
// Document Engine st$$HEX1$$fc00$$ENDHEX$$rzt bei GarbageCollect() ab
If getApplication().AppName = "cbase" Then GarbageCollect()
//GarbageCollect()

f_trace("uo_client_label.of_label END")


return 0

end function

public function integer of_create ();// -----------------------------------------------------------
// 
// Einstiegsfunktion
// 
// -----------------------------------------------------------
//  22.08.2012 GetStandardLoading usw. auch ausf$$HEX1$$fc00$$ENDHEX$$hren, wenn nur Ramp Box Sheet aktiv und bLabel = AUS
// -----------------------------------------------------------

Long lStart, lEnde, I
Integer		li_Succ

lStart = CPU()

f_trace("uo_client_label.of_create START")

// -----------------------------------------------------------
// Kein ResultKey = Fehler
// -----------------------------------------------------------
if isNull(this.lResultKey) or this.lResultKey = 0 then
	sErrorMessage = uf.translate("Flugdaten k$$HEX1$$f600$$ENDHEX$$nnen nicht ermittelt werden!")
	return -1
end if

// -----------------------------------------------------------
// Die Fluginformationen die zum ResultKey geh$$HEX1$$f600$$ENDHEX$$ren einlesen
// -----------------------------------------------------------
if dsCenOut.RowCount() <= 0 then

	dsCenOut.Retrieve(this.lResultKey)
	if dsCenOut.RowCount() <= 0 then
		sErrorMessage = uf.translate("Keine Flugdaten gefunden!")
		return -1
	elseif dsCenOut.RowCount() > 1 then
		sErrorMessage = uf.translate("Flugdaten konnten nicht ermittelt werden!")
		return -1
	end if
	
end if

// -----------------------------------------------------------
// "Standardlabel"
// -----------------------------------------------------------
// 22.08.2012 auch ausf$$HEX1$$fc00$$ENDHEX$$hren, wenn nur Ramp Box Sheet aktiv
if (iPrintFlightLabel = 1 and this.blabel) OR bRampBoxSheet then
	
	// -----------------------------------------------------------
	// 19.08.2005
	// Die Beladung ermitteln, bei Abfertigungsart DLV
	// in cen_out_local_ssl (Der Scheich fliegt) nachschaun.
	// -----------------------------------------------------------
	if dsCenOut.GetItemString(1, "chandling_type_text") <> "DLV" then
	
		if this.of_get_standard_loading() <> 0 then
			sErrorMessage = uf.translate("Keine Standardbeladung gefunden!")
			return -1
		end if
	
	// -------------------------------------------------------------------------
	// Alle Datens$$HEX1$$e400$$ENDHEX$$tze mit unerw$$HEX1$$fc00$$ENDHEX$$nschtem Status l$$HEX1$$f600$$ENDHEX$$schen
	// -------------------------------------------------------------------------
	// this.of_reckoning()
	
	else
	
		if this.of_get_local_standard_loading() <= 0 then
			sErrorMessage = uf.translate("Keine individuelle Standardbeladung gefunden!")
			return -1
		end if
		
	end if
	
//	f_print_datastore(dsLoading)
//this.dsLoading.saveas("c:\temp\cbase\out1.xls", Excel5!, True)

f_trace("uo_client_label.of_create BEFORE .of_set_labeltype()")
	
	
	this.of_set_labeltype()
//this.dsLoading.saveas("c:\temp\cbase\out2.xls", Excel5!, True)
	
	// -----------------------------------------------------------
	// Die Lokalen Informationen zuspielen
	// -----------------------------------------------------------	
	this.of_add_workstations()
//this.dsLoading.saveas("c:\temp\cbase\out3.xls", Excel5!, True)
	
	// -----------------------------------------------------------
	// 21.08.2008
	// Eventuelle zus$$HEX1$$e400$$ENDHEX$$tzliche lokale Beladung ermitteln
	// -----------------------------------------------------------
	if bAddLoad and dsCenOut.GetItemString(1, "chandling_type_text") <> "REQ" then
		long ll_rc = -1
		ll_rc = this.of_get_local_additional_loading()
//		MessageBox("of_create: lokale Sonderbeladung geholt", string(ll_rc))
	end if
//this.dsLoading.saveas("c:\temp\cbase\out4.xls", Excel5!, True)
	
	// -----------------------------------------------------------
	// Die Komponentenverteilung
	// -----------------------------------------------------------
	if bDistribution then
		
		f_trace("uo_client_label.of_create BEFORE of_distribution()")

		
		if this.of_distribution() = -1000 then
			// -----------------------------------------------------
			// -1000 = User hat Mahlzeitenverteilung abgebrochen
			//         dann soll alles beendet werden (ZE-CR-1020)
			// -----------------------------------------------------
			If ii_Do_NOT_Trace = 0 Then
				f_trace("uo_client_label.of_create of_distribution() = -1000")
			end if
			return -1000
		end if
		
		if dsCenOut.RowCount() > 0 and uoDistribution.dsFlight.RowCount() > 0 then
			
			dsCenOut.SetItem(1, "cairline_owner", uoDistribution.dsFlight.GetItemString(1, "cairline_owner"))
			dsCenOut.SetItem(1, "cactype", uoDistribution.dsFlight.GetItemString(1, "cactype"))
			
		end if
		
	end if

//this.dsLoading.saveas("c:\temp\cbase\out5.xls", Excel5!, True)
		f_trace("uo_client_label.of_create BEFORE of_create_additional_label()")
	// -----------------------------------------------------------
	// Die Zustaulabel erstellen 
	// -----------------------------------------------------------	
	this.of_create_additional_label()
//this.dsLoading.saveas("c:\temp\cbase\out6.xls", Excel5!, True)
	
	// ---------------------------------------------------------------
	// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob Mahlzeiten in den Stauort verteilt wurden,
	// wenn ja, dann den Stauort immer drucken, auch wenn lokal
	// die St$$HEX1$$fc00$$ENDHEX$$ckliste auf "no print" gesetzt ist
	// ---------------------------------------------------------------
	For I = 1 to this.dsLoading.RowCount()
		if Len(Trim(this.of_checknull(this.dsLoading.GetItemString(I, "cdistributed_components")))) > 0 then
			this.dsLoading.SetItem(I,"nprint", 1)
		end if
	Next
		
end if

// -----------------------------------------------------------
// "Zeitungslabel"
// -----------------------------------------------------------
if iPrintNewspaperLabel = 1 then
			f_trace("uo_client_label.of_create BEFORE of_get_newspaper_loading()")

	if this.of_get_newspaper_loading() <> 0 then
		sErrorMessage = uf.translate("Keine Beladung gefunden!")
		return -1
	end if
	
end if
// -----------------------------------------------------------
// "Rampenboxpositionen zuordnen"
// -----------------------------------------------------------
if iRampBoxShow = 1 then
	if iRampBoxZieh = 1 then
		of_rampbox(TRUE)
	else
		of_rampbox(FALSE)
	end if
//	this.dsLoading.saveas("c:\temp\cbase\out6.xls", Excel5!, True)
end if


// -----------------------------------------------------------
// Die Lokalen Rampenbox Settings ermitteln
// -----------------------------------------------------------	
bFill_Ramp_box_mode = TRUE
If bFill_Ramp_box_mode Then
	li_Succ = of_add_ramp_box_mode()
End If

f_trace("uo_client_label.of_create BEFORE lEnde = CPU()")


lEnde = CPU()
of_log(String((lEnde - lStart) / 1000, "00.00") + " preparing uo_client_label")

// -----------------------------------------------------------
// Die Labels erstellen
// -----------------------------------------------------------
f_trace("uo_client_label.of_create BEFORE of_label")

if this.of_label() <> 0 then
	f_trace("uo_client_label.of_create AFTER of_label")

	return -1
end if

	f_trace("uo_client_label.of_create AFTER of_label")


dsExternalLoadinglists.Reset()

	f_trace("uo_client_label.of_create END")


return 0

end function

public function integer of_spml_label ();// -----------------------------------------------------
// 
// Labels bauen
// 
// -----------------------------------------------------
str_bitmaps 		strBMP[]
integer 				iRet, i, j
blob 					bXMLDok, bXMLFragment
Long					lIndex, lQuantity

String				sPrintBefore, sPrintAfter, sBoxFrom, sBoxTo, sRampBox
s_Flight 			sFlight

DataStore			dsTemp

uoLabel = create uo_label_other
	
uoLabel.sLocalPrinters			= this.sLocalPrinters
uoLabel.sLocalBellyPrinters	= this.sLocalBellyPrinters
uoLabel.lLocalLabelTypes		= this.lLocalLabelTypes
uoLabel.strLabelTypes			= this.strLabelTypes
uoLabel.sPrintWeekDay			= this.sWeekdays[DayNumber(Today())]
uoLabel.sSPMLLabelType			= this.sSPMLLabelType
uoLabel.lResultKey				= this.lResultKey
sFlight.dtDepartureDate			= DateTime(this.dDeparture)

this.dsCenOut.Retrieve(this.lResultKey)

dsTemp		= Create Datastore
dsTemp.dataobject = this.dsSPMLDetails.dataobject
dsTemp.SetTransobject(sqlca)
dsTemp.Retrieve(this.lResultKeys)

For i = 1 to dsTemp.RowCount()
	
	lQuantity = dsTemp.GetItemnumber(i, "nquantity")
		
	for j = 1 to lQuantity
		
		dsTemp.RowsCopy(i, i, Primary!, this.dsSPMLDetails, this.dsSPMLDetails.RowCount() + 1, Primary!)
		
	next
	
Next

Destroy(dsTemp)
this.of_add_workstations_to_spml()

iRet = uoLabel.of_label_spml(this.dsSPMLDetails, this.iPrinterType, strBMP[]) 

Choose case iRet 
	case -1		
		this.sErrorMessage = "No SPML data available"
		return -1
	case -2
		this.sErrorMessage = "No valid SPML label found"
		return -1
	case -3
		this.sErrorMessage = "Unknown printer-type"
		return -1
	case is < -4
		this.sErrorMessage = "Internal error " + String(iRet)
		return -1
end choose

this.strLabelTypes = uoLabel.strLabelTypes

return 0

end function

public function integer of_add_workstations_to_spml ();// -----------------------------------------------------
// 
// Zuspielen der lokalen Bereichszuordnung
// 
// -----------------------------------------------------
Datastore	ds_temp
Long 			i, j, k, l, &
				lPL_Keys[], &
				lQuantity

Long 			lKey, lLabelTypeKey , lPrint, lType, lLabelQuantity
String		sText, sArea, sWorkStation, sAddOnText, sWorkstationText, sDistribitionText, sPL
	
datetime		dtDeparture

ds_temp = Create Datastore
ds_temp.DataObject = "dw_label_spml_detail"

dsWorkstations.SetTransObject(sqlca)
dsWorkstations.SetFilter("")
dsWorkstations.Filter()
// ---------------------------------------------
// Erstellen Number Array
// und wenn wir schon mal am
// duchlaufen sind dann packen wir
// auch gleich die Mengen zu den Texten
// ---------------------------------------------
For i = 1 to this.dsSPMLDetails.RowCount()
	
	lPL_Keys[i] = this.dsSPMLDetails.GetItemNumber(i,"npackinglist_index_key")
	this.dsSPMLDetails.SetItem(i,"carea", "")  
	this.dsSPMLDetails.SetItem(i,"cworkstation", "")  
	
Next 

dtDeparture = dsCenOut.GetItemDateTime(1, "ddeparture")
dsWorkstations.Retrieve(isMandant, this.sUnit , lPL_Keys, dtDeparture)

if dsWorkstations.RowCount() > 0 then
	// ---------------------------------------------
	// Lokal
	// ---------------------------------------------
	For j = 1 to this.dsSPMLDetails.RowCount()
		this.dsSPMLDetails.RowsCopy(j,j,Primary!,ds_temp,ds_temp.RowCount() + 1,Primary!)
		ds_temp.SetItem(ds_temp.RowCount(),"carea","")  // Bereichsbezeichnung blank setzen
		// --------------------------------------------
		// Die PL aus der Beladung in der lokalen
		// Bereichszuordnung rausfiltern
		// --------------------------------------------
		lKey = this.dsSPMLDetails.GetItemNumber(j,"npackinglist_index_key")
		dsWorkstations.SetFilter("npackinglist_index_key = " + string(lKey))
		dsWorkstations.Filter()
		
		sPL = this.dsSPMLDetails.GetItemString(j, "cpackinglist")
		
		if  dsWorkstations.RowCount() > 0 then

			k = 1
			
			sArea 				= dsWorkstations.GetItemString(k,"carea")
			sWorkStation 		= dsWorkstations.GetItemString(k,"cworkstation")
			sWorkStationText  = dsWorkstations.GetItemString(k,"loc_unit_workstation_ctext")
			lLabelTypeKey 		= dsWorkstations.GetItemNumber(k,"nlabel_type_key")
			lLabelQuantity    = 1
			sAddOnText			= dsWorkstations.GetItemString(k,"loc_unit_pl_flight_label_ctext")
			sText					= dsWorkstations.GetItemString(k,"loc_unit_pl_flight_label_ctext2")
			lType					= 0  // 0=Masterlabel, 1=Dupliziertes Label
			lPrint 				= dsWorkstations.GetItemNumber(k,"nlabel_print")  
			
			// --------------------------------------------------------------
			// Bereiche setzen
			// --------------------------------------------------------------
			ds_temp.SetItem(ds_temp.RowCount(),"carea", sArea)  
			ds_temp.SetItem(ds_temp.RowCount(),"cworkstation", sWorkStation)  
			ds_temp.SetItem(ds_temp.RowCount(),"nprint", lPrint)  
			
			// --------------------------------------------------------------
			// AddOn Texte tauschen
			// --------------------------------------------------------------
			if len(trim(sAddOnText)) > 0 or not isnull(sAddOnText) then
				ds_temp.SetItem(ds_temp.RowCount() ,"clocal_text1",sAddOnText)
			end if
			if len(trim(sText)) > 0 or not isnull(sText) then
				ds_temp.SetItem(ds_temp.RowCount() ,"clocal_text2",sText)
			end if
			
		End if
		
	Next
	// --------------------------------------------------------------
	// Tempor$$HEX1$$e400$$ENDHEX$$rer Datastore zur$$HEX1$$fc00$$ENDHEX$$ckkopieren
	// --------------------------------------------------------------
	this.dsSPMLDetails.Reset()
	ds_temp.RowsCopy(1,ds_temp.RowCount(),Primary!,this.dsSPMLDetails,1,Primary!)

end if

return 0
end function

public function integer of_dump_pps (datastore ods);//----------------------------------------------------
// 
// LogFile schreiben
//
//----------------------------------------------------

integer 	iFile
Long		i
String	sOut
String	sDebug

iFile = FileOpen(f_gettemppath() + "cbase_pps.log", LineMode!, Write!, LockReadWrite! , append!)

//f_print_datastore(ods)

for i = 1 to ods.RowCount()
	
	if ods.GetItemNumber(I, "nprint") = 0 then
		
		continue
		
	end if
	
	
	sDebug = ods.GetItemString(i, "cen_galley_cgalley") + "-" + &
				ods.GetItemString(i, "cen_stowage_cstowage") + " " + &
				ods.GetItemString(i, "cen_stowage_cplace") + " [" + &
				ods.GetItemString(i, "cen_packinglists_cunit") + "] " + &  
				ods.GetItemString(i, "cen_packinglist_index_cpackinglist") + ";" 
	
	sOut = String(this.lResultKey) + ";" + &
			 String(ods.GetItemNumber(i, "cen_galley_ngalley_key")) + ";" + &
			 String(ods.GetItemNumber(i, "cen_stowage_nstowage_key")) + ";" + &
			 String(ods.GetItemNumber(i, "cen_packinglist_index_npackinglist_index_key")) + ";" + &
			 String(ods.GetItemNumber(i, "cen_loadinglists_nbelly_container")) 

	FileWrite(iFile, sOut)
			 
next

FileClose(iFile)

return 0

end function

public function integer of_check_sheet_prepare_text ();String	sTemp, sToken, sText
Integer	iCounter

Long 		i, j

sTemp = ""
iCounter = 0
String	ls_Part
			
for i = 1 to this.dsCheckSheet.RowCount()
	
	sText = this.of_checknull(this.dsCheckSheet.GetItemString(i, "cdistributed"))
	
	if right(sText, 1) <> "~n" then sText = sText + "~n"
	
	if len(sText) = 0 then continue
	
	iCounter 	= 0
	sTemp 		= ""
	
	for j = 1 to len(sText)
	
		sToken = Mid(sText, j, 1)
					
		if sToken = "~t" then
			sTemp += " " 
		else
			sTemp += sToken 
		end if
		
		ls_Part += sToken
		
		if sToken = "~n" then 
			iCounter ++
			// 11.04.2013 "Umbruch" bei 45 Digits
			if len(ls_Part) > 45 then
				iCounter ++			
			end if
			ls_Part = ""
			
		end if
		
	next
	
	this.dsCheckSheet.SetItem(i, "cdistributed", sTemp)
	this.dsCheckSheet.SetItem(i, "nitems",  iCounter)
		
next
		
		

return 0


end function

public function integer of_check_sheet_reload ();// -----------------------------------------------------------
// 
// Checksheet neu f$$HEX1$$fc00$$ENDHEX$$llen, mit Zustaulabel
// 
// -----------------------------------------------------------
Long 		lStart, lEnde, I
Long		lStowages
Long		lContents
Long		lLabels, lBosta
Long		a, j, k, lCount, lPos
String	sFlight, sDeparture, sAircraft, sVersion, sHandling, sFetch, sClasses, sBosta, sPLType, sClass
String	sTLCFrom, sTLCTo, sReg
String	sHandling_Type
Integer	li_Succ
String	sComponents


if this.iAddLabelOption = 0 then return 0

// this.of_check_sheet_prepare_text()

if this.dsCheckSheet.RowCount() = 0 then return 0

a = 1

sFlight 		= 	this.dsCheckSheet.GetItemString(a, "sflight")
sDeparture 	= 	this.dsCheckSheet.GetItemString(a, "sdeparture")
sAircraft 	= 	this.dsCheckSheet.GetItemString(a, "saircraft")
sVersion 	= 	this.dsCheckSheet.GetItemString(a, "sversion")
sBosta 		= 	this.dsCheckSheet.GetItemString(a, "sbosta")
sHandling 	= 	this.dsCheckSheet.GetItemString(a, "sHandling")
	
sTLCFrom 	= 	this.dsCheckSheet.GetItemString(a, "stlc_from")
sTLCTo 		= 	this.dsCheckSheet.GetItemString(a, "stlc_to")
sReg 			= 	this.dsCheckSheet.GetItemString(a, "sreg")

sHandling_Type = 	this.dsCheckSheet.GetItemString(a, "chandling_type")

this.dsCheckSheet.Reset()
// this.dsLoading.saveas("c:\temp\cbase\out5.xls", Excel5!, True)
// Messagebox("", "Drin")

For I = 1 to this.dsLoading.RowCount()
	
	if this.dsLoading.GetItemNumber(I, "nprint") = 0 and &
		Len(Trim(this.of_checknull(this.dsLoading.GetItemString(I, "cdistributed_components")))) = 0 then
		
		continue
		
	end if

	a = this.dsCheckSheet.InsertRow(0)
	
	this.dsCheckSheet.SetItem(a, "sflight", sFlight)
	this.dsCheckSheet.SetItem(a, "sdeparture", sDeparture)
	this.dsCheckSheet.SetItem(a, "saircraft", sAircraft)
	this.dsCheckSheet.SetItem(a, "sversion", sVersion)
	this.dsCheckSheet.SetItem(a, "sbosta", sBosta)
	this.dsCheckSheet.SetItem(a, "sHandling", sHandling)
	
	this.dsCheckSheet.SetItem(a, "stlc_from", sTLCFrom)
	this.dsCheckSheet.SetItem(a, "stlc_to", sTLCTo)
	this.dsCheckSheet.SetItem(a, "sreg", sReg)
		
	this.dsCheckSheet.SetItem(a, "ngalley_pos", this.dsLoading.GetItemNumber(i, "ngalley_group"))
	this.dsCheckSheet.SetItem(a, "cpackinglist", this.dsLoading.GetItemString(i, "cen_packinglist_index_cpackinglist"))
	this.dsCheckSheet.SetItem(a, "cgalley", this.dsLoading.GetItemString(i, "cen_galley_cgalley") )
	this.dsCheckSheet.SetItem(a, "cstowage", this.dsLoading.GetItemString(i, "cen_stowage_cstowage"))
	this.dsCheckSheet.SetItem(a, "cplace", this.dsLoading.GetItemString(i, "cen_stowage_cplace"))
	this.dsCheckSheet.SetItem(a, "cunit", this.dsLoading.GetItemString(i, "cen_packinglists_cunit")) 
	this.dsCheckSheet.SetItem(a, "ctext", "[" + this.dsLoading.GetItemString(i, "cen_packinglist_index_cpackinglist") + "] - " + this.dsLoading.GetItemString(i, "cen_packinglists_ctext")) 
	this.dsCheckSheet.SetItem(a, "sworkstation", this.dsLoading.GetItemString(i, "carea") + " - " + this.dsLoading.GetItemString(i, "cworkstation_text"))  
	this.dsCheckSheet.SetItem(a, "carea", f_check_null(this.dsLoading.GetItemString(i, "carea")) )
	this.dsCheckSheet.SetItem(a, "cworkstation", f_check_null(this.dsLoading.GetItemString(i, "cworkstation")))
	this.dsCheckSheet.SetItem(a, "ngalley_sort", this.dsLoading.GetItemNumber(i, "cen_galley_nsort")) 
	this.dsCheckSheet.SetItem(a, "nstowage_sort", this.dsLoading.GetItemNumber(i, "cen_stowage_nsort")) 
	this.dsCheckSheet.SetItem(a, "nbelly", this.dsLoading.GetItemNumber(i, "cen_loadinglists_nbelly_container")) 
	this.dsCheckSheet.SetItem(a, "nmodified", this.dsLoading.GetItemNumber(i, "nmodified")) 
	this.dsCheckSheet.SetItem(a, "cdistributed", this.dsLoading.GetItemString(i, "cdistributed_components")) 
	this.dsCheckSheet.SetItem(a, "nduplicated", this.dsLoading.GetItemNumber(i, "nlabel_type")) 
	// 12.03.2013 Handling Type added (CBASE-DE-CR-2013-002)
	li_Succ = this.dsCheckSheet.SetItem(a, "chandling_type", sHandling_Type)
	
	// ------------------------------------------------------------------------------
	// 04.03.2013 MealCode Stelle 1-2 entfernen
	// ------------------------------------------------------------------------------	
	sComponents = Trim(this.of_checknull(this.dsLoading.GetItemString(i, "cdistributed_components")))
	sComponents = of_remove_mealcode( sComponents)
	this.dsCheckSheet.SetItem(a, "cdistributed", sComponents)
	


Next

this.of_check_sheet_prepare_text()

this.dsCheckSheet.Sort()
this.dsCheckSheet.GroupCalc()

// f_print_datastore(dschecksheet)


return 0
end function

public function integer of_get_local_additional_loading ();
/* 
* Funktion:			of_get_local_additional_loading
* Beschreibung: 	holen der eventuell vorhandenen lokalen Beladungen zum flug
*						(aus loc_unit_add_load & loc_unit_add_detail)
* Besonderheit: 	
*
* Argumente: 
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		26.11.2008		setzen zeit erg$$HEX1$$e400$$ENDHEX$$nzt 
* 							(wird sonst in of_set_labetype gemacht, geht aber f$$HEX1$$fc00$$ENDHEX$$r add_loading nicht, weil dort auch area/workstation gesetzt werden)
*														setzen class1, class2, class3 erg$$HEX1$$e400$$ENDHEX$$nzt 
*
* Return Codes:
*	0		alles ok, nichts gefunden
*	> 0	alles ok, Anzahl insgesamt geladener S$$HEX1$$e400$$ENDHEX$$tze
*/


Long			lRow, lLoop, lFound
Long			lKey, lDetailKey
Datastore 	dsLocal

Long		lAirline, lFlightNumber, lRoutingId, lHandlingTypeKey, lTlcFrom, lTlcTo, lAircraftKey, lLabelTypeKey
String		sSuffix, sDepartureTime, sKitchenTime, sRampTime, sFoodValue, sNonFoodValue, sClass

Datetime	dtDepartureDate
Integer	iTrafficDay

s_esl		strESL


// ---------------------------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$bergabeparameter holen
// ---------------------------------------------------------------------
lAirline			= dsCenOut.GetItemNumber(1, "nairline_key")
lFlightNumber	= dsCenOut.GetItemNumber(1, "nflight_number")
sSuffix			= dsCenOut.GetItemString(1, "csuffix")
lRoutingId		= dsCenOut.GetItemNumber(1, "nrouting_id")
lHandlingTypeKey	= dsCenOut.GetItemNumber(1, "nhandling_type_key")
lTlcFrom			= dsCenOut.GetItemNumber(1, "ntlc_from")
lTlcTo				= dsCenOut.GetItemNumber(1, "ntlc_to")
lAircraftKey		= dsCenOut.GetItemNumber(1, "naircraft_key")
dtDepartureDate	= Datetime(Date(dsCenOut.GetItemDateTime(1,"ddeparture")))

// -------------------------------------------------------
// Betriebliche Parameter f$$HEX1$$fc00$$ENDHEX$$r die Zeitanzeige auslesen
// -------------------------------------------------------
sFoodValue 		= f_unitprofilestring("Default","FoodTime","2", isUnit) 
sNonFoodValue 	= f_unitprofilestring("Default","NonFoodTime","2", isUnit) 

sDepartureTime	= dsCenOut.GetItemString(1,"cdeparture_time")
sKitchenTime	= dsCenOut.GetItemString(1, "ckitchen_time")
sRampTime		= dsCenOut.GetItemString(1, "cramp_time")

// ------------------------------------------
// Verkehrstag ermitteln
// ------------------------------------------	
iTrafficDay = DayNumber(Date(dtDepartureDate))
iTrafficDay --
if iTrafficDay = 0 then iTrafficDay = 7	

// ------------------------------------------
// Daten lesen (und Frequenz anschliessend filtern)
// ------------------------------------------	
dsLocal = create datastore
dsLocal.dataobject = "dw_local_add_load_select"
dsLocal.Settransobject(sqlca)
dsLocal.Retrieve(lAirline, isUnit, lFlightNumber, sSuffix, lRoutingId, lHandlingTypeKey, lTlcFrom, lTlcTo, lAircraftKey, dtDepartureDate, sDepartureTime)

//f_print_datastore(dsLocal)

dsLocal.SetFilter("nfreq" + string(iTrafficDay) + "=1")
dsLocal.Filter()

//f_print_datastore(dsLocal)

if dsLocal.RowCount() = 0 then return 0

// ------------------------------------------
// gelesene Daten eintragen
// ------------------------------------------	
For lLoop = 1 to dsLocal.RowCount()
	
	lLabelTypeKey = dsLocal.GetItemNumber(lLoop, "nlabel_type_key")
	sClass = dsLocal.GetItemString(lLoop, "cclass")
	
	lRow = this.dsLoading.InsertRow(0)
	
	this.dsLoading.SetItem(lRow, "cen_galley_cgalley", dsLocal.GetItemString(lLoop, "cgalley"))
	this.dsLoading.SetItem(lRow, "cen_stowage_cstowage", dsLocal.GetItemString(lLoop, "cstowage"))
	this.dsLoading.SetItem(lRow, "cen_stowage_cplace", dsLocal.GetItemString(lLoop, "cplace"))
//	this.dsLoading.SetItem(lRow, "cen_stowage_cplace", "")
	this.dsLoading.SetItem(lRow, "cen_loadinglists_cclass", sClass)
	// klasse aufsplitten, falls mehrere
	if len(sClass) > 0 then this.dsLoading.SetItem(lRow, "cclass1", mid(sClass,1,1))
	if len(sClass) > 1 then this.dsLoading.SetItem(lRow, "cclass2", mid(sClass,2,1))
	if len(sClass) > 2 then this.dsLoading.SetItem(lRow, "cclass3", mid(sClass,3,1))
	
	this.dsLoading.SetItem(lRow, "cen_packinglists_cunit", dsLocal.GetItemString(lLoop, "detail_cunit"))
	this.dsLoading.SetItem(lRow, "cen_packinglist_index_cpackinglist", dsLocal.GetItemString(lLoop, "cpackinglist"))
	this.dsLoading.SetItem(lRow, "cen_packinglists_ctext", dsLocal.GetItemString(lLoop, "ctext"))
	this.dsLoading.SetItem(lRow, "cen_loadinglists_cadd_on_text", dsLocal.GetItemString(lLoop, "cadd_on_text"))
	this.dsLoading.SetItem(lRow, "cen_packinglists_nlabel_type_key", lLabelTypeKey)
	this.dsLoading.SetItem(lRow, "nlabel_type", 0)  // nur mal so testweise!!
	
	this.dsLoading.SetItem(lRow, "cen_galley_nsort", lLoop)  // versuch... eigentlich maximum + faktor
	this.dsLoading.SetItem(lRow, "cen_galley_ngalley_key", lLoop)  // versuch...
	this.dsLoading.SetItem(lRow, "cen_stowage_nsort", lLoop)  // versuch...
	this.dsLoading.SetItem(lRow, "cen_stowage_nstowage_key", lLoop)  // versuch...
	
	this.dsLoading.SetItem(lRow,"cen_loadinglists_nbelly_container", 0)
	this.dsLoading.SetItem(lRow, "cen_loadinglist_index_cloadinglist", "")
	this.dsLoading.SetItem(lRow, "cen_loadinglists_cmeal_control_code", "")
	this.dsLoading.SetItem(lRow, "cen_loadinglists_nlabel_quantity", 1)
	this.dsLoading.SetItem(lRow, "nprint", 1)
	this.dsLoading.SetItem(lRow, "stationinstruction", 1)
	
	this.dsLoading.SetItem(lRow, "nworkstationkey", dsLocal.GetItemNumber(lLoop, "nworkstation_key"))
	this.dsLoading.SetItem(lRow, "nareakey", dsLocal.GetItemNumber(lLoop, "narea_key"))
	this.dsLoading.SetItem(lRow, "carea_code", dsLocal.GetItemString(lLoop, "carea") + "-" + dsLocal.GetItemString(lLoop, "cworkstation") ) 
	this.dsLoading.SetItem(lRow, "carea", dsLocal.GetItemString(lLoop, "carea"))
	this.dsLoading.SetItem(lRow, "cworkstation", dsLocal.GetItemString(lLoop, "cworkstation"))
	this.dsLoading.SetItem(lRow, "cworkstation_text", dsLocal.GetItemString(lLoop, "cworkstation_text"))
	
	this.dsLoading.SetItem(lRow, "ndistribution_detail_key", lLoop)
	
	lKey = f_check_packinglist(dsLocal.GetItemString(lLoop, "cpackinglist"))
	if lKey <> -1 then
		// st$$HEX1$$fc00$$ENDHEX$$ckliste existiert grunds$$HEX1$$e400$$ENDHEX$$tzlich: hole daten
//		strESL= f_get_packinglist_text_and_type(lKey, DateTime(this.dDeparture))
		lDetailKey = f_get_packinglist_detail_key(lKey, this.dDeparture)
		if lDetailKey > 0 then
			this.dsLoading.SetItem(lRow, "cen_packinglist_index_npackinglist_index_key", lKey)
			this.dsLoading.SetItem(lRow, "cen_packinglists_npackinglist_detail_key", lDetailKey)
		end if
	end if
	
	// --------------------------------------------------------------
	// zeit ermitteln und eintragen
	// das passiert f$$HEX1$$fc00$$ENDHEX$$r alle anderen in of_set_labeltype
	// --------------------------------------------------------------
	lFound = dsLabelType.Find("nlabel_type_key=" + string(lLabelTypeKey), 1, dsLabelType.RowCount())
	// --------------------------------------------------------------
	// Treffer, es ist ein Food Label
	// 
	// In dsLabelType stehen alle Labeltypen die das Feld 
	// 'cdistributed_components' haben. 
	// --------------------------------------------------------------
	if lFound > 0 then
		choose case sFoodValue
				case "0"
					this.dsLoading.SetItem(lRow, "cunit_time", sDepartureTime)
				case "1"
					this.dsLoading.SetItem(lRow, "cunit_time", sKitchenTime)
				case "2"
					this.dsLoading.SetItem(lRow, "cunit_time", sRampTime)
		end choose
	else
		choose case sNonFoodValue
				case "0"
					this.dsLoading.SetItem(lRow, "cunit_time", sDepartureTime)
				case "1"
					this.dsLoading.SetItem(lRow, "cunit_time", sKitchenTime)
				case "2"
					this.dsLoading.SetItem(lRow, "cunit_time", sRampTime)
		end choose
	end if

Next

//return this.dsLoading.RowCount()
return lLoop


end function

public function integer of_rampbox (boolean argbzieh);/* 
* Funktion:			of_rampbox
* Beschreibung: 	Rampenboxenzuordnung in dsLoading erstellen
*
* Besonderheit:   "Zieharmonikafunktion": Die Rampenboxenbelegung wird f$$HEX1$$fc00$$ENDHEX$$r jede Seite optimiert, damit keine L$$HEX1$$fc00$$ENDHEX$$cken entstehen
*
* Argumente:
*
*	boolean argbzieh		Ziehharmonika an/aus
*
* Aenderungshistorie:
* 	Version 		Wer					Wann				Was und warum
*	1.0 			M.Barfknecht		20.07.2010		Erstellung
*
* Return Codes:
*/

long lairline,laircraft,lfound,lstowage,lrampbox,lhelp,lbox_key,lrow,lposntw,lcarttype,lpos
integer ibox,i,j,k,a
boolean bused
string sLabelinfo,sside,sposition,sntw

//Datastores
datastore dsrampbox_l,dsrampbox_r,dsrampbox_pos,dshelp_r,dshelp_l,dsramp_r,dsramp_l

dsrampbox_pos= create datastore
dsrampbox_pos.dataobject = "dw_local_rambox_all"
dsrampbox_pos.settransobject(sqlca)

dsrampbox_l= create datastore
dsrampbox_l.dataobject = "dw_local_ac2box_l"
dsrampbox_l.settransobject(sqlca)

dsramp_l= create datastore
dsramp_l.dataobject = "dw_local_ac2box_l"
dsramp_l.settransobject(sqlca)

dsrampbox_r= create datastore
dsrampbox_r.dataobject = "dw_local_ac2box_r"
dsrampbox_r.settransobject(sqlca)

dsramp_r= create datastore
dsramp_r.dataobject = "dw_local_ac2box_r"
dsramp_r.settransobject(sqlca)

dshelp_r= create datastore
dshelp_r.dataobject = "dw_local_rambbox_help"
dshelp_r.settransobject(sqlca)

dshelp_l= create datastore
dshelp_l.dataobject = "dw_local_rambbox_help"
dshelp_l.settransobject(sqlca)

//MB 25.04.2013: nairline_key oder nairline_owner_key
if dsCenOut.getitemnumber(1,"nairline_key") <> dsCenOut.getitemnumber(1,"nairline_owner_key") then
	lairline = dsCenOut.getitemnumber(1,"nairline_owner_key")
else	
	lairline = dsCenOut.getitemnumber(1,"nairline_key")
end if
laircraft = dsCenOut.getitemnumber(1,"naircraft_key")



//Gibt es $$HEX1$$fc00$$ENDHEX$$berhaupt Rampenbox Definitionen f$$HEX1$$fc00$$ENDHEX$$r diesen Betrieb/Airline/Aircraft?


for iBox =1 to 10

dsrampbox_l.retrieve(sunit,lairline,laircraft,iBox)
dsrampbox_r.retrieve(sunit,lairline,laircraft,iBox)

//Nur f$$HEX1$$fc00$$ENDHEX$$r Boxen durchf$$HEX1$$fc00$$ENDHEX$$hren, die auch tats$$HEX1$$e400$$ENDHEX$$chlich benutzt werden
if dsrampbox_l.rowcount() >0 or dsrampbox_r.rowcount() >0 then
	
//ok es gibt zugeordnete. Jetzt jede Seite durchgehen und $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen, ob der Stowage_key in der Loadinglist ist.	
//links. Gibt es den zugeordneten Stauort auch in der Loadinglist?
	if dsrampbox_l.rowcount() >0 then
		
	
	
		for i=1 to dsrampbox_l.rowcount()
			
			if dsrampbox_l.getitemnumber(i,"loc_unit_ac2box_nstowage_key") > 0 then
				lstowage = dsrampbox_l.getitemnumber(i,"loc_unit_ac2box_nstowage_key")
				lfound = dsLoading.find("cen_stowage_nstowage_key =" +string(lstowage),1,dsLoading.rowcount())
				if lfound = 0 then
					//Stauort nicht vorhanden und kein Gitterwagen da, also nstowage_key auf 0 setzen
				//	if dsrampbox_l.getitemnumber(i,"loc_unit_ac2box_ncarttypes_key") = 0 then
						
						dsrampbox_l.setitem(i,"loc_unit_ac2box_nstowage_key",0)
				
				//	end if
				end if
			
			end if
		
		next
	end if

	//rechts
		if dsrampbox_r.rowcount() >0 then
			
			
			for i=1 to dsrampbox_r.rowcount()
			
				if dsrampbox_r.getitemnumber(i,"loc_unit_ac2box_nstowage_key") > 0 then
					lstowage = dsrampbox_r.getitemnumber(i,"loc_unit_ac2box_nstowage_key")
					lfound = dsLoading.find("cen_stowage_nstowage_key =" +string(lstowage),1,dsLoading.rowcount())
					if lfound = 0 then
					//Stauort nicht vorhanden und kein Gitterwagen da, also nstowage_key auf 0 setzen
				//	if dsrampbox_r.getitemnumber(i,"loc_unit_ac2box_ncarttypes_key") = 0 then
						
						dsrampbox_r.setitem(i,"loc_unit_ac2box_nstowage_key",0)
				
				//	end if
					end if
				
			end if
			next
		end if
//Ergebnisse zum Testen speichern
//dsrampbox_r.saveas("c:\temp\cbase\rechts_nach_loeschen"+string(iBox) +".xls", Excel5!, True)	
//dsrampbox_l.saveas("c:\temp\cbase\links_nach_loeschen"+string(iBox) +".xls", Excel5!, True)	

//--------------------------------------------------------------------------------------
//"Ziehharmonika": L$$HEX1$$fc00$$ENDHEX$$cken in den  Datastores schliessen (Von oben nach unten)
//--------------------------------------------------------------------------------------

if argbzieh = true then	

//L$$HEX1$$fc00$$ENDHEX$$cken suchen und in den Help Datastore eintragen
	
//links:

	lhelp = dsrampbox_l.getitemnumber(1,"loc_unit_ac2box_nrampbox_key")
	bused = false
	for i=1 to dsrampbox_l.rowcount()
		lrampbox = dsrampbox_l.getitemnumber(i,"loc_unit_ac2box_nrampbox_key")
		
		
			if lrampbox <> lhelp or i = dsrampbox_l.rowcount() then
				if bused = false then
				lfound= dshelp_l.find("nrampbox_key =" +string(lhelp),1,dshelp_l.rowcount())
					if lfound = 0 then
						a = dshelp_l.insertrow(0)
						dshelp_l.setitem(a,"nrampbox_key",lhelp)
						dshelp_l.setitem(a,"cposition",dsrampbox_l.getitemstring(i -1,"loc_unit_rampbox_cposition"))
						dshelp_l.setitem(a,"cntw",dsrampbox_l.getitemstring(i -1,"loc_unit_ac2box_coption"))
						dshelp_l.setitem(a,"ncarttype",dsrampbox_l.getitemnumber(i -1,"loc_unit_ac2box_ncarttypes_key"))
						
					end if
				else
					lfound= dshelp_l.find("nrampbox_key =" +string(lhelp),1,dshelp_l.rowcount())
					if lfound = 0 then
						a = dshelp_l.insertrow(0)
						dshelp_l.setitem(a,"nrampbox_key",lhelp)
						dshelp_l.setitem(a,"cposition","0")
						dshelp_l.setitem(a,"cntw",dsrampbox_l.getitemstring(i -1,"loc_unit_ac2box_coption"))
						dshelp_l.setitem(a,"ncarttype",dsrampbox_l.getitemnumber(i -1,"loc_unit_ac2box_ncarttypes_key"))
					end if
					bused = false
				end if
			end if
			if dsrampbox_l.getitemnumber(i,"loc_unit_ac2box_nstowage_key") > 0 then
			bused = true
			end if
			lhelp = lrampbox
	
	next 
	
//rechts:
	lhelp = dsrampbox_r.getitemnumber(1,"loc_unit_ac2box_nrampbox_key")
	bused = false
	for i=1 to dsrampbox_r.rowcount()
		lrampbox = dsrampbox_r.getitemnumber(i,"loc_unit_ac2box_nrampbox_key")
		
		
			if lrampbox <> lhelp or i = dsrampbox_r.rowcount() then
				if bused = false then
				lfound= dshelp_r.find("nrampbox_key =" +string(lhelp),1,dshelp_l.rowcount())
					if lfound = 0 then
						
						a = dshelp_r.insertrow(0)
						dshelp_r.setitem(a,"nrampbox_key",lhelp)
						dshelp_r.setitem(a,"cposition",dsrampbox_r.getitemstring(i -1,"loc_unit_rampbox_cposition"))
						dshelp_r.setitem(a,"cntw",dsrampbox_r.getitemstring(i -1,"loc_unit_ac2box_coption"))	
						dshelp_r.setitem(a,"ncarttype",dsrampbox_r.getitemnumber(i -1,"loc_unit_ac2box_ncarttypes_key"))
						
					end if
				else
					lfound= dshelp_r.find("nrampbox_key =" +string(lhelp),1,dshelp_l.rowcount())
					if lfound = 0 then
						a = dshelp_r.insertrow(0)
						dshelp_r.setitem(a,"nrampbox_key",lhelp)
						dshelp_r.setitem(a,"cposition","0")
						dshelp_r.setitem(a,"cntw",dsrampbox_r.getitemstring(i -1,"loc_unit_ac2box_coption"))
						dshelp_r.setitem(a,"ncarttype",dsrampbox_r.getitemnumber(i -1,"loc_unit_ac2box_ncarttypes_key"))
					end if
					bused = false
				end if
			end if
			if dsrampbox_r.getitemnumber(i,"loc_unit_ac2box_nstowage_key") > 0 then
			bused = true
			end if
			lhelp = lrampbox
	
	next 
//dshelp_r.saveas("c:\temp\cbase\rechts_anfang"+string(iBox)+".xls", Excel5!, True)	
//----------------------------------------------------------------------------------
//jetzt Ziehharmonika durchf$$HEX1$$fc00$$ENDHEX$$hren:
//1. L$$HEX1$$fc00$$ENDHEX$$cke suchen
//2. Die n$$HEX1$$e400$$ENDHEX$$chste besetzte Position ermitteln
//3. L$$HEX1$$fc00$$ENDHEX$$cke mit gefunder Position besetzen
//4. Die verschobene Position als leer markieren
//----------------------------------------------------------------------------------
//links:
		for i = 1 to dshelp_l.rowcount()
			
			
			
			if dshelp_l.getitemstring(i,"cposition") <> "0" then
			//L$$HEX1$$fc00$$ENDHEX$$cke vorhanden. Suche n$$HEX1$$e400$$ENDHEX$$chste besetzte Position und tausche aus
			if dshelp_l.getitemnumber(i,"ncarttype") > 0 then
				//L$$HEX1$$fc00$$ENDHEX$$cke ist im Gitterwagen, also raus
				continue
			end if
			
			lfound = dshelp_l.find("cposition = '0'",i,dshelp_l.rowcount())
			
			if lfound > 0 then
			
			if dshelp_l.getitemnumber(lfound,"ncarttype") > 0 then
			//OK, zu verschiebende Position ist ein Gitterwagen, also erstmal Gr$$HEX2$$f600df00$$ENDHEX$$e holen
				lcarttype = dshelp_l.getitemnumber(lfound,"ncarttype")
				
				Select nblockposition into :lposntw
				from sys_units_carttypes
				where ncarttypes_key = :lcarttype;
			
			end if
			
			//Position "verschieben", um L$$HEX1$$fc00$$ENDHEX$$cke zu schliessen
			dsrampbox_pos.retrieve(sunit,lairline,laircraft,dshelp_l.getitemnumber(lfound,"nrampbox_key"),iBox)
				for k=1 to dsrampbox_pos.rowcount()
						lbox_key = dsrampbox_pos.getitemnumber(k,"nac2box_key")
						lrow = dsrampbox_l.find("loc_unit_ac2box_nac2box_key = "+string(lbox_key),1,dsrampbox_l.rowcount())
						dsrampbox_l.setitem(lrow,"loc_unit_ac2box_nrampbox_key",dshelp_l.getitemnumber(i,"nrampbox_key"))
						lrampbox = dshelp_l.getitemnumber(i,"nrampbox_key")
						Select cposition into :sposition
						from loc_unit_rampbox
						where nrampbox_key =:lrampbox;
						dsrampbox_l.setitem(lrow,"loc_unit_rampbox_cposition",sposition)
				next
			dshelp_l.setitem(lfound,"cposition","-1")
			dshelp_l.setitem(lfound,"ncarttype",0)
			
			//Wenn es ein Gitterwagen mit mehr als einer Position ist, m$$HEX1$$fc00$$ENDHEX$$ssen die weiteren Positionen mit verschoben werden
			if lposntw > 1 then
			for j=1 to lposntw - 1
				lpos = lfound + j 
				dsrampbox_pos.retrieve(sunit,lairline,laircraft,dshelp_l.getitemnumber(lpos,"nrampbox_key"),iBox)
				for k=1 to dsrampbox_pos.rowcount()
						lbox_key = dsrampbox_pos.getitemnumber(k,"nac2box_key")
						lrow = dsrampbox_l.find("loc_unit_ac2box_nac2box_key = "+string(lbox_key),1,dsrampbox_l.rowcount())
						dsrampbox_l.setitem(lrow,"loc_unit_ac2box_nrampbox_key",dshelp_l.getitemnumber(i + j,"nrampbox_key"))
						lrampbox = dshelp_l.getitemnumber(i + j,"nrampbox_key")
						Select cposition into :sposition
						from loc_unit_rampbox
						where nrampbox_key =:lrampbox;
						dsrampbox_l.setitem(lrow,"loc_unit_rampbox_cposition",sposition)
				next
				dshelp_l.setitem(lpos,"cposition","-1")
				dshelp_l.setitem(lpos,"ncarttype",0)
			next
			i = i +lposntw - 1
			lposntw = 0
			end if
			
			end if
		
			
			end if	
		next
//rechts:

	for i = 1 to dshelp_r.rowcount()
			
			if dshelp_r.getitemstring(i,"cposition") <> "0" then
			//L$$HEX1$$fc00$$ENDHEX$$cke vorhanden. Suche n$$HEX1$$e400$$ENDHEX$$chste besetzte Position und tausche aus
			if dshelp_r.getitemnumber(i,"ncarttype") > 0 then
				//L$$HEX1$$fc00$$ENDHEX$$cke ist im Gitterwagen, also raus
				continue
			end if
			lfound = dshelp_r.find("cposition = '0'",i,dshelp_r.rowcount())
			if lfound > 0 then
				
			if dshelp_r.getitemnumber(lfound,"ncarttype") > 0 then
			//OK, zu verschiebende Position ist ein Gitterwagen, also erstmal Gr$$HEX2$$f600df00$$ENDHEX$$e holen
				lcarttype = dshelp_r.getitemnumber(lfound,"ncarttype")
				
				Select nblockposition into :lposntw
				from sys_units_carttypes
				where ncarttypes_key = :lcarttype;
			
			end if	
				
			dsrampbox_pos.retrieve(sunit,lairline,laircraft,dshelp_r.getitemnumber(lfound,"nrampbox_key"),iBox)
				for k=1 to dsrampbox_pos.rowcount()
						lbox_key = dsrampbox_pos.getitemnumber(k,"nac2box_key")
						lrow = dsrampbox_r.find("loc_unit_ac2box_nac2box_key = "+string(lbox_key),1,dsrampbox_r.rowcount())
						dsrampbox_r.setitem(lrow,"loc_unit_ac2box_nrampbox_key",dshelp_r.getitemnumber(i,"nrampbox_key"))
						lrampbox = dshelp_r.getitemnumber(i,"nrampbox_key")
						Select cposition into :sposition
						from loc_unit_rampbox
						where nrampbox_key =:lrampbox;
						dsrampbox_r.setitem(lrow,"loc_unit_rampbox_cposition",sposition)
				next
			dshelp_r.setitem(lfound,"cposition","-1")
			dshelp_r.setitem(lfound,"ncarttype",0)
			//Wenn es ein Gitterwagen mit mehr als einer Position ist, m$$HEX1$$fc00$$ENDHEX$$ssen alle Positionen mit verschoben werden
			if lposntw > 1 then
			for j=1 to lposntw - 1
				lpos = lfound + j
				dsrampbox_pos.retrieve(sunit,lairline,laircraft,dshelp_r.getitemnumber(lpos,"nrampbox_key"),iBox)
				for k=1 to dsrampbox_pos.rowcount()
						lbox_key = dsrampbox_pos.getitemnumber(k,"nac2box_key")
						lrow = dsrampbox_r.find("loc_unit_ac2box_nac2box_key = "+string(lbox_key),1,dsrampbox_r.rowcount())
						dsrampbox_r.setitem(lrow,"loc_unit_ac2box_nrampbox_key",dshelp_r.getitemnumber(i + j,"nrampbox_key"))
						lrampbox = dshelp_r.getitemnumber(i + j,"nrampbox_key")
						Select cposition into :sposition
						from loc_unit_rampbox
						where nrampbox_key =:lrampbox;
						dsrampbox_r.setitem(lrow,"loc_unit_rampbox_cposition",sposition)
				next
				dshelp_r.setitem(lpos,"cposition","-1")
				dshelp_r.setitem(lpos,"ncarttype",0)
			next
			i = i +lposntw - 1
			lposntw = 0
			end if
			end if
			
			end if	
		next
//dshelp_r.saveas("c:\temp\cbase\rechts"+string(iBox)+".xls", Excel5!, True)	
//dshelp_l.saveas("c:\temp\cbase\links"+string(iBox)+".xls", Excel5!, True)
end if	


for i=1 to dsrampbox_r.rowcount()
if dsrampbox_r.getitemnumber(i,"loc_unit_ac2box_nstowage_key") > 0 /*or dsrampbox_r.getitemnumber(i,"loc_unit_ac2box_ncarttypes_key") > 0*/ then
	dsrampbox_r.rowscopy(i,i,PRIMARY!,dsramp_r,dsramp_r.rowcount() + 1,PRIMARY!)
else
	if dsrampbox_r.getitemnumber(i,"loc_unit_ac2box_ncarttypes_key") > 0 then
	//$$HEX1$$dc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fe, ob es noch ein weiteres Element gibt
	lrampbox =dsrampbox_r.getitemnumber(i,"loc_unit_ac2box_nrampbox_key")
	lfound = dsrampbox_r.find("loc_unit_ac2box_nrampbox_key =" + string(lrampbox),i + 1,dsrampbox_r.rowcount())
	if lfound = 0 then
	dsrampbox_r.rowscopy(i,i,PRIMARY!,dsramp_r,dsramp_r.rowcount() + 1,PRIMARY!)
	end if
	end if
end if
next
for i=1 to dsrampbox_l.rowcount()
if dsrampbox_l.getitemnumber(i,"loc_unit_ac2box_nstowage_key") > 0 /*or dsrampbox_l.getitemnumber(i,"loc_unit_ac2box_ncarttypes_key") > 0 */then
	dsrampbox_l.rowscopy(i,i,PRIMARY!,dsramp_l,dsramp_l.rowcount() + 1,PRIMARY!)
else
	if dsrampbox_l.getitemnumber(i,"loc_unit_ac2box_ncarttypes_key") > 0 then
	//$$HEX1$$dc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fe, ob es noch ein weiteres Element gibt
	lrampbox =dsrampbox_l.getitemnumber(i,"loc_unit_ac2box_nrampbox_key")
	lfound = dsrampbox_l.find("loc_unit_ac2box_nrampbox_key =" + string(lrampbox),i + 1,dsrampbox_l.rowcount())
	if lfound = 0 then
	dsrampbox_l.rowscopy(i,i,PRIMARY!,dsramp_l,dsramp_l.rowcount() + 1,PRIMARY!)
	end if
	end if
end if
next

dsramp_r.sort()
dsramp_l.sort()
//dsramp_r.saveas("c:\temp\cbase\rechts_komplett"+string(iBox) +".xls", Excel5!, True)	
//dsramp_l.saveas("c:\temp\cbase\links_komplett"+string(iBox) +".xls", Excel5!, True)	
//Datastores sind angepasst, jetzt Labelinformation in dsloading erg$$HEX1$$e400$$ENDHEX$$nzen:

for i = 1 to dsloading.rowcount()
	lstowage = dsloading.getitemnumber(i,"cen_stowage_nstowage_key")
	lfound = dsramp_r.find("loc_unit_ac2box_nstowage_key =" +string(lstowage),1,dsramp_r.rowcount())
	sside = "R"
	if lfound = 0 then
		//Wenn es nicht rechts ist, dann eben links
		lfound = dsramp_l.find("loc_unit_ac2box_nstowage_key =" +string(lstowage),1,dsramp_l.rowcount())
		sside ="L"
	end if
	
	if lfound > 0 then
		if sside = "R" then
		slabelinfo = string(dsramp_r.getitemnumber(lfound,"loc_unit_ac2box_nbox"))
		slabelinfo = slabelinfo +"-" + Trim(dsramp_r.getitemstring(lfound,"loc_unit_rampbox_cposition"))
		if dsramp_r.getitemstring(lfound,"loc_unit_ac2box_coption") > "" then
		//NTW Kurzbezeichnung aus Datenbank holen
		lcarttype = dsramp_r.getitemnumber(lfound,"loc_unit_ac2box_ncarttypes_key")
		select cshort into :sntw
		from sys_units_carttypes
		where ncarttypes_key = :lcarttype;
		slabelinfo = slabelinfo +"-" +sntw
		end if
		if dsramp_r.getitemnumber(lfound,"loc_unit_ac2box_nontop") > 0 then
		slabelinfo = slabelinfo +"-T" 
		end if
		
		else
		slabelinfo = string(dsramp_l.getitemnumber(lfound,"loc_unit_ac2box_nbox"))
		slabelinfo = slabelinfo +"-" + Trim(dsramp_l.getitemstring(lfound,"loc_unit_rampbox_cposition"))
		if dsramp_l.getitemstring(lfound,"loc_unit_ac2box_coption") > "" then
		//NTW Kurzbezeichnung aus Datenbank holen
		lcarttype = dsramp_l.getitemnumber(lfound,"loc_unit_ac2box_ncarttypes_key")
		select cshort into :sntw
		from sys_units_carttypes
		where ncarttypes_key = :lcarttype;	
		slabelinfo = slabelinfo +"-" +sntw
		end if
		if dsramp_l.getitemnumber(lfound,"loc_unit_ac2box_nontop") > 0 then
		slabelinfo = slabelinfo +"-T"
		end if
		end if
	end if
	if slabelinfo <> "" then
	dsLoading.setitem(i,"crampbox",slabelinfo)
	end if
	slabelinfo =""
next	
dsramp_r.getfullstate(bBox_R[iBox] )
dsramp_l.getfullstate(bBox_L[iBox])

dsramp_r.reset()
dsramp_l.reset()
end if

dshelp_r.reset()
dshelp_l.reset()

next

return 0
end function

public function integer of_create_acrobat (ref datastore dsacrobat, string as_file_name);/*************************************************************
* Objekt : w_print_center
* Methode: wf_create_acrobat (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 28.09.2009
* Argument(e):
* ref datastore dsacrobat
*  string sfilename
*  boolean bshow
*
* Return: integer
*
*
**************************************************************
*  Modifikationen:
*  Datum         Version    Autor             Kommentar
* --------------------------------------------------------------------------------
*  ??.??.????    1.0        ?                 Erstellt
*  28.09.2009    1.1        Ulrich Paudler    Performanceverbesserungen: dsacrobat als Reference $$HEX1$$fc00$$ENDHEX$$bergeben, Defaultprinter am Ende nicht setzen (kostet 3-4 sec) 
*  19.12.2012    1.2        D.Bunk            Anpassungen f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$fc00$$ENDHEX$$berarbeitetes PDF Handler Objekt
*
*************************************************************/
string		sTemppath
long 			lOpenFlags 		= 1
long 			lZoomType		= 2
string		sAcrobatFile	= ""

// -------------------------------------------------------------------
// Pdf erstellen
// -------------------------------------------------------------------
sTempPath = f_gettemppath()
if Len(sTempPath) > 0 Then
	sAcrobatFile = as_File_Name
	sAcrobatFile = f_valid_filename(sAcrobatFile)
else
	uf.mbox("Achtung", "Fehler beim Erzeugen der PDF-Datei. [2]", StopSign!)
	return -1
end if

if s_app.uo_PDF.of_convert(dsAcrobat, "ReportBrowser", sAcrobatFile) <> 0 then 
	uf.mbox("Achtung", "Fehler beim Erzeugen der PDF-Datei. [5]", StopSign!)
	return -1
end if

if not FileExists(sAcrobatFile) then 
	uf.mbox("Achtung", "Fehler beim Erzeugen der PDF-Datei. [6]", StopSign!)
	return -1
end if	

f_setcurrentdirectory(s_app.scurrentdirectory)	

return 0
end function

public function integer of_fill_tripticket_fields (ref datastore rads_tripticket, integer al_flight_number, string as_ramp_box, date adt_daparture, string as_airline, string as_ac_type, string as_tail_no, string as_dep_time, string as_loading_list_line_1, string as_loading_list_line_2, string as_kdt, string as_handling_type_description, string as_tlc_from, long al_num_tr_carts);/*
* Objekt : uo_client_label
* Methode: of_fill_tripticket_fields (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.09.2010
*
* Argument(e):
* ref	 datastore rads_tripticket
*		 integer al_flight_number
*		 string as_ramp_box
*		 date adt_daparture
*		 string as_airline
*		 string as_ac_type
*		 string as_tail_no
*		 string as_dep_time
*		 string as_loading_list_line_1
*		 string as_loading_list_line_2
*		 string as_kdt
*
* Beschreibung:		F$$HEX1$$fc00$$ENDHEX$$llen der Felder in Header / Footer
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.09.2010		Erstellung
*
*
* Return: integer
*
*/

String	ls_Error
String	ls_Mod


//f_flightnumber
//f_rampbox
//h_departuredate
//t_h_airline
//h_actype
//t_tail_no
//f_departure
//t_h_ll_1
//t_h_ll_2

If IsNULL(as_ramp_box)					Then as_ramp_box = " "
If IsNULL(as_tail_no)					Then as_tail_no = " "
If IsNULL(as_loading_list_line_1)	Then as_loading_list_line_1 = " "
If IsNULL(as_loading_list_line_2)	Then as_loading_list_line_2 = " "


ls_Error = rads_tripticket.Modify("f_flightnumber.Text='"		+ String(al_flight_number, "000")		+ "'")
ls_Error = rads_tripticket.Modify("f_rampbox.Text='"				+ as_ramp_box									+ "'")
ls_Error = rads_tripticket.Modify("h_departuredate.Text='"		+ String(adt_Daparture, "dd-MMM-yy")	+ "'")
ls_Error = rads_tripticket.Modify("t_h_airline.Text='"			+ as_airline									+ "'")
ls_Error = rads_tripticket.Modify("h_actype.Text='"				+ as_ac_type									+ "'")
ls_Error = rads_tripticket.Modify("t_tail_no.Text='"				+ as_tail_no									+ "'")
ls_Error = rads_tripticket.Modify("f_departure.Text='"			+ as_dep_time									+ "'")
ls_Error = rads_tripticket.Modify("t_h_ll_1.Text='"				+ as_loading_list_line_1					+ "'")
ls_Error = rads_tripticket.Modify("t_h_ll_2.Text='"				+ as_loading_list_line_2					+ "'")
ls_Error = rads_tripticket.Modify("t_sum_kdt.Text='"				+ as_kdt											+ "'")
ls_Error = rads_tripticket.Modify("t_handling_type.Text='"		+ as_handling_type_description			+ "'")
ls_Error = rads_tripticket.Modify("t_dep.Text='"					+ as_tlc_from									+ "'")

If al_num_tr_carts > 0 Then
	ls_Error = rads_tripticket.Modify("t_num_tr_carts.Text='"		+ String(al_num_tr_carts)					+ "'")
End If


Return 1
end function

public function long of_get_handlings (long al_result_key, ref string ras_handling_list[]);/*
* Objekt : uo_client_label
* Methode: of_get_handlings (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 22.09.2010
*
* Argument(e):
*       long     al_result_key
*   ref string   ras_handling_list
*
* Beschreibung:		Ermittle Loading Lists
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	22.09.2010		Erstellung
*
*
* Return: long
*
*/


DataStore	lds_Handlings
Integer		li_Succ
Long			ll_Return
Long			ll_Rows
Long			ll_Count
Long			ll_Type
String		ls_SSL, ls_ZBL

lds_Handlings = CREATE DataStore

lds_Handlings.DataObject = "dw_change_cen_out_handling"
li_Succ = lds_handlings.SetTransobject(SQLCA)

ll_Rows = lds_Handlings.Retrieve(al_Result_key, s_app.ilanguage )

ll_Return = lds_Handlings.RowCount()
//For ll_Count = 
If lds_Handlings.RowCount() > 0 Then
	//ras_Handling_List = lds_Handlings.Object.cloadinglist
	For ll_Count = 1 To lds_Handlings.RowCount()
		ll_Type = lds_Handlings.GetItemNumber(ll_Count, "nhandling_id")
		If ll_Type = 1 then
			If Trim(ls_SSL) > "" Then ls_SSL += "  "
			ls_SSL += lds_Handlings.GetItemString(ll_Count, "ctext")
			ls_SSL += "    "
			ls_SSL += lds_Handlings.GetItemString(ll_Count, "cloadinglist")
			
			//lds_Handlings.GetItemString(ll_Count, "cloadinglist")
		Else
			If Trim(ls_ZBL) > "" Then ls_ZBL += "  "
			ls_ZBL += lds_Handlings.GetItemString(ll_Count, "ctext")
			ls_ZBL += "    "
			ls_ZBL += lds_Handlings.GetItemString(ll_Count, "cloadinglist")
	
	
		End If	
	Next
	
	ras_Handling_List[1] = ls_SSL
	ras_Handling_List[2] = ls_ZBL
	
Else
	ll_Return = -1
End If
//	ras_Handling_List[upperbound(ras_Handling_List) + 1] = lds_Handlings.GetItemString(ll_Count, "cloadinglist")
DESTROY lds_Handlings

Return ll_Return


end function

public function string of_get_production_range (long al_airline, string as_unit, string as_dep_time);/*
* Objekt : uo_client_label
* Methode: of_get_production_range (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 23.09.2010
*
* Argument(e):
*	 long al_airline
*	 string as_unit
*	 string as_dep_time
*
* Beschreibung:		Ermittle Production Range
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	23.09.2010		Erstellung
*
*
* Return: string
*
*/

Long		ll_Rows
Integer	li_Succ
String	ls_Return


// ############### TODO #################
// loc_unit_prod_ranges.crange
// loc_unit_prod_ranges.cdescription
// via loc_unit_group_ranges / ....???
// ######################################

//dw_uo_wtrmrk_prod_range
//Client time unit
// crange
// cdescription
// welche label group?

DataStore lds_Prod_Range
lds_Prod_Range = CREATE DataStore
lds_Prod_Range.DataObject = "dw_uo_wtrmrk_prod_range"
li_Succ = lds_Prod_Range.SetTransObject(SQLCA)

ll_Rows = lds_Prod_Range.Retrieve()
If lds_Prod_Range.RowCount() > 0 Then
	// ### TODO Ausfiltern ###
	ls_Return = lds_Prod_Range.GetItemString(1, "crange")

End If

DESTROY lds_Prod_Range


Return ls_Return
end function

public function integer of_tripticket_sheet (string arg_s_labelfilter);/*
* Objekt : uo_client_label
* Methode: of_tripticket_sheet (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 29.07.2010
*
* Argument(e):
* string arg_s_labelfilter
*
* Beschreibung:		Angepasste Kopie von of_cartdiagram_sheet
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	29.07.2010		Erstellung
*
*
* Return: integer
*
*/


// 13.01.2010 Ulrich Paudler [UP] Area & Workstation und Loadinglist
String	lsArea, lsWorkstation, lsLoadinglist

// -----------------------------------------------------------
// 
// Beladung ermitteln
// 
// -----------------------------------------------------------
Long       	lStart, lEnde
Long       	llRow, llItem, llNewRow, llFoundRow
Long 			llIndex, llDetail, llBelly
String    	lsStowage, lsClass
String		ls_Class_1, ls_Class_2, ls_Class_3
Long			ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_1, ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_2, ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_3
Long			ll_TR_Cart 
Long			ll_Rows
Long			ll_Catering_Leg
Long			ll_Airline
Long			ll_Classes
DataStore	lds_Classes

lStart = CPU()


// -----------------------------------------------------------
// Kein ResultKey = Fehler
// -----------------------------------------------------------
if isNull(this.lResultKey) or this.lResultKey = 0 then
   sErrorMessage = uf.translate("Flugdaten k$$HEX1$$f600$$ENDHEX$$nnen nicht ermittelt werden!")
	if ii_Do_NOT_Trace = 0 Then
		f_trace("uo_client_label.of_tripticket_sheet RESULTKEY 0")
	End If

   return -1
end if

// -----------------------------------------------------------
// Die Fluginformationen die zum ResultKey geh$$HEX1$$f600$$ENDHEX$$ren einlesen
// -----------------------------------------------------------
if dsCenOut.RowCount() <= 0 then

   dsCenOut.Retrieve(this.lResultKey)
   if dsCenOut.RowCount() <= 0 then
		if ii_Do_NOT_Trace = 0 Then
			f_trace("uo_client_label.of_tripticket_sheet Keine Flugdaten gefunden")
		End If
      sErrorMessage = uf.translate("Keine Flugdaten gefunden!")
      return -1
   elseif dsCenOut.RowCount() > 1 then
  		if ii_Do_NOT_Trace = 0 Then
			f_trace("uo_client_label.of_tripticket_sheet Keine Flugdaten gefunden")
		End If
	   sErrorMessage = uf.translate("Flugdaten konnten nicht ermittelt werden!")
      return -1
   end if
   
end if


// Klassen
ll_Airline = dsCenOut.GetItemNumber(1, "nairline_key")
lds_Classes = CREATE DataStore
lds_Classes.DataObject = "dw_airline_classnames"
lds_Classes.SetTransObject(SQLCA)
ll_Classes = lds_Classes.Retrieve(ll_Airline)

// -----------------------------------------------------------
// Die Beladung ermitteln, bei Abfertigungsart DLV
// in cen_out_local_ssl (Der Scheich fliegt) nachschaun.
// -----------------------------------------------------------
if dsCenOut.GetItemString(1, "chandling_type_text") <> "DLV" then

   if this.of_get_standard_loading() <> 0 then
      sErrorMessage = uf.translate("Keine Standardbeladung gefunden!")
		if ii_Do_NOT_Trace = 0 Then
			f_trace("uo_client_label.of_tripticket_sheet Keine Standardbeladung gefunden!")
		End If
      return -1
   end if

else

   if this.of_get_local_standard_loading() <= 0 then
  		if ii_Do_NOT_Trace = 0 Then
			f_trace("uo_client_label.of_tripticket_sheet Keine individuelle Standardbeladung gefunden!")
		End If
		sErrorMessage = uf.translate("Keine individuelle Standardbeladung gefunden!")
      return -1
   end if
   
end if
// -----------------------------------------------------------
// Die Lokalen Informationen zuspielen
// -----------------------------------------------------------	
this.of_add_workstations()

If Trim(arg_s_labelfilter) > "" Then
//	arg_s_labelfilter = "(" + arg_s_labelfilter + ") AND ( ntransporter_cart = 1)"
End If

ll_Rows = dsLoading.RowCount()
// 24.11.2009 Ulrich Paudler [UP]
this.dsLoading.SetFilter(arg_s_labelfilter)
this.dsLoading.Filter()
ll_Rows = dsLoading.RowCount()
this.dsLoading.SetFilter("ntransporter_cart = 1")
this.dsLoading.Filter()
ll_Rows = dsLoading.RowCount()

if ii_Do_NOT_Trace = 0 Then
	f_trace("uo_cart_diagram.of_tripticket_sheet dsLoading.RowCount=" + String(dsLoading.RowCount()))
End If


// Alle Elemente durchgehen
For llRow = 1 to this.dsLoading.RowCount()

	ll_TR_Cart = this.dsLoading.GetItemNumber(llRow, "ntransporter_cart")
	ll_Catering_Leg = this.dsLoading.GetItemNumber(llRow, "ncatering_leg")

   // 19.08.2009 Ulrich Paudler [UP] Pr$$HEX1$$fc00$$ENDHEX$$fen ob index/detail schon vorhanden -> sstowage erweitern
   llIndex  = this.dsLoading.GetItemNumber(llRow, "cen_packinglist_index_npackinglist_index_key")
   llDetail = this.dsLoading.GetItemNumber(llRow, "cen_packinglists_npackinglist_detail_key")
   lsStowage = this.dsLoading.GetItemString(llRow, "cen_galley_cgalley")  + "-" +  this.dsLoading.GetItemString(llRow, "cen_stowage_cstowage") + " " + this.dsLoading.GetItemString(llRow, "cen_stowage_cplace")
   // 27.10.2009 Ulrich Paudler [UP]
   llBelly	=	this.dsLoading.GetItemNumber(llRow, "cen_loadinglists_nbelly_container")
   lsClass	=	this.dsLoading.GetItemString(llRow, "cen_loadinglists_cclass") 
  
   lsClass	=	this.dsLoading.GetItemString(llRow, "cclass1") 


	// Vorbelegung
	ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_1 = 999999
	ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_2 = 999999
	ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_3 = 999999
	ls_Class_1 =	this.dsLoading.GetItemString(llRow, "cclass1") 
	If NOT IsNULL(ls_Class_1) AND Trim(ls_Class_1) > "" Then
		ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_1 = lds_Classes.Find("cclass='" + ls_Class_1 + "'", 1, lds_Classes.RowCount() )		
	End If
	ls_Class_2 =	this.dsLoading.GetItemString(llRow, "cclass2") 
	If NOT IsNULL(ls_Class_2) AND Trim(ls_Class_2) > "" Then
		ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_2 = lds_Classes.Find("cclass='" + ls_Class_2 + "'", 1, lds_Classes.RowCount() )		
	End If
	ls_Class_3 =	this.dsLoading.GetItemString(llRow, "cclass3") 
	If NOT IsNULL(ls_Class_3) AND Trim(ls_Class_3) > "" Then
		ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_3 = lds_Classes.Find("cclass='" + ls_Class_3 + "'", 1, lds_Classes.RowCount() )		
	End If
	If ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_1 < ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_2 AND ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_1 < ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_3 Then	lsClass = ls_Class_1
	If ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_2 < ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_1 AND ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_2 < ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_3 Then	lsClass = ls_Class_2
	If ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_3 < ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_2 AND ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_3 < ll_Class_Rank$$HEX1$$ed00$$ENDHEX$$ng_1 Then	lsClass = ls_Class_3

	
	// 13.01.2010 Ulrich Paudler [UP] Area & Workstation hinzu
   lsArea 		   = this.dsLoading.GetItemString(llRow, "carea") 
   lsWorkstation = this.dsLoading.GetItemString(llRow, "cworkstation_text") 
   lsLoadinglist = this.dsLoading.GetItemString(llRow, "cen_loadinglist_index_cloadinglist") 

	
   llFoundRow = dsCartdiagramsheet.Find("nindex_key=" + String(llIndex) + " AND ndetail_key=" +String(llDetail), 1, dsCartdiagramsheet.Rowcount()) 
   // nicht gefunden oder keine Zeile vorhanden
   if llFoundRow <= 0 then
      llNewRow = dsCartdiagramsheet.insertrow( 0)
      dsCartdiagramsheet.setitem( llNewRow,"nindex_key", llIndex)
      dsCartdiagramsheet.setitem( llNewRow,"ndetail_key", llDetail)
      dsCartdiagramsheet.setitem( llNewRow,"sstowage",lsStowage)
		// 27.10.2009 Ulrich Paudler [UP]
		dsCartdiagramsheet.setitem( llNewRow,"nbelly",llBelly)
		dsCartdiagramsheet.setitem( llNewRow,"sclass",lsClass)
		// 13.01.2010 Ulrich Paudler [UP]
		dsCartdiagramsheet.setitem( llNewRow,"sarea",lsArea)
		dsCartdiagramsheet.setitem( llNewRow,"sworkstation",lsWorkstation)
		dsCartdiagramsheet.setitem( llNewRow,"sloadinglist",lsLoadinglist)
		dsCartdiagramsheet.setitem( llNewRow,"ncatering_leg",	ll_catering_leg)
   else
      lsStowage = lsStowage + "," + dsCartdiagramsheet.getitemstring( llFoundRow,"sstowage")
      dsCartdiagramsheet.setitem( llFoundRow,"sstowage",lsStowage)
   end if
Next

this.dsLoading.SetFilter("")
this.dsLoading.Filter()
this.dsLoading.Sort()


lEnde = CPU()

DESTROY lds_Classes

return 0

end function

public function integer of_create_tripticket (long al_result_key, ref string ras_file_name, string as_unit, integer ai_useexclusionlabel, long al_result_keys[], string as_currentprinter, string as_labelfilter, boolean ab_printdirectly, ref uo_tripticket rauo_tripticket);/*
* Objekt : uo_client_label
* Methode: of_create_tripticket (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 18.08.2010
*
* Argument(e):
*	 		long		al_result_key				Flug
*	 ref	string	ras_file_name				PDF Dateiname
*	 		string	as_unit						
*	 		integer	ai_useexclusionlabel		siehe w_print_center / iuseexclusionlabel
*	 		long		al_result_keys[]			Flug mit dazugeh$$HEX1$$f600$$ENDHEX$$renden anderen Legs
*	 		string	as_currentprinter			Wohin wird gedruckt
*	 		string	as_labelfilter				Labelfilter - siehe w_print_center
*	 		boolean	ab_printdirectly			Direktdruck statt PDF
*
* Beschreibung:		Erstelle Transporter Cart Diagramm
*
* Aenderungshistorie:
* Version    Wer         Wann          Was und warum
*  1.0       O.Hoefer    18.08.2010    Erstellung
*  1.1       O.Hoefer    02.11.2011    Z$$HEX1$$e400$$ENDHEX$$hlung Classes / Pages repariert
*  1.2       O.Hoefer    20.02.2012    Z$$HEX1$$e400$$ENDHEX$$hlung Classes, weitere Stelle
*  1.3       D.Bunk      19.12.2012    Anpassungen f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$fc00$$ENDHEX$$berarbeitetes PDF Handler Objekt
*
* Return: integer
*
*/

Blob					lb_Blob
Integer				li_Succ
Integer				iRet
long					ll_Start, ll_Stop
long					lFileCounter
long 					llIndex, llIndexComponent //, ll_RowContent
Long					ll_FullState				
Long					ll_Temp
Long					ll_Class_Cycles
Long					ll_Found
Long					ll_Counter
Long					ll_Routing_ID
Long					ll_Flight_Number
Long         		ll_Airline_key
Long			      ll_Leg_Number  	
Long					ll_transaction
Long					ll_num_xporters
Long					ll_Count_PL, ll_TT_Row
Long					ll_Class_Counter
Long					ll_Count_TT_Rows, ll_Count_TT_Cols
Long					ll_Loadinglists
Long					ll_Count_Classes
Long					ll_Tmp_Counter
String				ls_Stowage
String				ls_File_Name
String				ls_Area
string				ls_PdfFiles[] 
String				ls_handling_type_text
String				ls_packinglist, ls_class, ls_ramp_box, ls_currentpage, ls_pl_description
String				ls_temp
String				ls_Find, ls_unitarea
String				ls_Error
String         	ls_Suffix, ls_From, ls_To
String		      ls_Airline, ls_AC_Type
String	         ls_Dep_Time, ls_Ramp_Time, ls_Unit, ls_Kitchen_Time
String				ls_Owner, ls_Config
String				ls_cbox_from, ls_cbox_to
String				ls_handling_list[]
String				ls_Class_Filter, ls_Class_1
String				ls_Ops
String				ls_Tail_No 
String				ls_ll_1 = " ", ls_ll_2 = " "
String				ls_handling_type_description
String				ls_Summary
String				ls_TT_Class_1, ls_TT_Class_2, ls_TT_Class_3
String				ls_nobooking
Boolean				lb_First = TRUE
Boolean				lb_Group_Break = FALSE
s_product_log		lstr_Log
DataStore			lds_Tmp_Types
DataStore			ldsDatastore
DataStore			ldsTripTicket
DataStore			lds_Classes
s_component 		lstr_component[],  lstr_component_empty[]
uo_cart_diagram 			luo_diagram


ll_Start = CPU()


if ii_Do_NOT_Trace = 0 Then
	f_trace("uo_client_label.of_create_tripticket BEGINE")
End If

if isvalid(w_progress_with_cancel) then
	w_progress_with_cancel.wf_setmessage(uf.translate("erstelle") + " " + uf.translate("Trip Ticket"))
end if
		
		
lds_Classes = CREATE DataStore
lds_Classes.DataObject   = "dw_ext_classes"

dsCartdiagramSheet.reset()

li_Succ = of_get_flight_details( al_result_key, ll_flight_number, ls_suffix, ls_from, ls_to, ll_airline_key, ls_airline, ls_ac_type, &
											ls_dep_time, ls_ramp_time, ls_unit, ll_Leg_Number, ll_routing_id, ls_owner, ls_Config, &
											ls_cbox_from, ls_cbox_to, ls_kitchen_time, ll_transaction, ls_Tail_No )

If IsnULL(ls_Tail_No) Then	ls_Tail_No = " "

//// OPS
//select ctext 
//into :ls_OPS
//from loc_operations
//where cunit = :ls_unit
//and :ls_Dep_Time between ctime_from and ctime_to;
// --------------------------------------------------------------------
// ermittle ops - CBASE-NAM-CR-12089
// --------------------------------------------------------------------
select		ctext 
into			:ls_OPS
from			loc_operations
where			cunit = :ls_Unit
and			:ls_Dep_Time between ctime_from and ctime_to
and			nsort = (select max(nsort) 
							from	loc_operations  
							where	cunit = :ls_Unit
							and	:ls_Dep_Time between ctime_from and ctime_to );



ldsDatastore = create datastore

luo_diagram = create uo_cart_diagram
luo_diagram.iTrace = s_app.iTrace
luo_diagram.idt_Departure = ddeparture
If isvalid(inv_copy_settings) then
	luo_diagram.inv_copy_settings = inv_copy_settings
End If

ldsTripTicket	= create datastore
ldsTripTicket.dataobject="dw_uo_layout_trip"   //"dw_packinglist_content_edit"

// Loading Lists - dw_change_cen_out_handling
ll_Loadinglists = of_get_handlings(al_result_key, ls_handling_list)

lResultKeys = al_Result_keys
// -------------------------------------------------------------------
// Ermittle relevante St$$HEX1$$fc00$$ENDHEX$$cklisten f$$HEX1$$fc00$$ENDHEX$$r TR Cart 
// -------------------------------------------------------------------
f_set_printer(as_CurrentPrinter) 

iRet = of_tripticket_sheet(as_LabelFilter)
if iRet <> 0 then iRet = 0
if iRet = -1000 then
	if ii_Do_NOT_Trace = 0 Then
		f_trace("uo_client_label.of_create_tripticket of_tripticket_sheet -1000")
	End If
	
	return -1000
	
elseif iRet = 0 then

	if isNull(ls_Owner) then ls_Owner = ""
	if isNull(ls_ac_type) then ls_ac_type = ""
	if isNull(ls_Config) then ls_Config = ""

	//	ras_file_name = f_gettemppath() + "CBASE-TRIPTICKET-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
	ls_File_Name = ls_Airline + String(ll_flight_number , "000") + "_" + ls_From + "_" + ls_to + "_" +String( ddeparture, "YYYYMMDD")
	ls_File_Name += "_TT_" + String(ll_transaction) + "_" + String(Rand(32000),"00000") + ".PDF"
	//ls_File_Name =sWebTempPath + ls_File_Name

	ras_file_name = f_gettemppath() + ls_File_Name

	// -------------------------------------------------------------------
	// Schleife $$HEX1$$fc00$$ENDHEX$$ber gefundene St$$HEX1$$fc00$$ENDHEX$$cklisten 
	// -------------------------------------------------------------------	
	if ii_Do_NOT_Trace=0 then
		f_trace("of_create_tripticket dsCartdiagramSheet " + String(dsCartdiagramSheet.rowcount() ))
	end if
	
	If dsCartdiagramSheet.Rowcount() > 0 then
//			if isvalid(w_progress_with_cancel) then
//				// wurde abgebrochen?
//				if w_progress_with_cancel.bCancel then
//					return -1000
//				end if
//				w_progress_with_cancel.wf_setposition(ll_Row)
//	//			w_progress_with_cancel.wf_setstatus( uf.translate("Seite ") +  string(ll_TRCartPages) )
//			end if		
//			luo_diagram.isStowage = ls_Stowage
		luo_diagram.il_Routing_ID = ll_routing_ID
		If NOT Isnull(ls_cbox_from) Then ls_ramp_box = ls_cbox_from
		If NOT Isnull(ls_cbox_to) Then ls_ramp_box += " - " + ls_cbox_to	
		// --------------------------------------------------------------------------------------
		// Fill Contents & Print		
		// --------------------------------------------------------------------------------------
		li_Succ = of_create_tripticket_main(al_result_key , ls_handling_list , ll_flight_number , ls_ramp_box , &
													ls_airline , ls_ac_type , ls_tail_no , ls_dep_time , ls_ramp_time , ls_handling_type_text , &
													ls_handling_type_description, ls_from, rauo_tripticket, ll_airline_key,  ls_PdfFiles )

		
	else
		// keine rows in dsCartdiagramSheet
		luo_diagram.il_Routing_ID = ll_routing_ID
		ls_Temp = ls_cbox_from
		If NOT Isnull(ls_temp) Then ls_ramp_box = ls_Temp
		ls_Temp = ls_cbox_to
		If NOT Isnull(ls_temp) Then ls_ramp_box += " - " + ls_Temp

		
		If IsValid(rauo_tripticket) Then
			li_Succ = rauo_tripticket.of_concat_handling(ls_handling_list, ls_ll_1, ls_ll_2)
		End If
			
		// Werte ermitteln - kein TR Cart
		li_Succ = of_fill_tripticket_fields(ldsTripTicket, ll_Flight_Number , ls_Ramp_Box , ddeparture , ls_Airline , ls_AC_Type , ls_Tail_No , &
					ls_Dep_Time , ls_ll_1, ls_ll_2, ls_Ramp_Time, ls_handling_type_text + "   " + ls_handling_type_description, ls_From , rauo_tripticket.il_Num_TR_Carts )

		If IsValid(rauo_tripticket) Then
			// Ermittle Klassen
			if ii_Do_NOT_Trace=0 then
				//uf.mbox("Info", "TripTicket ids_packinglists " + String(rauo_tripticket.ids_packinglists.rowcount() ))
				rauo_tripticket.ids_Packinglists.saveas(f_gettemppath()+"tripticket_PL_" + String(al_result_key ) + "_" + String(now(), "hhmmssfff") + ".xls", excel5!, true)
			end if

			For ll_Count_PL = 1 To rauo_tripticket.ids_Packinglists.RowCount()
				ls_Stowage =  rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sstowage_pos")
				luo_diagram.isStowage = ls_Stowage
				ll_Temp = rauo_tripticket.ids_Packinglists.GetItemNumber(ll_Count_PL, "nclass_number")
				ll_Found = lds_Classes.Find("nclass_number=" + String(ll_Temp), 1, lds_Classes.RowCount())
				If ll_Found = 0 Then
					ls_temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sclass")
					//If rauo_tripticket.of_is_booking_class(ls_temp) Then
						ll_TT_Row = lds_Classes.insertRow(0)
						li_Succ = lds_Classes.SetItem(ll_TT_Row, "nclass_number", ll_Temp)
						//ls_temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sclass")
						li_Succ = lds_Classes.SetItem(ll_TT_Row, "cclass", ls_temp)
//							Else
//								// Non Booking: jetzt nicht 
//							End If
				End if
			Next
			ll_Class_Cycles = lds_Classes.RowCount()
			// 20.02.2012 Z$$HEX1$$e400$$ENDHEX$$hlung Classes / Pages repariert
			ll_Class_Cycles = Ceiling(ll_Class_Cycles / 3)
			li_Succ = lds_Classes.Sort()
			ll_Class_Counter = 0
	
			For ll_Count_Classes = 1 To ll_Class_Cycles //lds_Classes.RowCount()
				ldsTripTicket.Reset()
				ls_TT_Class_1 = ""
				ls_TT_Class_2 = ""
				ls_TT_Class_3 = ""
				ls_Class_Filter = "nclass_number in("
				ll_Class_Counter = (ll_Count_Classes - 1) * 3 + 1
				If ll_Class_Counter <= lds_Classes.RowCount() Then
					ls_Class_Filter += String(lds_Classes.Getitemnumber(ll_Class_Counter, "nclass_number")) + ", "
					ls_TT_Class_1 = lds_Classes.GetitemString(ll_Class_Counter, "cclass")
				End If
				ll_Class_Counter++
				If ll_Class_Counter <= lds_Classes.RowCount() Then
					ls_Class_Filter += String(lds_Classes.Getitemnumber(ll_Class_Counter, "nclass_number")) + ", "
					ls_TT_Class_2 = lds_Classes.GetitemString(ll_Class_Counter, "cclass")
				End If
				ll_Class_Counter++
				If ll_Class_Counter <= lds_Classes.RowCount() Then
					ls_Class_Filter += String(lds_Classes.Getitemnumber(ll_Class_Counter, "nclass_number")) + ", "
					ls_TT_Class_3 = lds_Classes.GetitemString(ll_Class_Counter, "cclass")
				End If
				ls_Class_Filter = Left(ls_Class_Filter, Len(ls_Class_Filter) - 2) + ")"
				
				ll_temp = rauo_tripticket.ids_Packinglists.RowCount()
				li_Succ = rauo_tripticket.ids_Packinglists.SetFilter(ls_Class_Filter)
				li_Succ = rauo_tripticket.ids_Packinglists.Filter()
				li_Succ = rauo_tripticket.ids_Packinglists.Sort()
				ll_temp = rauo_tripticket.ids_Packinglists.RowCount()
			
				For ll_Count_PL = 1 To rauo_tripticket.ids_Packinglists.RowCount()
					
					ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "scart_type")
					If rauo_tripticket.of_is_type_relevant(ls_temp) = FALSE Then
						
						//if ii_Do_NOT_Trace = 0 Then
							f_trace("uo_client_label.of_create_tripticket Type not relevant " + ls_Temp)
						//End If
						
						CONTINUE
					End If
					
					ll_TT_Row = ldsTripTicket.RowCount()

					// 01.09.2011 Test AREA UNITAREA
					ls_Unitarea = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sunit_area")
					//ls_Unitarea = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sarea")
					ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sclass")
					If ls_Temp = ls_TT_Class_1 Then
						// Find the first Row for Current sunitarea where PL is empty									
						ls_Find = "sunitarea='" + ls_Unitarea + "' AND isnull(spl_1)" 
						ll_found = ldsTripTicket.Find(ls_Find, 1, ldsTripTicket.RowCount())
						If ll_found > 0 Then
							ll_TT_Row = ll_Found
						Else
							ll_TT_Row = ldsTripTicket.InsertRow(0)
						End If
						
						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"sclass1" ,  ls_Temp)
						ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sstowage_pos")
						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"sstowage1" ,  ls_Temp)
						ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "spl_nr")
						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"spl_1" ,  ls_Temp)
						ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "spl_text")
						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"spl_text1" ,  ls_Temp)
						ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "scart_type")
						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"stype_1" ,  ls_Temp)

					ElseIf ls_Temp = ls_TT_Class_2 Then
						ls_Find = "sunitarea='" + ls_Unitarea + "' AND isnull(spl_2)" 
						ll_found = ldsTripTicket.Find(ls_Find, 1, ldsTripTicket.RowCount())
						If ll_found > 0 Then
							ll_TT_Row = ll_Found
						Else
							ll_TT_Row = ldsTripTicket.InsertRow(0)
						End If

						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"sclass2" ,  ls_Temp)
						ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sstowage_pos")
						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"sstowage2" ,  ls_Temp)
						ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "spl_nr")
						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"spl_2" ,  ls_Temp)
						ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "spl_text")
						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"spl_text2" ,  ls_Temp)									
						ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "scart_type")
						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"stype_2" ,  ls_Temp)

					ElseIf ls_Temp = ls_TT_Class_3 Then

						ls_Find = "sunitarea='" + ls_Unitarea + "' AND isnull(spl_3)" 
						ll_found = ldsTripTicket.Find(ls_Find, 1, ldsTripTicket.RowCount())
						If ll_found > 0 Then
							ll_TT_Row = ll_Found
						Else
							ll_TT_Row = ldsTripTicket.InsertRow(0)
						End If
						
						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"sclass3" ,  ls_Temp)
						ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sstowage_pos")
						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"sstowage3" ,  ls_Temp)
						ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "spl_nr")
						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"spl_3" ,  ls_Temp)
						ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "spl_text")
						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"spl_text3" ,  ls_Temp)
						ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "scart_type")
						li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"stype_3" ,  ls_Temp)

					Else
						// Error
						ls_error = "wrong class " + ls_Temp
						//uf.mbox("Wrong Class" , ls_Temp )
					End If
					ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sunit_area")
					li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"sunitarea" ,  ls_UnitArea)
					ll_Temp = rauo_tripticket.ids_Packinglists.GetItemNumber(ll_Count_PL, "nclass_number")
					li_Succ = ldsTripTicket.SetItem(ll_TT_Row, "nclass_number1" , ls_Temp)
				Next
				
				// --------------------------------------------------------------------
				// TR Carts je Klasse
				// --------------------------------------------------------------------
				
				// --------------------------------------------------------------------
				// TR Carts je Klasse
				// --------------------------------------------------------------------
				li_Succ = rauo_tripticket.of_tr_carts_per_class(ldstripticket)

				
//				
				// --------------------------------------------------------------------
				// Z$$HEX1$$e400$$ENDHEX$$hle Typen & Summen	GESAMT
				// --------------------------------------------------------------------
				lds_Tmp_Types = CREATE DataStore
				lds_Tmp_Types.DataObject = "dw_ext_classes"
				ll_Tmp_Counter = 0
				For ll_Count_TT_Rows = 1 TO ldsTripTicket.RowCount()
					For ll_Count_TT_Cols = 1 To 3
					
						ls_Temp = ldsTripTicket.GetItemString(ll_Count_TT_Rows,"stype_" + String(ll_Count_TT_Cols))
						If IsNULL(ls_Temp) Then CONTINUE
						ll_Tmp_Counter++
						ls_Find = "cclass='"  + ls_Temp + "'"
						ll_Found = lds_Tmp_Types.Find(ls_Find, 1, lds_Tmp_Types.RowCount())
						If ll_Found = 0 Then
							ll_Found = lds_Tmp_Types.InsertRow(0)
							li_Succ = lds_Tmp_Types.SetItem(ll_Found, "cclass", ls_Temp)
							li_Succ = lds_Tmp_Types.SetItem(ll_Found, "nnumeric_1", 1)
						Else
							ll_Temp = lds_Tmp_Types.GetItemNumber(ll_Found, "nnumeric_1")
							li_Succ = lds_Tmp_Types.SetItem(ll_Found, "nnumeric_1", ll_temp + 1)
						End if
					Next												
				Next
				ls_Summary = ""
				For ll_Count_TT_Rows = 1 TO lds_Tmp_Types.RowCount()
					ls_Summary += String(lds_Tmp_Types.GetItemNumber(ll_Count_TT_Rows, "nnumeric_1")) + " "
					ls_Summary += lds_Tmp_Types.GetItemString(ll_Count_TT_Rows, "cclass")+ " / "							
				Next
				ls_Summary = TRIM(ls_Summary)
				If Right(ls_Summary, 1 ) = "/" Then ls_Summary = Left(ls_Summary, Len(ls_Summary) - 1)
				If ll_num_Xporters > 0 Then
					ls_Summary += " / " + String(ll_num_xporters ) + " Xporters"	
					ls_Summary = "Total Carts to Load: "  + String(ll_Tmp_Counter + ll_num_xporters) + "~r~n" + ls_Summary	
				Else
					ls_Summary = "Total Carts to Load: "  + String(ll_Tmp_Counter) + "~r~n" + ls_Summary
				End If 
				ls_Error = ldstripticket.Modify("t_sum_alles.Text='" + ls_Summary + "'")
				
				// ----------------------------------------------------------------------
				// Summe pro Spalte 
				// ----------------------------------------------------------------------
				ll_Tmp_Counter = 0
				lds_Tmp_Types.Reset()
				For ll_Count_TT_Rows = 1 TO ldsTripTicket.RowCount()
					For ll_Count_TT_Cols = 1 To 3
					
						ls_Temp = ldsTripTicket.GetItemString(ll_Count_TT_Rows,"stype_" + String(ll_Count_TT_Cols))
						
						If IsNULL(ls_Temp) Then CONTINUE
						ll_Tmp_Counter++
						// nclass_number = SPALTE
						
						ls_Find = "cclass='"  + ls_Temp + "' AND nclass_number=" + String(ll_Count_TT_Cols)
						ll_Found = lds_Tmp_Types.Find(ls_Find, 1, lds_Tmp_Types.RowCount())
						If ll_Found = 0 Then
							ll_Found = lds_Tmp_Types.InsertRow(0)
							li_Succ = lds_Tmp_Types.SetItem(ll_Found, "cclass", ls_Temp)
							li_Succ = lds_Tmp_Types.SetItem(ll_Found, "nnumeric_1", 1)
							li_Succ = lds_Tmp_Types.SetItem(ll_Found, "nclass_number", ll_Count_TT_Cols)
						Else
							ll_Temp = lds_Tmp_Types.GetItemNumber(ll_Found, "nnumeric_1")
							li_Succ = lds_Tmp_Types.SetItem(ll_Found, "nnumeric_1", ll_temp + 1)
							li_Succ = lds_Tmp_Types.SetItem(ll_Found, "nclass_number", ll_Count_TT_Cols)
						End if
						
					Next												
				Next
				
				For ll_Count_TT_Cols = 1 To 3
					ls_Summary = ""
					li_Succ = lds_Tmp_Types.SetFilter("nclass_number=" + String(ll_Count_TT_Cols))
					li_Succ = lds_Tmp_Types.Filter()
					For ll_Count_TT_Rows = 1 TO lds_Tmp_Types.RowCount()
						ls_Summary += String(lds_Tmp_Types.GetItemNumber(ll_Count_TT_Rows, "nnumeric_1")) + " "
						ls_Summary += lds_Tmp_Types.GetItemString(ll_Count_TT_Rows, "cclass") + " / "							
					Next
					ls_Summary = TRIM(ls_Summary)
					If Right(ls_Summary, 1 ) = "/" Then ls_Summary = Left(ls_Summary, Len(ls_Summary) - 1)
					
					ls_temp = ldstripticket.describe("t_num_tr_" + String(ll_Count_TT_Cols) + ".Text")
					ls_Error = ldstripticket.Modify("t_sum_type_" + String(ll_Count_TT_Cols) + ".Text='" + ls_Summary + "'")
				Next
				// ----------------------------------------------------------------------
				// Ende Summe pro Spalte 
				// ----------------------------------------------------------------------								
				DESTROY lds_Tmp_Types
				// --------------------------------------------------------------------
				// ENDE Z$$HEX1$$e400$$ENDHEX$$hle Typen & Summen	GESAMT
				// --------------------------------------------------------------------

				
				// --------------------------------------------------------------------
				// TR Carts je Klasse
				// --------------------------------------------------------------------
				If ii_Do_NOT_Trace = 0 Then
					rauo_tripticket.ids_TR_Classes.saveas(f_gettemppath() + "ids_TR_Classes_" + String(Rand(32767)) + String(now(), "hhmmss") + ".XLS", Excel5!, True)
				End if											
				ldsTripTicket.groupcalc( )
				if ii_Do_NOT_Trace=0 then
					li_Succ = ldsTripTicket.saveas(f_gettemppath() + "CBASE-TRIPTICKET-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PSR", PSReport!, True)
				End If	
				ll_FullState = ldsTripTicket.getfullstate(lb_Blob) 
				ll_FullState = Len  (lb_Blob)
				ll_FullState = ldsDatastore.SetFullState(lb_Blob)
				lFileCounter++
				ls_PdfFiles[lFileCounter] = f_gettemppath() + "CBASE-TRIPTICKET-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
				li_Succ = of_create_acrobat(ldsDatastore, ls_PdfFiles[lFileCounter])
				lb_Group_Break = FALSE
				// Nochmal INIT
				lb_First = TRUE
		//end if
			Next
		End If
		ls_Stowage = ""
		//End If
		//Next
	End If

	// Erst mal pr$$HEX1$$fc00$$ENDHEX$$fen ob es etwas zum zusammenfassen gibt
	if upperbound(ls_PdfFiles) > 0 then
		if isvalid(w_progress_with_cancel) then
			w_progress_with_cancel.wf_setstatus( uf.translate("Zusammenfassen")  )
		end if
		if s_app.uo_pdf.of_concatenate(ls_PdfFiles, ras_file_name, true) <> 0 then
			li_Succ = -1
		Else
			li_Succ = 1
		end if
		If ab_PrintDirectly  Then
			s_app.uo_pdf.of_print(ras_file_name, as_CurrentPrinter)
		end if
	end if

end if

//f_set_printer(sDefaultPrinter)
	
ll_Stop = CPU()

// --------------------------------------------------------------
// Aktion protokollieren
// --------------------------------------------------------------
lstr_Log.lResultKey		= al_result_key
lstr_Log.lTransaction	= ll_transaction 
lstr_Log.lProduct   		= PRODUCT_TRIP_TICKET_SHEET
lstr_Log.lDuration   	= (ll_Stop - ll_Start) / 1000
lstr_Log.sWorkstation   = s_app.sHost
lstr_Log.sUser   			= s_app.sUser
lstr_Log.lLabelQuantity = 0
lstr_Log.lDistribution  = 0
lstr_Log.sLabelAreas 	= ""
of_Product_log(lstr_Log)

Destroy	ldsDatastore
Destroy	ldsTripTicket
DESTROY	lds_Classes
DESTROY	luo_diagram 

if ii_Do_NOT_Trace = 0 Then
	f_trace("uo_client_label.of_create_tripticket END")
End If

//GarbageCollect()
Yield()
	
Return 1

end function

public function integer of_create_content_sheet (ref string ras_file_name);/*
* Objekt : uo_client_label
* Methode: of_create_content_sheet (Function)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 10.03.2011
*
* Argument(e):
*	 		long			al_result_key				Flug
*	 ref	string		ras_file_name				PDF Dateiname
*
* Beschreibung:		Erstelle Content Sheets
*
* Aenderungshistorie:
* Version    Wer       Wann          Was und warum
*  1.0       Klaus     10.03.2011    Erstellung
*  1.1       D.Bunk    19.12.2012    Anpassungen f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$fc00$$ENDHEX$$berarbeitetes PDF Handler Objekt
*
*/

Long						I
string					ls_pdf_files[]
Integer					li_file_counter


if ii_Do_NOT_Trace = 0 Then
	f_trace("uo_client_label.of_create_content_sheet BEGIN")
End If



iuoContentSheet.ilResultKey = this.lResultKey

if isvalid(w_progress_with_cancel) then
	w_progress_with_cancel.wf_setstatus( uf.translate("Erstelle Inhalts$$HEX1$$fc00$$ENDHEX$$bersicht")  )
	w_progress_with_cancel.wf_setmessage(uf.translate("erstelle") + " " + uf.translate("Inhalts$$HEX1$$fc00$$ENDHEX$$bersicht"))
end if

if iuoContentSheet.of_create_content_sheet() <> 0 then
	sErrorMessage = iuoContentSheet.isError
 	return -1
end if

For I = 1 to Upperbound(iuoContentSheet.dsOutput)
	if isvalid(w_progress_with_cancel) then
		w_progress_with_cancel.wf_setstatus( uf.translate("Erzeuge PDF Dateien")  )
	end if
	li_file_counter ++
	ls_pdf_files[li_file_counter] = f_gettemppath() + "CBASE-CONTENT_SHEET-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
	of_create_acrobat(iuoContentSheet.dsOutput[i], ls_pdf_files[li_file_counter] )
	
Next

if upperbound(ls_pdf_files) > 0 then
	if isvalid(w_progress_with_cancel) then
		w_progress_with_cancel.wf_setstatus( uf.translate("Zusammenfassen")  )
	end if
	
	if s_app.uo_pdf.of_concatenate(ls_pdf_files, ras_file_name, true) <> 0 then
		sErrorMessage = "Merge failed: " + ras_file_name
 		return -1
	end if
end if

For I = 1 to Upperbound(ls_pdf_files)
	Filedelete(ls_pdf_files[i])
Next 

// Document Engine st$$HEX1$$fc00$$ENDHEX$$rzt bei GarbageCollect() ab
If getApplication().AppName = "cbase" Then GarbageCollect()
//GarbageCollect()
Yield()

if ii_Do_NOT_Trace = 0 Then
	f_trace("uo_client_label.of_create_content_sheet END")
End If


if upperbound(ls_pdf_files) > 0 then
	Return 0
Else
	Return -1
End If
end function

public function string of_remove_cr (string svalue);// ------------------------------------
// ~r~n aus String entfernen
// ------------------------------------

Integer 	I
String 	sReturn, sTemp

sReturn = ""

for i = 1 to Len(sValue) 
	
	sTemp = Mid(sValue, i, 1)
	
	if sTemp = "~n" or sTemp = "~r" then
		sTemp = ""
	end if
	
	sReturn += sTemp
		
next

return sReturn
end function

public function integer of_add_ramp_box_mode ();/*
* Objekt : uo_client_label
* Methode: of_add_ramp_box_mode (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 02.03.2012
*
* Argument(e):
* none
*
* Beschreibung:		Ermittlung des Ramp Box Modus (1 = Box From, 2 = Box To) und F$$HEX1$$fc00$$ENDHEX$$llen in dsLoading
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	02.03.2012		Erstellung
* 1.1 			O.Hoefer	02.07.2012		Umbau auf "zentrale" Speicherung (cUnit="*") CBASE-CR-NAM-12073
*
*
* Return: integer
*
*/


Integer		li_Succ
Long			ll_Stowages[]
Long			ll_Loading_Count
Long			ll_Num_Rows
Long			ll_Num_Rows_Default
String		ls_Unit
Long			ll_Stowage_key 
Long			ll_Found
Long			ll_Setting
String		ls_Find
String		ls_Default_Unit = "*"
DataStore	lds_Ramp_Box_Setting
DataStore	lds_Ramp_Box_Setting_Default


ls_Unit = This.sUnit

ll_Num_Rows = dsLoading.RowCount()

If ll_Num_Rows = 0 Then Return 0

lds_Ramp_Box_Setting = CREATE DataStore
lds_Ramp_Box_Setting.DataObject = "dw_ramp_box_setting_stowage_unit"
lds_Ramp_Box_Setting.SetTransObject (SQLCA)

lds_Ramp_Box_Setting_Default = CREATE DataStore
lds_Ramp_Box_Setting_Default.DataObject = "dw_ramp_box_setting_stowage_unit"
lds_Ramp_Box_Setting_Default.SetTransObject (SQLCA)

// -----------------------------
// List of Stowages
// -----------------------------
For ll_Loading_Count = 1 To dsLoading.RowCount()
	ll_Stowage_key = dsLoading.GetItemNumber(ll_Loading_Count, "cen_stowage_nstowage_key")
	If Not isnull(ll_Stowage_key) Then
		ll_Stowages[Upperbound(ll_Stowages) + 1] = ll_Stowage_key
	End if
Next

If Upperbound(ll_Stowages) > 0 Then 
	ll_Num_Rows = lds_Ramp_Box_Setting.Retrieve(ls_Unit, ll_Stowages)
	ll_Num_Rows_Default = lds_Ramp_Box_Setting_Default.Retrieve(ls_Default_Unit, ll_Stowages)
	// -----------------------------
	// Loop Loading
	// -----------------------------
	For ll_Loading_Count = 1 To dsLoading.RowCount()
		ll_Stowage_key = dsLoading.GetItemNumber(ll_Loading_Count, "cen_stowage_nstowage_key")
		ls_Find = "nstowage_key=" +String(ll_Stowage_key)
		ll_Found	= lds_Ramp_Box_Setting.Find(ls_Find, 1, lds_Ramp_Box_Setting.RowCount())
		If ll_Found > 0 Then
			ll_Setting = lds_Ramp_Box_Setting.GetItemNumber(ll_Found, "nbox")
			If NOT IsNULL(ll_Setting) Then
				// -----------------------------
				// Transfer Settting zo dsLoading
				// -----------------------------				
				li_Succ = dsLoading.SetItem(ll_Loading_Count,"nramp_box_mode", ll_Setting)  
				If ii_Do_NOT_Trace = 0 Then f_trace(ls_Find + " nramp_box_mode " + ls_Unit + " => " + String(ll_Setting))
			End if
		Else
			// No Entry for the Stowage for this Unit
			// Try Default Unit "*"
			ls_Find = "nstowage_key=" +String(ll_Stowage_key)
			ll_Found	= lds_Ramp_Box_Setting_Default.Find(ls_Find, 1, lds_Ramp_Box_Setting_Default.RowCount())
			If ll_Found > 0 Then
				ll_Setting = lds_Ramp_Box_Setting_Default.GetItemNumber(ll_Found, "nbox")
				If NOT IsNULL(ll_Setting) Then
					// -----------------------------
					// Transfer Settting to dsLoading
					// -----------------------------				
					li_Succ = dsLoading.SetItem(ll_Loading_Count,"nramp_box_mode", ll_Setting)  
					If ii_Do_NOT_Trace = 0 Then f_trace(ls_Find + " nramp_box_mode central => " + String(ll_Setting))
				End if
			End If						
		End if
	Next
End If

DESTROY	lds_Ramp_Box_Setting
DESTROY	lds_Ramp_Box_Setting_Default

Return 1

end function

public function long of_containerequipment (ref string ras_filename, string as_currentprinter, boolean ab_printdirectly);
/*
* Objekt: 	uo_client_label
* Methode:	of_ContainerEquipment (Function)
*
* Argument(e):
* string ref 		ras_FileName 			PDF dateiname
* string			as_CurrentPrinter		wohin soll gedruckt werden ?
* boolean 		ab_PrintDirectly 		Direktdruck
*
* Beschreibung:		Erstelle Transporter Cart Diagramm
*
* Aenderungshistorie:
* Version    Wer         Wann          Was und warum
*  1.0       M.N$$HEX1$$fc00$$ENDHEX$$ndel    08.05.2012    Erstellung
*  1.1       D.Bunk      19.12.2012    Anpassungen f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$fc00$$ENDHEX$$berarbeitetes PDF Handler Objekt
*
* Return: integer
*	1 	alles geklappt
*	0 	nicht geklappt
*	-1 fehler
*/

// hilfsvariable
Long 		ll_Ret

// hilfsvariable ausgabe-files
String 	ls_PdfFiles[]
Boolean 	lb_ErrorOnAcrobat
String 	ls_Out

// hilfsvariable datenpuffer
Long 		ll_FlightNumber
String		ls_Airline, ls_Suffix

uo_container_equipment_report luoContainerEquipment


// -----------------------------------------------------------
// Kein ResultKey = Fehler
// -----------------------------------------------------------
if isNull(this.lResultKey) or this.lResultKey = 0 then
   this.sErrorMessage = uf.translate("Flugdaten k$$HEX1$$f600$$ENDHEX$$nnen nicht ermittelt werden!")
   return -1
end if

// -----------------------------------------------------------
// Die Fluginformationen zum ResultKey einlesen
// -----------------------------------------------------------
if this.dsCenOut.RowCount() <= 0 then
   ll_Ret = this.dsCenOut.Retrieve(this.lResultKey)
   if this.dsCenOut.RowCount() <= 0 then
      this.sErrorMessage = uf.translate("Keine Flugdaten gefunden!")
      return -1
   elseif this.dsCenOut.RowCount() > 1 then
      this.sErrorMessage = uf.translate("Flugdaten konnten nicht ermittelt werden!")
      return -1
   end if
end if

// -----------------------------------------------------------
// Die Beladung ermitteln, bei Abfertigungsart DLV
// in cen_out_local_ssl (Der Scheich fliegt) nachschaun.
// -----------------------------------------------------------
if this.dsCenOut.GetItemString(1, "chandling_type_text") <> "DLV" then
   if this.of_get_standard_loading() <> 0 then
      this.sErrorMessage = uf.translate("Keine Standardbeladung gefunden!")
      return -1
   end if
else
   if this.of_get_local_standard_loading() <= 0 then
      this.sErrorMessage = uf.translate("Keine individuelle Standardbeladung gefunden!")
      return -1
   end if
end if

if this.ii_Do_NOT_Trace = 0 then
	this.dsLoading.saveas(f_gettemppath() + "ContainerEquipment_dsLoading_" + "000" + "-" + String(Rand(32767)) + String(now(), "hhmmss") + ".XLS", excel5!, True)
end if

// -----------------------------------------------------------
// jetzt sollten daten in dsLoading sein:
// aufbereiten
// -----------------------------------------------------------
if this.dsLoading.Rowcount() > 0 then
	ll_Ret = luoContainerEquipment.of_init(this.dsCenOut, this.dsLoading, this.lResultKeys)
	// init erfolgreich: bearbeiten
	if ll_Ret = 1 then
		ll_Ret = luoContainerEquipment.of_start(ls_PdfFiles)
	// init fehlerhaft
	else
		uf.mBox("", "Container & Equipment-Sheet konnte nicht initialisiert werden")
		if this.ii_Do_NOT_Trace = 0 then
		choose case ll_Ret
			case 0
				uf.mBox("Fehler", "Fehlende Flug- oder Beladedaten")
			case -1
				uf.mBox("Fehler", "Flugdaten konnten nicht $$HEX1$$fc00$$ENDHEX$$bergeben werden")
			case -2
				uf.mBox("Fehler", "Beladedaten konnte nicht $$HEX1$$fc00$$ENDHEX$$bergeben werden")
			case -3
				uf.mBox("Fehler", "Klassen konnten nicht gelesen werden")
			case -4
				uf.mBox("Fehler", "Equipment konnte nicht gelesen werden")
			case else
				uf.mBox("Fehler", "Fehler beim Initialisieren")
		end choose
		end if

	end if
end if

// -----------------------------------------------------------
// PDFs zusammenfassen
// -----------------------------------------------------------
// Erst mal pr$$HEX1$$fc00$$ENDHEX$$fen ob es etwas zum zusammenfassen gibt
if Upperbound(ls_PdfFiles) > 0 then
	// wenn progressfenster da: aktualisieren
	if isvalid(w_progress_with_cancel) then
		w_progress_with_cancel.wf_setstatus( uf.translate("Zusammenfassen")  )
	end if
	ls_Out =  ""      
	ras_FileName = f_gettemppath() + "CBASE-ContainerEquipment-" + "000" + "-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"

	// files zusammenfassen
	if s_app.uo_pdf.of_concatenate(ls_PdfFiles, ras_FileName, true) = 0 then
		ll_Ret =  1
	else
		ll_Ret = -1
		lb_ErrorOnAcrobat = true
		if this.ii_Do_NOT_Trace = 0 then
			f_trace("of_containerequipment MERGE lb_Error_on_Acrobat")
		end if
	end if
	// direkt drucken, wenn gewollt
	if ab_PrintDirectly  then
		s_app.uo_pdf.of_print(ras_FileName, as_CurrentPrinter)
	end if
		
// nix zum zusammenfassen da
	else
		if ll_Ret >= 0 then ll_Ret = 0
end if

return ll_Ret



end function

protected function long of_get_bestbefore_minutes (string as_client, string as_unit, long al_airlinekey);
/*
* Objekt: 	uo_client_label
* Methode:	of_get_bestbefore_minutes (Function)
*
* Argument(e):
*
* Beschreibung:		Wert f$$HEX1$$fc00$$ENDHEX$$r Offset zur Berechnung von Best Before holen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		29.05.2012		Erstellung
*
*
* Return: integer
*	long-wert
*/

// hilfsvariable
Long 	ll_BestBeforeMinutes = 0

// erstmal fest, was RUS nutzt (8400 = 140 stunden bzw. 5 tage, 20 stunden)
//ll_BestBeforeMinutes = long(ProfileInt(s_app.sProfile, this.classname(), "BestBeforeOffset", 8400))
ll_BestBeforeMinutes = 8400

SELECT nMinutes  
 INTO :ll_BestBeforeMinutes  
 FROM loc_unit_times_bb  
WHERE cClient = :as_Client
	AND cUnit = :as_Unit
	AND nAirline_Key = :al_AirlineKey
	AND dvalid_from <= :this.dDeparture
	AND dvalid_to >= :this.dDeparture;

if sqlca.sqlcode = 100 then
	ll_BestBeforeMinutes = 0
elseif sqlca.sqlcode < 0 then 	
	f_db_error(sqlca, "")
	ll_BestBeforeMinutes = 0
end if

return ll_BestBeforeMinutes

end function

public function integer of_product_log (s_product_log astr_log);DateTime	dtStamp


return 0 /// 

dtStamp = DateTime(Today(), Now())


INSERT INTO sys_product_log  
		( dtimestamp,   
		  nresult_key,   
		  ntransaction,   
		  nproduct,   
		  nduration,   
		  cworkstation,   
		  cuser,   
		  nlabel_quantity,   
		  ndistribution,   
		  clabel_areas )  
VALUES ( :dtStamp,   
		  :astr_log.lResultKey,   
		  :astr_log.lTransaction,   
		  :astr_log.lProduct,   
		  :astr_log.lDuration,   
		  :astr_log.sWorkstation,   
		  :astr_log.sUser,   
		  :astr_log.lLabelQuantity,   
		  :astr_log.lDistribution,   
		  :astr_log.sLabelAreas );
		  
		  
if sqlca.sqlcode = 0 then
	commit;
else
	// f_db_error(sqlca, "Log failed")
	rollback;
end if
	
return 0
end function

public function integer of_create_flight_documents (long al_result_key, string as_label_filter, ref uo_documents rauo_product, boolean ab_cart_diagram, boolean ab_contentsheet, boolean ab_tripticket, boolean ab_tr_cart, boolean ab_unassignedcarts, boolean ab_printdirectly, boolean ab_use_printer_allocation, string as_printer_cart_diagram, string as_printer_trip_ticket, string as_current_printer_1, string as_printer_tr_carts, string as_printer_content_spec);/*
* Objekt : uo_client_label
* Methode: of_create_flight_documents (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 02.08.2012
*
* Argument(e):
*	 		long				al_result_key						Flug
*	 		string			as_label_filter					Label Filter aus w_print_center
*	 ref	uo_documents	rauo_product						"erstellte Produkte" - aus & nach w_print_center
*	 		boolean			ab_cart_diagram
*	 		boolean			ab_contentsheet
*	 		boolean			ab_tripticket
*	 		boolean			ab_tr_cart
*	 		boolean			ab_unassignedcarts
*	 		boolean			ab_printdirectly					direkter Ausdruck
*	 		boolean			ab_use_printer_allocation		eigener Durcker je Dokumenttyp
*	 		string			as_printer_cart_diagram			Drucker f$$HEX1$$fc00$$ENDHEX$$r Cart Diagram
*	 		string			as_printer_trip_ticket			Drucker f$$HEX1$$fc00$$ENDHEX$$r Trip Ticket
*	 		string			as_current_printer_1				
*	 		string			as_printer_tr_carts				Drucker f$$HEX1$$fc00$$ENDHEX$$r TR Cart
*	 		string			as_printer_content_spec			Drucker f$$HEX1$$fc00$$ENDHEX$$r Content Spec
*
*
* Beschreibung:		Neue Funktion als Abl$$HEX1$$f600$$ENDHEX$$sung zu w_print_center.wf_create_ Cart / TR Cart / TripTicket / Content Spec
*
* Aenderungshistorie:
* Version    Wer         Wann          Was und warum
*  1.0       O.Hoefer    01.08.2012    Erstellung
*  1.1       D.Bunk      19.12.2012    Anpassungen f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$fc00$$ENDHEX$$berarbeitetes PDF Handler Objekt
*  1.2       O.Hoefer    14.01.2013    Keine Messagebox, wenn Content Spec failed (z.B wegen Std. Loading) 
*
* Return: integer
*
*/


String				ls_TT_File_Name
String				ls_TR_File_Name
String				ls_SP_File_Name
Boolean				lb_TT_Without_TR
Boolean				lb_manual_distr_done
Long					ll_Start, ll_Stop
Integer				li_return
Long					ll_Cart_Pages
String				ls_FBox_From, ls_fbox_to
String				ls_Compute_5
String				ls_airline
Integer 				iFlightNumber
String 				sFrom	, sTo, sTime , sRegistration, sOwner, sACType, sVersion, sSuffix, sStowage, sHeader
Long					ll_Routing_ID, ll_Watermark
Long					ll_transaction
long					ll_Airline_key
Long					ll_Leg_nr
String				ls_unit
String				ls_Distr_G,ls_Distr_S,ls_Distr_P, ls_Find_RowId
Long					ll_Count
String				ls_Printername
s_product_log		lstr_Log
//uo_distribution 	luo_Distribution


//luo_Distribution = CREATE uo_distribution

ids_TR_Exclusions = CREATE DataStore
ids_TR_Exclusions.DataObject = "dw_ext_3_cols"

ll_Start = CPU()

////-----------------------------------------------------------------
//// Acrobat Printer initialisieren (MB 13.05.2011, Citrix-Fehlerbehebung)
////-----------------------------------------------------------------
////wf_create_acrobat_init_cs( )
//// -------------------------------------------------------------------

This.lResultKey = al_result_key


select	cunit, nleg_number, cbox_from, cbox_to, nrouting_id, ntransaction, nflight_number , csuffix, ctlc_from, ctlc_to, ddeparture, cdeparture_time,cregistration,cairline_owner, cactype, cconfiguration, cairline, nairline_key
into		:ls_unit , :ll_Leg_nr, :ls_FBox_From, :ls_fbox_to, :ll_routing_ID, :ll_transaction, :iFlightNumber , :sSuffix, :sFrom, :sTo, :dDeparture, :sTime, :sRegistration, :sOwner, :sACType, :sVersion, :ls_airline, :ll_airline_key
from		cen_out 
where		nresult_key = :al_result_key;

// -------------------------------------------------------------------
// Cart Diagram 
// -------------------------------------------------------------------
If ab_cart_diagram OR ab_tr_cart OR ab_tripticket OR ib_Secondary_Distribution_ONLY Then
//	li_Return = of_create_cart_diagram( al_result_key, as_label_filter, rauo_product, luo_Distribution, & 
//					ab_cart_diagram, ab_contentsheet, ab_tripticket, ab_tr_cart, ab_unassignedcarts, ab_printdirectly, & 
//					ab_use_printer_allocation, as_printer_cart_diagram, as_current_printer_1)
	li_Return = of_create_cart_diagram( al_result_key, as_label_filter, rauo_product, & 
					ab_cart_diagram, ab_contentsheet, ab_tripticket, ab_tr_cart, ab_unassignedcarts, ab_printdirectly, & 
					ab_use_printer_allocation, as_printer_cart_diagram, as_current_printer_1)

End If
// -------------------------------------------------------------------
// End Cart Diagram 
// -------------------------------------------------------------------

If isvalid(uodistribution) then
	f_trace("of_create_flight_documents AFTER of_create_cart_diagram upperbound(uodistribution.uoStowages) " + String(upperbound(uodistribution.uoStowages)))
end if

//If isvalid(luo_Distribution) then
//	f_trace("of_create_flight_documents AFTER of_create_cart_diagram upperbound(luo_Distribution.uoStowages) " + String(upperbound(luo_Distribution.uoStowages)))
//end if


if ii_Do_NOT_Trace = 0 Then
//	If isvalid(luo_Distribution) then
//		For ll_Count = 1 To luo_Distribution.dsDistribution.RowCount()
//			ls_Distr_G = luo_Distribution.dsDistribution.GetItemString(ll_Count, "cen_galley_cgalley")
//			ls_Distr_S = luo_Distribution.dsDistribution.GetItemString(ll_Count, "cen_stowage_cstowage")
//			ls_Distr_P = luo_Distribution.dsDistribution.GetItemString(ll_Count, "cen_stowage_cplace")
//			If Isnull(ls_Distr_P) then ls_Distr_P = ""
//			If Trim(ls_Distr_P) = "" Then 
//				ls_Find_RowId = "cen_galley_cgalley='" + ls_Distr_G + "' AND cen_stowage_cstowage='" + ls_Distr_S + "'"
//			Else
//				ls_Find_RowId = "cen_galley_cgalley='" + ls_Distr_G + "' AND cen_stowage_cstowage='" + ls_Distr_S + "' and cen_stowage_cplace='" + ls_Distr_P + "'"
//			End If
//			f_trace("of_create_cartdiagram luo_Distribution.dsDistribution["+String(ll_Count)+"].sStowage " + ls_Find_RowId)
//		Next
//	End If
	
	If isvalid(uoDistribution) then
		For ll_Count = 1 To uoDistribution.dsDistribution.RowCount()
			ls_Distr_G = uoDistribution.dsDistribution.GetItemString(ll_Count, "cen_galley_cgalley")
			ls_Distr_S = uoDistribution.dsDistribution.GetItemString(ll_Count, "cen_stowage_cstowage")
			ls_Distr_P = uoDistribution.dsDistribution.GetItemString(ll_Count, "cen_stowage_cplace")
			If Isnull(ls_Distr_P) then ls_Distr_P = ""
			If Trim(ls_Distr_P) = "" Then 
				ls_Find_RowId = "cen_galley_cgalley='" + ls_Distr_G + "' AND cen_stowage_cstowage='" + ls_Distr_S + "'"
			Else
				ls_Find_RowId = "cen_galley_cgalley='" + ls_Distr_G + "' AND cen_stowage_cstowage='" + ls_Distr_S + "' and cen_stowage_cplace='" + ls_Distr_P + "'"
			End If
			f_trace("of_create_cartdiagram uoDistribution.dsDistribution["+String(ll_Count)+"].sStowage " + ls_Find_RowId)
		Next
	End If
End If


// -------------------------------------------------------------------
// TR Cart Diagram 
// -------------------------------------------------------------------
If ab_tr_cart = false and ab_tripticket = true then lb_TT_Without_TR = TRUE
lb_manual_distr_done = TRUE
If ab_tr_cart = TRUE OR lb_TT_Without_TR = TRUE Then
	f_trace("uo_ClientLabel.of_create_flight_documents BEFORE of_create_tr_cartdiagram")
	// Wenn Dokumententyp-spezifischer Drucker aktiv - > diesen verwenden ... TBR 20.06.2012
	IF ab_use_printer_allocation THEN
		ls_Printername = as_printer_tr_carts
	Else
		ls_Printername = as_current_printer_1
	End If
//	li_Return =	of_create_tr_cartdiagram(al_result_key , ls_TR_File_Name, ls_Unit ,&
//							iuseexclusion, this.lResultKeys, ls_Printername , as_Label_Filter, ab_PrintDirectly, &
//							ll_Cart_Pages, ids_tr_exclusions, ab_contentsheet, lb_manual_distr_done, lb_TT_Without_TR, luo_Distribution )
	li_Return =	of_create_tr_cartdiagram(al_result_key , ls_TR_File_Name, ls_Unit ,&
							iuseexclusion, this.lResultKeys, ls_Printername , as_Label_Filter, ab_PrintDirectly, &
							ll_Cart_Pages, ids_tr_exclusions, ab_contentsheet, lb_manual_distr_done, lb_TT_Without_TR )
	f_trace("uo_ClientLabel.of_create_flight_documents AFTER of_create_tr_cartdiagram")
	If li_Return >= 0 AND IsValid(iuo_tripticket) Then
		// Anzahl Pages
		iuo_tripticket.il_num_tr_carts = ll_Cart_Pages
	Else
		if ii_Do_NOT_Trace = 0 Then
			f_trace("uo_ClientLabel.of_create_tr_cartdiagram NO VALID TR CART ")
		end if
	End If
	
	If li_Return = 1 Then
		rauo_product.itrcartdiagram		= 1
		rauo_product.strcartdiagramfile	= ls_TR_File_Name
	Else
		rauo_product.itrcartdiagram		= 0
	End If
	
	If not fileexists(ls_TR_File_Name) Then
		rauo_product.itrcartdiagram		= 0
		rauo_product.strcartdiagramfile	= ""
	End If
	
	If ii_Do_NOT_Trace = 0 Then
		f_trace("uo_ClientLabel.of_create_cartdiagram AFTER of_create_tr_cartdiagram")
	End if
End If
// ------------------------------------------------------------
// End TR Cart Diagram
// ------------------------------------------------------------

// ------------------------------------------------------------
// Trip Ticket
// ------------------------------------------------------------
If NOT ib_Secondary_Distribution_ONLY Then
	If ab_Tripticket Then
		f_trace("uo_ClientLabel.of_create_cartdiagram BEFORE of_create_tripticket")
		// Wenn Dokumententyp-spezifischer Drucker aktiv - > diesen verwenden ... TBR 20.06.2012
		li_Return = iuo_tripticket.of_init(ll_airline_key)
		IF ab_use_printer_allocation THEN
			ls_Printername = as_printer_trip_ticket
		Else
			ls_Printername = as_current_printer_1
		End If
		li_Return = of_create_tripticket(al_result_key, ls_TT_File_Name, ls_Unit , iuseexclusion, this.lResultKeys, ls_Printername, &
													as_label_filter, ab_PrintDirectly, iuo_tripticket)	
		
		If li_Return = 1 Then
			rauo_product.itripticket		= 1
			rauo_product.stripticketfile	= ls_TT_File_Name
			if ii_Do_NOT_Trace = 0 Then
				f_trace("uo_ClientLabel.of_create_tripticket OK " + ls_TT_File_Name)
			End If
		Else
			if ii_Do_NOT_Trace = 0 then
				f_trace("uo_ClientLabel.of_create_tripticket RETURNS <> 1")
			end if
			rauo_product.itripticket		= 0
		End If
		f_trace("uo_ClientLabel.of_create_cartdiagram AFTER of_create_tripticket")
	End if
End If
// ------------------------------------------------------------
// Trip Ticket
// ------------------------------------------------------------


// ------------------------------------------------------------
// Content Sheet
// ------------------------------------------------------------
If NOT ib_Secondary_Distribution_ONLY Then
	If ab_Contentsheet Then
		ls_Compute_5 = ls_airline + string(  iFlightNumber ,"000" ) +  trim(ssuffix)
		ls_SP_File_Name = ls_Compute_5 + "_" + sFrom + "_" + sto + "_" +String( ddeparture, "YYYYMMDD")
		ls_SP_File_Name += "_SP_" + String(ll_transaction) + "_" + String(Rand(32000),"00000") + ".PDF"
		rauo_product.sContentsheet 	= f_gettemppath() + ls_SP_File_Name 
			
		li_Return = of_create_content_sheet(rauo_product.sContentsheet)
		if li_return = 0 then
			rauo_product.iContentsheet		= 1
			If ab_PrintDirectly  Then
				// Wenn Dokumententyp-spezifischer Drucker aktiv - > diesen verwenden ... TBR 20.06.2012
				IF ab_use_printer_allocation THEN
					ls_Printername = as_printer_content_spec
				Else
					ls_Printername = as_current_printer_1
				End If
				s_app.uo_pdf.of_print(rauo_product.sContentsheet, ls_Printername)						
			end if
		else
			rauo_product.iContentsheet		= 0
			If isnull(sErrorMessage) Then sErrorMessage = " "
			If Trim(sErrorMessage) > "" Then
				//	uf.mbox("Achtung", "Erstellung der Inhalts$$HEX1$$fc00$$ENDHEX$$bersicht fehlgeschlagen ~r~n${" + sErrorMessage + "}", Information!)
				f_trace("Creation of content spec failed: " + sErrorMessage)
			End If
		end if
		If not fileexists(rauo_product.sContentsheet) then
			rauo_product.iContentsheet		= 0
		end if
	End If
End if
// ------------------------------------------------------------
// End Content Sheet
// ------------------------------------------------------------

ll_Stop = CPU()

DESTROY	ids_TR_Exclusions

f_trace("uo_ClientLabel.of_create_flight_documents END")

Return li_Return


end function

protected function integer of_tr_cartdiagram_sheet (string arg_s_labelfilter, boolean ab_distribution);/*
* Objekt : uo_client_label
* Methode: of_tr_cartdiagram_sheet (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 29.07.2010
*
* Argument(e):
* string arg_s_labelfilter
*
* Beschreibung:		Angepasste Kopie von of_cartdiagram_sheet
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	29.07.2010		Erstellung
* 1.1 			O.Hoefer	04.03.2011		Hinzu: nRowId f$$HEX1$$fc00$$ENDHEX$$r Content Sheet
* 1.2 			O.Hoefer	06.02.2012		Stauorte NIEMALS zusammenfassen
* 1.3 			O.Hoefer	02.03.2012		Rampenboxermittlung ge$$HEX1$$e400$$ENDHEX$$ndert
* 1.4 			O.Hoefer	17.01.2013		Workstation Key hinzu
*
*
* Return: integer
*
*/



// -----------------------------------------------------------
// 
// Beladung ermitteln
// 
// -----------------------------------------------------------
Long			ll_Start, ll_Ende
Long			ll_Row, ll_NewRow 
Long			ll_Index, ll_Detail, ll_Belly
String		ls_Stowage, ls_Class
Long			ll_TR_Cart 
Long			ll_Rows
Long			ll_Catering_Leg
Long		   ll_rowid
Integer		li_succ
Long			ll_ramp_box_mode
Long			ll_count
Long			ll_WS_Key
String		ls_Area, ls_Workstation, ls_Loadinglist
String		ls_cpackinglist, ls_Ctext
String		ls_PL_unit


ll_Start = CPU()

dsCartdiagramsheet.reset()

If not isvalid(dsLoading) then 	
	DESTROY dsLoading
	dsLoading          = Create DataStore
	dsLoading.DataObject       = "dw_loading_list_result"
	dsLoading.SetTransObject(SQLCA)
else
	ll_count = dsLoading.rowcount()
end if

dsLoading.reset()


// -----------------------------------------------------------
// Kein ResultKey = Fehler
// -----------------------------------------------------------
if isNull(this.lResultKey) or this.lResultKey = 0 then
   sErrorMessage = uf.translate("Flugdaten k$$HEX1$$f600$$ENDHEX$$nnen nicht ermittelt werden!")
   return -1
end if

// -----------------------------------------------------------
// Die Fluginformationen die zum ResultKey geh$$HEX1$$f600$$ENDHEX$$ren einlesen
// -----------------------------------------------------------
if dsCenOut.RowCount() <= 0 then
   dsCenOut.Retrieve(this.lResultKey)
   if dsCenOut.RowCount() <= 0 then
      sErrorMessage = uf.translate("Keine Flugdaten gefunden!")
      return -1
   elseif dsCenOut.RowCount() > 1 then
      sErrorMessage = uf.translate("Flugdaten konnten nicht ermittelt werden!")
      return -1
   end if   
end if

// -----------------------------------------------------------
// Die Beladung ermitteln, bei Abfertigungsart DLV
// in cen_out_local_ssl (Der Scheich fliegt) nachschaun.
// -----------------------------------------------------------
if dsCenOut.GetItemString(1, "chandling_type_text") <> "DLV" then

   if this.of_get_standard_loading() <> 0 then
      sErrorMessage = uf.translate("Keine Standardbeladung gefunden!")
      return -1
   end if

else

   if this.of_get_local_standard_loading() <= 0 then
      sErrorMessage = uf.translate("Keine individuelle Standardbeladung gefunden!")
      return -1
   end if
   
end if
// -----------------------------------------------------------
// Die Lokalen Informationen zuspielen
// -----------------------------------------------------------	
this.of_add_workstations()

If Trim(arg_s_labelfilter) > "" Then
//	arg_s_labelfilter = "(" + arg_s_labelfilter + ") AND ( ntransporter_cart = 1)"
End If

// -----------------------------------------------------------
// Die Lokalen Rampenbox Settings ermitteln
// -----------------------------------------------------------	
bFill_Ramp_box_mode = TRUE
If bFill_Ramp_box_mode Then
	li_Succ = of_add_ramp_box_mode()
End If

// -------------------------------------
// Counter / RowId 
// -------------------------------------
For ll_Row = 1 to this.dsLoading.RowCount()
	ll_rowid	= ll_Row //this.dsLoading.GetItemNumber(ll_Row, "nrowid")
	li_Succ = dsLoading.SetItem(ll_Row, "nrowid", ll_rowid)
	if ii_Do_NOT_Trace = 0 then f_trace("of_cartdiagram_sheet RowId="  + String(ll_rowid) + " => Success " + String(li_Succ))
Next

ll_Rows = dsLoading.RowCount()
this.dsLoading.SetFilter(arg_s_labelfilter)
this.dsLoading.Filter()
ll_Rows = dsLoading.RowCount()
this.dsLoading.SetFilter("ntransporter_cart = 1")
this.dsLoading.Filter()
ll_Rows = dsLoading.RowCount()

If trim(arg_s_labelfilter) > "" then
	this.dsLoading.SetFilter(arg_s_labelfilter + " and ntransporter_cart = 1")
	this.dsLoading.Filter()
	ll_Rows = dsLoading.RowCount()
end if

// Alle Elemente durchgehen
For ll_Row = 1 to this.dsLoading.RowCount()
	ll_TR_Cart = this.dsLoading.GetItemNumber(ll_Row, "ntransporter_cart")
	if isnull(ll_TR_Cart) or ll_TR_Cart = 0 then
		continue
	end if
	ll_Catering_Leg	= this.dsLoading.GetItemNumber(ll_Row, "ncatering_leg")
   ll_Index				= this.dsLoading.GetItemNumber(ll_Row, "cen_packinglist_index_npackinglist_index_key")
   ll_Detail			= this.dsLoading.GetItemNumber(ll_Row, "cen_packinglists_npackinglist_detail_key")
   ls_Stowage			= this.dsLoading.GetItemString(ll_Row, "cen_galley_cgalley")  + "-" +  this.dsLoading.GetItemString(ll_Row, "cen_stowage_cstowage") + " " + this.dsLoading.GetItemString(ll_Row, "cen_stowage_cplace")
   ll_Belly				= this.dsLoading.GetItemNumber(ll_Row, "cen_loadinglists_nbelly_container")
   ls_Class				= this.dsLoading.GetItemString(ll_Row, "cen_loadinglists_cclass") 
   ls_Class				= this.dsLoading.GetItemString(ll_Row, "cclass1") 
   ls_Area 			   = this.dsLoading.GetItemString(ll_Row, "carea") 
   ls_Workstation		= this.dsLoading.GetItemString(ll_Row, "cworkstation_text") 
   ls_Loadinglist		= this.dsLoading.GetItemString(ll_Row, "cen_loadinglist_index_cloadinglist") 
	ls_cpackinglist	= this.dsLoading.GetItemString(ll_Row, "cen_packinglist_index_cpackinglist") 
	ls_ctext				= this.dsLoading.GetItemString(ll_Row, "cen_packinglists_ctext") 
	ls_pl_unit			=	this.dsLoading.GetItemString(ll_Row, "cen_packinglists_cunit") 

	SetNULL(ll_WS_Key)
	
	// Workstation Key?
	//ll_WS_Key
	select	lw.nworkstation_key 
	into		:ll_WS_Key
	from		loc_unit_workstation lw , loc_unit_areas la  
	where		lw.narea_key = la.narea_key
	and 		la.cunit = :sUnit
	and		la.carea = :ls_Area
	AND		lw.ctext = :ls_Workstation		;
	IF SQLCA.SQLCode <> 0 Then
		SetNULL(ll_WS_Key)
	End if
	

	// -------------------------------------
	// Content Sheet - Row Id
	// -------------------------------------
   ll_rowid	=	this.dsLoading.GetItemNumber(ll_Row, "nrowid")
	// -------------------------------------
	// 06.02.2012 WEB 374
	// Stauorte nicht zusammenfassen
	// -------------------------------------
	
	ll_NewRow = dsCartdiagramsheet.insertrow( 0)
	// -----------------------------------------------
	// Ramp Box Mode: 1 => Box From 2 => Box To
	// -----------------------------------------------
	ll_ramp_box_mode = dsLoading.GetItemNumber(ll_Row, "nramp_box_mode")		
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "nramp_box_mode", ll_ramp_box_mode) 
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "nindex_key", ll_Index)
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "ndetail_key", ll_Detail)
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "sstowage",ls_Stowage)
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "nbelly",ll_Belly)
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "sclass",ls_Class)
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "sarea",ls_Area)
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "sworkstation", ls_Workstation)
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "sloadinglist", ls_Loadinglist)
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "ncatering_leg", ll_catering_leg)	
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "spackinglist", ls_cpackinglist)
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "stext", ls_ctext)		
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "nsort_galley", dsLoading.GetItemNumber(ll_Row, "cen_galley_nsort"))	
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "nsort_stowage", dsLoading.GetItemNumber(ll_Row, "cen_stowage_nsort"))	
	li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "spl_unit", ls_pl_unit)
	If NOT IsNULL(ll_ws_key) Then
		li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "nworkstation_key", ll_ws_key) 
	End If
	// -------------------------------------
	// u.a. f$$HEX1$$fc00$$ENDHEX$$r Content Sheet: Row Id
	// -------------------------------------
	li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"nrowid", ll_rowid)
Next

//If ii_Do_NOT_Trace = 0 Then
//	dsCartdiagramsheet.saveas("c:\temp\cbase\TR_dsCartdiagramsheet_490_" + String(CPU()) + ".xls", Excel5!,true)
//End If

//this.dsLoading.SetFilter("")
//this.dsLoading.Filter()
//this.dsLoading.Sort()

If not isvalid(dsLoading) then 	
	//uf.mbox("Achtung", "dsLoading NOT valid!")
	f_trace("uo_client_label.of_tr_cartdiagram_sheet BEFORE if ab_distribution dsLoading IS NOT VALID")
end if

If ab_distribution = FALSE Then
	If ii_Do_NOT_Trace = 0 Then f_trace("uo_client_label.of_tr_cartdiagram_sheet SKIPPING of_distribution()")
Else
	If not isvalid(dsLoading) then 	
		//uf.mbox("Achtung", "dsLoading NOT valid!")
		f_trace("uo_client_label.of_tr_cartdiagram_sheet BEFORE of_distribution dsLoading IS NOT VALID")
	end if

	
	if this.of_distribution() = -1000 then
		// -----------------------------------------------------
		// -1000 = User hat Mahlzeitenverteilung abgebrochen
		//         dann soll alles beendet werden
		// -----------------------------------------------------
		If ii_Do_NOT_Trace = 0 Then f_trace("uo_client_label.of_tr_cartdiagram_sheet of_distribution() = -1000")
	
		If not isvalid(dsLoading) then 	
			//uf.mbox("Achtung", "dsLoading NOT valid!")
			f_trace("uo_client_label.of_tr_cartdiagram_sheet AFTER of_distribution() dsLoading IS NOT VALID")
		end if
		
		return -1000
	else
		If ii_Do_NOT_Trace = 0 Then f_trace("uo_client_label.of_tr_cartdiagram_sheet of_distribution() OK")
	
		If not isvalid(dsLoading) then 	
			//uf.mbox("Achtung", "dsLoading NOT valid!")
			f_trace("uo_client_label.of_tr_cartdiagram_sheet AFTER of_distribution() dsLoading IS NOT VALID")
		end if
				
	end if
End If

If not isvalid(dsLoading) then 	
	//uf.mbox("Achtung", "dsLoading NOT valid!")
	f_trace("uo_client_label.of_tr_cartdiagram_sheet BEFORE dsLoading.SetFilter() dsLoading IS NOT VALID")
Else
	this.dsLoading.SetFilter("")
	this.dsLoading.Filter()
	this.dsLoading.Sort()
End if

ll_Ende = CPU()

Return 0

end function

public function integer of_cartdiagram_sheet (string as_labelfilter, boolean ab_distribution);/*************************************************************
* Objekt : uo_client_label
* Methode: of_cartdiagram_sheet (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 19.08.2009
* Argument(e):
* none
*
* Return: integer
*
*
*
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  19.08.2009	1.0           Ulrich Paudler     Erstellung
*  27.10.2009	1.1           Ulrich Paudler     Belly und Class ermitteln
*  24.11.2009	1.2           Ulrich Paudler     Labelfilter anwenden
*  13.01.2010	1.3           Ulrich Paudler     Area & Workstation und Loadinglist hinzu
*  31.08.2011	1.4           Oliver H$$HEX1$$f600$$ENDHEX$$fer       Hinzu: Packinglist Nummer & Text
*  06.02.2013	1.5           Oliver H$$HEX1$$f600$$ENDHEX$$fer       Hinzu: TR Cart Switch
*
*************************************************************/


// -----------------------------------------------------------
// 
// Beladung ermitteln
// 
// -----------------------------------------------------------
Long			ll_Start, ll_Ende
Long			ll_Row, ll_Item, ll_NewRow, ll_FoundRow
Long			ll_Index, ll_Detail, ll_Belly
String		ls_Stowage, ls_Class, ls_Class_1
Integer		li_succ 
String		ls_pl_unit
Long			ll_catering_leg
Long			ll_rowid
Long			ll_ramp_box_mode
Long			ll_WS_Key
Long			ll_TR_Cart_Switch
String		ls_Area, ls_Workstation, ls_Loadinglist
String		ls_cpackinglist, ls_ctext
String		ls_Sort


ll_Start = CPU()


If ib_Enable_Masterdata_View Then
	as_Labelfilter = ""
End If

// -----------------------------------------------------------
// Kein ResultKey = Fehler
// -----------------------------------------------------------
if isNull(this.lResultKey) or this.lResultKey = 0 then
   sErrorMessage = uf.translate("Flugdaten k$$HEX1$$f600$$ENDHEX$$nnen nicht ermittelt werden!")	
	f_trace("uo_ClientLabel.of_cartdiagram_sheet Flugdaten k$$HEX1$$f600$$ENDHEX$$nnen nicht ermittelt werden!")
   return -1
end if

// -----------------------------------------------------------
// Die Fluginformationen die zum ResultKey geh$$HEX1$$f600$$ENDHEX$$ren einlesen
// -----------------------------------------------------------
if dsCenOut.RowCount() <= 0 then
   dsCenOut.Retrieve(this.lResultKey)
   if dsCenOut.RowCount() <= 0 then
      sErrorMessage = uf.translate("Keine Flugdaten gefunden!")
		f_trace("uo_ClientLabel.of_cartdiagram_sheet Keine Flugdaten gefunden!")
      return -1
   elseif dsCenOut.RowCount() > 1 then
      sErrorMessage = uf.translate("Flugdaten konnten nicht ermittelt werden!")
		f_trace("uo_ClientLabel.of_cartdiagram_sheet Flugdaten konnten nicht ermittelt werden!")
      return -1
   end if
end if

// -----------------------------------------------------------
// Die Beladung ermitteln, bei Abfertigungsart DLV
// in cen_out_local_ssl (Der Scheich fliegt) nachschaun.
// -----------------------------------------------------------
if dsCenOut.GetItemString(1, "chandling_type_text") <> "DLV" then

   if this.of_get_standard_loading() <> 0 then
      sErrorMessage = uf.translate("Keine Standardbeladung gefunden!")
		f_trace("uo_ClientLabel.of_cartdiagram_sheet Keine Standardbeladung gefunden!")
      return -1
   end if

else

   if this.of_get_local_standard_loading() <= 0 then
      sErrorMessage = uf.translate("Keine individuelle Standardbeladung gefunden!")
		f_trace("uo_ClientLabel.of_cartdiagram_sheet Keine individuelle Standardbeladung gefunden!")
      return -1
   end if
   
end if
// -----------------------------------------------------------
// Die Lokalen Informationen zuspielen
// -----------------------------------------------------------	
If not ib_Enable_Masterdata_View Then 
	this.of_add_workstations()
End If

// -----------------------------------------------------------
// Die Lokalen Rampenbox Settings ermitteln
// -----------------------------------------------------------	
bFill_Ramp_box_mode = TRUE
If bFill_Ramp_box_mode Then
	li_Succ = of_add_ramp_box_mode()
End If

// -------------------------------------
// Unterscheidung zu TR Sheet
// RowId erh$$HEX1$$f600$$ENDHEX$$hen
// -------------------------------------
For ll_Row = 1 to this.dsLoading.RowCount()
	ll_rowid	=	ll_row //this.dsLoading.GetItemNumber(ll_Row, "nrowid")
	ll_rowid += 1000000
	li_Succ = dsLoading.SetItem(ll_Row, "nrowid", ll_rowid)
	if ii_Do_NOT_Trace= 0 then
		f_trace("of_cartdiagram_sheet RowId="  + String(ll_rowid) + " => Success " + String(li_Succ))
	End If
Next

// 24.11.2009 Ulrich Paudler [UP]
this.dsLoading.SetFilter(as_labelfilter)
this.dsLoading.Filter()

// Alle Elemente durchgehen
For ll_Row = 1 to this.dsLoading.RowCount()
	// 19.08.2009 Ulrich Paudler [UP] Pr$$HEX1$$fc00$$ENDHEX$$fen ob index/detail schon vorhanden -> sstowage erweitern
	ll_Index				=	this.dsLoading.GetItemNumber(ll_Row, "cen_packinglist_index_npackinglist_index_key")
	ll_Detail			=	this.dsLoading.GetItemNumber(ll_Row, "cen_packinglists_npackinglist_detail_key")
	ls_Stowage			=	this.dsLoading.GetItemString(ll_Row, "cen_galley_cgalley")  + "-" +  this.dsLoading.GetItemString(ll_Row, "cen_stowage_cstowage") + " " + this.dsLoading.GetItemString(ll_Row, "cen_stowage_cplace")
	// 27.10.2009 Ulrich Paudler [UP]
	ll_Belly				=	this.dsLoading.GetItemNumber(ll_Row, "cen_loadinglists_nbelly_container")
	ls_Class				=	this.dsLoading.GetItemString(ll_Row, "cen_loadinglists_cclass") 
	ls_Class_1			=	this.dsLoading.GetItemString(ll_Row, "cclass1")   
	// 13.01.2010 Ulrich Paudler [UP] Area & Workstation hinzu
	SetNULL(ll_WS_Key)
	If not ib_Enable_Masterdata_View Then 
		ls_Area 			   =	this.dsLoading.GetItemString(ll_Row, "carea") 
		ls_Workstation		=	this.dsLoading.GetItemString(ll_Row, "cworkstation_text") 
		
		// Workstation Key?
		//ll_WS_Key
		select	lw.nworkstation_key 
		into		:ll_WS_Key
		from		loc_unit_workstation lw , loc_unit_areas la  
		where		lw.narea_key = la.narea_key
		and 		la.cunit = :sUnit
		and		la.carea = :ls_Area
		AND		lw.ctext = :ls_Workstation		;
		IF SQLCA.SQLCode <> 0 Then
			SetNULL(ll_WS_Key)
		End if
	
	Else
		ls_Area 			   =	""
		ls_Workstation		=	""
	End If
	ls_Loadinglist		=	this.dsLoading.GetItemString(ll_Row, "cen_loadinglist_index_cloadinglist") 
	ls_pl_unit			=	this.dsLoading.GetItemString(ll_Row, "cen_packinglists_cunit") 
	ls_cpackinglist	=	this.dsLoading.GetItemString(ll_Row, "cen_packinglist_index_cpackinglist") 
	ls_ctext				=  this.dsLoading.GetItemString(ll_Row, "cen_packinglists_ctext") 
	// Leg f$$HEX1$$fc00$$ENDHEX$$r Downline
	ll_catering_leg	=	this.dsLoading.GetItemNumber(ll_Row, "ncatering_leg")
	
	// Tr Cart Diagram Schalter
	//this.dsLoading.SetFilter(arg_s_labelfilter + " and ntransporter_cart = 1")
	ll_TR_Cart_Switch =	this.dsLoading.GetItemNumber(ll_Row, "ntransporter_cart")
	
	// -------------------------------------
	// Content Sheet - Row Id
	// -------------------------------------
   ll_rowid				=	this.dsLoading.GetItemNumber(ll_Row, "nrowid")

	ll_FoundRow = dsCartdiagramsheet.Find("nindex_key=" + String(ll_Index) + " AND ndetail_key=" +String(ll_Detail), 1, dsCartdiagramsheet.Rowcount()) 
  // nicht gefunden oder keine Zeile vorhanden
  if ll_FoundRow <= 0 then
      ll_NewRow = dsCartdiagramsheet.insertrow( 0)
		li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"spackinglist", ls_cpackinglist)
		li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"stext", ls_ctext)
      li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"nindex_key", ll_Index)
      li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"ndetail_key", ll_Detail)
      li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"sstowage",ls_Stowage)
		// 27.10.2009 Ulrich Paudler [UP]
		li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"nbelly",ll_Belly)
		li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"sclass",ls_Class)
		// 13.01.2010 Ulrich Paudler [UP]
		li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"sarea",ls_Area)
		li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"sworkstation",ls_Workstation)
		li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"sloadinglist",ls_Loadinglist)
		// Spezial: MUlti Area + WS????
		li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"smulti_ws_1", this.dsLoading.GetItemString(ll_Row, "carea_list"))
		li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"smulti_ws_2", this.dsLoading.GetItemString(ll_Row, "cws_list"))
		li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"sclass_1",ls_Class_1)
		li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"spl_unit",ls_pl_unit)
		li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"ncatering_leg",	ll_catering_leg)
		
		
		// -----------------------------------------------
		// TR Cart Switch
		// -----------------------------------------------
		li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"ntransporter_cart", ll_TR_Cart_Switch)
		
		// -----------------------------------------------
		// Ramp Box Mode: 1 => Box From 2 => Box To
		// -----------------------------------------------
		ll_ramp_box_mode = dsLoading.GetItemNumber(ll_Row, "nramp_box_mode")
		li_succ = dsCartdiagramsheet.setitem( ll_NewRow,"nramp_box_mode",	ll_ramp_box_mode)

		li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "nsort_galley", dsLoading.GetItemNumber(ll_Row, "cen_galley_nsort"))	
		li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "nsort_stowage", dsLoading.GetItemNumber(ll_Row, "cen_stowage_nsort"))	
		
		// -----------------------------------------------
		// Workstation Key
		// -----------------------------------------------
		If NOT IsNULL(ll_ws_key) Then
			li_succ = dsCartdiagramsheet.setitem( ll_NewRow, "nworkstation_key", ll_ws_key)	
		End If
		
		// -------------------------------------
		// Content Sheet - Row Id
		// -------------------------------------
		li_succ = dsCartdiagramsheet.setitem(ll_NewRow,"nrowid", ll_rowid)
		if ii_Do_NOT_Trace = 0 then f_trace("of_cartdiagram_sheet  dsCartdiagramsheet.setitem RowId="  + String(ll_rowid) + " => Success " + String(li_Succ))
   else
      ls_Stowage = ls_Stowage + "," + dsCartdiagramsheet.getitemstring( ll_FoundRow,"sstowage")
      dsCartdiagramsheet.setitem( ll_FoundRow,"sstowage",ls_Stowage)
   end if
Next

// ---------------------------------------------------------
// wenn keine Area / Workstation vorhanden, dann Sort by Galley/Stauort
// ---------------------------------------------------------
If ib_enable_masterdata_view Then
	//li_Succ = This.dsCartdiagramSheet.SetSort("nclass_number ASC, nsort_galley ASC, nsort_stowage ASC, Sstowage ASC, sworkstation ASC, sloadinglist ASC")
	li_Succ = This.dsCartdiagramSheet.SetSort("nsort_galley ASC, nsort_stowage ASC, sloadinglist ASC")
	li_Succ = This.dsCartdiagramSheet.Sort()
	
//	ls_Sort = dsCartdiagramSheet.Describe("DataWindow.Table.Sort")
//	f_trace("of_cartdiagram_sheet ds_CartdiagramSheet.Sort " + ls_Sort)
	
End If

	ls_Sort = dsCartdiagramSheet.Describe("DataWindow.Table.Sort")
	f_trace("of_cartdiagram_sheet ds_CartdiagramSheet.Sort " + ls_Sort)


// ---------------------------------------------------------
// 05.07.2010 Klaus F$$HEX1$$f600$$ENDHEX$$rster
// Filter wieder resetten, da sonst die MZV // nicht alle Stauorte zur Verf$$HEX1$$fc00$$ENDHEX$$gung hat.
// ---------------------------------------------------------
this.dsLoading.SetFilter("")
this.dsLoading.Filter()
this.dsLoading.Sort()
// 22.10.2009 Ulrich Paudler [UP]

If ii_Do_NOT_Trace = 0 Then f_trace("uo_client_label.of_cartdiagram_sheet BEFORE of_distribution()")

If ab_distribution = FALSE Then
	If ii_Do_NOT_Trace = 0 Then f_trace("uo_client_label.of_cartdiagram_sheet SKIPPING of_distribution()")
Else
	if this.of_distribution() = -1000 then
		// -----------------------------------------------------
		// -1000 = User hat Mahlzeitenverteilung abgebrochen
		//         dann soll alles beendet werden
		// -----------------------------------------------------
		If ii_Do_NOT_Trace = 0 Then f_trace("uo_client_label.of_cartdiagram_sheet of_distribution() = -1000")	
		Return -1000
	else
		If ii_Do_NOT_Trace = 0 Then f_trace("uo_client_label.of_cartdiagram_sheet of_distribution() OK")
	end if
End If

ll_Ende = CPU()

If ii_Do_NOT_Trace = 0 Then
	if isvalid(uoDistribution) then
		f_trace("of_cartdiagram_sheet AFTER of_distribution upperbound(uodistribution.uoStowages) " + String(upperbound(uodistribution.uoStowages)))
	End If
End If

Return 0

end function

protected function integer of_create_tr_cart_diagram_cs_distr (boolean ab_content_sheet, long al_row, s_component astr_component_single, ref uo_distribution rauo_distribution, string as_stowage, ref uo_cart_diagram rauo_cart_diagram, ref string ras_distribution_items[]);/*
* Objekt : uo_client_label
* Methode: of_create_tr_cart_diagram_cs_distr (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 23.08.2012
*
* Argument(e):
*	 boolean ab_content_sheet
*	 long al_row
*	 s_component astr_component_single
*	 ref uo_distribution rauo_distribution
*	 string as_stowage
*	 ref uo_cart_diagram rauo_cart_diagram
*	 ref string ras_distribution_items[]
*
* Beschreibung:		TR Cart - Content Sheet: "Header" und verteilte Komponenten nach Content Sheet $$HEX1$$fc00$$ENDHEX$$bertragen 
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	23.08.2012		Erstellung
* 1.1 			O.Hoefer	16.10.2012		CBASE-NAM-CR-12049-TR Cart / All Settings can be combined for both Diagram types
*
*
* Return: integer
*
*/

Integer		li_Succ
Long			ll_RowId, ll_Content_Header_Detail_Key, ll_New_Row, ll_Header_Sort_Counter
Long			ll_Distr_Stowage_Counter, ll_Distr_Counter
Long			ll_Qty, ll_comp_pos, ll_Sort_Counter
String		ls_temp_content, ls_Loading_Header_PL, ls_Temp_Stowage
String		ls_Empty[]
String		ls_Content_Sort_OLD, ls_Content_Sort
String		ls_Value_A, ls_Value_B, ls_temp_content_pl
String		ls_Temp
s_component	lstr_Empty, lstr_component_single
s_distrib_items	lstr_Distributed_Items[], lstr_Empty_Array[]

// --------------------------------------------------------------
// Content Sheet - "Header"
// --------------------------------------------------------------
If ab_Content_sheet Then
	If Isvalid(iuoContentSheet) Then
		ll_RowId = dsCartdiagramSheet.GetItemNumber(al_Row , "nrowid")
		ll_New_Row = iuoContentSheet.dsLoadingHeader.InsertRow(0)
		li_Succ = iuoContentSheet.dsLoadingHeader.SetItem(ll_New_Row, "ndetail_key", ll_New_Row)
		ll_Content_Header_Detail_Key = ll_New_Row
		li_Succ = iuoContentSheet.dsLoadingHeader.SetItem(ll_New_Row, "nrowid", ll_RowId)
		ls_temp_content = astr_component_single.ssnr
		ls_Loading_Header_PL = ls_temp_content
		li_Succ = iuoContentSheet.dsLoadingHeader.SetItem(ll_New_Row, "cpackinglist", ls_temp_content)
		if ii_Do_NOT_Trace= 0 then
			f_trace("uo_Client_Label.of_create_tr_cartdiagram content sheet MASTER " + ls_temp_content)
		End If
		ls_temp_content = astr_component_single.stext
		li_Succ = iuoContentSheet.dsLoadingHeader.SetItem(ll_New_Row, "ctext", ls_temp_content)
		li_Succ = iuoContentSheet.dsLoadingHeader.SetItem(ll_New_Row, "nquantity", 1)
		ll_Header_Sort_Counter++
		li_Succ = iuoContentSheet.dsLoadingHeader.SetItem(ll_New_Row, "nsort", ll_Header_Sort_Counter)
	End If
End If			

// --------------------------------------------------------
// Beginn verteilte Komponenten nach Content Sheet $$HEX1$$fc00$$ENDHEX$$bertragen 				
// --------------------------------------------------------
If ab_Content_sheet Then
	If IsValid(rauo_distribution) Then
		If Isvalid(iuoContentSheet) Then
			ras_Distribution_Items = ls_Empty
			lstr_Distributed_Items = lstr_Empty_Array
			ll_RowId = dsCartdiagramSheet.GetItemNumber(al_Row , "nrowid")
			For ll_Distr_Stowage_Counter = 1 To upperbound(rauo_distribution.uoStowages) 
				// Richtiger Stauort?
				ls_Temp_Stowage = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].sStowage
				If Trim(as_Stowage) = Trim(ls_Temp_Stowage) Then 
					
					if ii_Do_NOT_Trace= 0 then
						f_trace("uo_client_label.of_create_tr_cartdiagram FOUND Stowage " + as_Stowage + " => " + rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].sStowage)
					End If
					
					// ------------------------------------------------------------------------
					// Konsolidieren
					// ------------------------------------------------------------------------
					If rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.RowCount() > 1 Then
						//For ll_Distr_Counter = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.RowCount() to 2 step -1
						ll_Distr_Counter = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.RowCount()
						// Sortieren nach PL / Text
						ls_Content_Sort_OLD = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.Object.DataWindow.Table.Sort
						ls_Content_Sort = "cpackinglist A, ctext A"
						li_Succ = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.SetSort(ls_Content_Sort)
						li_Succ = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.Sort()							
						do while ll_Distr_Counter > 1
							ls_Value_A =	rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.GetItemString(ll_Distr_Counter, "ctext") + &
											rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.GetItemString(ll_Distr_Counter, "cpackinglist")
							ls_Value_B =	rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.GetItemString(ll_Distr_Counter - 1, "ctext") + &
											rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.GetItemString(ll_Distr_Counter -1 , "cpackinglist")
							If ls_Value_A = ls_Value_B then
								If rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.GetItemNumber(ll_Distr_Counter, "nquantity") > 0 then
									rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.SetItem(ll_Distr_Counter - 1, "nquantity", &
																	rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.GetItemNumber(ll_Distr_Counter    , "nquantity") + &
																	rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.GetItemNumber(ll_Distr_Counter - 1, "nquantity"))
								End If
								li_Succ = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.deleterow(ll_Distr_Counter)
							End If
							ll_Distr_Counter -=1 
						loop
						// Alte Sortierung wiederherstellen
						li_Succ = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.SetSort(ls_Content_Sort_OLD)
						li_Succ = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.Sort()							
					End If
					// ------------------------------------------------------------------------
					// Konsolidieren
					// ------------------------------------------------------------------------
					For ll_Distr_Counter = 1 To rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.RowCount()
						ll_New_Row = iuoContentSheet.dsLoadingContents.InsertRow(0)
						li_Succ = iuoContentSheet.dsLoadingContents.SetItem(ll_New_Row, "nrowid", ll_RowId)
						li_Succ = iuoContentSheet.dsLoadingContents.SetItem(ll_New_Row, "ndetail_key", ll_Content_Header_Detail_Key)
						if ii_Do_NOT_Trace= 0 then
							f_trace("uo_client_label.of_create_tr_cartdiagram content sheet aus DISTRIBUTION Stowage " + rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].sStowage)
						End If
						ls_temp_content_pl = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.GetItemString(ll_Distr_Counter , "cpackinglist")
						li_Succ = iuoContentSheet.dsLoadingContents.SetItem(ll_New_Row, "cpackinglist", ls_temp_content_pl)
						ls_temp_content = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.GetItemString(ll_Distr_Counter , "ctext")
						li_Succ = iuoContentSheet.dsLoadingContents.SetItem(ll_New_Row, "ctext", ls_temp_content)						
						ll_Qty = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.GetItemNumber(ll_Distr_Counter , "nquantity")
						li_Succ = iuoContentSheet.dsLoadingContents.SetItem(ll_New_Row, "nquantity", ll_Qty)
						lstr_component_single = lstr_Empty
						lstr_component_single.ssnr			= ls_temp_content_pl
						lstr_component_single.stext		= ls_temp_content
						lstr_component_single.lquantity	= ll_Qty
						lstr_component_single.squantity	= String(ll_Qty)
						ls_Temp = rauo_cart_diagram.of_get_item_description(lstr_component_single)	
						ras_Distribution_Items[upperbound(ras_Distribution_Items) + 1] = ls_Temp
					
						ll_comp_pos = upperbound(lstr_Distributed_Items) + 1
						lstr_Distributed_Items[ll_comp_pos].cpackinglist = ls_temp_content_pl
						lstr_Distributed_Items[ll_comp_pos].ctext        = ls_temp_content
						lstr_Distributed_Items[ll_comp_pos].lcount       = ll_Qty
						lstr_Distributed_Items[ll_comp_pos].sitem        = ls_Temp
					
						if ii_Do_NOT_Trace= 0 then
							f_trace("uo_client_label.of_create_tr_cartdiagram TR Distr Content aus DISTRIBUTION " + ls_temp)
						End If
						ll_Sort_Counter++
						li_Succ = iuoContentSheet.dsLoadingContents.SetItem(ll_New_Row, "nsort", ll_Sort_Counter)
					Next
				Else
					if ii_Do_NOT_Trace= 0 then
						f_trace("uo_client_label.of_create_tr_cartdiagram WRONG Stowage " + as_Stowage + " => " + rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].sStowage)
					End If
				End If
			Next
		End If
	End If
End If				
// ------------------------------------------------------
// Ende verteilte Komponenten nach Content Sheet $$HEX1$$fc00$$ENDHEX$$bertragen 				
// ------------------------------------------------------


Return 1
end function

protected function integer of_create_tr_diagram_empty (long al_empty_page, boolean ab_tt_without_tr, ref long ral_trcartpages, ref uo_cart_diagram rauo_cart_diagram, long al_trcartpagesmax, ref string ras_pdffiles[], string as_currentprinter, string as_airline, long al_flight_number, long al_belly, string as_dep_time, string as_suffix, string as_header, string ls_from, string ls_to, string ls_ac_type, string as_container, string as_owner, string as_config, string as_area, string as_workstation, string as_multi_ws_1, string as_loadinglist, long al_legnumber, string as_class, long al_cart_counter, string as_cbox_from, string as_cbox_to, long al_airline_key, long al_routing_id, string as_unit, string as_ramp_time, string as_kitchen_time, string as_ops, string as_production_range, ref long ral_filecounter);/*
* Objekt : uo_client_label
* Methode: of_create_tr_diagram_empty (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.01.2013
*
* Argument(e):
* none
*
* Beschreibung:		Empty Page
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.01.2013		Erstellung
*
*
* Return: none
*
*/



Integer	li_Succ
Blob		lbBlob
Long		ll_Watermark
Integer	li_Min_OffSet
Long		ll_FullState
String	ls_currentpage
String	ls_stowage, ls_RampBox, ls_Temp, sStowageTmp
String	ls_packinglist, ls_pl_description, ls_Loadinglist

DataStore lds_TR_Cart_Print

lds_TR_Cart_Print = CREATE DataStore

// -----------------------------------------------------------
// Drucke Leere Seite
// -----------------------------------------------------------
ral_TRCartPages++
//Variable Daten im Datawindow f$$HEX1$$fc00$$ENDHEX$$llen (und Result Key suchen)
rauo_cart_diagram.of_print_prepare(as_CurrentPrinter , as_Airline , al_Flight_Number , as_Suffix, as_Header, ls_From, ls_To, ls_AC_Type, ls_Stowage, &
										ral_TRCartPages, al_Belly, dDeparture, as_Dep_Time, as_Class, as_Container, as_Owner, as_Config, as_Area, as_Workstation, as_Loadinglist, al_LegNumber)
rauo_cart_diagram.of_print_init()
// --------------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r neuen Header / Footer: weitere Values erg$$HEX1$$e400$$ENDHEX$$nzen
// --------------------------------------------------------------
ls_currentpage				= String(al_Empty_Page) + "/" + String(al_TRCartPagesMax )
as_Workstation				= as_Area + "-" + as_Workstation
If NOT Isnull(as_Multi_WS_1) AND Trim(as_Multi_WS_1) > "" Then
	as_Workstation = as_Multi_WS_1		
End If
ls_RampBox					= ""
ls_Temp = as_cbox_from
If NOT Isnull(ls_temp) Then ls_rampbox = ls_Temp
ls_Temp = as_cbox_to
If NOT Isnull(ls_temp) Then ls_rampbox += " - " + ls_Temp
ls_packinglist				= "" 
ls_pl_description			= rauo_cart_diagram.of_get_container_short_name()
ls_stowage					= "TR " + String(al_Cart_Counter, "00")
ls_Loadinglist = " "
rauo_cart_diagram.of_print_prepare_new_h_f(ls_Loadinglist, ls_packinglist, ls_pl_description, ls_rampbox, ls_stowage, &
												as_Class, as_Workstation, ls_currentpage, FALSE)
ll_Watermark = rauo_cart_diagram.of_get_watermark_type(al_Airline_key, al_Routing_ID, as_unit)
If ll_Watermark <> -1 Then
	li_Succ = rauo_cart_diagram.of_draw_watermark(ll_Watermark, al_Flight_Number , as_Ramp_Time , as_Kitchen_Time , as_Ops, as_class, as_Production_Range ,&
				al_airline_key, as_unit, al_routing_id , TRUE)
End If				
li_Min_OffSet = rauo_cart_diagram.of_get_min_offset("detail", FALSE) 
If li_Min_OffSet > 10 then li_Min_OffSet -= 5
rauo_cart_diagram.of_move_objects("detail", - li_Min_OffSet , 0, FALSE)	
rauo_cart_diagram.of_move_to_background(FALSE)
if ii_Do_NOT_Trace=0 then
	//li_Succ = rauo_cart_diagram.ods.saveas(f_gettemppath() + "XXX_CBASE-TRCARTEMPTY-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PSR", PSReport!, True)
End If			
ll_FullState = rauo_cart_diagram.of_getfullstate(lbBlob)
ll_FullState = Len  ( lbBlob)
ll_FullState = lds_TR_Cart_Print.SetFullState(lbBlob)

li_Succ = rauo_cart_diagram.of_clean_tr_diagram( lds_TR_Cart_Print)
				
if s_app.iTrace = 1 then
	if Pos(ls_Stowage, "*") > 0 then
		sStowageTmp =  replace(ls_Stowage, pos(ls_Stowage, "*"), 1, "x")
	else
		sStowageTmp = ls_Stowage  
	end if
	lds_TR_Cart_Print.saveas( f_gettemppath() + sStowageTmp + "-Datawindow.PSR", PSReport!, True)
	//sTempFilesToDelete[Upperbound(sTempFilesToDelete[]) + 1] = f_gettemppath() + sStowageTmp + "-Datawindow-2.PSR"
end if
ral_FileCounter++
ras_PdfFiles[ral_FileCounter] = f_gettemppath() + "CBASE-TRCARTEMPTY-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"

// ------------------------------------------------------
// Nicht drucken, wenn nur TripTicket ben$$HEX1$$f600$$ENDHEX$$tigt
// ------------------------------------------------------
If NOT ab_TT_Without_TR Then
	li_Succ = of_create_acrobat(lds_TR_Cart_Print, ras_PdfFiles[ral_FileCounter])
End If			

If li_Succ = -1 Then
	//lB_Error_on_Acrobat = TRUE
	if ii_Do_NOT_Trace= 0 then
		f_trace("of_create_tr_cartdiagram lb_Error_on_Acrobat")
	End If
End If		

DESTROY 	lds_TR_Cart_Print

Return 1

end function

public function integer of_get_flight_details (long al_result_key, ref long ral_flight_number, ref string ras_suffix, ref string ras_from, ref string ras_to, ref long ral_airline_key, ref string ras_airline, ref string ras_ac_type, ref string ras_dep_time, ref string ras_ramp_time, ref string ras_unit, ref long ral_leg_number, ref long ral_routing_id, ref string ras_owner, ref string ras_config, ref string ras_cbox_from, ref string ras_cbox_to, ref string ras_kitchen_time, ref long ral_transaction, ref string ras_tail_no);/*
* Objekt : uo_client_label
* Methode: of_get_flight_details (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 23.08.2012
*
* Argument(e):
* long al_result_key
*	 ref long ral_flight_number
*	 ref string ras_suffix
*	 ref string ras_from
*	 ref string ras_to
*	 ref long ral_airline_key
*	 ref string ras_airline
*	 ref string ras_ac_type
*	 ref string ras_dep_time
*	 ref string ras_ramp_time
*	 ref string ras_unit
*	 ref long ral_leg_number
*	 ref long ral_routing_id
*	 ref string ras_owner
*	 ref string ras_config
*	 ref string ras_cbox_from
*	 ref string ras_cbox_to
*	 ref string ras_kitchen_time
*	 ref long ral_transaction
*	 ref string ras_tail_no
*
* Beschreibung:		Read Flight Info
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	23.08.2012		Erstellung
*
*
* Return: integer
*
*/


SELECT nflight_number,   
		csuffix,   
		ctlc_from,   
		ctlc_to,   
		nairline_key,   
		cairline,   
		cactype,   
		ddeparture,   
		cdeparture_time,   
		cramp_time,   
		cunit,   
		nleg_number  ,
		nrouting_id,
		cairline_owner,
		cconfiguration,
		cbox_from,
		cbox_to,
		ckitchen_time,
		ntransaction,
		cregistration
 INTO :ral_Flight_Number,   
		:ras_Suffix,   
		:ras_From,   
		:ras_To,   
		:ral_Airline_key,   
		:ras_Airline,   
		:ras_AC_Type,   
		:ddeparture,   
		:ras_Dep_Time,   
		:ras_Ramp_Time,   
		:ras_Unit,   
		:ral_Leg_Number  ,
		:ral_Routing_ID,
		:ras_Owner,
		:ras_Config,
		:ras_cbox_from,
		:ras_cbox_to,
		:ras_Kitchen_Time,
		:ral_transaction,
		:ras_Tail_No
 FROM cen_out 
 WHERE nresult_key = :al_result_key;
 
 Return 1
end function

public function integer of_create_tripticket_class (long al_count_pl, string as_class, string as_tt_class_1, string as_tt_class_2, string as_tt_class_3, string ls_unitarea, ref datastore radstripticket, ref uo_tripticket rauo_tripticket, ref long ral_tt_row);/*
* Objekt : uo_client_label
* Methode: of_create_tripticket_class (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 23.08.2012
*
* Argument(e):
*	 long al_count_pl
*	 string as_class
*	 string as_TT_Class_1
*	 string as_TT_Class_2
*	 string as_TT_Class_3
*	 string ls_unitarea
*	 ref datastore radstripticket
*	 ref uo_tripticket rauo_tripticket
*
* Beschreibung:		Sortiere Inhalt je nach Klasse in Spalte 1,2,3
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	23.08.2012		Erstellung
*
*
* Return: integer
*
*/


Integer	li_Succ
Long		ll_found
String	ls_Find
String	ls_Temp
String	ls_Error


If as_class = as_TT_Class_1 Then
	// Find the first Row for Current sunitarea where PL is empty									
	ls_Find = "sunitarea='" + ls_Unitarea + "' AND isnull(spl_1)" 
	ll_found = radsTripTicket.Find(ls_Find, 1, radsTripTicket.RowCount())
	If ll_found > 0 Then
		ral_TT_Row = ll_Found
	Else
		ral_TT_Row = radsTripTicket.InsertRow(0)
	End If
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"sclass1" ,  as_class)
	ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(al_Count_PL, "sstowage_pos")
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"sstowage1" ,  ls_Temp)
	ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(al_Count_PL, "spl_nr")
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"spl_1" ,  ls_Temp)
	ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(al_Count_PL, "spl_text")
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"spl_text1" ,  ls_Temp)
	ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(al_Count_PL, "scart_type")
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"stype_1" ,  ls_Temp)
	
ElseIf as_class = as_TT_Class_2 Then
	ls_Find = "sunitarea='" + ls_Unitarea + "' AND isnull(spl_2)" 
	ll_found = radsTripTicket.Find(ls_Find, 1, radsTripTicket.RowCount())
	If ll_found > 0 Then
		ral_TT_Row = ll_Found
	Else
		ral_TT_Row = radsTripTicket.InsertRow(0)
	End If
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"sclass2" ,  as_class)
	ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(al_Count_PL, "sstowage_pos")
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"sstowage2" ,  ls_Temp)
	ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(al_Count_PL, "spl_nr")
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"spl_2" ,  ls_Temp)
	ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(al_Count_PL, "spl_text")
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"spl_text2" ,  ls_Temp)									
	ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(al_Count_PL, "scart_type")
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"stype_2" ,  ls_Temp)

ElseIf as_class = as_TT_Class_3 Then
	ls_Find = "sunitarea='" + ls_Unitarea + "' AND isnull(spl_3)" 
	ll_found = radsTripTicket.Find(ls_Find, 1, radsTripTicket.RowCount())
	If ll_found > 0 Then
		ral_TT_Row = ll_Found
	Else
		ral_TT_Row = radsTripTicket.InsertRow(0)
	End If
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"sclass3" ,  as_class)
	ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(al_Count_PL, "sstowage_pos")
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"sstowage3" ,  ls_Temp)
	ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(al_Count_PL, "spl_nr")
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"spl_3" ,  ls_Temp)
	ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(al_Count_PL, "spl_text")
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"spl_text3" ,  ls_Temp)
	ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(al_Count_PL, "scart_type")
	li_Succ = radsTripTicket.SetItem(ral_TT_Row,"stype_3" ,  ls_Temp)

Else
	// Error
	ls_error = "wrong class " + as_class
	//uf.mbox("Wrong Class" , ls_Temp )
	Return -1
End If


Return 1
end function

public function integer of_create_tr_cartidagram_main (long al_row, ref uo_cart_diagram rauo_cart_diagram, long al_airline_key, string as_unit, string as_dep_time, long al_routing_id, ref datastore rads_backlog, ref datastore rads_cartdiagram, ref uo_tr_cart_allocation rauo_tr_alloc, boolean ab_content_sheet, ref uo_distribution rauo_distribution, boolean ab_tt_without_tr, long al_catering_leg, long al_trcartpagesmax, ref long ral_cart_counter, long al_highest_class, string as_highest_class, string as_currentprinter, string as_airline, long al_flight_number, string as_suffix, string as_header, string as_from, string as_to, string as_ac_type, string as_owner, string as_config, string as_production_range, string as_ops, string as_ramp_time, string as_kitchen_time, ref long ral_filecounter, ref string ras_pdffiles[], string as_cbox_from, string as_cbox_to, long al_leg_number, ref boolean rab_first, ref long ral_trcartpages);/*
* Objekt : uo_client_label
* Methode: of_create_tr_cartidagram_main (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 27.08.2012
*
* Argument(e):
* none
*
* Beschreibung:		Main Action - Draw TR Cart Content  (Drawer)
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	27.08.2012		Erstellung
* 1.1 			O.Hoefer	16.10.2012		CBASE-NAM-CR-12049-TR Cart / All Settings can be combined for both Diagram types
*
*
* Return: none
*
*/


Blob			lb_Blob
Integer		li_Succ
Integer		li_Min_OffSet
Integer		li_Succ_Comp
Boolean		lb_Group_Break				= FALSE
Boolean		lb_Error_on_Acrobat		= FALSE
Boolean		lb_Watermark_Changed		= FALSE
Boolean		lb_Explode
Long			llIndexKey, llDetailKey, llBelly
Long			ll_Page
Long			ll_Cart_Row
Long			ll_Cart_Number
Long			ll_Column
Long			ll_Color_Background
Long			ll_Catering_Leg
Long			ll_Empty_Page
Long			ll_Found
Long			ll_TT_Row
Long			ll_temp
Long			ll_Watermark
Long			ll_Class_Number
Long			ll_FullState
Long				ll_Empty[]
Long				ll_TR_Page, ll_TR_Cart_No, ll_TR_Column, ll_TR_Rung
DateTime			ldt_Modified
String			ls_Area, 	ls_Workstation, ls_Multi_WS_1, ls_Multi_WS_2
String			ls_Loadinglist, ls_Stowage, ls_Class, ls_Production_Range
String			ls_PL_Text
String			ls_packinglist, ls_pl_description
String			ls_Drawer_Text
String			ls_Find
String			ls_currentpage
String			ls_Container
String			ls_Dummy
String			ls_RampBox
String			ls_Distribution_Items[]
String			ls_Suppressed_Items[], ls_Empty[]
DataStore		lds_TR_Cart_Print	
s_component		lstr_component_single
s_component		lstr_Empty


lds_TR_Cart_Print = CREATE DataStore

ls_Area		   = ""
ls_Workstation	= ""
if isvalid(w_progress_with_cancel) then
	// wurde abgebrochen?
	if w_progress_with_cancel.bCancel then
		return -1000
	end if
	w_progress_with_cancel.wf_setposition(al_Row)
	w_progress_with_cancel.wf_setstatus( uf.translate("Seite ") +  string(ral_TRCartPages) )
end if

llIndexKey 			= This.dsCartdiagramSheet.GetItemNumber(al_Row, "lindex_key")
llDetailKey 		= This.dsCartdiagramSheet.GetItemNumber(al_Row, "ldetail_key")
llBelly 				= This.dsCartdiagramSheet.GetItemNumber(al_Row, "nbelly")
ls_Class				= This.dsCartdiagramSheet.GetItemString(al_Row, "sclass")
ls_Area 				= This.dsCartdiagramSheet.GetItemString(al_Row, "sarea")
ls_Workstation		= This.dsCartdiagramSheet.GetItemString(al_Row, "sworkstation")
ls_Multi_WS_1		= This.dsCartdiagramSheet.GetItemString(al_Row, "smulti_ws_1")
ls_Multi_WS_2 		= This.dsCartdiagramSheet.GetItemString(al_Row, "smulti_ws_2")
il_Current_TR_Comp[upperbound(il_Current_TR_Comp) + 1] = This.dsCartdiagramSheet.GetItemNumber(al_Row, "nrowid")
If Isnull(ls_Multi_WS_2) Then ls_Multi_WS_2 = ""
ls_Multi_WS_2 		= Trim(ls_Multi_WS_2)
If NOT Isnull(ls_Multi_WS_1) Then
	ls_Multi_WS_1 += ls_Multi_WS_2
End If
// --------------------------------------------
// Ermittlung Prod range
ls_Production_Range = of_get_production_range(al_Airline_key, as_Unit, as_Dep_Time)
// --------------------------------------------
ls_Loadinglist		= This.dsCartdiagramSheet.GetItemString(al_Row, "sloadinglist")
ls_Stowage = trim(dsCartdiagramSheet.GetItemString(al_Row, "sstowage"))
rads_Cartdiagram.retrieve(llIndexKey, llDetailKey, datetime(dDeparture))
rauo_cart_diagram.isStowage				= ls_Stowage
rauo_cart_diagram.il_Routing_ID		= al_routing_ID

If rab_First Then
	rauo_cart_diagram.of_clean_band( "detail", FALSE)
	rauo_cart_diagram.of_init_tr(llIndexKey, llDetailKey, al_Airline_key, as_Unit, rads_Cartdiagram, datetime(dDeparture), rads_Backlog)
	rab_First = FALSE
End If

// -----------------------------------------------------------
// Lese berechnete Position
// -----------------------------------------------------------
rauo_TR_Alloc.of_get_content_position(al_Row, ll_Page, ll_Cart_Number,ll_Column, ll_Cart_Row)             

// -----------------------------------------------------------
// Background Colouring for Changes 
// -----------------------------------------------------------
lb_Watermark_Changed = FALSE
ldt_Modified = DateTime(1900-01-01)
SELECT		dtimestamp_modification, ctext  
INTO			:ldt_Modified, :ls_PL_Text  
FROM			cen_packinglists  
WHERE			npackinglist_index_key		= :llIndexKey
AND         npackinglist_detail_key		= :llDetailKey    ;
If Date(ldt_Modified) > RelativeDate(date(today()), - 30 ) Then 
	lb_Watermark_Changed = TRUE
End If

lstr_component_single = lstr_Empty
lstr_component_single.ssnr =  f_get_packinglist(llIndexKey)
lstr_component_single.stext = ls_PL_Text
//ls_Drawer_Text = rauo_cart_diagram.of_get_item_description_tr(lstr_component_single)		
ls_Drawer_Text = rauo_cart_diagram.of_get_item_description(lstr_component_single)		

// --------------------------------------------------------------
// Content Sheet - "Header"
// --------------------------------------------------------
// Und Content Sheet - verteilte Komponenten nach Content Sheet $$HEX1$$fc00$$ENDHEX$$bertragen 				
// --------------------------------------------------------
li_Succ = of_create_tr_cart_diagram_cs_distr(	ab_content_sheet, al_Row, lstr_component_single, &
																rauo_distribution, ls_stowage, rauo_cart_diagram, ls_Distribution_Items)

ls_Suppressed_Items = ls_Empty

// --------------------------------------------------------
// verteilte Komponenten f$$HEX1$$fc00$$ENDHEX$$r Drawer  				
// --------------------------------------------------------
li_Succ = of_create_tr_cartdiagram_distr_comp(	ab_content_sheet, al_Row, lstr_component_single, &
																rauo_distribution, ls_stowage, rauo_cart_diagram, ls_Distribution_Items , ls_Suppressed_Items)

// ------------------------------------------------------
// Nicht drucken, wenn nur TripTicket ben$$HEX1$$f600$$ENDHEX$$tigt
// ------------------------------------------------------
If NOT ab_TT_Without_TR Then		
	// -----------------------------------------------------------
	// Drawer zeichnen
	// -----------------------------------------------------------
	li_Succ = rauo_cart_diagram.of_draw_tr_drawer( ll_Cart_Row, ll_Column , rauo_cart_diagram.drawer , TRUE , ls_Drawer_Text )			
	// -----------------------------------------------------------
	// Watermark Backcolour 
	// -----------------------------------------------------------
	If rauo_cart_diagram.of_is_backcol_enabled( al_airline_key, al_routing_id, as_unit) Then
		If lb_Watermark_Changed Then
			ll_Color_Background = rgb(230, 230, 230)
			li_Succ = rauo_cart_diagram.of_draw_tr_background_col(ll_Cart_Row, ll_Column , ll_Color_Background )
		End If
	End If
	
	// --------------------------------------------------------------------------------
	// Wasserzeichen pro Einschub
	// Gadget: "ein Drawer, der in einen TR-Cart verteilt wird , erh$$HEX1$$e400$$ENDHEX$$lt die Downline  
	//          Watermark, wenn man im Ranking Loading List eine Leg-Nummer >1 eintr$$HEX1$$e400$$ENDHEX$$gt."
	// ---------------------------------------------------------------------------------
	If rauo_cart_diagram.of_is_downline_enabled( al_airline_key, al_routing_id, as_unit ) Then
		ll_Catering_Leg = This.dsCartdiagramSheet.GetItemNumber(al_Row, "ncatering_leg")	
		If ll_Catering_Leg > 1 Then
			li_Succ = rauo_cart_diagram.of_draw_watermark_downline(ll_Cart_Row, ll_Column, rauo_cart_diagram.drawer)		
		End If
	End if			
End If

// -----------------------------------------------------------
// Aufl$$HEX1$$f600$$ENDHEX$$sen / Explosion?
// -----------------------------------------------------------
If rauo_cart_diagram.of_is_explosion_enabled( llIndexKey, as_unit, Date(dDeparture) ) Then
	// Explosion EIN
	SELECT	CEN_PACKINGLIST_INDEX.CPACKINGLIST, CEN_PACKINGLISTS.CTEXT
	INTO		:ls_packinglist, :ls_Pl_description
	FROM		CEN_PACKINGLIST_INDEX, CEN_PACKINGLISTS
	WHERE		CEN_PACKINGLISTS.NPACKINGLIST_INDEX_KEY  = CEN_PACKINGLIST_INDEX.NPACKINGLIST_INDEX_KEY  
	AND		CEN_PACKINGLISTS.NPACKINGLIST_INDEX_KEY  = :llIndexKey  
	AND		CEN_PACKINGLISTS.NPACKINGLIST_DETAIL_KEY = :llDetailKey
	USING sqlca;
	lb_Explode = TRUE
ElSE
	lb_Explode = FALSE
End If

// -----------------------------------------------------------
// Schreibe/zeichne Inhalt
// -----------------------------------------------------------		
// 1. array konsolidieren
// 2. neuen text erzeugen
li_Succ = rauo_cart_diagram.of_draw_tr_content_drawer(llIndexKey,  llDetailKey,  ll_Cart_Row, ll_Column, 1, lb_Explode, as_unit, ls_Distribution_Items, ls_Suppressed_Items)		

// -----------------------------------------------------------
// Schreibe Stowage-Text
// -----------------------------------------------------------
li_Succ = rauo_cart_diagram.of_draw_tr_stowage_pos( ll_Cart_Row, ll_Column , rauo_cart_diagram.drawer , ls_Stowage)

// -----------------------------------------------------------
// Text "Segment X"
// -----------------------------------------------------------
//ll_Catering_Leg = This.dsCartdiagramSheet.GetItemNumber(al_Row, "nsegment_number")	
If ll_Catering_Leg = 0 OR Isnull(ll_Catering_Leg) Then ll_Catering_Leg = 0 		
If ll_Catering_Leg > 1 Then
	li_Succ = rauo_cart_diagram.of_draw_tr_segment_indicator(ll_Cart_Row, ll_Column, rauo_cart_diagram.drawer, ll_Catering_Leg)		
End If
	
lb_Group_Break = FALSE
// wenn letzte Zeile: Drucken
If al_Row = This.dsCartdiagramSheet.Rowcount() Then
	lb_Group_Break = TRUE
End If
If al_Row = This.dsCartdiagramSheet.Rowcount() AND ll_page < al_trCartPagesMax Then
	ll_Empty_Page = al_trCartPagesMax
End If
		
If al_Row < This.dsCartdiagramSheet.Rowcount() Then
	rauo_TR_Alloc.of_get_content_position(al_Row + 1, ll_TR_Page, ll_TR_Cart_No, ll_TR_Column, ll_TR_Rung)      
	If ll_TR_Page <> ral_TRCartPages Then
		// Neue Seite
		lb_Group_Break = TRUE
		// ====== Leere Seite dazwischen ======== 
		If ll_TR_Page <> ral_TRCartPages + 1 Then
			ll_Empty_Page = ral_TRCartPages + 1
		End If				
	End If
End If

If lb_Group_Break Then
	ral_Cart_Counter++
	ral_TRCartPages++
	
	If al_Highest_Class = 99 Then
		ls_Find = "cclass='" + ls_Class + "'"
	Else
		// Alles in eine Klasse
		ls_Find = "cclass='" + as_Highest_Class + "'"
	End If
	ll_Found = iuo_tripticket.ids_TR_Classes.Find(ls_Find, 1, iuo_tripticket.ids_TR_Classes.RowCount())
	If ll_Found > 0 Then
		ll_temp = iuo_tripticket.ids_TR_Classes.GetItemNumber(ll_Found, "nnumeric_1")
		ll_temp++
		li_Succ = iuo_tripticket.ids_TR_Classes.SetItem(ll_Found, "nnumeric_1", ll_temp)
	Else
		ll_TT_Row = iuo_tripticket.ids_TR_Classes.InsertRow(0)
		li_Succ = iuo_tripticket.ids_TR_Classes.SetItem(ll_TT_Row, "nnumeric_1", 1)
		li_Succ = iuo_tripticket.ids_TR_Classes.SetItem(ll_TT_Row, "cclass", ls_Class)
	End if
	
	ls_Container = rauo_cart_diagram.of_get_container_short_name()
	
	//++++++++++++++++++
	//ll_Current_TR_Comp[], ll_Empty
	
	
	// ------------------------------------------------------
	// Nicht drucken, wenn nut TripTicket ben$$HEX1$$f600$$ENDHEX$$tigt
	// ------------------------------------------------------
	If NOT ab_TT_Without_TR Then
		//Variable Daten im Datawindow f$$HEX1$$fc00$$ENDHEX$$llen (und Result Key suchen)
		rauo_cart_diagram.of_print_prepare(as_CurrentPrinter , as_Airline , al_Flight_Number , as_Suffix, as_Header, as_From, as_To, as_AC_Type, ls_Stowage, &
														ral_TRCartPages, llBelly, dDeparture, as_Dep_Time, ls_Class, ls_Container, as_Owner, as_Config, ls_Area, ls_Workstation, ls_Loadinglist, lLegNumber)
		// Header / Footer / usw. H$$HEX1$$f600$$ENDHEX$$henanpassung
		rauo_cart_diagram.of_print_init()
	End If
	
	// --------------------------------------------------------------
	// F$$HEX1$$fc00$$ENDHEX$$r neuen Header / Footer: weitere Values erg$$HEX1$$e400$$ENDHEX$$nzen
	// --------------------------------------------------------------
	ls_currentpage				= String(ll_Page) + "/" + String(al_TRCartPagesMax )
	ls_Workstation				= ls_Area + "-" + ls_Workstation
	If NOT Isnull(ls_Multi_WS_1) AND Trim(ls_Multi_WS_1) > "" Then
		ls_Workstation = ls_Multi_WS_1		
	End If
	ls_RampBox					= ""
	If NOT Isnull(as_cbox_from) Then ls_rampbox = as_cbox_from
	If NOT Isnull(as_cbox_to) Then ls_rampbox += " - " + as_cbox_to
	// TR Cart: PL Leer
	//	Description = TR Cart Name
	ls_packinglist				= "" 
	ls_pl_description			= rauo_cart_diagram.of_get_container_short_name()
	ls_Dummy = ls_stowage
	ls_stowage					= "TR " + String(ral_Cart_Counter, "00")
	// Loadinglist leer
	ls_Loadinglist = " "

	// ---------------------------------------------------------------------------
	// TripTicket versorgen
	// ---------------------------------------------------------------------------
	If rauo_cart_diagram.of_is_use_class_enabled() Then
		ll_Class_Number = f_get_class_key(ls_Class, al_Airline_Key)
		iuo_tripticket.of_add_packinglist(	cs_Xporter, ls_Stowage, ls_Stowage, rauo_cart_diagram.is_TR_Cart_Area_WS, &
														ls_Dummy, ls_Class, ll_Class_Number, ls_Area )
	Else
		ll_Class_Number = f_get_class_key(as_Highest_Class, al_Airline_Key)
		iuo_tripticket.of_add_packinglist(	cs_Xporter, ls_Stowage, ls_Stowage, rauo_cart_diagram.is_TR_Cart_Area_WS, &
														ls_Dummy, as_Highest_Class, ll_Class_Number, ls_Area )
	End If
	
	// ------------------------------------------------------
	// Nicht drucken, wenn nut TripTicket ben$$HEX1$$f600$$ENDHEX$$tigt
	// ------------------------------------------------------
	If NOT ab_TT_Without_TR Then
		// ls_Unit_Area_From_Masterdata		
		rauo_cart_diagram.of_print_prepare_new_h_f(ls_Loadinglist, ls_packinglist, ls_pl_description, ls_rampbox, ls_stowage, &
																ls_Class, rauo_cart_diagram.is_TR_Cart_Area_WS, ls_currentpage, FALSE)
		// ------------------------------------------	
		// Wasserzeichen					
		// ------------------------------------------
		ll_Watermark = rauo_cart_diagram.of_get_watermark_type(al_Airline_key, al_Routing_ID, as_unit)
		If ll_Watermark <> -1 Then
			li_Succ = rauo_cart_diagram.of_draw_watermark(ll_Watermark, al_Flight_Number , as_Ramp_Time , as_Kitchen_Time, &
																		as_Ops, ls_class, as_Production_Range ,&
																		al_airline_key, as_unit, al_routing_id , TRUE)
		End If				
		// --------------------------------------------------------------
		// Nach oben schieben - freien Platz nutzen	
		// --------------------------------------------------------------
		li_Min_OffSet = rauo_cart_diagram.of_get_min_offset("detail", FALSE) 
		If li_Min_OffSet > 10 then li_Min_OffSet -= 5
		rauo_cart_diagram.of_move_objects("detail", - li_Min_OffSet , 0, FALSE)	
		
			// --------------------------------------------------------------
		// Wasserzeichen sortieren
		// --------------------------------------------------------------
		rauo_cart_diagram.of_move_to_background(FALSE)
		
		
		li_Succ = rauo_cart_diagram.of_modify("r_frame.visible='0'" , FALSE)
		
		If bDistribution Then

			li_Succ_Comp = rauo_cart_diagram.of_sd_create_tr_component_list(il_Current_TR_Comp, rauo_distribution, dsCartdiagramSheet)
		
		End If
		
		il_Current_TR_Comp = ll_Empty
		
		
		// --------------------------------------------------------------
		// Ende Values f$$HEX1$$fc00$$ENDHEX$$r Header / Footer
		// --------------------------------------------------------------
		ll_FullState = rauo_cart_diagram.of_getfullstate(lb_Blob)
		ll_FullState = Len(lb_Blob)
		ll_FullState = lds_TR_Cart_Print.SetFullState(lb_Blob)
		
		ii_Do_NOT_Trace = 0
		If ii_Do_NOT_Trace = 0 then
			li_Succ = lds_TR_Cart_Print.saveas(f_gettemppath() + "CBASE_TRCART_" + String(Rand(32767)) + String(now(), "hhmmss") + ".PSR", PSReport!, True)
		End if
		ii_Do_NOT_Trace = 1		
		
		ral_FileCounter++
		ras_PdfFiles[ral_FileCounter] = f_gettemppath() + "CBASE-TRCARTDIAGRAM-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"

		li_Succ = of_create_acrobat(lds_TR_Cart_Print, ras_PdfFiles[ral_FileCounter])
		

		If li_Succ = -1 Then
			lB_Error_on_Acrobat = TRUE
			if ii_Do_NOT_Trace= 0 then
				f_trace("of_create_tr_cartdiagram lb_Error_on_Acrobat")
			End If
		End If				
	end if

	If ll_Empty_Page > 0 Then
		// -----------------------------------------------------------
		// Drucke Leere Seite
		// -----------------------------------------------------------

		li_Succ = of_create_tr_diagram_empty(	ll_empty_page,  ab_tt_without_tr, ral_trcartpages, rauo_cart_diagram, &
															al_trcartpagesmax, ras_PdfFiles, as_currentprinter, as_airline, al_flight_number, &
															llbelly, as_dep_time, as_suffix, as_header, as_from, as_to, as_ac_type, ls_Container, &
															as_owner, as_config, ls_area, ls_workstation, ls_multi_ws_1, ls_loadinglist, al_leg_number, &
															ls_class, ral_cart_counter, as_cbox_from, as_cbox_to, al_airline_key, al_routing_id, as_unit,&
															as_ramp_time, as_kitchen_time, as_ops, as_production_range, ral_FileCounter )
															
	End If

	lb_Group_Break = FALSE
	// Nochmal INIT
	rab_First = TRUE
end if		
ls_Stowage = ""

DESTROY	lds_TR_Cart_Print

Return 1

end function

protected function integer of_create_tripticket_main (long al_result_key, string as_handling_list[], long al_flight_number, string as_ramp_box, string as_airline, string as_ac_type, string as_tail_no, string as_dep_time, string as_ramp_time, string as_handling_type_text, string as_handling_type_description, string as_from, ref uo_tripticket rauo_tripticket, long al_airline_key, ref string ras_pdffiles[]);
Blob					lb_Blob
Integer				li_Succ
long					lFileCounter
Long					ll_FullState				
Long					ll_Temp
Long					ll_Class_Cycles, ll_Classes
Long					ll_Found
Long					ll_Counter
Long					ll_num_xporters
Long					ll_Count_PL , ll_TT_Row
Long					ll_Class_Counter
Long					ll_Count_TT_Rows, ll_Count_TT_Cols
Long					ll_Count_Classes
Long					ll_Tmp_Counter
String				ls_Find, ls_unitarea
String				ls_Error
String				ls_Class_Filter //, ls_Class_1
String				ls_Temp, ls_Class
String				ls_ll_1 = " ", ls_ll_2 = " "
String				ls_Summary
String				ls_TT_Class_1, ls_TT_Class_2, ls_TT_Class_3
//String				ls_nobooking
Boolean				lb_First = TRUE
Boolean				lb_Group_Break = FALSE
DataStore			lds_Tmp_Types
DataStore			ldsDatastore
DataStore			ldsTripTicket
DataStore			lds_Classes


ldsDatastore = CREATE DataStore

ldsTripTicket = CREATE DataStore
ldsTripTicket.DataObject = "dw_uo_layout_trip"

lds_Classes = CREATE DataStore
lds_Classes.DataObject = "dw_airline_classnames"
lds_Classes.SetTransObject(SQLCA)
//ll_Classes = lds_Classes.Retrieve(al_Airline_key)

// Header f$$HEX1$$fc00$$ENDHEX$$llen
// Handlings auf 2 Zeilen verteilen
If IsValid(rauo_tripticket) Then
	li_Succ = rauo_tripticket.of_concat_handling(as_handling_list, ls_ll_1, ls_ll_2)
End If

li_Succ = of_fill_tripticket_fields(ldsTripTicket, al_Flight_Number , as_Ramp_Box , ddeparture , as_Airline , as_AC_Type , as_Tail_No , &
												as_Dep_Time , ls_ll_1, ls_ll_2, as_Ramp_Time, &
												as_handling_type_text + "   " + as_handling_type_description, as_From , rauo_tripticket.il_Num_TR_Carts )

If IsValid(rauo_tripticket) Then
	// Ermittle Klassen
	if ii_Do_NOT_Trace = 0 then
		rauo_tripticket.ids_Packinglists.saveas(f_gettemppath()+"tripticket_PL_" + String(al_result_key ) + "_" + String(now(), "hhmmssfff") + ".xls", excel5!, true)
	end if
	
	For ll_Count_PL = 1 To rauo_tripticket.ids_Packinglists.RowCount()
		ll_Temp = rauo_tripticket.ids_Packinglists.GetItemNumber(ll_Count_PL, "nclass_number")
		If ll_Temp = -1 then 
			if ii_Do_NOT_Trace = 0 Then
				f_trace("uo_client_label.of_create_tripticket INVALID CLASS CONTINUE")
			End If
			continue
		End If
		ll_Found = lds_Classes.Find("nclass_number=" + String(ll_Temp), 1, lds_Classes.RowCount())
		If ll_Found = 0 Then
			ls_temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sclass")
			//If rauo_tripticket.of_is_booking_class(ls_temp) Then
			ll_TT_Row = lds_Classes.insertRow(0)
			li_Succ = lds_Classes.SetItem(ll_TT_Row, "nclass_number", ll_Temp)
			//ls_temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sclass")
			li_Succ = lds_Classes.SetItem(ll_TT_Row, "cclass", ls_temp)
			//	Else
			//		// Non Booking: jetzt nicht 
			//	End If
		End if
	Next
	
	ll_Class_Cycles = lds_Classes.RowCount()
	// 02.11.2011 Z$$HEX1$$e400$$ENDHEX$$hlung Classes / Pages repariert
	ll_Class_Cycles = Ceiling(ll_Class_Cycles / 3)
	li_Succ = lds_Classes.Sort()
	ll_Class_Counter = 0
	For ll_Count_Classes = 1 To ll_Class_Cycles 
		ldsTripTicket.Reset()
		ls_TT_Class_1 = ""
		ls_TT_Class_2 = ""
		ls_TT_Class_3 = ""
		ls_Class_Filter = "nclass_number in("
		ll_Class_Counter = (ll_Count_Classes - 1) * 3 + 1
		If ll_Class_Counter <= lds_Classes.RowCount() Then
			ls_Class_Filter += String(lds_Classes.Getitemnumber(ll_Class_Counter, "nclass_number")) + ", "
			ls_TT_Class_1 = lds_Classes.GetitemString(ll_Class_Counter, "cclass")
		End If
		ll_Class_Counter++
		If ll_Class_Counter <= lds_Classes.RowCount() Then
			ls_Class_Filter += String(lds_Classes.Getitemnumber(ll_Class_Counter, "nclass_number")) + ", "
			ls_TT_Class_2 = lds_Classes.GetitemString(ll_Class_Counter, "cclass")
		End If
		ll_Class_Counter++
		If ll_Class_Counter <= lds_Classes.RowCount() Then
			ls_Class_Filter += String(lds_Classes.Getitemnumber(ll_Class_Counter, "nclass_number")) + ", "
			ls_TT_Class_3 = lds_Classes.GetitemString(ll_Class_Counter, "cclass")
		End If
		ls_Class_Filter = Left(ls_Class_Filter, Len(ls_Class_Filter) - 2) + ")"
		ll_temp = rauo_tripticket.ids_Packinglists.RowCount()
		li_Succ = rauo_tripticket.ids_Packinglists.SetFilter(ls_Class_Filter)
		li_Succ = rauo_tripticket.ids_Packinglists.Filter()
		li_Succ = rauo_tripticket.ids_Packinglists.Sort()
		ll_temp = rauo_tripticket.ids_Packinglists.RowCount()
		For ll_Count_PL = 1 To rauo_tripticket.ids_Packinglists.RowCount()
			ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "scart_type")
			If rauo_tripticket.of_is_type_relevant(ls_temp) = FALSE Then
				if ii_Do_NOT_Trace = 0 Then f_trace("uo_client_label.of_create_tripticket Type not relevant " + ls_Temp)
				CONTINUE
			End If
			ll_TT_Row = ldsTripTicket.RowCount()
		
			// 01.09.2011 Test AREA - UNITAREA
			ls_Unitarea = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sunit_area")
			ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sclass")
			
			// Je nach Klasse in Spalte 1,2,3 f$$HEX1$$fc00$$ENDHEX$$llen
			li_Succ = of_create_tripticket_class(	ll_count_pl, ls_Temp, ls_tt_class_1, ls_tt_class_2, ls_tt_class_3, &
																ls_unitarea, ldstripticket, rauo_tripticket, ll_TT_Row)
			
			ls_Temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sunit_area")
			li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"sunitarea" ,  ls_UnitArea)
			ll_Temp = rauo_tripticket.ids_Packinglists.GetItemNumber(ll_Count_PL, "nclass_number")
			li_Succ = ldsTripTicket.SetItem(ll_TT_Row, "nclass_number1" , ll_Temp)
			
		Next
		
		// --------------------------------------------------------------------
		// TR Carts je Klasse
		// --------------------------------------------------------------------
		li_Succ = rauo_tripticket.of_tr_carts_per_class(ldstripticket)
			
		// --------------------------------------------------------------------
		// Z$$HEX1$$e400$$ENDHEX$$hle Typen & Summen	GESAMT
		// --------------------------------------------------------------------
		lds_Tmp_Types = CREATE DataStore
		lds_Tmp_Types.DataObject = "dw_ext_classes"
		ll_Tmp_Counter = 0
		For ll_Count_TT_Rows = 1 TO ldsTripTicket.RowCount()
			For ll_Count_TT_Cols = 1 To 3
			
				ls_Temp = ldsTripTicket.GetItemString(ll_Count_TT_Rows,"stype_" + String(ll_Count_TT_Cols))
				If IsNULL(ls_Temp) Then CONTINUE
				ll_Tmp_Counter++
				ls_Find = "cclass='"  + ls_Temp + "'"
				ll_Found = lds_Tmp_Types.Find(ls_Find, 1, lds_Tmp_Types.RowCount())
				If ll_Found = 0 Then
					ll_Found = lds_Tmp_Types.InsertRow(0)
					li_Succ = lds_Tmp_Types.SetItem(ll_Found, "cclass", ls_Temp)
					li_Succ = lds_Tmp_Types.SetItem(ll_Found, "nnumeric_1", 1)
				Else
					ll_Temp = lds_Tmp_Types.GetItemNumber(ll_Found, "nnumeric_1")
					li_Succ = lds_Tmp_Types.SetItem(ll_Found, "nnumeric_1", ll_temp + 1)
				End if
				// nnumeric_1
			Next												
		Next
		ls_Summary = ""
		For ll_Count_TT_Rows = 1 TO lds_Tmp_Types.RowCount()
			ls_Summary += String(lds_Tmp_Types.GetItemNumber(ll_Count_TT_Rows, "nnumeric_1")) + " "
			ls_Summary += lds_Tmp_Types.GetItemString(ll_Count_TT_Rows, "cclass")+ " / "							
		Next
		ls_Summary = TRIM(ls_Summary)
		If Right(ls_Summary, 1 ) = "/" Then ls_Summary = Left(ls_Summary, Len(ls_Summary) - 1)
			ls_Summary = "Total Carts to Load: "  + String(ll_Tmp_Counter) + "~r~n" + ls_Summary
		ls_Error = ldstripticket.Modify("t_sum_alles.Text='" + ls_Summary + "'")
		
		// ----------------------------------------------------------------------
		// Summe pro Spalte 
		// ----------------------------------------------------------------------
		ll_Tmp_Counter = 0
		lds_Tmp_Types.Reset()
		For ll_Count_TT_Rows = 1 TO ldsTripTicket.RowCount()
			For ll_Count_TT_Cols = 1 To 3
				ls_Temp = ldsTripTicket.GetItemString(ll_Count_TT_Rows,"stype_" + String(ll_Count_TT_Cols))
				If IsNULL(ls_Temp) Then CONTINUE
				ll_Tmp_Counter++
				// nclass_number = SPALTE
				ls_Find = "cclass='"  + ls_Temp + "' AND nclass_number=" + String(ll_Count_TT_Cols)
				ll_Found = lds_Tmp_Types.Find(ls_Find, 1, lds_Tmp_Types.RowCount())
				If ll_Found = 0 Then
					ll_Found = lds_Tmp_Types.InsertRow(0)
					li_Succ = lds_Tmp_Types.SetItem(ll_Found, "cclass", ls_Temp)
					li_Succ = lds_Tmp_Types.SetItem(ll_Found, "nnumeric_1", 1)
					li_Succ = lds_Tmp_Types.SetItem(ll_Found, "nclass_number", ll_Count_TT_Cols)
				Else
					ll_Temp = lds_Tmp_Types.GetItemNumber(ll_Found, "nnumeric_1")
					li_Succ = lds_Tmp_Types.SetItem(ll_Found, "nnumeric_1", ll_temp + 1)
					li_Succ = lds_Tmp_Types.SetItem(ll_Found, "nclass_number", ll_Count_TT_Cols)
				End if
			Next												
		Next
		
		
		For ll_Count_TT_Cols = 1 To 3
			
			ls_Summary = ""
			li_Succ = lds_Tmp_Types.SetFilter("nclass_number=" + String(ll_Count_TT_Cols))
			li_Succ = lds_Tmp_Types.Filter()
			
			For ll_Count_TT_Rows = 1 TO lds_Tmp_Types.RowCount()
				ls_Summary += String(lds_Tmp_Types.GetItemNumber(ll_Count_TT_Rows, "nnumeric_1")) + " "
				ls_Summary += lds_Tmp_Types.GetItemString(ll_Count_TT_Rows, "cclass") + " / "							
			Next
			ls_Summary = TRIM(ls_Summary)
			If Right(ls_Summary, 1 ) = "/" Then ls_Summary = Left(ls_Summary, Len(ls_Summary) - 1)
			ls_temp = ldstripticket.describe("t_num_tr_" + String(ll_Count_TT_Cols) + ".Text")
			ls_Error = ldstripticket.Modify("t_sum_type_" + String(ll_Count_TT_Cols) + ".Text='" + ls_Summary + "'")
		Next
		// ----------------------------------------------------------------------
		// Ende Summe pro Spalte 
		// ----------------------------------------------------------------------
		DESTROY lds_Tmp_Types
		// --------------------------------------------------------------------
		// ENDE Z$$HEX1$$e400$$ENDHEX$$hle Typen & Summen	GESAMT
		// --------------------------------------------------------------------
//						// --------------------------------------------------------------------
//						// TEST NON BOOKING
//						// --------------------------------------------------------------------
//						For ll_Count_PL = 1 To rauo_tripticket.ids_Packinglists.RowCount()
//							ll_Temp = rauo_tripticket.ids_Packinglists.GetItemNumber(ll_Count_PL, "nclass_number")
//							ll_Found = lds_Classes.Find("nclass_number=" + String(ll_Temp), 1, lds_Classes.RowCount())
//							If ll_Found = 0 Then
//								ls_temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sclass")
//								If rauo_tripticket.of_is_booking_class(ls_temp) = FALSE Then
//								
//	//								ll_TT_Row = lds_Classes.insertRow(0)
//	//								li_Succ = lds_Classes.SetItem(ll_TT_Row, "nclass_number", ll_Temp)
//									//ls_temp = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "sclass")
//									//li_Succ = lds_Classes.SetItem(ll_TT_Row, "cclass", ls_temp)
//									ll_TT_Row = ldsTripTicket.InsertRow(0)
//									
//									ls_nobooking = rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "spl_nr")
//									//li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"spl_1" ,  ls_Temp)
//									ls_nobooking += " " + rauo_tripticket.ids_Packinglists.GetItemString(ll_Count_PL, "spl_text")
//									//li_Succ = ldsTripTicket.SetItem(ll_TT_Row,"spl_text1" ,  ls_Temp)
//									li_Succ = ldsTripTicket.SetItem(ll_TT_Row, "snobooking", ls_nobooking)
//									li_Succ = ldsTripTicket.SetItem(ll_TT_Row, "sunitarea", "ZZZ")
//								End If
//							End If
//						Next
//			
		// --------------------------------------------------------------------
		// TR Carts je Klasse
		// --------------------------------------------------------------------
		If ii_Do_NOT_Trace = 0 Then
			rauo_tripticket.ids_TR_Classes.saveas(f_gettemppath() + "ids_TR_Classes_" + String(Rand(32767)) + String(now(), "hhmmss") + ".XLS", Excel5!, True)
		End if					
		ldsTripTicket.groupcalc( )
		if ii_Do_NOT_Trace=0 then
			li_Succ = ldsTripTicket.saveas(f_gettemppath() + "CBASE-TRIPTICKET-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PSR", PSReport!, True)
			li_Succ = ldsTripTicket.saveas(f_gettemppath() + "CBASE-TRIPTICKET2-" + String(Rand(32767)) + String(now(), "hhmmss") + ".XLS", Excel5!, True)
		End If	
	
		ll_FullState = ldsTripTicket.getfullstate(lb_Blob) 
		ll_FullState = Len(lb_Blob)
		ll_FullState = ldsDatastore.SetFullState(lb_Blob)
		
		lFileCounter++
		ras_PdfFiles[lFileCounter] = f_gettemppath() + "CBASE-TRIPTICKET-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
		li_Succ = of_create_acrobat(ldsDatastore, ras_PdfFiles[lFileCounter])
		lb_Group_Break = FALSE
		// Nochmal INIT
		lb_First = TRUE
	Next
End If
//ls_Stowage = ""


Return 1
end function

public function integer of_create_cart_diagram (long al_result_key, string as_label_filter, ref uo_documents rauo_product, boolean ab_cart_diagram, boolean ab_contentsheet, boolean ab_tripticket, boolean ab_tr_cart, boolean ab_unassignedcarts, boolean ab_printdirectly, boolean ab_use_printer_allocation, string as_printer_cart_diagram, string as_current_printer_1);/*
* Objekt : uo_client_label
* Methode: of_create_cart_diagram (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 01.08.2012
*
* Argument(e):
*			long					al_result_key
*			string				as_label_filter
*	ref	uo_documents		rauo_product
*	ref	uo_distribution	rauo_distribution
*			boolean				ab_cart_diagram
*			boolean				ab_contentsheet
*			boolean				ab_tripticket
*			boolean				ab_tr_cart
*			boolean				ab_unassignedcarts
*			boolean				ab_printdirectly
*			boolean				ab_use_printer_allocation
*			string				as_printer_cart_diagram
*			string				as_current_printer_1
*
* Beschreibung:		Create Cart Diagram (aus w_print_center umgezogen)
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	01.08.2012		Erstellung
* 1.1 			O.Hoefer	06.02.2013		Ops_Ermittlung ge$$HEX1$$e400$$ENDHEX$$ndert
*
*
* Return: integer
*
*/

Integer				li_Succ
Long 					ll_flightnumber
Integer				li_Catering_Leg
Boolean				lb_TT_Without_TR
Boolean				lb_manual_distr_done
Boolean				lb_require_exact_match = FALSE
Long					ll_Cart_Pages
Long					ll_Number_of_Pages = 0
long					ll_Start, ll_Stop , ll_Row
Long					ll_CartPages
long					ll_FileCounter
Long					ll_Routing_ID, ll_Watermark
Long					ll_transaction
Long					ll_temp
Long					ll_Airline_key
Long					ll_EQ_Rows
Long					ll_BacklogPages
Long					ll_Leg_nr
Long					ll_RowId
Long					ll_Found
Long					ll_Cart_Rows
String				ls_airline
String 				ls_From, ls_To, ls_Time, ls_Registration, ls_Owner, ls_ACType, ls_Version, ls_Suffix, ls_Stowage, ls_Header
string				ls_PdfFiles[], ls_Out
String				ls_Unit
String				ls_FBox_From, ls_fbox_to
String				ls_OPS, ls_Dep_Time, ls_Ramp_Time, ls_Kitchen_Time
String				ls_CD_File_Name
s_product_log		lstr_Log
DataStore			lds_Unassigned
DataStore			lds_EQ
uo_cart_diagram 	luo_diagram


ll_Start = CPU()

f_trace("uo_client_label.of_create_cart_diagram START")

// Airline Equipment
lds_EQ = CREATE DataStore
lds_EQ.DataObject = "dw_airlines_equipment"
lds_EQ.Settransobject(SQLCA)
// Unassigned PLs
lds_unassigned = CREATE DataStore
lds_unassigned.DataObject = "dw_unassigned_pl_report"
lds_unassigned.Settransobject(SQLCA)

luo_diagram = create uo_cart_diagram
luo_diagram.iTrace = s_app.iTrace
luo_diagram.il_disable_debug = ii_Do_NOT_Trace
luo_diagram.ib_secondary_distribution_only = ib_secondary_distribution_only
If isvalid(inv_copy_settings) then
	luo_diagram.inv_copy_settings = inv_copy_settings
End If
luo_diagram.ib_enable_masterdata_view = ib_enable_masterdata_view

//-----------------------------------------------------------------
// Acrobat Printer initialisieren (MB 13.05.2011, Citrix-Fehlerbehebung)
//-----------------------------------------------------------------
//wf_create_acrobat_init_cs( )
// -------------------------------------------------------------------
This.lResultKey = al_result_key


li_Succ = of_get_flight_details( al_result_key, ll_flightnumber, ls_suffix, ls_from, ls_to, ll_airline_key, ls_airline, ls_actype, &
											ls_dep_time, ls_ramp_time, ls_unit, ll_leg_nr, ll_routing_id, ls_owner, ls_version, &
											ls_fbox_from, ls_fbox_to, ls_kitchen_time, ll_transaction, ls_Registration)
											
luo_diagram.idt_Departure = ddeparture											

if isNull(ls_Owner)			then ls_Owner		= ""
if isNull(ls_ACType)			then ls_ACType		= ""
if isNull(ls_Version)		then ls_Version	= ""
ls_Out =  ls_airline + " " + string(  ll_flightnumber ,"000" ) +  trim(ls_suffix)


rauo_Product.sAirline = ls_airline
rauo_Product.lFlightNumber = ll_flightnumber

// --------------------------------------------------------------------
// Schalter "Require exact match"
// --------------------------------------------------------------------
select	nrequire_exact_match_4_distr 
into		:ll_temp
from		cen_airlines 
where		nairline_key = :ll_airline_key;
If ll_temp = 1 then 
	lb_require_exact_match = TRUE
End If

// --------------------------------------------------------------------
// Init Flight (uo_cart_diagram)
// --------------------------------------------------------------------
luo_diagram.of_sd_init_flight(al_result_key, ll_transaction, lb_require_exact_match, ls_unit, ll_airline_key )
lTransaction = ll_transaction


// --------------------------------------------------------------------
// ermittle ops - CBASE-NAM-CR-12089
// --------------------------------------------------------------------
select		ctext 
into			:ls_OPS
from			loc_operations
where			cunit = :ls_Unit
and			:ls_Dep_Time between ctime_from and ctime_to
and			nsort = (select max(nsort) 
							from	loc_operations  
							where	cunit = :ls_Unit
							and	:ls_Dep_Time between ctime_from and ctime_to );



// 17.01.2013
bSecondaryDistribution = luo_diagram.of_is_distribution_enabled( )


If bDistribution Then
//If ib_manual_distr_done = FALSE then
	if ii_Do_NOT_Trace = 0 then
		f_trace("uo_client_label.of_create_cartdiagram This.of_cartdiagram_sheet DISTRIBUTION = TRUE")
	End If
	li_Succ = this.of_cartdiagram_sheet(as_Label_Filter, TRUE)
	If li_Succ <> -1 Then
//		If isvalid(uodistribution) then
//			rauo_distribution = uodistribution.of_clone()
//		Else
//			f_trace("uo_client_label.of_create_cartdiagram This.of_cartdiagram_sheet isvalid(uodistribution) = FALSE")
//		End If
	Else
		f_trace("uo_client_label.of_create_cartdiagram This.of_cartdiagram_sheet li_Succ = " + String(li_Succ))
	End If
	//ib_manual_distr_done = TRUE
	// ----------------------------------------------------------------------
	// Komponenten, die nicht verteilt werden konnten
	// ----------------------------------------------------------------------
	If ib_Secondary_Distribution_ONLY = FALSE Then
		if not isnull(This.blbDistributionError) and len(This.blbDistributionError) > 0 then
			rauo_Product.iDistributionError		= 1
			rauo_Product.sDistributionErrorFile = f_gettemppath() + "CBASE-DISTRIBUTIONERRORS-" + String(al_result_key) + "-" + String(Rand(30000))  + String(now(), "hhmmss") + ".blb"
			f_blob_to_file(rauo_Product.sDistributionErrorFile, This.blbDistributionError)
		End If
	End If
Else
	if ii_Do_NOT_Trace = 0 then f_trace("uo_client_label.of_create_cartdiagram This.of_cartdiagram_sheet DISTRIBUTION = FALSE")
	li_Succ = This.of_cartdiagram_sheet(as_Label_Filter, FALSE)
End If
	
if li_Succ = -1000 then
	if ii_Do_NOT_Trace = 0 then
		f_trace("uo_client_label.of_create_cartdiagram This.of_cartdiagram_sheet li_Succ = -1000")
	End If
	return -1000
elseif li_Succ = 0 then
	If ab_contentsheet Then
		If dsLoading.rowcount() > 0 then
			dsLoading.RowsCopy(1, dsLoading.RowCount(), Primary!, iuoContentSheet.dsLoading , iuoContentSheet.dsLoading.RowCount() + 1, Primary!)	
		End If	
	End If

	// Airline Equiment Types
	ll_EQ_Rows = lds_EQ.Retrieve(ll_Airline_key)
	
//	rauo_Product.sCartdiagramSheetFile	 = f_gettemppath() + "CBASE-CARTDIAGRAM-" + ls_Out + "-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"

	ls_CD_File_Name = ls_Airline + String(ll_flightnumber , "000") + "_" + ls_From + "_" + ls_to + "_" +String( ddeparture, "YYYYMMDD")
	//	ls_CD_File_Name = ls_Compute_5 + "_" + sFrom + "_" + sto + "_" +String( ddeparture, "YYYYMMDD")
	ls_CD_File_Name += "_CD_" + String(ll_transaction) + "_" + String(Rand(32000),"00000") + ".PDF"

	rauo_Product.sCartdiagramSheetFile	 = f_gettemppath() + ls_CD_File_Name//"CBASE-CARTDIAGRAM-" + ls_Out + "-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"

	ll_CartPages = 0
			
	// ---------------------------------------------------------------------------------------------
	// Wenn TripTicket OHNE Cart Diagram: nur relevante Daten f$$HEX1$$fc00$$ENDHEX$$llen und dann zur$$HEX1$$fc00$$ENDHEX$$ck
	// ---------------------------------------------------------------------------------------------
	//if ab_Cart_Diagram = FALSE then
	if ab_Cart_Diagram = FALSE AND ib_Secondary_Distribution_ONLY = FALSE AND ab_tripticket = FALSE then		
		
		If ii_Do_NOT_Trace = 0 then f_trace("of_create_cart_diagram ab_Cart_Diagram = FALSE => END")

	Else
		// ---------------------------------------------------------------------------------------------
		// Create or load secondary distribution
		// ---------------------------------------------------------------------------------------------
		//	Wenn keine secondary distribution gespeichert ist: neu erstellen / bef$$HEX1$$fc00$$ENDHEX$$llen
		//		1. Master 
		//		2. Component List
		//		3. List of Carts
		//		4. Drawers / Trays per Cart
		//		5. Drawers / Trays content
		//		6. Errors / Overflow / Messages / Info
		
		If bmanueldistribution = TRUE OR ib_enable_masterdata_view = TRUE Then
			li_Succ = luo_diagram.of_delete_secondary_distribution(al_result_key, ll_transaction)
		End If
		
		If ii_Do_NOT_Trace = 0 Then f_trace("uo_client_label.of_create_cartdiagram BEFORE of_create_or_load_sec_distr")
		
		//ii_Do_NOT_Trace = 0
//		ll_Number_of_Pages = luo_diagram.of_create_or_load_sec_distr(al_result_key, ll_transaction, rauo_distribution, ll_airline_key,&
//									ls_unit, lds_unassigned, lds_eq, ab_contentsheet , dsCartdiagramSheet, iuo_tripticket, iuoContentSheet)
		ll_Number_of_Pages = luo_diagram.of_create_or_load_sec_distr(al_result_key, ll_transaction, uodistribution, ll_airline_key,&
									ls_unit, lds_unassigned, lds_eq, ab_contentsheet , dsCartdiagramSheet, iuo_tripticket, iuoContentSheet)
									
		// ------------------------------------------------------------------------
		// 05.09.2012 KPI Kennzahl Seitenanzahl Cart Diagram nach "au$$HEX1$$df00$$ENDHEX$$en"
		// ------------------------------------------------------------------------
		il_kpi_cart_diagram = ll_Number_of_Pages		
		//ii_Do_NOT_Trace = 1
		
		If ii_Do_NOT_Trace = 0 Then f_trace("uo_client_label.of_create_cartdiagram AFTER of_create_or_load_sec_distr")
		
		// ------------------------------------------------------------------------
		// nur TripTicket => Ende
		// ------------------------------------------------------------------------
		If ab_Cart_Diagram = FALSE AND ib_Secondary_Distribution_ONLY = FALSE AND ab_tripticket = TRUE Then
			f_trace("of_create_cart_diagram TripTicket only")				
		Else
	
			
			// ------------------------------------------------------------------------
			// Weiche ib_Secondary_Distribution_ONLY
			// ------------------------------------------------------------------------
			If ib_Secondary_Distribution_ONLY = FALSE Then
		
				// Masterdata View => kein Watermark
				If NOT ib_enable_masterdata_view Then
					ll_Watermark = luo_diagram.of_get_watermark_type(ll_airline_key, ll_Routing_ID, ls_Unit)
				End If
				
				li_Succ = luo_diagram.ids_sd_master.SetSort("carea ASC, cworkstation ASC, cloadinglist ASC")
				If ib_enable_masterdata_view Then
					li_Succ = luo_diagram.ids_sd_master.SetSort("nrowid ASC")
				End If
				li_Succ = luo_diagram.ids_sd_master.Sort()
			
				If isvalid(w_progress_with_cancel) then
					w_progress_with_cancel.wf_setmin(1)
					w_progress_with_cancel.wf_setmax(luo_diagram.ids_sd_master.Rowcount() + 1)
				End If
			
				// ---------------------------------------------------------------------------------------------
				// Hauptschleife
				// ---------------------------------------------------------------------------------------------
				li_Succ = luo_diagram.ids_SD_Cart.SetFilter("")
				li_Succ = luo_diagram.ids_SD_Cart.Filter()
				For ll_Row = 1 to luo_diagram.ids_sd_master.Rowcount()
					ll_RowId = luo_diagram.ids_sd_master.GetItemNumber(ll_Row, "nrowid")
					ll_Cart_Rows = luo_diagram.ids_SD_Cart.Rowcount()
					li_Succ = luo_diagram.ids_SD_Cart.SetFilter("")
					li_Succ = luo_diagram.ids_SD_Cart.Filter()
					ll_Cart_Rows = luo_diagram.ids_SD_Cart.Rowcount()
					ll_Found = luo_diagram.ids_SD_Cart.Find("nrowid=" + String(ll_RowId), 1, luo_diagram.ids_SD_Cart.RowCount() )
					// Keine Druck-Seite
					If ll_Found < 1 Then	CONTINUE
						
					if isvalid(w_progress_with_cancel) then
						// wurde abgebrochen?
						if w_progress_with_cancel.bCancel then
							return -1000
						End If
						w_progress_with_cancel.wf_setposition(ll_Row)
						w_progress_with_cancel.wf_setstatus( uf.translate("Seite ") +  string(ll_CartPages) )
					End If
			
					// ------------------------------------------------------------------------
					// Create Diagram Page (and Backlog Page if enabled)
					// ------------------------------------------------------------------------
	//				li_Succ = luo_diagram.of_create_cart_diagram_page(ll_row,ll_rowid,ll_airline_key,ls_unit, ll_cartpages,  ab_contentsheet, &
	//													as_current_printer_1,rauo_product,ll_flightnumber,ls_suffix,ls_from,ls_to,ls_actype,&
	//													ls_time,ls_owner,ls_version,ll_leg_nr,ll_number_of_pages,ls_fbox_from,ls_fbox_to,ll_watermark,&
	//													ls_ramp_time,ls_kitchen_time,ls_ops,ll_routing_id, ll_filecounter, ls_pdffiles, ll_backlogpages, &
	//													iuocontentsheet, rauo_distribution )
					li_Succ = luo_diagram.of_create_cart_diagram_page(ll_row,ll_rowid,ll_airline_key,ls_unit, ll_cartpages,  ab_contentsheet, &
														as_current_printer_1,rauo_product,ll_flightnumber,ls_suffix,ls_from,ls_to,ls_actype,&
														ls_time,ls_owner,ls_version,ll_leg_nr,ll_number_of_pages,ls_fbox_from,ls_fbox_to,ll_watermark,&
														ls_ramp_time,ls_kitchen_time,ls_ops,ll_routing_id, ll_filecounter, ls_pdffiles, ll_backlogpages, &
														iuocontentsheet, uodistribution )
	
	
					//	f_trace("of_create_cart_diagram MAIN LOOP NEXT PAGE")									
				Next
				
				// ------------------------------------------------------------------------
				// Report unassigned carts.... 
				// ------------------------------------------------------------------------
				li_Succ = luo_diagram.of_create_unassigned_cart_report(ab_unassignedcarts, lds_unassigned, rauo_product, ll_FileCounter, ls_PdfFiles)
			
				// ------------------------------------------------------------------------
				// Merge PDF Files
				// ------------------------------------------------------------------------
				li_Succ = luo_diagram.of_cart_diagram_merge(rauo_product, ls_pdffiles, ab_printdirectly, ab_use_printer_allocation, as_printer_cart_diagram)
		
			End If	
	
			// ------------------------------------------------------------------------
			// ib_Secondary_Distribution_ONLY
			// ------------------------------------------------------------------------
		End if
	End If
Else
	if ii_Do_NOT_Trace = 0 then f_trace("uo_client_label.of_create_cartdiagram This.of_cartdiagram_sheet li_Succ = " + String(li_Succ))
End If


if ab_tr_cart then 
	If luo_diagram.ids_TR_Exclusions.RowCount() > 0 Then
		li_Succ = luo_diagram.ids_TR_Exclusions.RowsCopy(1, luo_diagram.ids_TR_Exclusions.RowCount(), Primary!, ids_TR_Exclusions, 1, Primary!)	
	End If
End If

//f_set_printer(sDefaultPrinter)
//If lb_Error_on_Acrobat Then
//	rauo_Product.iCartdiagramsheet = 0
//	if ii_Do_NOT_Trace = 0 then
//		f_trace("uo_client_label.of_create_cartdiagram lb_Error_on_Acrobat")
//	End If
//End If
	
ll_Stop = CPU()

DESTROY	luo_diagram
DESTROY	lds_unassigned
DESTROY	lds_EQ

// --------------------------------------------------------------
// Aktion protokollieren
// --------------------------------------------------------------
lstr_Log.lResultKey		= al_result_key
lstr_Log.lTransaction	= ll_transaction 
lstr_Log.lProduct   		= PRODUCT_CART_DIAGRAM
lstr_Log.lDuration   	= (ll_Stop - ll_Start) / 1000
lstr_Log.sWorkstation   = s_app.sHost
lstr_Log.sUser   			= s_app.sUser
lstr_Log.lLabelQuantity = 0
lstr_Log.lDistribution  = 0
lstr_Log.sLabelAreas 	= ""
of_Product_log(lstr_Log)

f_trace("uo_ClientLabel.of_create_cartdiagram END")

Return 0

end function

public function integer of_create_tr_cartdiagram (long al_result_key, ref string ras_file_name, string as_unit, integer ai_useexclusionlabel, long al_result_keys[], string as_currentprinter, string as_labelfilter, boolean ab_printdirectly, ref long ral_cart_pages, datastore ads_exclusions, boolean ab_content_sheet, ref boolean rab_distr_done, boolean ab_tt_without_tr);
/*
* Objekt : uo_client_label
* Methode: of_create_tr_cartdiagram (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 18.08.2010
*
* Argument(e):
*	 		long			al_result_key				Flug
*	 ref	string		ras_file_name				PDF Dateiname
*	 		string		as_unit						
*	 		integer		ai_useexclusionlabel		siehe w_print_center / iuseexclusionlabel
*	 		long			al_result_keys[]			Flug mit dazugeh$$HEX1$$f600$$ENDHEX$$renden anderen Legs
*	 		string		as_currentprinter			Wohin wird gedruckt
*	 		string		as_labelfilter				Labelfilter - siehe w_print_center
*	 		boolean		ab_printdirectly			Direktdruck statt PDF
*	 ref	long			ral_cart_pages
*	 ref	uo_tripticket iuo_tripticket
*	 		datastore	ads_exclusions
*	 		boolean		ab_content_sheet
*	 		uo_distribution uodistribution
*        boolean		ab_TT_Without_TR			Nicht drucken, nur TripTicket bef$$HEX1$$fc00$$ENDHEX$$llen
*
* Beschreibung:		Erstelle Transporter Cart Diagramm
*
* Aenderungshistorie:
* Version 		Wer			Wann          Was und warum
*  1.0 			O.Hoefer    18.08.2010    Erstellung
*  1.1 			O.Hoefer    10.03.2011    Umbau: Distributed Content f$$HEX1$$fc00$$ENDHEX$$r "Content Sheet" aus uodistribution
*  1.2 			O.Hoefer    14.03.2011    Verteilte Inhalte via uo_Distribution
*  1.3 			O.Hoefer    06.04.2011    Issue Loadinglist LEER (129)
*  1.4 			O.Hoefer    26.07.2011    Issue TR Diagramme Type "Double" - Leerseiten drucken
*  1.5 			O.Hoefer    02.08.2011    wegen Problem mit geklontem uo_Distribution; immer Distr. ausf$$HEX1$$fc00$$ENDHEX$$hren
*  1.6 			O.Hoefer    05.09.2011    $$HEX1$$c400$$ENDHEX$$nderung: TripTicket => wenn nicht class-specific, use highest class
*  1.7 			O.Hoefer    25.10.2011    $$HEX1$$c400$$ENDHEX$$nderung: TripTicket OHNE andere Diagramme erm$$HEX1$$f600$$ENDHEX$$glichen
*  1.8 			O.Hoefer    20.03.2012    Konsolidieren von TR & CS Inhalten
*  1.9 			O.Hoefer    26.03.2012    Reparatur Klassenermittlung f$$HEX1$$fc00$$ENDHEX$$r TripTicket
*  1.10 			O.Hoefer    18.09.2012    Einmal of_clone wegoptimiert
*  1.1         D.Bunk      19.12.2012    Anpassungen f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$fc00$$ENDHEX$$berarbeitetes PDF Handler Objekt
*
* Return: integer
*
*/

Integer				li_Succ
Integer				li_Ret
Integer				li_Fill_Type
long					ll_Start, ll_Stop
Long					ll_Row
Long					ll_TRCartPagesMax
Long					ll_TRCartPages
Long					ll_Count
long					ll_FileCounter
Long					ll_transaction
Long					ll_Cart_Counter
Long					ll_Page
Long					ll_Catering_Leg 
Long					ll_Routing_ID
Long					ll_Flight_Number
Long         		ll_Airline_key
Long			      ll_Leg_Number  	
Long					ll_Watermark
Long					ll_Color_Background = RGB(200, 200, 200)
Long					ll_RowId 
Long					ll_Distr_Stowage_Counter
Long					ll_Content_Rows
//Long					ll_Empty_Page = 0 
Long					ll_Class_Number
Long					ll_Highest_Class = 99
//Long					ll_Current_TR_Comp[]
String				ls_Group_Class
String				ls_temp
String				ls_Header, ls_Registration
string				ls_PdfFiles[]
String				ls_Production_Range
String				ls_PL_Text
String         	ls_Suffix, ls_From, ls_To
String				ls_Owner, ls_Config
String				ls_cbox_from, ls_cbox_to
String				ls_Ops
String		      ls_Airline, ls_AC_Type
String	         ls_Dep_Time, ls_Ramp_Time, ls_Unit, ls_Kitchen_Time
String				ls_Area
String				ls_File_Name
String				ls_Highest_Class
String				ls_Stowage
Boolean				lb_First						= TRUE
Boolean				lb_Break_on_Class
Boolean				lb_Group_Break				= FALSE
Boolean				lb_Distribution			= FALSE
Boolean				lB_Error_on_Acrobat		= FALSE
Boolean				lb_Stowage_Missing
DataStore			lds_Cartdiagram, lds_Backlog
s_product_log		lstr_Log
uo_cart_diagram 			luo_cart_diagram
uo_tr_cart_allocation 	luo_TR_Alloc 


ll_Start = CPU()

//if ii_Do_NOT_Trace = 0 Then
//	f_trace("uo_client_label.of_create_tr_cartdiagram uodistribution Stowages " + String(upperbound(uodistribution.uostowages )))
//End If

f_trace("uo_client_label.of_create_tr_cartdiagram BEGIN")

if isvalid(w_progress_with_cancel) then
	w_progress_with_cancel.wf_setmessage(uf.translate("erstelle") + " " + uf.translate("Transporter Cart Diagramm"))
end if


dsCartdiagramsheet.reset()

li_Succ = of_get_flight_details( al_result_key, ll_flight_number, ls_suffix, ls_from, ls_to, ll_airline_key, ls_airline, ls_ac_type, &
											ls_dep_time, ls_ramp_time, ls_unit, ll_Leg_Number, ll_routing_id, ls_owner, ls_Config, &
											ls_cbox_from, ls_cbox_to, ls_kitchen_time, ll_transaction, ls_Registration )

// --------------------------------------------------------------------
// ermittle ops - CBASE-NAM-CR-12089
// --------------------------------------------------------------------
select		ctext 
into			:ls_OPS
from			loc_operations
where			cunit = :ls_Unit
and			:ls_Dep_Time between ctime_from and ctime_to
and			nsort = (select max(nsort) 
							from	loc_operations  
							where	cunit = :ls_Unit
							and	:ls_Dep_Time between ctime_from and ctime_to );




luo_cart_diagram			= create uo_cart_diagram
luo_cart_diagram.iTrace = s_app.iTrace
luo_cart_diagram.idt_Departure = ddeparture

//il_transaction
luo_cart_diagram.of_sd_init_flight(al_result_key, ll_transaction, FALSE, ls_Unit, ll_airline_key)

luo_cart_diagram.ib_Mode_TR_Cart = TRUE

If isvalid(inv_copy_settings) then
	luo_cart_diagram.inv_copy_settings = inv_copy_settings
End If

lds_Cartdiagram	= create datastore
lds_Backlog			= create datastore

lds_Cartdiagram.dataobject="dw_packinglist_content_edit"
lds_Cartdiagram.settransobject(SQLCA)

lds_Backlog.dataobject="dw_uo_layout_backlog"
lds_Backlog.settransobject(SQLCA)

lResultKeys = al_Result_keys
// -------------------------------------------------------------------
// Ermittle relevante St$$HEX1$$fc00$$ENDHEX$$cklisten f$$HEX1$$fc00$$ENDHEX$$r TR Cart 
// -------------------------------------------------------------------
f_set_printer( as_CurrentPrinter )

lb_Distribution = FALSE

//If rab_Distr_Done = TRUE Then
	If isvalid(uodistribution) Then
		If upperbound(uodistribution.uoStowages) < 1 Then
			lb_Distribution = TRUE
//			rab_Distr_Done = FALSE
		else
			For ll_Distr_Stowage_Counter = 1 To upperbound(uodistribution.uoStowages) 
				If isvalid(uodistribution.uoStowages[ll_Distr_Stowage_Counter]) then
					ls_temp = uodistribution.uoStowages[ll_Distr_Stowage_Counter].sStowage
					f_trace("of_create_tr_cartdiagram BEFORE of_tr_cartdiagram_sheet uodistribution.uoStowages["+String(ll_Distr_Stowage_Counter)+"].sStowage " + ls_temp)
				Else
					f_trace("of_create_tr_cartdiagram BEFORE of_tr_cartdiagram_sheet uodistribution.uoStowages["+String(ll_Distr_Stowage_Counter)+"] IS NOT VALID " )
					lb_Distribution = TRUE
				End If		
			Next	
		end if
//	else
//		rab_Distr_Done = FALSE
	end if
//End If

If lb_Distribution AND rab_Distr_Done Then
	bmanueldistribution = FALSE
	bmanueldistributiononerror = FALSE
End If

//lb_Distribution = bDistribution
//lb_Distribution = NOT rab_Distr_Done

li_Ret = of_tr_cartdiagram_sheet(as_LabelFilter, lb_Distribution )
if li_Ret = -1000 then
	return -1000
elseif li_Ret = 0 then

	if ii_Do_NOT_Trace = 0 Then
		f_trace("uo_client_label.of_create_tr_cartdiagram uodistribution Stowages " + String(upperbound(uodistribution.uostowages )))
	End If
	f_trace("uo_client_label.of_create_tr_cartdiagram dsCartdiagramSheet.RowCount() " + String(dsCartdiagramSheet.RowCount()))	

	If isvalid(uodistribution) then
		f_trace("of_create_tr_cartdiagram upperbound(uodistribution.uoStowages) " + String(upperbound(uodistribution.uoStowages)))
//		For ll_Distr_Stowage_Counter = 1 To upperbound(uodistribution.uoStowages) 
//			//If Trim(ls_Stowage) = Trim(uodistribution.uoStowages[ll_Distr_Stowage_Counter].sStowage) 
//			ls_temp = uodistribution.uoStowages[ll_Distr_Stowage_Counter].sStowage
//			if ii_Do_NOT_Trace=0 then
//				f_trace("of_create_tr_cartdiagram uodistribution.uoStowages["+String(ll_Distr_Stowage_Counter)+"].sStowage " + ls_temp)
//			End if
//		Next
	Else
		f_trace("of_create_tr_cartdiagram uodistribution NOT VALID")
	End if
		
	If isvalid(uodistribution) then
		f_trace("of_create_tr_cartdiagram upperbound(uodistribution.uoStowages) " + String(upperbound(uodistribution.uoStowages)))
		For ll_Distr_Stowage_Counter = 1 To upperbound(uodistribution.uoStowages) 
			If  isvalid(uodistribution.uoStowages[ll_Distr_Stowage_Counter]) then
				ls_temp = uodistribution.uoStowages[ll_Distr_Stowage_Counter].sStowage
				f_trace("of_create_tr_cartdiagram uodistribution.uoStowages["+String(ll_Distr_Stowage_Counter)+"].sStowage " + ls_temp)
			Else
				f_trace("of_create_tr_cartdiagram uodistribution.uoStowages["+String(ll_Distr_Stowage_Counter)+"] IS NOT VALID " )
			End If				
		Next
	Else
		f_trace("of_create_tr_cartdiagram uodistribution NOT VALID")
	End if	
		
	//if ii_Do_NOT_Trace = 0 then This.dsLoading.saveas(f_gettemppath() + "TR_Cart_dsLoading_" + String(Rand(32767)) + String(now(), "hhmmss") + ".XLS", excel5!, True)

	// -------------------------------------------------------------------
	// Content Sheet versorgen
	// -------------------------------------------------------------------
	//li_Succ = of_create_tr_cartdigram_cs(ab_content_sheet, al_result_key, uodistribution )
	//li_Succ = luo_cart_diagram.of_create_tr_cartdigram_cs(ab_content_sheet, al_result_key, uodistribution, iuocontentsheet, dsloading )

	ll_Cart_Counter = 0

	if isNull(ls_Owner)		then ls_Owner		= ""
	if isNull(ls_ac_type)	then ls_ac_type	= ""
	if isNull(ls_Config)		then ls_Config		= ""
	
	//ras_file_name = f_gettemppath() + "CBASE-TRCARTDIAGRAM-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
	
	ls_File_Name = ls_Airline + String(ll_Flight_Number, "000") + "_" + ls_From + "_" + ls_to + "_" + String(ddeparture, "YYYYMMDD")
	ls_File_Name += "_TC_" + String(ll_transaction) + "_" + String(Rand(32000),"00000") + ".PDF"
	ras_file_name 	= f_gettemppath() + ls_File_Name 
	
	// --------------------------------------------
	//  Seitenzahl herausfinden
	// --------------------------------------------
	
	If luo_cart_diagram.of_get_tr_cart_type(s_app.smandant, as_Unit, ll_Airline_key, ll_Routing_ID) < 0 then
		DESTROY	luo_cart_diagram
		DESTROY	lds_Cartdiagram
		DESTROY	lds_Backlog
		DESTROY	luo_TR_Alloc 

		if ii_Do_NOT_Trace = 0 Then f_trace("uo_client_label.of_create_tr_cartdiagram NO VALID TR CART " + as_unit + " CRASH") 

		Return -1001
	Else
	
	If luo_cart_diagram.of_is_use_class_enabled() Then
		// Wenn Sort by Class = JA und TOP-DOWN = JA dann
		// ----------------------------------------------------------------
		// nach Class Number statt cClass => erstmal einbauen (Dummy Feld)
		// ----------------------------------------------------------------
		For ll_Count = 1 To dsCartdiagramSheet.RowCount()
			ls_Temp = dsCartdiagramSheet.GetItemString(ll_Count, "sclass")
			ll_Class_Number = f_get_class_key(ls_Temp, ll_Airline_Key)
			li_Succ = dsCartdiagramSheet.SetItem(ll_Count, "nclass_number", ll_Class_Number)			
		Next
		//li_Succ = This.dsCartdiagramSheet.SetSort("nclass_number ASC, Sstowage ASC, sworkstation ASC, sloadinglist ASC")
		li_Succ = This.dsCartdiagramSheet.SetSort("nclass_number ASC, nsort_galley ASC, nsort_stowage ASC, Sstowage ASC, sworkstation ASC, sloadinglist ASC")
		li_Succ = This.dsCartdiagramSheet.Sort()
		if ii_Do_NOT_Trace = 0 Then f_trace("USE CLASS ENABLED TRUE")
	Else
		// --------------------------------------------------------------------------
		// F$$HEX1$$fc00$$ENDHEX$$r TripTicket: suche h$$HEX1$$f600$$ENDHEX$$chste Klasse
		// --------------------------------------------------------------------------
		For ll_Count = 1 To dsCartdiagramSheet.RowCount()
			ls_Temp = dsCartdiagramSheet.GetItemString(ll_Count, "sclass")
			ll_Class_Number = f_get_class_key(ls_Temp, ll_Airline_Key)
			If ll_Highest_Class > ll_Class_Number Then
				ll_Highest_Class = ll_Class_Number
				ls_Highest_Class = ls_Temp
			End if
			li_Succ = dsCartdiagramSheet.SetItem(ll_Count, "nclass_number", ll_Class_Number)			
		Next
		// Ohne Klassenbezug? 
		//li_Succ = This.dsCartdiagramSheet.SetSort("Sstowage ASC, sworkstation ASC, sloadinglist ASC")
		
		li_Succ = This.dsCartdiagramSheet.SetSort("nsort_galley ASC, nsort_stowage ASC")
		
		li_Succ = This.dsCartdiagramSheet.Sort()
		if ii_Do_NOT_Trace = 0 Then f_trace("TR Cart Diagram	USE CLASS ENABLED FALSE")
	End If

	ll_TRCartPagesMax	= 0
	ll_TRCartPages		= 0
	
	if isvalid(w_progress_with_cancel) then
		w_progress_with_cancel.wf_setmin(1)
		w_progress_with_cancel.wf_setmax(This.dsCartdiagramSheet.Rowcount() + 1 )
	end if
	
	luo_TR_Alloc = CREATE uo_tr_cart_allocation  
	If luo_cart_diagram.of_is_fill_top_down_enabled() Then
		li_Fill_Type = luo_TR_Alloc.FILL_TOP_DOWN
	Else
		li_Fill_Type = luo_TR_Alloc.FILL_FROM_BOTTOM
	End If
	
	// ------------------------------------------------------------------------------------------------------
	// entferne alle mit Workstation Exclusion 
	// ------------------------------------------------------------------------------------------------------
	li_Succ = luo_cart_diagram.of_apply_tr_workstation_exclusions(as_unit, luo_tr_alloc, ll_airline_key, ll_routing_id, li_fill_type, dscartdiagramsheet)
	
	// ------------------------------------------------------------------------------------------------------
	// entferne alle mit of_is_cartdiagram_enabled = FALSE, alle aus Exclusion List, und alle ohne Inhalt
	// ------------------------------------------------------------------------------------------------------
	li_Succ = luo_cart_diagram.of_tr_remove_entries(uodistribution, as_unit, ads_exclusions, dscartdiagramsheet )
				
	// --------------------------------------------------------------------
	// Ermittle Anzahl Seiten
	// --------------------------------------------------------------------
	ll_TRCartPagesMax = luo_cart_diagram.of_count_tr_cart_pages(as_unit, luo_tr_alloc, ll_airline_key, ll_routing_id, li_fill_type, dscartdiagramsheet)

	ll_TRCartPages = 1
	// -------------------------------------------------------------------
	// Schleife $$HEX1$$fc00$$ENDHEX$$ber gefundene St$$HEX1$$fc00$$ENDHEX$$cklisten (Zeichnen)
	// -------------------------------------------------------------------	
	For ll_Row = 1 to This.dsCartdiagramSheet.Rowcount()
		
		li_Succ = of_create_tr_cartidagram_main(ll_row, luo_cart_diagram, ll_airline_key , ls_unit ,ls_dep_time, ll_routing_id, &
															lds_backlog, lds_cartdiagram, luo_tr_alloc, ab_content_sheet, uodistribution, ab_tt_without_tr ,&
															ll_catering_leg, ll_trcartpagesmax, ll_cart_counter, ll_highest_class , &
															ls_highest_class, as_currentprinter, ls_airline, ll_flight_number , &
															ls_suffix, ls_header, ls_from, ls_to, ls_ac_type, ls_owner , &
															ls_config, ls_production_range, ls_ops, ls_ramp_time, ls_kitchen_time ,&
															ll_filecounter, ls_pdffiles, ls_cbox_from, ls_cbox_to, ll_leg_number, lb_First, ll_TRCartPages )
	
	Next

	// Erst mal pr$$HEX1$$fc00$$ENDHEX$$fen ob es etwas zum zusammenfassen gibt
	if upperbound(ls_PdfFiles) > 0 then
		if isvalid(w_progress_with_cancel) then
			w_progress_with_cancel.wf_setstatus( uf.translate("Zusammenfassen")  )
		end if

		// ------------------------------------------------------
		// Nicht drucken, wenn nut TripTicket ben$$HEX1$$f600$$ENDHEX$$tigt
		// ------------------------------------------------------
		If NOT ab_TT_Without_TR Then
			if s_app.uo_pdf.of_concatenate(ls_PdfFiles, ras_file_name, true) <> 0 then
				li_Succ = -1
				lB_Error_on_Acrobat = TRUE
				if ii_Do_NOT_Trace = 0 then f_trace("of_create_tr_cartdiagram MERGE lb_Error_on_Acrobat")
			Else
				li_Succ = 1
			end if
		end if
		
		// ------------------------------------------------------
		// Nicht drucken, wenn nut TripTicket ben$$HEX1$$f600$$ENDHEX$$tigt
		// ------------------------------------------------------
		If ab_TT_Without_TR = FALSE AND ab_PrintDirectly = TRUE Then
			s_app.uo_pdf.of_print(ras_file_name, as_CurrentPrinter)
		end if		
	end if
	end if				
end if

//f_set_printer(sDefaultPrinter)
	
ral_Cart_Pages	= ll_Cart_Counter

ll_Stop = CPU()

// --------------------------------------------------------------
// Aktion protokollieren
// --------------------------------------------------------------
lstr_Log.lResultKey		= al_result_key
lstr_Log.lTransaction	= ll_transaction 
lstr_Log.lProduct   		= PRODUCT_TR_cart_diagram
lstr_Log.lDuration   	= (ll_Stop - ll_Start) / 1000
lstr_Log.sWorkstation   = s_app.sHost
lstr_Log.sUser   			= s_app.sUser
lstr_Log.lLabelQuantity = 0
lstr_Log.lDistribution  = 0
lstr_Log.sLabelAreas 	= ""
of_Product_log(lstr_Log)

DESTROY	luo_cart_diagram
DESTROY	lds_Cartdiagram
DESTROY	lds_Backlog
DESTROY	luo_TR_Alloc 

If ab_content_sheet Then
	If dsLoading.rowcount() > 0 then
		dsLoading.RowsCopy(1, dsLoading.RowCount(), Primary!, iuoContentSheet.dsLoading , iuoContentSheet.dsLoading.RowCount() + 1, Primary!)	
	end if	
End If

if ii_Do_NOT_Trace = 0 Then f_trace("uo_client_label.of_create_tr_cartdiagram END")

// Document Engine st$$HEX1$$fc00$$ENDHEX$$rzt bei GarbageCollect() ab
If getApplication().AppName = "cbase" Then GarbageCollect()
//GarbageCollect()
Yield()

Return 1

end function

protected function integer of_create_tr_cartdiagram_distr_comp (boolean ab_content_sheet, long al_row, s_component astr_component_single, ref uo_distribution rauo_distribution, string as_stowage, ref uo_cart_diagram rauo_cart_diagram, ref string ras_distribution_items[], ref string ras_suppressed_items[]);/*
* Objekt : uo_client_label
* Methode: of_create_tr_cartdiagram_distr_comp (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 23.08.2012
*
* Argument(e):
*	 boolean ab_content_sheet
*	 long al_row
*	 s_component astr_component_single
*	 ref uo_distribution rauo_distribution
*	 string as_stowage
*	 ref uo_cart_diagram rauo_cart_diagram
*	 ref string ras_distribution_items[]
*
* Beschreibung:		Komponenten f$$HEX1$$fc00$$ENDHEX$$r Drawer einsammeln 
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	23.08.2012		Erstellung
* 1.1 			O.Hoefer	29.10.2012		Disable Secondary Distribution
* 1.2 			O.Hoefer	19.11.2012		Umbau Disable Secondary Distribution - f$$HEX1$$fc00$$ENDHEX$$lle Array "Suppress"
* 1.3 			O.Hoefer	10.01.2013		Bugfix Distr Comp - TR without CS
* 1.4 			O.Hoefer	17.01.2013		Distr Comp  aus MZV sollen entfallen, wenn secondary distr. AUS
*
*
* Return: integer
*
*/

Integer		li_Succ
Long			ll_RowId, ll_Content_Header_Detail_Key, ll_New_Row, ll_Header_Sort_Counter
Long			ll_Distr_Stowage_Counter, ll_Distr_Counter
Long			ll_Qty
Long			ll_pltype_key, ll_pl_distribution_key
Long			ll_Disable_2nd_Distr
String		ls_pl_type
Long			ll_Found
String		ls_temp_content, ls_Loading_Header_PL, ls_Temp_Stowage
String		ls_Empty[]
String		ls_temp_content_pl
String		ls_Temp
String		ls_Find
String		ls_Meal_Control_Code
Boolean		lb_Breakpoint
s_component	lstr_Empty, lstr_component_single
s_distrib_items	ls_Distributed_Items[], ls_Empty_Array[]

// --------------------------------------------------------
// Beginn verteilte Komponenten f$$HEX1$$fc00$$ENDHEX$$r Drawer einsammeln 				
// --------------------------------------------------------
//If ab_Content_sheet = FALSE Then
	If Isvalid(rauo_distribution) Then
		ras_Distribution_Items = ls_Empty				
		if ii_Do_NOT_Trace= 0 then f_trace("uo_client_label.of_create_tr_cartdiagram upperbound Stowages "+ String(upperbound(rauo_distribution.uoStowages)))				
		For ll_Distr_Stowage_Counter = 1 To upperbound(rauo_distribution.uoStowages) 
			
			If isvalid(uodistribution.uoStowages[ll_Distr_Stowage_Counter]) then
				f_trace("of_create_tr_cartdiagram BEFORE of_tr_cartdiagram_sheet uodistribution.uoStowages["+String(ll_Distr_Stowage_Counter)+"].sStowage " + ls_temp)
			Else
				f_trace("of_create_tr_cartdiagram BEFORE of_tr_cartdiagram_sheet uodistribution.uoStowages["+String(ll_Distr_Stowage_Counter)+"] IS NOT VALID " )
				CONTINUE
			End If					
			
			// Richtiger Stauort?	
			If as_Stowage = Trim(rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].sStowage) Then
				If trim(as_Stowage) = "G4-452"  then
					lb_breakpoint=TRUE
				End if
				For ll_Distr_Counter = 1 To rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.RowCount()
					// ---------------------------------------------------------------------
					// Switch Off Secondary Distr. CBASE-CR-NAM-12050
					// ---------------------------------------------------------------------
					ll_pltype_key				= rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.getitemnumber(ll_Distr_Counter,"npltype_key")
					ll_pl_distribution_key	= rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.getitemnumber(ll_Distr_Counter,"npl_distribution_key")
					ls_pl_type					= rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.getitemstring(ll_Distr_Counter,"cpl_type")
					ls_meal_control_code		= rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.getitemstring(ll_Distr_Counter,"cmeal_control_code")
					ls_Find  = "npltype_key=" + String(ll_pltype_key) +  " AND "
					ls_Find += "npl_distribution_key=" + String(ll_pl_distribution_key)+  " AND "
					ls_Find += "ctext='" + ls_pl_type+  "' AND "
					ls_Find += "cmeal_control_code='" + ls_meal_control_code+  "'"
					
					If ls_pl_type = "JUI" OR ls_pl_type = "OJ" then
						lb_breakpoint=TRUE
					End if
					ll_Disable_2nd_Distr = 0
					ll_Found = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsPackinglistSize.Find(ls_Find, 1, rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsPackinglistSize.RowCount())
					If ll_Found > 0 then
						ll_Disable_2nd_Distr =  rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsPackinglistSize.getitemnumber(ll_Found,"ndisable_2nd_distribution")
						If isnull(ll_Disable_2nd_Distr) then ll_Disable_2nd_Distr = 0 						
					End If
					If ll_Disable_2nd_Distr = 1 then
						//CONTINUE
					End if
					
					ll_New_Row = iuoContentSheet.dsLoadingContents.InsertRow(0)
					li_Succ = iuoContentSheet.dsLoadingContents.SetItem(ll_New_Row, "nrowid", ll_RowId)
					li_Succ = iuoContentSheet.dsLoadingContents.SetItem(ll_New_Row, "ndetail_key", ll_Content_Header_Detail_Key	)
					if ii_Do_NOT_Trace= 0 then f_trace("uo_client_label.of_create_tr_cartdiagram ab_Content_sheet=FALSE DISTRIBUTION Stowage " + rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].sStowage)
					ls_temp_content_pl = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.GetItemString(ll_Distr_Counter , "cpackinglist")
					ls_temp_content = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.GetItemString(ll_Distr_Counter , "ctext")
					ll_Qty = rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].dsContent.GetItemNumber(ll_Distr_Counter , "nquantity")
					lstr_component_single = lstr_Empty
					lstr_component_single.ssnr			= ls_temp_content_pl
					lstr_component_single.stext		= ls_temp_content
					lstr_component_single.lquantity	= ll_Qty
					lstr_component_single.squantity	= String(ll_Qty)
					ls_Temp = rauo_cart_diagram.of_get_item_description(lstr_component_single)	
					
					If ll_Disable_2nd_Distr = 1 then
						// Do Not Print
						//ras_Suppressed_Items[upperbound(ras_Suppressed_Items) + 1] = ls_Temp
						ras_Suppressed_Items[upperbound(ras_Suppressed_Items) + 1] = ls_temp_content_pl
						CONTINUE
					End if
					
					//--------------------------------------------------------------------
					// wenn secondary distr. aus: MZV l$$HEX1$$f600$$ENDHEX$$schen
					//--------------------------------------------------------------------
					If bSecondaryDistribution = FALSE Then
						f_trace("uo_client_label.of_create_tr_cartdiagram Secondary DISTRIBUTION OFF " + ls_temp)
						CONTINUE
					
					End If
					
					
					//If ab_Content_sheet Then
						// 10.01.2013 Bugfix Distr Comp were missing - TR without CS
						ras_Distribution_Items[upperbound(ras_Distribution_Items) + 1] = ls_Temp
						
					//End if
				
					if ii_Do_NOT_Trace= 0 then f_trace("uo_client_label.of_create_tr_cartdiagram content aus DISTRIBUTION " + ls_temp)
				Next
			Else
				//if ii_Do_NOT_Trace= 0 then f_trace("uo_client_label.of_create_tr_cartdiagram WRONG Stowage " + as_Stowage + " => " + rauo_distribution.uoStowages[ll_Distr_Stowage_Counter].sStowage)
			End If
		Next
	Else
		if ii_Do_NOT_Trace= 0 then f_trace("uo_client_label.of_create_tr_cartdiagram Isvalid(rauo_distribution) FALSE")
	End If
//Else
//	if ii_Do_NOT_Trace= 0 then f_trace("uo_client_label.of_create_tr_cartdiagram ab_Content_sheet TRUE")
//End if
//

Return 1



end function

public function integer of_get_healthmark_info (string asunit, ref string asheader, ref string asdetail, ref string asfooter);// --------------------------------------------------------------------------------
// Objekt : uo_label_other
// Methode: of_fill_healthmark (Function)
// Autor  : M. Barfknecht
// --------------------------------------------------------------------------------
// Argument(e):
// string sunit
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung: Bef$$HEX1$$fc00$$ENDHEX$$llt ishealthmark_header, ..footer und ..detail
//						mit Werten aus sys_units
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  18.01.2013	           M.Barfknecht       Erstellung
//
// --------------------------------------------------------------------------------

string sheader, sdetail,sfooter
long lflight
date lddeparture
f_trace("uo_client_label.of_label BEFORE of_get_healthmark ")

if trim(asunit) <> "" then
	//Dann die Felder bef$$HEX1$$fc00$$ENDHEX$$llen
	select CHEALTHMARK1,CHEALTHMARK2,CHEALTHMARK3
	into :sheader,:sdetail,:sfooter
	from sys_units
	where cunit =:asunit;
end if
	
trim(sheader)
trim(sdetail)
trim(sfooter)

asdetail = sdetail
asheader = sheader
asfooter = sfooter
f_trace("uo_client_label.of_label END of_get_healthmark ")

return 0
end function

public function string of_remove_mealcode (string svalue);// --------------------------------------------------------------------------------
// Objekt : uo_distribution
// Methode: of_remove_mealcode (Function)
// Autor  : M. Barfknecht
// --------------------------------------------------------------------------------
// Argument(e):
// string svalue
// --------------------------------------------------------------------------------
// Return: string
// --------------------------------------------------------------------------------
//  Beschreibung: Entfernt den Mealcode aus sValue
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  30.01.2013	           M.Barfknecht       Erstellung
//
// --------------------------------------------------------------------------------

string sreturn
long iPos

if len(svalue) = 0 then return svalue

iPos = Pos(svalue,"~n")

if iPos= 0 then 
	Return svalue
else
	sreturn = Left(svalue, iPos - 3) +"~n"
	sreturn = sreturn + of_remove_mealcode(mid(svalue,iPos +1,len(svalue)))
end if

return sreturn
end function

event constructor;// Objekt zur Berechnung von Schriftgr$$HEX2$$f600df00$$ENDHEX$$en erstellen
iuo_FontCalc = CREATE uo_font_calc 

// uoLabel = Create uo_label_other	

// --------------------------------------------------------
// Die LL und SLL die f$$HEX1$$fc00$$ENDHEX$$r die Beladung verwendet werden
// --------------------------------------------------------
dsLoadinglists									= Create DataStore
dsLoadinglists.DataObject 					= "dw_cen_out_all_loadinglists"
dsLoadinglists.SetTransObject(SQLCA)

//
// 02.11.2007 nur Infos f$$HEX1$$fc00$$ENDHEX$$r die Reports
//
dsLoadinglistsInfoOnly								= Create DataStore
dsLoadinglistsInfoOnly.DataObject 					= "dw_cen_out_all_loadinglists"
dsLoadinglistsInfoOnly.SetTransObject(SQLCA)

dsExternalLoadinglists						= Create DataStore
dsExternalLoadinglists.DataObject 		= "dw_cen_out_all_loadinglists"


// --------------------------------------------------------
// Die LL und SLL die f$$HEX1$$fc00$$ENDHEX$$r die Beladung verwendet werden
// Aus der History
// --------------------------------------------------------
dsLoadinglistsHistory									= Create DataStore
dsLoadinglistsHistory.DataObject 					= "dw_cen_out_all_loadinglists_from_history"
dsLoadinglistsHistory.SetTransObject(SQLCA)

// --------------------------------------------------------
// Die lokalen Arbeitspl$$HEX1$$e400$$ENDHEX$$tze
// --------------------------------------------------------
dsWorkstations									= Create DataStore
dsWorkstations.DataObject 					= "dw_workstations_local"
dsWorkstations.SetTransObject(SQLCA)
// --------------------------------------------------------
// Der entsprechende Datensatz aus der cen_out 
// --------------------------------------------------------
dsCenOut											= Create DataStore
dsCenOut.DataObject 							= "dw_cen_out_single_flight"
dsCenOut.SetTransObject(SQLCA)

dsCenOutHistory								= Create DataStore
dsCenOutHistory.DataObject					= "dw_cen_out_single_flight_history"
dsCenOutHistory.SetTransObject(SQLCA)

// --------------------------------------------------------
// Der Datastore f$$HEX1$$fc00$$ENDHEX$$r die SPML's
// --------------------------------------------------------
dsSPMLDetails											= Create DataStore
dsSPMLDetails.DataObject 							= "dw_label_spml_detail"
dsSPMLDetails.SetTransObject(SQLCA)

// --------------------------------------------------------
// Datastore der Objekte im Label
// --------------------------------------------------------
dsLabelObjects								= Create DataStore
dsLabelObjects.DataObject					= "dw_uo_label_objects"
dsLabelObjects.SetTransObject(SQLCA)

dsLabelType									= Create DataStore
dsLabelType.DataObject					= "dw_uo_label_types"
dsLabelType.SetTransObject(SQLCA)



// --------------------------------------------------------
// na was wohl !?!?!?!
// --------------------------------------------------------
dsLoading										= Create DataStore
dsLoading.DataObject 						= "dw_loading_list_result"
dsLoading.SetTransObject(SQLCA)

uoLabel											= Create uo_label_other	
uoEmptyLabel  									= Create uo_label_other	

dsCheckSheet   								= create Datastore
dsCheckSheet.DataObject 					= "dw_uo_check_sheet"

// 19.08.2009 Ulrich Paudler [UP]
dsCartdiagramSheet   								= create Datastore
dsCartdiagramSheet.DataObject 					= "dw_uo_cartdiagram_sheet"

// --------------------------------------------------------
// 10.03.2011, KF
// --------------------------------------------------------
iuoContentSheet = Create	uo_content_sheet

// --------------------------------------------------------
// Die Wochentage !!!
// --------------------------------------------------------
if this.iWebService = 0 then
	sWeekdays[1] = uf.translate("So")
	sWeekdays[2] = uf.translate("Mo")
	sWeekdays[3] = uf.translate("Di")
	sWeekdays[4] = uf.translate("Mi")
	sWeekdays[5] = uf.translate("Do")
	sWeekdays[6] = uf.translate("Fr")
	sWeekdays[7] = uf.translate("Sa")
else
	sWeekdays[1] = "Sun"
	sWeekdays[2] = "Mon"
	sWeekdays[3] = "Thu"
	sWeekdays[4] = "Wed"
	sWeekdays[5] = "Thu"
	sWeekdays[6] = "Fri"
	sWeekdays[7] = "Sat"
end if

isMandant	= s_app.sMandant
isUnit		= s_app.sWerk

// -------------------------------------------
iuo_tripticket = CREATE uo_tripticket	
iuoContentSheet= CREATE uo_content_sheet
//uo_content_sheet 		iuoContentSheet


end event

on uo_client_label.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_client_label.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;// Objekt zur Berechnung von Schriftgr$$HEX2$$f600df00$$ENDHEX$$en zerst$$HEX1$$f600$$ENDHEX$$ren
DESTROY iuo_FontCalc 

if isvalid(dsLoadinglists) then Destroy(dsLoadinglists)
if isvalid(dsLoadinglistsInfoOnly) then Destroy(dsLoadinglistsInfoOnly)
if isvalid(dsLoadinglistsHistory) then  Destroy(dsLoadinglistsHistory)
if isvalid(dsExternalLoadinglists) then Destroy(dsExternalLoadinglists)
if isvalid(dsCenOut) then Destroy(dsCenOut)
if isvalid(dsCenOutHistory) then Destroy(dsCenOutHistory)
if isvalid(dsLoading) then Destroy(dsLoading)
if isvalid(dsWorkstations) then Destroy(dsWorkstations)
if isvalid(dsCheckSheet) then Destroy(dsCheckSheet)
if isvalid(dsLabelObjects) then Destroy(dsLabelObjects)
if isvalid(dsLabelType) then Destroy(dsLabelType)
if isvalid(dsSPMLDetails) then Destroy(dsSPMLDetails)
if isvalid(uoLabel) then Destroy(uoLabel)
if isvalid(uoEmptyLabel) then Destroy(uoEmptyLabel)
if isvalid(dsCartdiagramSheet) then Destroy(dsCartdiagramSheet)
if isvalid(iuoContentSheet) then Destroy(iuoContentSheet)

// ------------------------------------------------------
if isvalid(iuo_tripticket) then Destroy(iuo_tripticket)
//if isvalid(idsLoading) then Destroy(idsLoading)
//if isvalid(idsLoadingHeader) then Destroy(idsLoadingHeader)
//if isvalid(idsLoadingContents) then Destroy(idsLoadingContents)



end event

