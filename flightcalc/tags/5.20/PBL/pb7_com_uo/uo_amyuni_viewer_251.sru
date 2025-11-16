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
public subroutine of_print (string as_printer)
public subroutine of_show_page (integer ai_page)
public subroutine of_zoom (integer li_zoom)
public function integer resize (integer w, integer h)
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
*
* Return Codes:
*   Die Anzahl der Seiten des Dokuments
*/

return ole_viewer.object.PageCount
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
* 	Version    Wer         Wann          Was und warum
*	1.0        O.Hoefer    28.08.2008    Erstellung
*  1.1        D.Bunk      31.01.2013    Header hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*   0: OK
*  -1: Fehler
*/

integer li_ret

if ole_viewer.object.Open(as_file, "") = 1 then
	li_ret = 0
else
	li_ret = -1
end if

return li_ret
end function

public subroutine of_print (string as_printer);/* 
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
*
* Return Codes:
*  keine
*/

ole_viewer.object.Print(as_printer, 0)
end subroutine

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
*
* Return Codes:
*  keine
*/

ole_viewer.object.CurrentPage = ai_page
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
*
* Return Codes:
*  keine
*/

ole_viewer.object.ZoomFactor = li_zoom

if li_zoom <= 50 then 
	ole_viewer.object.RulerSize = 0
else
	ole_viewer.object.RulerSize = 24
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
integer width = 1627
integer height = 924
integer taborder = 10
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


Start of PowerBuilder Binary Data Section : Do NOT Edit
05uo_amyuni_viewer_251.bin 
2300000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000099df81f001ce0b89fffffffe000000000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003525ca8d54aed81ee4d9c5cb90b98d5ba0000000099df81f001ce0b8999df81f001ce0b89000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15uo_amyuni_viewer_251.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
