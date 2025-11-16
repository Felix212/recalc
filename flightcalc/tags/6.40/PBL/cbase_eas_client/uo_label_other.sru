HA$PBExportHeader$uo_label_other.sru
forward
global type uo_label_other from nonvisualobject
end type
end forward

global type uo_label_other from nonvisualobject
end type
global uo_label_other uo_label_other

type prototypes
Function uint GetDC(uint hw) Library "USER32.DLL"
Function uint ReleaseDC(uint hw, uint hDC) Library "USER32.DLL"
Function ulong GetDeviceCaps(ulong hDC, int iCapability) Library "GDI32.DLL"
Function long GetDesktopWindow() Library "USER32.DLL"
FUNCTION Boolean GetTextExtentPoint32A(uLong  hdc, String lpString, Int cbString, Ref str_textsize lpSize) Library "gdi32.dll" alias for "GetTextExtentPoint32A;Ansi"
FUNCTION ulong SelectObject(ulong hDC, ulong hGDIObj) LIBRARY "Gdi32.dll"
 
end prototypes

type variables


Private:

datastore dsObjects
datastore dsLayout
datastore dsErrorLayout	
datastore dsMaster
datastore dsColumns
datastore dsPackinglistDetail
datastore dsProductGroup
datastore dsLoadingListColumns
datastore dsPackinglistExplosion
integer iRetCount
integer iBitMapCount
integer iColumnCount
integer iTrace
integer iYOffset = 10000

str_columns strColumns[]
string 		sLabelComment
string 		sLabel
long 			lBelly
boolean 		isbelly
string 		is_delimiter = "[#]"
//TransactionServer its_jag

Long				lLabelTypeCounter

// Objekt zur Berechnung von Schriftarten
uo_font_calc iuo_FontCalc

// ----------------------------------------------------------------------------------
// bisschen doku zu den speziellen columns
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//
// distributed components
// - werden als einzige bereits bei der aufl$$HEX1$$f600$$ENDHEX$$sung direkt ins DS eingetragen
// 		( tab-separated und ggf. mit duplizierten label, falls zeilenanzahl $$HEX1$$fc00$$ENDHEX$$berschritten)
// 		( zeilenanzahl wird direkt bei der aufl$$HEX1$$f600$$ENDHEX$$sung schon mal berechnet, aber nicht aufgehoben)
// - werden durch eigene, zu generierende columns dargestellt
// 		(hier ist ein restrisiko, dass die (zeilen-)anzahl columns, die generiert werden, nicht zur zeilenanzahl aus der aufl$$HEX1$$f600$$ENDHEX$$sung passt)
// -----------------------------------------
// rtn components 
// - die daten werden per explosion und anschliessende spezielle aufbereitung zun$$HEX1$$e400$$ENDHEX$$chst in ein array eingetragen
// 		( tab-separated und linefeed formatiert, ein array-eintrag pro label)
// 		( zeilenanzahl wird direkt vorher berechnet und aufgehoben)
// - beim $$HEX1$$fc00$$ENDHEX$$bertragen aus dem array ins DS werden dann ggf. labels dupliziert, wenn n$$HEX1$$f600$$ENDHEX$$tig
// - werden durch eigene, zu generierende columns dargestellt
// 		( zeilenanzahl wird aus der Instance $$HEX1$$fc00$$ENDHEX$$bernommen)
// -----------------------------------------
// pldetail text bzw. pldetail explosion
// - die daten werden per explosion und anschliessende spezielle aufbereitung zun$$HEX1$$e400$$ENDHEX$$chst in ein array eingetragen
// 		( tab-separated und linefeed formatiert, ein array-eintrag pro label)
// 		( zeilenanzahl wird direkt vorher berechnet und aufgehoben)
// - beim $$HEX1$$fc00$$ENDHEX$$bertragen aus dem array ins DS werden dann ggf. labels dupliziert, wenn n$$HEX1$$f600$$ENDHEX$$tig
// - werden in der vorhandenen column dargestellt
// 		(formatierungen per tab und linefeed sind bei der aufbereitung bereits eingef$$HEX1$$fc00$$ENDHEX$$gt worden)
// ----------------------------------------------------------------------------------

// columns im label, die besonders aufgel$$HEX1$$f600$$ENDHEX$$st werden m$$HEX1$$fc00$$ENDHEX$$ssen
Constant String 	COL_PLDETAIL_TEXT = "pldetail_text"
Constant String 	COL_PLDETAIL_EXPL = "pldetail_explosion"
Constant String 	COL_DISTRIBUTED_COMP = "cdistributed_components"
Constant String 	COL_RTN_COMP = "crtn_components"
Constant String 	COL_EQ_COMP = "ceq_components"

// anzahl zeilen pro column zu denen, die besonders aufgel$$HEX1$$f600$$ENDHEX$$st werden m$$HEX1$$fc00$$ENDHEX$$ssen
// notwendig, damit der wert nur einmal berechnet wird und somit daten und columns immer gleich laufen 
Integer 		ii_TextRowsIn_PLDETAIL = -1
Integer 		ii_TextRowsIn_RTN_COMP = -1
Integer 		ii_TextRowsIn_EQ_COMP = -1
// f$$HEX1$$fc00$$ENDHEX$$r distributed_components ist das zeug schon generiert...

// die struktur zur column COL_RTN_COMP
uo_str_draw_columns 	istr_RTN[]

// die filter-kritierien zur column COL_RTN_COMP
String 	is_kindsRTN[]
// die struktur zur column COL_EQUIP_COMP
uo_str_draw_columns 	istr_EQ[]
// die filter-kritierien zur column COL_EQUIP_COMP
String 	is_kindsEQ[]
// das kennzeichen f$$HEX1$$fc00$$ENDHEX$$r additional items
String 	is_AddItems = "*"
// das kennzeichen f$$HEX1$$fc00$$ENDHEX$$r additional items
Long 		il_AddItems_ReductFontsize = 1
// die aktiven abrechungsstatus f$$HEX1$$fc00$$ENDHEX$$r additional items
String 	is_Reckoning = "0,2"		// 0 = Abr./Prod.
										// 1 = Prod.
										// 2 = Abr.
										// 3 = Info.
										// 4 = Req.

// trace-schalter, wird aus handle(getapplication) gesetzt
boolean ib_Trace = false



// -----------------------------------------
// f$$HEX1$$fc00$$ENDHEX$$r's Web-Deployment
// -----------------------------------------
//n_cbase				nCbase

Public:
String		sWhereAmI
datastore 	dsDistributionErrors

STRING		sLocalPrinters[]
STRING		sLocalBellyPrinters[]
Long			lLocalLabelTypes[]
str_labeltypes	strLabelTypes[]

string		is_Rancho_Number = "" // needs to be public or wrapped
string		sGeneratedForPrinter
string		sSPMLLabelType = ""

Integer		iThermo = 0

string		sRampBox, sRampTime, sKitchenTime, sPrintWeekDay
s_flight		strFlight

// -----------------------------------------
// Struktur f$$HEX1$$fc00$$ENDHEX$$r PL-Detail
// -----------------------------------------
s_packinglist_detail	s_pl_detail[]

uo_label_return		uoResult[]

Integer 		iLegs[]
string 		sPLFontname
integer		iPLFontweight
integer		iPLFontsize
integer		iPLTextHeight
integer		iPLObjectHeight
integer		ihasbarcode
// 25.6.18 Schalter Barcode OFF
integer		ihidebarcode

// ALM 5076 07.06.2019 Schalter VPS Barcode 
integer		ivpsbarcode


long			lResultkey
long			il_kpi_labelcount

Public	Long		il_Printing_Group = 0

Public	Long		il_Stowage_Key_Array[]


Public	Date		idt_Departure 

//string		sRange = ""

String		is_Leg_Routing_From[]
String		is_Leg_Routing_To[]
String		sbox_from, sbox_to, sRampBox2

integer		ii_max_columns_in_dw = 12			// 07.12.2012 HR: Anzahl Colums in dw_label_layout_other und dw_label_layout_thermo
string ishealthmark_header, ishealthmark_detail, ishealthmark_footer

//MB 22.01.2013	Schalter f$$HEX1$$fc00$$ENDHEX$$r Mealcode auf Label:
integer		iShowMealCode
integer		iMealcodeWrapped

//MB 25.04.2013 Parameter f$$HEX1$$fc00$$ENDHEX$$r of_wrap aus cen_setup:

integer	iiwrapstartpos
integer	iiwrapendpos
integer	iinowraplen

// MHO 2014-02-07 (CBASE-UK-CR-2013-001): Kennzeichen weiterreichen, ob SPML-Label 
// nach alter Methode oder neu mit Labeltypen nach Unitareas erstellt werden sollen
integer ii_SPML_LABEL_FROM_UNITAREAS = 0

String	is_Label_Group_Sort = ""
Long		il_BestBefore_Minutes
uo_datetime_functions iuo_DateFunctions

uo_pps_barcodes iuoPpsBarcodes

long lRoleID = 1000026
end variables

forward prototypes
public function string of_checknull (string sval)
public function integer of_draw_rect (long lrow, datastore ods)
public function integer of_create_pictures (ref str_bitmaps strbmp[])
public function integer of_init (datastore dwdata, integer iprintertype, string sflgnr, date ddepdate, string sdeptime, string sdestination, ref uo_label_return strret[], ref str_bitmaps strbmp[])
public function long of_checknull (long ival)
public function datetime of_find_valid_label (long llabeltype, datetime dtsearch)
public function boolean of_isproduct_group (long lpoductgroup)
public function integer of_draw_text (long lrow, datastore ods)
public function integer of_draw_bmp (long lrow, datastore ods)
public function boolean of_isbelly (long nbelly)
public function integer of_draw_column_font_dummy (long lrow, datastore ods)
public function integer of_get_next_column_id (integer istart, datastore ods)
public function integer of_draw_line (long lrow, datastore ods)
public function integer of_create_error_label ()
public function integer of_fill_error_columns (integer imaxperlabel)
public function integer of_draw_error_columns (integer iid)
public function integer of_log (string smsg)
public function integer of_draw_pl_columns (long lrow, datastore ods)
public function integer of_draw (integer iprintertype)
public function integer of_split_distribution_text (string sstring, ref s_distribution_text strvalues[])
public function integer of_fill_prod_columns (long lrowdata, long lrowinsert, datastore odw, string sflgnr, date ddepdate, string stime, string sdestination, string sactype)
public function integer of_set_printer_type (integer iprintertype, long llabeltype)
public function integer of_build_label (date ddepdate, long llabeltype, integer iprintertype)
public function integer of_analyse (datastore odw)
public function integer of_label_production (datastore dwdata, integer iprintertype, integer ilabelsort, integer ilabelpagebreak, s_flight strflightinfo, ref uo_label_return strret[], ref str_bitmaps strbmp[])
public function string of_wrap (string stext, integer inowraplen, integer iwrapstartpos, integer iwrapendpos)
public function integer of_label (datastore dwdata, integer iprintertype, integer ilabelsort, integer ilabelpagebreak, s_flight strflightinfo, ref str_bitmaps strbmp[])
public function integer of_destroy_layout ()
public function integer of_fill_spml_columns (long lrowdata, long lrowinsert, datastore odw)
public function integer of_label_spml (datastore dwdata, integer iprintertype, ref str_bitmaps strbmp[])
public function integer of_label (datastore dwdata, integer iprintertype, integer ilabelsort, integer ilabelpagebreak, s_flight strflightinfo, ref uo_label_return strret[], ref str_bitmaps strbmp[])
public function s_packinglist_detail of_create_pl_detail (long lindex_key, long ldetail_key, datetime dtdeparture)
public function s_packinglist_detail of_create_pl_explosion (long al_index_key, long al_detail_key, datetime dtdeparture)
public function integer of_fill_columns (long lrowdata, long lrowinsert, datastore odw, string sflgnr, date ddepdate, string stime, string sdestination, string sactype, string sconfiguration, string sdeparture)
public function integer of_fill_columns (long lrowdata, long lrowinsert, datastore odw, string sflgnr, date ddepdate, string stime, string sdestination, string sactype, string sconfiguration, string sdeparture, datetime adt_bestbefore)
public function integer of_draw_column (long al_row, datastore ods)
protected function long of_draw_line (datastore ods, string as_objectname, long al_posx1, long al_posy1, long al_posx2, long al_posy2, long al_penwidth, long al_pencolor)
protected function long of_draw_line (datastore ods, integer al_posx1, integer al_posy1, integer al_posx2, integer al_posy2, integer al_penwidth, integer al_pencolor)
protected function long of_get_setup_columns (ref uo_str_draw_columns astr_columns[])
protected function long of_get_setup_rtn ()
protected function long of_draw_rtn_components (long al_row, datastore ods)
public function boolean of_check_rtn_level (string as_level)
protected function s_packinglist_detail of_create_pl_rtn (long al_index_key, datetime adt_departure, boolean ab_read)
protected function long of_draw_eq_components (long al_row, datastore ods)
protected function long of_get_setup_eq ()
protected function s_packinglist_detail of_create_pl_eq (long al_index_key, datetime adt_departure, boolean ab_read, ref s_packinglist_detail lstr_labelpltexte)
public function string of_check_unit (string asitem)
public function string of_return_max_text (string arg_text, long arg_row)
public function integer of_draw_barcode (long lrow, datastore ods)
public function integer of_create_barcode (long ai_type, string as_file, string as_text, long ai_width, long ai_height, long ai_dpi)
public function integer of_label_pps (datastore dwdata, integer iprintertype, integer ilabelsort, integer ilabelpagebreak, s_flight strflightinfo, integer ikh_flug)
public function integer of_label_pps_production (datastore dwdata, integer iprintertype, integer ilabelsort, integer ilabelpagebreak, s_flight strflightinfo)
public function integer of_fill_healthmark (s_flight sflightinfo)
public function integer of_set_mealcode_flag ()
public function string of_create_barcode_information (datastore ads_data, long al_row, s_flight astr_flightinfo)
public function string of_create_barcode_information_spml_label (datastore ads_data, long al_row, datetime adt_date)
public function string of_create_barcode_information_prod_label (datastore ads_data, long al_row)
public function integer of_split_distribution_old (string sstring, ref s_distribution_text strvalues[])
public function integer of_retrieve_column_definition ()
public function integer of_get_wrap_param ()
public function string of_get_filename_only (string sfile)
public function integer of_get_cflight_compare (ref datastore ods, string sflight)
public function string of_get_prod_cflight (string sairline, date ddepart, long arg_pl_index, string sflight, long arg_belly)
public function string of_get_registration ()
public function string of_get_prod_cflight_all (string sairline, date ddepart, long arg_pl_index, string sflight, long arg_belly)
public function string of_get_prod_cflightranges (string sairline, date ddepart, long arg_pl_index, string sflight, long arg_belly)
public function integer of_set_label_group_sort (string as_new_sort)
public function integer of_legs ()
end prototypes

public function string of_checknull (string sval);
if isnull(sVal) then 
	
	return ""
	
else
	
	return sVal
	
end if


end function

public function integer of_draw_rect (long lrow, datastore ods);//----------------------------------------------------
// 
// Rectangle Object zeichnen ...
// 
// 
//----------------------------------------------------
long a, lBorder, lFontSize, lFontWeight, lAlign, lUnder, lItalic, lBackMode
long lBackColor, lFontColor, lR, lM
long lBrushColor, lPenColor, lPenWidth, lBrushHatch, lKey

string sCreate, sName, sText, sFontName
string sWidth, sHeight, sX, sY, sRet

decimal lX, lY, lW, lH

integer iCount, iId


lX = dsObjects.GetItemNumber(lRow, "nxpos")
lY = dsObjects.GetItemNumber(lRow, "nypos")
lH = dsObjects.GetItemNumber(lRow, "nheight")
lW = dsObjects.GetItemNumber(lRow, "nwidth")
lBorder = dsObjects.GetItemNumber(lRow, "nborderstyle") 
sName = dsObjects.GetItemString(lRow, "cobject_name")
lBackMode = dsObjects.GetItemNumber(lRow, "nbackgroundmode")
lBackColor = dsObjects.GetItemNumber(lRow, "nbackgroundcolor")
lBrushColor = dsObjects.GetItemNumber(lRow, "nbrushcolor")
lPenColor = dsObjects.GetItemNumber(lRow, "npencolor")
lPenWidth = dsObjects.GetItemNumber(lRow, "npenwidth")
lBrushHatch = dsObjects.GetItemNumber(lRow, "nbrushhatch")
lR = 0 //dsObjects.GetItemNumber(lRow, "nresizeable")
lM = 0 //dsObjects.GetItemNumber(lRow, "nmoveable")

sCreate = "create rectangle(band=detail x='" + string(lX) +  &
			   "' y='" + string(lY) + "' height='" + string(lH) + &
				"' width='" + string(lW) + "' name=" + sName + &
				" resizeable=" + string(lR)  + "  moveable=" + string(lM)  + &
				" visible='1~tif( nvisible =1, 1, 0)'" + &
				"  brush.hatch='" + string(lBrushHatch) + &
				"' brush.color='" + string(lBrushColor) +  &
				"' pen.style='0' pen.width='" + string(lPenWidth) + &
				"' pen.color='" + string(lPenColor) + &
				"' background.mode='2' background.color='0')"		

sRet = oDS.modify(sCreate)

if sRet <> "" then
	of_log("Error -6, create rect  : " + sRet)
	of_log("Error -6, create syntax: " + sCreate)
	return -6
end if


return 0

end function

public function integer of_create_pictures (ref str_bitmaps strbmp[]);// -----------------------------------
// Alle Bilder in c:\temp\ erstellen
// -----------------------------------
long lRow, lID
Blob bPicture
string sFile, sPic, sDir

// -----------------------------------
// und dann die neuen erstellen
// -----------------------------------
For lRow = 1 to dsObjects.RowCount()

	// --------------------------------------------------------------------------------------------------------------------
	// 07.12.2012 HR: $$HEX1$$dc00$$ENDHEX$$bernahme TYP 6 aus PPS/FTQ
	// --------------------------------------------------------------------------------------------------------------------
	
	if dsObjects.GetItemNumber(lRow, "nobject_type") = 5 or dsObjects.GetItemNumber(lRow, "nobject_type") = 6  then // 5= Bitmap and 6:Barcode
		sFile = dsObjects.GetItemString(lRow, "cvalue")
		sPic = dsObjects.GetItemString(lRow, "cobject_name")		
		lID = dsObjects.GetItemNumber(lRow, "nlabel_detail_key")
		
		selectblob cen_label_detail.bBitmap
		into :bPicture
		from cen_label_detail
		where cen_label_detail.nlabel_detail_key = :lID;
		
		if sqlca.sqlcode <> 0 then
			of_log("Error -12, of_create_pictures")
			of_log("Error -12, arguments: cen_label_detail.nlabel_detail_key = " + string(lID))
			of_log("Error -12,    SQLCODE: " + string(sqlca.sqlcode))
			of_log("Error -12, SQLERRTEXT: " + sqlca.sqlerrtext) 
			return -12
		else
			sdir = f_gettemppath()
			sfile = of_get_filename_only( sfile)
			iBitMapCount ++
			strBMP[iBitmapCount].sFileName = sdir+sFile
			strBMP[iBitmapCount].bBitmap = bPicture
			f_blob_to_file(strBMP[iBitmapCount].sFileName, strBMP[iBitmapCount].bBitmap)
		end if

	end if
	
Next

return 0
end function

public function integer of_init (datastore dwdata, integer iprintertype, string sflgnr, date ddepdate, string sdeptime, string sdestination, ref uo_label_return strret[], ref str_bitmaps strbmp[]);//// ------------------------------------------------------------------------------------
//// Erstellen der Labels
////
//// Parameter:	dwdata 				dw_1 aus ou_loading_list
//// 				iPrinterType		1 = Thermodrucker via Druckertreiber
////											2 = Normaler Drucker (auf Bogen)
////					sFlgnr				Flugnummer (Airline + Flugnummer + Suffix)
////					dDepDate				Abflugdatum
////					sDepTime				Abflugzeit
//// 				strRet				Struktur vom Typ str_label_return
////											wird per Referenz $$HEX1$$fc00$$ENDHEX$$bergeben und gef$$HEX1$$fc00$$ENDHEX$$llt
////
////
////	R$$HEX1$$fc00$$ENDHEX$$ckgabe:	 0		alle prima
////					-1		keine Daten in dwdata
////					-2		kein g$$HEX1$$fc00$$ENDHEX$$ltiges Label gefunden
////					-3		ung$$HEX1$$fc00$$ENDHEX$$ltiger Wert in iPrinterType
////					-4		Fehler beim ColumnObject
////					-5		Fehler beim LineObject
////					-6		Fehler beim RectangleObject
////					-7		Fehler beim TextObject
////					-8		Fehler beim BitmapObject
////					-9		Fehler im dsMaster kein oder mehr als ein Datensatz
////					-10	Fehler im dsObjects kein Datensatz
////					-11	Label hat keine Columns
//// 				-12	Fehler beim erzeugen der Bitmaps
//// 				-13	
//// 				-14	Fehler keine Daten in SYS_LABEL_COLUMNS
//// ------------------------------------------------------------------------------------
//Datetime dtValid, dtSearch
//Long lLabelType
//Long lRows
//Long lInsert
//Long lFound
//Blob bBlob
//
//integer iRet
//
//// ------------------------------------------------------------------------------------
//// Mal schaun, ob $$HEX1$$fc00$$ENDHEX$$berhaupt Daten drin sind
//// ------------------------------------------------------------------------------------
//if dwdata.RowCount() = 0 then
//	of_log("Error -1, no data found, RowCount() on dwData = 0 ")
//	return -1
//end if
//
//// ------------------------------------------------------------------------------------
//// Daten nach Belly sortieren 
//// ------------------------------------------------------------------------------------
//iRet = dwData.SetSort("cen_loadinglists_nbelly_container A")
//dwData.Sort()
//if iRet = -1 then
//	of_log("Error -1, wrong sort criteria")
//	return -1
//end if
//
//// -----------------------------------------
//// iPrintertype pr$$HEX1$$fc00$$ENDHEX$$fen und dsLayout $$HEX1$$e400$$ENDHEX$$ndern
//// -----------------------------------------
//if of_set_printer_type(iPrinterType) <> 0 then
//	return -3
//end if
//
//// -----------------------------------------
//// Columndefinitionen aus SYS_LABEL_COLUMNS
//// -----------------------------------------
//if dsColumns.Retrieve() <= 0 then
//	of_log("Error -14, no data from SYS_LABEL_COLUMNS")
//	return -1
//end if
//
//// -----------------------------------------
//// Label bauen
//// -----------------------------------------
//lLabelType = dwData.GetItemNumber(1, "cen_packinglists_nlabel_type_key")
//iRet = of_build_label(dDepDate, lLabelType, iPrinterType)
//if iRet <> 0 then
//	return iRet
//end if
//
//// -----------------------------------------
//// Bilder blobben
//// -----------------------------------------
//iRet = of_create_pictures(strBMP)
//
//if iRet <> 0 then
//	return iRet
//end if
//
//// -----------------------------------------
//// F$$HEX1$$fc00$$ENDHEX$$r den Spooler noch nen Namen geben
//// -----------------------------------------
//dsLayout.Modify("datawindow.print.documentname = 'Labelprint: " + sFlgnr + " " + String(dDepDate) + "/" + sDepTime + "'")
//isBelly = of_isbelly(dwData.GetItemNumber(1, "cen_loadinglists_nbelly_container"))
//
//For lRows = 1 to dwData.RowCount()
//
//	// -------------------------------------------------
//	// Nachschaun, on sich der Labeltyp ge$$HEX1$$e400$$ENDHEX$$ndert hat
//	// -------------------------------------------------
//	
//		
//	if lLabelType = dwData.GetItemNumber(lRows, "cen_packinglists_nlabel_type_key") and &
//						 of_isbelly(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")) = isBelly then  
//		
//		// -------------------------------------------------
//		// Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert, dann Daten reinpacken
//		// -------------------------------------------------
//		
//		lInsert = dsLayout.InsertRow(0)	
//		
//		//messagebox(string(isBelly) + " Wert: " + string(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")), string(lInsert)) 
//		
//		//messagebox("",lInsert)
//		dsLayout.SetItem(lInsert, "nobject_type", lInsert)
//		dsLayout.SetItem(lInsert, "nbelly", of_checknull(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")))
//		of_fill_columns(lRows, lInsert, dwData, sFlgnr, dDepdate, sDepTime, sDestination, "")	
//	else
//		// -------------------------------------------------------------------
//		// Labeltyp oder Belly hat sich ge$$HEX1$$e400$$ENDHEX$$ndert, den Datastore (dsLayout)
//		// in das UserObkect packen und den neuen Labeltyp bauen
//		// -------------------------------------------------------------------
//		if iRet = -1 then
//			return -13
//		end if
//		
//		iRet = dsLayout.GetFullState(bBlob)
//		
//		if iRet = -1 then
//			return -13
//		end if
//		
//		iRetCount ++		
//		strRet[iRetCount] = Create uo_label_return
//		strRet[iRetCount].llabeltype = lLabelType
//		strRet[iRetCount].bLabel = bBlob
//		strRet[iRetCount].sLabel = sLabel
//		strRet[iRetCount].sLabelComment = sLabelComment
//		strRet[iRetCount].isBelly = isBelly
//
//		lLabelType = dwData.GetItemNumber(lRows, "cen_packinglists_nlabel_type_key") 
//		isBelly = of_isbelly(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container"))
//		iRet = of_build_label(dDepDate, lLabelType, iPrinterType)
//		
//		
//		if iRet <> 0 then
//			return iRet
//		end if
//		
//		lInsert = dsLayout.InsertRow(0)	
//		dsLayout.SetItem(lInsert, "nobject_type", lInsert)
//		dsLayout.SetItem(lInsert, "nbelly", of_checknull(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")))
//		of_fill_columns(lRows, lInsert, dwData, sFlgnr, dDepdate, sDepTime, sDestination, "")	
//		
//	end if
//			
//Next
//
//iRet = dsLayout.GetFullState(bBlob)
//if iRet = -1 then
//	return -13
//end if
//
//iRetCount ++				
//strRet[iRetCount] = Create uo_label_return
//strRet[iRetCount].bLabel = bBlob
//strRet[iRetCount].lLabeltype = lLabelType
//strRet[iRetCount].sLabel = sLabel
//strRet[iRetCount].sLabelComment = sLabelComment
//strRet[iRetCount].isBelly = isBelly
//
////int i
//// for i = 1 to iretcount
////	messagebox(string(i), "Rows: " + String(strRet[i].dsLabel.rowcount()))
//// next
//
//
return 0
end function

public function long of_checknull (long ival);

if isnull(iVal) then 
	
	return 0
	
else
	
	return iVal
	
end if

end function

public function datetime of_find_valid_label (long llabeltype, datetime dtsearch);// -----------------------------------------
// Suchen des g$$HEX1$$fc00$$ENDHEX$$ltigen Labels
// -----------------------------------------

datetime dtvalid

//SELECT cen_label_type_detail.dvalid_from, cen_label_type_detail.ctext   
//  INTO :dtValid, :sLabelComment  
//  FROM cen_label_type_detail  
// WHERE ( cen_label_type_detail.dvalid_from <= :dtSearch ) AND  
//       ( cen_label_type_detail.dvalid_to >= :dtSearch )   AND 
//		 ( cen_label_type_detail.nLabel_type_key = :lLabelType );
		 
		 
  SELECT cen_label_type.ctext,   
         cen_label_type_detail.dvalid_from,   
         cen_label_type_detail.ctext  
    INTO :sLabel,   
         :dtValid,   
         :sLabelComment  
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

//Messagebox("", "Type: " + string(lLAbelType) + "~rSearchDate: " + string(dtsearch))

return dtValid
end function

public function boolean of_isproduct_group (long lpoductgroup);// -------------------------------------------------------------------------------
// Sofern die Produktgruppe gefunden wird, wird diese nicht im PL-Detail ben$$HEX1$$f600$$ENDHEX$$tigt
// -------------------------------------------------------------------------------

If isnull(lPoductgroup) Then return True

If dsProductGroup.find("nproduct_index_key = " + string(lpoductgroup) + &
							  " and nproduction_relevant = 0",1,dsProductGroup.Rowcount()) > 0 Then
	Return False
Else	
	Return True
End if


end function

public function integer of_draw_text (long lrow, datastore ods);//----------------------------------------------------
// 
// Text Object zeichnen ...
// 
// 
//----------------------------------------------------

long a, lBorder, lFontSize, lFontWeight, lAlign, lUnder, lItalic, lBackMode
Long lBackColor, lFontColor, lR, lM
long lBrushColor, lPenColor, lPenWidth, lBrushHatch, lKey
string sCreate, sName, sText, sFontName
decimal lX, lY, lW, lH
integer iCount, iId
string sWidth, sHeight, sX, sY, sRet


lX = dsObjects.GetItemNumber(lRow, "nxpos")
lY = dsObjects.GetItemNumber(lRow, "nypos")
lH = dsObjects.GetItemNumber(lRow, "nheight")
lW = dsObjects.GetItemNumber(lRow, "nwidth")
lBorder = dsObjects.GetItemNumber(lRow, "nborderstyle") 
sFontName = dsObjects.GetItemString(lRow, "cfontname")
lFontSize = dsObjects.GetItemNumber(lRow, "nfontsize")
lFontWeight = dsObjects.GetItemNumber(lRow, "nfontweight")
sName = dsObjects.GetItemString(lRow, "cobject_name")
lAlign = dsObjects.GetItemNumber(lRow, "ntextalign")
lUnder = dsObjects.GetItemNumber(lRow, "nfontunderline")
lItalic = dsObjects.GetItemNumber(lRow, "nfontitalic")
lBackMode = dsObjects.GetItemNumber(lRow, "nbackgroundmode")
lBackColor = dsObjects.GetItemNumber(lRow, "nbackgroundcolor")
lFontColor = dsObjects.GetItemNumber(lRow, "nfontcolor")
lBrushColor = dsObjects.GetItemNumber(lRow, "nbrushcolor")
lPenColor = dsObjects.GetItemNumber(lRow, "npencolor")
lPenWidth = dsObjects.GetItemNumber(lRow, "npenwidth")
lBrushHatch = dsObjects.GetItemNumber(lRow, "nbrushhatch")
sText = dsObjects.GetItemString(lRow, "cvalue")
lR = 0 //dsObjects.GetItemNumber(lRow, "nresizeable")
lM = 0 //dsObjects.GetItemNumber(lRow, "nmoveable")

sCreate = "create text(band=detail alignment='"  + string(lAlign) + &
			"' text='" + sText + "' border='" + string(lBorder) + "' color='" +&
			string(lFontColor) + "' x='" + string(lX) +  "' y='" + string(lY) + &
			"' height='" + string(lH) + "' width='" + string(lW) + &
			"' name=" + sName + " resizeable=" + string(lR) + &
			" visible='1~tif( nvisible =1, 1, 0)'" + &
			"  moveable=" + string(lM) + " font.face='" + sFontName + &
			"' font.height='" + string(lFontSize) + &
			"' font.weight='" + string(lFontWeight) + &
			"' font.family='2' font.pitch='2' font.charset='0'   font.italic='" + string(lItalic) + &
			"' font.underline='" + string(lUnder) +&
			"' background.mode='" + string(lBackMode) + &
			"' background.color='" + string(lBackColor) + "')"

sRet = oDS.modify(sCreate)

if sRet <> "" then
	of_log("Error -7, create text  : " + sRet)
	of_log("Error -7, create syntax: " + sCreate)
	return -7
end if


return 0
end function

public function integer of_draw_bmp (long lrow, datastore ods);//----------------------------------------------------
// 
// Bitmap Object zeichnen ...
// 
// 
//----------------------------------------------------
long a, lBorder, lFontSize, lFontWeight, lAlign, lUnder, lItalic, lBackMode
Long lBackColor, lFontColor, lR, lM
long lBrushColor, lPenColor, lPenWidth, lBrushHatch, lKey
string sCreate, sName, sVal, sFontName
decimal lX, lY, lW, lH
integer iCount, iId, iRet
string sWidth, sHeight, sX, sY, sRet


lX = dsObjects.GetItemNumber(lRow, "nxpos")
lY = dsObjects.GetItemNumber(lRow, "nypos")
lH = dsObjects.GetItemNumber(lRow, "nheight")
lW = dsObjects.GetItemNumber(lRow, "nwidth")
lBorder = dsObjects.GetItemNumber(lRow, "nborderstyle") 
sName = dsObjects.GetItemString(lRow, "cobject_name")
sVal = dsObjects.GetItemString(lRow, "cvalue")
sval = f_gettemppath() + of_get_filename_only(sval)
lR = 0 //dsObjects.GetItemNumber(lRow, "nresizeable")
lM = 0 //dsObjects.GetItemNumber(lRow, "nmoveable")

sCreate = "create bitmap(name=" + sName + " band=detail filename='" + sVal + "' x='" + string(lX, "0") + "' y='" + string(lY, "0") + &
			 "' height='" + string(lH, "0") + "' width='" + string(lW, "0") + "' border='" + string(lBorder, "0") + "'  resizeable=" +string(lR, "0") + "  moveable=" + string(lM, "0") + "  )"

sRet = oDS.modify(sCreate)

//iRet = oDS.Setposition(sName, "detail", False)
//
//Messagebox("", "Setposition " + sName  + " - " + string(iRet))

if sRet <> "" then
	of_log("Error -8, create bitmap: " + sRet)
	of_log("Error -8, create syntax: " + sCreate)
	return -8
end if

return 0
end function

public function boolean of_isbelly (long nbelly);
if nBelly = 0 then
	return False
else
	return True
end if

end function

public function integer of_draw_column_font_dummy (long lrow, datastore ods);//----------------------------------------------------
// Column Object zeichnen ...
// 
// Ziemlich komplizierter Mist !!!
// Wenn jemand ne bessere Idee hat, dann her damit
//----------------------------------------------------

string sWidth, sHeight, sX, sY, sRet
string sCreate, sName, sText, sFontName
string sSyntax, sToken, sFind, sColumn

integer iCount, iId
integer iPos, iLen

sName = dsObjects.GetItemString(lRow, "cobject_name")

// --------------------------------------------------------------------------------------------------------------------
// 26.09.2022 HR: Wir setzen am Anfang mal den Standarddrucker vom Starten
// --------------------------------------------------------------------------------------------------------------------
if cbase.is_RemoteDesktopDefaultprinter > " " then
	oDS.Modify("datawindow.printer='" +cbase.is_RemoteDesktopDefaultprinter + "'")
	f_set_printer( cbase.is_RemoteDesktopDefaultprinter ) 
end if

// ----------------------------------------------------
// DW Syntax holen
// ----------------------------------------------------
sSyntax = oDS.describe("datawindow.syntax")

sFind = "text(name=jumppoint"
iLen = len(sFind)
iPos = pos(sSyntax, sFind)

// -----------------------------------------------------------
// im DW Syntax - neue Column eintragen im DW-Syntax-"Header"
// -----------------------------------------------------------
//iId = of_get_next_column_id(3, oDS)

if iPos > 0 then

	sSyntax = Mid(sSyntax, 1, iPos - 4) + "column=(type=number updatewhereclause=no name=fs_" + sName + " dbname='fs_" + sName + "') ~r~n" + Mid(sSyntax, iPos - 3)	
		
	oDS.create(sSyntax)
	

else
	
	return 0
	
end  if


// --------------------------------------------------------
// DW Syntax - neue Column eintragen im DW-Syntax-"Detail"
// --------------------------------------------------------

//sCreate = "create column(band=detail id=" + string(iId) + &
//            " tabsequence=0 visible='0' " + &
//				" x='4' y='4' height='4' width='4')"
//				
////"~t fs_" + sName + &
//sRet = oDS.modify(sCreate)
//
//if sRet <> "" then
//	of_log("Error -4, create font dummy: " + sRet)
//	of_log("Error -4, create syntax: " + sCreate)
//	return -4
//end if
//

return 0
end function

public function integer of_get_next_column_id (integer istart, datastore ods);//----------------------------------------------------
// 
//	Suchen der h$$HEX1$$f600$$ENDHEX$$chsten Column ID
//
// F$$HEX1$$fc00$$ENDHEX$$r das dynamische Einf$$HEX1$$fc00$$ENDHEX$$gen von Column-Objecten
// in ein DW ist es notwendig, da$$HEX2$$df002000$$ENDHEX$$das 
// Column Property >>ID<< fortlaufend vergeben wird,
// sonst rappelts !!
//  ii_max_columns_in_dw enth$$HEX1$$e400$$ENDHEX$$lt die Anzahl Columns im DW
//----------------------------------------------------

long i
integer iId, iRet
string sObject

// ---------------------------------------------------
// iRet = 2, weil DW_LABEL_LAYOUT
// bereits $$HEX1$$fc00$$ENDHEX$$ber zwei Columns verf$$HEX1$$fc00$$ENDHEX$$gt
// ---------------------------------------------------

iRet = iStart

for i = 1 to dsObjects.rowcount()
		
	if dsObjects.GetItemNumber(i, "nobject_type") = 1 then // 1 = Column
		sObject = dsObjects.GetItemString(i, "cobject_name")
		iId = integer(oDS.describe(sObject + ".id"))
		
		if iId > iRet then
			iRet = iId
		end if
	
	end if
	
next

return iRet + 1


end function

public function integer of_draw_line (long lrow, datastore ods);//----------------------------------------------------
// 
// Line Object zeichnen ...
// 
// 
//----------------------------------------------------

long a, lBorder, lFontSize, lFontWeight, lAlign, lUnder, lItalic, lBackMode
long lBackColor, lFontColor, lR, lM
long lBrushColor, lPenColor, lPenWidth, lBrushHatch, lKey

string sCreate, sName, sText, sFontName
string sWidth, sHeight, sX, sY, sRet

decimal lX, lY, lW, lH

integer iCount, iId

lX = dsObjects.GetItemNumber(lRow, "nxpos")
lY = dsObjects.GetItemNumber(lRow, "nypos")
lH = dsObjects.GetItemNumber(lRow, "nheight")
lW = dsObjects.GetItemNumber(lRow, "nwidth")
lBorder = dsObjects.GetItemNumber(lRow, "nborderstyle") 
sName = dsObjects.GetItemString(lRow, "cobject_name")
lBackMode = dsObjects.GetItemNumber(lRow, "nbackgroundmode")
lBackColor = dsObjects.GetItemNumber(lRow, "nbackgroundcolor")
lBrushColor = dsObjects.GetItemNumber(lRow, "nbrushcolor")
lPenColor = dsObjects.GetItemNumber(lRow, "npencolor")
lPenWidth = dsObjects.GetItemNumber(lRow, "npenwidth")
lBrushHatch = dsObjects.GetItemNumber(lRow, "nbrushhatch")
lR = dsObjects.GetItemNumber(lRow, "nresizeable")
lM = dsObjects.GetItemNumber(lRow, "nmoveable")


// Stand vor dem FormFeed
sCreate = "create line(band=detail x1='" + string(lX) + "' y1='" + &
			 string(lY) + "' x2='" + string(lW) + "' y2='" + string(lH) + &
			 "' name=" + sName + "  moveable=" + string(lM) + &
			 " visible='1~tif( nvisible =1, 1, 0)'" + &
			 " pen.style='0' pen.width='" + string(lPenWidth) + &
			 "' pen.color='" + string(lPenColor) + &
			 "'  background.mode='2' background.color='16777215' )"

//sCreate = "create line(band=detail x1='" + string(lX) + "' y1='" + &
//			 string(lY) + "' x2='" + string(lW) + "' y2='" + string(lH) + "'" + &
//			 " name=" + sName + "  moveable=" + string(lM) + &
//			 " pen.style='0' pen.width='" + string(lPenWidth) + + "'"  + &
//			 " pen.color='" + string(lPenColor) + "~tif( nvisible =1, " + string(lPenColor) + ", " + String(RGB(255,255,255)) + ")'" + &
//			 " background.mode='2' background.color='16777215' )"





sRet = oDS.modify(sCreate)

if sRet <> "" then
	of_log("Error -5, create line  : " + sRet)
	of_log("Error -5, create syntax: " + sCreate)
	return -5
end if


return 0


end function

public function integer of_create_error_label ();// -----------------------------------------
// Erzeugen eines ErrorLabels f$$HEX1$$fc00$$ENDHEX$$r die
// Komponenten, die nicht verteilt werden
// konnten
// ----------------------------------------

Long I
Long lLabelType
Blob bBlob
String sDWObjects, sTemp
Integer iMaxPerLabel, iID, iRet
Long lHeight, lWidth
String sCreate, sText, sRet


lLabelType = -10

// -----------------------------------------
// Wir schaun mal nach, ob der Labeltype
// schonmal generiert wurde. Wenn ja dann
// machen wir das nat$$HEX1$$fc00$$ENDHEX$$rlich nicht nochmal
// -----------------------------------------
for i = 1 to UpperBound(this.strLabelTypes)
	
	if this.strLabelTypes[i].lLabelType = lLabelType then
		dsErrorLayout.SetFullState(this.strLabelTypes[i].bLayout)
		dsErrorLayout.Modify("datawindow.printer='" + this.strLabelTypes[i].sPrinter + "'")		//BEFORE PRINT
		
		this.sGeneratedForPrinter = this.strLabelTypes[i].sPrinter
		sText = strFlight.sAirline + " " + strFlight.sFlightNumber + " / " + string(date(strFlight.dtDepartureDate))
		dsErrorLayout.Modify("stErrorHeader2.text='" + sText + "'")
		return this.strLabelTypes[i].iMaxPerLabel
	end if 

Next 

// ------------------------------------------
// Wenn der Labeltyp noch nicht erstellt
// wurde, dann bauen wir uns das ErrorLabel
// anhand der Gr$$HEX2$$f600df00$$ENDHEX$$e des ersten Labeltyps
// den wir finden zusammen
// ------------------------------------------

if UpperBound(strLabelTypes) = 0 then return -1

bBlob = this.strLabelTypes[1].bLayout
dsErrorLayout.SetFullstate(bBlob)
dsErrorLayout.Reset()

// --------------------------------------------------------------------------------------------------------------------
// 26.09.2022 HR: Wir setzen am Anfang mal den Standarddrucker vom Starten
// --------------------------------------------------------------------------------------------------------------------
if cbase.is_RemoteDesktopDefaultprinter > " " then
	dsErrorLayout.Modify("datawindow.printer='" +cbase.is_RemoteDesktopDefaultprinter + "'")
	f_set_printer( cbase.is_RemoteDesktopDefaultprinter ) 
end if

// -----------------------------------------
// Danach alle Objekte im Layout l$$HEX1$$f600$$ENDHEX$$schen
// und die n$$HEX1$$f600$$ENDHEX$$tigen wieder erstellen
// -----------------------------------------
//
// dazu alle Objekte von DW_LAYOUT auslesen
//
// -----------------------------------------
sDWObjects = dsErrorLayout.describe("datawindow.objects")
// ---------------------------------------
// Den String zerhacken und alle Objekte
// l$$HEX1$$f600$$ENDHEX$$schen
// ---------------------------------------

for i = 1 to len(sDWObjects)
	
	if Mid(sDWObjects, i, 1) <> char(9) then
		sTemp += Mid(sDWObjects, i, 1)
	else
		
		if sTemp <> "jumppoint" then
			dsErrorLayout.Modify("Destroy " + sTemp)
		else
			iID = integer(dsErrorLayout.describe(sTemp + ".id"))
		end if 
		
		sTemp = ""
		
	end if

next

iID 	= 0
iRet 	= 0 

if len(sTemp) > 0 then		
	if sTemp <> "jumppoint" then
		dsErrorLayout.Modify("Destroy " + sTemp)
	else
		iID = integer(dsErrorLayout.describe(sTemp + ".id"))
	end if
end if

lHeight 	= Long(dsErrorLayout.Describe("datawindow.detail.height"))
lWidth 	= 180

// --------------------------------------------------------------
// Die Felder erzeugen, die das ErrorLabel beinhalten soll
//
// simple $$HEX1$$dc00$$ENDHEX$$berschrift, bestehend aus Flugnummer und Datum
// --------------------------------------------------------------

sText = strFlight.sAirline + " " + strFlight.sFlightNumber + " / " + string(date(strFlight.dtDepartureDate))

sCreate = "create text(band=detail alignment='0' text='Error-Label' border='0' color='" + String(RGB(0,0,0)) + "' x='5' y='5' height='20' width='" + string(lWidth - 10) + "' name=stErrorHeader1 resizeable=0 visible='1' " + &
			 "moveable=0 font.face='Arial' font.height='-12' font.weight='700' font.family='2' font.pitch='2' font.charset='0' font.italic='0' font.underline='0' background.mode='1' background.color='" + String(RGB(255,255,255)) + "')"

sRet = dsErrorLayout.modify(sCreate)

sCreate = "create text(band=detail alignment='0' text='" + sText + "' border='0' color='" + String(RGB(0,0,0)) + "' x='5' y='30' height='20' width='" + string(lWidth - 10) + "' name=stErrorHeader2 resizeable=0 visible='1' " + &
			 "moveable=0 font.face='Arial' font.height='-12' font.weight='700' font.family='2' font.pitch='2' font.charset='0' font.italic='0' font.underline='0' background.mode='1' background.color='" + String(RGB(255,255,255)) + "')"

sRet = dsErrorLayout.modify(sCreate)

// --------------------------------------------
// Columns erzeugen
// --------------------------------------------

iID = Integer(dsErrorLayout.Describe("datawindow.column.count"))

iMaxPerLabel = of_draw_error_columns(iID)

 // 07.04.2022 HR: Moved direct before print
 dsErrorLayout.Modify("datawindow.printer='" + this.strLabelTypes[1].sPrinter + "'")		//BEFORE PRINT

// ---------------------------------------------
// wir merken uns den gerade generierten 
// Labeltyp f$$HEX1$$fc00$$ENDHEX$$rs n$$HEX1$$e400$$ENDHEX$$chste mal
// ---------------------------------------------
dsErrorLayout.GetFullState(bBlob)
this.lLabelTypeCounter ++
this.strLabelTypes[lLabelTypeCounter].lLabelType 	= lLabelType
this.strLabelTypes[lLabelTypeCounter].bLayout 		= bBlob
this.strLabelTypes[lLabelTypeCounter].sPrinter 		= this.strLabelTypes[1].sPrinter
this.strLabelTypes[lLabelTypeCounter].iMaxPerLabel = iMaxPerLabel

return iMaxPerLabel
end function

public function integer of_fill_error_columns (integer imaxperlabel);// ----------------------------------------
//
// F$$HEX1$$fc00$$ENDHEX$$llen des Errorlabels mit Werten
//
// ----------------------------------------
Long 		lRows, a, lQuantity
String	sText, sPackingList
Integer	iCounter

String 	sColumn

a = dsErrorLayOut.InsertRow(0)

for lRows = 1 to this.dsDistributionErrors.RowCount()
	
	if iCounter = iMaxPerLabel then
		a = dsErrorLayOut.InsertRow(0)
		iCounter = 1
	else
		iCounter ++
	end if
	
	lQuantity 		= dsDistributionErrors.GetItemNumber(lRows, "nquantity")
	sText		 		= dsDistributionErrors.GetItemString(lRows, "cproduction_text")
	sPackinglist	= dsDistributionErrors.GetItemString(lRows, "cpackinglist")
	
	dsErrorLayout.SetItem(a, "npl_quantity_" + String(iCounter), String(lQuantity))
	dsErrorLayout.SetItem(a, "npl_prod_text_" + String(iCounter), sText)
	dsErrorLayout.SetItem(a, "npl_number_" + String(iCounter), sPackinglist)
	
next

return 0


end function

public function integer of_draw_error_columns (integer iid);//----------------------------------------------------
// 3 Column Objecte zeichnen ...
// 
//
// F$$HEX1$$fc00$$ENDHEX$$r Menge, PL Text und St$$HEX1$$fc00$$ENDHEX$$cklistennummer
//
//----------------------------------------------------
long a, lBorder, lFontSize, lFontWeight, lAlign, lUnder, lItalic, lBackMode
long lBackColor, lFontColor, lR, lM
long lBrushColor, lPenColor, lPenWidth, lBrushHatch, lKey
long i, j, lTextRows, lObjectX[], lObjectWidth[], lObjectAlignment[], lRest
long ll_TextHeight, ll_TextWidth

String sObjectName[]

decimal lX, lY, lW, lH

string sWidth, sHeight, sX, sY, sRet
string sCreate, sName, sText, sFontName
string sSyntax, sToken, sFind, sColumn

integer iCount
integer iPos, iLen

string  sPitch 	= "2"
string  sFamily	= "2"

lX = 5
lY = 60

if dsErrorLayout.Describe("datawindow.processing") = "2" then
	lH = Long(dsErrorLayout.Describe("datawindow.label.height")) - 80
else
	lH = Long(dsErrorLayout.Describe("datawindow.detail.height")) - 80	
end if

lW 			= 1000
lBorder 		= 0
sFontName 	= "Arial"
lFontSize 	= -10
lFontWeight = 400
lAlign 		= 0
lUnder 		= 0
lItalic 		= 0
lBackMode 	= 1
lBackColor 	= 0
lFontColor 	= 0
lBrushColor = 0
lPenColor 	= 0
lPenWidth 	= 1
lBrushHatch = 1

lR 			= 0 //dsObjects.GetItemNumber(lRow, "nresizeable")
lM 			= 0 //dsObjects.GetItemNumber(lRow, "nmoveable")

iuo_FontCalc.of_GetTextSize("Calculate", sFontName, lFontSize * -1, false, false, false, ll_TextHeight, ll_TextWidth)
lTextRows	= lH  / ll_TextHeight

// ----------------------------------------------------------------------------------------------------------
// Menge
// ----------------------------------------------------------------------------------------------------------
sObjectName[1]			= "npl_quantity_"
lObjectX[1]				= lX
iuo_FontCalc.of_GetTextSize("000", sFontName, lFontSize * -1, false, false, false, ll_TextHeight, ll_TextWidth)
lObjectWidth[1] = ll_TextWidth
lObjectAlignment[1] 	= 1
// ----------------------------------------------------------------------------------------------------------
// Text und St$$HEX1$$fc00$$ENDHEX$$cklistennummer teilen sich den restlichen Platz
// ----------------------------------------------------------------------------------------------------------

sObjectName[2]			= "npl_prod_text_"
lObjectX[2]				= lObjectX[1] + lObjectWidth[1] + 2
iuo_FontCalc.of_GetTextSize("AEFGHIJKLM", sFontName, lFontSize * -1, false, false, false, ll_TextHeight, ll_TextWidth)
lObjectWidth[2] = ll_TextWidth
lObjectAlignment[2] 	= 0

sObjectName[3]			= "npl_number_"
lObjectX[3]				= lObjectX[2] + lObjectWidth[2] 
iuo_FontCalc.of_GetTextSize("8888888", sFontName, lFontSize * -1, false, false, false, ll_TextHeight, ll_TextWidth)
lObjectWidth[3] = ll_TextWidth
lObjectAlignment[3] 	= 2

For I = 1 to lTextRows

	for J = 1 to UpperBound(sObjectName)
		
		// ----------------------------------------------------
		// DW Syntax holen
		// ----------------------------------------------------
		sSyntax = dsErrorLayout.describe("datawindow.syntax")
		
		sFind = "text(name=jumppoint"
		iLen = len(sFind)
		iPos = pos(sSyntax, sFind)
		sName = sObjectName[J] + String(I)
		
		if iPos > 0 then
			sSyntax = Mid(sSyntax, 1, iPos - 4) + "column=(type=char(30) updatewhereclause=no name=" + sName + " dbname=" + char(34) + sName + char(34) + ")~r~n" + Mid(sSyntax, iPos - 3)
			//Messagebox("sSyntax", string(sSyntax))
			dsErrorLayout.create(sSyntax)
			//Messagebox("sSyntax", "sSyntax   DONE")
		else
			
			return 0
			
		end  if
		
		// --------------------------------------------------------
		// DW Syntax - neue Column eintragen im DW-Syntax-"Detail"
		// --------------------------------------------------------
		
		iID ++
		sCreate = "create column(band=detail id=" + string(iId) + " alignment='" + string(lObjectAlignment[J]) + &
						"' tabsequence=0 border='" + string(lBorder) + &
						"' color='" + string(lFontColor) + &
						"' x='" + string(lObjectX[J], "0") + "' y='" + string(lY, "0") + &
						"' height='" + string(ll_TextHeight, "0") + "' width='" + string(lObjectWidth[J], "0") + &
						"' format='[General]'  name=" + sName + &
						" resizeable=" + string(lR) + "  moveable=" + string(lM) + &
						" edit.limit=0 edit.case=any edit.autoselect=yes edit.autohscroll=yes  font.face='" + sFontName + &
						"' font.height='" + string(-8) + &
						"' font.weight='" +string(lFontWeight) + &
						"' font.italic='" + string(lItalic) + &
						"' font.underline='" + string(lUnder) + &
						"' font.family='" + sFamily + "' font.pitch='" + sPitch + "' font.charset='0' background.mode='" + string(lBackMode) + &
						"' background.color='" + string(lBackColor) +"')"
						
		sRet = dsErrorLayout.modify(sCreate)
		
	Next	
	
	lY += ll_TextHeight
	
Next

return lTextRows
end function

public function integer of_log (string smsg);

//----------------------------------------------------
// 
// LogFile schreiben
//
//----------------------------------------------------

/*
integer iFile
string 	ls_filename

// initialisieren
if this.ib_Trace then
	ls_filename = "tcbase_label.log"
else
	ls_filename = "cbase_label.log"
end if

//----------------------------------------------------
// 
// LogFile schreiben
//
//----------------------------------------------------

iFile = FileOpen(f_gettemppath() + ls_filename, LineMode!, Write!, Shared!)
FileWrite(iFile, string(today(), "dd.mm.yyyy") + "-" + string(now(), "hh:mm:ss") + " " + sMsg)
FileClose(iFile)
*/
guoLog.uf_allways("["+ this.classname( )+"] " + sMsg)

return 0

end function

public function integer of_draw_pl_columns (long lrow, datastore ods);
//----------------------------------------------------
// 3 Column Objecte zeichnen ...
// 
//
// F$$HEX1$$fc00$$ENDHEX$$r Menge, PL Text und St$$HEX1$$fc00$$ENDHEX$$cklistennummer
//
//----------------------------------------------------

long a, lBorder, lFontSize, lFontWeight, lAlign, lUnder, lItalic, lBackMode
long lBackColor, lFontColor, lR, lM
long lBrushColor, lPenColor, lPenWidth, lBrushHatch, lKey
long i, j, lTextRows
long lObjectX[], lObjectWidth[], lObjectHeight[],  lObjectAlignment[], lObjectWeight[], lRest, lRest1, lRest2
long lWrap, lFontSizes[]
long ll_TextHeight, ll_TextWidth
string sObjectName[]

//decimal lX, lY, lW, lH
long	lX, lY, lW, lH

string sWidth, sHeight, sX, sY, sRet
string sCreate, sName, sText, sFontName
string sSyntax, sToken, sFind, sColumn

integer iCount, iId
integer iPos, iLen

string  sPitch 	= "2"
string  sFamily	= "2"

Long lStart, lEnde
boolean lb_bold

Datastore oDatastore

// of_log("         --------------------------------------------------------")

lKey = dsObjects.GetItemNumber(lRow, "nlabel_detail_key")
lX = dsObjects.GetItemNumber(lRow, "nxpos")
lY = dsObjects.GetItemNumber(lRow, "nypos")
lH = dsObjects.GetItemNumber(lRow, "nheight")
lW = dsObjects.GetItemNumber(lRow, "nwidth")
lBorder = dsObjects.GetItemNumber(lRow, "nborderstyle") 
sFontName = dsObjects.GetItemString(lRow, "cfontname")
lFontSize = dsObjects.GetItemNumber(lRow, "nfontsize")
lFontWeight = dsObjects.GetItemNumber(lRow, "nfontweight")
sName = dsObjects.GetItemString(lRow, "cobject_name")
lAlign = dsObjects.GetItemNumber(lRow, "ntextalign")
lUnder = dsObjects.GetItemNumber(lRow, "nfontunderline")
lItalic = dsObjects.GetItemNumber(lRow, "nfontitalic")
lBackMode = dsObjects.GetItemNumber(lRow, "nbackgroundmode")
lBackColor = dsObjects.GetItemNumber(lRow, "nbackgroundcolor")
lFontColor = dsObjects.GetItemNumber(lRow, "nfontcolor")
lBrushColor = dsObjects.GetItemNumber(lRow, "nbrushcolor")
lPenColor = dsObjects.GetItemNumber(lRow, "npencolor")
lPenWidth = dsObjects.GetItemNumber(lRow, "npenwidth")
lBrushHatch = dsObjects.GetItemNumber(lRow, "nbrushhatch")
sText = dsObjects.GetItemString(lRow, "cvalue")
scolumn = dsObjects.GetItemString(lRow, "ccolumn")
lR = 0 //dsObjects.GetItemNumber(lRow, "nresizeable")
lM = 0 //dsObjects.GetItemNumber(lRow, "nmoveable")
lb_bold =(lFontWeight = 700)

lWrap = dsObjects.GetItemNumber(lRow, "nwrap")

if lWrap = 1 then
	lH = lH / 2
end if

// Textgr$$HEX2$$f600df00$$ENDHEX$$e ermitteln
iuo_FontCalc.of_GetTextSize("Calculate", sFontName, lFontSize * -1, lb_bold, false, false, ll_TextHeight, ll_TextWidth)

// eigentlich sollte es so sein...
// aber da es generell schrott ist, f$$HEX1$$fc00$$ENDHEX$$r das zeichnen und nachher das bef$$HEX1$$fc00$$ENDHEX$$llen separat zu berechnen, 
// 		lassen wir erstmal die im zweifel h$$HEX1$$f600$$ENDHEX$$here anzahl beim generieren der columns hier stehen,
// 		das macht weniger $$HEX1$$e400$$ENDHEX$$rger, als wenn es mal umgekehrt laufen sollte
//lTextRows 				= truncate(lH  / (ll_TextHeight + 1), 0)
lTextRows				= lH  / ll_TextHeight

//Messagebox(" ++++ UO_LABEL_OTHER +++++", "lHeight:" + string(lH) + "~r~rll_TextHeight" + string(ll_TextHeight) +  "~r~rlTextRows: " +  string(lTextRows))

// -------------------------------------------------------
// Alte Verarbeitung
// alles auf einer Zeile
// -------------------------------------------------------
if lWrap <> 1 then

	// ----------------------------------------------------------------------------------------------------------
	// Menge
	// ----------------------------------------------------------------------------------------------------------
	sObjectName[1]			= "npl_quantity_"
	lObjectX[1]				= lX
	lFontSizes[1]			= lFontSize
	// CBASE-UK-CR-2016-023 The label shold only have place for 3 digits instead of 4
	//iuo_FontCalc.of_GetTextSize("0000", sFontName, lFontSize * -1, true, false, false, lObjectHeight[1], lObjectWidth[1])
	iuo_FontCalc.of_GetTextSize("000", sFontName, lFontSize * -1, true, false, false, lObjectHeight[1], lObjectWidth[1])
	lObjectAlignment[1] 	= 1
	lObjectWeight[1]		= 700
	
	// ----------------------------------------------------------------------------------------------------------
	// Text und St$$HEX1$$fc00$$ENDHEX$$cklistennummer teilen sich den restlichen Platz
	// ----------------------------------------------------------------------------------------------------------
	lRest  = (lW - lObjectWidth[1]) / 2
	lRest1 = (lW - lObjectWidth[1]) * 0.6 // 70% des restlichen Platzes f$$HEX1$$fc00$$ENDHEX$$r den Text
	lRest2 = (lW - lObjectWidth[1]) * 0.4 // 30% des restlichen Platzes f$$HEX1$$fc00$$ENDHEX$$r die SNR
	
	sObjectName[2]			= "npl_prod_text_"
	lObjectX[2]				= lObjectX[1] + lObjectWidth[1] + 2
	lFontSizes[2]			= lFontSize
	lObjectHeight[2] 		= ll_TextHeight
	lObjectWidth[2] 		= lRest1
	lObjectAlignment[2] 	= 0
	lObjectWeight[2]		= lFontWeight
	
	sObjectName[3]			= "npl_number_"
	lObjectX[3]				= lObjectX[2] + lObjectWidth[2] + 2
	lFontSizes[3]			= lFontSize
	lObjectWidth[3] 		= lRest2
	lObjectHeight[3] 		= ll_TextHeight
	lObjectAlignment[3] 	= 2  // Rechtsb$$HEX1$$fc00$$ENDHEX$$ndig
	lObjectWeight[3]		= lFontWeight
	
	//Wrap-Schalter f$$HEX1$$fc00$$ENDHEX$$r Mealcodeanzeige
	iMealcodeWrapped = 0
	
else
	
	// ----------------------------------------------------------------------------------------------------------
	// Menge
	// ----------------------------------------------------------------------------------------------------------
	sObjectName[1]			= "npl_quantity_"
	lFontSizes[1]			= lFontSize * 2
	lObjectX[1]				= lX
	// CBASE-UK-CR-2016-023 The label shold only have place for 3 digits instead of 4
	iuo_FontCalc.of_GetTextSize("000", sFontName, lFontSizes[1] * -1, true, false, false, lObjectHeight[1], lObjectWidth[1])
	//iuo_FontCalc.of_GetTextSize("0000", sFontName, lFontSizes[1] * -1, true, false, false, lObjectHeight[1], lObjectWidth[1])
	lObjectAlignment[1] 	= 1
	lObjectWeight[1]		= 700
	// ----------------------------------------------------------------------------------------------------------
	// Text und St$$HEX1$$fc00$$ENDHEX$$cklistennummer teilen sich den restlichen Platz
	// ----------------------------------------------------------------------------------------------------------
	lRest  = (lW - lObjectWidth[1]) / 2
	lRest1 = (lW - lObjectWidth[1]) 
	
	sObjectName[2]			= "npl_prod_text_"
	lFontSizes[2]			= lFontSize
	lObjectX[2]				= lObjectX[1] + lObjectWidth[1] + 6
	lObjectHeight[2] 		= ll_TextHeight
	lObjectWidth[2] 		= lRest1
	lObjectAlignment[2] 	= 0
	lObjectWeight[2]		= lFontWeight
	
	sObjectName[3]			= "npl_number_"
	lObjectX[3]				= lObjectX[1] + lObjectWidth[1] + 6
	lFontSizes[3]			= lFontSize
	lObjectHeight[3] 		= ll_TextHeight
	lObjectWidth[3] 		= lRest1
	lObjectAlignment[3] 	= 0  // Rechtsb$$HEX1$$fc00$$ENDHEX$$ndig
	lObjectWeight[3]		= lFontWeight
	
	//---------------------------------------------------------------------------------------------------------------
	//MB 22.01.2013: 4. Objekt f$$HEX1$$fc00$$ENDHEX$$r mealcode Zeichnen
	//---------------------------------------------------------------------------------------------------------------

	sObjectName[4]			= "npl_mealcode_"
	lObjectX[4]				= lObjectX[3] + (lObjectWidth[3] * 0.7)
	lFontSizes[4]			= lFontSize
	lObjectHeight[4] 		= ll_TextHeight
	lObjectWidth[4] 		= (lRest1/4) - 2
	lObjectAlignment[4] 	= 1
	lObjectWeight[4]		= 700 //Fett

	//Wrap-Schalter f$$HEX1$$fc00$$ENDHEX$$r Mealcodeanzeige
	iMealcodeWrapped = 1

end if


For I = 1 to lTextRows
	
	lStart = CPU()
	
	of_log("            - distributed comp. creating " + string(lTextRows) + " rows with " +  string(UpperBound(sObjectName)) + " columns" )
	
	for J = 1 to UpperBound(sObjectName)

		// ----------------------------------------------------
		// DW Syntax holen
		// ----------------------------------------------------
		sSyntax = dsLayout.describe("datawindow.syntax")
		
		sFind = "text(name=jumppoint"
		iLen = len(sFind)
		iPos = pos(sSyntax, sFind)
		
		// -----------------------------------------------------------
		// im DW Syntax - neue Column eintragen im DW-Syntax-"Header"
		// -----------------------------------------------------------
		iId = of_get_next_column_id(ii_max_columns_in_dw, dsLayout) // 07.12.2012 HR: 7 -> ii_max_columns_in_dw
		
		
		///Messagebox("DetailColumns !!!!", iID)
		
		if iPos > 0 then
		
			sName = sObjectName[J] + String(I)
			sSyntax = Mid(sSyntax, 1, iPos - 4) + "column=(type=char(30) updatewhereclause=no name=" + sName + " dbname='" + sName + "')~r~n" + Mid(sSyntax, iPos - 3)
			dsLayout.create(sSyntax)
			
			if this.ib_trace then this.of_log("Trace create column: ID=" + string(iId) + ", columnname=" + sName)
		
		else
			
			return 0
			
		end  if
		
		// --------------------------------------------------------
		// Bei nwrap = 1 (Zeilenumbruch) das 3. Feld eine Zeile
		// tiefer zeichnen
		// --------------------------------------------------------
		if j = 3 and lWrap = 1 then 
			lY += ll_TextHeight
		end if
		
		sCreate = "create column(band=detail id=" + string(iId) + " alignment='" + string(lObjectAlignment[J]) + &
						"' tabsequence=0 border='" + string(lBorder) + &
						"' color='" + string(lFontColor) + &
						"' x='" + string(lObjectX[J], "0") + "' y='" + string(lY, "0") + &
						"' height='" + string(lObjectHeight[J], "0") + "' width='" + string(lObjectWidth[J], "0") + &
						"' format='[General]'  name=" + sName + &
						" resizeable=" + string(lR) + "  moveable=" + string(lM) + &
						" edit.limit=0 edit.case=any edit.autoselect=yes edit.autohscroll=yes  font.face='" + sFontName + &
						"' font.height='" + string(lFontSizes[J]) + &
						"' font.weight='" +string(lObjectWeight[J]) + &
						"' font.italic='" + string(lItalic) + &
						"' font.underline='" + string(lUnder) + &
						"' font.family='" + sFamily + "' font.pitch='" + sPitch + "' font.charset='0' background.mode='" + string(lBackMode) + &
						"' background.color='" + string(lBackColor) +"' )"
		
		sRet = dsLayout.modify(sCreate)
		
		if sRet <> "" then
			of_log("Error -4, create pl column: " + sRet)
			of_log("Error -4, create syntax: " + sCreate)
			return -4
		end if
		
		a = dsObjects.InsertRow(0)
		dsObjects.SetItem(a, "nlabel_detail_key", dsObjects.GetItemNumber(lRow, "nlabel_detail_key"))
		dsObjects.SetItem(a, "nobject_type", 1)
		dsObjects.SetItem(a, "nxpos", lObjectX[J])
		dsObjects.SetItem(a, "nypos", lY)
		dsObjects.SetItem(a, "nheight", ll_TextHeight)
		dsObjects.SetItem(a, "nwidth", lObjectWidth[J])
		dsObjects.SetItem(a, "nborderstyle", lBorder)
		dsObjects.SetItem(a, "cfontname", sFontName)
		dsObjects.SetItem(a, "nfontsize", lFontSize)
		dsObjects.SetItem(a, "nfontweight", lFontWeight)
		dsObjects.SetItem(a, "cobject_name", sName)
		dsObjects.SetItem(a, "ntextalign", lAlign)
		dsObjects.SetItem(a, "nfontunderline", lUnder)
		dsObjects.SetItem(a, "nbackgroundmode", lBackMode)
		dsObjects.SetItem(a, "nfontcolor", lFontColor)
		dsObjects.SetItem(a, "nbackgroundcolor", lBrushColor)
		dsObjects.SetItem(a, "nbrushcolor", lBrushColor)
		dsObjects.SetItem(a, "npencolor", lPenColor)
		dsObjects.SetItem(a, "npenwidth", lPenWidth)
		dsObjects.SetItem(a, "nbrushhatch", lBrushHatch)
		dsObjects.SetItem(a, "ccolumn", sName)
		//of_log("                - column: " + sName)

	Next	
	
	lY += ll_TextHeight + 1
	
	lEnde = CPU()
//	of_log("            - " + String((lEnde - lStart) / 1000, "00.00") + " seconds for row " + string(J))

	
Next

//of_log("         --------------------------------------------------------")

return 0
end function

public function integer of_draw (integer iprintertype);// -------------------------------
// Objekte zeichnen
// -------------------------------	

long 			a, &
				lVal, &
				lFound
				
integer 		iRet

string 		sCreate, &	
				sObject, &
				sRet, &
				sColumnName


// --------------------------------------------------------------------------------------------------------------------
// 26.09.2022 HR: Wir setzen am Anfang mal den Standarddrucker vom Starten
// --------------------------------------------------------------------------------------------------------------------
if cbase.is_RemoteDesktopDefaultprinter > " " then
	dsLayout.Modify("datawindow.printer='" +cbase.is_RemoteDesktopDefaultprinter + "'")
	f_set_printer( cbase.is_RemoteDesktopDefaultprinter ) 
end if

	
if iPrinterType = 1 then
	
	lVal = dsMaster.GetItemNumber(1, "nlabel_height") 
	dsLayout.modify("datawindow.detail.height = " + string(lVal))
	
elseif iPrinterType = 2 then
	
	dsLayout.modify("datawindow.print.margin.left = " + string(dsMaster.GetItemNumber(1, "nborder_x")))
	dsLayout.modify("datawindow.print.margin.top = " + string(dsMaster.GetItemNumber(1, "nborder_y")))
	dsLayout.modify("datawindow.print.margin.bottom = 0")
	dsLayout.modify("datawindow.print.margin.right = 0")
	dsLayout.modify("datawindow.label.height=" + string(dsMaster.GetItemNumber(1, "nlabel_height")))
	dsLayout.modify("datawindow.label.width=" + string(dsMaster.GetItemNumber(1, "nlabel_width")))
	dsLayout.modify("datawindow.label.rows=" + string(dsMaster.GetItemNumber(1, "n_rows_per_page")))			
	dsLayout.modify("datawindow.label.rows.spacing=" + string(dsMaster.GetItemNumber(1, "nrow_space")))	
	dsLayout.modify("datawindow.label.columns=" + string(dsMaster.GetItemNumber(1, "n_cols_per_page")))	
	dsLayout.modify("datawindow.label.columns.spacing=" + string(dsMaster.GetItemNumber(1, "ncol_space")))
	
	// ----------------------------------------------------
	// DS erneut erzeugen (funktioniert nicht anders)
	// ----------------------------------------------------
	sCreate = dsLayout.describe("datawindow.syntax")
	dsLayout.create(sCreate)
	
end if


// ---------------------------------
// Die Objekte ins Label zeichnen
// ---------------------------------
Long lRows
lRows = dsObjects.rowcount()

for a = 1 to lRows

	if dsObjects.GetItemNumber(a, "nobject_type")	= 1 then		

		iRet = of_draw_column(a, dsLayout) 
		if iRet <> 0 then
			return iRet
		end if
	elseif dsObjects.GetItemNumber(a, "nobject_type")	= 2 then		
		iRet = of_draw_text(a, dsLayout)	
		if iRet <> 0 then
			return iRet
		end if
	elseif dsObjects.GetItemNumber(a, "nobject_type")	= 3 then		
		iRet = of_draw_rect(a, dsLayout)		
		if iRet <> 0 then
			return iRet
		end if
	elseif dsObjects.GetItemNumber(a, "nobject_type")	= 4 then		
		iRet = of_draw_line(a, dsLayout)		
		if iRet <> 0 then
			return iRet
		end if
	elseif dsObjects.GetItemNumber(a, "nobject_type")	= 5 then		
		iRet = of_draw_bmp(a, dsLayout)		
		if iRet <> 0 then
			return iRet
		end if
	elseif dsObjects.GetItemNumber(a, "nobject_type")	= 6 then		
		iRet = of_draw_barcode(a, dsLayout)		
		if iRet <> 0 then
			return iRet
		end if
	end if
	
next

// ---------------------------------
// Dummy Columns f$$HEX1$$fc00$$ENDHEX$$r die Fontgr$$HEX2$$f600df00$$ENDHEX$$e
// ---------------------------------

for a = 1 to dsObjects.rowcount()

	if dsObjects.GetItemNumber(a, "nobject_type") = 1 then		

		iRet = of_draw_column_font_dummy(a, dsLayout) 
		
		if iRet <> 0 then
			return iRet
		else
			
			// ----------------------------------
			// Die Column suchen und pr$$HEX1$$fc00$$ENDHEX$$fen, ob
			// f$$HEX1$$fc00$$ENDHEX$$r diese die FontSize kalkuliert
			// werden soll .....................
			// ----------------------------------
			lFound = dsColumns.Find("ccolumn='" + dsObjects.GetItemString(a, "ccolumn") + "'", 1, dsColumns.RowCount())
			
			//Messagebox("", dsObjects.GetItemString(a, "ccolumn") + "   lFound:"  + string(lFound))
			//f_print_datastore(dsObjects)
			
			if lFound > 0 then
			
				if dsColumns.GetItemNumber(lFound, "ncalculate_size") = 1 then
			
					sObject = dsObjects.GetItemString(a, "cobject_name")
					sRet = dsLayout.Modify(sObject + ".font.height='-8~t fs_" + sObject + "'")
					
				end if
				
			end if
									
		end if
		
	end if
		
Next

// ---------------------------------
// Bitmaps in den Hintergrund
// ---------------------------------
for a = 1 to dsObjects.rowcount()
	if dsObjects.GetItemNumber(a, "nobject_type") = 5 then		
		sObject = dsObjects.GetItemString(a, "cobject_name")
		iRet = dsLayout.Setposition(sObject, "detail", False)
	end if
next

return 0

end function

public function integer of_split_distribution_text (string sstring, ref s_distribution_text strvalues[]);// ----------------------------------------------------
//
// Tab getrennte Text aufsplitten
//
// ----------------------------------------------------
Integer iStartPos, iEndPos, iPos, iPosText, iPosPLNumber, iCount, iItem,iPosMealcode

string sToken, sText, sPLNumber, sQuantity
			
iEndPos		= 1
iStartPos 	= 1

if isnull(sString) then return 0	

do while iEndPos > 0
			
	iEndPos	 = Pos(sString, "~n",  iStartPos)
				
	if iEndPos > 0 then
				
		sToken 			= Mid(sString, iStartPos, iEndPos - iStartPos)
				
		iPos 				= Pos(sToken, "~t")
		iPosText			= Pos(sToken, "~t", iPos + 1)
		iPosMealcode = Pos(sToken, "~t", iPosText + 1)
		
		iItem = UpperBound(strValues) + 1
		strValues[iItem].sQuantity 		= Mid(sToken, 1, iPos -1)
		strValues[iItem].sText 				= Mid(sToken, iPos + 1, iPosText - iPos - 1)
		strValues[iItem].spackinglist		= Mid(sToken, iPosText + 1,iPosMealcode - iPosText -1 ) 
		strValues[iItem].smealcode		= Mid(sToken, iPosMealcode + 1 ) 
	
		iStartPos = iEndPos + 1			
					
	end if
	
	iCount ++
	if iCount > 1000 then exit
	
loop

// Messagebox("No of items !!!", Upperbound(strValues))

return 0
end function

public function integer of_fill_prod_columns (long lrowdata, long lrowinsert, datastore odw, string sflgnr, date ddepdate, string stime, string sdestination, string sactype);// --------------------------------------------------
// Die Columns mir Werte f$$HEX1$$fc00$$ENDHEX$$llen
// --------------------------------------------------
str_label_print 		strPrint[]
s_distribution_text	strValues[], strEmpty[]

integer 				iCount, &
						iFontSize, &
						iStartSize, &
						iItems

long 					lColumns, &
						lFound, &
						lWidth, &
						lHeight, &
						lForTo, &
						lCheck
						
string 				sObject, &
						sColumn, &
						sFont, &
						sFindColumn, &
						sNotFound, &
						sValue, &
						sWrapText


//Parameter f$$HEX1$$fc00$$ENDHEX$$r cflights						
string	sairline
date	ddeparture
long	lpl_index
string	sflight
boolean lb_Bold, lb_Italic, lb_Underline, lb_Wrap
long	l_belly

f_trace("uo_label_other of_fill_prod_columns START")	


// ---------------------------------------------------------------
// Erstmal die "spezial" Columns in die Struktur
// schreiben.
// Dies sind alle welche in der Tabelle SYS_LABEL_COLUMNS
// nexternal auf 1 gesetzt haben
// ---------------------------------------------------------------
iCount ++
strPrint[iCount].cColumn = "flugnummer"
strPrint[iCount].cValue = sFlgnr
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn = "datum"
strPrint[iCount].cValue = String(dDepDate)
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn = "tag"
strPrint[iCount].cValue = String(day(dDepDate), "00")
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn = "monat"
strPrint[iCount].cValue = String(month(dDepDate), "00")
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn = "jahr4"
strPrint[iCount].cValue = String(dDepDate, "yyyy")
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn = "jahr2"
strPrint[iCount].cValue = String(dDepDate, "yy")
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn = "timedeparture"
strPrint[iCount].cValue = sTime
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn = "destination"
strPrint[iCount].cValue = sDestination
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn = "timeprint"
strPrint[iCount].cValue = String(now(), "hh:mm:ss")
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn = "dateprint"
strPrint[iCount].cValue = String(Today())
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn = "actype"
strPrint[iCount].cValue = sActype
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn = "rampbox"
strPrint[iCount].cValue = this.sRampBox
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn = "ramptime"
strPrint[iCount].cValue = this.sRampTime
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn = "kitchentime"
strPrint[iCount].cValue = this.sKitchenTime
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn = "printdate"
strPrint[iCount].cValue = string(today())
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn 	= "printday"
strPrint[iCount].cValue 	= String(Day(Today()), "00")
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn 	= "printweekday"
strPrint[iCount].cValue 	= this.sPrintWeekDay
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0

iCount ++
strPrint[iCount].cColumn 	= "cflightranges"
strPrint[iCount].cValue 	= "X,Y,Z"
strPrint[iCount].nExternal = 1
strPrint[iCount].ncalculate_size = 0


iCount ++

// --------------------------------------------------
// dann alle anderen in die Struktur schreiben ...
// --------------------------------------------------
sNotFound = ""

for lColumns = 1 to dsColumns.RowCount()
	
	// --------------------------------------------------
	// ... aber nur, wenn es die Column im Datastore gibt
	// --------------------------------------------------
	sFindColumn = dsColumns.GetItemString(lColumns, "ccolumn")
	lCheck = dsLoadinglistColumns.Find("sobject = '" + sFindColumn + "'", 1, dsLoadinglistColumns.RowCount())
	if lCheck <= 0 then
		continue
	end if
	
	iCount ++
	strPrint[iCount].cColumn = dsColumns.GetItemString(lColumns, "ccolumn")
	if mid(oDW.Describe(strPrint[iCount].cColumn + ".coltype"), 1, 4) = "char" then
		strPrint[iCount].cValue = of_checknull(oDW.GetItemString(lRowData, strPrint[iCount].cColumn))
	elseif oDW.Describe(strPrint[iCount].cColumn + ".coltype") = "datetime" then
		strPrint[iCount].cValue = String(oDW.GetItemDateTime(lRowData, strPrint[iCount].cColumn))
	else		
		strPrint[iCount].cValue = String(oDW.GetItemNumber(lRowData, strPrint[iCount].cColumn))
	end if
		
	strPrint[iCount].nExternal = 0
	strPrint[iCount].ncalculate_size = dsColumns.GetItemNumber(lColumns, "ncalculate_size")
	
next

// --------------------------------------------------
// und zum Schlu$$HEX2$$df002000$$ENDHEX$$die Werte ins Label eintragen !!!
// --------------------------------------------------
for lColumns = 1 to dsObjects.RowCount()
	// --------------------------------------------------
	// erstmal schaun, ob es ne column ist
	// --------------------------------------------------
	if dsObjects.GetItemNumber(lColumns, "nobject_type") = 1 then
		
		// --------------------------------------------------
		// wenn ja, den Objekt und Columnnamen merken
		// --------------------------------------------------
		sObject = dsObjects.GetItemString(lColumns, "cobject_name")
		sColumn = dsObjects.GetItemString(lColumns, "ccolumn")
		
		// --------------------------------------------------
		// Nun noch die Column in der Struktur suchen und
		// ins Label eintragen
		// --------------------------------------------------
		for iCount = 1 to UpperBound(strPrint)
			
			if strPrint[iCount].cColumn = sColumn then
				
				// --------------------------------------------------
				// Spezialfeld cdistributed_components bekommt eine
				// besondere Behandlung
				// --------------------------------------------------
				if sColumn <> "cdistributed_components" then
				
					lb_Wrap = (dsObjects.GetItemNumber(lColumns, "nwrap") = 1)
					//if sColumn <> "cflights" then

					if sColumn <> "cflights" AND sColumn <> "cflights_all"  AND sColumn <> "cflightranges" then
						if lb_Wrap then
							sWrapText = strPrint[iCount].cValue
							sValue = of_wrap(of_checknull(sWrapText), 8, 5, 4)					
						else
							sValue = of_checknull(strPrint[iCount].cValue)	
						end if 
					else
						if sColumn = "cflights" then
							sairline = odw.getitemstring(lrowdata,"cairline")
							ddeparture = ddepdate
							lpl_index = odw.getitemnumber(lrowdata,"npackinglist_index_key")
							sflight = strPrint[iCount].cValue
							l_belly = odw.getitemnumber(lrowdata,"nbelly")
							sValue = of_return_max_text(of_checknull(of_get_prod_cflight( sairline, ddeparture, lpl_index,sflight,l_belly )),lColumns)		
						Elseif sColumn = "cflights_all" then
							//CBASE-CR-UK-2016-026 Bulk Label Flt Num - neue Columns
							sairline = odw.getitemstring(lrowdata,"cairline")
							ddeparture = ddepdate
							lpl_index = odw.getitemnumber(lrowdata,"npackinglist_index_key")
							sflight = strPrint[iCount].cValue
							l_belly = odw.getitemnumber(lrowdata,"nbelly")
							sValue = of_return_max_text(of_checknull(of_get_prod_cflight_all( sairline, ddeparture, lpl_index,sflight,l_belly )),lColumns)		
							
						Elseif sColumn = "cflightranges" then
							// CBASE-CR-UK-2016-026 Bulk Label Flt Num - "Flight Range"
							sairline = odw.getitemstring(lrowdata,"cairline")
							ddeparture = ddepdate
							lpl_index = odw.getitemnumber(lrowdata,"npackinglist_index_key")
							sflight = strPrint[iCount].cValue
							l_belly = odw.getitemnumber(lrowdata,"nbelly")
							//sValue = "$$HEX1$$d600$$ENDHEX$$,$$HEX1$$c400$$ENDHEX$$,$$HEX1$$dc00$$ENDHEX$$"

							sValue = of_get_prod_cflightranges( sairline, ddeparture, lpl_index,sflight,l_belly )
																				
						end if
					end if
					
					dsLayout.SetItem(lRowInsert,sObject,sValue)
					
					lFound = dsColumns.Find("ccolumn='" + dsObjects.GetItemString(lColumns, "ccolumn") + "'", 1, dsColumns.RowCount())
					if lFound > 0 then
						if dsColumns.GetItemNumber(lFound, "ncalculate_size") = 1 then							
							lHeight 			= Long(dsLayout.Describe(sObject + ".height"))
							lWidth  			= Long(dsLayout.Describe(sObject + ".width"))
							sFont 			= dsLayout.Describe(sObject + ".font.face")
							iStartSize 		= dsObjects.GetItemNumber(lColumns, "nfontsize") * -1							
									
							// Die optimale Schriftgr$$HEX2$$f600df00$$ENDHEX$$e ermitteln
							lb_Bold = (dsObjects.GetItemNumber(lColumns, "nfontweight") = 700)
							lb_Italic = (dsObjects.GetItemNumber(lColumns, "nfontitalic") = 1)
							lb_Underline = (dsObjects.GetItemNumber(lColumns, "nfontunderline") = 1)
							iuo_FontCalc.of_GetOptFontSize(sValue, sFont, iFontSize, lb_Bold, lb_Italic, lb_Underline, lHeight, lWidth, false)
							
							// Wenn die optimale Schriftgr$$HEX2$$f600df00$$ENDHEX$$e gr$$HEX2$$f600df00$$ENDHEX$$er ist, als die Start-Schriftgr$$HEX2$$f600df00$$ENDHEX$$e, nehmen wir die Start-Schriftgr$$HEX2$$f600df00$$ENDHEX$$e
							if iFontSize > iStartSize then iFontSize = iStartSize
							dsLayout.SetItem(lRowInsert, "fs_" + sObject, -iFontSize)
						end if
					end if
					
					exit
					
				else
				
					strValues = strEmpty
					of_split_distribution_text(strPrint[iCount].cValue, strValues)

					//messagebox("D A N A C H !!!!!!!!!!!!!", UpperBound(strValues))

					for iItems = 1 to UpperBound(strValues)
						
						//Messagebox("", strValues[iItems].sQuantity)
						
						dsLayout.SetItem(lRowInsert, "npl_quantity_" + String(iItems), strValues[iItems].sQuantity)
						dsLayout.SetItem(lRowInsert, "npl_prod_text_" + String(iItems), strValues[iItems].sText)
						dsLayout.SetItem(lRowInsert, "npl_number_" + String(iItems), strValues[iItems].sPackinglist)
						
					Next
					
				end if	
				
			end if
			
		next
				
	end if

Next

return 0
end function

public function integer of_set_printer_type (integer iprintertype, long llabeltype);Integer 	I
String 	sPrinters[]

// -----------------------------------------
// iPrintertype pr$$HEX1$$fc00$$ENDHEX$$fen
// -----------------------------------------

dsLayout.Reset()
sGeneratedForPrinter = ""

		
dsLayout.dataobject = "dw_label_layout_other"


if isbelly then
	sPrinters = this.sLocalBellyPrinters
else
	sPrinters = this.sLocalPrinters
end if


For I = 1 to UpperBound(lLocalLabelTypes)
	
	//Messagebox("", "Suche: " + string(lLabelType) + "~n~n" + string(lLocalLabelTypes[i]) + " - " + sLocalPrinters[i])
	
	if lLocalLabelTypes[i] = lLabelType then

		this.sGeneratedForPrinter = sPrinters[i]	
		
		//Messagebox("", "Treffer")
		
		If Pos(Upper(sPrinters[i]), "ZEBRA") > 0 then
			//Messagebox("", "ES ist ein ZEBRA")
			dsLayout.dataobject = "dw_label_layout_thermo"
			iThermo = 1
			return 1
			
		else
			//Messagebox("", "ES ist KEIN Zebra")
			dsLayout.dataobject = "dw_label_layout_other"	
			iThermo = 0
			return 2
			
		end if

		Exit
		
	end if
	
Next

return 0

end function

public function integer of_build_label (date ddepdate, long llabeltype, integer iprintertype);
DateTime dtValid, dtSearch
Long lFound, lSize
String sName
integer iRet, iPrinterRet, iState, i
blob bBlob
long lStart, lEnde

//Messagebox("", "Start Typ: " + string(llabeltype) )

lStart = CPU()
// -----------------------------------------
// Suchen des g$$HEX1$$fc00$$ENDHEX$$ltigen Labels
// -----------------------------------------
dtSearch = Datetime(dDepDate, Time("00:00:00"))
dtValid = of_find_valid_label(lLabelType, dtSearch) 

if isnull(dtValid)  then
	return -2
end if

dsObjects.Retrieve(lLabelType, dtValid)
lFound = dsObjects.Find("nobject_type = 1", 1, dsObjects.RowCount())

if dsObjects.RowCount() = 0 then
	of_log("Error -10, No Objects for this Label Row(s) retrieved =  0")
	of_log("Error -10, retrival arguments: lLabelType = " + string(lLabelType) + " dtValid = " + string(dtValid) )
	return -10
end if

if lFound = 0 then
	of_log("Error -11, Label has no Columns defined")
	return -11
end if

// 21.09.2012, KF: rausfinden, ob ein Barcode drauf ist
lFound = dsObjects.Find("nobject_type = 6", 1, dsObjects.RowCount())

if lFound > 0 then
	this.ihasbarcode = 1
else
	this.ihasbarcode = 0
end if


// -----------------------------------------
// Wir schaun mal nach, ob der Labeltype
// schonmal generiert wurde. Wenn ja dann
// machen wir das nat$$HEX1$$fc00$$ENDHEX$$rlich nicht nochmal
// -----------------------------------------
for i = 1 to UpperBound(this.strLabelTypes)
	
	// 04.05.2018 T.Schaefer: AlmId 3093: Auch die Gueltigkeit muss passen, damit wir das bereits generierte Layout nutzen koennen.
	if this.strLabelTypes[i].lLabelType = lLabelType and this.strLabelTypes[i].dvalid_from = dtValid and this.strLabelTypes[i].bBelly  = this.isBelly then
		this.of_destroy_layout()
		iState = dsLayout.SetFullState(this.strLabelTypes[i].bLayout)
			this.imealcodewrapped = this.strLabelTypes[i].iMealcode
		this.sGeneratedForPrinter = this.strLabelTypes[i].sPrinter
		If Pos(Upper(this.sGeneratedForPrinter), "ZEBRA") > 0 then
			this.iThermo = 1
		else
			iThermo = 0
		end if
		return 0
	end if 

Next 

// -----------------------------------------
// iPrintertype pr$$HEX1$$fc00$$ENDHEX$$fen und dsLayout $$HEX1$$e400$$ENDHEX$$ndern
// -----------------------------------------
iPrinterRet = of_set_printer_type(iPrinterType, lLabelType)

if iPrinterRet < 0 then
	return -3
end if

// -----------------------------------------
// soweit alles ok, LabelLayout erzeugen
// -----------------------------------------
dsMaster.Retrieve(lLabelType, dtValid)

if dsMaster.RowCount() <> 1 then
	of_log("Error -9, Row(s) retrieved =  " + string(dsMaster.RowCount()) )
	of_log("Error -9, retrival arguments: lLabelType = " + string(lLabelType) + " dtValid = " + string(dtValid) )
	return -9
end if

this.of_destroy_layout()
iRet = of_draw(iPrinterRet)

if iRet <> 0 then
	return iRet
end if
	
// ---------------------------------------------
// wir merken uns den gerade generierten 
// Labeltyp f$$HEX1$$fc00$$ENDHEX$$rs n$$HEX1$$e400$$ENDHEX$$chste mal
// ---------------------------------------------
dsLayout.Modify("datawindow.printer='" + this.sGeneratedForPrinter + "'")
lSize = dsLayout.GetFullState(bBlob)

// MHO Tuning und Bugfix !!!  Cache hatte nicht zu 100% gearbeitet. Neue uo_label_other fingen hier wieder bei 0 an
this.lLabelTypeCounter = upperbound(this.strLabelTypes)
this.lLabelTypeCounter ++

this.strLabelTypes[lLabelTypeCounter].lLabelType 	= lLabelType
this.strLabelTypes[lLabelTypeCounter].bLayout 		= bBlob
this.strLabelTypes[lLabelTypeCounter].sPrinter     = this.sGeneratedForPrinter
this.strLabelTypes[lLabelTypeCounter].bBelly    	= this.isBelly
this.strLabelTypes[lLabelTypeCounter].iMealcode    	= this.iMealcodeWrapped
// 04.05.2018 T.Schaefer: AlmId 3093: Auch die Gueltigkeit muss passen, damit wir das bereits generierte Layout nutzen koennen.
this.strLabelTypes[lLabelTypeCounter].dvalid_from = dtValid
lEnde = CPU()
// Messagebox("", "Ende Typ: " + string(llabeltype) )
// of_log("    - " + String((lEnde - lStart) / 1000, "00.00") + " building label-type [" + string(lLabelType) + "]")

return 0

end function

public function integer of_analyse (datastore odw);//----------------------------------------------------
// Alle Objecte im DW analysieren
//----------------------------------------------------

integer 	i, &
			j, &
			iCount, &
			iPos, &
			iAnchorY, &
			iY
			
string 	sDWObjects, &
			sTemp, &
			sObjects[], &
			sBand, &
			sSyntax, &
			sType, &
			sTag, &
			sHeader
			
long 		lInsert

// ---------------------------------------
// Nachschaun, ob gruppiert ist
// ---------------------------------------

sSyntax = oDW.Describe("datawindow.syntax")

// ---------------------------------------
// Alle Objekte von DW_LAYOUT auslesen
// ---------------------------------------
 sDWObjects = oDW.describe("datawindow.objects")

// ---------------------------------------
// Den String zerhacken und alle Objekte
// ein Array schreiben
// ---------------------------------------

for i = 1 to len(sDWObjects)
	
	if Mid(sDWObjects, i, 1) <> char(9) then
		
		sTemp += Mid(sDWObjects, i, 1)
		
	else
				
		iCount ++
		sObjects[iCount] = sTemp
		sTemp = ""
		
	end if

next

if len(sTemp) > 0 then		
	iCount ++
	sObjects[iCount] = sTemp
end if


// ---------------------------------------
// Die Objekte nach Header und Detail Band
// trennen
// ---------------------------------------

for i = 1 to UpperBound(sObjects)
	
	sBand = oDW.Describe(sObjects[i] + ".band")
	sType = oDW.Describe(sObjects[i] + ".type")
	
	if lower(sBand) = "detail" and (lower(sType) = "column" or lower(sType) = "compute") then
		
		// -----------------------------------------------------------------------
		// Nur die Objekte merken, die im detail band stehen
		// -----------------------------------------------------------------------
		lInsert = dsLoadinglistColumns.InsertRow(0)
		dsLoadinglistColumns.SetItem(lInsert, "sobject", oDW.Describe(sObjects[i] + ".name"))
		dsLoadinglistColumns.SetItem(lInsert, "stype", sType)
		dsLoadinglistColumns.SetItem(lInsert, "sband", sband)
		
	end if
			
	
Next

//f_print_datastore(dsLoadinglistColumns)

return 0
end function

public function integer of_label_production (datastore dwdata, integer iprintertype, integer ilabelsort, integer ilabelpagebreak, s_flight strflightinfo, ref uo_label_return strret[], ref str_bitmaps strbmp[]);// ------------------------------------------------------------------------------------
// Erstellen der Labels
//
// Parameter:	dwdata 				dw_1 aus ou_loading_list
// 				iPrinterType		1 = Thermodrucker via Druckertreiber
//											2 = Normaler Drucker (auf Bogen)
//					sFlgnr				Flugnummer (Airline + Flugnummer + Suffix)
//					dDepDate				Abflugdatum
//					sDepTime				Abflugzeit
// 				strRet				Struktur vom Typ str_label_return
//											wird per Referenz $$HEX1$$fc00$$ENDHEX$$bergeben und gef$$HEX1$$fc00$$ENDHEX$$llt
//					ilabelsort			1 = Sortiere die Label nach Bereichen
//											2 = Sortiere die Label nach Galley
//
//
//	R$$HEX1$$fc00$$ENDHEX$$ckgabe:	 0		alle prima
//					-1		keine Daten in dwdata
//					-2		kein g$$HEX1$$fc00$$ENDHEX$$ltiges Label gefunden
//					-3		ung$$HEX1$$fc00$$ENDHEX$$ltiger Wert in iPrinterType
//					-4		Fehler beim ColumnObject
//					-5		Fehler beim LineObject
//					-6		Fehler beim RectangleObject
//					-7		Fehler beim TextObject
//					-8		Fehler beim BitmapObject
//					-9		Fehler im dsMaster kein oder mehr als ein Datensatz
//					-10	Fehler im dsObjects kein Datensatz
//					-11	Label hat keine Columns
// 				-12	Fehler beim erzeugen der Bitmaps
// 				-13	
// 				-14	Fehler keine Daten in SYS_LABEL_COLUMNS
// ------------------------------------------------------------------------------------
Datetime dtValid, dtSearch
Long lLabelType, lLastLabelType
Long lRows
Long lInsert
Long lFound
Blob bBlob
String sArea, sFilter, sWorkstation
integer iRet
long	lPackinglistDetail
long	lPackinglistIndexKey
long	lPackinglistDetailKey
s_packinglist_detail	sLabelPLTexte
integer	i
Long lStart, lEnde
string ls_barcode_file, ls_barcode



// ------------------------------------------------------------------------------------
// Mal schaun, ob $$HEX1$$fc00$$ENDHEX$$berhaupt Daten drin sind
// ------------------------------------------------------------------------------------
if dwdata.RowCount() = 0 then
	of_log("Error -1, no data found, RowCount() on dwData = 0 ")
	return -1
end if
// ------------------------------------------------------------------------------------
// Retrieve der Produktgruppen
// ------------------------------------------------------------------------------------	
dsProductGroup.Retrieve("002")

strFlight = strflightinfo

// ------------------------------------------------------------------------------------
// 
// ------------------------------------------------------------------------------------
lLastLabelType = -1
lLastLabelType		= 0
lLabelType			= 0

// -----------------------------------------
// Columndefinitionen aus SYS_LABEL_COLUMNS
// -----------------------------------------
dsColumns.dataobject = "dw_label_print_prod_columns"
dsColumns.SetTransObject(sqlca)
if dsColumns.Retrieve() <= 0 then
	of_log("Error -14, no data from SYS_LABEL_COLUMNS_PROD")
	return -1
end if
// -----------------------------------------
// Label bauen
// -----------------------------------------
// f_print_datastore(dwdata)

lLabelType = dwData.GetItemNumber(1, "nlabel_type_key")
isBelly 	= of_isbelly(dwData.GetItemNumber(1, "nbelly"))
iRet = of_build_label(Date(strFlightInfo.dtDepartureDate), lLabelType, iPrinterType)
lLastLabelType = lLabelType

if iRet <> 0 then
	return iRet
end if

// -----------------------------------------
// Bilder blobben
// -----------------------------------------
iRet = of_create_pictures(strBMP)
if iRet <> 0 then
	return iRet
end if
// -----------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r den Spooler noch nen Namen geben
// -----------------------------------------
dsLayout.Modify("datawindow.print.documentname = 'Bulklabel'")
sArea		= dwData.GetItemString(1, "cworkstation")

// -----------------------------------------
// dw_loadinglist_result "zerlegen"
// -----------------------------------------
of_analyse(dwData)

lStart = CPU()

For lRows = 1 to dwData.RowCount()
	
	// --------------------------------------------------------------------------------------------------------------------
	// Nachschaun, on sich der Labeltyp oder Belly ge$$HEX1$$e400$$ENDHEX$$ndert hat
	// dann ggf. neues Layout (kompl. Reset auf dsLayout und neu Zeichnen)
	// --------------------------------------------------------------------------------------------------------------------
	//
	// Was macht das folgende IF ???
	//
	// 1. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Sortierung nach Galley = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + iLabelSort = 2
	//
	// 2. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Area unver$$HEX1$$e400$$ENDHEX$$ndert + Sortierung nach Area = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + sArea = dwDat..  + iLabelSort = 1
	//
	// 3. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Area VER$$HEX1$$c400$$ENDHEX$$NDERT + Sortierung nach Area + Areas fortlaufend = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + sArea <> dwDat.+ iLabelSort = 1       + iLabelPageBreak = 0
	//
	// --------------------------------------------------------------------------------------------------------------------
		
	if (	lLabelType = dwData.GetItemNumber(lRows, "nlabel_type_key") and &
			of_isbelly(dwData.GetItemNumber(lRows, "nbelly")) = isBelly and &
			iLabelSort = 2 &
		) 	&
		or &
		(	lLabelType = dwData.GetItemNumber(lRows, "nlabel_type_key") and &
			of_isbelly(dwData.GetItemNumber(lRows, "nbelly")) = isBelly and &
			sArea = dwData.GetItemString(lRows, "cworkstation") and &
			iLabelSort = 1 &
		) &
		or &
		(	lLabelType = dwData.GetItemNumber(lRows, "nlabel_type_key") and &
			of_isbelly(dwData.GetItemNumber(lRows, "nbelly")) = isBelly and &
			dwData.GetItemString(lRows, "cworkstation") <> sArea and &
			iLabelSort = 1 and &
			iLabelPageBreak = 0 &
		) &
		then  

//	if (	lLabelType = dwData.GetItemNumber(lRows, "nlabel_type_key") and &
//			of_isbelly(dwData.GetItemNumber(lRows, "nbelly")) = isBelly &
//		) 	then  

		// -------------------------------------------------
		// Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert, dann Daten reinpacken
		// -------------------------------------------------
		lInsert = dsLayout.InsertRow(0)	
		
		dsLayout.SetItem(lInsert, "nobject_type", lInsert)
		dsLayout.SetItem(lInsert, "nbelly", of_checknull(dwData.GetItemNumber(lRows, "nbelly")))
		dsLayout.SetItem(lInsert, "carea", of_checknull(dwData.GetItemString(lRows, "carea")))
		dsLayout.SetItem(lInsert, "cworkstation", of_checknull(dwData.GetItemString(lRows, "clabel_workstation")))
		
		if this.ihasbarcode = 1 then
			
			ls_barcode_file =  f_gettemppath() + "cbase_barcode_" + string(lRows, "000") + "_" + string(cpu()) + ".bmp"
			dsLayout.SetItem(lInsert, "cfilename", ls_barcode_file)
			
			ls_barcode = of_create_barcode_information_prod_label(dwData, lRows)	
	
			this.of_create_barcode(37, ls_barcode_file, ls_barcode, 120,120, 75)
						
		end if
		
		of_fill_prod_columns(lRows, &
							 lInsert, &
							 dwData, &
							 strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber, &
							 Date(strFlightInfo.dtDepartureDate), &
							 strFlightInfo.cDepartureTime, &
							 strFlightInfo.sDestination, &
							 strFlightInfo.sOwner + " " + strFlightInfo.sActype )

		
//		Messagebox("if     ", String(lLabelType) + " = " + string(isbelly) + " - " + sArea)

	else
		
				
//		Messagebox("else     ", String(lLabelType) + " = " + string(isbelly) + " - " + sArea)

		
		// -------------------------------------------------------------------
		// Labeltyp oder Belly hat sich ge$$HEX1$$e400$$ENDHEX$$ndert, den Datastore (dsLayout)
		// in das UserObject packen und den neuen Labeltyp bauen
		// -------------------------------------------------------------------
		iRet = dsLayout.GetFullState(bBlob)
		
		if iRet = -1 then
			return -13
		end if
		
		iRetCount ++		
		strRet[iRetCount] = Create uo_label_return
		strRet[iRetCount].llabeltype = lLabelType
		strRet[iRetCount].bLabel = bBlob					// alle Label eines Labeltyps

		if isBelly then
			strRet[iRetCount].sLabel = sLabel + " (Belly)" 
		else
			strRet[iRetCount].sLabel = sLabel
		end if
		
		strRet[iRetCount].sLabelComment = sArea
		strRet[iRetCount].sWorkstation = sWorkstation
		strRet[iRetCount].isBelly = isBelly
		strRet[iRetCount].iLabelSort = iLabelSort
		strRet[iRetCount].iLabelPageBreak = iLabelPageBreak		
		strRet[iRetCount].sGeneratedForPrinter = this.sGeneratedForPrinter
		// -----------------------------------------------------------
		// Neuen Label-Typ zeichnen, wenn er sich ge$$HEX1$$e400$$ENDHEX$$ndert hat
		// -----------------------------------------------------------
		lLabelType 	= dwData.GetItemNumber(lRows, "nlabel_type_key") 
		isBelly 		= of_isbelly(dwData.GetItemNumber(lRows, "nbelly"))
		
		iRet = of_build_label(date(strFlightInfo.dtDepartureDate), lLabelType, iPrinterType)
		
		if iRet <> 0 then
			return iRet
		end if
		
		lLastLabelType = lLabelType 
		
		lInsert = dsLayout.InsertRow(0)	
		dsLayout.SetItem(lInsert, "nobject_type", lInsert)
		dsLayout.SetItem(lInsert, "nbelly", of_checknull(dwData.GetItemNumber(lRows, "nbelly")))
		dsLayout.SetItem(lInsert, "carea", of_checknull(dwData.GetItemString(lRows, "carea")))
		dsLayout.SetItem(lInsert, "cworkstation", of_checknull(dwData.GetItemString(lRows, "clabel_workstation")))
		
		if this.ihasbarcode = 1 then
			
			ls_barcode_file =  f_gettemppath() + "cbase_barcode_" + string(lRows, "000") + "_" + string(cpu()) + ".bmp"
			dsLayout.SetItem(lInsert, "cfilename", ls_barcode_file)
			//MB: 13.11.2012 Inhalt f$$HEX1$$fc00$$ENDHEX$$r Fluglabel St$$HEX1$$fc00$$ENDHEX$$ckliste	Flugdatum	Flugschl$$HEX1$$fc00$$ENDHEX$$ssel	Stauort	Menge (Treenzeichen TAB):
	
			
			ls_barcode = of_create_barcode_information_prod_label(dwData, lRows)	
			
			this.of_create_barcode(37, ls_barcode_file, ls_barcode, 120,120, 75)
						
		end if
		
		of_fill_prod_columns(lRows, &
							 lInsert, &
							 dwData, &
							 strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber, &
							 Date(strFlightInfo.dtDepartureDate), &
							 strFlightInfo.cDepartureTime, &
							 strFlightInfo.sDestination, &
							 strFlightInfo.sOwner + " " + strFlightInfo.sActype )	
		
	end if

	sArea = dwData.GetItemString(lRows, "cworkstation")
	sWorkstation = dwData.GetItemString(lRows, "cworkstation_long")
	
Next

iRet = dsLayout.GetFullState(bBlob)
if iRet = -1 then
	return -13
end if
// -----------------------------------------------------------
// R$$HEX1$$fc00$$ENDHEX$$ckgabe: Array von uo_label_return - Objekten
// -----------------------------------------------------------
iRetCount ++				
strRet[iRetCount] = Create uo_label_return
strRet[iRetCount].bLabel = bBlob
strRet[iRetCount].lLabeltype = lLabelType

if isBelly then
	strRet[iRetCount].sLabel = sLabel + " (Belly)" 
else
	strRet[iRetCount].sLabel = sLabel
end if

strRet[iRetCount].sLabelComment = sArea
strRet[iRetCount].sWorkstation = sWorkstation
strRet[iRetCount].isBelly = isBelly
strRet[iRetCount].iLabelSort = iLabelSort
strRet[iRetCount].iLabelPageBreak = iLabelPageBreak
strRet[iRetCount].sGeneratedForPrinter = this.sGeneratedForPrinter

//For i = 1 to Upperbound(strRet)
//	Messagebox("" , strRet[i].sLabel + "~r~r" + string(strRet[i].isBelly = isBelly) + "~r~r" + strRet[i].sGeneratedForPrinter)
//Next

//For i = 1 to Upperbound(sLocalPrinters)
//	Messagebox("sLocalPrinters" , sLocalPrinters[i])
//Next
//
//For i = 1 to Upperbound(sLocalBellyPrinters)
//	Messagebox("sLocalBellyPrinters" , sLocalBellyPrinters[i])
//Next

lEnde = CPU()

return 0
end function

public function string of_wrap (string stext, integer inowraplen, integer iwrapstartpos, integer iwrapendpos);integer	iTextLen, i, iPos
string	sDebug

If isnull(sText) or len(trim(stext)) <= 0 Then return " "


//25.04.2013 MB: Parameter jetzt aus cen_setup
inowraplen = this.iinowraplen
iwrapstartpos = this.iiwrapstartpos
iwrapendpos = this.iiwrapendpos

// ------------------------------------------
// Kein Umbruch <= iWrapLen
// ------------------------------------------
iTextlen = len(sText)
If iTextLen <= iNoWrapLen Then
	sText = sText
	return sText
End if	

iPos = Pos(sText," ",iwrapstartpos)
If iPos > 0 and (iTextlen - iPos) >= iWrapEndPos Then
	sText = mid(sText,1,iPos - 1) 	+ "~n" + mid(sText,iPos+1)
	return sText
End if

iPos = Pos(sText,"/",iwrapstartpos)
If iPos > 0 and (iTextlen - iPos) >= iWrapEndPos Then
	sText = mid(sText,1,iPos) 	+ "~n" + mid(sText,iPos+1)
	return sText
End if

iPos = Pos(sText,"-",iwrapstartpos)
If iPos > 0 and (iTextlen - iPos) >= iWrapEndPos Then
	sText = mid(sText,1,iPos) 	+ "~n" + mid(sText,iPos +1)
	return sText
End if

return sText
end function

public function integer of_label (datastore dwdata, integer iprintertype, integer ilabelsort, integer ilabelpagebreak, s_flight strflightinfo, ref str_bitmaps strbmp[]);
// ------------------------------------------------------------------------------------
// 30.11.05
// 
// N E U E  of_label Funktion f$$HEX1$$fc00$$ENDHEX$$r Beladevorschau
// 
// ------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------
// Erstellen der Labels
//
// Parameter:	dwdata 				dw_1 aus uo_loading_list
// 					iPrinterType			1 = Thermodrucker via Druckertreiber
//											2 = Normaler Drucker (auf Bogen)
//					ilabelsort				1 = Sortiere die Label nach Bereichen
//											2 = Sortiere die Label nach Galley
//											3 = Sortiere die Label nach Labeltyp innerhalb nach Bereichen
//					ilabelpagebreak	0 = Seitenumbruch aus, 1 = Seitenumbruch an
//					strflightinfo 			struktur mit flugdaten
//			ref		strbmp 				struktur mit und f$$HEX1$$fc00$$ENDHEX$$r BMPs
//
//					sFlgnr				Flugnummer (Airline + Flugnummer + Suffix)
//					dDepDate				Abflugdatum
//					sDepTime				Abflugzeit
// 				this.uoResult				Struktur vom Typ str_label_return
//											wird per Referenz $$HEX1$$fc00$$ENDHEX$$bergeben und gef$$HEX1$$fc00$$ENDHEX$$llt
//
//
//	R$$HEX1$$fc00$$ENDHEX$$ckgabe:	 0		alle prima
//					-1		keine Daten in dwdata
//					-2		kein g$$HEX1$$fc00$$ENDHEX$$ltiges Label gefunden
//					-3		ung$$HEX1$$fc00$$ENDHEX$$ltiger Wert in iPrinterType
//					-4		Fehler beim ColumnObject
//					-5		Fehler beim LineObject
//					-6		Fehler beim RectangleObject
//					-7		Fehler beim TextObject
//					-8		Fehler beim BitmapObject
//					-9		Fehler im dsMaster kein oder mehr als ein Datensatz
//					-10	Fehler im dsObjects kein Datensatz
//					-11	Label hat keine Columns
// 					-12	Fehler beim erzeugen der Bitmaps
// 					-13	
// 					-14	Fehler keine Daten in SYS_LABEL_COLUMNS
// ------------------------------------------------------------------------------------
// Aenderungshistorie:
// Version 		Wer				Wann				Was und warum
// 1.0 			??? 				xx.xx.xxxx		Erstellung
// 1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel 		30.05.2012		bestbefore erg$$HEX1$$e400$$ENDHEX$$nzt (bei der $$HEX1$$fc00$$ENDHEX$$bergabe an of_fill_column)
// 1.2 			M.N$$HEX1$$fc00$$ENDHEX$$ndel 		05.06.2012		RTN-column rein (analog pldetail behandeln)
// 1.3 			M.N$$HEX1$$fc00$$ENDHEX$$ndel 		08.06.2012		pldetail/pldetail_explosion/rtn in schon vorhandene doppelte erst einf$$HEX1$$fc00$$ENDHEX$$llen, bevor kopiert wird
// 1.4 			M.N$$HEX1$$fc00$$ENDHEX$$ndel 		04.07.2012		iTextRowsInObject abgerundet
// 1.5			M.Barfknecht	29.08.2012		EQ-column rein (analog RTN)
// 1.6         K.F$$HEX1$$f600$$ENDHEX$$rster      26.09.2012     KPI Messung f$$HEX1$$fc00$$ENDHEX$$r Michael
// 1.7         D.Bunk         15.11.2012     Alte PBAcorbat Funktionen gegen neue getauscht
//	1.8         Oliver H$$HEX1$$f600$$ENDHEX$$fer   27.07.2017     request #1455 CBASE-UK-CR-2016-022 Berechnung "Label X of Y" f$$HEX1$$fc00$$ENDHEX$$r Flight Labels "as needed"
//	1.9         Oliver H$$HEX1$$f600$$ENDHEX$$fer   15.01.2018     Issue "Label Fehler"
//	2.0         Oliver H$$HEX1$$f600$$ENDHEX$$fer   11.04.2019     Issue #4823 Label - Sort of Distributed Components
//	2.1         Oliver H$$HEX1$$f600$$ENDHEX$$fer   11.06.2019     Issue #5076 VPS Flightlabel Barcode anstelle des normalen Barcodes (falls Schalter gesetzt)
//	2.2         Oliver H$$HEX1$$f600$$ENDHEX$$fer   17.06.2019     Issue #5076 VPS Flightlabel Barcode anstelle des normalen Barcodes (falls Schalter gesetzt) an anderer Stelle 
//	2.3         Oliver H$$HEX1$$f600$$ENDHEX$$fer   15.08.2022     #6466 Barcode switch is checked using flight CSC (before: s_app.swerk)
// 
// hilfsvariable
string 	ls_Client = "002" 		// bisher hier fest drin f$$HEX1$$fc00$$ENDHEX$$r select productgruppen

// hilfsvariable inhalte holen
Long ll_FoundPLDetail, ll_FoundRTN,ll_FoundEQ
Long	ll_PackinglistIndexKey, ll_PackinglistDetailKey
s_packinglist_detail	lstr_LabelPLTexte, lstr_LabelPLRTN, lstr_LabelEmpty,lstr_LabelPLEQ
Boolean lb_NotExploded = true

String ls_temp
Long ll_LabelCountDist, ll_LabelCountRows, ll_LabelCountMax,ll_labelCountEX
Long ll_InsertRow

Datetime dtValid, dtSearch
Long lLabelType, lLastLabelType
Long lRows
Long lInsert

Blob bBlob
String sArea, sFilter
integer iRet
String	ls_Find
long	lPackinglistDetail

integer	i
Long 		lStart, lEnde
String	sWorkStation
String	ls_Column
Integer	li_Succ
Long		ll_Ramp_Box_Mode
String	ls_Ramp_Box_2

Long 	ll_Ret
String lsFilenameForTrace01, lsFilenameForTrace02
string	ls_barcode_file, ls_barcode 
long ll_width, ll_height
DateTime	ldt_help
String		ls_New_Counter
Long			ll_Counter, ll_Number_Of_Group_Members
String		ls_Group_Crit, ls_Current_Crit
Long			ll_Found
String		ls_CSC
Long			ll_Temp_Belly
String		ls_Debug
Boolean		lb_NO_PPM_CODE
Boolean		lb_First
Long			ll_Key, ll_ST_Key , ll_PL_Key
//Long			ll_PPM_Key_Array[]	
Long			ll_Prt_Grp
String		ls_Value
String		ls_cFlight_key 

Boolean	lb_Barcode_without_Newline
Boolean	lb_Barcode_without_cFlightkey

DataStore lds_Prt_Grp

lds_Prt_Grp = CREATE DataStore
lds_Prt_Grp.DataObject = "dw_labelgroups_detail_wide"
lds_Prt_Grp.SetTransObject(SQLCA)
ll_Prt_Grp = lds_Prt_Grp.Retrieve ( il_Printing_Group , datetime(idt_Departure))

//If f_unitprofileString("PPMBARCODE4GROUP", String(il_Printing_Group) , "0",  ls_CSC ) = "1" Then
//	lb_NO_PPM_CODE = FALSE 
//	of_log("il_Printing_Group "+string(il_Printing_Group)+"PPMBARCODE4GROUP = FALSE " + ls_CSC)
//Else
//	lb_NO_PPM_CODE = TRUE
//	of_log("il_Printing_Group "+string(il_Printing_Group)+"PPMBARCODE4GROUP = TRUE " + ls_CSC)
//End If
	

// --------------------------------------------------
// trace-schalter
// sonderfall hintergrund-files: 
// 	- pr$$HEX1$$e400$$ENDHEX$$fix setzen, damit sie nicht aufger$$HEX1$$e400$$ENDHEX$$umt werden beim abmelden
// --------------------------------------------------
if handle(getapplication()) = 0 then
	this.ib_Trace = true
else
	this.ib_Trace = false
end if

// dwdata.saveas("c:\temp\dwdata.xls", Excel5!, true)
// f_print_datastore(dwdata)
// ------------------------------------------------------------------------------------
// Mal schaun, ob $$HEX1$$fc00$$ENDHEX$$berhaupt Daten drin sind
// ------------------------------------------------------------------------------------
if dwdata.RowCount() = 0 then
	of_log("Error -1, no data found, RowCount() on dwData = 0 ")
	return -1
end if

if this.ib_Trace then
	lsFilenameForTrace01 = f_gettemppath() + "LabelOther01-" + String(Rand(32767)) + String(now(), "hhmmss")
	lsFilenameForTrace01 = f_valid_filename(lsFilenameForTrace01)	
	lsFilenameForTrace02 = f_gettemppath() + "LabelOther02-" + String(Rand(32767)) + String(now(), "hhmmss")
	lsFilenameForTrace02 = f_valid_filename(lsFilenameForTrace02)	
//
//	ll_Ret = dwdata.SaveAs(lsFilenameForTrace01 + ".xls", Excel!, True)
end if

// ------------------------------------------------------------------------------------
// Alle wegfiltern, die nicht gedruckt werden sollen
// ------------------------------------------------------------------------------------
sFilter = dwData.Describe("datawindow.table.filter")

if sFilter = "?" then
	sFilter = ""
else
	sFilter += " and "
end if

dwData.SetFilter(sFilter + "nprint = 1")
dwData.Filter()

// f_print_datastore(dwdata)

if dwdata.RowCount() = 0 then
	of_log("Error -1, no data found after filtering, RowCount() on dwData = 0 ")
	return -1
end if

// --------------------------------------------------------------------------------------------------------------------
// 27.07.2017 request #1455 CBASE-UK-CR-2016-022 Berechnung "Label X of Y" f$$HEX1$$fc00$$ENDHEX$$r Flight Labels "as needed"
//"Label X of Y " f$$HEX1$$fc00$$ENDHEX$$r "as needed" einstellen
// --------------------------------------------------------------------------------------------------------------------
// 12.07.18 Issue Label Z$$HEX1$$e400$$ENDHEX$$hler... 
//iRet = dwData.SetSort("cen_loadinglists_nbelly_container,cen_galley_cgalley,cen_stowage_cstowage,cen_stowage_cplace,cen_loadinglists_cclass,cen_packinglist_index_cpackinglist,cen_packinglists_cunit")

// 11.04.2019 Issue #4823 Label - Sort of Distributed Components
iRet = dwData.SetSort("cen_loadinglists_nbelly_container,cen_galley_cgalley,cen_stowage_cstowage,cen_stowage_cplace,cen_loadinglists_cclass,cen_packinglist_index_cpackinglist,cen_packinglists_cunit,pldetail_label_counter")

iRet = dwData.Sort()
//dwData.saveas("c:\temp\cbase\dwdataaftersort.xls",excel5!,true)

// --------------------------------------------------------------------------------------------------------------------
//// 27.07.2017 request #1455 CBASE-UK-CR-2016-022 Berechnung "Label X of Y" f$$HEX1$$fc00$$ENDHEX$$r Flight Labels "as needed"
////"Label X of Y " f$$HEX1$$fc00$$ENDHEX$$r "as needed" einstellen
//// --------------------------------------------------------------------------------------------------------------------
//// 12.07.18 Issue Label Z$$HEX1$$e400$$ENDHEX$$hler... 
//iRet = dwData.SetSort("cen_loadinglists_nbelly_container,cen_galley_cgalley,cen_stowage_cstowage,cen_stowage_cplace,cen_loadinglists_cclass,cen_packinglist_index_cpackinglist,cen_packinglists_cunit,pldetail_label_counter")
////iRet = dwData.SetSort("cen_loadinglists_nbelly_container,cen_galley_cgalley,cen_stowage_cstowage,cen_stowage_cplace,cen_loadinglists_cclass,cen_packinglist_index_cpackinglist,cen_packinglists_cunit")
//iRet = dwData.Sort()
////dwData.saveas("c:\temp\cbase\dwdataaftersort.xls",excel5!,true)


ls_Value = f_mandant_profilestring(sqlca, s_app.smandant, "CartDiagramBarcode", "IncludeFlightKey", "1")
IF ls_Value = "0" THEN
	lb_Barcode_without_cFlightkey = TRUE
END IF
ls_Value = f_mandant_profilestring(sqlca, s_app.smandant, "CartDiagramBarcode", "IncludeNewline", "1")
IF ls_Value = "0" THEN
	lb_Barcode_without_Newline = TRUE
END IF


// 20220824AA0038 MIALHR
ls_cFlight_key = String(strflightinfo.dtdeparturedate,"yyyymmdd")
ls_cFlight_key += strflightinfo.sairline
ls_cFlight_key += Right ("000" + strflightinfo.sflightnumber, 4)
IF Trim(strflightinfo.ssuffix) = "" THEN strflightinfo.ssuffix = " "
ls_cFlight_key += strflightinfo.ssuffix
ls_cFlight_key += strflightinfo.sdeparture
ls_cFlight_key += strflightinfo.sdestination

For I = 1 to dwData.RowCount()
	// wenn nmodified > 0
	if dwData.GetItemNumber(I, "nmodified") = 0 then
		ll_Counter = 0 
		ll_Number_Of_Group_Members = 0
		continue
	End If
	//ls_Current_Crit = galley usw.
	ls_Current_Crit  = dwData.GetItemString(I, "cen_galley_cgalley") + "_"
	ls_Current_Crit += dwData.GetItemString(I, "cen_stowage_cstowage") + "_"
	ls_Current_Crit += dwData.GetItemString(I, "cen_stowage_cplace") + "_"
	ls_Current_Crit += dwData.GetItemString(I, "cen_packinglists_cunit") + "_"
	ls_Current_Crit += dwData.GetItemString(I, "cen_loadinglists_cclass") + "_"
	ls_Current_Crit += dwData.GetItemString(I, "cen_packinglist_index_cpackinglist")
	ll_Temp_Belly = dwData.GetItemNumber(i, "cen_loadinglists_nbelly_container")
	If isnull(ll_Temp_Belly) OR ll_Temp_Belly = 0 Then
		//ls_Current_Crit += " AND (isnull(cen_loadinglists_nbelly_container) or cen_loadinglists_nbelly_container=0) "
		ls_Current_Crit += "_B0"
	Elseif ll_Temp_Belly > 0 Then
		//ls_Current_Crit += " AND cen_loadinglists_nbelly_container=1 "
		ls_Current_Crit += "_B" + String(ll_Temp_Belly)
	End If


	If ls_Group_Crit <> ls_Current_Crit then
		ll_Counter = 0 
		ll_Number_Of_Group_Members=0
		ls_Group_Crit = ls_Current_Crit
	End If
	
	// wenn gleiche source row (Stauort + PL + .....)	
	ll_Counter++
	
	if ll_Counter = 1 then
		//ll_Compute_Group = z$$HEX1$$e400$$ENDHEX$$hle anzahl zusammengeh$$HEX1$$f600$$ENDHEX$$render zeilen				
		ll_Number_Of_Group_Members++
		// Find next row
		ls_Find  = "cen_galley_cgalley='" +                 dwData.GetItemString(I, "cen_galley_cgalley") + "' AND "
		ls_Find += "cen_stowage_cstowage='" +               dwData.GetItemString(I, "cen_stowage_cstowage") + "' AND "
		ls_Find += "cen_stowage_cplace='" +                 dwData.GetItemString(I, "cen_stowage_cplace") + "' AND "
		ls_Find += "cen_packinglists_cunit='" +             dwData.GetItemString(I, "cen_packinglists_cunit") + "' AND "
		ls_Find += "cen_loadinglists_cclass='" +            dwData.GetItemString(I, "cen_loadinglists_cclass") + "' AND "
		ls_Find += "cen_packinglist_index_cpackinglist='" + dwData.GetItemString(I, "cen_packinglist_index_cpackinglist") + "' "
		ls_Find += " AND nmodified>0 "

		If dwData.GetItemString(I, "cen_packinglist_index_cpackinglist") = "E5050962" then
			ll_Temp_Belly = ll_Temp_Belly
		End If
		
		ll_Temp_Belly = dwData.GetItemNumber(i, "cen_loadinglists_nbelly_container")
		If isnull(ll_Temp_Belly) OR ll_Temp_Belly = 0 Then
			ls_Find += " AND (isnull(cen_loadinglists_nbelly_container) or cen_loadinglists_nbelly_container=0) "
		Elseif ll_Temp_Belly > 0 Then
			ls_Find += " AND cen_loadinglists_nbelly_container=" + String(ll_Temp_Belly)
		End If
		
		// dwData.GetItemNumber(lRows, "nbelly")

		//ll_Found = dwData.Find(ls_Find, I + 1, dwData.RowCount())
		
		If I < dwData.RowCount() Then
			ll_Found = dwData.Find(ls_Find, I + 1, dwData.RowCount())
		Else
			// 15.01.2018 - Issue "Label Fehler"
			ll_Found = 0
		End If
				
		Do While ll_Found > 0 
			ll_Number_Of_Group_Members++
			If ll_Found < dwData.RowCount() Then
				ll_Found = dwData.Find(ls_Find, ll_Found + 1 , dwData.RowCount())
			Else
				ll_Found = 0
			End If
		Loop
	End If
	
	ls_New_Counter = String(ll_Counter) + " of " + String(ll_Number_Of_Group_Members)
//	If ll_Number_Of_Group_Members > 9 then
//		ls_New_Counter = String(ll_Counter, "00") + " of " + String(ll_Number_Of_Group_Members)
//	End If
	dwData.SetItem(i, "pldetail_label_counter", ls_New_Counter)
Next

//if this.ib_Trace then
//	ll_Ret = dwdata.SaveAs(lsFilenameForTrace02 + ".xls", Excel5!, True)
//end if


// ------------------------------------------------------------------------------------
// Retrieve der Produktgruppen
// ------------------------------------------------------------------------------------	
dsProductGroup.Retrieve(ls_Client)

strFlight = strflightinfo

lStart = CPU()
this.ihidebarcode = Integer(f_mandant_profilestring(sqlca, s_app.sMandant, "LabelHideBarcode", "Default", "0"))

ivpsbarcode= Integer(f_mandant_profilestring(sqlca, s_app.sMandant, "LabelVPSBarcode", "Default", "0"))

//LabelVPSBarcode

// ------------------------------------------------------------------------------------
// Packing-List Detail in Loadinglist Result einarbeiten
// ------------------------------------------------------------------------------------
lLastLabelType = -1
For lRows = dwData.RowCount()	to 1 Step -1
	// pro st$$HEX1$$fc00$$ENDHEX$$ckliste zur$$HEX1$$fc00$$ENDHEX$$cksetzen
	lb_NotExploded = true

	sRampBox = dwData.GetItemString(lRows, "crampbox")

	// ------------------------------------------------------------------------------------
	// Neue Spalte "Ramp Box Doc Departure" (crampbox2)
	// ------------------------------------------------------------------------------------
	ll_Ramp_Box_Mode = dwData.GetItemNumber(lRows, "nramp_box_mode")
	ls_Ramp_Box_2 = sRampBox
	if ll_Ramp_Box_Mode = 1 Then
		ls_Ramp_Box_2 = sbox_from
	elseif ll_Ramp_Box_Mode = 2 Then
		ls_Ramp_Box_2 = sbox_to
	Else
		// Alte Methode, jedoch ohne f$$HEX1$$fc00$$ENDHEX$$hrendes "B: "
		if f_check_null(sbox_from) <> "" or f_check_null(sbox_to) <> "" then
			if sbox_from = sbox_to then
				ls_Ramp_Box_2 = sbox_from
			else
				ls_Ramp_Box_2 = sbox_from + " - " + sbox_to
			end if
		end if	
	End If
	li_succ = dwData.SetItem(lRows, "crampbox2", ls_Ramp_Box_2 )
	
	ls_Debug = dwData.GetItemString(lRows, "cen_packinglist_index_cpackinglist")
	
	if ls_Debug = "AVFF213" then
		ls_Debug=ls_Debug	
	end if
	
	// -------------------------------------------------------
	// Pr$$HEX1$$fc00$$ENDHEX$$fung des Labeltypes: gruppenwechsel ?
	// -------------------------------------------------------
	lLabelType = dwData.GetItemNumber(lRows,"cen_packinglists_nlabel_type_key")
	dtValid = of_find_valid_label(lLabelType, Datetime(Date(strFlightInfo.dtDepartureDate),Time("00:00:00")))
	If isnull(dtValid)  then
		continue
	End if
	If lLabelType <> lLastLabelType Then
		dsObjects.Retrieve(lLabelType, dtValid)
		lLastLabelType = lLabelType
		
		iRet = of_create_pictures(strBMP)
		if iRet <> 0 then
			return iRet
		end if
		
		
	End if	
	
	// -------------------------------------------------------
	// Pr$$HEX1$$fc00$$ENDHEX$$fung des Labeltypes, ob pldetail verwendet wurde.
	// dann werden die daten dazu geholt
	// bei explosion wird immer beides bedient!!
	// f$$HEX1$$fc00$$ENDHEX$$r die berechnung der labelanzahl wird auch font etc. gebraucht
	// -------------------------------------------------------
	// ACHTUNG: 
	// wenn COL_DISTRIBUTED_COMP drin ist, dann k$$HEX1$$f600$$ENDHEX$$nnen schon duplizierte s$$HEX1$$e400$$ENDHEX$$tze da sein
	// diese s$$HEX1$$e400$$ENDHEX$$tze sind mit nduplicated = 1 gekennzeichnet und sollten eigentlich nicht jeder separat gef$$HEX1$$fc00$$ENDHEX$$llt werden...
	// -------------------------------------------------------
	
	// vorsichtshalber schon mal hier, damit es nicht vergessen wird
	dwData.SetItem(lRows,COL_PLDETAIL_TEXT," ")
	dwData.SetItem(lRows,COL_PLDETAIL_EXPL," ")
	dwData.SetItem(lRows,COL_RTN_COMP," ")
	dwData.SetItem(lRows,COL_EQ_COMP," ")
	// das klappt aber nur begrenzt, da oftmals l$$HEX1$$e400$$ENDHEX$$ngere leerstrings drin sind ?!
	if of_checknull(dwData.GetItemString(lRows,"pldetail_label_counter")) = "" then
		dwData.SetItem(lRows,"pldetail_label_counter","1 of 1")			
	end if
	
	// -------------------------------------------------------
	// unter der voraussetzung, dass alles nach labeltyp und dann stauort sortiert ist:
	// z$$HEX1$$e400$$ENDHEX$$hlen, wie viele duplizierte label da sind zu einem kopf
	// diese updaten, falls erneut dupliziert werden muss
	// -------------------------------------------------------
	// sind label schon dupliziert ? dann anzahl rauslesen
	if dwData.GetItemNumber(lRows,"nduplicated") = 1 then
		ll_LabelCountRows++
		ls_temp = dwData.GetItemString(lRows,"pldetail_label_counter")
		ll_LabelCountDist = long(right(ls_temp, len(ls_temp) - LastPos(ls_temp, " ")))
//		MessageBox(ls_temp, string(LastPos(ls_temp, " ")) + "-" + string(len(ls_temp)) + "-> " +  string(ll_LabelCountDist))
		continue
	Else
		ls_temp = dwData.GetItemString(lRows,"pldetail_label_counter")
		If trim(ls_Temp) = "" Then
			ll_LabelCountDist = 1
		else
			ll_LabelCountDist = long(right(ls_temp, len(ls_temp) - LastPos(ls_temp, " ")))
		end if		
	end if
	
	ll_LabelCountRows++
		
	ll_FoundPLDetail = dsObjects.Find("ccolumn = '" + COL_PLDETAIL_TEXT + "' OR ccolumn = '" + COL_PLDETAIL_EXPL + "' ", 1, dsObjects.RowCount())
	ll_FoundRTN = dsObjects.Find("ccolumn = '" + COL_RTN_COMP + "'", 1, dsObjects.RowCount())
	ll_FoundEQ = dsObjects.Find("ccolumn = '" + COL_EQ_COMP + "'", 1, dsObjects.RowCount())
	
	// egal, was da ist: st$$HEX1$$fc00$$ENDHEX$$ckliste bleibt gleich f$$HEX1$$fc00$$ENDHEX$$r alle
	if ll_FoundPLDetail > 0 or ll_FoundRTN > 0 or ll_FoundEQ > 0 then
		lstr_LabelPLTexte = lstr_LabelEmpty
		lstr_LabelPLRTN = lstr_LabelEmpty
		lstr_LabelPLEQ = lstr_LabelEmpty
		ll_PackinglistIndexKey = dwData.GetItemNumber(lRows,"cen_packinglist_index_npackinglist_index_key")
		ll_PackinglistDetailKey	= dwData.GetItemNumber(lRows,"cen_packinglists_npackinglist_detail_key")
	
		// zuerst details
		if ll_FoundPLDetail > 0 then
			ls_Column				= dsObjects.Getitemstring(ll_FoundPLDetail,"ccolumn")
			sPLFontname			= dsObjects.Getitemstring(ll_FoundPLDetail,"cfontname")
			iPLFontweight			= dsObjects.Getitemnumber(ll_FoundPLDetail,"nfontweight")
			iPLFontsize				= dsObjects.Getitemnumber(ll_FoundPLDetail,"nfontsize") * -1
			iPLObjectHeight			= dsObjects.Getitemnumber(ll_FoundPLDetail,"nheight")
			iuo_FontCalc.of_GetTextSize("Calculate", sPLFontName, iPLFontSize, false, false, false, ll_height, ll_width)
			iPLTextHeight = Integer(ll_height)
			this.ii_TextRowsIn_PLDETAIL = truncate(iPLObjectHeight  / (iPLTextHeight + 1), 0)

			// Struktur mit Labeltexten f$$HEX1$$fc00$$ENDHEX$$llen
			choose case ls_column
			case COL_PLDETAIL_TEXT
				lstr_LabelPLTexte = of_create_pl_detail(ll_PackinglistIndexKey, ll_PackinglistDetailKey, strFlightInfo.dtDepartureDate)
			case COL_PLDETAIL_EXPL
			// 20.10.2010 Neu: Explosion "Explode item lists to lowest level"	
			// CBASE-NAM-CR-0029-Cart Diagram Add Req_Final
				lstr_LabelPLTexte = of_create_pl_explosion(ll_PackinglistIndexKey, ll_PackinglistDetailKey, strFlightInfo.dtDepartureDate)
				lb_NotExploded = false
			case else
				lstr_LabelPLTexte = of_create_pl_detail(ll_PackinglistIndexKey, ll_PackinglistDetailKey, strFlightInfo.dtDepartureDate)
			end choose
			// daten ins 1. label direkt eintragen
			dwData.SetItem(lRows, COL_PLDETAIL_TEXT, lstr_LabelPLTexte.cdetail_text[1])
			If ls_Column = COL_PLDETAIL_EXPL Then
				li_Succ = dwData.SetItem(lRows, COL_PLDETAIL_EXPL, lstr_LabelPLTexte.cdetail_text[1])
			End If
		end if 		// das waren die details
		// dann RTN
		if ll_FoundRTN > 0 then
			sPLFontname			= dsObjects.Getitemstring(ll_FoundRTN,"cfontname")
			iPLFontweight			= dsObjects.Getitemnumber(ll_FoundRTN,"nfontweight")
			iPLFontsize				= dsObjects.Getitemnumber(ll_FoundRTN,"nfontsize") * -1
			iPLObjectHeight			= dsObjects.Getitemnumber(ll_FoundRTN,"nheight")
			iuo_FontCalc.of_GetTextSize("Calculate", sPLFontName, iPLFontSize, false, false, false, ll_height, ll_width)
			iPLTextHeight = Integer(ll_height)
			
			this.ii_TextRowsIn_RTN_COMP	= truncate(iPLObjectHeight  / (iPLTextHeight + 1), 0)
			// Struktur mit Labeltexten f$$HEX1$$fc00$$ENDHEX$$llen
			lstr_LabelPLRTN = of_create_pl_rtn(ll_PackinglistIndexKey, strFlightInfo.dtDepartureDate, lb_NotExploded)		
			// daten ins 1. label direkt eintragen
			dwData.SetItem(lRows, COL_RTN_COMP, lstr_LabelPLRTN.cdetail_text[1])
		end if 		// das waren die RTNs
		
		// jetzt noch EQ
		if ll_FoundEQ> 0 then
			sPLFontname			= dsObjects.Getitemstring(ll_FoundEQ,"cfontname")
			iPLFontweight			= dsObjects.Getitemnumber(ll_FoundEQ,"nfontweight")
			iPLFontsize				= dsObjects.Getitemnumber(ll_FoundEQ,"nfontsize") * -1
			iPLObjectHeight			= dsObjects.Getitemnumber(ll_FoundEQ,"nheight")
			iuo_FontCalc.of_GetTextSize("Calculate", sPLFontName, iPLFontSize, false, false, false, ll_height, ll_width)
			iPLTextHeight = Integer(ll_height)
			this.ii_TextRowsIn_EQ_COMP	= truncate(iPLObjectHeight  / (iPLTextHeight + 1), 0)
			// Struktur mit Labeltexten f$$HEX1$$fc00$$ENDHEX$$llen
			 of_create_pl_eq(ll_PackinglistIndexKey, strFlightInfo.dtDepartureDate, lb_NotExploded,lstr_LabelPLEQ)		
			// daten ins 1. label direkt eintragen
			dwData.SetItem(lRows, COL_EQ_COMP, lstr_LabelPLEQ.cdetail_text[1])
		end if 		// das waren die EQs
		
		// dann die buchhaltung: label-z$$HEX1$$e400$$ENDHEX$$hler
		ll_labelCountEX = max(Upperbound(lstr_LabelPLRTN.cdetail_text),Upperbound(lstr_LabelPLEQ.cdetail_text))
		ll_LabelCountMax = max(Upperbound(lstr_LabelPLTexte.cdetail_text), ll_labelCountEX)
		ll_LabelCountMax = max(ll_LabelCountMax, ll_LabelCountDist)
		dwData.SetItem(lRows, "pldetail_label_counter", "1 of " + string(ll_LabelCountMax))

		// -------------------------------------------------------
		// Sind Labels zu duplizieren ?
		// solange noch welche aus distribution da sind, die bef$$HEX1$$fc00$$ENDHEX$$llen, dann erst kopieren
		// -------------------------------------------------------
		if Max(Upperbound(lstr_LabelPLTexte.cdetail_text), ll_labelCountEX) > 1 then
			for i = 2 to Max(Upperbound(lstr_LabelPLTexte.cdetail_text), ll_labelCountEX) step 1
				
				// solange noch welche aus distribution da sind, die bef$$HEX1$$fc00$$ENDHEX$$llen
				if i <= ll_LabelCountRows then
					ll_InsertRow = lRows + i -1
				else
				// zeile kopieren
					ll_Ret = dwData.RowsCopy(lRows, lRows, Primary!, dwData, dwData.Rowcount() + 1, Primary!)
					ll_InsertRow = dwData.Rowcount()
					li_Succ = dwData.SetItem(ll_InsertRow, COL_DISTRIBUTED_COMP, "")
				end if
				// detail-daten rein ? 
				if i <= Upperbound(lstr_LabelPLTexte.cdetail_text) then
					li_Succ = dwData.SetItem(ll_InsertRow, COL_PLDETAIL_TEXT, lstr_LabelPLTexte.cdetail_text[i])
					if ls_Column = COL_PLDETAIL_EXPL then
						li_Succ = dwData.SetItem(ll_InsertRow, COL_PLDETAIL_EXPL ,lstr_LabelPLTexte.cdetail_text[i])
					end if
				else
					li_Succ = dwData.SetItem(ll_InsertRow, COL_PLDETAIL_TEXT, "")
					if ls_Column = COL_PLDETAIL_EXPL then li_Succ = dwData.SetItem(ll_InsertRow, COL_PLDETAIL_EXPL, "")
				end if
				
				// RTN-daten rein ?
				if i <= Upperbound(lstr_LabelPLRTN.cdetail_text) then
					li_Succ = dwData.SetItem(ll_InsertRow, COL_RTN_COMP, lstr_LabelPLRTN.cdetail_text[i])
				else
					li_Succ = dwData.SetItem(ll_InsertRow, COL_RTN_COMP, "")
				end if
				// EQ-daten rein ?
				if i <= Upperbound(lstr_LabelPLEQ.cdetail_text) then
					li_Succ = dwData.SetItem(ll_InsertRow, COL_EQ_COMP, lstr_LabelPLEQ.cdetail_text[i])
				else
					li_Succ = dwData.SetItem(ll_InsertRow, COL_EQ_COMP, "")
				end if
				// label-z$$HEX1$$e400$$ENDHEX$$hler
				dwData.SetItem(ll_InsertRow,"pldetail_label_counter", string(i) + " of " + string(ll_LabelCountMax))
	
//				// ------------------------------------------------------------------
//				// Issue 3001
//				// ------------------------------------------------------------------
//				If ll_LabelCountMax > 9 then
//					dwData.SetItem(ll_InsertRow,"pldetail_label_counter", string(i, "00") + " of " + string(ll_LabelCountMax))
//				End If
				dwData.SetItem(ll_InsertRow,"nduplicated", 1)
				// ------------------------------------------------------------------
				// 26.02.07, KF
				// Verteilte Mahlzeiten auf dem zweiten Label nicht mehr anzeigen
				// (da die im DW in einer column schon eingetragen sind, m$$HEX1$$fc00$$ENDHEX$$ssen sie also gel$$HEX1$$f600$$ENDHEX$$scht werden)
				// NUR NOCH, wenn wirklich dupliziert wird
				// ------------------------------------------------------------------
//				dwData.SetItem(dwData.Rowcount(), COL_DISTRIBUTED_COMP, "")
			next
		end if 	// label war zu duplizieren

	end if 		// pldetail etc. gefunden
	
	// z$$HEX1$$e400$$ENDHEX$$hler zur$$HEX1$$fc00$$ENDHEX$$cksetzen
	ll_LabelCountDist = 0
	ll_LabelCountRows = 0

		
Next 

lLastLabelType		= 0
lLabelType			= 0

lEnde = CPU()

//of_log(String((lEnde - lStart) / 1000, "00.00") + " seconds getting pl details")
//if this.ib_Trace then
//	lsFilenameForTrace01 = f_gettemppath() + "LabelOther03-" + String(Rand(32767)) + String(now(), "hhmmss")
//	lsFilenameForTrace01 = f_valid_filename(lsFilenameForTrace01)	
//	lsFilenameForTrace02 = f_gettemppath() + "LabelOther04-" + String(Rand(32767)) + String(now(), "hhmmss")
//	lsFilenameForTrace02 = f_valid_filename(lsFilenameForTrace02)	
//
//	ll_Ret = dwdata.SaveAs(lsFilenameForTrace01 + ".xls", Excel!, True)
//end if

// ------------------------------------------------------------------------------------
// Daten sortieren 
// ------------------------------------------------------------------------------------
//Messagebox("", iLabelsort)
if iLabelSort = 4 then
	iRet = dwData.SetSort(is_Label_Group_Sort)
	iRet = dwData.Sort()
	
Elseif iLabelSort = 3 then
//if iLabelSort = 3 then
	iRet = dwData.SetSort("cen_loadinglists_nbelly_container A, cen_packinglists_nlabel_type_key A, carea_code A, cen_stowage_nsort A, cen_packinglist_index_cpackinglist A pldetail_label_counter A")
elseif iLabelSort = 2 then
	iRet = dwData.SetSort("cen_loadinglists_nbelly_container A, cen_packinglists_nlabel_type_key A, cen_stowage_nsort A, cen_packinglist_index_cpackinglist A pldetail_label_counter A")
elseif iLabelSort = 1 then
	iRet = dwData.SetSort("cen_loadinglists_nbelly_container A, carea_code A, cen_packinglists_nlabel_type_key A, cen_stowage_nsort A, cen_packinglist_index_cpackinglist A pldetail_label_counter A")	
end if	

dwData.Sort()

//if this.ib_Trace then
//	ll_Ret = dwdata.SaveAs(lsFilenameForTrace02 + ".xls", Excel5!, True)
//end if

if iRet = -1 then
	of_log("Error -1, wrong sort criteria")
	return -1
end if

//-----------------------------------------------------
//MB 22.01.2013: of_set_mealcode_flag aufrufen
//------------------------------------------------------
of_set_mealcode_flag( )

// -----------------------------------------
// Columndefinitionen aus SYS_LABEL_COLUMNS
// -----------------------------------------
if dsColumns.Retrieve() <= 0 then
	of_log("Error -14, no data from SYS_LABEL_COLUMNS")
	return -1
end if

// -----------------------------------------
// Label bauen
// -----------------------------------------
lLabelType = dwData.GetItemNumber(1, "cen_packinglists_nlabel_type_key")
iRet = of_build_label(Date(strFlightInfo.dtDepartureDate), lLabelType, iPrinterType)
lLastLabelType = lLabelType

if iRet <> 0 then
	return iRet
end if

// -----------------------------------------
// Bilder blobben
// -----------------------------------------
//iRet = of_create_pictures(strBMP)
//if iRet <> 0 then
//	return iRet
//end if

// -----------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r den Spooler noch nen Namen geben
// -----------------------------------------
dsLayout.Modify("datawindow.print.documentname = 'Labelprint: " + strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber + " " + String(Date(strFlightInfo.dtDepartureDate)) + "/" + strFlightInfo.cDepartureTime + "'")
isBelly 	= of_isbelly(dwData.GetItemNumber(1, "cen_loadinglists_nbelly_container"))
sArea		= dwData.GetItemString(1, "carea_code")

// -----------------------------------------
// dw_loadinglist_result "zerlegen"
// -----------------------------------------
of_analyse(dwData)

lStart = CPU()

// -----------------------------------------
// 26.09.2012, KF: KPI Messung f$$HEX1$$fc00$$ENDHEX$$r 
// Michael ....
// -----------------------------------------
il_kpi_labelcount = dwData.Rowcount()

//------------------------------------------------
//18.01.2013: MB Healthmark f$$HEX1$$fc00$$ENDHEX$$r UK bef$$HEX1$$fc00$$ENDHEX$$llen -> wird in uo_client_label schon gemacht
//-----------------------------------------------
///of_fill_healthmark( strflightinfo)


// -----------------------------------------
// #5955 Rancho Number
// -----------------------------------------
// of_fill_rancho_number( strflightinfo )


//If dwData.RowCount() > 0 then
//	lResultKey = dwData.GetItemNumber(1, "nresult_key")
//End If
lResultKey = 0

For lRows = 1 to dwData.RowCount()
	
	// -----------------------------------------------------------------
	// Achtung: Stationsauftrag
	// Nur die Packinglists ber$$HEX1$$fc00$$ENDHEX$$cksichtigen, die auch f$$HEX1$$fc00$$ENDHEX$$r die Station 
	// interessant sind.
	// -----------------------------------------------------------------
	if dwData.GetItemNumber(lRows, "stationinstruction") = 0 then
		continue
	end if

	if lResultKey <> dwData.GetItemNumber(lRows, "nresult_key") then
		lResultKey = dwData.GetItemNumber(lRows, "nresult_key") 
		li_Succ = of_legs( )
		select cactype, cconfiguration, cKitchen_Time, cRamp_Time, cunit
		into :strFlightInfo.sActype , :strFlightInfo.sConfiguration	, :sKitchenTime	, :sRampTime, :ls_CSC
		from cen_out 
		where nresult_key = :lresultkey;
		
		strFlightInfo.dtDepartureDate = dwData.GetItemDateTime(lRows, "ddeparture")
		strFlightInfo.cDepartureTime = dwData.GetItemString(lRows, "cdeparture_time")

		// bestbefore bestimmen: f$$HEX1$$fc00$$ENDHEX$$r k$$HEX1$$fc00$$ENDHEX$$chenzeit tag erg$$HEX1$$e400$$ENDHEX$$nzen
		ldt_help = datetime(date(strFlightInfo.dtDepartureDate), time(this.of_checknull(sKitchenTime)))
		// abflug-termin kleiner als gleicher tag + k$$HEX1$$fc00$$ENDHEX$$chenzeit: tag um 1 reduzieren
		//f_trace("uo_client_label.of_label BEFORE of_rel_datetime_minutes ")
		if datetime(date(strFlightInfo.dtDepartureDate), time(strFlightInfo.cDepartureTime)) < ldt_help then
			ldt_help = datetime(relativedate(date(strFlightInfo.dtDepartureDate),-1), time(sKitchenTime))
		end if
		strFlightInfo.dtBestBeforeTime = iuo_DateFunctions.of_rel_datetime_minutes(ldt_help, il_BestBefore_Minutes)
		
	end if
		

	// -------------------------------------------------------------------
	// Bei Multi Flight Label Erstellung, jeweils Flight Info aktualisieren
	// -------------------------------------------------------------------
	//Issues #2975
	if not isnull( dwData.GetItemDateTime(lRows, "ddeparture")) then
		
		strFlightInfo.sAirline = dwData.GetItemString(lRows, "cairline")
		strFlightInfo.sFlightNumber = Trim(String(dwData.GetItemNumber(lRows, "nflight_number"), "000") + " " + trim(dwData.GetItemString(lRows, "csuffix")))
		strFlightInfo.sDestination					= dwData.GetItemString(lRows, "ctlc_to")
		strFlightInfo.cDepartureTime = dwData.GetItemString(lRows, "cdeparture_time")
		strFlightInfo.sActype = dwData.GetItemString(lRows, "cactype")
		strFlightInfo.sOwner = dwData.GetItemString(lRows, "cairline_owner")
		strFlightInfo.dtDepartureDate = dwData.GetItemDateTime(lRows, "ddeparture")
		
	End If
	
	If f_unitprofileString("PPMBARCODE4GROUP", String(il_Printing_Group) , "0",  ls_CSC ) = "1" Then
		lb_NO_PPM_CODE = FALSE 
		of_log("il_Printing_Group "+string(il_Printing_Group)+"PPMBARCODE4GROUP = FALSE " + ls_CSC)
	Else
		lb_NO_PPM_CODE = TRUE
		of_log("il_Printing_Group "+string(il_Printing_Group)+"PPMBARCODE4GROUP = TRUE " + ls_CSC)
	End If
	

//strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber, &
//							 Date(strFlightInfo.dtDepartureDate), &
//							 strFlightInfo.cDepartureTime, &
//							 strFlightInfo.sDestination, &
//							 strFlightInfo.sOwner + " " + strFlightInfo.sActype , &
//							 strFlightInfo.sConfiguration, &
//							 strFlightInfo.sDeparture, &
//							 strFlightInfo.dtBestBeforeTime)	

	// --------------------------------------------------------------------------------------------------------------------
	// Nachschaun, on sich der Labeltyp oder Belly ge$$HEX1$$e400$$ENDHEX$$ndert hat
	// dann ggf. neues Layout (kompl. Reset auf dsLayout und neu Zeichnen)
	// --------------------------------------------------------------------------------------------------------------------
	//
	// Was macht das folgende IF ???
	//
	// 1. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Sortierung nach Galley = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + iLabelSort = 2
	//
	// 2. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Area unver$$HEX1$$e400$$ENDHEX$$ndert + Sortierung nach Area = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + sArea = dwDat..  + iLabelSort = 1
	//
	// 3. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Area VER$$HEX1$$c400$$ENDHEX$$NDERT + Sortierung nach Area + Areas fortlaufend = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + sArea <> dwDat.+ iLabelSort = 1       + iLabelPageBreak = 0
	//
	// --------------------------------------------------------------------------------------------------------------------
		
	if (	lLabelType = dwData.GetItemNumber(lRows, "cen_packinglists_nlabel_type_key") and &
			of_isbelly(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")) = isBelly and &
			iLabelSort = 2 &
		) 	&
		or &
		(	lLabelType = dwData.GetItemNumber(lRows, "cen_packinglists_nlabel_type_key") and &
			of_isbelly(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")) = isBelly and &
			sArea = dwData.GetItemString(lRows, "carea_code") and &
			(iLabelSort = 1 or iLabelSort = 3)&
		) &
		or &
		(	lLabelType = dwData.GetItemNumber(lRows, "cen_packinglists_nlabel_type_key") and &
			of_isbelly(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")) = isBelly and &
			dwData.GetItemString(lRows, "carea_code") <> sArea and &
			(iLabelSort = 1 or iLabelSort = 3) and &
			iLabelPageBreak = 0 &
		) &
		OR		&
		(	lLabelType = dwData.GetItemNumber(lRows, "cen_packinglists_nlabel_type_key") and &
		iLabelSort = 4 ) &		
		then  
		
		// -------------------------------------------------
		// Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert, dann Daten reinpacken
		// -------------------------------------------------
		
		lInsert = dsLayout.InsertRow(0)	
		
		dsLayout.SetItem(lInsert, "nobject_type", lInsert)
		dsLayout.SetItem(lInsert, "nbelly", of_checknull(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")))
		dsLayout.SetItem(lInsert, "carea", of_checknull(dwData.GetItemString(lRows, "carea")))
		dsLayout.SetItem(lInsert, "cworkstation", of_checknull(dwData.GetItemString(lRows, "cworkstation")))
		
		// ------------------------------------------------------
		// KF: 21.09.2012, der Barcode 
		// ------------------------------------------------------
		//if this.ihasbarcode = 1 then
		// 25.5.18 abschaltbar
		if this.ihasbarcode = 1 and this.ihidebarcode = 0 then	
			
			ls_barcode_file =  f_gettemppath() + "cbase_barcode_" + string(lRows, "000") + "_" + string(cpu()) + ".bmp"
			dsLayout.SetItem(lInsert, "cfilename", ls_barcode_file)
//			ls_barcode =	string(this.lresultkey) + "#" + &
//							 	string(dwData.GetItemNumber(lRows, "cen_stowage_nstowage_key")) + "#" + &
//							   	string(dwData.GetItemNumber(lRows, "cen_packinglist_index_npackinglist_index_key"))
			//MB: 13.11.2012 Inhalt f$$HEX1$$fc00$$ENDHEX$$r Fluglabel St$$HEX1$$fc00$$ENDHEX$$ckliste	Flugdatum	Flugschl$$HEX1$$fc00$$ENDHEX$$ssel	Stauort	Menge (Treenzeichen TAB):
			ls_barcode = of_create_barcode_information(dwData, lRows, strflightinfo)
			this.of_create_barcode(37, ls_barcode_file, ls_barcode, 120,120, 75)

		Elseif this.ihasbarcode = 1 and this.ihidebarcode = 1 and iVPSBarcode = 1 AND lb_NO_PPM_CODE = FALSE then	

			// Check ob diese Zeile in aktueller Printing Group
			sArea				= dwData.GetItemString(lRows, "carea")
			sWorkStation   = dwData.GetItemString(lRows, "cworkstation")
			
			ls_Find = "loc_unit_areas_carea='" + sArea + "'"
			ls_Find += " and loc_unit_workstation_cworkstation='" + sWorkStation + "'"
			ll_Found = lds_Prt_Grp.Find(ls_Find,1,lds_Prt_Grp.RowCount())
			If lds_Prt_Grp.Find(ls_Find,1,lds_Prt_Grp.RowCount()) < 1 then
				ls_Find = "NOT IN GROUP"	
			
			Else

			//loc_unit_areas.carea= LC-EQ and loc_unit_workstation.ctext = Labels Mix TSU & Equip & ENT
			
			
			ls_Temp = dwData.GetItemString(lRows,"pldetail_label_counter")
			If isnull(ls_Temp) OR trim(ls_Temp) = "" OR Left(ls_Temp, 1) = "1" Then
				lb_First = TRUE
			Else
				lb_First = FALSE
			End If
			
			ls_barcode_file =  f_gettemppath() + "cbase_barcode_" + string(lRows, "000") + "_" + string(cpu()) + ".bmp"
			dsLayout.SetItem(lInsert, "cfilename", ls_barcode_file)

			
			//	Flug-Label VPS (WIKI)
			// Barcode ID
			//	npackinglistIndexKey
			//	ddeparture
			//	nresultKey
			//	nstowageKey
			//	nppmProdLabelKey

			//	%001%0000020019311 8 0 42017000023495158000008154711000 0 08154711
			

			// Barcode Format V2 / Flug-Label VPS
			ls_barcode = "%001%"
						
			ls_Temp = String(dwData.GetItemNumber(lRows,"cen_packinglist_index_npackinglist_index_key"), "000000000000")
			ls_barcode += ls_Temp
			
//			String(strFlightInfo.dtDepartureDate),"YYYYMMDD")
			
			
			ls_Temp = String(strFlightInfo.dtDepartureDate,"DDMMYYYY")
			ls_barcode += ls_Temp

			ls_Temp = String(lResultKey,  "000000000000")
			ls_barcode += ls_Temp

			//nstowageKey
			ls_Temp = String(dwData.GetItemNumber(lRows, "cen_stowage_nstowage_key"), "000000000000")
			ls_barcode += ls_Temp
			
			ll_ST_Key =  dwData.GetItemNumber(lRows, "cen_stowage_nstowage_key")
			ls_Debug = dwData.GetItemString(lRows, "cen_packinglist_index_cpackinglist")
			ll_PL_Key =  dwData.GetItemNumber(lRows,"cen_packinglist_index_npackinglist_index_key")
					
			ll_Key = 0
			//select nppm_prod_label_key 
			
			select min(nppm_prod_label_key) 
			into :ll_Key
			from cen_out_ppm_prod_label 
			where nresult_key = :lResultKey
			and nstowage_key = :ll_ST_Key
			and npl_index_key = :ll_PL_Key   ;
			
			IF SQLCa.SQLCode = 0 Then
				//OK
			Else
				SetNULL(ll_Key)
			End If
			
			If ll_Key = 0 Then
				SetNULL(ll_Key)
			End If
	
			If lb_First = TRUE Then
				
				if not isnull(ll_Key) Then
		
					ls_Temp = String(ll_Key,  "000000000000")
					ls_barcode += ls_Temp
				
					// Add "readable" part / cFlightKey
					IF lb_Barcode_without_Newline = FALSE THEN
						ls_barcode += "~r~n"	
					END IF
					IF lb_Barcode_without_cFlightkey = FALSE THEN
						ls_barcode += ls_cFlight_key
					End If	
				
					
					this.of_create_barcode(58, ls_barcode_file, ls_barcode, 120,120, 75)
					// -----------------------------------------------------------
					// zu Issue #5076 VPS Flightlabel Barcode anstelle des normalen Barcodes (falls Schalter gesetzt)

					
					il_Stowage_Key_Array[Upperbound(il_Stowage_Key_Array) + 1] = ll_ST_Key
					
					of_log( "of_label create VPS Flight Label Barcode " +ls_Debug + " " + ls_barcode)
					
					// -----------------------------------------------------------
					
				else
					of_log( "of_label NO VPS Flight Label Barcode for " + ls_Debug)
		
				end if
			else
				of_log( "of_label NO VPS Flight Label Barcode for " + ls_Debug + " " + dwData.GetItemString(lRows,"pldetail_label_counter"))
			
			end if
		end if
		end if
	
		of_fill_columns(lRows, &
							 lInsert, &
							 dwData, &
							 strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber, &
							 Date(strFlightInfo.dtDepartureDate), &
							 strFlightInfo.cDepartureTime, &
							 strFlightInfo.sDestination, &
							 strFlightInfo.sOwner + " " + strFlightInfo.sActype , &
							 strFlightInfo.sConfiguration, &
							 strFlightInfo.sDeparture, &
							 strFlightInfo.dtBestBeforeTime)	

	else
		// -------------------------------------------------------------------
		// Labeltyp oder Belly hat sich ge$$HEX1$$e400$$ENDHEX$$ndert, den Datastore (dsLayout)
		// in das UserObject packen und den neuen Labeltyp bauen
		// -------------------------------------------------------------------
		iRet = dsLayout.GetFullState(bBlob)
		
		if iRet = -1 then
			return -13
		end if
		
		iRetCount ++		
		this.uoResult[iRetCount] = Create uo_label_return
		this.uoResult[iRetCount].llabeltype = lLabelType
		this.uoResult[iRetCount].bLabel = bBlob					// alle Label eines Labeltyps

		if isBelly then
			this.uoResult[iRetCount].sLabel = sLabel + " (Belly)" 
		else
			this.uoResult[iRetCount].sLabel = sLabel
		end if
		
		this.uoResult[iRetCount].sLabelComment = sArea
		this.uoResult[iRetCount].sWorkstation	= sWorkStation
		this.uoResult[iRetCount].isBelly = isBelly
		this.uoResult[iRetCount].iLabelSort = iLabelSort
		this.uoResult[iRetCount].iLabelPageBreak = iLabelPageBreak		
		this.uoResult[iRetCount].sGeneratedForPrinter = this.sGeneratedForPrinter
		// -----------------------------------------------------------
		// Neuen Label-Typ zeichnen, wenn er sich ge$$HEX1$$e400$$ENDHEX$$ndert hat
		// -----------------------------------------------------------
		lLabelType = dwData.GetItemNumber(lRows, "cen_packinglists_nlabel_type_key") 
		isBelly = of_isbelly(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container"))
		
		if lLabelType <> lLastLabelType or isBelly = True then
		
			iRet = of_build_label(date(strFlightInfo.dtDepartureDate), lLabelType, iPrinterType)
			
			if iRet <> 0 then
				return iRet
			end if
			
			lLastLabelType = lLabelType 
			
		else
			
			dsLayout.Reset()
			
		end if
		
		lInsert = dsLayout.InsertRow(0)	
		dsLayout.SetItem(lInsert, "nobject_type", lInsert)
		dsLayout.SetItem(lInsert, "nbelly", of_checknull(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")))
		dsLayout.SetItem(lInsert, "carea", of_checknull(dwData.GetItemString(lRows, "carea")))
		dsLayout.SetItem(lInsert, "cworkstation", of_checknull(dwData.GetItemString(lRows, "cworkstation")))
		
		// ------------------------------------------------------
		// KF: 21.09.2012, der Barcode 
		// ------------------------------------------------------
		//if this.ihasbarcode = 1 then
		// 25.5.18 abschaltbar
		if this.ihasbarcode = 1 and this.ihidebarcode = 0 then					
			
			ls_barcode_file =  f_gettemppath() + "cbase_barcode_" + string(lRows, "000") + "_" + string(cpu()) + ".bmp"
			dsLayout.SetItem(lInsert, "cfilename", ls_barcode_file)
	/*		ls_barcode =	string(this.lresultkey) + "#" + &
							 	string(dwData.GetItemNumber(lRows, "cen_stowage_nstowage_key")) + "#" + &
							   	string(dwData.GetItemNumber(lRows, "cen_packinglist_index_npackinglist_index_key"))
	*/
	
			ls_barcode = of_create_barcode_information(dwData, lRows, strflightinfo)
			this.of_create_barcode(37, ls_barcode_file, ls_barcode, 120,120, 75)
		
		Elseif this.ihasbarcode = 1 and this.ihidebarcode = 1 and iVPSBarcode = 1 AND lb_NO_PPM_CODE = FALSE then	
			
			// Check ob diese Zeile in aktueller Printing Group
			sArea				= dwData.GetItemString(lRows, "carea")
			sWorkStation   = dwData.GetItemString(lRows, "cworkstation")
			
			ls_Find = "loc_unit_areas_carea='" + sArea + "'"
			ls_Find += " and loc_unit_workstation_cworkstation='" + sWorkStation + "'"
			
			ll_Found = lds_Prt_Grp.Find(ls_Find,1,lds_Prt_Grp.RowCount())
			If lds_Prt_Grp.Find(ls_Find,1,lds_Prt_Grp.RowCount()) < 1 then
				ls_Find = "NOT IN GROUP"	
			
			Else
			
				
				ls_Temp = dwData.GetItemString(lRows,"pldetail_label_counter")
				If isnull(ls_Temp) OR trim(ls_Temp) = "" OR Left(ls_Temp, 1) = "1" Then
					lb_First = TRUE
				Else
					lb_First = FALSE
				End If
				
				ls_barcode_file =  f_gettemppath() + "cbase_barcode_" + string(lRows, "000") + "_" + string(cpu()) + ".bmp"
				dsLayout.SetItem(lInsert, "cfilename", ls_barcode_file)
	
				
				//	Flug-Label VPS (WIKI)
				// Barcode ID
				//	npackinglistIndexKey
				//	ddeparture
				//	nresultKey
				//	nstowageKey
				//	nppmProdLabelKey
	
				//	%001%0000020019311 8 0 42017000023495158000008154711000 0 08154711
				
				// Barcode Format V2 / Flug-Label VPS
				ls_barcode = "%001%" 					
				
				ls_Temp = String(dwData.GetItemNumber(lRows,"cen_packinglist_index_npackinglist_index_key"), "000000000000")
				ls_barcode += ls_Temp
				
	//			String(strFlightInfo.dtDepartureDate),"YYYYMMDD")
				
				ls_Temp = String(strFlightInfo.dtDepartureDate,"DDMMYYYY")
				ls_barcode += ls_Temp
	
				ls_Temp = String(lResultKey,  "000000000000")
				ls_barcode += ls_Temp
	
				//nstowageKey
				ls_Temp = String(dwData.GetItemNumber(lRows, "cen_stowage_nstowage_key"), "000000000000")
				ls_barcode += ls_Temp
				
				ll_ST_Key =  dwData.GetItemNumber(lRows, "cen_stowage_nstowage_key")
				ls_Debug = dwData.GetItemString(lRows, "cen_packinglist_index_cpackinglist")
				ll_PL_Key =  dwData.GetItemNumber(lRows,"cen_packinglist_index_npackinglist_index_key")
						
				ll_Key = 0
				//select nppm_prod_label_key 
				
				select min(nppm_prod_label_key) 
				into :ll_Key
				from cen_out_ppm_prod_label 
				where nresult_key = :lResultKey
				and nstowage_key = :ll_ST_Key
				and npl_index_key = :ll_PL_Key   ;
				
				IF SQLCa.SQLCode = 0 Then
					//OK
				Else
					SetNULL(ll_Key)
				End If
				
				If ll_Key = 0 Then
					SetNULL(ll_Key)
				End If
		
				If lb_First = TRUE Then
					
					if not isnull(ll_Key) Then
			
						ls_Temp = String(ll_Key,  "000000000000")
						ls_barcode += ls_Temp
					
						// Add "readable" part / cFlightKey
						IF lb_Barcode_without_Newline = FALSE THEN
							ls_barcode += "~r~n"	
						END IF
						IF lb_Barcode_without_cFlightkey = FALSE THEN
							ls_barcode += ls_cFlight_key
						End If
					
						this.of_create_barcode(58, ls_barcode_file, ls_barcode, 120,120, 75)
						// -----------------------------------------------------------
						// zu Issue #5076 VPS Flightlabel Barcode anstelle des normalen Barcodes (falls Schalter gesetzt)
						
	//					update	cen_out_ppm_prod_label
	//					set		nprinted = 1
	//					where		nppm_prod_label_key = :ll_Key ;
						
						of_log( "of_label create VPS Flight Label Barcode " +ls_Debug + " " + ls_barcode)
						
						il_Stowage_Key_Array[Upperbound(il_Stowage_Key_Array) + 1] = ll_ST_Key
						
						// -----------------------------------------------------------
						
					else
						of_log( "of_label NO VPS Flight Label Barcode for " + ls_Debug)
			
					end if
				else
					of_log( "of_label NO VPS Flight Label Barcode for " + ls_Debug + " " + dwData.GetItemString(lRows,"pldetail_label_counter"))
				
				end if
			end if
		end if
		
		
		of_fill_columns(lRows, &
							 lInsert, &
							 dwData, &
							 strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber, &
							 Date(strFlightInfo.dtDepartureDate), &
							 strFlightInfo.cDepartureTime, &
							 strFlightInfo.sDestination, &
							 strFlightInfo.sOwner + " " + strFlightInfo.sActype , &
							 strFlightInfo.sConfiguration, &
							 strFlightInfo.sDeparture, &
							 strFlightInfo.dtBestBeforeTime)	
		
	end if

	sArea 			= dwData.GetItemString(lRows, "carea_code")
	sWorkStation 	= dwData.GetItemString(lRows, "cworkstation_text")
	f_yield(lRoleID)		
	//messagebox("DANACH !!!!!!!!!!!!!", "Zeile " + string(lRows) + " von " + string(dwData.RowCount()))

Next

iRet = dsLayout.GetFullState(bBlob)
if iRet = -1 then
	return -13
end if

// messagebox("DANACH !!!!!!!!!!!!!", "1")
// -----------------------------------------------------------
// R$$HEX1$$fc00$$ENDHEX$$ckgabe: Array von uo_label_return - Objekten
// -----------------------------------------------------------
iRetCount ++				
this.uoResult[iRetCount] = Create uo_label_return
this.uoResult[iRetCount].bLabel = bBlob
this.uoResult[iRetCount].lLabeltype = lLabelType

if isBelly then
	this.uoResult[iRetCount].sLabel = sLabel + " (Belly)" 
else
	this.uoResult[iRetCount].sLabel = sLabel
end if

this.uoResult[iRetCount].sLabelComment = sArea
this.uoResult[iRetCount].sWorkstation = sWorkstation
this.uoResult[iRetCount].isBelly = isBelly
this.uoResult[iRetCount].iLabelSort = iLabelSort
this.uoResult[iRetCount].iLabelPageBreak = iLabelPageBreak
this.uoResult[iRetCount].sGeneratedForPrinter = this.sGeneratedForPrinter

this.of_destroy_layout()
lEnde = CPU()


COMMIT;

//of_log(String((lEnde - lStart) / 1000, "00.00") + " building all Labels")
DESTROY	lds_Prt_Grp


return 0

end function

public function integer of_destroy_layout ();//----------------------------------------------------
// 08.12.2005
// 
//----------------------------------------------------

integer 	i, &
			j, &
			iCount, &
			iPos, &
			iY
			
string 	sDWObjects, &
			sTemp, &
			sObjects[], &
			sValidObjects[], &
			sBand, &
			sSyntax, &
			sObject, &
			sType, &
			lTaborder, &
			sTag

long 		lInsert, &
			lHeight

// ---------------------------------------
// Get alles nicht mit nem datastore vom
// Typ Label
// ---------------------------------------
if this.iThermo <> 1 then return 0

// ---------------------------------------
// Alle Objekte von DW_LAYOUT auslesen
// ---------------------------------------
sDWObjects = dsLayout.describe("datawindow.objects")

// ---------------------------------------
// Den String zerhacken und alle Objekte
// ein Array schreiben
// ---------------------------------------

for i = 1 to len(sDWObjects)
	
	if Mid(sDWObjects, i, 1) <> char(9) then
		sTemp += Mid(sDWObjects, i, 1)
	else
		
		if Mid(sTemp, 1, 3) = "obj" then
			iCount ++
			sObjects[iCount] = sTemp
		end if 
		
		sTemp = ""
		
	end if

next

if len(sTemp) > 0 then		
	
	if Mid(sTemp, 1, 3) = "obj" then
		iCount ++
		sObjects[iCount] = sTemp
	end if
	
end if

for i = 1 to iCount
	dsLayout.Modify("Destroy " + sObjects[i])
Next

return 0
end function

public function integer of_fill_spml_columns (long lrowdata, long lrowinsert, datastore odw);// --------------------------------------------------
// Die Columns mir Werte f$$HEX1$$fc00$$ENDHEX$$llen
// --------------------------------------------------
str_label_print 		strPrint[]
s_distribution_text	strValues[], strEmpty[]

integer 				iCount, &
						iFontSize, &
						iStartSize, &
						iItems

long 					lColumns, &
						lFound, &
						lWidth, &
						lHeight, &
						lForTo, &
						lCheck
						
string 				sObject, &
						sColumn, &
						sFont, &
						sFindColumn, &
						sNotFound, &
						sValue, &
						sWrapText

boolean lb_Bold, lb_Italic, lb_Underline, lb_Wrap
		
// --------------------------------------------------
// dann alle anderen in die Struktur schreiben ...
// --------------------------------------------------
sNotFound = ""

for lColumns = 1 to dsColumns.RowCount()
	
	// --------------------------------------------------
	// ... aber nur, wenn es die Column im Datastore gibt
	// --------------------------------------------------
	sFindColumn = dsColumns.GetItemString(lColumns, "ccolumn")
	lCheck = dsLoadinglistColumns.Find("sobject = '" + sFindColumn + "'", 1, dsLoadinglistColumns.RowCount())
	if lCheck <= 0 then
		continue
	end if
	
	iCount ++
	strPrint[iCount].cColumn = dsColumns.GetItemString(lColumns, "ccolumn")
	if mid(oDW.Describe(strPrint[iCount].cColumn + ".coltype"), 1, 4) = "char" then
		strPrint[iCount].cValue = of_checknull(oDW.GetItemString(lRowData, strPrint[iCount].cColumn))
	elseif oDW.Describe(strPrint[iCount].cColumn + ".coltype") = "datetime" then
		strPrint[iCount].cValue = String(oDW.GetItemDateTime(lRowData, strPrint[iCount].cColumn))
	else		
		strPrint[iCount].cValue = String(oDW.GetItemNumber(lRowData, strPrint[iCount].cColumn))
	end if
		
	strPrint[iCount].nExternal = 0
	strPrint[iCount].ncalculate_size = dsColumns.GetItemNumber(lColumns, "ncalculate_size")
	
next

//f_print_datastore(dsColumns)
//f_print_datastore(dsObjects)


// --------------------------------------------------
// und zum Schlu$$HEX2$$df002000$$ENDHEX$$die Werte ins Label eintragen !!!
// --------------------------------------------------
for lColumns = 1 to dsObjects.RowCount()
	// --------------------------------------------------
	// erstmal schaun, ob es ne column ist
	// --------------------------------------------------
	if dsObjects.GetItemNumber(lColumns, "nobject_type") = 1 then
		
		// --------------------------------------------------
		// wenn ja, den Objekt und Columnnamen merken
		// --------------------------------------------------
		sObject = dsObjects.GetItemString(lColumns, "cobject_name")
		sColumn = dsObjects.GetItemString(lColumns, "ccolumn")
		
		// --------------------------------------------------
		// Nun noch die Column in der Struktur suchen und
		// ins Label eintragen
		// --------------------------------------------------
		for iCount = 1 to UpperBound(strPrint)
			
			if strPrint[iCount].cColumn = sColumn then
				
				lb_Wrap = (dsObjects.GetItemNumber(lColumns, "nwrap") = 1)
				if lb_Wrap then
					sWrapText = strPrint[iCount].cValue
					sValue = of_wrap(of_checknull(sWrapText), 8, 5, 4)					
				else
					sValue = of_checknull(strPrint[iCount].cValue)	
				end if
				
				dsLayout.SetItem(lRowInsert,sObject,sValue)
								
				lFound = dsColumns.Find("ccolumn='" + dsObjects.GetItemString(lColumns, "ccolumn") + "'", 1, dsColumns.RowCount())
				if lFound > 0 then
					if dsColumns.GetItemNumber(lFound, "ncalculate_size") = 1 then						
						lHeight 			= Long(dsLayout.Describe(sObject + ".height"))
						lWidth  			= Long(dsLayout.Describe(sObject + ".width"))
						sFont 			= dsLayout.Describe(sObject + ".font.face")
						iStartSize 		= dsObjects.GetItemNumber(lColumns, "nfontsize") * -1

						// Die optimale Schriftgr$$HEX2$$f600df00$$ENDHEX$$e ermitteln
						lb_Bold = (dsObjects.GetItemNumber(lColumns, "nfontweight") = 700)
						lb_Italic = (dsObjects.GetItemNumber(lColumns, "nfontitalic") = 1)
						lb_Underline = (dsObjects.GetItemNumber(lColumns, "nfontunderline") = 1)
						iuo_FontCalc.of_GetOptFontSize(sValue, sFont, iFontSize, lb_Bold, lb_Italic, lb_Underline, lHeight, lWidth, false)
						
						// Wenn die optimale Schriftgr$$HEX2$$f600df00$$ENDHEX$$e gr$$HEX2$$f600df00$$ENDHEX$$er ist, als die Start-Schriftgr$$HEX2$$f600df00$$ENDHEX$$e, nehmen wir die Start-Schriftgr$$HEX2$$f600df00$$ENDHEX$$e
						if iFontSize > iStartSize then iFontSize = iStartSize
						dsLayout.SetItem(lRowInsert, "fs_" + sObject, -iFontSize)
					end if
				end if
				
				exit
			
				
			end if
			
		next
				
	end if

Next

return 0
end function

public function integer of_label_spml (datastore dwdata, integer iprintertype, ref str_bitmaps strbmp[]);// ------------------------------------------------------------------------------------
// Erstellen der SPML - Labels
//
// Parameter:	dwdata 				dw_1 aus ou_loading_list
// 				iPrinterType		1 = Thermodrucker via Druckertreiber
//											2 = Normaler Drucker (auf Bogen)
//					sFlgnr				Flugnummer (Airline + Flugnummer + Suffix)
//					dDepDate				Abflugdatum
//					sDepTime				Abflugzeit
// 				strRet				Struktur vom Typ str_label_return
//											wird per Referenz $$HEX1$$fc00$$ENDHEX$$bergeben und gef$$HEX1$$fc00$$ENDHEX$$llt
//					ilabelsort			1 = Sortiere die Label nach Bereichen
//											2 = Sortiere die Label nach Galley
//
//
//	R$$HEX1$$fc00$$ENDHEX$$ckgabe:	 0		alle prima
//					-1		keine Daten in dwdata
//					-2		kein g$$HEX1$$fc00$$ENDHEX$$ltiges Label gefunden
//					-3		ung$$HEX1$$fc00$$ENDHEX$$ltiger Wert in iPrinterType
//					-4		Fehler beim ColumnObject
//					-5		Fehler beim LineObject
//					-6		Fehler beim RectangleObject
//					-7		Fehler beim TextObject
//					-8		Fehler beim BitmapObject
//					-9		Fehler im dsMaster kein oder mehr als ein Datensatz
//					-10	Fehler im dsObjects kein Datensatz
//					-11	Label hat keine Columns
// 				-12	Fehler beim erzeugen der Bitmaps
// 				-13	
// 				-14	Fehler keine Daten in SYS_LABEL_COLUMNS
// ------------------------------------------------------------------------------------
Datetime dtValid, dtSearch, dtDepartureDate
Long lLabelType
Long lRows
Long lInsert
Long lFound
Blob bBlob
String sArea, sFilter, sWorkstation
integer iRet
long	lPackinglistDetail
long	lPackinglistIndexKey
long	lPackinglistDetailKey
s_packinglist_detail	sLabelPLTexte
integer	i
Long lStart, lEnde
String	sFlight,ls_barcode_file,ls_barcode
Integer iLabelSort		= 1
Integer iLabelPageBreak = 0

// ------------------------------------------------------------------------------------
// Mal schaun, ob $$HEX1$$fc00$$ENDHEX$$berhaupt Daten drin sind
// ------------------------------------------------------------------------------------
if dwdata.RowCount() = 0 then
	of_log("Error -1, no data found, RowCount() on dwData = 0 ")
	return -1
end if
// ------------------------------------------------------------------------------------
// Retrieve der Produktgruppen
// ------------------------------------------------------------------------------------	
dsProductGroup.Retrieve("002")
lLabelType			= 0

// -----------------------------------------
// Columndefinitionen aus SYS_LABEL_COLUMNS
// -----------------------------------------
dsColumns.dataobject = "dw_label_print_spml_columns"
dsColumns.SetTransObject(sqlca)
if dsColumns.Retrieve() <= 0 then
	of_log("Error -14, no data from SYS_LABEL_COLUMNS_PROD")
	return -1
end if
// -----------------------------------------
// Label bauen
// -----------------------------------------
select nlabel_type_key into :lLabelType from cen_label_type where ctext = :this.sSPMLLabelType;

if sqlca.sqlcode <> 0 then return -3

dtDepartureDate 	= dwData.GetItemDateTime(1, "ddeparture")
sFlight				= dwData.GetItemString(1, "compute_flight")

iRet = of_build_label(Date(dtDepartureDate), lLabelType, iPrinterType)

if iRet <> 0 then
	return iRet
end if

// -----------------------------------------
// Bilder blobben
// -----------------------------------------
iRet = of_create_pictures(strBMP)
if iRet <> 0 then
	return iRet
end if
// -----------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r den Spooler noch nen Namen geben
// -----------------------------------------
dsLayout.Modify("datawindow.print.documentname = 'SPML-Label " + sFlight + "'")
isBelly 	= false
sArea		= dwData.GetItemString(1, "cworkstation")

// -----------------------------------------
// dw_loadinglist_result "zerlegen"
// -----------------------------------------
of_analyse(dwData)

lStart = CPU()

For lRows = 1 to dwData.RowCount()
	
	// MHO 2014-02-07 (CBASE-UK-CR-2013-001): Kennzeichen, ob SPML-Label 
	// nach alter Methode oder neu mit Labeltypen nach Unitareas erstellt werden sollen
	if this.ii_SPML_LABEL_FROM_UNITAREAS = 1 then
		// Nichts tun. dwData ist schon um Label mit nprint_spml2 = 0 bereinigt worden
	else
		if dwData.GetItemNumber(lRows, "nprint") = 0 then 
			continue
		end if
	end if
	
	// -------------------------------------------------
	// Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert, dann Daten reinpacken
	// -------------------------------------------------
	lInsert = dsLayout.InsertRow(0)	
	
	dsLayout.SetItem(lInsert, "nobject_type", lInsert)
	dsLayout.SetItem(lInsert, "nbelly", 0)
	dsLayout.SetItem(lInsert, "carea", of_checknull(dwData.GetItemString(lRows, "carea")))
	dsLayout.SetItem(lInsert, "cworkstation", of_checknull(dwData.GetItemString(lRows, "cworkstation")))
	
		if this.ihasbarcode = 1 then
			
			ls_barcode_file =  f_gettemppath() + "cbase_barcode_" + string(lRows, "000") + "_" + string(cpu()) + ".bmp"
			dsLayout.SetItem(lInsert, "cfilename", ls_barcode_file)
			
			
			ls_barcode = of_create_barcode_information_spml_label(dwData, lRows, dwData.GetItemdatetime(lRows, "ddeparture"))	
		
			this.of_create_barcode(37, ls_barcode_file, ls_barcode, 120,120, 75)
						
		end if
	
	of_fill_spml_columns(lRows, lInsert, dwData)
	
Next

iRet = dsLayout.GetFullState(bBlob)
if iRet = -1 then
	return -13
end if

// f_print_datastore(dsLayout)
// -----------------------------------------------------------
// R$$HEX1$$fc00$$ENDHEX$$ckgabe: Array von uo_label_return - Objekten
// -----------------------------------------------------------
iRetCount ++				
uoResult[iRetCount] = Create uo_label_return
uoResult[iRetCount].bLabel = bBlob
uoResult[iRetCount].lLabeltype = lLabelType

uoResult[iRetCount].sLabel = sSPMLLabelType
uoResult[iRetCount].sLabelComment = ""
uoResult[iRetCount].sWorkstation = ""
uoResult[iRetCount].isBelly = isBelly
uoResult[iRetCount].iLabelSort = 1
uoResult[iRetCount].iLabelPageBreak = 1
uoResult[iRetCount].sGeneratedForPrinter = this.sGeneratedForPrinter

this.of_destroy_layout()
lEnde = CPU()

return 0
end function

public function integer of_label (datastore dwdata, integer iprintertype, integer ilabelsort, integer ilabelpagebreak, s_flight strflightinfo, ref uo_label_return strret[], ref str_bitmaps strbmp[]);// ------------------------------------------------------------------------------------
// 30.11.05
// 
// A L T E  of_label Funktion f$$HEX1$$fc00$$ENDHEX$$r Beladevorschau
// 
// ------------------------------------------------------------------------------------
// Erstellen der Labels
//
// Parameter:	dwdata 				dw_1 aus ou_loading_list
// 				iPrinterType		1 = Thermodrucker via Druckertreiber
//											2 = Normaler Drucker (auf Bogen)
//					sFlgnr				Flugnummer (Airline + Flugnummer + Suffix)
//					dDepDate				Abflugdatum
//					sDepTime				Abflugzeit
// 				strRet				Struktur vom Typ str_label_return
//											wird per Referenz $$HEX1$$fc00$$ENDHEX$$bergeben und gef$$HEX1$$fc00$$ENDHEX$$llt
//					ilabelsort			1 = Sortiere die Label nach Bereichen
//											2 = Sortiere die Label nach Galley
//											3 = Sortiere die Label nach Labeltyp innerhalb nach Bereichen
//
//
//	R$$HEX1$$fc00$$ENDHEX$$ckgabe:	 0		alle prima
//					-1		keine Daten in dwdata
//					-2		kein g$$HEX1$$fc00$$ENDHEX$$ltiges Label gefunden
//					-3		ung$$HEX1$$fc00$$ENDHEX$$ltiger Wert in iPrinterType
//					-4		Fehler beim ColumnObject
//					-5		Fehler beim LineObject
//					-6		Fehler beim RectangleObject
//					-7		Fehler beim TextObject
//					-8		Fehler beim BitmapObject
//					-9		Fehler im dsMaster kein oder mehr als ein Datensatz
//					-10	Fehler im dsObjects kein Datensatz
//					-11	Label hat keine Columns
// 				-12	Fehler beim erzeugen der Bitmaps
// 				-13	
// 				-14	Fehler keine Daten in SYS_LABEL_COLUMNS
// ------------------------------------------------------------------------------------
Datetime dtValid, dtSearch
Long lLabelType, lLastLabelType
Long lRows
Long lInsert
Long lFound
Blob bBlob
String sArea, sFilter
integer iRet
long	lPackinglistDetail
long	lPackinglistIndexKey
long	lPackinglistDetailKey
s_packinglist_detail	sLabelPLTexte
integer	i
Long 		lStart, lEnde
String	sWorkStation, sOut
String	ls_Column
Integer	li_Succ

long ll_height, ll_width

// dwdata.saveas("c:\temp\dwdata.xls", Excel5!, true)
// ------------------------------------------------------------------------------------
// Mal schaun, ob $$HEX1$$fc00$$ENDHEX$$berhaupt Daten drin sind
// ------------------------------------------------------------------------------------
if dwdata.RowCount() = 0 then
	of_log("Error -1, no data found, RowCount() on dwData = 0 ")
	return -1
end if
// ------------------------------------------------------------------------------------
// Alle wegfiltern, die nicht gedruckt werden sollen
// ------------------------------------------------------------------------------------
sFilter = dwData.Describe("datawindow.table.filter")


if sFilter = "?" then
	sFilter = ""
else
	sFilter += " and "
end if

dwData.SetFilter(sFilter + "nprint = 1")
dwData.Filter()

if dwdata.RowCount() = 0 then
	of_log("Error -1, no data found after filtering, RowCount() on dwData = 0 ")
	return -1
end if
// ------------------------------------------------------------------------------------
// Retrieve der Produktgruppen
// ------------------------------------------------------------------------------------	
dsProductGroup.Retrieve("002")

strFlight = strflightinfo

lStart = CPU()

// ------------------------------------------------------------------------------------
// Packing-List Detail in Loadinglist Result einarbeiten
// ------------------------------------------------------------------------------------
lLastLabelType = -1
For lRows = dwData.RowCount()	to 1 Step -1
	// -------------------------------------------------------
	// Pr$$HEX1$$fc00$$ENDHEX$$fung des Labeltypes, ob pldetail verwendet wurde.
	// -------------------------------------------------------
	lLabelType				= dwData.GetItemNumber(lRows,"cen_packinglists_nlabel_type_key")
	lPackinglistDetail 	= dsObjects.Find("ccolumn = 'pldetail'" , 1, dsObjects.RowCount())
	dtValid 					= of_find_valid_label(lLabelType, Datetime(Date(strFlightInfo.dtDepartureDate),Time("00:00:00")))
	If isnull(dtValid)  then
		continue
	End if
	If lLabelType <> lLastLabelType Then
		dsObjects.Retrieve(lLabelType, dtValid)
		lLastLabelType = lLabelType
	End if	
	
	// 20.10.2010 neu: explosion
	//lFound = dsObjects.Find("ccolumn = 'pldetail_text'",1, dsObjects.RowCount())
	lFound = dsObjects.Find("ccolumn = 'pldetail_text' OR ccolumn = 'pldetail_explosion' ",1, dsObjects.RowCount())
	
	// dwdata.saveas("c:\temp\cbase\davor.xls", Excel5!, true)
	
	If lFound > 0 Then
		lPackinglistIndexKey 	= dwData.GetItemNumber(lRows,"cen_packinglist_index_npackinglist_index_key")
		lPackinglistDetailKey	= dwData.GetItemNumber(lRows,"cen_packinglists_npackinglist_detail_key")
		ls_Column					= dsObjects.Getitemstring(lFound,"ccolumn")
		sPLFontname					= dsObjects.Getitemstring(lFound,"cfontname")
		iPLFontweight				= dsObjects.Getitemnumber(lFound,"nfontweight")
		iPLFontsize					= dsObjects.Getitemnumber(lFound,"nfontsize") * -1
		iPLObjectHeight			= dsObjects.Getitemnumber(lFound,"nheight")
		iuo_FontCalc.of_GetTextSize("Calculate", sPLFontName, iPLFontSize, false, false, false, ll_height, ll_width)
		iPLTextHeight = Integer(ll_height)
		this.ii_TextRowsIn_PLDETAIL = truncate(iPLObjectHeight  / (iPLTextHeight + 1), 0)
		
		// -------------------------------------------------------
		// Struktur mit Labeltexten f$$HEX1$$fc00$$ENDHEX$$llen
		// -------------------------------------------------------
		//sLabelPLTexte = of_create_pl_detail(lPackinglistIndexKey,lPackinglistDetailKey, strFlightInfo.dtDepartureDate)
		If ls_Column = "pldetail_text" Then
			sLabelPLTexte = of_create_pl_detail(lPackinglistIndexKey, lPackinglistDetailKey, strFlightInfo.dtDepartureDate)
		// 20.10.2010 Neu: Explosion "Explode item lists to lowest level"	
		// CBASE-NAM-CR-0029-Cart Diagram Add Req_Final
		ElseIf ls_Column = "pldetail_explosion" Then
			sLabelPLTexte = of_create_pl_explosion(lPackinglistIndexKey, lPackinglistDetailKey, strFlightInfo.dtDepartureDate)		
		Else
			sLabelPLTexte = of_create_pl_detail(lPackinglistIndexKey, lPackinglistDetailKey, strFlightInfo.dtDepartureDate)
		End if
		dwData.SetItem(lRows,"pldetail_text",sLabelPLTexte.cdetail_text[1])
		If ls_Column = "pldetail_explosion" Then
			li_Succ = dwData.SetItem(lRows,"pldetail_explosion",sLabelPLTexte.cdetail_text[1])
		End If
		dwData.SetItem(lRows,"pldetail_label_counter","1 of " + string(Upperbound(sLabelPLTexte.cdetail_text)))
		
		// -------------------------------------------------------
		// Sind Labels zu duplizieren ?
		// -------------------------------------------------------
		If Upperbound(sLabelPLTexte.cdetail_text) > 1 Then
			For i = 2 to Upperbound(sLabelPLTexte.cdetail_text)
				dwData.RowsCopy(lRows,lRows,Primary!,dwData,dwData.Rowcount() + 1,Primary!)
				dwData.SetItem(dwData.Rowcount(),"pldetail_text",sLabelPLTexte.cdetail_text[i])
				dwData.SetItem(dwData.Rowcount(),"pldetail_label_counter", string(i) + " of " + string(Upperbound(sLabelPLTexte.cdetail_text)))
//				// -------------------------------------------------------
//				// Issue 3001
//				// -------------------------------------------------------
//				If Upperbound(sLabelPLTexte.cdetail_text) > 9 then
//					dwData.SetItem(dwData.Rowcount(),"pldetail_label_counter", string(i, "00") + " of " + string(Upperbound(sLabelPLTexte.cdetail_text)))
//				End If				
				
				If ls_Column = "pldetail_explosion" Then
					li_Succ = dwData.SetItem(dwData.Rowcount(),"pldetail_explosion",sLabelPLTexte.cdetail_text[i])
				End If
				// ------------------------------------------------------------------
				// 26.02.07, KF
				// Verteilte Mahlzeiten auf dem zweiten Label nicht mehr anzeigen
				// ------------------------------------------------------------------
				dwData.SetItem(dwData.Rowcount(),"cdistributed_components", "")
				
			Next	
		End if	
	Else
		
		if of_checknull(dwData.GetItemString(lRows,"pldetail_label_counter")) = "" then
			dwData.SetItem(lRows,"pldetail_text"," ")
			dwData.SetItem(lRows,"pldetail_label_counter","1 of 1")			
		end if
		
	End if
		
Next 

//dwdata.saveas("c:\temp\cbase\danach.xls", Excel5!, true)



lLastLabelType		= 0
lLabelType			= 0

lEnde = CPU()

//of_log(String((lEnde - lStart) / 1000, "00.00") + " seconds getting pl details")

// ------------------------------------------------------------------------------------
// Daten sortieren 
// ------------------------------------------------------------------------------------
//Messagebox("", iLabelsort)
if iLabelSort = 3 then
	iRet = dwData.SetSort("cen_loadinglists_nbelly_container A, cen_packinglists_nlabel_type_key A, carea_code A, cen_stowage_nsort A, cen_packinglist_index_cpackinglist A pldetail_label_counter A")
elseif iLabelSort = 2 then
	iRet = dwData.SetSort("cen_loadinglists_nbelly_container A, cen_packinglists_nlabel_type_key A, cen_stowage_nsort A, cen_packinglist_index_cpackinglist A pldetail_label_counter A")
elseif iLabelSort = 1 then
	iRet = dwData.SetSort("cen_loadinglists_nbelly_container A, carea_code A, cen_packinglists_nlabel_type_key A, cen_stowage_nsort A, cen_packinglist_index_cpackinglist A pldetail_label_counter A")	
end if	

dwData.Sort()

if iRet = -1 then
	of_log("Error -1, wrong sort criteria")
	return -1
end if
// -----------------------------------------
// Columndefinitionen aus SYS_LABEL_COLUMNS
// -----------------------------------------
if dsColumns.Retrieve() <= 0 then
	of_log("Error -14, no data from SYS_LABEL_COLUMNS")
	return -1
end if
// -----------------------------------------
// Label bauen
// -----------------------------------------

lLabelType = dwData.GetItemNumber(1, "cen_packinglists_nlabel_type_key")
iRet = of_build_label(Date(strFlightInfo.dtDepartureDate), lLabelType, iPrinterType)
lLastLabelType = lLabelType

if iRet <> 0 then
	return iRet
end if

// -----------------------------------------
// Bilder blobben
// -----------------------------------------
iRet = of_create_pictures(strBMP)
if iRet <> 0 then
	return iRet
end if
// -----------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r den Spooler noch nen Namen geben
// -----------------------------------------
dsLayout.Modify("datawindow.print.documentname = 'Labelprint: " + strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber + " " + String(Date(strFlightInfo.dtDepartureDate)) + "/" + strFlightInfo.cDepartureTime + "'")
isBelly 	= of_isbelly(dwData.GetItemNumber(1, "cen_loadinglists_nbelly_container"))
sArea		= dwData.GetItemString(1, "carea_code")

// -----------------------------------------
// dw_loadinglist_result "zerlegen"
// -----------------------------------------
of_analyse(dwData)

lStart = CPU()

For lRows = 1 to dwData.RowCount()
	
	// -----------------------------------------------------------------
	// Achtung: Stationsauftrag
	// Nur die Packinglists ber$$HEX1$$fc00$$ENDHEX$$cksichtigen, die auch f$$HEX1$$fc00$$ENDHEX$$r die Station 
	// interessant sind.
	// -----------------------------------------------------------------
	if dwData.GetItemNumber(lRows, "stationinstruction") = 0 then
		continue
	end if

	// --------------------------------------------------------------------------------------------------------------------
	// Nachschaun, on sich der Labeltyp oder Belly ge$$HEX1$$e400$$ENDHEX$$ndert hat
	// dann ggf. neues Layout (kompl. Reset auf dsLayout und neu Zeichnen)
	// --------------------------------------------------------------------------------------------------------------------
	//
	// Was macht das folgende IF ???
	//
	// 1. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Sortierung nach Galley = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + iLabelSort = 2
	//
	// 2. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Area unver$$HEX1$$e400$$ENDHEX$$ndert + Sortierung nach Area = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + sArea = dwDat..  + iLabelSort = 1
	//
	// 3. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Area VER$$HEX1$$c400$$ENDHEX$$NDERT + Sortierung nach Area + Areas fortlaufend = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + sArea <> dwDat.+ iLabelSort = 1       + iLabelPageBreak = 0
	//
	// --------------------------------------------------------------------------------------------------------------------
		
	if (	lLabelType = dwData.GetItemNumber(lRows, "cen_packinglists_nlabel_type_key") and &
			of_isbelly(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")) = isBelly and &
			iLabelSort = 2 &
		) 	&
		or &
		(	lLabelType = dwData.GetItemNumber(lRows, "cen_packinglists_nlabel_type_key") and &
			of_isbelly(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")) = isBelly and &
			sArea = dwData.GetItemString(lRows, "carea_code") and &
			(iLabelSort = 1 or iLabelSort = 3)&
		) &
		or &
		(	lLabelType = dwData.GetItemNumber(lRows, "cen_packinglists_nlabel_type_key") and &
			of_isbelly(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")) = isBelly and &
			dwData.GetItemString(lRows, "carea_code") <> sArea and &
			(iLabelSort = 1 or iLabelSort = 3) and &
			iLabelPageBreak = 0 &
		) &
		then  
		
		// -------------------------------------------------
		// Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert, dann Daten reinpacken
		// -------------------------------------------------
		
		lInsert = dsLayout.InsertRow(0)	
		
		dsLayout.SetItem(lInsert, "nobject_type", lInsert)
		dsLayout.SetItem(lInsert, "nbelly", of_checknull(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")))
		dsLayout.SetItem(lInsert, "carea", of_checknull(dwData.GetItemString(lRows, "carea")))
		dsLayout.SetItem(lInsert, "cworkstation", of_checknull(dwData.GetItemString(lRows, "cworkstation")))
		
		of_fill_columns(lRows, &
							 lInsert, &
							 dwData, &
							 strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber, &
							 Date(strFlightInfo.dtDepartureDate), &
							 strFlightInfo.cDepartureTime, &
							 strFlightInfo.sDestination, &
							 strFlightInfo.sOwner + " " + strFlightInfo.sActype , &
							 strFlightInfo.sConfiguration, &
							 strFlightInfo.sDeparture )

	else
		// -------------------------------------------------------------------
		// Labeltyp oder Belly hat sich ge$$HEX1$$e400$$ENDHEX$$ndert, den Datastore (dsLayout)
		// in das UserObject packen und den neuen Labeltyp bauen
		// -------------------------------------------------------------------
		iRet = dsLayout.GetFullState(bBlob)
		
		if iRet = -1 then
			return -13
		end if
		
		iRetCount ++		
		strRet[iRetCount] = Create uo_label_return
		strRet[iRetCount].llabeltype = lLabelType
		strRet[iRetCount].bLabel = bBlob					// alle Label eines Labeltyps

		if isBelly then
			strRet[iRetCount].sLabel = sLabel + " (Belly)" 
		else
			strRet[iRetCount].sLabel = sLabel
		end if
		
		strRet[iRetCount].sLabelComment = sArea
		strRet[iRetCount].sWorkstation	= sWorkStation
		strRet[iRetCount].isBelly = isBelly
		strRet[iRetCount].iLabelSort = iLabelSort
		strRet[iRetCount].iLabelPageBreak = iLabelPageBreak		
		strRet[iRetCount].sGeneratedForPrinter = this.sGeneratedForPrinter
		// -----------------------------------------------------------
		// Neuen Label-Typ zeichnen, wenn er sich ge$$HEX1$$e400$$ENDHEX$$ndert hat
		// -----------------------------------------------------------
		lLabelType = dwData.GetItemNumber(lRows, "cen_packinglists_nlabel_type_key") 
		isBelly = of_isbelly(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container"))
		
		if lLabelType <> lLastLabelType or isBelly = True then
		
			iRet = of_build_label(date(strFlightInfo.dtDepartureDate), lLabelType, iPrinterType)
			
			if iRet <> 0 then
				return iRet
			end if
			
			lLastLabelType = lLabelType 
			
		else
			
			this.of_destroy_layout()
			dsLayout.Reset()
			
		end if
		
		lInsert = dsLayout.InsertRow(0)	
		dsLayout.SetItem(lInsert, "nobject_type", lInsert)
		dsLayout.SetItem(lInsert, "nbelly", of_checknull(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")))
		dsLayout.SetItem(lInsert, "carea", of_checknull(dwData.GetItemString(lRows, "carea")))
		dsLayout.SetItem(lInsert, "cworkstation", of_checknull(dwData.GetItemString(lRows, "cworkstation")))
		
		of_fill_columns(lRows, &
							 lInsert, &
							 dwData, &
							 strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber, &
							 Date(strFlightInfo.dtDepartureDate), &
							 strFlightInfo.cDepartureTime, &
							 strFlightInfo.sDestination, &
							 strFlightInfo.sOwner + " " + strFlightInfo.sActype , &
							 strFlightInfo.sConfiguration, &
							 strFlightInfo.sDeparture )	
		
	end if

	sArea 			= dwData.GetItemString(lRows, "carea_code")
	sWorkStation 	= dwData.GetItemString(lRows, "cworkstation_text")
	f_yield(lRoleID)		
	//messagebox("DANACH !!!!!!!!!!!!!", "Zeile " + string(lRows) + " von " + string(dwData.RowCount()))

Next


iRet = dsLayout.GetFullState(bBlob)
if iRet = -1 then
	return -13
end if

// messagebox("DANACH !!!!!!!!!!!!!", "1")
// -----------------------------------------------------------
// R$$HEX1$$fc00$$ENDHEX$$ckgabe: Array von uo_label_return - Objekten
// -----------------------------------------------------------
iRetCount ++				
strRet[iRetCount] = Create uo_label_return
strRet[iRetCount].bLabel = bBlob
strRet[iRetCount].lLabeltype = lLabelType

if isBelly then
	strRet[iRetCount].sLabel = sLabel + " (Belly)" 
else
	strRet[iRetCount].sLabel = sLabel
end if

strRet[iRetCount].sLabelComment = sArea
strRet[iRetCount].sWorkstation = sWorkstation
strRet[iRetCount].isBelly = isBelly
strRet[iRetCount].iLabelSort = iLabelSort
strRet[iRetCount].iLabelPageBreak = iLabelPageBreak
strRet[iRetCount].sGeneratedForPrinter = this.sGeneratedForPrinter

lEnde = CPU()
//of_log(String((lEnde - lStart) / 1000, "00.00") + " building all Labels")


return 0
end function

public function s_packinglist_detail of_create_pl_detail (long lindex_key, long ldetail_key, datetime dtdeparture);integer 	i,lCounter
long 		lQuantity
string	cText,sQuantity
string	cLabelText
integer	iTextCounter 	= 0
integer	iLabelCounter	= 1
long		lProductGroup
s_packinglist_detail	sLabelPLTexte
// ----------------------------------------
// Erstellung der Packinglist Detail Texte
// ----------------------------------------
dsPackinglistDetail.Retrieve(lIndex_key,lDetail_key, dtdeparture)
sLabelPLTexte.cdetail_text[1] = "no items available"

cLabelText 		= ""
iTextCounter 	= 0
For i = 1 to dsPackinglistDetail.Rowcount()
	lProductGroup = dsPackinglistDetail.Getitemnumber(i,"nproduct_index_key")
	// ---------------------------------------------------
	// Soll dieser Artikel aufs Label gedruckt werden ?
	// ---------------------------------------------------
	If of_isproduct_group(lProductGroup) = False Then
		continue
	End if	
		
	iTextCounter 	++
	lQuantity 		= dsPackinglistDetail.Getitemnumber(i,"compute_3")
	cText				= dsPackinglistDetail.Getitemstring(i,"cen_packinglists_ctext") + "~n"

	If len(string(lQuantity)) = 1 Then
		sQuantity = "  " + string(lQuantity)
	ElseIf len(string(lQuantity)) = 2 Then	
		sQuantity = " " + string(lQuantity)
	Else
		sQuantity = string(lQuantity)
	End if	
	cLabelText +=  sQuantity + " " + cText
	sLabelPLTexte.cdetail_text[iLabelCounter] = cLabelText
	// ----------------------------------------
	// Neues Sub-Label starten
	// ----------------------------------------
	If iTextCounter = this.ii_TextRowsIn_PLDETAIL Then
		iTextCounter 	= 0
		iLabelCounter ++
		cLabelText 		= ""
	End if	
Next	

Return sLabelPLTexte


		  
end function

public function s_packinglist_detail of_create_pl_explosion (long al_index_key, long al_detail_key, datetime dtdeparture);
/*
* Objekt : uo_label_other
* Methode: of_create_pl_explosion (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 19.10.2010
*
* Argument(e):
* long lindex_key
*	 long ldetail_key
*	 datetime dtdeparture
*
* Beschreibung:		Neue Label-Column f$$HEX1$$fc00$$ENDHEX$$r Label "Content Spec" (CR Cart Diagram)
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	19.10.2010		Erstellung
*
*
* Return: s_packinglist_detail
*
*/

integer 	i,lCounter
long 		ll_Quantity
string	ls_Text, ls_Quantity
string	ls_LabelText
integer	li_TextCounter 	= 0
integer	li_LabelCounter	= 1
String	ls_unit
//long		lProductGroup
Long		ll_Rows
s_packinglist_detail	lstr_LabelPLTexte

// ----------------------------------------
// Erstellung der Packinglist Detail Texte
// ----------------------------------------
ll_Rows = dsPackinglistExplosion.Retrieve(al_Index_key, dtdeparture)
lstr_LabelPLTexte.cdetail_text[1] = "no items available"

ls_LabelText 		= ""
li_TextCounter 	= 0
For i = 1 to dsPackinglistExplosion.Rowcount()
//	lProductGroup = dsPackinglistExplosion.Getitemnumber(i,"nproduct_index_key")
//	// ---------------------------------------------------
//	// Soll dieser Artikel aufs Label gedruckt werden ?
//	// ---------------------------------------------------
//	If of_isproduct_group(lProductGroup) = False Then
//		continue
//	End if	
		
	li_TextCounter 	++
	ll_Quantity 		= dsPackinglistExplosion.Getitemnumber(i,"nquantity")
	ls_unit				= dsPackinglistExplosion.Getitemstring(i,"cunit")  
	ls_Text				= dsPackinglistExplosion.Getitemstring(i,"ctext") + "~n"

	If len(string(ll_Quantity)) = 1 Then
		ls_Quantity = "  " + string(ll_Quantity)
	ElseIf len(string(ll_Quantity)) = 2 Then	
		ls_Quantity = " " + string(ll_Quantity)
	Else
		ls_Quantity = string(ll_Quantity)
	End if	
	
	// Einheit
	If len(ls_unit) = 1 Then
		ls_unit = "  " + ls_unit
	ElseIf len(ls_unit) = 2 Then	
		ls_unit = " " + ls_unit
	Else
		//ls_unit = string(ll_Quantity)
	End if	
	
//	ls_LabelText +=  ls_Quantity + " " + ls_Text
	ls_LabelText +=  ls_Quantity + " " + ls_unit + " " + ls_Text
	lstr_LabelPLTexte.cdetail_text[li_LabelCounter] = ls_LabelText
	// ----------------------------------------
	// Neues Sub-Label starten
	// ----------------------------------------
	If li_TextCounter = this.ii_TextRowsIn_PLDETAIL Then
		li_TextCounter 	= 0
		li_LabelCounter ++
		ls_LabelText 		= ""
	End if	
Next	

Return lstr_LabelPLTexte


		  
end function

public function integer of_fill_columns (long lrowdata, long lrowinsert, datastore odw, string sflgnr, date ddepdate, string stime, string sdestination, string sactype, string sconfiguration, string sdeparture);
/*
* Objekt: 	uo_label_other
* Methode:	of_fill_columns (Function)
*
* Argument(e):
* 		lRowData 			Zeile
* 		lRowInsert 			Zeile
* 		oDW 					Daten
* 		sFlgnr					Flugnummer (Airline + Flugnummer + Suffix)
* 		dDepDate			Abflugdatum
* 		sTime					Abflugzeit
* 		sDestination			Zielort (tlc_to)
* 		sACType				AC-Type
* 		sConfiguration		Konfiguration
* 		sDeparture			Abflugort (tlc_from)
*
*
* Beschreibung:		Die Columns mit Werten f$$HEX1$$fc00$$ENDHEX$$llen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				??? 				xx.xx.xxxx		Erstellung
* 1.1 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		30.05.2012		bestbefore erg$$HEX1$$e400$$ENDHEX$$nzt
*
*
* Return: integer
*	0 	alles geklappt
*	-1 fehler
*/

// hilfsvariable
datetime 	ldt_BestBefore

ldt_BestBefore = datetime(dDepDate, time(sTime))

return this.of_fill_columns(lRowData, lRowInsert, oDW, sFlgNr, dDepDate, sTime, sDestination, sACType, sConfiguration, sDeparture, ldt_BestBefore)

end function

public function integer of_fill_columns (long lrowdata, long lrowinsert, datastore odw, string sflgnr, date ddepdate, string stime, string sdestination, string sactype, string sconfiguration, string sdeparture, datetime adt_bestbefore);
/*
* Objekt: 	uo_label_other
* Methode:	of_fill_columns (Function)
*
* Argument(e):
* 		lRowData 			Zeile
* 		lRowInsert 			Zeile
* 		oDW 					Daten
* 		sFlgnr					Flugnummer (Airline + Flugnummer + Suffix)
* 		dDepDate			Abflugdatum
* 		sTime					Abflugzeit
* 		sDestination			Zielort (tlc_to)
* 		sACType				AC-Type
* 		sConfiguration		Konfiguration
* 		sDeparture			Abflugort (tlc_from)
* 		adt_BestBefore		Best Before Zeitpunkt
*
*
* Beschreibung:		Die Columns mit Werten f$$HEX1$$fc00$$ENDHEX$$llen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 			??? 				xx.xx.xxxx		Erstellung
* 1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel 		30.05.2012		bestbefore erg$$HEX1$$e400$$ENDHEX$$nzt
* 1.2 			M.N$$HEX1$$fc00$$ENDHEX$$ndel 		31.05.2012		distributed_rtn_components eingebaut
* 1.3				M.Barfknecht	31.08.2012		eq_components eingebaut
* 1.4          D.Bunk         15.11.2012     Alte PBAcorbat Funktionen gegen neue getauscht
* 1.5          O.Hoefer    	20.04.2015     5.10 Issue #24: 4-Leg Flug (flugnummer2leg)
* 1.6          O.Hoefer    	14.02.2020     #5955 crancho_number
*
* Return: integer
*	0 	alles geklappt
*	-1 fehler
*/

// hilfsvariable

// --------------------------------------------------
// Die Columns mit Werten f$$HEX1$$fc00$$ENDHEX$$llen
// --------------------------------------------------
str_label_print 		lstr_LabelPrint[]

s_distribution_text	lstr_Values[], lstr_Empty[]

string 					sValue

integer 				iCount, &
						iFontSize, &
						iStartSize, &
						iItems

long 					lColumns, &
						lFound, &
						lWidth, &
						lHeight, &
						lForTo, &
						lCheck, &
						lLeg
						
string 				sObject, &
						sColumn, &
						sFont, &
						sFindColumn,skitchendatetime,srampboxdatetime

boolean lb_Bold, lb_Italic, lb_Underline, lb_Wrap
boolean lb_concat_cateringleg // MHO 2014-01-28 / CBASE-NAM-CR-13051

// das objekt zum zeichnen (f$$HEX1$$fc00$$ENDHEX$$r die anpassungen bei den additional items rtn)
uo_draw_objects 	luo_DrawObjects

// ---------------------------------------------------------------
// Erstmal die "spezial" Columns in die Struktur schreiben.
// Das sind alle, welche in der Tabelle SYS_LABEL_COLUMNS
// nexternal auf 1 gesetzt haben
// ---------------------------------------------------------------
iCount ++

lstr_LabelPrint[iCount].cColumn = "flugnummer"
lstr_LabelPrint[iCount].nExternal = 0
lstr_LabelPrint[iCount].ncalculate_size = 1

if sWhereAmI <> "WEB" then	
	lLeg = oDW.GetItemNumber(lRowData, "ncatering_leg")
	if isnull(lLeg) then lLeg = 1
	if lLeg <= 0 then lLeg = 1 // 05.03.2019 HR: Integer$$HEX1$$fc00$$ENDHEX$$berlauf korrigieren
	
	if lLeg = 1 then
		lstr_LabelPrint[iCount].cValue = sFlgnr
	else
		// ---------------------------------------------------------
		// Bei einem Catering-Leg > 1 die R$$HEX1$$fc00$$ENDHEX$$ck-/Weiterflugnummer
		// andrucken ....
		// ---------------------------------------------------------
		if lLeg <= UpperBound(this.iLegs) and UpperBound(this.iLegs) > 0 then
			lstr_LabelPrint[iCount].cValue = sFlgnr + "/" + string(this.iLegs[lLeg], "000")
		else
			lstr_LabelPrint[iCount].cValue = sFlgnr
		end if
		
	end if
else
	lstr_LabelPrint[iCount].cValue = sFlgnr
end if
	
// ---------------------------------------------------------
// Neues Flugnummerfeld: Bei 2-Leg-Fl$$HEX1$$fc00$$ENDHEX$$gen IMMER beide Flugnummern anzeigen
// MHO 2014-01-28 / CBASE-NAM-CR-13051
// ---------------------------------------------------------

iCount ++

lstr_LabelPrint[iCount].cColumn = "flugnummer2leg"
lstr_LabelPrint[iCount].nExternal = 0
lstr_LabelPrint[iCount].ncalculate_size = 1

lb_concat_cateringleg =  FALSE // Ist schon ein weiteres Leg angef$$HEX1$$fc00$$ENDHEX$$gt worden?

// Zuerst normale Funktionalit$$HEX1$$e400$$ENDHEX$$t: Abh$$HEX1$$e400$$ENDHEX$$ngig von den Eintr$$HEX1$$e400$$ENDHEX$$gen in der Ranking Loading List
// werden hier Folge-Legs im Flugnummerntext mit angef$$HEX1$$fc00$$ENDHEX$$gt.
if sWhereAmI <> "WEB" then
	lLeg = oDW.GetItemNumber(lRowData, "ncatering_leg")
	if isnull(lLeg) then lLeg = 1
	if lLeg <= 0 then lLeg = 1  // 05.03.2019 HR: Integer$$HEX1$$fc00$$ENDHEX$$berlauf korrigieren
	
	if lLeg = 1 then
		lstr_LabelPrint[iCount].cValue = sFlgnr
	else
		// ---------------------------------------------------------
		// Bei einem Catering-Leg > 1 die R$$HEX1$$fc00$$ENDHEX$$ck-/Weiterflugnummer
		// andrucken ....
		// ---------------------------------------------------------
		if lLeg <= UpperBound(this.iLegs) and UpperBound(this.iLegs) > 0 then
			lstr_LabelPrint[iCount].cValue = sFlgnr + "/" + string(this.iLegs[lLeg], "000")
			lb_concat_cateringleg = TRUE  // Ein Leg ist hier schon angef$$HEX1$$fc00$$ENDHEX$$gt worden
		else
			lstr_LabelPrint[iCount].cValue = sFlgnr
		end if
		
	end if
else
	lstr_LabelPrint[iCount].cValue = sFlgnr
end if

// Haben wir im Flugnummertext noch kein weiteres Leg als Text angef$$HEX1$$fc00$$ENDHEX$$gt, 
// wird hier f$$HEX1$$fc00$$ENDHEX$$r 2-Leg-Fl$$HEX1$$fc00$$ENDHEX$$ge in jedem Fall das zweite Leg angef$$HEX1$$fc00$$ENDHEX$$gt
if NOT lb_concat_cateringleg then
	// handelt es sich um einen 2-Leg-Flug, dann die Flugnummer des zweiten Legs anf$$HEX1$$fc00$$ENDHEX$$gen
	//if UpperBound(this.iLegs) = 2 then
	// 20.4.15 5.10 Issue #24: 4-Leg Flug
	if UpperBound(this.iLegs) >= 2 then
		lstr_LabelPrint[iCount].cValue = sFlgnr + "/" + string(this.iLegs[2], "000")
	end if
end if

// --------------------------------------------

iCount ++
lstr_LabelPrint[iCount].cColumn = "datum"
lstr_LabelPrint[iCount].cValue = String(dDepDate)
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

iCount ++
lstr_LabelPrint[iCount].cColumn = "tag"
lstr_LabelPrint[iCount].cValue = String(day(dDepDate), "00")
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

iCount ++
lstr_LabelPrint[iCount].cColumn = "monat"
lstr_LabelPrint[iCount].cValue = String(month(dDepDate), "00")
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

iCount ++
lstr_LabelPrint[iCount].cColumn = "jahr4"
lstr_LabelPrint[iCount].cValue = String(dDepDate, "yyyy")
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

iCount ++
lstr_LabelPrint[iCount].cColumn = "jahr2"
lstr_LabelPrint[iCount].cValue = String(dDepDate, "yy")
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

iCount ++
lstr_LabelPrint[iCount].cColumn = "timedeparture"
lstr_LabelPrint[iCount].cValue = sTime
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

iCount ++
lstr_LabelPrint[iCount].cColumn = "destination"
lstr_LabelPrint[iCount].cValue = sDestination
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0
lstr_LabelPrint[iCount].ncalculate_size = 0

iCount ++
lstr_LabelPrint[iCount].cColumn = "timeprint"
lstr_LabelPrint[iCount].cValue = String(now(), "hh:mm:ss")
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

iCount ++
lstr_LabelPrint[iCount].cColumn = "dateprint"
lstr_LabelPrint[iCount].cValue = String(Today())
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

iCount ++
lstr_LabelPrint[iCount].cColumn = "actype"
lstr_LabelPrint[iCount].cValue = sActype
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

iCount ++
lstr_LabelPrint[iCount].cColumn = "configuration"
lstr_LabelPrint[iCount].cValue = sConfiguration
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

iCount ++
lstr_LabelPrint[iCount].cColumn = "rampbox"
lstr_LabelPrint[iCount].cValue = this.sRampBox
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

iCount ++
lstr_LabelPrint[iCount].cColumn = "ramptime"
lstr_LabelPrint[iCount].cValue = this.sRampTime
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

iCount ++
lstr_LabelPrint[iCount].cColumn = "kitchentime"
lstr_LabelPrint[iCount].cValue = this.sKitchenTime
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

//Kitchendatetime
iCount ++
lstr_LabelPrint[iCount].cColumn = "kitchendatetime"
if time(this.sKitchenTime) < time(stime) then
	skitchendatetime =string(dDepDate)+" "+this.sKitchenTime
else
	skitchendatetime =string(Relativedate(dDepDate,-1))+" "+this.sKitchenTime
end if
lstr_LabelPrint[iCount].cValue = skitchendatetime
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0
//Rampboxdatetime
iCount ++
lstr_LabelPrint[iCount].cColumn = "rampboxdatetime"
if time(this.sRampTime) < time(stime) then
	srampboxdatetime =string(dDepDate)+" "+this.sRampTime
else
	srampboxdatetime =string(Relativedate(dDepDate,-1))+" "+this.sRampTime
end if
lstr_LabelPrint[iCount].cValue = srampboxdatetime
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0


// 2011-08-16 "FROM"
iCount ++
lstr_LabelPrint[iCount].cColumn = "departure"
lstr_LabelPrint[iCount].cValue = sDeparture
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

// 2011-08-22 "FROM",. aber diesmal richtig
if sWhereAmI <> "WEB" then
	iCount ++
	lstr_LabelPrint[iCount].cColumn = "routing"
	lstr_LabelPrint[iCount].nExternal = 1
	lLeg = oDW.GetItemNumber(lRowData, "ncatering_leg")
	if isnull(lLeg) then lLeg = 1
	if lLeg <= 0 then lLeg = 1  // 05.03.2019 HR: Integer$$HEX1$$fc00$$ENDHEX$$berlauf korrigieren
	// ---------------------------------------------------------
	// Catering-Leg > 1: Routing = From + "-" +To
	// ---------------------------------------------------------
	if lLeg <= UpperBound(this.iLegs) and UpperBound(this.iLegs) > 0 then
		lstr_LabelPrint[iCount].cValue = is_Leg_Routing_From[lLeg] + "-" + is_Leg_Routing_To[lLeg]
	else
		lstr_LabelPrint[iCount].cValue = is_Leg_Routing_From[1] + "-" + is_Leg_Routing_To[1]
	end if
else
	lstr_LabelPrint[iCount].cValue = sFlgnr
end if

iCount ++
lstr_LabelPrint[iCount].cColumn = "fortocode"
lForTo = oDW.GetItemNumber(lRowData, "cen_loadinglists_nfor_to_code")
if lForTo = 0 then
	lstr_LabelPrint[iCount].cValue = ""
elseif lForTo = 1 then
	lstr_LabelPrint[iCount].cValue = "for " + of_checknull(oDW.GetItemString(lRowData, "sys_three_letter_codes_ctlc"))
else
	lstr_LabelPrint[iCount].cValue = "to " + of_checknull(oDW.GetItemString(lRowData, "sys_three_letter_codes_ctlc"))
end if
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

// 2012-05-29 MNu best before (kitchentime + xxx minutes)
iCount ++
lstr_LabelPrint[iCount].cColumn = "best_before"
lstr_LabelPrint[iCount].cValue = string(date(adt_BestBefore)) + " " + String(time(adt_BestBefore), "hh:mm")
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

// 2013-01-13 MB Healthmark f$$HEX1$$fc00$$ENDHEX$$r UK (Header, Detail, Footer)



iCount ++
lstr_LabelPrint[iCount].cColumn = "healthmark_header"
lstr_LabelPrint[iCount].cValue = ishealthmark_header
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0
iCount ++
lstr_LabelPrint[iCount].cColumn = "healthmark_detail"
lstr_LabelPrint[iCount].cValue = ishealthmark_detail
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0
iCount ++
lstr_LabelPrint[iCount].cColumn = "healthmark_footer"
lstr_LabelPrint[iCount].cValue = ishealthmark_footer
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0
//MB 02.06.2014: Registration
iCount ++
lstr_LabelPrint[iCount].cColumn = "registration"
lstr_LabelPrint[iCount].cValue = of_get_registration()
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0

// --------------------------------------------------
// #5955 Rancho Nr
// --------------------------------------------------
iCount ++
lstr_LabelPrint[iCount].cColumn = "crancho_number"
lstr_LabelPrint[iCount].cValue = is_rancho_number
lstr_LabelPrint[iCount].nExternal = 1
lstr_LabelPrint[iCount].ncalculate_size = 0


// --------------------------------------------------
// dann alle anderen in die Struktur schreiben ...
// --------------------------------------------------
// schleife $$HEX1$$fc00$$ENDHEX$$ber alle objecte
for lColumns = 1 to dsColumns.RowCount()
	
	// --------------------------------------------------
	// ... aber nur, wenn es die Column im Datastore gibt
	// --------------------------------------------------
	sFindColumn = dsColumns.GetItemString(lColumns, "ccolumn")
	lCheck = dsLoadinglistColumns.Find("sobject = '" + sFindColumn + "'", 1, dsLoadinglistColumns.RowCount())
	
	if lCheck <= 0 then continue
	
	iCount ++
	lstr_LabelPrint[iCount].cColumn = dsColumns.GetItemString(lColumns, "ccolumn")
	
	if mid(oDW.Describe(lstr_LabelPrint[iCount].cColumn + ".coltype"), 1, 4) = "char" then
		lstr_LabelPrint[iCount].cValue = of_checknull(oDW.GetItemString(lRowData, lstr_LabelPrint[iCount].cColumn))
	elseif oDW.Describe(lstr_LabelPrint[iCount].cColumn + ".coltype") = "datetime" then
		lstr_LabelPrint[iCount].cValue = String(oDW.GetItemDateTime(lRowData, lstr_LabelPrint[iCount].cColumn))
	else		
		lstr_LabelPrint[iCount].cValue = String(oDW.GetItemNumber(lRowData, lstr_LabelPrint[iCount].cColumn))
	end if
		
	lstr_LabelPrint[iCount].nExternal = 0
	lstr_LabelPrint[iCount].ncalculate_size = dsColumns.GetItemNumber(lColumns, "ncalculate_size")
	
next

// --------------------------------------------------
// und zum Schlu$$HEX2$$df002000$$ENDHEX$$die Werte ins Label eintragen !!!
// --------------------------------------------------
// schleife $$HEX1$$fc00$$ENDHEX$$ber alle objecte
for lColumns = 1 to dsObjects.RowCount() step 1
	// --------------------------------------------------
	// erstmal schaun, ob es ne column ist
	// --------------------------------------------------
	if dsObjects.GetItemNumber(lColumns, "nobject_type") <> 1 then continue
		
	// --------------------------------------------------
	// wenn ja, den Objekt und Columnnamen merken
	// --------------------------------------------------
	sObject = dsObjects.GetItemString(lColumns, "cobject_name")
	sColumn = dsObjects.GetItemString(lColumns, "ccolumn")
		
	// --------------------------------------------------
	// Nun noch die Column in der Struktur suchen
	// und ins Label eintragen
	// --------------------------------------------------
	// schleife $$HEX1$$fc00$$ENDHEX$$ber alle columns
	for iCount = 1 to UpperBound(lstr_LabelPrint) step 1
		// aktuelle column gefunden ?
		if lstr_LabelPrint[iCount].cColumn = sColumn then
				
			// --------------------------------------------------
			// Spezialfelder (wie z.B. cdistributed_components) 
			// bekommen eine besondere Behandlung
			// --------------------------------------------------
			choose case sColumn

					case COL_DISTRIBUTED_COMP
							// frisch initialisieren
							lstr_Values = lstr_Empty
							// daten aufsplitten: in die einzelnen columns und zeilen (1:menge, 2:text, 3:packinglist)
							//messagebox("DAVOR !!!!!!!!!!!!!", of_checknull(lstr_LabelPrint[iCount].cValue))
							of_split_distribution_text(lstr_LabelPrint[iCount].cValue, lstr_Values)
							// messagebox("D A N A C H !!!!!!!!!!!!!", UpperBound(lstr_Values))

							// zeilenweise aus dem array ins DS einf$$HEX1$$fc00$$ENDHEX$$llen
							for iItems = 1 to UpperBound(lstr_Values) step 1
								//Messagebox("", lstr_Values[iItems].sQuantity)
								dsLayout.SetItem(lRowInsert, "npl_quantity_" + String(iItems), lstr_Values[iItems].sQuantity)
								dsLayout.SetItem(lRowInsert, "npl_prod_text_" + String(iItems), lstr_Values[iItems].sText)
								dsLayout.SetItem(lRowInsert, "npl_number_" + String(iItems), lstr_Values[iItems].sPackinglist)
								
								if iMealcodeWrapped = 1 and iShowMealCode = 1 then
									
									//Mealcode anzeigen
									dsLayout.SetItem(lRowInsert, "npl_mealcode_" + String(iItems), lstr_Values[iItems].smealcode)
									
								end if
								
							next

					case COL_RTN_COMP
							// frisch initialisieren
							lstr_Values = lstr_Empty
							// daten aufsplitten: in die einzelnen columns und zeilen (1:menge, 2:text, 3:einheit)
							//messagebox("DAVOR !!!!!!!!!!!!!", of_checknull(lstr_LabelPrint[iCount].cValue))
							of_split_distribution_old(lstr_LabelPrint[iCount].cValue, lstr_Values)
							// messagebox("D A N A C H !!!!!!!!!!!!!", UpperBound(lstr_Values))

							// zeilenweise aus dem array ins DS einf$$HEX1$$fc00$$ENDHEX$$llen
							for iItems = 1 to UpperBound(lstr_Values) step 1
								// wegschreiben
								dsLayout.SetItem(lRowInsert, istr_RTN[3].is_ObjectName + "_" + String(iItems), lstr_Values[iItems].sQuantity)
								dsLayout.SetItem(lRowInsert, istr_RTN[2].is_ObjectName + "_" + String(iItems), lstr_Values[iItems].sText)
								dsLayout.SetItem(lRowInsert, istr_RTN[1].is_ObjectName + "_" + String(iItems), lstr_Values[iItems].sPackinglist)
							next
							
					case COL_EQ_COMP
							// frisch initialisieren
							lstr_Values = lstr_Empty
							// daten aufsplitten: in die einzelnen columns und zeilen (1:menge, 2:text, 3:einheit)
							//messagebox("DAVOR !!!!!!!!!!!!!", of_checknull(lstr_LabelPrint[iCount].cValue))
							of_split_distribution_old(lstr_LabelPrint[iCount].cValue, lstr_Values)
							// messagebox("D A N A C H !!!!!!!!!!!!!", UpperBound(lstr_Values))

							// zeilenweise aus dem array ins DS einf$$HEX1$$fc00$$ENDHEX$$llen
							for iItems = 1 to UpperBound(lstr_Values) step 1
								// wegschreiben
								dsLayout.SetItem(lRowInsert, istr_EQ[3].is_ObjectName + "_" + String(iItems), lstr_Values[iItems].sQuantity)
								dsLayout.SetItem(lRowInsert, istr_EQ[2].is_ObjectName + "_" + String(iItems), lstr_Values[iItems].sText)
								dsLayout.SetItem(lRowInsert, istr_EQ[1].is_ObjectName + "_" + String(iItems), lstr_Values[iItems].sPackinglist)
							next


					// kein sonderfall
					case else						
						
							// zeilenumbruch ?
							lb_Wrap = (dsObjects.GetItemNumber(lColumns, "nwrap") = 1)
							if lb_Wrap then 
								sValue = this.of_wrap(lstr_LabelPrint[iCount].cValue, 12, 5, 4)
							else
								sValue = lstr_LabelPrint[iCount].cValue
							end if
							
							// wert eintragen
							dsLayout.SetItem(lRowInsert, sObject, sValue)
							
							// optik setzen
							lFound = dsColumns.Find("ccolumn='" + dsObjects.GetItemString(lColumns, "ccolumn") + "'", 1, dsColumns.RowCount())
							if lFound > 0 then
								if dsColumns.GetItemNumber(lFound, "ncalculate_size") = 1 then									
									lHeight = Long(dsLayout.Describe(sObject + ".height"))
									lWidth = Long(dsLayout.Describe(sObject + ".width"))
									sFont = dsLayout.Describe(sObject + ".font.face")
									iStartSize = dsObjects.GetItemNumber(lColumns, "nfontsize") * -1
									
									// Die optimale Schriftgr$$HEX2$$f600df00$$ENDHEX$$e ermitteln
									lb_Bold = (dsObjects.GetItemNumber(lColumns, "nfontweight") = 700)
									lb_Italic = (dsObjects.GetItemNumber(lColumns, "nfontitalic") = 1)
									lb_Underline = (dsObjects.GetItemNumber(lColumns, "nfontunderline") = 1)
									iuo_FontCalc.of_GetOptFontSize(sValue, sFont, iFontSize, lb_Bold, lb_Italic, lb_Underline, lHeight, lWidth, false)
									
									// Wenn die optimale Schriftgr$$HEX2$$f600df00$$ENDHEX$$e gr$$HEX2$$f600df00$$ENDHEX$$er ist, als die Start-Schriftgr$$HEX2$$f600df00$$ENDHEX$$e, nehmen wir die Start-Schriftgr$$HEX2$$f600df00$$ENDHEX$$e
									if iFontSize > iStartSize then iFontSize = iStartSize
									dsLayout.SetItem(lRowInsert, "fs_" + sObject, -iFontSize)
								end if
							end if

			end choose

			// direkt raus aus der schleife $$HEX1$$fc00$$ENDHEX$$ber die columns: die aktuelle wurde ja gefunden
			exit

		end if 		// die aktuelle column gefunden
	next 				// schleife $$HEX1$$fc00$$ENDHEX$$ber die columns
				
next 				// schleife $$HEX1$$fc00$$ENDHEX$$ber alle objecte

return 0

end function

public function integer of_draw_column (long al_row, datastore ods);
//----------------------------------------------------
// Column Object zeichnen ...
// 
// Ziemlich komplizierter Mist !!!
// Wenn jemand ne bessere Idee hat, dann her damit
//----------------------------------------------------

// hilfsvariable feld-eigenschaften
Long 	ll_PosX, ll_PosY, ll_Height, ll_Width
Long 	ll_BorderStyle, ll_Fontsize, ll_FontSizes[], ll_Fontweight, ll_FontColor
Long 	ll_TextAlign, ll_FontUnderline, ll_FontItalic
Long 	ll_BackgroundMode, ll_BackgroundColor
Long 	ll_BrushColor, ll_BrushHatch
Long 	ll_PenColor, ll_PenWidth
Long 	ll_Resize, ll_Move

String 	ls_Fontname
String 	ls_FontPitch = "2"
String 	ls_FontFamily = "2"
String 	ls_ObjectName, ls_Value, ls_Column
Long 		ll_WithWrap

// hilfsvariable zum modifizieren der DW-Syntax
String 	ls_DWSyntax, ls_SyntaxCreate, ls_Ret
String 	ls_Autosize, ls_NewLength
integer 	li_InsertPos, li_NewId

// allgemeine hilfsvariable
Long 	ll_Start, ll_Ende
Long 	ll_Ret




ll_Start = CPU()

// eckdaten zum object holen
ll_PosX = dsObjects.GetItemNumber(al_Row, "nxpos")
ll_PosY = dsObjects.GetItemNumber(al_Row, "nypos")
ll_Height = dsObjects.GetItemNumber(al_Row, "nheight")
ll_Width = dsObjects.GetItemNumber(al_Row, "nwidth")
ll_BorderStyle = dsObjects.GetItemNumber(al_Row, "nborderstyle") 
ls_Fontname = dsObjects.GetItemString(al_Row, "cfontname")
ll_FontSize = dsObjects.GetItemNumber(al_Row, "nfontsize")
ll_FontWeight = dsObjects.GetItemNumber(al_Row, "nfontweight")
ll_TextAlign = dsObjects.GetItemNumber(al_Row, "ntextalign")
ll_FontUnderline = dsObjects.GetItemNumber(al_Row, "nfontunderline")
ll_FontItalic = dsObjects.GetItemNumber(al_Row, "nfontitalic")
ll_BackgroundMode = dsObjects.GetItemNumber(al_Row, "nbackgroundmode")
ll_BackgroundColor = dsObjects.GetItemNumber(al_Row, "nbackgroundcolor")
ll_FontColor = dsObjects.GetItemNumber(al_Row, "nfontcolor")
ll_BrushColor = dsObjects.GetItemNumber(al_Row, "nbrushcolor")
ll_PenColor = dsObjects.GetItemNumber(al_Row, "npencolor")
ll_PenWidth = dsObjects.GetItemNumber(al_Row, "npenwidth")
ll_BrushHatch = dsObjects.GetItemNumber(al_Row, "nbrushhatch")
ll_Resize = 0 //dsObjects.GetItemNumber(al_Row, "nresizeable")
ll_Move = 0 //dsObjects.GetItemNumber(al_Row, "nmoveable")

ls_ObjectName = dsObjects.GetItemString(al_Row, "cobject_name")
ls_Value = dsObjects.GetItemString(al_Row, "cvalue")
ls_Column = dsObjects.GetItemString(al_Row, "ccolumn")
if ls_Column = COL_PLDETAIL_TEXT OR ls_Column = COL_PLDETAIL_EXPL then
	ls_NewLength = "2048"
else
	ls_NewLength = "30"
end if

ll_WithWrap = dsObjects.GetItemNumber(al_Row, "nwrap")
if IsNull(ll_WithWrap) then ll_WithWrap = 0


if ll_WithWrap = 1 then
	ls_Autosize = "height.autosize=yes edit.autovscroll=yes"
else
	ls_Autosize = "height.autosize=no edit.autovscroll=no"
end if


// n$$HEX1$$e400$$ENDHEX$$chste id f$$HEX1$$fc00$$ENDHEX$$r die column bestimmen: VOR dem ersten create/modify!!
li_NewId = of_get_next_column_id(ii_max_columns_in_dw, dsLayout) // 07.12.2012 HR: 7 -> ii_max_columns_in_dw
// Messagebox("", li_NewId)

// --------------------------------------------------------------------------------------------------------------------
// 26.09.2022 HR: Wir setzen am Anfang mal den Standarddrucker vom Starten
// --------------------------------------------------------------------------------------------------------------------
if cbase.is_RemoteDesktopDefaultprinter > " " then
	oDS.Modify("datawindow.printer='" +cbase.is_RemoteDesktopDefaultprinter + "'")
	f_set_printer( cbase.is_RemoteDesktopDefaultprinter ) 
end if

// ----------------------------------------------------
// DW Syntax holen
// ----------------------------------------------------
// DW Syntax holen und die "einsprung"-position bestimmen
ls_DWSyntax = oDS.describe("datawindow.syntax")
li_InsertPos = pos(ls_DWSyntax, "text(name=jumppoint")

if li_InsertPos > 0 then
	// syntax f$$HEX1$$fc00$$ENDHEX$$r neue (daten-)column einpassen (l$$HEX1$$e400$$ENDHEX$$nge abh$$HEX1$$e400$$ENDHEX$$ngig vom feldnamen ???)
	// 19.10.2010 Neue Spalte "Explosion"
	ls_DWSyntax = Mid(ls_DWSyntax, 1, li_InsertPos - 4) + "column=(type=char(" + ls_NewLength + ") updatewhereclause=no name=" + ls_ObjectName + " dbname='" + ls_ObjectName + "')~r~n" + Mid(ls_DWSyntax, li_InsertPos - 3)
	// syntax laden
	ll_Ret = oDS.create(ls_DWSyntax)

	if this.ib_trace then this.of_log("Trace create column: ID=" + string(li_NewId) + ", columnname=" + ls_ObjectName)
	if ll_Ret <> 1 then
		of_log("Error -4, create column: " + string(ll_Ret))
		of_log("Error -4, create syntax: " + ls_DWSyntax)
		return -4
	end if

else
	return 0
end  if

// --------------------------------------------------------
// DW Syntax - neue Column eintragen im DW-Syntax-"Detail"
// --------------------------------------------------------
ls_SyntaxCreate = "create column(band=detail id=" + string(li_NewId) + " alignment='" + string(ll_TextAlign) + &
						"' tabsequence=0 border='" + string(ll_BorderStyle) + &
						"' color='" + string(ll_FontColor) + &
						"' x='" + string(ll_PosX, "0") + "' y='" + string(ll_PosY, "0") + &
						"' height='" + string(ll_Height, "0") + "' width='" + string(ll_Width, "0") + &
						"' format='[General]'  name=" + ls_ObjectName + &
						" resizeable=" + string(ll_Resize) + "  moveable=" + string(ll_Move) + &
						" edit.limit=0 edit.case=any " + ls_Autosize + " edit.autoselect=yes edit.autohscroll=yes  font.face='" + ls_Fontname + &
						"' font.height='" + string(ll_FontSize) + &
						"' font.weight='" +string(ll_FontWeight) + &
						"' font.italic='" + string(ll_FontItalic) + &
						"' font.underline='" + string(ll_FontUnderline) + &
						"' font.family='" + ls_FontFamily + "' font.pitch='" + ls_FontPitch + "' font.charset='0' background.mode='" + string(ll_BackgroundMode) + &
						"' background.color='" + string(ll_BackgroundColor) +"' )"
		
ls_Ret = oDS.modify(ls_SyntaxCreate)

if ls_Ret <> "" then
	of_log("Error -4, create column: " + ls_Ret)
	of_log("Error -4, create syntax: " + ls_SyntaxCreate)
	return -4
end if

	
// -----------------------------------------------------------------
// Hack:
// Wenn eine sonder-column aus mehreren Werten plus formatierungen
// (z.b. cdistributed_components) gemalt werden soll, dann in spezielle funktion
// -----------------------------------------------------------------
// das eigentliche Feld ausblenden ... 
// unsichtbar funzt irgendwie nicht, also H$$HEX1$$f600$$ENDHEX$$he und Breite auf 0 setzen
// -----------------------------------------------------------------
choose case ls_Column

	case COL_DISTRIBUTED_COMP
			oDS.modify(ls_ObjectName + ".visible='0'")
			oDS.modify(ls_ObjectName + ".height=0")
			oDS.modify(ls_ObjectName + ".width=0")
			this.of_draw_pl_columns(al_Row, ods)

	case COL_RTN_COMP
			oDS.modify(ls_ObjectName + ".visible='0'")
			oDS.modify(ls_ObjectName + ".height=0")
			oDS.modify(ls_ObjectName + ".width=0")
			this.of_draw_rtn_components(al_Row, oDS)
			
	case COL_EQ_COMP
			oDS.modify(ls_ObjectName + ".visible='0'")
			oDS.modify(ls_ObjectName + ".height=0")
			oDS.modify(ls_ObjectName + ".width=0")
			this.of_draw_eq_components(al_Row, oDS)

end choose


ll_Ende = CPU()
of_log("         - " + String((ll_Ende - ll_Start) / 1000, "00.00") + " seconds to create column: " + Upper(ls_Column))

return 0


end function

protected function long of_draw_line (datastore ods, string as_objectname, long al_posx1, long al_posy1, long al_posx2, long al_posy2, long al_penwidth, long al_pencolor);
/*
* Objekt: 	uo_label_other
* Methode:	of_draw_line (Function)
*
* Argument(e):
* 		oDS 
* 		as_ObjectName 
* 		al_PosX1 
* 		al_PosY1 
* 		al_PosX2 
* 		al_PosY1 
* 		al_PenWidth 
* 		al_PenColor 
*
*
* Beschreibung:		Die Columns mit Werten f$$HEX1$$fc00$$ENDHEX$$llen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		31.05.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// hilfsvariable zum modifizieren der DW-Syntax
String 	ls_SyntaxCreate, ls_Ret

ls_SyntaxCreate = "create line(band=detail" + &
			" x1='" + string(al_PosX1) + "' y1='" + string(al_PosY1) + "'" + &
			" x2='" + string(al_PosX2) + "' y2='" + string(al_PosY2) + "'" + &
			" name=" + as_ObjectName + "  moveable=0 visible='1'" + &
			" pen.style='0' pen.width='" + string(al_PenWidth) + "' pen.color='" + string(al_PenColor) + "'" + &
			" background.mode='2' background.color='16777215' )"

ls_Ret = oDS.modify(ls_SyntaxCreate)

of_log("rtn create syntax: " + ls_SyntaxCreate)

if ls_Ret <> "" then
	of_log("Error -5, create line  : " + ls_Ret)
	of_log("Error -5, create syntax: " + ls_SyntaxCreate)
	return -5
end if

return 0

end function

protected function long of_draw_line (datastore ods, integer al_posx1, integer al_posy1, integer al_posx2, integer al_posy2, integer al_penwidth, integer al_pencolor);
/*
* Objekt: 	uo_label_other
* Methode:	of_draw_line (Function)
*
* Argument(e):
* 		oDS 
* 		al_PosX1 
* 		al_PosY1 
* 		al_PosX2 
* 		al_PosY1 
* 		al_PenWidth 
* 		al_PenColor 
*
*
* Beschreibung:		Die Columns mit Werten f$$HEX1$$fc00$$ENDHEX$$llen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		31.05.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// hilfsvariable zum modifizieren der DW-Syntax
String 	ls_ObjectName

ls_ObjectName = "line_" + string(rand(32767))

return this.of_draw_line(oDS, ls_ObjectName, al_PosX1, al_PosY1, al_PosX2, al_PosY2, al_PenWidth, al_PenColor)

end function

protected function long of_get_setup_columns (ref uo_str_draw_columns astr_columns[]);
/*
* Objekt: 	uo_label_other
* Methode:	of_get_setup_columns (Function)
*
* Argument(e):
* 		astr_Columns 			Array von columns
*
*
* Beschreibung:		einige eigenschaften der Columns mit individuellen Werten f$$HEX1$$fc00$$ENDHEX$$llen
* 							nur, wenn tats$$HEX1$$e400$$ENDHEX$$chlich was da ist, eintragen, dann allerdings auch blocken gegen$$HEX1$$fc00$$ENDHEX$$ber den defaults
* 							spezielle kennzeichungen f$$HEX1$$fc00$$ENDHEX$$r additional items auch hier lesen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		14.06.2012		Erstellung
* 1.1 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		04.07.2012		Kennzeichnungen f$$HEX1$$fc00$$ENDHEX$$r additional items mit rein
*
*
* Return: integer
*	0 	alles geklappt
*/



// hilfsvariable schleife
Long 	ll_Row

// hilfsvariable zum zwischenspeichern
Decimal 	ldc_temp, ldc_Proz[]
String 	ls_Temp
Long 		ll_Temp


for ll_Row = 1 to UpperBound(astr_columns) step 1

	// platz-verteilung (erstmal nur ins hilfs-array, damit gepr$$HEX1$$fc00$$ENDHEX$$ft werden kann, ob die summe passt, bevor wirklich eingetragen wird)
	ls_Temp = ProfileString(s_app.sProfile, "Label-" + astr_columns[ll_Row].is_ObjectName, "WidthPercent", "-1")
	// erstmal initialisieren
	ldc_Proz[ll_Row] = astr_columns[ll_Row].idec_Proz
	if IsNumber(ls_Temp) then
		ldc_Temp = round(long(ls_Temp) / 100, 2)
		// was sinnvolles gefunden: eintragen
		if ldc_Temp > 0.00 then
//			astr_columns[ll_Row].idec_Proz = ldc_Temp
			ldc_Proz[ll_Row] = ldc_Temp
		end if
	end if

	// schriftausrichtung (0 linksb$$HEX1$$fc00$$ENDHEX$$ndig, 1 rechtsb$$HEX1$$fc00$$ENDHEX$$ndig, 2 zentriert)
	ls_Temp = ProfileString(s_app.sProfile, "Label-" + astr_columns[ll_Row].is_ObjectName, "TextAlign", "-1")
	if IsNumber(ls_Temp) then
		ll_Temp = long(ls_Temp)
		// was sinnvolles gefunden: eintragen
		if ll_Temp >= 0 and ll_Temp <= 2 then
			astr_columns[ll_Row].il_TextAlign = ll_Temp
			astr_columns[ll_Row].ib_TextAlign = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
		end if
	end if

	// schriftgewicht (700 fett, 400 normal)
	ls_Temp = ProfileString(s_app.sProfile, "Label-" + astr_columns[ll_Row].is_ObjectName, "FontWeight", "-1")
	if IsNumber(ls_Temp) then
		ll_Temp = long(ls_Temp)
		// was sinnvolles gefunden: eintragen
		if ll_Temp = 400 or ll_Temp = 700 then
			astr_columns[ll_Row].il_Fontweight = ll_Temp
			astr_columns[ll_Row].ib_Fontweight = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
		end if
	end if

next

// plausi platzverteilung: pr$$HEX1$$fc00$$ENDHEX$$fen
ldc_Temp = 0.00
for ll_Row = 1 to UpperBound(astr_columns) step 1
	ldc_Temp += ldc_Proz[ll_Row]
next
// plausi platzverteilung erfolgreich: eintragen
if ldc_Temp <= 1.00 then
	for ll_Row = 1 to UpperBound(astr_columns) step 1
		astr_columns[ll_Row].idec_Proz = ldc_Proz[ll_Row]
	next
end if

return 0

end function

protected function long of_get_setup_rtn ();
/*
* Objekt: 	uo_label_other
* Methode:	of_get_setup_rtn (Function)
*
* Argument(e):
*
*
* Beschreibung:		filter f$$HEX1$$fc00$$ENDHEX$$r die daten individuell setzen
* 							nur, wenn tats$$HEX1$$e400$$ENDHEX$$chlich was da ist, sonst bleibt der default
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		14.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*/

// hilfsvariable
Long 	ll_Row, ll_Pos
String ls_Temp


//ls_Temp = f_mandant_profilestring(sqlca, s_app.sMandant, "Label-RTN", "Kinds", "-1")
ls_Temp = ProfileString(s_app.sProfile, "Label-RTN", "Kinds", "-1")

if trim(ls_Temp) <> "" and trim(ls_Temp) <> "-1" then
	ll_Pos = Pos(ls_Temp, ",")
	ll_Row = 1
	do while ll_Pos > 0
		this.is_kindsRTN[ll_Row] = trim(left(ls_Temp, ll_Pos - 1))
		ll_Row += 1
		ls_Temp = trim(mid(ls_Temp, ll_Pos + 1))
		ll_Pos = Pos(ls_Temp, ",")
	loop
	if trim(ls_Temp) <> "" then
		this.is_kindsRTN[ll_Row] = trim(ls_Temp)
	end if
end if

// kennzeichnung additional item (erscheint in der Unit-Column)
ls_Temp = ProfileString(s_app.sProfile, "Label-RTN", "UnitAddItems", "-1")
if ls_Temp <> "-1" then this.is_AddItems = ls_Temp

// faktor, um die die schriftgr$$HEX1$$f600$$ENDHEX$$sse der additional items reduziert werden soll
ls_Temp = ProfileString(s_app.sProfile, "Label-RTN", "SizeAddItems", "1")
if ls_Temp <> "1" and IsNumber(ls_Temp) then this.il_AddItems_ReductFontsize = long(ls_Temp)

// die aktiven abrechungsstatus f$$HEX1$$fc00$$ENDHEX$$r additional items
ls_Temp = ProfileString(s_app.sProfile, "Label-RTN", "ReckoningAddItems", "-1")
if ls_Temp <> "-1" then this.is_Reckoning = ls_Temp

return 0

end function

protected function long of_draw_rtn_components (long al_row, datastore ods);
/*
* Objekt: 	uo_label_other
* Methode:	of_draw_rtn_components (Function)
*
* Argument(e):
* 		al_Row 			Zeile
*
*
* Beschreibung:		Die Columns mit Werten f$$HEX1$$fc00$$ENDHEX$$llen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel 		31.05.2012		Erstellung
* 1.1          D.Bunk         15.11.2012     Alte PBAcorbat Funktionen gegen neue getauscht
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// hilfsvariable zur breitenberechnung: abstand zwischen den feldern
Long ll_Offset = 4
//
// hilfsvariable feld-eigenschaften
Long 	ll_PosX, ll_PosY, ll_Height, ll_Width
Long 	ll_BorderStyle, ll_Fontsize, ll_Fontweight, ll_FontColor
Long 	ll_TextAlign, ll_FontUnderline, ll_FontItalic
Long 	ll_BackgroundMode, ll_BackgroundColor
Long 	ll_BrushColor, ll_BrushHatch
Long 	ll_PenColor, ll_PenWidth
Long 	ll_Resize, ll_Move
Long 	ll_WithWrap
String ls_Fontname
String ls_FontPitch = "2"
String ls_FontFamily = "2"

Long 	ll_LabelDetailKey
String ls_ObjectName
Long 	ll_TextHeight
Long ll_TextWidth

// allgemeine hilfsvariable
Long ll_Ret, ll_RowObjects, ll_Row, ll_Len

// das objekt zum eigentlichen zeichnen
uo_draw_objects 	luo_DrawObjects


// of_log("         --------------------------------------------------------")

// eckdaten zum object holen
ll_PosX = dsObjects.GetItemNumber(al_Row, "nxpos")
ll_PosY = dsObjects.GetItemNumber(al_Row, "nypos")
ll_Height = dsObjects.GetItemNumber(al_Row, "nheight")
ll_Width = dsObjects.GetItemNumber(al_Row, "nwidth")
ll_BorderStyle = dsObjects.GetItemNumber(al_Row, "nborderstyle") 
ls_Fontname = dsObjects.GetItemString(al_Row, "cfontname")
ll_FontSize = dsObjects.GetItemNumber(al_Row, "nfontsize")
ll_FontWeight = dsObjects.GetItemNumber(al_Row, "nfontweight")
ll_TextAlign = dsObjects.GetItemNumber(al_Row, "ntextalign")
ll_FontUnderline = dsObjects.GetItemNumber(al_Row, "nfontunderline")
ll_FontItalic = dsObjects.GetItemNumber(al_Row, "nfontitalic")
ll_BackgroundMode = dsObjects.GetItemNumber(al_Row, "nbackgroundmode")
ll_BackgroundColor = dsObjects.GetItemNumber(al_Row, "nbackgroundcolor")
ll_FontColor = dsObjects.GetItemNumber(al_Row, "nfontcolor")
ll_BrushColor = dsObjects.GetItemNumber(al_Row, "nbrushcolor")
ll_PenColor = dsObjects.GetItemNumber(al_Row, "npencolor")
ll_PenWidth = dsObjects.GetItemNumber(al_Row, "npenwidth")
ll_BrushHatch = dsObjects.GetItemNumber(al_Row, "nbrushhatch")
ll_Resize = 0 //dsObjects.GetItemNumber(al_Row, "nresizeable")
ll_Move = 0 //dsObjects.GetItemNumber(al_Row, "nmoveable")

ll_LabelDetailKey = dsObjects.GetItemNumber(al_Row, "nlabel_detail_key")
ls_ObjectName = dsObjects.GetItemString(al_Row, "cobject_name")

ll_WithWrap = dsObjects.GetItemNumber(al_Row, "nwrap")
if IsNull(ll_WithWrap) then ll_WithWrap = 0

// -------------------------------------------------------
// initialisieren
// -------------------------------------------------------
// mit umbruch: feldh$$HEX1$$f600$$ENDHEX$$he anpassen
if ll_WithWrap = 1 then
	ll_Height = ll_Height / 2
end if
// bestimme die texth$$HEX1$$f600$$ENDHEX$$he
iuo_FontCalc.of_GetTextSize("Calculate", ls_Fontname, ll_FontSize * -1, true, false, false, ll_TextHeight, ll_TextWidth)

// -------------------------------------------------------
// trage erstmal die defaults pro column ein
// -------------------------------------------------------
ll_Ret = luo_DrawObjects.of_set_columns_properties (this.istr_RTN, ll_BorderStyle, ll_FontSize, ll_FontWeight, ll_FontColor, ll_TextAlign, &
						ll_FontUnderline, ll_FontItalic, ll_BackgroundMode, ll_BackgroundColor, ll_Resize, ll_Move, ls_Fontname, ls_FontPitch, ls_FontFamily)

// alles gleiche h$$HEX1$$f600$$ENDHEX$$he
for ll_RowObjects = 1 to UpperBound(this.istr_RTN) step 1
	this.istr_RTN[ll_RowObjects].il_Height = ll_TextHeight
next

// wir wollen grid!
ll_Ret = luo_DrawObjects.of_init_grid(true)

// wir wollen individuelle schriftgewichtung
for ll_RowObjects = 1 to UpperBound(this.istr_RTN) step 1
	this.istr_RTN[ll_RowObjects].is_If_Fontweight = "if (<<" + this.istr_RTN[1].is_ObjectName + ">>=~"" + this.is_AddItems + "~", 400, 700)"
next

// wir wollen individuelle schriftgr$$HEX1$$f600$$ENDHEX$$sse
for ll_RowObjects = 1 to UpperBound(this.istr_RTN) step 1
//for ll_RowObjects = 2 to 2 step 1
	// addieren, da das ganze negativ ist
	ll_FontSize = this.istr_RTN[ll_RowObjects].il_FontSize + this.il_AddItems_ReductFontsize
	this.istr_RTN[ll_RowObjects].is_If_FontSize = "if (<<" + this.istr_RTN[1].is_ObjectName + ">>=~"" + this.is_AddItems + "~", " + string(ll_FontSize) + ", " + string(this.istr_RTN[ll_RowObjects].il_FontSize) + ")"
next

// -------------------------------------------------------
// ... und dann zeichne den ganzen block
// -------------------------------------------------------
ll_Ret = luo_DrawObjects.of_draw_block(oDS, this.istr_RTN, ll_PosX, ll_PosY, ll_Width, ll_Height, ll_Offset, ll_TextHeight, this.ii_TextRowsIn_RTN_COMP, ll_LabelDetailKey, this.dsObjects)

return 0

end function

public function boolean of_check_rtn_level (string as_level);
/*
* Objekt: 	uo_label_other
* Methode: 	of_check_rtn_level
*
* Argument(e):
* 	string 		as_Level 						Text, der gepr$$HEX1$$fc00$$ENDHEX$$ft werden soll
*
* Beschreibung:		initialisieren
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		29.06.2012		Erstellung
*
*
* Return: boolean
*	true 	gefunden
*	false 	nicht gefunden
*/


// hilfsvariable
Long 	ll_Row
Boolean 	lb_Found = false


for ll_Row = 1 to UpperBound(this.is_kindsRTN) step 1
	if Upper(trim(as_Level)) = this.is_kindsRTN[ll_Row] then
		lb_Found = true
		exit
	end if
next

return lb_Found

end function

protected function s_packinglist_detail of_create_pl_rtn (long al_index_key, datetime adt_departure, boolean ab_read);
/*
* Objekt : uo_label_other
* Methode: of_create_pl_rtn (Function)
* Autor  : Margret N$$HEX1$$fc00$$ENDHEX$$ndel
* Datum  : 06.06.2012
*
* Argument(e):
* 	Long 		al_Index_Key 		IndexKey der St$$HEX1$$fc00$$ENDHEX$$ckliste
* 	Datetime adt_Departure 		Abflugdatum des Fluges
* 	Boolean 	ab_Read 			Schalter, ob Explosion neu gelesen werden muss
*
* Beschreibung:		Neue Label-Column f$$HEX1$$fc00$$ENDHEX$$r Return Items:
* 							lesen der RTN-Daten (Unit, Text, Menge)
*
* Aenderungshistorie:
* Version 	Wer				Wann				Was und warum
* 1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel 		06.06.2012		Erstellung (abgeleitet aus of_create_pl_explosion)
* 1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel 		14.06.2012		array von g$$HEX1$$fc00$$ENDHEX$$ltigen kinds zur pr$$HEX1$$fc00$$ENDHEX$$fung, was nun genommen werden soll, erg$$HEX1$$e400$$ENDHEX$$nzt
* 1.2 			M.N$$HEX1$$fc00$$ENDHEX$$ndel 		29.06.2012		$$HEX1$$fc00$$ENDHEX$$bergeordnete st$$HEX1$$fc00$$ENDHEX$$ckliste, additional items mit betrachten
* 1.3 			M.N$$HEX1$$fc00$$ENDHEX$$ndel 		11.12.2012		auch bei RTN reckoning mit betrachten: ausblenden
*
*
* Return: s_packinglist_detail
*
*/

// allgemeine hilfsvariable
Long 		ll_Ret
Long		ll_Rows, ll_Row, ll_Lauf, ll_Kind
Long 		ll_RowMaster = 0, ll_RowMasterDone = 0, ll_Level = 1
Boolean 	lb_Found = false

Long 		ll_RowMasterStart[], ll_RowMasterEnd[]


// hilfsvariable datenpuffer
String		ls_Unit, ls_Text
Long 		ll_Quantity

// return-parameter
s_packinglist_detail	lstr_LabelPLTexte

// object zum kummulieren der Inhalte
uo_label_collect_textrows 	luoCollectTextRows

// ---------------------------------------------------
// initialisieren
// ---------------------------------------------------
// tabs rein, damit der text an der richtigen stelle landet: qty-text-einheit
luoCollectTextRows.of_init(this.ii_TextRowsIn_RTN_COMP, "~tno items available~t~n")

// ---------------------------------------------------
// lesen, falls n$$HEX1$$f600$$ENDHEX$$tig
// ---------------------------------------------------
if ab_Read then
	ll_Rows = this.dsPackinglistExplosion.Retrieve(al_Index_Key, adt_Departure)
else
	ll_Rows = this.dsPackinglistExplosion.RowCount()
end if

// ---------------------------------------------------
// schleife $$HEX1$$fc00$$ENDHEX$$ber alle s$$HEX1$$e400$$ENDHEX$$tze:
// nur die daten der gew$$HEX1$$fc00$$ENDHEX$$nschten $$HEX1$$fc00$$ENDHEX$$bernehmen
// ---------------------------------------------------
// ich brauche die RTN plus das gef$$HEX1$$e400$$ENDHEX$$ss eine stufe h$$HEX1$$f600$$ENDHEX$$her (nlevel und nlevel-1):
// ich finde rtn, gehe zur$$HEX1$$fc00$$ENDHEX$$ck zu nlevel-1, hole die unit und merke mir die row, damit das nicht mehrfach passiert
// 
// ich brauche zus$$HEX1$$e400$$ENDHEX$$tzlich alle Artikel neben dem RTN im gef$$HEX1$$e400$$ENDHEX$$ss eine stufe h$$HEX1$$f600$$ENDHEX$$her (nlevel und nlevel-1):
//
// 
// ---------------------------------------------------
for ll_Row = 1 to dsPackinglistExplosion.Rowcount() step 1

	// wenn schon was gef$$HEX1$$fc00$$ENDHEX$$llt und das ende des "gef$$HEX1$$e400$$ENDHEX$$sses" $$HEX1$$fc00$$ENDHEX$$berschritten ist:
	if Upperbound(ll_RowMasterStart) > 0 then
		if ll_Row = ll_RowMasterEnd[Upperbound(ll_RowMasterStart)] + 1 then
	
			// dann additional RTN-inhalt eintragen
			for ll_Lauf = ll_RowMasterStart[Upperbound(ll_RowMasterStart)] + 1 to ll_RowMasterEnd[Upperbound(ll_RowMasterStart)] step 1
				// nur artikel
				if dsPackinglistExplosion.GetItemNumber(ll_Lauf, "npackinglist_key") <> 3 then continue
				// nur direkte Inhalte betrachten (level ist der wert vom RTN)
				if dsPackinglistExplosion.GetItemNumber(ll_Lauf, "nlevel") <> ll_level then continue
				// die s$$HEX1$$e400$$ENDHEX$$tze weglassen, die gewollt sind (und deshalb schon oben da)
				if of_check_rtn_level(dsPackinglistExplosion.GetitemString(ll_Lauf, "clevel")) then continue
				// die s$$HEX1$$e400$$ENDHEX$$tze weglassen, die den "falschen" abrechnungsstatus haben)
				if Pos(this.is_Reckoning, string(this.dsPackinglistExplosion.GetItemNumber(ll_Lauf, "nreckoning"))) = 0 then continue
				// dann den RTN-inhalt eintragen
				ll_Quantity 	= dsPackinglistExplosion.Getitemnumber(ll_Lauf, "nquantity")
				ls_Text		= dsPackinglistExplosion.Getitemstring(ll_Lauf, "ctext")
				ls_Unit = this.is_AddItems
				ll_Ret = luoCollectTextRows.of_add_row(ls_text, ls_Unit, ll_Quantity)
			next
			
		end if
	end if

	// nur die s$$HEX1$$e400$$ENDHEX$$tze nehmen, die gewollt sind
	if not of_check_rtn_level(dsPackinglistExplosion.GetitemString(ll_Row,"clevel")) then continue
	
	// satz gefunden: suche "gef$$HEX1$$e400$$ENDHEX$$ss" dazu (n$$HEX1$$e400$$ENDHEX$$chst-h$$HEX1$$f600$$ENDHEX$$here stufe)
	ll_level = dsPackinglistExplosion.GetItemNumber(ll_Row, "nlevel")

	if ll_Row > 1 and ll_Row > ll_RowMaster then
		ll_RowMaster = 0 		// damit festgestellt werden kann, ob was gefunden wurde
		for ll_Lauf = ll_Row - 1 to 1 step -1
			if dsPackinglistExplosion.GetItemNumber(ll_Lauf, "nlevel") = ll_level - 1 then
				ll_RowMaster = ll_Lauf
				exit
			end if
		next
	end if

	// neuer master gefunden: intervall bestimmen und eintragen
	if ll_RowMaster > 0 and ll_RowMaster<> ll_RowMasterDone then
		ll_RowMasterStart[Upperbound(ll_RowMasterStart) + 1] = ll_RowMaster
		ll_RowMasterEnd[Upperbound(ll_RowMasterStart)] = dsPackinglistExplosion.Rowcount()
		for ll_Lauf = ll_Row + 1 to dsPackinglistExplosion.Rowcount() step 1
			if dsPackinglistExplosion.GetItemNumber(ll_Lauf, "nlevel") <= ll_level - 1 then
				ll_RowMasterEnd[Upperbound(ll_RowMasterStart)] = ll_Lauf - 1
				exit
			end if
		next		
	end if	

	// einheit aus dem "gef$$HEX1$$e400$$ENDHEX$$ss", wenn gefunden und es noch fehlt
	if ll_RowMaster > 0 and ll_RowMaster<> ll_RowMasterDone then
		ls_Unit = dsPackinglistExplosion.Getitemstring(ll_RowMaster, "cunit")  
		// festschreiben, dass dieses "gef$$HEX1$$e400$$ENDHEX$$ss" geschrieben wurde
		ll_RowMasterDone = ll_RowMaster
	else
		ls_Unit = ""
	end if
	
	// dann den RTN-inhalt eintragen
	// die s$$HEX1$$e400$$ENDHEX$$tze leerlassen, die den "falschen" abrechnungsstatus haben)
	if Pos(this.is_Reckoning, string(this.dsPackinglistExplosion.GetItemNumber(ll_Row, "nreckoning"))) = 0 then
		ll_Quantity 	= -1
		ls_Text		= ""
		ll_Ret = luoCollectTextRows.of_add_row(ls_text, ls_Unit, ll_Quantity)
	else
		ll_Quantity 	= dsPackinglistExplosion.GetitemNumber(ll_Row, "nquantity")
		ls_Text		= dsPackinglistExplosion.GetitemString(ll_Row, "ctext")
		ll_Ret = luoCollectTextRows.of_add_row(ls_text, ls_Unit, ll_Quantity)
	end if

next	

// falls das ende des "gef$$HEX1$$e400$$ENDHEX$$sses" genau rowcount ist:
if Upperbound(ll_RowMasterStart) > 0 then
	if dsPackinglistExplosion.Rowcount() = ll_RowMasterEnd[Upperbound(ll_RowMasterStart)] then
	
		// dann additional RTN-inhalt eintragen
		for ll_Lauf = ll_RowMasterStart[Upperbound(ll_RowMasterStart)] + 1 to ll_RowMasterEnd[Upperbound(ll_RowMasterStart)] step 1
			// nur artikel
			if dsPackinglistExplosion.GetItemNumber(ll_Lauf, "npackinglist_key") <> 3 then continue
			// nur direkte Inhalte betrachten (level ist der wert vom RTN)
			if dsPackinglistExplosion.GetItemNumber(ll_Lauf, "nlevel") <> ll_level then continue
			// die s$$HEX1$$e400$$ENDHEX$$tze weglassen, die gewollt sind (und deshalb schon oben da)
			if of_check_rtn_level(dsPackinglistExplosion.GetitemString(ll_Lauf, "clevel")) then continue
			// die s$$HEX1$$e400$$ENDHEX$$tze weglassen, die den "falschen" abrechnungsstatus haben)
			if Pos(this.is_Reckoning, string(this.dsPackinglistExplosion.GetItemNumber(ll_Lauf, "nreckoning"))) = 0 then continue
			// dann den RTN-inhalt eintragen
			ll_Quantity 	= dsPackinglistExplosion.Getitemnumber(ll_Lauf, "nquantity")
			ls_Text		= dsPackinglistExplosion.Getitemstring(ll_Lauf, "ctext")
			ls_Unit = this.is_AddItems
			ll_Ret = luoCollectTextRows.of_add_row(ls_text, ls_Unit, ll_Quantity)
		next
			
	end if
end if

// das ergebnis abholen
ll_Ret = luoCollectTextRows.of_return_textrows(lstr_LabelPLTexte)

return lstr_LabelPLTexte

end function

protected function long of_draw_eq_components (long al_row, datastore ods);
/*
* Objekt: 	uo_label_other
* Methode:	of_draw_eq_components (Function)
*
* Argument(e):
* 		al_Row 			Zeile
*
*
* Beschreibung:		Die Columns mit Werten f$$HEX1$$fc00$$ENDHEX$$llen
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 			M.Barfknecht 	29.08.2012		Erstellung
* 1.1          D.Bunk         15.11.2012     Alte PBAcorbat Funktionen gegen neue getauscht
*
* Return: integer
*	0 	alles geklappt
*	< 0 fehler
*/

// hilfsvariable zur breitenberechnung: abstand zwischen den feldern
Long ll_Offset = 4
//
// hilfsvariable feld-eigenschaften
Long 	ll_PosX, ll_PosY, ll_Height, ll_Width
Long 	ll_BorderStyle, ll_Fontsize, ll_Fontweight, ll_FontColor
Long 	ll_TextAlign, ll_FontUnderline, ll_FontItalic
Long 	ll_BackgroundMode, ll_BackgroundColor
Long 	ll_BrushColor, ll_BrushHatch
Long 	ll_PenColor, ll_PenWidth
Long 	ll_Resize, ll_Move
Long 	ll_WithWrap
String ls_Fontname
String ls_FontPitch = "2"
String ls_FontFamily = "2"

Long 	ll_LabelDetailKey
String ls_ObjectName
Long 	ll_TextHeight, ll_TextWidth

// allgemeine hilfsvariable
Long ll_Ret, ll_RowObjects, ll_Row, ll_Len

// das objekt zum eigentlichen zeichnen
uo_draw_objects 	luo_DrawObjects


// of_log("         --------------------------------------------------------")

// eckdaten zum object holen
ll_PosX = dsObjects.GetItemNumber(al_Row, "nxpos")
ll_PosY = dsObjects.GetItemNumber(al_Row, "nypos")
ll_Height = dsObjects.GetItemNumber(al_Row, "nheight")
ll_Width = dsObjects.GetItemNumber(al_Row, "nwidth")
ll_BorderStyle = dsObjects.GetItemNumber(al_Row, "nborderstyle") 
ls_Fontname = dsObjects.GetItemString(al_Row, "cfontname")
ll_FontSize = dsObjects.GetItemNumber(al_Row, "nfontsize")
ll_FontWeight = dsObjects.GetItemNumber(al_Row, "nfontweight")
ll_TextAlign = dsObjects.GetItemNumber(al_Row, "ntextalign")
ll_FontUnderline = dsObjects.GetItemNumber(al_Row, "nfontunderline")
ll_FontItalic = dsObjects.GetItemNumber(al_Row, "nfontitalic")
ll_BackgroundMode = dsObjects.GetItemNumber(al_Row, "nbackgroundmode")
ll_BackgroundColor = dsObjects.GetItemNumber(al_Row, "nbackgroundcolor")
ll_FontColor = dsObjects.GetItemNumber(al_Row, "nfontcolor")
ll_BrushColor = dsObjects.GetItemNumber(al_Row, "nbrushcolor")
ll_PenColor = dsObjects.GetItemNumber(al_Row, "npencolor")
ll_PenWidth = dsObjects.GetItemNumber(al_Row, "npenwidth")
ll_BrushHatch = dsObjects.GetItemNumber(al_Row, "nbrushhatch")
ll_Resize = 0 //dsObjects.GetItemNumber(al_Row, "nresizeable")
ll_Move = 0 //dsObjects.GetItemNumber(al_Row, "nmoveable")

ll_LabelDetailKey = dsObjects.GetItemNumber(al_Row, "nlabel_detail_key")
ls_ObjectName = dsObjects.GetItemString(al_Row, "cobject_name")

ll_WithWrap = dsObjects.GetItemNumber(al_Row, "nwrap")
if IsNull(ll_WithWrap) then ll_WithWrap = 0

// -------------------------------------------------------
// initialisieren
// -------------------------------------------------------
// mit umbruch: feldh$$HEX1$$f600$$ENDHEX$$he anpassen
if ll_WithWrap = 1 then
	ll_Height = ll_Height / 2
end if
// bestimme die texth$$HEX1$$f600$$ENDHEX$$he
iuo_FontCalc.of_GetTextSize("Calculate", ls_Fontname, ll_FontSize * -1, true, false, false, ll_TextHeight, ll_TextWidth)

// -------------------------------------------------------
// trage erstmal die defaults pro column ein
// -------------------------------------------------------
ll_Ret = luo_DrawObjects.of_set_columns_properties (this.istr_EQ, ll_BorderStyle, ll_FontSize, ll_FontWeight, ll_FontColor, ll_TextAlign, &
						ll_FontUnderline, ll_FontItalic, ll_BackgroundMode, ll_BackgroundColor, ll_Resize, ll_Move, ls_Fontname, ls_FontPitch, ls_FontFamily)

// alles gleiche h$$HEX1$$f600$$ENDHEX$$he
for ll_RowObjects = 1 to UpperBound(this.istr_EQ) step 1
	this.istr_EQ[ll_RowObjects].il_Height = ll_TextHeight
next

// wir wollen grid!
ll_Ret = luo_DrawObjects.of_init_grid(true)

// wir wollen individuelle schriftgewichtung
for ll_RowObjects = 1 to UpperBound(this.istr_EQ) step 1
//	this.istr_EQ[ll_RowObjects].is_If_Fontweight = "if (<<" + this.istr_EQ[1].is_ObjectName + ">>=~"" + this.is_AddItems + "~", 400, 700)"
next

// wir wollen individuelle schriftgr$$HEX1$$f600$$ENDHEX$$sse
for ll_RowObjects = 1 to UpperBound(this.istr_EQ) step 1
//for ll_RowObjects = 2 to 2 step 1
	// addieren, da das ganze negativ ist
	ll_FontSize = this.istr_EQ[ll_RowObjects].il_FontSize + this.il_AddItems_ReductFontsize
	this.istr_EQ[ll_RowObjects].is_If_FontSize = "if (<<" + this.istr_EQ[1].is_ObjectName + ">>=~"" + this.is_AddItems + "~", " + string(ll_FontSize) + ", " + string(this.istr_EQ[ll_RowObjects].il_FontSize) + ")"
next

// -------------------------------------------------------
// ... und dann zeichne den ganzen block
// -------------------------------------------------------
ll_Ret = luo_DrawObjects.of_draw_block(oDS, this.istr_EQ, ll_PosX, ll_PosY, ll_Width, ll_Height, ll_Offset, ll_TextHeight, this.ii_TextRowsIn_EQ_COMP, ll_LabelDetailKey, this.dsObjects)

return 0

end function

protected function long of_get_setup_eq ();
/*
* Objekt: 	uo_label_other
* Methode:	of_get_setup_rtn (Function)
*
* Argument(e):
*
*
* Beschreibung:		filter f$$HEX1$$fc00$$ENDHEX$$r die daten individuell setzen
* 							nur, wenn tats$$HEX1$$e400$$ENDHEX$$chlich was da ist, sonst bleibt der default
*
* Aenderungshistorie:
* Version 		Wer					Wann				Was und warum
* 1.0 				M.Barfkencht		29.08.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*/

// hilfsvariable
Long 	ll_Row, ll_Pos
String ls_Temp


ls_Temp = f_mandant_profilestring(sqlca, s_app.sMandant, "Label-EQ", "Units", "-1")

//ls_Temp = ProfileString(s_app.sProfile, "Label-EQ", "Units", "-1")

if trim(ls_Temp) <> "" and trim(ls_Temp) <> "-1" then
	ll_Pos = Pos(ls_Temp, ",")
	ll_Row = 1
	do while ll_Pos > 0
		this.is_kindsEQ[ll_Row] = trim(left(ls_Temp, ll_Pos - 1))
		ll_Row += 1
		ls_Temp = trim(mid(ls_Temp, ll_Pos + 1))
		ll_Pos = Pos(ls_Temp, ",")
	loop
	if trim(ls_Temp) <> "" then
		this.is_kindsEQ[ll_Row] = trim(ls_Temp)
	end if
end if

// kennzeichnung additional item (erscheint in der Unit-Column)
ls_Temp = ProfileString(s_app.sProfile, "Label-EQ", "UnitAddItems", "-1")
if ls_Temp <> "-1" then this.is_AddItems = ls_Temp

// faktor, um die die schriftgr$$HEX1$$f600$$ENDHEX$$sse der additional items reduziert werden soll
ls_Temp = ProfileString(s_app.sProfile, "Label-EQ", "SizeAddItems", "1")
if ls_Temp <> "1" and IsNumber(ls_Temp) then this.il_AddItems_ReductFontsize = long(ls_Temp)

// die aktiven abrechungsstatus f$$HEX1$$fc00$$ENDHEX$$r additional items
ls_Temp = ProfileString(s_app.sProfile, "Label-EQ", "ReckoningAddItems", "-1")
if ls_Temp <> "-1" then this.is_Reckoning = ls_Temp

return 0

end function

protected function s_packinglist_detail of_create_pl_eq (long al_index_key, datetime adt_departure, boolean ab_read, ref s_packinglist_detail lstr_labelpltexte);
/*
* Objekt : uo_label_other
* Methode: of_create_pl_eq (Function)
* Autor  : Matthias Barfknecht
* Datum  : 29.08.2012
*
* Argument(e):
* 	Long 		al_Index_Key 		IndexKey der St$$HEX1$$fc00$$ENDHEX$$ckliste
* 	Datetime adt_Departure 		Abflugdatum des Fluges
* 	Boolean 	ab_Read 			Schalter, ob Explosion neu gelesen werden muss
*
* Beschreibung:		Neue Label-Column f$$HEX1$$fc00$$ENDHEX$$r Equipment Recheck:
* 							(Unit, Text, Menge)
*
* Aenderungshistorie:
* Version 	Wer					Wann				Was und warum
* 1.0 			M.Barfkencht 		29.08.2012		Erstellung (abgeleitet aus of_create_pl_rtn)
* 1.1			M.Barfknecht		21.11.2012		Ausblenden unerw$$HEX1$$fc00$$ENDHEX$$nschter Inhalte
*
* Return: s_packinglist_detail
*
*/

// allgemeine hilfsvariable
Long 		ll_Ret,ll_start,ll_plevel
Long		ll_Rows, ll_Row, ll_Lauf, ll_Kind,ll_packinglistkey
Long 		ll_RowMaster = 0, ll_RowMasterDone = 0, ll_Level = 1
Boolean 	lb_Found = false

Long 		ll_RowMasterStart[], ll_RowMasterEnd[]

datastore ds_pl_help

// hilfsvariable datenpuffer
String		ls_Unit, ls_Text,ls_unit_test
Long 		ll_Quantity

// return-parameter
//s_packinglist_detail	lstr_LabelPLTexte

// object zum kummulieren der Inhalte
uo_label_collect_textrows 	luoCollectTextRows

// ---------------------------------------------------
// initialisieren
// ---------------------------------------------------
// tabs rein, damit der text an der richtigen stelle landet: qty-text-einheit
luoCollectTextRows.of_init(this.ii_TextRowsIn_EQ_COMP, "~tno items available~t~n")

// ---------------------------------------------------
// lesen, falls n$$HEX1$$f600$$ENDHEX$$tig
// ---------------------------------------------------
if ab_Read then
	ll_Rows = this.dsPackinglistExplosion.Retrieve(al_Index_Key, adt_Departure)
else
	ll_Rows = this.dsPackinglistExplosion.RowCount()
end if

//---------------------------------------
// Hilfsdatastore initialisieren
//---------------------------------------

ds_pl_help = create datastore
ds_pl_help.dataobject =  this.dsPackinglistExplosion.dataobject

dsPackinglistExplosion.rowscopy( 1,dsPackinglistExplosion.rowcount() ,Primary!, ds_pl_help, ds_pl_help.rowcount() +1, Primary!)

//So ds_pl_help enth$$HEX1$$e400$$ENDHEX$$lt die komplette explosion.
//Jetzt m$$HEX1$$fc00$$ENDHEX$$ssen wir alles rauswerfen, was wir nicht auf dem Label wollen:

for ll_Lauf= 1 to ds_pl_help.Rowcount() step 1
	
	ls_unit_test = ds_pl_help.Getitemstring(ll_Lauf, "cunit")
	ll_packinglistkey =ds_pl_help.Getitemnumber(ll_Lauf, "npackinglist_key")
	
	if ls_unit_test <> 'RU' and ll_packinglistkey = 2 then
		//Wenn es nicht RU ist aber subitems hat, dann diese Zeile l$$HEX1$$f600$$ENDHEX$$schen
		//und die Unit der n$$HEX1$$e400$$ENDHEX$$chsten Zeile austauschen
		ds_pl_help.deleterow(ll_lauf)
		ds_pl_help.setitem(ll_lauf,"cunit",ls_unit_test)
	end if
	if ls_unit_test = 'RU' then
		//Wenn es RU ist, bleibt diese Zeile stehen,
		//aber die Inhalte fliegen raus:
		ll_plevel = ds_pl_help.Getitemnumber(ll_Lauf + 1, "nlevel")
		ll_start = ll_lauf +1
		//Das erste, das rausfliegt ist die n$$HEX1$$e400$$ENDHEX$$chste Zeile
		ll_start = ll_lauf +1
		//Wir l$$HEX1$$f600$$ENDHEX$$schen solange, bis sich der level wieder $$HEX1$$e400$$ENDHEX$$ndert:
		do while ds_pl_help.Getitemnumber(ll_start, "nlevel") =ll_plevel 
			ds_pl_help.deleterow(ll_start)
			if ll_start > ds_pl_help.rowcount() then exit
		loop
		
	end if
	
next
// ---------------------------------------------------
// schleife $$HEX1$$fc00$$ENDHEX$$ber alle s$$HEX1$$e400$$ENDHEX$$tze:

// 
// ---------------------------------------------------
for ll_Lauf= 1 to ds_pl_help.Rowcount() step 1

	
				ll_Quantity 	= ds_pl_help.Getitemnumber(ll_Lauf, "nquantity")
				ls_Text		= ds_pl_help.Getitemstring(ll_Lauf, "ctext")
				
				ls_Unit = of_check_unit(ds_pl_help.Getitemstring(ll_Lauf, "cunit"))
				
				
				
				ll_Ret = luoCollectTextRows.of_add_row(ls_text, ls_Unit, ll_Quantity)

next	



// das ergebnis abholen
ll_Ret = luoCollectTextRows.of_return_textrows(lstr_LabelPLTexte)

return lstr_LabelPLTexte

end function

public function string of_check_unit (string asitem);// --------------------------------------------------------------------------------
// Objekt : uo_label_other
// Methode: of_check_unit (Function)
// Autor  : M. Barfknecht
// --------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------
// Return: string
// --------------------------------------------------------------------------------
//  Beschreibung: $$HEX1$$dc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$ft, ob der $$HEX1$$fc00$$ENDHEX$$bergebene string im array
//						is_kindsEQ[] vorhanden ist. Falls ja, gibt er einen leeren
//						string zur$$HEX1$$fc00$$ENDHEX$$ck
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  30.08.2012	           M.Barfknecht       Erstellung
//
// --------------------------------------------------------------------------------

string lsreturn
long i

lsreturn = asitem

for i=1 to upperbound(is_kindsEQ)
	
	if is_kindsEQ[i]=trim(asitem) then
		lsreturn = "  "
		exit
	end if
	
next



return lsreturn
end function

public function string of_return_max_text (string arg_text, long arg_row);// --------------------------------------------------------------------------------
// Objekt : uo_label_other
// Methode: of_return_max_text (Function)
// Autor  : M. Barfknecht
// --------------------------------------------------------------------------------
// Argument(e):
// string arg_text -> Der Inhalt des Feldes
//  long arg_row -> die Row in ds_objects, wo die Daten der column stehen
// --------------------------------------------------------------------------------
// Return: string
// --------------------------------------------------------------------------------
//  Beschreibung: Schneidet f$$HEX1$$fc00$$ENDHEX$$r Felder, die autosize-height bekommen,
//						den Text so zurecht, dass er ins Feld passt
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  20.09.2012	           M.Barfknecht       Erstellung
//
// --------------------------------------------------------------------------------

string	lsreturn,ls_test,ls_test_double
long	lheight
long	lwidth
long	lfontsize
string	lsfont
long	lzeile
long	lheight_test,lheight_test_double
decimal dec_heigth_max
decimal dec_width_max
decimal dec_max_sign
decimal dec_rest
decimal dec_height_ganz
decimal dec_width_ganz
long 	lretlength,lflights
long	lwidth_test,lwidth_test_double
long	lret



uo_font_calc uoCalc

uoCalc = create uo_font_calc

//Parameter zum rechnen bef$$HEX1$$fc00$$ENDHEX$$llen

lheight = dsobjects.getitemnumber(arg_row,"nheight")
lwidth = dsobjects.getitemnumber(arg_row,"nwidth")
lfontsize = dsobjects.getitemnumber(arg_row,"nfontsize")
lsfont = dsobjects.getitemstring(arg_row,"cfontname")


//ls_test = '0000, '
ls_test = '0'
lret = uoCalc.of_gettextsize( ls_test, lsfont, lfontsize, false, false,false, lheight_test, lwidth_test)

//Das ganze nochmal mit 2 Zeilen, um den Zeilenabstand zu ermitteln
//ls_test_double = '0000, ~r~n0000,'
ls_test_double = '0~r~n0,'
lret = uoCalc.of_gettextsize( ls_test_double, lsfont, lfontsize, false, false,false, lheight_test_double, lwidth_test_double)

lzeile = lheight_test_double -  lheight_test

//So in lheight_test steht, wie hoch der Text ist und in lwidht_test wie breit
//wir errechnen, wieviele Texte wir in das Feld maximal bekommen k$$HEX1$$f600$$ENDHEX$$nnen
//Anzahl Zeilen
if lheight_test > 0 then
	lheight_test = lheight_test + lzeile
//	dec_rest = mod(lheight,lheight_test)
//	dec_height_ganz=lheight - dec_rest
	dec_heigth_max = lheight / lheight_test
	
else
	destroy(uoCalc)
	return arg_text
end if
//Pro einzelne Zeile
if lwidth_test > 0 then
	//dec_rest = mod(lwidth,lwidth_test)
	//dec_width_ganz=lwidth - dec_rest
	dec_width_max = lwidth / lwidth_test
	if dec_width_max > 1 then
	dec_width_max = dec_width_max - 1 //Eins abziehen um Zeilenumbruch auszugleichen (erfolgt nur bei space)
	end if
else
	destroy(uoCalc)
	return arg_text
end if
//Falls es nicht hochgenug f$$HEX1$$fc00$$ENDHEX$$r eine Zeile ist...
if dec_heigth_max < 1 then 
	dec_heigth_max = 1
end if
dec_max_sign = dec_heigth_max * dec_width_max
dec_max_sign = Round(dec_max_sign,0) //wir runden auf ganzen Wert und ziehen 1 ab
lflights = long(dec_max_sign) //Das ist die Anzahl der Fl$$HEX1$$fc00$$ENDHEX$$ge
lretlength = lflights * len(ls_test)
//Wenn die maximale Zeichenanzahl > oder gleich der Anzahl im $$HEX1$$fc00$$ENDHEX$$bergebenen string ist, sind wir fertig
if lretlength>=len(arg_text) then 
		destroy(uoCalc)
		return arg_text
		
else		
		//Der String ist l$$HEX1$$e400$$ENDHEX$$nger, also schneiden wir ihn zurecht
		lretlength = lflights * len(ls_test)
		//1. Schritt: auf die richtige L$$HEX1$$e400$$ENDHEX$$nge k$$HEX1$$fc00$$ENDHEX$$rzen
		lsreturn = Left(arg_text, lretlength)
		//2. Schritt:
		lsreturn = lsreturn+"(...)"
end if	




destroy(uoCalc)

return lsreturn
end function

public function integer of_draw_barcode (long lrow, datastore ods);
// ## HR vom 09.05.2007 f$$HEX1$$fc00$$ENDHEX$$r PPS 
// ## KF 21.09.2012 von PPS nach CBASE $$HEX1$$fc00$$ENDHEX$$bernommen
// of_draw_barcode

//----------------------------------------------------
// 
// Bitmap Object zeichnen ...
// 
// 
//----------------------------------------------------
long a, lBorder, lFontSize, lFontWeight, lAlign, lUnder, lItalic, lBackMode
Long lBackColor, lFontColor, lR, lM
long lBrushColor, lPenColor, lPenWidth, lBrushHatch, lKey
string sCreate, sName, sVal, sFontName
decimal lX, lY, lW, lH
integer iCount, iId
string sWidth, sHeight, sX, sY, sRet


lX = dsObjects.GetItemNumber(lRow, "nxpos")
lY = dsObjects.GetItemNumber(lRow, "nypos")
lH = dsObjects.GetItemNumber(lRow, "nheight")
lW = dsObjects.GetItemNumber(lRow, "nwidth")
lBorder = dsObjects.GetItemNumber(lRow, "nborderstyle") 
sName = dsObjects.GetItemString(lRow, "cobject_name")
sVal = dsObjects.GetItemString(lRow, "cvalue")
lR = 0 //dsObjects.GetItemNumber(lRow, "nresizeable")
lM = 0 //dsObjects.GetItemNumber(lRow, "nmoveable")

//sCreate = "create bitmap(name=" + sName + " band=detail filename='"+f_gettemppath()+"BARCODE_" + sConatinerNummer + ".BMP' x='" + string(lX, "0") + "' y='" + string(lY, "0") + &
//			 "' height='" + string(lH, "0") + "' width='" + string(lW, "0") + "' border='" + string(lBorder, "0") + "'  resizeable=" +string(lR, "0") + "  moveable=" + string(lM, "0") + "  )"

sCreate = "create compute(name=" + sName + " band=detail expression='bitmap(cfilename)' x='" + string(lX, "0") + "' y='" + string(lY, "0") + &
			 "' height='" + string(lH, "0") + "' width='" + string(lW, "0") + "' border='" + string(lBorder, "0") + "'  resizeable=0 moveable=" + string(lM, "0") + "  )"

//sCreate = "create compute(name=" + sName + " band=detail expression='bitmap(objc4760+~"BARCODE_~"+ ncontainer +~".BMP~")' x='" + string(lX, "0") + "' y='" + string(lY, "0") + &

//bitmap(~"C:\Temp\CBASE\~"+a+~".bmp~")
//compute(band=detail alignment="0" expression="bitmap(~"C:\Temp\CBASE\lh_color.jpg~")"border="0" color="0" x="558" y="12" height="228" width="261" format="[GENERAL]" html.valueishtml="0"  name=compute_1 visible="1"  font.face="Arial" font.height="-12" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16777215" )
//messagebox("",screate)
sRet = oDS.modify(sCreate)

if sRet <> "" then
	of_log("Error -15, create bitmap: " + sRet)
	of_log("Error -15, create syntax: " + sCreate)
	return -15
end if

return 0
end function

public function integer of_create_barcode (long ai_type, string as_file, string as_text, long ai_width, long ai_height, long ai_dpi);/* ### Event: of_create_barcode *******************************************
 *
 * Beschreibung : Funktion zur Erstellung eines Barcodes
 *
 *	Parameter : 	ai_type 	= 	37: Barcode DataMatrix
 * 									 	14: Barcode Code128
 * 						as_file	=	Filename (incl Pfad) des Barcodes
 *						as_text 	= 	Text der im Barcode codiert werden soll
 *			 			ai_width	=	Breite des Barcodes
 *			 			ai_height	=	H$$HEX1$$f600$$ENDHEX$$he des Barcodes
 *			 			ai_dpi		=	Aufl$$HEX1$$f600$$ENDHEX$$sung des Barcodes
 *
 * Aenderungshistorie
 *  Version  Wer                        			Wann        		Was und warum
 *   1.0     	H.Rothenbach /LSY IS       	19.11.2007  	Erstellung
 *	  1.1 		H.Rothenbach /LSY IS       	05.06.2008  	Austausch des Barcodes
 *   1.2		Klaus								21.09.2012		Aus PPS $$HEX1$$fc00$$ENDHEX$$bernommen
 * ### END Eventdoku ***************************************************
 */

return iuoPpsBarcodes.of_create_barcode(ai_type, as_file, as_text, ai_width, ai_height, ai_dpi)

// #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

end function

public function integer of_label_pps (datastore dwdata, integer iprintertype, integer ilabelsort, integer ilabelpagebreak, s_flight strflightinfo, integer ikh_flug);
// ------------------------------------------------------------------------------------
// Erstellen der Labels
//
// Parameter:	dwdata 				dw_1 aus ou_loading_list
// 					iPrinterType			1 = Thermodrucker via Druckertreiber
//											2 = Normaler Drucker (auf Bogen)
//					sFlgnr					Flugnummer (Airline + Flugnummer + Suffix)
//					dDepDate			Abflugdatum
//					sDepTime			Abflugzeit
// 					this.uoResult		Struktur vom Typ str_label_return
//											wird per Referenz $$HEX1$$fc00$$ENDHEX$$bergeben und gef$$HEX1$$fc00$$ENDHEX$$llt
//					ilabelsort				1 = Sortiere die Label nach Bereichen
//											2 = Sortiere die Label nach Galley
//											3 = Sortiere die Label nach Labeltyp innerhalb nach Bereichen
//
//
//	R$$HEX1$$fc00$$ENDHEX$$ckgabe:	 0		alle prima
//					-1		keine Daten in dwdata
//					-2		kein g$$HEX1$$fc00$$ENDHEX$$ltiges Label gefunden
//					-3		ung$$HEX1$$fc00$$ENDHEX$$ltiger Wert in iPrinterType
//					-4		Fehler beim ColumnObject
//					-5		Fehler beim LineObject
//					-6		Fehler beim RectangleObject
//					-7		Fehler beim TextObject
//					-8		Fehler beim BitmapObject
//					-9		Fehler im dsMaster kein oder mehr als ein Datensatz
//					-10	Fehler im dsObjects kein Datensatz
//					-11	Label hat keine Columns
// 					-12	Fehler beim erzeugen der Bitmaps
// 					-13	
// 					-14	Fehler keine Daten in SYS_LABEL_COLUMNS
// ------------------------------------------------------------------------------------
Datetime dtValid, dtSearch
Long lLabelType, lLastLabelType
Long lRows
Long lInsert
Long lFound
Blob bBlob
String sArea, sFilter
integer iRet
long	lPackinglistDetail
long	lPackinglistIndexKey
long	lPackinglistDetailKey
s_packinglist_detail	sLabelPLTexte
integer	i
Long 		lStart, lEnde
String	sWorkStation
string sflgnr

long 						ll_LabelCountRows,  ll_LabelCountDist, ll_LabelCountMax, ll_labelCountEX
Long 						ll_FoundPLDetail, ll_FoundEQ //ll_FoundRTN
string						ls_temp
s_packinglist_detail	lstr_LabelPLTexte, lstr_LabelEmpty, lstr_LabelPLEQ, lstr_LabelPLRTN
Long						ll_PackinglistIndexKey, ll_PackinglistDetailKey
string 					ls_column
long 						ll_height
long 						ll_width
Boolean 					lb_NotExploded = true
integer					li_Succ
Long 						ll_InsertRow, ll_ret

// ------------------------------------------------------------------------------------
// Alle wegfiltern, die nicht gedruckt werden sollen
// ------------------------------------------------------------------------------------
sFilter = dwData.Describe("datawindow.table.filter")

dwData.SetFilter( " nprint = 1 ")
dwData.Filter()

if dwdata.RowCount() = 0 then
	of_log("Error -1, no data found after filtering, RowCount() on dwData = 0 ")
	return -1
end if
// ------------------------------------------------------------------------------------
// Retrieve der Produktgruppen
// ------------------------------------------------------------------------------------	
dsProductGroup.Retrieve("002")

strFlight = strflightinfo

lStart = CPU()

// ------------------------------------------------------------------------------------
// Packing-List Detail in Loadinglist Result einarbeiten
// ------------------------------------------------------------------------------------
lLastLabelType = -1

For lRows = dwData.RowCount()	to 1 Step -1
	lLabelType				= dwData.GetItemNumber(lRows,"cen_packinglists_nlabel_type_key")
	lPackinglistDetail 	= dsObjects.Find("ccolumn = 'pldetail'" , 1, dsObjects.RowCount())
	dtValid 					= of_find_valid_label(lLabelType, Datetime(Date(strFlightInfo.dtDepartureDate),Time("00:00:00")))
	If isnull(dtValid)  then
		continue
	End if
	If lLabelType <> lLastLabelType Then
		dsObjects.Retrieve(lLabelType, dtValid)
		lLastLabelType = lLabelType
	End if	
	
	// -------------------------------------------------------
	// Pr$$HEX1$$fc00$$ENDHEX$$fung des Labeltypes, ob pldetail verwendet wurde.
	// dann werden die daten dazu geholt
	// bei explosion wird immer beides bedient!!
	// f$$HEX1$$fc00$$ENDHEX$$r die berechnung der labelanzahl wird auch font etc. gebraucht
	// -------------------------------------------------------
	// ACHTUNG: 
	// wenn COL_DISTRIBUTED_COMP drin ist, dann k$$HEX1$$f600$$ENDHEX$$nnen schon duplizierte s$$HEX1$$e400$$ENDHEX$$tze da sein
	// diese s$$HEX1$$e400$$ENDHEX$$tze sind mit nduplicated = 1 gekennzeichnet und sollten eigentlich nicht jeder separat gef$$HEX1$$fc00$$ENDHEX$$llt werden...
	// -------------------------------------------------------
	dwData.SetItem(lRows,COL_PLDETAIL_TEXT," ")
	dwData.SetItem(lRows,COL_PLDETAIL_EXPL," ")
	dwData.SetItem(lRows,COL_RTN_COMP," ")
	dwData.SetItem(lRows,COL_EQ_COMP," ")
	
	// das klappt aber nur begrenzt, da oftmals l$$HEX1$$e400$$ENDHEX$$ngere leerstrings drin sind ?!
	if of_checknull(dwData.GetItemString(lRows,"pldetail_label_counter")) = "" then
		dwData.SetItem(lRows,"pldetail_label_counter","1 of 1")			
	end if

	if dwData.GetItemNumber(lRows,"nduplicated") = 1 then
		ll_LabelCountRows++
		ls_temp = dwData.GetItemString(lRows,"pldetail_label_counter")
		ll_LabelCountDist = long(right(ls_temp, len(ls_temp) - LastPos(ls_temp, " ")))
		//		MessageBox(ls_temp, string(LastPos(ls_temp, " ")) + "-" + string(len(ls_temp)) + "-> " +  string(ll_LabelCountDist))
		continue
		
	else
		ls_temp = dwData.GetItemString(lRows,"pldetail_label_counter")
		If trim(ls_Temp) = "" Then
			ll_LabelCountDist = 1
		else
			ll_LabelCountDist = long(right(ls_temp, len(ls_temp) - LastPos(ls_temp, " ")))
		end if	
	end if
	
	ll_LabelCountRows++
	

	ll_FoundPLDetail = dsObjects.Find("ccolumn = '" + COL_PLDETAIL_TEXT + "' OR ccolumn = '" + COL_PLDETAIL_EXPL + "' ", 1, dsObjects.RowCount())
//	ll_FoundRTN = dsObjects.Find("ccolumn = '" + COL_RTN_COMP + "'", 1, dsObjects.RowCount())
	ll_FoundEQ = dsObjects.Find("ccolumn = '" + COL_EQ_COMP + "'", 1, dsObjects.RowCount())

	if ll_FoundPLDetail > 0 or  ll_FoundEQ > 0 then //ll_FoundRTN > 0 or
		lstr_LabelPLTexte = lstr_LabelEmpty
		//lstr_LabelPLRTN = lstr_LabelEmpty
		lstr_LabelPLEQ = lstr_LabelEmpty
		ll_PackinglistIndexKey = dwData.GetItemNumber(lRows,"cen_packinglist_index_npackinglist_index_key")
		ll_PackinglistDetailKey	= dwData.GetItemNumber(lRows,"cen_packinglists_npackinglist_detail_key")
		
		if ll_FoundPLDetail > 0 then
			ls_Column				= dsObjects.Getitemstring(ll_FoundPLDetail,"ccolumn")
			sPLFontname			= dsObjects.Getitemstring(ll_FoundPLDetail,"cfontname")
			iPLFontweight			= dsObjects.Getitemnumber(ll_FoundPLDetail,"nfontweight")
			iPLFontsize				= dsObjects.Getitemnumber(ll_FoundPLDetail,"nfontsize") * -1
			iPLObjectHeight			= dsObjects.Getitemnumber(ll_FoundPLDetail,"nheight")
			iuo_FontCalc.of_GetTextSize("Calculate", sPLFontName, iPLFontSize, false, false, false, ll_height, ll_width)
			iPLTextHeight = Integer(ll_height)
			this.ii_TextRowsIn_PLDETAIL = truncate(iPLObjectHeight  / (iPLTextHeight + 1), 0)

			// Struktur mit Labeltexten f$$HEX1$$fc00$$ENDHEX$$llen
			choose case ls_column
			case COL_PLDETAIL_TEXT
				lstr_LabelPLTexte = of_create_pl_detail(ll_PackinglistIndexKey, ll_PackinglistDetailKey, strFlightInfo.dtDepartureDate)
			case COL_PLDETAIL_EXPL
			// 20.10.2010 Neu: Explosion "Explode item lists to lowest level"	
			// CBASE-NAM-CR-0029-Cart Diagram Add Req_Final
				lstr_LabelPLTexte = of_create_pl_explosion(ll_PackinglistIndexKey, ll_PackinglistDetailKey, strFlightInfo.dtDepartureDate)
				lb_NotExploded = false
			case else
				lstr_LabelPLTexte = of_create_pl_detail(ll_PackinglistIndexKey, ll_PackinglistDetailKey, strFlightInfo.dtDepartureDate)
			end choose
			// daten ins 1. label direkt eintragen
			dwData.SetItem(lRows, COL_PLDETAIL_TEXT, lstr_LabelPLTexte.cdetail_text[1])
			If ls_Column = COL_PLDETAIL_EXPL Then
				li_Succ = dwData.SetItem(lRows, COL_PLDETAIL_EXPL, lstr_LabelPLTexte.cdetail_text[1])
			End If
		end if 		// das waren die details

		if ll_FoundEQ> 0 then
			sPLFontname			= dsObjects.Getitemstring(ll_FoundEQ,"cfontname")
			iPLFontweight			= dsObjects.Getitemnumber(ll_FoundEQ,"nfontweight")
			iPLFontsize				= dsObjects.Getitemnumber(ll_FoundEQ,"nfontsize") * -1
			iPLObjectHeight			= dsObjects.Getitemnumber(ll_FoundEQ,"nheight")
			iuo_FontCalc.of_GetTextSize("Calculate", sPLFontName, iPLFontSize, false, false, false, ll_height, ll_width)
			iPLTextHeight = Integer(ll_height)
			this.ii_TextRowsIn_EQ_COMP	= truncate(iPLObjectHeight  / (iPLTextHeight + 1), 0)
			// Struktur mit Labeltexten f$$HEX1$$fc00$$ENDHEX$$llen
			 of_create_pl_eq(ll_PackinglistIndexKey, strFlightInfo.dtDepartureDate, lb_NotExploded,lstr_LabelPLEQ)		
			// daten ins 1. label direkt eintragen
			dwData.SetItem(lRows, COL_EQ_COMP, lstr_LabelPLEQ.cdetail_text[1])
		end if 		// das waren die EQs
		
		// dann die buchhaltung: label-z$$HEX1$$e400$$ENDHEX$$hler
		ll_labelCountEX = max(Upperbound(lstr_LabelPLRTN.cdetail_text),Upperbound(lstr_LabelPLEQ.cdetail_text))
		ll_LabelCountMax = max(Upperbound(lstr_LabelPLTexte.cdetail_text), ll_labelCountEX)
		ll_LabelCountMax = max(ll_LabelCountMax, ll_LabelCountDist)
		dwData.SetItem(lRows, "pldetail_label_counter", "1 of " + string(ll_LabelCountMax))
		
		// -------------------------------------------------------
		// Sind Labels zu duplizieren ?
		// solange noch welche aus distribution da sind, die bef$$HEX1$$fc00$$ENDHEX$$llen, dann erst kopieren
		// -------------------------------------------------------
		if Max(Upperbound(lstr_LabelPLTexte.cdetail_text), ll_labelCountEX) > 1 then
			for i = 2 to Max(Upperbound(lstr_LabelPLTexte.cdetail_text), ll_labelCountEX) step 1
				
				// solange noch welche aus distribution da sind, die bef$$HEX1$$fc00$$ENDHEX$$llen
				if i <= ll_LabelCountRows then
					ll_InsertRow = lRows + i -1
				else
				// zeile kopieren
					ll_Ret = dwData.RowsCopy(lRows, lRows, Primary!, dwData, dwData.Rowcount() + 1, Primary!)
					ll_InsertRow = dwData.Rowcount()
					li_Succ = dwData.SetItem(ll_InsertRow, COL_DISTRIBUTED_COMP, "")
				end if
				// detail-daten rein ? 
				if i <= Upperbound(lstr_LabelPLTexte.cdetail_text) then
					li_Succ = dwData.SetItem(ll_InsertRow, COL_PLDETAIL_TEXT, lstr_LabelPLTexte.cdetail_text[i])
					if ls_Column = COL_PLDETAIL_EXPL then
						li_Succ = dwData.SetItem(ll_InsertRow, COL_PLDETAIL_EXPL ,lstr_LabelPLTexte.cdetail_text[i])
					end if
				else
					li_Succ = dwData.SetItem(ll_InsertRow, COL_PLDETAIL_TEXT, "")
					if ls_Column = COL_PLDETAIL_EXPL then li_Succ = dwData.SetItem(ll_InsertRow, COL_PLDETAIL_EXPL, "")
				end if
				
				// RTN-daten rein ?
				if i <= Upperbound(lstr_LabelPLRTN.cdetail_text) then
					li_Succ = dwData.SetItem(ll_InsertRow, COL_RTN_COMP, lstr_LabelPLRTN.cdetail_text[i])
				else
					li_Succ = dwData.SetItem(ll_InsertRow, COL_RTN_COMP, "")
				end if
				// EQ-daten rein ?
				if i <= Upperbound(lstr_LabelPLEQ.cdetail_text) then
					li_Succ = dwData.SetItem(ll_InsertRow, COL_EQ_COMP, lstr_LabelPLEQ.cdetail_text[i])
				else
					li_Succ = dwData.SetItem(ll_InsertRow, COL_EQ_COMP, "")
				end if
				// label-z$$HEX1$$e400$$ENDHEX$$hler
				dwData.SetItem(ll_InsertRow,"pldetail_label_counter", string(i) + " of " + string(ll_LabelCountMax))
//				if ll_LabelCountMax > 9 then
//					dwData.SetItem(ll_InsertRow,"pldetail_label_counter", string(i,"00") + " of " + string(ll_LabelCountMax))
//				end if
				dwData.SetItem(ll_InsertRow,"nduplicated", 1)
				// ------------------------------------------------------------------
				// 26.02.07, KF
				// Verteilte Mahlzeiten auf dem zweiten Label nicht mehr anzeigen
				// (da die im DW in einer column schon eingetragen sind, m$$HEX1$$fc00$$ENDHEX$$ssen sie also gel$$HEX1$$f600$$ENDHEX$$scht werden)
				// NUR NOCH, wenn wirklich dupliziert wird
				// ------------------------------------------------------------------
//				dwData.SetItem(dwData.Rowcount(), COL_DISTRIBUTED_COMP, "")
			next
		end if 	// label war zu duplizieren

	end if 		// pldetail etc. gefunden
	
	// z$$HEX1$$e400$$ENDHEX$$hler zur$$HEX1$$fc00$$ENDHEX$$cksetzen
	ll_LabelCountDist = 0
	ll_LabelCountRows = 0

	
//	##############

	/*
	lFound = dsObjects.Find("ccolumn = 'pldetail_text'",1, dsObjects.RowCount())
	
	If lFound > 0 Then
		sPLFontname			= dsObjects.Getitemstring(lFound,"cfontname")
		iPLFontweight			= dsObjects.Getitemnumber(lFound,"nfontweight")
		iPLFontsize				= dsObjects.Getitemnumber(lFound,"nfontsize") * -1
		iPLObjectHeight			= dsObjects.Getitemnumber(lFound,"nheight")
//		iPLTextHeight  			= oleprinter.GetTextHeight("Calculate",2,sPLFontName, iPLFontSize, False, False) + 2
//		iPLTextRowsInObject		= iPLObjectHeight / iPLTextHeight
		lPackinglistIndexKey 	= dwData.GetItemNumber(lRows,"cen_packinglist_index_npackinglist_index_key")
		lPackinglistDetailKey	= dwData.GetItemNumber(lRows,"cen_packinglists_npackinglist_detail_key")
//####
		ls_Column							= dsObjects.Getitemstring(lFound,"ccolumn")
		iuo_FontCalc.of_GetTextSize("Calculate", sPLFontName, iPLFontSize, false, false, false, ll_height, ll_width)
		iPLTextHeight 						= Integer(ll_height)
		this.ii_TextRowsIn_PLDETAIL	 = truncate(iPLObjectHeight  / (iPLTextHeight + 1), 0)

//###
		// -------------------------------------------------------
		// Struktur mit Labeltexten f$$HEX1$$fc00$$ENDHEX$$llen
		// -------------------------------------------------------
		sLabelPLTexte = of_create_pl_detail(lPackinglistIndexKey,lPackinglistDetailKey, strFlightInfo.dtDepartureDate)
		dwData.SetItem(lRows,"pldetail_text",sLabelPLTexte.cdetail_text[1])
		dwData.SetItem(lRows,"pldetail_label_counter","1 of " + string(Upperbound(sLabelPLTexte.cdetail_text)))
		// -------------------------------------------------------
		// Sind Labels zu duplizieren ?
		// -------------------------------------------------------
		If Upperbound(sLabelPLTexte.cdetail_text) > 1 Then
			For i = 2 to Upperbound(sLabelPLTexte.cdetail_text)
				dwData.RowsCopy(lRows,lRows,Primary!,dwData,dwData.Rowcount() + 1,Primary!)
				dwData.SetItem(dwData.Rowcount(),"pldetail_text",sLabelPLTexte.cdetail_text[i])
				dwData.SetItem(dwData.Rowcount(),"pldetail_label_counter", string(i) + " of " + string(Upperbound(sLabelPLTexte.cdetail_text)))
			Next	
		End if	
	Else
		
		if of_checknull(dwData.GetItemString(lRows,"pldetail_label_counter")) = "" then
			dwData.SetItem(lRows,"pldetail_text"," ")
			dwData.SetItem(lRows,"pldetail_label_counter","1 of 1")			
		end if

	End if
*/		
next

lLastLabelType		= 0
lLabelType			= 0

lEnde = CPU()

// -----------------------------------------
// Columndefinitionen aus SYS_LABEL_COLUMNS
// -----------------------------------------
if dsColumns.Retrieve() <= 0 then
	of_log("Error -14, no data from SYS_LABEL_COLUMNS")
	return -1
end if

// --------------------------------------------------------------------------------------------------------------------
// 05.02.2014 HR: Labelsortierung
// --------------------------------------------------------------------------------------------------------------------
choose case iLabelSort
	case 1
		iRet = dwData.SetSort("cen_loadinglists_nbelly_container A, carea_code A, cen_packinglists_nlabel_type_key A, cen_stowage_nsort A, cen_packinglist_index_cpackinglist A, pldetail_label_counter A")	
	case 2
		iRet = dwData.SetSort("cen_loadinglists_nbelly_container A, cen_packinglists_nlabel_type_key A, cen_stowage_nsort A, cen_packinglist_index_cpackinglist A, pldetail_label_counter A")
	case 3
		iRet = dwData.SetSort("cen_loadinglists_nbelly_container A, cen_packinglists_nlabel_type_key A, carea_code A, cen_stowage_nsort A, cen_packinglist_index_cpackinglist A, pldetail_label_counter A")
	case 4 // 30.09.2015 HR: CBASE-DE-CR-2015-060 Nach Rampenfeinsteuerung
		iRet = dwData.SetSort("nrowid A, cen_loadinglists_nbelly_container A, crampbox A, carea_code A, cen_packinglists_nlabel_type_key A, cen_stowage_nsort A, cen_packinglist_index_cpackinglist A, pldetail_label_counter A")	
end choose

dwData.Sort()

if iRet = -1 then
	of_log("Error -1, wrong sort criteria")
	return -1
end if

// -----------------------------------------
// Label bauen
// -----------------------------------------
isBelly 			= of_isbelly(dwData.GetItemNumber(1, "cen_loadinglists_nbelly_container"))
lLabelType 		= dwData.GetItemNumber(1, "cen_packinglists_nlabel_type_key")
iRet 				= of_build_label(Date(strFlightInfo.dtDepartureDate), lLabelType, iPrinterType)

if iRet <> 0 then
	return iRet
end if

// -----------------------------------------
// Bilder blobben
// -----------------------------------------
str_bitmaps strBMP[]
iRet = of_create_pictures(strBMP)

if iRet <> 0 then
	return iRet
end if
// -----------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r den Spooler noch nen Namen geben
// -----------------------------------------
sflgnr=	strFlightInfo.sAirline + strFlightInfo.sFlightNumber

dsLayout.Modify("datawindow.print.documentname = 'Labelprint: " + strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber + " " + String(Date(strFlightInfo.dtDepartureDate)) + "/" + strFlightInfo.cDepartureTime + "'")
isBelly 	= of_isbelly(dwData.GetItemNumber(1, "cen_loadinglists_nbelly_container"))
sArea		= dwData.GetItemString(1, "carea_code")

// -----------------------------------------
// dw_loadinglist_result "zerlegen"
// -----------------------------------------
of_analyse(dwData)

lStart = CPU()

For lRows = 1 to dwData.RowCount()
	
	// -----------------------------------------------------------------
	// Achtung: Stationsauftrag
	// Nur die Packinglists ber$$HEX1$$fc00$$ENDHEX$$cksichtigen, die auch f$$HEX1$$fc00$$ENDHEX$$r die Station 
	// interessant sind.
	// -----------------------------------------------------------------
	if dwData.GetItemNumber(lRows, "stationinstruction") = 0 then
		continue
	end if

	// --------------------------------------------------------------------------------------------------------------------
	// Nachschaun, on sich der Labeltyp oder Belly ge$$HEX1$$e400$$ENDHEX$$ndert hat
	// dann ggf. neues Layout (kompl. Reset auf dsLayout und neu Zeichnen)
	// --------------------------------------------------------------------------------------------------------------------
	//
	// Was macht das folgende IF ???
	//
	// 1. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Sortierung nach Galley = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + iLabelSort = 2
	//
	// 2. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Area unver$$HEX1$$e400$$ENDHEX$$ndert + Sortierung nach Area = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + sArea = dwDat..  + iLabelSort = 1
	//
	// 3. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Area VER$$HEX1$$c400$$ENDHEX$$NDERT + Sortierung nach Area + Areas fortlaufend = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + sArea <> dwDat.+ iLabelSort = 1       + iLabelPageBreak = 0
	//
	// --------------------------------------------------------------------------------------------------------------------
		
	if 1=1		then  
		
		// -------------------------------------------------
		// Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert, dann Daten reinpacken
		// -------------------------------------------------
		
		lInsert = dsLayout.InsertRow(0)	
		
		dsLayout.SetItem(lInsert, "nobject_type", lInsert)
		dsLayout.SetItem(lInsert, "nbelly", of_checknull(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")))
		dsLayout.SetItem(lInsert, "carea", of_checknull(dwData.GetItemString(lRows, "carea")))
		dsLayout.SetItem(lInsert, "cworkstation", of_checknull(dwData.GetItemString(lRows, "cworkstation")))
		dsLayout.SetItem(lInsert, "cfilename", f_gettemppath()+"BARCODE_"+of_checknull(dwData.GetItemString(lRows, "cppscontainer"))+".BMP")
		
		//HR 20.05.2008 Packinglist und Labeltype im Label vermerken
		dsLayout.SetItem(lInsert, "cpackinglist",dwData.GetItemString(lRows,"cen_packinglist_index_cpackinglist"))
		dsLayout.SetItem(lInsert, "nlabel_type_key",dwData.GetItemNumber(lRows,"cen_packinglists_nlabel_type_key"))
		    
		//HR 05.06.2008 Flugnummer und Abflug im Label vermerken
		dsLayout.SetItem(lInsert, "cabflug",strFlightInfo.cDepartureTime)
		dsLayout.SetItem(lInsert, "cflgnummer",strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber)
		
		
		//HR 16.05.2008 Containerkey im Layout eingef$$HEX1$$fc00$$ENDHEX$$gt
		if dwData.GetItemNumber(lRows, "nflight_label")>1 then
			dsLayout.SetItem(lInsert, "ncontainer_key",0)
		else
			dsLayout.SetItem(lInsert, "ncontainer_key",long(dwData.GetItemString(lRows, "cppscontainer")))
		end if	
		
		if ikh_flug = 0 then	
			of_fill_columns(lRows, &
								 lInsert, &
								 dwData, &
								 strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber, &
								 Date(strFlightInfo.dtDepartureDate), &
								 strFlightInfo.cDepartureTime, &
								 strFlightInfo.sDestination, &
								 strFlightInfo.sOwner + " " + strFlightInfo.sActype, &
								 strFlightInfo.sConfiguration, &
							 	 strFlightInfo.sDeparture )
		else
			of_fill_columns(lRows, &
								 lInsert, &
								 dwData, &
								" ", &
								 Date(strFlightInfo.dtDepartureDate), &
								 " ", &
								 " ", &
								 " " , &
								 " " , &
								 " " )
			
		end if
	else
		// -------------------------------------------------------------------
		// Labeltyp oder Belly hat sich ge$$HEX1$$e400$$ENDHEX$$ndert, den Datastore (dsLayout)
		// in das UserObject packen und den neuen Labeltyp bauen
		// -------------------------------------------------------------------
		iRet = dsLayout.GetFullState(bBlob)
		
		if iRet = -1 then
			return -13
		end if
		
		iRetCount ++		
		this.uoResult[iRetCount] = Create uo_label_return
		this.uoResult[iRetCount].llabeltype = lLabelType
		this.uoResult[iRetCount].bLabel = bBlob					// alle Label eines Labeltyps

		if isBelly then
			this.uoResult[iRetCount].sLabel = sflgnr+" "+sLabel + " (Belly)" 
		else
			this.uoResult[iRetCount].sLabel = sflgnr+" "+sLabel
		end if
		
		this.uoResult[iRetCount].sLabelComment = sArea
		this.uoResult[iRetCount].sWorkstation	= sWorkStation
		this.uoResult[iRetCount].isBelly = isBelly
		this.uoResult[iRetCount].iLabelSort = iLabelSort
		this.uoResult[iRetCount].iLabelPageBreak = iLabelPageBreak		
		this.uoResult[iRetCount].sGeneratedForPrinter = this.sGeneratedForPrinter
		// -----------------------------------------------------------
		// Neuen Label-Typ zeichnen, wenn er sich ge$$HEX1$$e400$$ENDHEX$$ndert hat
		// -----------------------------------------------------------
		lLabelType = dwData.GetItemNumber(lRows, "cen_packinglists_nlabel_type_key") 
		isBelly = of_isbelly(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container"))
		
		if lLabelType <> lLastLabelType or isBelly = True then
		
			iRet = of_build_label(date(strFlightInfo.dtDepartureDate), lLabelType, iPrinterType)
			
			if iRet <> 0 then
				return iRet
			end if
			
			lLastLabelType = lLabelType 
			
		else
			
			dsLayout.Reset()
			
		end if
		
		lInsert = dsLayout.InsertRow(0)	
		dsLayout.SetItem(lInsert, "nobject_type", lInsert)
		dsLayout.SetItem(lInsert, "nbelly", of_checknull(dwData.GetItemNumber(lRows, "cen_loadinglists_nbelly_container")))
		dsLayout.SetItem(lInsert, "carea", of_checknull(dwData.GetItemString(lRows, "carea")))
		dsLayout.SetItem(lInsert, "cworkstation", of_checknull(dwData.GetItemString(lRows, "cworkstation")))
		dsLayout.SetItem(lInsert, "cfilename", f_gettemppath()+"BARCODE_"+of_checknull(dwData.GetItemString(lRows, "cppscontainer"))+".BMP")

		//HR 20.05.2008 Packinglist und Labeltype im Label vermerken
		dsLayout.SetItem(lInsert, "cpackinglist",dwData.GetItemString(lRows,"cen_packinglist_index_cpackinglist"))
		dsLayout.SetItem(lInsert, "nlabel_type_key",dwData.GetItemNumber(lRows,"cen_packinglists_nlabel_type_key"))

		//HR 05.06.2008 Flugnummer und Abflug im Label vermerken
		dsLayout.SetItem(lInsert, "cabflug",strFlightInfo.cDepartureTime)
		dsLayout.SetItem(lInsert, "cflgnummer",strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber)
		
		//HR 16.05.2008 Containerkey im Layout eingef$$HEX1$$fc00$$ENDHEX$$gt
		if dwData.GetItemNumber(lRows, "nflight_label")>1 then
			dsLayout.SetItem(lInsert, "ncontainer_key",0)
		else
			dsLayout.SetItem(lInsert, "ncontainer_key",long(dwData.GetItemString(lRows, "cppscontainer")))
		end if	

		if ikh_flug = 0 then	
			of_fill_columns(lRows, &
								 lInsert, &
								 dwData, &
								 strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber, &
								 Date(strFlightInfo.dtDepartureDate), &
								 strFlightInfo.cDepartureTime, &
								 strFlightInfo.sDestination, &
								 strFlightInfo.sOwner + " " + strFlightInfo.sActype,&
								 strFlightInfo.sConfiguration, &
							 	 strFlightInfo.sDeparture )
		else
			of_fill_columns(lRows, &
								 lInsert, &
								 dwData, &
								" ", &
								 Date(strFlightInfo.dtDepartureDate), &
								 " ", &
								 " ", &
								 " " , &
								 " ", &
								 " "  )

			
		end if

		
	end if

	sArea 			= dwData.GetItemString(lRows, "carea_code")
	sWorkStation 	= dwData.GetItemString(lRows, "cworkstation_text")
	f_yield(lRoleID)		
	//messagebox("DANACH !!!!!!!!!!!!!", "Zeile " + string(lRows) + " von " + string(dwData.RowCount()))

Next


iRet = dsLayout.GetFullState(bBlob)
if iRet = -1 then
	return -13
end if

// messagebox("DANACH !!!!!!!!!!!!!", "1")
// -----------------------------------------------------------
// R$$HEX1$$fc00$$ENDHEX$$ckgabe: Array von uo_label_return - Objekten
// -----------------------------------------------------------
iRetCount ++				
this.uoResult[iRetCount] = Create uo_label_return
this.uoResult[iRetCount].bLabel = bBlob
this.uoResult[iRetCount].lLabeltype = lLabelType

if isBelly then
	this.uoResult[iRetCount].sLabel = sflgnr+"/"+string(strFlightInfo.dtDepartureDate,"dd.")+" "+sLabel + " (Belly)" 
else
	this.uoResult[iRetCount].sLabel = sflgnr+"/"+string(strFlightInfo.dtDepartureDate,"dd.")+" "+sLabel
end if

this.uoResult[iRetCount].sLabelComment = sArea
this.uoResult[iRetCount].sWorkstation = sWorkstation
this.uoResult[iRetCount].isBelly = isBelly
this.uoResult[iRetCount].iLabelSort = iLabelSort
this.uoResult[iRetCount].iLabelPageBreak = iLabelPageBreak
this.uoResult[iRetCount].sGeneratedForPrinter = this.sGeneratedForPrinter

this.of_destroy_layout()
lEnde = CPU()

//of_log(String((lEnde - lStart) / 1000, "00.00") + " building all Labels")

return 0//

return 0
end function

public function integer of_label_pps_production (datastore dwdata, integer iprintertype, integer ilabelsort, integer ilabelpagebreak, s_flight strflightinfo);// ------------------------------------------------------------------------------------
// Erstellen der Labels
//
// Parameter:	dwdata 				dw_1 aus ou_loading_list
// 					iPrinterType			1 = Thermodrucker via Druckertreiber
//											2 = Normaler Drucker (auf Bogen)
//					sFlgnr					Flugnummer (Airline + Flugnummer + Suffix)
//					dDepDate			Abflugdatum
//					sDepTime			Abflugzeit
// 					strRet					Struktur vom Typ str_label_return
//											wird per Referenz $$HEX1$$fc00$$ENDHEX$$bergeben und gef$$HEX1$$fc00$$ENDHEX$$llt
//					ilabelsort				1 = Sortiere die Label nach Bereichen
//											2 = Sortiere die Label nach Galley
//
//
//	R$$HEX1$$fc00$$ENDHEX$$ckgabe:	 0		alle prima
//					-1		keine Daten in dwdata
//					-2		kein g$$HEX1$$fc00$$ENDHEX$$ltiges Label gefunden
//					-3		ung$$HEX1$$fc00$$ENDHEX$$ltiger Wert in iPrinterType
//					-4		Fehler beim ColumnObject
//					-5		Fehler beim LineObject
//					-6		Fehler beim RectangleObject
//					-7		Fehler beim TextObject
//					-8		Fehler beim BitmapObject
//					-9		Fehler im dsMaster kein oder mehr als ein Datensatz
//					-10	Fehler im dsObjects kein Datensatz
//					-11	Label hat keine Columns
// 					-12	Fehler beim erzeugen der Bitmaps
// 					-13	
// 					-14	Fehler keine Daten in SYS_LABEL_COLUMNS
// ------------------------------------------------------------------------------------
Datetime dtValid, dtSearch
Long lLabelType, lLastLabelType
Long lRows
Long lInsert
Long lFound
Blob bBlob
String sArea, sFilter, sWorkstation
integer iRet
long	lPackinglistDetail
long	lPackinglistIndexKey
long	lPackinglistDetailKey
s_packinglist_detail	sLabelPLTexte
integer	i
Long lStart, lEnde
str_bitmaps strbmp[]
uo_label_return strret[]

// ------------------------------------------------------------------------------------
// Mal schaun, ob $$HEX1$$fc00$$ENDHEX$$berhaupt Daten drin sind
// ------------------------------------------------------------------------------------
if dwdata.RowCount() = 0 then
	of_log("Error -1, no data found, RowCount() on dwData = 0 ")
	return -1
end if
// ------------------------------------------------------------------------------------
// Retrieve der Produktgruppen
// ------------------------------------------------------------------------------------	
dsProductGroup.Retrieve("002")

strFlight = strflightinfo

// ------------------------------------------------------------------------------------
// 
// ------------------------------------------------------------------------------------
lLastLabelType 		= -1
lLastLabelType		= 0
lLabelType			= 0

// -----------------------------------------
// Columndefinitionen aus SYS_LABEL_COLUMNS
// -----------------------------------------
dsColumns.dataobject = "dw_label_print_prod_columns"
dsColumns.SetTransObject(sqlca)
if dsColumns.Retrieve() <= 0 then
	of_log("Error -14, no data from SYS_LABEL_COLUMNS_PROD")
	return -1
end if
// -----------------------------------------
// Label bauen
// -----------------------------------------
// f_print_datastore(dwdata)

lLabelType = dwData.GetItemNumber(1, "nlabel_type_key")
isBelly 	= of_isbelly(dwData.GetItemNumber(1, "nbelly"))
iRet = of_build_label(Date(strFlightInfo.dtDepartureDate), lLabelType, iPrinterType)
lLastLabelType = lLabelType

if iRet <> 0 then
	return iRet
end if

// -----------------------------------------
// Bilder blobben
// -----------------------------------------
iRet = of_create_pictures(strBMP)
if iRet <> 0 then
	return iRet
end if
// -----------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r den Spooler noch nen Namen geben
// -----------------------------------------
dsLayout.Modify("datawindow.print.documentname = 'Bulklabel'")
sArea		= dwData.GetItemString(1, "cworkstation")

// -----------------------------------------
// dw_loadinglist_result "zerlegen"
// -----------------------------------------
of_analyse(dwData)

lStart = CPU()

For lRows = 1 to dwData.RowCount()
	
	// --------------------------------------------------------------------------------------------------------------------
	// Nachschaun, on sich der Labeltyp oder Belly ge$$HEX1$$e400$$ENDHEX$$ndert hat
	// dann ggf. neues Layout (kompl. Reset auf dsLayout und neu Zeichnen)
	// --------------------------------------------------------------------------------------------------------------------
	//
	// Was macht das folgende IF ???
	//
	// 1. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Sortierung nach Galley = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + iLabelSort = 2
	//
	// 2. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Area unver$$HEX1$$e400$$ENDHEX$$ndert + Sortierung nach Area = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + sArea = dwDat..  + iLabelSort = 1
	//
	// 3. Pr$$HEX1$$fc00$$ENDHEX$$fung
	//    Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert + Belly unver$$HEX1$$e400$$ENDHEX$$ndert + Area VER$$HEX1$$c400$$ENDHEX$$NDERT + Sortierung nach Area + Areas fortlaufend = TRUE
	//    lLabelType = .....   + of_isbelly(dw...) + sArea <> dwDat.+ iLabelSort = 1       + iLabelPageBreak = 0
	//
	// --------------------------------------------------------------------------------------------------------------------
		
	if (	lLabelType = dwData.GetItemNumber(lRows, "nlabel_type_key") and &
			of_isbelly(dwData.GetItemNumber(lRows, "nbelly")) = isBelly and &
			iLabelSort = 2 &
		) 	&
		or &
		(	lLabelType = dwData.GetItemNumber(lRows, "nlabel_type_key") and &
			of_isbelly(dwData.GetItemNumber(lRows, "nbelly")) = isBelly and &
			sArea = dwData.GetItemString(lRows, "cworkstation") and &
			iLabelSort = 1 &
		) &
		or &
		(	lLabelType = dwData.GetItemNumber(lRows, "nlabel_type_key") and &
			of_isbelly(dwData.GetItemNumber(lRows, "nbelly")) = isBelly and &
			dwData.GetItemString(lRows, "cworkstation") <> sArea and &
			iLabelSort = 1 and &
			iLabelPageBreak = 0 &
		) &
		then  

//	if (	lLabelType = dwData.GetItemNumber(lRows, "nlabel_type_key") and &
//			of_isbelly(dwData.GetItemNumber(lRows, "nbelly")) = isBelly &
//		) 	then  

		// -------------------------------------------------
		// Labeltyp unver$$HEX1$$e400$$ENDHEX$$ndert, dann Daten reinpacken
		// -------------------------------------------------
		lInsert = dsLayout.InsertRow(0)	
		
		dsLayout.SetItem(lInsert, "nobject_type", lInsert)
		dsLayout.SetItem(lInsert, "nbelly", of_checknull(dwData.GetItemNumber(lRows, "nbelly")))
		dsLayout.SetItem(lInsert, "carea", of_checknull(dwData.GetItemString(lRows, "carea")))
		dsLayout.SetItem(lInsert, "cworkstation", of_checknull(dwData.GetItemString(lRows, "clabel_workstation")))
		dsLayout.SetItem(lInsert, "cfilename", f_gettemppath()+"BARCODE_"+of_checknull(dwData.GetItemString(lRows, "cppscontainer"))+".BMP")

		//HR 20.05.2008 Packinglist und Labeltype im Label vermerken
		// dsLayout.SetItem(lInsert, "cpackinglist",dwData.GetItemString(lRows,"cen_packinglist_index_cpackinglist"))
		// dsLayout.SetItem(lInsert, "nlabel_type_key",dwData.GetItemNumber(lRows,"cen_packinglists_nlabel_type_key"))
				
		//HR 16.05.2008: Containerkey zum Auswerten eingef$$HEX1$$fc00$$ENDHEX$$gt
		dsLayout.SetItem(lInsert, "ncontainer_key",0)
		
		of_fill_prod_columns(lRows, &
							 lInsert, &
							 dwData, &
							 strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber, &
							 Date(strFlightInfo.dtDepartureDate), &
							 strFlightInfo.cDepartureTime, &
							 strFlightInfo.sDestination, &
							 strFlightInfo.sOwner + " " + strFlightInfo.sActype )

		
//		Messagebox("if     ", String(lLabelType) + " = " + string(isbelly) + " - " + sArea)

	else
		
				
//		Messagebox("else     ", String(lLabelType) + " = " + string(isbelly) + " - " + sArea)

		
		// -------------------------------------------------------------------
		// Labeltyp oder Belly hat sich ge$$HEX1$$e400$$ENDHEX$$ndert, den Datastore (dsLayout)
		// in das UserObject packen und den neuen Labeltyp bauen
		// -------------------------------------------------------------------
		iRet = dsLayout.GetFullState(bBlob)
		
		if iRet = -1 then
			return -13
		end if
		
		iRetCount ++		
		strRet[iRetCount] = Create uo_label_return
		strRet[iRetCount].llabeltype = lLabelType
		strRet[iRetCount].bLabel = bBlob					// alle Label eines Labeltyps

		if isBelly then
			strRet[iRetCount].sLabel = sLabel + " (Belly)" 
		else
			strRet[iRetCount].sLabel = sLabel
		end if
		
		strRet[iRetCount].sLabelComment = sArea
		strRet[iRetCount].sWorkstation = sWorkstation
		strRet[iRetCount].isBelly = isBelly
		strRet[iRetCount].iLabelSort = iLabelSort
		strRet[iRetCount].iLabelPageBreak = iLabelPageBreak		
		strRet[iRetCount].sGeneratedForPrinter = this.sGeneratedForPrinter
		// -----------------------------------------------------------
		// Neuen Label-Typ zeichnen, wenn er sich ge$$HEX1$$e400$$ENDHEX$$ndert hat
		// -----------------------------------------------------------
		lLabelType 	= dwData.GetItemNumber(lRows, "nlabel_type_key") 
		isBelly 		= of_isbelly(dwData.GetItemNumber(lRows, "nbelly"))
		
		iRet = of_build_label(date(strFlightInfo.dtDepartureDate), lLabelType, iPrinterType)
		
		if iRet <> 0 then
			return iRet
		end if
		
		lLastLabelType = lLabelType 
		
		lInsert = dsLayout.InsertRow(0)	
		dsLayout.SetItem(lInsert, "nobject_type", lInsert)
		dsLayout.SetItem(lInsert, "nbelly", of_checknull(dwData.GetItemNumber(lRows, "nbelly")))
		dsLayout.SetItem(lInsert, "carea", of_checknull(dwData.GetItemString(lRows, "carea")))
		dsLayout.SetItem(lInsert, "cworkstation", of_checknull(dwData.GetItemString(lRows, "clabel_workstation")))
		dsLayout.SetItem(lInsert, "cfilename", f_gettemppath()+"BARCODE_"+of_checknull(dwData.GetItemString(lRows, "cppscontainer"))+".BMP")

		//HR 20.05.2008 Packinglist und Labeltype im Label vermerken
		dsLayout.SetItem(lInsert, "cpackinglist",dwData.GetItemString(lRows,"cen_packinglist_index_cpackinglist"))
		dsLayout.SetItem(lInsert, "nlabel_type_key",dwData.GetItemNumber(lRows,"cen_packinglists_nlabel_type_key"))
				
		//HR 16.05.2008: Containerkey zum Auswerten eingef$$HEX1$$fc00$$ENDHEX$$gt
		dsLayout.SetItem(lInsert, "ncontainer_key",0)

		of_fill_prod_columns(lRows, &
							 lInsert, &
							 dwData, &
							 strFlightInfo.sAirline + " " + strFlightInfo.sFlightNumber, &
							 Date(strFlightInfo.dtDepartureDate), &
							 strFlightInfo.cDepartureTime, &
							 strFlightInfo.sDestination, &
							 strFlightInfo.sOwner + " " + strFlightInfo.sActype )	
		
	end if

	sArea = dwData.GetItemString(lRows, "cworkstation")
	sWorkstation = dwData.GetItemString(lRows, "cworkstation_long")
	
Next

iRet = dsLayout.GetFullState(bBlob)
if iRet = -1 then
	return -13
end if

iRetCount ++				
this.uoResult[iRetCount] = Create uo_label_return
this.uoResult[iRetCount].bLabel = bBlob
this.uoResult[iRetCount].lLabeltype = lLabelType

if isBelly then
	this.uoResult[iRetCount].sLabel ="RESERVE"+" "+sLabel + " (Belly)" 
else
	this.uoResult[iRetCount].sLabel ="RESERVE"+" "+sLabel
end if

this.uoResult[iRetCount].sLabelComment = sArea
this.uoResult[iRetCount].sWorkstation = sWorkstation
this.uoResult[iRetCount].isBelly = isBelly
this.uoResult[iRetCount].iLabelSort = iLabelSort
this.uoResult[iRetCount].iLabelPageBreak = iLabelPageBreak
this.uoResult[iRetCount].sGeneratedForPrinter = this.sGeneratedForPrinter

this.of_destroy_layout()
lEnde = CPU()

return 0
end function

public function integer of_fill_healthmark (s_flight sflightinfo);// --------------------------------------------------------------------------------
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

string sheader, sdetail,sfooter,sunit
long lflight
date lddeparture

lflight = long(sflightinfo.sflightnumber)
lddeparture = date(sflightinfo.dtdeparturedate)

//Erstmal den Betrieb holen
Select cunit into :sunit from cen_out
where cairline = :sflightinfo.sairline and nflight_number  = :lflight and ddeparture =:lddeparture and cdeparture_time =:sflightinfo.cdeparturetime;

if trim(sunit) <> "" then
	//Dann die Felder bef$$HEX1$$fc00$$ENDHEX$$llen
	select CHEALTHMARK1,CHEALTHMARK2,CHEALTHMARK3
	into :sheader,:sdetail,:sfooter
	from sys_units
	where cunit =:sunit;
end if
	
trim(sheader)
trim(sdetail)
trim(sfooter)

ishealthmark_detail = sdetail
ishealthmark_header = sheader
ishealthmark_footer = sfooter

return 0
end function

public function integer of_set_mealcode_flag ();// --------------------------------------------------------------------------------
// Objekt : uo_label_other
// Methode: of_set_mealcode_flag (Function)
// Autor  : M. Barfknecht
// --------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung: Holt den Wert f$$HEX1$$fc00$$ENDHEX$$r ishowmealcode aus cen_setup
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  22.01.2013	           M.Barfknecht       Erstellung
//
// --------------------------------------------------------------------------------

string	lsValue


select cValue into :lsValue 
  from cen_setup
where cclient = :s_app.sMandant
   and cSection = 'LabelPrint'
   and cKey = 'ShowMarker';
			
// wert nicht gefunden:
if sqlca.SQLCode = 100 then
	// eintragen
	INSERT INTO cen_setup  
				 (cclient,   
				  csection,   
				  ckey,   
				  cvalue )
   	VALUES ( :s_app.smandant,   
				  'LabelPrint',   
				 'ShowMarker',   
				 '0') ;
	 commit;
	// default zur$$HEX1$$fc00$$ENDHEX$$ckgeben
	lsValue = '0'
 
end if

this.ishowmealcode = integer(lsValue)
return 0
end function

public function string of_create_barcode_information (datastore ads_data, long al_row, s_flight astr_flightinfo);/* ### Event: of_create_barcode_information *******************************************
 *
 * Beschreibung : zusammenbauen der Barcodeinformationen f$$HEX1$$fc00$$ENDHEX$$r FLUGLABEL
 *
 *	Parameter : 	
 *
 * Aenderungshistorie
 *  Version  Wer                        			Wann        		Was und warum
 *   1.2		Klaus								21.01.2013		Erstellung
 * ### END Eventdoku ***************************************************
 */
String		ls_fill
String 	ls_barcode
String		ls_value
date		ld_date

ls_fill = "000000000000000000" 

// ---------------------------------------------------
// Element 1 im Barcode
// Packinglist Index Key 10 Zeichen
// ---------------------------------------------------
ls_value = String(ads_data.GetItemNumber(al_row, "cen_packinglist_index_npackinglist_index_key"))
ls_barcode = Right(ls_fill + ls_value, 10)

// ---------------------------------------------------
// Element 2 im Barcode
// Datum 8 Zeichen
// Feste Formatierung DDMMYYYY
// ---------------------------------------------------
ld_date = date(astr_flightinfo.dtdeparturedate)
ls_value = String(Day(ld_date), "00") + String(Month(ld_date), "00") + String(Year(ld_date))
ls_barcode += Right(ls_fill + ls_value, 8)

// ---------------------------------------------------
// Element 3 im Barcode
// Result Key 10 Zeichen
// ---------------------------------------------------
ls_value = String(this.lresultkey)
ls_barcode += Right(ls_fill + ls_value, 10)

// ---------------------------------------------------
// Element 4 im Barcode
// Stowage Key 10 Zeichen
// ---------------------------------------------------
ls_value = String(ads_data.GetItemNumber(al_row, "cen_stowage_nstowage_key"))
ls_barcode += Right(ls_fill + ls_value, 10)

// ---------------------------------------------------
// Element 5 im Barcode
// Quantity 10 Zeichen
// ---------------------------------------------------
ls_value = String(ads_data.GetItemNumber(al_row, "cen_loadinglists_nquantity"))
ls_barcode += Right(ls_fill + ls_value, 10)

//ls_barcode += Fill("0", 25) 
//
//Messagebox("", ls_barcode + "~r~r" + String(len(ls_barcode)))

return ls_barcode

end function

public function string of_create_barcode_information_spml_label (datastore ads_data, long al_row, datetime adt_date);/* ### Event: of_create_barcode_information_spml_label *******************************************
 *
 * Beschreibung : zusammenbauen der Barcodeinformationen f$$HEX1$$fc00$$ENDHEX$$r SPML Label
 *
 *	Parameter : 	
 *
 * Aenderungshistorie
 *  Version  Wer                        			Wann        		Was und warum
 *   1.2		Klaus								21.01.2013		Erstellung
 * ### END Eventdoku ***************************************************
 */
String		ls_fill
String 	ls_barcode
String		ls_value
date		ld_date

ls_fill = "000000000000000000" 

// ---------------------------------------------------
// Element 1 im Barcode
// Packinglist Index Key 10 Zeichen
// ---------------------------------------------------
ls_value = String(ads_data.GetItemNumber(al_row, "npackinglist_index_key"))
ls_barcode = Right(ls_fill + ls_value, 10)

// ---------------------------------------------------
// Element 2 im Barcode
// Datum 8 Zeichen
// Feste Formatierung DDMMYYYY
// ---------------------------------------------------
ld_date = date(adt_date)
ls_value = String(Day(ld_date), "00") + String(Month(ld_date), "00") + String(Year(ld_date))
ls_barcode += Right(ls_fill + ls_value, 8)

// ---------------------------------------------------
// Element 3 im Barcode
// Result Key 10 Zeichen
// ---------------------------------------------------
ls_value = String(this.lresultkey)
ls_barcode += Right(ls_fill + ls_value, 10)

// ---------------------------------------------------
// Element 4 im Barcode
// Stowage Key 10 Zeichen
// Im SPML Label nicht verf$$HEX1$$fc00$$ENDHEX$$gbar, deshalb leer
// ---------------------------------------------------
ls_value = ""
ls_barcode += Right(ls_fill + ls_value, 10)

// ---------------------------------------------------
// Element 5 im Barcode
// Quantity 10 Zeichen
// ---------------------------------------------------
ls_value = String(ads_data.GetItemNumber(al_row, "nquantity"))
ls_barcode += Right(ls_fill + ls_value, 10)

//ls_barcode += Fill("0", 25) 
//
//Messagebox("", ls_barcode + "~r~r" + String(len(ls_barcode)))

return ls_barcode

end function

public function string of_create_barcode_information_prod_label (datastore ads_data, long al_row);/* ### Event: of_create_barcode_information *******************************************
 *
 * Beschreibung : zusammenbauen der Barcodeinformationen f$$HEX1$$fc00$$ENDHEX$$r PRODUKTIONSLABEL
 *
 *	Parameter : 	
 *
 * Aenderungshistorie
 *  Version  Wer                        			Wann        		Was und warum
 *   1.2		Klaus								21.01.2013		Erstellung
 * ### END Eventdoku ***************************************************
 */
String		ls_fill
String 	ls_barcode
String		ls_value
date		ld_date

ls_fill = "000000000000000000" 

// ---------------------------------------------------
// Element 1 im Barcode
// Packinglist Index Key 10 Zeichen
// ---------------------------------------------------
ls_value = String(ads_data.GetItemNumber(al_row, "npackinglist_index_key"))
ls_barcode = Right(ls_fill + ls_value, 10)

// ---------------------------------------------------
// Element 2 im Barcode
// Datum 8 Zeichen
// Feste Formatierung DDMMYYYY
// ---------------------------------------------------
ld_date = Date(ads_data.GetItemString(al_row, "cdate"))
ls_value = String(Day(ld_date), "00") + String(Month(ld_date), "00") + String(Year(ld_date))
ls_barcode += Right(ls_fill + ls_value, 8)

// ---------------------------------------------------
// Element 3 im Barcode
// Result Key 10 Zeichen
// ---------------------------------------------------
ls_value = "" //String(this.lresultkey)
ls_barcode += Right(ls_fill + ls_value, 10)

// ---------------------------------------------------
// Element 4 im Barcode
// Stowage Key 10 Zeichen
// ---------------------------------------------------
ls_value = "" // String(ads_data.GetItemNumber(al_row, "cen_stowage_nstowage_key"))
ls_barcode += Right(ls_fill + ls_value, 10)

// ---------------------------------------------------
// Element 5 im Barcode
// Quantity 10 Zeichen
// ---------------------------------------------------
ls_value = ads_data.GetItemString(al_row, "ctotalquantity")
ls_barcode += Right(ls_fill + ls_value, 10)

//ls_barcode += Fill("0", 25) 
//
//Messagebox("", ls_barcode + "~r~r" + String(len(ls_barcode)))

return ls_barcode

end function

public function integer of_split_distribution_old (string sstring, ref s_distribution_text strvalues[]);// ----------------------------------------------------
//
// Tab getrennte Text aufsplitten
//
// ----------------------------------------------------
Integer iStartPos, iEndPos, iPos, iPosText, iPosPLNumber, iCount, iItem,iPosMealcode

string sToken, sText, sPLNumber, sQuantity
			
iEndPos		= 1
iStartPos 	= 1

if isnull(sString) then return 0	

do while iEndPos > 0
			
	iEndPos	 = Pos(sString, "~n",  iStartPos)
				
	if iEndPos > 0 then
				
		sToken 			= Mid(sString, iStartPos, iEndPos - iStartPos)
				
		iPos 				= Pos(sToken, "~t")
		iPosText			= Pos(sToken, "~t", iPos + 1)
		iPosMealcode = Pos(sToken, "~t", iPosText + 1)
		
		iItem = UpperBound(strValues) + 1
		strValues[iItem].sQuantity 		= Mid(sToken, 1, iPos -1)
		strValues[iItem].sText 				= Mid(sToken, iPos + 1, iPosText - iPos - 1)
		strValues[iItem].spackinglist		= Mid(sToken, iPosText + 1 ) 
		//strValues[iItem].smealcode		= Mid(sToken, iPosMealcode + 1 ) 
	
		iStartPos = iEndPos + 1			
					
	end if
	
	iCount ++
	if iCount > 1000 then exit
	
loop

// Messagebox("No of items !!!", Upperbound(strValues))

return 0
end function

public function integer of_retrieve_column_definition ();// -----------------------------------------
// Columndefinitionen aus SYS_LABEL_COLUMNS
// -----------------------------------------
if dsColumns.Retrieve() <= 0 then
	of_log("Error -14, no data from SYS_LABEL_COLUMNS")
	return -1
end if

return 0
end function

public function integer of_get_wrap_param ();// --------------------------------------------------------------------------------
// Objekt : uo_label_other
// Methode: of_get_wrap_param (Function)
// Autor  : M. Barfknecht
// --------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung: Holt die Parameter f$$HEX1$$fc00$$ENDHEX$$r die Wrapfunktion aus der cen_setup
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  25.04.2013	           M.Barfknecht       Erstellung
//
// --------------------------------------------------------------------------------

//NoWrapLen

Select cvalue into :this.iinowraplen
from cen_setup 
where csection = 'WRAP-Parameter' and ckey = 'nowraplen';

if sqlca.sqlcode <> 0 then
	this.iinowraplen = 12
end if

Select cvalue into :this.iiwrapstartpos
from cen_setup 
where csection = 'WRAP-Parameter' and ckey = 'wrapstartpos';

if sqlca.sqlcode <> 0 then
	this.iiwrapstartpos = 5
end if

Select cvalue into :this.iiwrapendpos
from cen_setup 
where csection = 'WRAP-Parameter' and ckey = 'wrapendpos';

if sqlca.sqlcode <> 0 then
	this.iiwrapendpos = 4
end if


return 0
end function

public function string of_get_filename_only (string sfile);// --------------------------------------------------------------------------------
// Objekt : uo_label_other
// Methode: of_get_filename_single (Function)
// Autor  : M. Barfknecht
// --------------------------------------------------------------------------------
// Argument(e):
// string sfile
// --------------------------------------------------------------------------------
// Return: string
// --------------------------------------------------------------------------------
//  Beschreibung: Liefert Filename ohne Pfad zur$$HEX1$$fc00$$ENDHEX$$ck
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  01.07.2013	           M.Barfknecht       Erstellung
//
// --------------------------------------------------------------------------------

string sfilename
long lpos

lpos = pos(sfile,"\")

if lpos > 0 then
	return of_get_filename_only(mid(sfile,lpos + 1))
else

	return sfile

end if
end function

public function integer of_get_cflight_compare (ref datastore ods, string sflight);// --------------------------------------------------------------------------------
// Objekt : uo_label_other
// Methode: of_get_cflight_compare (Function)
// Autor  : M. Barfknecht
// --------------------------------------------------------------------------------
// Argument(e):
// ref datastore ods
//  string sflight
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung: F$$HEX1$$fc00$$ENDHEX$$llt den $$HEX1$$fc00$$ENDHEX$$bergebenen Datastore mit den Fl$$HEX1$$fc00$$ENDHEX$$gen
//					aus sflight (Kommagetrennt)
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  29.08.2013	           M.Barfknecht       Erstellung
//
// --------------------------------------------------------------------------------
long a,lpos
Long	ll_Found
string snumber

//Falls nichts drin ist, machen wir auch nichts
if len(sflight) = 0 then return 0

do while len(sflight) > 0 
	
	if left(sflight,1) = "," then sflight =  right(sflight,len(sflight)-1)
	
	lpos = Pos(sflight,",")
	if lpos > 0 then
		snumber = left(sflight,lpos -1)
	else
		snumber = sflight
	end if
	if isNumber(snumber) then
		
		ll_Found = ods.find("cen_out_nflight_number=" + snumber ,1,ods.rowcount())
		
		if ll_Found = 0 then
			
			a=ods.insertrow(0)
			ods.setitem(a,"cen_out_nflight_number",long(snumber))
			
		End If
	end if
	if lpos > 0 then
		sflight =  right(sflight,len(sflight)-lpos)
	else
		sflight =""
	end if
loop


return 0
end function

public function string of_get_prod_cflight (string sairline, date ddepart, long arg_pl_index, string sflight, long arg_belly);// --------------------------------------------------------------------------------
// Objekt : uo_label_other
// Methode: of_get_prod_cflight (Function)
// Autor  : M. Barfknecht
// --------------------------------------------------------------------------------
// Argument(e):
// string sairline
//  date ddepart
//  long arg_pl_index
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung: Liefert alle Fl$$HEX1$$fc00$$ENDHEX$$ge zur$$HEX1$$fc00$$ENDHEX$$ck, in der die St$$HEX1$$fc00$$ENDHEX$$ckliste an diesem Tag vorkommt 
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  30.07.2013	           M.Barfknecht       Erstellung
//
// --------------------------------------------------------------------------------


string sflights
datastore	dsflights,dscompare
long i,llast,lfound

dsflights = create datastore
dsflights.dataobject = 'dw_prod_label_flights'
dsflights.settransobject(sqlca)

dscompare = create datastore
dscompare.dataobject = 'dw_prod_label_flights'

dsflights.retrieve(ddepart,sairline,arg_pl_index,arg_belly)

//Jetzt f$$HEX1$$fc00$$ENDHEX$$llen wir noch dscompare mit den $$HEX1$$fc00$$ENDHEX$$bergebenen Fl$$HEX1$$fc00$$ENDHEX$$gen(stehen in sflight)
of_get_cflight_compare( dscompare, sflight)

if dsflights.rowcount( ) = 0 or dscompare.rowcount() = 0 then
	//Sollte eigentlich nicht passieren
	sflights = ""
else
	
	llast = 0
	
	for i=1 to dsflights.rowcount()
		if llast <> dsflights.getitemnumber(i,"cen_out_nflight_number") then
			//Nur eintragen, wenn der Flug aus ausgew$$HEX1$$e400$$ENDHEX$$hlt wurde
			lfound = dscompare.find("cen_out_nflight_number= "+string(dsflights.getitemnumber(i,"cen_out_nflight_number")),1,dscompare.rowcount())
			if lfound > 0 then
				sflights = sflights +string(dsflights.getitemnumber(i,"cen_out_nflight_number"),"000")+", "
			end if
			llast = dsflights.getitemnumber(i,"cen_out_nflight_number")
		end if
	next
	//Komma nach letztem Flug raus
	sflights = Left(sflights,len(sflights)-2)
	
end if
	

destroy(dsflights)
return sflights
end function

public function string of_get_registration ();string sregistration

select cregistration
into :sregistration
from cen_out
where nresult_key = :this.lresultkey;

if isNull(sregistration) then sregistration =' '

return sregistration
end function

public function string of_get_prod_cflight_all (string sairline, date ddepart, long arg_pl_index, string sflight, long arg_belly);
// --------------------------------------------------------------------------------
// Objekt : uo_label_other
// Methode: of_get_prod_cflight_all (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 27.09.2016
//
// Argument(e):
// string sairline
//	 date ddepart
//	 long arg_pl_index
//	 string sflight
//	 long arg_belly
//
// Beschreibung:		Liefert alle Fl$$HEX1$$fc00$$ENDHEX$$ge zur$$HEX1$$fc00$$ENDHEX$$ck, in der die St$$HEX1$$fc00$$ENDHEX$$ckliste an diesem Tag vorkommt 
//							Zus$$HEX1$$e400$$ENDHEX$$tzlich Leg 2,3,4..		
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	27.09.2016		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------


string	sflights
long		ll_Counter
Long		llast,lfound
Long		ll_Rows
Long		ll_Pos
Long		ll_Result_key
Long		ll_More_Legs, ll_Leg_Counter
String	ls_Search
datastore	dsflights,dscompare, lds_Leg


dsflights = create uo_cbase_datastore
dsflights.dataobject = "dw_prod_label_all_flights_belly" //"dw_prod_label_all_flights"
dsflights.settransobject(sqlca)

dscompare = create uo_cbase_datastore
dscompare.dataobject = "dw_prod_label_all_flights"
dscompare.settransobject(sqlca)

lds_Leg			= create datastore
lds_Leg.dataobject = "dw_uo_cen_out_leg"
lds_Leg.SetTransObject(sqlca)

//f_trace("of_get_prod_cflight_all START")	

ll_Rows = dsflights.retrieve(ddepart, sairline, arg_pl_index )
//ll_Rows = dsflights.retrieve(ddepart,sairline,arg_pl_index,arg_belly)

//dsflights.saveas("c:\temp\cbase\flights_"+ String(cpu())+ ".xls",excel5!,true)

//Jetzt f$$HEX1$$fc00$$ENDHEX$$llen wir noch dscompare mit den $$HEX1$$fc00$$ENDHEX$$bergebenen Fl$$HEX1$$fc00$$ENDHEX$$gen(stehen in sflight)
of_get_cflight_compare( dscompare, sflight)

if dsflights.rowcount( ) = 0 or dscompare.rowcount() = 0 then
	//Sollte eigentlich nicht passieren
	sflights = ""
else
	
	llast = 0
	
	for ll_Counter=1 to dsflights.rowcount()
		//f_trace("of_get_prod_cflight_all row " + String(ll_Counter) + ": " + String(dsflights.getitemnumber(ll_Counter,"cen_out_nflight_number")))	
		if llast <> dsflights.getitemnumber(ll_Counter,"cen_out_nflight_number") then
			//f_trace("of_get_prod_cflight_all row " + String(ll_Counter) + ": " + String(dsflights.getitemnumber(ll_Counter,"cen_out_nflight_number")))	
			ll_Result_key = dsflights.getitemnumber(ll_Counter,"nresult_key")
			//Nur eintragen, wenn der Flug aus ausgew$$HEX1$$e400$$ENDHEX$$hlt wurde
			lfound = dscompare.find("cen_out_nflight_number= "+string(dsflights.getitemnumber(ll_Counter,"cen_out_nflight_number")),1,dscompare.rowcount())
			if lfound > 0 then
				
				ls_Search = string(dsflights.getitemnumber(ll_Counter,"cen_out_nflight_number"),"000")+","
				ll_Pos = pos(sflights, ls_Search)
				if ll_Pos < 1 then
				
					sflights = sflights +string(dsflights.getitemnumber(ll_Counter,"cen_out_nflight_number"),"000")+", "
					
					ll_More_Legs = lds_Leg.Retrieve(ll_Result_key)
					//f_trace("of_get_prod_cflight_all more legs: " + String(lds_Leg.rowcount()))	
					For ll_Leg_Counter = 1 To lds_Leg.RowCount()
						If ll_Result_key <> lds_Leg.getitemnumber(ll_Leg_Counter,"nresult_key") Then
							
							ls_Search = string(lds_Leg.getitemnumber(ll_Leg_Counter,"nflight_number"),"000")+","
							ll_Pos = pos(sflights, ls_Search)
							if ll_Pos < 1 then
//								sflights = sflights +string(lds_Leg.getitemnumber(ll_Leg_Counter,"nflight_number"),"000")+", "
							End If
							//f_trace("of_get_prod_cflight_all : " + String(lds_Leg.getitemnumber(ll_Leg_Counter,"nflight_number")))	
						End If
					Next
				
				end if
			end if
			llast = dsflights.getitemnumber(ll_Counter,"cen_out_nflight_number")
		end if
	next
	//Komma nach letztem Flug raus
	sflights = Left(sflights,len(sflights)-2)
	
end if
//f_trace("of_get_prod_cflight_all END")	
	

destroy(dsflights)

f_trace("of_get_prod_cflight_all sflights")	

return sflights

end function

public function string of_get_prod_cflightranges (string sairline, date ddepart, long arg_pl_index, string sflight, long arg_belly);// --------------------------------------------------------------------------------
// Objekt : uo_label_other
// Methode: of_get_prod_cflight (Function)
// Autor  : M. Barfknecht
// --------------------------------------------------------------------------------
// Argument(e):
// string sairline
//  date ddepart
//  long arg_pl_index
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung: Liefert alle Fl$$HEX1$$fc00$$ENDHEX$$ge zur$$HEX1$$fc00$$ENDHEX$$ck, in der die St$$HEX1$$fc00$$ENDHEX$$ckliste an diesem Tag vorkommt 
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  30.07.2013	           M.Barfknecht       Erstellung
//
// --------------------------------------------------------------------------------


string sflights
datastore	dsflights
long i,llast,lfound
Long		ll_Rows

dsflights = create datastore
dsflights.dataobject = 'dw_prod_label_routings'
dsflights.settransobject(sqlca)


ll_Rows = dsflights.retrieve(ddepart,sairline,arg_pl_index,arg_belly)

////Jetzt f$$HEX1$$fc00$$ENDHEX$$llen wir noch dscompare mit den $$HEX1$$fc00$$ENDHEX$$bergebenen Fl$$HEX1$$fc00$$ENDHEX$$gen(stehen in sflight)
//of_get_cflight_compare( dscompare, sflight)

if dsflights.rowcount( ) = 0 then
	//Sollte eigentlich nicht passieren
	sflights = ""
else
	
	//llast = 0
	
	for i=1 to dsflights.rowcount()
		sflights = sflights + dsflights.getitemstring(i,"crouting") 
		if i < dsflights.rowcount() then
			sflights += ","
		End If
//		if llast <> dsflights.getitemnumber(i,"cen_out_nflight_number") then
//			//Nur eintragen, wenn der Flug aus ausgew$$HEX1$$e400$$ENDHEX$$hlt wurde
//			lfound = dscompare.find("cen_out_nflight_number= "+string(dsflights.getitemnumber(i,"cen_out_nflight_number")),1,dscompare.rowcount())
//			if lfound > 0 then
//				sflights = sflights +string(dsflights.getitemnumber(i,"cen_out_nflight_number"),"000")+", "
//			end if
//			llast = dsflights.getitemnumber(i,"cen_out_nflight_number")
//		end if
	next
	//Komma nach letztem Flug raus
//	sflights = Left(sflights,len(sflights)-2)
	
end if
	

destroy(dsflights)

return sflights
end function

public function integer of_set_label_group_sort (string as_new_sort);
// --------------------------------------------------------------------------------
// Objekt : uo_label_other
// Methode: of_set_label_group_sort (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 26.06.2017
//
// Argument(e):
// string as_new_sort
//
// Beschreibung:		Label Group Sort Parameter
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	26.06.2017		Erstellung
//
//
// Return: integer
//
// --------------------------------------------------------------------------------


is_Label_Group_Sort =""

If NOT IsnULL(as_New_Sort) Then

	If Trim(as_New_Sort) > "" Then

		is_Label_Group_Sort = as_New_Sort
		
	End If
	
End If


Return 1
end function

public function integer of_legs ();
datastore 	dsLeg
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

event constructor;// hilfsvariable
Long 	ll_Ret

// Objekt zur Berechnung von Schriftarten erzeugen
iuo_FontCalc = CREATE uo_font_calc

// -----------------------------------------------
// DataStore mit den Informationen zu dem Label
// selbst
// -----------------------------------------------
dsMaster = Create Datastore
dsMaster.dataobject = "dw_label_print_layout"
dsMaster.SettransObject(sqlca)
// -----------------------------------------------
// DataStore mit den f$$HEX1$$fc00$$ENDHEX$$r auf das Label zu 
// druckenden Objekten
// -----------------------------------------------
dsObjects = Create Datastore
dsObjects.dataobject = "dw_label_print_objects"
dsObjects.SettransObject(sqlca)
// -----------------------------------------------
// DataStore mit allen erlaubten Label-Columns
// -----------------------------------------------
dsColumns = Create Datastore
dsColumns.dataobject = "dw_label_print_columns"
dsColumns.SettransObject(sqlca)
// -----------------------------------------------
// DataStore in dem das Labellayout erzeugt wird
// -----------------------------------------------
dsLayout = Create Datastore
dsLayout.dataobject = "dw_label_layout_thermo"
dsLayout.SettransObject(sqlca)

// -----------------------------------------------
// Layout f$$HEX1$$fc00$$ENDHEX$$r das ErrorLabel
// -----------------------------------------------
dsErrorLayout = Create Datastore
dsErrorLayout.dataobject = "dw_label_layout_thermo"
// -----------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$brig gebliebene Datebs$$HEX1$$e400$$ENDHEX$$tze der 
// Komponentenverteilung
// -----------------------------------------------
dsDistributionErrors = Create Datastore
dsDistributionErrors.dataobject = "dw_uo_cen_out_meals"
// -----------------------------------------------
// DataStore in dem das PL-Detail erzeugt wird
// -----------------------------------------------
dsPackinglistDetail 				 = Create Datastore
dsPackinglistDetail.dataobject = "dw_label_packinglist_detail"
dsPackinglistDetail.SettransObject(sqlca)
// -----------------------------------------------
// Columns in dw_loading_list_result
// -----------------------------------------------
dsLoadingListColumns				 	= Create datastore 
dsLoadingListColumns.dataobject 	= "dw_columns_in_loadinglist"

// ---------------------------------------------------------------------
// DataStore mit Produktgruppen die nicht im PL-Detail verwendet werden
// ---------------------------------------------------------------------
dsProductGroup 				 	= Create Datastore
dsProductGroup.dataobject 		= "dw_label_product_group"
dsProductGroup.SettransObject(sqlca)

// -----------------------------------------------
// TransaktionsServer
// -----------------------------------------------
//This.GetContextService ("Transactionserver", its_jag)
//
//if isValid(its_jag) Then
//	its_jag.CreateInstance(nCbase, "cbase/n_cbase") 
//end if

// -----------------------------------------------
// DataStore in dem PL-Explosion erzeugt wird
// -----------------------------------------------
dsPackinglistExplosion 				 = Create Datastore
dsPackinglistExplosion.dataobject = "dw_label_packinglist_explosion"
dsPackinglistExplosion.SettransObject(sqlca)

// -----------------------------------------------
// die daten f$$HEX1$$fc00$$ENDHEX$$rs RTN-object
// -----------------------------------------------
// einheit
this.istr_RTN[1].is_ObjectName = "crtn_unit"
this.istr_RTN[1].is_ColumnName = "cunit"
this.istr_RTN[1].idec_Proz = 0.13
this.istr_RTN[1].il_TextAlign = 2 // center
this.istr_RTN[1].ib_TextAlign = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
this.istr_RTN[1].il_BorderStyle = 0 // kein rahmen
this.istr_RTN[1].ib_BorderStyle = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
// bezeichnung
this.istr_RTN[2].is_ObjectName = "crtn_text"
this.istr_RTN[2].is_ColumnName = "ctext"
this.istr_RTN[2].idec_Proz = 0.66
this.istr_RTN[2].il_TextAlign = 0 // left
this.istr_RTN[2].ib_TextAlign = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
this.istr_RTN[2].il_BorderStyle = 0 // kein rahmen
this.istr_RTN[2].ib_BorderStyle = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
// menge
this.istr_RTN[3].is_ObjectName = "nrtn_qty"
this.istr_RTN[3].is_ColumnName = "nquantity"
this.istr_RTN[3].idec_Proz = 0.10
this.istr_RTN[3].il_TextAlign = 1 // right
this.istr_RTN[3].ib_TextAlign = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
this.istr_RTN[3].il_BorderStyle = 0 // kein rahmen
this.istr_RTN[3].ib_BorderStyle = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
// rtn-menge
this.istr_RTN[4].is_ObjectName = "nrtn_qty_return"
this.istr_RTN[4].is_ColumnName = "nquantity_return"
this.istr_RTN[4].idec_Proz = 0.11
this.istr_RTN[4].il_TextAlign = 1 // right
this.istr_RTN[4].ib_TextAlign = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
this.istr_RTN[4].il_BorderStyle = 0 // kein rahmen
this.istr_RTN[4].ib_BorderStyle = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben

// -----------------------------------------------
// die daten f$$HEX1$$fc00$$ENDHEX$$rs EQ-object
// -----------------------------------------------
// einheit
this.istr_EQ[1].is_ObjectName = "ceq_unit"
this.istr_EQ[1].is_ColumnName = "cunit"
this.istr_EQ[1].idec_Proz = 0.13
this.istr_EQ[1].il_TextAlign = 2 // center
this.istr_EQ[1].ib_TextAlign = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
this.istr_EQ[1].il_BorderStyle = 0 // kein rahmen
this.istr_EQ[1].ib_BorderStyle = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
this.istr_EQ[1].il_fontweight = 400 // nicht fett
this.istr_EQ[1].ib_fontweight = true// default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
// bezeichnung
this.istr_EQ[2].is_ObjectName = "ceq_text"
this.istr_EQ[2].is_ColumnName = "ctext"
this.istr_EQ[2].idec_Proz = 0.77
this.istr_EQ[2].il_TextAlign = 0 // left
this.istr_EQ[2].ib_TextAlign = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
this.istr_EQ[2].il_BorderStyle = 0 // kein rahmen
this.istr_EQ[2].ib_BorderStyle = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
this.istr_EQ[2].il_fontweight = 400 // nicht fett
this.istr_EQ[2].ib_fontweight = true// default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
// menge
this.istr_EQ[3].is_ObjectName = "neq_qty"
this.istr_EQ[3].is_ColumnName = "nquantity"
this.istr_EQ[3].idec_Proz = 0.10
this.istr_EQ[3].il_TextAlign = 1 // right
this.istr_EQ[3].ib_TextAlign = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
this.istr_EQ[3].il_BorderStyle = 0 // kein rahmen
this.istr_EQ[3].ib_BorderStyle = true // default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben
this.istr_EQ[3].il_fontweight = 700 // fett
this.istr_EQ[3].ib_fontweight = true// default-routine darf nicht $$HEX1$$fc00$$ENDHEX$$berschreiben


// externes setup (defaults hier aber lassen!) sinnvoll f$$HEX1$$fc00$$ENDHEX$$r
// - prozentuale verteilung pro column
// - fontweight pro column
// - textalign pro column
ll_Ret = this.of_get_setup_columns(this.istr_RTN)
//und nochmal f$$HEX1$$fc00$$ENDHEX$$r EQ
ll_Ret = this.of_get_setup_columns(this.istr_EQ)

// filter-kriterien rtn
this.is_kindsRTN[1] = Upper("RTN")

// individuelles setup f$$HEX1$$fc00$$ENDHEX$$r rtn
// - filter-kriterien
ll_Ret = this.of_get_setup_rtn()

//unit filter EQ(Einheiten werden unsichtbar)
//this.is_kindsEQ[1] = "EA"


ll_Ret = this.of_get_setup_eq()

//Wrap Parameter initialisieren

of_get_wrap_param( )

end event

on uo_label_other.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_label_other.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;Integer I

// Objekt zur Berechnung von Schriftarten zerst$$HEX1$$f600$$ENDHEX$$ren
DESTROY iuo_FontCalc

For I = 1 to Upperbound(this.uoResult)
	Setnull(this.uoResult[I].bLabel)
	Setnull(this.uoResult[I].bLocationSheet)
	Setnull(this.uoResult[I].bDistributionErrors)
	Destroy(this.uoResult[I])
Next

if isvalid(dsMaster) then destroy dsMaster
if isvalid(dsObjects) then destroy dsObjects
if isvalid(dsColumns) then destroy dsColumns
if isvalid(dsLayout) then destroy dsLayout
if isvalid(dsErrorLayout) then destroy dsErrorLayout
if isvalid(dsDistributionErrors) then destroy dsDistributionErrors	
if isvalid(dsPackinglistDetail) then destroy dsPackinglistDetail
if isvalid(dsLoadingListColumns) then destroy dsLoadingListColumns
if isvalid(dsProductGroup) then destroy dsProductGroup
If IsValid(dsPackinglistExplosion) Then Destroy dsPackinglistExplosion

end event

