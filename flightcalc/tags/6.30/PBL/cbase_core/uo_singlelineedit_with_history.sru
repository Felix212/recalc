HA$PBExportHeader$uo_singlelineedit_with_history.sru
$PBExportComments$Ancestor for Suchfelder
forward
global type uo_singlelineedit_with_history from userobject
end type
type vsb_scroll_hist from uo_vscrollbar within uo_singlelineedit_with_history
end type
type p_seek from picture within uo_singlelineedit_with_history
end type
type p_corner from picture within uo_singlelineedit_with_history
end type
type sle_seek from singlelineedit within uo_singlelineedit_with_history
end type
type st_seek_corner from statictext within uo_singlelineedit_with_history
end type
type dwhist from datawindow within uo_singlelineedit_with_history
end type
type r_1 from rectangle within uo_singlelineedit_with_history
end type
end forward

global type uo_singlelineedit_with_history from userobject
integer width = 640
integer height = 572
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_action ( )
vsb_scroll_hist vsb_scroll_hist
p_seek p_seek
p_corner p_corner
sle_seek sle_seek
st_seek_corner st_seek_corner
dwhist dwhist
r_1 r_1
end type
global uo_singlelineedit_with_history uo_singlelineedit_with_history

type variables
integer 	iOpen
string 	isFilter


end variables

forward prototypes
public subroutine of_load (blob bblob)
public function integer of_open ()
public function string of_parse_key (keycode key)
public function blob of_save ()
public function integer of_set_marker (long lrow)
public function integer of_close ()
end prototypes

event ue_action();this.of_close()
end event

public subroutine of_load (blob bblob);// -------------------------------------
//	L$$HEX1$$e400$$ENDHEX$$dt alte daten ins DW 
// -------------------------------------

if LenA(bBlob) = 0 then return 
if isnull(bBlob) then return

dwHist.SetFullState(bBlob)


end subroutine

public function integer of_open ();// -------------------------------------
//	Datawindow anzeigen
// -------------------------------------

if dwHist.RowCount() > 0 then

	vsb_scroll_hist.Trigger Event ue_init(dwHist)

	this.Height = sle_seek.y + r_1.y + r_1.height 
	
	iOpen = 1
	
end if

return 0



end function

public function string of_parse_key (keycode key);// -------------------------------------
//	Eingegebene Taste interpretieren
// -------------------------------------

String sReturn

sReturn = ""

// ----------------------------------------------
// KeyMapping
// ----------------------------------------------
CHOOSE CASE key
	CASE KeyA!
		sReturn = "A"
	CASE KeyB!
		sReturn = "B"
	CASE KeyC!
		sReturn = "C"
	CASE KeyD!
		sReturn = "D"
	CASE KeyE!
		sReturn = "E"
	CASE KeyF!
		sReturn = "F"
	CASE KeyG!
		sReturn = "G"
	CASE KeyH!
		sReturn = "H"
	CASE KeyI!
		sReturn = "I"
	CASE KeyJ!
		sReturn = "J"
	CASE KeyK!
		sReturn = "K"
	CASE KeyL!
		sReturn = "L"
	CASE KeyM!
		sReturn = "M"
	CASE KeyN!
		sReturn = "N"
	CASE KeyO!
		sReturn = "O"
	CASE KeyP!
		sReturn = "P"
	CASE KeyQ!
		sReturn = "Q"
	CASE KeyR!
		sReturn = "R"
	CASE KeyS!
		sReturn = "S"
	CASE KeyT!
		sReturn = "T"
	CASE KeyU!
		sReturn = "U"
	CASE KeyV!
		sReturn = "V"
	CASE KeyW!
		sReturn = "W"
	CASE KeyX!
		sReturn = "X"
	CASE KeyY!
		sReturn = "Y"
	CASE KeyZ!
		sReturn = "Z"
	CASE Key0!, KeyNumpad0!
		sReturn = "0"
	CASE Key1!, KeyNumpad1!
		sReturn = "1"
	CASE Key2!, KeyNumpad2!
		sReturn = "2"
	CASE Key3!, KeyNumpad3!
		sReturn = "3"
	CASE Key4!, KeyNumpad4!
		sReturn = "4"
	CASE Key5!, KeyNumpad5!
		sReturn = "5"
	CASE Key6!, KeyNumpad6!
		sReturn = "6"
	CASE Key7!, KeyNumpad7!
		sReturn = "7"
	CASE Key8!, KeyNumpad8!
		sReturn = "8"
	CASE Key9!, KeyNumpad9!
		sReturn = "9"
END CHOOSE

return sReturn

end function

public function blob of_save ();// -------------------------------------
//	Daten im DW als Blob zur$$HEX1$$fc00$$ENDHEX$$ckgeben
// -------------------------------------
blob		bReturn

dwHist.SetFilter("")
dwHist.Filter()
dwHist.GetFullState(bReturn)

return bReturn
end function

public function integer of_set_marker (long lrow);// -------------------------------------
//	Zeilenmarlierer positionieren
// -------------------------------------

long 	lGroupHeaderHeight, &
		lNoOfGroupHeaders, &
		lFirstRow, &
		lFirstHeader, &
		lPos,	&
		lX, &
		lY, &
		a


// ----------------------------------
// erstmal die Headerh$$HEX1$$f600$$ENDHEX$$he ermitteln
// ----------------------------------
lY += Long(dwHist.describe("datawindow.header.height"))

lFirstRow = Long(dwHist.describe("datawindow.firstrowonpage"))

lY += Long(dwHist.describe("datawindow.detail.height")) * (lRow - lFirstRow)

return lY			
end function

public function integer of_close ();// -------------------------------------
// Datawindow ausblenden
// -------------------------------------

this.Height = sle_seek.y + r_1.y - 4
iOpen = 0 

return 0
end function

on uo_singlelineedit_with_history.create
this.vsb_scroll_hist=create vsb_scroll_hist
this.p_seek=create p_seek
this.p_corner=create p_corner
this.sle_seek=create sle_seek
this.st_seek_corner=create st_seek_corner
this.dwhist=create dwhist
this.r_1=create r_1
this.Control[]={this.vsb_scroll_hist,&
this.p_seek,&
this.p_corner,&
this.sle_seek,&
this.st_seek_corner,&
this.dwhist,&
this.r_1}
end on

on uo_singlelineedit_with_history.destroy
destroy(this.vsb_scroll_hist)
destroy(this.p_seek)
destroy(this.p_corner)
destroy(this.sle_seek)
destroy(this.st_seek_corner)
destroy(this.dwhist)
destroy(this.r_1)
end on

type vsb_scroll_hist from uo_vscrollbar within uo_singlelineedit_with_history
integer x = 558
integer y = 96
integer height = 400
end type

event ue_init(datawindow odw);long 			lDetailHeight, &
				lHeaderHeight, &
				lGroupHeaderHeight, &
				lObjectHeight
				
dwParent =  oDw 

lDetailHeight = long(dwParent.describe("datawindow.detail.height"))
lHeaderHeight = long(dwParent.describe("datawindow.Header.height"))
lGroupHeaderHeight = long(dwParent.describe("datawindow.Group.1.Header.height"))
lObjectHeight = dwParent.Height

if dwParent.Rowcount() > 9 then
	
	this.Visible = True
	st_seek_corner.visible = True
	p_corner.visible = True

	this.MinPosition = lDetailHeight
	this.MaxPosition = dwParent.Rowcount() * lDetailHeight
	
	r_1.height = (lDetailHeight * 9) + 20
	dwHist.height = lDetailHeight * 9 + 12


	this.Height = dwHist.Height - st_seek_corner.height
	st_seek_corner.y = this.y + this.height
	p_corner.y = st_seek_corner.y + 12

	
else
	this.Visible = False
	st_seek_corner.visible = False
	p_corner.visible = False
	
	r_1.height = (lDetailHeight * dwParent.Rowcount()) + 20
	dwHist.height = lDetailHeight * dwParent.Rowcount() + 12

end if



end event

event moved;//
end event

type p_seek from picture within uo_singlelineedit_with_history
integer x = 535
integer y = 4
integer width = 91
integer height = 84
string picturename = "..\Resource\seek_small.gif"
boolean focusrectangle = false
end type

event clicked;parent.Trigger Event ue_action()
end event

type p_corner from picture within uo_singlelineedit_with_history
integer x = 571
integer y = 508
integer width = 59
integer height = 56
string picturename = "..\Resource\corner.gif"
boolean focusrectangle = false
end type

type sle_seek from singlelineedit within uo_singlelineedit_with_history
event ue_doubleclick pbm_lbuttondblclk
event ue_keydown pbm_keydown
integer width = 517
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event ue_doubleclick;// -------------------------------------
//	Mal alles anzeigen
// -------------------------------------

dwHist.Setfilter("")
dwHist.Filter()
dwHist.Sort()
		
if iOpen = 0 then
	
	if dwHist.RowCount() > 0 then
		parent.of_open()
	else
		parent.of_close()
	end if	
else
	parent.of_close()
	
end if


end event

event ue_keydown;// -------------------------------------
//	Schaun mer mal, was eingetippt wurde
// -------------------------------------
String 	sKey, &
			sText

			
Long 		lRow, &
			lFound
	
	
// ------------------------------------------------
// Beim verlassen den Wert wegschreiben
// ------------------------------------------------
if key = KeyEnter! and keyflags <> 1000 then
		
	Parent.Post Event ue_action()	
	parent.of_close()
	
	if Trim(this.Text) <> "" then

		dwHist.SetFilter("")
		dwHist.Filter()
		
		lFound = dwHist.Find("ssearch='" + this.Text + "'", 1, dwHist.RowCount())
	
		if lFound = 0 then
			lRow = dwHist.InsertRow(0)
			dwHist.SetItem(lRow, "ssearch", This.Text)
			dwHist.Sort()
			dwHist.SelectRow(0,false)
			vsb_scroll_hist.Trigger Event ue_init(dwHist)
			
		end if 
		
	end if
	
end if

// ------------------------------------------------
// Wenn ein Buchstabe oder eine Zahl ankommt
// Dann das DW filtern und wenn dann noch was
// drinsteht, dann aufklappen
// ------------------------------------------------
sKey = of_parse_key(key)

if sKey <> "" then
	
	sText = this.text + sKey
	
	isFilter = "UPPER(Mid(ssearch, 1, " + string(LenA(sText)) +")) = '" + Upper(sText) + "'"
	
	dwHist.Setfilter(isFilter)
	dwHist.Filter()
		
	if dwHist.RowCount() > 0 then
		parent.of_open()
	else
		parent.of_close()
	end if
		
end if

if key = KeyBack! then
	
	sText = MidA(this.text, 1, LenA(this.text) - 1)
	
	//messagebox("", "|" + sText + "|")
	
	if sText <> "" then
	
		isFilter = "UPPER(Mid(ssearch, 1, " + string(LenA(sText)) +")) = '" + Upper(sText) + "'"
		
		dwHist.Setfilter(isFilter)
		dwHist.Filter()
			
		if dwHist.RowCount() > 0 then
			parent.of_open()
		else
			parent.of_close()
		end if
		
	else
		
		parent.of_close()
			
	end if
		
end if

if key = KeyDownArrow! and iOpen = 1 then
	
	dwHist.SetFocus()
	
end if

end event

event losefocus;
this.Trigger Event ue_keydown(KeyEnter!, 1000)

end event

event modified;Long 		lFound, &
			lRow


Parent.Post Event ue_action()	
parent.of_close()

if Trim(this.Text) <> "" then

	dwHist.SetFilter("")
	dwHist.Filter()
		
	lFound = dwHist.Find("ssearch='" + this.Text + "'", 1, dwHist.RowCount())
	
	if lFound = 0 then
		lRow = dwHist.InsertRow(0)
		dwHist.SetItem(lRow, "ssearch", This.Text)
		dwHist.Sort()
		dwHist.SelectRow(0,false)
		vsb_scroll_hist.Trigger Event ue_init(dwHist)
			
	end if 
	
end if
end event

type st_seek_corner from statictext within uo_singlelineedit_with_history
integer x = 558
integer y = 496
integer width = 73
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type dwhist from datawindow within uo_singlelineedit_with_history
event ue_mouse_move pbm_dwnmousemove
event ue_key pbm_dwnkey
integer x = 5
integer y = 96
integer width = 626
integer height = 468
integer taborder = 20
string dataobject = "dw_singlelineedit_with_history"
boolean border = false
end type

event ue_mouse_move;// -------------------------------------
//	
// -------------------------------------

if row > 0 then
	this.ScrollToRow(row)
end if
end event

event ue_key;// -------------------------------------
//	Enter gedr$$HEX1$$fc00$$ENDHEX$$ckt, dann den Text ins
// SLE packen
// -------------------------------------
long lRow

if this.GetRow() > 0 and key = KeyEnter! then
	sle_seek.text = This.GetItemString(this.GetRow(), "ssearch")
	sle_seek.Setfocus()
	sle_seek.SelectText ( LenA(sle_seek.text) + 1, 0 )
	parent.of_close()
end if

end event

event doubleclicked;
if row > 0 then
	sle_seek.text = This.GetItemString(row, "ssearch")
	sle_seek.Setfocus()
	sle_seek.SelectText ( LenA(sle_seek.text) + 1, 0 )
end if

parent.of_close()
end event

event rowfocuschanged;// -------------------------------------
//	Zeilenmarkierer positionieren
// -------------------------------------
Long lY

if currentrow > 0 then
	
	vsb_scroll_hist.of_set_position(currentrow)

	lY = of_set_marker(currentrow)
	lY += long(this.Describe("nflight_number_1.y")) - 4
	this.Modify("st_marker.visible = 1")
	this.Modify("st_marker.x = " + string(0))
	this.Modify("st_marker.y = " + string(lY))
	
end if
end event

type r_1 from rectangle within uo_singlelineedit_with_history
integer linethickness = 1
long fillcolor = 16777215
integer y = 92
integer width = 635
integer height = 476
end type

