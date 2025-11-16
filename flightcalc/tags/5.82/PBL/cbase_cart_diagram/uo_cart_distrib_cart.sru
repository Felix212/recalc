HA$PBExportHeader$uo_cart_distrib_cart.sru
forward
global type uo_cart_distrib_cart from nonvisualobject
end type
end forward

global type uo_cart_distrib_cart from nonvisualobject
end type
global uo_cart_distrib_cart uo_cart_distrib_cart

type variables

/*************************************************************
* Objekt : uo_cart_distrib_cart
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

CONSTANT Long EMPTY = 0
CONSTANT Long DRAWER = 1
CONSTANT Long TRAY = 2
CONSTANT Long DRAWERFOOD = 3
CONSTANT Long TRAYNONFOOD= 4
CONSTANT Long BLOCKED = 9

CONSTANT Long NOSPACELEFT = -9999999

Private:
Long ilRows
uo_cart_distrib_row uoCartRow[]

Public Long	il_Disable_Debug = 1 //0

Public	n_doc_gen_settings	inv_doc_gen_settings
Public	Boolean					ib_use_doc_gen_settings

Public	String	is_user = ""
Public	String	is_section = ""

PUBLIC	Boolean	ib_suppress_qty_1 = FALSE

end variables

forward prototypes
public function long of_create_rows (long arg_l_rows)
public function long of_add_row ()
public function long of_set_type (long arg_l_row, long arg_l_type)
public function long of_get_rowcount ()
public function long of_set_order (long arg_l_row, long arg_l_order)
public function long of_get_type (long arg_l_row)
public function long of_get_row (long arg_l_row, ref s_distrib_items arg_str_item[])
public function long of_set_item (long arg_l_row, s_distrib_items arg_str_item[])
public function long of_combine_item ()
public function long of_check_row_limit (long arg_l_row, s_distrib_item_props arg_str_props)
public function long of_check_row_limit (long arg_l_row)
public function long of_set_length (long arg_l_row, long arg_l_length)
public function long of_check_row (long arg_l_row, long arg_l_length)
public function long of_check_row_item (long arg_l_row, s_distrib_item_props arg_str_props, long al_min_fit_factor)
public function long of_get_row_without_sub (long arg_l_row, ref s_distrib_items arg_str_item[])
public function long of_set_row (long arg_l_row, long arg_l_length, string arg_s_item, long arg_l_show, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text)
public function long of_set_row_item (long arg_l_row, long arg_l_length, string arg_s_item, long arg_l_show, long arg_l_index, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text, boolean ab_bold, string as_code)
end prototypes

public function long of_create_rows (long arg_l_rows);/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_create_rows (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* long arg_l_rows
*
* Return: long
*
*
* Cart aufbauen, Rows erzeugen
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llIndex

for llIndex = 1 to arg_l_rows
	ilRows = of_add_row()
next

return ilRows
	

end function

public function long of_add_row ();/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_add_row (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
*
* Return: long
*
*
* Schiene hinzuf$$HEX1$$fc00$$ENDHEX$$gen (fast eine Factory!)
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*  06.02.2012	1.1           Oliver H$$HEX1$$f600$$ENDHEX$$fer       User / Section f$$HEX1$$fc00$$ENDHEX$$r WEB
*  22.08.2012	1.2           Oliver H$$HEX1$$f600$$ENDHEX$$fer       Schalter Suppress Qty 1
*
*************************************************************/
Long llIndex

llIndex =  upperbound(uoCartRow) + 1

uoCartRow[llIndex] = create uo_cart_distrib_row
uoCartRow[llIndex].of_set_length(0)
uoCartRow[llIndex].of_set_order(0)
uoCartRow[llIndex].of_set_type(0)

uoCartRow[llIndex].ib_suppress_qty_1 = ib_suppress_qty_1

uoCartRow[llIndex].il_Disable_Debug = il_Disable_Debug


If is_user > "" then
	uoCartRow[llIndex].is_user = is_user
end if

If is_section > "" then
	uoCartRow[llIndex].is_section = is_section
end if

If ib_use_doc_gen_settings Then
	uoCartRow[llIndex].inv_doc_gen_settings = inv_doc_gen_settings
	uoCartRow[llIndex].ib_use_doc_gen_settings = TRUE
End if

return llIndex
	

end function

public function long of_set_type (long arg_l_row, long arg_l_type);/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_set_type (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_row
*  long arg_l_type
*
* Return: long
*
*
* Setzen des Einschubtyps
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/



Long llIndex

if not isvalid(uoCartRow[arg_l_row]) then
	llIndex = 0
else
	llIndex = uoCartRow[arg_l_row].of_set_type( arg_l_type)
end if

return llIndex
	

end function

public function long of_get_rowcount ();/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_get_rowcount (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* none
*
* Return: long
*
*
* R$$HEX1$$fc00$$ENDHEX$$ckgabe der Zeilenzahl
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/


return ilRows
	

end function

public function long of_set_order (long arg_l_row, long arg_l_order);/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_set_order (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_row
*  long arg_l_order
*
* Return: long
*
*
* Festlegen der Verteilungsorder
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llIndex

if not isvalid(uoCartRow[arg_l_row]) then
	llIndex = 0
else
	llIndex = uoCartRow[arg_l_row].of_set_order( arg_l_order)
end if

return llIndex
	

end function

public function long of_get_type (long arg_l_row);/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_get_type (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_row
*
* Return: long
*
*
* Type ermitteln
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llType

if not isvalid(uoCartRow[arg_l_row]) then
	llType = EMPTY
else
	llType = uoCartRow[arg_l_row].of_get_type()
end if

return llType
	

end function

public function long of_get_row (long arg_l_row, ref s_distrib_items arg_str_item[]);/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_get_row (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_row
*  ref s_distrib_row arg_str_row[]
*
* Return: long
*
*
* Rowattribute ermitteln und per Referenz zur$$HEX1$$fc00$$ENDHEX$$ck geben
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
long llItem

if not isvalid(uoCartRow[arg_l_row]) then
	llItem = EMPTY
else
	llItem = uoCartRow[arg_l_row].of_get_row(arg_str_item)
end if

return llItem
	

end function

public function long of_set_item (long arg_l_row, s_distrib_items arg_str_item[]);/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_set_item (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_row
*  s_distrib_items arg_s_item[]
*
* Return: long
*
*
* Itemproperties setzen
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llIndex

if not isvalid(uoCartRow[arg_l_row]) then
	llIndex = 0
else
	llIndex = uoCartRow[arg_l_row].of_set_item( arg_str_item)
	if il_Disable_Debug = 0 Then
		f_trace("uo_cart_distrib_cart.of_set_item Row " + String(arg_l_row))
	end if
end if

return llIndex
	

end function

public function long of_combine_item ();/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_combine_item (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 16.11.2009
* Argument(e):
* none
*
* Return: long
*
*
*Gleiche Items zusammenfassen
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  16.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long  llIndex

for llIndex = 1 to upperbound(uoCartRow)
	uoCartRow[llIndex].of_combine_item()
next
	
return 0

end function

public function long of_check_row_limit (long arg_l_row, s_distrib_item_props arg_str_props);/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_check_row_limit (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 18.01.2010
* Argument(e):
* long arg_l_row
*  s_distrib_item_props arg_str_props
*
* Return: long
*
*
* Pr$$HEX1$$fc00$$ENDHEX$$fen ob in dieser Zeile eine feste Anzahl vergeben ist
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  18.01.2010	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/


Long llFreeLength = 0

if not isvalid(uoCartRow[arg_l_row]) or isNull(uoCartRow[arg_l_row]) then
	llFreeLength = NOSPACELEFT
else
	llFreeLength = uoCartRow[arg_l_row].of_check_row_limit(arg_str_props)
end if

return llFreeLength
	

end function

public function long of_check_row_limit (long arg_l_row);/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_check_row_limit (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 18.01.2010
* Argument(e):
* long arg_l_row
*
* Return: long
*
*
* Pr$$HEX1$$fc00$$ENDHEX$$fen ob in dieser Zeile eine feste Anzahl vergeben ist
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  18.01.2010	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/


Long llFreeLength = 0

if not isvalid(uoCartRow[arg_l_row]) or isNull(uoCartRow[arg_l_row]) then
	llFreeLength = NOSPACELEFT
	if il_Disable_Debug = 0 Then
		f_trace("uo_cart_distrib_cart.of_check_row_limit NOSPACELEFT Row " + String(arg_l_row ) )
	End If
else
	llFreeLength = uoCartRow[arg_l_row].of_check_row_limit()
end if

return llFreeLength
	

end function

public function long of_set_length (long arg_l_row, long arg_l_length);/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_add_row (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
*
* Return: long
*
*
* Schiene hinzuf$$HEX1$$fc00$$ENDHEX$$gen und Tiefe setzen
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

Long llIndex

if not isvalid(uoCartRow[arg_l_row]) then
	llIndex = -1
else
	llIndex = uoCartRow[arg_l_row].of_set_length(arg_l_length)
end if

return llIndex
	

end function

public function long of_check_row (long arg_l_row, long arg_l_length);/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_check_row (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
*
* Return: long
*
*
* Pr$$HEX1$$fc00$$ENDHEX$$fen ob die L$$HEX1$$e400$$ENDHEX$$nge in dieser Row noch frei ist
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llFreeLength = 0

if not isvalid(uoCartRow[arg_l_row]) or isNull(uoCartRow[arg_l_row]) then
	llFreeLength = NOSPACELEFT
else
	// 11.01.2010 Ulrich Paudler [UP] erst beim 2. Aufruf wird der Wert *sicher* geladen
	// Keine Ahnung was der PB f$$HEX1$$fc00$$ENDHEX$$r ein Problem hat. 
	llFreeLength = uoCartRow[arg_l_row].of_check_row(arg_l_length)
	llFreeLength = uoCartRow[arg_l_row].of_check_row(arg_l_length)
end if

return llFreeLength
	

end function

public function long of_check_row_item (long arg_l_row, s_distrib_item_props arg_str_props, long al_min_fit_factor);/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_check_row (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
*
* Return: long
*
*
*Pr$$HEX1$$fc00$$ENDHEX$$fen ob das Item an dieser Stelle eingef$$HEX1$$fc00$$ENDHEX$$gt werden darf
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llLength = 0

if not isvalid(uoCartRow[arg_l_row]) or isNull(uoCartRow[arg_l_row]) then
	llLength = NOSPACELEFT
else
	llLength = uoCartRow[arg_l_row].of_check_row_item(arg_str_props, al_min_fit_factor)
end if

return llLength
	

end function

public function long of_get_row_without_sub (long arg_l_row, ref s_distrib_items arg_str_item[]);/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_get_row (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_row
*  ref s_distrib_row arg_str_row[]
*
* Return: long
*
*
* Rowattribute ermitteln und per Referenz zur$$HEX1$$fc00$$ENDHEX$$ck geben
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
long llItem

if not isvalid(uoCartRow[arg_l_row]) then
	llItem = EMPTY
else
	llItem = uoCartRow[arg_l_row].of_get_row_without_sub(arg_str_item)
end if

return llItem
	

end function

public function long of_set_row (long arg_l_row, long arg_l_length, string arg_s_item, long arg_l_show, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text);/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_set_row (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* long arg_l_row
*  long arg_l_length
*  string arg_s_item
*
* Return: long
*
*
*  Einf$$HEX1$$fc00$$ENDHEX$$gen eines Items
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/


Long llIndex

if not isvalid(uoCartRow[arg_l_row]) then
	llIndex = NOSPACELEFT
else
	if il_Disable_Debug= 0 then
		f_trace("uo_cart_distrib_cart.of_set_row uoCartRow["+String(arg_l_row)+"].of_add_row_item arg_l_show=" + String(arg_l_show) +" / "+ as_ssnr + " / " + as_text )			
	End If
	llIndex = uoCartRow[arg_l_row].of_add_row_item(arg_l_length, arg_s_item, arg_l_show, astr_sub, as_ssnr , as_text)
end if

return llIndex
	

end function

public function long of_set_row_item (long arg_l_row, long arg_l_length, string arg_s_item, long arg_l_show, long arg_l_index, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text, boolean ab_bold, string as_code);/*************************************************************
* Objekt : uo_cart_distrib_cart
* Methode: of_set_row_item (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 10.11.2009
* Argument(e):
* long arg_l_row
*  long arg_l_length
*  string arg_s_item
*  long arg_l_show
*  long arg_l_index
*
* Return: long
*
*
* Einf$$HEX1$$fc00$$ENDHEX$$gen eines Items mit Indexwert
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  10.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llIndex

if not isvalid(uoCartRow[arg_l_row]) then
	llIndex = NOSPACELEFT
	
	If il_Disable_Debug = 0 Then
		f_trace("uo_cart_distrib_cart.of_set_row_item not isvalid(uoCartRow[arg_l_row]) " + String(arg_l_row))
	End If
	
else
	if il_Disable_Debug= 0 then
		f_trace("uo_cart_distrib_cart.of_set_row_item " + as_ssnr + " / " + as_text )			
	End If
	llIndex = uoCartRow[arg_l_row].of_set_row_item(arg_l_length, arg_s_item, arg_l_show, arg_l_index, astr_sub , as_ssnr , as_text, ab_bold, as_code )
end if

return llIndex
	

end function

on uo_cart_distrib_cart.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cart_distrib_cart.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;/*************************************************************
* Objekt : uo_cart_distrib_cart
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

for llIndex = 1 to upperbound(uoCartRow)
	if isvalid (uoCartRow[llIndex]) then destroy uoCartRow[llIndex]
next

// Document Engine st$$HEX1$$fc00$$ENDHEX$$rzt bei GarbageCollect() ab
If getApplication().AppName = "cbase" Then GarbageCollect()
//GarbageCollect()


end event

