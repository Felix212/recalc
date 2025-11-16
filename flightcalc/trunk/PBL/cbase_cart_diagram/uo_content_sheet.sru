HA$PBExportHeader$uo_content_sheet.sru
$PBExportComments$Collection of Data and Functions to Create a Content Spec Report/Label
forward
global type uo_content_sheet from nonvisualobject
end type
end forward

global type uo_content_sheet from nonvisualobject
end type
global uo_content_sheet uo_content_sheet

type variables
datastore 	dsLoading 
datastore 	dsLoadingHeader
datastore 	dsLoadingContents 
datastore 	dsOutput[]
datastore	dsOperations

datastore 	dsPLContents
datastore 	dsPLSubContents

integer 		iiUseLetterFormat

Long 			ilResultKey
String		isError	= ""
String		isTempPath	= "c:\temp\cbase\"
String		isOperation = ""

Public	Boolean		ib_NON_Sky = FALSE

end variables

forward prototypes
public function integer of_create_content_sheet ()
public function integer of_debug_print ()
public function integer of_reset_datastores ()
public function integer of_prepare_details (ref datastore arg_dsdetails, datetime arg_ddeparture, string arg_sunit)
public function integer of_prepare (datastore arg_ds, datetime arg_ddeparture, string arg_sunit)
public function integer of_debug_xls (string arg_sprefix)
end prototypes

public function integer of_create_content_sheet ();/*
* Objekt : uo_content_sheet
* Methode: of_create_content_sheet (Function)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 03.03.2011
*
* Argument(e):
* none
*
* Beschreibung:		Erstellt das Content Sheet 
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			Klaus F$$HEX1$$f600$$ENDHEX$$rster[KF]		03.03.2011			Erstellung
* 1.1				Klaus Winckler			18.10.2012			CBASE-NAM-CR-12036 (Summenbildung und Ausdruck)
* 1.2				Oliver H$$HEX1$$f600$$ENDHEX$$fer			06.02.2014			CBASE-NAM-CR-13048WEB (Content Specs by Area / Workstation)
* 1.3				Oliver H$$HEX1$$f600$$ENDHEX$$fer			06.01.2017			CR Single Content Spec plus Overflow Content
*
* Return: integer
*
*/

Long		ll_flight, a, b, ll_rows, ll_details, ll_sub_details, ll_index_key, ll_detail_key, ll_row_id, ll_distribution, ll_sub_index_key, ll_sub_detail_key, ll_row_detail_key
String	ls_airline, ls_suffix, ls_departure_time, ls_actype, ls_acowner, ls_gv, ls_unit, ls_pl, ls_ops, ls_ws
Datetime ld_departure
Decimal 	ldec_quantity, ldec_sub_quantity
Integer	li_Succ
Long		ll_Content_Rows
Integer	liPos
Long		ll_non_sky
Long		ll_Sort
String	ls_Trace
String	ls_check_PL


//if handle(getapplication()) = 0 then
//	of_debug_xls("AT_START_")
//end if

// ------------------------------------------------------------------------------
// Fluginformationen f$$HEX1$$fc00$$ENDHEX$$r den Header einsammeln
// ------------------------------------------------------------------------------
  SELECT cen_out.cairline,   
         cen_out.nflight_number,   
         cen_out.csuffix,   
         cen_out.ddeparture,   
         cen_out.cdeparture_time,   
         cen_out.cactype,   
         cen_out.cairline_owner,   
         cen_out.cgalleyversion,   
         cen_out.cunit  
    INTO :ls_airline,   
         :ll_flight,   
         :ls_suffix,   
         :ld_departure,   
         :ls_departure_time,   
         :ls_actype,   
         :ls_acowner,   
         :ls_gv,   
         :ls_unit  
    FROM cen_out 
	WHERE cen_out.nresult_key = :this.ilResultkey;

if sqlca.sqlcode <> 0 then
	iserror = "Error getting flight information: " + sqlca.sqlerrtext
	return -1
end if

SELECT	nnon_sky  
INTO		:ll_non_sky  
FROM		sys_units  
WHERE		cunit = :ls_unit ;

If ll_non_sky > 0 Then
	ib_Non_Sky = TRUE
Else
	ib_Non_Sky = FALSE
End If


iiUseLetterFormat = integer(f_mandant_profilestring(sqlca, s_app.smandant, "PaperFormat", "UseLetterFormat", "0"))

//Messagebox("", "iiUseLetterFormat = " + string(iiUseLetterFormat))

dsOperations.Retrieve(ls_unit)

if dsOperations.RowCount() > 0 then
	ls_ops = dsOperations.GetItemString(1, "ctext")
else
	ls_ops = "N/A"
end if

if sqlca.sqlcode <> 0 then
//	Messagebox("", sqlca.sqlerrtext)
	iserror = "Error getting ops information: " + sqlca.sqlerrtext
	return -1
end if

this.of_prepare(this.dsLoadingHeader, ld_departure, ls_unit)
this.of_prepare(this.dsLoadingContents, ld_departure, ls_unit)

// f_print_datastore(dsLoadingHeader)
// f_print_datastore(dsLoadingContents)

//li_Succ = dsLoadingHeader.SetSort("carea_text A cworkstation_text A cgalley A cstowage A cplace A cpackinglist A ")
//li_Succ = dsLoadingHeader.SetSort("carea_text A, cworkstation_text A, cgalley A, cstowage A, cplace A, cpackinglist A ")
li_Succ = dsLoadingHeader.SetSort("carea_text A, cworkstation_text A, cgalley A, cstowage A, cplace A, cpackinglist A, nrowid A, nsort A ")

li_Succ = this.dsLoadingHeader.Sort()

//if handle(getapplication()) = 0 then
//	of_debug_xls("BEFORE_PROCESSING_")
//end if

for ll_rows = 1 to this.dsLoadingHeader.Rowcount()

	if this.dsLoadingHeader.GetitemNumber(ll_rows, "ncontent_sheet") <> 1 then
		continue
	end if
	
	liPos = Upperbound(dsOutPut) + 1
	dsOutPut[liPos] = Create Datastore
	dsOutPut[liPos].dataobject = "dw_uo_content_sheet_layout_nam"
	dsOutPut[liPos].Modify("r_frame.x=9")
	dsOutPut[liPos].Modify("r_frame.y=7")
	dsOutPut[liPos].Modify("r_frame.width=453")
	
	if iiUseLetterFormat = 1 then
		dsOutPut[liPos].Modify("r_frame.height=804")
	else
		dsOutPut[liPos].Modify("r_frame.height=733")
	end if
	
	
	// Header
	ls_pl = this.dsLoadingHeader.Getitemstring(ll_rows, "cpackinglist")
	ls_ws = this.dsLoadingHeader.Getitemstring(ll_rows, "carea_text") + " - " + this.dsLoadingHeader.Getitemstring(ll_rows, "cworkstation_text") 

	if isnull (ls_ws) then
		ls_ws	= ""
	end if 

	ls_Trace =  this.dsLoadingHeader.Getitemstring(ll_rows, "carea_text")	
	ls_Trace += " " + this.dsLoadingHeader.Getitemstring(ll_rows, "cgalley")
	ls_Trace += "-" + this.dsLoadingHeader.Getitemstring(ll_rows, "cstowage")
	ls_Trace += " " + this.dsLoadingHeader.Getitemstring(ll_rows, "cplace")
	
	ll_Sort = this.dsLoadingHeader.GetitemNumber(ll_rows, "nsort")
	 
	if isnull(ls_Trace) then ls_trace = "" 
	f_trace("Content Spec: " + ls_Trace + " " + ls_pl)
	
	dsOutPut[liPos].Modify("t_flight.text='" + ls_airline + " " + string(ll_flight, "000") + ls_suffix + "'")
	// Next Line is NEW since CBASE-NAM-CR-12036
	dsOutPut[liPos].Modify("t_flight_big.text='" + ls_airline + " " + string(ll_flight, "000") + ls_suffix + "'")
	dsOutPut[liPos].Modify("t_header_pl.text='" +  ls_pl + "'")
	dsOutPut[liPos].Modify("t_header_pl_text.text='" +   this.dsLoadingHeader.Getitemstring(ll_rows, "ctext") + "'")
	dsOutPut[liPos].Modify("t_departure.text='" + string(ld_departure,  "mmm dd, yyyy") + " " + ls_departure_time + "'")
	dsOutPut[liPos].Modify("t_ac.text='" + ls_acowner + " " + ls_actype +  " [" + ls_gv + "]" + "'")
	dsOutPut[liPos].Modify("t_stowage.text='" + this.dsLoadingHeader.Getitemstring(ll_rows, "cgalley") + " - " + this.dsLoadingHeader.Getitemstring(ll_rows, "cstowage") + " " + this.dsLoadingHeader.Getitemstring(ll_rows, "cplace") + "'")
	// Next 2Lines are NEW since CBASE-NAM-CR-12036
	dsOutPut[liPos].Modify("t_stowage_big.text='" + this.dsLoadingHeader.Getitemstring(ll_rows, "cgalley") + " - " + this.dsLoadingHeader.Getitemstring(ll_rows, "cstowage") + " " + this.dsLoadingHeader.Getitemstring(ll_rows, "cplace") + "'")
 	dsOutPut[liPos].Modify("t_class_big.text='" +  this.dsLoadingHeader.GetitemString(ll_rows, "cclass") + "'")
	dsOutPut[liPos].Modify("t_ops.text='" +  ls_ops  + "'")
	dsOutPut[liPos].Modify("t_ws.text='" + ls_ws + "'")
	
 	ll_index_key 		=  this.dsLoadingHeader.GetitemNumber(ll_rows, "npackinglist_index_key")
	ll_detail_key	 		=  this.dsLoadingHeader.GetitemNumber(ll_rows, "npackinglist_detail_key")
	ll_row_id				=  this.dsLoadingHeader.GetitemNumber(ll_rows, "nrowid")
	ll_row_detail_key	=  this.dsLoadingHeader.GetitemNumber(ll_rows, "ndetail_key")
	
	dsPLContents.Retrieve(ll_index_key, ll_detail_key, ld_departure, ls_unit)
	
	// --------------------------------------------------------------------------
	// Distribution in den Content Datastore "umf$$HEX1$$fc00$$ENDHEX$$llen"
	// --------------------------------------------------------------------------
	li_Succ = dsLoadingContents.SetFilter("nrowid=" + string(ll_row_id) + " and ndetail_key=" + string(ll_row_detail_key) )
	dsLoadingContents.Filter()
	ll_Content_Rows = dsLoadingContents.RowCount()
	
	if ib_non_sky then
		//dsLoadingContents.SetFilter("nrowid=" + string(ll_row_id) + " and nsort=" + string(ll_Sort) )
		//dsLoadingContents.SetFilter("nrowid=" + string(ll_row_id) + " and cpackinglist='" + ls_pl + "'" )
		//	li_Succ = dsLoadingContents.SetFilter("nrowid=" + string(ll_row_id) + " and ndetail_key="+ String(ll_Sort) + " and cpackinglist='" + ls_pl + "'" )
		li_Succ = dsLoadingContents.SetFilter("nrowid=" + string(ll_row_id) + " and ndetail_key="+ String(ll_Sort)) 
		ll_Content_Rows = dsLoadingContents.RowCount()
	end If
	
	dsLoadingContents.Filter()
	dsLoadingContents.Sort()
	for ll_distribution = 1 to dsLoadingContents.RowCount()

		ls_check_PL = dsLoadingContents.GetItemString(ll_distribution, "cpackinglist")
		if ls_check_PL = ls_PL then
			f_trace("Content Spec SKIP (" + ls_PL + "): " + ls_check_PL)
			continue
		end if
			
		b = dsPLContents.InsertRow(0)
		
		this.dsPLContents.Setitem(b, "nquantity", dsLoadingContents.GetItemNumber(ll_distribution, "nquantity") )
		this.dsPLContents.Setitem(b, "cpackinglist", dsLoadingContents.GetItemString(ll_distribution, "cpackinglist") )
		this.dsPLContents.Setitem(b, "ctext", dsLoadingContents.GetItemString(ll_distribution, "ctext") )
		this.dsPLContents.Setitem(b, "nsubpackinglist_index_key", dsLoadingContents.GetItemNumber(ll_distribution, "npackinglist_index_key") )
		this.dsPLContents.Setitem(b, "nsubpackinglist_detail_key", dsLoadingContents.GetItemNumber(ll_distribution, "npackinglist_detail_key") )
		this.dsPLContents.Setitem(b, "cunit", " " )
		this.dsPLContents.Setitem(b, "nexplode", dsLoadingContents.GetItemNumber(ll_distribution, "nexplode") )
		
		f_trace("Content Spec (" + ls_PL + "): " + ls_check_PL)
		
	next


	for ll_details = 1 to  dsPLContents.RowCount()
	
		 a = dsOutPut[liPos].InsertRow(0)
		// Contents
		dsOutPut[liPos].SetItem(a, "nquantity",this.dsPLContents.Getitemnumber(ll_details, "nquantity"))
		dsOutPut[liPos].SetItem(a, "cpackinglist",this.dsPLContents.Getitemstring(ll_details, "cpackinglist") + " - " + this.dsPLContents.Getitemstring(ll_details, "ctext"))
		dsOutPut[liPos].SetItem(a, "cunit_of_measure",this.dsPLContents.Getitemstring(ll_details, "cunit"))
		dsOutPut[liPos].SetItem(a, "nlevel", 0)
		
		// Area Workstation for Single page sorting
		dsOutPut[liPos].SetItem(a, "carea", dsLoadingHeader.Getitemstring(ll_rows, "carea_text"))
		dsOutPut[liPos].SetItem(a, "cworkstation_text",dsLoadingHeader.Getitemstring(ll_rows, "cworkstation_text") )

		
		if dsPLContents.Getitemnumber(ll_details, "nexplode") = 1 then
			
			ll_sub_index_key	= dsPLContents.Getitemnumber(ll_details, "nsubpackinglist_index_key")
			ll_sub_detail_key	= dsPLContents.Getitemnumber(ll_details, "nsubpackinglist_detail_key")
			
			dsPLSubContents.Retrieve(ll_sub_index_key, ll_sub_detail_key, ld_departure, ls_unit)
			
			// CBASE-NAM-CR-12036 - Summenbildung (nquantity) der SubInhalte bei Explode
			for ll_sub_details = 1 to dsPLSubContents.RowCount()
				 a = dsOutPut[liPos].InsertRow(0)
				// Sub Contents				
				dsOutPut[liPos].SetItem(a, "nquantity",this.dsPLSubContents.Getitemnumber(ll_sub_details, "nquantity")*dsPLContents.Getitemnumber(ll_details, "nquantity"))
				dsOutPut[liPos].SetItem(a, "cpackinglist",this.dsPLSubContents.Getitemstring(ll_sub_details, "cpackinglist") + " - " + this.dsPLSubContents.Getitemstring(ll_sub_details, "ctext"))
				dsOutPut[liPos].SetItem(a, "cunit_of_measure",this.dsPLSubContents.Getitemstring(ll_sub_details, "cunit"))
				dsOutPut[liPos].SetItem(a, "nlevel", 1)
//				dsOutPut[liPos].SetItem(a, "nlevel", ls_ws)
				
			next
			
		end if
		
	next
	 
Next

return 0

end function

public function integer of_debug_print ();/*
* Objekt : uo_content_sheet
* Methode: of_debug_print (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 04.03.2011
*
* Argument(e):
* none
*
* Beschreibung:		DataStores drucken
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	04.03.2011		Erstellung
*
*
* Return: integer
*
*/

If dsLoading.			RowCount() > 0 Then		dsLoading.Print()

If dsLoadingHeader.	RowCount() > 0 Then		dsLoadingHeader.Print()

If dsLoadingContents.RowCount() > 0 Then		dsLoadingContents.Print()
	

Return 1

end function

public function integer of_reset_datastores ();/*
* Objekt : uo_content_sheet
* Methode: of_reset_datastores (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 04.03.2011
*
* Argument(e):
* none
*
* Beschreibung:		DataStores leeren
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	04.03.2011		Erstellung
*
*
* Return: integer
*
*/


dsLoading.				Reset()
dsLoadingHeader.		Reset()
dsLoadingContents. 	Reset()


return 0
end function

public function integer of_prepare_details (ref datastore arg_dsdetails, datetime arg_ddeparture, string arg_sunit);/*
* Objekt : of_prepare_details
* Methode: of_prepare_header (Function)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 08.03.2011
*
* Argument(e):
* none
*
* Beschreibung:	
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			Klaus F$$HEX1$$f600$$ENDHEX$$rster[KF]		08.03.2011			Erstellung
*
*
* Return: integer
*
*/
Long 			ll_Indexkeys[]
Long			ll_Row, ll_Found
String			ls_PLs[], ls_Find
datastore 	dsPLKeys
datastore 	dsLocalPLSettings 


dsPLKeys = create datastore
dsPLKeys.dataobject = "dw_uo_content_sheet_pl_keys"
dsPLKeys.SettransObject(sqlca)

// ------------------------------------------------------------------------------------
// St$$HEX1$$fc00$$ENDHEX$$cklisten nummern einsammeln um die Keys zuspielen zu kommen.
// ------------------------------------------------------------------------------------
For ll_Row = 1 to arg_dsdetails.RowCount()
	
	ls_PLs[Upperbound(ls_PLs) + 1] = arg_dsdetails.GetItemString(ll_Row, "cpackinglist")
	
Next

// --------------------------------------------------------------------------------------------------------------------
// 09.07.2021 HR: Analog Issue #4918 kein retrieve mit leerem Array
// --------------------------------------------------------------------------------------------------------------------
if upperbound(ls_PLs) > 0 then
	dsPLKeys.Retrieve(ls_PLs, arg_ddeparture)
end if

// ------------------------------------------------------------------------------------
// Keys in den Header Datastore $$HEX1$$fc00$$ENDHEX$$bertragen
// ------------------------------------------------------------------------------------
For ll_Row = 1 to dsLoadingHeader.RowCount()
	ls_Find = "cpackinglist = '" + dsLoadingHeader.GetItemString(ll_Row, "cpackinglist") + "'"
	
	ll_Found = dsPLKeys.Find(ls_Find, 1, dsPLKeys.RowCount())
	
	if ll_Found > 0 then
		dsLoadingHeader.Setitem(ll_Row, "npackinglist_index_key", dsPLKeys.GetItemNumber(ll_Found, "npackinglist_index_key"))
		dsLoadingHeader.Setitem(ll_Row, "npackinglist_detail_key", dsPLKeys.GetItemNumber(ll_Found, "npackinglist_detail_key"))
		ll_Indexkeys[Upperbound(ll_Indexkeys) + 1] = dsPLKeys.GetItemNumber(ll_Found, "npackinglist_index_key")
	end if
		
Next

if Upperbound( ll_Indexkeys) = 0 then ll_Indexkeys[1] = -1

// ------------------------------------------------------------------------------------
// Settings in den Header Datastore $$HEX1$$fc00$$ENDHEX$$bertragen
// ------------------------------------------------------------------------------------
dsLocalPLSettings.Retrieve(ll_Indexkeys, arg_sunit, arg_ddeparture)

//f_print_datastore(dsLocalPLSettings)

For ll_Row = 1 to dsLoadingHeader.RowCount()
	
	ls_Find = "cpackinglist = '" + dsLoadingHeader.GetItemString(ll_Row, "cpackinglist") + "'"
	
	ll_Found = dsLocalPLSettings.Find(ls_Find, 1, dsLocalPLSettings.RowCount())
	
	if ll_Found > 0 then
		dsLoadingHeader.Setitem(ll_Row, "carea", dsLocalPLSettings.GetItemString(ll_Found, "loc_unit_areas_carea"))
		dsLoadingHeader.Setitem(ll_Row, "carea_text", dsLocalPLSettings.GetItemString(ll_Found, "loc_unit_areas_ctext"))
		dsLoadingHeader.Setitem(ll_Row, "cworkstation", dsLocalPLSettings.GetItemString(ll_Found, "loc_unit_workstation_cworkstation"))
		dsLoadingHeader.Setitem(ll_Row, "cworkstation_text", dsLocalPLSettings.GetItemString(ll_Found, "loc_unit_workstation_ctext"))
		dsLoadingHeader.Setitem(ll_Row, "nexplode", dsLocalPLSettings.GetItemNumber(ll_Found, "nexplode"))
		dsLoadingHeader.Setitem(ll_Row, "ncontent_sheet", dsLocalPLSettings.GetItemNumber(ll_Found, "ncontent_spec"))
	end if
		
Next


// ------------------------------------------------------------------------------------
// Stauorte in den Header Datastore $$HEX1$$fc00$$ENDHEX$$bertragen
// ------------------------------------------------------------------------------------
For ll_Row = 1 to dsLoadingHeader.RowCount()
	
	ls_Find = "nrowid = " + string(dsLoadingHeader.GetItemNumber(ll_Row, "nrowid"))  
	
	ll_Found = dsLoading.Find(ls_Find, 1, dsLoading.RowCount())
	
	if ll_Found > 0 then
		dsLoadingHeader.Setitem(ll_Row, "cgalley", dsLoading.GetItemString(ll_Found, "cen_galley_cgalley"))
		dsLoadingHeader.Setitem(ll_Row, "cstowage", dsLoading.GetItemString(ll_Found, "cen_stowage_cstowage"))
		dsLoadingHeader.Setitem(ll_Row, "cplace", dsLoading.GetItemString(ll_Found, "cen_stowage_cplace"))
	end if
		
Next

//f_print_datastore(dsLoadingHeader)

Destroy(dsPLKeys)
Destroy(dsLocalPLSettings)
return 0

end function

public function integer of_prepare (datastore arg_ds, datetime arg_ddeparture, string arg_sunit);/*
* Objekt : uo_content_sheet
* Methode: of_prepare_header (Function)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 08.03.2011
*
* Argument(e):
* none
*
* Beschreibung:	arg_ds anreichern..
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 		Klaus F$$HEX1$$f600$$ENDHEX$$rster[KF]		08.03.2011			Erstellung
* 1.1			Klaus Winckler			18.10.2012			CBASE-NAM-CR-12036 (Neues Feld cclass)
* 1.2			Oliver Hoefer			23.04.2019			IM12438128 issue #4869 
*
* Return: integer
*
*/
Long 			ll_Indexkeys[]
Long			ll_Row, ll_Found
String			ls_PLs[], ls_Find
datastore 	dsPLKeys
datastore 	dsLocalPLSettings 

dsLocalPLSettings= create datastore 	 
dsLocalPLSettings.dataobject = "dw_uo_content_sheet_pl_areas"
dsLocalPLSettings.Settransobject(sqlca)

dsPLKeys = create datastore
dsPLKeys.dataobject = "dw_uo_content_sheet_pl_keys"
dsPLKeys.SettransObject(sqlca)

// ------------------------------------------------------------------------------------
// St$$HEX1$$fc00$$ENDHEX$$cklisten nummern einsammeln um die Keys zuspielen zu kommen.
// ------------------------------------------------------------------------------------
For ll_Row = 1 to arg_ds.RowCount()
	
	ls_PLs[Upperbound(ls_PLs) + 1] = arg_ds.GetItemString(ll_Row, "cpackinglist")
	
Next

// --------------------------------------------------------------------------------------------------------------------
// 09.07.2021 HR: Analog Issue #4918 kein retrieve mit leerem Array
// --------------------------------------------------------------------------------------------------------------------
if upperbound(ls_PLs) > 0 then
	dsPLKeys.Retrieve(ls_PLs, arg_ddeparture)
end if

// ------------------------------------------------------------------------------------
// Keys in den Header Datastore $$HEX1$$fc00$$ENDHEX$$bertragen
// ------------------------------------------------------------------------------------
For ll_Row = 1 to arg_ds.RowCount()
	ls_Find = "cpackinglist = '" + arg_ds.GetItemString(ll_Row, "cpackinglist") + "'"
	
	ll_Found = dsPLKeys.Find(ls_Find, 1, dsPLKeys.RowCount())
	
	if ll_Found > 0 then
		arg_ds.Setitem(ll_Row, "npackinglist_index_key", dsPLKeys.GetItemNumber(ll_Found, "npackinglist_index_key"))
		arg_ds.Setitem(ll_Row, "npackinglist_detail_key", dsPLKeys.GetItemNumber(ll_Found, "npackinglist_detail_key"))
		ll_Indexkeys[Upperbound(ll_Indexkeys) + 1] = dsPLKeys.GetItemNumber(ll_Found, "npackinglist_index_key")
	end if
		
Next

if Upperbound( ll_Indexkeys) = 0 then ll_Indexkeys[1] = -1

// ------------------------------------------------------------------------------------
// Settings in den Header Datastore $$HEX1$$fc00$$ENDHEX$$bertragen
// ------------------------------------------------------------------------------------
dsLocalPLSettings.Retrieve(ll_Indexkeys, arg_sunit, arg_ddeparture)

//f_print_datastore(dsLocalPLSettings)

For ll_Row = 1 to arg_ds.RowCount()
	
	ls_Find = "cpackinglist = '" + arg_ds.GetItemString(ll_Row, "cpackinglist") + "'"
	
	ll_Found = dsLocalPLSettings.Find(ls_Find, 1, dsLocalPLSettings.RowCount())
	
	if ll_Found > 0 then
		arg_ds.Setitem(ll_Row, "carea", dsLocalPLSettings.GetItemString(ll_Found, "loc_unit_areas_carea"))
		arg_ds.Setitem(ll_Row, "carea_text", dsLocalPLSettings.GetItemString(ll_Found, "loc_unit_areas_ctext"))
		arg_ds.Setitem(ll_Row, "cworkstation", dsLocalPLSettings.GetItemString(ll_Found, "loc_unit_workstation_cworkstation"))
		arg_ds.Setitem(ll_Row, "cworkstation_text", dsLocalPLSettings.GetItemString(ll_Found, "loc_unit_workstation_ctext"))
		arg_ds.Setitem(ll_Row, "nexplode", dsLocalPLSettings.GetItemNumber(ll_Found, "nexplode"))
		arg_ds.Setitem(ll_Row, "ncontent_sheet", dsLocalPLSettings.GetItemNumber(ll_Found, "ncontent_spec"))
	
	end if

	// 23.04.2019 IM12438128 issue #4869 
	If ib_NON_Sky Then
		arg_ds.Setitem(ll_Row, "ncontent_sheet", 1)
	End If
	
Next


// ------------------------------------------------------------------------------------
// Stauorte in den Header Datastore $$HEX1$$fc00$$ENDHEX$$bertragen
// ------------------------------------------------------------------------------------
For ll_Row = 1 to arg_ds.RowCount()
	
	ls_Find = "nrowid = " + string(arg_ds.GetItemNumber(ll_Row, "nrowid"))  
	
	ll_Found = dsLoading.Find(ls_Find, 1, dsLoading.RowCount())
	
	if ll_Found > 0 then
		arg_ds.Setitem(ll_Row, "cgalley", dsLoading.GetItemString(ll_Found, "cen_galley_cgalley"))
		arg_ds.Setitem(ll_Row, "cstowage", dsLoading.GetItemString(ll_Found, "cen_stowage_cstowage"))
		arg_ds.Setitem(ll_Row, "cplace", dsLoading.GetItemString(ll_Found, "cen_stowage_cplace"))
		arg_ds.Setitem(ll_Row, "carea", dsLoading.GetItemString(ll_Found, "carea"))
		arg_ds.Setitem(ll_Row, "cworkstation", dsLoading.GetItemString(ll_Found, "cworkstation"))
		
		// CBASE-NAM-CR-12036
		// Neues feld cclass in dw_loading_list_result_detail aufgenommen!
		arg_ds.Setitem(ll_Row, "cclass", dsLoading.GetItemString(ll_Found, "cen_loadinglists_cclass"))
		
		
		
	end if
		
Next

//f_print_datastore(arg_ds)

Destroy(dsPLKeys)
Destroy(dsLocalPLSettings)
return 0

end function

public function integer of_debug_xls (string arg_sprefix);/*
* Objekt : uo_content_sheet
* Methode: of_debug_xls (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 04.03.2011
*
* Argument(e):
* none
*
* Beschreibung:		DatStores => XLS
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	04.03.2011		Erstellung
*
*
* Return: integer
*
*/


If dsLoading.			RowCount() > 0 Then		dsLoading.			saveas(isTempPath + arg_sprefix + "_dsLoading_"			+ String(now(), "hhmmss")  + ".XLS", Excel5! , true)

If dsLoadingHeader.	RowCount() > 0 Then		dsLoadingHeader.	saveas(isTempPath + arg_sprefix + "_dsLoadingHeader"	+ String(now(), "hhmmss") + ".XLS", Excel5! , true)

If dsLoadingContents.RowCount() > 0 Then		dsLoadingContents.saveas(isTempPath + arg_sprefix + "_dsLoadingContents"+ String(now(), "hhmmss") + String(Rand(32767)) + ".XLS", Excel5! , true)
	

Return 1

end function

on uo_content_sheet.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_content_sheet.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;/*
* Objekt : uo_content_sheet
* Methode: constructor (Event)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 03.03.2011
*
* Argument(e):
* none
*
* Beschreibung:		Initialisierung
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 				Klaus F$$HEX1$$f600$$ENDHEX$$rster[KF]		03.03.2011			Erstellung
*
*
* Return: integer
*
*/

isTempPath = f_gettemppath()

dsLoading = create datastore 	 
dsLoading.dataobject = "dw_loading_list_result"

dsLoadingHeader = create datastore 	 
dsLoadingHeader.dataobject = "dw_loading_list_result_detail"

dsLoadingContents = create datastore 	 
dsLoadingContents.dataobject = "dw_loading_list_result_detail"

dsPLContents = create datastore 	 
dsPLContents.dataobject = "dw_uo_content_sheet_pl_contents"
dsPLContents.Settransobject(sqlca)

dsPLSubContents = create datastore 	 
dsPLSubContents.dataobject = "dw_uo_content_sheet_pl_contents"
dsPLSubContents.Settransobject(sqlca)

dsOperations = create datastore 	 
dsOperations.dataobject = "dw_uo_content_sheet_pl_operations"
dsOperations.Settransobject(sqlca)





end event

event destructor;/*
* Objekt : uo_content_sheet
* Methode: destructor (Event)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 03.03.2011
*
* Argument(e):
* none
*
* Beschreibung:		Aufr$$HEX1$$e400$$ENDHEX$$umen
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 				Klaus F$$HEX1$$f600$$ENDHEX$$rster[KF]		03.03.2011			Erstellung
*
*
* Return: integer
*
*/
Long i

if isvalid(dsLoading) then destroy(dsLoading)
if isvalid(dsLoadingHeader) then destroy(dsLoadingHeader)
if isvalid(dsLoadingContents) then destroy(dsLoadingContents)
 
if isvalid(dsPLContents) then destroy(dsPLContents)
if isvalid(dsPLSubContents) then destroy(dsPLSubContents)
if isvalid(dsOperations) then destroy(dsOperations)

for i = 1 to  Upperbound(dsOutPut)
	if isvalid(dsOutPut[i]) then destroy(dsOutPut[i])
next

end event

