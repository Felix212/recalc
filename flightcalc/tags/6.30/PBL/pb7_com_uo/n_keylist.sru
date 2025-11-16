HA$PBExportHeader$n_keylist.sru
$PBExportComments$zum Umgang mit cen_key_list
forward
global type n_keylist from nonvisualobject
end type
end forward

global type n_keylist from nonvisualobject
end type
global n_keylist n_keylist

type variables
/* 
* object: 			uo_keylist
* Beschreibung: 	objekt zum Umgang mit cen_key_list
*
* Aenderungshistorie:
* 	Version 		Wer							Wann			Was und warum
*	1.0 			Margret N$$HEX1$$fc00$$ENDHEX$$ndel				03.07.2015	Erstellung
*
* ---------------------------------------------------------------------- 
* das objekt kann sowohl numerische werte als auch strings entsprechend der Tabellenformate bearbeiten,
* standardm$$HEX1$$e400$$ENDHEX$$ssig wird SQLCA genutzt, das kann aber anders initialisiert werden
*
* ---------------------------------------------------------------------- 
* grunds$$HEX1$$e400$$ENDHEX$$tzliche nutzung:
* - of_session_start 				l$$HEX1$$f600$$ENDHEX$$scht eine eventuell offene session und startet eine neue
* - of_session_insert_data 		f$$HEX1$$fc00$$ENDHEX$$gt einen wert ein (numerischer oder string parameter)
* - of_session_close 				speichert und beendet die session
* ---------------------------------------------------------------------- 
*
* initialisierungsfunktionen:
* - of_session_cleanup
* 		l$$HEX1$$f600$$ENDHEX$$scht eine eventuell offene session
* 		initialisiert die session-variablen (il_SessionKey=-1, idt_SessionStamp=null, il_LfdNr=0)
* 
* - of_session_set_transaction ( <transaction> )
* 		setzt die transactions-variable  (default ist SQLCA)
* 
* ---------------------------------------------------------------------- 
*
* output-funktionen:
* 
* - of_session_active
* 		gibt den wert true zur$$HEX1$$fc00$$ENDHEX$$ck, wenn ein g$$HEX1$$fc00$$ENDHEX$$ltiger SessionKey gesetzt ist, false sonst
* 
* ---------------------------------------------------------------------- 
*
* verarbeitungs-funktionen:
*
* - of_session_start 				
* 		l$$HEX1$$f600$$ENDHEX$$scht eine eventuell offene session (per of_session_cleanup)
* 		holt einen neuen SessionKey und setzt idt_SessionStamp, wenn erfolgreich
*
* - of_session_insert_data ( <long-wert> )		
* - of_session_insert_data ( <string-wert> )		
* 		f$$HEX1$$fc00$$ENDHEX$$gt einen wert ein (numerischer oder string parameter)
* 		bei strings wird der numerische wert mit einem laufenden z$$HEX1$$e400$$ENDHEX$$hler best$$HEX1$$fc00$$ENDHEX$$ckt
*
* - of_session_commit
* 		speichert die bis dahin eingef$$HEX1$$fc00$$ENDHEX$$gten werte
*
* - of_session_close
* 		speichert die bis dahin eingef$$HEX1$$fc00$$ENDHEX$$gten werte 
* 		initialisiert die session-variablen (il_SessionKey=-1, idt_SessionStamp=null, il_LfdNr=0)
*
* ---------------------------------------------------------------------- 
* 
*/



private:

// daten f$$HEX1$$fc00$$ENDHEX$$r die key_list
Long 			il_SessionKey = -1
Datetime 	idt_SessionStamp
// z$$HEX1$$e400$$ENDHEX$$hler als key ersatz
Long	il_LfdNr = 0

// transaction, die genutzt werden soll
transaction itr_Trans



end variables

forward prototypes
public function long of_session_cleanup ()
public function long of_session_insert_data (long al_value)
public function long of_session_commit ()
public function boolean of_session_active ()
public function long of_session_set_transaction (transaction atr_trans)
public function long of_session_insert_data (string as_value)
public function long of_session_start ()
public function long of_session_close ()
end prototypes

public function long of_session_cleanup ();
/* 
* Function: 			of_session_cleanup (extern)
* Beschreibung: 	alle eintr$$HEX1$$e400$$ENDHEX$$ge zur session l$$HEX1$$f600$$ENDHEX$$schen
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 	Wer						Wann			Was und warum
*	1.0 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel			03.07.2015	Erstellung
*
* Return Codes:
*	 1		immer
*/

// hilfsvariable

if this.il_SessionKey <> -1 then
	// ungespeicherte $$HEX1$$e400$$ENDHEX$$nderung direkt weg
	rollback using this.itr_Trans;
	// dann bereits gespeicherte daten l$$HEX1$$f600$$ENDHEX$$schen
	Delete from cen_key_list where nsession_key=:this.il_SessionKey using this.itr_Trans;
	if this.itr_Trans.sqlcode <> 0 then
		rollback using this.itr_Trans;
	else
		commit using this.itr_Trans;
	end if
end if

// session-variable in jedem fall zur$$HEX1$$fc00$$ENDHEX$$cksetzen
// wenn delete fehlschl$$HEX1$$e400$$ENDHEX$$gt, muss die aufr$$HEX1$$e400$$ENDHEX$$umroutine das mit l$$HEX1$$f600$$ENDHEX$$sen
this.il_SessionKey = -1
SetNull(this.idt_SessionStamp)
this.il_LfdNr = 0

return 1

end function

public function long of_session_insert_data (long al_value);
/* 
* Function: 			of_session_insert_data (extern)
* Beschreibung: 	satz einf$$HEX1$$fc00$$ENDHEX$$gen
* Besonderheit: 	
*
* Argumente:
* 	al_value 		Wert f$$HEX1$$fc00$$ENDHEX$$r nResult_Key
*
* Aenderungshistorie:
* 	Version 	Wer						Wann			Was und warum
*	1.0 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel			03.07.2015	Erstellung
*
* Return Codes:
*	1 		wenn alles geklappt hat
* -1 		im fehlerfall (dann ist auch die session mit weg!!)
*/

// hilfsvariable
Long 		ll_Ret = 1
String 	ls_Error

if this.il_SessionKey <> -1 then
	insert into cen_key_list (nSession_Key, nResult_Key, "DTimestamp") 
	values (:this.il_SessionKey, :al_value, :idt_SessionStamp) 
	using this.itr_Trans;

	if this.itr_Trans.sqlcode <> 0 then
		// TODO Error Handling
		ls_Error = ""
		f_db_error(this.itr_Trans, ls_Error)
		rollback;
		this.of_session_cleanup() 
		ll_Ret = -1
	end if
else
	ll_Ret = -1
end if

return ll_Ret

end function

public function long of_session_commit ();
/* 
* Function: 			of_session_commit (extern)
* Beschreibung: 	transaction abschliessen
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 	Wer						Wann			Was und warum
*	1.0 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel			03.07.2015	Erstellung
*
* Return Codes:
*	 1		immer
*/

// hilfsvariable

commit using this.itr_Trans;

return 1

end function

public function boolean of_session_active ();
/* 
* Function: 			of_session_active (extern)
* Beschreibung: 	aktuellen key holen
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 	Wer						Wann			Was und warum
*	1.0 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel			03.07.2015	Erstellung
*
* Return Codes:
*	true 		wenn aktiver SessionKey vorhanden
* 	false 		sonst
*/

// hilfsvariable
Boolean 		lb_Ret = true

if this.il_SessionKey = -1 then lb_Ret = false


return lb_Ret

end function

public function long of_session_set_transaction (transaction atr_trans);
/* 
* Function: 			of_session_set_transaction (extern)
* Beschreibung: 	alle eintr$$HEX1$$e400$$ENDHEX$$ge zur session l$$HEX1$$f600$$ENDHEX$$schen
* Besonderheit: 	
*
* Argumente:
* 	transaction 	atr_trans
*
* Aenderungshistorie:
* 	Version 	Wer						Wann			Was und warum
*	1.0 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel			03.07.2015	Erstellung
*
* Return Codes:
*	 1		immer
*/

// hilfsvariable


// transaction setzen
this.itr_Trans = atr_Trans

return 1

end function

public function long of_session_insert_data (string as_value);
/* 
* Function: 			of_session_insert_data (extern)
* Beschreibung: 	satz einf$$HEX1$$fc00$$ENDHEX$$gen
* Besonderheit: 	
*
* Argumente:
* 	as_value 		Wert f$$HEX1$$fc00$$ENDHEX$$r cTag
*
* Aenderungshistorie:
* 	Version 	Wer						Wann			Was und warum
*	1.0 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel			03.07.2015	Erstellung
*
* Return Codes:
*	1 		wenn alles geklappt hat
* -1 		im fehlerfall (dann ist auch die session mit weg!!)
*/

// hilfsvariable
Long 		ll_Ret = 1
String 	ls_Error

if this.il_SessionKey <> -1 then
	this.il_LfdNr += 1
	insert into cen_key_list (nSession_Key, nResult_Key, cTag, "DTimestamp") 
	values (:this.il_SessionKey, :this.il_LfdNr, :as_Value, :idt_SessionStamp) 
	using this.itr_Trans;

	if this.itr_Trans.sqlcode <> 0 then
		// TODO Error Handling
		ls_Error = ""
		f_db_error(this.itr_Trans, ls_Error)
		rollback;
		this.of_session_cleanup()
		ll_Ret = -1
	end if
else
	ll_Ret = -1
end if

return ll_Ret

end function

public function long of_session_start ();
/* 
* Function: 			of_session_start (extern)
* Beschreibung: 	alte session aufr$$HEX1$$e400$$ENDHEX$$umen und neuen key holen
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 	Wer						Wann			Was und warum
*	1.0 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel			03.07.2015	Erstellung
*
* Return Codes:
*	 aktuellen Key		immer (falls es keinen gibt, ist er -1)
*/

// hilfsvariable
Long 		ll_Ret


// Aufr$$HEX1$$e400$$ENDHEX$$umen der Tabelle cen_key_list f$$HEX1$$fc00$$ENDHEX$$r die aktuelle Session
ll_Ret = this.of_session_cleanup()

// Neuen Schl$$HEX1$$fc00$$ENDHEX$$ssel f$$HEX1$$fc00$$ENDHEX$$r die Session in der Tabelle cen_key_list holen
this.il_SessionKey = f_sequence("SEQ_cen_key_list", this.itr_Trans)
if this.il_SessionKey > -1 then this.idt_SessionStamp = datetime(today(),now())

return this.il_SessionKey

end function

public function long of_session_close ();
/* 
* Function: 			of_session_close (extern)
* Beschreibung: 	transaction abschliessen und Session-Variable initialisieren
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 	Wer						Wann			Was und warum
*	1.0 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel			03.07.2015	Erstellung
*
* Return Codes:
*	 1		immer
*/

// hilfsvariable

// transaction abschliessen
commit using this.itr_Trans;

// Session-Variable initialisieren
this.il_SessionKey = -1
SetNull(this.idt_SessionStamp)
this.il_LfdNr = 0


return 1

end function

on n_keylist.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_keylist.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;


Long 	ll_Ret


ll_Ret = this.of_session_cleanup()

end event

event constructor;



// transaction, die genutzt werden soll
this.itr_Trans = SQLCA


end event

