HA$PBExportHeader$uo_display_pdf.sru
$PBExportComments$Objekt zum Anzeigen und Drucken von PDFs
forward
global type uo_display_pdf from userobject
end type
type em_change from editmask within uo_display_pdf
end type
type p_save from picture within uo_display_pdf
end type
type p_print from picture within uo_display_pdf
end type
type p_mail from picture within uo_display_pdf
end type
type p_web from picture within uo_display_pdf
end type
type p_acrobat from picture within uo_display_pdf
end type
type p_excel from picture within uo_display_pdf
end type
type p_z_out from picture within uo_display_pdf
end type
type p_z_in from picture within uo_display_pdf
end type
type em_zoom from editmask within uo_display_pdf
end type
type p_hide from picture within uo_display_pdf
end type
type p_last from picture within uo_display_pdf
end type
type p_next from picture within uo_display_pdf
end type
type p_prev from picture within uo_display_pdf
end type
type p_first from picture within uo_display_pdf
end type
type ln_1 from line within uo_display_pdf
end type
type ln_2 from line within uo_display_pdf
end type
type st_1 from statictext within uo_display_pdf
end type
type ln_8 from line within uo_display_pdf
end type
type ln_9 from line within uo_display_pdf
end type
type st_7 from statictext within uo_display_pdf
end type
type ln_3 from line within uo_display_pdf
end type
type ln_33 from line within uo_display_pdf
end type
type ln_144 from line within uo_display_pdf
end type
type ln_155 from line within uo_display_pdf
end type
type ln_4 from line within uo_display_pdf
end type
type ln_5 from line within uo_display_pdf
end type
type ln_18 from line within uo_display_pdf
end type
type ln_19 from line within uo_display_pdf
end type
type ln_6 from line within uo_display_pdf
end type
type ln_7 from line within uo_display_pdf
end type
type ln_14 from line within uo_display_pdf
end type
type ln_15 from line within uo_display_pdf
end type
type ln_16 from line within uo_display_pdf
end type
type ln_17 from line within uo_display_pdf
end type
type ln_20 from line within uo_display_pdf
end type
type ln_21 from line within uo_display_pdf
end type
type st_marker from statictext within uo_display_pdf
end type
type tab_fake_container from tab within uo_display_pdf
end type
type tab_fake_container from tab within uo_display_pdf
end type
type ln_10 from line within uo_display_pdf
end type
end forward

global type uo_display_pdf from userobject
integer width = 2679
integer height = 1100
long backcolor = 67108864
string text = "1"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_killfocus pbm_killfocus
event ue_mousemove pbm_mousemove
em_change em_change
p_save p_save
p_print p_print
p_mail p_mail
p_web p_web
p_acrobat p_acrobat
p_excel p_excel
p_z_out p_z_out
p_z_in p_z_in
em_zoom em_zoom
p_hide p_hide
p_last p_last
p_next p_next
p_prev p_prev
p_first p_first
ln_1 ln_1
ln_2 ln_2
st_1 st_1
ln_8 ln_8
ln_9 ln_9
st_7 st_7
ln_3 ln_3
ln_33 ln_33
ln_144 ln_144
ln_155 ln_155
ln_4 ln_4
ln_5 ln_5
ln_18 ln_18
ln_19 ln_19
ln_6 ln_6
ln_7 ln_7
ln_14 ln_14
ln_15 ln_15
ln_16 ln_16
ln_17 ln_17
ln_20 ln_20
ln_21 ln_21
st_marker st_marker
tab_fake_container tab_fake_container
ln_10 ln_10
end type
global uo_display_pdf uo_display_pdf

type variables
PUBLIC:
boolean ib_Use_Current_File_For_Save = false
string is_Save_as_Name

PRIVATE:
boolean ib_thin = false

integer ii_Page
integer ii_PageCount
integer ii_Excel = 0
integer ii_Zoom = 100

long il_pageRange[]

string is_CurrentFile

picture ip_Pic[]

s_printer_settings istr_Print

uo_amyuni_viewer_interface iuo_viewer
end variables

forward prototypes
public function integer resize (integer w, integer h)
public function integer of_open (string as_file)
private function integer of_thin ()
private function integer of_set_page ()
private function integer of_set_zoom ()
public function integer of_close ()
private function integer of_set_marker (picture ap_pic)
end prototypes

event ue_killfocus;integer i

st_marker.Visible = false

for i = 1 to UpperBound(ip_Pic)
	ip_Pic[i].tag = "OFF"
next

end event

event ue_mousemove;integer i

st_marker.Visible = false

for i = 1 to UpperBound(ip_Pic)
	ip_Pic[i].tag = "OFF"
next



end event

public function integer resize (integer w, integer h);/* 
* Funktion: resize
* Beschreibung: Anpassen der Gr$$HEX2$$f600df00$$ENDHEX$$e des OLE Objekts an die Gr$$HEX2$$f600df00$$ENDHEX$$e des Parent Objekts 
* Besonderheit: keine
*
* Argumente:
* 	Name	Beschreibung
*  w     Die Breite in PB-Units, die gesetzt werden soll
*  h     Die H$$HEX1$$f600$$ENDHEX$$he in PB-Units, die gesetzt werden soll
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*	1.0        O.Hoefer    28.08.2008    Erstellung
*  1.1        D.Bunk      31.01.2013    Anpassungen f$$HEX1$$fc00$$ENDHEX$$r neue Amyuni Viewer Version
*
* Return Codes:
*/

integer li_ret

li_ret = super::resize(w, h)

if w > 40 then tab_fake_container.width = w
if h > 230 then tab_fake_container.height = h - 80
if ib_thin then tab_fake_container.height = tab_fake_container.height - 136

iuo_viewer.resize(tab_fake_container.width - 28, tab_fake_container.height)
iuo_viewer.show()

return li_ret
end function

public function integer of_open (string as_file);/* 
* Funktion: of_open
* Beschreibung: $$HEX1$$d600$$ENDHEX$$ffnet ein PDF Dokument im Viewer OCX 
* Besonderheit: keine
*
* Argumente:
* 	Name	  Beschreibung
*  as_File Der Pfad+Dateiname des PDF, das ge$$HEX1$$f600$$ENDHEX$$ffnet werden soll
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*	1.0        O.Hoefer    28.08.2008    Erstellung
*  1.1        D.Bunk      31.01.2013    Anpassungen f$$HEX1$$fc00$$ENDHEX$$r neue Amyuni Viewer Version
*
* Return Codes:
*   0: OK
*  -1: Fehler
*/

string ls_version

// Pr$$HEX1$$fc00$$ENDHEX$$fen, welche PDF Creator Version installiert ist und entsprechendes UserObject erstellen
RegistryGet("HKEY_CLASSES_ROOT\PDFCreactiveX.PDFCreactiveX\CurVer", "", ls_version)
choose case ls_version
	case "PDFCreactiveX.PDFCreactiveX.4.5"
		tab_fake_container.OpenTab(iuo_viewer, "uo_amyuni_viewer", 0)
	case "PDFCreactiveX.PDFCreactiveX.3"
		tab_fake_container.OpenTab(iuo_viewer, "uo_amyuni_viewer_251", 0)
	case else
		return -1
end choose

if IsNull(as_File) then return 0
if as_File = "" then return 0
if not FileExists(as_File) then return 0

iuo_viewer.of_open(as_File)

ii_Page = 1
ii_PageCount = iuo_viewer.of_get_page_count()

resize(width, height)
of_set_page()
of_set_zoom()

is_CurrentFile = as_File

p_print.Enabled = true
p_save.Enabled = true
p_web.Enabled = true
p_z_in.Enabled = true
p_z_out.Enabled = true
p_first.Enabled = true
p_prev.Enabled = true
p_next.Enabled = true
p_last.Enabled = true

return 0
end function

private function integer of_thin ();/* 
* Funktion: of_thin
* Beschreibung: Passt die Objekte des Viewer-Containers an eine schmale Variante an 
* Besonderheit: keine
*
* Argumente:
* 	Name	Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*	1.0        O.Hoefer    28.08.2008    Erstellung
*  1.1        D.Bunk      31.01.2013    Anpassungen f$$HEX1$$fc00$$ENDHEX$$r neue Amyuni Viewer Version
*
* Return Codes:
*   0: OK
*/

tab_fake_container.y = 268

p_print.x = 46
p_print.y = 168

ln_15.EndY = 264
ln_14.EndY = 264
ln_21.EndY = 264
ln_20.EndY = 264

ln_144.BeginY  = 264
ln_144.EndY	   = 264
ln_144.BeginX  = 9
ln_144.EndX    = 32009
ln_144.visible = true

ln_155.BeginY  = 268
ln_155.EndY	   = 268
ln_155.BeginX  = 9
ln_155.EndX    = 32009
ln_155.visible = true

ii_Zoom = 40
of_set_zoom()
ib_thin = true

return 0
end function

private function integer of_set_page ();/* 
* Funktion: of_set_page
* Beschreibung: W$$HEX1$$e400$$ENDHEX$$hlt die aktuell gesetzte Seite im Viewer aus und setzt den "gew$$HEX1$$e400$$ENDHEX$$hlte Seite" Text
* Besonderheit: keine
*
* Argumente:
* 	Name	Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*	1.0        O.Hoefer    28.08.2008    Erstellung
*  1.1        D.Bunk      31.01.2013    Anpassungen f$$HEX1$$fc00$$ENDHEX$$r neue Amyuni Viewer Version
*
* Return Codes:
*  0: OK
*/

iuo_viewer.of_show_page(ii_Page)

if ii_Page = 0 then
	em_change.Text = ""
else
	em_change.Text = String(ii_Page) + " / " + String(ii_PageCount)
end if

return 0
end function

private function integer of_set_zoom ();/* 
* Funktion: of_set_zoom
* Beschreibung: Passt den Zoom des ge$$HEX1$$f600$$ENDHEX$$ffneten PDF Dokuments und den Zoom-Anzeigetext an 
* Besonderheit: keine
*
* Argumente:
* 	Name	Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*	1.0        O.Hoefer    28.08.2008    Erstellung
*  1.1        D.Bunk      31.01.2013    Anpassungen f$$HEX1$$fc00$$ENDHEX$$r neue Amyuni Viewer Version
*
* Return Codes:
*   0: OK
*/

iuo_viewer.of_zoom(ii_Zoom)
em_zoom.text = String(ii_Zoom) + " %"
SetProfileString(s_app.sProfile, "PrintPreview", "Zoomfactor", String(ii_Zoom))

return 0
end function

public function integer of_close ();/* 
* Funktion: of_close
* Beschreibung: Schlie$$HEX1$$df00$$ENDHEX$$t ein ge$$HEX1$$f600$$ENDHEX$$ffnetes PDF Dokument des Viewer OCX
* Besonderheit: keine
*
* Argumente:
* 	Name	Beschreibung
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*	1.0        O.Hoefer    28.08.2008    Erstellung
*  1.1        D.Bunk      31.01.2013    Anpassungen f$$HEX1$$fc00$$ENDHEX$$r neue Amyuni Viewer Version
*
* Return Codes:
*/

ii_Page = 0
ii_PageCount = 0

of_set_page()
of_set_zoom()

p_print.Enabled = false
p_save.Enabled = false
p_web.Enabled = false
p_z_in.Enabled = false
p_z_out.Enabled = false
p_first.Enabled = false
p_prev.Enabled = false
p_next.Enabled = false
p_last.Enabled = false

is_CurrentFile = ""

return 0
end function

private function integer of_set_marker (picture ap_pic);/* 
* Funktion: of_set_marker
* Beschreibung: Setzt das Markier-Objekt f$$HEX1$$fc00$$ENDHEX$$r ein Bild
* Besonderheit: keine
*
* Argumente:
* 	Name   Beschreibung
*  ap_Pic Das Bild, f$$HEX1$$fc00$$ENDHEX$$r welches das Markier-Objekt gesetzt werden soll
*
* Aenderungshistorie:
* 	Version    Wer         Wann          Was und warum
*	1.0        O.Hoefer    28.08.2008    Erstellung
*  1.1        D.Bunk      31.01.2013    Anpassungen f$$HEX1$$fc00$$ENDHEX$$r neue Amyuni Viewer Version
*
* Return Codes:
*   0: OK
*/

st_marker.X = ap_Pic.X - 4
st_marker.Y = ap_Pic.Y - 4
st_marker.Width = ap_Pic.Width + 14
st_marker.Height = ap_Pic.Height + 8
st_marker.Visible = true
st_marker.SetPosition(Behind!, ap_Pic)

return 0
end function

on uo_display_pdf.create
this.em_change=create em_change
this.p_save=create p_save
this.p_print=create p_print
this.p_mail=create p_mail
this.p_web=create p_web
this.p_acrobat=create p_acrobat
this.p_excel=create p_excel
this.p_z_out=create p_z_out
this.p_z_in=create p_z_in
this.em_zoom=create em_zoom
this.p_hide=create p_hide
this.p_last=create p_last
this.p_next=create p_next
this.p_prev=create p_prev
this.p_first=create p_first
this.ln_1=create ln_1
this.ln_2=create ln_2
this.st_1=create st_1
this.ln_8=create ln_8
this.ln_9=create ln_9
this.st_7=create st_7
this.ln_3=create ln_3
this.ln_33=create ln_33
this.ln_144=create ln_144
this.ln_155=create ln_155
this.ln_4=create ln_4
this.ln_5=create ln_5
this.ln_18=create ln_18
this.ln_19=create ln_19
this.ln_6=create ln_6
this.ln_7=create ln_7
this.ln_14=create ln_14
this.ln_15=create ln_15
this.ln_16=create ln_16
this.ln_17=create ln_17
this.ln_20=create ln_20
this.ln_21=create ln_21
this.st_marker=create st_marker
this.tab_fake_container=create tab_fake_container
this.ln_10=create ln_10
this.Control[]={this.em_change,&
this.p_save,&
this.p_print,&
this.p_mail,&
this.p_web,&
this.p_acrobat,&
this.p_excel,&
this.p_z_out,&
this.p_z_in,&
this.em_zoom,&
this.p_hide,&
this.p_last,&
this.p_next,&
this.p_prev,&
this.p_first,&
this.ln_1,&
this.ln_2,&
this.st_1,&
this.ln_8,&
this.ln_9,&
this.st_7,&
this.ln_3,&
this.ln_33,&
this.ln_144,&
this.ln_155,&
this.ln_4,&
this.ln_5,&
this.ln_18,&
this.ln_19,&
this.ln_6,&
this.ln_7,&
this.ln_14,&
this.ln_15,&
this.ln_16,&
this.ln_17,&
this.ln_20,&
this.ln_21,&
this.st_marker,&
this.tab_fake_container,&
this.ln_10}
end on

on uo_display_pdf.destroy
destroy(this.em_change)
destroy(this.p_save)
destroy(this.p_print)
destroy(this.p_mail)
destroy(this.p_web)
destroy(this.p_acrobat)
destroy(this.p_excel)
destroy(this.p_z_out)
destroy(this.p_z_in)
destroy(this.em_zoom)
destroy(this.p_hide)
destroy(this.p_last)
destroy(this.p_next)
destroy(this.p_prev)
destroy(this.p_first)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.st_1)
destroy(this.ln_8)
destroy(this.ln_9)
destroy(this.st_7)
destroy(this.ln_3)
destroy(this.ln_33)
destroy(this.ln_144)
destroy(this.ln_155)
destroy(this.ln_4)
destroy(this.ln_5)
destroy(this.ln_18)
destroy(this.ln_19)
destroy(this.ln_6)
destroy(this.ln_7)
destroy(this.ln_14)
destroy(this.ln_15)
destroy(this.ln_16)
destroy(this.ln_17)
destroy(this.ln_20)
destroy(this.ln_21)
destroy(this.st_marker)
destroy(this.tab_fake_container)
destroy(this.ln_10)
end on

event constructor;integer i

ip_Pic[1] = p_first
ip_Pic[2] = p_prev
ip_Pic[3] = p_next
ip_Pic[4] = p_last
ip_Pic[5] = p_hide
ip_Pic[6] = p_z_out
ip_Pic[7] = p_z_in
ip_Pic[8] = p_excel
ip_Pic[9] = p_acrobat
ip_Pic[10] = p_web
ip_Pic[11] = p_mail
ip_Pic[12] = p_print
ip_Pic[13] = p_save

for i = 1 to UpperBound(ip_Pic)
	ip_Pic[i].enabled = false
next

// Erstmal nur das Interface Objekt f$$HEX1$$fc00$$ENDHEX$$r den Viewer erzeugen.
// Beim $$HEX1$$f600$$ENDHEX$$ffnen des Dokuments, wird dann das richtige Objekt erzeugt.
// Das erzeugen, des eigentlich Viewer Objekts darf erst dann passieren,
// weil es sonst zu Problemen kommt.
iuo_viewer = CREATE uo_amyuni_viewer_interface

// Bei sehr kleinen Fenstern ist es notwendig, 
// dass die Toolbar auf die n$$HEX1$$e400$$ENDHEX$$chste Zeile umgebrochen werden muss
if width < 1500 then of_thin()

// Zoomwert aus dem Profil auslesen und setzen
ii_Zoom = Integer(ProfileString(s_app.sProfile, "PrintPreview", "Zoomfactor", "100" ))
of_set_zoom()
end event

event destructor;DESTROY iuo_viewer
end event

type em_change from editmask within uo_display_pdf
integer x = 750
integer y = 40
integer width = 256
integer height = 68
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean border = false
alignment alignment = center!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxx"
end type

event modified;integer li_Input

li_Input = Integer(this.Text)

if li_Input >= 1 and li_Input <= ii_PageCount then
	ii_Page = li_Input
end if

of_set_page()
end event

type p_save from picture within uo_display_pdf
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 1303
integer y = 32
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_save.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	of_set_marker(this)

	for i = 1 to UpperBound(ip_Pic)
		if ip_Pic[i] = this then
			ip_Pic[i].tag = "ON"
		else
			ip_Pic[i].tag = "OFF"
		end if
	next

end if
end event

event ue_enable;Integer i

if enable then
	this.picturename = "..\Resource\report_save.gif"
else
	this.picturename = "..\Resource\report_save_disabled.gif"
end if

this.enabled = enable





end event

event clicked;string ls_Pathname, ls_Filename, ls_Text, ls_Dir
integer li_Return

ls_Text = uf.translate("Speichern unter")

if ib_Use_Current_File_For_Save AND is_Save_as_Name > "" then		
	li_Return = GetFileSaveName(ls_Text, is_Save_as_Name, ls_FileName, "Adobe", "Adobe PDF-Dateien (*.pdf),*.pdf,")
	
	// 02.11.2010 HR: F$$HEX1$$fc00$$ENDHEX$$r die weitere Verarbeitung muss das hier gespeichert werden
	ls_Pathname = is_Save_as_Name
else
	li_Return = GetFileSaveName(ls_Text, ls_Pathname, ls_Filename, "Adobe","Adobe PDF-Dateien (*.pdf),*.pdf,")
end if

ls_Dir = f_getcurrentdirectory()

if li_Return = 1 then 
	s_app.sSavePath = f_getpathname(ls_Pathname)
	
	if FileExists(ls_Pathname) then
		if uf.mbox("", "Die Datei:~r~r${" + ls_Pathname + "}~r~r existiert bereits.~r~r Wollen Sie die Datei $$HEX1$$fc00$$ENDHEX$$berschreiben?", Question!, YesNo!, 1) = 2 then
			return 0
		end if
	end if
	
	FileCopy(is_CurrentFile, ls_Pathname, true)
end if

f_sethomedirectory()

return 0
end event

type p_print from picture within uo_display_pdf
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 1481
integer y = 32
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_print.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	of_set_marker(this)

	for i = 1 to UpperBound(ip_Pic)
		if ip_Pic[i] = this then
			ip_Pic[i].tag = "ON"
		else
			ip_Pic[i].tag = "OFF"
		end if
	next

end if

end event

event clicked;long i

// Den Druck einstellen
istr_Print.lMaxPage	= ii_PageCount
istr_Print.lCurrentPage = ii_Page

OpenWithParm(w_report_printer_setting_pdf, istr_Print)
istr_Print = Message.PowerObjectParm

// Der eigentliche Druck
SetPointer(HourGlass!)

// Kopien beachten
for i = 1 to istr_Print.lCopies
	iuo_viewer.of_print(istr_Print.sPrinter)
next

SetPointer(Arrow!)
end event

type p_mail from picture within uo_display_pdf
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
boolean visible = false
integer x = 2185
integer y = 32
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_mail.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	of_set_marker(this)

	for i = 1 to UpperBound(ip_Pic)
		if ip_Pic[i] = this then
			ip_Pic[i].tag = "ON"
		else
			ip_Pic[i].tag = "OFF"
		end if
	next

end if
end event

event ue_enable;if enable then
	this.picturename = "..\Resource\report_mail.gif"
else
	this.picturename = "..\Resource\report_mail_disabled.gif"
end if



end event

type p_web from picture within uo_display_pdf
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
boolean visible = false
integer x = 2304
integer y = 32
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_web.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	of_set_marker(this)

	for i = 1 to UpperBound(ip_Pic)
		if ip_Pic[i] = this then
			ip_Pic[i].tag = "ON"
		else
			ip_Pic[i].tag = "OFF"
		end if
	next

end if
end event

type p_acrobat from picture within uo_display_pdf
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
boolean visible = false
integer x = 2066
integer y = 32
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_acrobat.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	of_set_marker(this)

	for i = 1 to UpperBound(ip_Pic)
		if ip_Pic[i] = this then
			ip_Pic[i].tag = "ON"
		else
			ip_Pic[i].tag = "OFF"
		end if
	next

end if
end event

event ue_enable;if enable then
	this.picturename = "..\Resource\report_acrobat.gif"
else
	this.picturename = "..\Resource\report_acrobat_disabled.gif"
end if


end event

type p_excel from picture within uo_display_pdf
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
boolean visible = false
integer x = 1947
integer y = 32
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_excel.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	of_set_marker(this)

	for i = 1 to UpperBound(ip_Pic)
		if ip_Pic[i] = this then
			ip_Pic[i].tag = "ON"
		else
			ip_Pic[i].tag = "OFF"
		end if
	next

end if

end event

event ue_enable;if enable then
	this.picturename = "..\Resource\report_excel.gif"
else
	this.picturename = "..\Resource\report_excel_disabled.gif"
end if


end event

type p_z_out from picture within uo_display_pdf
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 352
integer y = 32
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_zoomout.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	of_set_marker(this)

	for i = 1 to UpperBound(ip_Pic)
		if ip_Pic[i] = this then
			ip_Pic[i].tag = "ON"
		else
			ip_Pic[i].tag = "OFF"
		end if
	next

end if
end event

event ue_enable;if enable then
	this.picturename = "..\Resource\report_zoomout.gif"
else
	this.picturename = "..\Resource\report_zoomout_disabled.gif"
end if


end event

event clicked;ii_Zoom += 10 
if ii_Zoom > 1000 then ii_Zoom = 1000
of_set_zoom()
end event

type p_z_in from picture within uo_display_pdf
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 37
integer y = 32
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\report_zoomin.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	of_set_marker(this)

	for i = 1 to UpperBound(ip_Pic)
		if ip_Pic[i] = this then
			ip_Pic[i].tag = "ON"
		else
			ip_Pic[i].tag = "OFF"
		end if
	next

end if


end event

event ue_enable;if enable then
	this.picturename = "..\Resource\report_zoomin.gif"
else
	this.picturename = "..\Resource\report_zoomin_disabled.gif"
end if


end event

event clicked;ii_Zoom -= 10 
if ii_Zoom < 10 then ii_Zoom = 10
of_set_zoom()
end event

type em_zoom from editmask within uo_display_pdf
integer x = 160
integer y = 40
integer width = 165
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "74"
boolean border = false
alignment alignment = center!
maskdatatype maskdatatype = stringmask!
end type

event modified;integer li_Input
string ls_Text

ls_Text = Trim(this.Text)
if Right(ls_Text, 1) = "%" then ls_Text = Mid(ls_Text, 1, Len(ls_Text) - 1)

li_Input = Integer(ls_Text)

if li_Input >= 10 and li_Input <= 1000 then 
	ii_Zoom = li_Input
end if

of_set_zoom()
end event

type p_hide from picture within uo_display_pdf
event ue_mouse_move pbm_mousemove
boolean visible = false
integer x = 1829
integer y = 32
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\page_last.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	of_set_marker(this)

	for i = 1 to UpperBound(ip_Pic)
		if ip_Pic[i] = this then
			ip_Pic[i].tag = "ON"
		else
			ip_Pic[i].tag = "OFF"
		end if
	next

end if

end event

type p_last from picture within uo_display_pdf
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 1147
integer y = 32
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\page_last.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	of_set_marker(this)

	for i = 1 to UpperBound(ip_Pic)
		if ip_Pic[i] = this then
			ip_Pic[i].tag = "ON"
		else
			ip_Pic[i].tag = "OFF"
		end if
	next

end if
end event

event ue_enable;if enable then
	this.picturename = "..\Resource\page_last.gif"
else
	this.picturename = "..\Resource\page_last_disabled.gif"
end if


end event

event clicked;if ii_PageCount > 0 then
	ii_Page = ii_PageCount
	of_set_page()
end if

return 0
end event

type p_next from picture within uo_display_pdf
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 1033
integer y = 32
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\page_next.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	of_set_marker(this)

	for i = 1 to UpperBound(ip_Pic)
		if ip_Pic[i] = this then
			ip_Pic[i].tag = "ON"
		else
			ip_Pic[i].tag = "OFF"
		end if
	next

end if
end event

event ue_enable;if enable then
	this.picturename = "..\Resource\page_next.gif"
else
	this.picturename = "..\Resource\page_next_disabled.gif"
end if


end event

event clicked;if ii_Page < ii_PageCount then
	ii_Page ++
	of_set_page()
end if

return 0
end event

type p_prev from picture within uo_display_pdf
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 622
integer y = 32
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\page_prev.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	of_set_marker(this)

	for i = 1 to UpperBound(ip_Pic)
		if ip_Pic[i] = this then
			ip_Pic[i].tag = "ON"
			
		else
			ip_Pic[i].tag = "OFF"
		end if
	next

end if
end event

event ue_enable;if enable then
	this.picturename = "..\Resource\page_prev.gif"
else
	this.picturename = "..\Resource\page_prev_disabled.gif"
end if


end event

event clicked;if ii_Page > 1 then
	ii_Page --
	of_set_page()
end if

return 0
end event

type p_first from picture within uo_display_pdf
event ue_mouse_move pbm_mousemove
event ue_enable pbm_enable
integer x = 512
integer y = 32
integer width = 91
integer height = 80
boolean originalsize = true
string picturename = "..\Resource\page_first.gif"
boolean focusrectangle = false
end type

event ue_mouse_move;integer i

if this.Tag <> "ON" then
	of_set_marker(this)

	for i = 1 to UpperBound(ip_Pic)
		if ip_Pic[i] = this then
			ip_Pic[i].tag = "ON"
		else
			ip_Pic[i].tag = "OFF"
		end if
	next

end if
end event

event ue_enable;if enable then
	this.picturename = "..\Resource\page_first.gif"
else
	this.picturename = "..\Resource\page_first_disabled.gif"
end if

return 0


end event

event clicked;if ii_Page > 0 then 
	ii_Page = 1
	of_set_page()
end if

return 0
end event

type ln_1 from line within uo_display_pdf
long linecolor = 8421504
integer linethickness = 1
integer beginx = 146
integer beginy = 28
integer endx = 329
integer endy = 28
end type

type ln_2 from line within uo_display_pdf
long linecolor = 8421504
integer linethickness = 1
integer beginx = 146
integer beginy = 32
integer endx = 146
integer endy = 112
end type

type st_1 from statictext within uo_display_pdf
integer x = 151
integer y = 32
integer width = 183
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean focusrectangle = false
end type

type ln_8 from line within uo_display_pdf
long linecolor = 8421504
integer linethickness = 1
integer beginx = 741
integer beginy = 28
integer endx = 1006
integer endy = 28
end type

type ln_9 from line within uo_display_pdf
long linecolor = 8421504
integer linethickness = 1
integer beginx = 741
integer beginy = 32
integer endx = 741
integer endy = 112
end type

type st_7 from statictext within uo_display_pdf
integer x = 745
integer y = 32
integer width = 261
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean focusrectangle = false
end type

type ln_3 from line within uo_display_pdf
long linecolor = 8421504
integer linethickness = 1
integer beginx = 471
integer beginy = 12
integer endx = 471
integer endy = 136
end type

type ln_33 from line within uo_display_pdf
long linecolor = 16777215
integer linethickness = 1
integer beginx = 475
integer beginy = 12
integer endx = 475
integer endy = 132
end type

type ln_144 from line within uo_display_pdf
boolean visible = false
long linecolor = 8421504
integer linethickness = 1
integer beginx = 2386
integer beginy = 164
integer endx = 2267
integer endy = 164
end type

type ln_155 from line within uo_display_pdf
boolean visible = false
long linecolor = 16777215
integer linethickness = 1
integer beginx = 2386
integer beginy = 168
integer endx = 2272
integer endy = 168
end type

type ln_4 from line within uo_display_pdf
long linecolor = 8421504
integer linethickness = 1
integer beginx = 9
integer beginy = 132
integer endx = 32009
integer endy = 132
end type

type ln_5 from line within uo_display_pdf
long linecolor = 16777215
integer linethickness = 1
integer beginx = 9
integer beginy = 136
integer endx = 32009
integer endy = 136
end type

type ln_18 from line within uo_display_pdf
long linecolor = 16777215
integer linethickness = 1
integer beginx = 9
integer beginy = 8
integer endx = 32009
integer endy = 8
end type

type ln_19 from line within uo_display_pdf
long linecolor = 8421504
integer linethickness = 1
integer beginx = 9
integer beginy = 4
integer endx = 32009
integer endy = 4
end type

type ln_6 from line within uo_display_pdf
long linecolor = 8421504
integer linethickness = 1
integer beginx = 1266
integer beginy = 12
integer endx = 1266
integer endy = 136
end type

type ln_7 from line within uo_display_pdf
long linecolor = 16777215
integer linethickness = 1
integer beginx = 1271
integer beginy = 12
integer endx = 1271
integer endy = 132
end type

type ln_14 from line within uo_display_pdf
long linecolor = 8421504
integer linethickness = 1
integer beginx = 1435
integer beginy = 12
integer endx = 1435
integer endy = 136
end type

type ln_15 from line within uo_display_pdf
long linecolor = 16777215
integer linethickness = 1
integer beginx = 1440
integer beginy = 12
integer endx = 1440
integer endy = 132
end type

type ln_16 from line within uo_display_pdf
long linecolor = 8421504
integer linethickness = 1
integer beginx = 1623
integer beginy = 12
integer endx = 1623
integer endy = 136
end type

type ln_17 from line within uo_display_pdf
long linecolor = 16777215
integer linethickness = 1
integer beginx = 1627
integer beginy = 12
integer endx = 1627
integer endy = 132
end type

type ln_20 from line within uo_display_pdf
long linecolor = 8421504
integer linethickness = 1
integer beginx = 5
integer beginy = 4
integer endx = 5
integer endy = 136
end type

type ln_21 from line within uo_display_pdf
long linecolor = 16777215
integer linethickness = 1
integer beginx = 9
integer beginy = 12
integer endx = 9
integer endy = 132
end type

type st_marker from statictext within uo_display_pdf
boolean visible = false
integer x = 2505
integer y = 12
integer width = 101
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

type tab_fake_container from tab within uo_display_pdf
integer x = 9
integer y = 136
integer width = 1266
integer height = 892
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean focusonbuttondown = true
boolean showtext = false
boolean showpicture = false
tabposition tabposition = tabsonbottom!
integer selectedtab = 1
end type

type ln_10 from line within uo_display_pdf
long linecolor = 8421504
integer linethickness = 4
integer beginx = 5
integer beginy = 136
integer endx = 5
integer endy = -32768
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
09uo_display_pdf.bin 
2300000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000004b883be001ccb429fffffffe000000000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003525ca8d54aed81ee4d9c5cb90b98d5ba000000004b883be001ccb4294b883be001ccb429000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
19uo_display_pdf.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
