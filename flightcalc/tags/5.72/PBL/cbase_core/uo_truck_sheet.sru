HA$PBExportHeader$uo_truck_sheet.sru
$PBExportComments$Userobjekt zur Erstellung des Truck-Check-Sheets
forward
global type uo_truck_sheet from nonvisualobject
end type
end forward

global type uo_truck_sheet from nonvisualobject
end type
global uo_truck_sheet uo_truck_sheet

type variables

long			lGalleyPos
long			lPage				// Seitennummer

datastore	dsTruckSheet	// das neu zu erstellende Truck-Sheet
datastore	dsCover			// Deckblatt

string		sAirline
integer		iFlightNumber
string		sSuffix
string		sFrom
string		sTo
date			dDeparture
string		sTime

end variables

event constructor;dsTruckSheet = create datastore
dsTruckSheet.Dataobject = "dw_uo_truck_check_sheet"
uf.translate_datastore(dsTruckSheet)

dsCover = create datastore
dsCover.Dataobject = "dw_uo_truck_check_sheet_cover"
uf.translate_datastore(dsCover)

dsCover.insertRow(0)

end event

event destructor;destroy dsTruckSheet
destroy dsCover

end event

on uo_truck_sheet.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_truck_sheet.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

