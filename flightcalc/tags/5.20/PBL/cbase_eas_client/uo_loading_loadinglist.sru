HA$PBExportHeader$uo_loading_loadinglist.sru
$PBExportComments$Datenstruktur BELADUNG
forward
global type uo_loading_loadinglist from nonvisualobject
end type
end forward

global type uo_loading_loadinglist from nonvisualobject
end type
global uo_loading_loadinglist uo_loading_loadinglist

type variables


uo_loading_ssl		LoadingLists[]
Long					lLoadingListCount = 0
end variables

on uo_loading_loadinglist.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_loading_loadinglist.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

