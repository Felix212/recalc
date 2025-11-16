HA$PBExportHeader$uo_crystal_report_viewer_115.sru
$PBExportComments$Objekt, welches den neuen Crystal Reports Viewer beinhaltet (Version 11.5)
forward
global type uo_crystal_report_viewer_115 from uo_crystal_report_viewer_interface
end type
type ole_viewer from olecustomcontrol within uo_crystal_report_viewer_115
end type
end forward

global type uo_crystal_report_viewer_115 from uo_crystal_report_viewer_interface
integer height = 900
ole_viewer ole_viewer
end type
global uo_crystal_report_viewer_115 uo_crystal_report_viewer_115

type variables

end variables

forward prototypes
public function integer of_show (ref uo_crystal_report auo_cr)
public function integer resize (integer w, integer h)
public function integer of_print ()
public function integer of_export ()
end prototypes

public function integer of_show (ref uo_crystal_report auo_cr);/*
* Objekt : uo_crystal_report_viewer_115
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
* Objekt : uo_crystal_report_viewer_115
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
* Objekt : uo_crystal_report_viewer_115
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

on uo_crystal_report_viewer_115.create
int iCurrent
call super::create
this.ole_viewer=create ole_viewer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_viewer
end on

on uo_crystal_report_viewer_115.destroy
call super::destroy
destroy(this.ole_viewer)
end on

type ole_viewer from olecustomcontrol within uo_crystal_report_viewer_115
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
integer width = 1339
integer height = 848
integer taborder = 10
boolean border = false
boolean focusrectangle = false
string binarykey = "uo_crystal_report_viewer_115.udo"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Euo_crystal_report_viewer_115.bin 
2100000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000cf10516001ce0dc300000003000000800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036f0892f741c30d44997507bf04aa3f8700000000cf10516001ce0dc3cf10516001ce0dc3000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000007c0000000000000001fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Bffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000071000001e48000015e9ffff000bffff000bffff000bffff000bffff000bffff000bffff000bffff000b0000000bffff000bffff000bffff000bffff000b0000000bffff000bffff000bffff000bffff000b00000008000b0000000bffff000bffff000b0000000b0000000bffff0013ffff000004070000000b0000000000002172000000000000218c00000000000021aa00000000000021ca00000000000021ea000000000000220c000000000000222a00000000000022480000000000002264000000000000228400000000000022a000000000000022be00000000000022dc00000000000022f80000000000002312000000000000232e000000000000234c000000000000236a000000000000238800000000000023a000000000000023c400000000000023dc00000000000024000000000000002426000000000000244000000000000024520000000000002470000000000000249200000000000024aa00000000000024d400000000000024fa0000000000002518000000000000253200000000000025560000000000002576000000000000259800000000000025cc00000000000025ea000000000000260a000000000000263c0000000000002670000000000000269800000000000026b600000000000026ce00000000000026e200000000000026fe000000000000271e000000000000274400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Euo_crystal_report_viewer_115.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
