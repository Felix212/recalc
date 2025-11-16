HA$PBExportHeader$uo_windows_networking_functions.sru
$PBExportComments$Implementiert einige der "Windows Networking Functions". Zum Beispiel, um ein Netzlaufwerk zu verbinden oder zu trennen.
forward
global type uo_windows_networking_functions from nonvisualobject
end type
type netresource from structure within uo_windows_networking_functions
end type
end forward

type netresource from structure
	unsignedlong		dwscope
	unsignedlong		dwtype
	unsignedlong		dwdisplaytype
	unsignedlong		dwusage
	string		lplocalname
	string		lpremotename
	string		lpcomment
	string		lpprovider
end type

global type uo_windows_networking_functions from nonvisualobject
end type
global uo_windows_networking_functions uo_windows_networking_functions

type prototypes
PRIVATE: 
////////////////////////////////////////////////////////////////////////////////////////
// Windows Networking Functions                                                       //
// http://msdn.microsoft.com/en-us/library/windows/desktop/aa385391%28v=vs.85%29.aspx //
////////////////////////////////////////////////////////////////////////////////////////
function ulong WNetAddConnection2A(ref netresource lpNetResource, string lpPassword, string lpUsername, ulong dwFlags) library "mpr.dll" alias for "WNetAddConnection2A;Ansi"
function ulong WNetCancelConnection2A(string lpName, ulong dwFlags, boolean fForce) library "mpr.dll" alias for "WNetCancelConnection2A;Ansi"
function ulong WNetGetLastErrorA(ref ulong lpError, ref string lpErrorBuf, ulong nErrorBufSize, ref string lpNameBuf, ulong nNameBufSize) library "mpr.dll" alias for "WNetGetLastErrorA;Ansi"
function ulong WNetGetConnectionA(string lpLocalName, ref string lpRemoteName, ref ulong lpnLength) library "mpr.dll" alias for "WNetGetConnectionA;Ansi"
end prototypes

type variables
PRIVATE:
string isLastError = ""
ulong  ilLastError = 0

// dwFlags: A set of connection options. The possible values for the connection options are defined in the Winnetwk.h header file. The following values can currently be used.
constant ulong CONNECT_UPDATE_PROFILE =    1 // 0x00000001 The network resource connection should be remembered. If this bit flag is set, the operating system automatically attempts to restore the connection when the user logs on. The operating system remembers only successful connections that redirect local devices. It does not remember connections that are unsuccessful or deviceless connections. (A deviceless connection occurs when the lpLocalName member is NULL or points to an empty string.) If this bit flag is clear, the operating system does not try to restore the connection when the user logs on.
constant ulong CONNECT_UPDATE_RECENT  =    2 // 0x00000002 The network resource connection should not be put in the recent connection list. If this flag is set and the connection is successfully added, the network resource connection will be put in the recent connection list only if it has a redirected local device associated with it. 
constant ulong CONNECT_TEMPORARY      =    4 // 0x00000004 The network resource connection should not be remembered. If this flag is set, the operating system will not attempt to restore the connection when the user logs on again.
constant ulong CONNECT_INTERACTIVE    =    8 // 0x00000008 If this flag is set, the operating system may interact with the user for authentication purposes.
constant ulong CONNECT_PROMPT         =   16 // 0x00000010 This flag instructs the system not to use any default settings for user names or passwords without offering the user the opportunity to supply an alternative. This flag is ignored unless CONNECT_INTERACTIVE is also set.
constant ulong CONNECT_REDIRECT       =  128 // 0x00000080 This flag forces the redirection of a local device when making the connection. If the lpLocalName member of NETRESOURCE specifies a local device to redirect, this flag has no effect, because the operating system still attempts to redirect the specified device. When the operating system automatically chooses a local device, the dwType member must not be equal to RESOURCETYPE_ANY. If this flag is not set, a local device is automatically chosen for redirection only if the network requires a local device to be redirected.
constant ulong CONNECT_CURRENT_MEDIA  =  512 // 0x00000200 If this flag is set, then the operating system does not start to use a new media to try to establish the connection (initiate a new dial up connection, for example).
constant ulong CONNECT_COMMANDLINE    = 2048 // 0x00000800 If this flag is set, the operating system prompts the user for authentication using the command line instead of a graphical user interface (GUI). This flag is ignored unless CONNECT_INTERACTIVE is also set.
constant ulong CONNECT_CMD_SAVECRED   = 4096 // 0x00001000 If this flag is set, and the operating system prompts for a credential, the credential should be saved by the credential manager. If the credential manager is disabled for the caller's logon session, or if the network provider does not support saving credentials, this flag is ignored. This flag is ignored unless CONNECT_INTERACTIVE is also set. This flag is also ignored unless you set the CONNECT_COMMANDLINE flag.
constant ulong CONNECT_CRED_RESET     = 8192 // 0x00002000 If this flag is set, and the operating system prompts for a credential, the credential is reset by the credential manager. If the credential manager is disabled for the caller's logon session, or if the network provider does not support saving credentials, this flag is ignored. This flag is also ignored unless you set the CONNECT_COMMANDLINE flag.
   
	
/////////////////////////////////////////
// M$$HEX1$$f600$$ENDHEX$$gliche Konstanten f$$HEX1$$fc00$$ENDHEX$$r NetResource //
/////////////////////////////////////////

// dwScope: The scope of the enumeration. This member can be one of the following values defined in the Winnetwk.h header file. 
constant ulong RESOURCE_CONNECTED  = 1 // 0x00000001 Enumerate currently connected resources. The dwUsage member cannot be specified.
constant ulong RESOURCE_GLOBALNET  = 2 // 0x00000002 Enumerate all resources on the network. The dwUsage member is specified.
constant ulong RESOURCE_REMEMBERED = 3 // 0x00000003 Enumerate remembered (persistent) connections. The dwUsage member cannot be specified.
constant ulong RESOURCE_RECENT     = 4 // 0x00000004 Enumerate recent resources.
constant ulong RESOURCE_CONTEXT    = 5 // 0x00000005 ???

// dwType: The type of resource. This member can be one of the following values defined in the Winnetwk.h header file.
constant ulong RESOURCETYPE_ANY      = 0          // 0x00000000 All resources.
constant ulong RESOURCETYPE_DISK     = 1          // 0x00000001 Disk resources.
constant ulong RESOURCETYPE_PRINT    = 2          // 0x00000002 Print resources.
constant ulong RESOURCETYPE_RESERVED = 8          // 0x00000008 Reserved.
constant ulong RESOURCETYPE_UNKNOWN  = 4294967295 // 0xFFFFFFFF Unkown resources.

// dwDisplayType: The display options for the network object in a network browsing user interface. This member can be one of the following values defined in the Winnetwk.h header file. 
constant ulong RESOURCEDISPLAYTYPE_GENERIC      =  0 // 0x00000000 The method used to display the object does not matter.
constant ulong RESOURCEDISPLAYTYPE_DOMAIN       =  1 // 0x00000001 The object should be displayed as a domain.
constant ulong RESOURCEDISPLAYTYPE_SERVER       =  2 // 0x00000002 The object should be displayed as a server.
constant ulong RESOURCEDISPLAYTYPE_SHARE        =  3 // 0x00000003 The object should be displayed as a share.
constant ulong RESOURCEDISPLAYTYPE_FILE         =  4 // 0x00000004 The object should be displayed as a file.
constant ulong RESOURCEDISPLAYTYPE_GROUP        =  5 // 0x00000005 The object should be displayed as a group.
constant ulong RESOURCEDISPLAYTYPE_NETWORK      =  6 // 0x00000006 The object should be displayed as a network.
constant ulong RESOURCEDISPLAYTYPE_ROOT         =  7 // 0x00000007 The object should be displayed as a logical root for the entire network.
constant ulong RESOURCEDISPLAYTYPE_SHAREADMIN   =  8 // 0x00000008 The object should be displayed as a administrative share.
constant ulong RESOURCEDISPLAYTYPE_DIRECTORY    =  9 // 0x00000009 The object should be displayed as a directory.
constant ulong RESOURCEDISPLAYTYPE_TREE         = 10 // 0x0000000A The object should be displayed as a tree. This display type was used for a NetWare Directory Service (NDS) tree by the NetWare Workstation service supported on Windows XP and earlier.

// dwUsage: A set of bit flags describing how the resource can be used. Note that this member can be specified only if the dwScope member is equal to RESOURCE_GLOBALNET. This member can be one of the following values defined in the Winnetwk.h header file. 
constant ulong RESOURCEUSAGE_CONNECTABLE   =          1 // 0x00000001 The resource is a connectable resource; the name pointed to by the lpRemoteName member can be passed to the WNetAddConnection function to make a network connection.
constant ulong RESOURCEUSAGE_CONTAINER     =          2 // 0x00000002 The resource is a container resource; the name pointed to by the lpRemoteName member can be passed to the WNetOpenEnum function to enumerate the resources in the container.
constant ulong RESOURCEUSAGE_NOLOCALDEVICE =          4 // 0x00000004 The resource is not a local device.
constant ulong RESOURCEUSAGE_SIBLING       =          8 // 0x00000008 The resource is a sibling. This value is not used by Windows.
constant ulong RESOURCEUSAGE_ATTACHED      =         16 // 0x00000010 The resource must be attached. This value specifies that a function to enumerate resource this should fail if the caller is not authenticated, even if the network permits enumeration without authentication.
constant ulong RESOURCEUSAGE_ALL           =         19 // 0x00000013 (RESOURCEUSAGE_CONNECTABLE | RESOURCEUSAGE_CONTAINER | RESOURCEUSAGE_ATTACHED)
constant ulong RESOURCEUSAGE_RESERVED      = 2147483648 // 0x80000000 Reserved.
  
	
//////////////////////
// Fehlerkonstanten //
//////////////////////

constant ulong NO_ERROR                          =    0 // 0x0000 No error.
constant ulong ERROR_ACCESS_DENIED               =    5 // 0x0005 Access is denied.
constant ulong ERROR_BAD_NETPATH                 =   53 // 0x0035 The network path was not found.
constant ulong ERROR_NETWORK_BUSY                =   54 // 0x0036 The network is busy.
constant ulong ERROR_BAD_DEV_TYPE                =   66 // 0x0042 The network resource type is not correct.
constant ulong ERROR_BAD_NET_NAME                =   67 // 0x0043 The network name cannot be found.
constant ulong ERROR_ALREADY_ASSIGNED            =   85 // 0x0055 The local device name is already in use.
constant ulong ERROR_INVALID_PASSWORD            =   86 // 0x0056 The specified network password is not correct.
constant ulong ERROR_BUSY                        =  170 // 0x00AA The requested resource is in use.
constant ulong ERROR_BAD_DEVICE                  = 1200 // 0x04B0 The specified device name is invalid.
constant ulong ERROR_DEVICE_ALREADY_REMEMBERED   = 1202 // 0x04B2 The local device name has a remembered connection to another network resource.
constant ulong ERROR_NO_NET_OR_BAD_PATH          = 1203 // 0x04B3 The network path was either typed incorrectly, does not exist, or the network provider is not currently available. Please try retyping the path or contact your network administrator.
constant ulong ERROR_BAD_PROVIDER                = 1204 // 0x04B4 The specified network provider name is invalid.
constant ulong ERROR_CANNOT_OPEN_PROFILE         = 1205 // 0x04B5 Unable to open the network connection profile.
constant ulong ERROR_BAD_PROFILE                 = 1206 // 0x04B6 The network connection profile is corrupted.
constant ulong ERROR_EXTENDED_ERROR              = 1208 // 0x04B8 An extended error has occurred.
constant ulong ERROR_SESSION_CREDENTIAL_CONFLICT = 1219 // 0x04C3 Multiple connections to a server or shared resource by the same user, using more than one user name, are not allowed. Disconnect all previous connections to the server or shared resource and try again.
constant ulong ERROR_NO_NETWORK                  = 1222 // 0x04C6 The network is not present or not started.
constant ulong ERROR_CANCELLED                   = 1223 // 0x04C7 The operation was canceled by the user.
constant ulong ERROR_BAD_USERNAME                = 2202 // 0x089A The specified username is invalid.
constant ulong ERROR_NOT_CONNECTED               = 2250 // 0x08CA This network connection does not exist.
constant ulong ERROR_OPEN_FILES                  = 2401 // 0x0961 This network connection has files open or requests pending.
constant ulong ERROR_DEVICE_IN_USE               = 2404 // 0x0964 The device is in use by an active process and cannot be disconnected.
end variables

forward prototypes
public function string of_get_last_error ()
public function string of_get_remote_name (string as_local_name)
public function boolean of_map_network_drive (string as_remote_name, string as_local_name, string as_username, string as_password, boolean ab_persistent)
public function boolean of_unmap_network_drive (string as_local_name, boolean ab_persistent, boolean ab_force)
private subroutine of_parse_error_code (integer al_error_code)
end prototypes

public function string of_get_last_error ();/*
* Objekt : uo_windows_networking_functions
* Methode: of_get_last_error (Function)
* Autor  : Dirk Bunk
* Datum  : 05.03.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt die letzte Fehlermeldung im Klartext zur$$HEX1$$fc00$$ENDHEX$$ck.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    05.03.2012    Erstellung
*
* Return: 
*   Die letzte Fehlermeldug im Klartext.
*/

return isLastError
end function

public function string of_get_remote_name (string as_local_name);/*
* Objekt : uo_windows_networking_functions
* Methode: of_get_remote_name (Function)
* Autor  : Dirk Bunk
* Datum  : 05.03.2012
*
* Argument(e):
*   as_local_name Der lokale Name des Netzlaufwerks, zu dem der Remotename ermittelt werden soll.
*
* Beschreibung: Ermittelt den Remotenamen eines Netzlaufwerks anhand des lokalen Namens.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    05.03.2012    Erstellung
*
* Return: 
*   Der Remotename des Netzlaufwerks.
*/

string sRemoteName = ""
ulong  lbuflen     = 256

//Den Pufferstring auff$$HEX1$$fc00$$ENDHEX$$llen
sRemoteName = Space(lbuflen)

//Den Remotenamen ermitteln
WNetGetConnectionA(as_local_name, sRemoteName, lbuflen)

return sRemoteName
end function

public function boolean of_map_network_drive (string as_remote_name, string as_local_name, string as_username, string as_password, boolean ab_persistent);/*
* Objekt : uo_windows_networking_functions
* Methode: of_map_network_drive (Function)
* Autor  : Dirk Bunk
* Datum  : 05.03.2012
*
* Argument(e):
*   as_remote_name Der Name des freigegebenen Verzeichnisses (Zum Beispiel \\10.102.16.80\DATEN$).
*   as_local_name  Der Name des lokalen Netzlaufwerkes (Zum Beispiel T:).
*   as_username    Der Benutzername f$$HEX1$$fc00$$ENDHEX$$r die Freigabe.
*   as_password    Das Passwort f$$HEX1$$fc00$$ENDHEX$$r die Freigabe.
*   ab_persistent  Boolean-Flag, das angibt, ob die Verbindung auch nach einem Neustart weiter bestehen soll.
*
* Beschreibung: Versucht, ein freigegebenes Verzeichnis im Netzwerk "as_remote_name" 
*               als lokales Netzwerklaufwerk "as_local_name" einzubinden. Im Fall 
*               kennwortgesch$$HEX1$$fc00$$ENDHEX$$tzter freigegebener Verzeichnisse im Netzwerk 
*               kann im Parameter "as_password" ein Kennwort $$HEX1$$fc00$$ENDHEX$$bergeben werden. 
*               Wird in "as_username" kein Benutzername $$HEX1$$fc00$$ENDHEX$$bergeben, wird der Name 
*               des angemeldeten Benutzers verwendet. Wird der Parameter 
*               "ab_persistent" auf true gesetzt so wird nach einem Systemneustart 
*               versucht, die Verbindung erneut herzustellen. 	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    05.03.2012    Erstellung
*
* Return: 
*   True, wenn die Verbindung hergestellt werden konnte.
*   False, wenn ein Fehler aufgetreten ist.
*/

netresource lstr_NetR
ulong lFlags    = 0
ulong lReturn   = 0
boolean bReturn = false

// as_local_name muss ein Buchstabe plus Doppelpunkt sein 
if Right(as_local_name, 1) <> ":" then as_local_name += ":"

// NETRESOURCE-Struktur bef$$HEX1$$fc00$$ENDHEX$$llen
lstr_NetR.dwScope       = RESOURCE_GLOBALNET 
lstr_NetR.dwType        = RESOURCETYPE_DISK
lstr_NetR.dwDisplayType = RESOURCEDISPLAYTYPE_GENERIC 
lstr_NetR.dwUsage       = RESOURCEUSAGE_ALL
lstr_NetR.lpRemoteName  = as_remote_name 
lstr_NetR.lpLocalName   = as_local_name

// Persistenz-Parameter ber$$HEX1$$fc00$$ENDHEX$$cksichtigen 
if ab_persistent then 
	lFlags += CONNECT_UPDATE_PROFILE 
end if

// Versuchen, den Pfad als Netzwerklaufwerk einzubinden
lReturn = WNetAddConnection2A(lstr_NetR, as_password, as_username, lFlags) 

//Fehlercode auswerten
of_parse_error_code(lReturn)

// Pr$$HEX1$$fc00$$ENDHEX$$fung auf Erfolg anhand des zuletzt aufgetretenen Fehlers 
if ilLastError = NO_ERROR then 
	// Aktion erfolgreich 
	bReturn = true
else 
	// Fehler ist aufgetreten
	bReturn = false
end if 

return bReturn
end function

public function boolean of_unmap_network_drive (string as_local_name, boolean ab_persistent, boolean ab_force);/*
* Objekt : uo_windows_networking_functions
* Methode: of_unmap_network_drive (Function)
* Autor  : Dirk Bunk
* Datum  : 05.03.2012
*
* Argument(e):
*   as_local_name Der Name des lokalen Netzlaufwerkes (Zum Beispiel T:).
*   ab_persistent Boolean-Flag, das angibt, ob das Netzlaufwerk permanent gel$$HEX1$$f600$$ENDHEX$$scht werden soll. Also auch nach einem Systemneustart.
*   ab_force      Boolean-Flag, das angibt, ob das Trennen des Netzlaufwerks erzwungen werden soll.
*
* Beschreibung: Versucht, ein lokales Netzwerklaufwerk "as_local_name" zu trennen.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    05.03.2012    Erstellung
*
* Return: 
*   True, wenn die Verbindung getrennt werden konnte.
*   False, wenn ein Fehler aufgetreten ist.
*/

ulong lFlags    = 0
ulong lReturn   = 0
boolean bReturn = false

// as_local_name muss ein Buchstabe plus Doppelpunkt sein 
if Right(as_local_name, 1) <> ":" then as_local_name += ":"

// Persistenz-Parameter ber$$HEX1$$fc00$$ENDHEX$$cksichtigen 
if ab_persistent then 
	lFlags += CONNECT_UPDATE_PROFILE 
end if

// Versuchen, das Netzwerklaufwerk zu trennen
lReturn = WNetCancelConnection2A(as_local_name, lFlags, ab_force)
		
//Fehlercode auswerten
of_parse_error_code(lReturn)

// Pr$$HEX1$$fc00$$ENDHEX$$fung auf Erfolg anhand des zuletzt aufgetretenen Fehlers 
if ilLastError = NO_ERROR then 
	// Aktion erfolgreich 
	bReturn = true
else 
	// Fehler ist aufgetreten
	bReturn = false
end if 

return bReturn
end function

private subroutine of_parse_error_code (integer al_error_code);/*
* Objekt : uo_windows_networking_functions
* Methode: of_parse_error_code (Function)
* Autor  : Dirk Bunk
* Datum  : 05.03.2012
*
* Argument(e):
*   al_error_code Der Fehlercode, zu dem die Fehlermeldung ermittelt werden soll.
*
* Beschreibung: Interne Funktion, die anhand eines Fehlercodes eine sinnvolle Fehlermeldung ermittelt.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    05.03.2012    Erstellung
*
* Return: 
*   none
*/

ilLastError = al_error_code

choose case(ilLastError)
	case NO_ERROR 
		isLastError = ""
	case ERROR_ACCESS_DENIED               
		isLastError = "Access is denied."
	case ERROR_BAD_NETPATH                 
		isLastError = "The network path was not found."
	case ERROR_NETWORK_BUSY
		isLastError = "The network is busy."
	case ERROR_BAD_DEV_TYPE
		isLastError = "The network resource type is not correct."
	case ERROR_BAD_NET_NAME
		isLastError = "The network name cannot be found."
	case ERROR_ALREADY_ASSIGNED
		isLastError = "The local device name is already in use."
	case ERROR_INVALID_PASSWORD
		isLastError = "The specified network password is not correct."
	case ERROR_BUSY
		isLastError = "The requested resource is in use."
	case ERROR_BAD_DEVICE
		isLastError = "The specified device name is invalid."
	case ERROR_DEVICE_ALREADY_REMEMBERED
		isLastError = "The local device name has a remembered connection to another network resource."
	case ERROR_NO_NET_OR_BAD_PATH
		isLastError = "The network path was either typed incorrectly, does not exist, or the network provider is not currently available. Please try retyping the path or contact your network administrator."
	case ERROR_BAD_PROVIDER
		isLastError = "The specified network provider name is invalid."
	case ERROR_CANNOT_OPEN_PROFILE
		isLastError = "Unable to open the network connection profile."
	case ERROR_BAD_PROFILE
		isLastError = "The network connection profile is corrupted."
	case ERROR_EXTENDED_ERROR
		isLastError = "An extended error has occurred."
	case ERROR_SESSION_CREDENTIAL_CONFLICT
		isLastError = "Multiple connections to a server or shared resource by the same user, using more than one user name, are not allowed. Disconnect all previous connections to the server or shared resource and try again."
	case ERROR_NO_NETWORK 
		isLastError = "The network is not present or not started."
	case ERROR_CANCELLED
		isLastError = "The operation was canceled by the user."
	case ERROR_BAD_USERNAME
		isLastError = "The specified username is invalid."
	case ERROR_NOT_CONNECTED 
		isLastError = "This network connection does not exist."
	case ERROR_OPEN_FILES
		isLastError = "This network connection has files open or requests pending."
	case ERROR_DEVICE_IN_USE
		isLastError = "The device is in use by an active process and cannot be disconnected."
	case else
		isLastError = "Unknown error " + String(ilLastError)
end choose
end subroutine

on uo_windows_networking_functions.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_windows_networking_functions.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

