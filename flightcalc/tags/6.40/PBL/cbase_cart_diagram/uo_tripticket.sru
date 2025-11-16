HA$PBExportHeader$uo_tripticket.sru
$PBExportComments$Functions related to the Creation of TripTicket Sheets
forward
global type uo_tripticket from nonvisualobject
end type
end forward

global type uo_tripticket from nonvisualobject
end type
global uo_tripticket uo_tripticket

type variables

// Packinglists aus Cart Diagram
DataStore	ids_Packinglists
// Equipment Types (Cart Diagram)
DataStore	ids_Eq
// TR Carts
DataStore	ids_TR_Classes
// Klassen
DataStore	ids_Airline_Classes


PUBLIC	Long			il_num_tr_carts	= 0 
PUBLIC	Long			il_Disable_Debug	= 1 //0
end variables

forward prototypes
public function integer of_init (long al_airline_key)
public function boolean of_is_type_relevant (string as_type)
public function integer of_add_packinglist (string as_cart_type, string as_packinglist, string as_pl_text, string as_unit_area, string as_stowage, string as_class, long al_class_number, string as_area)
public function boolean of_is_booking_class (string as_class)
public function integer of_concat_handling (string as_handling_list[], ref string ras_ll_1, ref string ras_ll_2)
public function integer of_tr_carts_per_class (ref datastore rads_tripticket)
end prototypes

public function integer of_init (long al_airline_key);/*
* Objekt : uo_tripticket
* Methode: of_init (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 21.09.2010
*
* Argument(e):
* long al_airline_key
*
* Beschreibung:		 Lese relevante Equipment Tyen
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	21.09.2010		Erstellung
*
*
* Return: integer
*
*/


// Lese relevante Equipment Tyen zu Airline
Integer		li_Succ
Long			ll_Rows
String		ls_Filter


ids_Eq  = CREATE datastore
ids_eq.DataObject = "dw_airlines_equipment"
li_Succ = ids_Eq.SetTransObject(SQLCA)
ll_Rows = ids_Eq.Retrieve(al_airline_key)

ls_Filter = "ntripticket=1"
li_Succ = ids_Eq.SetFilter(ls_Filter)
li_Succ = ids_Eq.Filter()

ll_Rows = ids_Eq.RowCount()

ids_Airline_Classes.Retrieve(al_airline_key)


Return 1
end function

public function boolean of_is_type_relevant (string as_type);/*
* Objekt : uo_tripticket
* Methode: of_is_type_relevant (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 21.09.2010
*
* Argument(e):
* string as_type
*
* Beschreibung:		Ist der Equipment Typ relevant f$$HEX1$$fc00$$ENDHEX$$r TripTicket
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	21.09.2010		Erstellung
* 1.1 			O.Hoefer	05.09.2011		TR Carts sollen mit auf deas TripTicket
*
*
* Return: boolean
*
*/


Long		ll_Found
String	ls_Find


ls_Find = "cunit='" + as_type + "'"

ll_Found = ids_eq.Find(ls_Find, 1, ids_eq.RowCOunt() )
If ll_Found > 0 Then 
	Return TRUE
Else
	
	If Upper(as_type) = "XPORTER" Then

		Return TRUE
	
	End If
End If

Return FALSE
end function

public function integer of_add_packinglist (string as_cart_type, string as_packinglist, string as_pl_text, string as_unit_area, string as_stowage, string as_class, long al_class_number, string as_area);/*
* Objekt : uo_tripticket
* Methode: of_add_packinglist (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 20.09.2010
*
* Argument(e):
*	 string as_cart_type
*	 string as_packinglist
*	 string as_pl_text
*	 string as_unit_area
*	 string as_stowage
*	 string as_class
*	 long al_class_number
*
* Beschreibung:		Zeile belegen
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	20.09.2010		Erstellung
*
*
* Return: integer
*
*/


Long		ll_NewRow
Integer	li_Succ


ll_NewRow = ids_packinglists.InsertRow(0)

li_Succ = ids_packinglists.SetItem(ll_NewRow, "scart_type",			as_cart_type )
li_Succ = ids_packinglists.SetItem(ll_NewRow, "spl_nr",				as_packinglist )
li_Succ = ids_packinglists.SetItem(ll_NewRow, "spl_text",			as_pl_text )
li_Succ = ids_packinglists.SetItem(ll_NewRow, "sunit_area", 		as_unit_area )
li_Succ = ids_packinglists.SetItem(ll_NewRow, "sstowage_pos",		as_stowage )
li_Succ = ids_packinglists.SetItem(ll_NewRow, "sclass",				as_Class )
li_Succ = ids_packinglists.SetItem(ll_NewRow, "nclass_number", 	al_class_number )
li_Succ = ids_packinglists.SetItem(ll_NewRow, "sarea", 				as_area )

if il_Disable_Debug=0 then
//	uf.mbox("Info", "TripTicket ids_packinglists " + String(ids_packinglists.rowcount() ))
	f_trace("uo_tripticket.of_add_packinglist ids_packinglists " + as_packinglist + " / " +  as_stowage + " / " + as_Class )
end if


Return 0


end function

public function boolean of_is_booking_class (string as_class);/*
* Objekt : uo_tripticket
* Methode: of_is_booking_class (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 25.10.2010
*
* Argument(e):
* string as_class
*
* Beschreibung:		Check ob Booking Class
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	25.10.2010		Erstellung
*
*
* Return: boolean
*
*/


String	ls_Find
Long		ll_Found
Long		ll_Booking

ls_Find = "cclass='" + as_class + "'"

ll_Found = ids_Airline_Classes.FInd(ls_Find, 1, ids_airline_classes.RowCount())

If ll_Found > 0 Then
	ll_Booking = ids_Airline_Classes.GetItemNumber(ll_Found, "nbooking_class")
	If ll_Booking = 1 Then
		Return TRUE
	End If
End If
	
Return False

end function

public function integer of_concat_handling (string as_handling_list[], ref string ras_ll_1, ref string ras_ll_2);/*
* Objekt : uo_tripticket
* Methode: of_concat_handling (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 03.09.2012
*
* Argument(e):
*	 string as_handling_list[]
*	 ref string ras_ll_1
*	 ref string ras_ll_2
*
* Beschreibung:		Umf$$HEX1$$fc00$$ENDHEX$$llen String-Array auf Zwei Zeilen
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	03.09.2012		Erstellung
*
*
* Return: integer
*
*/

CHOOSE CASE Upperbound(as_handling_list)
	CASE 0
		ras_ll_1 = ""
		ras_ll_2 = ""
	CASE 1
		ras_ll_1 = as_handling_list[1]
		ras_ll_2 = ""
	CASE 2
		ras_ll_1 = as_handling_list[1]
		ras_ll_2 = as_handling_list[2]
	CASE 3
		ras_ll_1 = as_handling_list[1] + "     " + as_handling_list[2]
		ras_ll_2 = as_handling_list[3]
	CASE 4
		ras_ll_1 =  as_handling_list[1] + "     " + as_handling_list[2]
		ras_ll_2 =  as_handling_list[3] + "     " + as_handling_list[4]
	CASE 5
		ras_ll_1 =  as_handling_list[1] + "     " + as_handling_list[2] + "     " + as_handling_list[3]
		ras_ll_2 =  as_handling_list[4] + "     " + as_handling_list[5]
	CASE 6
		ras_ll_1 =  as_handling_list[1] + "     " + as_handling_list[2] + "     " + as_handling_list[3]
		ras_ll_2 =  as_handling_list[4] + "     " + as_handling_list[5] + "     " + as_handling_list[6]
	CASE 7
		ras_ll_1 =  as_handling_list[1] + " " + as_handling_list[2] + " " + as_handling_list[3] + " " + as_handling_list[4]
		ras_ll_2 =  as_handling_list[5] + " " + as_handling_list[6] + " " + as_handling_list[7]
	CASE 8
		ras_ll_1 =  as_handling_list[1] + " " + as_handling_list[2] + " " + as_handling_list[3] + " " + as_handling_list[4]
		ras_ll_2 =  as_handling_list[5] + " " + as_handling_list[6] + " " + as_handling_list[7] + " " + as_handling_list[8]
	CASE ELSE
		ras_ll_1 = ""
		ras_ll_2 = ""
END CHOOSE

Return 1
end function

public function integer of_tr_carts_per_class (ref datastore rads_tripticket);/*
* Objekt : uo_tripticket
* Methode: of_tr_carts_per_class (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 23.08.2012
*
* Argument(e):
* ref datastore rads_tripticket
*
* Beschreibung:		Z$$HEX1$$e400$$ENDHEX$$hle TR Catrs je Klasse
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	23.08.2012		Erstellung
*
*
* Return: integer
*
*/


Long		ll_Found, ll_num_xporters, ll_Counter, ll_temp
String	ls_Error, ls_Class, ls_Find

// --------------------------------------------------------------------
// TR Carts je Klasse
// --------------------------------------------------------------------
ls_Error = rads_tripticket.Modify("t_num_tr_1.Text=' '")
ls_Error = rads_tripticket.Modify("t_num_tr_2.Text=' '")
ls_Error = rads_tripticket.Modify("t_num_tr_3.Text=' '")
If rads_tripticket.Rowcount() > 0 Then
	ll_num_xporters = 0 
	ll_Counter = 1
	SetNULL(ls_Class)
	Do While IsNULL(ls_Class) AND ll_Counter <= rads_tripticket.RowCount()
		ls_Class = rads_tripticket.getitemstring(ll_Counter,"sclass1")
		ll_Counter++
	Loop							
	If NOT isnull(ls_Class) AND Trim(ls_Class) > "" Then
		ls_Find = "cclass='" + ls_Class + "'"
		ll_Found =  ids_tr_classes.Find(ls_Find, 1,  ids_tr_classes.RowCount())
		If ll_Found > 0 Then
			ll_temp =  ids_tr_classes.GetItemNumber(ll_Found, "nnumeric_1")
			ll_num_xporters += ll_temp
			ls_Error = rads_tripticket.Modify("t_num_tr_1.Text='" + String(ll_Temp) + "'")
		End If
	End if
	
	ll_Counter = 1
	SetNULL(ls_Class)
	Do While IsNULL(ls_Class) AND ll_Counter <= rads_tripticket.RowCount()
		ls_Class = rads_tripticket.getitemstring(ll_Counter,"sclass2")
		ll_Counter++
	Loop
	If NOT isnull(ls_Class) AND Trim(ls_Class) > "" Then
		ls_Find = "cclass='" + ls_Class + "'"
		ll_Found =  ids_tr_classes.Find(ls_Find, 1,  ids_tr_classes.RowCount())
		If ll_Found > 0 Then
			ll_temp =  ids_tr_classes.GetItemNumber(ll_Found, "nnumeric_1")
			ll_num_xporters += ll_temp
			ls_Error = rads_tripticket.Modify("t_num_tr_2.Text='" + String(ll_Temp) + "'")
		End If
	End if
	
	ll_Counter = 1
	SetNULL(ls_Class)
	Do While IsNULL(ls_Class) AND ll_Counter <= rads_tripticket.RowCount()
		ls_Class = rads_tripticket.getitemstring(ll_Counter,"sclass3")
		ll_Counter++
	Loop
	If NOT isnull(ls_Class) AND Trim(ls_Class) > "" Then
		ls_Find = "cclass='" + ls_Class + "'"
		ll_Found =  ids_tr_classes.Find(ls_Find, 1,  ids_tr_classes.RowCount())
		If ll_Found > 0 Then
			ll_temp =  ids_tr_classes.GetItemNumber(ll_Found, "nnumeric_1")
			ll_num_xporters += ll_temp
			ls_Error = rads_tripticket.Modify("t_num_tr_3.Text='" + String(ll_Temp) + "'")
		End If
	End if			
End If


Return 1
end function

on uo_tripticket.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_tripticket.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;/*
* Objekt : uo_tripticket
* Methode: destructor (Event)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 22.09.2010
*
* Argument(e):
* none
*
* Beschreibung:		Aufr$$HEX1$$e400$$ENDHEX$$umen
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	22.09.2010		Erstellung
*
*
* Return: long
*
*/


DESTROY ids_Packinglists
DESTROY ids_Eq
DESTROY ids_TR_Classes
DESTROY ids_Airline_Classes
end event

event constructor;/*
* Objekt : uo_tripticket
* Methode: constructor (Event)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 22.09.2010
*
* Argument(e):
* none
*
* Beschreibung:		Initialisierung
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	22.09.2010		Erstellung
*
*
* Return: long
*
*/

ids_Packinglists = CREATE DataStore	
ids_Packinglists.DataObject = "dw_ext_tripticket"

ids_TR_Classes = CREATE DataStore	
ids_TR_Classes.DataObject = "dw_ext_classes"

ids_Airline_Classes = CREATE DataStore	
ids_Airline_Classes.DataObject = "dw_airline_classnames"
ids_Airline_Classes.SetTransObject(SQLCA)

end event

