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

public function integer of_create_cart (long arg_l_columns, long arg_l_rows);

return 1
end function

public function integer of_init_cart (long arg_l_rows);
return 0
	
end function

public function long of_set_type (long arg_l_column, long arg_l_row, long arg_l_type);
return EMPTY
	
end function

public function long of_set_order (long arg_l_column, long arg_l_row, long arg_l_order);
return -1
	
end function

public function integer of_init_allocate (long arg_l_columns, long arg_l_rows);
return 0
	
end function

public function long of_set_allocation_mode (long arg_l_mode);
return 0

end function

public function long of_get_type (long arg_l_column, long arg_l_row);
return EMPTY
	
end function

public function long of_get_row (long arg_l_column, long arg_l_row, ref s_distrib_items arg_str_item[]);
return 0
	
end function

public function long of_set_item (long arg_l_column, long arg_l_row, s_distrib_items arg_str_item[]);
return 0
	
end function

public function string of_get_item_description (s_component arg_str_component);

Return " "

end function

public function string of_profilestring (string suser, string ssection, string skey, string sdefault);
return " "
end function

public function long of_combine_item ();
return 0
end function

public function long of_check_row_limit (long arg_l_column, long arg_l_row, s_distrib_item_props arg_str_props);
return NOSPACELEFT
	
end function

public function long of_check_row_limit (long arg_l_column, long arg_l_row);
return NOSPACELEFT
	
end function

public function long of_set_length (long arg_l_column, long arg_l_row, long arg_l_length);
return -1
	
end function

public function long of_get_cart_dimension (string arg_s_type, long arg_l_airline, long arg_l_indexkey, long arg_l_detailkey, ref long ref_l_columns, ref long ref_l_rows, ref long ref_l_length);
return 0

end function

public function long of_check_row (long arg_l_column, long arg_l_row, long arg_l_length);

return NOSPACELEFT
	
end function

public function long of_check_row_item (long arg_l_column, long arg_l_row, long arg_l_length, s_distrib_item_props arg_str_props, long al_min_fit_factor);
return NOSPACELEFT
	
end function

public function long of_get_row_without_sub (long arg_l_column, long arg_l_row, ref s_distrib_items arg_str_item[]);

return 0
	
end function

public function long of_set_row (long arg_l_column, long arg_l_row, long arg_l_length, string arg_s_item, long arg_l_print_column, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text);
return 0
	
end function

public function long of_allocate_w_split (s_component arg_str_component, ref long ref_l_column, ref long ref_l_row, long al_min_fit_factor, s_distrib_item_sub astr_sub[], uo_cart_diagram rauo_cart_diagram, long al_qty);
Return -1

end function

public function long of_set_alloc_props (long arg_l_column, long arg_l_row, integer arg_l_order, s_distrib_items arg_str_item[]);

Return 1

	
end function

public subroutine of_save_idsallocateprops (string as_name);
// Debug
//idsAllocateProps.saveas("c:\temp\cbase\idsAllocateProps_"+ as_Name + "_" + String(datetime(today(),now()), "yyyymmddhhmmssfff") + ".xls",excel5!,true)

end subroutine

public function long of_set_row_item (long arg_l_column, long arg_l_row, long arg_l_length, string arg_s_item, long arg_l_print_column, long arg_l_index, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text, boolean ab_bold, string as_code);

return 0
	
end function

on uo_cart_distribution.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cart_distribution.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;
DESTROY	idsAllocate

DESTROY	idsAllocateProps


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

