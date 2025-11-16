HA$PBExportHeader$uo_filterblock_date.sru
forward
global type uo_filterblock_date from userobject
end type
type pb_such from picturebutton within uo_filterblock_date
end type
type cb_1 from commandbutton within uo_filterblock_date
end type
type rb_kleiner from radiobutton within uo_filterblock_date
end type
type rb_groesser from radiobutton within uo_filterblock_date
end type
type rb_gleich from radiobutton within uo_filterblock_date
end type
type ole_1 from olecustomcontrol within uo_filterblock_date
end type
type gb_abgleich from groupbox within uo_filterblock_date
end type
end forward

global type uo_filterblock_date from userobject
integer width = 617
integer height = 484
boolean border = true
long backcolor = 79741120
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
pb_such pb_such
cb_1 cb_1
rb_kleiner rb_kleiner
rb_groesser rb_groesser
rb_gleich rb_gleich
ole_1 ole_1
gb_abgleich gb_abgleich
end type
global uo_filterblock_date uo_filterblock_date

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
public function integer filter_date (string filterkrit)
end prototypes

public subroutine setformat (maskdatatype argmaskdatatype, string argformat);
end subroutine

public function integer filter_date (string filterkrit);
// Filter oder Find

String	sAbgleich
long 		lRow

If rb_gleich.checked Then
	sAbgleich = "="
Elseif rb_groesser.checked Then	
	sAbgleich = ">="
Else
	sAbgleich = "<="
End if
	
If bFilter = True Then
	oDW.SetFilter (filteredcolumn + " " + sAbgleich + " date('" + FilterKrit + "')")
	oDW.Filter()
	odw.Setfocus()
	odw.Setcolumn(filteredcolumn)
Else
	lRow = oDW.Find(filteredcolumn + " " + sAbgleich + " date('" + FilterKrit + "')",lStartrow,odw.Rowcount())
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

on uo_filterblock_date.create
this.pb_such=create pb_such
this.cb_1=create cb_1
this.rb_kleiner=create rb_kleiner
this.rb_groesser=create rb_groesser
this.rb_gleich=create rb_gleich
this.ole_1=create ole_1
this.gb_abgleich=create gb_abgleich
this.Control[]={this.pb_such,&
this.cb_1,&
this.rb_kleiner,&
this.rb_groesser,&
this.rb_gleich,&
this.ole_1,&
this.gb_abgleich}
end on

on uo_filterblock_date.destroy
destroy(this.pb_such)
destroy(this.cb_1)
destroy(this.rb_kleiner)
destroy(this.rb_groesser)
destroy(this.rb_gleich)
destroy(this.ole_1)
destroy(this.gb_abgleich)
end on

event constructor;
SetNULL(filteredcolumn)



end event

type pb_such from picturebutton within uo_filterblock_date
integer x = 32
integer y = 172
integer width = 146
integer height = 128
integer taborder = 200
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

event clicked;String	sMask


date 			dlDate
Any 			aYear, aMonth, aDay
Integer 		iYear, iMonth, iDay


aYear		= ole_1.object.Year
aMonth	= ole_1.object.Month
aDay		= ole_1.object.Day

iYear		= aYear
iMonth	= aMonth
iDay		= aDay


dlDate		= Date(iyear, iMonth, iDay)

sMask = oDW.Describe(filteredcolumn + ".editmask.mask")

if sMask = "!" OR sMask = "?" Then
	sMask = "dd.mm.yyyy"
end if


Filter_Date(string(dlDate, sMask))


oDW.Setfocus()

end event

type cb_1 from commandbutton within uo_filterblock_date
integer x = 27
integer y = 324
integer width = 146
integer height = 128
integer taborder = 200
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

type rb_kleiner from radiobutton within uo_filterblock_date
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

type rb_groesser from radiobutton within uo_filterblock_date
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

type rb_gleich from radiobutton within uo_filterblock_date
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

type ole_1 from olecustomcontrol within uo_filterblock_date
event callbackkeydown ( integer keycode,  integer shift,  string callbackfield,  ref datetime callbackdate )
event change ( )
event closeup ( )
event dropdown ( )
event format ( string callbackfield,  ref string formattedstring )
event formatsize ( string callbackfield,  ref integer size )
event click ( )
event dblclick ( )
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event olestartdrag ( ref oleobject data,  ref long allowedeffects )
event olegivefeedback ( ref long effect,  ref boolean defaultcursors )
event olesetdata ( ref oleobject data,  ref integer dataformat )
event olecompletedrag ( ref long effect )
event oledragover ( ref oleobject data,  ref long effect,  ref integer button,  ref integer shift,  ref real ocx_x,  ref real ocx_y,  ref integer state )
event oledragdrop ( ref oleobject data,  ref long effect,  ref integer button,  ref integer shift,  ref real ocx_x,  ref real ocx_y )
integer x = 27
integer y = 40
integer width = 553
integer height = 92
integer taborder = 160
boolean border = false
boolean focusrectangle = false
string binarykey = "uo_filterblock_date.udo"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type gb_abgleich from groupbox within uo_filterblock_date
integer x = 265
integer y = 136
integer width = 311
integer height = 320
integer taborder = 190
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


Start of PowerBuilder Binary Data Section : Do NOT Edit
08uo_filterblock_date.bin 
2C00000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000e473ac3001c05ec800000003000001400000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000480000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a00000002000000010000000420dd1b9e11d187c40000e38ba14d75f800000000e46d91b001c05ec8e473ac3001c05ec800000000000000000000000000000001fffffffe0000000300000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff003500360041003100390038003000340038002d00430037002d003500310031003100640038002d00450042002d003300300030003000300038004600350037004400340031004100730061003b0065003a00640070005c006f007200720067006d0061005c00730079005300610062006500730050005c0077006f00720065123443210000000800000c81000002610e7f28410006000000000034000b07d0001d00030000000000000000000c270f001f00050000000000000000000106410001000100000000000000000000000000000000abcdef01000500000012e56800200006ffffffffffffffff77b812b00000000a00640064006d002e002e006d0079007900790079bdecde1f000500010012e598006900740065007600530020007200650065007600200072006e0041007700790065006800650072003600200030002e0077005c006e0069003200330064003b005c003a007200700067006f006100720073006d0053005c0062007900730061005c0065006f00500065007700420072006900750064006c00720065003700200030002e0048005c006c0065003b00700044003b005c003a007200500067006f006100720073006d004f005c006100720074006e0062005c006e00690043003b005c003a007200500067006f006100720073006d0050005c00720065005c006c00690062005c006e0043003b006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000200000094000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18uo_filterblock_date.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
