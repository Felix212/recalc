HA$PBExportHeader$w_report_preview_master.srw
forward
global type w_report_preview_master from window
end type
type tab_1 from tab within w_report_preview_master
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from uo_tree_detail_datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tab_excel from userobject within tab_1
end type
type ole_excel from olecustomcontrol within tab_excel
end type
type tab_excel from userobject within tab_1
ole_excel ole_excel
end type
type tab_acrobat from userobject within tab_1
end type
type uo_pdf_viewer from uo_display_pdf within tab_acrobat
end type
type tab_acrobat from userobject within tab_1
uo_pdf_viewer uo_pdf_viewer
end type
type tab_html from userobject within tab_1
end type
type ole_browser from olecustomcontrol within tab_html
end type
type tab_html from userobject within tab_1
ole_browser ole_browser
end type
type tab_1 from tab within w_report_preview_master
tabpage_1 tabpage_1
tab_excel tab_excel
tab_acrobat tab_acrobat
tab_html tab_html
end type
type uo_tools from uo_report_preview_toolbar within w_report_preview_master
end type
type uo_statusbar from uo_comctl_statusbar within w_report_preview_master
end type
type pb_exit from picturebutton within w_report_preview_master
end type
type pb_print from picturebutton within w_report_preview_master
end type
type pb_open from picturebutton within w_report_preview_master
end type
type pb_save from picturebutton within w_report_preview_master
end type
type st_22 from statictext within w_report_preview_master
end type
type st_221 from statictext within w_report_preview_master
end type
type st_222 from statictext within w_report_preview_master
end type
type st_23 from statictext within w_report_preview_master
end type
end forward

global type w_report_preview_master from window
integer width = 3922
integer height = 2760
boolean titlebar = true
string title = "Druckvorschau"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
tab_1 tab_1
uo_tools uo_tools
uo_statusbar uo_statusbar
pb_exit pb_exit
pb_print pb_print
pb_open pb_open
pb_save pb_save
st_22 st_22
st_221 st_221
st_222 st_222
st_23 st_23
end type
global w_report_preview_master w_report_preview_master

type variables
s_print_preview 			strPreview
uo_tree_detail_datawindow		dw_1

string	sExcelFile		= ""
string	sAcrobatFile	= ""
string	sHTMLFile		= ""

Integer	iDoneExcel
Integer	iAcrobat
Integer	iHTML

string 	sDefaultPrinter
end variables

forward prototypes
public function integer wf_set_status_message (integer ipart, string smsg)
public function integer wf_run_report ()
public function string wf_format_logo ()
end prototypes

public function integer wf_set_status_message (integer ipart, string smsg);
uo_StatusBar.of_SetText( iPart, 0, uf.translate(sMsg))

return 0
end function

public function integer wf_run_report ();String					sClassName
uo_report_ancestor	uoReport
Integer 					iRet
Blob 						bDatawindow, &
							bData
							
String 					sDatawindow, &
							sErrors, &
							sDW
							
Long 						lStart, &
							lEnde	

String sCreate, sUnits

// ----------------------------------------
// Klassennamen suchen
// ----------------------------------------
 SELECT sys_report_objects.cobject_name,
		  sys_reports.cdatawindow_name  
  INTO :sClassName , :sDW 
  FROM sys_report_objects,   
       sys_reports  
 WHERE ( sys_reports.nreport_object_id = sys_report_objects.nreport_object_id ) and  
       ( ( sys_reports.nreport_id = :strPreview.lReportID ) )   ;

if SQLCA.SQLCODE = 0 Then
	// ----------------------------------------
	// Klassennamen erzeugen
	// ----------------------------------------
	uoReport = CREATE USING sClassName
	
	if isNull(uoReport) or not isValid(uoReport)  then
		uf.mbox("Achtung", "Ung$$HEX1$$fc00$$ENDHEX$$ltiger Klassennamen zugeordnet, bzw. Klasse konnte nicht erstellt werden!", StopSign!)
		return -1
	end if
	
	// ----------------------------------------
	// Report-ID setzten
	// ----------------------------------------
	uoReport.lReportID = strPreview.lReportID
	
	// -------------------------------------------
	// Das Datawindow aus der Datenbank holen ...
	// -------------------------------------------
	selectblob sys_reports.bDatawindow
		   into :bDatawindow
		   from sys_reports
		  where sys_reports.nreport_id = :strPreview.lReportID;
		
	if sqlca.sqlcode <> 0 then
		uf.Mbox("Achtung", "Fehler beim Erstellen der Datawindows!", StopSign!)
		f_db_error(sqlca, "SELECTBLOB")
		return -1
	end if

	// -------------------------------------------
	// ... und dann erstellen 
	// -------------------------------------------
	
	sDatawindow = String(bDatawindow)
	
	if uoReport.of_Create(sDatawindow) <> 0 then
		uf.mbox("Achtung", "Die Erstellung des Reports ist fehlgeschlagen. ~r~r ${" + uoReport.sErrorMessage + "}", StopSign!)
		return -1
	end if
	
	uoReport.SetTransObject(sqlca)
	uoReport.of_retrieve()
	
	// ------------------------------------------------
	// User hat im Auswahldialog abgebrochen
	// ------------------------------------------------
	if uoReport.bSuccessful = False then 
		Destroy(uoReport)
		return -1
	end if
	
	// ------------------------------------------------
	// Es sind Daten im Report und es soll sofort 
	// gedruckt werden ....
	// ------------------------------------------------
	if uoReport.RowCount() > 0 and uoReport.iPrintDirectly = 1 then
		uoReport.Print()
		Destroy(uoReport)
		return -1
	end if
	
	
	if uoReport.RowCount() > 0 then
		sDataWindow = uoReport.Describe("datawindow.syntax")
		dw_1.Create(sDatawindow, sErrors)
		
		if uoReport.GetFullState(bData) >= 0 then
			dw_1.SetFullState(bData)
		end if
		
		//dw_1.Modify("p_logo.filename='" + uoReport.of_picturename() + "'"  )
		wf_format_logo()
		
		
	end if
	
elseif SQLCA.SQLCODE = 100 Then
	
	uf.mbox("Achtung", "Klassennamen nicht gefunden!", StopSign!)
	return -1
	
elseif SQLCA.SQLCODE <> 0 Then
	
	f_db_error(sqlca, "wf_run_report")
	return -1
	
	
end if 

Destroy(uoReport)

return 0
end function

public function string wf_format_logo ();//----------------------------------------------------------------
//Holt den Namen und Pfad vom Temp Bild f$$HEX1$$fc00$$ENDHEX$$r den Report
//----------------------------------------------------------------

String 	sTempPath
String 	sLogoPathPictureName
String 	sPicture
String   sPictureName
integer 	i

sPicture = tab_1.tabpage_1.dw_1.Describe("p_logo.filename")

sTempPath = f_gettemppath()

for i = LenA(sPicture) to 1 step -1
	
	if MidA(sPicture, i ,1) = "\" then
		exit
	end if
	
next

if i <> 0 then
	sPictureName = MidA(sPicture, i + 1)
	sLogoPathPictureName = sTempPath + sPictureName
	tab_1.tabpage_1.dw_1.Modify("p_logo.filename='" + sLogoPathPictureName + "'"  )
	//Messagebox("",sLogoPathPictureName)
end if

return sLogoPathPictureName

end function

event open;long	llParts[3]

llParts[1] = UnitsToPixels(this.width, YUnitsToPixels!) / 100 * 50
llParts[2] = llParts[1] + UnitsToPixels(this.width, YUnitsToPixels!) / 100 * 20
llParts[3] = -1
uo_StatusBar.of_SetParts( llParts[] )
uo_StatusBar.of_SetText( 0, 0, "Ready" )
uo_StatusBar.of_SetText( 1, 0, "" )
uo_StatusBar.of_SetText( 2, 0, String(Today(),s_app.sDateformat))

dw_1 = tab_1.tabpage_1.dw_1

dw_1.width = 3813
dw_1.height = 2256
dw_1.x = 0
dw_1.y = 8

tab_1.tab_excel.ole_excel.width = 3813
tab_1.tab_excel.ole_excel.height = 2256
tab_1.tab_excel.ole_excel.x = 0
tab_1.tab_excel.ole_excel.y = 8

strPreview = Message.PowerObjectParm

if strPreview.lReportID > 0 then
	
	if wf_run_report() <> 0 then
		close(this)
		return 1
	end if
	
elseif not isnull(strPreview.bData) then
	
	dw_1.SetFullState(strPreview.bData)
	wf_format_logo()
		
end if

uf.translate_window(this)
f_centerwindow(this)



dw_1.Modify("datawindow.print.preview = YES") 
dw_1.Modify("datawindow.print.preview.rulers = YES") 

uf.translate_datawindow(dw_1)	
uo_tools.oDW = dw_1
uo_tools.of_init()

// -----------------------------------
// sDefaultPrinter merken
// -----------------------------------
sDefaultPrinter = f_get_printer()




end event

on w_report_preview_master.create
this.tab_1=create tab_1
this.uo_tools=create uo_tools
this.uo_statusbar=create uo_statusbar
this.pb_exit=create pb_exit
this.pb_print=create pb_print
this.pb_open=create pb_open
this.pb_save=create pb_save
this.st_22=create st_22
this.st_221=create st_221
this.st_222=create st_222
this.st_23=create st_23
this.Control[]={this.tab_1,&
this.uo_tools,&
this.uo_statusbar,&
this.pb_exit,&
this.pb_print,&
this.pb_open,&
this.pb_save,&
this.st_22,&
this.st_221,&
this.st_222,&
this.st_23}
end on

on w_report_preview_master.destroy
destroy(this.tab_1)
destroy(this.uo_tools)
destroy(this.uo_statusbar)
destroy(this.pb_exit)
destroy(this.pb_print)
destroy(this.pb_open)
destroy(this.pb_save)
destroy(this.st_22)
destroy(this.st_221)
destroy(this.st_222)
destroy(this.st_23)
end on

event close;f_filedelete(f_gettemppath(), "PREVIEW*.*", this)
end event

type tab_1 from tab within w_report_preview_master
integer x = 14
integer y = 148
integer width = 3849
integer height = 2408
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tab_excel tab_excel
tab_acrobat tab_acrobat
tab_html tab_html
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tab_excel=create tab_excel
this.tab_acrobat=create tab_acrobat
this.tab_html=create tab_html
this.Control[]={this.tabpage_1,&
this.tab_excel,&
this.tab_acrobat,&
this.tab_html}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tab_excel)
destroy(this.tab_acrobat)
destroy(this.tab_html)
end on

event selectionchanged;
if newindex = 1 then
	uo_tools.p_save.trigger event ue_enable(false)
else
	uo_tools.p_save.trigger event ue_enable(true)
end if

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 128
integer width = 3813
integer height = 2264
long backcolor = 67108864
string text = "Report"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from uo_tree_detail_datawindow within tabpage_1
integer y = 8
integer width = 3813
integer height = 2256
integer taborder = 20
boolean border = true
integer isetdetailheight = 0
end type

event doubleclicked;//
return 
end event

type tab_excel from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 128
integer width = 3813
integer height = 2264
long backcolor = 67108864
string text = "Excel"
long tabtextcolor = 33554432
string picturename = "..\resource\report_excel.gif"
long picturemaskcolor = 536870912
ole_excel ole_excel
end type

on tab_excel.create
this.ole_excel=create ole_excel
this.Control[]={this.ole_excel}
end on

on tab_excel.destroy
destroy(this.ole_excel)
end on

type ole_excel from olecustomcontrol within tab_excel
event statustextchange ( string stext )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean arg_enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string stext )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean arg_cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean arg_cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
integer y = 8
integer width = 3813
integer height = 2256
integer taborder = 50
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_report_preview_master.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type tab_acrobat from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 128
integer width = 3813
integer height = 2264
long backcolor = 67108864
string text = "Acrobat (PDF)"
long tabtextcolor = 33554432
string picturename = "..\resource\report_acrobat.gif"
long picturemaskcolor = 536870912
uo_pdf_viewer uo_pdf_viewer
end type

on tab_acrobat.create
this.uo_pdf_viewer=create uo_pdf_viewer
this.Control[]={this.uo_pdf_viewer}
end on

on tab_acrobat.destroy
destroy(this.uo_pdf_viewer)
end on

type uo_pdf_viewer from uo_display_pdf within tab_acrobat
integer y = 8
integer width = 3808
integer height = 2248
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_pdf_viewer.destroy
call uo_display_pdf::destroy
end on

type tab_html from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 128
integer width = 3813
integer height = 2264
long backcolor = 67108864
string text = "HTML"
long tabtextcolor = 33554432
string picturename = "..\resource\report_web.gif"
long picturemaskcolor = 536870912
ole_browser ole_browser
end type

on tab_html.create
this.ole_browser=create ole_browser
this.Control[]={this.ole_browser}
end on

on tab_html.destroy
destroy(this.ole_browser)
end on

type ole_browser from olecustomcontrol within tab_html
event statustextchange ( string stext )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean arg_enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string stext )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean arg_cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean arg_cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
integer y = 8
integer width = 3813
integer height = 2252
integer taborder = 40
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_report_preview_master.win"
integer binaryindex = 1
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type uo_tools from uo_report_preview_toolbar within w_report_preview_master
integer x = 5
integer y = 12
integer width = 3794
integer height = 116
integer taborder = 40
end type

on uo_tools.destroy
call uo_report_preview_toolbar::destroy
end on

event ue_message(string smessage);call super::ue_message;uo_StatusBar.of_SetText(0, 0, uf.translate(sMessage))
end event

event ue_excel;call super::ue_excel;uo_Excel oExcel

if iDoneExcel = 0 then

	oExcel = Create uo_Excel
	
	sExcelFile = f_gettemppath() + "PREVIEW-EXCEL" + String(Rand(32767)) + String(now(), "hhmmss") + ".XLS"
	
	oExcel.sReportHeader1 = f_check_null(strPreview.sExcelText1)
	oExcel.sReportHeader2 = f_check_null(strPreview.sExcelText2)
	oExcel.sReportHeader3 = f_check_null(strPreview.sExcelText3)
	oExcel.sReportHeader4 = f_check_null(strPreview.sExcelText4)
	
	oExcel.of_export(dw_1,  sExcelFile)
	
	if FileExists(sExcelFile) then
		iDoneExcel = 1
		tab_1.tab_excel.Visible = True
		tab_1.tab_excel.ole_excel.object.Navigate(sExcelFile)
		tab_1.SelectedTab = 2
	else
		iDoneExcel = 0
	end if
	
elseif iDoneExcel = 1 then
	
	if FileExists(sExcelFile) then
		iDoneExcel = 1
		tab_1.tab_excel.Visible = True
		tab_1.SelectedTab = 2
	else
		iDoneExcel = 0
	end if

end if

destroy oExcel
end event

event ue_web();call super::ue_web;
if iHTML = 0 then
	
	sHTMLFile = f_gettemppath() + "PREVIEW-HTML" + String(Rand(32767)) + String(now(), "hhmmss") + ".HTML"
	dw_1.SaveAs(sHTMLFile, HTMLTable!, TRUE)	
	
	if FileExists(sHTMLFile) then
		iHTML = 1
		tab_1.tab_html.ole_browser.object.Navigate(sHTMLFile)
		tab_1.tab_html.Visible = True
		tab_1.SelectedTab = 4
	else
		iHTML = 0
	end if
	
elseif iHTML = 1 then
	
	if FileExists(sHTMLFile) then
		iHTML = 1
		tab_1.tab_html.Visible = True
		tab_1.SelectedTab = 4
	else
		iHTML = 0
	end if

end if

end event

event ue_acrobat;call super::ue_acrobat;// ---------------------------------
// lOpenFlags
// 1 = Toolbar
// 2 = ohne Toolbar
// 4 = ohne Alles
// ---------------------------------
long 	lOpenFlags 		= 1
// ---------------------------------

//	lZoomType
// 0 = Zoom via Application
// 2 = Default
// ---------------------------------
long 	lZoomType		= 2

String sDefault

if iAcrobat = 0 then
	dw_1.Describe("datawindow.printer='" + sAcrobatPrinter + "'")
		
	SetPointer(Hourglass!)
	
	sAcrobatFile = f_gettemppath() + "PREVIEW-ACROBAT" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
	sAcrobatFile = f_valid_filename(sAcrobatFile)	
	
	if s_app.uo_PDF.of_convert(dw_1, "ReportPreview", sAcrobatFile) <> 0 then
		SetPointer(Arrow!)
		uf.mbox("Achtung", "Fehler beim Erzeugen der PDF-Datei. [4]", StopSign!)
		return
	end if	
	
	if FileExists(sAcrobatFile) then
		iAcrobat = 1
		tab_1.tab_acrobat.uo_pdf_viewer.of_open(sAcrobatFile)
		tab_1.tab_acrobat.Visible = True
		tab_1.SelectedTab = 3
	end if
	
	// 18.01.2012 OH Performance
	f_set_printer(sDefaultPrinter)
	SetPointer(Arrow!)
	
elseif iAcrobat = 1 then
	
	if FileExists(sAcrobatFile) then
		iAcrobat = 1
		tab_1.tab_acrobat.Visible = True
		tab_1.SelectedTab = 3
	else
		iAcrobat = 0
	end if
	
end if
end event

event ue_print();call super::ue_print;s_printer_settings strPrint

strPrint.oDW 				= dw_1
strPrint.lMaxPage			= uo_tools.iPageCount
strPrint.lCurrentPage 	= uo_tools.iPage


OpenWithParm(w_report_printer_setting, strPrint)


end event

event ue_mail;call super::ue_mail;Long 		a, i
string	sFileNames[]
string	sAttachmentfile, sFlight
uo_mail 	uo_mail_send
string   sText, sSubject
Integer iMode, iCounter
string  srecipient[], sMail	
string  sMsg

if iAcrobat = 0 then 
	this.Trigger Event ue_acrobat()
	if iAcrobat = 0 then 
		return
	end if
end if

uo_mail_send = create uo_mail
sAttachmentfile = f_gettemppath() + "CBASE-Report.Zip"

sFileNames[1] 	= sAcrobatFile
sSubject  		= ""
sText     		= ""
sFlight   		= ""					
iMode =  2
uo_mail_send.uf_create_mail(srecipient, sFlight,sFileNames,sAttachmentfile,iMode, sSubject, sText)

destroy uo_mail_send
f_setcurrentdirectory(s_app.scurrentdirectory)
filedelete(sAttachmentfile)
end event

event ue_save();call super::ue_save;string 	sPathname, sFilename, sText, sDir
integer	iReturn

if not isnull(s_app.sSavePath) and s_app.sSavePath <> "" then
	f_setcurrentdirectory(s_app.sSavePath)
end if

// --------------------------------------------
// Exceldatei speichern
// --------------------------------------------
if tab_1.SelectedTab = 2 then

	if iDoneExcel = 1 and FileExists(sExcelFile) then

		sText = uf.translate("Speichern unter")
				
		iReturn = GetFileSaveName(sText,sPathname,sFilename,"Excel","Microsoft Excel (*.xls),*.xls,")

		sDir = f_getcurrentdirectory()
		
		IF iReturn = 1 THEN 
			s_app.sSavePath = f_getpathname(sPathname)
			CopyFileA(sExcelFile, sPathname, false)
			f_sethomedirectory()
		End if

	end if

end if

// --------------------------------------------
// Adobedatei speichern
// --------------------------------------------
if tab_1.SelectedTab = 3 then

	if iAcrobat = 1 and FileExists(sAcrobatFile) then

		sText = uf.translate("Speichern unter")
				
		iReturn = GetFileSaveName(sText,sPathname,sFilename,"Adobe","Adobe PDF-Dateien (*.pdf),*.pdf,")

		sDir = f_getcurrentdirectory()
		
		IF iReturn = 1 THEN 
			s_app.sSavePath = f_getpathname(sPathname)
			CopyFileA(sAcrobatFile, sPathname, false)
			f_sethomedirectory()
		End if

	end if

end if



f_sethomedirectory()

return
end event

type uo_statusbar from uo_comctl_statusbar within w_report_preview_master
integer x = 64
integer y = 2516
integer taborder = 30
end type

type pb_exit from picturebutton within w_report_preview_master
integer x = 3959
integer y = 2400
integer width = 174
integer height = 152
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\door02.gif"
string disabledname = "..\Resource\door02.gif"
alignment htextalign = left!
end type

event clicked;close(parent)

//Integer 	iRet
//
//String 	sPath, &
//			sFile, &
//			sDir
//			
//Blob 		bBlob
//
//sDir = f_GetCurrentDirectory()
//
//iRet = GetFileOpenName("Dateiauswahl",  sPath, sFile, "Blob", "Binary File (*.Blob), *.Blob")
//
//if iRet = 1 then
//	
//	f_file_to_blob(sPath, ref bBlob, true)
//	dw_1.SetFullState(bblob)
//	
//end if
//
//f_SetCurrentDirectory(sDir)
end event

type pb_print from picturebutton within w_report_preview_master
integer x = 3959
integer y = 316
integer width = 174
integer height = 152
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\printer1c.gif"
string disabledname = "..\Resource\printer1c.gif"
alignment htextalign = left!
end type

event clicked;dw_1.Print()
end event

type pb_open from picturebutton within w_report_preview_master
integer x = 3959
integer y = 2212
integer width = 174
integer height = 152
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\book07.gif"
string disabledname = "..\Resource\book07.gif"
alignment htextalign = left!
end type

event clicked;uf.help(handle(parent), parent.classname())


//Integer 	iRet
//
//String 	sPath, &
//			sFile, &
//			sDir
//			
//Blob 		bBlob
//
//sDir = f_GetCurrentDirectory()
//
//iRet = GetFileOpenName("Dateiauswahl",  sPath, sFile, "Blob", "Binary File (*.Blob), *.Blob")
//
//if iRet = 1 then
//	
//	f_file_to_blob(sPath, ref bBlob, true)
//	dw_1.SetFullState(bblob)
//	
//end if
//
//f_SetCurrentDirectory(sDir)
end event

type pb_save from picturebutton within w_report_preview_master
integer x = 3959
integer y = 136
integer width = 174
integer height = 152
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "..\Resource\diskett2.gif"
string disabledname = "..\Resource\diskett2.gif"
alignment htextalign = left!
end type

event clicked;String		sDir, &
				sFileName, &
				sFileTypes, &
				sSaveName, &
				sFile

Integer 		iOpen

Blob 			bBlob

sDir = f_GetCurrentDirectory()

sFileTypes = "Binary File (*.Blob), *.Blob"

iOpen =  GetFileSaveName(uf.translate("Speichern als"),sSaveName, sFile, "Blob", sFileTypes) 

if iOpen <> 1 then	
	return 
end if

if FileExists(sSaveName) then
	if uf.mbox("Achtung", "Vorhandene Datei ${" + sSaveName + "} $$HEX1$$fc00$$ENDHEX$$berschreiben ?" , Question!, YesNo!, 1) = 2 then
		return 
	end if
	
end if

if dw_1.GetFullState(bBlob)  = -1 then
	uf.mbox("Achtung", "Fehler GetFullState()") 
	return
end if
//Messagebox(sSaveName, iOpen)
f_blob_to_file(sSaveName, bBlob)

f_SetCurrentDirectory(sDir)



end event

type st_22 from statictext within w_report_preview_master
integer x = 3954
integer y = 132
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

type st_221 from statictext within w_report_preview_master
integer x = 3954
integer y = 2396
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

type st_222 from statictext within w_report_preview_master
integer x = 3954
integer y = 312
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

type st_23 from statictext within w_report_preview_master
integer x = 3954
integer y = 2208
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


Start of PowerBuilder Binary Data Section : Do NOT Edit
05w_report_preview_master.bin 
2E00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000002de8dc8001cdfa2200000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f000000002de8dc8001cdfa222de8dc8001cdfa22000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
29ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c0000563200003a4b0000000100000005000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c046000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000003400320030002e002e0031003000320033003100310020003a0030003700350031003a0000004c0000563200003a4b0000000100000005000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c046000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000002e0074006900770020006e007800280020002900340028003600390029003800320020002e0034003100300032002e0031003000200033003000310035003a003a003700320031000000200000000000000000000000000000000000000000000000000543000900000000001601c0036c196000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000002de8dc8001cdfa2200000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f000000002de8dc8001cdfa222de8dc8001cdfa22000000000000000000000000004f00430054004e004e004500530054
2900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c0000563200003a300000000100000005000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c046000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000003400320030002e002e0031003000320033003100310020003a0030003700350031003a0000004c0000563200003a300000000100000005000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c046000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000002e0074006900770020006e007800280020002900340028003600390029003800320020002e0034003100300032002e0031003000200033003000310035003a003a003700320031000000200000000000000000000000000000000000000000000000000543000900000000001601c0036c19600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15w_report_preview_master.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
