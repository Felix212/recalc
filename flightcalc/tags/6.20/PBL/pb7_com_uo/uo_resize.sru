HA$PBExportHeader$uo_resize.sru
$PBExportComments$userobject, welches genutzt werden kann, um windows mitsamt seinen controls resizable zu machen
forward
global type uo_resize from nonvisualobject
end type
end forward

global type uo_resize from nonvisualobject
end type
global uo_resize uo_resize

type variables

protected:

/*--- ausgangsgr$$HEX1$$f600$$ENDHEX$$sse des workspace, der resized wurde ---*/
integer ii_width, ii_height

/*--- mindestgr$$HEX1$$f600$$ENDHEX$$sse des FENSTERS(!!), das resized wurde ---*/
long il_minwidth = 0, il_minheight = 0

/*--- fenster, um das sich alles dreht ---*/
window iw_win

/*--- Objekte mit Resize-Funktionalit$$HEX1$$e400$$ENDHEX$$t ---*/
s_0_resize	istr_2resize[]




/*--- ausgangsgr$$HEX1$$f600$$ENDHEX$$sse des tabs, der resized wurde ---*/
/*--- wenn das genutzt werden soll, muss es gesetzt werden !! ---*/
integer ii_tab_width, ii_tab_height
tab itab_tab




/*-------------------------------------------------------------------
"Bedienungsanleitung":
f$$HEX1$$fc00$$ENDHEX$$r den generellen window-resize:

instance-variable deklarieren, 
object im open-event des Fensters kreieren,
zu verschiebende objekte dazu im open-event des Fensters registrieren (s.u.),
im close-event zerst$$HEX1$$f600$$ENDHEX$$ren
im resize-event des Fensters <object>.of_resizecontrols(this) eintragen
(dieses k$$HEX1$$f600$$ENDHEX$$nnte in den wurzel-fenstern einmalig passieren)

-------------------------------------------------
"Bedienungsanleitung":
f$$HEX1$$fc00$$ENDHEX$$r alleinigen (oder zus$$HEX1$$e400$$ENDHEX$$tzlichen) tab-resize (bei split-bar zwischen tab und anderen objekten beispielsweise n$$HEX1$$f600$$ENDHEX$$tig):

instance-variable deklarieren, 
object im open-event des Fensters kreieren, 
tab initialisieren (s.u.),
zu verschiebende objekte dazu im open-event des Fensters registrieren (s.u.),
im close-event zerst$$HEX1$$f600$$ENDHEX$$ren
im resize-event des Fensters <object>.of_init_tab(<tab>, <tab>.width, <tab>.height) eintragen
	(damit immer die "richtigen" ausgangsabmessungen vorliegen)
in lbuttonup-event der split-bar <object>.of_resizecontrols_tab(<tab>) eintragen
	(damit nach verschieben immer angepasst wird)

-------------------------------------------------

im open-event (oder post-open-event) die controls registrieren, die sich bewegen/anpassen sollen:
<object>.of_set_resize(<control>, schalter hoehe, schalter breite, schalter x, schalter y, schalter midx, schalter midy)
<object>.of_set_resize(<control>, schalter hoehe, schalter breite, schalter x, schalter y)
<object>.of_set_resize(<control>, schalter hoehe, schalter breite)

ACHTUNG:
Bei tabs NICHT die tabpages eintragen, das macht probleme! Nur das tab selber und die objekte auf den tabpages registrieren.

-------------------------------------------------
Beispiele fenster:

uoResize.of_set_resize(tab_1, true, true)
(das haupttab im fenster soll in h$$HEX1$$f600$$ENDHEX$$he und breite mitwachsen)

uoResize.of_set_resize(tab_1.tabpage_2.dw_header, false, true)
uoResize.of_set_resize(tab_1.tabpage_2.dw_2, true, true)
(beide dws ver$$HEX1$$e400$$ENDHEX$$ndern parallel die breite, aber das obere bleibt in der h$$HEX1$$f600$$ENDHEX$$he statisch, w$$HEX1$$e400$$ENDHEX$$hrend das untere sich anpasst)


uoResize.of_set_resize(pb_save, false, false, true, false)
(der knopf soll sich nur horizontal mitbewegen)

uoResize.of_set_resize(pb_exit, false, false, true, true)
(der knopf soll sich horizontal und vertikal mitbewegen, er ist nach unten ausgerichtet)
-------------------------------------------------
Beispiel tab:

uoResizeTab.of_init_tab(tab_1, tab_1.width, tab_1.height)
(immer erst initialisieren)

alle Elemente zu tab_1, die im fenster-resize eingetragen sind, sollten auch hier entsprechend erscheinen:

uoResizeTab.of_set_resize(tab_1, true, true)
(das haupttab im fenster soll in h$$HEX1$$f600$$ENDHEX$$he und breite mitwachsen)

uoResizeTab.of_set_resize(tab_1.tabpage_2.dw_header, false, true)
uoResizeTab.of_set_resize(tab_1.tabpage_2.dw_2, true, true)
(beide dws ver$$HEX1$$e400$$ENDHEX$$ndern parallel die breite, aber das obere bleibt in der h$$HEX1$$f600$$ENDHEX$$he statisch, w$$HEX1$$e400$$ENDHEX$$hrend das untere sich anpasst)

-------------------------------------------------------------------*/

end variables

forward prototypes
public function long of_set_h2resize (dragobject ado_2set, integer ai_h2set)
public function long of_set_h2resize (dragobject ado_2set)
public function long of_set_w2resize (dragobject ado_2set, integer ai_w2set)
public function long of_set_w2resize (dragobject ado_2set)
public function long of_set_x2resize (dragobject ado_2set, integer ai_x2set)
public function long of_set_x2resize (dragobject ado_2set)
public function long of_set_y2resize (dragobject ado_2set, integer ai_y2set)
public function long of_set_y2resize (dragobject ado_2set)
public function long of_unset_h2resize (dragobject ado_2set)
public function long of_unset_w2resize (dragobject ado_2set)
public function long of_unset_x2resize (dragobject ado_2set)
public function long of_unset_y2resize (dragobject ado_2set)
public function long of_unset_midx2resize (dragobject ado_2set)
public function long of_unset_midy2resize (dragobject ado_2set)
public function long of_resizecontrols (window aw_win)
public function long of_resizecontrols ()
public function integer of_set_resize (dragobject ado_2set, boolean ab_h2set, boolean ab_w2set, boolean ab_x2set, boolean ab_y2set, boolean ab_midx2set, boolean ab_midy2set, integer ai_w2set, integer ai_x2set, integer ai_h2set, integer ai_y2set)
public function integer of_set_resize (dragobject ado_2set, boolean ab_h2set, boolean ab_w2set, boolean ab_x2set, boolean ab_y2set, boolean ab_midx2set, boolean ab_midy2set, integer ai_w2set, integer ai_x2set)
public function integer of_set_resize (dragobject ado_2set, boolean ab_h2set, boolean ab_w2set, boolean ab_x2set, boolean ab_y2set, boolean ab_midx2set, boolean ab_midy2set)
public function integer of_set_resize (dragobject ado_2set, boolean ab_h2set, boolean ab_w2set, boolean ab_x2set, boolean ab_y2set)
public function integer of_set_resize (dragobject ado_2set, boolean ab_h2set, boolean ab_w2set)
public function integer of_unset_resize (dragobject ado_2set)
public function long of_set_midx2resize (dragobject ado_2set)
public function long of_set_midy2resize (dragobject ado_2set)
public function long of_set_minheight (long al_minheight)
public function long of_set_minwidth (long al_minwidth)
public function long of_init_tab (tab atab2resize, integer alwidth, integer alheight)
public function long of_resizecontrols_tab (tab atab_tab)
end prototypes

public function long of_set_h2resize (dragobject ado_2set, integer ai_h2set);
/* 
* Funktion:			of_set_h2resize
* Beschreibung: 	control soll in der H$$HEX1$$f600$$ENDHEX$$he angepasst werden
*
* Besonderheit: 	
*
* Argumente:
*	ado_2set		control
*	ai_h2set		faktor, um wieviel prozent der $$HEX1$$e400$$ENDHEX$$nderung die h$$HEX1$$f600$$ENDHEX$$he angepasst werden soll
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

// variable
long ll_rc = 0  // returncode
long ll_i       // laufvariable

// plausi: faktor muss zwischen 1 und 100 prozent liegen
// messagebox, weil entwickler-adressiert...
if ai_h2set < 1 OR ai_h2set > 100 THEN 
	Messagebox("","Invalid resize-height-faktor: " + string(ai_h2set) + " for " + ado_2set.classname())
end if

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle schon vorhandenen eintr$$HEX1$$e400$$ENDHEX$$ge STRUKTUR
FOR ll_i = 1 TO Upperbound(istr_2resize) STEP 1
     // wenn schon da, dann $$HEX1$$fc00$$ENDHEX$$berschreiben
	IF istr_2resize[ll_i].do2resize = ado_2set THEN
		istr_2resize[ll_i].ih2resize = ai_h2set
		istr_2resize[ll_i].bh2resize = TRUE
		ll_rc = ll_i
		EXIT
	END IF
NEXT

// noch nicht da: eintragen in STRUKTUR
IF ll_rc = 0 THEN
	ll_rc = Upperbound(istr_2resize) + 1
	istr_2resize[ll_rc].do2resize = ado_2set
	istr_2resize[ll_rc].bh2resize = TRUE
	istr_2resize[ll_rc].bw2resize = FALSE
	istr_2resize[ll_rc].bx2resize = FALSE
	istr_2resize[ll_rc].by2resize = FALSE
	istr_2resize[ll_rc].bmidx2resize = FALSE
	istr_2resize[ll_rc].bmidy2resize = FALSE
	istr_2resize[ll_rc].ih2resize = ai_h2set
	istr_2resize[ll_rc].iw2resize = 100
	istr_2resize[ll_rc].ix2resize = 100
	istr_2resize[ll_rc].iy2resize = 100
END IF

return ll_rc

end function

public function long of_set_h2resize (dragobject ado_2set);
/* 
* Funktion:			of_set_h2resize
* Beschreibung: 	control soll in der H$$HEX1$$f600$$ENDHEX$$he angepasst werden
*
* Besonderheit: 	das hier ist nur eine umleitung in die eigentliche Funktion
*						f$$HEX1$$fc00$$ENDHEX$$r den Fall, dass sie mit weniger Parameter aufgerufen wird
*
* Argumente:
*	ado_2set		control
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Erstellung
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

return of_set_h2resize(ado_2set, 100)

end function

public function long of_set_w2resize (dragobject ado_2set, integer ai_w2set);
/* 
* Funktion:			of_set_w2resize
* Beschreibung: 	control soll in der Breite angepasst werden
*
* Besonderheit: 	
*
* Argumente:
*	ado_2set		control
*	ai_w2set		faktor, um wieviel prozent der $$HEX1$$e400$$ENDHEX$$nderung die breite angepasst werden soll
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

// variable
long ll_rc = 0  // returncode
long ll_i       // laufvariable

// plausi: faktor muss zwischen 1 und 100 prozent liegen
// messagebox, weil entwickler-adressiert...
if ai_w2set < 1 OR ai_w2set > 100 THEN 
	Messagebox("","Invalid resize-width-faktor: " + string(ai_w2set) + " for " + ado_2set.classname())
end if

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle schon vorhandenen eintr$$HEX1$$e400$$ENDHEX$$ge STRUKTUR
FOR ll_i = 1 TO Upperbound(istr_2resize) STEP 1
	// wenn schon da, dann $$HEX1$$fc00$$ENDHEX$$berschreiben
	IF istr_2resize[ll_i].do2resize = ado_2set THEN
		istr_2resize[ll_i].bw2resize = TRUE
		istr_2resize[ll_rc].iw2resize = ai_w2set
		ll_rc = ll_i
		EXIT
	END IF
NEXT

// noch nicht da: eintragen in STRUKTUR
IF ll_rc = 0 THEN
	ll_rc = Upperbound(istr_2resize) + 1
	istr_2resize[ll_rc].do2resize = ado_2set
	istr_2resize[ll_rc].bh2resize = FALSE
	istr_2resize[ll_rc].bw2resize = TRUE
	istr_2resize[ll_rc].bx2resize = FALSE
	istr_2resize[ll_rc].by2resize = FALSE
	istr_2resize[ll_rc].bmidx2resize = FALSE
	istr_2resize[ll_rc].bmidy2resize = FALSE
	istr_2resize[ll_rc].ih2resize = 100
	istr_2resize[ll_rc].iw2resize = ai_w2set
	istr_2resize[ll_rc].ix2resize = 100
	istr_2resize[ll_rc].iy2resize = 100
END IF

return ll_rc

end function

public function long of_set_w2resize (dragobject ado_2set);
/* 
* Funktion:			of_set_w2resize
* Beschreibung: 	control soll in der Breite angepasst werden
*
* Besonderheit: 	das hier ist nur eine umleitung in die eigentliche Funktion
*						f$$HEX1$$fc00$$ENDHEX$$r den Fall, dass sie mit weniger Parameter aufgerufen wird
*
* Argumente:
*	ado_2set		control
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Erstellung
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

return of_set_w2resize(ado_2set, 100)

end function

public function long of_set_x2resize (dragobject ado_2set, integer ai_x2set);
/* 
* Funktion:			of_set_x2resize
* Beschreibung: 	control soll horizontal angepasst werden
*
* Besonderheit: 	horizontal mittig anpassen wird ggf. abgeschaltet
*
* Argumente:
*	ado_2set		control
*	ai_x2set		faktor, um wieviel prozent der $$HEX1$$e400$$ENDHEX$$nderung die horizontale position angepasst werden soll
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

// variable
long ll_rc = 0  // returncode
long ll_i       // laufvariable

// plausi: faktor muss zwischen 1 und 100 prozent liegen
// messagebox, weil entwickler-adressiert...
if ai_x2set < 1 OR ai_x2set > 100 THEN 
	Messagebox("","Invalid resize-x-faktor: " + string(ai_x2set) + " for " + ado_2set.classname())
end if

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle schon vorhandenen eintr$$HEX1$$e400$$ENDHEX$$ge STRUKTUR
FOR ll_i = 1 TO Upperbound(istr_2resize) STEP 1
	// wenn schon da, dann $$HEX1$$fc00$$ENDHEX$$berschreiben
	IF istr_2resize[ll_i].do2resize = ado_2set THEN
		istr_2resize[ll_i].bx2resize = TRUE
		istr_2resize[ll_rc].ix2resize = ai_x2set
		istr_2resize[ll_i].bmidx2resize = FALSE
		ll_rc = ll_i
		EXIT
	END IF
NEXT

// noch nicht da: eintragen in STRUKTUR
IF ll_rc = 0 THEN
	ll_rc = Upperbound(istr_2resize) + 1
	istr_2resize[ll_rc].do2resize = ado_2set
	istr_2resize[ll_rc].bh2resize = FALSE
	istr_2resize[ll_rc].bw2resize = FALSE
	istr_2resize[ll_rc].bx2resize = TRUE
	istr_2resize[ll_rc].by2resize = FALSE
	istr_2resize[ll_rc].bmidx2resize = FALSE
	istr_2resize[ll_rc].bmidy2resize = FALSE
	istr_2resize[ll_rc].ih2resize = 100
	istr_2resize[ll_rc].iw2resize = 100
	istr_2resize[ll_rc].ix2resize = ai_x2set
	istr_2resize[ll_rc].iy2resize = 100
END IF

return ll_rc

end function

public function long of_set_x2resize (dragobject ado_2set);
/* 
* Funktion:			of_set_x2resize
* Beschreibung: 	control soll horizontal angepasst werden
*
* Besonderheit: 	horizontal mittig anpassen wird ggf. abgeschaltet
* 						das hier ist nur eine umleitung in die eigentliche Funktion
*						f$$HEX1$$fc00$$ENDHEX$$r den Fall, dass sie mit weniger Parameter aufgerufen wird
*
* Argumente:
*	ado_2set		control
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Erstellung
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

return of_set_x2resize(ado_2set, 100)

end function

public function long of_set_y2resize (dragobject ado_2set, integer ai_y2set);
/* 
* Funktion:			of_set_y2resize
* Beschreibung: 	control soll vertikal angepasst werden
*
* Besonderheit: 	vertikal mittig anpassen wird ggf. abgeschaltet
*
* Argumente:
*	ado_2set		control
*	ai_y2set		faktor, um wieviel prozent der $$HEX1$$e400$$ENDHEX$$nderung die vertikale position angepasst werden soll
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

// variable
long ll_rc = 0  // returncode
long ll_i       // laufvariable

// plausi: faktor muss zwischen 1 und 100 prozent liegen
// messagebox, weil entwickler-adressiert...
if ai_y2set < 1 OR ai_y2set > 100 THEN 
	Messagebox("","Invalid resize-y-faktor: " + string(ai_y2set) + " for " + ado_2set.classname())
end if

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle schon vorhandenen eintr$$HEX1$$e400$$ENDHEX$$ge STRUKTUR
FOR ll_i = 1 TO Upperbound(istr_2resize) STEP 1
	// wenn schon da, dann $$HEX1$$fc00$$ENDHEX$$berschreiben
	IF istr_2resize[ll_i].do2resize = ado_2set THEN
		istr_2resize[ll_i].by2resize = TRUE
		istr_2resize[ll_rc].iy2resize = ai_y2set
		istr_2resize[ll_i].bmidy2resize = FALSE
		ll_rc = ll_i
		EXIT
	END IF
NEXT

// noch nicht da: eintragen in STRUKTUR
IF ll_rc = 0 THEN
	ll_rc = Upperbound(istr_2resize) + 1
	istr_2resize[ll_rc].do2resize = ado_2set
	istr_2resize[ll_rc].bh2resize = FALSE
	istr_2resize[ll_rc].bw2resize = FALSE
	istr_2resize[ll_rc].bx2resize = FALSE
	istr_2resize[ll_rc].by2resize = TRUE
	istr_2resize[ll_rc].bmidx2resize = FALSE
	istr_2resize[ll_rc].bmidy2resize = FALSE
	istr_2resize[ll_rc].ih2resize = 100
	istr_2resize[ll_rc].iw2resize = 100
	istr_2resize[ll_rc].ix2resize = 100
	istr_2resize[ll_rc].iy2resize = ai_y2set
END IF

return ll_rc

end function

public function long of_set_y2resize (dragobject ado_2set);
/* 
* Funktion:			of_set_y2resize
* Beschreibung: 	control soll vertikal angepasst werden
*
* Besonderheit: 	vertikal mittig anpassen wird ggf. abgeschaltet
* 						das hier ist nur eine umleitung in die eigentliche Funktion
*						f$$HEX1$$fc00$$ENDHEX$$r den Fall, dass sie mit weniger Parameter aufgerufen wird
*
* Argumente:
*	ado_2set		control
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Erstellung
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

return of_set_y2resize(ado_2set, 100)

end function

public function long of_unset_h2resize (dragobject ado_2set);
/* 
* Funktion:			of_unset_h2resize
* Beschreibung: 	control soll nicht mehr in der H$$HEX1$$f600$$ENDHEX$$he angepasst werden
*
* Besonderheit: 	
*
* Argumente:
*	ado_2set		control
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

// variable
long ll_rc = 0  // returncode
long ll_i       // laufvariable

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle schon vorhandenen eintr$$HEX1$$e400$$ENDHEX$$ge STRUKTUR
FOR ll_i = 1 TO Upperbound(istr_2resize) STEP 1
     // wenn gefunden, dann $$HEX1$$e400$$ENDHEX$$ndern
	IF istr_2resize[ll_i].do2resize = ado_2set THEN
		istr_2resize[ll_i].bh2resize = FALSE
		istr_2resize[ll_i].ih2resize = 100
		ll_rc = ll_i
		EXIT
	END IF
NEXT

// nicht da: nix machen....

return ll_rc

end function

public function long of_unset_w2resize (dragobject ado_2set);
/* 
* Funktion:			of_unset_w2resize
* Beschreibung: 	control soll nicht mehr in der Breite angepasst werden
*
* Besonderheit: 	
*
* Argumente:
*	ado_2set		control
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

// variable
long ll_rc = 0  // returncode
long ll_i       // laufvariable

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle schon vorhandenen eintr$$HEX1$$e400$$ENDHEX$$ge STRUKTUR
FOR ll_i = 1 TO Upperbound(istr_2resize) STEP 1
     // wenn gefunden, dann $$HEX1$$e400$$ENDHEX$$ndern
	IF istr_2resize[ll_i].do2resize = ado_2set THEN
		istr_2resize[ll_i].bw2resize = FALSE
		istr_2resize[ll_i].iw2resize = 100
		ll_rc = ll_i
		EXIT
	END IF
NEXT

// nicht da: nix machen....

return ll_rc

end function

public function long of_unset_x2resize (dragobject ado_2set);
/* 
* Funktion:			of_unset_x2resize
* Beschreibung: 	control soll nicht mehr horizontal angepasst werden
*
* Besonderheit: 	
*
* Argumente:
*	ado_2set		control
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

// variable
long ll_rc = 0  // returncode
long ll_i       // laufvariable


// schleife $$HEX1$$fc00$$ENDHEX$$ber alle schon vorhandenen eintr$$HEX1$$e400$$ENDHEX$$ge STRUKTUR
FOR ll_i = 1 TO Upperbound(istr_2resize) STEP 1
     // wenn gefunden, dann $$HEX1$$e400$$ENDHEX$$ndern
	IF istr_2resize[ll_i].do2resize = ado_2set THEN
		istr_2resize[ll_i].bx2resize = FALSE
		istr_2resize[ll_i].ix2resize = 100
		ll_rc = ll_i
		EXIT
	END IF
NEXT

// nicht da: nix machen....

return ll_rc

end function

public function long of_unset_y2resize (dragobject ado_2set);
/* 
* Funktion:			of_unset_y2resize
* Beschreibung: 	control soll nicht mehr vertikal angepasst werden
*
* Besonderheit: 	
*
* Argumente:
*	ado_2set		control
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

// variable
long ll_rc = 0  // returncode
long ll_i       // laufvariable

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle schon vorhandenen eintr$$HEX1$$e400$$ENDHEX$$ge STRUKTUR
FOR ll_i = 1 TO Upperbound(istr_2resize) STEP 1
     // wenn gefunden, dann $$HEX1$$e400$$ENDHEX$$ndern
	IF istr_2resize[ll_i].do2resize = ado_2set THEN
		istr_2resize[ll_i].by2resize = FALSE
		istr_2resize[ll_i].iy2resize = 100
		ll_rc = ll_i
		EXIT
	END IF
NEXT

// nicht da: nix machen....

return ll_rc

end function

public function long of_unset_midx2resize (dragobject ado_2set);
/* 
* Funktion:			of_unset_midx2resize
* Beschreibung: 	control soll nicht mehr horizontal mittig angepasst werden
*
* Besonderheit: 	
*
* Argumente:
*	ado_2set		control
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

// variable
long ll_rc = 0  // returncode
long ll_i       // laufvariable

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle schon vorhandenen eintr$$HEX1$$e400$$ENDHEX$$ge STRUKTUR
FOR ll_i = 1 TO Upperbound(istr_2resize) STEP 1
     // wenn gefunden, dann $$HEX1$$e400$$ENDHEX$$ndern
	IF istr_2resize[ll_i].do2resize = ado_2set THEN
		istr_2resize[ll_i].bmidx2resize = FALSE
		istr_2resize[ll_i].ix2resize = 100
		ll_rc = ll_i
		EXIT
	END IF
NEXT

// nicht da: nix machen....

return ll_rc

end function

public function long of_unset_midy2resize (dragobject ado_2set);
/* 
* Funktion:			of_unset_midy2resize
* Beschreibung: 	control soll nicht mehr vertikal mittig angepasst werden
*
* Besonderheit: 	
*
* Argumente:
*	ado_2set		control
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

// variable
long ll_rc = 0  // returncode
long ll_i       // laufvariable

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle schon vorhandenen eintr$$HEX1$$e400$$ENDHEX$$ge STRUKTUR
FOR ll_i = 1 TO Upperbound(istr_2resize) STEP 1
     // wenn gefunden, dann $$HEX1$$e400$$ENDHEX$$ndern
	IF istr_2resize[ll_i].do2resize = ado_2set THEN
		istr_2resize[ll_i].bmidy2resize = FALSE
		istr_2resize[ll_i].iy2resize = 100
		ll_rc = ll_i
		EXIT
	END IF
NEXT

// nicht da: nix machen....

return ll_rc

end function

public function long of_resizecontrols (window aw_win);
/* 
* Funktion:			of_resizecontrols
* Beschreibung: 	controls anpassen entsprechend ihrer eintr$$HEX1$$e400$$ENDHEX$$ge im array
*
* Besonderheit: 	
*
* Argumente:
*	aw_win			betroffenes fenster
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*	1.2 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		07.09.2009		Mindestgr$$HEX1$$f600$$ENDHEX$$ssen-sperre eingebaut
*
* Return Codes:
*	-1		fehler
*	 1		alles geklappt
*/

// variable
long ll_rc = 1
integer li, li_bound
integer li_width, li_height, li_width_diff, li_height_diff, li_width_offset, li_height_offset, li_x_offset, li_y_offset

// fenster merken
iw_win = aw_win

// valid window
IF Isvalid (iw_win) THEN

	// pr$$HEX1$$fc00$$ENDHEX$$fen, ob mindestwerte unterschritten wurden, wenn vorhanden
	IF il_minwidth > 0 and iw_win.Width < il_minwidth THEN
		iw_win.Width = il_minwidth
	END IF
	IF il_minheight > 0 and iw_win.Height < il_minheight THEN
		iw_win.Height = il_minheight
	END IF

	// neue abmessungen feststellen
	li_width = WorkspaceWidth(iw_win)
	li_height = WorkspaceHeight(iw_win)
	
	// differenzen feststellen
	li_width_diff = li_width - ii_width
	li_height_diff = li_height - ii_height
	
	// not minimized
	IF iw_win.windowstate <> Minimized! THEN
		iw_win.SetRedraw(False)

		li_bound = UpperBound (istr_2resize)
		// objekt f$$HEX1$$fc00$$ENDHEX$$r objekt betrachten
		FOR li = 1 TO li_bound 
			
		// plausi: x oder midx
//			Messagebox(string(li),istr_2resize[li].do2resize.classname())
			if istr_2resize[li].bx2resize AND istr_2resize[li].bmidx2resize THEN Messagebox("X doppelt",istr_2resize[li].do2resize.classname())
			if istr_2resize[li].by2resize AND istr_2resize[li].bmidy2resize THEN Messagebox("Y doppelt",istr_2resize[li].do2resize.classname())
			
			// faktor ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
			if li_width_diff > 0 then
				li_width_offset = round(((li_width_diff * istr_2resize[li].iw2resize) / 100),0)
				li_x_offset = round(((li_width_diff*istr_2resize[li].ix2resize) / 100),0)
			else
				li_width_offset = ceiling((li_width_diff * istr_2resize[li].iw2resize) / 100)
				li_x_offset = ceiling((li_width_diff*istr_2resize[li].ix2resize) / 100)
			end if

			if li_height_diff > 0 then
				li_height_offset = round(((li_height_diff * istr_2resize[li].ih2resize) / 100), 0)
				li_y_offset = round(((li_height_diff * istr_2resize[li].iy2resize) / 100),0)
			else
				li_height_offset = ceiling((li_height_diff * istr_2resize[li].ih2resize) / 100)
				li_y_offset = ceiling((li_height_diff * istr_2resize[li].iy2resize) / 100)
			end if

			// setting the object-width/-height in verh$$HEX1$$e400$$ENDHEX$$ltnis window.width/height.old to window.width/height.new
			if (li_width_diff <> 0 and ii_width > 0 and istr_2resize[li].bw2resize) AND (li_height_diff <> 0 and ii_height > 0 and istr_2resize[li].bh2resize) then
				istr_2resize[li].do2resize.Resize( istr_2resize[li].do2resize.width + li_width_offset,  istr_2resize[li].do2resize.height + li_height_offset)
			else
				// setting the object-width in verh$$HEX1$$e400$$ENDHEX$$ltnis window.width.old to window.width.new
				if li_width_diff <> 0 and ii_width > 0 and istr_2resize[li].bw2resize then
					istr_2resize[li].do2resize.Resize( istr_2resize[li].do2resize.width + li_width_offset,  istr_2resize[li].do2resize.height)
				end if
				// setting the object-height in verh$$HEX1$$e400$$ENDHEX$$ltnis window.height.old to window.height.new
				if li_height_diff <> 0 and ii_height > 0 and istr_2resize[li].bh2resize then
					istr_2resize[li].do2resize.Resize( istr_2resize[li].do2resize.width,  istr_2resize[li].do2resize.height + li_height_offset)
				end if
			end if
			
		// setting the object-X-position in verh$$HEX1$$e400$$ENDHEX$$ltnis window.width.old to window.width.new
			IF li_width_diff <> 0 AND ii_width > 0 THEN
				if istr_2resize[li].bx2resize then
					istr_2resize[li].do2resize.x = istr_2resize[li].do2resize.x + li_x_offset
				end if
			END IF
		// setting the object-X-position in the middle
			if istr_2resize[li].bmidx2resize then
				 istr_2resize[li].do2resize.x = (li_width/2) - (istr_2resize[li].do2resize.width/2)
			end if
			
		// setting the object-Y-position in verh$$HEX1$$e400$$ENDHEX$$ltnis window.height.old to window.height.new
			IF li_height_diff <> 0 AND ii_height > 0 THEN
				if istr_2resize[li].by2resize then
					istr_2resize[li].do2resize.y = istr_2resize[li].do2resize.y + li_y_offset
				end if
			END IF
		// setting the object-Y-position in the middle
			if istr_2resize[li].bmidy2resize then
				 istr_2resize[li].do2resize.y = (li_height/2) - (istr_2resize[li].do2resize.height/2)
			end if
			
		NEXT
		
	// neue abmessungen merken
		ii_width = li_width
		ii_height = li_height
		
		iw_win.SetRedraw(True)

	END IF
ELSE
//	MessageBox ("of_resizecontrols", "Window not valid")
	ll_rc = -1
END IF

RETURN ll_rc

end function

public function long of_resizecontrols ();
/* 
* Funktion:			of_resizecontrols
* Beschreibung: 	controls anpassen entsprechend ihrer Eintr$$HEX1$$e400$$ENDHEX$$ge im array
*
* Besonderheit: 	das hier ist "nur" eine umleitung in die eigentliche Funktion
*						f$$HEX1$$fc00$$ENDHEX$$r den Fall, dass sie ohne Parameter aufgerufen wird
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*
* Return Codes:
*	-1		fehler
*	 1		alles geklappt
*/

return this.of_resizecontrols(iw_win)

end function

public function integer of_set_resize (dragobject ado_2set, boolean ab_h2set, boolean ab_w2set, boolean ab_x2set, boolean ab_y2set, boolean ab_midx2set, boolean ab_midy2set, integer ai_w2set, integer ai_x2set, integer ai_h2set, integer ai_y2set);/* 
* Funktion:			of_set_resize
* Beschreibung: 	control soll bei resize angepasst werden
*
* Besonderheit: 	
*
* Argumente:
*	ado_2set			control
*	ab_h2set			schalter, ob h$$HEX1$$f600$$ENDHEX$$he angepasst werden soll
*	ab_w2set		schalter, ob breite angepasst werden soll
*	ab_x2set			schalter, ob horizontale position angepasst werden soll
*	ab_y2set			schalter, ob vertikale position angepasst werden soll
*	ab_midx2set	schalter, ob horizontale position mittig angepasst werden soll
*	ab_midy2set	schalter, ob vertikale position mittig angepasst werden soll
*	ai_w2set			faktor, um wieviel prozent der $$HEX1$$e400$$ENDHEX$$nderung die breite angepasst werden soll
*	ai_x2set			faktor, um wieviel prozent der $$HEX1$$e400$$ENDHEX$$nderung die horizontale position angepasst werden soll
*	ai_h2set			faktor, um wieviel prozent der $$HEX1$$e400$$ENDHEX$$nderung die h$$HEX1$$f600$$ENDHEX$$he angepasst werden soll
*	ai_y2set			faktor, um wieviel prozent der $$HEX1$$e400$$ENDHEX$$nderung die vertikale position angepasst werden soll
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*														um die 4 parameter erweitert
*
* Return Codes:
*	-1			wenn fehlerhafte parameter $$HEX1$$fc00$$ENDHEX$$bergeben wurden [es wird kein eintrag gemacht]
*	long		index im array, wo das control registriert ist
*/

// variable
long ll_rc = 0  // returncode
long ll_i       // laufvariable


// plausi: x oder midx
// messagebox, weil entwickler-adressiert...
if ab_x2set AND ab_midx2set then
	Messagebox("","X / midX for " + ado_2set.classname())
	ll_rc =  -1
end if
// plausi: y oder midy
// messagebox, weil entwickler-adressiert...
if ab_y2set AND ab_midy2set then
	Messagebox("","Y / midY for " + ado_2set.classname())
	ll_rc =  -1
end if

// plausies: faktoren m$$HEX1$$fc00$$ENDHEX$$ssen zwischen 1 und 100 prozent liegen
// messagebox, weil entwickler-adressiert...
if ai_h2set < 1 OR ai_h2set > 100 then 
	Messagebox("","Invalid resize-height-faktor: " + string(ai_h2set) + " for " + ado_2set.classname())
	ll_rc =  -1
end if
if ai_w2set < 1 OR ai_w2set > 100 then 
	Messagebox("","Invalid resize-width-faktor: " + string(ai_w2set) + " for " + ado_2set.classname())
	ll_rc =  -1
end if
if ai_x2set < 1 OR ai_x2set > 100 then 
	Messagebox("","Invalid resize-x-faktor: " + string(ai_x2set) + " for " + ado_2set.classname())
	ll_rc =  -1
end if
if ai_y2set < 1 OR ai_y2set > 100 then 
	Messagebox("","Invalid resize-y-faktor: " + string(ai_y2set) + " for " + ado_2set.classname())
	ll_rc =  -1
end if
// plausies haben was gefunden: raus
if ll_rc = -1 then return ll_rc


// TRACE
if ai_h2set <> 100 or ai_w2set <> 100 or ai_y2set <> 100 or ai_x2set <> 100 then
	Messagebox(ado_2set.classname(),"resize-width-faktor: " + string(ai_w2set) )
	Messagebox(ado_2set.classname(),"resize-x-faktor: " + string(ai_x2set) )
	Messagebox(ado_2set.classname(),"resize-height-faktor: " + string(ai_h2set) )
	Messagebox(ado_2set.classname(),"resize-y-faktor: " + string(ai_y2set) )
end if



// schleife $$HEX1$$fc00$$ENDHEX$$ber alle schon vorhandenen eintr$$HEX1$$e400$$ENDHEX$$ge
FOR ll_i = 1 TO Upperbound(istr_2resize) STEP 1
     // wenn schon da, dann $$HEX1$$fc00$$ENDHEX$$berschreiben
   IF istr_2resize[ll_i].do2resize = ado_2set THEN
      ll_rc = ll_i
      EXIT
   END IF
NEXT

// noch nicht da: eintragen
IF ll_rc = 0 THEN
   ll_rc = Upperbound(istr_2resize) + 1
   istr_2resize[ll_rc].do2resize = ado_2set
END IF

// schalter eintragen
 istr_2resize[ll_rc].bh2resize = ab_h2set
 istr_2resize[ll_rc].bw2resize = ab_w2set
 istr_2resize[ll_rc].bx2resize = ab_x2set
 istr_2resize[ll_rc].by2resize = ab_y2set
 istr_2resize[ll_rc].bmidx2resize = ab_midx2set
 istr_2resize[ll_rc].bmidy2resize = ab_midy2set
 istr_2resize[ll_rc].ih2resize = ai_h2set
 istr_2resize[ll_rc].iw2resize = ai_w2set
 istr_2resize[ll_rc].ix2resize = ai_x2set
 istr_2resize[ll_rc].iy2resize = ai_y2set

return ll_rc

end function

public function integer of_set_resize (dragobject ado_2set, boolean ab_h2set, boolean ab_w2set, boolean ab_x2set, boolean ab_y2set, boolean ab_midx2set, boolean ab_midy2set, integer ai_w2set, integer ai_x2set)
/* 
* Funktion:			of_set_resize
* Beschreibung: 	control soll bei resize angepasst werden
*
* Besonderheit: 	das hier ist nur eine umleitung in die eigentliche Funktion
*						f$$HEX1$$fc00$$ENDHEX$$r den Fall, dass sie mit weniger Parameter aufgerufen wird
*
* Argumente:
*	ado_2set			control
*	ab_h2set			schalter, ob h$$HEX1$$f600$$ENDHEX$$he angepasst werden soll
*	ab_w2set		schalter, ob breite angepasst werden soll
*	ab_x2set			schalter, ob horizontale position angepasst werden soll
*	ab_y2set			schalter, ob vertikale position angepasst werden soll
*	ab_midx2set	schalter, ob horizontale position mittig angepasst werden soll
*	ab_midy2set	schalter, ob vertikale position mittig angepasst werden soll
*	ai_w2set			faktor, um wieviel prozent der $$HEX1$$e400$$ENDHEX$$nderung die breite angepasst werden soll
*	ai_x2set			faktor, um wieviel prozent der $$HEX1$$e400$$ENDHEX$$nderung die horizontale position angepasst werden soll
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Erstellung
*
* Return Codes:
*	-1			wenn fehlerhafte parameter $$HEX1$$fc00$$ENDHEX$$bergeben wurden [es wird kein eintrag gemacht]
*	long		index im array, wo das control registriert ist
*/

return of_set_resize (ado_2set, ab_h2set, ab_w2set, ab_x2set, ab_y2set, ab_midx2set, ab_midy2set, ai_w2set, ai_x2set, 100, 100)

end function

public function integer of_set_resize (dragobject ado_2set, boolean ab_h2set, boolean ab_w2set, boolean ab_x2set, boolean ab_y2set, boolean ab_midx2set, boolean ab_midy2set);
/* 
* Funktion:			of_set_resize
* Beschreibung: 	control soll bei resize angepasst werden
*
* Besonderheit: 	das hier ist nur eine umleitung in die eigentliche Funktion
*						f$$HEX1$$fc00$$ENDHEX$$r den Fall, dass sie mit weniger Parameter aufgerufen wird
*
* Argumente:
*	ado_2set			control
*	ab_h2set			schalter, ob h$$HEX1$$f600$$ENDHEX$$he angepasst werden soll
*	ab_w2set		schalter, ob breite angepasst werden soll
*	ab_x2set			schalter, ob horizontale position angepasst werden soll
*	ab_y2set			schalter, ob vertikale position angepasst werden soll
*	ab_midx2set	schalter, ob horizontale position mittig angepasst werden soll
*	ab_midy2set	schalter, ob vertikale position mittig angepasst werden soll
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*
* Return Codes:
*	-1			wenn fehlerhafte parameter $$HEX1$$fc00$$ENDHEX$$bergeben wurden [es wird kein eintrag gemacht]
*	long		index im array, wo das control registriert ist
*/

return of_set_resize (ado_2set, ab_h2set, ab_w2set, ab_x2set, ab_y2set, FALSE, FALSE, 100, 100, 100, 100)

end function

public function integer of_set_resize (dragobject ado_2set, boolean ab_h2set, boolean ab_w2set, boolean ab_x2set, boolean ab_y2set);
/* 
* Funktion:			of_set_resize
* Beschreibung: 	control soll bei resize angepasst werden
*
* Besonderheit: 	das hier ist nur eine umleitung in die eigentliche Funktion
*						f$$HEX1$$fc00$$ENDHEX$$r den Fall, dass sie mit weniger Parameter aufgerufen wird
*
* Argumente:
*	ado_2set			control
*	ab_h2set			schalter, ob h$$HEX1$$f600$$ENDHEX$$he angepasst werden soll
*	ab_w2set		schalter, ob breite angepasst werden soll
*	ab_x2set			schalter, ob horizontale position angepasst werden soll
*	ab_y2set			schalter, ob vertikale position angepasst werden soll
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*
* Return Codes:
*	-1			wenn fehlerhafte parameter $$HEX1$$fc00$$ENDHEX$$bergeben wurden [es wird kein eintrag gemacht]
*	long		index im array, wo das control registriert ist
*/

return of_set_resize (ado_2set, ab_h2set, ab_w2set, ab_x2set, ab_y2set, FALSE, FALSE, 100, 100, 100, 100)

end function

public function integer of_set_resize (dragobject ado_2set, boolean ab_h2set, boolean ab_w2set);
/* 
* Funktion:			of_set_resize
* Beschreibung: 	control soll bei resize angepasst werden
*
* Besonderheit: 	das hier ist nur eine umleitung in die eigentliche Funktion
*						f$$HEX1$$fc00$$ENDHEX$$r den Fall, dass sie mit weniger Parameter aufgerufen wird
*
* Argumente:
*	ado_2set			control
*	ab_h2set			schalter, ob h$$HEX1$$f600$$ENDHEX$$he angepasst werden soll
*	ab_w2set		schalter, ob breite angepasst werden soll
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*
* Return Codes:
*	-1			wenn fehlerhafte parameter $$HEX1$$fc00$$ENDHEX$$bergeben wurden [es wird kein eintrag gemacht]
*	long		index im array, wo das control registriert ist
*/

return of_set_resize (ado_2set, ab_h2set, ab_w2set, FALSE, FALSE, FALSE, FALSE, 100, 100, 100, 100)

end function

public function integer of_unset_resize (dragobject ado_2set);
/* 
* Funktion:			of_unset_resize
* Beschreibung: 	control soll bei resize nicht mehr angepasst werden
*
* Besonderheit: 	
*
* Argumente:
*	ado_2set			control
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

// variable
long ll_rc = 0  // returncode
long ll_i       // laufvariable

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle schon vorhandenen eintr$$HEX1$$e400$$ENDHEX$$ge STRUKTUR
FOR ll_i = 1 TO Upperbound(istr_2resize) STEP 1
     // wenn gefunden, dann $$HEX1$$e400$$ENDHEX$$ndern
	IF istr_2resize[ll_i].do2resize = ado_2set THEN
		istr_2resize[ll_i].bh2resize = FALSE
		istr_2resize[ll_i].bw2resize = FALSE
		istr_2resize[ll_i].bx2resize = FALSE
		istr_2resize[ll_i].by2resize = FALSE
		istr_2resize[ll_i].bmidx2resize = FALSE
		istr_2resize[ll_i].bmidy2resize = FALSE
		istr_2resize[ll_i].ih2resize = 100
		istr_2resize[ll_i].iw2resize = 100
		istr_2resize[ll_i].ix2resize = 100
		istr_2resize[ll_i].iy2resize = 100
		
		ll_rc = ll_i
		EXIT
	END IF
NEXT

// nicht da: nix machen....

return ll_rc

end function

public function long of_set_midx2resize (dragobject ado_2set);
/* 
* Funktion:			of_set_midx2resize
* Beschreibung: 	control soll horizontal mittig angepasst werden
*
* Besonderheit: 	horizontal anpassen wird ggf. abgeschaltet
*
* Argumente:
*	ado_2set		control
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

// variable
long ll_rc = 0  // returncode
long ll_i       // laufvariable

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle schon vorhandenen eintr$$HEX1$$e400$$ENDHEX$$ge STRUKTUR
FOR ll_i = 1 TO Upperbound(istr_2resize) STEP 1
	// wenn schon da, dann $$HEX1$$fc00$$ENDHEX$$berschreiben
	IF istr_2resize[ll_i].do2resize = ado_2set THEN
		istr_2resize[ll_i].bmidx2resize = TRUE
		istr_2resize[ll_i].bx2resize = FALSE
		ll_rc = ll_i
		EXIT
	END IF
NEXT

// noch nicht da: eintragen in STRUKTUR
IF ll_rc = 0 THEN
	ll_rc = Upperbound(istr_2resize) + 1
	istr_2resize[ll_rc].do2resize = ado_2set
	istr_2resize[ll_rc].bh2resize = FALSE
	istr_2resize[ll_rc].bw2resize = FALSE
	istr_2resize[ll_rc].bx2resize = FALSE
	istr_2resize[ll_rc].by2resize = FALSE
	istr_2resize[ll_rc].bmidx2resize = TRUE
	istr_2resize[ll_rc].bmidy2resize = FALSE
	istr_2resize[ll_rc].ih2resize = 100
	istr_2resize[ll_rc].iw2resize = 100
	istr_2resize[ll_rc].ix2resize = 100
	istr_2resize[ll_rc].iy2resize = 100
END IF

return ll_rc

end function

public function long of_set_midy2resize (dragobject ado_2set);
/* 
* Funktion:			of_set_midy2resize
* Beschreibung: 	control soll vertikal mittig angepasst werden
*
* Besonderheit: 	vertikal anpassen wird ggf. abgeschaltet
*
* Argumente:
*	ado_2set		control
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		21.08.2008		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		17.09.2008		Faktor eingebaut
*
* Return Codes:
*	long		index im array, wo das control registriert ist
*/

// variable
long ll_rc = 0  // returncode
long ll_i       // laufvariable

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle schon vorhandenen eintr$$HEX1$$e400$$ENDHEX$$ge STRUKTUR
FOR ll_i = 1 TO Upperbound(istr_2resize) STEP 1
	// wenn schon da, dann $$HEX1$$fc00$$ENDHEX$$berschreiben
	IF istr_2resize[ll_i].do2resize = ado_2set THEN
		istr_2resize[ll_i].bmidy2resize = TRUE
		istr_2resize[ll_i].by2resize = FALSE
		ll_rc = ll_i
		EXIT
	END IF
NEXT

// noch nicht da: eintragen in STRUKTUR
IF ll_rc = 0 THEN
	ll_rc = Upperbound(istr_2resize) + 1
	istr_2resize[ll_rc].do2resize = ado_2set
	istr_2resize[ll_rc].bh2resize = FALSE
	istr_2resize[ll_rc].bw2resize = FALSE
	istr_2resize[ll_rc].bx2resize = FALSE
	istr_2resize[ll_rc].by2resize = FALSE
	istr_2resize[ll_rc].bmidx2resize = FALSE
	istr_2resize[ll_rc].bmidy2resize = TRUE
	istr_2resize[ll_rc].ih2resize = 100
	istr_2resize[ll_rc].iw2resize = 100
	istr_2resize[ll_rc].ix2resize = 100
	istr_2resize[ll_rc].iy2resize = 100
END IF

return ll_rc

end function

public function long of_set_minheight (long al_minheight);
/* 
* Funktion:			of_set_minheight
* Beschreibung: 	instance Mindesth$$HEX1$$f600$$ENDHEX$$he aufnehmen
*
* Besonderheit: 	
*
* Argumente:
*	al_minheight	mindesth$$HEX1$$f600$$ENDHEX$$he des fensters
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		07.09.2009		Erstellung
*
* Return Codes:
*	long		immer 0
*/

// variable
long ll_rc = 0  // returncode

il_minheight = al_minheight

return ll_rc

end function

public function long of_set_minwidth (long al_minwidth);
/* 
* Funktion:			of_set_minwidth
* Beschreibung: 	instance Mindestbreite aufnehmen
*
* Besonderheit: 	
*
* Argumente:
*	al_minwidth 	mindestbreite des fensters
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		07.09.2009		Erstellung
*
* Return Codes:
*	long		immer 0
*/

// variable
long ll_rc = 0  // returncode

il_minwidth = al_minwidth

return ll_rc

end function

public function long of_init_tab (tab atab2resize, integer alwidth, integer alheight);
/* 
* Funktion:			of_init_tab
* Beschreibung: 	masse $$HEX1$$fc00$$ENDHEX$$bernehmen
*
* Besonderheit: 	die masse m$$HEX1$$fc00$$ENDHEX$$ssen hier von aussen $$HEX1$$fc00$$ENDHEX$$bernommen werden,
* 						da das tab auch ausserhalb des userobjects in der gr$$HEX1$$f600$$ENDHEX$$sse ver$$HEX1$$e400$$ENDHEX$$ndert werden kann
*
* Argumente:
*	atab2Resize		Tab, um welches es gehen soll
*	alWidth			aktuelle Breite
*	alHeight			aktuelle H$$HEX1$$f600$$ENDHEX$$he
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		18.08.2011		Erstellung
*
* Return Codes:
*	0		immer
*/


// parameter in die instance-variablen $$HEX1$$fc00$$ENDHEX$$bernehmen
this.itab_tab = atab2Resize
this.ii_tab_width = alWidth
this.ii_tab_height = alHeight

return 0

end function

public function long of_resizecontrols_tab (tab atab_tab);
/* 
* Funktion:			of_resizecontrols
* Beschreibung: 	controls anpassen entsprechend ihrer eintr$$HEX1$$e400$$ENDHEX$$ge im array
*
* Besonderheit: 	
*
* Argumente:
*	atab_tab			betroffenes tab
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		18.08.2011		Erstellung
*
* Return Codes:
*	-1		fehler
*	 1		alles geklappt
*/

// variable
long ll_rc = 1
integer li, li_bound
integer li_width, li_height, li_width_diff, li_height_diff, li_width_offset, li_height_offset, li_x_offset, li_y_offset

// tab merken
itab_tab = atab_tab

// valid window
IF Isvalid (itab_tab) THEN

	// neue abmessungen feststellen
	li_width = itab_tab.width
	li_height = itab_tab.height
	
	// differenzen feststellen
	li_width_diff = li_width - ii_tab_width
	li_height_diff = li_height - ii_tab_height
	
//	MessageBox("", "Breite Diff: " + string(li_width_diff) + ", vorher: " + string(ii_tab_width) + ", jetzt: " + string(li_width))
	
		li_bound = UpperBound (istr_2resize)
		// objekt f$$HEX1$$fc00$$ENDHEX$$r objekt betrachten
		FOR li = 1 TO li_bound 
			
		// plausi: x oder midx
//			Messagebox(string(li),istr_2resize[li].do2resize.classname())
			if istr_2resize[li].bx2resize AND istr_2resize[li].bmidx2resize THEN Messagebox("X doppelt",istr_2resize[li].do2resize.classname())
			if istr_2resize[li].by2resize AND istr_2resize[li].bmidy2resize THEN Messagebox("Y doppelt",istr_2resize[li].do2resize.classname())
			
			// faktor ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
			if li_width_diff > 0 then
				li_width_offset = round(((li_width_diff * istr_2resize[li].iw2resize) / 100),0)
				li_x_offset = round(((li_width_diff*istr_2resize[li].ix2resize) / 100),0)
			else
				li_width_offset = ceiling((li_width_diff * istr_2resize[li].iw2resize) / 100)
				li_x_offset = ceiling((li_width_diff*istr_2resize[li].ix2resize) / 100)
			end if
			
//			MessageBox("", "Breite mehr: " + string(li_width_offset) + ", X -> " + string(li_x_offset))

			if li_height_diff > 0 then
				li_height_offset = round(((li_height_diff * istr_2resize[li].ih2resize) / 100), 0)
				li_y_offset = round(((li_height_diff * istr_2resize[li].iy2resize) / 100),0)
			else
				li_height_offset = ceiling((li_height_diff * istr_2resize[li].ih2resize) / 100)
				li_y_offset = ceiling((li_height_diff * istr_2resize[li].iy2resize) / 100)
			end if

			// setting the object-width/-height in verh$$HEX1$$e400$$ENDHEX$$ltnis window.width/height.old to window.width/height.new
			if (li_width_diff <> 0 and ii_tab_width > 0 and istr_2resize[li].bw2resize) AND (li_height_diff <> 0 and ii_tab_height > 0 and istr_2resize[li].bh2resize) then
				istr_2resize[li].do2resize.Resize( istr_2resize[li].do2resize.width + li_width_offset,  istr_2resize[li].do2resize.height + li_height_offset)
			else
				// setting the object-width in verh$$HEX1$$e400$$ENDHEX$$ltnis window.width.old to window.width.new
				if li_width_diff <> 0 and ii_tab_width > 0 and istr_2resize[li].bw2resize then
					istr_2resize[li].do2resize.Resize( istr_2resize[li].do2resize.width + li_width_offset,  istr_2resize[li].do2resize.height)
				end if
				// setting the object-height in verh$$HEX1$$e400$$ENDHEX$$ltnis window.height.old to window.height.new
				if li_height_diff <> 0 and ii_tab_height > 0 and istr_2resize[li].bh2resize then
					istr_2resize[li].do2resize.Resize( istr_2resize[li].do2resize.width,  istr_2resize[li].do2resize.height + li_height_offset)
				end if
			end if
			
		// setting the object-X-position in verh$$HEX1$$e400$$ENDHEX$$ltnis window.width.old to window.width.new
			IF li_width_diff <> 0 AND ii_tab_width > 0 THEN
				if istr_2resize[li].bx2resize then
					istr_2resize[li].do2resize.x = istr_2resize[li].do2resize.x + li_x_offset
				end if
			END IF
		// setting the object-X-position in the middle
			if istr_2resize[li].bmidx2resize then
				 istr_2resize[li].do2resize.x = (li_width/2) - (istr_2resize[li].do2resize.width/2)
			end if
			
		// setting the object-Y-position in verh$$HEX1$$e400$$ENDHEX$$ltnis window.height.old to window.height.new
			IF li_height_diff <> 0 AND ii_tab_height > 0 THEN
				if istr_2resize[li].by2resize then
					istr_2resize[li].do2resize.y = istr_2resize[li].do2resize.y + li_y_offset
				end if
			END IF
		// setting the object-Y-position in the middle
			if istr_2resize[li].bmidy2resize then
				 istr_2resize[li].do2resize.y = (li_height/2) - (istr_2resize[li].do2resize.height/2)
			end if
			
		NEXT
		
	// neue abmessungen merken
		ii_tab_width = li_width
		ii_tab_height = li_height
		
ELSE
//	MessageBox ("of_resizecontrols", "Window not valid")
	ll_rc = -1
END IF

RETURN ll_rc

end function

on uo_resize.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_resize.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
// ----------------------------------------------------------
// merken, um welches fenster es geht (immer parent) 
//    und die ausgangsabmessungen festhalten 
// ----------------------------------------------------------

powerobject lpo_work

lpo_work = this.getparent()
IF IsValid(lpo_work) THEN
IF lpo_work.TypeOf() = Window! THEN
   iw_win = lpo_work
   ii_width = WorkspaceWidth(iw_win)
   ii_height = WorkspaceHeight(iw_win)
END IF
//ELSE
//	MessageBox("","kein parent")
END IF

end event

