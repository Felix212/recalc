HA$PBExportHeader$uo_cart_distrib_row.sru
forward
global type uo_cart_distrib_row from nonvisualobject
end type
end forward

global type uo_cart_distrib_row from nonvisualobject
end type
global uo_cart_distrib_row uo_cart_distrib_row

type variables
/*************************************************************
* Objekt : uo_cart_distrib_row
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
*  07.12.2010	1.2           Oliver H$$HEX1$$f600$$ENDHEX$$fer       Drawer Multi Rung
*
*************************************************************/
CONSTANT Long EMPTY					= 0
CONSTANT Long DRAWER					= 1
CONSTANT Long TRAY					= 2
CONSTANT Long DRAWERFOOD			= 3
CONSTANT Long TRAYNONFOOD			= 4
CONSTANT Long BLOCKED				= 9
CONSTANT Long DRAWER_MULTI_RUNG	= 13
CONSTANT Long NOSPACELEFT			= -9999999


private:
				Long		il_Length
				Long		ilOrder
				Long		ilType

Public		n_doc_gen_settings	inv_doc_gen_settings
Protected	s_distrib_items		istr_item[]
Public		Long		il_Disable_Debug = 1 //0
Public		Boolean	ib_use_doc_gen_settings
Public		String	is_user
Public		String	is_section = ""
Protected	String	isCartDiagramComponentDisplay = ""
PUBLIC		Boolean	ib_suppress_qty_1 = TRUE

end variables

forward prototypes
public function long of_get_order ()
public function long of_set_order (long arg_l_order)
public function long of_set_type (long arg_l_type)
public function string of_get_row_item ()
public function long of_get_type ()
public function long of_get_row (ref s_distrib_items ref_str_item[])
public function long of_set_item (s_distrib_items arg_str_item[])
public function long of_combine_item ()
public function long of_get_limit ()
public function long of_check_row_limit (s_distrib_item_props arg_str_props)
public function long of_check_row_limit ()
public function long of_get_count_limit ()
public function long of_set_length (long arg_l_length)
public function long of_get_length ()
public function long of_get_reserved_length ()
public function long of_get_unused_length ()
public function long of_check_row (long arg_l_length)
public function long of_check_row_item (s_distrib_item_props arg_str_props, long al_min_fit_factor)
public function integer of_compress ()
public function string of_profilestring (string suser, string ssection, string skey, string sdefault)
public function string of_get_item_description (s_component arg_str_component)
public function integer of_include_subitems (ref s_distrib_items rastr_items[])
public function long of_add_row_item (long arg_l_length, string arg_s_item, long arg_l_show, s_distrib_item_sub astr_sub[])
public function long of_get_row_without_sub (ref s_distrib_items ref_str_item[])
public function long of_add_row_item (long arg_l_length, string arg_s_item, long arg_l_show, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text)
public function long of_set_row_item (long arg_l_length, string arg_s_item, long arg_l_show, long arg_l_index, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text, boolean ab_bold, string as_code)
public function integer of_extend_array ()
end prototypes

public function long of_get_order ();


return ilOrder
	


end function

public function long of_set_order (long arg_l_order);

return 0
	


end function

public function long of_set_type (long arg_l_type);
return EMPTY
	


end function

public function string of_get_row_item ();

Return  ""
	


end function

public function long of_get_type ();/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_get_type (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
*
* Return: long
*
*
* Typ des Einschubs in dieser Row zur$$HEX1$$fc00$$ENDHEX$$ckgeben
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

return ilType
	


end function

public function long of_get_row (ref s_distrib_items ref_str_item[]);
Return  0
	


end function

public function long of_set_item (s_distrib_items arg_str_item[]);

return 0
	


end function

public function long of_combine_item ();
return 0
	


end function

public function long of_get_limit ();


return 0
	


end function

public function long of_check_row_limit (s_distrib_item_props arg_str_props);
 return 0
	


end function

public function long of_check_row_limit ();
 return 0
	


end function

public function long of_get_count_limit ();

return 0
	


end function

public function long of_set_length (long arg_l_length);

return 0
	


end function

public function long of_get_length ();
return il_Length
	


end function

public function long of_get_reserved_length ();
return 0
	


end function

public function long of_get_unused_length ();

Return 0 
	


end function

public function long of_check_row (long arg_l_length);

return 0
	


end function

public function long of_check_row_item (s_distrib_item_props arg_str_props, long al_min_fit_factor);

Return 0

end function

public function integer of_compress ();

Return 1

end function

public function string of_profilestring (string suser, string ssection, string skey, string sdefault);

return " "
end function

public function string of_get_item_description (s_component arg_str_component);

Return " "

end function

public function integer of_include_subitems (ref s_distrib_items rastr_items[]);
Return 1

end function

public function long of_add_row_item (long arg_l_length, string arg_s_item, long arg_l_show, s_distrib_item_sub astr_sub[]);
Return 0



end function

public function long of_get_row_without_sub (ref s_distrib_items ref_str_item[]);
Return  0

end function

public function long of_add_row_item (long arg_l_length, string arg_s_item, long arg_l_show, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text);
Return 0
	


end function

public function long of_set_row_item (long arg_l_length, string arg_s_item, long arg_l_show, long arg_l_index, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text, boolean ab_bold, string as_code);
Return NOSPACELEFT
	


end function

public function integer of_extend_array ();
return 1
end function

on uo_cart_distrib_row.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cart_distrib_row.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: constructor (Event)
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

 il_Length 	= 0

end event

