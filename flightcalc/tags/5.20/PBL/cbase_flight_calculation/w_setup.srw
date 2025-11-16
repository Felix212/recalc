HA$PBExportHeader$w_setup.srw
$PBExportComments$Vorschaufenster f$$HEX1$$fc00$$ENDHEX$$r datastores (f_print_datastore)
forward
global type w_setup from window
end type
type pb_exit from picturebutton within w_setup
end type
type dw_2 from datawindow within w_setup
end type
type pb_open from picturebutton within w_setup
end type
type pb_save from picturebutton within w_setup
end type
type dw_1 from datawindow within w_setup
end type
type st_22 from statictext within w_setup
end type
type st_221 from statictext within w_setup
end type
type st_2 from statictext within w_setup
end type
end forward

global type w_setup from window
integer width = 3534
integer height = 1736
boolean titlebar = true
string title = "Instanzen - Setup"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
boolean center = true
pb_exit pb_exit
dw_2 dw_2
pb_open pb_open
pb_save pb_save
dw_1 dw_1
st_22 st_22
st_221 st_221
st_2 st_2
end type
global w_setup w_setup

type variables
s_print_preview strPreview
end variables

event open;
strPreview = Message.PowerObjectParm

if not isnull(strPreview.bData) then
	dw_1.SetFullState(strPreview.bData)
else
	//messagebox("", "")
end if

dw_1.Modify("datawindow.print.preview = YES") 
dw_1.Modify("datawindow.print.preview.rulers = YES") 
end event

on w_setup.create
this.pb_exit=create pb_exit
this.dw_2=create dw_2
this.pb_open=create pb_open
this.pb_save=create pb_save
this.dw_1=create dw_1
this.st_22=create st_22
this.st_221=create st_221
this.st_2=create st_2
this.Control[]={this.pb_exit,&
this.dw_2,&
this.pb_open,&
this.pb_save,&
this.dw_1,&
this.st_22,&
this.st_221,&
this.st_2}
end on

on w_setup.destroy
destroy(this.pb_exit)
destroy(this.dw_2)
destroy(this.pb_open)
destroy(this.pb_save)
destroy(this.dw_1)
destroy(this.st_22)
destroy(this.st_221)
destroy(this.st_2)
end on

type pb_exit from picturebutton within w_setup
integer x = 3291
integer y = 1392
integer width = 174
integer height = 152
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\door02.gif"
string disabledname = "..\Resource\door02.gif"
alignment htextalign = left!
string powertiptext = "Run"
end type

event clicked;close(parent)
end event

type dw_2 from datawindow within w_setup
boolean visible = false
integer x = 3310
integer y = 452
integer width = 686
integer height = 400
integer taborder = 30
string title = "none"
string dataobject = "dw_setup_functions"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_open from picturebutton within w_setup
boolean visible = false
integer x = 3291
integer y = 216
integer width = 174
integer height = 152
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\open.gif"
string disabledname = "..\Resource\open.gif"
alignment htextalign = left!
end type

event clicked;Integer 	iRet

String 	sPath, &
			sFile, &
			sDir
			
Blob 		bBlob

sDir = f_GetCurrentDirectory()

iRet = GetFileOpenName("Dateiauswahl",  sPath, sFile, "Blob", "Binary File (*.Blob), *.Blob")

if iRet = 1 then
	
	f_file_to_blob(sPath, ref bBlob, true)
	dw_1.SetFullState(bblob)
	
end if

//f_SetCurrentDirectory(sDir)
end event

type pb_save from picturebutton within w_setup
integer x = 3291
integer y = 32
integer width = 174
integer height = 152
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "..\Resource\diskett2.gif"
string disabledname = "..\Resource\docs7_write.gif"
alignment htextalign = left!
end type

event clicked;dw_1.update()
this.enabled=false
end event

type dw_1 from datawindow within w_setup
integer x = 32
integer y = 32
integer width = 3214
integer height = 1524
integer taborder = 10
string title = "none"
string dataobject = "dw_setup_instances"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;integer i, j, k

this.settransobject(SQLCA)

dw_2.settransobject(SQLCA)
dw_2.retrieve()

i = 0
k = 0
do
	i++
	
	j = dw_2.find("nfunction = "+string(i), 1, dw_2.rowcount())
	
	if j > 0 then
		this.modify("nfunction"+string(i)+"_t.text = '"+string(i)+" "+dw_2.getitemstring(j, "cprotocol_text")+"'")
		this.modify("nfunction"+string(i)+"_t.x = "+string(453 + k * 455))
		this.modify("nfunction"+string(i)+".x = "+string(453 + k * 455))
		k++
	else
		if this.modify("nfunction"+string(i)+"_t.visible=0") = "" then
			this.modify("nfunction"+string(i)+".visible=0")
		else
			exit
		end if
	end if
loop until 1 = 2

this.modify("r_24.width = "+string(453 + k * 455))
this.retrieve()


end event

event itemchanged;pb_save.enabled=true
end event

event clicked;this.setrow(row)
end event

type st_22 from statictext within w_setup
integer x = 3287
integer y = 28
integer width = 183
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_221 from statictext within w_setup
boolean visible = false
integer x = 3287
integer y = 212
integer width = 183
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_setup
integer x = 3287
integer y = 1388
integer width = 183
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

