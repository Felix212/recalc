HA$PBExportHeader$uo_catering_object_steuerung.sru
forward
global type uo_catering_object_steuerung from nonvisualobject
end type
end forward

global type uo_catering_object_steuerung from nonvisualobject
end type
global uo_catering_object_steuerung uo_catering_object_steuerung

type variables
Private:

long			lParentHwnd
datastore 	dsSteuerungLocal
datastore	dsSteuerungGlobal



Public:
// ---------------------------------------
// Der PDF-Stream
// ---------------------------------------
Blob		bPDFStream
String	sPDFFileName

uo_pdf_handler	uoPDF


String	sMandant
String	sWerk
String	sDateFormat
String	sUserStation

Long		lRoutingID
// ---------------------------------------
// Funktionen
//
// 1 = Drucken (default)
// 2 = Object finden (f$$HEX1$$fc00$$ENDHEX$$llt Treffermenge)
// ---------------------------------------
Integer	iFunction = 1

Integer	iCopyCount = 1

// ------------------
// Flugeigenschaften
// ------------------
String	sAirline
String	sAircraftOwner
String	sDestination
Integer	iFlightNumber
String	sSuffix
String	sRouting
Date		dDepartureDate
Time		tDepartureTime
String	sOwner
String	sACType
String	sRegistration
long		lSnr

// ------------------
// Treffermenge
// ------------------
Long		lDefinition_id						// hier wird der Key der gefundenen Definition abgelegt
Long		lCatering_userobject_id
Long		lInheritCateringID
Long		lAirlineKey
DateTime	dtValid_From
DateTime	dtDepartureDate
boolean	bSuccess

// ------------------
// nachfolgender Text
// enth$$HEX1$$e400$$ENDHEX$$lt die Fehler-
// meldung
// ------------------
String	sErrorText

CONSTANT String  sOrga = "$$HEX2$$a9002000$$ENDHEX$$2000-2006 FRA ZC/F4"

Protected:
ErrorLogging		iel_jag
end variables

forward prototypes
private subroutine writelog (string smsg)
private function integer uf_getobjects_detail (long lcatkey, ref cat_object strcatobject, long lrow, datastore dds)
private function integer uf_getobjects_global (long lcatkey, ref cat_object strcatobject)
public function integer uf_getobjects (ref cat_object catobjects[], s_all_flight_infos sinfo)
public function integer of_getglobalobjectexplicit (s_all_flight_infos sinfo)
end prototypes

private subroutine writelog (string smsg);
if isValid(iel_jag) Then
	iel_jag.log(sMSG)
end if
end subroutine

private function integer uf_getobjects_detail (long lcatkey, ref cat_object strcatobject, long lrow, datastore dds);	Long		lCatObjectID
	
	Integer	iUpperBound
	String	sCatObjectName, &
				sDepartureTime, &
				sDescription, &
				sClassName

	uo_basisclass_catering_object		uoCatObject
	sDepartureTime = String(tDepartureTime, "hh:mm")
	lCatObjectID 	= dds.GetItemNumber(lRow, "ncatering_userobject_id")
	sCatObjectName	= dds.GetItemString(lRow, "ccatering_uo_name")
	sDescription	= dds.GetItemString(lRow, "ccatering_uo_descripton")
	sClassName		= dds.GetItemString(lRow, "sys_cateringobject_cclass_name")
	
// ---------------------------------------
// Bis hier haben wir schon mal einen 
// Treffer. Haben wir aber ein Dok. in
// diesem G$$HEX1$$fc00$$ENDHEX$$ltigkeitsbereich. Das wei$$HEX1$$df00$$ENDHEX$$
// nur das Object selbst. Wir instanziieren
// es und lassen es checken.
// ---------------------------------------
	uoCatObject = CREATE USING sClassName
	uoCatObject.dDepartureDate 		= dDepartureDate
	uoCatObject.lInheritCateringID 	= lCatObjectID
		
	if uoCatObject.uf_isValidAtDate() Then
		iUpperBound = UpperBound(strcatobject.objects[]) + 1
		strcatobject.objects[iUpperBound].sname				= sCatObjectName
		strcatobject.objects[iUpperBound].sdescription		= sDescription
		strcatobject.objects[iUpperBound].luserobjectkey	= lCatObjectID
		strcatobject.objects[iUpperBound].dValidFrom			= uoCatObject.dValidFrom
		strcatobject.objects[iUpperBound].dValidTo			= uoCatObject.dValidTo
	end if
		
	DESTROY uoCatObject 

	Return 1
end function

private function integer uf_getobjects_global (long lcatkey, ref cat_object strcatobject);Long		lRow, &
			lCnt, &
			lCatObjectID

Integer	iRet, i, iUpperBound
Boolean	bCreate 
String	sCatObjectName, &
			sDepartureTime, &
			sDescription, &
			sClassName

inherit_cat_object	strRet
uo_basisclass_catering_object		uoCatObject

sDepartureTime = String(tDepartureTime, "hh:mm")
// ----------------------------------
// ein Retrieve
// ----------------------------------
dsSteuerungGlobal.Retrieve(sMandant, lCatKey)

// ----------------------------------
// wir durchlaufen alle Rows des 
// SteuerungsDW und schauen nach 
// ob es eine Zuordnung gibt
// ----------------------------------
For lRow = 1 To dsSteuerungGlobal.RowCount()
	bCreate 			= False
	lCatObjectID 	= dsSteuerungGlobal.GetItemNumber(lRow, "ncatering_userobject_id")
	sCatObjectName	= dsSteuerungGlobal.GetItemString(lRow, "ccatering_uo_name")
	sDescription	= dsSteuerungGlobal.GetItemString(lRow, "cen_catering_userobject_ccatering_uo_descripton")
	sClassName		= dsSteuerungGlobal.GetItemString(lRow, "sys_cateringobject_cclass_name")
	
	// ---------------------------------------
	// haben wir eine Zuordnung auf Airline ?
	// ---------------------------------------
			
	Select 	Count(*)
	INTO		:lCnt
	FROM		cen_object_loading_one
	WHERE		ncatering_userobject_id = :lCatObjectID 		AND
				nairline_key				= :lAirlineKey  		AND
				ctime_from 				  <= :sDepartureTime		AND
				ctime_to 				  >= :sDepartureTime		
	USING		SQLCA;
	
	if lCnt > 0 Then
		// -------------------------------
		// es besteht eine Zuordnung auf
		// die Airline => Treffer und raus
		// -------------------------------
		bCreate = True
	end if
	
	// ---------------------------------------
	// haben wir eine Zuordnung auf Routing ?
	// ---------------------------------------
	if Not bCreate Then
		
		Select 	Count(*)
		INTO		:lCnt
		FROM		cen_object_loading_two
		WHERE		ncatering_userobject_id = :lCatObjectID 		AND
					nairline_key				= :lAirlineKey  		AND
					nrouting_id					= :lRoutingID  		AND
					ctime_from 				  <= :sDepartureTime		AND
					ctime_to 				  >= :sDepartureTime		
		USING		SQLCA;
		
		if lCnt > 0 Then
			// -------------------------------
			// es besteht eine Zuordnung auf
			// das Routing => Treffer und raus
			// -------------------------------
			bCreate = True
		end if
	end if
	
	// ---------------------------------------
	// haben wir eine Zuordnung auf Flugnummer ?
	// ---------------------------------------
	if Not bCreate Then
		
		// ----------------------
		// Haben wir ein Suffix
		// ----------------------
		if IsNull(sSuffix) OR len(sSuffix) = 0 Then
				
			Select 	Count(*)
				INTO		:lCnt
				FROM		cen_object_loading_three
				WHERE		ncatering_userobject_id = :lCatObjectID 		AND
							nairline_key				= :lAirlineKey  		AND
							nflight_number				= :iFlightNumber  	AND
							ctime_from 				  <= :sDepartureTime		AND
							ctime_to 				  >= :sDepartureTime		
				USING		SQLCA;
		else			
			Select 	Count(*)
				INTO		:lCnt
				FROM		cen_object_loading_three
				WHERE		ncatering_userobject_id = :lCatObjectID 		AND
							nairline_key				= :lAirlineKey  		AND
							nflight_number				= :iFlightNumber 		AND
							cSuffix						= :sSuffix  			AND
							ctime_from 				  <= :sDepartureTime		AND
							ctime_to 				  >= :sDepartureTime		
				USING		SQLCA;
			
		end if
		
		if lCnt > 0 Then
			// -------------------------------
			// es besteht eine Zuordnung auf
			// die Flugnummer => Treffer und raus
			// -------------------------------
			bCreate = True
		end if
	end if
	
	// ---------------------------------------
	// haben wir eine Zuordnung auf Destination ?
	// ---------------------------------------
	if Not bCreate Then
	
		Select 	Count(*)
			INTO		:lCnt
			FROM		cen_object_loading_four
			WHERE		ncatering_userobject_id = :lCatObjectID   		AND
						ctime_from 				  <= :sDepartureTime			AND
						ctime_to 				  >= :sDepartureTime			AND
						nairline_key				= :lAirlineKey  			AND
						ntlc_key						= (Select 	ntlc_key 
															FROM 		sys_three_letter_codes
															WHERE		ctlc = :sDestination)
			USING		SQLCA;
			
		if lCnt > 0 Then
			// -------------------------------
			// es besteht eine Zuordnung auf
			// die Destination => Treffer und raus
			// -------------------------------
			bCreate = True
		end if
	end if
	
	// ---------------------------------------
	// be continued ......
	// ---------------------------------------
	If bCreate Then
		// ---------------------------------------
		// Bis hier haben wir schon mal einen 
		// Treffer. Haben wir aber ein Dok. in
		// diesem G$$HEX1$$fc00$$ENDHEX$$ltigkeitsbereich. Das wei$$HEX1$$df00$$ENDHEX$$
		// nur das Object selbst. Wir instanziieren
		// es und lassen es checken.
		// ---------------------------------------
		uoCatObject = CREATE USING sClassName
		uoCatObject.dDepartureDate 		= dDepartureDate
		uoCatObject.lInheritCateringID 	= lCatObjectID
		
		if uoCatObject.uf_isValidAtDate() Then
			iUpperBound = UpperBound(strcatobject.objects[]) + 1

			strcatobject.objects[iUpperBound].sname				= sCatObjectName
			strcatobject.objects[iUpperBound].sdescription		= sDescription
			strcatobject.objects[iUpperBound].luserobjectkey	= lCatObjectID
			strcatobject.objects[iUpperBound].dValidFrom			= uoCatObject.dValidFrom
			strcatobject.objects[iUpperBound].dValidTo			= uoCatObject.dValidTo
		end if
		
		DESTROY uoCatObject 
	end if
	
Next	


Return iRet
end function

public function integer uf_getobjects (ref cat_object catobjects[], s_all_flight_infos sinfo);// ------------------------------------------------------------
// Alle Dokumente f$$HEX1$$fc00$$ENDHEX$$r diesen Flug
// ------------------------------------------------------------

	DataStore 	ds_documents, ds_acdocuments
	integer		iVerkehrsTag,iRows,iacRows,i
	string		sFrequenz,sFilter,sName
	LONG			lRowCount, lObjectKey
	ds_documents					= CREATE DataStore
	ds_documents.DataObject 	= "dw_documents"							
	ds_documents.SetTransObject(SQLCA)
	//MB 27.07.2010: Alle Aircraftspezifischen Dokumente f$$HEX1$$fc00$$ENDHEX$$r diesen Flug holen
	ds_acdocuments					= CREATE DataStore
	ds_acdocuments.DataObject 	= "dw_acdocuments"							
	ds_acdocuments.SetTransObject(SQLCA)
	
	//FRE 21.05.2008: Einschr$$HEX1$$e400$$ENDHEX$$nkung auf aktuelle Unit
	ds_documents.Retrieve(sInfo.lroutingplan_key,date(sInfo.sdeparturedate),sInfo.cdeparturetime, sInfo.sUnit)
	iVerkehrsTag = f_getfrequence(date(sInfo.sdeparturedate))
	sFrequenz 	 = "cen_routingplan_nfreq" + string(iVerkehrsTag) + "=1"
// ----------------------------------------------------------------------
// Filter auf Frequenz
// ----------------------------------------------------------------------
	sFilter		 =  "nfreq" + string(iVerkehrsTag) + " = 1"
	ds_documents.SetFilter(sFilter)
	ds_documents.Filter()
	iRows = ds_documents.Rowcount()
	
	For i = 1 to iRows
		lObjectKey 	= ds_documents.GetItemNumber(i, "ncateringobject_id")		
		sName			= ds_documents.GetItemString(i, "ccatering_uo_name")	
		CatObjects[i].sType 			= sName
		CatObjects[i].lobjectkey	= lObjectKey
		uf_getobjects_detail(lObjectKey, CatObjects[i],i,ds_documents)
	NEXT
	//AC-Dokumente vorbereiten:
	ds_acdocuments.Retrieve(sInfo.lroutingplan_key,date(sInfo.sdeparturedate),sInfo.cdeparturetime, sInfo.sUnit)
	sFilter	 = "cen_handling_acdoc_detail_naircraft_key =" + string(sInfo.laircraft_key)
	ds_acdocuments.SetFilter(sFilter)
	ds_acdocuments.Filter()
	iacRows = ds_acdocuments.rowcount()
	
	if iacRows = 0 then
		//Keine Aircraftspezifischen Dokumente vorhanden, aber vielleicht gibt es Defaultdokumente
		ds_acdocuments.SetFilter("")
		ds_acdocuments.Filter()
		sFilter = "cen_handling_acdoc_detail_ndefault = 1"
		ds_acdocuments.SetFilter(sFilter)
		ds_acdocuments.Filter()
		iacRows = ds_acdocuments.rowcount()
	end if
	
	if iacRows > 0 then
	//Es gibt AC-Dokumente, also werden Sie angeh$$HEX1$$e400$$ENDHEX$$ngt	
	For i = 1 to iacRows
		lObjectKey 	= ds_acdocuments.GetItemNumber(i, "ncateringobject_id")		
		sName			= ds_acdocuments.GetItemString(i, "ccatering_uo_name")	
		CatObjects[iRows+i].sType 			= sName
		CatObjects[iRows+i].lobjectkey	= lObjectKey
		uf_getobjects_detail(lObjectKey, CatObjects[iRows+i],i,ds_acdocuments)
	NEXT
	
	
	end if
	
	destroy ds_documents
	destroy ds_acdocuments
	return 1
	
end function

public function integer of_getglobalobjectexplicit (s_all_flight_infos sinfo);	String									sClassName
	INTEGER									iRet = -1
	Long										lRowCount
	uo_basisclass_catering_object		uoCatObject
	
// ----------------------------------------
// wir holen uns den Klassennamen
// und erzeugen dynamisch 
// ----------------------------------------
	SELECT 	sys_cateringobject.cclass_name  
	INTO 		:sClassName  
	FROM 		cen_catering_userobject,   
				sys_cateringobject  
	WHERE 	sys_cateringobject.ncateringobject_id = cen_catering_userobject.ncateringobject_id and  	
				cen_catering_userobject.ncatering_userobject_id = :lInheritCateringID 
	USING SQLCA;

	if SQLCA.SQLCODE <> 0 OR isNull(sClassName) Then
		sErrorText = "Error while retrieve Catering-Object-ClassName: " + string(sqlca.sqlerrtext)
		writelog(sErrorText)
		return iRet
	end if 

// ----------------------------------------
// wir fangen an
// ----------------------------------------
	uoCatObject = CREATE USING sClassName
	
	uoCatObject.lInheritCateringID 	= lInheritCateringID
	uoCatObject.dDepartureDate 		= date(sinfo.sdeparturedate)
	uoCatObject.tDepartureTime			= Time(sinfo.cdeparturetime) 
	uoCatObject.sAirline					= sinfo.sairline
	uoCatObject.iFlightNumber			= integer(sinfo.sflightnumber)
	uoCatObject.sSuffix					= sinfo.ssuffix
	uoCatObject.sDestination			= sinfo.sto
	uoCatObject.sOwner					= sinfo.sowner
	uoCatObject.sACType					= sinfo.sactype
	uoCatObject.sDateFormat				= f_getdateformat(sInfo.luser_id)			
	uoCatObject.sOrga						= sOrga
	uoCatObject.sLogopath				= sinfo.slogo_path
	uoCatObject.uoPDF						= this.uoPDF
	
	if uoCatObject.uf_createpdf() = -1 Then
		sErrorText = "Error while generate Catering-Object-Name: " + sClassName + " " + uoCatObject.sErrorText
	else
		bPDFStream 		= uoCatObject.bStream 
		sPDFFileName	= uoCatObject.sPDFFileName 
		iCopyCount		= uoCatObject.iCopyCount
		iRet = 0
	end if
	
	DESTROY uoCatObject

	return iRet


end function

on uo_catering_object_steuerung.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_catering_object_steuerung.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
dsSteuerungGlobal = CREATE DataStore

dsSteuerungGlobal.DataObject  = "dw_cateringobject_steuerung"

dsSteuerungGlobal.SetTransObject(SQLCA)

This.GetContextService ("ErrorLogging", iel_jag)




end event

event destructor;DESTROY dsSteuerungGlobal
DESTROY dsSteuerungLocal

if isValid(iel_jag) THEN setNull(iel_jag)
end event

