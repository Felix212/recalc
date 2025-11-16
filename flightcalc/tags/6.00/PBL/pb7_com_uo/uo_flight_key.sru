HA$PBExportHeader$uo_flight_key.sru
forward
global type uo_flight_key from nonvisualobject
end type
end forward

global type uo_flight_key from nonvisualobject autoinstantiate
end type

forward prototypes
public function string of_get_cflight_key (string as_airline, date ad_departure, long al_flight_number, string as_suffix, string as_tlc_from, string as_tlc_to)
end prototypes

public function string of_get_cflight_key (string as_airline, date ad_departure, long al_flight_number, string as_suffix, string as_tlc_from, string as_tlc_to);/*
* Objekt : uo_flight_key
* Methode: of_get_cflight_key (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 24.03.2010
*
* Argument(e):
*	 string as_airline			cAirline
*	 date ad_departure			dDeparture
*	 long al_flight_number		nFlight_Number
*	 string as_suffix				cSuffix
*	 string as_tlc_from			cTLC_From
*	 string as_tlc_to				cTLC_To
*
* Beschreibung:		Erzeugt standardkonformen cFlight_Key (unabh$$HEX1$$e400$$ENDHEX$$ngig von nResult_key)
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	24.03.2010		Erstellung
*
*
* Return: string
*
*/

// --------------------------------------------------------------
// 100322LH0419 IADFRA
// Aufbau:		Datum YYMMDD	6 Stellen
//					Airline			meist 2 bis 3 Stellen
//					Flight Number	4 Stellen - f$$HEX1$$fc00$$ENDHEX$$hrende Nullen
//					cSuffix			falls leer: 1 BLANK
//					TLC From			3 Stellen
//					TLC To			3 Stellen
// --------------------------------------------------------------


String	ls_Return
String	ls_Temp

If NOT IsNull(ad_Departure) Then
	ls_Return = String(ad_Departure, "YYMMDD")
Else
	ls_Return = "000000"
End If

If Not IsNULL(as_Airline) AND Trim(as_Airline) > "" Then
	ls_Return += as_Airline
Else
	ls_Return += "??"
End If

If Not IsNULL(al_flight_number) Then
	ls_Temp = String(ABS(al_flight_number), "0000")
	If Len(ls_Temp) > 4 Then 
		ls_Temp = Right(ls_Temp, 4)
	End If
	ls_Return += ls_Temp
Else
	ls_Return += "0000"
End If
	
If Not IsNULL(as_Suffix) AND Trim(as_Suffix) > "" Then
	ls_Return += as_Suffix
Else
	ls_Return += " "
End If	

If Not IsNULL(as_TLC_From) AND Trim(as_TLC_From) > "" Then
	ls_Return += as_TLC_From
Else
	ls_Return += "???"
End If	

If Not IsNULL(as_TLC_To) AND Trim(as_TLC_To) > "" Then
	ls_Return += as_TLC_To
Else
	ls_Return += "???"
End If	


Return ls_Return
end function

on uo_flight_key.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_flight_key.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

