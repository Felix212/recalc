HA$PBExportHeader$w_manual_loading.srw
$PBExportComments$Fenster zum Austausch der Standardbeladung. ~r~n~r~n- $$HEX1$$d600$$ENDHEX$$ffnet sich von w_manual_distribution
forward
global type w_manual_loading from window
end type
type cb_1 from commandbutton within w_manual_loading
end type
type cb_2 from commandbutton within w_manual_loading
end type
type dw_2 from datawindow within w_manual_loading
end type
type dw_1 from datawindow within w_manual_loading
end type
type st_2 from statictext within w_manual_loading
end type
type st_1 from statictext within w_manual_loading
end type
end forward

global type w_manual_loading from window
integer width = 1115
integer height = 1168
boolean titlebar = true
string title = "Standardbeladung tauschen"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_2 cb_2
dw_2 dw_2
dw_1 dw_1
st_2 st_2
st_1 st_1
end type
global w_manual_loading w_manual_loading

type variables
s_distribution_sim	strOpen
s_distribution_sim	strClose	
end variables

on w_manual_loading.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_2=create dw_2
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.cb_1,&
this.cb_2,&
this.dw_2,&
this.dw_1,&
this.st_2,&
this.st_1}
end on

on w_manual_loading.destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
end on

event open;Long I, a


dw_1.Modify("t_header.text='Standardbeladung'")
dw_2.Modify("t_header.text='Zusatzbeladung'")

f_centerwindow(this)
uf.translate_datawindow(dw_1)
uf.translate_datawindow(dw_2)

strOpen = Message.PowerObjectParm

For I = 1 to UpperBound(strOpen.sLL)
	a = dw_1.InsertRow(0)
	dw_1.SetItem(a, "cloadinglist", strOpen.sLL[i])
Next

if dw_1.RowCount() < 3 then
	for i = 3 - (dw_1.RowCount()) to 3
		a = dw_1.InsertRow(0)
		dw_1.SetItem(a, "cloadinglist", "")
	next
end if

For I = 1 to UpperBound(strOpen.sZBL)
	a = dw_2.InsertRow(0)
	dw_2.SetItem(a, "cloadinglist", strOpen.sZBL[i])
Next

if dw_2.RowCount() = 0 then
	a = dw_2.InsertRow(0)
	dw_2.SetItem(a, "cloadinglist", "")
end if


end event

type cb_1 from commandbutton within w_manual_loading
integer x = 233
integer y = 912
integer width = 283
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;Long 		lRows
String	sLL

dw_1.Accepttext()
dw_2.Accepttext()

for lRows = 1 to dw_1.RowCount()
	sLL = f_check_null(dw_1.GetItemString(lRows, "cloadinglist"))
	
	if sLL <> "" then
		strClose.sLL[UpperBound(strClose.sLL) + 1] = sLL
	end if
	
next

if UpperBound(strClose.sLL) = 0 then 
	beep(2)
	return 0
end if

for lRows = 1 to dw_2.RowCount()
	sLL = f_check_null(dw_2.GetItemString(lRows, "cloadinglist"))
	
	if sLL <> "" then
		strClose.sZBL[UpperBound(strClose.sZBL) + 1] = sLL
	end if
	
next

CloseWithReturn(parent, strClose)
end event

type cb_2 from commandbutton within w_manual_loading
integer x = 530
integer y = 912
integer width = 283
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Abbrechen"
end type

event clicked;
CloseWithReturn(parent, "-1")
end event

type dw_2 from datawindow within w_manual_loading
integer x = 5
integer y = 540
integer width = 1051
integer height = 328
integer taborder = 20
string title = "none"
string dataobject = "dw_uo_change_loading"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_manual_loading
integer x = 5
integer y = 8
integer width = 1051
integer height = 524
integer taborder = 10
string title = "none"
string dataobject = "dw_uo_change_loading"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_manual_loading
integer x = 526
integer y = 908
integer width = 293
integer height = 100
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

type st_1 from statictext within w_manual_loading
integer x = 229
integer y = 908
integer width = 293
integer height = 100
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

