HA$PBExportHeader$uo_toolbar_horizontal.sru
forward
global type uo_toolbar_horizontal from userobject
end type
type pb_save from picturebutton within uo_toolbar_horizontal
end type
type pb_new from picturebutton within uo_toolbar_horizontal
end type
type pb_exit from picturebutton within uo_toolbar_horizontal
end type
type pb_help from picturebutton within uo_toolbar_horizontal
end type
type pb_print from picturebutton within uo_toolbar_horizontal
end type
type pb_delete from picturebutton within uo_toolbar_horizontal
end type
type st_help from statictext within uo_toolbar_horizontal
end type
type st_exit from statictext within uo_toolbar_horizontal
end type
type st_save from statictext within uo_toolbar_horizontal
end type
type st_new from statictext within uo_toolbar_horizontal
end type
type st_delete from statictext within uo_toolbar_horizontal
end type
type st_print from statictext within uo_toolbar_horizontal
end type
end forward

global type uo_toolbar_horizontal from userobject
integer width = 1243
integer height = 184
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
event ue_mousemove pbm_mousemove
event ue_postopen ( )
pb_save pb_save
pb_new pb_new
pb_exit pb_exit
pb_help pb_help
pb_print pb_print
pb_delete pb_delete
st_help st_help
st_exit st_exit
st_save st_save
st_new st_new
st_delete st_delete
st_print st_print
end type
global uo_toolbar_horizontal uo_toolbar_horizontal

type variables
DataWindowChild dw_child
long lFirstTime = 0


end variables

forward prototypes
public subroutine uf_resize (integer ix, integer iwidth)
public subroutine uf_enable_buttons (boolean benable)
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

public subroutine uf_resize (integer ix, integer iwidth);integer iDifferenz

iDifferenz  = iWidth - this.width
this.x  		= iX
this.width  = iWidth


st_exit.x 	= st_exit.x + iDifferenz
pb_exit.x 	= pb_exit.x + iDifferenz

st_help.x 	= st_help.x + iDifferenz
pb_help.x 	= pb_help.x + iDifferenz

st_print.x 	= st_print.x + iDifferenz
pb_print.x 	= pb_print.x + iDifferenz
end subroutine

public subroutine uf_enable_buttons (boolean benable);


pb_new.enabled = bEnable
pb_delete.enabled = bEnable
end subroutine

on uo_toolbar_horizontal.create
this.pb_save=create pb_save
this.pb_new=create pb_new
this.pb_exit=create pb_exit
this.pb_help=create pb_help
this.pb_print=create pb_print
this.pb_delete=create pb_delete
this.st_help=create st_help
this.st_exit=create st_exit
this.st_save=create st_save
this.st_new=create st_new
this.st_delete=create st_delete
this.st_print=create st_print
this.Control[]={this.pb_save,&
this.pb_new,&
this.pb_exit,&
this.pb_help,&
this.pb_print,&
this.pb_delete,&
this.st_help,&
this.st_exit,&
this.st_save,&
this.st_new,&
this.st_delete,&
this.st_print}
end on

on uo_toolbar_horizontal.destroy
destroy(this.pb_save)
destroy(this.pb_new)
destroy(this.pb_exit)
destroy(this.pb_help)
destroy(this.pb_print)
destroy(this.pb_delete)
destroy(this.st_help)
destroy(this.st_exit)
destroy(this.st_save)
destroy(this.st_new)
destroy(this.st_delete)
destroy(this.st_print)
end on

type pb_save from picturebutton within uo_toolbar_horizontal
string tag = "Speichern"
integer x = 18
integer y = 4
integer width = 174
integer height = 152
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
boolean originalsize = true
string picturename = "..\Resource\diskett2.gif"
string disabledname = "..\Resource\docs7_write.gif"
alignment htextalign = left!
end type

event clicked;parent.postevent("ue_save")
end event

type pb_new from picturebutton within uo_toolbar_horizontal
string tag = "Neu"
integer x = 210
integer y = 4
integer width = 174
integer height = 152
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\pencil1b.gif"
string disabledname = "..\Resource\pencil1_disabled.gif"
alignment htextalign = left!
end type

event clicked;parent.postevent("ue_new")
end event

type pb_exit from picturebutton within uo_toolbar_horizontal
string tag = "Exit"
integer x = 1033
integer y = 4
integer width = 174
integer height = 152
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\door02.gif"
alignment htextalign = left!
end type

event clicked;parent.postevent("ue_exit")
end event

type pb_help from picturebutton within uo_toolbar_horizontal
string tag = "Hilfe"
integer x = 827
integer y = 4
integer width = 174
integer height = 152
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\book07.gif"
alignment htextalign = left!
end type

event clicked;parent.postevent("ue_help")
end event

type pb_print from picturebutton within uo_toolbar_horizontal
string tag = "Drucken"
integer x = 626
integer y = 4
integer width = 174
integer height = 152
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\printer1c.gif"
alignment htextalign = left!
end type

event clicked;parent.postevent("ue_print")
end event

type pb_delete from picturebutton within uo_toolbar_horizontal
string tag = "L$$HEX1$$f600$$ENDHEX$$schen"
integer x = 402
integer y = 4
integer width = 174
integer height = 152
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\eraser0c.gif"
string disabledname = "..\Resource\eraser_disabled.gif"
alignment htextalign = left!
end type

event clicked; parent.postevent("ue_delete")
//lFirstTime ++
//If dw_airline.Rowcount() > 0 Then
//	If dw_child.Retrieve(dw_airline.GetitemNumber(dw_airline.Getrow(),"nairline_key")) > 0 Then
//		If lFirstTime = 1 Then
//			// dw_actyp.uf_edit_style("naircraft_key")
//		End if	
//		dw_actyp.retrieve()
//		dw_actyp.scrolltorow(1)
//	Else
//		dw_actyp.Reset()
//	End if	
//End if
end event

type st_help from statictext within uo_toolbar_horizontal
integer x = 823
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

type st_exit from statictext within uo_toolbar_horizontal
integer x = 1029
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

type st_save from statictext within uo_toolbar_horizontal
integer x = 14
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

type st_new from statictext within uo_toolbar_horizontal
integer x = 206
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

type st_delete from statictext within uo_toolbar_horizontal
integer x = 402
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

type st_print from statictext within uo_toolbar_horizontal
integer x = 622
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

