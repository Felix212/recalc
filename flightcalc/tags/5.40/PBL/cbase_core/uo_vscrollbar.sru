HA$PBExportHeader$uo_vscrollbar.sru
$PBExportComments$Scrollbar von uo_singlelineedit_with_history
forward
global type uo_vscrollbar from vscrollbar
end type
end forward

global type uo_vscrollbar from vscrollbar
integer width = 73
integer height = 256
event ue_init ( datawindow odw )
end type
global uo_vscrollbar uo_vscrollbar

type variables
datawindow	dwParent

end variables

forward prototypes
public function integer of_set_position (long lrow)
end prototypes

event ue_init(datawindow odw);long 			lDetailHeight, &
				lHeaderHeight, &
				lGroupHeaderHeight, &
				lObjectHeight
				
dwParent =  oDw 

lDetailHeight = long(dwParent.describe("datawindow.detail.height"))
lHeaderHeight = long(dwParent.describe("datawindow.Header.height"))
lGroupHeaderHeight = long(dwParent.describe("datawindow.Group.1.Header.height"))
lObjectHeight = dwParent.Height

if (lDetailHeight * dwParent.Rowcount()) + lHeaderHeight + lGroupHeaderHeight > lObjectHeight then
	this.Visible = True
else
	this.Visible = False
end if

//Messagebox("", "lDetaiHeight: " + string(lDetailHeight) + "~r~r" + &
//					"lHeaderHeight: " + string(lHeaderHeight) + "~r~r" + &
//					"lGroupHeaderHeight: " + string(lGroupHeaderHeight) + "~r~r" + &
//					"lObjectHeight: " + string(lObjectHeight) + "~r~r" + &
//					"dwParent.Rowcount(): " + string(dwParent.Rowcount()))


this.MinPosition = lDetailHeight
this.MaxPosition = dwParent.Rowcount() * lDetailHeight

end event

public function integer of_set_position (long lrow);
if lRow > 0 and isvalid(dwParent) then
	this.Position = lRow * long(dwParent.describe("datawindow.detail.height"))
end if

return 0
end function

on uo_vscrollbar.create
end on

on uo_vscrollbar.destroy
end on

event moved;long lRow


lRow = long(scrollpos / long(dwParent.describe("datawindow.detail.height")))

if lRow > 0 and lRow <= dwParent.RowCount() then
	this.Position = (lRow) * long(dwParent.describe("datawindow.detail.height"))
	dwParent.ScrollToRow(lRow)
end if
end event

event pagedown;long lRow

dwParent.ScrollNextPage()

lRow = long(dwParent.describe("datawindow.firstrowonpage"))

if lRow > 0 then
	this.Position = (lRow) * long(dwParent.describe("datawindow.detail.height"))
	dwParent.ScrollToRow(lRow)
end if
end event

event pageup;long lRow

dwParent.ScrollPriorPage()

lRow = long(dwParent.describe("datawindow.firstrowonpage"))

if lRow > 0 then
	this.Position = (lRow) * long(dwParent.describe("datawindow.detail.height"))
	dwParent.ScrollToRow(lRow)
end if
end event

event linedown;long lRow, lLastRow

dwParent.ScrollNextPage()

lRow = long(dwParent.describe("datawindow.firstrowonpage"))
lLastRow = long(dwParent.describe("datawindow.lastrowonpage"))

if lRow > 0 then
	this.Position = (lRow) * long(dwParent.describe("datawindow.detail.height"))
	dwParent.ScrollToRow(lRow)
	
	if lLastRow = dwParent.RowCount() then
		of_set_position(lLastRow)
	end if
	
end if
end event

event lineup;long lRow

dwParent.ScrollPriorPage()

lRow = long(dwParent.describe("datawindow.firstrowonpage"))

if lRow > 0 then
	this.Position = (lRow) * long(dwParent.describe("datawindow.detail.height"))
	dwParent.ScrollToRow(lRow)
end if
end event

event constructor;this.MinPosition = 1
this.MaxPosition = 65000
end event

