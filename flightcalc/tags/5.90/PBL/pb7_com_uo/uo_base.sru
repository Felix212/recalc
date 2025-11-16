HA$PBExportHeader$uo_base.sru
$PBExportComments$user_object Basis mit trace
forward
global type uo_base from nonvisualobject
end type
end forward

global type uo_base from nonvisualobject
end type
global uo_base uo_base

type variables

/* 
* object: 			uo_base
* Beschreibung: 	objekt-basis mit trace-funktionalit$$HEX1$$e400$$ENDHEX$$t
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		12.06.2009		Erstellung
*
*
* das objekt kennt den schalter ibTrace (analog zu bDebug in s_application: trace ein/aus),
* den wert ilTracelevel (analog zu iTrace in s_application: alles, was kleiner als dieser wert ist, wird protokolliert),
* und den string isTracefile (analog zu sTracefile in s_application: das file, in das geschrieben werden soll)
* 
* Tracelevel wird derzeit nur $$HEX1$$fc00$$ENDHEX$$bernommen, aber nicht ausgewertet 
* 
*/


protected:

// soll trace-file geschrieben werden ?
Boolean	ibTrace = FALSE
String 	isTraceFile
Long 		ilTracelevel = 100

String 	isObjectname = "<obj>"

end variables

forward prototypes
protected function long of_log2file (string asmessage)
public function long of_init_trace (boolean abtrace, string astracefile, long altracelevel)
public function long of_init_trace (boolean abtrace, string astracefile)
end prototypes

protected function long of_log2file (string asmessage);
/* 
* Function: 			of_log2file
* Beschreibung: 	schreibt trace in datei
* Besonderheit: 	PROTECTED, nur zum internen gebrauch
*
* Argumente:
*	asMessage		Text, der weggeschrieben werden soll
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		09.06.2009		Erstellung
*
* Return Codes:
*	 0		immer
*/

// hilfsvariable
integer iFile
string  sLogMessage

// ----------------------------------------------------
// Message verfeinern (Leerzeile ohne zeitpunkt lassen)
// ----------------------------------------------------
if asMessage <> "" then sLogMessage = isObjectname + ": " + string(today(),"YYYY-MM-DD") + "," + string(now(), "hh:mm:ss") + "," + asMessage
// ----------------------------------------------------
// ... ins file
// ----------------------------------------------------
iFile = FileOpen(isTraceFile, LineMode!, Write!, LockWrite!, Append!)
if IsNull(iFile) or iFile < 0 then 
	isTraceFile = "C:\Temp\CbaseTrace-" + String(Today(), "yyyy-mm-dd") + ".log"	
	iFile = FileOpen(isTraceFile, LineMode!, Write!, LockWrite!, Append!)
end if
FileWrite(iFile,sLogMessage)
FileClose(iFile)

return 0

end function

public function long of_init_trace (boolean abtrace, string astracefile, long altracelevel);
/* 
* Function: 			of_init_trace
* Beschreibung: 	initialisiert trace-schalter und trace-file
* Besonderheit: 	
*
* Argumente:
*	abTrace			schalter, ob getraced werden soll ( = bDebug in s_app)
*	asTraceFile		name des tracefiles ( = bTracefile in s_app)
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		12.06.2008		Erstellung
*
* Return Codes:
*	 0		immer
*/

// hilfsvariable
integer 	liFile

// null-values und leerstrings wollen wir hier nicht
if IsNull(asTraceFile) or trim(asTraceFile) = "" then asTraceFile = "C:\Temp\CbaseTrace-" + String(Today(), "yyyy-mm-dd") + ".log"
if IsNull(alTracelevel) then alTracelevel = 100

// daten $$HEX1$$fc00$$ENDHEX$$bernehmen
ibTrace = abTrace
isTraceFile = asTraceFile
ilTracelevel = alTracelevel

// daten testen
if ibTrace then
	liFile = FileOpen(isTraceFile, LineMode!, Write!, LockWrite!, Append!)
	if IsNull(liFile) or liFile < 0 then 
		isTraceFile = "C:\Temp\CbaseTrace-" + String(Today(), "yyyy-mm-dd") + ".log"
	else
		FileClose(liFile)
	end if
end if

return 0

end function

public function long of_init_trace (boolean abtrace, string astracefile);
/* 
* Function: 			of_init_trace
* Beschreibung: 	initialisiert trace-schalter und trace-file
* Besonderheit: 	Tracelevel 100 wird unterstellt und das ding wird weitergeleitet
*
* Argumente:
*	abTrace			schalter, ob getraced werden soll ( = bDebug in s_app)
*	asTraceFile		name des tracefiles ( = bTracefile in s_app)
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		12.06.2008		Erstellung
*
* Return Codes:
* 	aus der original-routine 
*/

return this.of_init_trace(abTrace, asTraceFile, 100)

end function

on uo_base.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_base.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
/* 
* Event: 				constructor
* Beschreibung: 	initialisiert...
* Besonderheit: 	hier den objectnamen
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		12.06.2009		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		25.05.2010		Tracefile-init auch hier rein
*
* Return Codes:
*
*/


isObjectname = this.Classname ( )

// hier initialisieren, damit er das mit dem datum korrekt mitkriegt
isTraceFile = "C:\Temp\CbaseTrace-" + String(Today(), "yyyy-mm-dd") + ".log"

end event

