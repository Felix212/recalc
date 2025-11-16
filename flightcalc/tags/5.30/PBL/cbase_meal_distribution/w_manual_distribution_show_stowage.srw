HA$PBExportHeader$w_manual_distribution_show_stowage.srw
$PBExportComments$Fenster zum Anzeigen der Stauortinhalt und Stauortparameter, war eigentlich zum debuggen gedacht, wurde aber beibehalten da der Anwender diese Funktion n$$HEX1$$fc00$$ENDHEX$$tzlich fand.~r~n~r~n- $$HEX1$$d600$$ENDHEX$$ffnet sich bei Doppelklick auf Stauort in w_manual_distribution
forward
global type w_manual_distribution_show_stowage from window
end type
type st_legs from statictext within w_manual_distribution_show_stowage
end type
type st_12 from statictext within w_manual_distribution_show_stowage
end type
type st_class6 from statictext within w_manual_distribution_show_stowage
end type
type st_class5 from statictext within w_manual_distribution_show_stowage
end type
type st_class4 from statictext within w_manual_distribution_show_stowage
end type
type st_sep from statictext within w_manual_distribution_show_stowage
end type
type st_11 from statictext within w_manual_distribution_show_stowage
end type
type st_multileg from statictext within w_manual_distribution_show_stowage
end type
type st_10 from statictext within w_manual_distribution_show_stowage
end type
type st_stow_group from statictext within w_manual_distribution_show_stowage
end type
type st_9 from statictext within w_manual_distribution_show_stowage
end type
type st_mixed from statictext within w_manual_distribution_show_stowage
end type
type st_8 from statictext within w_manual_distribution_show_stowage
end type
type st_multi from statictext within w_manual_distribution_show_stowage
end type
type st_7 from statictext within w_manual_distribution_show_stowage
end type
type st_class3 from statictext within w_manual_distribution_show_stowage
end type
type st_class2 from statictext within w_manual_distribution_show_stowage
end type
type st_class1 from statictext within w_manual_distribution_show_stowage
end type
type st_5 from statictext within w_manual_distribution_show_stowage
end type
type st_limit_spml from statictext within w_manual_distribution_show_stowage
end type
type st_6 from statictext within w_manual_distribution_show_stowage
end type
type st_limit from statictext within w_manual_distribution_show_stowage
end type
type st_4 from statictext within w_manual_distribution_show_stowage
end type
type st_unit from statictext within w_manual_distribution_show_stowage
end type
type st_3 from statictext within w_manual_distribution_show_stowage
end type
type st_sl from statictext within w_manual_distribution_show_stowage
end type
type st_2 from statictext within w_manual_distribution_show_stowage
end type
type st_1 from statictext within w_manual_distribution_show_stowage
end type
type st_stowage from statictext within w_manual_distribution_show_stowage
end type
type dw_stowage from datawindow within w_manual_distribution_show_stowage
end type
type dw_contents from datawindow within w_manual_distribution_show_stowage
end type
type ln_1 from line within w_manual_distribution_show_stowage
end type
type ln_2 from line within w_manual_distribution_show_stowage
end type
type ln_3 from line within w_manual_distribution_show_stowage
end type
type ln_4 from line within w_manual_distribution_show_stowage
end type
type ln_5 from line within w_manual_distribution_show_stowage
end type
type ln_6 from line within w_manual_distribution_show_stowage
end type
type ln_22 from line within w_manual_distribution_show_stowage
end type
end forward

global type w_manual_distribution_show_stowage from window
integer width = 2491
integer height = 1612
boolean border = false
windowtype windowtype = popup!
long backcolor = 16777215
st_legs st_legs
st_12 st_12
st_class6 st_class6
st_class5 st_class5
st_class4 st_class4
st_sep st_sep
st_11 st_11
st_multileg st_multileg
st_10 st_10
st_stow_group st_stow_group
st_9 st_9
st_mixed st_mixed
st_8 st_8
st_multi st_multi
st_7 st_7
st_class3 st_class3
st_class2 st_class2
st_class1 st_class1
st_5 st_5
st_limit_spml st_limit_spml
st_6 st_6
st_limit st_limit
st_4 st_4
st_unit st_unit
st_3 st_3
st_sl st_sl
st_2 st_2
st_1 st_1
st_stowage st_stowage
dw_stowage dw_stowage
dw_contents dw_contents
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
ln_5 ln_5
ln_6 ln_6
ln_22 ln_22
end type
global w_manual_distribution_show_stowage w_manual_distribution_show_stowage

type variables
uo_distribution_container uoStowage
end variables

on w_manual_distribution_show_stowage.create
this.st_legs=create st_legs
this.st_12=create st_12
this.st_class6=create st_class6
this.st_class5=create st_class5
this.st_class4=create st_class4
this.st_sep=create st_sep
this.st_11=create st_11
this.st_multileg=create st_multileg
this.st_10=create st_10
this.st_stow_group=create st_stow_group
this.st_9=create st_9
this.st_mixed=create st_mixed
this.st_8=create st_8
this.st_multi=create st_multi
this.st_7=create st_7
this.st_class3=create st_class3
this.st_class2=create st_class2
this.st_class1=create st_class1
this.st_5=create st_5
this.st_limit_spml=create st_limit_spml
this.st_6=create st_6
this.st_limit=create st_limit
this.st_4=create st_4
this.st_unit=create st_unit
this.st_3=create st_3
this.st_sl=create st_sl
this.st_2=create st_2
this.st_1=create st_1
this.st_stowage=create st_stowage
this.dw_stowage=create dw_stowage
this.dw_contents=create dw_contents
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.ln_5=create ln_5
this.ln_6=create ln_6
this.ln_22=create ln_22
this.Control[]={this.st_legs,&
this.st_12,&
this.st_class6,&
this.st_class5,&
this.st_class4,&
this.st_sep,&
this.st_11,&
this.st_multileg,&
this.st_10,&
this.st_stow_group,&
this.st_9,&
this.st_mixed,&
this.st_8,&
this.st_multi,&
this.st_7,&
this.st_class3,&
this.st_class2,&
this.st_class1,&
this.st_5,&
this.st_limit_spml,&
this.st_6,&
this.st_limit,&
this.st_4,&
this.st_unit,&
this.st_3,&
this.st_sl,&
this.st_2,&
this.st_1,&
this.st_stowage,&
this.dw_stowage,&
this.dw_contents,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.ln_4,&
this.ln_5,&
this.ln_6,&
this.ln_22}
end on

on w_manual_distribution_show_stowage.destroy
destroy(this.st_legs)
destroy(this.st_12)
destroy(this.st_class6)
destroy(this.st_class5)
destroy(this.st_class4)
destroy(this.st_sep)
destroy(this.st_11)
destroy(this.st_multileg)
destroy(this.st_10)
destroy(this.st_stow_group)
destroy(this.st_9)
destroy(this.st_mixed)
destroy(this.st_8)
destroy(this.st_multi)
destroy(this.st_7)
destroy(this.st_class3)
destroy(this.st_class2)
destroy(this.st_class1)
destroy(this.st_5)
destroy(this.st_limit_spml)
destroy(this.st_6)
destroy(this.st_limit)
destroy(this.st_4)
destroy(this.st_unit)
destroy(this.st_3)
destroy(this.st_sl)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_stowage)
destroy(this.dw_stowage)
destroy(this.dw_contents)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
destroy(this.ln_5)
destroy(this.ln_6)
destroy(this.ln_22)
end on

event open;

uoStowage = Message.PowerObjectParm

uoStowage.dsPackinglistSize.RowsCopy(1, uoStowage.dsPackinglistSize.RowCount(), Primary!, dw_stowage, dw_stowage.Rowcount() + 1, Primary!)
uoStowage.dsContent.RowsCopy(1, uoStowage.dsContent.RowCount(), Primary!, dw_contents, dw_contents.Rowcount() + 1, Primary!)

st_stowage.text 			= uoStowage.sStowage
st_sl.text 					= uoStowage.sPackinglist
st_unit.text 				= uoStowage.sUnit
st_class1.text 			= uoStowage.sClass1
st_class2.text 			= uoStowage.sClass2
st_class3.text 			= uoStowage.sClass3
// ---------- Class 4,5,6 -----------
st_class4.text 			= uoStowage.sClass4
st_class5.text 			= uoStowage.sClass5
st_class6.text 			= uoStowage.sClass6

st_stow_group.text 		= uoStowage.sStowageGroup

st_limit.text 				= String(uoStowage.lLimit)
st_limit_spml.text 		= String(uoStowage.lLimitSPML)
st_multi.text 				= String(uoStowage.iMultiClass)
st_mixed.text 				= String(uoStowage.iMixed)
st_legs.text			= String(uoStowage.ii_catering_legs)
st_multileg.text			= String(uoStowage.iMultiLeg)
st_sep.text					= String(uoStowage.lSeparate)

uf.translate_datawindow(dw_stowage)
uf.translate_datawindow(dw_contents)
uf.translate_window(this)

this.height = 1508
this.width  = 2491

f_centerwindow(this)
end event

event deactivate;close(this)
end event

event clicked;close(this)
end event

type st_legs from statictext within w_manual_distribution_show_stowage
integer x = 891
integer y = 96
integer width = 343
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "123456"
boolean focusrectangle = false
end type

type st_12 from statictext within w_manual_distribution_show_stowage
integer x = 599
integer y = 100
integer width = 288
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
long backcolor = 16777215
string text = "Legs:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_class6 from statictext within w_manual_distribution_show_stowage
integer x = 1285
integer y = 20
integer width = 105
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "66"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_class5 from statictext within w_manual_distribution_show_stowage
integer x = 1202
integer y = 20
integer width = 105
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "55"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_class4 from statictext within w_manual_distribution_show_stowage
integer x = 1120
integer y = 20
integer width = 105
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "44"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_sep from statictext within w_manual_distribution_show_stowage
integer x = 2126
integer y = 92
integer width = 146
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_11 from statictext within w_manual_distribution_show_stowage
integer x = 1819
integer y = 100
integer width = 288
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
long backcolor = 16777215
string text = "Separate"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_multileg from statictext within w_manual_distribution_show_stowage
integer x = 1664
integer y = 88
integer width = 146
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_10 from statictext within w_manual_distribution_show_stowage
integer x = 1385
integer y = 100
integer width = 288
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
long backcolor = 16777215
string text = "MultiLeg"
boolean focusrectangle = false
end type

type st_stow_group from statictext within w_manual_distribution_show_stowage
integer x = 18
integer y = 204
integer width = 507
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "XX-XX-XX"
boolean focusrectangle = false
end type

type st_9 from statictext within w_manual_distribution_show_stowage
integer x = 27
integer y = 144
integer width = 224
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
long backcolor = 16777215
string text = "Gruppe:"
boolean focusrectangle = false
end type

type st_mixed from statictext within w_manual_distribution_show_stowage
integer x = 2126
integer y = 20
integer width = 146
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_8 from statictext within w_manual_distribution_show_stowage
integer x = 1819
integer y = 32
integer width = 288
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
long backcolor = 16777215
string text = "Mix at end"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_multi from statictext within w_manual_distribution_show_stowage
integer x = 1664
integer y = 20
integer width = 146
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_manual_distribution_show_stowage
integer x = 1362
integer y = 32
integer width = 288
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
long backcolor = 16777215
string text = "MultiClass"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_class3 from statictext within w_manual_distribution_show_stowage
integer x = 1033
integer y = 20
integer width = 105
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "EY"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_class2 from statictext within w_manual_distribution_show_stowage
integer x = 951
integer y = 20
integer width = 105
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "BC"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_class1 from statictext within w_manual_distribution_show_stowage
integer x = 869
integer y = 20
integer width = 105
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "FC"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_manual_distribution_show_stowage
integer x = 626
integer y = 32
integer width = 288
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
long backcolor = 16777215
string text = "Klasse(n):"
boolean focusrectangle = false
end type

type st_limit_spml from statictext within w_manual_distribution_show_stowage
integer x = 261
integer y = 588
integer width = 146
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "1"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_manual_distribution_show_stowage
integer x = 270
integer y = 540
integer width = 174
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
long backcolor = 16777215
string text = "SPML:"
boolean focusrectangle = false
end type

type st_limit from statictext within w_manual_distribution_show_stowage
integer x = 32
integer y = 588
integer width = 146
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "1"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_manual_distribution_show_stowage
integer x = 27
integer y = 540
integer width = 183
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
long backcolor = 16777215
string text = "Limit:"
boolean focusrectangle = false
end type

type st_unit from statictext within w_manual_distribution_show_stowage
integer x = 18
integer y = 460
integer width = 507
integer height = 68
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "XX-XX-XX"
boolean focusrectangle = false
end type

type st_3 from statictext within w_manual_distribution_show_stowage
integer x = 27
integer y = 412
integer width = 389
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
long backcolor = 16777215
string text = "Beh$$HEX1$$e400$$ENDHEX$$ltnis:"
boolean focusrectangle = false
end type

type st_sl from statictext within w_manual_distribution_show_stowage
integer x = 18
integer y = 332
integer width = 507
integer height = 68
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "XX-XX-XX"
boolean focusrectangle = false
end type

type st_2 from statictext within w_manual_distribution_show_stowage
integer x = 27
integer y = 284
integer width = 389
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
long backcolor = 16777215
string text = "St$$HEX1$$fc00$$ENDHEX$$ckliste:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_manual_distribution_show_stowage
integer x = 27
integer y = 16
integer width = 439
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
long backcolor = 16777215
string text = "Stauort:"
boolean focusrectangle = false
end type

type st_stowage from statictext within w_manual_distribution_show_stowage
integer x = 18
integer y = 72
integer width = 507
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "XX-XX-XX"
boolean focusrectangle = false
end type

type dw_stowage from datawindow within w_manual_distribution_show_stowage
integer x = 539
integer y = 172
integer width = 1947
integer height = 496
integer taborder = 20
string title = "none"
string dataobject = "dw_uo_packinglist_size_display"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_contents from datawindow within w_manual_distribution_show_stowage
integer x = 14
integer y = 676
integer width = 2459
integer height = 816
integer taborder = 10
string title = "none"
string dataobject = "dw_uo_content_display"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type ln_1 from line within w_manual_distribution_show_stowage
integer linethickness = 1
integer endx = 2496
end type

type ln_2 from line within w_manual_distribution_show_stowage
integer linethickness = 1
integer beginy = 668
integer endx = 2496
integer endy = 668
end type

type ln_3 from line within w_manual_distribution_show_stowage
integer linethickness = 1
integer beginy = 1504
integer endx = 2496
integer endy = 1504
end type

type ln_4 from line within w_manual_distribution_show_stowage
integer linethickness = 1
integer beginy = 4
integer endy = 2000
end type

type ln_5 from line within w_manual_distribution_show_stowage
integer linethickness = 1
integer beginx = 2487
integer beginy = 4
integer endx = 2487
integer endy = 2000
end type

type ln_6 from line within w_manual_distribution_show_stowage
integer linethickness = 1
integer beginx = 526
integer beginy = 4
integer endx = 526
integer endy = 668
end type

type ln_22 from line within w_manual_distribution_show_stowage
integer linethickness = 1
integer beginx = 530
integer beginy = 168
integer endx = 3026
integer endy = 168
end type

