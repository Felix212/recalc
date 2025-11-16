HA$PBExportHeader$uo_report_preview_toolbar.sru
$PBExportComments$Toolbar im Reportbrowser
forward
global type uo_report_preview_toolbar from userobject
end type
type p_save from picture within uo_report_preview_toolbar
end type
type p_print from picture within uo_report_preview_toolbar
end type
type p_mail from picture within uo_report_preview_toolbar
end type
type p_web from picture within uo_report_preview_toolbar
end type
type p_acrobat from picture within uo_report_preview_toolbar
end type
type p_excel from picture within uo_report_preview_toolbar
end type
type p_z_out from picture within uo_report_preview_toolbar
end type
type p_z_in from picture within uo_report_preview_toolbar
end type
type st_5 from statictext within uo_report_preview_toolbar
end type
type cbx_1 from checkbox within uo_report_preview_toolbar
end type
type em_zoom from editmask within uo_report_preview_toolbar
end type
type p_hide from picture within uo_report_preview_toolbar
end type
type p_last from picture within uo_report_preview_toolbar
end type
type p_next from picture within uo_report_preview_toolbar
end type
type p_prev from picture within uo_report_preview_toolbar
end type
type p_first from picture within uo_report_preview_toolbar
end type
type st_marker from statictext within uo_report_preview_toolbar
end type
type ln_1 from line within uo_report_preview_toolbar
end type
type ln_2 from line within uo_report_preview_toolbar
end type
type st_1 from statictext within uo_report_preview_toolbar
end type
type ln_4 from line within uo_report_preview_toolbar
end type
type ln_5 from line within uo_report_preview_toolbar
end type
type ln_8 from line within uo_report_preview_toolbar
end type
type ln_9 from line within uo_report_preview_toolbar
end type
type em_change from editmask within uo_report_preview_toolbar
end type
type st_7 from statictext within uo_report_preview_toolbar
end type
type ln_3 from line within uo_report_preview_toolbar
end type
type ln_33 from line within uo_report_preview_toolbar
end type
type ln_6 from line within uo_report_preview_toolbar
end type
type ln_7 from line within uo_report_preview_toolbar
end type
type ln_10 from line within uo_report_preview_toolbar
end type
type ln_11 from line within uo_report_preview_toolbar
end type
type ln_12 from line within uo_report_preview_toolbar
end type
type ln_13 from line within uo_report_preview_toolbar
end type
type ln_14 from line within uo_report_preview_toolbar
end type
type ln_15 from line within uo_report_preview_toolbar
end type
type ln_16 from line within uo_report_preview_toolbar
end type
type ln_17 from line within uo_report_preview_toolbar
end type
type ln_144 from line within uo_report_preview_toolbar
end type
type ln_155 from line within uo_report_preview_toolbar
end type
end forward

global type uo_report_preview_toolbar from userobject
integer width = 2405
integer height = 152
long backcolor = 80269524
string text = "1"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_execute ( integer ifunction )
event ue_killfocus pbm_killfocus
event ue_mousemove pbm_mousemove
event ue_excel ( )
event ue_acrobat ( )
event ue_web ( )
event ue_message ( string smessage )
event ue_mail ( )
event ue_print ( )
event ue_save ( )
event ue_page ( )
p_save p_save
p_print p_print
p_mail p_mail
p_web p_web
p_acrobat p_acrobat
p_excel p_excel
p_z_out p_z_out
p_z_in p_z_in
st_5 st_5
cbx_1 cbx_1
em_zoom em_zoom
p_hide p_hide
p_last p_last
p_next p_next
p_prev p_prev
p_first p_first
st_marker st_marker
ln_1 ln_1
ln_2 ln_2
st_1 st_1
ln_4 ln_4
ln_5 ln_5
ln_8 ln_8
ln_9 ln_9
em_change em_change
st_7 st_7
ln_3 ln_3
ln_33 ln_33
ln_6 ln_6
ln_7 ln_7
ln_10 ln_10
ln_11 ln_11
ln_12 ln_12
ln_13 ln_13
ln_14 ln_14
ln_15 ln_15
ln_16 ln_16
ln_17 ln_17
ln_144 ln_144
ln_155 ln_155
end type
global uo_report_preview_toolbar uo_report_preview_toolbar

type variables
integer iPage
Integer iPageCount
picture ipPic[]

Integer iExcel = 0

datawindow	oDW






end variables

forward prototypes
public function integer of_set_page ()
public function integer of_hide_marker ()
public function integer of_set_marker (picture ppic)
public function integer of_set_max (integer imaxpage)
public function long of_init ()
end prototypes

event ue_execute(integer ifunction);
choose case iFunction
		
	case 1
		// --------------------------
		// First Page
		// --------------------------
		
	case 2
		// --------------------------
		// Prev Page
		// --------------------------
	case 3
		// --------------------------
		// Next Page
		// --------------------------	
	case 4
		// --------------------------
		// Last Page
		// --------------------------	
	case 5
		// --------------------------
		// Eingabe ins SingleLineEdit
		// --------------------------	
	
End choose
end event

event ue_killfocus;Integer i

of_hide_marker()

for i = 1 to UpperBound(ipPic)
	ipPic[i].tag = "OFF"
next

end event

event ue_mousemove;Integer i

of_set_marker(p_hide)

for i = 1 to UpperBound(ipPic)
	ipPic[i].tag = "OFF"
next



end event

event ue_page();Long lRow

lRow = Long(oDW.Describe("datawindow.firstrowonpage"))

if lRow > 0 then
	 iPage = oDW.GetItemNumber(lRow, "compute_currentpage")
	of_set_page()
end if
end event

public function integer of_set_page ();em_change.Text = String(iPage)

return 0
end function

public function integer of_hide_marker ();// ---------------------------------
// Den Marker hinter das jeweilige
// Picture setzen
// ---------------------------------

st_marker.X = p_hide.X - 4
st_marker.Y = p_hide.Y - 4
st_marker.Width = p_hide.Width + 14
st_marker.Height = p_hide.Height + 8

return 0
end function

public function integer of_set_marker (picture ppic);// ---------------------------------
// Den Marker hinter das jeweilige
// Picture setzen
// ---------------------------------

st_marker.X = pPic.X - 4
st_marker.Y = pPic.Y - 4
st_marker.Width = pPic.Width + 14
st_marker.Height = pPic.Height + 8

return 0
end function

public function integer of_set_max (integer imaxpage);
iPageCount     = iMaxPage
return 0
end function

public function long of_init ();Integer  i
String	sZoom
String	sProcessing

iPageCount = 0
if oDW.RowCount() > 0 then
	
	//------------------------------------------------------------------------------------------------------------------ 
	// Ich (Feussi) habe ne kleine Pr$$HEX1$$fc00$$ENDHEX$$fung eingebaut ob das DW ein Crosstab ist, falls ja, dann keinen create compute
	//------------------------------------------------------------------------------------------------------------------ 
	
	sProcessing = oDW.Describe("DataWindow.Processing")
	if long(sProcessing) <> 4 then
		oDW.Modify("create compute(band=detail alignment='0' expression='pagecount()' border='0' color='0' x='374' y='2' height='19' width='56' format='[GENERAL]'  name=compute_pagecounter visible='1~t0'  font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )")
		oDW.Modify("create compute(band=detail alignment='0' expression='page()' border='0' color='0' x='374' y='2' height='19' width='56' format='[GENERAL]'  name=compute_currentpage visible='1~t0'  font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )")
	
		iPage = 1
		iPageCount = oDW.GetItemNumber(1, "compute_pagecounter")
		
	end if


	//---------------------------------------------------------
	// Datawindow hat mindestens eine Seite in der Preview
	// Erstmal alle Buttons anschalten
	//---------------------------------------------------------
	for i = 1 to UpperBound(ipPic)
		ipPic[i].tag = "OFF"
		ipPic[i].Enabled = True
	next
		
	//---------------------------------------------------------
	// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob Excel l$$HEX1$$e400$$ENDHEX$$uft
	//---------------------------------------------------------
	if this.iExcel = 0 then
		p_excel.enabled = false
	else
		p_excel.enabled = true
	end if
	
	//---------------------------------------------------------
	// Die letzte Zoom Einstellung setzten
	//---------------------------------------------------------
	sZoom = ProfileString(s_app.sProfile, "PrintPreview", "Zoomfactor", "100" )
	em_zoom.Text = sZoom + " %"
	oDW.Modify ("DataWindow.Print.Preview.Zoom=" + sZoom) 
	
	p_save.Enabled = false
	
else
	
	of_set_marker(p_hide)
	
	//
	// 16.03.2006 Drucken soll immer m$$HEX1$$f600$$ENDHEX$$glich sein
	//	ipPic[12] = p_print
	//
	ipPic[12].Enabled = True

end if

return iPageCount
end function

on uo_report_preview_toolbar.create
this.p_save=create p_save
this.p_print=create p_print
this.p_mail=create p_mail
this.p_web=create p_web
this.p_acrobat=create p_acrobat
this.p_excel=create p_excel
this.p_z_out=create p_z_out
this.p_z_in=create p_z_in
this.st_5=create st_5
this.cbx_1=create cbx_1
this.em_zoom=create em_zoom
this.p_hide=create p_hide
this.p_last=create p_last
this.p_next=create p_next
this.p_prev=create p_prev
this.p_first=create p_first
this.st_marker=create st_marker
this.ln_1=create ln_1
this.ln_2=create ln_2
this.st_1=create st_1
this.ln_4=create ln_4
this.ln_5=create ln_5
this.ln_8=create ln_8
this.ln_9=create ln_9
this.em_change=create em_change
this.st_7=create st_7
this.ln_3=create ln_3
this.ln_33=create ln_33
this.ln_6=create ln_6
this.ln_7=create ln_7
this.ln_10=create ln_10
this.ln_11=create ln_11
this.ln_12=create ln_12
this.ln_13=create ln_13
this.ln_14=create ln_14
this.ln_15=create ln_15
this.ln_16=create ln_16
this.ln_17=create ln_17
this.ln_144=create ln_144
this.ln_155=create ln_155
this.Control[]={this.p_save,&
this.p_print,&
this.p_mail,&
this.p_web,&
this.p_acrobat,&
this.p_excel,&
this.p_z_out,&
this.p_z_in,&
this.st_5,&
this.cbx_1,&
this.em_zoom,&
this.p_hide,&
this.p_last,&
this.p_next,&
this.p_prev,&
this.p_first,&
this.st_marker,&
this.ln_1,&
this.ln_2,&
this.st_1,&
this.ln_4,&
this.ln_5,&
this.ln_8,&
this.ln_9,&
this.em_change,&
this.st_7,&
this.ln_3,&
this.ln_33,&
this.ln_6,&
this.ln_7,&
this.ln_10,&
this.ln_11,&
this.ln_12,&
this.ln_13,&
this.ln_14,&
this.ln_15,&
this.ln_16,&
this.ln_17,&
this.ln_144,&
this.ln_155}
end on

on uo_report_preview_toolbar.destroy
destroy(this.p_save)
destroy(this.p_print)
destroy(this.p_mail)
destroy(this.p_web)
destroy(this.p_acrobat)
destroy(this.p_excel)
destroy(this.p_z_out)
destroy(this.p_z_in)
destroy(this.st_5)
destroy(this.cbx_1)
destroy(this.em_zoom)
destroy(this.p_hide)
destroy(this.p_last)
destroy(this.p_next)
destroy(this.p_prev)
destroy(this.p_first)
destroy(this.st_marker)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.st_1)
destroy(this.ln_4)
destroy(this.ln_5)
destroy(this.ln_8)
destroy(this.ln_9)
destroy(this.em_change)
destroy(this.st_7)
destroy(this.ln_3)
destroy(this.ln_33)
destroy(this.ln_6)
destroy(this.ln_7)
destroy(this.ln_10)
destroy(this.ln_11)
destroy(this.ln_12)
destroy(this.ln_13)
destroy(this.ln_14)
destroy(this.ln_15)
destroy(this.ln_16)
destroy(this.ln_17)
destroy(this.ln_144)
destroy(this.ln_155)
end on

event constructor;Integer i

ipPic[1] = p_first
ipPic[2] = p_prev
ipPic[3] = p_next
ipPic[4] = p_last
ipPic[5] = p_hide
ipPic[6] = p_z_out
ipPic[7] = p_z_in
ipPic[8] = p_excel
ipPic[9] = p_acrobat
ipPic[10] = p_web
ipPic[11] = p_mail
ipPic[12] = p_print
ipPic[13] = p_save

for i = 1 to UpperBound(ipPic)
	ipPic[i].enabled = False
next

cbx_1.Text = uf.translate("Druckvorschau")

end event

type p_save from picture within uo_report_preview_toolbar
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 1897
integer y = 24
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_save.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	
	of_set_marker(this)
//	Messagebox("", "drin")
	
	for i = 1 to UpperBound(ipPic)
		
		if ipPic[i] = this then
			ipPic[i].tag = "ON"
		else
			ipPic[i].tag = "OFF"
		end if
		
	next

end if


parent.Trigger Event ue_message("Report Speichern")
end event

event ue_enable;Integer i

if enable then
	this.picturename = "..\Resource\report_save.gif"
else
	this.picturename = "..\Resource\report_save_disabled.gif"
end if

this.enabled = enable

//Messagebox("", this.enabled)





end event

event clicked;Parent.Trigger Event ue_save()
end event

type p_print from picture within uo_report_preview_toolbar
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 1751
integer y = 24
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_print.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	
	of_set_marker(this)

	for i = 1 to UpperBound(ipPic)
		
		if ipPic[i] = this then
			ipPic[i].tag = "ON"
		else
			ipPic[i].tag = "OFF"
		end if
		
	next

end if

parent.Trigger Event ue_message("Drucken")


end event

event clicked;Parent.Trigger Event ue_print()
end event

type p_mail from picture within uo_report_preview_toolbar
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 1413
integer y = 20
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_mail.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	
	of_set_marker(this)

	for i = 1 to UpperBound(ipPic)
		
		if ipPic[i] = this then
			ipPic[i].tag = "ON"
		else
			ipPic[i].tag = "OFF"
		end if
		
	next

end if

parent.Trigger Event ue_message("E-Mail versenden")
end event

event ue_enable;if enable then
	this.picturename = "..\Resource\report_mail.gif"
else
	this.picturename = "..\Resource\report_mail_disabled.gif"
end if



end event

event clicked;Parent.Trigger Event ue_mail()
end event

type p_web from picture within uo_report_preview_toolbar
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 1362
integer y = 196
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_web.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	
	of_set_marker(this)

	for i = 1 to UpperBound(ipPic)
		
		if ipPic[i] = this then
			ipPic[i].tag = "ON"
		else
			ipPic[i].tag = "OFF"
		end if
		
	next

end if

parent.Trigger Event ue_message("HTML-Datei erzeugen")
end event

event clicked;Parent.Trigger Event ue_web()
end event

type p_acrobat from picture within uo_report_preview_toolbar
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 1243
integer y = 16
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_acrobat.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	
	of_set_marker(this)

	for i = 1 to UpperBound(ipPic)
		
		if ipPic[i] = this then
			ipPic[i].tag = "ON"
		else
			ipPic[i].tag = "OFF"
		end if
		
	next

end if

parent.Trigger Event ue_message("PDF-Datei erzeugen")
end event

event ue_enable;if enable then
	this.picturename = "..\Resource\report_acrobat.gif"
else
	this.picturename = "..\Resource\report_acrobat_disabled.gif"
end if


end event

event clicked;Parent.Trigger Event ue_acrobat()
end event

type p_excel from picture within uo_report_preview_toolbar
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 1582
integer y = 20
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_excel.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	
	of_set_marker(this)

	for i = 1 to UpperBound(ipPic)
		
		if ipPic[i] = this then
			ipPic[i].tag = "ON"
		else
			ipPic[i].tag = "OFF"
		end if
		
	next

end if

parent.Trigger Event ue_message("Excel-Datei erzeugen")

end event

event ue_enable;if enable then
	this.picturename = "..\Resource\report_excel.gif"
else
	this.picturename = "..\Resource\report_excel_disabled.gif"
end if


end event

event clicked;Parent.Trigger Event ue_excel()

end event

type p_z_out from picture within uo_report_preview_toolbar
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 352
integer y = 16
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_zoomout.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i


if this.Tag <> "ON" then
	
	of_set_marker(this)

	for i = 1 to UpperBound(ipPic)
		
		if ipPic[i] = this then
			ipPic[i].tag = "ON"
		else
			ipPic[i].tag = "OFF"
		end if
		
	next

end if

parent.Trigger Event ue_message("vergr$$HEX2$$f600df00$$ENDHEX$$ern")
end event

event ue_enable;if enable then
	this.picturename = "..\Resource\report_zoomout.gif"
else
	this.picturename = "..\Resource\report_zoomout_disabled.gif"
end if


end event

event clicked;Integer iZoom
Integer iDiff
Integer iZoomToAdd


iZoom = Integer(Trim(MidA(em_zoom.text, 1, LenA(em_zoom.text) - 1)))

iDiff = Mod(iZoom, 25)

if iDiff <> 0 then
	
	iZoom = iZoom + (25 - iDiff)
	
else
	
	iZoom += 25
	
end if

if iZoom > 500 then
	Beep(2)
	return 0
else
		
	em_zoom.text = String(iZoom) + " %"
	SetProfileString(s_app.sProfile, "PrintPreview", "Zoomfactor", String(iZoom) )
	oDW.Modify ("DataWindow.Print.Preview.Zoom=" + String(iZoom)) 
	
end if


end event

type p_z_in from picture within uo_report_preview_toolbar
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 37
integer y = 16
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_zoomin.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	
	of_set_marker(this)

	for i = 1 to UpperBound(ipPic)
		
		if ipPic[i] = this then
			ipPic[i].tag = "ON"
		else
			ipPic[i].tag = "OFF"
		end if
		
	next

end if

parent.Trigger Event ue_message("verkleinern")


end event

event ue_enable;if enable then
	this.picturename = "..\Resource\report_zoomin.gif"
else
	this.picturename = "..\Resource\report_zoomin_disabled.gif"
end if


end event

event clicked;Integer iZoom
Integer iDiff

iZoom = Integer(Trim(MidA(em_zoom.text, 1, LenA(em_zoom.text) - 1))) 

iDiff = Mod(iZoom, 25)

if iDiff <> 0 then
	
	iZoom = iZoom + (25 - iDiff) - 25
	
else
	
	iZoom -= 25
	
end if

if iZoom < 25 then
	Beep(2)
	return 0
else
	em_zoom.text = String(iZoom) + " %"
	SetProfileString(s_app.sProfile, "PrintPreview", "Zoomfactor", String(iZoom) )
	oDW.Modify ("DataWindow.Print.Preview.Zoom=" + String(iZoom)) 
end if


end event

type st_5 from statictext within uo_report_preview_toolbar
boolean visible = false
integer x = 421
integer y = 408
integer width = 183
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean focusrectangle = false
end type

type cbx_1 from checkbox within uo_report_preview_toolbar
boolean visible = false
integer x = 50
integer y = 292
integer width = 690
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Druckvorschau"
end type

event clicked;//If this.checked Then
//	em_preview.visible 	= True
//	st_1.visible 			= True
//	Parent.Trigger Event ue_execute(7)
//Else
//	em_preview.visible 	= False
//	st_1.visible 			= False
//	Parent.Trigger Event ue_execute(8)
//End if	
//
end event

type em_zoom from editmask within uo_report_preview_toolbar
integer x = 160
integer y = 24
integer width = 165
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "74"
boolean border = false
alignment alignment = center!
maskdatatype maskdatatype = stringmask!
end type

event modified;
String sText

if not isnumber(this.Text) or integer(this.Text) > 500 or integer(this.Text) < 25 then
	this.text = ProfileString(s_app.sProfile, "PrintPreview", "Zoomfactor", "100" )
else
	oDW.Modify ("DataWindow.Print.Preview.Zoom=" + this.text) 
	SetProfileString(s_app.sProfile, "PrintPreview", "Zoomfactor", String(this.text) )
	this.text = this.text + " %"
end if

end event

type p_hide from picture within uo_report_preview_toolbar
event ue_mouse_move pbm_mousemove
boolean visible = false
integer x = 256
integer y = 408
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\page_last.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i


if this.Tag <> "ON" then
	
	of_set_marker(this)

	for i = 1 to UpperBound(ipPic)
		
		if ipPic[i] = this then
			ipPic[i].tag = "ON"
		else
			ipPic[i].tag = "OFF"
		end if
		
	next

end if

end event

event clicked;Parent.Trigger Event ue_execute(4)
end event

type p_last from picture within uo_report_preview_toolbar
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 1074
integer y = 16
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\page_last.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	
	of_set_marker(this)

	for i = 1 to UpperBound(ipPic)
		
		if ipPic[i] = this then
			ipPic[i].tag = "ON"
		else
			ipPic[i].tag = "OFF"
		end if
		
	next

end if

parent.Trigger Event ue_message("letzte Seite")
end event

event ue_enable;if enable then
	this.picturename = "..\Resource\page_last.gif"
else
	this.picturename = "..\Resource\page_last_disabled.gif"
end if


end event

event clicked;
oDW.ScrollToRow(oDW.RowCount())
iPage = iPageCount
of_set_page()
end event

type p_next from picture within uo_report_preview_toolbar
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 960
integer y = 16
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\page_next.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i


if this.Tag <> "ON" then
	
	of_set_marker(this)

	for i = 1 to UpperBound(ipPic)
		
		if ipPic[i] = this then
			ipPic[i].tag = "ON"
		else
			ipPic[i].tag = "OFF"
		end if
		
	next

end if

parent.Trigger Event ue_message("eine Seite vor")
end event

event ue_enable;if enable then
	this.picturename = "..\Resource\page_next.gif"
else
	this.picturename = "..\Resource\page_next_disabled.gif"
end if


end event

event clicked;

if iPage < iPageCount then
	oDW.ScrollNextPage()
	iPage ++
	of_set_page()
end if




end event

type p_prev from picture within uo_report_preview_toolbar
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 622
integer y = 16
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\page_prev.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	
	of_set_marker(this)

	for i = 1 to UpperBound(ipPic)
		
		if ipPic[i] = this then
			ipPic[i].tag = "ON"
			
		else
			ipPic[i].tag = "OFF"
		end if
		
	next

end if

parent.Trigger Event ue_message("eine Seite zur$$HEX1$$fc00$$ENDHEX$$ck")
end event

event ue_enable;if enable then
	this.picturename = "..\Resource\page_prev.gif"
else
	this.picturename = "..\Resource\page_prev_disabled.gif"
end if


end event

event clicked;
if iPage > 1 then
	oDW.ScrollPriorPage()
	iPage --
	of_set_page()
end if
end event

type p_first from picture within uo_report_preview_toolbar
event ue_mouse_move pbm_mousemove
event ue_enabled pbm_enable
integer x = 512
integer y = 16
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\page_first.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i


if this.Tag <> "ON" then
	
	of_set_marker(this)

	for i = 1 to UpperBound(ipPic)
		
		if ipPic[i] = this then
			ipPic[i].tag = "ON"
		else
			ipPic[i].tag = "OFF"
		end if
		
	next

end if

parent.Trigger Event ue_message("erste Seite")
end event

event ue_enabled;
if enable then
	this.picturename = "..\Resource\page_first.gif"
else
	this.picturename = "..\Resource\page_first_disabled.gif"
end if


end event

event clicked;
if oDW.RowCount() > 0 then
	oDW.ScrollToRow(1)
	iPage = 1
	of_set_page()
end if

end event

type st_marker from statictext within uo_report_preview_toolbar
integer x = 46
integer y = 384
integer width = 151
integer height = 108
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type ln_1 from line within uo_report_preview_toolbar
long linecolor = 8421504
integer linethickness = 1
integer beginx = 146
integer beginy = 12
integer endx = 329
integer endy = 12
end type

type ln_2 from line within uo_report_preview_toolbar
long linecolor = 8421504
integer linethickness = 1
integer beginx = 146
integer beginy = 16
integer endx = 146
integer endy = 96
end type

type st_1 from statictext within uo_report_preview_toolbar
integer x = 151
integer y = 16
integer width = 183
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean focusrectangle = false
end type

type ln_4 from line within uo_report_preview_toolbar
boolean visible = false
long linecolor = 8421504
integer linethickness = 1
integer beginx = 416
integer beginy = 404
integer endx = 599
integer endy = 404
end type

type ln_5 from line within uo_report_preview_toolbar
boolean visible = false
long linecolor = 8421504
integer linethickness = 1
integer beginx = 416
integer beginy = 408
integer endx = 416
integer endy = 500
end type

type ln_8 from line within uo_report_preview_toolbar
long linecolor = 8421504
integer linethickness = 1
integer beginx = 741
integer beginy = 12
integer endx = 923
integer endy = 12
end type

type ln_9 from line within uo_report_preview_toolbar
long linecolor = 8421504
integer linethickness = 1
integer beginx = 741
integer beginy = 16
integer endx = 741
integer endy = 96
end type

type em_change from editmask within uo_report_preview_toolbar
integer x = 750
integer y = 28
integer width = 165
integer height = 60
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
string text = "1"
boolean border = false
alignment alignment = center!
boolean displayonly = true
string mask = "##"
end type

event modified;// Parent.Trigger Event ue_execute(5)
end event

type st_7 from statictext within uo_report_preview_toolbar
integer x = 745
integer y = 16
integer width = 183
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean focusrectangle = false
end type

type ln_3 from line within uo_report_preview_toolbar
long linecolor = 8421504
integer linethickness = 1
integer beginx = 471
integer beginy = 12
integer endx = 471
integer endy = 108
end type

type ln_33 from line within uo_report_preview_toolbar
long linecolor = 16777215
integer linethickness = 1
integer beginx = 475
integer beginy = 12
integer endx = 475
integer endy = 108
end type

type ln_6 from line within uo_report_preview_toolbar
long linecolor = 8421504
integer linethickness = 1
integer beginx = 1198
integer beginy = 12
integer endx = 1198
integer endy = 108
end type

type ln_7 from line within uo_report_preview_toolbar
long linecolor = 16777215
integer linethickness = 1
integer beginx = 1202
integer beginy = 12
integer endx = 1202
integer endy = 108
end type

type ln_10 from line within uo_report_preview_toolbar
long linecolor = 8421504
integer linethickness = 1
integer beginx = 1367
integer beginy = 12
integer endx = 1367
integer endy = 108
end type

type ln_11 from line within uo_report_preview_toolbar
long linecolor = 16777215
integer linethickness = 1
integer beginx = 1371
integer beginy = 12
integer endx = 1371
integer endy = 108
end type

type ln_12 from line within uo_report_preview_toolbar
long linecolor = 8421504
integer linethickness = 1
integer beginx = 1367
integer beginy = 12
integer endx = 1367
integer endy = 108
end type

type ln_13 from line within uo_report_preview_toolbar
long linecolor = 16777215
integer linethickness = 1
integer beginx = 1371
integer beginy = 12
integer endx = 1371
integer endy = 108
end type

type ln_14 from line within uo_report_preview_toolbar
long linecolor = 8421504
integer linethickness = 1
integer beginx = 1541
integer beginy = 12
integer endx = 1541
integer endy = 108
end type

type ln_15 from line within uo_report_preview_toolbar
long linecolor = 16777215
integer linethickness = 1
integer beginx = 1545
integer beginy = 12
integer endx = 1545
integer endy = 108
end type

type ln_16 from line within uo_report_preview_toolbar
long linecolor = 8421504
integer linethickness = 1
integer beginx = 2016
integer beginy = 12
integer endx = 2016
integer endy = 108
end type

type ln_17 from line within uo_report_preview_toolbar
long linecolor = 16777215
integer linethickness = 1
integer beginx = 2021
integer beginy = 12
integer endx = 2021
integer endy = 108
end type

type ln_144 from line within uo_report_preview_toolbar
long linecolor = 8421504
integer linethickness = 1
integer beginx = 1705
integer beginy = 12
integer endx = 1705
integer endy = 108
end type

type ln_155 from line within uo_report_preview_toolbar
long linecolor = 16777215
integer linethickness = 1
integer beginx = 1710
integer beginy = 12
integer endx = 1710
integer endy = 108
end type

