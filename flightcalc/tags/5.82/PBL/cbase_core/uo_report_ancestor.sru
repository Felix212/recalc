HA$PBExportHeader$uo_report_ancestor.sru
$PBExportComments$Ancestor Object f$$HEX1$$fc00$$ENDHEX$$r Reports
forward
global type uo_report_ancestor from datastore
end type
end forward

global type uo_report_ancestor from datastore
string dataobject = "dw_report_dummy"
event ue_retrieve ( )
end type
global uo_report_ancestor uo_report_ancestor

type variables
String 	sErrorMessage, sObjects[]
Long 		lReportID
String	sDescription
DataWindowChild dwChilds[]
Boolean	bsuccessful
Integer	iPrintDirectly
Integer	iExcel = 0
String	sExcelText1, &
			sExcelText2, &
			sExcelText3, &
			sExcelText4
			
			
s_retrieval_arguments	strArguments		


Boolean	bFlightNumber, &
			bFlightRange, &
			bDate1, &
			bDate2, &
			bTime, &
			bAirline, &
			bPlType, &
			bClass, &
			bRouting, &
			bPackinglists, &
			bUnits, &
			bFreeText1, &
			bFreeText2, &
			bFreeText3, &
			bFreeText4, &
			bFreeText5, &
			bFreeText6, &
			bFreeText7, &
			bFreeText8, &
			bFreeText9, &
			bFreeText10, &
			bSingleAirline, &
			bFlightOverView, &
			bUnitAreas, &
			bWorkstations, &
			bMasterData, &
			bPackinglistCheck

Long 		lFlightNumberX, &
			lFlightRangeX, &
			lDate1X, &
			lDate2X, &
			lTimeX, &
			lAirlineX, &
			lPlTypeX, &
			lClassX, &
			lRoutingX, &
			lPackinglistsX, &
			lUnitsX, &
			lUnitAreasX, &
			lWorkstationsX, &
			lSingleAirlineX, &
			lFlightOverViewX, &
			lFreeText1X, &
			lFreeText2X, &
			lFreeText3X, &
			lFreeText4X, &
			lFreeText5X, &
			lFreeText6X, &
			lFreeText7X, &
			lFreeText8X, &
			lFreeText9X, &
			lFreeText10X
			
Long 		lFlightNumberY, &
			lFlightRangeY, &
			lDate1Y, &
			lDate2Y, &
			lTimeY, &
			lAirlineY, &
			lPlTypeY, &
			lClassY, &
			lRoutingY, &
			lUnitAreasY, &
			lWorkstationsY, &
			lPackinglistsY, &
			lUnitsY, &
			lSingleAirlineY, &
			lFlightOverViewY, &
			lFreeText1Y, &
			lFreeText2Y, &
			lFreeText3Y, &
			lFreeText4Y, &
			lFreeText5Y, &
			lFreeText6Y, &
			lFreeText7Y, &
			lFreeText8Y, &
			lFreeText9Y, &
			lFreeText10Y
			
Long		lFreeText1Width, &
			lFreeText2Width, &
			lFreeText3Width, &
			lFreeText4Width, &
			lFreeText5Width, &
			lFreeText6Width, &
			lFreeText7Width, &
			lFreeText8Width, &
			lFreeText9Width, &
			lFreeText10Width
			
			
String	sDate1Text, &
			sDate2Text, &
			sFreeText1Text, &
			sFreeText2Text, &
			sFreeText3Text, &
			sFreeText4Text, &
			sFreeText5Text, &
			sFreeText6Text, &
			sFreeText7Text, &
			sFreeText8Text, &
			sFreeText9Text, &
			sFreeText10Text, &
			sReportText
			

end variables

forward prototypes
public function integer of_retrieve ()
public function integer of_set_orga_string (string sobject)
public function integer of_create_childs ()
public function String of_get_report_name ()
public function string of_picturename ()
public function boolean of_editstyle ()
public function integer of_check_object (string sobject)
public function integer of_create_logo ()
public function integer of_init ()
public function long of_get_report_number ()
public function boolean of_get_number ()
public function integer of_analyse ()
public function integer of_create (string sdatawindow)
public function string of_get_routing_text ()
end prototypes

public function integer of_retrieve ();

return 0
end function

public function integer of_set_orga_string (string sobject);return 0
end function

public function integer of_create_childs ();// ---------------------------------------
// Das Array nach SubReports durchsuchen
// ---------------------------------------
String 	sObjectType
Blob 		bDatawindow
String 	sDatawindow
String 	sError
Blob		bInsert
Integer	I, iChildCounter

datawindowchild dwDummy
// --------------------------------------------------------------------------
// Dann alle Objekte des Typs report finden
// --------------------------------------------------------------------------
For i = 1 to UpperBound(this.sObjects)
	
	sObjectType = this.describe(sObjects[i] + ".type")
	
	if sObjectType = "report" then // Treffer
	
		// --------------------------------------
		// den Syntax aus der Datenbank lesen
		// --------------------------------------

		selectblob sys_report_childs.bDatawindow
				into :bDatawindow
				from sys_report_childs
			  where sys_report_childs.nreport_id = :lReportID and
			        sys_report_childs.cobject_name = :sObjects[i];
	
		if sqlca.sqlcode <> 0 then
			this.sErrorMessage = "Fehler beim Erstellen der Datawindows!"
			return -1
		end if
		
		sDatawindow = String(bDatawindow)
		iChildCounter ++
		dwChilds[iChildCounter] = dwDummy
		
		//if this.GetChild(sObjects[i],dwChilds[iChildCounter]) <> 1 then
		if this.GetChild(sObjects[i],dwDummy) <> 1 then
			this.sErrorMessage = "Erstellen des SubReports: ${" +sObjects[i] + "} fehlgeschlagen."
			return - 1
		end if
		
		//Messagebox("",dwChilds[iChildCounter].Modify(sDatawindow) )//Create(sDatawindow, sError)
		dwChilds[iChildCounter].SetTransObject(sqlca)
			
	end if
	
Next

return 0
end function

public function String of_get_report_name ();string sReport

Choose case s_app.iLanguage	

	case 1
	  SELECT sys_reports.ctext INTO :sReport FROM sys_reports WHERE sys_reports.nreport_id = :this.lReportID ;

	case 2
	  SELECT sys_reports.ctext1 INTO :sReport FROM sys_reports WHERE sys_reports.nreport_id = :this.lReportID ;

	case 3
	  SELECT sys_reports.ctext2 INTO :sReport FROM sys_reports WHERE sys_reports.nreport_id = :this.lReportID ;

	case 4
	  SELECT sys_reports.ctext3 INTO :sReport FROM sys_reports WHERE sys_reports.nreport_id = :this.lReportID ;

	case 5
	  SELECT sys_reports.ctext4 INTO :sReport FROM sys_reports WHERE sys_reports.nreport_id = :this.lReportID ;

End Choose

if sqlca.sqlcode = 0 then
	return sReport
else
	return ""
end if
	
end function

public function string of_picturename ();// --------------------------------------------------
//
// Syntax LibraryExport 
// bitmap(band=header filename="..\resource\lsg_color.jpg"  .............
// 
//	Syntax dwo.Describe("datawindow.syntax")
// bitmap(band=header filename="..~\resource~\lsg_color.jpg"  .............
// 
// --------------------------------------------------

//String sSyntax

//For i = 1 to Len(Trim(sSyntax))
//	if Mid(sSyntax, I, 1) = char(126) then // char(126) = Tilde
//		
//	end if
//Next

string	sPictureFileName

sPictureFileName = this.Describe("p_logo.filename")

//Messagebox("", sPictureFileName)

return sPictureFileName
end function

public function boolean of_editstyle ();// --------------------------------------
// Standard Editstyles und Pr$$HEX1$$fc00$$ENDHEX$$fungen
// --------------------------------------
	integer i,iColumns
	string  sColumnType,sColumnText,sColumnName,sDataType
	string  sMText
	string  sReturn
	long	  lDDDWwidth,lWidth,lPercentWidth

// -------------------------------
// Standard Datawindow Freeform
// -------------------------------
	this.Modify("DataWindow.Message.Title='" + uf.translate("Eingabefehler") + "'")

	iColumns = integer(this.Object.DataWindow.Column.Count)
	For i = 1 to iColumns
		sColumnType = this.describe("#" + string(i) + ".Edit.Style")
		sDataType = lower(this.Describe ("#" + string(i) + ".ColType"))
		// --------------------------------------
		// nur Columns die eine Width haben !
		// --------------------------------------
		If integer(this.Describe("#" + string(i) + ".Width")) > 0 Then
			// --------------------------------------
			// Neu Dateformat
			// --------------------------------------
			If Match (sDataType, "date") Then
				this.Modify("#" + string(i) + ".Edit.Format='" + s_app.sDateformat   + "'")
				this.Modify("#" + string(i) + ".Format='" + s_app.sDateformat   + "'")
			End if	
			// -------------------------------------------
			// Neu Decimal
			// Nur formatieren wenn es KEINE editmask ist
			// -------------------------------------------
			
			if sColumnType <> "editmask" then
			
				If Match (sDataType, "decimal(2)") Then
					this.Modify("#" + string(i) + ".Format='#,###,##0.00'")
					this.Modify("#" + string(i) + ".edit.format='#,###,##0.00'")
				end if
				If Match (sDataType, "decimal(3)") Then
					this.Modify("#" + string(i) + ".Format='#,###,##0.000'")
					this.Modify("#" + string(i) + ".edit.format='#,###,##0.000'")
					//MessageBox(this.describe("#" + string(i) + ".name") + "      ",sColumnType)
					//Messagebox("", this.describe("#" + string(i) + ".name"))
					//dw_1.Object.cen_packinglists_nweight.format = "#,###,##0.000"
				end if
				
			end if
			// --------------------------------------
			// Standard Eigenschaften Edit
			// --------------------------------------
			If Upper(sColumnType) = "EDIT" Then
				
				this.Modify("#" + string(i) + ".Edit.FocusRectangle=NO")
				this.Modify("#" + string(i) + ".Edit.AutoHScroll=YES")
				this.Modify("#" + string(i) + ".Edit.AutoSelect=YES")
			End if	
		End if	
	Next

	
return True
end function

public function integer of_check_object (string sobject);integer I

for i = 1 to UpperBound(this.sObjects)
	
	if this.sObjects[i] = sObject then
		return I
	end if
	
next

return -1
end function

public function integer of_create_logo ();// --------------------------------------------
// da es Probleme mit der Anzeige des
// Logos gibt wird mit dieser Funktion
// ein Computed Field anstelle des Objektes
// p_logo eingef$$HEX1$$fc00$$ENDHEX$$gt
// --------------------------------------------
string 	sX, &
			sY, &
			sWidth, &
			sHeight, &
			sSyntax, &
			sFile, &
			sReturn

sX      = this.Describe("p_logo.x")
sY      = this.Describe("p_logo.y")
sWidth  = this.Describe("p_logo.width")
sHeight = this.Describe("p_logo.height")

//sFile	  = this.Describe("p_logo.filename")

sFile = f_gettemppath() + s_app.sReportLogo

this.Modify("p_logo.filename='" + sFile + "'")
this.Modify("p_logo.x = " + sX)
this.Modify("p_logo.y = " + sY)
this.Modify("p_logo.width = " + sWidth)
this.Modify("p_logo.height = " + sHeight)


//Messagebox("", sFile)


//sSyntax = "create compute(band=header alignment='0' expression='bitmap(~"" + sFile + "~")' border='0' color='0' x='" + sX+ "' y='" + sY + "' height='" + sHeight + "' width='" + sWidth + "' format='[GENERAL]'  name=compute_logo  font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )"
//
//// -------------------------------------------
//// Picture Objekt entfernen
//// -------------------------------------------
//sReturn = this.Modify("destroy p_logo")
//
//if sReturn <> "" then
//	this.sErrorMessage = "Fehler beim Entfernen des Logos~r~r" + sReturn
//	return -1
//end if
//
//// -------------------------------------------
//// ComputedField erstellen
//// -------------------------------------------
//sReturn = this.Modify(sSyntax)
//
//if sReturn <> "" then
//	this.sErrorMessage = "Fehler beim Erstellen des Logos~r~r" + sReturn 
//	return -1
//else
//	// --------------------------------
//	// Logo in den Hintergrund 
//	// --------------------------------
//	this.SetPosition("compute_logo", "", False)
//end if	

return 0

end function

public function integer of_init ();// --------------------------------------------------------------
// 
// Positionen der Controls im Report Browser bestimmen
//
// --------------------------------------------------------------

// --------------------------------------------------------------
// Einzelne Flugnummer
// uo_flight
// --------------------------------------------------------------
bFlightNumber 		= false
lFlightNumberX 	= 10
lFlightNumberY 	= 10
// --------------------------------------------------------------
// Einzelne Airline
// uo_airline_single
// --------------------------------------------------------------
bSingleAirline 	= false
lSingleAirlineX	= 10
lSingleAirlineY	= 10
// --------------------------------------------------------------
// Auflistung von Fl$$HEX1$$fc00$$ENDHEX$$gen
// uo_flights_overview
// --------------------------------------------------------------
bFlightOverView 	= false
lFlightOverViewX	= 101
lFlightOverViewY	= 300
// --------------------------------------------------------------
// Flugnummernkreis
// uo_flights
// --------------------------------------------------------------
bFlightRange		= false
lFlightRangeX		= 10
lFlightRangeY		= 10
// --------------------------------------------------------------
// Datum 1
// uo_date1
// --------------------------------------------------------------
bDate1				= false
lDate1X				= 10
lDate1Y				= 10
sDate1Text			= uf.translate("G$$HEX1$$fc00$$ENDHEX$$ltig ab")
// --------------------------------------------------------------
// Datum 2
// uo_date2
// --------------------------------------------------------------
bDate2				= false
lDate2X				= 10
lDate2Y				= 10
sDate2Text			= uf.translate("G$$HEX1$$fc00$$ENDHEX$$ltig bis")
// --------------------------------------------------------------
// Uhrzeit von/bis + betriebliche OPS
// uo_ops
// --------------------------------------------------------------
bTime		= false
lTimeX	= 10
lTimeY	= 10
// --------------------------------------------------------------
// Airlines
// uo_airline
// --------------------------------------------------------------
bAirline		= false
lAirlineX	= 10
lAirlineY	= 10
// --------------------------------------------------------------
// Airlinesklasses
// uo_classname
// --------------------------------------------------------------
bClass		= false
lClassX		= 10
lClassY		= 10
// --------------------------------------------------------------
// Strecken
// uo_rout
// --------------------------------------------------------------
bRouting			= false
lRoutingX		= 10
lRoutingY		= 10
// --------------------------------------------------------------
// Betriebe
// uo_rout
// --------------------------------------------------------------
bUnits			= false
lUnitsX		= 10
lUnitsY		= 10
// --------------------------------------------------------------
// St$$HEX1$$fc00$$ENDHEX$$cklistentypen
// uo_pl_types_new
// --------------------------------------------------------------
bPlType			= false
lPlTypeX		= 10
lPlTypeY		= 10
// --------------------------------------------------------------
// St$$HEX1$$fc00$$ENDHEX$$cklisten
// uo_plnumbers
// --------------------------------------------------------------
bPackinglists			= false
lPackinglistsX			= 10
lPackinglistsY			= 10

// --------------------------------------------------------------
// St$$HEX1$$fc00$$ENDHEX$$cklisten per Stammdaten
// uo_plnumbers
// --------------------------------------------------------------
bMasterData 			= false

// --------------------------------------------------------------
// Bereiche
// uo_unit_areas
// --------------------------------------------------------------
bUnitAreas				= false
lUnitAreasX				= 10	
lUnitAreasY				= 10

// --------------------------------------------------------------
// Workstations
// uo_unit_areas
// --------------------------------------------------------------
bWorkstations			= false
lWorkstationsX			= 10
lWorkstationsY			= 10

// --------------------------------------------------------------
// Freitexte 1 - 10 
// st_text1 bis st_text10
// --------------------------------------------------------------
bFreeText1 			= false
lFreeText1X			= 10
lFreeText1Y			= 10
lFreeText1Width	= 900
sFreeText1Text		= uf.translate("none")

bFreeText2 			= false
lFreeText2X			= 10
lFreeText2Y			= 10
lFreeText2Width	= 900
sFreeText2Text		= uf.translate("none")

bFreeText3 			= false
lFreeText3X			= 10
lFreeText3Y			= 10
lFreeText3Width	= 900
sFreeText3Text		= uf.translate("none")

bFreeText4 			= false
lFreeText4X			= 10
lFreeText4Y			= 10
lFreeText4Width	= 900
sFreeText4Text		= uf.translate("none")

bFreeText5 			= false
lFreeText5X			= 10
lFreeText5Y			= 10
lFreeText5Width	= 900
sFreeText5Text		= uf.translate("none")

bFreeText6 			= false
lFreeText6X			= 10
lFreeText6Y			= 10
lFreeText6Width	= 900
sFreeText6Text		= uf.translate("none")

bFreeText7 			= false
lFreeText7X			= 10
lFreeText7Y			= 10
lFreeText7Width	= 900
sFreeText7Text		= uf.translate("none")

bFreeText8 			= false
lFreeText8X			= 10
lFreeText8Y			= 10
lFreeText8Width	= 900
sFreeText8Text		= uf.translate("none")

bFreeText9 			= false
lFreeText9X			= 10
lFreeText9Y			= 10
lFreeText9Width	= 900
sFreeText9Text		= uf.translate("none")

bFreeText10 		= false
lFreeText10X		= 10
lFreeText10Y		= 10
lFreeText10Width	= 900
sFreeText10Text	= uf.translate("none")

return 0
end function

public function long of_get_report_number ();// ---------------------------------------------------------------
// Die H$$HEX1$$f600$$ENDHEX$$chste Report-ID auslesen
// ---------------------------------------------------------------
Long lNumber
DateTime	dtNow

select max(ncounter) into :lNumber from sys_report_count where nreport_id = :this.lReportID;

if sqlca.sqlcode = 0 then
	
	// ---------------------------------------
	// lNumber ist nicht NULL, also
	// updaten
	// ---------------------------------------
	if not isnull(lNumber) then
	
		lNumber ++
		dtNow = DateTime(Today(), Now())
		
		UPDATE sys_report_count  
		  SET nreport_id = :this.lReportID,   
				ncounter = :lNumber,   
				dlast = :dtNow  
		WHERE sys_report_count.nreport_id = :this.lReportID ;
		 
		if sqlca.sqlcode = 0 then
			commit;
		end if
		 
	else
		
		lNumber = 1
		dtNow   = DateTime(Today(), Now())
		
		INSERT INTO sys_report_count  
					 ( nreport_id,   
						ncounter,   
						dlast )  
			VALUES ( :this.lReportID,   
						:lNumber,   
						:dtNow )  ;
						
		if sqlca.sqlcode = 0 then
			commit;
		end if				
		
	end if
	
end if

return lNumber
end function

public function boolean of_get_number ();// ------------------------------------------------------------------
// Die bleyersche Variante der Reportz$$HEX1$$e400$$ENDHEX$$hlung
// ------------------------------------------------------------------

Long 		lReport_Number
String	sName

sName = this.DataObject
SELECT sys_application_report.ncounter  
  INTO :lReport_Number  
  FROM sys_application_report  
 WHERE ( sys_application_report.cclient = :s_app.smandant) AND  
		 ( sys_application_report.cunit = :s_app.swerk) AND  
		 ( sys_application_report.cdatawindow = :sName)   ;
		 
// ---------------------------------------------------------------------------
// Tabelleneintrag anlegen !
// ---------------------------------------------------------------------------	
If SQLCA.SQLCODE = 100 Then
	INSERT INTO sys_application_report  
		(cclient,   
		 cunit,   
		 cdatawindow,   
		 ncounter)  
	VALUES
		(:s_app.smandant,   
		 :s_app.swerk,   
		 :sName,   
		 1);
	lReport_Number = 1
// ---------------------------------------------------------------------------
// Report Nummer hoch z$$HEX1$$e400$$ENDHEX$$hlen !
// ---------------------------------------------------------------------------	
Elseif SQLCA.SQLCODE = 0 Then
	lReport_Number ++
	UPDATE sys_application_report  
		SET ncounter = :lReport_Number  
	WHERE (sys_application_report.cclient = :s_app.smandant) AND  
			(sys_application_report.cunit = :s_app.swerk) AND  
			(sys_application_report.cdatawindow = :sName)   
		  ;
End if	

COMMIT;

this.Object.t_printed.text 	= "No:" + string(lReport_Number) + "   " + this.Object.t_printed.text 
//this.Object.t_signature.width  =500
//this.Object.t_signature.text  = s_app.sorga + "/" + sReportText 
Return True
end function

public function integer of_analyse ();String 	sDWObjects, sTemp
Integer	i, iCount

// ---------------------------------------
// Alle Objekte von DW_LAYOUT auslesen
// ---------------------------------------
sDWObjects = this.describe("datawindow.objects")

// ---------------------------------------
// Den String zerhacken und alle Objekte
// ein Array schreiben
// ---------------------------------------

for i = 1 to LenA(sDWObjects)
	
	if MidA(sDWObjects, i, 1) <> CharA(9) then
		sTemp += MidA(sDWObjects, i, 1)
	else
				
		iCount ++
		this.sObjects[iCount] = sTemp
		sTemp = ""
		
	end if

next

if LenA(sTemp) > 0 then		
	iCount ++
	this.sObjects[iCount] = sTemp
end if

return 0

end function

public function integer of_create (string sdatawindow);String 	sErrors, &
			sUnits

Long 		lReportNumber

// --------------------------------
// Report ID gesetzt !!!!
// --------------------------------
if lReportID <= 0 then
	this.sErrorMessage = "Die Report-ID ist nicht gesetzt."
	return - 1
end if

// --------------------------------
// Datastore erstellen
// --------------------------------
this.Create(sDatawindow, sErrors)	
if sErrors <> "" then
	this.sErrorMessage = sErrors
	return - 1
end if

// --------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob die Units stimmen
// --------------------------------
if this.Describe("datawindow.units") <> "1" then
	this.sErrorMessage = "Der Report verwendet die falschen Einheiten.~rBitte Pixel verwenden"
	return -1
end if

// --------------------------------
// Datastoreobjekte einlesen
// --------------------------------
of_analyse()

// --------------------------------
// Datastore $$HEX1$$fc00$$ENDHEX$$bersetzten
// --------------------------------
uf.translate_datastore(this)

// --------------------------------
// Objekte pr$$HEX1$$fc00$$ENDHEX$$fen und Stadards
// eintragen
// --------------------------------

// $$HEX1$$dc00$$ENDHEX$$berschrift
//if this.of_check_object("t_title") = -1 then
//	this.sErrorMessage = "Objekt t_title fehlt."
//	return -1
//else
//	sDescription = this.of_get_report_name()
//	this.Modify("t_title.text='" + sDescription + "'")
//end if

// Orga - String
if this.of_check_object("t_signature") = -1 then
	this.sErrorMessage = "Objekt t_signature fehlt."
	return -1
else
	this.Modify("t_signature.text='" + s_app.sOrga + "  " + sReportText + "'")
end if

// Druckdatum
if this.of_check_object("t_printed") = -1 then
	this.sErrorMessage = "Objekt t_printed fehlt."
	return -1
else
	this.Modify("t_printed.text='" + String(Today(), s_app.sDateformat) + " - " + String(now(), "hh:mm")+ "'")
end if

// Reportnummer
//if this.of_check_object("t_report_number") = -1 then
//	this.sErrorMessage = "Objekt t_report_number fehlt."
//	return -1
//else
//	lReportNumber = this.of_get_report_number()	
//	this.Modify("t_report_number.text='" + String(lReportNumber, "00000" ) + "'")
//end if

// Logo
if this.of_check_object("p_logo") = -1 then
	this.sErrorMessage = "Objekt p_logo fehlt."
	return -1
else
	
	// Computed Logo einf$$HEX1$$fc00$$ENDHEX$$gen
	//if of_create_logo() <> 0 then
	//	return -1
	//end if
	
end if

// --------------------------------
// ChildReports erstellen
// --------------------------------
//if this.of_create_childs() = -1 then
//	return -1
//end if


return 0

end function

public function string of_get_routing_text ();string sRoutingReturn
integer i

sRoutingReturn = ""


for i = 1 to upperbound(strArguments.lroutingid) 
	
	if i <> upperbound(strArguments.lroutingid) then
		
		sRoutingReturn += f_rout_to_string(strArguments.lroutingid[i])+ " / "
		
	else
		
		sRoutingReturn += f_rout_to_string(strArguments.lroutingid[i])
	
	end if
	
next
return sRoutingReturn
end function

on uo_report_ancestor.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_report_ancestor.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//////this.bsuccessful = false
this.iPrintDirectly = 0
end event

