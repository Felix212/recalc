HA$PBExportHeader$w_meal_pax_counts_mass.srw
$PBExportComments$Fenster zur Eingabe der Passageierzahlenaufteilung. ~r~n~r~n$$HEX1$$d600$$ENDHEX$$ffnet im Flugbrowser, wenn der Schalter "Passagiere ausz$$HEX1$$e400$$ENDHEX$$hlen" im Mahlzeitendefinitionsobjekt gesetzt ist.
forward
global type w_meal_pax_counts_mass from w_response_resizable
end type
type gb_1 from groupbox within w_meal_pax_counts_mass
end type
type st_5 from statictext within w_meal_pax_counts_mass
end type
type dw_1 from datawindow within w_meal_pax_counts_mass
end type
type p_1 from picture within w_meal_pax_counts_mass
end type
type cb_ok from commandbutton within w_meal_pax_counts_mass
end type
type cbx_1 from checkbox within w_meal_pax_counts_mass
end type
end forward

global type w_meal_pax_counts_mass from w_response_resizable
integer x = 1047
integer y = 864
integer width = 3849
integer height = 1564
string title = "Passagiere ausz$$HEX1$$e400$$ENDHEX$$hlen"
long backcolor = 79741120
boolean center = true
string is_section = "w_pax_counts_resize"
long il_minheight = 1484
long il_minwidth = 3570
gb_1 gb_1
st_5 st_5
dw_1 dw_1
p_1 p_1
cb_ok cb_ok
cbx_1 cbx_1
end type
global w_meal_pax_counts_mass w_meal_pax_counts_mass

type variables
//s_new_handling_explosion s_new
uo_meal_calculation iuo_MealCalc

end variables

on w_meal_pax_counts_mass.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.st_5=create st_5
this.dw_1=create dw_1
this.p_1=create p_1
this.cb_ok=create cb_ok
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cbx_1
end on

on w_meal_pax_counts_mass.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.st_5)
destroy(this.dw_1)
destroy(this.p_1)
destroy(this.cb_ok)
destroy(this.cbx_1)
end on

event open;datawindowchild dw_child
long lFound
Long	ll_Ret
// Parameter
iuo_MealCalc = Message.PowerObjectParm	

f_centerwindow(this)

// Translate
uf.translate_window(this)
uf.translate_datawindow(dw_1)


ll_Ret = wf_customize_statusbar(true)

// -------------------------------
// 05.11.2015 HR: fensterposition wiederherstellen
// -------------------------------
ll_Ret = wf_restore_window_pos(false)

// =========================================================
// Resize-Funktionalit$$HEX1$$e400$$ENDHEX$$t
// format: obj, hoehe, breite, x, y, midx, midy
// zum aktivieren: close und resize event auch !!
// =========================================================
ll_Ret = this.Event ue_open_resize()

// =========================================================
// Posten des Events ue_post_open
// =========================================================

iuo_MealCalc.ids_ask4passenger.rowscopy(1, iuo_MealCalc.ids_ask4passenger.rowcount(), primary!, dw_1, 1, primary!)
dw_1.setfilter("npaxchanged = 1 or  nnewvalue <> npax_manual ")
dw_1.filter()

IF Handle(GetApplication()) = 0 THEN
	
else
	if dw_1.rowcount()=0 then
		cb_ok.triggerevent( clicked!)
		return
	end if
end if
dw_1.Setfocus()	

// --------------------------------------------------------------------------------------------------------------------
// #9310 Put a count on every Open Event on Powerbuilder side 
f_count_open_window(this)
// --------------------------------------------------------------------------------------------------------------------

Post Event ue_post_open()


end event

event ue_open_resize;
/* 
* Event: 				ue_open_resize
* Beschreibung: 	resize initialisieren
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 	Wer									Wann			Was und warum
*	1.0 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel 					28.03.2013	Erstellung
*
* Return Codes:
*
*/

// hilfsvariable
Long 	ll_Ret


// =========================================================
// Resize-Funktionalit$$HEX1$$e400$$ENDHEX$$t
// format: obj, hoehe, breite, x, y, midx, midy
// zum aktivieren: close und resize event auch !!
// =========================================================

uoResize = create uo_resize
//uoResize.of_set_minwidth(3570)
//uoResize.of_set_minheight(1484)
uoResize.of_set_minwidth(this.il_MinWidth)
uoResize.of_set_minheight(this.il_MinHeight)


uoResize.of_set_resize(gb_1, true, true)
uoResize.of_set_resize(dw_1, true, true)

//uoResize.of_set_resize(cb_ok, false, false, true, true)
//uoResize.of_set_resize(st_5, false, false, true, true)

uoResize.of_set_resize( cb_ok, false, false, false, TRUE,TRUE, false)
uoResize.of_set_resize( st_5, false, false, false, TRUE,TRUE, false)


return 0

end event

event ue_post_open;call super::ue_post_open;
// -------------------------------
// resize-funktionalit$$HEX1$$e400$$ENDHEX$$t anschalten
// -------------------------------
Long	ll_Ret
if (f_mandant_profilestring(sqlca, s_app.sMandant, "response", "resizable", "1") <> "1") then
	ll_Ret = wf_SetResizable()
end if

end event

type st_warning_2 from w_response_resizable`st_warning_2 within w_meal_pax_counts_mass
integer x = 206
integer y = 1216
integer height = 276
end type

type st_warning_1 from w_response_resizable`st_warning_1 within w_meal_pax_counts_mass
integer x = 59
integer y = 164
end type

type uo_statusbar from w_response_resizable`uo_statusbar within w_meal_pax_counts_mass
integer x = 0
integer width = 795
boolean border = true
end type

type gb_1 from groupbox within w_meal_pax_counts_mass
integer x = 23
integer y = 40
integer width = 3803
integer height = 1192
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_5 from statictext within w_meal_pax_counts_mass
integer x = 1609
integer y = 1268
integer width = 379
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

type dw_1 from datawindow within w_meal_pax_counts_mass
integer x = 41
integer y = 132
integer width = 3758
integer height = 1080
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ask4passanger_mass"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;

if currentrow = rowcount() then
	cb_ok.Default = true
else
	cb_ok.Default = false
end if
end event

type p_1 from picture within w_meal_pax_counts_mass
integer x = 64
integer y = 4
integer width = 146
integer height = 128
boolean bringtotop = true
string picturename = "..\Resource\Icons\users_men_women.png"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_meal_pax_counts_mass
integer x = 1614
integer y = 1272
integer width = 370
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&OK"
end type

event clicked;Long lRow

dw_1.AcceptText()

iuo_MealCalc.ids_ask4passenger.reset()

// --------------------------------------------------------------------------------------------------------------------
// 05.11.2015 HR: Filter wieder wegnehmen, damit alles kopiert wird
// --------------------------------------------------------------------------------------------------------------------
dw_1.setredraw(false)
dw_1.setfilter("")
dw_1.filter()

dw_1.rowscopy(1, dw_1.rowcount(), primary!, iuo_MealCalc.ids_ask4passenger, 1, primary!)

close(parent)

end event

type cbx_1 from checkbox within w_meal_pax_counts_mass
integer x = 3072
integer y = 152
integer width = 667
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "nur ge$$HEX1$$e400$$ENDHEX$$nderte Klassen"
boolean checked = true
end type

event clicked;integer i
if this.checked then
	i = dw_1.setfilter("npaxchanged = 1 or  nnewvalue <> npax_manual ")
else
	i = dw_1.setfilter("")
end if

i = dw_1.filter()
dw_1.sort()
	

end event

