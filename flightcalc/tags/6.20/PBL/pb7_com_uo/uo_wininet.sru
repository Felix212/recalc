HA$PBExportHeader$uo_wininet.sru
forward
global type uo_wininet from userobject
end type
end forward

global type uo_wininet from userobject
integer width = 1925
integer height = 1468
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type
global uo_wininet uo_wininet

type prototypes
//KERNEL32.DLL
FUNCTION boolean FileTimeToSystemTime(REF str_filedatetime lpFileTime, REF str_systemtime lpSystemTime) LIBRARY "kernel32.DLL" ALIAS FOR "FileTimeToSystemTime;Ansi"
FUNCTION boolean FileTimeToLocalFileTime(REF str_filedatetime lpFileTime, REF str_filedatetime lpLocalFileTime) LIBRARY "kernel32.DLL" ALIAS FOR "FileTimeToLocalFileTime;Ansi"
FUNCTION ulong GetLastError() LIBRARY "kernel32.dll" ALIAS FOR "GetLastError;Ansi"

//WININET.DLL
FUNCTION boolean InternetCloseHandle(long hInet) LIBRARY "wininet.dll"
FUNCTION boolean InternetFindNextFileA(ulong hFind, REF str_finddata lpvData) LIBRARY "wininet.dll" ALIAS FOR "InternetFindNextFileA;Ansi"
FUNCTION boolean InternetReadFile(ulong hFile, REF blob lpBuffer, long dwNumberOfBytesToRead, REF ulong lpdwNumberOfBytesRead) LIBRARY "wininet.dll" ALIAS FOR "InternetReadFile"
FUNCTION boolean FtpPutFile(long hInet) LIBRARY "wininet.dll" ALIAS FOR "FtpPutFileA;Ansi"
FUNCTION boolean FtpPutFile(long hFtpSession,String lpszLocalFile,String lpszRemoteFile,	long dwFlags,long dwContext) LIBRARY "wininet.dll" ALIAS FOR "FtpPutFileA;Ansi"
FUNCTION boolean FtpCreateDirectoryA(ulong hSession, REF string lpszDirectory) LIBRARY "wininet.dll" ALIAS FOR "FtpCreateDirectoryA;Ansi"
FUNCTION boolean FtpDeleteFileA(ulong hSession, REF string lpszFileName) LIBRARY "wininet.dll" ALIAS FOR "FtpDeleteFileA;Ansi"
FUNCTION boolean FtpGetCurrentDirectoryA(ulong hService, REF string szPath, REF ulong lpdwBuffLength) LIBRARY "wininet.dll" ALIAS FOR "FtpGetCurrentDirectoryA;Ansi"
FUNCTION boolean FtpGetFileA(ulong hService, string szRemoteFile, string szLocalFile, boolean bFailIfExist, ulong dwLocalFlags, ulong dwInetFals, ulong dwContext) LIBRARY "wininet.dll" ALIAS FOR "FtpGetFileA;Ansi"
FUNCTION boolean FtpSetCurrentDirectoryA(ulong hService, string szPath) LIBRARY "wininet.dll" ALIAS FOR "FtpSetCurrentDirectoryA;Ansi"
FUNCTION boolean FtpRemoveDirectoryA(ulong hSession, REF string lpszDirectory) LIBRARY "wininet.dll" ALIAS FOR "FtpRemoveDirectoryA;Ansi"
FUNCTION boolean FtpRenameFileA(ulong hSession, REF string lpszExisting, REF string lpszNew) LIBRARY "wininet.dll" ALIAS FOR "FtpRenameFileA;Ansi"
FUNCTION boolean HttpSendRequestA(ulong hRequest, string szHeaders, long dwHeadersLength, string lpOptional, long dwOptionalLength) LIBRARY "wininet.dll" ALIAS FOR "HttpSendRequestA;Ansi"
FUNCTION boolean HttpQueryInfoA(ulong hRequest, ulong dwInfoLevel, REF blob lpBuffer, REF ulong dwBufferLength, REF ulong dwIndex) LIBRARY "wininet.dll" ALIAS FOR "HttpQueryInfoA;Ansi"

FUNCTION ulong InternetConnectA(ulong hSession, string szServer, uint iiPort, string szUser, string szPassword, ulong dwService, ulong dwFlags, ulong dwContext ) LIBRARY "wininet.dll" ALIAS FOR "InternetConnectA;Ansi"
FUNCTION ulong InternetOpenA(string szAgent, ulong dwAccessType, string szProxy, string szProxyBypass, ulong dwFlags) LIBRARY "wininet.dll" ALIAS FOR "InternetOpenA;Ansi"
FUNCTION ulong FtpOpenFileA(ulong hSession, REF string lpszFileName, ulong dwAccess, ulong dwFlags, long dwContext) LIBRARY "wininet.dll" ALIAS FOR "FtpOpenFileA;Ansi"
FUNCTION ulong FtpGetFileSize(ulong hFile, REF ulong lpdwFileSizeHigh) LIBRARY "wininet.dll" ALIAS FOR "FtpGetFileSize;Ansi"
FUNCTION ulong FtpFindFirstFileA(ulong hSession, string szSearchFile, REF str_finddata lpvData, ulong dwFlags, ulong dwContext) LIBRARY "wininet.dll" ALIAS FOR "FtpFindFirstFileA;Ansi"
FUNCTION ulong HttpOpenRequestA(ulong hConnect, string szVerb, string szObjectName, string szVersion, string szReferrer, string szAcceptTypes[], ulong dwFlags, ulong dwContext) LIBRARY "wininet.dll" ALIAS FOR "HttpOpenRequestA;Ansi"

end prototypes

type variables
//INTERNET FLAGS
constant ulong	INTERNET_FLAG_TRANSFER_ASCII   = 1          //HEX 0000 0001
constant ulong	INTERNET_FLAG_TRANSFER_BINARY  = 2          //HEX 0000 0002
constant ulong	INTERNET_FLAG_NEED_FILE        = 16         //HEX 0000 0010
constant ulong INTERNET_FLAG_PRAGMA_NOCACHE   = 256        //HEX 0000 0100
constant ulong INTERNET_FLAG_NO_UI            = 512        //HEX 0000 0200
constant ulong	INTERNET_FLAG_HYPERLINK        = 1024       //HEX 0000 0400
constant ulong	INTERNET_FLAG_RESYNCHRONIZE    = 2048       //HEX 0000 0800
constant ulong INTERNET_FLAG_KEEP_CONNECTION  = 4194304    //HEX 0040 0000
constant ulong INTERNET_FLAG_SECURE           = 8388608    //HEX 0080 0000
constant ulong	INTERNET_FLAG_FROM_CACHE       = 16777216   //HEX 0100 0000
constant ulong	INTERNET_FLAG_OFFLINE          = 16777216   //HEX 0100 0000
constant ulong INTERNET_FLAG_NO_CACHE_WRITE   = 67108864   //HEX 0400 0000
constant ulong	INTERNET_FLAG_ASYNC            = 268435456  //HEX 1000 0000
constant ulong	INTERNET_FLAG_PASSIVE          = 134217728  //HEX 0800 0000
constant ulong INTERNET_FLAG_EXISTING_CONNECT = 536870912  //HEX 2000 0000
constant ulong INTERNET_FLAG_RAW_DATA         = 1073741824 //HEX 4000 0000
constant ulong INTERNET_FLAG_RELOAD           = 2147483648 //HEX 8000 0000

//GENERIC ACCESS RIGHTS
constant ulong GENERIC_ALL     = 268435456  //HEX 1000 0000
constant ulong GENERIC_EXECUTE = 536870912  //HEX 2000 0000
constant ulong GENERIC_WRITE   = 1073741824 //HEX 4000 0000
constant ulong GENERIC_READ    = 2147483648 //HEX 8000 0000

//ACCESS TYPES
constant uint INTERNET_OPEN_TYPE_PRECONFIG                   = 0;
constant uint INTERNET_OPEN_TYPE_DIRECT                      = 1;
constant uint INTERNET_OPEN_TYPE_PROXY                       = 3;
constant uint INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY = 4;

//SERVER PORTS
constant uint INTERNET_DEFAULT_FTP_PORT      = 21
constant uint INTERNET_DEFAULT_HTTP_PORT     = 80
constant uint INTERNET_DEFAULT_HTTPS_PORT    = 443
constant uint INTERNET_DEFAULT_SOCKS_PORT    = 1080
constant uint INTERNET_ALTERNATIVE_HTTP_PORT = 8080
constant uint INTERNET_INVALID_PORT_NUMBER   = 0

//INTERNET SERVICES
constant uint INTERNET_SERVICE_FTP  = 1
constant uint INTERNET_SERVICE_HTTP = 3

//HTTP QUERY
constant ulong HTTP_QUERY_CONTENT_TYPE              = 1
constant ulong HTTP_QUERY_CONTENT_TRANSFER_ENCODING = 2
constant ulong HTTP_QUERY_CONTENT_ID                = 3
constant ulong HTTP_QUERY_CONTENT_DESCRIPTION       = 4
constant ulong HTTP_QUERY_CONTENT_LENGTH            = 5
constant ulong HTTP_QUERY_RAW_HEADERS_CRLF          = 22

//FTP TRANSFER TYPES
constant uint FTP_TRANSFER_TYPE_BINARY = 0
constant uint FTP_TRANSFER_TYPE_ASCII  = 1

//Hilfsvariablen
integer  iTranferMode = 0

string sAgent            = "CBASE"
string sErrorText        = ""
string sPassword         = ""
string sServername       = ""
string sUsername         = ""
string sLocalpath        = ""
string sIP               = ""
string is_CurrentDirectory = ""
string sFilePattern      = ""

boolean bConnected = false

uint iPort = 21

ulong lOpen       = 0
ulong lConnection = 0
ulong lRequest    = 0
ulong lLastError  = 0

str_directory	strDir[]
end variables

forward prototypes
public function long uf_put_file (string slocalfile)
public function boolean uf_disconnect ()
public function long uf_set_directory (string spath)
public function boolean uf_connect ()
public function string uf_checknull (string sval)
public function boolean uf_connect (string sserver, string suser, string spwd)
public function integer uf_dir ()
public function string uf_filename (str_finddata strfile)
public function integer uf_filedatetime (str_filedatetime strfiletime, ref date dfiledate, ref time tfiletime)
public function string uf_get_directory ()
public function long uf_delete_file (string sfile)
public function long uf_delete_directory (string sfile)
public function integer uf_get_file (string ssource, string starget)
public function integer uf_rename_file (string ssource, string starget)
public function long uf_mkdir (string sdir)
public function unsignedlong uf_get_file_size (string sfile)
public subroutine uf_set_binary ()
public subroutine uf_set_ascii ()
public function str_http_request uf_get_http_request (string as_server, string as_request, unsignedinteger ai_port, boolean ab_use_https)
end prototypes

public function long uf_put_file (string slocalfile);boolean	bResult
string	sRemoteFile
integer	i

// ------------------------------------
// Datei $$HEX1$$fc00$$ENDHEX$$bertragen
// ------------------------------------
sRemoteFile = sLocalFile
for i = len(sLocalFile) to 1 step -1
	 if mid(sLocalFile,i,1)	= "\" then	
		sRemoteFile = mid(sLocalFile, i + 1)
		exit
	end if	
next

// 21.10.2009 HR: Umstellung des Transfermodes auf Umgebungsvaribale
//bResult = FtpPutFile(lConnection, sLocalFile, sRemoteFile, FTP_TRANSFER_TYPE_BINARY, 0)
bResult = FtpPutFile(lConnection, sLocalFile, sRemoteFile, iTranferMode, 0)

if bResult = true then
	return 1
else 
	this.lLastError = GetLastError()
	this.sErrorText = "Error putting file"
	return 0
end if
end function

public function boolean uf_disconnect ();boolean bCloseConnection
boolean bCloseOpen

// ------------------------------------
// Verbindung trennen
// ------------------------------------
bCloseConnection = InternetCloseHandle(lConnection)
bCloseOpen = InternetCloseHandle(lOpen)

if bCloseConnection and bCloseOpen then
	this.sErrorText = ""
	this.bConnected = false
	return true
else
	this.lLastError = GetLastError()
	this.sErrorText = "Error disconnecting connection"
	return false
end if


end function

public function long uf_set_directory (string spath);boolean bReturn

if sPath = "." then return 1

bReturn = FtpSetCurrentDirectoryA(this.lConnection, sPath)

if bReturn = true then
	this.is_CurrentDirectory = sPath
	return 1
else
	this.lLastError = GetLastError()
	this.sErrorText = "Error changing directory"
	return 0
end if

end function

public function boolean uf_connect ();string		sNullString
long			lFlag

// ------------------------------------
// Verbindung aufbauen
// ------------------------------------
setnull(sNullString)
lOpen = InternetOpenA(sAgent, INTERNET_OPEN_TYPE_DIRECT, sNullString, sNullString, 0)

If lOpen <> 0 Then
	// -------------------------------------------------
	// erstmal den connect via Servername probieren
	// -------------------------------------------------
	lConnection = InternetConnectA(lOpen, this.sServerName, this.iPort,&
											this.sUsername, this.sPassword, INTERNET_SERVICE_FTP, 0, 0)

	// --------------------------------------------------------
	// Wenns nicht geklappt dann nochmal mit der IP probieren
	// --------------------------------------------------------
	If lConnection = 0 Then
				
		lConnection = InternetConnectA(lOpen, this.sIP, this.iPort,&
											this.sUsername, this.sPassword, INTERNET_SERVICE_FTP, 0, 0)

		If lConnection = 0 Then
			this.lLastError = GetLastError()
			this.sErrorText = "Error during InternetConnect"
			return False
		end if
		
	End if	
	
Else	
	this.lLastError = GetLastError()
	this.sErrorText = "Error during InternetOpen"
	return False
End if

this.sLocalPath = uf_checknull(this.sLocalPath)

if this.sLocalPath = "" then 
	this.sLocalPath = "."
end if


this.sFilePattern = uf_checknull(this.sFilePattern)

if this.sFilePattern = "" then 
	this.sFilePattern = "*.*"
end if

this.sErrorText = "" 
this.bConnected = True

return True
end function

public function string uf_checknull (string sval);if isnull(sVal) then return ""

return sVal
end function

public function boolean uf_connect (string sserver, string suser, string spwd);string		sNullString
long			lFlag
// ------------------------------------
// Verbindung aufbauen
// ------------------------------------
setnull(sNullString)
lOpen = InternetOpenA(sAgent, INTERNET_OPEN_TYPE_DIRECT, sNullString, sNullString, 0)

this.sServerName	= sServer
this.sUsername		= sUser
this.sPassword		= sPWD

If lOpen <> 0 Then
	
	lConnection = InternetConnectA(lOpen, this.sServerName, INTERNET_INVALID_PORT_NUMBER,&
											this.sUsername, this.sPassword, INTERNET_SERVICE_FTP, lFlag, 0)
	If lConnection = 0 Then
		this.lLastError = GetLastError()
		this.sErrorText = "Error during InternetConnect"
		return False
	End if	
	
Else	
	this.lLastError = GetLastError()
	this.sErrorText = "Error during InternetOpen"
	return False
End if

this.sLocalPath = uf_checknull(this.sLocalPath)

if this.sLocalPath = "" then 
	this.sLocalPath = "."
end if

this.sErrorText = "" 
this.bConnected = True

return True
end function

public function integer uf_dir ();// ---------------------------------------------
// 
// Liste mit allen Files aus einem Verzeichnis
//
//
// Die Files finden befinden sich in der
// Struktur strDir[]
//
// ---------------------------------------------
str_finddata	strEmpty
str_directory	strEmptyDir[]

ulong		lReturn, lHandle
long		lNull
long		lPos

boolean	bFile
boolean	bReturn

date		dDate
time		tTime

string	sOut
string	sPattern

strDir	= strEmptyDir
lNull 	= 0

// DB 05.01.2009: Flags berichtigt
lHandle = FtpFindFirstFileA(this.lConnection, this.sFilePattern , strEmpty, INTERNET_FLAG_RELOAD + INTERNET_FLAG_NO_CACHE_WRITE + INTERNET_FLAG_RESYNCHRONIZE + INTERNET_FLAG_HYPERLINK + INTERNET_FLAG_NEED_FILE, 0 ) 
//lHandle = FtpFindFirstFileA(this.lConnection, this.sFilePattern , strEmpty, INTERNET_FLAG_RAW_DATA, 0 )

if lHandle  = 0 then 
//	lLastError = GetLastError()
//	Messagebox("Attention", "Failed reading directory " + this.uf_get_directory() + "~r~rErrorcode: " + String(lLastError))
	InternetCloseHandle(lHandle)
	return 0
end if

lPos = UpperBound(strDir) + 1
strDir[lPos].sFilename = uf_checknull(strEmpty.cFilename)
strDir[lPos].lFileType = strEmpty.dwfileattributes // 16 = Directory, 128 = File
strDir[lPos].lFileSize = strEmpty.nfilesizelow
uf_filedatetime(strEmpty.ftcreationtime, dDate, tTime)
strDir[lPos].sFileDate = String(dDate)
strDir[lPos].sFileTime = String(tTime)

bFile = true

do while bFile = true
	
	bFile = InternetFindNextFileA(lHandle, strEmpty)

	if not bFile then
		exit
	end if
	
	lPos = UpperBound(strDir) + 1
	strDir[lPos].sFilename = uf_checknull(strEmpty.cFilename)
	strDir[lPos].lFileType = strEmpty.dwfileattributes
	strDir[lPos].lFileSize = strEmpty.nfilesizelow
	uf_filedatetime(strEmpty.ftcreationtime, dDate, tTime)
	strDir[lPos].sFileDate = String(dDate)
	strDir[lPos].sFileTime = String(tTime)
loop

InternetCloseHandle(lHandle)

return 0
end function

public function string uf_filename (str_finddata strfile);str_finddata	strEmpty

integer i
string sOut

sOut = ""
	
for i = 1 to Upperbound(strFile.cFilename)
	sOut += this.uf_checknull(strFile.cFilename[i])
next
	
return sOut
end function

public function integer uf_filedatetime (str_filedatetime strfiletime, ref date dfiledate, ref time tfiletime);string				sTime
str_filedatetime	strLocalTime
str_systemtime		strSystemTime

If Not FileTimeToLocalFileTime(strFileTime, strLocalTime) Then Return -1

If Not FileTimeToSystemTime(strLocalTime, strSystemTime) Then Return -1

dFileDate = Date(strSystemTime.ui_wyear, strSystemTime.ui_WMonth, strSystemTime.ui_WDay)

//Messagebox("", string(strSystemTime.ui_wyear))


sTime   = String(strSystemTime.ui_wHour) + ":" + &
			 String(strSystemTime.ui_wMinute) + ":" + &
			 String(strSystemTime.ui_wSecond) + ":" + &
			 String(strSystemTime.ui_wMilliseconds)
			 
tFileTime = Time(sTime)

Return 1


end function

public function string uf_get_directory ();boolean 	bReturn
string 	sPath
uLong		lLen 

sPath = Space(512)
lLen = len(sPath) + 1
bReturn = FtpGetCurrentDirectoryA(this.lConnection, sPath, lLen)

if bReturn = false then
	this.lLastError = GetLastError()
	this.sErrorText = "Error getting directory"
end if

return trim(uf_checknull(sPath))
end function

public function long uf_delete_file (string sfile);boolean	bReturn
string	sRemoteFile
integer	i

bReturn = FtpDeleteFileA(this.lConnection, sFile)
 
if bReturn = true then
	return 1
else
	this.lLastError = GetLastError()
	this.sErrorText = "Error deleting file"
	return 0
end if

end function

public function long uf_delete_directory (string sfile);boolean 	bReturn
string	sRemoteFile
integer	i

bReturn = FtpRemoveDirectoryA(this.lConnection, sFile)
 
if bReturn = true then
	return 1
else
	this.lLastError = GetLastError()
	this.sErrorText = "Error deleting directory"
	return 0
end if

end function

public function integer uf_get_file (string ssource, string starget);boolean	bReturn

bReturn = FtpGetFileA(this.lConnection, sSource, sTarget, FALSE, 0, iTranferMode, 0)

//Dies ist die einzige Funktion bei der der R$$HEX1$$fc00$$ENDHEX$$ckgabewert bei Erfolg 0 ist...
if bReturn = true then
	return 0
else
	this.lLastError = GetLastError()
	this.sErrorText = "Error getting file"
	return -1
end if



end function

public function integer uf_rename_file (string ssource, string starget);boolean bReturn

bReturn = FtpRenameFileA(this.lConnection, sSource, sTarget)

if bReturn = true then
	return 1
else 
	this.lLastError = GetLastError()
	this.sErrorText = "Error renaming file"
	return 0
end if


end function

public function long uf_mkdir (string sdir);boolean	bResult
string	sRemoteFile
integer	i

bResult = FtpCreateDirectoryA(this.lConnection, sDir)
 
if bResult = true then
	return 1
else
	this.lLastError = GetLastError()
	this.sErrorText = "Error creating directory"
	return 0
end if

end function

public function unsignedlong uf_get_file_size (string sfile);/* 
* Funktion/Event: uf_get_file_size
* Beschreibung: 	Liest die Gr$$HEX2$$f600df00$$ENDHEX$$e einer Datei
* Besonderheit: 	keine
*
* Argumente:
* 	Name						Beschreibung
*	sfile						Der Pfad+Name der Datei, deren Gr$$HEX2$$f600df00$$ENDHEX$$e gelesen werden soll
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			D.Bunk		04.08.2008		Erstellung
*
* Return Codes:
*	>0	Gr$$HEX2$$f600df00$$ENDHEX$$e der Datei in Bytes
*	-1	Fehler ist aufgetreten
*/

ulong lFileSize
ulong ulFileHandle
boolean bReturn

//Datei zum lesen $$HEX1$$f600$$ENDHEX$$ffnen
ulFileHandle = FtpOpenFileA(this.lConnection, sFile, GENERIC_READ, FTP_TRANSFER_TYPE_BINARY, 0)

//Fehlerpr$$HEX1$$fc00$$ENDHEX$$fung
if ulFileHandle <= 0 then 
	
	this.lLastError = GetLastError()
	
	choose case this.lLastError
		case 12111
			//Verbindung verloren
			this.sErrorText = "The FTP Connection was lost."
			return -1
		case else
			this.sErrorText = "Could not open file for reading. Return code: " + String(this.lLastError)
			return -1
	end choose
	
end if

//Dateigr$$HEX2$$f600df00$$ENDHEX$$e lesen
lFileSize = FtpGetFileSize(ulFileHandle, lFileSize)

//Dateihandle schlie$$HEX1$$df00$$ENDHEX$$en
bReturn = InternetCloseHandle(ulFileHandle)

//Fehlerpr$$HEX1$$fc00$$ENDHEX$$fung
if not bReturn then
	this.lLastError = GetLastError()
	this.sErrorText = "File could not be closed. Return code: " + String(this.lLastError)
	return -1
end if

return lFileSize
end function

public subroutine uf_set_binary ();// --------------------------------------------------------------------------------
// Objekt : uo_wininet
// Methode: uf_set_binary (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------
// Return: none
// --------------------------------------------------------------------------------
//  Beschreibung: Setzt den Modus auf Binary-$$HEX1$$dc00$$ENDHEX$$bertragung
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor              Kommentar
// --------------------------------------------------------------------------------
//  21.10.2009	   1.0      Heiko Rothenbach   Erstellung
// --------------------------------------------------------------------------------

iTranferMode = FTP_TRANSFER_TYPE_BINARY	

end subroutine

public subroutine uf_set_ascii ();// --------------------------------------------------------------------------------
// Objekt : uo_wininet
// Methode: uf_set_ascii (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------
// Return: none
// --------------------------------------------------------------------------------
//  Beschreibung: Setzt den Modus auf ASCII-$$HEX1$$dc00$$ENDHEX$$bertragung
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor              Kommentar
// --------------------------------------------------------------------------------
//  21.10.2009	   1.0      Heiko Rothenbach   Erstellung
// --------------------------------------------------------------------------------

iTranferMode = FTP_TRANSFER_TYPE_ASCII	

end subroutine

public function str_http_request uf_get_http_request (string as_server, string as_request, unsignedinteger ai_port, boolean ab_use_https);str_http_request strRequest

String sNullString
String sNullStringArray[]
String sTmp

Boolean bError

Blob bUrlBlob
Blob{2048} bBuffer
Blob{2048} bEmpty

ULong lBytesRead
ULong lHeaderIndex
ULong lBufferSize
Ulong lInternetFlags

//Defaults setzen
bError                   = false
lBufferSize              = 2048
strRequest.lSize         = 0
strRequest.sRawHeaders   = ""
strRequest.sType         = ""
sTmp                     = ""
lInternetFlags           = INTERNET_FLAG_KEEP_CONNECTION
if(ab_use_https) then lInternetFlags += INTERNET_FLAG_SECURE


//Die WinInet-Funktionen initialisieren
if(bError = false) then
   lOpen = InternetOpenA(sAgent, INTERNET_OPEN_TYPE_PRECONFIG, sNullString, sNullString, 0)

	//Pr$$HEX1$$fc00$$ENDHEX$$fen, ob die Initialisierung geklappt hat
	if(isNull(lOpen)) then
		lLastError = GetLastError()
		sErrorText = "Failed to initialize WinInet API."
		bError     = true
	end if
end if

//HTTP-Session einer bestimmten Seite $$HEX1$$f600$$ENDHEX$$ffnen
if(bError = false) then
	lConnection = InternetConnectA(lOpen, as_server, ai_port, sUsername, sPassword, INTERNET_SERVICE_HTTP, 0, 0)
	
	//Pr$$HEX1$$fc00$$ENDHEX$$fen, ob die Verbindung geklappt hat
	if(isNull(lConnection)) then
		lLastError = GetLastError()
		sErrorText = "Failed to connect to server."
		bError     = true
	end if
end if

//HTTP-Request $$HEX1$$f600$$ENDHEX$$ffnen
if(bError = false) then	
	lRequest = HttpOpenRequestA(lConnection, "GET", as_request, sNullString, sNullString, sNullStringArray, lInternetFlags, 0)
	
	//Pr$$HEX1$$fc00$$ENDHEX$$fen, ob der Request geklappt hat
	if(isNull(lRequest)) then
		lLastError = GetLastError()
		sErrorText = "Failed to open request."
		bError     = true
	end if
end if

//HTTP-Request senden
if(bError = false) then
	bError = not HttpSendRequestA(lRequest, sNullString, 0, sNullString, 0)
	
	//Pr$$HEX1$$fc00$$ENDHEX$$fen, ob der Request geklappt hat
	if(bError = true) then
		lLastError = GetLastError()
		sErrorText = "Failed to send request."
		bError     = true
	end if
end if

//HTTP-Header abfragen
if(bError = false) then
	//Raw Headers auslesen
	lHeaderIndex = 0
	lBytesRead   = lBufferSize
	bBuffer      = bEmpty
	bUrlBlob     = Blob("")
	do while(HttpQueryInfoA(lRequest, HTTP_QUERY_RAW_HEADERS_CRLF, bBuffer, lBytesRead, lHeaderIndex))
		if(lBytesRead = 0) then 
			exit
		end if
		
		bUrlBlob += bBuffer
		bBuffer   = bEmpty
	loop
	
	strRequest.sRawHeaders = String(bUrlBlob, EncodingANSI!)
	
	//Die x-CompId aus den Infos parsen
	sTmp = strRequest.sRawHeaders
	sTmp = Right(sTmp, Len(sTmp) - Pos(sTmp, "X-compId: ") - 9)
	sTmp = Left(sTmp, Pos(sTmp, Char(10)))
	strRequest.sCompId = sTmp
	
	//Den Content-Type aus den Infos parsen
	sTmp = strRequest.sRawHeaders
	sTmp = Right(sTmp, Len(sTmp) - Pos(sTmp, "Content-Type: ") - 13)
	sTmp = Left(sTmp, Pos(sTmp, Char(10)))
	strRequest.sType = sTmp
	
	//Die Content-Length aus den Infos parsen
	sTmp = strRequest.sRawHeaders
	sTmp = Right(sTmp, Len(sTmp) - Pos(sTmp, "Content-Length: ") - 15)
	sTmp = Left(sTmp, Pos(sTmp, Char(10)))
	strRequest.lSize = Long(sTmp)
end if

//HTTP-Request empfangen
if(bError = false) then
	bUrlBlob = Blob("")
	bBuffer  = bEmpty
	
	do while(InternetReadFile(lRequest, bBuffer, lBufferSize, lBytesRead))
		if(lBytesRead = 0) then 
			exit
		end if
		
		bUrlBlob         += bBuffer
		bBuffer           = bEmpty
	loop
	
	strRequest.bdata = bUrlBlob
end if

return strRequest
end function

on uo_wininet.create
end on

on uo_wininet.destroy
end on

