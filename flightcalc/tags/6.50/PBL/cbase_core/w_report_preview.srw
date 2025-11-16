HA$PBExportHeader$w_report_preview.srw
forward
global type w_report_preview from w_report_preview_master
end type
end forward

global type w_report_preview from w_report_preview_master
integer width = 4622
end type
global w_report_preview w_report_preview

type variables

end variables

event open;long		llParts[3]
string	sPictureFileName

strPreview = Message.PowerObjectParm
this.move(0,0)
this.width = 4622
this.height = 2764
this.setposition(TopMost!)

llParts[1] = UnitsToPixels(this.width, YUnitsToPixels!) / 100 * 50
llParts[2] = llParts[1] + UnitsToPixels(this.width, YUnitsToPixels!) / 100 * 20
llParts[3] = -1
uo_StatusBar.of_SetParts( llParts[] )
uo_StatusBar.of_SetText( 0, 0, "Ready" )
uo_StatusBar.of_SetText( 1, 0, "" )
uo_StatusBar.of_SetText( 2, 0, String(Today(),s_app.sDateformat))

dw_1 = tab_1.tabpage_1.dw_1

if not isnull(strPreview.bData) then
	tab_1.tabpage_1.dw_1.SetFullState(strPreview.bData)
	wf_format_logo()
end if

uf.translate_window(this)

dw_1.Modify("datawindow.print.preview = YES") 
dw_1.Modify("datawindow.print.preview.rulers = YES") 

//uf.translate_datawindow(dw_1)	
uo_tools.oDW = dw_1

if not isnull(strPreview.sReportName) then
	dw_1.tag = strPreview.sReportName
else
	dw_1.tag = ""
end if

uo_tools.iExcel = strPreview.iExcel
uo_tools.of_init()

dw_1.width = 4265
dw_1.height = 2256
dw_1.x = 0
dw_1.y = 8

tab_1.tab_excel.ole_excel.width = 4265
tab_1.tab_excel.ole_excel.height = 2256
tab_1.tab_excel.ole_excel.x = 0
tab_1.tab_excel.ole_excel.y = 8

// -----------------------------------
// sDefaultPrinter merken
// -----------------------------------
sDefaultPrinter = f_get_printer()





end event

on w_report_preview.create
int iCurrent
call super::create
end on

on w_report_preview.destroy
call super::destroy
end on

type tab_1 from w_report_preview_master`tab_1 within w_report_preview
integer x = 32
integer width = 4315
end type

type tabpage_1 from w_report_preview_master`tabpage_1 within tab_1
integer width = 4279
end type

type dw_1 from w_report_preview_master`dw_1 within tabpage_1
integer width = 4265
boolean hscrollbar = true
end type

event dw_1::doubleclicked;//
return 

end event

type tab_excel from w_report_preview_master`tab_excel within tab_1
integer width = 4279
end type

type ole_excel from w_report_preview_master`ole_excel within tab_excel
end type

type tab_acrobat from w_report_preview_master`tab_acrobat within tab_1
integer width = 4279
end type

type uo_pdf_viewer from w_report_preview_master`uo_pdf_viewer within tab_acrobat
integer width = 4274
end type

type tab_html from w_report_preview_master`tab_html within tab_1
integer width = 4279
end type

type ole_browser from w_report_preview_master`ole_browser within tab_html
end type

type uo_tools from w_report_preview_master`uo_tools within w_report_preview
integer x = 0
integer y = 16
integer height = 120
end type

type uo_statusbar from w_report_preview_master`uo_statusbar within w_report_preview
end type

type pb_exit from w_report_preview_master`pb_exit within w_report_preview
integer x = 4402
end type

type pb_print from w_report_preview_master`pb_print within w_report_preview
boolean visible = false
integer x = 4398
boolean enabled = false
end type

type pb_open from w_report_preview_master`pb_open within w_report_preview
integer x = 4402
end type

type pb_save from w_report_preview_master`pb_save within w_report_preview
boolean visible = false
integer x = 4398
boolean enabled = false
end type

type st_22 from w_report_preview_master`st_22 within w_report_preview
boolean visible = false
integer x = 4393
end type

type st_221 from w_report_preview_master`st_221 within w_report_preview
integer x = 4398
end type

type st_222 from w_report_preview_master`st_222 within w_report_preview
boolean visible = false
integer x = 4393
end type

type st_23 from w_report_preview_master`st_23 within w_report_preview
integer x = 4398
end type

