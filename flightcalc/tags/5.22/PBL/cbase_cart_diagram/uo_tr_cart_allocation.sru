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
Integer		ii_Number_of_Columns
Integer		ii_Number_of_Rungs

Long			il_Cart_Counter	= 0 
Long			il_Page_Counter	= 0 

String		is_TR_Name

Public Long	il_Disable_Debug = 1 //0

// CBASE-UK-CR-2013-002
Boolean		ib_Extended_TR_Handling = FALSE
Date			idt_Ref_Date = Today()
String		is_Unit


end variables
forward prototypes
public function integer of_init (integer ai_pages, integer ai_columns, integer ai_rows)
public function long of_get_page_count ()
public function integer of_set_tr_cart_size (integer ai_pages, integer ai_columns, integer ai_rungs)
public function long of_get_cart_number (long al_row)
public function integer of_get_content_position (long al_row, ref long ral_page, ref long ral_cart_number, ref long ral_column, ref long ral_rung)
public function long of_get_tr_cart_key (string as_unit, long al_index_key, date adt_ref_date)
public function integer of_set_extended_tr_handling (boolean ab_switch, date adt_departure, string as_unit)
public function boolean of_exists_cart_key (long al_tr_cart_key)
public function integer of_fit_into_cart (integer ai_content_height, integer ai_fill_order, long al_content, long al_tr_cart_key, long al_galley_group)
public function integer of_add_content (long al_index_key, long al_detail_key, integer ai_fill_order, boolean ab_force_new_cart, long al_source_row, long al_galley_group)
public function integer of_add_cart (integer ai_pages, integer ai_columns, integer ai_rows, long al_tr_cart_key, long al_galley_group)
end prototypes

public function integer of_init (integer ai_pages, integer ai_columns, integer ai_rows);/*
* Objekt : uo_tr_cart_allocation
* Methode: of_init (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 03.09.2012
*
* Argument(e):
*	 integer ai_pages
*	 integer ai_columns
*	 integer ai_rows
*
* Beschreibung:		Initialisiere DataStore ids_TR_Cart_Allocation
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	03.09.2012		Erstkommentar
*
*
* Return: integer
*
*/


Long		ll_Count_P
Long		ll_Count_C
Long		ll_Count_R
Long		ll_New_Row
Integer	li_Succ


ii_Number_of_Pages		= ai_Pages
ii_Number_of_Columns		= ai_columns
ii_Number_of_Rungs		= ai_rows	

// c r o p c

ids_TR_Cart_Allocation.Reset()

For ll_Count_P = 1 To ai_Pages  
	For ll_Count_C = 1 To ai_Columns
		For ll_Count_R = 1 To ai_rows  
			ll_New_Row = ids_TR_Cart_Allocation.InsertRow(0)
			li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "ncolumn",		ll_Count_C )
			li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "nrow",			ll_Count_R )
			li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "norder",			ll_New_Row )
			li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "npage",			ll_Count_P )
			li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "ncontents",		0 )
			li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "ntrcart",		1 )
		Next
	Next
Next


//ncolumn
//nrow
//norder 
//npage 
//ncontents 

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


Long		ll_Page_Counter
Long		ll_Count
String	ls_Group_Crit
String	ls_Group


ls_Group_Crit = ""
For ll_Count = 1 To ids_TR_Cart_Allocation.RowCount()
	ls_Group = ids_TR_Cart_Allocation.GetItemString(ll_Count, "cart_page_unique")
	If ls_Group <> ls_Group_Crit Then
		ls_Group_Crit = ls_Group
		ll_Page_Counter++
	End If
	
Next


Return ll_Page_Counter

end function

public function integer of_set_tr_cart_size (integer ai_pages, integer ai_columns, integer ai_rungs);/*
* Objekt : uo_tr_cart_allocation
* Methode: of_set_tr_cart_size (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 11.08.2010
*
* Argument(e):
*	 integer ai_pages
*	 integer ai_rungs
*	 integer ai_columns
*
* Beschreibung:		Festlegen der Abmessungen des zu verwendenden TR Catr Typs
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	11.08.2010		Erstellung
*
*
* Return: integer
*
*/


Integer	li_Succ

ii_Number_of_Pages		= ai_pages
ii_Number_Of_Columns		= ai_columns
ii_Number_of_Rungs		= ai_rungs

Return li_Succ
end function

public function long of_get_cart_number (long al_row);/*
* Objekt : uo_tr_cart_allocation
* Methode: of_get_cart_number (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 03.09.2012
*
* Argument(e):
* long al_row
*
* Beschreibung:		Lese Cart Number
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	03.09.2012		Erstellung
*
*
* Return: long
*
*/

Long		ll_Cart_Number
String	ls_Find	
Long		ll_Found


ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())

If ll_Found > 0 Then
	ll_Cart_Number = ids_tr_cart_allocation.GetItemNumber(ll_Found, "ncontents")
End If

Return ll_Cart_Number
end function

public function integer of_get_content_position (long al_row, ref long ral_page, ref long ral_cart_number, ref long ral_column, ref long ral_rung);/*
* Objekt : uo_tr_cart_allocation
* Methode: of_get_content_position (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 11.08.2010
*
* Argument(e):
* long al_row
*	 ref long ral_page
*	 ref long ral_cart_number
*	 ref long ral_column
*	 ref long ral_rung
*
* Beschreibung:		Wohin wird der Inhalt abgelegt
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	11.08.2010		Erstellung
*
*
* Return: integer
*
*/

Integer	li_Succ
String	ls_Find
Long		ll_Found


ls_Find = "ncontents=" + String(al_Row)
ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
If ll_Found > 0 Then
	//ral_page				= ids_tr_cart_allocation.GetItemNumber(ll_Found, "npage")
	ral_cart_number	= ids_tr_cart_allocation.GetItemNumber(ll_Found, "ntrcart")
	ral_column			= ids_tr_cart_allocation.GetItemNumber(ll_Found, "ncolumn")
	ral_rung				= ids_tr_cart_allocation.GetItemNumber(ll_Found, "nrow")
	ral_page				= ids_tr_cart_allocation.GetItemNumber(ll_Found, "nprintpage")
	li_Succ = 1
Else
ral_cart_number		= 0
	ral_column			= 0
	ral_rung				= 0
	ral_page				= 0
	li_Succ = -1
End If

//ncolumn
//nrow
//norder 
//npage 
//ncontents 

Return li_Succ
end function

public function long of_get_tr_cart_key (string as_unit, long al_index_key, date adt_ref_date);/*
* Methode: of_get_tr_cart_key (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 28.02.2014
*
* Argument(e):
*	 string as_unit
*	 long al_index_key
*	 date adt_ref_date
*	 ref integer rai_number_of_rungs
*	 ref integer rai_number_of_columns
*	 ref integer rai_number_of_pages			=> "2": add Page for Double Carts (Front-Rear x Left-Right x Height)
*
* Beschreibung:				Ermittle TR Cart f$$HEX1$$fc00$$ENDHEX$$r Betrieb, St$$HEX1$$fc00$$ENDHEX$$ckliste, Datum (via Workstation)
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	28.02.2014		Erstellung
*
*
* Return: long
*
*/


Long			ll_Rows
Long			ll_Return = -1
DataStore	lds_Allocated_TR


lds_Allocated_TR = CREATE DataStore
lds_Allocated_TR.DataObject = "dw_loc_unit_tr_cart_per_pl"
lds_Allocated_TR.SetTransObject(SQLCA)

ll_Rows = lds_Allocated_TR.Retrieve(as_Unit, al_Index_Key, adt_Ref_Date)

If ll_Rows > 0 Then
	ll_Return = lds_Allocated_TR.GetItemNumber(1, "ntr_cart_key")
	
	ii_Number_of_Rungs = lds_Allocated_TR.GetItemNumber(1, "nrungs")
	ii_Number_of_Columns = lds_Allocated_TR.GetItemNumber(1, "ncolumns")
	If lds_Allocated_TR.GetItemNumber(1, "nmultiply") = 2 Then
		ii_Number_of_Pages = 2
	Else
		ii_Number_of_Pages = 1
	End If
	
	
//	is_TR_Area		= lds_Allocated_TR.GetItemString(1, "carea")
//	is_TR_WS			= lds_Allocated_TR.GetItemString(1, "loc_unit_workstation_ctext")
//	is_TR_Freetext	= lds_Allocated_TR.GetItemString(1, "ccomment")
	
	is_TR_Name = lds_Allocated_TR.GetItemString(1, "cname")
//	is_TR_Cart_Area_WS = is_TR_Area + "-" + is_TR_WS
	
End If


DESTROY	lds_Allocated_TR


Return ll_Return

///*
//* Objekt : uo_tr_cart_allocation
//* Methode: of_get_tr_cart_key (Function)
//* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
//* Datum  : 28.02.2014
//*
//* Argument(e):
//*	 string as_unit
//*	 long al_index_key
//*	 date adt_ref_date
//*
//* Beschreibung:				Ermittle TR Cart f$$HEX1$$fc00$$ENDHEX$$r Betrieb, St$$HEX1$$fc00$$ENDHEX$$ckliste, Datum (via Workstation)
//*
//* Aenderungshistorie:
//* Version 		Wer			Wann			Was und warum
//* 1.0 			O.Hoefer	28.02.2014		Erstellung
//*
//*
//* Return: long
//*
//*/
//
//
//Long			ll_Rows
//Long			ll_Return = -1
//DataStore	lds_Allocated_TR
//
//
//lds_Allocated_TR = CREATE DataStore
//lds_Allocated_TR.DataObject = "dw_loc_unit_tr_cart_per_pl"
//lds_Allocated_TR.SetTransObject(SQLCA)
//
//ll_Rows = lds_Allocated_TR.Retrieve(as_Unit, al_Index_Key, adt_Ref_Date)
//
//If ll_Rows > 0 Then
//	ll_Return = lds_Allocated_TR.GetItemNumber(1, "ntr_cart_key")
//	
//	//ii_Number_of_Pages, ii_Number_Of_Columns, ii_Number_of_Rungs,
//	ii_Number_of_Rungs = lds_Allocated_TR.GetItemNumber(1, "nrungs")
//	ii_Number_Of_Columns = lds_Allocated_TR.GetItemNumber(1, "ncolumns")
//	If lds_Allocated_TR.GetItemNumber(1, "nmultiply") = 2 Then
//		ii_Number_of_Pages = 2
//	Else
//		ii_Number_of_Pages = 1
//	End If
//	is_TR_Name = lds_Allocated_TR.GetItemString(1, "cname")
//End If
//
//
//DESTROY	lds_Allocated_TR
//
//
//Return ll_Return
end function

public function integer of_set_extended_tr_handling (boolean ab_switch, date adt_departure, string as_unit);/*
* Objekt : uo_tr_cart_allocation
* Methode: of_set_extended_tr_handling (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 27.02.2014
*
* Argument(e):
* boolean ab_switch
*
* Beschreibung:		Switch to enable different TR Types within one flight
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	27.02.2014		Erstellung
*
*
* Return: integer
*
*/


ib_Extended_TR_Handling = ab_Switch
is_Unit = as_unit
idt_ref_date = adt_departure

return 1
end function

public function boolean of_exists_cart_key (long al_tr_cart_key);


//			li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "ntr_type",	al_TR_Cart_Key )	



String ls_Find
long	ll_Found


ls_Find = "ntr_type=" + String(al_TR_Cart_Key)

ll_Found = 	ids_TR_Cart_Allocation.Find(ls_Find , 1, ids_TR_Cart_Allocation.RowCount())	

If ll_Found < 1 Then
	return FALSE
Else
	return TRUE
End If
end function

public function integer of_fit_into_cart (integer ai_content_height, integer ai_fill_order, long al_content, long al_tr_cart_key, long al_galley_group);/*
* Objekt : uo_tr_cart_allocation
* Methode: of_fit_into_cart (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 26.04.2011
*
* Argument(e):
* integer ai_content_height
*	 integer ai_fill_order
*	 long al_content
*
* Beschreibung:		Freier Platz f$$HEX1$$fc00$$ENDHEX$$r TR Carts
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	26.04.2011		Erstkommentar: variable Belegung bei 3 und mehr H$$HEX1$$f600$$ENDHEX$$heneinheiten
* 1.1 			O.Hoefer	03.03.2014		Hinzu: Option verschiedene TR Typen
*
*
* Return: integer
*
*/


Integer	li_Succ
Long		ll_Found
Long		ll_Free_Rungs[]
String	ls_Find
Integer	li_Page
Integer	li_Column
Integer	li_Row
Long		ll_Count
Boolean	lb_Valid_Rungs

//ncolumn
//nrow
//norder
//npage
//ncontents
//ntrcart
//cinfo

ids_tr_cart_allocation.Sort()

If IsNULL(al_galley_group ) Then
	al_galley_group =  0 
End If

//Wenn H$$HEX1$$f600$$ENDHEX$$he = 1 dann suche n$$HEX1$$e400$$ENDHEX$$chsten freien Einschub
If ai_content_height = 1 Then
	ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0"
	
	If ib_Extended_tr_handling Then
		ls_Find += " AND ntr_type=" + String(al_tr_cart_key)
	End If
	If ib_Extended_tr_handling Then
		ls_Find += " AND ngalley_group=" + String(al_galley_group)
	End If
	
	
	ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
	If ll_Found > 0 Then
		li_Page		= ids_tr_cart_allocation.GetItemNumber(ll_Found, "npage")
		li_Column	= ids_tr_cart_allocation.GetItemNumber(ll_Found, "ncolumn")
		Do While ll_Found > 0
			ll_Free_Rungs[Upperbound(ll_Free_Rungs) + 1] = 	 ids_tr_cart_allocation.GetItemNumber(ll_Found, "nrow")
			ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) + " and ncolumn=" + String(li_Column)
			ll_Found = ids_tr_cart_allocation.Find(ls_Find, ll_Found + 1, ids_tr_cart_allocation.RowCount() + 1)
		Loop
		
		If Upperbound(ll_Free_Rungs) > 0 Then
			If ai_fill_order = FILL_TOP_DOWN Then
				// Top Down: kleinste Rung Number wird belegt
				li_Row = ll_Free_Rungs[1]
				ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
				ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
				ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
				If ll_Found > 0 Then
					li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", al_content )
					li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "FILL")				
					li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ngalley_group", al_galley_group)									
				End If
			ElseIf ai_fill_order = FILL_FROM_BOTTOM Then
				// Top Down: h$$HEX1$$f600$$ENDHEX$$chste Rung Number wird belegt
				li_Row = ll_Free_Rungs[Upperbound(ll_Free_Rungs)]
				ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
				ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
				ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
				If ll_Found > 0 Then
					li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", al_content )
					li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "FILL")				
					li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ngalley_group", al_galley_group)														
				End If
			End If
		
		End If
		
	Else
		// Nichts frei => neuer Cart
		
		li_Succ = of_add_cart(ii_Number_of_Pages, ii_Number_Of_Columns, ii_Number_of_Rungs, al_tr_cart_key , al_galley_group)
		Return of_fit_into_cart( ai_content_height, ai_fill_order, al_content, al_tr_cart_key, al_galley_group )	
	End If
	
ElseIf ai_content_height = 2 Then
	// -----------------------------------------------------------------------
	// Ben$$HEX1$$f600$$ENDHEX$$tige 2 H$$HEX1$$f600$$ENDHEX$$heneinheiten
	// -----------------------------------------------------------------------
	ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0"
	
	If ib_Extended_tr_handling Then
		ls_Find += " AND ntr_type=" + String(al_tr_cart_key)
	End If
	If ib_Extended_tr_handling Then
		ls_Find += " AND ngalley_group=" + String(al_galley_group)
	End If
	
	ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
	If ll_Found > 0 Then
		li_Page		= ids_tr_cart_allocation.GetItemNumber(ll_Found, "npage")
		li_Column	= ids_tr_cart_allocation.GetItemNumber(ll_Found, "ncolumn")
		Do While ll_Found > 0
			ll_Free_Rungs[Upperbound(ll_Free_Rungs) + 1] = 	 ids_tr_cart_allocation.GetItemNumber(ll_Found, "nrow")
			ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) + " and ncolumn=" + String(li_Column)
			ll_Found = ids_tr_cart_allocation.Find(ls_Find, ll_Found + 1, ids_tr_cart_allocation.RowCount() + 1)
		Loop
		
		If Upperbound(ll_Free_Rungs) > 1 Then
			//Mindestens 2 aufeinanderfolgende
			If ai_fill_order = FILL_TOP_DOWN Then
				// Top Down: kleinste freie Rung Number wird belegt
				If ll_Free_Rungs[1] + 1 = ll_Free_Rungs[2] Then
					li_Row = ll_Free_Rungs[1]
					ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
					ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
					ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
					If ll_Found > 0 Then
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", -1 )
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "DOUBLE " + String(ll_Free_Rungs[2]))		
					End If
					li_Row = ll_Free_Rungs[2]
					ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
					ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
					ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
					If ll_Found > 0 Then
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", al_content )
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "FILL")				
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ngalley_group", al_galley_group)																				
					End If
				End If
			ElseIf ai_fill_order = FILL_FROM_BOTTOM Then
				// Top Down: h$$HEX1$$f600$$ENDHEX$$chste und zweith$$HEX1$$f600$$ENDHEX$$chste Rung Number wird belegt
				If ll_Free_Rungs[Upperbound(ll_Free_Rungs)] - 1 = ll_Free_Rungs[Upperbound(ll_Free_Rungs) - 1] Then
					
					li_Row = ll_Free_Rungs[Upperbound(ll_Free_Rungs) - 1]
					ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
					ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
					ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
					If ll_Found > 0 Then
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", -1 )
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "DOUBLE " + String(ll_Free_Rungs[Upperbound(ll_Free_Rungs)]))				
					End If
					li_Row = ll_Free_Rungs[Upperbound(ll_Free_Rungs)]
					ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
					ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
					ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
					If ll_Found > 0 Then
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", al_content )
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "FILL")				
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ngalley_group", al_galley_group)																				
					End If
					
				End If	
					
			End If
		Else
			// Keine 2 freien Rungs => freien Einschub blocken, => n$$HEX1$$e400$$ENDHEX$$chster Versuch
			If Upperbound(ll_Free_Rungs) = 1 Then
				// Es gibt 1 Einschub, der nicht ausreicht => belegen mit DUMMY
				li_Row = ll_Free_Rungs[1]
				ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
				ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
				ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
				If ll_Found > 0 Then
					li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", -1 )
					li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "DUMMY")				
				End If
				Return of_fit_into_cart( ai_content_height, ai_fill_order, al_content, al_tr_cart_key, al_galley_group )	
				
			End If
			
		
		End If
		
	Else
		// Nichts frei => neuer Cart
		li_Succ = of_add_cart(ii_Number_of_Pages, ii_Number_Of_Columns, ii_Number_of_Rungs, al_tr_cart_key ,al_galley_group)
		Return of_fit_into_cart( ai_content_height, ai_fill_order, al_content, al_tr_cart_key, al_galley_group )	
	End If
	
ElseIf ai_content_height > 2 Then
	// -----------------------------------------------------------------------
	// Ben$$HEX1$$f600$$ENDHEX$$tige mind. 3 H$$HEX1$$f600$$ENDHEX$$heneinheiten 
	// -----------------------------------------------------------------------
	ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0"
	
	If ib_Extended_tr_handling Then
		ls_Find += " AND ntr_type=" + String(al_tr_cart_key)
	End If
	If ib_Extended_tr_handling Then
		ls_Find += " AND ngalley_group=" + String(al_galley_group)
	End If
	
	ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
	If ll_Found > 0 Then
		li_Page		= ids_tr_cart_allocation.GetItemNumber(ll_Found, "npage")
		li_Column	= ids_tr_cart_allocation.GetItemNumber(ll_Found, "ncolumn")
		Do While ll_Found > 0
			ll_Free_Rungs[Upperbound(ll_Free_Rungs) + 1] = 	 ids_tr_cart_allocation.GetItemNumber(ll_Found, "nrow")
			ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) + " and ncolumn=" + String(li_Column)
			ll_Found = ids_tr_cart_allocation.Find(ls_Find, ll_Found + 1, ids_tr_cart_allocation.RowCount() + 1)
		Loop
		
		If Upperbound(ll_Free_Rungs) >= ai_content_height Then
			//Mindestens ai_content_height aufeinanderfolgende
			If ai_fill_order = FILL_TOP_DOWN Then
				// Top Down: kleinste freie Rung Number wird belegt
				lb_Valid_Rungs = TRUE
				For ll_Count = 1 To ai_content_height - 1
					If NOT (ll_Free_Rungs[1] + ll_Count = ll_Free_Rungs[1 + ll_Count] )Then
						 lb_Valid_Rungs = FALSE
					End If
				Next
				
				//If ll_Free_Rungs[1] + 1 = ll_Free_Rungs[2] AND ll_Free_Rungs[1] + 2 = ll_Free_Rungs[3] Then
				If lb_Valid_Rungs Then
					For ll_Count = 1 To ai_content_height - 1
						li_Row = ll_Free_Rungs[ll_Count]
						ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
						ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
						ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
						If ll_Found > 0 Then
							li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", -1 )
							li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "DOUBLE " + String(ll_Free_Rungs[ai_content_height]))		
							If il_Disable_Debug = 0 Then
								f_trace("uo_tr_cart_allocation.of_fit_into_cart height=3 DOUBLE " + String(li_Row))
							End If
						End If
					Next

					li_Row = ll_Free_Rungs[ai_content_height]
					ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
					ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
					ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
					If ll_Found > 0 Then
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", al_content )
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "FILL")	 //"cinfo", "DOUBLE " + String(ll_Free_Rungs[3]))			
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ngalley_group", al_galley_group)														
						
						If il_Disable_Debug = 0 Then
							f_trace("uo_tr_cart_allocation.of_fit_into_cart height=3 " + String(ll_Free_Rungs[ai_content_height]))
						End If
						
					End If
				End If
				
			ElseIf ai_fill_order = FILL_FROM_BOTTOM Then
				// Top Down: h$$HEX1$$f600$$ENDHEX$$chste und zweith$$HEX1$$f600$$ENDHEX$$chste Rung Number wird belegt
				lb_Valid_Rungs = TRUE
				For ll_Count = (Upperbound(ll_Free_Rungs) - ai_content_height) + 1 To Upperbound(ll_Free_Rungs)
//					If NOT (ll_Free_Rungs[1] + ll_Count = ll_Free_Rungs[1 + ll_Count])
					If NOT (ll_Free_Rungs[ll_Count] + 1 = ll_Free_Rungs[ll_Count + 1]) Then 
						lb_Valid_Rungs = FALSE
					End If
				Next

//				If ll_Free_Rungs[Upperbound(ll_Free_Rungs)] - 1 = ll_Free_Rungs[Upperbound(ll_Free_Rungs) - 1] AND &
//					ll_Free_Rungs[Upperbound(ll_Free_Rungs)] - 2 = ll_Free_Rungs[Upperbound(ll_Free_Rungs) - 2]Then
				If lb_Valid_Rungs Then
					// Rungs
					
					For ll_Count = 1 To ai_content_height - 1
					
						li_Row = ll_Free_Rungs[Upperbound(ll_Free_Rungs) - ll_Count]
						ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
						ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
						ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
						If ll_Found > 0 Then
							li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", -1 )
							li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "DOUBLE " + String(ll_Free_Rungs[Upperbound(ll_Free_Rungs)]))
							
							If il_Disable_Debug = 0 Then
								f_trace("uo_tr_cart_allocation.of_fit_into_cart height=3 DOUBLE " + String(li_Row))
							End If
							
						End If
					
					Next
				
//					li_Row = ll_Free_Rungs[Upperbound(ll_Free_Rungs) - 1]
//					ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
//					ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
//					ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
//					If ll_Found > 0 Then
//						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", -1 )
//						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "DOUBLE " + String(ll_Free_Rungs[Upperbound(ll_Free_Rungs)]))				
//						
//						If il_Disable_Debug = 0 Then
//							f_trace("uo_tr_cart_allocation.of_fit_into_cart height=3 DOUBLE " + String(li_Row))
//						End If
//						
//					End If
					
					li_Row = ll_Free_Rungs[Upperbound(ll_Free_Rungs)]
					ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
					ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
					ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
					If ll_Found > 0 Then
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", al_content )
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "FILL")
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ngalley_group", al_galley_group)														
						
						If il_Disable_Debug = 0 Then
							f_trace("uo_tr_cart_allocation.of_fit_into_cart height=3 " + String(ll_Free_Rungs[Upperbound(ll_Free_Rungs)]))
						End If

					End If
					
				End If	
					
			End If
		Else
			// Keine 3 freien Rungs => freien Einschub blocken, => n$$HEX1$$e400$$ENDHEX$$chster Versuch
			If Upperbound(ll_Free_Rungs) < 3 Then
				// Es gibt 1 Einschub, der nicht ausreicht => belegen mit DUMMY
				li_Row = ll_Free_Rungs[1]
				ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
				ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
				ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
				If ll_Found > 0 Then
					li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", -1 )
					li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "DUMMY")				
				End If
				Return of_fit_into_cart( ai_content_height, ai_fill_order, al_content, al_tr_cart_key, al_galley_group )	
				
			End If			
		
		End If
		
	Else
		// Nichts frei => neuer Cart
		li_Succ = of_add_cart(ii_Number_of_Pages, ii_Number_Of_Columns, ii_Number_of_Rungs, al_tr_cart_key ,al_galley_group)
		Return of_fit_into_cart( ai_content_height, ai_fill_order, al_content, al_tr_cart_key, al_galley_group )	
	End If


End If

Return li_Succ


/*
ElseIf ai_content_height = 3 Then
	// -----------------------------------------------------------------------
	// Ben$$HEX1$$f600$$ENDHEX$$tige 3 H$$HEX1$$f600$$ENDHEX$$heneinheiten XXXXXXXX
	// -----------------------------------------------------------------------
	ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0"
	ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
	If ll_Found > 0 Then
		li_Page		= ids_tr_cart_allocation.GetItemNumber(ll_Found, "npage")
		li_Column	= ids_tr_cart_allocation.GetItemNumber(ll_Found, "ncolumn")
		Do While ll_Found > 0
			ll_Free_Rungs[Upperbound(ll_Free_Rungs) + 1] = 	 ids_tr_cart_allocation.GetItemNumber(ll_Found, "nrow")
			ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) + " and ncolumn=" + String(li_Column)
			ll_Found = ids_tr_cart_allocation.Find(ls_Find, ll_Found + 1, ids_tr_cart_allocation.RowCount() + 1)
		Loop
		
		If Upperbound(ll_Free_Rungs) > 2 Then
			//Mindestens 3 aufeinanderfolgende
			If ai_fill_order = FILL_TOP_DOWN Then
				// Top Down: kleinste freie Rung Number wird belegt
				If ll_Free_Rungs[1] + 1 = ll_Free_Rungs[2] AND ll_Free_Rungs[1] + 2 = ll_Free_Rungs[3] Then
					li_Row = ll_Free_Rungs[1]
					ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
					ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
					ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
					If ll_Found > 0 Then
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", -1 )
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "DOUBLE " + String(ll_Free_Rungs[3]))		
						
						If il_Disable_Debug = 0 Then
							f_trace("uo_tr_cart_allocation.of_fit_into_cart height=3 DOUBLE " + String(li_Row))
						End If
						
					End If
					li_Row = ll_Free_Rungs[2]
					ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
					ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
					ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
					If ll_Found > 0 Then
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", -1 )
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "DOUBLE " + String(ll_Free_Rungs[3]))//"cinfo", "FILL")				
						
						If il_Disable_Debug = 0 Then
							f_trace("uo_tr_cart_allocation.of_fit_into_cart height=3 DOUBLE " + String(li_Row))
						End If
						
					End If
					li_Row = ll_Free_Rungs[3]
					ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
					ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
					ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
					If ll_Found > 0 Then
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", al_content )
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "FILL")	 //"cinfo", "DOUBLE " + String(ll_Free_Rungs[3]))			
						
						If il_Disable_Debug = 0 Then
							f_trace("uo_tr_cart_allocation.of_fit_into_cart height=3 " + String(ll_Free_Rungs[3]))
						End If
						
					End If
				End If
			ElseIf ai_fill_order = FILL_FROM_BOTTOM Then
				// Top Down: h$$HEX1$$f600$$ENDHEX$$chste und zweith$$HEX1$$f600$$ENDHEX$$chste Rung Number wird belegt
				If ll_Free_Rungs[Upperbound(ll_Free_Rungs)] - 1 = ll_Free_Rungs[Upperbound(ll_Free_Rungs) - 1] AND &
					ll_Free_Rungs[Upperbound(ll_Free_Rungs)] - 2 = ll_Free_Rungs[Upperbound(ll_Free_Rungs) - 2]Then
					
					// Rungs
					li_Row = ll_Free_Rungs[Upperbound(ll_Free_Rungs) - 2]
					ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
					ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
					ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
					If ll_Found > 0 Then
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", -1 )
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "DOUBLE " + String(ll_Free_Rungs[Upperbound(ll_Free_Rungs)]))
						
						If il_Disable_Debug = 0 Then
							f_trace("uo_tr_cart_allocation.of_fit_into_cart height=3 DOUBLE " + String(li_Row))
						End If
						
					End If
					
					li_Row = ll_Free_Rungs[Upperbound(ll_Free_Rungs) - 1]
					ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
					ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
					ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
					If ll_Found > 0 Then
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", -1 )
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "DOUBLE " + String(ll_Free_Rungs[Upperbound(ll_Free_Rungs)]))				
						
						If il_Disable_Debug = 0 Then
							f_trace("uo_tr_cart_allocation.of_fit_into_cart height=3 DOUBLE " + String(li_Row))
						End If
						
					End If
					
					li_Row = ll_Free_Rungs[Upperbound(ll_Free_Rungs)]
					ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
					ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
					ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
					If ll_Found > 0 Then
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", al_content )
						li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "FILL")
						
						If il_Disable_Debug = 0 Then
							f_trace("uo_tr_cart_allocation.of_fit_into_cart height=3 " + String(ll_Free_Rungs[Upperbound(ll_Free_Rungs)]))
						End If

					End If
					
				End If	
					
			End If
		Else
			// Keine 3 freien Rungs => freien Einschub blocken, => n$$HEX1$$e400$$ENDHEX$$chster Versuch
			If Upperbound(ll_Free_Rungs) < 3 Then
				// Es gibt 1 Einschub, der nicht ausreicht => belegen mit DUMMY
				li_Row = ll_Free_Rungs[1]
				ls_Find = "ntrcart=" + String(il_Cart_Counter) +  " and ncontents=0 and npage=" + String(li_Page) 
				ls_Find += " and ncolumn=" + String(li_Column) + " and nrow=" + String(li_Row)
				ll_Found = ids_tr_cart_allocation.Find(ls_Find, 1, ids_tr_cart_allocation.RowCount())
				If ll_Found > 0 Then
					li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "ncontents", -1 )
					li_Succ = ids_tr_cart_allocation.SetItem(ll_Found, "cinfo", "DUMMY")				
				End If
				Return of_fit_into_cart( ai_content_height, ai_fill_order, al_content )	
				
			End If
			
		
		End If
		
	Else
		// Nichts frei => neuer Cart
		li_Succ = of_add_cart(ii_Number_of_Pages, ii_Number_Of_Columns, ii_Number_of_Rungs )
		Return of_fit_into_cart( ai_content_height, ai_fill_order, al_content )	
	End If

*/
end function

public function integer of_add_content (long al_index_key, long al_detail_key, integer ai_fill_order, boolean ab_force_new_cart, long al_source_row, long al_galley_group);/*
* Objekt : uo_tr_cart_allocation
* Methode: of_add_content (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 03.09.2012
*
* Argument(e):
*	 long al_index_key
*	 long al_detail_key
*	 integer ai_fill_order
*	 boolean ab_force_new_cart
*	 long al_source_row
*
* Beschreibung:		Ermittle Platzbedarf der St$$HEX1$$fc00$$ENDHEX$$ckliste und f$$HEX1$$fc00$$ENDHEX$$lle in Cart
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	03.09.2012		Erstkommentar
*
*
* Return: integer
*
*/


Boolean	lb_New_Cart = FALSE
Integer	li_Succ
Integer	li_Content_Height	= 1
Integer	li_Content_Depth	= 1
String	ls_PL,  ls_Text, ls_Packinglist
Long		ll_Height  
Long		ll_Key


// Ermittle Platzbedarf der St$$HEX1$$fc00$$ENDHEX$$ckliste

// ##### wenn Sondermass - dann hier festlegen
// ##### z.B. Coffee Pots => H$$HEX1$$f600$$ENDHEX$$he 2

// li_Content_Height
SELECT	ccustomer_pl,   ctext,   ndrawer_height , cpackinglist 
INTO		:ls_PL,   :ls_Text,   :ll_Height , :ls_Packinglist 
FROM		cen_packinglists  , cen_packinglist_index
WHERE		cen_packinglists.npackinglist_index_key = :al_index_key
AND		cen_packinglists.npackinglist_detail_key = :al_detail_key  
AND      cen_packinglists.npackinglist_index_key  = cen_packinglist_index.npackinglist_index_key ;

If ll_Height > 1 Then
	li_Content_Height = ll_Height
End If

if il_Disable_Debug = 0 then
	f_trace("uo_tr_cart_allocation.of_add_content li_Content_Height " + String(li_Content_Height))
End If

// Wenn NEW CART von aussen: neuer TR Cart 
If ab_force_new_cart Then
	lb_New_Cart = TRUE
End If

// Noch kein Cart vorhanden	
If il_Cart_Counter = 0 Then
	lb_New_Cart = TRUE
End If

// --------------------------------------------------
// ermittle TR Cart Typ
// --------------------------------------------------
If ib_extended_tr_handling Then
	ll_Key = of_get_tr_cart_key( is_Unit, al_index_key, idt_Ref_Date)
Else
	ll_Key = 0 	
End If

If ib_extended_tr_handling Then
	If NOT of_Exists_cart_key(ll_Key) Then
		lb_New_Cart = TRUE
	End If
End If


If lb_New_Cart Then
	li_Succ = of_add_cart(ii_Number_of_Pages, ii_Number_Of_Columns, ii_Number_of_Rungs, ll_Key, al_galley_group)
End if

// Platz im aktuellen TR Cart?
// Wenn nicht: neuer TR Cart

If handle(getapplication()) = 0 then

	
	f_trace("uo_tr_cart_allocation.of_add_content " + ls_Packinglist + " " + is_TR_Name + " " +  ls_Text )
End If

// F$$HEX1$$fc00$$ENDHEX$$lle in den n$$HEX1$$e400$$ENDHEX$$chsten freien Platz
If of_fit_into_cart (li_Content_Height, ai_Fill_Order, al_source_row, ll_Key, al_galley_group ) = 1 Then
	// Erfolgreich untergebracht
	li_Succ = 1
Else
	li_Succ = -1
End If

Return li_Succ

end function

public function integer of_add_cart (integer ai_pages, integer ai_columns, integer ai_rows, long al_tr_cart_key, long al_galley_group);/*
* Objekt : uo_tr_cart_allocation
* Methode: of_add_cart (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 11.08.2010
*
* Argument(e):
*	 integer ai_pages
*	 integer ai_columns
*	 integer ai_rows
*
* Beschreibung:		TR Cart hinzufgen
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	11.08.2010		Erstellung
* 1.1 			O.Hoefer	28.02.2014		Hinzu: TR Cart Key - Typ wird pro St$$HEX1$$fc00$$ENDHEX$$ckliste ermittelt
*
*
* Return: integer
*
*/


Long		ll_Count_P
Long		ll_Count_C
Long		ll_Count_R
Long		ll_New_Row
Long		ll_Cart_Number
Integer	li_Succ


// c r o p c
If ids_TR_Cart_Allocation.RowCount() > 0 Then
	ll_Cart_Number = ids_TR_Cart_Allocation.GetItemNumber(1, "nmax_cart") + 1
Else
	ll_Cart_Number = 1
	il_Page_Counter = 0
	//nprintpage
End If
//ids_TR_Cart_Allocation.Reset()

For ll_Count_P = 1 To ai_Pages
	il_Page_Counter++
	For ll_Count_C = 1 To ai_Columns
		For ll_Count_R = 1 To ai_rows  
			ll_New_Row = ids_TR_Cart_Allocation.InsertRow(0)
			li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "ncolumn",		ll_Count_C )
			li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "nrow",			ll_Count_R )
			li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "norder",			ll_New_Row )
			li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "npage",			ll_Count_P )
			li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "ncontents",		0 )
			li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "ntrcart",		ll_Cart_Number )
			li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "nprintpage",	il_Page_Counter )
			
			If ib_Extended_TR_Handling Then
				// verschiedene Typen m$$HEX1$$f600$$ENDHEX$$glich => Key merken
				li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "ntr_type",	al_TR_Cart_Key )				
				// nach Galley Group aufteilen
				li_Succ = ids_TR_Cart_Allocation.SetItem(ll_New_Row, "ngalley_group",	al_galley_group )				
				
				
				
			End If
			
		Next
	Next
Next

il_Cart_Counter = ll_Cart_Number

//ncolumn
//nrow
//norder 
//npage 
//ncontents 

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

