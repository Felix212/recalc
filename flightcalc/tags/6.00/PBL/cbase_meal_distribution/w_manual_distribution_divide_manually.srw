HA$PBExportHeader$w_manual_distribution_divide_manually.srw
$PBExportComments$Fenster zum manuellen Verteilen der Mengen in die Stauortgruppen~r~n~r~n- $$HEX1$$d600$$ENDHEX$$ffnet sich bei entsprechend gepflegten Stauortgruppen und~r~n  verwendeter Option "manuell" in den Verteilungsregeln
forward
global type w_manual_distribution_divide_manually from window
end type
type cbx_reuse_values from checkbox within w_manual_distribution_divide_manually
end type
type pb_exit from picturebutton within w_manual_distribution_divide_manually
end type
type pb_run from picturebutton within w_manual_distribution_divide_manually
end type
type pb_save from picturebutton within w_manual_distribution_divide_manually
end type
type st_1 from statictext within w_manual_distribution_divide_manually
end type
type st_shadow_1 from statictext within w_manual_distribution_divide_manually
end type
type dw_groups_final from datawindow within w_manual_distribution_divide_manually
end type
type rb_fixed_value from radiobutton within w_manual_distribution_divide_manually
end type
type rb_percentage from radiobutton within w_manual_distribution_divide_manually
end type
type dw_pax from datawindow within w_manual_distribution_divide_manually
end type
type dw_groups from datawindow within w_manual_distribution_divide_manually
end type
type p_indicator from picture within w_manual_distribution_divide_manually
end type
type dw_components from datawindow within w_manual_distribution_divide_manually
end type
type uo_statusbar from uo_comctl_statusbar within w_manual_distribution_divide_manually
end type
type pb_reset from picturebutton within w_manual_distribution_divide_manually
end type
type st_3 from statictext within w_manual_distribution_divide_manually
end type
type st_shadow_12 from statictext within w_manual_distribution_divide_manually
end type
end forward

global type w_manual_distribution_divide_manually from window
integer width = 2473
integer height = 1664
boolean titlebar = true
string title = "Manuelle Stauortgruppenzuordnung"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cbx_reuse_values cbx_reuse_values
pb_exit pb_exit
pb_run pb_run
pb_save pb_save
st_1 st_1
st_shadow_1 st_shadow_1
dw_groups_final dw_groups_final
rb_fixed_value rb_fixed_value
rb_percentage rb_percentage
dw_pax dw_pax
dw_groups dw_groups
p_indicator p_indicator
dw_components dw_components
uo_statusbar uo_statusbar
pb_reset pb_reset
st_3 st_3
st_shadow_12 st_shadow_12
end type
global w_manual_distribution_divide_manually w_manual_distribution_divide_manually

type variables
s_distribution_divide_manually		strOpen
uo_distribution							uoDistribution
String										sSection = "DivideManually"


end variables

forward prototypes
public subroutine wf_set_statusbar ()
public function integer wf_calc_pax ()
public function integer wf_run_simulation ()
public function integer wf_load ()
public function long wf_get_leg_result_key (long arg_result_key, integer arg_leg)
end prototypes

public subroutine wf_set_statusbar ();// ------------------------------------------------------
// Infos f$$HEX1$$fc00$$ENDHEX$$r Statusbar
// ------------------------------------------------------
long lRow,lRowOf

if isnull(dw_components) then return 

if not isvalid(dw_components) then return 
	

If dw_components.Getrow() > 0 Then
	lRow 		= dw_components.Getrow()
	lRowOf	= dw_components.Rowcount()
End if	

If isnull(lRow) 	Then lRow 	= 0
If isnull(lRowOf) Then lRowOf = 0

uo_StatusBar.of_SetText( 1, 0, "Row " + string(lRow) + " of " + string(lRowOf))

end subroutine

public function integer wf_calc_pax ();// ---------------------------------------------
// Je nach Anwendereinstellungen die Eingaben
// in Prozent umrechnen oder als Prozentwerte
// $$HEX1$$fc00$$ENDHEX$$bernehmen
// ---------------------------------------------
Long i, lQuantity, lPax, lValue

dw_groups.AcceptText()

if rb_percentage.Checked then
	
	// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob auch 100 Prozent in der Summe vorliegen
	for i = 1 to dw_groups.RowCount()
		dw_groups.SetItem(i, "nvalue_type", 2) // nebenbei den Berechnungstyp von 1 (manuell) auf 2 (Prozent) umsetzten
		lQuantity += dw_groups.GetItemNumber(i, "nvalue")
	next
	
	if lQuantity <> 100 then
		uf.mBox("Achtung", "Bitte exakt 100 Prozent in die Gruppen verteilen!", StopSign!)
		return 0
	end if
	
	dw_groups_final.Reset()
	if dw_groups.RowsCopy(1, dw_groups.RowCount(), Primary!, dw_groups_final, 1, Primary!) <> 1 then
		uf.mbox("Achtung", "Fehler beim Kopieren der Stauortgruppen!", StopSign!)
	end if
	
else // die Prozente selbst ausrechnen
	
	// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob auch alle Paxe auf die Gruppen verteilt wurden
	lPax = dw_pax.GetItemNumber(1, "cen_out_pax_npax")
	
	for i = 1 to dw_groups.RowCount()
		dw_groups.SetItem(i, "nvalue_type", 2) // nebenbei den Berechnungstyp von 1 (manuell) auf 2 (Prozent) umsetzten
		lQuantity += dw_groups.GetItemNumber(i, "nvalue")
	next
		
	if lQuantity <> lPax then
		// Messagebox("", "lQuantity " + String(lQuantity) + "  lPax " + String(lPax))
		uf.mBox("Achtung", "Bitte alle Passagiere auf die Gruppen verteilen", StopSign!)
		return 0
	end if		
	
	// --------------------------------------------
	// Das Verh$$HEX1$$e400$$ENDHEX$$ltnis der Eingaben ausrechnen
	// --------------------------------------------
	for i = 1 to dw_groups_final.RowCount()
		lValue = dw_groups.GetItemNumber(i, "nvalue") // Ist schon richtig so, ist der Datastore nebenan
		if lValue = 0 then continue
		dw_groups_final.SetItem(i, "nvalue", Round(lValue / (lPax / 100), 0) )
	next 
	
	
	// --------------------------------------------
	// Nachschaun, ob wir $$HEX1$$fc00$$ENDHEX$$ber 100 Prozent 
	// gekommen sind. Erstmal alle Prozetwerte
	// aufaddieren
	// --------------------------------------------
	lValue = 0
	for i = 1 to dw_groups_final.RowCount()
		lValue += dw_groups_final.GetItemNumber(i, "nvalue")
	next
			
	// --------------------------------------------
	// Es liegt ein Rundungsproblem vor, die
	// Differenz zu 100 ermitteln und vom h$$HEX1$$f600$$ENDHEX$$chsten
	// Wert abziehen
	// --------------------------------------------
	Long lDiff, lRow, lMax
	if lValue <> 100 then
		
		lDiff = lValue - 100
		
		// H$$HEX1$$f600$$ENDHEX$$chstwert suchen
		for i = 1 to dw_groups_final.RowCount()
			if dw_groups_final.GetItemNumber(i, "nvalue") > lMax then
				lMax = dw_groups_final.GetItemNumber(i, "nvalue")
				lRow = i
			end if
		next
		
		// H$$HEX1$$f600$$ENDHEX$$chstwert um Differenz reduzieren
		if lRow > 0 then
			lValue = dw_groups_final.GetItemNumber(lRow, "nvalue") - lDiff
			dw_groups_final.SetItem(lRow, "nvalue", lValue)
		end if
			
	end if
			
end if

pb_save.enabled 	= true
pb_run.enabled 	= false
pb_reset.enabled 	= true

wf_run_simulation()

return 0
end function

public function integer wf_run_simulation ();// ---------------------------------------------------
// Simulation f$$HEX1$$fc00$$ENDHEX$$r den Anwender
// ---------------------------------------------------

datastore	dsTemp, dsContents


dsTemp = create datastore
dsTemp.Dataobject = dw_components.dataobject

dsContents = create datastore
dsContents.Dataobject = dw_components.dataobject

dw_components.RowsCopy(1, dw_components.RowCount(), Primary!, dsTemp, 1, Primary!)

uoDistribution.dsStowageGroupValues.Reset()
dw_groups_final.RowsCopy(1, dw_groups_final.RowCount(), Primary!,uoDistribution.dsStowageGroupValues, 1, Primary!)

uoDistribution.of_divide_by_percent(dsTemp, dsContents, 0)

dw_components.Reset()
dsContents.RowsCopy(1, dsContents.RowCount(), Primary!, dw_components, 1, Primary!)
dw_components.Sort()
return 0

end function

public function integer wf_load ();String 	sClass
Long		I
Long		lCurrentResultKey
Integer  iLeg
this.SetRedraw(false)

pb_save.enabled 	= false
pb_run.enabled 	= true
pb_reset.enabled 	= false

dw_components.Reset()
if strOpen.dsContents.RowsCopy(1, strOpen.dsContents.RowCount(), Primary!, dw_components, 1, Primary!) <> 1 then
	uf.mbox("Achtung", "Fehler beim Kopieren der Komponenten!", StopSign!)
	if dw_components.RowCount() > 0 then
		iLeg = Integer(Mid(dw_components.GetItemString(1, "cmeal_control_code"), 1, 1))
	else
		iLeg = 1
	end if
else
	sClass = dw_components.GetItemString(1, "cclass")
	
	if dw_components.RowCount() > 0 then
		iLeg = Integer(Mid(dw_components.GetItemString(1, "cmeal_control_code"), 1, 1))
	else
		iLeg = 1
	end if
	
	
	if iLeg <> 1 then
		iLeg = iLeg
	end if
	
end if



dw_groups.Reset()
if strOpen.dsstowagegroupvalues.RowsCopy(1, strOpen.dsstowagegroupvalues.RowCount(), Primary!, dw_groups, 1, Primary!) <> 1 then
	uf.mbox("Achtung", "Fehler beim Kopieren der Stauortgruppen!", StopSign!)
end if

dw_groups_final.Reset()
if strOpen.dsstowagegroupvalues.RowsCopy(1, strOpen.dsstowagegroupvalues.RowCount(), Primary!, dw_groups_final, 1, Primary!) <> 1 then
	uf.mbox("Achtung", "Fehler beim Kopieren der Stauortgruppen!", StopSign!)
end if

if iLeg = 1 then
	lCurrentResultKey = strOpen.uoDistribution.lResultKey
else
	lCurrentResultKey = wf_get_leg_result_key(strOpen.uoDistribution.lResultKey, iLeg)
end if

dw_pax.SetTransObject(sqlca)
dw_pax.retrieve(lCurrentResultKey, sClass)



if dw_pax.RowCount() = 0 then 
	uf.mbox("Achtung", "Keine Passagierzahlen gefunden!", StopSign!)
else
	
	this.title = uf.translate("Stauortgruppenzuordnung f$$HEX1$$fc00$$ENDHEX$$r ") + dw_pax.GetItemString(1,"compute_flight")
	
	if sClass = strOpen.sLastClass then
		for I = 1 to dw_groups.RowCount()
			if i <= Upperbound(strOpen.lLastValues) then
				dw_groups.SetItem(i, "nvalue", strOpen.lLastValues[i])
			end if 
		next
	end if
	
end if

cbx_reuse_values.text = uf.translate("Aufteilung anwenden f$$HEX1$$fc00$$ENDHEX$$r alle Komponenten der Klasse ${" + sClass + "}")

dw_groups.SetFocus()
dw_groups.SetColumn("nvalue")

this.SetRedraw(true)
return 0
end function

public function long wf_get_leg_result_key (long arg_result_key, integer arg_leg);
// Den ResultKey eines weiterf$$HEX1$$fc00$$ENDHEX$$hrenden Legs ermitteln
Long lReturn

  SELECT cen_out.nresult_key  
    INTO :lReturn  
    FROM cen_out  
   WHERE ( cen_out.nresult_key_group = :arg_result_key ) AND  
         ( cen_out.nleg_number = :arg_leg )   ;

if sqlca.sqlcode <> 0 then
	return arg_result_key
else
	return lReturn
end if

return 0
end function

event open;long		llParts[3], 	&
			lID, 				&
			lPicture, 		&
			I, &
			lFound

String	sClass
//this.width = 4622
//this.height = 2764			
			
llParts[1] = UnitsToPixels(this.width, YUnitsToPixels!) / 100 * 45
llParts[2] = llParts[1] + UnitsToPixels(this.width, YUnitsToPixels!) / 100 * 20
llParts[3] = -1

uo_StatusBar.of_SetParts( llParts[] )
uo_StatusBar.of_SetText( 0, 0, "" )
uo_StatusBar.of_SetText( 1, 0, "" )
uo_StatusBar.of_SetText( 2, 0, String(Today(),s_app.sDateformat))


f_centerwindow(this)

strOpen 	= Message.PowerObjectParm

uoDistribution = strOpen.uoDistribution.of_clone()
dw_components.SetRowFocusIndicator(p_indicator)

if  f_profilestring(sSection, "CalcType", "1") = "1" then
	rb_percentage.Checked = true
else
	rb_fixed_value.Checked = true
end if

uf.translate_window(this)
uf.translate_datawindow(dw_components)
uf.translate_datawindow(dw_groups)	
uf.translate_datawindow(dw_pax)	

wf_load()

end event

on w_manual_distribution_divide_manually.create
this.cbx_reuse_values=create cbx_reuse_values
this.pb_exit=create pb_exit
this.pb_run=create pb_run
this.pb_save=create pb_save
this.st_1=create st_1
this.st_shadow_1=create st_shadow_1
this.dw_groups_final=create dw_groups_final
this.rb_fixed_value=create rb_fixed_value
this.rb_percentage=create rb_percentage
this.dw_pax=create dw_pax
this.dw_groups=create dw_groups
this.p_indicator=create p_indicator
this.dw_components=create dw_components
this.uo_statusbar=create uo_statusbar
this.pb_reset=create pb_reset
this.st_3=create st_3
this.st_shadow_12=create st_shadow_12
this.Control[]={this.cbx_reuse_values,&
this.pb_exit,&
this.pb_run,&
this.pb_save,&
this.st_1,&
this.st_shadow_1,&
this.dw_groups_final,&
this.rb_fixed_value,&
this.rb_percentage,&
this.dw_pax,&
this.dw_groups,&
this.p_indicator,&
this.dw_components,&
this.uo_statusbar,&
this.pb_reset,&
this.st_3,&
this.st_shadow_12}
end on

on w_manual_distribution_divide_manually.destroy
destroy(this.cbx_reuse_values)
destroy(this.pb_exit)
destroy(this.pb_run)
destroy(this.pb_save)
destroy(this.st_1)
destroy(this.st_shadow_1)
destroy(this.dw_groups_final)
destroy(this.rb_fixed_value)
destroy(this.rb_percentage)
destroy(this.dw_pax)
destroy(this.dw_groups)
destroy(this.p_indicator)
destroy(this.dw_components)
destroy(this.uo_statusbar)
destroy(this.pb_reset)
destroy(this.st_3)
destroy(this.st_shadow_12)
end on

event close;
if rb_percentage.Checked then 
	f_setprofilestring(sSection, "CalcType", "1")
else
	f_setprofilestring(sSection, "CalcType", "0")	
end if

end event

type cbx_reuse_values from checkbox within w_manual_distribution_divide_manually
integer x = 32
integer y = 1368
integer width = 1989
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Aufteilung f$$HEX1$$fc00$$ENDHEX$$r alle Komponenten der Klasse verwenden"
end type

type pb_exit from picturebutton within w_manual_distribution_divide_manually
integer x = 2235
integer y = 1188
integer width = 174
integer height = 152
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\door02.gif"
alignment htextalign = left!
end type

event clicked;int iReturn


if pb_save.enabled then

	iReturn = uf.mbox("Speichern","Sie haben Daten ge$$HEX1$$e400$$ENDHEX$$ndert, m$$HEX1$$f600$$ENDHEX$$chten Sie speichern ?",Question!,YesNoCancel!,1)
	
	If iReturn = 1 Then				// Speichern
	
		strOpen.bSuccessful 	= true
		strOpen.dsContents.Reset()
		dw_components.RowsCopy(1, dw_components.RowCount(), Primary!, strOpen.dsContents, 1, Primary!)
	
	ElseIf iReturn = 2 Then			// nicht Speichern
		
		strOpen.bSuccessful 	= false
		
	ElseIf iReturn = 3	Then		// Abbruch
		return 0
	End if

else

	strOpen.bSuccessful = false
	
end if

closewithreturn(parent, strOpen)
end event

type pb_run from picturebutton within w_manual_distribution_divide_manually
integer x = 2235
integer y = 212
integer width = 174
integer height = 152
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\run_enabled.gif"
string disabledname = "..\Resource\run_disabled.gif"
alignment htextalign = left!
end type

event clicked;

wf_calc_pax()



return 0
end event

type pb_save from picturebutton within w_manual_distribution_divide_manually
integer x = 2235
integer y = 24
integer width = 174
integer height = 152
integer taborder = 30
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

event clicked;Long 	lEmpty[]
Long	I

strOpen.bSuccessful 	= true

strOpen.dsContents.Reset()

if dw_pax.RowCount() > 0 then
	strOpen.sLastClass = dw_pax.GetItemString(1, "cen_out_pax_cclass")
end if

if dw_components.RowCount() > 0 then
	strOpen.iLastLeg = Integer(Mid(dw_components.GetItemString(1, "cmeal_control_code"), 1, 1))
end if

strOpen.lLastValues = lEmpty

if cbx_reuse_values.Checked then
	strOpen.bAskagain = false
else
	strOpen.bAskagain = true
end if

for i = 1 to dw_groups.RowCount()
	strOpen.lLastValues[i] = dw_groups.GetItemNumber(i, "nvalue")
next

for i = 1 to dw_groups_final.RowCount()
	strOpen.lLastPercents[i] = dw_groups_final.GetItemNumber(i, "nvalue")
next

dw_groups_final.GetFullState(strOpen.bLastGroupValues)

strOpen.bSuccessful 	= true

dw_components.RowsCopy(1, dw_components.RowCount(), Primary!, strOpen.dsContents, 1, Primary!)
closewithreturn(parent, strOpen)
end event

type st_1 from statictext within w_manual_distribution_divide_manually
integer x = 2231
integer y = 208
integer width = 183
integer height = 160
long backcolor = 80663510
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type st_shadow_1 from statictext within w_manual_distribution_divide_manually
integer x = 2231
integer y = 20
integer width = 183
integer height = 160
long backcolor = 80663510
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type dw_groups_final from datawindow within w_manual_distribution_divide_manually
integer x = 2501
integer y = 24
integer width = 891
integer height = 576
integer taborder = 20
string title = "none"
string dataobject = "dw_uo_stowage_groups_value"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_fixed_value from radiobutton within w_manual_distribution_divide_manually
integer x = 530
integer y = 480
integer width = 402
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "fester Wert"
end type

type rb_percentage from radiobutton within w_manual_distribution_divide_manually
integer x = 82
integer y = 480
integer width = 402
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "Prozent"
end type

type dw_pax from datawindow within w_manual_distribution_divide_manually
integer x = 14
integer y = 16
integer width = 1234
integer height = 596
integer taborder = 20
string title = "none"
string dataobject = "dw_uo_pax_manually"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_groups from datawindow within w_manual_distribution_divide_manually
event ue_key pbm_dwnkey
integer x = 1271
integer y = 16
integer width = 919
integer height = 596
integer taborder = 10
string title = "none"
string dataobject = "dw_uo_stowage_groups_value_display"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key;


// Den Workflow etwas optimieren
if this.GetRow() = this.RowCount() and key = KeyEnter! then
	
	if pb_save.Enabled then
		pb_save.TriggerEvent(Clicked!)
	else
		this.AcceptText()
		pb_run.TriggerEvent(Clicked!)
	end if
	
end if
end event

type p_indicator from picture within w_manual_distribution_divide_manually
boolean visible = false
integer x = 2231
integer y = 752
integer width = 101
integer height = 72
string picturename = "..\Resource\Indicator.bmp"
boolean focusrectangle = false
end type

type dw_components from datawindow within w_manual_distribution_divide_manually
event uo_mousemove pbm_dwnmousemove
event type integer ue_validation ( string sfield,  long lrow,  string sdata )
integer x = 14
integer y = 628
integer width = 2181
integer height = 712
integer taborder = 10
string dragicon = "..\resource\dragdrop.ico"
string title = "none"
string dataobject = "dw_uo_cen_out_meals_display_manually"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;

if row > 0 then this.scrolltorow(row)
	
end event

event rowfocuschanged;
//wf_set_statusbar()

if currentrow <= 0 then return 0

end event

type uo_statusbar from uo_comctl_statusbar within w_manual_distribution_divide_manually
integer x = 731
integer y = 984
integer taborder = 10
end type

type pb_reset from picturebutton within w_manual_distribution_divide_manually
integer x = 2235
integer y = 396
integer width = 174
integer height = 152
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "..\Resource\standard.gif"
string disabledname = "..\Resource\standard_disabled.gif"
alignment htextalign = left!
end type

event clicked;if uf.mbox("Achtung", "M$$HEX1$$f600$$ENDHEX$$chten Sie die Einstellungen zur$$HEX1$$fc00$$ENDHEX$$cksetzen?", Question!, YesNo!, 1) = 2 then
	return 0
end if

f_set_pointer_hourglass(handle(this))
parent.SetRedraw(false)

wf_load()
f_set_pointer_arrow()
parent.SetRedraw(true)

end event

type st_3 from statictext within w_manual_distribution_divide_manually
integer x = 2231
integer y = 392
integer width = 183
integer height = 160
long backcolor = 80663510
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type st_shadow_12 from statictext within w_manual_distribution_divide_manually
integer x = 2231
integer y = 1184
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

