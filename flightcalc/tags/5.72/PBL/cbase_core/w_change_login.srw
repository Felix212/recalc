HA$PBExportHeader$w_change_login.srw
$PBExportComments$Fenster zum Wechsel des Kennworts
forward
global type w_change_login from window
end type
type p_1 from picture within w_change_login
end type
type sle_password2 from singlelineedit within w_change_login
end type
type sle_password1 from singlelineedit within w_change_login
end type
type cb_cancel from commandbutton within w_change_login
end type
type cb_ok from commandbutton within w_change_login
end type
type st_2 from statictext within w_change_login
end type
type st_1 from statictext within w_change_login
end type
type st_3 from statictext within w_change_login
end type
type st_33 from statictext within w_change_login
end type
end forward

global type w_change_login from window
integer x = 1047
integer y = 864
integer width = 1586
integer height = 688
boolean titlebar = true
string title = "Kennwort $$HEX1$$e400$$ENDHEX$$ndern f$$HEX1$$fc00$$ENDHEX$$r Anwender"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
string icon = "WinLogo!"
p_1 p_1
sle_password2 sle_password2
sle_password1 sle_password1
cb_cancel cb_cancel
cb_ok cb_ok
st_2 st_2
st_1 st_1
st_3 st_3
st_33 st_33
end type
global w_change_login w_change_login

type variables
integer Versuche

long		lRoleID = 20500
long		lHelpID = 0
end variables

forward prototypes
public function boolean wf_rolecheck ()
end prototypes

public function boolean wf_rolecheck ();long 		lRow
Boolean 	bRet

lRow = s_app.ds_userinfo.find("nrole_id = " + string(lRoleID),1 ,s_app.ds_userinfo.Rowcount())

If s_app.bDebug Then
	f_role_info(this,lRoleID,lHelpID)
End if	


If lRow <= 0 Then
	bRet = False
else
	bRet = True
end if

return bRet 
end function

on w_change_login.create
this.p_1=create p_1
this.sle_password2=create sle_password2
this.sle_password1=create sle_password1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_2=create st_2
this.st_1=create st_1
this.st_3=create st_3
this.st_33=create st_33
this.Control[]={this.p_1,&
this.sle_password2,&
this.sle_password1,&
this.cb_cancel,&
this.cb_ok,&
this.st_2,&
this.st_1,&
this.st_3,&
this.st_33}
end on

on w_change_login.destroy
destroy(this.p_1)
destroy(this.sle_password2)
destroy(this.sle_password1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_33)
end on

event open;
	f_centerwindow(this)

// -------------------------------
// Translate
// -------------------------------	
	uf.translate_window(this)
	this.title = this.title + " " + s_app.sUser
	
	
	if Not wf_rolecheck() Then
		uf.mbox("Achtung", "Sie haben keine Berechtigung f$$HEX1$$fc00$$ENDHEX$$r dieses Fenster")
		Close(This)
		// ----------------------
		// weitere Verarbeitung 
		// abbrechen => return <> 0
		// ----------------------
		return 1
	end if
end event

type p_1 from picture within w_change_login
integer x = 50
integer y = 80
integer width = 146
integer height = 128
string picturename = "..\Resource\pwd.gif"
boolean focusrectangle = false
end type

type sle_password2 from singlelineedit within w_change_login
integer x = 731
integer y = 224
integer width = 681
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type sle_password1 from singlelineedit within w_change_login
integer x = 731
integer y = 96
integer width = 681
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_change_login
integer x = 960
integer y = 404
integer width = 361
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Abbrechen"
boolean cancel = true
end type

event clicked;
close( parent )
end event

type cb_ok from commandbutton within w_change_login
integer x = 288
integer y = 404
integer width = 361
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&OK"
end type

event clicked;string	sChange
integer i,iCheck
If sle_password1.text <> sle_password2.text Then
	uf.mbox("Kennwort $$HEX1$$e400$$ENDHEX$$ndern","Beide Eingaben m$$HEX1$$fc00$$ENDHEX$$ssen gleich sein.",Stopsign!)
	return
End if

If LenA(sle_password1.text) < 8 Then
	uf.mbox("Kennwort $$HEX1$$e400$$ENDHEX$$ndern","Kennw$$HEX1$$f600$$ENDHEX$$rter m$$HEX1$$fc00$$ENDHEX$$ssen mindestens 8 Zeichen lang sein.",Stopsign!)
	return
End if	

For i = 1 to LenA(sle_password1.text)
	 iCheck = AscA(MidA(sle_password1.text,i,1))
	 If iCheck < AscA("0") or iCheck > AscA("9") and &
	 	 iCheck < AscA("A") or iCheck > AscA("Z") and &
	 	 iCheck < AscA("a") or iCheck > AscA("z") Then
		 uf.mbox("Kennwort $$HEX1$$e400$$ENDHEX$$ndern","Kennwort enth$$HEX1$$e400$$ENDHEX$$lt ung$$HEX1$$fc00$$ENDHEX$$ltige Zeichen.",Stopsign!)
		 Return
	End if	 
Next	


// --------------------------------
// Nun gut,$$HEX1$$e400$$ENDHEX$$ndern wir das Kennwort
// --------------------------------
	UPDATE sys_login  
     	SET cuserpassword = :sle_password1.text  
    WHERE ( sys_login.cclient		= :s_app.sMandant ) AND  
          ( sys_login.cunit 		= :s_app.sWerk ) AND  
          ( sys_login.cusername 	= :s_app.sUser )   ;
			 
	If sqlca.sqlcode <> 0 Then
		uf.mbox("Kennwort $$HEX1$$e400$$ENDHEX$$ndern","Kennwort konnte nicht ge$$HEX1$$e400$$ENDHEX$$ndert werden.~nFehlercode: " + string(sqlca.SQLCode))
		return
	End if	
// --------------------------------
// auch in der Datenbank
// --------------------------------				 
	sChange = "ALTER USER " + Upper(s_app.sUser) + " IDENTIFIED BY " + sle_password1.text

	execute immediate :sChange;

	If sqlca.sqldbcode <> 0 Then
		uf.mbox("Kennwort $$HEX1$$e400$$ENDHEX$$ndern","Kennwort konnte nicht ge$$HEX1$$e400$$ENDHEX$$ndert werden.~nFehlercode: " + string(sqlca.SQLDBCode))
		rollback using sqlca;
		return
	End if
	
	commit using sqlca;
	
	uf.mbox("Kennwort $$HEX1$$e400$$ENDHEX$$ndern","Kennwort erfolgreich ge$$HEX1$$e400$$ENDHEX$$ndert.")
	close(parent)
end event

type st_2 from statictext within w_change_login
integer x = 133
integer y = 244
integer width = 562
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Kennwortbest$$HEX1$$e400$$ENDHEX$$tigung"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_change_login
integer x = 224
integer y = 116
integer width = 471
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Neues Kennwort:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_change_login
integer x = 283
integer y = 400
integer width = 370
integer height = 116
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

type st_33 from statictext within w_change_login
integer x = 955
integer y = 400
integer width = 370
integer height = 116
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

