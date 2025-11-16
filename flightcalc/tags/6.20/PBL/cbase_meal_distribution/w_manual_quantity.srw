HA$PBExportHeader$w_manual_quantity.srw
$PBExportComments$Fenster zur manuellen Mengenangabe.~r~n~r~n- $$HEX1$$d600$$ENDHEX$$ffnet sich bei drag&drop in w_manual_distribution
forward
global type w_manual_quantity from window
end type
type st_text from statictext within w_manual_quantity
end type
type cb_2 from commandbutton within w_manual_quantity
end type
type cb_1 from commandbutton within w_manual_quantity
end type
type st_1 from statictext within w_manual_quantity
end type
type em_quantity from editmask within w_manual_quantity
end type
type st_2 from statictext within w_manual_quantity
end type
end forward

global type w_manual_quantity from window
integer width = 1070
integer height = 260
boolean titlebar = true
string title = "Menge"
windowtype windowtype = response!
long backcolor = 67108864
st_text st_text
cb_2 cb_2
cb_1 cb_1
st_1 st_1
em_quantity em_quantity
st_2 st_2
end type
global w_manual_quantity w_manual_quantity

type variables
Long 	lMax
s_distribution_quantities	strOpen
end variables

event open;

//lMax = Long(Message.StringParm)
strOpen = Message.PowerObjectParm

lMax = strOpen.lQuantity
st_text.text = strOpen.sText
this.title   = strOpen.sText

em_quantity.text = string(lMax)
em_quantity.MinMax  = ("1 ~~ " + string(lMax) ) 
em_quantity.SelectText(1, len(em_quantity.text))

uf.translate_window(this)

this.move(w_mdi_master.PointerX(), w_mdi_master.PointerY())
end event

on w_manual_quantity.create
this.st_text=create st_text
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.em_quantity=create em_quantity
this.st_2=create st_2
this.Control[]={this.st_text,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.em_quantity,&
this.st_2}
end on

on w_manual_quantity.destroy
destroy(this.st_text)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.em_quantity)
destroy(this.st_2)
end on

type st_text from statictext within w_manual_quantity
integer x = 55
integer y = 204
integer width = 905
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
long backcolor = 67108864
string text = "HM 1"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_manual_quantity
integer x = 704
integer y = 32
integer width = 283
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Abbrechen"
end type

event clicked;
CloseWithReturn(parent, "-1")
end event

type cb_1 from commandbutton within w_manual_quantity
integer x = 585
integer y = 32
integer width = 114
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;Long lValue

lValue = long(em_quantity.text)

if lValue <= 0 then 
	uf.mbox("Achtung", "Bitte geben Sie einen Wert gr$$HEX2$$f600df00$$ENDHEX$$er 0 ein!", StopSign!)
	return 0
end if

if lValue > lMax then 
	uf.mbox("Achtung", "Bitte geben Sie einen Wert kleiner oder gleich ${" + string(lMax) + "} ein!", StopSign!)
	return 0
end if

CloseWithReturn(parent, em_quantity.text)
end event

type st_1 from statictext within w_manual_quantity
integer y = 48
integer width = 261
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Menge:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_quantity from editmask within w_manual_quantity
integer x = 274
integer y = 32
integer width = 247
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####0"
boolean spin = true
double increment = 1
string minmax = "1~~1"
end type

type st_2 from statictext within w_manual_quantity
integer x = 581
integer y = 28
integer width = 411
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

