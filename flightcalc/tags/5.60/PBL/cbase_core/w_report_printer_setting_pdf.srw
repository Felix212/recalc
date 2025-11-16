HA$PBExportHeader$w_report_printer_setting_pdf.srw
forward
global type w_report_printer_setting_pdf from window
end type
type ddlb_range from dropdownlistbox within w_report_printer_setting_pdf
end type
type st_444 from statictext within w_report_printer_setting_pdf
end type
type em_copies from editmask within w_report_printer_setting_pdf
end type
type st_44 from statictext within w_report_printer_setting_pdf
end type
type st_4 from statictext within w_report_printer_setting_pdf
end type
type ddlb_printers from dropdownlistbox within w_report_printer_setting_pdf
end type
type cb_ok from commandbutton within w_report_printer_setting_pdf
end type
type cb_cancel from commandbutton within w_report_printer_setting_pdf
end type
type sle_pages from singlelineedit within w_report_printer_setting_pdf
end type
type st_3 from statictext within w_report_printer_setting_pdf
end type
type st_2 from statictext within w_report_printer_setting_pdf
end type
type st_1 from statictext within w_report_printer_setting_pdf
end type
type rb_3 from radiobutton within w_report_printer_setting_pdf
end type
type rb_2 from radiobutton within w_report_printer_setting_pdf
end type
type rb_1 from radiobutton within w_report_printer_setting_pdf
end type
type gb_1 from groupbox within w_report_printer_setting_pdf
end type
type st_5 from statictext within w_report_printer_setting_pdf
end type
type st_55 from statictext within w_report_printer_setting_pdf
end type
end forward

global type w_report_printer_setting_pdf from window
integer width = 1550
integer height = 1788
boolean titlebar = true
string title = "Seitenauswahl"
windowtype windowtype = response!
long backcolor = 67108864
ddlb_range ddlb_range
st_444 st_444
em_copies em_copies
st_44 st_44
st_4 st_4
ddlb_printers ddlb_printers
cb_ok cb_ok
cb_cancel cb_cancel
sle_pages sle_pages
st_3 st_3
st_2 st_2
st_1 st_1
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
gb_1 gb_1
st_5 st_5
st_55 st_55
end type
global w_report_printer_setting_pdf w_report_printer_setting_pdf

type variables
s_printer_settings	 	strPrint

String sDefaultPrinter
end variables

forward prototypes
public function integer of_get_pages (string spages)
end prototypes

public function integer of_get_pages (string spages);String 		sToken[]
integer		iToken
String		sTemp

Integer 		iStartPos = 1
Integer 		iEndPos	= 1
Integer 		iCounter
Integer 		i

Integer		iPos

if Trim(sPages) = "" then
	uf.mbox("Achtung", "Bitte geben Sie einen g$$HEX1$$fc00$$ENDHEX$$ltigen Seitenbereich ein!", StopSign!)
	return -1
end if

if right(sPages, 1) <> ";" then
	sPages = sPages + ";"
end if

Do while iEndPos > 0

	iEndPos	 = Pos(sPages, ";",  iStartPos)
	
	if iEndPos > 0 then
		
		iCounter ++
		sTemp = Mid(sPages, iStartPos, iEndPos - 1)
		sToken[iCounter] = sTemp
		//iStartPos = iEndPos + 1
		sPages = Mid(sPages, iEndPos + 1)
				
	end if

loop

Long 		j
String	sFrom, sTo
iCounter = 0

For i = 1 to upperbound(sToken)
	// --------------------------------------------------	
	// Einzelne Seite
	// --------------------------------------------------
	if IsNumber(sToken[i]) then
		// Ist die Seitenzahl kleiner der Maximalen Seitenanzahl
		if Long(sToken[i]) <= strPrint.lMaxPage then
			iCounter ++
			strPrint.lPrintPages[iCounter] = Long(sToken[i])
		end if
	// --------------------------------------------------	
	// Seitenbereich auswerten
	// --------------------------------------------------		
	else
		// ----------------------------------------------
		// Bindestrich finden und Zahlen trennen
		// ----------------------------------------------
		
		iPos = Pos(sToken[i], "-")
		
		// Bullshit-Eingabe
		if iPos <= 0 then
			uf.mbox("Achtung", "Bitte geben Sie einen g$$HEX1$$fc00$$ENDHEX$$ltigen Seitenbereich ein!", StopSign!)
			return -1
		end if
		
		sFrom = mid(sToken[i], 1, iPos - 1)
		sTo   = mid(sToken[i], iPos + 1 )
		
		// Sind die Werte vor und hinter dem Bindestrich auch Zahlen ???
		if isnumber(sFrom) and isnumber(sTo) then
		
			if Long(sFrom) < Long(sTo) then
			
				for j = Long(sFrom) to Long(sTo)
					if j <= strPrint.lMaxPage then
						iCounter ++
						strPrint.lPrintPages[iCounter] = j
					end if
				Next
				
			else
				uf.mbox("Achtung", "Bitte geben Sie einen g$$HEX1$$fc00$$ENDHEX$$ltigen Seitenbereich ein!", StopSign!)
				return -1
			end if
			
		else
			uf.mbox("Achtung", "Bitte geben Sie einen g$$HEX1$$fc00$$ENDHEX$$ltigen Seitenbereich ein!", StopSign!)
			return -1
		end if
	
	end if
		
Next

//for i = 1 to UpperBound(strPrint.lPrintPages)
//	f_debug("Page: " + string(strPrint.lPrintPages[i]))
//next
	
	

return 0
end function

on w_report_printer_setting_pdf.create
this.ddlb_range=create ddlb_range
this.st_444=create st_444
this.em_copies=create em_copies
this.st_44=create st_44
this.st_4=create st_4
this.ddlb_printers=create ddlb_printers
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.sle_pages=create sle_pages
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_1=create gb_1
this.st_5=create st_5
this.st_55=create st_55
this.Control[]={this.ddlb_range,&
this.st_444,&
this.em_copies,&
this.st_44,&
this.st_4,&
this.ddlb_printers,&
this.cb_ok,&
this.cb_cancel,&
this.sle_pages,&
this.st_3,&
this.st_2,&
this.st_1,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.gb_1,&
this.st_5,&
this.st_55}
end on

on w_report_printer_setting_pdf.destroy
destroy(this.ddlb_range)
destroy(this.st_444)
destroy(this.em_copies)
destroy(this.st_44)
destroy(this.st_4)
destroy(this.ddlb_printers)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.sle_pages)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_1)
destroy(this.st_5)
destroy(this.st_55)
end on

event open;String sPrinterList, sPrinter
Long lPos

f_centerwindow(this)
uf.translate_window(this)
strPrint = message.PowerObjectParm

// -----------------------------------
// sDefaultPrinter
// -----------------------------------
sDefaultPrinter = f_get_printer()
// -----------------------------------
// Drucker auslesen
// -----------------------------------
	
sPrinterList = f_get_printer_list(";")	
Do While sPrinterList <> ""

	sPrinter = f_get_token(sPrinterList,";")
	
	// -------------------------------------------
	// Pr$$HEX1$$fc00$$ENDHEX$$fung f$$HEX1$$fc00$$ENDHEX$$r Citrix, nur die  Drucker der 
	// eigenen Workstation in die Liste aufnehmen
	// -------------------------------------------
	if cbase.iCitrix = 1 then
		if f_citrix_printer(sPrinter) <= 0 then continue
	end if
	
	ddlb_printers.AddItem(sPrinter)
	
loop	

lPos = ddlb_printers.FindItem(sDefaultPrinter, 0)

if lPos > 0 then
	ddlb_printers.SelectItem(lPos)
end if 

ddlb_range.SelectItem(1)
end event

type ddlb_range from dropdownlistbox within w_report_printer_setting_pdf
integer x = 430
integer y = 1256
integer width = 978
integer height = 376
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
boolean sorted = false
string item[] = {"Alle Seiten","Alle geraden Seiten","Alle ungeraden Seiten"}
borderstyle borderstyle = stylelowered!
end type

type st_444 from statictext within w_report_printer_setting_pdf
integer y = 1264
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Drucken:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_copies from editmask within w_report_printer_setting_pdf
integer x = 384
integer y = 252
integer width = 206
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "1"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
double increment = 1
string minmax = "1~~99"
end type

type st_44 from statictext within w_report_printer_setting_pdf
integer y = 264
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Kopien:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_report_printer_setting_pdf
integer y = 76
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Drucker:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_printers from dropdownlistbox within w_report_printer_setting_pdf
integer x = 384
integer y = 64
integer width = 1038
integer height = 656
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_ok from commandbutton within w_report_printer_setting_pdf
integer x = 311
integer y = 1460
integer width = 370
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&OK"
end type

event clicked;Long lPos, lCopies

lPos = ddlb_range.FindItem(ddlb_range.text, 0) - 1

// ------------------------------------------------------------------------
// Kopien
// ------------------------------------------------------------------------
if Not isNumber(em_copies.text) then
	lCopies	= 1
	em_copies.text = "1"
elseif long(em_copies.text) > 99 or long(em_copies.text) <= 0 then
	lCopies	= 1
	em_copies.text = "1"
else	
	lCopies	= long(em_copies.text)
end if
	
strPrint.lCopies = lCopies
strPrint.sPrinter = ddlb_printers.text
// ------------------------------------------------------------------------
// Alle / gerade / ungerade
// ------------------------------------------------------------------------
if lPos = 0 or lPos = 1 or lPos = 2 then
	strPrint.lRangeInclude = lPos
else
	strPrint.lRangeInclude = 0
end if

// ------------------------------------------------------------------------
//  Alles / Aktuelle / Range
// ------------------------------------------------------------------------
if rb_1.checked then // Alles
	strPrint.lRange = 0
	
elseif rb_2.checked then // Aktuelle Seite
	strPrint.lRange = 1
	
elseif rb_3.checked then // Seitenbereich
	of_get_pages(sle_pages.text)
	strPrint.lRange = 2
end if

closewithreturn(parent,strPrint)


end event

type cb_cancel from commandbutton within w_report_printer_setting_pdf
integer x = 873
integer y = 1460
integer width = 370
integer height = 108
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Abbrechen"
boolean cancel = true
end type

event clicked;strPrint.lCopies = 0
closewithreturn(parent, strPrint)
end event

type sle_pages from singlelineedit within w_report_printer_setting_pdf
integer x = 544
integer y = 768
integer width = 681
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_report_printer_setting_pdf
integer x = 265
integer y = 1052
integer width = 544
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "werden, wie z.B 1;3;5-12"
boolean focusrectangle = false
end type

type st_2 from statictext within w_report_printer_setting_pdf
integer x = 265
integer y = 980
integer width = 942
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seitenbereiche durch Bindestriche getrennt"
boolean focusrectangle = false
end type

type st_1 from statictext within w_report_printer_setting_pdf
integer x = 265
integer y = 908
integer width = 887
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Einzelseiten m$$HEX1$$fc00$$ENDHEX$$ssen durch Semikola und"
boolean focusrectangle = false
end type

type rb_3 from radiobutton within w_report_printer_setting_pdf
integer x = 242
integer y = 784
integer width = 265
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seiten:"
end type

event clicked;// 08.12.2008 HR:SLE aktivieren, damit Seitenzahlen eingegeben werden k$$HEX1$$f600$$ENDHEX$$nnen
sle_pages.enabled=true


sle_pages.SetFocus()
end event

type rb_2 from radiobutton within w_report_printer_setting_pdf
integer x = 242
integer y = 668
integer width = 571
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Aktuelle Seite"
end type

event clicked;// 08.12.2008 HR:SLE deaktivieren, damit keiner was eintragen kann ohne den rb_3 zu aktivieren
sle_pages.enabled=false
end event

type rb_1 from radiobutton within w_report_printer_setting_pdf
integer x = 242
integer y = 556
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Alles"
boolean checked = true
end type

event clicked;// 08.12.2008 HR:SLE deaktivieren, damit keiner was eintragen kann ohne den rb_3 zu aktivieren
sle_pages.enabled=false
end event

type gb_1 from groupbox within w_report_printer_setting_pdf
integer x = 105
integer y = 436
integer width = 1312
integer height = 760
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seitenbereich"
end type

type st_5 from statictext within w_report_printer_setting_pdf
integer x = 306
integer y = 1456
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

type st_55 from statictext within w_report_printer_setting_pdf
integer x = 869
integer y = 1456
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

