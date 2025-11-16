HA$PBExportHeader$uo_filterblock_num.sru
forward
global type uo_filterblock_num from userobject
end type
type rb_kleiner from radiobutton within uo_filterblock_num
end type
type rb_groesser from radiobutton within uo_filterblock_num
end type
type rb_gleich from radiobutton within uo_filterblock_num
end type
type cb_41 from commandbutton within uo_filterblock_num
end type
type cb_40 from commandbutton within uo_filterblock_num
end type
type cb_39 from commandbutton within uo_filterblock_num
end type
type cb_38 from commandbutton within uo_filterblock_num
end type
type cb_37 from commandbutton within uo_filterblock_num
end type
type cb_36 from commandbutton within uo_filterblock_num
end type
type cb_35 from commandbutton within uo_filterblock_num
end type
type cb_34 from commandbutton within uo_filterblock_num
end type
type cb_33 from commandbutton within uo_filterblock_num
end type
type cb_32 from commandbutton within uo_filterblock_num
end type
type em_1 from editmask within uo_filterblock_num
end type
type pb_such from picturebutton within uo_filterblock_num
end type
type cb_1 from commandbutton within uo_filterblock_num
end type
type gb_abgleich from groupbox within uo_filterblock_num
end type
end forward

global type uo_filterblock_num from userobject
integer width = 530
integer height = 744
boolean border = true
long backcolor = 79741120
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
rb_kleiner rb_kleiner
rb_groesser rb_groesser
rb_gleich rb_gleich
cb_41 cb_41
cb_40 cb_40
cb_39 cb_39
cb_38 cb_38
cb_37 cb_37
cb_36 cb_36
cb_35 cb_35
cb_34 cb_34
cb_33 cb_33
cb_32 cb_32
em_1 em_1
pb_such pb_such
cb_1 cb_1
gb_abgleich gb_abgleich
end type
global uo_filterblock_num uo_filterblock_num

type variables
Public:
	DataWindow	oDW
	String		FilteredColumn
	boolean		bFilter
//	String		sEventToTrigger
	
	
Private:	
//	Boolean		bTrigger
	String		sDataType
	long			lStartrow = 1
	
end variables

forward prototypes
public subroutine setformat (maskdatatype argmaskdatatype, string argformat)
private function integer filter_num (string filterkrit)
end prototypes

public subroutine setformat (maskdatatype argmaskdatatype, string argformat);em_1.SetMask(Argmaskdatatype, ArgFormat)
end subroutine

private function integer filter_num (string filterkrit);// Filter oder Find
String	sAbgleich
long lRow

If rb_gleich.checked Then
	sAbgleich = "="
Elseif rb_groesser.checked Then	
	sAbgleich = ">="
Else
	sAbgleich = "<="
End if

If bFilter = True Then
	oDW.SetFilter (filteredcolumn + sAbgleich + filterkrit)
	oDW.Filter()
	odw.Setfocus()
	odw.Setcolumn(filteredcolumn)
Else
	lRow = oDW.Find(filteredcolumn + sAbgleich + filterkrit,lStartrow,odw.Rowcount())
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


return 1

end function

on uo_filterblock_num.create
this.rb_kleiner=create rb_kleiner
this.rb_groesser=create rb_groesser
this.rb_gleich=create rb_gleich
this.cb_41=create cb_41
this.cb_40=create cb_40
this.cb_39=create cb_39
this.cb_38=create cb_38
this.cb_37=create cb_37
this.cb_36=create cb_36
this.cb_35=create cb_35
this.cb_34=create cb_34
this.cb_33=create cb_33
this.cb_32=create cb_32
this.em_1=create em_1
this.pb_such=create pb_such
this.cb_1=create cb_1
this.gb_abgleich=create gb_abgleich
this.Control[]={this.rb_kleiner,&
this.rb_groesser,&
this.rb_gleich,&
this.cb_41,&
this.cb_40,&
this.cb_39,&
this.cb_38,&
this.cb_37,&
this.cb_36,&
this.cb_35,&
this.cb_34,&
this.cb_33,&
this.cb_32,&
this.em_1,&
this.pb_such,&
this.cb_1,&
this.gb_abgleich}
end on

on uo_filterblock_num.destroy
destroy(this.rb_kleiner)
destroy(this.rb_groesser)
destroy(this.rb_gleich)
destroy(this.cb_41)
destroy(this.cb_40)
destroy(this.cb_39)
destroy(this.cb_38)
destroy(this.cb_37)
destroy(this.cb_36)
destroy(this.cb_35)
destroy(this.cb_34)
destroy(this.cb_33)
destroy(this.cb_32)
destroy(this.em_1)
destroy(this.pb_such)
destroy(this.cb_1)
destroy(this.gb_abgleich)
end on

event constructor;
SetNULL(filteredcolumn)



end event

type rb_kleiner from radiobutton within uo_filterblock_num
integer x = 201
integer y = 632
integer width = 247
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "kleiner"
borderstyle borderstyle = stylelowered!
end type

type rb_groesser from radiobutton within uo_filterblock_num
integer x = 201
integer y = 564
integer width = 247
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "gr$$HEX2$$f600df00$$ENDHEX$$er"
borderstyle borderstyle = stylelowered!
end type

type rb_gleich from radiobutton within uo_filterblock_num
integer x = 201
integer y = 504
integer width = 247
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "gleich"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type cb_41 from commandbutton within uo_filterblock_num
string tag = "number"
integer x = 151
integer y = 248
integer width = 114
integer height = 108
integer taborder = 320
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "0"
end type

event clicked;Filter_Num(This.Text)
end event

type cb_40 from commandbutton within uo_filterblock_num
string tag = "number"
integer x = 37
integer y = 248
integer width = 114
integer height = 108
integer taborder = 310
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "9"
end type

event clicked;Filter_Num(This.Text)
end event

type cb_39 from commandbutton within uo_filterblock_num
string tag = "number"
integer x = 379
integer y = 140
integer width = 114
integer height = 108
integer taborder = 360
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "8"
end type

event clicked;Filter_Num(This.Text)
end event

type cb_38 from commandbutton within uo_filterblock_num
string tag = "number"
integer x = 265
integer y = 140
integer width = 114
integer height = 108
integer taborder = 360
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "7"
end type

event clicked;Filter_Num(This.Text)
end event

type cb_37 from commandbutton within uo_filterblock_num
string tag = "number"
integer x = 151
integer y = 140
integer width = 114
integer height = 108
integer taborder = 310
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "6"
end type

event clicked;Filter_Num(This.Text)
end event

type cb_36 from commandbutton within uo_filterblock_num
string tag = "number"
integer x = 37
integer y = 140
integer width = 114
integer height = 108
integer taborder = 290
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "5"
end type

event clicked;Filter_Num(This.Text)
end event

type cb_35 from commandbutton within uo_filterblock_num
string tag = "number"
integer x = 379
integer y = 32
integer width = 114
integer height = 108
integer taborder = 290
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "4"
end type

event clicked;Filter_Num(This.Text)
end event

type cb_34 from commandbutton within uo_filterblock_num
string tag = "number"
integer x = 265
integer y = 32
integer width = 114
integer height = 108
integer taborder = 290
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "3"
end type

event clicked;Filter_Num(This.Text)
end event

type cb_33 from commandbutton within uo_filterblock_num
string tag = "number"
integer x = 151
integer y = 32
integer width = 114
integer height = 108
integer taborder = 290
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "2"
end type

event clicked;Filter_Num(This.Text)
end event

type cb_32 from commandbutton within uo_filterblock_num
string tag = "number"
integer x = 37
integer y = 32
integer width = 114
integer height = 108
integer taborder = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "1"
end type

event clicked;Filter_Num(This.Text)
end event

type em_1 from editmask within uo_filterblock_num
integer x = 37
integer y = 368
integer width = 457
integer height = 92
integer taborder = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type pb_such from picturebutton within uo_filterblock_num
integer x = 18
integer y = 536
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


sFilter = trim(em_1.text)
If len(sFilter) > 0 Then
	Filter_Num(sFilter)	
Else
	beep(1)
End if	



oDW.Setfocus()

end event

type cb_1 from commandbutton within uo_filterblock_num
integer x = 265
integer y = 248
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

type gb_abgleich from groupbox within uo_filterblock_num
integer x = 187
integer y = 464
integer width = 311
integer height = 248
integer taborder = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

