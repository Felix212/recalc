HA$PBExportHeader$w_delivery_note_question.srw
$PBExportComments$Druck-Funktion Catering-Order: Frage, ob neue Belegnummer vergeben und ob f$$HEX1$$fc00$$ENDHEX$$r alle Legs gedruckt werden soll
forward
global type w_delivery_note_question from window
end type
type p_1 from picture within w_delivery_note_question
end type
type cbx_legs from checkbox within w_delivery_note_question
end type
type st_1 from statictext within w_delivery_note_question
end type
type cb_ok from commandbutton within w_delivery_note_question
end type
type cb_cancel from commandbutton within w_delivery_note_question
end type
type st_5 from statictext within w_delivery_note_question
end type
type st_55 from statictext within w_delivery_note_question
end type
end forward

global type w_delivery_note_question from window
integer width = 1614
integer height = 520
boolean titlebar = true
string title = "Catering Order"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
p_1 p_1
cbx_legs cbx_legs
st_1 st_1
cb_ok cb_ok
cb_cancel cb_cancel
st_5 st_5
st_55 st_55
end type
global w_delivery_note_question w_delivery_note_question

type variables
s_catering_order 	sreturn
end variables

on w_delivery_note_question.create
this.p_1=create p_1
this.cbx_legs=create cbx_legs
this.st_1=create st_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.st_5=create st_5
this.st_55=create st_55
this.Control[]={this.p_1,&
this.cbx_legs,&
this.st_1,&
this.cb_ok,&
this.cb_cancel,&
this.st_5,&
this.st_55}
end on

on w_delivery_note_question.destroy
destroy(this.p_1)
destroy(this.cbx_legs)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.st_5)
destroy(this.st_55)
end on

event open;string	sTitle, sAirline, sSuffix, sFrom, sTo
Long		lFlight

sreturn = Message.PowerobjectParm

if sreturn.ball_legs = False then
	cbx_legs.enabled = False
end if

if sreturn.lResultKey > 0 then 
	
	select cairline, nflight_number, csuffix, ctlc_from, ctlc_to into :sAirline, :lFlight, :sSuffix, :sFrom, :sTo from cen_out where nresult_key = :sreturn.lResultKey;
	
	if sqlca.sqlcode = 0 then
		this.title = sAirline + " " + string(lFlight, "000") + sSuffix + " - " + sFrom + "-" + sTo
	else
		f_db_error(sqlca, "w_delivery_note_question.open()")
	end if
	
end if



uf.translate_window(this)

end event

type p_1 from picture within w_delivery_note_question
integer x = 23
integer y = 24
integer width = 183
integer height = 144
boolean originalsize = true
string picturename = "..\Resource\questionmark_big.gif"
boolean focusrectangle = false
end type

type cbx_legs from checkbox within w_delivery_note_question
integer x = 233
integer y = 152
integer width = 1321
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "drucke Catering Order f$$HEX1$$fc00$$ENDHEX$$r alle Legs"
end type

type st_1 from statictext within w_delivery_note_question
integer x = 233
integer y = 68
integer width = 1321
integer height = 72
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Soll eine neue Belegnummer vergeben werden?"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_delivery_note_question
integer x = 229
integer y = 292
integer width = 370
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Ja"
end type

event clicked;sReturn.bsuccessful 	= True
sReturn.bnew_number 	= True
sReturn.bAll_legs 	= cbx_legs.checked 
closewithreturn(parent,sReturn)
end event

type cb_cancel from commandbutton within w_delivery_note_question
integer x = 791
integer y = 292
integer width = 370
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Nein"
boolean cancel = true
boolean default = true
end type

event clicked;sReturn.bsuccessful 	= True
sReturn.bnew_number 	= False
sReturn.bAll_legs 	= cbx_legs.checked 
closewithreturn(parent,sReturn)
end event

type st_5 from statictext within w_delivery_note_question
integer x = 224
integer y = 288
integer width = 379
integer height = 100
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

type st_55 from statictext within w_delivery_note_question
integer x = 786
integer y = 288
integer width = 379
integer height = 100
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

