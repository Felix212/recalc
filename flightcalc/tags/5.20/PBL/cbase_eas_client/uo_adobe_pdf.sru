HA$PBExportHeader$uo_adobe_pdf.sru
$PBExportComments$Catering Objekt f$$HEX1$$fc00$$ENDHEX$$r Acrobat (Wird $$HEX1$$fc00$$ENDHEX$$ber die Datanbank referenziert!)
forward
global type uo_adobe_pdf from uo_basisclass_catering_object
end type
end forward

global type uo_adobe_pdf from uo_basisclass_catering_object
end type
global uo_adobe_pdf uo_adobe_pdf

type variables
Private:

String		sFileName
String		sDescription

DateTime		dtValid_From




end variables

forward prototypes
private function integer uf_print ()
public function boolean uf_isvalidatdate ()
public function integer uf_createpdf ()
end prototypes

private function integer uf_print ();// ---------------------------------
// diese Funktion ermittelt den ent-
// sprechenden Blob (Dokument) und 
// lagert ihn im Filesystem aus und
// druckt in anschlie$$HEX1$$df00$$ENDHEX$$end
// ---------------------------------
	BLOB		bPDFDoc
	INTEGER	iRet
	
//// -------------------------------
//// wir holen das Dok aus dem Blob
//// -------------------------------
//	if bIsLocal	then
//		SELECTBLOB 		BPDF_BLOB
//		INTO				:bPDFDoc
//		FROM 				loc_catering_uo_pdf
//		WHERE				ncatering_userobject_id	= :lcatering_userobject_id AND
//							dvalid_from					= :dtvalid_from
//		USING				SQLCA;
//	
//	else
//		SELECTBLOB 		BPDF_BLOB
//		INTO				:bPDFDoc
//		FROM 				cen_catering_uo_pdf
//		WHERE				ncatering_userobject_id	= :lcatering_userobject_id AND
//							dvalid_from					= :dtvalid_from
//		USING				SQLCA;
//	end if
//	
//	if sqlca.SQLNRows = 0 Then
//		sErrorText 			= "Cannot read document: " + sfilename
//		sErrorTextPreview = sErrorText
//		writelog(sErrorText)
//		iPreviewRet 		= -1
//		return -1
//	end if
//	
//	if isNull(bPDFDoc) OR len(bPDFDoc) = 0 Then
//		sErrorText 			= "Document has no content: " + sfilename
//		sErrorTextPreview = sErrorText
//		writelog(sErrorText)
//		iPreviewRet 		= -1
//		return -1
//	end if
//	
//	// ------------------
//	// den Blob in das 
//	// Dokument Array 
//	// speichern
//	// ------------------
//	bStream					= bPDFDoc
//
	return iRet

end function

public function boolean uf_isvalidatdate ();	Integer	iCnt
	
	
	SELECT	 		dvalid_from, dvalid_to
	INTO				:dValidFrom, :dValidTo
	FROM 				cen_catering_uo_pdf
	WHERE				ncatering_userobject_id	= :lInheritCateringID AND
	  					dvalid_from <= :dDepartureDate AND  
         			dvalid_to >= :dDepartureDate 
	USING				SQLCA;
	
	SELECT	 		Count(*)
	INTO				:iCnt
	FROM 				cen_catering_uo_pdf
	WHERE				ncatering_userobject_id	= :lInheritCateringID AND
	  					dvalid_from <= :dDepartureDate AND  
         			dvalid_to >= :dDepartureDate 
	USING				SQLCA;

	return (iCnt > 0)

end function

public function integer uf_createpdf ();// ---------------------------------
// diese Funktion ermittelt den ent-
// sprechenden Blob (Dokument) und 
// lagert ihn im Filesystem aus und
// druckt in anschlie$$HEX1$$df00$$ENDHEX$$end
// ---------------------------------
	BLOB		bPDFDoc
	
	Long 		lEnde, lStart
	
	String	sIndexFile
	
//--------------------------------------------------------------
// Nachschaun, von wo das Object instanziiert wurde.
// Wenn es der Client war dann nachschaun, ob das PDF
// schon auf der Platte liegt
//--------------------------------------------------------------
//This.GetContextService ("Transactionserver", its_jag)
//
//if its_jag.Which() = 0 then
	
	//--------------------------------------------------------------
	// Powerbuilder-Client 
	//--------------------------------------------------------------
	sWhereAmI = "PB"

	sIndexFile = f_gettemppath() + "CBASE-DOCUMENT-ID-" + string(lInheritCateringID) + ".PDF"

	//--------------------------------------------------------------
	// Nachschaun, ob es die Datei schon auf der Platte gibt
	//--------------------------------------------------------------
	if FileExists(sIndexFile) then
		
		// f_debug("FOUND: " + string(lInheritCateringID))
		
		if f_file_to_blob(sIndexFile, bPDFDoc, True) <= 0 then
			sErrorText 			= "Document: " + sIndexFile + " has a invalid size."
			writelog(sErrorText)
			return -1
		end if
			
	else
		
		// -----------------------------------------------
		// Das PDF liegt noch nicht auf der Platte rum
		// also holen wir es aus der DB
		// -----------------------------------------------
		// f_debug("NOT FOUND: " + string(lInheritCateringID))

		SELECTBLOB 		BPDF_BLOB
		INTO				:bPDFDoc
		FROM 				cen_catering_uo_pdf
		WHERE				ncatering_userobject_id	= :lInheritCateringID AND
							dvalid_from <= :dDepartureDate AND  
							dvalid_to >= :dDepartureDate 
		USING				SQLCA;
			
		if sqlca.SQLNRows = 0 Then
			sErrorText 			= "Cannot read document: " + sFilename
			writelog(sErrorText)
			return -1
		end if
		
		if isNull(bPDFDoc) OR len(bPDFDoc) = 0 Then
			sErrorText 			= "Document has no content: " + sFilename
			writelog(sErrorText)
			return -1
		end if
		
		// -----------------------------------------------
		// Und dann noch den Blob f$$HEX1$$fc00$$ENDHEX$$rs n$$HEX1$$e400$$ENDHEX$$chste mal auf 
		// die Platte schreiben
		// -----------------------------------------------
		f_blob_to_file(sIndexFile, bPDFDoc)
		
			
	end if

//else
//	
//	//--------------------------------------------------------------
//	// EAS
//	//--------------------------------------------------------------
//	sWhereAmI = "WEB"
//	
//	// -----------------------------------------------
//	// Wir sind im Web also den Blob immer aus der
//	// DB holen
//	// -----------------------------------------------
//	SELECTBLOB 		BPDF_BLOB
//	INTO				:bPDFDoc
//	FROM 				cen_catering_uo_pdf
//	WHERE				ncatering_userobject_id	= :lInheritCateringID AND
//	  					dvalid_from <= :dDepartureDate AND  
//         			dvalid_to >= :dDepartureDate 
//	USING				SQLCA;
//
//	if sqlca.SQLNRows = 0 Then
//		sErrorText 			= "Cannot read document: " + sFilename
//		writelog(sErrorText)
//		return -1
//	end if
//	
//	if isNull(bPDFDoc) OR len(bPDFDoc) = 0 Then
//		sErrorText 			= "Document has no content: " + sFilename
//		writelog(sErrorText)
//		return -1
//	end if
//	
//end if

iCopyCount = -1

SELECT 	cen_catering_uo_pdf.cpdf_file, 
			cen_catering_uo_pdf.ncopy_count
INTO 		:sPDFFileName, 
			:iCopyCount
FROM 		cen_catering_uo_pdf 
WHERE				ncatering_userobject_id	= :lInheritCateringID AND
					dvalid_from <= :dDepartureDate AND  
					dvalid_to >= :dDepartureDate 
USING				SQLCA;

if sqlca.SQLNRows = 0 Then
	sPDFFileName = "unknown.pdf"
else
	sPDFFileName = f_Replace(TRIM(sPDFFileName), " ", "_")
end if

if sWhereAmI <> "WEB" then

end if	

// ----------------------------------------------------
// den Blob in das Dokument Array speichern
// ----------------------------------------------------
bStream					= bPDFDoc

if sWhereAmI = "WEB" then
	bStream					= bPDFDoc
else
	sPDFFileName			= f_gettemppath() + "CBASE-ACROBAT-" + String(Rand(32767)) + String(now(), "hhmmss") + ".PDF"
	
	lStart = CPU()
			
	f_blob_to_file(sPDFFileName, bPDFDoc)
	
	lEnde = CPU()

end if

return 0

end function

on uo_adobe_pdf.create
call super::create
end on

on uo_adobe_pdf.destroy
call super::destroy
end on

