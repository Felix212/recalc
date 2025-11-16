HA$PBExportHeader$uo_message.sru
$PBExportComments$Flug-Browser: Objekt zum Erzeugen von $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen
forward
global type uo_message from nonvisualobject
end type
end forward

global type uo_message from nonvisualobject
end type
global uo_message uo_message

type prototypes
function int WSAStartup (uint UIVerionrequested, ref str_wsadata lpWSAdata) library "wsock32.DLL" alias for "WSAStartup;Ansi"
function int WSACleanup() library "wsock32.DLL" 
function int WSAGetLastError() library "wsock32.DLL"
function int gethostname(ref string name, int namelen) library "wsock32.DLL" alias for "gethostname;Ansi"
function string GetHost(string lpszhost,ref blob lpszaddress) library "pbws32.dll" alias for "GetHost;Ansi"
end prototypes

type variables
// ----------------------------------------
// Datastores
// ----------------------------------------
	datastore	dsChanges
	datastore	dsReceived
	datastore	dsClient
	datastore	dsFlight
	datastore	dsFlightFirstLeg
	datastore	dsAirline
	datastore	dsAirlinePositiv
	datastore	dsDebug		
	datastore	dsAreas	// 22.02.2005
// ----------------------------------------
// Variabeln f$$HEX1$$fc00$$ENDHEX$$r Retrieve
// ----------------------------------------
	long			lClientKey
// ----------------------------------------
// kann dieser Client $$HEX1$$c400$$ENDHEX$$nderungen empfangen
// ----------------------------------------
	boolean		bClientReceiver	
	string		sClientIpAddress
	string		sClientHostName
// ----------------------------------------
// Variabeln f$$HEX1$$fc00$$ENDHEX$$r einen Flug
// ----------------------------------------
	long			lResultkey
	long			lTransactionKey	
// ----------------------------------------
// Variabeln f$$HEX1$$fc00$$ENDHEX$$r Vergleich
// ----------------------------------------	
	datetime		dtNow
// ----------------------------------------
// Variabeln f$$HEX1$$fc00$$ENDHEX$$r Errorhandling
// ----------------------------------------	
	string	sErrortext
// ----------------------------------------
// Variabeln f$$HEX1$$fc00$$ENDHEX$$r Debug
// ----------------------------------------	
	boolean	bDebug	= False
	string	sDebugMessage
	
	long		lFirstLegAircraft
	string	sFirstLegBoxFrom
	string	sFirstLegBoxTo
	long		lFirstLegHandlingTypeKey
	string	sFirstLegRegistration
	string	sFirstLegVersion
	
	long		lCurrentLegAircraft
	string	sCurrentLegBoxFrom
	string	sCurrentLegBoxTo
	long		lCurrentLegHandlingTypeKey
	string	sCurrentLegRegistration
	string	sCurrentLegVersion
	
	
	boolean	bRegistration
	boolean	bAircraft
	boolean	bBox
	boolean	bHandling
	boolean	bVersion
	
	integer	iCurrentLegNumber
	
	integer	iClientMoreLegStatus
	
	long il_mess_count
end variables

forward prototypes
public function long uf_find_client (long lclient_key)
public function long uf_retrieve_messages ()
public function boolean uf_write_message ()
public function boolean uf_check_time_from (long lclientrow)
public function boolean uf_check_time_to (long lclientrow)
public subroutine uf_debug (string stype)
public function boolean uf_check_status (long lclientrow)
public function boolean uf_check_message (long lclientrow)
public function boolean uf_check_groups (long lclientrow)
public function boolean uf_check_time_from_to (long lclientrow)
public function boolean uf_check_time_from_old (long lclientrow)
public function boolean uf_check_time_to_old (long lclientrow)
public function boolean uf_generate_message (string sunit, long lresult_key, long ltransaction_key, integer ilegnumber)
public function boolean uf_compare_flight ()
public function boolean uf_check_external (long lclientrow)
public function boolean uf_check_airline_old (long lclientrow)
public function boolean uf_check_airline (long lclientrow)
end prototypes

public function long uf_find_client (long lclient_key);	long	lFound 
// -----------------------------------------------
// Suche nach eienm Client 
// -----------------------------------------------
	lFound = dsClient.Find("nclient_key = " + string(lClient_key) ,1,dsClient.Rowcount())
	If lFound > 0 Then
		lClientKey			= dsClient.Getitemnumber(lFound,"nclient_key")
		bClientReceiver 	= True
	Else
		lClientKey			= 0 
		bClientReceiver 	= False
	End if
	
	
	Return lFound


end function

public function long uf_retrieve_messages ();// --------------------------------------------------
//	Retrieve der $$HEX1$$c400$$ENDHEX$$nderungen, falls der ClientKey 0 ist
// werden keine $$HEX1$$c400$$ENDHEX$$nderungen geholt.
// --------------------------------------------------
//	dDeparture = Today()
//	
//	If bClientReceiver 	= True  Then
//		return dsChanges.Retrieve(s_app.smandant,s_app.swerk,dDeparture,lClientKey)
//	Else
//		return 0
//	End if	
//


return 0
end function

public function boolean uf_write_message ();	datetime		dtCreated
// -----------------------------------------------------
// Eine Message in die Tabelle LOC_RECEIVED f$$HEX1$$fc00$$ENDHEX$$r einen
// Client schreiben.
// -----------------------------------------------------
	dtCreated = datetime(today(),now())

	
	INSERT INTO loc_received  
          (nclient_key,   
           nresult_key,   
           ntransaction,
			  dcreated,
           dreceived,   
           dconfirmed )  
  	VALUES (:lClientKey,   
           :lResultKey,   
           :lTransactionKey,
			  :dtCreated,
           NULL,   
           NULL)  ;

	If sqlca.sqlcode <> 0 then
		Return False
	Else
		Return True		
	End if
	



end function

public function boolean uf_check_time_from (long lclientrow);integer		iClientStatus
integer		iDays
long			lSecondsbefore
long			lSecondsToday
long			lSeconds
long			lClientSeconds
datetime		dtDeparture
string		sDepartureTime
// --------------------------------------------------------------
// 2. Zeitpunkt der $$HEX1$$c400$$ENDHEX$$nderung		NCHANGES_FROM 
//											 0 			immer
//											24			24 Stunden 
//											12			12 Stunden
//											 1			 1 Stunde
// --------------------------------------------------------------
iClientStatus	= dsClient.Getitemnumber(lclientrow,"nchanges_from")

// --------------------------------------
// Clientstatus Immer, dann Message
// --------------------------------------	
If iClientStatus = 0 Then
	return True
End if

dtDeparture		= dsFlight.Getitemdatetime(1,"ddeparture")
sDepartureTime = dsFlight.GetitemString(1,"cdeparture_time")
// --------------------------------------
// Datumsdifferenz
// --------------------------------------
iDays = Daysafter(date(dtNow),date(dtDeparture))
// -------------------------------------------------------
// Es wurde in der Vergangenheit ge$$HEX1$$e400$$ENDHEX$$ndert, keine Message
// -------------------------------------------------------
If iDays < 0 Then
	sDebugMessage	= "$$HEX1$$c400$$ENDHEX$$nderung lag in der Vergangenheit."
	return False
End if	
// -------------------------------------------------------
// Es wurde in der Zukunft ge$$HEX1$$e400$$ENDHEX$$ndert
// -------------------------------------------------------	
If iDays > 0 Then
	lSecondsbefore = iDays * 86400
	lSecondsToday 	= secondsafter(time(dtnow),time(string(sDepartureTime)))
//	lSecondsToday 	= secondsafter(time("00:00"),time(string(sDepartureTime)))
	lSeconds			= lSecondsbefore + lSecondsToday
End if					
// -------------------------------------------------------
// Es wurde Heute ge$$HEX1$$e400$$ENDHEX$$ndert
// -------------------------------------------------------	
If iDays = 0 Then
	lSecondsToday 	= secondsafter(time(dtnow),time(string(sDepartureTime)))
//	lSecondsToday 	= secondsafter(time("00:00"),time(string(sDepartureTime)))
	lSeconds			= lSecondsToday
End if	
// -------------------------------------------------------
// Message ja oder nein ?
// -------------------------------------------------------	
lClientSeconds		= iClientStatus * 3600

If lClientSeconds <= lSeconds Then
	sDebugMessage	= "Zeit von: " + string(iClientStatus)+ " Stunden"
	return False
Else
	return True
End if	

return True


end function

public function boolean uf_check_time_to (long lclientrow);integer		iClientStatus
integer		iDays
long			lSecondsbefore
long			lSecondsToday
long			lSeconds
long			lClientSeconds
datetime		dtDeparture
string		sDepartureTime
// --------------------------------------------------------------
// 2. Zeitpunkt der $$HEX1$$c400$$ENDHEX$$nderung		NCHANGES_TO 
//											 0 			immer
//											24			24 Stunden 
//											12			12 Stunden
//											 1			 1 Stunde
// --------------------------------------------------------------
iClientStatus	= dsClient.Getitemnumber(lclientrow,"nchanges_to")
// --------------------------------------
// Clientstatus Immer, dann Message
// --------------------------------------	
If iClientStatus = 0 Then
	return True
End if

dtDeparture		= dsFlight.Getitemdatetime(1,"ddeparture")
sDepartureTime = dsFlight.GetitemString(1,"cdeparture_time")
// --------------------------------------
// Datumsdifferenz
// --------------------------------------
iDays = Daysafter(date(dtNow),date(dtDeparture))
// -------------------------------------------------------
// Es wurde in der Vergangenheit ge$$HEX1$$e400$$ENDHEX$$ndert, keine Message
// -------------------------------------------------------
If iDays < 0 Then
	sDebugMessage	= "$$HEX1$$c400$$ENDHEX$$nderung lag in der Vergangenheit."
	return False
End if	
// -------------------------------------------------------
// Es wurde in der Zukunft ge$$HEX1$$e400$$ENDHEX$$ndert
// -------------------------------------------------------	
If iDays > 0 Then
	lSecondsbefore = iDays * 86400
	lSecondsToday 	= secondsafter(time(dtnow),time(string(sDepartureTime)))
	//lSecondsToday 	= secondsafter(time("00:00"),time(string(sDepartureTime)))
	lSeconds			= lSecondsbefore + lSecondsToday
End if					
// -------------------------------------------------------
// Es wurde Heute ge$$HEX1$$e400$$ENDHEX$$ndert
// -------------------------------------------------------	
If iDays = 0 Then
	lSecondsToday 	= secondsafter(time(dtnow),time(string(sDepartureTime)))
	//lSecondsToday 	= secondsafter(time("00:00"),time(string(sDepartureTime)))
	lSeconds			= lSecondsToday
End if	
// -------------------------------------------------------
// Message ja oder nein ?
// -------------------------------------------------------	
lClientSeconds		= iClientStatus * 3600

If lClientSeconds >= lSeconds Then
	sDebugMessage	= "Zeit bis: " + string(iClientStatus) + " Stunden"
	return False
Else
	return True
End if	

return True


end function

public subroutine uf_debug (string stype);long 			lRow
datetime		dtDeparture
string		sDepartureTime,sFlight

If bDebug Then
	dtDeparture		= dsFlight.Getitemdatetime(1,"ddeparture")
	sDepartureTime = dsFlight.GetitemString(1,"cdeparture_time")
	dtDeparture		= datetime(date(dtDeparture),time(sDepartureTime))
	sFlight			= dsFlight.GetitemString(1,"cen_out_history_cairline") + &
						  " " + string(dsFlight.GetitemNumber(1,"cen_out_history_nflight_number"))
	
	dsDebug.modify("t_flight.text = '" + sFlight + "'")
	dsDebug.modify("t_departure.text = '" + string(dtDeparture) + "'")
	dsDebug.modify("t_changetime.text = '" + string(dtNow) + "'")
	
	lRow 	= dsDebug.insertrow(0)
	dsDebug.Setitem(lRow,"sclient",sClientIpAddress)
	dsDebug.Setitem(lRow,"smessage",sDebugMessage)
	dsDebug.Setitem(lRow,"stype",sType)
	
	
	f_Log2Csv(0,0,"sFlight: "+sFlight+" | departure:"+string(dtDeparture)+" | changetime: "+ string(dtNow)+" | sclient" + sClientIpAddress+" | smessage: " +  sDebugMessage+" | stype:"+sType)
End if	

return
end subroutine

public function boolean uf_check_status (long lclientrow);	integer		iClientStatus
	integer		iFlightStatus
	
// --------------------------------------------------------------
// 1. Flugstatus						Status 1-7	
// 										1.	Generierung
// 										2.	Generierung Update
// 										3.	Planung
// 										4.	Produktionsstatus 1
// 										5.	Produktionsstatus 2
// 										6.	Flight Closed
// 										7.	Flug ist abgerechnet
// --------------------------------------------------------------

// --------------------------------------------------------------
// Sollen der Hinflug mit den Weiter und R$$HEX1$$fc00$$ENDHEX$$ckfl$$HEX1$$fc00$$ENDHEX$$gen verglichen werden
// --------------------------------------------------------------
	iClientMoreLegStatus		= dsClient.Getitemnumber(lclientrow,"nstatus_8")
	
	
	iFlightStatus 				= dsFlight.Getitemnumber(1,"cen_out_history_nstatus")
	If iFlightStatus >= 1 and iFlightStatus <= 7 Then
		iClientStatus	= dsClient.Getitemnumber(lclientrow,"nstatus_" + string(iFlightStatus))
		If iClientStatus = 0 Then 
			sDebugMessage	= "Keine Message da, Flugstatus " + string(iFlightStatus) + " nicht ausgew$$HEX1$$e400$$ENDHEX$$hlt war."
			Return False
		Else
			Return True
		End if	
	Else
		sDebugMessage	= "Flugstatus"
		Return False
	End if


end function

public function boolean uf_check_message (long lclientrow);// --------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderung f$$HEX1$$fc00$$ENDHEX$$r einen Client $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen
// In dsClient stehen die $$HEX1$$c400$$ENDHEX$$nderungs Parameter in dsCheck stehen
// die Infos zur aktuellen $$HEX1$$c400$$ENDHEX$$nderung
// --------------------------------------------------------------
integer		iClientStatus
integer		iFlightStatus

// --------------------------------------------------------------	
// 29.11.05	Vorab-Pr$$HEX1$$fc00$$ENDHEX$$fung auf $$HEX1$$c400$$ENDHEX$$nderung vom Nachfahrten-Browser
//				Sollte der Client nexternal = 1 konfiguriert sein,
//				dann bekommt er auf jeden Fall eine $$HEX1$$c400$$ENDHEX$$nderung.
//				Falls nicht, dann normale Verarbeitung.
// --------------------------------------------------------------	
If uf_check_external(lClientrow) Then
	return true
End if

// --------------------------------------------------------------	
// Folgende Pr$$HEX1$$fc00$$ENDHEX$$fungen werden vorgenommen
// 0. Airline Negative Liste
// 1. Flugstatus						Status 1-7
// 2. Zeitpunkt der $$HEX1$$c400$$ENDHEX$$nderung		NCHANGES_FROM 
// 3. Zeitpunkt der $$HEX1$$c400$$ENDHEX$$nderung		NCHANGES_TO
// 4. $$HEX1$$c400$$ENDHEX$$nderungsgruppen				naircrafttype, nversion, ...
// 5. Airlineabh$$HEX1$$e400$$ENDHEX$$ngig
// --------------------------------------------------------------
If not uf_check_airline(lClientrow) Then
	uf_debug("$$HEX1$$fb00$$ENDHEX$$")
	Return False
End if

If not uf_check_status(lClientrow) Then
	uf_debug("$$HEX1$$fb00$$ENDHEX$$")
	Return False
End if

If not uf_check_time_from(lClientrow) Then
	uf_debug("$$HEX1$$fb00$$ENDHEX$$")
	Return False
End if

If not uf_check_time_to(lClientrow) Then
	uf_debug("$$HEX1$$fb00$$ENDHEX$$")
	Return False
End if

If not uf_check_groups(lClientrow) Then
	uf_debug("$$HEX1$$fb00$$ENDHEX$$")
	Return False
End if


Return True
end function

public function boolean uf_check_groups (long lclientrow);integer	iClientStatus
integer	iFlightStatus
integer	iBillingStatus
string	sGroups[]
integer	i
long		lClientAreaKey
long		lFind
// --------------------------------------------------------------
// 3. $$HEX1$$c400$$ENDHEX$$nderungsgruppen				
//										nflight
//										ndate_time
//										nregistration		
//										nrampbox				
//										naircrafttype		
//										nhandling			
//										nversion				
//										npassenger
//										nmeal
//										nspml
//										nextra
//										ntextinfo
//										nflight_status
// --------------------------------------------------------------
	sGroups[1]	= "nflight"
	sGroups[2]	= "ndate_time"
	sGroups[3]	= "nregistration"
	sGroups[4]	= "nrampbox"
	sGroups[5]	= "naircrafttype"
	sGroups[6]	= "nhandling"
	sGroups[7]	= "nversion"
	sGroups[8]	= "npassenger"
	sGroups[9]	= "nmeal"
	sGroups[10]	= "nspml"
	sGroups[11]	= "nextra"
	sGroups[12]	= "ntextinfo"
	sGroups[13]	= "nflight_status"
// --------------------------------------------------------------
//	Sofern der Client die $$HEX1$$c400$$ENDHEX$$nderungsgruppe gew$$HEX1$$e400$$ENDHEX$$hlt hat und eine
// $$HEX1$$c400$$ENDHEX$$nderung in dieser Gruppe vorliegt. Return True
// --------------------------------------------------------------
	For I = 1 to Upperbound(sGroups)
		iClientStatus	= dsClient.Getitemnumber(lclientrow,sGroups[i])
		iFlightStatus	= dsFlight.Getitemnumber(1,sGroups[i])
		lClientAreaKey	= dsClient.Getitemnumber(lclientrow,"loc_client_setting_narea_key")
		// --------------------------------------------------------------
		//	Wurden nur Abrechnungsinformationen ge$$HEX1$$e400$$ENDHEX$$ndert
		// --------------------------------------------------------------
		If i = 9 Then
			iBillingStatus	= dsFlight.Getitemnumber(1,"nmeal_billing")
		ElseIf i = 10 Then
			iBillingStatus	= dsFlight.Getitemnumber(1,"nspml_billing")
		ElseIf i = 11 Then
			iBillingStatus	= dsFlight.Getitemnumber(1,"nextra_billing")
		Else
			iBillingStatus	= 0
		End if
		//
		// Textinfo-Bereiche
		//
		if i = 12 then
			if iFlightStatus = 1 then
				dsAreas.Retrieve(lResultkey)
				lFind = dsAreas.Find("narea_key = " + string(lClientAreaKey) + &
											" and nsend = 1" ,1,dsAreas.RowCount())
				if lFind = 0 then
					iFlightStatus = 0
				end if
			end if
		end if
		// --------------------------------------------------------------
		//	Weiter und R$$HEX1$$fc00$$ENDHEX$$ckflug$$HEX1$$e400$$ENDHEX$$nderungen gegen Hinflug pr$$HEX1$$fc00$$ENDHEX$$fen
		// Bei gleichen werten keine Mitteilung sofern iClientMoreLegStatus 
		// gesetzt wurde
		// --------------------------------------------------------------
		If iCurrentLegNumber > 1 and iClientMoreLegStatus = 1 Then
			If i = 3 Then
				If iClientStatus = 1 and iFlightStatus = 1 and bRegistration = True Then
					iClientStatus = 0
				End if
			ElseIf i = 4 Then
				If iClientStatus = 1 and iFlightStatus = 1 and bBox = True Then
					iClientStatus = 0
				End if
			ElseIf i = 5 Then
				If iClientStatus = 1 and iFlightStatus = 1 and bAircraft = True Then
					iClientStatus = 0
				End if	
			ElseIf i = 6 Then
				If iClientStatus = 1 and iFlightStatus = 1 and bHandling = True Then
					iClientStatus = 0
				End if	
			ElseIf i = 7 Then
				If iClientStatus = 1 and iFlightStatus = 1 and bVersion = True Then
					iClientStatus = 0
				End if		
			End if		
		End if	
		
		
		If iBillingStatus = 0 and iClientStatus = 1 and iFlightStatus = 1 Then
			return True
		End if	
	Next
	
	sDebugMessage	= "$$HEX1$$c400$$ENDHEX$$nderungsgruppe"
	return False
end function

public function boolean uf_check_time_from_to (long lclientrow);integer		iClientStatusFrom
integer		iClientStatusTo
integer		iDays
long			lSecondsbefore
long			lSecondsToday
long			lSeconds
long			lClientSeconds
datetime		dtDeparture
string		sDepartureTime
// --------------------------------------------------------------
// 2. Zeitpunkt der $$HEX1$$c400$$ENDHEX$$nderung		NCHANGES_FROM 
//											 0 			immer
//											24			24 Stunden 
//											12			12 Stunden
//											 1			 1 Stunde
// --------------------------------------------------------------
iClientStatusFrom	= dsClient.Getitemnumber(lclientrow,"nchanges_from")
iClientStatusTo	= dsClient.Getitemnumber(lclientrow,"nchanges_to")

// ---------------------------------------------------------------
// ClientstatusFrom =  Immer
// ClientstatusFrom =  Immer
// ---- dann Message -----
// ---------------------------------------------------------------	
If iClientStatusFrom = 0 and iClientStatusTo = 0 Then
	return True
End if

dtDeparture		= dsFlight.Getitemdatetime(1,"ddeparture")
sDepartureTime = dsFlight.GetitemString(1,"cdeparture_time")

// --------------------------------------
// Datumsdifferenz
// --------------------------------------
iDays = Daysafter(date(dtNow),date(dtDeparture))

// -------------------------------------------------------
// Es wurde in der Vergangenheit ge$$HEX1$$e400$$ENDHEX$$ndert, keine Message
// -------------------------------------------------------
If iDays < 0 Then
	sDebugMessage	= "$$HEX1$$c400$$ENDHEX$$nderung lag in der Vergangenheit."
	return False
End if	

// -------------------------------------------------------
// Es wurde in der Zukunft ge$$HEX1$$e400$$ENDHEX$$ndert
// -------------------------------------------------------	
If iDays > 0 Then
	lSecondsbefore = iDays * 86400
	lSecondsToday 	= secondsafter(time(dtnow),time(string(sDepartureTime)))
	lSeconds			= lSecondsbefore + lSecondsToday
End if					
// -------------------------------------------------------
// Es wurde Heute ge$$HEX1$$e400$$ENDHEX$$ndert
// -------------------------------------------------------	
If iDays = 0 Then
	lSecondsToday 	= secondsafter(time(dtnow),time(string(sDepartureTime)))
	lSeconds			= lSecondsToday
End if	
// -------------------------------------------------------
// Message ja oder nein ?
// -------------------------------------------------------	
lClientSeconds		= iClientStatusFrom * 3600

If lClientSeconds <= lSeconds Then
	sDebugMessage	= "Zeit von: " + string(iClientStatusFrom)+ " Stunden"
	return False
Else
	return True
End if	




return True


end function

public function boolean uf_check_time_from_old (long lclientrow);integer		iClientStatus
integer		iDays
long			lSecondsbefore
long			lSecondsToday
long			lSeconds
long			lClientSeconds
datetime		dtDeparture
string		sDepartureTime
// --------------------------------------------------------------
// 2. Zeitpunkt der $$HEX1$$c400$$ENDHEX$$nderung		NCHANGES_FROM 
//											 0 			immer
//											24			24 Stunden 
//											12			12 Stunden
//											 1			 1 Stunde
// --------------------------------------------------------------
iClientStatus	= dsClient.Getitemnumber(lclientrow,"nchanges_from")

// --------------------------------------
// Clientstatus Immer, dann Message
// --------------------------------------	
If iClientStatus = 0 Then
	return True
End if

dtDeparture		= dsFlight.Getitemdatetime(1,"ddeparture")
sDepartureTime = dsFlight.GetitemString(1,"cdeparture_time")
// --------------------------------------
// Datumsdifferenz
// --------------------------------------
iDays = Daysafter(date(dtNow),date(dtDeparture))
// -------------------------------------------------------
// Es wurde in der Vergangenheit ge$$HEX1$$e400$$ENDHEX$$ndert, keine Message
// -------------------------------------------------------
If iDays < 0 Then
	sDebugMessage	= "$$HEX1$$c400$$ENDHEX$$nderung lag in der Vergangenheit."
	return False
End if	
// -------------------------------------------------------
// Es wurde in der Zukunft ge$$HEX1$$e400$$ENDHEX$$ndert
// -------------------------------------------------------	
If iDays > 0 Then
	lSecondsbefore = iDays * 86400
	lSecondsToday 	= secondsafter(time(dtnow),time(string(sDepartureTime)))
	lSeconds			= lSecondsbefore + lSecondsToday
End if					
// -------------------------------------------------------
// Es wurde Heute ge$$HEX1$$e400$$ENDHEX$$ndert
// -------------------------------------------------------	
If iDays = 0 Then
	lSecondsToday 	= secondsafter(time(dtnow),time(string(sDepartureTime)))
	lSeconds			= lSecondsToday
End if	
// -------------------------------------------------------
// Message ja oder nein ?
// -------------------------------------------------------	
lClientSeconds		= iClientStatus * 3600

If lClientSeconds <= lSeconds Then
	sDebugMessage	= "Zeit von: " + string(iClientStatus)+ " Stunden"
	return False
Else
	return True
End if	

return True


end function

public function boolean uf_check_time_to_old (long lclientrow);	integer		iClientStatus
	integer		iDays
	long			lSecondsbefore
	long			lSecondsToday
	long			lSeconds
	long			lClientSeconds
	datetime		dtDeparture
	string		sDepartureTime
// --------------------------------------------------------------
// 2. Zeitpunkt der $$HEX1$$c400$$ENDHEX$$nderung		NCHANGES_TO 
//											 0 			immer
//											24			24 Stunden 
//											12			12 Stunden
//											 1			 1 Stunde
// --------------------------------------------------------------
	iClientStatus	= dsClient.Getitemnumber(lclientrow,"nchanges_to")
// --------------------------------------
// Clientstatus Immer, dann Message
// --------------------------------------	
	If iClientStatus = 0 Then
		return True
	End if
	
	dtDeparture		= dsFlight.Getitemdatetime(1,"ddeparture")
	sDepartureTime = dsFlight.GetitemString(1,"cdeparture_time")
// --------------------------------------
// Datumsdifferenz
// --------------------------------------
	iDays = Daysafter(date(dtNow),date(dtDeparture))
// -------------------------------------------------------
// Es wurde in der Vergangenheit ge$$HEX1$$e400$$ENDHEX$$ndert, keine Message
// -------------------------------------------------------
	If iDays < 0 Then
		sDebugMessage	= "$$HEX1$$c400$$ENDHEX$$nderung lag in der Vergangenheit."
		return False
	End if	
// -------------------------------------------------------
// Es wurde in der Zukunft ge$$HEX1$$e400$$ENDHEX$$ndert
// -------------------------------------------------------	
	If iDays > 0 Then
		lSecondsbefore = iDays * 86400
		lSecondsToday 	= secondsafter(time(dtnow),time(string(sDepartureTime)))
		lSeconds			= lSecondsbefore + lSecondsToday
	End if					
// -------------------------------------------------------
// Es wurde Heute ge$$HEX1$$e400$$ENDHEX$$ndert
// -------------------------------------------------------	
	If iDays = 0 Then
		lSecondsToday 	= secondsafter(time(dtnow),time(string(sDepartureTime)))
		lSeconds			= lSecondsToday
	End if	
// -------------------------------------------------------
// Message ja oder nein ?
// -------------------------------------------------------	
	lClientSeconds		= iClientStatus * 3600
	
	If lClientSeconds >= lSeconds Then
		sDebugMessage	= "Zeit bis: " + string(iClientStatus) + " Stunden"
		return False
	Else
		return True
	End if	

	return True
	
	
end function

public function boolean uf_generate_message (string sunit, long lresult_key, long ltransaction_key, integer ilegnumber);//=================================================================================
//
// uf_generate_message
//
//=================================================================================
//
// Einstiegsfunktion f$$HEX1$$fc00$$ENDHEX$$r die Benachrichtigung von Message-Browser-Clients
//
//=================================================================================
integer 	i

// -------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r welchen Client soll eine Message generiert werden ?
// -------------------------------------------------------
lResultKey			= lResult_Key
lTransactionKey	= lTransaction_Key
dtNow					= datetime(today(),now())

iCurrentLegNumber = iLegNumber
dsDebug.Reset()

// -------------------------------------------------------
// Retrieve auf CEN_OUT_CHANGES
// -------------------------------------------------------
dsFlight.Retrieve(lResultKey,lTransactionKey)
If dsFlight.Rowcount() <= 0 Then
	uf.mbox("Fehler","Fehler beim Lesen der $$HEX1$$c400$$ENDHEX$$nderungsflug-Informationen.",Stopsign!)
	return False
End if	

// ---------------------------------------------------------------
// Vergleiche Weiter und R$$HEX1$$fc00$$ENDHEX$$ckfl$$HEX1$$fc00$$ENDHEX$$ge mit Hinflug
// ---------------------------------------------------------------
If uf_compare_flight() = False Then
	uf.mbox("Fehler","Fehler beim Lesen der $$HEX1$$c400$$ENDHEX$$nderungsflug-Informationen (Hinflug).",Stopsign!)
	return False
End if	

// -------------------------------------------------------
// Filter auf Betrieb
// -------------------------------------------------------	
dsClient.Setfilter("loc_clients_cunit = '" + sunit + "'")
dsClient.Filter()

// -------------------------------------------------------
// Alle Clients $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen
// -------------------------------------------------------

il_mess_count = 0
For i = 1 to dsClient.Rowcount()
	lClientKey 			= dsClient.Getitemnumber(i,"nclient_key")
	sClientIpAddress	= dsClient.Getitemstring(i,"cipaddress")
	// -------------------------------------------------------
	// Ist diese $$HEX1$$c400$$ENDHEX$$nderung f$$HEX1$$fc00$$ENDHEX$$r diesen Client ?
	// -------------------------------------------------------
	If uf_check_message(i) Then
		// -------------------------------------------------------
		// Eintrag in die Tabelle LOC_RECEIVED
		// -------------------------------------------------------
		il_mess_count ++
		
		sDebugMessage = ""
		uf_debug("$$HEX1$$fc00$$ENDHEX$$")
		If not uf_write_message() Then
			uf.mbox("Fehler","Fehler beim Erstellen von $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen.",Stopsign!)
			return False
		ELSE
			uf_debug(" ok")
		End if
		
	End if	
Next

Return True

end function

public function boolean uf_compare_flight ();// ---------------------------------------------------------------
// Schalter: Vergleiche Weiter und R$$HEX1$$fc00$$ENDHEX$$ckfl$$HEX1$$fc00$$ENDHEX$$ge mit Hinflug:
// Vorbereitung f$$HEX1$$fc00$$ENDHEX$$r Vergleich
// Bei gleichen werten von:
// Registration, Flugger$$HEX1$$e400$$ENDHEX$$t, Rampenbox und Version keine Mitteilung
// ---------------------------------------------------------------
	If iCurrentLegNumber > 1 Then
		dsFlightFirstLeg.retrieve(dsFlight.Getitemnumber(1,"nresult_key_group"))
		If dsFlightFirstLeg.Rowcount() <= 0 Then
			return False
		End if	
			
		sFirstLegRegistration 			= dsFlightFirstLeg.GetItemString(1,"cregistration")
		lFirstLegAircraft					= dsFlightFirstLeg.GetItemNumber(1,"naircraft_key")
		sFirstLegBoxFrom					= dsFlightFirstLeg.GetItemString(1,"cbox_from")
		sFirstLegBoxTo						= dsFlightFirstLeg.GetItemString(1,"cbox_to")
		lFirstLegHandlingTypeKey		= dsFlightFirstLeg.GetItemNumber(1,"nhandling_type_key")
		sFirstLegVersion					= dsFlightFirstLeg.GetItemString(1,"cconfiguration")

		sCurrentLegRegistration 		= dsFlight.GetItemString(1,"cregistration")
		lCurrentLegAircraft				= dsFlight.GetItemNumber(1,"naircraft_key")
		sCurrentLegBoxFrom				= dsFlight.GetItemString(1,"cbox_from")
		sCurrentLegBoxTo					= dsFlight.GetItemString(1,"cbox_to")
		lCurrentLegHandlingTypeKey		= dsFlight.GetItemNumber(1,"nhandling_type_key")
		sCurrentLegVersion				= dsFlight.GetItemString(1,"cconfiguration")
	// -------------------------------------------------------
	// Registration mit Hinflug vergleichen
	// -------------------------------------------------------
		If isnull(sCurrentLegRegistration) or len(trim(sCurrentLegRegistration)) = 0 Then
			bRegistration 	= True
		Elseif sFirstLegRegistration = sCurrentLegRegistration Then
			bRegistration 	= True
		Else
			bRegistration 	= False
		End if	
	// -------------------------------------------------------
	// Aircrafttype mit Hinflug vergleichen
	// -------------------------------------------------------	
		If lFirstLegAircraft = lCurrentLegAircraft Then
			bAircraft 		= True
		Else
			bAircraft 		= False
		End if	
	// -------------------------------------------------------
	// Rampenbox mit Hinflug vergleichen
	// -------------------------------------------------------	
		If isnull(sCurrentLegBoxFrom) or len(trim(sCurrentLegBoxFrom)) = 0 Then
			bBox 				= True
		Elseif sFirstLegBoxFrom = sCurrentLegBoxFrom Then
			bBox 				= True
		Else
			bBox 				= False
		End if	
		
		If bBox = True Then
			If isnull(sCurrentLegBoxTo) or len(trim(sCurrentLegBoxTo)) = 0 Then
				bBox 				= True
			Elseif sFirstLegBoxTo = sCurrentLegBoxTo Then
				bBox 				= True
			Else
				bBox 				= False
			End if	
		End if	
	// -------------------------------------------------------
	// Handling mit Hinflug vergleichen
	// -------------------------------------------------------
		If lFirstLegHandlingTypeKey = lCurrentLegHandlingTypeKey Then
			bHandling 		= True
		Else
			bHandling 		= False
		End if	
	// -------------------------------------------------------
	// Version mit Hinflug vergleichen
	// -------------------------------------------------------
		If sFirstLegVersion = sCurrentLegVersion Then
			bVersion 		= True
		Else
			bVersion 		= False
		End if		
	End if

	Return True



end function

public function boolean uf_check_external (long lclientrow);//=================================================================================
//
// uf_check_external
//
//=================================================================================
//
// 29.11.05 Pr$$HEX1$$fc00$$ENDHEX$$fe, ob Client f$$HEX1$$fc00$$ENDHEX$$r "externe" $$HEX1$$c400$$ENDHEX$$nderungen berechtigt ist
//				(Nachfahrten-Browser)
//				true: Ja, $$HEX1$$c400$$ENDHEX$$nderung ist aus Nachfahrten-Browser und f$$HEX1$$fc00$$ENDHEX$$r diesen Client
//						relevant!
//
//=================================================================================
integer	iClientStatus
long		lAirlineKey
long		lRoutingId
long		lFound

// --------------------------------------------------------------
// Negative Liste von Airlines und Strecken $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen
// --------------------------------------------------------------
iClientStatus	= dsClient.Getitemnumber(lclientrow,"nexternal")
if isnull(iClientStatus) then iClientStatus = 0

If iClientStatus <= 0 Then
	// --------------------------------------------------------------------
	// nexternal spielt f$$HEX1$$fc00$$ENDHEX$$r diesen PC keine Rolle
	// --------------------------------------------------------------------
	return false
else
	// --------------------------------------------------------------------
	// nexternal wurde gefunden
	// --------------------------------------------------------------------
	return true
End if

return false

end function

public function boolean uf_check_airline_old (long lclientrow);integer	iClientStatus
long		lAirlineKey
long		lRoutingId
long		lFound
String	sDep, sFind
// --------------------------------------------------------------
// Negative Liste von Airlines und Strecken $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen
// --------------------------------------------------------------
iClientStatus	= dsClient.Getitemnumber(lclientrow,"nuse_airline")
// --------------------------------------------------------------------
// nuse_airline hat die Information ob Airline Infos eingegeben wurden
// --------------------------------------------------------------------
If iClientStatus <= 0 Then
	return True
End if	

lAirlineKey		= dsFlight.Getitemnumber(1,"nairline_key")
lRoutingId		= dsFlight.Getitemnumber(1,"nrouting_id")

dsAirline.Retrieve(lClientKey)

// --------------------------------------------------------------------
// Suche nach Airline und Strecke in der NEGATIVLISTE
// --------------------------------------------------------------------	
lFound = dsAirline.Find("nairline_key = " + string(lAirlineKey) + " and nrouting_id = " + string(lRoutingId),1,dsAirline.Rowcount())
If lFound > 0 Then
	// Treffer in der Negativliste, keine Meldung
	sDebugMessage	= "Airline und Strecke"
	return False
End if
// --------------------------------------------------------------------
// Suche nach Airline und Strecke (Alle) in der NEGATIVLISTE
// --------------------------------------------------------------------	
lFound = dsAirline.Find("nairline_key = " + string(lAirlineKey) + " and nrouting_id = 0",1,dsAirline.Rowcount())
If lFound > 0 Then 
	// Treffer in der Negativliste, keine Meldung
	sDebugMessage	= "Airline und Strecke (Alle)"
	return False
End if

// --------------------------------------------------------------
// 22.03.2007, KF
// POSITIV Liste von Airlines und Strecken $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen
// --------------------------------------------------------------
dsAirlinePositiv.Retrieve(lClientKey)

if dsAirlinePositiv.RowCount() > 0 then

	sDep = dsFlight.GetitemString(1, "cdeparture_time")
	// --------------------------------------------------------------------
	// Suche nach Airline und Strecke in der POSITIVLISTE
	// --------------------------------------------------------------------	
	sFind = "nairline_key = " + string(lAirlineKey) + " and (nrouting_id = " + string(lRoutingId) + " or nrouting_id=0) and ctime_from <= '" + sDep + "' and ctime_to >= '" + sDep + "'"
	lFound = dsAirlinePositiv.Find(sFind ,1,dsAirlinePositiv.Rowcount())
	
	// Messagebox("Suche in Positivliste        ", "lFound: " + String(lFound) + "~r~r" + sFind)
	// f_print_datastore(dsAirlinePositiv)
	
	If lFound > 0 Then 
		// -----------------------------------------------------
		// Treffer in der Positivliste, dann Meldung generieren
		// -----------------------------------------------------
		sDebugMessage	= "Airline und Strecke auf POSITIVLISTE"
		return true
	else
		// -----------------------------------------------------
		// Kein Treffer in der Positivliste, dann keine Meldung
		// -----------------------------------------------------
		sDebugMessage	= "Airline und Strecke nicht auf POSITIVLISTE"
		return false
	End if
	
end if

return True
end function

public function boolean uf_check_airline (long lclientrow);integer	iClientStatus
long		lAirlineKey
long		lRoutingId
long		lFound
String	sDep, sFind
// --------------------------------------------------------------
// Negative Liste von Airlines und Strecken $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen
// --------------------------------------------------------------
iClientStatus	= dsClient.Getitemnumber(lclientrow,"nuse_airline")
// --------------------------------------------------------------------
// nuse_airline hat die Information ob Airline Infos eingegeben wurden
// --------------------------------------------------------------------
If iClientStatus <= 0 Then
	return True
End if	

lAirlineKey		= dsFlight.Getitemnumber(1,"nairline_key")
lRoutingId		= dsFlight.Getitemnumber(1,"nrouting_id")


// -----------------------------------------------------------------------
// 04.06.2007
// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob Negativliste gef$$HEX1$$fc00$$ENDHEX$$llt und aktiviert ist
// 
// -----------------------------------------------------------------------
dsAirline.Retrieve(lClientKey)

if dsAirline.RowCount() > 0 then

	// --------------------------------------------------------------------
	// Negativliste nur durchsuchen, wenn sie auch aktiviert ist
	// --------------------------------------------------------------------
	if dsAirline.GetItemNumber(1,"nactive") = 1 then
		
		// --------------------------------------------------------------------
		// Suche nach Airline und Strecke in der NEGATIVLISTE
		// --------------------------------------------------------------------	
		sDep = dsFlight.GetitemString(1, "cdeparture_time")
		sFind = "nairline_key = " + string(lAirlineKey) + " and (nrouting_id = " + string(lRoutingId) + " or nrouting_id=0) and ctime_from <= '" + sDep + "' and ctime_to >= '" + sDep + "'"
		lFound = dsAirline.Find(sFind,1,dsAirline.Rowcount())
		
		If lFound > 0 Then
			// Treffer in der Negativliste, keine Meldung
			sDebugMessage	= "Airline und Strecke auf der Negativliste"
			return False
		else
			// Kein Treffer in der Negativliste, $$HEX1$$c400$$ENDHEX$$nderungsmitteilung erzeugen, es findet
			// keine Pr$$HEX1$$fc00$$ENDHEX$$fung der Positivliste statt
			sDebugMessage	= "Airline und Strecke nicht auf der Negativliste"
			return true
		End if

	end if

end if

// --------------------------------------------------------------
// 22.03.2007, KF
// POSITIV Liste von Airlines und Strecken $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen
// --------------------------------------------------------------
dsAirlinePositiv.Retrieve(lClientKey)

if dsAirlinePositiv.RowCount() > 0 then

	// --------------------------------------------------------------------
	// Positivliste nur durchsuchen, wenn sie auch aktiviert ist
	// --------------------------------------------------------------------
	if dsAirlinePositiv.GetItemNumber(1,"nactive") = 1 then

		sDep = dsFlight.GetitemString(1, "cdeparture_time")
		// --------------------------------------------------------------------
		// Suche nach Airline und Strecke in der POSITIVLISTE
		// --------------------------------------------------------------------	
		sFind = "nairline_key = " + string(lAirlineKey) + " and (nrouting_id = " + string(lRoutingId) + " or nrouting_id=0) and ctime_from <= '" + sDep + "' and ctime_to >= '" + sDep + "'"
		lFound = dsAirlinePositiv.Find(sFind ,1,dsAirlinePositiv.Rowcount())
		
		// Messagebox("Suche in Positivliste        ", "lFound: " + String(lFound) + "~r~r" + sFind)
		// f_print_datastore(dsAirlinePositiv)
		
		If lFound > 0 Then 
			// -----------------------------------------------------
			// Treffer in der Positivliste, dann Meldung generieren
			// -----------------------------------------------------
			sDebugMessage	= "Airline und Strecke auf POSITIVLISTE"
			return true
		else
			// -----------------------------------------------------
			// Kein Treffer in der Positivliste, dann keine Meldung
			// -----------------------------------------------------
			sDebugMessage	= "Airline und Strecke nicht auf POSITIVLISTE"
			return false
		End if
		
	end if
	
end if

return True
end function

on uo_message.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_message.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// ------------------------------------------------------
// Datastore mit den $$HEX1$$c400$$ENDHEX$$nderungsinformationen
// ------------------------------------------------------
	dsChanges	= create Datastore
	dsChanges.DataObject = 'dw_client_messages'
	dsChanges.SetTransObject(SQLCA)
// ------------------------------------------------------
// Datastore mit einer aktuellen $$HEX1$$c400$$ENDHEX$$nderung
// ------------------------------------------------------
	dsFlight		= create Datastore
	dsFlight.DataObject = 'dw_flight_information'
	dsFlight.SetTransObject(SQLCA)	
// ------------------------------------------------------
// Datastore vom ersten Leg
// ------------------------------------------------------
	dsFlightFirstLeg		= create Datastore
	dsFlightFirstLeg.DataObject = 'dw_change_cen_out'
	dsFlightFirstLeg.SetTransObject(SQLCA)		
// ------------------------------------------------------
// Datastore mit Clientinformationen f$$HEX1$$fc00$$ENDHEX$$r einen Mandant
// ------------------------------------------------------
	dsClient	= create Datastore
	dsClient.DataObject = 'dw_client_information'
	dsClient.SetTransObject(SQLCA)
	dsClient.retrieve(s_app.smandant)
// ------------------------------------------------------
// Datastore mit Negativ Liste von Airlines und Strecken
// ------------------------------------------------------
	dsAirline	= create Datastore
	dsAirline.DataObject = 'dw_client_airline_message'
	dsAirline.SetTransObject(SQLCA)
	dsAirline.retrieve(s_app.smandant)
	
// ------------------------------------------------------
// Datastore mit Negativ Liste von Airlines und Strecken
// ------------------------------------------------------
	dsAirlinePositiv	= create Datastore
	dsAirlinePositiv.DataObject = 'dw_client_airline_assign_message'
	dsAirlinePositiv.SetTransObject(SQLCA)
		
// ------------------------------------------------------
// Debug Datastore 
// ------------------------------------------------------
	dsDebug	= create Datastore
	dsDebug.DataObject = 'dw_client_debug'
	dsDebug.SetTransObject(SQLCA)
// ------------------------------------------------------
// Datastore f$$HEX1$$fc00$$ENDHEX$$r die Textinfo-Bereiche
// ------------------------------------------------------
	dsAreas	= create Datastore
	dsAreas.DataObject = 'dw_message_cen_out_text_area'
	dsAreas.SetTransObject(SQLCA)


end event

event destructor;destroy 	dsChanges
destroy	dsClient
destroy	dsFlight
destroy  dsFlightFirstLeg
destroy	dsAirline
destroy	dsAirlinePositiv
destroy	dsDebug
destroy	dsAreas

end event

