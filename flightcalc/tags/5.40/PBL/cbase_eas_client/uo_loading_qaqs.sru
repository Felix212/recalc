HA$PBExportHeader$uo_loading_qaqs.sru
$PBExportComments$Datenstruktur BELADUNG
forward
global type uo_loading_qaqs from nonvisualobject
end type
end forward

global type uo_loading_qaqs from nonvisualobject
end type
global uo_loading_qaqs uo_loading_qaqs

type variables


uo_handling_qaq	QAQS[]
Long					lQAQSCount = 0
end variables

on uo_loading_qaqs.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_loading_qaqs.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

