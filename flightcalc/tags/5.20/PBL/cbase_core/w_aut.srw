HA$PBExportHeader$w_aut.srw
$PBExportComments$Fenster zur Erstellung von Autorisationsantr$$HEX1$$e400$$ENDHEX$$gen
forward
global type w_aut from window
end type
type pb_help from picturebutton within w_aut
end type
type pb_print from picturebutton within w_aut
end type
type pb_exit from picturebutton within w_aut
end type
type sle_description from singlelineedit within w_aut
end type
type p_1 from picture within w_aut
end type
type dw_5 from datawindow within w_aut
end type
type dw_3 from datawindow within w_aut
end type
type dw_2 from datawindow within w_aut
end type
type dw_1 from datawindow within w_aut
end type
type gb_3 from groupbox within w_aut
end type
type mle_1 from multilineedit within w_aut
end type
type gb_6 from groupbox within w_aut
end type
type gb_4 from groupbox within w_aut
end type
type gb_2 from groupbox within w_aut
end type
type dw_6 from datawindow within w_aut
end type
type st_4 from statictext within w_aut
end type
type st_1 from statictext within w_aut
end type
type st_2 from statictext within w_aut
end type
end forward

global type w_aut from window
integer x = 110
integer y = 48
integer width = 4626
integer height = 2764
boolean titlebar = true
string title = "Authorisation order"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
string icon = "F:\Source\AutorisationsTool\Resource\lsg16.ico"
event post_open ( )
pb_help pb_help
pb_print pb_print
pb_exit pb_exit
sle_description sle_description
p_1 p_1
dw_5 dw_5
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
gb_3 gb_3
mle_1 mle_1
gb_6 gb_6
gb_4 gb_4
gb_2 gb_2
dw_6 dw_6
st_4 st_4
st_1 st_1
st_2 st_2
end type
global w_aut w_aut

type variables


end variables

event post_open();
// event wird durch Open gepostet und
// durch reset-Button getriggert. Deshalb kommen Resets vor
Integer 	i, PosInString 

long			lRow
datastore	dsRoles
string		sText, sDescription

dsRoles = create datastore
dsRoles.DataObject = "dw_autorisation_allroles"

dw_3.SetRowFocusIndicator(p_1)
dw_3.SetTransObject(SQLCA)
dw_3.Retrieve()

for i = 1 to dw_3.RowCount()
	lRow = dsRoles.InsertRow(0)
	sText = dw_3.GetItemString(i,"ctext")
	sDescription = dw_3.GetItemString(i,"cdescription")
	sText = uf.translate(sText)
	sDescription = uf.translate(sDescription)
	dsRoles.SetItem(lRow,"ctext",sText)
	dsRoles.SetItem(lRow,"cdescription",sDescription)
next

for i = 1 to dsRoles.RowCount()
	dw_3.SetItem(i,"ctext",dsRoles.GetItemString(i,"ctext"))
	dw_3.SetItem(i,"cdescription",dsRoles.GetItemString(i,"cdescription"))
	if i = 1 then
		sle_description.text = dsRoles.GetItemString(i,"cdescription")
	end if
next

dw_5.SetRowFocusIndicator(p_1)
dw_5.SetTransObject(SQLCA)
dw_5.Retrieve()

dw_1.Reset()
dw_2.Reset()

dw_1.ShareData(dw_2)
dw_1.InsertRow(0)

dw_1.SetItem (dw_1.GetRow(), "aut_Ab", Today())
dw_1.SetItem (dw_1.GetRow(), "aut_Bis", "31.12.3000")
dw_1.SetItem (dw_1.GetRow(), "autaend_ab", Today())
dw_1.SetItem (dw_1.GetRow(), "autloesch_ab", Today())

s_app.smandant			= "002"


end event

on w_aut.create
this.pb_help=create pb_help
this.pb_print=create pb_print
this.pb_exit=create pb_exit
this.sle_description=create sle_description
this.p_1=create p_1
this.dw_5=create dw_5
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_3=create gb_3
this.mle_1=create mle_1
this.gb_6=create gb_6
this.gb_4=create gb_4
this.gb_2=create gb_2
this.dw_6=create dw_6
this.st_4=create st_4
this.st_1=create st_1
this.st_2=create st_2
this.Control[]={this.pb_help,&
this.pb_print,&
this.pb_exit,&
this.sle_description,&
this.p_1,&
this.dw_5,&
this.dw_3,&
this.dw_2,&
this.dw_1,&
this.gb_3,&
this.mle_1,&
this.gb_6,&
this.gb_4,&
this.gb_2,&
this.dw_6,&
this.st_4,&
this.st_1,&
this.st_2}
end on

on w_aut.destroy
destroy(this.pb_help)
destroy(this.pb_print)
destroy(this.pb_exit)
destroy(this.sle_description)
destroy(this.p_1)
destroy(this.dw_5)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_3)
destroy(this.mle_1)
destroy(this.gb_6)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.dw_6)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;
move(24,285)

SQLCA.DBMS 			= s_app.sDBMS
SQLCA.LogPass 		= "zb41987"
SQLCA.ServerName 	= s_app.sServername
SQLCA.LogId 		= "cbase"
SQLCA.AutoCommit 	= False
SQLCA.DBParm 		= s_app.sDbparm

Connect Using SQLCA;

//
// 19.04.2006 CBASE UK wurde nicht ber$$HEX1$$fc00$$ENDHEX$$cksichtigt
//
if SQLCA.SQLDBCode = 1017 then
	SQLCA.LogPass 		= "cbaselhr"
	connect using sqlca;
end if
	

if SQLCA.SQLCode <> 0 then
	uf.mbox("Login","Couldn't connect to database.~r~r" + sqlca.sqlerrtext ,Stopsign!)
	return
end if

// ----------------------------
// 30.11.06 Translation auslesen
// ----------------------------
If uf.uf_create_datastore() = False Then
	uf.mbox("Translation","Could not read the translation data.",Stopsign!)
	s_app.ilanguage = 1 
End if


postevent("post_open")


end event

event close;disconnect using SQLCA;
if isvalid(uf.dsTranslate) then
	destroy uf.dsTranslate
end if

end event

type pb_help from picturebutton within w_aut
integer x = 4338
integer y = 2292
integer width = 174
integer height = 152
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\book07.gif"
alignment htextalign = left!
end type

event clicked;s_app.sHelpFile = "cbase.chm"
uf.help(handle(parent), parent.classname())

end event

type pb_print from picturebutton within w_aut
integer x = 4343
integer y = 32
integer width = 174
integer height = 152
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\printer1c.gif"
string disabledname = "..\Resource\printer1c_disabled.gif"
alignment htextalign = left!
end type

event clicked;	String	lsProfile,sGroups
	Integer	i

	dw_1.AcceptText()
	dw_6.AcceptText()
// -----------------------------------
// Anwender Profile
// -----------------------------------
	lsProfile = ""
	For i = 1 to dw_3.Rowcount()
		If dw_3.GetItemNumber(i,"norder") = 1 Then
			lsProfile = lsProfile + dw_3.GetItemString(i,"ctext") + "~n"
		End if	
	Next
	dw_2.Modify ("cprofile.text='" + lsProfile + "'")
// -----------------------------------
// die Besitzer Gruppen
// -----------------------------------
	sGroups = ""
	For i = 1 to dw_6.Rowcount()
		sGroups = sGroups + dw_6.GetItemString(i,"ctext") + "~n"
	Next
	dw_2.Modify ("cgruppen.text='" + sGroups + "'")
// -----------------------------------
// die Bemerkung
// -----------------------------------
	dw_2.Modify ("bemerkung.text='" + mle_1.text + "'")
	dw_2.AcceptText()
	dw_2.Print(True)


end event

type pb_exit from picturebutton within w_aut
integer x = 4338
integer y = 2492
integer width = 174
integer height = 152
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\door02.gif"
alignment htextalign = left!
end type

event clicked;close(parent)
end event

type sle_description from singlelineedit within w_aut
integer x = 50
integer y = 1512
integer width = 4114
integer height = 88
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 80269524
boolean border = false
end type

type p_1 from picture within w_aut
boolean visible = false
integer x = 4320
integer y = 1560
integer width = 101
integer height = 72
boolean originalsize = true
string picturename = "..\Resource\Indicator_button_color.gif"
boolean focusrectangle = false
end type

type dw_5 from datawindow within w_aut
event ue_mouse_move_pressed pbm_mousemove
integer x = 37
integer y = 1704
integer width = 1929
integer height = 452
integer taborder = 110
string dragicon = "..\Resource\Drag3pg.ico"
boolean bringtotop = true
string title = "none"
string dataobject = "dw_autorisation_allgroups"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type long ue_mouse_move_pressed(unsignedlong flags, integer xpos, integer ypos);
// -------------------------
// linker Button gedr$$HEX1$$fc00$$ENDHEX$$ckt
// -------------------------
if flags = 1 Then
	Drag(Begin!)
end if

return 0	
end event

event clicked;// ------------------------------
// Vorbereitung f$$HEX1$$fc00$$ENDHEX$$r DRAG
// ------------------------------
This.ScrollToRow(row)

end event

event dragdrop;Long 	lRow
DataWindow ldw_Source

IF source.TypeOf() = DataWindow! THEN
	ldw_Source = source
	// DataObject checken, wegen drag auf This
	if Handle(ldw_Source) <> Handle(This) And ldw_Source.DataObject = "dw_autorisation_allgroups" Then
		lRow = This.InsertRow(0)
		
		This.SetItem(lRow, "ctext", ldw_Source.GetItemString(ldw_Source.GetRow(), "ctext"))
		
		ldw_Source.DeleteRow(ldw_Source.GetRow())
		
		This.SetSort("ctext A")
		This.Sort()
	end if
END IF


end event

type dw_3 from datawindow within w_aut
event ue_mouse_move_pressed pbm_mousemove
integer x = 37
integer y = 608
integer width = 4059
integer height = 892
integer taborder = 100
string dragicon = "..\Resource\Drag3pg.ico"
string title = "none"
string dataobject = "dw_autorisation_allroles"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;// ------------------------------
// Vorbereitung f$$HEX1$$fc00$$ENDHEX$$r DRAG
// ------------------------------
This.ScrollToRow(row)

end event

event rowfocuschanged;string sdescription = ""

If currentrow > 0 Then
	sdescription = this.getitemstring(currentrow,"cdescription")
	sle_description.text = sdescription
End if	
end event

event retrieveend;string sdescription = ""

If this.Getrow() > 0 Then
	sdescription = this.getitemstring(this.Getrow(),"cdescription")
	sle_description.text = sdescription
End if	
end event

type dw_2 from datawindow within w_aut
boolean visible = false
integer x = 4338
integer y = 1760
integer width = 174
integer height = 156
integer taborder = 80
string dataobject = "dw_aut_report"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_aut
integer width = 4251
integer height = 536
integer taborder = 10
string dataobject = "dw_aut"
boolean border = false
boolean livescroll = true
end type

type gb_3 from groupbox within w_aut
integer x = 14
integer y = 540
integer width = 4183
integer height = 1072
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "User Profile"
end type

type mle_1 from multilineedit within w_aut
integer x = 55
integer y = 2284
integer width = 4059
integer height = 296
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean vscrollbar = true
integer limit = 500
borderstyle borderstyle = stylelowered!
end type

type gb_6 from groupbox within w_aut
integer x = 14
integer y = 2208
integer width = 4183
integer height = 440
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Remark"
end type

type gb_4 from groupbox within w_aut
integer x = 2112
integer y = 1632
integer width = 2085
integer height = 556
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Necessary Owner groups"
end type

type gb_2 from groupbox within w_aut
integer x = 14
integer y = 1632
integer width = 2098
integer height = 556
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Available Owner groups"
end type

type dw_6 from datawindow within w_aut
event ue_mouse_move_pressed pbm_mousemove
integer x = 2144
integer y = 1704
integer width = 1929
integer height = 452
integer taborder = 100
string dragicon = "..\Resource\Drag3pg.ico"
boolean bringtotop = true
string title = "none"
string dataobject = "dw_autorisation_allgroups"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type long ue_mouse_move_pressed(unsignedlong flags, integer xpos, integer ypos);
// -------------------------
// linker Button gedr$$HEX1$$fc00$$ENDHEX$$ckt
// -------------------------
if flags = 1 Then
	Drag(Begin!)
end if

return 0	
end event

event clicked;// ------------------------------
// Vorbereitung f$$HEX1$$fc00$$ENDHEX$$r DRAG
// ------------------------------
This.ScrollToRow(row)

end event

event dragdrop;Long 	lRow
DataWindow ldw_Source

IF source.TypeOf() = DataWindow! THEN
	ldw_Source = source
	// DataObject checken, wegen drag auf This
	if Handle(ldw_Source) <> Handle(This) And ldw_Source.DataObject = "dw_autorisation_allgroups" Then
		lRow = This.InsertRow(0)
		
		This.SetItem(lRow, "ctext", ldw_Source.GetItemString(ldw_Source.GetRow(), "ctext"))
		
		ldw_Source.DeleteRow(ldw_Source.GetRow())
		
		This.SetSort("ctext A")
		This.Sort()
	end if
END IF


end event

type st_4 from statictext within w_aut
integer x = 4338
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

type st_1 from statictext within w_aut
integer x = 4334
integer y = 2288
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

type st_2 from statictext within w_aut
integer x = 4334
integer y = 2488
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

