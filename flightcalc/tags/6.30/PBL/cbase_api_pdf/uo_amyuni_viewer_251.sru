HA$PBExportHeader$uo_amyuni_viewer_251.sru
$PBExportComments$Objekt, welches den alten Amyuni PDF Viewer beinhaltet (aus Version 2.51)
forward
global type uo_amyuni_viewer_251 from uo_amyuni_viewer_interface
end type
type ole_viewer from olecustomcontrol within uo_amyuni_viewer_251
end type
end forward

global type uo_amyuni_viewer_251 from uo_amyuni_viewer_interface
ole_viewer ole_viewer
end type
global uo_amyuni_viewer_251 uo_amyuni_viewer_251

type variables
PRIVATE:
string is_LicenseCompany = "LSG Sky Chefs"
string is_LicenseKey = "07EFCDAB0100010054F8D2FC7D37B306DDB5B09B69459572452654C763272DF9AFE8AFCA8C9244D4C64254353BC082B2B0755E75ED91F5F6781AE565DB4182193B513249896ABE8A16504C13704686CFF252F18D27C5CB59DA0B699FA8E6"
end variables

forward prototypes
public function integer of_get_page_count ()
public function integer of_open (string as_file)
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
// Objekt : uo_amyuni_viewer_251
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

on uo_amyuni_viewer_251.create
int iCurrent
call super::create
this.ole_viewer=create ole_viewer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_viewer
end on

on uo_amyuni_viewer_251.destroy
call super::destroy
destroy(this.ole_viewer)
end on

event constructor;call super::constructor;/////////////////////////////////////////////////
// Ein paar Initialwerte des Viewer OCX setzen //
/////////////////////////////////////////////////
ole_viewer.object.StatusBar = false

// In dieser Version muss Navigation falsch geschrieben werden :)
ole_viewer.object.VerticalNaviguationBar = false
ole_viewer.object.SetLicenseKey(is_LicenseCompany, is_LicenseKey)
end event

type ole_viewer from olecustomcontrol within uo_amyuni_viewer_251
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
integer width = 1317
integer height = 768
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_amyuni_viewer_251.udo"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

event printpage(long pagenumber, ref long ocx_continue);integer i
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

event refresh();// Refresh Event nach oben weitergeben
PARENT.EVENT ue_refresh()
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
05uo_amyuni_viewer_251.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15uo_amyuni_viewer_251.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
