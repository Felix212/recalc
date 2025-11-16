HA$PBExportHeader$uo_dropdown_parent_dw.sru
$PBExportComments$Drop Down Parent aller Datawindows
forward
global type uo_dropdown_parent_dw from datawindow
end type
type s_setdw from structure within uo_dropdown_parent_dw
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

global type uo_dropdown_parent_dw from datawindow
integer width = 713
integer height = 364
integer taborder = 1
boolean border = false
borderstyle borderstyle = stylelowered!
end type
global uo_dropdown_parent_dw uo_dropdown_parent_dw

type variables
long lChildRow = 1 
end variables

forward prototypes
public function datawindowchild uf_edit_style (string scolumn)
end prototypes

public function datawindowchild uf_edit_style (string scolumn);// --------------------------------------
// Standard Editstyles und Pr$$HEX1$$fc00$$ENDHEX$$fungen
// --------------------------------------
	integer i,iColumns
	string  sColumnType,sColumnText,sColumnName
	string  sMText,sDataType
	string  sReturn
	long	  lDDDWwidth,lWidth,lPercentWidth
	

// -------------------------------
// Standard Datawindow Tabular
// -------------------------------
	this.Modify("DataWindow.Message.Title='" + uf.translate("Eingabefehler") + "'")
	this.Modify("DataWindow.Detail.Height='88'")
	this.Modify("DataWindow.Header.Height='0'")
	this.Modify("DataWindow.Color='79741120'")
	
	iColumns = integer(this.Object.DataWindow.Column.Count)
	
// --------------------------------------
// nur Columns die eine Width haben !
// --------------------------------------
	If integer(this.Describe("#1.Width")) > 0 Then
		lWidth   = integer(this.Describe("#1.Width"))
	// --------------------------------------
	// Standard Eigenschaften Columns
	// --------------------------------------
		this.Modify("#1.Font.Face='MS Sans Serif'")
		this.Modify("#1.Font.CharSet='0'")
		this.Modify("#1.Font.Pitch='2'")
		this.Modify("#1.Font.Family='2'")
		this.Modify("#1.Font.Height='-9'")
		this.Modify("#1.y='4'")
		this.Modify("#1.Height='80'")
		this.Modify("#1.Border=5")
		sDataType = lower(this.Describe ("#1.ColType"))
	// --------------------------------------
	// Neu Dateformat
	// --------------------------------------
		If Match(sDataType, "date") Then
			this.Modify("#1.Format='" + s_app.sDateformat + "'")
		End if	

		If Upper(this.Describe("#1.Edit.Style")) = "DDDW" Then
			if Upper(this.describe("#1.DDDW.VScrollbar")) <> "YES" Then
				Messagebox ("Hallo Entwickler", "Vertikaler Scrollbar anschalten bei " + This.DataObject)	
			end if
			if Upper(this.describe("#1.DDDW.Lines")) <> "5" Then
				Messagebox ("Hallo Entwickler", "Lines auf 5 einstellen bei " + This.DataObject)	
			end if
			if Upper(this.describe("#1.DDDW.UseAsBorder")) <> "YES" Then
				Messagebox ("Hallo Entwickler", "Use Borders anschalten bei " + This.DataObject)	
			end if
		end if
			
	End if	
	
// --------------------------------------
// So und nun das ChildWindow (Grid)
// --------------------------------------
	DataWindowChild dw_child

	integer iReturn
	iReturn = this.GetChild(sColumn, dw_child)

	IF iReturn = -1 THEN 
		MessageBox("Hallo Entwickler", "Da stimmt was mit dem DataWindowChild nicht (" + sColumn + ") .")
	End if
// --------------------------------------
// Standard Datawindow
// --------------------------------------
	dw_child.Modify("DataWindow.Detail.Height='88'")
	dw_child.Modify("DataWindow.Header.Height='0'")
	dw_child.Modify("DataWindow.Grid.ColumnMove=No")
	dw_child.Modify("DataWindow.Selected.mouse=No")
	
	iColumns = integer(dw_child.Describe("DataWindow.Column.Count"))
	lDDDWwidth = 0
	For i = 1 to iColumns
		sColumnType = dw_child.describe("#" + string(i) + ".Edit.Style")
	// --------------------------------------
	// nur Columns die eine Width haben !
	// --------------------------------------
		If integer(dw_child.Describe("#" + string(i) + ".Width")) > 0 Then
			lDDDWwidth += integer(dw_child.Describe("#" + string(i) + ".Width"))
			sDataType = lower(dw_child.Describe ("#" + string(i) + ".ColType"))
		// --------------------------------------
		// Neu Dateformat
		// --------------------------------------
			If Match(sDataType, "date") Then
				dw_child.Modify("#" + string(i) + ".Edit.Format='" + s_app.sDateformat   + "'")
				dw_child.Modify("#" + string(i) + ".Format='" + s_app.sDateformat   + "'")
			End if	
		
		// --------------------------------------
		// Standard Eigenschaften Columns
		// --------------------------------------
			dw_child.Modify("#" + string(i) + ".Color='8388608'")
			dw_child.Modify("#" + string(i) + ".Edit.FocusRectangle=NO")
			dw_child.Modify("#" + string(i) + ".Font.Face='MS Sans Serif'")
			dw_child.Modify("#" + string(i) + ".Font.CharSet='0'")
			dw_child.Modify("#" + string(i) + ".Font.Pitch='2'")
			dw_child.Modify("#" + string(i) + ".Font.Family='2'")
			dw_child.Modify("#" + string(i) + ".Font.Height='-9'")
			dw_child.Modify("#" + string(i) + ".y='0'")
			dw_child.Modify("#" + string(i) + ".Height='76'")
			
		End if	
	Next	
	
// --------------------------------------
// DDDW.PercentWidth berechnen
// --------------------------------------	
	If lWidth < lDDDWwidth and lWidth <> 0 Then
		lPercentWidth = lDDDWwidth / lWidth * 100 
		this.Modify("#1.DDDW.PercentWidth='" + string(lPercentWidth) + "'")
	Else
		this.Modify("#1.DDDW.PercentWidth='100'")
	End if	
		
	return dw_child
end function

event dberror;// --------------------------------------------
// Error's f$$HEX1$$fc00$$ENDHEX$$r Oracle-Datenbank
// --------------------------------------------

	uf.mbox(sqldbcode,sqlerrtext)

	this.setrow(row)
	this.scrolltorow(row)
Return 1
end event

on uo_dropdown_parent_dw.create
end on

on uo_dropdown_parent_dw.destroy
end on

