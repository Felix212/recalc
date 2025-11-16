HA$PBExportHeader$uo_json_array.sru
forward
global type uo_json_array from nonvisualobject
end type
end forward

global type uo_json_array from nonvisualobject
end type
global uo_json_array uo_json_array

type prototypes
global function string replace_all (readonly string source, readonly string find, readonly string replace) system library "fastfuncs125.dll" alias for "Replace_All"
global function string replace_all (readonly string source, readonly string find, readonly string replace, boolean insensitive) system library "fastfuncs125.dll" alias for "Replace_All"

global function boolean append (ref blob ab_source, readonly string as_append, ...) system library "fastfuncs125.dll" alias for "Append"
global function boolean append (ref string as_source, readonly string as_append, ...) system library "fastfuncs125.dll" alias for "Append"
end prototypes

type variables
Private:
string is_key
string is_value []
//Already Parsed json String Values for Array by external FastFunc
string	is_parsed_value
uo_json_object iuo_object[]
end variables

forward prototypes
public function integer of_append (string as_value)
public function integer of_set_key (string as_key)
public function string of_get_key ()
public function string of_get_json_string ()
public function long of_has_values ()
public function long of_has_objects ()
public function uo_json_object of_find_object_by_key (string as_key)
public function uo_json_array of_find_array_by_key (string as_key)
public function uo_json_object of_get_object (long al_index)
public function uo_json_object of_find_object_by_keyvalue (string as_key, string as_value)
public function uo_json_object of_append_object ()
private function string of_escape_string (string as_value)
public function integer of_append_string (string as_value, string as_delimiter)
end prototypes

public function integer of_append (string as_value);long ll_cnt

ll_cnt = Upperbound(is_value) + 1
if isNull(as_value) then
	is_value[ll_cnt] = ""
else
	is_value[ll_cnt] = of_escape_string(as_value)
end if

return 0
end function

public function integer of_set_key (string as_key);this.is_key = as_key

return 0
end function

public function string of_get_key ();return this.is_key
end function

public function string of_get_json_string ();string ls_result
long ll_cnt

ls_result = '['

//Exception Handling when fastfunc.dll not exists
/*
try

	for ll_cnt = 1 to this.of_has_values( ) 
		
		append(ls_result, '"'+this.is_value[ll_cnt]+'"')
		if not ll_cnt = this.of_has_values( ) then
			append(ls_result, ',')
		end if
	Next
	
	//Parsed Values ebenfalls eintragen wenn vorhanden
	if len(this.is_parsed_value) > 0 then
		append(ls_result, this.is_parsed_value)
	end if
	
	//wenn vorher key/values eingetragen sind erst mit komma bevor objekte folgen
	if this.of_has_values( ) > 0 and this.of_has_objects( ) > 0 then append(ls_result, ',')
		
	for ll_cnt = 1 to this.of_has_objects( )
		
		append(ls_result, this.iuo_object[ll_cnt].of_get_json_string())
		
		if not ll_cnt = this.of_has_objects( ) then
			append(ls_result, ',')
		end if
	Next
	
	append(ls_result, ']')

catch(Runtimeerror e)
*/
	for ll_cnt = 1 to this.of_has_values( ) 
		
		ls_result += '"'+this.is_value[ll_cnt]+'"'
		if not ll_cnt = this.of_has_values( ) then
			ls_result += ','
		end if
	Next
	
	//Parsed Values ebenfalls eintragen wenn vorhanden
	if len(this.is_parsed_value) > 0 then
		ls_result += this.is_parsed_value
	end if
	
	//wenn vorher key/values eingetragen sind erst mit komma bevor objekte folgen
	if this.of_has_values( ) > 0 and this.of_has_objects( ) > 0 then ls_result += ','
		
	for ll_cnt = 1 to this.of_has_objects( )
		
		ls_result += this.iuo_object[ll_cnt].of_get_json_string()
		
		if not ll_cnt = this.of_has_objects( ) then
			ls_result += ','
		end if
	Next
	
	ls_result += ']'

//end try

return ls_result
end function

public function long of_has_values ();return Upperbound(is_value)
end function

public function long of_has_objects ();return Upperbound(iuo_object)
end function

public function uo_json_object of_find_object_by_key (string as_key);long ll_cnt
uo_json_object luo_json_object

//start with drill down to child objects
for ll_cnt = 1 to this.of_has_objects( )
	luo_json_object = iuo_object[ll_cnt].of_find_object_by_key(as_key)
	//if isvalid(luo_json_object) then luo_json_object = luo_json_object
	
Next

return luo_json_object
end function

public function uo_json_array of_find_array_by_key (string as_key);long ll_cnt
uo_json_array luo_json_array

//first check if this array is target
if this.of_get_key() = as_key then return this

//proceed with drill down to child objects
for ll_cnt = 1 to this.of_has_objects( )
	luo_json_array = iuo_object[ll_cnt].of_find_array_by_key(as_key)
	if isValid(luo_json_array) then return luo_json_array
Next

return luo_json_array
end function

public function uo_json_object of_get_object (long al_index);return iuo_object[al_index]
end function

public function uo_json_object of_find_object_by_keyvalue (string as_key, string as_value);long ll_cnt
uo_json_object luo_json_object

//start with drill down to child objects
for ll_cnt = 1 to this.of_has_objects( )
	luo_json_object = iuo_object[ll_cnt].of_find_object_by_keyvalue(as_key, as_value)
	if isvalid(luo_json_object) then return luo_json_object
	
Next

return luo_json_object
end function

public function uo_json_object of_append_object ();long ll_cnt

ll_cnt = Upperbound(iuo_object) + 1

iuo_object[ll_cnt] = create uo_json_object
//iuo_object[ll_cnt].of_set_key(as_key)

return iuo_object[ll_cnt]
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

//return Replace(as_value, pos(as_value,"~""), len(as_value)-pos(as_value,"~""),"\~"")

end function

public function integer of_append_string (string as_value, string as_delimiter);//First replace all " in orignal values
this.is_parsed_value = replace_all( as_value, '"','\"')

//Make Json Array Values
this.is_parsed_value ='"'+ replace_all( this.is_parsed_value, as_delimiter,'","') + '"'

return 0
end function

on uo_json_array.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_json_array.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

