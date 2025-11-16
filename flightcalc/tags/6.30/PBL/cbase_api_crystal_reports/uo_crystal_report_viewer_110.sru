HA$PBExportHeader$uo_crystal_report_viewer_110.sru
$PBExportComments$Objekt, welches den alten Crystal Reports Viewer beinhaltet (Version 11.0)
forward
global type uo_crystal_report_viewer_110 from uo_crystal_report_viewer_interface
end type
type ole_viewer from olecustomcontrol within uo_crystal_report_viewer_110
end type
end forward

global type uo_crystal_report_viewer_110 from uo_crystal_report_viewer_interface
integer height = 900
ole_viewer ole_viewer
end type
global uo_crystal_report_viewer_110 uo_crystal_report_viewer_110

type variables

end variables

forward prototypes
public function integer of_show (ref uo_crystal_report auo_cr)
public function integer resize (integer w, integer h)
public function integer of_print ()
public function integer of_export ()
end prototypes

public function integer of_show (ref uo_crystal_report auo_cr);/*
* Objekt : uo_crystal_report_viewer_110
* Methode: of_show
* Autor  : Ulrich Paudler
* Datum  : 26.11.2009
*
* Argument(e):
*   keine
*
* Beschreibung: Zeigt den geladenen Crystal Report im Viewer Objekt an.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        U.Paudler    26.11.2009    Erstellung
*   1.1        Dirk Bunk    04.07.2012    Formatierung/Vereinfachung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

// Den Tabtext setzen
this.text = auo_cr.of_get_report_title()

// Den Report in den Viewer laden
ole_viewer.object.ReportSource(auo_cr.of_get_report_object())

// Einstellungen am Report Viewer vornehmen
// Weitere Einstellungen unter:
// http://devlibrary.businessobjects.com/businessobjectsxi/en/devlib.htm#en/RDC_SDK/rdc_com_dg_doc/doc/rdcsdk_com_doc/RDC_ObjectModel8.html
ole_viewer.object.DisplayBorder            = false
ole_viewer.object.DisplayGroupTree         = false
ole_viewer.object.DisplayToolbar           = true
ole_viewer.object.DisplayTabs              = false
ole_viewer.object.EnablePrintButton        = true
ole_viewer.object.EnableExportButton       = true
ole_viewer.object.EnableAnimationCtrl      = true
ole_viewer.object.EnableCloseButton        = false
ole_viewer.object.EnableGroupTree          = false
ole_viewer.object.EnableNavigationControls = true
ole_viewer.object.EnableRefreshButton      = false
ole_viewer.object.EnableZoomControl        = true
ole_viewer.object.EnableSearchControl      = true
ole_viewer.object.EnableSearchExpertButton = false
ole_viewer.object.EnableStopButton         = true

// Report anzeigen
ole_viewer.object.ViewReport()

return 0
end function

public function integer resize (integer w, integer h);/* 
* Funktion: resize
* Beschreibung: Anpassen der Gr$$HEX2$$f600df00$$ENDHEX$$e des OLE Objekts an die Gr$$HEX2$$f600df00$$ENDHEX$$e des Parent Objekts 
* Besonderheit: keine
*
* Argumente:
* 	Name				Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer       Wann          Was und warum
*	1.0        D.Bunk    07.02.2013    Erstellung
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
ole_viewer.resize(w - 32, h - 32)

ole_viewer.visible = true
ole_viewer.SetRedraw(true)

return li_ret
end function

public function integer of_print ();/*
* Objekt : uo_crystal_report_viewer_110
* Methode: of_print
* Autor  : Dirk Bunk
* Datum  : 18.02.2013
*
* Argument(e):
*   keine
*
* Beschreibung: Druckt den angezeigten Crystal Report.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    18.02.2013    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

// Den angezeigten Report drucken
ole_viewer.object.PrintReport()

return 0
end function

public function integer of_export ();/*
* Objekt : uo_crystal_report_viewer_110
* Methode: of_export
* Autor  : Dirk Bunk
* Datum  : 18.02.2013
*
* Argument(e):
*   keine
*
* Beschreibung: Exportiert den angezeigten Crystal Report.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    18.02.2013    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

// Den angezeigten Report exportieren
ole_viewer.object.ExportReport()

return 0
end function

on uo_crystal_report_viewer_110.create
int iCurrent
call super::create
this.ole_viewer=create ole_viewer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_viewer
end on

on uo_crystal_report_viewer_110.destroy
call super::destroy
destroy(this.ole_viewer)
end on

type ole_viewer from olecustomcontrol within uo_crystal_report_viewer_110
event closebuttonclicked ( ref boolean usedefault )
event firstpagebuttonclicked ( ref boolean usedefault )
event lastpagebuttonclicked ( ref boolean usedefault )
event prevpagebuttonclicked ( ref boolean usedefault )
event nextpagebuttonclicked ( ref boolean usedefault )
event gotopagenclicked ( ref boolean usedefault,  integer pagenumber )
event stopbuttonclicked ( integer loadingtype,  ref boolean usedefault )
event refreshbuttonclicked ( ref boolean usedefault )
event printbuttonclicked ( ref boolean usedefault )
event grouptreebuttonclicked ( boolean ocx_visible )
event zoomlevelchanged ( integer zoomlevel )
event searchbuttonclicked ( string searchtext,  ref boolean usedefault )
event drillongroup ( any groupnamelist,  integer drilltype,  ref boolean usedefault )
event showgroup ( any groupnamelist,  ref boolean usedefault )
event selectionformulabuttonclicked ( ref string selctionformula,  ref boolean usedefault )
event selectionformulabuilt ( string selctionformula,  ref boolean usedefault )
event ocx_clicked ( long ocx_x,  long ocx_y,  any eventinfo,  ref boolean usedefault )
event dblclicked ( long ocx_x,  long ocx_y,  any eventinfo,  ref boolean usedefault )
event downloadstarted ( integer loadingtype )
event downloadfinished ( integer loadingtype )
event viewchanging ( long oldviewindex,  long newviewindex )
event viewchanged ( long oldviewindex,  long newviewindex )
event onreportsourceerror ( string errormsg,  long errorcode,  ref boolean usedefault )
event exportbuttonclicked ( ref boolean usedefault )
event searchexpertbuttonclicked ( ref boolean usedefault )
event drillongraph ( long pagenumber,  long ocx_x,  long ocx_y,  ref boolean usedefault )
event drillonsubreport ( any groupnamelist,  string subreportname,  string title,  long pagenumber,  long index,  ref boolean usedefault )
event helpbuttonclicked ( )
event focuschanged ( boolean hasfocus )
event oncontextmenu ( any objectdescription,  long ocx_x,  long ocx_y,  ref boolean usedefault )
event onchangeobjectrect ( any objectdescription,  long ocx_x,  long ocx_y,  long ocx_width,  long ocx_height )
event onlaunchhyperlink ( ref string hyperlink,  ref boolean usedefault )
event viewclosed ( long viewindex )
integer width = 1349
integer height = 828
integer taborder = 10
boolean border = false
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "uo_crystal_report_viewer_110.udo"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
09uo_crystal_report_viewer_110.bin 
2C00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000c9a969f001ce0dc300000003000000800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003460324e84357cfb43eceef85623ae2bf00000000c9a969f001ce0dc3c9a969f001ce0dc3000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000780000000000000001fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
25ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000071000001e7d00001565ffff000bffff000bffff000bffff000bffff000bffff000bffff000bffff000b0000000bffff000bffff000bffff000bffff000b0000000bffff000bffff000bffff000bffff000b00000008000b0000000bffff000bffff000b0000000b0000000bffff0013ffff000004070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
19uo_crystal_report_viewer_110.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
