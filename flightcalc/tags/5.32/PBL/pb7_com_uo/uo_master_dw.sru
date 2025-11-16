HA$PBExportHeader$uo_master_dw.sru
forward
global type uo_master_dw from datawindow
end type
end forward

global type uo_master_dw from datawindow
integer width = 3035
integer height = 1212
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type
global uo_master_dw uo_master_dw

type variables

end variables

forward prototypes
public function boolean uf_edit_style ()
end prototypes

public function boolean uf_edit_style ();// --------------------------------------
// Standard Editstyles unf Pr$$HEX1$$fc00$$ENDHEX$$fungen
// --------------------------------------
	integer i,iColumns, j
	string  sColumnType, sColumnName, sBufferColumn

	
// -------------------------------
// Standard Datawindow Master-Detail
// N-Up
// -------------------------------
	this.Modify("DataWindow.Message.Title='" + uf.translate("Eingabefehler") + "'")
	this.Modify("DataWindow.Detail.Height='78'")
	this.Modify("DataWindow.Header.Height='72'")
	
	
	iColumns = integer(this.Object.DataWindow.Column.Count)
	
	For i = 1 to iColumns
	// --------------------------------------
	// nur Columns die eine Width haben !
	// --------------------------------------
		If integer(this.Describe("#" + string(i) + ".Width")) > 0 Then
			sColumnName = this.Describe("#" + string(i) + ".Name")
			// ----------------------------------
			// n-up columns haben immer die form
			// _Zahl
			// ----------------------------------
			if Match (sColumnName, "_[0-9]") then
				sBufferColumn = Mid(sColumnName, 1, Pos(sColumnName, "_"))

				for j = 1 to Integer(This.Object.DataWindow.rows_per_detail)
			
					// --------------------------------------
					// Standard Eigenschaften Columns
					// --------------------------------------
					this.Modify(sBufferColumn + string(j) + ".Edit.FocusRectangle=NO")
					this.Modify(sBufferColumn + string(j) + ".Edit.AutoHScroll=YES")
					this.Modify(sBufferColumn + string(j) + ".Edit.AutoSelect=YES")
					this.Modify(sBufferColumn + string(j) + ".Font.Face='MS Sans Serif'")					
					this.Modify(sBufferColumn + string(j) + ".Font.CharSet='0'")
					this.Modify(sBufferColumn + string(j) + ".Font.Pitch='2'")
					this.Modify(sBufferColumn + string(j) + ".Font.Family='2'")
					this.Modify(sBufferColumn + string(j) + ".Font.Height='-10'")
					this.Modify(sBufferColumn + string(j) + ".y='0'")
					this.Modify(sBufferColumn + string(j) + ".Height='68'")
					this.Modify(sBufferColumn + string(j) + ".Width='280'")	
					this.Modify(sBufferColumn + string(j) + ".Border='6'")
					this.Modify(sBufferColumn + string(j) + ".Background.Color='79741120 ~t if(isSelected(), 255, 79741120)'")
				next
			end if
		End if	
	Next

return True
end function

on uo_master_dw.create
end on

on uo_master_dw.destroy
end on

event itemchanged;string	sText, sColName, sSearch, sOrgtext, sData_type
integer	iCol
Long		lRow

// ----------------------------------------------------------
// Eingegebenen Wert lesen und durch Original ersetzen
// ----------------------------------------------------------

if row > 0 then
	iCol 	= This.GetColumn()
	sText = data

	sColName   = "#" + string(iCol)
	sData_type = This.Describe(sColName + ".ColType")
		
	IF sData_type = "number" THEN
		sOrgtext = string(This.GetItemNumber (row, iCol, Primary!, TRUE))
		This.SetText (sOrgtext)
		This.SelectText (1, Len (sOrgtext))
		sSearch = sColName + " >= " + sText
	Else
		sOrgtext = This.GetItemstring (row, iCol, Primary!, TRUE)
		This.SetText (sOrgtext)
		This.SelectText (1, Len (sOrgtext))
		sSearch = "Match(" + sColName  + ", '^" + Upper(sText) + "')"
	End if
	
	lRow = This.Find (sSearch, 1, This.RowCount())
	
	if lRow > 0 then
		This.ScrollToRow (lRow)
	else
		This.ScrollToRow (This.RowCount())
	end if
	Return 1

end if

end event

event itemerror;


return 1

end event

