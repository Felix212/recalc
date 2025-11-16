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

PUBLIC	Boolean	ib_suppress_qty_1 = TRUE

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

public function long of_create_rows (long arg_l_rows);
return 0
	

end function

public function long of_add_row ();
return 1
	

end function

public function long of_set_type (long arg_l_row, long arg_l_type);
return 0
	

end function

public function long of_get_rowcount ();

return ilRows
	

end function

public function long of_set_order (long arg_l_row, long arg_l_order);
return 0
	

end function

public function long of_get_type (long arg_l_row);

return EMPTY
	

end function

public function long of_get_row (long arg_l_row, ref s_distrib_items arg_str_item[]);

return EMPTY
	

end function

public function long of_set_item (long arg_l_row, s_distrib_items arg_str_item[]);

return 0
	

end function

public function long of_combine_item ();
return 0

end function

public function long of_check_row_limit (long arg_l_row, s_distrib_item_props arg_str_props);
return 0
	

end function

public function long of_check_row_limit (long arg_l_row);

return 0
	

end function

public function long of_set_length (long arg_l_row, long arg_l_length);
return -1
	

end function

public function long of_check_row (long arg_l_row, long arg_l_length);
return 0
	

end function

public function long of_check_row_item (long arg_l_row, s_distrib_item_props arg_str_props, long al_min_fit_factor);
return 0
	

end function

public function long of_get_row_without_sub (long arg_l_row, ref s_distrib_items arg_str_item[]);
return EMPTY
	

end function

public function long of_set_row (long arg_l_row, long arg_l_length, string arg_s_item, long arg_l_show, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text);

return NOSPACELEFT
	

end function

public function long of_set_row_item (long arg_l_row, long arg_l_length, string arg_s_item, long arg_l_show, long arg_l_index, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text, boolean ab_bold, string as_code);
return NOSPACELEFT
	

end function

on uo_cart_distrib_cart.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cart_distrib_cart.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

