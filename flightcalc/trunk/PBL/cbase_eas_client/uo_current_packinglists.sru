HA$PBExportHeader$uo_current_packinglists.sru
forward
global type uo_current_packinglists from nonvisualobject
end type
end forward

global type uo_current_packinglists from nonvisualobject
end type
global uo_current_packinglists uo_current_packinglists

type variables
Public:

Long 		lPlKey[]
String	sPl[]
Long		lAnzahl
end variables

on uo_current_packinglists.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_current_packinglists.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

