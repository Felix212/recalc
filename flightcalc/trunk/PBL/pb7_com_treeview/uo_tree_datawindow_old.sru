HA$PBExportHeader$uo_tree_datawindow_old.sru
forward
global type uo_tree_datawindow_old from uo_parent_dw
end type
end forward

global type uo_tree_datawindow_old from uo_parent_dw
event ue_line ( )
event ue_paint pbm_paint
event ue_key pbm_dwnkey
event type integer ue_scroll_check ( )
event ue_multi_select_all ( )
event type integer ue_save ( )
event type integer ue_scroll_to_row ( long lrow )
end type
global uo_tree_datawindow_old uo_tree_datawindow_old

type variables
Public:

String	sGroupField, &
			sGroupFieldType, &
			sElapseValidation

Long 		lDetailHeight 		= 72, &
			lMarkerHeight 		= 80, &
			lMarkerWidth 		= 969, &
			lMarkerColor 		= 29360127, &
			lMultiMarkerColor = 32106985

Integer 	iOpen 				= 0
Integer  iDefaultScrollBar = 0
			

Private:

Long							lXOffset 			= 78, &
								lMarkerXPosHeader = 10000, &
								lMarkerXPosDetail = 10000
			
datawindow 					oDWObserver[]
integer 						iDWObserver

Integer						iMultiSelection 	= 0
Integer						iMultiEnabled 		= 1
			
uo_tree_verticalscroll	ioScroll

end variables

forward prototypes
public function integer of_add_dw_to_observer (datawindow odw)
public function integer of_check_observer_single (datawindow odw)
public function integer of_multiselection (long lrow)
public function integer of_multiselection_end ()
public function integer of_multiselection_start (long lrow)
public function integer of_multiselection_all ()
public function integer of_check_observer ()
public function integer of_elapse_all (integer ielapse, long lnewheight)
public function integer of_get_marker_position ()
public function integer of_group_count ()
public function integer of_show_marker (boolean bshow)
public function integer of_elapse_number (long lrow, integer ielapse, long lnewheight)
public function integer of_elapse_string (long lrow, integer ielapse, long lnewheight)
public function integer of_log_syntax (string sfile, string ssyntax)
public function integer of_init (vscrollbar oscroll)
public function integer of_set_marker (long lrow, string sband)
public function integer of_add_columns ()
public function integer of_add_dataobject (string sdataobject)
public function integer of_change_dataobject (string sdataobject)
public subroutine of_constructor ()
public subroutine of_modify ()
end prototypes

event ue_line();long 	lGroupHeaderHeight, &
		lNoOfGroupHeaders, &
		lFirstRow, &
		lLastRow, &
		lFirstHeader, &
		lLastHeader, &
		lPos,	&
		lX, &
		lY, &
		a


if this.RowCount() <= 0 then
	this.modify("l_disp.visible=0")
	this.SetPosition("l_disp", "background", false)
	return
else
	this.modify("l_disp.visible=1")
end if

// ----------------------------------
// An der Line (st_position) im 
// Header positionieren
// ----------------------------------

this.modify("l_disp.x1 = " + this.describe("l_position.x2"))
this.modify("l_disp.y1 = " + this.describe("datawindow.header.height"))
this.modify("l_disp.x2 = " + this.describe("l_position.x2"))

lY += long(this.describe("datawindow.header.height"))

// ----------------------------------
// Den Wert f$$HEX1$$fc00$$ENDHEX$$r y2 ausrechnen
//
// Alle Rows pr$$HEX1$$fc00$$ENDHEX$$fen, ob sie
// angezeigt (elapsed) sind
// ----------------------------------
lFirstRow = Long(this.describe("datawindow.firstrowonpage"))
lLastRow = Long(this.describe("datawindow.lastrowonpage"))

for a = lFirstRow to lLastRow
	
	if this.GetItemNumber(a, "elapse") = 1 then
		lY += lDetailHeight
	end if
	
next

// ----------------------------------
// Dann noch die Anzahl der 
// Groupheader die angezeigt sind
// dazurechnen
// ----------------------------------

lFirstHeader = this.GetItemNumber(lFirstRow, "group_no")
lLastHeader = this.GetItemNumber(lLastRow, "group_no")

lGroupHeaderHeight = Long(this.describe("datawindow.header.1.height"))
lNoOfGroupHeaders = lLastHeader - lFirstHeader
lY += (lNoOfGroupHeaders ) * lGroupHeaderHeight + 20


if lLastRow = this.RowCount()  then

	this.modify("l_disp.y2 = " + string(lY + 36))		
	this.SetPosition("l_disp", "background", false)

else
	
	this.modify("l_disp.y2 = " + string(20000))		
	this.SetPosition("l_disp", "background", false)

	
end if



end event

event ue_key;long 		lRow, &
			lCurrentGroup, &
			lFound, &
			lFirst

String sBand



lRow = This.GetRow()

if lRow <= 0 then return 1


Choose case Key 
	// ----------------------------------------------------------
	//	KEY DOWN ARROW 
	// ----------------------------------------------------------
		
	case KeyDownArrow!  
		// ----------------------------------------------------------
		// Wenn nix ausgew$$HEX1$$e400$$ENDHEX$$hlt ist oder wir bereits auf der
		// letzten Row stehen, dann mach auch nix 
		// ----------------------------------------------------------
		
		if lRow + 1 > this.RowCount() then
			return 1
		end if
			
		//OutputDebugStringA(this.ClassName() + " ScrollTow() " + String(lrow + 1) + "  ~r~n")
		
		
		// ----------------------------------------------------------
		// Wenn die n$$HEX1$$e400$$ENDHEX$$chste Row zur gleichen Gruppe geh$$HEX1$$f600$$ENDHEX$$rt und
		// diese sichtbar ist dann diese im Detailband markieren
		// ----------------------------------------------------------
		lCurrentGroup = This.GetItemNumber(lRow, "group_no")
		
		if lCurrentGroup = This.GetItemNumber(lRow + 1, "group_no") and &
			This.GetItemNumber(lRow + 1, "elapse") = 1 then

			if this.Trigger Event ue_scroll_to_row(lRow + 1) = 0 then
				Post of_set_marker(lRow + 1, "Detail")
			end if
			
			return 1
		else
			
			// ----------------------------------------------------------
			// Wenn die n$$HEX1$$e400$$ENDHEX$$chste Row nicht zur gleichen Gruppe geh$$HEX1$$f600$$ENDHEX$$rt 
			// dann diese im Detail oder Headerband markieren
			// ----------------------------------------------------------

			lFound = This.Find("group_no > " + String(lCurrentGroup), lRow, this.RowCount())
			
			if lFound > 0 then
				
				if this.GetItemNumber(lFound, "elapse") = 1 then
					sBand = "Detail"
				else
					sBand = "Header"
				end if
	
				if this.Trigger Event ue_scroll_to_row(lFound) = 0 then
					//this.ScrollToRow(lFound)
					Post of_set_marker(lFound, sBand)
				end if
				return 1
				
				
			end if
			
		end if
	
	// ----------------------------------------------------------
	//	KEY UP ARROW 
	// ----------------------------------------------------------
	Case KeyUpArrow! 
		
		// ----------------------------------------------------------
		// Wenn nix ausgew$$HEX1$$e400$$ENDHEX$$hlt ist oder wir bereits auf der
		// ersten Row stehen, dann mach auch nix 
		// ----------------------------------------------------------
		
		if lRow - 1 <= 0 then
			return 1
		end if



		// ----------------------------------------------------------
		// Wenn Row - 1 zur gleichen Gruppe geh$$HEX1$$f600$$ENDHEX$$rt und
		// diese sichtbar ist dann diese im Detailband markieren
		// ----------------------------------------------------------
		lCurrentGroup = This.GetItemNumber(lRow, "group_no")
		
		if This.GetItemNumber(lRow - 1, "elapse") = 1 then
			if this.Trigger Event ue_scroll_to_row(lRow - 1) = 0 then
				
				//OutputDebugStringA(this.ClassName() + " Previous Row is elapsed  ~r~n")
				
				Post of_set_marker(lRow - 1, "Detail")
			end if
			
			return 1
			
		else
			
			lFound = This.Find("group_no = " + String(lCurrentGroup - 1), 1, lRow)			
			
			if lFound > 0 then
				if this.Trigger Event ue_scroll_to_row(lFound) = 0 then
					
					//OutputDebugStringA(this.ClassName() + " Previous Row is not elapsed new group found at row " + + string() " ~r~n")

					Post of_set_marker(lFound, "Header")
				end if
			end if

			
		end if

end choose		


return 1
end event

event type integer ue_scroll_check();// -----------------------------------------
// Den Scrollbar positionieren
// -----------------------------------------

//if isNull(ioScroll) then
//	return 0
//end if
//
//
//if isvalid (ioScroll) then
//	
//	//Messagebox("", "Valid")
//	
//	if this.RowCount() = 0 then
//		ioScroll.Visible = False
//		///Messagebox("", "Unsichtbar")
//
//	else
//
//		if long(this.Describe("datawindow.LastRowOnPage")) = this.RowCount() and &
//			long(this.Describe("datawindow.FirstRowOnPage")) = 1 then
//			//Messagebox("", "False")
//			ioScroll.Visible = False
//		
//		else
//			
//			ioScroll.Visible = True
//			//Messagebox("", "True")
//			if this.GetRow() > 0 then
//				ioScroll.Position = This.GetItemNumber(this.GetRow() , "group_no")
//			end if
//					
//		end if
//		
//	end if
//
//end if

return 0
end event

event type integer ue_save();

return 0
end event

event type integer ue_scroll_to_row(long lrow);//
// ue_scroll_to_row
//
// Dieser Event wird im Window $$HEX1$$fc00$$ENDHEX$$berladen!
//

// -------------------------------------------------------
// Beispiel
// -------------------------------------------------------
//
// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob sich im Detail-Fenster was ge$$HEX1$$e400$$ENDHEX$$ndert hat
//
//if pb_save.enabled = true then
//	if not wf_save_question() then
//		//MessageBox("rowfocuschanging","Nicht wechseln, Du Depp!")
//		return 1
//	else
//		//MessageBox("rowfocuschanging","ok")
//		this.scrolltorow(lRow)
//		return 0
//	end if
//else
//	this.scrolltorow(lRow)
//	return 0
//end if

this.scrolltorow(lRow)
return 0

end event

public function integer of_add_dw_to_observer (datawindow odw);
iDWObServer ++

oDwObserver[iDWObServer] = odw

return 0
end function

public function integer of_check_observer_single (datawindow odw);long i

for i = 1 to Upperbound(oDwObserver)
		
	if oDwObserver[i] = oDw then
			
		if oDwObserver[i].ModifiedCount() + oDwObserver[i].DeletedCount() > 0 then
			
			return 1
			
		end if
		
	end if
	
next

return 0


end function

public function integer of_multiselection (long lrow);long a, iSelect

if iMultiEnabled <> 1 then
	return 0
end if

if lRow > 0 then
	
	if this.GetItemNumber(lRow, "multiselect") = 0 then
		iSelect = 1
	else
		iSelect = 0
	end if
		
	this.SetItem(lRow, "multiselect", iSelect)

end if

return 0

end function

public function integer of_multiselection_end ();long a

if iMultiEnabled <> 1 then
	return 0
end if


of_show_marker(true)

iMultiSelection = 0

for a = 1 to this.RowCount()
	this.SetItem(a, "multiselect", 0)
next


return 0

end function

public function integer of_multiselection_start (long lrow);long a

if iMultiEnabled <> 1 then
	return 0
end if


of_show_marker(false)

iMultiSelection = 1

for a = 1 to this.RowCount()
	this.SetItem(a, "multiselect", 0)
next


return 0

end function

public function integer of_multiselection_all ();long a

for a = 1 to this.RowCount()
	this.SetItem(a, "multiselect", 1)
next

this.Trigger Event ue_multi_select_all()

return 0

end function

public function integer of_check_observer ();long i

for i = 1 to Upperbound(oDwObserver)
	
	if oDwObserver[i].ModifiedCount() + oDwObserver[i].DeletedCount() > 0 then
		
		return 1
		
	end if
	
next

return 0


end function

public function integer of_elapse_all (integer ielapse, long lnewheight);Long a


This.Setredraw(false)

for a = 1 to this.RowCount()
	
	if this.GetItemNumber(a, "c_elapse_validation") = 1 then	
		this.SetDetailHeight(a, a, lNewHeight)  // 88
		this.SetItem(a, "elapse", ielapse)
		this.SetItemStatus(a, "elapse", Primary!, NotModified!)
	end if
	
Next

This.Trigger Event ue_line()
of_show_marker(false)	
This.Setredraw(True)

return 0
end function

public function integer of_get_marker_position ();//----------------------------------------------------
// Alle Objecte im DW analysieren
//----------------------------------------------------

integer 	i, &
			j, &
			iCount, &
			iPos
			
string 	sDWObjects, &
			sTemp, &
			sObjects[], &
			sBand, &
			sSyntax

long 		lInsert, &
			lXPOS
			

// ---------------------------------------
// Alle Objekte von DW_LAYOUT auslesen
// ---------------------------------------
 sDWObjects = this.describe("datawindow.objects")

// ---------------------------------------
// Den String zerhacken und alle Objekte
// ein Array schreiben
// ---------------------------------------

for i = 1 to LenA(sDWObjects)
	
	if MidA(sDWObjects, i, 1) <> CharA(9) then
		
		sTemp += MidA(sDWObjects, i, 1)
		
	else
				
		iCount ++
		sObjects[iCount] = sTemp
		sTemp = ""
		
	end if

next

if LenA(sTemp) > 0 then		
	iCount ++
	sObjects[iCount] = sTemp
end if

// ---------------------------------------
// Die Objekte nach Header und Detail Band
// trennen
// ---------------------------------------



for i = 1 to UpperBound(sObjects)
	
	sBand = this.Describe(sObjects[i] + ".band")
	lXPos = Long(this.Describe(sObjects[i] + ".x"))
	
	if sBand = "detail" then
			
		if lXPos < lMarkerXPosDetail then //and this.Describe(sObjects[i] + ".visible") = "1" then
			lMarkerXPosDetail = lXpos
		end if

	elseif sBand = "header.1" then
		
		if lXPos < lMarkerXPosHeader then //and this.Describe(sObjects[i] + ".visible") = "1" then
			lMarkerXPosHeader = lXpos
		end if
		
		
	end if
		
	
Next

lMarkerXPosDetail -= 8
lMarkerXPosHeader -= 8
//Messagebox("", "Header: " + string(lMarkerXPosHeader) + "~r~rDetail: " + string(lMarkerXPosDetail))

return 0
end function

public function integer of_group_count ();Long 	lCounter, &
		a, &
		lRows, &
		lGroupKey

String sGroupKey

lRows = this.RowCount()

if lRows = 0 then return 0


if sGroupFieldType = "number" then

	lCounter = 1
	lGroupKey = this.GetItemNumber(1, sGroupField)
	
	for a = 1 to lRows
		
		//Messagebox(string(lCounter) + "         ", this.GetItemNumber(a, "nflight_number"))
		
		if this.GetItemNumber(a, sGroupField) = lGroupKey then
			this.SetItem(a, "group_no", lCounter)
		else
			lCounter ++
			lGroupKey = this.GetItemNumber(a, sGroupField)
			this.SetItem(a, "group_no", lCounter)
		end if
		
		this.SetItemStatus(a, "group_no", Primary!, NotModified!)
						
	next

end if
	
if sGroupFieldType = "string" then

	lCounter = 1
	sGroupKey = this.GetItemString(1, sGroupField)
	
	for a = 1 to lRows
		
		if this.GetItemString(a, sGroupField) = sGroupKey then
			this.SetItem(a, "group_no", lCounter)
		else
			lCounter ++
			sGroupKey = this.GetItemString(a, sGroupField)
			this.SetItem(a, "group_no", lCounter)
		end if
		
		this.SetItemStatus(a, "group_no", Primary!, NotModified!)
						
	next

end if




return 0
end function

public function integer of_show_marker (boolean bshow);// -----------------------------------------
// Den Zeilenmarkierer ein-/ausblenden
// -----------------------------------------

if bShow = true then
	this.Modify("st_marker.visible = 1")
else
	this.Modify("st_marker.visible = 0")
end if

return 1
end function

public function integer of_elapse_number (long lrow, integer ielapse, long lnewheight);Long a
long lGroupVal
Long lFound, lGroupNo


lGroupVal = this.GetItemNumber(lRow, sGroupField)

lGroupNo  = this.GetItemNumber(lRow, "group_no")
lFound    = this.Find("group_no = " + String(lGroupNo), 1, lRow)

if lFound > 0 then
	
	lRow = lFound

	if this.GetItemNumber(lRow, "c_elapse_validation") = 1 then
	
		for a = lRow to this.RowCount()
			
			if this.GetItemNumber(a, sGroupField) = lGroupVal then
				
				this.SetDetailHeight(a, a, lNewHeight)  // 88
				this.SetItem(a, "elapse", ielapse)
				this.SetItemStatus(a, "elapse", Primary!, NotModified!)
				
	
			else
				exit
				
			end if
			
		Next
	
	end if

End if

//ioScroll.of_init(this)
This.Trigger Event ue_line()

return 0
end function

public function integer of_elapse_string (long lrow, integer ielapse, long lnewheight);Long a
String sGroupVal


Long lFound, lGroupNo


sGroupVal = this.GetItemString(lRow, sGroupField)

lGroupNo  = this.GetItemNumber(lRow, "group_no")
lFound    = this.Find("group_no = " + String(lGroupNo), 1, lRow)

if lFound > 0 then
	
	lRow = lFound

	if this.GetItemNumber(lRow, "c_elapse_validation") = 1 then
	
		for a = lRow to this.RowCount()
			
			if this.GetItemString(a, sGroupField) = sGroupVal then
				
				this.SetDetailHeight(a, a, lNewHeight)  // 88
				this.SetItem(a, "elapse", ielapse)
				this.SetItemStatus(a, "elapse", Primary!, NotModified!)
			else
				
				exit
				
			end if
			
			///Messagebox("", string(a) + " = " + this.GetItemString(a, sGroupField))
			
		Next
	
	end if
	
end if

//ioScroll.of_init(this)
This.Trigger Event ue_line()

return 0
end function

public function integer of_log_syntax (string sfile, string ssyntax);integer iFile

iFile = FileOpen(f_gettemppath() + sFile, LineMode!, Write!, Shared!)
FileWrite(iFile, sSyntax)
FileClose(iFile)


return 0
end function

public function integer of_init (vscrollbar oscroll);// ------------------------------------------------
// Den Scrollbar initialisieren 
// 
// Achtung: of_init nach retrieve aufrufen
// ------------------------------------------------

ioScroll = oScroll

if iDefaultScrollBar = 0 then
	ioScroll.of_init(this)
end if

return 0
end function

public function integer of_set_marker (long lrow, string sband);long 	lGroupHeaderHeight, &
		lNoOfGroupHeaders, &
		lFirstRow, &
		lFirstHeader, &
		lPos,	&
		lX, &
		lY, &
		a

if lRow <= 0 or this.RowCount() <= 0 or lRow > this.RowCount() then
	of_show_marker(false)
	return 0
end if

if not isvalid(ioScroll) then
	return 0
end if

if sBand = "" then
	
	if This.GetItemNumber(lRow, "elapse") = 0 then
		sBand = "Header"
	else
		sBand = "Detail"
	end if
	
end if

if sBand = "Detail" and This.GetItemNumber(lRow, "c_elapse_validation") = 0 then
	sBand = "Header"
end if

// ----------------------------------
// erstmal die Headerh$$HEX1$$f600$$ENDHEX$$he ermitteln
// ----------------------------------
lY += Long(this.describe("datawindow.header.height"))

// ----------------------------------
// dann alle Rows pr$$HEX1$$fc00$$ENDHEX$$fen, ob sie
// angezeigt (elapsed) sind
// ----------------------------------
lFirstRow = Long(this.describe("datawindow.firstrowonpage"))

//OutputDebugStringA(this.ClassName() + " FIRSTROW:  " + string(lFirstRow)  +  "~r~n")

for a = lFirstRow to lRow - 1
	
	//OutputDebugStringA(this.ClassName() + " " + String(a)  + "        " + string(lFirstRow)      +  "~r~n")
	
	if this.GetItemNumber(a, "elapse") = 1 then
		lY += lDetailHeight
	end if
	
next

// ----------------------------------
// Dann noch die Anzahl der 
// Groupheader die angezeigt sind
// dazurechnen 
// ----------------------------------

lFirstHeader = this.GetItemNumber(lFirstRow, "group_no")
lGroupHeaderHeight = Long(this.describe("datawindow.header.1.height"))
lNoOfGroupHeaders = this.GetItemNumber(lRow, "group_no") - lFirstHeader

lY += lNoOfGroupHeaders * lGroupHeaderHeight

// -----------------------------------------
// Den Zeilenmarkierer positionieren
// -----------------------------------------

this.Modify("st_marker.visible = 1")

if iDefaultScrollBar = 0 then

	ioScroll.of_set_position()
	
	if Long(This.Describe("datawindow.LastRowOnPage")) = This.RowCount() and &
		Long(This.Describe("datawindow.FirstRowOnPage")) = 1 					then
		
		ioScroll.Visible = False
	
	else
		
		ioScroll.Visible = True
	
	end if

end if

//OutputDebugStringA(this.ClassName() + " " + sBand + "        " + string(lrow)      +  "~r~n")

if sBand = "Header" then
	this.Modify("st_marker.y = " + string(lY + 8))
	this.Modify("st_marker.x = " + string(lMarkerXPosHeader))
	this.Modify("st_marker.height = " + string(lMarkerHeight))
else
	this.Modify("st_marker.y = " + string(lY + lGroupHeaderHeight + 4) )
	this.Modify("st_marker.x = " + string(lMarkerXPosDetail))
	this.Modify("st_marker.height = " + string(lDetailHeight - 8))
end if

this.Trigger Event ue_line()

return lY			
end function

public function integer of_add_columns ();string 	sSyntax, &
		 	sFind, &
		 	sAdd, &
		 	sNewSyntax, &
		 	sRet, &
			sSql, &
			sPart1, &
			sPart2, &
			sCreate


integer 	iLen, &
			iPos


// ----------------------------------------------------------
// Columns in die Table-Section des Datawindow Syntax 
// am Ende anf$$HEX1$$fc00$$ENDHEX$$gen
// ----------------------------------------------------------
sSyntax = this.describe("datawindow.syntax")

//of_log_syntax("old.txt", sSyntax)

sAdd = "column=(type=number updatewhereclause=yes name=elapse dbname='elapse' )~r~n" 
sAdd += "column=(type=number updatewhereclause=yes name=group_no dbname='group_no' )~r~n"
sAdd += "column=(type=number updatewhereclause=yes name=multiselect dbname='multiselect' )~r~n"

sFind = "retrieve"
iLen = LenA(sFind)
iPos = PosA(sSyntax, sFind)

if iPos > 0 then

	sNewSyntax = MidA(sSyntax, 1, iPos - 1) + sAdd + MidA(sSyntax,iPos)
	this.create(sNewSyntax)
	//of_log_syntax("new1.txt", sNewSyntax)	
else
	
	uf.mBox("Hallo Entwickler", "Das Einf$$HEX1$$fc00$$ENDHEX$$gen der Computed Columns hat nicht funktioniert!")	
	
end if



//this.SettransObject(sqlca)

//Messagebox("", "sRet: ~r~r" + sRet + "~r~rNewSyntax~r~r" + sNewSyntax) 

// ----------------------------------------------------------
// SQL-Select im DW-Syntax um die beiden Spalten erweitern
// ----------------------------------------------------------

this.Settransobject(sqlca)
sSyntax = this.GetSqlSelect()
//of_log_syntax("SyntaxAfterAdded.txt", sSyntax)

iPos = PosA(sSyntax, "FROM")

if iPos > 0 then
	
	sPart1 = MidA(sSyntax, 1, iPos - 1) + ", " + string(iOpen) + " elapse, 0 group_no , 0 multiselect "
	sPart2 = MidA(sSyntax, iPos )
	sSql = sPart1 + sPart2
	this.Modify("DataWindow.Table.Select='" + sSQL + "'")

	//of_log_syntax("SyntaxAfterModified.txt", sSQL)
	
	sCreate = this.describe("datawindow.syntax")
		
	//Messagebox("", "sSQL: ~r~r" + sSQL + "~r~rsCreate~r~r" + sCreate) 
		
	this.create(sCreate)
	
else
	
	uf.mBox("Hallo Entwickler", "Das Einf$$HEX1$$fc00$$ENDHEX$$gen der Computed Columns hat nicht funktioniert!")
	
end if


return 0
end function

public function integer of_add_dataobject (string sdataobject);//
// of_add_dataobject
//
// DataObject setzen
//

this.DataObject = sDataObject

of_constructor()


return 0

end function

public function integer of_change_dataobject (string sdataobject);//
// of_add_dataobject
//
// DataObject setzen
//

this.DataObject = sDataObject

of_modify()


return 0

end function

public subroutine of_constructor ();/* ------------------------------------------------------------------------------
/  Folgende Objekte werden im Datawindow Object erwartet:
/ -------------------------------------------------------------------------------
/	Linie: 		l_position		Eine vertikale Linie im Header, die
/										so genau wie m$$HEX1$$f600$$ENDHEX$$glich mit dem Ende des
/										Headerbands abschliesst.
/										Sie wird ben$$HEX1$$f600$$ENDHEX$$tigt um eine Startposition f$$HEX1$$fc00$$ENDHEX$$r
/										Linie zu erhalten, die das fehlende Pixel
/										zwischen GroupHeader und Detailband $$HEX1$$fc00$$ENDHEX$$berzeichnet.
/										Desweiteren wird die x1 Eigenschaft als 
/										X-Offset f$$HEX1$$fc00$$ENDHEX$$r die Positionierung der restlichen 
/										Linien verwendet.
/
/	Bitmaps:		p_plus			..\Resource\plus.bmp
/					p_minus			..\Resource\minus.bmp
/					p_open			..\Resource\folder_open.bmp
/					p_closed			..\Resource\folder_closed.bmp
/					p_detail			beliebig
/
/ -------------------------------------------------------------------------------
/	Instanz Variablen:
/ -------------------------------------------------------------------------------
/	String		sGroupField			Feld mit dem im Datawindow gruppiert ist
/					sGroupFieldType	Werte: string, number
/					sElapseValidation ValidationRule f$$HEX1$$fc00$$ENDHEX$$r das Anzeigen der Child Rows
/
/	Long	 		lDetailHeight 		H$$HEX1$$f600$$ENDHEX$$he der Detailbands wenn sichtbar
/					lMarkerHeight 		H$$HEX1$$f600$$ENDHEX$$he der Zeilenmarkierung im Header
/					lMarkerWidth 		Breite der Zeilenmarkierung
/					lMarkerColor 		Farbe der Zeilenmarkierung
/			
/	Integer 		iOpen 				Detailband beim Start sichtbar (1)
/											oder unsichtbar (0)
/
/
/ ----------------------------------------------------------------------------*/

Long 		lGroupHeaderHeight, &
			lWidth, &
			lHeight

String	sOut

// -----------------------------------------------------------------------------
// Computed Columns hinzuf$$HEX1$$fc00$$ENDHEX$$gen
// -----------------------------------------------------------------------------
of_add_columns()

// -----------------------------------------------------------------------------
// Die Positionen f$$HEX1$$fc00$$ENDHEX$$r die Zeilenmarkierung herausfinden
// -----------------------------------------------------------------------------
of_get_marker_position()

lGroupHeaderHeight = long(this.Describe("datawindow.header.1.Height"))

if iDefaultScrollBar = 0 then
	this.vscrollbar = False
else
	this.vscrollbar = True
end if

// -----------------------------------------------------------------------------
// Instanz - Variablen pr$$HEX1$$fc00$$ENDHEX$$fen
// -----------------------------------------------------------------------------
if iOpen = 0 then
	this.Modify("datawindow.detail.height=0")
elseif iOpen = 1 then	
	this.Modify("datawindow.detail.height=" + string(lDetailHeight) )
else
	uf.mbox("Hallo Entwickler", "Ung$$HEX1$$fc00$$ENDHEX$$ltiger Wert f$$HEX1$$fc00$$ENDHEX$$r iOpen !!!~r~r~r G$$HEX1$$fc00$$ENDHEX$$ltige Werte: 0 = zu, 1 = auf")
end if

if sGroupField = "" then
	uf.mbox("Hallo Entwickler", "Wert f$$HEX1$$fc00$$ENDHEX$$r sGroupField setzen !!!")
end if

if sGroupFieldType = "" then
	uf.mbox("Hallo Entwickler", "Wert f$$HEX1$$fc00$$ENDHEX$$r sGroupFieldType setzen !!!")
end if

if sGroupFieldType <> "string" and sGroupFieldType <> "number" then
	uf.mbox("Hallo Entwickler", "G$$HEX1$$fc00$$ENDHEX$$ltigen Wert f$$HEX1$$fc00$$ENDHEX$$r sGroupFieldType setzen !!!~r~r~r G$$HEX1$$fc00$$ENDHEX$$ltige Werte: string oder number")
end if

if isnull(sElapseValidation) or Trim(sElapseValidation) = "" then
	sElapseValidation = ""
end if

// -----------------------------------------------------------------------------
// l_position pr$$HEX1$$fc00$$ENDHEX$$fen und X-Offset ermitteln
// -----------------------------------------------------------------------------
if this.describe("l_position.x1") = "!" then
	uf.mbox("Hallo Entwickler", "l_position im Header fehlt !!!")
else
	lXOffSet = Long(this.describe("l_position.x1"))
end if

// -----------------------------------------------------------------------------
// Die Zeilenmarker zeichnen
// -----------------------------------------------------------------------------
this.Modify("create text(band=background alignment='0' text='' border='0' color='0' x='503' y='44' height='" + string(lMarkerHeight) + "' width='" + string(lMarkerWidth) + "'  name=st_marker visible='0~t0'  font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='" + string(lMarkerColor) + "' )")
this.Modify("create text(band=detail alignment='0' text='' border='0' color='0' x='" + string(lMarkerXPosDetail) + "' y='0' height='" + string(lMarkerHeight) + "' width='" + string(lMarkerWidth) + "'  name=st_multimarker visible='1~tif ( multiselect = 1, 1, 0)'  font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='" + string(lMultiMarkerColor) + "' )")
this.SetPosition("st_multimarker", "detail", False)
//text(band=detail alignment="0" text="" border="0" color="0" x="78" y="192" height="76" width="795"  name=st_multimarker visible="1~tif ( multiselect = 1, 1, 0)"  font.face="Arial" font.height="-12" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="32106985" )
 
// -----------------------------------------------------------------------------
// Die Linen, die das fehlende Pixel zwischen Header und Detailband, $$HEX1$$fc00$$ENDHEX$$berzeichnet
// -----------------------------------------------------------------------------
this.Modify("create line(band=background x1='1806' y1='24' x2='1806' y2='140'  name=l_disp pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215' )")

// -----------------------------------------------------------------------------
// Ein Paar Computed Fields, f$$HEX1$$fc00$$ENDHEX$$r die Linen (damit die wissen wie lang sie sind =:-))
// -----------------------------------------------------------------------------
this.Modify("create compute(band=detail alignment='0' expression='GetRow()'border='0' color='0' x='805' y='144' height='76' width='256' format='[General]'  name=cf_row visible='0'  font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='29360127' )")
this.Modify("create compute(band=detail alignment='0' expression='max(cf_row for group 1)'border='0' color='0' x='809' y='244' height='76' width='256' format='[GENERAL]'  name=cf_last visible='0' font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='29360127' )")
this.Modify("create compute(band=detail alignment='0' expression='if(getrow() = cf_last, 1, 0)'border='0' color='0' x='809' y='344' height='76' width='256' format='[GENERAL]'  name=cf_last_ident visible='0' font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='29360127' )")
this.Modify("create compute(band=header.1 alignment='0' expression='count(" + sGroupField + " for group 1)' border='0' color='0' x='453' y='200' height='76' width='256' format='[GENERAL]'  name=c_count visible='0' font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )")
this.Modify("create compute(band=header alignment='0' expression='PageCount()' border='0' color='0' x='4' y='4' height='76' width='1000' format='[GENERAL]'  name=c_pagecounter visible='0' font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )")
this.Modify("create compute(band=detail alignment='0' expression='Page()' border='0' color='0' x='4' y='4' height='76' width='100' format='[GENERAL]'  name=c_on_page visible='0' font.face='Arial' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )")
this.Modify("create compute(band=header alignment='0' expression='sum(elapse for all)' border='0' color='0' x='4' y='4' height='76' width='1000' format='[GENERAL]'  name=c_sum_elapse visible='0' font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )")


if sElapseValidation <> "" then
	this.Modify("create compute(band=detail alignment='0' expression='if(" + sElapseValidation + " , 1, 0)' border='0' color='0' x='1902' y='16' height='52' width='183' format='[GENERAL]'  name=c_elapse_validation visible='1'  font.face='MS Sans Serif' font.height='-8' font.weight='400' font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='536870912' )")
else
	this.Modify("create compute(band=detail alignment='0' expression='if( 1 = 1 , 1, 0)' border='0' color='0' x='1902' y='16' height='52' width='183' format='[GENERAL]'  name=c_elapse_validation visible='1'  font.face='MS Sans Serif' font.height='-8' font.weight='400' font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='536870912' )")	
end if
//this.Modify("create compute(band=header alignment='0' expression='sum(elapse for all)'border='0' color='0' x='32' y='100' height='76' width='256' format='[GENERAL]'  name=c_open_items  font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )")

// -----------------------------------------------------------------------------
// Horizontale Linie im Header Band
// -----------------------------------------------------------------------------

//this.Modify("create line(band=header.1 x1='" + String(lXOffset) + "' y1='40' x2='" + String(lXOffset + 68)+ "' y2='40'  name=l_hor1_header pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215' )")
this.Modify("create line(band=header.1 x1='" + String(lXOffset) + "' y1='" + String(lGroupHeaderHeight / 2) + "' x2='" + String(lXOffset + 68)+ "' y2='" + String(lGroupHeaderHeight / 2) + "'  name=l_hor1_header pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215' )")
this.SetPosition("l_hor1_header", "header.1", False)
// -----------------------------------------------------------------------------
// Vertikale Linie im Header Band
// -----------------------------------------------------------------------------
this.Modify("create line(band=header.1 x1='" + String(lXOffset) + "' y1='0' x2='" + String(lXOffset) + "' y2='116~tif( max(group_no for group 1) = group_no, 44, 120)'  name=l_vert1_header pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215' )")
this.SetPosition("l_vert1_header", "header.1", False)

// -----------------------------------------------------------------------------
// Horizontale Linien im Detail Band
// -----------------------------------------------------------------------------
this.Modify("create line(band=detail x1='" + String(lXOffset) + "' y1='40' x2='" + String(lXOffset + 80) + "' y2='40'  name=l_hor1_detail visible='1~tIf(GetRow() = RowCount(), 1,0)' pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215' )")
this.Modify("create line(band=detail x1='" + String(lXOffset + 80) + "' y1='40' x2='" + String(lXOffset + 150 ) + "' y2='40'  name=l_hor2_detail pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215' )")
this.SetPosition("l_hor1_detail", "detail", False)
this.SetPosition("l_hor2_detail", "detail", False)
// -----------------------------------------------------------------------------
// Vertikale Linien im Detail Band
// -----------------------------------------------------------------------------
this.Modify("create line(band=detail x1='" + String(lXOffset + 80 ) + "' y1='0' x2='" + String(lXOffset + 80) + "' y2='160~tif(cf_last_ident = 0 ,1000, 44)'  name=l_vert2_detail pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215' )")
this.Modify("create line(band=detail x1='" + String(lXOffset) + "' y1='0' x2='" + String(lXOffset) + "' y2='112~tif (GetRow() = RowCount(),  44, 1000)'  name=l_vert1_detail pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215'") 
this.SetPosition("l_vert1_detail", "detail", False)
this.SetPosition("l_vert2_detail", "detail", False)

// -----------------------------------------------------------------------------
//
// Bilder positionieren
//
// -----------------------------------------------------------------------------
// p_minus pr$$HEX1$$fc00$$ENDHEX$$fen
// -----------------------------------------------------------------------------
if this.describe("p_minus.x") = "!" then
	uf.mbox("Hallo Entwickler", "p_minus im Groupheader fehlt !!!")
else
	lWidth = Long(this.describe("p_minus.width"))
	lHeight = Long(this.describe("p_minus.height"))
	this.Modify("p_minus.x=" + String(lXOffSet - (lWidth / 2)))
	this.Modify("p_minus.y=" + String((lGroupHeaderHeight / 2) - (lHeight / 2)))
//	this.Modify("p_minus.visible='1~tif(elapse = 1, 1, 0)'")
	this.Modify("p_minus.visible='1~tif(c_elapse_validation = 0, 0, if(elapse = 1, 1, 0))'")
	this.SetPosition("p_minus", "header.1", true)
end if

// -----------------------------------------------------------------------------
// p_plus pr$$HEX1$$fc00$$ENDHEX$$fen
// -----------------------------------------------------------------------------
if this.describe("p_plus.x") = "!" then
	uf.mbox("Hallo Entwickler", "p_plus im Groupheader fehlt !!!")
else
	lWidth = Long(this.describe("p_plus.width"))
	lHeight = Long(this.describe("p_plus.height"))
	this.Modify("p_plus.x=" + String(lXOffSet - (lWidth / 2)))
	this.Modify("p_plus.y=" + String((lGroupHeaderHeight / 2) - (lHeight / 2)))
//	this.Modify("p_plus.visible='1~tif (c_count >= 1 and elapse = 1, 0, 1)'")
	this.Modify("p_plus.visible='1~tif (c_elapse_validation = 0, 0, if(c_count >= 1 and elapse = 1, 0, 1))'")
	this.SetPosition("p_plus", "header.1", true)
end if

// -----------------------------------------------------------------------------
// p_open pr$$HEX1$$fc00$$ENDHEX$$fen
// -----------------------------------------------------------------------------
if this.describe("p_open.x") = "!" then
	uf.mbox("Hallo Entwickler", "p_open im Groupheader fehlt !!!")
else
	lWidth = Long(this.describe("p_open.width"))
	lHeight = Long(this.describe("p_open.height"))
	this.Modify("p_open.x=" + String(lXOffSet + 40 ))
	this.Modify("p_open.y=" + String((lGroupHeaderHeight / 2) - (lHeight / 2)))
	this.Modify("p_open.visible='1~tif(elapse = 0 , 0, 1)'")
	this.SetPosition("p_open", "header.1", true)
end if

// -----------------------------------------------------------------------------
// p_closed pr$$HEX1$$fc00$$ENDHEX$$fen
// -----------------------------------------------------------------------------
if this.describe("p_closed.x") = "!" then
	uf.mbox("Hallo Entwickler", "p_closed im Groupheader fehlt !!!")
else
	lWidth = Long(this.describe("p_closed.width"))
	lHeight = Long(this.describe("p_closed.height"))
	this.Modify("p_closed.x=" + String(lXOffSet + 40 ))
	this.Modify("p_closed.y=" + String((lGroupHeaderHeight / 2) - (lHeight / 2)))
	this.Modify("p_closed.visible='1~tif(elapse = 0 , 1, 0)'")
	this.SetPosition("p_closed", "header.1", true)
end if

// -----------------------------------------------------------------------------
// p_detail pr$$HEX1$$fc00$$ENDHEX$$fen
// -----------------------------------------------------------------------------
if this.describe("p_detail.x") = "!" then
	uf.mbox("Hallo Entwickler", "p_detail im Detailband fehlt !!!")
else
	lWidth = Long(this.describe("p_detail.width"))
	lHeight = Long(this.describe("p_detail.height"))
	this.Modify("p_detail.x=" + String((lXOffSet + 80) + 60 ))
	this.Modify("p_detail.y=" + String((lDetailHeight / 2) - (lHeight / 2)))
	this.SetPosition("p_detail", "detail", False)
end if

//of_log_syntax("finished.txt",  this.describe("datawindow.syntax"))

end subroutine

public subroutine of_modify ();/* ------------------------------------------------------------------------------
/  Folgende Objekte werden im Datawindow Object erwartet:
/ -------------------------------------------------------------------------------
/	Linie: 		l_position		Eine vertikale Linie im Header, die
/										so genau wie m$$HEX1$$f600$$ENDHEX$$glich mit dem Ende des
/										Headerbands abschliesst.
/										Sie wird ben$$HEX1$$f600$$ENDHEX$$tigt um eine Startposition f$$HEX1$$fc00$$ENDHEX$$r
/										Linie zu erhalten, die das fehlende Pixel
/										zwischen GroupHeader und Detailband $$HEX1$$fc00$$ENDHEX$$berzeichnet.
/										Desweiteren wird die x1 Eigenschaft als 
/										X-Offset f$$HEX1$$fc00$$ENDHEX$$r die Positionierung der restlichen 
/										Linien verwendet.
/
/	Bitmaps:		p_plus			..\Resource\plus.bmp
/					p_minus			..\Resource\minus.bmp
/					p_open			..\Resource\folder_open.bmp
/					p_closed			..\Resource\folder_closed.bmp
/					p_detail			beliebig
/
/ -------------------------------------------------------------------------------
/	Instanz Variablen:
/ -------------------------------------------------------------------------------
/	String		sGroupField			Feld mit dem im Datawindow gruppiert ist
/					sGroupFieldType	Werte: string, number
/					sElapseValidation ValidationRule f$$HEX1$$fc00$$ENDHEX$$r das Anzeigen der Child Rows
/
/	Long	 		lDetailHeight 		H$$HEX1$$f600$$ENDHEX$$he der Detailbands wenn sichtbar
/					lMarkerHeight 		H$$HEX1$$f600$$ENDHEX$$he der Zeilenmarkierung im Header
/					lMarkerWidth 		Breite der Zeilenmarkierung
/					lMarkerColor 		Farbe der Zeilenmarkierung
/			
/	Integer 		iOpen 				Detailband beim Start sichtbar (1)
/											oder unsichtbar (0)
/
/
/ ----------------------------------------------------------------------------*/

Long 	lGroupHeaderHeight, &
		lWidth, &
		lHeight
		

// -----------------------------------------------------------------------------
// Computed Columns hinzuf$$HEX1$$fc00$$ENDHEX$$gen
// -----------------------------------------------------------------------------
of_add_columns()

// -----------------------------------------------------------------------------
// Die Positionen f$$HEX1$$fc00$$ENDHEX$$r die Zeilenmarkierung herausfinden
// -----------------------------------------------------------------------------
// of_get_marker_position()

lGroupHeaderHeight = long(this.Describe("datawindow.header.1.Height"))
this.vscrollbar = False

// -----------------------------------------------------------------------------
// Instanz - Variablen pr$$HEX1$$fc00$$ENDHEX$$fen
// -----------------------------------------------------------------------------
if iOpen = 0 then
	this.Modify("datawindow.detail.height=0")
elseif iOpen = 1 then	
	this.Modify("datawindow.detail.height=" + string(lDetailHeight) )
else
	uf.mbox("Hallo Entwickler", "Ung$$HEX1$$fc00$$ENDHEX$$ltiger Wert f$$HEX1$$fc00$$ENDHEX$$r iOpen !!!~r~r~r G$$HEX1$$fc00$$ENDHEX$$ltige Werte: 0 = zu, 1 = auf")
end if

if sGroupField = "" then
	uf.mbox("Hallo Entwickler", "Wert f$$HEX1$$fc00$$ENDHEX$$r sGroupField setzen !!!")
end if

if sGroupFieldType = "" then
	uf.mbox("Hallo Entwickler", "Wert f$$HEX1$$fc00$$ENDHEX$$r sGroupFieldType setzen !!!")
end if

if sGroupFieldType <> "string" and sGroupFieldType <> "number" then
	uf.mbox("Hallo Entwickler", "G$$HEX1$$fc00$$ENDHEX$$ltigen Wert f$$HEX1$$fc00$$ENDHEX$$r sGroupFieldType setzen !!!~r~r~r G$$HEX1$$fc00$$ENDHEX$$ltige Werte: string oder number")
end if

if isnull(sElapseValidation) or Trim(sElapseValidation) = "" then
	sElapseValidation = ""
end if

// -----------------------------------------------------------------------------
// l_position pr$$HEX1$$fc00$$ENDHEX$$fen und X-Offset ermitteln
// -----------------------------------------------------------------------------
if this.describe("l_position.x1") = "!" then
	uf.mbox("Hallo Entwickler", "l_position im Header fehlt !!!")
else
	lXOffSet = Long(this.describe("l_position.x1"))
end if

// -----------------------------------------------------------------------------
// Die Zeilenmarker zeichnen
// -----------------------------------------------------------------------------
this.Modify("create text(band=background alignment='0' text='' border='0' color='0' x='503' y='44' height='" + string(lMarkerHeight) + "' width='" + string(lMarkerWidth) + "'  name=st_marker visible='0~t0'  font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='" + string(lMarkerColor) + "' )")
this.Modify("create text(band=detail alignment='0' text='' border='0' color='0' x='" + string(lMarkerXPosDetail) + "' y='0' height='" + string(lMarkerHeight) + "' width='" + string(lMarkerWidth) + "'  name=st_multimarker visible='1~tif ( multiselect = 1, 1, 0)'  font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='" + string(lMultiMarkerColor) + "' )")
this.SetPosition("st_multimarker", "detail", False)
//text(band=detail alignment="0" text="" border="0" color="0" x="78" y="192" height="76" width="795"  name=st_multimarker visible="1~tif ( multiselect = 1, 1, 0)"  font.face="Arial" font.height="-12" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="32106985" )

// -----------------------------------------------------------------------------
// Die Linen, die das fehlende Pixel zwischen Header und Detailband, $$HEX1$$fc00$$ENDHEX$$berzeichnet
// -----------------------------------------------------------------------------
this.Modify("create line(band=background x1='1806' y1='24' x2='1806' y2='140'  name=l_disp pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215' )")

// -----------------------------------------------------------------------------
// Ein Paar Computed Fields, f$$HEX1$$fc00$$ENDHEX$$r die Linen (damit die wissen wie lang sie sind =:-))
// -----------------------------------------------------------------------------
this.Modify("create compute(band=detail alignment='0' expression='GetRow()'border='0' color='0' x='805' y='144' height='76' width='256' format='[General]'  name=cf_row visible='0'  font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='29360127' )")
this.Modify("create compute(band=detail alignment='0' expression='max(cf_row for group 1)'border='0' color='0' x='809' y='244' height='76' width='256' format='[GENERAL]'  name=cf_last visible='0' font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='29360127' )")
this.Modify("create compute(band=detail alignment='0' expression='if(getrow() = cf_last, 1, 0)'border='0' color='0' x='809' y='344' height='76' width='256' format='[GENERAL]'  name=cf_last_ident visible='0' font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='29360127' )")
this.Modify("create compute(band=header.1 alignment='0' expression='count(" + sGroupField + " for group 1)' border='0' color='0' x='453' y='200' height='76' width='256' format='[GENERAL]'  name=c_count visible='0' font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )")
this.Modify("create compute(band=header alignment='0' expression='PageCount()' border='0' color='0' x='4' y='4' height='76' width='1000' format='[GENERAL]'  name=c_pagecounter visible='0' font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )")
this.Modify("create compute(band=detail alignment='0' expression='Page()' border='0' color='0' x='4' y='4' height='76' width='100' format='[GENERAL]'  name=c_on_page visible='0' font.face='Arial' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )")
this.Modify("create compute(band=header alignment='0' expression='sum(elapse for all)' border='0' color='0' x='4' y='4' height='76' width='1000' format='[GENERAL]'  name=c_sum_elapse visible='0' font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )")


if sElapseValidation <> "" then
	this.Modify("create compute(band=detail alignment='0' expression='if(" + sElapseValidation + " , 1, 0)' border='0' color='0' x='1902' y='16' height='52' width='183' format='[GENERAL]'  name=c_elapse_validation visible='1'  font.face='MS Sans Serif' font.height='-8' font.weight='400' font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='536870912' )")
else
	this.Modify("create compute(band=detail alignment='0' expression='if( 1 = 1 , 1, 0)' border='0' color='0' x='1902' y='16' height='52' width='183' format='[GENERAL]'  name=c_elapse_validation visible='1'  font.face='MS Sans Serif' font.height='-8' font.weight='400' font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='536870912' )")	
end if
//this.Modify("create compute(band=header alignment='0' expression='sum(elapse for all)'border='0' color='0' x='32' y='100' height='76' width='256' format='[GENERAL]'  name=c_open_items  font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )")

// -----------------------------------------------------------------------------
// Horizontale Linie im Header Band
// -----------------------------------------------------------------------------

//this.Modify("create line(band=header.1 x1='" + String(lXOffset) + "' y1='40' x2='" + String(lXOffset + 68)+ "' y2='40'  name=l_hor1_header pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215' )")
this.Modify("create line(band=header.1 x1='" + String(lXOffset) + "' y1='" + String(lGroupHeaderHeight / 2) + "' x2='" + String(lXOffset + 68)+ "' y2='" + String(lGroupHeaderHeight / 2) + "'  name=l_hor1_header pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215' )")
this.SetPosition("l_hor1_header", "header.1", False)
// -----------------------------------------------------------------------------
// Vertikale Linie im Header Band
// -----------------------------------------------------------------------------
this.Modify("create line(band=header.1 x1='" + String(lXOffset) + "' y1='0' x2='" + String(lXOffset) + "' y2='116~tif( max(group_no for group 1) = group_no, 44, 120)'  name=l_vert1_header pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215' )")
this.SetPosition("l_vert1_header", "header.1", False)

// -----------------------------------------------------------------------------
// Horizontale Linien im Detail Band
// -----------------------------------------------------------------------------
this.Modify("create line(band=detail x1='" + String(lXOffset) + "' y1='40' x2='" + String(lXOffset + 80) + "' y2='40'  name=l_hor1_detail visible='1~tIf(GetRow() = RowCount(), 1,0)' pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215' )")
this.Modify("create line(band=detail x1='" + String(lXOffset + 80) + "' y1='40' x2='" + String(lXOffset + 150 ) + "' y2='40'  name=l_hor2_detail pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215' )")
this.SetPosition("l_hor1_detail", "detail", False)
this.SetPosition("l_hor2_detail", "detail", False)
// -----------------------------------------------------------------------------
// Vertikale Linien im Detail Band
// -----------------------------------------------------------------------------
this.Modify("create line(band=detail x1='" + String(lXOffset + 80 ) + "' y1='0' x2='" + String(lXOffset + 80) + "' y2='160~tif(cf_last_ident = 0 ,1000, 44)'  name=l_vert2_detail pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215' )")
this.Modify("create line(band=detail x1='" + String(lXOffset) + "' y1='0' x2='" + String(lXOffset) + "' y2='112~tif (GetRow() = RowCount(),  44, 1000)'  name=l_vert1_detail pen.style='0' pen.width='5' pen.color='10789024'  background.mode='2' background.color='16777215'") 
this.SetPosition("l_vert1_detail", "detail", False)
this.SetPosition("l_vert2_detail", "detail", False)

// -----------------------------------------------------------------------------
//
// Bilder positionieren
//
// -----------------------------------------------------------------------------
// p_minus pr$$HEX1$$fc00$$ENDHEX$$fen
// -----------------------------------------------------------------------------
if this.describe("p_minus.x") = "!" then
	uf.mbox("Hallo Entwickler", "p_minus im Groupheader fehlt !!!")
else
	lWidth = Long(this.describe("p_minus.width"))
	lHeight = Long(this.describe("p_minus.height"))
	this.Modify("p_minus.x=" + String(lXOffSet - (lWidth / 2)))
	this.Modify("p_minus.y=" + String((lGroupHeaderHeight / 2) - (lHeight / 2)))
//	this.Modify("p_minus.visible='1~tif(elapse = 1, 1, 0)'")
	this.Modify("p_minus.visible='1~tif(c_elapse_validation = 0, 0, if(elapse = 1, 1, 0))'")
	this.SetPosition("p_minus", "header.1", true)
end if

// -----------------------------------------------------------------------------
// p_plus pr$$HEX1$$fc00$$ENDHEX$$fen
// -----------------------------------------------------------------------------
if this.describe("p_plus.x") = "!" then
	uf.mbox("Hallo Entwickler", "p_plus im Groupheader fehlt !!!")
else
	lWidth = Long(this.describe("p_plus.width"))
	lHeight = Long(this.describe("p_plus.height"))
	this.Modify("p_plus.x=" + String(lXOffSet - (lWidth / 2)))
	this.Modify("p_plus.y=" + String((lGroupHeaderHeight / 2) - (lHeight / 2)))
//	this.Modify("p_plus.visible='1~tif (c_count >= 1 and elapse = 1, 0, 1)'")
	this.Modify("p_plus.visible='1~tif (c_elapse_validation = 0, 0, if(c_count >= 1 and elapse = 1, 0, 1))'")
	this.SetPosition("p_plus", "header.1", true)
end if

// -----------------------------------------------------------------------------
// p_open pr$$HEX1$$fc00$$ENDHEX$$fen
// -----------------------------------------------------------------------------
if this.describe("p_open.x") = "!" then
	uf.mbox("Hallo Entwickler", "p_open im Groupheader fehlt !!!")
else
	lWidth = Long(this.describe("p_open.width"))
	lHeight = Long(this.describe("p_open.height"))
	this.Modify("p_open.x=" + String(lXOffSet + 40 ))
	this.Modify("p_open.y=" + String((lGroupHeaderHeight / 2) - (lHeight / 2)))
	this.Modify("p_open.visible='1~tif(elapse = 0 , 0, 1)'")
	this.SetPosition("p_open", "header.1", true)
end if

// -----------------------------------------------------------------------------
// p_closed pr$$HEX1$$fc00$$ENDHEX$$fen
// -----------------------------------------------------------------------------
if this.describe("p_closed.x") = "!" then
	uf.mbox("Hallo Entwickler", "p_closed im Groupheader fehlt !!!")
else
	lWidth = Long(this.describe("p_closed.width"))
	lHeight = Long(this.describe("p_closed.height"))
	this.Modify("p_closed.x=" + String(lXOffSet + 40 ))
	this.Modify("p_closed.y=" + String((lGroupHeaderHeight / 2) - (lHeight / 2)))
	this.Modify("p_closed.visible='1~tif(elapse = 0 , 1, 0)'")
	this.SetPosition("p_closed", "header.1", true)
end if

// -----------------------------------------------------------------------------
// p_detail pr$$HEX1$$fc00$$ENDHEX$$fen
// -----------------------------------------------------------------------------
if this.describe("p_detail.x") = "!" then
	uf.mbox("Hallo Entwickler", "p_detail im Detailband fehlt !!!")
else
	lWidth = Long(this.describe("p_detail.width"))
	lHeight = Long(this.describe("p_detail.height"))
	this.Modify("p_detail.x=" + String((lXOffSet + 80) + 60 ))
	this.Modify("p_detail.y=" + String((lDetailHeight / 2) - (lHeight / 2)))
	this.SetPosition("p_detail", "detail", False)
end if

//of_log_syntax("finished.txt",  this.describe("datawindow.syntax"))

end subroutine

on uo_tree_datawindow_old.create
call super::create
end on

on uo_tree_datawindow_old.destroy
call super::destroy
end on

event retrieveend;// -------------------------------------------------------
// Dem Datawindow mu$$HEX2$$df002000$$ENDHEX$$eine Computed-Column mit der
// Bezeichnung "group_no" hizugef$$HEX1$$fc00$$ENDHEX$$gt werden, desweitere
// mu$$HEX2$$df002000$$ENDHEX$$der Code entsprechend der Gruppierung im DW
// angepasst werden
// -------------------------------------------------------

Long 	a, &
		lRows, &
		lGroupKey
	
integer iCounter

string	sGroupKey

lRows = this.rowcount()

if lRows <= 0 then
	of_show_marker(false)
	This.Trigger Event ue_line()
	this.Trigger Event ue_scroll_check()
	this.SetRedraw(true)
	return
end if

SetPointer(HourGlass!)

// -----------------------------------------
// Die vertikale Line durchzeichnen
// -----------------------------------------
if this.rowcount() > 0 then
	this.ScrollToRow(1)
	this.Post of_set_marker(1, "Header")
	this.Trigger Event ue_scroll_check()
	This.Trigger Event ue_line()
end if


// -----------------------------------------
// Die Gruppen durchz$$HEX1$$e400$$ENDHEX$$hlen, wird f$$HEX1$$fc00$$ENDHEX$$r
// die Positionierung der Zeilenmarkierung
// ben$$HEX1$$f600$$ENDHEX$$tigt
// -----------------------------------------

if sGroupFieldType = "number" then

	iCounter = 1
	lGroupKey = this.GetItemNumber(1, sGroupField)
	
	for a = 1 to lRows
		
		if this.GetItemNumber(a, sGroupField) = lGroupKey then
			this.SetItem(a, "group_no", iCounter)
		else
			iCounter ++
			lGroupKey = this.GetItemNumber(a, sGroupField)
			this.SetItem(a, "group_no", iCounter)
		end if
		
		this.SetItemStatus(a, "group_no", Primary!, NotModified!)
						
	next

end if

if sGroupFieldType = "string" then

	iCounter = 1
	sGroupKey = this.GetItemString(1, sGroupField)
	
	for a = 1 to lRows
		
		if this.GetItemString(a, sGroupField) = sGroupKey then
			this.SetItem(a, "group_no", iCounter)
		else
			iCounter ++
			sGroupKey = this.GetItemString(a, sGroupField)
			this.SetItem(a, "group_no", iCounter)
		end if
		
		this.SetItemStatus(a, "group_no", Primary!, NotModified!)
						
	next

end if


SetPointer(Arrow!)
this.SetRedraw(true)
end event

event clicked;string 	sObject, &
			sColumn, &
			sBand
			
Long 		lRow, &
			lColRow, &
			a, &
			lGroupKey, &
			lY, &
			lLastRowOnPage, &
			lPageCount, &
			lOnPage
			
Integer iRet

// -----------------------------------------
// Row und Band des angeklickten Objektes 
// ermitteln
// -----------------------------------------

sObject = this.GetBandAtPointer()
sBand = Trim(MidA(sObject, 1, PosA(sObject, "~t") - 1))
lRow = Long(MidA(sObject, PosA(sObject, "~t") + 1))

sColumn = this.GetObjectAtPointer()
lColRow = Long(MidA(sColumn, PosA(sColumn, "~t") + 1))
sColumn = Trim(MidA(sColumn, 1, PosA(sColumn, "~t") - 1))

lLastRowOnPage = long(This.Describe("datawindow.LastRowOnPage"))

// -----------------------------------------
// wenn in eine Row geklickt wurde dann
// Daten im Dateil DW lesen
// -----------------------------------------

if lRow > 0 and sBand = "detail" then 

	if this.Trigger Event ue_scroll_to_row(lRow) = 0 then
		// -----------------------------------------------
		// Markierung nur wenn gescrollt wird
		// -----------------------------------------------
		This.Post of_set_marker(lRow, "Detail")
		this.Trigger Event ue_scroll_check()
	end if
	
	return 1
	
end if

this.SetRedraw(false)

// -----------------------------------------
// Wenn in den Groupheader geklickt wurde
// dann ein- bzw. ausblenden
// -----------------------------------------

if sBand = "header.1" and lRow > 0  then 
	
	if this.Trigger Event ue_scroll_to_row(lRow) = 0 then
						
		// -----------------------------------------------
		// Markierung nur wenn gescrollt wird
		// -----------------------------------------------
		lPageCount = this.GetItemNumber(1, "c_pagecounter")
		lOnPage    = this.GetItemNumber(lRow, "c_on_page")
		
		if this.GetItemNumber(lRow, "elapse") = 0 then
				
			if sGroupFieldType = "string" then
				of_elapse_string(lRow, 1, lDetailHeight)
			elseif sGroupFieldType = "number" then
				of_elapse_number(lRow, 1, lDetailHeight)
			end if
			
		// -----------------------------------------
		// Die Group ist ausgeblendet, also
		// einblenden Detailheight = 72
		// -----------------------------------------
		elseif this.GetItemNumber(lRow, "elapse") = 1 then
	
			if sGroupFieldType = "string" then
				of_elapse_string(lRow, 0, 0)
			elseif sGroupFieldType = "number" then
				of_elapse_number(lRow, 0, 0)
			end if
	
		end if
				
		// -------------------------------------------------------------
		// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob sich durch das auf/zuklappen die Seitenzahl 
		// ver$$HEX1$$e400$$ENDHEX$$ndert hat, wenn ja pr$$HEX1$$fc00$$ENDHEX$$fen, ob die aktuelle Zeile
		// noch im sichtbaren Bereich ist.
		// -------------------------------------------------------------
		// Die Seitenzahl ist angewachsen
		// -------------------------------------------------------------
		this.SetRedraw(true)
		if lOnPage < this.GetItemNumber(lRow, "c_on_page") then
			this.SetRedraw(False)
			this.ScrollToRow(lRow)
			Post of_set_marker(lRow, "")
		// -------------------------------------------------------------
		// Die Seitenzahl hat abgenommen
		// -------------------------------------------------------------
		elseif lOnPage > this.GetItemNumber(lRow, "c_on_page") then
			this.SetRedraw(False)
			This.Sort()
			This.GroupCalc()
			this.ScrollToRow(lRow)
			Post of_set_marker(lRow, "")			
		else
			this.SetRedraw(False)
			Post of_set_marker(lRow, "")
		end if
		
	end if
end if

this.SetRedraw(true)

end event

event scrollvertical;call super::scrollvertical;// ------------------------------------------------
// Nachschau, ob die aktuelle Row angezeigt wird
// ------------------------------------------------

//this.SetReDraw(false)


if this.GetRow() >= long(this.describe("datawindow.firstrowonpage")) and &
	this.GetRow() <= long(this.describe("datawindow.lastrowonpage")) then
	
	this.Modify("st_marker.visible = 1")
	
else
	
	this.Modify("st_marker.visible = 0")
	
end if


This.Trigger Event ue_line()

//this.GroupCalc()
//This.Post Modify("datawindow.verticalscrollposition = " + string(scrollpos))
//this.SetReDraw(true)
end event

event rowfocuschanged;call super::rowfocuschanged;


This.Post Event ue_line()

//
//if currentrow > 0 then
//	if This.GetItemNumber(currentrow, "elapse") = 0 then
//		This.Post of_set_marker(CurrentRow, "Detail")
//	end if
//end if
end event

event retrievestart;call super::retrievestart;this.SetRedraw(false)
end event

event rbuttondown;
return


end event

event rowfocuschanging;call super::rowfocuschanging;
// --------------------------------------------
// Alle zu $$HEX1$$dc00$$ENDHEX$$berwachende Datawindows auf
// $$HEX1$$c400$$ENDHEX$$nderungen pr$$HEX1$$fc00$$ENDHEX$$fen ....
// --------------------------------------------
if of_check_observer() = 1 then
	if this.Trigger Event ue_save() = 1 then
		return 1
	end if
end if

return 0
end event

event destructor;call super::destructor;integer i


for i = 1 to UpperBound(oDWObserver)
	destroy oDWObserver[i]
next
end event

