HA$PBExportHeader$uo_rtn_queue.sru
$PBExportComments$Insert rows into Queue sys_bill_init_queue
forward
global type uo_rtn_queue from nonvisualobject
end type
end forward

global type uo_rtn_queue from nonvisualobject autoinstantiate
end type

type variables


protected:

Long 		il_ErrorNo = 0
String 	is_ErrorText = ""

end variables

forward prototypes
protected function long of_get_function_key (string as_type)
public function boolean of_is_enabled (string as_client, ref transaction atr_sqlca)
protected function string of_mandant_profilestring (ref transaction atr_sqlca, string as_mandant, string as_section, string as_key, string as_default)
public function long of_enqueue_flight (long al_result_key, string as_int_type, ref transaction atr_sqlca, string as_modified, string as_mandant)
public function long of_enqueue_flight (long al_result_key, string as_int_type, ref transaction atr_sqlca, string as_modified)
public function long of_check_error (ref string as_errortext)
public function long of_check_error ()
public function long of_enqueue_flight (long al_result_key, long al_int_type, ref transaction atr_sqlca, string as_modified, string as_mandant)
end prototypes

protected function long of_get_function_key (string as_type);
/*
* Objekt : uo_rtn_queue
* Methode: of_get_function_key (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 18.04.2012
*
* Argument(e):
* string as_type
*
* Beschreibung:		Mapping Type Text to Key
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	18.04.2012		Erstellung
*
*
* Return: long
* 	einen g$$HEX1$$fc00$$ENDHEX$$ltigen Key
* 	 -1 im falle eines ung$$HEX1$$fc00$$ENDHEX$$ltigen typs
*
*/

Long	ll_Type

ll_Type = -1

//  SELECT nbint_key  
//    INTO :ll_Type
//    FROM sys_bill_int_rtypes  
//   WHERE ctext = :as_type ;

Choose case as_Type
	Case "INT003"
		ll_Type = 10030
	Case "INT004"
		ll_Type = 10040
	Case "INT005"
		ll_Type = 10050
	Case "INT006"
		ll_Type = 10060
	Case "INT007"
		ll_Type = 10070
	Case "INT007_LOAD"
		ll_Type = 10071
	Case "INT008"
		ll_Type = 10080
	Case "INT010"
		ll_Type = 10100
	Case "INT011"
		ll_Type = 10110
	Case "INT012_LOAD"
		ll_Type = 10121 // 26.05.2014 HR:
	Case "INT012"
		ll_Type = 10120
		
End Choose


Return ll_Type

/*
insert into sys_bill_int_rtypes values (10030, 'INT003', 0);
insert into sys_bill_int_rtypes values (10040, 'INT004', 0);
insert into sys_bill_int_rtypes values (10050, 'INT005', 0);
insert into sys_bill_int_rtypes values (10060, 'INT006', 0);
insert into sys_bill_int_rtypes values (10070, 'INT007', 0);
insert into sys_bill_int_rtypes values (10071, 'INT007_LOAD', 0);
insert into sys_bill_int_rtypes values (10080, 'INT008', 0);
insert into sys_bill_int_rtypes values (10100, 'INT010', 0);
insert into sys_bill_int_rtypes values (10110, 'INT011', 0);*/


end function

public function boolean of_is_enabled (string as_client, ref transaction atr_sqlca);
/*
* Objekt : uo_rtn_queue
* Methode: of_is_enabled (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 18.04.2012
*
* Argument(e):
*	 string as_mandant 		der mandant, f$$HEX1$$fc00$$ENDHEX$$r den gelesen werden soll
*	 transaction atr_sqlca 	die transaction, die genutzt werden soll
*
* Beschreibung:		Read Global Switch (Is Return Interface processing enabled)
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				O.Hoefer			18.04.2012		Erstellung
*
*
* Return: boolean
*
*/

// hilfsvariable
Boolean	lb_return
long		ll_Value

// initialisieren
lb_return = FALSE

ll_Value = long(this.of_mandant_profilestring(atr_sqlca, as_client, "ReturnInterface", "EnableReturnInterface", "0"))
if ll_Value = 1 then
	lb_return = TRUE
end if

return lb_return

end function

protected function string of_mandant_profilestring (ref transaction atr_sqlca, string as_mandant, string as_section, string as_key, string as_default);

//string f_mandant_profilestring (transaction arg_sqlca, string arg_mandant, string arg_section, string arg_key, string arg_default);//
/* 
* Funktion/Event: f_mandant_profilestring
* Beschreibung: 	Lesen eines Wertes aus der cen_setup
* Besonderheit: 	hier abgespeckt auf nur lesen, nicht eintragen
*
* Argument(e):
*	 transaction atr_sqlca 	die transaction, die genutzt werden soll
*	 string as_mandant 		der mandant, f$$HEX1$$fc00$$ENDHEX$$r den gelesen werden soll
*	 string as_section 			die section, aus der gelesen werden soll
*	 string as_key 				die wert, der gelesen werden soll
*	 string as_default 			der wert, der genommen werden soll, wenn der zu lesende wert fehlt
*
*
* Aenderungshistorie:
* 	Version 		Wer					Wann				Was und warum
*	1.0 			O.H$$HEX1$$f600$$ENDHEX$$fer				19.04.2012		$$HEX1$$fc00$$ENDHEX$$bernommen aus f_mandant-profilestring (cbase)
*
* Return: string
* 	as_default 	wert nicht gefunden oder fehler (select)
*	wert 			sonst
*/

// hilfsvariable
String	ls_Value

// parameter auf die maximal m$$HEX1$$f600$$ENDHEX$$gliche l$$HEX1$$e400$$ENDHEX$$nge eink$$HEX1$$fc00$$ENDHEX$$rzen, falls n$$HEX1$$f600$$ENDHEX$$tig
if len(as_section) > 25 then as_section = left(as_section, 25)

Select 	cValue 
into 		:ls_Value 
from		cen_setup
where	cclient		= :as_mandant  	and
			cSection		= :as_Section		and
			cKey			= :as_Key
using 		atr_sqlca;
			

// fehlerstatus $$HEX1$$fc00$$ENDHEX$$bernehmen
this.il_ErrorNo = atr_sqlca.SQLCode
this.is_Errortext = ""

// Wert nicht gefunden oder fehler: default eintragen und zur$$HEX1$$fc00$$ENDHEX$$ckgeben
if atr_sqlca.SQLCode <> 0 then
	ls_Value = as_default
end if

// Wert nicht gefunden: ok zur$$HEX1$$fc00$$ENDHEX$$ckgeben
if atr_sqlca.SQLCode = 100 then
	this.il_ErrorNo = 0
end if

// fehler: eintragen
if atr_sqlca.SQLCode = -1 then
	this.is_ErrorText = "select cen_setup (" + as_mandant + "-" + as_section + "-" + as_key + ") failed"
end if

return ls_Value

end function

public function long of_enqueue_flight (long al_result_key, string as_int_type, ref transaction atr_sqlca, string as_modified, string as_mandant);
/*
* Objekt : uo_rtn_queue
* Methode: of_enqueue_flight (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 18.04.2012
*
* Argument(e):
*	 long al_result_key 		der flug, zu dem der satz geh$$HEX1$$f600$$ENDHEX$$rt
*	 string as_int_type 		der typ des satzes, der eingetragen werden soll
*	 transaction atr_sqlca 	die transaction, die genutzt werden soll
*	 string as_modified 		die kennung der quelle, woher der satz kommt ("host")
*	 string as_mandant 		der mandant, f$$HEX1$$fc00$$ENDHEX$$r den gelesen werden soll
*
* Beschreibung:		Insert Row into RTN Queue Table SYS_BILL_INT_QUEUE
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				O.Hoefer			18.04.2012		Erstellung
*
*
* Return: long
* 	-1 	fehler (sequence oder insert)
*	0 	eintragen nicht erforderlich
*	1 	eintragen erfolgreich
*/

// hilfsvariable
Long		ll_Ret, ll_Sequence
Long		ll_function_key
DateTime	ldt_Now


// --------------------------------------------------------
// erstmal pr$$HEX1$$fc00$$ENDHEX$$fen, ob eintrag $$HEX1$$fc00$$ENDHEX$$berhaupt gewollt 
// --------------------------------------------------------
if not IsNull(as_mandant) and as_mandant <> trim("") then
	if not this.of_is_enabled(as_mandant, atr_sqlca) then
		if this.il_ErrorNo <> 0 then
			return -1
		else
			return 0
		end if
	end if
end if

// --------------------------------------------------------
// initialisieren
// --------------------------------------------------------
// aktuellen zeitpunkt holen
ldt_Now = DateTime(Today(), Now())

// kein null-value f$$HEX1$$fc00$$ENDHEX$$r quelle
if IsNull(as_modified) then as_modified = ""

// function-key holen
ll_function_key = of_get_function_key(as_int_type)
if ll_function_key <= 0 then
	return ll_function_key
end if

// --------------------------------------------------------
// Auftrag eintragen
// --------------------------------------------------------
// neuen key holen
ll_Sequence = f_Sequence ("SEQ_SYS_BILL_INT_QUEUE", atr_sqlca)
if ll_Sequence = -1 then
	this.is_Errortext = "Es konnte kein eindeutiger Schl$$HEX1$$fc00$$ENDHEX$$ssel (Sequence) ermittelt werden.~r~rKeine Neuanlage m$$HEX1$$f600$$ENDHEX$$glich."
	this.il_ErrorNo = -1
	//uf.MBox ("Datenbankfehler", "Es konnte kein eindeutiger Schl$$HEX1$$fc00$$ENDHEX$$ssel (Sequence) ermittelt werden.~r~r" + &
	//										 "Keine Neuanlage m$$HEX1$$f600$$ENDHEX$$glich.", StopSign!)
	ll_Ret = -1
	return ll_Ret
end if

// flug eintragen
INSERT INTO SYS_BILL_INT_QUEUE  
         ( njob_nr,   
           nresult_key,   
           dcreated,   
           nstatus,   
           nbint_key,   
           nerror,   
           cmodified )  
VALUES (:ll_Sequence,   
		 	:al_result_key,   
			:ldt_Now,
			0,   
			:ll_function_key, 
			0,
			:as_modified ) 
			USING atr_sqlca;

// fehlerstatus $$HEX1$$fc00$$ENDHEX$$bernehmen
this.il_ErrorNo = atr_sqlca.SQLCode
this.is_Errortext = ""

if atr_sqlca.SQLCode = 0 then
	// flug eintragen erfolgreich
	commit using atr_sqlca;
else			
	// flug eintragen gescheitert (details im trancaction-object, da reference-$$HEX1$$fc00$$ENDHEX$$bergabe)
	this.is_Errortext = "Insert sys_bill_int_queue failed"
	this.il_ErrorNo = atr_sqlca.SQLCode
	rollback using atr_sqlca;
end if

return 1

end function

public function long of_enqueue_flight (long al_result_key, string as_int_type, ref transaction atr_sqlca, string as_modified);
/*
* Objekt : uo_rtn_queue
* Methode: of_enqueue_flight (Function)
* Autor  : Margret N$$HEX1$$fc00$$ENDHEX$$ndel
* Datum  : 20.04.2012
*
* Argument(e):
*	 long al_result_key 		der flug, zu dem der satz geh$$HEX1$$f600$$ENDHEX$$rt
*	 string as_int_type 		der typ des satzes, der eingetragen werden soll
*	 transaction atr_sqlca 	die transaction, die genutzt werden soll
*	 string as_modified 		die kennung der quelle, woher der satz kommt ("host")
*
* Beschreibung:		wrapper f$$HEX1$$fc00$$ENDHEX$$r die eigentliche funktion: wenn kein mandant kommt, soll immer geschrieben werden 
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel			20.04.2012		Erstellung
*
*
* Return: long
* 	-1 	fehler (sequence oder insert)
*	0 	eintragen nicht erforderlich
*	1 	eintragen erfolgreich
*/


return this.of_enqueue_flight (al_result_key, as_int_type, atr_sqlca, as_modified, "")

end function

public function long of_check_error (ref string as_errortext);
/*
* Objekt : uo_rtn_queue
* Methode: of_check_error (Function)
* Autor  : Margret N$$HEX1$$fc00$$ENDHEX$$ndel
* Datum  : 20.04.2012
*
* Argument(e):
*	 string as_errortext 		puffer f$$HEX1$$fc00$$ENDHEX$$r den fehlertext
*
* Beschreibung:		$$HEX1$$fc00$$ENDHEX$$bernimmt den inhalt is_errortext und gibt il_errorno zur$$HEX1$$fc00$$ENDHEX$$ck 
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel			20.04.2012		Erstellung
*
*
* Return: long
* 	-1 	fehler
*	0 	alles ok
*/

as_errortext = this.is_ErrorText
return this.il_ErrorNo

end function

public function long of_check_error ();
/*
* Objekt : uo_rtn_queue
* Methode: of_check_error (Function)
* Autor  : Margret N$$HEX1$$fc00$$ENDHEX$$ndel
* Datum  : 20.04.2012
*
* Argument(e):
*
* Beschreibung:		gibt il_ErrorNo zur$$HEX1$$fc00$$ENDHEX$$ck 
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel			20.04.2012		Erstellung
*
*
* Return: long
* 	-1 	fehler
*	0 	alles ok
*/

return this.il_ErrorNo

end function

public function long of_enqueue_flight (long al_result_key, long al_int_type, ref transaction atr_sqlca, string as_modified, string as_mandant);
/*
* Objekt : uo_rtn_queue
* Methode: of_enqueue_flight (Function)
*
* Argument(e):
*	 long al_result_key 		der flug, zu dem der satz geh$$HEX1$$f600$$ENDHEX$$rt
*	 long al_int_type 			der typ des satzes, der eingetragen werden soll
*	 transaction atr_sqlca 	die transaction, die genutzt werden soll
*	 string as_modified 		die kennung der quelle, woher der satz kommt ("host")
*	 string as_mandant 		der mandant, f$$HEX1$$fc00$$ENDHEX$$r den gelesen werden soll
*
* Beschreibung:		Insert Row into RTN Queue Table SYS_BILL_INT_QUEUE
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				T. Schaefer		29.01.2020		Erstellung
*
*
* Return: long
* 	-1 	fehler (sequence oder insert)
*	0 	eintragen nicht erforderlich
*	1 	eintragen erfolgreich
*/

Long		ll_Ret, ll_Sequence
DateTime	ldt_Now


// --------------------------------------------------------
// erstmal pr$$HEX1$$fc00$$ENDHEX$$fen, ob eintrag $$HEX1$$fc00$$ENDHEX$$berhaupt gewollt 
// --------------------------------------------------------
if not IsNull(as_mandant) and as_mandant <> trim("") then
	if not this.of_is_enabled(as_mandant, atr_sqlca) then
		if this.il_ErrorNo <> 0 then
			return -1
		else
			return 0
		end if
	end if
end if

// --------------------------------------------------------
// initialisieren
// --------------------------------------------------------
// aktuellen zeitpunkt holen
ldt_Now = DateTime(Today(), Now())

// kein null-value f$$HEX1$$fc00$$ENDHEX$$r quelle
if IsNull(as_modified) then as_modified = ""

// --------------------------------------------------------
// Auftrag eintragen
// --------------------------------------------------------
// neuen key holen
ll_Sequence = f_Sequence ("SEQ_SYS_BILL_INT_QUEUE", atr_sqlca)
if ll_Sequence = -1 then
	this.is_Errortext = "Es konnte kein eindeutiger Schl$$HEX1$$fc00$$ENDHEX$$ssel (Sequence) ermittelt werden.~r~rKeine Neuanlage m$$HEX1$$f600$$ENDHEX$$glich."
	this.il_ErrorNo = -1
	//uf.MBox ("Datenbankfehler", "Es konnte kein eindeutiger Schl$$HEX1$$fc00$$ENDHEX$$ssel (Sequence) ermittelt werden.~r~r" + &
	//										 "Keine Neuanlage m$$HEX1$$f600$$ENDHEX$$glich.", StopSign!)
	ll_Ret = -1
	return ll_Ret
end if

// flug eintragen
INSERT INTO SYS_BILL_INT_QUEUE  
         ( njob_nr,   
           nresult_key,   
           dcreated,   
           nstatus,   
           nbint_key,   
           nerror,   
           cmodified )  
VALUES (:ll_Sequence,   
		 	:al_result_key,   
			:ldt_Now,
			0,   
			:al_int_type, 
			0,
			:as_modified ) 
			USING atr_sqlca;

// fehlerstatus $$HEX1$$fc00$$ENDHEX$$bernehmen
this.il_ErrorNo = atr_sqlca.SQLCode
this.is_Errortext = ""

if atr_sqlca.SQLCode = 0 then
	// flug eintragen erfolgreich
	commit using atr_sqlca;
else			
	// flug eintragen gescheitert (details im trancaction-object, da reference-$$HEX1$$fc00$$ENDHEX$$bergabe)
	this.is_Errortext = "Insert sys_bill_int_queue failed"
	this.il_ErrorNo = atr_sqlca.SQLCode
	rollback using atr_sqlca;
end if

return 1

end function

on uo_rtn_queue.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_rtn_queue.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

