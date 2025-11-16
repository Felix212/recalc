HA$PBExportHeader$n_graylog_client.sru
$PBExportComments$Graylog client to send messages to Graylog using an external REST endpoint.
forward
global type n_graylog_client from nonvisualobject
end type
type additionallogproperty from structure within n_graylog_client
end type
end forward

type additionallogproperty from structure
	string		name
	string		value
end type

global type n_graylog_client from nonvisualobject
end type
global n_graylog_client n_graylog_client

type variables
/*

#################################################################################
PUBLIC VARIABLE:
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
n_graylog_client 	gnvo_GrayLogClient
boolean				gb_GrayLogEnabled = false

#################################################################################
//redirect all logging functions (with messages to send to graylog) to 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
f_write_log2csv( arg_file, ljob, iinfotype, smessage)

#################################################################################

*/
PUBLIC:
CONSTANT UInt LOG_LEVEL_EMERGENCY = 0
CONSTANT UInt LOG_LEVEL_ALERT = 1
CONSTANT UInt LOG_LEVEL_CRITICAL = 2
CONSTANT UInt LOG_LEVEL_ERROR = 3
CONSTANT UInt LOG_LEVEL_WARNING = 4
CONSTANT UInt LOG_LEVEL_NOTICE = 5
CONSTANT UInt LOG_LEVEL_INFO = 6
CONSTANT UInt LOG_LEVEL_DEBUG = 7

PRIVATE:
RestClient invo_RestClient
JSONGenerator invo_JsonGenerator
String is_LogEndpoint, is_BackupPath
AdditionalLogProperty istr_additionalLogProperties[]

CONSTANT String GRAYLOG_CLIENT_OBJECT_NAME = "n_graylog_client"
CONSTANT String GRAYLOG_CLIENT_THREAD_NAME = "GrayLogClientThread"

CONSTANT String CBASE_TEMP_PATH = "C:\Temp\CBASE\" // used only if every other path fails

CONSTANT String PROPERTY_APPNAME = "application"
CONSTANT String PROPERTY_VERSION = "version"
CONSTANT String PROPERTY_HOSTNAME = "hostname"
CONSTANT String PROPERTY_USERNAME = "username"
CONSTANT String PROPERTY_MESSAGE = "message"
CONSTANT String PROPERTY_LEVEL = "level"
CONSTANT String PROPERTY_ADDITIONAL_PROPERTY_LIST = "additionalLogPropertyList"
CONSTANT String PROPERTY_SYSTEM_ERROR_LINE = "systemErrorLine"
CONSTANT String PROPERTY_SYSTEM_ERROR_NUMBER = "systemErrorNumber"
CONSTANT String PROPERTY_SYSTEM_ERROR_OBJECT = "systemErrorObject"
CONSTANT String PROPERTY_SYSTEM_ERROR_OBJECT_EVENT = "systemErrorObjectEvent"
CONSTANT String PROPERTY_SYSTEM_ERROR_TEXT = "systemErrorText"
CONSTANT String PROPERTY_SYSTEM_ERROR_WINDOW_MENU = "systemErrorWindowMenu"
end variables

forward prototypes
public subroutine of_init (string as_logendpoint, string as_appname, string as_appversion, string as_hostname, string as_username, string as_backuppath)
public subroutine of_send (string as_message)
public subroutine of_send (string as_message, unsignedinteger aui_loglevel)
public subroutine of_init (string as_logendpoint, string as_appname, string as_appversion, string as_backuppath)
public subroutine of_sendsystemerror ()
private subroutine of_send (string as_message, unsignedinteger aui_loglevel, boolean ab_loglastsystemerror)
public subroutine of_setadditionalproperty (string as_name, string as_value)
private subroutine of_backuplog (string as_backuppath, string as_logentry, string as_additionalinfo)
private subroutine of_addproperty (long al_jsonarrayhandle, string as_name, string as_value)
private subroutine of_endthread (string as_threadname)
private subroutine of_postrequestasync (string as_threadname, string as_endpoint, string as_postdata, string as_backuppath)
private function string of_startthread (ref powerobject rnvo_thread, string as_classname, string as_threadnamebase, integer ai_maxthreads)
end prototypes

public subroutine of_init (string as_logendpoint, string as_appname, string as_appversion, string as_hostname, string as_username, string as_backuppath);/*
* Object:	n_graylog_client
* Function:	of_Init
* Author:	Dirk Bunk
* Date:		08.06.2020
*
* Argument(s):
* 	as_LogEndpoint		The endpoint to use to log the Graylog message
*	as_AppName		The name of the app
*	as_AppVersion		The version of the app
*	as_HostName		The hostname
*	as_UserName		The username
*	as_BackupPath		The path used to save the logs to if the endpoint fails
*
* Description: Initializes the Graylog Client.
*
* History:
*   Version	Who			When			What and why
*   1.0		Dirk Bunk		08.06.2020	Creation
*
* Return: 
*   none
*/

is_LogEndpoint = as_LogEndpoint
is_BackupPath = as_BackupPath

of_SetAdditionalProperty(PROPERTY_APPNAME, as_AppName)
of_SetAdditionalProperty(PROPERTY_VERSION, as_AppVersion)
of_SetAdditionalProperty(PROPERTY_HOSTNAME, as_HostName)
of_SetAdditionalProperty(PROPERTY_USERNAME, as_UserName)
end subroutine

public subroutine of_send (string as_message);of_send(as_Message, LOG_LEVEL_INFO, False)
end subroutine

public subroutine of_send (string as_message, unsignedinteger aui_loglevel);of_send(as_Message, aui_LogLevel, False)
end subroutine

public subroutine of_init (string as_logendpoint, string as_appname, string as_appversion, string as_backuppath);string ls_HostName, ls_UserName

// Get the Hostname and the Username from the Registry.
RegistryGet("HKEY_LOCAL_MACHINE\SYSTEM\CURRENTCONTROLSET\CONTROL\COMPUTERNAME\COMPUTERNAME", "COMPUTERNAME", ls_HostName)
RegistryGet("HKEY_CURRENT_USER\VOLATILE ENVIRONMENT", "USERNAME", ls_UserName)

of_init(as_LogEndPoint, as_AppName, as_AppVersion, ls_HostName, ls_UserName, as_BackupPath)
end subroutine

public subroutine of_sendsystemerror ();of_send("System Error occured!", LOG_LEVEL_CRITICAL, True)
end subroutine

private subroutine of_send (string as_message, unsignedinteger aui_loglevel, boolean ab_loglastsystemerror);/*
* Object:	n_graylog_client
* Function:	of_Send
* Author:	Dirk Bunk
* Date:		08.06.2020
*
* Argument(s):
* 	as_Message					The message to be sent to Graylog
*	aui_LogLevel				Sets the LogLevel (see LOG_LEVEL constants)
*	ab_LogLastSystemError	Set to True to log the last available PowerBuilder SystemError
*
* Description: Creates a JSON object and posts it to Graylog using a webservice.
*
* History:
*   Version	Who			When			What and why
*   1.0		Dirk Bunk		08.06.2020	Creation
*
* Return: 
*   none
*/

n_graylog_client lnvo_GrayLogClientThread
String ls_PostData, ls_ResponseBody, ls_ThreadName
Long ll_ResponseStatusCode, ll_JsonRootHandle, ll_JsonChildHandle, ll_JsonArrayHandle
Integer i, li_SendReturn
AdditionalLogProperty lstr_AdditionalLogProperty

// Create a new JSON root object and append all needed properties to create the Graylog message.
ll_JsonRootHandle = invo_JsonGenerator.CreateJsonObject()
invo_JsonGenerator.AddItemString(ll_JsonRootHandle, PROPERTY_MESSAGE, as_Message)
invo_JsonGenerator.AddItemNumber(ll_JsonRootHandle, PROPERTY_LEVEL, aui_LogLevel)

// Set some additional properties
ll_JsonArrayHandle = invo_JsonGenerator.AddItemArray(ll_JsonRootHandle, PROPERTY_ADDITIONAL_PROPERTY_LIST)

If UpperBound(istr_additionalLogProperties) > 0 Then
	For i = 1 To UpperBound(istr_AdditionalLogProperties)
		lstr_AdditionalLogProperty = istr_AdditionalLogProperties[i]
		of_AddProperty(ll_JsonArrayHandle, lstr_AdditionalLogProperty.name, lstr_AdditionalLogProperty.value)
	Next
End If

// Set an additional property if the last system error should be logged.
If ab_LogLastSystemError And Error.Number > 0 Then
	of_AddProperty(ll_JsonArrayHandle, PROPERTY_SYSTEM_ERROR_LINE, String(Error.Line))
	of_AddProperty(ll_JsonArrayHandle, PROPERTY_SYSTEM_ERROR_NUMBER, String(Error.Number))
	of_AddProperty(ll_JsonArrayHandle, PROPERTY_SYSTEM_ERROR_OBJECT, Error.Object)
	of_AddProperty(ll_JsonArrayHandle, PROPERTY_SYSTEM_ERROR_OBJECT_EVENT, error.ObjectEvent)
	of_AddProperty(ll_JsonArrayHandle, PROPERTY_SYSTEM_ERROR_TEXT, Error.Text)
	of_AddProperty(ll_JsonArrayHandle, PROPERTY_SYSTEM_ERROR_WINDOW_MENU, Error.WindowMenu)
End If

// Start a new thread and post the request to log the message. Once the request is done the thread will be ended. The EndThread function has to be called inside the PostRequestAsync function.
ls_ThreadName = of_StartThread(lnvo_GrayLogClientThread, GRAYLOG_CLIENT_OBJECT_NAME, GRAYLOG_CLIENT_THREAD_NAME, 10)
lnvo_GrayLogClientThread.POST of_PostRequestAsync(ls_ThreadName, is_LogEndpoint, invo_JsonGenerator.GetJsonString(), is_BackupPath)
end subroutine

public subroutine of_setadditionalproperty (string as_name, string as_value);/*
* Object:	n_graylog_client
* Function:	of_SetAdditionalProperty()
* Author:	Dirk Bunk
* Date:		08.06.2020
*
* Argument(s):
* 	as_Name		The name of the property
*	as_Value		The value of the property
*
* Description: Creates a or updates a JSON object with a given name in a list of additional properties
*
* Note: These properties will be send with each message!
*
* History:
*   Version	Who			When			What and why
*   1.0		Dirk Bunk		16.06.2020	Creation
*
* Return: 
*   none
*/

Integer i
Boolean lb_Found = False
AdditionalLogProperty lstr_AdditionalLogProperty

// Update the existing JSON object in the list of additional properties
If UpperBound(istr_additionalLogProperties) > 0 Then
	For i = 1 to UpperBound(istr_additionalLogProperties)
		lstr_AdditionalLogProperty = istr_additionalLogProperties[i]
		If lstr_AdditionalLogProperty.name = as_Name Then 
			lstr_AdditionalLogProperty.value = as_Value
			lb_Found = True
		End If
	Next
End If

// If the object was not found create a new JSON object and add it to the list of additional properties
If Not lb_Found Then 
	lstr_AdditionalLogProperty.name = as_Name
	lstr_AdditionalLogProperty.value = as_Value
	istr_additionalLogProperties[UpperBound(istr_additionalLogProperties) + 1] = lstr_AdditionalLogProperty
end if
end subroutine

private subroutine of_backuplog (string as_backuppath, string as_logentry, string as_additionalinfo);Integer li_TraceFile
Long ll_RootHandle
String ls_FileName, ls_Return, ls_LogText, ls_AppName, ls_AppVersion, ls_HostName, ls_UserName, ls_Prefix, ls_LineFeed

JSONParser lnvo_JsonParser
lnvo_JsonParser = Create JSONParser

ls_LineFeed = Char(13) + Char(10)

// Try parsing the JSON file that failed to be sent to Graylog
ls_Return = lnvo_JsonParser.LoadString(as_LogEntry)
If Trim(ls_Return) <> "" Then
	ls_LogText = "Failed to parse log entry: " + ls_Return + ls_LineFeed + as_LogEntry
	ls_HostName = "unkownHost"
	ls_UserName = "unkownUser"
	
	ls_FileName = "graylog_error_" + String(Today(), "yyyy-mm-dd") + ".txt"
Else
	ll_RootHandle = lnvo_JsonParser.GetRootItem()

	If lnvo_JsonParser.ContainsKey(ll_RootHandle, PROPERTY_MESSAGE) Then ls_LogText = lnvo_JsonParser.GetItemString(ll_RootHandle, PROPERTY_MESSAGE)
	If lnvo_JsonParser.ContainsKey(ll_RootHandle, PROPERTY_APPNAME) Then ls_AppName = lnvo_JsonParser.GetItemString(ll_RootHandle, PROPERTY_APPNAME)
	If lnvo_JsonParser.ContainsKey(ll_RootHandle, PROPERTY_VERSION) Then ls_AppVersion = lnvo_JsonParser.GetItemString(ll_RootHandle, PROPERTY_VERSION)
	If lnvo_JsonParser.ContainsKey(ll_RootHandle, PROPERTY_HOSTNAME) Then ls_HostName = lnvo_JsonParser.GetItemString(ll_RootHandle, PROPERTY_HOSTNAME)
	If lnvo_JsonParser.ContainsKey(ll_RootHandle, PROPERTY_USERNAME) Then ls_UserName = lnvo_JsonParser.GetItemString(ll_RootHandle, PROPERTY_USERNAME)
		
	ls_FileName = "graylog_" + ls_AppName + "_" + ls_AppVersion + "_" + String(Today(), "yyyy-mm-dd") + ".txt"
End If 

// Write the message to a file
If Not DirectoryExists(as_BackupPath) Then as_BackupPath = CBASE_TEMP_PATH
If DirectoryExists(as_BackupPath) Then
	li_TraceFile = FileOpen(as_BackupPath + ls_FileName, LineMode!, Write!, LockWrite!, Append!)
	ls_Prefix = String(Today()) + "|" + String(Now()) + " [" + ls_HostName + "|" + ls_UserName + "]: "
	FileWriteEx(li_TraceFile, ls_Prefix + as_AdditionalInfo)
	FileWriteEx(li_TraceFile, ls_Prefix + ls_LogText)
	FileClose(li_TraceFile)
End If

Destroy lnvo_JsonParser
end subroutine

private subroutine of_addproperty (long al_jsonarrayhandle, string as_name, string as_value);Long ll_JsonChildHandle

ll_JsonChildHandle = invo_JsonGenerator.AddItemObject(al_JsonArrayHandle)
invo_JsonGenerator.AddItemString(ll_JsonChildHandle, "name", as_Name)
invo_JsonGenerator.AddItemString(ll_JsonChildHandle, "value", as_Value)
end subroutine

private subroutine of_endthread (string as_threadname);// Ends a thread by unregistering it from the shared object list.
// It then will be destroyed once its reference goes out of scope.
SharedObjectUnregister(as_ThreadName)
end subroutine

private subroutine of_postrequestasync (string as_threadname, string as_endpoint, string as_postdata, string as_backuppath);String ls_ResponseBody
Long ll_ResponseStatusCode
Integer li_SendReturn

// Send POST request to endpoint and wait for return codes
li_SendReturn = invo_RestClient.SendPostRequest(as_Endpoint, as_PostData, ls_ResponseBody)
ll_ResponseStatusCode = invo_RestClient.GetResponseStatusCode()

// Write a backup log on failure
If li_SendReturn <> 1 Or ll_ResponseStatusCode <> 200 Then
	of_BackupLog(as_BackupPath, as_PostData, "POST request return code: " + String(li_SendReturn) + " / response status: " + String(ll_ResponseStatusCode))
End If

// End the used thread
of_EndThread(as_ThreadName)
end subroutine

private function string of_startthread (ref powerobject rnvo_thread, string as_classname, string as_threadnamebase, integer ai_maxthreads);// Creates a new thread of a specific class.
// This can be used to call functions asynchroneously.
// The new object will be destroyed once its reference goes out of scope.
// It is important to call the EndThread function once the thread is no longer needed.

String ls_InstanceNames[], ls_ClassNames[], ls_ThreadName
Integer i, li_ThreadCount = 0

// Get all current shared objects
SharedObjectDirectory(ls_InstanceNames, ls_ClassNames)

// Find out number of open threads (of the same classname)
For i = 1 To UpperBound(ls_ClassNames)
	If ls_ClassNames[i] = as_ClassName Then li_ThreadCount++
Next

// Either create a new thread or reuse an existing one
If li_threadCount < ai_maxthreads Then
	ls_ThreadName = as_ThreadNameBase + "_" + String(li_ThreadCount + 1)
	SharedObjectRegister(as_ClassName, ls_ThreadName)
	SharedObjectGet(ls_ThreadName, rnvo_thread)
Else
	ls_ThreadName = as_ThreadNameBase + "_" + String(Rand(li_ThreadCount))
	SharedObjectGet(ls_ThreadName, rnvo_thread)
End If

// Return the name of the thread that can be used
Return ls_ThreadName
end function

event constructor;invo_RestClient = Create RestClient
invo_RestClient.SetRequestHeader("Content-Type", "application/json")

invo_JsonGenerator = Create JSONGenerator
end event

event destructor;If IsValid(invo_RestClient) Then Destroy invo_RestClient
If IsValid(invo_JsonGenerator) Then Destroy invo_JsonGenerator
end event

on n_graylog_client.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_graylog_client.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

