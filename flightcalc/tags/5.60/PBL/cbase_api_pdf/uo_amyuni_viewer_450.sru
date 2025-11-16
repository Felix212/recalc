HA$PBExportHeader$uo_amyuni_viewer_450.sru
$PBExportComments$Objekt, welches den alten Amyuni PDF Viewer beinhaltet (aus Version 4.50)
forward
global type uo_amyuni_viewer_450 from uo_amyuni_viewer_interface
end type
type st_4 from statictext within uo_amyuni_viewer_450
end type
type st_3 from statictext within uo_amyuni_viewer_450
end type
type st_2 from statictext within uo_amyuni_viewer_450
end type
type st_1 from statictext within uo_amyuni_viewer_450
end type
type ole_viewer from olecustomcontrol within uo_amyuni_viewer_450
end type
end forward

global type uo_amyuni_viewer_450 from uo_amyuni_viewer_interface
integer height = 1160
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
ole_viewer ole_viewer
end type
global uo_amyuni_viewer_450 uo_amyuni_viewer_450

type variables
PRIVATE:
string is_LicenseCompany = "LSG Sky Chefs"
string is_LicenseKey = "07EFCDAB0100010054F8D2FC113CB30685B5B09B4FD592F24D3E54C766270EB6AF17AACAC4C103F4AE292D1570A8E3D4C361653480E8"
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
// Objekt : uo_amyuni_viewer_450
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

on uo_amyuni_viewer_450.create
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

on uo_amyuni_viewer_450.destroy
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

type st_4 from statictext within uo_amyuni_viewer_450
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

type st_3 from statictext within uo_amyuni_viewer_450
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

type st_2 from statictext within uo_amyuni_viewer_450
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

type st_1 from statictext within uo_amyuni_viewer_450
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

type ole_viewer from olecustomcontrol within uo_amyuni_viewer_450
event beforedelete ( ref long ocx_continue )
event printpage ( long pagenumber,  ref long ocx_continue )
event savepage ( long pagenumber,  ref long ocx_continue )
event clickhyperlink ( string object,  string hyperlink,  ref long ocx_continue )
event refresh ( )
event selectedobjectchange ( )
event objecttextchange ( OleObject pobject )
event contextsensitivemenu ( ref long ocx_continue )
event mousedown ( OleObject pobject,  long xpos,  long ypos,  ref long ocx_continue )
event mousemove ( OleObject pobject,  long xpos,  long ypos )
event mouseup ( OleObject pobject,  long xpos,  long ypos )
event newobject ( OleObject pobject,  ref long ocx_continue )
event activateobject ( OleObject pobject,  ref long ocx_continue )
event loadpage ( long pagenumber,  ref long ocx_continue )
event evaluateexpression ( OleObject pobject,  ref string result,  ref long ocx_continue )
event processingprogress ( long totalsteps,  long currentstep,  ref long ocx_continue )
event mouserightbuttondown ( OleObject pobject,  long xpos,  long ypos,  ref long ocx_continue )
event contextsensitivemenu2 ( OleObject pobject,  long xpos,  long ypos,  ref long ocx_continue )
event keydown ( long key,  long lparam,  ref long ocx_continue )
event keyup ( long key,  long lparam,  ref long ocx_continue )
integer width = 1317
integer height = 768
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_amyuni_viewer_450.udo"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
06uo_amyuni_viewer_450.bin 
2F0000d652e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe000000040000000500000006000000070000000800000009000000130000000b0000000c0000000d0000000e0000000f000000100000001100000012000000030000001400000015000000160000001700000018000000190000001a0000001b0000001c0000001d0000001e0000001f000000200000002100000022000000230000002400000025000000260000002700000028000000290000002a0000002b0000002c0000002d0000002e0000002f00000030000000310000003200000033000000340000003500000036fffffffe00000038000000390000003a0000003b0000003c0000003d000000470000003f000000400000004100000042000000430000004400000045000000460000003700000048000000490000004a0000004b0000004c0000004d0000004e0000004f000000500000005100000052000000530000005400000055000000560000005700000058000000590000005a0000005b0000005c0000005d0000005e0000005f000000600000006100000062000000630000006400000065000000660000006700000068000000690000006afffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000001dbb019001d2fee0fffffffe000000000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000665200000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003525ca8d84aed81ee4d9c5cb90b98d5ba000000001db50e2001d2fee01dbb019001d2fee0000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000003e0000665200000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff4c3776214290dddd349063e0ed2fb357c202b0854c21f26b60c1e6d7e6d1ad98c5570e7dcdd2982e619bf530ccc336e6143c466de7513f5d529d7cfa73a87aee1eb9d43db30f5ceac2d6e19282c2d6f77065f021cc1c700177985afbfe003f9a2ce3b830fbf016ff29a2edc18f30dbee56d5e84984c1aaeef56c881f51529cbe2b04047fdf2f66866c56f2e7d6a53affd0844250b48d0850f4ac65ee1d6a7db25f6cbdcd421f3791060d35ad1d7452eee0ac82388155c047e78e0e9ba48c1d2e79b987fd52151ae8d25efe0cbdf2f5cb8e999f021571cfcd062c15a8a573323f242a0ea870ebcbfd4bba874d64e6a7dd519d4075b556ea2b7a3a09d0b9f9c73bb5cf57346139cb7050787c688109549a549c4b32a5ddafd96b0ed01d01856b8f2e3c58718b4f149e88cc4042762ad88a9f625d8812ee2fd8bf62fdd55db43a44272d3eda8cda036b6ab6d1567784bf05adcadc357c1e08a4b8175c19cc3c707e0fc872f15b8097701cb1ab0ec812e2a64823e047438ee0c9028424fccf508ca4908cf508235c846b69f022e40eb82b4952855d70c4c95cf169feb43b0e2e025a35c806a5049edcc0818d34ff1e94846be9487a527271d6a183287a160ad7001f2779638e80d501c12996513f138077945669f959a14ca267cab392ef1270f88aaef1240f624fee24a1beaea56781094287979b36279747973be6ef96ced19dc3be6ee7446d12dc25e6ecb449d1f5c3eb6efd44fa474e1d3e6ef489d347f61fde6eff09fd9ef37b7e8f9ae7e69bcbf3359b7b9b3bba581ab94ca9837d51430b0574181e1a18d455153d93261be0e59c30027704efe0fc871c83d5c1a793c704ebc9fbe03d27f7204fd413fb9038396e0209f8de01fbe02f157f34650b31a32b2751be4e5a9fc0c1ced9549c1e2208d0d29db83977fb6838e09a7f2869f6c7ced5f001fcb096fcb24f2c5dfd42c4fe0fdfb8081c3b2dcc4ca50a5bf6055a297fc29c0bae0e8b718e80a62c394107ef832d0f6e05d70a5b9e38316e62cf4f3c09f912b9a793f36e5f45141dbb2392a4d99affb0641b3f1e911b99fbfcc1f5f995bf86288fcc8de7fd46ea379ffa8fa8d3bf40248443ddf1eb19da2a0fcc06fefd063e834b7dd687a0d9e9af601c22f98d89cc27f1f512fcc79f7fd41ac53dffd411505bffa8bea083ff20bfa83b00f3df489589eaef03ea5af9237ea25ad68a63f3afd97fafd7d7ec5f7a0df5f8d7c303bcfbe654d13ea6ef9871bf6cfe8fa911bab6c0cfe0583c13d0110ff4973e3c02c4c100d7582cdd60d8eb074608e5f04076fdf7dd60302fe2cff3f869537f29c8c1c19f0d83fe9a78731bfc217bdb7a039e0e6e280f7e3f082028e1d50cac1a3f847fd691bb107fde1421443fd208ffad15ee1a1220f34e5c04ef78507f9592c1e10687d5f057c2364bec25441f960df7abefdc829c856c960f25837be07db04357783b4a30b15d60d55784c1bf75a108a34251452ff85cd27bf9686ce2e567086a58319e5f4e9adf42a784303f21cb860d3e5ed38895a8c38b183fce7da2f4836683c26b306ed3acc201a16514f5e7591bd542c4286846f8603d1fdc45dd67ffe530703a113b838d19167e7ffc9208b7c60673c27ffafff29f41ae9d102192b1ffffe83d1cff88f8555e10c8a52e1fe834c14152190443257385eff01fba801e49eff41f04ffed5929ee9598492c29430e52bacef5a5e143ff90a207fe58dff41e06ed2cf2bc4606ba4adb8a08eb9bf8a68ccff29e5628610e8a63e0eadc293fc67641cfe3b39e10ed797f29ef25768864753c6d035f0c5fd05759858c261cd616f5e124590eb4894ad2458e8ca964d28502952a5248f25792255995569d2a0caba952a34a22af15440eb2a42a52549f8d8ab4c8d4e449976cb8b3cfa9f24fa84cab0451fb80cef0084d226b8501e2a7f35a6a137326a075308d2434d59b50345fb5501a6a17b25b2e20dabbe31b6e403512c168c2759a50203cc07babb021c96ddeb7d203f5e1a6e9d6d9deb786069b862b4d452fcf9f03032e68718784203a5c7d913aa7deb3bd439b94c53c783ffd39f53f051d75339ff53bd39ffefcd36f707a4f0325682a06dbd6dbdc647e6b30348725e2e09ceff0c0d810fd312db4107b91378439d11719ee7a69bc7c286ab9db1aa0ba44ad01a3aa68850fb6fbc214355666b5583434c80d50defa6305e95f280256873c558179f22b6f9d5ab6809f02d500695a58450f88a3e2115bf21e80d56fcf198d91b0874c21d46635568798d6428d1bdaad2892950a26b7b26b46f6155f53f158f9a3871728a1b4eeb7144efbfc60efb1be449d75a141500e9d41510e7f9fffd4fffd4d975bef1950975587f13c2cb8cee33c23a3031d7032c2b86fb732b7d039eabbd8103020b40f563ac5c00d057a5ef0365c57d365f087a7855607b8aef6075f143ff484578b4a9745efa764b058ce65caa5ef285707d35784662bf7db6f4ca6b4ef58eb6b7c6feb4d6fb9f58d0ffdd1a6c6d2f4d63d6f689b8a1f5bf463f14d5bf44d298f5bf4356fb18f3715345dabd92eb5a6db5342f70f9c5df806ad116c1dc3a1bb976a9b98e630a6e0de741c5023cc3edb54da5b753c2e80168e0f40369436954ee022d06c80645a79c8a163fba0e4c350a27e3029b6432463cc153ca72b8ce776b7fb9fd475daed029f5fad277add7f4c075bcb34df9c1ba5c2f33006ea064b280c66ea30dbd31d85f58e5d
26144b69bf63bab9f9aeb3a475dd7b6eb7753dbace6df5fac22e7e6d9096442c74bd433a879da1eda191213da1e4bc5c1633b752a06e213ff45e13503da6337f0787ae6fb3e4d1fe10e96bf5baac0f821f5cff9705da6a7d6aba108692062ed0142c8a5e642ae0c2e02707cdc1ff02ffa00cfee0b778e0efeedff83374b828f7072b87347d38674ae5bf4e9caf42a296d8ec55c9c76a2b64cb715c2087bf9c3e7998ce1f341aeb0f970e109c2a1a6a57d631bc008cabfe0c3af701dee0c12fb83157055c099f5f1ac1b5b6daa7430a6d68d62411f76a6d6f5104414e1db75ee9d3d442953615870251fc29aa807847ba4d53047aed01020b016bb9625469eb6be90b47f1382806d1d8287824369a12466423e097bb5580e7e420dcf225f221f812d21cfdf300723448144a97238272839e6a449c38825f06bcf3f9299c79bad1bab9ba99f21ea875a3f059f2e2534133ca0f0514d03674787b559f0dc00a15f4041d30c3f0c91ac60bc85dc2f5e12926829b8f4d7b5b7477c8bf73444dc7ee84da1a115016508613f53ec588abe84b82eb4647da47f864eaeb48fd48c2e3b50679c58b6c76a32b246312289b1a23e1d59b2efbfae457187feb8edd7e7cc6a2c179d19d63cd8bbfcbe6ab81bdb78ab7f8f1763a7fa7ee6f4bef83f8f6d9e83287d087d622c3f249129c02d9aac541371f0752a02c2740e81ad4c4e1a8de1f92db3e70277bfd776b25bb1936cdd86aead9495e2ab673bfeeca4663c3fb6cdd79fec75741b9ceaac2f5d3bfcba6e2dfedf637863abd8df19d15bfd2f35e093db606efadf07b464f00a7b1d03912fe46de257cda2f1cdac3a3b539a9c5dc75de78923183a332a8e5a745667e6d1927b38d9f5bd062e10d46e5c6ef1f397462ccc14e866d1dcfb79d3e811fc9b0e7329ed1c8ec740b6ee10b147a091c312487aaab658a36ec2b2bd5adf8abd2496addf2d6cd4653d54d497b1f6f57bdb424aa5b57a2d5cb2a93d5be5dae67d2d52f7a591f71f34395680208804af5d555de7dccc602bd9110e602c0ee2b713e1778fd843c458e3ea00eab3a52c17e74eda34be023d28e2ca4aed33e705b4122bf4611cb68fb8e853f1ddf480bd13b078a528b5396a229aca4cad42ecfa95aea9de357bea26a3d26d577554f7756da56c7452adeb2899e518247e72b28695a8178686b856965f99f8dcbb645605322a2917439fe6bc24690b0d5d5d15c5c43084ace135e281b745fb0868b0cb806b17175c1d79c93b8bb3fc11dc843f1af2109ef73b83391d5faeaeb42746508b6eb8bf2cda9c61499e58ca64c6127f15ad92e5f5dc2b6849e1287f8e35015c233dc741146482a85707850701000d0346c10b0868beb8bab315111894c50db11d625e3193b156d9a2663513a8e58768eda2f457220814c1f630f4735616dddedc9e6291dcf9f8db4d990848e334a1108a1231130e609edc7a8a59cdcfb75a3198968e5d398dac8311170bf22569b5b12b458ebb3100d81c1162002add89556db2ccf3c06972257a920a6f1715ccc732a968dc387500d9812b26e46ac78e12b2bd8764daa6baa12794040ac778d22f0f1da5bf6dd0ff5dc2f95db338bcd78ebd5dd724899657c7a69392ed9157676b96e21f14be761a81d3e7b63fbcf783bec73ffcfacf7bdc3e71a79e86d687c3efcc178268d6187b111a8834ee8ecc66138aac53e9cbb9c3b723c9d2701b24e2a4311077d095f0583ef1a8a86339021427882ae345ff8161844af88c8f841c876b82005331609a891e11d2ad44ffc61d031473ea8c5460c1b7b18cd945dc6fd8d72e8de467c11261ca9b930aac8f2b9bab0c2ca2930ca26ba918ff439a91ff8b3dd2a9314a56896ed3bb76ac914ecc16c4013a592371a7fc717752d065a8e918f168a46bbbff2a7452dabe478123eb53df96f128dbb87f2263f3e038b1812c3a5463053e3b942be1f736a724982e7a70e9e02a72a9f467a8bea949edd8fd239a42c09512596aa97e3d73a9639d699d6a8fed61f99e980f0c086d3ed691c578457edbe74bf3279db7885ff05f008e606c336dc12eff0e5dd9743b5253aab7ad4eb5b5cb35c9203db1da38845d38973a5c80445ce7a7e00e9d17ebc2c9156a1ba087d5d562b87ab1a9f27454ab85ddb450b8f6ba778730eb88b77713095e744c3ee2a77c21ba9fe247ad2dcb2c5f0b5e969292c219655060516a04a02840475c02fc0480576017f04758ac7a67c3a4e5d624ed92f49c8c7239e443ff209c3fe5c45e9afaef89e5d54f902e7dba2b194c95bbbdb4646bb47eaebda648af76ccf2582d4e7e357b504d4c746445025342e312dff250a0d0dffffff3020310a6a626f200a3c3c0a7079542f432f20656c6174612f0a676f6567615034312073522030200a3e3e0a6f646e65320a6a626f2030203c0a6a62542f0a3c206570796761502f502f0a656e6572613431207452203020654d2f0a426169645b20786f203020302e353935343820335d392e3165522f0a72756f73207365632f0a3c3c636f72502074655344502f5b542f204620747865616d492f20426567616d492f20436567616d492f5d4965676f462f0a3c20746e462f203c20352031205220303e0a3e3e432f0a3e65746e6f2073746e3020335b0a5d5220650a3e3e626f646e20330a6a626f20303c3c0a6a654c2f206874676e302034202f205220746c69462f20726574616c46636544652065646f730a3e3e61657274780a0d6ddb51759c0c30c36d703b409cf512870240a081b06813c71b100d0283e9f93f20748a3dfa060411fdc71f13ad22da78a3
2A27fd44c58910f57c0e6f3df1653aa52234e399a6e047f53337c0322933a5f8392bac067305605b734e030af8e72b8ccccf76ab0caa801c82886ba879e97ccdd5e2d535e25c626bea1abca39a6024d4179f8a7e293d69e2d1766e0d7ae0b9c96d1ef5b3a83955c0f927e0b35cef8d16ecef0d17df8cf6755a816d4178791d0c9e9cfb3d9fbbc6fd623f171ce83629eb9b3c5be0e741f4cc6f3dae1efd84975e9c524f30dd2f8bcda8358c7ce7827ee54ced6b3366faae7d307ede6d6e09775c486ebf397f6e650af8727473640a6d61656f646e65340a6a626f203020320a6a62650a3634626f646e20350a6a626f20303c3c0a6a79542f0a2f206570746e6f4675532f0a70797462542f20653065707961422f0a6f4665732f20746e48465558542b464b73656d695277654e6e616d6f636e452f6e69646f492f2067746e65642d797469542f0a48696e556f65646f63302036202f0a52206373654461646e656f46746e5b73746e302037205d2052200a3e3e0a6f646e65360a6a626f2030203c0a6a62462f0a3c65746c69462f20726574616c6f6365442f0a6564676e654c322068743e0a373074730a3e6d6165729c780a0d6ecd9055841020c330efc09f6244f4c792f968e5f90f92aa4ef69d51c5216d6083e35a0b38e0bedf4812b2a9b3b0c31fd9f343a817508bb088a5a6f11a15b1ce708624fd7631dea37133ac25833765a5dcc9500ea1a463ceaaa3cee1c49df50acd8cca312c59d4079b1ee389f9fcbeeb14ed274de2069dc21aea2d881d42ba96f49c3a8e7cff50405ca1039df476b7780da0c696509ee689a8d5536d20d552bed3faefb6f81eeb754541fd7efcf53d7295e91e4029224cc592f732e64c7167283e09afaf1579b6e46a831b7f6e650af0727473640a6d61656f646e65370a6a626f2030203c0a6a62542f0a3c206570796e6f462f532f0a74797462752f2065704644494354746e6f3265707961422f0a6f4665732f20746e48465558542b464b73656d695277654e6e616d6f4449432f747379536e496d653c206f66522f0a3c73696765207972746f6441280a29656264724f2f6e69726549282067746e65642979746975532f0a656c7070746e656d3e0a3020572f0a3e34205b20325b20375d203737203634203035325b34205d20335b20355d203333203434203035325b34205d20335b20315d203333203034203333335b33205d20325b20325d203035203835203737325b35205d20355b20335d203030203235203030355b35205d20355b20315d203030203035203030355b34205d20355b20395d203030203834203030355b37205d20375b20385d203232203737203938385b37205d20335b20335d203333203037203635355b36205d20375b20385d203232203736203636365b36205d20375b20355d203232203938203232375b38205d20375b20365d203232203538203232375b38205d20365b20345d203031203038203635355b31205d205b203131203030353131205d355b20305d2030303930312037375b20205d2037203830313737325b31205d205b203530203737323031205d355b20345d2030303330312030355b20205d2030203130313334345b39205d20345b20395d203334203739203334345b31205d205b203132203030353131205d375b20395d2032323731312030355b20205d2030203631313737325b31205d205b203531203938333131205d335b20345d2033333231312030355b205d5d20306f462f0a6544746e69726373726f7470203031200a5220304449432f49476f5470614d44302038203e0a52206e650a3e6a626f643020380a6a626f200a3c3c0a6c69462f20726574616c462f6544657465646f63654c2f0a6874676e302039203e0a522074730a3e6d61657201780a0d16db8ba58414604214952a3fa074a439dffde248b92ff1af35af6b70b599be7b6b1ccc3730b36ff20e1592cd716c366b1fb1e1d9f5230f2f47014be0448fb0ed224c4366e5290d3a3670c5cc0abb7f347a5dd26ee1c853908a928bc943e6b8b74ad457c358c20fdd650ab3037473646e6d616572646e650a0a6a626f203020390a6a626f0a3830316f646e65310a6a62203020300a6a626f2f0a3c3c657079546f462f206544746e69726373726f74706f462f0a614e746e2f20656d48465558542b464b73656d695277654e6e616d6f616c462f342073676f462f0a4242746e5b20786f36352d20332d20383220373020303030373030312f0a5d2057677641687464693030342074532f0a20566d65432f0a3065487061746867692f0a30206c6174496e41636920656c67412f0a306e65637339382074442f0a31656373652d20746e0a3631326e6f462f6c69467431203265203020313e3e0a52646e650a0a6a626f302031316a626f200a3c3c0a6c69462f20726574616c462f6544657465646f63654c2f0a6874676e203231200a5220306e654c2f31687467323233203e0a383674730a3e6d6165729c780a0d7809bcac37d9d594b679ce7e7d99e7d933efb326593324992440c9260249d84f8c06b289d1514404a0a96166c115b898d775b48556a2d6023161096d57d1ad80b4285d6dab6abeb55bad16d06d4b52faf77c92557c413339bebaefdbf3fd75ff9cf3f670f2f72ce70339cfbb3d2108c25c577f623e5562b6ae00fe86c8c80afabc15b127979dd5c8c16ba44e8acd7fdbe90abb6b5c0bc14f205d61ba843a269f7aba77a4ab942b2e38c8443f1bd5f5635da7cf2f2e968419759ae2ba6bd3e6d7
27e06f036fd7d5aef2a0ebd3e4d2fcb17dde14566b783574dfae7577af5f4f975dcef8e5078ae9f9965ffafa7c5be8b7822cb9ae2bfb4cde9f63a229f1c22f6a13971a7bdaa1feeb1be958ab527decff0fb9bf8681d5fc37bb643bd1ba4ed032a41f9c7d42383ef40e962d0336beeb57d142a3213c257fd7fec1437085ae55097d81177187d7923e8320a6e21185ff43c4045ad0056908279abbb51e60f8c1d210c908430d8fd37fd01d40b210ff63b42bcc0dcc0dc8445b9d3e42317307c08f58119b85082844cf8a6f4b750983c2a8416af216507bdccda102794d08cdd0a9a15987d0e9039a11b30eaf3af321efd6a1a11abf34f9d3f7c54128a366f43aa19f822124038b469464fca3a66044404827db7a0bb83ce0fc8c8dc8dddcc11ff8d0e1f7029d59f8e3588f0a0d61927e355d3f3b40b3a284382913b45ee85c69d045c3405e8e863d11a8ba2b501ac742cd1b40641ed0886bf11b1d346147d8a2813d899e5f0f0f40581cc5d1b7a08fbd07a86a04a24e3361ef42750333b48dca3b21137e047f10fc6dba69a0d2d430e8a7e887cf1abeb3434f3ec14e09490f8fb7978c4a07230b7f1d1fef403f525ef8c8e31f621b34a38a1320645df45e57a157460a52cfc7e3d12b4611fc7af8740ea20a6fc55f3b26835f1b77e803a3736209b82de146d1357401f57628f5bc13f1e1e03f417fe30cba31e7dd09ba5a441e3d069b8ca4c30142ec26a017431494056879c6de875e29ce5c16a9f1f1e3ee400fe39233e8e312732f22e68523f44ee8e5a0c6cc08f4fa14e89b2ce2d6070a7e01febfe35f9edf416f0ab47ad09acf41f5099f77831f39708746e20e272ea072d98065085a24f86ed1db1c743efe3c36e13776e79f8cfab1990b6db8eb71e3e32ffc812d18a8cf44ee1ee0ce37c32f81d40c1d6e217009d7e3efc237a31587a157086bf471d1307bc7e8ff40ffeffcf0c5c27a40dc913f8f17c7f43efe31a8fc854596885d16eea04ea2c21fa36f5e80beaa5fc37f443cd435116c24bfc67f8f4e128636e60f5bdf42a6687cf6a0a55876fbcf043441134a309b6a28c00e117c3cf1e3b78d5e7e10f17b444dbf1be4dd24127b806e635f03fb8d93e3082df23b25a068c377c15602ba31ed9806e09f78c1ef57a12f4070c70db04de88c293273ff78e7874c99bc8c72516dcaddc7df0acfe7f6393b19e357d8c9a7ae80db812ddd0366127cd91db07fe157c490facff8b5e1b27ef3d03270339f5cb2e6176b80b703eee36ee3fdc97ee69fe1ef8ae611dfe2a7842b08df6315a478f5fb1a4c2df8d3afd08816154df038b9fa01aa0d69a81c9e0baff4ba3d741e77436d110f7cbd01c14f42edaf439fb877a1dfa0019cfa413e841271bf5f095f56eea8060f3c177cf3f1a7e00afc25f89cfe23fe4f04243e7a93548224cc8d32f0adc9ab938e4ddc9c87c937eb94bb87d9e0fae5dee41dc1f3cf11e63c0542e385db85b3a4d7c5c75a5b3484ecfd7aa968f168c8637be8db6c68ac6863bdd8d965fd8fcf46f8d17c95147fe8e9e832a203e5e816e1bb8340f1281279bd197a20f59bfe8eb04c33f5c4ef14001286a0613c7ab5586781cf0b9e10be2ec62cf0858159e14be02be257f87dc5e9be337c26ef89df0530fdcf61c7f8ddb6cf3c20f8fcf0c3e01fc09f0e67f18fe0709888041251cd4083926927b3234e9108b90b4813a4d59e43d22e9e3d0ac0364391f64ec2ce4de46e52b9453dcdd7057b94fdc0fb837b81097c2782f8ebe69ffe6afc45ff18fe66fe2dfe6bcc2fc12b7610ae106e882f08285c4ab12fde255e143f11eed4a24acfae94ad2ac690de97569051551f7180bf4f1c86f85af0c78b4b5fcac1385f004e0b612eb92633085ed5dc05926fdc5ddc69f1cb84c1df802eb92bb8db728fe335b8bfc9333c88bc4e5f9c43878e5dc498f8e340ee7247f229b785fc8623e405e18bbfe09cdc9d219f8fd222346de5bf08e802cdfc68dff240878cd912cddc4bc93fe3cddc1d84934383b084f8f8051afc4e82c493216f5700bf4bc1f7db9257224abe12d1095d0af8e163fef329ef985acc5c36e440efc1bdf26173efdf1a7c7728e3520be423e46e4fc39212c51dc481bb82343e07be17517e08f8298c210f17c71ee09fab0744cdb8f4403551c15406e0df882ea98da834e1b118bc2c9a72568f159ee4418c59736d06fc4a00ce1cc28dfc4ced07016fa120e24ddc348066d340ae2df9c81f744ecf6333fbbc2d8952740edc25825708f6d419422e93435e4e87de37800efa0967818740aa19436f067eba3f7202af0fbce4173fb9f84341275ac6942ae80e96900be82f5b2c81093bfd5f0e5c57ffc817e137ea41e36fa2bf30d67000e4b4f04a48067e0ebf900ea60ab3c3b761ea43b580f13df482d45bf00381a01dca803b63012e80fff867f39dbf68117e7b6482ef5e812f84773240078f0f1bc33c0a46cd61af41df9f433682b79f00a7f241b3f2157e3bded04af08c13a0cd518e57415fc1a687df7e345dda68edf8f3e323f8f968d5a3172013f8fe0f8c377f45b46aa2848b236832055f1422fc15f6e3dfa3e8cf6e41db3c80ef46fa27628a429f9e184708a7ffbffe36d08fd676413bfe31df08f9836404ad0cc15d0a7a2df30afe83461b9b36c8f363955c99f1de13a86817c7f1c2e88358fdc71abf18ae68b3ef24ec8024b7613e43e9edeed0370324e5fc3b224dfdc5ee434e0e844ec2a7dc05a17f62b8fb3b8d837d8fb83a857dee4ed08f1c02742191c8640bae0f5684e0e3e28fee61f1a8cc66fb4c2086503070b1954438ac913c8b060b
20fee33f15c9069e48138c87e82b377683ea706f79baa442d457d91f36a2715a5c87bdc341e11c07fec04ee3defb5bd928a71565128190f41b11901bb9768fce8801a2ef71dc290470b122fb3b71cf9d8aabf943afc0b02bdc0657b5f4680aa6f533dc17f020fc36a04a140f189833ec0e5ac3502a7b904eee071fe0c369dc1277e4ea3c70e0bd471e03db83b6f046478ee0d2e0fdf70e685af414f7146fbc3773ae0d3f047076dc1393e14c3cfa86bf9055dc13dcee7e52b0364a400ebee76f08411fc2cf0fe1045819f41f2169a408f77e90b3b8fe5a420801ff2160bc21db4807de10bfef086ef9cfcc08656f4853ddf7b3d6e05dc215d69f41dadc41f06e5f065c0079bbb1071c4ea5b77756c6115111cb9cc6ff655f392e9dd766d4336f28cd85916d25801a2f3b4f77717b5518acb305cc2960ab65085c2944a99275179d58291128c35d5d51ecfcb53d0702bc49d56b7c7675d458ceefdda1ecfb1f1a66795e0a624599e2f52afb1858fbe2a78a63e37c7fbd0fbbebeaff46fc303c3fd52e56ba763e61e8a75822f9707cdc0acf4fc669086a72ea0ea75619ba67a835cb9b6a66683531fc42936b264ed547554a5593aab1a848d4ff7ba8370a9eca9bc31c8a1c8ceca57b2ef444f844871f65f7e6ea8a3ef84392a884897d8ea9c8868c3833c77d1d55c4338ed904e0e77843ed4a92af013ac1795793eb27dd0af82389f26a45640adb4567d9fa406bee4ac01add61d01bfc87ee10d252bed294abba5f81fe42948c2f52e5afbc887dbc2a94688ab86aab9bdc815479628cf2ae2c42ce3e702a4a6c40b73cbbda467514ef50cf3d1072e8fa9e91a97311f69141979d2e5f6965d5c5e4634c8c1c30505e41a3045886a21425c2034cc4ae97cd82c4233eac4af8da99899751f7afd895d7236952f14a601578c7f08da77507ac266a9652ec9d60730582b16ce600e525cb27d2a31c2c4f6457487ca6d262ba565d1e5bdee6f0f53c8defaebed2f5b27d6455d0742d11d6ba70befcbeef753f91cecb40bc3c7637d9b8df05745aab9ef5a3bdde960375e0fc3d313e3709512deec776a2f5b54d2dd54f8344de2d2dc973a31f7babdc003c325756087abfe8f4830f5d8495bd0cd3962314e4629b61d62e73170204bcc4416abc47ab4e3a8bcf4e4795703dab2a4b311c54a924153a892ffeb1ebf2f0187e0854ef1693d51602f40954512a1fc74ebc038ee301a2b976491c8dab55e1edc9deff8437083d7138a9ee232f63d2757900454519c870cb92c2d7750f1e03aa15b107e88206f55a45321a0cb4b947911e56394cea7b2d986313f41e29658d1a8d153d6890467bba94000a6c2db05c59829b0ee60109fa3ddc1dadff59027c1163dd07b1aee6dc7de5f120ef674da72e8c8fd0256bf219a146fb994fb1059b1e23f6fa577cdbb15e857a7f077bd792ca57a7b721706cb838b030d841b3c6b642d9e83cf36d15dea13dca36193e15ca3630a266c5b326a0aca877553a3979541040a616081f2ee49c3db9ddc805e408102fb924830e5a0516727109ff14e683053f91e30fc400678dc8297693e81dffc63a51630e3a002611dc252f9060615764ca0e23690710c8a03a8abb2264bb3df18742633623f8cc41daa77674edcb029f6918d07103a141a08ca7b32953ea129655454d10ba60a28d05e4a43dc1efbe1370271014dc894150e2416c06720386bb4511f2af34ef5e5d0975400dbda17894149678a2c14a102ac61e1c6ed02f8de71b73d586d15df8badd0f6ed70b961659d4dc9ba78a2ebbdfaee69e6bf6e3fcd0bcc58ef8c1e41cd686dbccd78bece4a4f0afdeded560a9377eeb4a4622549580039dc001b9fa75340e4a1ba2e72feafd5e392ed77eea920af9506b598a74a1006c54bb6dfaaa2cf6c46cfa27228e8668600d8930cf5829abc05bb2881e7c82a80f9c2b814614a54c374947903721a30d6556d8f9a996d96ec454584061204fc83c839b097b9cfbf633323c8bcf88faf20f3eac43cfb184fee73f7024e01c8a4fee1a3e3c4543d8f2a8ce85dfc8bd58c130fb942a246568f587ae68fc7a3f41174d3aebf9191eff9d38a7796f37935c1945f1b8adc67951a306556a7c6b2fb4506b7f91722d19f6edc8a99062bd38b344501e5997d83454c2c55293070b192c40ecf9cbe45d9ff6583b67ca058da04aa5b27de342d46f71a36339d7c73ca62e336c12975a1796ae32aef86df0af962df8fb902dc66d8656f316f287fe6ddf0fc90f8c1df21e987f921e32f7c87456f955f19a7d57de9725be37bf50fc627f85f7d0fe17f25ff1257c2fde9b93636ac1de01f8cfaf2124341b51e7e3ddb56e4455db70266cab72ad76dbab640728cf3213c79f975356c9a3649b095e4430c107c44c51f7e7d5d03f2846ee80f8437146c953a2abb766ce67956a54a8a97f08d90ef08d434c506dc5afb324e4437d875010c553d386ad0c78f0ce064636cd603022ae0f94459c16a626a83133fc042275a32ac07e790c5b286ed2d880b6a67391394d9ee1e5823cc8b7f77f93ac5f9b631fe0ea5eb7af908233807a32b36892b21805083ce257068906629e1e3f7096a1c5fbfd16c72bc94e55742ef186efc1f9f6b95b985d1fa383eb7c4b6fcbf14f69fdc4b63a351a292fe7df33dbfeeafe51a2142eb2582cbe6449eb1c46540ff451ff8e35461d0230aaa65130269c697dbfed2e69ef80f8d7e6a3e351cc67c683db0f955a7733781dfb5aed9dfb36dc9d8b7bb80f708ee69ee0671d6ad7367789956909c641b88a6c88070a3568c3e31b183a6b88784850784e443c38
2706a5301c710f2c64ebb6070d7e89ea77692b4b880d3c9aab90ae0596c263de9f89bd537e18948a9802eba98efa746c4ee209c49dce742c8c94baae897b54f0499ff5c30f1dcf74f7530dd339f6da0a3f23f507cce9819e9f7d36011c80d9a98500ea2dcd31b4c660ab74547b06ce914b9425ca9e5f438d62ab39d08aa91bc6ff6ee9ea64053096c73608d4a910eedc330e2070f9508e6d8c01595a7ddaffc0abc1f29fefd9de5b23fee461bce8dd5e5bf4ec7cbf873db191f5c41db6f6fefb3f5adbb3628cd615a4b83b1e55138dec75f59f63433d613f778797c4f01786becfb76d991c025433b8a81712007e83b076ad3694e08efdeb5b3bfc8f7c6f20d859ef916eb07b603cb7f78afdc534e5590d1f5ead9996f0d927247cdba26efd12a17e490c1476183eb784fe5d04ae27a0c1548edd843316ba9e1cd966468acc67308d0f3059ce9077bf984e79a1fa94e8f24080682ca985771841c2e19690b16887981d0e85aad3e0017453b00e8a164cb2a22c532cd08ee299a41ac28a328ffd004f42b41f28b673ea6750334c11a8e5ca29e06b00726d19f219f31ad491708b3dc9af3c0d2dbb08bfd31345ae374c914f65777b10332f4e9604aa001426d9bc03c38998038c9323ac2b84b6009eec4517924adcf8c17c19c03f3f4ff3bdf7feb615c43e8bbd3abf6326b46d74babb96b8dd125037dff3f636f3ffbd8ef07a56372ec0ec4c694bdd3c4f10883de29631eff489bde29ae56810356aaae8a40cd6af8753fbb9dea72f53fa9b7ee6f348ff884695ff15ec49fa0d7d557a955db89f424952aeda2031751ac5401d61b957a298eddfaf2520c4860829273421df8345b87d860f6d182c777e3424954e102f1d2aaf30c3828e14528e209c84a15bf22189c78f1a2578f6a8084a34f12a24cc946292576495a28bf64f122dc25f0be00e7ec8655215c0c896c096c0c35679f210c8597912d9912d97a6bfd947779d20112d57903a9e98a7a3ddb5ff26ad2814241d6a51ba8b040c15b7e4790c584e8f2453ba7900846149e429c00465131c24653b541d59360c82572df958b73a72d0b2e5173fe8fc51a3e8b6fd319f1ca04d7a9f7a3e5324e620b33840fc6bd4f4dfdc119719a2e1d190255dc73a9a4fd18d2db283ab45b11a33b32ee26c0f2dc7c7ceae96de5cde0955eba0bd2d726c579e8a7b1d0a833ae3a1506dac892a0cb4c2b82b77e55aaae9c8609321839b77838ddf976ddfb56126cd860a981574985cde74722e453a2a0aeabe9e7d54bba96e2a93aaaa33855c8a875556561aae5b2a71571db153569e8d0d54997d3f6bff8a632217b55a7e97ec15d022720c9e0bb06b6099070dc8238ac9078fc37cc03f4f29b31464c377b54d9de7e7cf2bcd36effa3f50dba3665394c2b6018f476b9224aa6614ca332193305cc7e7f44ca983e343731b7166ef678421433a8660cfc4e515f8321b13a3437061ca90a4c613e948cf98b105f00be6276736e94d79c2be3ef3a37a35fa60fc0fce3be7bd4e27f1506209de70cccccccceaced5cf67272c0cb19dc48c853a2750a5c1c3d193521299ce4724f533657557152d1583684da05d6ba373eada1b6600f335bc63f32fba576658f4ebc540c5c39c578e23007f1588c578fbc7e763e39f1593aeff1d2fa3e36744cce9998e39b1cdb8a5e3957d28cecbd75a3a6f3297efbcccdf30633f7c60eaddfa1777e0287e65430522182277182ab77e051f19964838eefd4433a7385d3b9b6f4e9cbb0864a7cdaad38cd6d2413b4991c1df4163883977602842a55a542789933b406599085974aee0aef190d5ae9040dc18a0c90ae054a17a13684c9a3018d98ee342c8b088b67215eb748210351a4416c0eb462ac18f4894ced532ba0e3c3b770131d148b27421228ba0e1ee80a0430a1d606ed969dd7379c7abaa9d39ce4f36539ca699ca90e71f8d0c7339c8e03fde5cd632a00e66f0620f6a30e4df124a0b9018b1cc51e7c69b98c5791dc67a39258ccd6dad1f203200f9a686a7c53e6f317a5f706b68cbc8b338747afd1f6c38ecfebf07e2fecd86d02ab4689a586dc35fa3c6f0c9679efd15cedbb376eafb6cf7f1ada09e163fc7e38ada046da695e78ede6c6664b42301f66c13b7a5271c12b5cb5a9609c9fb964b244e3235866428b04304d38860ee66b61aeba39b0d75d2484c26cd9ab21cc810d0a1cd8c62a1feadc60d3f9177131ad8e6accaf3cce87a9c80a64d93991591ee4fc68740e2c137ca7ecce4d4c234964923bc986a0c98d5f403892c24c9c7b2b4ac5a4998305b0910e1e10918d1310ea19be9928ad3f1a1721abe8670fc562501823c423d1e57380320c1a783301fe223d6bf30560a5b231cc8880d6e89625b9ef6a2c484944b692732ecda99cce4c179a3505bee6a5a39379957443fc21f9901f047c64bf86bf3821ffe6c1b7b0ee97bb8e99824753d1af3ec4fe30509eb993d7d76d10f0fe7689e295102160e8d1c0e0b3702c32072bac52df468ed99ce686d911ce60b395ce0736a0de47cf1ccd0d603aff0394c511c271f0134aa80324e44073b50a90df55554dffe13c952a3160bb8bb8db7e0c528ce452d28b58ee4de4251610064c17c9af9a164ef2619c4acadabe5483fb3f4fc7b38473bd45894662a406c80b72629f187b5f04bd72c1950d36527f7eb9deb65d73cebdceecaba279d1b48f1270e44cfbdfeef7ee8889de78965cb8a8b9a2e58ca644e4f8cafc69695f59577b8465f6934f493c8f5dbfe7944f0b77b791abf02e44ef1db895bf8ed47a2224f2a137b0921171503c14b77ec5b130830
2581bc8c30a26f62924602dc3e15b2586e11b22e03a332a4955328b922157514a4ca7345099508680aa06ca5611b2cec8cc65e3b2ea6609595abd3316c1c5b299845181a3253303415a51d8611dbf84365e55482fb3bfde6a64b9f6a2a5c62b9cf166e47e915e5b48c9a8988f0e73f606a202ddea8e1d248a5b1134671895623a4e2f01e231c4ae2aecf2b877516734a431f64546c327858b02605f21f8fc060a3b04c153076c50cd0494dd983a41ff52e0afe5d088d58c17b35e60bdb3fc210dd56e6c4f25ca91e8d01bab5141dbfe160efff4dfcd3de597f7bc8bd906fb37dc54ad95059df5b1bae46892fe7b8ebfd6b69ac69abc763d3709a34b30ddc96fa477d0164d732dd7f446ffe56c078a5a4ca5dea5929d7835bea35de3590583a553ede096c1f7ee7dc2f2dcc7842d9f5ec1118396efd0c6d9d0218672586a8d9618c61910e0a29c6a2c5f50c38a4d73423661e20f68a5284910df5b352a450a5b3518751f5b3ca7f761c40d41747d93e40dfcbb7dcb7930efbc77f8fb204eae968aad9bad9d9817df5a18ad4ed55b4cea54b81f245d3d2cdab0dc6b50606d499602a00aeb929d5d9809fc166d148c07d144d8eb47216a857a6a236e541bd36d81e35789affdb14a26fca188ff0b67f8b5a6380e782f5cfa3d2a7747b065351aaa279f342c98a220b0bd83abe6a93bc4cc133fab960ce6a853c6249f8ed796acc2f6110f9be1928e080ca9865574ea1611e35a9eec0b2c493884a91a37166f1a3868f7c45708a7c467846c64a5c779ad27173cebda759b9fc60f86262bff89a8f219d2bb77efca8662a183b77e2c9ae50618334489b00831757a17edbfd94f9106b3a16608980a49833a1ab5656b2a72e8a5501b3ea52004546554c519d2825002b56224e031d6c544d03eb1561e7acfaf4e9995dc19ccc81995df19f0cc90662d807d80662d8664206627705af73f185b05acb40c59c665a3e2c7ccfa571c4a9c12d77448b664f0c99c52bf633b5bc91b000e6abceceee370ba6ab0151ad8d0982c512bdee89478d18d1294086235d314d92356b14b28a5a3941e8f05a12d8a5d6da2060c5db602377b6f887ca2e3226e46b73018a46f9d0037d81567008e35fb8e529ad9593af2385db2641f7bf978c03301105aac6fb79b79766feb7154233582ee69d1a3ce77d1eeff23e3ff5ff6d4de0f3cde620a46cd1a2cb6f7467eb8d3deba245bc0e1d00d460ff56c198622ee5298a31afde37df927e3ec76fda3fea0c1913f0633d122064bb97aa0ddb1f1f8f47e9ba69c641cb33a37369576cb663b63f6fcce361f36654e7692539db07372a16377f55c21d3fe57f0e3b0ee40d148f398490bf042e9ebb1f2838567a1000921e58fe2e3cb8f6d27aea48785d1f9bf6378507f7b41cab6d2b9a8df8ebd4b0a0be1ad1d8be52bc4cbc6d4996124b9a65aa41366d0c05a2b609be6162dc55820428266dad7ca210639aa84a52625d84b612cc1641001e3ea80087fb0a140608641e7b22f6344bb39db1b7443a7a488b0441ca1037e5bcc6607f204bd2f409d9db4b22b15b871811bb0141a36e9c0efd9505343fdb9fd93145be92a031253e8810a428827f10dace0252ca78f41d0c1a346ffaa24888fc76072bec57632576d3f6fdc661fede6d5ad8a636d3b603b0eb60216cfad9757c886dbcbc10307281774837bbb478406a9fb4ce6602ce47069ce76080050d0a7ff234866fc9f8dfc7fd7e88edc835b4d51d0a1e6739a71a9e39cc54a73900e2127259529683fce8a161269c35ed6fb97c9426e6b543dd1b4f4c128914215318451462077181d59b2b350761347674fc478b1c9becb8f8c71485339a865b525f9e92b0db09d04334b07d51cd6eafb2fcd4bbbfe0d10b0fea522cbaa8f7d9d57152bad339420b566f0b224a81998fc2427eddfa24e33361018a0027e95e712e65f0cd6ae21ceb8e25e31b631bc6b63bb712e0974524d8ca096990225b008208cd08d84c5d1c01441f48f11291c9965a22e64ac4cc5a44bc4268925bead715accd6b136b4a7d32bb8b45bc4fb857d125ba59d997dc947e28fce8bccaec64f79dfdb8ab7026e092da4538dc44b0b1fc42af128fdb8057946e65d7a73e269cc48bed1e28470e2da982b3d57454a9a404f1432398ce12aa32909d398f1484118cbf05547dfbf243ec38f9d3325fe33d813ecf32314469545211dd0f14c26a74c33de43881d3cf3eb3059de267881bde35bc4af78bef1510f8a5c79a5f7fb91e8b8a12548116987e722baa7a521c6d8cb57ba1c2dba97c2f878817e7360f103a93e40af1f2708fa4de79c2c938a4d8db53aeefc2988103b0c5383d527e30a6c4c800311eb6b309c149cf5112528ea51fdfa00dc831d5ee12892948a06195117837fead321d0cc05535f7098e3b70815a2a2edfd8dd5175a2ec4f214033301231dd8da78d68dd3574bee9918dd805cbeade7535b2afa06a47462b45509e9ec7d481b8706b08aaae9292d1a24d6325c8949787f8745c4a79f8ce6c67db95b70805d02a83dec29cdc599ea0785d0af5fe2a5b9b195ab4aa8b54ca30b22ae914469ad7ca29a56164cdf481569d557d4c7bd1b3c5d27564ab250b12732b000652a5a5786a03f8f912ac4aa6496451a1a8a752f5e29dba4504df1437f1a1d3a4ad1fec4ebdf1564eb9647d4729c38f095d5223f523d201f2822ff1d9475c2e947a68a3a91be7c6090d38efc3c3a2ca2f52a6dba51c6f53a56e014956d9ebb1abf3ccf5cfe0393ea13fd529cce1a8b9b466f376e83bf2d159eded924fb66b79eafbeb6859a7b56604671629279a84
2E2abd5bf5a00a418da4dc1cd0939da3993699aa6d8b05ce69b7b5abb5dcd16faab02e35a2fe276cdfa4f5e5faaa895543a592caea324047557c6e90eaa73aa0f83a73684b49a2f63aaad759591d780a2382c02e3a575e3a0d4726a4e7716b9b523a76772ed7b3b4b900379c496711d09b023a94ea47a2eec39859a5a5a66e21b765b5e262b4b8a5c3f52a8a2315555d3a5859fc4ce561710118a37a110d17e94547f5143951fda2fb8e9e895e8e28be92f452b4ca24869908e4dd0364f086d9cf4ee7c56ac525cae7ad480b90c9c49f52e12d3e12d300d05656fb4ca6bbb5c4fe773527a70a48cce4dcc53e54e60ad9803c460cba7a333faae91e5daa19e91faeca60840554a93ad1833bcf3ab3ac0e9c2efc91b6f0e18e589ec9d959a9a960b0a225aead1151a55a840a1831e6d59888b5e4c80262d99078383debf4e42c9e145556a83c2ad9c0157b23d9adde0421b043ceb1249d8eaa59443016d7b43d31710e04ce05d080ddc5ac192da7f87a6337e254429591872fef1c9e4502d0705994c009ab901a9cf3d8b58257a0a0339cda79c039cd6917b528736817416a1a0935a840d420ce7d508603f89c0a3a2db0135356b6713f935d5d0e6d160736f3b9eba3650dba2ed836371b418db74f43bc13c82b2a20d5233baccebf2c17d3ed7c97a3ebf3c5458e9231373b03d331ec9bcd59461c6bbaebab67be127cbcfa65a4af5be6daa26eb931aef95a6aba45176bf40a1e5eb6ab2a4c95d45d2aa84d4ff49fcaf63add92ad93cddef6aebeedc7dfe98e92ae7562766cdc14fc733a1f9c08d75418ffc4f78278f1b637d1498aff19a32d51a8f682bb0475039742845e83e99416fdd6e07910a0c0069520f5d80e72ded52f581308e2ff5e9478cca635ed839eb5f0ddb32855a5c55edf4d3c162fd0ed80b2c78865280f9fbdc4b48116ad23c4a87d0836fddfb82fe078e052505f7a247859e0d767a17391d9c3b879ece0d9e1df336cf1f537e9653fc31f3bfbc27b2217f8f3f01f5c2fd23e794ea94ec19c0e179a3491dff76f9b9f0be81e00a64b0e24fc767ec3f3800aa22f2362780193cc0bec11d601941412c5edd10979ff60ae83a7573bdee5e0fafc6c461396aa3d85b7fcd4bcd4a068e64830739abf75f06db6e8b70e2d2e88eb50520ca3fd42ea07a30d0068334d48936d727a08a445cdd12cef08b5584345c28b4f98a798b289188827a0bf0ed342d30fe6ef914b09e9cb68f74f7beea9fb7799f67a1e8c8fd54a3bb6337434c02e65a5ef7ccdee5eb5de6f4c5efbd517009d5ae2d6d6960bd476251bb028733b246e8059a06ee72c822f32a08530bde1eaa59170ae72374c400a649a88a6e16550ab2b1e354c44629b5c35c97408f9badf46de310fe1e5a7e5bf267d9325653c386d3e1705d5bce575b2f17c2a9ae2c2ff8161b0b7893a58dcfbf7e0db66e47cae352b4d5f476fa308dbcf9aea06f22b200db40b9b72add950950233a4360b032175b6ebfb0a0070828c242092268ea29fd3a2ca330ff744c511bad210a6490926a3875a3d32c4b6fa6249ea116864ded180d5e4406ff22d28679b2d5ae5ea2baa4600b69847f2a8c7e0fa70d4ddcc2530e86d7abcfc2c17687d6b60171e913be5c97e8aa2ffb150894469014b29d490e2407e23d121ff1efa5ee7907e431824a7e8317e551a685c5ebd307dfab5d1851a4e5a36451a401f0008f7e0c196407f5899d8b30d4ba147e3d1022fedaf7d60ad30a51e9e85bccb84b6eaeed9dc37d61d40f015c139e4f24080e7278aec4cd2bda7f952ac6be4d143298aa244be2e2fcf652e8b72ab25cb12f5a58ee5f6124565cea4a2d4e6db04e956b92b711cdba2dc437deadf263ce53c94bc8379603e477c6d59cefe4387521dccb7460baaf4bcfd550969e34bbfa482e4c3ea7085c82243c0f56ac6c5dd4b324c16405fe21e9257a8d5b2d5b247e580f586691fea03d40754bf905f9a33ba9390b8eaab1a5c749184a434dd22930fd77379b8003619456f33d5768dbb9799ce623b6d7adbef00276de5bfdcdbd9b74f310f8b0cac32b7c1e6cc39a01b4c6ec5f15d7a445773b84f65b4ee3b4683b7daf76ac672c50c07a3ed51922afd509d576d514ab271035448c1512a93aac6c1a4f5ae94ada39cc512b865f3d0314364190e369dc0c089ed036030d2e61a29ad37cdb282f16f5dda3b9ba32a8327404657b7092bb1a352a4943d2258263d369d2ad07a292ad093ac187d89761eeed2d6d5154b699cd313088bf6d4c6ddd27a383320e09452184e70da6bf4e694a73f9454e0d22614133b81a440cbe7729f3e4d290ad4a7c9a5d418a52ccaec9b399ca602b92436c03ef3ebd5d99b5b5194ce1474456efcf3570d1efca69093fdb2b55e0ef85bd2cb6a57b6fd4bc9fddfeff83e0edffc16e8f22ebb2084337f9eadbafafc996b5e97758c47fadd4b04fedf69393dafb956a44982e45811efdc99b1464c7b41771b5073d993729fec5f7ade950e6a8186c8cbca09f30de2c4cb162af00f6e8bcb2d35f5c7d66b3ae76d96ba3b370bb7cf6e716ef3729b6edf4ded8c71c7b9699681f38fb090fe21f9dfb1df4d2bd54a2f8ecbc3f4ecb93bc0517732ad672956c265fed5eac6aae373b2377a3746c1d5d3334d729d7a06ab5b56a3560ab5562c4a398da06419a85183329440434f5755fadaa980d13dd19d745ca2e7b038ef08a417d5248a7bf966ef35d69e3e09ee0c8582e417af085877e2aea1048dc46feca3620ef4258d5902b634ae540875b15aa74b14ab20aaf70a30dba2626981f1595710da788d5ce8aeb70bb49a
28c45cfaba1bf233f5373522249141d517175c94464a4b0be2ce7f738cf8d64065b9a1cfc0cbf1465cd999dc19e199d99edb2a4e32722a3a32195cd9322f00b7d783d363a0abc8863e8b2b65fbdf10c7bc3b96fc8251059788e827027fa28eeda0dc09edaa0c4ae892f8278e274cd681841058d84ca662abf93eb13e4a4cb32cb0e60bb6595f46585c557568f5efdb0ccb3267899d3cb338ac7b46c7603018fd9767f8d0daeeed898ab650a8e987da3eb3cb14cfc8beb8f50372b5c33c88c395a43145e993b7974a982ad0858a914f3f47433c8d03b95dc8c77c61d974cd10202de260adde409577e7b28cf5ffe7aa48c866ea9c94a9dd0607a979ca1e19d4f96ec88cf6481c86052367b280fdcf423cbdf7c24105543eb4c87fdd0e064822782cce7b47809fa3508c444f44e6c267a72184182c22409c30cc169a9ba6c9119a4f270ebc7a8ad16216aaf2caf2886c4e72a2cac4b5d145b1c599ec1e05a6a0f3ec9a00dcece803eb8a83dea1027ae74b5a05a945d039dd3c01c61783d3a2f07b176e49dec58c9eeea8031bcb9a5b31a9b8016990add7cb83baf4bcf0793f341e85cd00617920f34c70c80cbdc6f37ded7ea9c51317ee1fd91ba682a7694515899b8d032653453365669af7a7b4036fa699378f325b7a2f15d9870c5161819eda0b587b074d14000509dec3c2b09cfcccc2c588d4b8ce9053f3747a582e2f1dcdd7289c0ca4b7d4c6703ddc5f6b3f89567dfd74f198cef682eaeafe1eabb49b5bf9bcb4aca6b6c3952aabd355c6ce579b5a57fb1ca8d569333a553ff6cf1fe0f559f7e4bcf1517b6edba3b54411b38823485a0efabb29ab3963a09cf120d45d77d616f7e97d9d3b54574beaa9d1f0fee5fd86cb64254f163b4d73b4d9ed37b3d4e966892e56677a53223cedd9573ffa5c08177f716964d542ee7875017bb8ca156b51a4c6b271a1b451c9da6846f49da83684f299ec067ea2934a069d7cd0d8cea496c0c7f8560b119038a5e3650074ebc8c11b597ba36d2752d05f6e94ce7c885c274b6bb69f220c787afa462a14af6b29836378073213fb864b828b832aa38b80318a4feedde1a8ab9b8a356c04bc25bcd74e9d640a029bbf53f4f91fb79c4a209060196b42b97c5fcf95317e2e660a39813fe8bd9954966499664b29578c5f0f49b4a34168435c5340a4469e89b0c3449cb2c9c6b2c9cb2c1adace9c41d9641cd9641d9669cd1841f2206d26005a7ed9d0cfb391dad2d2b2a19c3c9a1a002bdd785033dafa918a302de68f77f16d4c3e9c52ad740076d4d58d463166fedabeb176a07e5a2d78f6b86b711297176d476d716a52cdfa4ce540519c434c934a8531486378be8dc9f49317d260e14a0ce21b2f1b385965f2a86bbc40e3a78251b11a6499334a5119cb8d80f06bf75d351b06639a9d9a85435e1a0514b454d2fe6523d28ed2d6afbe52ae0c94bfb458d06294c7a5c3a58ed2f94bd97ac79a8f7a33857f699463395c4e1a33afa91b9b8572e524c385f75047916bcc775189583cb8235e491552d9db660fec4ebbf96d9ba880f3aa9a1ba1d92d37e1bf3db28b8ecd539896269800b9083da53227bdedcf14785e61a9bcd062db9729b19464c342a536ca67a7f9e5b46aafba4d8e661a756c20b4b645fdbb859b019a6e5746e562e8b11767b1c9489e9c07e7931e245ef7e9e1196aae92e6525cf39a2c448f05dc45da245d983ffee8bb8712781d4f85168bf0e7ff614822808a104c7bb2f0faee467a085d93a00eca52711a9c9c5ae5930834cc787a6a0228e6b6fdd66c2fadad20ea24273bd6b4fe443e276ec0bfcdedd82702db8c0365aaf443d833b04bd4386a0b21dc3c09d6615162678ea82748620368fd74a0b48fd4209be6efcbb6b0aa7c61581473df8a666402c73faf5ee300fa0969f320819a9bfb3b8686910ad571447c150b88d412ed946a4228fd09b2486081ae7de1d06a9be87867ac24759427a0fc1f8cf5ecfcf2c8e8cf8ca4e09e7207f82450b3c9e40f1e7cfdf43df147f5a3dd05225bf347f570562ba4477015d91fd202111d395108d6910aa117a88aa2a2b3f293b5851f266961542ca38655455ccac69620c033e93e905dc45b03705f010db3a5ceba7250c3f49274850857e9acc5ea8e75635969c1e0fac6281aa746b72c11f4bbd339ca92a7f554eed9277eaaa40ee2756edfb39767da79cbb9c307382976328f83a2683f6077aa003ca86d87a4a185e682867ee7c940515792028960ea657f9fad575d1cf769fb9f57b275d00ae2e4f27837c9bae2c61bcab8732b4da6915f25ab56c06127505a2ee1793c5c57581a382c2e42039457885baa701253dc405d2319d50017216d6a811a3413bbf8632580eb89d56b346e8cc2588465bb31b1a22a454a2e8a8e98f9104c04dd6d49f128ea59c8846a523be8077b2067e13a36f4559e8100b23026562d6aa57ec1a3a6ef3e27c670a82a6e985213bf28be378e249e7c59e5185bc0b7d4ad9849086be4660f11b226bb444909e54e2c1c57979d24279286ff61ce1a07ad3033ced3cac7618efda0e70769b33f5114a4ca868aec2ae4dcaaafd418c560756e70e8ead11dfa3974a4a2a0bbc6a4fa4bc4fa4e10d71ad878d67c58374925d0e9d11c20d4e4cd0aeb93b32a37b875faab743b8755dd7eba5d9d69dd2e9fb41ba091790a47f5f75f58c10c03e2749da7ecdeb9bfed9d7dcb1358d66aab91597d7d4a2cefc1b849b0984586abebb6b65eb5acd0f29cc8c244bc01989084f73162cb770682dbde0d31b41da576c6a6b4b6260999cd850ba19b5dc32f974a1ae80f0e
2256ac5267e666bcaa1399ad44128e68b53666b5a4f5606acc34a1181a6869423035afd2b63cd7bc4f279bdba197c8801a6dd68b8a9a66d0d614f5ec53c3553d7b4669c776ab5f4c8decdabba143c6bc4cc061ae1b21ad56829bdd9cac36b131ab130dac4cb7cc8add73b0c81117f1a1da8a046df27e901b69aad2d1473f2852014f4a340b74aeed7754d98cc52d6606a83ad0a85865b885e9dec2e76145c2dc856772ace2d52b44b4bb12089550a69f62a41dbda3fd30e8e8941ac09b5a3dfee8518a75202c53945fde49997cafca39d475a1e6830b4824ad9c922e168c4cb3e59e014de20314810697962916a96069aa686a9606cc7c718658103f8819a1435263c9aecd8cf916342cd4d695881aa669704f3666c5fe4410db9b9b4ac7181496a197ce7410c1cce7d1f31b10436a7afae80ef500792c169bff1ccd0e9700cd10ff199706d39140f0944004e52b736bff78e92a9eb9d8ffdb36f1203e7a52608a4006dfdc39f49025fdd9c887afa49aa1368a221ccdf49cd492990c6a9560073ed254e1fdf4e21997490dc3fb28884cdfe30bc253f8161b7325574e16b92ae66ba48542648b45ace84b44c2e924ad1a746b3482f2e9c679661c39b4d01229b245577004cc8cfe80606315670a152cb24de0d4cda91a819aaeecf343524437177373fd9b9abe92e75b0973fdb925cf2b9a0faf81737355ed5a0db4963b82fba591f08672804dd95baae8710a1a0cf92ce5f2a73ac519bcdd4137a74d973d5fe82ffe9737fb19dce51282873a1a28507026a3ea33a2174458e1318360f48f9e886469e87a83483b776b0c3c40073007fd06713d535490d006798e5af8e4ce96cb9cd0df494375b895268af4b995dbd745ca34d5df56d7683ba7182faa6b0e4cb3ab3bbc343aa6bb28bea4db1099cde563992c10ad39cecea9693795752fafae4d8d279a622814d6c46e319574f9f96abc560b4d4db5b63f5d270ec051618721c9a05b78ad4d9d929957358d4dad89152431bc822e98525bc5725a5b6633dc448eed4be2179316092bee6c0e94b424827f9124e724abb2499659ca34330c549cd7f38a987b460a9a32841549237b1b854913a81e4cb22964ccecfdd1a9dcfcd303ef5a9d9be1dd5a31f565ecbc8ecbc86b2f9926f09ac66492c54f329248e9c9bee19f26fb89809bee1737d0d36c2243c892d4482a19f69a8ae57f4f42b70b83232245186de52a46311dc212a2a4cd3a49642c19160cad37d31779f0d49602a643f22e1bce444b8d8b5fe3b676d2ca14f6c1a0759c5931bedf3c53da62a28a8524c59d950d49cb3b2cd09668abb242ad9eddcbd3565ed0acbc32734a06cb22e21393ad098549ab664c91180d5ffeb2936d80b2a8c160d933ff94b6476cd6159fdb2bb0ac794a06a41f78f640e2b2640c96780c640771caaf3967f319f49ee9324cc65486348b31a19f49c2fa4dec3ca66379f190dc5ea0f74f951b254570361c2471871a0d1aabf5223d1b0a80f09daa5d555e2a63aa77198d45291bd2b2935b27f67b26f41d393fb25f5250e4906976124e9f0c0d531bcaa8ec77ffa93474ecc683751f2271160f0e713450a74462ecc6c1839bbb0ef33d987b8066b57ffccfcf23e254041ad7be47a66ec075741d4f96d02a516c9bdcc37c351ad06f6f675a2328532583961791c3e05dd5169ab171b63f18ecc5dff6fe0b63c69beee62f76edbc55acda70d9eec17808cf9445dc53ed082333e021815d12f203003cd3c763a219ce763a5831e993a0a788aeb6690b43bc4cd0b1441de3559e8e569551cc66bca24de5601f0b0faf8cd69cb4d4bb2fa22bf1154d29567146569c10cc9dcf1be0ccf28d0070cba74fbc5533fa6f740b89446e17e151b986656eb71f86cf84bfb41fe8bf515f9a2d5b7db3c1a2ff8bec33d53be2b76d6f8d5bd452bf25bb66d9e5917e3f4eff114af6d98e78fc516637a26aca7a2e9e016fadac71f1e4521df2b7eacfdf177cff22f00f5dd1fd29a9dba2bdfb73ba239744f4dca6a9bb1aa6fcc481970bd681e6f9d5ee73f3f5ece4ba5a2e9b0cf467f48417fe2aa42abf6792da70815711512ae56478723f923eed04979f6ff5f6d0d7b1abff48c4351c44d313d468c998c52e2f200d1abb600a62094e62c01cbd169b3c0e6e2e4011d6e1fcbc01763fb9d406b40b862da78754c9eb4c516693717af9936193e77afb5abdaa8f7a4723f0ade53647b5746ce0dcdf9b4bf34866a2fcf98e87fe6aeaadad62ee8847589b0b9961bf1d04bd6386cddead36c7ecfcfafc6f3ba99a95c3715a3b3db8b3eeb9ecb6dbeedf6c17c3727fdfa86edfc72ffd715ff5dbde00e8ee678bfc63a330ee46b1e51c5ad06b40a848a6ecc9c998a68544858b74065c5932ee2d25c028025b064c8044a2ece04d17ee037726350cf48894948971d845883799433ff3873f00b454ea86a2ca338a513614988c2913a81846b7202c249970261105e74e4afcb0f0ed34d60832d109d8a38c55087a09403d9f694342b17f36c9d2412793345add18ef04b48c98a4403af2e2abfa9d002d606621a212b500cbb08eded2d19d95d00ed092f397aecd3b9f11ce385e3abeaa514a52993341239e4e6b9ab7932fe094eff893f525c995964a9baaba655ca36aad642dc9636947d2ddaafad42faa9525e4cc5757556d9c64caf1a4897156cab002d905909df58c3c55c0b896c1e2e6274d0fcbe382547b4c6ae427da24425150d3976bf4d7ee4fa6874869c347b30b10093e0ee0d6bda1e95a04d3105f7501fcdec398ec10afc15342f420bfa198c3d8a904918ce7fe3ad56a7a
279cb559ce27f8a64174b713ffa2abd2562c5d3155154acd1383d69c010eaea957596d72e0c4fd7fe002cded8d4ad172098c9fb9db4f8c3a33fb4a9800423cfb790bd2605e43a00540d66c5170176d96f6f5d6df77a27563641a6b91c2e26ab80bf61c9b164ab8a339fe66b86d5e1729aaa4c92cace7ae5c23ae2b8dcd918de5bec66d7a872e8fb1d2a345f4a95f2daed8cb6cadc563bd0d382786764ff977992dcf74dfa17e519a73033c94af07c09cb48b684e267e8b251920ce2987c7e9dc447ceb8305813fc4fbb813fc3e86694fc199f80d9d4067e4f912eccfc39ccb1156023aeed33144edc44b4367201bde33bcc909e2e7a480e3a9643b528e7f90ac047f740ec346e6fe4717369867d53b778386a26abdf4229c0689b391948fb419d9f672325f0a8dbb5386791a66c5fdf9963e55afc9f5c60fb4e7eda3d1e95bbd34ac6d900485461520789bc628cbc6294969fff18bdb8369ecbddbae38038701c3000e1c40e0103b8107c3874142250471164504949243f121561f45654613426ca4c8488049149143b753925996d8e9986252bb6899e2b1b7491fd3ca506b4cdb1eca6276ad54e44d3472dadd326dc4d3329d3ae3362a649ea4ce464aedf449896993401ebdc829e36f6fbb7dddeeef77efbb7beeb4256bbd27fab948dd4244b47a248f11f368e0915b1154f84555c4826762744e0d91658156a3f6f86b62b79cb70db5a6b5ac4f2115c555b520caa2f5fe3e0455e54b7abaebea62d426361a2b70b53e27beaeaa72e838b53ea1ad6ba9532d8b55f0c30b30d8d4dfe6c6f06fbbc4259581ef85abcd6ecfa6fba631bddefc97e83daebdebedd397db9d8164ebfd6b4a6973f67ec042eddf77a5fa9b12312c2fa97c012fb9ef99ac6c532f43bd72a642d3dee197a05903f302da960d97a0497a758d64bd2964650e64f3c4255d30bb109574709f0a43d444fc9208fd964dbb864dce6f77824e7709f1b039a522d463c3967c0ef4e61c4d9b718c43c11d3e55d11c1149951705072451853831beea07553308c20d10c4484dd7909be766047e29bfdf56ef1cdfea33a3a8b696f04ee19488e6360db698da591ab3722fe1cb4e18e25f46f5b36f266470f0c97444c27f0f4981b50857994ed9ddb8bca26f8551224266aced9122cc376b8fadd906f8bc41241f5bb063719ab541bc50a317a86437653e4ca49183923391de57d05c8ebf891e70e3173e2014909b0464ecc552bab592b6cd58f3b3e443093f9bb7aedbe86ec46e17bda2ffa1f1a1fbc3ed43e5870ccfd81a0c6dd4198fede3e605f01757f15b02d2a84a9442fdbe726ec6e5c64eed6046bc608b6b351feeb5f66d85be61cd2d492e3215392f092fd9cf6acfa8da521cc635ee3495668f67f618cea4cfa5fd344fa7f652f6ce2d87ec8221bf14dc1131ae81a83b8aba0afa764ac799968c16d3de1142d7c8a2c155a5239dc2a2335af948a493ae415872e698711a09dcca26fc11406db474e554dc884839650fcd7c6c9432c6e41d4b1848efe7ee1364f5958f64c4931de5fba4c467cf759ba239794de35699c8a1e5c6f31e75522e0476e8964eb0d789323ab13a8a72f1b7b7ba9c5bec25d8594b8b5ef7b2ae42c1e22bff660375200c3598977526ca95d2c52eb17105c07206ab4dc0083b9f0e5cc70620e5cbb3e144e3ede2441053838bbb84d992d4f6d75829d776a8cc982e944654c92336ac7a2aab880f56b6df14d6b73be9888216b925b274fd0e6c305a8e4f2bf6d6fcdf9e57f105832d26124f7c107cbcb4052e665f195f1d97b35ff45d732e862e54f75a5cb6bb72ed5534989813bb23c5d987477993ca7b11d682f621785f120dc1524f7972a4f673952179c39c990840c75d0a006a197216c1b06832c844629ce7c9526eea2bfa2601e48d1ca1a654cc5c49c8ccd039bd9cd4eb35e823dcbacc924121341250ce52139dce7225c50ddbbc745639dc522e3b41e4bc9dc1505c768243d04206c0aaefc35361fdad3d80ae27d937c5a61a040c47d6c4473a186d93d80d12c4c84d223905f1a317307fef9fd3fa3d6d409dafb795f5163c3a68d15c07eb1f9fcbfcb4b07b2feded6fbed3697c9c9447ac6fcb4becbdf0fb3da9925bedbfa1aecc4452ec78a7aef050ae60e4ffb7170beff93c1ee614ddc07c6b3e6e2459b660bfbc2140def4c31f5431825e705e6d4c2c262a4e1dcc5efd3ba5e82979b1b799133325e84fc8e9651f268d30bd6ee1bc1c71e659f656c20ae86e96c998bc58ecdddec39f5163ac9e070724f8ed7a739dcce182aff44a94fc7990034aa75d204ac960749e44fd843b87c7bc3ea379736987db684520651cc211f22a38e1e41674726f90a6bcf3a53da5a1bf001f6f5e642bc89565b8ba8fb54b0e0d6e978a6f175eab1b06374358f0f93a0b91573b99c3b04c328f8ae792f877ff1dfc92e5e79a77cbb6ca9fc15e7c615dfb9dfb5d479d475e41051f411307f4941fd9b6839316156622f42fbdebebfd0c33d76548bb3ab6e7bf9ba773ffc0fffb2feb3fc720ef42379dbe3c333c9854986ae11d2d8c23093be62e162f15c5e05bd15e46def75ef56bd8fef2be5b16f5c0c1be79a82a992d134dd483ba8109f1c74c1697c05a802908227d30b2b4ce5214d99c26facb8ddd928f8f3596da96595a3cbbc4fbea26d7def7dee1dba326cbd2ad093dfb68199bf6e9e6f2c6f2ca402ff73ff27b616dfd286c792a1988747bee8f36898fa9978e97409058ce90e7d85553afacf4ae8273088df5f0afac9a8721f9d6db03975235ca5ef216a0b42bfe6235d122526e41a9e0006243
269330dd2ea1010d621d5ba8291ad0536a361c9a362df40fa202f020227d3f78ea30289e13e2e2dd0d995efaedfd7b84b93e6af4fda99b41ea82f2c5289b0475436a007a626074ab350854ee9edd054ee6ba1550bb1650a16ff4a8114b5c7cf12b5aa794a5b8dbb5cd485af6443fb1a9117b4a0046af88949283859d5ec8855748c4213ae1ca42206e483f018870bae0b5a8b72c82543f32098e8d9613d55badcd55bbadddfbbde14edd107c891a13d11f6c3bc09f7557be111e7e61e802bde5f7929875d20934f5c888e1c10e683044aadd8c5542c65f12784c16c3df5925873701d24989532f45efcbd54381eb53a21217440764ad1feeff4388d3e5456fbab035031dd35f3d2565ea60d4e16e2d4310695b8b4f2427a2415d105b86a54ea14eed8dd30601cdce92d06aeb4eb66df0213a9d68ae62e89521e6d1dc87f2d344d6f23fb57f4efb7d07779b2d1aee851de3b9bd89f44b73ec23abbcb83ffc9da3c5e167656eb4be0ae9f58433a3072a17a5d8c7dd36d199bb3e5b5fb7091a015ee0269bd8351e3b7e8d189a788d4d970883f20f1ec86adea4968c115b751ddddd612d09201d30d5badd93086a6c7a0f18710b674ee931e8926578859548db8c18f32b49282d03606b3feeb1d29d49c4953861bb598799a347b4087afaf6b07bab69d2eb6c9b906f4cc6cd0a0074a070d44939abbba547b32c01a399a84f64fb5199cffa67e67fd6bf920292749db45dbc57d6a15bdc264cd18d2c29bc354d21adcb788458cc73c46e38be05cff1f046f811a1de711b4e6d8e6fe1f747ecfc3db67d627f58aeea5f725f5622ad9ce7e8cf3c9552e792e7c4d7cc75fd6148357eaaf15bcc9df91fc95bfade4c3feace22b4ca2dfab3624b6ebb0154d693d8ec47a0570ee01cf11e081ed95c779d4acf05cf1073b5e7cb2578b9fafed2781338c9e044f017b2ebc7b4f169f1f3b76205d742784bd6036ca222780c2a2345aae411194aee229a16011239569789e541860264f9f9f2c78779531ea0c5b76f1b2a5f4952e2278c956f3d627a1dbcf1f71fd95bc6209f7413b62c5ae882fb283ed7153941ec3f1064e7804dbc8dbe3af0b7c114546ec56e5fa889490f785b4609441145af243115128a032313be0d64603a461f8ef3d7f1e23a1e64ee1d258b1bb2eec7eadce25c003951d72b380d11a571d43e7fca2fc6403dfc9af8959903f908eb12bfaaff40c208b1d6eaf9aebd0f458ebfa5787e4714a1799cf1e71c68e3133895e315ff21870e8963fb821c35fe417942e692b4590576bc43bca70668c051b45f260a40fe410edf8857f2a6a5317aea6aa996ca56eaccafb62a27648b03971656433b8d80162cabbc19ec1d44ca801902a430282e0e70d09039d750a420a4c8db5a306330d1739345e1232eb15c86f8856e3abf19990dfbfd276d1f56cedf8dbf22510d1a66ba29d5e3b5944e530e2715bf45ab080bc4bd0f94fc4c21243e44ac1512b9dd12f224e9c87f9cd4d3ea8d18c5cfcdd6773504debce3128b3ee6a69a34358d3468c5ab5896815c2e13dfc6e5819a260c6f7657e1b7adfc7c471c897c375a983e8e93f5377ee5f48fe56cb7851f2dd39f63635696916ff817e96816dc9e0d9d7562bfcf9a88dbfc4bf47897aa4d7e8d74909ecc9ffc665957a56645d64f3f72e7419846177b319595ce6e9edd9f0499d163ab25844e3e87ca8fedbe6f188087a0a10219050c13b05276063239c0d317a62dbbafe1b75d20e6e31564fae4a34f62363cc3cfb0913b89daf68a6304edc36928da1165f35a195d9801bc1fde591909f37da29bae787bdc55d50a1ae0dae48d7eedc0a41d06fac41444ed37dffd29ae87bbc629a7bc3cd331c7b98fe9cedd8cad2bccbc49894fb4f64c5263dbe0b7a7896857524d1f623497e3e54611c46850ca159fc33895a7cacee319d0997e5e70bcff6f3d1ee967f2aa8dadd1d7f06ab13f46d3a7e679809b5bb2bdf3784645e22f8249046779c52227f59456550a0f826dcc74e918cee0fbce8a6d29c106f022ddcfbc32c44095e6bc6a5642a2bd04d706b968744d20637bb09de4c8a0f0105d0cb21dc207fc293614c785605cedfbedbafdaced479b1098317bf4e1f2d5bb156e5ea32acb0ee06a380c60dba3aff1bb39d920a6c8da9c1c10727830b720eee961aa5e69d15bee046fef9b485a22a8434dde56398ebefbba8f7c3afbdf93e00af292ffe2690b29ad92dd353a50d4adf86ecabad2ae80cc864e259d899b37f139fcd1ededfd6c7a6e0f6e34bafcbb4193d3a6d4fcbce67e0e97a3ebcdbed910a4b9fcb1db158b2a3baa70902c815be89c2249bfc4eec3bb25256096eba5e3fba9b4f5cfc7f166d96d1a65c2f6f78cd6e5e6089d14e685b87359fe67fab890861d1ae21c780132fe21fb05ac4393dc217ba1b8406081e10a821fdcaae0181ee4489bac42f7401451a659c2dacbce66f71d685e9027edb40ff967080e701dfb2f0412a103da0c507dc21f5c103dc70836cf505d8158f74213b485fed5059fb172ea1b380c34617031e41ff3e08bbe38773f3b9efdbddf9ad99f6d0d9642dbd61b9db381da647798495254bada6221091adaa8981484b7de7d9a0b79a6744fb0b3959b7df80c0cad517f5a4b558bc6bbbddb5c12b5a49d65569464642aab14532daff598b48b551e64b6ba9dff1e4a64b379921624a57e5b686dd569f6a1bbaf66f56a91d91c063f000383d415abd3f78522ea8522f851a347005d17da8270ab55e91c55f6a8b899191ffb42f62beda10e73750b29eb47139a06ed003a001cc9b406aa8ed81c39fa04c029
2B8831ceb6aaa7417757dbd68ad25eb595f7ab2a8307ab8695f5f40e0e42d1a2863dc551bb2ab1da43d3e61e22a1ea08b43dad54cd466d1b558357251d8ce7529ecf4fb3eb3158e88b86d61ceda81f9f4b6902a5b2768693c34781ab7b249f821767a972a1d8d5c9e017db3b107249551cb549f67681c1e2fa3928d8d547500a168bfbd195f0d0fdb3f70b70d35418cf92030bc7993438fc5520eb92a89d5e64d72f5f9fe9ed56ac3e646d4eda3c22e1f68ab665185e8d9d0ed5fc9451d2918fda1e1ecea7eed5a2d0f5285690d0f9ccb62fb3a1ec5e5579cbe637698b5b798f4475dc9ae70d5ae9c014705794b409c5a27dcad0f7da47a4c5aa87201e4f42a43aa6b83406de50e42db687668215f831401d559c305a31e7866714f7b52f90adc59cabf392ecea6a2e17bac0476bdbc5b51cf54a73847e2eab64a84808df00d08574e9ab80108dadb59e07ad883b71f4281bb5774d5533cc8f2154526d0e87db82152dbdc0cdc076b6e3c9468f8f3e6a7d5aa2418ea6603839440c7455ba477cfe048a6550f181bd732a608e7fe9cacc0df8e80d45581dfa15af8f957f66c5bbfcd6c8df6f14fe6e2aefc4d9747bdb5fbdda80c8f0dfac5b3756d2985b96fc4ca7c21d5c15786e02269dc3a2d5e901a3da40323a1dd39fe032d1beb5fbd5786ee26f558fa0621b00cf84c4260ad0155a586a57e7ef270189265ba2cba9cf0ffd29602078dbfed5839a6ddc58aa34420b1e093cfffa16721c18ad393e8dadd54d7ecfe9b5e9e9af49ac8596739ecce25b0e6647c3deb835856766ac187eb535fb675b38b67f8e55af9acda8aa69d807655ebec9d981cff1e3622a7b5ed7ba7fed5482311700336902b7869ce768cb9c1dcf1ff773e3c22ab819f0ee7034330615c0859dc53d06e018b9e508aaae72432e69a849264962f6812430ae2b78ba1f2d3c42a8479a419a16b118f343d391be3cd13cd0d1878d89e6632cf2063ce69e5e6629191f914d5a41802ac5f40397faa3b45e4a5995d741644e5588d7e983fe6080d0ba8538f503b45607b47ea2401d167d2a02a00f465421a19d1268a3d9d1a74203d68d5a4b9c3a9cd2d0f74ae1f4a0fba10fd29528d53431daf7fb5d5aff6a8fdded7efb3bdacddabdaa7fb5da87fb59a8ded5df5abb56bd5abdaf9b95ed56fb2bb5cbdacf1bebffcc63fe9fc34516a8c0de27ff05bcf1c483ea9873b0163b628bb13b038b09087cec2583d8c7ec3ec5abbbf4cd087056322630e0b78e2ae26b33c075e2e38eb0c7389381381a70db8596ddb81b19989f1932e71f2ec6c6a7e3f189f1c42fa9a513343f8e8e35399e554f4dce35d6ca8696b1a199f2e4fe09d2f29989a96131b1f06389d4fcd1e9a9e5c3adc687a56363137964db293e3ca86a009d2f633e34ba68a785a0ecb2b1a6a15534b27d1f2b1f1e3428119fc8d0fa359e9a5f0c4e8d4f293932d17f1b9a6a76a271389a3b391d64b71e523913a31d4258f4dcc3f2c47a69826a7968b32f189db827a73372a99199e27c72d9f8e594d4766523e8370cf47a3ca47e5da54995cef1d1f1963635d4322e9f6e3190a5189f3d3cac659e4f95cde0d98d2a2cd04aba7a794a5c9c6274661de0cd29c1ee2778f70fb8bd37785de30bb62ca5e21c445fc071afb98cdd638471d117d9c31cc246c2ce59585a918431ef0fa4fb1e5151ebb98fb5a971fb97a7afc516d6056329afb5aa045a4783ef900cc3aa100994826a751900b3bdf002d841439875c9875234402b845704e8a3a35034e8503e2167f03421f10d34257901dda1100e25bd40532f4fdfa007d8e9fb700a67200e3390a383280d98a7d7c988033ff59e0a262d3f73646e65616572746e650a6d6a626f642032310a626f203033320a6a0a3335306f646e65310a6a62203020330a6a626f2f0a3c3c646f7250726563756d412820696e75794644502065724320726f7461352e3420312e332e432f0a29746165722820726f75796d415020696e43204644746165720a29726f6572432f6f6974617461446e442820653130323a31373037333131372b313235302732300a292730646f4d2f657461443a442820373130323731373036333131302b3730303027323e0a29276e650a3e6a626f642034310a626f20303c3c0a6a79542f0a2f20657065676150432f0a73746e756f2f0a312061746f5230206574694b2f0a5b207364203020320a5d2052650a3e3e626f646e35310a6a6f2030203c0a6a624c2f203c74676e65363120685220302069462f207265746c6c462f2044657461646f63653e3e20657274730a0d6d61657800080a9060e39c106060632901006399202606a50d25681cb4a16510679694b98ed3019979a5956e2e010aa945ce0a45f9258938320c6af44c1464f58cf54c3819f50c18382a808536c1944903303050933d438057d1b00191c058d700000d0ac5153573646e65616572746e650a6d6a626f642036310a626f203035310a6a6e650a376a626f646572780a20300a66300a373130303030303030303536203020353335300a206630303030313030303030203720303030300a206e30303030363030303030203720303030300a206e30303030343230303030203620303030300a206e30303030363530303030203720303030300a206e30303030383530303030203620303030300a206e30303030333730303030203120303030300a206e30303030313031303030203120303030300a206e30303030363631303030203520303030300a206e30303030343831303030203820303030300a206e30303030
22363831303030203720303030300a206e30303030383032303030203020303030300a206e30303030323235323030203520303030300a206e30303030343235323030203720303030300a206e30303030313435323030203320303030300a206e30303030383435323030203220303030300a206e30303030353635323030203720303030740a206e6c6961723c0a7265532f0a3c20657a692f0a3731746f6f52302031202f0a52206f666e49203331200a5220302044492f30343c5b463832413143463845333942314231344446383538354438333641343c3e334632413034463846383942314331344533383531424438444641343835334633362f0a5d3e43464450636165726576697435312058522030200a3e3e0a726174736572787435320a660a3737364f45252500000a4600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c3776214290dddd349063e0ed2fb357c202b0854c21f26b60c1e6d7e6d1ad98c5570e7dcdd2982e619bf530ccc336e6143c466de7513f5d529d7cfa73a87aee1eb9d43db30f5ceac2d6e19282c2d6f77065f021cc1c700177985afbfe003f9a2ce3b830fbf016ff29a2edc18f30dbee56d5e84984c1aaeef56c881f51529cbe2b04047fdf2f66866c56f2e7d6a53affd0844250b48d0850f4ac65ee1d6a7db25f6cbdcd421f3791060d35ad1d7452eee0ac82388155c047e78e0e9ba48c1d2e79b987fd52151ae8d25efe0cbdf2f5cb8e999f021571cfcd062c15a8a573323f242a0ea870ebcbfd4bba874d64e6a7dd519d4075b556ea2b7a3a09d0b9f9c73bb5cf57346139cb7050787c688109549a549c4b32a5ddafd96b0ed01d01856b8f2e3c58718b4f149e88cc4042762ad88a9f625d8812ee2fd8bf62fdd55db43a44272d3eda8cda036b6ab6d1567784bf05adcadc357c1e08a4b8175c19cc3c707e0fc872f15b8097701cb1ab0ec812e2a64823e047438ee0c9028424fccf508ca4908cf508235c846b69f022e40eb82b4952855d70c4c95cf169feb43b0e2e025a35c806a5049edcc0818d34ff1e94846be9487a527271d6a183287a160ad7001f2779638e80d501c12996513f138077945669f959a14ca267cab392ef1270f88aaef1240f624fee24a1beaea56781094287979b36279747973be6ef96ced19dc3be6ee7446d12dc25e6ecb449d1f5c3eb6efd44fa474e1d3e6ef489d347f61fde6eff09fd9ef37b7e8f9ae7e69bcbf3359b7b9b3bba581ab94ca9837d51430b0574181e1a18d455153d93261be0e59c30027704efe0fc871c83d5c1a793c704ebc9fbe03d27f7204fd413fb9038396e0209f8de01fbe02f157f34650b31a32b2751be4e5a9fc0c1ced9549c1e2208d0d29db83977fb6838e09a7f2869f6c7ced5f001fcb096fcb24f2c5dfd42c4fe0fdfb8081c3b2dcc4ca50a5bf6055a297fc29c0bae0e8b718e80a62c394107ef832d0f6e05d70a5b9e38316e62cf4f3c09f912b9a793f36e5f45141dbb2392a4d99affb0641b3f1e911b99fbfcc1f5f995bf86288fcc8de7fd46ea379ffa8fa8d3bf40248443ddf1eb19da2a0fcc06fefd063e834b7dd687a0d9e9af601c22f98d89cc27f1f512fcc79f7fd41ac53dffd411505bffa8bea083ff20bfa83b00f3df489589eaef03ea5af9237ea25ad68a63f3afd97fafd7d7ec5f7a0df5f8d7c303bcfbe654d13ea6ef9871bf6cfe8fa911bab6c0cfe0583c13d0110ff4973e3c02c4c100d7582cdd60d8eb074608e5f04076fdf7dd60302fe2cff3f869537f29c8c1c19f0d83fe9a78731bfc217bdb7a039e0e6e280f7e3f082028e1d50cac1a3f847fd691bb107fde1421443fd208ffad15ee1a1220f34e5c04ef78507f9592c1e10687d5f057c2364bec25441f960df7abefdc829c856c960f25837be07db04357783b4a30b15d60d55784c1bf75a108a34251452ff85cd27bf9686ce2e567086a58319e5f4e9adf42a784303f21cb860d3e5ed38895a8c38b183fce7da2f4836683c26b306ed3acc201a16514f5e7591bd542c4286846f8603d1fdc45dd67ffe530703a113b838d19167e7ffc9208b7c60673c27ffafff29f41ae9d102192b1ffffe83d1cff88f8555e10c8a52e1fe834c14152190443257385eff01fba801e49eff41f04ffed5929ee9598492c29430e52bacef5a5e143ff90a207fe58dff41e06ed2cf2bc4606ba4adb8a08eb9bf8a68ccff29e5628610e8a63e0eadc293fc6
2C7641cfe3b39e10ed797f29ef25768864753c6d035f0c5fd05759858c261cd616f5e124590eb4894ad2458e8ca964d28502952a5248f25792255995569d2a0caba952a34a22af15440eb2a42a52549f8d8ab4c8d4e449976cb8b3cfa9f24fa84cab0451fb80cef0084d226b8501e2a7f35a6a137326a075308d2434d59b50345fb5501a6a17b25b2e20dabbe31b6e403512c168c2759a50203cc07babb021c96ddeb7d203f5e1a6e9d6d9deb786069b862b4d452fcf9f03032e68718784203a5c7d913aa7deb3bd439b94c53c783ffd39f53f051d75339ff53bd39ffefcd36f707a4f0325682a06dbd6dbdc647e6b30348725e2e09ceff0c0d810fd312db4107b91378439d11719ee7a69bc7c286ab9db1aa0ba44ad01a3aa68850fb6fbc214355666b5583434c80d50defa6305e95f280256873c558179f22b6f9d5ab6809f02d500695a58450f88a3e2115bf21e80d56fcf198d91b0874c21d46635568798d6428d1bdaad2892950a26b7b26b46f6155f53f158f9a3871728a1b4eeb7144efbfc60efb1be449d75a141500e9d41510e7f9fffd4fffd4d975bef1950975587f13c2cb8cee33c23a3031d7032c2b86fb732b7d039eabbd8103020b40f563ac5c00d057a5ef0365c57d365f087a7855607b8aef6075f143ff484578b4a9745efa764b058ce65caa5ef285707d35784662bf7db6f4ca6b4ef58eb6b7c6feb4d6fb9f58d0ffdd1a6c6d2f4d63d6f689b8a1f5bf463f14d5bf44d298f5bf4356fb18f3715345dabd92eb5a6db5342f70f9c5df806ad116c1dc3a1bb976a9b98e630a6e0de741c5023cc3edb54da5b753c2e80168e0f40369436954ee022d06c80645a79c8a163fba0e4c350a27e3029b6432463cc153ca72b8ce776b7fb9fd475daed029f5fad277add7f4c075bcb34df9c1ba5c2f33006ea064b280c66ea30dbd31d85f58e5d144b69bf63bab9f9aeb3a475dd7b6eb7753dbace6df5fac22e7e6d9096442c74bd433a879da1eda191213da1e4bc5c1633b752a06e213ff45e13503da6337f0787ae6fb3e4d1fe10e96bf5baac0f821f5cff9705da6a7d6aba108692062ed0142c8a5e642ae0c2e02707cdc1ff02ffa00cfee0b778e0efeedff83374b828f7072b87347d38674ae5bf4e9caf42a296d8ec55c9c76a2b64cb715c2087bf9c3e7998ce1f341aeb0f970e109c2a1a6a57d631bc008cabfe0c3af701dee0c12fb83157055c099f5f1ac1b5b6daa7430a6d68d62411f76a6d6f5104414e1db75ee9d3d442953615870251fc29aa807847ba4d53047aed01020b016bb9625469eb6be90b47f1382806d1d8287824369a12466423e097bb5580e7e420dcf225f221f812d21cfdf300723448144a97238272839e6a449c38825f06bcf3f9299c79bad1bab9ba99f21ea875a3f059f2e2534133ca0f0514d03674787b559f0dc00a15f4041d30c3f0c91ac60bc85dc2f5e12926829b8f4d7b5b7477c8bf73444dc7ee84da1a115016508613f53ec588abe84b82eb4647da47f864eaeb48fd48c2e3b50679c58b6c76a32b246312289b1a23e1d59b2efbfae457187feb8edd7e7cc6a2c179d19d63cd8bbfcbe6ab81bdb78ab7f8f1763a7fa7ee6f4bef83f8f6d9e83287d087d622c3f249129c02d9aac541371f0752a02c2740e81ad4c4e1a8de1f92db3e70277bfd776b25bb1936cdd86aead9495e2ab673bfeeca4663c3fb6cdd79fec75741b9ceaac2f5d3bfcba6e2dfedf637863abd8df19d15bfd2f35e093db606efadf07b464f00a7b1d03912fe46de257cda2f1cdac3a3b539a9c5dc75de78923183a332a8e5a745667e6d1927b38d9f5bd062e10d46e5c6ef1f397462ccc14e866d1dcfb79d3e811fc9b0e7329ed1c8ec740b6ee10b147a091c312487aaab658a36ec2b2bd5adf8abd2496addf2d6cd4653d54d497b1f6f57bdb424aa5b57a2d5cb2a93d5be5dae67d2d52f7a591f71f34395680208804af5d555de7dccc602bd9110e602c0ee2b713e1778fd843c458e3ea00eab3a52c17e74eda34be023d28e2ca4aed33e705b4122bf4611cb68fb8e853f1ddf480bd13b078a528b5396a229aca4cad42ecfa95aea9de357bea26a3d26d577554f7756da56c7452adeb2899e518247e72b28695a8178686b856965f99f8dcbb645605322a2917439fe6bc24690b0d5d5d15c5c43084ace135e281b745fb0868b0cb806b17175c1d79c93b8bb3fc11dc843f1af2109ef73b83391d5faeaeb42746508b6eb8bf2cda9c61499e58ca64c6127f15ad92e5f5dc2b6849e1287f8e35015c233dc741146482a85707850701000d0346c10b0868beb8bab315111894c50db11d625e3193b156d9a2663513a8e58768eda2f457220814c1f630f4735616dddedc9e6291dcf9f8db4d990848e334a1108a1231130e609edc7a8a59cdcfb75a3198968e5d398dac8311170bf22569b5b12b458ebb3100d81c1162002add89556db2ccf3c06972257a920a6f1715ccc732a968dc387500d9812b26e46ac78e12b2bd8764daa6baa12794040ac778d22f0f1da5bf6dd0ff5dc2f95db338bcd78ebd5dd724899657c7a69392ed9157676b96e21f14be761a81d3e7b63fbcf783bec73ffcfacf7bdc3e71a79e86d687c3efcc178268d6187b111a8834ee8ecc66138aac53e9cbb9c3b723c9d2701b24e2a4311077d095f0583ef1a8a86339021427882ae345ff8161844af88c8f841c876b82005331609a891e11d2ad44ffc61d031473ea8c5460c1b7b18cd945dc6fd8d72e8de467c11261ca9b930aac8f2b9bab0c2ca2930ca26ba918ff439a91ff8b3dd2a9314
26a56896ed3bb76ac914ecc16c4013a592371a7fc717752d065a8e918f168a46bbbff2a7452dabe478123eb53df96f128dbb87f2263f3e038b1812c3a5463053e3b942be1f736a724982e7a70e9e02a72a9f467a8bea949edd8fd239a42c09512596aa97e3d73a9639d699d6a8fed61f99e980f0c086d3ed691c578457edbe74bf3279db7885ff05f008e606c336dc12eff0e5dd9743b5253aab7ad4eb5b5cb35c9203db1da38845d38973a5c80445ce7a7e00e9d17ebc2c9156a1ba087d5d562b87ab1a9f27454ab85ddb450b8f6ba778730eb88b77713095e744c3ee2a77c21ba9fe247ad2dcb2c5f0b5e969292c219655060516a04a02840475c02fc0480576017f04758ac7a67c3a4e5d624ed92f49c8c7239e443ff209c3fe5c45e9afaef89e5d54f902e7dba2b194c95bbbdb4646bb47eaebda648af76ccf2582d4e7e357b504d4c746445025342e312dff250a0d0dffffff3020310a6a626f200a3c3c0a7079542f432f20656c6174612f0a676f6567615034312073522030200a3e3e0a6f646e65320a6a626f2030203c0a6a62542f0a3c206570796761502f502f0a656e6572613431207452203020654d2f0a426169645b20786f203020302e353935343820335d392e3165522f0a72756f73207365632f0a3c3c636f72502074655344502f5b542f204620747865616d492f20426567616d492f20436567616d492f5d4965676f462f0a3c20746e462f203c20352031205220303e0a3e3e432f0a3e65746e6f2073746e3020335b0a5d5220650a3e3e626f646e20330a6a626f20303c3c0a6a654c2f206874676e302034202f205220746c69462f20726574616c46636544652065646f730a3e3e61657274780a0d6ddb51759c0c30c36d703b409cf512870240a081b06813c71b100d0283e9f93f20748a3dfa060411fdc71f13ad22da78a327fd44c58910f57c0e6f3df1653aa52234e399a6e047f53337c0322933a5f8392bac067305605b734e030af8e72b8ccccf76ab0caa801c82886ba879e97ccdd5e2d535e25c626bea1abca39a6024d4179f8a7e293d69e2d1766e0d7ae0b9c96d1ef5b3a83955c0f927e0b35cef8d16ecef0d17df8cf6755a816d4178791d0c9e9cfb3d9fbbc6fd623f171ce83629eb9b3c5be0e741f4cc6f3dae1efd84975e9c524f30dd2f8bcda8358c7ce7827ee54ced6b3366faae7d307ede6d6e09775c486ebf397f6e650af8727473640a6d61656f646e65340a6a626f203020320a6a62650a3634626f646e20350a6a626f20303c3c0a6a79542f0a2f206570746e6f4675532f0a70797462542f20653065707961422f0a6f4665732f20746e48465558542b464b73656d695277654e6e616d6f636e452f6e69646f492f2067746e65642d797469542f0a48696e556f65646f63302036202f0a52206373654461646e656f46746e5b73746e302037205d2052200a3e3e0a6f646e65360a6a626f2030203c0a6a62462f0a3c65746c69462f20726574616c6f6365442f0a6564676e654c322068743e0a373074730a3e6d6165729c780a0d6ecd9055841020c330efc09f6244f4c792f968e5f90f92aa4ef69d51c5216d6083e35a0b38e0bedf4812b2a9b3b0c31fd9f343a817508bb088a5a6f11a15b1ce708624fd7631dea37133ac25833765a5dcc9500ea1a463ceaaa3cee1c49df50acd8cca312c59d4079b1ee389f9fcbeeb14ed274de2069dc21aea2d881d42ba96f49c3a8e7cff50405ca1039df476b7780da0c696509ee689a8d5536d20d552bed3faefb6f81eeb754541fd7efcf53d7295e91e4029224cc592f732e64c7167283e09afaf1579b6e46a831b7f6e650af0727473640a6d61656f646e65370a6a626f2030203c0a6a62542f0a3c206570796e6f462f532f0a74797462752f2065704644494354746e6f3265707961422f0a6f4665732f20746e48465558542b464b73656d695277654e6e616d6f4449432f747379536e496d653c206f66522f0a3c73696765207972746f6441280a29656264724f2f6e69726549282067746e65642979746975532f0a656c7070746e656d3e0a3020572f0a3e34205b20325b20375d203737203634203035325b34205d20335b20355d203333203434203035325b34205d20335b20315d203333203034203333335b33205d20325b20325d203035203835203737325b35205d20355b20335d203030203235203030355b35205d20355b20315d203030203035203030355b34205d20355b20395d203030203834203030355b37205d20375b20385d203232203737203938385b37205d20335b20335d203333203037203635355b36205d20375b20385d203232203736203636365b36205d20375b20355d203232203938203232375b38205d20375b20365d203232203538203232375b38205d20365b20345d203031203038203635355b31205d205b203131203030353131205d355b20305d2030303930312037375b20205d2037203830313737325b31205d205b203530203737323031205d355b20345d2030303330312030355b20205d2030203130313334345b39205d20345b20395d203334203739203334345b31205d205b203132203030353131205d375b20395d2032323731312030355b20205d2030203631313737325b31205d205b203531203938333131205d335b20345d2033333231312030355b205d5d20306f462f0a6544746e69726373726f7470203031200a5220304449432f49476f5470614d44302038203e0a52206e650a3e6a626f643020380a6a626f20
240a3c3c0a6c69462f20726574616c462f6544657465646f63654c2f0a6874676e302039203e0a522074730a3e6d61657201780a0d16db8ba58414604214952a3fa074a439dffde248b92ff1af35af6b70b599be7b6b1ccc3730b36ff20e1592cd716c366b1fb1e1d9f5230f2f47014be0448fb0ed224c4366e5290d3a3670c5cc0abb7f347a5dd26ee1c853908a928bc943e6b8b74ad457c358c20fdd650ab3037473646e6d616572646e650a0a6a626f203020390a6a626f0a3830316f646e65310a6a62203020300a6a626f2f0a3c3c657079546f462f206544746e69726373726f74706f462f0a614e746e2f20656d48465558542b464b73656d695277654e6e616d6f616c462f342073676f462f0a4242746e5b20786f36352d20332d20383220373020303030373030312f0a5d2057677641687464693030342074532f0a20566d65432f0a3065487061746867692f0a30206c6174496e41636920656c67412f0a306e65637339382074442f0a31656373652d20746e0a3631326e6f462f6c69467431203265203020313e3e0a52646e650a0a6a626f302031316a626f200a3c3c0a6c69462f20726574616c462f6544657465646f63654c2f0a6874676e203231200a5220306e654c2f31687467323233203e0a383674730a3e6d6165729c780a0d7809bcac37d9d594b679ce7e7d99e7d933efb326593324992440c9260249d84f8c06b289d1514404a0a96166c115b898d775b48556a2d6023161096d57d1ad80b4285d6dab6abeb55bad16d06d4b52faf77c92557c413339bebaefdbf3fd75ff9cf3f670f2f72ce70339cfbb3d2108c25c577f623e5562b6ae00fe86c8c80afabc15b127979dd5c8c16ba44e8acd7fdbe90abb6b5c0bc14f205d61ba843a269f7aba77a4ab942b2e38c8443f1bd5f5635da7cf2f2e968419759ae2ba6bd3e6d7e06f036fd7d5aef2a0ebd3e4d2fcb17dde14566b783574dfae7577af5f4f975dcef8e5078ae9f9965ffafa7c5be8b7822cb9ae2bfb4cde9f63a229f1c22f6a13971a7bdaa1feeb1be958ab527decff0fb9bf8681d5fc37bb643bd1ba4ed032a41f9c7d42383ef40e962d0336beeb57d142a3213c257fd7fec1437085ae55097d81177187d7923e8320a6e21185ff43c4045ad0056908279abbb51e60f8c1d210c908430d8fd37fd01d40b210ff63b42bcc0dcc0dc8445b9d3e42317307c08f58119b85082844cf8a6f4b750983c2a8416af216507bdccda102794d08cdd0a9a15987d0e9039a11b30eaf3af321efd6a1a11abf34f9d3f7c54128a366f43aa19f822124038b469464fca3a66044404827db7a0bb83ce0fc8c8dc8dddcc11ff8d0e1f7029d59f8e3588f0a0d61927e355d3f3b40b3a284382913b45ee85c69d045c3405e8e863d11a8ba2b501ac742cd1b40641ed0886bf11b1d346147d8a2813d899e5f0f0f40581cc5d1b7a08fbd07a86a04a24e3361ef42750333b48dca3b21137e047f10fc6dba69a0d2d430e8a7e887cf1abeb3434f3ec14e09490f8fb7978c4a07230b7f1d1fef403f525ef8c8e31f621b34a38a1320645df45e57a157460a52cfc7e3d12b4611fc7af8740ea20a6fc55f3b26835f1b77e803a3736209b82de146d1357401f57628f5bc13f1e1e03f417fe30cba31e7dd09ba5a441e3d069b8ca4c30142ec26a017431494056879c6de875e29ce5c16a9f1f1e3ee400fe39233e8e312732f22e68523f44ee8e5a0c6cc08f4fa14e89b2ce2d6070a7e01febfe35f9edf416f0ab47ad09acf41f5099f77831f39708746e20e272ea072d98065085a24f86ed1db1c743efe3c36e13776e79f8cfab1990b6db8eb71e3e32ffc812d18a8cf44ee1ee0ce37c32f81d40c1d6e217009d7e3efc237a31587a157086bf471d1307bc7e8ff40ffeffcf0c5c27a40dc913f8f17c7f43efe31a8fc854596885d16eea04ea2c21fa36f5e80beaa5fc37f443cd435116c24bfc67f8f4e128636e60f5bdf42a6687cf6a0a55876fbcf043441134a309b6a28c00e117c3cf1e3b78d5e7e10f17b444dbf1be4dd24127b806e635f03fb8d93e3082df23b25a068c377c15602ba31ed9806e09f78c1ef57a12f4070c70db04de88c293273ff78e7874c99bc8c72516dcaddc7df0acfe7f6393b19e357d8c9a7ae80db812ddd0366127cd91db07fe157c490facff8b5e1b27ef3d03270339f5cb2e6176b80b703eee36ee3fdc97ee69fe1ef8ae611dfe2a7842b08df6315a478f5fb1a4c2df8d3afd08816154df038b9fa01aa0d69a81c9e0baff4ba3d741e77436d110f7cbd01c14f42edaf439fb877a1dfa0019cfa413e841271bf5f095f56eea8060f3c177cf3f1a7e00afc25f89cfe23fe4f04243e7a93548224cc8d32f0adc9ab938e4ddc9c87c937eb94bb87d9e0fae5dee41dc1f3cf11e63c0542e385db85b3a4d7c5c75a5b3484ecfd7aa968f168c8637be8db6c68ac6863bdd8d965fd8fcf46f8d17c95147fe8e9e832a203e5e816e1bb8340f1281279bd197a20f59bfe8eb04c33f5c4ef14001286a0613c7ab5586781cf0b9e10be2ec62cf0858159e14be02be257f87dc5e9be337c26ef89df0530fdcf61c7f8ddb6cf3c20f8fcf0c3e01fc09f0e67f18fe0709888041251cd4083926927b3234e9108b90b4813a4d59e43d22e9e3d0ac0364391f64ec2ce4de46e52b9453dcdd7057b94fdc0fb837b81097c2782f8ebe69ffe6afc45ff18fe66fe2dfe6bcc2fc12b7610ae106e882f08285c4ab12fde255e143f11eed4a24acfae94ad2ac690de97569051551f7180bf4f1c86f85af0c78b4b5fcac1
26385f004e0b612eb92633085ed5dc05926fdc5ddc69f1cb84c1df802eb92bb8db728fe335b8bfc9333c88bc4e5f9c43878e5dc498f8e340ee7247f229b785fc8623e405e18bbfe09cdc9d219f8fd222346de5bf08e802cdfc68dff240878cd912cddc4bc93fe3cddc1d84934383b084f8f8051afc4e82c493216f5700bf4bc1f7db9257224abe12d1095d0af8e163fef329ef985acc5c36e440efc1bdf26173efdf1a7c7728e3520be423e46e4fc39212c51dc481bb82343e07be17517e08f8298c210f17c71ee09fab0744cdb8f4403551c15406e0df882ea98da834e1b118bc2c9a72568f159ee4418c59736d06fc4a00ce1cc28dfc4ced07016fa120e24ddc348066d340ae2df9c81f744ecf6333fbbc2d8952740edc25825708f6d419422e93435e4e87de37800efa0967818740aa19436f067eba3f7202af0fbce4173fb9f84341275ac6942ae80e96900be82f5b2c81093bfd5f0e5c57ffc817e137ea41e36fa2bf30d67000e4b4f04a48067e0ebf900ea60ab3c3b761ea43b580f13df482d45bf00381a01dca803b63012e80fff867f39dbf68117e7b6482ef5e812f84773240078f0f1bc33c0a46cd61af41df9f433682b79f00a7f241b3f2157e3bded04af08c13a0cd518e57415fc1a687df7e345dda68edf8f3e323f8f968d5a3172013f8fe0f8c377f45b46aa2848b236832055f1422fc15f6e3dfa3e8cf6e41db3c80ef46fa27628a429f9e184708a7ffbffe36d08fd676413bfe31df08f9836404ad0cc15d0a7a2df30afe83461b9b36c8f363955c99f1de13a86817c7f1c2e88358fdc71abf18ae68b3ef24ec8024b7613e43e9edeed0370324e5fc3b224dfdc5ee434e0e844ec2a7dc05a17f62b8fb3b8d837d8fb83a857dee4ed08f1c02742191c8640bae0f5684e0e3e28fee61f1a8cc66fb4c2086503070b1954438ac913c8b060bfee33f15c9069e48138c87e82b377683ea706f79baa442d457d91f36a2715a5c87bdc341e11c07fec04ee3defb5bd928a71565128190f41b11901bb9768fce8801a2ef71dc290470b122fb3b71cf9d8aabf943afc0b02bdc0657b5f4680aa6f533dc17f020fc36a04a140f189833ec0e5ac3502a7b904eee071fe0c369dc1277e4ea3c70e0bd471e03db83b6f046478ee0d2e0fdf70e685af414f7146fbc3773ae0d3f047076dc1393e14c3cfa86bf9055dc13dcee7e52b0364a400ebee76f08411fc2cf0fe1045819f41f2169a408f77e90b3b8fe5a420801ff2160bc21db4807de10bfef086ef9cfcc08656f4853ddf7b3d6e05dc215d69f41dadc41f06e5f065c0079bbb1071c4ea5b77756c6115111cb9cc6ff655f392e9dd766d4336f28cd85916d25801a2f3b4f77717b5518acb305cc2960ab65085c2944a99275179d58291128c35d5d51ecfcb53d0702bc49d56b7c7675d458ceefdda1ecfb1f1a66795e0a624599e2f52afb1858fbe2a78a63e37c7fbd0fbbebeaff46fc303c3fd52e56ba763e61e8a75822f9707cdc0acf4fc669086a72ea0ea75619ba67a835cb9b6a66683531fc42936b264ed547554a5593aab1a848d4ff7ba8370a9eca9bc31c8a1c8ceca57b2ef444f844871f65f7e6ea8a3ef84392a884897d8ea9c8868c3833c77d1d55c4338ed904e0e77843ed4a92af013ac1795793eb27dd0af82389f26a45640adb4567d9fa406bee4ac01add61d01bfc87ee10d252bed294abba5f81fe42948c2f52e5afbc887dbc2a94688ab86aab9bdc815479628cf2ae2c42ce3e702a4a6c40b73cbbda467514ef50cf3d1072e8fa9e91a97311f69141979d2e5f6965d5c5e4634c8c1c30505e41a3045886a21425c2034cc4ae97cd82c4233eac4af8da99899751f7afd895d7236952f14a601578c7f08da77507ac266a9652ec9d60730582b16ce600e525cb27d2a31c2c4f6457487ca6d262ba565d1e5bdee6f0f53c8defaebed2f5b27d6455d0742d11d6ba70befcbeef753f91cecb40bc3c7637d9b8df05745aab9ef5a3bdde960375e0fc3d313e3709512deec776a2f5b54d2dd54f8344de2d2dc973a31f7babdc003c325756087abfe8f4830f5d8495bd0cd3962314e4629b61d62e73170204bcc4416abc47ab4e3a8bcf4e4795703dab2a4b311c54a924153a892ffeb1ebf2f0187e0854ef1693d51602f40954512a1fc74ebc038ee301a2b976491c8dab55e1edc9deff8437083d7138a9ee232f63d2757900454519c870cb92c2d7750f1e03aa15b107e88206f55a45321a0cb4b947911e56394cea7b2d986313f41e29658d1a8d153d6890467bba94000a6c2db05c59829b0ee60109fa3ddc1dadff59027c1163dd07b1aee6dc7de5f120ef674da72e8c8fd0256bf219a146fb994fb1059b1e23f6fa577cdbb15e857a7f077bd792ca57a7b721706cb838b030d841b3c6b642d9e83cf36d15dea13dca36193e15ca3630a266c5b326a0aca877553a3979541040a616081f2ee49c3db9ddc805e408102fb924830e5a0516727109ff14e683053f91e30fc400678dc8297693e81dffc63a51630e3a002611dc252f9060615764ca0e23690710c8a03a8abb2264bb3df18742633623f8cc41daa77674edcb029f6918d07103a141a08ca7b32953ea129655454d10ba60a28d05e4a43dc1efbe1370271014dc894150e2416c06720386bb4511f2af34ef5e5d0975400dbda17894149678a2c14a102ac61e1c6ed02f8de71b73d586d15df8badd0f6ed70b961659d4dc9ba78a2ebbdfaee69e6bf6e3fcd0bcc58ef8c1e41cd686dbccd78bece4a4f0afdeded560a9377eeb4a4622549580039dc001b9fa
2E75340e4a1ba2e72feafd5e392ed77eea920af9506b598a74a1006c54bb6dfaaa2cf6c46cfa27228e8668600d8930cf5829abc05bb2881e7c82a80f9c2b814614a54c374947903721a30d6556d8f9a996d96ec454584061204fc83c839b097b9cfbf633323c8bcf88faf20f3eac43cfb184fee73f7024e01c8a4fee1a3e3c4543d8f2a8ce85dfc8bd58c130fb942a246568f587ae68fc7a3f41174d3aebf9191eff9d38a7796f37935c1945f1b8adc67951a306556a7c6b2fb4506b7f91722d19f6edc8a99062bd38b344501e5997d83454c2c55293070b192c40ecf9cbe45d9ff6583b67ca058da04aa5b27de342d46f71a36339d7c73ca62e336c12975a1796ae32aef86df0af962df8fb902dc66d8656f316f287fe6ddf0fc90f8c1df21e987f921e32f7c87456f955f19a7d57de9725be37bf50fc627f85f7d0fe17f25ff1257c2fde9b93636ac1de01f8cfaf2124341b51e7e3ddb56e4455db70266cab72ad76dbab640728cf3213c79f975356c9a3649b095e4430c107c44c51f7e7d5d03f2846ee80f8437146c953a2abb766ce67956a54a8a97f08d90ef08d434c506dc5afb324e4437d875010c553d386ad0c78f0ce064636cd603022ae0f94459c16a626a83133fc042275a32ac07e790c5b286ed2d880b6a67391394d9ee1e5823cc8b7f77f93ac5f9b631fe0ea5eb7af908233807a32b36892b21805083ce257068906629e1e3f7096a1c5fbfd16c72bc94e55742ef186efc1f9f6b95b985d1fa383eb7c4b6fcbf14f69fdc4b63a351a292fe7df33dbfeeafe51a2142eb2582cbe6449eb1c46540ff451ff8e35461d0230aaa65130269c697dbfed2e69ef80f8d7e6a3e351cc67c683db0f955a7733781dfb5aed9dfb36dc9d8b7bb80f708ee69ee0671d6ad7367789956909c641b88a6c88070a3568c3e31b183a6b88784850784e443c3806a5301c710f2c64ebb6070d7e89ea77692b4b880d3c9aab90ae0596c263de9f89bd537e18948a9802eba98efa746c4ee209c49dce742c8c94baae897b54f0499ff5c30f1dcf74f7530dd339f6da0a3f23f507cce9819e9f7d36011c80d9a98500ea2dcd31b4c660ab74547b06ce914b9425ca9e5f438d62ab39d08aa91bc6ff6ee9ea64053096c73608d4a910eedc330e2070f9508e6d8c01595a7ddaffc0abc1f29fefd9de5b23fee461bce8dd5e5bf4ec7cbf873db191f5c41db6f6fefb3f5adbb3628cd615a4b83b1e55138dec75f59f63433d613f778797c4f01786becfb76d991c025433b8a81712007e83b076ad3694e08efdeb5b3bfc8f7c6f20d859ef916eb07b603cb7f78afdc534e5590d1f5ead9996f0d927247cdba26efd12a17e490c1476183eb784fe5d04ae27a0c1548edd843316ba9e1cd966468acc67308d0f3059ce9077bf984e79a1fa94e8f24080682ca985771841c2e19690b16887981d0e85aad3e0017453b00e8a164cb2a22c532cd08ee299a41ac28a328ffd004f42b41f28b673ea6750334c11a8e5ca29e06b00726d19f219f31ad491708b3dc9af3c0d2dbb08bfd31345ae374c914f65777b10332f4e9604aa001426d9bc03c38998038c9323ac2b84b6009eec4517924adcf8c17c19c03f3f4ff3bdf7feb615c43e8bbd3abf6326b46d74babb96b8dd125037dff3f636f3ffbd8ef07a56372ec0ec4c694bdd3c4f10883de29631eff489bde29ae56810356aaae8a40cd6af8753fbb9dea72f53fa9b7ee6f348ff884695ff15ec49fa0d7d557a955db89f424952aeda2031751ac5401d61b957a298eddfaf2520c4860829273421df8345b87d860f6d182c777e3424954e102f1d2aaf30c3828e14528e209c84a15bf22189c78f1a2578f6a8084a34f12a24cc946292576495a28bf64f122dc25f0be00e7ec8655215c0c896c096c0c35679f210c8597912d9912d97a6bfd947779d20112d57903a9e98a7a3ddb5ff26ad2814241d6a51ba8b040c15b7e4790c584e8f2453ba7900846149e429c00465131c24653b541d59360c82572df958b73a72d0b2e5173fe8fc51a3e8b6fd319f1ca04d7a9f7a3e5324e620b33840fc6bd4f4dfdc119719a2e1d190255dc73a9a4fd18d2db283ab45b11a33b32ee26c0f2dc7c7ceae96de5cde0955eba0bd2d726c579e8a7b1d0a833ae3a1506dac892a0cb4c2b82b77e55aaae9c8609321839b77838ddf976ddfb56126cd860a981574985cde74722e453a2a0aeabe9e7d54bba96e2a93aaaa33855c8a875556561aae5b2a71571db153569e8d0d54997d3f6bff8a632217b55a7e97ec15d022720c9e0bb06b6099070dc8238ac9078fc37cc03f4f29b31464c377b54d9de7e7cf2bcd36effa3f50dba3665394c2b6018f476b9224aa6614ca332193305cc7e7f44ca983e343731b7166ef678421433a8660cfc4e515f8321b13a3437061ca90a4c613e948cf98b105f00be6276736e94d79c2be3ef3a37a35fa60fc0fce3be7bd4e27f1506209de70cccccccceaced5cf67272c0cb19dc48c853a2750a5c1c3d193521299ce4724f533657557152d1583684da05d6ba373eada1b6600f335bc63f32fba576658f4ebc540c5c39c578e23007f1588c578fbc7e763e39f1593aeff1d2fa3e36744cce9998e39b1cdb8a5e3957d28cecbd75a3a6f3297efbcccdf30633f7c60eaddfa1777e0287e65430522182277182ab77e051f19964838eefd4433a7385d3b9b6f4e9cbb0864a7cdaad38cd6d2413b4991c1df4163883977602842a55a542789933b406599085974aee0aef190d5ae9040dc18a0c90ae054a17a13684c9a3018d98ee342c8b088b672
2515eb748210351a4416c0eb462ac18f4894ced532ba0e3c3b770131d148b27421228ba0e1ee80a0430a1d606ed969dd7379c7abaa9d39ce4f36539ca699ca90e71f8d0c7339c8e03fde5cd632a00e66f0620f6a30e4df124a0b9018b1cc51e7c69b98c5791dc67a39258ccd6dad1f203200f9a686a7c53e6f317a5f706b68cbc8b338747afd1f6c38ecfebf07e2fecd86d02ab4689a586dc35fa3c6f0c9679efd15cedbb376eafb6cf7f1ada09e163fc7e38ada046da695e78ede6c6664b42301f66c13b7a5271c12b5cb5a9609c9fb964b244e3235866428b04304d38860ee66b61aeba39b0d75d2484c26cd9ab21cc810d0a1cd8c62a1feadc60d3f9177131ad8e6accaf3cce87a9c80a64d93991591ee4fc68740e2c137ca7ecce4d4c234964923bc986a0c98d5f403892c24c9c7b2b4ac5a4998305b0910e1e10918d1310ea19be9928ad3f1a1721abe8670fc562501823c423d1e57380320c1a783301fe223d6bf30560a5b231cc8880d6e89625b9ef6a2c484944b692732ecda99cce4c179a3505bee6a5a39379957443fc21f9901f047c64bf86bf3821ffe6c1b7b0ee97bb8e99824753d1af3ec4fe30509eb993d7d76d10f0fe7689e295102160e8d1c0e0b3702c32072bac52df468ed99ce686d911ce60b395ce0736a0de47cf1ccd0d603aff0394c511c271f0134aa80324e44073b50a90df55554dffe13c952a3160bb8bb8db7e0c528ce452d28b58ee4de4251610064c17c9af9a164ef2619c4acadabe5483fb3f4fc7b38473bd45894662a406c80b72629f187b5f04bd72c1950d36527f7eb9deb65d73cebdceecaba279d1b48f1270e44cfbdfeef7ee8889de78965cb8a8b9a2e58ca644e4f8cafc69695f59577b8465f6934f493c8f5dbfe7944f0b77b791abf02e44ef1db895bf8ed47a2224f2a137b0921171503c14b77ec5b13083081bc8c30a26f62924602dc3e15b2586e11b22e03a332a4955328b922157514a4ca7345099508680aa06ca5611b2cec8cc65e3b2ea6609595abd3316c1c5b299845181a3253303415a51d8611dbf84365e55482fb3bfde6a64b9f6a2a5c62b9cf166e47e915e5b48c9a8988f0e73f606a202ddea8e1d248a5b1134671895623a4e2f01e231c4ae2aecf2b877516734a431f64546c327858b02605f21f8fc060a3b04c153076c50cd0494dd983a41ff52e0afe5d088d58c17b35e60bdb3fc210dd56e6c4f25ca91e8d01bab5141dbfe160efff4dfcd3de597f7bc8bd906fb37dc54ad95059df5b1bae46892fe7b8ebfd6b69ac69abc763d3709a34b30ddc96fa477d0164d732dd7f446ffe56c078a5a4ca5dea5929d7835bea35de3590583a553ede096c1f7ee7dc2f2dcc7842d9f5ec1118396efd0c6d9d0218672586a8d9618c61910e0a29c6a2c5f50c38a4d73423661e20f68a5284910df5b352a450a5b3518751f5b3ca7f761c40d41747d93e40dfcbb7dcb7930efbc77f8fb204eae968aad9bad9d9817df5a18ad4ed55b4cea54b81f245d3d2cdab0dc6b50606d499602a00aeb929d5d9809fc166d148c07d144d8eb47216a857a6a236e541bd36d81e35789affdb14a26fca188ff0b67f8b5a6380e782f5cfa3d2a7747b065351aaa279f342c98a220b0bd83abe6a93bc4cc133fab960ce6a853c6249f8ed796acc2f6110f9be1928e080ca9865574ea1611e35a9eec0b2c493884a91a37166f1a3868f7c45708a7c467846c64a5c779ad27173cebda759b9fc60f86262bff89a8f219d2bb77efca8662a183b77e2c9ae50618334489b00831757a17edbfd94f9106b3a16608980a49833a1ab5656b2a72e8a5501b3ea52004546554c519d2825002b56224e031d6c544d03eb1561e7acfaf4e9995dc19ccc81995df19f0cc90662d807d80662d8664206627705af73f185b05acb40c59c665a3e2c7ccfa571c4a9c12d77448b664f0c99c52bf633b5bc91b000e6abceceee370ba6ab0151ad8d0982c512bdee89478d18d1294086235d314d92356b14b28a5a3941e8f05a12d8a5d6da2060c5db602377b6f887ca2e3226e46b73018a46f9d0037d81567008e35fb8e529ad9593af2385db2641f7bf978c03301105aac6fb79b79766feb7154233582ee69d1a3ce77d1eeff23e3ff5ff6d4de0f3cde620a46cd1a2cb6f7467eb8d3deba245bc0e1d00d460ff56c198622ee5298a31afde37df927e3ec76fda3fea0c1913f0633d122064bb97aa0ddb1f1f8f47e9ba69c641cb33a37369576cb663b63f6fcce361f36654e7692539db07372a16377f55c21d3fe57f0e3b0ee40d148f398490bf042e9ebb1f2838567a1000921e58fe2e3cb8f6d27aea48785d1f9bf6378507f7b41cab6d2b9a8df8ebd4b0a0be1ad1d8be52bc4cbc6d4996124b9a65aa41366d0c05a2b609be6162dc55820428266dad7ca210639aa84a52625d84b612cc1641001e3ea80087fb0a140608641e7b22f6344bb39db1b7443a7a488b0441ca1037e5bcc6607f204bd2f409d9db4b22b15b871811bb0141a36e9c0efd9505343fdb9fd93145be92a031253e8810a428827f10dace0252ca78f41d0c1a346ffaa24888fc76072bec57632576d3f6fdc661fede6d5ad8a636d3b603b0eb60216cfad9757c886dbcbc10307281774837bbb478406a9fb4ce6602ce47069ce76080050d0a7ff234866fc9f8dfc7fd7e88edc835b4d51d0a1e6739a71a9e39cc54a73900e2127259529683fce8a161269c35ed6fb97c9426e6b543dd1b4f4c128914215318451462077181d59b2b350761347674fc478b1c9becb8f8c71485339a865b525f9e92b0db
2509d04334b07d51cd6eafb2fcd4bbbfe0d10b0fea522cbaa8f7d9d57152bad339420b566f0b224a81998fc2427eddfa24e33361018a0027e95e712e65f0cd6ae21ceb8e25e31b631bc6b63bb712e0974524d8ca096990225b008208cd08d84c5d1c01441f48f11291c9965a22e64ac4cc5a44bc4268925bead715accd6b136b4a7d32bb8b45bc4fb857d125ba59d997dc947e28fce8bccaec64f79dfdb8ab7026e092da4538dc44b0b1fc42af128fdb8057946e65d7a73e269cc48bed1e28470e2da982b3d57454a9a404f1432398ce12aa32909d398f1484118cbf05547dfbf243ec38f9d3325fe33d813ecf32314469545211dd0f14c26a74c33de43881d3cf3eb3059de267881bde35bc4af78bef1510f8a5c79a5f7fb91e8b8a12548116987e722baa7a521c6d8cb57ba1c2dba97c2f878817e7360f103a93e40af1f2708fa4de79c2c938a4d8db53aeefc2988103b0c5383d527e30a6c4c800311eb6b309c149cf5112528ea51fdfa00dc831d5ee12892948a06195117837fead321d0cc05535f7098e3b70815a2a2edfd8dd5175a2ec4f214033301231dd8da78d68dd3574bee9918dd805cbeade7535b2afa06a47462b45509e9ec7d481b8706b08aaae9292d1a24d6325c8949787f8745c4a79f8ce6c67db95b70805d02a83dec29cdc599ea0785d0af5fe2a5b9b195ab4aa8b54ca30b22ae914469ad7ca29a56164cdf481569d557d4c7bd1b3c5d27564ab250b12732b000652a5a5786a03f8f912ac4aa6496451a1a8a752f5e29dba4504df1437f1a1d3a4ad1fec4ebdf1564eb9647d4729c38f095d5223f523d201f2822ff1d9475c2e947a68a3a91be7c6090d38efc3c3a2ca2f52a6dba51c6f53a56e014956d9ebb1abf3ccf5cfe0393ea13fd529cce1a8b9b466f376e83bf2d159eded924fb66b79eafbeb6859a7b56604671629279a842abd5bf5a00a418da4dc1cd0939da3993699aa6d8b05ce69b7b5abb5dcd16faab02e35a2fe276cdfa4f5e5faaa895543a592caea324047557c6e90eaa73aa0f83a73684b49a2f63aaad759591d780a2382c02e3a575e3a0d4726a4e7716b9b523a76772ed7b3b4b900379c496711d09b023a94ea47a2eec39859a5a5a66e21b765b5e262b4b8a5c3f52a8a2315555d3a5859fc4ce561710118a37a110d17e94547f5143951fda2fb8e9e895e8e28be92f452b4ca24869908e4dd0364f086d9cf4ee7c56ac525cae7ad480b90c9c49f52e12d3e12d300d05656fb4ca6bbb5c4fe773527a70a48cce4dcc53e54e60ad9803c460cba7a333faae91e5daa19e91faeca60840554a93ad1833bcf3ab3ac0e9c2efc91b6f0e18e589ec9d959a9a960b0a225aead1151a55a840a1831e6d59888b5e4c80262d99078383debf4e42c9e145556a83c2ad9c0157b23d9adde0421b043ceb1249d8eaa59443016d7b43d31710e04ce05d080ddc5ac192da7f87a6337e254429591872fef1c9e4502d0705994c009ab901a9cf3d8b58257a0a0339cda79c039cd6917b528736817416a1a0935a840d420ce7d508603f89c0a3a2db0135356b6713f935d5d0e6d160736f3b9eba3650dba2ed836371b418db74f43bc13c82b2a20d5233baccebf2c17d3ed7c97a3ebf3c5458e9231373b03d331ec9bcd59461c6bbaebab67be127cbcfa65a4af5be6daa26eb931aef95a6aba45176bf40a1e5eb6ab2a4c95d45d2aa84d4ff49fcaf63add92ad93cddef6aebeedc7dfe98e92ae7562766cdc14fc733a1f9c08d75418ffc4f78278f1b637d1498aff19a32d51a8f682bb0475039742845e83e99416fdd6e07910a0c0069520f5d80e72ded52f581308e2ff5e9478cca635ed839eb5f0ddb32855a5c55edf4d3c162fd0ed80b2c78865280f9fbdc4b48116ad23c4a87d0836fddfb82fe078e052505f7a247859e0d767a17391d9c3b879ece0d9e1df336cf1f537e9653fc31f3bfbc27b2217f8f3f01f5c2fd23e794ea94ec19c0e179a3491dff76f9b9f0be81e00a64b0e24fc767ec3f3800aa22f2362780193cc0bec11d601941412c5edd10979ff60ae83a7573bdee5e0fafc6c461396aa3d85b7fcd4bcd4a068e64830739abf75f06db6e8b70e2d2e88eb50520ca3fd42ea07a30d0068334d48936d727a08a445cdd12cef08b5584345c28b4f98a798b289188827a0bf0ed342d30fe6ef914b09e9cb68f74f7beea9fb7799f67a1e8c8fd54a3bb6337434c02e65a5ef7ccdee5eb5de6f4c5efbd517009d5ae2d6d6960bd476251bb028733b246e8059a06ee72c822f32a08530bde1eaa59170ae72374c400a649a88a6e16550ab2b1e354c44629b5c35c97408f9badf46de310fe1e5a7e5bf267d9325653c386d3e1705d5bce575b2f17c2a9ae2c2ff8161b0b7893a58dcfbf7e0db66e47cae352b4d5f476fa308dbcf9aea06f22b200db40b9b72add950950233a4360b032175b6ebfb0a0070828c242092268ea29fd3a2ca330ff744c511bad210a6490926a3875a3d32c4b6fa6249ea116864ded180d5e4406ff22d28679b2d5ae5ea2baa4600b69847f2a8c7e0fa70d4ddcc2530e86d7abcfc2c17687d6b60171e913be5c97e8aa2ffb150894469014b29d490e2407e23d121ff1efa5ee7907e431824a7e8317e551a685c5ebd307dfab5d1851a4e5a36451a401f0008f7e0c196407f5899d8b30d4ba147e3d1022fedaf7d60ad30a51e9e85bccb84b6eaeed9dc37d61d40f015c139e4f24080e7278aec4cd2bda7f952ac6be4d143298aa244be2e2fcf652e8b72ab25cb12f5a58ee5f6124565cea4a2d4e6db04e956b92b711cdba2dc43
217deadf263ce53c94bc8379603e477c6d59cefe4387521dccb7460baaf4bcfd550969e34bbfa482e4c3ea7085c82243c0f56ac6c5dd4b324c16405fe21e9257a8d5b2d5b247e580f586691fea03d40754bf905f9a33ba9390b8eaab1a5c749184a434dd22930fd77379b8003619456f33d5768dbb9799ce623b6d7adbef00276de5bfdcdbd9b74f310f8b0cac32b7c1e6cc39a01b4c6ec5f15d7a445773b84f65b4ee3b4683b7daf76ac672c50c07a3ed51922afd509d576d514ab271035448c1512a93aac6c1a4f5ae94ada39cc512b865f3d0314364190e369dc0c089ed036030d2e61a29ad37cdb282f16f5dda3b9ba32a8327404657b7092bb1a352a4943d2258263d369d2ad07a292ad093ac187d89761eeed2d6d5154b699cd313088bf6d4c6ddd27a383320e09452184e70da6bf4e694a73f9454e0d22614133b81a440cbe7729f3e4d290ad4a7c9a5d418a52ccaec9b399ca602b92436c03ef3ebd5d99b5b5194ce1474456efcf3570d1efca69093fdb2b55e0ef85bd2cb6a57b6fd4bc9fddfeff83e0edffc16e8f22ebb2084337f9eadbafafc996b5e97758c47fadd4b04fedf69393dafb956a44982e45811efdc99b1464c7b41771b5073d993729fec5f7ade950e6a8186c8cbca09f30de2c4cb162af00f6e8bcb2d35f5c7d66b3ae76d96ba3b370bb7cf6e716ef3729b6edf4ded8c71c7b9699681f38fb090fe21f9dfb1df4d2bd54a2f8ecbc3f4ecb93bc0517732ad672956c265fed5eac6aae373b2377a3746c1d5d3334d729d7a06ab5b56a3560ab5562c4a398da06419a85183329440434f5755fadaa980d13dd19d745ca2e7b038ef08a417d5248a7bf966ef35d69e3e09ee0c8582e417af085877e2aea1048dc46feca3620ef4258d5902b634ae540875b15aa74b14ab20aaf70a30dba2626981f1595710da788d5ce8aeb70bb49ac45cfaba1bf233f5373522249141d517175c94464a4b0be2ce7f738cf8d64065b9a1cfc0cbf1465cd999dc19e199d99edb2a4e32722a3a32195cd9322f00b7d783d363a0abc8863e8b2b65fbdf10c7bc3b96fc8251059788e827027fa28eeda0dc09edaa0c4ae892f8278e274cd681841058d84ca662abf93eb13e4a4cb32cb0e60bb6595f46585c557568f5efdb0ccb3267899d3cb338ac7b46c7603018fd9767f8d0daeeed898ab650a8e987da3eb3cb14cfc8beb8f50372b5c33c88c395a43145e993b7974a982ad0858a914f3f47433c8d03b95dc8c77c61d974cd10202de260adde409577e7b28cf5ffe7aa48c866ea9c94a9dd0607a979ca1e19d4f96ec88cf6481c86052367b280fdcf423cbdf7c24105543eb4c87fdd0e064822782cce7b47809fa3508c444f44e6c267a72184182c22409c30cc169a9ba6c9119a4f270ebc7a8ad16216aaf2caf2886c4e72a2cac4b5d145b1c599ec1e05a6a0f3ec9a00dcece803eb8a83dea1027ae74b5a05a945d039dd3c01c61783d3a2f07b176e49dec58c9eeea8031bcb9a5b31a9b8016990add7cb83baf4bcf0793f341e85cd00617920f34c70c80cbdc6f37ded7ea9c51317ee1fd91ba682a7694515899b8d032653453365669af7a7b4036fa699378f325b7a2f15d9870c5161819eda0b587b074d14000509dec3c2b09cfcccc2c588d4b8ce9053f3747a582e2f1dcdd7289c0ca4b7d4c6703ddc5f6b3f89567dfd74f198cef682eaeafe1eabb49b5bf9bcb4aca6b6c3952aabd355c6ce579b5a57fb1ca8d569333a553ff6cf1fe0f559f7e4bcf1517b6edba3b54411b38823485a0efabb29ab3963a09cf120d45d77d616f7e97d9d3b54574beaa9d1f0fee5fd86cb64254f163b4d73b4d9ed37b3d4e966892e56677a53223cedd9573ffa5c08177f716964d542ee7875017bb8ca156b51a4c6b271a1b451c9da6846f49da83684f299ec067ea2934a069d7cd0d8cea496c0c7f8560b119038a5e3650074ebc8c11b597ba36d2752d05f6e94ce7c885c274b6bb69f220c787afa462a14af6b29836378073213fb864b828b832aa38b80318a4feedde1a8ab9b8a356c04bc25bcd74e9d640a029bbf53f4f91fb79c4a209060196b42b97c5fcf95317e2e660a39813fe8bd9954966499664b29578c5f0f49b4a34168435c5340a4469e89b0c3449cb2c9c6b2c9cb2c1adace9c41d9641cd9641d9669cd1841f2206d26005a7ed9d0cfb391dad2d2b2a19c3c9a1a002bdd785033dafa918a302de68f77f16d4c3e9c52ad740076d4d58d463166fedabeb176a07e5a2d78f6b86b711297176d476d716a52cdfa4ce540519c434c934a8531486378be8dc9f49317d260e14a0ce21b2f1b385965f2a86bbc40e3a78251b11a6499334a5119cb8d80f06bf75d351b06639a9d9a85435e1a0514b454d2fe6523d28ed2d6afbe52ae0c94bfb458d06294c7a5c3a58ed2f94bd97ac79a8f7a33857f699463395c4e1a33afa91b9b8572e524c385f75047916bcc775189583cb8235e491552d9db660fec4ebbf96d9ba880f3aa9a1ba1d92d37e1bf3db28b8ecd539896269800b9083da53227bdedcf14785e61a9bcd062db9729b19464c342a536ca67a7f9e5b46aafba4d8e661a756c20b4b645fdbb859b019a6e5746e562e8b11767b1c9489e9c07e7931e245ef7e9e1196aae92e6525cf39a2c448f05dc45da245d983ffee8bb8712781d4f85168bf0e7ff614822808a104c7bb2f0faee467a085d93a00eca52711a9c9c5ae5930834cc787a6a0228e6b6fdd66c2fadad20ea24273bd6b4fe443e276ec0bfcdedd82702db8c0365aaf443d833b04bd4386a0b21dc3c09d6615162
2A678ea82748620368fd74a0b48fd4209be6efcbb6b0aa7c61581473df8a666402c73faf5ee300fa0969f320819a9bfb3b8686910ad571447c150b88d412ed946a4228fd09b2486081ae7de1d06a9be87867ac24759427a0fc1f8cf5ecfcf2c8e8cf8ca4e09e7207f82450b3c9e40f1e7cfdf43df147f5a3dd05225bf347f570562ba4477015d91fd202111d395108d6910aa117a88aa2a2b3f293b5851f266961542ca38655455ccac69620c033e93e905dc45b03705f010db3a5ceba7250c3f49274850857e9acc5ea8e75635969c1e0fac6281aa746b72c11f4bbd339ca92a7f554eed9277eaaa40ee2756edfb39767da79cbb9c307382976328f83a2683f6077aa003ca86d87a4a185e682867ee7c940515792028960ea657f9fad575d1cf769fb9f57b275d00ae2e4f27837c9bae2c61bcab8732b4da6915f25ab56c06127505a2ee1793c5c57581a382c2e42039457885baa701253dc405d2319d50017216d6a811a3413bbf8632580eb89d56b346e8cc2588465bb31b1a22a454a2e8a8e98f9104c04dd6d49f128ea59c8846a523be8077b2067e13a36f4559e8100b23026562d6aa57ec1a3a6ef3e27c670a82a6e985213bf28be378e249e7c59e5185bc0b7d4ad9849086be4660f11b226bb444909e54e2c1c57979d24279286ff61ce1a07ad3033ced3cac7618efda0e70769b33f5114a4ca868aec2ae4dcaaafd418c560756e70e8ead11dfa3974a4a2a0bbc6a4fa4bc4fa4e10d71ad878d67c58374925d0e9d11c20d4e4cd0aeb93b32a37b875faab743b8755dd7eba5d9d69dd2e9fb41ba091790a47f5f75f58c10c03e2749da7ecdeb9bfed9d7dcb1358d66aab91597d7d4a2cefc1b849b0984586abebb6b65eb5acd0f29cc8c244bc01989084f73162cb770682dbde0d31b41da576c6a6b4b6260999cd850ba19b5dc32f974a1ae80f0e56ac5267e666bcaa1399ad44128e68b53666b5a4f5606acc34a1181a6869423035afd2b63cd7bc4f279bdba197c8801a6dd68b8a9a66d0d614f5ec53c3553d7b4669c776ab5f4c8decdabba143c6bc4cc061ae1b21ad56829bdd9cac36b131ab130dac4cb7cc8add73b0c81117f1a1da8a046df27e901b69aad2d1473f2852014f4a340b74aeed7754d98cc52d6606a83ad0a85865b885e9dec2e76145c2dc856772ace2d52b44b4bb12089550a69f62a41dbda3fd30e8e8941ac09b5a3dfee8518a75202c53945fde49997cafca39d475a1e6830b4824ad9c922e168c4cb3e59e014de20314810697962916a96069aa686a9606cc7c718658103f8819a1435263c9aecd8cf916342cd4d695881aa669704f3666c5fe4410db9b9b4ac7181496a197ce7410c1cce7d1f31b10436a7afae80ef500792c169bff1ccd0e9700cd10ff199706d39140f0944004e52b736bff78e92a9eb9d8ffdb36f1203e7a52608a4006dfdc39f49025fdd9c887afa49aa1368a221ccdf49cd492990c6a9560073ed254e1fdf4e21997490dc3fb28884cdfe30bc253f8161b7325574e16b92ae66ba48542648b45ace84b44c2e924ad1a746b3482f2e9c679661c39b4d01229b245577004cc8cfe80606315670a152cb24de0d4cda91a819aaeecf343524437177373fd9b9abe92e75b0973fdb925cf2b9a0faf81737355ed5a0db4963b82fba591f08672804dd95baae8710a1a0cf92ce5f2a73ac519bcdd4137a74d973d5fe82ffe9737fb19dce51282873a1a28507026a3ea33a2174458e1318360f48f9e886469e87a83483b776b0c3c40073007fd06713d535490d006798e5af8e4ce96cb9cd0df494375b895268af4b995dbd745ca34d5df56d7683ba7182faa6b0e4cb3ab3bbc343aa6bb28bea4db1099cde563992c10ad39cecea9693795752fafae4d8d279a622814d6c46e319574f9f96abc560b4d4db5b63f5d270ec051618721c9a05b78ad4d9d929957358d4dad89152431bc822e98525bc5725a5b6633dc448eed4be2179316092bee6c0e94b424827f9124e724abb2499659ca34330c549cd7f38a987b460a9a32841549237b1b854913a81e4cb22964ccecfdd1a9dcfcd303ef5a9d9be1dd5a31f565ecbc8ecbc86b2f9926f09ac66492c54f329248e9c9bee19f26fb89809bee1737d0d36c2243c892d4482a19f69a8ae57f4f42b70b83232245186de52a46311dc212a2a4cd3a49642c19160cad37d31779f0d49602a643f22e1bce444b8d8b5fe3b676d2ca14f6c1a0759c5931bedf3c53da62a28a8524c59d950d49cb3b2cd09668abb242ad9eddcbd3565ed0acbc32734a06cb22e21393ad098549ab664c91180d5ffeb2936d80b2a8c160d933ff94b6476cd6159fdb2bb0ac794a06a41f78f640e2b2640c96780c640771caaf3967f319f49ee9324cc65486348b31a19f49c2fa4dec3ca66379f190dc5ea0f74f951b254570361c2471871a0d1aabf5223d1b0a80f09daa5d555e2a63aa77198d45291bd2b2935b27f67b26f41d393fb25f5250e4906976124e9f0c0d531bcaa8ec77ffa93474ecc683751f2271160f0e713450a74462ecc6c1839bbb0ef33d987b8066b57ffccfcf23e254041ad7be47a66ec075741d4f96d02a516c9bdcc37c351ad06f6f675a2328532583961791c3e05dd5169ab171b63f18ecc5dff6fe0b63c69beee62f76edbc55acda70d9eec17808cf9445dc53ed082333e021815d12f203003cd3c763a219ce763a5831e993a0a788aeb6690b43bc4cd0b1441de3559e8e569551cc66bca24de5601f0b0faf8cd69cb4d4bb2fa22bf1154d29567146569c10cc9dcf1be0ccf28d0070cba74fbc
2D5533fa6f740b89446e17e151b986656eb71f86cf84bfb41fe8bf515f9a2d5b7db3c1a2ff8bec33d53be2b76d6f8d5bd452bf25bb66d9e5917e3f4eff114af6d98e78fc516637a26aca7a2e9e016fadac71f1e4521df2b7eacfdf177cff22f00f5dd1fd29a9dba2bdfb73ba239744f4dca6a9bb1aa6fcc481970bd681e6f9d5ee73f3f5ece4ba5a2e9b0cf467f48417fe2aa42abf6792da70815711512ae56478723f923eed04979f6ff5f6d0d7b1abff48c4351c44d313d468c998c52e2f200d1abb600a62094e62c01cbd169b3c0e6e2e4011d6e1fcbc01763fb9d406b40b862da78754c9eb4c516693717af9936193e77afb5abdaa8f7a4723f0ade53647b5746ce0dcdf9b4bf34866a2fcf98e87fe6aeaadad62ee8847589b0b9961bf1d04bd6386cddead36c7ecfcfafc6f3ba99a95c3715a3b3db8b3eeb9ecb6dbeedf6c17c3727fdfa86edfc72ffd715ff5dbde00e8ee678bfc63a330ee46b1e51c5ad06b40a848a6ecc9c998a68544858b74065c5932ee2d25c028025b064c8044a2ece04d17ee037726350cf48894948971d845883799433ff3873f00b454ea86a2ca338a513614988c2913a81846b7202c249970261105e74e4afcb0f0ed34d60832d109d8a38c55087a09403d9f694342b17f36c9d2412793345add18ef04b48c98a4403af2e2abfa9d002d606621a212b500cbb08eded2d19d95d00ed092f397aecd3b9f11ce385e3abeaa514a52993341239e4e6b9ab7932fe094eff893f525c995964a9baaba655ca36aad642dc9636947d2ddaafad42faa9525e4cc5757556d9c64caf1a4897156cab002d905909df58c3c55c0b896c1e2e6274d0fcbe382547b4c6ae427da24425150d3976bf4d7ee4fa6874869c347b30b10093e0ee0d6bda1e95a04d3105f7501fcdec398ec10afc15342f420bfa198c3d8a904918ce7fe3ad56a7a9cb559ce27f8a64174b713ffa2abd2562c5d3155154acd1383d69c010eaea957596d72e0c4fd7fe002cded8d4ad172098c9fb9db4f8c3a33fb4a9800423cfb790bd2605e43a00540d66c5170176d96f6f5d6df77a27563641a6b91c2e26ab80bf61c9b164ab8a339fe66b86d5e1729aaa4c92cace7ae5c23ae2b8dcd918de5bec66d7a872e8fb1d2a345f4a95f2daed8cb6cadc563bd0d382786764ff977992dcf74dfa17e519a73033c94af07c09cb48b684e267e8b251920ce2987c7e9dc447ceb8305813fc4fbb813fc3e86694fc199f80d9d4067e4f912eccfc39ccb1156023aeed33144edc44b4367201bde33bcc909e2e7a480e3a9643b528e7f90ac047f740ec346e6fe4717369867d53b778386a26abdf4229c0689b391948fb419d9f672325f0a8dbb5386791a66c5fdf9963e55afc9f5c60fb4e7eda3d1e95bbd34ac6d900485461520789bc628cbc6294969fff18bdb8369ecbddbae38038701c3000e1c40e0103b8107c3874142250471164504949243f121561f45654613426ca4c8488049149143b753925996d8e9986252bb6899e2b1b7491fd3ca506b4cdb1eca6276ad54e44d3472dadd326dc4d3329d3ae3362a649ea4ce464aedf449896993401ebdc829e36f6fbb7dddeeef77efbb7beeb4256bbd27fab948dd4244b47a248f11f368e0915b1154f84555c4826762744e0d91658156a3f6f86b62b79cb70db5a6b5ac4f2115c555b520caa2f5fe3e0455e54b7abaebea62d426361a2b70b53e27beaeaa72e838b53ea1ad6ba9532d8b55f0c30b30d8d4dfe6c6f06fbbc4259581ef85abcd6ecfa6fba631bddefc97e83daebdebedd397db9d8164ebfd6b4a6973f67ec042eddf77a5fa9b12312c2fa97c012fb9ef99ac6c532f43bd72a642d3dee197a05903f302da960d97a0497a758d64bd2964650e64f3c4255d30bb109574709f0a43d444fc9208fd964dbb864dce6f77824e7709f1b039a522d463c3967c0ef4e61c4d9b718c43c11d3e55d11c1149951705072451853831beea07553308c20d10c4484dd7909be766047e29bfdf56ef1cdfea33a3a8b696f04ee19488e6360db698da591ab3722fe1cb4e18e25f46f5b36f266470f0c97444c27f0f4981b50857994ed9ddb8bca26f8551224266aced9122cc376b8fadd906f8bc41241f5bb063719ab541bc50a317a86437653e4ca49183923391de57d05c8ebf891e70e3173e2014909b0464ecc552bab592b6cd58f3b3e443093f9bb7aedbe86ec46e17bda2ffa1f1a1fbc3ed43e5870ccfd81a0c6dd4198fede3e605f01757f15b02d2a84a9442fdbe726ec6e5c64eed6046bc608b6b351feeb5f66d85be61cd2d492e3215392f092fd9cf6acfa8da521cc635ee3495668f67f618cea4cfa5fd344fa7f652f6ce2d87ec8221bf14dc1131ae81a83b8aba0afa764ac799968c16d3de1142d7c8a2c155a5239dc2a2335af948a493ae415872e698711a09dcca26fc11406db474e554dc884839650fcd7c6c9432c6e41d4b1848efe7ee1364f5958f64c4931de5fba4c467cf759ba239794de35699c8a1e5c6f31e75522e0476e8964eb0d789323ab13a8a72f1b7b7ba9c5bec25d8594b8b5ef7b2ae42c1e22bff660375200c3598977526ca95d2c52eb17105c07206ab4dc0083b9f0e5cc70620e5cbb3e144e3ede2441053838bbb84d992d4f6d75829d776a8cc982e944654c92336ac7a2aab880f56b6df14d6b73be9888216b925b274fd0e6c305a8e4f2bf6d6fcdf9e57f105832d26124f7c107cbcb4052e665f195f1d97b35ff45d732e862e54f75a5cb6bb72ed5534989813bb23c5d987477993ca7b11d682f621785f120dc1524f7972
25a4f673952179c39c990840c75d0a006a197216c1b06832c844629ce7c9526eea2bfa2601e48d1ca1a654cc5c49c8ccd039bd9cd4eb35e823dcbacc924121341250ce52139dce7225c50ddbbc745639dc522e3b41e4bc9dc1505c768243d04206c0aaefc35361fdad3d80ae27d937c5a61a040c47d6c4473a186d93d80d12c4c84d223905f1a317307fef9fd3fa3d6d409dafb795f5163c3a68d15c07eb1f9fcbfcb4b07b2feded6fbed3697c9c9447ac6fcb4becbdf0fb3da9925bedbfa1aecc4452ec78a7aef050ae60e4ffb7170beff93c1ee614ddc07c6b3e6e2459b660bfbc2140def4c31f5431825e705e6d4c2c262a4e1dcc5efd3ba5e82979b1b799133325e84fc8e9651f268d30bd6ee1bc1c71e659f656c20ae86e96c998bc58ecdddec39f5163ac9e070724f8ed7a739dcce182aff44a94fc7990034aa75d204ac960749e44fd843b87c7bc3ea379736987db684520651cc211f22a38e1e41674726f90a6bcf3a53da5a1bf001f6f5e642bc89565b8ba8fb54b0e0d6e978a6f175eab1b06374358f0f93a0b91573b99c3b04c328f8ae792f877ff1dfc92e5e79a77cbb6ca9fc15e7c615dfb9dfb5d479d475e41051f411307f4941fd9b6839316156622f42fbdebebfd0c33d76548bb3ab6e7bf9ba773ffc0fffb2feb3fc720ef42379dbe3c333c9854986ae11d2d8c23093be62e162f15c5e05bd15e46def75ef56bd8fef2be5b16f5c0c1be79a82a992d134dd483ba8109f1c74c1697c05a802908227d30b2b4ce5214d99c26facb8ddd928f8f3596da96595a3cbbc4fbea26d7def7dee1dba326cbd2ad093dfb68199bf6e9e6f2c6f2ca402ff73ff27b616dfd286c792a1988747bee8f36898fa9978e97409058ce90e7d85553afacf4ae8273088df5f0afac9a8721f9d6db03975235ca5ef216a0b42bfe6235d122526e41a9e00062439330dd2ea1010d621d5ba8291ad0536a361c9a362df40fa202f020227d3f78ea30289e13e2e2dd0d995efaedfd7b84b93e6af4fda99b41ea82f2c5289b0475436a007a626074ab350854ee9edd054ee6ba1550bb1650a16ff4a8114b5c7cf12b5aa794a5b8dbb5cd485af6443fb1a9117b4a0046af88949283859d5ec8855748c4213ae1ca42206e483f018870bae0b5a8b72c82543f32098e8d9613d55badcd55bbadddfbbde14edd107c891a13d11f6c3bc09f7557be111e7e61e802bde5f7929875d20934f5c888e1c10e683044aadd8c5542c65f12784c16c3df5925873701d24989532f45efcbd54381eb53a21217440764ad1feeff4388d3e5456fbab035031dd35f3d2565ea60d4e16e2d4310695b8b4f2427a2415d105b86a54ea14eed8dd30601cdce92d06aeb4eb66df0213a9d68ae62e89521e6d1dc87f2d344d6f23fb57f4efb7d07779b2d1aee851de3b9bd89f44b73ec23abbcb83ffc9da3c5e167656eb4be0ae9f58433a3072a17a5d8c7dd36d199bb3e5b5fb7091a015ee0269bd8351e3b7e8d189a788d4d970883f20f1ec86adea4968c115b751ddddd612d09201d30d5badd93086a6c7a0f18710b674ee931e8926578859548db8c18f32b49282d03606b3feeb1d29d49c4953861bb598799a347b4087afaf6b07bab69d2eb6c9b906f4cc6cd0a0074a070d44939abbba547b32c01a399a84f64fb5199cffa67e67fd6bf920292749db45dbc57d6a15bdc264cd18d2c29bc354d21adcb788458cc73c46e38be05cff1f046f811a1de711b4e6d8e6fe1f747ecfc3db67d627f58aeea5f725f5622ad9ce7e8cf3c9552e792e7c4d7cc75fd6148357eaaf15bcc9df91fc95bfade4c3feace22b4ca2dfab3624b6ebb0154d693d8ec47a0570ee01cf11e081ed95c779d4acf05cf1073b5e7cb2578b9fafed2781338c9e044f017b2ebc7b4f169f1f3b76205d742784bd6036ca222780c2a2345aae411194aee229a16011239569789e541860264f9f9f2c78779531ea0c5b76f1b2a5f4952e2278c956f3d627a1dbcf1f71fd95bc6209f7413b62c5ae882fb283ed7153941ec3f1064e7804dbc8dbe3af0b7c114546ec56e5fa889490f785b4609441145af243115128a032313be0d64603a461f8ef3d7f1e23a1e64ee1d258b1bb2eec7eadce25c003951d72b380d11a571d43e7fca2fc6403dfc9af8959903f908eb12bfaaff40c208b1d6eaf9aebd0f458ebfa5787e4714a1799cf1e71c68e3133895e315ff21870e8963fb821c35fe417942e692b4590576bc43bca70668c051b45f260a40fe410edf8857f2a6a5317aea6aa996ca56eaccafb62a27648b03971656433b8d80162cabbc19ec1d44ca801902a430282e0e70d09039d750a420a4c8db5a306330d1739345e1232eb15c86f8856e3abf19990dfbfd276d1f56cedf8dbf22510d1a66ba29d5e3b5944e530e2715bf45ab080bc4bd0f94fc4c21243e44ac1512b9dd12f224e9c87f9cd4d3ea8d18c5cfcdd6773504debce3128b3ee6a69a34358d3468c5ab5896815c2e13dfc6e5819a260c6f7657e1b7adfc7c471c897c375a983e8e93f5377ee5f48fe56cb7851f2dd39f63635696916ff817e96816dc9e0d9d7562bfcf9a88dbfc4bf47897aa4d7e8d74909ecc9ffc665957a56645d64f3f72e7419846177b319595ce6e9edd9f0499d163ab25844e3e87ca8fedbe6f188087a0a10219050c13b05276063239c0d317a62dbbafe1b75d20e6e31564fae4a34f62363cc3cfb0913b89daf68a6304edc36928da1165f35a195d9801bc1fde591909f37da29bae787bdc55d50a1ae0dae48d7eedc0a41d06fac41444ed37dffd29ae87bbc629a7
20bc3cd331c7b98fe9cedd8cad2bccbc49894fb4f64c5263dbe0b7a7896857524d1f623497e3e54611c46850ca159fc33895a7cacee319d0997e5e70bcff6f3d1ee967f2aa8dadd1d7f06ab13f46d3a7e679809b5bb2bdf3784645e22f8249046779c52227f59456550a0f826dcc74e918cee0fbce8a6d29c106f022ddcfbc32c44095e6bc6a5642a2bd04d706b968744d20637bb09de4c8a0f0105d0cb21dc207fc293614c785605cedfbedbafdaced479b1098317bf4e1f2d5bb156e5ea32acb0ee06a380c60dba3aff1bb39d920a6c8da9c1c10727830b720eee961aa5e69d15bee046fef9b485a22a8434dde56398ebefbba8f7c3afbdf93e00af292ffe2690b29ad92dd353a50d4adf86ecabad2ae80cc864e259d899b37f139fcd1ededfd6c7a6e0f6e34bafcbb4193d3a6d4fcbce67e0e97a3ebcdbed910a4b9fcb1db158b2a3baa70902c815be89c2249bfc4eec3bb25256096eba5e3fba9b4f5cfc7f166d96d1a65c2f6f78cd6e5e6089d14e685b87359fe67fab890861d1ae21c780132fe21fb05ac4393dc217ba1b8406081e10a821fdcaae0181ee4489bac42f7401451a659c2dacbce66f71d685e9027edb40ff967080e701dfb2f0412a103da0c507dc21f5c103dc70836cf505d8158f74213b485fed5059fb172ea1b380c34617031e41ff3e08bbe38773f3b9efdbddf9ad99f6d0d9642dbd61b9db381da647798495254bada6221091adaa8981484b7de7d9a0b79a6744fb0b3959b7df80c0cad517f5a4b558bc6bbbddb5c12b5a49d65569464642aab14532daff598b48b551e64b6ba9dff1e4a64b379921624a57e5b686dd569f6a1bbaf66f56a91d91c063f000383d415abd3f78522ea8522f851a347005d17da8270ab55e91c55f6a8b899191ffb42f62beda10e73750b29eb47139a06ed003a001cc9b406aa8ed81c39fa04c0298831ceb6aaa7417757dbd68ad25eb595f7ab2a8307ab8695f5f40e0e42d1a2863dc551bb2ab1da43d3e61e22a1ea08b43dad54cd466d1b558357251d8ce7529ecf4fb3eb3158e88b86d61ceda81f9f4b6902a5b2768693c34781ab7b249f821767a972a1d8d5c9e017db3b107249551cb549f67681c1e2fa3928d8d547500a168bfbd195f0d0fdb3f70b70d35418cf92030bc7993438fc5520eb92a89d5e64d72f5f9fe9ed56ac3e646d4eda3c22e1f68ab665185e8d9d0ed5fc9451d2918fda1e1ecea7eed5a2d0f5285690d0f9ccb62fb3a1ec5e5579cbe637698b5b798f4475dc9ae70d5ae9c014705794b409c5a27dcad0f7da47a4c5aa87201e4f42a43aa6b83406de50e42db687668215f831401d559c305a31e7866714f7b52f90adc59cabf392ecea6a2e17bac0476bdbc5b51cf54a73847e2eab64a84808df00d08574e9ab80108dadb59e07ad883b71f4281bb5774d5533cc8f2154526d0e87db82152dbdc0cdc076b6e3c9468f8f3e6a7d5aa2418ea6603839440c7455ba477cfe048a6550f181bd732a608e7fe9cacc0df8e80d45581dfa15af8f957f66c5bbfcd6c8df6f14fe6e2aefc4d9747bdb5fbdda80c8f0dfac5b3756d2985b96fc4ca7c21d5c15786e02269dc3a2d5e901a3da40323a1dd39fe032d1beb5fbd5786ee26f558fa0621b00cf84c4260ad0155a586a57e7ef270189265ba2cba9cf0ffd29602078dbfed5839a6ddc58aa34420b1e093cfffa16721c18ad393e8dadd54d7ecfe9b5e9e9af49ac8596739ecce25b0e6647c3deb835856766ac187eb535fb675b38b67f8e55af9acda8aa69d807655ebec9d981cff1e3622a7b5ed7ba7fed5482311700336902b7869ce768cb9c1dcf1ff773e3c22ab819f0ee7034330615c0859dc53d06e018b9e508aaae72432e69a849264962f6812430ae2b78ba1f2d3c42a8479a419a16b118f343d391be3cd13cd0d1878d89e6632cf2063ce69e5e6629191f914d5a41802ac5f40397faa3b45e4a5995d741644e5588d7e983fe6080d0ba8538f503b45607b47ea2401d167d2a02a00f465421a19d1268a3d9d1a74203d68d5a4b9c3a9cd2d0f74ae1f4a0fba10fd29528d53431daf7fb5d5aff6a8fdded7efb3bdacddabdaa7fb5da87fb59a8ded5df5abb56bd5abdaf9b95ed56fb2bb5cbdacf1bebffcc63fe9fc34516a8c0de27ff05bcf1c483ea9873b0163b628bb13b038b09087cec2583d8c7ec3ec5abbbf4cd087056322630e0b78e2ae26b33c075e2e38eb0c7389381381a70db8596ddb81b19989f1932e71f2ec6c6a7e3f189f1c42fa9a513343f8e8e35399e554f4dce35d6ca8696b1a199f2e4fe09d2f29989a96131b1f06389d4fcd1e9a9e5c3adc687a56363137964db293e3ca86a009d2f633e34ba68a785a0ecb2b1a6a15534b27d1f2b1f1e3428119fc8d0fa359e9a5f0c4e8d4f293932d17f1b9a6a76a271389a3b391d64b71e523913a31d4258f4dcc3f2c47a69826a7968b32f189db827a73372a99199e27c72d9f8e594d4766523e8370cf47a3ca47e5da54995cef1d1f1963635d4322e9f6e3190a5189f3d3cac659e4f95cde0d98d2a2cd04aba7a794a5c9c6274661de0cd29c1ee2778f70fb8bd37785de30bb62ca5e21c445fc071afb98cdd638471d117d9c31cc246c2ce59585a918431ef0fa4fb1e5151ebb98fb5a971fb97a7afc516d6056329afb5aa045a4783ef900cc3aa100994826a751900b3bdf002d841439875c9875234402b845704e8a3a35034e8503e2167f03421f10d34257901dda1100e25bd40532f4fdfa007d8e9fb700a67200e3390a383280d98a7d7c988033ff59e0a262d3f73646e6561657274
216e650a6d6a626f642032310a626f203033320a6a0a3335306f646e65310a6a62203020330a6a626f2f0a3c3c646f7250726563756d412820696e75794644502065724320726f7461352e3420312e332e432f0a29746165722820726f75796d415020696e43204644746165720a29726f6572432f6f6974617461446e442820653130323a31373037333131372b313235302732300a292730646f4d2f657461443a442820373130323731373036333131302b3730303027323e0a29276e650a3e6a626f642034310a626f20303c3c0a6a79542f0a2f20657065676150432f0a73746e756f2f0a312061746f5230206574694b2f0a5b207364203020320a5d2052650a3e3e626f646e35310a6a6f2030203c0a6a624c2f203c74676e65363120685220302069462f207265746c6c462f2044657461646f63653e3e20657274730a0d6d61657800080a9060e39c106060632901006399202606a50d25681cb4a16510679694b98ed3019979a5956e2e010aa945ce0a45f9258938320c6af44c1464f58cf54c3819f50c18382a808536c1944903303050933d438057d1b00191c058d700000d0ac5153573646e65616572746e650a6d6a626f642036310a626f203035310a6a6e650a376a626f646572780a20300a66300a373130303030303030303536203020353335300a206630303030313030303030203720303030300a206e30303030363030303030203720303030300a206e30303030343230303030203620303030300a206e30303030363530303030203720303030300a206e30303030383530303030203620303030300a206e30303030333730303030203120303030300a206e30303030313031303030203120303030300a206e30303030363631303030203520303030300a206e30303030343831303030203820303030300a206e30303030363831303030203720303030300a206e30303030383032303030203020303030300a206e30303030323235323030203520303030300a206e30303030343235323030203720303030300a206e30303030313435323030203320303030300a206e30303030383435323030203220303030300a206e30303030353635323030203720303030740a206e6c6961723c0a7265532f0a3c20657a692f0a3731746f6f52302031202f0a52206f666e49203331200a5220302044492f30343c5b463832413143463845333942314231344446383538354438333641343c3e334632413034463846383942314331344533383531424438444641343835334633362f0a5d3e43464450636165726576697435312058522030200a3e3e0a726174736572787435320a660a3737364f4525256bdb0a460000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
16uo_amyuni_viewer_450.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
