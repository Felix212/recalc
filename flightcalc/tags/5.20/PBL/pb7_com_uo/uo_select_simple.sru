HA$PBExportHeader$uo_select_simple.sru
$PBExportComments$allgemeines Userobjekt zur Auswahl einfacher Werte (numerischer Key, textueller Wert), multiselekt-f$$HEX1$$e400$$ENDHEX$$hig, layout anpassbar
forward
global type uo_select_simple from userobject
end type
type st_value_label from statictext within uo_select_simple
end type
type p_back from picture within uo_select_simple
end type
type pb_toggle_all from picturebutton within uo_select_simple
end type
type sle_value from singlelineedit within uo_select_simple
end type
type st_open_close from statictext within uo_select_simple
end type
type st_toggle_all from statictext within uo_select_simple
end type
type dw_uo1 from datawindow within uo_select_simple
end type
type sle_back from singlelineedit within uo_select_simple
end type
type pb_open_close from picturebutton within uo_select_simple
end type
end forward

global type uo_select_simple from userobject
integer width = 1047
integer height = 912
boolean enabled = false
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_enabled pbm_enable
event ue_changed ( )
event ue_execute ( )
event type long dw_itemchanged_start ( long lrow,  dwobject dwo,  string data )
event type long dw_itemchanged ( long row,  dwobject dwo,  string data )
st_value_label st_value_label
p_back p_back
pb_toggle_all pb_toggle_all
sle_value sle_value
st_open_close st_open_close
st_toggle_all st_toggle_all
dw_uo1 dw_uo1
sle_back sle_back
pb_open_close pb_open_close
end type
global uo_select_simple uo_select_simple

type prototypes
FUNCTION long HitMsg( long hWindow, uint uMsg, long wParam,  REF s_hittest lParam ) LIBRARY "user32.dll"  ALIAS FOR "SendMessageA;Ansi"
end prototypes

type variables

/* 
* object: 			uo_select_simple
* Beschreibung: 	object zur auswahl von werten (numerisch intern, textuell extern)
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
* 	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		02.01.2012		Erstellung
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
*
* 
* --------------------------------------------------
*  Die $$HEX1$$f600$$ENDHEX$$ffentlichen Funktionen im $$HEX1$$dc00$$ENDHEX$$berblick
* --------------------------------------------------
* 
* 	of_init (<string section>)
* 	of_init (<boolean iiOnlyOneCode>[, <string section>])
*			hier werden ggf. der schalter "nur ein Wert" und die Section f$$HEX1$$fc00$$ENDHEX$$rs profile gesetzt
*			anschliessend wird immer die komplette init-routine durchlaufen
* 			alle hier gesetzten werte k$$HEX1$$f600$$ENDHEX$$nnen auch direkt in der entwicklungsoberfl$$HEX1$$e400$$ENDHEX$$che eingetragen werden
* 
* 	of_change (<boolean iiOnlyOneCode>)
*			hier wird der schalter "nur ein Wert" ver$$HEX1$$e400$$ENDHEX$$ndert
*			wird auf "nur ein Wert" gesetzt, dann wird gepr$$HEX1$$fc00$$ENDHEX$$ft, ob die aktuelle selektion dazu passt  
* 				ist das nicht der fall, dann wird der Wert mit der h$$HEX1$$f600$$ENDHEX$$chsten zeilennummer behalten, alle anderen werden de-selektiert
* 				wenn ein Wert selektiert ist (egal, ob es so war oder erst erzwungen wurde), dann wird of_values(row) angestossen
* 
* 	of_set_backcolor (<long Farbe>)
*			setzt die hintergrundfarbe vom label und vom object (zur anpassung an die umgebung)
* 
* 	of_set_layout (<long Nummer>)
*			setzt die Layout-Kennung, nach der die felder auf der oberfl$$HEX1$$e400$$ENDHEX$$che angepasst werden
*			--------------------------------------------------
*			- 0 bzw. else-zweig immer so, wie urspr$$HEX1$$fc00$$ENDHEX$$nglich, nicht ver$$HEX1$$e400$$ENDHEX$$nderbar
*			- 1 / 2: 	titel obendr$$HEX1$$fc00$$ENDHEX$$ber (1 linksb$$HEX1$$fc00$$ENDHEX$$ndig, 2 an anzeige ausgerichtet)
* 						button und anzeige darunter nebeneinander, button links
* 						breite und y-achse ver$$HEX1$$e400$$ENDHEX$$nderbar (resize)
*			- 10: 		titel obendr$$HEX1$$fc00$$ENDHEX$$ber
* 						button und anzeige darunter nebeneinander, button rechts
* 						breite und y-achse ver$$HEX1$$e400$$ENDHEX$$nderbar (resize)
*			- 20: 		button, titel und anzeige oben, button links
* 						breite und y-achse ver$$HEX1$$e400$$ENDHEX$$nderbar (resize)
*			- 30: 		button, titel und anzeige oben, button rechts
* 						breite und y-achse ver$$HEX1$$e400$$ENDHEX$$nderbar (resize)
*			- 90: 		titel obendr$$HEX1$$fc00$$ENDHEX$$ber linksb$$HEX1$$fc00$$ENDHEX$$ndig
* 						button und anzeige darunter ineinander, wie dropdown
*			- 91: 		titel links, dann button und anzeige ineinander, wie dropdown
*			--------------------------------------------------
* 
* 	of_hittest()
*			schliesst das object, wenn der cursor es verlassen hat 
*			wird vom timer gerufen 
* 
* 	of_resize()
*			baut das Layout neu auf (nach ver$$HEX1$$e400$$ENDHEX$$nderung der $$HEX1$$e400$$ENDHEX$$usseren abmessungen sinnvoll)
* 
* --------------------------------------------------
*  Die internen Funktionen im $$HEX1$$dc00$$ENDHEX$$berblick
* --------------------------------------------------
* 
* 	of_get_user_settings()
*			holt zuvor selektierte Werte aus dem profile und setzt sie ins array
*			wird aktuell im constructor gerufen 
* 
* 	of_init()
*			setzt die zuvor aus dem profile geholten Werte wieder 
*			am ende wird immer of_values(row) angestossen
*			wird aktuell im constructor und aus alle anderen of_init-functions gerufen 
* 
* 	of_close() 
*			setzt das object auf minheight 
*			wird aktuell am ende von of_layout und von of_hittest (timer) gerufen 
* 
* 	of_layout (<long Nummer>)
*			bestimmt die verteilung der felder auf der oberfl$$HEX1$$e400$$ENDHEX$$che (zur anpassung an die umgebung)
* 
* 	of_tooltip() 
*			setzt den inhalt des textfelds in den tooltip
* 
* 	of_values(<long row>)
*			l$$HEX1$$e400$$ENDHEX$$uft durchs datawindow und sammelt die selektierten Werte ein 
*			dabei werden zum einen die arrays isActualDataValues und ilActualDataValues gef$$HEX1$$fc00$$ENDHEX$$llt 
*			zum anderen wird der string aufgebaut, der angezeigt wird 
*			wenn nur ein Wert ausgew$$HEX1$$e400$$ENDHEX$$hlt werden darf, wird alles andere de-selektiert (row ist das kriterium, was stehen bleiben darf) 
*			wenn kein Wert ausgew$$HEX1$$e400$$ENDHEX$$hlt ist, wird  N/A in die anzeige gestellt
*			am ende wird immer ue_changed angestossen, damit die aussenwelt auf ver$$HEX1$$e400$$ENDHEX$$nderungen reagieren kann
* 
* 
* --------------------------------------------------
* controls im $$HEX1$$dc00$$ENDHEX$$berblick
* --------------------------------------------------
* 
* 	dw_uo1
*			datawindow: zeigt alle zu selektierendenWerte an, wenn das object offen ist
*							checkboxen erlauben das selektieren bzw. de-selektieren
* 
* 	sle_value
*			singleline-edit read-only: zeigt die aktuell selektierten Werte an, damit das noch zu erkennen ist, wenn das object geschlossen ist
* 
* 	pb_open_close
*			button: setzt das object auf max- oder min-height
* 
* 	pb_toggle_all
*			button: sitzt im Datawindow und erlaubt das komplette selektieren oder de-selektieren aller Werte
*			ist nur sichtbar, wenn mehr als ein Wert selektiert werden darf
* 
* 
* 	sle_back
*			singleline-edit read-only: hintergrund f$$HEX1$$fc00$$ENDHEX$$r die anzeige (sle_value)
* 
* --------------------------------------------------
* Events, die von aussen angefasst werden k$$HEX1$$f600$$ENDHEX$$nnen, im $$HEX1$$dc00$$ENDHEX$$berblick
* --------------------------------------------------
* 
* dw_itemchanged_start(<long lrow>, <dataobject dwo>, <string data>)
*			wird im itemchanged von dw_uo1 als erstes gerufen und ausgewertet
*			hier leer, vorhanden, damit der itemchanged von dw_uo1 genutzt werden kann
* 
* dw_itemchanged(<long lrow>, <dataobject dwo>, <string data>)
*			wird im itemchanged von dw_uo1 nach der hauptverarbeitung gerufen
*			hier leer, vorhanden, damit der itemchanged von dw_uo1 genutzt werden kann
* 
* ue_enabled(<boolean enabled>)
*			soll das object samt inhalten enablen oder disablen
* 
* ue_changed
*			reaktion auf $$HEX1$$e400$$ENDHEX$$nderung, getriggert aus of_values und of_hittest
*			hier leer, zu f$$HEX1$$fc00$$ENDHEX$$llen im umgebenden window
* 
* ue_execute
*			abschluss-reaktion auf $$HEX1$$e400$$ENDHEX$$nderung, getriggert aus dw_uo1.itemchanged und pb_toggle_all jeweils nach of_values
*			hier leer, zu f$$HEX1$$fc00$$ENDHEX$$llen im umgebenden window
* 
* --------------------------------------------------
* Events, die von aussen NICHT MEHR angefasst werden k$$HEX1$$f600$$ENDHEX$$nnen, im $$HEX1$$dc00$$ENDHEX$$berblick
* --------------------------------------------------
* 
* 	dw_uo1.itemchanged(<long lrow>, <dataobject dwo>, <string data>)
*			der normale itemchanged, betrachtet nur $$HEX1$$e400$$ENDHEX$$nderungen an nselected
*			triggert zuerst parent.dw_itemchanged_start, damit $$HEX1$$e400$$ENDHEX$$ndern unterbunden werden kann
*			posted dann parent.dw_itemchanged(<long lrow>, <dataobject dwo>, <string data>)
*			posted dann of_values(row)
*			posted ganz zum schluss ue_execute
* 
* 	pb_open_close.clicked
*			klappt auf und zu und startet bzw. stoppt timer dazu
* 
* 	pb_toggle_all.clicked
*			selektiert oder de-selektieren alle Werte, gesteuert $$HEX1$$fc00$$ENDHEX$$ber iiAll
*			ruft am ende of_values(0)
*			triggert dann ue_execute
* 
* --------------------------------------------------
*  Die $$HEX1$$f600$$ENDHEX$$ffentlichen Variablen zum auslesen
* --------------------------------------------------
* 
* ilActualDataValues[]
* isActualPLState[]
*			alle aktuell selektierten Werte (Key + text)
* 
*/


Public:

// --------------------------------------------------
// k$$HEX1$$f600$$ENDHEX$$nnen von aussen gesetzt werden
// direkt beim einbinden ins window
// defaults wie in der anlage eingestellt
// --------------------------------------------------

// name des datawindow
String 	isDataObject = ""
// name der numerischen key-column
String 	isNumKey = ""
// name der textuellen key-column
String 	isStringKey = ""


// Layout
Long 		ilLayoutNr = 0
// Layout: eingeklappte / ausgeklappte h$$HEX1$$f600$$ENDHEX$$he
Integer 	iiMinHeight = 104
Integer 	iiMaxHeight = 912
// Layout: gesamtbreite
Integer 	iiWidth = 1047
// Layout: start oben
Integer 	iiObenY = 0
// Layout: abmessungen button auf-/zuklappen
Integer 	iiButtonWidth = 96
Integer 	iiButtonHeight = 88
// Layout: abmessungen label anzeige
Integer 	iiLabelWidth = 174
Integer 	iiLabelHeight = 52
Integer 	iiLabelOffset = 0
// Layout: abmessungen anzeige
Integer 	iiValueWidth = 928
Integer 	iiValueHeight = 96

// Label-Text
String 	isLabelText = "Werte:"

// Profile auslesen / wegschreiben
String 	isSectionValue = ""

// verhalten bei initialisierung ohne jede selektion
Boolean 	ibDefaultAll = true

// sofort zuklappen, wenn maus das select-DW verl$$HEX1$$e400$$ENDHEX$$sst ?
Boolean 	ibCloseOnLoseFocus = false

// immer in den vordergrund ?
Boolean 	ibBringToTop = true

// abschalten m$$HEX1$$f600$$ENDHEX$$glich ?
Boolean 	ibSwitchOff = false


// --------------------------------------------------
// k$$HEX1$$f600$$ENDHEX$$nnen von aussen gesetzt werden
// entweder $$HEX1$$fc00$$ENDHEX$$ber init-funktionen  
// oder direkt beim einbinden ins window
// --------------------------------------------------

// Schalter: nur einer oder mehrere Werte gleichzeitig ausw$$HEX1$$e400$$ENDHEX$$hlen erlaubt
Integer	iiOnlyOneCode = 0

// Profile auslesen / wegschreiben
String 	isSection = ""

// --------------------------------------------------
// k$$HEX1$$f600$$ENDHEX$$nnen von aussen gesetzt werden
// $$HEX1$$fc00$$ENDHEX$$ber init-funktionen  
// --------------------------------------------------


// --------------------------------------------------
// k$$HEX1$$f600$$ENDHEX$$nnen von aussen ausgelesen werden
// --------------------------------------------------
String 	isActualDataValues[]
Long 		ilActualDataValues[]


Protected:

// --------------------------------------------------
// k$$HEX1$$f600$$ENDHEX$$nnen von aussen ausgelesen werden
// $$HEX1$$fc00$$ENDHEX$$ber return-funktionen  
// --------------------------------------------------
String 	isDisplayValue


// --------------------------------------------------
// absolut intern
// --------------------------------------------------

// der timer, der die liste ggf. wieder zuklappt
uo_select_simple_timer uoTimer

// hilfsschalter, ob auf- oder zugeklappt ist
Integer 	iiElapse = 0
// hilfsschalter, ob alles oder nix $$HEX1$$fc00$$ENDHEX$$ber den toggle-schalter zuletzt selektiert wurde
Integer	iiAll = 0

// zum "zwischenspeichern" von aktuell gerade selektierten Codes
// notwendig, damit nach Hauptschl$$HEX1$$fc00$$ENDHEX$$ssel-wechsel bisherige Werte ggf. behalten werden k$$HEX1$$f600$$ENDHEX$$nnen
Long 		ilDataValues[]
String 	isDataValues[]

// ?????
uo_tooltip	uoTip
Integer		iiToolID = 0

end variables

forward prototypes
public function integer of_close ()
public function integer of_tooltip ()
public function integer of_hittest ()
protected function integer of_init ()
protected function integer of_values (long alrow)
public function long of_init (string assection)
protected function long of_get_user_settings ()
protected function long of_layout (long allayoutnr)
public function long of_set_layout (long allayoutnr)
public function long of_resize ()
public function long of_set_backcolor (long alcolor)
public function long of_init (boolean abonlyonecode)
public function long of_init (boolean abonlyonecode, string assection)
public function long of_change (boolean abonlyonecode)
end prototypes

event ue_enabled;
/* 
* Event: 			ue_enabled
* Beschreibung: 	object wird enabled oder disabled: felder und DW entsprechend anpassen
* Besonderheit: 	
*
* Argumente:
*	enable	enabled-zustand (PB)
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		13.12.2010		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		24.01.2012		button immer visible lassen
*
* Return Codes:
*
*/

// hilfsvariable
Long llRow

// bearbeite das textfeld
sle_value.enabled = enable
sle_back.enabled 	= enable

// bearbeite den button
st_open_close.visible = true
pb_open_close.enabled = enable
pb_open_close.visible = true

// bearbeite das label zum textfeld
if enable then
	st_value_label.TextColor = RGB(0,0,0)
else
	st_value_label.TextColor = RGB(128,128,128)
end if

// bearbeite das datawindow
// zeilen bearbeiten
if enable then
	for llRow = 1 to dw_uo1.RowCount() step 1
		dw_uo1.SetItem(llRow, "nenabled", 0)
	next
else
	for llRow = 1 to dw_uo1.RowCount() step 1
		dw_uo1.SetItem(llRow, "nenabled", 1)
	next
end if

return 0

end event

event type long dw_itemchanged_start(long lrow, dwobject dwo, string data);
/* 
* Event: 			dw_itemchanged_start
* Beschreibung: 	eingangs-event f$$HEX1$$fc00$$ENDHEX$$r itemchanged zum dwo
* Besonderheit: 	hier geht's um eingangspr$$HEX1$$fc00$$ENDHEX$$fungen
*
* Argumente:
*	row	akuelle zeile (PB)
*	dwo	akuelles objekt (PB)
*	data	neuer inhalt (PB)
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		29.07.2010		Erstellung
*
* Return Codes:
* 	0  mach weiter
* 	die folgenden gibt einfach wieder raus:
* 	1  Reject the data value and do not allow focus to change (PB)
* 	2  Reject the data value but allow the focus to change (PB)
*
*/



return 0

end event

event type long dw_itemchanged(long row, dwobject dwo, string data);
/* 
* Event: 				dw_itemchanged
* Beschreibung: 	event f$$HEX1$$fc00$$ENDHEX$$r itemchanged zum dwo
* Besonderheit: 	
*
* Argumente:
*	row	akuelle zeile (PB)
*	dwo	akuelles objekt (PB)
*	data	neuer inhalt (PB)
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		02.02.2011		Erstellung
*
* Return Codes:
* 	0  mach weiter
* 	die folgenden gibt einfach wieder raus:
* 	1  Reject the data value and do not allow focus to change (PB)
* 	2  Reject the data value but allow the focus to change (PB)
*
*/



return 0

end event

public function integer of_close ();
/* 
* Funktion:			of_close (protected)
* Beschreibung: 	klappe das DW zu
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			???				xx.xx.xxxx	Erstellung
*
* Return Codes:
*	 0	immer
*
*/

this.height 	= this.iiMinHeight
// this.iElapse 	= 0 

return 0

end function

public function integer of_tooltip ();



if this.iiToolID <> 0 then	
	uoTip.of_RemoveTool(this, this.iiToolID)
	this.iiToolID = 0
end if

uoTip.of_SetMaxWidth(750)
uoTip.of_SetTipBKColor(RGB(255,255,231))
uoTip.of_SetTipTextColor(RGB(0,0,0))
this.iiToolID = uoTip.of_AddTool(sle_value ,this.isDisplayValue, 0)

if isnull(this.iiToolID) then
	this.iiToolId = 0
end if

return 0

end function

public function integer of_hittest ();
/* 
* Funktion:			of_hittest (extern)
* Beschreibung: 	pr$$HEX1$$fc00$$ENDHEX$$fung f$$HEX1$$fc00$$ENDHEX$$r timer: wo ist der zeiger ?
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			???				xx.xx.xxxx	Erstellung
*
* Return Codes:
*	 0	immer
*
*/

// hilfsvariable
Long 		llX, llY
String		lsBand

// initialisieren: wo ist der zeiger ?
lsBand = dw_uo1.GetObjectAtPointer()
if isnull(lsBand) then lsBand = ""
llX = this.PointerX()
llY = this.PointerY()

// Messagebox("", "X: " + String(llX) + " - Y: "  + string(llY))

// der zeiger ist ausserhalb dieses objects: zuklappen
if llX < 0 or llY < 0 or llX > this.width or llY > this.Height then
	this.iiElapse = 0
	this.of_close()
	// ggf. timer stoppen
	if IsValid (uoTimer) then uoTimer.Stop()
end if

return 0

end function

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
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			13.12.2010		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			10.03.2011		SwitchOff eingebaut
*	1.2 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			30.01.2012		SwitchOff als default, wenn default alles nicht gesetzt
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
llRet = dw_uo1.Retrieve()

// option "alles" erg$$HEX1$$e400$$ENDHEX$$nzen
if ibSwitchOff then
	llRow = dw_uo1.InsertRow(1)
	if llRow > 0 then
		if trim(this.isNumKey) <> "" then llRet = dw_uo1.SetItem(llRow, this.isNumKey, -99)
		if trim(this.isStringKey) <> "" then llRet = dw_uo1.SetItem(llRow, this.isStringKey,  uf.translate("nicht ber$$HEX1$$fc00$$ENDHEX$$cksichtigen"))
		llRet = dw_uo1.SetItem(llRow, "nselected", 0)
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

// nichts ist selektiert, dann alles selektieren wenn so eingestellt
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

protected function integer of_values (long alrow);
/* 
* Funktion:			of_values (protected)
* Beschreibung: 	aus dem DW die selektierten Werte zum einen in einen String und zum anderen in einem Array bereitstellen
* Besonderheit: 	direkt mit abpr$$HEX1$$fc00$$ENDHEX$$fen, ob mehr als ein Code selektiert ist, obwohl nur einer darf
*
* Argumente:
* 	alRow				die zeile, die ge$$HEX1$$e400$$ENDHEX$$ndert wurde, damit im falle von mehrfach-selektion, wo sie nicht erlaubt ist, 
* 								entschieden werden kann, welcher Code stehen bleiben soll
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			???			xx.xx.2010		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		03.08.2010		Parameter -1 eingebaut
*	1.2 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		10.03.2011		SwitchOff eingebaut
*	1.3 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		23.02.2012		SwitchOff markieren, wenn erlaubt und sonst nix selektiert
*
* Return Codes:
*	 1	immer
*
*/

// hilfsvariable
Long 		llRow, llHit = 0, llHitSwitchOff = 0
String 	lsValue
String 	lsEmpty[]
Long 		llEmpty[]

// --------------------------------
// Alle ausgew$$HEX1$$e400$$ENDHEX$$hlten Werte
// zusammenbauen
// --------------------------------

// initialisieren: ergebnis-string und ergebnis-array
this.isDisplayValue = ""
this.isActualDataValues = lsEmpty
this.ilActualDataValues = llEmpty

// wenn keine g$$HEX1$$fc00$$ENDHEX$$ltige zeile $$HEX1$$fc00$$ENDHEX$$bergeben wurde:
// nimm die h$$HEX1$$f600$$ENDHEX$$chste zeile mit selektierter ebene
if alRow < 0 then
	for llRow = dw_uo1.RowCount() to 1 step -1
		if dw_uo1.GetItemNumber(llRow, "nselected") =  1 then
			alRow = llRow
			exit
		end if
	next
end if

// es d$$HEX1$$fc00$$ENDHEX$$rfen beliebig viele ebenen selektiert sein: aufbauen
if this.iiOnlyOneCode = 0 then

	for llRow = 1 to dw_uo1.RowCount() step 1
		if dw_uo1.GetItemNumber(llRow, "nselected") = 1 then
			if ibSwitchOff and llRow = 1 then llHitSwitchOff++
			// option "nicht betrachten" zusammen mit was anderem: nicht erlaubt
			// beim ersten, wo sowas festgestellt wird, das ding vorne wieder rausnehmen
			// aber nur, wenn switchoff nicht die aktuelle zeile ist!
			if ibSwitchOff and llRow > 1 and llHitSwitchOff > 0 and alRow <> 1 then
				this.isDisplayValue = ""
				this.isActualDataValues = lsEmpty
				this.ilActualDataValues = llEmpty
				llHitSwitchOff = 0
				llHit --
				dw_uo1.SetItem(1, "nselected", 0)
			end if
			// option "nicht betrachten" zusammen mit was anderem: nicht erlaubt
			// wenn switchoff die aktuelle zeile ist, alles andere wegnehmen
			if ibSwitchOff and llRow > 1 and llHitSwitchOff > 0 and alRow = 1 then
				dw_uo1.SetItem(llRow, "nselected", 0)
			else
				llHit ++
				lsValue = dw_uo1.GetItemString(llRow, this.isStringKey)
				if lsValue = " " then lsValue = "[BLANK]"
				this.isDisplayValue += lsValue  + ", "
				if trim(this.isStringKey) <> "" then this.isActualDataValues[Upperbound(this.isActualDataValues) + 1] = dw_uo1.GetItemString(llRow, this.isStringKey)
				if trim(this.isNumKey) <> "" then this.ilActualDataValues[Upperbound(this.ilActualDataValues) + 1] = dw_uo1.GetItemNumber(llRow, this.isNumKey)
			end if
		end if
	next
	this.isDisplayValue = Mid(this.isDisplayValue, 1, len(this.isDisplayValue) - 2)

// es darf nur eine ebene selektiert sein: die aus alRow nehmen
else

	for llRow = 1 to dw_uo1.RowCount() step 1
		
		if alRow <> llRow then
			dw_uo1.SetItem(llRow, "nselected", 0)
			continue
		end if

		if dw_uo1.GetItemNumber(llRow, "nselected") = 1 then
			llHit ++
			lsValue = dw_uo1.GetItemString(llRow, this.isStringKey)
			if lsValue = " " then lsValue = "[BLANK]"
			this.isDisplayValue = lsValue
			if trim(this.isStringKey) <> "" then this.isActualDataValues[Upperbound(this.isActualDataValues) + 1] = dw_uo1.GetItemString(llRow, this.isStringKey)
			if trim(this.isNumKey) <> "" then this.ilActualDataValues[Upperbound(this.ilActualDataValues) + 1] = dw_uo1.GetItemNumber(llRow, this.isNumKey)
		end if

	next
	
end if

// aktuell selektierte merken
this.ilDataValues = this.ilActualDataValues
this.isDataValues = this.isActualDataValues


// -------------------------------------------
// Alle markiert ???
// -------------------------------------------
if (ibSwitchOff and llHit = dw_uo1.RowCount() - 1) &
or (not ibSwitchOff and llHit = dw_uo1.RowCount() ) then
	this.isDisplayValue = uf.translate("Alle")
	this.iiAll = 1
else
	this.iiAll = 0
end if

// -------------------------------------------
// Keiner markiert ??
// -------------------------------------------
if llHit = 0 then
	this.isDisplayValue = "(N/A)"
	// wenn switchoff da ist, den setzen
	if ibSwitchOff then
		dw_uo1.SetItem(1, "nselected", 1)
		this.isDisplayValue = dw_uo1.GetItemString(1, this.isStringKey)
		if trim(this.isStringKey) <> "" then this.isActualDataValues[Upperbound(this.isActualDataValues) + 1] = dw_uo1.GetItemString(1, this.isStringKey)
		if trim(this.isNumKey) <> "" then this.ilActualDataValues[Upperbound(this.ilActualDataValues) + 1] = dw_uo1.GetItemNumber(1, this.isNumKey)
		this.ilDataValues = this.ilActualDataValues
		this.isDataValues = this.isActualDataValues
//		post of_values(1) 
//		post event ue_execute()
	end if
end if

sle_value.text = this.isDisplayValue

this.of_tooltip()

trigger Event ue_changed()

return 0

end function

public function long of_init (string assection);
/* 
* Funktion:			of_init (public)
* Beschreibung: 	das userobject initialisieren
* Besonderheit: 	hier zun$$HEX1$$e400$$ENDHEX$$chst die Werte setzen, dann weiter in die eigentliche routine
*
* Argumente:
* 	asSection		zu betrachtende section im profile
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		13.12.2010		Erstellung
*
* Return Codes:
*	 1	immer
*
*/

// hilfsvariable
Long 	llRet

this.isSection = asSection
llRet = this.of_get_user_settings()

return this.of_init()

end function

protected function long of_get_user_settings ();
/* 
* Funktion:			of_get_user_settings (intern)
* Beschreibung: 	die zuletzt ausgew$$HEX1$$e400$$ENDHEX$$hlten Werte aus dem Profile wieder herstellen
* Besonderheit: 	kann mehrfach gerufen werden: wenn section angepasst wurde, macht das sinn
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			14.12.2010	Erstellung
*
* Return Codes:
*	 1	immer
*
*/


// hilfsvariable profile auslesen
String 	lsOut, lsTemp, lsToken, lsEmpty[]
Long 		llRow, llEmpty[]

// initialisieren
if IsNull(this.isSection) then this.isSection = ""
if IsNull(this.isSectionValue) then this.isSectionValue = ""
this.ilDataValues = llEmpty
this.isDataValues = lsEmpty

// profile auslesen und eventuell dort befindliche zuletzt selektierte Werte eintragen
if this.isSection <> "" and this.isSectionValue <> "" then
	lsOut = f_profilestring(this.isSection, this.isSectionValue, "0")
	lsTemp = ""
	// string umbauen in array, trenner ist semikolon (;)
	for llRow = 1 to len(lsOut)
		lsToken = Mid(lsOut, llRow, 1)
		if lsToken <> ";" then
			lsTemp += lsToken
		else
			this.ilDataValues[UpperBound(this.ilDataValues) + 1]  = long(lsTemp)
			this.isDataValues[UpperBound(this.isDataValues) + 1]  = lsTemp
			lsTemp = ""
		end if
	next
end if

return 1

end function

protected function long of_layout (long allayoutnr);
/* 
* Funktion:			of_layout (intern)
* Beschreibung: 	modifiziert das layout (zur anpassung an die umgebung, in die eingebettet wird)
* Besonderheit: 	
*
* Argumente:
* 	alLayoutNr		Layout-Nummer
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			07.02.2011	Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			02.01.2012	Layout 20/30 valuewidth nur anpassen, wenn zu gross (passierte auch bei kleiner)
*
* Return Codes:
*	 0	immer
*
*/


/* ----------------------------------------------------
 * FELDER:
 * - [st_value_label] 	titel
 * - [sle_back] 		anzeige
 * - [pb_open_close] 	button
 * - [st_open_close] 	schatten zu button
 * - [dw_uo1] 			datawindow
 * - [pb_toggle_all] 	toggle-button zu DW
 * - [pb_toggle_all] 	schatten zu toggle-button zu DW
 *
 * zus$$HEX1$$e400$$ENDHEX$$tzlich:
 * - [sle_value] 		anzeige innen
 * - [p_back] 			bild hintergrund anzeige
 *
 * ----------------------------------------------------
 * button ist immer x + 5 und y + 4 zum schatten
 * button ist immer width - 9 und height - 8 zum schatten
 * ----------------------------------------------------
 * wenn button und anzeige in gleicher zeile:
 * 		hintergrund anzeige ist y wie schatten button, height wie schatten button
 * ----------------------------------------------------
 * wenn anzeige und titel in gleicher zeile:
 * 		titel ist y wie hintergrund anzeige + die h$$HEX1$$e400$$ENDHEX$$lfte von (height hintergrund anzeige - height titel)
 * ----------------------------------------------------
 * wenn button und titel in gleicher zeile:
 * 		titel ist y wie button + die h$$HEX1$$e400$$ENDHEX$$lfte von (height button + 4 - height titel)
 * ----------------------------------------------------
 *
 *
 *
 * ----------------------------------------------------
 * LAYOUTS:
 * datawindow und toggle-button bleiben immer fix, nur die breite ist $$HEX1$$e400$$ENDHEX$$nderbar
 * - 0 bzw. else-zweig immer so, wie urspr$$HEX1$$fc00$$ENDHEX$$nglich, nicht ver$$HEX1$$e400$$ENDHEX$$nderbar
 *
 * - 1 / 2: 		titel obendr$$HEX1$$fc00$$ENDHEX$$ber (1 linksb$$HEX1$$fc00$$ENDHEX$$ndig, 2 an anzeige ausgerichtet)
 * 					button und anzeige darunter nebeneinander, button links
 * 					breite und y-achse ver$$HEX1$$e400$$ENDHEX$$nderbar (resize)
 * - 10: 			titel obendr$$HEX1$$fc00$$ENDHEX$$ber
 * 					button und anzeige darunter nebeneinander, button rechts
 * 					breite und y-achse ver$$HEX1$$e400$$ENDHEX$$nderbar (resize)
 * - 20: 			button, titel und anzeige oben, button links
 * 					breite und y-achse ver$$HEX1$$e400$$ENDHEX$$nderbar (resize)
 * - 30: 			button, titel und anzeige oben, button rechts
 * 					breite und y-achse ver$$HEX1$$e400$$ENDHEX$$nderbar (resize)
 *
 * - 90: 			titel obendr$$HEX1$$fc00$$ENDHEX$$ber linksb$$HEX1$$fc00$$ENDHEX$$ndig
 * 					button und anzeige darunter ineinander, wie dropdown
 * - 91: 			titel links, dann button und anzeige ineinander, wie dropdown
 * --------------------------------------------------*/


// hilfsvariable
Long 	llLayoutNr
Long 	llWidthDW = 851
Long 	llWidthShadowOpenClose, llHeightShadowOpenClose
Long 	llLabelWidth, llValueWidth, llLabelHeight
Long 	llWidthPictureButton = 96

// hilfsvariable f$$HEX1$$fc00$$ENDHEX$$r dropdown-optik
Long 		llWidthDropdownButton = 69, llHeightDropdownButton = 60
String 	lsDropdownPicture = "..\Resource\downarrow_small.gif"


// aus den instanzen holen
llWidthShadowOpenClose = this.iiButtonWidth + 9
llHeightShadowOpenClose = this.iiButtonHeight + 8

// layoutnummer $$HEX1$$fc00$$ENDHEX$$bernehmen
llLayoutNr = alLayoutNr

// breite aktuell reinholen
this.iiWidth = this.Width

// DW immer mindestens 851 breit
if this.iiWidth > llWidthDW then llWidthDW = this.iiWidth

// label- und value-breite erstmal $$HEX1$$fc00$$ENDHEX$$bernehmen
llLabelWidth = this.iiLabelWidth
llValueWidth = this.iiValueWidth
llLabelHeight = this.iiLabelHeight

// titel dr$$HEX1$$fc00$$ENDHEX$$ber hat zwei varianten, die sich nur in der position des titels unterscheiden, 
// deshalb keinen kompletten eigenen layout-block
if alLayoutNr = 2 then llLayoutNr = 1

// falls umgeschaltet wird...
st_open_close.visible = true
sle_back.visible = true
p_back.visible = true
sle_value.border = false
st_value_label.visible = false

// immer nur ein Wert: kein markieren "alles/nix"
if this.iiOnlyOneCode = 1 then
	pb_toggle_all.visible = false
	st_toggle_all.visible = false
else
	st_toggle_all.visible = true
	pb_toggle_all.visible = true
end if

// verteiler
choose case llLayoutNr

	// --------------------------------------------------
	// 		titel alleine obendr$$HEX1$$fc00$$ENDHEX$$ber
	// 		button, anzeige nebeneinander, button links
	// 		auswahl-dw darunter
	// --------------------------------------------------
	// titel:
	// 		5 versatz nach links (damit button drunter nicht $$HEX1$$fc00$$ENDHEX$$berragt wirkt)
	// 		iiObenY versatz nach unten
	// 		iiLabelWidth und iiLabelHeight werden genutzt
	// --------------------------------------------------
	// button:
	// 		schatten direkt links und oben direkt auf iiLabelHeight
	// 		button relativ zum schatten
	// 		iiButtonWidth und iiButtonHeight werden genutzt
	// --------------------------------------------------
	// anzeige:
	// 		position relativ zum button
	// 		h$$HEX1$$f600$$ENDHEX$$he relativ zum button
	// 		iiValueWidth wird genutzt (aber ggf. gekappt gegen gesamtbreite - button/schatten)
	// --------------------------------------------------
	// anzeige innen und bild anzeige immer relativ zur anzeige
	// --------------------------------------------------
	// DW:
	// 		direkt links und oben auf schatten + 12 zwischenraum
	// 		breite iiWidth, unter beachtung mindestbreite
	// 		h$$HEX1$$f600$$ENDHEX$$he iiMaxHeight - y-position
	// --------------------------------------------------
	case 1

			// der feldtitel
			if llLabelWidth > this.iiWidth - 5 then llLabelWidth = this.iiWidth - 5
			st_value_label.x = 5
			st_value_label.y = this.iiObenY
			st_value_label.width = llLabelWidth
			st_value_label.height = this.iiLabelHeight
			st_value_label.Alignment = Left!
			st_value_label.visible = true

			// der button und sein schatten
			st_open_close.x = 0
			st_open_close.y = this.iiLabelHeight
			st_open_close.width = llWidthShadowOpenClose
			st_open_close.height = llHeightShadowOpenClose
			pb_open_close.x = st_open_close.x + 5
			pb_open_close.y = st_open_close.y + 4
			pb_open_close.width = this.iiButtonWidth
			pb_open_close.height = this.iiButtonHeight

			// die anzeige
			if llValueWidth > this.iiWidth - llWidthShadowOpenClose then llValueWidth = this.iiWidth - llWidthShadowOpenClose
			sle_back.x = st_open_close.width
			sle_back.y = pb_open_close.y
			sle_back.width = llValueWidth
			sle_back.height = pb_open_close.height + 4

			// bild anzeige
			p_back.x = sle_back.x + 14
			p_back.y = sle_back.y + 16
			p_back.width = 73
			p_back.height = 64
			p_back.BringToTop = true
			
			// anzeige innen
			sle_value.x = p_back.x + 87
			sle_value.y = p_back.y + 4
			sle_value.width = sle_back.width - (sle_value.x - sle_back.x) - 20
			sle_value.height = p_back.height
			sle_value.BringToTop = true

			// das datawindow
			dw_uo1.x = 0
			dw_uo1.y = st_open_close.y + st_open_close.height + 12
			dw_uo1.width = llWidthDW 
			dw_uo1.height = this.iiMaxHeight - dw_uo1.y
			
			// der button im DW
			pb_toggle_all.x = dw_uo1.x + 192
			pb_toggle_all.y = dw_uo1.y + 16
			pb_toggle_all.width = 69
			pb_toggle_all.height = 60
			// und sein schatten
			st_toggle_all.x = pb_toggle_all.x - 5
			st_toggle_all.y = pb_toggle_all.y - 4
			st_toggle_all.width = pb_toggle_all.width + 9
			st_toggle_all.height = pb_toggle_all.height + 8

	// --------------------------------------------------
	// 		titel alleine obendr$$HEX1$$fc00$$ENDHEX$$ber
	// 		button, anzeige nebeneinander, button rechts
	// 		auswahl-dw darunter
	// --------------------------------------------------
	// titel:
	// 		5 versatz nach links (damit button drunter nicht $$HEX1$$fc00$$ENDHEX$$berragt wirkt)
	// 		iiObenY versatz nach unten
	// 		iiLabelWidth und iiLabelHeight werden genutzt
	// --------------------------------------------------
	// button:
	// 		schatten direkt rechts und oben direkt auf iiLabelHeight
	// 		button relativ zum schatten
	// 		iiButtonWidth und iiButtonHeight werden genutzt
	// --------------------------------------------------
	// anzeige:
	// 		direkt links, oben relativ zum button
	// 		h$$HEX1$$f600$$ENDHEX$$he relativ zum button
	// 		iiValueWidth wird genutzt (aber ggf. gekappt gegen gesamtbreite - button/schatten)
	// --------------------------------------------------
	// anzeige innen und bild anzeige immer relativ zur anzeige
	// --------------------------------------------------
	// DW:
	// 		direkt links und oben auf schatten + 12 zwischenraum
	// 		breite iiWidth, unter beachtung mindestbreite
	// 		h$$HEX1$$f600$$ENDHEX$$he iiMaxHeight - y-position
	// --------------------------------------------------
	case 10

			// der feldtitel
			if llLabelWidth > this.iiWidth - 5 then llLabelWidth = this.iiWidth - 5
			st_value_label.x = 5
			st_value_label.y = this.iiObenY
			st_value_label.width = llLabelWidth
			st_value_label.height = this.iiLabelHeight
			st_value_label.Alignment = Left!
			st_value_label.visible = true

			// der button und sein schatten
			st_open_close.x = this.iiWidth - llWidthShadowOpenClose
			st_open_close.y = this.iiLabelHeight
			st_open_close.width = llWidthShadowOpenClose
			st_open_close.height = llHeightShadowOpenClose
			pb_open_close.x = st_open_close.x + 5
			pb_open_close.y = st_open_close.y + 4
			pb_open_close.width = this.iiButtonWidth
			pb_open_close.height = this.iiButtonHeight
			
			// die anzeige
			if llValueWidth > this.iiWidth - llWidthShadowOpenClose then llValueWidth = this.iiWidth - llWidthShadowOpenClose
			sle_back.x = 0
			sle_back.y = pb_open_close.y
			sle_back.width = llValueWidth
			sle_back.height = pb_open_close.height + 4

			// bild anzeige
			p_back.x = sle_back.x + 14
			p_back.y = sle_back.y + 16
			p_back.width = 73
			p_back.height = 64
			p_back.BringToTop = true
			
			// anzeige innen
			sle_value.x = p_back.x + 87
			sle_value.y = p_back.y + 4
			sle_value.width = sle_back.width - (sle_value.x - sle_back.x) - 20
			sle_value.height = p_back.height
			sle_value.BringToTop = true

			// das datawindow
			dw_uo1.x = 0
			dw_uo1.y = st_open_close.y + st_open_close.height + 12
			dw_uo1.width = llWidthDW 
			dw_uo1.height = this.iiMaxHeight - dw_uo1.y
			
			// der button im DW
			pb_toggle_all.x = dw_uo1.x + 192
			pb_toggle_all.y = dw_uo1.y + 16
			pb_toggle_all.width = 69
			pb_toggle_all.height = 60
			// und sein schatten
			st_toggle_all.x = pb_toggle_all.x - 5
			st_toggle_all.y = pb_toggle_all.y - 4
			st_toggle_all.width = pb_toggle_all.width + 9
			st_toggle_all.height = pb_toggle_all.height + 8

	// --------------------------------------------------
	// 		button, titel, anzeige oben nebeneinander, button links
	// 		auswahl-dw darunter
	// --------------------------------------------------
	// button:
	// 		schatten direkt links
	// 		iiObenY versatz nach unten
	// 		iiButtonWidth und iiButtonHeight werden genutzt
	// --------------------------------------------------
	// titel:
	// 		direkt links auf den schatten
	// 		oben wird abstand berechnet aus differenz der h$$HEX1$$f600$$ENDHEX$$hen der anzeige und dem titel plus ev. offset aus instance
	// 		iiLabelWidth und iiLabelHeight werden genutzt
	// --------------------------------------------------
	// anzeige:
	// 		links auf schatten + labelbreite + 4 versatz, oben relativ zum button
	// 		h$$HEX1$$f600$$ENDHEX$$he relativ zum button
	// 		iiValueWidth wird genutzt (aber ggf. gekappt gegen gesamtbreite - button/schatten - titelbreite)
	// --------------------------------------------------
	// anzeige innen und bild anzeige immer relativ zur anzeige
	// --------------------------------------------------
	// DW:
	// 		direkt links und oben auf schatten + 12 zwischenraum
	// 		breite iiWidth, unter beachtung mindestbreite
	// 		h$$HEX1$$f600$$ENDHEX$$he iiMaxHeight - y-position
	// --------------------------------------------------
	case 20

			// erstmal sicherstellen, dass bei den breiten kein bl$$HEX1$$f600$$ENDHEX$$dsinn eingegeben wurde (labelbreite hat vorrang)
			if llLabelWidth + llValueWidth + 4 > this.iiWidth - llWidthShadowOpenClose then 
				llValueWidth = this.iiWidth - llWidthShadowOpenClose - llLabelWidth - 4
				if llValueWidth < 0 then
					llLabelWidth += llValueWidth
					llValueWidth = 0
				end if
				if llValueWidth < 100 and llLabelWidth > 200 then
					llValueWidth += 100
					llLabelWidth -= 100
				end if
			end if

			// der button und sein schatten
			st_open_close.x = 0
			st_open_close.y = this.iiObenY
			st_open_close.width = llWidthShadowOpenClose
			st_open_close.height = llHeightShadowOpenClose
			pb_open_close.x = st_open_close.x + 5
			pb_open_close.y = st_open_close.y + 4
			pb_open_close.width = this.iiButtonWidth
			pb_open_close.height = this.iiButtonHeight
			
			// die anzeige
			sle_back.x = llWidthShadowOpenClose + llLabelWidth + 4
			sle_back.y = pb_open_close.y
			sle_back.width = llValueWidth
			sle_back.height = pb_open_close.height + 4

			// bild anzeige
			p_back.x = sle_back.x + 14
			p_back.y = sle_back.y + 16
			p_back.width = 73
			p_back.height = 64
			p_back.BringToTop = true
			
			// anzeige innen
			sle_value.x = p_back.x + 87
			sle_value.y = p_back.y + 4
			sle_value.width = sle_back.width - (sle_value.x - sle_back.x) - 20
			sle_value.height = p_back.height
			sle_value.BringToTop = true

			// der feldtitel
			if llLabelHeight > sle_back.height then llLabelHeight = sle_back.height
			st_value_label.x = llWidthShadowOpenClose
			st_value_label.y = pb_open_close.y + (truncate((sle_back.height - llLabelHeight) / 2,0)) + this.iiLabelOffset
			st_value_label.width = llLabelWidth
			st_value_label.height = llLabelHeight
			st_value_label.Alignment = Right!
			st_value_label.visible = true

			// das datawindow
			dw_uo1.x = 0
			dw_uo1.y = st_open_close.y + st_open_close.height + 12
			dw_uo1.width = llWidthDW 
			dw_uo1.height = this.iiMaxHeight - dw_uo1.y
			
			// der button im DW
			pb_toggle_all.x = dw_uo1.x + 192
			pb_toggle_all.y = dw_uo1.y + 16
			pb_toggle_all.width = 69
			pb_toggle_all.height = 60
			// und sein schatten
			st_toggle_all.x = pb_toggle_all.x - 5
			st_toggle_all.y = pb_toggle_all.y - 4
			st_toggle_all.width = pb_toggle_all.width + 9
			st_toggle_all.height = pb_toggle_all.height + 8

	// --------------------------------------------------
	// 		titel, anzeige, button oben nebeneinander, button rechts
	// 		auswahl-dw darunter
	// --------------------------------------------------
	// button:
	// 		schatten direkt rechts
	// 		iiObenY versatz nach unten
	// 		iiButtonWidth und iiButtonHeight werden genutzt
	// --------------------------------------------------
	// titel:
	// 		direkt links
	// 		oben wird abstand berechnet aus differenz der h$$HEX1$$f600$$ENDHEX$$hen der anzeige und dem titel plus ev. offset aus instance
	// 		iiLabelWidth und iiLabelHeight werden genutzt (Height wird ggf. auf h$$HEX1$$f600$$ENDHEX$$he der anzeige gekappt)
	// --------------------------------------------------
	// anzeige:
	// 		links auf titel + 4 versatz, oben gleich schatten-button
	// 		h$$HEX1$$f600$$ENDHEX$$he gleich schatten-button
	// 		iiValueWidth wird genutzt (aber ggf. gekappt gegen gesamtbreite - button/schatten - titelbreite)
	// --------------------------------------------------
	// anzeige innen und bild anzeige immer relativ zur anzeige
	// --------------------------------------------------
	// DW:
	// 		direkt links und oben auf schatten + 12 zwischenraum
	// 		breite iiWidth, unter beachtung mindestbreite
	// 		h$$HEX1$$f600$$ENDHEX$$he iiMaxHeight - y-position
	// --------------------------------------------------
	case 30

			// erstmal sicherstellen, dass bei den breiten kein bl$$HEX1$$f600$$ENDHEX$$dsinn eingegeben wurde (labelbreite hat vorrang)
			if llLabelWidth + llValueWidth + 4 > this.iiWidth - llWidthShadowOpenClose then
				llValueWidth = this.iiWidth - llWidthShadowOpenClose - llLabelWidth - 4
				if llValueWidth < 0 then
					llLabelWidth += llValueWidth
					llValueWidth = 0
				end if
				if llValueWidth < 100 and llLabelWidth > 200 then
					llValueWidth += 100
					llLabelWidth -= 100
				end if
			end if
			
			// der button und sein schatten
			st_open_close.x = this.iiWidth - llWidthShadowOpenClose
			st_open_close.y = this.iiObenY
			st_open_close.width = llWidthShadowOpenClose
			st_open_close.height = llHeightShadowOpenClose
			pb_open_close.x = st_open_close.x + 5
			pb_open_close.y = st_open_close.y + 4
			pb_open_close.width = this.iiButtonWidth
			pb_open_close.height = this.iiButtonHeight
			
			// die anzeige
			sle_back.x = llLabelWidth + 4
			sle_back.y = st_open_close.y
			sle_back.width = llValueWidth
			sle_back.height = st_open_close.height

			// bild anzeige
			p_back.x = sle_back.x + 14
			p_back.y = sle_back.y + 16
			p_back.width = 73
			p_back.height = 64
			p_back.BringToTop = true
			
			// anzeige innen
			sle_value.x = p_back.x + 87
			sle_value.y = p_back.y + 4
			sle_value.width = sle_back.width - (sle_value.x - sle_back.x) - 20
			sle_value.height = p_back.height
			sle_value.BringToTop = true

			// der feldtitel
			if llLabelHeight > sle_back.height then llLabelHeight = sle_back.height
			st_value_label.x = 0
			st_value_label.y = pb_open_close.y + (truncate((sle_back.height - llLabelHeight) / 2,0)) + this.iiLabelOffset
			st_value_label.width = llLabelWidth
			st_value_label.height = llLabelHeight
			st_value_label.Alignment = Right!
			st_value_label.visible = true

			// das datawindow
			dw_uo1.x = 0
			dw_uo1.y = st_open_close.y + st_open_close.height + 12
			dw_uo1.width = llWidthDW 
			dw_uo1.height = this.iiMaxHeight - dw_uo1.y
			
			// der button im DW
			pb_toggle_all.x = dw_uo1.x + 192
			pb_toggle_all.y = dw_uo1.y + 16
			pb_toggle_all.width = 69
			pb_toggle_all.height = 60
			// und sein schatten
			st_toggle_all.x = pb_toggle_all.x - 5
			st_toggle_all.y = pb_toggle_all.y - 4
			st_toggle_all.width = pb_toggle_all.width + 9
			st_toggle_all.height = pb_toggle_all.height + 8

	// --------------------------------------------------
	// 		titel alleine obendr$$HEX1$$fc00$$ENDHEX$$ber
	// 		button in der anzeige (dropdown-layout)
	// 		auswahl-dw darunter
	// --------------------------------------------------
	// titel:
	// 		direkt links
	// 		iiObenY versatz nach unten
	// 		iiLabelWidth und iiLabelHeight werden genutzt
	// --------------------------------------------------
	// anzeige:
	// 		direkt links, oben auf den titel + 4 versatz
	// 		h$$HEX1$$f600$$ENDHEX$$he fest dropdown + 13
	// 		gesamtbreite (iiWidth)
	// --------------------------------------------------
	// anzeige innen und bild anzeige hier unsichtbar: kein platz
	// --------------------------------------------------
	// button:
	// 		rechts in anzeige eingepasst: horizontal 9 versatz, vertikal 6 versatz
	// 		h$$HEX1$$f600$$ENDHEX$$he / breite fest
	// 		schatten unsichtbar
	// --------------------------------------------------
	// DW:
	// 		direkt links und oben auf anzeige + 12 zwischenraum
	// 		breite iiWidth, unter beachtung mindestbreite
	// 		h$$HEX1$$f600$$ENDHEX$$he iiMaxHeight - y-position
	// --------------------------------------------------
	case 90
		
			// der feldtitel
			if llLabelWidth > this.iiWidth then llLabelWidth = this.iiWidth
			st_value_label.x = 0
			st_value_label.y = this.iiObenY
			st_value_label.width = llLabelWidth
			st_value_label.height = this.iiLabelHeight
			st_value_label.Alignment = Left!
			st_value_label.visible = true

			// die anzeige (geht hier nicht wegen platz)
			sle_back.visible = false

			// bild anzeige (geht hier nicht wegen platz)
			p_back.visible = false
			
			// anzeige innen
			sle_value.x = 0
			sle_value.y = st_value_label.height + 4
			sle_value.width =  this.iiWidth
			sle_value.height = llHeightDropdownButton + 13
			sle_value.border = true
			sle_value.BringToTop = true

			// der button (rechts in die anzeige eingepasst und schatten weg)
			st_open_close.x = 0
			st_open_close.y = 0
			st_open_close.width = 0
			st_open_close.height = 0
			st_open_close.visible = false

			pb_open_close.width = llWidthDropdownButton
			pb_open_close.height = llHeightDropdownButton
			pb_open_close.x = sle_value.x + sle_value.width - (pb_open_close.width + 9)
			pb_open_close.y = sle_value.y + 6
			pb_open_close.BringToTop = true
			pb_open_close.picturename = lsDropdownPicture

			// das datawindow
			dw_uo1.x = 0
			dw_uo1.y = sle_value.y + sle_value.height + 12
			dw_uo1.width = llWidthDW 
			dw_uo1.height = this.iiMaxHeight - dw_uo1.y
			
			// der button im DW
			pb_toggle_all.x = dw_uo1.x + 192
			pb_toggle_all.y = dw_uo1.y + 16
			pb_toggle_all.width = 69
			pb_toggle_all.height = 60
			// und sein schatten
			st_toggle_all.x = pb_toggle_all.x - 5
			st_toggle_all.y = pb_toggle_all.y - 4
			st_toggle_all.width = pb_toggle_all.width + 9
			st_toggle_all.height = pb_toggle_all.height + 8

	// --------------------------------------------------
	// 		titel links, button in der anzeige (dropdown-layout)
	// 		auswahl-dw darunter
	// --------------------------------------------------
	// titel:
	// 		direkt links
	// 		oben wird abstand berechnet aus differenz der h$$HEX1$$f600$$ENDHEX$$hen der anzeige und dem titel
	// 		iiLabelWidth und iiLabelHeight werden genutzt
	// --------------------------------------------------
	// anzeige:
	// 		links auf titelbreite + 4 versatz
	// 		iiObenY versatz nach unten
	// 		h$$HEX1$$f600$$ENDHEX$$he fest dropdown + 13
	// 		gesamtbreite  - titelbreite - 4 versatz
	// --------------------------------------------------
	// anzeige innen und bild anzeige hier unsichtbar: kein platz
	// --------------------------------------------------
	// button:
	// 		rechts in anzeige eingepasst: horizontal 9 versatz, vertikal 6 versatz
	// 		h$$HEX1$$f600$$ENDHEX$$he / breite fest
	// 		schatten unsichtbar
	// --------------------------------------------------
	// DW:
	// 		direkt links und oben auf anzeige + 12 zwischenraum
	// 		breite iiWidth, unter beachtung mindestbreite
	// 		h$$HEX1$$f600$$ENDHEX$$he iiMaxHeight - y-position
	// --------------------------------------------------
	case 91

			// erstmal sicherstellen, dass bei den breiten kein bl$$HEX1$$f600$$ENDHEX$$dsinn eingegeben wurde (labelbreite hat vorrang)
			if llLabelWidth + llValueWidth + 4 <> this.iiWidth then llValueWidth = this.iiWidth - llLabelWidth - 4
			if llValueWidth < 0 then
				llLabelWidth += llValueWidth
				llValueWidth = 0
			end if
			if llValueWidth < 100 and llLabelWidth > 200 then
				llValueWidth += 100
				llLabelWidth -= 100
			end if

			// die anzeige (geht hier nicht wegen platz)
			sle_back.visible = false

			// bild anzeige (geht hier nicht wegen platz)
			p_back.visible = false

			// anzeige innen
			sle_value.x = llLabelWidth + 4
			sle_value.y = this.iiObenY
			sle_value.width =  llValueWidth
			sle_value.height = llHeightDropdownButton + 13
			sle_value.border = true
			sle_value.BringToTop = true

			// der button (rechts in die anzeige eingepasst und schatten weg)
			st_open_close.x = 0
			st_open_close.y = 0
			st_open_close.width = 0
			st_open_close.height = 0
			st_open_close.visible = false
			
			pb_open_close.width = llWidthDropdownButton
			pb_open_close.height = llHeightDropdownButton
			pb_open_close.x = sle_value.x + sle_value.width - (pb_open_close.width + 9)
			pb_open_close.y = sle_value.y + 6
			pb_open_close.BringToTop = true
			pb_open_close.picturename = lsDropdownPicture

			// der feldtitel
			if llLabelHeight > sle_value.height then llLabelHeight = sle_value.height
			st_value_label.x = 0
			st_value_label.y = sle_value.y + (truncate((sle_value.height - llLabelHeight) / 2, 0))
			st_value_label.width = llLabelWidth
			st_value_label.height = llLabelHeight
			st_value_label.Alignment = Right!
			st_value_label.visible = true

			// das datawindow
			dw_uo1.x = 0
			dw_uo1.y = sle_value.y + sle_value.height + 12
			dw_uo1.width = llWidthDW 
			dw_uo1.height = this.iiMaxHeight - dw_uo1.y
			
			// der button im DW
			pb_toggle_all.x = dw_uo1.x + 192
			pb_toggle_all.y = dw_uo1.y + 16
			pb_toggle_all.width = 69
			pb_toggle_all.height = 60
			// und sein schatten
			st_toggle_all.x = pb_toggle_all.x - 5
			st_toggle_all.y = pb_toggle_all.y - 4
			st_toggle_all.width = pb_toggle_all.width + 9
			st_toggle_all.height = pb_toggle_all.height + 8

	// --------------------------------------------------
	// Standard: 
	// 		button, titel, anzeige nebeneinander (1029 breit; 4 dazwischen)
	// 		auswahl-dw darunter
	// --------------------------------------------------
	case else

			// der button und sein schatten
			st_open_close.x = 942
			st_open_close.y = 0
			st_open_close.width = 105
			st_open_close.height = 96
			
			pb_open_close.x = 946
			pb_open_close.y = 4
			pb_open_close.width = 96
			pb_open_close.height = 88
						
			// anzeige
			sle_back.x = 0
			sle_back.y = 0
			sle_back.width = 928
			sle_back.height = 96

			// bild anzeige
			p_back.x = 14
			p_back.y = 16
			p_back.width = 73
			p_back.height = 64
			p_back.BringToTop = true
			
			// anzeige innen
			sle_value.x = 101
			sle_value.y = 20
			sle_value.width = 814
			sle_value.height = 64
			sle_value.BringToTop = true

			// der feldtitel (bis 284)
			st_value_label.x = 110
			st_value_label.y = 28
			st_value_label.width = 174
			st_value_label.height = 52 
			st_value_label.Alignment = Right!
			st_value_label.visible = false
		
			// das datawindow
			dw_uo1.x = 0
			dw_uo1.y = 108
			dw_uo1.width = 1042 
			dw_uo1.height = 804
			
			// der button im DW
			pb_toggle_all.x = 192
			pb_toggle_all.y = 124
			pb_toggle_all.width = 69
			pb_toggle_all.height = 60
			// und sein schatten
			st_toggle_all.x = 187
			st_toggle_all.y = 120
			st_toggle_all.width = 78
			st_toggle_all.height = 68

end choose

// titel dr$$HEX1$$fc00$$ENDHEX$$ber hat zwei varianten, die sich nur in der position des titels unterscheiden, deshalb hier die anpassung
if alLayoutNr = 2 then 
	st_value_label.x = sle_back.x
	if st_value_label.width > sle_back.width then st_value_label.width = sle_back.width
end if

// Schleppnetz: wenn minheight zu gross, dann runtersetzen
if dw_uo1.y >= this.iiMinHeight - 5 then
	this.iiMinHeight = dw_uo1.y - 6
end if

// der $$HEX1$$e400$$ENDHEX$$ussere rahmen
this.width = dw_uo1.x + dw_uo1.width

this.of_close()

return 0

end function

public function long of_set_layout (long allayoutnr);
/* 
* Funktion:			of_set_layout (public)
* Beschreibung: 	setze die layout-kennung neu
* Besonderheit: 	
*
* Argumente:
* 	alLayoutNr 			Layout-kennung, die gesetzt werden soll
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			03.02.2011	Erstellung
*
* Return Codes:
*	 0	immer
*
*/

// hilfsvariable
Long 	llRet

this.ilLayoutNr = alLayoutNr
llRet = this.of_layout(this.ilLayoutNr)

return 0

end function

public function long of_resize ();
/* 
* Funktion:			of_resize (public)
* Beschreibung: 	veranlasse das userobjekt, das layout neu zu berechnen
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			03.02.2011	Erstellung
*
* Return Codes:
*	 0	immer
*
*/

// hilfsvariable
Long 	llRet

llRet = this.of_layout(this.ilLayoutNr)

return 0

end function

public function long of_set_backcolor (long alcolor);
/* 
* Funktion:			of_set_backcolor (public)
* Beschreibung: 	setzt die hintergrundfarbe (f$$HEX1$$fc00$$ENDHEX$$r anpassung an umgebung, in die eingebettet wird)
* Besonderheit: 	
*
* Argumente:
* 	alColor		die farbe
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			???				xx.xx.xxxx	Erstellung
*
* Return Codes:
*	 0	immer
*
*/


// hilfsvariable

this.BackColor = alColor
this.st_value_label.BackColor = alColor

return 0

end function

public function long of_init (boolean abonlyonecode);
/* 
* Funktion:			of_init (public)
* Beschreibung: 	das userobject initialisieren
* Besonderheit: 	hier zun$$HEX1$$e400$$ENDHEX$$chst den Schalter setzen, dann weiter in die eigentliche routine
*
* Argumente:
* 	abOnlyOneCode		Schalter, ob nur ein Wert oder mehrere ausgew$$HEX1$$e400$$ENDHEX$$hlt werden d$$HEX1$$fc00$$ENDHEX$$rfen
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		03.02.2011		Erstellung
*
* Return Codes:
*	 1	immer
*
*/


if abOnlyOneCode then
	this.iiOnlyOneCode = 1
else
	this.iiOnlyOneCode = 0
end if

return this.of_init()

end function

public function long of_init (boolean abonlyonecode, string assection);
/* 
* Funktion:			of_init (public)
* Beschreibung: 	das userobject initialisieren
* Besonderheit: 	hier zun$$HEX1$$e400$$ENDHEX$$chst den Schalter setzen, dann weiter in die eigentliche routine
*
* Argumente:
* 	abOnlyOneCode		Schalter, ob nur ein Wert oder mehrere ausgew$$HEX1$$e400$$ENDHEX$$hlt werden d$$HEX1$$fc00$$ENDHEX$$rfen
* 	asSection				Section im profile
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		03.02.2011		Erstellung
*
* Return Codes:
*	 1	immer
*
*/


if abOnlyOneCode then
	this.iiOnlyOneCode = 1
else
	this.iiOnlyOneCode = 0
end if
this.isSection = asSection

return this.of_init()

end function

public function long of_change (boolean abonlyonecode);
/* 
* Funktion:			of_change (public)
* Beschreibung: 	Schalter, ob nur einer oder mehrere Werte ausgew$$HEX1$$e400$$ENDHEX$$hlt werden d$$HEX1$$fc00$$ENDHEX$$rfen, wurde ge$$HEX1$$e400$$ENDHEX$$ndert
* Besonderheit: 	
*
* Argumente:
* 	abOnlyOneCode		Schalter, ob nur ein Wert oder mehrere ausgew$$HEX1$$e400$$ENDHEX$$hlt werden d$$HEX1$$fc00$$ENDHEX$$rfen
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			08.02.2011	Erstellung
*
* Return Codes:
*	 1	immer
*
*/


// hilfsvariable
Long 		llRet, llRow, llFound = 0

// nur noch ein Wert erlaubt
if abOnlyOneCode then
	this.iiOnlyOneCode = 1
	pb_toggle_all.visible = false
	st_toggle_all.visible = false
	// wenn aktuell mehr als ein Wert ausgew$$HEX1$$e400$$ENDHEX$$hlt: anpassen
	for llRow = dw_uo1.RowCount() to 1 step -1
		if dw_uo1.GetItemNumber(llRow, "nselected") =  1 then
			llFound = llRow
			exit
		end if
	next
	if llFound > 0 then llRet = of_values(llFound)
	
// jetzt mehr als ein Wert erlaubt
else
	this.iiOnlyOneCode = 0
	st_toggle_all.visible = true
	pb_toggle_all.visible = true
end if

return 1

end function

on uo_select_simple.create
this.st_value_label=create st_value_label
this.p_back=create p_back
this.pb_toggle_all=create pb_toggle_all
this.sle_value=create sle_value
this.st_open_close=create st_open_close
this.st_toggle_all=create st_toggle_all
this.dw_uo1=create dw_uo1
this.sle_back=create sle_back
this.pb_open_close=create pb_open_close
this.Control[]={this.st_value_label,&
this.p_back,&
this.pb_toggle_all,&
this.sle_value,&
this.st_open_close,&
this.st_toggle_all,&
this.dw_uo1,&
this.sle_back,&
this.pb_open_close}
end on

on uo_select_simple.destroy
destroy(this.st_value_label)
destroy(this.p_back)
destroy(this.pb_toggle_all)
destroy(this.sle_value)
destroy(this.st_open_close)
destroy(this.st_toggle_all)
destroy(this.dw_uo1)
destroy(this.sle_back)
destroy(this.pb_open_close)
end on

event destructor;
/* 
* Event: 				destructor
* Beschreibung: 	aufr$$HEX1$$e400$$ENDHEX$$umen
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			???			??.??.????		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		13.12.2010		angepasst f$$HEX1$$fc00$$ENDHEX$$r Werte
*	1.2 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		09.08.2011		GetItem in zeile 30 korrigiert
*
* Return Codes:
*	0		continue  (PB)
*
*/

// hilfsvariable
Long 		llRow
String 	lsCode = ""

// ggf. timer stoppen
if IsValid (uoTimer) then uoTimer.Stop()

// aktuell ausgew$$HEX1$$e400$$ENDHEX$$hlte(n) Wert(e) im profile merken
if this.isSection <> "" then
	for llRow = 1 to dw_uo1.RowCount()
		if dw_uo1.GetItemNumber(llRow, "nselected") = 1 then
			lsCode += string(dw_uo1.GetItemString(llRow, this.isStringKey)) + ";"
		end if
	next
	f_setProfilestring(this.isSection , this.isSectionValue, lsCode)
end if

// ggf. timer aufr$$HEX1$$e400$$ENDHEX$$umen
if IsValid (uoTimer) then destroy uoTimer

return 0

end event

event constructor;
/* 
* Event: 				constructor
* Beschreibung: 	
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		13.12.2010		Erstellung
*
* Return Codes:
*	0		continue  (PB)
*
*/

// hilfsvariable
Long 	llRet

// --------------------------------------------------
// der teil, der wirklich nur einmal laufen soll
// --------------------------------------------------

// titel setzen
st_value_label.text = isLabelText

// dataobject setzen
if trim(this.isDataobject) <> "" then dw_uo1.dataobject = this.isDataobject
// $$HEX1$$fc00$$ENDHEX$$bersetzen
uf.translate_datawindow(dw_uo1)	
// datenbank-anbindung und lesen
dw_uo1.SetTransObject(sqlca)

// ggf. layout anpassen
if this.ilLayoutNr <> 0 then llRet = this.of_layout(this.ilLayoutNr)

// --------------------------------------------------
// der teil, der nach parameter-$$HEX1$$e400$$ENDHEX$$nderungen erneut laufen kann
// --------------------------------------------------
llRet = this.of_get_user_settings()
llRet = this.of_init()

// --------------------------------------------------
// und noch ein teil, der wirklich nur einmal laufen soll
// --------------------------------------------------
if not IsValid(uoTimer) then
	uoTimer = Create uo_select_simple_timer 
	uoTimer.uoParent = this
end if

this.of_values(0)

return 0

end event

type st_value_label from statictext within uo_select_simple
boolean visible = false
integer x = 110
integer y = 28
integer width = 338
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Werte:"
alignment alignment = right!
boolean focusrectangle = false
end type

type p_back from picture within uo_select_simple
integer x = 14
integer y = 16
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "Custom081!"
boolean focusrectangle = false
end type

type pb_toggle_all from picturebutton within uo_select_simple
integer x = 192
integer y = 124
integer width = 69
integer height = 60
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\resource\downarrow_small.gif"
alignment htextalign = left!
end type

event clicked;
/* 
* Event: 				pb_toggle_all.clicked
* Beschreibung: 	alle betriebe selektieren bzw. de-selektieren
* Besonderheit: 	da dieser button gar nicht verf$$HEX1$$fc00$$ENDHEX$$gbar sein sollte, wenn nur ein betrieb selektiert werden darf, 
* 								ist parameter 0 f$$HEX1$$fc00$$ENDHEX$$r of_values hier OK!!
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
* 	1.0 			???			xx.xx.xxxx		Erstellung
* 
* Return Codes:
*	0		continue  (PB)
*
*/

// hilfsvariable
Long llRet, llRow

// den schalter pflegen, der aussagt, was gemacht werden soll: an oder aus...
if parent.iiAll = 1 then 
	parent.iiAll = 0 
else
	parent.iiAll = 1
end if 

// jetzt die eigentliche aktion
for llRow = 1 to dw_uo1.RowCount()
	dw_uo1.SetItem(llRow, "nselected", parent.iiAll)
next

// das ergebnis bereitstellen (oberfl$$HEX1$$e400$$ENDHEX$$che & werte)
llRet = parent.of_values(0)
parent.trigger event ue_execute()

return 0

end event

type sle_value from singlelineedit within uo_select_simple
integer x = 101
integer y = 20
integer width = 814
integer height = 64
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Alle"
boolean border = false
boolean displayonly = true
end type

type st_open_close from statictext within uo_select_simple
integer x = 942
integer width = 105
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_toggle_all from statictext within uo_select_simple
integer x = 187
integer y = 120
integer width = 78
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_uo1 from datawindow within uo_select_simple
event ue_key pbm_dwnkey
integer y = 108
integer width = 1042
integer height = 804
integer taborder = 10
string title = "none"
string dataobject = "dw_uo_select_packing_status"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_key;
String sFind
long lFound
long lRow

// ----------------------------------------------
// Keine Daten im DW ??? Dann machen wir nix
// ----------------------------------------------
if this.RowCount() <= 0 then
	return
end if

// ----------------------------------------------
// KeyMapping
// ----------------------------------------------
CHOOSE CASE key
	CASE KeyA!
		sFind = "A"
	CASE KeyB!
		sFind = "B"
	CASE KeyC!
		sFind = "C"
	CASE KeyD!
		sFind = "D"
	CASE KeyE!
		sFind = "E"
	CASE KeyF!
		sFind = "F"
	CASE KeyG!
		sFind = "G"
	CASE KeyH!
		sFind = "H"
	CASE KeyI!
		sFind = "I"
	CASE KeyJ!
		sFind = "J"
	CASE KeyK!
		sFind = "K"
	CASE KeyL!
		sFind = "L"
	CASE KeyM!
		sFind = "M"
	CASE KeyN!
		sFind = "N"
	CASE KeyO!
		sFind = "O"
	CASE KeyP!
		sFind = "P"
	CASE KeyQ!
		sFind = "Q"
	CASE KeyR!
		sFind = "R"
	CASE KeyS!
		sFind = "S"
	CASE KeyT!
		sFind = "T"
	CASE KeyU!
		sFind = "U"
	CASE KeyV!
		sFind = "V"
	CASE KeyW!
		sFind = "W"
	CASE KeyX!
		sFind = "X"
	CASE KeyY!
		sFind = "Y"
	CASE KeyZ!
		sFind = "Z"
END CHOOSE

// ----------------------------------------------
// Suche starten
// ----------------------------------------------
if len(sFind) > 0 then

	lRow = this.GetRow() + 1
	// ----------------------------------------------
	// Suchen ab der aktuellen Position
	// ----------------------------------------------
	lFound = this.Find("Mid(" + isStringKey + ",1, " + String(len(sFind)) + ") = '" + sFind + "'" , lRow, this.RowCount()) 
	if lFound > 0 then
		this.ScrollToRow(lFound)
	else
	// ----------------------------------------------
	// Ab der aktuellen Position nix gefunden
	// Suche von oben starten
	// ----------------------------------------------
		lRow = 1
		lFound = this.Find("Mid(" + isStringKey + ",1, " + String(len(sFind)) + ") = '" + sFind + "'" , lRow, this.RowCount()) 
		if lFound > 0 then
			this.ScrollToRow(lFound)
		else
			Beep(1)
		end if
	end if
		
end if

return 0
		
		
end event

event clicked;
if row > 0 then 
	this.ScrollToRow(row)
	//of_values()
end if
end event

event itemchanged;
/*
* Event: 				itemchanged
* Beschreibung: 	
* Besonderheit: 	
*
* Argument(e):
*	row	akuelle zeile (PB)
*	dwo	akuelles objekt (PB)
*	data	neuer inhalt (PB)
*
* Aenderungshistorie:
* Version 	Wer			Wann			Was und warum
* 1.0			M.N$$HEX1$$fc00$$ENDHEX$$ndel		02.02.2011	Erstellung
*
*
* Return Codes:
* 	0  (Default) Accept the data value (PB)
* 	1  Reject the data value and do not allow focus to change (PB)
* 	2  Reject the data value but allow the focus to change (PB)
*
*/

// hilfsvariable
Long 	llRet

// keine zeile macht keinen sinn: raus
if row = 0 then return 0

// zuerst pr$$HEX1$$fc00$$ENDHEX$$fungen erlauben, die den change ggf. unterbinden:
llRet = parent.event dw_itemchanged_start(row, dwo, data)
if llRet <> 0 then return llRet

// alles nur, wenn was an- oder abgew$$HEX1$$e400$$ENDHEX$$hlt wurde
if dwo.name='nselected' then
	parent.post event dw_itemchanged(row, dwo, data)
	post of_values(row) 
	parent.post event ue_execute()
end if

return 0

end event

event losefocus;
/*
* Event: 				losefocus
* Beschreibung: 	
* Besonderheit: 	
*
* Argument(e):
*
* Aenderungshistorie:
* Version 	Wer			Wann			Was und warum
* 1.0			M.N$$HEX1$$fc00$$ENDHEX$$ndel		08.02.2011	Erstellung
*
*
* Return Codes:
* 	0  continue processing (PB)
*
*/

// soll das "dropdown" sofort geschlossen werden ?
// in der regel nicht, das ist zu schnell f$$HEX1$$fc00$$ENDHEX$$r mehrfachauswahl...
if ibCloseOnLoseFocus then parent.of_close()

return 0

end event

type sle_back from singlelineedit within uo_select_simple
integer width = 928
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type pb_open_close from picturebutton within uo_select_simple
integer x = 946
integer y = 4
integer width = 105
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\downarrow.gif"
string disabledname = "..\Resource\downarrow.gif"
alignment htextalign = left!
end type

event clicked;
/* 
* Event: 				pb_open_close.clicked
* Beschreibung: 	auswahl-DW zeigen oder eben nicht
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
* 	1.0 			???			xx.xx.xxxx		Erstellung
* 
* Return Codes:
*	0		continue  (PB)
*
*/

// hilfsvariable

// vorsichtshalber immer wieder in den vordergrund 
// (es k$$HEX1$$f600$$ENDHEX$$nnte was anderes zwischendrin angesprochen worden sein)
if parent.ibBringToTop then parent.SetPosition(ToTop!)

if parent.iiElapse = 0 then 
	// den schalter pflegen, der aussagt, was gemacht werden soll: auf oder zu...
	parent.iiElapse = 1 
	// aufklappen: h$$HEX1$$f600$$ENDHEX$$he setzen
	parent.height = parent.iiMaxHeight
	// aufklappen: timer starten, der kontrolliert, dass irgendwann wieder geschlossen wird
	if isvalid(uoTimer) then uoTimer.Start(1)
else
	// den schalter pflegen, der aussagt, was gemacht werden soll: auf oder zu...
	parent.iiElapse = 0
	// zuklappen: h$$HEX1$$f600$$ENDHEX$$he setzen
	parent.height = parent.iiMinHeight
	// zuklappen: timer stoppen, wird jetzt ja nicht mehr gebraucht
	if isvalid(uoTimer) then uoTimer.Stop()
end if 

return 0

end event

