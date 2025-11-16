HA$PBExportHeader$uo_amyuni_viewer.sru
$PBExportComments$Objekt, welches den aktuellen Amyuni PDF Viewer beinhaltet
forward
global type uo_amyuni_viewer from uo_amyuni_viewer_interface
end type
type st_4 from statictext within uo_amyuni_viewer
end type
type st_3 from statictext within uo_amyuni_viewer
end type
type st_2 from statictext within uo_amyuni_viewer
end type
type st_1 from statictext within uo_amyuni_viewer
end type
type ole_viewer from olecustomcontrol within uo_amyuni_viewer
end type
end forward

global type uo_amyuni_viewer from uo_amyuni_viewer_interface
integer height = 1188
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
ole_viewer ole_viewer
end type
global uo_amyuni_viewer uo_amyuni_viewer

type variables
PRIVATE:
string is_LicenseCompany = "LSG Sky Chefs"
string is_LicenseKey = "07EFCDAB0100010054F8D2FC073CB30685B5B09B4FD592F24D3E5CC766270EB6AF17AACAC5C103F4A4292D1570A8E2D4C3616F3480E8"
end variables

forward prototypes
public function integer of_get_page_count ()
public subroutine of_show_page (integer ai_page)
public subroutine of_zoom (integer li_zoom)
public function integer resize (integer w, integer h)
public function integer of_get_current_page ()
public subroutine of_show_first_page ()
public subroutine of_show_last_page ()
public subroutine of_show_next_page ()
public subroutine of_show_prev_page ()
public subroutine of_print (string as_printer, integer ai_printrangeinclude, integer ai_printpages[])
public function integer of_zoom_to_fit ()
public function boolean of_search (integer ai_searchoption, string as_searchstring)
public function integer of_open (string as_file)
public subroutine of_refresh ()
public function string of_get_title ()
end prototypes

public function integer of_get_page_count ();/* 
* Funktion: of_get_page_count
* Beschreibung: Gibt die Anzahl der Seiten des ge$$HEX1$$f600$$ENDHEX$$ffneten Dokuments zur$$HEX1$$fc00$$ENDHEX$$ck 
* Besonderheit: keine
*      Hinweis: Eine Dokumentation der Funktionen gibt es unter:
*               http://www.amyuni.com/WebHelp/Developer_Documentation.htm
*
* Argumente:
* 	Name				Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*	1.0        O.Hoefer    28.08.2008    Erstellung
*  1.1        D.Bunk      31.01.2013    Header hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*  1.2        D.Bunk      06.11.2013    Pr$$HEX1$$fc00$$ENDHEX$$fung, ob das OLE schon aktiv (alive) ist, hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*   Die Anzahl der Seiten des Dokuments
*/

if ole_viewer.object.IsAlive() then
	return ole_viewer.object.PageCount
else
	return 0
end if
end function

public subroutine of_show_page (integer ai_page);/* 
* Funktion: of_show_page
* Beschreibung: Springt zu einer bestimmten Seite des ge$$HEX1$$f600$$ENDHEX$$ffneten Dokuments, des Viewer OCX
* Besonderheit: keine
*      Hinweis: Eine Dokumentation der Funktionen gibt es unter:
*               http://www.amyuni.com/WebHelp/Developer_Documentation.htm
*
* Argumente:
* 	Name    Beschreibung
*  ai_page Die Seite, zu der gesprungen werden soll
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*	1.0        O.Hoefer    28.08.2008    Erstellung
*  1.1        D.Bunk      31.01.2013    Header hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*  1.2        D.Bunk      06.11.2013    Pr$$HEX1$$fc00$$ENDHEX$$fung, ob das OLE schon aktiv (alive) ist, hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*  keine
*/

if ole_viewer.object.IsAlive() then
	ole_viewer.object.CurrentPage = ai_page
end if
end subroutine

public subroutine of_zoom (integer li_zoom);/* 
* Funktion: of_zoom
* Beschreibung: Setzt den Zoomwert f$$HEX1$$fc00$$ENDHEX$$r das Viewer OCX
* Besonderheit: keine
*      Hinweis: Eine Dokumentation der Funktionen gibt es unter:
*               http://www.amyuni.com/WebHelp/Developer_Documentation.htm
*
* Argumente:
* 	Name    Beschreibung
*  li_zoom Der Zoomwert, der gesetzt werden soll
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*	1.0        O.Hoefer    28.08.2008    Erstellung
*  1.1        D.Bunk      31.01.2013    Header hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*  1.2        D.Bunk      06.11.2013    Pr$$HEX1$$fc00$$ENDHEX$$fung, ob das OLE schon aktiv (alive) ist, hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*  keine
*/

if ole_viewer.object.IsAlive() then
	ole_viewer.object.ZoomFactor = li_zoom
	
	if li_zoom <= 50 then 
		ole_viewer.object.RulerSize = 0
	else
		ole_viewer.object.RulerSize = 24
	end if
end if
end subroutine

public function integer resize (integer w, integer h);/* 
* Funktion: resize
* Beschreibung: Anpassen der Gr$$HEX2$$f600df00$$ENDHEX$$e des OLE Objekts an die Gr$$HEX2$$f600df00$$ENDHEX$$e des Parent Objekts 
* Besonderheit: keine
*      Hinweis: Eine Dokumentation der Funktionen gibt es unter:
*               http://www.amyuni.com/WebHelp/Developer_Documentation.htm
*
* Argumente:
* 	Name				Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*	1.0        O.Hoefer    28.08.2008    Erstellung
*  1.1        D.Bunk      31.01.2013    Header hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*  PB Return Code
*/

integer li_ret

li_ret = super::resize(w, h)

ole_viewer.SetRedraw(false)
ole_viewer.visible = false

ole_viewer.x = 0
ole_viewer.y = 0
ole_viewer.resize(w - 20, h - 80)

ole_viewer.visible = true
ole_viewer.SetRedraw(true)

return li_ret
end function

public function integer of_get_current_page ();/* 
* Funktion: of_get_current_page
* Beschreibung: Gibt die aktuelle Seite des ge$$HEX1$$f600$$ENDHEX$$ffneten Dokuments zur$$HEX1$$fc00$$ENDHEX$$ck 
* Besonderheit: keine
*      Hinweis: Eine Dokumentation der Funktionen gibt es unter:
*               http://www.amyuni.com/WebHelp/Developer_Documentation.htm
*
* Argumente:
* 	Name				Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*  1.0        D.Bunk      10.04.2013    Erstellung
*  1.1        D.Bunk      06.11.2013    Pr$$HEX1$$fc00$$ENDHEX$$fung, ob das OLE schon aktiv (alive) ist, hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*   Die aktuelle Seite des Dokuments
*/

if ole_viewer.object.IsAlive() then
	return ole_viewer.object.CurrentPage
else
	return 0
end if
end function

public subroutine of_show_first_page ();/* 
* Funktion: of_show_first_page
* Beschreibung: Zeigt die erste Seite des Dokuments an 
* Besonderheit: keine
*      Hinweis: Eine Dokumentation der Funktionen gibt es unter:
*               http://www.amyuni.com/WebHelp/Developer_Documentation.htm
*
* Argumente:
* 	Name				Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*  1.0        D.Bunk      10.04.2013    Erstellung
*  1.1        D.Bunk      04.06.2013    Alternativer aufruf der ersten Seite
*
* Return Codes:
*   keine
*/

// 04.06.13, DB: Der direkte Aufruf funktioniert bl$$HEX1$$f600$$ENDHEX$$derweise nicht in der $$HEX1$$fc00$$ENDHEX$$bersetzten Version
//ole_viewer.object.DoCommandTool(COMMAND_PAGE_FIRST)

integer li_FirstPage

li_FirstPage = 1
if li_FirstPage <= of_get_page_count() then of_show_page(li_FirstPage)
end subroutine

public subroutine of_show_last_page ();/* 
* Funktion: of_show_last_page
* Beschreibung: Zeigt die letzte Seite des Dokuments an 
* Besonderheit: keine
*      Hinweis: Eine Dokumentation der Funktionen gibt es unter:
*               http://www.amyuni.com/WebHelp/Developer_Documentation.htm
*
* Argumente:
* 	Name				Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*  1.0        D.Bunk      10.04.2013    Erstellung
*  1.1        D.Bunk      04.06.2013    Alternativer aufruf der letzten Seite
*
* Return Codes:
*   keine
*/

// 04.06.13, DB: Der direkte Aufruf funktioniert bl$$HEX1$$f600$$ENDHEX$$derweise nicht in der $$HEX1$$fc00$$ENDHEX$$bersetzten Version
//ole_viewer.object.DoCommandTool(COMMAND_PAGE_LAST)

integer li_LastPage

li_LastPage = of_get_page_count()
if li_LastPage >= 1 then of_show_page(li_LastPage)
end subroutine

public subroutine of_show_next_page ();/* 
* Funktion: of_show_next_page
* Beschreibung: Zeigt die n$$HEX1$$e400$$ENDHEX$$chste Seite des Dokuments an 
* Besonderheit: keine
*      Hinweis: Eine Dokumentation der Funktionen gibt es unter:
*               http://www.amyuni.com/WebHelp/Developer_Documentation.htm
*
* Argumente:
* 	Name				Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*  1.0        D.Bunk      10.04.2013    Erstellung
*  1.1        D.Bunk      04.06.2013    Alternativer aufruf der n$$HEX1$$e400$$ENDHEX$$chsten Seite
*
* Return Codes:
*   keine
*/

// 04.06.13, DB: Der direkte Aufruf funktioniert bl$$HEX1$$f600$$ENDHEX$$derweise nicht in der $$HEX1$$fc00$$ENDHEX$$bersetzten Version
//ole_viewer.object.DoCommandTool(COMMAND_PAGE_NEXT)

integer li_NextPage

li_NextPage = of_get_current_page() + 1
if li_NextPage <= of_get_page_count() then of_show_page(li_NextPage)
end subroutine

public subroutine of_show_prev_page ();/* 
* Funktion: of_show_prev_page
* Beschreibung: Zeigt die vorherige Seite des Dokuments an 
* Besonderheit: keine
*      Hinweis: Eine Dokumentation der Funktionen gibt es unter:
*               http://www.amyuni.com/WebHelp/Developer_Documentation.htm
*
* Argumente:
* 	Name				Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*  1.0        D.Bunk      10.04.2013    Erstellung
*  1.1        D.Bunk      04.06.2013    Alternativer aufruf der vorherigen Seite
*
* Return Codes:
*   keine
*/

// 04.06.13, DB: Der direkte Aufruf funktioniert bl$$HEX1$$f600$$ENDHEX$$derweise nicht in der $$HEX1$$fc00$$ENDHEX$$bersetzten Version
//ole_viewer.object.DoCommandTool(COMMAND_PAGE_PREV)

integer li_PrevPage

li_PrevPage = of_get_current_page() - 1
if li_PrevPage >= 1 then of_show_page(li_PrevPage)
end subroutine

public subroutine of_print (string as_printer, integer ai_printrangeinclude, integer ai_printpages[]);/* 
* Funktion: of_print
* Beschreibung: Druckt das ge$$HEX1$$f600$$ENDHEX$$ffnete PDF Dokument des Viewer OCX 
* Besonderheit: keine
*      Hinweis: Eine Dokumentation der Funktionen gibt es unter:
*               http://www.amyuni.com/WebHelp/Developer_Documentation.htm
*
* Argumente:
* 	Name		  Beschreibung
*  as_printer Der Name des Druckers, auf den gedruckt werden soll   
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*	1.0        O.Hoefer    28.08.2008    Erstellung
*  1.1        D.Bunk      31.01.2013    Header hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*  1.2        D.Bunk      06.11.2013    Pr$$HEX1$$fc00$$ENDHEX$$fung, ob das OLE schon aktiv (alive) ist, hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*  keine
*/

// Zus$$HEX1$$e400$$ENDHEX$$tzliche Parameter $$HEX1$$fc00$$ENDHEX$$bernehmen. Diese werden im "printpage" Event des Viewer OCX verwendet.
ii_PrintRangeInclude = ai_PrintRangeInclude
ii_PrintPages = ai_PrintPages

if ole_viewer.object.IsAlive() then
	ole_viewer.object.Print(as_printer, 0)
end if
end subroutine

public function integer of_zoom_to_fit ();/* 
* Funktion: of_zoom_to_fit
* Beschreibung: Passt die Gr$$HEX2$$f600df00$$ENDHEX$$e des Dokuments der aktuellen Containergr$$HEX2$$f600df00$$ENDHEX$$e an
* Besonderheit: keine
*      Hinweis: Eine Dokumentation der Funktionen gibt es unter:
*               http://www.amyuni.com/WebHelp/Developer_Documentation.htm
*
* Argumente:
* 	Name				Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer       Wann          Was und warum
*	1.0        D.Bunk    10.04.2013    Erstellung
*  1.1        D.Bunk    06.11.2013    Pr$$HEX1$$fc00$$ENDHEX$$fung, ob das OLE schon aktiv (alive) ist, hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*  1.2        D.Bunk    12.02.2014    Der gew$$HEX1$$e400$$ENDHEX$$hlte Zoomfaktor wird zur$$HEX1$$fc00$$ENDHEX$$ckgegeben
*  1.3        D.Bunk    15.04.2014    Den Zoomfaktor auch von der H$$HEX1$$f600$$ENDHEX$$he abh$$HEX1$$e400$$ENDHEX$$ngig machen und etwas anders berechnen
*
* Return Codes:
*   Der gew$$HEX1$$e400$$ENDHEX$$hlte Zoomfaktor
*/

// Folgendes gilt f$$HEX1$$fc00$$ENDHEX$$r die Umrechnung:
// 15 Twips = 1 Pixel
// 1 Pixel = 4,571429 PBUnits (X)
// 1 Pixel = 4 PBUnits (Y)
constant decimal ldec_ConversionFaktorWidth = 3.28
constant decimal ldec_ConversionFaktorHeight = 3.75

integer li_PdfWidth, li_PdfHeight, li_ZoomFactor, li_ZoomFactorX, li_ZoomFactorY

if ole_viewer.object.IsAlive() then
	// Gr$$HEX2$$f600df00$$ENDHEX$$e des PDFs in PB-Units bestimmen. 
	// Da die Gr$$HEX2$$f600df00$$ENDHEX$$e des PDFs in Twips angegeben ist, muss eine Konvertierung erfolgen
	li_PdfWidth = Integer(Integer(ole_viewer.object.PageWidth) / ldec_ConversionFaktorWidth)
	li_PdfHeight = Integer(Integer(ole_viewer.object.PageLength) / ldec_ConversionFaktorHeight)
	
	// Optimalen Zoomfaktor berechnen
	li_ZoomFactorX = ole_viewer.width * 100 / li_PdfWidth
	li_ZoomFactorY = ole_viewer.height * 100 / li_PdfHeight
	if li_ZoomFactorY < li_ZoomFactorX then 
		li_ZoomFactor = li_ZoomFactorY
	else
		li_ZoomFactor = li_ZoomFactorX
	end if
	
	// Zoomfaktor nochmal um 10% erh$$HEX1$$f600$$ENDHEX$$hen, weil es leider doch nicht so 100%ig passt.
	li_ZoomFactor = li_ZoomFactor * 1.1
	
	// Zoomfaktor anpassen
	if li_ZoomFactor <= 10 then li_ZoomFactor = 10
	if li_ZoomFactor >= 999 then li_ZoomFactor = 999
	
	// Zoomfaktor setzen
	ole_viewer.object.ZoomFactor = li_ZoomFactor
end if

return li_ZoomFactor
end function

public function boolean of_search (integer ai_searchoption, string as_searchstring);/* 
* Funktion: of_search
* Beschreibung: Durchsucht das Dokument nach einem bestimmten Text
* Besonderheit: keine
*      Hinweis: Eine Dokumentation der Funktionen gibt es unter:
*               http://www.amyuni.com/WebHelp/Developer_Documentation.htm
*
* Argumente:
* 	Name				 Beschreibung
*  ai_SearchOption Die Art der Suche (siehe SEARCH_OPTION.. Konstanten)
*  as_SearchString Der gesuchte Text
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*  1.0        D.Bunk      15.09.2014    Erstellung
*
* Return Codes:
*   Booleanwert, der angibt, ob der Text gefunden wurde oder nicht
*/

boolean lb_Found = false

// Alle bisher selektierten Objekte abw$$HEX1$$e400$$ENDHEX$$hlen
ole_viewer.object.SelectAllObjects(false)

// Nach dem Text suchen (falls gefunden wird der Text automatisch markiert)
lb_Found = (ole_viewer.object.ReachText(ai_SearchOption, as_SearchString, "", 0, 0, 0) = 1)

return lb_Found
end function

public function integer of_open (string as_file);/* 
* Funktion: of_open
* Beschreibung: $$HEX1$$d600$$ENDHEX$$ffnet ein PDF Dokument im Viewer OCX
* Besonderheit: keine
*      Hinweis: Eine Dokumentation der Funktionen gibt es unter:
*               http://www.amyuni.com/WebHelp/Developer_Documentation.htm
*
* Argumente:
* 	Name	  Beschreibung
*  as_file Der Pfad+Dateiname, des PDF Dokuments, das ge$$HEX1$$f600$$ENDHEX$$ffnet werden soll
*
* Aenderungshistorie:
*  Version    Wer         Wann          Was und warum
*  1.0        O.Hoefer    28.08.2008    Erstellung
*  1.1        D.Bunk      31.01.2013    Header hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*  1.2        D.Bunk      22.07.2013    Schnellere Variante des $$HEX1$$d600$$ENDHEX$$ffnens benutzen
*  1.3        D.Bunk      25.07.2013    PDF nach dem $$HEX1$$d600$$ENDHEX$$ffnen optimieren, um Darstellungsfehler zu vermeiden
*  1.4        D.Bunk      29.07.2013    Schnelles $$HEX1$$d600$$ENDHEX$$ffnen wieder ausgebaut (siehe Hinweis unten)
*  1.5        D.Bunk      13.08.2013    PDF nur optimieren, falls es von Crystal Reports erstellt wurde
*  1.6        D.Bunk      06.11.2013    Pr$$HEX1$$fc00$$ENDHEX$$fung, ob das OLE schon aktiv (alive) ist, hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*  1.7        D.Bunk      24.10.2014    Optimierung bei PDFs aus Crystal Reports entfernt, da diese nun auch per Amyuni erstellt werden
*  1.8        D.Bunk      03.12.2014    Zuletzt ge$$HEX1$$f600$$ENDHEX$$ffnete Datei merken
*
* HINWEIS:
* Es ist prinzipiell m$$HEX1$$f600$$ENDHEX$$glich, die schnellere Variante zum $$HEX1$$d600$$ENDHEX$$ffnen des PDF Dokuments (OpenEx), zu verwenden.
* Dann muss allerdings immer sichergestellt werden, dass das Dokument wieder geschlossen wird, bevor ein erneuter
* Schreibzugriff erfolgt (Z.B. weil es nochmal erstellt wird).
*
* Return Codes:
*   0: OK
*  -1: Fehler
*/

integer li_ret
string ls_Producer

// Default setzen
li_ret = 0

// Zuletzt ge$$HEX1$$f600$$ENDHEX$$ffnete Datei zur$$HEX1$$fc00$$ENDHEX$$cksetzen
is_LastFileName = ""

if ole_viewer.object.IsAlive() then
	if ole_viewer.object.Open(as_file, "") = 1 then
		// Zuletzt ge$$HEX1$$f600$$ENDHEX$$ffnete Datei merken
		is_LastFileName = as_File
		
		// Den Ersteller des Dokuments herausfinden (wird zur Zeit allerdings nicht verwendet)
		try
			ls_Producer = String(ole_viewer.object.Document.Attribute("Producer"))
		catch (RuntimeError err)
		end try
		
		// HINWEIS:
		// Bisher wurde an dieser Stelle versucht, durch eine "PDF Zeilenoptimierung" diverse Darstellungsfehler zu beheben.
		// Diese traten vor allem auf, wenn die PDFs aus Crystal Reports heraus exportiert wurden.
		// Leider hat das nachtr$$HEX1$$e400$$ENDHEX$$gliche Optimieren in bestimmten Konstellationen negative Auswirkungen.
		// Zum Beispiel werden Texte, die eigentlich abgeschnitten werden sollen, durch die Optimierung wieder vollst$$HEX1$$e400$$ENDHEX$$ndig sichtbar.
		//
		// Mittlerweile werden auch Crystal Reports $$HEX1$$fc00$$ENDHEX$$ber den Amyuni Drucker erstellt, so dass eine nachtr$$HEX1$$e400$$ENDHEX$$gliche Optimierung auch in
		// diesen F$$HEX1$$e400$$ENDHEX$$llen nicht mehr sinnvoll ist.
		//
		// Die "PDF Zeilenoptimierung" darf an dieser Stelle also nie ausgef$$HEX1$$fc00$$ENDHEX$$hrt werden.
		// Falls eine solche Optimierung aus irgendwelchen Gr$$HEX1$$fc00$$ENDHEX$$nden doch erforderlich sein sollte, so muss diese bei der Erstellung
		// der PDFs erfolgen, indem man die entsprechenden Schalter in der "of_prepare_printer" Funktion des uo_amyuni-Objekts setzt.
		// ole_viewer.object.OptimizeDocument(1)
	else
		li_ret = -1
	end if
else
	li_ret = -1
end if

return li_ret
end function

public subroutine of_refresh ();/* 
* Funktion: of_refresh
* Beschreibung: Aktualisiert die Anzeige des Viewer OCX
* Besonderheit: keine
*
* Argumente:
* 	Name    Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer       Wann          Was und warum
*	1.0        D.Bunk    03.12.2014    Erstellung
*
* Return Codes:
*  keine
*/

// HINWEIS:
// Leider reicht es nicht, die Refresh Funktion des OCX Objekts aufzurufen.
// Als Workaround wird das Dokument neu ge$$HEX1$$f600$$ENDHEX$$ffnet und zur aktuellen Seite gesprungen :/
// ole_viewer.object.Refresh()

integer li_CurrentPage

ole_viewer.SetRedraw(false)

li_CurrentPage = of_get_current_page()
of_open(is_LastFileName)
of_show_page(li_CurrentPage)

ole_viewer.SetRedraw(true)
end subroutine

public function string of_get_title ();
// --------------------------------------------------------------------------------
// Objekt : uo_amyuni_viewer
// Methode: of_get_title (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 02.03.2016
//
// Argument(e):
// none
//
// Beschreibung:		Return Document Property "Title"
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	02.03.2016		Erstellung
//
//
// Return: string
//
// --------------------------------------------------------------------------------



String	ls_Doc_Title

try
	ls_Doc_Title = String(ole_viewer.object.Document.Attribute("Title"))
	catch (RuntimeError err)
end try

Return ls_Doc_Title

end function

on uo_amyuni_viewer.create
int iCurrent
call super::create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.ole_viewer=create ole_viewer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.ole_viewer
end on

on uo_amyuni_viewer.destroy
call super::destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ole_viewer)
end on

event constructor;call super::constructor;/////////////////////////////////////////////////
// Ein paar Initialwerte des Viewer OCX setzen //
/////////////////////////////////////////////////
ole_viewer.object.StatusBar = false
ole_viewer.object.VerticalNavigationBar = false
ole_viewer.object.SetLicenseKey(is_LicenseCompany, is_LicenseKey)
end event

type st_4 from statictext within uo_amyuni_viewer
boolean visible = false
integer x = 18
integer y = 1060
integer width = 1317
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
string text = "sonst geht es kaputt!"
boolean focusrectangle = false
end type

type st_3 from statictext within uo_amyuni_viewer
boolean visible = false
integer x = 18
integer y = 976
integer width = 1317
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
string text = "installiert und registriert sein, "
boolean focusrectangle = false
end type

type st_2 from statictext within uo_amyuni_viewer
boolean visible = false
integer x = 18
integer y = 892
integer width = 1317
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
string text = "muss der entsprechende PDF Creator"
boolean focusrectangle = false
end type

type st_1 from statictext within uo_amyuni_viewer
boolean visible = false
integer x = 18
integer y = 808
integer width = 1317
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
string text = "Wenn dieses Objekt ver$$HEX1$$e400$$ENDHEX$$ndert wird,"
boolean focusrectangle = false
end type

type ole_viewer from olecustomcontrol within uo_amyuni_viewer
event beforedelete ( ref long ocx_continue )
event printpage ( long pagenumber,  ref long ocx_continue )
event savepage ( long pagenumber,  ref long ocx_continue )
event clickhyperlink ( string object,  string hyperlink,  ref long ocx_continue )
event refresh ( )
event selectedobjectchange ( )
event objecttextchange ( oleobject pobject )
event contextsensitivemenu ( ref long ocx_continue )
event mousedown ( oleobject pobject,  long xpos,  long ypos,  ref long ocx_continue )
event mousemove ( oleobject pobject,  long xpos,  long ypos )
event mouseup ( oleobject pobject,  long xpos,  long ypos )
event newobject ( oleobject pobject,  ref long ocx_continue )
event activateobject ( oleobject pobject,  ref long ocx_continue )
event loadpage ( long pagenumber,  ref long ocx_continue )
event evaluateexpression ( oleobject pobject,  ref string result,  ref long ocx_continue )
event processingprogress ( long totalsteps,  long currentstep,  ref long ocx_continue )
event mouserightbuttondown ( oleobject pobject,  long xpos,  long ypos,  ref long ocx_continue )
event contextsensitivemenu2 ( oleobject pobject,  long xpos,  long ypos,  ref long ocx_continue )
event keydown ( long key,  long lparam,  ref long ocx_continue )
event keyup ( long key,  long lparam,  ref long ocx_continue )
integer width = 1317
integer height = 768
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_amyuni_viewer.udo"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Euo_amyuni_viewer.bin 
2E0000dbebe011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe000000040000000500000006000000070000000800000009000000130000000b0000000c0000000d0000000e0000000f000000100000001100000012000000030000001400000015000000160000001700000018000000190000001a0000001b0000001c0000001d0000001e0000001f000000200000002100000022000000230000002400000025000000260000002700000028000000290000002a0000002b0000002c0000002d0000002e0000002f0000003000000031000000320000003300000034000000350000003600000037fffffffe000000390000003a0000003b0000003c0000003d0000003e00000048000000400000004100000042000000430000004400000045000000460000004700000038000000490000004a0000004b0000004c0000004d0000004e0000004f000000500000005100000052000000530000005400000055000000560000005700000058000000590000005a0000005b0000005c0000005d0000005e0000005f000000600000006100000062000000630000006400000065000000660000006700000068000000690000006a0000006b0000006cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000d941e40001d2fedcfffffffe000000000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a000069eb00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d2fc4eb4cd3c144ffbd299536e60b9c00000000d93dec6001d2fedcd941e40001d2fedc000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000003f000069eb00000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff3014bb88016ee7e57006c94b0603f70718b0027f1ca18fe01f7719f45ddc29e49003dfc850b0ffd6ede4377ec02aef000ddca13b81660ef00bdbb9f97adc0df902badef61dadc3dc26a5f9f210cbd41f483810d2dba906dd836ee9608318821c7d8cb9a44ac03f6921e79780a1e6d72c68e18840ab8701f3e92c0f72cdfa5866619b72b01e2336e5689eaeaa4dbe7573b43577195cda1ab986ae6d0d6b734955016b7be10962086183810c82eb0b5f752107cb4e9c70811ef100df95343d8400eb015dc76d5180988a1d2ee356c881fb9528c81db04027d9a2f6e862e56f2e031a73afce8044252dd13402c6dab217b6f4680f0b03c2f4b4843cdec58c9bab5615740adc208a820486a8430ecf021530a70a18ad39b947fc523572e8642dfe8cdf85b70ba9e9f0225714f2d86bc03a89570b23f041a11a8611b4bfc27a6b75d74e1afd34b49ac8d26874d146a3a035849f9c7277ae59714b09ca5b9d4323e3c300154362a1aa866547b7406ad11ba8378309d71d71d511aa29d509d5d2ab2095a1d5452aa8f556eaaa0355fa80cd2a3ddd24406abf5d1ebab274938e7453ad2e2fc13a1d374d3de205a9cb72a104b10f0400c2072978d61e05dccb94360296105c52c2966208e500c2093904009f487104ce4028ced04ced2826a504822941354074d69853d086e8ad9d55a8b6877899206b453f08d6a0c4db5846a5a29f1013902d082900ce40333ab4033908c0ce4e086588255638101d500202767513c40d377d42e93fab1504d44cdac5725df4291b16594604c1e04903c093de6634ac0920952a9b658b1644646968695ee97c694d684d7ecd7c4d64d43dbe5eb78f691ea1b3e5efcf1b246ca153e5ee4f15245421fde5edf71fc47fb677e5efaa7b6bed7e3695edb69adb691d5c6d2d50c0eea060c95d32a1e14230657157211269a99d59d307d9086ef10a90e042ef8414e21f1035842c620fb2789429f93f7f4a14fe2c21da8a1bc0208505e2a53f8ea17f627566ef96c9eb45349839eab70d4363f82d4ded554297722083810dd8fa831fbe7ceb58c71f2b1f6a2b04f884dfb42f6f10fdcac381c3bc4fc4cc5b80bf6062dc17fc20c57a10a5a315e808208728216e8867b485207a10fd73c083ecc859e18b853f242d18f231e72a18aa57b7647e6c98b34283449352d5060340f4ef8b10fc1636f162561c5967cf862d8c6f3f0c5b62d4dc31c4824188f01b1941280e2c6dc1c326ba937b43268064d121afe01cdec58d88194fe31a2ac5873c58c0514aa5f0c045f0afe180b7028fc301e180de86cf7d009c206bbc03d1d62c451a25ac18aa38b0b7e786fce87e8586fdd0df9d4330bbc064614d1d7c6ec58fb10ecfe31a909aa69a19fc09e6820616f8fe131a87c01882614d8d43e38d4372000d8c0033f002ee350fe350e52fe24ffcf869533049f0a1f39f0d937f9a78b3c6fe015bffbd02cf156e2b07ed7e105816c46a00fc193f8011b696bc6affde1fbf8c7fe421feda6a822848b03e39760ddce151ff2d4a877bbdef57c39708dd2a192a21fd5f73bd5f659424f4a874a860fe0fef801b60065e950e8450e7c6a1d2f019937f12426142af1140aedb56d24742e84ce2f8338032f91b4f2ff24d6fa52ac6181fa50aa143cdca3a31007508712787f9cfb05e926c42785d6214da0d88501a0c228dde0d89b1aa0c828042d742879183aa2f347ffe930e27413e6869a32e9e7fff97802df984d678fbec5ffea3d035cba11f74a57fe4fb0e4718c27a157f18785cff8ff2182fa1ab0e9461d2a9e2f7f90f82420f22c3fb0f825bf2ae95f76ac434ff16a086f7b1bbbd50684f7fcc08eeffb1d7fc87e487493e9619872e81ceea802fb6fec9d2d3fd47c6aa18c32398f846958437f5a22819fcfab3c61faeafea3c0ea1d30f08478fa1a4e04bfb0f1b10d18ba3bafcca788906a4ae2a52bd8163a7034938ae7844cb12ac1e8af459516d48b15aa36a4bd5aad6af579a956a17523513509f8f0d2cc9d492269db1529e634f15634225a52293df9277804d582b5cad06053b9d69515a5a0f8329bceb61d6c975c1bcfc71a0eb64faa2c963badadf18fd7241b909f34630f3d281011683dd1ba24745e696dd480fc085375df8ddf8df573adc4eceb502b2383f07972ed0f30b9f5078bb9e22714d0833ac86fbce6c996b1ffa9f4c9c42eea299cffafcd39fe6fceb47783b8f8345dc2b073b78dbdc626963383ad9a2fe7caeaff8e02308f536993a007bf89bc11d17f3b4ef4834de3968336cf3b5d03d24144052350c41401d9bf1050cda8dacd6010d3203353fba9b4e7a37cc188da2cf06619e7c80fbe5568da027c30aa00a0eaf30a1f1197c4c2beb43d019b437d333be6c23d33bf4999d62a1e675882247f68d4234a4d08bafec9b91fd8340e8fd563a48a1d5d7289d387ec113bec2183bec9d9e26dd7f5054036fd0d44368f3fff926ff29c2ef81f18d0fb9587f65a185da6269a1dd691ee8421762e1b1dc72ff60e7f2bfde591e42b40fcbdda2e4e14c5c57ff070bb2ea70ba1054d0cae015b2ff79057aa1ff9a165ead98ad1fbafed16f365385ca15cb2996874d9685a6c0f03ced6fd6e696d9db6b7df96f356fa16d9d0f6fd3359d1ffad03df5695baaad5bf403f4ad5bf40f280f5b9eb56fb076b7053746afda2ccf9b3a534403c3cfe87e05a7a73a0776c99ea5d80526398c8fb8d79c96d408f2a839d92e34194d0f
226555a040b44d654d5693b80a54d8a119335e72a88a3ee02949542a1f4d0e6c5039d8f70167a992edbb5dadffeb0d1d765e2127d7cac9deb706d301d64e0eb6e6a2f1773fc6c1c6c1f74a8369d14c4ed4d7f0beb19e9148bc91a57c6ad2dc69ac7771b3b86146bee3284efafd7c153cb60696482504b704d707770677b45505f78745fce2c1ddc695f5b904bf1d784d40ca9b4dfc201eb9be75d9a3fc3fd2d7eb0b581f04e4b9ff21a2f364fa015a20a6cb062ed621590cbc4154208440410b986ff10dff840ffc21d1e041bf00ff10f50e10fdc28cae12d0bce69b2b62fd2a641d0a9267207957273f59535d45d9700c71773879939b4e1e954d8d87d943804e09936d2a8e8c6f0c8402fc4209fc20b7041097c264ab92ae53cfaf9db45ae76df861893668eb32080eb936b4e98121279b5baf72281a224ca00603819b7f1269bb5e11ee0052c11e23400042be96ba5689c29eb68ec15a3f21b14037664d43c1fbd9a224fc827e0991556c1c0484353cfcfc987e22b48720c8c21c4d4f0956a51c413d415e0d204ece402f8de379f4a4e91ce358b1ece374b48594468aa20674301cc0741ec22047b9919d1e808a33913f3242be2f31cb0216ae42d7d456456e30ee84a03726683f8999b7e9198d2ef6a0ad85dd879ab422150ec18ccd17f556a47e80bbb1ac746b8c2f8251d22b476661770ba82516345bb3aa123556c454a97211f0e40e179df53f2b8bdc9cd76abfe6cb7140db489adcdbc3df4578b5c55f53253bfcf1ddcd3fb6fbebdc1843f83f618c394346431b0112f8270983814cf510619b8f1a295056ef200c2d7eaa70d4fc9fa2db977020fbb0eec6b512126c5b2d6b6a6b72b1d53585d77e52bdcdef3b76ab8ff25ab80ecf965616affdf45eb4e5af15dcefe1c85e827da644daf73f57e807f6e07b93be085fc9ec14ab9a0722a7493ac4a73b59e38ebb7471460d38bbd49bcf22a2d87416837c75e8f5b7e6c930db38db6efd012e26226a5a185ef397d77cac1451aeb1ec4b49d3188e2d9b06ee191d0c6090c2b55050d144d1828554aadaea9a48adbb4abd559df545d4511a0d15452c5653b5ad5a3dcced61d9dc1a348a6835d315550db55d2ed7b9e96a9f022c9fb85943956bbf42264516ed657701e66301b848887301e37703c71f07bcab8c3c2a7e7ea10f4aba62de8d745d63d310a35201ad24a1112e605b8e22bec6dfcf693bd7893f1b0e9067a0520f1525d14e3a541a350d2854b35b25f66b778346e68869689ba5fdc97dbd5f455b9d249f46c23a2946099fbcbca9a51619e9a9da14a797927e372f728c064c83453ce8abfd1784c391016a10314c5c181088ae0ebc503652bf630dae697324f6e1eb9b1538277029fe04f7c61f91794bbff66b9a7a3abfb663682e9e50ab715b3d2cdc1c624e91ce7264c2113f81d68172fd6e85f408f0e23fc65a462e171ea3a30a1232d4cb438243809860c0a36026c61e284629a2c5944a25514f7477688f9444f471b1699ab6835a290f689da0e4572208d2c1f6283a39b016fdeaea478168f67c2a379acc0a1c386d4544c3074a8987305edc788ca9cdcfb7445351ac1cba7517f00aa22eafc8e5e68b8e5e2aebb2908cf2c615214356ec72cb6c9164110b4b912a349053e4a4a161a5b56b5a61c3a80e581117374eb458e12aabd872cd6aeb6b12794040acb72d22ef7ddc5bfcdcf7d55ccfe5dbd3b3f97bebb5bd3270e9e57cb530d126d93566663f6e11f573f769afe69f7db9c1fedf0e7dc8ffd365f6ffb4cce18f7d4dacf7479b99ce07747017bb0a8d440aee8ecc5667148a54f38f73b74e479384a03649c53631109be025f1591ef068a84339041487486ad344ffc100b2097c269fc209439b826029416086880e13d6a380ffc51d8b14b3e6cc5268d116d369358f6980d31cb937899f184947b26e2c2c7a34b6716030b29226194cd77a3efe83993dff06b7a5526432a91acb0eedd9173266a05b400ba1a9b70a7fe7e78dac04bd7748e78a462b5d5ff85323d6d5f7dc891f7abe62b788446dc3f9134fcfb225e614b0e9d1cc28f8ae562f878cba9d13a739e9c3e440a9da67c991a246c427b7b0f8967125e452a812f562fc6ae762c73af33af51fbabdcb3f36ef1978cc7ba6f8e6384cc74df3a5f213ce9b0e17fc17bc23b81b5cdb704bebc397769d0e351476ade753736d70cda74594ecb147108b1952ef4b541117388bf0074ec30de568468d0c30fb67d229cc335835497a2955c2e9de285cfb5dbbab9475c4eefb8582bef44c01c55dfc61b7ef5480d75a975b7958b758151630eb46445025342e312dff250a0d0dffffff3020310a6a626f200a3c3c0a6569462f2073646c2f0a5d5b31205244203020343e3e0a52646e650a0a6a626f203020320a6a626f2f0a3c3c6570795461432f206f6c6174502f0a6773656761203631200a5220307263412f726f466f2031206d0a522030650a3e3e626f646e20330a6a626f20303c3c0a6a79542f0a2f2065706567615061502f0a746e6572203631200a52203064654d2f6f426169305b207835203020332e3539313438200a5d392e7365522f6372756f3c207365502f0a3c53636f725b2074654644502f65542f202f20747867616d492f20426567616d492f20436567616d490a5d49656e6f462f3c3c207431462f20302036203e2052203e3e0a3e6f432f0a6e65746e5b207374203020343e0a5d526e650a3e6a626f643020340a6a626f20203c3c0a6e654c2f2068746720302035462f205265746c69462f20726574616c6f6365443e206564
2E74730a3e6d6165729c780a0d6a4b5175dd0c30c4813a14fb303ff247e493b40ca141be04dd374285b67dfaf42940c994df5921e60bb2e927eefea0496213bb5e530fefbc29f3428411e8e3530bd8e5f2e29a37f549ccae875ccacb98df4320179981e8008094e5f11114ffa2388ca503caf855e48fe1b6ae49ed87b0feaac98abd5ab72318313e883e0c7ac41a2f6ad15372723b2e4f587ff71b37b38605f1a0c67f34d26c17ad370d8bd9a6361ef5a293f7ae31233f824bc24383374dd8e92ced443db23e06f7371ab26ee5b46f319f8dc58b7afea376ff2eeeb6e9b387ef7f2663ec85b8ebe64c6a9cf5db417db062eb515d95f2f1b189fbad55df0c1eb864eb3d017e650aca737473646e6d616572646e650a0a6a626f203020350a6a626f0a3235326f646e65360a6a626f2030203c0a6a62542f0a3c206570796e6f462f532f0a74797462752f20657065707954422f0a304665736120746e6f5a46522f2b495341656d695477654e73616d6f526e452f6e69646f632f20676e6e656449797469742f0a482d6e556f54646f6369203720650a5220307365442f646e656346746e6173746e6f2038205b205220303e3e0a5d646e650a0a6a626f203020370a6a626f2f0a3c3c746c69462f20726574616c46636544650a65646f6e654c2f206874670a393132730a3e3e61657274780a0d6d4d90559c1030c36a3be04f8508b265bc8636b24aa2f052e203dba86d08d8d2c8e58c496a91df6f85203253f237cde3c176d51a7a09779daff4c1c2ea6f3a3094b2b0969939340c21d619d38fe5537499508eb33692dbf70218fcee68fa95d750bc497312c362f7614fa87b404fcec4b6bdb4fdd8f18d7ee809f266972c0d3447df6a958d33d0fc75d0ec1541da5df15977fcc20e70916f7c8b74fa2e512d2c1127ed621b6a947d423549bf50fd9f6f20578c353b557edcf93f7750957cffc80fb32b33a428cb2b04e716728918afb1e99f367e6256f40fea650abb727473646e6d616572646e650a0a6a626f203020380a6a626f2f0a3c3c657079546f462f202f0a746e74627553206570794449432f746e6f4665707954422f0a324665736120746e6f5a46522f2b495341656d695477654e73616d6f5249432f6e73795344496d6574206f666e2f0a3c3c6967655279727473644128202965626f724f2f0a697265642820676e6e65644979746974532f0a296c7070756e656d650a3020742f0a3e3e205b2057203931313232375b38205d20375b20355d203232203836203232375b31205d205b203631203737323939205d34345b20205d20335b203536203232373834205d30355b20205d20305b203534203333333131205d355b20305d203030203337203333335b31205d205b203132203030353031205d355b20345d203030203037203635355b35205d20355b20335d2030303831312030355b20205d2030203130313334345b38205d20365b20345d203031203736203636365b35205d20355b20305d2030303531312038335b20205d20395b203734203737323131205d355b20325d203030203837203232375b34205d20325b20345d2030353930312037375b20205d20375b203835203737323134205d33335b20205d20335b203938203232373535205d30355b20205d2030203330313030355b31205d205b203731203030353934205d30355b20205d20305b203233203035323131205d335b20345d203333203739203334345b38205d20355b20305d203635203634203035325b31205d205b203131203030353737205d38385b20205d2039203830313737325b35205d20355b20375d203030203034203333335b31205d205b203530203737323838205d32375b205d5d20326f462f0a6544746e69726373726f7470203131200a5220304449432f49476f5470614d44302039203e0a52206e650a3e6a626f643020390a6a626f200a3c3c0a6c69462f20726574616c462f6544657465646f63654c2f0a6874676e203031200a522030730a3e3e61657274780a0d6dd78ba5010c50830e94074f43285dd596ff007baba2b57dff8daf0bcb51d8e7648c99cfe0accca7feb3e1e399cac96020491e509ac1e589318d9ac152ced56b7c441cf61d644e9747d76739469410ab0c34d52552cae1b45c9e0f3b8d3e6f17e294e9697c44c21ffa650adf037473646e6d616572646e650a0a6a626f302030316a626f203730310a646e650a0a6a626f302031316a626f200a3c3c0a7079542f462f206544746e6f726373656f747069462f0a724e746e6f20656d615a46522f2b495341656d695477654e73616d6f526c462f6e20736761462f0a3442746e6f20786f42352d205b2d2038362037303330303032313938202f0a5d2057677641687464693030342074532f0a20566d65432f0a3065487061746867692f0a30206c6174496e41636920656c67412f0a306e65637339382074442f0a31656373652d20746e0a3631326e6f462f6c69467431203265203020323e3e0a52646e650a0a6a626f302032316a626f200a3c3c0a6c69462f20726574616c462f6544657465646f63654c2f0a6874676e203331200a5220306e654c2f31687467333333203e0a303674730a3e6d6165729c780a0d78097cacf0d9c51b56aeeccc759256b796ead7596f92db2c3ad131cbb13b69ce4c13a7210402039c2039db1a867310812db894242849a16738bf770d681381ce1b407c3140b6928e7c0816816dc14281205a534a4677ff96dfb68072f3fffcf3bcccdefccceced73
2228ccf7bc0c8423087c5dfd88f995b2e18403fa1420a18bda1045c59fb35b2f850f5f2262cbe5f0d1e429ecaeaf24414fce4eb0d8908489e7df4f56f8cd7a8585a69908a7e36cbaadabbcf9456e0ba11a75f2f8ba57f3e657c1d1093c5d567a8b7ed3cf9e2e2b1555ff78565ff4409f9ab59acf6a2df9f2eb5efe1ef06554dcfb1ead7f3e59df05a28585f976a7c79d3ca84dce886eeb0f3f6a6a596fa35abbfcfe3fb5661433ef1f2db6e6fe8dd6afa1b52122ddda120e916074fce334dc81f45f4250b45df2fbadbfca1509c02b2bfe25f0850de61ab934c6010c5d88425e480f108c9b41e617e3d484616f0789f0834295d210a71af9801cfc9ac2211a73218a8409cb0bf6420885de721011f7f15090847f720035d617a1073c304a844cf89bf2fde001f2aa10c32ca07aef00d423a8411f66b4d082d9d99a106b26cb5082fbe1da84d086dee742d5c03cbf25f75866ce6ba4433e86524847e88d284904446ac01685904ff8472b708880f90db88cdbb87821f1a11b90849c20f765ae51f01ab08cfc8e977285d0ace09f010b4fcf03ba08a1746146ed67a0570a416a08d0d426a00f33436e811f682bd0f88da23210a3c445421e8a9a2f87ec112c0e474f9bd1bba087d47ce85027403e77a2b51c99fa05b01d907a86863fc6653cdd15b8695a047e2ffa3351865f14749b98c2e78a524cd19de5f09381c823e38f2fe3e21fb901bf78700fa1099a3f7c19910fa9f416d0c59741643dcfc617a2cb462a506af883d1a00a31fcaf83b46eaf8fb7e621d09346856e1af451b46cd408734378dd6f065d64781d8f3ff1ddfc18f39fa25d3d085d11866e875211a10f7b0b35cee8a28c902d07341cd0abda832b8ad89b363c65386efc653e7d107d2879e492462471844e14b42cd107dd177d3a3af1ab758efe8908ff06b8afcf0a3f37859ff168ad6c60fa84da3dc00fe46123a18fbb105702b86ac07107cd025039689dba8700ff7c2f715b8e3a4fc11e2774857b73345e3b2ee3ff1b6e412a38f8bb84608b8df0d3d16d0d38d3905c0be0f8fbc75bd8e5427595c330b51c745ee8f1c61afddffbac0e09713fd16b91ef3c85f196c87f8d0fe323516300e747aa3f0d68c5a2e815f85067d580c7afe8b3d081a22bf8cff0af9653849b09b587dfe33029a28d3d6876f601defa17c3421a58b30ebcf066196334e0e78f51bc2af0f38781df134df89bf1d20122a20dc4fe4b7f722f7261056be0b27a01bc377c1f238ba21684c0d70301e61f7f6a0e7a10fb1c36c31da33065c5cffde1d7153224c92bc9fb9e46ee1de4467f276e227729b8abee49f7d740edf116ee8153023e6ac16c17f0abf0243187fe2d78a500f9181f3919c83935710b898f37135ce66ee4ebc97ee36ee3ef8afd12dfe51f84cb0966b965c5473d7ee4ef037e3ade182a0793a2950c57f407546ad35011730f5f186a6ae87d3c8eda2d74f97a056e1e83da3e853f7985d0d7a18e4e8120dbc0094883af812f9877540e5f9e15be23f863f1bb3e1cfc699fc3df86e10487d3925a93893a64cd25846e45599c7236e7e23e4ebc6e0adc3ccf0fd70bf730ee2e9e788f26e12a171f10ec299928bd541ee299c5c6674bf572c64ac746c9dec73a6e715ca1dc8eee498e3fb9d308df182fcf008fe3b748c39706ef28c2cf0bdc1a8789402325e8f3d1d6363bf402c130cf8713bc50014a1a80033c596b366782cff99e173e8bc42cf0978659e1d9e18be375f1fb82037c7af89dbe2efedcc1773df187e2f6c71e78610d79e147c43f8bbf119fc27f01c262208c484735660648a490664cda3c1e7276781ac8abd91f487a907a1800c847201c8b959ceb32dc65709bbb97ae19ee2ffb0bee55ee7ca5f09e17e46f8aebf8abf05ff857f95ff06ff39a617e094bb0b17056e54678abe6ab55a5dd552e48faa7da89544675f172e21d7155f16a69011d5cf7980bf5f2c96fa1bc15ea94afe228565f02ef24611eb9382b0f9e2bb8f322a6b95bb8cbe11708dfdf8c9c534bb9dbc2f7e3d5b83fc9d373017835b939070a795dc0d0bfe3416e841ef251f8c8fe4d39f23cf0dbdff38e3135938fc3d151335ce5bf088f02f5fc6d3bf272c8e33640d4771cf211f8fd773db08350cfec2bbf0b3246bf22d158827f5bd5c0bbd2f09dc96425c8af57c45a074ba15f0b161fdd609ef584ae25c66e4c2efcabdc221701f4f0a7c37f5e35201d987c2dc6f832405c63b89051714687d8b7c1ea2f813f052308c3c6df07b887e303d11b71018906b6782a81d757e00b9964ea2d396c4a2f6a229c83b85527b9f38c1ab9c706fc4a414e1cc26dfc4ced038077d0e531236e0340d369905716fc9a13ba2722dce9fde40b625493803b086f4ae3eece8d2879d1a88bc8ba03e378019ba116780a3a25504a337834d5d0bb932578fde320d9fdc8c61a093fd614a297c074b481be80b6d8c82093b0d5f0a5c27ffc827f2b7ea40102ba33fe2359c0cb9ad3ce282069f85bfe41ba99256780eebddc82ea43aafbe83b516fc296168076ca80bb73002e80fff03ff39d7ed062fd76c903dfa30a5f1ff7324196e6f71bc29e052266988bd09be630cda01de7c0c9bc904cfc0a5f8c777404bc33c4e81b54f192e863e033513bebf1bceea5a077c79f8df7e3b9a1568ffc810fe3843e30dda156d16a92102c93d8c8357cd059f8633bc7bf4744cf6e408a3c816f13fa2760e305ff3c813c2c9f03bff3b6bf1d99d96435fc65c208f5832d072d0a8e5d127a36eb0cfe55411b93ff6439b907ae74f8e8bbd434c707f1dc2e8b58fd240cbf1eaf6893ef
22e9ec80282f613e47fe0eeed0f1869222a71d9026617cf4a0d047423703d3ee3cdb3f895ca24ee364b463ee6ebd00fb9b1247810bca904894f481e8427c610438c0ef7b84ca9569b43964c03044f14383315a11e5fca9ec54791ef7191fa3240cb21dde0a3bcd59bb14a65343f9f5b512b29281c4b49b77ca2fe83bdc0ef7081092cc2ef75e2075bdc9aa795ebb980500e8809906f70f68fc40841a3675bdc290dcad1c2012f714fd1dc0bfd4d7d30403cc190d8e2fe1d0956d41c7b81e3041f83a1cd42aa257346077dcb5a6408dee4109c21c7cf020a70820f70d68276102da78107d840fd882649da10521728f7096f738c28f8826fbc240d61053878109d8ca047c257b98d3572a9302abf722b246bcb75ccbebb22647f005fc094a2b019986b252d1c93b216cf215e453510bf92e28ff97137a6bf5bea798d93ec0d9aee8ac651256deaeb1d1ef58ecc69e69157e9df1e8b7e694fc1a5d410d1593c99dbdcc31845422193258dc1c9be50baefaec8d8d3beaf361255b496046b305d7dbdc2f6aa3180d40b98980d53542aa18952a513a8bcd50311225c75b5b59ccf4ba3dcb0cbc0972b3bebb7ae234776fbd9ee5f81e5ba77e5e3262c5e9c2d9157dc8585df053c1c0fb5f0fcf23defa6ab03abfe50f8fd5154bd54e0e587ad46851be5c53ec014363c27f9a12efa74b8b6116df16f78b6ab15ebbfee604d48685e5f3730d9ed58156cf46c2bb78bdb221ee7ee789d09ecd485c099058b66493ba87766d37112408598a3d8ce208800edbb140e55e4e89c307ddd2803d603964e4eb2b0a60de8aacf223efc08600207e193c51c98719f7fc303dc5fa77fc61a7b084ab45910eea127f187d907b2258713b40380222b23451e48891edb7c51e0a16198fe3d901764e4797204b4f4622190d20120292d465f217028d49aadf55d0200a4f2ee4cd10eef4315e1727d23ee123af875fc02ac9d758785d0014cdb0778d7e6add47afa5655d0af1e8c474a09db253c880a1bea95301289873c12480d4b939c6dce6b13b8bde171b9e8ddaee708794d69bd6a9638aeff7ebd993f971da1eda179875db1c39c3eaf0f3b9bab1fd14a49e95e5bfdea8ca1ad7aabca26244927e36d5d0b80bdb208fa7a101c4fc7ec0b27babb8484f1c4ae058d46290533431ec36e8918f80bce41bf0378c57418483230eb0c088e06281ff9c832291cc52673c238e351994100558fbc2f83ef540ee1fa0ab8747bc3e70bd2e7538847c940f4547f2f0af2c6e5e1efc1d1f249fe060417d2224e09b5394d3f2a368d293aeb635af325b3f371a3acd425806ea9d6187f006e17407cbf30b7407db4a94117a18ab84005df915fbdf07b1ae9bd1db9e15e5579efe5fa2da5dce7f9c7aa3addef5985ce61c5120434af5862837b155d5df05df85f317f18ceacd851bf42b9a4d5a361a57a87790af356ab7af32099dea9cc42d49e0539881891e117c02bc51c23072b139a06221d69345669f8089ac8aaa3e42eca8028cac3a0e5bf0a4e0c81c4d8c56b4648b238f659c2d9158a85f18f4494250d12538273893d89df813e09123805628da2b8f4ceb44b4a7f615538a761559d158d9d19294b2ce9efb46bac8c0a3d3a418b894d456d53373cdab0ee2f114a8fabf514344791cb021a971544d7ceb252110ccbda0e591350536bf250896bdaf78da83a1515a79755d5b30abcbc3da011130a8e0949290b3009dd765df47e275f874be765b3fcf55d1dff7c5789fbefe7994cb2a936f3bb38d5a5a6cea42278d7ebef0e3d67c7edf0bdbc3c768fdeafd1f2f6bc6dc9bae47252bbdecb3edfaecf7a94a0b15cb7603ddb4083700f65340e7a9ba2e73aaac35e201ed701d5120abf5267458af4ce606c58f6d80f5c49ed88dbf44e41151967b01fd2669ca1263b60ab1a0c37f09b8d37e420693500a69aa69de60dc851a6f29caa7c94eb3e37620a6c28309057e41e46a184fdce2dfb059ade45e7c47d79079f1521e7d8f7dee73f4422080e42bef72d0f8f1350e63da93380f7f22f76304c7eef77c09b5e9a29654a72fe3e5d24714523f9fe8e89ffca9c5b3eb79b42a104acfadc56ed2064c9a36f8d3eb499b2a023b9b152ac98f6edd8bd00aabd30d4882c38bd20705964c19aac89438337cd1cb175f2fb17143c560ec3b940636c1b56b2533ce83a474d316a63daf9669285a69d0e45a2fcd4ab4d4bb41b7d8ba1ab7e7ea4ab69bb77cdb2d5b31effb376ddd23ddc477c7be59fa44748bdf11f15fa417a6fdf05f7af486f4dee923e989a617df23785f4a7f6a95f0bfe26ead4c4585ce07cf9f5e42dd6a31a3e1c7bb1ae889abb645ccdb563e95db6e3e4b24939668278f663dcc8a464c966ca63930e3cc0f8998bbdf9f48c2fca1178a43e30d38992d5e56aedd9b619ed46b31a2a5fcaf643bc1930f31511f7681f44f930df618aca3158ca78c3b7941f19c0f4676f5dc3062ae2854c59dc128ad531069f1035b8d63d3bc59798dee58cbb59d056e4c69227497ff234b1436956f1e3628db3f9c263fc2e906debf101ca903399809811d5cf603db79c2ae3a073986f63c3dc29383f3b7cfe6e796c64d55771bf0876f63b9ae99899b9f1f4fc3e77fb7aff3f13129fcc7d3393112ffcfe03fcf9baeeabe11221514ba503cec78481bb726540f9827bf8c98c30e80be34532814914e1461dff297bf77dbba61cb7ee99d16e3d30eed87dacabb99bcbbfda5768ffb76dc1f8a3bb834e09ee313c8ce7a93ae4cefc96a5213f883761c37110e1530d147c6fe587ad770f710a17bbc9878941c9cc835cc34b0d869da1d
296186206d8aa4a52eb031e434f4a571f2f6333ed86266b39b38a2562e9d9469aa3bf4e4d829541389159cef998982b9591f5764a7ef3fb1b37a3d9deb7e9617bad774f7aca3b30fe9e5869e9f3d36051c6c9364c660f4ab73517545ecd6e5447b0dbd2194284bb522a1875ac3fc244a8cd7d4794d21ad85db21c07826da1b30b57243e2a112db180caaa9f2a6ffc0b012fc9fefdadf5b7de1f461bcdad85e1bae7728bfe8bedc89eae30fdb23b07ecfec2ee2c4b3ab09d62a1caf5573f57b96de67dce1dd150fbd03cbe87a1dc45e67a369989ef354d3bab72c5580020ec4cb503a539892f79d6e75e976e92620d849352ada286ddbbd65ddcc7dcc7676a4aafb5e452d9af0da271f7d9be2d6f956ae248f7408dd84086ddf3f97011c881a346e23b76e2bddb1a7b53fe2f382822c516d9dfc78652d0d74c3479442b3c06b6727b84390fa1c2d4427a870142edf3256ac1c9307a101d4da62492f4d6a158abe64a1698aaa5970576ab04907010c58c7c4f92fa29a5e4a43396730405b0720d4327d8a781c29149b269e4cfa8a06d8b8055fecd791d756dd80bfe589821cb05af6ab7bd88132f2e86aaa143da3f83cc809102aa2e6664755831f1d8109b6105aaaabb3627bf1a71c48f63f4f39effd6e7408f82cb7757ee65748daf16a772d605d34b916d9f3f73db2f83ee6df3dcbabf960763a78a5ea9e1788401eb4cb0a77a778fec970c22c186a5acac8ba0ed1af0d92bbb8a627cf93479b7ee4df58ff98fc95ff15fb91b6035645b88b6aabf42fddd53b8a7629ab516aaf54ab01c551c61f5e8b76a00811dbbfd08402aa56e084927b6efd19bbf3e420b25081a3eb55ae341c10817994757582c51450a10f8938a5912adf93c04a2c58e3258cac4604a18fe9a8348903ced01ec45f952a8a7e22ed4a43fba9143232398c361919a0c6450ce450cbcf865e8565f2aeef2269d1437fc82350c0cfa65eabee7f3f01ca05090291ac71a2cfa67429e8d219019b1a48a70150e08026f5743f423299b14e543995683321422a8360649167419095974795fffbe3d610ddbf31b4d8e0896830ffa9c574d2e5bcf4d1d8f5a0d3a87f704503a78a843540a9785d5d693ec66f69ab93ac16e489ce2cb80ade42a4484f965dc4da5f5ee7aaf8a71992b936024f4503de0a026b2ba1406d9df1280cf39960571adaad6579a08126ef04b6efd31bbf2e82bf1a420759081cdb6ae8b0ccbae8ab708974d4b9d57d3c5ca8f4d415d427d5fba71ab8dc6eea1dd53d54b735e6ae3ea2a66d3cd41ea92b6641e7ff1e72242efa5a7e978a09ee4cbd044e07f423a074b846e01dd06403c702bd601fd992d98961617abb27ceebf3b155969b16f91c69a451b325f75856dcd7d8e572522a958513b4c9a74d1751b98a1d3260acd0dad6f958db99f41050ae9ab067d5214c7c6942c4e4c8f91876a44629b8865dd3e12a617c1ce5a2b9d3aa4ebcec5f0679d1b53cea61fe27ce5be7454e27f08f6209c1839e9e9550b59d6ae6ce4e19e9a3398e9e14e54e6997070ed24dc809448c8e0d429355c6b357b656cea1368c5eae8dce0d68ede975f4c6f39bf4cee8ddf481e8c3cac1ca9e9cc71c97007f9523e578f787ce4fe3a8544eb93f74be8e7e991d23fca63967894ee316a7a5d482c7cf5d2b8ebf4b9f3bfd3d7ceeb483f3816b77e4d1efd94102cb040e2e2078eefd756efc483e31242031ddf80a674e709076fede90397610ba4f9b549dd28aa74ee53a474e63058d04e5d9e7071ab51a20163a74a10097a757e552b8edf6caf04114030604aa02275712a52ec0bb426257d92648304df3266412182abb1b748301e7da441468d1345d8072a4ce99daa6455a8787722d5d67bf28964e80cb513a1cb7a02810ba8758170494ee5847ce3b8e34e9c65225929c678cced483f8fc786391c647219de4ca2e0dc016604c015d433cdbe249c1720516f3141bf84dcc6a8d8eed3b1ff173a47422c7c834305ceb6327c53e6f216a7f714748cbc8bd246c6afb1f6430ccfebf3b92fecd86ee5aa4488e2c36e3af91637becb3cf7e2b67ed9903b57fb683fc6b688f093ff1f0c56d0076eb4ad3c4ecb60bd7b42360e2d824ecca4638252bd6f5ac779177adad1138c97005a0c101040da69040ee67150d78a32c86bc51242633165916096830e0c12c8a62b1fe1ab5863d62ee260d31c345b5732de87c4a5966cd49c48a4b341e15e0712072034b6520fa4c6a609a6aa095da9635024c78bd32c01241227185da22d60748102d071048f14a0c6899f0e0cdf44b4529f8e2ba0d5f213c7ecb017abb1e356763d5fa4014189e0dba43747ae3cda3c16b7461991106a6e916286beaea2835c4a45e81259716696328b3a5962d470d65b168c9b2d4ba187e0f72590f813f625fc45ea6085fcb089dddbb336f68e4e324013d59f01d0fd11a84b2b4164376818747f3864f14a8c00a87265761c0cd4d1864062c98a1be92dd8b19820d9221b285632bba065d21ff079e392194543c2683398a5389c7ccd42aa005555101c584ea4b7fa2ca95fe71b92a54a50e770fa506fc18eb99f0a52076d1dc93484a2c9de499ce119db424a904e3399f8db57c6767e67ab4df67092c06ab527c4a901b52edc9925411e57c41fae80e7caa4d437b9d73bd78eae79d1eedf94ff1f3a371eff8d1f0bcf7bfdd62b956159a3c795293626489c5f2e9e23d624bb1bae5fde5f62e11e79ead3c24ef7eb9dfe38a1e163a6fc21719bf0ade49fe237b4251e55848dab8defb1045c5042062dd0816c4c25a5caf2143678de2595021edec04ada2
288b511b22962a0b6a4ac5d38a50b14f7160bcab3cac72a10d93960f94e523e5ddf2b9cbc72d94cc5233157a6626838b6582a8a323c22a66067cacabb820715f18726e5540455bbfce99e9b35dfb2b945368c0cdd853015e676a3c1a3fdea9a270e14a582d8ce3c3844709a3c43d870ab4255cc5100ee2385552c37d55a36f359ac580f922a0f8934202849e4f2a611fb2ccd10098c3eded8a92e4947d508a41ff0bda57f45ecc6ace3ba1dad89e27f8a4b1eaece84416aa276060dc8afe1ebfe17fefc0cd54d7d159e2f79e7330de673b5c83aaafefdf5b95ea448d2fcbb8ebfd6875aa688dc703d3fbdab433d9dd17fa447d056ac8326d7fa557ff304c5e3161fb177b1664d5e3564fb577b503640a9d84bb81ed090fdd3b8245b80fdfbb3ebda082052d90814db333810ce881d4992c58a2326114893835316b3187681d774121dcdd1fad58a57130d1f8617e186854dd8741348451f49fc81be91afa96f927df78f8f6f64712511d154ff1e19d9ec51fbd0ecd517657903c992e2fe49145dd57561f03d2183b436581aa99c6a52792cc04f982ae8a41aed544c20663910c873a6ad48d2a0dfd4640f3a9b75fe875259bf29e16f9590c4a9d514cfbde6abfd5a953c0538329a7b15e34bfdd254622ddccf72da1dd4370bc9827a757ad1bd789278f9d971baf2d5387ec213fd7c72d551069411feaa9251cc3c6f334ecf32a0caab8ea9edaa6d541a123e2685432ac489a169b19131bdb168c4cb113e9d7a47430fd32ae9fec54f631a35551fdf9356f5820576eab26acc2840ceddfd982b94083712244eca404a655d20f5f4c87c4835d04b304b59504c156a3469292b519f469d591ade94301352a2e62b4cf4943023315270cced8a89aa46c559b5235b353f7a4f71a27d307a42fda7cd20cca6433a6433299b658b41c2b1af158b39e32b6d59d691aaeaceb4725afe9d40cd895389a8774491764f0c90182bf63d9d79a367adcd57975fdc6ee68b5606a0735ae202a20b6c1091624532432e51b44faa3990369d619c50ca452dc511075dbd926367620e0252e6022f56bf887ca18c54dcbf5cc0a2947ce832d2c0ab3809f1afdc7da48eaa8e97d1dcef2d30f9d5a5e70345d85e7aa179db6ded99bf8dfb108cde0dfd9a4484bd6f63bc3f7ddef4eff3aeb44e79b2cbee135222fedfdb13bacb5f5808906f4c82f43530fb8c78195cb20e80e8c77e6e9d1799a3fdee61e8ba86aa848a12047950073513d5751f35a971289967d06a5a12db2cd47c7e3b1e11033a49208dd14c1b19a36e03689a50115d12b3ba7e2c1065346b1d48c968c269524a46ca289aebd543fa7de695d016e49ec14f061fb2af803d0eec0e1e9014387c1c39c3d940f44f4227ad1e889e45fd9c3fa9fb9cf4a19997f93f2cd7a69ee85fc9a92c79354504b6492e5e3270e5239d4a9279692dae9636a05b0640ce429b926a089bc74ddaf0cbe7f753abb2b8a5b7263ea764e6f269c033b27d90ae48b5a9b674b2a639b970e39511bd8185f17ce5bd87c836636309293711989cb477779ca05bb852e84a6ac5558d68ee14b48f50947ee7b9ec78ba002b92f36c5d0b96b4add0165c29ccd0525394592d0525592ccb8555ba249b12f432c963bb8b233b836c902dde602576edb584d7b4834cbebb9d5c4149282971845650b16b2a554e547b3caa72c91b3c46603f533070803c3d4f512a554c3716717d436308936d77c1961ee3771f3047883c1b0a7c09f2f930f167954d315e652bcaedc144ae461c124139587dff274023ba6c99409bfaeb1aee95f5d93dec3c1356f191d6376b744ddbaddb2b7acaffc48265bff4d9b4ebf826cb480da6aa195821b07f00207c3a2cb36a6089c299d5d7326125e124c935c995821e26eeaa07dc49f6ba5a876497628ba8271293d0c92134548f91ed42133eab10e532ea79ed33421b4eda6893db0e47c33db8c1390db503c9def433db331d61d4d3b5098a994c9676ca0992d4353d4c9e58994c800823501cc9079c8f600c98372ff329b4e6f22913176a3034f13ba7be5d59aec1c63d50f5b637d56630eb6ad7d807e306ac3a96997cab7cd4dcdd150eb8da1c56d1d8f171adcd8f0ee61fd31b6a599648aafe72d8999ee4c2fdfdc9559056bbf7d2931db5625affc267ca9bdae132f7ef91e7c5dc1ce6e4bc3f802a5eac44d3ae067987035b773f309726cc452088917f825a2f1f775bc36e571c80adc8cc89e1b515c319b24d9b7c99143192a12e731f7c0adfffff9330f610141da0fa4930bbe9c0181ab8179c03a97cd238c6c72ae70ed8c6e5ca98b6c50454b82e2da26da2d23ba7222cc0208007c236ec62c38c9a478e1638e9e9d3c78b9f495b7d8b8915e91de28ae2b5aabe92daf8d7ee3f7490de20dd5fe92fef1fb92eef44f64fdf16bef59faf96913de7156d54622c39c6be2bce371b76547f6ddcbc51f7dc2af2817dbaf4e8e1d3a8e045a2c60d5aa2fe4b1823d94cee2e438171523a818b8ead3bf053a8bfbf211843be5547d5fe3c3ec3edb873284d3f1613b1a62628435a8a87b287ba9c7fc699c055d18e48e46a18bac4a63a5eb13d623c4c40d8febb930d88d328a4017191e8b2c682e8392ed7e762a1be59fcad86808d48d27977b81e39b325b02687e4a0605e9f24583436689c2f24621b4e3d44207701ca0430b324e1f1462a05f2dc7011891a22cba3eb092932501e623ccfafde83d0881c4039aa37a4d5fed08726ccc36652857a608c1c2e259bf1c77bcf2bc5c4f11dcc67052bcf4c892c0eed52532dd5325145273f6a97d1b6b1bb042b5b5bd
2Bc17ca45bdcb1b1b2056613632bf5226e48da432b7c34b4a4ff15ae414f7282f847ee8ba9e51f1ace50fb71b69b873a259091385525bf6cb3d8cc50ab447962dcf991d3ad23a8a611e7955f485f990b59204da7651a330eff6cf228aaac5565146446556d66632c505781acb78f90abcaaba6944f3a068af52f5e2bd5a550cd8d557f1e1f7a46d1f189c5bf3dc9d4ac9d88a5385ae52c6c4f3b346a517ca82cfabb29a6b0a31a9cbff9357ce886414e329191808967c993b7a65f57a5656e309bbdb3ce8dd6e6588acfec8b62d21f67f49672d61cda3365a4da13755ca351dba10dec5af2cb3fb652426d3c6b3c9a6a9ba0d6d82dd579b764a328a35aaadc2ce0559ba59ddcd75ad3859ceb301bba55ba6f683735d9e699d07f13b7af749669767550ababaca2796346ec09faa107a47ae3e8c9a7ce9e8cba46a1b8bd89e877d29eb75102a0d819934e8df5e77425e8ea52e7769997271ae712716e7226c035e746e9c674b4c091a5cbfaca7bac0d59485d3730dbf2baf331d65c32910655411d1ababebd600cfe16eabf35401aa77a098d17e84547f11419110323fa8a9c895e8e08fe90e451b448448cd209d7bb0364e30db19f9dcf8a558a8854ca1d8b233149c8bf6262253e223cd8f07af93bf9b9bedec213d1ece4be3049a3d303a7a8b4936172960bbcfa44d8f4ecb8b4692ec907da3b37ce692b2a64c936d0433bcf2ae27c1e9c6261fcce46711ce1484f24cdd7d5d6b0469513d6551355ad89072820919746aaf56bd991e4d58b203070783778c849345ababd503ad535c660f2478b06a21063b287a35570f7b51495b960b276e980947026702dbf05ee28d65bb4081242f4c21eb701f5969980ac31245553a998d870cb548d93a9954e50ed03a4450e32eb24ed4a1e08168cbac5a71759500b500b5073500350f89ef7d633bbc7034e9a7132e3bb0d15a3a226003b09ece8d1b3fcdd6cec2b3b4a0cc6c1a03b5533c92aaaa06b86ef8c957a59cfa7e2f12f2366e70b468a925137bb8352b1e499cd49261d68b9ec6b6fdf01a2a8753eda590ddb7d41d75d9b97315cda5de105caf58305176d95e50da5060b65d5c929fe12aec7731b1a24549f98efeb1ad5dc03faceed2ae8f54a5ccc93f1f4cb7e700b5c487dff00de09e3cd3adfc527abfc60041a4c47b213d03bb1efc4f42080fa6510a0f5b817487f2c154a9870bc07056f0397ac09ec3b3ecaecbe33298af71f4f4cc419d85b6ab292da74366a140b0c3ad5ceb1e205730ae7e345c4f355711e45eee841b0958381fd47971e4c60040fa04f819e1d4d7be738179dba8696ce0d9eddcb76cf3ef301d6adfc01f380742fb2137f8d3f00f5c2fe21e7a4fab1ec69f24fcb169154ff0ecb42743fb90e659a242a09f8e4fc03f04324511791b2014b49e60fe81ddc02901410edd4db32637c0c09c054f0bffbc8b8107e9b09ae44688f618a3ab52ff5281432524c0c96afc978179dfaedc7494fa27ad4148d2800d07a8de823441a02d0d2045b591e82e9317d7c8bbbc628d630f1712a53962b2a92548c5051457f8f9b0735cfe5ef9056b9e9df58ef5f57dec9d76f9ce27a3e4747664c9ddb197b5f8c14b40aef5cedf72f5aeff7a62f03ea8b806e3d71ebebff07563b128dd81f199c923761ecd037a490466badeea60c647aa9445c2994bfc4eceb2531fa98bd551aa6a463b24e1531c5c2d1974084468de44b5c08fdefebff5b83e39274a2ab850baccfe73caf262db6fbdc8d57539fdff43fcf1beef5587673b8d86db51534965afbf0af93f7dfc237cb9a8fade9ec2a20dcb9736e5e426ae2b681e90d917bc85d404d54e140c8105696c30921619631fd1242a308f8eecc509a2c2110477416623b9dcbd12891df4d5034422d1916caec113b901bd9d74a71e1784e857c8bea9196c7819b760a8c5d8eba8e4edf2aa11e5ea4575f9984ed1fadaf3271e4011f9725c36a8bfe444c2511faca24a6c521c8a0e297a45bb1fbf1787a21f98ffc129fa39ef9546a61d5060d45bf22a2fc9349e60f8a935b30d80016cd3464500736667dfa2352d01ef1f2f52c5dac6197257576cf2f37f32ba65ebabab2cb9adeeae5d9d4af45dd46f64b827364f24080e3278aec36d2a3a7fdab54b7f668a194cd5e3c409496e78a2e55bb5705eb22cdc58ea5f622c525ce512a34e6b60bd6a3e46daa59fd56d516ef46e976e751e4fde4abeb21d25bd34dce37f269bb16e96abb303dd5c5a79a6d894e9a5fc34417201cd3840d81521e05d5a96c5c3433274c6479feede939669edbacdb237f5b775c7689f9a233487d58f905fda83fa139231f522dad8f1231174297a48bb00376ba4aa28368a117ccdc8746ddb42c64b56a6c5b6d4bdaef6dbbfdcd9b7874f31e5b7a88b373590d1f0a9943782935d0c969298ddf3ed497c446633bb8f6f635e3b2769df62da8ba7eceeb1e9fa85a49a80caefd53bd8ad4939a1ea2661a67009f548da311f85d28db47258aa571faa7a46d464a321c329dc8d9891d2362d8d2d606cd6e6becb28033ef0bd63d9b6f57641ed05180174822ec6864a9251f0450199f0d8d655a5e924ab4060d3ea0c6bb1f61e9ebea8ba2f35a1909842a836a64ede97d27f990e11452cc4650ba6b0c6594af3f94d410a44cd4e33b814540ebe7739f3e6d390a34e7cda73518a72ccae49b19c67364b8606db3203e96fc9cb4ececea53851caa5bbf3ced0247bf28a82ad76c5caf0b7a8df175b90bdb7e65e4fded77f87f87affc56d8fc56b920909ebdced4dd697a4c165715bae30f7b6de2c13f372c348f8bd72bd70a
2F939c8b021efdce9b3424c7b47772750bec59d72aef46771d9950e5ae286c84b4a09730d9eab955129f321dbcb25f6badb47d6ea67e4ec967e3bd70a79acee7069faf93eda6f5b3b6b71ddbf61f6eef3b07088fe6c79d071d8eb58faae4be392c4b5392c4adb2c5dcaa29aa4a1e112ff566d4b754d5cec8ddc8dc5a0617a16cd59d7a0c3c5ab1a356306a348b6a112c6d06405a85143328448214b3e9eecbaa993c8bec8ec322e11545a1d7780600fec9628ef625bb2d6da04f02fb03e140b80595e1061d9c55b40085b82d03516cc2de94a5a8a08e9695ca8c345c228d758ad543516f1abf374cc23777546aae61e6e35abbd142ee1729b488bbf57037e467ebdc3485485508d46c3ae8955a5a5b9f1773fd9a6ac6b20d2ecd0671075f8ad2e6e935e34a69dde99db2a4ed2e22a7ad2d29935d27e1e7fae7066e74797890c7d0c454a0e18b30ef12a0fe5e6fbccbc403e38e3f884776d27438cef571c4f78f6ee3c7e2475b48dc7c2c7c27c6b159fc485f1f25502f492f2f81ec9651d09617357d3a3d57cee312f5e9e3a63b5e9c56ccc9b1db21057f63defc786d18f6ccc5332854f554ed18d9db8a67e4c3ce2ceef50eb9a4561870748e384712716f2e94ba2bd083352d4f3f479c789a0764bb91cef8a392f1b440b04aedd1b7fb6a61fc8e2c90581f3bec9a31d97b2529b26f4d31b25e728f1a793a57d2a37db2c721816899eca43e3565e8956800f1101c0c687bc095f07a3c0201bb947a77da25a1b25e5023779111e137d2e6421c16a6584e1836175a9b78d70b4c16270ebc8aca91a20aea8aaa6d14d54e4a47968ff3220ba2c933d83c35ad41e7053465b38e7465678ea0f590741ed9b28c9e725e7ba73aa742d8fcf0d0b05e0fe686e0dbada849eeadc645a20ab5352dbee99669c1e8df397ae75273b9c4dcd068e69a32731bb0f6ebf6437919bfdbe8cb5e4929175f70fe4cbd341572da28ac46b46809f68b50b2d30b7ed44be09df4764dede6afde93a9054285550ddf9f6da1ab0f6158350006e16f61e1e8f157b33cdb08c67c839b392fc5bccdfbbeb9ef5391a49979299c097bb3fd45f528cea79e9ed207b5d39d5fbf7bd2e656c6fa7a5c46b99d60cc9d5aa9cacb5bcb6d1dd5fee555a7ac374a9947c1d9fcf87faaabf8939e1ecfcde741e34a822aaa0ad62887fd3d992299a28b9cf22cb39cf431a0fbe2bbd79d6b2b0bcd14c8ce3f857f0abad9017485aed361ed36fa53cce53c5e228b55b52de4f0e976edab33fd2e041ebfb8c4ff5aa2b7097560b3b2ca15eb78acd692b8436b5355bcd30ceb380b1d93e53f89e9fab5270934ebe1994675225204ffc787d105096cac4d7540bd78070cd65ecc1e49cca047dba328fb1214b417f24db39f831e09b2898aa7c4fac65ebe6f32c32bef72d26a08840b231884388457dee6aa068a354c45a9adde94b7b33153ac811749dbeca94fd1f0a0c4a2053f1996bf79cfb3d20c26cf4a57832f25f3ea7f4b9b2cc961309650b6aa7c3161ac9d0d563131cd2ed25a65a12db44435153ad136cc15939159d391593903875f598ac038ac0038ac03a4c539b33b3e240d71202b48575a71e6975f5656f0e867371d0d060a983c2819edf668c51f1ef397aa78bea6d1a9295ecd8377d6a2988a62f503f5fd48fd60fc2e7af1fdf51dc2a9b43df5ddb2c7a94899f099da629339877c25960e36a096b1425a93e13a2f8481f29519ccbcac4d503357daa95ab1cb152a0966c4b4966ccd3358672e5a83c5a068f6d26cd15f6b77a42a5af2102865227597f72ef597759465fdf194b06465032ac6830c5e3b291bd77597c65d85b03d67b7a3f3a7f698c675f76270ce68db343dbf0a6415e11c28b5047b157a8ee22a8b079704ebd162ea2110ecc11d8cc37f4552f5cbf9b5cd8c28ecd5bbf0df9edf748765a9cc8b134ccad2841f4289dabab3c1163134d75cd7356dc7a76e4ad36ad4a94db2e9a9fe726c5b4b8a86b9e9994e45427396d8bf93708b62324df2d8ebaf9c16d3727b923c84f4eca134a8b1c3e3bd4f077b755482b94173ce6ab61c3fe77017ebb16668fcfba1ea1489108d3f143a2fc09ffd85248a0c28238f6ecbc01bb918190d764e023b2949c71a727560964c20d03d91e86b16a39adbeeb361786b6987572139c18dfef121f19dbb02c1d7b76098936e310fa385f9e9b026b03d7070d405b770f00de614ab0a78ea827d0aa0769c9528acaafa841d7ddbd25dcb593e33791979efd866640258e0c0fe926418272c160103c6b60e7ed34d1216b6e284f94dcd53abaab653a85747e8454741039211f7a74ad16fa1e2b990e1346a8183f1813037b250cb33a07e329383f3281fe33e42cf3c797837d0e1c3df6f20397edfd84b7e72fbae0ac0a40eee3081c20784f7c2a7c27b08ee1c82614685132b2b30aa6fac19ab74b2c3c80c22861ee2aee52a6b10606af090d04b622d805917d926aee977aa98953003adbd41420c0768b568a1935834b9a8783a94c50286eb56e1ad219706f5199254ecaa9ddb27701ea86dee270ee20738f676a79c7b9c2873829c633f74342e93f6077aa003ca86d8fb47985e682a87f6749af9b0b8380fa91a0e179bfd6875d2cfa51fd9ed6d275d00e72a4d264a749c692929a2ab8dee5cdcd762be88d68b88dc4f45695b84a4c949635e4c605c2e420190978f9c6ebb2a5edda01ee14c6a80739036b5404d9a09bdfc18ca007555e916cd6e8cc45885dbbb3163445455945d153d27f1209813f5b526c4a7a9641211a94befa21cef819f85e83bd35678040ac8d83116b3aaabfe0d19
21ac9991484f19c2a4ddba6148fcf4acf8cc712437a8af28ca7856c6883311210d9c8cc1e26c54d0e8d24279504b0715e7af4909e425bfd8774340b34c7c79da7938e231c0941ce0e5abd3b222321a542963b1aa93b6b2b0c8471581c3d1dba387ec7018e33ea28681825b13e1c553e138433145423457d593aa2486150d8708b4f93742fa499aca8ddc7a03d5faddc7a17e80fd1e5e94fe8fbfd90fd091790a411afc6d98608660f98a56e3f67be36ffbb957dd02b2e467aaa362f2d9371c59dfeb70b363ea0b4d579cb70cbdbc8ccf728cc8c2449e0d2a90b7ee42c5e8ee0d0593bc1a64cc3b4aedf9e6b50c5d09e96da508a69bc3b34be874e38a03564ab592689f4dd415a27d35b402512d19a6f4d5135dac4d46269423456d4d28136d6bf4e84db5ef0e89b6f6e2a5f120b4db6da224b69bb45ec93d7bddb1d64f27505a71e8ead7d189bb36ae1da1e75082c331d7ac23ad36ac56dd9ecc3eb333dd330fac21f7cc8af8e9d9a7f933f8f0da12e43e52dfe4074ca9b4748067f50aba99e9469caa95dd550a9336f9bcc6799a936d0aafe7db8f3e65bf996a817f37523385464b1b13aab0fd91058d4d4521a2902eae6ff4236344a0d6c202c9eff7f51b53a9e0c9295926f24cf3237e52cfebbd0f74379c4144ace8817f146661980a79966f2c3324e4592cac924d72c4d706d4d72c2313f8f3545e597e5a334d47d1b7975c5633e258a8b7575b5a206a8d41c136d8ab27f8905ceb6b6df31c6054918258d9405300b3672fce6c0087d4b3b4341dea14f45bce11fe3e9a0521069ad1fe3d21cba762a1fe51060978add3af9de3c5aafd73b17fd49de240f01a49822a1827401ce7c272060e67260abe12eb60ba2848a337c25bf84e68251cab601cbe13250c386730f4f84a6a18994243a69b1f9a1c37cf34dd513aaa7f24c95b3746246ae248582c66d52913118aa2756bd319c417874ed22b28e1d3b640e1cc96f23dc65a61e44ca0ea98a35c70c9e512f70eba7d91d60dd49f665a3adc29b0bddd9fe6d6cff49b31d04d981e9936696c8b600f4dbbb3d5ec930e7517600207c595e30ce54bfbb23757a1c4d4d4d3a4e2079939d65da6738d77de9538f6597fa1edfd366f3433d9d99a0ad674618283b00910c9bd80fac345414d1b07769be46349419810d205dbdc52bd9e81183fe83313b575431ac09657cb5f1d12e2c5b3916fa4ac37dc2a93697652d2b1ab82d5716d6eab6db01bd59de7b5b41b93ad1ae4ef2d0e0259a82d8ead8846dda2ae7a610213a32d35b5eda5155ccb73d949b9ad79a662ca945c266234ae9f242e564b4575b5b2bdb9d5c37e3b640b0d290e4d18dbc0ee649a95ca7bae64ba99e1525995283cf9b0a5bc50abe2db3975ec38775a5f1f349ea0696770e0f4a5a02403fc8b2b39155924986ac9a347334b4cb97f22a887b26db9a72848509c3790b854913381e4cc97965ccedafd264dc2e6981ebfd4ecdf0fe6d28fab2f65e4765e47597bc13785d67304963c799412464e7cb70af9f2dc4d07cb70bcbe969b64121e4091a241534e743450a9fa0695bc420924c328c3ef305c29b09a1297162929524b26e048b0e6edbf98b9be4724b52a243f21e3bca440b8d8b5f23b676520a14f6c1e00d9a5829bfdf22a3da66ac2a8524cd5db50d499b3b22d09169abb22d535edd97a5acbc8559781596944d97a5c426269a130a8249a89122d075bffea86b6cc06d460f01ad3ff9435dd351d3503353d358f19423587ee96156a8d60dc0d78e6b0ddc1ac19c352305084f6d579667794cfb85f0912f84ea8256f212d8c3bca17c292b1153362afb4a62a8507aac38cd8ab64c990a161ec3ad4078d4071eea4d8d5bf56ef51d4d5e6a2aa2771997f12e1bc4dd123a29fd03f7f260c481812909438d5955d84ba27c3004d0ef3aba1defff29c5d38b138b88f8a2a0b0787c13c50a7143aecc6fb8511bbbff33f9891c0337adafc2cdfadc2a808f5bf7df7d46ed9324dc94c555a552ab215f669beca46741b2bd34588f02993c0ad33e8e1ceaf1a0b77e85c6dd4c63f31dcd8af8edbce5d7ba702f765e78958cd4c599dedd0808cf9011dc93e2f21333ecd3817d1b32066039631d8e8e8339d9ead8c7a25ef29e62f509a4ad06790b4ac444778cd282293ad07f319afe31779580d02c3eb8aeda7ad4a6ecbe9117cc553bd22b8a389382cc4b33c6f99e79268037e7d7a7d22a99fd38ba05c4a742bbf0afd2cd32bfda0fc367c39fdb0f7acf34cf2ca8d4da99e2d47685f6699a2df11bbd37a66d9ca95fa2df66d9e1ae7e3f6ef898ac76dd4b3c7e2f0b1a3138b49e914a40edb2e34e3e3c8f9bbe0ee1f807e1ea7fc55e4598ea7f44f5bbf45b9f767f4752e89e983ad937683adb9f1de2ee71ddacdf7af9d67e7efcfd178b7fd3619e87fe9184f605548d65127a2f3788957317e55c454feec7d2c43b41646fbffd7e75af62d418928c62288daa27815366a2a8b8bc8c940d76c65ca4229caec64906ae9b220e60972321ca70fe51033b1fecea035a05c48bcdc3aeb27af319bb49b55572c9b8cd73bd7da9d5dd47b6b359f85e339923c9ba36086e6fcba5ff24375176fce6d3f3ad6d56dcb17748222c4d852ab35f8e8e5b2bc3736ab4d9566b734bfd7dd94f592e6bb2d5dbedc19755df75b8eef7fa6c5f35e9f5dd94d15f732ff573eff9ece38374b7de45fe31d40a3b85a2194316b25ad02c1129bb1260a12da95dd0b16e890bab2654cac25cc76655b06fba642511af613452532bb93ec330322c2d278b847c5551b54fe3ff3947e60749db58c47a4c6312a
2018526230904ea0618db960b054cb8132682f2a72e7a4464718a6b041d6884ec5fc72a823884a21cc934a5a95a3f9b64ea300d49d656b7463e72ad2320e8a80759b8acfeab4326b19318cab8a18465d84868e8e8c3a62800e2325e52b759a7b3e959c70bc8d7d54a4d6a512765a4b348cf3336d2249e29537ad49d9a52f4a4ba5ba5a5f35bcd1bd56f506f4b1f563f15e7a431a17ceaaa2d279aacbeaa94e126562c278b975cab305c60ad05362842c550f98f6816496254da5cbe39c42474c5a97263a44e15958d349680ed7bb5fb6b73f69cb4f5e95899172cb706beeb43d07d87a600f15e03f9bcf0ddd02199c16b4904dbbfaffec7d8a52cd190ed671d6af128ce5ab3ff27fb588d54c2c3aa4750623a68faa8ca56235aa880653ae32b534ffcb95d0b642c3f2c8240b37b56caa45e7395f85136358b7fd954c06423cfb1b0bd2605e874305408ce8e2e0cfdbed9de7b9bdef78da96919ad323a531755d93f90a4dabad5c119c773e5e31cf73e4e553a51657f7d32e619765c6fae8eaf0dda66c5b3d17c7dcb2c69ffd548db8059e3bddbae3000eee7cc40038710e0481dd10097c3c0511f890f12116467d659fa31a84c72cc848a446149143a413925929b63b6cd594a9da24bb226dc4699934ad941ad3be46b2896db1aa9cb5a68e84db3324ddb5e28e93aea262a6711a4f6464eedf449b26951401edee416eededcfdbf7ddbddd02f6f7d9b6ae0891f7641cad55c857e66b7e2d8fb9eb6f4c7fa5df6f2c9f703dca5743218e5c045c2b2b17e39314f5b42b9f412d988859468165c41c127cb96bc11f70ac2410df0a06d743380a7c548248234652115a12e5ad5cac8b96e4065cb9d014512c6c5b6a8d8c58f69db2adc5239a9405483cc872778bff21f11dfa204ea7456eb9c28b9a3c63fc63b20343c3d14a7a050ce545d952dfc7d2b9120e7404cc4c8d82ca48b81dc4fac183ed0f92d7373d70fde944bbb26031b9a34c8d9d9ce4c733e6b26a7f7a9ef1ea48b8241cf427fab9175b4c58913ac40d7977ab60649b1134564759b29e7b63b4f81591659c163df63a4b60b391eb8f58060c1c2b9da53c3589a418d6d55fc7c0ad666bae25b5f12f13831b0b6071b89f3034eca22aebdf3165a1ad5ba00996ca79bd30c2eed655576fb1bc2bbad8854977bef85cc6eb68f2a0feb0e6ac36f257afd63b70d7764c5da1d982298098c1abaf73ecbd8a91debf24f2eaade9b8bd3ed89018de7ae5357053ddce07e02cc84306e960cbcbe026f31973534a144d625f84729a5f6a98328612d53109e55fa7621f927662da89390bc939948fca48d7745cad2b9d493219cc6a3e33496c6623c6c630648e70e556f570040f00b8a9a22019571d4ff6a1b25540bdbd6b431032a95e530bd4a011413bcc6f73cef3186f89347612ddce319c86901d5f547ea666d24668d5a5f198b691359fcc67bd48e633078033b54c03070330d9222073afe1e9a716c12ae551a9b319af28aa8b144893e79635357c466bb5f7d6ac8dbb5e20925e2edbd6744d56a32e7f271f1494a7c19ce94923db8a9b2d6f27b2b2567d1ddf166c3a7c485c42ac378d35f49c59354dcb58b34df229871d55ef8e7b8b5f0b5d56febbfc77a947f8efeaef4db29e7f86dea9ed49b1c368d48a7c29d4794ec539ff29d4a786c9cd5413876953e581193b211a96ed3fdd5af55b0d5cebaa6a91ed3f84956b233f8675497dab3c26d852ffd4f11d25a6b6d4e612474d3d544f5247ae7f437dddf63de95b827b1a985740190ce20e009e4f8b75b3d25747eab9cd58c57280e52a83501f9e0d5516ae54291c3ac293540eeb0a49a319c99b5f803991fd4ce94543c8844a5158ff55e36462640790cea9c25f7ccb708b2258ac6b24bf1b6727ace73ee27793b4f3b855e2ce752aa62539b98720e9ee18d9d42c9ce6a36264edb1350d612f4b666d629d6c7065594db89ff6b205d8dee10a5ed403367c03097cffbad3b74820aeb74d710dedccfaab2cbe083bc0b21d874dc061c38f36c4d37623232f33e0f9ede6f13fea09de2c14c06e35a67b5b928cd1de2753c379a26a089eba0d62cb24b5bc4036441ab8b8d6401c531b06b9a3935d3f5a1fd2d6703f103ff537187d3df041e672d00c40967c59cab59ecb39ed38e33df69ead3d5339ae9f6cfd65f7549a9d833bd6a01f465b393d4c9f84cf367e1b3dbb25ee65715ce5e971f2c94d42738b2537e08196aa5400cc69b216c1c0d14ac84062ed67c8d2af6a79fd08014a46967f53186c36276446e86cee664e6d1b764a4e5b4649c1212e094a6ca425b739c89354274e72d15966739071d70124e56e0601c75c072ec8207504d77e1a361feeeed8f2e26cf06d2fa56c55f3e1b787888e96e2a9ab0c558e14c13488e40f450e9c93fbaa7f17cf705ad0e577bfd79091ae6a8508e7d76f66feff8bfd83ecf0d0d16d6d57679d928972b5f16e7db9bc3d2f913c7561d5f030de82026763f53c378a5db23be796dd3e9f57c0f07d992ace7cfa5a746cf4c6b31585e3f20aa9161cf2873049cd634f52d5c98a9d9b9b1baf76537414ddacaee642e509ba13791d2ca38aab8616ab394b8dec59a63d05b08f3ff5c2d928b5fcccb91b7b0d32ddccb27833e293f3d1e9ce56f7860cbb4e951ef110a00ad52255204dcdb0db8f61dec7e9c1e4de0f403972f4cdb6b8458594cd8fd7915333d9a0a94c16f9086dff4a53dad52df800b5ddb9905e44cb35bed47d6af7b7bd705e2738aaf368adeb2ffab5e16074072107bb3d9df69861ef33ae33da97decbcaf79567ab5ad9eb14dbc5527c
2F7b1cdbecef1c7bec7a2f20cb56cc98e56545657bfc7839315deb30e7bb2dee51c5b061825d3a42de3bef03fd597a5fdeffe3c16fe2cdb23e0694b99ba99d33c4b532d62dc9936308776cf61c463729e3745dd16e775f755f716dc4fffb7cd5f75b8185647b504c30645546e9bed40e272ad8c370606e8a0982089f20db7c3594743e4ee9abc9ae35cd143cbb4f47a89ab7a5c5b46e3ba2acadeb7e6cad6878a6754fa62bbfea7ba6e0d93ad0595e984b85eeb7fc4dafcfbf340ef7c4866019ed1bc3d5424bba05a30ba0482ec228d3ec556328ac7a6a8c758442f2b8f5978b4d487e65b680e5940b6537391b515a55ff588ea895549ba0aab8001891a4cc174da84045709b1623926a5b25562b365553917a07b1809c0808e7276f32d3028de0dfce2ed01995af2c6fabdc2a51f39727430d5a0f6c1396290aae4d9aaad07c47730da4d13042a574dae82a5675d2a68558b2950b5fa540aa1aa2e38962cd3cc512a36ee855216b5918facaa449ee28015cba2c5291070b3be1c8856a76c4412a88ca4240ad483f018c705ae018b45ba898c50fa11ad6d9a90636d36c95666a37f2236f73205b684118b9d312700d675e522d9a9daee2cdcb91405b9c722490084d82553f1a42d9b050aa0c118ce5389107f8b3e3e2e984d861a8a4b03eeeda49e0a666ed04b37450da32b4e9bf45d2017cddd8f3ad12d91ab1a4bbbc20750609e25f3d26887480d4aba71afe20d6a9c66b17e5d1a755106b70300d905cb2b26f33ead8d23c152debdacdbe0427632a12ec2d62a41d543380fe2d558ccf91e1a2903d6d7588dd69aa93dbe5d77764b7fbbc2f4fb38d4376799df03f4ba7f9f5a97599f0a6591c7e8dfb6a7678eb197baa844cad7d8e00abac6a8e03ce8e062bcca479e05edbba164a06820b9073ff61814614c10619ed78f43b9908a0b2958f9a9e39fbc079c10bafd1550f365716dc7925b7653d6073430bd0146b7cc9733b489186ff3b39ede64d5afa6df1a17ee9798523fe47735ba85542a11d4b8f16defdbe7551e234b9084e8a6b2c2959f1b6a65b224da19ba9b412a77c4db9297725d0ee61d49bfc33b8aff8cfab5f137dd6cf5bfb837d57caabfefff86fd5bf917b812f905c2097a92f2adeeb57fd3e103f941b543f908eb8f2ce35f6aeaed2b938d32309038888c1b0ded6233163b976237529cb9c68bacecd35c3b221cf73f9b8da1f989fdae3aa9d77a166b8dbbfface59fa1ab96b213d6aa12b8f949c51b4ab6c27b2dc662d7e46e015c1248044f051808aabc52e0aca2b26bcf0f05e30d557e059c401cf8993662d2dcc96032c84db01679362aa3da79031b085160220b85670859821bc209fbc6364b398b1b89771ce1ef461d72a4395e310d03c714a75fd0ffcd97ccd1be7c48ad174485babf882dee2cd2e2075882f9778ceaa78c48b501ae6ee9c1715589910303c99314aee9b71efc82ea4f91a9712e24f3ab6c97e7909279c46a1b2f1ebb3ecb98d2336fbf348331ea23df8c20cc4624fd451a2f4b862da3b55a0ef7af261d87cc4227fa41646408a5c027704720c4d80d3968a0d8081c69b0d84db8c778ae96db86d1596db86267dd4ebd5cfc2e637de12c4b671f2df6c9c66ba8b35e8f6978b13975741e3aa2474fb23162be9aa75638c2db4ef156d572622455fa3fba01955e6b06c88e7917e61ba5c8a4b4601968f2b9daae0286815445262a8f8855391e299cc2169c5a09edede6896be18c98acb4715d40a25ea05da93b3829150d45a6a651e394719c79c509bca85347e360450e853e2876c475a336e38421aa54f594374a13b1d487b1189db7bb198bd04aa7d2c7bba8919feb7b4d4d9c040c7545a624574987a4f7a3cff4f1f6ff8f3f2db89bf22eef3854935ef5a169439b07f5706274ed04a2ad593698bafa68dad1003e8d9a2befbafbeca3d7f2ee1ad22d97436d8d6dd6ade2f77086dc4b7c6b6c7a7584e26e7d729c427e2272367e95312e549a7c452f165c8e5fc52e4d7916bf4fc8a3fe21d3d7e28d5936644f8f935e2c7c635885f16892ddae1d887fd69de6e7133bca43c4a76d24e549f21272227eadf6953a2df09fe71e0eb28f178b0f8f3318265d812336f014615b0110573e885050f4d44054894340aa85390204a833813fd620018f173cfb963d3106b091c9cade3959c93dc44e11b01c4481c15b1221e38e1ef1bc513b8411e2216f0e1e888c8f1590aea8892b230eb080a0f7804fe184df197f37c0144ba7620f955444a4815009bc0e01045144c90c4350550528c197ca90688228c3f39cb5fc36ce839e369b71c38020b391f2f3354c88485455cbd45ec4ebb667f39f829cf82e503f28abef5981df0c0ce189cd45ff64bc22c114649db2f4511632eb8461791f664273d3a2e7144c0a265151fc0bd2097b8658bc07398608a1a094e2df8a9e3d010b3b27e35387e5ed54ace8a7813db26242dec512e44b45c4d5c4c7d13584fd35c4b0d53f7593c1b85f9d4281cf42052c86d8fe58a032152b02a1b3936542493d6e953558b086be031fa7122ce437959d227fb72a338805b80e995c3fc939e3f2da1bb0d6e455ab170c6b7c4f60ea30ba60664c944573230442aa66ebaa62192d44f322296553d9d6e890f242365f78cd4d2f2a8a78ef71d9473316315893e32b3dbd958d39491c4798d670c80a78166a7fb5f06bd5639e031b0bfe2bfaee1e8716589ebe2c4c1be2d9f8971fc591f3035eaed3502989fafc2d4c15f1ddff09e22abe3f7513e9d8d7e1778b9a55c3f8eb38ec98bfe8fe19170b4d9393536655f68cf08c36f66ec
21a4b8d30c901a064791d167ac02d58e1814daa65d1737cc0f1174145c4320a190360a46c0764856ce13793e727333dafe7c2554bdf8077287b8f5aa24711b47984e609223d7251fd14d3c7a702d373508f76f2d4d8bee035e0d572cccdc5158450ae7abb2837e97f2a42dd294c414e3c2b7f872f25a716279048bfc95574e6ee333faae0f8616e3f3a712cde7f49f2a702c3e51a87268d585b5255e35434837f8ac3090fcfc0753ecdc23a94372a8e1513fe83d589c293a92be82be54fd597fc27465e4cb1667f9bd327e461d17afaa990a87a530c6a9a221728d11322baaa29a540f05ea94932548e1eb267c37957a94620a5c09a733c60575290997de82ad1ab67a32c6f3ecd9d693190aa97e0253fe1445b8472fc2e3c7d6385605f7e36fce0c7f2cf05caac7d8a72df26d59da9d86ed4ed18daa4ce14994a4c53d926fe6a67cb27425f5b13bde1b81ef46897bb70b7942c007c2eb7cd96e31a48db2082a2af8d2d079aea6de208fd3772500f8021b3fc995a1c528f0442af32cb32b62fc23b6d4528e1b7b6fe3ccef421a5d5cacb9e247d7123e2caf321db9eab975b7b89f171b2845ebc21b02433a2f16026be88ac6d58e14f11b16ba8971136f248039b7f6aaa1ca3f1f468f6faa99d1cdae76aa0f9e659f68bb75a6c592c84720d3e4352ed0b7cc47806908e21fbe2188ad302f19b4213529082dc2dc217b089407610b22afcd156d0bbcd14d375886d79c10a27545ad643f4b57e6e99d7483942d68a7213820d9d127d9b810dd082640f71b486b3b40706963dc20db482e45509974212da1bfe9068b5b077903cca1b417040c727520e195d81febcf7b5f6b65b44f9a7b45135715cae353a0037499540e224b85d7ac22b6a060b43d02afc6efb8f6a8d6501978d260658cfbbbd2efafb462b41bea8a68b4903637fd190fde8afa32cbdf75641af5a8a75dddda6ad173507335ccd4efdf4b733519ada8b135521a6b4115ae975a90753ae7e8ef76619df3f801ce2b5e7a852b785301d8534f2704287050f25d687dc456a7fbb1575aaee9a1916e684ebee87426c621a1051d1b0466858a803680067c7d3e0a62d6fbb6aebe300e710619d55154e88a8abb3b507a49defd5d23643bedc583fd3aba7a21be50a1031dc4552222defad248a55f5e83a82a28e968a6b465e95ae837726175266d4959a9fa754beded11c1f507da14f54ffeb93cfed9d7092b861efa2ced49df21bd4752e342a5e5f1cf4bba767e7248d61e56b8fa7a67a3b73c1c886979a36879f3fbba44c8c2e1bba6dc23c14f527d3e42f7cf1e6470e3f11407dc8d41eee327b9447a6f8c8ad61efa1f5ebebc0fb87e9a5d3a8c5e868f3b44ee6aabce4827e95277a6d2ed62a1e8f5f7cf5fbb78ccd677a3cef4d04d392bcf21a4bbb98cba2335e5533ac7c776032c54b0a0729d5a21462e765b407a4c573d74026fa41a036a288747a4f40e4d5a7b7a68d5858354356059c31e5f1f7841c5a3be45c3836c5a6f5f9c917c5d444734841f7e9bfe7d3eddfd39dde6444b1ce590111f7ca212c9602e057941fac59326d620827ad0a3780edd34b5c7647a90d2e3ea29963c1106a29e1db43e2dbe7f6d143f0f03c9f7af220bda1cd98ed4e289a1ad231e28f3febd8be64997b9291f4c3ef1295a2aa64a40f7a74b252fc780e97b476fd0e9745c8bbb5629df8ada86bb8a63fab896f9460b3b2df5fb5d68f77667e57dd3796d640bbd5f28cab0865654bc0f005193c08a68ea03a4da43dddced1cdfe03286bbd6e950c236fbdd163e839fac3d1de3101bc9805369676a5a9fbfec7a2499c4532da4707ff1420201cad675ac1cd38dbec517842f31c693cfff426721c98069cee8d1b62a7be57f4eef255df4aee2b34fb3dd945361d0f76bb2d95770b4f4564c3759baddd3d337dd3dd69a5b3fdda26babdaed897d3ec7a67b61af2afabbd2f4b67ff762fe9389b87953a806dc2133f5a0cd63b13e3adc4f872692e7bbbf627690880679cf57eb7d1d33286133f321a4b9eb0cb9a394249925c9da0491a19c546182df5a3867d087297fd1352d14981e9a0c71e688c5068c3c954f2319669031e4ac72f23267c8fc8f34d24c014c03a01c72d0fe5f2b452c463aa1323b2f834e20d7e44260788720edab82d446a05a1b515a37513a8743ee84da2803d1db00d1fa8f3461a02aa3a30e8e096d12a5a29475f8bf50b3f50adfd6839ea177f5d087fd72ea309a08fa5a7e97a587e971966f4ab75ebd28debf7d2b9a57a52ff4fd2ddf4bd295e963a54ba54bd2c5d2d94a17a58b2fafffcf3f5fffc4214a88c6cb7bf83468f9301b319b09853cc6a4b5db0db016447c83b185d88b0d1ec6ec25f4d5c5ec560acd9be0d71fb193564c5a75c21c3471873fc00c714704d70271c7e14e24e3a6b69c060e0ec747d399f616464687a3d1b1d1c49f13fdfd687d1e19d0f070a27279a8c460a07fbc18191c291dcfdfe9b07634384477b8307fb43d187262616fcb51a1f848c8d8e0bc7584ff18503130eff7c83d7fb268072b46d074234b424f7fbc7e05523a30a2a05077d843f0c4d0feb90743898583c998cfc9e14d0e47c6f6c6079a0cb7efef2a1f1d1d8da05a8cf341b1e1e4ff48e4c2d1e990363b18c41e0f605a1c1f331e4c14289a4d0ec6fb3f0df698872760520b27988fcd46148f69a8d20500b478748d8c8d6dfd8593f28d3214c3cd272614fa8703855f70ac47b85970fdc1e4c295a651b1e1875e20ffdc0ee3d73770bb89753f40de6d8cb0471991a7c1cc67e67188e394c0d0e7b31166c2463e66b0b1868c219993
2F7befddd50d0ed6d7fa5690e562d4fcc886b26e37eabbe5f001270058e43c4d83c32a1005a070600ca500b30ce009b0ca8cd865cd86543464a7c857c9d187530049d3c07e20fbe5c04ef10c3efd79063482201468870087c13f8b01fb97c7eebe2672127e72186ca02564a14630e23a8cfd67b1f959e6410f6e650a67727473640a6d61656f646e65310a6a62203020330a6a626f373733326e650a316a626f642034310a626f20303c3c0a6a0a3e3e0a6f646e65310a6a62203020350a6a626f2f0a3c3c646f7250726563756d412820696e75794644502065724320726f7461352e3520372e312e766572203232392063412031657669742f0a29586165724320726f74796d412820696e75204644506165724329726f7472432f0a6974616561446e6f2820657430323a443730373131313731343032312732302b292730306f4d2f0a74614464442820653130323a31373037313131372b333432302732300a292730650a3e3e626f646e36310a6a6f2030203c0a6a62542f0a3c206570796761502f2f0a73656e756f430a312074746f522f206574614b2f0a30207364693020335b5d2052200a3e3e0a6f646e65310a6a62203020370a6a626f2f203c3c676e654c3120687420302038462f205265746c69462f20726574616c6f6365443e20656474730a3e6d61657200090a0d64e39c786060639001006310202606290d256899b4a165a56796941c8ed3011079a595b92e010a9945ce0a6ef92589a9ba0c6a454c1464380cf54cf58a15ccf52c14cb52150c8c8d324b931cf42352cb5a809419819419381703072448600c90486748648a0050650cd94015cc0c210ccf50d2408aec1424e02c402b000680c8951e098b646e650a65727473650a6d61626f646e38310a6a6f203020320a6a62650a3030626f646e72780a6a300a66650a393120303030303030303036203030353335350a206620303030303030303030203731303030300a206e20303030303030303030203036303030300a206e20303030303130303030203632303030300a206e20303030303330303030203530303030300a206e20303030303630303030203233303030300a206e20303030303630303030203135303030300a206e20303030303730303030203639303030300a206e20303030303031303030203838303030300a206e20303030303731303030203335303030300a206e20303030303931303030203633303030300a206e20303030303931303030203635303030300a206e20303030303132303030203836303030300a206e20303030303036323030203133303030300a206e20303030303036323030203335303030300a206e20303030303036323030203537303030300a206e20303030303236323030203835303030300a206e20303030303336323030203732303030300a206e20303030303536323030203833303030300a206e20696172740a72656c2f0a3c3c657a69530a3931206f6f522f203220740a522030666e492f3531206f5220302044492f0a373c5b20443435334344384239333931414634383033364644414536413738323e4132313533373c384244343931434434383933364641464536303338324441323141370a5d3e414644502f616572437669746331205865203020373e3e0a526174730a72787472320a6665383535364525250a000a464f00000000000000000000000000000000000000003014bb88016ee7e57006c94b0603f70718b0027f1ca18fe01f7719f45ddc29e49003dfc850b0ffd6ede4377ec02aef000ddca13b81660ef00bdbb9f97adc0df902badef61dadc3dc26a5f9f210cbd41f483810d2dba906dd836ee9608318821c7d8cb9a44ac03f6921e79780a1e6d72c68e18840ab8701f3e92c0f72cdfa5866619b72b01e2336e5689eaeaa4dbe7573b43577195cda1ab986ae6d0d6b734955016b7be10962086183810c82eb0b5f752107cb4e9c70811ef100df95343d8400eb015dc76d5180988a1d2ee356c881fb9528c81db04027d9a2f6e862e56f2e031a73afce8044252dd13402c6dab217b6f4680f0b03c2f4b4843cdec58c9bab5615740adc208a820486a8430ecf021530a70a18ad39b947fc523572e8642dfe8cdf85b70ba9e9f0225714f2d86bc03a89570b23f041a11a8611b4bfc27a6b75d74e1afd34b49ac8d26874d146a3a035849f9c7277ae59714b09ca5b9d4323e3c300154362a1aa866547b7406ad11ba8378309d71d71d511aa29d509d5d2ab2095a1d5452aa8f556eaaa0355fa80cd2a3ddd24406abf5d1ebab274938e7453ad2e2fc13a1d374d3de205a9cb72a104b10f0400c2072978d61e05dccb94360296105c52c2966208e500c2093904009f487104ce4028ced04ced2826a504822941354074d69853d086e8ad9d55a8b6877899206b453f08d6a0c4db5846a5a29f1013902d082900ce40333ab4033908c0ce4e086588255638101d500202767513c40d377d42e93fab1504d44cdac5725df4291b16594604c1e04903c093de6634ac0920952a9b658b1644646968695ee97c694d684d7ecd7c4d64d43dbe5eb78f691ea1b3e5efcf1b246ca153e5ee4f15245421fde5edf71fc47fb677e5efaa7b6bed7e3695edb69adb691d5c6d2d50c0eea060c95d32a1e14230657157211269a99d59d307d9086ef10a90e042ef8414e21f1035842c620fb2789429f93f7f4a14fe2c21da8a1bc0208505e2a53f8ea17f627566ef96c9eb45349839eab70d4363f82d4ded554297722083810dd8fa831fbe
2F7ceb58c71f2b1f6a2b04f884dfb42f6f10fdcac381c3bc4fc4cc5b80bf6062dc17fc20c57a10a5a315e808208728216e8867b485207a10fd73c083ecc859e18b853f242d18f231e72a18aa57b7647e6c98b34283449352d5060340f4ef8b10fc1636f162561c5967cf862d8c6f3f0c5b62d4dc31c4824188f01b1941280e2c6dc1c326ba937b43268064d121afe01cdec58d88194fe31a2ac5873c58c0514aa5f0c045f0afe180b7028fc301e180de86cf7d009c206bbc03d1d62c451a25ac18aa38b0b7e786fce87e8586fdd0df9d4330bbc064614d1d7c6ec58fb10ecfe31a909aa69a19fc09e6820616f8fe131a87c01882614d8d43e38d4372000d8c0033f002ee350fe350e52fe24ffcf869533049f0a1f39f0d937f9a78b3c6fe015bffbd02cf156e2b07ed7e105816c46a00fc193f8011b696bc6affde1fbf8c7fe421feda6a822848b03e39760ddce151ff2d4a877bbdef57c39708dd2a192a21fd5f73bd5f659424f4a874a860fe0fef801b60065e950e8450e7c6a1d2f019937f12426142af1140aedb56d24742e84ce2f8338032f91b4f2ff24d6fa52ac6181fa50aa143cdca3a31007508712787f9cfb05e926c42785d6214da0d88501a0c228dde0d89b1aa0c828042d742879183aa2f347ffe930e27413e6869a32e9e7fff97802df984d678fbec5ffea3d035cba11f74a57fe4fb0e4718c27a157f18785cff8ff2182fa1ab0e9461d2a9e2f7f90f82420f22c3fb0f825bf2ae95f76ac434ff16a086f7b1bbbd50684f7fcc08eeffb1d7fc87e487493e9619872e81ceea802fb6fec9d2d3fd47c6aa18c32398f846958437f5a22819fcfab3c61faeafea3c0ea1d30f08478fa1a4e04bfb0f1b10d18ba3bafcca788906a4ae2a52bd8163a7034938ae7844cb12ac1e8af459516d48b15aa36a4bd5aad6af579a956a17523513509f8f0d2cc9d492269db1529e634f15634225a52293df9277804d582b5cad06053b9d69515a5a0f8329bceb61d6c975c1bcfc71a0eb64faa2c963badadf18fd7241b909f34630f3d281011683dd1ba24745e696dd480fc085375df8ddf8df573adc4eceb502b2383f07972ed0f30b9f5078bb9e22714d0833ac86fbce6c996b1ffa9f4c9c42eea299cffafcd39fe6fceb47783b8f8345dc2b073b78dbdc626963383ad9a2fe7caeaff8e02308f536993a007bf89bc11d17f3b4ef4834de3968336cf3b5d03d24144052350c41401d9bf1050cda8dacd6010d3203353fba9b4e7a37cc188da2cf06619e7c80fbe5568da027c30aa00a0eaf30a1f1197c4c2beb43d019b437d333be6c23d33bf4999d62a1e675882247f68d4234a4d08bafec9b91fd8340e8fd563a48a1d5d7289d387ec113bec2183bec9d9e26dd7f5054036fd0d44368f3fff926ff29c2ef81f18d0fb9587f65a185da6269a1dd691ee8421762e1b1dc72ff60e7f2bfde591e42b40fcbdda2e4e14c5c57ff070bb2ea70ba1054d0cae015b2ff79057aa1ff9a165ead98ad1fbafed16f365385ca15cb2996874d9685a6c0f03ced6fd6e696d9db6b7df96f356fa16d9d0f6fd3359d1ffad03df5695baaad5bf403f4ad5bf40f280f5b9eb56fb076b7053746afda2ccf9b3a534403c3cfe87e05a7a73a0776c99ea5d80526398c8fb8d79c96d408f2a839d92e34194d0f6555a040b44d654d5693b80a54d8a119335e72a88a3ee02949542a1f4d0e6c5039d8f70167a992edbb5dadffeb0d1d765e2127d7cac9deb706d301d64e0eb6e6a2f1773fc6c1c6c1f74a8369d14c4ed4d7f0beb19e9148bc91a57c6ad2dc69ac7771b3b86146bee3284efafd7c153cb60696482504b704d707770677b45505f78745fce2c1ddc695f5b904bf1d784d40ca9b4dfc201eb9be75d9a3fc3fd2d7eb0b581f04e4b9ff21a2f364fa015a20a6cb062ed621590cbc4154208440410b986ff10dff840ffc21d1e041bf00ff10f50e10fdc28cae12d0bce69b2b62fd2a641d0a9267207957273f59535d45d9700c71773879939b4e1e954d8d87d943804e09936d2a8e8c6f0c8402fc4209fc20b7041097c264ab92ae53cfaf9db45ae76df861893668eb32080eb936b4e98121279b5baf72281a224ca00603819b7f1269bb5e11ee0052c11e23400042be96ba5689c29eb68ec15a3f21b14037664d43c1fbd9a224fc827e0991556c1c0484353cfcfc987e22b48720c8c21c4d4f0956a51c413d415e0d204ece402f8de379f4a4e91ce358b1ece374b48594468aa20674301cc0741ec22047b9919d1e808a33913f3242be2f31cb0216ae42d7d456456e30ee84a03726683f8999b7e9198d2ef6a0ad85dd879ab422150ec18ccd17f556a47e80bbb1ac746b8c2f8251d22b476661770ba82516345bb3aa123556c454a97211f0e40e179df53f2b8bdc9cd76abfe6cb7140db489adcdbc3df4578b5c55f53253bfcf1ddcd3fb6fbebdc1843f83f618c394346431b0112f8270983814cf510619b8f1a295056ef200c2d7eaa70d4fc9fa2db977020fbb0eec6b512126c5b2d6b6a6b72b1d53585d77e52bdcdef3b76ab8ff25ab80ecf965616affdf45eb4e5af15dcefe1c85e827da644daf73f57e807f6e07b93be085fc9ec14ab9a0722a7493ac4a73b59e38ebb7471460d38bbd49bcf22a2d87416837c75e8f5b7e6c930db38db6efd012e26226a5a185ef397d77cac1451aeb1ec4b49d3188e2d9b06ee191d0c6090c2b55050d144d1828554aadaea9a48adbb4abd559df545d4511a0d15452c5653b5ad5a3dcced61d9dc1a348a6835d315550db55d2ed7b9e96a9f022c9fb85943956b
2Ebf42264516ed657701e66301b848887301e37703c71f07bcab8c3c2a7e7ea10f4aba62de8d745d63d310a35201ad24a1112e605b8e22bec6dfcf693bd7893f1b0e9067a0520f1525d14e3a541a350d2854b35b25f66b778346e68869689ba5fdc97dbd5f455b9d249f46c23a2946099fbcbca9a51619e9a9da14a797927e372f728c064c83453ce8abfd1784c391016a10314c5c181088ae0ebc503652bf630dae697324f6e1eb9b1538277029fe04f7c61f91794bbff66b9a7a3abfb663682e9e50ab715b3d2cdc1c624e91ce7264c2113f81d68172fd6e85f408f0e23fc65a462e171ea3a30a1232d4cb438243809860c0a36026c61e284629a2c5944a25514f7477688f9444f471b1699ab6835a290f689da0e4572208d2c1f6283a39b016fdeaea478168f67c2a379acc0a1c386d4544c3074a8987305edc788ca9cdcfb7445351ac1cba7517f00aa22eafc8e5e68b8e5e2aebb2908cf2c615214356ec72cb6c9164110b4b912a349053e4a4a161a5b56b5a61c3a80e581117374eb458e12aabd872cd6aeb6b12794040acb72d22ef7ddc5bfcdcf7d55ccfe5dbd3b3f97bebb5bd3270e9e57cb530d126d93566663f6e11f573f769afe69f7db9c1fedf0e7dc8ffd365f6ffb4cce18f7d4dacf7479b99ce07747017bb0a8d440aee8ecc5667148a54f38f73b74e479384a03649c53631109be025f1591ef068a84339041487486ad344ffc100b2097c269fc209439b826029416086880e13d6a380ffc51d8b14b3e6cc5268d116d369358f6980d31cb937899f184947b26e2c2c7a34b6716030b29226194cd77a3efe83993dff06b7a5526432a91acb0eedd9173266a05b400ba1a9b70a7fe7e78dac04bd7748e78a462b5d5ff85323d6d5f7dc891f7abe62b788446dc3f9134fcfb225e614b0e9d1cc28f8ae562f878cba9d13a739e9c3e440a9da67c991a246c427b7b0f8967125e452a812f562fc6ae762c73af33af51fbabdcb3f36ef1978cc7ba6f8e6384cc74df3a5f213ce9b0e17fc17bc23b81b5cdb704bebc397769d0e351476ade753736d70cda74594ecb147108b1952ef4b541117388bf0074ec30de568468d0c30fb67d229cc335835497a2955c2e9de285cfb5dbbab9475c4eefb8582bef44c01c55dfc61b7ef5480d75a975b7958b758151630eb46445025342e312dff250a0d0dffffff3020310a6a626f200a3c3c0a6569462f2073646c2f0a5d5b31205244203020343e3e0a52646e650a0a6a626f203020320a6a626f2f0a3c3c6570795461432f206f6c6174502f0a6773656761203631200a5220307263412f726f466f2031206d0a522030650a3e3e626f646e20330a6a626f20303c3c0a6a79542f0a2f2065706567615061502f0a746e6572203631200a52203064654d2f6f426169305b207835203020332e3539313438200a5d392e7365522f6372756f3c207365502f0a3c53636f725b2074654644502f65542f202f20747867616d492f20426567616d492f20436567616d490a5d49656e6f462f3c3c207431462f20302036203e2052203e3e0a3e6f432f0a6e65746e5b207374203020343e0a5d526e650a3e6a626f643020340a6a626f20203c3c0a6e654c2f2068746720302035462f205265746c69462f20726574616c6f6365443e20656474730a3e6d6165729c780a0d6a4b5175dd0c30c4813a14fb303ff247e493b40ca141be04dd374285b67dfaf42940c994df5921e60bb2e927eefea0496213bb5e530fefbc29f3428411e8e3530bd8e5f2e29a37f549ccae875ccacb98df4320179981e8008094e5f11114ffa2388ca503caf855e48fe1b6ae49ed87b0feaac98abd5ab72318313e883e0c7ac41a2f6ad15372723b2e4f587ff71b37b38605f1a0c67f34d26c17ad370d8bd9a6361ef5a293f7ae31233f824bc24383374dd8e92ced443db23e06f7371ab26ee5b46f319f8dc58b7afea376ff2eeeb6e9b387ef7f2663ec85b8ebe64c6a9cf5db417db062eb515d95f2f1b189fbad55df0c1eb864eb3d017e650aca737473646e6d616572646e650a0a6a626f203020350a6a626f0a3235326f646e65360a6a626f2030203c0a6a62542f0a3c206570796e6f462f532f0a74797462752f20657065707954422f0a304665736120746e6f5a46522f2b495341656d695477654e73616d6f526e452f6e69646f632f20676e6e656449797469742f0a482d6e556f54646f6369203720650a5220307365442f646e656346746e6173746e6f2038205b205220303e3e0a5d646e650a0a6a626f203020370a6a626f2f0a3c3c746c69462f20726574616c46636544650a65646f6e654c2f206874670a393132730a3e3e61657274780a0d6d4d90559c1030c36a3be04f8508b265bc8636b24aa2f052e203dba86d08d8d2c8e58c496a91df6f85203253f237cde3c176d51a7a09779daff4c1c2ea6f3a3094b2b0969939340c21d619d38fe5537499508eb33692dbf70218fcee68fa95d750bc497312c362f7614fa87b404fcec4b6bdb4fdd8f18d7ee809f266972c0d3447df6a958d33d0fc75d0ec1541da5df15977fcc20e70916f7c8b74fa2e512d2c1127ed621b6a947d423549bf50fd9f6f20578c353b557edcf93f7750957cffc80fb32b33a428cb2b04e716728918afb1e99f367e6256f40fea650abb727473646e6d616572646e650a0a6a626f203020380a6a626f2f0a3c3c657079546f462f202f0a746e74627553206570794449432f746e6f4665707954422f0a324665736120746e6f5a46522f2b495341656d695477654e73
2C616d6f5249432f6e73795344496d6574206f666e2f0a3c3c6967655279727473644128202965626f724f2f0a697265642820676e6e65644979746974532f0a296c7070756e656d650a3020742f0a3e3e205b2057203931313232375b38205d20375b20355d203232203836203232375b31205d205b203631203737323939205d34345b20205d20335b203536203232373834205d30355b20205d20305b203534203333333131205d355b20305d203030203337203333335b31205d205b203132203030353031205d355b20345d203030203037203635355b35205d20355b20335d2030303831312030355b20205d2030203130313334345b38205d20365b20345d203031203736203636365b35205d20355b20305d2030303531312038335b20205d20395b203734203737323131205d355b20325d203030203837203232375b34205d20325b20345d2030353930312037375b20205d20375b203835203737323134205d33335b20205d20335b203938203232373535205d30355b20205d2030203330313030355b31205d205b203731203030353934205d30355b20205d20305b203233203035323131205d335b20345d203333203739203334345b38205d20355b20305d203635203634203035325b31205d205b203131203030353737205d38385b20205d2039203830313737325b35205d20355b20375d203030203034203333335b31205d205b203530203737323838205d32375b205d5d20326f462f0a6544746e69726373726f7470203131200a5220304449432f49476f5470614d44302039203e0a52206e650a3e6a626f643020390a6a626f200a3c3c0a6c69462f20726574616c462f6544657465646f63654c2f0a6874676e203031200a522030730a3e3e61657274780a0d6dd78ba5010c50830e94074f43285dd596ff007baba2b57dff8daf0bcb51d8e7648c99cfe0accca7feb3e1e399cac96020491e509ac1e589318d9ac152ced56b7c441cf61d644e9747d76739469410ab0c34d52552cae1b45c9e0f3b8d3e6f17e294e9697c44c21ffa650adf037473646e6d616572646e650a0a6a626f302030316a626f203730310a646e650a0a6a626f302031316a626f200a3c3c0a7079542f462f206544746e6f726373656f747069462f0a724e746e6f20656d615a46522f2b495341656d695477654e73616d6f526c462f6e20736761462f0a3442746e6f20786f42352d205b2d2038362037303330303032313938202f0a5d2057677641687464693030342074532f0a20566d65432f0a3065487061746867692f0a30206c6174496e41636920656c67412f0a306e65637339382074442f0a31656373652d20746e0a3631326e6f462f6c69467431203265203020323e3e0a52646e650a0a6a626f302032316a626f200a3c3c0a6c69462f20726574616c462f6544657465646f63654c2f0a6874676e203331200a5220306e654c2f31687467333333203e0a303674730a3e6d6165729c780a0d78097cacf0d9c51b56aeeccc759256b796ead7596f92db2c3ad131cbb13b69ce4c13a7210402039c2039db1a867310812db894242849a16738bf770d681381ce1b407c3140b6928e7c0816816dc14281205a534a4677ff96dfb68072f3fffcf3bcccdefccceced7328ccf7bc0c8423087c5dfd88f995b2e18403fa1420a18bda1045c59fb35b2f850f5f2262cbe5f0d1e429ecaeaf24414fce4eb0d8908489e7df4f56f8cd7a8585a69908a7e36cbaadabbcf9456e0ba11a75f2f8ba57f3e657c1d1093c5d567a8b7ed3cf9e2e2b1555ff78565ff4409f9ab59acf6a2df9f2eb5efe1ef06554dcfb1ead7f3e59df05a28585f976a7c79d3ca84dce886eeb0f3f6a6a596fa35abbfcfe3fb5661433ef1f2db6e6fe8dd6afa1b52122ddda120e916074fce334dc81f45f4250b45df2fbadbfca1509c02b2bfe25f0850de61ab934c6010c5d88425e480f108c9b41e617e3d484616f0789f0834295d210a71af9801cfc9ac2211a73218a8409cb0bf6420885de721011f7f15090847f720035d617a1073c304a844cf89bf2fde001f2aa10c32ca07aef00d423a8411f66b4d082d9d99a106b26cb5082fbe1da84d086dee742d5c03cbf25f75866ce6ba4433e86524847e88d284904446ac01685904ff8472b708880f90db88cdbb87821f1a11b90849c20f765ae51f01ab08cfc8e977285d0ace09f010b4fcf03ba08a1746146ed67a0570a416a08d0d426a00f33436e811f682bd0f88da23210a3c445421e8a9a2f87ec112c0e474f9bd1bba087d47ce85027403e77a2b51c99fa05b01d907a86863fc6653cdd15b8695a047e2ffa3351865f14749b98c2e78a524cd19de5f09381c823e38f2fe3e21fb901bf78700fa1099a3f7c19910fa9f416d0c59741643dcfc617a2cb462a506af883d1a00a31fcaf83b46eaf8fb7e621d09346856e1af451b46cd408734378dd6f065d64781d8f3ff1ddfc18f39fa25d3d085d11866e875211a10f7b0b35cee8a28c902d07341cd0abda832b8ad89b363c65386efc653e7d107d2879e492462471844e14b42cd107dd177d3a3af1ab758efe8908ff06b8afcf0a3f37859ff168ad6c60fa84da3dc00fe46123a18fbb105702b86ac07107cd025039689dba8700ff7c2f715b8e3a4fc11e2774857b73345e3b2ee3ff1b6e412a38f8bb84608b8df0d3d16d0d38d3905c0be0f8fbc75bd8e5427595c330b51c745ee8f1c61afddffbac0e09713fd16b91ef3c85f196c87f8d0fe323516300e747aa3f0d68c5a2e815f85067d580c7
2Dafe8b3d081a22bf8cff0af9653849b09b587dfe33029a28d3d6876f601defa17c3421a58b30ebcf066196334e0e78f51bc2af0f38781df134df89bf1d20122a20dc4fe4b7f722f7261056be0b27a01bc377c1f238ba21684c0d70301e61f7f6a0e7a10fb1c36c31da33065c5cffde1d7153224c92bc9fb9e46ee1de4467f276e227729b8abee49f7d740edf116ee8153023e6ac16c17f0abf0243187fe2d78a500f9181f3919c83935710b898f37135ce66ee4ebc97ee36ee3ef8afd12dfe51f84cb0966b965c5473d7ee4ef037e3ade182a0793a2950c57f407546ad35011730f5f186a6ae87d3c8eda2d74f97a056e1e83da3e853f7985d0d7a18e4e8120dbc0094883af812f9877540e5f9e15be23f863f1bb3e1cfc699fc3df86e10487d3925a93893a64cd25846e45599c7236e7e23e4ebc6e0adc3ccf0fd70bf730ee2e9e788f26e12a171f10ec299928bd541ee299c5c6674bf572c64ac746c9dec73a6e715ca1dc8eee498e3fb9d308df182fcf008fe3b748c39706ef28c2cf0bdc1a8789402325e8f3d1d6363bf402c130cf8713bc50014a1a80033c596b366782cff99e173e8bc42cf0978659e1d9e18be375f1fb82037c7af89dbe2efedcc1773df187e2f6c71e78610d79e147c43f8bbf119fc27f01c262208c484735660648a490664cda3c1e7276781ac8abd91f487a907a1800c847201c8b959ceb32dc65709bbb97ae19ee2ffb0bee55ee7ca5f09e17e46f8aebf8abf05ff857f95ff06ff39a617e094bb0b17056e54678abe6ab55a5dd552e48faa7da89544675f172e21d7155f16a69011d5cf7980bf5f2c96fa1bc15ea94afe228565f02ef24611eb9382b0f9e2bb8f322a6b95bb8cbe11708dfdf8c9c534bb9dbc2f7e3d5b83fc9d373017835b939070a795dc0d0bfe3416e841ef251f8c8fe4d39f23cf0dbdff38e3135938fc3d151335ce5bf088f02f5fc6d3bf272c8e33640d4771cf211f8fd773db08350cfec2bbf0b3246bf22d158827f5bd5c0bbd2f09dc96425c8af57c45a074ba15f0b161fdd609ef584ae25c66e4c2efcabdc221701f4f0a7c37f5e35201d987c2dc6f832405c63b89051714687d8b7c1ea2f813f052308c3c6df07b887e303d11b71018906b6782a81d757e00b9964ea2d396c4a2f6a229c83b85527b9f38c1ab9c706fc4a414e1cc26dfc4ced038077d0e531236e0340d369905716fc9a13ba2722dce9fde40b625493803b086f4ae3eece8d2879d1a88bc8ba03e378019ba116780a3a25504a337834d5d0bb932578fde320d9fdc8c61a093fd614a297c074b481be80b6d8c82093b0d5f0a5c27ffc827f2b7ea40102ba33fe2359c0cb9ad3ce282069f85bfe41ba99256780eebddc82ea43aafbe83b516fc296168076ca80bb73002e80fff03ff39d7ed062fd76c903dfa30a5f1ff7324196e6f71bc29e052266988bd09be630cda01de7c0c9bc904cfc0a5f8c777404bc33c4e81b54f192e863e033513bebf1bceea5a077c79f8df7e3b9a1568ffc810fe3843e30dda156d16a92102c93d8c8357cd059f8633bc7bf4744cf6e408a3c816f13fa2760e305ff3c813c2c9f03bff3b6bf1d99d96435fc65c208f5832d072d0a8e5d127a36eb0cfe55411b93ff6439b907ae74f8e8bbd434c707f1dc2e8b58fd240cbf1eaf6893efe9ec80282f613e47fe0eeed0f1869222a71d9026617cf4a0d047423703d3ee3cdb3f895ca24ee364b463ee6ebd00fb9b1247810bca904894f481e8427c610438c0ef7b84ca9569b43964c03044f14383315a11e5fca9ec54791ef7191fa3240cb21dde0a3bcd59bb14a65343f9f5b512b29281c4b49b77ca2fe83bdc0ef7081092cc2ef75e2075bdc9aa795ebb980500e8809906f70f68fc40841a3675bdc290dcad1c2012f714fd1dc0bfd4d7d30403cc190d8e2fe1d0956d41c7b81e3041f83a1cd42aa257346077dcb5a6408dee4109c21c7cf020a70820f70d68276102da78107d840fd882649da10521728f7096f738c28f8826fbc240d61053878109d8ca047c257b98d3572a9302abf722b246bcb75ccbebb22647f005fc094a2b019986b252d1c93b216cf215e453510bf92e28ff97137a6bf5bea798d93ec0d9aee8ac651256deaeb1d1ef58ecc69e69157e9df1e8b7e694fc1a5d410d1593c99dbdcc31845422193258dc1c9be50baefaec8d8d3beaf361255b496046b305d7dbdc2f6aa3180d40b98980d53542aa18952a513a8bcd50311225c75b5b59ccf4ba3dcb0cbc0972b3bebb7ae234776fbd9ee5f81e5ba77e5e3262c5e9c2d9157dc8585df053c1c0fb5f0fcf23defa6ab03abfe50f8fd5154bd54e0e587ad46851be5c53ec014363c27f9a12efa74b8b6116df16f78b6ab15ebbfee604d48685e5f3730d9ed58156cf46c2bb78bdb221ee7ee789d09ecd485c099058b66493ba87766d37112408598a3d8ce208800edbb140e55e4e89c307ddd2803d603964e4eb2b0a60de8aacf223efc08600207e193c51c98719f7fc303dc5fa77fc61a7b084ab45910eea127f187d907b2258713b40380222b23451e48891edb7c51e0a16198fe3d901764e4797204b4f4622190d20120292d465f217028d49aadf55d0200a4f2ee4cd10eef4315e1727d23ee123af875fc02ac9d758785d0014cdb0778d7e6add47afa5655d0af1e8c474a09db253c880a1bea95301289873c12480d4b939c6dce6b13b8bde171b9e8ddaee708794d69bd6a9638aeff7ebd993f971da1eda179875db1c39c3eaf0f3b9bab1fd14a49e95e5bfdea8ca1ad7aabca26244927e36d5d0b80bdb208fa7a1
2E01c4fc7ec0b27babb8484f1c4ae058d46290533431ec36e8918f80bce41bf0378c57418483230eb0c088e06281ff9c832291cc52673c238e351994100558fbc2f83ef540ee1fa0ab8747bc3e70bd2e7538847c940f4547f2f0af2c6e5e1efc1d1f249fe060417d2224e09b5394d3f2a368d293aeb635af325b3f371a3acd425806ea9d6187f006e17407cbf30b7407db4a94117a18ab84005df915fbdf07b1ae9bd1db9e15e5579efe5fa2da5dce7f9c7aa3addef5985ce61c5120434af5862837b155d5df05df85f317f18ceacd851bf42b9a4d5a361a57a87790af356ab7af32099dea9cc42d49e0539881891e117c02bc51c23072b139a06221d69345669f8089ac8aaa3e42eca8028cac3a0e5bf0a4e0c81c4d8c56b4648b238f659c2d9158a85f18f4494250d12538273893d89df813e09123805628da2b8f4ceb44b4a7f615538a761559d158d9d19294b2ce9efb46bac8c0a3d3a418b894d456d53373cdab0ee2f114a8fabf514344791cb021a971544d7ceb252110ccbda0e591350536bf250896bdaf78da83a1515a79755d5b30abcbc3da011130a8e0949290b3009dd765df47e275f874be765b3fcf55d1dff7c5789fbefe7994cb2a936f3bb38d5a5a6cea42278d7ebef0e3d67c7edf0bdbc3c768fdeafd1f2f6bc6dc9bae47252bbdecb3edfaecf7a94a0b15cb7603ddb4083700f65340e7a9ba2e73aaac35e201ed701d5120abf5267458af4ce606c58f6d80f5c49ed88dbf44e41151967b01fd2669ca1263b60ab1a0c37f09b8d37e420693500a69aa69de60dc851a6f29caa7c94eb3e37620a6c28309057e41e46a184fdce2dfb059ade45e7c47d79079f1521e7d8f7dee73f4422080e42bef72d0f8f1350e63da93380f7f22f76304c7eef77c09b5e9a29654a72fe3e5d24714523f9fe8e89ffca9c5b3eb79b42a104acfadc56ed2064c9a36f8d3eb499b2a023b9b152ac98f6edd8bd00aabd30d4882c38bd20705964c19aac89438337cd1cb175f2fb17143c560ec3b940636c1b56b2533ce83a474d316a63daf9669285a69d0e45a2fcd4ab4d4bb41b7d8ba1ab7e7ea4ab69bb77cdb2d5b31effb376ddd23ddc477c7be59fa44748bdf11f15fa417a6fdf05f7af486f4dee923e989a617df23785f4a7f6a95f0bfe26ead4c4585ce07cf9f5e42dd6a31a3e1c7bb1ae889abb645ccdb563e95db6e3e4b24939668278f663dcc8a464c966ca63930e3cc0f8998bbdf9f48c2fca1178a43e30d38992d5e56aedd9b619ed46b31a2a5fcaf643bc1930f31511f7681f44f930df618aca3158ca78c3b7941f19c0f4676f5dc3062ae2854c59dc128ad531069f1035b8d63d3bc59798dee58cbb59d056e4c69227497ff234b1436956f1e3628db3f9c263fc2e906debf101ca903399809811d5cf603db79c2ae3a073986f63c3dc29383f3b7cfe6e796c64d55771bf0876f63b9ae99899b9f1f4fc3e77fb7aff3f13129fcc7d3393112ffcfe03fcf9baeeabe11221514ba503cec78481bb726540f9827bf8c98c30e80be34532814914e1461dff297bf77dbba61cb7ee99d16e3d30eed87dacabb99bcbbfda5768ffb76dc1f8a3bb834e09ee313c8ce7a93ae4cefc96a5213f883761c37110e1530d147c6fe587ad770f710a17bbc9878941c9cc835cc34b0d869da1d6186206d8aa4a52eb031e434f4a571f2f6333ed86266b39b38a2562e9d9469aa3bf4e4d829541389159cef998982b9591f5764a7ef3fb1b37a3d9deb7e9617bad774f7aca3b30fe9e5869e9f3d36051c6c9364c660f4ab73517545ecd6e5447b0dbd2194284bb522a1875ac3fc244a8cd7d4794d21ad85db21c07826da1b30b57243e2a112db180caaa9f2a6ffc0b012fc9fefdadf5b7de1f461bcdad85e1bae7728bfe8bedc89eae30fdb23b07ecfec2ee2c4b3ab09d62a1caf5573f57b96de67dce1dd150fbd03cbe87a1dc45e67a369989ef354d3bab72c5580020ec4cb503a539892f79d6e75e976e92620d849352ada286ddbbd65ddcc7dcc7676a4aafb5e452d9af0da271f7d9be2d6f956ae248f7408dd84086ddf3f97011c881a346e23b76e2bddb1a7b53fe2f382822c516d9dfc78652d0d74c3479442b3c06b6727b84390fa1c2d4427a870142edf3256ac1c9307a101d4da62492f4d6a158abe64a1698aaa5970576ab04907010c58c7c4f92fa29a5e4a43396730405b0720d4327d8a781c29149b269e4cfa8a06d8b8055fecd791d756dd80bfe589821cb05af6ab7bd88132f2e86aaa143da3f83cc809102aa2e6664755831f1d8109b6105aaaabb3627bf1a71c48f63f4f39effd6e7408f82cb7757ee65748daf16a772d605d34b916d9f3f73db2f83ee6df3dcbabf960763a78a5ea9e1788401eb4cb0a77a778fec970c22c186a5acac8ba0ed1af0d92bbb8a627cf93479b7ee4df58ff98fc95ff15fb91b6035645b88b6aabf42fddd53b8a7629ab516aaf54ab01c551c61f5e8b76a00811dbbfd08402aa56e084927b6efd19bbf3e420b25081a3eb55ae341c10817994757582c51450a10f8938a5912adf93c04a2c58e3258cac4604a18fe9a8348903ced01ec45f952a8a7e22ed4a43fba9143232398c361919a0c6450ce450cbcf865e8565f2aeef2269d1437fc82350c0cfa65eabee7f3f01ca05090291ac71a2cfa67429e8d219019b1a48a70150e08026f5743f423299b14e543995683321422a8360649167419095974795fffbe3d610ddbf31b4d8e0896830ffa9c574d2e5bcf4d1d8f5a0d3a87f704503a78a843540a9785d5d693ec66f69ab93ac16e489ce2cb80a
27de42a4484f965dc4da5f5ee7aaf8a71992b936024f4503de0a026b2ba1406d9df1280cf39960571adaad6579a08126ef04b6efd31bbf2e82bf1a420759081cdb6ae8b0ccbae8ab708974d4b9d57d3c5ca8f4d415d427d5fba71ab8dc6eea1dd53d54b735e6ae3ea2a66d3cd41ea92b6641e7ff1e72242efa5a7e978a09ee4cbd044e07f423a074b846e01dd06403c702bd601fd992d98961617abb27ceebf3b155969b16f91c69a451b325f75856dcd7d8e572522a958513b4c9a74d1751b98a1d3260acd0dad6f958db99f41050ae9ab067d5214c7c6942c4e4c8f91876a44629b8865dd3e12a617c1ce5a2b9d3aa4ebcec5f0679d1b53cea61fe27ce5be7454e27f08f6209c1839e9e9550b59d6ae6ce4e19e9a3398e9e14e54e6997070ed24dc809448c8e0d429355c6b357b656cea1368c5eae8dce0d68ede975f4c6f39bf4cee8ddf481e8c3cac1ca9e9cc71c97007f9523e578f787ce4fe3a8544eb93f74be8e7e991d23fca63967894ee316a7a5d482c7cf5d2b8ebf4b9f3bfd3d7ceeb483f3816b77e4d1efd94102cb040e2e2078eefd756efc483e31242031ddf80a674e709076fede90397610ba4f9b549dd28aa74ee53a474e63058d04e5d9e7071ab51a20163a74a10097a757e552b8edf6caf04114030604aa02275712a52ec0bb426257d92648304df3266412182abb1b748301e7da441468d1345d8072a4ce99daa6455a8787722d5d67bf28964e80cb513a1cb7a02810ba8758170494ee5847ce3b8e34e9c65225929c678cced483f8fc786391c647219de4ca2e0dc016604c015d433cdbe249c1720516f3141bf84dcc6a8d8eed3b1ff173a47422c7c834305ceb6327c53e6f216a7f714748cbc8bd246c6afb1f6430ccfebf3b92fecd86ee5aa4488e2c36e3af91637becb3cf7e2b67ed9903b57fb683fc6b688f093ff1f0c56d0076eb4ad3c4ecb60bd7b42360e2d824ecca4638252bd6f5ac779177adad1138c97005a0c101040da69040ee67150d78a32c86bc51242633165916096830e0c12c8a62b1fe1ab5863d62ee260d31c345b5732de87c4a5966cd49c48a4b341e15e0712072034b6520fa4c6a609a6aa095da9635024c78bd32c01241227185da22d60748102d071048f14a0c6899f0e0cdf44b4529f8e2ba0d5f213c7ecb017abb1e356763d5fa4014189e0dba43747ae3cda3c16b7461991106a6e916286beaea2835c4a45e81259716696328b3a5962d470d65b168c9b2d4ba187e0f72590f813f625fc45ea6085fcb089dddbb336f68e4e324013d59f01d0fd11a84b2b4164376818747f3864f14a8c00a87265761c0cd4d1864062c98a1be92dd8b19820d9221b285632bba065d21ff079e392194543c2683398a5389c7ccd42aa005555101c584ea4b7fa2ca95fe71b92a54a50e770fa506fc18eb99f0a52076d1dc93484a2c9de499ce119db424a904e3399f8db57c6767e67ab4df67092c06ab527c4a901b52edc9925411e57c41fae80e7caa4d437b9d73bd78eae79d1eedf94ff1f3a371eff8d1f0bcf7bfdd62b956159a3c795293626489c5f2e9e23d624bb1bae5fde5f62e11e79ead3c24ef7eb9dfe38a1e163a6fc21719bf0ade49fe237b4251e55848dab8defb1045c5042062dd0816c4c25a5caf2143678de2595021edec04ada28b511b22962a0b6a4ac5d38a50b14f7160bcab3cac72a10d93960f94e523e5ddf2b9cbc72d94cc5233157a6626838b6582a8a323c22a66067cacabb820715f18726e5540455bbfce99e9b35dfb2b945368c0cdd853015e676a3c1a3fdea9a270e14a582d8ce3c3844709a3c43d870ab4255cc5100ee2385552c37d55a36f359ac580f922a0f8934202849e4f2a611fb2ccd10098c3eded8a92e4947d508a41ff0bda57f45ecc6ace3ba1dad89e27f8a4b1eaece84416aa276060dc8afe1ebfe17fefc0cd54d7d159e2f79e7330de673b5c83aaafefdf5b95ea448d2fcbb8ebfd6875aa688dc703d3fbdab433d9dd17fa447d056ac8326d7fa557ff304c5e3161fb177b1664d5e3564fb577b503640a9d84bb81ed090fdd3b8245b80fdfbb3ebda082052d90814db333810ce881d4992c58a2326114893835316b3187681d774121dcdd1fad58a57130d1f8617e186854dd8741348451f49fc81be91afa96f927df78f8f6f64712511d154ff1e19d9ec51fbd0ecd517657903c992e2fe49145dd57561f03d2183b436581aa99c6a52792cc04f982ae8a41aed544c20663910c873a6ad48d2a0dfd4640f3a9b75fe875259bf29e16f9590c4a9d514cfbde6abfd5a953c0538329a7b15e34bfdd254622ddccf72da1dd4370bc9827a757ad1bd789278f9d971baf2d5387ec213fd7c72d551069411feaa9251cc3c6f334ecf32a0caab8ea9edaa6d541a123e2685432ac489a169b19131bdb168c4cb113e9d7a47430fd32ae9fec54f631a35551fdf9356f5820576eab26acc2840ceddfd982b94083712244eca404a655d20f5f4c87c4835d04b304b59504c156a3469292b519f469d591ade94301352a2e62b4cf4943023315270cced8a89aa46c559b5235b353f7a4f71a27d307a42fda7cd20cca6433a6433299b658b41c2b1af158b39e32b6d59d691aaeaceb4725afe9d40cd895389a8774491764f0c90182bf63d9d79a367adcd57975fdc6ee68b5606a0735ae202a20b6c1091624532432e51b44faa3990369d619c50ca452dc511075dbd926367620e0252e6022f56bf887ca18c54dcbf5cc0a2947ce832d2c0ab3809f1afdc7da48eaa8e97d1dcef2d30f9d5a5e70345d85e7aa179db6de
27d99bf8dfb108cde0dfd9a4484bd6f63bc3f7ddef4eff3aeb44e79b2cbee135222fedfdb13bacb5f5808906f4c82f43530fb8c78195cb20e80e8c77e6e9d1799a3fdee61e8ba86aa848a12047950073513d5751f35a971289967d06a5a12db2cd47c7e3b1e11033a49208dd14c1b19a36e03689a50115d12b3ba7e2c1065346b1d48c968c269524a46ca289aebd543fa7de695d016e49ec14f061fb2af803d0eec0e1e9014387c1c39c3d940f44f4227ad1e889e45fd9c3fa9fb9cf4a19997f93f2cd7a69ee85fc9a92c79354504b6492e5e3270e5239d4a9279692dae9636a05b0640ce429b926a089bc74ddaf0cbe7f753abb2b8a5b7263ea764e6f269c033b27d90ae48b5a9b674b2a639b970e39511bd8185f17ce5bd87c836636309293711989cb477779ca05bb852e84a6ac5558d68ee14b48f50947ee7b9ec78ba002b92f36c5d0b96b4add0165c29ccd0525394592d0525592ccb8555ba249b12f432c963bb8b233b836c902dde602576edb584d7b4834cbebb9d5c4149282971845650b16b2a554e547b3caa72c91b3c46603f533070803c3d4f512a554c3716717d436308936d77c1961ee3771f3047883c1b0a7c09f2f930f167954d315e652bcaedc144ae461c124139587dff274023ba6c99409bfaeb1aee95f5d93dec3c1356f191d6376b744ddbaddb2b7acaffc48265bff4d9b4ebf826cb480da6aa195821b07f00207c3a2cb36a6089c299d5d7326125e124c935c995821e26eeaa07dc49f6ba5a876497628ba8271293d0c92134548f91ed42133eab10e532ea79ed33421b4eda6893db0e47c33db8c1390db503c9def433db331d61d4d3b5098a994c9676ca0992d4353d4c9e58994c800823501cc9079c8f600c98372ff329b4e6f22913176a3034f13ba7be5d59aec1c63d50f5b637d56630eb6ad7d807e306ac3a96997cab7cd4dcdd150eb8da1c56d1d8f171adcd8f0ee61fd31b6a599648aafe72d8999ee4c2fdfdc9559056bbf7d2931db5625affc267ca9bdae132f7ef91e7c5dc1ce6e4bc3f802a5eac44d3ae067987035b773f309726cc452088917f825a2f1f775bc36e571c80adc8cc89e1b515c319b24d9b7c99143192a12e731f7c0adfffff9330f610141da0fa4930bbe9c0181ab8179c03a97cd238c6c72ae70ed8c6e5ca98b6c50454b82e2da26da2d23ba7222cc0208007c236ec62c38c9a478e1638e9e9d3c78b9f495b7d8b8915e91de28ae2b5aabe92daf8d7ee3f7490de20dd5fe92fef1fb92eef44f64fdf16bef59faf96913de7156d54622c39c6be2bce371b76547f6ddcbc51f7dc2af2817dbaf4e8e1d3a8e045a2c60d5aa2fe4b1823d94cee2e438171523a818b8ead3bf053a8bfbf211843be5547d5fe3c3ec3edb873284d3f1613b1a62628435a8a87b287ba9c7fc699c055d18e48e46a18bac4a63a5eb13d623c4c40d8febb930d88d328a4017191e8b2c682e8392ed7e762a1be59fcad86808d48d27977b81e39b325b02687e4a0605e9f24583436689c2f24621b4e3d44207701ca0430b324e1f1462a05f2dc7011891a22cba3eb092932501e623ccfafde83d0881c4039aa37a4d5fed08726ccc36652857a608c1c2e259bf1c77bcf2bc5c4f11dcc67052bcf4c892c0eed52532dd5325145273f6a97d1b6b1bb042b5b5bdc17ca45bdcb1b1b2056613632bf5226e48da432b7c34b4a4ff15ae414f7282f847ee8ba9e51f1ace50fb71b69b873a259091385525bf6cb3d8cc50ab447962dcf991d3ad23a8a611e7955f485f990b59204da7651a330eff6cf228aaac5565146446556d66632c505781acb78f90abcaaba6944f3a068af52f5e2bd5a550cd8d557f1e1f7a46d1f189c5bf3dc9d4ac9d88a5385ae52c6c4f3b346a517ca82cfabb29a6b0a31a9cbff9357ce886414e329191808967c993b7a65f57a5656e309bbdb3ce8dd6e6588acfec8b62d21f67f49672d61cda3365a4da13755ca351dba10dec5af2cb3fb652426d3c6b3c9a6a9ba0d6d82dd579b764a328a35aaadc2ce0559ba59ddcd75ad3859ceb301bba55ba6f683735d9e699d07f13b7af749669767550ababaca2796346ec09faa107a47ae3e8c9a7ce9e8cba46a1b8bd89e877d29eb75102a0d819934e8df5e77425e8ea52e7769997271ae712716e7226c035e746e9c674b4c091a5cbfaca7bac0d59485d3730dbf2baf331d65c32910655411d1ababebd600cfe16eabf35401aa77a098d17e84547f11419110323fa8a9c895e8e08fe90e451b448448cd209d7bb0364e30db19f9dcf8a558a8854ca1d8b233149c8bf6262253e223cd8f07af93bf9b9bedec213d1ece4be3049a3d303a7a8b4936172960bbcfa44d8f4ecb8b4692ec907da3b37ce692b2a64c936d0433bcf2ae27c1e9c6261fcce46711ce1484f24cdd7d5d6b0469513d6551355ad89072820919746aaf56bd991e4d58b203070783778c849345ababd503ad535c660f2478b06a21063b287a35570f7b51495b960b276e980947026702dbf05ee28d65bb4081242f4c21eb701f5969980ac31245553a998d870cb548d93a9954e50ed03a4450e32eb24ed4a1e08168cbac5a71759500b500b5073500350f89ef7d633bbc7034e9a7132e3bb0d15a3a226003b09ece8d1b3fcdd6cec2b3b4a0cc6c1a03b5533c92aaaa06b86ef8c957a59cfa7e2f12f2366e70b468a925137bb8352b1e499cd49261d68b9ec6b6fdf01a2a8753eda590ddb7d41d75d9b97315cda5de105caf58305176d95e50da5060b65d5c929fe12aec7731b1a24549f98efeb1ad5dc03faceed2ae8f54a5ccc
2293f1f4cb7e700b5c487dff00de09e3cd3adfc527abfc60041a4c47b213d03bb1efc4f42080fa6510a0f5b817487f2c154a9870bc07056f0397ac09ec3b3ecaecbe33298af71f4f4cc419d85b6ab292da74366a140b0c3ad5ceb1e205730ae7e345c4f355711e45eee841b0958381fd47971e4c60040fa04f819e1d4d7be738179dba8696ce0d9eddcb76cf3ef301d6adfc01f380742fb2137f8d3f00f5c2fe21e7a4fab1ec69f24fcb169154ff0ecb42743fb90e659a242a09f8e4fc03f04324511791b2014b49e60fe81ddc02901410edd4db32637c0c09c054f0bffbc8b8107e9b09ae44688f618a3ab52ff5281432524c0c96afc978179dfaedc7494fa27ad4148d2800d07a8de823441a02d0d2045b591e82e9317d7c8bbbc628d630f1712a53962b2a92548c5051457f8f9b0735cfe5ef9056b9e9df58ef5f57dec9d76f9ce27a3e4747664c9ddb197b5f8c14b40aef5cedf72f5aeff7a62f03ea8b806e3d71ebebff07563b128dd81f199c923761ecd037a490466badeea60c647aa9445c2994bfc4eceb2531fa98bd551aa6a463b24e1531c5c2d1974084468de44b5c08fdefebff5b83e39274a2ab850baccfe73caf262db6fbdc8d57539fdff43fcf1beef5587673b8d86db51534965afbf0af93f7dfc237cb9a8fade9ec2a20dcb9736e5e426ae2b681e90d917bc85d404d54e140c8105696c30921619631fd1242a308f8eecc509a2c2110477416623b9dcbd12891df4d5034422d1916caec113b901bd9d74a71e1784e857c8bea9196c7819b760a8c5d8eba8e4edf2aa11e5ea4575f9984ed1fadaf3271e4011f9725c36a8bfe444c2511faca24a6c521c8a0e297a45bb1fbf1787a21f98ffc129fa39ef9546a61d5060d45bf22a2fc9349e60f8a935b30d80016cd3464500736667dfa2352d01ef1f2f52c5dac6197257576cf2f37f32ba65ebabab2cb9adeeae5d9d4af45dd46f64b827364f24080e3278aec36d2a3a7fdab54b7f668a194cd5e3c409496e78a2e55bb5705eb22cdc58ea5f622c525ce512a34e6b60bd6a3e46daa59fd56d516ef46e976e751e4fde4abeb21d25bd34dce37f269bb16e96abb303dd5c5a79a6d894e9a5fc34417201cd3840d81521e05d5a96c5c3433274c6479feede939669edbacdb237f5b775c7689f9a233487d58f905fda83fa139231f522dad8f1231174297a48bb00376ba4aa28368a117ccdc8746ddb42c64b56a6c5b6d4bdaef6dbbfdcd9b7874f31e5b7a88b373590d1f0a9943782935d0c969298ddf3ed497c446633bb8f6f635e3b2769df62da8ba7eceeb1e9fa85a49a80caefd53bd8ad4939a1ea2661a67009f548da311f85d28db47258aa571faa7a46d464a321c329dc8d9891d2362d8d2d606cd6e6becb28033ef0bd63d9b6f57641ed05180174822ec6864a9251f0450199f0d8d655a5e924ab4060d3ea0c6bb1f61e9ebea8ba2f35a1909842a836a64ede97d27f990e11452cc4650ba6b0c6594af3f94d410a44cd4e33b814540ebe7739f3e6d390a34e7cda73518a72ccae49b19c67364b8606db3203e96fc9cb4ececea53851caa5bbf3ced0247bf28a82ad76c5caf0b7a8df175b90bdb7e65e4fded77f87f87affc56d8fc56b920909ebdced4dd697a4c165715bae30f7b6de2c13f372c348f8bd72bd70a939c8b021efdce9b3424c7b47772750bec59d72aef46771d9950e5ae286c84b4a09730d9eab955129f321dbcb25f6badb47d6ea67e4ec967e3bd70a79acee7069faf93eda6f5b3b6b71ddbf61f6eef3b07088fe6c79d071d8eb58faae4be392c4b5392c4adb2c5dcaa29aa4a1e112ff566d4b754d5cec8ddc8dc5a0617a16cd59d7a0c3c5ab1a356306a348b6a112c6d06405a85143328448214b3e9eecbaa993c8bec8ec322e11545a1d7780600fec9628ef625bb2d6da04f02fb03e140b80595e1061d9c55b40085b82d03516cc2de94a5a8a08e9695ca8c345c228d758ad543516f1abf374cc23777546aae61e6e35abbd142ee1729b488bbf57037e467ebdc3485485508d46c3ae8955a5a5b9f1773fd9a6ac6b20d2ecd0671075f8ad2e6e935e34a69dde99db2a4ed2e22a7ad2d29935d27e1e7fae7066e74797890c7d0c454a0e18b30ef12a0fe5e6fbccbc403e38e3f884776d27438cef571c4f78f6ee3c7e2475b48dc7c2c7c27c6b159fc485f1f25502f492f2f81ec9651d09617357d3a3d57cee312f5e9e3a63b5e9c56ccc9b1db21057f63defc786d18f6ccc5332854f554ed18d9db8a67e4c3ce2ceef50eb9a4561870748e384712716f2e94ba2bd083352d4f3f479c789a0764bb91cef8a392f1b440b04aedd1b7fb6a61fc8e2c90581f3bec9a31d97b2529b26f4d31b25e728f1a793a57d2a37db2c721816899eca43e3565e8956800f1101c0c687bc095f07a3c0201bb947a77da25a1b25e5023779111e137d2e6421c16a6584e1836175a9b78d70b4c16270ebc8aca91a20aea8aaa6d14d54e4a47968ff3220ba2c933d83c35ad41e7053465b38e7465678ea0f590741ed9b28c9e725e7ba73aa742d8fcf0d0b05e0fe686e0dbada849eeadc645a20ab5352dbee99669c1e8df397ae75273b9c4dcd068e69a32731bb0f6ebf6437919bfdbe8cb5e4929175f70fe4cbd341572da28ac46b46809f68b50b2d30b7ed44be09df4764dede6afde93a9054285550ddf9f6da1ab0f6158350006e16f61e1e8f157b33cdb08c67c839b392fc5bccdfbbeb9ef5391a49979299c097bb3fd45f528cea79e9ed207b5d39d5fbf7bd2e656c6fa7a5c46b99d60cc9d5aa9cacb5bcb6d1dd5
26fee555a7ac374a9947c1d9fcf87faaabf8939e1ecfcde741e34a822aaa0ad62887fd3d992299a28b9cf22cb39cf431a0fbe2bbd79d6b2b0bcd14c8ce3f857f0abad9017485aed361ed36fa53cce53c5e228b55b52de4f0e976edab33fd2e041ebfb8c4ff5aa2b7097560b3b2ca15eb78acd692b8436b5355bcd30ceb380b1d93e53f89e9fab5270934ebe1994675225204ffc787d105096cac4d7540bd78070cd65ecc1e49cca047dba328fb1214b417f24db39f831e09b2898aa7c4fac65ebe6f32c32bef72d26a08840b231884388457dee6aa068a354c45a9adde94b7b33153ac811749dbeca94fd1f0a0c4a2053f1996bf79cfb3d20c26cf4a57832f25f3ea7f4b9b2cc961309650b6aa7c3161ac9d0d563131cd2ed25a65a12db44435153ad136cc15939159d391593903875f598ac038ac0038ac03a4c539b33b3e240d71202b48575a71e6975f5656f0e867371d0d060a983c2819edf668c51f1ef397aa78bea6d1a9295ecd8377d6a2988a62f503f5fd48fd60fc2e7af1fdf51dc2a9b43df5ddb2c7a94899f099da629339877c25960e36a096b1425a93e13a2f8481f29519ccbcac4d503357daa95ab1cb152a0966c4b4966ccd3358672e5a83c5a068f6d26cd15f6b77a42a5af2102865227597f72ef597759465fdf194b06465032ac6830c5e3b291bd77597c65d85b03d67b7a3f3a7f698c675f76270ce68db343dbf0a6415e11c28b5047b157a8ee22a8b079704ebd162ea2110ecc11d8cc37f4552f5cbf9b5cd8c28ecd5bbf0df9edf748765a9cc8b134ccad2841f4289dabab3c1163134d75cd7356dc7a76e4ad36ad4a94db2e9a9fe726c5b4b8a86b9e9994e45427396d8bf93708b62324df2d8ebaf9c16d3727b923c84f4eca134a8b1c3e3bd4f077b755482b94173ce6ab61c3fe77017ebb16668fcfba1ea1489108d3f143a2fc09ffd85248a0c28238f6ecbc01bb918190d764e023b2949c71a727560964c20d03d91e86b16a39adbeeb361786b6987572139c18dfef121f19dbb02c1d7b76098936e310fa385f9e9b026b03d7070d405b770f00de614ab0a78ea827d0aa0769c9528acaafa841d7ddbd25dcb593e33791979efd866640258e0c0fe926418272c160103c6b60e7ed34d1216b6e284f94dcd53abaab653a85747e8454741039211f7a74ad16fa1e2b990e1346a8183f1813037b250cb33a07e329383f3281fe33e42cf3c797837d0e1c3df6f20397edfd84b7e72fbae0ac0a40eee3081c20784f7c2a7c27b08ee1c82614685132b2b30aa6fac19ab74b2c3c80c22861ee2aee52a6b10606af090d04b622d805917d926aee977aa98953003adbd41420c0768b568a1935834b9a8783a94c50286eb56e1ad219706f5199254ecaa9ddb27701ea86dee270ee20738f676a79c7b9c2873829c633f74342e93f6077aa003ca86d8fb47985e682a87f6749af9b0b8380fa91a0e179bfd6875d2cfa51fd9ed6d275d00e72a4d264a749c692929a2ab8dee5cdcd762be88d68b88dc4f45695b84a4c949635e4c605c2e420190978f9c6ebb2a5edda01ee14c6a80739036b5404d9a09bdfc18ca007555e916cd6e8cc45885dbbb3163445455945d153d27f1209813f5b526c4a7a9641211a94befa21cef819f85e83bd35678040ac8d83116b3aaabfe0d19ac9991484f19c2a4ddba6148fcf4acf8cc712437a8af28ca7856c6883311210d9c8cc1e26c54d0e8d24279504b0715e7af4909e425bfd8774340b34c7c79da7938e231c0941ce0e5abd3b222321a542963b1aa93b6b2b0c8471581c3d1dba387ec7018e33ea28681825b13e1c553e138433145423457d593aa2486150d8708b4f93742fa499aca8ddc7a03d5faddc7a17e80fd1e5e94fe8fbfd90fd091790a411afc6d98608660f98a56e3f67be36ffbb957dd02b2e467aaa362f2d9371c59dfeb70b363ea0b4d579cb70cbdbc8ccf728cc8c2449e0d2a90b7ee42c5e8ee0d0593bc1a64cc3b4aedf9e6b50c5d09e96da508a69bc3b34be874e38a03564ab592689f4dd415a27d35b402512d19a6f4d5135dac4d46269423456d4d28136d6bf4e84db5ef0e89b6f6e2a5f120b4db6da224b69bb45ec93d7bddb1d64f27505a71e8ead7d189bb36ae1da1e75082c331d7ac23ad36ac56dd9ecc3eb333dd330fac21f7cc8af8e9d9a7f933f8f0da12e43e52dfe4074ca9b4748067f50aba99e9469caa95dd550a9336f9bcc6799a936d0aafe7db8f3e65bf996a817f37523385464b1b13aab0fd91058d4d4521a2902eae6ff4236344a0d6c202c9eff7f51b53a9e0c9295926f24cf3237e52cfebbd0f74379c4144ace8817f146661980a79966f2c3324e4592cac924d72c4d706d4d72c2313f8f3545e597e5a334d47d1b7975c5633e258a8b7575b5a206a8d41c136d8ab27f8905ceb6b6df31c6054918258d9405300b3672fce6c0087d4b3b4341dea14f45bce11fe3e9a0521069ad1fe3d21cba762a1fe51060978add3af9de3c5aafd73b17fd49de240f01a49822a1827401ce7c272060e67260abe12eb60ba2848a337c25bf84e68251cab601cbe13250c386730f4f84a6a18994243a69b1f9a1c37cf34dd513aaa7f24c95b3746246ae248582c66d52913118aa2756bd319c417874ed22b28e1d3b640e1cc96f23dc65a61e44ca0ea98a35c70c9e512f70eba7d91d60dd49f665a3adc29b0bddd9fe6d6cff49b31d04d981e9936696c8b600f4dbbb3d5ec930e7517600207c595e30ce54bfbb23757a1c4d4d4d3a4e2079939d65da6738d77de9538f6597fa1edfd366f3433d9d99a0ad674
2F618283b00910c9bd80fac345414d1b07769be46349419810d205dbdc52bd9e81183fe83313b575431ac09657cb5f1d12e2c5b3916fa4ac37dc2a93697652d2b1ab82d5716d6eab6db01bd59de7b5b41b93ad1ae4ef2d0e0259a82d8ead8846dda2ae7a610213a32d35b5eda5155ccb73d949b9ad79a662ca945c266234ae9f242e564b4575b5b2bdb9d5c37e3b640b0d290e4d18dbc0ee649a95ca7bae64ba99e1525995283cf9b0a5bc50abe2db3975ec38775a5f1f349ea0696770e0f4a5a02403fc8b2b39155924986ac9a347334b4cb97f22a887b26db9a72848509c3790b854913381e4cc97965ccedafd264dc2e6981ebfd4ecdf0fe6d28fab2f65e4765e47597bc13785d67304963c799412464e7cb70af9f2dc4d07cb70bcbe969b64121e4091a241534e743450a9fa0695bc420924c328c3ef305c29b09a1297162929524b26e048b0e6edbf98b9be4724b52a243f21e3bca440b8d8b5f23b676520a14f6c1e00d9a5829bfdf22a3da66ac2a8524cd5db50d499b3b22d09169abb22d535edd97a5acbc8559781596944d97a5c426269a130a8249a89122d075bffea86b6cc06d460f01ad3ff9435dd351d3503353d358f19423587ee96156a8d60dc0d78e6b0ddc1ac19c352305084f6d579667794cfb85f0912f84ea8256f212d8c3bca17c292b1153362afb4a62a8507aac38cd8ab64c990a161ec3ad4078d4071eea4d8d5bf56ef51d4d5e6a2aa2771997f12e1bc4dd123a29fd03f7f260c481812909438d5955d84ba27c3004d0ef3aba1defff29c5d38b138b88f8a2a0b0787c13c50a7143aecc6fb8511bbbff33f9891c0337adafc2cdfadc2a808f5bf7df7d46ed9324dc94c555a552ab215f669beca46741b2bd34588f02993c0ad33e8e1ceaf1a0b77e85c6dd4c63f31dcd8af8edbce5d7ba702f765e78958cd4c599dedd0808cf9011dc93e2f21333ecd3817d1b32066039631d8e8e8339d9ead8c7a25ef29e62f509a4ad06790b4ac444778cd282293ad07f319afe31779580d02c3eb8aeda7ad4a6ecbe9117cc553bd22b8a389382cc4b33c6f99e79268037e7d7a7d22a99fd38ba05c4a742bbf0afd2cd32bfda0fc367c39fdb0f7acf34cf2ca8d4da99e2d47685f6699a2df11bbd37a66d9ca95fa2df66d9e1ae7e3f6ef898ac76dd4b3c7e2f0b1a3138b49e914a40edb2e34e3e3c8f9bbe0ee1f807e1ea7fc55e4598ea7f44f5bbf45b9f767f4752e89e983ad937683adb9f1de2ee71ddacdf7af9d67e7efcfd178b7fd3619e87fe9184f605548d65127a2f3788957317e55c454feec7d2c43b41646fbffd7e75af62d418928c62288daa27815366a2a8b8bc8c940d76c65ca4229caec64906ae9b220e60972321ca70fe51033b1fecea035a05c48bcdc3aeb27af319bb49b55572c9b8cd73bd7da9d5dd47b6b359f85e339923c9ba36086e6fcba5ff24375176fce6d3f3ad6d56dcb17748222c4d852ab35f8e8e5b2bc3736ab4d9566b734bfd7dd94f592e6bb2d5dbedc19755df75b8eef7fa6c5f35e9f5dd94d15f732ff573eff9ece38374b7de45fe31d40a3b85a2194316b25ad02c1129bb1260a12da95dd0b16e890bab2654cac25cc76655b06fba642511af613452532bb93ec330322c2d278b847c5551b54fe3ff3947e60749db58c47a4c6312a18526230904ea0618db960b054cb8132682f2a72e7a4464718a6b041d6884ec5fc72a823884a21cc934a5a95a3f9b64ea300d49d656b7463e72ad2320e8a80759b8acfeab4326b19318cab8a18465d84868e8e8c3a62800e2325e52b759a7b3e959c70bc8d7d54a4d6a512765a4b348cf3336d2249e29537ad49d9a52f4a4ba5ba5a5f35bcd1bd56f506f4b1f563f15e7a431a17ceaaa2d279aacbeaa94e126562c278b975cab305c60ad05362842c550f98f6816496254da5cbe39c42474c5a97263a44e15958d349680ed7bb5fb6b73f69cb4f5e95899172cb706beeb43d07d87a600f15e03f9bcf0ddd02199c16b4904dbbfaffec7d8a52cd190ed671d6af128ce5ab3ff27fb588d54c2c3aa4750623a68faa8ca56235aa880653ae32b534ffcb95d0b642c3f2c8240b37b56caa45e7395f85136358b7fd954c06423cfb1b0bd2605e874305408ce8e2e0cfdbed9de7b9bdef78da96919ad323a531755d93f90a4dabad5c119c773e5e31cf73e4e553a51657f7d32e619765c6fae8eaf0dda66c5b3d17c7dcb2c69ffd548db8059e3bddbae3000eee7cc40038710e0481dd10097c3c0511f890f12116467d659fa31a84c72cc848a446149143a413925929b63b6cd594a9da24bb226dc4699934ad941ad3be46b2896db1aa9cb5a68e84db3324ddb5e28e93aea262a6711a4f6464eedf449b26951401edee416eededcfdbf7ddbddd02f6f7d9b6ae0891f7641cad55c857e66b7e2d8fb9eb6f4c7fa5df6f2c9f703dca5743218e5c045c2b2b17e39314f5b42b9f412d988859468165c41c127cb96bc11f70ac2410df0a06d743380a7c548248234652115a12e5ad5cac8b96e4065cb9d014512c6c5b6a8d8c58f69db2adc5239a9405483cc872778bff21f11dfa204ea7456eb9c28b9a3c63fc63b20343c3d14a7a050ce545d952dfc7d2b9120e7404cc4c8d82ca48b81dc4fac183ed0f92d7373d70fde944bbb26031b9a34c8d9d9ce4c733e6b26a7f7a9ef1ea48b8241cf427fab9175b4c58913ac40d7977ab60649b1134564759b29e7b63b4f81591659c163df63a4b60b391eb8f58060c1c2b9da53c3589a418d6d55fc7c0ad666bae25b5f12f13831b0b6071b89f3034eca22aebdf31
2765a1ad5ba00996ca79bd30c2eed655576fb1bc2bbad8854977bef85cc6eb68f2a0feb0e6ac36f257afd63b70d7764c5da1d982298098c1abaf73ecbd8a91debf24f2eaade9b8bd3ed89018de7ae5357053ddce07e02cc84306e960cbcbe026f31973534a144d625f84729a5f6a98328612d53109e55fa7621f927662da89390bc939948fca48d7745cad2b9d493219cc6a3e33496c6623c6c630648e70e556f570040f00b8a9a22019571d4ff6a1b25540bdbd6b431032a95e530bd4a011413bcc6f73cef3186f89347612ddce319c86901d5f547ea666d24668d5a5f198b691359fcc67bd48e633078033b54c03070330d9222073afe1e9a716c12ae551a9b319af28aa8b144893e79635357c466bb5f7d6ac8dbb5e20925e2edbd6744d56a32e7f271f1494a7c19ce94923db8a9b2d6f27b2b2567d1ddf166c3a7c485c42ac378d35f49c59354dcb58b34df229871d55ef8e7b8b5f0b5d56febbfc77a947f8efeaef4db29e7f86dea9ed49b1c368d48a7c29d4794ec539ff29d4a786c9cd5413876953e581193b211a96ed3fdd5af55b0d5cebaa6a91ed3f84956b233f8675497dab3c26d852ffd4f11d25a6b6d4e612474d3d544f5247ae7f437dddf63de95b827b1a985740190ce20e009e4f8b75b3d25747eab9cd58c57280e52a83501f9e0d5516ae54291c3ac293540eeb0a49a319c99b5f803991fd4ce94543c8844a5158ff55e36462640790cea9c25f7ccb708b2258ac6b24bf1b6727ace73ee27793b4f3b855e2ce752aa62539b98720e9ee18d9d42c9ce6a36264edb1350d612f4b666d629d6c7065594db89ff6b205d8dee10a5ed403367c03097cffbad3b74820aeb74d710dedccfaab2cbe083bc0b21d874dc061c38f36c4d37623232f33e0f9ede6f13fea09de2c14c06e35a67b5b928cd1de2753c379a26a089eba0d62cb24b5bc4036441ab8b8d6401c531b06b9a3935d3f5a1fd2d6703f103ff537187d3df041e672d00c40967c59cab59ecb39ed38e33df69ead3d5339ae9f6cfd65f7549a9d833bd6a01f465b393d4c9f84cf367e1b3dbb25ee65715ce5e971f2c94d42738b2537e08196aa5400cc69b216c1c0d14ac84062ed67c8d2af6a79fd08014a46967f53186c36276446e86cee664e6d1b764a4e5b4649c1212e094a6ca425b739c89354274e72d15966739071d70124e56e0601c75c072ec8207504d77e1a361feeeed8f2e26cf06d2fa56c55f3e1b787888e96e2a9ab0c558e14c13488e40f450e9c93fbaa7f17cf705ad0e577bfd79091ae6a8508e7d76f66feff8bfd83ecf0d0d16d6d57679d928972b5f16e7db9bc3d2f913c7561d5f030de82026763f53c378a5db23be796dd3e9f57c0f07d992ace7cfa5a746cf4c6b31585e3f20aa9161cf2873049cd634f52d5c98a9d9b9b1baf76537414ddacaee642e509ba13791d2ca38aab8616ab394b8dec59a63d05b08f3ff5c2d928b5fcccb91b7b0d32ddccb27833e293f3d1e9ce56f7860cbb4e951ef110a00ad52255204dcdb0db8f61dec7e9c1e4de0f403972f4cdb6b8458594cd8fd7915333d9a0a94c16f9086dff4a53dad52df800b5ddb9905e44cb35bed47d6af7b7bd705e2738aaf368adeb2ffab5e16074072107bb3d9df69861ef33ae33da97decbcaf79567ab5ad9eb14dbc5527c7b1cdbecef1c7bec7a2f20cb56cc98e56545657bfc7839315deb30e7bb2dee51c5b061825d3a42de3bef03fd597a5fdeffe3c16fe2cdb23e0694b99ba99d33c4b532d62dc9936308776cf61c463729e3745dd16e775f755f716dc4fffb7cd5f75b8185647b504c30645546e9bed40e272ad8c370606e8a0982089f20db7c3594743e4ee9abc9ae35cd143cbb4f47a89ab7a5c5b46e3ba2acadeb7e6cad6878a6754fa62bbfea7ba6e0d93ad0595e984b85eeb7fc4dafcfbf340ef7c4866019ed1bc3d5424bba05a30ba0482ec228d3ec556328ac7a6a8c758442f2b8f5978b4d487e65b680e5940b6537391b515a55ff588ea895549ba0aab8001891a4cc174da84045709b1623926a5b25562b365553917a07b1809c0808e7276f32d3028de0dfce2ed01995af2c6fabdc2a51f39727430d5a0f6c1396290aae4d9aaad07c47730da4d13042a574dae82a5675d2a68558b2950b5fa540aa1aa2e38962cd3cc512a36ee855216b5918facaa449ee28015cba2c5291070b3be1c8856a76c4412a88ca4240ad483f018c705ae018b45ba898c50fa11ad6d9a90636d36c95666a37f2236f73205b684118b9d312700d675e522d9a9daee2cdcb91405b9c722490084d82553f1a42d9b050aa0c118ce5389107f8b3e3e2e984d861a8a4b03eeeda49e0a666ed04b37450da32b4e9bf45d2017cddd8f3ad12d91ab1a4bbbc20750609e25f3d26887480d4aba71afe20d6a9c66b17e5d1a755106b70300d905cb2b26f33ead8d23c152debdacdbe0427632a12ec2d62a41d543380fe2d558ccf91e1a2903d6d7588dd69aa93dbe5d77764b7fbbc2f4fb38d4376799df03f4ba7f9f5a97599f0a6591c7e8dfb6a7678eb197baa844cad7d8e00abac6a8e03ce8e062bcca479e05edbba164a06820b9073ff61814614c10619ed78f43b9908a0b2958f9a9e39fbc079c10bafd1550f365716dc7925b7653d6073430bd0146b7cc9733b489186ff3b39ede64d5afa6df1a17ee9798523fe47735ba85542a11d4b8f16defdbe7551e234b9084e8a6b2c2959f1b6a65b224da19ba9b412a77c4db9297725d0ee61d49bfc33b8aff8cfab5f137dd6cf5bfb837d57caabfefff86fd5bf917b812f905c2097a92f2a
2Adeeb57fd3e103f941b543f908eb8f2ce35f6aeaed2b938d32309038888c1b0ded6233163b976237529cb9c68bacecd35c3b221cf73f9b8da1f989fdae3aa9d77a166b8dbbfface59fa1ab96b213d6aa12b8f949c51b4ab6c27b2dc662d7e46e015c1248044f051808aabc52e0aca2b26bcf0f05e30d557e059c401cf8993662d2dcc96032c84db01679362aa3da79031b085160220b85670859821bc209fbc6364b398b1b89771ce1ef461d72a4395e310d03c714a75fd0ffcd97ccd1be7c48ad174485babf882dee2cd2e2075882f9778ceaa78c48b501ae6ee9c1715589910303c99314aee9b71efc82ea4f91a9712e24f3ab6c97e7909279c46a1b2f1ebb3ecb98d2336fbf348331ea23df8c20cc4624fd451a2f4b862da3b55a0ef7af261d87cc4227fa41646408a5c027704720c4d80d3968a0d8081c69b0d84db8c778ae96db86d1596db86267dd4ebd5cfc2e637de12c4b671f2df6c9c66ba8b35e8f6978b13975741e3aa2474fb23162be9aa75638c2db4ef156d572622455fa3fba01955e6b06c88e7917e61ba5c8a4b4601968f2b9daae0286815445262a8f8855391e299cc2169c5a09edede6896be18c98acb4715d40a25ea05da93b3829150d45a6a651e394719c79c509bca85347e360450e853e2876c475a336e38421aa54f594374a13b1d487b1189db7bb198bd04aa7d2c7bba8919feb7b4d4d9c040c7545a624574987a4f7a3cff4f1f6ff8f3f2db89bf22eef3854935ef5a169439b07f5706274ed04a2ad593698bafa68dad1003e8d9a2befbafbeca3d7f2ee1ad22d97436d8d6dd6ade2f77086dc4b7c6b6c7a7584e26e7d729c427e2272367e95312e549a7c452f165c8e5fc52e4d7916bf4fc8a3fe21d3d7e28d5936644f8f935e2c7c635885f16892ddae1d887fd69de6e7133bca43c4a76d24e549f21272227eadf6953a2df09fe71e0eb28f178b0f8f3318265d812336f014615b0110573e885050f4d44054894340aa85390204a833813fd620018f173cfb963d3106b091c9cade3959c93dc44e11b01c4481c15b1221e38e1ef1bc513b8411e2216f0e1e888c8f1590aea8892b230eb080a0f7804fe184df197f37c0144ba7620f955444a4815009bc0e01045144c90c4350550528c197ca90688228c3f39cb5fc36ce839e369b71c38020b391f2f3354c88485455cbd45ec4ebb667f39f829cf82e503f28abef5981df0c0ce189cd45ff64bc22c114649db2f4511632eb8461791f664273d3a2e7144c0a265151fc0bd2097b8658bc07398608a1a094e2df8a9e3d010b3b27e35387e5ed54ace8a7813db26242dec512e44b45c4d5c4c7d13584fd35c4b0d53f7593c1b85f9d4281cf42052c86d8fe58a032152b02a1b3936542493d6e953558b086be031fa7122ce437959d227fb72a338805b80e995c3fc939e3f2da1bb0d6e455ab170c6b7c4f60ea30ba60664c944573230442aa66ebaa62192d44f322296553d9d6e890f242365f78cd4d2f2a8a78ef71d9473316315893e32b3dbd958d39491c4798d670c80a78166a7fb5f06bd5639e031b0bfe2bfaee1e8716589ebe2c4c1be2d9f8971fc591f3035eaed3502989fafc2d4c15f1ddff09e22abe3f7513e9d8d7e1778b9a55c3f8eb38ec98bfe8fe19170b4d9393536655f68cf08c36f66eca4b8d30c901a064791d167ac02d58e1814daa65d1737cc0f1174145c4320a190360a46c0764856ce13793e727333dafe7c2554bdf8077287b8f5aa24711b47984e609223d7251fd14d3c7a702d373508f76f2d4d8bee035e0d572cccdc5158450ae7abb2837e97f2a42dd294c414e3c2b7f872f25a716279048bfc95574e6ee333faae0f8616e3f3a712cde7f49f2a702c3e51a87268d585b5255e35434837f8ac3090fcfc0753ecdc23a94372a8e1513fe83d589c293a92be82be54fd597fc27465e4cb1667f9bd327e461d17afaa990a87a530c6a9a221728d11322baaa29a540f05ea94932548e1eb267c37957a94620a5c09a733c60575290997de82ad1ab67a32c6f3ecd9d693190aa97e0253fe1445b8472fc2e3c7d6385605f7e36fce0c7f2cf05caac7d8a72df26d59da9d86ed4ed18daa4ce14994a4c53d926fe6a67cb27425f5b13bde1b81ef46897bb70b7942c007c2eb7cd96e31a48db2082a2af8d2d079aea6de208fd3772500f8021b3fc995a1c528f0442af32cb32b62fc23b6d4528e1b7b6fe3ccef421a5d5cacb9e247d7123e2caf321db9eab975b7b89f171b2845ebc21b02433a2f16026be88ac6d58e14f11b16ba8971136f248039b7f6aaa1ca3f1f468f6faa99d1cdae76aa0f9e659f68bb75a6c592c84720d3e4352ed0b7cc47806908e21fbe2188ad302f19b4213529082dc2dc217b089407610b22afcd156d0bbcd14d375886d79c10a27545ad643f4b57e6e99d7483942d68a7213820d9d127d9b810dd082640f71b486b3b40706963dc20db482e45509974212da1bfe9068b5b077903cca1b417040c727520e195d81febcf7b5f6b65b44f9a7b45135715cae353a0037499540e224b85d7ac22b6a060b43d02afc6efb8f6a8d6501978d260658cfbbbd2efafb462b41bea8a68b4903637fd190fde8afa32cbdf75641af5a8a75dddda6ad173507335ccd4efdf4b733519ada8b135521a6b4115ae975a90753ae7e8ef76619df3f801ce2b5e7a852b785301d8534f2704287050f25d687dc456a7fbb1575aaee9a1916e684ebee87426c621a1051d1b0466858a803680067c7d3e0a62d6fbb6aebe300e710619d55154e88a8abb3b507a49defd5d23643bedc583
28fd3aba7a21be50a1031dc4552222defad248a55f5e83a82a28e968a6b465e95ae837726175266d4959a9fa754beded11c1f507da14f54ffeb93cfed9d7092b861efa2ced49df21bd4752e342a5e5f1cf4bba767e7248d61e56b8fa7a67a3b73c1c886979a36879f3fbba44c8c2e1bba6dc23c14f527d3e42f7cf1e6470e3f11407dc8d41eee327b9447a6f8c8ad61efa1f5ebebc0fb87e9a5d3a8c5e868f3b44ee6aabce4827e95277a6d2ed62a1e8f5f7cf5fbb78ccd677a3cef4d04d392bcf21a4bbb98cba2335e5533ac7c776032c54b0a0729d5a21462e765b407a4c573d74026fa41a036a288747a4f40e4d5a7b7a68d5858354356059c31e5f1f7841c5a3be45c3836c5a6f5f9c917c5d444734841f7e9bfe7d3eddfd39dde6444b1ce590111f7ca212c9602e057941fac59326d620827ad0a3780edd34b5c7647a90d2e3ea29963c1106a29e1db43e2dbe7f6d143f0f03c9f7af220bda1cd98ed4e289a1ad231e28f3febd8be64997b9291f4c3ef1295a2aa64a40f7a74b252fc780e97b476fd0e9745c8bbb5629df8ada86bb8a63fab896f9460b3b2df5fb5d68f77667e57dd3796d640bbd5f28cab0865654bc0f005193c08a68ea03a4da43dddced1cdfe03286bbd6e950c236fbdd163e839fac3d1de3101bc9805369676a5a9fbfec7a2499c4532da4707ff1420201cad675ac1cd38dbec517842f31c693cfff426721c98069cee8d1b62a7be57f4eef255df4aee2b34fb3dd945361d0f76bb2d95770b4f4564c3759baddd3d337dd3dd69a5b3fdda26babdaed897d3ec7a67b61af2afabbd2f4b67ff762fe9389b87953a806dc2133f5a0cd63b13e3adc4f872692e7bbbf627690880679cf57eb7d1d33286133f321a4b9eb0cb9a394249925c9da0491a19c546182df5a3867d087297fd1352d14981e9a0c71e688c5068c3c954f2319669031e4ac72f23267c8fc8f34d24c014c03a01c72d0fe5f2b452c463aa1323b2f834e20d7e44260788720edab82d446a05a1b515a37513a8743ee84da2803d1db00d1fa8f3461a02aa3a30e8e096d12a5a29475f8bf50b3f50adfd6839ea177f5d087fd72ea309a08fa5a7e97a587e971966f4ab75ebd28debf7d2b9a57a52ff4fd2ddf4bd295e963a54ba54bd2c5d2d94a17a58b2fafffcf3f5fffc4214a88c6cb7bf83468f9301b319b09853cc6a4b5db0db016447c83b185d88b0d1ec6ec25f4d5c5ec560acd9be0d71fb193564c5a75c21c3471873fc00c714704d70271c7e14e24e3a6b69c060e0ec747d399f616464687a3d1b1d1c49f13fdfd687d1e19d0f070a27279a8c460a07fbc18191c291dcfdfe9b07634384477b8307fb43d187262616fcb51a1f848c8d8e0bc7584ff18503130eff7c83d7fb268072b46d074234b424f7fbc7e05523a30a2a05077d843f0c4d0feb90743898583c998cfc9e14d0e47c6f6c6079a0cb7efef2a1f1d1d8da05a8cf341b1e1e4ff48e4c2d1e990363b18c41e0f605a1c1f331e4c14289a4d0ec6fb3f0df698872760520b27988fcd46148f69a8d20500b478748d8c8d6dfd8593f28d3214c3cd272614fa8703855f70ac47b85970fdc1e4c295a651b1e1875e20ffdc0ee3d73770bb89753f40de6d8cb0471991a7c1cc67e67188e394c0d0e7b31166c2463e66b0b1868c2199937befddd50d0ed6d7fa5690e562d4fcc886b26e37eabbe5f001270058e43c4d83c32a1005a070600ca500b30ce009b0ca8cd865cd86543464a7c857c9d187530049d3c07e20fbe5c04ef10c3efd79063482201468870087c13f8b01fb97c7eebe2672127e72186ca02564a14630e23a8cfd67b1f959e6410f6e650a67727473640a6d61656f646e65310a6a62203020330a6a626f373733326e650a316a626f642034310a626f20303c3c0a6a0a3e3e0a6f646e65310a6a62203020350a6a626f2f0a3c3c646f7250726563756d412820696e75794644502065724320726f7461352e3520372e312e766572203232392063412031657669742f0a29586165724320726f74796d412820696e75204644506165724329726f7472432f0a6974616561446e6f2820657430323a443730373131313731343032312732302b292730306f4d2f0a74614464442820653130323a31373037313131372b333432302732300a292730650a3e3e626f646e36310a6a6f2030203c0a6a62542f0a3c206570796761502f2f0a73656e756f430a312074746f522f206574614b2f0a30207364693020335b5d2052200a3e3e0a6f646e65310a6a62203020370a6a626f2f203c3c676e654c3120687420302038462f205265746c69462f20726574616c6f6365443e20656474730a3e6d61657200090a0d64e39c786060639001006310202606290d256899b4a165a56796941c8ed3011079a595b92e010a9945ce0a6ef92589a9ba0c6a454c1464380cf54cf58a15ccf52c14cb52150c8c8d324b931cf42352cb5a809419819419381703072448600c90486748648a0050650cd94015cc0c210ccf50d2408aec1424e02c402b000680c8951e098b646e650a65727473650a6d61626f646e38310a6a6f203020320a6a62650a3030626f646e72780a6a300a66650a393120303030303030303036203030353335350a206620303030303030303030203731303030300a206e20303030303030303030203036303030300a206e20303030303130303030203632303030300a206e20303030303330303030203530303030300a206e20303030303630303030203233303030300a206e20303030303630303030203135
20303030300a206e20303030303730303030203639303030300a206e20303030303031303030203838303030300a206e20303030303731303030203335303030300a206e20303030303931303030203633303030300a206e20303030303931303030203635303030300a206e20303030303132303030203836303030300a206e20303030303036323030203133303030300a206e20303030303036323030203335303030300a206e20303030303036323030203537303030300a206e20303030303236323030203835303030300a206e20303030303336323030203732303030300a206e20303030303536323030203833303030300a206e20696172740a72656c2f0a3c3c657a69530a3931206f6f522f203220740a522030666e492f3531206f5220302044492f0a373c5b20443435334344384239333931414634383033364644414536413738323e4132313533373c384244343931434434383933364641464536303338324441323141370a5d3e414644502f616572437669746331205865203020373e3e0a526174730a72787472320a6665383535364525250a5d0a464f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Euo_amyuni_viewer.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
