HA$PBExportHeader$w_error_box.srw
$PBExportComments$Fenster zur Anzeige von Fehlermeldungen
forward
global type w_error_box from window
end type
type st_1 from statictext within w_error_box
end type
end forward

global type w_error_box from window
integer width = 1531
integer height = 224
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
end type
global w_error_box w_error_box

on w_error_box.create
this.st_1=create st_1
this.Control[]={this.st_1}
end on

on w_error_box.destroy
destroy(this.st_1)
end on

type st_1 from statictext within w_error_box
integer x = 32
integer y = 16
integer width = 1435
integer height = 136
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Dummy Object"
boolean focusrectangle = false
end type

