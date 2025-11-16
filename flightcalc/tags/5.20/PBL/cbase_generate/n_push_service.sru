HA$PBExportHeader$n_push_service.sru
$PBExportComments$Generated Jaguar Component
forward
global type n_push_service from nonvisualobject
end type
end forward

global type n_push_service from nonvisualobject
end type
global n_push_service n_push_service

forward prototypes
public function long of_get_next_sequence (string as_sequence)
public function string of_send (string as_topic, string as_data)
public function long of_cleanup ()
end prototypes

public function long of_get_next_sequence (string as_sequence);/**
* Liefert die N$$HEX1$$e400$$ENDHEX$$chste Sequence Nummer
* (Diese Methode ist eine angepasste Kopie der EAServer Componente cbase_push_service)
*
* @param string as_sequence F$$HEX1$$fc00$$ENDHEX$$r den PushService ist folgende gew$$HEX1$$e400$$ENDHEX$$hlt SEQ_SYS_MSG_MESSAGES
* @return long The next Sequence; -1 when sqlerror
*/


long 						ll_NextID
long						ll_Ret
string 					ls_SQL
DynamicStagingArea	dsaSQLSA

//-------------------------------------------------------------
//SQLCA must be set !!!
//-------------------------------------------------------------

dsaSQLSA = Create DynamicStagingArea

// ein wenig Dynamic SQL

DECLARE cur_AutoInc DYNAMIC CURSOR FOR dsaSQLSA ;
	
ls_SQL =  "Select " + as_sequence + ".nextval from dual"

PREPARE dsaSQLSA FROM :ls_SQL;

OPEN DYNAMIC cur_AutoInc ;

If SQLCA.SQLCODE <> 0 Then
	ll_NextID = -1
else
	FETCH cur_AutoInc INTO :ll_NextID ;
End if	

CLOSE 	cur_AutoInc ;
Destroy 	dsaSQLSA


return ll_NextID
end function

public function string of_send (string as_topic, string as_data);/**
*  Die Nachricht wird zuerst in SYS_MSG_MESSAGES gespeichert, anschliessend
*  wird eine Referenz zur Nachricht (NMESSAGE_KEY) f$$HEX1$$fc00$$ENDHEX$$r alle  Clients die das Topic 
*  der Nachricht abonniert haben (SYS_MSG_SUBSCRIBER) in der Auslieferungstabelle 
*  (SYS_MSG_DELIVERY) abgelegt.
* (Diese Methode ist eine angepasste Kopie der EAServer Componente cbase_push_service)
*
* @param string as_topic Topic der Nachricht
* @param string as_data Die eigenltiche Nachricht, Ziel Format der Clients beachten!!
* @return string <0 error
*/


integer li_ret
Long ll_Message_Id
Long i
String ls_Queue[]
string ls_return
string ls_value

//-------------------------------------------------------------
//SQLCA Database must be set !!!!
//-------------------------------------------------------------


ll_Message_Id = of_get_next_sequence("SEQ_SYS_MSG_MESSAGES")

if ll_Message_Id = -1 then
	//of_log(1,isMethod,"seq_msg_message.of_get_next_sequence() Error:" + sqlca.sqlerrtext + ":" + String(sqlca.sqlcode))
	return string(-1)
end if

INSERT INTO SYS_MSG_MESSAGES (NMESSAGE_KEY, CTOPIC, DTIMESTAMP, CDATA) VALUES (:ll_Message_Id, :as_topic, CURRENT_TIMESTAMP, :as_data) USING SQLCA;
if sqlca.sqlcode <> 0 then
	rollback using SQLCA;
	//of_log(1,isMethod,"INSERT INTO SYS_MSG_MESSAGES Error:" + sqlca.sqlerrtext + ":" + String(sqlca.sqlcode))
	return string(-3)
else
	//of_log(99,isMethod, "Saved Message ID/Topic:" +string(ll_Message_Id) + "/" + as_topic)
end if 

// Ermittlung der Abo Clients
DECLARE cur_Queue CURSOR FOR SELECT CQUEUE FROM SYS_MSG_SUBSCRIBER WHERE CTOPIC=:as_topic USING SQLCA;
OPEN cur_Queue ;
if sqlca.sqlcode <> 0 then
	//of_log(1,isMethod,"OPEN CURSOR Error:" + sqlca.sqlerrtext + ":" + String(sqlca.sqlcode))
	return string(-4)
end if

FETCH cur_Queue INTO :ls_value;
Do While SQLCA.SQLCODE = 0
	if ls_value <> "" then
		i = upperbound(ls_Queue) + 1
		ls_Queue[i] = ls_value
		//of_log(99,isMethod, "Fetching Subscriber [No#/Queue] :" +string(i) + "/" + ls_Queue[i] )
	end if
	FETCH cur_Queue INTO :ls_value;
Loop
CLOSE cur_Queue ;

for i = 1 to upperbound(ls_Queue)
	INSERT INTO SYS_MSG_DELIVERY (CQUEUE, NMESSAGE_KEY) VALUES (:ls_Queue[i], :ll_Message_Id) USING SQLCA;
	if sqlca.sqlcode = 0 then	
		//of_log(99,isMethod, "Message_ID delivered to Queue:" + string(ll_Message_Id) + "/" +ls_Queue[i])
	else
		//of_log(1,isMethod,"INSERT INTO SYS_MSG_DELIVERY Error:" + sqlca.sqlerrtext + ":" + String(sqlca.sqlcode))
	end if
next
		
commit using SQLCA;

// an alle Abos ausgelieferte Nachrichten entfernen
of_cleanup()

return ls_return
end function

public function long of_cleanup ();/**
* Ausgelagerte Methode zum Aufraeumen alter Nachrichten die keinem
* Abo zugeordnet sind. Augelagert deshalb damit es zu keinem Deadlock kommt.
* (Diese Methode ist eine angepasste Kopie der EAServer Componente cbase_push_service)
*
* @param none ...
* @return long ...
*/


integer	li_ret
long ll_count

//-------------------------------------------------------------
//SQLCA Database must be set !!!
//-------------------------------------------------------------

SELECT COUNT(NMESSAGE_KEY) into :ll_count FROM SYS_MSG_MESSAGES WHERE NMESSAGE_KEY NOT IN( SELECT NMESSAGE_KEY FROM SYS_MSG_DELIVERY) USING SQLCA;
//of_log(99,isMethod, "Starting cleanup " + String(ll_count) + " Message(s)" )

// Alte, vollstaendig ausgelieferte, Nachichten entfernen
DELETE FROM SYS_MSG_MESSAGES WHERE NMESSAGE_KEY NOT IN( SELECT NMESSAGE_KEY FROM SYS_MSG_DELIVERY) USING SQLCA;

if sqlca.sqlcode <> 0 then
	ROLLBACK USING SQLCA;
	//of_log(1,isMethod,"Cleanup Error:" + sqlca.sqlerrtext + ":"+ String(sqlca.sqlcode))
else
	COMMIT USING SQLCA;
	//of_log(99,isMethod, "Cleanup done")
end if

return 0
end function

event constructor;/**
* This is a functional subset from the EAServer Component cbase_push_service and
* provides the basic functions to push a Message only, no receive!
*
* @author Alex Schaab
* @date 06.03.2015
*/

end event

on n_push_service.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_push_service.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

