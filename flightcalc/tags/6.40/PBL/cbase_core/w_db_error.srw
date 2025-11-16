HA$PBExportHeader$w_db_error.srw
$PBExportComments$Display database error messages; opened by db_error func
forward
global type w_db_error from window
end type
type p_1 from picture within w_db_error
end type
type st_1 from statictext within w_db_error
end type
type dw_error from datawindow within w_db_error
end type
type cb_print2 from commandbutton within w_db_error
end type
type cb_continue from commandbutton within w_db_error
end type
type cb_exit from commandbutton within w_db_error
end type
type mle_message from multilineedit within w_db_error
end type
type st_2 from statictext within w_db_error
end type
type st_4 from statictext within w_db_error
end type
type st_3 from statictext within w_db_error
end type
end forward

global type w_db_error from window
integer x = 654
integer y = 300
integer width = 2139
integer height = 1440
boolean titlebar = true
string title = "Database Error"
windowtype windowtype = response!
long backcolor = 80269524
p_1 p_1
st_1 st_1
dw_error dw_error
cb_print2 cb_print2
cb_continue cb_continue
cb_exit cb_exit
mle_message mle_message
st_2 st_2
st_4 st_4
st_3 st_3
end type
global w_db_error w_db_error

event open;/////////////////////////////////////////////////////////////////////////
// 
// Event:   Open for w_db_error
//
// Purpose: W_DB_ERROR is "called" from public function f_db_error.
//				The error message from the parameter is placed in 
//				the multi line edit for viewing.
// 			 
// Log:
// 
// DATE		NAME				REVISION
//------		-------------------------------------------------------------
// Powersoft Corporation	INITIAL VERSION
//
/////////////////////////////////////////////////////////////////////////

mle_message.text = message.stringparm

dw_error.insertrow (1)
dw_error.setitem (1,"message" ,mle_message.text)
end event

on w_db_error.create
this.p_1=create p_1
this.st_1=create st_1
this.dw_error=create dw_error
this.cb_print2=create cb_print2
this.cb_continue=create cb_continue
this.cb_exit=create cb_exit
this.mle_message=create mle_message
this.st_2=create st_2
this.st_4=create st_4
this.st_3=create st_3
this.Control[]={this.p_1,&
this.st_1,&
this.dw_error,&
this.cb_print2,&
this.cb_continue,&
this.cb_exit,&
this.mle_message,&
this.st_2,&
this.st_4,&
this.st_3}
end on

on w_db_error.destroy
destroy(this.p_1)
destroy(this.st_1)
destroy(this.dw_error)
destroy(this.cb_print2)
destroy(this.cb_continue)
destroy(this.cb_exit)
destroy(this.mle_message)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.st_3)
end on

type p_1 from picture within w_db_error
integer x = 46
integer y = 1012
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "..\resource\bug.gif"
boolean focusrectangle = false
end type

type st_1 from statictext within w_db_error
integer x = 242
integer y = 1048
integer width = 1888
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 80269524
boolean enabled = false
string text = "Print the errormessage and send it to your local system administrator."
boolean focusrectangle = false
end type

type dw_error from datawindow within w_db_error
boolean visible = false
integer x = 562
integer y = 1196
integer width = 119
integer height = 68
integer taborder = 1
string dataobject = "d_db_error"
boolean border = false
boolean livescroll = true
end type

type cb_print2 from commandbutton within w_db_error
integer x = 1705
integer y = 1196
integer width = 357
integer height = 104
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Print"
end type

event clicked;///////////////////////////////////////////////////////////////////////////
//// Event	 :  w_db_error.cb_print.clicked!
//// Purpose:
//// 			 The clicked event of cb_print is designed to create a print
////				 file using the database error message information and print
////				 the file.
//// Log:
//// 
//// DATE		NAME				REVISION
////------		-------------------------------------------------------------
//// Powersoft Corporation	INITIAL VERSION
////
///////////////////////////////////////////////////////////////////////////
//
//string  ls_line, ls_err_msg
//int    li_prt
//
//li_prt   = printopen("Database Error")
//
///*
//	Pass the multi line message to public function block_text which will
//	return the message in the necessary format to string ls_err_msg
//*/
//
//ls_err_msg = f_block_text ( mle_message.text, 60 )
//
//print(li_prt, "Database error  - "+string(today(),"mm/dd/yyyy")+" - "+string(now(),"HH:MM:SS"))
//print(li_prt, " ")
//print(li_prt, ls_err_msg)
//
//printclose(li_prt)
//

dw_error.print()
return
end event

type cb_continue from commandbutton within w_db_error
integer x = 905
integer y = 1196
integer width = 357
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Continue"
end type

on clicked;/////////////////////////////////////////////////////////////////////////
//
// Event	 :  w_system_error.cb_continue
//
// Purpose:
// 			Closes w_system_error
//
// Log:
// 
// DATE		NAME				REVISION
//------		-------------------------------------------------------------
// Powersoft Corporation	INITIAL VERSION
//
///////////////////////////////////////////////////////////////////////////

close(parent)
end on

type cb_exit from commandbutton within w_db_error
integer x = 59
integer y = 1196
integer width = 357
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Exit"
end type

on clicked;/////////////////////////////////////////////////////////////////////////
//
// Event	 :  w_system_error.cb_exit
//
// Purpose:
// 			Ends the application session
//
// Log:
// 
// DATE		NAME				REVISION
//------		-------------------------------------------------------------
// Powersoft Corporation	INITIAL VERSION
//
///////////////////////////////////////////////////////////////////////////

halt close
end on

type mle_message from multilineedit within w_db_error
integer x = 14
integer y = 12
integer width = 2085
integer height = 960
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Helv"
string pointer = "arrow!"
boolean vscrollbar = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_db_error
integer x = 55
integer y = 1192
integer width = 366
integer height = 112
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 80269524
long backcolor = 80269524
string text = "none"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_db_error
integer x = 1701
integer y = 1192
integer width = 366
integer height = 112
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 80269524
long backcolor = 80269524
string text = "none"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_db_error
integer x = 901
integer y = 1192
integer width = 366
integer height = 112
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 80269524
long backcolor = 80269524
string text = "none"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

