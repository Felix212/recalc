HA$PBExportHeader$uo_cart_distribution.sru
forward
global type uo_cart_distribution from nonvisualobject
end type
end forward

global type uo_cart_distribution from nonvisualobject
end type
global uo_cart_distribution uo_cart_distribution

type variables
/*************************************************************
* Objekt : uo_cart_distribution
* Methode:  (Declaration)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* none
*
* Return: none
*
*
*
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*  19.11.2009	1.1           Ulrich Paudler     Drawerfood und Traynonfood eingebaut
*
*************************************************************/
//Typen
CONSTANT Long EMPTY = 0
CONSTANT Long DRAWER = 1
CONSTANT Long TRAY = 2
CONSTANT Long DRAWERFOOD = 3
CONSTANT Long TRAYNONFOOD= 4
CONSTANT Long BLOCKED = 9
CONSTANT Long DRAWER_MULTI_RUNG = 13

CONSTANT Long NOSPACELEFT = -9999999

// Verteilungsmode
CONSTANT Long BYORDER = 0
CONSTANT Long REVERSEORDER = 1
CONSTANT Long TOPDOWN = 2
CONSTANT Long BOTTOMUP = 4
CONSTANT Long LEFTTORIGHT = 8


Private:
uo_cart_distrib_cart 	iuoCart[]
datastore 					idsAllocate

// Cache f$$HEX1$$fc00$$ENDHEX$$r Profilestring
String sCachedUser 	= ""
String sCachedSection= ""
String sCachedKey		= ""
String sCachedValue	= ""

Protected		Long			ilColumns
Public			Long			il_Disable_Debug = 1 //0

Public			n_doc_gen_settings	inv_doc_gen_settings
Public			Boolean					ib_use_doc_gen_settings = FALSE

Public			String		is_user
Public			String		is_section = ""

PUBLIC			Boolean		ib_Split_Evenly = FALSE
Protected		datastore 				idsAllocateProps
PUBLIC			Boolean		ib_suppress_qty_1 = FALSE

PUBLIC			String		is_CartDiagramComponentDisplay
end variables

forward prototypes
public function integer of_create_cart (long arg_l_columns, long arg_l_rows)
public function integer of_init_cart (long arg_l_rows)
public function long of_set_type (long arg_l_column, long arg_l_row, long arg_l_type)
public function long of_set_order (long arg_l_column, long arg_l_row, long arg_l_order)
public function integer of_init_allocate (long arg_l_columns, long arg_l_rows)
public function long of_set_allocation_mode (long arg_l_mode)
public function long of_get_type (long arg_l_column, long arg_l_row)
public function long of_get_row (long arg_l_column, long arg_l_row, ref s_distrib_items arg_str_item[])
public function long of_set_item (long arg_l_column, long arg_l_row, s_distrib_items arg_str_item[])
public function string of_get_item_description (s_component arg_str_component)
public function string of_profilestring (string suser, string ssection, string skey, string sdefault)
public function long of_combine_item ()
public function long of_check_row_limit (long arg_l_column, long arg_l_row, s_distrib_item_props arg_str_props)
public function long of_check_row_limit (long arg_l_column, long arg_l_row)
public function long of_set_length (long arg_l_column, long arg_l_row, long arg_l_length)
public function long of_get_cart_dimension (string arg_s_type, long arg_l_airline, long arg_l_indexkey, long arg_l_detailkey, ref long ref_l_columns, ref long ref_l_rows, ref long ref_l_length)
public function long of_check_row (long arg_l_column, long arg_l_row, long arg_l_length)
public function long of_check_row_item (long arg_l_column, long arg_l_row, long arg_l_length, s_distrib_item_props arg_str_props, long al_min_fit_factor)
public function long of_get_row_without_sub (long arg_l_column, long arg_l_row, ref s_distrib_items arg_str_item[])
public function long of_set_row (long arg_l_column, long arg_l_row, long arg_l_length, string arg_s_item, long arg_l_print_column, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text)
public function long of_allocate_w_split (s_component arg_str_component, ref long ref_l_column, ref long ref_l_row, long al_min_fit_factor, s_distrib_item_sub astr_sub[], uo_cart_diagram rauo_cart_diagram, long al_qty)
public function long of_set_alloc_props (long arg_l_column, long arg_l_row, integer arg_l_order, s_distrib_items arg_str_item[])
public subroutine of_save_idsallocateprops (string as_name)
public function long of_set_row_item (long arg_l_column, long arg_l_row, long arg_l_length, string arg_s_item, long arg_l_print_column, long arg_l_index, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text, boolean ab_bold, string as_code)
end prototypes

public function integer of_create_cart (long arg_l_columns, long arg_l_rows);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_create_cart (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* long arg_l_columns
*  long arg_l_rows
*
* Return: integer
*
*
* Initialisierung des Cart und der Verteilung
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llIndex

for llIndex = 1 to arg_l_columns
	of_init_cart(arg_l_rows)
next

of_init_allocate(arg_l_columns, arg_l_rows)

ilColumns = arg_l_columns

return llIndex
end function

public function integer of_init_cart (long arg_l_rows);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_init_cart (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* long arg_l_rows
*
* Return: integer
*
*
* Initialisierung der Rows im Cart
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*  06.02.2012	1.1           Oliver H$$HEX1$$f600$$ENDHEX$$fer       Section f$$HEX1$$fc00$$ENDHEX$$r WEB nicht aus ACTIVESETUP
*
*************************************************************/
Long llIndex

llIndex =  upperbound(iuoCart) + 1

iuoCart[llIndex] = create uo_cart_distrib_cart
iuoCart[llIndex].ib_suppress_qty_1 = ib_suppress_qty_1
iuoCart[llIndex].il_Disable_Debug = il_Disable_Debug


If is_section > "" Then
	iuoCart[llIndex].is_section = is_section
End if

If ib_use_doc_gen_settings Then
	iuoCart[llIndex].inv_doc_gen_settings = inv_doc_gen_settings
	iuoCart[llIndex].ib_use_doc_gen_settings = TRUE
End if

iuoCart[llIndex].of_create_rows(arg_l_rows)

return llIndex
	
end function

public function long of_set_type (long arg_l_column, long arg_l_row, long arg_l_type);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_set_type (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_column
*  long arg_l_row
*  long arg_l_type
*
* Return: long
*
*
* Setzen des Einschub-Typs
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llRetVal

if not isvalid(iuoCart[arg_l_column]) then
	llRetVal = EMPTY
else
	llRetVal = iuoCart[arg_l_column].of_set_type(arg_l_row, arg_l_type)
end if

return llRetVal
	
end function

public function long of_set_order (long arg_l_column, long arg_l_row, long arg_l_order);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_set_order (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_column
*  long arg_l_row
*  long arg_l_order
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
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*  20.08.2012	1.1           Oliver H$$HEX1$$f600$$ENDHEX$$fer       Order 0 wird zu 99
*
*************************************************************/
Long llRetVal, llFoundRow


If arg_l_order = 0 AND ib_split_evenly = TRUE then
	arg_l_order = 99
End if

if not isvalid(iuoCart[arg_l_column]) then
	llRetVal = - 1
else
	llRetVal = iuoCart[arg_l_column].of_set_order(arg_l_row, arg_l_order)
	// DW f$$HEX1$$fc00$$ENDHEX$$r die Verteilung
	llFoundRow  = idsAllocate.find( "ncolumn=" + String(arg_l_column) + " and nrow=" + String(arg_l_row) + "", 1, idsAllocate.Rowcount())
	if llFoundRow > 0 then
		idsAllocate.setitem(llFoundRow,"norder", arg_l_order)
	end if
end if

return llRetVal
	
end function

public function integer of_init_allocate (long arg_l_columns, long arg_l_rows);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_init_allocate (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_columns
*  long arg_l_rows
*
* Return: integer
*
*
* Init des DS zur Bestimmung der Verteilungsreihenfolge
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llColumn, llRow, llNewRow

for llColumn = 1 to arg_l_columns
	for llRow = 1 to arg_l_rows
		llNewRow = idsAllocate.insertrow(0)
		idsAllocate.setitem(llNewRow,"ncolumn",llColumn)
		idsAllocate.setitem(llNewRow,"nrow",llRow)
		
		// idsAllocate ORDER vorbelegen mit High Value
		idsAllocate.setitem(llNewRow,"norder", 99)
		
	next
next

// Hier kann der Initiale Verteilungsalgorithmus festgelegt werden
// -> Gilt nur f$$HEX1$$fc00$$ENDHEX$$r Schienen ohne Order (=0),
// Schienen mit Order 0 werden vor allen anderen gef$$HEX1$$fc00$$ENDHEX$$llt!
of_set_allocation_mode(BOTTOMUP)

return llNewRow
	
end function

public function long of_set_allocation_mode (long arg_l_mode);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_allocate (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* string arg_s_item
*  long arg_l_mode
*
* Return: long
*
*
* Festlegen der Verteilungsstategie
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
String lsSort

// gew$$HEX1$$e400$$ENDHEX$$hlte Reihenfolge anwenden
choose case arg_l_mode
	case BYORDER
		lsSort = "norder asc, nrow desc, ncolumn asc"
	case REVERSEORDER
		lsSort = "norder desc, nrow desc, ncolumn asc"
	case TOPDOWN
		lsSort = "nrow asc, ncolumn asc"
	case BOTTOMUP //von unten nach oben, links nach rechts 
		lsSort = " nrow desc, ncolumn asc"
	case LEFTTORIGHT
		lsSort = " ncolumn asc, nrow desc"
	case else
		// von unten nach oben, links nach rechts (BOTTOMUP)
		lsSort = "nrow desc, ncolumn asc"
end choose

idsAllocate.SetSort(lsSort)
idsAllocate.Sort()

////if il_Disable_Debug = 0 Then
////	//idsAllocate.print()
//If s_app.itrace =1 then
//	idsAllocate.saveas("c:\temp\cbase\idsallocate_" + String(cpu()) + ".XLS", excel5!, true)
////End If
//End if

return idsAllocate.Rowcount()

end function

public function long of_get_type (long arg_l_column, long arg_l_row);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_set_type (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_column
*  long arg_l_row
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
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llType

if not isvalid(iuoCart[arg_l_column]) then
	llType = EMPTY
else
	llType = iuoCart[arg_l_column].of_get_type(arg_l_row)
end if

return llType
	
end function

public function long of_get_row (long arg_l_column, long arg_l_row, ref s_distrib_items arg_str_item[]);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_get_row (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_column
*  long arg_l_row
*  ref s_distrib_items arg_str_item[]
*
* Return: long
*
*
* Attribute des Objekts ermitteln
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

long llItemLen = 0
Boolean	lb_breakpoint	

If arg_l_column =1 and arg_l_row =1 Then
	lb_breakpoint= TRUE
End If

if not isvalid(iuoCart[arg_l_column]) then
	llItemLen = EMPTY
else
	llItemLen = iuoCart[arg_l_column].of_get_row(arg_l_row, arg_str_item)
end if

return llItemLen
	
end function

public function long of_set_item (long arg_l_column, long arg_l_row, s_distrib_items arg_str_item[]);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_set_item (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_column
*  long arg_l_row
*  s_distrib_items arg_str_item[]
*
* Return: long
*
*
* Setzen der Attribute einer Row
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llRetVal

if not isvalid(iuoCart[arg_l_column]) then
	llRetVal = 0
else
	llRetVal = iuoCart[arg_l_column].of_set_item(arg_l_row, arg_str_item)
end if

return llRetVal
	
end function

public function string of_get_item_description (s_component arg_str_component);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_get_item_description (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 27.10.2009
* Argument(e):
* s_component arg_str_component
*
* Return: boolean
*
*
* Aus dem Profil die Konfiguration laden und anwenden 
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  16.11.2009	1.0           Ulrich Paudler     Erstellung
*  06.02.2012	1.1           Oliver H$$HEX1$$f600$$ENDHEX$$fer       Section f$$HEX1$$fc00$$ENDHEX$$r WEB nicht aus ACTIVESETUP
*  20.08.2012	1.2           Oliver H$$HEX1$$f600$$ENDHEX$$fer       CBASE-NAM-CR-12002 - Qty 1 anzeigen
*
*************************************************************/
string	ls_Value, ls_ArgItem, ls_Default, ls_Section
Integer	li_Config

// ----------------------------------------------------------------------
// 24.01.2012 bei Doc Gen Service nicht aus Profile, sondern Parameter
// ----------------------------------------------------------------------
If ib_use_doc_gen_settings Then
	ls_Value = String(inv_doc_gen_settings.il_ncart_component_display )
Else
	If Trim(is_CartDiagramComponentDisplay) > "" Then
		// Use cached value
		ls_Value = is_CartDiagramComponentDisplay
	Else
		If is_section > "" Then
			ls_Section = is_section
		Else		
			ls_Section = of_profilestring(s_app.suser,"settings_master", "ACTIVESETUP", "docbrowser")
			if trim(ls_Section) = "" Then ls_Section = "docbrowser"
		end if
		
		if ls_Section <> "docbrowser" Then
			li_Config = integer(Mid(ls_Section,11))
			ls_Default ="Default" +string(li_Config)
		Else
			ls_Default ="Default"
		End If
		ls_Value = of_profilestring(s_app.suser,ls_Default,"CartDiagramComponentDisplay","0") 
		is_CartDiagramComponentDisplay = ls_Value
	End If
End If

if ls_Value = "0" then
	ls_ArgItem= arg_str_component.ssnr + " - " + arg_str_component.stext
elseif ls_Value = "1" then
	ls_ArgItem= arg_str_component.ssnr
elseif ls_Value = "2" then
	ls_ArgItem= arg_str_component.stext	
end if

// NAM CR 12002 show Qty 1
If isNull(arg_str_component.squantity) Then arg_str_component.squantity = ""
If ib_suppress_qty_1 = FALSE OR arg_str_component.squantity <> "1" Then
	If arg_str_component.squantity <> "0" AND Trim(arg_str_component.squantity) > "" then
		ls_ArgItem = arg_str_component.squantity + " x " + ls_ArgItem
	End if
End if

if il_Disable_Debug = 0 Then f_trace("uo_cart_distribution.of_get_item_description " + ls_ArgItem)


Return ls_ArgItem

end function

public function string of_profilestring (string suser, string ssection, string skey, string sdefault);// --------------------------------------------------------------------------------
// Objekt : uo_cart_distribution
// Methode: of_profilestring (Function)
// Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
// --------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung:
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  27.03.2009	            Klaus F$$HEX1$$f600$$ENDHEX$$rster        Erstellung
//  30.10.2014	            Oliver Hoefer        Kein Insert, wenn nicht gefunden
//
// --------------------------------------------------------------------------------
string	sValue
Long lUserID

if sUser  =  sCachedUser and ssection = sCachedSection and skey = sCachedKey then
	return sCachedValue
end if

Select nuser_id into :lUserID from sys_login where cusername = :sUser;

if sqlca.sqlcode <> 0 then
	sCachedUser = ""
	sCachedSection = ""
	sCachedKey = ""
	sCachedValue = ""
	return sDefault
end if

Select 	cValue 
into 		:sValue 
from		loc_setup
where		nuser_id		= :lUserID	and
			cSection		= :sSection	and
			cKey			= :sKey;

If SQLCA.SQLCode = 100 Then
	
	sValue = sDefault

End if	

// Cache f$$HEX1$$fc00$$ENDHEX$$llen
sCachedUser = sUser
sCachedSection = sSection 
sCachedKey = sKey 
sCachedValue = sValue

return sValue
end function

public function long of_combine_item ();/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_combine_text (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 16.11.2009
* Argument(e):
* ref uo_cart_diagram arg_uo_cartdiagram
*
* Return: long
*
* Zusammenfassen von gleichen Items
*
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  16.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long  llIndex

for llIndex = 1 to upperbound(iuoCart)
	iuoCart[llIndex].of_combine_item()
next

return 0
end function

public function long of_check_row_limit (long arg_l_column, long arg_l_row, s_distrib_item_props arg_str_props);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_check_row_limit (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 18.01.2010
* Argument(e):
* long arg_l_column
*  long arg_l_row
*  s_distrib_item_props arg_str_props
*
* Return: long
*
*
* Pr$$HEX1$$fc00$$ENDHEX$$fen ob in dieser Koordinate (Spalte/Zeile) eine feste Anzahl vergeben ist
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  18.01.2010	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/


Long llRetVal

if not isvalid(iuoCart[arg_l_column]) then
	llRetVal = NOSPACELEFT
else 
	llRetVal = iuoCart[arg_l_column].of_check_row_limit(arg_l_row, arg_str_props)
end if

return llRetVal
	
end function

public function long of_check_row_limit (long arg_l_column, long arg_l_row);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_check_row_limit (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 18.01.2010
* Argument(e):
* long arg_l_column
*  long arg_l_row
*
* Return: long
*
*
* Pr$$HEX1$$fc00$$ENDHEX$$fen ob in dieser Koordinate (Spalte/Zeile) eine feste Anzahl vergeben ist
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  18.01.2010	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/


Long llRetVal

if not isvalid(iuoCart[arg_l_column]) then
	llRetVal = NOSPACELEFT
else 
	llRetVal = iuoCart[arg_l_column].of_check_row_limit(arg_l_row)
end if

return llRetVal
	
end function

public function long of_set_length (long arg_l_column, long arg_l_row, long arg_l_length);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_set_length (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_column
*  long arg_l_row
*  long arg_l_length
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
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llRetVal

if not isvalid(iuoCart[arg_l_column]) then
	llRetVal = - 1
else
	llRetVal = iuoCart[arg_l_column].of_set_length(arg_l_row, arg_l_length)
end if

return llRetVal
	
end function

public function long of_get_cart_dimension (string arg_s_type, long arg_l_airline, long arg_l_indexkey, long arg_l_detailkey, ref long ref_l_columns, ref long ref_l_rows, ref long ref_l_length);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_get_cart_dimension (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 16.11.2009
* Argument(e):
* string arg_s_type
*  long arg_l_airline
*  long arg_l_indexkey
*  long arg_l_detailkey
*  ref long ref_l_columns
*  ref long ref_l_rows
*  ref long ref_l_length
*
* Return: long
*
*
* Ermittlung der Cartparameter
* Die Tiefe wird durch die Anzahl der Spalten geteilt
* z.B. 2 Spalten 6000 Tiefe -> 2 * 3000 
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  16.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
// Anzahl der Spalten und Zeilen ermitteln
Select ncolumns, nrows 
	into :ref_l_columns, :ref_l_rows 
	from cen_airline_eq 
	where cunit = :arg_s_type and nairline_key=:arg_l_airline 
	using sqlca;

if sqlca.sqlcode <> 0 then
	ref_l_columns = 0
	ref_l_rows = 0
	ref_l_length = 0
	return -1
end if

// die Tiefe des Cart herausfinden
Select max(nwidth)
	into :ref_l_length 
	from cen_packinglist_size 
	where npackinglist_index_key = :arg_l_indexkey and npackinglist_detail_key=:arg_l_detailkey 
	using sqlca;

if sqlca.sqlcode <> 0 then
	ref_l_columns = 0
	ref_l_rows = 0
	ref_l_length = 0
	return -1
end if

if isnull(ref_l_length) then 
	ref_l_length = 3000
// Effektive Tiefe durch die Anzahl der Spalten teilen
elseif  ref_l_length * ref_l_columns > 0 then
	ref_l_length = ref_l_length / ref_l_columns
end if

return 0

end function

public function long of_check_row (long arg_l_column, long arg_l_row, long arg_l_length);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_check_row (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 10.11.2009
* Argument(e):
* long arg_l_column
*  long arg_l_row
*  long arg_l_length
*
* Return: long
*
*
* Pr$$HEX1$$fc00$$ENDHEX$$fen ob in dieser Koordinate (Spalte/Zeile) noch Platz vorhanden ist
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  10.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llRetVal

if not isvalid(iuoCart[arg_l_column]) then
	llRetVal = NOSPACELEFT
else 
	llRetVal = iuoCart[arg_l_column].of_check_row(arg_l_row, arg_l_length)
end if

if il_Disable_Debug = 0 Then
	f_trace("uo_cart_distribution.of_check_row arg_l_length " + String(arg_l_length  ) )
end if

return llRetVal
	
end function

public function long of_check_row_item (long arg_l_column, long arg_l_row, long arg_l_length, s_distrib_item_props arg_str_props, long al_min_fit_factor);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_check_row_item (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 10.11.2009
* Argument(e):
*	long arg_l_column
*  long arg_l_row
*  long arg_l_length
*  s_distrib_item_props arg_str_props
*
* Return: long
*
*
* Pr$$HEX1$$fc00$$ENDHEX$$fen ob an dieser Stelle dieses Item hineinpasst und darf
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  10.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llIndex

if not isvalid(iuoCart[arg_l_column]) then
	llIndex = NOSPACELEFT
else
	// pr$$HEX1$$fc00$$ENDHEX$$fen ob ein bevorzugter Platz vorhanden ist
	llIndex = iuoCart[arg_l_column].of_check_row_item(arg_l_row, arg_str_props, al_min_fit_factor) 
end if

return llIndex
	
end function

public function long of_get_row_without_sub (long arg_l_column, long arg_l_row, ref s_distrib_items arg_str_item[]);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_get_row (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_column
*  long arg_l_row
*  ref s_distrib_items arg_str_item[]
*
* Return: long
*
*
* Attribute des Objekts ermitteln
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

long llItemLen = 0
Boolean	lb_breakpoint	

If arg_l_column =1 and arg_l_row =1 Then
	lb_breakpoint= TRUE
End If

if not isvalid(iuoCart[arg_l_column]) then
	llItemLen = EMPTY
else
	llItemLen = iuoCart[arg_l_column].of_get_row_without_sub(arg_l_row, arg_str_item)
end if

return llItemLen
	
end function

public function long of_set_row (long arg_l_column, long arg_l_row, long arg_l_length, string arg_s_item, long arg_l_print_column, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_set_row (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 10.11.2009
* Argument(e):
* long arg_l_column
*  long arg_l_row
*  long arg_l_length
*  string arg_s_item
*  long arg_l_print_column
*
* Return: long
*
*
* setzen der Itemproperties der Row
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  10.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

Long llRetVal

if il_Disable_Debug= 0 then
	f_trace("uo_cart_distribution.of_set_row arg_l_column=" + String(arg_l_column) +" arg_l_row=" +  String(arg_l_row ) + " arg_l_print_column="+ String(arg_l_print_column)  + " / " + as_ssnr + " / " + as_text )			
End If


if not isvalid(iuoCart[arg_l_column]) then
	llRetVal = 0
// Text soll genau in die Spalte in der auch das Item liegt
elseif arg_l_column = arg_l_print_column then
	llRetVal = iuoCart[arg_l_column].of_set_row(arg_l_row, arg_l_length, arg_s_item, arg_l_print_column, astr_sub, as_ssnr, as_text)
else
	llRetVal = iuoCart[arg_l_column].of_set_row(arg_l_row, arg_l_length, arg_s_item, 0, astr_sub, as_ssnr, as_text)
end if

return llRetVal
	
end function

public function long of_allocate_w_split (s_component arg_str_component, ref long ref_l_column, ref long ref_l_row, long al_min_fit_factor, s_distrib_item_sub astr_sub[], uo_cart_diagram rauo_cart_diagram, long al_qty);/*
* Objekt : uo_cart_distribution
* Methode: of_allocate_w_split (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 14.08.2012
*
* Argument(e):
*	 		s_component arg_str_component
*	 ref	long						ref_l_column
*	 ref	long						ref_l_row
*	 		long						al_min_fit_factor
*	 		s_distrib_item_sub	astr_sub[]
*	 		uo_cart_diagram		rauo_cart_diagram
*	 		long						al_qty
*
* Beschreibung:		Weiterentwicklung von of_allocate (split evenly CBASE-NAM-CR-12038)
*							Besonderheit: gleichm$$HEX2$$e400df00$$ENDHEX$$ig verteilen bei gleichem Ranking und gleichem Platzhalter
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	14.08.2012		Erstellung als erweiterte Kopie von of_allocate
* 1.1 			O.Hoefer	10.08.2018		Issue 3993 Sort Order auch kein Match in 4 Kriterien 
*
*
* Return: long
*
*/

Integer			li_Succ
Long				ll_Alloc_Order, ll_RetVal, ll_Shortage, ll_ShortageColumn, ll_Length
long				ll_ArgLength, ll_Index
String			ls_ArgItem
Long				ll_type
String			ls_Filter
Boolean			lb_Header_Exists		= FALSE
Boolean			lb_Distr_Items_Bold	= FALSE
Long				ll_Target_Row
Long				ll_Qty_Alloc
Long				ll_Order
Boolean			lb_Breakpoi
Integer			li_Check
String			ls_code
Boolean			lb_Breakpoint
Long				ll_Counter, ll_Fullmatch
s_distrib_item_props lstrArgProps


//il_disable_debug = 0 

ls_ArgItem = of_get_item_description(arg_str_component)

If arg_str_component.ssnr  = "EMH+TRY31" then
	lb_Breakpoint = TRUE
End if

ib_Split_Evenly = TRUE

li_Succ = idsAllocateProps.Sort()

if il_Disable_Debug = 0 Then
	f_trace("uo_cart_distribution.of_allocate_w_split Column " + String(ref_l_column) + " / Row " + String(ref_l_row) + " " + arg_str_component.ssnr + " / " + arg_str_component.stext )
End If

ll_ArgLength = arg_str_component.llength
lstrArgProps = arg_str_component.str_item_props
ls_code = lstrArgProps.smeal_control_code

// --------------------------------------------------------------------------
// Filter relevant entries and move the rest to the "end" of the datastore
// --------------------------------------------------------------------------
ls_Filter  =      "cclass='"			+ lstrArgProps.sclass              + "'"
ls_Filter += " AND cdistr_code='"	+ lstrArgProps.smeal_control_code  + "'"
ls_Filter += " AND cdistr_type='"	+ lstrArgProps.stext               + "'"
ls_Filter += " AND nspml="				+ String(lstrArgProps.lspml)

ll_Fullmatch = 0
idsAllocateProps.SetFilter(ls_Filter)
idsAllocateProps.Filter()
idsAllocateProps.Sort()

If idsAllocateProps.Filteredcount() > 0 Then
	If idsAllocateProps.rowcount() = 0 then
		idsAllocateProps.SetFilter("")
		idsAllocateProps.Filter()
		idsAllocateProps.Sort()
	Else
		ll_Fullmatch = idsAllocateProps.rowcount()
		For ll_Counter = 1 To idsAllocateProps.rowcount()
			idsAllocateProps.SetItem( ll_Counter, "nnofullmatch", 0) 
		Next

		ll_Target_Row = idsAllocateProps.RowCount() + 10
		li_Succ = idsAllocateProps.RowsMove (1, idsAllocateProps.Filteredcount(), Filter!, idsAllocateProps, ll_Target_Row, Primary! )
		
		If idsAllocateProps.rowcount() > ll_Fullmatch Then
			For ll_Counter = ll_Fullmatch + 1 To idsAllocateProps.rowcount()
				idsAllocateProps.SetItem( ll_Counter, "nnofullmatch", 1) 
			Next
			idsAllocateProps.Sort()
		End If
		
	End If
End If


//if s_app.itrace > 0 then
//	li_Check = idsAllocateProps.saveas("c:\temp\cbase\allocate_" + arg_str_component.ssnr + "_" + String(now(),"hhmmssfff") +  ".xls",excel5!,true)
//End If

// 1	arg_str_props.stext
// 2	arg_str_props.smeal_control_code
// 3	arg_str_props.sclass
// 4	arg_str_props.lspml


if il_disable_debug = 0 then
//	of_save_idsallocateprops( arg_str_component.ssnr )
end if


// Zuerst die reservierten Pl$$HEX1$$e400$$ENDHEX$$tze belegen (first fit)
// diese sind per Platzhalter z.B. "TSU/1111/C/SPML" gekennzeichnet
for ll_Alloc_Order = 1 to idsAllocateProps.Rowcount()
	ref_l_column 	= idsAllocateProps.getitemnumber(ll_Alloc_Order,"ncolumn")
	ref_l_row		= idsAllocateProps.getitemnumber(ll_Alloc_Order,"nrow")
	choose case of_get_type(ref_l_column, ref_l_row) 
		case TRAY, DRAWERFOOD
			if il_Disable_Debug = 0 Then f_trace("uo_cart_distribution.of_allocate_w_split Column/Row " + String(ref_l_column) + " / " + String(ref_l_row) + " TRAY, DRAWERFOOD")
		case DRAWER_MULTI_RUNG
			if il_Disable_Debug = 0 Then f_trace("uo_cart_distribution.of_allocate_w_split Column/Row " + String(ref_l_column) + " / " + String(ref_l_row) + " DRAWER_MULTI_RUNG")
		case else
			//if il_Disable_Debug = 0 Then f_trace("uo_cart_distribution.of_allocate Column/Row " + String(ref_l_column) + " / " + String(ref_l_row) + " OTHER => CONTINUE")
			continue
	end choose
	
	// ist ein reservierter Platz vorhanden, dann auch benutzen
	ll_Index = of_check_row_item(ref_l_column, ref_l_row, ll_ArgLength, lstrArgProps, al_min_fit_factor)	
	if ll_Index > 0 then
		// ------------------------------------------------------------------------
		// Distributed Content: Top = Bold ausser Multirung & Header vorhanden 
		// ------------------------------------------------------------------------
		lb_Distr_Items_Bold = FALSE
		ll_type = of_get_type(ref_l_column, ref_l_row) 
		If ll_type = TRAY OR ll_type = DRAWERFOOD Then
			lb_Header_Exists = FALSE
		Else
			If ll_type = DRAWER_MULTI_RUNG Then
				lb_Header_Exists = rauo_cart_diagram.of_exists_content_sheet_header(ref_l_column, ref_l_row)
			End If
		End If
		If lb_Header_Exists Then
			lb_Distr_Items_Bold = FALSE
			if il_Disable_Debug= 0 then f_trace("uo_cart_distribution.of_allocate_w_split DISTR ITEMS TOP BOLD FALSE " + arg_str_component.ssnr + " / " + arg_str_component.stext )			
		ELSE
			lb_Distr_Items_Bold = TRUE
			if il_Disable_Debug= 0 then f_trace("uo_cart_distribution.of_allocate_w_split DISTR ITEMS TOP BOLD TRUE " + arg_str_component.ssnr + " / " + arg_str_component.stext )			
		End if
			
		ll_RetVal = of_set_row_item(ref_l_column, ref_l_row, ll_ArgLength, ls_ArgItem, ref_l_column, ll_Index, astr_sub, arg_str_component.ssnr, arg_str_component.stext , lb_Distr_Items_Bold, ls_code  )	

		if il_Disable_Debug = 0 then f_trace("uo_cart_distribution.of_allocate_w_split of_set_row_item " + arg_str_component.ssnr + " / " + arg_str_component.stext )			
		if il_Disable_Debug = 0 Then f_trace("uo_cart_distribution.of_allocate_w_split of_check_row_item reservierter Platz vorhanden " + String(ll_Index) + " ll_RetVal " + String(ll_RetVal))
		if il_Disable_Debug = 0 Then f_trace("uo_cart_distribution.of_allocate_w_split Column/Row " + String(ref_l_column) + " / " + String(ref_l_row) + " " + arg_str_component.ssnr + " / " + arg_str_component.stext )

		// --------------------------------------
		// DS Update - nur wenn Order gesetzt
		// --------------------------------------
		ll_Order = idsAllocateProps.GetItemNumber(ll_Alloc_Order, "norder")
		If ll_Order > 0 AND ll_Order < 90 Then
			ll_Qty_Alloc = idsAllocateProps.getitemnumber(ll_Alloc_Order, "nqty_alloc")
			ll_Qty_Alloc++
			li_Succ = idsAllocateProps.SetItem(ll_Alloc_Order,"nqty_alloc", ll_Qty_Alloc)
		Else
			if il_Disable_Debug = 0 Then f_trace("uo_cart_distribution.of_allocate NO ORDER Column/Row " + String(ref_l_column) + " / " + String(ref_l_row) + " " + arg_str_component.ssnr + " / " + arg_str_component.stext )
		End If

		
		return ll_RetVal
	else
		if il_Disable_Debug = 0 Then
			If al_min_fit_factor < 2 then
				f_trace("uo_cart_distribution.of_allocate_w_split " + arg_str_component.ssnr + " KEIN PLATZ Column/Row " + String(ref_l_column) + " / " + String(ref_l_row))
			end if
		end if
	end if
next

If al_min_fit_factor > 0 Then
	if il_Disable_Debug = 0 Then
		f_trace("of_allocate_w_split NICHT REST VERTEILEN al_min_fit_factor " + String(al_min_fit_factor))
	end if
	return -1
End If

// nun den Rest verteilen und alle zeilen abklappern (first fit)
for ll_Alloc_Order = 1 to idsAllocateProps.Rowcount()
	ref_l_column 	= idsAllocateProps.getitemnumber(ll_Alloc_Order,"ncolumn")
	ref_l_row		= idsAllocateProps.getitemnumber(ll_Alloc_Order,"nrow")
	choose case of_get_type(ref_l_column, ref_l_row) 
		case TRAY, DRAWERFOOD
			if il_Disable_Debug = 0 Then
				f_trace("of_allocate_w_split TRAY, DRAWERFOOD nun den Rest verteilen und alle Zeilen abklappern (first fit) C " + String(ref_l_column) + " / R " + String(ref_l_row))
			end if
		case DRAWER_MULTI_RUNG
			if il_Disable_Debug = 0 Then
				f_trace("of_allocate_w_split DRAWER_MULTI_RUNG nun den Rest verteilen und alle Zeilen abklappern (first fit) C " + String(ref_l_column) + " / R " + String(ref_l_row))
			end if

		case else
			if il_Disable_Debug = 0 Then
				f_trace("of_allocate_w_split NO SUPPORTED TYPE C " + String(ref_l_column) + " / R " + String(ref_l_row))
			end if
			continue
	end choose
	// Passt es rein?
	ll_Shortage = of_check_row(ref_l_column, ref_l_row, ll_ArgLength)
	if ll_Shortage >= 0 then
		// wenn ja dann einf$$HEX1$$fc00$$ENDHEX$$gen und raus
		if il_Disable_Debug= 0 then
			f_trace("uo_cart_distribion.of_allocate_w_split of_set_row ll_Shortage>=0 " + arg_str_component.ssnr + " / " + arg_str_component.stext )			
		End If

		ll_RetVal = of_set_row(ref_l_column, ref_l_row, ll_ArgLength, ls_ArgItem, ref_l_column, astr_sub, arg_str_component.ssnr, arg_str_component.stext )	
		if il_Disable_Debug = 0  Then	f_trace("of_allocate_w_split ll_Shortage >= 0 " + ls_ArgItem + "C " + String(ref_l_column) + " / R " + String(ref_l_row))


		return ll_RetVal
		// Wenn in der 2.Spalte ein Tray vorhanden ist, dann versuchen auch in diesen aufzuteilen: $$HEX1$$dc00$$ENDHEX$$berlappung
	elseif ilColumns = 2 and ref_l_column = 1 then
		choose case of_get_type(ref_l_column + 1, ref_l_row) 
			case TRAY, DRAWERFOOD
				if il_Disable_Debug = 0 Then f_trace("of_allocate_w_split TRAY, DRAWERFOOD ilColumns = 2 and ref_l_column = 1 ")
				ll_Shortage = ll_Shortage * -1
				ll_Length = ll_ArgLength - ll_Shortage
				// nur wenn  in der ersten Spalte noch Platz $$HEX1$$fc00$$ENDHEX$$brig ist
				if ll_Length > 0 then
					ll_ShortageColumn =  of_check_row(ref_l_column + 1, ref_l_row, ll_Length )
					if  ll_ShortageColumn >= 0 then
						// wenn ja dann in beide einf$$HEX1$$fc00$$ENDHEX$$gen und raus, Die Column 1 erh$$HEX1$$e400$$ENDHEX$$lt die Beschreibung
						if il_Disable_Debug= 0 then f_trace("uo_cart_distribion.of_allocate_w_split of_set_row " + arg_str_component.ssnr + " / " + arg_str_component.stext )			

						ll_RetVal = of_set_row(ref_l_column, ref_l_row, ll_Shortage, ls_ArgItem, ref_l_column, astr_sub, arg_str_component.ssnr, arg_str_component.stext )	
						ll_RetVal = of_set_row(ref_l_column + 1, ref_l_row, ll_Length, ls_ArgItem, ref_l_column, astr_sub, arg_str_component.ssnr, arg_str_component.stext 	)	

						if il_Disable_Debug = 0 Then f_trace("uo_cart_distribution.of_allocate_w_split Column/Row " + String(ref_l_column) + " / " + String(ref_l_row) + " $$HEX1$$dc00$$ENDHEX$$BERLAPPEND COLUMN " + String(ref_l_column + 1) + " " + arg_str_component.ssnr + " / " + arg_str_component.stext )
						
						return ll_RetVal									
					end if
				end if
				
			case DRAWER_MULTI_RUNG	
				ll_Shortage = ll_Shortage * -1
				ll_Length = ll_ArgLength - ll_Shortage
				if il_Disable_Debug = 0 Then f_trace("of_allocate_w_split DRAWER_MULTI_RUNG ilColumns = 2 and ref_l_column = 1 ll_Shortage=" + String(ll_Shortage))
				// nur wenn  in der ersten Spalte noch Platz $$HEX1$$fc00$$ENDHEX$$brig ist
				if ll_Length > 0 then
					ll_ShortageColumn =  of_check_row(ref_l_column + 1, ref_l_row, ll_Length )
					if ll_ShortageColumn >= 0 then
						if il_Disable_Debug= 0 then f_trace("uo_cart_distribion.of_allocate_w_split col1:"+String(ll_Length)+" of_set_row " + arg_str_component.ssnr + " / " + arg_str_component.stext )			
						
						// wenn ja dann in beide einf$$HEX1$$fc00$$ENDHEX$$gen und raus, Die Column 1 erh$$HEX1$$e400$$ENDHEX$$lt die Beschreibung
						ll_RetVal = of_set_row(ref_l_column, ref_l_row, ll_ArgLength - ll_Shortage , ls_ArgItem, ref_l_column, astr_sub, arg_str_component.ssnr, arg_str_component.stext)
						ll_RetVal = of_set_row(ref_l_column + 1, ref_l_row, ll_Shortage, ls_ArgItem, ref_l_column, astr_sub, arg_str_component.ssnr, arg_str_component.stext)

						if il_Disable_Debug = 0 Then
							f_trace("uo_cart_distribution.of_allocate_w_split llArgLength - ll_Shortage=" + String(ll_ArgLength - ll_Shortage)+" col2:ll_Shortage=" + String(ll_Shortage)+ " Column/Row " + String(ref_l_column) + " / " + String(ref_l_row) + " $$HEX1$$dc00$$ENDHEX$$BERLAPPEND COLUMN " + String(ref_l_column + 1) + " " + arg_str_component.ssnr + " / " + arg_str_component.stext )
							f_trace("uo_cart_distribution.of_allocate_w_split col1:ll_Shortage=" + String(ll_Shortage)+" col2:llLength=" + String(ll_Length)+ " Column/Row " + String(ref_l_column) + " / " + String(ref_l_row) + " $$HEX1$$dc00$$ENDHEX$$BERLAPPEND COLUMN " + String(ref_l_column + 1) + " " + arg_str_component.ssnr + " / " + arg_str_component.stext )
						End If
						
						// ------------------------------------------------------------------------
						// Distributed Content: Top = Bold ausser Multirung & Header vorhanden 
						// ------------------------------------------------------------------------
						lb_Distr_Items_Bold = FALSE
						ll_type = of_get_type(ref_l_column, ref_l_row) 
						If ll_type = TRAY OR ll_type = DRAWERFOOD Then
							lb_Header_Exists = FALSE
						Else
							If ll_type = DRAWER_MULTI_RUNG Then
								lb_Header_Exists = rauo_cart_diagram.of_exists_content_sheet_header(ref_l_column, ref_l_row)
							End If
						End If
						If lb_Header_Exists Then
							lb_Distr_Items_Bold = FALSE
							if il_Disable_Debug= 0 then f_trace("uo_cart_distribution.of_allocate_w_split DISTR ITEMS TOP BOLD FALSE " + arg_str_component.ssnr + " / " + arg_str_component.stext )			
						ELSE
							lb_Distr_Items_Bold = TRUE
							if il_Disable_Debug= 0 then f_trace("uo_cart_distribution.of_allocate_w_split DISTR ITEMS TOP BOLD TRUE " + arg_str_component.ssnr + " / " + arg_str_component.stext )			
						End if
														
						Return ll_RetVal
					else
						if il_Disable_Debug = 0 Then f_trace("of_allocate_w_split DRAWER_MULTI_RUNG ll_ShortageColumn < 0 ")
						
					end if
				Else
					if il_Disable_Debug = 0 Then f_trace("of_allocate_w_split DRAWER_MULTI_RUNG Length <= 0 ")
				end if
				
		end choose
	else
		if il_Disable_Debug = 0  Then f_trace("of_allocate_w_split ll_Shortage = " + String(ll_Shortage ) + " / " + ls_ArgItem + "C " + String(ref_l_column) + " / R " + String(ref_l_row))

	end if
Next

// wenn es bis hier hin l$$HEX1$$e400$$ENDHEX$$uft dann konnte es nirgendwo reingestopft werden !

Return -1

end function

public function long of_set_alloc_props (long arg_l_column, long arg_l_row, integer arg_l_order, s_distrib_items arg_str_item[]);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_set_alloc_props (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_column
*  long arg_l_row
*  s_distrib_items arg_str_item[]
*
* Return: long
*
*
* Setzen der Attribute einer Row
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long		llRetVal
Long		ll_New_Row
Long		ll_Count
String	ls_Code
String	ls_Text
String	ls_Class
Long		ll_SPML
Integer	li_Succ
Long		ll_Qty
String	ls_Temp
Long		ll_Found
String	ls_Find


For ll_Count = 1 To Upperbound(arg_str_item)
	ls_Code	= arg_str_item[ll_Count].str_prop.smeal_control_code
	ls_Text	= arg_str_item[ll_Count].str_prop.stext
	ls_Class	= arg_str_item[ll_Count].str_prop.sclass
	ll_SPML	= arg_str_item[ll_Count].str_prop.lSPML
	ll_Qty	= arg_str_item[ll_Count].str_prop.llimit
	
	If IsNULL(ls_Class)		Then ls_Class	= ""
	If IsNULL(ls_Text)		Then ls_Text	= ""
	If IsNULL(ls_Code)		Then ls_Code	= ""
	If IsNULL(ll_SPML)		Then ll_SPML = 0
	If IsNULL(ll_Qty)			Then ll_Qty	= 0
	
	If arg_l_order = 0 Then arg_l_order = 99
	
	If trim(ls_Code) = "" AND trim(ls_Text) = "" AND  trim(ls_Class) = "" Then
		ls_Find  = " ncolumn="		+ String(arg_l_column)
		ls_Find += " AND nrow="		+ String(arg_l_row)
		ll_Found = idsAllocateProps.Find(ls_Find, 1, idsAllocateProps.RowCOunt())
		If ll_Found > 0 then CONTINUE
		
	End If
	
	ll_New_Row = idsAllocateProps.InsertRow(0)
	
	li_Succ = idsAllocateProps.SetItem(ll_New_Row, "ncolumn", arg_l_column)
	li_Succ = idsAllocateProps.SetItem(ll_New_Row, "nrow", arg_l_row)
	li_Succ = idsAllocateProps.SetItem(ll_New_Row, "norder", arg_l_order)
	li_Succ = idsAllocateProps.SetItem(ll_New_Row, "nqty_distr", ll_Qty)
	li_Succ = idsAllocateProps.SetItem(ll_New_Row, "cdistr_code", ls_Code)
	li_Succ = idsAllocateProps.SetItem(ll_New_Row, "cdistr_type", ls_Text)
	li_Succ = idsAllocateProps.SetItem(ll_New_Row, "cclass", ls_Class)
	li_Succ = idsAllocateProps.SetItem(ll_New_Row, "nspml", ll_SPML)
	
	if il_Disable_Debug = 0 Then	
		ls_temp = classname() + "of_set_alloc_props COL " + String(arg_l_column) + " ROW " + String(arg_l_row) 
		If trim(ls_Code) = ""	Then ls_Code	= "[EMPTY]"
		If trim(ls_Text) = ""	Then ls_Text	= "[EMPTY]"
		If trim(ls_Class) = ""	Then ls_Class	= "[EMPTY]"
		
		ls_temp += ": ORDER: " + String(arg_l_order, "#0") + "  "  + ls_Text + "/" + ls_Code + "/" +ls_Class + " qty: " + String(ll_Qty)
		f_trace(ls_temp)						
	End If
	
Next

/*
ncolumn
nrow
norder
nqty_alloc
nqty_distr
cdistr_type
cdistr_code
nspml
*/

Return llRetVal

	
end function

public subroutine of_save_idsallocateprops (string as_name);
// Debug
//idsAllocateProps.saveas("c:\temp\cbase\idsAllocateProps_"+ as_Name + "_" + String(datetime(today(),now()), "yyyymmddhhmmssfff") + ".xls",excel5!,true)

end subroutine

public function long of_set_row_item (long arg_l_column, long arg_l_row, long arg_l_length, string arg_s_item, long arg_l_print_column, long arg_l_index, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text, boolean ab_bold, string as_code);/*************************************************************
* Objekt : uo_cart_distribution
* Methode: of_set_row (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 10.11.2009
* Argument(e):
* long arg_l_column
*  long arg_l_row
*  long arg_l_length
*  string arg_s_item
*  long arg_l_print_column
*  long arg_l_index
*
* Return: long
*
*
* setzen der Itemproperties der Row
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  10.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llRetVal


if il_Disable_Debug= 0 then
	f_trace("uo_cart_distribution.of_set_row_item " + as_ssnr + " / " + as_text )			
End If
	
if not isvalid(iuoCart[arg_l_column]) then
	llRetVal = 0
	
	If il_Disable_Debug = 0 Then
		f_trace("uo_cart_distribution.of_set_row_item not isvalid(iuoCart[arg_l_column]) " + String(arg_l_column))
	End If
	
// Text soll genau in die Spalte in der auch das Item liegt
elseif arg_l_column = arg_l_print_column then
	llRetVal = iuoCart[arg_l_column].of_set_row_item(arg_l_row, arg_l_length, arg_s_item, arg_l_print_column, arg_l_index, astr_sub , as_ssnr , as_text, ab_bold, as_code)
else
	llRetVal = iuoCart[arg_l_column].of_set_row_item(arg_l_row, arg_l_length, arg_s_item, 0, arg_l_index, astr_sub , as_ssnr , as_text, ab_bold, as_code)
end if

return llRetVal
	
end function

on uo_cart_distribution.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cart_distribution.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;/*************************************************************
* Objekt : uo_cart_distribution
* Methode: destructor (Event)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
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
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long  llIndex

for llIndex = 1 to upperbound(iuoCart)
	if isvalid (iuoCart[llIndex]) then destroy iuoCart[llIndex]
next

DESTROY	idsAllocate

DESTROY	idsAllocateProps

// Document Engine st$$HEX1$$fc00$$ENDHEX$$rzt bei GarbageCollect() ab
If getApplication().AppName = "cbase" Then GarbageCollect()
//GarbageCollect()
end event

event constructor;/*************************************************************
* Objekt : uo_cart_distribution
* Methode: constructor (Event)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
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
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

idsAllocate = create Datastore
idsAllocate.dataobject="dw_uo_distribution_allocate"


idsAllocateProps = create Datastore
idsAllocateProps.dataobject="dw_uo_distribution_allocate_props"

end event

