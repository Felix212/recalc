HA$PBExportHeader$uo_cbase.sru
$PBExportComments$Dummy-Userobject, da an der Klasse CBASE der Applikation CBASE Instanz-Variablen in Verwendung sind, die ein Kompilieren von CBASE Service unm$$HEX1$$f600$$ENDHEX$$glich machen w$$HEX1$$fc00$$ENDHEX$$rden
forward
global type uo_cbase from nonvisualobject
end type
end forward

global type uo_cbase from nonvisualobject
end type
global uo_cbase uo_cbase

type variables

//
// Proxy f$$HEX1$$fc00$$ENDHEX$$r CBASE Application-Object
//
string		sCommandParam

integer iCitrix
string	sAdditionalSystem
end variables

on uo_cbase.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cbase.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

