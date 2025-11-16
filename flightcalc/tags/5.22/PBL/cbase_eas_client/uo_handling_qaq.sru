HA$PBExportHeader$uo_handling_qaq.sru
forward
global type uo_handling_qaq from nonvisualobject
end type
end forward

global type uo_handling_qaq from nonvisualobject
end type
global uo_handling_qaq uo_handling_qaq

type variables
// --------------------------------
// Beinhaltet eine QAQ-PKNummer
// sowie alle Stauorte, welche
// diese SSL enthalten
// --------------------------------

Long						lQAQHandlingKey
Integer					iLoadedAtLeg

Long						lStowageCount = 0
uo_loading_stowage	Stowages[]

end variables

on uo_handling_qaq.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_handling_qaq.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

