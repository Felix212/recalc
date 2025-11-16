HA$PBExportHeader$uo_print_dw.sru
$PBExportComments$Parent aller Datawindows
forward
global type uo_print_dw from datawindow
end type
type s_setdw from structure within uo_print_dw
end type
end forward

type s_setdw from structure
	boolean		bfilter
	boolean		bfind
	boolean		bsort
	boolean		breadonly
	boolean		bcut
	boolean		bcopy
	boolean		bpaste
end type

shared variables

end variables

global type uo_print_dw from datawindow
integer width = 713
integer height = 364
integer taborder = 1
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylelowered!
event ue_mouseup pbm_lbuttonup
event ue_mouseout pbm_dwnmousemove
event ue_accepttext ( )
end type
global uo_print_dw uo_print_dw

type variables
Public:


Private:
string sLastcolumn,sLastsort,sLastTempcolumn
String sLastObject

boolean bFocus
end variables

forward prototypes
public function boolean uf_edit_style ()
end prototypes

public function boolean uf_edit_style ();// --------------------------------------
// Standard Editstyles und Pr$$HEX1$$fc00$$ENDHEX$$fungen
// --------------------------------------
	integer i,iColumns
	string  sColumnType,sColumnText,sColumnName,sDataType
	string  sMText
	string  sReturn
	long	  lDDDWwidth,lWidth,lPercentWidth

	
	iColumns = integer(this.Object.DataWindow.Column.Count)
	For i = 1 to iColumns
		sColumnType = this.describe("#" + string(i) + ".Edit.Style")
		sDataType = lower(this.Describe ("#" + string(i) + ".ColType"))
	// --------------------------------------
	// nur Columns die eine Width haben !
	// --------------------------------------
		If integer(this.Describe("#" + string(i) + ".Width")) > 0 Then
		// --------------------------------------
		// Neu Dateformat
		// --------------------------------------
			If Match (sDataType, "date") Then
				this.Modify("#" + string(i) + ".Edit.Format='" + s_app.sDateformat   + "'")
				this.Modify("#" + string(i) + ".Format='" + s_app.sDateformat   + "'")
			End if	
			
		// --------------------------------------
		// Standard Eigenschaften Edit
		// --------------------------------------
			If Upper(sColumnType) = "EDIT" Then
				this.Modify("#" + string(i) + ".Edit.FocusRectangle=NO")
				this.Modify("#" + string(i) + ".Edit.AutoHScroll=YES")
				this.Modify("#" + string(i) + ".Edit.AutoSelect=YES")
			End if
		End if	
	Next

	
return True
end function

event dberror;// --------------------------------------------
// Error's f$$HEX1$$fc00$$ENDHEX$$r Oracle-Datenbank
// --------------------------------------------
	uf.mbox(sqldbcode,sqlerrtext)

	this.setrow(row)
	this.scrolltorow(row)
	Return 1

end event

on uo_print_dw.create
end on

on uo_print_dw.destroy
end on

event getfocus;bFocus = True
end event

event losefocus;bFocus = False


end event

event retrieveend;uf_edit_style()

end event

