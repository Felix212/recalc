HA$PBExportHeader$uo_toolbar_color.sru
$PBExportComments$Toolbar f$$HEX1$$fc00$$ENDHEX$$r Farb-Zuordnungs-Fenster
forward
global type uo_toolbar_color from userobject
end type
type htb_line from htrackbar within uo_toolbar_color
end type
type pb_linecolor from picturebutton within uo_toolbar_color
end type
type pb_font from picturebutton within uo_toolbar_color
end type
type pb_backcolor from picturebutton within uo_toolbar_color
end type
type st_backcolor from statictext within uo_toolbar_color
end type
type st_font from statictext within uo_toolbar_color
end type
type st_linecolor from statictext within uo_toolbar_color
end type
end forward

global type uo_toolbar_color from userobject
integer width = 1125
integer height = 188
boolean border = true
long backcolor = 67108864
string text = "none"
borderstyle borderstyle = stylelowered!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_backcolor ( )
event ue_linecolor ( )
event ue_font ( )
event ue_linewidth ( integer scrollpos )
event ue_clicked pbm_lbuttonclk
htb_line htb_line
pb_linecolor pb_linecolor
pb_font pb_font
pb_backcolor pb_backcolor
st_backcolor st_backcolor
st_font st_font
st_linecolor st_linecolor
end type
global uo_toolbar_color uo_toolbar_color

type variables


end variables

forward prototypes
public subroutine uf_resize (integer iwidth)
end prototypes

public subroutine uf_resize (integer iwidth);this.width =  iwidth
end subroutine

on uo_toolbar_color.create
this.htb_line=create htb_line
this.pb_linecolor=create pb_linecolor
this.pb_font=create pb_font
this.pb_backcolor=create pb_backcolor
this.st_backcolor=create st_backcolor
this.st_font=create st_font
this.st_linecolor=create st_linecolor
this.Control[]={this.htb_line,&
this.pb_linecolor,&
this.pb_font,&
this.pb_backcolor,&
this.st_backcolor,&
this.st_font,&
this.st_linecolor}
end on

on uo_toolbar_color.destroy
destroy(this.htb_line)
destroy(this.pb_linecolor)
destroy(this.pb_font)
destroy(this.pb_backcolor)
destroy(this.st_backcolor)
destroy(this.st_font)
destroy(this.st_linecolor)
end on

type htb_line from htrackbar within uo_toolbar_color
event ue_position_changed pbm_sbnthumbposition
integer x = 617
integer y = 24
integer width = 439
integer height = 128
integer minposition = 1
integer maxposition = 8
integer position = 1
integer tickfrequency = 1
end type

event ue_position_changed;//Messagebox("", "")
end event

event moved;// parent.postevent("ue_linewidth")
Post Event ue_linewidth(scrollpos)
end event

type pb_linecolor from picturebutton within uo_toolbar_color
string tag = "Tooltip C"
integer x = 407
integer y = 12
integer width = 174
integer height = 152
integer taborder = 30
integer weight = 700
string picturename = "..\Resource\roller1a.gif"
end type

event clicked;parent.postevent("ue_linecolor")
end event

type pb_font from picturebutton within uo_toolbar_color
string tag = "Tooltip B"
integer x = 210
integer y = 12
integer width = 174
integer height = 152
integer taborder = 20
string picturename = "..\Resource\ffont.gif"
end type

event clicked;parent.postevent("ue_font")
end event

type pb_backcolor from picturebutton within uo_toolbar_color
string tag = "Tooltip A"
integer x = 18
integer y = 12
integer width = 174
integer height = 152
integer taborder = 10
string picturename = "..\Resource\roller1c.gif"
end type

event clicked;parent.postevent("ue_backcolor")
end event

type st_backcolor from statictext within uo_toolbar_color
integer x = 14
integer y = 8
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

type st_font from statictext within uo_toolbar_color
integer x = 206
integer y = 8
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

type st_linecolor from statictext within uo_toolbar_color
integer x = 402
integer y = 8
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

