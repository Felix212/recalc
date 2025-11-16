HA$PBExportHeader$uo_loading_packinglist.sru
$PBExportComments$Datenstruktur BELADUNG
forward
global type uo_loading_packinglist from nonvisualobject
end type
end forward

global type uo_loading_packinglist from nonvisualobject
end type
global uo_loading_packinglist uo_loading_packinglist

type variables


uo_loading_pl	PackingLists[]
Long				lPackingListCount = 0
end variables

on uo_loading_packinglist.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_loading_packinglist.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

