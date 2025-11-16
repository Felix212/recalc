HA$PBExportHeader$uo_cbase_datastore_with_trace.sru
$PBExportComments$von uo_cbase_datastore mit trace-funktionalit$$HEX1$$e400$$ENDHEX$$t
forward
global type uo_cbase_datastore_with_trace from uo_cbase_datastore
end type
end forward

global type uo_cbase_datastore_with_trace from uo_cbase_datastore
end type
global uo_cbase_datastore_with_trace uo_cbase_datastore_with_trace

type variables

end variables

forward prototypes
end prototypes

on uo_cbase_datastore_with_trace.create
call super::create
end on

on uo_cbase_datastore_with_trace.destroy
call super::destroy
end on

event constructor;call super::constructor;
/* 
* Event: 				constructor
* Beschreibung: 	initialisiert... hier den objectnamen setzen
* Besonderheit: 	extended stehen lassen
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		12.06.2009		Erstellung
*
* Return Codes:
* 	0  Continue processing (PB)
*
*/


// damit der aktuelle name des objects, welches die ausgabe generiert, mit ausgegeben werden kann
isObjectname = this.Classname ( )

return 0

end event

