HA$PBExportHeader$uo_font_calc.sru
$PBExportComments$Objekt zur Berechnung von Schriftgr$$HEX2$$f600df00$$ENDHEX$$en
forward
global type uo_font_calc from nonvisualobject
end type
end forward

global type uo_font_calc from nonvisualobject
end type
global uo_font_calc uo_font_calc

type prototypes
Function boolean DrawText(ulong hdcr, string lpString, long nCount, ref str_rect size, ulong uFormat) Library "user32.DLL" alias for "DrawTextW"
Function long MulDiv(long nNumber, long nNumerator, int nDenominator) Library "kernel32.dll"
Function ulong SelectObject(ulong hdc, ulong hgdiobj) Library "gdi32.dll"
Function boolean DeleteObject(ulong hObject) Library "gdi32.dll"
Function ulong GetDeviceCaps(ulong hdc,ulong nIndex) Library "gdi32.dll"
Function ulong CreateFont(long nHeight, ulong nWidth, ulong nEscapement, ulong nOrientation, ulong fnWeight, boolean fdwItalic, boolean fdwUnderline, boolean fdwStrikeOut, ulong fdwCharSet, ulong fdwOutputPrecision, ulong fdwClipPrecision, ulong fdwQuality, ulong dwPitchAndFamily, ref string lpszFace) Library "gdi32.dll" alias for "CreateFontW"
end prototypes

type variables
PRIVATE:
///////////////////////////////
// Konstanten f$$HEX1$$fc00$$ENDHEX$$r CreateFont //
///////////////////////////////
constant integer FW_NORMAL = 400
constant integer FW_BOLD   = 700

constant ulong LOGPIXELSX = 88 // Number of pixels per logical inch along the screen width
constant ulong LOGPIXELSY = 90 // Number of pixels per logical inch along the screen height

constant ulong DEFAULT_CHARSET = 1 // (0x01)

/////////////////////////////
// Konstanten f$$HEX1$$fc00$$ENDHEX$$r DrawText //
/////////////////////////////
constant uint DT_CALCRECT = 1024 // (0x0400)
end variables

forward prototypes
public function integer of_gettextsize (string as_text, string as_fontface, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref long al_height, ref long al_width)
public function integer of_getoptfontsize (string as_text, string as_fontface, ref integer ai_optfontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, long al_height, long al_width, boolean ab_wraptext)
end prototypes

public function integer of_gettextsize (string as_text, string as_fontface, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref long al_height, ref long al_width);/*
* Objekt : uo_font_calc
* Methode: of_GetTextSize
* Autor  : Dirk Bunk
* Datum  : 31.08.2012
*
* Argument(e):
*   as_Text      Der Text, dessen Gr$$HEX2$$f600df00$$ENDHEX$$e ermittelt werden soll
*   as_FontFace  Die Font-Family des Textes
*   ai_FontSize  Die Font-Gr$$HEX2$$f600df00$$ENDHEX$$e des Textes
*   ab_Bold      Gibt an, ob der Text fett gedruckt ist oder nicht
*   ab_Italic    Gibt an, ob der Text kursiv geschrieben ist oder nicht
*   ab_Underline Gibt an, ob der Text unterstrichen ist oder nicht
*   al_Height    R$$HEX1$$fc00$$ENDHEX$$ckgabeparameter f$$HEX1$$fc00$$ENDHEX$$r die H$$HEX1$$f600$$ENDHEX$$he des Textes
*   al_Width     R$$HEX1$$fc00$$ENDHEX$$ckgabeparameter f$$HEX1$$fc00$$ENDHEX$$r die Breite des Textes
*
* Beschreibung: Berechnet die Gr$$HEX2$$f600df00$$ENDHEX$$e eines Textes anhand einer definierten Schriftart
*
* Hinweis: Siehe auch "CreateFont" in MSDN --> http://msdn.microsoft.com/en-us/library/dd183499%28v=vs.85%29
*          Ebenso "DrawText" in MSDN http://msdn.microsoft.com/en-us/library/windows/desktop/dd162498%28v=vs.85%29.aspx
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    31.08.2012    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_ret = 0
ulong ll_handle, ll_hdc, ll_hfont, ll_weight
str_rect lstr_Rect

// Handle des User Objects benutzen, um an den Ger$$HEX1$$e400$$ENDHEX$$tekontext zu gelangen
ll_handle = Handle(this)
ll_hdc = GetDC(ll_handle)

// Die H$$HEX1$$f600$$ENDHEX$$he entsprechend der physischen Eigenschaften des Bildschirms berechnen
al_height = -MulDiv(ai_FontSize, GetDeviceCaps(ll_hdc, LOGPIXELSY), 72)

// Ein Schriftobjekt erzeugen
if ab_bold then ll_weight = FW_BOLD else ll_weight = FW_NORMAL
ll_hfont = CreateFont(al_height, 0, 0, 0, ll_weight, ab_italic, ab_underline, false, 0, DEFAULT_CHARSET, 0, 0, 0, as_fontface)

// Das erzeugte Schriftobjekt im aktuellen Kontext benutzen
SelectObject(ll_hdc, ll_hfont)

// Die H$$HEX1$$f600$$ENDHEX$$he und Breite des Textes ermitteln		 
if DrawText(ll_hdc, as_Text, Len(as_Text), lstr_Rect, DT_CALCRECT) then
	al_Height = lstr_Rect.Bottom - lstr_Rect.Top
	al_Width = lstr_Rect.Right - lstr_Rect.Left
end if

// Das Schriftobjekt wieder zerst$$HEX1$$f600$$ENDHEX$$ren (Sehr wichtig, da sonst eigenartige Fehler auftreten k$$HEX1$$f600$$ENDHEX$$nnen)
DeleteObject(ll_hfont)

// Den Ger$$HEX1$$e400$$ENDHEX$$tekontext wieder freigeben
ReleaseDC(ll_handle, ll_hdc)

return li_ret
end function

public function integer of_getoptfontsize (string as_text, string as_fontface, ref integer ai_optfontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, long al_height, long al_width, boolean ab_wraptext);/*
* Objekt : uo_font_calc
* Methode: of_GetOptFontSize
* Autor  : Rainer Hillebrandt
* Datum  : ??.??.????
*
* Argument(e):
*   as_text      Der Text, f$$HEX1$$fc00$$ENDHEX$$r den die optimale Schriftgr$$HEX2$$f600df00$$ENDHEX$$e ermittelt werden soll
*   as_fontface  Die Font-Family des Textes an
*   ai_fontsize  R$$HEX1$$fc00$$ENDHEX$$ckgabewert der optimalen Font-Gr$$HEX2$$f600df00$$ENDHEX$$e des Textes
*   ab_bold      Gibt an, ob der Text fett gedruckt ist oder nicht
*   ab_italic    Gibt an, ob der Text kursiv geschrieben ist oder nicht
*   ab_underline Gibt an, ob der Text unterstrichen ist oder nicht
*   al_height    H$$HEX1$$f600$$ENDHEX$$he des Rechtecks
*   al_width     Breite des Rechtecks
*   ab_wrapText  Gibt an, ob der Text umgebrochen werden soll, um die optimale Gr$$HEX2$$f600df00$$ENDHEX$$e zu finden
*
* Beschreibung: Berechnet die optimale Gr$$HEX2$$f600df00$$ENDHEX$$e f$$HEX1$$fc00$$ENDHEX$$r die Schriftart eines Textes, um in ein Rechteck zu passen
*
* Hinweis: Powerbuilder definiert die Schriftgr$$HEX2$$f600df00$$ENDHEX$$e mit einem negativen Wert (Whatever?!)
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer               Wann          Was und warum
*   1.0        R. Hillebrandt    ??.??.????    Erstellung
*   1.1        Dirk Bunk         31.08.2012    Neue Funktion verwenden
*   1.2        Dirk Bunk         04.09.2012    Leerzeichen mit Zeilenumbr$$HEX1$$fc00$$ENDHEX$$chen ersetzen
*   1.3        Dirk Bunk         05.09.2012    Extra Pr$$HEX1$$fc00$$ENDHEX$$fung des Textes/Zeilenumbr$$HEX1$$fc00$$ENDHEX$$che optional
*
* Return: 
*   0: OK
*  -1: Fehler
*/

boolean lb_exit = false
integer li_fontsize, li_ret = 0
long ll_height, ll_width, ll_Pos

// Optimale Schriftgr$$HEX2$$f600df00$$ENDHEX$$e standardm$$HEX2$$e400df00$$ENDHEX$$ig auf 2 setzen
ai_optfontsize = 2
li_fontsize = ai_optfontsize

if Trim(as_text) <> "" then
	do until lb_exit
		// Die Gr$$HEX2$$f600df00$$ENDHEX$$e des Textes mit der aktuellen Schriftgr$$HEX2$$f600df00$$ENDHEX$$e ermitteln
		li_ret = of_GetTextSize(as_text, as_fontface, li_fontsize, ab_bold, ab_italic, ab_underline, ll_height, ll_width)
		
		if li_ret <> 0 then
			lb_exit = true
		else
			// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob der Text noch in die Box passt, wenn ja dann 
			// Schriftgr$$HEX2$$f600df00$$ENDHEX$$e merken, ansonsten raus aus der Funktion
			if al_height > ll_height and al_width > ll_width then
				ai_optfontsize = li_fontsize
				ll_height = 0 
				ll_width = 0
				li_fontsize++
			else
				// Wenn Leerzeichen vorhanden sind, k$$HEX1$$f600$$ENDHEX$$nnten Zeilenumbr$$HEX1$$fc00$$ENDHEX$$che ein besseres Ergebnis liefern.
				// Also brechen wir bei letzten Wort um, und schauen, ob die Schrift dadurch gr$$HEX2$$f600df00$$ENDHEX$$er werden kann.
				if ab_wrapText then
					ll_Pos = LastPos(as_text, " ")
					if ll_Pos > 0 then
						as_text = Replace(as_text, ll_Pos, 1, "~n")
						of_GetOptFontSize(as_text, as_fontface, li_fontsize, ab_bold, ab_italic, ab_underline, al_height, al_width, true)
						if li_fontsize > ai_optfontsize then ai_optfontsize = li_fontsize
					end if
				end if
	
				lb_exit = true
			end if
		end if
	loop
end if

return li_ret
end function

on uo_font_calc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_font_calc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

