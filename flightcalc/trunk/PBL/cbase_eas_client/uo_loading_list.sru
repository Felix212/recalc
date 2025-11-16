HA$PBExportHeader$uo_loading_list.sru
$PBExportComments$Klasse mit allen Methoden rund um extra Stauorte f$$HEX1$$fc00$$ENDHEX$$r die Diagramm Design
forward
global type uo_loading_list from nonvisualobject
end type
type strsilbentrennung from structure within uo_loading_list
end type
end forward

type strSilbentrennung from structure
	string		sFontname
	integer		iFontSize
	boolean		bBold
	boolean		bItalic
	integer		iMaxWidth
	string		sTextZumTrennen
	string		sFirst
	string		sSecond
end type

global type uo_loading_list from nonvisualobject
end type
global uo_loading_list uo_loading_list

type variables
Public:
DataStore ds_matrix
string	 slogo_color,sLogo_black
Integer iUseExclusion = 0 
Integer iPrintDiagram = 1
// ----------------------------------------------------------
// Die Flug-Infos (quasi KopfDATEn)
// ----------------------------------------------------------

//
// 29.01.2003
// Datastore ist jetzt Public
//
DataStore ds_loadinglist

Datastore	dsNewspaperReport		// Referenz zu Datastore

Long		lTimeStart, lTimeEnde
String	sLoadingSequence[]


BOOLEAN	bDoAircraftChange = False	// wenn True, dann m$$HEX1$$fc00$$ENDHEX$$ssen die KopfDATEn von extern gef$$HEX1$$fc00$$ENDHEX$$llt werden.
												// spricht ACTyp, Ac-Key, Owner-Key etc. pp.
LONG		lAirlineKey
LONG		lCustomerAirlineKey
LONG		lOwnerKey
LONG		lResultKey						// Die Eindeutige Flug-Kennung f$$HEX1$$fc00$$ENDHEX$$r den Tagesflugplan

STRING	sAirlineCode
STRING	sCustomerAirlineCode
STRING	sOwnerCode
STRING	sGalleyVersion

INTEGER	iFlightNo
STRING	sSuffix
DATETIME	dtDepartureDATE		
TIME		tDepartureTIME
LONG		lAircraftKey
STRING	sAircraftType
LONG		lGroupKey

LONG		lHandlingKey
STRING	sHandling
INTEGER	iAnzahlLegs
INTEGER	iActLeg					// stimmt zu 99%. Jedoch bei 4 Leg Fl$$HEX1$$fc00$$ENDHEX$$gen explizit $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen gegen die Unit
INTEGER	iPaxKomplett
STRING	sUnit						// die Unit, welche das Ereignis verarbeitet = Users Unit ? GGf. sp$$HEX1$$e400$$ENDHEX$$ter von Relevanz
STRING	sFromTLC					// die Station, welche das Ereignis verarbeitet = Users Station ?	
STRING	sToTLC					
LONG		lFromTLCKey				// die Station, welche das Ereignis verarbeitet = Users Station ?	
LONG		lToTLCKey				
INTEGER	iVerkehrsTag

Integer 	iDocumentCopies
INTEGER	iLabelSort						// Sortierung der Label, 1=Bereiche 2=Galley
INTEGER	iLabelPageBreak				// Seitenwechsel nach Areawechsel
integer	iPrintFlightLabel		= 1	// Es sollen Fluglabel gedruckt werden
integer	iPrintNewspaperLabel = 0	// Es sollen Zeitungslabel gedruckt werden
integer	iPrintNewspaperReport = 0	// Es soll ein Report gedruckt werden

uo_label_return		uoLabelReturn[] 
uo_label_newspaper	uoNewspaper		// Newspaper Label sollen gedruckt werden
STRING	sLocalPrinters[]
STRING	sLocalBellyPrinters[]
String 	sGeneratedForPrinter[]
Long		lLocalLabelTypes[]

STRING	sRouting

Long		lLayOutKey

// ---------------------------------------
// Passagiere erstes Leg
// ---------------------------------------
integer	iBostaF
integer	iBostaC
integer	iBostaM


// ---------------------------------------
// Die zu generierenden Streams
// ---------------------------------------
BLOB		bPDFStream
BLOB		bLabelStream

// ---------------------------------------
// Verarbeitungvariablen
// ---------------------------------------
STRING	sLLFooter

LONG 		lArgSchema
//BOOLEAN 	bDiagramColor
BOOLEAN	bDiagramDuplex
BOOLEAN	bDiagramPages
BOOLEAN  bDiagramFirstPages
BOOLEAN	bDiagramCollate
BOOLEAN	bDiagramSameFont
BOOLEAN	bPrintAddonReport
BOOLEAN	bPrintBellyReport
BOOLEAN	bSortByClass

STRING	sDiagramDPI
INTEGER	iDiagramExemplare
STRING	sPrinter
STRING	sErrorText

INTEGER	iDiagramCopies
INTEGER	iDiagramDuplex
INTEGER	iDiagramCollate
INTEGER	iDiagramQuality
INTEGER	iDiagramOrientation

// ---------------------------------------
// Report-Title
// ---------------------------------------
STRING	sReportTitle

// ---------------------------------------
// Variable f$$HEX1$$fc00$$ENDHEX$$r die Klassenmarkierung
// ---------------------------------------
BOOLEAN		bClassMark
INTEGER		iClassBrush
LONG			lClassBrushColor

// ---------------------------------------
// drucken wir im Single oder im Multiple-
// Flightmode
// ---------------------------------------
LONG			lFlightsToPrint   = 1
LONG			lActFlightToPrint = 1

// ---------------------------------------
// User spezifische Einstellungen
// ---------------------------------------
STRING	sMandant
STRING	sDATEFormat

// ---------------------------------------
// Der Druckertyp
// ---------------------------------------
INTEGER	iPrinterType				// 1 = Zebra - 2 = other
STRING	sRampBox			= ""
STRING   sKitchenTime	= ""
STRING   sRampTime		= ""


// ---------------------------------------
// 21.08.2002
// Filename - Array f$$HEX1$$fc00$$ENDHEX$$r die Client - App
// ---------------------------------------
Integer 			iFileCounter
string 			sFileNames[]
string			sFileDescriptions[]

string 			sDocumentFileNames[]
string			sDocumentFileDescriptions[]

uo_pdf_handler	uoPDF
STRING			sPDFFileName, &
					sPDFFullFileName

string			sConfiguration		// Sitzplatzversion, die in die Kopfzeile gedruckt werden soll
string			sFromTo				// Information zur Anzeige

Boolean			ib_deliverynotemode = FALSE

Private:
CONSTANT STRING  sOrga = "$$HEX2$$a9002000$$ENDHEX$$2000-2003 FRA ZB 4 IT-Development"
// ---------------------------------------
// die DATEinamen im Filesystem des zu
// erstellenden tempor$$HEX1$$e400$$ENDHEX$$ren PDF-Doks
// wir f$$HEX1$$fc00$$ENDHEX$$r die Generierung und anschie$$HEX1$$df00$$ENDHEX$$endem
// L$$HEX1$$f600$$ENDHEX$$schen ben$$HEX1$$f600$$ENDHEX$$tigt
// ---------------------------------------

// Objekt zur Berechnung von Schriftarten
uo_font_calc iuo_FontCalc				

BOOLEAN		bValidObject = True
INTEGER		iMinFontSize

STRING		sTempPath
STRING		sTempFiles[]				// beinhaltet alle zur Laufzeit erzeugten tempor$$HEX1$$e400$$ENDHEX$$ren Bilder
												// zum Schlu$$HEX2$$df002000$$ENDHEX$$l$$HEX1$$f600$$ENDHEX$$schen

// ---------------------------------------
// Infos f$$HEX1$$fc00$$ENDHEX$$r Extra-Stauort
// ---------------------------------------
BOOLEAN		bPrintFrame
BOOLEAN		bPrintHeader
STRING		sHeadLineExtra, &
				sLinkTextExtra

LONG			lFrameColorExtra

// ---------------------------------------
// Wieviel AddOn-Reports sollen gedruckt 
// werden
// ---------------------------------------
INTEGER	iAnzahlAddonReports = 1												

// ---------------------------------------
// Markierungsfarben
// ---------------------------------------
LONG		lMarkNoCatererActionColor
LONG		lQAQTextColor
LONG		lForToTextColor
LONG		lNoMarkup

String 	sLegendenPicture

integer  iEmptyDiagram
// ---------------------------------------
// Die DataStores
// ---------------------------------------
DataStore ds_print_job
DataStore ds_childstowages
DataStore ds_zustautextetoextrastauort
DataStore ds_belly
DataStore ds_exclude
DataStore ds_classname
DataStore ds_reportnotprinted
DataStore ds_extra
uo_report_dw2inpixel ds_report 
DataStore ds_diagramlayout
DataStore ds_emptybox
DataStore ds_bitmap
DataStore ds_freetext
DataStore ds_schema
DataStore ds_stauorteohneinhalte

DataStore ds_matrix_routingplan
DataStore ds_matrix_routingplan_qaq
DataStore ds_currentleg
DataStore ds_suplementloadingslist	//dw_2
DataStore ds_matrix_qaq_processing

DataStore ds_areas_local
DataStore ds_workstations
DataStore ds_areas_default

DataStore ds_actual_layout
Datastore ds_matrix_newspaper
// ---------------------------------------
// Die Proxy
// ---------------------------------------
n_printer			nPrintPDF
// n_cbase				nCbase
// n_addinfos			nAddInfos

TransactionServer its_jag

// ---------------------------------------
// Das XML Object
// ---------------------------------------
OleObject	oXML
Integer		iXMLStatus
String		sXMLMessage


// ---------------------------------------
// Wie soll gedruckt werden? Farbig (1), 
// Graustufen (2) oder S/W (3)
// ---------------------------------------
Integer	iPrintColor = 1			

// ---------------------------------------
// 21.08.2002
// Von wo wird das Objekt aus instanziiert
// ---------------------------------------
String			sWhereAmI

datastore ds_new_packinglists
date		 dShowAsNew

boolean bPrintContentsReport
integer iContentsDays

boolean bUseCenOut = false				// Schalter: Soll Tagesflugplan oder Matrix benutzt werden?

long	lRoutingplanKey_CP

Integer	iLegs[]
String	is_Leg_Routing_from[]
String	is_Leg_Routing_to[]

long lRoleID = 1000027
end variables

forward prototypes
public function integer uf_getclasscount (integer ipage, ref string sclassname, ref uo_class sclassarray)
public function uo_current_packinglists uf_getpackinglists ()
public function integer uf_clear_all ()
public function integer uf_getmaxpage ()
public function integer uf_createprintjob ()
private function integer uf_setsamefont ()
public function boolean uf_set_page_properties (integer ipage, integer imaxpage)
private function long uf_parse_class (ref string sclassnames[], ref integer iclass_sort[])
private function integer uf_find_first_loading ()
public function boolean uf_exclude (long lrow)
public function s_all_flight_infos uf_get_dblogo (integer ilogo, s_all_flight_infos sinfo)
public function s_all_flight_infos uf_get_loading_data (s_all_flight_infos sinfo)
private subroutine uf_label_check ()
public function string uf_cen_profilestring (string ssection, string skey, string sdefault, string smand)
public function string uf_check_null (string stext)
public function long uf_draw_emptybox (integer ipage)
public function integer uf_set_printer ()
public function boolean uf_isprintpossible ()
public subroutine writelog (string smsg)
public function s_all_flight_infos uf_generate_documents (s_all_flight_infos sinfo)
public function integer uf_fortocode ()
public function integer uf_checkaufleerenstowage (long lrow)
public function boolean uf_no_action (long lrow)
public function integer uf_draw_freetext (integer ipage)
private function integer uf_resetactioncode ()
public function boolean uf_offload (long lrow)
private function integer uf_zustauen (long lrow)
public function long uf_default_color ()
public subroutine uf_setdatabaseinfo (transaction trsqlca)
public subroutine uf_diagram_setup (long lhandle, long llayout_key, string sinvoked)
public function long uf_draw_bitmap (integer ipage)
private function integer uf_calcweight ()
public function long uf_createnewsreport (ref blob bstate, date dcheckdate)
public subroutine uf_add_color_text ()
private function integer uf_qaq_actioncode (integer iworkingleg, long larg_handlingkey)
public function s_all_flight_infos uf_matrix_newspaper (s_all_flight_infos sinfo)
public function s_all_flight_infos uf_get_newspaper_handling_by_id (s_all_flight_infos sinfo, long lhandling_id)
public function s_all_flight_infos uf_get_catobjects (s_all_flight_infos sinfo, ref string scomments[], ref long lobjectkeys[])
public function s_all_flight_infos uf_get_document (s_all_flight_infos sinfo, long linheritcatobject)
public function integer uf_matdispo ()
public function integer uf_reset_for_to_codes ()
public function long uf_delete (datastore dsdeleteon)
public function s_all_flight_infos uf_get_qaq (s_all_flight_infos sinfo, long lhandling_id)
public function s_all_flight_infos uf_check_flightschedule (s_all_flight_infos sinfo)
public function integer uf_retrieveextrastowage ()
private function integer uf_childstowage (long lrow)
public function integer uf_check4documents (s_all_flight_infos sinfo)
public function long uf_get_cp_key (s_all_flight_infos sinfo)
public function s_all_flight_infos uf_check_routingplan (s_all_flight_infos sinfo)
public function integer uf_add_areas (datetime dtdeparture)
public function integer uf_add_workstations (datetime dtdeparture)
public function integer uf_save_results ()
public function integer uf_save_results_master ()
public function s_all_flight_infos uf_generate_data (s_all_flight_infos sinfo)
public function s_all_flight_infos uf_matrix (s_all_flight_infos sinfo)
public function s_all_flight_infos uf_get_handling_by_id (s_all_flight_infos sinfo, long lhandling_id)
private function integer uf_setschema (long lrow)
public function long uf_draw_stowage (integer ipage, string sclass)
public function s_all_flight_infos uf_print_label (s_all_flight_infos sinfo)
public function s_all_flight_infos uf_generate_label (s_all_flight_infos sinfo)
public function integer uf_draw_extrastowage (integer ipage)
public function integer uf_print ()
public function long uf_createaddonreport (ref blob bstate)
public function long uf_createbellyreport (ref blob bdsstate)
public function uo_loading uf_generate_loading (ref s_all_flight_infos sinfo)
public function long uf_retrieve ()
public function s_all_flight_infos uf_generate_information (s_all_flight_infos sinfo)
public function s_all_flight_infos uf_generate_diagram (s_all_flight_infos sinfo)
public function boolean uf_actioncode ()
public function string uf_get_configuration (long arg_aircraft_key)
public function integer uf_loadinglist_exclusion ()
public function integer of_legs ()
end prototypes

public function integer uf_getclasscount (integer ipage, ref string sclassname, ref uo_class sclassarray);// ----------------------------------
// Diese Funktion ermittelt die max.
// Anzahl an Klassen und gibt den
// zusammengesetzten Klassennamen
// als Referenz zur$$HEX1$$fc00$$ENDHEX$$ck
// ----------------------------------
Long		lRow, &
			lNext

String	sAllShortClasss[], &
			sAllClasss[], &
			sSearchArg, &
			sClass[]

Integer	iClassFound[], &
			iMaxClass, &
			i, j, &
			iClassReturn, &
			iClassSort[]

For lRow = 1 To ds_classname.RowCount()
	sAllShortClasss[lRow] 	= ds_classname.GetItemString(lRow, "cclass")
	sAllClasss[lRow]			= ds_classname.GetItemString(lRow, "cclass_name")
	iClassSort[lRow]			= ds_classname.GetItemNumber(lRow, "nclass_number")
	iClassFound[lRow]			= 0
Next

// ----------------------------------------------
// Alle Klassen durchlaufen und parsen.
// ----------------------------------------------
sSearchArg 	= "cen_stowage_npage = " + String(iPage) + " AND cen_loadinglists_cclass <> ''"
lNext			= 1

Do While lNext > 0
	lNext = ds_loadinglist.Find(sSearchArg, lNext, ds_loadinglist.RowCount())
	iMaxClass ++
	if lNext > 0 Then
		sClass[iMaxClass] = ds_loadinglist.GetItemString(lNext, "cen_loadinglists_cclass")
		sSearchArg = sSearchArg + " AND cen_loadinglists_cclass <> '" + sClass[iMaxClass] + "'"
		lNext ++
	end if
	
	if lNext > ds_loadinglist.RowCount() Then
		lNext = 0
	end if
Loop

// --------------------------------------------------------------------------------------------
// So wir haben nun alle Klassen im Array. Dieses
// durchlaufen wir und checken es gegen die vor-
// handenen KLassen (parsen).
// Haben wir bereist die Klasse, so $$HEX1$$fc00$$ENDHEX$$bernehmen
// wir sie nicht erneut.
// so wird z.B. wird aus der Klasse FCM => First / Business / Echo
// das gleiche Ergebnis erzielen wir mit drei verschiedenen Klassen F, C, und M
//
// die $$HEX1$$e400$$ENDHEX$$ussere Schleife bestimmt die Reihenfolge (dw sort nach ClassNumber)
// --------------------------------------------------------------------------------------------
iClassReturn = 0
For j = 1 To UpperBound(sAllClasss[])
	For i = 1 To UpperBound(sClass[])
		if Match (sClass[i], sAllShortClasss[j]) AND iClassFound[j] = 0 Then
			iClassFound[j]	= 1
			sclassname 	 = sclassname + " / " + sAllClasss[j]	
			iClassReturn ++
			sClassArray.sLongClass[iClassReturn]  = sAllClasss[j] + " Class"
			sClassArray.sShortClass[iClassReturn] = sAllShortClasss[j]
			sClassArray.iClassSort[iClassReturn]  = iClassSort[j]
		end if
	next
Next	

// ----------------------------------------------
// noch etwas aufr$$HEX1$$e400$$ENDHEX$$umen
// ----------------------------------------------
sclassname = Trim(sclassname)
if Left(sclassname, 1) = "/" Then
	sclassname = Right(sclassname, Len(sclassname) - 1)
end if
if Right(sclassname, 1) = "/" Then
	sclassname = Left(sclassname, Len(sclassname) - 1)
end if
// ----------------------------------------------
// nur wenn $$HEX1$$fc00$$ENDHEX$$berhaupt eine Klasse vorhanden ist,
// f$$HEX1$$fc00$$ENDHEX$$gen wir das Wort Class an
// ----------------------------------------------
if Len(sclassname) > 0 Then
	sClassName += " Class"
end if

// ------------------------------------------------------
// Ups, da wurde keine Klasse in der Galley definiert.
// z.B. LH 560 Galley S11 nur K-Klasse 
// (K ist nicht in Airline Classes definiert) !
// ------------------------------------------------------
	If iClassReturn = 0 Then
		iClassReturn = 1
		sClassArray.sLongClass[iClassReturn]  = " "
		sClassArray.sShortClass[iClassReturn] = " "
		sClassArray.iClassSort[iClassReturn]  = 0
	End if	

return iClassReturn
end function

public function uo_current_packinglists uf_getpackinglists ();Long							lRow, &
								lArrayCnt

Long							lPL
String						sPL
Boolean						bIsNew
uo_current_packinglists	uoPLs


uoPLs = CREATE uo_current_packinglists
		
For lRow = 1 To ds_loadinglist.RowCount()
	
	bIsNew = True
	lPL = ds_loadinglist.GetItemNumber(lRow, "cen_packinglist_index_npackinglist_index_key")
	sPL = ds_loadinglist.GetItemString(lRow, "cen_packinglist_index_cpackinglist")
	
	if UpperBound(uoPLs.lPLKey[]) = 0 Then
		uoPLs.lPLKey[1] 	= lPL
		uoPLs.sPL[1] 		= sPL
	else
		For lArrayCnt = 1 To UpperBound(uoPLs.lPLKey[])
			if uoPLs.lPLKey[lArrayCnt] = lPL Then
				bIsNew = False
				exit
			end if
		Next
		
		if bIsNew Then
			uoPLs.lPLKey[UpperBound(uoPLs.lPLKey[]) + 1] 	= lPL
			uoPLs.sPL[UpperBound(uoPLs.lPLKey[])] 				= sPL
		end if
	end if
Next


uoPLs.lAnzahl = UpperBound(uoPLs.lPLKey[])

return uoPLs
end function

public function integer uf_clear_all ();// --------------------------------------
// diese Funktion wird abschlie$$HEX1$$df00$$ENDHEX$$end 
// aufgerufen. Sie r$$HEX1$$e400$$ENDHEX$$umt alles auf
//
// l$$HEX1$$f600$$ENDHEX$$scht tempor$$HEX1$$e400$$ENDHEX$$re Dateien
// --------------------------------------
Integer i

// ---------------------------------------------
// Wir haben tempor$$HEX1$$e400$$ENDHEX$$re Dateien erzeugt
// Aufr$$HEX1$$e400$$ENDHEX$$umen
// ---------------------------------------------
	For i = 1 to UpperBound(sTempFiles[])
		If FileExists(sTempFiles[i]) Then
			FileDelete(sTempFiles[i])
		end if
	next

return 1

end function

public function integer uf_getmaxpage ();// ----------------------------------
// Diese Funktion ermittelt die max
// Seite
// ----------------------------------
Integer		iMaxPage
Long		 	lRow, &
				lNext

iMaxPage = 1
lNext 	= 1

// -----------------------------------
// h$$HEX1$$f600$$ENDHEX$$chste Seitenzahl in Stauorten
// -----------------------------------
Do While lNext > 0
	lNext 	= ds_loadinglist.Find("cen_stowage_npage>" + String(iMaxPage), lNext, ds_loadinglist.RowCount())
	
	if lNext > 0 Then
		iMaxPage = ds_loadinglist.GetItemNumber(lNext, "cen_stowage_npage")
		lNext ++
	end if
	
	if lNext > ds_loadinglist.RowCount() Then
		lNext = 0
	end if
Loop

// -----------------------------------
// h$$HEX1$$f600$$ENDHEX$$chste Seitenzahl in Bitmaps
// -----------------------------------
lNext 	= 1
Do While lNext > 0
	lNext 	= ds_bitmap.Find("npage>" + String(iMaxPage), lNext, ds_bitmap.RowCount())
	
	if lNext > 0 Then
		iMaxPage = ds_bitmap.GetItemNumber(lNext, "npage")
		lNext ++
	end if
	
	if lNext > ds_bitmap.RowCount() Then
		lNext = 0
	end if
Loop

// -----------------------------------
// h$$HEX1$$f600$$ENDHEX$$chste Seitenzahl in Freitexten
// -----------------------------------
lNext 	= 1
Do While lNext > 0
	lNext 	= ds_freetext.Find("npage>" + String(iMaxPage), lNext, ds_freetext.RowCount())
	
	if lNext > 0 Then
		iMaxPage = ds_freetext.GetItemNumber(lNext, "npage")
		lNext ++
	end if
	
	if lNext > ds_freetext.RowCount() Then
		lNext = 0
	end if
Loop

// -----------------------------------
// h$$HEX1$$f600$$ENDHEX$$chste Seitenzahl in Empty Boxen
// -----------------------------------
lNext 	= 1
Do While lNext > 0
	lNext 	= ds_emptybox.Find("npage>" + String(iMaxPage), lNext, ds_emptybox.RowCount())
	
	if lNext > 0 Then
		iMaxPage = ds_emptybox.GetItemNumber(lNext, "npage")
		lNext ++
	end if
	
	if lNext > ds_emptybox.RowCount() Then

		lNext = 0
	end if
Loop

// --------------------------------------
// h$$HEX1$$f600$$ENDHEX$$chste Seitenzahl in Extra-Stauorten
// --------------------------------------
lNext 	= 1
Do While lNext > 0
	lNext 	= ds_extra.Find("cen_diagram_extra_npage>" + String(iMaxPage), lNext, ds_extra.RowCount())
	
	if lNext > 0 Then
		iMaxPage = ds_extra.GetItemNumber(lNext, "npage")
		lNext ++
	end if
	
	if lNext > ds_extra.RowCount() Then
		lNext = 0
	end if
Loop




return iMaxPage

end function

public function integer uf_createprintjob ();// ------------------------------------------
// diese Funktion erstellt einen Printjob
// ------------------------------------------

Integer		iPage, &
				iAnzKlassen, &
				iClassCnt, &
				iMaxClass, &
				iBufferClass = 0, &
				iBufferPrevClass = 0, &
				iClassSort[], &
				iSort
			
Long			lRow, &
				l = 0

String		sLargeClassName, &
				sLongClass[]

uo_class		uoClass

ds_print_job.Reset()

// ---------------------------
// wir merken uns wieviel max.
// Klassen wir $$HEX1$$fc00$$ENDHEX$$ber alle
// Seiten haben, dies brauchen
// wir f$$HEX1$$fc00$$ENDHEX$$r die Seitenduplizierung
// von Seiten ohne Klassen 
// (Deckblatt)
// ---------------------------
if bdiagrampages AND bdiagramfirstpages Then
	// ------------------------
	// die Anzahl der zu 
	// druckenden AddOn-Reports 
	// festlegen
	// ------------------------
	iMaxClass = uf_parse_class(sLongClass[], iClassSort[])
	iAnzahlAddonReports = iMaxClass
end if

For iPage = 1 to uf_GetMaxPage()
	
	uoClass = Create uo_class
	sLargeClassName = ""
	iAnzKlassen = uf_GetClassCount(iPage, sLargeClassName, uoClass)
	
	if bDiagramPages And iAnzKlassen > 0 Then
		For iClassCnt = 1 To iAnzKlassen
			lRow = ds_print_job.InsertRow(0)
			ds_print_job.SetItem(lRow, "iPage", iPage)
			ds_print_job.SetItem(lRow, "sclasslong",  uoClass.sLongClass[iClassCnt])
			ds_print_job.SetItem(lRow, "sclassshort", uoClass.sShortClass[iClassCnt])
			ds_print_job.SetItem(lRow, "iclasssort",  uoClass.iClassSort[iClassCnt])
		next
	else
		lRow = ds_print_job.InsertRow(0)
		ds_print_job.SetItem(lRow, "iPage", iPage)
		ds_print_job.SetItem(lRow, "sclasslong",  sLargeClassName)
		ds_print_job.SetItem(lRow, "sclassshort", "")
		ds_print_job.SetItem(lRow, "iclasssort",  iBufferClass)
	end if
	
	Destroy uoClass
Next


// die Deckbl$$HEX1$$e400$$ENDHEX$$tter
if bSortByClass Then
	ds_print_job.SetSort("iclasssort A, iPage A")			// nach Klasse
	ds_print_job.Sort()
	// ------------------------
	// soll die erste Dupliziert
	// werden?
	// ------------------------
	if bdiagrampages AND bdiagramfirstpages Then
		// ------------------------
		// alle Zeilen Durchlaufen
		// und checken wo ein
		// Klassenwechsel statt-
		// findet
		// ------------------------
		For lRow = 1 To ds_print_job.RowCount()
			
			iBufferClass 		= ds_print_job.GetItemNumber(lRow, "iclasssort")
			sLargeClassName	= ds_print_job.GetItemString(lRow, "sclasslong")
			
			if iBufferClass <> iBufferPrevClass Then
				
				// ------------------------------------------------
				// falls iBufferPrevClass = 0 nichts machen
				// dann ist dies die erste Seite nach dem Deckblatt
				// ------------------------------------------------
				if iBufferPrevClass > 0 Then
					l = ds_print_job.InsertRow(lRow)
					ds_print_job.SetItem(l, "iPage", 1)
					ds_print_job.SetItem(l, "sclasslong", sLargeClassName)
					ds_print_job.SetItem(l, "sclassshort", "")
					ds_print_job.SetItem(l, "iclasssort", 0)
				else
					ds_print_job.SetItem(1, "sclasslong", sLargeClassName)	// kann nur erste Zeile sein
				end if
				
				iBufferPrevClass = iBufferClass
			end if
		Next
	end if
else
	// ------------------------
	// soll die erste Dupliziert
	// werden?
	// ------------------------
	if bdiagrampages AND bdiagramfirstpages Then
		for lRow = 1 To (iMaxClass)	
			if lRow = 1 Then
				// -----------------------------------------------
				// die erste Zeile ist hier immer das Deckblatt
				// einmal haben wir die erste Seite ja eh immer
				// -----------------------------------------------
				if UpperBound(sLongClass[]) >= lRow AND &
					UpperBound(iClassSort[]) >= lRow Then
					sLargeClassName = sLongClass[lRow]
					iSort				 = iClassSort[lRow]
				else
					sLargeClassName = ""
					iSort				 = 0
				end if
				
				ds_print_job.SetItem(1, "sclasslong", sLargeClassName)
				ds_print_job.SetItem(l, "iclasssort", iSort)
				
			else
				if UpperBound(sLongClass[]) >= lRow AND &
					UpperBound(iClassSort[]) >= lRow Then
					sLargeClassName = sLongClass[lRow]
					iSort				 = iClassSort[lRow]
				else
					sLargeClassName = ""
					iSort				 = 0
				end if
				
				l = ds_print_job.InsertRow(0)
				ds_print_job.SetItem(l, "iPage", 1)
				ds_print_job.SetItem(l, "sclasslong",sLargeClassName)
				ds_print_job.SetItem(l, "sclassshort", "")
				ds_print_job.SetItem(l, "iclasssort", iSort)
			end if
		Next
	end if
	// ------------------------
	// sortieren
	// ------------------------
	ds_print_job.SetSort("iPage A, iclasssort A")			// nach Seite
	ds_print_job.Sort()
	
end if

//ds_print_job.saveas("d:\ds_print_job.xls", Excel5!, TRUE)

return 1
end function

private function integer uf_setsamefont ();// ----------------------------------
// Diese Funktion ermittelt die 
// kleinste FontSize pro Seite und 
// aktualisiert gleich alle mit
// ----------------------------------
Integer		iPage, &
				iFontSize, &
				iFontHeight
				
Long		 	lRow, &
				lNext, &
				lNextSet, &
				lNextExtra, &
				lNextExtraSet, &
				lGalleyKey
				
For iPage = 1 to uf_getmaxpage()
	lNext 		= 1
	iFontSize	= 9999
	Do While lNext > 0
		lNext 	= ds_loadinglist.Find("cen_stowage_npage=" + String(iPage) + " AND compute_usefontsize<" + String(iFontSize), lNext, ds_loadinglist.RowCount())
		
		if lNext > 0 Then
			iFontSize  	= ds_loadinglist.GetItemNumber(lNext, "compute_usefontsize")
			iFontHeight	= ds_loadinglist.GetItemNumber(lNext, "compute_fontheight")

			lNext ++
		end if
		
		if lNext > ds_loadinglist.RowCount() Or lNext = 0 Then
			lNext = 0
			if iFontSize < 9999 Then
				
				// ----------------------------
				// Aktualisieren
				// ----------------------------
				lNextSet = 1
				Do While lNextSet > 0
					lNextSet 	= ds_loadinglist.Find("cen_stowage_npage=" + String(iPage)+ " AND compute_usefontsize>" + String(iFontSize), lNextSet, ds_loadinglist.RowCount())
					if lNextSet > 0 Then
						ds_loadinglist.SetItem(lNextSet, "compute_usefontsize", iFontSize)
						ds_loadinglist.SetItem(lNextSet, "compute_fontheight", iFontHeight)
						lNextSet ++
					end if
					
					if lNextSet > ds_loadinglist.RowCount() Then
						lNextSet= 0
					end if
				Loop
				// ----------------------------
				// Die Extra-Stauorte
				// ----------------------------
				lNextExtra = 1
				Do While lNextExtra > 0
					lNextExtra 	= ds_extra.Find("cen_diagram_extra_npage=" + String(iPage), lNextExtra, ds_extra.RowCount())
								
					if lNextExtra > 0 Then
						
						lGalleyKey		= ds_extra.GetItemNumber(lNextExtra, "cen_diagram_extra_ngalley_key")
						lNextExtraSet 	= 1
						Do While lNextExtraSet > 0
							lNextExtraSet = ds_loadinglist.Find("cen_galley_ngalley_key=" + String(lGalleyKey) + &
															  " AND cen_stowage_npage=0", lNextExtraSet, ds_loadinglist.RowCount())
							
							if lNextExtraSet > 0 Then
								ds_loadinglist.SetItem(lNextExtraSet, "compute_usefontsize", iFontSize)
								ds_loadinglist.SetItem(lNextExtraSet, "compute_fontheight", iFontHeight)
								lNextExtraSet ++
							end if
							
							if lNextExtraSet > ds_loadinglist.RowCount()  Then 
								lNextExtraSet = 0
							end if
						Loop
						lNextExtra ++
					end if
					if lNextExtra > ds_extra.RowCount() Then 
						lNextExtra= 0
					end if
				Loop
				// ----------------------------
				// Die Stauorte ohne Inhalte
				// ----------------------------
				lNextSet = 1
				Do While lNextSet > 0
					lNextSet 	= ds_stauorteohneinhalte.Find("cen_stowage_npage=" + String(iPage)+ " AND compute_usefontsize>" + String(iFontSize), lNextSet, ds_stauorteohneinhalte.RowCount())

					if lNextSet > 0 Then
						ds_stauorteohneinhalte.SetItem(lNextSet, "compute_usefontsize", iFontSize)
						ds_stauorteohneinhalte.SetItem(lNextSet, "compute_fontheight", iFontHeight)
						lNextSet ++
					end if
					
					if lNextSet > ds_stauorteohneinhalte.RowCount() Then
						lNextSet= 0
					end if
				Loop
			end if
		end if
	Loop
Next

return 1

end function

public function boolean uf_set_page_properties (integer ipage, integer imaxpage);	
// ------------------------------------------
// Die Uhrzeitund das Datum
// -------------------------------------------
	ds_report.Object.time_t.text = string(Today(), sDateFormat) + "   " + string(now(), "HH:MM")
	
	
	Return True


end function

private function long uf_parse_class (ref string sclassnames[], ref integer iclass_sort[]);// ----------------------------------------------------
// Diese Funktion ermittelt die Anzahl der Klassen
// $$HEX1$$fc00$$ENDHEX$$ber alle Seiten und gibt die Anzahl zur$$HEX1$$fc00$$ENDHEX$$ck.
// Die Funktion uf_GetClassCount() hingegen ermittelt
// die Anzahl von Klassen auf einer speziellen Seite
// ----------------------------------------------------

Long		lRow, &
			l
Integer	iAnzahlClasses = 0, &
			i, j, &
			iClassSort[], &
			iSort, &
			iBuffer

String	sShortClass, &
			sShortClassDef, &
			sLongClassDef, &
			sClasses[], &
			sLongClassNames[], &
			sBuffer
			
Boolean	sClassExists
			
// ----------------------------------------------
// alle KLassen durchlaufen und parsen.
// z.B. wird aus FCM => First / Business / Echo
// ----------------------------------------------

For lRow = 1 To ds_loadinglist.RowCount()
	sShortClass = ds_loadinglist.GetItemString(lRow, "cen_loadinglists_cclass")
	sClassExists = False

	For l = 1 To ds_classname.RowCount()
		sShortClassDef = ds_classname.GetItemString(l, "cclass")
		sLongClassDef	= ds_classname.GetItemString(l, "cclass_name")
		iSort				= ds_classname.GetItemNumber(l, "nclass_number")
	
		If Match(sShortClass, sShortClassDef) Then
			if UpperBound(sClasses[]) = 0 Then
				iAnzahlClasses ++
				sClasses[iAnzahlClasses] 			= sShortClassDef
				sLongClassNames[iAnzahlClasses]	= sLongClassDef
				iClassSort[iAnzahlClasses]			= iSort
			else
				for i = 1 to UpperBound(sClasses[])
					if Match(sShortClass, sClasses[i]) Then 
						sClassExists = True
						exit
					end if
				Next
				if Not sClassExists Then
					iAnzahlClasses ++
					sClasses[iAnzahlClasses] 			= sShortClassDef
					sLongClassNames[iAnzahlClasses]	= sLongClassDef
					iClassSort[iAnzahlClasses]			= iSort
				end if
			end if
			exit
		end if
	Next
Next		

// -------------------------------------
// nun noch das Class-Array sortieren
// -------------------------------------
if UpperBound(iClassSort[]) > 0 Then
	For i = 1 to UpperBound(iClassSort[])
		For j = UpperBound(iClassSort[]) To 2 Step - 1
			if iClassSort[j - 1] > iClassSort[i] Then
				sBuffer						= sLongClassNames[j - 1]
				sLongClassNames[j - 1]	= sLongClassNames[j]
				sLongClassNames[j]		= sBuffer
				
				iBuffer						= iClassSort[j - 1]
				iClassSort[j - 1]			= iClassSort[j]
				iClassSort[j]				= iBuffer
				
			end if
		next
	next
	For i = 1 to UpperBound(sLongClassNames[])
		sclassnames[i] = sLongClassNames[i]
		iClass_Sort[i] = iClassSort[i]
	next
	
end if
return iAnzahlClasses






end function

private function integer uf_find_first_loading ();// ------------------------------------------------------------------------------------------
//	Diese Funktion findet die erste Grundbeladung in der Matrix. Es ist egal in welchem /
//	Leg die Grundbaldung vorgenommen wurde. Ausgehend von der letzen Zeile nach oben
//	wandert wird die erste Grundbeladung gefunden. Gleichzeitig werden alle Zeile 
//	bis zur ersten Grundbeladung von oben her gel$$HEX1$$f600$$ENDHEX$$scht.
//	
//	Der R$$HEX1$$fc00$$ENDHEX$$ckgabewert
//	0 	= ok
//	-1 = Fehler (keine Grundbeladung)
// ------------------------------------------------------------------------------------------
	Long		lRow, &
				lFoundRow = 0
			
	Integer	iLeg, &
				iFoundLeg, &
				iTyp

// -------------------------------------------------
// erst mal alle Rows l$$HEX1$$f600$$ENDHEX$$schen
// welche > dem aktuellen Leg sind
// -------------------------------------------------
	For lRow = ds_matrix.RowCount() To 1 Step -1
		iLeg = ds_matrix.getItemNumber(lRow, "nleg")
		
		if iLeg > iActLeg Then
			ds_matrix.DeleteRow(lRow)				
		end if
	Next

// -------------------------------------------------
// die 1. Grundbeladung suchen
// -------------------------------------------------
	For lRow = ds_matrix.RowCount() To 1 Step -1
		iLeg = ds_matrix.getItemNumber(lRow, "nleg")
		iTyp = ds_matrix.getItemNumber(lRow, "ntyp")
		
		if iTyp = 1 Then
			lFoundRow = lRow
			iFoundLeg = iLeg
			exit
		end if
	Next

// -------------------------------------------------
// bis zur 1. Grundbeladung alles weg
// -------------------------------------------------
	For lRow = 1 To lFoundRow
		iLeg = ds_matrix.getItemNumber(1, "nleg")
		
		if iLeg < iFoundLeg Then
			ds_matrix.deleteRow(1)			
		end if
	Next
	
	if lFoundRow = 0 Then
		return -1
	else
		return 0
	end if

end function

public function boolean uf_exclude (long lrow);	long 		lActionRow
	string	sGalley,sStowage
// ------------------------------------------------------------------------------
// $$HEX2$$81002000$$ENDHEX$$Es werden Datens$$HEX1$$e400$$ENDHEX$$tze gesucht die in Galley und Stowage $$HEX1$$fc00$$ENDHEX$$bereinstimmen.
// $$HEX2$$81002000$$ENDHEX$$Sofern der Satz gefunden wird wird im Feld Compute Exclude der Status 1 eingetragen.
// ------------------------------------------------------------------------------
	lActionRow 	= 1
	sGalley		= ds_loadinglist.Getitemstring(lRow,"cen_galley_cgalley")
	sStowage		= ds_loadinglist.Getitemstring(lRow,"cen_stowage_cstowage")
		
	lActionRow = ds_exclude.Find("cgalley = '" + sGalley + "' and " + &
						 "cstowage = '" + sStowage + "'",1,ds_exclude.RowCount()) 

	If lActionRow > 0	Then
		Return True
	Else 
		Return False
	End if
	
end function

public function s_all_flight_infos uf_get_dblogo (integer ilogo, s_all_flight_infos sinfo);select ccolor_logo,cblack_logo 
 into :sInfo.slogo_color,:sInfo.slogo_black
 from sys_logos
where nlogo_key = :ilogo using sqlca;

If sqlca.sqlcode <> 0 Then
	sInfo.slogo_color = ""
	sInfo.slogo_black = ""
	slogo_color			= sInfo.slogo_color
	sLogo_black			= sInfo.slogo_black
Else
	sInfo.slogo_color = sinfo.slogo_path + "\" + sInfo.slogo_color
	sInfo.slogo_black = sinfo.slogo_path + "\" + sInfo.slogo_black
	slogo_color			= sInfo.slogo_color
	sLogo_black			= sInfo.slogo_black
End if

	
return sInfo
end function

public function s_all_flight_infos uf_get_loading_data (s_all_flight_infos sinfo);Long		lRow
String	sTemp
Integer	iLeg, iLegPrev

// ----------------------------------------
// Vorinitialisieren
// ----------------------------------------
bPDFStream			= BLOB("")
bLabelStream		= BLOB("")
sLLFooter			= ""

// ----------------------------------------
// Wir erstellen die Beladematrix
// ----------------------------------------
	sInfo = uf_matrix(sInfo)
	if sInfo.iStatus = -1 Then
		return sInfo
	end if

// ----------------------------------------
// Wir Retrieven
// ----------------------------------------
	if uf_retrieve() = -1 Then
		sInfo.sStatus = sErrortext
		sInfo.iStatus = -1
		return sInfo
	end if

// ----------------------------------------
// ds_loadinglist in den Blob schreiben
// ----------------------------------------
lRow = ds_loadinglist.GetFullState(sInfo.bStream)
if lRow < 0 then
	sInfo.sStatus = "Error GetFullState"
	sInfo.iStatus = -1
	return sInfo
end if

sInfo.iStatus = 0
return sInfo

end function

private subroutine uf_label_check ();// -----------------------------------
// Soll das Label gedruckt werden ?
// -----------------------------------
	Long		i,lRow
	Long		lCounter = 0
	String	sBuffer
	boolean	bSI_QAQ	= False
	boolean	bZBL		= False
	boolean	bSSL		= False
	
	For i= 1 to ds_matrix.RowCount()
// ----------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob eine SI-QAQ Beladung f$$HEX1$$fc00$$ENDHEX$$r dieses Leg vorliegt
// ----------------------------------------------------------		
		if ds_matrix.GetItemNumber(i, "ntyp") = 3 and &
		   ds_matrix.GetItemNumber(i, "nleg") = iactleg Then
			bSI_QAQ = True
		end if
// ----------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob eine ZBL Beladung f$$HEX1$$fc00$$ENDHEX$$r dieses Leg vorliegt
// ----------------------------------------------------------		
		if ds_matrix.GetItemNumber(i, "ntyp") = 2 and &
		   ds_matrix.GetItemNumber(i, "nleg") = iactleg Then
			bZBL = True
		end if
// ----------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob eine SSL Beladung f$$HEX1$$fc00$$ENDHEX$$r dieses Leg vorliegt
// ----------------------------------------------------------		
		if ds_matrix.GetItemNumber(i, "ntyp") = 1 and &
		   ds_matrix.GetItemNumber(i, "nleg") = iactleg Then
			bSSL = True
		end if		
	Next
	

	
// ----------------------------------------------------------
// nur SSL alle Label werden gedruckt.
// ----------------------------------------------------------
	If bSSL = True and bSI_QAQ = False Then
		For i = 1 To ds_loadinglist.RowCount()
		 	 ds_loadinglist.SetItem(i, "compute_labelprinting",1) 
		Next
		Return
	End if	
// ----------------------------------------------------------
// SSL und SI-QAQ ,nur die einen SI-QAQ Code haben.
// ----------------------------------------------------------
	If bSSL = True and bSI_QAQ = True Then
		For i = 1 To ds_loadinglist.RowCount()
			 sBuffer = ds_loadinglist.GetItemString(i, "compute_sicodes")
			 If isnull(sBuffer) or len(trim(sBuffer)) <= 0 Then
				 ds_loadinglist.SetItem(i, "compute_labelprinting",0)
			 Else
				 ds_loadinglist.SetItem(i, "compute_labelprinting",1)
			 End if	 
		Next
		return
	End if	
// ----------------------------------------------------------
// keine SSL und SI-QAQ ,nur die einen SI-QAQ Code haben.
// ----------------------------------------------------------
	If bSSL = False and bSI_QAQ = True Then
		For i = 1 To ds_loadinglist.RowCount()
			 sBuffer = ds_loadinglist.GetItemString(i, "compute_sicodes")
			 If isnull(sBuffer) or len(trim(sBuffer)) <= 0 Then
				 ds_loadinglist.SetItem(i, "compute_labelprinting",0)
			 Else
				 ds_loadinglist.SetItem(i, "compute_labelprinting",1)
			 End if	 
		Next
		return
	End if
// ----------------------------------------------------------
// keine SSL keine SI-QAQ und nur ZBL ,nur die der ZBL.
// ----------------------------------------------------------
	If bSSL = False and bSI_QAQ = False and bZBL = True Then
		For i = 1 To ds_loadinglist.RowCount()
			 sBuffer = ds_loadinglist.GetItemString(i,"cen_loadinglist_index_cloadinglist")
			 lRow = ds_matrix.find("nleg = " + string(iactleg) + &
			 							  " and ssl_zbl_qaq = '" + sBuffer + "'",1,ds_matrix.Rowcount())
			 If lRow <= 0 Then
				 ds_loadinglist.SetItem(i, "compute_labelprinting",0)
			 Else
				 ds_loadinglist.SetItem(i, "compute_labelprinting",1)
			 End if	 
		Next
		return
	End if		
	
	
	return



end subroutine

public function string uf_cen_profilestring (string ssection, string skey, string sdefault, string smand);string	sValue

Select 	cValue 
into 		:sValue 
from		cen_setup
where		cclient		= :smandant  	and
			cSection		= :sSection				and
			cKey			= :sKey;
			
			
If SQLCA.SQLCode = 100 Then
	sValue = sDefault
	INSERT INTO cen_setup  
          (cclient,   
          csection,   
          ckey,   
          cvalue )
   VALUES (:smandant,   
          :sSection,   
          :sKey,   
          :sDefault)  ;
	f_check_sql(sqlca,"Insert into cen_setup","Insert")
End if


return sValue
end function

public function string uf_check_null (string stext);
if isnull(sText) then
	sText = ""
end if

return sText
end function

public function long uf_draw_emptybox (integer ipage);	//	-----------------------------------------------------------------------------------------------------
	//		 diese Funktion zeichnet ein Quadrat in das Datawindow ds_report
	//	
	//			Argumente:
	//							iPage		= zu verarbeitende Seite im Datawindow ds_freetext
	//	----------------------------------------------------------------------------------------------------- 


	// ---------------------------
	// Druck-relevante Variable
	// ---------------------------
	Integer		iStartX, &
					iStartY, &
					iHeight, &
					iWidth, &
					iBold, &
					iItalic, &
					iAlign
					
	Long			lBackColor
	
	// ---------------------------
	// Verarbeitungs-Variable
	// ---------------------------
	String		sCreate, &
					sObjectName, &
					sResult
	
	Integer		iFontSize, &
					iLeftMargin
					
	Long			lRow, &
					lRet
	
	// ---------------------------
	// Init
	// ---------------------------
	iLeftMargin		= Integer(ds_report.Describe("DataWindow.Print.Margin.Left"))
	
	// ---------------------------
	// Die Werte der zu verarbeiten-
	// den Zeile lesen
	// ---------------------------
	
	For lRow = 1 To ds_emptybox.RowCount()
		if ds_emptybox.GetItemNumber(lRow, "npage") = iPage Then
			
			iStartX 		= ds_emptybox.GetItemNumber(lRow, "nxpos") 
			iStartY 		= ds_emptybox.GetItemNumber(lRow, "nypos") 
			iHeight 		= ds_emptybox.GetItemNumber(lRow, "nheight") 
			iWidth 		= ds_emptybox.GetItemNumber(lRow, "nwidth") 
			iBold 		= ds_emptybox.GetItemNumber(lRow, "nfontbold") 
			iAlign		= ds_emptybox.GetItemNumber(lRow, "ntextalign") 
			lBackColor	= ds_emptybox.GetItemNumber(lRow, "nobjectbackgroundcolor") 
			
			// --------------------
			// Nicht Farbig ?
			// --------------------
			if iPrintColor = 2 then
				// --------------------
				// Graustufen
				// --------------------
				lBackColor = f_RGBToGreyScale(lBackColor)
			elseif iPrintColor = 3 then
				// --------------------
				// S/W
				// --------------------
				lBackColor 	= 16777215		// Hintergrund wei$$HEX1$$df00$$ENDHEX$$
			end if
			
			if iBold = 1 Then
				iBold = 700
			else
				iBold = 400
			end if
		
			sObjectName = "emptybox_" + String(lRow)
			sCreate 			= "create rectangle("  																	+  &
										 "band=Detail "  																	+  &
										 "pointer='Arrow!' "  															+  &
										 "moveable=0 "  																	+  &
										 "resizeable=0 "  																+  &
										 "x='" 						+ String(iStartX) 					+ "' "	+  &
										 "y='" 						+ String(iStartY) 					+ "' "	+  &
										 "height='" 				+ String(iHeight)	 					+ "' "  	+  &
										 "width='" 					+ String(iWidth)						+ "' "  	+  &
										 "name=" 					+ sObjectName 							+ " "		+  & 
										 "tag='" 					+ sObjectName			 				+ "' "	+  &
										 "brush.hatch='6' "  															+  &
										 "brush.color='" 			+ String(lBackColor) 				+ "' "	+  &
										 "pen.style='0' "  																+  & 
										 "pen.width='1' "																	+  & 
										 "pen.color='0' "  																+  & 
										 "background.mode='1' "  														+  & 
										 "background.color='" 	+ String(lBackColor) 				+ "')"
										 
										 
			if Len(trim(ds_report.Modify(sCreate))) > 0 Then
				lRet --
			end if
		end if
		//f_yield(lRoleID)			
	Next
	
	
	return lRet

end function

public function integer uf_set_printer ();if f_set_printer(this.sPrinter) = 0 then
	OutputDebugStringA("Printer is set to: " + this.sPrinter  + "~r~n")
	return 0
else
	OutputDebugStringA("Could not set Printer: " + this.sPrinter  + "~r~n")
	return -1
end if
end function

public function boolean uf_isprintpossible ();Boolean		sRet = TRue

if ds_loadinglist.Find("cen_stowage_npage > 0", 1, ds_loadinglist.RowCount()) = 0 Then
	sErrorText = "No information for generating galley-diagram available" 
	sRet = False
end if



return sRet 









end function

public subroutine writelog (string smsg);
//IF isValid(nCbase) THEN
//	nCbase.writelog(sMsg)
//END IF
end subroutine

public function s_all_flight_infos uf_generate_documents (s_all_flight_infos sinfo);s_all_flight_infos		strTemp

long 							lRtn,  &
								lObjectKeys[]
								
String						sComments[]


Integer						i, j, lCounter



// -----------------------------------------------------------
// Alle Dokumente suchen
// Die Keys stehen in lObjectKeys[]
// -----------------------------------------------------------

lTimeStart = CPU()

sInfo =  this.uf_get_catobjects(sInfo, sComments, lObjectKeys)

lTimeEnde = CPU()
//f_debug("UF_GET_CATOBJECTS:             " + string ((lTimeEnde - lTimeStart) / 1000 , "0.000"))	
	
if sInfo.iStatus < 0 then
	return sInfo
else
	
if UpperBound(sComments) <= 0 then
	sInfo.iStatus = -1
	sInfo.sStatus = "No documents available"
	return sInfo
end if
			
	For I = 1 to UpperBound(lObjectKeys)
		
		
		lTimeStart = CPU()
		
		strTemp = sInfo
		strTemp = this.uf_get_document(strTemp, lObjectKeys[i])
		
		lTimeEnde = CPU()
		//f_debug("UF_GET_DOCUMENT (" + string(I) + "):             " + string ((lTimeEnde - lTimeStart) / 1000 , "0.000"))	

		

		if strTemp.istatus = -1 then
			sInfo.iStatus = -1	
			sInfo.sStatus = strTemp.sStatus
			return sInfo
			
		else
			
			for j = 1 to strTemp.iDocumentCopies
			
				lCounter ++
				sInfo.sstreamcomment[lCounter] = strTemp.sadditionalinfos
				this.sDocumentFileNames[lCounter]  			= strTemp.sadditionalinfos
				this.sDocumentFileDescriptions[lCounter]	= sComments[i]
				
			Next
			
			
		end if
					
	Next
	
end if

//string sout = ""
//for j = 1 to Upperbound(this.sDocumentFileNames)
//	sOut += this.sDocumentFileNames[j] + "~r"
//next
//Messagebox("", sOut)

return sInfo


end function

public function integer uf_fortocode ();	long lRow, lFoundRow, lNext
	long lDeleted = 0
	
// -----------------------------------------------
// Setzt L$$HEX1$$f600$$ENDHEX$$schmarkierung f$$HEX1$$fc00$$ENDHEX$$r ForTo-Code <> 0
// -----------------------------------------------
	lFoundRow = 1
	lNext		 = 1
	
	Do while lFoundRow > 0
		lFoundRow = ds_loadinglist.Find ("cen_loadinglists_nfor_to_code>0", lNext, ds_loadinglist.RowCount())
		if lFoundRow > 0 Then
			ds_loadinglist.Setitem(lFoundRow, "compute_1", 1)
			lNext = lFoundRow + 1
			lDeleted ++  
		end if
		
		if lFoundRow >= ds_loadinglist.RowCount() Then		// letzte Zeile
			lFoundRow = 0
		end if
	Loop
	
// -----------------------------------------------
// diese Funktion wird in Zukunft erweitert
// ForTo-Code = 0 ist nur f$$HEX1$$fc00$$ENDHEX$$r Deutschland
// -----------------------------------------------
	Return lDeleted



end function

public function integer uf_checkaufleerenstowage (long lrow);long 		lFind, &
			lStowageKey

lStowageKey	= ds_loadinglist.GetItemNumber(lRow, "cen_stowage_nstowage_key")			

lFind = ds_StauorteOhneInhalte.Find("cen_stowage_nstowage_key=" + String(lStowageKey), 1, ds_StauorteOhneInhalte.RowCount())

if lFind > 0 Then
	ds_StauorteOhneInhalte.DeleteRow(lFind)
end if

return 1

end function

public function boolean uf_no_action (long lrow);	long 		lActionRow,lSeekRow,i
	string	sGalley,sStowage,sPlace
	integer  iBelly
// ------------------------------------------------------------------------------
// Actioncode 'N' -> No Action
// Es werden alle Datens$$HEX1$$e400$$ENDHEX$$tze gesucht.
// Die in Galley,Stowage,Place und Belly $$HEX1$$fc00$$ENDHEX$$bereinstimmen.
// Sofern der Satz gefunden wird wird im Feld ....
// ------------------------------------------------------------------------------
	lActionRow 	= 1
	lSeekRow 	= 1
	sGalley		= ds_loadinglist.Getitemstring(lRow,"cen_galley_cgalley")
	sStowage		= ds_loadinglist.Getitemstring(lRow,"cen_stowage_cstowage")
	sPlace		= ds_loadinglist.Getitemstring(lRow,"cen_stowage_cplace")
	iBelly		= ds_loadinglist.GetitemNumber(lRow,"cen_loadinglists_nbelly_container")
	
	Do while lActionRow > 0
		lActionRow = ds_loadinglist.Find("cen_galley_cgalley = '" + sGalley + "' and " + &
									  "cen_stowage_cstowage = '" + sStowage + "' and " + &
									  "cen_stowage_cplace = '" + sPlace + "' and " + &
									  "cen_loadinglists_nbelly_container = " + string(iBelly),lSeekRow, ds_loadinglist.RowCount()) 

		If lActionRow > 0	Then
			ds_loadinglist.SetItem(lActionRow,"cen_loadinglists_cadd_on_text","No Action")			
		End if
		lSeekRow = lActionRow + 1
		If lSeekRow > ds_loadinglist.RowCount()	Then
			exit
		End If
	Loop	
	
	return True
end function

public function integer uf_draw_freetext (integer ipage);	//	-----------------------------------------------------------------------------------------------------
	//		 diese Funktion zeichnet einen Freitext in das Datawindow ds_report
	//	
	//			Argumente:
	//							iPage		= zu verarbeitende Seite im Datawindow ds_freetext
	//	----------------------------------------------------------------------------------------------------- 


	// ---------------------------
	// Druck-relevante Variable
	// ---------------------------
	Integer		iStartX, &
					iStartY, &
					iHeight, &
					iWidth, &
					iBold, &
					iItalic, &
					iAlign
					
	String		sText, &
					sFontName
					
	Long			lBackColor, &
					lTextColor
	
	// ---------------------------
	// Verarbeitungs-Variable
	// ---------------------------
	String		sCreate, &
					sObjectName, &
					sResult
	
	Integer		iFontSize, &
					iLeftMargin
					
	Long			lRow
	
	// ---------------------------
	// Init
	// ---------------------------
	iLeftMargin		= Integer(ds_report.Describe("DataWindow.Print.Margin.Left"))
	
	// ---------------------------
	// Die Werte der zu verarbeiten-
	// den Zeile lesen
	// ---------------------------
	For lRow = 1 To ds_freetext.RowCount()
		if ds_freetext.GetItemNumber(lRow, "npage") = iPage Then
			
			iStartX 		= ds_freetext.GetItemNumber(lRow, "nxpos") 
			iStartY 		= ds_freetext.GetItemNumber(lRow, "nypos") 
			iHeight 		= ds_freetext.GetItemNumber(lRow, "nheight") 
			iWidth 		= ds_freetext.GetItemNumber(lRow, "nwidth") 
			iBold 		= ds_freetext.GetItemNumber(lRow, "nfontbold") 
			iAlign		= ds_freetext.GetItemNumber(lRow, "ntextalign") 
			lBackColor	= ds_freetext.GetItemNumber(lRow, "nobjectbackgroundcolor") 
			lTextColor	= ds_freetext.GetItemNumber(lRow, "nfontcolor") 
			iFontSize	= ds_freetext.GetItemNumber(lRow, "nfontsize")  
			sText			= ds_freetext.GetItemString(lRow, "ctext")  
			
			// --------------------
			// Nicht Farbig ?
			// --------------------
			if iPrintColor = 2 then
				// --------------------
				// Graustufen
				// --------------------
				lBackColor = f_RGBToGreyScale(lBackColor)
			elseif iPrintColor = 3 then
				// --------------------
				// S/W
				// --------------------
				lBackColor 	= 16777215		// Hintergrund wei$$HEX1$$df00$$ENDHEX$$
			end if
		
			
			if iBold = 1 Then
				iBold = 700
			else
				iBold = 400
			end if
		
			sObjectName = "freitext_" + String(lRow)
			sCreate = "create "											 	  			+  & 
								"text("  													+  &
								"band=detail "  											+  &
								"alignment='" + string(iAlign)+ "' "  				+  &
								"text='" + sText + "' "  								+  &
								"border='0' "  											+  &
								"color='" + string(lTextColor) + "' "				+  &
								"x='" + String(iStartX) + "' "						+  &
								"y='" + String(iStartY) + "' "						+  &
								"height='" + String(iHeight) + "' "  				+  &
								"width='" + String(iWidth) + "' "  					+  &
								"name=" + sObjectName + " "							+  & 
								"tag='" + sObjectName + "' "							+  &
								"resizeable=0 "  											+  &
								"moveable=1 "  											+  &
								"font.face='" + sfontname + "' " 					+  &
								"font.height='" + String(iFontSize) + "' "		+  &
								"font.weight='" + string(iBold) + "' "  			+  &
								"font.family='2' "  										+  &
								"font.pitch='2' "  										+  &
								"font.charset='0' "  									+  &
								"background.mode='0' "  								+  &
								"background.color='" + string(lBackcolor) + "' "+  &
								"height.autosize=no)"
			
			if Len(trim(ds_report.Modify(sCreate))) > 0 Then
				return -1	
			end if
		end if
		//f_yield(lRoleID)
	Next
	
	return 1

end function

private function integer uf_resetactioncode ();/*


	Diese tolle Methode setzt das ds_loadinglist auf einen jungfr$$HEX1$$e400$$ENDHEX$$ulichen Stand
	
	WARUM:
	
	Wir f$$HEX1$$fc00$$ENDHEX$$gen alle ZBL's aus der Matrix der Reihe nach in DW_1 ein und zwar f$$HEX1$$fc00$$ENDHEX$$r jedes Leg
	Nach jedem einf$$HEX1$$fc00$$ENDHEX$$gen m$$HEX1$$fc00$$ENDHEX$$ssen wir DW_1 glatt ziehen damit der Action beim n$$HEX1$$e400$$ENDHEX$$chsten einf$$HEX1$$fc00$$ENDHEX$$gen und Ausf$$HEX1$$fc00$$ENDHEX$$hren
	der ActionCodes nicht beachtet wird
	

*/
	Long	i
	
	For i = 1 to ds_loadinglist.Rowcount()
	
		ds_loadinglist.SetItem(i,"cen_loadinglists_cactioncode", "L") 
		ds_loadinglist.SetItem(i,"cen_loadinglist_index_nloadinglist_key", 1) 
		
	Next
	
	return 1

end function

public function boolean uf_offload (long lrow);	long 		lActionRow,lSeekRow,i
	string	sGalley,sStowage,sPlace
	integer  iBelly
// ------------------------------------------------------------------------------
//   Actioncode Offload
// $$HEX2$$81002000$$ENDHEX$$Es werden Datens$$HEX1$$e400$$ENDHEX$$tze gesucht die den Loading List Type 1 (Loading List) haben.
// $$HEX2$$81002000$$ENDHEX$$Die in Galley,Stowage,Place und Belly $$HEX1$$fc00$$ENDHEX$$bereinstimmen.
// $$HEX2$$81002000$$ENDHEX$$Sofern der Satz gefunden wird wird im Feld Compute Actioncode der Status 1 eingetragen.
// ------------------------------------------------------------------------------
	lActionRow 	= 1
	lSeekRow 	= 1
	sGalley		= ds_loadinglist.Getitemstring(lRow,"cen_galley_cgalley")
	sStowage		= ds_loadinglist.Getitemstring(lRow,"cen_stowage_cstowage")
	sPlace		= ds_loadinglist.Getitemstring(lRow,"cen_stowage_cplace")
	iBelly		= ds_loadinglist.GetitemNumber(lRow,"cen_loadinglists_nbelly_container")
	
	Do while lActionRow > 0
		lActionRow = ds_loadinglist.Find("cen_galley_cgalley = '" + sGalley + "' and " + &
									  "cen_stowage_cstowage = '" + sStowage + "' and " + &
									  "cen_stowage_cplace = '" + sPlace + "' and " + &
									  "cen_loadinglists_nbelly_container = " + string(iBelly) + " and " + &
									  "cen_loadinglist_index_nloadinglist_key <> " + "2",lSeekRow, ds_loadinglist.RowCount()) 

		If lActionRow > 0	Then
			ds_loadinglist.Setitem(lActionRow,"compute_actioncode",1) 	
		End if
		lSeekRow = lActionRow + 1
		If lSeekRow > ds_loadinglist.RowCount()	Then
			exit
		End If
	Loop	
	
	return True
end function

private function integer uf_zustauen (long lrow);// --------------------------------------------
// Eintr$$HEX1$$e400$$ENDHEX$$ge aus ZBL mit dem Actioncode Z
// (Zustauen), werden in die zugeh$$HEX1$$f600$$ENDHEX$$rige 
// Zeile der SSL $$HEX1$$fc00$$ENDHEX$$bertragen
// --------------------------------------------

Long		lStowageKey, &
			lRowStowage
		
String	sZustautext, &
			sZustautextB

		
lStowageKey = ds_loadinglist.GetItemNumber(lRow, "cen_stowage_nstowage_key")

if lStowageKey = -1 Then
	return -1
end if

sZustautext	 = ds_loadinglist.GetItemString(lRow, "cen_packinglists_ctext")
sZustautextB = ds_loadinglist.GetItemString(lRow, "cen_packinglists_ctext_short")

if Not IsNull(sZustautextB) AND Len(sZustautextB) < Len(sZustautext) Then
	// -------------------------
	// den k$$HEX1$$fc00$$ENDHEX$$rzeren Text nehmen
	// -------------------------
	sZustautext = sZustautextB
end if

lRowStowage = 1
Do while lRowStowage > 0
	lRowStowage = ds_loadinglist.Find ("cen_stowage_nstowage_key = " + String(lStowageKey), lRowStowage, ds_loadinglist.RowCount())
	if lRowStowage > 0 AND lRowStowage <> lRow Then
		sZustautextB = ds_loadinglist.GetItemString(lRowStowage, "compute_ZustauText")
		if isNull(sZustautextB) OR Len(Trim(sZustautextB)) = 0 Then
			ds_loadinglist.SetItem(lRowStowage, "compute_ZustauText", sZustautext)
		end if
	end if
	
	if lRowStowage > 0 Then
		lRowStowage ++
	end if
	
	if lRowStowage > ds_loadinglist.RowCount() Then
		lRowStowage = 0
	end if
Loop


return 1

end function

public function long uf_default_color ();// ------------------------------------
// Default Farb schema ermitteln
// ------------------------------------
	SELECT 	cen_object_schema.nschema_key  
	INTO 		:largschema
	FROM 		cen_object_schema  
	WHERE 	cen_object_schema.nairline_key = :lAirlineKey AND 
				cen_object_schema.ndefault = 1   
	USING		SQLCA;

	If SQLCA.Sqlcode <> 0 Then
		return -1
	End if				
				

Return lArgschema
end function

public subroutine uf_setdatabaseinfo (transaction trsqlca);	// ---------------------------------------------
	// die Transobjekte
	// ---------------------------------------------	
	ds_print_job.SetTransObject(trSQLCA)
	ds_childstowages.SetTransObject(trSQLCA)					
	ds_zustautextetoextrastauort.SetTransObject(trSQLCA)	
	ds_belly.SetTransObject(trSQLCA)		
	ds_exclude.SetTransObject(trSQLCA)	
	ds_classname.SetTransObject(trSQLCA)
	ds_reportnotprinted.SetTransObject(trSQLCA)				
	ds_extra.SetTransObject(trSQLCA)	
	ds_report.SetTransObject(trSQLCA)							
	ds_diagramlayout.SetTransObject(trSQLCA)					
	ds_emptybox.SetTransObject(trSQLCA)	
	ds_bitmap.SetTransObject(trSQLCA)	
	ds_freetext.SetTransObject(trSQLCA)	
	ds_schema.SetTransObject(trSQLCA)	
	ds_loadinglist.SetTransObject(trSQLCA)
	ds_stauorteohneinhalte.SetTransObject(trSQLCA)		
	ds_matrix_routingplan_qaq.SetTransObject(trSQLCA)		
	ds_suplementloadingslist.SetTransObject(trSQLCA)		
	ds_matrix_qaq_processing.SetTransObject(trSQLCA)		
	ds_actual_layout.SetTransObject(trSQLCA)	
	
end subroutine

public subroutine uf_diagram_setup (long lhandle, long llayout_key, string sinvoked);	string sLayout_key
	Long	 lRow
	sLayout_key = string(lLayout_key)
	ds_actual_layout.retrieve(sMandant,sLayout_key)
// ---------------------------------
// Drucke Belly-Report True / False
// ---------------------------------	
	lRow = ds_actual_layout.find("csection = 'PrintBelly'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		bPrintBellyReport	= (ds_actual_layout.Getitemstring(lRow,"cvalue")= "1") 
	Else
		bPrintBellyReport	= False
	End if	
// ---------------------------------
// Drucke Add-On-Report True / False
// ---------------------------------	
	lRow = ds_actual_layout.find("csection = 'PrintAddOn'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		bPrintAddonReport	= (ds_actual_layout.Getitemstring(lRow,"cvalue")= "1") 
	Else
		bPrintAddonReport	= False
	End if	
// ---------------------------------
// Seitenduplizierung True / False
// ---------------------------------
	lRow = ds_actual_layout.find("csection = 'Diagram Pages'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		bDiagramPages	= (ds_actual_layout.Getitemstring(lRow,"cvalue")= "1") 
	Else
		bDiagramPages	= False
	End if	
// -----------------------------------------------------------
// Seitenduplizierung 1.Seite True / False
// -----------------------------------------------------------
	lRow = ds_actual_layout.find("csection = 'Diagram FirstPage'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		bDiagramFirstPages	= (ds_actual_layout.Getitemstring(lRow,"cvalue")= "1") 
	Else
		bDiagramFirstPages	= False
	End if	
// ---------------------------------
// gleicher Font  True / False
// ---------------------------------
	lRow = ds_actual_layout.find("csection = 'Diagram Font'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		bDiagramSameFont	= (ds_actual_layout.Getitemstring(lRow,"cvalue")= "1") 
	Else
		bDiagramSameFont	= False
	End if	
// ---------------------------------
// Sortierung
// ---------------------------------
	lRow = ds_actual_layout.find("csection = 'Diagram PrintSort'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		bSortByClass	= (ds_actual_layout.Getitemstring(lRow,"cvalue")= "2") 
	Else
		bSortByClass	= False
	End if	
// ---------------------------------
// Kleinster Font  
// ---------------------------------
	lRow = ds_actual_layout.find("csection = 'MinFontSize'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		iMinFontSize	= integer(ds_actual_layout.Getitemstring(lRow,"cvalue"))
	Else
		iMinFontSize	= 8
	End if	
// ---------------------------------
// Drucke Rahmen Extra-Stauort
// ---------------------------------	
	lRow = ds_actual_layout.find("csection = 'PrintFrame'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		bPrintFrame	= (ds_actual_layout.Getitemstring(lRow,"cvalue")= "1") 
	Else
		bPrintFrame	= False
	End if
	lRow = ds_actual_layout.find("csection = 'PrintHeader'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		bPrintHeader	= (ds_actual_layout.Getitemstring(lRow,"cvalue")= "1") 
	Else
		bPrintHeader	= False
	End if

	lRow = ds_actual_layout.find("csection = 'LineColor'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		lFrameColorExtra	= long(ds_actual_layout.Getitemstring(lRow,"cvalue"))
	Else
		lFrameColorExtra	= 0
	End if
	
	lRow = ds_actual_layout.find("csection = 'HeaderText'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		sHeadLineExtra	= ds_actual_layout.Getitemstring(lRow,"cvalue")
	Else
		sHeadLineExtra	= ""
	End if
// ---------------------------------
// Report Title	
// ---------------------------------
	lRow = ds_actual_layout.find("csection = 'Diagram Title'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		sReportTitle	= ds_actual_layout.Getitemstring(lRow,"cvalue")
	Else
		sReportTitle	= ""
	End if
// ---------------------------------
// Extra-Stauort Verweistext
// z.B. see Addon Report
// ---------------------------------
	lRow = ds_actual_layout.find("csection = 'ExtraLinkText'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		sLinkTextExtra	= ds_actual_layout.Getitemstring(lRow,"cvalue")
	Else
		sLinkTextExtra	= ""
	End if
// ---------------------------------
// Klassenmarkierung
// ---------------------------------
	lRow = ds_actual_layout.find("csection = 'ClassMark'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		bClassMark	= (ds_actual_layout.Getitemstring(lRow,"cvalue")= "1") 
	Else
		bClassMark	= False
	End if
	lRow = ds_actual_layout.find("csection = 'ClassBrush'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		iClassBrush	= integer(ds_actual_layout.Getitemstring(lRow,"cvalue"))
	Else
		iClassBrush	= 1
	End if	
	lRow = ds_actual_layout.find("csection = 'ClassMarkColor'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		lClassBrushColor	= long(ds_actual_layout.Getitemstring(lRow,"cvalue"))
	Else
		lClassBrushColor	= 1
	End if
// ---------------------------------
// Die Markierung f$$HEX1$$fc00$$ENDHEX$$r die Station
// ---------------------------------
	lRow = ds_actual_layout.find("csection = 'MarkForStationColor'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		lMarkNoCatererActionColor	= long(ds_actual_layout.Getitemstring(lRow,"cvalue"))
	Else
		lMarkNoCatererActionColor	= 0
	End if
// ---------------------------------
// Die Farbe f$$HEX1$$fc00$$ENDHEX$$r QAQ-Actioncodes
// ---------------------------------
	lRow = ds_actual_layout.find("csection = 'QAQTextColor'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		lQAQTextColor	= long(ds_actual_layout.Getitemstring(lRow,"cvalue"))
	Else
		lQAQTextColor	= 0
	End if
// ---------------------------------
// Die Farbe f$$HEX1$$fc00$$ENDHEX$$r For To Codes
// ---------------------------------
	lRow = ds_actual_layout.find("csection = 'ForToTextColor'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		lForToTextColor	= long(ds_actual_layout.Getitemstring(lRow,"cvalue"))
	Else
		lForToTextColor	= 0
	End if
// ---------------------------------
// Diagram Farbig ? True / False
// ---------------------------------
	if sWhereAmI = "WEB" then
		lRow = ds_actual_layout.find("csection = 'DiagramWebColor'",1,ds_actual_layout.Rowcount())
		If lRow > 0 Then
			iPrintColor	= integer(ds_actual_layout.Getitemstring(lRow,"cvalue"))
		Else
			iPrintColor	= 0
		End if
	Else
		lRow = ds_actual_layout.find("csection = 'DiagramClientColor'",1,ds_actual_layout.Rowcount())
		If lRow > 0 Then
			iPrintColor	= integer(ds_actual_layout.Getitemstring(lRow,"cvalue"))
		Else
			iPrintColor	= 0
		End if
	End if	
		
// ---------------------------------
// Standardmarkierung
// ---------------------------------
	lRow = ds_actual_layout.find("csection = 'NoMarkup'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		lNoMarkup	= long(ds_actual_layout.Getitemstring(lRow,"cvalue"))
	Else
		lNoMarkup	= 0
	End if
// ---------------------------------
// Legenden Bild Seite 1
// ---------------------------------	
	lRow = ds_actual_layout.find("csection = 'Legende'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		sLegendenPicture	= ds_actual_layout.Getitemstring(lRow,"cvalue")
	Else
		sLegendenPicture	= "None"
	End if
	If isnull(sLegendenPicture) Then
		sLegendenPicture = "None"
	End if	
// ---------------------------------
// leere Galleygrafik mit AC-Stamm
// ---------------------------------
	lRow = ds_actual_layout.find("csection = 'EmptyDiagram'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		iEmptyDiagram	= integer(ds_actual_layout.Getitemstring(lRow,"cvalue"))
	Else
		iEmptyDiagram	= 0
	End if
// ---------------------------------
// Contents Report
// ---------------------------------
	lRow = ds_actual_layout.find("csection = 'PrintContents'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		bPrintContentsReport	= (ds_actual_layout.Getitemstring(lRow,"cvalue")= "1") 
	Else
		bPrintContentsReport	= False
	End if
	lRow = ds_actual_layout.find("csection = 'PrintContentsDays'",1,ds_actual_layout.Rowcount())
	If lRow > 0 Then
		iContentsDays	= integer(ds_actual_layout.Getitemstring(lRow,"cvalue"))
	Else
		iContentsDays	= 0
	End if
// -------------------------
// das Layout laden
// -------------------------	
	ds_diagramlayout.Retrieve(lLayout_key)
	
		
end subroutine

public function long uf_draw_bitmap (integer ipage);//	-----------------------------------------------------------------------------------------------------
//		 diese Funktion zeichnet ein Bitmap in das Datawindow ds_report
//	
//			Argumente:
//							iPage		= zu verarbeitende Seite im Datawindow ds_printbitmap
//	----------------------------------------------------------------------------------------------------- 


// ---------------------------
// Druck-relevante Variable
// ---------------------------
Integer		iStartX, &
				iStartY, &
				iHeight, &
				iWidth
				
// ---------------------------
// Verarbeitungs-Variable
// ---------------------------
String		sCreate, &
				sObjectName, &
				sResult, &
				sPrefix, &
				sBitmapname, &
				sGreyedBitmapname

Integer		iLeftMargin, &
				iAnzLeseLoops, &
				iPicIndex, &
				i
				
Long			lRow, &
				lRet, &
				lLen, &
				lFHnd, &
				lFileLength, &
				lPageKey

Blob			bBuffer, &
				bPicture
				
Long			lSession

// ---------------------------------------------
// der Temp-Ordner, in dem die Bitmaps erzeugt 
// werden. Wir schreiben sie in den gleichen
// Ordner in den wir auch die temp. PDFs er-
// zeugen. Den R$$HEX1$$e400$$ENDHEX$$umen wir n$$HEX1$$e400$$ENDHEX$$mlich auch $$HEX1$$fc00$$ENDHEX$$ber
// die Service-Komponente auf.
// 
// 21.08.2002
// falls die Komponente von einem Powerbuilder
// Client aufgerufen wird dann die Bilder in
// das Temp Verzeichnis speichern
// ---------------------------------------------

if sWhereAmI = "WEB" then
	lSession = nPrintPDF.GetSession()
	sTempPath = nPrintPDF.GetPdfDocPath() //f_GetTempPath ()
else
	lSession  = Rand(32767)
	sTempPath = f_gettemppath()
end if


if isNull(sTempPath) Then
	sTempPath = "c:\"
end if

// ---------------------------
// Die Werte der zu verarbeiten-
// den Zeile lesen
// ---------------------------

For lRow = 1 To ds_bitmap.RowCount()
	if ds_bitmap.GetItemNumber(lRow, "npage") = iPage Then
		iStartX 		= ds_bitmap.GetItemNumber(lRow, "nxpos")
		iStartY 		= ds_bitmap.GetItemNumber(lRow, "nypos") 
		sBitmapname	= ds_bitmap.GetItemString(lRow, "ctext") 
		lPageKey		= ds_bitmap.GetItemNumber(lRow, "npage_key")
		iHeight		= ds_bitmap.GetItemNumber(lRow, "nheight")
		iWidth		= ds_bitmap.GetItemNumber(lRow, "nwidth")
		
		// ------------------------------------------
		// das Bild kommt zwar als Blob aus der DB
		// das Picture-Control im DW kann jedoch
		// keine Blob. Er braucht einen Filenamen.
		// Wir erstellen im Temp ein tempor$$HEX1$$e400$$ENDHEX$$res
		// File und nutzen dies. Im Desctructor
		// l$$HEX1$$f600$$ENDHEX$$schen wir es wieder
		//
		// wir erstellen eine tempor$$HEX1$$e400$$ENDHEX$$re Datei
		// ------------------------------------
		
		sPrefix = Right(sBitmapname, 4)
		
		if Left(sPrefix, 1) <> "." Then				// f$$HEX1$$fc00$$ENDHEX$$r jpeg
			sPrefix = "." + sPrefix
		end if
		
		// ------------------------------------------
		// Sofern keine Standardmarkierung brauchen 
		// wir keine Legende !
		// ------------------------------------------
		If iPage = 1 and lNoMarkup = 1 and Upper(sBitmapname) = Upper(sLegendenPicture) Then
			CONTINUE
		End if		
		sBitmapname = sTempPath + "~CBASE-P-" + String(CPU()) + String(lRow) + string(lPageKey) + string(lSession) + sPrefix
		iPicIndex  = UpperBound(sTempFiles[]) + 1
		sTempFiles[iPicIndex] = sBitmapname

			
		// ------------------------------------------
		// Wir holen das Bild in den Blob
		// ------------------------------------------
		SELECTBLOB 	bBITMAP
		INTO			:bPicture
		FROM			CEN_DIAGRAM_PAGES
		WHERE 		nPage_Key = :lPageKey
		USING			SQLCA;
		if SQLCA.SQLDBCODE <> 0 Then
			lRet --
		else
			
			if not isnull(bPicture) then
			
				f_Blob_To_File(sBitmapname, bPicture)
										
				sCreate = "create "										 				+  & 
							"bitmap("  														+  &
							"band=detail "  												+  &
							"filename='" + sBitmapname + "' "						+  &
							"x='" + String(iStartX) 						+ "' "	+  &
							"y='" + String(iStartY) 						+ "' "	+  &				
							"height='" + string(iHeight) 					+ "' " 	+  &
							"width='" + string(iWidth) 					+ "' "   +  &		
							"border='0' "  												+  &
							"name=stowage_picture_" + String(CPU()) + "_" + string(lRow) 	+  ")"		
							
			end if
							
						
			if Len(trim(ds_report.Modify(sCreate))) > 0 Then
				lRet --	
			end if
		end if
	end if
Next

f_setHomeDirectory()

return lRet
end function

private function integer uf_calcweight ();/*
	wir berechnen die Gewichte. Das Gesamtgewicht steht immer nur in einem Stauort
	Haben wir aber zwei Halbe, so m$$HEX1$$fc00$$ENDHEX$$ssen wir teilen. Der Sicherheitshalber 
	addieren wir aber die Gewichte aller Front/Rear Stauorte auf (ist ja eh
	egal wenn sie 0 sind) und teilen dann erst
	
*/
Long		lStowageRow[], lClear[]
Long		lRow = 1
Long		lFoundRow, lCnt
String	sGalley, sStowage
Double	dMaxWeight, DCalcWeight

// --------------------------------------------------
// erst mal vom Prinzip her alle Zeilen durchlaufen
// --------------------------------------------------
do while lRow > 0
	// ---------------------------------------------
	// Erst mal alles zur$$HEX1$$fc00$$ENDHEX$$ck setzen
	// ---------------------------------------------
	lCnt 				= 0
	dMaxWeight 		= 0
	lStowageRow[] = lClear[]
	
	lRow = ds_loadinglist.Find("cen_stowage_nweight > 0", lRow, ds_loadinglist.RowCount()) 
	
	// ---------------------------------------------
	// haben wir einen Stauort mit Gewicht ?
	// ---------------------------------------------
	if lRow > 0 Then
		lCnt ++
		lStowageRow[lCnt] = lRow		// wir merken uns die Row
		
		sGalley		= ds_loadinglist.Getitemstring(lRow, "cen_galley_cgalley")
		sStowage		= ds_loadinglist.Getitemstring(lRow, "cen_stowage_cstowage")
		dMaxWeight	= ds_loadinglist.GetitemDecimal(lRow, "cen_stowage_nweight")

		// ---------------------------------------------
		// wir suchen alle Stauorte mit gleicher Galley 
		// und Stauort also Front / Rear und so etwas
		// aber nur die, die auch gedruckt werden.
		// Also iPage > 0
		// ---------------------------------------------
		lFoundRow = 1
		do while lFoundRow > 0
			lFoundRow = ds_loadinglist.Find("cen_galley_cgalley = '" + sGalley + "' and " + &
								 "cen_stowage_cstowage = '" + sStowage + "' AND cen_stowage_npage > 0", lFoundRow, ds_loadinglist.RowCount()) 
			if lFoundRow > 0 AND lFoundRow <> lRow Then
				lCnt ++
				lStowageRow[lCnt] = lFoundRow
				dMaxWeight	= 	dMaxWeight + ds_loadinglist.GetItemDecimal(lFoundRow, "cen_stowage_nweight")
				ds_loadinglist.SetItem(lFoundRow, "cen_stowage_nweight", 0)
				lFoundRow ++
			end if
			
			if lFoundRow = lRow Then
				lFoundRow ++
			end if
			
			
			if lFoundRow > ds_loadinglist.RowCount() Then
				lFoundRow = 0
			end if
		loop
		
		// ---------------------------------------------
		// OK jetzt haben wir sie alle
		// wir teilen und setzen das kalkulierte Gewicht 
		// in die Compute Spalte. In lCnt steht die
		// Anzahl der gefundenen Stauorte
		// ---------------------------------------------
		DCalcWeight = 	dMaxWeight / lCnt
		For lCnt = 1 To UpperBound(lStowageRow[])
			ds_loadinglist.SetItem(lStowageRow[lCnt], "compute_calcweight", DCalcWeight)
		Next
		
		// ---------------------------------------------
		// jetzt nocht das Gewicht auf 0 und die 
		// Scuhzeile 1 rauf
		// ---------------------------------------------
		ds_loadinglist.SetItem(lRow, "cen_stowage_nweight", 0)
		lRow ++
	end if
	
	if lRow > ds_loadinglist.RowCount() Then
		lRow = 0
	end if
	
loop

return 0



end function

public function long uf_createnewsreport (ref blob bstate, date dcheckdate);// ---------------------------------------------------
// diese Funktion ermittelt die neuen Packinglists
// ---------------------------------------------------

	
if Not bPrintContentsReport Then
	return 0
end if


Long		lNext, &
			lAnz, &
			lRow, &
			l, I, &
			lFound
			
Integer	ianzahlnewsreports

DateTime	dtCheck

String 	sPL

// -------------
// leeren
// -------------
ds_new_packinglists.Reset()

//lNext 	= 1

ianzahlnewsreports 	= 1
dtCheck 					= DateTime(dShowAsNew, Time("00:00"))

For I = 1 to ds_loadinglist.RowCount()
	
	// ------------------------------------------------------------------
	// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob das G$$HEX1$$fc00$$ENDHEX$$ltig ab Datum der PL gr$$HEX2$$f600df00$$ENDHEX$$er dem Pr$$HEX1$$fc00$$ENDHEX$$fdatum ist
	// ------------------------------------------------------------------
	if ds_loadinglist.GetItemDateTime(I, "cen_packinglists_dvalid_from") >= dtCheck and ds_loadinglist.GetItemNumber(I, "stationinstruction") = 1 then
		
		// ------------------------------------------------------------------
		// Nachschau, ob dir PL schon im Report steht
		// ------------------------------------------------------------------
		sPL = ds_loadinglist.GetItemString(I, "cen_packinglist_index_cpackinglist")

		lFound = ds_new_packinglists.Find("cen_packinglist_index_cpackinglist = '" + sPL + "'", 1, ds_new_packinglists.RowCount())

		if lFound = 0 then
			lRow = ds_new_packinglists.InsertRow(0)
			ds_new_packinglists.SetItem(lRow, "cen_packinglist_index_cpackinglist", ds_loadinglist.GetItemString(i, "cen_packinglist_index_cpackinglist"))
			ds_new_packinglists.SetItem(lRow, "cen_packinglists_dvalid_from", ds_loadinglist.GetItemdatetime(i, "cen_packinglists_dvalid_from"))
			ds_new_packinglists.SetItem(lRow, "cen_packinglists_cunit", ds_loadinglist.GetItemString(i, "cen_packinglists_cunit"))
			ds_new_packinglists.SetItem(lRow, "cen_packinglists_ctext", ds_loadinglist.GetItemString(i, "cen_packinglists_ctext"))
		end if
	
	end if
		
Next


if ds_new_packinglists.RowCount() > 0 Then
		
	ds_new_packinglists.Object.flight_t.text 				= Trim(sAirlineCode + " " + STRING(iFlightNo) + " " + sSuffix)
	ds_new_packinglists.Object.actyp_t.text  				= sOwnerCode + " " + sAircraftType
	ds_new_packinglists.Object.flightdetail_t.text 		= String(dtdeparturedate, sDateFormat) + "  " + String(tdeparturetime, "HH:MM")
	ds_new_packinglists.Object.time_t.text 				= string(Today(), sdateformat) + "   " + string(now(), "HH:MM")
	ds_new_packinglists.Object.signature_t.text			= sOrga
	
	// die Farbe und das Logo
	if iPrintColor > 1 Then
		ds_new_packinglists.Object.reportheadline_t.Color = "0"
		ds_new_packinglists.Object.r_1.Pen.Color = "0"
		ds_new_packinglists.Object.r_2.Pen.Color = "0"
		ds_new_packinglists.Object.l_2.Pen.Color = "0"
	end if
	

	if iPrintColor > 1 Then
		ds_new_packinglists.Object.p_title.filename = slogo_black
	else
		ds_new_packinglists.Object.p_title.filename = slogo_color
	end if
	
	ds_new_packinglists.SetSort("cen_galley_nsort A, cen_stowage_nsort A")
	ds_new_packinglists.Sort()
	

	// -----------------------------
	// wir f$$HEX1$$fc00$$ENDHEX$$llen den per Ref $$HEX1$$fc00$$ENDHEX$$ber-
	// geben Blob
	// -----------------------------
	if iPrintColor > 1 Then
		ds_new_packinglists.Modify("DataWindow.Print.Color='2'")
	end if
	
	//ds_new_packinglists.print()
	
	if ds_new_packinglists.GetFullState(bState) = -1 Then
		ianzahlnewsreports = -1
	end if
	
else
	ianzahlnewsreports = 0
end if

return ianzahlnewsreports  
end function

public subroutine uf_add_color_text ();	long 			lRow, ll_MaxWidth, ll_MaxHeight, ll_TextHeight, ll_TextWidth
	s_schema		s_properties	
	Integer		iFontSize, &
					iFontHeight
	Boolean		bBold, &
					bItalic
	String		sText

// ---------------------------------------------
// Farben und Text Informationen hinzuf$$HEX1$$fc00$$ENDHEX$$gen
// ---------------------------------------------
	For lRow = 1 to ds_loadinglist.Rowcount()
		
		uf_SetSchema(lRow)	
		uf_checkAufLeerenStowage(lRow)
		
		// -----------------------------
		// Die max. Textbreite berechnen
		// -----------------------------
		if	bValidObject Then
			s_properties.fontsize 	= ds_loadinglist.GetitemNumber(lRow, "cen_object_schema_nfontsize") 
			s_properties.fontname 	= ds_loadinglist.GetitemString(lRow, "cen_object_schema_cfontname")
			s_properties.fontbold	= ds_loadinglist.GetitemNumber(lRow, "cen_object_schema_nfontbold")
			s_properties.fontitalic	= ds_loadinglist.GetitemNumber(lRow, "cen_object_schema_nfontitalic")
			sText							= ds_loadinglist.GetitemString(lRow, "cen_packinglists_ctext")
			ll_MaxWidth					= ds_loadinglist.GetitemNumber(lRow, "cen_object_equipment_nequipment_width")
			ll_MaxHeight				= ds_loadinglist.GetitemNumber(lRow, "cen_object_equipment_nequipment_height")
			
			bBold 	= (s_properties.fontbold = 1) 
			bItalic 	= (s_properties.fontitalic = 1)
		
			iuo_FontCalc.of_GetOptFontSize(sText, s_properties.fontname, iFontSize, bBold, bItalic, false, ll_MaxHeight, ll_MaxWidth, false)
			if iFontSize > s_properties.fontsize then iFontSize = s_properties.fontsize
						
			if iFontSize <> -1 Then
				if iFontSize < iMinFontSize Then
					iFontSize = iMinFontSize 
				end if
				
				// Property fehlt noch
				iuo_FontCalc.of_GetTextSize(sText, s_properties.fontname, iFontSize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
				iFontHeight = Integer(ll_TextHeight)
				
				ds_loadinglist.Setitem(lRow, "compute_usefontsize", iFontSize)
				ds_loadinglist.Setitem(lRow, "compute_FontHeight", iFontHeight)
			end if
		
		end if
	Next	
	
	// -----------------------------
	// Die max. Textbreite berechnen
	// f$$HEX1$$fc00$$ENDHEX$$r Stauorte mit leeren Inhalt
	// hier nehmen wir den Standard 
	// Font.
	// -----------------------------
	For lRow = 1 To ds_stauorteohneinhalte.Rowcount()
		
		s_properties.fontsize 	= ds_stauorteohneinhalte.GetitemNumber(lRow, "cen_object_schema_nfontsize") 
		s_properties.fontname 	= ds_stauorteohneinhalte.GetitemString(lRow, "cen_object_schema_cfontname")
		s_properties.fontbold	= ds_stauorteohneinhalte.GetitemNumber(lRow, "cen_object_schema_nfontbold")
		s_properties.fontitalic	= ds_stauorteohneinhalte.GetitemNumber(lRow, "cen_object_schema_nfontitalic")
		sText							= ds_stauorteohneinhalte.GetitemString(lRow, "cen_galley_cgalley")			// wir brauchen ja einen Text, also nehmen wir die Galley
		
		bBold 	= (s_properties.fontbold = 1) 
		bItalic 	= (s_properties.fontitalic = 1)
		
		sText = uf_check_null(sText)
		
		iuo_FontCalc.of_GetTextSize(sText, s_properties.fontname, s_properties.fontsize, bBold, bItalic, false, ll_TextHeight, ll_TextWidth)
		iFontHeight = Integer(ll_TextHeight)
		ds_stauorteohneinhalte.Setitem(lRow, "compute_usefontsize", iFontSize)
	Next
	
	// --------------------------
	// die ganze Seite in der 
	// gleichen Fontgr$$HEX2$$f600df00$$ENDHEX$$e
	// => bereinigen
	// --------------------------
	if bdiagramsamefont Then
		uf_setsamefont()
	end if
	
			   //messagebox("", "3")
	
	// --------------------------
	// wird schwarz/wei$$HEX1$$df00$$ENDHEX$$
	// gedruckt
	// leere Stauorte nachziehen
	// --------------------------
	if iPrintColor > 1  then
			
		for lRow = 1 to ds_StauorteOhneInhalte.Rowcount()
			s_properties.objectcolor				= 0				// Linenfarbe schwarz
			s_properties.objectbackgroundcolor	= 16777215		// Hintergrund wei$$HEX1$$df00$$ENDHEX$$
			s_properties.fontcolor					= 0				// Schriftfarbe schwarz
			ds_StauorteOhneInhalte.Setitem(lRow ,"cen_object_schema_nfontcolor",s_properties.fontcolor)		
			ds_StauorteOhneInhalte.Setitem(lRow ,"cen_object_schema_nobjectbackgroundcolor",s_properties.objectbackgroundcolor)
			ds_StauorteOhneInhalte.Setitem(lRow ,"cen_object_schema_nobjectcolor",s_properties.objectcolor)
		next

	end if


			

	
	
end subroutine

private function integer uf_qaq_actioncode (integer iworkingleg, long larg_handlingkey);Long		lRows, &
			lNext, &
			lStartRow, &
			lAnz = 0

Long		lPlKey
Long		lZBLRow

String	sActionCode, &
			sSearchArg, &
			sSICode, &
			sBuffer, &
			sLoadinglist

// -----------------------------------------------------------------
// Datens$$HEX1$$e400$$ENDHEX$$tze aus der ZBL kommen nicht zur Beladung, au$$HEX1$$df00$$ENDHEX$$er No Action
// Alle anderen erstmal nicht !
// stationinstruction 1 = Beladung
// stationinstruction 0 = keine Beladung
// -----------------------------------------------------------------
	For lRows = 1 To ds_loadinglist.RowCount()
		
		 If ds_loadinglist.GetItemNumber(lRows,"cen_loadinglist_index_nloadinglist_key") = 2 Then
		 	 If ds_loadinglist.GetItemString(lRows,"cen_loadinglists_cadd_on_text") = 'No Action' Then
			    ds_loadinglist.SetItem(lRows, "stationinstruction",0)
			 Else 
				 ds_loadinglist.SetItem(lRows, "stationinstruction",1)
			End if	 
		 Else
			 ds_loadinglist.SetItem(lRows, "stationinstruction",0)
		 End if
	Next

// ----------------------------------------------------------
// OK, nun kommen die dazu die einen SI-Code haben
// ----------------------------------------------------------

	For lRows = 1 To ds_matrix_qaq_processing.RowCount()
		// -----------------------------------
		// wir ermitteln den QAQ-Actioncode
		// und suchen die entsprechende
		// PL in ds_loadinglist und $$HEX1$$fc00$$ENDHEX$$bertragen den
		// QAQ-Actioncode in das entsprechende
		// Feld
		// -----------------------------------
		sActionCode 	= Upper(ds_matrix_qaq_processing.GetItemString(lRows, "cactioncode"))
		sSICode			= ds_matrix_qaq_processing.GetItemString(lRows, "csi_code")
		lPlKey			= ds_matrix_qaq_processing.GetItemNumber(lRows, "npackinglist_index_key")
		
		lNext = 1
		sSearchArg = "cen_packinglist_index_npackinglist_index_key=" + STRING(lPlKey)
		Do While lNext > 0
			lNext = ds_loadinglist.Find(sSearchArg, lNext, ds_loadinglist.RowCount())
			if lNext > 0 Then
				If ds_loadinglist.GetItemString(lNext,"cen_loadinglists_cadd_on_text") = 'No Action' Then
					// --------------------------------------------------------
					// f$$HEX1$$fc00$$ENDHEX$$r Datens$$HEX1$$e400$$ENDHEX$$tze mit Actioncode 'N' -> No Action
					// wird kein SI-Code eingetragen
					// --------------------------------------------------------
					ds_loadinglist.SetItem(lNext, "stationinstruction",0)
					lNext ++
				else	
					sBuffer = ds_loadinglist.GetItemString(lNext, "compute_sicodes")
					sBuffer = sBuffer + " " + sSICode + " " + sActionCode + " "
					ds_loadinglist.SetItem(lNext, "compute_sicodes", Trim(sBuffer))
					ds_loadinglist.SetItem(lNext, "compute_qaq_actioncode", sActionCode)
					ds_loadinglist.SetItem(lNext, "compute_handling_key", lARG_HandlingKey)
				// ----------------------------------------------------------
				// stationinstruction = 1 kommt f$$HEX1$$fc00$$ENDHEX$$r diese Station zur Beladung
				// ----------------------------------------------------------
					ds_loadinglist.SetItem(lNext, "stationinstruction",1)
					lNext ++
				End if	
			end if
					
			if lNext >= ds_loadinglist.RowCount() Then
				lNext = 0
			end if
		Loop
	Next




return 1


end function

public function s_all_flight_infos uf_matrix_newspaper (s_all_flight_infos sinfo);	String		sFilterVerkehr,sDepartureTime
	Long			i, lRow, lRows
	
// -----------------------------------------------
// Vorbereitung und setzen der Variabeln
// -----------------------------------------------
	sDepartureTime = sInfo.cdeparturetime
	iVerkehrsTag 	= f_getfrequence(Date(sInfo.sdeparturedate))
	sFilterVerkehr = "nfreq" + STRING(iVerkehrsTag) + "=1"
	sAirlineCode	= sInfo.sairline
	lAircraftKey	= sInfo.laircraft_key
	sAircraftType	= sInfo.sactype
	sOwnerCode		= sInfo.sowner
	lOwnerKey		= sInfo.lownerKey
	sGalleyVersion	= sInfo.sgalleyversion
	lHandlingKey	= sInfo.lhandling_key
		
	ds_matrix_newspaper.Reset()
// -----------------------------------------------
// Loading Lists Newspaper
// -----------------------------------------------
	sinfo = uf_get_newspaper_handling_by_id(sInfo,6)
// -----------------------------------------------
// Packing Lists Newspaper
// -----------------------------------------------
	sinfo = uf_get_newspaper_handling_by_id(sInfo,7)	
	ds_matrix_newspaper.SetSort("nleg A, nprio_extern A, nprio_intern A")
	ds_matrix_newspaper.Sort()

	return sInfo

end function

public function s_all_flight_infos uf_get_newspaper_handling_by_id (s_all_flight_infos sinfo, long lhandling_id);// -----------------------------------------------
// 
// -----------------------------------------------	
	string  		sFrequenz, sFilter,sLoadingText
	DataStore 	ds_handlingplan
	integer 		i
	long			lRow,lJoker_Handling_Type_Key
	
	
	ds_handlingplan					= CREATE DataStore
	ds_handlingplan.DataObject 	= "dw_handlingplan_newspaper"							
	ds_handlingplan.SetTransObject(SQLCA)
	
	
	ds_handlingplan.Retrieve(sInfo.lroutingplan_index, &
									sInfo.lroutingplan_group_key, &
									lhandling_id, &
									date(sInfo.sdeparturedate), &
									sInfo.cdeparturetime)
	
	
	iVerkehrsTag = f_getfrequence(date(sInfo.sdeparturedate))
	sFrequenz 	 = "cen_routingplan_nfreq" + string(iVerkehrsTag) + "=1"
// ----------------------------------------------------------------------
// Filter auf Aircrafttyp,Handling,Beladeleg,Originalleg,Frequenz
// ----------------------------------------------------------------------
	sFilter		 = "cen_aircraft_naircraft_key = " + string(sInfo.laircraft_key) + &
						" and cen_handling_types_nhandling_type_key = " + string(sInfo.lhandling_key) + &
						" and cen_routingplan_nleg_number >= " + string(sInfo.lhandling_leg_number) + &
						" and cen_routingplan_nleg_number <= " + string(sInfo.lroutingplan_leg_number) + &
						" and cen_routingplan_nfreq" + string(iVerkehrsTag) + " = 1 and cen_routingplan_handling_nfreq" + string(iVerkehrsTag) + " = 1"
	
	ds_handlingplan.SetFilter(sFilter)
	ds_handlingplan.Filter()
// ----------------------------------------------------------------------
// Filter auf Aircrafttyp,Handling = *,Beladeleg,Originalleg,Frequenz
// nur bei Supplement Loading Lists
// ----------------------------------------------------------------------	
	If ds_handlingplan.rowcount() <= 0 Then
		uf.mbox("Joker Handling " + string(lhandling_id),"")
		 SELECT nhandling_type_key  
    	   INTO :lJoker_Handling_Type_Key  
         FROM cen_handling_types  
        WHERE ctext = '*' AND  
              nairline_key = :sInfo.lairline_key ;
					
			If SQLCA.SQLCODE = 0 Then
				ds_handlingplan.SetFilter("")
				ds_handlingplan.Filter()
				sFilter	 = "cen_aircraft_naircraft_key = " + string(sInfo.laircraft_key) + &
								" and cen_handling_types_nhandling_type_key = " + string(lJoker_Handling_Type_Key) + &
								" and cen_routingplan_nleg_number >= " + string(sInfo.lhandling_leg_number) + &
								" and cen_routingplan_nleg_number <= " + string(sInfo.lroutingplan_leg_number) + &
								" and cen_routingplan_nfreq" + string(iVerkehrsTag) + " = 1 and cen_routingplan_handling_nfreq" + string(iVerkehrsTag) + " = 1"
	
				ds_handlingplan.SetFilter(sFilter)
				ds_handlingplan.Filter()
			End if
	End if	


	uf.mbox("Newspaper : " + string(lhandling_id), String(ds_handlingplan.RowCount()))
	For i = 1 to ds_handlingplan.RowCount()
		lRow = ds_matrix_newspaper.InsertRow(0)
		ds_matrix_newspaper.SetItem(lRow,"nleg",ds_handlingplan.GetItemNumber(i,"cen_routingplan_nleg_number"))
		ds_matrix_newspaper.SetItem(lRow,"nact_leg",sInfo.lroutingplan_leg_number)
		ds_matrix_newspaper.SetItem(lRow,"ssl_zbl_qaq",ds_handlingplan.GetItemString(i,"cen_handling_newspaper_cnews_ll"))			
		ds_matrix_newspaper.SetItem(lRow,"nkey",ds_handlingplan.GetItemNumber(i,"cen_news_ll_index_nnews_ll_index_key"))
		ds_matrix_newspaper.SetItem(lRow,"ntyp",ds_handlingplan.GetItemNumber(i,"cen_handling_nhandling_id"))
		ds_matrix_newspaper.SetItem(lRow,"nprio_extern",ds_handlingplan.GetItemNumber(i,"sys_handling_id_nprio"))
		ds_matrix_newspaper.SetItem(lRow,"nprio_intern",ds_handlingplan.GetItemNumber(i,"cen_handling_newspaper_nprio"))	
		ds_matrix_newspaper.SetItem(lRow,"cfrom",ds_handlingplan.GetItemString(i,"sys_three_letter_codes_ctlc_from"))
		ds_matrix_newspaper.SetItem(lRow,"cto",ds_handlingplan.GetItemString(i,"sys_three_letter_codes_ctlc_to"))

		uf.mbox("Newspaper",ds_handlingplan.GetItemString(i,"cen_handling_newspaper_cnews_ll"))
	Next

	
	DESTROY ds_handlingplan
	return sInfo
end function

public function s_all_flight_infos uf_get_catobjects (s_all_flight_infos sinfo, ref string scomments[], ref long lobjectkeys[]);	cat_object							strCatObjects[]
	uo_catering_object_steuerung	uoSteuerung
	DATE									dDepartureDate
	String								sRowStyle,sFormName
											
	DataStore							dsFlight
	LONG									lCatCnt, lInheritCatCnt,lCounter = 0
	INTEGER								iTag, iStyleCheck = 0
	sDateFormat = f_getdateformat(sinfo.luser_id)
// ---------------------
// Userobject erstellen
// ---------------------
	uoSteuerung = CREATE uo_catering_object_steuerung	
	uoSteuerung.sMandant			= sinfo.sclient
	uoSteuerung.lAirlineKey		= sinfo.lairline_key
	uoSteuerung.iFlightNumber 	= integer(sinfo.sflightnumber)
	uoSteuerung.dDepartureDate	= date(sInfo.sdeparturedate)
	uoSteuerung.sDestination 	= sinfo.sto
	uoSteuerung.sSuffix 			= sinfo.ssuffix
	uoSteuerung.lRoutingID 		= sInfo.lrouting_id
	uoSteuerung.tDepartureTime	= Time(sinfo.cdeparturetime)

	uoSteuerung.ib_deliverynotemode = 	ib_deliverynotemode

// ---------------------
// Dokumente holen.
// ---------------------
	uoSteuerung.uf_getobjects(strCatObjects[],sInfo)

	IF UpperBound(strCatObjects[]) = 0 THEN
		DESTROY uoSteuerung
		DESTROY dsFlight
		sinfo.sStatus =  "Sorry, CBASE found no documents for this flight"
		sinfo.iStatus = -1
		return sinfo
	END IF


	For lCatCnt = 1 To UpperBound(strCatObjects[])
		
		if UpperBound(strCatObjects[lCatCnt].objects[]) > 0 Then
			
	
			For lInheritCatCnt = 1 To UpperBound(strCatObjects[lCatCnt].objects[])
				lCounter ++
				
				sComments[lCounter]		= strCatObjects[lCatCnt].objects[lInheritCatCnt].sName + "    " + &
									  			  String(strCatObjects[lCatCnt].objects[lInheritCatCnt].dValidFrom, sDateFormat) + " - " + &
												  String(strCatObjects[lCatCnt].objects[lInheritCatCnt].dValidTo, sDateFormat)
												  
				lObjectKeys[lCounter]	= strCatObjects[lCatCnt].objects[lInheritCatCnt].luserobjectkey
				
			Next
			
		end if
	Next
					
	
	DESTROY uoSteuerung 
	return sinfo



end function

public function s_all_flight_infos uf_get_document (s_all_flight_infos sinfo, long linheritcatobject);// ------------------------------
// Dokumente erstellen
// ------------------------------
	uo_catering_object_steuerung	uoSteuerung
	DATE									dDepartureDate
	uoSteuerung = CREATE uo_catering_object_steuerung	

	uoSteuerung.dDepartureDate 			= date(sInfo.sdeparturedate)
	uoSteuerung.lInheritCateringID		= lInheritCatObject
	uoSteuerung.lAirlineKey					= sinfo.lairline_key
	uoSteuerung.iFlightNumber				= integer(sinfo.sflightnumber)
	uoSteuerung.sSuffix						= sinfo.ssuffix
	uoSteuerung.sMandant						= sinfo.sclient
	uoSteuerung.sUserStation				= sinfo.shomeStation
	uoSteuerung.sDateFormat					= f_getdateformat(sInfo.luser_id)
	uoSteuerung.uoPDF							= this.uoPDF

	uoSteuerung.ib_deliverynotemode = 	ib_deliverynotemode

	if uoSteuerung.of_getglobalobjectexplicit(sinfo) = 0 Then
		sInfo.sstatus 				= ""
		sInfo.istatus 				= 0
		sInfo.bStream 				= uoSteuerung.bPDFStream
		sInfo.iDocumentCopies   = uoSteuerung.iCopyCount
		sInfo.lStreamSize 		= LEN(uoSteuerung.bPDFStream)
		sInfo.sadditionalinfos	= uoSteuerung.spdffilename
		
	else
		sInfo.sstatus = uoSteuerung.sErrorText
		sInfo.istatus = -1
	end if
	
	DESTROY uoSteuerung
	
	return sInfo
end function

public function integer uf_matdispo ();//
// uf_matdispo
//
// St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung aller in ds_loadinglist enthaltenen Packinglists
//
// Unterscheidung nach St$$HEX1$$fc00$$ENDHEX$$cklistentyp (npackinglist_type):
// 
// 1	=	St$$HEX1$$fc00$$ENDHEX$$ckliste
// 2	=	Zeitungsbeladungs-St$$HEX1$$fc00$$ENDHEX$$ckliste
//
// Datastores:
// 
long	i



For i = 1 to ds_loadinglist.RowCount()
	
	
	//
	// Check, ob St$$HEX1$$fc00$$ENDHEX$$ckliste f$$HEX1$$fc00$$ENDHEX$$r den gew$$HEX1$$e400$$ENDHEX$$hlten Tag schon aufgel$$HEX1$$f600$$ENDHEX$$st wurde
	// Wenn von gestern, dann l$$HEX1$$f600$$ENDHEX$$schen
	//
	
	
	
	
	
	
Next



return 0

end function

public function integer uf_reset_for_to_codes ();//
// uf_reset_for_to_codes
//
integer	iLeg = 1
long		i, j, lNext

string	sTouchdown[]

//
// feststellen, wo sich das aktuelle Leg befindet
//


//
// alle Destinations bis zum aktuellen Leg - 1 durchlaufen
// und alle For-To-Code Infos aus ds_loading_list_result
// entfernen.
//
Do While iLeg < iactleg
	i++
	If i > ds_matrix.Rowcount() Then
		exit
	End if	
	iLeg = ds_matrix.GetItemNumber(i,"nleg")
	if iLeg = iactleg then
		exit
	end if
	sTouchdown[iLeg] = ds_matrix.GetItemString(i,"cto")
Loop

For i = 1 to upperbound(sTouchdown)
	lNext = 1
	Do While lNext > 0
		lNext = ds_loadinglist.Find("cen_loadinglists_nfor_to_code > 0 AND sys_three_letter_codes_ctlc = '" + sTouchdown[i] + "'", lNext, ds_loadinglist.RowCount())
			
		if lNext > 0 Then
			ds_loadinglist.SetItem(lNext,"cen_loadinglists_nfor_to_code", 0)
			ds_loadinglist.SetItem(lNext,"sys_three_letter_codes_ctlc", "")
			
			lNext ++
		end if
		
		if lNext > ds_loadinglist.RowCount() Then
			lNext = 0
		end if
	Loop


Next

return 0

end function

public function long uf_delete (datastore dsdeleteon);	long i
	long lDeleted = 0
// -----------------------------------------------
// L$$HEX1$$f600$$ENDHEX$$scht Datens$$HEX1$$e400$$ENDHEX$$tze die nicht ben$$HEX1$$f600$$ENDHEX$$tigt werden.
// -----------------------------------------------
	For i = dsDeleteOn.Rowcount() to 1 Step -1
		 If dsDeleteOn.GetitemNumber(i,"compute_1") > 0 Then
		 	 dsDeleteOn.deleterow(i)
			 lDeleted ++  
	 	 End if	
	Next 	
	
	Return lDeleted
end function

public function s_all_flight_infos uf_get_qaq (s_all_flight_infos sinfo, long lhandling_id);
// --------------------------------------------------------------
// Behandlung QAQ
// --------------------------------------------------------------
	integer 	i
	long		lRow
	string	sFilter,sLoadingText
	
	
	ds_matrix_routingplan_qaq.Retrieve(sInfo.lairline_key, &
												  sInfo.lroutingplan_group_Key, &
												  Date(sInfo.sdeparturedate), &
												  sInfo.cdeparturetime)
												  
												  
	iVerkehrsTag = f_getfrequence(date(sInfo.sdeparturedate))
	sFilter		 = "nleg_number >= " + string(sInfo.lhandling_leg_number) + &
						" and nleg_number <= " + string(sInfo.lroutingplan_leg_number) + &
						" and nfreq" + string(iVerkehrsTag) + "=1 and cen_routingplan_handling_nfreq" + string(iVerkehrsTag) + "=1"
					
	ds_matrix_routingplan_qaq.SetFilter(sFilter)
	ds_matrix_routingplan_qaq.Filter()
// --------------------------------------------------------------
// Jetzt in die Matrix eintragen
// --------------------------------------------------------------
	
	For i = 1 to ds_matrix_routingplan_qaq.RowCount()
		lRow = ds_matrix.InsertRow(0)
		ds_matrix.SetItem(lRow,"nleg",ds_matrix_routingplan_qaq.GetItemNumber(i,"nleg_number"))
		ds_matrix.SetItem(lRow,"nact_leg",sInfo.lroutingplan_leg_number)
		
		ds_matrix.SetItem(lRow,"ssl_zbl_qaq","SI")
		
		ds_matrix.SetItem(lRow,"nkey",ds_matrix_routingplan_qaq.GetItemNumber(i,"nhandling_qaq_key"))
		ds_matrix.SetItem(lRow,"ntyp",ds_matrix_routingplan_qaq.GetItemNumber(i,"nhandling_id"))
		ds_matrix.SetItem(lRow,"nhandlingkey",ds_matrix_routingplan_qaq.GetItemNumber(i,"cen_handling_nhandling_key"))
		
		ds_matrix.SetItem(lRow,"nprio_extern",ds_matrix_routingplan_qaq.GetItemNumber(i,"nprio_extern"))
		ds_matrix.SetItem(lRow,"nprio_intern", ds_matrix_routingplan_qaq.GetItemNumber(i,"nprio_intern"))	
		ds_matrix.SetItem(lRow,"cfrom",ds_matrix_routingplan_qaq.GetItemString(i,"ctlc_from"))
		ds_matrix.SetItem(lRow,"cto",ds_matrix_routingplan_qaq.GetItemString(i,"ctlc_to"))
		sLoadingText 	= ds_matrix_routingplan_qaq.GetItemString(i,"cen_handling_ctext")
	
		If not isnull(sLoadingText) Then
			sInfo.ssi_qaq 	+= '<font color="#3366FF">' + sLoadingText + '</font>' +  "<br>"
		End if		
	Next


	return sInfo
	
	
		
end function

public function s_all_flight_infos uf_check_flightschedule (s_all_flight_infos sinfo);// ------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Flug im Flugplan vorhanden ist.
// ------------------------------------------------------------

	
	DataStore 	ds_FlightSchedule
	integer 		iGMT,iOffset
	string  		sFrequenz
	
	ds_FlightSchedule					= CREATE DataStore
	ds_FlightSchedule.DataObject 	= "dw_flightschedule"							
	ds_FlightSchedule.SetTransObject(SQLCA)
		
	ds_flightschedule.Retrieve(sInfo.lairline_key, &
					long(sInfo.sflightnumber),&
					sInfo.sSuffix,&
					date(sInfo.sdeparturedate),&
					sInfo.sHomeStation)
					
					
	iVerkehrsTag 	= f_getfrequence(date(sInfo.sdeparturedate))
	sFrequenz 		= "nfreq" + string(iVerkehrsTag) + "=1"
	
	ds_flightschedule.SetFilter(sFrequenz)
	ds_flightschedule.Filter()
	
	IF ds_flightschedule.RowCount() <= 0 THEN
		sInfo.sStatus = "Sorry, CBASE found no flight in flightschedule."
		sInfo.iStatus = -1
		return sInfo
	Elseif ds_flightschedule.RowCount() = 1 THEN
		sInfo.cdeparturetime 			= ds_flightschedule.GetItemString(1, "cdeparture_time")
		iGMT									= ds_flightschedule.GetItemNumber(1, "ntime_local_utc")
		iOffset								= ds_flightschedule.GetItemNumber(1, "ndeparture_faktor")
//		sInfo.cdeparturetime				= of_gmt_local_time(sInfo.cdeparturetime,iGMT,iOffset) 
		sInfo.ldefault_aircraft_key	= ds_flightschedule.GetItemNumber(1, "naircraft_key")
		sInfo.lfrom_key					= ds_flightschedule.GetItemNumber(1, "cen_schedule_ntlc_from")
		sInfo.lto_key						= ds_flightschedule.GetItemNumber(1, "cen_schedule_ntlc_to")	
		sInfo.sfrom							= f_check_three_letter_code_id(sInfo.lfrom_key)
		sInfo.sto							= f_check_three_letter_code_id(sInfo.lto_key)
		sInfo.lschedule_leg 				= ds_flightschedule.GetItemNumber(1, "cen_schedule_nleg_number")	
		sInfo.lschedule_index			= ds_flightschedule.GetItemNumber(1, "cen_schedule_definition_nschedule_index")	
		sInfo.sschedule_text				= ds_flightschedule.GetItemString(1, "cen_schedule_definition_ctext")
		sInfo.lschedule_key				= ds_flightschedule.GetItemNumber(1, "cen_schedule_nschedule_key")	
	Else
		sInfo.sStatus = "Sorry, wrong masterdata in flightschedule."
		sInfo.iStatus = -1
		DESTROY ds_flightschedule
		return sInfo
	End if		
	
	
	DESTROY ds_flightschedule
	return sInfo
end function

public function integer uf_retrieveextrastowage ();	Long 		lRow, &
				lINdex, &
				lCnt, &
				lGalleyKey[], &
				lGalley

	Boolean	bNew = true
	
	For lRow = 1 To ds_loadinglist.RowCount()
		If ds_loadinglist.GetItemNumber(lRow, "cen_stowage_npage") = 0 Then
			lGalley = ds_loadinglist.GetItemNumber(lRow, "cen_galley_ngalley_key") 
			For lCnt = 1 to UpperBound(lGalleyKey[])
				if lGalleyKey[lCnt] = lGalley Then
					bNew = False
					exit
				else
					bNew = True
				end if
			Next
			
			if bNew Then
				lIndex 					= UpperBound(lGalleyKey[]) + 1
				lGalleyKey[lIndex] 	= lGalley
			end if
		end if
	Next
	
	
	ds_extra.Retrieve(lGalleyKey[])
		
		
	
	
	return 1
end function

private function integer uf_childstowage (long lrow);	// --------------------------------------------
	// Eintr$$HEX1$$e400$$ENDHEX$$ge mit g$$HEX1$$fc00$$ENDHEX$$ltigen Child-Stauorten
	// werden in die zugeh$$HEX1$$f600$$ENDHEX$$rige 
	// Zeile der SSL $$HEX1$$fc00$$ENDHEX$$bertragen
	// --------------------------------------------
	
	Long		lRowParent
			
	String	sZustautext, &
				sZustautextB, &
				sChildPlace, &
				sGalley, &
				sStowage

	sChildPlace = Trim(ds_loadinglist.GetItemString(lRow, "cen_stowage_cplace"))
	
	if Not isNull(sChildPlace) AND len(sChildPlace) > 0 Then
		if ds_childstowages.Find("cchildplace='" + sChildPlace + "'", 1, ds_childstowages.RowCount()) > 0 Then
			// ------------------------------------------------
			// Hierbei handelt es sich um einen Child-Stauort
			// ------------------------------------------------
			ds_loadinglist.Setitem(lRow,"compute_actioncode",1) 
			
			sZustautext	 = ds_loadinglist.GetItemString(lRow, "cen_packinglists_ctext")
			sZustautextB = ds_loadinglist.GetItemString(lRow, "cen_packinglists_ctext_short")
			sGalley		 = ds_loadinglist.GetItemString(lRow, "cen_galley_cgalley")
			sStowage		 = ds_loadinglist.GetItemString(lRow, "cen_stowage_cstowage")
			
			if Not IsNull(sZustautextB) AND Len(sZustautextB) < Len(sZustautext) Then
				// -------------------------
				// den k$$HEX1$$fc00$$ENDHEX$$rzeren Text nehmen
				// -------------------------
				sZustautext = sZustautextB
			end if
			
			lRowParent = 1
			Do while lRowParent > 0
				lRowParent = ds_loadinglist.Find ("cen_galley_cgalley = '" + sGalley + "' AND " + &
												 "cen_stowage_cstowage = '" + sStowage + "'", &
												 lRowParent, ds_loadinglist.RowCount())
										 
				if lRowParent > 0 AND lRowParent <> lRow Then
					sZustautextB = ds_loadinglist.GetItemString(lRowParent, "compute_ZustauText")
					if isNull(sZustautextB) OR Len(Trim(sZustautextB)) = 0 Then
						ds_loadinglist.SetItem(lRowParent, "compute_ZustauText", sZustautext)
					end if
				end if
				
				if lRowParent > 0 Then
					lRowParent ++
				end if
				
				if lRowParent > ds_loadinglist.RowCount() Then
					lRowParent = 0
				end if
			Loop
		end if
	end if

return 1

end function

public function integer uf_check4documents (s_all_flight_infos sinfo);// ------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob Dokumente vorhanden sind !
// NHANDLING_ID = 4
// ------------------------------------------------------------

	DataStore 	ds_documents
	integer		iRows
	string		sFrequenz,sFilter
	ds_documents					= CREATE DataStore
	ds_documents.DataObject 	= "dw_documents"							
	ds_documents.SetTransObject(SQLCA)
	
	//FRE 21.05.2008: Einschr$$HEX1$$e400$$ENDHEX$$nkung auf ausgew$$HEX1$$e400$$ENDHEX$$hlte Unit	
	ds_documents.Retrieve(sInfo.lroutingplan_key,date(sInfo.sdeparturedate),sInfo.cdeparturetime, sInfo.sUnit)
	iVerkehrsTag = f_getfrequence(date(sInfo.sdeparturedate))
	sFrequenz 	 = "cen_routingplan_nfreq" + string(iVerkehrsTag) + "=1"
// ----------------------------------------------------------------------
// Filter auf Aircrafttyp,Handling,Beladeleg,Originalleg,Frequenz
// ----------------------------------------------------------------------
	sFilter		 =  "nfreq" + string(iVerkehrsTag) + " = 1"
	

	ds_documents.SetFilter(sFilter)
	ds_documents.Filter()
	

	iRows = ds_documents.Rowcount()
	
			
	destroy ds_documents
	return iRows

end function

public function long uf_get_cp_key (s_all_flight_infos sinfo);// ------------------------------------------------------------
// City Pair Key ermitteln
// ------------------------------------------------------------
	string  		sFrequenz
	DataStore 	ds_routingplan
	
	ds_routingplan					= CREATE DataStore
	ds_routingplan.DataObject 	= "dw_routingplan"							
	ds_routingplan.SetTransObject(SQLCA)
	
	iVerkehrsTag 	= f_getfrequence(date(sInfo.sdeparturedate))
	sFrequenz 		= "nfreq"  + string(iVerkehrsTag) + "= 1 and " + &
						  "cen_routingplan_ntlc_to = " + string(sInfo.lto_key)
// ------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Flug im Streckenplan mit CityPair vorhanden ist.
// ------------------------------------------------------------
	ds_routingplan.Retrieve(sInfo.lairline_key, &
					-1,&
					" ",&
					date(sInfo.sdeparturedate),&
					sInfo.sHomeStation)

	ds_routingplan.Setfilter("cen_routingplan_ntlc_from = " + &
						string(sInfo.lfrom_key) + &
						" and cen_routingplan_ntlc_to = " + &
						string(sInfo.lto_key) + " and " + sFrequenz)
	ds_routingplan.Filter()
	
// ------------------------------------------------------------
// Flug ist mit CityPair vorhanden !
// ------------------------------------------------------------	
	if ds_routingplan.RowCount() = 1 Then					
		lRoutingplanKey_CP = ds_routingplan.Getitemnumber(1,"cen_routingplan_nroutingdetail_key")
	Else
		lRoutingplanKey_CP = -1
	End if	
	
	
	DESTROY ds_routingplan
	return lRoutingplanKey_CP



end function

public function s_all_flight_infos uf_check_routingplan (s_all_flight_infos sinfo);// ------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Flug im Streckenplan vorhanden ist.
// Flugnummer oder Citypair ?
// ------------------------------------------------------------
string  		sFrequenz
DataStore 	ds_routingplan

// -------------------------------------------------------------------------
// Routingplan Key f$$HEX1$$fc00$$ENDHEX$$r City Pair wird neuerdings auf jeden Fall ermittelt
// sofern kein Eintrag vorhanden ist, wird lroutingplan_key_cp auf -1 gesetzt.
// -------------------------------------------------------------------------
sinfo.lroutingplan_key_cp = uf_get_cp_key(sinfo)


ds_routingplan					= CREATE DataStore
ds_routingplan.DataObject 	= "dw_routingplan"							
ds_routingplan.SetTransObject(SQLCA)

// ------------------------------------------
// Aus WEB: nicht erkanntes Datum umstellen
// ------------------------------------------
String	ls_Temp
Date		ldt_Departure
ldt_Departure = Date(sInfo.sdeparturedate)
If ldt_Departure = 1900-01-01 then
   //f_log("CCS_TEST", "uo_loading_list.uf_check_routingplan date( sInfo.sdeparturedate)=1900-01-01")
   If s_app.sdateformat = "mm/dd/yyyy" then
      If pos(sInfo.sdeparturedate, "/") > 0 Then
         //mm/dd/yyyy
         ls_Temp = Mid(sInfo.sdeparturedate, 7, 4) + "-" + Left(sInfo.sdeparturedate, 2) + "-" + Mid(sInfo.sdeparturedate, 4, 2)
         ldt_Departure = Date(ls_Temp)
         sInfo.sdeparturedate = String(ldt_Departure)
        // f_log("CCS_TEST", "uo_loading_list.uf_check_routingplan 2ND TRY Date(" + sInfo.sdeparturedate + ")")
      end if
   end if   
end if



ds_routingplan.Retrieve(sInfo.lairline_key, &
				long(sInfo.sflightnumber),&
				sInfo.sSuffix,&
				date(sInfo.sdeparturedate),&
				sInfo.sHomeStation)
					
iVerkehrsTag 	= f_getfrequence(date(sInfo.sdeparturedate))
sFrequenz 		= "nfreq"  + string(iVerkehrsTag) + "= 1 and " + &
					  "cen_routingplan_ntlc_to = " + string(sInfo.lto_key)

ds_routingplan.SetFilter(sFrequenz)
ds_routingplan.Filter()

//Messagebox("", sFrequenz)

// ------------------------------------------------------------
// Flug ist mit Flugnummer vorhanden !
// ------------------------------------------------------------	
Long lCount

if ds_routingplan.RowCount() = 1 Then					
	sInfo.lroutingplan_key 				= ds_routingplan.Getitemnumber(1,"cen_routingplan_nroutingdetail_key")
	sInfo.lroutingplan_leg_number		= ds_routingplan.Getitemnumber(1,"cen_routingplan_nleg_number")
	sInfo.lroutingplan_group_key		= ds_routingplan.Getitemnumber(1,"cen_routingplan_nrouting_group_key")
	sInfo.lroutingplan_index 			= ds_routingplan.Getitemnumber(1,"cen_routingplan_nroutingplan_index")
	sInfo.sroutingplan_text				= ds_routingplan.GetitemString(1,"cen_routingplan_definition_ctext")
	sInfo.scitypair 						= "False"	
	sInfo.lrouting_id						= ds_routingplan.Getitemnumber(1,"cen_routingplan_nrouting_id")
	sInfo.srouting_text					= f_rout_to_string(sInfo.lrouting_id)
	
	//	 ------------------------------------------------------------
	// Jetzt nochmal pr$$HEX1$$fc00$$ENDHEX$$fen, ob die Standardbeladung auch wirklich 
	// $$HEX1$$fc00$$ENDHEX$$ber die Flugnummer definiert ist, wenn nicht, dann nach dem 
	// CityPair suchen
	// ------------------------------------------------------------
	  SELECT count(*)
	  INTO	:lCount
    FROM cen_handling,   
         cen_routingplan_handling,   
         sys_handling_id  
   WHERE ( cen_routingplan_handling.nhandling_key = cen_handling.nhandling_key ) and  
         ( sys_handling_id.nhandling_id = cen_handling.nhandling_id ) and  
         ( ( cen_routingplan_handling.nroutingdetail_key = :sInfo.lroutingplan_key ) AND  
         ( cen_handling.nhandling_id = 1 or cen_handling.nhandling_id = 2));

	if sqlca.sqlcode <> 0 then
		DESTROY ds_routingplan
		return sInfo
	end if
	
	// Messagebox("", lCount)
	
	if lCount > 0 then
		// ------------------------------------------------------------
		// Pr$$HEX1$$fc00$$ENDHEX$$fung ob Dokumente f$$HEX1$$fc00$$ENDHEX$$r diese Flugnummer vorhanden sind.
		// sofern nur Dokumente geholt werden sollen. (sInfo.bdocuments)
		// ------------------------------------------------------------	
		If sInfo.bdocuments	Then
			If uf_check4documents(sInfo) > 0 Then
				DESTROY ds_routingplan
				return sInfo
			Else
				// -------------------------------------
				// Wir probieren das ganze mit City Pair
				// -------------------------------------
			End if
		Else
			DESTROY ds_routingplan
			return sInfo
		End if	
	end if
	
Elseif ds_routingplan.RowCount() > 1 Then
	//MessageBox("", "Treffer: " + string(ds_routingplan.RowCount()))
	//f_print_datastore(ds_routingplan)
	sInfo.sStatus = "Sorry, wrong masterdata in routingplan."
	sInfo.iStatus = -1	
	DESTROY ds_routingplan
	return sInfo
	
End if	


// ------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob der Flug im Streckenplan mit CityPair vorhanden ist.
// ------------------------------------------------------------
ds_routingplan.Retrieve(sInfo.lairline_key, &
				-1,&
				" ",&
				date(sInfo.sdeparturedate),&
				sInfo.sHomeStation)

//Messagebox("Filter ", "Pr$$HEX1$$fc00$$ENDHEX$$fung auf CityPair Ebene~n~nsInfo.lfrom_key:" + string(sInfo.lfrom_key) + "~nsInfo.lto_key: " + string(sInfo.lto_key) + "~n" + sFrequenz)
//f_print_datastore(ds_routingplan)
					
					
ds_routingplan.Setfilter("cen_routingplan_ntlc_from = " + &
					string(sInfo.lfrom_key) + &
					" and cen_routingplan_ntlc_to = " + &
					string(sInfo.lto_key) + " and " + sFrequenz)
ds_routingplan.Filter()

//Messagebox("nach Filter", ds_routingplan.RowCount())

// ------------------------------------------------------------
// Flug ist mit CityPair vorhanden !
// ------------------------------------------------------------	
if ds_routingplan.RowCount() = 1 Then					
	sInfo.lroutingplan_key 				= ds_routingplan.Getitemnumber(1,"cen_routingplan_nroutingdetail_key")
	sInfo.lroutingplan_leg_number		= ds_routingplan.Getitemnumber(1,"cen_routingplan_nleg_number")
	sInfo.lroutingplan_group_key		= ds_routingplan.Getitemnumber(1,"cen_routingplan_nrouting_group_key")
	sInfo.lroutingplan_index 			= ds_routingplan.Getitemnumber(1,"cen_routingplan_nroutingplan_index")
	sInfo.sroutingplan_text				= ds_routingplan.GetitemString(1,"cen_routingplan_definition_ctext")
	sInfo.scitypair 						= "True"	
	sInfo.lrouting_id						= ds_routingplan.Getitemnumber(1,"cen_routingplan_nrouting_id")
	sInfo.srouting_text					= f_rout_to_string(sInfo.lrouting_id)		
	// ------------------------------------------------------------
	// Pr$$HEX1$$fc00$$ENDHEX$$fung ob Dokumente f$$HEX1$$fc00$$ENDHEX$$r diese Flugnummer vorhanden sind.
	// sofern nur Dokumente geholt werden sollen. (sInfo.bdocuments)
	// ------------------------------------------------------------	
	If sInfo.bdocuments	Then
		If uf_check4documents(sInfo) <= 0 Then
			sInfo.sStatus = "Sorry, CBASE found no documents for this flight."
			sInfo.iStatus = -1
			DESTROY ds_routingplan
			return sInfo
		End if	
	End if	
	
	
Elseif ds_routingplan.RowCount() <= 0 Then	
	sInfo.sStatus = "Sorry, CBASE found no flight in routingplan."
	sInfo.iStatus = -1
	DESTROY ds_routingplan
	return sInfo
else	
	sInfo.sStatus = "Sorry, wrong masterdata in routingplan."
	sInfo.iStatus = -1
	DESTROY ds_routingplan
	return sInfo
End if	


DESTROY ds_routingplan
return sInfo


return sinfo
end function

public function integer uf_add_areas (datetime dtdeparture);//
// uf_add_areas
//
// Hier werden der fertigen Beladung die Bereiche zugespielt.
// Dabei gilt zun$$HEX1$$e400$$ENDHEX$$chst: Je Bereich ein Label
//
long	 	i, &
			j, &
			k, &
			lkey, &
			lPL_Keys[], &
			lLabel_type_key, &
			lType, &
			lPrint, &
			lQuantity
		

string	sCode, &
			sRepository, &
			sAdd_on_text, &
			sText

ds_areas_local.SetTransObject(SQLCA)
ds_areas_default.SetTransObject(SQLCA)

Datastore	ds_temp

ds_temp = Create Datastore
ds_temp.DataObject = 'dw_loading_list_result'

// ---------------------------------------------
// Erstellen Number Array
// und wenn wir schon mal am
// duchlaufen sind dann packen wir
// auch gleich die Mengen zu den Texten
// ---------------------------------------------
For i = 1 to ds_loadinglist.RowCount()
	
	lPL_Keys[i] = ds_loadinglist.GetItemNumber(i,"cen_packinglist_index_npackinglist_index_key")
	lQuantity = ds_loadinglist.GetItemNumber(i,"cen_loadinglists_nquantity")
		
	if lQuantity > 1 then
		ds_loadinglist.SetItem(i,"cen_packinglists_ctext_short", string(lQuantity) + " x " + ds_loadinglist.GetItemString(i,"cen_packinglists_ctext_short"))
		ds_loadinglist.SetItem(i,"cen_packinglists_ctext", string(lQuantity) + " x " + ds_loadinglist.GetItemString(i,"cen_packinglists_ctext"))
	end if
	
Next 

//Messagebox("", "Anzahl Keys: " + string(lPL_Keys))

// ---------------------------------------------
// Check, ob lokale Daten vorhanden sind
// ---------------------------------------------

//Messagebox("", sUnit)
//return -1

ds_areas_local.Retrieve(lPL_Keys,sUnit,sMandant, dtDeparture)
//ds_areas_local.saveas("e:\inetpub\ds_areas_local.xls", Excel5!, true)

if ds_areas_local.RowCount() > 0 then
	// ---------------------------------------------
	// Lokal
	// ---------------------------------------------
	For j = 1 to ds_loadinglist.RowCount()
		
		ds_loadinglist.RowsCopy(j,j,Primary!,ds_temp,ds_temp.RowCount() + 1,Primary!)
		ds_temp.SetItem(ds_temp.RowCount(),"carea_code","")  // Bereichsbezeichnung blank setzen
		
		lKey = ds_loadinglist.GetItemNumber(j,"cen_packinglist_index_npackinglist_index_key")
		ds_areas_local.SetFilter("loc_packinglist_areas_npackinglist_index = " + string(lKey))
		ds_areas_local.Filter()
		
		//if ds_areas_local.RowCount() > 0 then
		//	MessageBox("Hier ist was",ds_areas_local.GetItemString(1,"loc_areas_ccode") + ", key=" + string(lKey))
		//end if
								
		For k = 1 to ds_areas_local.RowCount()
			sCode					= ds_areas_local.GetItemString(k,"loc_areas_ccode")
			sRepository			= ds_areas_local.GetItemString(k,"loc_packinglist_areas_crepository")
			sAdd_on_text		= ds_areas_local.GetItemString(k,"loc_packinglist_areas_cadd_on_text")
			sText					= ds_areas_local.GetItemString(k,"loc_packinglist_areas_ctext")
			lLabel_type_key 	= ds_areas_local.GetItemNumber(k,"nlabel_type_key")
			lType					= ds_areas_local.GetItemNumber(k,"ntype")  /// 0=Masterlabel, 1=Dupliziertes Label
			lPrint 				= ds_areas_local.GetItemNumber(k,"nprint")  
			
			if sCode = "(none)" then
				sCode = ""
			end if
			
			
			if k > 1 then
				ds_loadinglist.RowsCopy(j,j,Primary!,ds_temp,ds_temp.RowCount() + 1,Primary!)
			end if
			
			// --------------------------------------------------------------
			// Bereiche setzen
			// --------------------------------------------------------------
			ds_temp.SetItem(ds_temp.RowCount(),"carea_code",sCode)  // Bereichsbezeichnung
			ds_temp.SetItem(ds_temp.RowCount(),"cen_packinglists_nlabel_type_key", lLabel_type_key) // Labeltype
			ds_temp.SetItem(ds_temp.RowCount(),"nlabel_type", lType)  // Master oder dupliziertes Label
			ds_temp.SetItem(ds_temp.RowCount(),"nprint", lPrint)  // Druck on-off

			// --------------------------------------------------------------
			// Nur wenn es ein dupliziertes Label ist
			// dann Texte tauschen
			// --------------------------------------------------------------
			if lType = 1 then			
				if len(trim(sText)) > 0 or not isnull(sText) then
					ds_temp.SetItem(ds_temp.RowCount() ,"cen_packinglists_ctext",sText)
					ds_temp.SetItem(ds_temp.RowCount() ,"cen_packinglists_ctext_short",sText)
				end if
				ds_temp.SetItem(ds_temp.RowCount() ,"cen_loadinglists_cadd_on_text",sAdd_on_text)
	
				if len(trim(sRepository)) > 0 or not isnull(sRepository) then
					ds_temp.SetItem(ds_temp.RowCount() ,"cen_packinglists_cunit",sRepository)
				end if
			end if

		Next
	Next
	// --------------------------------------------------------------
	// Tempor$$HEX1$$e400$$ENDHEX$$rer Datastore zur$$HEX1$$fc00$$ENDHEX$$ckkopieren
	// --------------------------------------------------------------
	ds_loadinglist.Reset()
	ds_temp.RowsCopy(1,ds_temp.RowCount(),Primary!,ds_loadinglist,1,Primary!)
	
else
	// --------------------------------------------------------------
	// Zentral
	// --------------------------------------------------------------
	ds_areas_default.Retrieve(lPL_Keys, dtdeparturedate)
	For j = 1 to ds_loadinglist.RowCount()
		
		ds_loadinglist.RowsCopy(j,j,Primary!,ds_temp,ds_temp.RowCount() + 1,Primary!)
		
		lKey = ds_loadinglist.GetItemNumber(j,"cen_packinglist_index_npackinglist_index_key")
		ds_areas_default.SetFilter("cen_packinglist_areas_npackinglist_index = " + string(lKey))
		ds_areas_default.Filter()
		
		//if ds_areas_default.RowCount() > 0 then
		//	MessageBox("Hier ist was",ds_areas_default.GetItemString(1,"loc_areas_ccode") + ", key=" + string(lKey))
		//end if
		
		For k = 1 to ds_areas_default.RowCount()
			sCode				= ds_areas_default.GetItemString(k,"sys_areas_ccode_uk")
			
			if k > 1 then
				ds_loadinglist.RowsCopy(j,j,Primary!,ds_temp,ds_temp.RowCount() + 1,Primary!)
			end if
			
			// --------------------------------------------------------------
			// Bereiche setzen
			// --------------------------------------------------------------
			ds_temp.SetItem(ds_temp.RowCount(),"carea_code",sCode)
			
			//--------------------------------------------------------------
			// Nach dem ersten Datensatz raus aus der Schleife
			//
			// Nur den ersten Bereich eintragen
			// solange der Default Bereich nicht 
			// verf$$HEX1$$fc00$$ENDHEX$$gbar ist
			//--------------------------------------------------------------
			exit
			
		Next
	Next
	// --------------------------------------------------------------
	// Tempor$$HEX1$$e400$$ENDHEX$$rer Datastore zur$$HEX1$$fc00$$ENDHEX$$ckkopieren
	// --------------------------------------------------------------
	ds_loadinglist.Reset()
	ds_temp.RowsCopy(1,ds_temp.RowCount(),Primary!,ds_loadinglist,1,Primary!)


end if

Destroy ds_temp

return 0

end function

public function integer uf_add_workstations (datetime dtdeparture);Datastore	ds_temp
Long 			i, j, k, l, &
				lPL_Keys[], &
				lQuantity

Long 		lKey, lLabelTypeKey , lPrint, lType, lLabelQuantity
String	sText, sArea, sWorkStation, sAddOnText

ds_temp = Create Datastore
//ds_temp.DataObject = 'dw_loading_list_result'
ds_temp.DataObject = this.ds_loadinglist.dataobject

ds_workstations.SetTransObject(sqlca)

long l1, l1_1, l2, l2_2, l3, l3_3

// ---------------------------------------------
// Erstellen Number Array
// und wenn wir schon mal am
// duchlaufen sind dann packen wir
// auch gleich die Mengen zu den Texten
// ---------------------------------------------
For i = 1 to ds_loadinglist.RowCount()
	
	lPL_Keys[i] = ds_loadinglist.GetItemNumber(i,"cen_packinglist_index_npackinglist_index_key")
	ds_loadinglist.SetItem(i,"carea", "")  
	ds_loadinglist.SetItem(i,"cworkstation", "")  
		
//	lQuantity = ds_loadinglist.GetItemNumber(i,"cen_loadinglists_nquantity")	
//	if lQuantity > 1 then
//		ds_loadinglist.SetItem(i,"cen_packinglists_ctext_short", string(lQuantity) + " x " + ds_loadinglist.GetItemString(i,"cen_packinglists_ctext_short"))
//		ds_loadinglist.SetItem(i,"cen_packinglists_ctext", string(lQuantity) + " x " + ds_loadinglist.GetItemString(i,"cen_packinglists_ctext"))
//		
//		ds_loadinglist.SetItem(i,"carea", "")  
//		ds_loadinglist.SetItem(i,"cworkstation", "")  
//	end if
	
Next 

ds_workstations.retrieve(this.sMandant, this.sUnit, lPL_Keys, dtDeparture)

if ds_workstations.RowCount() > 0 then
	
	// ---------------------------------------------
	// Lokal
	// ---------------------------------------------
	For j = 1 to ds_loadinglist.RowCount()
		ds_loadinglist.RowsCopy(j,j,Primary!,ds_temp,ds_temp.RowCount() + 1,Primary!)
		ds_temp.SetItem(ds_temp.RowCount(),"carea_code","")  // Bereichsbezeichnung blank setzen
		
		// --------------------------------------------
		// Die PL aus der Beladung in der lokalen
		// Bereichszuordnung rausfiltern
		// --------------------------------------------
		lKey = ds_loadinglist.GetItemNumber(j,"cen_packinglist_index_npackinglist_index_key")
		ds_workstations.SetFilter("npackinglist_index_key = " + string(lKey))
		ds_workstations.Filter()
		

		For k = 1 to ds_workstations.RowCount()
			
			sArea 				= ds_workstations.GetItemString(k,"carea")
			sWorkStation 		= ds_workstations.GetItemString(k,"cworkstation")
			lLabelTypeKey 		= ds_workstations.GetItemNumber(k,"nlabel_type_key")
			lLabelQuantity    = ds_workstations.GetItemNumber(k,"nquantity")
			sAddOnText			= ds_workstations.GetItemString(k,"loc_unit_pl_flight_label_ctext")
			sText					= ds_workstations.GetItemString(k,"loc_unit_pl_flight_label_ctext2")
			lType					= 0  /// 0=Masterlabel, 1=Dupliziertes Label
			lPrint 				= ds_workstations.GetItemNumber(k,"nlabel_print")  
			
			if k > 1 then
				ds_loadinglist.RowsCopy(j,j,Primary!,ds_temp,ds_temp.RowCount() + 1,Primary!)
				lType = 1  /// 0=Masterlabel, 1=Dupliziertes Label
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
	
			// --------------------------------------------------------------
			// Nur wenn es ein dupliziertes Label ist
			// den AddOn Text tauschen
			// --------------------------------------------------------------
			if lType = 1 then			
				
				if len(trim(sAddOnText)) > 0 or not isnull(sAddOnText) then
						ds_temp.SetItem(ds_temp.RowCount() ,"cen_loadinglists_cadd_on_text",sAddOnText)
				end if
				
			end if
			
			// --------------------------------------------------------------
			// Ganz zum Schluss dann entweder 1 Label mit der Menge oder
			// n - Label gem. der Menge aus der SSL erstellen
			//
			// lLabelQuantity = 1 = 1 Label
			// lLabelQuantity = 2 = Anzahl Label gem. Menge der St$$HEX1$$fc00$$ENDHEX$$ckliste
			// --------------------------------------------------------------
			if ds_temp.RowCount() = 0 then continue
			lQuantity = ds_temp.GetItemNumber(ds_temp.RowCount(),"cen_loadinglists_nquantity")	
																					
			if lLabelQuantity = 1 then			
				//lQuantity = ds_loadinglist.GetItemNumber(j,"cen_loadinglists_nquantity")
				ds_temp.SetItem(ds_temp.RowCount(),"cen_packinglists_ctext_short", String(lQuantity) + " x " + ds_temp.GetItemString(ds_temp.RowCount(),"cen_packinglists_ctext_short"))
				ds_temp.SetItem(ds_temp.RowCount(),"cen_packinglists_ctext", String(lQuantity) + " x " +  ds_temp.GetItemString(ds_temp.RowCount(),"cen_packinglists_ctext"))
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
	ds_loadinglist.Reset()
	ds_temp.RowsCopy(1,ds_temp.RowCount(),Primary!,ds_loadinglist,1,Primary!)
	//f_print_datastore(ds_loadinglist)

end if

return 0
end function

public function integer uf_save_results ();//
// uf_save_results
//
// Speichert den Result-Datastore ds_loadinglist in die Datenbank
// f$$HEX1$$fc00$$ENDHEX$$r die Weiterverarbeitung durch die MATDISPO
//
// Object Property lResult_key (Key f$$HEX1$$fc00$$ENDHEX$$r cen_outbound) wird von au$$HEX1$$df00$$ENDHEX$$en gesetzt
//
// Da der Datastore bereits sortiert ist, wird die Variable i als nprio gesetzt.
//
// npl_type = 1 (normale St$$HEX1$$fc00$$ENDHEX$$cklisten)
// npl_detail_key
//
// offen:
//	Haben wir einen Handling-Key?
// Class-Number ist unbekannt, "C/M"-Problem
// Gewicht unbekannt
//
long 		i
long		lSequence

boolean	bOK = true

//
// Host Variablen
//
long		lLoading_key
long		lLoadinglist_type
long		lLoadinglist_index_key
long		lBelly
long		lPackinglist_index_key
long		lPackinglist_detail_key
long		lquantity_pl
long		lquantity_label
long		llabel_type
long		lTransaction
long		lHandling_key

decimal	dcStowage_weight

string	sActioncode
string	sActioncode_qaq
string	sFor_to
string	sFor_tcl
string	sSi_codes
string	sLoadinglist
string	sGalley
string	sStowage
string	sPlace
string	sAdd_on_text
string	sMeal_control_code
string	sPackinglist
string	sPL_Unit
string	sPL_text
string	sPL_text_short
string	sClass
string	sClassname
string	sAdd_text
string	sArea_code

integer	iPrint_label
integer	iStationinstruction

datetime	dtTimestamp


//
// Flug aus Tagesflugplan feststellen, um nresult_key setzen zu k$$HEX1$$f600$$ENDHEX$$nnen
// (kann aber schon von au$$HEX1$$df00$$ENDHEX$$en gesetzt sein)
//
//MessageBox("uf_save_results",ds_loadinglist.RowCount())

//
// Check lresultkey
//
if lresultkey = 0 or isnull(lresultkey) then
	select nresult_key, ntransaction
	  into :lresultkey, :lTransaction
	  from cen_out
	 where nairline_key		= :lAirlineKey
	   and nflight_number	= :iFlightNo
		and csuffix				= :sSuffix
		and ddeparture			= :dtDepartureDate;
	
	if sqlca.sqlcode <> 0 then
		sErrorText = "Could not find flight in cen_out."	
		return -1
	end if
end if

//MessageBox("ds_loadinglist.RowCount()", ds_loadinglist.RowCount())

//
// Falls schon Daten mit diesem Result-Key in cen_outbound_loading,
// dann diese l$$HEX1$$f600$$ENDHEX$$schen (aber nur die St$$HEX1$$fc00$$ENDHEX$$cklisten, nicht die Zeitungen)
//
delete from cen_out_ll
 where nresult_key 	= :lresultkey
   and npl_type		= 1;

if sqlca.sqlcode <> 0 then
	sErrorText = "Could not delete old loading."	
	//MessageBox("Error delete cen_outbound_loading",sqlca.sqlerrtext)
	return -1
end if



//
// ds_loadinglist durchlaufen, Daten in DB speichern
//
for i = 1 to ds_loadinglist.RowCount()
	
	//
	// Hostvariablen f$$HEX1$$fc00$$ENDHEX$$llen
	//
	lSequence = f_Sequence("seq_cen_out_ll", sqlca)
	if lSequence = -1 Then
		// -----------------------------------------
		// Messagebox muss noch getauscht werden!!!
		// -----------------------------------------
		//beep(1)
		//uf.MBox ("Datenbankfehler", "Es konnte kein eindeutiger Schl$$HEX1$$fc00$$ENDHEX$$ssel (Sequence) ermittelt werden.~r~r" + &
		//									 "Keine Neuanlage m$$HEX1$$f600$$ENDHEX$$glich.", StopSign!)
		sErrorText = "Could not assign sequence for cen_out_ll."	
		return -1
	end if

	lLoading_key				= lSequence
	lLoadinglist_type			= ds_loadinglist.GetItemNumber(i,"cen_loadinglist_index_nloadinglist_key")
	lLoadinglist_index_key	= ds_loadinglist.GetItemNumber(i,"cen_loadinglist_index_nloadinglist_index_key")
	lBelly						= ds_loadinglist.GetItemNumber(i,"cen_loadinglists_nbelly_container")
	lPackinglist_index_key	= ds_loadinglist.GetItemNumber(i,"cen_packinglist_index_npackinglist_index_key")
	lquantity_pl				= ds_loadinglist.GetItemNumber(i,"cen_loadinglists_nquantity")
	// Ist das die Anzahl zu druckender Label?
	lquantity_label			= ds_loadinglist.GetItemNumber(i,"compute_labelprinting")
	// Achtung: es gibt 2 Felder Labeltype : cen_packinglists_nlabel_type_key und nlabel_type
	// Welchen nehmen?
	llabel_type					= ds_loadinglist.GetItemNumber(i,"nlabel_type")
	lPackinglist_detail_key = ds_loadinglist.GetItemNumber(i,"cen_packinglists_npackinglist_detail_key")
	
	sActioncode			= ds_loadinglist.GetItemString(i,"cen_loadinglists_cactioncode")
	sActioncode_qaq	= ds_loadinglist.GetItemString(i,"compute_qaq_actioncode")
	sFor_to				= ds_loadinglist.GetItemString(i,"compute_6")
	sFor_tcl				= ds_loadinglist.GetItemString(i,"sys_three_letter_codes_ctlc")
	sSi_codes			= ds_loadinglist.GetItemString(i,"compute_sicodes")
	sLoadinglist		= ds_loadinglist.GetItemString(i,"cen_loadinglist_index_cloadinglist")
	sGalley				= ds_loadinglist.GetItemString(i,"cen_galley_cgalley")
	sStowage				= ds_loadinglist.GetItemString(i,"cen_stowage_cstowage")
	sPlace				= ds_loadinglist.GetItemString(i,"cen_stowage_cplace")
	sAdd_on_text		= ds_loadinglist.GetItemString(i,"cen_loadinglists_cadd_on_text")
	sMeal_control_code	= ds_loadinglist.GetItemString(i,"cen_loadinglists_cmeal_control_code")
	sPackinglist		= ds_loadinglist.GetItemString(i,"cen_packinglist_index_cpackinglist")
	sPL_Unit				= ds_loadinglist.GetItemString(i,"cen_packinglists_cunit")
	sPL_text				= ds_loadinglist.GetItemString(i,"cen_packinglists_ctext")
	sPL_text_short		= ds_loadinglist.GetItemString(i,"cen_packinglists_ctext_short")
	sClass				= ds_loadinglist.GetItemString(i,"cen_loadinglists_cclass")
	sClassname			= ds_loadinglist.GetItemString(i,"compute_classname")
	sAdd_text			= ds_loadinglist.GetItemString(i,"compute_zustautext")
	sArea_code			= ds_loadinglist.GetItemString(i,"carea_code")						// Produktionsbereich f$$HEX1$$fc00$$ENDHEX$$r Labeldruck
	
	iPrint_label			= ds_loadinglist.GetItemNumber(i,"nprint")
	iStationinstruction	= ds_loadinglist.GetItemNumber(i,"stationinstruction")
	
	dtTimestamp = datetime(today(), now())
	
	lHandling_key = 1
	
	//
	// insert into cen_out_ll...
	//
	insert into cen_out_ll
		(	ndetail_key,
			ntransaction,
			nresult_key,
			nhandling_id,
			nhandling_key,
			nll_index_key,
			cloadinglist,
			npl_type,
			npl_index_key,
			npl_detail_key,
			cpackinglist,
			ctext,
			cadd_on_text,
			cunit,
			nclass_number,
			cclass,
			nquantity,
			nweight,
			cactioncode,
			nlabel_type_key,
			cmeal_control_code,
			cmeal_control_code2,
			cmeal_control_code3,
			cgalley,
			cstowage,
			cplace,
			nbelly,
			ngalley_sort,
			nstowage_sort,
			npl_sort,
			nprio,
			dtimestamp,
			nstatus,
			naction,
			nexplosion_level,
			nparent_result_key
		)
		values
		(	:lSequence,
			:lTransaction,
			:lResultkey,
			2,
			:lHandling_key,
			:lLoadinglist_index_key,
			:sLoadinglist,
			1,
			:lPackinglist_index_key,
			:lPackinglist_detail_key,
			:sPackinglist,
			:sPL_text,
			:sAdd_on_text,
			:sPL_Unit,
			0,
			:sClass,
			:lquantity_pl,
			0,
			:sActioncode,
			:llabel_type,
			:sMeal_control_code,
			'', '',
			:sGalley,
			:sStowage,
			:sPlace,
			:lBelly,
			0,
			0,
			:i,
			:i,
			:dtTimestamp,
			0,
			1,1,0
		);
	
	if sqlca.sqlcode <> 0 then
		bOK = false
	end if

next

if bOK = true then
	commit;
else
	sErrorText = "Could not generate loading."
	rollback;
end if



return 0

end function

public function integer uf_save_results_master ();//
// uf_save_results_master
//
// Ge$$HEX1$$e400$$ENDHEX$$ndert auf cen_out_master
//
// Speichert den Result-Datastore ds_loadinglist in die Datenbank
// f$$HEX1$$fc00$$ENDHEX$$r die Weiterverarbeitung durch die MATDISPO
//
// Object Property lResult_key (Key f$$HEX1$$fc00$$ENDHEX$$r cen_outbound) wird von au$$HEX1$$df00$$ENDHEX$$en gesetzt
//
// Da der Datastore bereits sortiert ist, wird die Variable i als nprio gesetzt.
//
// npl_type = 1 (normale St$$HEX1$$fc00$$ENDHEX$$cklisten)
// npl_detail_key
//
// offen:
// Kumulierung nach Packinglist
//
long 		i
longlong	lSequence

boolean	bOK = true

//
// Host Variablen
//
long		lLoading_key
long		lLoadinglist_type
long		lLoadinglist_index_key
long		lBelly
long		lPackinglist_index_key
long		lPackinglist_detail_key
long		lquantity_pl
long		lquantity_label
long		llabel_type
long		lTransaction
long		lHandling_key

decimal	dcStowage_weight

string	sActioncode
string	sActioncode_qaq
string	sFor_to
string	sFor_tcl
string	sSi_codes
string	sLoadinglist
string	sGalley
string	sStowage
string	sPlace
string	sAdd_on_text
string	sMeal_control_code
string	sPackinglist
string	sPL_Unit
string	sPL_text
string	sPL_text_short
string	sClass
string	sClassname
string	sAdd_text
string	sArea_code

integer	iPrint_label
integer	iStationinstruction

datetime	dtTimestamp


//
// Flug aus Tagesflugplan feststellen, um nresult_key setzen zu k$$HEX1$$f600$$ENDHEX$$nnen
// (kann aber schon von au$$HEX1$$df00$$ENDHEX$$en gesetzt sein)
//
//MessageBox("uf_save_results",ds_loadinglist.RowCount())

//
// Check lresultkey
//
if lresultkey = 0 or isnull(lresultkey) then
	select nresult_key, ntransaction
	  into :lresultkey, :lTransaction
	  from cen_out
	 where nairline_key		= :lAirlineKey
	   and nflight_number	= :iFlightNo
		and csuffix				= :sSuffix
		and ddeparture			= :dtDepartureDate;
	
	if sqlca.sqlcode <> 0 then
		sErrorText = "Could not find flight in cen_out."	
		return -1
	end if
end if

//MessageBox("ds_loadinglist.RowCount()", ds_loadinglist.RowCount())

//
// Falls schon Daten mit diesem Result-Key in cen_outbound_loading,
// dann diese l$$HEX1$$f600$$ENDHEX$$schen (aber nur die St$$HEX1$$fc00$$ENDHEX$$cklisten, nicht die Zeitungen)
//
delete from cen_out_master
 where nresult_key 	= :lresultkey
   and npl_type		= 1;

if sqlca.sqlcode <> 0 then
	sErrorText = "Could not delete old loading."	
	//MessageBox("Error delete cen_outbound_loading",sqlca.sqlerrtext)
	return -1
end if



//
// ds_loadinglist durchlaufen, Daten in DB speichern
//
for i = 1 to ds_loadinglist.RowCount()
	
	//
	// Hostvariablen f$$HEX1$$fc00$$ENDHEX$$llen
	//
	lSequence = f_Sequence_ll("seq_cen_out_master", sqlca)
	if lSequence = -1 Then
		// -----------------------------------------
		// Messagebox muss noch getauscht werden!!!
		// -----------------------------------------
		//beep(1)
		//uf.MBox ("Datenbankfehler", "Es konnte kein eindeutiger Schl$$HEX1$$fc00$$ENDHEX$$ssel (Sequence) ermittelt werden.~r~r" + &
		//									 "Keine Neuanlage m$$HEX1$$f600$$ENDHEX$$glich.", StopSign!)
		sErrorText = "Could not assign sequence for cen_out_master."	
		return -1
	end if

	lPackinglist_index_key	= ds_loadinglist.GetItemNumber(i,"cen_packinglist_index_npackinglist_index_key")
	lPackinglist_detail_key = ds_loadinglist.GetItemNumber(i,"cen_packinglists_npackinglist_detail_key")
	sPackinglist		= ds_loadinglist.GetItemString(i,"cen_packinglist_index_cpackinglist")
	sPL_text				= ds_loadinglist.GetItemString(i,"cen_packinglists_ctext")
	sPL_Unit				= ds_loadinglist.GetItemString(i,"cen_packinglists_cunit")
	lquantity_pl		= ds_loadinglist.GetItemNumber(i,"cen_loadinglists_nquantity")

	//	lLoading_key				= lSequence
	//	lLoadinglist_type			= ds_loadinglist.GetItemNumber(i,"cen_loadinglist_index_nloadinglist_key")
	//	lLoadinglist_index_key	= ds_loadinglist.GetItemNumber(i,"cen_loadinglist_index_nloadinglist_index_key")
	//	lBelly						= ds_loadinglist.GetItemNumber(i,"cen_loadinglists_nbelly_container")
	//	// Ist das die Anzahl zu druckender Label?
	//	lquantity_label			= ds_loadinglist.GetItemNumber(i,"compute_labelprinting")
	//	// Achtung: es gibt 2 Felder Labeltype : cen_packinglists_nlabel_type_key und nlabel_type
	//	// Welchen nehmen?
	//	llabel_type					= ds_loadinglist.GetItemNumber(i,"nlabel_type")
	//	
	//	sActioncode			= ds_loadinglist.GetItemString(i,"cen_loadinglists_cactioncode")
	//	sActioncode_qaq	= ds_loadinglist.GetItemString(i,"compute_qaq_actioncode")
	//	sFor_to				= ds_loadinglist.GetItemString(i,"compute_6")
	//	sFor_tcl				= ds_loadinglist.GetItemString(i,"sys_three_letter_codes_ctlc")
	//	sSi_codes			= ds_loadinglist.GetItemString(i,"compute_sicodes")
	//	sLoadinglist		= ds_loadinglist.GetItemString(i,"cen_loadinglist_index_cloadinglist")
	//	sGalley				= ds_loadinglist.GetItemString(i,"cen_galley_cgalley")
	//	sStowage				= ds_loadinglist.GetItemString(i,"cen_stowage_cstowage")
	//	sPlace				= ds_loadinglist.GetItemString(i,"cen_stowage_cplace")
	//	sAdd_on_text		= ds_loadinglist.GetItemString(i,"cen_loadinglists_cadd_on_text")
	//	sMeal_control_code	= ds_loadinglist.GetItemString(i,"cen_loadinglists_cmeal_control_code")
	//	sPL_text_short		= ds_loadinglist.GetItemString(i,"cen_packinglists_ctext_short")
	//	sClass				= ds_loadinglist.GetItemString(i,"cen_loadinglists_cclass")
	//	sClassname			= ds_loadinglist.GetItemString(i,"compute_classname")
	//	sAdd_text			= ds_loadinglist.GetItemString(i,"compute_zustautext")
	//	sArea_code			= ds_loadinglist.GetItemString(i,"carea_code")						// Produktionsbereich f$$HEX1$$fc00$$ENDHEX$$r Labeldruck
	//	
	//	iPrint_label			= ds_loadinglist.GetItemNumber(i,"nprint")
	//	iStationinstruction	= ds_loadinglist.GetItemNumber(i,"stationinstruction")
	
	dtTimestamp = datetime(today(), now())
	
	lHandling_key = 1
	
	//
	// insert into cen_out_ll...
	//
	insert into cen_out_master
		(	ndetail_key,
			ntransaction,
			nresult_key,
			npl_type,
			npl_index_key,
			npl_detail_key,
			cpackinglist,
			ctext,
			cunit,
			nquantity,
			naction,
			dtimestamp,
			nstatus
		)
		values
		(	:lSequence,
			:lTransaction,
			:lResultkey,
			1,
			:lPackinglist_index_key,
			:lPackinglist_detail_key,
			:sPackinglist,
			:sPL_text,
			:sPL_Unit,
			:lquantity_pl,
			1,
			:dtTimestamp,
			0
		);
	
	if sqlca.sqlcode <> 0 then
		bOK = false
	end if

next

if bOK = true then
	commit;
else
	sErrorText = "Could not generate loading."
	rollback;
	return -1
end if



return 0

end function

public function s_all_flight_infos uf_generate_data (s_all_flight_infos sinfo);Long		lRow
String	sTemp
Integer	iLeg, iLegPrev, iRet

// --------------------------------------------------------------
// Vorinitialisieren
// --------------------------------------------------------------	
bPDFStream			= BLOB("")
bLabelStream		= BLOB("")
sLLFooter			= ""

// ----------------------------------------------------------------------------
// Wir erstellen die Beladematrix, Fehlercode wird nur bei Fluglabel verwendet
// ----------------------------------------------------------------------------
sInfo = uf_matrix(sInfo)
if sInfo.iStatus = -1 and iPrintFlightLabel = 1 Then
	return sInfo
Else
	sInfo.iStatus 	= 0
	sErrortext		= ""
	sInfo.sStatus 	= sErrortext
end if
	

// ----------------------------------------
// Wir Retrieven
// ----------------------------------------
if uf_retrieve() = -1 Then
	sInfo.sStatus = sErrortext
	sInfo.iStatus = -1
	return sInfo
end if
	
// ----------------------------------------
// Die Farbinfos
// ----------------------------------------
uf_add_color_text()

// ----------------------------------------
// Wir spielen die Bereiche dazu
// ----------------------------------------
if this.sWhereamI <> "PB" then
	if uf_add_areas(DateTime(Date(sInfo.sDepartureDate))) = -1 then
		sInfo.sStatus = sErrortext
		sInfo.iStatus = -1
		return sInfo
	end if
	
else
	// --------------------------------------
	// Neu:
	// Zuspielen der Bereiche gem. der 
	// Zuordnung aus der Client Appl.
	// --------------------------------------
	
	//
	// Achtung: Anpassung notwendig, sonst wird versucht einer Newspaper PL
	// ein "normaler" Bereich zuzuspielen
	//
	if uf_add_workstations(DateTime(Date(sInfo.sDepartureDate))) = -1 then
		sInfo.sStatus = sErrortext
		sInfo.iStatus = -1
		return sInfo
	end if

end if
	
// ----------------------------------------
// Wir filtern die Label
// ----------------------------------------	
uf_label_check()

// -----------------------
// K$$HEX1$$f600$$ENDHEX$$nnen wir drucken, 
// wenn JA los
// -----------------------
//	IF not uf_isprintpossible() THEN 
//		sInfo.sStatus = sErrortext
//		sInfo.iStatus = -1
//		return sInfo
//	end if

// -----------------------
// wir generieren 
// -----------------------
// sInfo = uf_print_label(sInfo)
	
		
return sInfo
	
end function

public function s_all_flight_infos uf_matrix (s_all_flight_infos sinfo);// -------------------------------------------
// Hier werden alle Beladungen eines Fluges auf-
// bereitet. Es sind alle Infos der einzelnen
// Legs vorhanden.
//
// Neu: bUseCenOut -> Tagesflugplan ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
// -------------------------------------------
String		sFilterVerkehr,sDepartureTime
Long			i, lRow, lRows

// -----------------------------------------------
// Vorbereitung und setzen der Variabeln
// -----------------------------------------------
sDepartureTime = sInfo.cdeparturetime
iVerkehrsTag 	= f_getfrequence(Date(sInfo.sdeparturedate))
sFilterVerkehr = "nfreq" + STRING(iVerkehrsTag) + "=1"
sAirlineCode	= sInfo.sairline
lAircraftKey	= sInfo.laircraft_key
sAircraftType	= sInfo.sactype
sOwnerCode		= sInfo.sowner
lOwnerKey		= sInfo.lownerKey
sGalleyVersion	= sInfo.sgalleyversion
lHandlingKey	= sInfo.lhandling_key

// -----------------------------------------------
// sofern lResultKey > 0 ist wurde der Datastore 
// ds_matrix vom aufrufendem Objekt gef$$HEX1$$fc00$$ENDHEX$$llt.
// -----------------------------------------------
If isnull(lResultKey) or lResultKey <= 0 Then
	ds_matrix.Reset()
// -----------------------------------------------
// Loading Lists
// -----------------------------------------------
	sInfo.sloadinglist 	= ""
	sinfo = uf_get_handling_by_id(sInfo,1)
	if ds_matrix.rowcount() <= 0 Then
		sInfo.sStatus = "Sorry, CBASE doesn't find a basic loading for this flight."
		sInfo.iStatus = -1
		return sInfo
	end if	
// -----------------------------------------------
// Supplement Loading Lists
// -----------------------------------------------
	sinfo = uf_get_handling_by_id(sInfo,2)	
// -----------------------------------------------
// SI QAQ
// -----------------------------------------------
	sinfo = uf_get_qaq(sInfo,3)	
End if

ds_matrix.SetSort("nleg A, nprio_extern A, nprio_intern A")
ds_matrix.Sort()
iActLeg = sInfo.lroutingplan_leg_number

//f_print_datastore(ds_matrix)


return sInfo

end function

public function s_all_flight_infos uf_get_handling_by_id (s_all_flight_infos sinfo, long lhandling_id);// -----------------------------------------------
// 
// -----------------------------------------------	
string  		sFrequenz, sFilter,sLoadingText,sPacketText1,sPacketText2 
DataStore 	ds_handlingplan
integer 		i
long			lRow,lJoker_Handling_Type_Key
Long 			lCount

ds_handlingplan					= CREATE DataStore
ds_handlingplan.DataObject 	= "dw_handlingplan"							
ds_handlingplan.SetTransObject(SQLCA)

//// ----------------------------------------------------------------------------------------
//// 23.01.2012: Beladevorschau - Leg Nummer = 0 macht Probleme (WEB #364 "Doppelte Label")
//// ----------------------------------------------------------------------------------------
//If sInfo.lhandling_leg_number < 1 and sInfo.lroutingplan_leg_number > 0 then
//	sInfo.lhandling_leg_number = sInfo.lroutingplan_leg_number
//End if

//messagebox("", "sInfo.lroutingplan_index = " + String(sInfo.lroutingplan_index) + "~r" + &
//"sInfo.lroutingplan_group_key = " + String(sInfo.lroutingplan_group_key) + "~r" +  &
//"lhandling_id = " + String(lhandling_id) + "~r" + &
//"date(sInfo.sdeparturedate) = " + String(date(sInfo.sdeparturedate)) + "~r" + &
//"sInfo.cdeparturetime = " + sInfo.cdeparturetime )

ds_handlingplan.Retrieve(sInfo.lroutingplan_index, &
								sInfo.lroutingplan_group_key, &
								lhandling_id, &
								date(sInfo.sdeparturedate), &
								sInfo.cdeparturetime)

//f_print_datastore(ds_handlingplan)

lCount = ds_handlingplan.RowCount()

iVerkehrsTag = f_getfrequence(date(sInfo.sdeparturedate))
sFrequenz 	 = "cen_routingplan_nfreq" + string(iVerkehrsTag) + "=1"

// ----------------------------------------------------------------------
// Filter auf Aircrafttyp,Handling,Beladeleg,Originalleg,Frequenz
// ----------------------------------------------------------------------
sFilter		 = "cen_aircraft_naircraft_key = " + string(sInfo.laircraft_key) + &
					" and cen_handling_types_nhandling_type_key = " + string(sInfo.lhandling_key) + &
					" and cen_routingplan_nleg_number >= " + string(sInfo.lhandling_leg_number) + &
					" and cen_routingplan_nleg_number <= " + string(sInfo.lroutingplan_leg_number) + &
					" and cen_routingplan_nfreq" + string(iVerkehrsTag) + " = 1 and cen_routingplan_handling_nfreq" + string(iVerkehrsTag) + " = 1"

ds_handlingplan.SetFilter(sFilter)
ds_handlingplan.Filter()



//if lhandling_id = 2 then ds_handlingplan.print()

lCount = ds_handlingplan.RowCount()

// ----------------------------------------------------------------------
// Filter auf Aircrafttyp,Handling = *,Beladeleg,Originalleg,Frequenz
// nur bei Supplement Loading Lists
// ----------------------------------------------------------------------	

//Messagebox("lhandling_id = " + string(lhandling_id), lCount)

If ds_handlingplan.rowcount() <= 0 and lhandling_id = 2 Then
	
	 SELECT nhandling_type_key  
		INTO :lJoker_Handling_Type_Key  
		FROM cen_handling_types  
	  WHERE ctext = '*' AND  
			  nairline_key = :sInfo.lairline_key ;

		
		If SQLCA.SQLCODE = 0 Then
			ds_handlingplan.SetFilter("")
			ds_handlingplan.Filter()
			sFilter	 = "cen_aircraft_naircraft_key = " + string(sInfo.laircraft_key) + &
							" and cen_handling_types_nhandling_type_key = " + string(lJoker_Handling_Type_Key) + &
							" and cen_routingplan_nleg_number >= " + string(sInfo.lhandling_leg_number) + &
							" and cen_routingplan_nleg_number <= " + string(sInfo.lroutingplan_leg_number) + &
							" and cen_routingplan_nfreq" + string(iVerkehrsTag) + " = 1 and cen_routingplan_handling_nfreq" + string(iVerkehrsTag) + " = 1"

			ds_handlingplan.SetFilter(sFilter)
			ds_handlingplan.Filter()
			
			
			//f_print_datastore(ds_handlingplan)
			//Messagebox(String(SQLCA.SQLCODE) + "        ", ds_handlingplan.RowCount())		
			
		End if
End if	


sPacketText1 = ""

For i = 1 to ds_handlingplan.RowCount()
	lRow = ds_matrix.InsertRow(0)
	ds_matrix.SetItem(lRow,"nleg",ds_handlingplan.GetItemNumber(i,"cen_routingplan_nleg_number"))
	ds_matrix.SetItem(lRow,"nact_leg",sInfo.lroutingplan_leg_number)
	ds_matrix.SetItem(lRow,"ssl_zbl_qaq",ds_handlingplan.GetItemString(i,"cen_handling_detail_cloadinglist"))			
	ds_matrix.SetItem(lRow,"nkey",ds_handlingplan.GetItemNumber(i,"nloadinglist_index_key"))
	ds_matrix.SetItem(lRow,"ntyp",ds_handlingplan.GetItemNumber(i,"cen_handling_nhandling_id"))
	ds_matrix.SetItem(lRow,"nprio_extern",ds_handlingplan.GetItemNumber(i,"sys_handling_id_nprio"))
	ds_matrix.SetItem(lRow,"nprio_intern",ds_handlingplan.GetItemNumber(i,"cen_handling_detail_nprio"))	
	ds_matrix.SetItem(lRow,"cfrom",ds_handlingplan.GetItemString(i,"sys_three_letter_codes_ctlc_from"))
	ds_matrix.SetItem(lRow,"cto",ds_handlingplan.GetItemString(i,"sys_three_letter_codes_ctlc_to"))
	
	sLoadingText 	= ds_handlingplan.GetItemString(i,"cen_handling_detail_cloadinglist")
	sPacketText2	= ds_handlingplan.GetItemString(i,"cen_handling_ctext") + "<br>"
	
	If sPacketText1 <> sPacketText2 Then
		sPacketText1 = sPacketText2 
	Else
		sPacketText1 = ""
	End if
	
	If not isnull(sLoadingText) Then
		If lhandling_id = 1 Then
			sInfo.sloadinglist 				+= '<font color="#3366FF">' + sPacketText1 + '</font>' + sLoadingText + "<br>"
		Elseif lhandling_id = 2 Then
			sInfo.ssupplementloadinglist	+= '<font color="#3366FF">' + sPacketText1 + '</font>' + sLoadingText + "<br>"
		End if	
	End if	
Next


DESTROY ds_handlingplan
return sInfo
end function

private function integer uf_setschema (long lrow);long 		lFind, &
			lPlKey
String	sMealCode
s_schema	s_propertie

lPlKey 		= ds_loadinglist.GetItemNumber(lRow, "cen_packinglists_npackinglist_key")			
sMealCode	= ds_loadinglist.GetItemString(lRow, "cen_loadinglists_cmeal_control_code")


// -------------------------------------------------------------------------------------------
// 23.02.2004
// cmeal_control_code audgebaut
// 
//lFind = ds_schema.Find("cmeal_control_code='" + sMealCode + "' " + &
//					    	  "AND npackinglist_key=" + String(lPlKey), 1, ds_schema.RowCount())
// -------------------------------------------------------------------------------------------

lFind = ds_schema.Find("npackinglist_key=" + String(lPlKey), 1, ds_schema.RowCount())

if lFind > 0 Then
	
	s_propertie.fontsize						= ds_schema.GetItemNumber(lFind, "cen_object_schema_nfontsize")
	s_propertie.fontcolor					= ds_schema.GetItemNumber(lFind, "cen_object_schema_nfontcolor")
	s_propertie.fontname						= ds_schema.GetItemString(lFind, "cen_object_schema_cfontname")
	s_propertie.fontbold						= ds_schema.GetItemNumber(lFind, "cen_object_schema_nfontbold")
	s_propertie.fontitalic					= ds_schema.GetItemNumber(lFind, "cen_object_schema_nfontitalic")
	s_propertie.objectborder				= ds_schema.GetItemNumber(lFind, "cen_object_schema_nobjectborder")
	s_propertie.objectcolor					= ds_schema.GetItemNumber(lFind, "cen_object_schema_nobjectcolor")
	s_propertie.objectbackgroundcolor	= ds_schema.GetItemNumber(lFind, "cen_object_schema_nobjectbackgroundcolor")
	s_propertie.objectlinewidth			= ds_schema.GetItemNumber(lFind, "cen_object_schema_nobjectlinewidth")
	
	// --------------------
	// Nicht Farbig ?
	// --------------------
	if iPrintColor = 2 then
		// --------------------
		// Graustufen
		// --------------------
		s_propertie.objectcolor					= f_RGBToGreyScale(s_propertie.objectcolor)  			// 0				// Linenfarbe schwarz
		s_propertie.objectbackgroundcolor	= f_RGBToGreyScale(s_propertie.objectbackgroundcolor)  //16777215		// Hintergrund wei$$HEX1$$df00$$ENDHEX$$
		s_propertie.fontcolor					= f_RGBToGreyScale(s_propertie.fontcolor)  				//0				// Schriftfarbe schwarz
	elseif iPrintColor = 3 then
		// --------------------
		// S/W
		// --------------------
		s_propertie.objectcolor					= 0				// Linenfarbe schwarz
		s_propertie.objectbackgroundcolor	= 16777215		// Hintergrund wei$$HEX1$$df00$$ENDHEX$$
		s_propertie.fontcolor					= 0				// Schriftfarbe schwarz
	end if

	// ----------------------------------
	// Keine Standardmarkierung (Bleyer)
	// ----------------------------------
	If lNoMarkup = 1 Then
		s_propertie.objectcolor					= 0				// Linenfarbe schwarz
		s_propertie.objectbackgroundcolor	= 16777215		// Hintergrund wei$$HEX1$$df00$$ENDHEX$$
		s_propertie.fontcolor					= 0				// Schriftfarbe schwarz
	End if


	
	ds_loadinglist.Setitem(lRow ,"cen_object_schema_nfontsize",s_propertie.fontsize)
	ds_loadinglist.Setitem(lRow ,"cen_object_schema_nfontcolor",s_propertie.fontcolor)			
	ds_loadinglist.Setitem(lRow ,"cen_object_schema_cfontname",s_propertie.fontname)
	ds_loadinglist.Setitem(lRow ,"cen_object_schema_nfontbold",s_propertie.fontbold)
	ds_loadinglist.Setitem(lRow ,"cen_object_schema_nfontitalic",s_propertie.fontitalic)
	ds_loadinglist.Setitem(lRow ,"cen_object_schema_nobjectborder",s_propertie.objectborder)	
	ds_loadinglist.Setitem(lRow ,"cen_object_schema_nobjectcolor",s_propertie.objectcolor)
	ds_loadinglist.Setitem(lRow ,"cen_object_schema_nobjectbackgroundcolor",s_propertie.objectbackgroundcolor)
	ds_loadinglist.Setitem(lRow ,"cen_object_schema_nobjectlinewidth",s_propertie.objectlinewidth)		
	
elseif lFind = 0 AND iPrintColor > 1 Then // Not bDiagramColor then
	
	s_propertie.objectcolor					= 0				// Linenfarbe schwarz
	s_propertie.objectbackgroundcolor	= 16777215		// Hintergrund wei$$HEX1$$df00$$ENDHEX$$
	s_propertie.fontcolor					= 0				// Schriftfarbe schwarz
	
	ds_loadinglist.Setitem(lRow ,"cen_object_schema_nfontcolor",s_propertie.fontcolor)		
	ds_loadinglist.Setitem(lRow ,"cen_object_schema_nobjectbackgroundcolor",s_propertie.objectbackgroundcolor)
	ds_loadinglist.Setitem(lRow ,"cen_object_schema_nobjectcolor",s_propertie.objectcolor)
	
end if

return 1

end function

public function long uf_draw_stowage (integer ipage, string sclass);//	----------------------------------------------------------------------------------------------------- 
//	zeichnet einen Stauort in das Datawindow ds_report
//	----------------------------------------------------------------------------------------------------- 
	
// ---------------------------
// Druck-relevante Variable
// ---------------------------
	uo_stowage	uoStowage
	Integer		iStartX, &
					iStartY, &
					iHeight, &
					iWidth, &
					iLineWidth, &
					iFontSize, &
					iSecFontSize, &
					iMenge, &
					iForTo
	
					
	Long			lStowageID, &
					lBackColor, &
					lLineColor, &
					lTextColor, &
					lNewBackgroundColor , &
					lNewLineColor , &
					lNewLineWidth, &
					lFindRow, &
					lAnzRows, &
					lPaintedStowages = 0, &
					lBenchStart, &
					lBenchStop,&
					lRowSubLayout
										
	
	String		sFontName, &
					sClassName
	// ---------------------------
	// Verarbeitungs-Variable
	// ---------------------------
	Long			lRow, &
					lRowLayout, &
					lRet 
	String		sBufferA, sBufferB
	
	integer 		iResize,iCheckHeight1,iCheckWidth1,iCheckHeight2,iCheckWidth2
					
	decimal		dGewicht
	
	// ---------------------------
	// Ein bi$$HEX1$$df00$$ENDHEX$$chen Vorbereitung
	// ---------------------------
	ds_ZustauTexteToExtraStauort.Reset()
	
	// --------------------
	// Nicht Farbig ?
	// --------------------
	if iPrintColor = 2 then
		// --------------------
		// Graustufen
		// --------------------
		lClassBrushColor 				= f_RGBToGreyScale(lClassBrushColor)
		lMarkNoCatererActionColor 	= f_RGBToGreyScale(lMarkNoCatererActionColor) 
		lForToTextColor				= f_RGBToGreyScale(lForToTextColor)
		lQAQTextColor 					= f_RGBToGreyScale(lQAQTextColor) 
		lClassBrushColor 				= f_RGBToGreyScale(lClassBrushColor)
	elseif iPrintColor = 3 then
		// --------------------
		// S/W
		// --------------------
		lClassBrushColor 				= RGB(255,255,255)
		lMarkNoCatererActionColor 	= RGB(255,255,255)
		lForToTextColor				= RGB(0,0,0)
		lQAQTextColor 					= RGB(0,0,0)
		lClassBrushColor 				= RGB(255,255,255)
	end if


	// ----------------------------
	// Es geht los
	// zuerst die Stauorte ohne
	// Inhalte
	// ----------------------------
	lAnzRows = ds_StauorteOhneInhalte.RowCount()

	For lRow = 1 To lAnzRows 
		If ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_stowage_npage") = iPage Then
					
			uoStowage 								= Create uo_stowage	
			uoStowage.dsreport   				= ds_report
			uoStowage.sDateFormat				= sDateFormat
			uoStowage.sMandant   				= sMandant   
			
			iStartX 		= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_stowage_nxpos") 
			iStartY 		= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_stowage_nypos") 
			iHeight 		= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_object_equipment_nequipment_height") 
			iWidth  		= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_object_equipment_nequipment_width")  
			iLineWidth	= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_object_schema_nobjectlinewidth") 	
			
			sFontName	= ds_StauorteOhneInhalte.GetItemString(lRow, "cen_object_schema_cfontname") 
			if ds_loadinglist.RowCount() > 0 Then
				iFontSize	= ds_loadinglist.GetItemNumber(1, "compute_usefontsize") 
				iSecFontSize= ds_loadinglist.GetItemNumber(1, "cen_object_schema_nfontsize") 
			else
				iFontSize	= iMinFontSize
				iSecFontSize= iMinFontSize
			end if
			
			uoStowage.lMarkNoCatererActionColor	= lMarkNoCatererActionColor
			uoStowage.lForToTextColor				= lForToTextColor
			
			lBackColor	= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_object_schema_nobjectbackgroundcolor") 
			lLineColor	= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_object_schema_nobjectcolor") 
			lTextColor	= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_object_schema_nfontcolor")
				
			
			uoStowage.iResize 			= iResize
			uoStowage.lXPosInPixel 		= iStartX
			uoStowage.lYPosInPixel 		= iStartY
			uoStowage.lHeightInPixel	= iHeight
			uoStowage.lWidthInPixel		= iWidth
			uoStowage.iLineWidth			= iLineWidth
			
			uoStowage.lLineColor			= lLineColor
			uoStowage.lTextColor			= lTextColor
			uoStowage.lBackColor			= lBackColor
			
			uoStowage.iFontSize 			= iFontSize
			uoStowage.iSecondFontSize	= iSecFontSize
			uoStowage.sFontName 			= sFontName
			
			// -----------
			// Galley = 1
			// -----------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=1", 1, ds_diagramlayout.RowCount())
			if lRowLayout > 0 Then
				uoStowage.sGalley		     = Trim(ds_StauorteOhneInhalte.GetItemString(lRow, "cen_galley_cgalley")) 
				uoStowage.iGalleyBold     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iGalleyItalic   = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iGalleyAlign    = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if	
			// -------------------------------------
			// Stauort = 2 
			// -------------------------------------
			lRowLayout 		= ds_diagramlayout.Find("nlayout_field=2", 1, ds_diagramlayout.RowCount())	
			
			if lRowLayout > 0 Then
				uoStowage.sStowage		   = Trim(ds_StauorteOhneInhalte.GetItemString(lRow, "cen_stowage_cstowage"))
				uoStowage.iStowageBold     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iStowageItalic   = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iStowageAlign    = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if	
			// -----------
			// Platz = 3
			// -----------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=3", 1, ds_diagramlayout.RowCount())
			if lRowLayout > 0 Then
				uoStowage.sPlace		   	= Trim(ds_StauorteOhneInhalte.GetItemString(lRow, "cen_stowage_cplace"))
				uoStowage.iPlaceBold       = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iPlaceItalic     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iPlaceAlign      = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if	
			// ---------------------------------
			// Gewicht = 14 nur bei Blanko Grafik
			// ---------------------------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=14", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 and iEmptyDiagram = 1 Then
				dGewicht 						= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_stowage_nweight") 
				If isnull(dGewicht) or dGewicht <= 0 Then
					setnull(dGewicht)
				End if	
				uoStowage.dGewicht			= round(dGewicht,2)
				uoStowage.iGewichtBold  	= ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iGewichtItalic	= ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iGewichtAlign 	= ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if		
			
	
			// ---------------------------------------------------------------------
			// Caterer Markierer = 16
			//
			//
			// soll dieser Stauort f$$HEX1$$fc00$$ENDHEX$$r den Dritt-Caterer markiert werden.
			// So nach dem Motto: "hier musst du was tun", 
			// d.h. alle anderen Stauorte sind eingef$$HEX1$$e400$$ENDHEX$$rbt aus diesem.
			// Das bekommen wir raus indem  wir die SSL in der Matrix suchen
			// und nachsehen, ob diese im iActLeg beladen wurde.
			// ---------------------------------------------------------------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=16", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.bMarkNoCatererAction = TRUE
			end if
			
			uoStowage.uf_drawreport()
		
			Destroy uoStowage
		End if
	Next
	

	// ----------------------------
	// Jetzt die Stauorte mit
	// Inhalten
	// ----------------------------
	lAnzRows = ds_loadinglist.RowCount()
	For lRow = 1 To lAnzRows
		If ds_loadinglist.GetItemNumber(lRow, "cen_stowage_npage") = iPage AND &
			ds_loadinglist.GetItemNumber(lRow, "cen_loadinglists_nbelly_container") = 0 Then
			
			uoStowage 								= Create uo_stowage	
			uoStowage.dsreport   				= ds_report
			uoStowage.sDateFormat				= sDateFormat
			uoStowage.sMandant   				= sMandant   
	
			uoStowage.lMarkNoCatererActionColor	= lMarkNoCatererActionColor
			uoStowage.lForToTextColor				= lForToTextColor
			uoStowage.lQAQTextColor 				= lQAQTextColor
	
				
			iStartX 		= ds_loadinglist.GetItemNumber(lRow, "cen_stowage_nxpos") 
			iStartY 		= ds_loadinglist.GetItemNumber(lRow, "cen_stowage_nypos") 
			iHeight 		= ds_loadinglist.GetItemNumber(lRow, "cen_object_equipment_nequipment_height") 
			iWidth  		= ds_loadinglist.GetItemNumber(lRow, "cen_object_equipment_nequipment_width")  
			iLineWidth	= ds_loadinglist.GetItemNumber(lRow, "cen_object_schema_nobjectlinewidth") 	
			
			sFontName	= ds_loadinglist.GetItemString(lRow, "cen_object_schema_cfontname") 
			iFontSize	= ds_loadinglist.GetItemNumber(lRow, "compute_usefontsize") 
			iSecFontSize= ds_loadinglist.GetItemNumber(lRow, "cen_object_schema_nfontsize") 
					
			lBackColor	= ds_loadinglist.GetItemNumber(lRow, "cen_object_schema_nobjectbackgroundcolor") 
			
				
			lLineColor	= ds_loadinglist.GetItemNumber(lRow, "cen_object_schema_nobjectcolor") 
			lTextColor	= ds_loadinglist.GetItemNumber(lRow, "cen_object_schema_nfontcolor")

			// ---------------------------------
			// geh$$HEX1$$f600$$ENDHEX$$rt dieser Stauort zur Klasse
			// ---------------------------------
			
			if bClassMark Then
				sClassName = Trim(ds_loadinglist.GetItemString(lRow, "cen_loadinglists_cclass"))
				if Not isNull(sClassName) AND len(sClassName) > 0 Then
					if Match(sClassName, sClass) Then		
						lPaintedStowages ++
						uoStowage.bIsClassStowage = True
					else
						// --------------------------------
						// dieser Stauort wird schraffiert
						// --------------------------------
						uoStowage.bIsClassStowage 	= False
						uoStowage.iBrushHatch 		= iClassBrush
						uoStowage.lBrushColor 		= lClassBrushColor
					end if
					
				else
					uoStowage.bIsClassStowage = True
				end if
			else
				// --------------------------------
				// dieser Stauort wird schraffiert
				// --------------------------------
				uoStowage.iBrushHatch 		= iClassBrush
				uoStowage.lBrushColor 		= lBackColor
			end if
			
			
			uoStowage.lXPosInPixel 		= iStartX
			uoStowage.lYPosInPixel 		= iStartY
			uoStowage.lHeightInPixel	= iHeight
			uoStowage.lWidthInPixel		= iWidth
			uoStowage.iLineWidth			= iLineWidth
			
			uoStowage.lLineColor			= lLineColor
			uoStowage.lTextColor			= lTextColor
			uoStowage.lBackColor			= lBackColor
			
			uoStowage.iFontSize 			= iFontSize
			uoStowage.iSecondFontSize	= iSecFontSize
			uoStowage.sFontName 			= sFontName
						
			// -----------
			// Galley = 1
			// -----------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=1", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.sGalley		     = Trim(ds_loadinglist.GetItemString(lRow, "cen_galley_cgalley")) 
				uoStowage.iGalleyBold     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iGalleyItalic   = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iGalleyAlign    = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if	
			// --------------------------------------
			// Stauort = 2 
			// --------------------------------------
			lRowLayout 		= ds_diagramlayout.Find("nlayout_field=2", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.sStowage		   = Trim(ds_loadinglist.GetItemString(lRow, "cen_stowage_cstowage"))								
				uoStowage.iStowageBold     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iStowageItalic   = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iStowageAlign    = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if	
			// -----------
			// Platz = 3
			// -----------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=3", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.sPlace		   	= Trim(ds_loadinglist.GetItemString(lRow, "cen_stowage_cplace"))
				uoStowage.iPlaceBold       = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iPlaceItalic     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iPlaceAlign      = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if	
			// ------------------------------------------------------------------------------------------------
			//
			// 											Die untere Ecke ist abgearbeitet 
			// 									         Jetzt fangen wir oben an. 
			//
			// ------------------------------------------------------------------------------------------------
			// ----------------
			// Zusatztext = 4
			// ----------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=4", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.sAddOnText		   	 = Trim(ds_loadinglist.GetItemString(lRow, "cen_loadinglists_cadd_on_text")) 
				uoStowage.iAddOnTextBold       = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iAddOnTextItalic     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iAddOnTextAlign      = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if	
			
			// ----------------
			// Bezeichnung = 5
			// ----------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=5", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				sBufferA = Trim(ds_loadinglist.GetItemString(lRow, "cen_packinglists_ctext"))
				sBufferB = Trim(ds_loadinglist.GetItemString(lRow, "cen_packinglists_ctext_short"))
				
				if Not IsNull(sBufferB) AND Len(sBufferB) < Len(sBufferA) Then
					// -------------------------
					// den k$$HEX1$$fc00$$ENDHEX$$rzeren Text nehmen
					// -------------------------
					sBufferA = sBufferB
				end if
				
				iMenge = ds_loadinglist.GetItemNumber(lRow, "cen_loadinglists_nquantity")
				if iMenge > 1 Then
					sBufferA = String(iMenge) + "x " + sBufferA 
				end if
				
				uoStowage.sPLText		   	 = sBufferA
				uoStowage.iPLTextBold       = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iPLTextItalic     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iPLTextAlign      = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
				uoStowage.bPLTextPrinted	= False
			else
				uoStowage.bPLTextPrinted	= True
			end if
			
			
			// ----------------
			// Mealcode = 6
			// ----------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=6", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.sMealCode		   	= Trim(ds_loadinglist.GetItemString(lRow, "cen_loadinglists_cmeal_control_code")) 
				uoStowage.iMealCodeBold       = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iMealCodeItalic     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iMealCodeAlign      = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
				
				If uoStowage.sMealCode = "- -" Then
					uoStowage.sMealCode = ""
				End if	
				
			End if	
			
			// ----------------
			// SNR = 7
			// ----------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=7", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.sSNR		   	 = Trim(ds_loadinglist.GetItemString(lRow, "cen_packinglist_index_cpackinglist")) 
				uoStowage.iSNRBold       = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iSNRItalic     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iSNRAlign      = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if	

/*
			// ----------------------
			// Produktionsbereich = 8
			// ----------------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=8", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.sProdBereich		   	= Trim(ds_loadinglist.GetItemString(lRow, "")) 
				uoStowage.iProdBereichBold       = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iProdBereichItalic     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iProdBereichAlign      = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if	
			
			
			// ----------------------
			// Mahlzeitenmenge = 9
			// ----------------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=9", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.iMealMenge		   	 = ds_loadinglist.GetItemNumber(lRow, "")
				uoStowage.iMealMengeBold       = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iMealMengeItalic     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iMealMengeAlign      = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if
			
			// ----------------------
			// MOPSNR = 10
			// ----------------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=10", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.sMOPSNR		   	= Trim(ds_loadinglist.GetItemString(lRow, "")) 
				uoStowage.iMOPSNRBold       = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iMOPSNRItalic     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iMOPSNRAlign      = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if	
			
			// --------------------------
			// Mahlzeitenbezeichnung = 11
			// --------------------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=11", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.sMealBez		   	= Trim(ds_loadinglist.GetItemString(lRow, "")) 
				uoStowage.iMealBezBold       = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iMealBezItalic     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iMealBezAlign      = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if
*/				
			// ---------------------------------------
			// Einheit = 12 
			// ---------------------------------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=12", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.sEinheit = Trim(ds_loadinglist.GetItemString(lRow, "cen_packinglists_cunit")) 										
				uoStowage.iEinheitBold       = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iEinheitItalic     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iEinheitAlign      = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if
		// ---------------------------------------
		// New-Markierung = 19
		// ---------------------------------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=19", 1, ds_diagramlayout.RowCount())				
			if lRowLayout > 0 Then
				If not isnull(ds_loadinglist.GetItemDateTime(lRow, "cen_loadinglists_dtimestamp_modification")) Then
					uoStowage.sNew 			 = "F" 
				Else
					uoStowage.sNew 			 = "" 
				End if	
				uoStowage.iNewBold       = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iNewItalic     = ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iNewAlign      = ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if
			
			
			// --------------------------
			// Zustautext = 13
			// --------------------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=13", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.sZustauText			= Trim(ds_loadinglist.GetItemString(lRow, "compute_ZustauText")) 
				uoStowage.iZustauTextBold  	= ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iZustauTextItalic	= ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iZustauTextAlign 	= ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
				uoStowage.bZustauTextPrinted 	= False
			else
				uoStowage.bZustauTextPrinted 	= True
			end if
			
			// --------------------------
			// Gewicht = 14
			// --------------------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=14", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.dGewicht			= round(ds_loadinglist.GetItemNumber(lRow, "compute_calcweight"),2)
				uoStowage.iGewichtBold  	= ds_diagramlayout.GetItemNumber(lRowLayout, "nfontbold") 
				uoStowage.iGewichtItalic	= ds_diagramlayout.GetItemNumber(lRowLayout, "nfontitalic") 
				uoStowage.iGewichtAlign 	= ds_diagramlayout.GetItemNumber(lRowLayout, "nalign") 
			end if		
		
			// --------------------------
			// QAQActionCode = 15
			// --------------------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=15", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				uoStowage.sQAQActionCode	= ds_loadinglist.GetItemString(lRow, "compute_sicodes")
			end if		

			
			// ---------------------------------------------------------------------
			// Caterer Markierer = 16
			//
			//
			// soll dieser Stauort f$$HEX1$$fc00$$ENDHEX$$r den Dritt-Caterer markiert werden.
			// So nach dem Motto: "hier musst du was tun", 
			// d.h. alle anderen Stauorte sind eingef$$HEX1$$e400$$ENDHEX$$rbt ausser diesem.
			// Das bekommen wir raus indem  wir die SSL in der Matrix suchen
			// und nachsehen, ob diese im iActLeg beladen wurde.
			// ---------------------------------------------------------------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=16", 1, ds_diagramlayout.RowCount())	
			if lRowLayout > 0 Then
				If ds_loadinglist.GetItemNumber(lRow, "stationinstruction") = 1 Then
						// nicht anstreichen. Also f$$HEX1$$fc00$$ENDHEX$$r den Caterer von Interesse
					uoStowage.bMarkNoCatererAction = FALSE			
				else
						// anstreichen. Also f$$HEX1$$fc00$$ENDHEX$$r den Caterer NICHT von Interesse
					uoStowage.bMarkNoCatererAction = TRUE	
				end if
			end if
			
			
						
			// --------------------------
			// For Code = 17
			// --------------------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=17", 1, ds_diagramlayout.RowCount())	
			iForTo   = ds_loadinglist.GetItemNumber(lRow, "cen_loadinglists_nfor_to_code") 
			if lRowLayout > 0 AND iForTo = 1 Then
				uoStowage.sForToCode	= "For " + ds_loadinglist.GetItemString(lRow, "sys_three_letter_codes_ctlc") 
			end if
			
			// --------------------------
			// To Code = 18
			// --------------------------
			lRowLayout = ds_diagramlayout.Find("nlayout_field=18", 1, ds_diagramlayout.RowCount())	
			iForTo   = ds_loadinglist.GetItemNumber(lRow, "cen_loadinglists_nfor_to_code") 
			if lRowLayout > 0 AND iForTo = 2 Then
				uoStowage.sForToCode	= "To " + ds_loadinglist.GetItemString(lRow, "sys_three_letter_codes_ctlc") 
			end if
			
			// --------------------------
			// wir malen
			// --------------------------
		
					
			uoStowage.uf_drawreport()
			
			
			// ----------------------------
			// wurde der PL-Text gedruckt
			// wenn nicht auf Extra-Stauort
			// ----------------------------
			if uoStowage.bPLTextPrinted Then
				ds_loadinglist.SetItem(lRow, "compute_rowprinted", 1)
			else
				ds_loadinglist.SetItem(lRow, "compute_rowprinted", 0)
			end if
			
			// ----------------------------
			// wurde der Zustau-Text gedruckt
			// wenn nicht auf Extra-Stauort
			// Hierzu RowsCopy und Zustautext
			// und PL-Text tauschen
			// ----------------------------
			if Not uoStowage.bZustauTextPrinted Then
				ds_loadinglist.RowsCopy(lRow, lRow, Primary!, &
								  ds_ZustauTexteToExtraStauort, &
								  (ds_ZustauTexteToExtraStauort.RowCount() + 1),&
								  Primary!)
								  
				sBufferA = ds_ZustauTexteToExtraStauort.GetItemString(ds_ZustauTexteToExtraStauort.RowCount(), &
							  				"compute_zustautext")
				ds_ZustauTexteToExtraStauort.SetItem(ds_ZustauTexteToExtraStauort.RowCount(), &
							  				"cen_packinglists_ctext", sBufferA)			  
				ds_ZustauTexteToExtraStauort.SetItem(ds_ZustauTexteToExtraStauort.RowCount(), &
											"compute_rowprinted", 0)
			end if
			
			
			
			Destroy uoStowage
		End if

	Next
	
	// ----------------------------
	// Nochmal die Stauorte ohne
	// Inhalte f$$HEX1$$fc00$$ENDHEX$$r Resize Equipment
	// ----------------------------
	For lRow = 1 To ds_StauorteOhneInhalte.RowCount()
		If ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_stowage_npage") = iPage Then
			// -------------------------------------------------
			// Alle die die in der Gr$$HEX2$$f600df00$$ENDHEX$$e ver$$HEX1$$e400$$ENDHEX$$ndert werden sollen
			// ist iResize = 1
			// -------------------------------------------------
			iResize = ds_StauorteOhneInhalte.GetItemNumber(lRow,"cen_object_equipment_nequipment_resize")
			If iResize = 1 Then	
				uoStowage 								= Create uo_stowage	
				uoStowage.dsreport   				= ds_report
				uoStowage.sDateFormat				= sDateFormat
				uoStowage.sMandant   				= sMandant   
				
				iStartX 		= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_stowage_nxpos") 
				iStartY 		= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_stowage_nypos") 
				iHeight 		= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_object_equipment_nequipment_height") 
				iWidth  		= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_object_equipment_nequipment_width")  
				iLineWidth	= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_object_schema_nobjectlinewidth") 	
				
				sFontName	= ds_StauorteOhneInhalte.GetItemString(lRow, "cen_object_schema_cfontname") 
				
				if ds_loadinglist.RowCount() > 0 Then
					iFontSize	= ds_loadinglist.GetItemNumber(1, "compute_usefontsize") 
					iSecFontSize= ds_loadinglist.GetItemNumber(1, "cen_object_schema_nfontsize") 
				else
					iFontSize	= iMinFontSize
					iSecFontSize= iMinFontSize	
				end if
							
				lBackColor	= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_object_schema_nobjectbackgroundcolor") 
				lLineColor	= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_object_schema_nobjectcolor") 
				lTextColor	= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_object_schema_nfontcolor")
				
						
				uoStowage.iResize 			= iResize
				uoStowage.lXPosInPixel 		= iStartX
				uoStowage.lYPosInPixel 		= iStartY
				uoStowage.lHeightInPixel	= iHeight
				uoStowage.lWidthInPixel		= iWidth
				uoStowage.iLineWidth			= iLineWidth
				
				uoStowage.lLineColor			= lLineColor
				uoStowage.lTextColor			= lTextColor
				uoStowage.lBackColor			= lBackColor
				
				uoStowage.iFontSize 			= iFontSize
				uoStowage.iSecondFontSize	= iSecFontSize
				uoStowage.sFontName 			= sFontName
			
			
				uoStowage.sGalley		     = ds_StauorteOhneInhalte.GetItemString(lRow, "cen_galley_cgalley")				
				uoStowage.sStowage		  = ds_StauorteOhneInhalte.GetItemString(lRow, "cen_stowage_cstowage")
						
				
				// ----------------------------------
				// Farbe von Partner-Stauort suchen.
				// ----------------------------------
				lFindRow = ds_loadinglist.find("cen_galley_cgalley = '" + uoStowage.sGalley + &
							 			  "' and cen_stowage_cstowage = '" + uoStowage.sStowage + &
										  "' and cen_loadinglists_nbelly_container = 0" + & 
							 			  "  and cen_stowage_npage = " + string(iPage), 1, ds_loadinglist.Rowcount())
										  
				If lFindRow > 0 Then
					
				// -------------------------------------------------------------
				// Neu Check Resize !!!
				// Sofern der Stauort ohne Inhalt und der Partnerstauort 
				// die gleiche Gr$$HEX2$$f600df00$$ENDHEX$$e haben, machen wir keinen Resize.
				// Half Trolley und Half Trolley  bleibt Half Trolley
				// -------------------------------------------------------------	
					iCheckHeight1 		= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_object_equipment_nequipment_height") 
					iCheckWidth1  		= ds_StauorteOhneInhalte.GetItemNumber(lRow, "cen_object_equipment_nequipment_width")  
					
					iCheckHeight2 		= ds_loadinglist.GetItemNumber(lFindRow, "cen_object_equipment_nequipment_height") 
					iCheckWidth2  		= ds_loadinglist.GetItemNumber(lFindRow, "cen_object_equipment_nequipment_width")  			
					
	
					

					If iCheckHeight1 	= iCheckHeight2 and &
						iCheckWidth1 	= iCheckWidth2 Then
						iResize = 0
						uoStowage.iResize = iResize
					End if
				// -------------------------------------------------------------
				// Neu Check Resize -> Standardtrolley
				// -------------------------------------------------------------
				// 05.04.2017 ALM #1850 zus$$HEX1$$e400$$ENDHEX$$tzliche Typen f$$HEX1$$fc00$$ENDHEX$$r Resize
				// -------------------------------------------------------------
						If trim(ds_loadinglist.GetItemString(lFindRow,"cen_packinglists_cunit")) = "ST" OR &
							trim(ds_loadinglist.GetItemString(lFindRow,"cen_packinglists_cunit")) = "STW" OR &
							trim(ds_loadinglist.GetItemString(lFindRow,"cen_packinglists_cunit")) = "SC" OR &
							trim(ds_loadinglist.GetItemString(lFindRow,"cen_packinglists_cunit")) = "SC10" OR &
							trim(ds_loadinglist.GetItemString(lFindRow,"cen_packinglists_cunit")) = "SC11" OR &
							trim(ds_loadinglist.GetItemString(lFindRow,"cen_packinglists_cunit")) = "SC12" OR &
							trim(ds_loadinglist.GetItemString(lFindRow,"cen_packinglists_cunit")) = "SC13" OR &
							trim(ds_loadinglist.GetItemString(lFindRow,"cen_packinglists_cunit")) = "SC14" OR &
							trim(ds_loadinglist.GetItemString(lFindRow,"cen_packinglists_cunit")) = "SC15"Then
						iResize = 1
						uoStowage.iResize = iResize
						//f_trace()
					End if
					
					lNewLineWidth			= ds_loadinglist.GetItemNumber(lFindRow, "cen_object_schema_nobjectlinewidth")
					lNewBackGroundColor	= ds_loadinglist.GetItemNumber(lFindRow, "cen_object_schema_nobjectbackgroundcolor") 
					lNewLineColor			= ds_loadinglist.GetItemNumber(lFindRow, "cen_object_schema_nobjectcolor") 
					sBufferA 				= ds_loadinglist.GetItemString(lFindRow, "cen_loadinglist_index_cloadinglist") 
					// ---------------------------------------------------------------------
					// Caterer Markierer = 16
					//
					//
					// soll dieser Stauort f$$HEX1$$fc00$$ENDHEX$$r den Dritt-Caterer markiert werden? Wir m$$HEX1$$fc00$$ENDHEX$$ssen
					// aber suchen, ob dieser Stauort ggf. eine Aktion erf$$HEX1$$e400$$ENDHEX$$hrt, dann darf er
					// n$$HEX1$$e400$$ENDHEX$$mlich nicht angestrichen werden.
					//
					// Dies ist der Fall, wenn die Schl$$HEX1$$fc00$$ENDHEX$$sselnummer im aktuellen Leg beladen
					// wird, oder der Stauort ein Actioncode aus der QAQ hat
					// ---------------------------------------------------------------------
					lRowLayout = ds_diagramlayout.Find("nlayout_field=16", 1, ds_diagramlayout.RowCount())	
					
					if lRowLayout > 0 Then
						If ds_loadinglist.GetItemNumber(lFindRow, "stationinstruction") = 1 Then
								// nicht anstreichen. Also f$$HEX1$$fc00$$ENDHEX$$r den Caterer von Interesse
							uoStowage.bMarkNoCatererAction = FALSE			
						else
								// anstreichen. Also f$$HEX1$$fc00$$ENDHEX$$r den Caterer NICHT von Interesse
							uoStowage.bMarkNoCatererAction = TRUE	
							uoStowage.lMarkNoCatererActionColor	= lMarkNoCatererActionColor
							uoStowage.lForToTextColor				= lForToTextColor
						end if
					end if
					
					// ---------------------------------------------------------------------
					// oder Klassenmarkierung
					// ---------------------------------------------------------------------
					if bClassMark Then
						sClassName = Trim(ds_loadinglist.GetItemString(lFindRow, "cen_loadinglists_cclass"))
						if Not isNull(sClassName) AND len(sClassName) > 0 Then
							if Match(sClassName, sClass) Then		
								lPaintedStowages ++
								uoStowage.bIsClassStowage  = True
							else
								// --------------------------------
								// dieser Stauort wird schraffiert
								// --------------------------------
								uoStowage.bIsClassStowage 	= False

								uoStowage.iBrushHatch 		= iClassBrush
								uoStowage.lBrushColor 		= lClassBrushColor
								
							end if
						else
							uoStowage.bIsClassStowage = True
						end if
					end if
					If iResize > 0 Then
						uoStowage.uf_resize_equipment(lNewBackGroundColor, lNewLineColor, lNewLineWidth)
					End if	
				End if	
				Destroy uoStowage
			End if	
		End if

	Next
	
	return lPaintedStowages
end function

public function s_all_flight_infos uf_print_label (s_all_flight_infos sinfo);	uo_label_other 	uoPrint
	str_bitmaps 		strBMP[]
	integer 				iRet, i
	blob 					bXMLDok, bXMLFragment
	Long					lIndex
	
	String				sPrintBefore, sPrintAfter
	s_Flight 			sFlight
	
	uoPrint = Create uo_label_other
		
	uoPrint.sWhereAmi 				= this.sWhereAmI
	uoPrint.sLocalPrinters			= this.sLocalPrinters
	uoPrint.sLocalBellyPrinters	= this.sLocalBellyPrinters
	uoPrint.lLocalLabelTypes		= this.lLocalLabelTypes
	
	uoPrint.sRampTime	 				= this.uf_check_null(this.sRampTime)
	uoPrint.sKitchenTime				= this.uf_check_null(this.sKitchenTime)
	uoPrint.sRampBox					= this.uf_check_null(this.sRampBox)
		// ---------------------------------
	// die Werte ermitteln, welche vor
	// dem eigentlichen Druck an den
	// Zebradrucker gesendet werden.
	// ---------------------------------
	sPrintBefore	= "" // ncbase.get_zebra_before_printing ()
	sPrintAfter		= "" // ncbase.get_zebra_after_printing ()
	
	// ---------------------------------
	// wir generieren das Label
	// der R$$HEX1$$fc00$$ENDHEX$$ckgabeparameter ist ein blob
	// diesen in XML wrappen
	// ---------------------------------
	sFlight.sAirline						= sAirlineCode
	sFlight.sFlightNumber				= STRING(iFlightNo)
	sFlight.dtDepartureDate				= dtDepartureDate
	sFlight.cDepartureTime				= STRING(tDepartureTime, "HH:MM")
	sFlight.sDestination					= sToTLC
	sFlight.sOwner							= sOwnerCode
	sFlight.sActype						= sAircraftType
	sFlight.lroutingplan_leg_number 	= sInfo.lroutingplan_leg_number
	sFlight.lsi_qaq_key					= sInfo.lsi_qaq_key
	sFlight.sConfiguration				= this.sConfiguration
	
	// Test
	this.of_legs()
	If Upperbound(is_Leg_Routing_From) = 0 Then
		is_Leg_Routing_From[1] = STRING(iFlightNo)
		is_Leg_Routing_To[1] = STRING(iFlightNo)
		this.iLegs[1] = sInfo.lroutingplan_leg_number
	End If
	uoPrint.iLegs = this.iLegs
	uoPrint.is_Leg_Routing_From = this.is_Leg_Routing_From
	uoPrint.is_Leg_Routing_To = this.is_Leg_Routing_to
	
	
	iRet = uoPrint.of_label(ds_loadinglist, iPrinterType, iLabelSort, iLabelPageBreak, sFlight, uoLabelReturn[], strBMP[]) 

	Choose case iRet 
		case -1		
			sInfo.sStatus = "No data available"
			sInfo.iStatus = -1
			return sInfo
		case -2
			sInfo.sStatus = "No valid label found"
			sInfo.iStatus = -1
			return sInfo
		case -3
			sInfo.sStatus = "Unknown printer-type"
			sInfo.iStatus = -1
			return sInfo
		case is < -4
			sInfo.sStatus = "Internal error " + String(iRet)
			sInfo.iStatus = -1
			return sInfo
	end choose
	
	if UpperBound(uoLabelReturn[]) = 0 Then
		sInfo.sStatus = "No label available"
		sInfo.iStatus = -1
		return sInfo
	end if
		
	bXMLDok = Blob  ("<Flight>")
	
	if not isNull(sAirlineCode) AND Len(Trim(sAirlineCode)) > 0 Then
		bXMLDok = bXMLDok + Blob ("<Airline dt:dt=~"string~">" + sAirlineCode + "</Airline>")
	Else
		bXMLDok = bXMLDok + Blob ("<Airline dt:dt=~"string~"/>")
	end if
	
	if not isNull(iFlightNo) AND iFlightNo > 0 Then
		bXMLDok = bXMLDok + Blob ("<FlightNo  dt:dt=~"string~">" + STRING(iFlightNo) + "</FlightNo>")
	Else
		bXMLDok = bXMLDok + Blob ("<FlightNo dt:dt=~"string~"/>")
	end if

	if not isNull(sSuffix) AND Len(Trim(sSuffix)) > 0 Then
		bXMLDok = bXMLDok + Blob ("<Suffix  dt:dt=~"string~">" + sSuffix + "</Suffix>")
	Else
		bXMLDok = bXMLDok + Blob ("<Suffix dt:dt=~"string~"/>")
	end if
	
	bXMLDok = bXMLDok + Blob ("<DepartureDate dt:dt=~"string~">" + string(Date(dtDepartureDate), "yyyy-mm-dd") + "</DepartureDate>")
	bXMLDok = bXMLDok + Blob ("<DepartureTime dt:dt=~"string~">" + string(tDepartureTime, "hh:mm:ss")    + "</DepartureTime>")
		
	// -------------------------------------------
	// die Kopfinfos haben wir
	// nun die einzelnen Label
	// -------------------------------------------
	For lIndex = 1 To UpperBound(uoLabelReturn)
		
		uoLabelReturn[lIndex].sEscapeBefore	= sPrintBefore
		uoLabelReturn[lIndex].sEscapeAfter	= sPrintAfter
		
		if sInfo.sInvocation <> "WEB" then
			sInfo.bStreamArray[lIndex]   			= uoLabelReturn[lIndex].bLabel
			sInfo.sLabeltypes[lIndex]	  			= uoLabelReturn[lIndex].sLabel
			sInfo.sStreamComment[lIndex] 			= uoLabelReturn[lIndex].sLabelComment
			this.sGeneratedForPrinter[lIndex]   = uoLabelReturn[lIndex].sGeneratedForPrinter
		end if
				
		uoLabelReturn[lIndex].iPrinterType = iPrinterType
		bXMLFragment = uoLabelReturn[lIndex].of_generate_xml_fragment() 
		
//		datastore dsTemp
//		dsTemp = create datastore
//		dsTemp.dataobject = "dw_loadinglist_result"
//		dsTemp.SetFullstate(uoLabelReturn[lIndex].bLabel)
//		dsTemp.SaveAs("c:\temp\blob" + string(cpu()) + ".xls", Excel5!, true)
		
		
		
		if not isNull(bXMLFragment) AND len(bXMLFragment) > 0 Then
			bXMLDok = bXMLDok + bXMLFragment
		end if
		
		//f_yield(lRoleID)
		
	Next
								
	bXMLDok = bXMLDok + Blob ("</Flight>")
	
	If Len(bXMLDok) = 0 Then
		sInfo.sStatus = "Internal error"
		sInfo.iStatus = -1
		return sInfo
	end if
		
	bLabelStream = bXMLDok

	return sInfo

end function

public function s_all_flight_infos uf_generate_label (s_all_flight_infos sinfo);Long		lRow
String	sTemp
Integer	iLeg, iLegPrev, iRet

// --------------------------------------------------------------
// Vorinitialisieren
// --------------------------------------------------------------	
bPDFStream			= BLOB("")
bLabelStream		= BLOB("")
sLLFooter			= ""

// ----------------------------------------------------------------------------
// Wir erstellen die Beladematrix, Fehlercode wird nur bei Fluglabel verwendet
// ----------------------------------------------------------------------------
sInfo = uf_matrix(sInfo)
if sInfo.iStatus = -1 and iPrintFlightLabel = 1 Then
	return sInfo
Else
	sInfo.iStatus 	= 0
	sErrortext		= ""
	sInfo.sStatus 	= sErrortext
end if
	
if iPrintFlightLabel = 1 then
	// ----------------------------------------
	// Wir Retrieven
	// ----------------------------------------
	if uf_retrieve() = -1 Then
		sInfo.sStatus = sErrortext
		sInfo.iStatus = -1
		return sInfo
	end if
		
	// ----------------------------------------
	// Die Farbinfos
	// ----------------------------------------
	uf_add_color_text()
	
else
	
	// ----------------------------------------
	// Wir Resetten den DataStore, da ggf. vom
	// Generieren der Galleygrafik noch was
	// drin steht ............................
	// ----------------------------------------
	ds_loadinglist.Reset()
	
	
end if


// ----------------------------------------
// Wir spielen die Bereiche dazu
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
	uoNewspaper.dsNewspaperReport = dsNewspaperReport
	uoNewspaper.sAirline				= sInfo.sAirline
	uoNewspaper.lFlightnumber		= long(sInfo.sflightnumber)
	uoNewspaper.sSuffix				= sInfo.ssuffix
	uoNewspaper.sDepartureTime		= sInfo.cdeparturetime
	uoNewspaper.sOwner				= sInfo.sOwner
	uoNewspaper.sActype				= sInfo.sActype
	
	uoNewspaper.iBostaF				= iBostaF
	uoNewspaper.iBostaC				= iBostaC
	uoNewspaper.iBostaM				= iBostaM

	uoNewspaper.of_start_label(sInfo)
	//
	// Append von uoNewspaper.dsResult an ds_loadinglist
	//
	uoNewspaper.dsResult.RowsCopy(1,uoNewspaper.dsResult.RowCount(),Primary!,ds_loadinglist,ds_loadinglist.RowCount() + 1, Primary!)
	
	destroy uoNewspaper
	
end if


// ----------------------------------------
// Wir spielen die Bereiche dazu
// ----------------------------------------
if this.sWhereamI <> "PB" then
	if uf_add_areas(DateTime(Date(sInfo.sDepartureDate))) = -1 then
		sInfo.sStatus = sErrortext
		sInfo.iStatus = -1
		return sInfo
	end if
	
else
	// --------------------------------------
	// Neu:
	// Zuspielen der Bereiche gem. der 
	// Zuordnung aus der Client Appl.
	// --------------------------------------
	
	//
	// Achtung: Anpassung notwendig, sonst wird versucht einer Newspaper PL
	// ein "normaler" Bereich zuzuspielen
	//
	if uf_add_workstations(DateTime(Date(sInfo.sDepartureDate))) = -1 then
		sInfo.sStatus = sErrortext
		sInfo.iStatus = -1
		return sInfo
	end if

end if
	
// ----------------------------------------
// Wir filtern die Label
// ----------------------------------------	
uf_label_check()

// -----------------------
// K$$HEX1$$f600$$ENDHEX$$nnen wir drucken, 
// wenn JA los
// -----------------------
//	IF not uf_isprintpossible() THEN 
//		sInfo.sStatus = sErrortext
//		sInfo.iStatus = -1
//		return sInfo
//	end if

// -----------------------
// wir generieren 
// -----------------------
sInfo = uf_print_label(sInfo)
	
		
return sInfo
	
end function

public function integer uf_draw_extrastowage (integer ipage);	Long 				lRow, &
						lUpperBoundFoundRow, &
						lIndex, &
						lGalleyKey, &
						lNext, &
						lIndexUeberlauf = 0
		
	String			sBufferA, &
						sBufferB, &
						sStowage
	
	Boolean			bCanPrint = False


		
	uo_extraStowage	uoExtraStowage							
	
	For lRow = 1 To ds_extra.RowCount()
		
		If ds_extra.GetItemNumber(lRow, "cen_diagram_extra_npage") = iPage Then
			bCanPrint = False
			uoExtraStowage = Create uo_extraStowage	
			uoExtraStowage.dsreport			= ds_report
			uoExtraStowage.lXPosInPixel 	= ds_extra.GetItemNumber(lRow, "cen_diagram_extra_nxpos") 
			uoExtraStowage.lYPosInPixel 	= ds_extra.GetItemNumber(lRow, "cen_diagram_extra_nypos") 
			uoExtraStowage.lHeightInPixel = ds_extra.GetItemNumber(lRow, "cen_object_equipment_nequipment_height") 
			uoExtraStowage.lWidthInPixel 	= ds_extra.GetItemNumber(lRow, "cen_object_equipment_nequipment_width")
			uoExtraStowage.bPrintHeader	= bprintheader
			uoExtraStowage.sHeaderText		= sHeadLineExtra + " " + ds_extra.GetItemString(lRow, "cen_galley_cgalley")
			uoExtraStowage.lLineColor	 	= lFrameColorExtra
			uoExtraStowage.bPrintFrame 	= bPrintFrame
			uoExtraStowage.sVerweisText	= sLinkTextExtra	
			uoExtraStowage.sDateFormat		= sDateFormat
			uoExtraStowage.sMandant   		= sMandant   
			uoExtraStowage.iPrintColor 	= iPrintColor

			lGalleyKey  = ds_extra.GetItemNumber(lRow, "cen_diagram_extra_ngalley_key")
			lNext			= 1
			
			// -----------------------------------------
			// erst mal die "normalen" nicht gedruckten
			// -----------------------------------------
			Do While lNext > 0
				
				lNext = ds_loadinglist.Find("cen_galley_ngalley_key=" + String(lGalleyKey) + " AND cen_stowage_npage=0 " + &
										"AND cen_loadinglists_nbelly_container=0", lNext, ds_loadinglist.RowCount())
				
				if lNext > 0 Then
					bCanPrint = True
					
					// ---------------------------
					// wir holen die Fontinfo
					// f$$HEX1$$fc00$$ENDHEX$$r die Galley
					// ---------------------------
					uoExtraStowage.sFontName	= ds_loadinglist.GetItemString(lNext, "cen_object_schema_cfontname") 
					uoExtraStowage.iFontSize	= ds_loadinglist.GetItemNumber(lNext, "compute_usefontsize") 
					uoExtraStowage.lTextColor	= ds_loadinglist.GetItemNumber(lNext, "cen_object_schema_nfontcolor")
					
					sStowage	= Trim(ds_loadinglist.GetItemString(lNext, "cen_stowage_cstowage"))
					sBufferA = Trim(ds_loadinglist.GetItemString(lNext, "cen_packinglists_ctext"))
					sBufferB = Trim(ds_loadinglist.GetItemString(lNext, "cen_packinglists_ctext_short"))
					
					if Not IsNull(sBufferB) AND Len(sBufferB) < Len(sBufferA) Then
						// -------------------------
						// den k$$HEX1$$fc00$$ENDHEX$$rzeren Text nehmen
						// -------------------------
						sBufferA = sBufferB
					end if
					
					lIndex = Upperbound(uoExtraStowage.sText[]) + 1
					uoExtraStowage.sText[lIndex] 			= sBufferA
					uoExtraStowage.sStauOrt[lIndex]		= sStowage
					uoExtraStowage.iTextPrinted[lIndex] = 0	
					// ----------------------------------------
					// die Zeile merken f$$HEX1$$fc00$$ENDHEX$$r Print Status
					// ----------------------------------------
					uoExtraStowage.lFoundRow[lIndex]	= lNext
					lNext ++
				end if
				
				if lNext > ds_loadinglist.RowCount() Then
					lNext = 0
				end if
				//f_yield(lRoleID)
			Loop
			
			// -----------------------------------------
			// jetzt die aus dem $$HEX1$$dc00$$ENDHEX$$berlauf, d.h. die 
			// Informationen welche zwar einen Stauort
			// haben, aber aus Platzgr$$HEX1$$fc00$$ENDHEX$$nden nicht ge-
			// druckt wurden
			// -----------------------------------------
			lNext			= 1
			Do While lNext > 0
				
				lNext = ds_zustautextetoextrastauort.Find("cen_galley_ngalley_key=" + String(lGalleyKey) + &
													"AND cen_loadinglists_nbelly_container=0", lNext, ds_zustautextetoextrastauort.RowCount())

				if lNext > 0 Then
					bCanPrint = True
					
					// ---------------------------
					// wir holen die Fontinfo
					// f$$HEX1$$fc00$$ENDHEX$$r die Galley
					// ---------------------------
					uoExtraStowage.sFontName	= ds_zustautextetoextrastauort.GetItemString(lNext, "cen_object_schema_cfontname") 
					uoExtraStowage.iFontSize	= ds_zustautextetoextrastauort.GetItemNumber(lNext, "compute_usefontsize") 
					uoExtraStowage.lTextColor	= ds_zustautextetoextrastauort.GetItemNumber(lNext, "cen_object_schema_nfontcolor")
					
					sStowage	= Trim(ds_zustautextetoextrastauort.GetItemString(lNext, "cen_stowage_cstowage"))
					sBufferA = Trim(ds_zustautextetoextrastauort.GetItemString(lNext, "cen_packinglists_ctext"))
										
					lIndex = Upperbound(uoExtraStowage.sText[]) + 1
					uoExtraStowage.sText[lIndex] 			= sBufferA
					uoExtraStowage.sStauOrt[lIndex]		= sStowage
					uoExtraStowage.iTextPrinted[lIndex] = 0	
					// ----------------------------------------
					// die Zeile merken f$$HEX1$$fc00$$ENDHEX$$r Print Status
					// ----------------------------------------
					lIndexUeberlauf = Upperbound(uoExtraStowage.lFoundRowUeberlauf[]) + 1
					uoExtraStowage.lFoundRowUeberlauf[lIndexUeberlauf]	= lNext
					lNext ++
				end if
				
				if lNext > ds_zustautextetoextrastauort.RowCount() Then
					lNext = 0
				end if
				//f_yield(lRoleID)
			Loop
			
			
			if bCanPrint Then
				uoExtraStowage.uf_drawreport()
				// --------------------------
				// die Flags setzen, welche
				// Zeilen gedruckt wurden
				// --------------------------
				lUpperBoundFoundRow = UpperBound(uoExtraStowage.lFoundRow[])
				// f$$HEX1$$fc00$$ENDHEX$$r ds_loadinglist
				for lIndex = 1 To lUpperBoundFoundRow
					ds_loadinglist.SetItem(uoExtraStowage.lFoundRow[lIndex], "compute_rowprinted", uoExtraStowage.iTextPrinted[lIndex])	
					//f_yield(lRoleID)
				next
				// f$$HEX1$$fc00$$ENDHEX$$r ds_zustautextetoextrastauort
				for lIndex = 1 To UpperBound(uoExtraStowage.lFoundRowUeberlauf[])
					ds_zustautextetoextrastauort.SetItem(uoExtraStowage.lFoundRowUeberlauf[lIndex], "compute_rowprinted", uoExtraStowage.iTextPrinted[lIndex + lUpperBoundFoundRow])	
					//f_yield(lRoleID)
				next
				
			end if
			Destroy uoExtraStowage
		end if
		//f_yield(lRoleID)
	Next
	return 1

end function

public function integer uf_print ();LONG					lJobCnt, &
						lUpperBound, &
						lRet, &
						lPageCounter
						
INTEGER				iPage  = 0, &
						iMaxPage = 0, &
						iAnzahlKopien = 0, &		
						iIndex

STRING				sNull, &
						sDocumentName, &
						sHeaderText, &
						sClassName, &
						sShortClassName, &
						sInternal, &
						sAircraftVersion
						
						
BLOB					bDsState
s_class_names 		sClassArray[]
datastore 			dsAddOnReport


		
if not isValid(nPrintPDF) and sWhereAmI = "WEB" Then
	sErrorText = "Can't connect to PDF-Writer"
	writelog(sErrorText)
	return -1
end if
	
// -------------------------
// Ein paar Infos
// -------------------------
SetNull(sNull)

IF isnull(sSuffix) THEN
	sHeaderText = Trim(sAirlineCode + " " + String(iFlightNo))
ELSE
	sHeaderText	= Trim(sAirlineCode + " " + String(iFlightNo) + " " + sSuffix)
END IF	
//
// Routing
//
if not isnull(sFromTo) then
	sHeaderText = sHeaderText + "  " + sFromTo
end if

sDocumentName 				= sHeaderText
ds_report.iPrintColor 	= iPrintColor 	

// ----------------------------------
// Den Namen des PDF 
// festlegen und dem UO mitteilen
//
// wir holen jedoch immer nur beim 
// ersten Flug den Dateinamen. Dies
// ist beim Multiple-Flight-Printing
// von Wichtigkeit, da wir ja ein 
// gro$$HEX1$$df00$$ENDHEX$$es PDF haben wollen
// ----------------------------------

IF lActFlightToPrint = 1 THEN
	// ----------------------------------
	// 21.08.2002
	// Unterscheiden, ob Instanz im Web
	// oder im Powerbuilder-Client 
	// l$$HEX1$$e400$$ENDHEX$$uft
	// ----------------------------------
	if sWhereAmI = "WEB" then
		sPDFFileName 				= String(nPrintPDF.GetSession())
		sPDFFullFileName			= nPrintPDF.GetPdfDocPath() + sPDFFileName + ".pdf"
		lUpperBound					= UpperBound(sTempFiles[]) + 1
		sTempFiles[lUpperBound]	= sPDFFullFileName
	else
		sPDFFileName 				= String(Rand(32767))
		sPDFFullFileName			= f_gettemppath() + "CBASE-GRAFIK-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
	end if
	
END IF

// ----------------------------------
// Das Datumsformat des users
// ----------------------------------		
ds_report.sDateFormat = sDateFormat 

// ----------------------------------
// ein PrintJob erstellen
// und wieviel max. Seiten
// ----------------------------------
uf_createprintjob()
iMaxPage = uf_GetMaxPage()

// ----------------------------------
// alle Seiten durchlaufen 
// ----------------------------------
FOR lJobCnt = 1 TO ds_print_job.RowCount() 
	ds_report.DataObject = sNull
	ds_report.DataObject = "dw_loading_diagram2"
	
	// --------------------------------------------------------
	// Liefert den Header-Text
	// --------------------------------------------------------
	sClassName 		= ds_print_job.GetItemSTRING(lJobCnt, "sclassLONG")
	iPage		  		= ds_print_job.GetItemNumber(lJobCnt, "ipage")
	sShortClassName= ds_print_job.GetItemSTRING(lJobCnt, "sclassshort")
	
	IF isNull(sShortClassName) THEN
		sShortClassName = ""
	END IF
	IF isNull(sClassName) THEN
		sClassName = ""
	END IF
	
	// --------------------------------------------------------
	// Aircraft-Typ und Sitzplatzversion f$$HEX1$$fc00$$ENDHEX$$llen Feld actyp_t
	// --------------------------------------------------------
	if not isnull(sConfiguration) then
		sAircraftVersion = sOwnerCode + " " + sAircraftType + " " + sConfiguration
	else
		sAircraftVersion = sOwnerCode + " " + sAircraftType
	end if
	// ------------------------
	// ausrichten
	// ------------------------
	ds_report.uf_report_style(sReportTitle, sHeaderText, True, &
											 sAircraftVersion, &
											 String(dtDepartureDate , sDateFormat) + "  " + String(tDepartureTime, "HH:MM"), sClassName, sLLFooter)

	// ------------------------
	// eine Zeile einf$$HEX1$$fc00$$ENDHEX$$gen
	// ------------------------
	ds_report.InsertRow(0)

	// ------------------------------------------
	// Die Seitenzahl
	// ------------------------------------------
	ds_report.Object.c_page.text = "Page " + STRING(iPage) +  " - " + STRING(iMaxPage)
	// ------------------------------------------
	// Die Uhrzeitund das Datum
	// -------------------------------------------
	ds_report.Object.time_t.text = STRING(Today(),sdateformat) + "   " + STRING(now(), "HH:MM")
	// ------------------------------------------
	// die Logos
	// -------------------------------------------
	if iPrintColor > 1 then
		ds_report.Object.p_title.filename = sLogo_Black
	Else
		ds_report.Object.p_title.filename = sLogo_Color
	End if	
	
	// ------------------------------
	// Stauorte einzeichnen
	// ------------------------------
	lret = lret + uf_draw_stowage(iPage, sShortClassName)
	
	// ------------------------------
	// Freitexte einzeichnen
	// ------------------------------
	uf_draw_freetext(iPage)
	
	// ------------------------------
	// Leere Boxen einzeichnen
	// ------------------------------
	uf_draw_emptybox(iPage)
	
	// ------------------------------
	// Bitmaps einzeichnen
	// ------------------------------
	uf_draw_bitmap(iPage)
	
	// ------------------------------
	// Extra-Stauort einzeichnen
	// ------------------------------
	uf_draw_extrastowage(iPage)
		
	// ----------------------------------
	// Seitenzahlen neu durchnummerieren
	// ----------------------------------
	lPageCounter ++ 
	ds_report.Modify("c_page.text = '" + string(lPageCounter) + " - " + String(ds_print_job.RowCount()) + "'")
		
	// ------------------------------
	// Drucken
	//
	// 21.08.2002
	// Unterscheiden, ob Instanz im Web
	// oder im Powerbuilder-Client 
	// l$$HEX1$$e400$$ENDHEX$$uft
	// ----------------------------------
	ds_report.GetFullState(bDsState)
	
	//	f_blob_to_file("c:\temp\page_" + string(lJobCnt),bDsState) 
	
	if sWhereAmI = "WEB" then
		nPrintPDF.printpdf(bDsState, sPDFFileName)
	else
		// -------------------------------------------------
		// Aus dem Datastore ein PDF-File machen 
		// -------------------------------------------------
		iFileCounter ++
		sFileNames[iFileCounter] = f_gettemppath() + "CBASE-D-" + String(lJobCnt, "000") + "-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
		sFileDescriptions[iFileCounter] = "Galleygrafik Seite ( " + String(lJobCnt) + " ): " + f_airline_to_string(this.lAirlineKey) + " " + string(this.iFlightNo, "000") + " " + this.sSuffix
		
		// -------------------------------------------
		// create PDF from datawindow
		// -------------------------------------------
		// Evtl. Schwarzwei$$HEX1$$df00$$ENDHEX$$druck
		if iPrintColor > 1 then
			if uoPDF.of_convert(ds_report, "Galleydiagram: " + sHeaderText, sFileNames[iFileCounter], true, true, false, false) <> 0 then 
				sErrorText = "Galleygrafik: of_convert()"
				return -1
			end if	
		else
			if uoPDF.of_convert(ds_report, "Galleydiagram: " + sHeaderText, sFileNames[iFileCounter]) <> 0 then 
				sErrorText = "Galleygrafik: of_convert()"
				return -1
			end if	
		end if
		
	end if
NEXT


// -------------------------
// nicht gedruckte Stauorte
// -------------------------		
iAnzahlKopien = uf_CreateAddOnReport(bDsState) 

//Messagebox("", " " + String(iAnzahlKopien))

IF iAnzahlKopien > 0 THEN
	FOR iIndex = 1 TO iAnzahlKopien 
		
		// 21.08.2002
		// Unterscheiden, ob Instanz im Web
		// oder im Powerbuilder-Client 
		// l$$HEX1$$e400$$ENDHEX$$uft
		if sWhereAmI = "WEB" then
			nPrintPDF.printpdf(bDsState, sPDFFileName)
		else
			// -------------------------------------------------
			// Aus dem Datastore ein PDF-File machen 
			// -------------------------------------------------
			iFileCounter ++
			sFileNames[iFileCounter] = f_gettemppath() + "CBASE-D-" + String(Rand(32767)) + String(now(), "hhmmss") + ".pdf"
			sFileDescriptions[iFileCounter] = "Add-On-Report: " + f_airline_to_string(this.lAirlineKey) + " " + string(this.iFlightNo, "000") + " " + this.sSuffix
			
			
			ds_report.DataObject = "dw_loading_diagram_notprinted"
			ds_report.SetFullState(bDsState)
			
			// -------------------------------------------
			// create PDF from datawindow
			// -------------------------------------------	
			if uoPDF.of_convert(ds_report, "AddOn Report " + sHeaderText, sFileNames[iFileCounter]) <> 0 then 
				sErrorText = "Add-On Report: of_convert()"
				return -1
			end if		
			
		end if
	NEXT
END IF

// -------------------------
// Belly Stauorte
// -------------------------
IF uf_CreateBellyReport(bDsState) > 0 THEN
	// 21.08.2002
	// Unterscheiden, ob Instanz im Web
	// oder im Powerbuilder-Client 
	// l$$HEX1$$e400$$ENDHEX$$uft
	if sWhereAmI = "WEB" then
		nPrintPDF.printpdf(bDsState, sPDFFileName)
	else
		// -------------------------------------------------
		// Aus dem Datastore ein PDF-File machen 
		// -------------------------------------------------
		iFileCounter ++
		sFileNames[iFileCounter] = f_gettemppath() + "CBASE-D-" + String(Rand(32767)) + String(now(), "hhmmss") + ".pdf"
		sFileDescriptions[iFileCounter] = "Belly-Report: " + f_airline_to_string(this.lAirlineKey) + " " + string(this.iFlightNo, "000") + " " + this.sSuffix
		ds_report.DataObject = "dw_loading_diagram_belly"
		ds_report.SetFullState(bDsState)
		ds_report.Sort()
		ds_report.GroupCalc()
		
		// -------------------------------------------
		// create PDF from datawindow
		// -------------------------------------------	
		If uoPDF.of_convert(ds_report, "BellyReport " + sHeaderText, sFileNames[iFileCounter]) <> 0 then 
			sErrorText = "Belly Report: of_convert()"
			return -1
		end if		
	end if
	
END IF

// -------------------------
// Neue Packing Lists
// -------------------------
IF uf_CreateNewsReport(bDsState,dShowAsNew) > 0 THEN
	// 21.08.2002
	// Unterscheiden, ob Instanz im Web
	// oder im Powerbuilder-Client 
	// l$$HEX1$$e400$$ENDHEX$$uft
	if sWhereAmI = "WEB" then
		nPrintPDF.printpdf(bDsState, sPDFFileName)
	else
		// -------------------------------------------------
		// Aus dem Datastore ein PDF-File machen 
		// -------------------------------------------------
		iFileCounter ++
		sFileNames[iFileCounter] = f_gettemppath() + "CBASE-D-" + String(Rand(32767)) + String(now(), "hhmmss") + ".pdf"
		sFileDescriptions[iFileCounter] = "News-Report: " + f_airline_to_string(this.lAirlineKey) + " " + string(this.iFlightNo, "000") + " " + this.sSuffix
		ds_report.dataobject = 	"dw_loading_diagram_news"
		ds_report.SetFullState(bDsState)
		
		// -------------------------------------------
		// create PDF from datawindow
		// -------------------------------------------	
		If uoPDF.of_convert(ds_report, "NewsReport " + sHeaderText, sFileNames[iFileCounter]) <> 0 then 
			sErrorText = "News Report: of_convert()"
			return -1
		end if		
	end if
	
END IF

// -------------------------
// das File in den Blob
// laden. Dieser dient
// sp$$HEX1$$e400$$ENDHEX$$ter in der JSP
// als Stream
// -------------------------
if lActFlightToPrint = lFlightsToPrint and sWhereAmI = "WEB" THEN
	f_file_to_blob(sPDFFullFileName, bPDFStream, TRUE)
else
	if uoPDF.of_concatenate(sFileNames, sPDFFullFileName, true) <> 0 then
		sErrorText = "Error merging PDF-Files"
		return -1
	End if
end if


return 0


end function

public function long uf_createaddonreport (ref blob bstate);// ---------------------------------------------------
// diese Funktion ermittelt die nicht gedruckten
// Stauorte und erstellt einen Report
// $$HEX1$$fc00$$ENDHEX$$ber diese. Der R$$HEX1$$fc00$$ENDHEX$$ckgabewert ist die Anzahl zu
// druckender Seiten
//
// ---------------------------------------------------

if Not bPrintAddonReport Then
	return 0
end if


Long		lNext, &
			lAnz, &
			lRow, &
			l

Decimal	dcQuantity

String	sAircraftVersion, &
			sHeaderText

// -------------
// leeren
// -------------
ds_reportnotprinted.Reset()

lNext 	= 1

//f_print_datastore(ds_loadinglist) 
 
Do While lNext > 0
	
	lNext = ds_loadinglist.Find("compute_rowprinted = 0 AND cen_loadinglists_nbelly_container = 0 AND stationinstruction = 1", lNext, ds_loadinglist.RowCount())
	
	if lNext > 0 Then
		lAnz ++
		lRow = ds_reportnotprinted.InsertRow(0)
		ds_reportnotprinted.SetItem(lRow, "cen_galley_cgalley", ds_loadinglist.GetItemString(lNext, "cen_galley_cgalley"))
		ds_reportnotprinted.SetItem(lRow, "cen_stowage_cstowage", ds_loadinglist.GetItemString(lNext, "cen_stowage_cstowage"))
		ds_reportnotprinted.SetItem(lRow, "cen_stowage_cplace", ds_loadinglist.GetItemString(lNext, "cen_stowage_cplace"))
		ds_reportnotprinted.SetItem(lRow, "cen_stowage_ctext", ds_loadinglist.GetItemString(lNext, "cen_stowage_ctext"))
		ds_reportnotprinted.SetItem(lRow, "cen_packinglists_cunit", ds_loadinglist.GetItemString(lNext, "cen_packinglists_cunit"))
		ds_reportnotprinted.SetItem(lRow, "cen_loadinglists_cclass", ds_loadinglist.GetItemString(lNext, "cen_loadinglists_cclass"))
		ds_reportnotprinted.SetItem(lRow, "cen_packinglists_ctext", ds_loadinglist.GetItemString(lNext, "cen_packinglists_ctext"))
		ds_reportnotprinted.SetItem(lRow, "cen_stowage_nsort", ds_loadinglist.GetItemNumber(lNext, "cen_stowage_nsort"))
		ds_reportnotprinted.SetItem(lRow, "cen_galley_nsort", ds_loadinglist.GetItemNumber(lNext, "cen_galley_nsort"))
		//
		// Menge hat gefehlt
		//
		dcQuantity = ds_loadinglist.GetItemDecimal(lNext, "cen_loadinglists_nquantity")
		if dcQuantity > 1 then
			ds_reportnotprinted.SetItem(lRow, "cen_packinglists_ctext", string(dcQuantity) + " x " + ds_loadinglist.GetItemString(lNext, "cen_packinglists_ctext"))
		end if
		
		lNext ++
	end if
	
	if lNext > ds_loadinglist.RowCount() Then
		lNext = 0
	end if
	
Loop


// -----------------------------
// nun die $$HEX1$$dc00$$ENDHEX$$berlauftexte
// -----------------------------
lNext 	= 1
 
Do While lNext > 0
	lNext = ds_zustautextetoextrastauort.Find("compute_rowprinted = 0 AND cen_loadinglists_nbelly_container = 0", lNext, ds_zustautextetoextrastauort.RowCount())
	

	if lNext > 0 Then
		lAnz ++
		lRow = ds_reportnotprinted.InsertRow(0)
		ds_reportnotprinted.SetItem(lRow, "cen_galley_cgalley", ds_zustautextetoextrastauort.GetItemString(lNext, "cen_galley_cgalley"))
		ds_reportnotprinted.SetItem(lRow, "cen_stowage_cstowage", ds_zustautextetoextrastauort.GetItemString(lNext, "cen_stowage_cstowage"))
		ds_reportnotprinted.SetItem(lRow, "cen_stowage_cplace", ds_zustautextetoextrastauort.GetItemString(lNext, "cen_stowage_cplace"))
		ds_reportnotprinted.SetItem(lRow, "cen_stowage_ctext", ds_zustautextetoextrastauort.GetItemString(lNext, "cen_stowage_ctext"))
		ds_reportnotprinted.SetItem(lRow, "cen_packinglists_cunit", ds_zustautextetoextrastauort.GetItemString(lNext, "cen_packinglists_cunit"))
		ds_reportnotprinted.SetItem(lRow, "cen_loadinglists_cclass", ds_zustautextetoextrastauort.GetItemString(lNext, "cen_loadinglists_cclass"))
		ds_reportnotprinted.SetItem(lRow, "cen_packinglists_ctext", ds_zustautextetoextrastauort.GetItemString(lNext, "cen_packinglists_ctext"))
		ds_reportnotprinted.SetItem(lRow, "cen_stowage_nsort", ds_zustautextetoextrastauort.GetItemNumber(lNext, "cen_stowage_nsort"))
		ds_reportnotprinted.SetItem(lRow, "cen_galley_nsort", ds_zustautextetoextrastauort.GetItemNumber(lNext, "cen_galley_nsort"))
		//
		// Menge hat gefehlt
		//
		dcQuantity = ds_zustautextetoextrastauort.GetItemDecimal(lNext, "cen_loadinglists_nquantity")
		if dcQuantity > 1 then
			ds_reportnotprinted.SetItem(lRow, "cen_packinglists_ctext", string(dcQuantity) + " x " + ds_zustautextetoextrastauort.GetItemString(lNext, "cen_packinglists_ctext"))
		end if
	
		lNext ++
	end if
	
	if lNext > ds_zustautextetoextrastauort.RowCount() Then
		lNext = 0
	end if
Loop

if lAnz > 0 Then
	//
	// Flugnummer und Routing-Info
	//
	IF isnull(sSuffix) THEN
		sHeaderText = Trim(sAirlineCode + " " + String(iFlightNo))
	ELSE
		sHeaderText	= Trim(sAirlineCode + " " + String(iFlightNo) + " " + sSuffix)
	END IF	
	if not isnull(sFromTo) then
		sHeaderText = sHeaderText + "  " + sFromTo
	end if
	
	ds_reportnotprinted.Object.flight_t.text 	= sHeaderText
	// --------------------------------------------------------
	// Aircraft-Typ und Sitzplatzversion f$$HEX1$$fc00$$ENDHEX$$llen Feld actyp_t
	// --------------------------------------------------------
	if not isnull(sConfiguration) then
		sAircraftVersion = sOwnerCode + " " + sAircraftType + " " + sConfiguration
	else
		sAircraftVersion = sOwnerCode + " " + sAircraftType
	end if
	ds_reportnotprinted.Object.actyp_t.text  				= sAircraftVersion
	ds_reportnotprinted.Object.flightdetail_t.text 		= String(dtdeparturedate, sDateFormat) + "  " + String(tdeparturetime, "HH:MM")
	ds_reportnotprinted.Object.time_t.text 				= string(Today(), sdateformat) + "   " + string(now(), "HH:MM")
	ds_reportnotprinted.Object.signature_t.text			= sOrga
	
	// die Farbe und das Logo
	if iPrintColor > 1 Then
		ds_reportnotprinted.Object.reportheadline_t.Color = "0"
		ds_reportnotprinted.Object.r_1.Pen.Color = "0"
		ds_reportnotprinted.Object.r_2.Pen.Color = "0"
		ds_reportnotprinted.Object.l_2.Pen.Color = "0"
	end if
	

	if iPrintColor > 1 Then
		ds_reportnotprinted.Object.p_title.filename = slogo_black
	else
		ds_reportnotprinted.Object.p_title.filename = slogo_color
	end if
	
	ds_reportnotprinted.SetSort("cen_galley_nsort A, cen_stowage_nsort A")
	ds_reportnotprinted.Sort()
	

	// -----------------------------
	// wir f$$HEX1$$fc00$$ENDHEX$$llen den per Ref $$HEX1$$fc00$$ENDHEX$$ber-
	// geben Blob
	// -----------------------------
	if iPrintColor > 1 Then
		ds_reportnotprinted.Modify("DataWindow.Print.Color='2'")
	end if
	
	//ds_reportnotprinted.Print()
	
	if ds_reportnotprinted.GetFullState(bState) = -1 Then
		ianzahladdonreports = -1
	end if
	
else
	ianzahladdonreports = 0
end if

return ianzahladdonreports  
end function

public function long uf_createbellyreport (ref blob bdsstate);// ---------------------------------------------------
// diese Funktion ermittelt die Belly-Stauorte und 
// erstellt einen Report $$HEX1$$fc00$$ENDHEX$$ber diese. Der R$$HEX1$$fc00$$ENDHEX$$ckgabewert 
// ist die Anzahl der gedruckten Belly-Stauorte
//
// ---------------------------------------------------

if Not bPrintBellyReport Then
	return 0
end if


Long		lNext, &
			lAnz, &
			lRow

String	sHeaderText, &
			sAircraftVersion

// -------------
// leeren
// -------------
ds_belly.Reset()

lNext 	= 1
 
Do While lNext > 0
	lNext = ds_loadinglist.Find("cen_loadinglists_nbelly_container > 0 AND stationinstruction = 1", lNext, ds_loadinglist.RowCount())

	if lNext > 0 Then
		lAnz ++
		lRow = ds_belly.InsertRow(0)
		ds_belly.SetItem(lRow, "cen_loadinglists_nbelly_container", ds_loadinglist.GetItemNumber(lNext, "cen_loadinglists_nbelly_container"))
		ds_belly.SetItem(lRow, "cen_galley_cgalley", ds_loadinglist.GetItemString(lNext, "cen_galley_cgalley"))
		ds_belly.SetItem(lRow, "cen_stowage_cstowage", ds_loadinglist.GetItemString(lNext, "cen_stowage_cstowage"))
		ds_belly.SetItem(lRow, "cen_stowage_cplace", ds_loadinglist.GetItemString(lNext, "cen_stowage_cplace"))
		ds_belly.SetItem(lRow, "cen_packinglists_cunit", ds_loadinglist.GetItemString(lNext, "cen_packinglists_cunit"))
		ds_belly.SetItem(lRow, "cen_packinglists_ctext", ds_loadinglist.GetItemString(lNext, "cen_packinglists_ctext"))
		ds_belly.SetItem(lRow, "cen_stowage_nsort", ds_loadinglist.GetItemNumber(lNext, "cen_stowage_nsort"))
		ds_belly.SetItem(lRow, "cen_galley_nsort", ds_loadinglist.GetItemNumber(lNext, "cen_galley_nsort"))
		ds_belly.SetItem(lRow, "cen_packinglist_index_cpackinglist", ds_loadinglist.GetItemString(lNext, "cen_packinglist_index_cpackinglist"))
		ds_belly.SetItem(lRow, "cen_loadinglists_nquantity", ds_loadinglist.GetItemNumber(lNext, "cen_loadinglists_nquantity"))

		ds_belly.SetItem(lRow, "cen_loadinglists_nfor_to_code", ds_loadinglist.GetItemNumber(lNext, "cen_loadinglists_nfor_to_code"))
		ds_belly.SetItem(lRow, "sys_three_letter_codes_ctlc", ds_loadinglist.GetItemString(lNext, "sys_three_letter_codes_ctlc"))
		lNext ++
	end if
	
	if lNext > ds_loadinglist.RowCount() Then
		lNext = 0
	end if
Loop

if lAnz > 0 Then
	//
	// Flugnummer und Routing-Info
	//
	IF isnull(sSuffix) THEN
		sHeaderText = Trim(sAirlineCode + " " + String(iFlightNo))
	ELSE
		sHeaderText	= Trim(sAirlineCode + " " + String(iFlightNo) + " " + sSuffix)
	END IF	
	if not isnull(sFromTo) then
		sHeaderText = sHeaderText + "  " + sFromTo
	end if
	ds_belly.Object.flight_t.text 				= sHeaderText
	// --------------------------------------------------------
	// Aircraft-Typ und Sitzplatzversion f$$HEX1$$fc00$$ENDHEX$$llen Feld actyp_t
	// --------------------------------------------------------
	if not isnull(sConfiguration) then
		sAircraftVersion = sOwnerCode + " " + sAircraftType + " " + sConfiguration
	else
		sAircraftVersion = sOwnerCode + " " + sAircraftType
	end if
	ds_belly.Object.actyp_t.text  				= sAircraftVersion
	ds_belly.Object.flightdetail_t.text 		= String(dtDepartureDate, sDateFormat) + "  " + string(tDepartureTime, "HH:MM")
	ds_belly.Object.time_t.text 					= string(Today(), sDateformat) + "   " + string(now(), "HH:MM")
	ds_belly.Object.signature_t.text				= sOrga

	// die Farbe und das Logo
	if iPrintColor > 1 Then
		ds_belly.Object.reportheadline_t.Color = "0"
		ds_belly.Object.r_1.Pen.Color = "0"
		ds_belly.Object.r_2.Pen.Color = "0"
		ds_belly.Object.l_2.Pen.Color = "0"
	end if
	
	
	if iPrintColor > 1 Then
		ds_belly.Object.p_title.filename = 	slogo_black
	else
		ds_belly.Object.p_title.filename = 	slogo_color
	end if
	
	
	ds_belly.GroupCalc()
	
	if iPrintColor > 1 Then
			ds_belly.Modify("DataWindow.Print.Color='2'")
	end if
	
	//ds_belly.Print()
	
	if ds_belly.GetFullState(bDsState) = -1 Then
		lAnz = -1
	end if
else
	lAnz = 0
end if

return lAnz  
end function

public function uo_loading uf_generate_loading (ref s_all_flight_infos sinfo);// ------------------------------------------------------
// Diese Methode arbeitet ein Flugereignis ab und liefert
// eine komplette Beladung f$$HEX1$$fc00$$ENDHEX$$r diesen Flug
// ------------------------------------------------------
	Long			lRow, i
	String		sGalley
	Long			lGalleyKey
	Integer		iBellyContainer
	
	String		sStauort
	String		sPlatz
	
	uo_loading_galley 	uoLoadingGalley
	uo_loading_stowage 	uoLoadingStowage
	uo_loading 				uoLoading
	
	uoLoading = CREATE uo_loading

// --------------------------------------------------------------
// Vorinitialisieren
// --------------------------------------------------------------	
	sLLFooter			= ""
// --------------------------------------------------------------
// And Go...
// --------------------------------------------------------------	
	uoLoading.sAirlineCode		= sAirlineCode
	uoLoading.lAirlineKey		= lAirlineKey
	uoLoading.iFlightNumber		= iFlightNo
	uoLoading.sSuffix				= sSuffix
	uoLoading.iLeg					= iActLeg
	
// ----------------------------------------
// Wir erstellen die Beladematrix
// Der Parameter sinfo wurde per Referenz
// $$HEX1$$fc00$$ENDHEX$$bergeben !
// ----------------------------------------
	sInfo = uf_matrix(sInfo)
	if sInfo.iStatus = -1 Then
		return uoLoading
	end if
// ----------------------------------------
// Wir Retrieven
// ----------------------------------------
	uf_retrieve()
// ----------------------------------------
// In ds_loadinglist steht nun die fertige Beladung
// f$$HEX1$$fc00$$ENDHEX$$r diesen Flug. Wir erstellen das 
// Belade-Objekt
// ----------------------------------------
	if ds_loadinglist.RowCount() = 0 Then
		Destroy uoLoading
	end if

	For lRow = 1 To ds_loadinglist.RowCount()
		//
		// Achtung: Stationsauftrag
		// Nur die Packinglists ber$$HEX1$$fc00$$ENDHEX$$cksichtigen, die auch f$$HEX1$$fc00$$ENDHEX$$r die Station 
		// interessant sind.
		//
		if ds_loadinglist.GetItemNumber(lRow, "stationinstruction") = 0 then
			continue
		end if
		i++
		// ---------------
		// die Galley
		// ---------------
		sGalley				= ds_loadinglist.GetItemString(lRow, "cen_galley_cgalley")
		lGalleyKey			= ds_loadinglist.GetItemNumber(lRow, "cen_galley_ngalley_key")
		iBellyContainer	= ds_loadinglist.GetItemNumber(lRow, "cen_loadinglists_nbelly_container")
		uoLoading.sLoadinglists[i] = ds_loadinglist.GetItemString(lRow, "cen_loadinglist_index_cloadinglist")
		
		// ---------------
		// der Stauort
		// ---------------
		sStauort	= ds_loadinglist.GetItemString(lRow, "cen_stowage_cstowage")
		sPlatz	= ds_loadinglist.GetItemString(lRow, "cen_stowage_cplace")
		
		uoLoadingStowage = uoLoading.uf_InsertStowage(lGalleyKey, sGalley, iBellyContainer, sStauort, sPlatz)
		
		if isValid(uoLoadingStowage) Then
			
			uoLoadingStowage.lStowageKey 			= ds_loadinglist.GetItemNumber(lRow, "cen_galley_ngalley_key")
			
			
			uoLoadingStowage.sPackingList			= ds_loadinglist.GetItemString(lRow, "cen_packinglist_index_cpackinglist")
			uoLoadingStowage.lPackingListKey		= ds_loadinglist.GetItemNumber(lRow, "cen_packinglist_index_npackinglist_index_key")
			uoLoadingStowage.sPLText				= ds_loadinglist.GetItemString(lRow, "cen_packinglists_ctext")
			
			
			uoLoadingStowage.sPLTextShort			= ds_loadinglist.GetItemString(lRow, "cen_packinglists_ctext_short")
			uoLoadingStowage.sAddOnText			= ds_loadinglist.GetItemString(lRow, "cen_loadinglists_cadd_on_text")
			uoLoadingStowage.sZuStauText			= ds_loadinglist.GetItemString(lRow, "compute_zustautext")
			uoLoadingStowage.sUnit					= ds_loadinglist.GetItemString(lRow, "cen_packinglists_cunit")
					
			uoLoadingStowage.sMealCode				= ds_loadinglist.GetItemString(lRow, "cen_loadinglists_cmeal_control_code")
			uoLoadingStowage.dWeight				= ds_loadinglist.GetItemDecimal(lRow, "cen_stowage_nweight")
			
			uoLoadingStowage.sLoadingList			= ds_loadinglist.GetItemString(lRow, "cen_loadinglist_index_cloadinglist")
			uoLoadingStowage.lLoadingListKey		= ds_loadinglist.GetItemNumber(lRow, "cen_loadinglist_index_nloadinglist_index_key")
			uoLoadingStowage.lLoadingListType	= ds_loadinglist.GetItemNumber(lRow, "cen_loadinglist_index_nloadinglist_key")
	
			uoLoadingStowage.iForToCode			= ds_loadinglist.GetItemNumber(lRow, "cen_loadinglists_nfor_to_code")
			uoLoadingStowage.sSICode				= ds_loadinglist.GetItemString(lRow, "compute_sicodes")
			
			if uoLoadingStowage.iForToCode > 0 Then
				if uoLoadingStowage.iForToCode  = 1 Then
					uoLoadingStowage.sForToCode = "for"
				else
					uoLoadingStowage.sForToCode = "to"
				end if
			end if
	
			uoLoadingStowage.sQAQActioncode		= ds_loadinglist.GetItemString(lRow, "compute_qaq_actioncode")
			
			uoLoadingStowage.sForToDestination	= ds_loadinglist.GetItemString(lRow, "sys_three_letter_codes_ctlc")
			uoLoadingStowage.lForToDestination	= ds_loadinglist.GetItemNumber(lRow, "forto_ntlc_key")
			
			uoLoadingStowage.sClass					= ds_loadinglist.GetItemString(lRow, "cen_loadinglists_cclass")
			uoLoadingStowage.sClassLong			= ds_loadinglist.GetItemString(lRow, "compute_classname")
			
			uoLoadingStowage.lQAQHandlingKey 	= ds_loadinglist.GetItemNumber(lRow, "compute_handling_key")
		// --------------------------------------------------------------
		// Wir suchen die Legnummer, in der dieser Stauort beladen wurde
		// --------------------------------------------------------------
			uoLoadingStowage.iLoadedAtLeg	= ds_matrix.GetItemNumber(ds_matrix.find("ssl_zbl_qaq = '" &
													+ uoLoadingStowage.sLoadingList + "'",1,ds_matrix.RowCount()), &
													"nleg")
		end if
	Next

return uoLoading
end function

public function long uf_retrieve ();	integer 	i, iWorkingLeg
	Long		lAnz, lRow
	long		lArgRetrieve[]
	Long		lSecondArgRetrieve[1]
	Long		lQAQHandlingKey, lHandling
	Long 		lCurrentLeg
	string	sTemp
	uo_current_packinglists	uoPLs
	
// --------------------------------------------------------------
// Default Farb Schema
// --------------------------------------------------------------	
	If uf_default_color() = -1 Then
		sErrorText = "Default diagram-color not defined."	
		return -1
	End if	

// ----------------------------------------------------------------------
// wir holen der Reihe nach alle Schl$$HEX1$$fc00$$ENDHEX$$sselnummern
// aus der Matrix und f$$HEX1$$fc00$$ENDHEX$$hren Retrievs durch und zwar:
//		alle vom Typ 1 (Loadinglist) auf dw_1
//		alle vom Typ 2 (Supplement Loadinglist) auf dw_2 mit anschlie$$HEX1$$df00$$ENDHEX$$ender 
//		$$HEX1$$dc00$$ENDHEX$$bertrag nach dw_1, Typ 3 (Station Instruction) kommt sp$$HEX1$$e400$$ENDHEX$$ter
// ----------------------------------------------------------------------
	lAnz = 0
	lCurrentLeg = iActleg
	For lRow = ds_matrix.RowCount() to 1 Step -1
		if ds_matrix.GetItemNumber(lRow, "ntyp") = 1 Then
			lAnz ++
			ds_matrix.SetItem(lRow,"nused",1)
			lArgRetrieve[lAnz] = ds_matrix.GetItemNumber(lRow, "nkey")
		end if
// -------------------------------------------------------------
// die Grundbeladung die dem aktuellen Leg am n$$HEX1$$e400$$ENDHEX$$chsten ist.
// -------------------------------------------------------------
		If lCurrentLeg <> ds_matrix.GetItemNumber(lRow, "nleg") Then
			lCurrentLeg = ds_matrix.GetItemNumber(lRow, "nleg")
		End if	
		
		If lAnz > 0 and ds_matrix.GetItemNumber(lRow, "nleg") < lCurrentLeg Then
			Exit
		End if	
	Next
	
	
//	f_print_datastore(ds_Matrix)
	
// -------------------------------------
// Galleygrafik nur mit AC-Stamm (leer)
// -------------------------------------
	If iEmptyDiagram = 0 Then
		// -------------------------------------
		// #4918 Kein Retrieve bei leerem Array
		// -------------------------------------
		lAnz = 0
		If Upperbound(lArgRetrieve) > 0 Then
			lAnz = ds_loadinglist.Retrieve(lArgRetrieve, dtDepartureDate, String(tDepartureTime, "HH:MM"), String(iVerkehrstag), lArgschema)
		End If
		if lAnz = 0 Then
			sErrorText = "No rows in datastore ds_loadinglist."	
			return -1
		end if
	Else
		lAnz = 1
	End if
		
// -------------------------------------
// Retrieve auf die zus$$HEX1$$e400$$ENDHEX$$tzlichen Infos.
// -------------------------------------
	ds_emptybox.Retrieve(lAircraftKey)
	ds_bitmap.Retrieve(lAircraftKey)
	ds_freetext.Retrieve(lAircraftKey)
	ds_StauorteOhneInhalte.Retrieve(lAircraftKey, lArgSchema)
	ds_schema.Retrieve(sMandant, sAirlineCode)
	ds_exclude.Retrieve(lAirlineKey)
	ds_classname.Retrieve(lAirlineKey)
	ds_childstowages.Retrieve(lAirlineKey)
// ----------------------------------------------------------------------
// First Delete. Alles weg was nicht dem G$$HEX1$$fc00$$ENDHEX$$ltigkeitsbereich entspricht.
// ----------------------------------------------------------------------
	uf_delete(ds_loadinglist)
// ----------------------------------------------------------------------
// Retrieves der ZBL's auf DW2 bzw. QAQ Verarbeitung
// ----------------------------------------------------------------------
	For lRow = 1 To ds_matrix.RowCount()
		// ------------------------------------------------
		// Eine ZBL Satz, aber nur die f$$HEX1$$fc00$$ENDHEX$$r das aktuelle Leg
		// ------------------------------------------------
		if ds_matrix.GetItemNumber(lRow, "ntyp") = 2 and &
			ds_matrix.GetItemNumber(lRow, "nleg") = iActleg Then
			
			ds_matrix.SetItem(lRow,"nused",1)
		
			lSecondArgRetrieve[1] = ds_matrix.GetItemNumber(lRow, "nkey")
			sTemp						 = ds_matrix.GetItemstring(lRow, "ssl_zbl_qaq")
			lAnz = ds_suplementloadingslist.Retrieve(lSecondArgRetrieve[], dtDepartureDate, String(tDepartureTime, "HH:MM"), String(iVerkehrstag), lArgschema)
		// ----------------------------------------------------------------------
		// First Delete. Alles weg was nicht dem G$$HEX1$$fc00$$ENDHEX$$ltigkeitsbereich entspricht.
		// ----------------------------------------------------------------------
			uf_delete(ds_suplementloadingslist)
			ds_suplementloadingslist.RowsCopy(1, ds_suplementloadingslist.RowCount(), Primary!, ds_loadinglist, ds_loadinglist.RowCount() + 1, Primary!)
		// ----------------------------------------------------------------------
		// Wir wenden die Actioncodes an.
		//	----------------------------------------------------------------------
			uf_actioncode()
		// ----------------------------------------------------------------------
		// Second Delete. Alles weg was den Actioncodes zum Opfer fiel.
		//	----------------------------------------------------------------------
			uf_delete(ds_loadinglist)
		end if
		
//		f_print_datastore(ds_matrix)
		
	// ---------------------------------------------------
	// Ein QAQ Satz, aber nur die f$$HEX1$$fc00$$ENDHEX$$r das aktuelle Leg
	// ---------------------------------------------------
		if ds_matrix.GetItemNumber(lRow, "ntyp") = 3 and &
			ds_matrix.GetItemNumber(lRow, "nleg") = iActleg Then
			ds_matrix.SetItem(lRow,"nused",1)
			// -----------------------------------
			// wir ermitteln die unterschiedlichen
			// PL's f$$HEX1$$fc00$$ENDHEX$$r den Retrive auf QAQ
			// -----------------------------------
			uoPLs 				= uf_GetPackinglists()
			lQAQHandlingKey 	= ds_matrix.GetItemNumber(lRow, "nkey")
			iWorkingLeg			= ds_matrix.GetItemNumber(lRow, "nleg")
			lHandling			= ds_matrix.GetItemNumber(lRow, "nhandlingkey")
	
			ds_matrix_qaq_processing.Retrieve(uoPLs.lPLKey[], &
														 dtDepartureDate, 	&
														 String(tDepartureTime, "HH:MM"), &
														 lQAQHandlingKey)
			// -----------------------------------------------------------------------------------
			// ACHTUNG: Die neuen Actioncodes der QAQ in eine neu zu definierenden Spalte
			// $$HEX1$$fc00$$ENDHEX$$bertragen, damit dieser auf das Diagramm gedruckt werden kann.
			// -----------------------------------------------------------------------------------
	
			uf_qaq_actioncode(iWorkingLeg, lHandling)
			DESTROY uoPLs 
		end if
	Next

	
// ----------------------------------------------------------------------
// 09.01.2002
// Bereinigung For-To-Codes
// $$HEX1$$dc00$$ENDHEX$$berall, wo wir schon aufgeschlagen sind, k$$HEX1$$f600$$ENDHEX$$nnen wir die For-To-Codes
// rausl$$HEX1$$f600$$ENDHEX$$schen!
// ----------------------------------------------------------------------
	uf_reset_for_to_codes()
// ----------------------------------------------------------------------
// Retrieve auf die Extra-Stauorte f$$HEX1$$fc00$$ENDHEX$$r oben generierte Beladung
// wird f$$HEX1$$fc00$$ENDHEX$$r Diagramm ben$$HEX1$$f600$$ENDHEX$$tigt.
// ----------------------------------------------------------------------
	uf_retrieveextrastowage()
	Return lAnz

end function

public function s_all_flight_infos uf_generate_information (s_all_flight_infos sinfo);// --------------------------------------------------------------
// Vorinitialisieren
// --------------------------------------------------------------	
	

// ----------------------------------------
// Wir erstellen die Beladematrix
// ----------------------------------------
	sInfo = uf_matrix(sInfo)
	if sInfo.iStatus = -1 Then
		return sInfo
	end if



	return sInfo
end function

public function s_all_flight_infos uf_generate_diagram (s_all_flight_infos sinfo);// --------------------------------------------------------------
// uf_generate_diagram
//
// Einstiegsfunktion von uo_loading_list
//
// Ermittelt die Beladung und erstellt das Galley Diagram
// --------------------------------------------------------------	
Long		lRow,lUsed
String	sTemp
Integer	iLeg, iLegPrev,iLogo, iCounter
time		start,ende

// --------------------------------------------------------------
// Vorinitialisieren
// --------------------------------------------------------------	
bPDFStream			= BLOB("")
bLabelStream		= BLOB("")
sLLFooter			= ""
sFromTo				= sInfo.sFrom + "-" + sInfo.sTo

// ----------------------------------------
// das Setup laden
// ----------------------------------------
uf_diagram_setup(handle(this), sInfo.lLayoutKey, sInfo.sInvocation)

// -------------------------
// die Logos
// -------------------------
If ds_diagramlayout.Rowcount() > 0 Then
	iLogo = ds_diagramlayout.GetitemNumber(1,"nlogo")
	sinfo = uf_get_dblogo(iLogo,sinfo)
End if

// ----------------------------------------
// Wir erstellen die Beladematrix
// ----------------------------------------
sInfo = uf_matrix(sInfo)

if this.iUseExclusion = 1 then
	uf_loadinglist_exclusion()
end if

if sInfo.iStatus = -1 Then
	return sInfo
end if

// ----------------------------------------
// Wir Retrieven
// ----------------------------------------
if uf_retrieve() = -1 Then
	sInfo.sStatus = sErrortext
	sInfo.iStatus = -1
	return sInfo
end if

// ----------------------------------------
// Die Farbinfos
// ----------------------------------------
uf_add_color_text()

// ----------------------------------------
// Der Footer mit den LL und SLL Infos
// setzen. Die Info bekommen wir aus der
// Matrix
// ----------------------------------------
FOR lRow = 1 To ds_matrix.RowCount()
	iLeg 	= ds_matrix.GetItemNumber(lRow, "nleg")
	sTemp = ds_matrix.GetItemString(lRow, "ssl_zbl_qaq")
	lUsed = ds_matrix.GetItemNumber(lRow, "nused")
	if Not isNull(iLeg) AND lUsed = 1 Then
		iCounter ++
		sLoadingSequence[iCounter] = String(iLeg) + ". Leg = " + sTemp
		if iLeg <> iLegPrev Then
			if lRow = 1 Then
				sLLFooter = sLLFooter + " " + String(iLeg) + ". Leg = " + sTemp
			else
				sLLFooter = sLLFooter + " - " +  String(iLeg) + ". Leg = " + sTemp
			end if
		else
			sLLFooter = sLLFooter + ", " + sTemp
		end if
	end if
	iLegPrev = iLeg
NEXT

// -----------------------
// Wir kalkulieren die 
// Teilgewichte der 
// Stauorte aber nur wenn
// auch Gewichte gedruckt
// werden sollen
// -----------------------
lRow = ds_diagramlayout.Find("nlayout_field=14", 1, ds_diagramlayout.RowCount())	
if lRow > 0 Then
	uf_CalcWeight()
end if		

// --------------------------
// wir generieren 
// 26.08.2002
// Wenn's ein PB-Client ist
// dann das uoPDF 
// --------------------------
if sWhereAmi = "WEB" then
	sConfiguration = uf_get_configuration(sInfo.lAircraft_Key)
end if

//f_print_datastore(ds_loadinglist)

// --------------------------
// Newsdatum f$$HEX1$$fc00$$ENDHEX$$r ContentReport
// --------------------------
dShowAsNew		= Relativedate(date(sInfo.sdeparturedate),-iContentsDays)

// -------------------------------------------------------------------------
// 06.10.2009, KF
// GGf keine PDF's erstellen, PAULA IF bracucht nur das ds_loadingslist
// -------------------------------------------------------------------------
if iPrintDiagram = 1 then
	if uf_print() = -1 then
		sInfo.iStatus = -1
		sInfo.sStatus = sErrorText
	end if	
end if

return sInfo

end function

public function boolean uf_actioncode ();	long 		i
	  
// ----------------------------------------------------------------
// M$$HEX1$$f600$$ENDHEX$$gliche Actioncode's
//	1. L	-> Load	
//	2. O	-> Offload
//	3. C	-> Crewrequest							(l$$HEX1$$f600$$ENDHEX$$schen)
//	4. X	-> Austauschen
//	5. R	-> Auff$$HEX1$$fc00$$ENDHEX$$llen  / Replenish			(Intern Austauschen)
// 6. Z  -> Zustauen								(Intern Load)
// 7. N  -> No Action							(Keine Action)
// ----------------------------------------------------------------
	For i = 1 to ds_loadinglist.Rowcount()
	// -------------------------------------------------
	// Actioncode Crewrequest (C)
	// -------------------------------------------------
		If ds_loadinglist.GetItemString(i,"cen_loadinglists_cactioncode") = 'C' Then
		// -------------------------------------------------
		// diesen Satz in Compute Actioncode markieren.
		// -------------------------------------------------
			ds_loadinglist.Setitem(i,"compute_actioncode",1) 
		End If
	// -------------------------------------------------
	// Actioncode Offload (O), nur die vom St$$HEX1$$fc00$$ENDHEX$$cklistenTyp
	// Supplement Loading List sind. (2)
	// -------------------------------------------------
		If ds_loadinglist.Getitemstring(i,"cen_loadinglists_cactioncode") = 'O' and &
			ds_loadinglist.GetitemNumber(i,"cen_loadinglist_index_nloadinglist_key") = 2 Then
		// -------------------------------------------------
		// diesen Satz in Compute Actioncode markieren.
		// -------------------------------------------------
			ds_loadinglist.Setitem(i,"compute_actioncode",1) 
			uf_offload(i)
		End If
	// -------------------------------------------------
	// Actioncode Austauschen (X) oder Austauschen (R), 
	//	nur die vom St$$HEX1$$fc00$$ENDHEX$$cklistenTyp Supplement Loading List
	// sind. (2)
	// -------------------------------------------------
		If (ds_loadinglist.Getitemstring(i,"cen_loadinglists_cactioncode") = 'X' OR &
			 ds_loadinglist.Getitemstring(i,"cen_loadinglists_cactioncode") = 'R') and &
			 ds_loadinglist.GetitemNumber(i,"cen_loadinglist_index_nloadinglist_key") = 2 Then
		// -------------------------------------------------------
		// dieser Satz bleibt erhalten, und wird auf Load gesetzt
		// -------------------------------------------------------
			uf_offload(i)
			ds_loadinglist.SetItem(i,"cen_loadinglists_cactioncode", "L") 
		End If
	// -----------------------------------------------------------
	// Actioncode Zustauen (Z), nur die vom St$$HEX1$$fc00$$ENDHEX$$cklistenTyp
	// Supplement Loading List sind (2) und deren Inhalte 
	// in der Galley sind (cen_loadinglists_nbelly_container = 0)
	// Zustauorte aus der Belly nicht zustauen => gehen auf
	// auf Belly-Report
	// -----------------------------------------------------------
		If ds_loadinglist.Getitemstring(i,"cen_loadinglists_cactioncode") = 'Z' and &
			ds_loadinglist.GetitemNumber(i,"cen_loadinglist_index_nloadinglist_key") = 2 AND &
			ds_loadinglist.GetitemNumber(i,"cen_loadinglists_nbelly_container") = 0 Then
		// -------------------------------------------------
		// den Text der ZBL in den zugeh$$HEX1$$f600$$ENDHEX$$rigen Stauort $$HEX1$$fc00$$ENDHEX$$ber-
		// tragen
		// -------------------------------------------------
			ds_loadinglist.Setitem(i,"compute_actioncode",1) 
			uf_zustauen(i)
		End If
	// -----------------------------------------------------------
	// Actioncode (N), nur die vom St$$HEX1$$fc00$$ENDHEX$$cklistenTyp
	// Supplement Loading List sind (2) 
	// -----------------------------------------------------------		
		If ds_loadinglist.Getitemstring(i,"cen_loadinglists_cactioncode") = 'N' and &
			ds_loadinglist.GetitemNumber(i,"cen_loadinglist_index_nloadinglist_key") = 2 Then
		// -------------------------------------------------
		// diesen Actioncode $$HEX1$$fc00$$ENDHEX$$bertragen, und sp$$HEX1$$e400$$ENDHEX$$ter bei der 
		// SI-Code bearbeitung ber$$HEX1$$fc00$$ENDHEX$$cksichtigen.
		// -------------------------------------------------
		// -------------------------------------------------
		// diesen Satz in Compute Actioncode markieren.
		// -------------------------------------------------
			ds_loadinglist.Setitem(i,"compute_actioncode",1) 
			uf_no_action(i)
		End If		
	// -------------------------------------------------
	// Stauorte entfernen, welche in der Exclude-Tabelle
	// hinterlegt sind 
	// -------------------------------------------------
		if uf_exclude(i) Then
			ds_loadinglist.Setitem(i,"compute_exclude",1) 
		end if
	// -------------------------------------------------
	// Die Child-Stauorte ermitteln und den asso. Stauorten
	// zuordnen
	// -------------------------------------------------
		uf_childStowage(i)
	Next
	
	return True

end function

public function string uf_get_configuration (long arg_aircraft_key);//
// Hole Aircraft-Version
//
string	sConfig

select cConfiguration
into :sConfig
from cen_aircraft
where naircraft_key = :arg_aircraft_key;

if sqlca.sqlcode <> 0 then
	return string(sqlca.sqlcode) + "/" + string(arg_aircraft_key)
else
	return sConfig
end if

return ""

end function

public function integer uf_loadinglist_exclusion ();// -----------------------------------------------------------
// Negativliste ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
// -----------------------------------------------------------

String sNumber
String sResult
Long	 i
	
For i = ds_matrix.Rowcount() to 1 step -1
	sNumber = ds_matrix.GetitemString(i,"ssl_zbl_qaq")
	
	select cloadinglist into :sResult 
	from loc_unit_ll_exclude 
	where cloadinglist = :sNumber and
			cunit = :this.sUnit and
			dvalid_from <= :this.dtDepartureDATE and
			dvalid_to >= :this.dtDepartureDATE ;
			
	// ------------------------------------------		
	// St$$HEX1$$fc00$$ENDHEX$$ckliste ist definiert, dann l$$HEX1$$f600$$ENDHEX$$schen		
	// ------------------------------------------
	if sqlca.sqlcode = 0 then
		ds_matrix.DeleteRow(i)
		
	elseif sqlca.sqlcode < 0 then
		f_db_error(sqlca, "LL: " + sNumber )
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

on uo_loading_list.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_loading_list.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;Integer	iRet

// Objekt zur Berechnung von Schriftarten erzeugen
iuo_FontCalc = CREATE uo_font_calc

//--------------------------------------------------------------
// Powerbuilder-Client 
//--------------------------------------------------------------
sWhereAmI = "PB"
	
// ---------------------------------------------
// die DataStores
// ---------------------------------------------	
ds_print_job						= create DataStore
ds_childstowages					= create DataStore
ds_zustautextetoextrastauort	= create DataStore
ds_belly								= create DataStore
ds_exclude							= create DataStore
ds_classname						= create DataStore
ds_reportnotprinted				= create DataStore
ds_extra								= create DataStore
ds_report							= create uo_report_dw2inpixel
ds_diagramlayout					= create DataStore
ds_emptybox							= create DataStore
ds_bitmap							= create DataStore
ds_freetext							= create DataStore
ds_schema							= create DataStore
ds_loadinglist						= create DataStore 
ds_stauorteohneinhalte			= create DataStore
ds_matrix							= create DataStore
ds_matrix_routingplan_qaq		= create DataStore
ds_suplementloadingslist		= create DataStore 
ds_matrix_qaq_processing		= create DataStore
ds_areas_local						= create DataStore
ds_areas_default					= create DataStore
ds_new_packinglists				= create DataStore
ds_actual_layout					= create DataStore
ds_matrix_newspaper				= create DataStore
ds_workstations					= create DataStore	

ds_print_job.dataobject 						= "dw_printjob"
ds_childstowages.dataobject 					= "dw_child_stowages"
ds_zustautextetoextrastauort.dataobject 	= "dw_loading_list_result"
ds_belly.dataobject 								= "dw_loading_diagram_belly"
ds_exclude.dataobject 							= "dw_diagram_exclude_airline"
ds_classname.dataobject 						= "dw_classname"
ds_reportnotprinted.dataobject 				= "dw_loading_diagram_notprinted"
ds_extra.dataobject 								= "dw_printextra"
ds_diagramlayout.dataobject 					= "dw_diagram_layout_detail_update"
ds_emptybox.dataobject 							= "dw_printemptybox"
ds_bitmap.dataobject 							= "dw_printbitmap"
ds_freetext.dataobject 							= "dw_printfreetext"
ds_schema.dataobject 							= "dw_diagram_colors"
ds_loadinglist.dataobject 						= "dw_loading_list_result"
ds_stauorteohneinhalte.dataobject 			= "dw_allstowagetoprint"
ds_matrix.dataobject 							= "dw_matrix"
ds_matrix_routingplan_qaq.dataobject 		= "dw_matrix_routinginfo_qaq"
ds_suplementloadingslist.dataobject 		= "dw_loading_list_result"
ds_matrix_qaq_processing.dataobject 		= "dw_matrix_qaq_accodes"
ds_areas_local.dataobject 						= "dw_areas_local"
ds_areas_default.dataobject 					= "dw_areas_default"
ds_actual_layout.dataobject 					= "dw_actual_layout"

ds_matrix_newspaper.dataobject 				= "dw_matrix_newspaper"
ds_workstations.dataobject 					= "dw_workstations_local"	

ds_report.sOrga = sOrga

ds_new_packinglists.dataobject 				= "dw_loading_diagram_news"
end event

event destructor;Long		lFiles

// Objekt zur Berechnung von Schriftarten zerst$$HEX1$$f600$$ENDHEX$$ren
DESTROY iuo_FontCalc

//if sWhereAmI = "WEB" then

	FOR lFiles = 1 TO UpperBound(sTempFiles[])
		IF FileExists(sTempFiles[lFiles]) THEN
			FileDelete(sTempFiles[lFiles])
		END IF
	NEXT

	FOR lFiles = 1 TO UpperBound(sFilenames[])
		IF FileExists(sFilenames[lFiles]) THEN
			FileDelete(sFilenames[lFiles])
		END IF
	NEXT

//end if




// -------------------------------------------
// 13.12.2002  
// -------------------------------------------
Destroy(ds_print_job)
Destroy(ds_childstowages)
Destroy(ds_zustautextetoextrastauort)
Destroy(ds_belly)
Destroy(ds_exclude)
Destroy(ds_classname)
Destroy(ds_reportnotprinted)
Destroy(ds_extra)
Destroy(ds_report)
Destroy(ds_diagramlayout)
Destroy(ds_emptybox)
Destroy(ds_bitmap)
Destroy(ds_freetext)
Destroy(ds_schema)
Destroy(ds_loadinglist)
Destroy(ds_stauorteohneinhalte)
Destroy(ds_matrix)
Destroy(ds_suplementloadingslist)
Destroy(ds_matrix_qaq_processing)
Destroy(ds_areas_local)
Destroy(ds_areas_default)
Destroy(ds_new_packinglists)
Destroy(ds_matrix_newspaper)
Destroy(ds_workstations)

if isValid(nPrintPDF) Then setnull(nPrintPDF)
if isValid(oXML) Then Destroy oXML

// If isvalid(nCbase) then setnull(nCbase)
// If isvalid(nAddInfos) then setnull(nAddInfos)
If isvalid(its_jag) then setnull(its_jag)
If isvalid(its_jag) then Destroy its_jag


end event

