HA$PBExportHeader$uo_tr_cart_allocation.sru
$PBExportComments$TR Cart Bef$$HEX1$$fc00$$ENDHEX$$llung
forward
global type uo_tr_cart_allocation from nonvisualobject
end type
end forward

global type uo_tr_cart_allocation from nonvisualobject
end type
global uo_tr_cart_allocation uo_tr_cart_allocation

type variables


uo_cart_datastore ids_TR_Cart_Allocation


CONSTANT	INTEGER	CONTENT_EMPTY		= 0
CONSTANT	INTEGER	CONTENT_FULL		= 1

CONSTANT	INTEGER	FILL_TOP_DOWN		= 0
CONSTANT	INTEGER	FILL_FROM_BOTTOM	= 1
/*
Top Down means: Fill the fist column of the cart starting from top with the lowest stowage position,
When first column is filled, start filling the second column (top-down).
If the TR-Cart is full but more drawers are left, a second TR-Cart has to be generated.
If the check box Top Down is not checked it should start to fill the transporter cart from bottom to the
top
*/

Protected:
Integer		ii_Number_of_Pages
Integer		ii_Number_Of_Columns
Integer		ii_Number_of_Rungs

Long			il_Cart_Counter	= 0 
Long			il_Page_Counter	= 0 

Public Long	il_Disable_Debug = 1 //0
end variables

forward prototypes
public function integer of_init (integer ai_pages, integer ai_columns, integer ai_rows)
public function integer of_add_cart (integer ai_pages, integer ai_columns, integer ai_rows)
public function long of_get_page_count ()
public function integer of_set_tr_cart_size (integer ai_pages, integer ai_columns, integer ai_rungs)
public function long of_get_cart_number (long al_row)
public function integer of_add_content (long al_index_key, long al_detail_key, integer ai_fill_order, boolean ab_force_new_cart, long al_source_row)
public function integer of_fit_into_cart (integer ai_content_height, integer ai_fill_order, long al_content)
public function integer of_get_content_position (long al_row, ref long ral_page, ref long ral_cart_number, ref long ral_column, ref long ral_rung)
public function boolean of_exists_cart_key (long al_tr_cart_key)
public function long of_get_tr_cart_key (string as_unit, long al_index_key, date adt_ref_date)
public function integer of_set_extended_tr_handling (boolean ab_switch, date adt_departure, string as_unit)
end prototypes

public function integer of_init (integer ai_pages, integer ai_columns, integer ai_rows);
Return 1
end function

public function integer of_add_cart (integer ai_pages, integer ai_columns, integer ai_rows);
Return 1
end function

public function long of_get_page_count ();/*
* Objekt : uo_tr_cart_allocation
* Methode: of_get_page_count (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 11.08.2010
*
* Argument(e):
* none
*
* Beschreibung:		Z$$HEX1$$e400$$ENDHEX$$hle Diagrammseiten
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	11.08.2010		Erstellung
*
*
* Return: long
*
*/

Return 1

end function

public function integer of_set_tr_cart_size (integer ai_pages, integer ai_columns, integer ai_rungs);
Return 1
end function

public function long of_get_cart_number (long al_row);

Long		ll_Cart_Number

Return ll_Cart_Number
end function

public function integer of_add_content (long al_index_key, long al_detail_key, integer ai_fill_order, boolean ab_force_new_cart, long al_source_row);
return 1

end function

public function integer of_fit_into_cart (integer ai_content_height, integer ai_fill_order, long al_content);
Return 1

end function

public function integer of_get_content_position (long al_row, ref long ral_page, ref long ral_cart_number, ref long ral_column, ref long ral_rung);

Return 1
end function

public function boolean of_exists_cart_key (long al_tr_cart_key);
Return true
end function

public function long of_get_tr_cart_key (string as_unit, long al_index_key, date adt_ref_date);
Return 1
end function

public function integer of_set_extended_tr_handling (boolean ab_switch, date adt_departure, string as_unit);
Return 1
end function

event destructor;/*
* Objekt : uo_tr_cart_allocation
* Methode: destructor (Event)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 11.08.2010
*
* Argument(e):
* none
*
* Beschreibung:		Aufr$$HEX1$$e400$$ENDHEX$$umen
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	11.08.2010		Erstellung
*
*
* Return: long
*
*/

DESTROY  ids_TR_Cart_Allocation
end event

event constructor;/*
* Objekt : uo_tr_cart_allocation
* Methode: constructor (Event)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 11.08.2010
*
* Argument(e):
* none
*
* Beschreibung:		Initialisierung
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	11.08.2010		Erstellung
*
*
* Return: long
*
*/


ids_TR_Cart_Allocation = CREATE uo_cart_datastore 
ids_TR_Cart_Allocation.DataObject = "dw_uo_tr_cart_allocate"



end event

on uo_tr_cart_allocation.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_tr_cart_allocation.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

