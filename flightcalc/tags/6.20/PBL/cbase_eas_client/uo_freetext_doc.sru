HA$PBExportHeader$uo_freetext_doc.sru
$PBExportComments$Catering Objekt f$$HEX1$$fc00$$ENDHEX$$r Freitexte
forward
global type uo_freetext_doc from uo_basisclass_catering_object
end type
end forward

global type uo_freetext_doc from uo_basisclass_catering_object
end type
global uo_freetext_doc uo_freetext_doc

type variables
Public:

Private:

Boolean		bPrintDuplex 	= False
String		sDescription
String		sTitle
Integer		iColor
DateTime		dtValid_From

Integer		iPrintDuplex


end variables

forward prototypes
public function integer uf_print ()
public function boolean uf_isvalidatdate ()
public function string uf_get_dblogo (integer ilogo)
public function integer uf_createpdf ()
end prototypes

public function integer uf_print ();	long			lRows
	DataStore	dsFreeTextReport

	dsFreeTextReport 					= Create DataStore

	
	//
	// lokales oder zentrales Dataobject?
	//
	if bIsLocal	then
		dsFreeTextReport.DataObject 	= "dw_freetext_report_local"
	else
		dsFreeTextReport.DataObject 	= "dw_freetext_report"
	end if
	
	dsFreeTextReport.SetTransObject(SQLCA)

// -------------------------------
// Modify Datawindow
// -------------------------------
	dsFreeTextReport.Object.reportheadline_t.text 		= sTitle
	dsFreeTextReport.Object.signature_t.text 				= sOrga
	dsFreeTextReport.Object.time_t.text 					= string(Today(),sdateformat) + "   " + string(now(), "HH:MM")

	dsFreeTextReport.Object.flight_t.text 					= sAirline + " " + string(iFlightNumber,"000") + " " + sSuffix
	dsFreeTextReport.Object.actyp_t.text 					= sACType
	dsFreeTextReport.Object.flightdetail_t.text 			= string(dDepartureDate,sdateformat) + "   " + string(tDepartureTime, "HH:MM")

	dsFreeTextReport.Object.DataWindow.print.duplex 	= iPrintDuplex
	dsFreeTextReport.Object.DataWindow.print.copies		= string(icopycount)
	If icolor = 1 Then
		dsFreeTextReport.Object.DataWindow.print.color			= '1'
	Else
		dsFreeTextReport.Object.DataWindow.print.color			= '2'
	End if
	
	//
	// Von welchem Betrieb stammt die Info?
	//
	if bIsLocal	then
		dsFreeTextReport.Object.betrieb_t.text 			= sWerk
	end if

// -------------------------------
// und der Retrieve
// -------------------------------
	lRows = dsFreeTextReport.retrieve(lCatering_Userobject_Id,date(dtValid_From),dDepartureDate)
	If lRows > 0 Then
		dsFreeTextReport.print(False)
	else
		iPreviewRet = -1
		sErrorTextPreview = "No valid for printing found!"
	End if	

	destroy 	dsFreeTextReport
	return 0
end function

public function boolean uf_isvalidatdate ();	Integer	iCntMaster, &
				iCntDetail
				
				
	SELECT	 		dvalid_from, dvalid_to
	INTO				:dValidFrom, :dValidTo
	FROM 				cen_catering_uo_freetext
	WHERE				ncatering_userobject_id	= :lInheritCateringID AND
	  					dvalid_from <= :dDepartureDate AND  
         			dvalid_to >= :dDepartureDate 
	USING				SQLCA;
	
	SELECT	 		Count(*)
	INTO				:iCntMaster
	FROM 				cen_catering_uo_freetext
	WHERE				ncatering_userobject_id	= :lInheritCateringID AND
	  					dvalid_from <= :dDepartureDate AND  
         			dvalid_to >= :dDepartureDate 
	USING				SQLCA;
	
	
	SELECT	 		Count(*)
	INTO				:iCntDetail
	FROM 				cen_catering_uo_ft_detail
	WHERE				ncatering_userobject_id	= :lInheritCateringID AND
	  					ddetail_valid_from <= :dDepartureDate AND  
         			ddetail_valid_to >= :dDepartureDate 
	USING				SQLCA;
	
	
	return ((iCntMaster > 0) AND (iCntDetail > 0))

end function

public function string uf_get_dblogo (integer ilogo);// --------------------------------------
// Das farbige logo aus der DB
// --------------------------------------
	string slogo_color
	
	select ccolor_logo
	 into :slogo_color
	 from sys_logos
	where nlogo_key = :ilogo using sqlca;
	
	If sqlca.sqlcode <> 0 Then
		slogo_color = ""
	End if
	
		
	return sLogoPath + "\" + sLogo_color
	
end function

public function integer uf_createpdf ();long			lRows

INTEGER		iRet,i,iLogo
				
DataStore	dsFreeTextReport, &
				dsFreeText
Blob			bDSState
String		sFileName, &
				sFullFileName

dsFreeTextReport					= Create DataStore
dsFreeText 							= Create DataStore
dsFreeText.DataObject 			= "dw_freetext_files"
dsFreeTextReport.DataObject 	= "dw_freetext_report"
dsFreeText.SetTransObject (SQLCA)
dsFreeTextReport.SetTransObject(SQLCA)

if not isValid(nPrintPDF) and sWhereAmI = "WEB" Then
	sErrorText = "Can't connect to PDF-Writer"
	writelog(sErrorText)
	return -1
end if

lRows = dsFreeText.Retrieve(lInheritCateringID, DateTime(ddeparturedate)) 
// -----------------------------
// Hier d$$HEX1$$fc00$$ENDHEX$$rfte nur eine Zeile
// stehen
// -----------------------------
if lRows > 0 Then
	dtValid_From	= dsFreeText.GetItemDateTime(1, "dvalid_from")
	sdescription	= dsFreeText.GetItemString(1, "ccatering_uo_descripton")
	sTitle			= dsFreeText.GetItemString(1, "ctitle")
	iCopyCount		= dsFreeText.GetItemNumber(1, "ncopy_count")
	iLogo				= dsFreeText.GetItemNumber(1, "nlogo")
else
	sErrorText = "Cannot load Object-Informations: " + SQLCA.SQLERRTEXT
	writelog("Cannot load Object-Informations")
	return -1
end if

// -----------------------------
// Wir holen den PDF-Namen
// der PDF-LIB
// -----------------------------

if sWhereAmI = "WEB" then
	sFileName 				= String(nPrintPDF.GetSession())
	sFullFileName			= nPrintPDF.GetPdfDocPath() + sFileName + ".pdf"
else
	sFileName 				= "CBASE-FREETEXT-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
	sFullFileName			= f_gettemppath() + sFileName
	
end if

// -------------------------------
// Modify Datawindow
// -------------------------------
dsFreeTextReport.Object.reportheadline_t.text 		= sTitle
dsFreeTextReport.Object.signature_t.text 				= sOrga
dsFreeTextReport.Object.time_t.text 					= string(Today(),sdateformat) + "   " + string(now(), "HH:MM")
dsFreeTextReport.Object.p_title.filename 				= uf_get_dblogo(iLogo)

dsFreeTextReport.Object.flight_t.text 					= sAirline + " " + string(iFlightNumber,"000") + " " + sSuffix
dsFreeTextReport.Object.actyp_t.text 					= sACType
dsFreeTextReport.Object.flightdetail_t.text 			= string(dDepartureDate, sDateFormat) + "   " + string(tDepartureTime, "HH:MM")

// -------------------------------
// und der Retrieve
// -------------------------------
lRows = dsFreeTextReport.retrieve(lInheritCateringID, date(dtValid_From), dDepartureDate)

//
// 06.02.06 Falls keine Details g$$HEX1$$fc00$$ENDHEX$$ltig sind, steht die Verarbeitung!
//
If lRows > 0 Then
	// ------------------------
	// wir drucken in PDF
	// ------------------------
	dsFreeTextReport.GetFullState(bDSState)
	
	for i = 1 To iCopyCount
		// ----------------------------------
		// 27.08.2002
		// unterscheiden, ob Web oder 
		// PB - Client
		// ----------------------------------
		if sWhereAmI = "WEB" then
			nPrintPDF.printpdf(bDsState, sFileName)
		else
			// -------------------------------------------
			// create PDF from datawindow
			// -------------------------------------------	
			if uoPDF.of_convert(dsFreeTextReport, "FreeTextReport", sFullFilename) <> 0 then 
				sErrorText = "Dokumente: of_convert()"
				return -1
			end if						
		end if
	next
			
	if sWhereAmI = "WEB" then
		sPDFFileName = f_replace(sTitle, " ", "_") + ".pdf"
	else
		sPDFFileName = sFullFilename
	end if

	if FileExists(sFullFileName) and sWhereAmI = "WEB" Then
		f_file_to_blob(sFullFileName, bStream, TRUE)
		FileDelete(sFullFileName)
		iRet = 0
	elseif FileExists(sFullFileName) = False and sWhereAmI = "WEB" then
		sErrorText = "Generated File not found"
		iRet = -1
	End if
	
else
	//
	// 06.02.06 Keine G$$HEX1$$fc00$$ENDHEX$$ltigkeit ist doch eigentlich kein Fehler!
	// Dies f$$HEX1$$fc00$$ENDHEX$$hrt allerdings zum Fehler beim Mergen der Objekte....
	// Bereits in Steuerung checken?
	//
	//iRet = 0
	iRet = -1
	sErrorTextPreview = "No valid data for printing found!"
End if	

destroy 	dsFreeTextReport
destroy 	dsFreeText

return iRet
end function

on uo_freetext_doc.create
call super::create
end on

on uo_freetext_doc.destroy
call super::destroy
end on

