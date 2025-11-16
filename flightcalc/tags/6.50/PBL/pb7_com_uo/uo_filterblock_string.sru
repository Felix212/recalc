HA$PBExportHeader$uo_filterblock_string.sru
forward
global type uo_filterblock_string from userobject
end type
type pb_such from picturebutton within uo_filterblock_string
end type
type sle_1 from singlelineedit within uo_filterblock_string
end type
type cb_2 from commandbutton within uo_filterblock_string
end type
type cb_3 from commandbutton within uo_filterblock_string
end type
type cb_4 from commandbutton within uo_filterblock_string
end type
type cb_5 from commandbutton within uo_filterblock_string
end type
type cb_6 from commandbutton within uo_filterblock_string
end type
type cb_7 from commandbutton within uo_filterblock_string
end type
type cb_8 from commandbutton within uo_filterblock_string
end type
type cb_9 from commandbutton within uo_filterblock_string
end type
type cb_10 from commandbutton within uo_filterblock_string
end type
type cb_11 from commandbutton within uo_filterblock_string
end type
type cb_12 from commandbutton within uo_filterblock_string
end type
type cb_13 from commandbutton within uo_filterblock_string
end type
type cb_14 from commandbutton within uo_filterblock_string
end type
type cb_15 from commandbutton within uo_filterblock_string
end type
type cb_16 from commandbutton within uo_filterblock_string
end type
type cb_17 from commandbutton within uo_filterblock_string
end type
type cb_18 from commandbutton within uo_filterblock_string
end type
type cb_19 from commandbutton within uo_filterblock_string
end type
type cb_20 from commandbutton within uo_filterblock_string
end type
type cb_21 from commandbutton within uo_filterblock_string
end type
type cb_22 from commandbutton within uo_filterblock_string
end type
type cb_23 from commandbutton within uo_filterblock_string
end type
type cb_24 from commandbutton within uo_filterblock_string
end type
type cb_25 from commandbutton within uo_filterblock_string
end type
type cb_26 from commandbutton within uo_filterblock_string
end type
type cb_27 from commandbutton within uo_filterblock_string
end type
type cb_28 from commandbutton within uo_filterblock_string
end type
type cb_29 from commandbutton within uo_filterblock_string
end type
type cb_30 from commandbutton within uo_filterblock_string
end type
type cb_31 from commandbutton within uo_filterblock_string
end type
type cb_1 from commandbutton within uo_filterblock_string
end type
end forward

global type uo_filterblock_string from userobject
integer width = 526
integer height = 1276
boolean border = true
long backcolor = 79741120
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
pb_such pb_such
sle_1 sle_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
cb_8 cb_8
cb_9 cb_9
cb_10 cb_10
cb_11 cb_11
cb_12 cb_12
cb_13 cb_13
cb_14 cb_14
cb_15 cb_15
cb_16 cb_16
cb_17 cb_17
cb_18 cb_18
cb_19 cb_19
cb_20 cb_20
cb_21 cb_21
cb_22 cb_22
cb_23 cb_23
cb_24 cb_24
cb_25 cb_25
cb_26 cb_26
cb_27 cb_27
cb_28 cb_28
cb_29 cb_29
cb_30 cb_30
cb_31 cb_31
cb_1 cb_1
end type
global uo_filterblock_string uo_filterblock_string

type variables
Public:
	DataWindow	oDW
	String		FilteredColumn
	boolean		bFilter
//	String		sEventToTrigger
	
	
Private:	
//	Boolean		bTrigger
	String		sDataType
	long 			lStartrow = 1
end variables

forward prototypes
private subroutine filter (string filterkrit)
end prototypes

private subroutine filter (string filterkrit);// Filter oder Find
long lRow

If bFilter = True Then
	If Filterkrit = "0-9" Then
		oDW.SetFilter ("match(" + filteredcolumn + ",'^[0-9]')")
	Else
		oDW.SetFilter ("match(upper(" + filteredcolumn + "),'^" + upper(filterkrit) + "')")
	End if
	oDW.Filter()
	odw.Setfocus()
	odw.Setcolumn(filteredcolumn)
Else
	If Filterkrit = "0-9" Then
		lRow = oDW.Find("match(" + filteredcolumn + ",'^[0-9]')",lStartrow,odw.Rowcount())
	Else
		lRow = oDW.Find("match(upper(" + filteredcolumn + "),'^" + upper(filterkrit) + "')",lStartrow,odw.Rowcount())
	End if		
	If lRow > 0 Then
		odw.Setfocus()
		oDW.Scrolltorow(lRow)
		oDW.Setrow(lRow)
		odw.Setcolumn(filteredcolumn)
		lStartrow = lRow +1
		If lStartrow > odw.Rowcount() Then lStartrow = 1
	Else
		beep(1)
		lStartrow = 1
	End if
End if	

end subroutine

on uo_filterblock_string.create
this.pb_such=create pb_such
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_9=create cb_9
this.cb_10=create cb_10
this.cb_11=create cb_11
this.cb_12=create cb_12
this.cb_13=create cb_13
this.cb_14=create cb_14
this.cb_15=create cb_15
this.cb_16=create cb_16
this.cb_17=create cb_17
this.cb_18=create cb_18
this.cb_19=create cb_19
this.cb_20=create cb_20
this.cb_21=create cb_21
this.cb_22=create cb_22
this.cb_23=create cb_23
this.cb_24=create cb_24
this.cb_25=create cb_25
this.cb_26=create cb_26
this.cb_27=create cb_27
this.cb_28=create cb_28
this.cb_29=create cb_29
this.cb_30=create cb_30
this.cb_31=create cb_31
this.cb_1=create cb_1
this.Control[]={this.pb_such,&
this.sle_1,&
this.cb_2,&
this.cb_3,&
this.cb_4,&
this.cb_5,&
this.cb_6,&
this.cb_7,&
this.cb_8,&
this.cb_9,&
this.cb_10,&
this.cb_11,&
this.cb_12,&
this.cb_13,&
this.cb_14,&
this.cb_15,&
this.cb_16,&
this.cb_17,&
this.cb_18,&
this.cb_19,&
this.cb_20,&
this.cb_21,&
this.cb_22,&
this.cb_23,&
this.cb_24,&
this.cb_25,&
this.cb_26,&
this.cb_27,&
this.cb_28,&
this.cb_29,&
this.cb_30,&
this.cb_31,&
this.cb_1}
end on

on uo_filterblock_string.destroy
destroy(this.pb_such)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.cb_10)
destroy(this.cb_11)
destroy(this.cb_12)
destroy(this.cb_13)
destroy(this.cb_14)
destroy(this.cb_15)
destroy(this.cb_16)
destroy(this.cb_17)
destroy(this.cb_18)
destroy(this.cb_19)
destroy(this.cb_20)
destroy(this.cb_21)
destroy(this.cb_22)
destroy(this.cb_23)
destroy(this.cb_24)
destroy(this.cb_25)
destroy(this.cb_26)
destroy(this.cb_27)
destroy(this.cb_28)
destroy(this.cb_29)
destroy(this.cb_30)
destroy(this.cb_31)
destroy(this.cb_1)
end on

event constructor;
SetNULL(filteredcolumn)




end event

type pb_such from picturebutton within uo_filterblock_string
integer x = 18
integer y = 1072
integer width = 146
integer height = 128
integer taborder = 170
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
boolean originalsize = true
string picturename = "..\Resource\seek.gif"
alignment htextalign = left!
end type

event clicked;string 	sFilter
integer  iPos

sFilter = upper(trim(sle_1.text))

iPos = pos(sFilter,"*")
if iPos > 1 then 
	sFilter = mid(sFilter,1,iPos -1) + "\" + mid(sFilter,iPos)
end if

Filter(sFilter)

oDW.Setfocus()

end event

type sle_1 from singlelineedit within uo_filterblock_string
integer x = 18
integer y = 904
integer width = 494
integer height = 92
integer taborder = 310
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 37
integer y = 28
integer width = 114
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "A"
end type

event clicked;
Filter(This.Text)
end event

type cb_3 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 151
integer y = 28
integer width = 114
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "B"
end type

event clicked;Filter(This.Text)
end event

type cb_4 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 379
integer y = 28
integer width = 114
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "D"
end type

event clicked;Filter(This.Text)
end event

type cb_5 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 265
integer y = 28
integer width = 114
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "C"
end type

event clicked;Filter(This.Text)
end event

type cb_6 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 265
integer y = 136
integer width = 114
integer height = 108
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "G"
end type

event clicked;Filter(This.Text)
end event

type cb_7 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 379
integer y = 136
integer width = 114
integer height = 108
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "H"
end type

event clicked;Filter(This.Text)
end event

type cb_8 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 151
integer y = 136
integer width = 114
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F"
end type

event clicked;Filter(This.Text)
end event

type cb_9 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 37
integer y = 136
integer width = 114
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "E"
end type

event clicked;Filter(This.Text)
end event

type cb_10 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 265
integer y = 244
integer width = 114
integer height = 108
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "K"
end type

event clicked;Filter(This.Text)
end event

type cb_11 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 379
integer y = 244
integer width = 114
integer height = 108
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "L"
end type

event clicked;Filter(This.Text)
end event

type cb_12 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 151
integer y = 244
integer width = 114
integer height = 108
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "J"
end type

event clicked;Filter(This.Text)
end event

type cb_13 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 37
integer y = 244
integer width = 114
integer height = 108
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "I"
end type

event clicked;Filter(This.Text)
end event

type cb_14 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 265
integer y = 352
integer width = 114
integer height = 108
integer taborder = 150
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "O"
end type

event clicked;Filter(This.Text)
end event

type cb_15 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 379
integer y = 352
integer width = 114
integer height = 108
integer taborder = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "P"
end type

event clicked;Filter(This.Text)
end event

type cb_16 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 151
integer y = 352
integer width = 114
integer height = 108
integer taborder = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "N"
end type

event clicked;Filter(This.Text)
end event

type cb_17 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 37
integer y = 352
integer width = 114
integer height = 108
integer taborder = 130
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "M"
end type

event clicked;Filter(This.Text)
end event

type cb_18 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 37
integer y = 460
integer width = 114
integer height = 108
integer taborder = 170
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Q"
end type

event clicked;Filter(This.Text)
end event

type cb_19 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 151
integer y = 460
integer width = 114
integer height = 108
integer taborder = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "R"
end type

event clicked;Filter(This.Text)
end event

type cb_20 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 379
integer y = 460
integer width = 114
integer height = 108
integer taborder = 210
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "T"
end type

event clicked;Filter(This.Text)
end event

type cb_21 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 265
integer y = 460
integer width = 114
integer height = 108
integer taborder = 190
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "S"
end type

event clicked;Filter(This.Text)
end event

type cb_22 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 37
integer y = 568
integer width = 114
integer height = 108
integer taborder = 220
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "U"
end type

event clicked;Filter(This.Text)
end event

type cb_23 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 151
integer y = 568
integer width = 114
integer height = 108
integer taborder = 230
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "V"
end type

event clicked;Filter(This.Text)
end event

type cb_24 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 379
integer y = 568
integer width = 114
integer height = 108
integer taborder = 250
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "X"
end type

event clicked;Filter(This.Text)
end event

type cb_25 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 265
integer y = 568
integer width = 114
integer height = 108
integer taborder = 240
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "W"
end type

event clicked;Filter(This.Text)
end event

type cb_26 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 265
integer y = 676
integer width = 114
integer height = 108
integer taborder = 280
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "$$HEX1$$c400$$ENDHEX$$"
end type

event clicked;Filter(This.Text)
end event

type cb_27 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 379
integer y = 676
integer width = 114
integer height = 108
integer taborder = 290
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "$$HEX1$$d600$$ENDHEX$$"
end type

event clicked;Filter(This.Text)
end event

type cb_28 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 151
integer y = 676
integer width = 114
integer height = 108
integer taborder = 270
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Z"
end type

event clicked;Filter(This.Text)
end event

type cb_29 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 37
integer y = 676
integer width = 114
integer height = 108
integer taborder = 260
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Y"
end type

event clicked;Filter(This.Text)
end event

type cb_30 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 37
integer y = 784
integer width = 114
integer height = 108
integer taborder = 300
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "$$HEX1$$dc00$$ENDHEX$$"
end type

event clicked;Filter(This.Text)
end event

type cb_31 from commandbutton within uo_filterblock_string
string tag = "string"
integer x = 151
integer y = 784
integer width = 114
integer height = 108
integer taborder = 350
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "0-9"
end type

event clicked;Filter(This.Text)
end event

type cb_1 from commandbutton within uo_filterblock_string
integer x = 265
integer y = 784
integer width = 229
integer height = 108
integer taborder = 360
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Alle"
end type

event clicked;
oDW.SetFilter("")
oDW.Filter()

oDW.Sort()

end event

