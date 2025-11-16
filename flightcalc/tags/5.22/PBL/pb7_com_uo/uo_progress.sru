HA$PBExportHeader$uo_progress.sru
forward
global type uo_progress from userobject
end type
type hpb_1 from hprogressbar within uo_progress
end type
end forward

global type uo_progress from userobject
integer width = 1024
integer height = 152
boolean border = true
long backcolor = 67108864
string text = "none"
borderstyle borderstyle = StyleRaised!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
hpb_1 hpb_1
end type
global uo_progress uo_progress

forward prototypes
public subroutine uf_setPosition (integer iPos)
public subroutine uf_setmax (integer imax)
public subroutine uf_setmin (integer imin)
end prototypes

public subroutine uf_setPosition (integer iPos);hpb_1.Position = iPos
end subroutine

public subroutine uf_setmax (integer imax);hpb_1.MaxPosition = iMax
end subroutine

public subroutine uf_setmin (integer imin);hpb_1.MinPosition = iMin
end subroutine

on uo_progress.create
this.hpb_1=create hpb_1
this.Control[]={this.hpb_1}
end on

on uo_progress.destroy
destroy(this.hpb_1)
end on

event constructor;Long		lx, ly
window	wParent

wParent = GetParent()

if isvalid(wParent) Then
	lx = wParent.x + (wParent.width / 2) - (this.width / 2)
	ly = wParent.y + (wParent.height / 2) - (this.height / 2)
	This.Move(lx, ly)
end if



end event

type hpb_1 from hprogressbar within uo_progress
integer x = 5
integer y = 8
integer width = 1000
integer height = 120
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 1
boolean smoothscroll = true
end type

