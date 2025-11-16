HA$PBExportHeader$uo_cart_datastore.sru
$PBExportComments$Datastore mit Protokollfunktionen
forward
global type uo_cart_datastore from datastore
end type
end forward

global type uo_cart_datastore from datastore
end type
global uo_cart_datastore uo_cart_datastore

type variables
// --------------------------
// Logging
// --------------------------
protected string	is_LogFile, isIPAdress

datastore dsObjects

Integer iDebug = 0


end variables

forward prototypes
public function integer of_get_objects ()
public function long of_log (string smessage)
public subroutine of_set_log_file (string as_file)
end prototypes

public function integer of_get_objects ();

return 0

end function

public function long of_log (string smessage);
return 0
end function

public subroutine of_set_log_file (string as_file);is_LogFile = as_File
end subroutine

on uo_cart_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cart_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

