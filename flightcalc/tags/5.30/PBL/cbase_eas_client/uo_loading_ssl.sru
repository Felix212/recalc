HA$PBExportHeader$uo_loading_ssl.sru
$PBExportComments$Datenstruktur BELADUNG
forward
global type uo_loading_ssl from nonvisualobject
end type
end forward

global type uo_loading_ssl from nonvisualobject
end type
global uo_loading_ssl uo_loading_ssl

type variables
// --------------------------------
// Beinhaltet eine SSL-Nummer
// sowie alle Stauorte, welche
// diese SSL enthalten
// --------------------------------


String					sLoadingList
Long						lLoadingListKey
Long						lLoadingListType
Integer					iLoadedAtLeg

Long						lStowageCount = 0
uo_loading_stowage	Stowages[]

end variables

on uo_loading_ssl.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_loading_ssl.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

