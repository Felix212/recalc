HA$PBExportHeader$w_gmt_test.srw
$PBExportComments$Testfenster zur Umrechnung von GMT-Zeiten
forward
global type w_gmt_test from window
end type
type st_2 from statictext within w_gmt_test
end type
type sle_faktor from singlelineedit within w_gmt_test
end type
type st_1 from statictext within w_gmt_test
end type
type sle_departure from singlelineedit within w_gmt_test
end type
type cb_1 from commandbutton within w_gmt_test
end type
end forward

global type w_gmt_test from window
integer width = 1541
integer height = 464
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
st_2 st_2
sle_faktor sle_faktor
st_1 st_1
sle_departure sle_departure
cb_1 cb_1
end type
global w_gmt_test w_gmt_test

on w_gmt_test.create
this.st_2=create st_2
this.sle_faktor=create sle_faktor
this.st_1=create st_1
this.sle_departure=create sle_departure
this.cb_1=create cb_1
this.Control[]={this.st_2,&
this.sle_faktor,&
this.st_1,&
this.sle_departure,&
this.cb_1}
end on

on w_gmt_test.destroy
destroy(this.st_2)
destroy(this.sle_faktor)
destroy(this.st_1)
destroy(this.sle_departure)
destroy(this.cb_1)
end on

type st_2 from statictext within w_gmt_test
integer x = 55
integer y = 180
integer width = 215
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Faktor:"
boolean focusrectangle = false
end type

type sle_faktor from singlelineedit within w_gmt_test
integer x = 517
integer y = 156
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "1,45"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_gmt_test
integer x = 55
integer y = 52
integer width = 215
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Abflug:"
boolean focusrectangle = false
end type

type sle_departure from singlelineedit within w_gmt_test
integer x = 517
integer y = 28
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "12:00"
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_gmt_test
integer x = 1001
integer y = 164
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Test"
end type

event clicked;Messagebox("Date","")
s_dep_time	s_departure
s_departure.sTime			= sle_departure.text
s_departure.doffset		= dec(sle_faktor.text)
s_departure.ddate			= today()
s_departure					= f_utc_to_local_time(s_departure)

Messagebox("Date","")

Messagebox("Date",s_departure.sTime)


end event

