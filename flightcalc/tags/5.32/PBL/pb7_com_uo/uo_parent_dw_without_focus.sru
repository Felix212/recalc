HA$PBExportHeader$uo_parent_dw_without_focus.sru
$PBExportComments$Parent aller Datawindows
forward
global type uo_parent_dw_without_focus from datawindow
end type
type s_setdw from structure within uo_parent_dw_without_focus
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

global type uo_parent_dw_without_focus from datawindow
integer width = 713
integer height = 364
integer taborder = 1
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylelowered!
event ue_mouseup pbm_lbuttonup
event ue_mouseout pbm_dwnmousemove
end type
global uo_parent_dw_without_focus uo_parent_dw_without_focus

type variables
Public:

uo_setdw 		dw_settings
uo_history		dw_history

Private:
string sLastcolumn,sLastsort,sLastTempcolumn
String sLastObject


end variables

forward prototypes
public subroutine uf_click_sort (string scolumnname)
public function long uf_style_dddw (string scolumn)
public function boolean uf_edit_style ()
public function boolean uf_add_validation (string scolumn)
end prototypes

event ue_mouseup;
IF Pos( this.GetObjectAtPointer(),sLastTempcolumn) > 0 THEN
	this.Modify (sLastTempcolumn + ".Border = '6'") // 3-D raised border
END IF


end event

event ue_mouseout;If sLastObject <> dwo.Name Then
	this.Modify (sLastTempcolumn + ".Border = '6'") // 3-D raised border
End if

sLastObject = dwo.Name 
	


end event

public subroutine uf_click_sort (string scolumnname);Long ll_X1, ll_Y1, ll_X2, ll_Y2, ll_X3, ll_x4, ll_Y3, ll_Y4
String ls_Mod

this.SetRedraw( FALSE )

ll_X1 = Long( this.Describe( scolumnname + '_t.X' ) ) + 5
ll_Y1 = Long( this.Describe( scolumnname + '_t.Y' ) ) + 3

ls_Mod = 'destroy sort_ln1 destroy sort_ln2 destroy sort_ln3'
this.Modify( ls_Mod )

ll_X2 = PixelsToUnits( &
	UnitsToPixels( ll_X1, XUnitsToPixels! ) + 4, XPixelsToUnits! )
ll_X3 = PixelsToUnits( &
	UnitsToPixels( ll_X1, XUnitsToPixels! ) + 3, XPixelsToUnits! )
ll_X4 = PixelsToUnits( &
	UnitsToPixels( ll_X1, XUnitsToPixels! ) + 8, XPixelsToUnits! )
ll_Y2 = PixelsToUnits( &
	UnitsToPixels( ll_Y1, YUnitsToPixels! ) + 4, YPixelsToUnits! )
ll_Y3 = PixelsToUnits( &
	UnitsToPixels( ll_Y1, YUnitsToPixels! ) + 5, YPixelsToUnits! )
ll_Y4 = PixelsToUnits( &
	UnitsToPixels( ll_Y1, YUnitsToPixels! ) - 1, YPixelsToUnits! )

// -------------------------------------
// Click auf die gleiche Spalte ?
// -------------------------------------
	If sLastcolumn = sColumnname Then
		If sLastsort = "A" Then
			sLastsort = "D"
		Else	
			sLastsort = "A"
		End if		
	Else
		sLastsort = "A"
	End if

// If the sort sequence is ascending or decending
IF sLastSort = 'A' THEN
	ls_Mod = 'create line(band=header x1="' + String( ll_X1 ) &
		+ '" y1="' + string( ll_Y1 ) &
		+ '" x2="' + String( ll_X4 ) + '" y2="' &
		+ String( ll_Y1 ) + '" pen.style="0" pen.width="5" ' &
		+ 'pen.color="33554432"  background.mode="2" ' &
		+ 'background.color="16777215" name=sort_ln1 )'
	
	ls_Mod += ' create line(band=header x1="' + String( ll_X1 ) &
		+ '" y1="' + string( ll_Y1 ) &
		+ '" x2="' + String( ll_X2 ) + '" y2="' &
		+ String( ll_Y2 ) + '" pen.style="0" pen.width="5" ' &
		+ 'pen.color="33554432"  background.mode="2" ' &
		+ 'background.color="16777215" name=sort_ln2 )'
	
	ls_Mod += ' create line(band=header x1="' + String( ll_X4 ) &
		+ '" y1="' + string( ll_Y1 ) &
		+ '" x2="' + String( ll_X3 ) + '" y2="' &
		+ String( ll_Y3 ) + '" pen.style="0" pen.width="5" ' &
		+ 'pen.color="1089522856"  background.mode="2" ' &
		+ 'background.color="16777215" name=sort_ln3 )'

ELSE
	ls_Mod = 'create line(band=header x1="' + String( ll_X1 ) &
		+ '" y1="' + string( ll_Y2 ) &
		+ '" x2="' + String( ll_X4 ) + '" y2="' + String( ll_Y2 ) &
		+ '" pen.style="0" pen.width="5" ' &
		+ 'pen.color="33554432"  background.mode="2" ' &
		+ 'background.color="16777215" name=sort_ln1 )'
	
	ls_Mod += ' create line(band=header x1="' + String( ll_X1 ) &
		+ '" y1="' + string( ll_Y2 ) &
		+ '" x2="' + String( ll_X2 ) + '" y2="' + String( ll_Y1 ) &
		+ '" pen.style="0" pen.width="5" ' &
		+ 'pen.color="33554432"  background.mode="2" ' &
		+ 'background.color="16777215" name=sort_ln2 )'
	
	ls_Mod += ' create line(band=header x1="' + String( ll_X4 ) &
		+ '" y1="' + string( ll_Y2 ) &
		+ '" x2="' + String( ll_X3 ) + '" y2="' &
		+ String( ll_Y4 ) + '" pen.style="0" pen.width="5" ' &
		+ 'pen.color="1089522856"  background.mode="2" ' &
		+ 'background.color="16777215" name=sort_ln3 )'
END IF


// -----------------------------
// Create the triangle
// -----------------------------
	this.Modify( ls_Mod )
// -----------------------------
// Sortieren
// -----------------------------
	this.SetSort(sColumnname + " " + sLastsort)
	this.Sort()
	this.SetRedraw( TRUE )
	
	sLastcolumn = sColumnname
end subroutine

public function long uf_style_dddw (string scolumn);	DataWindowChild 	dw_child
	integer 				iReturn,i,iColumns
	string  				sColumnType
	long 					lDDDWwidth
	
	iReturn = this.GetChild(sColumn,dw_child)

	IF iReturn = -1 THEN 
		MessageBox("Hallo Entwickler", "Da stimmt was mit dem DataWindowChild nicht.")
	End if

// --------------------------------------
// Standard Datawindow
// --------------------------------------
	dw_child.Modify("DataWindow.Detail.Height='80'")
	dw_child.Modify("DataWindow.Header.Height='0'")
	dw_child.Modify("DataWindow.Grid.ColumnMove=No")
	dw_child.Modify("DataWindow.Selected.mouse=No")
	
	lDDDWwidth = 0
	iColumns = integer(dw_child.Describe("DataWindow.Column.Count"))
	For i = 1 to iColumns
		sColumnType = dw_child.describe("#" + string(i) + ".Edit.Style")
	// --------------------------------------
	// nur Columns die eine Width haben !
	// --------------------------------------
		If integer(dw_child.Describe("#" + string(i) + ".Width")) > 0 Then
		// --------------------------------------
		// Breite der Spalten ++
		// --------------------------------------
			lDDDWwidth += integer(dw_child.Describe("#" + string(i) + ".Width"))
		// --------------------------------------
		// Standard Eigenschaften Columns
		// --------------------------------------
			dw_child.Modify("#" + string(i) + ".Color='8388608'")
			dw_child.Modify("#" + string(i) + ".Edit.FocusRectangle=NO")
			dw_child.Modify("#" + string(i) + ".Font.Face='MS Sans Serif'")
			dw_child.Modify("#" + string(i) + ".Font.CharSet='0'")
			dw_child.Modify("#" + string(i) + ".Font.Pitch='2'")
			dw_child.Modify("#" + string(i) + ".Font.Family='2'")
			dw_child.Modify("#" + string(i) + ".Font.Height='-10'")
			dw_child.Modify("#" + string(i) + ".y='0'")
			dw_child.Modify("#" + string(i) + ".Height='76'")
			
		End if	
	Next	
			
			
	return lDDDWwidth 
end function

public function boolean uf_edit_style ();// --------------------------------------
// Standard Editstyles und Pr$$HEX1$$fc00$$ENDHEX$$fungen
// --------------------------------------
	integer i,iColumns
	string  sColumnType,sColumnText,sColumnName,sDataType
	string  sMText
	string  sReturn
	long	  lDDDWwidth,lWidth,lPercentWidth

// -------------------------------
// Standard Datawindow Grid
// -------------------------------
	this.Modify("DataWindow.Message.Title='" + uf.translate("Eingabefehler") + "'")
	this.Modify("DataWindow.Detail.Height='80'")
	this.Modify("DataWindow.Header.Height='72'")
	this.Modify("DataWindow.Grid.ColumnMove=No")
	this.Modify("DataWindow.Selected.mouse=No")

// --------------------------------------
// Standard erster Text 
// --------------------------------------
	sReturn = this.Modify("selector.Height ='52'")
	If sReturn = "" Then
		this.Modify("selector.Width  ='120'")
		this.Modify("selector.Height ='52'")
		this.Modify("selector.Border ='6'")
		this.Modify("selector.Background.Color = '79741120'")
		this.Modify("selector.background.mode='2'")  // Send to back
	Else
		uf.mbox("Hallo Entwickler","Textobject Selector nicht vorhanden.")
	End if	
	
	
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
		// ----------------------------------------------
		// Standard Eigenschaften Drop Down Datawindow
		// ----------------------------------------------
			Elseif Upper(sColumnType) = "DDDW" Then
				If Upper(this.describe("#" + string(i) + ".DDDW.VScrollbar")) <> "YES" Then
					Messagebox ("Hallo Entwickler", "Vertikaler Scrollbar anschalten bei " + This.DataObject)	
				End if
				If Upper(this.describe("#" + string(i) + ".DDDW.Lines")) <> "5" Then
					Messagebox ("Hallo Entwickler", "Lines auf 5 einstellen bei " + This.DataObject)	
				End if
				lDDDWwidth = uf_style_dddw(this.describe("#" + string(i) + ".Name"))
				lWidth     = integer(this.Describe("#" + string(i) + ".Width"))
				
			// --------------------------------------
			// DDDW.PercentWidth berechnen
			// --------------------------------------				
				If lWidth < lDDDWwidth Then
					lPercentWidth = lDDDWwidth / lWidth * 100 
					this.Modify("#" + string(i) + ".DDDW.PercentWidth='" + string(lPercentWidth) + "'")
				Else
					this.Modify("#" + string(i) + ".DDDW.PercentWidth='100'")
				End if	
				
			End if	
		// --------------------------------------
		// Standard Eigenschaften Columns
		// --------------------------------------
			this.Modify("#" + string(i) + ".Font.Face='MS Sans Serif'")
			this.Modify("#" + string(i) + ".Font.CharSet='0'")
			this.Modify("#" + string(i) + ".Font.Pitch='2'")
			this.Modify("#" + string(i) + ".Font.Family='2'")
			this.Modify("#" + string(i) + ".Font.Height='-10'")
			this.Modify("#" + string(i) + ".y='0'")
			this.Modify("#" + string(i) + ".Height='76'")
			
			sColumnName = this.describe("#" + string(i) + ".Name")	
			sColumnText = this.describe(sColumnName + "_t.Name")
		// --------------------------------------
		// Standard Eigenschaften Texte
		// --------------------------------------
			If sColumnText <> "!" Then
				this.Modify(sColumnName + "_t.Text ='   " + this.describe(sColumnName + "_t.Text") + "'")
				this.Modify(sColumnName + "_t.Font.Face ='MS Sans Serif'")
				this.Modify(sColumnName + "_t.Font.CharSet='0'")
				this.Modify(sColumnName + "_t.Font.Pitch='2'")
				this.Modify(sColumnName + "_t.Font.Family='2'")
				this.Modify(sColumnName + "_t.Alignment ='0'")
				this.Modify(sColumnName + "_t.Font.Height ='-9'")			
				this.Modify(sColumnName + "_t.Height ='52'")
				this.Modify(sColumnName + "_t.Border ='6'")
				this.Modify(sColumnName + "_t.Background.Color = '79741120'")
				this.Modify(sColumnName + "_t.background.mode='2'")  // Send to back
			End if	
		End if	
	Next

	
return True
end function

public function boolean uf_add_validation (string scolumn);	string sReturn,sDatatype
	string sValidation,sValidationMSG
	
	
// --------------------------------
// Add Validation je nach Datentyp
// --------------------------------
	sDataType = lower(this.Describe (sColumn + ".ColType"))
	
	If Match (sDataType, "char") Then	
		sValidation 	=  'not isnull(gettext())'
		sValidationMSG =  uf.translate("Bitte geben Sie eine g$$HEX1$$fc00$$ENDHEX$$ltige Zeichenkette ein.") 
	elseif Match (sDataType, "date") Then
		sValidation 	=  'not isdate(gettext())'
		sValidationMSG =  uf.translate("Bitte geben Sie ein g$$HEX1$$fc00$$ENDHEX$$ltiges Datum ein.") 
	elseif Match (sDataType, "decimal") Then		
		sValidation 	=  'not isnumber(gettext())'
		sValidationMSG =  uf.translate("Bitte geben Sie einen g$$HEX1$$fc00$$ENDHEX$$ltigen Wert ein.") 
	elseif Match (sDataType, "long") Then
		sValidation 	=  'not isnumber(gettext())'
		sValidationMSG =  uf.translate("Bitte geben Sie einen g$$HEX1$$fc00$$ENDHEX$$ltigen Wert ein.") 
	elseif Match (sDataType, "number") Then		
		sValidation 	=  'not isnumber(gettext())'
		sValidationMSG =  uf.translate("Bitte geben Sie einen g$$HEX1$$fc00$$ENDHEX$$ltigen Wert ein.") 	
	elseif Match (sDataType, "real") Then		
		sValidation 	=  'not isnumber(gettext())'
		sValidationMSG =  uf.translate("Bitte geben Sie einen g$$HEX1$$fc00$$ENDHEX$$ltigen Wert ein.") 	
	elseif Match (sDataType, "ulong") Then
		sValidation 	=  'not isnumber(gettext())'
		sValidationMSG =  uf.translate("Bitte geben Sie einen g$$HEX1$$fc00$$ENDHEX$$ltigen Wert ein.") 
	elseif Match (sDataType, "int") Then		
		sValidation 	=  'not isnumber(gettext())'
		sValidationMSG =  uf.translate("Bitte geben Sie einen g$$HEX1$$fc00$$ENDHEX$$ltigen Wert ein.") 
	elseif Match (sDataType, "time") Then		
		sValidation 	=  'not istime(gettext())'
		sValidationMSG =  uf.translate("Bitte geben Sie eine g$$HEX1$$fc00$$ENDHEX$$ltige Zeit ein.") 
	elseif Match (sDataType, "timestamp") Then		
		sValidation 	=  'not istime(gettext())'
		sValidationMSG =  uf.translate("Bitte geben Sie eine g$$HEX1$$fc00$$ENDHEX$$ltige Zeit ein.") 
	End if	
	
// --------------------------------
// Add Validation
// --------------------------------
	sReturn = this.modify(sColumn + ".Validation = '" + sValidation + "'")
	If sReturn <> "" Then return False
// ---------------------------
// Add Validation Message
// ---------------------------
	sReturn = this.modify(sColumn + ".ValidationMSG = '" + sValidationMSG + "'")
	If sReturn <> "" Then return False

	this.Modify(sColumn + ".Edit.NilIsNull=YES")
	this.Modify(sColumn + ".Edit.Required=YES")
			
	Return True
	
end function

event dberror;// --------------------------------------------
// Error's f$$HEX1$$fc00$$ENDHEX$$r Oracle-Datenbank
// --------------------------------------------
	uf.mbox(sqldbcode,sqlerrtext)

	this.setrow(row)
	this.scrolltorow(row)
	Return 1

end event

event clicked;	string sTab
	string  sColumn

// --------------------------------------
// War es ein Click in den Column Header
// --------------------------------------
	If dw_settings.bSort = True Then
		IF Right(dwo.Name,2) = '_t' THEN
			sColumn = LEFT(dwo.Name, LEN(String(dwo.Name)) - 2)
			this.Modify(dwo.Name + ".Border = '5'") // 3-D lowered border 
			sLastTempColumn = dwo.Name
			this.uf_click_sort(sColumn)
		End if
	End if	
// -------------------------------------------------------
// Auch Columns ansprechen die Taborder 0 haben.
// -------------------------------------------------------
	If Row <= 0 then return
	If Row <> this.getrow() then 
		sTab = describe('#'+string(getcolumn())+'.tabsequence')
		If  sTab = '0' then this.setrow(Row)
	End if



end event

event constructor;// -------------------------------
// UserObject uo_setdw erstellen
// -------------------------------
	dw_settings = Create uo_setdw
	dw_history	= Create uo_history
end event

event rbuttondown;m_uo_dw NewMenu

NewMenu = create m_uo_dw 

NewMenu.m_data.m_excel.enabled 			= dw_settings.bexcel
NewMenu.m_data.m_mail.enabled 			= dw_settings.bmail

NewMenu.m_data.m_suchen.enabled 			= dw_settings.bfind 
NewMenu.m_data.m_filtern.enabled 		= dw_settings.bfilter
NewMenu.m_data.m_hardcopy.enabled 		= dw_settings.bhardcopy

uf.translate_menu(NewMenu)
NewMenu.m_data.PopMenu(s_app.lWindowX + this.PointerX(),s_app.lWindowY + this.PointerY())


end event

on uo_parent_dw_without_focus.create
end on

on uo_parent_dw_without_focus.destroy
end on

event itemchanged;Parent.PostEvent('ue_masterupdate')
end event

event retrieveend;// ----------------------------
// rowfocuschange ausf$$HEX1$$fc00$$ENDHEX$$hren
// ----------------------------
	Parent.PostEvent('ue_masterfocuschanged')

end event

event rowfocuschanged;Parent.PostEvent('ue_masterfocuschanged')
end event

event rowfocuschanging;// ----------------------------------------------
// Lassen wir zu das die Zeile getauscht wird ?
// ----------------------------------------------
// Messagebox("Row Changeing","Pr$$HEX1$$fc00$$ENDHEX$$fung einbauen.")
end event

event sqlpreview;// -----------------------------------
// Array mit Update-Infos f$$HEX1$$fc00$$ENDHEX$$llen
// -----------------------------------

	If SQLTYPE  = PreviewInsert!	Then
		dw_history.uf_add_history("Insert",SqlSyntax)
	ElseIf SQLTYPE  = PreviewDelete!	Then	
		dw_history.uf_add_history("Delete",SqlSyntax)
	ElseIf SQLTYPE  = PreviewUpdate!		Then	
		dw_history.uf_add_history("Update",SqlSyntax)
	End if	
end event

event updatestart;// ---------------------------
// Reset History-Array
// ---------------------------
	destroy uo_history
	dw_history	= Create uo_history
end event

