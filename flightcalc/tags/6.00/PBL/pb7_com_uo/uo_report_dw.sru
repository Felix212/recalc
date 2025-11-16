HA$PBExportHeader$uo_report_dw.sru
$PBExportComments$Report Datawindow
forward
global type uo_report_dw from datawindow
end type
type s_setdw from structure within uo_report_dw
end type
end forward

type s_setdw from structure
	boolean		bfilter
	boolean		bfind
	boolean		bsort
	boolean		breadonly
	boolean		bcut
	boolean		bcopy
	boolean		bpaste
end type

shared variables

end variables

global type uo_report_dw from datawindow
integer width = 713
integer height = 364
integer taborder = 1
string dataobject = "dw_report"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylelowered!
event ue_mouseup pbm_lbuttonup
event ue_mouseout pbm_dwnmousemove
event ue_accepttext ( )
end type
global uo_report_dw uo_report_dw

type variables
Public:

uo_setdw 	dw_settings

Private:
string sLastcolumn,sLastsort,sLastTempcolumn
String sLastObject

boolean bFocus
end variables

forward prototypes
public subroutine uf_report_style (string stitle, boolean bdetail)
public function boolean uf_setprinter (string sprintername)
public function boolean uf_setcopies (integer icopies)
public function boolean uf_documentname (string sdocumentname)
public function boolean uf_setcollate (boolean bcollate)
public function boolean uf_setquality (integer iQuality)
public function boolean uf_defaultprinter ()
public function boolean uf_setduplex (boolean bduplexmode)
end prototypes

public subroutine uf_report_style (string stitle, boolean bdetail);	integer iMarginTop,iMarginBottom,iMarginLeft,iMarginRight
	integer iHeaderHeight,iDetailHeight,iFooterHeight,iSummaryHeight
	integer iDWWidth,iDWHeight
// ---------------------------------------------------------------------------
// Welche Orientation ? 1 = Landscape	2 = Portrait
// ---------------------------------------------------------------------------
		
	If this.Object.DataWindow.Print.Orientation = "1" Then
		iDWWidth 	= 29700
		iDWHeight	= 21000
	Elseif this.Object.DataWindow.Print.Orientation = "2" Then
		iDWWidth 	= 21000
		iDWHeight	= 29700
	Else
		Messagebox("Hallo Entwickler","Orientation im Datawindow angeben.")
	End if	
// ---------------------------------------------------------------------------
// Ma$$HEX1$$df00$$ENDHEX$$einheit 1/1000 Zentimeter
// ---------------------------------------------------------------------------
	If this.Object.DataWindow.Units <> "3" Then
		Messagebox("Hallo Entwickler","Reports Units bitte in 1/1000 Zentimeter.")
	End if	
	
	iMarginTop		= integer(this.Object.DataWindow.Print.Margin.Top)
	iMarginBottom	= integer(this.Object.DataWindow.Print.Margin.Bottom)
	iMarginLeft		= integer(this.Object.DataWindow.Print.Margin.Left)
	iMarginRight	= integer(this.Object.DataWindow.Print.Margin.Right)
// ---------------------------------------------------------------------------
// Header.Height und Footer.Height
// ---------------------------------------------------------------------------
	this.Object.DataWindow.Header.Height='1650'
	this.Object.DataWindow.Footer.Height='476'
	this.Object.DataWindow.Summary.Height='0'
	iHeaderheight  = integer(this.Object.DataWindow.Header.Height)
	iFooterheight  = integer(this.Object.DataWindow.Footer.Height)	
	iSummaryHeight = integer(this.Object.DataWindow.Summary.Height)	
// ---------------------------------------------------------------------------
// Optimales Detail errechnen
// ---------------------------------------------------------------------------	
	If bDetail Then
		iDetailheight = iDWHeight - 100 - (iHeaderheight + iFooterheight + iSummaryHeight + iMarginTop + iMarginBottom )
		this.Object.DataWindow.Detail.Height = string(iDetailheight)
	End if
	
// ---------------------------------------------------------------------------
// Layout Header
// ---------------------------------------------------------------------------	
	this.Object.r_top.X 			= "52"
	this.Object.r_top.Width 	= string(iDWwidth - iMarginLeft - iMarginRight - 208)
	this.Object.r_top.Y 			= "52"
	this.Object.r_top.Height 	= "1570"
	
	this.Object.line_top.X1 = string(200 + integer(this.Object.p_logo.Width))
	this.Object.line_top.X2 = string(200 + integer(this.Object.p_logo.Width))
	this.Object.line_top.Y1 = this.Object.r_top.Y
	this.Object.line_top.Y2 = string(integer(this.Object.r_top.Height) + integer(this.Object.line_top.pen.width))
	
	
	this.Object.p_logo.Filename = s_app.sLogo
	this.Object.p_logo.X = "158"
	this.Object.p_logo.Y = "132"
// ---------------------------------------------------------------------------
// Layout Header Page
// ---------------------------------------------------------------------------		
	this.Object.page_t.X	= string(iDWwidth - iMarginLeft - iMarginRight - integer(this.Object.page_t.width) - 156)
	this.Object.page_t.Y = "250"
	this.Object.page_t.text = uf.translate("Seite")
	
	this.Object.c_page.X	= string(iDWwidth - iMarginLeft - iMarginRight - integer(this.Object.c_page.width) - 156)
	this.Object.c_page.Y = "1000"
	
	this.Object.line_top_page_verti.X1 = string(iDWwidth - iMarginLeft - iMarginRight - integer(this.Object.c_page.width) - 170)
	this.Object.line_top_page_verti.X2 = string(iDWwidth - iMarginLeft - iMarginRight - integer(this.Object.c_page.width) - 170)
	this.Object.line_top_page_verti.Y1 = "52"
	this.Object.line_top_page_verti.Y2 = string(integer(this.Object.r_top.Height) + integer(this.Object.line_top_page_verti.pen.width))

	this.Object.line_top_page_horiz.X1 = this.Object.line_top_page_verti.X1
	this.Object.line_top_page_horiz.X2 = this.Object.r_top.Width
	
	this.Object.line_top_page_horiz.Y1 = "800"
	this.Object.line_top_page_horiz.Y2 = "800"
// ---------------------------------------------------------------------------
// Layout Header Title und DocumentName
// ---------------------------------------------------------------------------		
	this.Object.title_t.X		= string(integer(this.Object.line_top.X1) + 100)
	this.Object.title_t.Y 		= "150"
	this.Object.title_t.width 	= string(integer(this.Object.line_top_page_verti.X1) - integer(this.Object.line_top.X1) - 150)
	this.Object.title_t.text 	= sTitle
	this.Object.DataWindow.Print.DocumentName = sTitle

 
// ---------------------------------------------------------------------------
// Layout Footer
// ---------------------------------------------------------------------------
	this.Object.line_bottom.X1 = 52
	this.Object.line_bottom.X2 = string(iDWwidth - iMarginLeft - iMarginRight - 104)
	this.Object.line_bottom.Y1 = this.Object.line_bottom.pen.width
	this.Object.line_bottom.Y2 = this.Object.line_bottom.pen.width
	
	this.Object.signature_t.X		= 52
	this.Object.signature_t.width	= "6000"
	this.Object.signature_t.Y		= string(integer(this.Object.line_bottom.pen.width) * 2)
	this.Object.signature_t.text 	= s_app.sOrga
	
	this.Object.time_t.X			= string(iDWwidth - iMarginLeft - iMarginRight - 6200)
	this.Object.time_t.width	= "6000"
	this.Object.time_t.Y			= string(integer(this.Object.line_bottom.pen.width) * 2)
	this.Object.time_t.text 	= string(Today(),s_app.sdateformat) + "   " + string(now(), "HH:MM")


	return
	
end subroutine

public function boolean uf_setprinter (string sprintername);	string sPort
// ---------------------------------
// Port ermitteln
// ---------------------------------
	If RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Devices",sPrinterName,sPort) <> 1 Then 
		Return False
	End if	
// ---------------------------------
// Diagram Drucker setzen
// ---------------------------------
	If RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows","DEVICE",sPrinterName + "," + sPort) <> 1 Then
		Return False
	End if	
	
	Return True

end function

public function boolean uf_setcopies (integer icopies);this.Object.DataWindow.Print.Copies = string(iCopies)

Return True
end function

public function boolean uf_documentname (string sdocumentname);this.Object.DataWindow.Print.DocumentName = sDocumentName

Return True
end function

public function boolean uf_setcollate (boolean bcollate);If bCollate Then
	this.Object.DataWindow.Print.Collate='Yes'
Else
	this.Object.DataWindow.Print.Collate='No'
End if	

Return True
end function

public function boolean uf_setquality (integer iQuality);// ------------------------------------------------------------
// 0 - Default, 1 - High, 2 - Medium, 3 - Low, 4 - Draft
// ------------------------------------------------------------
	this.Object.DataWindow.Print.Quality= string(iQuality)
	
	Return True
	
	
end function

public function boolean uf_defaultprinter ();	string sDefault
// ---------------------------------
// Default Drucker ermitteln
// ---------------------------------	
	If RegistryGet("HKEY_CURRENT_USER\Printers","DEVICEOLD",sDefault)  <> 1 Then
		Return False		
	End if	
		
	If RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows","DEVICE",sDefault) <> 1 Then 
		Return False		
	End if	
	

end function

public function boolean uf_setduplex (boolean bduplexmode);// ---------------------------------------------
// <1 - Simplex, 2 - Horizontal, 3 - Vertical>
// ---------------------------------------------
	If bduplexmode Then
		this.Object.DataWindow.Print.Duplex='2'
	Else
		this.Object.DataWindow.Print.Duplex='1'
	End if	
	
	Return True
end function

event dberror;// --------------------------------------------
// Error's f$$HEX1$$fc00$$ENDHEX$$r Oracle-Datenbank
// --------------------------------------------

	uf.mbox(sqldbcode,sqlerrtext)

	this.setrow(row)
	this.scrolltorow(row)
	Return 1
end event

on uo_report_dw.create
end on

on uo_report_dw.destroy
end on

