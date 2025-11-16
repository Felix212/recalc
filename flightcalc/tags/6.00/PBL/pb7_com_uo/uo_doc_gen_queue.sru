HA$PBExportHeader$uo_doc_gen_queue.sru
$PBExportComments$Queue for Document Generation Service
forward
global type uo_doc_gen_queue from nonvisualobject
end type
end forward

global type uo_doc_gen_queue from nonvisualobject
end type
global uo_doc_gen_queue uo_doc_gen_queue

type variables
PUBLIC:
// Public Wrappers
indirect boolean bTrace {set_trace(*value), get_trace()}
indirect boolean bCommit {set_commit(*value), get_commit()}

constant integer ci_Flight_Closed = 6

PRIVATE:
// Trace ON/OFF
boolean	ib_Trace = false

// Commit ON/OFF
boolean	ib_Commit = true
end variables

forward prototypes
public function integer of_enqueue_flight (long al_resultkey)
public function integer of_enqueue_flight (long al_resultkey, integer ai_type)
private subroutine set_trace (boolean ab_trace)
private subroutine set_commit (boolean ab_commit)
private function boolean get_commit ()
private function boolean get_trace ()
private function integer of_delete_document_entries (long al_resultkey)
private function boolean of_check_flight_departure (long al_result_key)
private function integer of_save_user_settings (datastore ads_usersettings, long al_queuekey)
public function integer of_enqueue_flights (long al_resultkeys[], integer ai_type, string as_user, string as_section, boolean ab_deleteolddocuments)
public function integer of_delete_mzv (long arg_result_key)
end prototypes

public function integer of_enqueue_flight (long al_resultkey);/*
* Objekt : uo_doc_gen_queue
* Methode: of_enqueue_flight (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 10.01.2012
*
* Argument(e):
* al_ResultKey  Der betroffene ResultKey
*
* Beschreibung: Pr$$HEX1$$fc00$$ENDHEX$$fen, ob Flug relevant f$$HEX1$$fc00$$ENDHEX$$r Doc Gen Service und ggf. einstellen in Queue
*
* Hinweis: Die Funktion ist nur noch aus Gr$$HEX1$$fc00$$ENDHEX$$nden der Abw$$HEX1$$e400$$ENDHEX$$rtskompatibilit$$HEX1$$e400$$ENDHEX$$t vorhanden.
*          Die neue Variante ist "of_enqueue_flights".
*
* Aenderungshistorie:
* Version 		Wer			Wann			   Was und warum
* 1.0 			O.Hoefer    10.01.2012		Erstellung
* 1.1 			O.Hoefer    12.09.2013		Do not enqueue flights with departure < today for document engine
* 1.2          D.Bunk      04.12.2013     Weiterleitung zur $$HEX1$$fc00$$ENDHEX$$berladenen Funktion mit ensprechendem Defaultwert
*
* Return:
*  2: Flight already in Queue
*  1: Flight successfully enqueued
*  0: Not relevant
* -1: No Settings
* -2: Error Occured
*/

return of_enqueue_flight(al_ResultKey, 1)
end function

public function integer of_enqueue_flight (long al_resultkey, integer ai_type);/*
* Objekt : uo_doc_gen_queue
* Methode: of_enqueue_flight (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 10.01.2012
*
* Argument(e):
* al_ResultKey  Der betroffene ResultKey
* ai_Type       Die Art der Generierung (1: Generic, 2: ???, 3: UserDefined)
*
* Beschreibung: Pr$$HEX1$$fc00$$ENDHEX$$fen, ob Flug relevant f$$HEX1$$fc00$$ENDHEX$$r Doc Gen Service und ggf. einstellen in Queue
*
* Hinweis: Die Funktion ist nur noch aus Gr$$HEX1$$fc00$$ENDHEX$$nden der Abw$$HEX1$$e400$$ENDHEX$$rtskompatibilit$$HEX1$$e400$$ENDHEX$$t vorhanden.
*          Die neue Variante ist "of_enqueue_flights".
*
* Aenderungshistorie:
* Version 		Wer			Wann			   Was und warum
* 1.0 			O.Hoefer	   10.01.2012		Erstellung
* 1.1 			O.Hoefer	   12.09.2013		Do not enqueue flights with departure < today for document engine
* 1.2          D.Bunk      04.12.2013     Pr$$HEX1$$fc00$$ENDHEX$$fung der Settings nicht bei UserDefined
*
* Return:
*  2: Flight already in Queue
*  1: Flight successfully enqueued
*  0: Not relevant
* -1: No Settings
* -2: Error Occured
*/

long ll_ResultKeys[]

ll_ResultKeys[1] = al_resultkey

return of_enqueue_flights(ll_ResultKeys, ai_Type, "", "", false)
end function

private subroutine set_trace (boolean ab_trace);ib_Trace = ab_Trace
end subroutine

private subroutine set_commit (boolean ab_commit);ib_Commit = ab_commit
end subroutine

private function boolean get_commit ();return ib_commit
end function

private function boolean get_trace ();return ib_Trace
end function

private function integer of_delete_document_entries (long al_resultkey);/* 
* Beschreibung: 	Hilfsfunktion der Doc Engine Queue, um alte Dokumenteneintr$$HEX1$$e400$$ENDHEX$$ge zu l$$HEX1$$f600$$ENDHEX$$schen
* Besonderheit: 	keine
* 
* Argumente:
* 	Name          Beschreibung
*	al_ResultKey  Der betroffene ResultKey
*
* Aenderungshistorie:
* 	Version 		Wer			Wann			Was und warum
*	1.0 			D.Bunk		04.12.13		Erstellung
*
* Return Codes:
*	0: OK
*/	

integer li_Return
long ll_Transaction

// Defaults setzen
li_Return = 0

// Transaktion ermitteln
SELECT ntransaction INTO :ll_Transaction FROM cen_out WHERE nresult_key = :al_ResultKey USING SQLCA;

// Alte Dokumenten-Eintr$$HEX1$$e400$$ENDHEX$$ge (aller Benutzer) l$$HEX1$$f600$$ENDHEX$$schen
if SQLCA.SQLCode = 0 then
	DELETE FROM cen_out_documents
			WHERE nresult_key = :al_ResultKey
			  AND ntransaction = :ll_Transaction
			USING SQLCA;
			
	if SQLCA.SQLCode <> 0 then
		if ib_Trace then f_trace("Failed to delete old document entries [" + String(al_ResultKey) + ", " + String(ll_Transaction) + "]: " + SQLCA.SQLErrText)
	end if
			
	DELETE FROM cen_out_labels
			WHERE nresult_key = :al_ResultKey
			  AND ntransaction = :ll_Transaction
			USING SQLCA;
			
	if SQLCA.SQLCode <> 0 then	
		if ib_Trace then f_trace("Failed to delete old label entries [" + String(al_ResultKey) + ", " + String(ll_Transaction) + "]: " + SQLCA.SQLErrText)
	end if
end if

return li_Return
end function

private function boolean of_check_flight_departure (long al_result_key);/*
* Objekt : uo_doc_gen_queue
* Methode: of_check_flight_departure (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 12.09.2013
*
* Argument(e):
* long al_result_key
*
* Beschreibung: Don't enqueue old flights
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	12.09.2013		Erstellung
* 1.1 			O.Hoefer	12.09.2013		Don't enqueue flights > Flight Closed
* 1.2 			O.Hoefer	02.11.2016		IM11666092 wegen Tageswechsel / NAM Tagesdatum mit Reserve (halber Tag)
*
*
* Return: boolean
*
*/


Boolean	lb_Return = FALSE
Date		ldt_Today
Date		ldt_Departure
Long		ll_Status


SELECT		ddeparture, sysdate - 0.5 , nstatus  
INTO			:ldt_Departure  , :ldt_Today, :ll_Status
FROM			cen_out  
WHERE			nresult_key = :al_Result_key   ;



//SELECT		ddeparture, sysdate, nstatus  
//INTO			:ldt_Departure  , :ldt_Today, :ll_Status
//FROM			cen_out  
//WHERE			nresult_key = :al_Result_key   ;

If SQLCA.SQLCode <> 0 then
	// Error
Else
	If ldt_Departure >= ldt_Today Then
		// Departure >= Today => OK
		lb_Return = TRUE
	Else
		// Departure < Today => NOT OK
		lb_Return = FALSE
	End If
End If
	
If lb_Return = TRUE Then
	// Status
	If ll_Status > ci_Flight_Closed Then
		lb_Return = FALSE
	End If
End If
	

Return lb_Return
end function

private function integer of_save_user_settings (datastore ads_usersettings, long al_queuekey);/* 
* Beschreibung: 	Hilfsfunktion der Doc Engine Queue, um Benutzereinstellungen zu speichern
* Besonderheit: 	keine
* 
* Argumente:
* 	Name              Beschreibung
*	ads_UserSettings  Ein gef$$HEX1$$fc00$$ENDHEX$$lltes DataStore der Benutzereinstellungen
*  al_QueueKey       Der DocEngine-QueueKey, f$$HEX1$$fc00$$ENDHEX$$r den die Benutzereinstellungen hinterlegt werden sollen
*
* Aenderungshistorie:
* 	Version 		Wer			Wann			Was und warum
*	1.0 			D.Bunk		05.12.13		Erstellung
*
* Return Codes:
*	0: OK
* -1: Fehler
*/	

integer li_Return
long i, a, ll_SequenceParams
datastore lds_QueueSettingsInsert

// Defaults setzen
li_Return = 0

lds_QueueSettingsInsert = create datastore
lds_QueueSettingsInsert.DataObject = "dw_gen_queue_ud_insert"
lds_QueueSettingsInsert.SetTransObject(SQLCA)

for i = 1 to ads_UserSettings.RowCount()
	ll_SequenceParams = f_sequence("seq_cen_doc_gen_ud", SQLCA)

	if ll_SequenceParams <= 0 then
		if ib_Trace then f_trace("Failed to get new sequence for cen_doc_gen_ud")
		li_Return = -1
	end if
	
	if li_Return = 0 then
		a = lds_QueueSettingsInsert.InsertRow(0)
		lds_QueueSettingsInsert.SetItem(a, "ngen_ud_index", ll_SequenceParams)
		lds_QueueSettingsInsert.SetItem(a, "ndoc_gen_queue_key", al_QueueKey)
		lds_QueueSettingsInsert.SetItem(a, "csection", ads_UserSettings.GetItemString(i, "csection"))
		lds_QueueSettingsInsert.SetItem(a, "ckey", ads_UserSettings.GetItemString(i, "ckey"))
		lds_QueueSettingsInsert.SetItem(a, "cvalue", ads_UserSettings.GetItemString(i, "cvalue"))
	else 
		exit
	end if
next

// Speichern (an der Stelle ohne Commit!)
if lds_QueueSettingsInsert.update() = -1 then
	li_Return = -1
end if

// Aufr$$HEX1$$e400$$ENDHEX$$umen
destroy lds_QueueSettingsInsert

return li_Return
end function

public function integer of_enqueue_flights (long al_resultkeys[], integer ai_type, string as_user, string as_section, boolean ab_deleteolddocuments);/*
* Objekt : uo_doc_gen_queue
* Methode: of_enqueue_flights (Function)
* Autor  : Dirk Bunk
* Datum  : 10.01.2012
*
* Argument(e):
* al_ResultKeys          		Ein Long-Array der betroffene ResultKeys
* ai_Type                			Die Art der Generierung (1: Generic, 2: Secondary Distribution, 3: User Defined)
* as_User                			Der Benutzer, f$$HEX1$$fc00$$ENDHEX$$r den der Flug eingestellt werden soll
* as_Section             		Die Profile-Section, des Setups bei einer UserDefined Generierung
* ab_DeleteOldDocuments	Gibt an, ob alte Dokumenteneintr$$HEX1$$e400$$ENDHEX$$ge aus der Tabelle gel$$HEX1$$f600$$ENDHEX$$scht werden sollen, bevor der neue Auftrag in die Queue gestellt wird
*
* Beschreibung: Pr$$HEX1$$fc00$$ENDHEX$$fen, ob Flug relevant f$$HEX1$$fc00$$ENDHEX$$r Doc Gen Service und ggf. einstellen in Queue 
*
* Aenderungshistorie:
* Version 	Wer				Wann			  	Was und warum
* 1.0 			D.Bunk	   		04.12.2013		Erstellung
* 1.1          	D.Bunk      		13.12.2013     	Abflugdatum bei UserDefined nicht pr$$HEX1$$fc00$$ENDHEX$$fen
* 1.2			H.Rothenbach	29.01.2014		Bei 'nicht 1.Leg Fl$$HEX1$$fc00$$ENDHEX$$gen' soll auch ein Auftrag f$$HEX1$$fc00$$ENDHEX$$r Leg1 eingestellt werden
*
* Return:
*  2: Flight already in Queue
*  1: Flight successfully enqueued
*  0: Not relevant
* -1: No Settings
* -2: Error Occured
*/

integer li_Return, iRet
string ls_Airline, ls_Unit, ls_Error, ls_AlternateSection
long i, j, ll_ResultKey, ll_AirlineKey, ll_Setting, ll_QueueKey, ll_Jobs, ll_UserId, ll_ResultKey_Group
boolean lb_Ok, lb_UserSettingsFound
datastore lds_UserSettings, lds_UserSettingsDefault

constant integer TYPE_GENERIC = 1
constant integer TYPE_USERDEFINED = 3

lds_UserSettings = create datastore
lds_UserSettings.DataObject = "dw_gen_queue_ud_setup"
lds_UserSettings.SetTransObject(SQLCA)

lds_UserSettingsDefault = create datastore
lds_UserSettingsDefault.DataObject = "dw_gen_queue_ud_setup"
lds_UserSettingsDefault.SetTransObject(SQLCA)


////////////////////////////////////////////////////
// Bei der Benutzerdefinierten Generierung m$$HEX1$$fc00$$ENDHEX$$ssen //
// auch die Benutzereinstellungen geladen werden. //
////////////////////////////////////////////////////
if ai_Type = TYPE_USERDEFINED then
	////////////////////////////////////
	// Benutzereinstellungen auslesen //
	////////////////////////////////////
	lb_UserSettingsFound = false
	lds_UserSettings.Retrieve(as_section, as_user)
	
	if ib_Trace then f_trace("uo_document.of_create_udf lds_UserSettings.Retrieve " + String(lds_UserSettings.RowCount()) + " rows" )
	
	if lds_UserSettings.RowCount() > 0 then lb_UserSettingsFound = true


	/////////////////////////////////////////////////////////////////
	// Da CartDiagram-Einstellungen eine andere Section verwenden, //
	// m$$HEX1$$fc00$$ENDHEX$$ssen wir diese noch zus$$HEX1$$e400$$ENDHEX$$tzlich auslesen.                  //
	/////////////////////////////////////////////////////////////////
	ls_AlternateSection = "Default"
	if Left(Upper(as_Section), Len("docbrowser")) = "DOCBROWSER" then
		if Len(as_section) > Len("DOCBROWSER") then
			ls_AlternateSection += Mid(as_section, Len("DOCBROWSER") + 1)
		end If
	end If

	lds_UserSettingsDefault.Retrieve(ls_AlternateSection, as_user)
	
	if ib_Trace then f_trace("uo_document.of_create_udf lds_UserSettingsDefault.Retrieve " + String(lds_UserSettingsDefault.RowCount()) + " rows" )
	
	if lds_UserSettingsDefault.RowCount() > 0 then lb_UserSettingsFound = true
end if


//////////////////////////////////////////////////////
// Alle Fl$$HEX1$$fc00$$ENDHEX$$ge durchgehen und in die Queue eintragen //
//////////////////////////////////////////////////////
for i=1 to UpperBound(al_ResultKeys)
	ll_ResultKey = al_ResultKeys[i]
	lb_Ok = true
	
	
	/////////////////////////////////
	// UserDefined Settings pr$$HEX1$$fc00$$ENDHEX$$fen //
	/////////////////////////////////
	if ai_Type = TYPE_USERDEFINED and not lb_UserSettingsFound then
		li_Return = -1
		lb_Ok = false
	end if
	
	
	///////////////////////////////////////////////////////////
	// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob der Flug vom Abflugsdatum her relevant ist //
	///////////////////////////////////////////////////////////
	if lb_Ok and ai_Type <> TYPE_USERDEFINED then
		if not of_check_flight_departure(ll_ResultKey) then
			f_trace("Doc Engine of_enqueue_flight DEPARTURE < Today " + String(ll_ResultKey))
			li_Return = 0
			lb_Ok = false
		end if
	end if
	
	
	/////////////////////////////////////////
	// Zus$$HEX1$$e400$$ENDHEX$$tzliche Informationen ermitteln //
	/////////////////////////////////////////
	if lb_Ok then
		// 29.01.2014 HR: Result_key_group mit lesen
		SELECT cairline, nairline_key, cunit, nresult_key_group  
		  INTO :ls_airline, :ll_AirlineKey, :ls_unit, :ll_ResultKey_Group
		  FROM cen_out  
		 WHERE cen_out.nresult_key = :ll_ResultKey
		 USING SQLCA;
		 
		// Check SQLCode
		if SQLCA.SQLCode <> 0 then
			ls_Error = SQLCA.SQLErrtext
			if ib_Trace then f_trace("Datenbankfehler " + ls_Error)
			li_Return = -2
			lb_Ok = false
		end if
		
		if lb_Ok then
			if IsNull(as_User) or Trim(as_User) = "" then
				SetNull(as_User)
				SetNull(ll_UserId)
			else
				SELECT nuser_id INTO :ll_UserId FROM sys_login WHERE cusername = :as_User USING SQLCA;
				
				// Check SQLCode
				if SQLCA.SQLCode <> 0 then
					ls_Error = SQLCA.SQLErrtext
					if ib_Trace then f_trace("Datenbankfehler " + ls_Error)
					li_Return = -2
					lb_Ok = false
				end if
			end if
		end if
	end if
		
	
	/////////////////////////
	// Settings $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen //
	/////////////////////////
	if lb_Ok then
		// Check if Doc Gen is enabled for Airline + Unit
		if ai_type = TYPE_USERDEFINED then
			ll_Setting = 1
		else
			SELECT cen_airline_unit.nenable_doc_gen INTO :ll_Setting FROM cen_airline_unit  
			 WHERE cen_airline_unit.nairline_key = :ll_AirlineKey AND cen_airline_unit.cunit = :ls_unit
			 USING SQLCA;
			
			// Check SQLCode
			if SQLCA.SQLCode <> 0 then
				ll_Setting = 0
				lb_Ok = false
				
				if SQLCA.SQLCode = 100 then
					// No Settings found
					if ib_Trace then f_trace("Keine Einstellungen f$$HEX1$$fc00$$ENDHEX$$r Dokumentengenerierung gefunden")
					li_Return = -1
				else
					ls_Error = SQLCA.SQLErrtext
					if ib_Trace then f_trace("Datenbankfehler " + ls_Error)
					li_Return = -2
				end if
			end if
		end if
		
		if ll_Setting = 0 then
			// Setting = OFF
			if ib_Trace then f_trace("Dokumentengenerierung f$$HEX1$$fc00$$ENDHEX$$r Airline & Betrieb inaktiv")
			li_return = 0
			lb_Ok = false
		end if
	end if
	
	// --------------------------------------------------------------------------------------------------------------------
	// 29.01.2014 HR: CBASE-NAM-CR-14007WEB: Wenn f$$HEX1$$fc00$$ENDHEX$$r ein 'nicht 1.Leg' eine Auftrag erstellt wurde, dann
	//                                                                  soll auch ein Auftrag f$$HEX1$$fc00$$ENDHEX$$rs 1.Leg erstellt werden
	// --------------------------------------------------------------------------------------------------------------------
	for j=1 to 2

		// 29.01.2014 HR: Im 2. Durchlauf erstellen wir einen Auftrag f$$HEX1$$fc00$$ENDHEX$$rs 1. Leg
		if j=2 then ll_ResultKey = ll_ResultKey_Group
		
		////////////////////////////////////////////////////////
		// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob der Flug nicht bereits in der Queue ist //
		////////////////////////////////////////////////////////
		if lb_Ok then
			// Flight already in Queue?
			SELECT count(*) INTO :ll_jobs FROM cen_doc_gen_queue 
			 WHERE nresult_key = :ll_ResultKey AND ngen_status = 0
			 USING SQLCA;
			 
			 if ll_jobs > 0 then
				if ib_Trace then f_trace("Dokumentengenerierung f$$HEX1$$fc00$$ENDHEX$$r diesen Flug bereits in Queue")
				li_return = 2
				
				// 29.01.2014 HR: Wenn Auftragsleg = Erstes Leg oder Auftragtyp ist Userdefined, dann wie gehabt ansonsten 1. Leg verarbeiten 
				if ll_ResultKey_Group = ll_ResultKey or  ai_Type = TYPE_USERDEFINED then 
					lb_Ok = false
				else
					continue
				end if
			end If
		end if
		
		////////////////////////////////////////////
		// Evtl. alte Dokumenten Eintr$$HEX1$$e400$$ENDHEX$$ge l$$HEX1$$f600$$ENDHEX$$schen //
		////////////////////////////////////////////
		if lb_Ok then	
			if ab_DeleteOldDocuments then 
				of_delete_document_entries(ll_ResultKey)
			end if
		end if
		
		////////////////////////////////////////
		// Neuen Eintrag in die Queue stellen //
		////////////////////////////////////////
		if lb_Ok then	
			
			if j=2 then
				// --------------------------------------------------------------------------------------------------------------------
				// 24.04.2014 HR: Bei $$HEX1$$c400$$ENDHEX$$nderungen ab 2. Leg m$$HEX1$$fc00$$ENDHEX$$ssen wir die gespeicherten MZ-Verteilungen l$$HEX1$$f600$$ENDHEX$$schen, 
				//                        damit diese neu erstellt werden
				// --------------------------------------------------------------------------------------------------------------------
				iRet = of_delete_mzv(ll_ResultKey_Group)
			end if
			
			// Neuen Eintrag in die Queue stellen
			ll_QueueKey = f_Sequence("SEQ_CEN_DOC_GEN_QUEUE", SQLCA)
			if ll_QueueKey <> -1 then
				INSERT INTO cen_doc_gen_queue (ndoc_gen_queue_key, nresult_key, ngen_status, cairline, cunit, njob_type, nuser_id, cusername)  
					  VALUES (:ll_QueueKey, :ll_ResultKey, 0, :ls_Airline, :ls_Unit, :ai_Type, :ll_UserId, :as_User)
						USING SQLCA;
				
				// Check SQLCode
				if SQLCA.SQLCode <> 0 then
					ls_Error = SQLCA.SQLErrtext
					if ib_Trace then f_trace("Datenbankfehler " + ls_Error)						
					li_Return = -2
					lb_Ok = false
				else
					if ib_Trace then f_trace("Dokumentengenerierung f$$HEX1$$fc00$$ENDHEX$$r diesen Flug wurde in Queue gestellt")				
					li_Return = 1
				end if
			end if
		end If
		
		
		////////////////////////////////////////////////////////////
		// Bei der Benutzerdefinierten Generierung m$$HEX1$$fc00$$ENDHEX$$ssen         //
		// die Benutzereinstellungen pro Flug gespeichert werden. //
		////////////////////////////////////////////////////////////
		if lb_Ok then
			if ai_Type = TYPE_USERDEFINED then
				if of_save_user_settings(lds_UserSettings, ll_QueueKey) <> 0 then
					if ib_Trace then f_trace("Failed to insert queue entry [" + String(ll_QueueKey) + "] for user: " + as_user + " section: " + as_Section)
					li_return = -2
				end if
				
				if of_save_user_settings(lds_UserSettingsDefault, ll_QueueKey) <> 0 then
					if ib_Trace then f_trace("Failed to insert queue entry [" + String(ll_QueueKey) + "] for user: " + as_user + " section: " + ls_AlternateSection)
					li_return = -2
				end if
			end if
		end if

		if li_return < 0 then exit
		
		// 29.01.2014 HR: Wenn Auftragsleg = Erstes Leg oder Auftragtype ist Userdefined, dann raus hier
		if ll_ResultKey_Group = ll_ResultKey or ai_Type = TYPE_USERDEFINED then exit
	next
	
	//////////////////////////////////////
	// Wenn ein Fehler aufgetreten ist, //
	// gar nicht erst weitermachen.     //
	//////////////////////////////////////
	if li_return < 0 then exit
next


//////////////////////////////////////////
// Evtl. Rollback bzw. Commit ausf$$HEX1$$fc00$$ENDHEX$$hren //
//////////////////////////////////////////
if li_return < 0 then
	if ib_Commit then 
		ROLLBACK USING SQLCA;
	end if
else
	if ib_Commit then 
		COMMIT USING SQLCA;
	end if
end if


///////////////
// Aufr$$HEX1$$e400$$ENDHEX$$umen //
///////////////
destroy lds_UserSettings
destroy lds_UserSettingsDefault

return li_Return
end function

public function integer of_delete_mzv (long arg_result_key);string ls_error

  DELETE FROM cen_out_md  
   WHERE nresult_key = :arg_result_key   
  USING SQLCA;

if SQLCA.SQLCode <> 0 then
	ls_Error = SQLCA.SQLErrtext
	if ib_Trace then f_trace("[of_delete_mzv] cen_out_md ("+string(arg_result_key)+"): Datenbankfehler " + ls_Error)						
	return -1
end if

  DELETE FROM cen_out_md_blob  
   WHERE nresult_key = :arg_result_key   
  USING SQLCA;

if SQLCA.SQLCode <> 0 then
	ls_Error = SQLCA.SQLErrtext
	if ib_Trace then f_trace("[of_delete_mzv] cen_out_md_blob ("+string(arg_result_key)+"): Datenbankfehler " + ls_Error)						
	return -1
end if

  DELETE FROM cen_out_md_co
   WHERE nresult_key = :arg_result_key   
  USING SQLCA;

if SQLCA.SQLCode <> 0 then
	ls_Error = SQLCA.SQLErrtext
	if ib_Trace then f_trace("[of_delete_mzv] cen_out_md_co ("+string(arg_result_key)+"): Datenbankfehler " + ls_Error)						
	return -1
end if

  DELETE FROM cen_out_md_de
   WHERE nresult_key = :arg_result_key   
  USING SQLCA;

if SQLCA.SQLCode <> 0 then
	ls_Error = SQLCA.SQLErrtext
	if ib_Trace then f_trace("[of_delete_mzv] cen_out_md_de ("+string(arg_result_key)+"): Datenbankfehler " + ls_Error)						
	return -1
end if

  DELETE FROM cen_out_md_lo
   WHERE nresult_key = :arg_result_key   
  USING SQLCA;

if SQLCA.SQLCode <> 0 then
	ls_Error = SQLCA.SQLErrtext
	if ib_Trace then f_trace("[of_delete_mzv] cen_out_md_lo ("+string(arg_result_key)+"): Datenbankfehler " + ls_Error)						
	return -1
end if

  DELETE FROM cen_out_md_ps
   WHERE nresult_key = :arg_result_key   
  USING SQLCA;

if SQLCA.SQLCode <> 0 then
	ls_Error = SQLCA.SQLErrtext
	if ib_Trace then f_trace("[of_delete_mzv] cen_out_md_ps ("+string(arg_result_key)+"): Datenbankfehler " + ls_Error)						
	return -1
end if

return 1
end function

on uo_doc_gen_queue.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_doc_gen_queue.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

