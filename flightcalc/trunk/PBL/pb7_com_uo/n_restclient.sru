HA$PBExportHeader$n_restclient.sru
$PBExportComments$REST client
forward
global type n_restclient from nonvisualobject
end type
end forward

global type n_restclient from nonvisualobject autoinstantiate
end type

type variables
PUBLIC:

// common HTTP methods
constant string METHOD_GET = "GET"
constant string METHOD_POST = "POST"
constant string METHOD_PUT = "PUT"
constant string METHOD_PATCH = "PATCH"
constant string METHOD_DELETE = "DELETE"

// common HTTP status codes
constant integer STATUS_OK = 200
constant integer STATUS_CREATED = 201
constant integer STATUS_ACCEPTED = 202
constant integer STATUS_BAD_REQUEST = 400
constant integer STATUS_UNAUTHORIZED = 401
constant integer STATUS_FORBIDDEN = 403
constant integer STATUS_NOT_FOUND = 404
constant integer STATUS_METHOD_NOT_ALLOWED = 405
constant integer STATUS_NOT_ACCEPTABLE = 406
constant integer STATUS_INTERNAL_SERVER_ERROR = 500
constant integer STATUS_NOT_IMPLEMENTED = 501
constant integer STATUS_BAD_GATEWAY = 502
constant integer STATUS_SERVICE_UNABAILABLE = 503


PRIVATE:

HTTPClient invo_httpClient
JSONParser invo_jsonParser

string is_host
string is_lastError
string is_parameters
string is_csrfToken
string is_AccessToken
string is_RefreshToken
string is_sessionCookie
end variables

forward prototypes
public subroutine of_init (string as_host)
public function string of_getlasterror ()
public subroutine of_resetparameters ()
public subroutine of_addparameter (string as_key, string as_value)
public function string of_getlastresponsebody ()
private function integer of_retrieve (string as_endpoint, ref datawindow adw_target, ref datastore ads_target)
private function integer of_invoke (string as_method, string as_endpoint, string as_data, blob ablb_data)
public function integer of_invoke (string as_method, string as_endpoint)
public function integer of_invoke (string as_method, string as_endpoint, blob ablb_data)
public function integer of_invoke (string as_method, string as_endpoint, string as_data)
public function integer of_retrieve (string as_endpoint, ref datawindow adw_target)
public function integer of_retrieve (string as_endpoint, ref datastore ads_target)
private function integer of_update (string as_endpoint, ref datawindow adw_target, datastore ads_target)
public function integer of_update (string as_endpoint, datastore ads_target)
public function integer of_update (string as_endpoint, ref datawindow adw_target)
end prototypes

public subroutine of_init (string as_host);/*
* Function: of_init
* Author: Dirk Bunk
* Date: 06.06.2019
*
* Description: Initializes the REST client
*
* Argument(s):
* 	as_host	The host part of the webservice URL
*
* Revision History:
*   Version	Who			When			What/Why
*   1.0		Dirk Bunk		06.06.2019	Creation
*
* Return: 
* 	(None)
*/

is_host = as_host

// --------------------------------------------------------------------------------------------------------------------
// 14.10.2024 HR: if a new Run all old Object should be recreated
// --------------------------------------------------------------------------------------------------------------------
if isvalid(invo_httpClient) then
	destroy invo_httpClient
	invo_httpClient = create HTTPClient
end if

if isvalid(invo_jsonParser) then
	destroy invo_jsonParser
	invo_jsonParser = create JSONParser
end if

end subroutine

public function string of_getlasterror ();/*
* Function: of_getLastError
* Author: Dirk Bunk
* Date: 06.06.2019
*
* Description: Returns the last error message
*
* Argument(s):
* 	(None)
*
* Revision History:
*   Version	Who			When			What/Why
*   1.0		Dirk Bunk		06.06.2019	Creation
*
* Return: 
* 	The last error message
*/

return is_lastError
end function

public subroutine of_resetparameters ();/*
* Function: of_resetParameters
* Author: Dirk Bunk
* Date: 06.06.2019
*
* Description: Resets the list of URL parameters
*
* Argument(s):
* 	(None)
*
* Revision History:
*   Version	Who			When			What/Why
*   1.0		Dirk Bunk		06.06.2019	Creation
*
* Return: 
* 	(None)
*/

is_parameters = ""
end subroutine

public subroutine of_addparameter (string as_key, string as_value);/*
* Function: of_addParameter
* Author: Dirk Bunk
* Date: 06.06.2019
*
* Description: Adds a new URL parameter to the current list of parameters
*
* Argument(s):
* 	as_key	The name of the parameter to set
*	as_value	The value of the parameter
*
* Revision History:
*   Version	Who			When			What/Why
*   1.0		Dirk Bunk		06.06.2019	Creation
*
* Return: 
*   (None)
*/

if Len(is_parameters) > 0 then is_parameters += "&"
is_parameters += as_key + "=" + as_value
end subroutine

public function string of_getlastresponsebody ();/*
* Function: of_getLastResponseBody
* Author: Dirk Bunk
* Date: 06.06.2019
*
* Description: Returns the last response body
*
* Argument(s):
* 	(None)
*
* Revision History:
*   Version	Who			When			What/Why
*   1.0		Dirk Bunk		06.06.2019	Creation
*
* Return: 
* 	The last response body
*/

integer li_rc
string ls_response

li_rc = invo_httpClient.GetResponseBody(ls_response)
if li_rc <> 1 then
	is_lastError = "GetResponseBody failed: " + String(li_rc)
end if

return ls_response
end function

private function integer of_retrieve (string as_endpoint, ref datawindow adw_target, ref datastore ads_target);/*
* Function: of_retrieve
* Author: Dirk Bunk
* Date: 06.06.2019
*
* Description: Invokes a REST endpoint using the HTTP GET method and imports the result in a DataWindow/DataStore
*
* Argument(s):
*	as_endpoint	The endpoint to be called
* 	adw_target	The target DataWindow to import the data
*	ads_target	The target DataStore to import the data
*
* Note:
*	Only one target argument will be used.
*
* Revision History:
*   Version	Who			When			What/Why
*   1.0		Dirk Bunk		06.06.2019	Creation
*
* Return: 
* 	0	OK
* -1	Error
*/

integer li_return
long ll_row
string ls_jsonResponse

// set defaults
li_return = 0

// reset target dw/ds
if li_return = 0 then
	if IsValid(adw_target) then adw_target.Reset()
	if IsValid(ads_target) then ads_target.Reset()
end if

// handle the json response
if li_return = 0 then li_return = of_invoke(METHOD_GET, as_endpoint)

// parse the string response as json
if li_return = 0 then
	ls_jsonResponse = of_getLastResponseBody()	
	
	// import to DW
	if IsValid(adw_target) then 
		adw_target.ImportJsonByKey(ls_jsonResponse)
				
		// reset status for all rows to not modified
		adw_target.ResetUpdate()
	end if
	
	// import to DS
	if IsValid(ads_target) then 
		ads_target.ImportJsonByKey(ls_jsonResponse)
		
		// reset status for all rows to not modified
		ads_target.ResetUpdate()
	end if
end if

return li_return
end function

private function integer of_invoke (string as_method, string as_endpoint, string as_data, blob ablb_data);/*
* Function: of_invoke
* Author: Dirk Bunk
* Date: 06.06.2019
*
* Description: Invokes a REST endpoint using a certain HTTP method and data
*
* Argument(s):
* 	as_method	The HTTP method to use (GET, POST, PUT, PATCH, DELETE)
*	as_endpoint	The endpoint to be called
*	as_data		The data to be send as JSON string
*	ablb_data	The data to be send as blob
*
* Note:
*	Only one data argument will be used. The JSON string is prefered.
*
* Revision History:
*   Version	Who			When			What/Why
*   1.0		Dirk Bunk		06.06.2019	Creation
*
* Return: 
* 	0	OK
* -1	Error
*/

long ll_httpStatus, ll_jsonObjectHandle
integer li_return, li_rc, li_ret
string ls_url

// set defaults
li_return = 0

// create url and send the request
ls_url = is_host + as_endpoint
if (Len(is_parameters) > 0) then ls_url += "?" + is_parameters

// set headers to disable caching
invo_httpClient.SetRequestHeader("Cache-Control", "no-cache", true)
invo_httpClient.SetRequestHeader("Pragma", "no-cache", true)
invo_httpClient.SetRequestHeader("Expires", "Sat, 01 Jan 2000 00:00:00 GMT", true)

// set headers for content type
if (Len(as_data) > 0) then
	invo_httpClient.SetRequestHeader("Content-Type", "application/json", true)
elseif (Len(ablb_data) > 0) then
	invo_httpClient.SetRequestHeader("Content-Type", "multipart/form-data", true)
else
	invo_httpClient.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded", true)
end if

// send the request
//MessageBox("Authorization", invo_httpClient.GetRequestHeader("Authorization"))
li_rc = invo_httpClient.SendRequest(as_method, ls_url, as_data)
ll_httpStatus = invo_httpClient.GetResponseStatusCode()

// reset the parameters
of_resetParameters()

// check the request and http status
if li_rc <> 1 or ll_httpStatus <>  STATUS_OK then
	is_lastError = "SendRequest failed: " + String(li_rc) + " HTTP status: " + String(ll_httpStatus)
	li_return = -1
end if

// check for session cookie
if li_return = 0 then
	is_sessionCookie = invo_httpClient.GetResponseHeader("Set-Cookie")
	if Len(is_sessionCookie) > 0 then invo_httpClient.SetRequestHeader("Cookie", invo_httpClient.GetResponseHeader("Set-Cookie"), true)
end if

// check new CSRF token
if li_return = 0 then
	invo_jsonParser.LoadString(of_getLastResponsebody())
	ll_jsonObjectHandle = invo_jsonParser.GetRootItem()
	
	// --------------------------------------------------------------------------------------------------------------------
	// 14.10.2024 HR: V1 and V2 Logic should be possible (PB19 has Problems with v2 Logic)
	// --------------------------------------------------------------------------------------------------------------------
	if pos(is_host, "/v2/") > 0 then
		is_AccessToken = invo_jsonParser.GetItemString(ll_jsonObjectHandle, "access_token")
		is_RefreshToken = invo_jsonParser.GetItemString(ll_jsonObjectHandle, "refresh_token")
		if Len(is_AccessToken) > 0 then invo_httpClient.SetRequestHeader("Authorization", "Bearer " + is_AccessToken, true)
	else
		is_csrfToken = invo_jsonParser.GetItemString(ll_jsonObjectHandle, "X-CSRF-TOKEN")
		if Len(is_csrfToken) > 0 then li_ret = invo_httpClient.SetRequestHeader("X-CSRF-TOKEN", is_csrfToken, true)
	end if
end if

return li_return
end function

public function integer of_invoke (string as_method, string as_endpoint);return of_invoke(as_method, as_endpoint, "")
end function

public function integer of_invoke (string as_method, string as_endpoint, blob ablb_data);return of_invoke(as_method, as_endpoint, "", ablb_data)
end function

public function integer of_invoke (string as_method, string as_endpoint, string as_data);return of_invoke(as_method, as_endpoint, as_data, Blob(""))
end function

public function integer of_retrieve (string as_endpoint, ref datawindow adw_target);datastore lds_null
return of_retrieve(as_endpoint, adw_target, lds_null)
end function

public function integer of_retrieve (string as_endpoint, ref datastore ads_target);datawindow ldw_null
return of_retrieve(as_endpoint, ldw_null, ads_target)
end function

private function integer of_update (string as_endpoint, ref datawindow adw_target, datastore ads_target);integer li_return
string ls_updated, ls_inserted, ls_deleted
long ll_row, ll_rowMod

// set defaults
li_return = 0
ls_updated = ""
ls_inserted = ""
ls_deleted = ""

// If rows are deleted in DataWindow, the information about what has been deleted is stored in the Delete! buffer.
// But this only works if the DataWindow is updateable (which requires a database connection).
// This might be a problem, if we want to remove database dependencies.

if (IsValid(adw_target)) then
	for ll_row = 1 to adw_target.ModifiedCount()
		ll_rowMod = adw_target.GetNextModified(ll_row - 1, Primary!)
		choose case adw_target.GetItemStatus(ll_rowMod, 0, Primary!)
			case DataModified!
				if (Len(ls_updated) > 0) then ls_updated += ","
				ls_updated += adw_target.ExportRowAsJson(ll_rowMod)
			case New!, NewModified!
				if (Len(ls_inserted) > 0) then ls_inserted += ","
				ls_inserted += adw_target.ExportRowAsJson(ll_rowMod)
		end choose
	next
	
	ls_deleted = adw_target.ExportJson(Delete!, true, false)
elseif (IsValid(ads_target)) then
		for ll_row = 1 to ads_target.ModifiedCount()
		ll_rowMod = ads_target.GetNextModified(ll_row - 1, Primary!)
		choose case ads_target.GetItemStatus(ll_rowMod, 0, Primary!)
			case DataModified!
				if (Len(ls_updated) > 0) then ls_updated += ","
				ls_updated += ads_target.ExportRowAsJson(ll_rowMod)
			case New!, NewModified!
				if (Len(ls_inserted) > 0) then ls_inserted += ","
				ls_inserted += ads_target.ExportRowAsJson(ll_rowMod)
		end choose
	next
	
	ls_deleted = ads_target.ExportJson(Delete!, true, false)
end if

// TODO: Open question: how to actually update data? POST, PUT, DELETE as seperate endpoints or combined in POST?
if (Len(ls_updated) > 0) then of_invoke(METHOD_POST, as_endpoint, "[" + ls_updated + "]")
if (Len(ls_inserted) > 0) then of_invoke(METHOD_PUT, as_endpoint, "[" + ls_inserted + "]")
if (Len(ls_deleted) > 0) then of_invoke(METHOD_DELETE, as_endpoint, ls_deleted)

return li_return
end function

public function integer of_update (string as_endpoint, datastore ads_target);datawindow ldw_null
return of_update(as_endpoint, ldw_null, ads_target)
end function

public function integer of_update (string as_endpoint, ref datawindow adw_target);datastore lds_null
return of_update(as_endpoint, adw_target, lds_null)
end function

on n_restclient.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_restclient.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;invo_httpClient = create HTTPClient
invo_jsonParser = create JSONParser

is_host = ""
is_lastError = ""
is_parameters = ""
is_csrfToken = ""
is_sessionCookie = ""
end event

event destructor;destroy invo_httpClient
destroy invo_jsonParser
end event

