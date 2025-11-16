HA$PBExportHeader$uo_select_simple_for_airline.sru
forward
global type uo_select_simple_for_airline from uo_select_simple
end type
end forward

global type uo_select_simple_for_airline from uo_select_simple
end type
global uo_select_simple_for_airline uo_select_simple_for_airline

type variables

/* 
* object: 			uo_select_simple_for_airline
* Beschreibung: 	object zur auswahl von werten zur airline (numerisch intern, textuell extern)
* 						ererbt von uo_select_simple, nur erweitert um airline-bezug
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
* 	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		25.01.2012		Erstellung
*
*
* --------------------------------------------------
* Die Datawindows / Datastores
* --------------------------------------------------
* das objekt braucht ein Datawindow f$$HEX1$$fc00$$ENDHEX$$r die Auswahl,
*    welches mindestens enthalten muss:
* - column mit numerischem key (long)
* - column mit textuellem key (string)
* - column nselected 
* - column nenabled
* - column nairline_key
* - column cairline
* 
* --------------------------------------------------
*  Zus$$HEX1$$e400$$ENDHEX$$tzliche $$HEX1$$f600$$ENDHEX$$ffentlichen Funktionen im $$HEX1$$dc00$$ENDHEX$$berblick
* --------------------------------------------------
* 
* 	of_init (<long array AirlineKey>)
*			hier werden die Airlines f$$HEX1$$fc00$$ENDHEX$$r den select gesetzt
*			anschliessend wird immer die komplette init-routine durchlaufen

* --------------------------------------------------
*  angepasste $$HEX1$$f600$$ENDHEX$$ffentlichen Funktionen im $$HEX1$$dc00$$ENDHEX$$berblick
* --------------------------------------------------
* 
* 	of_init (<string section>)
*			retrieve angepasst, insert "nicht ber$$HEX1$$fc00$$ENDHEX$$cksichtigen"-row erweitert
* 
*/

Public:

// --------------------------------------------------
// k$$HEX1$$f600$$ENDHEX$$nnen von aussen gesetzt werden
// $$HEX1$$fc00$$ENDHEX$$ber init-funktionen  
// --------------------------------------------------

// airlines, zu denen die werte geh$$HEX1$$f600$$ENDHEX$$ren
Long 	ilAirlineKeys[]


end variables

forward prototypes
protected function integer of_init ()
public function long of_init (long alairlinekeys[])
end prototypes

protected function integer of_init ();
/* 
* Funktion:			of_init (intern)
* Beschreibung: 	das userobject initialisieren
* Besonderheit: 	kann mehrfach gerufen werden: wenn parameter angepasst wurden, macht das sinn
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer				Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			25.01.2012		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			30.01.2012		SwitchOff als default, wenn default alles nicht gesetzt
*
* Return Codes:
*	 1	immer
*
*/


// hilfsvariable
Long 		llRet, llRow, llFound = 0, llHit = 0, llHitSwitchOff = 0

// immer nur ein Wert
if this.iiOnlyOneCode = 1 then
	pb_toggle_all.visible = false
	st_toggle_all.visible = false
end if

// daten lesen
//llRet = dw_uo1.Retrieve()
if Upperbound(this.ilAirlineKeys) > 0 then
	llRet = dw_uo1.Retrieve(this.ilAirlineKeys)
else
	dw_uo1.Reset()
end if

// option "alles" erg$$HEX1$$e400$$ENDHEX$$nzen
if ibSwitchOff then
	llRow = dw_uo1.InsertRow(1)
	if llRow > 0 then
		if trim(this.isNumKey) <> "" then llRet = dw_uo1.SetItem(llRow, this.isNumKey, -99)
		if trim(this.isStringKey) <> "" then llRet = dw_uo1.SetItem(llRow, this.isStringKey,  uf.translate("nicht ber$$HEX1$$fc00$$ENDHEX$$cksichtigen"))
		llRet = dw_uo1.SetItem(llRow, "nselected", 0)
		// zus$$HEX1$$e400$$ENDHEX$$tzlich auch die airline
		llRet = dw_uo1.SetItem(llRow, "nairline_key", -1)
		llRet = dw_uo1.SetItem(llRow, "cairline", uf.translate("alle"))
	end if
end if

// dann selektieren
for llRow = 1 to UpperBound(this.isDataValues) step 1
	llFound = dw_uo1.Find(this.isStringKey + " = '" + this.isDataValues[llRow] + "'", 1, dw_uo1.RowCount())
	if llFound > 0 then
		llHit++
		if ibSwitchOff and llRow = 1 then llHitSwitchOff++
		dw_uo1.SetItem(llFound, "nselected", 1)
		dw_uo1.ScrollToRow(llFound)
	end if
next

// option "alles" nicht mit anderen
if llHitSwitchOff > 0 and llHit > 1 then
	dw_uo1.SetItem(1, "nselected", 0)
end if

// nichts ist selektiert, dann alles selektieren
if llHit = 0 and this.ibDefaultAll and this.iiOnlyOneCode = 0 then
	// den schalter nicht vergessen!
	this.iiAll = 1
	for llRow = 1 to dw_uo1.RowCount()
		if ibSwitchOff and llRow = 1 then continue
		dw_uo1.SetItem(llRow, "nselected",  this.iiAll)
	next
end if 

// nichts ist selektiert, alles selektieren nicht gewollt, abschalten erlaubt: abschalten setzen
if llHit = 0 and this.ibDefaultAll = false and this.ibSwitchOff then
	dw_uo1.SetItem(1, "nselected",  1)
end if 

// schliesslich den ausgabestring aufbauen 
llRet = of_values(llFound)

this.trigger event ue_enabled(true)


return 1

end function

public function long of_init (long alairlinekeys[]);
/* 
* Funktion:			of_init (public)
* Beschreibung: 	das userobject initialisieren
* Besonderheit: 	hier zun$$HEX1$$e400$$ENDHEX$$chst die Werte setzen, dann weiter in die eigentliche routine
*
* Argumente:
* 	alAirlineKeys	zu betrachtende airlines
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		25.01.2012		Erstellung
*
* Return Codes:
*	 1	immer
*
*/


this.ilAirlineKeys = alAirlineKeys

return this.of_init()

end function

on uo_select_simple_for_airline.create
call super::create
end on

on uo_select_simple_for_airline.destroy
call super::destroy
end on

type st_value_label from uo_select_simple`st_value_label within uo_select_simple_for_airline
end type

type p_back from uo_select_simple`p_back within uo_select_simple_for_airline
end type

type pb_toggle_all from uo_select_simple`pb_toggle_all within uo_select_simple_for_airline
end type

type sle_value from uo_select_simple`sle_value within uo_select_simple_for_airline
end type

type st_open_close from uo_select_simple`st_open_close within uo_select_simple_for_airline
end type

type st_toggle_all from uo_select_simple`st_toggle_all within uo_select_simple_for_airline
end type

type dw_uo1 from uo_select_simple`dw_uo1 within uo_select_simple_for_airline
end type

type sle_back from uo_select_simple`sle_back within uo_select_simple_for_airline
end type

type pb_open_close from uo_select_simple`pb_open_close within uo_select_simple_for_airline
end type

