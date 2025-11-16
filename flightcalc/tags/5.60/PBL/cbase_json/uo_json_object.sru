HA$PBExportHeader$uo_json_object.sru
forward
global type uo_json_object from nonvisualobject
end type
end forward

global type uo_json_object from nonvisualobject
end type
global uo_json_object uo_json_object

type prototypes
global function boolean append (ref blob ab_source, readonly string as_append, ...) system library "fastfuncs125.dll" alias for "Append"
global function boolean append (ref string as_source, readonly string as_append, ...) system library "fastfuncs125.dll" alias for "Append"
end prototypes

type variables
Private:
string is_key

uo_json_keyvalue iuo_keyvalue[]

//or another object ...
uo_json_object iuo_object[]

//or another/an array
uo_json_array	iuo_array[]

end variables

forward prototypes
public function long of_has_keyvalues ()
public function long of_has_objects ()
public function long of_has_arrays ()
public function integer of_set_key (string as_key)
public function uo_json_object of_append_object (string as_key)
public function uo_json_keyvalue of_get_keyvalue (long al_index)
public function string of_get_json_string ()
public function string of_get_key ()
public function long of_append_keyvalue (string as_key, string as_value)
public function uo_json_array of_append_array (string as_key)
public function uo_json_object of_find_object_by_key (string as_key)
public function uo_json_array of_find_array_by_key (string as_key)
public function uo_json_object of_find_object_by_keyvalue (string as_key, string as_value)
end prototypes

public function long of_has_keyvalues ();return Upperbound(iuo_keyvalue)
end function

public function long of_has_objects ();return Upperbound(iuo_object)
end function

public function long of_has_arrays ();return Upperbound(iuo_array)
end function

public function integer of_set_key (string as_key);this.is_key = as_key

return 0
end function

public function uo_json_object of_append_object (string as_key);long ll_cnt

//search if find existing key value
for ll_cnt = 1 to Upperbound(iuo_object)
	if iuo_object[ll_cnt].of_get_key() = as_key then
		iuo_object[ll_cnt].of_set_key(as_key)
		return iuo_object[ll_cnt]
	end if
Next

ll_cnt = Upperbound(iuo_object) + 1

iuo_object[ll_cnt] = create uo_json_object
iuo_object[ll_cnt].of_set_key(as_key)

return iuo_object[ll_cnt]
end function

public function uo_json_keyvalue of_get_keyvalue (long al_index);return iuo_keyvalue[al_index]
end function

public function string of_get_json_string ();string ls_result
long ll_cnt

ls_result = '{'

//Exception Handling when fastfunc.dll not exists
/*
try
	
	for ll_cnt = 1 to this.of_has_keyvalues( ) 

		append(ls_result, '"'+this.of_get_keyvalue(ll_cnt).of_get_key()+'"')
		append(ls_result, ':')
		append(ls_result, '"'+this.of_get_keyvalue(ll_cnt).of_get_value()+'"')
		
		if not ll_cnt = this.of_has_keyvalues( ) then
			append(ls_result, ',')
		end if
	Next
	
	//wenn vorher key/values eingetragen sind erst mit komma bevor objekte folgen
	if this.of_has_keyvalues( ) > 0 and this.of_has_objects( ) > 0 then append(ls_result, ',')
		
	for ll_cnt = 1 to this.of_has_objects( )
		
		append(ls_result, '"'+this.iuo_object[ll_cnt].of_get_key()+'"')
		append(ls_result,  ':')
		append(ls_result, this.iuo_object[ll_cnt].of_get_json_string())
		
		if not ll_cnt = this.of_has_objects( ) then
			append(ls_result, ',')
		end if
	Next
	
	//wenn vorher key/values oder objects eingetragen sind erst mit komma bevor arrays folgen
	if (this.of_has_objects( ) > 0 or this.of_has_keyvalues( ) > 0 ) and this.of_has_arrays( ) > 0 then append(ls_result, ',') 
		
	for ll_cnt = 1 to this.of_has_arrays( )

		append(ls_result, '"'+this.iuo_array[ll_cnt].of_get_key()+'"')
		append(ls_result, ':')
		append(ls_result, this.iuo_array[ll_cnt].of_get_json_string())
		
		if not ll_cnt = this.of_has_arrays( ) then
			append(ls_result, ',')
		end if
	Next
	
	append(ls_result, '}')

catch(Runtimeerror e)
*/	
	for ll_cnt = 1 to this.of_has_keyvalues( ) 
		
		ls_result += '"'+this.of_get_keyvalue(ll_cnt).of_get_key()+'"'
		ls_result += ':'
		ls_result += '"'+this.of_get_keyvalue(ll_cnt).of_get_value()+'"'
		
		if not ll_cnt = this.of_has_keyvalues( ) then
			ls_result += ','
		end if
	Next
	
	//wenn vorher key/values eingetragen sind erst mit komma bevor objekte folgen
	if this.of_has_keyvalues( ) > 0 and this.of_has_objects( ) > 0 then ls_result += ','
		
	for ll_cnt = 1 to this.of_has_objects( )
		
		ls_result += '"'+this.iuo_object[ll_cnt].of_get_key()+'"'
		ls_result += ':'
		ls_result += this.iuo_object[ll_cnt].of_get_json_string()
	
		if not ll_cnt = this.of_has_objects( ) then
			ls_result += ','
		end if
	Next
	
	//wenn vorher key/values oder objects eingetragen sind erst mit komma bevor arrays folgen
	if (this.of_has_objects( ) > 0 or this.of_has_keyvalues( ) > 0 ) and this.of_has_arrays( ) > 0 then ls_result += ','
		
	for ll_cnt = 1 to this.of_has_arrays( )
		
		ls_result += '"'+this.iuo_array[ll_cnt].of_get_key()+'"'
		ls_result += ':'
		ls_result += this.iuo_array[ll_cnt].of_get_json_string()
		
		if not ll_cnt = this.of_has_arrays( ) then
			ls_result += ','
		end if
	Next
	
	ls_result += '}'

//end try

return ls_result
end function

public function string of_get_key ();return this.is_key
end function

public function long of_append_keyvalue (string as_key, string as_value);long ll_cnt

//search if find existing key value
for ll_cnt = 1 to Upperbound(iuo_keyvalue)
	if iuo_keyvalue[ll_cnt].of_get_key() = as_key then
		iuo_keyvalue[ll_cnt].of_set_value(as_value)
		return 1
	end if
Next

ll_cnt = Upperbound(iuo_keyvalue) + 1
iuo_keyvalue[ll_cnt] = create uo_json_keyvalue
iuo_keyvalue[ll_cnt].of_append(as_key, as_value)

return 0
end function

public function uo_json_array of_append_array (string as_key);long ll_cnt

//search if find existing key value
for ll_cnt = 1 to Upperbound(iuo_array)
	if iuo_array[ll_cnt].of_get_key() = as_key then
		iuo_array[ll_cnt].of_set_key(as_key)
		return iuo_array[ll_cnt]
	end if
Next

ll_cnt = Upperbound(iuo_array) + 1

iuo_array[ll_cnt] = create uo_json_array
iuo_array[ll_cnt].of_set_key(as_key)

return iuo_array[ll_cnt]
end function

public function uo_json_object of_find_object_by_key (string as_key);long ll_cnt
uo_json_object luo_json_object

//start with this key
if this.of_get_key() = as_key then luo_json_object = this

//proceed with this object keyvalue pairs
for ll_cnt = 1 to this.of_has_keyvalues( ) 
	if this.of_get_keyvalue(ll_cnt).of_get_key() = as_key then return this
Next

//proceed with drill down to child objects
for ll_cnt = 1 to this.of_has_objects( )
	luo_json_object = iuo_object[ll_cnt].of_find_object_by_key(as_key)
	if isValid(luo_json_object) then return luo_json_object
	
Next

//proceed with drill down to child arrays
for ll_cnt = 1 to this.of_has_arrays( )
	luo_json_object = iuo_array[ll_cnt].of_find_object_by_key(as_key)
	if isValid(luo_json_object) then return luo_json_object
Next

return luo_json_object
end function

public function uo_json_array of_find_array_by_key (string as_key);long ll_cnt
uo_json_array luo_json_array

//proceed with drill down to child arrays
for ll_cnt = 1 to this.of_has_arrays( )
	luo_json_array = iuo_array[ll_cnt].of_find_array_by_key(as_key) 
	if isValid(luo_json_array) then return luo_json_array
Next

//proceed with drill down to child objects
for ll_cnt = 1 to this.of_has_objects( )
	luo_json_array = iuo_object[ll_cnt].of_find_array_by_key(as_key)
	if isValid(luo_json_array) then return luo_json_array
Next

return luo_json_array
end function

public function uo_json_object of_find_object_by_keyvalue (string as_key, string as_value);long ll_cnt
uo_json_object luo_json_object

//start with this object keyvalue pairs
for ll_cnt = 1 to this.of_has_keyvalues( ) 
	if this.of_get_keyvalue(ll_cnt).of_get_key() = as_key and this.of_get_keyvalue(ll_cnt).of_get_value() = as_value then return this
Next

//proceed with drill down to child objects
for ll_cnt = 1 to this.of_has_objects( )
	luo_json_object = iuo_object[ll_cnt].of_find_object_by_keyvalue(as_key, as_value)
	if isValid(luo_json_object) then return luo_json_object
	
Next

//proceed with drill down to child arrays
for ll_cnt = 1 to this.of_has_arrays( )
	luo_json_object = iuo_array[ll_cnt].of_find_object_by_keyvalue(as_key, as_value)
	if isValid(luo_json_object) then return luo_json_object
Next

return luo_json_object
end function

on uo_json_object.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_json_object.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

