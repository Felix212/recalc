HA$PBExportHeader$uo_request_out.sru
forward
global type uo_request_out from nonvisualobject
end type
end forward

global type uo_request_out from nonvisualobject
end type
global uo_request_out uo_request_out

type variables
CONSTANT Integer		II_REQUEST_TYPE_PAX = 3
CONSTANT Integer		II_REQUEST_TYPE_WAB = 4

// Letzte Job Nr fuer diesen Flug
Long		il_job_nr_last
// Neue Job Nr fuer diesen Flug
Long		il_job_nr

// Aktueller Aircraft-Key am Flug
Long		il_aircraft_key
// Zuletzt uebermittelter Aircraft-Key
Long		il_aircraft_key_last

//DataStore ids_store_cen_request_out
uo_cbase_DataStore ids_store_cen_request_out
DataStore ids_store_cen_request_out_pax
uo_cbase_datastore	ids_store_cen_request_out_wab



end variables

forward prototypes
public function boolean uf_request_out_manu_2 (integer ai_request_type)
public function boolean uf_request_out_auto (long al_nresult_key)
public function boolean uf_request_out_auto_wab (long al_nresult_key, ref string as_msg)
protected function boolean uf_get_cen_out_data (long al_nresult_key, boolean ab_pax)
protected function boolean uf_get_last_request_out (long al_nresult_key, boolean ab_wab)
protected function boolean uf_store_request_out (integer ai_request_type)
public function boolean uf_request_out_manu_1 (long al_nresult_key)
end prototypes

public function boolean uf_request_out_manu_2 (integer ai_request_type);
// -----------------------------------------------------------------------------------------------------------------------------------------
// Objekt : uo_request_out
// Methode: uf_request_out_manu_2 (Function)
// Autor  :
// -----------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// -----------------------------------------------------------------------------------------------------------------------------------------
// Return: boolean
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung: 	Abschlu$$HEX1$$df00$$ENDHEX$$funktion bei Aufruf aus w_send_jfe
//						-	Speichern der Transferdaten
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version		Autor              			     Kommentar
// -----------------------------------------------------------------------------------------------------------------------------------------
//  03.07.2013	1.00			Thomas Brackmann		Erstellung
//  04.11.2015	1.10			Thomas Schaefer			Weight And Balance eingebaut und vereinfacht
// -----------------------------------------------------------------------------------------------------------------------------------------
Boolean	lb_ret

// CEN_REQUEST_OUT-DataStores speichern
lb_ret = uf_store_request_out(ai_request_type)

DESTROY ids_store_cen_request_out
DESTROY ids_store_cen_request_out_pax
DESTROY ids_store_cen_request_out_wab

RETURN lb_ret

end function

public function boolean uf_request_out_auto (long al_nresult_key);
// -----------------------------------------------------------------------------------------------------------------------------------------
// Objekt : uo_request_out
// Methode: uf_request_out_auto (Function)
// Autor  :
// -----------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long 		al_nresult_key
// -----------------------------------------------------------------------------------------------------------------------------------------
// Return: boolean
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung:	Einstiegsfunktion bei automatischem Aufruf aus w_change_center (wf_transfer_jfe)
//
//						-	Holt die CEN_OUT-Daten des Fluge 
//						-	aktualisiert sie mit zuvor ggf. eigegebenen Transfer-Daten
//						-	und speichert sie in die CEN_REQUEST_OUT-Strukturen ab
//
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version		Autor              			     Kommentar
// -----------------------------------------------------------------------------------------------------------------------------------------
//  03.07.2013	1.00			Thomas Brackmann		Erstellung
//	25.01.2015	1.10			Thomas Schaefer			Umbau wegen WAB
// -----------------------------------------------------------------------------------------------------------------------------------------

Boolean		lb_ret
Integer		li_rc

// DataWindow instanzieren ...
ids_store_cen_request_out 						= 	CREATE uo_cbase_DataStore
ids_store_cen_request_out.DataObject 		= 	"dw_store_cen_request_out"
ids_store_cen_request_out.SetTransObject(SQLCA)

ids_store_cen_request_out_pax				= 	CREATE DataStore
ids_store_cen_request_out_pax.DataObject = 	"dw_store_cen_request_out_pax"
ids_store_cen_request_out_pax.SetTransObject(SQLCA)

// Einlesen CEN_OUT-Daten in CEN_REQUEST_OUT-DataStores umlesen
lb_ret = uf_get_cen_out_data(al_nresult_key, TRUE)

IF lb_ret THEN
	// Das CEN_REQUEST_OUT Kopfdaten-DataStore mit den letzten gespeicherten CEN_REQUEST_OUT-Daten aktualisieren
	lb_ret = uf_get_last_request_out(al_nresult_key, False)
	
	IF lb_ret THEN
		// CEN_REQUEST_OUT-DataStores speichern
		lb_ret = uf_store_request_out(THIS.II_REQUEST_TYPE_PAX)
	END IF
END IF

// Aufr$$HEX1$$e400$$ENDHEX$$umen ...
IF IsValid(ids_store_cen_request_out) THEN DESTROY ids_store_cen_request_out
IF IsValid(ids_store_cen_request_out_pax) THEN DESTROY ids_store_cen_request_out_pax

RETURN lb_ret

end function

public function boolean uf_request_out_auto_wab (long al_nresult_key, ref string as_msg);
/* 
* Function: 			uf_request_out_auto_wab
* Beschreibung: 	Speichert die aktuellen Galley-Gewichtsdaten f$$HEX1$$fc00$$ENDHEX$$r den $$HEX1$$fc00$$ENDHEX$$bergebenen Flug in cen_request_out
* Besonderheit: 	...
*
* Argumente:
* 		al_nresult_key 		Flug
*
* Aenderungshistorie:
* 	Version 	Wer					Wann				Was und warum
*	1.0 		Thomas Schaefer	25.01.2016		Erstellung
*
* Return Codes:
*	 ...
*/
Long			ll_jobnr
String			ls_hostname
String			ls_msg

ls_hostname = s_app.shost

DECLARE pf_flightweights2requestout PROCEDURE FOR CBASE_WAB.pf_flightweights2requestout(:al_nresult_key, :ls_hostname);
EXECUTE pf_flightweights2requestout;
IF SQLCA.SQLCode = -1 THEN
	as_msg = "Error Executing CBASE_WAB.pf_flightweights2requestout. SQLCA.SqlCode: " + String(SQLCA.SQLCode) + " - " + SQLCA.SQLErrText
	CLOSE pf_flightweights2requestout;
	Return False
END IF

FETCH pf_flightweights2requestout INTO :ll_jobnr, :ls_msg;
IF SQLCA.SQLCode = -1 THEN
	as_msg = "Error Fetching CBASE_WAB.pf_flightweights2requestout. SQLCA.SqlCode: " + String(SQLCA.SQLCode) + " - " + SQLCA.SQLErrText
	CLOSE pf_flightweights2requestout;
	Return False
END IF

as_msg = ls_msg
CLOSE pf_flightweights2requestout;

Return true

end function

protected function boolean uf_get_cen_out_data (long al_nresult_key, boolean ab_pax);
// -----------------------------------------------------------------------------------------------------------------------------------------
// Objekt : uo_request_out
// Methode: uf_get_cen_out_data (Function)
// Autor  :
// -----------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long al_nresult_key
// -----------------------------------------------------------------------------------------------------------------------------------------
// Return: boolean
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Einlesen der CEN_OUT-Daten eines Fluges und $$HEX1$$fc00$$ENDHEX$$bertragen in die CEN_REQUEST_OUT-DataStores
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version		Autor              			     Kommentar
// -----------------------------------------------------------------------------------------------------------------------------------------
//  03.07.2013	1.00			Thomas Brackmann		Erstellung
//  03.11.2015	1.10			Thomas Schaefer			$$HEX1$$c400$$ENDHEX$$nderugen fuer Weight and Balance:
//																	Aircraft-Key hinzugef$$HEX1$$fc00$$ENDHEX$$gt an cen_request_out, JobNr und RequestType
//																	noch nicht festlegen
//  27.01.2016	1.20			Oliver H$$HEX1$$f600$$ENDHEX$$fer					Abfertigungsart "INT" CBASE-BRU-CR-2015-014
// -----------------------------------------------------------------------------------------------------------------------------------------

Long				ll_rc
Long				ll_nairline_key
String				ls_chostname
String				ls_cclient
String				ls_cunit
Integer			li_nrequest_type
Long				ll_nresult_key
Long				ll_result_keys[]
String				ls_cairline
Integer			li_nflight_number
String				ls_csuffix
DateTime		ldt_ddeparture
String				ls_cdeparture_time
DateTime		ldt_ddeparture_local
String				ls_cdeparture_time_local
String				ls_ctlc_from
String				ls_ctlc_to
DateTime		ldt_dcreated
Integer			li_nstatus
String				ls_cflight_key
Long				ll_ntransaction
Long				ll_rownum
Long				ll_actnum
String				ls_cclass_name

Integer			li_nclass_number
String				ls_cclass
Integer			li_nfunction
Integer			li_npax
String				ls_ccomment

String 			ls_filter

DataStore lds_change_cen_out
DataStore lds_change_cen_out_passenger
DataStore lds_flight_legs

// DataStores initialisieren...
lds_change_cen_out 					= 	CREATE DataStore
lds_change_cen_out.DataObject 	= "dw_change_cen_out"
lds_change_cen_out.SetTransObject(sqlca)
ll_rc = lds_change_cen_out.Retrieve(al_nresult_key)

// --------------------------------------------------------------------------------------------------------------------
// 25.03.2014 HR: F$$HEX1$$fc00$$ENDHEX$$r den Punkt 8 Regelwerk m$$HEX1$$fc00$$ENDHEX$$ssen wir noch pr$$HEX1$$fc00$$ENDHEX$$fen, ob es den Flug f$$HEX1$$fc00$$ENDHEX$$r mehrere 
//                        deutsche Betriebe gibt
// --------------------------------------------------------------------------------------------------------------------

IF lds_change_cen_out.rowcount() = 0 THEN
	DESTROY lds_change_cen_out
	Return False
END IF

lds_flight_legs 					= 	CREATE DataStore
lds_flight_legs.DataObject 	= "dw_request_out_resultkeys"
lds_flight_legs.SetTransObject(sqlca)
lds_flight_legs.Retrieve(lds_change_cen_out.getitemstring(1, "cairline"), lds_change_cen_out.getitemnumber(1, "nflight_number"), lds_change_cen_out.getitemstring(1, "csuffix"),date( lds_change_cen_out.getitemdatetime(1, "ddeparture")))

if  lds_flight_legs.rowcount()>1 then
	// 27.01.2016 Abfertigungsart INT CBASE-BRU-CR-2015-014
	if lds_flight_legs.find("chandling_type_text = 'REQ'", 1,  lds_flight_legs.rowcount())>0 or &
	   lds_flight_legs.find("chandling_type_text = 'DLV'", 1,  lds_flight_legs.rowcount())>0 or &
	   lds_flight_legs.find("chandling_type_text = 'INT'", 1,  lds_flight_legs.rowcount())>0  then
		
		for ll_rownum = 1 to  lds_flight_legs.rowcount()
			ll_result_keys[ll_rownum] = lds_flight_legs.getitemnumber(ll_rownum, "nresult_key")
		next
	else
		
		//Punkt 8.2 wird erst mal so interpretiert, dass wir dann den ge$$HEX1$$e400$$ENDHEX$$nderten Flug $$HEX1$$fc00$$ENDHEX$$bertragen
		ll_result_keys[1] = al_nresult_key
		
	end if
else
	//ge$$HEX1$$e400$$ENDHEX$$nderte Flug $$HEX1$$fc00$$ENDHEX$$bertragen
	ll_result_keys[1] = al_nresult_key
end if

DESTROY lds_flight_legs	  
		  
// Daten aus cen_out lesen ...
IF 	lds_change_cen_out.RowCount() > 0 THEN
	
	il_job_nr							= 		0	// hier noch nicht, sondern erst beim Senden: f_sequence("seq_cen_request_out", sqlca)
	ls_chostname					=		s_app.shost
	ls_cclient							=		lds_change_cen_out.GetItemString(1,"cclient")
	ls_cunit							=		lds_change_cen_out.GetItemString(1,"cunit")
	li_nrequest_type				=		0	// das auch erst beim Speichern festlegen
	ll_nresult_key					=		lds_change_cen_out.GetItemNumber(1,"nresult_key")
	ll_nairline_key					=		lds_change_cen_out.GetItemNumber(1,"nairline_key")
	ls_cairline						=		lds_change_cen_out.GetItemString(1,"cairline")
	li_nflight_number				=		lds_change_cen_out.GetItemNumber(1,"nflight_number")
	ls_csuffix							=		lds_change_cen_out.GetItemString(1,"csuffix")

	// 16.05.2014 HR: 4.99-171: Hier soll das richtige Datum angezeigt werden und nicht das vom 1. Leg
	//ldt_ddeparture					=		lds_change_cen_out.GetItemDateTime(1,"ddeparture")	
	ldt_ddeparture					=		lds_change_cen_out.GetItemDateTime(1,"dreturn_date")	

	ls_cdeparture_time			=		lds_change_cen_out.GetItemString(1,"cdeparture_time")
	ldt_ddeparture_local			=		lds_change_cen_out.GetItemDateTime(1,"ddeparture_time_loc")	
	ls_cdeparture_time_local		=		MId(String(lds_change_cen_out.GetItemDateTime(1,"ddeparture_time_loc")),12,5)	
	ls_ctlc_from						=		lds_change_cen_out.GetItemString(1,"ctlc_from")
	ls_ctlc_to							=		lds_change_cen_out.GetItemString(1,"ctlc_to")
	ldt_dcreated						=		Datetime(today(), now())
	li_nstatus						=		0 // 22.07.2013 HR: von 1 auf 0 ge$$HEX1$$e400$$ENDHEX$$ndert
	ls_cflight_key					=		lds_change_cen_out.GetItemString(1,"cflight_key")
	ll_ntransaction					=		lds_change_cen_out.GetItemNumber(1,"ntransaction")
	il_aircraft_key					=		lds_change_cen_out.GetItemNumber(1,"naircraft_key")

	// cen_request_out Daten bef$$HEX1$$fc00$$ENDHEX$$llen ...
	ids_store_cen_request_out.InsertRow(0)
	
	ids_store_cen_request_out.SetItem(1,"njob_nr",il_job_nr)
	ids_store_cen_request_out.SetItem(1,"chostname",ls_chostname)
	ids_store_cen_request_out.SetItem(1,"cclient",ls_cclient)
	ids_store_cen_request_out.SetItem(1,"cunit",ls_cunit)
	ids_store_cen_request_out.SetItem(1,"nrequest_type",li_nrequest_type)
	ids_store_cen_request_out.SetItem(1,"nresult_key",ll_nresult_key)
	ids_store_cen_request_out.SetItem(1,"cairline",ls_cairline)
	ids_store_cen_request_out.SetItem(1,"nflight_number",li_nflight_number)
	ids_store_cen_request_out.SetItem(1,"csuffix",ls_csuffix)
	ids_store_cen_request_out.SetItem(1,"ddeparture",ldt_ddeparture)
	ids_store_cen_request_out.SetItem(1,"cdeparture_time",ls_cdeparture_time)
	ids_store_cen_request_out.SetItem(1,"ddeparture_local",ldt_ddeparture_local)
	ids_store_cen_request_out.SetItem(1,"cdeparture_time_local",ls_cdeparture_time_local)
	ids_store_cen_request_out.SetItem(1,"ctlc_from",ls_ctlc_from)
	ids_store_cen_request_out.SetItem(1,"ctlc_to",ls_ctlc_to)
	ids_store_cen_request_out.SetItem(1,"dcreated",ldt_dcreated)
	ids_store_cen_request_out.SetItem(1,"nstatus",li_nstatus)
	ids_store_cen_request_out.SetItem(1,"cflight_key",ls_cflight_key)
	ids_store_cen_request_out.SetItem(1,"ntransaction",ll_ntransaction)
	ids_store_cen_request_out.SetItem(1,"naircraft_key",il_aircraft_key)

	IF ab_pax THEN
		lds_change_cen_out_passenger  	= 	CREATE DataStore
		//lds_change_cen_out_passenger.DataObject 	= "dw_change_cen_out_passenger"
		lds_change_cen_out_passenger.DataObject 	= "dw_request_out_resultkeys_pax"
		lds_change_cen_out_passenger.SetTransObject(sqlca)
		lds_change_cen_out_passenger.Retrieve(ll_result_keys)
		
		// 22.07.2013 HR: Filter angepa$$HEX1$$df00$$ENDHEX$$t, da Amadeus Paxe f$$HEX1$$fc00$$ENDHEX$$r nicht vorhandene Klassen nicht mag
		//ls_filter = "nbooking_class = 1"
		ls_filter = "nbooking_class = 1 and nversion >0"
		lds_change_cen_out_passenger.SetFilter(ls_filter)
		lds_change_cen_out_passenger.Filter()
	
		// Daten aus cen_out_passenger lesen ...	
		IF	lds_change_cen_out_passenger.RowCount() > 0 THEN
	
			for ll_rownum = 1 to lds_change_cen_out_passenger.RowCount()
				
				if ll_rownum = 1 then
					li_npax						=		lds_change_cen_out_passenger.GetItemNumber(ll_rownum,"npax")
					ls_ccomment				=		lds_change_cen_out_passenger.GetItemString(ll_rownum,"ccomment")
				elseif lds_change_cen_out_passenger.GetItemNumber(ll_rownum,"nclass_number") <> lds_change_cen_out_passenger.GetItemNumber(ll_rownum -1,"nclass_number") then
					li_npax						=		lds_change_cen_out_passenger.GetItemNumber(ll_rownum,"npax")
					ls_ccomment				=		lds_change_cen_out_passenger.GetItemString(ll_rownum,"ccomment")
				else				
					li_npax						+=		lds_change_cen_out_passenger.GetItemNumber(ll_rownum,"npax")
					if not isnull( lds_change_cen_out_passenger.GetItemString(ll_rownum,"ccomment")) then
						ls_ccomment			+=		" - "+lds_change_cen_out_passenger.GetItemString(ll_rownum,"ccomment")
					end if
				end if
				
				if isnull(ls_ccomment) then ls_ccomment=""
				
				if ll_rownum <  lds_change_cen_out_passenger.RowCount() then
					//Wenn wir noch nicht auf der letzen Zeile sind und die Klasse der aktuellen und n$$HEX1$$e400$$ENDHEX$$chsten Zeile gleich sind, dann machen wir mit der n$$HEX1$$e400$$ENDHEX$$chsten weiter
					if lds_change_cen_out_passenger.GetItemNumber(ll_rownum,"nclass_number") = lds_change_cen_out_passenger.GetItemNumber(ll_rownum +1,"nclass_number") then
						continue
					end if
				end if	
	
				li_nclass_number			=		lds_change_cen_out_passenger.GetItemNumber(ll_rownum,"nclass_number")
				ls_cclass						=		lds_change_cen_out_passenger.GetItemString(ll_rownum,"cclass")
				ls_cclass_name				=		f_get_class_name(li_nclass_number,ll_nairline_key)
				
				// --------------------------------------------------------------------------------------------------------------------
				// 22.07.2013 HR: Wenn ein Kommentar eingetragen ist, dann $$HEX1$$fc00$$ENDHEX$$bertragen wir es auch
				// --------------------------------------------------------------------------------------------------------------------
				if isnull(ls_ccomment) or trim(ls_ccomment)="" then
					li_nfunction				= 0 //Nur Pax
				else
					li_nfunction				= 1 //Pax und Kommentar
				end if
			
				// cen_request_out_pax Daten bef$$HEX1$$fc00$$ENDHEX$$llen ...			
				ll_actnum = ids_store_cen_request_out_pax.InsertRow(0)
			
				ids_store_cen_request_out_pax.SetItem(ll_actnum,"njob_nr"			,il_job_nr)
				ids_store_cen_request_out_pax.SetItem(ll_actnum,"nclass_number"	,li_nclass_number)
				ids_store_cen_request_out_pax.SetItem(ll_actnum,"cclass"				,ls_cclass)
				ids_store_cen_request_out_pax.SetItem(ll_actnum,"cclass_name"		,ls_cclass_name)			
				ids_store_cen_request_out_pax.SetItem(ll_actnum,"nfunction"			,li_nfunction)
				ids_store_cen_request_out_pax.SetItem(ll_actnum,"npax"				,li_npax)
				ids_store_cen_request_out_pax.SetItem(ll_actnum,"ccomment"		,ls_ccomment)
			next		
		END IF
	END IF //ab_pax
END IF

// Aufr$$HEX1$$e400$$ENDHEX$$umen ...
IF IsValid (lds_change_cen_out) THEN DESTROY lds_change_cen_out
IF IsValid (lds_change_cen_out_passenger) THEN DESTROY lds_change_cen_out_passenger

// ... und raus!
RETURN TRUE

end function

protected function boolean uf_get_last_request_out (long al_nresult_key, boolean ab_wab);
/* 
* Function: 			uf_get_last_request_out
* Beschreibung: 	...
* Besonderheit: 	...
*
* Argumente:
* 		arg_name 	Beschreibung
*
* Aenderungshistorie:
* 	Version 	Wer					Wann				Was und warum
*	1.0 		??											Erstellung
*	1.1 		Thomas Schaefer	04.11.2015		$$HEX1$$c400$$ENDHEX$$nderungen fuer Weight And Balance
*
* Return Codes:
*	 ...
*/

Long			ll_rc
Long			ll_row

Integer		li_nflight_number_1				
Integer		li_nflight_number_2				
String			ls_cairline_1						
String			ls_cairline_2						
String			ls_csuffix_1					
String			ls_csuffix_2					
String			ls_ctlc_from_1			
String			ls_ctlc_from_2		
String			ls_ctlc_to_1		
String			ls_ctlc_to_2		

DateTime	ldt_ddeparture_1					
DateTime	ldt_ddeparture_2					

DataStore lds_store_cen_request_out_last

// Letzen Stand holen ...
SELECT 	MAX(NJOB_NR)
INTO		:il_job_nr_last
FROM		CEN_REQUEST_OUT
WHERE	NRESULT_KEY = :al_nresult_key;

// Wenn ok -> Daten in DataStore ...
IF	sqlca.sqlcode = 0 THEN
	
	lds_store_cen_request_out_last 					=	CREATE DataStore
	lds_store_cen_request_out_last.DataObject 	= 	"dw_store_cen_request_out"
	lds_store_cen_request_out_last.SetTransObject(SQLCA)	
	ll_rc = lds_store_cen_request_out_last.Retrieve(il_job_nr_last)
	
	// Wenn ok -> Daten vergleichen ...
	IF 	lds_store_cen_request_out_last.RowCount() > 0 THEN

		ls_cairline_1						=		ids_store_cen_request_out.GetItemString(1,"cairline")
		li_nflight_number_1			=		ids_store_cen_request_out.GetItemNumber(1,"nflight_number")
		ls_csuffix_1						=		ids_store_cen_request_out.GetItemString(1,"csuffix")
		ldt_ddeparture_1				=		ids_store_cen_request_out.GetItemDateTime(1,"ddeparture")	
		ls_ctlc_from_1					=		ids_store_cen_request_out.GetItemString(1,"ctlc_from")
		ls_ctlc_to_1						=		ids_store_cen_request_out.GetItemString(1,"ctlc_to")
		il_aircraft_key					= 		ids_store_cen_request_out.GetItemNumber(1,"naircraft_key")

		ls_cairline_2						=		lds_store_cen_request_out_last.GetItemString(1,"cairline")
		li_nflight_number_2			=		lds_store_cen_request_out_last.GetItemNumber(1,"nflight_number")
		ls_csuffix_2						=		lds_store_cen_request_out_last.GetItemString(1,"csuffix")
		ldt_ddeparture_2				=		lds_store_cen_request_out_last.GetItemDateTime(1,"ddeparture")	
		ls_ctlc_from_2					=		lds_store_cen_request_out_last.GetItemString(1,"ctlc_from")
		ls_ctlc_to_2						=		lds_store_cen_request_out_last.GetItemString(1,"ctlc_to")
		il_aircraft_key_last				= 		lds_store_cen_request_out_last.GetItemNumber(1,"naircraft_key")

		IF IsNull(ls_csuffix_1) THEN
			ls_csuffix_1 = " "
		END IF
		
		IF IsNull(ls_csuffix_2) THEN
			ls_csuffix_2 = " "
		END IF
		
		// Wenn Unterschiede => vorbelegen ...
		IF	ls_cairline_1 <> ls_cairline_2 THEN
			ids_store_cen_request_out.SetItem(1,"cairline", ls_cairline_2)
		END IF
		
		IF	li_nflight_number_1 <> li_nflight_number_2 THEN
			ids_store_cen_request_out.SetItem(1,"nflight_number", li_nflight_number_2)
		END IF

		IF	ls_csuffix_1 <> ls_csuffix_2 THEN
			ids_store_cen_request_out.SetItem(1,"csuffix", ls_csuffix_2)
		END IF

		IF	ldt_ddeparture_1 <> ldt_ddeparture_2 THEN
			ids_store_cen_request_out.SetItem(1,"ddeparture", ldt_ddeparture_2)
		END IF

		IF	ls_ctlc_from_1 <> ls_ctlc_from_2 THEN
			ids_store_cen_request_out.SetItem(1,"ctlc_from", ls_ctlc_from_2)
		END IF

		IF	ls_ctlc_to_1 <> ls_ctlc_to_2 THEN
			ids_store_cen_request_out.SetItem(1,"ctlc_to", ls_ctlc_to_2)
		END IF

	END IF

	IF ab_wab THEN
		// Zuletzt gesendete Galleyweights lesen, aber nicht ver$$HEX1$$e400$$ENDHEX$$ndern
		ids_store_cen_request_out_wab.Retrieve(il_job_nr_last)
	END IF
	
ELSEIF sqlca.sqlcode < 0 THEN
	
	uf.mbox("Fehler","Fehler beim Lesen der letzten JFE-$$HEX1$$dc00$$ENDHEX$$bertragunsdaten")

END IF

// Aufr$$HEX1$$e400$$ENDHEX$$umen ...
DESTROY lds_store_cen_request_out_last 

// ... und raus.
RETURN TRUE

end function

protected function boolean uf_store_request_out (integer ai_request_type);
// -----------------------------------------------------------------------------------------------------------------------------------------
// Objekt : uo_request_out
// Methode: uf_store_request_out (Function)
// Autor  :
// -----------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// -----------------------------------------------------------------------------------------------------------------------------------------
// Return: boolean
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung: CEN_REQUEST_OUT-DataStores speichern 
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version		Autor              			     Kommentar
// -----------------------------------------------------------------------------------------------------------------------------------------
//  09.07.2013	1.00			Thomas Brackmann		Erstellung
//  13.01.2016	1.10			Thomas Schaefer			$$HEX1$$c400$$ENDHEX$$nderungen f$$HEX1$$fc00$$ENDHEX$$r Weight And Balance
// -----------------------------------------------------------------------------------------------------------------------------------------
Boolean		lb_ret = TRUE
Integer		li_row


// JobNr holen
il_job_nr = f_sequence("seq_cen_request_out", sqlca)
FOR li_row = 1 TO ids_store_cen_request_out.RowCount()
	ids_store_cen_request_out.SetItem(li_row, "njob_nr", il_job_nr)
	ids_store_cen_request_out.SetItem(li_row,"nrequest_type", ai_request_type)
NEXT

// Update
IF	ids_store_cen_request_out.Update() = -1 THEN
	uf.mbox("Speichern","Fehler beim Speichern der Kopfdaten.")
	lb_ret = FALSE
ELSE
	IF ai_request_type = II_REQUEST_TYPE_PAX THEN
		FOR li_row = 1 TO ids_store_cen_request_out_pax.RowCount()
			ids_store_cen_request_out_pax.SetItem(li_row, "njob_nr", il_job_nr)
		NEXT
		IF	ids_store_cen_request_out_pax.Update() = -1 THEN
			uf.mbox("Speichern","Fehler beim Speichern der Detaildaten.")
			lb_ret = FALSE
		END IF
	ELSEIF ai_request_type = II_REQUEST_TYPE_WAB THEN
		FOR li_row = 1 TO ids_store_cen_request_out_wab.RowCount()
			ids_store_cen_request_out_wab.SetItem(li_row, "njob_nr", il_job_nr)
		NEXT
		IF	ids_store_cen_request_out_wab.Update() = -1 THEN
			uf.mbox("Speichern","Fehler beim Speichern der Detaildaten.")
			lb_ret = FALSE
		END IF
	END IF
END IF

RETURN lb_ret

end function

public function boolean uf_request_out_manu_1 (long al_nresult_key);
// -----------------------------------------------------------------------------------------------------------------------------------------
// Objekt : uo_request_out
// Methode: uf_request_out_manu_1 (Function)
// Autor  :
// -----------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long al_nresult_key
// -----------------------------------------------------------------------------------------------------------------------------------------
// Return: boolean
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung:	Einstiegsfunktion bei Aufruf aus w_send_jfe
//
//						-	Holt die CEN_OUT-Daten des Fluge und
//						-	aktualisiert sie mit zuvor ggf. eigegebenen Transfer-Daten
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version		Autor              			     Kommentar
// -----------------------------------------------------------------------------------------------------------------------------------------
//  03.07.2013	1.00			Thomas Brackmann		Erstellung
//  04.11.2015	1.10			Thomas Schaefer			Weight And Balance eingebaut
// -----------------------------------------------------------------------------------------------------------------------------------------

// DataStores instanzieren ...
ids_store_cen_request_out 						= 	CREATE uo_cbase_DataStore
ids_store_cen_request_out.DataObject 		= 	"dw_store_cen_request_out"
ids_store_cen_request_out.SetTransObject(SQLCA)

ids_store_cen_request_out_pax				= 	CREATE DataStore
ids_store_cen_request_out_pax.DataObject	= 	"dw_store_cen_request_out_pax"
ids_store_cen_request_out_pax.SetTransObject(SQLCA)

ids_store_cen_request_out_wab				= 	CREATE uo_cbase_datastore
ids_store_cen_request_out_wab.DataObject= 	"dw_store_cen_request_out_wab"
ids_store_cen_request_out_wab.SetTransObject(SQLCA)

// Einlesen CEN_OUT-Date in CEN_REQUEST_OUT-DataStores umlesen.
IF 	NOT uf_get_cen_out_data(al_nresult_key, True) THEN
	RETURN FALSE
END IF

// Das CEN_REQUEST_OUT Kopfdaten-DataStore mit den letzten gespeicherten CEN_REQUEST_OUT-Daten aktualisieren
IF 	NOT uf_get_last_request_out(al_nresult_key, True) THEN
	RETURN FALSE
ELSE
	RETURN TRUE
END IF
end function

on uo_request_out.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_request_out.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;
// Aufr$$HEX1$$e400$$ENDHEX$$umen ...
IF IsValid(ids_store_cen_request_out) THEN DESTROY ids_store_cen_request_out
IF IsValid(ids_store_cen_request_out_pax) THEN DESTROY ids_store_cen_request_out_pax
IF IsValid(ids_store_cen_request_out_wab) THEN DESTROY ids_store_cen_request_out_wab


end event

