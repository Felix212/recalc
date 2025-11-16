HA$PBExportHeader$uo_request_idoc.sru
forward
global type uo_request_idoc from nonvisualobject
end type
end forward

global type uo_request_idoc from nonvisualobject
end type
global uo_request_idoc uo_request_idoc

type variables


datastore	ids_request
end variables

forward prototypes
public function integer of_insert_flight (long arg_result, integer arg_type, integer arg_application, long arg_transaction)
public function integer of_insert (long arg_result, long arg_application, string sorderstatus, long arg_transaction)
end prototypes

public function integer of_insert_flight (long arg_result, integer arg_type, integer arg_application, long arg_transaction);// --------------------------------------------------------------------------------
// Objekt : uo_request_idoc
// Methode: of_insert_flight (Function)
// Autor  : M. Barfknecht
// --------------------------------------------------------------------------------
// Argument(e):
// long arg_result
//  integer arg_type
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung: Tr$$HEX1$$e400$$ENDHEX$$gt einen Flug in sky_idoc_request
//					ein
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  23.08.2013	           M.Barfknecht      Erstellung
//  13.12.2013			  S.R.					CPRD Eintrag erlauben, wenn es noch keinen CPRD/CBIL Satz gibt.
// --------------------------------------------------------------------------------
long	ll_Queue_Rows,ll_Sequence,ll_NewRow,li_Succ 
string sorderstatus

//Typzuordnung

choose case arg_type
		
	case	1
		sorderstatus = 'CPLN'
	case	2
		sorderstatus = 'CPRD'
	case	3
		sorderstatus = 'CBIL'
	
	case else
		//Falscher Typ
		return -1
		
end choose		

//$$HEX1$$dc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen, ob es den Flug schon in der queue gibt:
//  13.12.2013			  S.R.					CPRD Eintrag erlauben, wenn es noch keinen CPRD/CBIL Satz gibt.
IF arg_type=2 THEN
	
	ll_Queue_Rows = 0
	select	count(*)
	into		:ll_Queue_Rows
	from		sky_idoc_request 
	where		napplication = :arg_application
	and		nresult_key = :arg_result
	and		ntransaction = :arg_transaction
	and 		corderstatus in('CPRD','CBIL')
	;
	
	IF SQLCA.SQLCode = 0 Then
		If ll_Queue_Rows > 0 Then
		
				Return -1
		End if
	End If		
ELSE

	ll_Queue_Rows = 0
	select	count(*)
	into		:ll_Queue_Rows
	from		sky_idoc_request 
	where		napplication = :arg_application
	and		nresult_key = :arg_result
	and		ntransaction = :arg_transaction
	;
	
	IF SQLCA.SQLCode = 0 Then
		If ll_Queue_Rows > 0 Then
		
				Return -1
		End if
	End If	
END IF
	
//Flug anlegen

//ll_Sequence = f_Sequence("seq_sky_idoc_request", sqlca)
//
//	If ll_Sequence = -1 Then
//		uf.MBox ("Datenbankfehler", "Es konnte kein eindeutiger Schl$$HEX1$$fc00$$ENDHEX$$ssel (Sequence) ermittelt werden.~r~r" + &
//											 "Keine Neuanlage m$$HEX1$$f600$$ENDHEX$$glich.", StopSign!)
//		return -1
//	Else
//		// Einstellen in sky_idoc_request	
//		ll_NewRow = ids_request.InsertRow(0)
//		li_Succ = ids_request.SetItem(ll_NewRow, "nbilling_request_key", ll_Sequence)
//		li_Succ = ids_request.SetItem(ll_NewRow, "nresult_key", arg_result)
//		li_Succ = ids_request.SetItem(ll_NewRow, "napplication", arg_application)
//		li_Succ = ids_request.SetItem(ll_NewRow, "corderstatus", sorderstatus)
//		li_Succ = ids_request.SetItem(ll_NewRow, "ntransaction", arg_transaction)
//		
//	End If
//	
//	
//If ids_request.update() = 1 Then
//	Commit;
//	return 0
//else
//	rollback;
//	return -1
//end if

li_succ = of_insert( arg_result, arg_application, sorderstatus, arg_transaction)

If li_succ = 0 Then
	Commit;
	return 0
else
	rollback;
	return -1
end if

end function

public function integer of_insert (long arg_result, long arg_application, string sorderstatus, long arg_transaction);// --------------------------------------------------------------------------------
// Objekt : uo_request_idoc
// Methode: of_insert (Function)
// Autor  : M. Barfknecht
// --------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung: Flug in die Tabelle eintragen
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  17.12.2013	           M.Barfknecht       Erstellung
//
// --------------------------------------------------------------------------------

long ll_sequence,ll_newrow
integer	li_succ

ids_request.reset()

//Flug anlegen

ll_Sequence = f_Sequence("seq_sky_idoc_request", sqlca)

	If ll_Sequence = -1 Then
		uf.MBox ("Datenbankfehler", "Es konnte kein eindeutiger Schl$$HEX1$$fc00$$ENDHEX$$ssel (Sequence) ermittelt werden.~r~r" + &
											 "Keine Neuanlage m$$HEX1$$f600$$ENDHEX$$glich.", StopSign!)
		return -1
	Else
		// Einstellen in sky_idoc_request	
		ll_NewRow = ids_request.InsertRow(0)
		li_Succ = ids_request.SetItem(ll_NewRow, "nbilling_request_key", ll_Sequence)
		li_Succ = ids_request.SetItem(ll_NewRow, "nresult_key", arg_result)
		li_Succ = ids_request.SetItem(ll_NewRow, "napplication", arg_application)
		li_Succ = ids_request.SetItem(ll_NewRow, "corderstatus", sorderstatus)
		li_Succ = ids_request.SetItem(ll_NewRow, "ntransaction", arg_transaction)
		
	End If
	
	
If ids_request.update() = 1 Then
	
	return 0
else
	
	return -1
end if


end function

on uo_request_idoc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_request_idoc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_request = create datastore
ids_request.dataobject='dw_billing_browser_idoc_request'
ids_request.settransobject(SQLCA)


end event

event destructor;destroy ids_request
end event

