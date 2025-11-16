HA$PBExportHeader$uo_json_keyvalue.sru
forward
global type uo_json_keyvalue from nonvisualobject
end type
end forward

global type uo_json_keyvalue from nonvisualobject
end type
global uo_json_keyvalue uo_json_keyvalue

type variables
Private:
string is_key
string is_value
end variables

forward prototypes
public function long of_append (string as_key, string as_value)
public function string of_get_key ()
public function string of_get_value ()
public function long of_set_value (string as_value)
private function string of_escape_string (string as_value)
end prototypes

public function long of_append (string as_key, string as_value);this.is_key = as_key
this.of_set_value(as_value)

return 0
end function

public function string of_get_key ();return this.is_key
end function

public function string of_get_value ();return this.is_value
end function

public function long of_set_value (string as_value);if isNull(as_value) then
	this.is_value=""
else
	this.is_value = of_escape_string(as_value)
end if
return 0
end function

private function string of_escape_string (string as_value);string ls_return
n_string	lnvo_string

string old_str = "~""
string new_str = "\~""

if not Match(as_value, old_str) then return as_value

lnvo_string = create n_string

ls_return = lnvo_string.of_replaceall(as_value, old_str, new_str )

destroy lnvo_string

return ls_return

end function

on uo_json_keyvalue.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_json_keyvalue.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

