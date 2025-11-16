HA$PBExportHeader$uo_distribution.sru
$PBExportComments$Die Mahlzeitenverteilung.~r~n~r~n- Mahlzeitenmengenermittung~r~n- Verteilungsregelermittlung~r~n- Mengeverteilung
forward
global type uo_distribution from nonvisualobject
end type
end forward

global type uo_distribution from nonvisualobject
end type
global uo_distribution uo_distribution

type variables
//Automatische Verteilung in PPS JA/NEIN HR 19.03.2008 (LSY-PPS-C-08-0008)
boolean bPPSDistribution = TRUE
boolean bReturnWithoutAbort = True // 26.02.2015 HR: CBASE-CFC-CR-2014-001
// --------------------------------------------------------
// Die Mutter aller Informationen
// --------------------------------------------------------
long	lResultKey		// Leg 1
long	lGroupKey		
Long	lResultKeys[]	// alle Legs
// --------------------------------------------------------
// Beladung, 
// zuvor mit uo_loading_list ermittelt
// --------------------------------------------------------
datastore dsLoadinglist
datastore dsDistribution

// --------------------------------------------------------
// Die "Kopfinformationen" aus cen_out
// --------------------------------------------------------
datastore dsFlight
datastore dsLeg

// --------------------------------------------------------
// Die FLUGGER$$HEX1$$c400$$ENDHEX$$TE - Informationen
// --------------------------------------------------------
datastore dsAircraft

// --------------------------------------------------------
// Mahlzeiten/Komponenten aus cen_out_meals
// --------------------------------------------------------
datastore dsMeals
datastore dsAdditional

// --------------------------------------------------------
// Mahlzeiten/Komponenten aus cen_out_meals
// werden in diese Datastores kopiert, damit
// die Standardverteilroutinen verwendet werden
// k$$HEX1$$f600$$ENDHEX$$nnen.
// --------------------------------------------------------
datastore dsSPMLDistribution
datastore dsSPMLDistributionMaster
datastore dsAdditionalDistribution

// --------------------------------------------------------
// SPMLs aus cen_out_spml / cen_out_spml_detail
// --------------------------------------------------------
datastore dsSPML

// --------------------------------------------------------
// H$$HEX1$$f600$$ENDHEX$$hen und Tiefen der St$$HEX1$$fc00$$ENDHEX$$cklisten
// --------------------------------------------------------
datastore dsPackinglistSizes
datastore dsPackinglistSizeFind
// --------------------------------------------------------
// Labeltypen
// --------------------------------------------------------
datastore dsLabelTypes

// --------------------------------------------------------
// MCD Schalter
// --------------------------------------------------------
integer	iMCD
// --------------------------------------------------------
// Schalter "Mischbeh$$HEX1$$e400$$ENDHEX$$ltnisse zuletzt verteilen"
// --------------------------------------------------------
integer	iMixed
// --------------------------------------------------------
// Schalter SPML's kummuliert verteilen
// --------------------------------------------------------
integer	iAccumulateSPML
// --------------------------------------------------------
// Schalter SPML's nach der Kummulierung wieder explodieren
// --------------------------------------------------------
integer	iExplodeSPML

// --------------------------------------------------------
// St$$HEX1$$fc00$$ENDHEX$$cklistentypen
// --------------------------------------------------------
datastore dsPackinglistTypes

// --------------------------------------------------------
// Verteilerroutinenzuordnung
// --------------------------------------------------------
datastore dsDistributingMeals
datastore dsDistributingAdditional

// --------------------------------------------------------
// Array mit den Stauorten
// --------------------------------------------------------
uo_distribution_container	uoStowages[]

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// Achtung: $$HEX1$$c400$$ENDHEX$$nderungen des Arrays un der enthaltenen 
// DataStores m$$HEX1$$fc00$$ENDHEX$$ssen in: 
// * cbase_meal_disribution.uo_distribution.uf_store_distribution
// * cbase_meal_disribution.uo_distribution.uf_restore_distribution 
// sowie in den Tabellen
// * cen_out_md
// * cen_out_md_ps
// * cen_out_md_co
// nachgezogen werden.
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// --------------------------------------------------------
// Datastore ....
// --------------------------------------------------------
datastore dsControl

// --------------------------------------------------------
// Datastore der Objekte im Label
// --------------------------------------------------------
datastore dsLabelObjects

// --------------------------------------------------------
// Datastore der Stauortgruppenzuordnung
// --------------------------------------------------------
datastore 	dsStowageGroups
datastore 	dsStowageGroupValues
String		sStowageGroups[]	 	

// --------------------------------------------------------
// die Klassen der Airline
// --------------------------------------------------------
datastore dsClasses

// --------------------------------------------------------
// Informationen der Verteilerroutine
// --------------------------------------------------------
datastore dsDistributionParameter
datastore dsDistributionPriority

// --------------------------------------------------------
// Datastore f$$HEX1$$fc00$$ENDHEX$$r alle Komponenten, die nicht verteilt
// werden konnten
// --------------------------------------------------------
datastore dsDistributionErrors

// --------------------------------------------------------
// Report: Location Sheet
// --------------------------------------------------------
uo_location_sheet dsLocationSheet
// --------------------------------------------------------
// Report: Check Sheet
// --------------------------------------------------------
datastore dsCheckSheet
// --------------------------------------------------------
// Report: SPML Summary
// --------------------------------------------------------
datastore dsSPMLSummary
//-----------------------------------------------------
//Datastore f$$HEX1$$fc00$$ENDHEX$$r Airlinespezifische Komponentenverteilung
//-----------------------------------------------------
datastore dsAirlineInfo


// --------------------------------------------------------
// Datastores f$$HEX1$$fc00$$ENDHEX$$r Distribution per Aircraft Type 
// --------------------------------------------------------
datastore dsDistributionPerACType
datastore dsDistributionExceptions


// --------------------------------------------------------
// ein paar Variablen
// --------------------------------------------------------
String 	sError
String	sLogPath
String	sViewUnit
Integer 	iTrace
Long		lAircraftKey
Long		lAirlineKey
DateTime	dtDeparture
Boolean	bLocationSheet
Boolean	bCheckSheet
Boolean	bCheckSheetOnlyUsed
Boolean	bSPMLSummary
Boolean 	bManuelDistribution
Boolean 	bManuelDistributionOnError
String	sHandlingString
Blob		blbDistributionErrors
Blob		blbSPMLSummary
Blob		blbLocationSheet
Long		lBelly
Integer	iSPMLTextType
Integer  iResetPercentage = 0
Integer	iAddLabelOption = 0
Integer	iDivManualLeg = 0

Long					lLastValues[]
String					sLastClass	= ""
Boolean				bAskAgain 	= true
Long					lLastPercents[]
blob					bLastGroupValues
Integer				iWebService = 0
uo_pdf_handler		uoPDF
integer 				iAccumulateSPMLType	// 24.04.2013 HR: CBASE-AKL-CR-2013-003

// -----------------------------------------------------------
// CBASE-F4-CR-2015-014 Verteilerroutine pro Airline und A/C 
// -----------------------------------------------------------
Boolean				bNewDistrubtionAssignment = FALSE

PRIVATE:
//Objekt zur Berechnung von Schriftgr$$HEX2$$f600df00$$ENDHEX$$en
uo_font_calc iuo_FontCalc
end variables
forward prototypes
public function integer of_get_used_stowages (uo_distribution_container uoTemp[])
public function integer of_set_priority_maximun (long lmax, long lspml, ref datastore dsstowages)
public function integer of_log (string smsg)
public function datetime of_find_valid_label (long llabeltype, datetime dtsearch)
public function integer of_dump (long lrow, datastore dsdata, boolean bheader)
public function string of_checknull (string sval)
public function long of_checknull (long lVal)
public function integer of_move_spmls ()
public function integer of_get_classnumber (string sclass)
public function integer of_hide_columns ()
public function integer of_distribution_errorlist ()
public function s_distribution_parameters of_get_distribution_parameters_detail (long lkey, string sclass, long lpltype, string smealcontrolcode, integer ispml)
public function integer of_alternate (ref uo_distribution_container uotemp[], datastore dscontents, long lspml, boolean blast)
public function integer of_distribution (integer itype)
public function integer of_mcd_prepare ()
public function integer of_stuffed (ref uo_distribution_container uotemp[], datastore dscontents, long lspml, boolean blast)
public function integer of_add_text_to_label ()
public function integer of_add_classnumbers (integer itype)
public function integer of_get_distribution_parameters ()
public function integer of_load_components (integer itype)
public function integer of_get_dimensions ()
public function integer of_mcd_complete ()
public function uo_distribution of_clone ()
public function integer of_run ()
public function integer of_to_errorlist (integer itype)
public function integer of_absolute (ref uo_distribution_container uotemp[], datastore dscontents, long lrow, long lspml, boolean blast)
public function integer of_get_location_sheet ()
public function integer of_check_labeltypes ()
public function integer of_to_errorlist_stowage (long lstowage)
public function integer of_check_sheet ()
public function integer of_get_spml_sheet ()
public function String of_get_distribution_type_description (long lkey)
public function integer of_get_bosta (long lcurrentresultkey, ref string sclasses, ref string sbosta)
public function integer of_get_handling (long lcurrentresultkey)
public function integer of_get_location_sheet_old ()
public function integer of_set_sort ()
public function string of_remove_cr (string svalue)
public function integer of_dump_stowage_sort ()
public function integer of_dump_unit_priority ()
public function integer of_accumulate_spmls ()
public function integer of_explode_spmls ()
public function integer of_split_absolut (ref uo_distribution_container uotemp[], datastore dscontents, long lspml, boolean blast)
public function integer of_split (ref uo_distribution_container uotemp[], ref datastore dscontents, long lspml, boolean blast)
public function integer of_remove_multiclass_flag ()
public function integer of_unit_priority (long ldirection, string sclass, uo_distribution_container uousedstowages[])
public function integer of_distribution_joblist (ref datastore dscontents, integer itype)
public function integer of_divide_by_fixed_value (ref datastore dstemp, ref datastore dscontents)
public function integer of_divide_manually (ref datastore dstemp, ref datastore dscontents)
public function integer of_sort_by_max_free_space (long lrow, datastore dscomponents, ref uo_distribution_container uosort[])
public function integer of_sort_array (long larray[], integer ldirection)
public function integer of_divide_by_percent (ref datastore dstemp, ref datastore dscontents, integer ireusevalues)
public function integer of_reset_percentage (integer itype)
public function integer of_divide_by_fixed_value_old (ref datastore dstemp, ref datastore dscontents)
public function integer of_combine_spmls_old ()
public function integer of_combine_spmls ()
public function integer of_format_datastore_report (datastore odw, string sreporttitle)
public function boolean of_store_distribution ()
public function boolean of_restore_distribution ()
public function string of_remove_mealcode (string svalue)
public function integer of_run_pps ()
public function integer of_explode_spmlstype ()
public function integer of_get_distribution_parameters_by_ac ()
end prototypes

public function integer of_get_used_stowages (uo_distribution_container uoTemp[]);integer I, iRet

for i = 1 to Upperbound(uoTemp)
	
	iRet += uoTemp[i].iUse
	
next

return iRet
end function

public function integer of_set_priority_maximun (long lmax, long lspml, ref datastore dsstowages);
Long 		lRow
String 	sColumn


if lSPML = 0 then
	sColumn = "nranking"
else
	sColumn = "nranking_spml"
end if

for lRow = 1 to dsStowages.RowCount()

	if dsStowages.GetItemNumber(lRow, sColumn) = 1000 or &
		dsStowages.GetItemNumber(lRow, sColumn) = -1000 then
		
//	if dsStowages.GetItemNumber(lRow, sColumn) >= 1000 or &
//		dsStowages.GetItemNumber(lRow, sColumn) <= -1000 then
//		
//		if lMax >= 1000 then 
//			lMax = lMax + 1
//
//			
//		elseif lMax <= -1000 then
//			lMax = lMax - 1
//
//		end if
		
		dsStowages.SetItem(lRow, sColumn, lMax)
		
	end if
	
next

return 0
end function

public function integer of_log (string smsg);//----------------------------------------------------
// 
// LogFile schreiben
//
//----------------------------------------------------
integer iFile

if this.iTrace = 0 then return 0

iFile = FileOpen(this.sLogPath + "cbase_distribution.log", LineMode!, Write!, Shared!)
FileWrite(iFile, "[" + string(today(), "dd.mm.yyyy") + "-" + string(now(), "hh:mm:ss") + "] " + sMsg)
FileClose(iFile)

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

public function integer of_dump (long lrow, datastore dsdata, boolean bheader);// --------------------------------------------------
//
// Eine Zeile aus dem Datastore ins Logfile schreiben
//
// --------------------------------------------------
String sOut 		= ""
String sOutHeader = ""

if this.iTrace = 0 then return 0

if dsData.dataobject <> "dw_uo_cen_out_meals" then return -1

sOut = ""

sOutHeader += "CLASS "
sOut       += Mid(dsData.GetItemString(lRow, "cclass") + Space(100), 1, 6)

sOutHeader += "PACKINGLIST       "
sOut       += Mid(dsData.GetItemString(lRow, "cpackinglist") + Space(100), 1, 18)

sOutHeader += "PROD-TEXT           "
sOut       += Mid(dsData.GetItemString(lRow, "cproduction_text") + Space(100), 1, 20)

sOutHeader += "QUANTITY "
sOut       += Mid(String(dsData.GetItemNumber(lRow, "nquantity")) + Space(100), 1, 9)

sOutHeader += "D-KEY "
sOut       += Mid(dsData.GetItemString(lRow, "cmeal_control_code") + Space(100), 1, 6)

sOutHeader += "%   "
sOut       += Mid(String(dsData.GetItemNumber(lRow, "npercentage")) + Space(100), 1, 4)

sOutHeader += "PL-TYPE   "
sOut       += Mid(dsData.GetItemString(lRow, "sys_packinglist_types_ctext") + Space(100), 1, 10)

sOutHeader += "PL-TYPE-KEY "
sOut       += Mid(String(dsData.GetItemNumber(lRow, "npltype_key")) + Space(100), 1, 10)

sOutHeader += "HEIGHT "
sOut       += Mid(String(dsData.GetItemNumber(lRow, "nheight")) + Space(100), 1, 7)

sOutHeader += "DEPTH "
sOut       += Mid(String(dsData.GetItemNumber(lRow, "nwidth")) + Space(100), 1, 10)

if bHeader then
	this.of_log(sOutHeader)
	this.of_log(Fill("-", Len(sOutHeader)))
end if

of_log(sOut)


return 0
end function

public function string of_checknull (string sval);

if isnull(sVal) then return ""

return sVal
end function

public function long of_checknull (long lVal);

if isnull(lVal) then return 0

return lVal
end function

public function integer of_move_spmls ();// --------------------------------------------------------------------------
//
// Die SPML's stehen in anderen Tabellen als die normalen Mahlzeiten, damit
// die "normalen" Funktionen (of_distribut, of_absolut ...) auch f$$HEX1$$fc00$$ENDHEX$$r die
// SPML's verwendet werden k$$HEX1$$f600$$ENDHEX$$nnen ist es notwendig, die SPML's in einen
// Datatore von gleicher Struktur (cen_out_meals) wie die normalen Mahlzeiten
// zu kopieren
// 
// --------------------------------------------------------------------------

Long 	lRows, &
		a

for lRows = 1 to this.dsSPML.RowCount()
	
	a = this.dsSPMLDistribution.InsertRow(0)	

	this.dsSPMLDistribution.SetItem(a, "npackinglist_index_key", this.dsSPML.GetItemNumber(lRows, "npackinglist_index_key"))
	this.dsSPMLDistribution.SetItem(a, "nresult_key", this.dsSPML.GetItemNumber(lRows, "nresult_key"))
	this.dsSPMLDistribution.SetItem(a, "nclass_number", this.dsSPML.GetItemNumber(lRows, "nclass_number"))
	this.dsSPMLDistribution.SetItem(a, "cclass", this.dsSPML.GetItemString(lRows, "cclass"))
	this.dsSPMLDistribution.SetItem(a, "cpackinglist", this.dsSPML.GetItemString(lRows, "cpackinglist"))
	
	if this.iSPMLTextType = 1 then
		this.dsSPMLDistribution.SetItem(a, "cproduction_text", this.dsSPML.GetItemString(lRows, "cspml"))
	else
		this.dsSPMLDistribution.SetItem(a, "cproduction_text", this.dsSPML.GetItemString(lRows, "cen_out_spml_detail_cproduction_text"))
	end if
	
	this.dsSPMLDistribution.SetItem(a, "cremark", this.of_checknull(this.dsSPML.GetItemString(lRows, "cadd_text")))
	this.dsSPMLDistribution.SetItem(a, "nquantity", this.dsSPML.GetItemNumber(lRows, "nquantity"))
	this.dsSPMLDistribution.SetItem(a, "cmeal_control_code", this.dsSPML.GetItemString(lRows, "cen_out_spml_detail_cmeal_control_code"))
	this.dsSPMLDistribution.SetItem(a, "ncomponent_group", 0)
	this.dsSPMLDistribution.SetItem(a, "npercentage", 100)
	this.dsSPMLDistribution.SetItem(a, "sys_packinglist_types_ctext", this.of_checknull(this.dsSPML.GetItemString(lRows, "sys_packinglist_types_ctext")))
	this.dsSPMLDistribution.SetItem(a, "npltype_key", this.of_checknull(this.dsSPML.GetItemNumber(lRows, "npltype_key")))
	this.dsSPMLDistribution.SetItem(a, "nhandling_meal_key", 0)
	this.dsSPMLDistribution.SetItem(a, "nheight", this.dsSPML.GetItemNumber(lRows, "nheight"))
	this.dsSPMLDistribution.SetItem(a, "nwidth", this.dsSPML.GetItemNumber(lRows, "nwidth"))
	this.dsSPMLDistribution.SetItem(a, "cremark", this.of_checknull(this.dsSPML.GetItemString(lRows, "cadd_text")))
	this.dsSPMLDistribution.SetItem(a, "nspml", 1)
	
next


return 0
end function

public function integer of_get_classnumber (string sclass);// -------------------------------------------
//
// Klassensortierungsnummer ermitteln
//
// bei Mischbeh$$HEX1$$e400$$ENDHEX$$ltnissen wird die Nummer
// der ersten Klasse verwendet
//
// -------------------------------------------
string 	sClassName
Long		lClass, lRows

sClassName = Mid(sClass,1 ,1)

//sClassName = sClass

for lRows = 1 to this.dsClasses.RowCount()
	if sClassName = this.dsClasses.GetItemString(lRows, "cclass") then
		
		lClass = this.dsClasses.GetItemNumber(lRows, "nclass_number")
		
		return lClass
	end if
next

return -1
end function

public function integer of_hide_columns ();// -----------------------------------------------------
//
// ds_loading_list_result etwas $$HEX1$$fc00$$ENDHEX$$bersichtlicher machen
// Spalten die nicht interessieren werde ausgeblendet
// 
// -----------------------------------------------------
dsLoadingList.Modify("compute_1.visible=0")
dsLoadingList.Modify("compute_2.visible=0")
dsLoadingList.Modify("compute_3.visible=0")
dsLoadingList.Modify("compute_4.visible=0")
dsLoadingList.Modify("compute_actioncode.visible=0")
dsLoadingList.Modify("compute_exclude.visible=0")
dsLoadingList.Modify("cen_loadinglist_index_nloadinglist_key.visible=0")
dsLoadingList.Modify("cen_loadinglists_cactioncode.visible=0")
dsLoadingList.Modify("compute_qaq_actioncode.visible=0")
dsLoadingList.Modify("compute_sicodes.visible=0")
dsLoadingList.Modify("compute_6.visible=0")
dsLoadingList.Modify("sys_three_letter_codes_ctlc.visible=0")
dsLoadingList.Modify("cen_loadinglists_nbelly_container.visible=0")
dsLoadingList.Modify("cen_loadinglist_index_cloadinglist.visible=0")
dsLoadingList.Modify("compute_classname.visible=0")
dsLoadingList.Modify("cen_loadinglists_cadd_on_text.visible=0")
dsLoadingList.Modify("cen_loadinglists_cmeal_control_code.visible=0")
dsLoadingList.Modify("cen_stowage_nweight.visible=0")
dsLoadingList.Modify("cen_packinglists_dvalid_from.visible=0")
dsLoadingList.Modify("cen_packinglists_dvalid_to.visible=0")
dsLoadingList.Modify("cen_loadinglists_cfrequency.visible=0")
dsLoadingList.Modify("cen_loadinglists_ctime_from.visible=0")
dsLoadingList.Modify("cen_loadinglists_ctime_to.visible=0")
dsLoadingList.Modify("cen_stowage_npage.visible=0")
dsLoadingList.Modify("cen_stowage_nxpos.visible=0")
dsLoadingList.Modify("cen_stowage_nypos.visible=0")
dsLoadingList.Modify("cen_object_equipment_nequipment_height.visible=0")
dsLoadingList.Modify("cen_object_equipment_nequipment_width.visible=0")
dsLoadingList.Modify("cen_loadinglists_nquantity.visible=0")
dsLoadingList.Modify("cen_loadinglists_nlabel_quantity.visible=0")
dsLoadingList.Modify("cen_packinglists_nlabel_type_key.visible=0")
dsLoadingList.Modify("cen_object_schema_cfontname.visible=0")
dsLoadingList.Modify("cen_object_schema_nfontbold.visible=0")
dsLoadingList.Modify("cen_object_schema_nfontitalic.visible=0")
dsLoadingList.Modify("cen_object_schema_nfontcolor.visible=0")
dsLoadingList.Modify("cen_object_schema_nobjectcolor.visible=0")
dsLoadingList.Modify("cen_object_schema_nobjectbackgroundcolor.visible=0")
dsLoadingList.Modify("cen_object_schema_nfontsize.visible=0")
dsLoadingList.Modify("cen_object_equipment_nequipment_resize.visible=0")
dsLoadingList.Modify("compute_handling_key.visible=0")
dsLoadingList.Modify("compute_calcweight.visible=0")
dsLoadingList.Modify("compute_rowprinted.visible=0")
dsLoadingList.Modify("cen_loadinglists_dtimestamp_modification.visible=0")
dsLoadingList.Modify("stationinstruction.visible=0")
dsLoadingList.Modify("nworkstationkey.visible=0")
dsLoadingList.Modify("nareakey.visible=0")
dsLoadingList.Modify("npltype.visible=0")
dsLoadingList.Modify("pldetail_label_counter.visible=0")
dsLoadingList.Modify("cen_object_schema_nobjectborder.visible=0")
dsLoadingList.Modify("compute_usefontsize.visible=0")
dsLoadingList.Modify("cen_object_schema_nobjectlinewidth.visible=0")
dsLoadingList.Modify("compute_zustautext.visible=0")
dsLoadingList.Modify("carea_code.visible=0")
dsLoadingList.Modify("nlabel_type.visible=0")
dsLoadingList.Modify("nprint.visible=0")
dsLoadingList.Modify("compute_labelprinting.visible=0")
dsLoadingList.Modify("cen_loadinglists_dtimestamp_modification.visible=0")
dsLoadingList.Modify("cen_packinglists_npackinglist_detail_key.visible=0")
dsLoadingList.Modify("nworkstationkey.visible=0")
dsLoadingList.Modify("cworkstation.visible=0")
dsLoadingList.Modify("nareakey.visible=0")
dsLoadingList.Modify("carea.visible=0")
dsLoadingList.Modify("npltype.visible=0")
dsLoadingList.Modify("compute_for_to.visible=0")
dsLoadingList.Modify("pldetail_text.visible=0")
dsLoadingList.Modify("pldetail_label_counter.visible=0")
dsLoadingList.Modify("cen_packinglists_ctext_short.visible=0")

return 0
end function

public function integer of_distribution_errorlist ();// ---------------------------------------------------
// 
// Reste verteilen
// 
// Thilos Regel sagt:
// Reste werden in die Beh$$HEX1$$e400$$ENDHEX$$lter mit der gr$$HEX1$$f600$$ENDHEX$$ssten
// Restkapazit$$HEX1$$e400$$ENDHEX$$t gepackt. Verteilparameter finden
// keine Ber$$HEX1$$fc00$$ENDHEX$$cksichtigung
// ---------------------------------------------------
Long 								lRow
Long								lPlType
Long								lClass
Long								lFound
Long								a, I, J
Long								lGroup
Long								lParameters
Long 								lSort
String							sMealControlCode
String							sClass
String							sFilter
String							sGalleyFilter
String							sPlType
String 						sPL
Boolean							bFound
Boolean							bLast
Long 								lRankings[]
String							sTemp
Long								lSPML
Long								lInsert
Long 								lRows

uo_distribution_container	uoTemp[]
uo_distribution_container	uoRanking[]
uo_distribution_container	uoEmpty[]
uo_distribution_container	uoAbsolute[]

datastore						dsContents
datastore						dsSorter

dsSorter							= create datastore
dsSorter.dataobject 			= "dw_uo_rest"

s_distribution_parameters 	strParams

// -----------------------------------
// erstmal wieder au$$HEX1$$df00$$ENDHEX$$er Betrieb
// genommen !!!!!
// -----------------------------------
// return 0

this.dsControl.Reset()

// -------------------------------------------------------------------------
// Alle rausfilter, f$$HEX1$$fc00$$ENDHEX$$r die H$$HEX1$$f600$$ENDHEX$$hen und Tiefen gefunden wurden und dann einem
// Tempor$$HEX1$$e400$$ENDHEX$$ren Datastore $$HEX1$$fc00$$ENDHEX$$bergeben, damit ds_loading_list_result unver$$HEX1$$e400$$ENDHEX$$ndert
// bleibt
// -------------------------------------------------------------------------
this.dsLoadingList.SetFilter("ndistribution_detail_key > 0")
this.dsLoadingList.Filter()
this.dsDistribution = this.dsLoadingList

//dsContents = this.dsDistributionErrors
dsContents 					= create datastore
dsContents.dataobject 	= "dw_uo_cen_out_meals"

// f_print_datastore(this.dsDistributionErrors)


// -------------------------------------------------------------------------
// 12.11.2015, KF
// Die XXML's aus der Errorlist l$$HEX1$$f600$$ENDHEX$$schen, da die eigentlichen
// St$$HEX1$$fc00$$ENDHEX$$cklisten zus$$HEX1$$e400$$ENDHEX$$tzlich gelistet sind
// -------------------------------------------------------------------------
for lRows = this.dsDistributionErrors.RowCount() to 1 Step -1
	// ----------------------------------------------------
	// SPML Dummies l$$HEX1$$f600$$ENDHEX$$schen
	// ----------------------------------------------------
	sPl = this.dsDistributionErrors.GetItemString(lRows, "cpackinglist")
	
	if mid(sPL, 1, 6) = "XXXXXX" then 
		this.dsDistributionErrors.DeleteRow(lRows)
       	this.of_log("of_distribution_errorlist(), XXML deleted")
	end if
next


if this.dsDistributionErrors.RowsMove(1, this.dsDistributionErrors.RowCount(), Primary!,  dsContents, 1, Primary!) <> 1 then
	this.of_log("Error Rowscopy, can't copy errorlist to temporarely datastore!")
	this.of_log("Lost " + string(this.dsDistributionErrors.RowCount()) + " rows")
end if

// ---------------------------------------------------
// Erstmal eine Eindeutigkeit herstellen
// Kombinationen aus :	Klasse
//								St$$HEX1$$fc00$$ENDHEX$$cklistentype
//								Verteilerschl$$HEX1$$fc00$$ENDHEX$$ssel
//								KomponentenGruppe
// ---------------------------------------------------
For lRow = 1 to dsContents.RowCount()
	
	sTemp 				= dsContents.GetItemString(lRow, "cproduction_text") 
	sTemp					= "* " + sTemp
	dsContents.SetItem(lRow, "cproduction_text", sTemp)
		
	lPlType				= dsContents.GetItemNumber(lRow, "npltype_key")
	sPlType				= dsContents.GetItemString(lRow, "sys_packinglist_types_ctext")
	lClass				= dsContents.GetItemNumber(lRow, "nclass_number")
	lGroup				= dsContents.GetItemNumber(lRow, "ncomponent_group")
	sMealControlCode	= dsContents.GetItemString(lRow, "cmeal_control_code")
	sClass				= dsContents.GetItemString(lRow, "cclass")
	
	lFound = this.dsControl.Find("npltype_key=" + string(lPlType) + " and nclass_number=" + string(lClass) + " and cmeal_control_code='" + sMealcontrolCode + "'", 1, this.dsControl.RowCount())			

	if lFound = 0 then
		a = this.dsControl.InsertRow(0)
		this.dsControl.SetItem(a, "npltype_key", lPlType)
		this.dsControl.SetItem(a, "cpl_type", sPlType)
		this.dsControl.SetItem(a, "nclass_number", lClass)
		this.dsControl.SetItem(a, "cmeal_control_code", sMealControlCode)
		this.dsControl.SetItem(a, "cclass", sClass)
		this.dsControl.SetItem(a, "ncomponent_group", lGroup)
	end if
	
Next

this.dsControl.SetFilter("")
this.dsControl.Filter()
this.dsControl.Sort()

//f_print_datastore(dsControl)

// ---------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r jede Kombinationen aus	Klasse, St$$HEX1$$fc00$$ENDHEX$$cklistentyp
//	und Verteilerschl$$HEX1$$fc00$$ENDHEX$$ssel nun das richtige T$$HEX1$$f600$$ENDHEX$$pfchen
// suchen
// ---------------------------------------------------
For lRow = 1 to this.dsControl.RowCount()

	lPlType				= this.dsControl.GetItemNumber(lRow, "npltype_key")
	sPlType				= this.dsControl.GetItemString(lRow, "cpl_type")
	lClass				= this.dsControl.GetItemNumber(lRow, "nclass_number")
	lGroup				= this.dsControl.GetItemNumber(lRow, "ncomponent_group")
	sMealControlCode	= this.dsControl.GetItemString(lRow, "cmeal_control_code")
	sClass				= this.dsControl.GetItemString(lRow, "cclass")

	sFilter = "npltype_key=" + string(lPlType) + " and nclass_number=" + string(lClass) + " and cmeal_control_code='" + sMealcontrolCode + "'"
	dsContents.SetFilter(sFilter)
	dsContents.Filter()
	
	if dsContents.RowCount() = 0 then
		// Um$$HEX1$$f600$$ENDHEX$$glich
		this.of_log("NO RECORDS for [of_distribution_errorlist]: " + sFilter) 
		continue
	end if
	
	// ------------------------------------------------
	// Die Stauorte raussuchen, die verwendet werden
	// d$$HEX1$$fc00$$ENDHEX$$rfen
	// ------------------------------------------------
	uoTemp = uoEmpty
	sGalleyFilter = ""
	For a = 1 to UpperBound(uoStowages)
		if uoStowages[a].of_utilise(sClass, lPlType, sMealControlCode, "*", lSPML) then
			uoTemp[UpperBound(uoTemp) + 1] = uoStowages[a]
			// -------------------------------------------
			// wir basteln uns gleich noch den Filter
			// mit zusammen
			// -------------------------------------------
			sGalleyFilter += "ndistribution_detail_key=" + string(uoTemp[UpperBound(uoTemp)].lLoadRow) + " or "
		end if
	Next
	
	if upperbound(uoTemp) = 0 then 
		this.of_log("NO STOWAGES for [of_distribution_errorlist]: " + sFilter) 
		continue
	end if
	
	// ---------------------------------------------------------------------
	// Alle Stauorte aus dsLoadinglist, in die verteilt werden soll
	// Die Anzahl der Datens$$HEX1$$e400$$ENDHEX$$tze im Datastore muss nun der Anzahl der 
	// Eintr$$HEX1$$e400$$ENDHEX$$ge im Array entsprechen
	// ---------------------------------------------------------------------
	sGalleyFilter = Mid(sGalleyFilter, 1, len(sGalleyFilter) - 4)
	dsDistribution.SetFilter(sGalleyFilter)
	dsDistribution.Filter()
	
	this.dsDistribution.Sort()
	//f_print_datastore(this.dsDistribution)
	
	for lSort = 1 to Upperbound(uoTemp)
		lInsert = dsSorter.InsertRow(0)
		dsSorter.SetItem(lInsert, "lstowagekey", uoTemp[lSort].lStowageKey)
		dsSorter.SetItem(lInsert, "lrest", uoTemp[lSort].of_availability(1, dsContents))
	next
	
	dsSorter.Sort()
	//f_print_datastore(dsSorter)
	
	for lSort = 1 to dsSorter.Rowcount()
		for a = 1 to UpperBound(uoTemp)
			if  dsSorter.GetItemNumber(lSort, "lstowagekey") = uoTemp[a].lStowageKey then
				this.of_stuffed(uoTemp, dsContents, lSPML, False)
				continue
			end if
		next
	next
	
next

// ---------------------------------------------------------
// Alles was nicht verteilt werden konnte in die Errorliste 
// kopieren
// ---------------------------------------------------------
dsContents.SetFilter("")
dsContents.Filter()

//f_print_datastore(dsContents)


for lRows = dsContents.RowCount() to 1 Step -1
	
	
	// ----------------------------------------------------
	// SPML Dummies ignorieren
	// ----------------------------------------------------
	sPl = dsContents.GetItemString(lRows, "cpackinglist")
	
	if mid(sPL, 1, 7) = "XXXXXXX" then 
		continue
	end if
	
	
	if dsContents.GetItemNumber(lRows, "nquantity") > 0 then
		// Messagebox("", "Rest: " + string(dsContents.GetItemNumber(lRows, "nquantity")))
		if dsContents.RowsMove(lRows, lRows, Primary!,  this.dsDistributionErrors, this.dsDistributionErrors.RowCount() + 1, Primary!) <> 1 then
			this.of_log("of_distribution_errorlist ERROR Rowscopy to ErrorList failed!")
		end if
	end if
next


return 0


end function

public function s_distribution_parameters of_get_distribution_parameters_detail (long lkey, string sclass, long lpltype, string smealcontrolcode, integer ispml);// --------------------------------------------------------------
//
// Die Verteilungsparameter ermitteln
//
// --------------------------------------------------------------
s_distribution_parameters 	strReturn
Long 								lFound, I
Integer							iTypes[]
String							sFind


// --------------------------------------------------------------
// Beim Type Default explizit suchen, bei SPML's muss gem. 
// Vorgabe keine Definition vorhanden sein, es soll dann die
// des Default Types genommen werden
// --------------------------------------------------------------
if iSPML = 0 then
	iTypes[1] = 0
else
	iTypes[1] = 1
	iTypes[2] = 0
end if

this.dsDistributionParameter.Retrieve(lKey)

if this.dsDistributionParameter.RowCount() = 0 then
	strReturn.iStatus = -1
	this.of_log("No distribution parameters for Key: " + string(lKey) + "  found!")
	return strReturn
else
	strReturn.iStatus = 0
end if

for i = 1 to UpperBound(iTypes)

	// ----------------------------------------------------
	// Mit dem 3 stelligen MealccontrolCode suchen
	// wird nix gefunden, dann die Suche mit *
	// wiederholen
	// ----------------------------------------------------
	sFind = Mid(sMealControlcode, 2)
	//sFind = Mid(sMealControlcode, 1)
	
	lFound = this.dsDistributionParameter.Find("cmeal_control_code ='" + sFind + "' and npackinglist_key=" + string(lPlType) + " and cclass ='" + sClass + "' and ndistribution_type = " + String(iTypes[i]), 1, this.dsDistributionParameter.RowCount())
	
	if lFound = 0 then
		sFind = "*"
		lFound = this.dsDistributionParameter.Find("cmeal_control_code ='" + sFind + "' and npackinglist_key=" + string(lPlType) + " and cclass ='" + sClass + "' and ndistribution_type = " + String(iTypes[i]) , 1, this.dsDistributionParameter.RowCount())

		if lFound > 0 then
			strReturn.lDistributionType			= this.dsDistributionParameter.GetItemNumber(lFound, "ndistribution_type")
			strReturn.lDistributionDetailKey		= this.dsDistributionParameter.GetItemNumber(lFound, "ndistribution_detail_key")
			strReturn.sClass							= this.dsDistributionParameter.GetItemString(lFound, "cclass")
			strReturn.lPlType							= this.dsDistributionParameter.GetItemNumber(lFound, "npackinglist_key")
			strReturn.sMealControlCode				= this.dsDistributionParameter.GetItemString(lFound, "cmeal_control_code")
			strReturn.lDirection						= this.dsDistributionParameter.GetItemNumber(lFound, "ndirection")
			strReturn.lAbsolute						= this.dsDistributionParameter.GetItemNumber(lFound, "nabsolute")
			strReturn.lSplitting						= this.dsDistributionParameter.GetItemNumber(lFound, "nsplit")
			strReturn.lAlternate						= this.dsDistributionParameter.GetItemNumber(lFound, "nalternate")
			strReturn.sName							= this.dsDistributionParameter.GetItemString(lFound, "cen_distribution_ctext")
			//Messagebox("", "Klasse: " + sClass + "~rlPlType: " + string(lPlType) + "~rCode: " + sMealControlCode + "~rRichtung: " + string(strReturn.lDirection))
			return strReturn
			
		end if
		
	else
		
		strReturn.lDistributionType			= this.dsDistributionParameter.GetItemNumber(lFound, "ndistribution_type")
		strReturn.lDistributionDetailKey		= this.dsDistributionParameter.GetItemNumber(lFound, "ndistribution_detail_key")
		strReturn.sClass							= this.dsDistributionParameter.GetItemString(lFound, "cclass")
		strReturn.lPlType							= this.dsDistributionParameter.GetItemNumber(lFound, "npackinglist_key")
		strReturn.sMealControlCode				= this.dsDistributionParameter.GetItemString(lFound, "cmeal_control_code")
		strReturn.lDirection						= this.dsDistributionParameter.GetItemNumber(lFound, "ndirection")
		strReturn.lAbsolute						= this.dsDistributionParameter.GetItemNumber(lFound, "nabsolute")
		strReturn.lSplitting						= this.dsDistributionParameter.GetItemNumber(lFound, "nsplit")
		strReturn.lAlternate						= this.dsDistributionParameter.GetItemNumber(lFound, "nalternate")
		return strReturn
	end if

next

strReturn.iStatus = -1
this.of_log("No distribution parameters for Type: Class=" + sClass + " and MealControlCode: " + sMealControlcode + " and PlType = " + string(lPlType) + " SPML = " + string(iSPML))

return strReturn
end function

public function integer of_alternate (ref uo_distribution_container uotemp[], datastore dscontents, long lspml, boolean blast);// ---------------------------------------------------------
//
// Die alternierende (abwechselnde) Sortenreine Verteilung
//
// ---------------------------------------------------------
Long 		lStowages, &
			lCount, &
			lQuantity, &
			lLastQuantity, &
			lLoop, &
			i
			
Long 		lRow

String	sStowages, &
			sOut


// --------------------------------------------------------------------------------------------------------------------
// 11.01.2010 HR: Pr$$HEX1$$fc00$$ENDHEX$$fen, ob $$HEX1$$fc00$$ENDHEX$$berhaupt Container im Array sind, wenn nicht zur$$HEX1$$fc00$$ENDHEX$$ck
//CBASE-DE-EM-2093
// --------------------------------------------------------------------------------------------------------------------
 if UpperBound(uoTemp) <= 0 then 
	this.of_log("------------------------------------------------------------")
	this.of_log(" A L T E R N A T I N G: No Containers in uotemp ")
	this.of_log("------------------------------------------------------------")
	return 0	
end if


sStowages = ""
For lRow =  1 to UpperBound(uoTemp)
	sStowages += uoTemp[lRow].sStowage + "/"
Next

this.of_log("------------------------------------------------------------")
this.of_log(" A L T E R N A T I N G ")
this.of_log("------------------------------------------------------------")
this.of_log("Stowage sort: " + sStowages )
this.of_log("alternating " + string(dsContents.RowCount()) + " items" )

lStowages 		= UpperBound(uoTemp)
lCount			= 0
lQuantity		= 1
lLastQuantity 	= 0


// ----------------------------------------------------------
// Den ersten freien Stauort rausfinden
// ----------------------------------------------------------
For lRow = 1 to UpperBound(uoTemp)
	if uoTemp[lRow].of_is_empty() then
		
		if uoTemp[lRow].of_availability(1, dsContents) > 0 then
			lCount = lRow
			this.of_log("------------------------------------------------------------")
			this.of_log("Starting in Stowage: " + uoTemp[lRow].sStowage)
			this.of_log("------------------------------------------------------------")
			exit
		end if
		
	end if
Next
 
 // --------------------------------------------------------------------------------------------------------------------
 // 19.05.2010 HR: Wenn keine Stauort gefunden wurde, dann raus hier
 // Fehler trat in DA bei JTG auf
 // --------------------------------------------------------------------------------------------------------------------
 if lCount =  0 then 
	this.of_log("------------------------------------------------------------")
	this.of_log(" A L T E R N A T I N G: No Container availabile ")
	this.of_log("------------------------------------------------------------")
	return 0	
end if

Integer iFirstEntry

do while lQuantity > 0 

	for lRow = 1 to dsContents.RowCount()
		
		if dsContents.GetItemNumber(lRow, "nquantity") = 0 then continue
		
		if iFirstEntry = 1 then
			lCount ++
		else
			iFirstEntry = 1
		end if
		
		if lCount > lStowages then
			lCount = 1
		end if
		
		sOut = ""
		sOut += "Trying stowage "  + uoTemp[lCount].sStowage + " with "
		sOut += of_checknull(String(dsContents.GetItemNumber(lRow, "nquantity"))) + " x " + this.of_checknull(dsContents.GetItemString(lRow, "cpackinglist")) + " h: " + String(dsContents.GetItemNumber(lRow, "nheight")) + " w: " + String(dsContents.GetItemNumber(lRow, "nwidth"))
		this.of_log(sOut)
	
		if uoTemp[lCount].of_fill_absolute(lRow, dsContents, lSPML)	<> 0 then
			
			this.of_log("ERROR Alternating: " + this.of_checknull(uoTemp[lCount].sError))
			this.of_dump(lRow, dsContents, True)
//			lCount --
			
		end if
		
	next
	
	// ---------------------------------------------------------
	// Nachdem alle Mahlzeiten sortenrein verteilt wurden 
	// pr$$HEX1$$fc00$$ENDHEX$$fen, ob es noch einen Rest gibt
	// ---------------------------------------------------------
	lQuantity = 0
	
	for i = 1 to dsContents.RowCount()
		lQuantity += dsContents.GetItemNumber(i, "nquantity")
	next
	
	// ----------------------------------------------------------
	// Die Menge hat sich zum letzten Loop nicht ver$$HEX1$$e400$$ENDHEX$$ndert, d.h.
	// es wurde kein freier Stauort mehr gefunden.
	// Den Loop verlassen ..........
	// ----------------------------------------------------------
	//	if lLastQuantity = lQuantity then
	//		exit
	//	else
	//		lLastQuantity = lQuantity
	//	end if
	
	// ----------------------------------------------------------
	// Sicher ist sicher =;-))
	// ----------------------------------------------------------
	lLoop ++
	if lLoop = 100 then
		this.of_log("of_alternate Loop at 100")
		exit
	end if 
	
loop

// ---------------------------------------------------------
// Alles was nicht verteilt werden konnte in die Errorliste 
// kopieren
// ---------------------------------------------------------
for lRow = dsContents.RowCount() to 1 Step -1
	if dsContents.GetItemNumber(lRow, "nquantity") > 0 and bLast then
		if dsContents.RowsMove(lRow, lRow, Primary!,  this.dsDistributionErrors, this.dsDistributionErrors.RowCount() + 1, Primary!) <> 1 then
			this.of_log("ERROR Rowscopy to ErrorList failed!")
		end if
	end if
next

return 0
end function

public function integer of_distribution (integer itype);// ---------------------------------------------------
// 
// Die eigentliche Verteilung
// 
// ---------------------------------------------------
Long 								lRow
Long								lPlType 
Long								lClass
Long								lFound
Long								lContentRows
Long								a, I, J, K
Long								lGroup
Long								lParameters
Long 								lSort
Long								lLog
Long								lDistributionRoutines[]
Long								lDistributionRoutine
String							sMealControlCode
String							sClass
String							sFilter
String							sGalleyFilter
String							sPlType
Boolean							bFound
Boolean							bLast
Boolean							bFinalLoop
Long 								lRankings[]
Long 								lEmpty[]
String							sSorter
String 							sCurrentGroup
Long								lSPML
Integer							iTypes[]
Long								lQuantity
Long								lLastComponent

uo_distribution_container	uoTemp[]
uo_distribution_container	uoDistribute[]
uo_distribution_container	uoRanking[]
uo_distribution_container	uoSplit[]
uo_distribution_container	uoEmpty[]
uo_distribution_container	uoAbsolute[]
uo_distribution_container	uoFinal[]

datastore						dsContents
datastore						dsAbsoluteSplitting

s_distribution_parameters 	strParams

this.dsControl.Reset()

// -------------------------------------------------------------------------
// Alle rausfilter, f$$HEX1$$fc00$$ENDHEX$$r die H$$HEX1$$f600$$ENDHEX$$hen und Tiefen gefunden wurden und dann einem
// Tempor$$HEX1$$e400$$ENDHEX$$ren Datastore $$HEX1$$fc00$$ENDHEX$$bergeben, damit ds_loading_list_result unver$$HEX1$$e400$$ENDHEX$$ndert
// bleibt
// -------------------------------------------------------------------------
this.dsLoadingList.SetFilter("ndistribution_detail_key > 0")
this.dsLoadingList.Filter()
this.dsDistribution = this.dsLoadingList

// -------------------------------------------------------------------------
// iType = 3 bedeutet es sollen SPML's verteilt werden. Es muss nach dem
// SPML-Rang (nranking_spml) sortiert werden
// -------------------------------------------------------------------------
if iType = 3 then
	lSPML = 1
	//sSorter = "nclass_number, nranking_spml, nunit_priority, cen_stowage_nsort"
	sSorter = "nranking_spml, nunit_priority, cen_stowage_nsort"
else
	lSPML = 0
	//sSorter = "nclass_number, nranking, nunit_priority, cen_stowage_nsort"
	sSorter = "nranking, nunit_priority, cen_stowage_nsort"
end if 
	
dsDistribution.SetSort(sSorter)
dsDistribution.Sort()

// -----------------------------------------------------------------
// iTypes[1] = 3
// iTypes[2] = 1
// iTypes[3] = 2
// For lClasses = 1 to this.dsClasses.RowCount()
//
//		sCurrentClass = this.dsClasses.GetItemString(lClasses, "cclass")
//
// 	For lTypes = 1 to UpperBound(iTypes)
//
//			iType = iTypes[lTypes]
//

// ----------------------------------------------
// Ggf. die SPML's noch kummulieren // 24.04.2013 HR: auch bei iAccumulateSPMLType
// ----------------------------------------------
if (this.iAccumulateSPML = 1 or this.iAccumulateSPMLType = 1) and iType = 3 then
	// Messagebox("","SPML accumulation is activated!!!!" )
	this.of_log("SPML accumulation is activated!!!!")
	this.of_accumulate_spmls()
end if

// ---------------------------------------------------
// Parameter iType
// 1 = Mahlzeiten
// 2 = Extrabeladung
// 3 = SPML
// ---------------------------------------------------
if iType = 1 then
	dsContents = this.dsMeals
elseif iType = 2 then
	dsContents = this.dsAdditional
elseif iType = 3 then
	dsContents = this.dsSPMLDistribution
else
	return -1
end if 

//Messagebox("iType", iType)
//if iType = 3 then f_print_datastore(dsContents)

// --------------------------------------------------------------------------------------
// 26.05.2006
// Herausfinden, ob eine Gruppenzuordnung existiert, wenn ja die Werte gem. Stammdaten
// aufsplitten
// --------------------------------------------------------------------------------------

//if dsContents.RowCount() > 0 then 
//	dsContents.Modify("t_2.text='Before'")
//	f_print_datastore(dsContents)
//end if

this.of_distribution_joblist(dsContents, iType)		



// --------------------------------------------------------------------------------------
// 05.07.06
// Prozente wurden bisher in of_load_components aus 0 gesetzt, die Prozente werden
// allerdings f$$HEX1$$fc00$$ENDHEX$$r of_divide_manually ben$$HEX1$$f600$$ENDHEX$$tigt, deshalb erst danach auf 0 setzten
// --------------------------------------------------------------------------------------
this.of_reset_percentage(iType)

//if dsContents.RowCount() > 0 then 
//	dsContents.Modify("t_2.text='After'")
//	f_print_datastore(dsContents)
//end if

//if iType = 1 then
//	f_print_datastore(dsContents)
//	f_print_datastore(dsControl)
//end if	

// ---------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r jede Kombinationen aus	Klasse, St$$HEX1$$fc00$$ENDHEX$$cklistentyp
//	und Verteilerschl$$HEX1$$fc00$$ENDHEX$$ssel nun das richtige T$$HEX1$$f600$$ENDHEX$$pfchen
// suchen
// ---------------------------------------------------
For lRow = 1 to this.dsControl.RowCount()
	
	lPlType				= this.dsControl.GetItemNumber(lRow, "npltype_key")
	sPlType				= this.dsControl.GetItemString(lRow, "cpl_type")
	lClass				= this.dsControl.GetItemNumber(lRow, "nclass_number")
	lGroup				= this.dsControl.GetItemNumber(lRow, "ncomponent_group")
	sMealControlCode	= this.dsControl.GetItemString(lRow, "cmeal_control_code")
	sClass				= this.dsControl.GetItemString(lRow, "cclass")
	sCurrentGroup		= this.dsControl.GetItemString(lRow, "cstowagegroup")
	
	//sFilter = "npltype_key=" + string(lPlType) + " and nclass_number=" + string(lClass) + " and cmeal_control_code='" + sMealcontrolCode + "' and ncomponent_group = " + string(lGroup)
	sFilter 	= "npltype_key=" + string(lPlType) + &
			" and nclass_number=" + string(lClass) + &
			" and cmeal_control_code='" + sMealcontrolCode + "'" + &
			" and cstowagegroup='" + sCurrentGroup + "'"
			
	dsContents.SetFilter(sFilter)
	dsContents.Filter()
	
	//of_add_classnumbers(4)
	
	if dsContents.RowCount() = 0 then
		// Um$$HEX1$$f600$$ENDHEX$$glich
		this.of_log("NO RECORDS for[" + string(iType) + "]: " + sFilter) 
		continue
	end if

	// ------------------------------------------------
	// Die Stauorte raussuchen, die verwendet werden
	// d$$HEX1$$fc00$$ENDHEX$$rfen
	// ------------------------------------------------
	uoTemp = uoEmpty
	sGalleyFilter = ""
	For a = 1 to UpperBound(uoStowages)
		if uoStowages[a].of_utilise(sClass, lPlType, sMealControlCode, sCurrentGroup, lSPML) then
			uoTemp[UpperBound(uoTemp) + 1] = uoStowages[a]
			// -------------------------------------------
			// wir basteln uns gleich noch den Filter
			// mit zusammen
			// -------------------------------------------
			sGalleyFilter += "ndistribution_detail_key=" + string(uoTemp[UpperBound(uoTemp)].lLoadRow) + " or "
		else
			
			//this.of_log(uoStowages[a].sStowage + " is not good for Class: " + sClass + " / " + string(lPlType) + " Code: " + sMealControlCode)
			
		end if
	Next
	
	// ---------------------------------------------
	// Alle Komponenten, f$$HEX1$$fc00$$ENDHEX$$r die kein Stauort
	// definiert ist in die Error - Liste
	// aufnehmen
	// ---------------------------------------------
	if UpperBound(uoTemp) = 0 then
		of_log("PRESELECT -> NO STOWAGES with the proper parameters found: Class = " + sClass + " PL-Type: " + sPlType + "/" + string(lPLType) + " MealControlCode: " + sMealControlCode )
		if dsContents.RowsMove(1, dsContents.RowCount(), Primary!,  this.dsDistributionErrors, this.dsDistributionErrors.RowCount() + 1, Primary!) <> 1 then
			this.of_log("ERROR Rowscopy to ErrorList failed!")
		end if
		continue
	end if

	// ---------------------------------------------------------------------
	// Alle Stauorte aus dsLoadinglist, in die verteilt werden soll
	// Die Anzahl der Datens$$HEX1$$e400$$ENDHEX$$tze im Datastore muss nun der Anzahl der 
	// Eintr$$HEX1$$e400$$ENDHEX$$ge im Array entsprechen
	// ---------------------------------------------------------------------
	sGalleyFilter = Mid(sGalleyFilter, 1, len(sGalleyFilter) - 4)
	dsDistribution.SetFilter(sGalleyFilter)
	dsDistribution.Filter()

	if dsDistribution.RowCount() <> Upperbound(uoTemp) then
		this.of_log("ERROR unequal number of rows: dsDistribution = " + string(dsDistribution.RowCount()) + " Array = " + String(UpperBound(uoTemp)))
	end if
		
	if iType = 3 then
		//sSorter = "nclass_number, nranking_spml A, nunit_priority, cen_stowage_nsort"
		sSorter = "nranking_spml A, nunit_priority, cen_stowage_nsort"
	else
		//sSorter = "nclass_number, nranking A, nunit_priority , cen_stowage_nsort"
		sSorter = "nranking A, nunit_priority , cen_stowage_nsort"
	end if 
	
	dsDistribution.SetSort(sSorter)
	this.of_set_priority_maximun(-1000, lSPML, dsDistribution)
	this.dsDistribution.Sort()	
	
	// -------------------------------------------------
	// Stauort Array nochmal neu erstellen
	// -------------------------------------------------
	uoTemp = uoEmpty
	for lSort = 1 to this.dsDistribution.Rowcount()
		for a = 1 to UpperBound(uoStowages)
			if this.dsDistribution.GetItemNumber(lSort, "ndistribution_detail_key") = uoStowages[a].lLoadRow then
				if uoStowages[a].of_utilise(sClass, lPlType, sMealControlCode, sCurrentGroup, lSPML) then
					uoTemp[UpperBound(uoTemp) + 1] = uoStowages[a]
				end if
			end if
		next
	next
	
	// -------------------------------------------------
	// Eindeutigkeit der Verteilerroutinen ermitteln
	// -------------------------------------------------
	Long 		b
	Boolean 	bFoundRoutine
	String  	sOut
	
	For a = 1 to UpperBound(uoTemp)
		
		bFoundRoutine = false
		
		if iType = 1 then
			lParameters = uoTemp[a].lDistributionMealKey	
		elseif iType = 2 then
			lParameters = uoTemp[a].lDistributionAddKey	
		elseif iType = 3 then
			lParameters = uoTemp[a].lDistributionMealKey	
		end if 
		
		lParameters = f_get_valid_distribution_key(lParameters,  date(dtDeparture) )
		
		for b = 1 to UpperBound(lDistributionRoutines)	
			if lParameters = lDistributionRoutines[b] then
				bFoundRoutine = true
				exit
			end if
		next
		
		if not bFoundRoutine then
			lDistributionRoutines[UpperBound(lDistributionRoutines) + 1] = lParameters
			of_log("Found Routine: " + String(lParameters) )
		end if
				
	Next
	
	of_log("Routine(s) found: "  + String(UpperBound(lDistributionRoutines)))
	
	// -----------------------------------------------------------------------------------------
	//
	//
	// Ab hier wird verteilt
	//
	//
	// -----------------------------------------------------------------------------------------
	bFinalLoop = false		
	For lDistributionRoutine = 1 to UpperBound(lDistributionRoutines)
		
		if lDistributionRoutine = UpperBound(lDistributionRoutines) then bFinalLoop = true
	
		// --------------------------------------------------------------------------------------
		// Erstmal die Stauorte raussuchen, die die entsprechende Verteilerroutine haben
		// --------------------------------------------------------------------------------------
		uoDistribute = uoEmpty
		
		for a = 1 to UpperBound(uoTemp)
	
			if iType = 1 then
				lParameters = uoTemp[a].lDistributionMealKey	
			elseif iType = 2 then
				lParameters = uoTemp[a].lDistributionAddKey	
			elseif iType = 3 then
				lParameters = uoTemp[a].lDistributionMealKey	
			end if 
			
			lParameters = f_get_valid_distribution_key(lParameters,  date(dtDeparture) )
			
			if lDistributionRoutines[lDistributionRoutine] = lParameters then
				uoDistribute[UpperBound(uoDistribute) + 1] = uoTemp[a]
			end if
			
		next
		
		if iType = 3 then
			//sSorter = "nclass_number, nranking_spml A, nunit_priority, cen_stowage_nsort"
			sSorter = "nranking_spml A, nunit_priority, cen_stowage_nsort"
		else
			//sSorter = "nclass_number, nranking A, nunit_priority , cen_stowage_nsort"
			sSorter = "nranking A, nunit_priority , cen_stowage_nsort"
		end if 
		
		// --------------------------------------------------------------------------------------
		// Struktur mit Verteilungsparametern f$$HEX1$$fc00$$ENDHEX$$llen
		// --------------------------------------------------------------------------------------
		strParams = this.of_get_distribution_parameters_detail(lDistributionRoutines[lDistributionRoutine] , sClass, lPlType, sMealControlCode, lSPML)
		if strParams.iStatus = -1 then 
			this.of_log("ERROR no Distribution Parameters for Routine: " + string(lDistributionRoutines[lDistributionRoutine]) + " -  Class: " +  sClass + " PlType: " + sPlType + " DistributionCode: " + sMealControlCode + " SPML: " + String(lSPML))
									
			if dsContents.RowsMove(1, dsContents.RowCount(), Primary!,  this.dsDistributionErrors, this.dsDistributionErrors.RowCount() + 1, Primary!) <> 1 then
				this.of_log("ERROR Rowscopy (Distribution Parameters) to ErrorList failed!")
			end if

			continue			
			
		else
			this.of_log("--------------------------------------------------------------------------------------------------------------")
			this.of_log("Distribution Parameters for Class: " +  sClass + " PlType: " + sPlType + " DistributionCode: " + sMealControlCode + " SPML: " + String(lSPML))
			this.of_log("Using Parameters: " + strParams.sName)
			this.of_log("           Class: " + strParams.sClass)
			this.of_log("         PL-Type: " + String(strParams.lPlType))
			this.of_log("DistributionCode: " + sMealcontrolcode)
			this.of_log("       Direction: " + String(strParams.lDirection))
			this.of_log("        Absolute: " + String(strParams.lAbsolute))
			this.of_log("       Splitting: " + String(strParams.lSplitting))
			this.of_log("       Alternate: " + String(strParams.lAlternate))
			this.of_log("--------------------------------------------------------------------------------------------------------------")
			this.of_log("             MCD: " + String(this.iMCD))
			this.of_log("           Mixed: " + String(this.iMixed))
			this.of_log("--------------------------------------------------------------------------------------------------------------")
			this.of_log("   AccumulateSPML: " + String(this.iAccumulateSPML))
			this.of_log("   AccumulateSPMLType : " + String(this.iAccumulateSPMLType))  // 24.04.2013 HR:
			this.of_log("      ExplodeSPML: " + String(this.iExplodeSPML))
			this.of_log("--------------------------------------------------------------------------------------------------------------")
			
		end if
	
		this.of_log("--------------------------------------------------------------------------------------------------------------")
		this.of_log(" ++++ Sortierung vorher ++++ ")
		this.of_log("--------------------------------------------------------------------------------------------------------------")
		this.of_dump_stowage_sort()
		this.of_log("--------------------------------------------------------------------------------------------------------------")
	
		if iType = 3 then
			//sSorter = "nclass_number, nranking_spml A, nunit_priority, cen_stowage_nsort"
			sSorter = "nranking_spml A, nunit_priority, cen_stowage_nsort"
		else
			//sSorter = "nclass_number, nranking A, nunit_priority , cen_stowage_nsort"
			sSorter = "nranking A, nunit_priority , cen_stowage_nsort"
		end if 
		
		if strParams.lDirection	= 1 then
			
			this.of_set_priority_maximun(1000, lSPML, this.dsDistribution)
			
			if iType = 3 then
				//sSorter = "nclass_number, nranking_spml A, nunit_priority, cen_stowage_nsort A"
				sSorter = "nranking_spml A, nunit_priority, cen_stowage_nsort A"
			else
				//sSorter = "nclass_number, nranking A, nunit_priority , cen_stowage_nsort A"
				sSorter = "nranking A, nunit_priority , cen_stowage_nsort A"
			end if 
			
		else
			
			this.of_set_priority_maximun(-1000, lSPML, this.dsDistribution)
			
			if iType = 3 then
				//sSorter = "nclass_number, nranking_spml D, nunit_priority, cen_stowage_nsort D"
				sSorter = "nranking_spml D, nunit_priority, cen_stowage_nsort D"
			else
				//sSorter = "nclass_number, nranking D, nunit_priority , cen_stowage_nsort D"
				sSorter = "nranking D, nunit_priority , cen_stowage_nsort D"
			end if 
			
		end if
			
		this.dsDistribution.SetSort(sSorter)
				
		// ------------------------------------------------------------------------------------------
		// Nachschaun, ob eine zus$$HEX1$$e400$$ENDHEX$$tzliche Sortierung nach Beh$$HEX1$$e400$$ENDHEX$$ltnispriorit$$HEX1$$e400$$ENDHEX$$t erfolgen soll
		// ------------------------------------------------------------------------------------------
		this.dsDistributionPriority.Retrieve(strParams.lDistributionDetailKey)
		this.of_dump_unit_priority()
		
		// ------------------------------------------------------------------------------------------
		// Beh$$HEX1$$e400$$ENDHEX$$ltnispriorit$$HEX1$$e400$$ENDHEX$$tof_unit_priority
		// ------------------------------------------------------------------------------------------
		this.of_unit_priority(strParams.lDirection, sClass, uoTemp)
		this.dsDistribution.Sort()
		
		// ------------------------------------------------------------------------------------------
		// Stauortsortierung ins Logfile schreiben
		// ------------------------------------------------------------------------------------------
		this.of_log("--------------------------------------------------------------------------------------------------------------")
		this.of_log(" ++++ Sortierung nachher ++++ ")
		this.of_log("--------------------------------------------------------------------------------------------------------------")
		this.of_dump_stowage_sort()
		this.of_log("--------------------------------------------------------------------------------------------------------------")
		
		//f_print_datastore(this.dsDistribution)
		
		// ------------------------------------------------------------------------------------------
		// Und ein letztes Mal das StauortArray erstellen
		// ------------------------------------------------------------------------------------------
		uoFinal = uoEmpty

		for lSort = 1 to this.dsDistribution.Rowcount()
			for a = 1 to UpperBound(uoDistribute)
				if this.dsDistribution.GetItemNumber(lSort, "ndistribution_detail_key") = uoDistribute[a].lLoadRow then
					if uoDistribute[a].of_utilise(sClass, lPlType, sMealControlCode, sCurrentGroup, lSPML) then
						uoFinal[UpperBound(uoFinal) + 1] = uoDistribute[a]
					end if
				end if
			next
		next
	
		// ----------------------------------------------------------
		// Sortenreine Verteilung in die gefundenen Stauorte
		// ----------------------------------------------------------
		if strParams.lAbsolute = 1 and strParams.lSplitting = 0 then
			
			// -------------------------------------------------------
			// Nur leere Stauorte verwenden
			// -------------------------------------------------------
			uoAbsolute = uoEmpty
			for a = 1 to UpperBound(uoFinal)
				if uoFinal[a].of_is_empty() and uoFinal[a].of_multi_class() then
					uoAbsolute[UpperBound(uoAbsolute) + 1] = uoFinal[a]
				end if
			next
						
			if UpperBound(uoAbsolute) > 0 then
						
				for i = 1 to dsContents.RowCount()
					
					if I = dsContents.RowCount() and bFinalLoop then
						bLast = True
					else
						bLast = False
					end if
					
					this.of_absolute(uoAbsolute, dsContents, i, lSPML, bLast)
				
				next
				
			else
				
				of_log("FINALSELECTION ABSOLUTE -> NO STOWAGES with the proper parameters found: Class = " + sClass + " PL-Type: " + sPlType + "/" + string(lPLType) + " MealControlCode: " + sMealControlCode )
				
			end if
		// ----------------------------------------------------------
		// Sortenreine Verteilung in die gefundenen Stauorte
		// ----------------------------------------------------------
		elseif strParams.lAlternate = 1 then
			
			// -------------------------------------------------------
			// Nur leere Stauorte verwenden
			// -------------------------------------------------------
			uoAbsolute = uoEmpty
			for a = 1 to UpperBound(uoFinal)
				if uoFinal[a].of_is_empty() and uoFinal[a].of_multi_class() then
					uoAbsolute[UpperBound(uoAbsolute) + 1] = uoFinal[a]
				end if
			next
			
			if UpperBound(uoAbsolute) > 0 then
				
				if bFinalLoop then
					bLast = True
				else
					bLast = False
				end if
				
				this.of_alternate(uoAbsolute, dsContents, lSPML, bLast)
				
			else
				
				of_log("FINALSELECTION ALTERNATE -> NO STOWAGES with the proper parameters found: Class = " + sClass + " PL-Type: " + sPlType + "/" + string(lPLType) + " MealControlCode: " + sMealControlCode )
			
			end if
						
		// ----------------------------------------------------------------
		// Splitting/Parallel Verteilung in die gefundenen Stauorte
		// f$$HEX1$$fc00$$ENDHEX$$r NICHT - SPML Komponenten
		// ----------------------------------------------------------------
		elseif strParams.lSplitting = 1 and iType <> 3 then
			
			Long lCounterPos, &
			     lCounterNeg
			// -------------------------------------------------------------
			// Eindeutigkeit bei den R$$HEX1$$e400$$ENDHEX$$ngen herstellen
			// -------------------------------------------------------------
			lCounterPos = 1000
			lCounterNeg = -1000
			
			For I = 1 to UpperBound(uoFinal)
				
				if uoFinal[i].lRanking >= 1000 then 
					lCounterPos ++
					uoFinal[i].lRanking = lCounterPos
				end if
				
				if uoFinal[i].lRanking <= -1000 then 
					lCounterNeg --
					uoFinal[i].lRanking = lCounterNeg
				end if
				
			Next
						
			lRankings = lEmpty
			
			For I = 1 to UpperBound(uoFinal)
				bFound = False
				For J = 1 to UpperBound(lRankings)
					if uoFinal[I].lRanking = lRankings[J] then
						bFound = true
						exit
					end if
				Next
				if not bFound then
					lRankings[UpperBound(lRankings) + 1] = uoFinal[I].lRanking
				end if
			Next
			
			// -------------------------------------------------------------
			// Rankings nochmal sortieren 
			// -------------------------------------------------------------
			if UpperBound(lRankings) > 1 then
				this.of_sort_array(lRankings, strParams.lDirection)
			end if
						
			// -------------------------------------------------------------
			// Flag wenn 1 dann wird das Verh$$HEX1$$e400$$ENDHEX$$ltnis der
			// Komponenten zueinander neu berechnet
			// -------------------------------------------------------------
			this.iResetPercentage = 1
			
			For I = 1 to UpperBound(lRankings)
				
				uoRanking = uoEmpty
				
				For J = 1 to UpperBound(uoFinal)
					
					if uoFinal[J].lRanking = lRankings[I] and uoFinal[J].of_multi_class() then
						
						// -----------------------------------------------------
						// Bei der sortenreinen Parallelverteilung pr$$HEX1$$fc00$$ENDHEX$$fen, ob
						// der Stauort leer ist 
						// -----------------------------------------------------
						if strParams.lAbsolute = 1 then
							if uoFinal[J].of_is_empty() then
								uoRanking[UpperBound(uoRanking) + 1] = uoFinal[J]
							end if 
							
						else
							uoRanking[UpperBound(uoRanking) + 1] = uoFinal[J]
						end if
						
					end if
					
				Next
				
				// if I = UpperBound(lRankings) and bFinalLoop then
				if I = UpperBound(lRankings) and bFinalLoop then
					bLast = True
				else
					bLast = False
				end if
				
				if strParams.lAbsolute = 1 then
					// --------------------------------------------------------
					// 03.05.2006
					// Sortenreines splitten/parallel verteilen.
					// Hierzu einfach die Positionen einzeln in die Funktion 
					// geben
					// --------------------------------------------------------
					this.of_log("--------------------------------------------- ")
					this.of_log("starting splitting absolute")
					this.of_log("--------------------------------------------- ")
																		
					dsAbsoluteSplitting = create datastore
					dsAbsoluteSplitting.dataobject = dsContents.dataobject
					
					lLastComponent ++
										
					if lLastComponent > dsContents.RowCount() then
						lLastComponent = 1
					end if 
					
					//for k = lLastComponent to dsContents.RowCount()
					for k = lLastComponent to lLastComponent
						
						// Zeilenweise in einen tempor$$HEX1$$e400$$ENDHEX$$ren Datastore umf$$HEX1$$fc00$$ENDHEX$$llen
						dsAbsoluteSplitting.Reset()
						dsContents.RowsCopy(k, k, Primary!, dsAbsoluteSplitting, 1, Primary!)
																
						// this.of_split(uoRanking, dsAbsoluteSplitting, lSPML, bLast)
						this.of_split(uoRanking, dsAbsoluteSplitting, lSPML, false)
						
						if dsAbsoluteSplitting.RowCount() = 1 then
							
							lQuantity = dsAbsoluteSplitting.GetItemNumber(1, "nquantity")
							
							this.of_log("Remaining quantity after split = " + string(lQuantity))

							if lQuantity > 0 then
								this.of_log("Quantity " + string(lQuantity) + " set to dsContents")
								dsContents.SetItem(k, "nquantity", lQuantity)
							else
								this.of_log("Quantity set to zero")
								dsContents.SetItem(k, "nquantity", 0)
							end if 
							
						else
							
							this.of_log("Contents missing, quantity set to zero")
							dsContents.SetItem(k, "nquantity", 0)
							
						end if
						
						// --------------------------------------------------------------------
						// Nach jedem Durchlauf die Liste der leeren Stauorte neu ermitteln
						// --------------------------------------------------------------------
						uoRanking = uoEmpty
											
						for J = 1 to UpperBound(uoFinal)
							if uoFinal[J].lRanking = lRankings[I] then
								if uoFinal[J].of_is_empty() then
									uoRanking[UpperBound(uoRanking) + 1] = uoFinal[J]
								end if 
							end if
						next
												
					next
					
					destroy(dsAbsoluteSplitting)
									
				else
					// --------------------------------------------------------
					// Normales splitten/parallel verteilen
					// --------------------------------------------------------
					this.of_split(uoRanking, dsContents, lSPML, bLast)
										
				end if
				
				//f_print_datastore(dsContents)
								
			Next	
			
			// --------------------------------------------------------
			// 03.05.2006
			// Beim sortenreinen splitten am Ende alle Positionen 
			// l$$HEX1$$f600$$ENDHEX$$schen, da diese zeilenweise in dsAbsoluteSplitting
			// umgef$$HEX1$$fc00$$ENDHEX$$llt und von dort aus verteilt wurden
			// --------------------------------------------------------
			if strParams.lAbsolute = 1 then
				
				// ------------------------------------------
				// Rang ist verteilt, jetzt den Rest in die
				// selbe Gruppe stopfen 
				// ------------------------------------------
				String sGroup, sPL
				
				dsAbsoluteSplitting = create datastore
				dsAbsoluteSplitting.dataobject = dsContents.dataobject
				
				for k = 1 to dsContents.RowCount()
					
					sPL	= dsContents.GetItemString(k, "cpackinglist")
					lQuantity 		= dsContents.GetItemNumber(k, "nquantity")
					sGroup 			= dsContents.GetItemString(k, "cstowagegroup")
										
					if lQuantity = 0 then continue
					
					this.of_log(sPL  + " has a rest of " + String(lQuantity) + " from parallel Split!")
					
					uoRanking = uoEmpty
					
					for J = 1 to UpperBound(uoFinal)
						if uoFinal[J].of_valid_group(sGroup) then
							uoRanking[UpperBound(uoRanking) + 1] = uoFinal[J]
						end if
					next
					
					dsAbsoluteSplitting.Reset()
					dsContents.RowsCopy(k, k, Primary!, dsAbsoluteSplitting, 1, Primary!)
					
					this.of_sort_by_max_free_space(1, dsAbsoluteSplitting, uoRanking)
					
					// f_print_datastore(dsAbsoluteSplitting)			
						
					this.of_stuffed(uoRanking, dsAbsoluteSplitting, lSPML, True)
					dsContents.SetItem(k, "nquantity", 0)
					
				next
				
				Destroy(dsAbsoluteSplitting)
				
				for k = dsContents.RowCount() to 1 step -1 
					dsContents.DeleteRow(K)
				next
				
			end if
			
		// -------------------------------------------------------------
		// 
		// SPML - Parallel/Splitting
		// 
		// -------------------------------------------------------------
		elseif strParams.lSplitting = 1 and iType = 3 then
			// -------------------------------------------------------------
			// Eindeutigkeit bei den R$$HEX1$$e400$$ENDHEX$$ngen herstellen
			// -------------------------------------------------------------
			lRankings = lEmpty
			For I = 1 to UpperBound(uoFinal)
				bFound = False
				For J = 1 to UpperBound(lRankings)
					if uoFinal[I].lRankingSPML = lRankings[J] then
						bFound = true
						exit
					end if
				Next
				
				if not bFound then
					lRankings[UpperBound(lRankings) + 1] = uoFinal[I].lRankingSPML
				end if
				
			Next
			
			// -------------------------------------------------------------
			// Rankings nochmal sortieren 
			// -------------------------------------------------------------
			if UpperBound(lRankings) > 1 then
				this.of_sort_array(lRankings, strParams.lDirection)
			end if
						
			For I = 1 to UpperBound(lRankings)
				uoRanking = uoEmpty
				For J = 1 to UpperBound(uoFinal)
					if uoFinal[J].lRankingSPML = lRankings[I] and uoFinal[J].of_multi_class() then
						uoRanking[UpperBound(uoRanking) + 1] = uoFinal[J]
					end if
				Next
				if I = UpperBound(lRankings)  and bFinalLoop then
					bLast = True
				else
					bLast = False
				end if
				
				this.of_split(uoRanking, dsContents, lSPML, bLast)
				
			Next
		// --------------------------------------------------------------
		// Kein Schalter an, dann einfach die Beh$$HEX1$$e400$$ENDHEX$$lter voll machen (unter
		// Ber$$HEX1$$fc00$$ENDHEX$$cksichtigung des Ranges) wenn es kein SPML ist 
		// --------------------------------------------------------------
		elseif strParams.lAbsolute = 0 and strParams.lSplitting = 0 and strParams.lAlternate = 0 and iType <> 3 then
			// -------------------------------------------------------------
			// Eindeutigkeit bei den R$$HEX1$$e400$$ENDHEX$$ngen herstellen
			// -------------------------------------------------------------
			lRankings = lEmpty
			For I = 1 to UpperBound(uoFinal)
				bFound = False
				For J = 1 to UpperBound(lRankings)
					if uoFinal[I].lRanking = lRankings[J] then
						bFound = true
						exit
					end if
				Next
				if not bFound then
					lRankings[UpperBound(lRankings) + 1] = uoFinal[I].lRanking
				end if
			Next
			
			// -------------------------------------------------------------
			// Rankings nochmal sortieren 
			// -------------------------------------------------------------
			if UpperBound(lRankings) > 1 then
				this.of_sort_array(lRankings, strParams.lDirection)
			end if
			
			For I = 1 to UpperBound(lRankings)
				uoRanking = uoEmpty
				For J = 1 to UpperBound(uoFinal)
					if uoFinal[J].lRanking = lRankings[I] and uoFinal[J].of_multi_class() then
						uoRanking[UpperBound(uoRanking) + 1] = uoFinal[J]
					end if
				Next
				if I = UpperBound(lRankings)  and bFinalLoop then
					bLast = True
				else
					bLast = False
				end if
				
				this.of_stuffed(uoRanking, dsContents, lSPML, bLast)
				
			Next	
			
		// --------------------------------------------------------------
		// Kein Schalter an, dann einfach die Beh$$HEX1$$e400$$ENDHEX$$lter voll machen (unter
		// Ber$$HEX1$$fc00$$ENDHEX$$cksichtigung des Ranges) wenn es EIN SPML ist 
		// --------------------------------------------------------------
		elseif strParams.lAbsolute = 0 and strParams.lSplitting = 0 and strParams.lAlternate = 0 and iType = 3 then
			// -------------------------------------------------------------
			// Eindeutigkeit bei den R$$HEX1$$e400$$ENDHEX$$ngen herstellen
			// -------------------------------------------------------------
			lRankings = lEmpty
			
			For I = 1 to UpperBound(uoFinal)
				bFound = False
				For J = 1 to UpperBound(lRankings)
					if uoFinal[I].lRankingSPML = lRankings[J] then
						bFound = true
						exit
					end if
				Next
				if not bFound then
					lRankings[UpperBound(lRankings) + 1] = uoFinal[I].lRankingSPML
				end if
			Next
			
			// -------------------------------------------------------------
			// Rankings nochmal sortieren 
			// -------------------------------------------------------------
			if UpperBound(lRankings) > 1 then
				this.of_sort_array(lRankings, strParams.lDirection)
			end if
			
			For I = 1 to UpperBound(lRankings)
				uoRanking = uoEmpty
				For J = 1 to UpperBound(uoFinal)
					if uoFinal[J].lRankingSPML = lRankings[I] and uoFinal[J].of_multi_class() then
						uoRanking[UpperBound(uoRanking) + 1] = uoFinal[J]
					end if
				Next
				if I = UpperBound(lRankings)  and bFinalLoop then
					bLast = True
				else
					bLast = False
				end if
				this.of_stuffed(uoRanking, dsContents, lSPML, bLast)
			Next	
			
		end if
		
	Next
		
Next


// 
// dsContents.SetFilter("")
// dsContents.Filter
// 
this.of_set_priority_maximun(1000, lSPML, dsDistribution)
this.of_set_sort()


// ----------------------------------------------
// Nach der SPML-Verteilung die Kummulierung
// ggf. wieder aufl$$HEX1$$f600$$ENDHEX$$sen
// ----------------------------------------------
if  iType = 3 then
	if this.iAccumulateSPML = 1 and this.iExplodeSPML = 1 then
		this.of_log("SPML explosion is activated!!!!")
		this.of_explode_spmls()
	elseif this.iAccumulateSPML = 1 and this.iExplodeSPML = 0 then
		this.of_log("SPML combining is activated!!!!")
		this.of_combine_spmls()
	elseif this.iAccumulateSPMLType = 1 then
		this.of_log("SPML-Type combining is activated!!!!")
		of_explode_spmlstype()
	end if
end if 

return 0


end function

public function integer of_mcd_prepare ();// -----------------------------------------------
// 
// Klassen l$$HEX1$$f600$$ENDHEX$$schen, wenn eine MCD Beladung
// erfolgen soll, sowie den Stauorten
// im Array den MCD Schalter weitergeben
// -----------------------------------------------
Long 		lRow, &
			lCount

if this.iMCD = 0 then return 0

for lRow = 1 to this.dsLoadinglist.RowCount()
	this.dsLoadingList.SetItem(lRow, "cen_loadinglists_cclass", "")
	this.dsLoadingList.SetItem(lRow, "cclass1", "")
	this.dsLoadingList.SetItem(lRow, "cclass2", "")
	this.dsLoadingList.SetItem(lRow, "cclass3", "")

	this.dsLoadingList.SetItem(lRow, "cclass4", "")
	this.dsLoadingList.SetItem(lRow, "cclass5", "")
	this.dsLoadingList.SetItem(lRow, "cclass6", "")

next

for lCount = 1 to UpperBound(this.uoStowages)
	this.uoStowages[lCount].iMCD	= this.iMCD
next

return 0
end function

public function integer of_stuffed (ref uo_distribution_container uotemp[], datastore dscontents, long lspml, boolean blast);// ---------------------------------------------------------
//
// Beh$$HEX1$$e400$$ENDHEX$$lter voll machen
// 
// ---------------------------------------------------------
Long lRows, lStowages
string 	sStowages
String	sOut

sStowages = ""
For lRows =  1 to UpperBound(uoTemp)
	sStowages += uoTemp[lRows].sStowage + "/"
Next

//Messagebox("Stowages for STUFFED Distribution", "Type: " + string(lSPML) + "~r" + sStowages)
this.of_log("------------------------------------------------------------")
this.of_log(" S T U F F E D  ")
this.of_log("------------------------------------------------------------")
this.of_log("Stowage sort: " + sStowages )

for lStowages = 1 to UpperBound(uoTemp)
	
//	uoTemp[lStowages].dsContent.SetFilter("")
//	uoTemp[lStowages].dsContent.Filter()
	
	for lRows = 1 to dsContents.RowCount()	
		
		this.of_log("Class: " + this.of_checknull(uoTemp[lStowages].sClass1) + this.of_checknull(uoTemp[lStowages].sClass2) + this.of_checknull(uoTemp[lStowages].sClass3) + " Stowage: " +  uoTemp[lStowages].sStowage)
	
		sOut  = dsContents.GetItemString(lRows, "cpackinglist")
		sOut += " - quantity is " + String(dsContents.GetItemNumber(lRows, "nquantity"))
		this.of_log("       " + sOut)
		
		if uoTemp[lStowages].of_fill_stuffed(lRows, dsContents, lSPML)	<> 0 then
			this.of_log("Error of_stuffed: " + uoTemp[lStowages].sError)
		end if
		
	next

next

// ---------------------------------------------------------
// Alles was nicht verteilt werden konnte in die Errorliste 
// kopieren
// ---------------------------------------------------------
for lRows = dsContents.RowCount() to 1 Step -1
	if dsContents.GetItemNumber(lRows, "nquantity") > 0 and bLast then
		// Messagebox("", "Rest: " + string(dsContents.GetItemNumber(lRows, "nquantity")))
		if dsContents.RowsMove(lRows, lRows, Primary!,  this.dsDistributionErrors, this.dsDistributionErrors.RowCount() + 1, Primary!) <> 1 then
			this.of_log("ERROR Rowscopy to ErrorList failed!")
		end if
	end if
next

return 0
end function

public function integer of_add_text_to_label ();// -----------------------------------------------------------
//
// die Verteilten Mahlzeiten ins dsLoadinglist eintragen,
// damit sie auf dem Label auftauchen
//
// -----------------------------------------------------------
Long		lStowages, &
			lFound, &
			I, &
			lLabelType, &
			lRow, &
			lQuantity, &
			lSortKey, &
			lKey, &
			lWrap
			
			
String	sText, &
			sFontName, &
			sDistributionType, &
			sDistributionKey 

Long		lTextRows, &
			lFontweight, &
			lFontsize, &
			lObjectHeight, &
			lTextHeight, &
			lTextWidth, &
			lCounter, &
			lLabelCounter, &
			lMaxLabels

boolean lb_Bold

long		lrecord_count

//f_print_datastore(this.dsLoadingList)

this.of_log("-----------------------------------------------------" ) 
this.of_log("Got these stowages in of_add_text_to_label()" ) 
this.of_log("-----------------------------------------------------" )
for lStowages = 1 to Upperbound(this.uoStowages)
	this.of_log("    " + this.uoStowages[lStowages].sStowage + " with " + string(this.uoStowages[lStowages].dsContent.RowCount()) + "Contents ")
next

//Maximalen Recordcount vor Zeilenverdopplung (f$$HEX1$$fc00$$ENDHEX$$r Storagefunktion)
lrecord_count = dsloadinglist.rowcount() + 1

// ---------------------------------------------
// Text f$$HEX1$$fc00$$ENDHEX$$rs Label erzeugen
// ---------------------------------------------
for lStowages = 1 to Upperbound(this.uoStowages)
	
	if this.uoStowages[lStowages].dsContent.RowCount() <= 0 then continue
	
	this.uoStowages[lStowages].dsContent.Sort()
	
	if this.uoStowages[lStowages].lLoadRow = 55 then
		lrecord_count = lrecord_count
	end if
	
	lFound = this.dsLoadingList.Find("ndistribution_detail_key=" + String(this.uoStowages[lStowages].lLoadRow), 1, this.dsLoadingList.RowCount())

	if lFound > 0 then
		
		// ----------------------------------------------------------------------
		// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob der LabelTyp das Feld cdistributed_components eingetragen
		// hat, wenn ja, dann maximal Anzahl von Eintr$$HEX1$$e400$$ENDHEX$$gen ausrechnen
		// ----------------------------------------------------------------------
		if this.dsLoadingList.GetItemNumber(lFound, "cen_packinglists_nlabel_type_key") <> lLabelType then
						
			lLabelType = this.dsLoadingList.GetItemNumber(lFound, "cen_packinglists_nlabel_type_key")
			this.dsLabelObjects.Retrieve(lLabelType, this.of_find_valid_label(lLabelType, this.dtDeparture))
			
			if this.dsLabelObjects.RowCount() = 0 then 	// das Feld cdistributed_components ist nicht vorhanden

				continue												// die Verteilten Komponenten erscheinen nicht auf dem Label
			else
				lWrap         = dsLabelObjects.Getitemnumber(1,"nwrap")
				sFontname     = dsLabelObjects.Getitemstring(1,"cfontname")
				lFontweight   = dsLabelObjects.Getitemnumber(1,"nfontweight")
				lFontsize     = dsLabelObjects.Getitemnumber(1,"nfontsize") 
				lObjectHeight = dsLabelObjects.Getitemnumber(1,"nheight")
				lb_Bold       = (lFontweight = 700)
				
				iuo_FontCalc.of_GetTextSize("Calculate", sFontName, lFontSize * -1, lb_Bold, false, false, lTextHeight, lTextWidth)				
				
				if lWrap = 1 then
					lObjectHeight = lObjectHeight / 2
				end if
				
				lTextRows				= lObjectHeight / lTextHeight
				//Messagebox("+++ UO_DISTRIBUTION +++", "lHeight: "  + string(lObjectHeight) + "~r~rlTextHeight: " + string(lTextHeight) +  "~r~rlTextRows: " +  string(lTextRows))

				this.of_log("Labeltype[" + string(lLabelType) + "] - No. of rows in LF - Label: " + string(lTextRows) ) 
				
			end if
			
		end if
		
		if lTextrows = 0 then 
			this.of_log("Error iTextRow = 0 for Stowage " + this.uoStowages[lStowages].sStowage)
			continue
		end if			
		
		lMaxLabels				= Ceiling(this.uoStowages[lStowages].dsContent.RowCount() / lTextRows)
			
		this.of_log("Labeltype[" + string(lLabelType) + "] - No. of Labels will be created: " + string(lMaxLabels) ) 
		this.of_log("Labeltype[" + string(lLabelType) + "] - No. contents to display: " + string(Ceiling(this.uoStowages[lStowages].dsContent.RowCount())) ) 
		
		// -------------------------------------------------------------------------
		// Die Texte zusammenbauen .....
		// -------------------------------------------------------------------------
		sText 	= ""
		lCounter = 0
		lLabelCounter = 0
		
		For I = 1 to this.uoStowages[lStowages].dsContent.RowCount()
			
			lQuantity = this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nquantity")
			sText	+= this.of_checknull(String(lQuantity)) + "~t"
			sText += this.of_checknull(this.uoStowages[lStowages].dsContent.GetItemString(I, "ctext")) + "~t" 
			sText += this.of_checknull(this.uoStowages[lStowages].dsContent.GetItemString(I, "cpackinglist")) + "~t" 						
			//MB 22.01.2012: Meal Control Code erg$$HEX1$$e400$$ENDHEX$$nzen (aber nur die ersten beiden Stellen)
			sText += this.of_checknull(left(this.uoStowages[lStowages].dsContent.GetItemString(I, "cmeal_control_code"),2)) + "~n" 				
			// ----------------------------------------------------------------------
			// pr$$HEX1$$fc00$$ENDHEX$$fen, dass wenn die maximal zul$$HEX1$$e400$$ENDHEX$$ssige Anzahl an Texten eingetragen
			// wurde ein Rowscopy passiert
			// ----------------------------------------------------------------------
			lCounter ++
			if lCounter = lTextRows then
				
				lLabelCounter ++
			
				// if lLabelType = 1542 then this.of_log("Labeltype[" + string(lLabelType) + "] - " + sText)
			
				this.dsLoadingList.SetItem(lFound, "cdistributed_components", sText)
				this.dsLoadingList.SetItem(lFound, "pldetail_label_counter", string(lLabelCounter) + " of " + string(lMaxLabels))
				if lLabelCounter > 1 then this.dsLoadingList.SetItem(lFound, "nduplicated", 1)
												
				sText = ""
				lCounter = 0
				
				if i <> this.uoStowages[lStowages].dsContent.RowCount() then
					this.dsLoadingList.RowsCopy(lFound, lFound, Primary!, this.dsLoadingList, lFound + 1, Primary!)
					lFound ++
					//MB: 04.03.2013
					//Den Recordcount mit hochz$$HEX1$$e400$$ENDHEX$$hlen, sonst funktioniert die Storefunktion nicht richtig
//					this.dsLoadingList.SetItem(lFound, "nrecord_count", lrecord_count)
//					lrecord_count ++
				else
					exit
				end if
								
			end if	
			
		Next
		
		// ----------------------------------------------------------------------
		// ..... und eintragen !
		// ----------------------------------------------------------------------
		if sText <> "" then
			lLabelCounter ++
			this.dsLoadingList.SetItem(lFound, "cdistributed_components", sText)
			this.dsLoadingList.SetItem(lFound, "pldetail_label_counter", string(lLabelCounter) + " of " + string(lMaxLabels))
			if lLabelCounter > 1 then this.dsLoadingList.SetItem(lFound, "nduplicated", 1)
		end if
		
	end if
		
next

//f_print_datastore(dsLoadingList)

// ----------------------------------------------------
// Mahlzeiten ins CheckSheet eintragen
// ----------------------------------------------------
if this.dsCheckSheet.RowCount() > 0 then
	this.of_check_sheet()
end if 

//this.dsLoadingList.SaveAs("c:\temp\loading.xls", Excel5!, true)

return 0
end function

public function integer of_add_classnumbers (integer itype);// ---------------------------------------------------
//
// Klassennummer zuspielen
// 
// ---------------------------------------------------
datastore 	dsContents

Long			lRow, &
				lFound

String		sClass, &
				sClassColumn
				
Long			lStart, lEnde


lStart = CPU()
// ---------------------------------------------------
// Parameter iType
// 1 = Mahlzeiten
// 2 = Extrabeladung
// 3 = SPML
// 4 = dw_loadinglist_result
// ---------------------------------------------------
if iType = 1 then
	dsContents = this.dsMeals
	sClassColumn = "cclass"
elseif iType = 2 then
	dsContents = this.dsAdditional
	sClassColumn = "cclass"
elseif iType = 3 then
	dsContents = this.dsSPMLDistribution
	sClassColumn = "cclass"
elseif iType = 4 then
	dsContents = this.dsLoadingList
	sClassColumn = "cclass1"
else
	return -1
end if 

For lRow = 1 to dsContents.RowCount()
	
	sClass = this.of_checknull(dsContents.GetItemString(lRow, sClassColumn))
	
	if isnull(dsContents.GetItemString(lRow, sClassColumn)) then dsContents.SetItem(lRow, sClassColumn, "")
	
	lFound = this.dsClasses.Find("cclass='" + sClass + "'", 1, dsClasses.RowCount())
	
	if lFound > 0 then
		dsContents.SetItem(lRow, "nclass_number", this.dsClasses.GetItemNumber(lFound, "nclass_number"))
	else
		//messagebox(string(lFound), of_checknull(sClass))
	end if
	
Next

lEnde = CPU()
of_log("of_add_classnumbers(" + string(iType) + ") took " + string((lEnde - lStart)/1000, "0.00") + " seconds!")

return 0
end function

public function integer of_get_distribution_parameters ();
// --------------------------------------------------------------------------------
// Objekt : uo_distribution
// Methode: of_get_distribution_parameters (Function)
// Beschreibung:		Ermittlung Verteilerschl$$HEX1$$fc00$$ENDHEX$$ssel
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			<unknown>
// 1.1 			O.Hoefer	25.08.2016		Erstkommentar; Weiche zu neuer Strategie (pro AC Type ohne Handling Objekt CBASE-F4-CR-2015-014)
//
//
// Return: integer
//
// --------------------------------------------------------------------------------

// ---------------------------------------------------------------
//
// Die, je Galley anzuwendende Verteilerroutine finden
//
// ---------------------------------------------------------------
Long 	lCover, &
		i, &
		lKey, &
		lMealKey

Long	lStart, lEnde

lStart = CPU()

string ls_out

// Messagebox("", this.lAircraftKey)


If bNewDistrubtionAssignment Then
	// ---------------------------------------------------------------------------------------------
	// 24.08.2016: Verteilerschl$$HEX1$$fc00$$ENDHEX$$ssel pro AC Type ohne Handling Objekt (CBASE-F4-CR-2015-014)
	// ---------------------------------------------------------------------------------------------
	Return of_get_distribution_parameters_by_ac()
Else
	// ---------------------------------------------------------------
	// Verteilerschl$$HEX1$$fc00$$ENDHEX$$ssel in bisheriger Variante ermitteln
	// ---------------------------------------------------------------
End If


// ---------------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r die Mahlzeitenbeladung
// ---------------------------------------------------------------
this.dsDistributingMeals.Retrieve(this.lAircraftKey)
		
if this.dsDistributingMeals.RowCount() = 0 then
	this.sError = "No galleyparameters for Meal distribution found"
	return -1
else
	
	if this.dsMeals.RowCount() > 0  then
		// ---------------------------------------------------------
		// Alle "unbest$$HEX1$$fc00$$ENDHEX$$ckten" Galley mit den Verteilungsparametern
		// aus dem "Cover Objekt" best$$HEX1$$fc00$$ENDHEX$$cken
		// ---------------------------------------------------------
		lCover = this.dsMeals.GetItemNumber(1, "ncover_key")
		
		this.of_log("------------------------------------------------------------------------------------------------------------------------")
		ls_out = ""
		For i = 1 to Upperbound(lResultKeys)
			ls_out += String(lResultKeys[i])
			if i <>  Upperbound(lResultKeys) then
				ls_out += ", "
			end if
		Next
		
		this.of_log("nresult_keys = " + ls_out)
		this.of_log("First item list is used to identify Distribution rule: " + this.dsMeals.GetItemString(1, "cpackinglist") + " - " + this.dsMeals.GetItemString(1, "cproduction_text"))
		this.of_log("-------------------------------------------------------------------------------------------------------------------------")
				
				
		if not isnull(lCover) then
			
			// --------------------------------------------------------------------------------------------------------------------
			// 07.02.2013 HR: Tabelle durch View ersetzt (NAMR-CR-1212042)
			// --------------------------------------------------------------------------------------------------------------------
			//select distinct ndistribution_key into :lMealKey from cen_meal_cover where nhandling_key = :lCover and naircraft_key = :this.lAircraftKey and ndistribution_key > 0;
			select distinct ndistribution_key into :lMealKey from cen_meal_cover_v where nhandling_key = :lCover and naircraft_key = :this.lAircraftKey and ndistribution_key > 0;
				
			// Messagebox("sqlcode " + String(sqlca.sqlcode) + "               ", "lMealKey " + String(lMealKey) + " lCover  " + String(lCover))
			// --------------------------------------------
			// Verteilerroutine f$$HEX1$$fc00$$ENDHEX$$r den AC-Typ suchen
			// --------------------------------------------
			if sqlca.sqlcode = 0 then
				
				if this.iTrace = 1 then
					ls_out = ""
					select ctext into :ls_out from cen_handling where nhandling_key = :lCover;
					if sqlca.sqlcode = 0 then
						this.of_log("[1] Meal loading is: " + ls_out)
					else
						this.of_log("Error getting Meal Loading description: " + sqlca.sqlerrtext)
					end if
					
					ls_out = ""
					select ctext into :ls_out from cen_distribution where ndistribution_key = :lMealKey;
					if sqlca.sqlcode = 0 then
						this.of_log("Using Distribution rule: " + ls_out)
					else
						this.of_log("Error getting Distribution Rule description: " + sqlca.sqlerrtext)
					end if
				end if
				
				lMealKey = f_get_valid_distribution_key(lMealKey,  date(dtDeparture) )

				for I = 1 to this.dsDistributingMeals.RowCount()
					if isnull(this.dsDistributingMeals.GetItemNumber(I, "ndistribution_key")) then
						this.dsDistributingMeals.SetItem(I, "ndistribution_key", lMealKey)
						this.dsDistributingMeals.SetItem(I, "ngroup", 9999)
					end if
				next
				
				for I = 1 to this.dsMeals.RowCount()
					this.dsMeals.SetItem(i, "ndistribution_key", lMealKey)
				next
				
				// ------------------------------------
				// SPMLs auch 
				// ------------------------------------
				for I = 1 to this.dsSPMLDistribution.RowCount()
					this.dsSPMLDistribution.SetItem(i, "ndistribution_key", lMealKey)
				next
				
			// --------------------------------------------
			// Keine f$$HEX1$$fc00$$ENDHEX$$r den AC-Typ gefunden, nach der
			// Default Verteilung suchen
			// --------------------------------------------
			elseif sqlca.sqlcode = 100 then
				// Messagebox("Log", "Log")
				this.of_log("of_get_distribution_parameters/MEALS for parameter nhandling_key = " + String(lCover) + " found no distribution routine for aircraft: " + string(this.lAircraftKey))
				this.of_log("nhandling_key=" + String(lCover) + " looking for default!")
				
				// --------------------------------------------------------------------------------------------------------------------
				// 07.02.2013 HR: Tabelle durch View ersetzt (NAMR-CR-1212042)
				// --------------------------------------------------------------------------------------------------------------------
				//select distinct ndistribution_key into :lMealKey from cen_meal_cover where nhandling_key = :lCover and naircraft_default = 1 and ndistribution_key > 0;
				select distinct ndistribution_key into :lMealKey from cen_meal_cover_v where nhandling_key = :lCover and naircraft_default = 1 and ndistribution_key > 0;
				// Messagebox("sqlcode " + String(sqlca.sqlcode) + "               ", "lMealKey " + String(lMealKey) + " lCover  " + String(lCover))
				
				if sqlca.sqlcode = 0 then
					
					if this.iTrace = 1 then
						ls_out = ""
						select ctext into :ls_out from cen_handling where nhandling_key = :lCover;
						if sqlca.sqlcode = 0 then
							this.of_log("[2] Meal loading is: " + ls_out)
						else
							this.of_log("Error getting Meal Loading description: " + sqlca.sqlerrtext)
						end if
						
						ls_out = ""
						select ctext into :ls_out from cen_distribution where ndistribution_key = :lMealKey;
						if sqlca.sqlcode = 0 then
							this.of_log("Using Distribution rule: " + ls_out)
						else
							this.of_log("Error getting Distribution Rule description: " + sqlca.sqlerrtext)
						end if
					end if
					
					lMealKey = f_get_valid_distribution_key(lMealKey,  date(dtDeparture) )
					
					for I = 1 to this.dsDistributingMeals.RowCount()
						if isnull(this.dsDistributingMeals.GetItemNumber(I, "ndistribution_key")) then
							this.dsDistributingMeals.SetItem(I, "ndistribution_key", lMealKey)
							this.dsDistributingMeals.SetItem(I, "ngroup", 9999)
						end if
					next
					
					for I = 1 to this.dsMeals.RowCount()
						this.dsMeals.SetItem(i, "ndistribution_key", lMealKey)
					next
					
					// ------------------------------------
					// SPML's auch 
					// ------------------------------------
					for I = 1 to this.dsSPMLDistribution.RowCount()
						this.dsSPMLDistribution.SetItem(i, "ndistribution_key", lMealKey)
					next
		
				else
					// ------------------------------------
					// 06.03.07, KF
					// ------------------------------------
					// Immernoch nix gefunden,
					// kann nur sein, wenn die erste Zeile 
					// der Mahlzeitenbeladung manuell im 
					// Flugbrowser aufgenommen wurde
					// ------------------------------------
					// Beliebige Verteilerroutine verwenden
					// ------------------------------------
					this.of_log(".. no default rule found, now looking for a random distribution rule")
					select max(ncover_key) into :lCover from cen_out_meals where nresult_key = :this.lResultKey and nmodule_type = 0;
					
					if sqlca.sqlcode <> 0 then
						// So genug gesucht ...
						this.sError = "of_get_distribution_parameters/MAX ncover_key: [" + string(sqlca.sqlcode) + "] - " + sqlca.sqlerrtext
						return -1
					end if
					
					select distinct ndistribution_key into :lMealKey from cen_meal_cover where nhandling_key = :lCover and naircraft_key = :this.lAircraftKey;
					
					if sqlca.sqlcode <> 0 then
						this.sError = "of_get_distribution_parameters/Meals MAX ncover_key: [" + string(sqlca.sqlcode) + "] - " + sqlca.sqlerrtext
						return -1
					end if
					
					lMealKey = f_get_valid_distribution_key(lMealKey,  date(dtDeparture) )

					if this.iTrace = 1 then
						ls_out = ""
						select ctext into :ls_out from cen_handling where nhandling_key = :lCover;
						if sqlca.sqlcode = 0 then
							this.of_log("[3] Meal loading is: " + ls_out)
						else
							this.of_log("Error getting Meal Loading description: " + sqlca.sqlerrtext)
						end if
						
						ls_out = ""
						select ctext into :ls_out from cen_distribution where ndistribution_key = :lMealKey;
						if sqlca.sqlcode = 0 then
							this.of_log("Using Distribution rule: " + ls_out)
						else
							this.of_log("Error getting Distribution Rule description: " + sqlca.sqlerrtext)
						end if
					end if
				
					this.of_log(".. found rule with key " + string(lMealKey))
					
					for I = 1 to this.dsDistributingMeals.RowCount()
						if isnull(this.dsDistributingMeals.GetItemNumber(I, "ndistribution_key")) then
							this.dsDistributingMeals.SetItem(I, "ndistribution_key", lMealKey)
							this.dsDistributingMeals.SetItem(I, "ngroup", 9999)
						end if
					next
					
					for I = 1 to this.dsMeals.RowCount()
						this.dsMeals.SetItem(i, "ndistribution_key", lMealKey)
					next
					
					// ------------------------------------
					// SPMLs auch 
					// ------------------------------------
					for I = 1 to this.dsSPMLDistribution.RowCount()
						this.dsSPMLDistribution.SetItem(i, "ndistribution_key", lMealKey)
					next
					
				end if
				
			else
				this.sError = "of_get_distribution_parameters/MEALS: [" + string(sqlca.sqlcode) + "] - " + sqlca.sqlerrtext
				this.sError += " for parameter nhandling_key=" + String(lCover)
				return -1
			end if
			
		end if
		
		
	end if
	
end if

// ---------------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r die Extrabeladung
// ---------------------------------------------------------------
this.dsDistributingAdditional.Retrieve(this.lAircraftKey)
		
if this.dsDistributingAdditional.RowCount() = 0 then
	this.sError = "No galleyparameters for Additional distribution found"
	return -1
else
	
	if this.dsAdditional.RowCount() > 0  then
		// ---------------------------------------------------------
		// Alle "unbest$$HEX1$$fc00$$ENDHEX$$ckten" Galley mit den Verteilungsparametern
		// aus dem "Cover Objekt" best$$HEX1$$fc00$$ENDHEX$$cken
		// ---------------------------------------------------------
		lCover = this.dsAdditional.GetItemNumber(1, "ncover_key")
		
		if lCover = 0 then
			if this.dsMeals.RowCount() > 0 then
				lCover = this.dsMeals.GetItemNumber(1, "ncover_key")
			else
				this.of_log("of_get_distribution_parameters/ADDITIONAL found no distribution routine for aircraft: " + string(this.lAircraftKey))				
				return -1
			end if
		end if
		
				
		if not isnull(lCover) then
			
			// --------------------------------------------------------------------------------------------------------------------
			// 07.02.2013 HR: Tabelle durch View ersetzt (NAMR-CR-1212042)
			// --------------------------------------------------------------------------------------------------------------------
			//select distinct ndistribution_key into :lKey from cen_meal_cover where nhandling_key = :lCover and naircraft_key = :this.lAircraftKey and ndistribution_key > 0;
			select distinct ndistribution_key into :lKey from cen_meal_cover_v where nhandling_key = :lCover and naircraft_key = :this.lAircraftKey and ndistribution_key > 0;			
			
			if sqlca.sqlcode = 0 then
				
				lKey = f_get_valid_distribution_key(lKey,  date(dtDeparture) )

				
				for I = 1 to this.dsDistributingAdditional.RowCount()
					if isnull(this.dsDistributingAdditional.GetItemNumber(I, "ndistribution_key")) then
						this.dsDistributingAdditional.SetItem(I, "ndistribution_key", lKey)
						this.dsDistributingAdditional.SetItem(I, "ngroup", 9999)
					end if
				next
				
				for I = 1 to this.dsAdditional.RowCount()
					this.dsAdditional.SetItem(i, "ndistribution_key", lKey)
				next

				
			// --------------------------------------------
			// Keine f$$HEX1$$fc00$$ENDHEX$$r den AC-Typ gefunden, nach der
			// Default Verteilung suchen
			// --------------------------------------------
			elseif sqlca.sqlcode = 100 then
				
				this.of_log("of_get_distribution_parameters/ADDITIONAL for parameter nhandling_key = " + String(lCover) + " found no distribution routine for aircraft: " + string(this.lAircraftKey))
				this.of_log("nhandling_key=" + String(lCover) + " looking for default!")
				
				// --------------------------------------------------------------------------------------------------------------------
				// 07.02.2013 HR: Tabelle durch View ersetzt (NAMR-CR-1212042)
				// --------------------------------------------------------------------------------------------------------------------
				//select distinct ndistribution_key into :lKey from cen_meal_cover where nhandling_key = :lCover and naircraft_default = 1 and ndistribution_key > 0;
				select distinct ndistribution_key into :lKey from cen_meal_cover_v where nhandling_key = :lCover and naircraft_default = 1 and ndistribution_key > 0;
				
				if sqlca.sqlcode = 0 then
					
					lKey = f_get_valid_distribution_key(lKey,  date(dtDeparture) )

					for I = 1 to this.dsDistributingAdditional.RowCount()
						
						if isnull(this.dsDistributingAdditional.GetItemNumber(I, "ndistribution_key")) then
							this.dsDistributingAdditional.SetItem(I, "ndistribution_key", lKey)
							this.dsDistributingAdditional.SetItem(I, "ngroup", 9999)
						end if
						
					next
					
					for I = 1 to this.dsAdditional.RowCount()
						this.dsAdditional.SetItem(i, "ndistribution_key", lKey)
					next
					
				else
					
					// -------------------------------------------------
					// Auch nix gefunden, dann die von den Mahlzeiten
					// verwenden
					// -------------------------------------------------
					for I = 1 to this.dsDistributingAdditional.RowCount()
						
						if isnull(this.dsDistributingAdditional.GetItemNumber(I, "ndistribution_key")) then
							this.dsDistributingAdditional.SetItem(I, "ndistribution_key", lMealKey)
							this.dsDistributingAdditional.SetItem(I, "ngroup", 9999)
						end if
						
					next
					
					for I = 1 to this.dsAdditional.RowCount()
						this.dsAdditional.SetItem(i, "ndistribution_key", lMealKey)
					next

					of_log("of_get_distribution_parameters()/ADDITIONAL using MealParameter: " + String(lMealKey))
//					this.sError = "of_get_distribution_parameters/ADDITIONAL: [" + string(sqlca.sqlcode) + "] - " + sqlca.sqlerrtext
//					this.sError += " for parameter nhandling_key=" + String(lCover)
//					return -1
				end if

			else
				this.sError = "of_get_distribution_parameters/ADDITIONAL: " + sqlca.sqlerrtext
				this.sError += " for parameter nhandling_key=" + String(lCover)
				return -1
			end if
			
		end if
		
	end if
	
end if

// ---------------------------------------------------------------
// Anhand der ersten Verteilerroutine ermitteln, ob es
// eine MCD Verteilung ist
// ---------------------------------------------------------------
if this.dsDistributingMeals.RowCount() > 0 then
	lKey = this.dsDistributingMeals.GetItemNumber(1, "ndistribution_key")
elseif this.dsDistributingAdditional.RowCount() > 0 then
	lKey = this.dsDistributingAdditional.GetItemNumber(1, "ndistribution_key")
else
	this.sError = "No distribution key found !!"
	return -1
end if


lKey = f_get_valid_distribution_key(lKey,  date(dtDeparture) )

select nmcd, nmixed into :this.iMCD, :this.iMixed  from cen_distribution where ndistribution_key = :lKey;



if isnull(this.iMCD) then this.iMCD = 0
if isnull(this.iMixed) then this.iMixed = 0
// Messagebox("", "iMCD:" + string(iMcd) + "~riAccumulateSPML:" + String(iAccumulateSPML) +"~riMixed:" + String(iMixed))

if sqlca.sqlcode <> 0 then
	this.sError = "distribution key error: " + sqlca.sqlerrtext
	return -1
end if

lEnde = CPU()
of_log("of_get_distribution_parameters() took " + string((lEnde - lStart)/1000, "0.00") + " seconds!")


return 0

end function

public function integer of_load_components (integer itype);// ---------------------------------------------------
//
// Belademengen aggregieren
// 
// ---------------------------------------------------
datastore 	dsTemp, &
				dsComponents

Long			lRow, &
				lFound, &
				lQuantity, &
				lQuantityOld, &
				lModule, &
				lPlType

String		sClass, &
				sCode, &
				sPlNumber, &
				sPlText, &
				sFind

Long			lStart, lEnde

lStart 		= CPU()
// ---------------------------------------------------
// Parameter iType
// 1 = Mahlzeiten
// 2 = Extrabeladung
// ---------------------------------------------------
if iType = 1 then
	dsComponents 	= this.dsMeals
	lModule 			= 0
elseif iType = 2 then
	dsComponents 	= this.dsAdditional
	lModule 			= 1
else
	return -1
end if 

dsTemp		= create datastore
dsTemp.dataobject = "dw_uo_cen_out_meals"
dsTemp.SetTransObject(sqlca)
dsTemp.Retrieve(this.lResultKeys, lModule, this.dtDeparture)

//if iType = 1 then
//	f_print_datastore(dsTemp)
//end if

// ---------------------------------------------------------
// Dann die mit SL-Type in den Datastore $$HEX1$$fc00$$ENDHEX$$bertragen und 
// ggf. kummulieren
// ---------------------------------------------------------
for lRow = 1 to dsTemp.RowCount()
	
	lQuantity	= dsTemp.GetItemNumber(lRow, "nquantity")
	sClass		= dsTemp.GetItemString(lRow, "cclass")
	sCode			= dsTemp.GetItemString(lRow, "cmeal_control_code")
	sPlNumber	= dsTemp.GetItemString(lRow, "cpackinglist")
	sPlText		= dsTemp.GetItemString(lRow, "cproduction_text")
	
	sFind 		= "cclass='" + sClass + "' and " + &
					  "cpackinglist='" + sPlNumber + "' and " + &	
					  "cmeal_control_code='" + sCode + "'"
	
	lFound = dsComponents.Find(sFind, 1, dsComponents.RowCount())
	
	if lFound > 0 then
		lQuantityOld = dsComponents.GetItemNumber(lFound, "nquantity")
		dsComponents.SetItem(lFound, "nquantity", lQuantityOld + lQuantity)
	elseif lFound = 0 then
		dsTemp.RowsCopy(lRow, lRow, Primary!, dsComponents, dsComponents.RowCount() + 1, Primary! )
		//dsComponents.SetItem(dsComponents.RowCount(), "npercentage",0)
	end if								 
	
next

Destroy(dsTemp)
lEnde 		= CPU()
of_log("of_load_components(" + string(iType) + ") took " + string((lEnde - lStart) / 1000, "0.00") + " seconds!")

return 0
end function

public function integer of_get_dimensions ();// -------------------------------------------------
//
//  dsLoadingList um die Informationen aus
//  cen_packinglist_size anreichern
// 
//  Alle Datens$$HEX1$$e400$$ENDHEX$$tze werden durchnummeriert.
//  Die Nummerierung dient als Schl$$HEX1$$fc00$$ENDHEX$$ssel in
//  dsPackinglistSizes
// 
// -------------------------------------------------
Long 				lRow, &
					lIndex, &
					lDetail, &
					lSizes, &
					lInsert, &
					a, &
					i, &
					j, &
					lCount, &
					lWidth, &
					lLeg, &
					lNextLeg, &
					lSeparate, &
					lQuantity, &
					lComponentQuantity, &
					lFound, &
					lFoundStowage, &
					lStart, &
					lEnde, &
					lStartPart, &
					lEndePart, &
					ll_initial_width, & 
					ll_sum_devided_width
										
String			sPackingList, sFilter, sCode, sDefault, sStowageGroup, ls_temp, ls_meal_control_codes[], ls_legs, ls_stowage
boolean			bFound
Long				ll_Height, ll_empty[], ll_catering_legs[], ll_counter, ll_leg_counter
Boolean			lb_Breakpoint
Long				ll_Temp_key
Datastore		dsPackinglistSizeTemp

Integer 			iMultileg

dsPackinglistSizeTemp = Create Datastore
dsPackinglistSizeTemp.dataobject = "dw_uo_packinglist_size"

lStart = CPU()

ls_meal_control_codes[1] = "cmeal_control_code"
ls_meal_control_codes[2] = "cmeal_control_code2"
ls_meal_control_codes[3] = "cmeal_control_code3"
ls_meal_control_codes[4] = "cmeal_control_code4"
ls_meal_control_codes[5] = "cmeal_control_code5"
ls_meal_control_codes[6] = "cmeal_control_code6"
ls_meal_control_codes[7] = "cmeal_control_code7"
ls_meal_control_codes[8] = "cmeal_control_code8"
ls_meal_control_codes[9] = "cmeal_control_code9"

// ---------------------------------------------------
// Die Stauortgruppe in einem Array einsammeln
// ---------------------------------------------------
For i = 1 to this.dsStowageGroups.RowCount()

	sStowageGroup 	= this.dsStowageGroups.GetItemString(i, "ctext")
	bFound 			= false
	
	for j = 1 to UpperBound(this.sStowageGroups)
		
		if this.sStowageGroups[j] = sStowageGroup then
			bFound = true
			exit
		end if
		
	next

	if not bFound then
		sStowageGroups[Upperbound(sStowageGroups) + 1] = sStowageGroup
	end if 
	
Next

sStowageGroups[Upperbound(sStowageGroups) + 1] = "-1"

this.of_log("---------------------------------------------------")
this.of_log("Unique StowageGroupArray contains " + String(Upperbound(sStowageGroups)) + " groups")
this.of_log("---------------------------------------------------")
For i = 1 to Upperbound(sStowageGroups)
	this.of_log(String(i, "00") + " -> " + sStowageGroups[i])
Next	
this.of_log("---------------------------------------------------")

lStartPart = CPU()

for lRow = 1 to this.dsLoadingList.RowCount()
	
	// -------------------------------------------------------------------
	// Leg Array initialisieren
	// -------------------------------------------------------------------
	ll_catering_legs = ll_empty
	ll_catering_legs[1] = 0
	ll_catering_legs[2] = 0
	ll_catering_legs[3] = 0
	ll_catering_legs[4] = 0
	ll_catering_legs[5] = 0
	ll_catering_legs[6] = 0
	ll_catering_legs[7] = 0
	ll_catering_legs[8] = 0
	ll_catering_legs[9] = 0

	sPackingList = this.dsLoadingList.GetItemString(lRow, "cen_packinglist_index_cpackinglist")
	ls_stowage = this.dsLoadingList.GetItemString(lRow, "cen_galley_cgalley") + "-" + dsLoadingList.GetItemString(lRow, "cen_stowage_cstowage") + " " + dsLoadingList.GetItemString(lRow, "cen_stowage_cplace")
	
	
	if isnull(this.dsLoadingList.GetItemNumber(lRow, "nranking")) then this.dsLoadingList.SetItem(lRow, "nranking", 1000) 
	if isnull(this.dsLoadingList.GetItemNumber(lRow, "nranking_spml")) then this.dsLoadingList.SetItem(lRow, "nranking_spml", 1000) 
	
	if this.dsLoadingList.GetItemNumber(lRow, "nranking") = 0 then this.dsLoadingList.SetItem(lRow, "nranking", 1000) 
	if this.dsLoadingList.GetItemNumber(lRow, "nranking_spml") = 0 then this.dsLoadingList.SetItem(lRow, "nranking_spml", 1000) 
	this.dsLoadingList.SetItem(lRow, "nunit_priority", 1000)
	
	// ----------------------------------------------------------
	// Nachschaun, ob H$$HEX1$$f600$$ENDHEX$$hen und Tiefen definiert sind
	// und ob das Teil ggf. f$$HEX1$$fc00$$ENDHEX$$r 2 Legs Komponenten 
	// aufnehmen soll !!!
	// ----------------------------------------------------------
	lIndex  		=  this.dsLoadingList.GetItemNumber(lRow, "cen_packinglist_index_npackinglist_index_key")
	lDetail 		=  this.dsLoadingList.GetItemNumber(lRow, "cen_packinglists_npackinglist_detail_key")
	lLeg    		=  Long(Mid(String(this.dsLoadingList.GetItemNumber(lRow, "compute_leg")), 1, 1))
	lNextLeg   	=  Long(Mid(String(this.dsLoadingList.GetItemNumber(lRow, "compute_leg")), 2, 1))
	
	ls_legs = String(this.dsLoadingList.GetItemNumber(lRow, "compute_leg"))
	
	for ll_leg_counter = 1 to len(ls_legs)
		ll_catering_legs[ll_leg_counter] = Long(Mid(ls_legs, ll_leg_counter, 1))
	next
	
	lSeparate  	=  of_checknull(this.dsLoadingList.GetItemNumber(lRow, "nseparator"))
	
	this.dsPackinglistSizeFind.Retrieve(lIndex, lDetail)
	dsPackinglistSizeTemp.Reset()
	
	For lSizes = 1 to this.dsPackinglistSizeFind.RowCount()
		
		// --------------------------------------------------
		// Alles prima, Stauort ist nur f$$HEX1$$fc00$$ENDHEX$$r ein Leg
		// --------------------------------------------------
		sCode = this.dsPackinglistSizeFind.GetItemString(lSizes, "cmeal_control_code")
		
		if lNextLeg = 0 then
			iMultileg = 0
			this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code", String(lLeg) + sCode)
			this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code2", "")
			this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code3", "")
			this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code4", "")
			this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code5", "")
			this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code6", "")
			this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code7", "")
			this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code8", "")
			this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code9", "")
		else
			// --------------------------------------------------
			// Stauort ist f$$HEX1$$fc00$$ENDHEX$$r 2 Legs
			// --------------------------------------------------
			iMultileg = 1
			if lSeparate = 1 then
				// -----------------------------------------------
				// Es soll die Kapazit$$HEX1$$e400$$ENDHEX$$t gleich verteilt werden
				// -----------------------------------------------
	
				ll_initial_width 				=  this.dsPackinglistSizeFind.GetItemNumber(lSizes, "nwidth")
				lWidth 						= ll_initial_width / len(ls_legs)
				ll_sum_devided_width 	= lWidth * len(ls_legs)

				this.of_log("------------------------------------------------------------------------------------------------------------------------------------------------------------")
				this.of_log(ls_stowage +" is a multileg stowage with reserved space, item list " + spackinglist + " is assigned,  height of " + string(ll_initial_width) + " will be devided by " + string(len(ls_legs)))
					
				if ll_initial_width <> ll_sum_devided_width then
					this.of_log("Rounding issue found!")
					this.of_log("Initial width was " + string(ll_initial_width))
					this.of_log("Sum up after leg splitting is  " + string(ll_sum_devided_width))
				end if 
				
				this.of_log("------------------------------------------------------------------------------------------------------------------------------------------------------------")
	
				this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code", string(ll_catering_legs[1]) + sCode)
				this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code2", "")
				this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code3", "")
				this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code4", "")
				this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code5", "")
				this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code6", "")
				this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code7", "")
				this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code8", "")
				this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code9", "")
				this.dsPackinglistSizeFind.SetItem(lSizes, "nwidth", lWidth)
			//	this.dsPackinglistSizeFind.SetItem(lSizes, "nheight", ll_Height)
							
				for ll_counter = 2 to upperbound(ll_catering_legs)
					
					if ll_catering_legs[ll_counter] = 0 then exit
					
					if this.dsPackinglistSizeFind.RowsCopy(lSizes, lSizes, Primary!, dsPackinglistSizeTemp, dsPackinglistSizeTemp.RowCount() + 1, Primary!) <> 1 then
						this.sError = "Rowscopy to temporarely PL-Size datastore failed (" + string(this.dsPackinglistSizeFind.RowCount()) + " rows)"
						Destroy(dsPackinglistSizeTemp)
						return -1
					else
						dsPackinglistSizeTemp.SetItem(dsPackinglistSizeTemp.RowCount(), "cmeal_control_code", String(ll_catering_legs[ll_counter]) + sCode)
						dsPackinglistSizeTemp.SetItem(dsPackinglistSizeTemp.RowCount(), "cmeal_control_code2", "")
						dsPackinglistSizeTemp.SetItem(dsPackinglistSizeTemp.RowCount(), "cmeal_control_code3", "")
						dsPackinglistSizeTemp.SetItem(dsPackinglistSizeTemp.RowCount(), "cmeal_control_code4", "")
						dsPackinglistSizeTemp.SetItem(dsPackinglistSizeTemp.RowCount(), "cmeal_control_code5", "")
						dsPackinglistSizeTemp.SetItem(dsPackinglistSizeTemp.RowCount(), "cmeal_control_code6", "")
						dsPackinglistSizeTemp.SetItem(dsPackinglistSizeTemp.RowCount(), "cmeal_control_code7", "")
						dsPackinglistSizeTemp.SetItem(dsPackinglistSizeTemp.RowCount(), "cmeal_control_code8", "")
						dsPackinglistSizeTemp.SetItem(dsPackinglistSizeTemp.RowCount(), "cmeal_control_code9", "")
						dsPackinglistSizeTemp.SetItem(dsPackinglistSizeTemp.RowCount(), "nwidth", lWidth)
					end if						
					
				next
			
			else
				
				this.of_log(ls_stowage +" is a multileg stowage,  item list " + spackinglist + " is assigned")
			
				for ll_counter = 1 to Upperbound(ll_catering_legs)
					
					if ll_catering_legs[ll_counter] > 0 then
						ls_temp = String(ll_catering_legs[ll_counter]) + sCode
						this.of_log(ls_stowage +" - " + ls_meal_control_codes[ll_counter] + " will be " + ls_temp )
						this.dsPackinglistSizeFind.SetItem(lSizes, ls_meal_control_codes[ll_counter], ls_temp)
					else
						this.dsPackinglistSizeFind.SetItem(lSizes, ls_meal_control_codes[ll_counter], "")
					end if
					
				next
				
//				this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code", String(lLeg) + sCode)
//				this.dsPackinglistSizeFind.SetItem(lSizes, "cmeal_control_code2", String(lNextLeg) + sCode)
			end if
			
		end if
		
	Next
	
	if dsPackinglistSizeTemp.RowCount() > 0 then
		
		if dsPackinglistSizeTemp.RowsCopy(1, dsPackinglistSizeTemp.RowCount(), Primary!, this.dsPackinglistSizeFind, this.dsPackinglistSizeFind.RowCount() + 1, Primary!) <> 1 then
			this.sError = "Rowscopy to back from temporarely PL-Size datastore failed (" + string(dsPackinglistSizeTemp.RowCount()) + " rows)"
			Destroy(dsPackinglistSizeTemp)
			return -1
		end if
		
	end if
	
	// Wenns Abfertigungsart DLV ist dann einen zurechtschummeln
	
	//if this.dsFlight.GetItemString(1, "chandling_type_text") = "DLV" then
	// 27.01.2016 Abfertigungsart INT wie DLV CBASE-BRU-CR-2015-014
	if this.dsFlight.GetItemString(1, "chandling_type_text") = "DLV" OR this.dsFlight.GetItemString(1, "chandling_type_text") = "INT" then
		a = this.dsPackinglistSizeFind.InsertRow(0)
	end if
	
	// ----------------------------------------------------------
	// F$$HEX1$$fc00$$ENDHEX$$r jeden Stauort, der H$$HEX1$$f600$$ENDHEX$$hen und Tiefen hat
	// ein UserObject erzeugen
	// ----------------------------------------------------------
	if this.dsPackinglistSizeFind.RowCount() > 0 then
		if lSeparate = 1 then
			lb_Breakpoint=TRUE	
		end if
		this.dsLoadingList.SetItem(lRow, "ndistribution_detail_key", lRow)
		lCount = UpperBound(uoStowages) + 1
		this.uoStowages[lCount] = create uo_distribution_container
		this.uoStowages[lCount].lLoadRow 		= lRow
		this.uoStowages[lCount].sPackinglist 	= this.dsLoadingList.GetItemString(lRow, "cen_packinglist_index_cpackinglist")
		this.uoStowages[lCount].sClass1		 	= of_checknull(this.dsLoadingList.GetItemString(lRow, "cclass1"))
		this.uoStowages[lCount].sClass2		 	= of_checknull(this.dsLoadingList.GetItemString(lRow, "cclass2"))
		this.uoStowages[lCount].sClass3		 	= of_checknull(this.dsLoadingList.GetItemString(lRow, "cclass3"))

		this.uoStowages[lCount].sClass4		 	= of_checknull(this.dsLoadingList.GetItemString(lRow, "cclass4"))
		this.uoStowages[lCount].sClass5		 	= of_checknull(this.dsLoadingList.GetItemString(lRow, "cclass5"))
		this.uoStowages[lCount].sClass6		 	= of_checknull(this.dsLoadingList.GetItemString(lRow, "cclass6"))

		this.uoStowages[lCount].sStowage	 		= this.dsLoadingList.GetItemString(lRow, "cen_galley_cgalley") + "-" + dsLoadingList.GetItemString(lRow, "cen_stowage_cstowage") + " " + dsLoadingList.GetItemString(lRow, "cen_stowage_cplace")
		this.uoStowages[lCount].sUnit		 		= this.dsLoadingList.GetItemString(lRow, "cen_packinglists_cunit") 
		this.uoStowages[lCount].sText1	 		= this.dsLoadingList.GetItemString(lRow, "cen_loadinglists_cadd_on_text")
		this.uoStowages[lCount].sText2	 		= this.dsLoadingList.GetItemString(lRow, "cen_packinglists_ctext") 
		this.uoStowages[lCount].sText3	 		= "" 
		this.uoStowages[lCount].sWorkstation	= this.dsLoadingList.GetItemString(lRow, "carea_code")  
		this.uoStowages[lCount].lRanking	 		= this.dsLoadingList.GetItemNumber(lRow, "nranking") 
		this.uoStowages[lCount].lRankingSPML	= this.dsLoadingList.GetItemNumber(lRow, "nranking_spml") 
		this.uoStowages[lCount].lLabelTypeKey	= this.dsLoadingList.GetItemNumber(lRow, "cen_packinglists_nlabel_type_key") 
		this.uoStowages[lCount].lSeparate		= lSeparate
		this.uoStowages[lCount].iMultiLeg		= iMultiLeg
		this.uoStowages[lCount].ii_catering_legs		= this.dsLoadingList.GetItemNumber(lRow, "compute_leg")
		this.uoStowages[lCount].lLimit = this.dsLoadingList.GetItemNumber(lRow, "nlimit")
		if isnull(this.uoStowages[lCount].lLimit) then this.uoStowages[lCount].lLimit = 0
		
		this.uoStowages[lCount].lLimitSPML = this.dsLoadingList.GetItemNumber(lRow, "nlimit_spml")
		if isnull(this.uoStowages[lCount].lLimitSPML) then this.uoStowages[lCount].lLimitSPML = 0
		
		this.uoStowages[lCount].lGalleyKey		= this.dsLoadingList.GetItemNumber(lRow, "cen_galley_ngalley_key") 
		this.uoStowages[lCount].lStowageKey		= this.dsLoadingList.GetItemNumber(lRow, "cen_stowage_nstowage_key") 
		this.uoStowages[lCount].lStowageSort	= this.dsLoadingList.GetItemNumber(lRow, "cen_stowage_nsort") 
		this.uoStowages[lCount].lBelly			= this.dsLoadingList.GetItemNumber(lRow, "cen_loadinglists_nbelly_container") 
		
		// --------------------------------------------------------
		// Nach Stauortgruppenzugeh$$HEX1$$f600$$ENDHEX$$rigkeit suchen
		// --------------------------------------------------------
		
		lFoundStowage = this.dsStowageGroups.Find("ngalley_key= " + String(this.uoStowages[lCount].lGalleyKey) + " and nstowage_key=" + String(this.uoStowages[lCount].lStowageKey), 1, this.dsStowageGroups.RowCount())
		
		if lFoundStowage > 0 then
			sStowageGroup = this.dsStowageGroups.GetItemString(lFoundStowage, "ctext")
			this.of_log("[" + this.uoStowages[lCount].sStowage	+ "] is assigned to stowage group [" + sStowageGroup + "]")
			this.uoStowages[lCount].sStowageGroup = sStowageGroup
		else
			this.uoStowages[lCount].sStowageGroup = "-1"
		end if
				
		this.uoStowages[lCount].iMCD				= 0
		this.uoStowages[lCount].iMixed			= this.iMixed
		
		lFound = this.dsDistributingMeals.Find("cen_galley_ngalley_key=" + string(this.uoStowages[lCount].lGalleyKey), 1, this.dsDistributingMeals.RowCount())

		if lFound > 0 then
			//this.uoStowages[lCount].lDistributionMealKey = 	this.dsDistributingMeals.GetItemNumber(lFound, "ndistribution_key")
			ll_Temp_key = this.dsDistributingMeals.GetItemNumber(lFound, "ndistribution_key")
			// #####################
			//this.uoStowages[lCount].lDistributionMealKey = f_get_valid_distribution_key(this.uoStowages[lCount].lDistributionAddKey, date(dtdeparture)  )
			ll_Temp_key = f_get_valid_distribution_key(ll_Temp_key, date(dtdeparture)  )
			
			this.uoStowages[lCount].lDistributionMealKey = ll_Temp_key
		else
			this.uoStowages[lCount].lDistributionMealKey = 0
			
//			this.sError = "No distribution parameter for meal loading found !"
//			Destroy(dsPackinglistSizeTemp)
//			return -1
		end if
		if lSeparate = 1 then
			lb_Breakpoint=TRUE	
		end if
		lFound = this.dsDistributingAdditional.Find("cen_galley_ngalley_key=" + string(this.uoStowages[lCount].lGalleyKey), 1, this.dsDistributingAdditional.RowCount())

		if lFound > 0 then
			//this.uoStowages[lCount].lDistributionAddKey = 	this.dsDistributingAdditional.GetItemNumber(lFound, "ndistribution_key")
			// ####################################
			ll_Temp_key = this.dsDistributingAdditional.GetItemNumber(lFound, "ndistribution_key")
			// #####################
			//this.uoStowages[lCount].lDistributionMealKey = f_get_valid_distribution_key(this.uoStowages[lCount].lDistributionAddKey, date(dtdeparture)  )
			ll_Temp_key = f_get_valid_distribution_key(ll_Temp_key, date(dtdeparture)  )
			
			this.uoStowages[lCount].lDistributionAddKey = ll_Temp_key
			
			
			//this.uoStowages[lCount].lDistributionAddKey = f_get_valid_distribution_key(this.uoStowages[lCount].lDistributionAddKey, date(dtdeparture)  )
			
		else
			
			ll_Temp_key = 	this.uoStowages[lCount].lDistributionMealKey
			ll_Temp_key = f_get_valid_distribution_key(ll_Temp_key, date(dtdeparture)  )
			this.uoStowages[lCount].lDistributionAddKey = ll_Temp_key
			
		end if
		
		if lSeparate = 1 then
			lb_Breakpoint=TRUE	
		end if
		
		if this.dsPackinglistSizeFind.Rowscopy(1, this.dsPackinglistSizeFind.RowCount(), Primary!, &
		   this.uoStowages[lCount].dsPackinglistSize, this.uoStowages[lCount].dsPackinglistSize.RowCount() + 1, & 
			Primary!) <> 1 then
			
			this.sError = "of_get_dimension: RowsCopy failed!"
			Destroy(dsPackinglistSizeTemp)
			return -1
			
		end if
		
		this.uoStowages[lCount].of_init()
		
		if this.uoStowages[lCount].dsPackinglistSize.RowCount() > 0 then
			this.dsLoadingList.SetItem(lRow, "cen_loadinglists_cmeal_control_code", this.uoStowages[lCount].dsPackinglistSize.GetItemString(1, "cmeal_control_code"))
					
		else
			this.dsLoadingList.SetItem(lRow, "cen_loadinglists_cmeal_control_code", "")
		end if
		
		
	else
		this.dsLoadingList.SetItem(lRow, "cen_loadinglists_cmeal_control_code", "")
		this.dsLoadingList.SetItem(lRow, "ndistribution_detail_key", -1)
	end if
		
next

lEndePart = CPU()
this.of_log("Creating StowageObjects took " + string((lEndePart - lStartPart) / 1000, "0.00") + " seconds.")

lStartPart = CPU()

// --------------------------------------------------------
// Default Verteilertyp suchen (SL)
// --------------------------------------------------------
lFound = dsPackinglistTypes.Find("npltype_key=0", 1, dsPackinglistTypes.RowCount())

if lFound > 0 then
	sDefault = dsPackinglistTypes.GetItemString(lFound, "ctext")
else
	sDefault = "N/A"
end if

// --------------------------------------------------------------
//
// Jetzt die H$$HEX1$$f600$$ENDHEX$$hen und Tiefen f$$HEX1$$fc00$$ENDHEX$$r die Mahlzeiten ermitteln
//
// --------------------------------------------------------------

for lRow = 1 to this.dsMeals.RowCount()

	// if isnull(this.dsMeals.GetItemNumber(lRow, "npltype_key")) then this.dsMeals.SetItem(lRow, "npltype_key", 0)
	// if isnull(this.dsMeals.GetItemString(lRow, "sys_packinglist_types_ctext")) then this.dsMeals.SetItem(lRow, "sys_packinglist_types_ctext", " ")

	//if not isnull(this.dsMeals.GetItemNumber(lRow, "cen_packinglist_size_nquantity")) then
	if not isnull(this.dsMeals.GetItemNumber(lRow, "npltype_key")) then
		
		lQuantity = this.dsMeals.GetItemNumber(lRow, "cen_packinglist_size_nquantity") 
		lComponentQuantity = this.dsMeals.GetItemNumber(lRow, "nquantity")
		this.dsMeals.SetItem(lRow, "nquantity", lQuantity * lComponentQuantity) 
		
	else
		
		this.dsMeals.SetItem(lRow, "nheight", 9999) 
		this.dsMeals.SetItem(lRow, "nwidth", 9999) 
		
		this.dsMeals.SetItem(lRow, "sys_packinglist_types_ctext", sDefault)
		this.dsMeals.SetItem(lRow, "npltype_key", 0)		
		
		of_log(sPackinglist + "- ErrorCode:" + string(sqlca.sqlcode) + " Errormessage: " + string(sqlca.sqlcode))
		
	end if

Next

lEndePart = CPU()
this.of_log("Adding height and depth to Meals took " + string((lEndePart - lStartPart) / 1000, "0.00") + " seconds.")

lStartPart = CPU()
// --------------------------------------------------------------
//
// Die Extrabeladung nicht vergessen !!!
//
// --------------------------------------------------------------
for lRow = 1 to this.dsAdditional.RowCount()


	if isnull(this.dsAdditional.GetItemNumber(lRow, "npltype_key")) then this.dsAdditional.SetItem(lRow, "npltype_key", 1)
	if isnull(this.dsAdditional.GetItemString(lRow, "sys_packinglist_types_ctext")) then this.dsAdditional.SetItem(lRow, "sys_packinglist_types_ctext", " ")

	if not isnull(this.dsAdditional.GetItemNumber(lRow, "cen_packinglist_size_nquantity")) then

		lQuantity 				= this.dsAdditional.GetItemNumber(lRow, "cen_packinglist_size_nquantity") 
		lComponentQuantity 	= this.dsAdditional.GetItemNumber(lRow, "nquantity")
		this.dsAdditional.SetItem(lRow, "nquantity", lQuantity * lComponentQuantity) 
		
	else
		
		this.dsAdditional.SetItem(lRow, "nheight", 9999) 
		this.dsAdditional.SetItem(lRow, "nwidth", 9999) 
		
		this.dsAdditional.SetItem(lRow, "sys_packinglist_types_ctext", sDefault) 
		this.dsAdditional.SetItem(lRow, "npltype_key", 0) 
		
		of_log(sPackinglist + "- ErrorCode:" + string(sqlca.sqlcode) + " Errormessage: " + string(sqlca.sqlcode))
		
	end if

Next

lEndePart = CPU()
this.of_log("Adding height and depth to Additional Loading took " + string((lEndePart - lStartPart) / 1000, "0.00") + " seconds.")

lStartPart = CPU()

// --------------------------------------------------------------
//
// Die SPML's haben nat$$HEX1$$fc00$$ENDHEX$$rlich auch H$$HEX1$$f600$$ENDHEX$$hen und Tiefen !!!
//
// --------------------------------------------------------------
for lRow = 1 to this.dsSPMLDistribution.RowCount()

	sPackingList = this.dsSPMLDistribution.GetItemString(lRow, "cpackinglist")
	
	// ----------------------------------------------------------
	// Nachschaun, ob H$$HEX1$$f600$$ENDHEX$$hen und Tiefen definiert sind
	// ----------------------------------------------------------
	lIndex  = this.dsSPMLDistribution.GetItemNumber(lRow, "npackinglist_index_key")
		
	select npackinglist_detail_key 
	  into :lDetail
	  from cen_packinglists 
	 where npackinglist_index_key = :lIndex and 
   	    dvalid_from <= :this.dtDeparture and  
			 dvalid_to >= :this.dtDeparture;
	
	if sqlca.sqlcode = 0 then
	
		if lSeparate = 1 then
			lb_Breakpoint=TRUE	
		end if
	
		this.dsPackinglistSizeFind.Retrieve(lIndex, lDetail)
	
		If this.dsPackinglistSizeFind.RowCount() > 0 then
			lQuantity = dsPackinglistSizeFind.GetItemNumber(1, "nquantity") 
			
			this.dsSPMLDistribution.SetItem(lRow, "nheight", this.dsPackinglistSizeFind.GetItemNumber(1, "nheight")) 
			this.dsSPMLDistribution.SetItem(lRow, "nwidth", this.dsPackinglistSizeFind.GetItemNumber(1, "nwidth")) 
			this.dsSPMLDistribution.SetItem(lRow, "sys_packinglist_types_ctext", this.dsPackinglistSizeFind.GetItemString(1, "ctext")) 
			this.dsSPMLDistribution.SetItem(lRow, "npltype_key", this.dsPackinglistSizeFind.GetItemNumber(1, "npltype_key")) 
			
			lComponentQuantity = this.dsSPMLDistribution.GetItemNumber(lRow, "nquantity")
			this.dsSPMLDistribution.SetItem(lRow, "nquantity", lQuantity * lComponentQuantity) 
			
		End if
		
	else
		
		this.dsSPMLDistribution.SetItem(lRow, "nheight", 9999) 
		this.dsSPMLDistribution.SetItem(lRow, "nwidth", 9999) 
	
		this.dsSPMLDistribution.SetItem(lRow, "sys_packinglist_types_ctext", sDefault) 
		this.dsSPMLDistribution.SetItem(lRow, "npltype_key", 0) 
		
		of_log(sPackinglist + "- ErrorCode:" + string(sqlca.sqlcode) + " Errormessage: " + string(sqlca.sqlcode))
		
	end if

Next


lEndePart = CPU()
this.of_log("Adding height and depth to SPML's took " + string((lEndePart - lStartPart) / 1000, "0.00") + " seconds.")
this.dsMeals.Sort()
this.dsAdditional.Sort()
this.dsSPMLDistribution.Sort()

lEnde = CPU()
this.of_log("of_get_dimensions() took " + string((lEnde - lStart) / 1000, "0.00") + " seconds.")
Destroy(dsPackinglistSizeTemp)
return 0

end function

public function integer of_mcd_complete ();// -----------------------------------------------
// 
// Die gel$$HEX1$$f600$$ENDHEX$$schten Klassen, jetzt anhand der 
// zugestauten Komponenten neu bestimmen
// 
// -----------------------------------------------
Long 		lStowages, &
			lFound, &
			lRows

String	sClass, &
			sClassMCD, &
			sClassNew, &
			sClass1, &
			sClass2, &
			sClass3, &
			sClass4, &
			sClass5, &
			sClass6

if this.iMCD = 0 then 
	
	for lRows = 1 to this.dsLoadingList.RowCount()
		
		sClass1 = trim(this.of_checknull(this.dsLoadingList.GetItemString(lRows, "cclass1")))
		sClass2 = trim(this.of_checknull(this.dsLoadingList.GetItemString(lRows, "cclass2")))
		sClass3 = trim(this.of_checknull(this.dsLoadingList.GetItemString(lRows, "cclass3")))

		sClass4 = trim(this.of_checknull(this.dsLoadingList.GetItemString(lRows, "cclass4")))
		sClass5 = trim(this.of_checknull(this.dsLoadingList.GetItemString(lRows, "cclass5")))
		sClass6 = trim(this.of_checknull(this.dsLoadingList.GetItemString(lRows, "cclass6")))

		sClass = sClass1
		if sClass2 <> "" then sClass += "/" + sClass2
		if sClass3 <> "" then sClass += "/" + sClass3

		if sClass4 <> "" then sClass += "/" + sClass4
		if sClass5 <> "" then sClass += "/" + sClass5
		if sClass6 <> "" then sClass += "/" + sClass6
		
		this.dsLoadingList.SetItem(lRows, "cen_loadinglists_cclass", sClass)
		
	next
	
	return 0
	
end if

// -------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r alle Stauorte die beackert wurden.......
// -------------------------------------------------------
for lStowages = 1 to Upperbound(this.uoStowages)
	
	if this.uoStowages[lStowages].dsContent.RowCount() <= 0 then continue
	
	
	// ----------------------------------------------------
	// Sortieren
	// ----------------------------------------------------
	this.uoStowages[lStowages].dsContent.Sort()

	// ----------------------------------------------------
	// Die Stauorte im Array f$$HEX1$$fc00$$ENDHEX$$hren eine Nummer
	// mit sich die auf die Zeile im DataStore
	// referenzieren. $$HEX1$$dc00$$ENDHEX$$ber diese Nummer wird der
	// Datensatz gesucht und ggf. die Klassenbezeichnung
	// neu eingetragen
	// ----------------------------------------------------
	lFound = this.dsLoadingList.Find("ndistribution_detail_key=" + String(this.uoStowages[lStowages].lLoadRow), 1, this.dsLoadingList.RowCount())
	
	if lFound > 0 then
		
		for lRows = 1 to this.uoStowages[lStowages].dsContent.RowCount()
			
			sClass 		= trim(f_check_null(this.dsLoadingList.GetItemString(lFound, "cen_loadinglists_cclass")))
			sClassMCD 	= f_check_null(this.uoStowages[lStowages].dsContent.GetItemString(lRows, "cclass"))
			
			if Pos(sClass, sClassMCD) = 0 then
				
				if sClass = "" then
					sClassNew = sClassMCD
				else
					sClassNew = sClass +  "/" + sClassMCD
				end if
				
				this.dsLoadingList.SetItem(lFound, "cen_loadinglists_cclass", sClassNew) 
			end if
			
		next
		
		this.uoStowages[lStowages].sClass1 = f_check_null(this.dsLoadingList.GetItemString(lFound, "cen_loadinglists_cclass"))

	else
		
		this.of_log("Foreign record in dsLoadingList not found for stowage " + this.uoStowages[lStowages].sStowage)
		
	end if
		
next

return 0
end function

public function uo_distribution of_clone ();// ---------------------------------------------------------------------------------
// 
// Die Funktion erstellt eine Kopie des UserObjects
// 
// ---------------------------------------------------------------------------------
uo_distribution 	uoClone
Long 					I
String 				sFilter
Long					ll_Count

f_trace("uo_distribution.of_clone START")

f_trace("uo_distribution.of_clone BEFORE uoClone = create uo_distribution")

uoClone = create uo_distribution

uoClone.lResultKey 						= this.lResultKey
uoClone.iMCD 								= this.iMCD
uoClone.iMixed								= this.iMixed
uoClone.iAccumulateSPML				= this.iAccumulateSPML
uoClone.iAccumulateSPMLType			= this.iAccumulateSPMLType
uoClone.iExplodeSPML					= this.iExplodeSPML
uoClone.iAddLabelOption					= this.iAddLabelOption
uoClone.iWebService						= this.iWebService
uoClone.uoPDF								= this.uoPDF
uoClone.sError								= this.sError
uoClone.sLogPath							= this.sLogPath
uoClone.iTrace								= this.iTrace
uoClone.lAircraftKey						= this.lAircraftKey
uoClone.lAirlineKey						= this.lAirlineKey
uoClone.lBelly								= this.lBelly
uoClone.dtDeparture						= this.dtDeparture
uoClone.bLocationSheet					= this.bLocationSheet
uoClone.bManuelDistribution			= this.bManuelDistribution
uoClone.bManuelDistributionOnError	= this.bManuelDistributionOnError
uoClone.bCheckSheet						= this.bCheckSheet
uoClone.bSPMLSummary						= this.bSPMLSummary
uoClone.sHandlingString					= this.sHandlingString
uoClone.sViewUnit							= this.sViewUnit
uoClone.sStowageGroups					= this.sStowageGroups

//this.dsSPMLDistribution.RowsCopy(1, this.dsSPMLDistribution.RowCount(), Primary!, this.dsSPMLDistributionMaster, 1, Primary!)
	
f_trace("uo_distribution.of_clone BEFORE DS SetFilter")

this.dsFlight.SetFilter("")	
this.dsFlight.Filter()
this.dsFlight.RowsCopy(1, this.dsFlight.RowCount(), Primary!, uoClone.dsFlight, 1, Primary!)

this.dsLoadinglist.SetFilter("")	
this.dsLoadinglist.Filter()
this.dsLoadinglist.RowsCopy(1, this.dsLoadinglist.RowCount(), Primary!, uoClone.dsLoadinglist, 1, Primary!)

this.dsDistribution.SetFilter("")	
this.dsDistribution.Filter()
this.dsDistribution.RowsCopy(1, this.dsDistribution.RowCount(), Primary!, uoClone.dsDistribution, 1, Primary!)

this.dsMeals.SetFilter("")	
this.dsMeals.Filter()
this.dsMeals.RowsCopy(1, this.dsMeals.RowCount(), Primary!, uoClone.dsMeals, 1, Primary!)

this.dsAdditional.SetFilter("")	
this.dsAdditional.Filter()
this.dsAdditional.RowsCopy(1, this.dsAdditional.RowCount(), Primary!, uoClone.dsAdditional, 1, Primary!)

this.dsSPMLDistribution.SetFilter("")	
this.dsSPMLDistribution.Filter()
this.dsSPMLDistribution.RowsCopy(1, this.dsSPMLDistribution.RowCount(), Primary!, uoClone.dsSPMLDistribution, 1, Primary!)

this.dsSPMLDistributionMaster.SetFilter("")	
this.dsSPMLDistributionMaster.Filter()
this.dsSPMLDistributionMaster.RowsCopy(1, this.dsSPMLDistributionMaster.RowCount(), Primary!, uoClone.dsSPMLDistributionMaster, 1, Primary!)

this.dsAdditionalDistribution.SetFilter("")	
this.dsAdditionalDistribution.Filter()
this.dsAdditionalDistribution.RowsCopy(1, this.dsAdditionalDistribution.RowCount(), Primary!, uoClone.dsAdditionalDistribution, 1, Primary!)


this.dsSPML.SetFilter("")	
this.dsSPML.Filter()
this.dsSPML.RowsCopy(1, this.dsSPML.RowCount(), Primary!, uoClone.dsSPML, 1, Primary!)

this.dsDistributingMeals.SetFilter("")	
this.dsDistributingMeals.Filter()
this.dsDistributingMeals.RowsCopy(1, this.dsDistributingMeals.RowCount(), Primary!, uoClone.dsDistributingMeals, 1, Primary!)

this.dsDistributingAdditional.SetFilter("")	
this.dsDistributingAdditional.Filter()
this.dsDistributingAdditional.RowsCopy(1, this.dsDistributingAdditional.RowCount(), Primary!, uoClone.dsDistributingAdditional, 1, Primary!)

this.dsControl.SetFilter("")	
this.dsControl.Filter()
this.dsControl.RowsCopy(1, this.dsControl.RowCount(), Primary!, uoClone.dsControl, 1, Primary!)

this.dsDistributionErrors.SetFilter("")	
this.dsDistributionErrors.Filter()
this.dsDistributionErrors.RowsCopy(1, this.dsDistributionErrors.RowCount(), Primary!, uoClone.dsDistributionErrors, 1, Primary!)

this.dsStowageGroups.SetFilter("")	
this.dsStowageGroups.Filter()
this.dsStowageGroups.RowsCopy(1, this.dsStowageGroups.RowCount(), Primary!, uoClone.dsStowageGroups, 1, Primary!)

this.dsStowageGroupValues.SetFilter("")	
this.dsStowageGroupValues.Filter()
this.dsStowageGroupValues.RowsCopy(1, this.dsStowageGroupValues.RowCount(), Primary!, uoClone.dsStowageGroupValues, 1, Primary!)


this.dsFlight.RowsCopy(1, this.dsFlight.RowCount(), Primary!, uoClone.dsFlight, 1, Primary!)
this.dsAircraft.RowsCopy(1, this.dsAircraft.RowCount(), Primary!, uoClone.dsAircraft, 1, Primary!)
this.dsPackinglistSizes.RowsCopy(1, this.dsPackinglistSizes.RowCount(), Primary!, uoClone.dsPackinglistSizes, 1, Primary!)
this.dsPackinglistSizeFind.RowsCopy(1, this.dsPackinglistSizeFind.RowCount(), Primary!, uoClone.dsPackinglistSizeFind, 1, Primary!)
this.dsPackinglistTypes.RowsCopy(1, this.dsPackinglistTypes.RowCount(), Primary!, uoClone.dsPackinglistTypes, 1, Primary!)
this.dsLabelObjects.RowsCopy(1, this.dsLabelObjects.RowCount(), Primary!, uoClone.dsLabelObjects, 1, Primary!)
this.dsClasses.RowsCopy(1, this.dsClasses.RowCount(), Primary!, uoClone.dsClasses, 1, Primary!)
this.dsDistributionParameter.RowsCopy(1, this.dsDistributionParameter.RowCount(), Primary!, uoClone.dsDistributionParameter, 1, Primary!)
this.dsDistributionPriority.RowsCopy(1, this.dsDistributionPriority.RowCount(), Primary!, uoClone.dsDistributionPriority, 1, Primary!)
this.dsCheckSheet.RowsCopy(1, this.dsCheckSheet.RowCount(), Primary!, uoClone.dsCheckSheet, 1, Primary!)
this.dsLeg.RowsCopy(1, this.dsLeg.RowCount(), Primary!, uoClone.dsLeg, 1, Primary!)
this.dsSPMLSummary.RowsCopy(1, this.dsSPMLSummary.RowCount(), Primary!, uoClone.dsSPMLSummary, 1, Primary!)

f_trace("uo_distribution.of_clone AFTER DS ROWSCOPY")

ll_Count = UpperBound(this.uoStowages)
f_trace("uo_distribution.of_clone UpperBound(this.uoStowages " + String(ll_Count))

// ---------------------------------------------------------
// Die Stauorte
// ---------------------------------------------------------
for i = 1 to UpperBound(this.uoStowages)
	f_trace("uo_distribution.of_clone LOOP Stowages " + String(i) + " / " + String(ll_Count))

	
	uoClone.uoStowages[i] = create uo_distribution_container
	
	uoClone.uoStowages[i].lLoadRow 			= this.uoStowages[i].lLoadRow
	uoClone.uoStowages[i].sClass1				= this.uoStowages[i].sClass1
	uoClone.uoStowages[i].sClass2				= this.uoStowages[i].sClass2
	uoClone.uoStowages[i].sClass3				= this.uoStowages[i].sClass3
	uoClone.uoStowages[i].sClass4				= this.uoStowages[i].sClass4
	uoClone.uoStowages[i].sClass5				= this.uoStowages[i].sClass5
	uoClone.uoStowages[i].sClass6				= this.uoStowages[i].sClass6
	uoClone.uoStowages[i].sUnit				= this.uoStowages[i].sUnit
	uoClone.uoStowages[i].sPackinglist		= this.uoStowages[i].sPackinglist
	uoClone.uoStowages[i].sStowage			= this.uoStowages[i].sStowage
	uoClone.uoStowages[i].sText1				= this.uoStowages[i].sText1
	uoClone.uoStowages[i].sText2				= this.uoStowages[i].sText2
	uoClone.uoStowages[i].sText3				= this.uoStowages[i].sText3	
	uoClone.uoStowages[i].sError				= this.uoStowages[i].sError
	uoClone.uoStowages[i].lRanking			= this.uoStowages[i].lRanking	
	uoClone.uoStowages[i].lRankingSPML		= this.uoStowages[i].lRankingSPML	
	uoClone.uoStowages[i].lLimit				= this.uoStowages[i].lLimit
	uoClone.uoStowages[i].lLimitSPML			= this.uoStowages[i].lLimitSPML	
	uoClone.uoStowages[i].sWorkstation		= this.uoStowages[i].sWorkstation	
	uoClone.uoStowages[i].lLabelTypeKey		= this.uoStowages[i].lLabelTypeKey
	uoClone.uoStowages[i].iMultileg			= this.uoStowages[i].iMultileg
	uoClone.uoStowages[i].lSeparate			= this.uoStowages[i].lSeparate
	uoClone.uoStowages[i].iMultiLeg			= this.uoStowages[i].iMultiLeg
	uoClone.uoStowages[i].ii_catering_legs			= this.uoStowages[i].ii_catering_legs
	
	uoClone.uoStowages[i].sStowageGroup		= this.uoStowages[i].sStowageGroup
		
	uoClone.uoStowages[i].lDistributionMealKey	= this.uoStowages[i].lDistributionMealKey
	uoClone.uoStowages[i].lDistributionAddKey		= this.uoStowages[i].lDistributionAddKey
	uoClone.uoStowages[i].lGalleyKey					= this.uoStowages[i].lGalleyKey
	uoClone.uoStowages[i].lStowageKey				= this.uoStowages[i].lStowageKey
	
	uoClone.uoStowages[i].lDistributionGroup		= this.uoStowages[i].lDistributionGroup
	uoClone.uoStowages[i].lBelly						= this.uoStowages[i].lBelly
		
	uoClone.uoStowages[i].iClassNumber				= this.uoStowages[i].iClassNumber
	uoClone.uoStowages[i].iUse							= this.uoStowages[i].iUse
	uoClone.uoStowages[i].iMCD							= this.uoStowages[i].iMCD
	uoClone.uoStowages[i].iMixed						= this.uoStowages[i].iMixed
	uoClone.uoStowages[i].iMultiClass				= this.uoStowages[i].iMultiClass
	
	f_trace("uo_distribution.of_clone LOOP Stowages BEFORE dsPackinglistSize.RowsCopy " + String(i))

	this.uoStowages[i].dsPackinglistSize.RowsCopy(1, this.uoStowages[i].dsPackinglistSize.RowCount(), Primary!, uoClone.uoStowages[i].dsPackinglistSize, 1, Primary!)

	f_trace("uo_distribution.of_clone LOOP Stowages BEFORE dsContent.RowsCopy " + String(i))

	this.uoStowages[i].dsContent.RowsCopy(1, this.uoStowages[i].dsContent.RowCount(), Primary!, uoClone.uoStowages[i].dsContent, 1, Primary!)
	

	if this.uoStowages[i].sStowage = "G5A-521 *2" then
		i=i
	end if
	


next

f_trace("uo_distribution.of_clone END ")

return uoClone
end function

public function integer of_run ();
// -----------------------------------------------------------------------------------------------------------------------------------------
// Objekt : uo_distribution
// Methode: of_run (Function)
// Autor  :
// -----------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// -----------------------------------------------------------------------------------------------------------------------------------------
// Return: integer
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung: 	Einstiegsfunktion f$$HEX1$$fc00$$ENDHEX$$r die Mahlzeitenverteilung
//						oder
//						hier ist der Anfang vom Ende
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version		Autor              			     Kommentar
// -----------------------------------------------------------------------------------------------------------------------------------------
//  ??.??.????	1.00			???
//  28.06.2012	1.00			Thomas Brackmann		Einbau Aufruf of_restore_distribution() 
// -----------------------------------------------------------------------------------------------------------------------------------------

Long I, lKey
Long lStart, lEnde,lfound
string ssearch,s_airline
s_distribution_manual strReturn

// ---------------------------------------------------------------
// Die "Kopfinformationen" retrieven
// ---------------------------------------------------------------
lStart = CPU()

this.dsFlight.Retrieve(this.lResultKey)

if this.dsFlight.RowCount() = 0 then
	this.sError = "No flight information found!"
	return -1
else
	// Ggf. Mahlzeitenverteilung aus Sicherung holen ...
	IF of_restore_distribution() THEN
		lEnde = CPU()
		
		//MB 04.03.2013: Duplizierung noch machen, sonst funktioniert die Labelerstellung nicht richtig
		this.dtDeparture  	= this.dsFlight.GetItemDateTime(1, "ddeparture")
		this.of_add_text_to_label()
		
		of_log("Distribution took " + string((lEnde - lStart)/1000, "0.00") + " seconds!")
		RETURN 0
	ELSE

		this.lAircraftKey 	= this.dsFlight.GetItemNumber(1, "naircraft_key")
		this.lAirlineKey		= this.dsFlight.GetItemNumber(1, "ncustomer_key")
		this.dtDeparture  	= this.dsFlight.GetItemDateTime(1, "ddeparture")
		this.sViewUnit			= this.dsFlight.GetItemString(1, "cunit")
		this.lGroupKey			= this.dsFlight.GetItemNumber(1, "nresult_key_group")
		//-----------------------------------------------
		//16.06.2010 M.Barfknecht
		//iAccumulateSPML und iExplodeSPML an dieser Stelle Airlinespezifisch setzen, falls es eine Airlinespezifische Abweichung gibt
		//-------------------------------------------------
		dsAirlineInfo = create datastore
		dsAirlineInfo.dataobject = "dw_print_spml_airlines"
		dsAirlineInfo.Settransobject(SQLCA)
		dsAirlineInfo.retrieve(this.sViewUnit)
		
		Select cairline into :s_airline
		from cen_airlines
		where nairline_key = :lAirlineKey;
	
		ssearch = "cf_airline = '" + s_airline +"'"
		lfound = dsAirlineInfo.find(ssearch,1,dsAirlineInfo.rowcount())
		if lfound > 0 then
			this.iAccumulateSPML	 		= integer(dsAirlineInfo.getitemstring(lfound,"cf_accum_spmls"))
			this.iExplodeSPML				= integer(dsAirlineInfo.getitemstring(lfound,"cf_explode_spml"))
			this.iAccumulateSPMLType 	= integer(dsAirlineInfo.getitemstring(lfound,"cf_accum_spmls_type")) // 24.04.2013 HR: CBASE-AKL-CR-2013-003
			this.of_get_handling(this.lResultKey)
		
		else

			this.iAccumulateSPML			= Integer(f_unitprofilestring("Default","ACCUM_SPMLS","0", this.sViewUnit))
			this.iExplodeSPML				= Integer(f_unitprofilestring("Default","EXPLODE_SPML","1", this.sViewUnit))
			this.iAccumulateSPMLType 	= integer(f_unitprofilestring("Default","ACCUM_SPMLS_TYPE","0", this.sViewUnit)) // 24.04.2013 HR: CBASE-AKL-CR-2013-003
			this.of_get_handling(this.lResultKey)
		end if
		//MB 15.05.2013: destroy erg$$HEX1$$e400$$ENDHEX$$nzt
		destroy dsAirlineInfo	
	END IF				

end if

//for i = 1 to UpperBound(lResultKeys)
//	messagebox("", lResultKeys[i])
//next

// ---------------------------------------------------------------
// Labeltypen, die Mahlzeiten darstellen k$$HEX1$$f600$$ENDHEX$$nnen
// ---------------------------------------------------------------
this.dsLabelTypes.Retrieve(this.dtDeparture)

// ---------------------------------------------------------------
// Die Klassen der Airline retrieven
// ---------------------------------------------------------------
this.dsClasses.Retrieve(this.lAirlineKey)

if this.dsClasses.RowCount() = 0 then
	this.sError = "No classnames defined!"
	return -1
end if

// ---------------------------------------------------------------
// Die St$$HEX1$$fc00$$ENDHEX$$cklistentypen retrieven
// ---------------------------------------------------------------
this.dsPackinglistTypes.Retrieve()

if dsPackinglistTypes.RowCount() = 0 then
	this.sError = "No packinglist types defined!"
	return -1
end if

// ---------------------------------------------------------------
// Stauortzuordnungen retrieven
// ---------------------------------------------------------------
this.dsStowageGroups.Retrieve(this.lAircraftKey)
this.of_log("Found [" + string(this.dsStowageGroups.RowCount()) + "] stowage group assignments for AircraftKey: " + String(this.lAircraftKey))

// ---------------------------------------------------------------
// Die Meals/Extrabeladung retrieven
// 1 = Meals
// 2 = Extrabeladung
// ---------------------------------------------------------------
this.of_load_components(1)
this.of_load_components(2)
//f_print_datastore(this.dsMeals)

// ---------------------------------------------------------------
// Die Legs retrieven
// ---------------------------------------------------------------
this.dsLeg.Retrieve(this.lResultKeys)
// f_print_datastore(this.dsLeg)
// ---------------------------------------------------------------
// Die SPML's retrieven
// ---------------------------------------------------------------
this.dsSPML.Retrieve(this.lResultKeys)
this.of_move_spmls()


//f_print_datastore(dsSPMLDistribution)
//f_print_datastore(dsSPML)

// ---------------------------------------------------------------
// Gibts denn $$HEX1$$fc00$$ENDHEX$$berhaupt was zu verteilen ???
// ---------------------------------------------------------------
if this.dsMeals.RowCount() + this.dsAdditional.RowCount() + this.dsSPML.RowCount() = 0 then
	this.sError = "Nothing to distribut!"
	return -2
end if

//f_print_datastore(dsMeals)
//f_print_datastore(dsAdditional)
//f_print_datastore(dsSPML)

// ---------------------------------------------------------------
// Klassennummern zuspielen
// 1 = Meals
// 2 = Extrabeladung
// 3 = SPML's
// 4 = dsLoadingList
// ---------------------------------------------------------------
this.of_add_classnumbers(1)
this.of_add_classnumbers(2)
this.of_add_classnumbers(3)
this.of_add_classnumbers(4)

// -----------------------------------------------------
// Gibt es Stauorte
// -----------------------------------------------------
if isnull(dsLoadingList) or dsLoadingList.RowCount() <= 0 then
	this.sError = "No Basic Loading found!"
	this.of_log(this.sError)
	return -1
else
	//this.of_hide_columns()
end if

// -----------------------------------------------------
// Verteilungsparameter pro Galley einsammeln
// -----------------------------------------------------
if this.of_get_distribution_parameters() <> 0 then
	this.of_log(this.sError)
//	return -1
end if

// -----------------------------------------------------
// Die H$$HEX1$$f600$$ENDHEX$$hen und Tiefen ermitteln
// -----------------------------------------------------
if this.of_get_dimensions() <> 0 then
	this.of_log(this.sError)
//	return -1
end if


// -----------------------------------------------------
// Klassen l$$HEX1$$f600$$ENDHEX$$schen, wenn MCD Verteilung erfolgen soll
// -----------------------------------------------------
this.of_mcd_prepare()

// -----------------------------------------------------
//
// Automatische Verteilung anwerfen
//
// -----------------------------------------------------
if this.bManuelDistribution = false then
	
	
//	Messagebox("", "drin")
	// -----------------------------------------------------
	// Los gehts ....
	// Verteilung Mahlzeiten / Extrabeladung
	// Parameter:
	// 1 = Mahlzeiten
	// 2 = Extrabeladung
	// 3 = SPML's
	// -----------------------------------------------------
	this.of_distribution(3)
	this.of_distribution(1)
	this.of_distribution(2)
	
	this.of_to_errorlist(1)
	this.of_to_errorlist(2)
	this.of_to_errorlist(3)
	
	this.of_distribution_errorlist()
	
	// -----------------------------------------------------
	// 08.05.2006 
	// Mehrklassige Beh$$HEX1$$e400$$ENDHEX$$ltnisse erst am Ende bef$$HEX1$$fc00$$ENDHEX$$llen
	// -----------------------------------------------------
	if this.iMixed = 1 then
		this.of_log("Removing MultiClassFlag .......")
		this.of_remove_multiclass_flag()
		this.of_distribution_errorlist()
	end if 

//	Messagebox("this.bManuelDistribution            ", this.bManuelDistribution)	
//	f_print_datastore(this.dsDistributionErrors)
// --------------------------------------------------------
//
// Automatische Verteilung mit manuellem Fehlerhandling
//
// --------------------------------------------------------
elseif this.bManuelDistribution = true and this.bManuelDistributionOnError = true then
	
	this.of_distribution(3)
	this.of_distribution(1)
	this.of_distribution(2)
	
	this.of_to_errorlist(1)
	this.of_to_errorlist(2)
	this.of_to_errorlist(3)
	this.of_distribution_errorlist()
	
	// -----------------------------------------------------
	// 08.05.2006 
	// Mehrklassige Beh$$HEX1$$e400$$ENDHEX$$ltnisse erst am Ende bef$$HEX1$$fc00$$ENDHEX$$llen
	// -----------------------------------------------------
	if this.iMixed = 1 then
		this.of_log("Removing MultiClassFlag .......")
		this.of_remove_multiclass_flag()
		this.of_distribution_errorlist()
	end if 
	
	if this.dsDistributionErrors.RowCount() > 0 then
		
		openwithparm(w_manual_distribution, this)
		strReturn = message.PowerObjectParm
		
		yield()
		
		if not isvalid(strReturn) then
			// ---------------------------------
			// Anwender hat abgebrochen alles
			// in die Fehlerliste kopieren
			// ---------------------------------
			this.of_to_errorlist(1)
			this.of_to_errorlist(2)
			this.of_to_errorlist(3)
		end if
	
		if not strReturn.bSuccessful  then
			
			// ---------------------------------
			// Anwender hat abgebrochen alles
			// in die Fehlerliste kopieren
			// ---------------------------------
			this.of_to_errorlist(1)
			this.of_to_errorlist(2)
			this.of_to_errorlist(3)
			return -1000

		else
			
			this.dsLoadinglist.Reset()
			strReturn.uoReturn.dsLoadinglist.SetFilter("")
			strReturn.uoReturn.dsLoadinglist.Filter()
			strReturn.uoReturn.dsLoadinglist.RowsCopy(1, &
																	strReturn.uoReturn.dsLoadinglist.RowCount(), &
																	Primary!, &
																	this.dsLoadinglist, &
																	1, &
																	Primary!)
														
			this.dsDistribution					= strReturn.uoReturn.dsDistribution								
			this.dsMeals							= strReturn.uoReturn.dsMeals
			this.dsAdditional						= strReturn.uoReturn.dsAdditional
			this.dsSPMLDistribution				= strReturn.uoReturn.dsSPMLDistribution
			this.dsAdditionalDistribution		= strReturn.uoReturn.dsAdditionalDistribution
			this.dsSPML								= strReturn.uoReturn.dsSPML
			this.dsDistributingMeals			= strReturn.uoReturn.dsDistributingMeals
			this.dsDistributingAdditional		= strReturn.uoReturn.dsDistributingAdditional
			this.uoStowages[]						= strReturn.uoReturn.uoStowages[]
			this.dsDistributionErrors			= strReturn.uoReturn.dsDistributionErrors
			
			// ---------------------------------
			// Falls es Reste gibt, diese
			// in die Fehlerliste kopieren
			// ---------------------------------
			this.of_to_errorlist(1)
			this.of_to_errorlist(2)
			this.of_to_errorlist(3)
			
		end if	
		
	end if
	
// -----------------------------------------------------
//
// Manuelle Verteilung anwerfen
//
// -----------------------------------------------------
elseif this.bManuelDistribution = true and this.bManuelDistributionOnError = false then
	
	openwithparm(w_manual_distribution, this)
	strReturn = message.PowerObjectParm
	
	yield()
	
	if not isvalid(strReturn) then
		// ---------------------------------
		// Anwender hat abgebrochen alles
		// in die Fehlerliste kopieren
		// ---------------------------------
		this.of_to_errorlist(1)
		this.of_to_errorlist(2)
		this.of_to_errorlist(3)
	end if
	
	if not strReturn.bSuccessful  then
		// ---------------------------------
		// Anwender hat abgebrochen alles
		// in die Fehlerliste kopieren
		// ---------------------------------
		this.of_to_errorlist(1)
		this.of_to_errorlist(2)
		this.of_to_errorlist(3)
		return -1000
		
	else
		
		this.dsLoadinglist.Reset()
		strReturn.uoReturn.dsLoadinglist.SetFilter("")
		strReturn.uoReturn.dsLoadinglist.Filter()
		strReturn.uoReturn.dsLoadinglist.RowsCopy(1, &
																strReturn.uoReturn.dsLoadinglist.RowCount(), &
																Primary!, &
																this.dsLoadinglist, &
																1, &
																Primary!)
		
		this.dsDistribution					= strReturn.uoReturn.dsDistribution								
		this.dsFlight							= strReturn.uoReturn.dsFlight
		this.dsMeals							= strReturn.uoReturn.dsMeals
		this.dsAdditional						= strReturn.uoReturn.dsAdditional
		this.dsSPMLDistribution				= strReturn.uoReturn.dsSPMLDistribution
		this.dsAdditionalDistribution		= strReturn.uoReturn.dsAdditionalDistribution
		this.dsSPML								= strReturn.uoReturn.dsSPML
		this.dsDistributingMeals			= strReturn.uoReturn.dsDistributingMeals
		this.dsDistributingAdditional		= strReturn.uoReturn.dsDistributingAdditional
		this.uoStowages[]						= strReturn.uoReturn.uoStowages[]
		this.dsDistributionErrors			= strReturn.uoReturn.dsDistributionErrors
	
		this.sHandlingString					= 	strReturn.uoReturn.sHandlingString
		
		// ---------------------------------
		// Falls es Reste gibt, diese
		// in die Fehlerliste kopieren
		// ---------------------------------
		this.of_to_errorlist(1)
		this.of_to_errorlist(2)
		this.of_to_errorlist(3)
		
	end if
	
end if

// -----------------------------------------------------
// Den Screen wieder h$$HEX1$$fc00$$ENDHEX$$bsch machen !!!
// -----------------------------------------------------
if isvalid(w_mdi_master) then w_print_center.setredraw(false)	
if isvalid(w_mdi_master) then w_print_center.setredraw(true)	

if isvalid(w_print_center) then w_print_center.setredraw(false)	
if isvalid(w_print_center) then w_print_center.setredraw(true)	

this.dsLoadingList.SetFilter("")
this.dsLoadingList.Filter()

// -----------------------------------------------------
// Klassen zuspielen, wenn MCD Verteilung erfolgt ist
// -----------------------------------------------------
this.of_mcd_complete()

// -----------------------------------------------------
// Das Location Sheet
// -----------------------------------------------------
if this.bLocationSheet then
	this.of_format_datastore_report(this.dsLocationSheet, "Location Sheet")
	this.of_get_location_sheet()

	if this.dsLocationSheet.RowCount() = 0 then
		SetNull(this.blbLocationSheet)
	else
		this.dsLocationSheet.GetFullState(this.blbLocationSheet)
	end if
	
end if 

// -----------------------------------------------------
// SPML Summary
// -----------------------------------------------------
if this.bSPMLSummary then
	if iWebService = 0 then
		this.of_format_datastore_report(this.dsSPMLSummary, uf.translate("SPML-Liste"))
	else
		this.of_format_datastore_report(this.dsSPMLSummary, "SPML-Sheet")
	end if
	
	this.of_get_spml_sheet()
	
	if this.dsSPMLSummary.RowCount() = 0 then
		SetNull(this.blbSPMLSummary)
	else
		this.dsSPMLSummary.GetFullState(blbSPMLSummary)
	end if
	
else
	SetNull(this.blbSPMLSummary)
end if 

// -----------------------------------------------------
// In die Arrays ins dsLoadingList $$HEX1$$fc00$$ENDHEX$$bertragen
// -----------------------------------------------------
this.of_add_text_to_label()
this.of_check_labeltypes()
// -----------------------------------------------------
// Die Fehlerliste h$$HEX1$$fc00$$ENDHEX$$bsch machen
// -----------------------------------------------------
string sFlight, sDeparture, sAircraft, sVersion

if this.dsDistributionErrors.RowCount() > 0 then 

	sFlight 			= dsFlight.GetItemString(1, "cairline") + " " + String(dsFlight.GetItemNumber(1, "nflight_number"), "000") + " " + dsFlight.GetItemString(1, "csuffix")
	sDeparture 		= String(dsFlight.GetItemDateTime(1, "ddeparture"), s_app.sDateFormat) + "/" + dsFlight.GetItemString(1, "cdeparture_time")
	sAircraft		= dsFlight.GetItemString(1, "cairline_owner") + " " + dsFlight.GetItemString(1, "cactype") + " [" + dsFlight.GetItemString(1, "cgalleyversion") + "]"
	sVersion 		= dsFlight.GetItemString(1, "cconfiguration")
	
	this.dsDistributionErrors.Modify("t_header1.text='" + sFlight + " - " + sDeparture + "'")
	this.dsDistributionErrors.Modify("t_header2.text='Aircraft: " +  sAircraft + " / " + sVersion + "'")
	
	if iWebService = 0 then
		this.of_format_datastore_report(this.dsDistributionErrors, uf.translate("Fehlerliste Komponentenverteilung"))
	else
		this.of_format_datastore_report(this.dsDistributionErrors, "Distribution Errors")
	end if
	
	this.dsDistributionErrors.Sort()
	this.dsDistributionErrors.GetFullState(blbDistributionErrors)
else
	SetNull(blbDistributionErrors)
end if

//f_print_datastore(this.dsLocationSheet)
//f_print_datastore(dsLoadingList)
//f_print_datastore(dsDistributingMeals)
//f_print_datastore(dsFlight)
//f_print_datastore(dsMeals)
//f_print_datastore(dsSPML)

this.dsMeals.SetFilter("")
this.dsMeals.Filter()
this.dsAdditional.SetFilter("")
this.dsAdditional.Filter()

of_store_distribution()

lEnde = CPU()
of_log("Distribution took " + string((lEnde - lStart)/1000, "0.00") + " seconds!")

return 0

end function

public function integer of_to_errorlist (integer itype);String		sPL
datastore 	dsContents
Long 			lRow

// ---------------------------------------------------
// Parameter iType
// 1 = Mahlzeiten
// 2 = Extrabeladung
// 3 = SPML
// ---------------------------------------------------
if iType = 1 then
	dsContents = this.dsMeals
elseif iType = 2 then
	dsContents = this.dsAdditional
elseif iType = 3 then
	dsContents = this.dsSPMLDistribution
else
	return -1
end if 

dsContents.SetFilter("")
dsContents.Filter()

//Messagebox("iType", iType)
//if iType = 3 then f_print_datastore(dsContents)

// ---------------------------------------------------------
// Alles in die Errorliste kopieren
// ---------------------------------------------------------
for lRow = dsContents.RowCount() to 1 Step -1
	
	// ----------------------------------------------------
	// SPML Dummies ignorieren
	// ----------------------------------------------------
	sPl = dsContents.GetItemString(lRow, "cpackinglist")
	
	if mid(sPL, 1, 7) = "XXXXXXX" then 
		continue
	end if
	
	if dsContents.GetItemNumber(lRow, "nquantity") > 0 then
		if dsContents.RowsMove(lRow, lRow, Primary!,  this.dsDistributionErrors, this.dsDistributionErrors.RowCount() + 1, Primary!) <> 1 then
				this.of_log("ERROR Rowscopy to ErrorList failed!")
		end if
	end if
next

return 0
end function

public function integer of_absolute (ref uo_distribution_container uotemp[], datastore dscontents, long lrow, long lspml, boolean blast);// ---------------------------------------------------------
//
// Die Sortenreine Verteilung
//
// ---------------------------------------------------------
Long 		lStowages, &
			lRows
string 	sStowages

sStowages = ""
For lRows =  1 to UpperBound(uoTemp)
	sStowages += uoTemp[lRows].sStowage + "/"
Next

this.of_log("------------------------------------------------------------")
this.of_log(" A B S O L U T E ")
this.of_log("------------------------------------------------------------")
this.of_log("Stowage sort: " + sStowages )
// ----------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$rs Logfile
// ----------------------------------------------------------
For lRows =  1 to dsContents.RowCount()
	if lRows = 1 then
		this.of_dump(lRows, dsContents,true)
	else
		this.of_dump(lRows, dsContents,false)
	end if
Next

for lStowages = 1 to UpperBound(uoTemp)
	
	if uoTemp[lStowages].of_fill_absolute(lRow, dsContents, lSPML)	<> 0 then
		this.of_log("of_absolute: " + uoTemp[lStowages].sError)
		this.of_dump(lRow, dsContents,true)
	end if
	
next

// ---------------------------------------------------------
// Alles was nicht verteilt werden konnte in die Errorliste 
// kopieren
// ---------------------------------------------------------
if bLast then
	
	for lRows = dsContents.RowCount() to 1 step -1
		
		if dsContents.GetItemNumber(lRows, "nquantity") > 0 then
			if dsContents.RowsMove(lRows, lRows, Primary!,  this.dsDistributionErrors, this.dsDistributionErrors.RowCount() + 1, Primary!) <> 1 then
				this.of_log("ERROR Rowscopy to ErrorList failed!")
			end if
		end if
		
	next

end if

return 0

end function

public function integer of_get_location_sheet ();// --------------------------------------------------------
// 
// Das Meal Location Sheet f$$HEX1$$fc00$$ENDHEX$$llen
// 
// --------------------------------------------------------
Long		lStowages
Long		lContents, lRows
Long		lLabels, lBosta
Long		a, i, j, k, lCount, lPos
String	sFlight, sDeparture, sAircraft, sVersion, sFetch, sClasses, sBosta, sPLType, sClass

// --------------------------------------------------------
// Header
// --------------------------------------------------------
sFlight 			= dsFlight.GetItemString(1, "cairline") + " " + String(dsFlight.GetItemNumber(1, "nflight_number"), "000") + " " + dsFlight.GetItemString(1, "csuffix")
sDeparture 		= String(dsFlight.GetItemDateTime(1, "ddeparture"), s_app.sDateFormat) + "/" + dsFlight.GetItemString(1, "cdeparture_time")
sAircraft		= dsFlight.GetItemString(1, "cairline_owner") + " " + dsFlight.GetItemString(1, "cactype") + " [" + dsFlight.GetItemString(1, "cgalleyversion") + "]"
sVersion 		= dsFlight.GetItemString(1, "cconfiguration")

this.of_get_bosta(this.lResultKey, sClasses, sBosta)
//this.of_get_handling(this.lResultKey)

this.dsLocationSheet.Modify("t_flight.text='" + sFlight + "'")
this.dsLocationSheet.Modify("t_departure.text='" + sDeparture + "'")
this.dsLocationSheet.Modify("t_aircraft.text='" + sAircraft + "'")
this.dsLocationSheet.Modify("t_version.text='" + sVersion + "'")
this.dsLocationSheet.Modify("t_bosta.text='" + sbosta + "'")
this.dsLocationSheet.Modify("t_14.text='Bosta " + sClasses + "'")
this.dsLocationSheet.Modify("t_handling.text='" + sHandlingString + "'")

this.of_format_datastore_report(this.dsLocationSheet, "Location Sheet")

//this.dsLoadingList.SetSort("")
//this.dsLoadingList.Sort()
//for lRows = 1 to this.dsLoadingList.RowCount()
//"nlabel_type"
//this.dsLoadingList.SetItem(lRow, "ndistribution_detail_key", lRow)
//this.	 [lCount].lLoadRow 		= lRow

Long lFound

for lStowages = 1 to Upperbound(this.uoStowages)
	
	
	lFound = this.dsLoadingList.Find("ndistribution_detail_key=" + string(this.uoStowages[lStowages].lLoadRow), 1, this.dsLoadingList.RowCount())
	
	if this.uoStowages[lStowages].lRanking > 1000 then this.uoStowages[lStowages].lRanking = 1000
	
	if lFound <= 0 then continue // Kann nicht sein
	
	// -----------------------------------------------------------------------
	// Duplizierte Stauorte ohne Inhalt werden nicht angezeigt/gedruckt
	// -----------------------------------------------------------------------
	if this.dsLoadingList.GetItemNumber(lFound, "nprint") = 0 and &
		this.uoStowages[lStowages].dsContent.RowCount() = 0 then continue
		
	
	this.uoStowages[lStowages].dsContent.Sort()
	
	// ------------------------------------------------------
	// Es passen nur 5 Mahlzeiten auf das Label im 
	// Location Sheet. Deshalb das Teil entsprechen
	// vervielf$$HEX1$$e400$$ENDHEX$$ltigen
	// ------------------------------------------------------
	lContents = this.uoStowages[lStowages].dsContent.RowCount()
	
	if lContents = 0 then
		lLabels	 = 1
	else
		lLabels   = Ceiling(lContents / 5)
	end if
	
	lCount = 1 
	
	for i = 1 to lLabels
		
		a = this.dsLocationSheet.InsertRow(0)
		sClass = this.uoStowages[lStowages].sClass1
		if this.uoStowages[lStowages].sClass2 <> "" then sClass += "/" + this.uoStowages[lStowages].sClass2
		if this.uoStowages[lStowages].sClass3 <> "" then sClass += "/" + this.uoStowages[lStowages].sClass3
		// -----------------------------------------------------------------------
		// Class 4,5,6
		// -----------------------------------------------------------------------		
		if this.uoStowages[lStowages].sClass4 <> "" then sClass += "/" + this.uoStowages[lStowages].sClass4
		if this.uoStowages[lStowages].sClass5 <> "" then sClass += "/" + this.uoStowages[lStowages].sClass5
		if this.uoStowages[lStowages].sClass6 <> "" then sClass += "/" + this.uoStowages[lStowages].sClass6
		
		this.dsLocationSheet.SetItem(a, "cunit", this.uoStowages[lStowages].sUnit)
		this.dsLocationSheet.SetItem(a, "cstowage", this.uoStowages[lStowages].sStowage)
		this.dsLocationSheet.SetItem(a, "cclass", sClass)
		this.dsLocationSheet.SetItem(a, "nclass_number", this.of_get_classnumber(this.uoStowages[lStowages].sClass1))
		this.dsLocationSheet.SetItem(a, "ctext1", this.uoStowages[lStowages].sText1)
		this.dsLocationSheet.SetItem(a, "ctext2", this.uoStowages[lStowages].sText2)
		this.dsLocationSheet.SetItem(a, "ctext3", this.uoStowages[lStowages].sText3)
		this.dsLocationSheet.SetItem(a, "cpackinglist", this.uoStowages[lStowages].sPackinglist)
		this.dsLocationSheet.SetItem(a, "nstowage_key", this.uoStowages[lStowages].lStowageKey)
		this.dsLocationSheet.SetItem(a, "ncopy", lLabels)
		
		//if this.uoStowages[lStowages].lRanking <> 1000 then this.dsLocationSheet.SetItem(a, "nranking", this.uoStowages[lStowages].lRanking)
		//if this.uoStowages[lStowages].lRankingSPML <> 1000 then this.dsLocationSheet.SetItem(a, "nranking_spml", this.uoStowages[lStowages].lRankingSPML)
		this.dsLocationSheet.SetItem(a, "nranking", this.uoStowages[lStowages].lRanking)
		this.dsLocationSheet.SetItem(a, "nranking_spml", this.uoStowages[lStowages].lRankingSPML)
		
		// -------------------------------------------------------------
		// Mealgang
		// H$$HEX1$$f600$$ENDHEX$$hen/Tiefen
		// St$$HEX1$$fc00$$ENDHEX$$cklistentype
		// 
		// werden nur dann eingetragen, wenn
		// sie f$$HEX1$$fc00$$ENDHEX$$r die ESL eindeutig sind
		// -------------------------------------------------------------
		if this.uoStowages[lStowages].dsPackingListSize.RowCount() = 1 then
			this.dsLocationSheet.SetItem(a, "cmeal_control_code", this.uoStowages[lStowages].dsPackingListSize.GetItemString(1, "cmeal_control_code"))			
			this.dsLocationSheet.SetItem(a, "cpl_type", this.uoStowages[lStowages].dsPackingListSize.GetItemString(1, "ctext"))			
			this.dsLocationSheet.SetItem(a, "nheight", this.uoStowages[lStowages].dsPackingListSize.GetItemNumber(1, "nheight"))			
			this.dsLocationSheet.SetItem(a, "nwidth", this.uoStowages[lStowages].dsPackingListSize.GetItemNumber(1, "nwidth"))			
		else
			sPLType = ""
			for k = 1 to this.uoStowages[lStowages].dsPackingListSize.RowCount() 
				
				sPLType += this.uoStowages[lStowages].dsPackingListSize.GetItemString(k, "ctext")
				
				if k <> this.uoStowages[lStowages].dsPackingListSize.RowCount() then
					sPLType += "/"
				end if
				
			next
			
			this.dsLocationSheet.SetItem(a, "cpl_type", sPlType)			
			
		end if
		
		lPos = 0
		
		for J = lCount to lContents
			lPos ++
			if lPos = 6 then exit
			lCount ++
			this.dsLocationSheet.SetItem(a, "nquantity" + string(lPos), this.uoStowages[lStowages].dsContent.GetItemNumber(J, "nquantity"))
			this.dsLocationSheet.SetItem(a, "ccontent" + string(lPos), this.uoStowages[lStowages].dsContent.GetItemString(J, "ctext"))
			this.dsLocationSheet.SetItem(a, "ccontent_pl" + string(lPos), this.uoStowages[lStowages].dsContent.GetItemString(J, "cpackinglist"))
		next
	next
	
next
	
this.dsLocationSheet.Sort()

return 0	
end function

public function integer of_check_labeltypes ();// ---------------------------------------------------------
// 
// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob einer St$$HEX1$$fc00$$ENDHEX$$ckliste ein Label zugeordnet ist
// das keine Verteilten Mahlzeiten darstellen kann
// 
// ---------------------------------------------------------
Long 		lStowages, &
			lFound, &
			lRows, &
			lLabelKey, &
			a
					
String	sStowages[], &
			sOut, &
			sValue
		
For a = 1 to UpperBound(uoStowages)
	
	if uoStowages[a].dsContent.RowCount() > 0 then
	
		lFound = this.dsLabelTypes.Find("nlabel_type_key=" + string(uoStowages[a].lLabelTypeKey), 1, this.dsLabelTypes.RowCount())
				
		// ----------------------------------------------------------------
		// Zugeordneter Labeltyp w$$HEX1$$fc00$$ENDHEX$$rde nicht in der Liste der Labeltypen
		// gefunden, die verteilte Komponenten darstellen k$$HEX1$$f600$$ENDHEX$$nnen. Dann
		// den Inhalt des Stauortes auf die Fehlerliste $$HEX1$$fc00$$ENDHEX$$bertragen.
		// ----------------------------------------------------------------		
		if lFound = 0 then 
			sStowages[UpperBound(sStowages) + 1] = uoStowages[a].sStowage + " - " + uoStowages[a].sPackinglist
			this.of_to_errorlist_stowage(a)
		end if
		
	end if
	
Next

if UpperBound(sStowages) > 0 then
	
	sOut = ""
	
	for a = 1 to UpperBound(sStowages)
		
		sOut += sStowages[a] + "~r"
		
		if a = 10 then
			sOut += "....... "
			exit
		end if 
		
	next
	
	if this.iWebService = 0 then
			uf.mbox("", "In folgende Stauorte wurden Mahlzeiten verteilt ~rdie nicht dargestellt werden k$$HEX1$$f600$$ENDHEX$$nnen:~r~r${" + sOut + "}~r~rDie Mahlzeiten werden auf die Fehlerliste $$HEX1$$fc00$$ENDHEX$$bertragen!~r~r", StopSign!)
	end if
	
end if
	
	
return 0
end function

public function integer of_to_errorlist_stowage (long lstowage);// ----------------------------------------------------------------
//
// Inhalt eines Stauortes auf die Fehlerliste $$HEX1$$fc00$$ENDHEX$$bertragen
//
// ----------------------------------------------------------------
Long		lHeight, &
			lWidth, &
			lQuantity, &
			lPlType, &
			lMaxHeight, &
			lMaxWidth, &
			lMaxQuantity, &
			lSPML, &
			a, &
			lRow, &
			lMax, &
			lNumber, &
			lExistingQuantity
			
String	sPackingListText, &
			sPLType, &
			sText, &
			sMealControlCode, &
			sClassName, &
			sFind

// ----------------------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$bertrag
// ----------------------------------------------------------------
For lRow = 1 to this.uoStowages[lStowage].dsContent.RowCount()

	lSPML					= this.uoStowages[lStowage].dsContent.GetItemNumber(lRow, "nspml")
	lQuantity			= this.uoStowages[lStowage].dsContent.GetItemNumber(lRow, "nquantity")
	sPackingListText	= this.uoStowages[lStowage].dsContent.GetItemString(lRow, "cpackinglist")
	sText					= this.uoStowages[lStowage].dsContent.GetItemString(lRow, "ctext")
	lHeight				= this.uoStowages[lStowage].dsContent.GetItemNumber(lRow, "nheight")
	lWidth				= this.uoStowages[lStowage].dsContent.GetItemNumber(lRow, "nwidth")
	lPlType				= this.uoStowages[lStowage].dsContent.GetItemNumber(lRow, "npltype_key")
	sPLType				= this.uoStowages[lStowage].dsContent.GetItemString(lRow, "cpl_type")
	sClassName 			= this.uoStowages[lStowage].dsContent.GetItemString(lRow, "cclass")
	sMealControlCode	= this.uoStowages[lStowage].dsContent.GetItemString(lRow, "cmeal_control_code")
	lNumber				= this.uoStowages[lStowage].dsContent.GetItemNumber(lRow, "nclass_number")
	
	
	
	sFind = "cpackinglist='" + sPackingListText + "' and cproduction_text='" + sText + "'"
	a = this.dsDistributionErrors.Find(sFind, 1, this.dsDistributionErrors.RowCount())
		
	if a > 0 then
		
		lExistingQuantity = this.dsDistributionErrors.GetItemNumber(a, "nquantity")
		this.dsDistributionErrors.SetItem(a, "nquantity", lQuantity + lExistingQuantity)
		
	else
		
		a = this.dsDistributionErrors.InsertRow(0)
		this.dsDistributionErrors.SetItem(a, "nheight", lHeight)
		this.dsDistributionErrors.SetItem(a, "nwidth", lWidth)
		this.dsDistributionErrors.SetItem(a, "nquantity", lQuantity)
		this.dsDistributionErrors.SetItem(a, "npltype_key", lPlType)
		this.dsDistributionErrors.SetItem(a, "cpackinglist", sPackingListText)
		this.dsDistributionErrors.SetItem(a, "sys_packinglist_types_ctext", sPlType)
		this.dsDistributionErrors.SetItem(a, "cproduction_text", sText)
		this.dsDistributionErrors.SetItem(a, "cmeal_control_code", sMealControlCode)
		this.dsDistributionErrors.SetItem(a, "cclass", sClassName)
		this.dsDistributionErrors.SetItem(a, "nclass_number", lNumber)
		
	end if

Next

// ----------------------------------------------------------------
// L$$HEX1$$f600$$ENDHEX$$schen
// ----------------------------------------------------------------
For lRow = this.uoStowages[lStowage].dsContent.RowCount() to 1 Step -1
	
	this.uoStowages[lStowage].dsContent.DeleteRow(lRow)
	
Next	

return 0
end function

public function integer of_check_sheet ();// ------------------------------------------------
// Checksheet mit den Mahlzeiten erg$$HEX1$$e400$$ENDHEX$$nzen
// ------------------------------------------------
Long a, i, lRow, lFound, lType
Integer 	iCounter, iOldCount
String	sComponents, sGalley, sStowage, sPlace, sTemp, sToken, sChecker
String 	sFind, sFlight, sDeparture, sAircraft, sVersion, sBosta, sHandling, sBelly, sOld, sModified, sPLUnit
datastore dsTemp

dsTemp = create datastore
dsTemp.DataObject = "dw_uo_check_sheet"

// f_view_datastore(dsLoadinglist)

this.dsLoadingList.SetFilter("")
this.dsLoadingList.Filter()

// f_print_datastore(dsCheckSheet)

For a = 1 to this.dsLoadinglist.RowCount() //UpperBound(uoStowages)
	
	// ------------------------------------------------------------------------------------------------
	// nur nlabel_type = 0 ist ein "richtiger" Stauort, die anderen sind duplizierte oder Zustaulabel	
	// ------------------------------------------------------------------------------------------------
	if this.dsLoadingList.GetItemnumber(a, "nlabel_type") <> 0 then 
		
		// Messagebox("",  this.dsLoadingList.GetItemString(a, "cen_galley_cgalley") + "-" + this.dsLoadingList.GetItemString(a, "cen_stowage_cstowage")  + "~r~r" + f_check_null(this.dsLoadingList.GetItemString(a, "cdistributed_components")) + "~r~r" + sTemp)
		if this.iAddLabelOption = 0 then continue
	end if
	
	sComponents = Trim(this.of_checknull(this.dsLoadinglist.GetItemString(a, "cdistributed_components")))
	sComponents = of_remove_mealcode( sComponents)
	sChecker 	= Trim(this.of_checknull(this.of_remove_cr(sComponents))) // CR/LF's entfernen
	
	if len(sChecker) > 0 then
		
		sGalley 		= this.dsLoadingList.GetItemString(a, "cen_galley_cgalley")
		sStowage 	= this.dsLoadingList.GetItemString(a, "cen_stowage_cstowage") 
		sPlace 		= this.dsLoadingList.GetItemString(a, "cen_stowage_cplace")
		sBelly		= String(this.dsLoadingList.GetItemnumber(a, "cen_loadinglists_nbelly_container"))
		sModified	= String(this.dsLoadingList.GetItemnumber(a, "nmodified"))
		sPLUnit		= this.dsLoadingList.GetItemString(a, "cen_packinglists_cunit")
		lType			= this.dsLoadingList.GetItemNumber(a, "nlabel_type")

//		Messagebox("", sGalley + "-" + sStowage + "~r~r" + sComponents  + "~r~r" + sChecker)


//		lFound = this.dsCheckSheet.Find("cgalley='" + sGalley + "' and cstowage='" + sStowage + "' and cplace='" + sPlace + "' and nbelly = " + sBelly, 1, this.dsCheckSheet.RowCount())
//		lFound = this.dsCheckSheet.Find("cgalley='" + sGalley + &
//		                          "' and cstowage='" + sStowage + &
//										  "' and cplace='" + sPlace + &
//										  "' and nbelly = " + sBelly + &
//										  "' and nduplicated = " + String(lType) + &
//										  "' and cunit = '" + sPLUnit + "'" + &
//										  "  and nmodified = " + sModified  , 1, this.dsCheckSheet.RowCount())
	
	
		sFind = "cgalley='" + sGalley + &
				  "' and cstowage='" + sStowage + "'" + &
				  " and cplace='" + sPlace + "'" + &
				  " and nbelly = " + sBelly + &
				  " and nduplicated = " + String(lType) + &
				  " and cunit = '" + sPLUnit + "'" + &
				  " and nmodified = " + sModified 
				  
		lFound = this.dsCheckSheet.Find(sFind,  1, this.dsCheckSheet.RowCount())		  
		
		// messagebox(string(lFound) + "             ", sFind)
		
		if lFound > 0 then 
					
			sTemp = ""
			iCounter = 0
			
			for i = 1 to len(sComponents)
				
				sToken = Mid(sComponents, i, 1)
				
				if sToken = "~t" then
					sTemp += " " 
				else
					sTemp += sToken 
				end if
				
			next
			
			if iCounter = 0 then iCounter = 1

			sOld = f_check_null(this.dsCheckSheet.GetItemString(lFound, "cdistributed"))
			
			if len(Trim(sOld)) > 7 then // 7 = St$$HEX1$$fc00$$ENDHEX$$cklistennummer
			
				if Right(sOld, 1) <> "~n" then 
					sOld += "~n"
				end if
				
			else
				
				sOld = ""
				
			end if
				
//			//iOldCount = this.dsCheckSheet.GetItemNumber(lFound, "nitems")
//			if sGalley = "F1" and sStowage = "11" then
//				Messagebox("........................", sOld + sTemp)
//			end if
			
			this.dsCheckSheet.SetItem(lFound, "cdistributed", sOld + sTemp)
			
		else
			
			// Messagebox("NOT Found ",  this.dsLoadingList.GetItemString(a, "cen_galley_cgalley") + "-" + this.dsLoadingList.GetItemString(a, "cen_stowage_cstowage")  + "~r~r" + this.dsLoadingList.GetItemString(a, "cdistributed_components"))
			sFlight		= this.dsCheckSheet.GetItemString(1, "sflight")
			sDeparture	= this.dsCheckSheet.GetItemString(1, "sdeparture")
			sAircraft	= this.dsCheckSheet.GetItemString(1, "saircraft")
			sVersion		= this.dsCheckSheet.GetItemString(1, "sversion")
			sBosta		= this.dsCheckSheet.GetItemString(1, "sbosta")
			sHandling	= this.dsCheckSheet.GetItemString(1, "sHandling")
			
			lRow = dsTemp.InsertRow(0)

			dsTemp.SetItem(lRow, "sflight", sFlight)
			dsTemp.SetItem(lRow, "sdeparture", sDeparture)
			dsTemp.SetItem(lRow, "saircraft", sAircraft)
			dsTemp.SetItem(lRow, "sversion", sVersion)
			dsTemp.SetItem(lRow, "sbosta", sBosta)
			dsTemp.SetItem(lRow, "sHandling", sHandling)
			dsTemp.SetItem(lRow, "ngalley_pos", this.dsLoadingList.GetItemNumber(a, "ngalley_group"))
			dsTemp.SetItem(lRow, "cpackinglist", this.dsLoadingList.GetItemString(a, "cen_packinglist_index_cpackinglist"))
			dsTemp.SetItem(lRow, "cgalley", this.dsLoadingList.GetItemString(a, "cen_galley_cgalley") )
			dsTemp.SetItem(lRow, "cstowage", this.dsLoadingList.GetItemString(a, "cen_stowage_cstowage"))
			dsTemp.SetItem(lRow, "cplace", this.dsLoadingList.GetItemString(a, "cen_stowage_cplace"))
			dsTemp.SetItem(lRow, "cunit", this.dsLoadingList.GetItemString(a, "cen_packinglists_cunit")) 
			dsTemp.SetItem(lRow, "ctext", "[" + this.dsLoadingList.GetItemString(a, "cen_packinglist_index_cpackinglist") + "] - " + this.dsLoadingList.GetItemString(a, "cen_packinglists_ctext")) 
			dsTemp.SetItem(lRow, "sworkstation", this.dsLoadingList.GetItemString(a, "carea") + " - " + this.dsLoadingList.GetItemString(a, "cworkstation_text"))  
			dsTemp.SetItem(lRow, "carea", f_check_null(this.dsLoadingList.GetItemString(a, "carea")) )
			dsTemp.SetItem(lRow, "cworkstation", f_check_null(this.dsLoadingList.GetItemString(a, "cworkstation")))
			dsTemp.SetItem(lRow, "ngalley_sort", this.dsLoadingList.GetItemNumber(a, "cen_galley_nsort")) 
			dsTemp.SetItem(lRow, "nstowage_sort", this.dsLoadingList.GetItemNumber(a, "cen_stowage_nsort")) 
			dsTemp.SetItem(lRow, "nbelly", this.dsLoadingList.GetItemNumber(a, "cen_loadinglists_nbelly_container")) 
			dsTemp.SetItem(lRow, "nmodified", this.dsLoadingList.GetItemNumber(a, "nmodified")) 
						
			sTemp = ""
			iCounter = 0
			
			for i = 1 to len(sComponents)
				
				sToken = Mid(sComponents, i, 1)
				
				if sToken = "~t" then
					sTemp += " " 
				else
					sTemp += sToken 
				end if
				
			next
			
			// dsTemp.SetItem(lRow, "cdistributed", this.dsLoadingList.GetItemString(a, "cdistributed_components")) 
			dsTemp.SetItem(lRow, "cdistributed", sTemp) 
	
//			if sGalley = "F1" and sStowage = "11" then
//				Messagebox("ELSE ....................", sTemp)
//				dsTemp.SetItem(lRow, "cdistributed", sTemp)
//			end if
			
		end if
		
	end if
	
Next

// ----------------------------------------------------------
// Stauorte, die nach Bedarf gef$$HEX1$$fc00$$ENDHEX$$llt werden sollen, werden
// bei der Erstellung des Check-Sheets nicht ber$$HEX1$$fc00$$ENDHEX$$cksichtigt
// Wenn die Mahlzeitenverteilung diese Stauorte verwendet
// hat, dann werden sie auf das Check-Sheet $$HEX1$$fc00$$ENDHEX$$bertragen 
// ----------------------------------------------------------
if dsTemp.RowCount() > 0 then
	dsTemp.RowsCopy(1, dsTemp.RowCount(), Primary!, this.dsCheckSheet, this.dsCheckSheet.RowCount() +1, Primary!)
end if

// ----------------------------------------------------------
// Zeilenumbr$$HEX1$$fc00$$ENDHEX$$che z$$HEX1$$e400$$ENDHEX$$hlen
// ----------------------------------------------------------
for a = 1 to this.dsCheckSheet.RowCount()

	sComponents	= this.dsCheckSheet.GetItemString(a, "cdistributed")
	iCounter 	= 0 
	
	if right(sComponents, 1) <> "~n" then sComponents = sComponents + "~n"
		
	// ----------------------------------------------------------
	// Alle ~n's vom Ende wegschneiden
	// ----------------------------------------------------------
	// Autosize height funktioniert nicht, deshalb die ~n's
	// z$$HEX1$$e400$$ENDHEX$$hlen und dann sp$$HEX1$$e400$$ENDHEX$$ter per SetDetailheight die Zeilenh$$HEX1$$f600$$ENDHEX$$he
	// anpassen
	// ----------------------------------------------------------
	for i = 1 to len(sComponents)
				
		sToken = Mid(sComponents, i, 1)
		
		if sToken = "~n" then 
			iCounter ++
		end if
			
	next
		
	if iCounter > 1 then 
		//iCounter ++
	elseif iCounter = 0 then
		iCounter = 1
	end if 
	
	this.dsCheckSheet.SetItem(a, "nitems",  iCounter)
	
//	Messagebox("", this.dsCheckSheet.GetItemString(a, "cdistributed"))
	
next




// ----------------------------------------------------------
// Es sollen nur die dargestellt werden, die auch verwendet
// wurden ..
// ----------------------------------------------------------
if bCheckSheetOnlyUsed then

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
//MB 15.05.2013 destroy erg$$HEX1$$e400$$ENDHEX$$nzt
destroy dstemp
return 0
end function

public function integer of_get_spml_sheet ();// ------------------------------------------------
// Checksheet mit den Mahlzeiten erg$$HEX1$$e400$$ENDHEX$$nzen
// ------------------------------------------------
Long 			a, &
				i, &
				lRow,&
				lFound, &
				lLeg, &
				lCurrentResultKey
				
Integer 		iCounter

String		sComponents, &
				sGalley, &
				sStowage, &
				sPlace, &
				sTemp, &
				sToken
				
String 		sFlight, &
				sDeparture, &
				sAircraft, &
				sVersion, &
				sClasses, &
				sBosta



// -------------------------------------------------
// Alles Stauorte
// -------------------------------------------------
For I = 1 to UpperBound(this.uoStowages)
	// -------------------------------------------------
	// Nachschaun, ob ein SPML drin ist
	// -------------------------------------------------
	For lRow = 1 to this.uoStowages[i].dsContent.RowCount()
		
		if this.uoStowages[i].dsContent.GetItemNumber(lRow, "nspml") = 1 then
			// -------------------------------------------------
			// Den Stauort suchen
			// -------------------------------------------------
			lFound = this.dsLoadingList.Find("ndistribution_detail_key=" + string(this.uoStowages[I].lLoadRow ), 1, this.dsLoadingList.RowCount())
			
			if lFound > 0 then
								
				lLeg = this.dsLoadingList.GetItemNumber(lFound, "ncatering_leg")
			
				
				if lLeg <= 0 or isnull(lLeg) then lLeg = 1
				if this.dsLeg.RowCount() = 0 then continue
				
					
				// -------------------------------------------------------------------
				// 28.02.07, KF
				// M$$HEX1$$f600$$ENDHEX$$gliche Eingabe ins Catering Leg ist auch 23 f$$HEX1$$fc00$$ENDHEX$$r Leg 2 & 3
				// 
				// Bei unklarer Leg - Zuordnung dann die erste Stelle des Mealcodes		
				// als Leg verwenden. K$$HEX1$$f600$$ENDHEX$$nnte auch grunds$$HEX1$$e400$$ENDHEX$$tzlich so funktionieren.
				// -------------------------------------------------------------------
				if Len(String(lLeg)) = 2 then 
					lLeg = Long(Mid(this.uoStowages[i].dsContent.GetItemString(lRow, "cmeal_control_code"), 1, 1))
				end if
				
				
				if lLeg > this.dsLeg.RowCount() then lLeg = 1
				
				if lCurrentResultKey <> this.dsLeg.GetItemNumber(lLeg, "nresult_key") then
					
					lCurrentResultKey = this.dsLeg.GetItemNumber(lLeg, "nresult_key")
					sVersion 			= this.dsLeg.GetItemString(lLeg, "cconfiguration")
					this.of_get_bosta(lCurrentResultKey, sClasses, sBosta)
					this.of_get_handling(lCurrentResultKey)
					
				end if
								
				a = this.dsSPMLSummary.InsertRow(0)
				sFlight 		= dsLeg.GetitemString(lLeg, "cairline") + " " + string(dsLeg.GetitemNumber(lLeg, "nflight_number"), "000") + dsLeg.GetitemString(lLeg, "csuffix")
				sDeparture 	= string(dsLeg.GetitemDateTime(lLeg, "ddeparture"), s_app.sDateFormat) + " " + dsLeg.GetitemString(lLeg, "cdeparture_time")
				sAircraft 	= dsLeg.GetitemString(lLeg, "cactype") + " [" + dsLeg.GetitemString(lLeg, "cgalleyversion") + "]"
								
				this.dsSPMLSummary.SetItem(a, "sflight", sFlight)
				this.dsSPMLSummary.SetItem(a, "sdeparture", sDeparture)
				this.dsSPMLSummary.SetItem(a, "saircraft", sAircraft)
				this.dsSPMLSummary.SetItem(a, "stlc_from", dsLeg.GetitemString(lLeg, "ctlc_from"))
				this.dsSPMLSummary.SetItem(a, "stlc_to", dsLeg.GetitemString(lLeg, "ctlc_to"))
								
				this.dsSPMLSummary.SetItem(a, "sversion", sVersion)
				this.dsSPMLSummary.SetItem(a, "sbosta", sBosta)
				this.dsSPMLSummary.SetItem(a, "sHandling", sHandlingString)
		
				this.dsSPMLSummary.SetItem(a, "nleg", lLeg)
				this.dsSPMLSummary.SetItem(a, "ngalley_pos", this.dsLoadingList.GetItemNumber(lFound, "ngalley_group"))
				this.dsSPMLSummary.SetItem(a, "cpackinglist", this.dsLoadingList.GetItemString(lFound, "cen_packinglist_index_cpackinglist"))
				this.dsSPMLSummary.SetItem(a, "cgalley", this.dsLoadingList.GetItemString(lFound, "cen_galley_cgalley") )
				this.dsSPMLSummary.SetItem(a, "cstowage", this.dsLoadingList.GetItemString(lFound, "cen_stowage_cstowage"))
				this.dsSPMLSummary.SetItem(a, "cplace", this.dsLoadingList.GetItemString(lFound, "cen_stowage_cplace"))
				this.dsSPMLSummary.SetItem(a, "cunit", this.dsLoadingList.GetItemString(lFound, "cen_packinglists_cunit")) 
				this.dsSPMLSummary.SetItem(a, "sworkstation", this.dsLoadingList.GetItemString(lFound, "carea") + " - " + this.dsLoadingList.GetItemString(lFound, "cworkstation_text"))  
				this.dsSPMLSummary.SetItem(a, "carea", f_check_null(this.dsLoadingList.GetItemString(lFound, "carea")) )
				this.dsSPMLSummary.SetItem(a, "cworkstation", f_check_null(this.dsLoadingList.GetItemString(lFound, "cworkstation")))
				this.dsSPMLSummary.SetItem(a, "ngalley_sort", this.dsLoadingList.GetItemNumber(lFound, "cen_galley_nsort")) 
				this.dsSPMLSummary.SetItem(a, "nstowage_sort", this.dsLoadingList.GetItemNumber(lFound, "cen_stowage_nsort")) 
				this.dsSPMLSummary.SetItem(a, "nbelly", this.dsLoadingList.GetItemNumber(lFound, "cen_loadinglists_nbelly_container")) 
				this.dsSPMLSummary.SetItem(a, "cdistributed", this.dsLoadingList.GetItemString(lFound, "cdistributed_components")) 

				this.dsSPMLSummary.SetItem(a, "ctext", this.uoStowages[i].dsContent.GetItemString(lRow, "ctext")) 
				this.dsSPMLSummary.SetItem(a, "sremark", this.uoStowages[i].dsContent.GetItemString(lRow, "cremark")) 
				this.dsSPMLSummary.SetItem(a, "nquantity", this.uoStowages[i].dsContent.GetItemNumber(lRow, "nquantity")) 
				this.dsSPMLSummary.SetItem(a, "cclass", this.uoStowages[i].dsContent.GetItemString(lRow, "cclass")) 
				this.dsSPMLSummary.SetItem(a, "sdistribution_key", this.of_get_distribution_type_description(this.uoStowages[i].dsContent.GetItemNumber(lRow, "npltype_key")))
				this.dsSPMLSummary.SetItem(a, "sservice", Mid(this.uoStowages[i].dsContent.GetItemString(lRow, "cmeal_control_code"), 2, 1))
				this.dsSPMLSummary.SetItem(a, "nclass_number", this.uoStowages[i].dsContent.GetItemNumber(lRow, "nclass_number"))
		
			end if
			
		end if
		
	Next
	
Next

this.dsSPMLSummary.Sort()
this.dsSPMLSummary.GroupCalc()

return 0
end function

public function String of_get_distribution_type_description (long lkey);

Long lRows


for lRows = 1 to this.dsPackinglistTypes.RowCount()
	if this.dsPackinglistTypes.GetItemNumber(lRows, "npltype_key") = lKey then return this.dsPackinglistTypes.GetItemString(lRows, "cdescription")
next

return ""
end function

public function integer of_get_bosta (long lcurrentresultkey, ref string sclasses, ref string sbosta);Long		lBosta
String	sFetch


// ---------------------------------------------------------
// BOSTA f$$HEX1$$fc00$$ENDHEX$$r den Header einsammeln
// ---------------------------------------------------------
DECLARE GetBosta CURSOR FOR  
select cclass, npax from cen_out_pax where nresult_key = :lCurrentResultKey and nbooking_class = 1 order by nclass_number;

open GetBosta;

sClasses = ""
sBosta	= ""

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
	
	sBosta = "Error: " + String(sqlca.sqlcode)
	
	//Messagebox(string(lCurrentResultKey) + "          ", sqlca.sqlerrtext)
	

end if

close GetBosta;

return 0
end function

public function integer of_get_handling (long lcurrentresultkey);String sFetch

// ---------------------------------------------------------
// LL und SLL f$$HEX1$$fc00$$ENDHEX$$r den Header einsammeln
// ---------------------------------------------------------
DECLARE GetHandling CURSOR FOR  
select cloadinglist from cen_out_handling where cen_out_handling.nresult_key = :lCurrentResultKey order by  cen_out_handling.nprio;

open GetHandling;

sHandlingString = ""

If sqlca.sqlcode = 0 then
	
	do While sqlca.sqlcode = 0
		Fetch GetHandling into :sFetch;
		if sqlca.sqlcode = 0 then
			
			sHandlingString += sFetch + " / " 
			
		end if
	loop
	
else
	close GetHandling;
	this.of_log("ERROR CURSOR: [ " + string(sqlca.sqlcode) + " ] - " + sqlca.sqlerrtext )
	return 0
	
end if

close GetHandling;

sHandlingString = Mid(sHandlingString, 1, Len(sHandlingString) - 3)

return 0
end function

public function integer of_get_location_sheet_old ();// --------------------------------------------------------
// 
// Das Meal Location Sheet f$$HEX1$$fc00$$ENDHEX$$llen
// 
// --------------------------------------------------------
Long		lStowages
Long		lContents
Long		lLabels, lBosta
Long		a, i, j, k, lCount, lPos
String	sFlight, sDeparture, sAircraft, sVersion, sFetch, sClasses, sBosta, sPLType, sClass

// --------------------------------------------------------
// Header
// --------------------------------------------------------
sFlight 			= dsFlight.GetItemString(1, "cairline") + " " + String(dsFlight.GetItemNumber(1, "nflight_number"), "000") + " " + dsFlight.GetItemString(1, "csuffix")
sDeparture 		= String(dsFlight.GetItemDateTime(1, "ddeparture"), s_app.sDateFormat) + "/" + dsFlight.GetItemString(1, "cdeparture_time")
sAircraft		= dsFlight.GetItemString(1, "cairline_owner") + " " + dsFlight.GetItemString(1, "cactype") + " [" + dsFlight.GetItemString(1, "cgalleyversion") + "]"
sVersion 		= dsFlight.GetItemString(1, "cconfiguration")

this.of_get_bosta(this.lResultKey, sClasses, sBosta)
//this.of_get_handling(this.lResultKey)

this.dsLocationSheet.Modify("t_flight.text='" + sFlight + "'")
this.dsLocationSheet.Modify("t_departure.text='" + sDeparture + "'")
this.dsLocationSheet.Modify("t_aircraft.text='" + sAircraft + "'")
this.dsLocationSheet.Modify("t_version.text='" + sVersion + "'")
this.dsLocationSheet.Modify("t_bosta.text='" + sbosta + "'")
this.dsLocationSheet.Modify("t_14.text='Bosta " + sClasses + "'")
this.dsLocationSheet.Modify("t_handling.text='" + sHandlingString + "'")

this.of_format_datastore_report(this.dsLocationSheet, "Location Sheet")

for lStowages = 1 to Upperbound(this.uoStowages)
	
	this.uoStowages[lStowages].dsContent.Sort()
	
	// ------------------------------------------------------
	// Es passen nur 5 Mahlzeiten auf das Label im 
	// Location Sheet. Deshalb das Teil entsprechend
	// vervielf$$HEX1$$e400$$ENDHEX$$ltigen
	// ------------------------------------------------------
	lContents = this.uoStowages[lStowages].dsContent.RowCount()
	
	if lContents = 0 then
		lLabels	 = 1
	else
		lLabels   = Ceiling(lContents / 5)
	end if
	
	lCount = 1 
	
	for i = 1 to lLabels
		
		a = this.dsLocationSheet.InsertRow(0)
		sClass = this.uoStowages[lStowages].sClass1
		if this.uoStowages[lStowages].sClass2 <> "" then sClass += "/" + this.uoStowages[lStowages].sClass2
		if this.uoStowages[lStowages].sClass3 <> "" then sClass += "/" + this.uoStowages[lStowages].sClass3

		if this.uoStowages[lStowages].sClass4 <> "" then sClass += "/" + this.uoStowages[lStowages].sClass4
		if this.uoStowages[lStowages].sClass5 <> "" then sClass += "/" + this.uoStowages[lStowages].sClass5
		if this.uoStowages[lStowages].sClass6 <> "" then sClass += "/" + this.uoStowages[lStowages].sClass6
		
		
		this.dsLocationSheet.SetItem(a, "cunit", this.uoStowages[lStowages].sUnit)
		this.dsLocationSheet.SetItem(a, "cstowage", this.uoStowages[lStowages].sStowage)
		this.dsLocationSheet.SetItem(a, "cclass", sClass)
		this.dsLocationSheet.SetItem(a, "nclass_number", this.of_get_classnumber(this.uoStowages[lStowages].sClass1))
		this.dsLocationSheet.SetItem(a, "ctext1", this.uoStowages[lStowages].sText1)
		this.dsLocationSheet.SetItem(a, "ctext2", this.uoStowages[lStowages].sText2)
		this.dsLocationSheet.SetItem(a, "ctext3", this.uoStowages[lStowages].sText3)
		this.dsLocationSheet.SetItem(a, "cpackinglist", this.uoStowages[lStowages].sPackinglist)
		this.dsLocationSheet.SetItem(a, "nstowage_key", this.uoStowages[lStowages].lStowageKey)
		this.dsLocationSheet.SetItem(a, "ncopy", lLabels)
		
		//if this.uoStowages[lStowages].lRanking <> 1000 then this.dsLocationSheet.SetItem(a, "nranking", this.uoStowages[lStowages].lRanking)
		//if this.uoStowages[lStowages].lRankingSPML <> 1000 then this.dsLocationSheet.SetItem(a, "nranking_spml", this.uoStowages[lStowages].lRankingSPML)
		this.dsLocationSheet.SetItem(a, "nranking", this.uoStowages[lStowages].lRanking)
		this.dsLocationSheet.SetItem(a, "nranking_spml", this.uoStowages[lStowages].lRankingSPML)
		
		// -------------------------------------------------------------
		// Mealgang
		// H$$HEX1$$f600$$ENDHEX$$hen/Tiefen
		// St$$HEX1$$fc00$$ENDHEX$$cklistentype
		// 
		// werden nur dann eingetragen, wenn
		// sie f$$HEX1$$fc00$$ENDHEX$$r die ESL eindeutig sind
		// -------------------------------------------------------------
		if this.uoStowages[lStowages].dsPackingListSize.RowCount() = 1 then
			this.dsLocationSheet.SetItem(a, "cmeal_control_code", this.uoStowages[lStowages].dsPackingListSize.GetItemString(1, "cmeal_control_code"))			
			this.dsLocationSheet.SetItem(a, "cpl_type", this.uoStowages[lStowages].dsPackingListSize.GetItemString(1, "ctext"))			
			this.dsLocationSheet.SetItem(a, "nheight", this.uoStowages[lStowages].dsPackingListSize.GetItemNumber(1, "nheight"))			
			this.dsLocationSheet.SetItem(a, "nwidth", this.uoStowages[lStowages].dsPackingListSize.GetItemNumber(1, "nwidth"))			
		else
			sPLType = ""
			for k = 1 to this.uoStowages[lStowages].dsPackingListSize.RowCount() 
				
				sPLType += this.uoStowages[lStowages].dsPackingListSize.GetItemString(k, "ctext")
				
				if k <> this.uoStowages[lStowages].dsPackingListSize.RowCount() then
					sPLType += "/"
				end if
				
			next
			
			this.dsLocationSheet.SetItem(a, "cpl_type", sPlType)			
			
		end if
		
		lPos = 0
		
		for J = lCount to lContents
			lPos ++
			if lPos = 6 then exit
			lCount ++
			this.dsLocationSheet.SetItem(a, "nquantity" + string(lPos), this.uoStowages[lStowages].dsContent.GetItemNumber(J, "nquantity"))
			this.dsLocationSheet.SetItem(a, "ccontent" + string(lPos), this.uoStowages[lStowages].dsContent.GetItemString(J, "ctext"))
			this.dsLocationSheet.SetItem(a, "ccontent_pl" + string(lPos), this.uoStowages[lStowages].dsContent.GetItemString(J, "cpackinglist"))
		next
	next
	
next

this.dsLocationSheet.Sort()

return 0	
end function

public function integer of_set_sort ();
String	sDistributionKey, sDistributionType, ls_find

Long		lStowages, i, lFound, lKey


// ---------------------------------------------
// Den Sortierer (Sequence aus den Stammdaten)
// in das Ergebnis kopieren
// ---------------------------------------------
for lStowages = 1 to Upperbound(this.uoStowages)
	
	for i = 1 to this.uoStowages[lStowages].dsContent.RowCount()
		
		sDistributionKey	= this.uoStowages[lStowages].dsContent.GetItemString(i, "cmeal_control_code")
		sDistributionType	= this.uoStowages[lStowages].dsContent.GetItemString(i, "cpl_type")
		
		lFound = this.uoStowages[lStowages].dsPackinglistSize.Find(	"cmeal_control_code='" + sDistributionKey + "' and ctext='" + sDistributionType + "'", &
																						1, &
																						this.uoStowages[lStowages].dsPackinglistSize.RowCount())
		
		if lFound > 0 then
		
			lKey = this.uoStowages[lStowages].dsPackinglistSize.GetItemNumber(lFound, "npl_distribution_key")
			this.uoStowages[lStowages].dsContent.SetItem(i, "npl_distribution_key", lKey)
		Else		
		
			// 05.11.2012 cmeal_control_code2 - 9 ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
			ls_find = "(cmeal_control_code2='" + sDistributionKey + "' or " + & 
						"cmeal_control_code3='" + sDistributionKey + "' or "  + & 
						"cmeal_control_code4='" + sDistributionKey + "' or " + &  
						"cmeal_control_code5='" + sDistributionKey + "' or " + &  
						"cmeal_control_code6='" + sDistributionKey + "' or " + &  
						"cmeal_control_code7='" + sDistributionKey + "' or " + &  
						"cmeal_control_code8='" + sDistributionKey + "' or " + &  
						"cmeal_control_code9='" + sDistributionKey + "') and ctext='" + sDistributionType + "'"
			
			lFound = this.uoStowages[lStowages].dsPackinglistSize.Find(ls_find, 1, this.uoStowages[lStowages].dsPackinglistSize.RowCount())
			
			if lFound > 0 then
			
				lKey = this.uoStowages[lStowages].dsPackinglistSize.GetItemNumber(lFound, "npl_distribution_key")
				this.uoStowages[lStowages].dsContent.SetItem(i, "npl_distribution_key", lKey)
				
			end if
				
			// Ende cmeal_control_code2 ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
				
		end if
		
	next
	
	this.uoStowages[lStowages].dsContent.Sort()
	
next


return 0
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

public function integer of_dump_stowage_sort ();Long 		lRow
String	sStowage

if this.iTrace = 0 then return 0

this.of_log("CLASS - RANKING - RANKING_SPML - UNIT_PRIO - GALLEY_SORT - GALLEY - STOWAGE - PLACE - UNIT")
this.of_log("--------------------------------------------------------------------------------------------")
this.of_log("SortCriteria: " + this.dsDistribution.Describe("datawindow.table.sort"))
this.of_log("--------------------------------------------------------------------------------------------")

for lRow = 1 to this.dsDistribution.RowCount()
	
	sStowage	= 	"[" + this.of_checknull(string(this.dsDistribution.GetItemNumber(lRow, "nclass_number") )) + "] - "
	sStowage += 	this.of_checknull(string(this.dsDistribution.GetItemNumber(lRow, "nranking"))) + " / " 
	sStowage += 	this.of_checknull(string(this.dsDistribution.GetItemNumber(lRow, "nranking_spml"))) + " / " 
	sStowage += 	this.of_checknull(string(this.dsDistribution.GetItemNumber(lRow, "nunit_priority"))) + " / " 
	sStowage += 	this.of_checknull(string(this.dsDistribution.GetItemNumber(lRow, "cen_stowage_nsort"))) + " / " 
	sStowage += 	this.dsDistribution.GetItemstring(lRow, "cen_galley_cgalley") + "-" 
	sStowage += 	this.dsDistribution.GetItemstring(lRow, "cen_stowage_cstowage") + " "
	sStowage += 	this.of_checknull(this.dsDistribution.GetItemstring(lRow, "cen_stowage_cplace")) + " - " 
	sStowage += 	this.of_checknull(this.dsDistribution.GetItemstring(lRow, "cen_packinglists_cunit")) 
	this.of_log(sStowage)
next

return 0

end function

public function integer of_dump_unit_priority ();Long 		lRow
String	sUnit

if this.iTrace = 0 then return 0

for lRow = 1 to this.dsDistributionPriority.RowCount()
	sUnit	 = 	"[" + this.dsDistributionPriority.GetItemString(lRow, "cunit") + "]"
	this.of_log(sUnit)
next

return 0

end function

public function integer of_accumulate_spmls ();// ---------------------------------------------------------------------
// 26.08.2005 / Kummulierung der SPML's
// 
// Problem:
// Werden viele unterschiedliche SPML-Typen mit Menge 1 beladen und
// sollen diese dann parallel verteilt werden, dann landen alle im 
// gleichen (ersten) Behaltnis. CR: ZD-CR-1028
//
// L$$HEX1$$f600$$ENDHEX$$sung: 
// Alle SPML's zun$$HEX1$$e400$$ENDHEX$$chst kummulieren, dann verteilen und am Ende
// dann wieder die Detailinformationen zuspielen.
// ---------------------------------------------------------------------
Long 			a, lRows
Long 			I, lQuantity
Long 			lPlType, lClass, lGroup, lFound, lHeight, lWidth
String 		sPlType, sMealControlCode, sClass, sFilter
Datastore 	dsSPMLControl

// ------------------------------------------------------------------
// 1.) Mengen sichern	
// ------------------------------------------------------------------
this.dsSPMLDistribution.RowsCopy(1, this.dsSPMLDistribution.RowCount(), Primary!, this.dsSPMLDistributionMaster, 1, Primary!)
this.dsSPMLDistribution.Reset()
// ------------------------------------------------------------------
// 2.) Ermitteln wie kummuliert wird
// Erstmal eine Eindeutigkeit herstellen
// Kombinationen aus :	Klasse
//								St$$HEX1$$fc00$$ENDHEX$$cklistentype
//								Verteilerschl$$HEX1$$fc00$$ENDHEX$$ssel
//								Gruppe
// ---------------------------------------------------

dsSPMLControl 					= create datastore
dsSPMLControl.dataobject	= "dw_uo_control"

For lRows = 1 to this.dsSPMLDistributionMaster.RowCount()
	
	lPlType				= this.dsSPMLDistributionMaster.GetItemNumber(lRows, "npltype_key")
	sPlType				= this.dsSPMLDistributionMaster.GetItemString(lRows, "sys_packinglist_types_ctext")
	lClass					= this.dsSPMLDistributionMaster.GetItemNumber(lRows, "nclass_number")
	lGroup				= this.dsSPMLDistributionMaster.GetItemNumber(lRows, "ncomponent_group")
	sMealControlCode	= this.dsSPMLDistributionMaster.GetItemString(lRows, "cmeal_control_code")
	sClass				= this.dsSPMLDistributionMaster.GetItemString(lRows, "cclass")
	lHeight				= this.dsSPMLDistributionMaster.GetItemNumber(lRows, "nheight")
	lWidth				= this.dsSPMLDistributionMaster.GetItemNumber(lRows, "nwidth")
	
	lFound = dsSPMLControl.Find("npltype_key=" + string(lPlType) + &
								  " and nclass_number=" + string(lClass) + &
								  " and cmeal_control_code='" + sMealcontrolCode + "'" +&
								  " and nheight = " + string(lHeight) + &
								  " and nwidth = " + string(lWidth) , 1, dsSPMLControl.RowCount())			
								  
	if lFound = 0 then
		a = dsSPMLControl.InsertRow(0)
		dsSPMLControl.SetItem(a, "npltype_key", lPlType)
		dsSPMLControl.SetItem(a, "cpl_type", sPlType)
		dsSPMLControl.SetItem(a, "nclass_number", lClass)
		dsSPMLControl.SetItem(a, "cmeal_control_code", sMealControlCode)
		dsSPMLControl.SetItem(a, "cclass", sClass)
		dsSPMLControl.SetItem(a, "ncomponent_group", lGroup)
		dsSPMLControl.SetItem(a, "nheight", lHeight)
		dsSPMLControl.SetItem(a, "nwidth", lWidth)
	end if
Next

dsSPMLControl.SetFilter("")
dsSPMLControl.Filter()
dsSPMLControl.Sort()	
// f_print_datastore(dsSPMLControl)

// ------------------------------------------------------------------
// 2.) Dann halt kummulieren
// ------------------------------------------------------------------
//f_print_datastore(dsSPMLControl)

For lRows = 1 to dsSPMLControl.RowCount()
	
	lPlType				= dsSPMLControl.GetItemNumber(lRows, "npltype_key")
	sPlType				= dsSPMLControl.GetItemString(lRows, "cpl_type")
	lClass				= dsSPMLControl.GetItemNumber(lRows, "nclass_number")
	lGroup				= dsSPMLControl.GetItemNumber(lRows, "ncomponent_group")
	sMealControlCode	= dsSPMLControl.GetItemString(lRows, "cmeal_control_code")
	sClass				= dsSPMLControl.GetItemString(lRows, "cclass")
	lHeight				= dsSPMLControl.GetItemNumber(lRows, "nheight")
	lWidth				= dsSPMLControl.GetItemNumber(lRows, "nwidth")

	sFilter = "npltype_key=" + string(lPlType) + " and nclass_number=" + string(lClass) + " and cmeal_control_code='" + sMealcontrolCode + "' and nheight = " + string(lHeight) + " and nwidth = " + string(lWidth)
	this.dsSPMLDistributionMaster.SetFilter(sFilter)
	this.dsSPMLDistributionMaster.Filter()
		
	if this.dsSPMLDistributionMaster.RowCount() = 0 then
		// Um$$HEX1$$f600$$ENDHEX$$glich
		this.of_log("of_move_spml() NO RECORDS for: " + sFilter) 
	end if 
	
	lQuantity = 0
	For i = 1 to this.dsSPMLDistributionMaster.RowCount()
		lQuantity += this.dsSPMLDistributionMaster.GetItemnumber(I, "nquantity")
	Next
				
	this.dsSPMLDistributionMaster.RowsCopy(1, 1, Primary!, this.dsSPMLDistribution, this.dsSPMLDistribution.RowCount() + 1, Primary!)
	this.dsSPMLDistribution.SetItem(this.dsSPMLDistribution.RowCount(), "nquantity", lQuantity)
	this.dsSPMLDistribution.SetItem(this.dsSPMLDistribution.RowCount(), "cproduction_text", "XXML")
	this.dsSPMLDistribution.SetItem(this.dsSPMLDistribution.RowCount(), "cpackinglist", "XXXXXXX" + String(lRows))
	
Next	

this.dsSPMLDistributionMaster.SetFilter("")
this.dsSPMLDistributionMaster.Filter()

//f_print_datastore(dsSPMLDistributionMaster)
//f_print_datastore(dsSPMLDistribution)
return 0
end function

public function integer of_explode_spmls ();// ---------------------------------------------------------------------
// 26.08.2005 / Kummulierte SPML wieder in die Einzelteile zerlegen
// 
// Problem:
// Werden viele unterschiedliche SPML-Typen mit Menge 1 beladen und
// sollen diese dann parallel verteilt werden, dann landen alle im 
// gleichen (ersten) Behaltnis. CR: ZD-CR-1028
//
// L$$HEX1$$f600$$ENDHEX$$sung: 
// Alle SPML's zun$$HEX1$$e400$$ENDHEX$$chst kummulieren (of_acculumate_spmls), dann verteilen 
// und am Ende dann wieder die Detailinformationen zuspielen.
// ---------------------------------------------------------------------
Long a, lStowages, I, J, K, lQuantity, lMovedQuantity
Long lPlType, lClass, lFound
String sPlType, sMealControlCode, sClass, sFilter, sPackinglist
Datastore dsSPMLControl, dsTemp

Long 		lPlTypeMaster				
String 	sPlTypeMaster				
Long 		lClassMaster				
String 	sMealControlCodeMaster	
String 	sClassMaster	
String 	sPLMaster	
Long 		lHeight
Long 		lWidth

dsTemp = create datastore
dsTemp.dataobject = "dw_uo_content"

this.of_log("Entering of_explode_spmls ......")

// ------------------------------------------------------------------
// Stauort f$$HEX1$$fc00$$ENDHEX$$r Stauort beackern
// ------------------------------------------------------------------
for lStowages = 1 to Upperbound(this.uoStowages)
	
	this.uoStowages[lStowages].dsContent.SetFilter("nspml=1")
	this.uoStowages[lStowages].dsContent.Filter()
	
	if this.uoStowages[lStowages].dsContent.RowCount() <= 0 then 
		this.uoStowages[lStowages].dsContent.SetFilter("")
		this.uoStowages[lStowages].dsContent.Filter()
		continue
	end if
	
	// ------------------------------------------------------------------
	// OK, es sind SPML's im Stauort. Diese jetzt in den Details suchen
	// und von dort in den Stauort zur$$HEX1$$fc00$$ENDHEX$$ckholen
	// ------------------------------------------------------------------
	this.of_log("Stowage: " + this.uoStowages[lStowages].sStowage + " contains " + string(this.uoStowages[lStowages].dsContent.RowCount()) + " SPML's" )
	
	For I = this.uoStowages[lStowages].dsContent.RowCount() to 1 step -1
		
		lQuantity 		= 0
		lMovedQuantity = 0
		// F$$HEX1$$fc00$$ENDHEX$$r jedes kummulierte SPML, dass im Stauort ist die passenden
		// Details rausfiltern
		sPackinglist		= this.uoStowages[lStowages].dsContent.GetItemString(I, "cpackinglist")
		lPlType				= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "npltype_key")
		sPlType				= this.uoStowages[lStowages].dsContent.GetItemString(I, "cpl_type")
		lClass				= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nclass_number")
		sMealControlCode	= this.uoStowages[lStowages].dsContent.GetItemString(I, "cmeal_control_code")
		sClass				= this.uoStowages[lStowages].dsContent.GetItemString(I, "cclass")
		lQuantity			= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nquantity")
		lHeight				= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nheight")
		lWidth				= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nwidth")

		this.of_log("[" + String(I) + "] - SPML Content " + String(lQuantity) + " x " + sPackinglist)
				
		this.dsSPMLDistributionMaster.SetFilter("npltype_key=" + string(lPlType) + &
												" and nclass_number=" + string(lClass) + &
												" and cmeal_control_code='" + sMealcontrolCode + "'" + & 
												" and nheight = " + string(lHeight)  + &
												" and nwidth = " + string(lWidth)  + &
												" and nquantity > 0")
												
		this.dsSPMLDistributionMaster.Filter()		
		
		if this.dsSPMLDistributionMaster.RowCount() = 0 then
			this.of_log("[" + String(I) + "] - Found no Details for " + sPlType + "/" + String(lPlType) + " + " + sClass + "/" + string(lClass) + " + " + sMealcontrolCode + "  Height " + String(lHeight)  + " Width " + string(lWidth))
		end if
		
		for j = 1 to this.dsSPMLDistributionMaster.RowCount()
			
			lMovedQuantity = this.dsSPMLDistributionMaster.GetItemNumber(j, "nquantity")
			sPLMaster		= this.dsSPMLDistributionMaster.GetItemString(j, "cpackinglist")
			
			this.of_log("[" + String(I) + "] - Found   " + String(lMovedQuantity) + " x " + sPLMaster)
			
			if lMovedQuantity = 0 then continue
			if lQuantity = 0 then exit
			
			// ------------------------------------------------
			// lQuantity 		= Anzahl SPML's im Stauort
			// lMovedQuantity = tats$$HEX1$$e400$$ENDHEX$$chliche Anzahl SPML's 
			// ------------------------------------------------
			// Passen alle rein
			//       3        <=    5
			// ------------------------------------------------
			if lMovedQuantity <= lQuantity then
				
				a = dsTemp.Insertrow(0)
				
				dsTemp.SetItem(a, "nspml", 1)
				dsTemp.SetItem(a, "cpackinglist",sPLMaster )
				dsTemp.SetItem(a, "ctext", this.dsSPMLDistributionMaster.GetItemString(j, "cproduction_text"))
				dsTemp.SetItem(a, "cremark", this.dsSPMLDistributionMaster.GetItemString(j, "cremark"))
				dsTemp.SetItem(a, "nheight", this.dsSPMLDistributionMaster.GetItemNumber(j, "nheight"))
				dsTemp.SetItem(a, "nwidth", this.dsSPMLDistributionMaster.GetItemNumber(j, "nwidth"))
				dsTemp.SetItem(a, "npl_distribution_key", 0)
				dsTemp.SetItem(a, "npltype_key", lPlType)
				dsTemp.SetItem(a, "cpl_type", sPlType)
				dsTemp.SetItem(a, "nclass_number", lClass)
				dsTemp.SetItem(a, "cclass", sClass)
				dsTemp.SetItem(a, "cmeal_control_code", sMealControlCode)
				dsTemp.SetItem(a, "nquantity", lMovedQuantity)
				dsTemp.SetItem(a, "nheight", lHeight)
				dsTemp.SetItem(a, "nwidth", lWidth)
				
				this.of_log("[1][" + String(I) + "] - Added   " + String(lMovedQuantity) + " x " + sPLMaster)
				
				this.dsSPMLDistributionMaster.SetItem(j, "nquantity", 0)
										
				this.of_log("[1][" + String(I) + "] - Stowage now Contains: " + string(this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nquantity")) + " SPML's")
				
				lQuantity = lQuantity - lMovedQuantity
				this.uoStowages[lStowages].dsContent.SetItem(I, "nquantity", lQuantity)
								
			// ------------------------------------------------					
			// Passt nur ein Teil rein	
			//           2             1
			// ------------------------------------------------
			elseif lMovedQuantity > lQuantity then
				
				a = dsTemp.Insertrow(0)

				dsTemp.SetItem(a, "nspml", 1)
				dsTemp.SetItem(a, "cpackinglist", sPLMaster)
				dsTemp.SetItem(a, "ctext", this.dsSPMLDistributionMaster.GetItemString(j, "cproduction_text"))
				dsTemp.SetItem(a, "cremark", this.dsSPMLDistributionMaster.GetItemString(j, "cremark"))
				dsTemp.SetItem(a, "nheight", this.dsSPMLDistributionMaster.GetItemNumber(j, "nheight"))
				dsTemp.SetItem(a, "nwidth", this.dsSPMLDistributionMaster.GetItemNumber(j, "nwidth"))
				dsTemp.SetItem(a, "npl_distribution_key", 0)
				dsTemp.SetItem(a, "npltype_key", lPlType)
				dsTemp.SetItem(a, "cpl_type", sPlType)
				dsTemp.SetItem(a, "nclass_number", lClass)
				dsTemp.SetItem(a, "cclass", sClass)
				dsTemp.SetItem(a, "cmeal_control_code", sMealControlCode)
				dsTemp.SetItem(a, "nquantity", lQuantity)
				
				this.of_log("[2][" + String(I) + "] - Added   " + String(lQuantity) + " x " + sPLMaster)
				
				this.dsSPMLDistributionMaster.SetItem(j, "nquantity", lMovedQuantity - lQuantity)
				
				this.uoStowages[lStowages].dsContent.SetItem(I, "nquantity", 0)
				lQuantity = 0
								
				this.of_log("[2][" + String(I) + "] - Stowage now Contains: " + string(this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nquantity")) + " SPML's")
				
			else
				this.of_log("[2][" + String(I) + "] -	ELSE ??  lMovedQuantity=" + String(lMovedQuantity) + " lQuantity=" + String(lQuantity))
			end if
			
	
			
		next
		
		if this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nquantity") = 0 then 
			this.of_log("[" + String(I) + "] - Remove " + sPLMaster)
			this.uoStowages[lStowages].dsContent.DeleteRow(I)
		end if

	Next
		
	this.uoStowages[lStowages].dsContent.SetFilter("")
	this.uoStowages[lStowages].dsContent.Filter()
	
	dsTemp.RowsCopy(1, dsTemp.RowCount(), Primary!, this.uoStowages[lStowages].dsContent, this.uoStowages[lStowages].dsContent.RowCount() + 1, Primary!)
	dsTemp.Reset()
	
Next

this.dsSPMLDistributionMaster.SetFilter("")
this.dsSPMLDistributionMaster.Filter()	

//f_print_datastore(dsSPMLDistributionMaster)

For I = this.dsSPMLDistributionMaster.RowCount() to 1 step -1
	if this.dsSPMLDistributionMaster.GetItemNumber(I, "nquantity") = 0 then
		this.dsSPMLDistributionMaster.DeleteRow(I)
	else
		sPLMaster = this.dsSPMLDistributionMaster.GetItemString(I, "cpackinglist") 
		lQuantity = this.dsSPMLDistributionMaster.GetItemNumber(I, "nquantity") 
		this.of_log("Can't remove " + sPLMaster + " quantity is still " + string(lQuantity))
	end if
Next

// ------------------------------------------------------------------------
// Alles wieder in dsSPMLDistribution, damit ggf. Reste auf der
// Fehlerliste landen
// ------------------------------------------------------------------------
//f_print_datastore(this.dsSPMLDistribution)
this.dsSPMLDistribution.SetFilter("")
this.dsSPMLDistribution.Filter()	
this.dsSPMLDistribution.Reset()
//f_print_datastore(this.dsSPMLDistribution)

if this.dsSPMLDistributionMaster.RowCount() > 0 then
	this.dsSPMLDistributionMaster.RowsCopy(1, this.dsSPMLDistributionMaster.RowCount(), Primary!, this.dsSPMLDistribution, 1, Primary!)
end if 

//f_print_datastore(this.dsSPMLDistribution)
//f_print_datastore(this.dsSPMLDistributionMaster)
//MB 15.05.2013 destroy erg$$HEX1$$e400$$ENDHEX$$nzt
destroy dstemp
return 0
end function

public function integer of_split_absolut (ref uo_distribution_container uotemp[], datastore dscontents, long lspml, boolean blast);// ---------------------------------------------------------
//
// Die gesplittete sortenreine Verteilung 
//
// Die Verteilung erfolgt sortenrein ggf. $$HEX1$$fc00$$ENDHEX$$ber mehrere 
// Beh$$HEX1$$e400$$ENDHEX$$ltnisse. 
//
// ---------------------------------------------------------
Long 			lRows, &
				lStowages, &
				lMaxFree, &
				lTemp, &
				lPos, &
				lFound, &
				lQuantityToLoad, &
				lOldQuantity, &
				lQuantity, &
				I, J, &
				lSum, &
				lDiff, &
				lNoOfContainers, &
				lNoOfComponentInArray, &
				lNoOfComponentsInDatastore, &
				lRankings[]

DataStore	dsTemp

Boolean 		bFound

Long 			lTotal
Decimal 		ldecPercent

	
String sStowages

sStowages = ""

For lRows =  1 to UpperBound(uoTemp)
	sStowages += uoTemp[lRows].sStowage + "/"
Next

this.of_log("------------------------------------------------------------")
this.of_log(" S P L I T T I N G  - A B S O L U T ")
this.of_log("------------------------------------------------------------")
this.of_log("Stowage sort: " + sStowages )

uo_distribution_container	uoRanking[]

s_distribution_split strSplit[], strEmpty[], strCompare[]

integer 		iCount, iUsedStowages
String		sPackingList

if dsContents.RowCount() <= 0 then
	this.of_log("No contents to distribute ....")
	return 0
end if

dsTemp = create datastore
dsTemp.dataobject = "dw_uo_cen_out_meals"

If UpperBound(uoTemp) = 0 then
	this.of_log("no stowages found ....")
	
	// ---------------------------------------------------------
	// Keine Stauorte mehr vorhanden !!!
	// Alles was noch im Datastore steht auf die Errorliste 
	// setzen !!!
	// ---------------------------------------------------------
	for lRows = dsContents.RowCount() to 1 Step -1
		if dsContents.GetItemNumber(lRows, "nquantity") > 0 and bLast then
			if dsContents.RowsMove(lRows, lRows, Primary!,  this.dsDistributionErrors, this.dsDistributionErrors.RowCount() + 1, Primary!) <> 1 then
				this.of_log("ERROR Rowscopy of_split to ErrorList failed!")
			end if
		end if
	next
	//MB 15.05.2013 destroy erg$$HEX1$$e400$$ENDHEX$$nzt
	destroy dstemp
	return -1
end if

// -------------------------------------------------------------
// Los gehts in die gro$$HEX1$$df00$$ENDHEX$$e Endlosschleife
// -------------------------------------------------------------
Do while dsContents.RowCount() > 0 

	// ----------------------------------------------------------
	// S$$HEX1$$e400$$ENDHEX$$mtliche Stauorte nach dem verf$$HEX1$$fc00$$ENDHEX$$gbaren Platz abfragen
	// Den kleisten Wert merken (SB, HT, ST  zusammen verteilen)
	// Der Kindsmiller wollts so .....
	// ----------------------------------------------------------
	lMaxFree = 10000
	
	for lStowages = 1 to UpperBound(uoTemp)
		// -------------------------------------------------------
		// Pr$$HEX1$$fc00$$ENDHEX$$fen wieviel der Stauort Maximalkapazit$$HEX1$$e400$$ENDHEX$$t hat
		// den kleinsten Max.wert aller relevanten Stauorte
		// zur Verteilung verwenden
		// -------------------------------------------------------
		lTemp = uoTemp[lStowages].of_availability(1, dsContents)
		
		if lTemp > 0 then
			uoTemp[lStowages].iUse = 1
		else
			uoTemp[lStowages].iUse = 0
			continue
		end if
		
		if lTemp > 0 and lTemp < lMaxFree then
			lMaxFree = lTemp
		end if
				
	next
	
	iUsedStowages = this.of_get_used_stowages(uoTemp)
	// -----------------------------------------------------------
	// Keine freien Stauorte mehr ??? Dann nix wie weg !!!
	// -----------------------------------------------------------
	if iUsedStowages = 0 then
		of_log("Quitting loop because there are no more available stowages !!!")
		exit 
	end if
	
	// -----------------------------------------------------------
	// Den Loop 10 mal durchlaufen dann raus ... 
	// -----------------------------------------------------------
	iCount ++
	if iCount > 10 then
		of_log("Quitting loop " + string(iCount))
		exit 
	end if
	
	of_log("Loop " + string(iCount) + " using " + string(iUsedStowages) + " of " + string(Upperbound(uoTemp)) + " stowages")
	of_log("Loop " + string(iCount) + " Maximum is " + string(lMaxFree))
	
	// ----------------------------------------------------------
	// Menge ermitteln
	// ----------------------------------------------------------
	lQuantityToLoad = 0
	for lRows = dsContents.RowCount() to 1 Step -1
		
		lQuantity = dsContents.GetItemNumber(lRows, "nquantity")
		
		if lQuantity > 0 then
			lQuantityToLoad += lQuantity
		else
			dsContents.DeleteRow(lRows)
		end if
	
	next
	
	
	
	of_log("Loop " + string(iCount) + " - " + String(lQuantityToLoad) + " components to distribute: ")

	// ----------------------------------------------------------
	// Es ist in keinem Stauort mehr was frei ........
	// ----------------------------------------------------------
	if lMaxFree = 0 then
		of_log("There is no space for " + string(lQuantityToLoad) + " components. Quitting loop")
		exit
	end if
		
	// ---------------------------------------------------------------
	//
	// Die zu beladende Menge ist gr$$HEX2$$f600df00$$ENDHEX$$er als die Staukapazit$$HEX1$$e400$$ENDHEX$$t
	// dann den Beh$$HEX1$$e400$$ENDHEX$$lter prozentual mit den Inhalten f$$HEX1$$fc00$$ENDHEX$$llen
	//
	// ---------------------------------------------------------------
	if lMaxFree * iUsedStowages <= lQuantityToLoad then
	
		for lStowages = 1 to UpperBound(uoTemp)
			
			strSplit = strEmpty
			
			if uoTemp[lStowages].iUse = 0 then continue
			
			of_log("Loop " + string(iCount) + " adding Values to " + uoTemp[lStowages].sStowage)
			
			for lRows = 1 to dsContents.RowCount()	
				
				if dsContents.GetItemNumber(lRows, "compute_loading_percentage") > 0 then
					lPos = Upperbound(strSplit) + 1
					strSplit[lPos].lPercentage 		= dsContents.GetItemNumber(lRows, "compute_loading_percentage") 
					strSplit[lPos].lQuantity			= dsContents.GetItemNumber(lRows, "nquantity")
					strSplit[lPos].lLoadQuantity		= Ceiling(lMaxFree * strSplit[lPos].lPercentage / 100)
					strSplit[lPos].lRest					= 0
					// -----------------------------------------------------------
					// LoadQuantity darf Quantity nicht $$HEX1$$fc00$$ENDHEX$$bersteigen
					// -----------------------------------------------------------
					if strSplit[lPos].lQuantity < strSplit[lPos].lLoadQuantity then 
						strSplit[lPos].lLoadQuantity 	= strSplit[lPos].lQuantity
						strSplit[lPos].lRest				= 0
					end if
					
					strSplit[lPos].lRow					= lRows
					strSplit[lPos].lPltype				= dsContents.GetItemNumber(lRows, "npltype_key")
					strSplit[lPos].lHeight				= dsContents.GetItemNumber(lRows, "nheight")
					strSplit[lPos].lWidth				= dsContents.GetItemNumber(lRows, "nwidth")
					strSplit[lPos].sPlType				= dsContents.GetItemString(lRows, "sys_packinglist_types_ctext")
					strSplit[lPos].sMealcontrolcode	= dsContents.GetItemString(lRows, "cmeal_control_code")
					strSplit[lPos].sProductiontext	= dsContents.GetItemString(lRows, "cproduction_text")
					strSplit[lPos].sRemark				= dsContents.GetItemString(lRows, "cremark")
					strSplit[lPos].sPackinglist		= dsContents.GetItemString(lRows, "cpackinglist")
					strSplit[lPos].sClass				= dsContents.GetItemString(lRows, "cclass")
					strSplit[lPos].lClassNumber		= dsContents.GetItemNumber(lRows, "nclass_number")
					strSplit[lPos].lSPML					= lSPML
					of_log("Loop " + string(iCount) + " ArrayPos: " + string(lPos) + "  crowded: " + strSplit[lPos].sPackinglist + " - " + strSplit[lPos].sProductiontext + " : " + string(strSplit[lPos].lLoadQuantity))
				else
					this.of_log("Cannot split[1]: Percentage is set to zero " + dsContents.GetItemString(lRows, "cpackinglist") + " - " + dsContents.GetItemString(lRows, "cproduction_text"))
				end if
				
			next	
			
			// -----------------------------------------------------------
			//
			// Rundungsfehler ausmerzen !!!
			//
			// -----------------------------------------------------------
			lSum = 0 
			
			// -----------------------------------------------------------
			// Inhalte addieren
			// -----------------------------------------------------------
			for I = 1 to Upperbound(strSplit)
				lSum += strSplit[i].lLoadQuantity
			next
			
			// -----------------------------------------------------------
			// Differenz ermitteln
			// -----------------------------------------------------------
			lDiff = lMaxFree - lSum
			
			if lDiff > 0 then
			
				for I = 1 to Upperbound(strSplit)
					
					// ---------------------------------------------------------------------------------
					// Ist die errechnete Belademenge ungleich der Beh$$HEX1$$e400$$ENDHEX$$ltniskapazit$$HEX1$$e400$$ENDHEX$$t und es sich nicht
					// um eine Restkapazit$$HEX1$$e400$$ENDHEX$$t handelt, dann die Differenz draufpacken.
					// ---------------------------------------------------------------------------------
					if strSplit[i].lLoadQuantity + lDiff <= strSplit[i].lQuantity and strSplit[i].lRest = 0 then
						
						strSplit[i].lLoadQuantity += lDiff
						
						// Messagebox(String(I) + "              " , strSplit[i].sPackinglist + " lDiff = " + string(lDiff)) 
						exit
					end if
					
				next
				
			else
				
				// ---------------------------------------------------------------------------------
				// Es ist mehr im Beh$$HEX1$$e400$$ENDHEX$$lnis als reinpasst (durch Rundung)
				// Die entsprechende Menge von der gr$$HEX1$$f600$$ENDHEX$$ssten Menge abziehen
				// ---------------------------------------------------------------------------------
				Long lMaxPos  = 0
				Long lMaxLoad = 0
				
				for I = 1 to Upperbound(strSplit)
					if strSplit[I].lLoadQuantity > lMaxLoad then
						lMaxLoad = strSplit[i].lLoadQuantity 
						lMaxPos	= I
					end if
				next
			
			
				// ---------------------------------------------------------------------------------
				// 19.08.2005
				// Bei vielen gemeinsam zu verteilenden Komponenten kann es passieren, dass durch
				// Rundungen lDiff gr$$HEX2$$f600df00$$ENDHEX$$er wird als die gr$$HEX1$$f600$$ENDHEX$$sste Menge einer Position, das hat
				// im Falle von ZE zu negativen Mengen auf den Labels gef$$HEX1$$fc00$$ENDHEX$$hrt, deshalb pr$$HEX1$$fc00$$ENDHEX$$fen
				// auf > 0 sonst einzeln abziehen
				// ---------------------------------------------------------------------------------
				long lInv, lLoop
								
				if lMaxPos > 0 and lDiff < 0 then
					
					// if isnull(lMaxpos) then Messagebox("", "lMaxPos is null") 
					
//					Messagebox("", "Upperbound(strSplit) = " + String(Upperbound(strSplit)) + "~r" + &
//										"lMaxpos              = " + String(lMaxPos))

			
					if strSplit[lMaxPos].lLoadQuantity + lDiff > 0 then  
						strSplit[lMaxPos].lLoadQuantity += lDiff
						this.of_log("reducing " + strSplit[lMaxPos].sPackinglist + " with " + string(lDiff) + ", because sum loadquantity is " + string(lSum) + " but there is only " + String(lMaxFree) + " free space!" )
					else
						lInv = lDiff * -1		
						
						i = 1
						
						Do while lInv > 0
							
							if i > UpperBound(strSplit) then i = 1
								
							// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob wir noch einen abziehen k$$HEX1$$f600$$ENDHEX$$nnen
							if strSplit[i].lLoadQuantity - 1 >= 0 then
								strSplit[i].lLoadQuantity --
								lInv --
								this.of_log("reducing " + strSplit[i].sPackinglist + " with 1, still " + string(lInv) + " too much components")
							end if
													
							i ++
							lLoop ++
							
							// ... sicher ist sicher !!
							if lLoop = 10 then 
								this.of_log("there are no more quantities to reduce.")
								exit
							end if 
						loop
						
					end if	
						
				end if
			
				
			end if
			
			// -----------------------------------------------------------
			// 
			// Stauort f$$HEX1$$fc00$$ENDHEX$$llen
			// 
			// -----------------------------------------------------------
			uoTemp[lStowages].of_fill_splitted(strSplit)
			// -----------------------------------------------------------
			// Mengen reduzieren
			// -----------------------------------------------------------
			for i = 1 to UpperBound(strSplit)
				// Messagebox("Protentual", String(strSplit[i].lLoadQuantity) + " --- " + String(dsContents.GetItemNumber(strSplit[i].lRow, "nquantity")))
				// Messagebox("", "Reduziere um: " + string(strSplit[i].lLoadQuantity))
				//Messagebox("","strSplit[i].lRow = " + string(strSplit[i].lRow) + "~r~r" + "dsContents.RowCount() = " + string(dsContents.RowCount()))
				
				if strSplit[i].lRow <= 0 then 
					this.of_log("Error lRow = 0")
					continue
				end if
				
				lOldQuantity = dsContents.GetItemNumber(strSplit[i].lRow, "nquantity")
				dsContents.SetItem(strSplit[i].lRow, "nquantity", lOldQuantity - strSplit[i].lLoadQuantity)
				this.of_log(dsContents.GetItemString(strSplit[i].lRow, "cpackinglist") +  " reducing quantity[1]: " + string(lOldQuantity) + " - " + string(strSplit[i].lLoadQuantity) + " = " + String(lOldQuantity - strSplit[i].lLoadQuantity))
			next
		
		next
		
	else
		
		// -----------------------------------------------------------------------------
		// 
		// Die zu beladende Menge ist kleiner als die Gesamtkapazit$$HEX1$$e400$$ENDHEX$$t der Stauorte
		// Den Rest gleichm$$HEX1$$e400$$ENDHEX$$ssig auf die Beh$$HEX1$$e400$$ENDHEX$$lter verteilen
		// 
		// -----------------------------------------------------------------------------
		
		// -----------------------------------------------------------------------------
		// Da immer von der gleichen Menge aus gerechnet werden muss die Daten in einen
		// tempor$$HEX1$$e400$$ENDHEX$$ren Datastore kopieren, da sonst die Belademenge nachjedem Stauort
		// reduziert w$$HEX1$$fc00$$ENDHEX$$rde.
		// -----------------------------------------------------------------------------
		strCompare = strEmpty
		dsTemp.Reset()
		
		if	dsContents.RowsCopy(1, dsContents.RowCount(), Primary!, dsTemp, 1, Primary!) <> 1 then
			of_log("ERROR ROWSCOPY FAILED of_split for " + string(lSPML) + ", trying to copy " + string(dsContents.RowCount()) + " rows")
		end if
		
		for lStowages = 1 to UpperBound(uoTemp)
			
			strSplit = strEmpty
			
			if uoTemp[lStowages].iUse = 0 then continue
			
			of_log("Loop " + string(iCount) + " Adding Values to " + uoTemp[lStowages].sStowage)
			
			for lRows = 1 to dsContents.RowCount()	
				
				if dsTemp.GetItemNumber(lRows, "compute_loading_percentage") > 0 then
					lPos = Upperbound(strSplit) + 1
					strSplit[lPos].lPercentage 		= dsTemp.GetItemNumber(lRows, "compute_loading_percentage") 
					strSplit[lPos].lQuantity			= dsTemp.GetItemNumber(lRows, "nquantity") / iUsedStowages
					strSplit[lPos].lLoadQuantity		= dsTemp.GetItemNumber(lRows, "nquantity") / iUsedStowages
					strSplit[lPos].lRest					= 0
					strSplit[lPos].lRow					= lRows
					strSplit[lPos].lPltype				= dsTemp.GetItemNumber(lRows, "npltype_key")
					strSplit[lPos].lHeight				= dsTemp.GetItemNumber(lRows, "nheight")
					strSplit[lPos].lWidth				= dsTemp.GetItemNumber(lRows, "nwidth")
					strSplit[lPos].sPlType				= dsTemp.GetItemString(lRows, "sys_packinglist_types_ctext")
					strSplit[lPos].sMealcontrolcode	= dsTemp.GetItemString(lRows, "cmeal_control_code")
					strSplit[lPos].sProductiontext	= dsTemp.GetItemString(lRows, "cproduction_text")
					strSplit[lPos].sRemark				= dsTemp.GetItemString(lRows, "cremark")
					strSplit[lPos].sPackinglist		= dsTemp.GetItemString(lRows, "cpackinglist")
					strSplit[lPos].sClass				= dsTemp.GetItemString(lRows, "cclass")
					strSplit[lPos].lClassNumber		= dsTemp.GetItemNumber(lRows, "nclass_number")					
					strSplit[lPos].lSPML					= lSPML
					of_log("Loop " + string(iCount) + "ArrayPos: " + string(lPos) + " has space: " + strSplit[lPos].sPackinglist + " - " + strSplit[lPos].sProductiontext + " : " + string(strSplit[lPos].lLoadQuantity))
				else
					this.of_log("Cannot split[2]: Percentage is set to zero " + dsContents.GetItemString(lRows, "cpackinglist") + " - " + dsContents.GetItemString(lRows, "cproduction_text"))
				end if
				
			next	
			
			// -----------------------------------------------------------
			// 
			// Stauort f$$HEX1$$fc00$$ENDHEX$$llen
			// 
			// -----------------------------------------------------------
			uoTemp[lStowages].of_fill_splitted(strSplit)
			
			// -----------------------------------------------------------
			// Mengen reduzieren
			// -----------------------------------------------------------
			for i = 1 to UpperBound(strSplit)
				//Messagebox("Rest", String(strSplit[i].lLoadQuantity) + " --- " + String(dsContents.GetItemNumber(strSplit[i].lRow, "nquantity")))
				lOldQuantity = dsContents.GetItemNumber(strSplit[i].lRow, "nquantity")
				dsContents.SetItem(strSplit[i].lRow, "nquantity", lOldQuantity - strSplit[i].lLoadQuantity)
				this.of_log(dsContents.GetItemString(strSplit[i].lRow, "cpackinglist") +  " reducing quantity[2]: " + string(lOldQuantity) + " - " + string(strSplit[i].lLoadQuantity) + " = " + String(lOldQuantity - strSplit[i].lLoadQuantity))
			next

						
		next
		
		// -----------------------------------------------------------
		// Nachschaun, ob was $$HEX1$$fc00$$ENDHEX$$brig geblieben ist (durch Rundungen)
		// -----------------------------------------------------------
		// Man nehme das letzte Array aus obiger Schleife, dort finden
		// wir jede St$$HEX1$$fc00$$ENDHEX$$ckliste, die es zu verteilen gilt 1 mal
		// und suchen diese im Datastore mit den restlichen 
		// Komponenten, bei einer Menge > 0 wird die Komponente
		// in einen der Stauorte gepackt
		// -----------------------------------------------------------
		for i = 1 to UpperBound(strSplit)
			
			lFound = dsContents.Find("cpackinglist = '" + strSplit[i].sPackinglist + "'", 1, dsContents.RowCount())
			
			if lFound > 0 then
				
				if dsContents.GetItemNumber(lFound, "nquantity") > 0 then
					strCompare = strEmpty
					
					strCompare[1].lPercentage 			= strSplit[i].lPercentage
					strCompare[1].lQuantity				= strSplit[i].lQuantity
					strCompare[1].lLoadQuantity		= dsContents.GetItemNumber(lFound, "nquantity")
					strCompare[1].lRest					= strSplit[i].lRest
					strCompare[1].lRow					= strSplit[i].lRow
					strCompare[1].lPltype				= strSplit[i].lPltype
					strCompare[1].lHeight				= strSplit[i].lHeight
					strCompare[1].lWidth					= strSplit[i].lWidth
					strCompare[1].sPlType				= strSplit[i].sPlType
					strCompare[1].sMealcontrolcode	= strSplit[i].sMealcontrolcode
					strCompare[1].sProductiontext		= strSplit[i].sProductiontext
					strCompare[1].sRemark				= strSplit[i].sRemark
					strCompare[1].sPackinglist			= strSplit[i].sPackinglist
					strCompare[1].sClass					= strSplit[i].sClass
					strCompare[1].lClassNumber			= strSplit[i].lClassNumber
					strCompare[1].lSPML					= lSPML
					
					// -----------------------------------------------------------
					// 
					// Stauort mit den Resten f$$HEX1$$fc00$$ENDHEX$$llen
					// 
					// -----------------------------------------------------------
					for lStowages = 1 to UpperBound(uoTemp)
						if uoTemp[lStowages].iUse = 1 then
							uoTemp[lStowages].of_fill_splitted(strCompare)
							of_log("Loop " + string(iCount) + " found rest for : " + uoTemp[lStowages].sStowage + " - " + strCompare[1].sPackinglist + " - " + strCompare[1].sProductiontext + " : " + String(strCompare[1].lLoadQuantity))
							// -----------------------------------------------------------
							// Mengen reduzieren
							// -----------------------------------------------------------
							//Messagebox("...........", strSplit[i].lLoadQuantity)
							lOldQuantity = dsContents.GetItemNumber(strCompare[1].lRow, "nquantity")
							dsContents.SetItem(strCompare[1].lRow, "nquantity", lOldQuantity - strCompare[1].lLoadQuantity)
							this.of_log(dsContents.GetItemString(strCompare[1].lRow, "cpackinglist") +  " reducing quantity[3] with rest : " + string(lOldQuantity) + " - " + string(strCompare[1].lLoadQuantity) + " = " + String(lOldQuantity - strCompare[1].lLoadQuantity))
							exit
						end if
						
					next
					
				end if
				
			end if
			
		next
				
	end if
	
loop

// ---------------------------------------------------------
// Alles was nicht verteilt werden konnte in die Errorliste 
// kopieren
// ---------------------------------------------------------
//f_print_datastore(dsContents)

for lRows = dsContents.RowCount() to 1 Step -1
	if dsContents.GetItemNumber(lRows, "nquantity") > 0 and bLast then
		if dsContents.RowsMove(lRows, lRows, Primary!,  this.dsDistributionErrors, this.dsDistributionErrors.RowCount() + 1, Primary!) <> 1 then
			this.of_log("ERROR Rowscopy of_split to ErrorList failed!")
		end if
	end if
next
//MB 15.05.2013 destroy erg$$HEX1$$e400$$ENDHEX$$nzt
destroy dstemp
return 0
end function

public function integer of_split (ref uo_distribution_container uotemp[], ref datastore dscontents, long lspml, boolean blast);// ---------------------------------------------------------
//
// Die gesplittete Verteilung
//
// Die Verteilung erfolgt entsprechend der Beladeprozente
// ggf. $$HEX1$$fc00$$ENDHEX$$ber mehrere Beh$$HEX1$$e400$$ENDHEX$$ltnisse. Das nennt der Fachmann 
// dann Parallelverteilung.
//
// ---------------------------------------------------------
Long 			lRows, &
				lStowages, &
				lMaxFree, &
				lTemp, &
				lPos, &
				lFound, &
				lQuantityToLoad, &
				lOldQuantity, &
				lQuantity, &
				I, J, &
				lSum, &
				lDiff, &
				lNoOfContainers, &
				lNoOfComponentInArray, &
				lNoOfComponentsInDatastore, &
				lRankings[], &
				lCurrentPercentage, &
				lMaxPos, &
				lMaxLoad, &
				lRestOfSplit, &
				lRestQuantity

DataStore	dsTemp

Boolean 		bFound

Long 			lTotal
Decimal 		ldecPercent 

	
String sStowages

sStowages = ""

For lRows =  1 to UpperBound(uoTemp)
	sStowages += uoTemp[lRows].sStowage + "/"
Next

this.of_log("------------------------------------------------------------")
this.of_log(" S P L I T T I N G  ")
this.of_log("------------------------------------------------------------")
this.of_log("Stowage sort: " + sStowages )

uo_distribution_container	uoRanking[]

s_distribution_split strSplit[], strEmpty[], strCompare[]

integer 		iCount, iUsedStowages
String		sPackingList

if dsContents.RowCount() <= 0 then
	this.of_log("No contents to distribute ....")
	return 0
end if

// --------------------------------------------------------
// Wenn nur ein Datensatz im Datastore steht, dann diesen
// zu 100 Prozent verteilen
// --------------------------------------------------------
if dsContents.RowCount() = 1 then
	
	dsContents.SetItem(1, "npercentage", 100)
	sPackingList = dsContents.GetItemString(1, "cpackinglist")
	this.of_log("Only one content [" + sPackingList + "] percentage is 100")
	this.iResetPercentage = 1
	
else
	
	if this.iResetPercentage = 1 then
	
		// -----------------------------------------------------
		// Die Beladeprozente anhand der Belademenge errechnen
		// -----------------------------------------------------
		for i = 1 to dsContents.RowCount()
			lTotal += dsContents.GetItemNumber(i, "nquantity") 
		next
		
		ldecPercent = lTotal / 100
				
		for i = dsContents.RowCount() to 1 Step -1
			
			sPackingList = dsContents.GetItemString(i, "cpackinglist")
			
			if ldecPercent = 0 then
				continue
			end if
			
			this.of_log("Adding percentage [" + string(dsContents.GetItemNumber(i, "nquantity")  / ldecPercent, "0.00") + "%] to " + sPackingList )
		
			if	dsContents.GetItemNumber(i, "nquantity") > 0 then
				dsContents.SetItem(i, "npercentage", dsContents.GetItemNumber(i, "nquantity")  / ldecPercent) 
			else
				dsContents.DeleteRow(i)
			end if
				
		next
		
		this.iResetPercentage = 0
		
	end if
	
end if 

dsTemp = create datastore
dsTemp.dataobject = "dw_uo_cen_out_meals"

If UpperBound(uoTemp) = 0 then
	this.of_log("no stowages found ....")
	bLast = true	
	// ---------------------------------------------------------
	// Keine Stauorte mehr vorhanden !!!
	// Alles was noch im Datastore steht auf die Errorliste 
	// setzen !!!
	// ---------------------------------------------------------
	for lRows = dsContents.RowCount() to 1 Step -1
		if dsContents.GetItemNumber(lRows, "nquantity") > 0 and bLast then
			if dsContents.RowsMove(lRows, lRows, Primary!,  this.dsDistributionErrors, this.dsDistributionErrors.RowCount() + 1, Primary!) <> 1 then
				this.of_log("ERROR Rowscopy of_split to ErrorList failed!")
			end if
		end if
	next
	//MB 15.05.2013 destroy erg$$HEX1$$e400$$ENDHEX$$nzt
	destroy dstemp
	return -1
end if

// -------------------------------------------------------------
// Los gehts in die gro$$HEX1$$df00$$ENDHEX$$e Endlosschleife
// -------------------------------------------------------------
Do while dsContents.RowCount() > 0 

	// ----------------------------------------------------------
	// S$$HEX1$$e400$$ENDHEX$$mtliche Stauorte nach dem verf$$HEX1$$fc00$$ENDHEX$$gbaren Platz abfragen
	// Den kleisten Wert merken (SB, HT, ST  zusammen verteilen)
	// Der Kindsmiller wollts so .....
	// ----------------------------------------------------------
	lMaxFree = 10000
	
	for lStowages = 1 to UpperBound(uoTemp)
		// -------------------------------------------------------
		// Pr$$HEX1$$fc00$$ENDHEX$$fen wieviel der Stauort Maximalkapazit$$HEX1$$e400$$ENDHEX$$t hat
		// den kleinsten Max.wert aller relevanten Stauorte
		// zur Verteilung verwenden
		// -------------------------------------------------------
		lTemp = uoTemp[lStowages].of_availability(1, dsContents)
		
		if lTemp > 0 then
			uoTemp[lStowages].iUse = 1
		else
			uoTemp[lStowages].iUse = 0
			continue
		end if
		
		if lTemp > 0 and lTemp < lMaxFree then
			lMaxFree = lTemp
		end if
				
	next
	
	iUsedStowages = this.of_get_used_stowages(uoTemp)
	// -----------------------------------------------------------
	// Keine freien Stauorte mehr ??? Dann nix wie weg !!!
	// -----------------------------------------------------------
	if iUsedStowages = 0 then
		of_log("Quitting loop because there are no more available stowages !!!")
		exit 
	end if
	// -----------------------------------------------------------
	// Den Loop 10 mal durchlaufen dann raus ... 
	// -----------------------------------------------------------
	iCount ++
	if iCount > 10 then
		of_log("Quitting loop " + string(iCount))
		exit 
	end if
	
	if iCount > 1 then
		this.iResetPercentage = 1
		of_log("Setting ResetPercentageFlag -> iCount = " + string(iCount))
	end if
	
	of_log("Loop " + string(iCount) + " using " + string(iUsedStowages) + " of " + string(Upperbound(uoTemp)) + " stowages")
	of_log("Loop " + string(iCount) + " Maximum is " + string(lMaxFree))
	
	// ----------------------------------------------------------
	// Menge ermitteln
	// ----------------------------------------------------------
	if dsContents.RowCount() = 0 then
		of_log("Loop " + string(iCount) + " - dsContents has a rowcount of 0" )
	end if
	
	lQuantityToLoad = 0
	for lRows = dsContents.RowCount() to 1 Step -1
		
		lQuantity = dsContents.GetItemNumber(lRows, "nquantity")
		
		if lQuantity > 0 then
			lQuantityToLoad += lQuantity
		else
			dsContents.DeleteRow(lRows)
		end if
	
	next

	of_log("Loop " + string(iCount) + " - " + String(lQuantityToLoad) + " components to distribute: ")

	// ----------------------------------------------------------
	// Es ist in keinem Stauort mehr was frei ........
	// ----------------------------------------------------------
	if lMaxFree = 0 then
		of_log("There is no space for " + string(lQuantityToLoad) + " components. Quitting loop")
		exit
	end if
		
	// ---------------------------------------------------------------
	//
	// Die zu beladende Menge ist gr$$HEX2$$f600df00$$ENDHEX$$er als die Staukapazit$$HEX1$$e400$$ENDHEX$$t
	// dann den Beh$$HEX1$$e400$$ENDHEX$$lter prozentual mit den Inhalten f$$HEX1$$fc00$$ENDHEX$$llen
	//
	// ---------------------------------------------------------------
	if lMaxFree * iUsedStowages <= lQuantityToLoad then
	
		for lStowages = 1 to UpperBound(uoTemp)
			
			strSplit = strEmpty
			
			if uoTemp[lStowages].iUse = 0 then continue
			
			of_log("Loop " + string(iCount) + " adding Values to " + uoTemp[lStowages].sStowage)
			
			for lRows = 1 to dsContents.RowCount()	
				
				if dsContents.GetItemNumber(lRows, "compute_loading_percentage") > 0 then
				//if dsContents.GetItemNumber(lRows, "npercentage") > 0 then
					lPos = Upperbound(strSplit) + 1
					strSplit[lPos].lPercentage 		= dsContents.GetItemNumber(lRows, "compute_loading_percentage") 
					//strSplit[lPos].lPercentage 		= dsContents.GetItemNumber(lRows, "npercentage") 
					strSplit[lPos].lQuantity			= dsContents.GetItemNumber(lRows, "nquantity")
					strSplit[lPos].lLoadQuantity		= Ceiling(lMaxFree * strSplit[lPos].lPercentage / 100)
					strSplit[lPos].lRest					= 0
					// -----------------------------------------------------------
					// LoadQuantity darf Quantity nicht $$HEX1$$fc00$$ENDHEX$$bersteigen
					// -----------------------------------------------------------
					if strSplit[lPos].lQuantity < strSplit[lPos].lLoadQuantity then 
						strSplit[lPos].lLoadQuantity 	= strSplit[lPos].lQuantity
						strSplit[lPos].lRest				= 0
					end if
					
					strSplit[lPos].lRow					= lRows
					strSplit[lPos].lPltype				= dsContents.GetItemNumber(lRows, "npltype_key")
					strSplit[lPos].lHeight				= dsContents.GetItemNumber(lRows, "nheight")
					strSplit[lPos].lWidth				= dsContents.GetItemNumber(lRows, "nwidth")
					strSplit[lPos].sPlType				= dsContents.GetItemString(lRows, "sys_packinglist_types_ctext")
					strSplit[lPos].sMealcontrolcode	= dsContents.GetItemString(lRows, "cmeal_control_code")
					strSplit[lPos].sProductiontext	= dsContents.GetItemString(lRows, "cproduction_text")
					strSplit[lPos].sRemark				= dsContents.GetItemString(lRows, "cremark")
					strSplit[lPos].sPackinglist		= dsContents.GetItemString(lRows, "cpackinglist")
					strSplit[lPos].sClass				= dsContents.GetItemString(lRows, "cclass")
					strSplit[lPos].lClassNumber		= dsContents.GetItemNumber(lRows, "nclass_number")
					strSplit[lPos].lSPML					= lSPML
					of_log("Loop " + string(iCount) + " ArrayPos: " + string(lPos) + "  crowded: " + strSplit[lPos].sPackinglist + " - " + strSplit[lPos].sProductiontext + " : " + string(strSplit[lPos].lLoadQuantity))
				else
					this.of_log("Cannot split[1]: Percentage is set to zero " + dsContents.GetItemString(lRows, "cpackinglist") + " - " + dsContents.GetItemString(lRows, "cproduction_text"))
				end if
				
			next	
			
			// -----------------------------------------------------------
			//
			// Rundungsfehler ausmerzen !!!
			//
			// -----------------------------------------------------------
			lSum = 0 
			
			// -----------------------------------------------------------
			// Inhalte addieren
			// -----------------------------------------------------------
			for I = 1 to Upperbound(strSplit)
				lSum += strSplit[i].lLoadQuantity
			next
			
			// -----------------------------------------------------------
			// Differenz ermitteln
			// -----------------------------------------------------------
			lDiff = lMaxFree - lSum
			
			if lDiff > 0 then
			
				for I = 1 to Upperbound(strSplit)
					
					// ---------------------------------------------------------------------------------
					// Ist die errechnete Belademenge ungleich der Beh$$HEX1$$e400$$ENDHEX$$ltniskapazit$$HEX1$$e400$$ENDHEX$$t und es sich nicht
					// um eine Restkapazit$$HEX1$$e400$$ENDHEX$$t handelt, dann die Differenz draufpacken.
					// ---------------------------------------------------------------------------------
					if strSplit[i].lLoadQuantity + lDiff <= strSplit[i].lQuantity and strSplit[i].lRest = 0 then
						
						this.of_log("Adding rest of " + String(lDiff) + " to " + String(strSplit[i].lLoadQuantity) + " of " + strSplit[i].sPackinglist)
						
						strSplit[i].lLoadQuantity += lDiff
						// Messagebox(String(I) + "              " , strSplit[i].sPackinglist + " lDiff = " + string(lDiff)) 
						exit
					end if
					
				next
				
			else
				
				// ---------------------------------------------------------------------------------
				// Es ist mehr im Beh$$HEX1$$e400$$ENDHEX$$lnis als reinpasst (durch Rundung)
				// Die entsprechende Menge von der gr$$HEX1$$f600$$ENDHEX$$ssten Menge abziehen
				// ---------------------------------------------------------------------------------
				lMaxPos  = 0
				lMaxLoad = 0				
				
				for I = 1 to Upperbound(strSplit)
					
					if strSplit[I].lLoadQuantity > lMaxLoad then
						lMaxLoad = strSplit[i].lLoadQuantity 
						lMaxPos	= I
					end if
					
				next
			
			
				// ---------------------------------------------------------------------------------
				// 19.08.2005
				// Bei vielen gemeinsam zu verteilenden Komponenten kann es passieren, dass durch
				// Rundungen lDiff gr$$HEX2$$f600df00$$ENDHEX$$er wird als die gr$$HEX1$$f600$$ENDHEX$$sste Menge einer Position, das hat
				// im Falle von ZE zu negativen Mengen auf den Labels gef$$HEX1$$fc00$$ENDHEX$$hrt, deshalb pr$$HEX1$$fc00$$ENDHEX$$fen
				// auf > 0 sonst einzeln abziehen
				// ---------------------------------------------------------------------------------
				long lInv, lLoop
								
				if lMaxPos > 0 and lDiff < 0 then
					
//					if isnull(lMaxpos) then Messagebox("", "lMaxPos is null") 
//					
//					Messagebox("", "Upperbound(strSplit) = " + String(Upperbound(strSplit)) + "~r" + &
//										"lMaxpos              = " + String(lMaxPos) + "~r" + &
//										"lDiff              = " + String(lDiff) + "~r" + &
//										"lMaxLoad              = " + String(lMaxLoad) )
										
			
					if strSplit[lMaxPos].lLoadQuantity + lDiff > 0 then  
						strSplit[lMaxPos].lLoadQuantity += lDiff
						this.of_log("reducing " + strSplit[lMaxPos].sPackinglist + " with " + string(lDiff) + ", because sum loadquantity is " + string(lSum) + " but there is only " + String(lMaxFree) + " free space!" )
					else
						lInv = lDiff * -1		
						
						i = 1
						
						Do while lInv > 0
							
							if i > UpperBound(strSplit) then i = 1
								
							// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob wir noch einen abziehen k$$HEX1$$f600$$ENDHEX$$nnen
							if strSplit[i].lLoadQuantity - 1 >= 0 then
								strSplit[i].lLoadQuantity --
								lInv --
								this.of_log("reducing " + strSplit[i].sPackinglist + " with 1, still " + string(lInv) + " too much components")
							end if
													
							i ++
							lLoop ++
							
							// ... sicher ist sicher !!
							if lLoop = 100 then 
								this.of_log("there are no more quantities to reduce.")
								exit
							end if 
						loop
						
					end if	
						
				end if
							
			end if
			
			// -----------------------------------------------------------
			// 
			// Stauort f$$HEX1$$fc00$$ENDHEX$$llen
			// 
			// -----------------------------------------------------------
			uoTemp[lStowages].of_fill_splitted(strSplit)
			// -----------------------------------------------------------
			// Mengen reduzieren
			// -----------------------------------------------------------
			for i = 1 to UpperBound(strSplit)
				// Messagebox("Protentual", String(strSplit[i].lLoadQuantity) + " --- " + String(dsContents.GetItemNumber(strSplit[i].lRow, "nquantity")))
				// Messagebox("", "Reduziere um: " + string(strSplit[i].lLoadQuantity))
				//Messagebox("","strSplit[i].lRow = " + string(strSplit[i].lRow) + "~r~r" + "dsContents.RowCount() = " + string(dsContents.RowCount()))
				
				if strSplit[i].lRow <= 0 then 
					this.of_log("Error lRow = 0")
					continue
				end if
				
				lOldQuantity = dsContents.GetItemNumber(strSplit[i].lRow, "nquantity")
				dsContents.SetItem(strSplit[i].lRow, "nquantity", lOldQuantity - strSplit[i].lLoadQuantity)
				this.of_log(dsContents.GetItemString(strSplit[i].lRow, "cpackinglist") +  " reducing quantity[1]: " + string(lOldQuantity) + " - " + string(strSplit[i].lLoadQuantity) + " = " + String(lOldQuantity - strSplit[i].lLoadQuantity))
				this.of_log("Quantity in dsContents = " + string(dsContents.GetItemNumber(strSplit[i].lRow, "nquantity")))
								
			next
		
		next
		
	else
		
		// -----------------------------------------------------------------------------
		// 
		// Die zu beladende Menge ist kleiner als die Gesamtkapazit$$HEX1$$e400$$ENDHEX$$t der Stauorte
		// Den Rest gleichm$$HEX1$$e400$$ENDHEX$$ssig auf die Beh$$HEX1$$e400$$ENDHEX$$lter verteilen
		// 
		// -----------------------------------------------------------------------------
		// -----------------------------------------------------------------------------
		// Da immer von der gleichen Menge aus gerechnet werden muss die Daten in einen
		// tempor$$HEX1$$e400$$ENDHEX$$ren Datastore kopieren, da sonst die Belademenge nachjedem Stauort
		// reduziert w$$HEX1$$fc00$$ENDHEX$$rde.
		// -----------------------------------------------------------------------------
		strCompare = strEmpty
		dsTemp.Reset()
		
		if	dsContents.RowsCopy(1, dsContents.RowCount(), Primary!, dsTemp, 1, Primary!) <> 1 then
			of_log("ERROR ROWSCOPY FAILED of_split for " + string(lSPML) + ", trying to copy " + string(dsContents.RowCount()) + " rows")
		end if
		
		for lStowages = 1 to UpperBound(uoTemp)
			
			strSplit = strEmpty
			
			if uoTemp[lStowages].iUse = 0 then continue
			
			of_log("Loop " + string(iCount) + " Adding Values to " + uoTemp[lStowages].sStowage)
			
			for lRows = 1 to dsContents.RowCount()	
				
				if dsTemp.GetItemNumber(lRows, "compute_loading_percentage") > 0 then
				//if dsTemp.GetItemNumber(lRows, "npercentage") > 0 then
					lPos = Upperbound(strSplit) + 1
					strSplit[lPos].lPercentage 		= dsTemp.GetItemNumber(lRows, "compute_loading_percentage") 
					//strSplit[lPos].lPercentage 		= dsTemp.GetItemNumber(lRows, "npercentage") 
					strSplit[lPos].lQuantity			= dsTemp.GetItemNumber(lRows, "nquantity") / iUsedStowages
					strSplit[lPos].lLoadQuantity		= dsTemp.GetItemNumber(lRows, "nquantity") / iUsedStowages
					strSplit[lPos].lRest					= 0
					strSplit[lPos].lRow					= lRows
					strSplit[lPos].lPltype				= dsTemp.GetItemNumber(lRows, "npltype_key")
					strSplit[lPos].lHeight				= dsTemp.GetItemNumber(lRows, "nheight")
					strSplit[lPos].lWidth				= dsTemp.GetItemNumber(lRows, "nwidth")
					strSplit[lPos].sPlType				= dsTemp.GetItemString(lRows, "sys_packinglist_types_ctext")
					strSplit[lPos].sMealcontrolcode	= dsTemp.GetItemString(lRows, "cmeal_control_code")
					strSplit[lPos].sProductiontext	= dsTemp.GetItemString(lRows, "cproduction_text")
					strSplit[lPos].sRemark				= dsTemp.GetItemString(lRows, "cremark")
					strSplit[lPos].sPackinglist		= dsTemp.GetItemString(lRows, "cpackinglist")
					strSplit[lPos].sClass				= dsTemp.GetItemString(lRows, "cclass")
					strSplit[lPos].lClassNumber		= dsTemp.GetItemNumber(lRows, "nclass_number")					
					strSplit[lPos].lSPML					= lSPML
					of_log("Loop " + string(iCount) + "ArrayPos: " + string(lPos) + " has space: " + strSplit[lPos].sPackinglist + " - " + strSplit[lPos].sProductiontext + " : " + string(strSplit[lPos].lLoadQuantity))
				else
					this.of_log("Cannot split[2]: Percentage is set to zero " + dsContents.GetItemString(lRows, "cpackinglist") + " - " + dsContents.GetItemString(lRows, "cproduction_text"))
				end if
				
			next	
			
			// -----------------------------------------------------------
			// 
			// Stauort f$$HEX1$$fc00$$ENDHEX$$llen
			// 
			// -----------------------------------------------------------
			uoTemp[lStowages].of_fill_splitted(strSplit)
			
			// -----------------------------------------------------------
			// Mengen reduzieren
			// -----------------------------------------------------------
			for i = 1 to UpperBound(strSplit)
				//Messagebox("Rest", String(strSplit[i].lLoadQuantity) + " --- " + String(dsContents.GetItemNumber(strSplit[i].lRow, "nquantity")))
				lOldQuantity = dsContents.GetItemNumber(strSplit[i].lRow, "nquantity")
				dsContents.SetItem(strSplit[i].lRow, "nquantity", lOldQuantity - strSplit[i].lLoadQuantity)
				this.of_log(dsContents.GetItemString(strSplit[i].lRow, "cpackinglist") +  " reducing quantity[2]: " + string(lOldQuantity) + " - " + string(strSplit[i].lLoadQuantity) + " = " + String(lOldQuantity - strSplit[i].lLoadQuantity))
			next

						
		next
		
		// -----------------------------------------------------------
		// Nachschaun, ob was $$HEX1$$fc00$$ENDHEX$$brig geblieben ist (durch Rundungen)
		// -----------------------------------------------------------
		// Man nehme das letzte Array aus obiger Schleife, dort finden
		// wir jede St$$HEX1$$fc00$$ENDHEX$$ckliste, die es zu verteilen gilt 1 mal
		// und suchen diese im Datastore mit den restlichen 
		// Komponenten, bei einer Menge > 0 wird die Komponente
		// in einen der Stauorte gepackt
		// -----------------------------------------------------------
		for i = 1 to UpperBound(strSplit)
			
			lFound = dsContents.Find("cpackinglist = '" + strSplit[i].sPackinglist + "'", 1, dsContents.RowCount())
			
			
			if strSplit[i].sPackinglist = "PDLHE0279" then
				lFound = lFound
			end if
			
			if lFound > 0 then
				
				if dsContents.GetItemNumber(lFound, "nquantity") > 0 then
					
					For lRestOfSplit = 1 to dsContents.GetItemNumber(lFound, "nquantity")
										
//						strCompare = strEmpty
//						
//						strCompare[1].lPercentage 			= strSplit[i].lPercentage
//						strCompare[1].lQuantity				= strSplit[i].lQuantity
//						strCompare[1].lLoadQuantity		= dsContents.GetItemNumber(lFound, "nquantity")
//						strCompare[1].lRest					= strSplit[i].lRest
//						strCompare[1].lRow					= strSplit[i].lRow
//						strCompare[1].lPltype					= strSplit[i].lPltype
//						strCompare[1].lHeight				= strSplit[i].lHeight
//						strCompare[1].lWidth					= strSplit[i].lWidth
//						strCompare[1].sPlType				= strSplit[i].sPlType
//						strCompare[1].sMealcontrolcode	= strSplit[i].sMealcontrolcode
//						strCompare[1].sProductiontext		= strSplit[i].sProductiontext
//						strCompare[1].sRemark				= strSplit[i].sRemark
//						strCompare[1].sPackinglist			= strSplit[i].sPackinglist
//						strCompare[1].sClass					= strSplit[i].sClass
//						strCompare[1].lClassNumber		= strSplit[i].lClassNumber
//						strCompare[1].lSPML					= lSPML
						
						// -----------------------------------------------------------
						// 
						// Stauort mit den Resten f$$HEX1$$fc00$$ENDHEX$$llen
						// 
						// 19.08.2013, KF: Resteverteilung umgebaut.
						//						Vorher	
						// -----------------------------------------------------------
						for lStowages = 1 to UpperBound(uoTemp)
													
							if uoTemp[lStowages].iUse = 1 then
								
								strCompare = strEmpty

								strCompare[1].lPercentage 			= strSplit[i].lPercentage
								strCompare[1].lQuantity				= strSplit[i].lQuantity
								strCompare[1].lLoadQuantity		= 1 
								strCompare[1].lRest					= strSplit[i].lRest
								strCompare[1].lRow					= strSplit[i].lRow
								strCompare[1].lPltype					= strSplit[i].lPltype
								strCompare[1].lHeight				= strSplit[i].lHeight
								strCompare[1].lWidth					= strSplit[i].lWidth
								strCompare[1].sPlType				= strSplit[i].sPlType
								strCompare[1].sMealcontrolcode	= strSplit[i].sMealcontrolcode
								strCompare[1].sProductiontext		= strSplit[i].sProductiontext
								strCompare[1].sRemark				= strSplit[i].sRemark
								strCompare[1].sPackinglist			= strSplit[i].sPackinglist
								strCompare[1].sClass					= strSplit[i].sClass
								strCompare[1].lClassNumber		= strSplit[i].lClassNumber
								strCompare[1].lSPML					= lSPML
									
								
								uoTemp[lStowages].of_fill_splitted(strCompare)
								of_log("Thru Stowages loop #" + string(lStowages) + " found rest for : " + uoTemp[lStowages].sStowage + " - " + strCompare[1].sPackinglist + " - " + strCompare[1].sProductiontext + " : " + String(strCompare[1].lLoadQuantity))
								// -----------------------------------------------------------
								// Mengen reduzieren
								// -----------------------------------------------------------
								//Messagebox("...........", strSplit[i].lLoadQuantity)
								lOldQuantity = dsContents.GetItemNumber(strCompare[1].lRow, "nquantity")
								dsContents.SetItem(strCompare[1].lRow, "nquantity", lOldQuantity - strCompare[1].lLoadQuantity)
								this.of_log(dsContents.GetItemString(strCompare[1].lRow, "cpackinglist") +  " reducing quantity[3] with rest : " + string(lOldQuantity) + " - " + string(strCompare[1].lLoadQuantity) + " = " + String(lOldQuantity - strCompare[1].lLoadQuantity))
								//exit
								lRestQuantity  = dsContents.GetItemNumber(lFound, "nquantity")
								if lRestQuantity = 0 then
									this.of_log(dsContents.GetItemString(strCompare[1].lRow, "cpackinglist") +  " quitting loop because quantity = 0")
									exit
								end if
							end if
							
						next
					
					next
						
				end if
				
			end if
			
		next
				
	end if
	
loop

// ---------------------------------------------------------
// Alles was nicht verteilt werden konnte in die Errorliste 
// kopieren
// ---------------------------------------------------------
//f_print_datastore(dsContents)

for lRows = dsContents.RowCount() to 1 Step -1
	if dsContents.GetItemNumber(lRows, "nquantity") > 0 and bLast then
		if dsContents.RowsMove(lRows, lRows, Primary!,  this.dsDistributionErrors, this.dsDistributionErrors.RowCount() + 1, Primary!) <> 1 then
			this.of_log("ERROR Rowscopy of_split to ErrorList failed!")
		end if
	end if
next
//MB 15.05.2013 destroy erg$$HEX1$$e400$$ENDHEX$$nzt
destroy dstemp
return 0
end function

public function integer of_remove_multiclass_flag ();
// -------------------------------------------------------------
// 08.05.2006
// -------------------------------------------------------------
// Mehrklassige Beh$$HEX1$$e400$$ENDHEX$$ltnisse wurden bisher von der Verteilung
// ausgeschlossen. Jetzt den Flag hierf$$HEX1$$fc00$$ENDHEX$$r resetten und nochmal
// versuchen ggf. Reste zu verteilen.
// -------------------------------------------------------------
Long lStowages

for lStowages = 1 to Upperbound(this.uoStowages)
	
	this.uoStowages[lStowages].iMixed = 0
	
next

return 0
end function

public function integer of_unit_priority (long ldirection, string sclass, uo_distribution_container uousedstowages[]);// -----------------------------------------------
// 
// Beh$$HEX1$$e400$$ENDHEX$$ltnispriorit$$HEX1$$e400$$ENDHEX$$t setzen
// 
// -----------------------------------------------
Long 		lRow, &
			I, &
			lCounter, &
			J, &
			K, &
			lFound, &
			lFoundUnit
			
String	sUnit, sStowage, sEntry, sTouchedStowages[]

Boolean 	bFound

Integer	iEmpty, iFound

// -----------------------------------------------
// Erstmal die ggf. vorhandene Prio resetten, da 
// vom vorangegangenen St$$HEX1$$fc00$$ENDHEX$$cklistentyp noch eine
// Priorit$$HEX1$$e400$$ENDHEX$$t eingetragen sein kann
// -----------------------------------------------
for lRow = 1 to this.dsDistribution.RowCount()
	this.dsDistribution.SetItem(lRow, "nunit_priority", 1000)
next

this.dsDistribution.Sort()

// -----------------------------------------------
// Alle Stauorte gem. der Priorit$$HEX1$$e400$$ENDHEX$$t durch-
// nummerieren
// -----------------------------------------------
for lRow = 1 to this.dsDistributionPriority.RowCount()
	
	sUnit 	= this.dsDistributionPriority.GetItemString(lRow, "cunit")
	iEmpty	= this.dsDistributionPriority.GetItemNumber(lRow, "nempty")
		
	lFoundUnit = this.dsDistributionPriority.Find("cunit = '" + sUnit + "'", lRow + 1,  this.dsDistributionPriority.RowCount())
	
	this.of_log("-------------------------------------------------------------" )
	this.of_log("Unit:" + sUnit + " Empty: " + string(iEmpty) + " lFoundUnit: " + string(lFoundUnit))
	this.of_log("-------------------------------------------------------------" )
	
	if lFoundUnit > 0 then
		this.of_log("     [" + sUnit + "] was found again!!!" )
	end if 
	
	// -------------------------------------------------
	// Die Liste der Stauorte durchlaufen
	// -------------------------------------------------
	for i = 1 to this.dsDistribution.RowCount()
		
		sStowage	 		= this.dsDistribution.GetItemString(i, "cen_galley_cgalley") + "-" + &
							  this.dsDistribution.GetItemString(i, "cen_stowage_cstowage") + " " + &
							  this.dsDistribution.GetItemString(i, "cen_stowage_cplace")
		
		// -------------------------------------------------
		// Treffer, das richtige Beh$$HEX1$$e400$$ENDHEX$$ltnis
		// -------------------------------------------------
		if this.dsDistribution.GetItemString(i, "cen_packinglists_cunit") = sUnit then

			For j = 1 to Upperbound(uoUsedStowages)
				
				if uoUsedStowages[j].sStowage = sStowage then
					
					// -------------------------------------------------
					// Der Normalfall, kein Schalter gesetzt, Beh$$HEX1$$e400$$ENDHEX$$ltnis
					// kommt nicht nochmal vor in der Liste
					// -------------------------------------------------
					if iEmpty = 0 and lFoundUnit = 0 then
						lCounter ++
						this.of_log("     [" + sClass + "] Setting unit priority " + String(lCounter) + " for " + sUnit + " in " + sStowage + " with NO Parameter")
						sTouchedStowages[Upperbound(sTouchedStowages) + 1] = sStowage
						this.dsDistribution.SetItem(i, "nunit_priority", lCounter)
						
					// -----------------------------------------------------
					// Fall 1:
					// Beh$$HEX1$$e400$$ENDHEX$$ltnis muss leer sein, die Abfrage nach bef$$HEX1$$fc00$$ENDHEX$$llten
					// kommt noch
					/// ----------------------------------------------------
					elseif iEmpty = 0 and lFoundUnit > 0 then
										
						lFound = uoUsedStowages[j].dsContent.Find("cclass <> '" + sClass + "' and nspml = 0", 1, uoUsedStowages[j].dsContent.RowCount())								
					
						if lFound = 0 then
											
							lCounter ++
							this.of_log("     [" + sClass + "] Setting unit priority " + String(lCounter) + " for " + sUnit + " in " + sStowage + " with EMPTY Parameter ")
							sTouchedStowages[Upperbound(sTouchedStowages) + 1] = sStowage
							this.dsDistribution.SetItem(i, "nunit_priority", lCounter)
						
						end if
					
					// -----------------------------------------------------
					// Fall 2:
					// Beh$$HEX1$$e400$$ENDHEX$$ltnis kann bereits bef$$HEX1$$fc00$$ENDHEX$$llt sein
					/// ----------------------------------------------------
					elseif iEmpty = 1 then
						
						// Nur verwenden, wenn er nocht nicht mit einem Counter versehen wurde
						// nunit_priority = 1000
						if this.dsDistribution.GetItemNumber(i, "nunit_priority") = 1000 then
							lCounter ++
							this.of_log("     [" + sClass + "] Setting unit priority " + String(lCounter) + " for " + sUnit + " in " + sStowage + " with CAN_BE_FILLED Parameter ")
							sTouchedStowages[Upperbound(sTouchedStowages) + 1] = sStowage
							this.dsDistribution.SetItem(i, "nunit_priority", lCounter)
							
						end if
						
//					else
//						
//						lCounter ++
//						this.of_log("[" + sClass + "] Setting unit priority " + String(lCounter) + " for " + sUnit + " in " + sStowage + " with NO Parameter ")
//						sTouchedStowages[Upperbound(sTouchedStowages) + 1] = sStowage
											
					end if
				
				end if
				
			next
					
		end if
		
	next
	
next

return 0
end function

public function integer of_distribution_joblist (ref datastore dscontents, integer itype);// ---------------------------------------------------
// Erstmal eine Eindeutigkeit herstellen
// Kombinationen aus :	Klasse
//								St$$HEX1$$fc00$$ENDHEX$$cklistentype
//								Verteilerschl$$HEX1$$fc00$$ENDHEX$$ssel
//								Komponentengruppe
// 							Stauortgruppe
// ---------------------------------------------------
Long		lRow, 	&
			lPlType, &	
			lClass, 	&
			lGroup, 	&
			lFound, 	&
			a, &
			i, &
			j, &
			lSort
						
String	sPlType, &
			sMealControlCode, &
			sClass, &
			sFilter, &
			sGroup

s_distribution_parameters 	strParams

DataStore	dsTemp
DataStore	dsData

Integer 	iRet
// ---------------------------------------------------
// Eindeutigkeit herstellen ohne Stauortgruppe
// ---------------------------------------------------
For lRow = 1 to dsContents.RowCount()
	
	lPlType				= dsContents.GetItemNumber(lRow, "npltype_key")
	sPlType				= dsContents.GetItemString(lRow, "sys_packinglist_types_ctext")
	lClass				= dsContents.GetItemNumber(lRow, "nclass_number")
	lGroup				= dsContents.GetItemNumber(lRow, "ncomponent_group")
	sMealControlCode	= dsContents.GetItemString(lRow, "cmeal_control_code")
	sClass				= dsContents.GetItemString(lRow, "cclass")
	
	lFound = this.dsControl.Find("npltype_key=" + string(lPlType) + " and nclass_number=" + string(lClass) + " and cmeal_control_code='" + sMealcontrolCode + "'", 1, this.dsControl.RowCount())			

	if lFound = 0 then
		a = this.dsControl.InsertRow(0)
		this.dsControl.SetItem(a, "npltype_key", lPlType)
		this.dsControl.SetItem(a, "cpl_type", sPlType)
		this.dsControl.SetItem(a, "nclass_number", lClass)
		this.dsControl.SetItem(a, "cmeal_control_code", sMealControlCode)
		this.dsControl.SetItem(a, "cclass", sClass)
		this.dsControl.SetItem(a, "ncomponent_group", lGroup)
		this.dsControl.SetItem(a, "cstowagegroup", "-1")
		this.dsControl.SetItem(a, "ngroupsort", 999)
	end if
	
Next

this.dsControl.SetFilter("")
this.dsControl.Filter()
this.dsControl.Sort()

// ----------------------------------------------------
// Sicherungskopie der Eingangsdaten, wird nach
// manueller Eingabe ben$$HEX1$$f600$$ENDHEX$$tigt
// ----------------------------------------------------
dsData = create datastore
dsData.dataobject = dsContents.dataobject
dsContents.RowsCopy(1, dsContents.Rowcount(), Primary!, dsData, 1, Primary!)

dsTemp = create datastore
dsTemp.dataobject = dsContents.dataobject
dsContents.RowsCopy(1, dsContents.Rowcount(), Primary!, dsTemp, 1, Primary!)
dsContents.Reset()

// f_print_datastore(dsControl)


// ---------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r jede Kombinationen aus	Klasse, St$$HEX1$$fc00$$ENDHEX$$cklistentyp
//	und Verteilerschl$$HEX1$$fc00$$ENDHEX$$ssel nun nachschaun, ob es eine 
// Gruppenzuordnung gibt
// ---------------------------------------------------
Long lDistributionKey, lSPML
Integer iCurrentDivManualLeg 

For lRow = 1 to this.dsControl.RowCount()
	
	lPlType					= this.dsControl.GetItemNumber(lRow, "npltype_key")
	sPlType					= this.dsControl.GetItemString(lRow, "cpl_type")
	lClass					= this.dsControl.GetItemNumber(lRow, "nclass_number")
	lGroup					= this.dsControl.GetItemNumber(lRow, "ncomponent_group")
	sMealControlCode		= this.dsControl.GetItemString(lRow, "cmeal_control_code")
	iCurrentDivManualLeg = Integer(Mid(sMealControlCode, 1, 1))
	sClass					= this.dsControl.GetItemString(lRow, "cclass")

	//sFilter = "npltype_key=" + string(lPlType) + " and nclass_number=" + string(lClass) + " and cmeal_control_code='" + sMealcontrolCode + "' and ncomponent_group = " + string(lGroup)
	sFilter = "npltype_key=" + string(lPlType) + " and nclass_number=" + string(lClass) + " and cmeal_control_code='" + sMealcontrolCode + "'"
	dsTemp.SetFilter(sFilter)
	dsTemp.Filter()
	
	if dsTemp.RowCount() = 0 then
		// Um$$HEX1$$f600$$ENDHEX$$glich
		this.of_log("Error of_distribution_joblist() NO RECORDS for[" + string(iType) + "]: " + sFilter) 
		continue
	end if

	lDistributionKey = dsTemp.GetItemNumber(1, "ndistribution_key")
	
	if lDistributionKey > 0 then
		lDistributionKey = f_get_valid_distribution_key(lDistributionKey, date(dtdeparture)  )
	End If
	
//	if lDistributionKey = 0 then
//		f_print_datastore(dsTemp)
//	end if
	
	
	if iType = 3 then 
		lSPML = 1
	else
		lSPML = 0
	end if
	
	strParams = this.of_get_distribution_parameters_detail(lDistributionKey , sClass, lPlType, sMealControlCode, lSPML)
	
	if strParams.iStatus = -1 then 
		
		this.of_log("ERROR no Distribution Detail Parameters for lDistributionKey = " + String(lDistributionKey) + " Class: " +  sClass + " PlType: " + sPlType + " DistributionCode: " + sMealControlCode + " SPML: " + String(lSPML) + " in of_distribution_joblist()" )
		// ---------------------------------------
		// Es gibt keine Verteilerregel
		// Datens$$HEX1$$e400$$ENDHEX$$tze wieder zur$$HEX1$$fc00$$ENDHEX$$ck in den
		// DataStore schreiben
		// ---------------------------------------
		for i = 1 to dsTemp.RowCount()
			dsTemp.SetItem(i, "cstowagegroup", "-1")
			dsTemp.SetItem(i, "ngroupsort", 999)
		next
		
		dsTemp.RowsCopy(1, dsTemp.Rowcount(), Primary!, dsContents, dsContents.RowCount() + 1, Primary!)		
		
		continue		
		
	end if
	
	// --------------------------------------------
	// Ab hier wird spannend, wenn RowCount > 0 
	// dann gibt es eine Gruppenzuordnung
	// --------------------------------------------
	Long lDivideType
	
//	Messagebox("", strParams.lDistributionDetailkey)
	
	this.dsStowageGroupValues.Retrieve(strParams.lDistributionDetailkey, this.lAircraftKey)
	
//	f_print_datastore(dsStowageGroupValues)
	
//	Messagebox("", sClass + " " + sPlType)
//	
//	if sClass = "EY" and  (sPlType = "TSU" or sPlType = "MCH") then
//		f_print_datastore(dsStowageGroupValues)
//	end if
	
	if sClass <> this.sLastClass or iCurrentDivManualLeg <> this.iDivManualLeg then
		this.bAskAgain = True
		
		for i = 1 to Upperbound(this.lLastValues)
			this.lLastValues[i] = 0
		next
		
	end if
	
	if this.dsStowageGroupValues.RowCount() > 0 then
		
		// ---------------------------------------------
		// lDivideType
		// 1 = Popup, Anwender gibt Verteilung ein
		// 2 = Prozentwert aus Stammdaten
		// 3 = Fester Wert aus Stammdaten
		// ---------------------------------------------
		lDivideType = this.dsStowageGroupValues.GetItemNumber(1, "nvalue_type")
		
		Choose Case lDivideType
				
			case 1
				
				if bAskAgain then
				
					iRet = this.of_divide_manually(dsTemp, dsContents)		
					// ----------------------------------------------
					// Beim Weiterreichen von dsTemp an das Fenster
					// gehen die S$$HEX1$$e400$$ENDHEX$$tze aus dem FilteredBuffer
					// verloren, deshalb dsTemp hier neu f$$HEX1$$fc00$$ENDHEX$$llen
					// ----------------------------------------------
					dsTemp.Reset()
					dsData.RowsCopy(1, dsData.Rowcount(), Primary!, dsTemp, 1, Primary!)
					dsTemp.Filter()
				
				else
				
					iRet = this.of_divide_by_percent(dsTemp, dsContents, 1)
					
				end if
		
				
			case 2
				iRet = this.of_divide_by_percent(dsTemp, dsContents, 0)
				
			case 3
				iRet = this.of_divide_by_fixed_value(dsTemp, dsContents)
				
		End choose
		
	else
		// ---------------------------------------
		// Es gibt keine Zuordnung
		// Datens$$HEX1$$e400$$ENDHEX$$tze wieder zur$$HEX1$$fc00$$ENDHEX$$ck in den
		// DataStore schreiben
		// ---------------------------------------
		for i = 1 to dsTemp.RowCount()
			dsTemp.SetItem(i, "cstowagegroup", "-1")
			dsTemp.SetItem(i, "ngroupsort", 999)
		next
		
		dsTemp.RowsCopy(1, dsTemp.Rowcount(), Primary!, dsContents, dsContents.RowCount() + 1, Primary!)
				
	end if
		
Next

dsContents.SetFilter("")
dsContents.Filter()
dsContents.Sort()

this.dsControl.Reset()

// ---------------------------------------------------
// Eindeutigkeit herstellen mit Stauortgruppe
// ---------------------------------------------------
For lRow = 1 to dsContents.RowCount()
	
	lPlType				= dsContents.GetItemNumber(lRow, "npltype_key")
	sPlType				= dsContents.GetItemString(lRow, "sys_packinglist_types_ctext")
	lClass				= dsContents.GetItemNumber(lRow, "nclass_number")
	lGroup				= dsContents.GetItemNumber(lRow, "ncomponent_group")
	sMealControlCode	= dsContents.GetItemString(lRow, "cmeal_control_code")
	sClass				= dsContents.GetItemString(lRow, "cclass")
	sGroup				= dsContents.GetItemString(lRow, "cstowagegroup")
	lSort					= dsContents.GetItemNumber(lRow, "ngroupsort")
	
	
	lFound = this.dsControl.Find("npltype_key=" + string(lPlType) + &
									" and nclass_number=" + string(lClass) + &
									" and cmeal_control_code='" + sMealcontrolCode + "'" + &
									" and cstowagegroup='" + sGroup + "'" , 1, this.dsControl.RowCount())			

	if lFound = 0 then
		a = this.dsControl.InsertRow(0)
		this.dsControl.SetItem(a, "npltype_key", lPlType)
		this.dsControl.SetItem(a, "cpl_type", sPlType)
		this.dsControl.SetItem(a, "nclass_number", lClass)
		this.dsControl.SetItem(a, "cmeal_control_code", sMealControlCode)
		this.dsControl.SetItem(a, "cclass", sClass)
		this.dsControl.SetItem(a, "ncomponent_group", lGroup)
		this.dsControl.SetItem(a, "cstowagegroup", sGroup)
		this.dsControl.SetItem(a, "ngroupsort", lSort)
	end if
	
Next

this.dsControl.SetFilter("")
this.dsControl.Filter()
this.dsControl.Sort()

// f_print_datastore(this.dsControl)

destroy(dsTemp)
destroy(dsData)

return 0
end function

public function integer of_divide_by_fixed_value (ref datastore dstemp, ref datastore dscontents);// ------------------------------------------------
// 27.05.06
// 
// Stauortgruppenzuordnung $$HEX1$$fc00$$ENDHEX$$ber feste Werte
//
// 05.07.06 $$HEX1$$dc00$$ENDHEX$$berarbeitet, ber$$HEX1$$fc00$$ENDHEX$$cksichtigt Belade-
//          prozente bezogen Gruppenmax. Wert
// ------------------------------------------------

Long	i, &
		j, &
		k, &
		m, &
		lCheckQuantity, &
		lStartQuantity, &
		lQuantity, &
		lValue, &
		lMovedQuantity, &
		lDiff, &
		lRest, &
		lPercent

Integer iUpDown

String 	sPackinglist, &
			sGroup
			
Datastore	dsMover

this.of_log("-------------------------------------------")
this.of_log("          of_divide_by_fixed_value")
this.of_log("-------------------------------------------")
// -------------------------------------------------------------
//
// Aufteilen der Komponenten in die Stauortgruppen
//
// -------------------------------------------------------------
dsMover = create datastore
dsMover.dataobject = dsTemp.dataobject

lCheckQuantity = 0

// f_print_datastore(dsTemp)

for i = 1 to dsTemp.RowCount()
	
	sPackinglist 	= dsTemp.GetItemString(i, "cpackinglist")
	// ----------------------------------------------------------
	// Startmenge merken, um hinterher ggf. Rundungsfehler
	// besser ausmerzen zu k$$HEX1$$f600$$ENDHEX$$nnen
	// ----------------------------------------------------------
	lStartQuantity = dsTemp.GetItemNumber(i, "nquantity")
	this.of_log(sPackinglist + " has a quantity of " + string(lStartQuantity) + " it's component " + string(i) + " of " + string(dsTemp.RowCount()))
	this.of_log("[" + String(i) + "] ----------------------------------------")
	
	// ----------------------------------------------------------
	// 05.07.06
	// Prozentuale Beladung ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
	// ----------------------------------------------------------
	lPercent  = dsTemp.GetItemNumber(i, "npercentage")
	if isnull(lPercent) then lPercent = 100
	if dsTemp.RowCount() = 1 then lPercent = 100
	
	for j = 1 to this.dsStowageGroupValues.RowCount()
		
		lValue 	= this.dsStowageGroupValues.GetItemNumber(j, "nvalue")
		sGroup	= this.dsStowageGroupValues.GetItemString(j, "ctext")
		
		if lValue = 0 then continue
		
		this.of_log(sPackinglist + " - Maxvalue of group " + sGroup + " is " + string(lValue))
		this.of_log(sPackinglist + " - Percentage requested: " + string(lPercent) + " %")
				
		
		
		if iUpDown = 0 then
			iUpDown = 1
			lValue = Ceiling(lValue * lPercent / 100)
			this.of_log(sPackinglist + " - RoundUp: " + string(lValue) + " --> " + string(lPercent))
		else
			iUpDown = 0
			lValue = Truncate(lValue * lPercent / 100,0)
			this.of_log(sPackinglist + " - RoundDown: " + string(lValue))
		end if
				
		lQuantity = dsTemp.GetItemNumber(i, "nquantity") 
		
		if  lQuantity = 0 then continue
		
		dsTemp.RowsCopy(i, i, Primary!, dsMover, dsMover.RowCount() + 1, Primary!)
		
		dsMover.SetItem(dsMover.RowCount(), "cstowagegroup", sGroup)
		dsMover.SetItem(dsMover.RowCount(), "ngroupsort", j)
		
		// ----------------------------------------------------------
		// Wenn der Vorgabewert gr$$HEX1$$f600$$ENDHEX$$sser der Menge der Komponnete ist
		// dann die Menge verwenden
		// ----------------------------------------------------------
		if lQuantity <= lValue then
			dsMover.SetItem(dsMover.RowCount(), "nquantity", lQuantity)
			dsTemp.SetItem(i, "nquantity", 0)
			this.of_log("moved portion of " + string(lQuantity) + " to group " + sGroup )
		// ----------------------------------------------------------
		// Sind mehr Komponenten vorhanden, als in die Gruppe sollen
		// denn den Maximalwert verwenden und die Menge reduzieren
		// ----------------------------------------------------------
		elseif lQuantity > lValue then	
			dsMover.SetItem(dsMover.RowCount(), "nquantity", lValue)
			dsTemp.SetItem(i, "nquantity", lQuantity - lValue)
			this.of_log("moved portion of " + string(lValue) + " to group " + sGroup )
		else
			this.of_log("ERROR moving portions lValue = " + string(lValue) + " lQuantity = " + String(lQuantity) + " to group " + sGroup )
		end if
		
	next
	
	// ---------------------------------------------------------------------
	// So, die Menge der Komponente sollte in die Gruppen verteilt sein, 
	// wenn nicht, dann den Rest in die Default Gruppe packen
	// ---------------------------------------------------------------------
	if dsTemp.GetItemNumber(i, "nquantity") > 0 then
		dsTemp.RowsCopy(i, i, Primary!, dsMover, dsMover.RowCount() + 1, Primary!)
		dsMover.SetItem(dsMover.RowCount(), "cstowagegroup", "-1")
		dsMover.SetItem(dsMover.RowCount(), "ngroupsort", 999)
	end if
	
next

// ----------------------------------------------------------------------------
// Hat wohl alles geklappt, die Komponenten in den Content Datastore kopieren
// ----------------------------------------------------------------------------
this.of_log("Moving " + String(dsMover.Rowcount()) + " rows to content datastore")
dsMover.RowsCopy(1, dsMover.Rowcount(), Primary!, dsContents, dsContents.RowCount() + 1, Primary!)
Destroy(dsMover)

return 0
end function

public function integer of_divide_manually (ref datastore dstemp, ref datastore dscontents);// ------------------------------------------------
// 27.05.06
// 
// Manuelle Stauortgruppenzuordnung
//
// ------------------------------------------------
s_distribution_divide_manually strOpen
Long 			I
DataStore	dsOld
String		sClass 

strOpen.uoDistribution 			= this
strOpen.dsContents				= dsTemp
strOpen.dsStowageGroupValues	= this.dsStowageGroupValues
strOpen.sLastClass				= this.sLastClass
strOpen.lLastValues				= this.lLastValues
strOpen.bAskAgain					= this.bAskAgain
strOpen.lAircraftKey				= this.lAircraftKey

if isvalid(w_manual_distribution) then w_manual_distribution.SetRedraw(true)
openwithparm(w_manual_distribution_divide_manually, strOpen)
if isvalid(w_manual_distribution) then w_manual_distribution.SetRedraw(false)

strOpen = Message.PowerObjectParm

// ----------------------------------------------------------------------------
// Fenster geschlossen ohnen zu speichern
// ----------------------------------------------------------------------------
if not isvalid(strOpen) or strOpen.bSuccessful = false then
	
	for i = 1 to dsTemp.RowCount()
		dsTemp.SetItem(i, "cstowagegroup", "-1")
		dsTemp.SetItem(i, "ngroupsort", 999)
	next
	
	dsTemp.RowsCopy(1, dsTemp.Rowcount(), Primary!, dsContents, dsContents.RowCount() + 1, Primary!)
	
else
	
	// ----------------------------------------------------------------------------
	// Hat wohl alles geklappt, die Komponenten in den Content Datastore kopieren
	// ----------------------------------------------------------------------------
	strOpen.dsContents.RowsCopy(1, strOpen.dsContents.Rowcount(), Primary!, dsContents, dsContents.RowCount() + 1, Primary!)
	this.bAskAgain 			= strOpen.bAskAgain
	this.sLastClass			= strOpen.sLastClass
	this.lLastValues			= strOpen.lLastValues
	this.bLastGroupValues 	= strOpen.bLastGroupValues
	this.iDivManualLeg		= strOpen.iLastLeg
	
end if

return 0
end function

public function integer of_sort_by_max_free_space (long lrow, datastore dscomponents, ref uo_distribution_container uosort[]);Long			lEmpty[], a, i
Datastore 	dsTemp
String		sSorter
uo_distribution_container	uoTemp[], uoEmpty[]


uoTemp = uoSort
uoSort = uoEmpty

dsTemp = create datastore
dsTemp.dataobject = "dw_uo_sort_by_free_space"

this.of_log("------ old sort --------------")

for i = 1 to UpperBound(uoTemp)
	
	a = dsTemp.InsertRow(0)
	dsTemp.SetItem(a, "cstowage", uoTemp[i].sStowage)
	dsTemp.SetItem(a, "nfree", uoTemp[i].of_availability(lRow, dsComponents))
	dsTemp.SetItem(a, "nsort", uoTemp[i].lLoadRow)
	dsTemp.SetItem(a, "npos", i)
	
	this.of_log(uoTemp[i].sStowage + " with free space of " + String(dsTemp.GetItemNumber(a, "nfree")) )
	
next

dsTemp.Sort()

this.of_log("------ new sort --------------")

for i = 1 to dsTemp.RowCount()
		
	uoSort[i] = uoTemp[dsTemp.GetItemNumber(i, "npos")]
	
	this.of_log(uoSort[i].sStowage + " with free space of " + String(dsTemp.GetItemNumber(i, "nfree")) )
		
next

this.of_log("------------------------------")
//MB 15.05.2013 destroy erg$$HEX1$$e400$$ENDHEX$$nzt
destroy dstemp
return 0


end function

public function integer of_sort_array (long larray[], integer ldirection);Long			lEmpty[], a, i
Datastore 	dsTemp
String		sSorter

// -----------------------------------------------
// Wenn es sich um eine MCD Verteilung handelt
// dann wird nicht sortiert 
// -----------------------------------------------
if this.iMCD = 1 then
	return 0
end if


dsTemp = create datastore
dsTemp.dataobject = "dw_uo_sort"

if lDirection = 1 then
	sSorter = "nsort A"
else
	sSorter = "nsort D"
end if

for i = 1 to UpperBound(lArray)
	
	a = dsTemp.InsertRow(0)
	dsTemp.SetItem(a, "nsort", lArray[i])
	
next

dsTemp.SetSort(sSorter)
dsTemp.Sort()

for i = 1 to dsTemp.RowCount()
		
	lEmpty[UpperBound(lEmpty) + 1] = dsTemp.GetItemNumber(i, "nsort")
		
next

lArray = lEmpty
Destroy(dsTemp)

return 0


end function

public function integer of_divide_by_percent (ref datastore dstemp, ref datastore dscontents, integer ireusevalues);// ------------------------------------------------
// 27.05.06
// 
// Stauortgruppenzuordnung $$HEX1$$fc00$$ENDHEX$$ber Prozentwerte
//
// ------------------------------------------------

Long	i, &
		j, &
		k, &
		m, &
		lCheckQuantity, &
		lStartQuantity, &
		lQuantity, &
		lPercent
		
String 	sPackinglist, &
			sGroup, &
			sClass
	
Long 	lDiff = 0, &
		lMax 	= 0, &
		lPos 	= 0	


Datastore	dsMover
Datastore	dsCheck

this.of_log("-------------------------------------------")
this.of_log("  Start    of_divide_by_percent")
this.of_log("-------------------------------------------")

if dsTemp.RowCount() = 0 then
	this.of_log("RowCount = 0")
	return 0
end if
	
// ----------------------------------------------------------------
// Prozent-Werte der letzten manuellen Aufteilung wiederverwenden
// ----------------------------------------------------------------
if iReUseValues = 1 then
	
	dsCheck = create Datastore
	
	dsCheck.SetFullState(this.bLastGroupValues)
	
	if dsCheck.RowCount() > 0 then
		this.of_log("of_devide_by_percent is reusing values for Class: " + dsTemp.GetItemString(1, "cclass"))
		
		for i = 1 to dsCheck.RowCount()
			this.of_log(dsCheck.GetItemString(i, "ctext") + " = [" + string(dsCheck.GetItemnumber(i, "nvalue")) + "]" )
		next
		
		this.dsStowageGroupValues.Reset()
		
		dsCheck.RowsCopy(1,dsCheck.RowCount(), Primary!, this.dsStowageGroupValues, 1, Primary!)
		
	else
		this.of_log("of_devide_by_percent is reusing values failed, no old values found")
	end if
	
	destroy(dsCheck)
	
end if 

// -------------------------------------------------------------
// Alle Prozentwerte aufaddieren, bei einem Ergebnis <> 100
// alle Komponenten in die Standardgruppe packen.
// -------------------------------------------------------------
For i = 1 to this.dsStowageGroupValues.RowCount()
	lCheckQuantity += this.dsStowageGroupValues.GetItemNumber(i, "nvalue")
Next

if lCheckQuantity <> 100 then 
	this.of_log("ERROR of_devide_by_percent, sum of percentage is " + string(lCheckQuantity))
	
	// f_print_datastore(dsStowageGroupValues)
	
	for i = 1 to dsTemp.RowCount()
		dsTemp.SetItem(i, "cstowagegroup", "-1")
		dsTemp.SetItem(i, "ngroupsort", 999)
	next
		
	dsTemp.RowsCopy(1, dsTemp.Rowcount(), Primary!, dsContents, dsContents.RowCount() + 1, Primary!)
	return 0
	
end if


// -------------------------------------------------------------
//
// Aufteilen der Komponenten in die Stauortgruppen
//
// -------------------------------------------------------------
dsMover = create datastore
dsMover.dataobject = dsTemp.dataobject

lCheckQuantity = 0

for i = 1 to dsTemp.RowCount()
	
	sPackinglist 	= dsTemp.GetItemString(i, "cpackinglist")
	lCheckQuantity = 0
	// ----------------------------------------------------------
	// Startmenge merken, um hinterher ggf. Rundungsfehler
	// besser ausmerzen zu k$$HEX1$$f600$$ENDHEX$$nnen
	// ----------------------------------------------------------
	lStartQuantity = dsTemp.GetItemNumber(i, "nquantity")
	this.of_log(sPackinglist + " has a quantity of " + string(lStartQuantity))
	
	for j = 1 to this.dsStowageGroupValues.RowCount()
		
		lPercent = this.dsStowageGroupValues.GetItemNumber(j, "nvalue")
		sGroup	= this.dsStowageGroupValues.GetItemString(j, "ctext")
		
		if  lPercent = 0 then continue
		
		lQuantity = Round(lStartQuantity * lPercent / 100, 0)
		
		dsTemp.RowsCopy(i, i, Primary!, dsMover, dsMover.RowCount() + 1, Primary!)
		
		dsMover.SetItem(dsMover.RowCount(), "cstowagegroup", sGroup)
		dsMover.SetItem(dsMover.RowCount(), "ngroupsort", j)
		dsMover.SetItem(dsMover.RowCount(), "nquantity", lQuantity)
		
		lCheckQuantity += lQuantity
		
		this.of_log("moved portion of " + string(lQuantity) + " to group " + sGroup )
		
	next
	
	// -------------------------------------------------------
	// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob durch Rundungsfehler mehr verteilt wurde 
	// als urspr$$HEX1$$fc00$$ENDHEX$$nglich vorhanden war.
	// -------------------------------------------------------
	lDiff = 0
	lMax 	= 0
	lPos 	= 0
	
	lDiff = lStartQuantity - lCheckQuantity
	
	if lDiff <> 0 then
		
		this.of_log(String(lDiff) + " = " + String(lStartQuantity) + " - " + String(lCheckQuantity))
		
		this.of_log("rounding error of " + string(lDiff) + " for " + sPackinglist + " was found")
		
		// --------------------------------------------------------
		// Die Rundungsdifferenz von der gr$$HEX2$$f600df00$$ENDHEX$$ten Menge abziehen
		// oder zu addieren. Dazu erstmal gr$$HEX1$$f600$$ENDHEX$$sste Menge ermittelen
		// --------------------------------------------------------
		this.of_log("dsMover has "  + string(dsMover.RowCount()) + " entries, k is at " + string(k))
		
		For k = 1 to dsMover.RowCount()
						
			if dsMover.GetItemString(k, "cpackinglist") = sPackinglist then
			
				if lMax <= dsMover.GetItemNumber(k, "nquantity") then 
					lPos = k
					lMax = dsMover.GetItemNumber(k, "nquantity")		
					
					this.of_log("Found new max entry for " + dsMover.GetItemString(k, "cpackinglist") + ", lMax now "  + string(lMax) + " lPos now " + string(lPos))
					
				end if
				
			end if
			
		Next
		
		// -----------------------------------------------------
		// Es wurde keine Position gefunden oder die gefundene
		// Position ist zu klein, dann alles in die Standard-
		// gruppe packen
		// -----------------------------------------------------
		if lPos = 0 or (lMax - lDiff <= 0) then
			
			this.of_log("couldn't eliminate rounding error for "  + sPackinglist + ", Diff = " + string(lDiff) + " Max =  " + string(lMax) )
			
			for m = 1 to dsTemp.RowCount()
				dsTemp.SetItem(m, "cstowagegroup", "-1")
				dsTemp.SetItem(m, "ngroupsort", 999)
			next
		
			dsTemp.RowsCopy(1, dsTemp.Rowcount(), Primary!, dsContents, dsContents.RowCount() + 1, Primary!)
			return 0
			
		else
			
			Long lOldValue, lNewValue
			
			lOldValue = dsMover.GetItemNumber(lPos, "nquantity")	
			lNewValue = lOldValue + lDiff
			
			dsMover.SetItem(lPos, "nquantity", lNewValue)
			
			this.of_log("Rounding Error fixed. Changed " + string(lOldValue) + " to " + string(lNewValue))
			
		end if
		
	end if 
	
next

// ----------------------------------------------------------------------------
// Hat wohl alles geklappt, die Komponenten in den Content Datastore kopieren
// ----------------------------------------------------------------------------
this.of_log("Moving " + String(dsMover.Rowcount()) + " rows to content datastore")
dsMover.RowsCopy(1, dsMover.Rowcount(), Primary!, dsContents, dsContents.RowCount() + 1, Primary!)
Destroy(dsMover)

this.of_log("-------------------------------------------")
this.of_log("  Done    of_divide_by_percent")
this.of_log("-------------------------------------------")


return 0
end function

public function integer of_reset_percentage (integer itype);// ---------------------------------------------------
//
// Beladeprozente auf Null setzen, npercent wird 
// von of_split neu ausgerechnet
//
// ---------------------------------------------------
datastore 	dsComponents
Long			lRow
// ---------------------------------------------------
// Parameter iType
// 1 = Mahlzeiten
// 2 = Extrabeladung
// ---------------------------------------------------
if iType = 1 then
	dsComponents 	= this.dsMeals
elseif iType = 2 then
	dsComponents 	= this.dsAdditional
else
	return -1
end if 

for lRow = 1 to dsComponents.RowCount()
	
	dsComponents.SetItem(lRow, "npercentage",0)
	
next

return 0
end function

public function integer of_divide_by_fixed_value_old (ref datastore dstemp, ref datastore dscontents);// ------------------------------------------------
// 27.05.06
// 
// Stauortgruppenzuordnung $$HEX1$$fc00$$ENDHEX$$ber feste Werte
//
// ------------------------------------------------

Long	i, &
		j, &
		k, &
		m, &
		lCheckQuantity, &
		lStartQuantity, &
		lQuantity, &
		lValue
		
String 	sPackinglist, &
			sGroup
			
Datastore	dsMover

this.of_log("-------------------------------------------")
this.of_log("          of_divide_by_fixed_value")
this.of_log("-------------------------------------------")
// -------------------------------------------------------------
//
// Aufteilen der Komponenten in die Stauortgruppen
//
// -------------------------------------------------------------
dsMover = create datastore
dsMover.dataobject = dsTemp.dataobject

lCheckQuantity = 0

// f_print_datastore(dsTemp)

for i = 1 to dsTemp.RowCount()
	
	sPackinglist 	= dsTemp.GetItemString(i, "cpackinglist")
	// ----------------------------------------------------------
	// Startmenge merken, um hinterher ggf. Rundungsfehler
	// besser ausmerzen zu k$$HEX1$$f600$$ENDHEX$$nnen
	// ----------------------------------------------------------
	lStartQuantity = dsTemp.GetItemNumber(i, "nquantity")
	this.of_log(sPackinglist + " has a quantity of " + string(lStartQuantity) + " it's component " + string(i) + " of " + string(dsTemp.RowCount()))
	
	for j = 1 to this.dsStowageGroupValues.RowCount()
		
		lValue 	= this.dsStowageGroupValues.GetItemNumber(j, "nvalue")
		sGroup	= this.dsStowageGroupValues.GetItemString(j, "ctext")
		
		if  lValue = 0 then continue
		
		lQuantity = dsTemp.GetItemNumber(i, "nquantity") 
		
		if  lQuantity = 0 then continue
		
		dsTemp.RowsCopy(i, i, Primary!, dsMover, dsMover.RowCount() + 1, Primary!)
		
		dsMover.SetItem(dsMover.RowCount(), "cstowagegroup", sGroup)
		dsMover.SetItem(dsMover.RowCount(), "ngroupsort", j)
		
		// ----------------------------------------------------------
		// Wenn der Vorgabewert gr$$HEX1$$f600$$ENDHEX$$sser der Menge der Komponnete ist
		// dann die Menge verwenden
		// ----------------------------------------------------------
		if lQuantity <= lValue then
			dsMover.SetItem(dsMover.RowCount(), "nquantity", lQuantity)
			dsTemp.SetItem(i, "nquantity", 0)
			this.of_log("moved portion of " + string(lQuantity) + " to group " + sGroup )
		// ----------------------------------------------------------
		// Sind mehr Komponenten vorhanden, als in die Gruppe sollen
		// denn den Maximalwert verwenden und die Menge reduzieren
		// ----------------------------------------------------------
		elseif lQuantity > lValue then	
			dsMover.SetItem(dsMover.RowCount(), "nquantity", lValue)
			dsTemp.SetItem(i, "nquantity", lQuantity - lValue)
			this.of_log("moved portion of " + string(lValue) + " to group " + sGroup )
		else
			this.of_log("ERROR moving portions lValue = " + string(lValue) + " lQuantity = " + String(lQuantity) + " to group " + sGroup )
		end if
		
	next
	
	// ---------------------------------------------------------------------
	// So, die Menge der Komponente sollte in die Gruppen verteilt sein, 
	// wenn nicht, dann den Rest in die Default Gruppe packen
	// ---------------------------------------------------------------------
	if dsTemp.GetItemNumber(i, "nquantity") > 0 then
		dsTemp.RowsCopy(i, i, Primary!, dsMover, dsMover.RowCount() + 1, Primary!)
		dsMover.SetItem(dsMover.RowCount(), "cstowagegroup", "-1")
		dsMover.SetItem(dsMover.RowCount(), "ngroupsort", 999)
	end if
	
next

// ----------------------------------------------------------------------------
// Hat wohl alles geklappt, die Komponenten in den Content Datastore kopieren
// ----------------------------------------------------------------------------
this.of_log("Moving " + String(dsMover.Rowcount()) + " rows to content datastore")
dsMover.RowsCopy(1, dsMover.Rowcount(), Primary!, dsContents, dsContents.RowCount() + 1, Primary!)
Destroy(dsMover)

return 0
end function

public function integer of_combine_spmls_old ();// ---------------------------------------------------------------------
// 09.05.2006 
// Kummulierte SPML nicht wieder in die Einzelteile zerlegen, sondern 
// Alle mit dem Typ & Text SPML versehen
// Problem:
// Werden viele unterschiedliche SPML-Typen mit Menge 1 beladen und
// sollen diese dann parallel verteilt werden, dann landen alle im 
// gleichen (ersten) Behaltnis. CR: ZD-CR-1028
//
// L$$HEX1$$f600$$ENDHEX$$sung: 
// Alle SPML's zun$$HEX1$$e400$$ENDHEX$$chst kummulieren (of_acculumate_spmls), dann verteilen 
// und am Ende dann wieder die Detailinformationen zuspielen.
// ---------------------------------------------------------------------
Long a, lStowages, I, J, K
String	sType

this.of_log("Entering of_combine_spmls ......")

// ------------------------------------------------------------------
// Stauort f$$HEX1$$fc00$$ENDHEX$$r Stauort beackern
// ------------------------------------------------------------------
for lStowages = 1 to Upperbound(this.uoStowages)
	
	this.uoStowages[lStowages].dsContent.SetFilter("nspml=1")
	this.uoStowages[lStowages].dsContent.Filter()
	
	if this.uoStowages[lStowages].dsContent.RowCount() <= 0 then 
		this.uoStowages[lStowages].dsContent.SetFilter("")
		this.uoStowages[lStowages].dsContent.Filter()
		continue
	end if
	
	// ------------------------------------------------------------------
	// OK, es sind SPML's im Stauort. Diese jetzt in den Details suchen
	// und von dort in den Stauort zur$$HEX1$$fc00$$ENDHEX$$ckholen
	// ------------------------------------------------------------------
	this.of_log("Stowage: " + this.uoStowages[lStowages].sStowage + " contains " + string(this.uoStowages[lStowages].dsContent.RowCount()) + " SPML's" )
	
	For I = this.uoStowages[lStowages].dsContent.RowCount() to 1 step -1
		
		sType = this.uoStowages[lStowages].dsContent.GetItemString(I, "cpl_type")
		
		this.uoStowages[lStowages].dsContent.SetItem(I, "cpackinglist", "       ")
		this.uoStowages[lStowages].dsContent.SetItem(I, "ctext", "SPML " + sType)

	Next
		
	this.uoStowages[lStowages].dsContent.SetFilter("")
	this.uoStowages[lStowages].dsContent.Filter()
		
Next

// f_print_datastore(this.dsSPMLDistributionMaster)

return 0
end function

public function integer of_combine_spmls ();// ---------------------------------------------------------------------
// 09.05.2006 
// Kummulierte SPML nicht wieder in die Einzelteile zerlegen, sondern 
// Alle mit dem Typ & Text SPML versehen
// Problem:
// Werden viele unterschiedliche SPML-Typen mit Menge 1 beladen und
// sollen diese dann parallel verteilt werden, dann landen alle im 
// gleichen (ersten) Behaltnis. CR: ZD-CR-1028
//
// L$$HEX1$$f600$$ENDHEX$$sung: 
// Alle SPML's zun$$HEX1$$e400$$ENDHEX$$chst kummulieren (of_acculumate_spmls), dann verteilen 
// und am Ende dann wieder die Detailinformationen zuspielen.
// ---------------------------------------------------------------------
Long 			a, lStowages, I, J, K, lQuantity, lMovedQuantity
Long 			lPlType, lClass, lFound
String			sType
String 		sPlType, sMealControlCode, sClass, sFilter, sPackinglist
Long 			lPlTypeMaster				
String 		sPlTypeMaster				
Long 			lClassMaster				
String 		sMealControlCodeMaster	
String 		sClassMaster	
String 		sPLMaster	
Long 			lHeight
Long 			lWidth
Datastore 	dsSPMLControl, dsTemp

dsTemp = create datastore
dsTemp.dataobject = "dw_ou_cen_out_meals"

this.of_log("Entering of_explode_spmls ......")

// ------------------------------------------------------------------
// Stauort f$$HEX1$$fc00$$ENDHEX$$r Stauort beackern
// ------------------------------------------------------------------
for lStowages = 1 to Upperbound(this.uoStowages)
	
	this.uoStowages[lStowages].dsContent.SetFilter("nspml=1")
	this.uoStowages[lStowages].dsContent.Filter()
	
	if this.uoStowages[lStowages].dsContent.RowCount() <= 0 then 
		this.uoStowages[lStowages].dsContent.SetFilter("")
		this.uoStowages[lStowages].dsContent.Filter()
		continue
	end if
	
	// ------------------------------------------------------------------
	// OK, es sind SPML's im Stauort. Diese jetzt in den Details suchen und von dort in den Stauort zur$$HEX1$$fc00$$ENDHEX$$ckholen
	// ------------------------------------------------------------------
	this.of_log("Stowage: " + this.uoStowages[lStowages].sStowage + " contains " + string(this.uoStowages[lStowages].dsContent.RowCount()) + " SPML's" )
	
	For I = this.uoStowages[lStowages].dsContent.RowCount() to 1 step -1
		
		sType = this.uoStowages[lStowages].dsContent.GetItemString(I, "cpl_type")
		
		this.uoStowages[lStowages].dsContent.SetItem(I, "cpackinglist", "       ")
		this.uoStowages[lStowages].dsContent.SetItem(I, "ctext", "SPML " + sType)

	Next
		
	this.uoStowages[lStowages].dsContent.SetFilter("")
	this.uoStowages[lStowages].dsContent.Filter()
		
Next

// ------------------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung der "wirklichen" SPML's gegen die verteilten Mengen alles was  in der Liste bleibt muss auf die Fehlerliste
// Stauort f$$HEX1$$fc00$$ENDHEX$$r Stauort beackern
// ------------------------------------------------------------------
for lStowages = 1 to Upperbound(this.uoStowages)
	
	this.uoStowages[lStowages].dsContent.SetFilter("nspml=1")
	this.uoStowages[lStowages].dsContent.Filter()
	
	if this.uoStowages[lStowages].dsContent.RowCount() <= 0 then 
		this.uoStowages[lStowages].dsContent.SetFilter("")
		this.uoStowages[lStowages].dsContent.Filter()
		continue
	end if
	
	// ------------------------------------------------------------------
	// OK, es sind SPML's im Stauort. Diese jetzt in den Details suchen und von dort in den Stauort zur$$HEX1$$fc00$$ENDHEX$$ckholen
	// ------------------------------------------------------------------
	this.of_log("Stowage: " + this.uoStowages[lStowages].sStowage + " contains " + string(this.uoStowages[lStowages].dsContent.RowCount()) + " SPML's" )
	
	For I = this.uoStowages[lStowages].dsContent.RowCount() to 1 step -1
		
		lQuantity 			= 0
		lMovedQuantity 	= 0
		// F$$HEX1$$fc00$$ENDHEX$$r jedes kummulierte SPML, dass im Stauort ist die passenden Details rausfiltern
		sPackinglist			= this.uoStowages[lStowages].dsContent.GetItemString(I, "cpackinglist")
		lPlType				= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "npltype_key")
		sPlType				= this.uoStowages[lStowages].dsContent.GetItemString(I, "cpl_type")
		lClass					= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nclass_number")
		sMealControlCode	= this.uoStowages[lStowages].dsContent.GetItemString(I, "cmeal_control_code")
		sClass				= this.uoStowages[lStowages].dsContent.GetItemString(I, "cclass")
		lQuantity				= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nquantity")
		lHeight				= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nheight")
		lWidth				= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nwidth")

		this.of_log("[" + String(I) + "] - SPML Content " + String(lQuantity) + " x " + sPackinglist)
				
		this.dsSPMLDistributionMaster.SetFilter("npltype_key=" + string(lPlType) + &
												" and nclass_number=" + string(lClass) + &
												" and cmeal_control_code='" + sMealcontrolCode + "'" + & 
												" and nheight = " + string(lHeight)  + &
												" and nwidth = " + string(lWidth)  + &
												" and nquantity > 0")
												
		this.dsSPMLDistributionMaster.Filter()		
		
		if this.dsSPMLDistributionMaster.RowCount() = 0 then
			this.of_log("[" + String(I) + "] - Found no Details for " + sPlType + "/" + String(lPlType) + " + " + sClass + "/" + string(lClass) + " + " + sMealcontrolCode + "  Height " + String(lHeight)  + " Width " + string(lWidth))
		end if
		
		for j = 1 to this.dsSPMLDistributionMaster.RowCount()
			
			lMovedQuantity = this.dsSPMLDistributionMaster.GetItemNumber(j, "nquantity")
			sPLMaster		= this.dsSPMLDistributionMaster.GetItemString(j, "cpackinglist")
			
			this.of_log("[" + String(I) + "] - Found   " + String(lMovedQuantity) + " x " + sPLMaster)
			
			if lMovedQuantity = 0 then continue
			if lQuantity = 0 then exit
			
			// ------------------------------------------------
			// lQuantity 			= Anzahl SPML's im Stauort
			// lMovedQuantity = tats$$HEX1$$e400$$ENDHEX$$chliche Anzahl SPML's 
			// ------------------------------------------------
			// Passen alle rein:   3    <=    5
			// ------------------------------------------------
			if lMovedQuantity <= lQuantity then
				
				this.of_log("[1][" + String(I) + "] - Added   " + String(lMovedQuantity) + " x " + sPLMaster)
				this.dsSPMLDistributionMaster.SetItem(j, "nquantity", 0)
				this.of_log("[1][" + String(I) + "] - Stowage now Contains: " + string(this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nquantity")) + " SPML's")
				
				lQuantity = lQuantity - lMovedQuantity
								
			// ------------------------------------------------					
			// Passt nur ein Teil rein:   2             1
			// ------------------------------------------------
			elseif lMovedQuantity > lQuantity then
				this.of_log("[2][" + String(I) + "] - Added   " + String(lQuantity) + " x " + sPLMaster)
				this.dsSPMLDistributionMaster.SetItem(j, "nquantity", lMovedQuantity - lQuantity)
				lQuantity = 0
				this.of_log("[2][" + String(I) + "] - Stowage now Contains: " + string(this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nquantity")) + " SPML's")
				
			else
				this.of_log("[2][" + String(I) + "] -	ELSE ??  lMovedQuantity=" + String(lMovedQuantity) + " lQuantity=" + String(lQuantity))
			end if
		next
	Next
		
	this.uoStowages[lStowages].dsContent.SetFilter("")
	this.uoStowages[lStowages].dsContent.Filter()
Next

this.dsSPMLDistributionMaster.SetFilter("")
this.dsSPMLDistributionMaster.Filter()	

//f_print_datastore(dsSPMLDistributionMaster)

For I = this.dsSPMLDistributionMaster.RowCount() to 1 step -1
	if this.dsSPMLDistributionMaster.GetItemNumber(I, "nquantity") = 0 then
		this.dsSPMLDistributionMaster.DeleteRow(I)
	else
		sPLMaster = this.dsSPMLDistributionMaster.GetItemString(I, "cpackinglist") 
		lQuantity = this.dsSPMLDistributionMaster.GetItemNumber(I, "nquantity") 
		this.of_log("Can't remove " + sPLMaster + " quantity is still " + string(lQuantity) + " this item should be shown on the error list")
	end if
Next

// ------------------------------------------------------------------------
// Alles wieder in dsSPMLDistribution, damit ggf. Reste auf der Fehlerliste landen
// ------------------------------------------------------------------------
//f_print_datastore(this.dsSPMLDistribution)
this.dsSPMLDistribution.SetFilter("")
this.dsSPMLDistribution.Filter()	
this.dsSPMLDistribution.Reset()
//f_print_datastore(this.dsSPMLDistribution)

if this.dsSPMLDistributionMaster.RowCount() > 0 then
	this.dsSPMLDistributionMaster.RowsCopy(1, this.dsSPMLDistributionMaster.RowCount(), Primary!, this.dsSPMLDistribution, 1, Primary!)
end if 

return 0
end function

public function integer of_format_datastore_report (datastore odw, string sreporttitle);integer 		iDWWidth, &
				iDWHeight, &
				iDetailX, &
				iDetailY
long			lXpos
blob			bl_report
integer 		iMarginTop,iMarginBottom,iMarginLeft,iMarginRight
integer 		iHeaderHeight,iDetailHeight,iFooterHeight,iSummaryHeight

// ---------------------------------------------------------------------------
// Translate
// ---------------------------------------------------------------------------

if this.iWebService = 0 then
	uf.translate_datastore(odw)
end if

// ---------------------------------------------------------------------------
// Quality High
// ---------------------------------------------------------------------------
	oDW.Object.DataWindow.Print.Quality = "1" 
// ---------------------------------------------------------------------------
// Welche Orientation ? 1 = Landscape	2 = Portrait
// ---------------------------------------------------------------------------
If oDW.Object.DataWindow.Print.Orientation = "1" Then
	iDWWidth 	= 1123 
	iDWHeight	= 793  
Elseif oDW.Object.DataWindow.Print.Orientation = "2" Then
	iDWWidth 	= 793  
	iDWHeight	= 1123 
else
	iDWWidth 	= 1123 
	iDWHeight	= 793  
End if	
// ---------------------------------------------------------------------------
// Layout Header
// ---------------------------------------------------------------------------
if len(trim(sReporttitle)) > 0 then
	oDW.Object.t_title.text = sReporttitle	
end if

//oDW.Object.p_logo.filename 		= sLogo
// ---------------------------------------------------------------------------
// Layout Footer
// ---------------------------------------------------------------------------
oDW.Object.DataWindow.Footer.Height	= "24" 
oDW.Object.t_signature.text 			= s_app.sOrga
oDW.Object.t_printed.text 				= string(today(),s_app.sDateformat) + &
										  			"  " + string(now(),"HH:MM")
													  
													  
//messagebox("", string(oDW.Object.t_signature.text))													  
// ---------------------------------------------------------------------------
// R$$HEX1$$e400$$ENDHEX$$nder ermitteln
// ---------------------------------------------------------------------------
iMarginTop		= integer(oDW.Object.DataWindow.Print.Margin.Top)
iMarginBottom	= integer(oDW.Object.DataWindow.Print.Margin.Bottom)
iMarginLeft		= integer(oDW.Object.DataWindow.Print.Margin.Left)
iMarginRight	= integer(oDW.Object.DataWindow.Print.Margin.Right)
iHeaderheight  = integer(oDW.Object.DataWindow.Header.Height)
iFooterheight  = integer(oDW.Object.DataWindow.Footer.Height)	
iSummaryHeight = integer(oDW.Object.DataWindow.Summary.Height)	
// ---------------------------------------------------------------------------
// Optimales Detail errechnen
// ---------------------------------------------------------------------------	
iDetailheight = iDWHeight - 4 - (iHeaderheight + iFooterheight + iSummaryHeight + iMarginTop + iMarginBottom )
oDW.Object.r_detail.Height 	= string(iDetailheight + 4)

return 0
end function

public function boolean of_store_distribution ();
// -----------------------------------------------------------------------------------------------------------------------------------------
// Objekt : uo_distribution
// Methode: of_store_distribution (Function)
// Autor  :
// -----------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// -----------------------------------------------------------------------------------------------------------------------------------------
// Return: boolean
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Ggf. Mahlzeiten-Verteilung in die DB schreiben (um sp$$HEX1$$e400$$ENDHEX$$ter wieder zu holen anstelle nochmals zu verteilen)
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version		Autor              			     Kommentar
// -----------------------------------------------------------------------------------------------------------------------------------------
//  28.06.2012	1.00			Thomas Brackmann		Erstellung
//  31.07.2012	1.01			Oliver H$$HEX1$$f600$$ENDHEX$$fer         			CBASE-CR-NAM-12050 Hinzu: Disable_Secondary_Distribution
//  21.09.2012 1.02			Thomas Brackmann		Messagebox durch uf.mbox ersetzt
//  04.02.2013	1.03			Thomas Brackmann		DataStore dsLoadingList in DB anreichern um aktuellen Inhalt dsLoadingList:
//																	5 zs$$HEX1$$e400$$ENDHEX$$tzliche Felder in lds_cen_out_md_lo aktualisiert
//  10.06.2013	1.04			Oliver Hoefer  		Umstellung Mandant von 002 auf s_app.smandant
// -----------------------------------------------------------------------------------------------------------------------------------------

Long			ll_array_count
Long			ll_ntransaction
Long			ll_nresult_key
Long			ll_rows
Long			ll_rownum
Long			ll_newrow
Long			ll_result

String			ls_save_distrtibution

// Tabelle cen_out_md

Long   		ll_lloadrow
String 		ls_cclass1
String 		ls_cclass2
String 		ls_cclass3
String 		ls_cclass4
String 		ls_cclass5
String 		ls_cclass6
String 		ls_cunit
String 		ls_cstowage
String 		ls_ctext1
String 		ls_ctext2
String 		ls_ctext3
String 		ls_cerror
String 		ls_cworkstation
Long   		ll_nranking
Long   		ll_nrankingspml
Long   		ll_nbelly
Long   		ll_nlabeltypekey
Long   		ll_nseparate
Integer  		li_nmultileg
Long   		ll_ndistributionmealkey
Long   		ll_ndistributionaddkey
Long   		ll_ngalleykey
Long   		ll_nstowagekey
Long   		ll_nstowagesort
Long   		ll_nlimit
Long   		ll_nlimitspml
Long   		ll_ndistributiongroup
Integer  		li_nclassnumber
Integer 		li_nuse
Integer  		li_nmcd
Integer  		li_nmulticlass
Integer  		li_nmixed
Integer  		li_naccummulatespml
String  		ls_cstowagegroup

// Tabelle cen_out_md_ps

Long			ll_npl_distribution_key
Long			ll_npackinglist_index_key
Long			ll_npackinglist_detail_key
Long			ll_npltype_key
String			ls_cmeal_control_code
Integer		li_nheight
Integer		li_nwidth
Long			ll_ndistribution_detail_key
Integer		li_nlimit
Integer		li_nlimit_spml
Integer		li_nrest_height
Integer		li_nrest_width
String			ls_cmeal_control_code2
String			ls_cmeal_control_code3
String			ls_cmeal_control_code4
String			ls_cmeal_control_code5
String			ls_cmeal_control_code6
String			ls_cmeal_control_code7
String			ls_cmeal_control_code8
String			ls_cmeal_control_code9
Long			ll_Disable_2nd_Distribution

// Tabelle cen_out_md_co

Long			ll_nspml 						
Integer		li_nquantity 					
String			ls_cpackinglist 			
String			ls_ctext 						
String			ls_cremark 					
String			ls_cpl_type 				
String			ls_cclass 					
Integer		li_nclass_number 			

// Tabelle cen_out_md_lo

Long			ll_nrecord_count								
String			ls_ccom_cdistributed_components          
String			ls_ccom_pldetail_label_counter           
Integer		li_ncom_nduplicated                         
Integer		li_nranking                                 
Integer		li_nranking_spml                                 	
Integer		li_ncom_nunit_priority                           
Long			ll_ncom_ndistribution_detail_key         

Long			ll_nworkstationkey
Long			ll_nareakey
String			ls_carea
String			ls_carea_code

// Tabelle cen_out_md_de

Long 			ll_ndetail_key
Long 			ll_nhandling_key
Long 			ll_nhandling_detail_key
String 		ls_chandling_text
Long 			ll_ncover_key
String 		ls_ccover_text
Integer 		li_ncover_prio
Long 			ll_nhandling_meal_key
Long 			ll_nclass_number
Integer 		li_nreserve_quantity
Integer 		li_nreserve_type
Integer 		li_ntopoff_quantity
Integer 		li_ntopoff_type
Long 			ll_nrotation_key
Long 			ll_nrotation_name_key
String 		ls_crotation
Integer 		li_nmodule_type
Integer 		li_nprio
String 		ls_cproduction_text
Integer 		li_ncomponent_group
Long 			ll_nforeign_object
Integer 		li_nforeign_group
Integer 		li_nask4passenger
String 		ls_cquestion_text
Integer 		li_npassenger_group
Integer 		li_nquantity_group
Long 			ll_naccount_key
String 		ls_caccount
Integer 		li_nbilling_status
Long 			ll_ncalc_id
Long 			ll_ncalc_detail_key
Integer 		li_npercentage
Decimal 		lde_nvalue
Integer 		li_nspml_deduction
Integer 		li_nac_transfer
Integer 		li_npax
Integer 		li_npax_manual
Integer 		li_ncalc_basis
Decimal 		lde_nquantity
Decimal 		lde_nquantity_old
Integer 		li_nmanual_input
Integer 		li_nmanual_processing
DateTime 	ldt_dtimestamp
Integer 		li_nstatus
String 		ls_cdescription
Decimal 		lde_nquantity1
Decimal 		lde_nquantity2
Decimal 		lde_nquantity3
Decimal 		lde_nquantity4
Decimal 		lde_nquantity5
Decimal 		lde_nquantity6
Decimal 		lde_nquantity7
Integer 		li_nspml_quantity
String 		ls_carea_host
String 		ls_ceffort_host
String 		ls_cadditional_account
Long 			ll_nheight
Long 			ll_nwidth
Integer 		li_nquantity_cps
Integer 		li_ndistribute
Integer 		li_ndone
Integer 		li_nspml
Integer 		li_ngroupsort
Long 			ll_ndistribution_key

String			ls_findstring 
Long 			ll_found
Long			i

DataStore lds_cen_out_md
DataStore lds_cen_out_md_ps
DataStore lds_cen_out_md_co
DataStore lds_cen_out_md_lo
DataStore lds_cen_out_md_de

uo_format_mandant uo_format_mandant

// Erstmal ermitteln, ob die Mahlzeitenverteilung $$HEX1$$fc00$$ENDHEX$$berhaupt gespeichert werden soll ...
ls_save_distrtibution = uo_format_mandant.of_mandant_profilestring(sqlca, s_app.smandant ,'MealDistribution','SaveDistribution','0')

// Soll gespeichert werden ...
IF ls_save_distrtibution = "1" THEN

	this.of_log("Storing Meal Distribution Data ...")
	
	// DataStores instanzieren ...
	lds_cen_out_md = CREATE DataStore
	lds_cen_out_md.DataObject = "dw_cen_out_md"
	lds_cen_out_md.SetTransObject(SQLCA)

	lds_cen_out_md_ps = CREATE DataStore
	lds_cen_out_md_ps.DataObject = "dw_cen_out_md_ps"
	lds_cen_out_md_ps.SetTransObject(SQLCA)

	lds_cen_out_md_co = CREATE DataStore
	lds_cen_out_md_co.DataObject = "dw_cen_out_md_co"
	lds_cen_out_md_co.SetTransObject(SQLCA)

	lds_cen_out_md_de = CREATE DataStore
	lds_cen_out_md_de.DataObject = "dw_cen_out_md_de"
	lds_cen_out_md_de.SetTransObject(SQLCA)

	// Gibt es zu diesem Flug und dieser Transaction bereits eine gespeicherte Mahlzeiten-Verteilung ?
	ll_nresult_key	=	THIS.lResultKey
	ll_ntransaction 	=	THIS.dsFlight.GetItemNumber(1, "ntransaction")	

	ll_rows			=	lds_cen_out_md.Retrieve(ll_nresult_key,ll_ntransaction)
	
	//MB 23.06.2014:
	//Wenn schon vorhanden, dann l$$HEX1$$f600$$ENDHEX$$schen und neu speichern
	if ll_rows > 0 then
		
		for i=ll_rows to 1 step -1
			
			lds_cen_out_md.deleterow(i)
			
		next
		ll_result = lds_cen_out_md.Update()
		
		//Rowcount sollte jetzt 0 sein...
		ll_rows 			= 	lds_cen_out_md.Retrieve(ll_nresult_key,ll_ntransaction)
		
//		if ll_rows = 0 then
//			//Die Blob-Tabellen noch l$$HEX1$$f600$$ENDHEX$$schen
//			delete from CEN_OUT_MD_BLOB
//			where nresult_key =						:ll_nresult_key	
//			and ntransaction =					:ll_ntransaction;
//			
//		end if
		
	end if
	
	// Nur wenn es noch keine gibt weiter ->
	IF ll_rows = 0 THEN
	
		// DataStore aus Array uoStowages f$$HEX1$$fc00$$ENDHEX$$llen ...
		FOR	ll_array_count = 1 TO UpperBound(uoStowages)

				lds_cen_out_md.InsertRow(0)
				
				lds_cen_out_md.SetItem(ll_array_count,"nresult_key",ll_nresult_key)
				lds_cen_out_md.SetItem(ll_array_count,"ntransaction",ll_ntransaction)
				lds_cen_out_md.SetItem(ll_array_count,"narray_count",ll_array_count)
				lds_cen_out_md.SetItem(ll_array_count,"lloadrow",uoStowages[ll_array_count].lloadrow)
				lds_cen_out_md.SetItem(ll_array_count,"cclass1",uoStowages[ll_array_count].sclass1)
				lds_cen_out_md.SetItem(ll_array_count,"cclass2",uoStowages[ll_array_count].sclass2)
				lds_cen_out_md.SetItem(ll_array_count,"cclass3",uoStowages[ll_array_count].sclass3)
				lds_cen_out_md.SetItem(ll_array_count,"cclass4",uoStowages[ll_array_count].sclass4)
				lds_cen_out_md.SetItem(ll_array_count,"cclass5",uoStowages[ll_array_count].sclass5)
				lds_cen_out_md.SetItem(ll_array_count,"cclass6",uoStowages[ll_array_count].sclass6)
				lds_cen_out_md.SetItem(ll_array_count,"cunit",uoStowages[ll_array_count].sunit)
				lds_cen_out_md.SetItem(ll_array_count,"cpackinglist",uoStowages[ll_array_count].spackinglist)
				lds_cen_out_md.SetItem(ll_array_count,"cstowage",uoStowages[ll_array_count].sstowage)
				lds_cen_out_md.SetItem(ll_array_count,"ctext1",uoStowages[ll_array_count].stext1)
				lds_cen_out_md.SetItem(ll_array_count,"ctext2",uoStowages[ll_array_count].stext2)
				lds_cen_out_md.SetItem(ll_array_count,"ctext3",uoStowages[ll_array_count].stext3)
				lds_cen_out_md.SetItem(ll_array_count,"cerror",uoStowages[ll_array_count].serror)
				lds_cen_out_md.SetItem(ll_array_count,"cworkstation",uoStowages[ll_array_count].sworkstation)
				lds_cen_out_md.SetItem(ll_array_count,"nranking",uoStowages[ll_array_count].lranking)
				lds_cen_out_md.SetItem(ll_array_count,"nrankingspml",uoStowages[ll_array_count].lrankingspml)
				lds_cen_out_md.SetItem(ll_array_count,"nbelly",uoStowages[ll_array_count].lbelly)
				lds_cen_out_md.SetItem(ll_array_count,"nlabeltypekey",uoStowages[ll_array_count].llabeltypekey)
				lds_cen_out_md.SetItem(ll_array_count,"nseparate",uoStowages[ll_array_count].lseparate)
				lds_cen_out_md.SetItem(ll_array_count,"nmultileg",uoStowages[ll_array_count].imultileg)
				lds_cen_out_md.SetItem(ll_array_count,"ndistributionmealkey",uoStowages[ll_array_count].ldistributionmealkey)
				lds_cen_out_md.SetItem(ll_array_count,"ndistributionaddkey",uoStowages[ll_array_count].ldistributionaddkey)
				lds_cen_out_md.SetItem(ll_array_count,"ngalleykey",uoStowages[ll_array_count].lgalleykey)
				lds_cen_out_md.SetItem(ll_array_count,"nstowagekey",uoStowages[ll_array_count].lstowagekey)
				lds_cen_out_md.SetItem(ll_array_count,"nstowagesort",uoStowages[ll_array_count].lstowagesort)
				lds_cen_out_md.SetItem(ll_array_count,"nlimit",uoStowages[ll_array_count].llimit)
				lds_cen_out_md.SetItem(ll_array_count,"nlimitspml",uoStowages[ll_array_count].llimitspml)
				lds_cen_out_md.SetItem(ll_array_count,"ndistributiongroup",uoStowages[ll_array_count].ldistributiongroup)
				lds_cen_out_md.SetItem(ll_array_count,"nclassnumber",uoStowages[ll_array_count].iclassnumber)
				lds_cen_out_md.SetItem(ll_array_count,"nuse",uoStowages[ll_array_count].iuse)
				lds_cen_out_md.SetItem(ll_array_count,"nmcd",uoStowages[ll_array_count].imcd)
				lds_cen_out_md.SetItem(ll_array_count,"nmulticlass",uoStowages[ll_array_count].imulticlass)
				lds_cen_out_md.SetItem(ll_array_count,"nmixed",uoStowages[ll_array_count].imixed)
				lds_cen_out_md.SetItem(ll_array_count,"naccummulatespml",uoStowages[ll_array_count].iaccummulatespml)
				lds_cen_out_md.SetItem(ll_array_count,"cstowagegroup",uoStowages[ll_array_count].sstowagegroup)
				
				// DataStore dsPackinglistSize aus Array uoStowages f$$HEX1$$fc00$$ENDHEX$$llen ...
				IF	uoStowages[ll_array_count].dsPackinglistSize.RowCount() > 0 THEN
					
					ll_rownum = 1
					
					DO
						ll_npl_distribution_key         	= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemNumber(ll_rownum,"npl_distribution_key")
						ll_npackinglist_index_key       	= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemNumber(ll_rownum,"npackinglist_index_key")
						ll_npackinglist_detail_key      	= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemNumber(ll_rownum,"npackinglist_detail_key")
						ll_npltype_key                  		= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemNumber(ll_rownum,"npltype_key")
						ls_cmeal_control_code           	= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemString(ll_rownum,"cmeal_control_code")
						li_nheight                      			= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemNumber(ll_rownum,"nheight")
						li_nwidth                       			= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemNumber(ll_rownum,"nwidth")
						li_nquantity                    		= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemNumber(ll_rownum,"nquantity")
						ls_cpackinglist                 		= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemString(ll_rownum,"cpackinglist")
						ll_ndistribution_detail_key     	= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemNumber(ll_rownum,"ndistribution_detail_key")
						ls_ctext                        			= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemString(ll_rownum,"ctext")
						li_nlimit                       			= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemNumber(ll_rownum,"nlimit")
						li_nlimit_spml                  		= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemNumber(ll_rownum,"nlimit_spml")
						li_nrest_height                 		= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemNumber(ll_rownum,"nrest_height")
						li_nrest_width                  		= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemNumber(ll_rownum,"nrest_width")
						ls_cmeal_control_code2          	= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemString(ll_rownum,"cmeal_control_code2")
						ls_cmeal_control_code3          	= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemString(ll_rownum,"cmeal_control_code3")
						ls_cmeal_control_code4          	= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemString(ll_rownum,"cmeal_control_code4")
						ls_cmeal_control_code5          	= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemString(ll_rownum,"cmeal_control_code5")
						ls_cmeal_control_code6          	= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemString(ll_rownum,"cmeal_control_code6")
						ls_cmeal_control_code7          	= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemString(ll_rownum,"cmeal_control_code7")
						ls_cmeal_control_code8          	= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemString(ll_rownum,"cmeal_control_code8")
						ls_cmeal_control_code9          	= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemString(ll_rownum,"cmeal_control_code9")
						ll_Disable_2nd_Distribution		= 		uoStowages[ll_array_count].dsPackinglistSize.GetItemNumber(ll_rownum,"ndisable_2nd_distribution")
						
						
						ll_newrow 							= 		lds_cen_out_md_ps.InsertRow(0)					
						
						lds_cen_out_md_ps.SetItem(ll_newrow,"nresult_key",ll_nresult_key)
						lds_cen_out_md_ps.SetItem(ll_newrow,"ntransaction",ll_ntransaction)
						lds_cen_out_md_ps.SetItem(ll_newrow,"narray_count",ll_array_count)
						lds_cen_out_md_ps.SetItem(ll_newrow,"nrecord_count",ll_newrow)					
						lds_cen_out_md_ps.SetItem(ll_newrow,"npl_distribution_key",ll_npl_distribution_key)
						lds_cen_out_md_ps.SetItem(ll_newrow,"npackinglist_index_key",ll_npackinglist_index_key)
						lds_cen_out_md_ps.SetItem(ll_newrow,"npackinglist_detail_key",ll_npackinglist_detail_key)
						lds_cen_out_md_ps.SetItem(ll_newrow,"npltype_key",ll_npltype_key)
						lds_cen_out_md_ps.SetItem(ll_newrow,"cmeal_control_code",ls_cmeal_control_code)
						lds_cen_out_md_ps.SetItem(ll_newrow,"nheight",li_nheight)
						lds_cen_out_md_ps.SetItem(ll_newrow,"nwidth",li_nwidth)
						lds_cen_out_md_ps.SetItem(ll_newrow,"nquantity",li_nquantity)
						lds_cen_out_md_ps.SetItem(ll_newrow,"cpackinglist",ls_cpackinglist)
						lds_cen_out_md_ps.SetItem(ll_newrow,"ndistribution_detail_key",ll_ndistribution_detail_key)
						lds_cen_out_md_ps.SetItem(ll_newrow,"ctext",ls_ctext)
						lds_cen_out_md_ps.SetItem(ll_newrow,"nlimit",li_nlimit)
						lds_cen_out_md_ps.SetItem(ll_newrow,"nlimit_spml",li_nlimit_spml)
						lds_cen_out_md_ps.SetItem(ll_newrow,"nrest_height",li_nrest_height)
						lds_cen_out_md_ps.SetItem(ll_newrow,"nrest_width",li_nrest_width)
						lds_cen_out_md_ps.SetItem(ll_newrow,"cmeal_control_code2",ls_cmeal_control_code2)
						lds_cen_out_md_ps.SetItem(ll_newrow,"cmeal_control_code3",ls_cmeal_control_code3)
						lds_cen_out_md_ps.SetItem(ll_newrow,"cmeal_control_code4",ls_cmeal_control_code4)
						lds_cen_out_md_ps.SetItem(ll_newrow,"cmeal_control_code5",ls_cmeal_control_code5)
						lds_cen_out_md_ps.SetItem(ll_newrow,"cmeal_control_code6",ls_cmeal_control_code6)
						lds_cen_out_md_ps.SetItem(ll_newrow,"cmeal_control_code7",ls_cmeal_control_code7)
						lds_cen_out_md_ps.SetItem(ll_newrow,"cmeal_control_code8",ls_cmeal_control_code8)
						lds_cen_out_md_ps.SetItem(ll_newrow,"cmeal_control_code9",ls_cmeal_control_code9)
						
						lds_cen_out_md_ps.SetItem(ll_newrow,"ndisable_2nd_distribution", ll_Disable_2nd_Distribution )
						
						ll_rownum = ll_rownum + 1
					
					LOOP UNTIL ll_rownum > uoStowages[ll_array_count].dsPackinglistSize.RowCount()
					
				END IF
					
				// DataStore dsContent aus Array uoStowages f$$HEX1$$fc00$$ENDHEX$$llen ...
				IF	uoStowages[ll_array_count].dsContent.RowCount() > 0 THEN
					
					ll_rownum = 1
					
					DO
						
						ll_nspml 						= 		uoStowages[ll_array_count].dsContent.GetItemNumber(ll_rownum,"nspml")
						li_nquantity 					= 		uoStowages[ll_array_count].dsContent.GetItemNumber(ll_rownum,"nquantity")
						ls_cpackinglist 				= 		uoStowages[ll_array_count].dsContent.GetItemString(ll_rownum,"cpackinglist")
						ls_ctext 						= 		uoStowages[ll_array_count].dsContent.GetItemString(ll_rownum,"ctext")
						ls_cremark 					= 		uoStowages[ll_array_count].dsContent.GetItemString(ll_rownum,"cremark")
						li_nheight 					= 		uoStowages[ll_array_count].dsContent.GetItemNumber(ll_rownum,"nheight")
						li_nwidth 					= 		uoStowages[ll_array_count].dsContent.GetItemNumber(ll_rownum,"nwidth")
						ll_npltype_key 				=		uoStowages[ll_array_count].dsContent.GetItemNumber(ll_rownum,"npltype_key")
						ls_cpl_type 					= 		uoStowages[ll_array_count].dsContent.GetItemString(ll_rownum,"cpl_type")
						ls_cclass 					= 		uoStowages[ll_array_count].dsContent.GetItemString(ll_rownum,"cclass")
						ls_cmeal_control_code	= 		uoStowages[ll_array_count].dsContent.GetItemString(ll_rownum,"cmeal_control_code")
						li_nclass_number 			= 		uoStowages[ll_array_count].dsContent.GetItemNumber(ll_rownum,"nclass_number")
						ll_npl_distribution_key 	= 		uoStowages[ll_array_count].dsContent.GetItemNumber(ll_rownum,"npl_distribution_key")

						ll_newrow 					= 		lds_cen_out_md_co.InsertRow(0)	

						lds_cen_out_md_co.SetItem(ll_newrow,"nresult_key",ll_nresult_key)
						lds_cen_out_md_co.SetItem(ll_newrow,"ntransaction",ll_ntransaction)
						lds_cen_out_md_co.SetItem(ll_newrow,"narray_count",ll_array_count)
						lds_cen_out_md_co.SetItem(ll_newrow,"nrecord_count",ll_newrow)					
						lds_cen_out_md_co.SetItem(ll_newrow,"nspml",ll_nspml)
						lds_cen_out_md_co.SetItem(ll_newrow,"nquantity",li_nquantity)
						lds_cen_out_md_co.SetItem(ll_newrow,"cpackinglist",ls_cpackinglist)
						lds_cen_out_md_co.SetItem(ll_newrow,"ctext",ls_ctext)
						lds_cen_out_md_co.SetItem(ll_newrow,"cremark",ls_cremark)
						lds_cen_out_md_co.SetItem(ll_newrow,"nheight",li_nheight)
						lds_cen_out_md_co.SetItem(ll_newrow,"nwidth",li_nwidth)
						lds_cen_out_md_co.SetItem(ll_newrow,"npltype_key",ll_npltype_key)
						lds_cen_out_md_co.SetItem(ll_newrow,"cpl_type",ls_cpl_type)
						lds_cen_out_md_co.SetItem(ll_newrow,"cclass",ls_cclass)
						lds_cen_out_md_co.SetItem(ll_newrow,"cmeal_control_code",ls_cmeal_control_code)
						lds_cen_out_md_co.SetItem(ll_newrow,"nclass_number",li_nclass_number)
						lds_cen_out_md_co.SetItem(ll_newrow,"npl_distribution_key",ll_npl_distribution_key)
						
						ll_rownum = ll_rownum + 1
					
					LOOP UNTIL ll_rownum > uoStowages[ll_array_count].dsContent.RowCount()
					
				END IF
				
		NEXT
		
		lds_cen_out_md.Update()
		lds_cen_out_md_ps.Update()		
		lds_cen_out_md_co.Update()				
		
		DESTROY lds_cen_out_md
		DESTROY lds_cen_out_md_ps		
		DESTROY lds_cen_out_md_co		
		
		// DataStores in Blob speichern ...
		//Sicherheitshalber immer erstmal l$$HEX1$$f600$$ENDHEX$$schen
		delete from CEN_OUT_MD_BLOB
		where nresult_key =						:ll_nresult_key	
		and ntransaction =					:ll_ntransaction;
		
		// Location-Sheet ----------------------
		IF Len (blbLocationSheet) > 0 THEN
		

			// Schritt 1: Datensatz vom Typ 1 anlegen ...
			INSERT INTO	CEN_OUT_MD_BLOB ( 	NRESULT_KEY        	,
																NTRANSACTION    	,	
																NTYPE                      ,
																BDATASTORE			)
								VALUES				  (		:ll_nresult_key			,
																:ll_ntransaction			,
																1							,
																EMPTY_BLOB()			);
																
			IF 	SQLCA.SQLCode <> 0 THEN
				uf.mbox("Fehler bei Anlegen Location-Sheet",sqlca.sqlerrtext)
				ROLLBACK;
					if isvalid(lds_cen_out_md) then destroy lds_cen_out_md
				if isvalid(lds_cen_out_md_ps) then destroy lds_cen_out_md_ps
				if isvalid(lds_cen_out_md_co) then destroy  lds_cen_out_md_co
				if isvalid(lds_cen_out_md_lo) then destroy lds_cen_out_md_lo
				if isvalid(lds_cen_out_md_de) then destroy lds_cen_out_md_de
				RETURN FALSE
			END IF
	
			// Schritt 2: Blob speichern ...
				UPDATEBLOB 	CEN_OUT_MD_BLOB 
				SET 				BDATASTORE 		= 		:blbLocationSheet
				WHERE 			NRESULT_KEY 		= 		:ll_nresult_key AND
									NTRANSACTION 	= 		:ll_ntransaction AND
									NTYPE 				= 		1;
	
			IF 	SQLCA.SQLCode <> 0 THEN
				uf.mbox("Fehler bei Speichern Location-Sheet",sqlca.sqlerrtext)
				ROLLBACK;
				if isvalid(lds_cen_out_md) then destroy lds_cen_out_md
				if isvalid(lds_cen_out_md_ps) then destroy lds_cen_out_md_ps
				if isvalid(lds_cen_out_md_co) then destroy  lds_cen_out_md_co
				if isvalid(lds_cen_out_md_lo) then destroy lds_cen_out_md_lo
				if isvalid(lds_cen_out_md_de) then destroy lds_cen_out_md_de
				RETURN FALSE
			END IF
			
		END IF
		
		// SPML-Summary ----------------------
		IF Len (blbSPMLSummary) > 0 THEN
			
			// DataStore SPML-Summary in Blob speichern ...
			// Schritt 1: Datensatz vom Typ 2 anlegen ...
			INSERT INTO	CEN_OUT_MD_BLOB ( 	NRESULT_KEY        	,
																NTRANSACTION    	,	
																NTYPE                      ,
																BDATASTORE			)																
								VALUES				  (		:ll_nresult_key			,
																:ll_ntransaction			,
																2							,
																EMPTY_BLOB()			);

																
			IF 	SQLCA.SQLCode <> 0 THEN
				uf.mbox("Fehler bei Anlegen SPML-Summary",sqlca.sqlerrtext)
				ROLLBACK;
				if isvalid(lds_cen_out_md) then destroy lds_cen_out_md
				if isvalid(lds_cen_out_md_ps) then destroy lds_cen_out_md_ps
				if isvalid(lds_cen_out_md_co) then destroy  lds_cen_out_md_co
				if isvalid(lds_cen_out_md_lo) then destroy lds_cen_out_md_lo
				if isvalid(lds_cen_out_md_de) then destroy lds_cen_out_md_de
				RETURN FALSE
			END IF
	
			// Schritt 2: Blob speichern ...
				UPDATEBLOB 	CEN_OUT_MD_BLOB 
				SET 				BDATASTORE 		= 		:blbSPMLSummary
				WHERE 			NRESULT_KEY 		= 		:ll_nresult_key AND
									NTRANSACTION 	= 		:ll_ntransaction AND
									NTYPE 				= 		2;
	
			IF 	SQLCA.SQLCode <> 0 THEN
				uf.mbox("Fehler bei Speichern SPML-Summary",sqlca.sqlerrtext)
				ROLLBACK;
				if isvalid(lds_cen_out_md) then destroy lds_cen_out_md
				if isvalid(lds_cen_out_md_ps) then destroy lds_cen_out_md_ps
				if isvalid(lds_cen_out_md_co) then destroy  lds_cen_out_md_co
				if isvalid(lds_cen_out_md_lo) then destroy lds_cen_out_md_lo
				if isvalid(lds_cen_out_md_de) then destroy lds_cen_out_md_de
				RETURN FALSE
			END IF
			
		END IF
		
		// Distribution-Errors ----------------------
		IF Len (blbDistributionErrors) > 0 THEN

			// Schritt 1: Datensatz vom Typ 3 anlegen ...
			INSERT INTO	CEN_OUT_MD_BLOB ( 	NRESULT_KEY        	,
																NTRANSACTION    	,	
																NTYPE                      ,
																BDATASTORE			)																
									VALUES			  (		:ll_nresult_key			,
																:ll_ntransaction			,
																3							,
																EMPTY_BLOB()			);
																
			IF 	SQLCA.SQLCode <> 0 THEN
				uf.mbox("Fehler bei Anlegen Distribution Errors",sqlca.sqlerrtext)
				ROLLBACK;
				if isvalid(lds_cen_out_md) then destroy lds_cen_out_md
				if isvalid(lds_cen_out_md_ps) then destroy lds_cen_out_md_ps
				if isvalid(lds_cen_out_md_co) then destroy  lds_cen_out_md_co
				if isvalid(lds_cen_out_md_lo) then destroy lds_cen_out_md_lo
				if isvalid(lds_cen_out_md_de) then destroy lds_cen_out_md_de
				RETURN FALSE
			END IF
	
			// Schritt 2: Blob speichern ...
				UPDATEBLOB 	CEN_OUT_MD_BLOB 
				SET 				BDATASTORE 		= 		:blbDistributionErrors
				WHERE 			NRESULT_KEY 		= 		:ll_nresult_key AND
									NTRANSACTION 	= 		:ll_ntransaction AND
									NTYPE 				= 		3;
	
			IF 	SQLCA.SQLCode <> 0 THEN
				uf.mbox("Fehler bei Speichern Distribution Errors",sqlca.sqlerrtext)
				ROLLBACK;
				if isvalid(lds_cen_out_md) then destroy lds_cen_out_md
				if isvalid(lds_cen_out_md_ps) then destroy lds_cen_out_md_ps
				if isvalid(lds_cen_out_md_co) then destroy  lds_cen_out_md_co
				if isvalid(lds_cen_out_md_lo) then destroy lds_cen_out_md_lo
				if isvalid(lds_cen_out_md_de) then destroy lds_cen_out_md_de
				RETURN FALSE
			END IF
			
		END IF		
	
		COMMIT;
		
	ELSE	
		
		// DataStore destroyen und raus ...	
		DESTROY lds_cen_out_md
		
	END IF

	// ----------------------------------------------------------------------------------------
	// DataStore dsLoadingList in DB anreichern um aktuellen Inhalt dsLoadingList ...
	IF	This.dsLoadingList.RowCount() > 0 THEN		
		
		lds_cen_out_md_lo = CREATE DataStore
		lds_cen_out_md_lo.DataObject = "dw_cen_out_md_lo"
		lds_cen_out_md_lo.SetTransObject(SQLCA)
		
		// Loading aus der DB in DataStore einlesen 
		ll_rows = lds_cen_out_md_lo.Retrieve(ll_nresult_key,ll_ntransaction)
		
		// Nur weiter, wenn auch was gefunden wurde ...
		IF 	ll_rows > 0 THEN
			
			// Die hier evtl. ge$$HEX1$$e400$$ENDHEX$$nderten Felder aus dem DataStore holen ...
			ll_rownum = 1
			
			DO
				
				ll_nrecord_count								=      dsLoadingList.GetItemNumber(ll_rownum,"nrecord_count")
				
				ls_cclass                                 			=      dsLoadingList.GetItemString(ll_rownum,"cen_loadinglists_cclass")
				ls_cclass1                                 			=      dsLoadingList.GetItemString(ll_rownum,"cclass1")
				ls_cclass2                                 			=      dsLoadingList.GetItemString(ll_rownum,"cclass2")
				ls_cclass3                                 			=      dsLoadingList.GetItemString(ll_rownum,"cclass3")
				ls_cclass4                                			=      dsLoadingList.GetItemString(ll_rownum,"cclass4")
				ls_cclass5                                 			=      dsLoadingList.GetItemString(ll_rownum,"cclass5")
				ls_cclass6                                 			=      dsLoadingList.GetItemString(ll_rownum,"cclass6")
				ls_ccom_cdistributed_components          =      dsLoadingList.GetItemString(ll_rownum,"cdistributed_components")
				ls_ccom_pldetail_label_counter             	=      dsLoadingList.GetItemString(ll_rownum,"pldetail_label_counter")
				li_ncom_nduplicated                            	=      dsLoadingList.GetItemNumber(ll_rownum,"nduplicated")
				li_nranking                                 			=      dsLoadingList.GetItemNumber(ll_rownum,"nranking")
				li_nranking_spml                                 	=      dsLoadingList.GetItemNumber(ll_rownum,"nranking_spml")
				li_ncom_nunit_priority                           =      dsLoadingList.GetItemNumber(ll_rownum,"nunit_priority")
				ll_ncom_ndistribution_detail_key          	=      dsLoadingList.GetItemNumber(ll_rownum,"ndistribution_detail_key")
				ls_cmeal_control_code                       	=      dsLoadingList.GetItemString(ll_rownum,"cen_loadinglists_cmeal_control_code")

				ll_nworkstationkey								=      dsLoadingList.GetItemNumber(ll_rownum,"nworkstationkey")
				ls_cworkstation									=		dsLoadingList.GetItemString(ll_rownum,"cworkstation")
				ll_nareakey										=      dsLoadingList.GetItemNumber(ll_rownum,"nareakey")
				ls_carea											=		dsLoadingList.GetItemString(ll_rownum,"carea")
				ls_carea_code									=		dsLoadingList.GetItemString(ll_rownum,"carea_code")

				// .   Findstring zusammensetzten ...
				ls_findstring 									= 		"nresult_key  		= "	+ String(ll_nresult_key) 	+ " AND " + &
																			"ntransaction    	= " 	+ String(ll_ntransaction)	+ " AND " + &
																			"nrecord_count		=" 	+ String(ll_nrecord_count)

				// ... und den Satz im DataStore mit den Daten aus der DB suchen ...																			
				ll_found 											= 		lds_cen_out_md_lo.Find(ls_findstring,1,lds_cen_out_md_lo.RowCount())
				
				// Ok, zugeh$$HEX1$$f600$$ENDHEX$$riger Datensatz wurde gefunden => Werte aktualisieren ...
				IF ll_found > 0 THEN
					
					lds_cen_out_md_lo.SetItem(ll_found,"cclass",ls_cclass)	
					lds_cen_out_md_lo.SetItem(ll_found,"cclass1",ls_cclass1)						
					lds_cen_out_md_lo.SetItem(ll_found,"cclass2",ls_cclass2)						
					lds_cen_out_md_lo.SetItem(ll_found,"cclass3",ls_cclass3)						
					lds_cen_out_md_lo.SetItem(ll_found,"cclass4",ls_cclass4)						
					lds_cen_out_md_lo.SetItem(ll_found,"cclass5",ls_cclass5)						
					lds_cen_out_md_lo.SetItem(ll_found,"cclass6",ls_cclass6)											
//					lds_cen_out_md_lo.SetItem(ll_found,"ccom_cdistributed_components",ls_ccom_cdistributed_components)																
//					lds_cen_out_md_lo.SetItem(ll_found,"ccom_pldetail_label_counter",ls_ccom_pldetail_label_counter)					
//					lds_cen_out_md_lo.SetItem(ll_found,"ncom_nduplicated",li_ncom_nduplicated)					
					lds_cen_out_md_lo.SetItem(ll_found,"nranking",li_nranking)					
					lds_cen_out_md_lo.SetItem(ll_found,"nranking_spml",li_nranking_spml )					
					lds_cen_out_md_lo.SetItem(ll_found,"ncom_nunit_priority",li_ncom_nunit_priority)					
					lds_cen_out_md_lo.SetItem(ll_found,"ncom_ndistribution_detail_key",ll_ncom_ndistribution_detail_key)					
					lds_cen_out_md_lo.SetItem(ll_found,"cmeal_control_code",ls_cmeal_control_code)										
					
					lds_cen_out_md_lo.SetItem(ll_found,"ncom_nworkstationkey",ll_nworkstationkey)
					lds_cen_out_md_lo.SetItem(ll_found,"ccom_cworkstation",ls_cworkstation)
					lds_cen_out_md_lo.SetItem(ll_found,"ncom_nareakey",ll_nareakey)
					lds_cen_out_md_lo.SetItem(ll_found,"ccom_carea",ls_carea)
					lds_cen_out_md_lo.SetItem(ll_found,"ccom_carea_code",ls_carea_code)
					
				END IF

				ll_rownum = ll_rownum + 1
				
			LOOP UNTIL ll_rownum > dsLoadingList.RowCount()
			
			// Und jetzt das upgedatete Loading wieder zur$$HEX1$$fc00$$ENDHEX$$ckspeichern.
			ll_result = lds_cen_out_md_lo.Update()
	
			DESTROY lds_cen_out_md_lo
			
		END IF
	
	END IF
	

	// Distribution-Errors
	ll_rows	=	lds_cen_out_md_de.Retrieve(ll_nresult_key,ll_ntransaction)
	
	// Nur wenn es noch keine gibt weiter ->
	IF ll_rows = 0 THEN
		
		// Nur, wenn es auch Distribution Errors gibt ...
		IF	dsDistributionErrors.RowCount() > 0 THEN
			
			ll_rownum = 1
						
			DO
	
				ll_ndetail_key							=		dsDistributionErrors.GetItemNumber(ll_rownum,"ndetail_key")
				ll_nhandling_key						=		dsDistributionErrors.GetItemNumber(ll_rownum,"nhandling_key")
				ll_nhandling_detail_key				=		dsDistributionErrors.GetItemNumber(ll_rownum,"nhandling_detail_key")
				ls_chandling_text						=		dsDistributionErrors.GetItemString(ll_rownum,"chandling_text")
				ll_ncover_key							=		dsDistributionErrors.GetItemNumber(ll_rownum,"ncover_key")
				ls_ccover_text							=		dsDistributionErrors.GetItemString(ll_rownum,"ccover_text")
				li_ncover_prio							=		dsDistributionErrors.GetItemNumber(ll_rownum,"ncover_prio")
				ll_nhandling_meal_key				=		dsDistributionErrors.GetItemNumber(ll_rownum,"nhandling_meal_key")
				ll_nclass_number						=		dsDistributionErrors.GetItemNumber(ll_rownum,"nclass_number")
				ls_cclass									=		dsDistributionErrors.GetItemString(ll_rownum,"cclass")
				li_nreserve_quantity					=		dsDistributionErrors.GetItemNumber(ll_rownum,"nreserve_quantity")
				li_nreserve_type						=		dsDistributionErrors.GetItemNumber(ll_rownum,"nreserve_type")
				li_ntopoff_quantity						=		dsDistributionErrors.GetItemNumber(ll_rownum,"ntopoff_quantity")
				li_ntopoff_type							=		dsDistributionErrors.GetItemNumber(ll_rownum,"ntopoff_type")
				ll_nrotation_key						=		dsDistributionErrors.GetItemNumber(ll_rownum,"nrotation_key")
				ll_nrotation_name_key				=		dsDistributionErrors.GetItemNumber(ll_rownum,"nrotation_name_key")
				ls_crotation								=		dsDistributionErrors.GetItemString(ll_rownum,"crotation")
				li_nmodule_type						=		dsDistributionErrors.GetItemNumber(ll_rownum,"nmodule_type")
				li_nprio									=		dsDistributionErrors.GetItemNumber(ll_rownum,"nprio")
				ll_npackinglist_index_key				=		dsDistributionErrors.GetItemNumber(ll_rownum,"npackinglist_index_key")
				ls_cpackinglist							=		dsDistributionErrors.GetItemString(ll_rownum,"cpackinglist")
				ls_cunit									=		dsDistributionErrors.GetItemString(ll_rownum,"cunit")
				ls_cmeal_control_code				=		dsDistributionErrors.GetItemString(ll_rownum,"cmeal_control_code")
				ls_cproduction_text					=		dsDistributionErrors.GetItemString(ll_rownum,"cproduction_text")
				li_ncomponent_group					=		dsDistributionErrors.GetItemNumber(ll_rownum,"ncomponent_group")
				ll_nforeign_object						=		dsDistributionErrors.GetItemNumber(ll_rownum,"nforeign_object")
				li_nforeign_group						=		dsDistributionErrors.GetItemNumber(ll_rownum,"nforeign_group")
				li_nask4passenger						=		dsDistributionErrors.GetItemNumber(ll_rownum,"nask4passenger")
				ls_cquestion_text						=		dsDistributionErrors.GetItemString(ll_rownum,"cquestion_text")
				li_npassenger_group					=		dsDistributionErrors.GetItemNumber(ll_rownum,"npassenger_group")
				li_nquantity_group						=		dsDistributionErrors.GetItemNumber(ll_rownum,"nquantity_group")
				ls_cremark								=		dsDistributionErrors.GetItemString(ll_rownum,"cremark")
				ll_naccount_key						=		dsDistributionErrors.GetItemNumber(ll_rownum,"naccount_key")
				ls_caccount								=		dsDistributionErrors.GetItemString(ll_rownum,"caccount")
				li_nbilling_status						=		dsDistributionErrors.GetItemNumber(ll_rownum,"nbilling_status")
				ll_ncalc_id								=		dsDistributionErrors.GetItemNumber(ll_rownum,"ncalc_id")
				ll_ncalc_detail_key						=		dsDistributionErrors.GetItemNumber(ll_rownum,"ncalc_detail_key")
				li_npercentage							=		dsDistributionErrors.GetItemNumber(ll_rownum,"npercentage")
				lde_nvalue								=		dsDistributionErrors.GetItemNumber(ll_rownum,"nvalue")
				li_nspml_deduction					=		dsDistributionErrors.GetItemNumber(ll_rownum,"nspml_deduction")
				li_nac_transfer							=		dsDistributionErrors.GetItemNumber(ll_rownum,"nac_transfer")
				li_npax									=		dsDistributionErrors.GetItemNumber(ll_rownum,"npax")
				li_npax_manual							=		dsDistributionErrors.GetItemNumber(ll_rownum,"npax_manual")
				li_ncalc_basis							=		dsDistributionErrors.GetItemNumber(ll_rownum,"ncalc_basis")
				lde_nquantity							=		dsDistributionErrors.GetItemNumber(ll_rownum,"nquantity")
				lde_nquantity_old						=		dsDistributionErrors.GetItemNumber(ll_rownum,"nquantity_old")
				li_nmanual_input						=		dsDistributionErrors.GetItemNumber(ll_rownum,"nmanual_input")
				li_nmanual_processing				=		dsDistributionErrors.GetItemNumber(ll_rownum,"nmanual_processing")
				ldt_dtimestamp							=		dsDistributionErrors.GetItemDateTime(ll_rownum,"dtimestamp")
				li_nstatus								=		dsDistributionErrors.GetItemNumber(ll_rownum,"nstatus")
				ls_cdescription							=		dsDistributionErrors.GetItemString(ll_rownum,"cdescription")
				lde_nquantity1							=		dsDistributionErrors.GetItemNumber(ll_rownum,"nquantity1")
				lde_nquantity2							=		dsDistributionErrors.GetItemNumber(ll_rownum,"nquantity2")
				lde_nquantity3							=		dsDistributionErrors.GetItemNumber(ll_rownum,"nquantity3")
				lde_nquantity4							=		dsDistributionErrors.GetItemNumber(ll_rownum,"nquantity4")
				lde_nquantity5							=		dsDistributionErrors.GetItemNumber(ll_rownum,"nquantity5")
				lde_nquantity6							=		dsDistributionErrors.GetItemNumber(ll_rownum,"nquantity6")
				lde_nquantity7							=		dsDistributionErrors.GetItemNumber(ll_rownum,"nquantity7")
				li_nspml_quantity						=		dsDistributionErrors.GetItemNumber(ll_rownum,"nspml_quantity")
				ls_carea_host							=		dsDistributionErrors.GetItemString(ll_rownum,"carea_host")
				ls_ceffort_host							=		dsDistributionErrors.GetItemString(ll_rownum,"ceffort_host")
				ls_cadditional_account				=		dsDistributionErrors.GetItemString(ll_rownum,"cadditional_account")
				ls_ctext									=		dsDistributionErrors.GetItemString(ll_rownum,"sys_packinglist_types_ctext	")
				ll_nheight								=		dsDistributionErrors.GetItemNumber(ll_rownum,"nheight")
				ll_nwidth									=		dsDistributionErrors.GetItemNumber(ll_rownum,"nwidth")
				li_nquantity_cps						=		dsDistributionErrors.GetItemNumber(ll_rownum,"cen_packinglist_size_nquantity")
				ll_npltype_key							=		dsDistributionErrors.GetItemNumber(ll_rownum,"npltype_key")
				li_ndistribute							=		dsDistributionErrors.GetItemNumber(ll_rownum,"ndistribute")
				li_ndone									=		dsDistributionErrors.GetItemNumber(ll_rownum,"ndone")
				li_nspml									=		dsDistributionErrors.GetItemNumber(ll_rownum,"nspml")
				ls_cstowagegroup						=		dsDistributionErrors.GetItemString(ll_rownum,"cstowagegroup")
				li_ngroupsort							=		dsDistributionErrors.GetItemNumber(ll_rownum,"ngroupsort")
				ll_ndistribution_key					=		dsDistributionErrors.GetItemNumber(ll_rownum,"ndistribution_key")

				ll_newrow 								= 		lds_cen_out_md_de.InsertRow(0)	

				lds_cen_out_md_de.SetItem(ll_newrow,"nresult_key",ll_nresult_key)
				lds_cen_out_md_de.SetItem(ll_newrow,"ntransaction",ll_ntransaction)
				lds_cen_out_md_de.SetItem(ll_newrow,"nrecord_count",ll_newrow)
				lds_cen_out_md_de.SetItem(ll_newrow,"ndetail_key",ll_ndetail_key)
				lds_cen_out_md_de.SetItem(ll_newrow,"nhandling_key",ll_nhandling_key)
				lds_cen_out_md_de.SetItem(ll_newrow,"nhandling_detail_key",ll_nhandling_detail_key)
				lds_cen_out_md_de.SetItem(ll_newrow,"chandling_text",ls_chandling_text)
				lds_cen_out_md_de.SetItem(ll_newrow,"ncover_key",ll_ncover_key)
				lds_cen_out_md_de.SetItem(ll_newrow,"ccover_text",ls_ccover_text)
				lds_cen_out_md_de.SetItem(ll_newrow,"ncover_prio",li_ncover_prio)
				lds_cen_out_md_de.SetItem(ll_newrow,"nhandling_meal_key",ll_nhandling_meal_key)
				lds_cen_out_md_de.SetItem(ll_newrow,"nclass_number",ll_nclass_number)
				lds_cen_out_md_de.SetItem(ll_newrow,"cclass",ls_cclass)
				lds_cen_out_md_de.SetItem(ll_newrow,"nreserve_quantity",li_nreserve_quantity)
				lds_cen_out_md_de.SetItem(ll_newrow,"nreserve_type",li_nreserve_type)
				lds_cen_out_md_de.SetItem(ll_newrow,"ntopoff_quantity",li_ntopoff_quantity)
				lds_cen_out_md_de.SetItem(ll_newrow,"ntopoff_type",li_ntopoff_type)
				lds_cen_out_md_de.SetItem(ll_newrow,"nrotation_key",ll_nrotation_key)
				lds_cen_out_md_de.SetItem(ll_newrow,"nrotation_name_key",ll_nrotation_name_key)
				lds_cen_out_md_de.SetItem(ll_newrow,"crotation",ls_crotation)
				lds_cen_out_md_de.SetItem(ll_newrow,"nmodule_type",li_nmodule_type)
				lds_cen_out_md_de.SetItem(ll_newrow,"nprio",li_nprio)
				lds_cen_out_md_de.SetItem(ll_newrow,"npackinglist_index_key",ll_npackinglist_index_key)
				lds_cen_out_md_de.SetItem(ll_newrow,"cpackinglist",ls_cpackinglist)
				lds_cen_out_md_de.SetItem(ll_newrow,"cunit",ls_cunit)
				lds_cen_out_md_de.SetItem(ll_newrow,"cmeal_control_code",ls_cmeal_control_code)
				lds_cen_out_md_de.SetItem(ll_newrow,"cproduction_text",ls_cproduction_text)
				lds_cen_out_md_de.SetItem(ll_newrow,"ncomponent_group",li_ncomponent_group)
				lds_cen_out_md_de.SetItem(ll_newrow,"nforeign_object",ll_nforeign_object)
				lds_cen_out_md_de.SetItem(ll_newrow,"nforeign_group",li_nforeign_group)
				lds_cen_out_md_de.SetItem(ll_newrow,"nask4passenger",li_nask4passenger)
				lds_cen_out_md_de.SetItem(ll_newrow,"cquestion_text",ls_cquestion_text)
				lds_cen_out_md_de.SetItem(ll_newrow,"npassenger_group",li_npassenger_group)
				lds_cen_out_md_de.SetItem(ll_newrow,"nquantity_group",li_nquantity_group)
				lds_cen_out_md_de.SetItem(ll_newrow,"cremark",ls_cremark)
				lds_cen_out_md_de.SetItem(ll_newrow,"naccount_key",ll_naccount_key)
				lds_cen_out_md_de.SetItem(ll_newrow,"caccount",ls_caccount)
				lds_cen_out_md_de.SetItem(ll_newrow,"nbilling_status",li_nbilling_status)
				lds_cen_out_md_de.SetItem(ll_newrow,"ncalc_id",ll_ncalc_id)
				lds_cen_out_md_de.SetItem(ll_newrow,"ncalc_detail_key",ll_ncalc_detail_key)
				lds_cen_out_md_de.SetItem(ll_newrow,"npercentage",li_npercentage)
				lds_cen_out_md_de.SetItem(ll_newrow,"nvalue",lde_nvalue)
				lds_cen_out_md_de.SetItem(ll_newrow,"nspml_deduction",li_nspml_deduction)
				lds_cen_out_md_de.SetItem(ll_newrow,"nac_transfer",li_nac_transfer)
				lds_cen_out_md_de.SetItem(ll_newrow,"npax",li_npax)
				lds_cen_out_md_de.SetItem(ll_newrow,"npax_manual",li_npax_manual)
				lds_cen_out_md_de.SetItem(ll_newrow,"ncalc_basis",li_ncalc_basis)
				lds_cen_out_md_de.SetItem(ll_newrow,"nquantity",lde_nquantity)
				lds_cen_out_md_de.SetItem(ll_newrow,"nquantity_old",lde_nquantity_old)
				lds_cen_out_md_de.SetItem(ll_newrow,"nmanual_input",li_nmanual_input)
				lds_cen_out_md_de.SetItem(ll_newrow,"nmanual_processing",li_nmanual_processing)
				lds_cen_out_md_de.SetItem(ll_newrow,"dtimestamp",ldt_dtimestamp)
				lds_cen_out_md_de.SetItem(ll_newrow,"nstatus",li_nstatus)
				lds_cen_out_md_de.SetItem(ll_newrow,"cdescription",ls_cdescription)
				lds_cen_out_md_de.SetItem(ll_newrow,"nquantity1",lde_nquantity1)
				lds_cen_out_md_de.SetItem(ll_newrow,"nquantity2",lde_nquantity2)
				lds_cen_out_md_de.SetItem(ll_newrow,"nquantity3",lde_nquantity3)
				lds_cen_out_md_de.SetItem(ll_newrow,"nquantity4",lde_nquantity4)
				lds_cen_out_md_de.SetItem(ll_newrow,"nquantity5",lde_nquantity5)
				lds_cen_out_md_de.SetItem(ll_newrow,"nquantity6",lde_nquantity6)
				lds_cen_out_md_de.SetItem(ll_newrow,"nquantity7",lde_nquantity7)
				lds_cen_out_md_de.SetItem(ll_newrow,"nspml_quantity",li_nspml_quantity)
				lds_cen_out_md_de.SetItem(ll_newrow,"carea_host",ls_carea_host)
				lds_cen_out_md_de.SetItem(ll_newrow,"ceffort_host",ls_ceffort_host)
				lds_cen_out_md_de.SetItem(ll_newrow,"cadditional_account",ls_cadditional_account)
				lds_cen_out_md_de.SetItem(ll_newrow,"ctext",ls_ctext)
				lds_cen_out_md_de.SetItem(ll_newrow,"nheight",ll_nheight)
				lds_cen_out_md_de.SetItem(ll_newrow,"nwidth",ll_nwidth)
				lds_cen_out_md_de.SetItem(ll_newrow,"nquantity_cps",li_nquantity_cps)
				lds_cen_out_md_de.SetItem(ll_newrow,"npltype_key",ll_npltype_key)
				lds_cen_out_md_de.SetItem(ll_newrow,"ndistribute",li_ndistribute)
				lds_cen_out_md_de.SetItem(ll_newrow,"ndone",li_ndone)
				lds_cen_out_md_de.SetItem(ll_newrow,"nspml",li_nspml)
				lds_cen_out_md_de.SetItem(ll_newrow,"cstowagegroup",ls_cstowagegroup)
				lds_cen_out_md_de.SetItem(ll_newrow,"ngroupsort",li_ngroupsort)
				lds_cen_out_md_de.SetItem(ll_newrow,"ndistribution_key",ll_ndistribution_key)

				ll_rownum = ll_rownum + 1
					
			LOOP UNTIL ll_rownum > dsDistributionErrors.RowCount()
				
			ll_result = lds_cen_out_md_de.Update()
		
			DESTROY lds_cen_out_md_de
				
		END IF		
			
		COMMIT;
			
	END IF

	COMMIT;
	
END IF
	if isvalid(lds_cen_out_md) then destroy lds_cen_out_md
	if isvalid(lds_cen_out_md_ps) then destroy lds_cen_out_md_ps
	if isvalid(lds_cen_out_md_co) then destroy  lds_cen_out_md_co
	if isvalid(lds_cen_out_md_lo) then destroy lds_cen_out_md_lo
	if isvalid(lds_cen_out_md_de) then destroy lds_cen_out_md_de
RETURN TRUE
end function

public function boolean of_restore_distribution ();
// -----------------------------------------------------------------------------------------------------------------------------------------
// Objekt : uo_distribution
// Methode: of_restore_distribution (Function)
// Autor  :
// -----------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// -----------------------------------------------------------------------------------------------------------------------------------------
// Return: boolean
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Ggf. Mahlzeiten-Verteilung aus DB holen (wenn zuvor bereits verteilt wurde)
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version		Autor              			     Kommentar
// -----------------------------------------------------------------------------------------------------------------------------------------
//  13.07.2012	1.00			Thomas Brackmann		Erstellung
//  31.07.2012	1.01			Oliver H$$HEX1$$f600$$ENDHEX$$fer         			CBASE-CR-NAM-12050 Hinzu: Disable_Secondary_Distribution
//  21.09.2012 1.02			Thomas Brackmann		Messagebox durch uf.mbox ersetzt
//  10.06.2013	1.04			Oliver Hoefer  		Umstellung Mandant von 002 auf s_app.smandant
// -----------------------------------------------------------------------------------------------------------------------------------------

Long		ll_rows
Long		ll_rows_1
Long		ll_rows_2
Long		ll_rows_3
Long		ll_rows_4
Long		ll_rows_5
Long		ll_rownum
Long		ll_rownum_1
Long		ll_rownum_2
Long		ll_rownum_3
Long		ll_newrow
Long		ll_nresult_key	
Long		ll_ntransaction
Long		ll_array_count
Long 		ll_npl_distribution_key
Long 		ll_npackinglist_index_key
Long 		ll_npackinglist_detail_key
Long 		ll_npltype_key
Long 		ll_ndistribution_detail_key
Long    	ll_nspml
Long 		ll_lloadrow
Long 		ll_nranking
Long 		ll_nrankingspml
Long 		ll_nbelly
Long 		ll_nlabeltypekey
Long 		ll_nseparate
Long 		ll_nmultileg
Long 		ll_ndistributionmealkey
Long 		ll_ndistributionaddkey
Long 		ll_ngalleykey
Long 		ll_nstowagekey
Long 		ll_nstowagesort
Long 		ll_nlimit
Long 		ll_nlimitspml
Long 		ll_ndistributiongroup
Long 		ll_nclassnumber
Long 		ll_nuse
Long 		ll_nmcd
Long 		ll_nmulticlass
Long 		ll_nmixed
Long 		ll_naccummulatespml
Long 		ll_found 							

Integer 	li_nheight
Integer 	li_nwidth
Integer 	li_nquantity
Integer 	li_nlimit
Integer 	li_nlimit_spml
Integer 	li_nrest_height
Integer 	li_nrest_width
Integer 	li_nclass_number

Integer 	li_ngalley_pos      		
Integer 	li_ngalley_sort     		
Integer 	li_nstowage_sort    	
Integer 	li_nbelly           	
Integer 	li_nitems           	
Integer 	li_nmodified        	
Integer 	li_nduplicated   

String		ls_save_distrtibution
String 	ls_cmeal_control_code
String 	ls_cpackinglist
String 	ls_ctext
String 	ls_cmeal_control_code2       
String 	ls_cmeal_control_code3       
String 	ls_cmeal_control_code4       
String 	ls_cmeal_control_code5       
String 	ls_cmeal_control_code6       
String 	ls_cmeal_control_code7       
String 	ls_cmeal_control_code8       
String 	ls_cmeal_control_code9       
String  	ls_cremark
String  	ls_cpl_type
String  	ls_cclass
String 	ls_cclass1
String 	ls_cclass2
String 	ls_cclass3
String 	ls_cclass4
String 	ls_cclass5
String 	ls_cclass6
String 	ls_cunit

String 	ls_cstowage
String 	ls_ctext1
String 	ls_ctext2
String 	ls_ctext3
String 	ls_cerror
String 	ls_cworkstation
String 	ls_cstowagegroup

Long		ll_Disable_2nd_Distribution

Blob		lbl_empty

DataStore lds_cen_out_md
DataStore lds_cen_out_md_ps
DataStore lds_cen_out_md_co

uo_format_mandant 			uo_format_mandant

// Erstmal ermitteln, ob die Mahlzeitenverteilung $$HEX1$$fc00$$ENDHEX$$berhaupt gespeichert werden soll ...
ls_save_distrtibution = uo_format_mandant.of_mandant_profilestring(sqlca, s_app.smandant ,'MealDistribution','SaveDistribution','0')

// Soll gespeichert werden (und keine manuelle Verteilung) ...
IF ls_save_distrtibution = "1" AND NOT this.bManuelDistribution THEN

	this.of_log("Restoring Meal Distribution Data ...")
	
	// DataStores instanzieren ...
	lds_cen_out_md = CREATE DataStore
	lds_cen_out_md.DataObject = "dw_cen_out_md"
	lds_cen_out_md.SetTransObject(SQLCA)

	lds_cen_out_md_ps = CREATE DataStore
	lds_cen_out_md_ps.DataObject = "dw_cen_out_md_ps"
	lds_cen_out_md_ps.SetTransObject(SQLCA)

	lds_cen_out_md_co = CREATE DataStore
	lds_cen_out_md_co.DataObject = "dw_cen_out_md_co"
	lds_cen_out_md_co.SetTransObject(SQLCA)

	ll_nresult_key	=	THIS.lResultKey
	ll_ntransaction 	=	THIS.dsFlight.GetItemNumber(1, "ntransaction")	

	// --------------------------------------------------------------------------------------------------------
	// 1. Array-Variable uoStowages
	// --------------------------------------------------------------------------------------------------------	
	
	// Daten f$$HEX1$$fc00$$ENDHEX$$r Array uoStowages einlesen ...
	ll_rows =	lds_cen_out_md.Retrieve(ll_nresult_key,ll_ntransaction)
	
	// Nur wenn es etwas gibt weiter -> Daten f$$HEX1$$fc00$$ENDHEX$$r Array-Instance-Variablen aus DataStore einlesen ...
	IF ll_rows > 0 THEN
		
		// Array initialisieren ...
		
		ll_rownum 		= 	1
		
		DO
			ll_array_count         											= 		lds_cen_out_md.GetItemNumber(ll_rownum,"narray_count")
			
			ll_lloadrow                          								=       lds_cen_out_md.GetItemNumber(ll_rownum,"lloadrow")
			ls_cclass1                           								=       lds_cen_out_md.GetItemString(ll_rownum,"cclass1")
			ls_cclass2                           								=       lds_cen_out_md.GetItemString(ll_rownum,"cclass2")
			ls_cclass3                           								=       lds_cen_out_md.GetItemString(ll_rownum,"cclass3")
			ls_cclass4                           								=       lds_cen_out_md.GetItemString(ll_rownum,"cclass4")
			ls_cclass5                           								=       lds_cen_out_md.GetItemString(ll_rownum,"cclass5")
			ls_cclass6                            								=       lds_cen_out_md.GetItemString(ll_rownum,"cclass6")
			ls_cunit                              								=       lds_cen_out_md.GetItemString(ll_rownum,"cunit")
			ls_cpackinglist                       								=       lds_cen_out_md.GetItemString(ll_rownum,"cpackinglist")
			ls_cstowage                           								=       lds_cen_out_md.GetItemString(ll_rownum,"cstowage")
			ls_ctext1                               								=       lds_cen_out_md.GetItemString(ll_rownum,"ctext1")
			ls_ctext2                                								=       lds_cen_out_md.GetItemString(ll_rownum,"ctext2")
			ls_ctext3                               								=       lds_cen_out_md.GetItemString(ll_rownum,"ctext3")
			ls_cerror                               								=       lds_cen_out_md.GetItemString(ll_rownum,"cerror")
			ls_cworkstation                      								=       lds_cen_out_md.GetItemString(ll_rownum,"cworkstation")
			ll_nranking                            								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nranking")
			ll_nrankingspml                      								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nrankingspml")
			ll_nbelly                              								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nbelly")
			ll_nlabeltypekey                     								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nlabeltypekey")
			ll_nseparate                           								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nseparate")
			ll_nmultileg                            								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nmultileg")
			ll_ndistributionmealkey           								=       lds_cen_out_md.GetItemNumber(ll_rownum,"ndistributionmealkey")
			ll_ndistributionaddkey             								=       lds_cen_out_md.GetItemNumber(ll_rownum,"ndistributionaddkey")
			ll_ngalleykey                         								=       lds_cen_out_md.GetItemNumber(ll_rownum,"ngalleykey")
			ll_nstowagekey                       								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nstowagekey")
			ll_nstowagesort                       								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nstowagesort")
			ll_nlimit                                								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nlimit")
			ll_nlimitspml                         								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nlimitspml")
			ll_ndistributiongroup              								=       lds_cen_out_md.GetItemNumber(ll_rownum,"ndistributiongroup")
			ll_nclassnumber                     								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nclassnumber")
			ll_nuse                                 								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nuse")
			ll_nmcd                                 								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nmcd")
			ll_nmulticlass                         								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nmulticlass")
			ll_nmixed                              								=       lds_cen_out_md.GetItemNumber(ll_rownum,"nmixed")
			ll_naccummulatespml              								=       lds_cen_out_md.GetItemNumber(ll_rownum,"naccummulatespml")
			ls_cstowagegroup                  								=       lds_cen_out_md.GetItemString(ll_rownum,"cstowagegroup")
			
			uoStowages[ll_array_count] 								= 		CREATE uo_distribution_container
			
			// Array-Instance-Variablen zuweisen ...
			uoStowages[ll_array_count].lloadrow 					=		ll_lloadrow
			uoStowages[ll_array_count].sclass1 						= 		ls_cclass1
			uoStowages[ll_array_count].sclass2 						= 		ls_cclass2
			uoStowages[ll_array_count].sclass3 						= 		ls_cclass3
			uoStowages[ll_array_count].sclass4 						= 		ls_cclass4
			uoStowages[ll_array_count].sclass5 						= 		ls_cclass5
			uoStowages[ll_array_count].sclass6 						= 		ls_cclass6
			uoStowages[ll_array_count].sunit 							= 		ls_cunit
			uoStowages[ll_array_count].spackinglist 				= 		ls_cpackinglist
			uoStowages[ll_array_count].sstowage 					= 		ls_cstowage
			uoStowages[ll_array_count].stext1 						= 		ls_ctext1
			uoStowages[ll_array_count].stext2 						= 		ls_ctext2
			uoStowages[ll_array_count].stext3 						= 		ls_ctext3
			uoStowages[ll_array_count].serror 						= 		ls_cerror
			uoStowages[ll_array_count].sworkstation 				= 		ls_cworkstation
			uoStowages[ll_array_count].lranking 						=		ll_nranking
			uoStowages[ll_array_count].lrankingspml 				=		ll_nrankingspml
			uoStowages[ll_array_count].lbelly 						=		ll_nbelly
			uoStowages[ll_array_count].llabeltypekey 				=		ll_nlabeltypekey
			uoStowages[ll_array_count].lseparate 					=		ll_nseparate
			uoStowages[ll_array_count].imultileg 					=		ll_nmultileg
			uoStowages[ll_array_count].ldistributionmealkey		=		ll_ndistributionmealkey
			uoStowages[ll_array_count].ldistributionaddkey 		=		ll_ndistributionaddkey
			uoStowages[ll_array_count].lgalleykey 					=		ll_ngalleykey
			uoStowages[ll_array_count].lstowagekey 				=		ll_nstowagekey
			uoStowages[ll_array_count].lstowagesort 				=		ll_nstowagesort
			uoStowages[ll_array_count].llimit 							=		ll_nlimit
			uoStowages[ll_array_count].llimitspml 					=		ll_nlimitspml
			uoStowages[ll_array_count].ldistributiongroup 			=		ll_ndistributiongroup
			uoStowages[ll_array_count].iclassnumber 				=		ll_nclassnumber
			uoStowages[ll_array_count].iuse 							=		ll_nuse
			uoStowages[ll_array_count].imcd 							=		ll_nmcd
			uoStowages[ll_array_count].imulticlass 					=		ll_nmulticlass
			uoStowages[ll_array_count].imixed 						=		ll_nmixed
			uoStowages[ll_array_count].iaccummulatespml 		=		ll_naccummulatespml
			uoStowages[ll_array_count].sstowagegroup 			= 		ls_cstowagegroup
	
			// --------------------------------------------------------------------------------------------------------
			// 2. Array-DataStore dsPackinglistSize
			// --------------------------------------------------------------------------------------------------------	

			// DataStore dsPackinglistSize (Array uoStowages) aus DataStore f$$HEX1$$fc00$$ENDHEX$$llen ...
			ll_rows_1 =	lds_cen_out_md_ps.Retrieve(ll_nresult_key, ll_ntransaction, ll_array_count)
			
			// Nur wenn es etwas gibt weiter ->
			IF ll_rows_1 > 0 THEN
				
				// DataStore des Arrays initialisieren ...
				uoStowages[ll_array_count].dsPackinglistSize.Reset()	
				
				ll_rownum_1 = 1
				
				DO
					// Lesen ...
					ll_npl_distribution_key		=		lds_cen_out_md_ps.GetItemNumber(ll_rownum_1,"npl_distribution_key")
					ll_npackinglist_index_key		=		lds_cen_out_md_ps.GetItemNumber(ll_rownum_1,"npackinglist_index_key")
					ll_npackinglist_detail_key		=		lds_cen_out_md_ps.GetItemNumber(ll_rownum_1,"npackinglist_detail_key")
					ll_npltype_key					=		lds_cen_out_md_ps.GetItemNumber(ll_rownum_1,"npltype_key")
					ls_cmeal_control_code		=		lds_cen_out_md_ps.GetItemString(ll_rownum_1,"cmeal_control_code")
					li_nheight						=		lds_cen_out_md_ps.GetItemNumber(ll_rownum_1,"nheight")
					li_nwidth							=		lds_cen_out_md_ps.GetItemNumber(ll_rownum_1,"nwidth")
					li_nquantity						=		lds_cen_out_md_ps.GetItemNumber(ll_rownum_1,"nquantity")
					ls_cpackinglist					=		lds_cen_out_md_ps.GetItemString(ll_rownum_1,"cpackinglist")
					ll_ndistribution_detail_key	=		lds_cen_out_md_ps.GetItemNumber(ll_rownum_1,"ndistribution_detail_key")
					ls_ctext							=		lds_cen_out_md_ps.GetItemString(ll_rownum_1,"ctext")
					li_nlimit							=		lds_cen_out_md_ps.GetItemNumber(ll_rownum_1,"nlimit")
					li_nlimit_spml					=		lds_cen_out_md_ps.GetItemNumber(ll_rownum_1,"nlimit_spml")
					li_nrest_height					=		lds_cen_out_md_ps.GetItemNumber(ll_rownum_1,"nrest_height")
					li_nrest_width					=		lds_cen_out_md_ps.GetItemNumber(ll_rownum_1,"nrest_width")
					ls_cmeal_control_code2		=		of_checknull(lds_cen_out_md_ps.GetItemString(ll_rownum_1,"cmeal_control_code2"))
					ls_cmeal_control_code3		=		of_checknull(lds_cen_out_md_ps.GetItemString(ll_rownum_1,"cmeal_control_code3"))
					ls_cmeal_control_code4		=		of_checknull(lds_cen_out_md_ps.GetItemString(ll_rownum_1,"cmeal_control_code4"))
					ls_cmeal_control_code5		=		of_checknull(lds_cen_out_md_ps.GetItemString(ll_rownum_1,"cmeal_control_code5"))
					ls_cmeal_control_code6		=		of_checknull(lds_cen_out_md_ps.GetItemString(ll_rownum_1,"cmeal_control_code6"))
					ls_cmeal_control_code7		=		of_checknull(lds_cen_out_md_ps.GetItemString(ll_rownum_1,"cmeal_control_code7"))
					ls_cmeal_control_code8		=		of_checknull(lds_cen_out_md_ps.GetItemString(ll_rownum_1,"cmeal_control_code8"))
					ls_cmeal_control_code9		=		of_checknull(lds_cen_out_md_ps.GetItemString(ll_rownum_1,"cmeal_control_code9"))
					// CBASE-CR-NAM-12050
					ll_Disable_2nd_Distribution	=		lds_cen_out_md_ps.GetItemNumber(ll_rownum_1,"ndisable_2nd_distribution")
					
					// Insert ...
					ll_newrow						=		uoStowages[ll_array_count].dsPackinglistSize.InsertRow(0)					

					// Schreiben ...
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"npl_distribution_key",ll_npl_distribution_key)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"npackinglist_index_key",ll_npackinglist_index_key)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"npackinglist_detail_key",ll_npackinglist_detail_key)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"npltype_key",ll_npltype_key)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"cmeal_control_code",ls_cmeal_control_code)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"nheight",li_nheight)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"nwidth",li_nwidth)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"nquantity",li_nquantity)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"cpackinglist",ls_cpackinglist)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"ndistribution_detail_key",ll_ndistribution_detail_key)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"ctext",ls_ctext)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"nlimit",li_nlimit)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"nlimit_spml",li_nlimit_spml)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"nrest_height",li_nrest_height)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"nrest_width",li_nrest_width)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"cmeal_control_code2",ls_cmeal_control_code2)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"cmeal_control_code3",ls_cmeal_control_code3)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"cmeal_control_code4",ls_cmeal_control_code4)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"cmeal_control_code5",ls_cmeal_control_code5)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"cmeal_control_code6",ls_cmeal_control_code6)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"cmeal_control_code7",ls_cmeal_control_code7)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"cmeal_control_code8",ls_cmeal_control_code8)
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"cmeal_control_code9",ls_cmeal_control_code9)
					
					// CBASE-CR-NAM-12050
					uoStowages[ll_array_count].dsPackinglistSize.SetItem(ll_newrow,"ndisable_2nd_distribution",ll_Disable_2nd_Distribution)
					
					ll_rownum_1 =  ll_rownum_1 + 1
					
				LOOP UNTIL ll_rownum_1 > ll_rows_1
			
			END IF
	
			// --------------------------------------------------------------------------------------------------------
			// 3. Array-DataStore dsContent
			// --------------------------------------------------------------------------------------------------------	

			// DataStore dsContent (Array uoStowages) aus DataStore f$$HEX1$$fc00$$ENDHEX$$llen ...
			ll_rows_2 =	lds_cen_out_md_co.Retrieve(ll_nresult_key, ll_ntransaction, ll_array_count)
			
			// Nur wenn es etwas gibt weiter ->
			IF ll_rows_2 > 0 THEN
				
				// DataStore des Arrays initialiesiern ...
				uoStowages[ll_array_count].dsContent.Reset()	
				
				ll_rownum_1 = 1
				
				DO
					// Lesen ...
					ll_nspml     						=		lds_cen_out_md_co.GetItemNumber(ll_rownum_1,"nspml")
					li_nquantity 						=      	lds_cen_out_md_co.GetItemNumber(ll_rownum_1,"nquantity")
					ls_cpackinglist          			=		lds_cen_out_md_co.GetItemString(ll_rownum_1,"cpackinglist")
					ls_ctext                 			=		lds_cen_out_md_co.GetItemString(ll_rownum_1,"ctext")
					ls_cremark               			=		lds_cen_out_md_co.GetItemString(ll_rownum_1,"cremark")
					li_nheight               			=		lds_cen_out_md_co.GetItemNumber(ll_rownum_1,"nheight")
					li_nwidth                			=		lds_cen_out_md_co.GetItemNumber(ll_rownum_1,"nwidth")
					ll_npltype_key           			=		lds_cen_out_md_co.GetItemNumber(ll_rownum_1,"npltype_key")
					ls_cpl_type              			=		lds_cen_out_md_co.GetItemString(ll_rownum_1,"cpl_type")
					ls_cclass                			=		lds_cen_out_md_co.GetItemString(ll_rownum_1,"cclass")
					ls_cmeal_control_code    	=		lds_cen_out_md_co.GetItemString(ll_rownum_1,"cmeal_control_code")
					li_nclass_number         		=		lds_cen_out_md_co.GetItemNumber(ll_rownum_1,"nclass_number")
					ll_npl_distribution_key  		=		lds_cen_out_md_co.GetItemNumber(ll_rownum_1,"npl_distribution_key")
					
					// Insert ...
					ll_newrow						=		uoStowages[ll_array_count].dsContent.InsertRow(0)					

					// Schreiben ...
					uoStowages[ll_array_count].dsContent.SetItem(ll_newrow,"nspml", ll_nspml)
					uoStowages[ll_array_count].dsContent.SetItem(ll_newrow,"nquantity", li_nquantity)
					uoStowages[ll_array_count].dsContent.SetItem(ll_newrow,"cpackinglist", ls_cpackinglist)
					uoStowages[ll_array_count].dsContent.SetItem(ll_newrow,"ctext", ls_ctext)
					uoStowages[ll_array_count].dsContent.SetItem(ll_newrow,"cremark", ls_cremark)
					uoStowages[ll_array_count].dsContent.SetItem(ll_newrow,"nheight", li_nheight)
					uoStowages[ll_array_count].dsContent.SetItem(ll_newrow,"nwidth", li_nwidth)
					uoStowages[ll_array_count].dsContent.SetItem(ll_newrow,"npltype_key", ll_npltype_key)
					uoStowages[ll_array_count].dsContent.SetItem(ll_newrow,"cpl_type", ls_cpl_type)
					uoStowages[ll_array_count].dsContent.SetItem(ll_newrow,"cclass", ls_cclass)
					uoStowages[ll_array_count].dsContent.SetItem(ll_newrow,"cmeal_control_code", ls_cmeal_control_code)
					uoStowages[ll_array_count].dsContent.SetItem(ll_newrow,"nclass_number", li_nclass_number)
					uoStowages[ll_array_count].dsContent.SetItem(ll_newrow,"npl_distribution_key", ll_npl_distribution_key)

					ll_rownum_1 =  ll_rownum_1 + 1
					
				LOOP UNTIL ll_rownum_1 > ll_rows_2
			
			END IF
			
			ll_rownum = ll_rownum + 1
			
		LOOP UNTIL ll_rownum > ll_rows

	ELSE // IF ll_rows_1 > 0 ...
		
		// Also keine Mahlzeitenverteilung aus der Sicherung gefunden => Raus ...
		DESTROY lds_cen_out_md
		RETURN FALSE
		
	END IF
	
	DESTROY lds_cen_out_md
	DESTROY lds_cen_out_md_ps
	DESTROY lds_cen_out_md_co

	// --------------------------------------------------------------------------------------------------------
	// 6. DataStores aus Blob einlesen
	// --------------------------------------------------------------------------------------------------------	

	// Erstmal die Blobs initialisieren ...
	blbLocationSheet  		=		lbl_empty
	blbSPMLSummary  	= 		lbl_empty
	blbDistributionErrors	= 		lbl_empty

	// Location Sheet ...
	SELECTBLOB 	BDATASTORE
	INTO				:blbLocationSheet 
	FROM				CEN_OUT_MD_BLOB
	WHERE			NRESULT_KEY       = 	:ll_nresult_key 		AND
						NTRANSACTION   	=	:ll_ntransaction		AND	
						NTYPE          		=	1;
						
	IF 	SQLCA.SQLCode <> 100 AND SQLCA.SQLCode <> 0 THEN
		uf.mbox("Fehler bei Lesen Location Sheet",sqlca.sqlerrtext)
		ROLLBACK;
		RETURN FALSE
	END IF
						
	// SPML-Summary ...
	SELECTBLOB 	BDATASTORE
	INTO				:blbSPMLSummary
	FROM				CEN_OUT_MD_BLOB
	WHERE			NRESULT_KEY       = 	:ll_nresult_key 		AND
						NTRANSACTION   	=	:ll_ntransaction		AND	
						NTYPE          		=	2;
						
	IF 	SQLCA.SQLCode <> 100 AND SQLCA.SQLCode <> 0 THEN
		uf.mbox("Fehler bei Lesen SPML-Summary",sqlca.sqlerrtext)
		ROLLBACK;
		RETURN FALSE
	END IF

	// Distribution Errors ...
	SELECTBLOB 	BDATASTORE
	INTO				:blbDistributionErrors
	FROM				CEN_OUT_MD_BLOB
	WHERE			NRESULT_KEY       = 	:ll_nresult_key 		AND
						NTRANSACTION   	=	:ll_ntransaction		AND	
						NTYPE          		=	3;
						
	IF 	SQLCA.SQLCode <> 100 AND SQLCA.SQLCode <> 0 THEN
		uf.mbox("Fehler bei Lesen Distribution Errors",sqlca.sqlerrtext)
		ROLLBACK;
		RETURN FALSE
	END IF

ELSE // IF ls_save_distrtibution = "1" ...
	
	// Also keine Mahlzeitenverteilung aus der Sicherung => Raus ...
	RETURN FALSE
	
END IF

RETURN TRUE
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

public function integer of_run_pps ();/* ### Event: of_run_pps ***********************************************
*
* Beschreibung : F$$HEX1$$fc00$$ENDHEX$$r PPS angepa$$HEX1$$df00$$ENDHEX$$te Funktion von of_run
*
* Aenderungshistorie
*  Version  Wer                        Wann        Was und warum
*   1.0     H.Rothenbach /LSY IS       19.04.2007  Erstellung
*  
 * ### END Eventdoku ***************************************************
*/

Long                                                                                                    I, lKey, lStart, lEnde, lfound
string                                                                                   ssearch,s_airline
s_distribution_manual                 strReturn

// ---------------------------------------------------------------
// Die "Kopfinformationen" retrieven
// ---------------------------------------------------------------
lStart = CPU()

this.dsFlight.Retrieve(this.lResultKey)

if this.dsFlight.RowCount() = 0 then
                this.sError = "No flight information found!"
                return -1
else
                // Ggf. Mahlzeitenverteilung aus Sicherung holen ...
                // Wir holen uns f$$HEX1$$fc00$$ENDHEX$$r FTQ keine Verteilung aus der Sicherung
                //IF of_restore_distribution() THEN
                //            lEnde = CPU()
                
                               //MB 04.03.2013: Duplizierung noch machen, sonst funktioniert die Labelerstellung nicht richtig
                //            this.dtDeparture             = this.dsFlight.GetItemDateTime(1, "ddeparture")
                //            this.of_add_text_to_label()
                               
                //            of_log("Distribution took " + string((lEnde - lStart)/1000, "0.00") + " seconds!")
                //            RETURN 0
                //ELSE

                               this.lAircraftKey               = this.dsFlight.GetItemNumber(1, "naircraft_key")
                               this.lAirlineKey                 = this.dsFlight.GetItemNumber(1, "ncustomer_key")
                               this.dtDeparture             = this.dsFlight.GetItemDateTime(1, "ddeparture")
                               this.sViewUnit                 = this.dsFlight.GetItemString(1, "cunit")
                               this.lGroupKey                 = this.dsFlight.GetItemNumber(1, "nresult_key_group")
                               
                               //-----------------------------------------------
                               //16.06.2010 M.Barfknecht
                               //iAccumulateSPML und iExplodeSPML an dieser Stelle Airlinespezifisch setzen, falls es eine Airlinespezifische Abweichung gibt
                               //-------------------------------------------------
                               dsAirlineInfo = create datastore
                               dsAirlineInfo.dataobject = "dw_print_spml_airlines"
                               dsAirlineInfo.Settransobject(SQLCA)
                               dsAirlineInfo.retrieve(this.sViewUnit)
                               
                               Select cairline into :s_airline
                               from cen_airlines
                               where nairline_key = :lAirlineKey;
                
                               ssearch = "cf_airline = '" + s_airline +"'"
                               lfound = dsAirlineInfo.find(ssearch,1,dsAirlineInfo.rowcount())
                               if lfound > 0 then
                                               this.iAccumulateSPML                                = integer(dsAirlineInfo.getitemstring(lfound,"cf_accum_spmls"))
                                               this.iExplodeSPML                                                         = integer(dsAirlineInfo.getitemstring(lfound,"cf_explode_spml"))
                                               this.iAccumulateSPMLType        = integer(dsAirlineInfo.getitemstring(lfound,"cf_accum_spmls_type")) // 24.04.2013 HR: CBASE-AKL-CR-2013-003
                                               this.of_get_handling(this.lResultKey)
                               else
                                               this.iAccumulateSPML                                 = Integer(f_unitprofilestring("Default","ACCUM_SPMLS","0", this.sViewUnit))
                                               this.iExplodeSPML                                                         = Integer(f_unitprofilestring("Default","EXPLODE_SPML","1", this.sViewUnit))
                                               this.iAccumulateSPMLType        = integer(f_unitprofilestring("Default","ACCUM_SPMLS_TYPE","0", this.sViewUnit)) // 24.04.2013 HR: CBASE-AKL-CR-2013-003
                                               this.of_get_handling(this.lResultKey)
                               end if
                               //MB 15.05.2013: destroy erg$$HEX1$$e400$$ENDHEX$$nzt
                               destroy dsAirlineInfo    
                //END IF                                                             
end if


// --------------------------------------------------------------------------------------------------------------------
// 04.02.2014 HR: Hier 2 Kombinationen, die in FTQ n icht m$$HEX1$$f600$$ENDHEX$$glich sind
// --------------------------------------------------------------------------------------------------------------------
if this.iAccumulateSPMLType = 1 then
                this.iAccumulateSPMLType = 0
end if

if this.iAccumulateSPML=1 and this.iExplodeSPML=0 then 
                this.iExplodeSPML=1 // 19.02.2014 HR: Wenn $$HEX1$$fc00$$ENDHEX$$ber Type verteilt, dann muss auch wieder auf SL aufgel$$HEX1$$f600$$ENDHEX$$st werden
                
end if

// ---------------------------------------------------------------
// Labeltypen, die Mahlzeiten darstellen k$$HEX1$$f600$$ENDHEX$$nnen
// ---------------------------------------------------------------
this.dsLabelTypes.Retrieve(this.dtDeparture)

// ---------------------------------------------------------------
// Die Klassen der Airline retrieven
// ---------------------------------------------------------------
this.dsClasses.Retrieve(this.lAirlineKey)

if this.dsClasses.RowCount() = 0 then
                this.sError = "No classnames defined!"
                return -1
end if

// ---------------------------------------------------------------
// Die St$$HEX1$$fc00$$ENDHEX$$cklistentypen retrieven
// ---------------------------------------------------------------
this.dsPackinglistTypes.Retrieve()

if dsPackinglistTypes.RowCount() = 0 then
                this.sError = "No packinglist types defined!"
                return -1
end if

// ---------------------------------------------------------------
// Stauortzuordnungen retrieven
// ---------------------------------------------------------------
this.dsStowageGroups.Retrieve(this.lAircraftKey)
this.of_log("Found [" + string(this.dsStowageGroups.RowCount()) + "] stowage group assignments for AircraftKey: " + String(this.lAircraftKey))

// ---------------------------------------------------------------
// Die Meals/Extrabeladung retrieven
// 1 = Meals
// 2 = Extrabeladung
// ---------------------------------------------------------------
// # nicht in FTQ# this.of_load_components(1)
// # nicht in FTQ# this.of_load_components(2)
//f_print_datastore(this.dsMeals)

// ---------------------------------------------------------------
// Die Legs retrieven
// ---------------------------------------------------------------
this.dsLeg.Retrieve(this.lResultKeys)

// f_print_datastore(this.dsLeg)
// ---------------------------------------------------------------
// Die SPML's retrieven
// ---------------------------------------------------------------
// # nicht in FTQ# this.dsSPML.Retrieve(this.lResultKeys)
// # nicht in FTQ# this.of_move_spmls()


//f_print_datastore(dsSPMLDistribution)
//f_print_datastore(dsSPML)

// ---------------------------------------------------------------
// Gibts denn $$HEX1$$fc00$$ENDHEX$$berhaupt was zu verteilen ???
// ---------------------------------------------------------------
// 16.02.2016 HR: Wir f$$HEX1$$fc00$$ENDHEX$$llen aus FTQ dsSPML nicht, daher Pr$$HEX1$$fc00$$ENDHEX$$fung auf dsSPMLDistribution umgebaut
//if this.dsMeals.RowCount() + this.dsAdditional.RowCount() + this.dsSPML.RowCount() = 0 then
if this.dsMeals.RowCount() + this.dsAdditional.RowCount() + this.dsSPMLDistribution.RowCount() = 0 then
	this.sError = "Nothing to distribut!"
	return -2
end if

//f_print_datastore(dsMeals)
//f_print_datastore(dsAdditional)
//f_print_datastore(dsSPML)

// ---------------------------------------------------------------
// Klassennummern zuspielen
// 1 = Meals
// 2 = Extrabeladung
// 3 = SPML's
// 4 = dsLoadingList
// ---------------------------------------------------------------
this.of_add_classnumbers(1)
this.of_add_classnumbers(2)
this.of_add_classnumbers(3)
this.of_add_classnumbers(4)

//Sortierung  in FTQ
dsMeals.sort()
dsAdditional.sort() 
dsSPML.sort()

// -----------------------------------------------------
// Gibt es Stauorte
// -----------------------------------------------------
if isnull(dsLoadingList) or dsLoadingList.RowCount() <= 0 then
                this.sError = "No Basic Loading found!"
                this.of_log(this.sError)
                return -1
else
                //this.of_hide_columns()
end if

// -----------------------------------------------------
// Verteilungsparameter pro Galley einsammeln
// -----------------------------------------------------
if this.of_get_distribution_parameters() <> 0 then
                this.of_log(this.sError)
//            return -1
end if

// -----------------------------------------------------
// Die H$$HEX1$$f600$$ENDHEX$$hen und Tiefen ermitteln
// -----------------------------------------------------
if this.of_get_dimensions() <> 0 then
                this.of_log(this.sError)
//            return -1
end if


// -----------------------------------------------------
// Klassen l$$HEX1$$f600$$ENDHEX$$schen, wenn MCD Verteilung erfolgen soll
// -----------------------------------------------------
this.of_mcd_prepare()

// -----------------------------------------------------
//
// Automatische Verteilung anwerfen
//
// -----------------------------------------------------
// # nicht in FTQ# if this.bManuelDistribution = false then
                
                
// # nicht in FTQ# //       Messagebox("", "drin")
// # nicht in FTQ#            // -----------------------------------------------------
// # nicht in FTQ#            // Los gehts ....
// # nicht in FTQ#            // Verteilung Mahlzeiten / Extrabeladung
// # nicht in FTQ#            // Parameter:
// # nicht in FTQ#            // 1 = Mahlzeiten
// # nicht in FTQ#            // 2 = Extrabeladung
// # nicht in FTQ#            // 3 = SPML's
// # nicht in FTQ#            // -----------------------------------------------------
// # nicht in FTQ#            this.of_distribution(3)
// # nicht in FTQ#            this.of_distribution(1)
// # nicht in FTQ#            this.of_distribution(2)
                
// # nicht in FTQ#            this.of_to_errorlist(1)
// # nicht in FTQ#            this.of_to_errorlist(2)
// # nicht in FTQ#            this.of_to_errorlist(3)
                
// # nicht in FTQ#            this.of_distribution_errorlist()
                
// # nicht in FTQ#            // -----------------------------------------------------
// # nicht in FTQ#            // 08.05.2006 
// # nicht in FTQ#            // Mehrklassige Beh$$HEX1$$e400$$ENDHEX$$ltnisse erst am Ende bef$$HEX1$$fc00$$ENDHEX$$llen
// # nicht in FTQ#            // -----------------------------------------------------
// # nicht in FTQ#            if this.iMixed = 1 then
// # nicht in FTQ#                            this.of_log("Removing MultiClassFlag .......")
// # nicht in FTQ#                            this.of_remove_multiclass_flag()
// # nicht in FTQ#                            this.of_distribution_errorlist()
// # nicht in FTQ# end if 

// # nicht in FTQ# //       Messagebox("this.bManuelDistribution            ", this.bManuelDistribution)        
// # nicht in FTQ# //       f_print_datastore(this.dsDistributionErrors)
// # nicht in FTQ# // --------------------------------------------------------
// # nicht in FTQ# //
// # nicht in FTQ# // Automatische Verteilung mit manuellem Fehlerhandling
// # nicht in FTQ# //
// # nicht in FTQ# // --------------------------------------------------------

// # nicht in FTQ# elseif this.bManuelDistribution = true and this.bManuelDistributionOnError = true then

// --------------------------------------------------------
// Automatische Verteilung mit manuellem Fehlerhandling
// --------------------------------------------------------
if this.bPPSDistribution = true then //19.03.2008 HR      
                this.of_distribution(3)
                this.of_distribution(1)
                this.of_distribution(2)
                
                this.of_to_errorlist(1)
                this.of_to_errorlist(2)
                this.of_to_errorlist(3)
                this.of_distribution_errorlist()
                
                // -----------------------------------------------------
                // 08.05.2006 
                // Mehrklassige Beh$$HEX1$$e400$$ENDHEX$$ltnisse erst am Ende bef$$HEX1$$fc00$$ENDHEX$$llen
                // -----------------------------------------------------
                if this.iMixed = 1 then
                               this.of_log("Removing MultiClassFlag .......")
                               this.of_remove_multiclass_flag()
                               this.of_distribution_errorlist()
                end if 
                
                if this.dsDistributionErrors.RowCount() > 0 then
                               
                               openwithparm(w_manual_distribution, this)
                               strReturn = message.PowerObjectParm
                               
                               yield()
                               
                               if not isvalid(strReturn) then
                                               // ---------------------------------
                                               // Anwender hat abgebrochen alles
                                               // in die Fehlerliste kopieren
                                               // ---------------------------------
                                               this.of_to_errorlist(1)
                                               this.of_to_errorlist(2)
                                               this.of_to_errorlist(3)
                               end if
                
                               bReturnWithoutAbort = strReturn.bReturnWithoutAbort // 26.02.2015 HR: CBASE-CFC-CR-2014-001
                               
                               if not strReturn.bSuccessful  then
                                               
                                               // ---------------------------------

                                               // Anwender hat abgebrochen alles
                                               // in die Fehlerliste kopieren
                                               // ---------------------------------
                                               this.of_to_errorlist(1)
                                               this.of_to_errorlist(2)
                                               this.of_to_errorlist(3)
                                               return -1000

                               else
                                               
                                               this.dsLoadinglist.Reset()
                                               strReturn.uoReturn.dsLoadinglist.SetFilter("")
                                               strReturn.uoReturn.dsLoadinglist.Filter()
                                               strReturn.uoReturn.dsLoadinglist.RowsCopy(1, &
                                                                                                                                                                                                                                                                          strReturn.uoReturn.dsLoadinglist.RowCount(), &
                                                                                                                                                                                                                                                                          Primary!, &
                                                                                                                                                                                                                                                                          this.dsLoadinglist, &
                                                                                                                                                                                                                                                                          1, &
                                                                                                                                                                                                                                                                          Primary!)
                                                                                                                                                                                                                           
                                               this.dsDistribution                                                                         = strReturn.uoReturn.dsDistribution                                                                                                                   
                                               this.dsMeals                                                                                                    = strReturn.uoReturn.dsMeals
                                               this.dsAdditional                                                                            = strReturn.uoReturn.dsAdditional
                                               this.dsSPMLDistribution                                              = strReturn.uoReturn.dsSPMLDistribution
                                               this.dsAdditionalDistribution                     = strReturn.uoReturn.dsAdditionalDistribution
                                               this.dsSPML                                                                                                     = strReturn.uoReturn.dsSPML
                                               this.dsDistributingMeals                                             = strReturn.uoReturn.dsDistributingMeals
                                               this.dsDistributingAdditional                     = strReturn.uoReturn.dsDistributingAdditional
                                               this.uoStowages[]                                                                         = strReturn.uoReturn.uoStowages[]
                                               this.dsDistributionErrors                                             = strReturn.uoReturn.dsDistributionErrors
                                               
                                               // ---------------------------------

                                               // Falls es Reste gibt, diese
                                               // in die Fehlerliste kopieren
                                               // ---------------------------------
                                               this.of_to_errorlist(1)
                                               this.of_to_errorlist(2)
                                               this.of_to_errorlist(3)
                                               
                               end if    
                               
                end if


                
// -----------------------------------------------------
//
// Manuelle Verteilung anwerfen

//
// -----------------------------------------------------
// # nicht in FTQ# elseif this.bManuelDistribution = true and this.bManuelDistributionOnError = false then
else       
                openwithparm(w_manual_distribution, this)
                strReturn = message.PowerObjectParm
                
                yield()
                
                if not isvalid(strReturn) then
                               // ---------------------------------
                               // Anwender hat abgebrochen alles in die Fehlerliste kopieren
                               // ---------------------------------
                               this.of_to_errorlist(1)
                               this.of_to_errorlist(2)
                               this.of_to_errorlist(3)
                end if

                bReturnWithoutAbort = strReturn.bReturnWithoutAbort // 26.02.2015 HR: CBASE-CFC-CR-2014-001
                
                if not strReturn.bSuccessful  then
                               // ---------------------------------
                               // Anwender hat abgebrochen alles in die Fehlerliste kopieren
                               // ---------------------------------
                               this.of_to_errorlist(1)
                               this.of_to_errorlist(2)
                               this.of_to_errorlist(3)
                               return -1000
                               
                else
                               
                               this.dsLoadinglist.Reset()
                               strReturn.uoReturn.dsLoadinglist.SetFilter("")
                               strReturn.uoReturn.dsLoadinglist.Filter()
                               strReturn.uoReturn.dsLoadinglist.RowsCopy(1, &
                                                                                                                                                                                                                                                           strReturn.uoReturn.dsLoadinglist.RowCount(), &
                                                                                                                                                                                                                                                           Primary!, &
                                                                                                                                                                                                                                                           this.dsLoadinglist, &
                                                                                                                                                                                                                                                           1, &
                                                                                                                                                                                                                                                           Primary!)
                               
                               this.dsDistribution                                                                         = strReturn.uoReturn.dsDistribution                                                                                                                   
                               this.dsFlight                                                                                                     = strReturn.uoReturn.dsFlight
                               this.dsMeals                                                                                                    = strReturn.uoReturn.dsMeals
                               this.dsAdditional                                                                                           = strReturn.uoReturn.dsAdditional
                               this.dsSPMLDistribution                                                             = strReturn.uoReturn.dsSPMLDistribution
                               this.dsAdditionalDistribution                     = strReturn.uoReturn.dsAdditionalDistribution
                               this.dsSPML                                                                                                                    = strReturn.uoReturn.dsSPML
                               this.dsDistributingMeals                                             = strReturn.uoReturn.dsDistributingMeals
                               this.dsDistributingAdditional                     = strReturn.uoReturn.dsDistributingAdditional
                               this.uoStowages[]                                                                                        = strReturn.uoReturn.uoStowages[]
                               this.dsDistributionErrors                                             = strReturn.uoReturn.dsDistributionErrors
                
                               this.sHandlingString                                                                      =             strReturn.uoReturn.sHandlingString
                               
                               // ---------------------------------

                               // Falls es Reste gibt, diese
                               // in die Fehlerliste kopieren
                               // ---------------------------------
                               this.of_to_errorlist(1)
                               this.of_to_errorlist(2)
                               this.of_to_errorlist(3)
                               
                end if
                
end if

// -----------------------------------------------------
// Den Screen wieder h$$HEX1$$fc00$$ENDHEX$$bsch machen !!!
// -----------------------------------------------------

// # nicht in FTQ# if isvalid(w_mdi_master) then w_print_center.setredraw(false)       
// # nicht in FTQ# if isvalid(w_mdi_master) then w_print_center.setredraw(true)        

// # nicht in FTQ# if isvalid(w_print_center) then w_print_center.setredraw(false)      
// # nicht in FTQ# if isvalid(w_print_center) then w_print_center.setredraw(true)       


this.dsLoadingList.SetFilter("")
this.dsLoadingList.Filter()

// -----------------------------------------------------
// Klassen zuspielen, wenn MCD Verteilung erfolgt ist
// -----------------------------------------------------
this.of_mcd_complete()

// -----------------------------------------------------
// Das Location Sheet
// -----------------------------------------------------
if this.bLocationSheet then
                this.of_format_datastore_report(this.dsLocationSheet, "Location Sheet")
                this.of_get_location_sheet()

                if this.dsLocationSheet.RowCount() = 0 then
                               SetNull(this.blbLocationSheet)
                else
                               this.dsLocationSheet.GetFullState(this.blbLocationSheet)
                end if
                
end if 

// -----------------------------------------------------
// SPML Summary
// -----------------------------------------------------
if this.bSPMLSummary then
                if iWebService = 0 then
                               this.of_format_datastore_report(this.dsSPMLSummary, uf.translate("SPML-Liste"))
                else
                               this.of_format_datastore_report(this.dsSPMLSummary, "SPML-Sheet")
                end if
                
                this.of_get_spml_sheet()

                
                if this.dsSPMLSummary.RowCount() = 0 then
                               SetNull(this.blbSPMLSummary)
                else
                               this.dsSPMLSummary.GetFullState(blbSPMLSummary)
                end if
                
else
                SetNull(this.blbSPMLSummary)
end if 

// -----------------------------------------------------
// In die Arrays ins dsLoadingList $$HEX1$$fc00$$ENDHEX$$bertragen
// -----------------------------------------------------
this.of_add_text_to_label()
this.of_check_labeltypes()

// -----------------------------------------------------
// Die Fehlerliste h$$HEX1$$fc00$$ENDHEX$$bsch machen
// -----------------------------------------------------
string sFlight, sDeparture, sAircraft, sVersion

if this.dsDistributionErrors.RowCount() > 0 then 

                sFlight                                  = dsFlight.GetItemString(1, "cairline") + " " + String(dsFlight.GetItemNumber(1, "nflight_number"), "000") + " " + dsFlight.GetItemString(1, "csuffix")
                sDeparture                        = String(dsFlight.GetItemDateTime(1, "ddeparture"), s_app.sDateFormat) + "/" + dsFlight.GetItemString(1, "cdeparture_time")
                sAircraft                              = dsFlight.GetItemString(1, "cairline_owner") + " " + dsFlight.GetItemString(1, "cactype") + " [" + dsFlight.GetItemString(1, "cgalleyversion") + "]"
                sVersion                             = dsFlight.GetItemString(1, "cconfiguration")
                
                this.dsDistributionErrors.Modify("t_header1.text='" + sFlight + " - " + sDeparture + "'")
                this.dsDistributionErrors.Modify("t_header2.text='Aircraft: " +  sAircraft + " / " + sVersion + "'")
                
                if iWebService = 0 then
                               this.of_format_datastore_report(this.dsDistributionErrors, uf.translate("Fehlerliste Komponentenverteilung"))
                else
                               this.of_format_datastore_report(this.dsDistributionErrors, "Distribution Errors")
                end if
                
                this.dsDistributionErrors.Sort()
                this.dsDistributionErrors.GetFullState(blbDistributionErrors)
else
                SetNull(blbDistributionErrors)
end if

//f_print_datastore(this.dsLocationSheet)
//f_print_datastore(dsLoadingList)
//f_print_datastore(dsDistributingMeals)
//f_print_datastore(dsFlight)
//f_print_datastore(dsMeals)
//f_print_datastore(dsSPML)

this.dsMeals.SetFilter("")
this.dsMeals.Filter()
this.dsAdditional.SetFilter("")
this.dsAdditional.Filter()

// # nicht in FTQ# of_store_distribution()

lEnde = CPU()
of_log("Distribution took " + string((lEnde - lStart)/1000, "0.00") + " seconds!")

return 0

end function

public function integer of_explode_spmlstype ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_distribution
// Methode: of_explode_spmlstype (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Es sollen nach SPML-Type gruppiert werden (CBASE-AKL-CR-2013-003)
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  25.04.2013	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
Long 			a, lStowages, I, J, K, lQuantity, lMovedQuantity, lTempQuantity
Long 			lPlType, lClass, lFound
String 		sPlType, sMealControlCode, sClass, sFilter, sPackinglist
Datastore	dsSPMLControl, dsTemp
Long 			lPlTypeMaster				
String 		sPlTypeMaster				
Long 			lClassMaster				
String 		sMealControlCodeMaster	
String 		sClassMaster	
String 		sPLMaster	
Long 			lHeight
Long 			lWidth

dsTemp = create datastore
dsTemp.dataobject = "dw_uo_content"

this.of_log("Entering of_explode_spmls ......")

// ------------------------------------------------------------------
// Stauort f$$HEX1$$fc00$$ENDHEX$$r Stauort beackern
// ------------------------------------------------------------------
for lStowages = 1 to Upperbound(this.uoStowages)
	
	this.uoStowages[lStowages].dsContent.SetFilter("nspml=1")
	this.uoStowages[lStowages].dsContent.Filter()
	
	if this.uoStowages[lStowages].dsContent.RowCount() <= 0 then 
		this.uoStowages[lStowages].dsContent.SetFilter("")
		this.uoStowages[lStowages].dsContent.Filter()
		continue
	end if
	
	// ------------------------------------------------------------------
	// OK, es sind SPML's im Stauort. Diese jetzt in den Details suchen und von dort in den Stauort zur$$HEX1$$fc00$$ENDHEX$$ckholen
	// ------------------------------------------------------------------
	this.of_log("Stowage: " + this.uoStowages[lStowages].sStowage + " contains " + string(this.uoStowages[lStowages].dsContent.RowCount()) + " SPML's" )
	
	For I = this.uoStowages[lStowages].dsContent.RowCount() to 1 step -1
		
		lQuantity 			= 0
		lMovedQuantity 	= 0
		
		// F$$HEX1$$fc00$$ENDHEX$$r jedes kummulierte SPML, dass im Stauort ist die passenden Details rausfiltern
		sPackinglist			= this.uoStowages[lStowages].dsContent.GetItemString(I, "cpackinglist")
		lPlType				= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "npltype_key")
		sPlType				= this.uoStowages[lStowages].dsContent.GetItemString(I, "cpl_type")
		lClass					= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nclass_number")
		sMealControlCode	= this.uoStowages[lStowages].dsContent.GetItemString(I, "cmeal_control_code")
		sClass				= this.uoStowages[lStowages].dsContent.GetItemString(I, "cclass")
		lQuantity				= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nquantity")
		lHeight				= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nheight")
		lWidth				= this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nwidth")

		this.of_log("[" + String(I) + "] - SPML Content " + String(lQuantity) + " x " + sPackinglist)
				
		this.dsSPMLDistributionMaster.SetFilter("npltype_key=" + string(lPlType) + &
												" and nclass_number=" + string(lClass) + &
												" and cmeal_control_code='" + sMealcontrolCode + "'" + & 
												" and nheight = " + string(lHeight)  + &
												" and nwidth = " + string(lWidth)  + &
												" and nquantity > 0")
												
		this.dsSPMLDistributionMaster.Filter()		
		
		if this.dsSPMLDistributionMaster.RowCount() = 0 then
			this.of_log("[" + String(I) + "] - Found no Details for " + sPlType + "/" + String(lPlType) + " + " + sClass + "/" + string(lClass) + " + " + sMealcontrolCode + "  Height " + String(lHeight)  + " Width " + string(lWidth))
		end if
		
		for j = 1 to this.dsSPMLDistributionMaster.RowCount()
			
			lMovedQuantity = this.dsSPMLDistributionMaster.GetItemNumber(j, "nquantity")
			sPLMaster		= this.dsSPMLDistributionMaster.GetItemString(j, "cpackinglist")
			
			this.of_log("[" + String(I) + "] - Found   " + String(lMovedQuantity) + " x " + sPLMaster)
			
			if lMovedQuantity 	= 0 then continue
			if lQuantity 			= 0 then exit
			
			
			sFilter = "cpackinglist = '" + sPLMaster +"'"
			sFilter += "and cclass = '"+ sClass + "'"
			sFilter += "and cpl_type = '" + sPlType + "'"
			// ------------------------------------------------
			// lQuantity 			= Anzahl SPML's im Stauort
			// lMovedQuantity	= tats$$HEX1$$e400$$ENDHEX$$chliche Anzahl SPML's 
			// ------------------------------------------------
			// Passen alle rein
			//       3        <=    5
			// ------------------------------------------------
			if lMovedQuantity <= lQuantity then
				a = dsTemp.find(sFilter, 1, dsTemp.rowcount())
				
				if a> 0 then
					
					lTempQuantity = dsTemp.GetItemNumber(a, "nquantity")
					lTempQuantity += lMovedQuantity
					dsTemp.SetItem(a, "nquantity", lTempQuantity)

					this.of_log("[1][" + String(I) + "] - Added   " + String(lMovedQuantity) + " x " + sPLMaster +" - NEW: "+string(lTempQuantity))
				else
				
					a = dsTemp.Insertrow(0)
					
					dsTemp.SetItem(a, "nspml", 1)
					dsTemp.SetItem(a, "cpackinglist",sPLMaster )
					dsTemp.SetItem(a, "ctext", this.dsSPMLDistributionMaster.GetItemString(j, "cproduction_text"))
					dsTemp.SetItem(a, "cremark", this.dsSPMLDistributionMaster.GetItemString(j, "cremark"))
					dsTemp.SetItem(a, "nheight", this.dsSPMLDistributionMaster.GetItemNumber(j, "nheight"))
					dsTemp.SetItem(a, "nwidth", this.dsSPMLDistributionMaster.GetItemNumber(j, "nwidth"))
					dsTemp.SetItem(a, "npl_distribution_key", 0)
					dsTemp.SetItem(a, "npltype_key", lPlType)
					dsTemp.SetItem(a, "cpl_type", sPlType)
					dsTemp.SetItem(a, "nclass_number", lClass)
					dsTemp.SetItem(a, "cclass", sClass)
					dsTemp.SetItem(a, "cmeal_control_code", sMealControlCode)
					dsTemp.SetItem(a, "nquantity", lMovedQuantity)
					dsTemp.SetItem(a, "nheight", lHeight)
					dsTemp.SetItem(a, "nwidth", lWidth)
					
					this.of_log("[1][" + String(I) + "] - Added   " + String(lMovedQuantity) + " x " + sPLMaster)
				end if
				
				this.dsSPMLDistributionMaster.SetItem(j, "nquantity", 0)
										
				this.of_log("[1][" + String(I) + "] - Stowage now Contains: " + string(this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nquantity")) + " SPML's")
				
				lQuantity = lQuantity - lMovedQuantity
				this.uoStowages[lStowages].dsContent.SetItem(I, "nquantity", lQuantity)
								
			// ------------------------------------------------					
			// Passt nur ein Teil rein	
			//           2             1
			// ------------------------------------------------
			elseif lMovedQuantity > lQuantity then
				a = dsTemp.find(sFilter, 1, dsTemp.rowcount())
				
				if a> 0 then
					
					lTempQuantity = dsTemp.GetItemNumber(a, "nquantity")
					lTempQuantity += lQuantity
					dsTemp.SetItem(a, "nquantity", lTempQuantity)

					this.of_log("[2][" + String(I) + "] - Added   " + String(lQuantity) + " x " + sPLMaster +" - NEW: "+string(lTempQuantity))
				else
			
					a = dsTemp.Insertrow(0)
	
					dsTemp.SetItem(a, "nspml", 1)
					dsTemp.SetItem(a, "cpackinglist", sPLMaster)
					dsTemp.SetItem(a, "ctext", this.dsSPMLDistributionMaster.GetItemString(j, "cproduction_text"))
					dsTemp.SetItem(a, "cremark", this.dsSPMLDistributionMaster.GetItemString(j, "cremark"))
					dsTemp.SetItem(a, "nheight", this.dsSPMLDistributionMaster.GetItemNumber(j, "nheight"))
					dsTemp.SetItem(a, "nwidth", this.dsSPMLDistributionMaster.GetItemNumber(j, "nwidth"))
					dsTemp.SetItem(a, "npl_distribution_key", 0)
					dsTemp.SetItem(a, "npltype_key", lPlType)
					dsTemp.SetItem(a, "cpl_type", sPlType)
					dsTemp.SetItem(a, "nclass_number", lClass)
					dsTemp.SetItem(a, "cclass", sClass)
					dsTemp.SetItem(a, "cmeal_control_code", sMealControlCode)
					dsTemp.SetItem(a, "nquantity", lQuantity)
					
					this.of_log("[2][" + String(I) + "] - Added   " + String(lQuantity) + " x " + sPLMaster)
				end if
				
				this.dsSPMLDistributionMaster.SetItem(j, "nquantity", lMovedQuantity - lQuantity)
				
				this.uoStowages[lStowages].dsContent.SetItem(I, "nquantity", 0)
				lQuantity = 0
								
				this.of_log("[2][" + String(I) + "] - Stowage now Contains: " + string(this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nquantity")) + " SPML's")
				
			else
				this.of_log("[2][" + String(I) + "] -	ELSE ??  lMovedQuantity=" + String(lMovedQuantity) + " lQuantity=" + String(lQuantity))
			end if
			
	
			
		next
		
		if this.uoStowages[lStowages].dsContent.GetItemNumber(I, "nquantity") = 0 then 
			this.of_log("[" + String(I) + "] - Remove " + sPLMaster)
			this.uoStowages[lStowages].dsContent.DeleteRow(I)
		end if

	Next
		
	this.uoStowages[lStowages].dsContent.SetFilter("")
	this.uoStowages[lStowages].dsContent.Filter()
	
	dsTemp.RowsCopy(1, dsTemp.RowCount(), Primary!, this.uoStowages[lStowages].dsContent, this.uoStowages[lStowages].dsContent.RowCount() + 1, Primary!)
	dsTemp.Reset()
	
Next

this.dsSPMLDistributionMaster.SetFilter("")
this.dsSPMLDistributionMaster.Filter()	

//f_print_datastore(dsSPMLDistributionMaster)

For I = this.dsSPMLDistributionMaster.RowCount() to 1 step -1
	if this.dsSPMLDistributionMaster.GetItemNumber(I, "nquantity") = 0 then
		this.dsSPMLDistributionMaster.DeleteRow(I)
	else
		sPLMaster = this.dsSPMLDistributionMaster.GetItemString(I, "cpackinglist") 
		lQuantity = this.dsSPMLDistributionMaster.GetItemNumber(I, "nquantity") 
		this.of_log("Can't remove " + sPLMaster + " quantity is still " + string(lQuantity))
	end if
Next

// ------------------------------------------------------------------------
// Alles wieder in dsSPMLDistribution, damit ggf. Reste auf der Fehlerliste landen
// ------------------------------------------------------------------------
//f_print_datastore(this.dsSPMLDistribution)
this.dsSPMLDistribution.SetFilter("")
this.dsSPMLDistribution.Filter()	
this.dsSPMLDistribution.Reset()
//f_print_datastore(this.dsSPMLDistribution)

if this.dsSPMLDistributionMaster.RowCount() > 0 then
	this.dsSPMLDistributionMaster.RowsCopy(1, this.dsSPMLDistributionMaster.RowCount(), Primary!, this.dsSPMLDistribution, 1, Primary!)
end if 

//f_print_datastore(this.dsSPMLDistribution)
//f_print_datastore(this.dsSPMLDistributionMaster)

return 0
end function

public function integer of_get_distribution_parameters_by_ac ();
// --------------------------------------------------------------------------------
// Objekt : uo_distribution
// Methode: of_get_distribution_parameters_by_ac (Function)
// Datum  : 22.08.2016
//
// Argument(e):
// none
//
// Beschreibung:		Ermittlung nDistribution_Key per AC Type (CBASE-F4-CR-2015-014)
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	22.08.2016		Erstellung
//
//
// Return: integer
//
// --------------------------------------------------------------------------------

Integer	li_Succ
Long		ll_Start, ll_Ende
Long		ll_Rows_Per_AC_Type
LOng		ll_Count
Long		ll_Exception_Rows
Long		ll_Distribution_Key_per_Type
Long		ll_Distribution_Key
Long		ll_Flight_Number
Long		ll_Handling_type_key
Long		ll_tlc_From
Long		ll_tlc_To
Long		ll_Freq
Long		ll_Cover

String	ls_Departure_Time
String	ls_out
Date		ldt_Departure
String	ls_Filter
String	ls_Suffix


// Distribution per AC type union Default per Airline 
// dw_uo_distribution_by_ac_type retrieve airline key, aircraft Key

// Distribution Exceptions
// dw_uo_ac_distr_exceptions (airline key, aircraft Key)
// nactive = 1

// 1. Schritt
// wenn "Distribution per AC typ" einen Treffer pro Type hat => OK Key gefunden
// wenn "Distribution Default" einen Treffer pro Airline hat => OK Key gefunden

// 2.Schritt
// wenn "Exception" einen oder mehrere Treffer pro AC Type (oder ALL) hat => weiter filtern
// Filter: 
// (nActive = 1)
// Aircrafttyp = AC Type oder AC Type ALL = 1 
// Flugnummer = nflight_number oder Flight ALL = 1
// Suffix = cSuffix oder nSuffix ALL = 1
// Handling = nhandling_type_key oder nHandling_ALL = 1
// From = TLC From = ntlc_from ODER tlc_from_ALL = 1
// To   = TLC To   = ntlc_to   ODER tlc_to_ALL = 1
// Abflugzeit cdeparture_time between ctime_from and ctime_to
// Abflugdatum between cen_aircraft_distr_ex.dvalid_from and cen_aircraft_distr_ex.dvalid_to  
// Frequenz  ll_freq = f_getfrequence(departure) => setfilter nfreq + String(ll_Freq) = 1

ll_Start = CPU()

ll_Rows_Per_AC_Type = dsDistributionPerACType.Retrieve(lAirlineKey, lAircraftKey )
// ---------------------------------------------------------------
// 2 Rows = Treffer pro Type UND Default pro Airline  
// 1 Row  = entweder Default oder pro Typ gefunden
// ---------------------------------------------------------------
 
if this.dsDistributionPerACType.RowCount() = 0 then
	this.sError = "No parameters for Meal distribution found for airline " + String(lAirlineKey)
	return -1
End If

If ll_Rows_Per_AC_Type > 0 Then
	ll_Distribution_Key_per_Type =  dsDistributionPerACType.GetItemNumber(1, "ndistribution_key" )
End If
	
ll_Distribution_Key	= ll_Distribution_Key_per_Type

ll_Exception_Rows = dsDistributionExceptions.Retrieve(lAirlineKey, lAircraftKey )
If ll_Exception_Rows > 0 Then
	If dsFlight.RowCount() > 0 Then
		ll_Flight_Number = dsFlight.GetItemNumber(1, "nflight_number")
		ls_Suffix = dsFlight.GetItemString(1, "csuffix")
		ll_Handling_type_key = dsFlight.GetItemNumber(1, "nhandling_type_key")
		ll_tlc_From = dsFlight.GetItemNumber(1, "ntlc_from")
		ll_tlc_To = dsFlight.GetItemNumber(1, "ntlc_to")
		ls_Departure_Time= dsFlight.GetItemString(1, "cdeparture_time")
		ldt_Departure= Date(dsFlight.GetItemDateTime(1, "ddeparture"))

		ll_Freq = f_getfrequence(ldt_Departure) // =>setfilter nfreq + String(ll_Freq) = 1
		
		ls_Filter  = "(nflight_number=" + String( ll_Flight_Number ) + " OR nflight_number_all=1)"
		ls_Filter += " AND (csuffix='" + ls_Suffix + "' OR nsuffix_all=1)"
		ls_Filter += " AND (nhandling_type_key=" + String( ll_Handling_type_key ) + " OR nhandling_type_all=1)"
		ls_Filter += " AND (ntlc_from=" + String( ll_tlc_From ) + " OR ntlc_from_ALL=1)"
		ls_Filter += " AND (ntlc_to=" + String( ll_tlc_to ) + " OR ntlc_to_ALL=1)"	
		ls_Filter += " AND (nfreq" + String( ll_Freq ) + "=1)"
		
		// Handling = nhandling_type=key oder nHandling_ALL = 1
		// From = TLC From = ntlc_from ODER tlc_from_ALL = 1
		// To   = TLC To   = ntlc_to   ODER tlc_to_ALL = 1
		// Abflugzeit cdeparture_time between ctime_from and ctime_to
		// Abflugdatum between cen_aircraft_distr_ex.dvalid_from and cen_aircraft_distr_ex.dvalid_to  
		// Frequenz  ll_freq = f_getfrequence(departure) =>setfilter nfreq + String(ll_Freq) = 1
	
		li_Succ = dsDistributionExceptions.SetFilter(ls_Filter)
		li_Succ = dsDistributionExceptions.Filter()
		
		ll_Exception_Rows = dsDistributionExceptions.RowCount()
		CHOOSE CASE	ll_Exception_Rows
			CASE 0
				// Keine Ausnhame gefunden => OK
			CASE 1
				// 1 Treffer => Key setzen
				ll_Distribution_Key = dsDistributionExceptions.GetItemNumber(1, "ndistribution_key" )
			CASE IS > 0 	
				// mehr als 1 Treffer
				
				// #### was tun? => zun$$HEX1$$e400$$ENDHEX$$chst mal Key aus Zeile 1 verwenden...
				ll_Distribution_Key =  dsDistributionExceptions.GetItemNumber(1, "ndistribution_key" )
				of_log("of_get_distribution_parameters_by_ac found multiple exceptions (" + String(ll_Exception_Rows) + ") using random one")
				
		END CHOOSE
	End If
End If

If ll_Distribution_Key > 0 Then
	ll_Distribution_Key = f_get_valid_distribution_key(ll_Distribution_Key,  date(dtDeparture) )
End If

// ---------------------------------------------------------------
//
// Verteilerroutine 
//
// ---------------------------------------------------------------

// Messagebox("", this.lAircraftKey)

// ---------------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r die Mahlzeitenbeladung
// ---------------------------------------------------------------
this.dsDistributingMeals.Retrieve(this.lAircraftKey)
		
if this.dsDistributingMeals.RowCount() = 0 then
	this.sError = "No galleyparameters for Meal distribution found"
	return -1
else
	
	if this.dsMeals.RowCount() > 0  then
		// ---------------------------------------------------------
		// Alle "unbest$$HEX1$$fc00$$ENDHEX$$ckten" Galley mit den Verteilungsparametern
		// aus dem "Cover Objekt" best$$HEX1$$fc00$$ENDHEX$$cken
		// ---------------------------------------------------------
		ll_Cover = this.dsMeals.GetItemNumber(1, "ncover_key")
		
		this.of_log("------------------------------------------------------------------------------------------------------------------------")
		ls_out = ""
		For ll_Count = 1 to Upperbound(lResultKeys)
			ls_out += String(lResultKeys[ll_Count])
			if ll_Count <>  Upperbound(lResultKeys) then
				ls_out += ", "
			end if
		Next
		
		this.of_log("nresult_keys = " + ls_out)
		this.of_log("AC Type is used to identify Distribution rule: " + this.dsMeals.GetItemString(1, "cpackinglist") + " - " + this.dsMeals.GetItemString(1, "cproduction_text"))
		this.of_log("-------------------------------------------------------------------------------------------------------------------------")
			
		if not isnull(ll_Cover) then
			// ----------------------------------------------------------------
			// Verteilerroutine f$$HEX1$$fc00$$ENDHEX$$r den AC-Typ wurde oben ermittelt
			// ----------------------------------------------------------------
			
			if this.iTrace = 1 then
				ls_out = ""
				select ctext into :ls_out from cen_handling where nhandling_key = :ll_Cover;
				if sqlca.sqlcode = 0 then
					this.of_log("[1] Meal loading is: " + ls_out)
				else
					this.of_log("Error getting Meal Loading description: " + sqlca.sqlerrtext)
				end if
				
				ls_out = ""
				select ctext into :ls_out from cen_distribution where ndistribution_key = :ll_Distribution_Key;
				if sqlca.sqlcode = 0 then
					this.of_log("Using Distribution rule: " + ls_out)
				else
					this.of_log("Error getting Distribution Rule description: " + sqlca.sqlerrtext)
				end if
			end if

			for ll_Count = 1 to this.dsDistributingMeals.RowCount()
				if isnull(this.dsDistributingMeals.GetItemNumber(ll_Count, "ndistribution_key")) then
					this.dsDistributingMeals.SetItem(ll_Count, "ndistribution_key", ll_Distribution_Key)
					this.dsDistributingMeals.SetItem(ll_Count, "ngroup", 9999)
				end if
			next
			
			for ll_Count = 1 to this.dsMeals.RowCount()
				this.dsMeals.SetItem(ll_Count, "ndistribution_key", ll_Distribution_Key)
			next
			
			// ------------------------------------
			// SPMLs auch 
			// ------------------------------------
			for ll_Count = 1 to this.dsSPMLDistribution.RowCount()
				this.dsSPMLDistribution.SetItem(ll_Count, "ndistribution_key", ll_Distribution_Key)
			next
		end if
		
	end if
	
end if

// ---------------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r die Extrabeladung
// ---------------------------------------------------------------
this.dsDistributingAdditional.Retrieve(this.lAircraftKey)
		
if this.dsDistributingAdditional.RowCount() = 0 then
	this.sError = "No galleyparameters for Additional distribution found"
	return -1
else
	
	if this.dsAdditional.RowCount() > 0  then
		// ---------------------------------------------------------
		// Alle "unbest$$HEX1$$fc00$$ENDHEX$$ckten" Galley mit den Verteilungsparametern
		// aus dem "Cover Objekt" best$$HEX1$$fc00$$ENDHEX$$cken
		// ---------------------------------------------------------
		ll_Cover = this.dsAdditional.GetItemNumber(1, "ncover_key")
		
		if ll_Cover = 0 then
			if this.dsMeals.RowCount() > 0 then
				ll_Cover = this.dsMeals.GetItemNumber(1, "ncover_key")
			else
				this.of_log("of_get_distribution_parameters_by_ac/ADDITIONAL found no distribution routine for aircraft: " + string(this.lAircraftKey))				
				return -1
			end if
		end if
		
				
		if not isnull(ll_Cover) then			
			// ----------------------------------------------------------------
			// Verteilerroutine wurde bereits oben ermittelt
			// ----------------------------------------------------------------
				
			for ll_Count = 1 to this.dsDistributingAdditional.RowCount()
				if isnull(this.dsDistributingAdditional.GetItemNumber(ll_Count, "ndistribution_key")) then
					this.dsDistributingAdditional.SetItem(ll_Count, "ndistribution_key", ll_Distribution_Key)
					this.dsDistributingAdditional.SetItem(ll_Count, "ngroup", 9999)
				end if
			next
			
			for ll_Count = 1 to this.dsAdditional.RowCount()
				this.dsAdditional.SetItem(ll_Count, "ndistribution_key", ll_Distribution_Key)
			next

		end if
		
	end if
	
end if

// ---------------------------------------------------------------
// Anhand der ersten Verteilerroutine ermitteln, ob es
// eine MCD Verteilung ist
// ---------------------------------------------------------------
if this.dsDistributingMeals.RowCount() > 0 then
	ll_Distribution_Key = this.dsDistributingMeals.GetItemNumber(1, "ndistribution_key")
elseif this.dsDistributingAdditional.RowCount() > 0 then
	ll_Distribution_Key = this.dsDistributingAdditional.GetItemNumber(1, "ndistribution_key")
else
	this.sError = "No distribution key found !!"
	return -1
end if

ll_Distribution_Key = f_get_valid_distribution_key(ll_Distribution_Key,  date(dtDeparture) )

select nmcd, nmixed into :this.iMCD, :this.iMixed  from cen_distribution where ndistribution_key = :ll_Distribution_Key;

if sqlca.sqlcode <> 0 then
	this.sError = "distribution key error: " + sqlca.sqlerrtext
	if isnull(this.iMCD) then this.iMCD = 0
	if isnull(this.iMixed) then this.iMixed = 0
	return -1
end if

if isnull(this.iMCD) then this.iMCD = 0
if isnull(this.iMixed) then this.iMixed = 0
// Messagebox("", "iMCD:" + string(iMcd) + "~riAccumulateSPML:" + String(iAccumulateSPML) +"~riMixed:" + String(iMixed))


ll_Ende = CPU()
of_log("of_get_distribution_parameters_by_ac() took " + string((ll_Ende - ll_Start)/1000, "0.00") + " seconds!")

return 0

end function

on uo_distribution.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_distribution.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
/* 
* Event: 				constructor
* Beschreibung: 	initialisiert die datastores udn was sonst noch so alles an vorbereitung notwenig ist
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 	Wer							Wann				Was und warum
*	1.0 		???							??.??.????		Erstellung
*	1.1 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel				06.11.2013		Schalter f$$HEX1$$fc00$$ENDHEX$$r landscape-distribution-error-report rein
*
* Return Codes:
*	0		continue  (PB)
*/

// hilfsvariable
integer iFile
uo_format_mandant luo_FormatMandant


//Objekt zur Berechnung von Schriftgr$$HEX2$$f600df00$$ENDHEX$$en erstellen
iuo_FontCalc = CREATE uo_font_calc

this.sLogPath 	= f_gettemppath()

dsFlight							= create datastore
dsLeg								= create datastore
dsMeals							= create datastore
dsSPML							= create datastore
dsSPMLDistribution			= create datastore
dsSPMLDistributionMaster	= create datastore
dsAdditional					= create datastore
dsAdditionalDistribution	= create datastore
dsAircraft						= create datastore 
dsClasses						= create datastore 
dsPackinglistSizes			= create datastore 
dsPackinglistTypes			= create datastore 
dsPackinglistSizeFind		= create datastore 
dsDistribution					= create datastore 
dsDistributingMeals			= create datastore 
dsDistributingAdditional	= create datastore 
dsDistributionParameter		= create	datastore
dsControl						= create datastore
dsDistributionErrors			= create datastore
dsDistributionPriority		= create datastore
dsLabelObjects					= create datastore
dsLocationSheet				= create uo_location_sheet
dsLoadingList					= create datastore
dsLabelTypes					= create datastore
dsCheckSheet					= create datastore
dsSPMLSummary					= create datastore
dsStowageGroups				= create datastore
dsStowageGroupValues			= create datastore

dsDistributionPerACType= create datastore
dsDistributionExceptions= create datastore

dsDistributionPerACType.dataobject = "dw_uo_cen_out"
dsDistributionPerACType.SetTransObject(sqlca)

dsDistributionExceptions.dataobject = "dw_uo_cen_out_all_legs"
dsDistributionExceptions.SetTransObject(sqlca)


dsFlight.dataobject = "dw_uo_cen_out"
dsFlight.SetTransObject(sqlca)

dsLeg.dataobject = "dw_uo_cen_out_all_legs"
dsLeg.SetTransObject(sqlca)

dsMeals.dataobject = "dw_uo_cen_out_meals"
dsMeals.SetTransObject(sqlca)

dsSPML.dataobject = "dw_uo_cen_out_spml"
dsSPML.SetTransObject(sqlca)

dsAdditional.dataobject = "dw_uo_cen_out_meals"
dsAdditional.SetTransObject(sqlca)

dsAircraft.dataobject = "dw_uo_aircrafttype"
dsAircraft.SetTransObject(sqlca)

dsClasses.dataobject = "dw_uo_classes"
dsClasses.SetTransObject(sqlca)

dsPackinglistSizes.dataobject = "dw_uo_packinglist_size"
dsPackinglistSizes.SetTransObject(sqlca)

dsPackinglistSizeFind.dataobject = "dw_uo_packinglist_size"
dsPackinglistSizeFind.SetTransObject(sqlca)

dsPackinglistTypes.dataobject = "dw_uo_packinglist_sys_types"
dsPackinglistTypes.SetTransObject(sqlca)

dsDistributingMeals.dataobject = "dw_uo_distribution_galley"
dsDistributingMeals.SetTransObject(sqlca)

dsDistributingAdditional.dataobject = "dw_uo_distribution_galley"
dsDistributingAdditional.SetTransObject(sqlca)

dsDistributionParameter.dataobject = "dw_uo_distribution_detail"
dsDistributionParameter.SetTransObject(sqlca)

dsDistributionPriority.dataobject = "dw_uo_distribution_priority"
dsDistributionPriority.SetTransObject(sqlca)

dsLabelObjects.dataobject = "dw_uo_label_objects"
dsLabelObjects.SetTransObject(sqlca)

dsLabelTypes.dataobject = "dw_uo_labeltypes"
dsLabelTypes.SetTransObject(sqlca)

dsStowageGroups.dataobject = "dw_uo_stowage_groups"
dsStowageGroups.SetTransObject(sqlca)

dsStowageGroupValues.dataobject = "dw_uo_stowage_groups_value"
dsStowageGroupValues.SetTransObject(sqlca)

dsDistributionPerACType.dataobject = "dw_uo_distribution_by_ac_type"
dsDistributionPerACType.SetTransObject(sqlca)

dsDistributionExceptions.dataobject = "dw_uo_ac_distr_exceptions"
dsDistributionExceptions.SetTransObject(sqlca)


dsLoadingList.dataobject						= "dw_loading_list_result"
dsDistribution.dataobject 					= "dw_loading_list_result"
dsControl.dataobject 							= "dw_uo_control"
dsDistributionErrors.dataobject 			= "dw_uo_cen_out_meals_errors"
dsSPMLDistribution.dataobject 				= "dw_uo_cen_out_meals"
dsSPMLDistributionMaster.dataobject		= "dw_uo_cen_out_meals"
dsAdditionalDistribution.dataobject 		= "dw_uo_cen_out_meals"
dsCheckSheet.dataobject 					= "dw_uo_check_sheet"
dsSPMLSummary.dataobject 				= "dw_uo_spml_summary"

// error-report landscape gewollt ?
if luo_FormatMandant.of_mandant_profilestring(sqlca, s_app.smandant ,'MealDistribution','ErrorsLandscape','0') = '1' then
	dsDistributionErrors.dataobject = "dw_uo_cen_out_meals_errors_landscape"
end if

// ---------------------------------------------------------
// CBASE-F4-CR-2015-014 Verteilerroutine pro Airline und A/C 
// ---------------------------------------------------------
if luo_FormatMandant.of_mandant_profilestring(sqlca, s_app.smandant ,'Distribution','ByACType','0') = '1' then
	bNewDistrubtionAssignment = TRUE
end if



// --------------------------------------------------------
// Das LogFile neu anlegen 
// --------------------------------------------------------
//if this.iTrace = 0 then 
//
//	iFile = FileOpen(this.sLogPath + "cbase_distribution.log", LineMode!, Write!, Shared!,Replace!)
//	FileClose(iFile)
//
//end if


end event

event destructor;Long 	I

//Objekt zur Berechnung von Schriftgr$$HEX2$$f600df00$$ENDHEX$$en zerst$$HEX1$$f600$$ENDHEX$$ren
DESTROY iuo_FontCalc

Destroy(dsFlight)
Destroy(dsLeg)
Destroy(dsMeals)		
Destroy(dsSPML)
Destroy(dsSPMLDistribution)
Destroy(dsSPMLDistributionMaster)
Destroy(dsAdditional)
Destroy(dsAdditionalDistribution)
Destroy(dsAircraft)
Destroy(dsClasses)
Destroy(dsPackinglistTypes)
Destroy(dsPackinglistSizes)
Destroy(dsPackinglistSizeFind)
Destroy(dsDistribution)
Destroy(dsDistributingMeals)
Destroy(dsDistributingAdditional)
Destroy(dsDistributionParameter)
Destroy(dsControl)
Destroy(dsDistributionErrors)
Destroy(dsDistributionPriority)
Destroy(dsLabelObjects)
Destroy(dsLocationSheet)
Destroy(dsLoadingList)
Destroy(dsLabelTypes)
Destroy(dsCheckSheet)
Destroy(dsSPMLSummary)
Destroy(dsStowageGroups)
Destroy(dsStowageGroupValues)

Destroy	dsDistributionPerACType
Destroy	dsDistributionExceptions


For I = 1 to UpperBound(uoStowages)
	Destroy(uoStowages[I])
Next


end event

