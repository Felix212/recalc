HA$PBExportHeader$uo_loading_pl.sru
$PBExportComments$Datenstruktur BELADUNG
forward
global type uo_loading_pl from nonvisualobject
end type
end forward

global type uo_loading_pl from nonvisualobject
end type
global uo_loading_pl uo_loading_pl

type variables
// --------------------------------
// Beinhaltet eine PL-Nummer
// sowie alle Stauorte, welche
// diese PL enthalten
// --------------------------------


String					sPackingList
Long						lPackingListKey
String					sUnit

Long						lStowageCount = 0
uo_loading_stowage	Stowages[]

end variables

on uo_loading_pl.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_loading_pl.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

