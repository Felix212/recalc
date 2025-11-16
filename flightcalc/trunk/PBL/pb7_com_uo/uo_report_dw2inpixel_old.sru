HA$PBExportHeader$uo_report_dw2inpixel_old.sru
$PBExportComments$Report Datawindow
forward
global type uo_report_dw2inpixel_old from datawindow
end type
type s_setdw from structure within uo_report_dw2inpixel_old
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

global type uo_report_dw2inpixel_old from datawindow
integer width = 713
integer height = 364
integer taborder = 1
string dataobject = "dw_loading_diagram2"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylelowered!
event ue_mouseup pbm_lbuttonup
event ue_mouseout pbm_dwnmousemove
event ue_accepttext ( )
end type
global uo_report_dw2inpixel_old uo_report_dw2inpixel_old

type variables
Public:

uo_setdw 	dw_settings

integer iMarginTop,iMarginBottom,iMarginLeft,iMarginRight
integer iHeaderHeight,iDetailHeight,iFooterHeight,iSummaryHeight

string  sOrga

Private:
string sLastcolumn,sLastsort,sLastTempcolumn
String sLastObject

boolean 	bFocus

end variables

forward prototypes
public function boolean uf_setcopies (integer icopies)
public function boolean uf_documentname (string sdocumentname)
public function boolean uf_setcollate (boolean bcollate)
public function boolean uf_setquality (integer iQuality)
public subroutine uf_report_style (string sreporttitle, string sflightnumber, boolean bdetail, string sactyp, string sflightdetail, string sclass, string sinternal)
public function boolean uf_setduplex (boolean bduplexmode)
end prototypes

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

public subroutine uf_report_style (string sreporttitle, string sflightnumber, boolean bdetail, string sactyp, string sflightdetail, string sclass, string sinternal);	
	integer 	iDWWidth, &
				iDWHeight, &
				iDetailX, &
				iDetailY
	long		lXpos
				
// ---------------------------------------------------------------------------
// Welche Orientation ? 1 = Landscape	2 = Portrait
// ---------------------------------------------------------------------------
		
	If this.Object.DataWindow.Print.Orientation = "1" Then
		iDWWidth 	= 1123 //29700
		iDWHeight	= 793  //21000
	Elseif this.Object.DataWindow.Print.Orientation = "2" Then
		iDWWidth 	= 793  //21000
		iDWHeight	= 1123 //29700
	Else
		Messagebox("Hallo Entwickler","Orientation im Datawindow angeben.")
	End if	
// ---------------------------------------------------------------------------
// Ma$$HEX1$$df00$$ENDHEX$$einheit Pixel
// ---------------------------------------------------------------------------
	If this.Object.DataWindow.Units <> "1" Then
		Messagebox("Hallo Entwickler","Reports Units bitte in Pixel.")
	End if	
	
	iMarginTop		= integer(this.Object.DataWindow.Print.Margin.Top)
	iMarginBottom	= integer(this.Object.DataWindow.Print.Margin.Bottom)
	iMarginLeft		= integer(this.Object.DataWindow.Print.Margin.Left)
	iMarginRight	= integer(this.Object.DataWindow.Print.Margin.Right)
// ---------------------------------------------------------------------------
// Header.Height und Footer.Height
// ---------------------------------------------------------------------------
	this.Object.DataWindow.Header.Height= "60" 
	this.Object.DataWindow.Footer.Height= "24" 
	this.Object.DataWindow.Summary.Height='0'
	iHeaderheight  = integer(this.Object.DataWindow.Header.Height)
	iFooterheight  = integer(this.Object.DataWindow.Footer.Height)	
	iSummaryHeight = integer(this.Object.DataWindow.Summary.Height)	
	
		
// ---------------------------------------------------------------------------
// Optimales Detail errechnen
// ---------------------------------------------------------------------------	
	If bDetail Then
		iDetailheight = iDWHeight - 4 - (iHeaderheight + iFooterheight + iSummaryHeight + iMarginTop + iMarginBottom )
		this.Object.DataWindow.Detail.Height = string(iDetailheight)
		this.Object.r_detail.X 		= "0"  
		this.Object.r_detail.Y 		= "0" 
		this.Object.r_detail.Width 	= string(iDWwidth - iMarginLeft - iMarginRight - 8 ) 
		this.Object.r_detail.Height 	= string(iDetailheight + 4)
	End if
		
// ---------------------------------------------------------------------------
// Layout Header
// ---------------------------------------------------------------------------	
	this.Object.p_title.X = "4" 
	this.Object.p_title.Y = "4"

	this.Object.r_1.X 		= "0"  
	this.Object.r_1.Y 		= "0" 
	this.Object.r_1.Width 	= string(iDWwidth - iMarginLeft - iMarginRight - 8 ) 
	this.Object.r_1.Height 	= "60" 
	
// ---------------------------------------------------------------------------
// Report-Titel
// ---------------------------------------------------------------------------	
	iDetailX										= (iDWwidth / 2) - (Long(this.Object.report_title_t.Width) / 2)
	this.Object.report_title_t.X 			= string(iDetailX)  
	this.Object.report_title_t.Y 			= "6" 
	this.Object.report_title_t.text		= sReportTitle
// ---------------------------------------------------------------------------
// Layout Class
// ---------------------------------------------------------------------------
	iDetailX							= (iDWwidth / 2) - (Long(this.Object.class_t.Width) / 2)
	this.Object.class_t.X		= String(iDetailX) 
	this.Object.class_t.text 	= sClass

// ---------------------------------------------------------------------------
// Layout Flugnummer-Bezeichnung (Flight:)
// ---------------------------------------------------------------------------		
	lXpos = Long(this.Object.r_1.x) + Long(this.Object.r_1.Width) - 138 - 60
	this.Object.flight_bez_t.X			= String(lXpos) 
// ---------------------------------------------------------------------------
// AC-Typ-Bezeichnung (Aircrafttype:)
// ---------------------------------------------------------------------------		
	this.Object.ac_bez_t.X		= String(lXpos) 
// ---------------------------------------------------------------------------
// Date-Bezeichnung (Departure:)
// ---------------------------------------------------------------------------		
	this.Object.date_bez_t.X		= String(lXpos) 
// ---------------------------------------------------------------------------
// Layout Flugnummer
// ---------------------------------------------------------------------------	
	lXpos = Long(this.Object.r_1.x) + Long(this.Object.r_1.Width) - 135
	this.Object.flight_t.X		= String(lXpos) 
	this.Object.flight_t.text 	= sFlightnumber
// ---------------------------------------------------------------------------
// Layout AC-Typ
// ---------------------------------------------------------------------------		
	this.Object.actyp_t.X		= String(lXpos) 
	this.Object.actyp_t.text 	= sActyp
// ---------------------------------------------------------------------------
// Layout Date
// ---------------------------------------------------------------------------		
	this.Object.flightdeparture_t.X		= String(lXpos) 
	this.Object.flightdeparture_t.text 	= sFlightDetail
// ---------------------------------------------------------------------------
// Layout Footer
// ---------------------------------------------------------------------------
	this.Object.signature_t.X		= "2"   
	this.Object.signature_t.width	= "228" 
	this.Object.signature_t.Y		= "1"   
	this.Object.signature_t.text 	= s_app.sOrga
	
	this.Object.time_t.X			= string(integer(this.Object.r_1.Width) - 234) 
	this.Object.time_t.width	= "228" 
	this.Object.time_t.Y			= "1"  
	this.Object.time_t.text 	= string(Today(),s_app.sdateformat) + "   " + string(now(), "HH:MM")

	this.Object.c_page.X			= "2"  
	this.Object.c_page.width 	= string(iDWwidth - iMarginLeft - iMarginRight - 8)
	this.Object.c_page.Y 		= "1"  
	this.Object.c_page.text 	= "Page"
	
	this.Object.internal_t.X			= "2"  
	this.Object.internal_t.width 		= string(iDWwidth - iMarginLeft - iMarginRight - 8)
	this.Object.internal_t.Y 			= "14"  
	this.Object.internal_t.text 		= "Internal Loadingkey: " + sInternal
	
	return
	

end subroutine

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

on uo_report_dw2inpixel_old.create
end on

on uo_report_dw2inpixel_old.destroy
end on

