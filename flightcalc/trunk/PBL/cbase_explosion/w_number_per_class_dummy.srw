HA$PBExportHeader$w_number_per_class_dummy.srw
forward
global type w_number_per_class_dummy from window
end type
type p_indicator from picture within w_number_per_class_dummy
end type
type dw_1 from datawindow within w_number_per_class_dummy
end type
type cb_cancel from commandbutton within w_number_per_class_dummy
end type
type cb_ok from commandbutton within w_number_per_class_dummy
end type
type st_ok from statictext within w_number_per_class_dummy
end type
type st_cancel from statictext within w_number_per_class_dummy
end type
end forward

global type w_number_per_class_dummy from window
integer width = 1253
integer height = 1536
boolean titlebar = true
string title = "Erfassung Anzahl pro Klasse"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
p_indicator p_indicator
dw_1 dw_1
cb_cancel cb_cancel
cb_ok cb_ok
st_ok st_ok
st_cancel st_cancel
end type
global w_number_per_class_dummy w_number_per_class_dummy

type variables
// $$HEX1$$dc00$$ENDHEX$$bergabestruktur
s_number_per_class_parameters istr_Open

/*---------------------------------------------------------------------------
Eingangsparameter
------------------------------------------------------------------------------
	lAirline_key					nairline_key
	sClass_Array[]				cclass Liste mit Klassenbezeichnung der Airline
	bPax_number_required	Indikator, ob Passagieranzahl gesetzt werden muss
	bVersion_required			Indikator, ob Version gesetzt werden muss
------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
Ausgangsparameter
------------------------------------------------------------------------------
bSuccessful	wird $$HEX1$$fc00$$ENDHEX$$berhaupt was zur$$HEX1$$fc00$$ENDHEX$$ckgegeben ?
	TRUE		es wurde was ausgew$$HEX1$$e400$$ENDHEX$$hlt
	FALSE	es wurde nichts ausgew$$HEX1$$e400$$ENDHEX$$hlt
------------------------------------------------------------------------------
	sClass						cclass der aktuell selektierten Zeile
	iPax_number				npax der aktuell selektierten Zeile
	i_version						nversion der aktuell selektierten Zeile
	iClass_number				nclass_number der aktuell selektierten Zeile
	strno_per_class_array[]	s_number_per_class-Array mit den Klassen, -nummern, der Passagieranzahl und Version, 
------------------------------------------------------------------------------*/
end variables

forward prototypes
public function integer wf_handle_column (datawindow adwdw, string ascolumn, boolean abswitch, long altaborder)
end prototypes

public function integer wf_handle_column (datawindow adwdw, string ascolumn, boolean abswitch, long altaborder);/*
* Methode: wf_handle_column (Function)
*
* Argument(e):
* 	adwDW			zu betrachtendes DW
* 	asColumn		Spalte
* 	abSwitch			Schalter, ob Spalte on oder off gesetzt werden soll
* 	alTabOrder		Taborder, die gesetzt werden soll, wenn die Spalte aktiv ist
*
* Beschreibung:	De-/Aktivieren der Spalte
*
* Aenderungshistorie:
*  Version 		Wer			Wann 			Was und warum
*  1.0				I.H$$HEX1$$fc00$$ENDHEX$$bler		21.09.2010 		Erstellung
*
* Return: 
* 0 	immer
*/

string	lsRet, lsSwitch, lsColor, lsTaborder

// werte setzen
if abSwitch then
	// anschalten
	lsSwitch = "no"
	lsColor = "0"
	lsTaborder = string(alTabOrder)
else
	// ausschalten
	lsSwitch = "yes"
	lsColor = "8421504"
	lsTaborder = "0"
end if

// DW modifizieren
lsRet = adwDW.Modify(asColumn + ".edit.DisplayOnly=" + lsSwitch)
lsRet = adwDW.Modify(asColumn + ".TabSequence = " + lsTaborder)
lsRet = adwDW.Modify(asColumn + ".Color=" + lsColor)

return 0
end function

on w_number_per_class_dummy.create
this.p_indicator=create p_indicator
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_ok=create st_ok
this.st_cancel=create st_cancel
this.Control[]={this.p_indicator,&
this.dw_1,&
this.cb_cancel,&
this.cb_ok,&
this.st_ok,&
this.st_cancel}
end on

on w_number_per_class_dummy.destroy
destroy(this.p_indicator)
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_ok)
destroy(this.st_cancel)
end on

event open;/*
* Methode: open (Event)
*
* Argument(e): 	none
*
* Beschreibung:	dw-Transobject, $$HEX1$$dc00$$ENDHEX$$bersetzung
*
* Aenderungshistorie:
*  Version 		Wer			Wann 			Was und warum
*  1.0				I.H$$HEX1$$fc00$$ENDHEX$$bler		03.09.2010 		Erstellung
*
* Return: long
*/
istr_Open = Message.PowerObjectParm

//uf.translate_window(this)
//uf.translate_datawindow(dw_1)
//f_centerwindow(this)
//dw_1.uf_edit_style_freeform()

dw_1.SetRowFocusIndicator(p_indicator)
dw_1.SettransObject(sqlca)
dw_1.Retrieve(istr_open.lAirline_key, istr_open.sClass_Array)

if dw_1.RowCount() = 0 then
	cb_cancel.TriggerEvent(Clicked!)
	return
end if

if dw_1.RowCount() > 0 then
	dw_1.ScrollToRow(1)
end if

// --------------------------------------------------------------------------------------------------------------------
// #9310 Put a count on every Open Event on Powerbuilder side 
f_count_open_window(this)
// --------------------------------------------------------------------------------------------------------------------

end event

type p_indicator from picture within w_number_per_class_dummy
integer x = 1449
integer y = 904
integer width = 105
integer height = 72
string picturename = "..\Resource\indicator.png"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_number_per_class_dummy
integer x = 87
integer y = 68
integer width = 1074
integer height = 1176
integer taborder = 10
string dataobject = "dw_number_per_class"
end type

event retrieveend;call super::retrieveend;/*
* Methode: dw_detail.retrieveend (Event)
*
* Argument(e): 
*	rowcount		Anzahl der retrievten Zeilen des DW's
*
* Beschreibung:	Aktivit$$HEX1$$e400$$ENDHEX$$ten nach dem Retrieve des DW's
*
* Aenderungshistorie:
*  Version 		Wer			Wann 			Was und warum
*  1.0				I.H$$HEX1$$fc00$$ENDHEX$$bler		21.09.2010 		Erstellung
*
* Return: long
*/

// De-/Aktivieren der Spalten Passagiere und Version
wf_handle_column(this,"c_npax_number", istr_open.bpax_number_required, 10)
wf_handle_column(this,"c_nversion", istr_open.bversion_required, 20)






end event

type cb_cancel from commandbutton within w_number_per_class_dummy
integer x = 686
integer y = 1300
integer width = 347
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

event clicked;/*
* Methode: cb_cancel.clicked (Event)
*
* Argument(e): none
*
* Beschreibung:	Fenster schliessen (Abbrechen-Button)
*
* Aenderungshistorie:
*  Version 		Wer			Wann 			Was und warum
*  1.0				I.H$$HEX1$$fc00$$ENDHEX$$bler		06.09.2010 		Erstellung
*
* Return: long
* 0	continue processing (PB)
*/

// R$$HEX1$$fc00$$ENDHEX$$ckgabestruktur f$$HEX1$$fc00$$ENDHEX$$llen
istr_Open.bsuccessful = false
// Fenster schlie$$HEX1$$df00$$ENDHEX$$en
closewithreturn(parent, istr_Open)
end event

type cb_ok from commandbutton within w_number_per_class_dummy
integer x = 256
integer y = 1300
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

event clicked;/*
* Methode: cb_ok.clicked (Event)
*
* Argument(e): none
*
* Beschreibung:	Ausgew$$HEX1$$e400$$ENDHEX$$hlte Werte zur$$HEX1$$fc00$$ENDHEX$$ckgeben und Fenster schliessen (OK-Button)
*
* Aenderungshistorie:
*  Version 		Wer			Wann 			Was und warum
*  1.0				I.H$$HEX1$$fc00$$ENDHEX$$bler		06.09.2010 		Erstellung
*
* Return: long
* 0	continue processing (PB)
*/

if dw_1.GetRow() > 0 then
	
	Long ll_counter, ll_classIndex  
	string ls_class
	s_number_per_class lstr_noPerClassesArray[]
	
	//--------------------------------------------------------------------
	//	Alle Klassen mit zugeh$$HEX1$$f600$$ENDHEX$$riger Paxanzahl holen
	//--------------------------------------------------------------------
	for ll_counter=1 to dw_1.RowCount()
		
		// entsprechenden Eintrag im sClass-Array suchen, da Klassen in beliebiger Reihenfolge eingegeben werden k$$HEX1$$f600$$ENDHEX$$nnen
		// Reihenfolge muss in sClass-,  lClassNumbers- und lPaxNumbers-Array gleich sein !!!
		for ll_classIndex=1  to upperBound(istr_Open.sClass_array) 
			ls_class = dw_1.getitemString(ll_counter, "cclass")
			// wenn Klassen $$HEX1$$fc00$$ENDHEX$$bereinstimmen, pax-, class-Number und version setzen
			if ls_class  = istr_Open.sClass_array[ll_classIndex] then
				lstr_noPerClassesArray[ll_classIndex].sClass = ls_class
				lstr_noPerClassesArray[ll_classIndex].iClass_number = dw_1.getitemnumber(ll_counter, "nclass_number")
				lstr_noPerClassesArray[ll_classIndex].iPax_number = dw_1.getitemnumber(ll_counter, "c_npax_number")
				lstr_noPerClassesArray[ll_classIndex].iVersion = dw_1.getitemnumber(ll_counter, "c_nversion")
				exit
			end if
		next
	next
	
	// R$$HEX1$$fc00$$ENDHEX$$ckgabestruktur f$$HEX1$$fc00$$ENDHEX$$llen
	istr_Open.bsuccessful = true
	// aktuell selektierte Klasse mit Paxanzahl setzen
	istr_Open.sClass = dw_1.GetItemString(dw_1.getrow(), "cclass")
	istr_Open.iClass_number = dw_1.GetItemNumber(dw_1.getrow(), "nclass_number")
	istr_Open.iPax_number = dw_1.GetItemNumber(dw_1.getrow(), "c_npax_number")
	istr_Open.iVersion = dw_1.GetItemNumber(dw_1.getrow(), "c_nversion")
	// Array mit Paxanzahl, Version und Klassennummer zur$$HEX1$$fc00$$ENDHEX$$ckgeben
	istr_Open.strno_per_class_array = lstr_noPerClassesArray
	
	closewithreturn(parent, istr_Open)
	
end if

return 0
end event

type st_ok from statictext within w_number_per_class_dummy
integer x = 251
integer y = 1296
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

type st_cancel from statictext within w_number_per_class_dummy
integer x = 681
integer y = 1296
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

