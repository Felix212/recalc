HA$PBExportHeader$uo_delivery_note.sru
$PBExportComments$User-Object zur Erstellung einer Catering Order (Ausdruck); dies ist z.B. im Flug-Browser m$$HEX1$$f600$$ENDHEX$$glich
forward
global type uo_delivery_note from nonvisualobject
end type
end forward

global type uo_delivery_note from nonvisualobject
end type
global uo_delivery_note uo_delivery_note

type variables
//==============================================================================================
//
// Pflicht-Properties
//
//==============================================================================================
Long			lResultKey
Long			lBillingKey			= 0		// Belegnummer
Boolean		bAskForNewKey		= true	// bei Massenverarbeitung keine Fragerei
Boolean		bNewNumber			= false
Boolean		bAsk					= True


integer		iPrintPreview		= 0		// Druck mit Vorschau

//==============================================================================================
//
// Sonstige Properties
//
//==============================================================================================
Long			lTransaction
String			sError
Integer 		iStatus  			= 0
Integer		iCopies				= 1
Integer		iMultiLeg			= 0
Long 			lAirlineKey

Datastore	dsReport
Datastore	dsDetailReport
Datastore	dsSetup
Datastore	dsGalleyGroups
DataStore	dsPaxHistory
DataStore	dsKeys
DataStore   dsCustomerNumber
DataStore   dsCustomBoardingBill
DataStore   ids_cust_board_bill_by_unit

DatawindowChild	dwcHeader
DatawindowChild	dwcHandling
DatawindowChild	dwcVersion
DatawindowChild	dwcMeals
DatawindowChild	dwcExtra
DatawindowChild	dwcDetail
DatawindowChild	dwcPax
DatawindowChild	dwcBarCode

string				sPrinter = ""
Integer			ii_EnableAllLegs = 1
Integer 			ii_ShowFlightInPopUp = 0

string				is_filepath
integer			ii_CR_EXPORT_PRINT = 0
Boolean			ib_web = FALSE

// fuer die customer boarding bill by unit fuer LAM
//Integer	ii_delivery_note_format = 1

//String		is_path_IF401Textfile


end variables

forward prototypes
public function integer of_get_meals ()
public function long of_get_number ()
public function integer of_format_datastore (datastore odw)
public function integer of_retrieve ()
public function long of_save (long lnumber)
public function integer of_get_pax ()
public function integer of_multileg ()
public function long of_get_billingkey ()
public function integer of_get_reserve ()
public function integer of_get_details (boolean ab_customer_number)
public function integer of_draw_healthmark (string as_unit, ref datastore rads_target)
public function boolean of_is_healthmark_enabled (string as_unit)
public function integer of_check_int007 (long alresult)
protected function integer of_collect_legs (long al_resultkey, ref long ral_all_legs_result[], ref long ral_all_legs_transaction[])
public function integer of_retrieve (boolean ab_pdf, ref datastore ads_datastore[], ref string as_pdf[])
end prototypes

public function integer of_get_meals ();Long 			lLastTransaction, &
				lRow, &
				I, &
				lFound, &
				lClass, &
				lPLIndex, &
				lQuantity
				
string		sFind				

datastore 	dsMealHistory

select max(ntransaction) into :lLastTransaction from cen_out_delivery_note where nresult_key = :this.lResultKey;

if sqlca.sqlcode < 0 then
	
	this.iStatus = -1
	this.sError = "Errorcode: " + string(sqlca.sqlcode) + "~r~r" + sqlca.sqlerrtext
	return this.iStatus
	
elseif sqlca.sqlcode = 100 then
	
	// --------------------------------
	// Flug wird das erste Mal gedruckt
	// --------------------------------		
	
	for lRow = 1 to dwcMeals.RowCount()
		dwcMeals.SetItem(lRow, "nquantity_old", dwcMeals.GetItemNumber(lRow, "nquantity"))
	next
	
	return 0
	
else
	
	// --------------------------------
	// Flug erneut gedruckt, ggf. dann 
	// in der History nach $$HEX1$$c400$$ENDHEX$$nderungen
	// suchen
	// --------------------------------
	dsMealHistory = create datastore 	
	dsMealHistory.DataObject = "dw_delivery_note_meals_history"
	dsMealHistory.SettransObject(sqlca)
	dsMealHistory.Retrieve(this.lResultKey, lLastTransaction)
	// --------------------------------
	// Keine History vorhanden
	// --------------------------------
	if dsMealHistory.RowCount() = 0 then
		for lRow = 1 to dwcMeals.RowCount()
			dwcMeals.SetItem(lRow, "nquantity_old", dwcMeals.GetItemNumber(lRow, "nquantity"))
		next
	else
		
		for I = 1 to dsMealHistory.RowCount()
			
			lClass 	 = dsMealHistory.GetItemNumber(I, "nclass_number")
			lPLIndex  = dsMealHistory.GetItemNumber(I, "npackinglist_index_key")
			lQuantity = dsMealHistory.GetItemNumber(I, "nquantity")
			
			sFind = "npackinglist_index_key = " + string(lPLIndex) + &
					  " and cen_out_meals_nclass_number = " + String(lClass) + &
					  " and ncompare = 0"
		
			lFound = dwcMeals.Find(sFind , 1, dwcMeals.RowCount())
	
			if lFound > 0 then 
				dwcMeals.SetItem(lFound, "nquantity_old", lQuantity)
				dwcMeals.SetItem(lFound, "ncompare", 1)
			end if
			
		Next
		
	end if
	
	destroy(dsMealHistory)
	
end if 

return 0
end function

public function long of_get_number ();//==============================================================================================
//
// of_get_number
//
//==============================================================================================
Long 	lSequence
DateTime dtNow

// -------------------------------------------------------------
// N$$HEX1$$e400$$ENDHEX$$chste Lieferscheinnummer holen
// -------------------------------------------------------------
lSequence = f_Sequence ("SEQ_CEN_DELIVERY_NOTE_COUNTER", sqlca)
	
If lSequence = -1 Then
	uf.MBox ("Datenbankfehler", "Es konnte kein eindeutiger Schl$$HEX1$$fc00$$ENDHEX$$ssel (Sequence) ermittelt werden.~r~r" + &
										 "Keine Neuanlage m$$HEX1$$f600$$ENDHEX$$glich.", StopSign!)
										 
	return -1
	
end if

dtNow = Datetime(Today(), Now())

INSERT INTO cen_out_delivery_note  
         ( nresult_key,   
           ntransaction,   
           nnumber,   
           dtimestamp )  
VALUES ( :this.lResultKey,   
         :this.lTransaction,   
          :lSequence,   
          :dtNow )  ;
			 
if sqlca.sqlcode = 0 then
	commit;
	
	// -------------------------------------------------------------
	// Kopfsatz in cen_out synchron halten
	// -------------------------------------------------------------
	UPDATE cen_out set nbilling_key = :lSequence where nresult_key = :this.lResultKey;
	
	if sqlca.sqlcode <> 0 then
		this.sError = "Errorcode updating nbilling_key: " + string(sqlca.sqlcode) + "~r~r" + sqlca.sqlerrtext
		return -1
	else
		commit;
	end if
	
	
	return lSequence
else
	this.sError = "Errorcode: " + string(sqlca.sqlcode) + "~r~r" + sqlca.sqlerrtext
	return -1
end if

return -1
end function

public function integer of_format_datastore (datastore odw);// ---------------------------------------------------------------------------
// Rahmen um Report zeichnen.
// f_format_datastore kann nicht verwendet werden, da die Funktion 
// $$HEX1$$fc00$$ENDHEX$$bersetzt
// ---------------------------------------------------------------------------
integer 		iDWWidth, &
				iDWHeight, &
				iDetailX, &
				iDetailY
long			lXpos
blob			bl_report
integer 		iMarginTop,iMarginBottom,iMarginLeft,iMarginRight
integer 		iHeaderHeight,iDetailHeight,iFooterHeight,iSummaryHeight
		
// ---------------------------------------------------------------------------
// Drucker
// ---------------------------------------------------------------------------
If sPrinter <> "" Then
	oDW.Modify("datawindow.printer='" + sPrinter + "'")
End if	
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
//oDW.Object.p_logo.filename 		= sLogo
// ---------------------------------------------------------------------------
// Layout Footer
// ---------------------------------------------------------------------------
oDW.Object.DataWindow.Footer.Height	= "24" 
oDW.Object.t_signature.text 			= s_app.sOrga
oDW.Object.t_printed.text 				= string(today(),s_app.sDateformat) + &
										  			"  " + string(now(),"HH:MM")
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

public function integer of_retrieve ();/*************************************************************
* Objekt : uo_delivery_note
* Methode: of_retrieve (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 17.02.2010
* Argument(e):
* none
*
* Return: integer
*
*
* wrapper zur kompatibilit$$HEX1$$e400$$ENDHEX$$t
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  17.02.2010	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
datastore ldsDummy[]
string lsDummy[]
return of_retrieve(false, ldsDummy, lsDummy)

end function

public function long of_save (long lnumber);//==============================================================================================
// 
// of_save
//
//==============================================================================================
DateTime dtNow

// -------------------------------------------------------------
// Die aktuelle Lieferscheinnummer holen
// -------------------------------------------------------------
//
//
dtNow = Datetime(Today(), Now())
//
INSERT INTO cen_out_delivery_note  
         ( nresult_key,   
           ntransaction,   
           nnumber,   
           dtimestamp )  
VALUES ( :this.lResultKey,   
         :this.lTransaction,   
          :lNumber,   
          :dtNow )  ;
			 
if sqlca.sqlcode = 0 then
	commit;
	return 0
else
	this.sError = "Errorcode of_save(): " + string(sqlca.sqlcode) + "~r~r" + sqlca.sqlerrtext
	return -1
end if

return -1
end function

public function integer of_get_pax ();Long 			lLastTransaction, &
				lRow, &
				I, &
				lFound, &
				lClass, &
				lPLIndex, &
				lQuantity
				
string		sFind				

select max(ntransaction) into :lLastTransaction from cen_out_delivery_note where nresult_key = :this.lResultKey;

if sqlca.sqlcode < 0 then
	
	this.iStatus = -1
	this.sError = "Errorcode: " + string(sqlca.sqlcode) + "~r~r" + sqlca.sqlerrtext
	return this.iStatus
	
elseif sqlca.sqlcode = 100 then
	// ----------------------------------
	// Flug wird das erste mal gedruckt
	// ----------------------------------
	if dsReport.GetChild ("dw_version", dwcPax ) <> 1 then
		this.iStatus 	= -1
		this.sError		= "Error creating subreport pax 1"
		return this.iStatus
	end if	
	
	for lRow = 1 to dwcPax.RowCount()
			dwcPax.SetItem(lRow, "nquantity_old", dwcPax.GetItemNumber(lRow, "npax"))
		next
	return 0
	
else
	
	// --------------------------------
	// Flug erneut gedruckt, ggf. dann 
	// in der History nach $$HEX1$$c400$$ENDHEX$$nderungen
	// suchen
	// --------------------------------
	dsPaxHistory.Retrieve(this.lResultKey, lLastTransaction)
	
	// f_print_datastore(dsReport)
	
	if dsReport.GetChild ("dw_version", dwcPax ) <> 1 then
		// --------------------------------------------------------
		// 27.02.07, KF
		// Vormals wurde an dieser Stelle mit einem Fehler
		// abgebrochen, ist aber falsch, wenn GetChild nicht
		// funktioniert, dann wurde das dwcPax in of_retrieve
		// destroyed. 
		// --------------------------------------------------------
		//		this.iStatus 	= -1
		//		this.sError		= "Error creating subreport pax 2"
		//		return this.iStatus
		// --------------------------------------------------------
		return 0
	end if	
	
	// --------------------------------
	// Keine History vorhanden
	// --------------------------------
	if dsPaxHistory.RowCount() = 0 then
		for lRow = 1 to dwcPax.RowCount()
			dwcPax.SetItem(lRow, "nquantity_old", dwcPax.GetItemNumber(lRow, "npax"))
		next
	else
		
		for I = 1 to dsPaxHistory.RowCount()
			
			lClass 	 = dsPaxHistory.GetItemNumber(I, "nclass_number")
			lQuantity = dsPaxHistory.GetItemNumber(I, "npax")		
			
			sFind 	= "nclass_number = " + string(lClass)
			lFound 	= dwcPax.Find(sFind , 1, dwcPax.RowCount())
	
			if lFound > 0 then 
				dwcPax.SetItem(lFound, "nquantity_old", lQuantity)
			else
				// Messagebox("", sFind + " Menge: " + string(lQuantity ))
			end if
			
		Next
		
	end if
	
	
end if 

return 0
end function

public function integer of_multileg ();Long 	I
Long	lResultKeyGroup

select nresult_key_group into :lResultKeyGroup
from cen_out where nresult_key = :lResultKey;

dsKeys.Retrieve(lResultKeyGroup)

for I = 1 to dsKeys.RowCount()
	this.lResultKey = dsKeys.GetItemNumber(I, "nresult_key")
		
	this.of_retrieve()
	
next


return 0
end function

public function long of_get_billingkey ();
long		lcnt
long		lKey
datetime	dttimestamp
	
select max(dtimestamp)
  into :dttimestamp
  from cen_out_delivery_note
 where nresult_key = :this.lResultKey;

if sqlca.sqlcode <> 100 then
	select nnumber
	  into :lBillingKey
	  from cen_out_delivery_note
	 where nresult_key 	= :this.lResultKey
	   and dtimestamp 	= :dttimestamp;
	
else
	select nbilling_key
	  into :lBillingKey
	  from cen_out
	 where nresult_key = :this.lResultKey;
	 
end if

return 0

end function

public function integer of_get_reserve ();long		i
long		lFound
long		lClassNumber
long		lcnt

lcnt = dwcMeals.RowCount()

for i = 1 to dwcPax.RowCount()
	lClassNumber = dwcPax.GetItemNumber(i,"nclass_number")
	//
	// 25.08.06	Pr$$HEX1$$fc00$$ENDHEX$$fung, ob Mahlzeiten einer Klasse Reserven haben
	//
//	lFound = dwcMeals.Find("nbilling_status <> 2 and cen_out_meals_nclass_number = " + &
//				string(lClassNumber) + " and nreserve_quantity > 0",1,dwcMeals.RowCount())
	lFound = dwcMeals.Find("nreserve_quantity > 0 and cen_out_meals_nclass_number = " + &
				string(lClassNumber) ,1,dwcMeals.RowCount())
	if lFound > 0 then
		dwcPax.SetItem(i,"reserve_counter",dwcMeals.GetItemNumber(lFound,"nreserve_quantity"))
	end if
	
next

return 0
end function

public function integer of_get_details (boolean ab_customer_number);// ----------------------------------------------------------
// 
// Detailreport f$$HEX1$$fc00$$ENDHEX$$r den Lieferschein 
// 
//
// zun$$HEX1$$e400$$ENDHEX$$chst Struktur bef$$HEX1$$fc00$$ENDHEX$$llen, dann uo_loading_list
// parametrieren
// ----------------------------------------------------------

s_all_flight_infos		oFlightInfo
uo_loading_list			uoLoadingList
Long							lRow = 1
Long 							a
Long							lGroup
String						sUnit
String						sRouting
String						sHandling

uoLoadingList 	= CREATE uo_loading_list

if ab_customer_number then
	uoLoadingList.ds_loadinglist.dataobject = "dw_delivery_note_detail_cusno"
else	
   uoLoadingList.ds_loadinglist.dataobject = "dw_delivery_note_detail"
end if

sUnit										= dwcHeader.GetItemString(lRow, "sys_units_ctext")
sRouting									= dwcHeader.GetItemString(lRow, "crouting_text")
sHandling								= dwcHeader.GetItemString(lRow, "chandling_type_description")


oFlightInfo.lairline_key			= dwcHeader.GetItemNumber(lRow, "nairline_key")
oFlightInfo.sflightnumber			= string(dwcHeader.GetItemNumber(lRow, "nflight_number"))
oFlightInfo.ssuffix					= dwcHeader.GetItemString(lRow, "csuffix")
oFlightInfo.sdeparturedate			= String(dwcHeader.GetItemDateTime(lRow, "ddeparture"), s_app.sDateFormat)
oFlightInfo.shomestation			= dwcHeader.GetItemString(lRow, "ctlc_from")
oFlightInfo.luser_id		  			= s_app.luser_id
oFlightInfo.sclient					= s_app.smandant
oFlightInfo.cdeparturetime			= dwcHeader.GetItemString(lRow, "cdeparture_time")
oFlightInfo.lhandling_key			= dwcHeader.GetItemNumber(lRow, "nhandling_type_key")
oFlightInfo.laircraft_key			= dwcHeader.GetItemNumber(lRow, "naircraft_key")
oFlightInfo.sActype					= f_get_ac_name(oFlightInfo.laircraft_key)
oFlightInfo.llayoutkey				= 1
oFlightInfo.sInvocation				= "PB"
oFlightInfo.slogo_path				= f_gettemppath()
oFlightInfo.lHomeStation_Key 		= dwcHeader.GetItemNumber(lRow, "ntlc_from")

oFlightInfo.lroutingplan_index	= dwcHeader.GetItemNumber(lRow, "nroutingplan_index")
oFlightInfo.lroutingplan_group_key	= dwcHeader.GetItemNumber(lRow, "nrouting_group_key")
oFlightInfo.lroutingplan_leg_number	= dwcHeader.GetItemNumber(lRow, "nleg_number")

oFlightInfo.sUnit						= s_app.sWerk
oFlightInfo.sairline 				= f_airline_to_string(oFlightInfo.lairline_key)
oFlightInfo.sairline_long  		= f_airline_to_string(oFlightInfo.lairline_key)
oFlightInfo.lfrom_key				= dwcHeader.GetItemNumber(lRow, "ntlc_from")
oFlightInfo.lto_key					= dwcHeader.GetItemNumber(lRow, "ntlc_to")

// ------------------------------------------------------------------------------------------------
// uoLoadingList parametrieren
// ------------------------------------------------------------------------------------------------
uoLoadingList.bDoAircraftChange 	= TRUE
uoLoadingList.sMandant 				= s_app.smandant
uoLoadingList.sDateFormat 			= s_app.sDateformat

uoLoadingList.lAirlineKey			= oFlightInfo.lairline_key
uoLoadingList.iFlightNo				= integer(oFlightInfo.sflightnumber)
uoLoadingList.sSuffix				= oFlightInfo.sSuffix

uoLoadingList.dtDepartureDate		= dwcHeader.GetItemDateTime(lRow, "ddeparture")
uoLoadingList.lAircraftKey			= oFlightInfo.laircraft_key
uoLoadingList.sFromTLC				= oFlightInfo.sHomeStation
uoLoadingList.sToTLC					= dwcHeader.GetItemString(lRow, "ctlc_to")
uoLoadingList.lFromTLCKey			= oFlightInfo.lHomeStation_Key

uoLoadingList.iPaxKomplett			= 1						// mu$$HEX2$$df002000$$ENDHEX$$sp$$HEX1$$e400$$ENDHEX$$ter ge$$HEX1$$e400$$ENDHEX$$ndert werden
uoLoadingList.lLayOutKey			= oFlightInfo.lLayoutKey
uoLoadingList.tDepartureTime		= Time(oFlightInfo.cdeparturetime)
uoLoadingList.lHandlingKey			= oFlightInfo.lhandling_key

uoLoadingList.sUnit	 				=	s_app.sWerk
uoLoadingList.uf_setdatabaseinfo(SQLCA)

// ---------------------------------------------------------------------------------------
// Den Header retrieven lassen
// ---------------------------------------------------------------------------------------
dsDetailReport.Retrieve(this.lResultKey)

dsDetailReport.Modify("t_flightnumber.text='" + oFlightInfo.sairline  + " " + String(dwcHeader.GetItemNumber(lRow, "nflight_number"), "000") + oFlightInfo.ssuffix + "'")
dsDetailReport.Modify("t_departure.text='" + oFlightInfo.sdeparturedate + "'")
dsDetailReport.Modify("t_departure_time.text='" + oFlightInfo.cdeparturetime + "'")
dsDetailReport.Modify("t_from.text='" + uoLoadingList.sFromTLC	 + "'")
dsDetailReport.Modify("t_to.text='" + uoLoadingList.sToTLC	+ "'")
dsDetailReport.Modify("t_unit.text='" + sUnit + "'")
dsDetailReport.Modify("t_actype.text='" + oFlightInfo.sActype	 + "'")
dsDetailReport.Modify("t_routing.text='" + sRouting + "'")
dsDetailReport.Modify("t_handling.text='" + sHandling + "'")

// ---------------------------------------------------------------------------------------
// Die Beladung kalkulieren
// ---------------------------------------------------------------------------------------
oFlightInfo = uoLoadingList.uf_generate_data(oFlightInfo)

if oFlightInfo.iStatus <> 0 then
	uf.mbox("Achtung", "Fehler beim Erstellen des Detail-Reports:~r~r" + oFlightInfo.sStatus, StopSign!)	
	return -1
end if 
	
// ------------------------------------------------------------------------------------
// Alle wegfiltern, die nicht gedruckt werden sollen
// ------------------------------------------------------------------------------------
uoLoadingList.ds_loadinglist.SetFilter("nprint = 1")
uoLoadingList.ds_loadinglist.Filter()

integer iRet
iRet = uoLoadingList.ds_loadinglist.RowsCopy(1, uoLoadingList.ds_loadinglist.RowCount(), Primary!, dsDetailReport, dsDetailReport.RowCount() + 1, Primary!)

//f_print_datastore(uoLoadingList.ds_loadinglist)
//f_print_datastore(dsDetailReport)
//Messagebox("", iRet)

if iRet <> 1 then
	uf.mbox("Achtung", "Fehler beim RowsCopy", StopSign!)	
	return -1
end if

dsDetailReport.Sort()
dsDetailReport.GroupCalc()

return 0
end function

public function integer of_draw_healthmark (string as_unit, ref datastore rads_target);/*
* Objekt : uo_delivery_note
* Methode: of_draw_healthmark (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
* string as_unit
*
* Beschreibung:		Draw Healthmark
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: integer
*
*/


Integer	li_Succ
String	ls_Mod
String	ls_Error
uo_healthmark	luo_healthmark



luo_healthmark = CREATE uo_healthmark


If isvalid(rads_Target) then
//	ls_Mod = "l_healthmark_v.visible='1'"
//	ls_Error = rads_Target.object.dw_header.Modify(ls_Mod)
//	ls_Mod = "sys_units_ctext.width='75'"
//	ls_Error = rads_Target.Modify(ls_Mod)
//	ls_Mod = "t_8.width='75'"
//	ls_Error = rads_Target.Modify(ls_Mod)
//	ls_Mod = "l_12.x2='117'"
//	ls_Error = rads_Target.Modify(ls_Mod)
	
	li_Succ = luo_healthmark.of_draw_healthmark( rads_Target, as_unit, luo_healthmark.deliverynote )
End If

DESTROY	luo_healthmark


//l_healthmark_v.visible = 1
//sys_units_ctext.width = 75
//t_8.width = 75
//l_12.x2=117
//


Return li_Succ

end function

public function boolean of_is_healthmark_enabled (string as_unit);/*
* Objekt : uo_delivery_note
* Methode: of_is_healthmark_enabled (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.04.2013
*
* Argument(e):
* none
*
* Beschreibung:		Healthmark Schalter
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.04.2013		Erstellung
*
*
* Return: boolean
*
*/


// Check Healthmark-Switch
String	ls_HM

ls_HM = f_unitprofileString("HEALTHMARK", "ENABLED", "FALSE", as_Unit)

If upper(ls_HM) = "TRUE" Then
	Return TRUE
Else
	Return FALSE
End If
	
end function

public function integer of_check_int007 (long alresult);// --------------------------------------------------------------------------------
// Objekt : uo_delivery_note
// Methode: of_check_int007 (Function)
// Autor  : M. Barfknecht
// --------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung:Falls wir in Russland sind, 
//					darf die delivery note nur erstellt werden, wenn keine
//					onlineexplosion/INT007_Load mehr offen sind
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  20.06.2013	           M.Barfknecht       Erstellung
//
// --------------------------------------------------------------------------------

long lcount

//Erstmal pr$$HEX1$$fc00$$ENDHEX$$fen wir, ob wir $$HEX1$$fc00$$ENDHEX$$berhaupt in Russland sind:

select count(*) into :lcount
from sys_bill_int_setup
where nbint_key = 10071;

if lcount = 0 then return 0 //Wir sind nicht in Russland, also raus


//1. Schritt: Gibt es noch eine offen Explosion?

select count(*) into :lcount
from sys_explosion
where nresult_key =:alresult
and nprocess_status <= 1
and nrequester <> 3;

if lcount > 0 then
	return -1
end if

//2. Schritt: Gibt es noch offene INT007_Loads?

select count(*) into :lcount
from sys_bill_int_queue
where nresult_key =:alresult
and nbint_key=10071
and nprocess_status <= 1;

if lcount > 0 then
	return -2
end if

return 0
end function

protected function integer of_collect_legs (long al_resultkey, ref long ral_all_legs_result[], ref long ral_all_legs_transaction[]);
// --------------------------------------------------------------------------------
// Objekt : uo_delivery_note
// Methode: of_collect_legs (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 23.07.2014
//
// Argument(e):
// long al_resultkey
//	 ref long ral_all_legs_result[]
//	 ref long ral_all_legs_transaction[]
//
// Beschreibung:		Collect Result_key and Transaction for all Legs
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	23.07.2014		Erstellung
//
//
// Return: integer
//
// --------------------------------------------------------------------------------


datastore 	lds_Legs
Long			lRows, ll_Number_of_Legs


lds_Legs			= create datastore
lds_Legs.dataobject = "dw_uo_cen_out_leg"
lds_Legs.SetTransObject(sqlca)
lds_Legs.Retrieve(al_ResultKey)

for lRows = 1 to lds_Legs.RowCount()
	ral_all_legs_result			[upperbound(ral_all_legs_result) + 1]			=  lds_Legs.GetItemNumber(lRows, "nresult_key")
	ral_all_legs_transaction	[upperbound(ral_all_legs_transaction) + 1]	=  lds_Legs.GetItemNumber(lRows, "ntransaction")	
next

ll_Number_of_Legs = lds_Legs.RowCount()

destroy(lds_Legs)

return ll_Number_of_Legs
end function

public function integer of_retrieve (boolean ab_pdf, ref datastore ads_datastore[], ref string as_pdf[]);/*************************************************************
* Objekt : uo_delivery_note
* Methode: of_retrieve (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 17.02.2010
* Argument(e):
* boolean ab_pdf
*  ref datastore ads_datastore[]
*
* Return: integer
*
* $$HEX1$$dc00$$ENDHEX$$berarbeitung 30.12.2004:
* Es darf nicht mehr automatisch eine Lieferscheinnummer vergeben werden,
* sondern nur, wenn es sich um eine tats$$HEX1$$e400$$ENDHEX$$chliche Nachlieferung handelt.
*
* Die Nummer des ersten Lieferscheins ist immer die Belegnummer des Flugs.
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
* 02.04.2009   1.1   		?                 Aufruf w_loading_rotations zum Druck derselben...
* 14.04.2009   1.2			G. Brosch         Steuerung ge$$HEX1$$e400$$ENDHEX$$ndert
* 17.02.2010	1.3         Ulrich Paudler    Erweiterung zum PDF Druck d.h. $$HEX1$$dc00$$ENDHEX$$bergabe der datastores
* 29.03.2010	1.4			O.Hoefer          Workaround f$$HEX1$$fc00$$ENDHEX$$r PDF Export eines Crystal Reports aus einem non-visual Object 
* 27.08.2010   1.5         Dirk Bunk         Bugfix falsches Papierformat/Layout
* 18.04.2012	1.6			O.Hoefer          NEU: Einstellen Flug in sys_bill_unit_queue (RUS Interfaces) - INT007
* 18.04.2012	1.7			O.Hoefer          Zusammenf$$HEX1$$fc00$$ENDHEX$$hren mit Funktion aus Webservice
* 16.08.2012   1.8         Dirk Bunk         Crystal Reports Druck/Export aktualisiert
* 18.04.2013	1.9			O.Hoefer          Healthmark
* 25.04.2013	2.0			M.Barfknecht      CustomBoardingBill repariert
* 27.06.2013	2.0			Dirk Bunk         Hartes Setzen des Crystal Report Papierformats ausgebaut
* 26.01.2017   2.1         Oliver H$$HEX1$$f600$$ENDHEX$$fer      Aufrufz$$HEX1$$e400$$ENDHEX$$hler (request #1978)
*************************************************************/
Long 		ll_status
Long 		ll_aircraft_key
Long 		ll_logo
String		ls_logo
Integer	li_language
Integer	li_i
Integer	li_k
String 	ls_title
Integer	li_textinfo
Integer	li_barcode
Long		ll_Succ

Boolean  lb_customer_number = false
Boolean  lb_load_ratios_meals = false
Boolean  lb_load_ratios_extra = false
Integer	li_Succ
String		ls_param_name
String		ls_PDF_File
String		ls_unit
String		ls_Mod
String		ls_Error
Long		ll_Leg_Counter
String		ls_BarCode_picture
String		ls_picture_list[]
Long		ll_Result_keys[], ll_transactions[]
Long		ll_key
String		ls_name, ls_File
Long		ll_found
Blob 		lblb_blob
integer	li_CustomerBill
datetime	ldt_departure
String		ls_CateringOrderPrinter
String		ls_TextFile
Integer 	li_active = -1
Datetime ldt_valid_from, ldt_valid_to

Integer	li_split_by_class
Integer	li_newrows
//Boolean	lb_401_createnew = True
//Boolean	lb_401_createtextfile = True
uo_crystal_report	luo_CR
uo_dn_barcode		lnv_dn_barcode
s_catering_order 	sreturn
uo_rtn_queue		luo_rtn_queue	// Queue Functions (sys_bill_unit_queue)


li_succ = of_check_int007(lresultkey)
if li_succ < 0 then
	this.iStatus 	= -1
	if li_succ = -1 then
		this.sError		= "Error: There are still open Explosions!"
	elseif  li_succ = -2 then
		this.sError		= "Error: There are still open INT007_LOAD!"
	end if
	return this.iStatus
end if

IF Handle(GetApplication()) = 0 THEN
	iPrintPreview = 1
End if

ls_CateringOrderPrinter = f_profilestring("changebrowser", "PRINTER1",s_app.sDefaultprinter)

if bAsk = true and bAskForNewKey = true then
	bAsk = false
	if ii_EnableAllLegs = 0 then
		sReturn.bAll_legs = False
	else
		sReturn.bAll_legs = True
	end if
	
	if	ii_ShowFlightInPopUp = 1 then
		sReturn.lResultKey = this.lResultKey
	else
		sReturn.lResultKey = 0
	end if
	
	openwithparm(w_delivery_note_question, sReturn)

	sReturn = Message.PowerObjectParm

	if not isvalid(sReturn) then return 0

	if sReturn.bAll_legs then
		iMultiLeg = 1
	end if

	if sReturn.bnew_number then
		bNewNumber = true
	end if

	if iMultiLeg = 1 then
		of_multileg()
		return 0
	end if
end if
//messagebox("", this.lResultkey)


if this.iStatus <> 0 then return this.iStatus

// Billing-Key ermitteln (aus cen_out oder cen_out_delivery_note)
of_get_billingkey()

// ---------------------------------
// Ein paar Flugdaten holen
// ---------------------------------
select nairline_key, ddeparture, ntransaction, cunit into :this.lAirlineKey, :ldt_departure, :this.lTransaction, :ls_unit from cen_out where nresult_key = :this.lResultKey;
if sqlca.sqlcode <> 0 then
	this.iStatus 	= -1
	this.sError		= "Error getting Flightinfo ~r~r Errorcode: " + string(sqlca.sqlcode) + "~r~r" + sqlca.sqlerrtext
	return this.iStatus
end if

// 16.03.2009 HR: Standardlieferschein oder CrystalReport?
SELECT cen_airlines.ncustom_bbill  INTO :li_CustomerBill  FROM cen_airlines  WHERE cen_airlines.nairline_key = :this.lAirlineKey;

// TSC 23.09.2019 (AlmID 5325): Der folgende IF li_CustomerBill wurde extra fuer LAM gebaut.  Jetzt soll das alles ueber SAP-Orders gemacht
// werden. Das brauchen wir also hier nicht mehr.
//if li_CustomerBill = 2 then
//	// ---------------------------------------------------------
//	// Crystal Report-Delivery Note by unit (for LAM)
//	// ---------------------------------------------------------
//	li_succ = ids_cust_board_bill_by_unit.retrieve(lAirlineKey, ls_unit, ldt_departure)
//	IF li_succ < 1 THEN
//		// Kein aktiver Report gefunden... Fehler und raus
//		this.iStatus= -1
//		this.sError = "Warning: No Active Custom Boarding Bill found!"
//		return this.istatus
//	END IF
//	// Der Datastore retrieved so, dass der Unit-Spezifische Report immer in Zeile 1 steht, wenn es einen gibt. Ansonsten kommt nur der fuer Unit * Default.
//	ll_key = ids_cust_board_bill_by_unit.GetItemNumber(1, "ncustom_bbill_key")
//	li_split_by_class = ids_cust_board_bill_by_unit.GetItemNumber(1, "nsplit_by_class")
//	// Report-Blob aus der Datenbank laden
//	IF ii_delivery_note_format = 1 THEN
//		ls_name = ids_cust_board_bill_by_unit.GetItemString(1, "creportname")
//		ls_file = ids_cust_board_bill_by_unit.GetItemString(1, "cfilename")
//		SELECTBLOB breport INTO :lblb_blob FROM cen_custom_bbill_by_unit WHERE ncustom_bbill_key = :ll_key;
//	ELSE
//		ls_name = ids_cust_board_bill_by_unit.GetItemString(1, "creportname2")
//		ls_file = ids_cust_board_bill_by_unit.GetItemString(1, "cfilename2")
//		SELECTBLOB breport2 INTO :lblb_blob FROM cen_custom_bbill_by_unit WHERE ncustom_bbill_key = :ll_key;
//	END IF
//	IF sqlca.sqlcode <> 0 then
//		this.iStatus 	= -1
//		this.sError = "Error while retrieving the report from database"
//		return this.istatus
//	END IF
//	ls_TextFile = f_gettemppath() + "CBASE-CrystalReport-" + String(CPU(), "000000000000") + ".RPT"
//	f_blob_to_file(ls_TextFile, lblb_blob)
//	
//	// Checken: Wenn der User sagt, er will KEINE neue Nummer vergeben, dann rufen wir die Procedure nur auf, wenn noch nie eine
//	// Delivery Note fuer diesen Flug erstellt wurde. Ansonsten soll einfach die letzte Delivery Note nochmal gedruckt, aber kein
//	// Textfile erstellt werden
//	IF bAskForNewKey and bNewNumber = FALSE THEN
//		select count(*) into :ll_found from cen_out_delivery_note where nresult_key = :this.lResultKey and nnumber_master = :this.lBillingKey;
//		IF ll_found > 0 THEN
//			lb_401_createnew = FALSE
//			lb_401_createtextfile = FALSE
//		END IF
//	END IF
//	
//	IF lb_401_createnew THEN
//		// Jetzt erstmal die IF401-Daten aufbereiten
//		DECLARE save_if401 PROCEDURE FOR cbase_sap.pf_save_if401(:this.lResultKey, :li_split_by_class) USING SQLCA;
//		IF SQLCA.sqlcode <> 0 THEN
//			this.iStatus 	= -1
//			this.sError = "Error declaring procedure cbase_sap.pf_save_if401" + SQLCA.SQLErrtext
//			return this.istatus
//		END IF
//		EXECUTE save_if401;
//		IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
//		END IF
//		FETCH save_if401 INTO :this.lBillingKey, :li_newrows;
//		CLOSE save_if401;
//		IF li_newrows < 1 THEN
//			lb_401_createtextfile = FALSE
//		END IF
//	END IF
//
//	IF li_newrows = 0 THEN
//		IF bAskForNewKey THEN
//			IF bNewNumber THEN
//				// Wenn explizit eine neue Nummer gewuenscht war, sich aber nix geaendert hat (also keine neuen Rows erzeugt wurden), dann Meldung und raus
//				this.iStatus = 0
//				this.sError = "Keine neuen Lieferschein Daten vorhanden"
//				return this.istatus
//			ELSE
//				// Es wurde zwar gefragt, aber der User hat nein gesagt, also den alten Report nochmal erstellen. D.h. hier nix und unten dann weiter machen
//			END IF
//		ELSE
//			// Es wurde nicht gefragt, also Aufruf aus Uebersichts-Tabpage. In diesem Fall ohne Meldung raus, wenn sich nix geaendert hat.
//			this.iStatus = 0
//			return this.istatus
//		END IF
//	END IF
//
//	// Crystal Reports drucken bzw. exportieren. Erstmal Objekt erzeugen
//	luo_CR = CREATE uo_crystal_report
//	if luo_CR.of_load(ls_TextFile) <> 0 then
//		this.iStatus = -1
//		this.sError	= "Error: Open Report failed"
//	end if
//
//	// Titel und Parameter setzen
//	if this.iStatus = 0 then			
//		if ib_web then
//			luo_CR.of_set_report_title("Delivery_Note_" + String(CPU()))
//		else
//			luo_CR.of_set_report_title(uf.translate("Lieferschein") + "_" + String(CPU()))
//		end if
//		for li_i = 1 to luo_CR.of_get_parameter_count()
//			ls_param_name = luo_CR.of_get_parameter_name(li_i)
//			choose case Trim(Upper(ls_param_name))
//				case "RESULTKEY"
//					if luo_CR.of_set_parameter(ls_param_name, this.lresultkey) <> 0 then
//						this.iStatus = -1
//						this.sError	= "Error: Set Parameter Result_Key"
//					end if
//				case "DOCNUMBER"
//					if luo_CR.of_set_parameter(ls_param_name, this.lBillingKey) <> 0 then
//						this.iStatus = -1
//						this.sError	= "Error: Set Parameter Result_Key"
//					end if
//			end choose
//		next
//	end if
//
//	// Drucken
//	if this.iStatus = 0 then
//		for li_k = 1 to this.iCopies
//			if ab_pdf then
//				if ib_web then
//					ls_PDF_File = is_filepath + "CBASE-DELIVERYNOTE-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
//				else
//					ls_PDF_File = f_gettemppath() + "CBASE-DELIVERYNOTE-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
//				end if
//				// -----------------------------------------------
//				// Aufrufz$$HEX1$$e400$$ENDHEX$$hler init
//				// -----------------------------------------------
//				luo_CR.of_set_properties(ll_key, ls_File, ls_Name , "CBASEclassic", luo_CR.ci_src_customer_boarding_bill  )
//				// -----------------------------------------------
//				// Aufrufz$$HEX1$$e400$$ENDHEX$$hler log
//				// -----------------------------------------------
//				li_Succ = luo_CR.of_increment_call_counter( )
//				li_Succ = luo_CR.of_export_pdf(ls_PDF_File)
//				if li_Succ = 0 then
//					as_pdf[upperbound(as_pdf) +1] = ls_PDF_File
//				else
//					this.iStatus = -1
//					this.sError	= "Error: Creating PDF-File " + ls_PDF_File
//					exit
//				end if					
//			else
//				if sPrinter <> "" then
//					luo_CR.of_print(sPrinter)
//				else
//					luo_CR.of_print(ls_CateringOrderPrinter)
//				end if
//			end if
//		end for
//	end if
//	
//	DESTROY luo_CR
//		
//	// Tempor$$HEX1$$e400$$ENDHEX$$re Reportdatei wieder l$$HEX1$$f600$$ENDHEX$$schen
//	FileDelete(ls_TextFile)
//	
//	IF this.iStatus = 0 THEN
//		uo_create_textfile		lnv_CreateTextfile
//		lnv_CreateTextfile.is_path_IF401Textfile = This.is_path_IF401Textfile
//		IF lb_401_createtextfile THEN
//			// Create the textfile
//			lnv_CreateTextfile.uf_run_single_401(this.lresultkey, this.lBillingKey)
//		ELSE
//			// Save the textfile from DB-Blob
//			lnv_CreateTextfile.uf_save_textfile_from_db(this.lresultkey, this.lBillingKey)
//		END IF
//	END IF
//	
//	IF this.iStatus <> 0 THEN Return this.iStatus
//
//elseif li_CustomerBill = 1 then
if li_CustomerBill = 1 then
	// ---------------------------------------------------------
	// Crystal Report-Delivery Note
	// ---------------------------------------------------------
	
	// ---------------------------------------------------------
	// BARCODE
	// ---------------------------------------------------------
	lnv_dn_barcode = CREATE	uo_dn_barcode
	li_Succ = of_collect_legs(lResultKey, ll_Result_keys , ll_transactions)
	If Upperbound(ll_Result_keys) > 0 Then
		// Multiple Legs
		For ll_Leg_Counter = 1 To Upperbound(ll_Result_keys)
			li_Barcode = lnv_dn_barcode.of_create_and_save( li_CustomerBill, ll_Result_keys[ll_Leg_Counter], ll_transactions[ll_Leg_Counter], lAirlineKey, ldt_departure, ls_picture_list[ll_Leg_Counter])
			If ll_Leg_Counter= 1 Then
				ls_BarCode_picture = ls_picture_list[1]
			End If
		Next
	Else
		// One Leg
		li_Barcode = lnv_dn_barcode.of_create_and_save( li_CustomerBill, lResultKey, ltransaction, lAirlineKey, ldt_departure, ls_BarCode_picture)			
	End If
	//dw_multileg_report_result_keys
	DESTROY lnv_dn_barcode

	//CR ist gew$$HEX1$$e400$$ENDHEX$$hlt
	// ---------------------------------------------------------
	// ReportNummer nur wenn gew$$HEX1$$fc00$$ENDHEX$$nscht holen und wegspeichern
	// 18.05.2012 HR: Auch beim CR ermitteln wir den Billingkey
	// ---------------------------------------------------------
	if isnull(lBillingKey) or lBillingKey = 0 then
		// falls nichts gesetzt ist, dann alte Verarbeitung
		lBillingKey = this.of_get_number()
	else
		if bAskForNewKey then
			// Nur bei einzelnen Fl$$HEX1$$fc00$$ENDHEX$$gen wird gefragt
			//if uf.mbox("Catering Order","Soll eine neue Belegnummer vergeben werden?",Question!,YesNo!,2) = 1 then
			if bNewNumber then
				lBillingKey = this.of_get_number()
				if lBillingKey <= 0 then
					this.iStatus = lBillingKey
					return this.lBillingKey
				end if
			end if
		end if
	end if

	// --------------------------------------------------------------
	// Speichern der Reportnummmer
	// 18.05.2012 HR: Auch beim CR speichern wir den Billingkey
	// --------------------------------------------------------------
	this.of_save(lBillingKey)	
	
	//G. Brosch, 27.04.2009
	dsCustomBoardingBill.retrieve(this.lAirlineKey,ldt_departure);
	//MB: 25.04.2013 es kann mehr als einen Eintrag geben...wir suchen die Aktive raus
	ll_found = dsCustomBoardingBill.find("nactive = 1",1,dsCustomBoardingBill.rowcount())
	if ll_found > 0 then
		li_active = dsCustomBoardingBill.getitemnumber(ll_found, "nactive")
		ldt_valid_from = dsCustomBoardingBill.getitemdatetime(ll_found, "dvalid_from")
		ldt_valid_to = dsCustomBoardingBill.getitemdatetime(ll_found, "dvalid_to")
	end if

	if li_active = 1 and ldt_valid_from <= ldt_departure and ldt_departure <= ldt_valid_to then
		SELECT ncustom_bbill_key ,creportname ,cfilename
		INTO :ll_key, :ls_name, :ls_File
		FROM cen_custom_bbills
		WHERE cen_custom_bbills.nairline_key = :this.lAirlineKey and
		cen_custom_bbills.nactive  	= 1 and
		:ldt_departure between cen_custom_bbills.dvalid_from and cen_custom_bbills.dvalid_to;
		
		////////////////////////////////////
		// Report aus der Datenbank laden //
		////////////////////////////////////
		if this.iStatus = 0 then
			SELECTBLOB breport
			INTO :lblb_blob
			FROM cen_custom_bbills
			WHERE cen_custom_bbills.nairline_key = :this.lAirlineKey and
			cen_custom_bbills.nactive  	= 1 and
			:ldt_departure between cen_custom_bbills.dvalid_from and cen_custom_bbills.dvalid_to;
	
			if sqlca.sqlcode <> 0 then
				this.iStatus 	= -1
				this.sError		= "Error while retrieving the report from database"
			end if
		end if

		if this.iStatus = 0 then
			ls_TextFile = f_gettemppath() + "CBASE-CrystalReport-" + String(CPU(), "000000000000") + ".RPT"
			f_blob_to_file(ls_TextFile, lblb_blob)
		end if

		//////////////////////////////////////////////
		// Crystal Reports drucken bzw. exportieren //
		//////////////////////////////////////////////
		if this.iStatus = 0 then
			luo_CR = CREATE uo_crystal_report
			
			if luo_CR.of_load(ls_TextFile) <> 0 then
				this.iStatus = -1
				this.sError	= "Error: Open Report failed"
			end if
		end if
		
		if this.iStatus = 0 then		
			if ib_web then
				//luo_CR.of_set_report_title("Delivery Note")
				luo_CR.of_set_report_title("Delivery_Note_" + String(CPU()))
			else
				//luo_CR.of_set_report_title(uf.translate("Lieferschein"))
				luo_CR.of_set_report_title(uf.translate("Lieferschein") + "_" + String(CPU()))
			end if
			
			for li_i = 1 to luo_CR.of_get_parameter_count()
				ls_param_name = luo_CR.of_get_parameter_name(li_i)
				
				choose case Trim(Upper(ls_param_name))
					case "RESULTKEY"
						if luo_CR.of_set_parameter(ls_param_name, this.lresultkey) <> 0 then
							this.iStatus = -1
							this.sError	= "Error: Set Parameter Result_Key"
						end if
				end choose
			next
		end if
	
		if this.iStatus = 0 then
			for li_k = 1 to this.iCopies
				if ab_pdf then
					if ib_web then
						ls_PDF_File = is_filepath + "CBASE-DELIVERYNOTE-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
					else
						ls_PDF_File = f_gettemppath() + "CBASE-DELIVERYNOTE-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
					end if
					
					// -----------------------------------------------
					// Aufrufz$$HEX1$$e400$$ENDHEX$$hler init
					// -----------------------------------------------
					luo_CR.of_set_properties(ll_key, ls_File, ls_Name , "CBASEclassic", luo_CR.ci_src_customer_boarding_bill  )

					// -----------------------------------------------
					// Aufrufz$$HEX1$$e400$$ENDHEX$$hler log
					// -----------------------------------------------
					li_Succ = luo_CR.of_increment_call_counter( )
					li_Succ = luo_CR.of_export_pdf(ls_PDF_File)
					if li_Succ = 0 then
						as_pdf[upperbound(as_pdf) +1] = ls_PDF_File
					else
						this.iStatus = -1
						this.sError	= "Error: Creating PDF-File " + ls_PDF_File
						exit
					end if					
				else
					if sPrinter <> "" then
						luo_CR.of_print(sPrinter)
					else
						luo_CR.of_print(ls_CateringOrderPrinter)
					end if
				end if
			end for
		end if
		
		DESTROY luo_CR
		
		// Tempor$$HEX1$$e400$$ENDHEX$$re Reportdatei wieder l$$HEX1$$f600$$ENDHEX$$schen
		FileDelete(ls_TextFile)
	elseif li_active = 1 and (ldt_valid_from > ldt_departure or ldt_departure > ldt_valid_to) then
		// Warnung, dass die aktive BoardingBill ausserhalb des Ranges liegt...
		this.iStatus 	= -1
		this.sError		= "Warning: Active Custom Boarding Bill is not valid anymore!"
		return this.istatus
	else
		// Warnung, dass keine aktive BoardingBill existiert...
		this.iStatus 	= -1
		this.sError		= "Warning: No Active Custom Boarding Bill found!"
		return this.istatus
	end if

else
	// ---------------------------------------------------------
	// Normale Delivery Note
	// ---------------------------------------------------------

	//Flags lesen und Variablen setzen...
	dsCustomerNumber.retrieve(lresultkey)
	if dsCustomerNumber.getitemnumber(1, "cen_delivery_note_ncustomer_number") = 1 then
		lb_customer_number = true
	end if
	if dsCustomerNumber.getitemnumber(1, "cen_delivery_note_nloading_rot_meals") = 1 then
		lb_load_ratios_meals = true
	end if
	if dsCustomerNumber.getitemnumber(1, "cen_delivery_note_nloading_rot_extra") = 1 then
		lb_load_ratios_extra = true
	end if
	
	//je nach gelesenem Zustand die "Eingeweide" vom Hauptreport setzen...
	//Meals
	if lb_customer_number and lb_load_ratios_meals then
		dsReport.object.dw_meals.dataobject = "dw_delivery_note_meals_cusno" //mit Loading Ratios
	elseif lb_customer_number and (not lb_load_ratios_meals) then
		dsReport.object.dw_meals.dataobject = "dw_delivery_note_meals_cusno_ohne_ratios"
	elseif (not lb_customer_number) and lb_load_ratios_meals then
		dsReport.object.dw_meals.dataobject = "dw_delivery_note_meals"      //mit Loading Ratios
	elseif (not lb_customer_number) and (not lb_load_ratios_meals) then
		dsReport.object.dw_meals.dataobject = "dw_delivery_note_meals_ohne_loadratios"
	else //tritt nicht auf, da schon vollst$$HEX1$$e400$$ENDHEX$$ndige Disjunktion
	end if
	
	//Extra
	if lb_customer_number and lb_load_ratios_extra then
		dsReport.object.dw_extra.dataobject = "dw_delivery_note_extra_cusno" //mit Loading Ratios
	elseif lb_customer_number and (not lb_load_ratios_extra) then
		dsReport.object.dw_extra.dataobject = "dw_delivery_note_extra_cusno_ohne_ratios"
	elseif (not lb_customer_number) and lb_load_ratios_extra then
		dsReport.object.dw_extra.dataobject = "dw_delivery_note_extra"       //mit Loading Ratios
	elseif (not lb_customer_number) and (not lb_load_ratios_extra) then
		dsReport.object.dw_extra.dataobject = "dw_delivery_note_extra_ohne_loadratios"
	else //tritt nicht auf, da schon vollst$$HEX1$$e400$$ENDHEX$$ndige Disjunktion
	end if
	
	dsReport.SetTransObject(sqlca)

	// ---------------------------------
	// Das richtige Logo raussuchen
	// ---------------------------------
	select nlogo into :ll_logo from cen_airlines where nairline_key = :this.lAirlineKey;
	if sqlca.sqlcode <> 0 then
		this.iStatus 	= -1
		this.sError		= "Error getting LogoID ~r~r Errorcode: " + string(sqlca.sqlcode) + "~r~r" + sqlca.sqlerrtext
		return this.iStatus
	end if
	select ccolor_logo into :ls_logo from sys_logos where nlogo_key = :ll_logo ;
	if sqlca.sqlcode <> 0 then
		this.iStatus 	= -1
		this.sError		= "Error getting LogoName ~r~r Errorcode: " + string(sqlca.sqlcode) + "~r~r" + sqlca.sqlerrtext
		return this.iStatus
	end if
	ls_logo = f_gettemppath() + ls_logo

	// ---------------------------------------------------------
	// BARCODE
	// ---------------------------------------------------------
	//uo_dn_barcode lnv_dn_barcode
	lnv_dn_barcode = CREATE	uo_dn_barcode
	li_Barcode = lnv_dn_barcode.of_create_and_save( li_CustomerBill, lResultKey, ltransaction, lAirlineKey, ldt_departure, ls_BarCode_picture)
	
	
	// ---------------------------------
	// Die Lieferscheineinstellungen
	// der Airline einlesen
	// ---------------------------------
	dsSetup.Retrieve(this.lAirlineKey)
	if dsSetup.RowCount() = 0 then
		this.iStatus 	= -1
		this.sError		= "No Delivery Note defined"
		return this.iStatus
	end if

	ls_title = dsSetup.GetItemString(1, "ctitle")
	// -----------------------------------------
	// Sollen die HandlingsInfos gedruckt werden
	// -----------------------------------------
	ll_status = dsSetup.GetItemNumber(1, "nloadinglist")
	if ll_status = 0 then dsReport.Modify("Destroy dw_handling")
	
	// -----------------------------------------
	// BarCode
	// -----------------------------------------
	If li_Barcode <> 1 then
		dsReport.Modify("Destroy dw_barcode")
	End If
	
	
	// -----------------------------------------
	// Sollen die VersionsInfos gedruckt werden
	// -----------------------------------------
	ll_status	= dsSetup.GetItemNumber(1, "nversion")



	if ll_status = 0 then dsReport.Modify("Destroy dw_version")
	// -----------------------------------------
	// Sollen die MahlzeitenInfos gedruckt werden
	// -----------------------------------------
	ll_status = dsSetup.GetItemNumber(1, "nmeals")
	if ll_status = 0 then
		dsReport.Modify("Destroy dw_meals")
	else
		ll_status = dsSetup.GetItemNumber(1, "nuse_flags")

		if ll_status = 1 then // Stammdaten-Schalter soll verwendet werden
			// und nicht die angegebenen St$$HEX1$$fc00$$ENDHEX$$cklistentypen

			//*** G. Brosch, 14.04.2009: loading Ratios eingebaut >>>
			if lb_customer_number and lb_load_ratios_meals then
				dsReport.object.dw_meals.dataobject = "dw_delivery_note_meals_using_flags_cuslr"
			elseif lb_customer_number and (not lb_load_ratios_meals) then
				dsReport.object.dw_meals.dataobject = "dw_delivery_note_meals_using_flags_cusno"
			elseif (not lb_customer_number) and lb_load_ratios_meals then
				dsReport.object.dw_meals.dataobject = "dw_delivery_note_meals_using_flags_lr"
			elseif (not lb_customer_number) and (not lb_load_ratios_meals) then
				dsReport.object.dw_meals.dataobject = "dw_delivery_note_meals_using_flags"
			else //tritt nicht auf, da schon vollst$$HEX1$$e400$$ENDHEX$$ndige Disjunktion
			end if
			//***<<<

		end if

	end if
	// -----------------------------------------
	// Sollen die SPML - Infos gedruckt werden
	// -----------------------------------------
	ll_status = dsSetup.GetItemNumber(1, "nspmls")
	if ll_status = 0 then 	dsReport.Modify("Destroy dw_spml")
	// -----------------------------------------
	// Sollen die ExtraInfos gedruckt werden
	// -----------------------------------------
	ll_status = dsSetup.GetItemNumber(1, "nextra_loading")
	if ll_status = 0 then
		dsReport.Modify("Destroy dw_extra")
	else
		ll_status = dsSetup.GetItemNumber(1, "nuse_flags_add_loading")

		if ll_status = 1 then // Stammdaten-Schalter soll verwendet werden
			// und nicht die angegebenen St$$HEX1$$fc00$$ENDHEX$$cklistentypen

			//*** G. Brosch, 14.04.2009: loading Ratios eingebaut >>>
			if lb_customer_number and lb_load_ratios_extra then
				dsReport.object.dw_extra.dataobject = "dw_delivery_note_extra_using_flags_cuslr"
			elseif lb_customer_number and (not lb_load_ratios_extra) then
				dsReport.object.dw_extra.dataobject = "dw_delivery_note_extra_using_flags_cusno"
			elseif (not lb_customer_number) and lb_load_ratios_extra then
				dsReport.object.dw_extra.dataobject = "dw_delivery_note_extra_using_flags_lr"
			elseif (not lb_customer_number) and (not lb_load_ratios_extra) then
				dsReport.object.dw_extra.dataobject = "dw_delivery_note_extra_using_flags"
			else //tritt nicht auf, da schon vollst$$HEX1$$e400$$ENDHEX$$ndige Disjunktion
			end if
			//***<<<

		end if

	end if

	// -------------------------------------------------------
	// 16.03.2006: Sollen Textinfos gedruckt werden?
	// dw_delivery_note_textinfo
	// -------------------------------------------------------
	li_textinfo = dsSetup.GetItemNumber(1, "ntext_info")
	if li_textinfo = 0 or isnull(li_textinfo) then
		dsReport.Modify("Destroy dw_textinfo")
	end if


	// -----------------------------------------
	// Fu$$HEX1$$df00$$ENDHEX$$zeile beackern
	// -----------------------------------------
	dsReport.Modify("t_signature.text = '" + s_app.sOrga + "'")
	dsReport.Modify("t_printed.text = '" + string(today(),s_app.sDateformat) + "  " + string(now(),"HH:MM") + "'")
	dsReport.Retrieve(this.lResultKey)

	// -----------------------------------------
	// BarCode 
	// -----------------------------------------
	If li_Barcode = 1 Then
		If trim(ls_BarCode_picture) > "" Then
			If FileExists(ls_BarCode_picture) Then
				if dsReport.GetChild ("dw_barcode", dwcBarCode ) = 1 then
					ls_Mod = "p_barcode.filename='"+ls_BarCode_picture+"'"
					ls_Error = dwcBarCode.Modify(ls_Mod)
					//dsReport.Modify("t_signature.text = '" + s_app.sOrga + "'")
				End If
			End If		
		End If
	End If

	// ---------------------------------------------------------
	// Child f$$HEX1$$fc00$$ENDHEX$$r den Header
	// hier holen wir uns den AirlineKey f$$HEX1$$fc00$$ENDHEX$$r die Einstellungen
	// ---------------------------------------------------------
	if dsReport.GetChild ("dw_header", dwcHeader ) <> 1 then
		this.iStatus 	= -1
		this.sError		= "Error creating subreport 1"
		return this.iStatus
	else
		If of_is_healthmark_enabled(ls_unit) Then
			ls_Mod = "l_healthmark_v.visible='1'"
			ls_Error = dwcHeader.Modify(ls_Mod)
			ls_Mod = "sys_units_ctext.width='75'"
			ls_Error = dwcHeader.Modify(ls_Mod)
			ls_Mod = "t_8.width='75'"
			ls_Error = dwcHeader.Modify(ls_Mod)
			ls_Mod = "l_12.x2='117'"
			ls_Error = dwcHeader.Modify(ls_Mod)
		End If
		
	end if

	// ---------------------------------------------------------
	// Child f$$HEX1$$fc00$$ENDHEX$$r die Mahlzeiten
	// nachtr$$HEX1$$e400$$ENDHEX$$glich den letzten Mahlzeitenstand einlesen
	// ---------------------------------------------------------
	if dsSetup.GetItemNumber(1, "nmeals") = 1 then
		if dsReport.GetChild ("dw_meals", dwcMeals ) <> 1 then
			this.iStatus 	= -1
			this.sError		= "Error creating subreport 2"
			return this.iStatus
		else

			if this.of_get_meals() <> 0 then
				return this.iStatus
			end if

		end if
	end if

	// -----------------------------------------
	// Die Paxe alt/neu
	// -----------------------------------------
	if this.of_get_pax() <> 0 then
		return this.iStatus
	end if

	// -----------------------------------------
	// Reserven setzen im Pax-Teil
	// -----------------------------------------
	if this.of_get_reserve() <> 0 then
		return this.iStatus
	end if


	// -----------------------------------------
	//
	// Der Detail-Report
	//
	// -----------------------------------------
	if dsSetup.GetItemNumber(1, "nloadinglist_detail") = 1 then

		if lb_customer_number then
			if dsSetup.GetItemNumber(1, "nloadinglist_by_truck") = 1 then
				dsDetailReport.DataObject = "dw_delivery_note_detail_by_truck_print_c"
			else
				dsDetailReport.DataObject = "dw_delivery_note_detail_print_cusno"
			end if
		else
			if dsSetup.GetItemNumber(1, "nloadinglist_by_truck") = 1 then
				dsDetailReport.DataObject = "dw_delivery_note_detail_by_truck_print"
			else
				dsDetailReport.DataObject = "dw_delivery_note_detail_print"
			end if
		end if

		if this.of_get_details(lb_customer_number) <> 0 then
			return this.iStatus
		end if

	end if
	// ---------------------------------------------------------
	// ReportNummer nur wenn gew$$HEX1$$fc00$$ENDHEX$$nscht holen und wegspeichern
	// ---------------------------------------------------------
	if isnull(lBillingKey) or lBillingKey = 0 then
		//
		// falls nichts gesetzt ist, dann alte Verarbeitung
		//
		lBillingKey = this.of_get_number()
	else
		if bAskForNewKey then
			//
			// Nur bei einzelnen Fl$$HEX1$$fc00$$ENDHEX$$gen wird gefragt
			//
			//if uf.mbox("Catering Order","Soll eine neue Belegnummer vergeben werden?",Question!,YesNo!,2) = 1 then
			if bNewNumber then
				lBillingKey = this.of_get_number()
				if lBillingKey <= 0 then
					this.iStatus = lBillingKey
					return this.lBillingKey
				end if
			end if
		end if
	end if

	// --------------------------------------------------------------
	// Speichern der Reportnummmer
	// --------------------------------------------------------------
	this.of_save(lBillingKey)


	if dwcHeader.RowCount() > 0 then
		ll_aircraft_key = dwcHeader.GetItemNumber(1, "naircraft_key")
	end if

	// -----------------------------------------
	// $$HEX1$$dc00$$ENDHEX$$bersetzen, wenn Sprache auf Englisch
	// gestellt ist
	// -----------------------------------------
	if dsSetup.GetItemNumber(1, "ntranslate") = 2 then
		li_language = s_app.iLanguage
		s_app.iLanguage = 2
		uf.translate_datastore(dsReport)
		s_app.iLanguage = li_language
	end if

	dwcHeader.Modify("t_title.text = '" + ls_title + "'" )
	dwcHeader.Modify("t_number.text = '" + string(lBillingKey) + "'")
	dwcHeader.Modify("p_logo.filename = '" + ls_logo + "'")

	//*** G. Brosch, 17.03.2009
	openwithparm(w_loading_rotations, this)
	close(w_loading_rotations)
	//***<<<

	//
	// Drucker
	//
	if sPrinter <> "" then
		dsReport.Modify("datawindow.printer='" + sPrinter + "'")
	else
		dsReport.Modify("datawindow.printer='" + ls_CateringOrderPrinter + "'")
	end if

	dsReport.Modify("datawindow.print.documentname = 'Catering Order'")
	dsReport.Modify("DataWindow.print.copies = " + string(this.iCopies))


	// -----------------------------------------
	// Healthmark
	// -----------------------------------------
	If of_is_healthmark_enabled(ls_unit) then
		of_draw_healthmark( ls_unit, dsReport)
	End If

	// -----------------------------------------
	// Bei Trennung des Detail Reports nach
	// Gruppe ... Pro "Gruppe" einen Liefer-
	// Schein drucken
	// -----------------------------------------
	if dsSetup.GetItemNumber(1, "nloadinglist_by_truck") = 1 then
		dsGalleyGroups.Retrieve(ll_aircraft_key)

		// for i = 1 to dsGalleyGroups.RowCount()
		// 17.02.2010 Ulrich Paudler [UP]
		if ab_pdf then
			// Druckfertiges DW in DS kopieren
			ads_datastore[upperbound(ads_datastore) + 1] = create datastore
			//dsDetailReport.GetFullState( lblb_blob)
			// 24.02.2010, KF: Falscher Report wurde geblobbt
			dsReport.GetFullState( lblb_blob)
			
			ads_datastore[upperbound(ads_datastore)].SetFullState(lblb_blob)
			
		
		else
			if iPrintPreview = 1 then
				f_print_datastore(dsReport)
			else
				dsReport.print()
			end if
		end if
		// next

	else
		// for j = 1 to this.iCopies
		// 17.02.2010 Ulrich Paudler [UP]
		if ab_pdf then
			// Druckfertiges DW in DS kopieren
			ads_datastore[upperbound(ads_datastore) + 1] = create datastore
			//dsDetailReport.GetFullState( lblb_blob)
			//24.02.2010, KF: Falsche Datastore wurde geblobbt
			dsReport.GetFullState( lblb_blob)
			ads_datastore[upperbound(ads_datastore)].SetFullState(lblb_blob)
			
			If s_app.itrace = 1 then
				ads_datastore[upperbound(ads_datastore)].saveas("c:\temp\cbase\deliverynote_"+String(cpu()) + ".psr",psreport!,true)
			end if

			
		else
			if iPrintPreview = 1 then
				f_print_datastore(dsReport)
			else
				dsReport.print()
			end if
		end if
		// next
	end if


	if dsSetup.GetItemNumber(1, "nloadinglist_detail") = 1 then
		this.of_format_datastore(dsDetailReport)
		// -----------------------------------------
		// $$HEX1$$dc00$$ENDHEX$$bersetzen, wenn Sprache auf Englisch
		// gestellt ist
		// -----------------------------------------
		if dsSetup.GetItemNumber(1, "ntranslate") = 2 then
			li_language = s_app.iLanguage
			s_app.iLanguage = 2
			uf.translate_datastore(dsDetailReport)
			s_app.iLanguage = li_language
		end if

		dsDetailReport.Modify("t_title.text = '" + ls_title + " Detail'" )
		dsDetailReport.Modify("p_logo.filename = '" + ls_logo + "'")
		dsDetailReport.Modify("t_number.text = '" + string(lBillingKey) + "'")
		dsDetailReport.Modify("DataWindow.print.copies = " + string(this.iCopies))
		
		// -----------------------------------------
		// Healthmark
		// -----------------------------------------
		If of_is_healthmark_enabled(ls_unit) then
			of_draw_healthmark( ls_unit, dsDetailReport)
		End If
		
		
		// for j = 1 to this.iCopies
		// 17.02.2010 Ulrich Paudler [UP]
		if ab_pdf then
			// Druckfertiges DW in DS kopieren
			ads_datastore[upperbound(ads_datastore) + 1] = create datastore
			dsDetailReport.GetFullState( lblb_blob)
			ads_datastore[upperbound(ads_datastore)].SetFullState(lblb_blob)
			
		else
			if iPrintPreview = 1 then
				f_print_datastore(dsDetailReport)
			else
				dsDetailReport.print()
			end if
		end if
		// next

	end if
end if

// --------------------------------------------------------
// Enqueue flight for INT007 processing
// --------------------------------------------------------
If luo_rtn_queue.of_is_enabled(s_app.smandant, SQLCA) then
	ll_Succ = luo_rtn_queue.of_enqueue_flight(lresultkey, "INT007", SQLCA, "uo_delivery_note")
End if

return 0

end function

on uo_delivery_note.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_delivery_note.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
is_filepath = f_gettemppath() //HR 30.08.2010

dsSetup	= create Datastore
dsSetup.dataobject = "dw_delivery_note_edit"
dsSetup.SetTransObject(sqlca)

//*** G. Brosch, 02.04.2009: NAM-CR0006 >>>
dsCustomerNumber = create Datastore
dsCustomerNumber.dataobject = "dw_customer_number"
dsCustomerNumber.SetTransObject(sqlca)
//*** <<<

dsReport	= create Datastore                                      
dsReport.dataobject = "dw_delivery_note_print"
dsReport.SetTransObject(sqlca)

dsDetailReport	= create Datastore
dsDetailReport.dataobject = "dw_delivery_note_detail_print"
dsDetailReport.SetTransObject(sqlca)

dsGalleyGroups = create Datastore
dsGalleyGroups.dataobject = "dw_delivery_note_galley_groups"
dsGalleyGroups.SetTransObject(sqlca)

dsPaxHistory = create Datastore
dsPaxHistory.dataobject = "dw_delivery_note_pax_history"
dsPaxHistory.SetTransObject(sqlca)

dsKeys = create datastore
dsKeys.dataobject = "dw_multileg_report_result_keys"
dsKeys.SetTransobject(sqlca)

//*** G. Brosch, 27.04.2009: NAM-CR0006 >>>
dsCustomBoardingBill = create Datastore
dsCustomBoardingBill.dataobject = "dw_custom_boarding_bill"
dsCustomBoardingBill.SetTransObject(sqlca)
//*** <<<

ids_cust_board_bill_by_unit = create Datastore
ids_cust_board_bill_by_unit.dataobject = "dw_cust_board_bill_by_unit"
ids_cust_board_bill_by_unit.SetTransObject(sqlca)


end event

event destructor;
Destroy dsReport
Destroy dsDetailReport
Destroy dsSetup
Destroy dsGalleyGroups
Destroy dsPaxHistory
Destroy dsKeys
Destroy dsCustomerNumber
Destroy dsCustomBoardingBill
Destroy ids_cust_board_bill_by_unit


end event

