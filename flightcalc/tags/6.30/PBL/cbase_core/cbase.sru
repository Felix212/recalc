HA$PBExportHeader$cbase.sru
$PBExportComments$Dummy-Userobject, da an der Klasse CBASE der Applikation CBASE Instanz-Variablen in Verwendung sind, die ein Kompilieren von CBASE Service unm$$HEX1$$f600$$ENDHEX$$glich machen w$$HEX1$$fc00$$ENDHEX$$rden
forward
global type cbase from nonvisualobject
end type
end forward

global type cbase from nonvisualobject
end type
global cbase cbase

type variables


integer iCitrix
String sadditionalsystem

end variables

on cbase.create
call super::create
TriggerEvent( this, "constructor" )
end on

on cbase.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

