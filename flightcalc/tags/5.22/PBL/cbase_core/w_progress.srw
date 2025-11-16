HA$PBExportHeader$w_progress.srw
$PBExportComments$Fenster zur Fortschrittsanzeige der Verarbeitung
forward
global type w_progress from window
end type
type hpb_1 from hprogressbar within w_progress
end type
type st_status from statictext within w_progress
end type
type st_msg from statictext within w_progress
end type
type ln_1 from line within w_progress
end type
type ln_2 from line within w_progress
end type
type ln_3 from line within w_progress
end type
type ln_4 from line within w_progress
end type
end forward

global type w_progress from window
integer width = 1083
integer height = 484
boolean titlebar = true
windowtype windowtype = popup!
long backcolor = 67108864
hpb_1 hpb_1
st_status st_status
st_msg st_msg
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
end type
global w_progress w_progress

type variables
window oParent
end variables

forward prototypes
public function integer wf_setmessage (string smsg)
public function integer wf_setstatus (string smsg)
public function integer wf_settitle (string stitle)
public function integer wf_setmax (integer ival)
public function integer wf_setmin (integer ival)
public function integer wf_setposition (integer ival)
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

public function integer wf_setmax (integer ival);hpb_1.MaxPosition = iVal

return 0
end function

public function integer wf_setmin (integer ival);hpb_1.MinPosition = iVal

return 0
end function

public function integer wf_setposition (integer ival);hpb_1.Position = iVal 

return 0
end function

on w_progress.create
this.hpb_1=create hpb_1
this.st_status=create st_status
this.st_msg=create st_msg
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.Control[]={this.hpb_1,&
this.st_status,&
this.st_msg,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.ln_4}
end on

on w_progress.destroy
destroy(this.hpb_1)
destroy(this.st_status)
destroy(this.st_msg)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
end on

event open;uf.translate_window(this)
f_centerwindow(this)

end event

type hpb_1 from hprogressbar within w_progress
integer x = 27
integer y = 136
integer width = 1001
integer height = 112
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 1
end type

type st_status from statictext within w_progress
integer x = 37
integer y = 292
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
boolean focusrectangle = false
end type

type st_msg from statictext within w_progress
integer x = 27
integer y = 20
integer width = 1006
integer height = 112
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

type ln_1 from line within w_progress
long linecolor = 8421504
integer linethickness = 1
integer beginx = 27
integer beginy = 280
integer endx = 1029
integer endy = 280
end type

type ln_2 from line within w_progress
long linecolor = 8421504
integer linethickness = 1
integer beginx = 27
integer beginy = 284
integer endx = 27
integer endy = 360
end type

type ln_3 from line within w_progress
long linecolor = 16777215
integer linethickness = 1
integer beginx = 27
integer beginy = 360
integer endx = 1029
integer endy = 360
end type

type ln_4 from line within w_progress
long linecolor = 16777215
integer linethickness = 1
integer beginx = 1024
integer beginy = 284
integer endx = 1024
integer endy = 364
end type

