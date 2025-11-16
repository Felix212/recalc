HA$PBExportHeader$uo_filterblock_time.sru
forward
global type uo_filterblock_time from userobject
end type
type pb_such from picturebutton within uo_filterblock_time
end type
type rb_kleiner from radiobutton within uo_filterblock_time
end type
type rb_groesser from radiobutton within uo_filterblock_time
end type
type rb_gleich from radiobutton within uo_filterblock_time
end type
type em_1 from editmask within uo_filterblock_time
end type
type cb_1 from commandbutton within uo_filterblock_time
end type
type gb_abgleich from groupbox within uo_filterblock_time
end type
end forward

global type uo_filterblock_time from userobject
integer width = 635
integer height = 492
boolean border = true
long backcolor = 79741120
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
pb_such pb_such
rb_kleiner rb_kleiner
rb_groesser rb_groesser
rb_gleich rb_gleich
em_1 em_1
cb_1 cb_1
gb_abgleich gb_abgleich
end type
global uo_filterblock_time uo_filterblock_time

type variables
Public:
	DataWindow	oDW
	String		FilteredColumn
	boolean		bFilter
//	String		sEventToTrigger
	
	
Private:	
//	Boolean		bTrigger
	String		sDataType
	long			lStartrow
	
end variables

forward prototypes
public subroutine setformat (maskdatatype argmaskdatatype, string argformat)
public function integer filter_time (string filterkrit)
end prototypes

public subroutine setformat (maskdatatype argmaskdatatype, string argformat);em_1.SetMask(Argmaskdatatype, ArgFormat)
em_1.Text = String(Now())
end subroutine

public function integer filter_time (string filterkrit);// Filter oder Find
String	sAbgleich, sMask
time		tTime
long lRow

sMask = oDW.Describe(filteredcolumn + ".editmask.mask")

If sMask = "!" OR  sMask = "?" Then
	sMask = "hh:mm"
End if

tTime	= Time(filterkrit)

If rb_gleich.checked Then
	sAbgleich = "="
Elseif rb_groesser.checked Then	
	sAbgleich = ">="
Else
	sAbgleich = "<="
End if

If bFilter = True Then
	oDW.SetFilter (filteredcolumn + sAbgleich + String(tTime, sMask))
	oDW.Filter()
	odw.Setfocus()
	odw.Setcolumn(filteredcolumn)
Else
	lRow = oDW.Find(filteredcolumn + sAbgleich + String(tTime, sMask),lStartrow,odw.Rowcount())
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

on uo_filterblock_time.create
this.pb_such=create pb_such
this.rb_kleiner=create rb_kleiner
this.rb_groesser=create rb_groesser
this.rb_gleich=create rb_gleich
this.em_1=create em_1
this.cb_1=create cb_1
this.gb_abgleich=create gb_abgleich
this.Control[]={this.pb_such,&
this.rb_kleiner,&
this.rb_groesser,&
this.rb_gleich,&
this.em_1,&
this.cb_1,&
this.gb_abgleich}
end on

on uo_filterblock_time.destroy
destroy(this.pb_such)
destroy(this.rb_kleiner)
destroy(this.rb_groesser)
destroy(this.rb_gleich)
destroy(this.em_1)
destroy(this.cb_1)
destroy(this.gb_abgleich)
end on

event constructor;
SetNULL(filteredcolumn)



end event

type pb_such from picturebutton within uo_filterblock_time
integer x = 32
integer y = 172
integer width = 146
integer height = 128
integer taborder = 370
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
string picturename = "..\Resource\seek.gif"
alignment htextalign = left!
end type

event clicked;string 	sFilter

sFilter = trim(em_1.text)



Filter_Time(sFilter)	


//yield()
//oDW.Triggerevent(sEventToTrigger)
oDW.Setfocus()

end event

type rb_kleiner from radiobutton within uo_filterblock_time
integer x = 279
integer y = 352
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

type rb_groesser from radiobutton within uo_filterblock_time
integer x = 279
integer y = 264
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

type rb_gleich from radiobutton within uo_filterblock_time
integer x = 279
integer y = 176
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

type em_1 from editmask within uo_filterblock_time
integer x = 23
integer y = 40
integer width = 553
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

type cb_1 from commandbutton within uo_filterblock_time
integer x = 27
integer y = 324
integer width = 146
integer height = 128
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

type gb_abgleich from groupbox within uo_filterblock_time
integer x = 265
integer y = 136
integer width = 311
integer height = 320
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

