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

public function integer of_init (long al_airline_key);


Return 1
end function

public function boolean of_is_type_relevant (string as_type);
	Return TRUE

end function

public function integer of_add_packinglist (string as_cart_type, string as_packinglist, string as_pl_text, string as_unit_area, string as_stowage, string as_class, long al_class_number, string as_area);
Return 0


end function

public function boolean of_is_booking_class (string as_class);
		Return TRUE

end function

public function integer of_concat_handling (string as_handling_list[], ref string ras_ll_1, ref string ras_ll_2);
Return 1
end function

public function integer of_tr_carts_per_class (ref datastore rads_tripticket);

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
//DESTROY ids_Eq
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

