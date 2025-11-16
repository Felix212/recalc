HA$PBExportHeader$uo_amyuni_viewer_600.sru
$PBExportComments$Objekt, welches den alten Amyuni PDF Viewer beinhaltet (aus Version 6.00)
forward
global type uo_amyuni_viewer_600 from uo_amyuni_viewer_interface
end type
type ole_viewer from olecustomcontrol within uo_amyuni_viewer_600
end type
type st_4 from statictext within uo_amyuni_viewer_600
end type
type st_3 from statictext within uo_amyuni_viewer_600
end type
type st_2 from statictext within uo_amyuni_viewer_600
end type
type st_1 from statictext within uo_amyuni_viewer_600
end type
end forward

global type uo_amyuni_viewer_600 from uo_amyuni_viewer_interface
integer width = 1349
integer height = 1180
ole_viewer ole_viewer
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
end type
global uo_amyuni_viewer_600 uo_amyuni_viewer_600

type variables
PRIVATE:
string is_LicenseCompany = "LSG Lufthansa Service Europa-A"
string is_LicenseKey = "07EFCDAB0100010029A6C2B13EF322F36B076F3BA07CBE9B581CB5AC2DB821D9533BAA62A7C4B971E5BDF5BCF7FE3DE063D22E1C9FC8"
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

on uo_amyuni_viewer_600.create
int iCurrent
call super::create
this.ole_viewer=create ole_viewer
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_viewer
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
end on

on uo_amyuni_viewer_600.destroy
call super::destroy
destroy(this.ole_viewer)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

event constructor;call super::constructor;/////////////////////////////////////////////////
// Ein paar Initialwerte des Viewer OCX setzen //
/////////////////////////////////////////////////
ole_viewer.object.StatusBar = false
ole_viewer.object.VerticalNavigationBar = false
ole_viewer.object.SetLicenseKey(is_LicenseCompany, is_LicenseKey)
end event

type ole_viewer from olecustomcontrol within uo_amyuni_viewer_600
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
event alert ( string message,  long nicon,  long ntype,  string caption,  ref long result )
event jsconsoleprintln ( string text )
event pdfaction ( oleobject pobject,  integer actiontype,  ref long ocx_continue )
event sendemail ( long bui,  string cto,  string ccc,  string cbcc,  string csubject,  string cmsg,  ref long ocx_continue )
event choosefiledialog ( string defaultdir,  string defaultfilename,  string dialogtitle,  long openfiledialog,  ref string resultfullfilename,  ref long result )
event objectattributechanged ( oleobject obj,  oleobject attr )
integer x = 5
integer y = 8
integer width = 1321
integer height = 768
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_amyuni_viewer_600.udo"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

event printpage(long pagenumber, ref long ocx_continue);// Issue #8737 specific page print does not work 

integer i
boolean lb_Print

// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob nur bestimmte Seitenzahlen gedruckt werden sollen, oder einfach alle
if UpperBound(ii_PrintPages) = 0 then
	lb_Print = true
else
	lb_Print = false
	for i = 1 to UpperBound(ii_PrintPages)
		if pagenumber = ii_PrintPages[i] then lb_Print = true
	next
end if

// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob die Seite zu den relevanten Seitenzahlen geh$$HEX1$$f600$$ENDHEX$$rt
choose case ii_PrintRangeInclude
	// Gerade Seiten drucken	
	case PRINT_RANGE_INCLUDE_EVEN
		if Mod(pagenumber, 2) <> 0 then lb_Print = false
	
	// Ungerade Seiten drucken
	case PRINT_RANGE_INCLUDE_ODD
		if Mod(pagenumber, 2) = 0 then lb_Print = false
end choose

// Wenn die aktuelle Seite nicht gedruckt werden soll, $$HEX1$$fc00$$ENDHEX$$berspringen wir den Druckauftrag f$$HEX1$$fc00$$ENDHEX$$r diese Seite
if not lb_Print then 
	ocx_continue = 0
else
	ocx_continue = 1
end if

end event

type st_4 from statictext within uo_amyuni_viewer_600
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

type st_3 from statictext within uo_amyuni_viewer_600
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

type st_2 from statictext within uo_amyuni_viewer_600
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

type st_1 from statictext within uo_amyuni_viewer_600
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


Start of PowerBuilder Binary Data Section : Do NOT Edit
03uo_amyuni_viewer_600.bin 
250000d400e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffe00000005000000060000000700000008000000090000000a0000000b0000000c0000000d0000000e0000000f000000100000001100000012000000130000001400000015000000160000001700000018000000190000001a0000001b0000001c0000001d0000001e0000001f000000200000002100000022000000230000002400000025000000260000002700000028000000290000002a0000002b0000002c0000002d0000002e0000002f00000030000000310000003200000033000000340000003500000003fffffffe00000038000000390000003a0000003b0000003c0000003d0000003e0000003f000000400000004100000042000000430000004400000045000000460000004700000048000000490000004a0000004b0000004c0000004d0000004e0000004f000000500000005100000052000000530000005400000055000000560000005700000058000000590000005a0000005b0000005c0000005d0000005e0000005f00000060000000610000006200000063000000640000006500000066000000670000006800000036ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000082c2d37001d8a817fffffffe000000000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000004000065f800000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000032fe33b6146852b6a096f64972f82c1c30000000082c0feb001d8a81782c2d37001d8a817000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000037000065f800000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
23fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe8671c2e94aa87d0ed4c9635cf329140790caead41c0a84d106ad60d36da2341c53d72a8261afcf3df55fa6ae8851a28735f443c1c57ae5de4446b52e1c31a2c3310defeb1c4b859f5cf73c253ea5bffd8cf58eaff736ce91e65f5acc990ccad3f7395075f9951356ce93e660fe3ccc9537cbfed6f86fecbfa2fb25f215bbe91cc30a695fbff8ffb1e21ee77700e61b554683dd32adad618f7f1f7c58b8817ac712f90aac6b446f522782d8179485f40f78fdb25bc3d72078f4f13884a0ce3ea939c4dcc3e7c851e19d82787d81b60783005d120ae983ae73646e65616572746e650a6d6a626f642030310a626f20303c3c0a6a79542f0a2f2065706665525820572f0a2031205b20312032532f0a5d20657a692f0a31315b2044494536373c36303234303134423431453230373832323238333430384630363341373c3e46323445363442363045323031383234313833303738463232334134303e463036522f0a5d20746f6f20302033492f0a52206f666e20302038462f0a5265746c69462f20726574616c6f6365442f0a6564676e654c342068743e3e0a337274730a0d6d6165639c780a6060606060612a4c610460626266204660641064f2076e4c281840d998c4c6c6000192f24a036d38646e650a65727473650a6d61626f646e74730a6a787472610a6665723338353225250a330a464f45000000000000000046445025342e312dff250a0d0dffffff3020350a6a626f200a3c3c0a6e654c2f2068746731313532462f0a3365746c69462f20726574616c6f6365443e3e65647274730a0d6d6165749c780a6daecdbd38240f294fd8a7cf87f8b5709ead4969ce0deab7b3707ba0d7e93d06111d8def57df3af67126e94a6d8166f0ff03018cf3fe7fe37fcffc7fe53fd7fef3ff7cf305fe7f7fcffebffccf3f9e7fc07ffcf8fdffefffecfe7b4ff7c67ecfa9ff7fdf05efe04bff517c7562c386336fc7fbe8a52cb1fa3e3d9fda5c04ff3f3d2c5546ddab2c3f39ac8cb22d3646ec067d2cdd1601d181f3f8c2abda0350df4ea7e25e74dc6256b7c4a8192eefc9bcbede1acb7a5b6062adcf77d9d2b72952813a2f7fbfe3fd5a850b409aa3e9be7ce3535bd282f9fe7fe6b6e6c6377ab59f1bda9be395f85ad0c82ffacdca8adbda2d0c56f85b1b26ffdcad2dfebe1d79ef922d5469c92e441b690d6d4bf8daa256efe45593e7ff9f3fe7b379e2b2f7faa5dcf0fee7b5997d8f4df7f399c69d3fe8f0597595d0c345eff4df6d976dbedd6d7d8c2e6da973f67f1adbad8cfb9e5cbbd21ba58fb19cb7460bf47efbd3758396d92fe987ce59c6f6da6e4fd6d12fda3fd2fa1571eae9be7e60e4b4b5daca8dfd61fd3fb7e2c3fb05e917c52fe6f4df033e317b8773ba8d78a29f7f1e56efa42fda4fc55437c49be7af374dca475502d227966f0d3fd3d28b4d361548681a3222a77b4dc6b275289c0bd37ef76e4df62a1d11b5aaec6f64eae85a0e82752990b87f78a97f507f78a98b92a3bc2fef9d0cf9d2ef9d8d835461ce3669b8ab2288c868040fdfc65e112386ba15fdfbaf850d5970483d4a85ef673f43656213a629a8ca435a9de8f38a635b5ba6678f666d72e9beed5c320ae9661cdfdba082117f58fbf88994389b7286f275856457269beef98875f176a3248b5a1fc8922fcd06da3fad94d920350dff88d1b9c9e9fb0db7f790dd1f67fd40a59a68172423d04a64e80b130502ba2502d02669450bf6bdb68c14d98c754dcaec7861b48ad93ebfb3522ceda65969bb9aab23ea5592577b48288c80dcd6189746c12a93f04cd634cde7c7b408f5d3cd9dba0f20919d565d011b05fd6cd6ef06a01804379d9ddbecca0d5ade655c06cf8d079b66ce4c3fb59b7ea148f71c07d380807c634253bd92ce7e7d2c0a789247d9d9b329ba9dc14ef923019668060f399b5fd47ec1d13335a5db292a0fc0be992f3beb2f729186f6463ec8c6d015989e3525806c14ca8691c39bb66fae2a6870c6661885f6d64dd18a553469140bf87f685f7766ab5efc3bebf385fa22c87d8056f5deab2bb836d91d0fb498735423fcfe6ad6e3224eaf70737c7f54d476e5dac4764d7b611cdf466262582fc1ef2af0c5753753ccea0351bff788e52a3cfc4e9619bd68101cf688cfed4dfd592ed1bab22e4af4dc97a057c579ecd5e54e6abb87b13d77412ce285c1c35ba42e43a5fee73eeb9fb51f1f6d40949ffa94171e90d1276f4b548d8fcfc25e3fc7da0862ba52bf0efc078ac312dd95acac2a59669d559bed9396d11a489c911fbf8af71717a3bb898656940faadcc6f049e39c88c6690fa1a625f58373e075e7643e2aa7d8aac6d918fc55e0657e506c6e5c0ef685fb76977769f5d4ab5be9575fc189acfd4ecdd2aed9c59a6f5a496f4feec3acc0c6ff7749e862ee1c150a8d9a138f9c0d50fe7e53cf7abfb0211c27cf5bac812fa22397f7f270633c0dd740b722f78d1e7258161818130cbb9a6ef2f475929ddbda340682b74be11975ce3d067e7f21c1cb05ff9bf5137dec36766fbff6867eaff1d372c27c229a523e8318b90f34b4e6be82b331c695dbbe03d8c34de4a19c3921dfc5e84fe4a3fb40d84772b1f03741bd6802e372c2d937c60d117cb2c63988dcb06f35a1b0192b3e78e73851615eeec181997ec0766319965495746ed37e24ab67fb1a4c07a1d8caf0bafa9ccb1fefe94b15f671a83bbcbbd120624eb62dba36
2F16a6c68d22d26afc4f21955f506032a8493b91c0a38b54ea2a7dbcdbd1b197c63c4dbf2ffe359794ba72fcc40137e660a6935961ce6edc041f30a0c422059418cdc74a1f0250a8c084a6b74c2f050a709b9f41dd7f32fb0fcd65e472df224b12f62f91746f942ba5d29ebcb3dd1a23e138e07e4c6c17f12c550de580c26cd0ece426a9921c78d5a9c034d46aa1d91a56a66d217a8236e954025b9a6ae5b640b061038f799d06fc4cc3b866f5eccb61f178c5dbd38850a2f563de3ca137953b170d74509db449923f2f96a4dfe806ce7983f7fb38227383cb0951274ff80668b9bb5e46f54d31d399b326931fe550f4df74592e7e9c5689fbefd934c1903a3e0880c67ff347dcb2cacb25640fb38e4e84e3d3251baea3931e3698d5150a729aa26007007fd30a5c693ae2a2628dedc84cd7d3a9961586cc624f083bc266864ab7b7e162c3f887d379d1e3b82faeef71f46a9cde23fd3067c9b020ef98707ec32c7a8b076d2bfd69d07c53f58fa81b8efdf41fe3d62d1994418abea0fda695f47a52a8b76fdb1b4d53e14859538d1a9a97e41982af99664fd2166bb0b3ed012ff4e059101b25e94df675bac1467b25ae68ba3d6db29cc9ecc5c0bd1ecd990f52c80de135f567d500d88b858d6676f011a97cd359d4545536774704ccaed38d75a2b950a55d12ee9af6d344082e74d2d9dd9be96057ca123ecbbba6ab3f9775bbacddd35f597774d3597eee98d65a55fdd38d4eee9ae9a42bd9f5f82be0dbef34c0cbb08079672df42056fb0469bb046968ff5a5bed012e9cb320d692ad35f574bed174052c8df2c86e93b2501a9241e4f3d2dd634bd7252933d0cdf6c6cda440c6e71e1282adf761ceb97dff1fe83ce27e413f13c96992b657ec92bc2f38bf1ba7e6294c6af9f72f4d33a1dc88cb834cb48ffcd137bf72d45eeac14dcab0ead2a82d7be621c3be7f4c9659cde9ede9836ccb5411059d5f75a06be2d93a5bf2dd77cdaf8f8fb15896a1a72ce0a6f4b235d0ad70e4f4b0ab44e8564fecdbfa979fb86bbc7d6532deffa82b14e7bc9774a5a3f29f6677e548a9f1e70fa690a9caaeb504e5c1f8c3a99ebb585fda6a2d1ccb8d3513b7a58badf6e713a6d4bb80e0260b67a12e053e0fb450787a3038dc6a9cb52ad92a1c2f24f9941d03ca47fe3fe9785673acc97fba1da61be77903cd7f397919ae21e499717b563931abd29a19bc91907a44ad90147a2abdff28f5ac15afab8adaf9f61e65a8f557bee982fc60dd920051ea19239b43e8106e21beefe1cd5e7859366f8d577855d95d9fe0c6192e776b26e38a6fd25837613e69c707ba0264109cbbe4b9d1cfbfbca573aff729f24b656e961325e7fdcf97219732bcb8efe36d7db56232e4fc6ecd27ff9c9343f635dc078db8ed3af644a1ef5b5c21af794afc3a7df250d816c2df1d54160242863188ebd3978ccb6be5d0d7dadd792905e7c6c1a3edea933d8073684bffecffbfb4686e1ec5ff7eefa3606645b45cfdd6c273af25a2f58d0e6f69767da688b9b91a4024ab68840f74c380bd302ffb60df2d01b4e606dff86f72f899954b1dad877cee16664eabd0bdfe42da2688c6dfb445d80c4276d8d0af0135a7b77743295b7a0e6b7afd51500c319e134e9dd88d92bdee22ef2b216b0795472de1d3806c17f161c30dfdd6d7798826cb97a281ed7b2fa527b58dcc9ac8075c3b83906fb4947e5cb296c0603dd618c35596845b9fdec7fbd5573f3e7d4ec79603341f70aa6b6a4eb0c5a20ed7a1e74c6d64546d0bcecd15c37fd4a31989b989303efe82c066ed561c8adeceaf40601a76c360d0c3bc589a7abf0814f2bdf5b62c2bcc1bdc3ca014c8f9bf2ce1927ab3389b8fcd541744ac3c8e83bd0e57efcf3f2fa78e68b0e6d0b4d9c1d9a16f371a8b26ebe19b25fad8899db0ce5fef87538d67247f73b0676e4bf70e853b48b96d402582682c2cbbc089a0a07c73798ca56f5d8ee2be03dc985a5a3ffec2aad65bee7674749e68e78d32d6b4eec1695b16fd41c2a701af93f2b150343e812c14e29d3a59c53607c096d0b5117238e1ffb7ebea6b97fe35b78e0ebac9f77fce210712ad29b52a799d6b16029c1e63bfdf897a0b7f86d50e079e7bbc4cb3ed0799531e77d8d5fa0c09ac05db381de44f51dbc6df396b1763a43e817d92c3e3b606ace5675004181bfc40067190bf657951bdda88d259fa157a7f98a08bad742e03cfd4c5ce57326b4dd4af419ed6b8396b135879ecf9d0c39dc0a60e30d915f15b165fb88b5c8487e9968fd1ad378b5c371cdbe0737c7c4789e58071fde5325678ca8fd7b48d6848bbb67d6d1ae08d3d3c959ec63f99fa6733f874ec2a7c3cb4da864058cc27635d1b617ece6be76764933074182cd522b4dd8882d38990758c3eebd068f2790d615e90a5a517526bc580c269635fb2a7b88d0dd025b4e173db249ac1511e7213ab16e0d16ea534506c1624b0490b6f5960e2ca870453049105f46449e79709da49356de1feb9c3f160f884e0475afcb5e723112efaabe943ed0e43d70fae5d111d5eeb47d1730f02063efd6c15e74560a6703b95a3b8e1e5637990d5861afda8f06bf37bd3819f0149dc3e98a6e1b70b097d6165babcc4cbe21b13a9fee2b7590d1556b0a54da15fe4637bc92ef86ae950f9d12f749522303f2b43a387945e54b4790229199df5c7c0a84cf2cf1d1804fcd475c9b0d0b47e8f839717694c316c8d9129b9d0263a1e57d3a4cc0bebe4794b44f0a294a386a682bfcccf1305ec9a10bb7e0959b1bd76c5eb2b0bacc09c0bc219b417d13cdd5931e77b0774b0
295410d41a0e1149f680d1a05feb2d9261e7a0b31b5e7345c574d19c9caf19309ff9faaddf386f4ad58db9ce2c2ec9612ebf0068d7c52d2e2d376e5d2d9da98a6aa59b9a4f829469e84dcfc59869610a6115104f5aa352aa99270fd4d7053b4cdba818ff95ab12ee1ff8841b607d563bc9c9cae52bd63afb9afe9c4d1392e1f1933ac7d3184bac90dc3a56db0f8c7ed5a36ac6507314e3dc39a2d320e3cd7104004568a0957b4e80aaa914172cf6c98054cab3e47063e297b6983c1aa94aa52faeee518db76d702f2877e6b47cb73918f1f1b59fa7e357d22a805415241abcb1a01b72b47d94b526f03d8a6de96c93e365c79c5143e467df021a6cfe0dcfbd43002e5379177dd7b4eb2a986bd142f662034416784f211d4dd3ee13fff6de9bb8891fb4b99b9be37a29067f8454f454fe600247a59eba701a8aa65ab296baf2efeba268bfca66f4dfe7b3709d4589ff7f56274f4c62508234baf43e85c0416616e7b20afcf3dda02fd8ea3c91199e3acd784eedd3acba4faaff2f57f79acdfaf8fe81ac15558c51e86dc34d30ed3da5a345890c1c6a0c2d073ae7b91cc068dd80f864d5d08b34ccc2bd9929d974b987ad34b98886fad13e769f02c49fec12db8470c2a9c6cd305b2e650851f52a2eec2fffd05fc8a699030be3dc22e1a0d2416a8603f8a445b493a3d340c348ef7ad65338f61a48fd1ea96b733e5d3951eb2f4900417ac983e8d962d35d0d27a25d20c074e0263e7a1ca77743fad63069a67bb59abc2b6d9145b080694062d05fe9f1f0775b45d182046f9e57f9d25982c16448091b05f9f7dd2c8fa1a4508a4a3333188bd563815458796abad9cbcc617a70ee9894f1ac66926f7dad0f5ceb4a9d908b6b1ed61eaf402e3f27acf5bea35e997b037b5b2ab144e3c46b342966b65f0289d0539856a10d5afa4fd550ec8b568b4b1a795fbc8d541a93714b59c7469e1508a845aff7caa006db81f858a8065c7aa6e09a00cf782b6445cdfdc72305bc0f257d98a9ac388178172a10cab8b767aa91b5626d5c03cfc512779592325b35ff6b82fb02f5c887ccd702e32f0621b7c3887b6a3aa49a62a3a15764f90e1f806364dce21754d45c62941f8d3bf2f4f6997f8f1d181ac20798b6ad2195509b510edef129bf3c19425ece7bd6567b3fa88487f142a11f70626b3f0b1c2a93819e4b56f9cff7e65d0810fd9befbdb1834ddb7c306e3136b6884fe7494c2f40f9dfe1edcab745271b6e87b50b08aa70cf272036b84a23c035f0f9dc6ff6eb2e67090e00f06fce8615d34ff2db8ee71b2175434c6686551ff76a124d82f60d91455e7a9fd5e47afd732c667b0715add529f8dd2708ff3cb4de7901e5dcca9c220decbbe323dfe1957456b8d28ebc5bb6b73b75a4f46ab2da9f1fcf3d4966b42b1db0934cbeef4afddb846c17ec49e28a2758e96ed045a8be0b921c16cd5d06c19932e2eb6e6d42f3c70f2e5a64510adb11c11f1e80596858bcadd10b4e71d3b890069adec7e2f2f49d0e8f8ff8484ee5278e7a58fc538ce65ccd682e183abefe2176cef7a33e664c146ea5f0965fb971dabcf9da6d4feb6bac345e906c01736bb9da6ea976492e7f368d2f5bda57d61dfbb7b53a27adfd79b515d605241c782b03178e9f07df04718195e19f97b3a9913b569368247ad47f7b3c2ca2df24ff36d5602ec1806f384cf1366a15235d44c79b58371b81f49ecabc6351c0d6cc179b93876f86e971b9d695abfb3373adb59d0ed5ace52450ed0773d82449e1e4b9a6ec6b1e2f891bd24cf44c846dd8f9fb3eaf65c852bbb9b024d71f8aad53c226d58986a0e74bae2f685cf1738385bb4235699dee1e9486a7390b9f46933ca47c6609f0cdb101e977c5f06dd5f854daca8f2656d60b2cd32168b2b416ea3fd7fe3c362b5e7aa529ecb1a5562c9db4d62058f0bf969a1e6519fb3a26809b4a164ebccfc9bd06275393e383ed5d8d16a59002b59216f3f257670d8b5d68263bafee00e7cef8ee79e2382ee79c2cb7c4a2b6fe4236e0276b9d14d03e80b9db9884c40a96460c17bbbd997f8f4177478c9457f4d39ca9e4ea3fe9074747870745845ea34aad03791b4591b9297e1f981123c9bc5d6ce0864d38f28ba36f6f856be59e69d666921b007f233a70d93d69adf9fe4665c8cd7d270e7117378fd5dd0c76bba934de662cdba39f7c5282f1eda53fc774f33ff7108631605e9167aa48c39c61f575a2acebc23ed58fe6e77609a5c159dfd0b1d98b2d27a963827b243f6467755aedc082cd501159af5ade7e7cf225f9f8e223ac481e9796c652b797373be11d037dfd75ab187597aa45748e1e53b3faa2bb248f336e1deb223d170063a59d150ad29c432cab5f4f2ec3da20401cb3db432e5ca4e37b88d277a008a16422e110baa7b62ad50f0574703532d42dd4ff3e89fc0a9c5430052921e83590ef67fced9db8522b11ea1f0fdc702b15ecee41d070241d15fa342c9f9bcb3c979fc189e3c05d1aff09836534a38c0cdc966816ffd9842df5d0350bb185a7632745345cb51f878e148c20ce0edd9beb0fb45a238eea6736d7fe62e54d793208c92168d727e5f548abd6291a8e55deff3eada8624be262879bcfda49b6aae01c8dd0dd91d17e36510a1ba107e7433546e860b532bc488b8edd0268cb611e8c6115270581c0c6ce7e8def038a7985a84e8e38e01be1ba9806ea6e4f0d22f777a6e40753d5c3686e6ea64f41b54c6a2cb4dd714f7ad1148c2a5334e9a9691a3cba37432a604baf2467a833ba04ae54413e788f94fc716f3f240f12fcfc91e4d66e86642b3563b4f4
2B3abbc63ad0ccbd726fea1d0d759fd523dc8bd393ec75af647dc9da086aac6d8382237432846c9c9da0f9e3a1a3d366090a3c89620c23a4e85a5148dd6f655a4ef3d5a4c60ef6325a74325a0da98182236374307edf6708b0691ba196b65e7718e05770f8a0e04876ae3f6883fce428e8bcfe0964a70109e4095f7003eda647cf30f9955b6819aa88744dd0d97389cb7dd14d09c047e1d0c90308172d1eae6935daa87ba7d567ba38fd98184716f1ce35a0ac159d38cafaaa34883a5a23708a1470ef068f43649e3d600d405c07a75ef03bb9d05f6b5e08318ac1aff48cefcee8118cd27bb7cd31615b3726dc073edabf80ddf627ac7fe2365c189f4ca54d4e8e3aae20460b9e1e07f238ac676132c4fe9c376ea10e2acd039f4d43d02fab48e6edc00793fb919d57a897974667a896a7f1d6a25a69994fa786471d5f3531e5b8a796e8476c093df36fd4c6102b32066ac587b3065a991d85a0f4b5aa9d3a7691f7532ee7b9d83977eb3254572a5f8eb64668bb5306ecb4d42213402d1679cb34875371cb1a7397ee0a40b31dd36b8b337c3d232e49da15103f82b690904533dd71646c00cc1a4e2967027532618815a122c606f341bad916fc4915b647de11ea6dfed7165e4758cdbcac13ac5718bfa2e2dae5f003f7d6cad825d78b75e6b1df782971f5974e8061bcf018244a23c19a9fc3e63422f19af99d09263fdb7d0c6eebabd6e6c5d02fd2f8f57bbce44d7b49d6c9a8796fcf170f074c276cf64f0ae79fe6b328a40b53e170fc091ce4fba60fa85491b30ac2af8fdb0ba03e178f78bec0f1177fb7aa15ebd7909d742bb92b564d65ebdd6040cecc4f5e1e5f4432f64c785a4b3dbba0f45e952571a5bd0bca158ae99386741b00b2de5aa5b98da85e7862d5cb4c0e2d5b625823e3d0965a14c9256c4233bc74eda4169ac41bb4956b5d2594ea16ba57eae73e2500190a1f5c707f698159bd109d5fc88222723d0109c3ac4d60e2b00e3d60c95f66fc28b5d013ce9aab4edae2a3a14aee40897a613efc13660717637cc1ed363e1a5999badce9a71c599d95fcea4d59911d97e9570d5e8bf0956a15d56e4006a6b206464395a6f92648d6057c0dd249f5a89984ca0b0818b84a1648a3dc69c9adc0049269b889ba5705c2109bd0a8db4b8641dc56de6cc90e03246e5d9178471801e64bff8598708a3c1d7f41d3a5387817052d6ff69252e4424618a95e78ea6ac19a4aeaa5a680dd1f44db4307420aef2b3c27ff1d2c74f1631f7fd40d69bcfd76a5df0de99b6ec564bc739b29ce11430f54c771846c11a9e38abba8d767c7f13601bf2a9b080268b1d3edc176f6dacd435922ed5a3c1d874ddc4d0a26add4bcc41fb0d3fbe0c1b5711f1142832d64282a3930776f1dec5e7aa1def7eef2f003cec3d40ce0d6db949c84065f5ebde082fffc5c3108f37b3e4b101bcf003017b5a1140ce2c4c83374d416a5aff3ecc432d2ab0e4530030ec3b0ec767ff03eb49f17d18f69b5376c4f01a1fc5e6fb3f99ee9e215d1d492353c3cf4c7103165b7ee61872fd7139424e0fc640adfc25ef42e169e9ec97105a7f58d21b4ea9cc5a381a9f765ba985b1ca52f6ab6f0439dfde1f60405ff3c70285a611bc9a7b83800edc23ed560a054555592e06f01d3599617770e7648a5511f7e9f01216aa0de95be40837c328029e716ee3229fcb2c4c2015014aaebde6c26d6d6f33982f24a94ea0d6271ab393f2e14e041cce9982390f500cab725f3b59fbbb7c0070c30c9d9b0ff589ba899c200f16235969983a2066c4edcb736f37e3b49ac1ae52e13b60bb815893e3bd4b86e9c4755509fab739ab725f2ed31f00eb6446e4b820173349f38bcaa2f155904eaae6cd44af2d9603ae1dd64930a89820848c3d4d67f163699ddd4f56e841fe77ed76d4f79f9f3c497e7e38bf5b12078ffcd3187db92d90a31c2cc5154e1dda0ce0b1b2ff55a1f6b5e76dd673a69d3901ea3066ff611f92719551e80bebc1be258c0b8737d88f79d2e3001ab3c7e6f0950b1d7ce139db92e324df247e76e4b83816e3170edc968b05416f5c4f1b92c3f74b31df4a417ce67d89e3705f62ecff33ffc1589f588e3209a6c94a1f3f7e495b789a692f55b8b3e1048497787d5f177f20bf5be5747f2f6c8b1bde7c244124b0d33c41317fb28057dfd7ab41f151357ae0f8aef73fe3e4b5c97d485d17df8b3f7bf6448fd580c832b49e5aa1de1f5635616bed9fdc7070bd53745a9442dcff5ac7e082737aa9f4cdbbc42cbac2128b73c3c25856018ae37f2655d29d3cf3bee692d517a7252e989720fb21ce01dd9d6d3a32dd6a9f2d7296bfa2a7e570f2a4fd8612f594933fdd45560c61fd68a49ef03c796ea106c19527965a272694b1ad6ea54ef9a9b94fcdec34c064b0c3a1ee6325cead5d644fb48f516380633ea8ae1dae0cc0cd6d99bc38de05a079e295c28fb51d9e096ceb68a7c575733b0b2bc98d565cc2aa10e9a998c49da3a60a6d4d3a4417027b89a23eee558ed0bb205b479768983e777f4147db8a68f9cc2d54268a037abd7d3b0207f3c83073a5d72d1ab1e64cbf5595668f7cb7eb05d1af5219f6fee1f27578328f46d537b44444c2658ae37a845c139bc0f54dec99604d2fa3e14f607c7ebaf558abcb34e37199c2e30b652b9270b3ce0023ad2b1e16e8db7426ff253d092d794d2a2ac1842045471e13b7333939c66a5a5fd0cafce6b7497c78408c9e300bc0b0aee1478d3a25e0febce5f106ef4ec5d6475af4905eb65c5aee1b71bbb8a18c73af5e13d0137466e21402e21270a55765f7d688716
27f06703f4150b0b8678f7e1f2fdbc718d243e2623b6dfcc63624b27bcd5b80d0d84bcd80f749440f4c9a53afdc516a0b1d191cda4c6884a43b68585f9a287a4e129578ff1320a45e0d2e08e8308a38a937ad1c39eb65b350ec6bbfb80ed820fde5e7e38b2316971c2a56f168caff011d42e364d4155f6fc54770bcaa8297be299b2540b82c296958cc4475505779ad4ce174d6b5a5a65392bbdb5ad698dc08cfd95eab15858fe0e272bb7426d9aa3970f60bb53daca5c73aaf845ee95dc65786b8938f5b4e3537b274afdf0a2b7c4c34b2d6f96dc53dd2dadf28a417a6af6880b1b8dfd6c0cbc4ef18440da177f2ad72a6c3872da8845b065c16ab9816c2819b39d5bcff941b260a4d0eb1aff8680fbbd7dffe56dcd017b933dee9763d869b566edd22cb81c51c73be31cbb6d8edfccfd509414d8d1bf9f75fbeb3f60bb151e6796b4dd8a746fe2e0d5612eb8c204671cdbe15721e5b3f925d10b8cf2e6631d2eac3dee4cbd49d69fcefe23056de1ad255729d74dcb6e57c695d355f108441dd27402f106f08d5bbdc1c587cc68af80ae095031d23c89f29c367ed2498d210be27be06905ff6309cda8fed021106296fd15b08835ed00bd5dc65e5dc1e2daee49daca0fc6df2ab7169b945a24d33ce84235302a8f6e1b09d9862cf18a7c4ffaf8b3e16047fb55d7eeaa4a4cec4a875263bab95e3a1022b2277125a3bdac085541e1c481ff7b21192de1cf3a0bbef585b26e2d63c69f25e3cf8acdd8df4fd05fc82132062d27687984231ff9dcaab32b8b96595a1e3f37b4de88cce3f74fee56676e1bceba0a11e32775f60bcf1014a22d4d1be3622332af9bc0bed160e635efceb0a8fb99e3864bb771914184f0c9a93569a324fa6333c6f79e76d4463a88783fecdf249922cea179eb484bdb8d857fcf53e69610e1a8cde3c634f2e5963855482a2d6ee39360dcbdd3fb876ab8ec157c3701e164e79a51722e0fe8ba8be17ae1095e863060ba3fd43d4d76b829bdd78c74f2df42bc0130c759e5a139028ccda86be1cee9c3d5355649cec93ccf5d037fa8ff2d59e27c0bbeb916a96b55dea97aaa2ade6b182d93e88c76e951cfdee64f6e60978b0f1713fb5cc7611349f17c500c158058eab401f4a74f2b45c30bbfb82d2de8b7574ed5dedd3291ab55e353bb11b8dfab84aa28cf2ebb58032cb1b7f2b83bede2c0475acc9a94d90d9253d00b8db5e515d6ba4af01e2f206de31074ba8f8ad0951a58ff2fb5d17a5e4f8a6a2159eebbc0af9ca43d56136d5c32a5c7bdf7c4e5d3ead0bae3a01d4bef93139d1f266fdde1e337f05b30dfbc4607ab1122dab8fb4bd6ec07b5f8bbef9349e81b40de15ad48bb07d05ecb952a85c9ab9db23bbe1b5e951fba83c689b3a1e35b3d3ec67e4d8e4a847fc668d07b62198dbcf8fb63cebfb5c9d2cd603713e000180f0880b12da4bef1d95e706120295c4124fa3d0155b49ad150cfaad18d19bbee018e7eb875821a81afe8038c3b80cd88d7c8abb90d72f8d72f950f323bf0ed6bb6f326855adadad5dda483886175f9ffe008afae9ca5fcb04723c77cd81beae7743ae6be2b5575fdabe1d6ee16281c770f4a52e093078461c8f60520e3f07f0f55d78a8f00b5f57358b83a65f02eb762d32711431c79c532d7169981f0eff4e8d4ed1255aa7128ca9453f17686f3c8de71cfe6cf219905c538c72f499bd028f004e8ab9b220fe26647f08e7d630699c3f67fb1a71f0a3b88c9291f152f7d3ad659fbd3796fde3c05f0bcce9d2982496a68146f1e510815adf815d3a2b5db4cef6f6ef6ab638a1d1158e9ac9c0d8ac78f2caefa5b3febf5f2cac1c3aaea95e9be6b4726a304301b351ec5e1c1c1bf353b39a0c056c4bdbf3f55ab9f0de95afa4a5a4ff8179c36d579ab5b15504dbd63fd79c9cd42afc6788b2c663aeb06a625de81a53d58fb03bed8e49f99ad9bb0ebebc376b88b95f997256f03454f7bec601a79bf70c15280596a9e353a126c19e0ef393c4e76ec676a8239a9a92b7ce2e4215ebbe0ea56b75401c971e8a1bbf84bfd265af589c8f19e7f6e3c63a4de94eb66c6b3d32c09f96e9459e8344cb139a468bf386344cbcbd81685bca9f23685fa663aaed17dd6887e1079176e26a1389379feb7ff2d6869cdcb66f1828038aac9df32491b32cec11f35587ce7b90ff0d9adf7beb5eda3823adff1e298ee62d2788f77e1707aa032d7e42ffcaa0f570b7dd3efc7e56f15ba35f68794017601ae00f8eae83e9c945d48bdc38c69db6e94f491d63fa3f78bdefe474c8d9a9d4fadf3555c6369847180fb9d0454191812978f029d79654cee573cc458c28cb8d546e38b859e096a5d9b1b39bfa30e410327df305ae8217fc943c10f42882b52331ce85c6f0ad86730df97965de2f17d461ba5882b26601abe4ec2452c490b1b64dcdeb9bbb3085edb65b0bbf5e2f513ae88c17f4837ba9748c985f3b539ef6bdc50c5573ed7582111d497708ae7793615d47ecf836a8bab8b28972a319b09d14b57f9a5a62ef232e5b966ba5960a37c41155e05d7294b07ab939405b78b14fbe756c7a3fcfa848c04cd7ed5197bc707a1fffa8a86a22eae1743956a8a1a185d616bc243eb85071a39d26706ef8c2e4d63182ef72af9ba5e3e31ef883e340106cab6e2bb82b10593ed105d2129d6a50905abe2e3687ab773b8025a4d5aba6bd0cb9b3c57eac99f75a0e6b711d3c5094bc5a4a440b922160bed987422ac75dc9ba2541814dab86ed2c62c86e562dabd102e9675cafd8b37a5eed287ae44b6af175a0c36944588bb6b02ee22fa7d9cbbafc204
25e7672bee04b09cdf142d0b9b6bbbaa21bcfebd6ca53a20bb75b59adef059ad937b229efdde8ec3bf6041f0125ad88a2b7df4b50a72c62239eb9eee04764b191371939b68158f827996eac2b8b7e31f1857cbdc062a96cb8c03cda854b5c775e6ab5e06c8d771bbcf162656f720d833b4f666341c19f60fab81f20f374dbf72bf930b9d446c045696874cd054e7d76042b79f8e2578af207495e4d80c446b6962de4c9acf935b067bc5b11ad8f2dc25a863b836ce6fb0465e35679492b443aa49b89273755ce9dbedfe5d85fdd60f96d235d9bdadef393cde19c8f03a62287aae5e220753b3da7a909f9b62d2e9eeba700f8d7d20cc67a54889e82ed4cff9e2af0a10045b842c09b753479eb344a1afc12d1bec989c4f241f2808a922c4739df5fbd75aa436f0f27e1cbaafb6d2cb9b8e430ba93be9af3d7d3c3d742039aee5817df7cfaf6fb9d3f9b4485fb54cb2bd0c11aa441d3bfcec1e91510b79594956ca5af5867ad706a10b59cd1c1230473adc878333b18e82abef13afe6495f5bc4ef02f0163b778bf74c6023e385e11ec9515bc0610ac7de80f3334405bdd147fb9bb406f2c0df76d27940da37f620e0bc6df7c560bcab0780f0111d44f2592c599d361e9b52e8127eb1299da323dc08ef39e3543112e0ef5ae18e37654ffabd4702bef04e5c8faa8bc42c82e1e55eee996ff399ba77fb51fa46ed5a60553d4e9dbd806cc2c96404f4b087a01e6a4132d026fb873c1511f206fdd9e27ae988e7d3255baf3826915c2fa5e1b795c7b01b221de81fe3a3489db22d4d017ec3a9c34e178100e39eac65fe45f4955a5d47ea818ec8089e3e100a5cb49788fa3107855a3b3a2d630325e7fdf3a4658805982bcca5c057f04dc567b8678750e890b047aa4fdc3df9bbf8c883d0ba7167a0747ebcb46921dbbdde1faf2c129c3703a59b8beedba405cd44c45b6d23dbb55b47b4ffbd8004e41de4b84d6158ffefcc275daf8681b159e4b06bce7f549827391dc3168f09ddc9683dba7067bf022185558e237194f0f6f730cbe3561e7b76e0e65b69ade463ad4e71347b64861cde3cf787b430130cfa3929ec0f8798075305d922e9b0424360b07163102fc77668dbc66c6637da1fe67ee0874bde4f15660cb78cdfdfe2281ecd1d82de788d54348d57967bb0508ff86ff988185995f733c1298a0627da1bfc1d983a4c5ed9fe47373f268071f6a3ff28a1a454138fa729e13e99cecc1392d0bce2d6ae8cf14ea96dbfd352f03d85d951aacda3c18b0df5e1d05667131276d8ca7961d1ef4126ac12467ac3b8330e485a5f8a28d289ed243b857ff7f53da72f7cf6e2fc2df6f3f9c457db3974b53cbb717a3f8cf68a3dada9305ef1b03dab47628131c4291e619447edc40dd2123611d1df9332568f6f95be2a81f3bc6aa060f25ba51f8fc6509d0449364d8e00fb87b7b81c849b08da666f82c28f683fb693963da990bcfcdeee3c1018d6576fe0256930e80f8290423aaa90a77e0764e8f6f8cc4270f91c0d5803f98dba029ed82a60c27d92f7bfee36851dc059425f955545f0d98393556a0be8804dece3cedcba0d1257e29a62d3236a2bc5a75b4093e5339ef88f8f3965a04d7af6c435704d869abc9ed415e3a2e699f7994ecb2dc3dbe231e963998fe59972fc85dcd4f7f1a67037d115d5c79d3371527334ba1147b51c52d1dddf3c7b47f4cf58b9a879695c5a89772046c4c85c137c0b2e22cc5a3aa8b1d84e693e2aa878d65174fa61bd29d4b7430728d3ee8b8787aa66f24ce101d07dcdd02d3d9b24512c0f4079e2598929ad9bcfe39a4eb4629d501bff324c98914af48d856b96a4ccdd02e6dfebb68009b9e6f9e6577c832d7ee8c2442a013ff36bd2ef993dcb4ccfa02dd1ed436b28e4afdab2f6c38cf74bfe8e2d6a9c558a45feaa747fb8a2e0af1eda3c182a4e8b459c4750c046a3b6f494e934eaae825b3b77b91e966af396c22af3d1fa43e98351986ee6f983d5c194f16c994788c35fe739aafdd799dcf34e3213b34670ecc603a41ae0099ebda5c3bd07c601332cd439d15a959687d7e07d7db6455332e8ce4cd2f831c0cdfddcf115c6ead1e7fd8970d1e7174b19e3cb6f14aedb9cfe02f16af2f83d3bd42007bf8ca01f28a9179e8c8ed02f8b5bfcfd52235e9146f781c96aa13ad585896da2f63d61aff6e74ad5128af052c8f1ff17b670ad9fe3c59cb9b6828e8ed076f760717767388886eeb424c10f70ae1dda30730117b4976b2cc01d54c082bb1f305d4112f5209efc078b3d932c6832c528810b90b12e41564c69721d8aa255f7f1292d0d84feb82b71cac640e767bc80694133372167698a725c46e1189437b289c46954a69ad04080dca58b3eeee4c7c560fe7f956bbfab154aacc1dad3578b44f3b41d270d5754f99431da9757d3ef29f0738cd298e634e8160c18e049dd41573ab8b0ab95654dd2d32f5b3ead1f9f61380cd79bf5aa28ad74adaa81ba56609d52c19bc5deaedb1ac36164a024b9d36abad1787efa7d177a47f24ea834d79b0c151d06cbf3fba5f32cc399466e8da6cf55bebd2736f12b2a69a176c0f1db292011f4c15744f9cb77adcacf4260e27c038c5b9ebab5f1ba430f8f7ad38e1a489ee55630729d733bf021d823479218b23180481428595989ba2137f2eb57f1a33d5040799116646a562f3f64a58bc8d95cf21fd554124e73050518260fd5de8aab52c312401281651c84c5be3d2956eb017586c32dde60aff014a0e7b89d225d748d5975e559f6882dd97dee94835bdccb43a49ef5543671a0bcee34d19582097e960d
215729c581e7cab6675f9feccde43c87ccf438badcb52d827859e6ae15ae5ff2d17db857eb65e5cb712da0de44c515a7af38077aa100b93131c034c24e9403e973e587e01c69f563bace7fab55bfd5caf3b788796e540f92bbf1232945d52361372f16bb59dc0be9480d5cf7c7b044170c97869398e0cad17d4f49cb2889e345928dc4ffd751c2ffb84507897842a9395a7722c4e5a6ba178b801a442304077150da098c18013884480fa77017014d0a2cb6f6498ecbf6515c2cb3e51b5da4ea9ba5936908e3622b78d4db5b1b8af504f2d31ff5d5c595f4df4331b94974a6ee9a6fe411a650d941c2928d524a2a2f4177ef928d5290d2713758e1e367349a74a1c781342046c17f507c6426986114cf7f8bc3b76813aed6d55c78a89e80bce6c54ebc345e7ab3ff8857f37d3a193fa4c01102c4c6bea094e238f413ec45553cc9c2b453c4da97809b86b720c5d991fc63afeaafd3c8ae23124534bae5b73f597f7187558778c4199aea57cb14fe434f2ba09b2e825cec637eaa4cbc045372f63c45e9bd7196918c2d198196e16c7aaa62fc4eb3d5b9f15e281319e435ec3391cb384c7788bd4f82a518953d695beda1472b06f1f0f54721c2d279f6f5fac7f068b44f8f47bd6a8baa5d6c3d1c5257933de632be36d55ad1c784e599b9402a7fbacb2591676fdbfe433cbb88dce5305a9979afb3343835c8f01ec1cf5e920391719e98ff79c76aa3857e9a8291ab9de97ef71ee36274144d32360f6bcdf158afa15ead971605600bd9fe5f0a8cd258f27e87a380f4a7d231938ba54e5b1aaa4029ba679dd6baa81bdd39cd0201d5e6b63a15e2a2c38b84379152b642663d904ad08e9bae5cfdd76b784bf1f3d1a5e55a8508c0de47c04af2890f565bfa92a080cfe7dc1f49ccf98e2156bbe6a19e3151ac2c73fa73eecd9c7d49f737438788227ce427ccd10f106a6b5f9bdf0ef11110d9e7fdc9790c5006ada6ada99df442bc186c378c7ef0b4031ee59d18b78b823abdde29be0ed849718e99373faf3d9362ba695a54ba338c74b83a71efb45bc849b2df23f591db71689fbe1bbe31a291addf21482eaa5a4e2d3476846b2f2c535baf3c24db96672db3e374020d4ae950cd50cac97936a019e9a7fa85c58774f55e349e1fbbfc778d6f38deab1cb93de89f8a058b2ca068ce245910826a83f1a27f70498b8c9695774d295cd9429b46a3e8b895ecd3d7b345f6c2137e5ed6f1ff98cf91f6ef2ce17389c4bd33c7f1573cb11beb2f8592f4d6a3d69835ada2e537344979c788b05ceb50fe40f03c1e1eecd9514a88617d675d051db36a60e116e4439eeba8e375900323ad82f2bacd1a531f34c35dccacdc41fd68ba74b56a6c42e78a8bcb0dcf1e84ae30a1b56e92ecb1126b0b2d30db4e8ad6dfabed81e3fc9fbeae2e13b3b065b68cb62ddc0263b367d6eddab46e59eb319f47dd8b78d6aeefadcc2efc07af78f2ad29e47e94151028224b9c35ce6f6c20df5c834de7321e3ee80adf9a8c104098be79079fd3576cd86383a593eabb01d2f3fec0f18a579a4db0671b02af1ee01ebaf367dd8df8d7435be0efbc36904be65c33e52ef38bdb847d8dd3d0f54fb4e1b0092f709e76e850879e713c08e1ae6e772e0f1efb5593d7db8409cf117bc6bc565973bd1171ee541c239b7e59e5e1e0775433f3a0f5c182c60026fe2d4a1bc9decac7ce33ef5658fcb78c4933c333b6fe85709ff6b2de3e7a1eead263f2fb89ff6ad21402aecf6e86e1f3a5d70bc243d169df71ec2740862d0cc39701fd78ce60d6a38d35ac7ab19762fc22cf28da951ff7909da4d9a82b882ef3856e0e768aca9ad8ddca5eb2dd873cc17d3814e938964e579f943a6c745a827c96abc036b9c9641d6a380acd9ce86db8ce35adc37f7afad38643a13593c1b7b9110f0d549271602d5be732663cedc84bae81734c0ee6b4e04fbd58bddf19717ebcc022ea984ae8e8871e99877ec64589dda99759676678cd1218458419766acd9b93c62f81f3dbc71cf4357f3aea4de9934db27e6a385179f9fbc82de7e509514d4823c6a4c70a3ad796f369ae20e236b788e5a65aabc626bd23cf62b3daa01b65f8e93ba3597cf9c32a682db9830173041f132c67b914cd72e0fe9bf761cb285cd2aaec67741a908643cb5382e185bebb14fb0be4993f1a567e0cce1a3447c72862dcf85b5ac12021fe95393fb460fcbcfa0bdbb48f573ba328b9e25bc538430d01fc5b1e25d4fba2cafab2124b79e8a86de5d3ec2b9148f53d051ef4429eeb36d8b9663d9b9170538a387ce8f6975ea74ddb9a09d277d27ce12f166d62dd4e9c48f53a9c8f65c73f761323d6bff3415f5aa74e47a2d945e9255e6723dc9e5aa6c4c19c8f535eaced3b5a17d90c64b8bd7615138db4147491551dded7c4ce7a850e117685c48f7e50979fd48232def5445c7691ef406f58f42bbca47abf7ace99e82e62a088fef9b151ed3d8f4728255d0775fa74373896794db8fd49cd60db2c32715d85cb652723d9a54e6e90af2a5a93a73e727d9083e633d131d43b35c61e24fa63c49f427178e85533b835ad7d4b5653d1060752b59a79274fabb6bacd0297c231dc9f50ef097ad3974b2de7b14da4ee1ba4c37973a06be3f826a0c680c256e09c9a7d5f534f6f9e8c8c7fa3ba9b765ec8186e3aa19376d17e81df3304d9f96a2e7742b3adbba1212f5a8f33e02388dca2088e6e82b7536f1c1a06a1bd45b29da05b7f39b09d03636813978717eb4c8cd61e0bc53a4f87a6fc1e93e99bd185b038ae247cca0b97a03faf4e126501e5b6aa8d8cf4466eff53
260d531fa77e3a4c740d010a5e5319d4398143e591f225af9ffd22b7c3b71675059b0bda2d2fcbc490eda5b92e25d8dfc07f0434b91fc6b2454b6d6a9d724b90ce1af74ba538fa770edc41a7a39f7a00a46e2e83e72ade97ea0b932cdfdd696d75f1718affcfd759d2665879251d5500e78462e0f9cddf6af1a7c4bf720ccb0b24fe7c0aa69c2980e85137f0c708134b76b30a9f7f63a2358b0a1af05fe4e34cd7b4d23f4a2592cc4bc036bc5a8b83beaa6e10ff3f2ec0c9e458798bbe5b3a5a5c10f5db8b878f7ba8fd72ed2c35fc4f16c384c74bff85329b3b52a3fe485ed41b9d5e02dba7c67345f537ba66d2c8e9a3b35ba7841e7641314205eca09f543a6af9dc90275240e959e76a19e38bcae6d8c9fb3f39d43f607678a2aba6cfce445bb17392e6dc785d3ca7006576d7e77c4b23e6da40ec81c7aa79eca5c4b70f1e9287f70024dd9fddd069e1dc11500ca986e77732167efd9ebd3356e433c22f92b61ed64a85019b3fbabd1dc653c9c640da730759fdf721f2dc9625e7e75c94b79f5a2b5b6e456cfee663cbecb77cdf24ea4aa3f3a11cef3699a3bacdf3c726bb5aa8df7368e32ad83b5857a652fee1a82e7f707190a0cd50f09fdd27743af9a7cd1e59d44b0abce8fe79b3fba442159fc9ba7367e79892d0b04badb71c1fe84efc1b1d1f9ce1599cbff481c4fae4ca2e410b677a6e1de83f7c68a6145a62c9f1cc114b79fbb5386572637b6a8d9d3dcce9ffecffbd047c7280e5e3376fc9d3dbfb5d8cd9f1d1159698a4c4fbcd4231d2f3da565ba13f6fdef4c787d0597e60ebadf72e1f63716b450a181bbd9a14b67eafbc996cd28a40c1ebf1f38ed8f2d309cb3231a04ec21f1c2d8cc4dac3e3811f9706cef5b37c725d8a3e3a4f50d5f6415becdfe533ba77b808b91eb39ad96f9b3e549008d870e475c2ba43c0f36e77768e80ba3ea70da471ea87516fd6cb2c8af722677bb26e0a79059e3ac014e93abf5709544deef0f4fb8698612fcfc6f233f4826461e4e6474797fde0e24a2b78a67554eac04b0e3fe73ee8dc2a78368effd84dd78e7fdd5a05773b465b787a78bdbaf111f461c75d3755ebc5dcf27ca80023c16aeea8ba38368d93e26956956aead074f924e33c6f0c1df169fe3c708555c62e8fef4355962bba7d2be838769f5028507ac9360613dc57341fef95172fa797dd4bcfad07dade7e0963e47d747e71be3037a027d8e2265627f722dae0cb5054cca013500506d3315b64b8a25387cb32d4cc6d8c11f51352fd74fe56306469bd1c6173d0e8064259c70894fa1823c0a0fac5c877f0f40709bcf1d05c03c4b2b44f9f9bd03fa7552c0fe7c069e93d2fdcb476ea66b3f0f86be5937e2e9eef3b874e29027454591fa3f45ae228a2779a36793e0f348f75eb66ee93cc95a9fc97f43a980abf6dce199e0536c9007ddd1fcb2d82ba13175ba3c84fccd5979b6f54b4e6f3f818f3cc38272fcbb6b70e61a7e471aef23737de46d0601e31edaa206e24ea6d74de490e0ccdeebe3b1b2bf07fd689733d1f27fe6aeece690022ca34012b08749aa3694f14d4b96cfd31fb043ab47df14178f3688ba7087dc3b3aae8453019605284795139352f2d8d7033fa7bed8f9a7259a301f21e03b610f13273a20f422741791e4d23e0e59710bb3d0497acb7f1279c3cdb8778593fdcff6a5e7e71f1d57a64a93f90d0c99e71d178e8445f5c3e8ae4aca3d27f7b67a79d9f9811240e4272f071112a3051c9fd289a4e3d89cd9747f52e1427346dd7955e439b01cdfa7da8050c3003232b08b2f0e5226bb5ef024799678bf4387c93fa35e987eedb8e3911040eba3517dd597ca6752bef5f9f6564bdd1787a2fb82422b379b8c517c1a303fbd8650ba992b07b08d2dd4b61c7e31cba26c876e8f48a8f1ea881dd26fa11d68f49c66da3e81e50aa3a969c16b3e8bb4cc325af761d2b2a6891405ed464ce6e03e39c39e754c29bf1e5cfc0d02d1662a19baf199d9dd3baa6a80a7c605e5494bdb3a0ac677e8b475d17b71041d17d0a48e8e01548ac647ce5cedff7ff4bae494308ee35ed21305b1fa5004f741f608f98fa809818a74c18ef7ba398aae1cf8741df32b174f38d1c8bb5e153418905f91048cf499799fcf170dc3ea231dadcb5e75efda57e03e35ec55dbe9a8ebee4117556f90d00b59ef2a32daad4cb58c812e92b3b94e589c7e04e0d6a13d5534889b5845a40fb36a57540b6be8b3580ef23ac711b84921d76909ee4afb046ce3d0613d4deb8172bd3d5b49495d08fb95ba41ebb88ad13cfabfbfdb1ac377984edf83f26648b8d1f9e46b3dc42f5a01ee9b9af48b8d4bac3d5c6e1b4cd7d1dfbab2c7be84417ba36e4a5e8ae3cb552a334dffdba8dbc838e0212d2d85fc765d1c3ce04893dd2cb5a8ee77cf42dac77901403aa7fba3279d6b674135ee5969160f9e4180d18e3b51c79b6ab57d8979c505d712c07a67624d4d67ce9958efcac8b0405f3f5c77f706776ff764c5eebd7171dc14f4a8f1a1507d1b38b7bae6a226ffa3ab0a72e558bcc20d9eb66755eac65f3aaf5e8b6a6147a85ba6f26a7f9d59693aaf58e32d6eb208c8c1fe5eae14438e97cf8283468f09e4b47c64d08d65760ecdc2043309c17931a0d043af695ec6c325007965ea00afc10a3a53d762d323e5597b9ec3e726bf479e4c38de2ef68bac763913076ef38cfe7f41919040ffccb4fe7f4a4fddd4854deca3507c4ef4bd596eb828e7c79a569ba5607861dcc2fe9b2ada6f53262856d7772389b8c97e289ba79ba00501b7555378fce5f22f2fd9d8cef234b461a365f4cff7f
24327ba8c1474e97c79dd37a247651c561017c1a94a2d169cf49e250868ea1e8aa2e34f8604dd28ffb2a55bdc88d6b6df0eade86858d35dbab01ab6ea29647d669e6591b79b799646dbd34411e1b6365698dc3a198383d3941fad15e87629dec5bd890c777b1ca26ba7696b1c3df43f150338ff23f0537be0e51e7551e7746fe58ab803b6f57d3a90ebc0fa61eee37a66bf48343ce9d3315f79dd38ba63fb27788423a8faef8ece5250b8ec6eaf8524f08160145cde30b68c9eb2162924140a507f93b1f18da2219b31eea7c5a08f52c17a216e0836bedbf27920af4223585851b9d87b70fe40afe8e3c2beb1550e20bd1aa118fc7cfeb5d6619f5aadfd2e9763a037f2ddd35e72eb26a13f49e7dab30efef666adf5b74c77cf6b8db9ac1069dc55c5619de40bba804a517650d03ea6bebf0446f480b6bbd0a60e0196b9af3c56f6bc6ab42dc7af14a0e5f49c840776046fe0d9c7aff711b85e9f7c385a7216a354cd44218cf265b75907a4594e2b271aea791e02cd425ef4f6526f3b79d24acfc62e348b9419b6b8f57bcfb18e50bcf7b6e97b800168fb6bb09bfdcce17e75782d79bcf2f733b79e3ee049f235eb8ed23f8e6f2f0230f89b83e61f78372520c19912fef73db4aa30fbc0c4ad72cff4f48a6183719e0d2dee57abdbf00966c3dea5e89e1babf604c19466f7053a64d1d207d1aa2e667f0d4708ef6e0fac2a0fee931a9cb0c8e5d0c7ef2f840bf588303f5c6767b975db6365b972e7a7846aa868ef5d23fb312c417a1f1f15e82c955988ee0b66b9566b957d499bd1ae7bd59a98aeecedc20b1c00c0fdfc59c9c036bc48f385a72d501b1e9f0708394a3fb2ce40b926a773681e8aaed12ff0e7e5782ab8a9511e33560514065a49c8c5e6b3b753e52c62ff3072dd7bdfdec252fe73fec6cb2f441bf87655313bc9dd3b9beb838d2343e968585775358c8060c94bf26a368585432501a4f29ad88e0fa41a1cbae8134add2f66383e90315c27165c02e8ba7253a632c5b09c4b5b958cce8837565ef37840e02806eb37411cc65ee339f7943c273d57b28fdb96fa38f0dc2f3497421be7d328b0b93db664db4e6e97edf3ff9e932f9340ac3e537e079bb5c4e8b7b27837f22a82b16679256a9a25fb841df41df3e5e29ed697615cea89576bec158846f1f72744f7d456f971d7e42dc26b4e0a566b2d434ad269bceebb69eeacb07638b9c095696f4f23b8fd4b7a64770172355933f773074a5cb4768e8a52a97fe083e05576c436bef5b54092f93f27624fbff3ed6adc7f6149d9f1a25cf13a196adffeea4ac3830aead058cd9a28cf420877f533a59e3e6f3c14bc7668eab579fbdf48dde7e1fa07b6688f6cd0eb416fb88bef8a9f277942b74fe6b45ddb1d2c8e522849b8e4ab81a5d1d78be9fd2f26dfa54ae1ed350cec1eb5a12bcb373d384458b56a6c2a734f08f5590c13cb7e1cce2559cd44aaa45c4ff939105b72dbf76778c7e78a75c820d27a574bdbca391077496838cea8e7e8f977571312016f5037aa44ab1da30cecfbdf48de64e085f16b332769859e16c15ee7413b30dd6c9fa8dea49ea5b7aba61496debaaae5ced240ce5c045bceb9da5bbc5e70f7d99e47c38c29493d6f1c259b18470b3c71c31e516ac0ee9d24b42ade6c309aa2a15be8aa1f4c68f581b9fb7c5dab25264a3f0e033c844310eb3ee82de566fc4b88679e9635f45b37b3ed0e9bc82661b29d7ab98617a6d2654ee6294dee3bbd47c1de42041034c2706403fe53c9b8c43b9b25b75d72f8b5a0caa787ee17292f2c174a2aa062163b8ce0d3aa46cd93c19dfdc2d0be27bb5adc7ec98390775bc98e2281a6485b0291f6f574b413b8dc6fd0151c2fc784145e2f8a154e1c6ecca5f45a7f67682374db8a3ae82c8a10891b411b823a8b9476007d3226f3e4e1b882fd9635cb69a8fd392f4ef5cb69a32964da14a9206c3196896ab56728d64a5f4b7c42387e98bf282bf7c1c21aac9a4a58d94a183039003b74b1a1249efa5ab1d49f927a50bda1342038cde358306f72611b05c03271817d5e215155b562fb54670977de63a15fb642b94148f74c37515c8ab1ee10168fbd2c524c77d9ad2cee878ef757ee0ebaa98299c6bb5a72aed16b4c431771cd323998b682afdaafdbd40f6315bc3fbc6d0765e02a16ee32ddc1affad9f362c1c3e965d1a11edbec93205df7e08707a6f67bd2276d28af1d35d37a8b58e97b2a9cb0ed497849702825e948d26237182ee58865236db65fa59ef1a9e6682e944746f87d599cd9cc0f5eade5334c26db006e15bb2ae2371bf1a2a70bf9e79a2d07c38a755fa6994e4b59fc7bfd6284b2c8809bedcb2fd0891b445a24e0df39e16ca93f26de6e00de3bfed3bef9d95ea9a8ffbffe0f0534c96e72a061ae81d81c805f8da41c4d9859ac307c8dc5e0c522e0aab2693b4e129d3b124b3256f3f9972f3b09ff6a07c378e11db3c7e0d2d5a05f9c77c577089964fc58086b35b98715344375f17d1827f60afd1a9a2141607d379f99b803e301c26a3ee812f367ba7af5b9dd9d3edbb6775bea3f4cde7274e2afe38561fed2892a91ebdf7417f8f3a09ae02d7ccecfeee129d5f55bde1336bc66e7e3c326e69f0431a411d11348004de9995e3abcbc4c314f2a5775050d7520be327f29d909de848073aedafa8d259179cc0d8cf75872f9c056963d2b4a9730bddd66e90b091978184782bb0de3072c799d656d8db3fed07bbf3a2057ab0373c2d53a140f25a72a2ba6679aca6184bcfffc6ef0e926479d2be8c60f9cd5ef1adf9a3ab7fbaf3309ffb54aebf7d
2E28b75bec4d8e21965b0f44b6e7e3f2828f216e8c771dfedc8b91b04a4a0f0c1d8f3c4f5989bcca42d82549d16de24a6bbba94da6b174aab47f1cbd275dd875483f0b37a935635969ae279dfafe0cca36fc1bb179cc567f1f0c6cf05ca7e1262dceeff847603a65c0ba8daca2d69bf13b454ba4414e59a87fccfd5f38f29d44645f9dcc35d7e7355b7861ce560ba615a3b9b2801833cd3d3ed5bde1fae88f20037306e7a759252b91eb8bced9bc032b2ac4e1a887c0ca5e1d70ba2cca9327014785cb92f5763fbb4aa2bc53b48ee3f2b15b90518291730fd229b9f33c5b6e1ee6c8e80956f7fdc19193e7c19f478effbede962c2bbd0e82c9d2adf1f908b37205760345609b53b3cffc74d296d883a15269acb087389f14e9fad93d1e3b46e9b96b3228cae83aeebc69be980a2cedf33dc3b6a3e21adab8b246aa0de98c47ca4b959e92ccc2734f2e74754b23c0317025f5723acecd1e92cc8b27d7ed1425e7e14b256949ec7c6baa14b64d87a5b0e6d156ded588986b958f9f19f90e6b8296c25a8a9493e96d25055e3e4dd140e82bfc30def01184f1cfdaaa79755dc77086ffcc33c13060d1ea8b3d95a94b1290e869ea52da75f09fb2ce3d45f28a3c4680a224ace6862c5e7f93478c1937a116dfeb6ac51e3b1840cfb478caadf63c6894baef0b078dd7dcb4d71ab54033cb36cb8fe36fea3cc512abd1db29d328d4e9a4f1a2d24678c78d4cf12b5c99e334af06324b478c6ee3a9b7533f2e0b897e0d09e39e9dff0303dff8a6eaeffa1032328127e6a45e7aa3b424b906ce05d4511af48a633bc94bbda84eb5fda25768568f586ba8b5c78c65c13520ae316c9cf18ad1ea47476a2c33438fc1e7bd937f68fe68481b7878c547c0e7932f692e39e7103a029d11a4707560c2ea8ad1f290bff568f1e658d0679f8e375021625cd588ad1ea53b1544aaefe2525a4868eae8e1e3c6b29a071f3d4c034a09acb70b3bcc7678c2f6c62488943712475529b1747a3fb729e2b4c2b4ad012b83ad1e8fe8ab1f2490b1f65792ed2869f15943393ce3f0c17ef965e0f23fdcfd0539bcdde5d02c1918779cee018ad1f00c5ace60f168f85f619b8a3f05d84e0359cac56aa78268aaa1878d118e3199ee6fc865cc4ad61b0cfe0125ced855d68b25be7dee9b1a1e2ebd1cc92e8f5475d8c9326e6c30c568f17d6a1b787805cca337e34d9ea5cacbce6d7e822e74e2e8cba827c94900f58e0aba96c4b77bb79e84d5bfb80718c7cf5d5c03bafb87967929afd736b1ce1d8307292183bf0211046279959b231868f54285b1b078c5aa081af8a2cc94672322b478de53790dae790fb9aa09276cf0fa8c6a870e0ad1432d4c958920297a93b66816be7a50d6c949332450642b478f17f80a9e7b8856bb27c7a5dbcab3ec105bb2fadd2906b72b47a749f0ffb3c6fcb70ad1ac138c3561b5168c581097e956b5729c666f3e57be62fcff5a3ca3cbd0d7fd914a3f6ba1777398418c3cfb8065983825e05ebc3710cf130140a728f03ab8b3cb3222051c2f335f9e1bb8f55c83e2ac446b2eeb2f47f91acf78a8173d357969ab487041ea747fb5172c0a896d7608f0fa1c9a8c3c9fc3cc9fe2c14717fff993a22cce610a5d98ee281b05604b18eacbe1acd3a79c4eb494791335e234d4263543b8b09297583ef257de2370939293d451b795bb71c18a563dfdfad6594f28c8144e6f2e6ef4564949777b92e16b693d86f4fc213c40c7f5c3f0be3e2ba488f4b16be3f9d57c0e6a8906f3bd45ca70e2b795fa5c8af32a6606a1ea74e1d47a1f90010a5f7fd7dbe10d9f217bdda1e6bb2a8d6febb878a898ed001a7afb8fe4968b7d7d38a362c52749707dd8b966f0ab5f23ca0a831e2cae6f4b74b4e29b894f23d21afefd2bf16d35d0b3be94ad5229b95bedc7925a1adec19aca26e5c77a2aeb5d00a29848f1ab777c963b9edabdc8554369a178b964b1d3ab99fc3e3b939e8b314732f82d96b5e7806ddc4a179a4846ade36a600152c9f54f069a8f02529f3d24daf64cb10a5ffe4b78215de27576fa4fb554fe57bbb342301ea6a0f83ee8b5ed0ec92e5b07356034755d50f1781b736833b3834e75679cf5599d79b668c9c59f6dd9dede7eab575766f48da59884066bab6204a34861c92bffd96aff525acaf76decae792f95231f55797ffa8c722dd7a69bbc8d373fc7903569396e687579b64ed14c9413022a272bd555deb0ec0908f37c3e73fb34e34c3be4d0ee4ba3c57c0f5599cc7e6c29fe6f2b0c5c7001a83cb16026a76321761e95b54c35c6ddfbe8fac2f403c0cf281f23ce51e6a19e68b788cbd14fb9bc91e056dd0017b744461aae9e79aaeb7c1a93638c8100e03f6906601958b97c47db2fb18eb3de1fd51923618d588b45121d7bd2ca57295d9750d80a4124601180a01b0b04243a20c5105cd08e6631265b5c8baee90cb162f0b8b87295913d707e1ab58a3908ad710bb6eb41e7885a0b42568b20382e14b4f2a40b87f0f8c184e540d0b5ce8cd0b29e8c0ab7a6b9bc133f5bf1a63229a2624ca0e7593e87d33d594fe9c9560d63f00d0461ac26b4a2581e18ffc6f6936fdd18cd191c8dc686f1c23681c53ce1ed28eed388a85f25c0a103282f488681840c13f68024cce69bc0ea2fe2fc30ff9fd162ba80fee355e1707bd5a3e3a47ffd1e1d232071eb61a5e3c88190dfb8c99687bab447e487506da2e1e5dc786d6982a1ea0f41837961cb3800dffba084408f44a48078c93475a142a1ff19f81e87cae2b583d804654566679d78bf6de4bbac35c9d486e3ff6951168cba250fc392
258a697f7ac516b531af3723539bac5aeb8c660f4e05c95cfcb4b4b3881d2e16766337f9fa092df5d09845d021236116d3a592e465c0e7d247a4550bc31b0a68d6488d24e9f8f8d1addccec01aafbdec0c37e3022917edc46ef173854e55fa7ba95a1d6d27d23575f53b66c4740e0b75bf815bf78107a11236522d10ba7db888461740a3fb1b26d356a3e7e47a3c257aa699fee1088ed7699bd9b9a684fcdef96e690709bf39d30fe31b89830f16b1db3526a03b97dd3309350a4170f5d1080865a969af3d6fac236020a23e984e206ed0a518fe9fc68e054e010cfc71dd89e7899082bff3a077410fb03e9bee05ad01f0199c26b27364be36591acabc35ce18d191d4e31bca8fd2d7216302af81c9a5d217f6c92de8cbb85462dab77c3b2747f98ced5fbe6a0e3853040ea866bc375d7d0d2d733424ba9ceffeff4e5cd79771597131e17b2da9a09a03d0cff209ecd6441093679f3f47cb2ef5fb2e5abd347f9ad2926aaeaab2d45ecde6ee6a1eebca18b5bc324d19778df82db43fbca01d04279a3a2a8377760fa1c3d17ef4032a7ce28eb37ace58c3f77f910781fe281da72ca8e631a6058b24e88be0ac59209a0ade689fdc0447fb25bab6969c73f6e3477f31cb842f47dbe5c556e783cab2291e5c044634787f4f967bf7d9392299e5bfb4f2cdeabebe162d5c8f51e95c8c19d1c61a1b1c51b84ef39cd2c23d53f491eac15c4457de3b69eedce82cea55fbac2d3ed82306bfcd2ea2fd615b8dee0dea4b3e0a9632c114d0244faecd069d1028c190a3cea99355d38f357a1e3df425ca9a363e5f9e9792a668be09d3707434cebebb91b8466aa5044187f535a1a9fc40d46f866343c9f1ffddc6fefaffcfe7fe3ff7ffc7ff3f7cbffefcfe7fef9effbfcfefd79d7354306e57b91751cbedfcb86b7db75ac9422f25b725bdb9d65bb8379aa12fa84d8e17ea8e58d52ea41cfbfa0ded0bf661b7a6b97b4b063db5691b5465be96e3eca4502f5e6ebb2db6dd859ab14543a11e5f58489b002023ad7cea818728e03e81c85bbcf1f0f5a962ddacaa3d4dd5acddd52a046705ed1c79563467680effc5b9abf5c26e05f760a986060ead8f721548eab6f59977a6d07fbbacb277ea19f08be30bc732be9b6991ed770bbcef72c0d6fd248cc140bb4901f53e13ab3c406d5aae9ee38e89ef64c8b44e070c13495653d9032c5abf52962e65e3c1d73d41a57aa00896935811616106cd896b35e5edc5322497d6dcbdd215946ea6542024b502673862f4306f13ffa3598515e2cc62a4d7d1db815cf9d366bcb64f1a850a95540d60c8c092a9394c8ff5cbc00f37c56841da20a1dc07fd9351cb34f2d55aaf3c7f6a400eb3c309fc24dfe6733930e65c8ddd51e0e95d57b7eac6f217a3eed52315b655b9b8e9c26335cbf5616e0f13fe5ebfe408c80a83756035bedc54e807567645ecdd739c6152f30af9c99a4ad4faaa195d6b529fb5b29d91a690f4cf3414c11c00a7c3206e104d957cdc6ff6d8a5d9b4b00305aa6a568d865b0fc262c193b4fdf41679a9569d9a2b49d3c0399e590ac736dda4ba086eb762ac751e161d0bea2ac25ed9dc2bfe7f2687cb846247e7b35b4b3eafac824b0779e3fcc2faa39d93655f47d59ef6d50296f1ac513287ceec6f3f72a84e4e840dd2748aaba57074a176ac25ca05e4344dca1393a95e9df56549c9d75f449d735597a3019f3d53151bc9d745d9aca7a7f5ccd1faf16ca0b95a684ef3cd5cb7e2e5952c372ba4cc256b2b49dcca95a16c695aee05cbd87e55e9d395a4b69eacc5eb615272b4684b49271fd2a0e5072b49076e9d56da8214ad25538e0e56fce526931cad08374f8181568395a4b6548ea9a6a4cad7050bbd30932749a9cd5a0e49a76938bd396841d2651a7766e57a8796aedafadd780c92f51f5e51adbb7f7631d8a1a07f6af3669bebdbf4dfbef62ae0744819f6a2076765de66e839bc5877895fd4ef841bcb99f0ded1157bae400c5e875d63c20b1a990bc4d739aafe187fab907b59739a1aa2216f5245cdf98808bf31ef158f7954e9d61a07f582ba2cb2c3de88feefa81754057f436abf6c84a8bcd0e96a8cbccf55df89db7e2a1ad9029404fd54711e1b0bdfc912e4092a657b3edaa263a0ba01b05ff02c9a17f6f83b56cf4c41bf250685f0d5d1a6d1d6c53fbda894d996abfa566d159b03810c0df9e0735b844def140f5094e10e731fedd88aaa27f4dffa8e16ce9cfc2c37acb6af26d372be74937f61fe47cd1d1a17a6f45efb582decbb2c0644ddb5ce69236e0fae19dc2143ef8fce77e227e7a59a73eedd7c8586ef1d392aef365be3aed29abb35396371035d874189b767dab61d1cc81a015f43d778dd9e99f3c4d6e5dc709f31291134b0dbcbc91d60e464205e2d621a715bc32cdef67f28bcd7fb9eca8253eae9b9fb8e102f02d6d366b7616a8c772d9afccc5e3b3eec3313c19597591e6a61201c0b967fafc640bed5993cd91480fce8072308df68ffb63e64bcc5849c5a4a834083d5327ebeaa849a97e2841b914f8cdfe44989629b8bcf4e45916f196c2e0cd0a3f040ca8c4eb86c45c58989df591c1727e1c5f0b20fe893e4305bec81dad619ebf93de08da79af41b8b065a18b77211aac5227fd1ed921cd5ba074560bd99eff050e69d3f17e7af0303c51df50aad65c6bb0da2fa77c9c6c4dde14a15f8f4d7fbc8e94aaff2f21afe03cca52a19618854c4ab9cb738f9897676f9c98d1fe93a9b7fceebb159a6f434dd0998df4dd0005ffde140666477ae8a1ec2a45cd59f25818ff7ec7873072b98306287e39387
2B0ea27e43a0e9fb9a45a9aabe3086db8e86a5631131936fa65c4d79f336d0972725c414603a696db883c8b76219cb4f2a37016151e27f09aa5da53557bf03e7754b32750aefd929ec62b3f16fed29ed74fce0999e0fad1fa466cf02caa9fccfa1988564b3a723192567e7cd7cc6f9c7a3254d5be23a3ebcd76ef19febcec0e72aeeeeacfdf994d83d672e49af1b6f57ae3d009eb415e43cf8cbe0a8183215d18f9075746674933b0fe489e7a60af76dede6dbd4bf2354a5f8b271d3318f4073ed565ba5b795077b63a0efee3a24028c52f4dbd1acf48b9ab3fbd136ded5d9b7ace6dbd16a612a55421726ab23e783a7b9b899cd553c90f33599cd2fe785c734bf518a0bfac3b5173b91adcd2abac8c7f27c93b2f84b8f7803aabf13f83c350d29ad7bec984a71bb960f5b9f47b4a7bb14f9c139f71f5a3f492dde0695b2db4c7a87ac62926ca4ddb53d0b7799f72637f917254956a861e719fa9b9bbd67e5f4ce1e3985a2657cce4cc2faf1a6d4030a8e39a775e0b0a152be1ce7ac7e6ea6a319929761f2e61ea4de64d56e7d6e9dbe73662f3ff594b2d7f4c62b163d5c3834f6c9d1c590129469c48dcfd721c82d3d467bca2a6b685ef2da2e4d6d1d5b4f7bff1c8c4d331ad0623faeaa29699197d6f12432faa4e31b446ba2c862f3e2c6f8dbb5957ad038067ba48bc15ab857969f75bda66f54a4fc05b75c0cd4dfabdefcffb24edfd40784ebde30cafd504693b876127f9f92d9f89f9e647944fad86761e123349996cc271fd9583f69d632417a1bd4a93f7061b87dadded5f9e0ed2dc7ecac1550606b72ec19973bb3bccaf90c4136e2d20a6961dbc7b7d9942ecb2efc3534d43e0beafcff6636e5de5f067d9097e35e6bb1cdf935d9386d92fe400b9bd571d1b09744542f6e3f1e0f09f081727a5625edf94d76074e23a8910bcabb1066655dd55cd2a50cacf717670a7673854b423358a66b6176abaa9a9659bb57bc3909e50e65efe08644cb8cfd8adf4909df9c9ef3e9be032ce54e4f8082c3582aec60eabcb4348c7665abd2dad95dd9776f4e9710ab8a771bfbf5aabbb9df4524426e83a9058260e9e9e9da1b7017c257dbb1b4ab6018c058969cbee1a93c791641badd8273da71e0a0fd37ed181684ff17834cf74e67eaf80e618a2e372f26cb623e8effaf935e47b51d5f48baf01e4f2f426fe272bc357fd3d23823ea0f6f397d897b16ecc2700c1591846042d120b9d3d7165d24108df4e104212a12186ced155569bb8430ae56fce8c47ba907dc65fbfe7b126b55a5da61a4b8b394ce1ce963dbe7c3b0b69d793bcbc319ee2d57339601e2b3afebbae81a8de99ba49413bae5d6c0bac5967f3e7ef2e6d4cc12574a41f2c6b77207734a662656c9d2abfd39dbf75843bc374db6e1dfda3ed016686a11d11ad86c69e8ef161c29717c07d92d6545593347bf72b04e6cc995f32c2f52a8fe9b683c2d92cdb2fc5770f62383abf96e681bb30755a00ab3192266def3a2ea3b0143538c3b0dadd5a6219b0ffe210503b0b69564b9594e53e45c85f20667bb140d1dce2bc84ef3cde7e17191d36714ec3eee57fbe979299e8aecd4a771eefaf8e5bf26a52d3258f953a9c9e065cf8e0effd1690dade877e4702ef623ccf61cfd8cd94fcb8fb0e9dde962b2f3c37196cf65723d7a98734869d3665cb16267d248fba6f236299b3582fd2ceac64ddce63af7c959ce60162b495cb7827ab933e77ce3ed1634b24aa1b4ec2736b4717a87fe585ae5b8726e8946496ae75ca139203d84edc0272ca983cdadf6052f01df33f971378172e1538533018e238ef3e050dd75e78a2760d88b028b323c7bd40323a2af256214668e16d1f4c3ef4c8acc08620bf95a47e67f363119f803b20e1d16b8de41ddb9e15c385168f4c6c18471e7b02a1d0ec7d05855b793d38daca9c2fbacacefc21f969d14391ae59f18a523eb8cf592493f8c8a978420a52f9030e40e5b6546171a7a89d2a063c0dd28c12abfab42cb1a6e92a05ee4101e855474cef42519a203e1380d422c59fc2fb972d0ddef44abb89ca66e06b6a7ad9e69b27eac702e9535fe838ebd42928452ec66fef904d049c4491c3f8516fd85d079e4591f52040eaa96331253e53cad9d7b6c4fba5309b8673879e3d0d350727d7a941fd7a547ab3c8413c0231e95031a3a5a8d2970f58ce4a9046fdf4d1d8c6dd67e0b911aa1c1e5ad7a9f0373879ddb40a6aed3bd170fcacb9ca8419f64fe0caee9b7b4b81cac534cb363844705fef28f8f844cb768365c2e18bde7f681758c31c2f7e89348bed16768f68c3db134d532085a4fe8074ac4d2f704a2e07c1eaf4b8e73e3590de957db0c5a557b47948053d1f61808c7f87a1ab2ca67ba0580aac7c4e6a968d9a5b62389eba7ed0cb92dbf0fe269eedc5e5d50864d79f72b4ebcb2c791ed874e641d2e1ed3677afb5a634837675ede47b7b688f03351e6263feb0b141163f0acbf42254d48ab4862ec3ca1ff7be8eaa1972449b046525c10f03100083f5d15d9c6b9ad44efda829e9f767819fc4d53f8830692001eeff09f2c003566ccb19d67fc7ee1c277d5b99ea9cded522c108e063faaf48cab7c0fe57cad99a883dad9a65663f856531d1a57cd871ed9034c9b992bca51f9eb0a579bb2ffa263e9c991f4ac2cff926884a74f5d7a40f5a30980e315e307bf1ec69ecf18cd5fd3be014ae322d7c1fac05275ccd06177a84f5769662cb2ba92795a7ab81bff97c271182b314513000311cb8409fe7f06eba71ca772071a2b68645395bfde393a25c52762e57ce927d2cc7d4a385997
2C989f3e5effac3a9bb1683c815f339a3d7d436b89a144401b8ce152498d391a66001734f59f7f4e8d01a78e1ccc16c34f83db1d1834d770387561034d6bfddd0769b60636924f4a4b923b3365c6611ead96a723dba38847a57a28592161848bbc4026d2d711da467b63bcc272daf99ed45ac610136535f08976d4d1ed8bcb5f1aafea8c1388cd74ce2872364d5209a3dafe862175718b5c3c92b8799df5cf3dd21d4138c9014e37416c137f68277dca4ef6a13147dc609c4f4ec543cee6539063b777b7ad2cad4f444d4758ac72e95da3f35a6e2f2433dbd91dc79b912f69629b62591bcdb8f2d90b368ad8b5c4d52e47532b406e542f55e1dc3c9744aab89d8443a96b1f70f2ac3f2210f22f4459e64b6e679a2b84195c270ca4ea9774caf782c2ff1f85c2ffb89b8eee70a9eabf4f1cad7bd8343c6d23f23b46c45c062aa56591ec191853bbbb086f952342bf796895d734958bd58968aaeee9af6b51d0e98f79ad8b562c661ae970a792c26e958622c5ed9c598f124d1102931e236d024b69c7405e7f67729c73714ebdf1ed84dc059b94670d68ad4ca690c1e5c3a9490c9225e514b22b300b9ed4d900716e894c1017358a9bd43094b80e47f345ddd5b0698e232a2b2f31d026bc811e3c7f547e9ecaa618159c3eb865bf88488434399fa0f216e3f39d81ed986b736cbbf0adbdb8ddbbb64135f10305efb8ad7c043f9db2aa8e741d2547e16761ec5c0ab6970707799e3e536f57964dd718cbe147e3359902aeb6be2c5c6b37083d45aff6a2e93a8152d1fac19e1f5b7ce2d40e893f7b8251ec609342bffc94898468ea4f386e338593479e470767e8fce15b234753ec5d64cc20ba9b744fab3a20a52f112d7ad54f89bc265d63bc14e5ee40c0c13c965a337ad4633450b45eef69b9a9a2fd81245cdc4754ba89196ff43971ff422319d4f81f9f47b209da5ce55bab5a3d178dd388ce3f428810ab9432e5606e2ef63857232c74e8496b852bfc2e31ad6b82306bb43f822fdae8e40d6b5d198b2781a1e986251150effdcadbe17c20542f700daaacbe1b425ae17c2345ad77f5952b470dd6b822565affbe00bcd80af8b2d7050056563534399e2adc8676ed944446efe06ef632d69e35b0c65feb76aac0947bd798dbd2f90c67e55649a0e903cf4891c3ee92181ab572aa1ce5561e16796dc09910b2de45af85b176759fc7efff0c6c6ff25769fe5682d563fe653ab520f21dbd7cdcc0796c5356cffc8665d023195687b8f69557c9cb40ff47e6ffd0279ee005137bb771add49b376bc0871a48de72b885f15b3f99374990df5e14ac0b0de32ad2d018e8b7deec6a2f43e0aacb87b14e727e1ae506f1d065f68e516139e05def1f62f72e17cb2d99a8dd22cfa3f584a3e796545f7415933b1571753ee359496cf59520a8ff3ecaadb5b00e195094a9026e5fe6ff2216e89f4ef19f63de604e944f92d45eead69ad131b866be9e95cd90615d5dc74ba4a75a48b5b8424d6ecad86c0e2031316411edb9e388e3f7b840c55de752977389fabf5b4fd6a264bb1b9cd6fd1345067f0d1e7ad5335e937e6d18e00cd7e06e09cf5b8b5df3cb09f3e966bbc59bd7102b8e63b8d6666c0573bb244387726d24f8ceb28cb79f94a4b935209256a4db35ad37862c4a649b1517fa5c169ad974d8cf51856056f381afb1265b68e114932f63b06a0ad7ba855b1649d635a7ff2bdac7300d6f27cdab6bd652efdf73a23a61807a8dd6b68565640dbaac65273d118451f8ea21d3e3cb391dee2d9ff1c557122000b7945f239afe5c2b6b2d3256d6fb4b9f388f5a76dc82174d69e5b9b6b4361090f08ee138bec5627a8e389e52e0d1dad527741c0ccf975d2fe8d1397e9e7ba1ac794e31b07a1a246ba87d79ad8e94cbd43ba9f497abe925925eba439d35f8ace728ae30a68d29d8f782285bd0051ddaeb72744424a8822a4de89505402a4dfceece57708410dabda40c7a138f80d1c360285dea3a5664dfea1b48bd59da71174659678d7f7a4dc1bffbafac3278780fb9828b7ded2cd33e8dfc6c3f9c6b9d3b46bd3995f092d715085eba8ac1a9df4c4a30d773e9f02cfc0df9d75aedf610d31421cf6b95695f864ac81e5ca87570cbfb8de3e17ce938a8b740bf8b1d256652f909136a5d7ffc298a306daecf4034da974f3d54ef1e52e910a44a4bd69b6f7c3da6ff8c1c77bffcfdebd3184dc1759e1c367335c94382446f58af6e0659a24ae949e84b6788148bf60555380fd21dbf4baafe1461ae2de00150483af1ce96b4d1f79af6d51d85f7b5b2ff5c6134f5ce2aff061841860474abc2d955c9e8b904317f4a7e7e5758028d84d73b92676de12620a599a348399c821a96ec635e5355ef341819247699556ba13ade00d2d1f96fc795dd8d0b695dd80634e2ff8a8ed3e131f093aba4c1379f762879a7369b8034e64c14f8b54b25b30342978ba1c10e5d0f4df4de176770c32ae54fe22f5c0ad3061e7d2a777a8e0757db03ffb734d9216363fbb8cae50a5e88f6f2fe0731fb01ba650a62707473646e6d616572646e650a0a6a626f203020310a6a626f2f0a3c3c65707954624f2f206d74536a204e2f0a462f0a33747372690a3531206c69462f20726574616c462f6544657465646f63654c2f0a6874676e333731200a3e3e0a657274730a0d6d618f659c7830830acbf9f745108e05fb8aa41581f545c11550713bac41a0883411ec14c4a6bb1137dfcee06aea0f187b9911787c2e58114402262a3092da1b0f31235e518e6ecd40327cd563b77194025e323967cd3628f8aaf74107c4
2Baa42c95e85ffde05c4ae2d0543fc7faae54f130c4135d68e8f8e87186271706b26c5ade3e537aadfb252a3b6968d0a7f3500bcaa72a0d76239e99d319d9673b3572652f587e64c6df08ebad03e802e0b6e650a43727473640a6d61656f646e65360a6a626f2030203c0a6a62542f0a3c206570796a624f2f0a6d745333204e2f69462f0a207473722f0a3531746c69462f20726574616c46636544650a65646f6e654c2f206874670a323532730a3e3e61657274780a0d6dbb92b59c0c30c36e057d774520e834b72ec3d44ae3ad0f0c041028a5460c82d9a259142dfe8671c2e94aa87d0ed4c9635cf329140790caead41c0a84d106ad60d36da2341c53d72a8261afcf3df55fa6ae8851a28735f443c1c57ae5de4446b52e1c31a2c3310defeb1c4b859f5cf73c253ea5bffd8cf58eaff736ce91e65f5acc990ccad3f7395075f9951356ce93e660fe3ccc9537cbfed6f86fecbfa2fb25f215bbe91cc30a695fbff8ffb1e21ee77700e61b554683dd32adad618f7f1f7c58b8817ac712f90aac6b446f522782d8179485f40f78fdb25bc3d72078f4f13884a0ce3ea939c4dcc3e7c851e19d82787d81b60783005d120ae983ae73646e65616572746e650a6d6a626f642030310a626f20303c3c0a6a79542f0a2f2065706665525820572f0a2031205b20312032532f0a5d20657a692f0a31315b2044494536373c36303234303134423431453230373832323238333430384630363341373c3e46323445363442363045323031383234313833303738463232334134303e463036522f0a5d20746f6f20302033492f0a52206f666e20302038462f0a5265746c69462f20726574616c6f6365442f0a6564676e654c342068743e3e0a337274730a0d6d6165639c780a6060606060612a4c610460626266204660641064f2076e4c281840d998c4c6c6000192f24a036d38646e650a65727473650a6d61626f646e74730a6a787472610a6665723338353225250a330a464f45000000000000000046445025342e312dff250a0d0dffffff3020350a6a626f200a3c3c0a6e654c2f2068746731313532462f0a3365746c69462f20726574616c6f6365443e3e65647274730a0d6d6165749c780a6daecdbd38240f294fd8a7cf87f8b5709ead4969ce0deab7b3707ba0d7e93d06111d8def57df3af67126e94a6d8166f0ff03018cf3fe7fe37fcffc7fe53fd7fef3ff7cf305fe7f7fcffebffccf3f9e7fc07ffcf8fdffefffecfe7b4ff7c67ecfa9ff7fdf05efe04bff517c7562c386336fc7fbe8a52cb1fa3e3d9fda5c04ff3f3d2c5546ddab2c3f39ac8cb22d3646ec067d2cdd1601d181f3f8c2abda0350df4ea7e25e74dc6256b7c4a8192eefc9bcbede1acb7a5b6062adcf77d9d2b72952813a2f7fbfe3fd5a850b409aa3e9be7ce3535bd282f9fe7fe6b6e6c6377ab59f1bda9be395f85ad0c82ffacdca8adbda2d0c56f85b1b26ffdcad2dfebe1d79ef922d5469c92e441b690d6d4bf8daa256efe45593e7ff9f3fe7b379e2b2f7faa5dcf0fee7b5997d8f4df7f399c69d3fe8f0597595d0c345eff4df6d976dbedd6d7d8c2e6da973f67f1adbad8cfb9e5cbbd21ba58fb19cb7460bf47efbd3758396d92fe987ce59c6f6da6e4fd6d12fda3fd2fa1571eae9be7e60e4b4b5daca8dfd61fd3fb7e2c3fb05e917c52fe6f4df033e317b8773ba8d78a29f7f1e56efa42fda4fc55437c49be7af374dca475502d227966f0d3fd3d28b4d361548681a3222a77b4dc6b275289c0bd37ef76e4df62a1d11b5aaec6f64eae85a0e82752990b87f78a97f507f78a98b92a3bc2fef9d0cf9d2ef9d8d835461ce3669b8ab2288c868040fdfc65e112386ba15fdfbaf850d5970483d4a85ef673f43656213a629a8ca435a9de8f38a635b5ba6678f666d72e9beed5c320ae9661cdfdba082117f58fbf88994389b7286f275856457269beef98875f176a3248b5a1fc8922fcd06da3fad94d920350dff88d1b9c9e9fb0db7f790dd1f67fd40a59a68172423d04a64e80b130502ba2502d02669450bf6bdb68c14d98c754dcaec7861b48ad93ebfb3522ceda65969bb9aab23ea5592577b48288c80dcd6189746c12a93f04cd634cde7c7b408f5d3cd9dba0f20919d565d011b05fd6cd6ef06a01804379d9ddbecca0d5ade655c06cf8d079b66ce4c3fb59b7ea148f71c07d380807c634253bd92ce7e7d2c0a789247d9d9b329ba9dc14ef923019668060f399b5fd47ec1d13335a5db292a0fc0be992f3beb2f729186f6463ec8c6d015989e3525806c14ca8691c39bb66fae2a6870c6661885f6d64dd18a553469140bf87f685f7766ab5efc3bebf385fa22c87d8056f5deab2bb836d91d0fb498735423fcfe6ad6e3224eaf70737c7f54d476e5dac4764d7b611cdf466262582fc1ef2af0c5753753ccea0351bff788e52a3cfc4e9619bd68101cf688cfed4dfd592ed1bab22e4af4dc97a057c579ecd5e54e6abb87b13d77412ce285c1c35ba42e43a5fee73eeb9fb51f1f6d40949ffa94171e90d1276f4b548d8fcfc25e3fc7da0862ba52bf0efc078ac312dd95acac2a59669d559bed9396d11a489c911fbf8af71717a3bb898656940faadcc6f049e39c88c6690fa1a625f58373e075e7643e2aa7d8aac6d918fc55e0657e506c6e5c0ef685fb76977769f5d4ab5be9575fc189acfd4ecdd2aed9c59a6f5a496f4feec3acc0c6ff7749e862ee1c150a8d9a138f9c0d50fe7e53cf7abfb0211c27cf5bac812fa22397f7f270633c0dd740b722f78d1e7258161818130cbb9a6ef2f475
2F929ddbda340682b74be11975ce3d067e7f21c1cb05ff9bf5137dec36766fbff6867eaff1d372c27c229a523e8318b90f34b4e6be82b331c695dbbe03d8c34de4a19c3921dfc5e84fe4a3fb40d84772b1f03741bd6802e372c2d937c60d117cb2c63988dcb06f35a1b0192b3e78e73851615eeec181997ec0766319965495746ed37e24ab67fb1a4c07a1d8caf0bafa9ccb1fefe94b15f671a83bbcbbd120624eb62dba3616a6c68d22d26afc4f21955f506032a8493b91c0a38b54ea2a7dbcdbd1b197c63c4dbf2ffe359794ba72fcc40137e660a6935961ce6edc041f30a0c422059418cdc74a1f0250a8c084a6b74c2f050a709b9f41dd7f32fb0fcd65e472df224b12f62f91746f942ba5d29ebcb3dd1a23e138e07e4c6c17f12c550de580c26cd0ece426a9921c78d5a9c034d46aa1d91a56a66d217a8236e954025b9a6ae5b640b061038f799d06fc4cc3b866f5eccb61f178c5dbd38850a2f563de3ca137953b170d74509db449923f2f96a4dfe806ce7983f7fb38227383cb0951274ff80668b9bb5e46f54d31d399b326931fe550f4df74592e7e9c5689fbefd934c1903a3e0880c67ff347dcb2cacb25640fb38e4e84e3d3251baea3931e3698d5150a729aa26007007fd30a5c693ae2a2628dedc84cd7d3a9961586cc624f083bc266864ab7b7e162c3f887d379d1e3b82faeef71f46a9cde23fd3067c9b020ef98707ec32c7a8b076d2bfd69d07c53f58fa81b8efdf41fe3d62d1994418abea0fda695f47a52a8b76fdb1b4d53e14859538d1a9a97e41982af99664fd2166bb0b3ed012ff4e059101b25e94df675bac1467b25ae68ba3d6db29cc9ecc5c0bd1ecd990f52c80de135f567d500d88b858d6676f011a97cd359d4545536774704ccaed38d75a2b950a55d12ee9af6d344082e74d2d9dd9be96057ca123ecbbba6ab3f9775bbacddd35f597774d3597eee98d65a55fdd38d4eee9ae9a42bd9f5f82be0dbef34c0cbb08079672df42056fb0469bb046968ff5a5bed012e9cb320d692ad35f574bed174052c8df2c86e93b2501a9241e4f3d2dd634bd7252933d0cdf6c6cda440c6e71e1282adf761ceb97dff1fe83ce27e413f13c96992b657ec92bc2f38bf1ba7e6294c6af9f72f4d33a1dc88cb834cb48ffcd137bf72d45eeac14dcab0ead2a82d7be621c3be7f4c9659cde9ede9836ccb5411059d5f75a06be2d93a5bf2dd77cdaf8f8fb15896a1a72ce0a6f4b235d0ad70e4f4b0ab44e8564fecdbfa979fb86bbc7d6532deffa82b14e7bc9774a5a3f29f6677e548a9f1e70fa690a9caaeb504e5c1f8c3a99ebb585fda6a2d1ccb8d3513b7a58badf6e713a6d4bb80e0260b67a12e053e0fb450787a3038dc6a9cb52ad92a1c2f24f9941d03ca47fe3fe9785673acc97fba1da61be77903cd7f397919ae21e499717b563931abd29a19bc91907a44ad90147a2abdff28f5ac15afab8adaf9f61e65a8f557bee982fc60dd920051ea19239b43e8106e21beefe1cd5e7859366f8d577855d95d9fe0c6192e776b26e38a6fd25837613e69c707ba0264109cbbe4b9d1cfbfbca573aff729f24b656e961325e7fdcf97219732bcb8efe36d7db56232e4fc6ecd27ff9c9343f635dc078db8ed3af644a1ef5b5c21af794afc3a7df250d816c2df1d54160242863188ebd3978ccb6be5d0d7dadd792905e7c6c1a3edea933d8073684bffecffbfb4686e1ec5ff7eefa3606645b45cfdd6c273af25a2f58d0e6f69767da688b9b91a4024ab68840f74c380bd302ffb60df2d01b4e606dff86f72f899954b1dad877cee16664eabd0bdfe42da2688c6dfb445d80c4276d8d0af0135a7b77743295b7a0e6b7afd51500c319e134e9dd88d92bdee22ef2b216b0795472de1d3806c17f161c30dfdd6d7798826cb97a281ed7b2fa527b58dcc9ac8075c3b83906fb4947e5cb296c0603dd618c35596845b9fdec7fbd5573f3e7d4ec79603341f70aa6b6a4eb0c5a20ed7a1e74c6d64546d0bcecd15c37fd4a31989b989303efe82c066ed561c8adeceaf40601a76c360d0c3bc589a7abf0814f2bdf5b62c2bcc1bdc3ca014c8f9bf2ce1927ab3389b8fcd541744ac3c8e83bd0e57efcf3f2fa78e68b0e6d0b4d9c1d9a16f371a8b26ebe19b25fad8899db0ce5fef87538d67247f73b0676e4bf70e853b48b96d402582682c2cbbc089a0a07c73798ca56f5d8ee2be03dc985a5a3ffec2aad65bee7674749e68e78d32d6b4eec1695b16fd41c2a701af93f2b150343e812c14e29d3a59c53607c096d0b5117238e1ffb7ebea6b97fe35b78e0ebac9f77fce210712ad29b52a799d6b16029c1e63bfdf897a0b7f86d50e079e7bbc4cb3ed0799531e77d8d5fa0c09ac05db381de44f51dbc6df396b1763a43e817d92c3e3b606ace5675004181bfc40067190bf657951bdda88d259fa157a7f98a08bad742e03cfd4c5ce57326b4dd4af419ed6b8396b135879ecf9d0c39dc0a60e30d915f15b165fb88b5c8487e9968fd1ad378b5c371cdbe0737c7c4789e58071fde5325678ca8fd7b48d6848bbb67d6d1ae08d3d3c959ec63f99fa6733f874ec2a7c3cb4da864058cc27635d1b617ece6be76764933074182cd522b4dd8882d38990758c3eebd068f2790d615e90a5a517526bc580c269635fb2a7b88d0dd025b4e173db249ac1511e7213ab16e0d16ea534506c1624b0490b6f5960e2ca870453049105f46449e79709da49356de1feb9c3f160f884e0475afcb5e723112efaabe943ed0e43d70fae5d111d5eeb47d1730f02063efd6c15e74560a6703b95a3b8e1e56379
2990d5861afda8f06bf37bd3819f0149dc3e98a6e1b70b097d6165babcc4cbe21b13a9fee2b7590d1556b0a54da15fe4637bc92ef86ae950f9d12f749522303f2b43a387945e54b4790229199df5c7c0a84cf2cf1d1804fcd475c9b0d0b47e8f839717694c316c8d9129b9d0263a1e57d3a4cc0bebe4794b44f0a294a386a682bfcccf1305ec9a10bb7e0959b1bd76c5eb2b0bacc09c0bc219b417d13cdd5931e77b0774b05410d41a0e1149f680d1a05feb2d9261e7a0b31b5e7345c574d19c9caf19309ff9faaddf386f4ad58db9ce2c2ec9612ebf0068d7c52d2e2d376e5d2d9da98a6aa59b9a4f829469e84dcfc59869610a6115104f5aa352aa99270fd4d7053b4cdba818ff95ab12ee1ff8841b607d563bc9c9cae52bd63afb9afe9c4d1392e1f1933ac7d3184bac90dc3a56db0f8c7ed5a36ac6507314e3dc39a2d320e3cd7104004568a0957b4e80aaa914172cf6c98054cab3e47063e297b6983c1aa94aa52faeee518db76d702f2877e6b47cb73918f1f1b59fa7e357d22a805415241abcb1a01b72b47d94b526f03d8a6de96c93e365c79c5143e467df021a6cfe0dcfbd43002e5379177dd7b4eb2a986bd142f662034416784f211d4dd3ee13fff6de9bb8891fb4b99b9be37a29067f8454f454fe600247a59eba701a8aa65ab296baf2efeba268bfca66f4dfe7b3709d4589ff7f56274f4c62508234baf43e85c0416616e7b20afcf3dda02fd8ea3c91199e3acd784eedd3acba4faaff2f57f79acdfaf8fe81ac15558c51e86dc34d30ed3da5a345890c1c6a0c2d073ae7b91cc068dd80f864d5d08b34ccc2bd9929d974b987ad34b98886fad13e769f02c49fec12db8470c2a9c6cd305b2e650851f52a2eec2fffd05fc8a699030be3dc22e1a0d2416a8603f8a445b493a3d340c348ef7ad65338f61a48fd1ea96b733e5d3951eb2f4900417ac983e8d962d35d0d27a25d20c074e0263e7a1ca77743fad63069a67bb59abc2b6d9145b080694062d05fe9f1f0775b45d182046f9e57f9d25982c16448091b05f9f7dd2c8fa1a4508a4a3333188bd563815458796abad9cbcc617a70ee9894f1ac66926f7dad0f5ceb4a9d908b6b1ed61eaf402e3f27acf5bea35e997b037b5b2ab144e3c46b342966b65f0289d0539856a10d5afa4fd550ec8b568b4b1a795fbc8d541a93714b59c7469e1508a845aff7caa006db81f858a8065c7aa6e09a00cf782b6445cdfdc72305bc0f257d98a9ac388178172a10cab8b767aa91b5626d5c03cfc512779592325b35ff6b82fb02f5c887ccd702e32f0621b7c3887b6a3aa49a62a3a15764f90e1f806364dce21754d45c62941f8d3bf2f4f6997f8f1d181ac20798b6ad2195509b510edef129bf3c19425ece7bd6567b3fa88487f142a11f70626b3f0b1c2a93819e4b56f9cff7e65d0810fd9befbdb1834ddb7c306e3136b6884fe7494c2f40f9dfe1edcab745271b6e87b50b08aa70cf272036b84a23c035f0f9dc6ff6eb2e67090e00f06fce8615d34ff2db8ee71b2175434c6686551ff76a124d82f60d91455e7a9fd5e47afd732c667b0715add529f8dd2708ff3cb4de7901e5dcca9c220decbbe323dfe1957456b8d28ebc5bb6b73b75a4f46ab2da9f1fcf3d4966b42b1db0934cbeef4afddb846c17ec49e28a2758e96ed045a8be0b921c16cd5d06c19932e2eb6e6d42f3c70f2e5a64510adb11c11f1e80596858bcadd10b4e71d3b890069adec7e2f2f49d0e8f8ff8484ee5278e7a58fc538ce65ccd682e183abefe2176cef7a33e664c146ea5f0965fb971dabcf9da6d4feb6bac345e906c01736bb9da6ea976492e7f368d2f5bda57d61dfbb7b53a27adfd79b515d605241c782b03178e9f07df04718195e19f97b3a9913b569368247ad47f7b3c2ca2df24ff36d5602ec1806f384cf1366a15235d44c79b58371b81f49ecabc6351c0d6cc179b93876f86e971b9d695abfb3373adb59d0ed5ace52450ed0773d82449e1e4b9a6ec6b1e2f891bd24cf44c846dd8f9fb3eaf65c852bbb9b024d71f8aad53c226d58986a0e74bae2f685cf1738385bb4235699dee1e9486a7390b9f46933ca47c6609f0cdb101e977c5f06dd5f854daca8f2656d60b2cd32168b2b416ea3fd7fe3c362b5e7aa529ecb1a5562c9db4d62058f0bf969a1e6519fb3a26809b4a164ebccfc9bd06275393e383ed5d8d16a59002b59216f3f257670d8b5d68263bafee00e7cef8ee79e2382ee79c2cb7c4a2b6fe4236e0276b9d14d03e80b9db9884c40a96460c17bbbd997f8f4177478c9457f4d39ca9e4ea3fe9074747870745845ea34aad03791b4591b9297e1f981123c9bc5d6ce0864d38f28ba36f6f856be59e69d666921b007f233a70d93d69adf9fe4665c8cd7d270e7117378fd5dd0c76bba934de662cdba39f7c5282f1eda53fc774f33ff7108631605e9167aa48c39c61f575a2acebc23ed58fe6e77609a5c159dfd0b1d98b2d27a963827b243f6467755aedc082cd501159af5ade7e7cf225f9f8e223ac481e9796c652b797373be11d037dfd75ab187597aa45748e1e53b3faa2bb248f336e1deb223d170063a59d150ad29c432cab5f4f2ec3da20401cb3db432e5ca4e37b88d277a008a16422e110baa7b62ad50f0574703532d42dd4ff3e89fc0a9c5430052921e83590ef67fced9db8522b11ea1f0fdc702b15ecee41d070241d15fa342c9f9bcb3c979fc189e3c05d1aff09836534a38c0cdc966816ffd9842df5d0350bb185a7632745345cb51f878e148c20ce0edd9beb0fb45a238eea6736d7fe62e54d793208c92168
2Bd727e5f548abd6291a8e55deff3eada8624be262879bcfda49b6aae01c8dd0dd91d17e36510a1ba107e7433546e860b532bc488b8edd0268cb611e8c6115270581c0c6ce7e8def038a7985a84e8e38e01be1ba9806ea6e4f0d22f777a6e40753d5c3686e6ea64f41b54c6a2cb4dd714f7ad1148c2a5334e9a9691a3cba37432a604baf2467a833ba04ae54413e788f94fc716f3f240f12fcfc91e4d66e86642b3563b4f43abbc63ad0ccbd726fea1d0d759fd523dc8bd393ec75af647dc9da086aac6d8382237432846c9c9da0f9e3a1a3d366090a3c89620c23a4e85a5148dd6f655a4ef3d5a4c60ef6325a74325a0da98182236374307edf6708b0691ba196b65e7718e05770f8a0e04876ae3f6883fce428e8bcfe0964a70109e4095f7003eda647cf30f9955b6819aa88744dd0d97389cb7dd14d09c047e1d0c90308172d1eae6935daa87ba7d567ba38fd98184716f1ce35a0ac159d38cafaaa34883a5a23708a1470ef068f43649e3d600d405c07a75ef03bb9d05f6b5e08318ac1aff48cefcee8118cd27bb7cd31615b3726dc073edabf80ddf627ac7fe2365c189f4ca54d4e8e3aae20460b9e1e07f238ac676132c4fe9c376ea10e2acd039f4d43d02fab48e6edc00793fb919d57a897974667a896a7f1d6a25a69994fa786471d5f3531e5b8a796e8476c093df36fd4c6102b32066ac587b3065a991d85a0f4b5aa9d3a7691f7532ee7b9d83977eb3254572a5f8eb64668bb5306ecb4d42213402d1679cb34875371cb1a7397ee0a40b31dd36b8b337c3d232e49da15103f82b690904533dd71646c00cc1a4e2967027532618815a122c606f341bad916fc4915b647de11ea6dfed7165e4758cdbcac13ac5718bfa2e2dae5f003f7d6cad825d78b75e6b1df782971f5974e8061bcf018244a23c19a9fc3e63422f19af99d09263fdb7d0c6eebabd6e6c5d02fd2f8f57bbce44d7b49d6c9a8796fcf170f074c276cf64f0ae79fe6b328a40b53e170fc091ce4fba60fa85491b30ac2af8fdb0ba03e178f78bec0f1177fb7aa15ebd7909d742bb92b564d65ebdd6040cecc4f5e1e5f4432f64c785a4b3dbba0f45e952571a5bd0bca158ae99386741b00b2de5aa5b98da85e7862d5cb4c0e2d5b625823e3d0965a14c9256c4233bc74eda4169ac41bb4956b5d2594ea16ba57eae73e2500190a1f5c707f698159bd109d5fc88222723d0109c3ac4d60e2b00e3d60c95f66fc28b5d013ce9aab4edae2a3a14aee40897a613efc13660717637cc1ed363e1a5999badce9a71c599d95fcea4d59911d97e9570d5e8bf0956a15d56e4006a6b206464395a6f92648d6057c0dd249f5a89984ca0b0818b84a1648a3dc69c9adc0049269b889ba5705c2109bd0a8db4b8641dc56de6cc90e03246e5d9178471801e64bff8598708a3c1d7f41d3a5387817052d6ff69252e4424618a95e78ea6ac19a4aeaa5a680dd1f44db4307420aef2b3c27ff1d2c74f1631f7fd40d69bcfd76a5df0de99b6ec564bc739b29ce11430f54c771846c11a9e38abba8d767c7f13601bf2a9b080268b1d3edc176f6dacd435922ed5a3c1d874ddc4d0a26add4bcc41fb0d3fbe0c1b5711f1142832d64282a3930776f1dec5e7aa1def7eef2f003cec3d40ce0d6db949c84065f5ebde082fffc5c3108f37b3e4b101bcf003017b5a1140ce2c4c83374d416a5aff3ecc432d2ab0e4530030ec3b0ec767ff03eb49f17d18f69b5376c4f01a1fc5e6fb3f99ee9e215d1d492353c3cf4c7103165b7ee61872fd7139424e0fc640adfc25ef42e169e9ec97105a7f58d21b4ea9cc5a381a9f765ba985b1ca52f6ab6f0439dfde1f60405ff3c70285a611bc9a7b83800edc23ed560a054555592e06f01d3599617770e7648a5511f7e9f01216aa0de95be40837c328029e716ee3229fcb2c4c2015014aaebde6c26d6d6f33982f24a94ea0d6271ab393f2e14e041cce9982390f500cab725f3b59fbbb7c0070c30c9d9b0ff589ba899c200f16235969983a2066c4edcb736f37e3b49ac1ae52e13b60bb815893e3bd4b86e9c4755509fab739ab725f2ed31f00eb6446e4b820173349f38bcaa2f155904eaae6cd44af2d9603ae1dd64930a89820848c3d4d67f163699ddd4f56e841fe77ed76d4f79f9f3c497e7e38bf5b12078ffcd3187db92d90a31c2cc5154e1dda0ce0b1b2ff55a1f6b5e76dd673a69d3901ea3066ff611f92719551e80bebc1be258c0b8737d88f79d2e3001ab3c7e6f0950b1d7ce139db92e324df247e76e4b83816e3170edc968b05416f5c4f1b92c3f74b31df4a417ce67d89e3705f62ecff33ffc1589f588e3209a6c94a1f3f7e495b789a692f55b8b3e1048497787d5f177f20bf5be5747f2f6c8b1bde7c244124b0d33c41317fb28057dfd7ab41f151357ae0f8aef73fe3e4b5c97d485d17df8b3f7bf6448fd580c832b49e5aa1de1f5635616bed9fdc7070bd53745a9442dcff5ac7e082737aa9f4cdbbc42cbac2128b73c3c25856018ae37f2655d29d3cf3bee692d517a7252e989720fb21ce01dd9d6d3a32dd6a9f2d7296bfa2a7e570f2a4fd8612f594933fdd45560c61fd68a49ef03c796ea106c19527965a272694b1ad6ea54ef9a9b94fcdec34c064b0c3a1ee6325cead5d644fb48f516380633ea8ae1dae0cc0cd6d99bc38de05a079e295c28fb51d9e096ceb68a7c575733b0b2bc98d565cc2aa10e9a998c49da3a60a6d4d3a4417027b89a23eee558ed0bb205b479768983e777f4147db8a68f9cc2d54268a037abd7d3b0207f3c83073a5d72d1ab1e64cbf5595668f7
2Ccb7eb05d1af5219f6fee1f27578328f46d537b44444c2658ae37a845c139bc0f54dec99604d2fa3e14f607c7ebaf558abcb34e37199c2e30b652b9270b3ce0023ad2b1e16e8db7426ff253d092d794d2a2ac1842045471e13b7333939c66a5a5fd0cafce6b7497c78408c9e300bc0b0aee1478d3a25e0febce5f106ef4ec5d6475af4905eb65c5aee1b71bbb8a18c73af5e13d0137466e21402e21270a55765f7d688716f06703f4150b0b8678f7e1f2fdbc718d243e2623b6dfcc63624b27bcd5b80d0d84bcd80f749440f4c9a53afdc516a0b1d191cda4c6884a43b68585f9a287a4e129578ff1320a45e0d2e08e8308a38a937ad1c39eb65b350ec6bbfb80ed820fde5e7e38b2316971c2a56f168caff011d42e364d4155f6fc54770bcaa8297be299b2540b82c296958cc4475505779ad4ce174d6b5a5a65392bbdb5ad698dc08cfd95eab15858fe0e272bb7426d9aa3970f60bb53daca5c73aaf845ee95dc65786b8938f5b4e3537b274afdf0a2b7c4c34b2d6f96dc53dd2dadf28a417a6af6880b1b8dfd6c0cbc4ef18440da177f2ad72a6c3872da8845b065c16ab9816c2819b39d5bcff941b260a4d0eb1aff8680fbbd7dffe56dcd017b933dee9763d869b566edd22cb81c51c73be31cbb6d8edfccfd509414d8d1bf9f75fbeb3f60bb151e6796b4dd8a746fe2e0d5612eb8c204671cdbe15721e5b3f925d10b8cf2e6631d2eac3dee4cbd49d69fcefe23056de1ad255729d74dcb6e57c695d355f108441dd27402f106f08d5bbdc1c587cc68af80ae095031d23c89f29c367ed2498d210be27be06905ff6309cda8fed021106296fd15b08835ed00bd5dc65e5dc1e2daee49daca0fc6df2ab7169b945a24d33ce84235302a8f6e1b09d9862cf18a7c4ffaf8b3e16047fb55d7eeaa4a4cec4a875263bab95e3a1022b2277125a3bdac085541e1c481ff7b21192de1cf3a0bbef585b26e2d63c69f25e3cf8acdd8df4fd05fc82132062d27687984231ff9dcaab32b8b96595a1e3f37b4de88cce3f74fee56676e1bceba0a11e32775f60bcf1014a22d4d1be3622332af9bc0bed160e635efceb0a8fb99e3864bb771914184f0c9a93569a324fa6333c6f79e76d4463a88783fecdf249922cea179eb484bdb8d857fcf53e69610e1a8cde3c634f2e5963855482a2d6ee39360dcbdd3fb876ab8ec157c3701e164e79a51722e0fe8ba8be17ae1095e863060ba3fd43d4d76b829bdd78c74f2df42bc0130c759e5a139028ccda86be1cee9c3d5355649cec93ccf5d037fa8ff2d59e27c0bbeb916a96b55dea97aaa2ade6b182d93e88c76e951cfdee64f6e60978b0f1713fb5cc7611349f17c500c158058eab401f4a74f2b45c30bbfb82d2de8b7574ed5dedd3291ab55e353bb11b8dfab84aa28cf2ebb58032cb1b7f2b83bede2c0475acc9a94d90d9253d00b8db5e515d6ba4af01e2f206de31074ba8f8ad0951a58ff2fb5d17a5e4f8a6a2159eebbc0af9ca43d56136d5c32a5c7bdf7c4e5d3ead0bae3a01d4bef93139d1f266fdde1e337f05b30dfbc4607ab1122dab8fb4bd6ec07b5f8bbef9349e81b40de15ad48bb07d05ecb952a85c9ab9db23bbe1b5e951fba83c689b3a1e35b3d3ec67e4d8e4a847fc668d07b62198dbcf8fb63cebfb5c9d2cd603713e000180f0880b12da4bef1d95e706120295c4124fa3d0155b49ad150cfaad18d19bbee018e7eb875821a81afe8038c3b80cd88d7c8abb90d72f8d72f950f323bf0ed6bb6f326855adadad5dda483886175f9ffe008afae9ca5fcb04723c77cd81beae7743ae6be2b5575fdabe1d6ee16281c770f4a52e093078461c8f60520e3f07f0f55d78a8f00b5f57358b83a65f02eb762d32711431c79c532d7169981f0eff4e8d4ed1255aa7128ca9453f17686f3c8de71cfe6cf219905c538c72f499bd028f004e8ab9b220fe26647f08e7d630699c3f67fb1a71f0a3b88c9291f152f7d3ad659fbd3796fde3c05f0bcce9d2982496a68146f1e510815adf815d3a2b5db4cef6f6ef6ab638a1d1158e9ac9c0d8ac78f2caefa5b3febf5f2cac1c3aaea95e9be6b4726a304301b351ec5e1c1c1bf353b39a0c056c4bdbf3f55ab9f0de95afa4a5a4ff8179c36d579ab5b15504dbd63fd79c9cd42afc6788b2c663aeb06a625de81a53d58fb03bed8e49f99ad9bb0ebebc376b88b95f997256f03454f7bec601a79bf70c15280596a9e353a126c19e0ef393c4e76ec676a8239a9a92b7ce2e4215ebbe0ea56b75401c971e8a1bbf84bfd265af589c8f19e7f6e3c63a4de94eb66c6b3d32c09f96e9459e8344cb139a468bf386344cbcbd81685bca9f23685fa663aaed17dd6887e1079176e26a1389379feb7ff2d6869cdcb66f1828038aac9df32491b32cec11f35587ce7b90ff0d9adf7beb5eda3823adff1e298ee62d2788f77e1707aa032d7e42ffcaa0f570b7dd3efc7e56f15ba35f68794017601ae00f8eae83e9c945d48bdc38c69db6e94f491d63fa3f78bdefe474c8d9a9d4fadf3555c6369847180fb9d0454191812978f029d79654cee573cc458c28cb8d546e38b859e096a5d9b1b39bfa30e410327df305ae8217fc943c10f42882b52331ce85c6f0ad86730df97965de2f17d461ba5882b26601abe4ec2452c490b1b64dcdeb9bbb3085edb65b0bbf5e2f513ae88c17f4837ba9748c985f3b539ef6bdc50c5573ed7582111d497708ae7793615d47ecf836a8bab8b28972a319b09d14b57f9a5a62ef232e5b966ba5960a37c41155e05d7294b07ab939405b78b14fbe756c7a3fcfa848c04cd7ed5197b
21c707a1fffa8a86a22eae1743956a8a1a185d616bc243eb85071a39d26706ef8c2e4d63182ef72af9ba5e3e31ef883e340106cab6e2bb82b10593ed105d2129d6a50905abe2e3687ab773b8025a4d5aba6bd0cb9b3c57eac99f75a0e6b711d3c5094bc5a4a440b922160bed987422ac75dc9ba2541814dab86ed2c62c86e562dabd102e9675cafd8b37a5eed287ae44b6af175a0c36944588bb6b02ee22fa7d9cbbafc204e7672bee04b09cdf142d0b9b6bbbaa21bcfebd6ca53a20bb75b59adef059ad937b229efdde8ec3bf6041f0125ad88a2b7df4b50a72c62239eb9eee04764b191371939b68158f827996eac2b8b7e31f1857cbdc062a96cb8c03cda854b5c775e6ab5e06c8d771bbcf162656f720d833b4f666341c19f60fab81f20f374dbf72bf930b9d446c045696874cd054e7d76042b79f8e2578af207495e4d80c446b6962de4c9acf935b067bc5b11ad8f2dc25a863b836ce6fb0465e35679492b443aa49b89273755ce9dbedfe5d85fdd60f96d235d9bdadef393cde19c8f03a62287aae5e220753b3da7a909f9b62d2e9eeba700f8d7d20cc67a54889e82ed4cff9e2af0a10045b842c09b753479eb344a1afc12d1bec989c4f241f2808a922c4739df5fbd75aa436f0f27e1cbaafb6d2cb9b8e430ba93be9af3d7d3c3d742039aee5817df7cfaf6fb9d3f9b4485fb54cb2bd0c11aa441d3bfcec1e91510b79594956ca5af5867ad706a10b59cd1c1230473adc878333b18e82abef13afe6495f5bc4ef02f0163b778bf74c6023e385e11ec9515bc0610ac7de80f3334405bdd147fb9bb406f2c0df76d27940da37f620e0bc6df7c560bcab0780f0111d44f2592c599d361e9b52e8127eb1299da323dc08ef39e3543112e0ef5ae18e37654ffabd4702bef04e5c8faa8bc42c82e1e55eee996ff399ba77fb51fa46ed5a60553d4e9dbd806cc2c96404f4b087a01e6a4132d026fb873c1511f206fdd9e27ae988e7d3255baf3826915c2fa5e1b795c7b01b221de81fe3a3489db22d4d017ec3a9c34e178100e39eac65fe45f4955a5d47ea818ec8089e3e100a5cb49788fa3107855a3b3a2d630325e7fdf3a4658805982bcca5c057f04dc567b8678750e890b047aa4fdc3df9bbf8c883d0ba7167a0747ebcb46921dbbdde1faf2c129c3703a59b8beedba405cd44c45b6d23dbb55b47b4ffbd8004e41de4b84d6158ffefcc275daf8681b159e4b06bce7f549827391dc3168f09ddc9683dba7067bf022185558e237194f0f6f730cbe3561e7b76e0e65b69ade463ad4e71347b64861cde3cf787b430130cfa3929ec0f8798075305d922e9b0424360b07163102fc77668dbc66c6637da1fe67ee0874bde4f15660cb78cdfdfe2281ecd1d82de788d54348d57967bb0508ff86ff988185995f733c1298a0627da1bfc1d983a4c5ed9fe47373f268071f6a3ff28a1a454138fa729e13e99cecc1392d0bce2d6ae8cf14ea96dbfd352f03d85d951aacda3c18b0df5e1d05667131276d8ca7961d1ef4126ac12467ac3b8330e485a5f8a28d289ed243b857ff7f53da72f7cf6e2fc2df6f3f9c457db3974b53cbb717a3f8cf68a3dada9305ef1b03dab47628131c4291e619447edc40dd2123611d1df9332568f6f95be2a81f3bc6aa060f25ba51f8fc6509d0449364d8e00fb87b7b81c849b08da666f82c28f683fb693963da990bcfcdeee3c1018d6576fe0256930e80f8290423aaa90a77e0764e8f6f8cc4270f91c0d5803f98dba029ed82a60c27d92f7bfee36851dc059425f955545f0d98393556a0be8804dece3cedcba0d1257e29a62d3236a2bc5a75b4093e5339ef88f8f3965a04d7af6c435704d869abc9ed415e3a2e699f7994ecb2dc3dbe231e963998fe59972fc85dcd4f7f1a67037d115d5c79d3371527334ba1147b51c52d1dddf3c7b47f4cf58b9a879695c5a89772046c4c85c137c0b2e22cc5a3aa8b1d84e693e2aa878d65174fa61bd29d4b7430728d3ee8b8787aa66f24ce101d07dcdd02d3d9b24512c0f4079e2598929ad9bcfe39a4eb4629d501bff324c98914af48d856b96a4ccdd02e6dfebb68009b9e6f9e6577c832d7ee8c2442a013ff36bd2ef993dcb4ccfa02dd1ed436b28e4afdab2f6c38cf74bfe8e2d6a9c558a45feaa747fb8a2e0af1eda3c182a4e8b459c4750c046a3b6f494e934eaae825b3b77b91e966af396c22af3d1fa43e98351986ee6f983d5c194f16c994788c35fe739aafdd799dcf34e3213b34670ecc603a41ae0099ebda5c3bd07c601332cd439d15a959687d7e07d7db6455332e8ce4cd2f831c0cdfddcf115c6ead1e7fd8970d1e7174b19e3cb6f14aedb9cfe02f16af2f83d3bd42007bf8ca01f28a9179e8c8ed02f8b5bfcfd52235e9146f781c96aa13ad585896da2f63d61aff6e74ad5128af052c8f1ff17b670ad9fe3c59cb9b6828e8ed076f760717767388886eeb424c10f70ae1dda30730117b4976b2cc01d54c082bb1f305d4112f5209efc078b3d932c6832c528810b90b12e41564c69721d8aa255f7f1292d0d84feb82b71cac640e767bc80694133372167698a725c46e1189437b289c46954a69ad04080dca58b3eeee4c7c560fe7f956bbfab154aacc1dad3578b44f3b41d270d5754f99431da9757d3ef29f0738cd298e634e8160c18e049dd41573ab8b0ab95654dd2d32f5b3ead1f9f61380cd79bf5aa28ad74adaa81ba56609d52c19bc5deaedb1ac36164a024b9d36abad1787efa7d177a47f24ea834d79b0c151d06cbf3fba5f32cc399466e8da6cf55bebd2736f12b2a69a176c0f1db
25292011f4c15744f9cb77adcacf4260e27c038c5b9ebab5f1ba430f8f7ad38e1a489ee55630729d733bf021d823479218b23180481428595989ba2137f2eb57f1a33d5040799116646a562f3f64a58bc8d95cf21fd554124e73050518260fd5de8aab52c312401281651c84c5be3d2956eb017586c32dde60aff014a0e7b89d225d748d5975e559f6882dd97dee94835bdccb43a49ef5543671a0bcee34d19582097e960d5729c581e7cab6675f9feccde43c87ccf438badcb52d827859e6ae15ae5ff2d17db857eb65e5cb712da0de44c515a7af38077aa100b93131c034c24e9403e973e587e01c69f563bace7fab55bfd5caf3b788796e540f92bbf1232945d52361372f16bb59dc0be9480d5cf7c7b044170c97869398e0cad17d4f49cb2889e345928dc4ffd751c2ffb84507897842a9395a7722c4e5a6ba178b801a442304077150da098c18013884480fa77017014d0a2cb6f6498ecbf6515c2cb3e51b5da4ea9ba5936908e3622b78d4db5b1b8af504f2d31ff5d5c595f4df4331b94974a6ee9a6fe411a650d941c2928d524a2a2f4177ef928d5290d2713758e1e367349a74a1c781342046c17f507c6426986114cf7f8bc3b76813aed6d55c78a89e80bce6c54ebc345e7ab3ff8857f37d3a193fa4c01102c4c6bea094e238f413ec45553cc9c2b453c4da97809b86b720c5d991fc63afeaafd3c8ae23124534bae5b73f597f7187558778c4199aea57cb14fe434f2ba09b2e825cec637eaa4cbc045372f63c45e9bd7196918c2d198196e16c7aaa62fc4eb3d5b9f15e281319e435ec3391cb384c7788bd4f82a518953d695beda1472b06f1f0f54721c2d279f6f5fac7f068b44f8f47bd6a8baa5d6c3d1c5257933de632be36d55ad1c784e599b9402a7fbacb2591676fdbfe433cbb88dce5305a9979afb3343835c8f01ec1cf5e920391719e98ff79c76aa3857e9a8291ab9de97ef71ee36274144d32360f6bcdf158afa15ead971605600bd9fe5f0a8cd258f27e87a380f4a7d231938ba54e5b1aaa4029ba679dd6baa81bdd39cd0201d5e6b63a15e2a2c38b84379152b642663d904ad08e9bae5cfdd76b784bf1f3d1a5e55a8508c0de47c04af2890f565bfa92a080cfe7dc1f49ccf98e2156bbe6a19e3151ac2c73fa73eecd9c7d49f737438788227ce427ccd10f106a6b5f9bdf0ef11110d9e7fdc9790c5006ada6ada99df442bc186c378c7ef0b4031ee59d18b78b823abdde29be0ed849718e99373faf3d9362ba695a54ba338c74b83a71efb45bc849b2df23f591db71689fbe1bbe31a291addf21482eaa5a4e2d3476846b2f2c535baf3c24db96672db3e374020d4ae950cd50cac97936a019e9a7fa85c58774f55e349e1fbbfc778d6f38deab1cb93de89f8a058b2ca068ce245910826a83f1a27f70498b8c9695774d295cd9429b46a3e8b895ecd3d7b345f6c2137e5ed6f1ff98cf91f6ef2ce17389c4bd33c7f1573cb11beb2f8592f4d6a3d69835ada2e537344979c788b05ceb50fe40f03c1e1eecd9514a88617d675d051db36a60e116e4439eeba8e375900323ad82f2bacd1a531f34c35dccacdc41fd68ba74b56a6c42e78a8bcb0dcf1e84ae30a1b56e92ecb1126b0b2d30db4e8ad6dfabed81e3fc9fbeae2e13b3b065b68cb62ddc0263b367d6eddab46e59eb319f47dd8b78d6aeefadcc2efc07af78f2ad29e47e94151028224b9c35ce6f6c20df5c834de7321e3ee80adf9a8c104098be79079fd3576cd86383a593eabb01d2f3fec0f18a579a4db0671b02af1ee01ebaf367dd8df8d7435be0efbc36904be65c33e52ef38bdb847d8dd3d0f54fb4e1b0092f709e76e850879e713c08e1ae6e772e0f1efb5593d7db8409cf117bc6bc565973bd1171ee541c239b7e59e5e1e0775433f3a0f5c182c60026fe2d4a1bc9decac7ce33ef5658fcb78c4933c333b6fe85709ff6b2de3e7a1eead263f2fb89ff6ad21402aecf6e86e1f3a5d70bc243d169df71ec2740862d0cc39701fd78ce60d6a38d35ac7ab19762fc22cf28da951ff7909da4d9a82b882ef3856e0e768aca9ad8ddca5eb2dd873cc17d3814e938964e579f943a6c745a827c96abc036b9c9641d6a380acd9ce86db8ce35adc37f7afad38643a13593c1b7b9110f0d549271602d5be732663cedc84bae81734c0ee6b4e04fbd58bddf19717ebcc022ea984ae8e8871e99877ec64589dda99759676678cd1218458419766acd9b93c62f81f3dbc71cf4357f3aea4de9934db27e6a385179f9fbc82de7e509514d4823c6a4c70a3ad796f369ae20e236b788e5a65aabc626bd23cf62b3daa01b65f8e93ba3597cf9c32a682db9830173041f132c67b914cd72e0fe9bf761cb285cd2aaec67741a908643cb5382e185bebb14fb0be4993f1a567e0cce1a3447c72862dcf85b5ac12021fe95393fb460fcbcfa0bdbb48f573ba328b9e25bc538430d01fc5b1e25d4fba2cafab2124b79e8a86de5d3ec2b9148f53d051ef4429eeb36d8b9663d9b9170538a387ce8f6975ea74ddb9a09d277d27ce12f166d62dd4e9c48f53a9c8f65c73f761323d6bff3415f5aa74e47a2d945e9255e6723dc9e5aa6c4c19c8f535eaced3b5a17d90c64b8bd7615138db4147491551dded7c4ce7a850e117685c48f7e50979fd48232def5445c7691ef406f58f42bbca47abf7ace99e82e62a088fef9b151ed3d8f4728255d0775fa74373896794db8fd49cd60db2c32715d85cb652723d9a54e6e90af2a5a93a73e727d9083e633d131d43b35c61e24fa63c49f427178e85533b835ad7d4b5653d1060752
21b59a79274fabb6bacd0297c231dc9f50ef097ad3974b2de7b14da4ee1ba4c37973a06be3f826a0c680c256e09c9a7d5f534f6f9e8c8c7fa3ba9b765ec8186e3aa19376d17e81df3304d9f96a2e7742b3adbba1212f5a8f33e02388dca2088e6e82b7536f1c1a06a1bd45b29da05b7f39b09d03636813978717eb4c8cd61e0bc53a4f87a6fc1e93e99bd185b038ae247cca0b97a03faf4e126501e5b6aa8d8cf4466eff530d531fa77e3a4c740d010a5e5319d4398143e591f225af9ffd22b7c3b71675059b0bda2d2fcbc490eda5b92e25d8dfc07f0434b91fc6b2454b6d6a9d724b90ce1af74ba538fa770edc41a7a39f7a00a46e2e83e72ade97ea0b932cdfdd696d75f1718affcfd759d2665879251d5500e78462e0f9cddf6af1a7c4bf720ccb0b24fe7c0aa69c2980e85137f0c708134b76b30a9f7f63a2358b0a1af05fe4e34cd7b4d23f4a2592cc4bc036bc5a8b83beaa6e10ff3f2ec0c9e458798bbe5b3a5a5c10f5db8b878f7ba8fd72ed2c35fc4f16c384c74bff85329b3b52a3fe485ed41b9d5e02dba7c67345f537ba66d2c8e9a3b35ba7841e7641314205eca09f543a6af9dc90275240e959e76a19e38bcae6d8c9fb3f39d43f607678a2aba6cfce445bb17392e6dc785d3ca7006576d7e77c4b23e6da40ec81c7aa79eca5c4b70f1e9287f70024dd9fddd069e1dc11500ca986e77732167efd9ebd3356e433c22f92b61ed64a85019b3fbabd1dc653c9c640da730759fdf721f2dc9625e7e75c94b79f5a2b5b6e456cfee663cbecb77cdf24ea4aa3f3a11cef3699a3bacdf3c726bb5aa8df7368e32ad83b5857a652fee1a82e7f707190a0cd50f09fdd27743af9a7cd1e59d44b0abce8fe79b3fba442159fc9ba7367e79892d0b04badb71c1fe84efc1b1d1f9ce1599cbff481c4fae4ca2e410b677a6e1de83f7c68a6145a62c9f1cc114b79fbb5386572637b6a8d9d3dcce9ffecffbd047c7280e5e3376fc9d3dbfb5d8cd9f1d1159698a4c4fbcd4231d2f3da565ba13f6fdef4c787d0597e60ebadf72e1f63716b450a181bbd9a14b67eafbc996cd28a40c1ebf1f38ed8f2d309cb3231a04ec21f1c2d8cc4dac3e3811f9706cef5b37c725d8a3e3a4f50d5f6415becdfe533ba77b808b91eb39ad96f9b3e549008d870e475c2ba43c0f36e77768e80ba3ea70da471ea87516fd6cb2c8af722677bb26e0a79059e3ac014e93abf5709544deef0f4fb8698612fcfc6f233f4826461e4e6474797fde0e24a2b78a67554eac04b0e3fe73ee8dc2a78368effd84dd78e7fdd5a05773b465b787a78bdbaf111f461c75d3755ebc5dcf27ca80023c16aeea8ba38368d93e26956956aead074f924e33c6f0c1df169fe3c708555c62e8fef4355962bba7d2be838769f5028507ac9360613dc57341fef95172fa797dd4bcfad07dade7e0963e47d747e71be3037a027d8e2265627f722dae0cb5054cca013500506d3315b64b8a25387cb32d4cc6d8c11f51352fd74fe56306469bd1c6173d0e8064259c70894fa1823c0a0fac5c877f0f40709bcf1d05c03c4b2b44f9f9bd03fa7552c0fe7c069e93d2fdcb476ea66b3f0f86be5937e2e9eef3b874e29027454591fa3f45ae228a2779a36793e0f348f75eb66ee93cc95a9fc97f43a980abf6dce199e0536c9007ddd1fcb2d82ba13175ba3c84fccd5979b6f54b4e6f3f818f3cc38272fcbb6b70e61a7e471aef23737de46d0601e31edaa206e24ea6d74de490e0ccdeebe3b1b2bf07fd689733d1f27fe6aeece690022ca34012b08749aa3694f14d4b96cfd31fb043ab47df14178f3688ba7087dc3b3aae8453019605284795139352f2d8d7033fa7bed8f9a7259a301f21e03b610f13273a20f422741791e4d23e0e59710bb3d0497acb7f1279c3cdb8778593fdcff6a5e7e71f1d57a64a93f90d0c99e71d178e8445f5c3e8ae4aca3d27f7b67a79d9f9811240e4272f071112a3051c9fd289a4e3d89cd9747f52e1427346dd7955e439b01cdfa7da8050c3003232b08b2f0e5226bb5ef024799678bf4387c93fa35e987eedb8e3911040eba3517dd597ca6752bef5f9f6564bdd1787a2fb82422b379b8c517c1a303fbd8650ba992b07b08d2dd4b61c7e31cba26c876e8f48a8f1ea881dd26fa11d68f49c66da3e81e50aa3a969c16b3e8bb4cc325af761d2b2a6891405ed464ce6e03e39c39e754c29bf1e5cfc0d02d1662a19baf199d9dd3baa6a80a7c605e5494bdb3a0ac677e8b475d17b71041d17d0a48e8e01548ac647ce5cedff7ff4bae494308ee35ed21305b1fa5004f741f608f98fa809818a74c18ef7ba398aae1cf8741df32b174f38d1c8bb5e153418905f91048cf499799fcf170dc3ea231dadcb5e75efda57e03e35ec55dbe9a8ebee4117556f90d00b59ef2a32daad4cb58c812e92b3b94e589c7e04e0d6a13d5534889b5845a40fb36a57540b6be8b3580ef23ac711b84921d76909ee4afb046ce3d0613d4deb8172bd3d5b49495d08fb95ba41ebb88ad13cfabfbfdb1ac377984edf83f26648b8d1f9e46b3dc42f5a01ee9b9af48b8d4bac3d5c6e1b4cd7d1dfbab2c7be84417ba36e4a5e8ae3cb552a334dffdba8dbc838e0212d2d85fc765d1c3ce04893dd2cb5a8ee77cf42dac77901403aa7fba3279d6b674135ee5969160f9e4180d18e3b51c79b6ab57d8979c505d712c07a67624d4d67ce9958efcac8b0405f3f5c77f706776ff764c5eebd7171dc14f4a8f1a1507d1b38b7bae6a226ffa3ab0a72e558bcc20d9eb66755eac65f3aaf5e8b6a6147a85ba6f26a7f9d59693aaf58e32d6eb
27208c8c1fe5eae14438e97cf8283468f09e4b47c64d08d65760ecdc2043309c17931a0d043af695ec6c325007965ea00afc10a3a53d762d323e5597b9ec3e726bf479e4c38de2ef68bac763913076ef38cfe7f41919040ffccb4fe7f4a4fddd4854deca3507c4ef4bd596eb828e7c79a569ba5607861dcc2fe9b2ada6f53262856d7772389b8c97e289ba79ba00501b7555378fce5f22f2fd9d8cef234b461a365f4cff7f327ba8c1474e97c79dd37a247651c561017c1a94a2d169cf49e250868ea1e8aa2e34f8604dd28ffb2a55bdc88d6b6df0eade86858d35dbab01ab6ea29647d669e6591b79b799646dbd34411e1b6365698dc3a198383d3941fad15e87629dec5bd890c777b1ca26ba7696b1c3df43f150338ff23f0537be0e51e7551e7746fe58ab803b6f57d3a90ebc0fa61eee37a66bf48343ce9d3315f79dd38ba63fb27788423a8faef8ece5250b8ec6eaf8524f08160145cde30b68c9eb2162924140a507f93b1f18da2219b31eea7c5a08f52c17a216e0836bedbf27920af4223585851b9d87b70fe40afe8e3c2beb1550e20bd1aa118fc7cfeb5d6619f5aadfd2e9763a037f2ddd35e72eb26a13f49e7dab30efef666adf5b74c77cf6b8db9ac1069dc55c5619de40bba804a517650d03ea6bebf0446f480b6bbd0a60e0196b9af3c56f6bc6ab42dc7af14a0e5f49c840776046fe0d9c7aff711b85e9f7c385a7216a354cd44218cf265b75907a4594e2b271aea791e02cd425ef4f6526f3b79d24acfc62e348b9419b6b8f57bcfb18e50bcf7b6e97b800168fb6bb09bfdcce17e75782d79bcf2f733b79e3ee049f235eb8ed23f8e6f2f0230f89b83e61f78372520c19912fef73db4aa30fbc0c4ad72cff4f48a6183719e0d2dee57abdbf00966c3dea5e89e1babf604c19466f7053a64d1d207d1aa2e667f0d4708ef6e0fac2a0fee931a9cb0c8e5d0c7ef2f840bf588303f5c6767b975db6365b972e7a7846aa868ef5d23fb312c417a1f1f15e82c955988ee0b66b9566b957d499bd1ae7bd59a98aeecedc20b1c00c0fdfc59c9c036bc48f385a72d501b1e9f0708394a3fb2ce40b926a773681e8aaed12ff0e7e5782ab8a9511e33560514065a49c8c5e6b3b753e52c62ff3072dd7bdfdec252fe73fec6cb2f441bf87655313bc9dd3b9beb838d2343e968585775358c8060c94bf26a368585432501a4f29ad88e0fa41a1cbae8134add2f66383e90315c27165c02e8ba7253a632c5b09c4b5b958cce8837565ef37840e02806eb37411cc65ee339f7943c273d57b28fdb96fa38f0dc2f3497421be7d328b0b93db664db4e6e97edf3ff9e932f9340ac3e537e079bb5c4e8b7b27837f22a82b16679256a9a25fb841df41df3e5e29ed697615cea89576bec158846f1f72744f7d456f971d7e42dc26b4e0a566b2d434ad269bceebb69eeacb07638b9c095696f4f23b8fd4b7a64770172355933f773074a5cb4768e8a52a97fe083e05576c436bef5b54092f93f27624fbff3ed6adc7f6149d9f1a25cf13a196adffeea4ac3830aead058cd9a28cf420877f533a59e3e6f3c14bc7668eab579fbdf48dde7e1fa07b6688f6cd0eb416fb88bef8a9f277942b74fe6b45ddb1d2c8e522849b8e4ab81a5d1d78be9fd2f26dfa54ae1ed350cec1eb5a12bcb373d384458b56a6c2a734f08f5590c13cb7e1cce2559cd44aaa45c4ff939105b72dbf76778c7e78a75c820d27a574bdbca391077496838cea8e7e8f977571312016f5037aa44ab1da30cecfbdf48de64e085f16b332769859e16c15ee7413b30dd6c9fa8dea49ea5b7aba61496debaaae5ced240ce5c045bceb9da5bbc5e70f7d99e47c38c29493d6f1c259b18470b3c71c31e516ac0ee9d24b42ade6c309aa2a15be8aa1f4c68f581b9fb7c5dab25264a3f0e033c844310eb3ee82de566fc4b88679e9635f45b37b3ed0e9bc82661b29d7ab98617a6d2654ee6294dee3bbd47c1de42041034c2706403fe53c9b8c43b9b25b75d72f8b5a0caa787ee17292f2c174a2aa062163b8ce0d3aa46cd93c19dfdc2d0be27bb5adc7ec98390775bc98e2281a6485b0291f6f574b413b8dc6fd0151c2fc784145e2f8a154e1c6ecca5f45a7f67682374db8a3ae82c8a10891b411b823a8b9476007d3226f3e4e1b882fd9635cb69a8fd392f4ef5cb69a32964da14a9206c3196896ab56728d64a5f4b7c42387e98bf282bf7c1c21aac9a4a58d94a183039003b74b1a1249efa5ab1d49f927a50bda1342038cde358306f72611b05c03271817d5e215155b562fb54670977de63a15fb642b94148f74c37515c8ab1ee10168fbd2c524c77d9ad2cee878ef757ee0ebaa98299c6bb5a72aed16b4c431771cd323998b682afdaafdbd40f6315bc3fbc6d0765e02a16ee32ddc1affad9f362c1c3e965d1a11edbec93205df7e08707a6f67bd2276d28af1d35d37a8b58e97b2a9cb0ed497849702825e948d26237182ee58865236db65fa59ef1a9e6682e944746f87d599cd9cc0f5eade5334c26db006e15bb2ae2371bf1a2a70bf9e79a2d07c38a755fa6994e4b59fc7bfd6284b2c8809bedcb2fd0891b445a24e0df39e16ca93f26de6e00de3bfed3bef9d95ea9a8ffbffe0f0534c96e72a061ae81d81c805f8da41c4d9859ac307c8dc5e0c522e0aab2693b4e129d3b124b3256f3f9972f3b09ff6a07c378e11db3c7e0d2d5a05f9c77c577089964fc58086b35b98715344375f17d1827f60afd1a9a2141607d379f99b803e301c26a3ee812f367ba7af5b9dd9d3edbb6775bea3f4cde7274e2afe38561fed2892a91e
26bdf7417f8f3a09ae02d7ccecfeee129d5f55bde1336bc66e7e3c326e69f0431a411d11348004de9995e3abcbc4c314f2a5775050d7520be327f29d909de848073aedafa8d259179cc0d8cf75872f9c056963d2b4a9730bddd66e90b091978184782bb0de3072c799d656d8db3fed07bbf3a2057ab0373c2d53a140f25a72a2ba6679aca6184bcfffc6ef0e926479d2be8c60f9cd5ef1adf9a3ab7fbaf3309ffb54aebf7d28b75bec4d8e21965b0f44b6e7e3f2828f216e8c771dfedc8b91b04a4a0f0c1d8f3c4f5989bcca42d82549d16de24a6bbba94da6b174aab47f1cbd275dd875483f0b37a935635969ae279dfafe0cca36fc1bb179cc567f1f0c6cf05ca7e1262dceeff847603a65c0ba8daca2d69bf13b454ba4414e59a87fccfd5f38f29d44645f9dcc35d7e7355b7861ce560ba615a3b9b2801833cd3d3ed5bde1fae88f20037306e7a759252b91eb8bced9bc032b2ac4e1a887c0ca5e1d70ba2cca9327014785cb92f5763fbb4aa2bc53b48ee3f2b15b90518291730fd229b9f33c5b6e1ee6c8e80956f7fdc19193e7c19f478effbede962c2bbd0e82c9d2adf1f908b37205760345609b53b3cffc74d296d883a15269acb087389f14e9fad93d1e3b46e9b96b3228cae83aeebc69be980a2cedf33dc3b6a3e21adab8b246aa0de98c47ca4b959e92ccc2734f2e74754b23c0317025f5723acecd1e92cc8b27d7ed1425e7e14b256949ec7c6baa14b64d87a5b0e6d156ded588986b958f9f19f90e6b8296c25a8a9493e96d25055e3e4dd140e82bfc30def01184f1cfdaaa79755dc77086ffcc33c13060d1ea8b3d95a94b1290e869ea52da75f09fb2ce3d45f28a3c4680a224ace6862c5e7f93478c1937a116dfeb6ac51e3b1840cfb478caadf63c6894baef0b078dd7dcb4d71ab54033cb36cb8fe36fea3cc512abd1db29d328d4e9a4f1a2d24678c78d4cf12b5c99e334af06324b478c6ee3a9b7533f2e0b897e0d09e39e9dff0303dff8a6eaeffa1032328127e6a45e7aa3b424b906ce05d4511af48a633bc94bbda84eb5fda25768568f586ba8b5c78c65c13520ae316c9cf18ad1ea47476a2c33438fc1e7bd937f68fe68481b7878c547c0e7932f692e39e7103a029d11a4707560c2ea8ad1f290bff568f1e658d0679f8e375021625cd588ad1ea53b1544aaefe2525a4868eae8e1e3c6b29a071f3d4c034a09acb70b3bcc7678c2f6c62488943712475529b1747a3fb729e2b4c2b4ad012b83ad1e8fe8ab1f2490b1f65792ed2869f15943393ce3f0c17ef965e0f23fdcfd0539bcdde5d02c1918779cee018ad1f00c5ace60f168f85f619b8a3f05d84e0359cac56aa78268aaa1878d118e3199ee6fc865cc4ad61b0cfe0125ced855d68b25be7dee9b1a1e2ebd1cc92e8f5475d8c9326e6c30c568f17d6a1b787805cca337e34d9ea5cacbce6d7e822e74e2e8cba827c94900f58e0aba96c4b77bb79e84d5bfb80718c7cf5d5c03bafb87967929afd736b1ce1d8307292183bf0211046279959b231868f54285b1b078c5aa081af8a2cc94672322b478de53790dae790fb9aa09276cf0fa8c6a870e0ad1432d4c958920297a93b66816be7a50d6c949332450642b478f17f80a9e7b8856bb27c7a5dbcab3ec105bb2fadd2906b72b47a749f0ffb3c6fcb70ad1ac138c3561b5168c581097e956b5729c666f3e57be62fcff5a3ca3cbd0d7fd914a3f6ba1777398418c3cfb8065983825e05ebc3710cf130140a728f03ab8b3cb3222051c2f335f9e1bb8f55c83e2ac446b2eeb2f47f91acf78a8173d357969ab487041ea747fb5172c0a896d7608f0fa1c9a8c3c9fc3cc9fe2c14717fff993a22cce610a5d98ee281b05604b18eacbe1acd3a79c4eb494791335e234d4263543b8b09297583ef257de2370939293d451b795bb71c18a563dfdfad6594f28c8144e6f2e6ef4564949777b92e16b693d86f4fc213c40c7f5c3f0be3e2ba488f4b16be3f9d57c0e6a8906f3bd45ca70e2b795fa5c8af32a6606a1ea74e1d47a1f90010a5f7fd7dbe10d9f217bdda1e6bb2a8d6febb878a898ed001a7afb8fe4968b7d7d38a362c52749707dd8b966f0ab5f23ca0a831e2cae6f4b74b4e29b894f23d21afefd2bf16d35d0b3be94ad5229b95bedc7925a1adec19aca26e5c77a2aeb5d00a29848f1ab777c963b9edabdc8554369a178b964b1d3ab99fc3e3b939e8b314732f82d96b5e7806ddc4a179a4846ade36a600152c9f54f069a8f02529f3d24daf64cb10a5ffe4b78215de27576fa4fb554fe57bbb342301ea6a0f83ee8b5ed0ec92e5b07356034755d50f1781b736833b3834e75679cf5599d79b668c9c59f6dd9dede7eab575766f48da59884066bab6204a34861c92bffd96aff525acaf76decae792f95231f55797ffa8c722dd7a69bbc8d373fc7903569396e687579b64ed14c9413022a272bd555deb0ec0908f37c3e73fb34e34c3be4d0ee4ba3c57c0f5599cc7e6c29fe6f2b0c5c7001a83cb16026a76321761e95b54c35c6ddfbe8fac2f403c0cf281f23ce51e6a19e68b788cbd14fb9bc91e056dd0017b744461aae9e79aaeb7c1a93638c8100e03f6906601958b97c47db2fb18eb3de1fd51923618d588b45121d7bd2ca57295d9750d80a4124601180a01b0b04243a20c5105cd08e6631265b5c8baee90cb162f0b8b87295913d707e1ab58a3908ad710bb6eb41e7885a0b42568b20382e14b4f2a40b87f0f8c184e540d0b5ce8cd0b29e8c0ab7a6b9bc133f5bf1a63229a2624ca0e7593e87d33d594fe9c9560d63f00d0461ac26b4a2581e18
2Cffc6f6936fdd18cd191c8dc686f1c23681c53ce1ed28eed388a85f25c0a103282f488681840c13f68024cce69bc0ea2fe2fc30ff9fd162ba80fee355e1707bd5a3e3a47ffd1e1d232071eb61a5e3c88190dfb8c99687bab447e487506da2e1e5dc786d6982a1ea0f41837961cb3800dffba084408f44a48078c93475a142a1ff19f81e87cae2b583d804654566679d78bf6de4bbac35c9d486e3ff6951168cba250fc3928a697f7ac516b531af3723539bac5aeb8c660f4e05c95cfcb4b4b3881d2e16766337f9fa092df5d09845d021236116d3a592e465c0e7d247a4550bc31b0a68d6488d24e9f8f8d1addccec01aafbdec0c37e3022917edc46ef173854e55fa7ba95a1d6d27d23575f53b66c4740e0b75bf815bf78107a11236522d10ba7db888461740a3fb1b26d356a3e7e47a3c257aa699fee1088ed7699bd9b9a684fcdef96e690709bf39d30fe31b89830f16b1db3526a03b97dd3309350a4170f5d1080865a969af3d6fac236020a23e984e206ed0a518fe9fc68e054e010cfc71dd89e7899082bff3a077410fb03e9bee05ad01f0199c26b27364be36591acabc35ce18d191d4e31bca8fd2d7216302af81c9a5d217f6c92de8cbb85462dab77c3b2747f98ced5fbe6a0e3853040ea866bc375d7d0d2d733424ba9ceffeff4e5cd79771597131e17b2da9a09a03d0cff209ecd6441093679f3f47cb2ef5fb2e5abd347f9ad2926aaeaab2d45ecde6ee6a1eebca18b5bc324d19778df82db43fbca01d04279a3a2a8377760fa1c3d17ef4032a7ce28eb37ace58c3f77f910781fe281da72ca8e631a6058b24e88be0ac59209a0ade689fdc0447fb25bab6969c73f6e3477f31cb842f47dbe5c556e783cab2291e5c044634787f4f967bf7d9392299e5bfb4f2cdeabebe162d5c8f51e95c8c19d1c61a1b1c51b84ef39cd2c23d53f491eac15c4457de3b69eedce82cea55fbac2d3ed82306bfcd2ea2fd615b8dee0dea4b3e0a9632c114d0244faecd069d1028c190a3cea99355d38f357a1e3df425ca9a363e5f9e9792a668be09d3707434cebebb91b8466aa5044187f535a1a9fc40d46f866343c9f1ffddc6fefaffcfe7fe3ff7ffc7ff3f7cbffefcfe7fef9effbfcfefd79d7354306e57b91751cbedfcb86b7db75ac9422f25b725bdb9d65bb8379aa12fa84d8e17ea8e58d52ea41cfbfa0ded0bf661b7a6b97b4b063db5691b5465be96e3eca4502f5e6ebb2db6dd859ab14543a11e5f58489b002023ad7cea818728e03e81c85bbcf1f0f5a962ddacaa3d4dd5acddd52a046705ed1c79563467680effc5b9abf5c26e05f760a986060ead8f721548eab6f59977a6d07fbbacb277ea19f08be30bc732be9b6991ed770bbcef72c0d6fd248cc140bb4901f53e13ab3c406d5aae9ee38e89ef64c8b44e070c13495653d9032c5abf52962e65e3c1d73d41a57aa00896935811616106cd896b35e5edc5322497d6dcbdd215946ea6542024b502673862f4306f13ffa3598515e2cc62a4d7d1db815cf9d366bcb64f1a850a95540d60c8c092a9394c8ff5cbc00f37c56841da20a1dc07fd9351cb34f2d55aaf3c7f6a400eb3c309fc24dfe6733930e65c8ddd51e0e95d57b7eac6f217a3eed52315b655b9b8e9c26335cbf5616e0f13fe5ebfe408c80a83756035bedc54e807567645ecdd739c6152f30af9c99a4ad4faaa195d6b529fb5b29d91a690f4cf3414c11c00a7c3206e104d957cdc6ff6d8a5d9b4b00305aa6a568d865b0fc262c193b4fdf41679a9569d9a2b49d3c0399e590ac736dda4ba086eb762ac751e161d0bea2ac25ed9dc2bfe7f2687cb846247e7b35b4b3eafac824b0779e3fcc2faa39d93655f47d59ef6d50296f1ac513287ceec6f3f72a84e4e840dd2748aaba57074a176ac25ca05e4344dca1393a95e9df56549c9d75f449d735597a3019f3d53151bc9d745d9aca7a7f5ccd1faf16ca0b95a684ef3cd5cb7e2e5952c372ba4cc256b2b49dcca95a16c695aee05cbd87e55e9d395a4b69eacc5eb615272b4684b49271fd2a0e5072b49076e9d56da8214ad25538e0e56fce526931cad08374f8181568395a4b6548ea9a6a4cad7050bbd30932749a9cd5a0e49a76938bd396841d2651a7766e57a8796aedafadd780c92f51f5e51adbb7f7631d8a1a07f6af3669bebdbf4dfbef62ae0744819f6a2076765de66e839bc5877895fd4ef841bcb99f0ded1157bae400c5e875d63c20b1a990bc4d739aafe187fab907b59739a1aa2216f5245cdf98808bf31ef158f7954e9d61a07f582ba2cb2c3de88feefa81754057f436abf6c84a8bcd0e96a8cbccf55df89db7e2a1ad9029404fd54711e1b0bdfc912e4092a657b3edaa263a0ba01b05ff02c9a17f6f83b56cf4c41bf250685f0d5d1a6d1d6c53fbda894d996abfa566d159b03810c0df9e0735b844def140f5094e10e731fedd88aaa27f4dffa8e16ce9cfc2c37acb6af26d372be74937f61fe47cd1d1a17a6f45efb582decbb2c0644ddb5ce69236e0fae19dc2143ef8fce77e227e7a59a73eedd7c8586ef1d392aef365be3aed29abb35396371035d874189b767dab61d1cc81a015f43d778dd9e99f3c4d6e5dc709f31291134b0dbcbc91d60e464205e2d621a715bc32cdef67f28bcd7fb9eca8253eae9b9fb8e102f02d6d366b7616a8c772d9afccc5e3b3eec3313c19597591e6a61201c0b967fafc640bed5993cd91480fce8072308df68ffb63e64bcc5849c5a4a834083d5327ebeaa849a97e2841b914f8cdfe44989629b8bcf4e45916f196c2e0cd0a3f040ca8c4eb86c45c589
2389df591c1727e1c5f0b20fe893e4305bec81dad619ebf93de08da79af41b8b065a18b77211aac5227fd1ed921cd5ba074560bd99eff050e69d3f17e7af0303c51df50aad65c6bb0da2fa77c9c6c4dde14a15f8f4d7fbc8e94aaff2f21afe03cca52a19618854c4ab9cb738f9897676f9c98d1fe93a9b7fceebb159a6f434dd0998df4dd0005ffde140666477ae8a1ec2a45cd59f25818ff7ec7873072b98306287e393870ea27e43a0e9fb9a45a9aabe3086db8e86a5631131936fa65c4d79f336d0972725c414603a696db883c8b76219cb4f2a37016151e27f09aa5da53557bf03e7754b32750aefd929ec62b3f16fed29ed74fce0999e0fad1fa466cf02caa9fccfa1988564b3a723192567e7cd7cc6f9c7a3254d5be23a3ebcd76ef19febcec0e72aeeeeacfdf994d83d672e49af1b6f57ae3d009eb415e43cf8cbe0a8183215d18f9075746674933b0fe489e7a60af76dede6dbd4bf2354a5f8b271d3318f4073ed565ba5b795077b63a0efee3a24028c52f4dbd1acf48b9ab3fbd136ded5d9b7ace6dbd16a612a55421726ab23e783a7b9b899cd553c90f33599cd2fe785c734bf518a0bfac3b5173b91adcd2abac8c7f27c93b2f84b8f7803aabf13f83c350d29ad7bec984a71bb960f5b9f47b4a7bb14f9c139f71f5a3f492dde0695b2db4c7a87ac62926ca4ddb53d0b7799f72637f917254956a861e719fa9b9bbd67e5f4ce1e3985a2657cce4cc2faf1a6d4030a8e39a775e0b0a152be1ce7ac7e6ea6a319929761f2e61ea4de64d56e7d6e9dbe73662f3ff594b2d7f4c62b163d5c3834f6c9d1c590129469c48dcfd721c82d3d467bca2a6b685ef2da2e4d6d1d5b4f7bff1c8c4d331ad0623faeaa29699197d6f12432faa4e31b446ba2c862f3e2c6f8dbb5957ad038067ba48bc15ab857969f75bda66f54a4fc05b75c0cd4dfabdefcffb24edfd40784ebde30cafd504693b876127f9f92d9f89f9e647944fad86761e123349996cc271fd9583f69d632417a1bd4a93f7061b87dadded5f9e0ed2dc7ecac1550606b72ec19973bb3bccaf90c4136e2d20a6961dbc7b7d9942ecb2efc3534d43e0beafcff6636e5de5f067d9097e35e6bb1cdf935d9386d92fe400b9bd571d1b09744542f6e3f1e0f09f081727a5625edf94d76074e23a8910bcabb1066655dd55cd2a50cacf717670a7673854b423358a66b6176abaa9a9659bb57bc3909e50e65efe08644cb8cfd8adf4909df9c9ef3e9be032ce54e4f8082c3582aec60eabcb4348c7665abd2dad95dd9776f4e9710ab8a771bfbf5aabbb9df4524426e83a9058260e9e9e9da1b7017c257dbb1b4ab6018c058969cbee1a93c791641badd8273da71e0a0fd37ed181684ff17834cf74e67eaf80e618a2e372f26cb623e8effaf935e47b51d5f48baf01e4f2f426fe272bc357fd3d23823ea0f6f397d897b16ecc2700c1591846042d120b9d3d7165d24108df4e104212a12186ced155569bb8430ae56fce8c47ba907dc65fbfe7b126b55a5da61a4b8b394ce1ce963dbe7c3b0b69d793bcbc319ee2d57339601e2b3afebbae81a8de99ba49413bae5d6c0bac5967f3e7ef2e6d4cc12574a41f2c6b77207734a662656c9d2abfd39dbf75843bc374db6e1dfda3ed016686a11d11ad86c69e8ef161c29717c07d92d6545593347bf72b04e6cc995f32c2f52a8fe9b683c2d92cdb2fc5770f62383abf96e681bb30755a00ab3192266def3a2ea3b0143538c3b0dadd5a6219b0ffe210503b0b69564b9594e53e45c85f20667bb140d1dce2bc84ef3cde7e17191d36714ec3eee57fbe979299e8aecd4a771eefaf8e5bf26a52d3258f953a9c9e065cf8e0effd1690dade877e4702ef623ccf61cfd8cd94fcb8fb0e9dde962b2f3c37196cf65723d7a98734869d3665cb16267d248fba6f236299b3582fd2ceac64ddce63af7c959ce60162b495cb7827ab933e77ce3ed1634b24aa1b4ec2736b4717a87fe585ae5b8726e8946496ae75ca139203d84edc0272ca983cdadf6052f01df33f971378172e1538533018e238ef3e050dd75e78a2760d88b028b323c7bd40323a2af256214668e16d1f4c3ef4c8acc08620bf95a47e67f363119f803b20e1d16b8de41ddb9e15c385168f4c6c18471e7b02a1d0ec7d05855b793d38daca9c2fbacacefc21f969d14391ae59f18a523eb8cf592493f8c8a978420a52f9030e40e5b6546171a7a89d2a063c0dd28c12abfab42cb1a6e92a05ee4101e855474cef42519a203e1380d422c59fc2fb972d0ddef44abb89ca66e06b6a7ad9e69b27eac702e9535fe838ebd42928452ec66fef904d049c4491c3f8516fd85d079e4591f52040eaa96331253e53cad9d7b6c4fba5309b8673879e3d0d350727d7a941fd7a547ab3c8413c0231e95031a3a5a8d2970f58ce4a9046fdf4d1d8c6dd67e0b911aa1c1e5ad7a9f0373879ddb40a6aed3bd170fcacb9ca8419f64fe0caee9b7b4b81cac534cb363844705fef28f8f844cb768365c2e18bde7f681758c31c2f7e89348bed16768f68c3db134d532085a4fe8074ac4d2f704a2e07c1eaf4b8e73e3590de957db0c5a557b47948053d1f61808c7f87a1ab2ca67ba0580aac7c4e6a968d9a5b62389eba7ed0cb92dbf0fe269eedc5e5d50864d79f72b4ebcb2c791ed874e641d2e1ed3677afb5a634837675ede47b7b688f03351e6263feb0b141163f0acbf42254d48ab4862ec3ca1ff7be8eaa1972449b046525c10f03100083f5d15d9c6b9ad44efda829e9f767819fc4d53f8830692001eeff09f2c003566ccb19d67fc7ee1c277d5
24b99ea9cded522c108e063faaf48cab7c0fe57cad99a883dad9a65663f856531d1a57cd871ed9034c9b992bca51f9eb0a579bb2ffa263e9c991f4ac2cff926884a74f5d7a40f5a30980e315e307bf1ec69ecf18cd5fd3be014ae322d7c1fac05275ccd06177a84f5769662cb2ba92795a7ab81bff97c271182b314513000311cb8409fe7f06eba71ca772071a2b68645395bfde393a25c52762e57ce927d2cc7d4a385997989f3e5effac3a9bb1683c815f339a3d7d436b89a144401b8ce152498d391a66001734f59f7f4e8d01a78e1ccc16c34f83db1d1834d770387561034d6bfddd0769b60636924f4a4b923b3365c6611ead96a723dba38847a57a28592161848bbc4026d2d711da467b63bcc272daf99ed45ac610136535f08976d4d1ed8bcb5f1aafea8c1388cd74ce2872364d5209a3dafe862175718b5c3c92b8799df5cf3dd21d4138c9014e37416c137f68277dca4ef6a13147dc609c4f4ec543cee6539063b777b7ad2cad4f444d4758ac72e95da3f35a6e2f2433dbd91dc79b912f69629b62591bcdb8f2d90b368ad8b5c4d52e47532b406e542f55e1dc3c9744aab89d8443a96b1f70f2ac3f2210f22f4459e64b6e679a2b84195c270ca4ea9774caf782c2ff1f85c2ffb89b8eee70a9eabf4f1cad7bd8343c6d23f23b46c45c062aa56591ec191853bbbb086f952342bf796895d734958bd58968aaeee9af6b51d0e98f79ad8b562c661ae970a792c26e958622c5ed9c598f124d1102931e236d024b69c7405e7f67729c73714ebdf1ed84dc059b94670d68ad4ca690c1e5c3a9490c9225e514b22b300b9ed4d900716e894c1017358a9bd43094b80e47f345ddd5b0698e232a2b2f31d026bc811e3c7f547e9ecaa618159c3eb865bf88488434399fa0f216e3f39d81ed986b736cbbf0adbdb8ddbbb64135f10305efb8ad7c043f9db2aa8e741d2547e16761ec5c0ab6970707799e3e536f57964dd718cbe147e3359902aeb6be2c5c6b37083d45aff6a2e93a8152d1fac19e1f5b7ce2d40e893f7b8251ec609342bffc94898468ea4f386e338593479e470767e8fce15b234753ec5d64cc20ba9b744fab3a20a52f112d7ad54f89bc265d63bc14e5ee40c0c13c965a337ad4633450b45eef69b9a9a2fd81245cdc4754ba89196ff43971ff422319d4f81f9f47b209da5ce55bab5a3d178dd388ce3f428810ab9432e5606e2ef63857232c74e8496b852bfc2e31ad6b82306bb43f822fdae8e40d6b5d198b2781a1e986251150effdcadbe17c20542f700daaacbe1b425ae17c2345ad77f5952b470dd6b822565affbe00bcd80af8b2d7050056563534399e2adc8676ed944446efe06ef632d69e35b0c65feb76aac0947bd798dbd2f90c67e55649a0e903cf4891c3ee92181ab572aa1ce5561e16796dc09910b2de45af85b176759fc7efff0c6c6ff25769fe5682d563fe653ab520f21dbd7cdcc0796c5356cffc8665d023195687b8f69557c9cb40ff47e6ffd0279ee005137bb771add49b376bc0871a48de72b885f15b3f99374990df5e14ac0b0de32ad2d018e8b7deec6a2f43e0aacb87b14e727e1ae506f1d065f68e516139e05def1f62f72e17cb2d99a8dd22cfa3f584a3e796545f7415933b1571753ee359496cf59520a8ff3ecaadb5b00e195094a9026e5fe6ff2216e89f4ef19f63de604e944f92d45eead69ad131b866be9e95cd90615d5dc74ba4a75a48b5b8424d6ecad86c0e2031316411edb9e388e3f7b840c55de752977389fabf5b4fd6a264bb1b9cd6fd1345067f0d1e7ad5335e937e6d18e00cd7e06e09cf5b8b5df3cb09f3e966bbc59bd7102b8e63b8d6666c0573bb244387726d24f8ceb28cb79f94a4b935209256a4db35ad37862c4a649b1517fa5c169ad974d8cf51856056f381afb1265b68e114932f63b06a0ad7ba855b1649d635a7ff2bdac7300d6f27cdab6bd652efdf73a23a61807a8dd6b68565640dbaac65273d118451f8ea21d3e3cb391dee2d9ff1c557122000b7945f239afe5c2b6b2d3256d6fb4b9f388f5a76dc82174d69e5b9b6b4361090f08ee138bec5627a8e389e52e0d1dad527741c0ccf975d2fe8d1397e9e7ba1ac794e31b07a1a246ba87d79ad8e94cbd43ba9f497abe925925eba439d35f8ace728ae30a68d29d8f782285bd0051ddaeb72744424a8822a4de89505402a4dfceece57708410dabda40c7a138f80d1c360285dea3a5664dfea1b48bd59da71174659678d7f7a4dc1bffbafac3278780fb9828b7ded2cd33e8dfc6c3f9c6b9d3b46bd3995f092d715085eba8ac1a9df4c4a30d773e9f02cfc0df9d75aedf610d31421cf6b95695f864ac81e5ca87570cbfb8de3e17ce938a8b740bf8b1d256652f909136a5d7ffc298a306daecf4034da974f3d54ef1e52e910a44a4bd69b6f7c3da6ff8c1c77bffcfdebd3184dc1759e1c367335c94382446f58af6e0659a24ae949e84b6788148bf60555380fd21dbf4baafe1461ae2de00150483af1ce96b4d1f79af6d51d85f7b5b2ff5c6134f5ce2aff061841860474abc2d955c9e8b904317f4a7e7e5758028d84d73b92676de12620a599a348399c821a96ec635e5355ef341819247699556ba13ade00d2d1f96fc795dd8d0b695dd80634e2ff8a8ed3e131f093aba4c1379f762879a7369b8034e64c14f8b54b25b30342978ba1c10e5d0f4df4de176770c32ae54fe22f5c0ad3061e7d2a777a8e0757db03ffb734d9216363fbb8cae50a5e88f6f2fe0731fb01ba650a62707473646e6d616572646e650a0a6a626f203020310a6a626f2f0a3c3c
2065707954624f2f206d74536a204e2f0a462f0a33747372690a3531206c69462f20726574616c462f6544657465646f63654c2f0a6874676e333731200a3e3e0a657274730a0d6d618f659c7830830acbf9f745108e05fb8aa41581f545c11550713bac41a0883411ec14c4a6bb1137dfcee06aea0f187b9911787c2e58114402262a3092da1b0f31235e518e6ecd40327cd563b77194025e323967cd3628f8aaf74107c4aa42c95e85ffde05c4ae2d0543fc7faae54f130c4135d68e8f8e87186271706b26c5ade3e537aadfb252a3b6968d0a7f3500bcaa72a0d76239e99d319d9673b3572652f587e64c6df08ebad03e802e0b6e650a43727473640a6d61656f646e65360a6a626f2030203c0a6a62542f0a3c206570796a624f2f0a6d745333204e2f69462f0a207473722f0a3531746c69462f20726574616c46636544650a65646f6e654c2f206874670a323532730a3e3e61657274780a0d6dbb92b59c0c30c36e057d774520e834b72ec3d44ae3ad0f0c041028a5460c82d9a259142d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
13uo_amyuni_viewer_600.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
