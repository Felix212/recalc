HA$PBExportHeader$w_progress_with_cancel.srw
$PBExportComments$Fenster zur Fortschrittsanzeige der Verarbeitung mit Cancel-Button
forward
global type w_progress_with_cancel from window
end type
type cb_1 from commandbutton within w_progress_with_cancel
end type
type hpb_1 from hprogressbar within w_progress_with_cancel
end type
type st_status from statictext within w_progress_with_cancel
end type
type st_msg from statictext within w_progress_with_cancel
end type
type ln_1 from line within w_progress_with_cancel
end type
type ln_2 from line within w_progress_with_cancel
end type
type ln_3 from line within w_progress_with_cancel
end type
type ln_4 from line within w_progress_with_cancel
end type
type st_1 from statictext within w_progress_with_cancel
end type
end forward

global type w_progress_with_cancel from window
integer width = 1083
integer height = 640
boolean titlebar = true
windowtype windowtype = popup!
long backcolor = 67108864
cb_1 cb_1
hpb_1 hpb_1
st_status st_status
st_msg st_msg
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
st_1 st_1
end type
global w_progress_with_cancel w_progress_with_cancel

type variables
Window oParent
boolean bCancel = False
end variables

forward prototypes
public function integer wf_setmessage (string smsg)
public function integer wf_setstatus (string smsg)
public function integer wf_settitle (string stitle)
public function integer wf_setmin (integer ival)
public function integer wf_setposition (integer ival)
public function integer wf_setmax (integer ival)
end prototypes

public function integer wf_setmessage (string smsg);st_msg.text = sMsg

return 0
end function

public function integer wf_setstatus (string smsg);st_Status.text = sMsg

return 0
end function

public function integer wf_settitle (string stitle);this.Title = sTitle

return 0
end function

public function integer wf_setmin (integer ival);hpb_1.MinPosition = iVal

return 0
end function

public function integer wf_setposition (integer ival);hpb_1.Position = iVal 

//Anti-Freeze fix
do while yield(); loop 

return 0
end function

public function integer wf_setmax (integer ival);hpb_1.MaxPosition = iVal

return 0
end function

on w_progress_with_cancel.create
this.cb_1=create cb_1
this.hpb_1=create hpb_1
this.st_status=create st_status
this.st_msg=create st_msg
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.st_1=create st_1
this.Control[]={this.cb_1,&
this.hpb_1,&
this.st_status,&
this.st_msg,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.ln_4,&
this.st_1}
end on

on w_progress_with_cancel.destroy
destroy(this.cb_1)
destroy(this.hpb_1)
destroy(this.st_status)
destroy(this.st_msg)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
destroy(this.st_1)
end on

event open;
oParent = message.PowerObjectParm

uf.translate_window(this)
f_centerwindow(this)

end event

type cb_1 from commandbutton within w_progress_with_cancel
integer x = 293
integer y = 380
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
string text = "Abbrechen"
end type

event clicked;st_status.text = uf.translate("Aktion wird beendet ...")
parent.bCancel = true

if isvalid(oParent) then
	oParent.Tag = "CANCEL"
end if

end event

type hpb_1 from hprogressbar within w_progress_with_cancel
integer x = 27
integer y = 112
integer width = 1001
integer height = 112
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 1
end type

type st_status from statictext within w_progress_with_cancel
integer x = 37
integer y = 268
integer width = 978
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_msg from statictext within w_progress_with_cancel
integer x = 27
integer y = 20
integer width = 1006
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type ln_1 from line within w_progress_with_cancel
long linecolor = 8421504
integer linethickness = 1
integer beginx = 27
integer beginy = 256
integer endx = 1029
integer endy = 256
end type

type ln_2 from line within w_progress_with_cancel
long linecolor = 8421504
integer linethickness = 1
integer beginx = 27
integer beginy = 260
integer endx = 27
integer endy = 336
end type

type ln_3 from line within w_progress_with_cancel
long linecolor = 16777215
integer linethickness = 1
integer beginx = 27
integer beginy = 336
integer endx = 1029
integer endy = 336
end type

type ln_4 from line within w_progress_with_cancel
long linecolor = 16777215
integer linethickness = 1
integer beginx = 1024
integer beginy = 260
integer endx = 1024
integer endy = 340
end type

type st_1 from statictext within w_progress_with_cancel
integer x = 288
integer y = 376
integer width = 411
integer height = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

