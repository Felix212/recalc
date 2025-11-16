HA$PBExportHeader$uo_select_simple_timer.sru
$PBExportComments$TimingObjekt f$$HEX1$$fc00$$ENDHEX$$r das allgemeine Userobjekt zur Auswahl einfacher Werte (numerischer Key, textueller Wert), multiselekt-f$$HEX1$$e400$$ENDHEX$$hig, layout anpassbar
forward
global type uo_select_simple_timer from timing
end type
end forward

global type uo_select_simple_timer from timing
end type
global uo_select_simple_timer uo_select_simple_timer

type variables

public:

uo_select_simple uoParent

end variables

on uo_select_simple_timer.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_select_simple_timer.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event timer;
/* 
* Event: 				timer
* Beschreibung: 	startet immer nach dem eingestellten intervall und pr$$HEX1$$fc00$$ENDHEX$$ft, was immer das rufende object m$$HEX1$$f600$$ENDHEX$$chte...
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		02.01.2012		Erstellung
*
* Return Codes:
*	none
*
*/


uoParent.of_hittest()

return

end event

