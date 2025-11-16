HA$PBExportHeader$uo_toolbar.sru
$PBExportComments$Toolbar
forward
global type uo_toolbar from userobject
end type
type pb_exit from picturebutton within uo_toolbar
end type
type pb_help from picturebutton within uo_toolbar
end type
type pb_print from picturebutton within uo_toolbar
end type
type pb_delete from picturebutton within uo_toolbar
end type
type pb_new from picturebutton within uo_toolbar
end type
type pb_save from picturebutton within uo_toolbar
end type
type st_help from statictext within uo_toolbar
end type
type st_exit from statictext within uo_toolbar
end type
type st_save from statictext within uo_toolbar
end type
type st_new from statictext within uo_toolbar
end type
type st_delete from statictext within uo_toolbar
end type
type st_printer from statictext within uo_toolbar
end type
end forward

global type uo_toolbar from userobject
integer width = 247
integer height = 1236
boolean border = true
long backcolor = 67108864
string text = "none"
borderstyle borderstyle = stylelowered!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_exit ( )
event ue_help ( )
event ue_print ( )
event ue_delete ( )
event ue_new ( )
event ue_save ( )
pb_exit pb_exit
pb_help pb_help
pb_print pb_print
pb_delete pb_delete
pb_new pb_new
pb_save pb_save
st_help st_help
st_exit st_exit
st_save st_save
st_new st_new
st_delete st_delete
st_printer st_printer
end type
global uo_toolbar uo_toolbar

type variables

end variables

forward prototypes
public subroutine uf_resize (integer iheight, integer iposition)
end prototypes

event ue_exit;
PowerObject w_window

w_window = this.getparent()
close(w_window)
end event

event ue_help;PowerObject w_window

w_window = this.getparent()
w_window.postevent("ue_help")
end event

event ue_print;PowerObject w_window

w_window = this.getparent()
w_window.postevent("ue_print")
end event

event ue_delete;PowerObject w_window

w_window = this.getparent()
w_window.postevent("ue_delete")
end event

event ue_new;PowerObject w_window

w_window = this.getparent()
w_window.postevent("ue_new")
end event

event ue_save;PowerObject w_window

w_window = this.getparent()
w_window.postevent("ue_save")
end event

public subroutine uf_resize (integer iheight, integer iposition);this.x		= iPosition
this.height = iheight
st_exit.y 	= iheight - st_exit.height - 20
pb_exit.y 	= iheight - pb_exit.height - 24
end subroutine

on uo_toolbar.create
this.pb_exit=create pb_exit
this.pb_help=create pb_help
this.pb_print=create pb_print
this.pb_delete=create pb_delete
this.pb_new=create pb_new
this.pb_save=create pb_save
this.st_help=create st_help
this.st_exit=create st_exit
this.st_save=create st_save
this.st_new=create st_new
this.st_delete=create st_delete
this.st_printer=create st_printer
this.Control[]={this.pb_exit,&
this.pb_help,&
this.pb_print,&
this.pb_delete,&
this.pb_new,&
this.pb_save,&
this.st_help,&
this.st_exit,&
this.st_save,&
this.st_new,&
this.st_delete,&
this.st_printer}
end on

on uo_toolbar.destroy
destroy(this.pb_exit)
destroy(this.pb_help)
destroy(this.pb_print)
destroy(this.pb_delete)
destroy(this.pb_new)
destroy(this.pb_save)
destroy(this.st_help)
destroy(this.st_exit)
destroy(this.st_save)
destroy(this.st_new)
destroy(this.st_delete)
destroy(this.st_printer)
end on

type pb_exit from picturebutton within uo_toolbar
string tag = "Exit"
integer x = 27
integer y = 1016
integer width = 174
integer height = 152
integer taborder = 60
string picturename = "..\Resource\door02.gif"
end type

event clicked;parent.postevent("ue_exit")
end event

type pb_help from picturebutton within uo_toolbar
string tag = "Hilfe"
integer x = 27
integer y = 768
integer width = 174
integer height = 152
integer taborder = 50
string picturename = "..\Resource\book07.gif"
end type

event clicked;parent.postevent("ue_help")
end event

type pb_print from picturebutton within uo_toolbar
string tag = "Drucken"
integer x = 27
integer y = 580
integer width = 174
integer height = 152
integer taborder = 40
string picturename = "..\Resource\printer1c.gif"
end type

event clicked;parent.postevent("ue_print")
end event

type pb_delete from picturebutton within uo_toolbar
string tag = "L$$HEX1$$f600$$ENDHEX$$schen"
integer x = 27
integer y = 396
integer width = 174
integer height = 152
integer taborder = 30
string picturename = "..\Resource\eraser0c.gif"
end type

event clicked;parent.postevent("ue_delete")
end event

type pb_new from picturebutton within uo_toolbar
string tag = "Neu"
integer x = 27
integer y = 212
integer width = 174
integer height = 152
integer taborder = 30
string picturename = "..\Resource\pencil1b.gif"
end type

event clicked;parent.postevent("ue_new")
end event

type pb_save from picturebutton within uo_toolbar
string tag = "Speichern"
integer x = 27
integer y = 28
integer width = 174
integer height = 152
integer taborder = 20
boolean enabled = false
string picturename = "..\Resource\diskett2.gif"
string disabledname = "..\Resource\docs7_write.gif"
end type

event clicked;parent.postevent("ue_save")
end event

type st_help from statictext within uo_toolbar
integer x = 23
integer y = 764
integer width = 183
integer height = 160
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

type st_exit from statictext within uo_toolbar
integer x = 23
integer y = 1012
integer width = 183
integer height = 160
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

type st_save from statictext within uo_toolbar
integer x = 23
integer y = 24
integer width = 183
integer height = 160
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

type st_new from statictext within uo_toolbar
integer x = 23
integer y = 208
integer width = 183
integer height = 160
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

type st_delete from statictext within uo_toolbar
integer x = 23
integer y = 392
integer width = 183
integer height = 160
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

type st_printer from statictext within uo_toolbar
integer x = 23
integer y = 576
integer width = 183
integer height = 160
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

