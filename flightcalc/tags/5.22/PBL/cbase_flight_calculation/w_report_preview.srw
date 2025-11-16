HA$PBExportHeader$w_report_preview.srw
$PBExportComments$Vorschaufenster f$$HEX1$$fc00$$ENDHEX$$r datastores (f_print_datastore)
forward
global type w_report_preview from window
end type
type pb_open from picturebutton within w_report_preview
end type
type pb_save from picturebutton within w_report_preview
end type
type cb_ok from commandbutton within w_report_preview
end type
type cb_exit from commandbutton within w_report_preview
end type
type dw_1 from datawindow within w_report_preview
end type
type st_2 from statictext within w_report_preview
end type
type st_1 from statictext within w_report_preview
end type
type st_22 from statictext within w_report_preview
end type
type st_221 from statictext within w_report_preview
end type
end forward

global type w_report_preview from window
integer width = 3520
integer height = 2208
boolean titlebar = true
string title = "Druckvorschau"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
pb_open pb_open
pb_save pb_save
cb_ok cb_ok
cb_exit cb_exit
dw_1 dw_1
st_2 st_2
st_1 st_1
st_22 st_22
st_221 st_221
end type
global w_report_preview w_report_preview

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

on w_report_preview.create
this.pb_open=create pb_open
this.pb_save=create pb_save
this.cb_ok=create cb_ok
this.cb_exit=create cb_exit
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
this.st_22=create st_22
this.st_221=create st_221
this.Control[]={this.pb_open,&
this.pb_save,&
this.cb_ok,&
this.cb_exit,&
this.dw_1,&
this.st_2,&
this.st_1,&
this.st_22,&
this.st_221}
end on

on w_report_preview.destroy
destroy(this.pb_open)
destroy(this.pb_save)
destroy(this.cb_ok)
destroy(this.cb_exit)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_22)
destroy(this.st_221)
end on

type pb_open from picturebutton within w_report_preview
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

type pb_save from picturebutton within w_report_preview
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
string picturename = "..\Resource\diskett2.gif"
string disabledname = "..\Resource\diskett2.gif"
alignment htextalign = left!
end type

event clicked;String		sDir, &
				sFileName, &
				sFileTypes, &
				sSaveName, &
				sFile

Integer 		iOpen

Blob 			bBlob

sDir = f_GetCurrentDirectory()

sFileTypes = "Binary File (*.Blob), *.Blob"

iOpen =  GetFileSaveName(("Speichern als"),sSaveName, sFile, "Blob", sFileTypes) 

if iOpen <> 1 then	
	return 
end if

if FileExists(sSaveName) then
	if Messagebox("Achtung", "Vorhandene Datei ${" + sSaveName + "} $$HEX1$$fc00$$ENDHEX$$berschreiben ?" , Question!, YesNo!, 1) = 2 then
		return 
	end if
	
end if

if dw_1.GetFullState(bBlob)  = -1 then
	Messagebox("Achtung", "Fehler GetFullState()") 
	return
end if
//Messagebox(sSaveName, iOpen)
//f_blob_to_file(sSaveName, bBlob)

//f_SetCurrentDirectory(sDir)



end event

type cb_ok from commandbutton within w_report_preview
integer x = 2491
integer y = 1984
integer width = 347
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
end type

event clicked;dw_1.Print()


	


end event

type cb_exit from commandbutton within w_report_preview
integer x = 2898
integer y = 1984
integer width = 347
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Abbrechen"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_report_preview
integer x = 9
integer y = 8
integer width = 3237
integer height = 1932
integer taborder = 10
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_report_preview
integer x = 2894
integer y = 1980
integer width = 357
integer height = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_report_preview
integer x = 2487
integer y = 1980
integer width = 357
integer height = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_22 from statictext within w_report_preview
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

type st_221 from statictext within w_report_preview
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

