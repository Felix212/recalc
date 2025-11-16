HA$PBExportHeader$uo_report_dw2inpixel.sru
$PBExportComments$Report datastore
forward
global type uo_report_dw2inpixel from datastore
end type
type s_setdw from structure within uo_report_dw2inpixel
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

global type uo_report_dw2inpixel from datastore
end type
global uo_report_dw2inpixel uo_report_dw2inpixel

type variables
Public:

String  		sOrga
String		sDateFormat
String		sLogo
String		sLogoSW

uo_setdw 	dw_settings

integer iMarginTop,iMarginBottom,iMarginLeft,iMarginRight
integer iHeaderHeight,iDetailHeight,iFooterHeight,iSummaryHeight

// ---------------------------------------
// Wie soll gedruckt werden? Farbig (1), 
// Graustufen (2) oder S/W (3)
// ---------------------------------------
Integer	iPrintColor = 1			

Private:
string sLastcolumn,sLastsort,sLastTempcolumn
String sLastObject

// for Logging
n_cbase				nCbase			



boolean 	bFocus




end variables
forward prototypes
public function boolean uf_setcopies (integer icopies)
public function boolean uf_setcollate (boolean bcollate)
public function boolean uf_setquality (integer iQuality)
public function boolean uf_setduplex (boolean bduplexmode)
public subroutine writelog (string smsg)
public function boolean uf_documentname (string sdocumentname)
public subroutine uf_report_style (string sreporttitle, string sflightnumber, boolean bdetail, string sactyp, string sflightdetail, string sclass, string sinternal)
end prototypes

public function boolean uf_setcopies (integer icopies);this.Object.DataWindow.Print.Copies = string(iCopies)

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

public subroutine writelog (string smsg);
IF isValid(nCbase) THEN
	nCbase.writelog(sMsg)
END IF
end subroutine

public function boolean uf_documentname (string sdocumentname);this.Object.DataWindow.Print.DocumentName = sDocumentName

Return True
end function

public subroutine uf_report_style (string sreporttitle, string sflightnumber, boolean bdetail, string sactyp, string sflightdetail, string sclass, string sinternal);	integer 	iDWWidth, &
				iDWHeight, &
				iDetailX, &
				iDetailY
	long		lXpos
	String	sLogoToInsert
	
	// --------------------
	// Nicht Farbig ?
	// --------------------
	if iPrintColor > 1 then
		// --------------------
		// S/W
		// --------------------
		this.Object.r_detail.Pen.Color = "0"				// Linenfarbe schwarz
		this.Object.r_1.Pen.Color = "0"						// Linenfarbe schwarz
		this.Object.report_title_t.Color = "0"
		// sLogoToInsert = sLogoSW									// Graues Logo
	else
		// Farben Standard und buntes Logo
		// sLogoToInsert = sLogo									
	end if

// ---------------------------------------------------------------------------
// Qulity High
// ---------------------------------------------------------------------------
	this.Object.DataWindow.Print.Quality = "1" 
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
		writelog("Hinweis uo_repoprt_dw2pixel: Orientation im Datawindow angeben.")
	End if	
// ---------------------------------------------------------------------------
// Ma$$HEX1$$df00$$ENDHEX$$einheit Pixel
// ---------------------------------------------------------------------------
	If this.Object.DataWindow.Units <> "1" Then
		writelog("Hinweis uo_repoprt_dw2pixel: Reports Units bitte in Pixel.")
		
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
//	this.Object.p_title.filename = sLogoToInsert
	
	this.Object.r_1.X 		= "0"  
	this.Object.r_1.Y 		= "0" 
	this.Object.r_1.Width 	= string(iDWwidth - iMarginLeft - iMarginRight - 8 ) 
	this.Object.r_1.Height 	= "60" 
	
	
// ---------------------------------------------------------------------------
// Report-Titel
// ---------------------------------------------------------------------------	
	iDetailX										= (iDWwidth / 2) - (Long(this.Object.report_title_t.Width) / 2) - 15 // -0
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
	lXpos = Long(this.Object.r_1.x) + Long(this.Object.r_1.Width) - 238 //- 138 - 60
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
	lXpos = Long(this.Object.r_1.x) + Long(this.Object.r_1.Width) - 175 // - 135
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
	this.Object.signature_t.text 	= sOrga
	
	this.Object.time_t.X			= string(integer(this.Object.r_1.Width) - 234) 
	this.Object.time_t.width	= "228" 
	this.Object.time_t.Y			= "1"  
	this.Object.time_t.text 	= string(Today(),sDateformat) + "   " + string(now(), "HH:MM")

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

on uo_report_dw2inpixel.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_report_dw2inpixel.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;	

	
//	sLogoSW 	= nCbase.getgreyscalelogofile ()				// Graues Logo
//	sLogo 	= nCbase.getlogofile()	
	
	
end event

event destructor;IF isValid(nCbase) THEN setNull(nCbase)

end event

