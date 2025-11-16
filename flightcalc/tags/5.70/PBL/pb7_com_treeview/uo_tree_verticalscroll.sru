HA$PBExportHeader$uo_tree_verticalscroll.sru
forward
global type uo_tree_verticalscroll from vscrollbar
end type
end forward

global type uo_tree_verticalscroll from vscrollbar
integer width = 82
integer height = 492
event ue_mouse_up pbm_lbuttonup
end type
global uo_tree_verticalscroll uo_tree_verticalscroll

type variables
Public:
uo_tree_datawindow dwParent
//uo_tree_datawindow dwTwin
//datastore dwTwin

Long		lRowsOnPage, &
			lPageScroll, &
			lMaxScroll, &
			lPages, &
			lMaxGroup, &
			lLastPosition, &
			lElapsedRows, &
			lOldPages, &
			lOffSet

end variables

forward prototypes
public function integer of_check ()
public function integer of_set_position ()
public function integer of_init_2009 (uo_parent_dw dwval)
public function integer of_init (uo_parent_dw dwval)
public function integer of_parameters_2009 ()
public function integer of_parameters ()
end prototypes

public function integer of_check ();// --------------------------------------------
// Alle zu $$HEX1$$dc00$$ENDHEX$$berwachende Datawindows auf
// $$HEX1$$c400$$ENDHEX$$nderungen pr$$HEX1$$fc00$$ENDHEX$$fen ....
// --------------------------------------------
//if dwParent.of_check_observer() = 1 then
//	if dwParent.Trigger Event ue_save() = 1 then
//		return 1
//	end if
//end if

return 0
end function

public function integer of_set_position ();long lRow


if dwParent.GetRow() > 0 then
	
	//this.Position = dwParent.GetItemNumber(dwParent.GetRow(), "group_no") - 1
	lRow  = Long(dwParent.Describe("datawindow.FirstRowOnPage"))
	this.Position =  dwParent.GetItemNumber(lRow, "c_on_page") - 1
	this.of_parameters()
	
end if

return 0

end function

public function integer of_init_2009 (uo_parent_dw dwval);Long lRow, lLast, lFirst
datastore 	dsTemp
Blob						bTemp
Long 			I


dwParent = dwVal

this.visible = False

dsTemp = create datastore

dwParent.getFullState(bTemp)
dsTemp.SetFullState(bTemp)
dsTemp.SetDetailHeight(1, dsTemp.RowCount(), dwParent.lDetailHeight)		  

if dsTemp.RowCount() > 0 then
	this.Width = 73
	this.MinPosition = 0
	this.MaxPosition = dsTemp.GetItemNumber(dsTemp.RowCount(), "group_no") - 1
	this.y = dwParent.y + 8
	this.height = dwParent.Height - 16
	this.x = dwParent.x + dwParent.Width - this.width - 8
		
	lFirst           = Long(dsTemp.Describe("datawindow.firstrowonpage"))
	lLast            = Long(dsTemp.Describe("datawindow.lastrowonpage"))
	this.lRowsOnPage = dsTemp.GetItemnumber(lLast, "group_no")
	
	// ---------------------------------------------------------------
	// Maximale Scrollposition ermitten
	// ---------------------------------------------------------------
	this.lMaxScroll = Long(dwParent.describe("datawindow.verticalscrollmaximum"))
		
	// ---------------------------------------------------------------
	// Anzahl der Gruppen ermitteln
	// ---------------------------------------------------------------
	this.lMaxGroup   = dsTemp.GetItemNumber(dsTemp.RowCount(), "group_no")

	// ---------------------------------------------------------------
	// Wer f$$HEX1$$fc00$$ENDHEX$$r das Pagescrolling ermitteln
	// ---------------------------------------------------------------
	if this.lMaxGroup > 0 and lMaxScroll > 0 then
		
		//this.lPages      = dsTemp.GetItemNumber(1, "c_pagecounter") - 1 //this.lMaxGroup / this.lRowsOnPage
		this.lPages      = dsTemp.GetItemNumber(1, "c_pagecounter") //this.lMaxGroup / this.lRowsOnPage
		if this.lPages = 0 then this.lPages = 1
	
		this.lPageScroll = this.lMaxScroll / this.lPages
		
		//this.MaxPosition = this.lPages - 1
		this.MaxPosition = this.lPages 
		
	end if
	
else
	this.MinPosition = 0
	this.MaxPosition = 0
	this.lRowsOnPage = 1
	this.lPages = 0

end if


return 0
end function

public function integer of_init (uo_parent_dw dwval);Long 		lRow, lLast, lFirst
Blob		bBlob	  
Integer 	iRet
datastore dwTwin

dwParent = dwVal

this.visible = False

//dwTwin = Create datastore
//iRet = dwParent.GetFullstate(bBlob)
//dwTwin.SetFullstate(bBlob)
//Messagebox(dwTwin.DataObject + " " + string(iRet) + "               ", " Master: " + string(dwParent.RowCount()) + "    Twin: " + string(dwTwin.RowCount()))

dwParent.SetDetailHeight(1, dwParent.RowCount(), dwParent.lDetailHeight)

if dwParent.RowCount() > 0 then
	this.Width = 73
	this.MinPosition = 0
	this.MaxPosition = dwParent.GetItemNumber(dwParent.RowCount(), "group_no") - 1
	this.y = dwParent.y + 8
	this.height = dwParent.Height - 16
	this.x = dwParent.x + dwParent.Width - this.width - 8
		
	lFirst           = Long(dwParent.Describe("datawindow.firstrowonpage"))
	lLast            = Long(dwParent.Describe("datawindow.lastrowonpage"))
	this.lRowsOnPage = dwParent.GetItemnumber(lLast, "group_no")
	
	// ---------------------------------------------------------------
	// Maximale Scrollposition ermitten
	// ---------------------------------------------------------------
	this.lMaxScroll = Long(dwParent.describe("datawindow.verticalscrollmaximum"))
		
	// ---------------------------------------------------------------
	// Anzahl der Gruppen ermitteln
	// ---------------------------------------------------------------
	this.lMaxGroup   = dwParent.GetItemNumber(dwParent.RowCount(), "group_no")

	// ---------------------------------------------------------------
	// Wer f$$HEX1$$fc00$$ENDHEX$$r das Pagescrolling ermitteln
	// ---------------------------------------------------------------
	if this.lMaxGroup > 0 and lMaxScroll > 0 then
		
		// Messagebox("drin    ", dwParent.GetItemNumber(1, "c_pagecounter"))
		this.lPages      = dwParent.GetItemNumber(1, "c_pagecounter") - 1 //this.lMaxGroup / this.lRowsOnPage
		//this.lPages      = dwParent.GetItemNumber(1, "c_pagecounter")  //this.lMaxGroup / this.lRowsOnPage
		
		if this.lPages = 0 then this.lPages = 1
	
		this.lPageScroll = this.lMaxScroll / this.lPages
		this.MaxPosition = this.lPages - 1
		
	end if
	
else
	this.MinPosition = 0
	this.MaxPosition = 0
	this.lRowsOnPage = 1
	this.lPages = 0

end if

dwParent.SetDetailHeight(1, dwParent.RowCount(), 0)

return 0
end function

public function integer of_parameters_2009 ();datastore 	dsTemp
Blob						bTemp
Long 			I

if dwParent.RowCount() = 0 then return 0

dsTemp = create datastore

dwParent.getFullState(bTemp)
dsTemp.SetFullState(bTemp)

dsTemp.SetDetailHeight(1, dsTemp.RowCount(), dwParent.lDetailHeight)	

//dsTemp.Print()

this.lOldPages   = this.lPages 
//this.lPages      = dsTemp.GetItemNumber(1, "c_pagecounter") - 1 //this.lMaxGroup / this.lRowsOnPage
this.lPages      = dsTemp.GetItemNumber(1, "c_pagecounter") //this.lMaxGroup / this.lRowsOnPage



// ---------------------------------------------------------------
// Durch aufklappen wurde aus einer Seite zwei
// ---------------------------------------------------------------
if this.lMaxScroll = 0 and Long(dsTemp.describe("datawindow.verticalscrollmaximum")) > 0 then
	
	// ---------------------------------------------------------------
	// Wer f$$HEX1$$fc00$$ENDHEX$$r das Pagescrolling ermitteln
	// ---------------------------------------------------------------
	if this.lMaxGroup > 0 and lMaxScroll > 0 then
		this.lPageScroll = this.lMaxScroll / this.lPages
	end if
	
end if

// ---------------------------------------------------------------
// Maximale Scrollposition ermitten
// ---------------------------------------------------------------
this.lMaxScroll = Long(dsTemp.describe("datawindow.verticalscrollmaximum"))


if this.lPages <> this.lOldPages then
	This.lOffSet = this.lPages - this.lOldPages
end if

this.lElapsedRows = dsTemp.GetItemNumber(dsTemp.RowCount(), "c_sum_elapse")  
this.MaxPosition  = dsTemp.GetItemNumber(dsTemp.RowCount(), "group_no") - 1 + This.lOffset
this.MaxPosition  = This.lPages

// ---------------------------------------------------------------
// Anzahl der Gruppen ermitteln
// ---------------------------------------------------------------
this.lMaxGroup   = dsTemp.GetItemNumber(dsTemp.RowCount(), "group_no")

// ---------------------------------------------------------------
// Wer f$$HEX1$$fc00$$ENDHEX$$r das Pagescrolling ermitteln
// ---------------------------------------------------------------
if this.lMaxGroup > 0 then

	this.lPages      = dsTemp.GetItemNumber(1, "c_pagecounter") - 1 //this.lMaxGroup / this.lRowsOnPage
	this.lPages ++
	
end if

//f_debug(this.ClassName() + " -------------------------------------------")
//f_debug(this.ClassName() + " lRowsOnPage:  " + string(lRowsOnPage))
//f_debug(this.ClassName() + " lMaxScroll:   " + string(lMaxScroll))
//f_debug(this.ClassName() + " MaxPosition:  " + string(MaxPosition))
//f_debug(this.ClassName() + " Position:     " + string(Position)  )
//f_debug(this.ClassName() + " lMaxGroup:    " + string(lMaxGroup))
//f_debug(this.ClassName() + " lPages:       " + string(lPages)   )
//f_debug(this.ClassName() + " lOldPages:    " + string(lOldPages)   )
//f_debug(this.ClassName() + " lOffset:      " + string(lOffset)   )
//f_debug(this.ClassName() + " lPageScroll:  " + string(lPageScroll))
//f_debug(this.ClassName() + " lElapsedRows: " + string(lElapsedRows))



return 0
end function

public function integer of_parameters ();DataStore 	dsTemp
Blob			bTemp
String		sColumn

if dwParent.RowCount() = 0 then return 0

this.lOldPages   = this.lPages 
this.lPages      = dwParent.GetItemNumber(1, "c_pagecounter") - 1 //this.lMaxGroup / this.lRowsOnPage

if this.lPages 	= 0 then this.lPages = 1
this.lMaxScroll	= Long(dwParent.describe("datawindow.verticalscrollmaximum"))

// ---------------------------------------------------------------
// Durch aufklappen wurde aus einer Seite zwei
// ---------------------------------------------------------------
//if this.lMaxScroll = 0 and Long(dwParent.describe("datawindow.verticalscrollmaximum")) > 0 then
	
	// ---------------------------------------------------------------
	// Wer f$$HEX1$$fc00$$ENDHEX$$r das Pagescrolling ermitteln
	// ---------------------------------------------------------------
	if this.lMaxGroup > 0 and lMaxScroll > 0 then
		this.lPageScroll = this.lMaxScroll / this.lPages
	end if
	
//end if

// ---------------------------------------------------------------
// Maximale Scrollposition ermitten
// ---------------------------------------------------------------
this.lMaxScroll = Long(dwParent.describe("datawindow.verticalscrollmaximum"))


if this.lPages <> this.lOldPages then
	This.lOffSet = this.lPages - this.lOldPages
end if

this.lElapsedRows = dwParent.GetItemNumber(dwParent.RowCount(), "c_sum_elapse")  
this.MaxPosition  = dwParent.GetItemNumber(dwParent.RowCount(), "group_no") - 1 + This.lOffset
this.MaxPosition  = This.lPages

// ---------------------------------------------------------------
// Anzahl der Gruppen ermitteln
// ---------------------------------------------------------------
this.lMaxGroup   = dwParent.GetItemNumber(dwParent.RowCount(), "group_no")

// ---------------------------------------------------------------
// Wer f$$HEX1$$fc00$$ENDHEX$$r das Pagescrolling ermitteln
// ---------------------------------------------------------------
if this.lMaxGroup > 0 then

	this.lPages      = dwParent.GetItemNumber(1, "c_pagecounter") - 1 //this.lMaxGroup / this.lRowsOnPage
	
end if

//f_debug(this.ClassName() + " -------------------------------------------")
//f_debug(this.ClassName() + " lRowsOnPage:  " + string(lRowsOnPage))
//f_debug(this.ClassName() + " lMaxScroll:   " + string(lMaxScroll))
//f_debug(this.ClassName() + " MaxPosition:  " + string(MaxPosition))
//f_debug(this.ClassName() + " Position:     " + string(Position)  )
//f_debug(this.ClassName() + " lMaxGroup:    " + string(lMaxGroup))
//f_debug(this.ClassName() + " lPages:       " + string(lPages)   )
//f_debug(this.ClassName() + " lOldPages:    " + string(lOldPages)   )
//f_debug(this.ClassName() + " lOffset:      " + string(lOffset)   )
//f_debug(this.ClassName() + " lPageScroll:  " + string(lPageScroll))
//f_debug(this.ClassName() + " lElapsedRows: " + string(lElapsedRows))



return 0
end function

on uo_tree_verticalscroll.create
end on

on uo_tree_verticalscroll.destroy
end on

event constructor;this.MinPosition = 1
this.MaxPosition = 65000



end event

event linedown;this.Trigger Event PageDown()


end event

event lineup;this.Trigger Event PageUp()


end event

event pagedown;//Long 		lRow, &
//			lNewPosition, &
//			lVerticalScrollPos
////			
////Long     lScrollPos
////
////
////if dwParent.GetRow() <= 0 then return 0
//
//lRow  = Long(dwParent.Describe("datawindow.FirstRowOnPage"))
//
//lScrollPos = dwParent.GetItemNumber(lRow, "c_on_page")
//
//if lScrollPos > lPages then
//	lScrollPos = lPages
//end if
//
//this.Position = lScrollPos
//this.Trigger Event moved(lScrollPos)
//

Long 		lFound,  & 
			lNewPosition, &
			lVerticalScrollPos

String	sOut 	
	
this.of_parameters()	
	
lVerticalScrollPos = Long(dwParent.Describe("datawindow.verticalscrollposition"))
lNewPosition       = lVerticalScrollPos + lPageScroll
dwParent.Modify("datawindow.verticalscrollposition = " + String(lNewPosition))

//this.lLastPosition = scrollpos

sOut =  "~r----------------------------------------"
sOut += "~rthis.lMaxScroll    = " + string(this.lMaxScroll)
sOut += "~rthis.lPages	       = " + string(this.lPages)
sOut += "~r----------------------------------------"
sOut += "~rlVerticalScrollPos = " + String (lVerticalScrollPos)
sOut += "~rlPageScroll        = " + String (lPageScroll)
sOut += "~r                     ------------"
sOut += "~rlNewPosition       = " + String (lNewPosition)

// Messagebox("", sOut)


end event

event pageup;Long 		lRow, &
			lNewPosition, &
			lVerticalScrollPos
			
		
Long		lScrollPos


if dwParent.GetRow() <= 0 then return 0

lRow  = Long(dwParent.Describe("datawindow.FirstRowOnPage"))

lScrollPos = dwParent.GetItemNumber(lRow, "c_on_page")


//Messagebox("page up 1" ,  lScrollPos)

lScrollPos = lScrollPos - 2

if lScrollPos < 0 then
	lScrollPos = 0
end if

//Messagebox("page up 2" ,  lScrollPos)

this.Position = lScrollPos
this.Trigger Event moved(lScrollPos)



//// ---------------------------------------------------------------
//// Instanzvariablen neu initialisieren
//// ---------------------------------------------------------------
//of_parameters()
//
//lVerticalScrollPos    = Long(dwParent.Describe("datawindow.verticalscrollposition"))
//lNewPosition          = lVerticalScrollPos - lPageScroll
//
//if lNewPosition < 0 then
//	lNewPosition = 0
//end if
//
//dwParent.Modify("datawindow.verticalscrollposition = " + String(lNewPosition))
//
//// ---------------------------------------------------------------
//// Positionierung setzen
//// ---------------------------------------------------------------
//lRow = Long(dwParent.Describe("datawindow.FirstRowOnPage"))
//
//if lRow > 0 then 
//	
//	this.Position = dwParent.GetItemNumber(lRow, "group_no")
//	
//end if
end event

event moved;Long 		lFound,  & 
			lNewPosition, &
			lVerticalScrollPos
			


// ---------------------------------------------------------------
// Instanzvariablen neu initialisieren
// ---------------------------------------------------------------
// Alt: 
// lVerticalScrollPos    = Integer(scrollpos / lRowsOnPage)
// lNewPosition          = lVerticalScrollPos * lPageScroll

lNewPosition          = scrollpos * lPageScroll
dwParent.Modify("datawindow.verticalscrollposition = " + String(lNewPosition))
this.lLastPosition = scrollpos



end event

event getfocus;f_debug(this.ClassName() + " ---------FOCUS-------")

end event

event destructor;//destroy(dwTwin)
end event

