HA$PBExportHeader$uo_class.sru
$PBExportComments$Dient als erweiterte $$HEX1$$dc00$$ENDHEX$$bergabe-Struktur, um w$$HEX1$$e400$$ENDHEX$$hrend des Druckens mittels uf_getclasscount die Anzahl der Klassen zu ermitteln.
forward
global type uo_class from nonvisualobject
end type
end forward

global type uo_class from nonvisualobject
end type
global uo_class uo_class

type variables
Public:

String	sShortClass[]
String	sLongClass[]
Integer	iClassSort[]
end variables

on uo_class.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_class.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

