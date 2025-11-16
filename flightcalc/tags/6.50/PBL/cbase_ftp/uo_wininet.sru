HA$PBExportHeader$uo_wininet.sru
$PBExportComments$Userobjekt f$$HEX1$$fc00$$ENDHEX$$r FTP - Funktionen
forward
global type uo_wininet from userobject
end type
end forward

global type uo_wininet from userobject
integer width = 2386
integer height = 1468
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type
global uo_wininet uo_wininet

type prototypes
Function boolean FileTimeToSystemTime(ref str_filedatetime lpFileTime, ref str_systemtime lpSystemTime) library "KERNEL32.DLL" alias for "FileTimeToSystemTime;Ansi"
Function boolean FileTimeToLocalFileTime(ref str_filedatetime lpFileTime, ref str_filedatetime lpLocalFileTime) library "KERNEL32.DLL" alias for "FileTimeToLocalFileTime;Ansi"


FUNCTION ulong 	InternetConnectA( ulong hSession, string szServer, uint iPort, string szUser, string szPassword, ulong dwService, ulong dwFlags, ulong dwContext ) LIBRARY "wininet.dll" alias for "InternetConnectA;Ansi"
FUNCTION ulong 	InternetOpenA( string szAgent, ulong dwAccessType, string szProxy, string szProxyBypass, ulong dwFlags ) LIBRARY "wininet.dll" alias for "InternetOpenA;Ansi"
Function integer 	InternetCloseHandle(long hInet) LIBRARY "wininet.dll"
FUNCTION ulong 	InternetFindNextFileA( ulong hFind, REF str_finddata lpvData ) LIBRARY "wininet.dll" alias for "InternetFindNextFileA;Ansi"

Function integer 	FtpPutFile(long hInet) LIBRARY "wininet.dll"
Function long		FtpPutFile(long hFtpSession,String lpszLocalFile,String lpszRemoteFile,	long dwFlags,long dwContext) LIBRARY "wininet.dll" Alias For "FtpPutFileA;Ansi"

FUNCTION ulong FtpCreateDirectoryA( ulong hSession, ref string lpszDirectory ) LIBRARY "wininet.dll" alias for "FtpCreateDirectoryA;Ansi"
FUNCTION ulong FtpDeleteFileA( ulong hSession, ref string lpszFileName ) LIBRARY "wininet.dll" alias for "FtpDeleteFileA;Ansi"
FUNCTION ulong FtpGetCurrentDirectoryA( ulong hService, REF string szPath, REF ulong lpdwBuffLength ) LIBRARY "wininet.dll" alias for "FtpGetCurrentDirectoryA;Ansi"
FUNCTION ulong FtpGetFileA( ulong hService, string szRemoteFile, string szLocalFile, boolean bFailIfExist, ulong dwLocalFlags, ulong dwInetFals, ulong dwContext ) LIBRARY "wininet.dll" alias for "FtpGetFileA;Ansi"
FUNCTION ulong FtpFindFirstFileA( ulong hSession, ref string szSearchFile, REF str_finddata lpvData, ref ulong dwFlags, ulong dwContext ) LIBRARY "wininet.dll" alias for "FtpFindFirstFileA;Ansi"
FUNCTION ulong FtpSetCurrentDirectoryA( ulong hService, string szPath ) LIBRARY "wininet.dll" alias for "FtpSetCurrentDirectoryA;Ansi"
FUNCTION ulong FtpRemoveDirectoryA( ulong hSession, ref string lpszDirectory ) LIBRARY "wininet.dll" alias for "FtpRemoveDirectoryA;Ansi"
FUNCTION ulong FtpRenameFileA( ulong hSession, ref string lpszExisting, ref string lpszNew ) LIBRARY "wininet.dll" alias for "FtpRenameFileA;Ansi"


FUNCTION ulong GetLastError() LIBRARY "kernel32.dll"

//FUNCTION ulong InternetConnectA( ulong hSession, string szServer, uint iPort, string szUser, string szPassword, ulong dwService, ulong dwFlags, ulong dwContext ) LIBRARY "wininet.dll"
//FUNCTION ulong InternetDial( ulong hwndParent, string szConnectId, ulong dwFlags, REF ulong dwConnection, ulong dwReserved ) LIBRARY "wininet.dll"
//FUNCTION ulong InternetGetConnectedState( REF ulong lpdwFlags, ulong dwReserved ) LIBRARY "wininet.dll"
//FUNCTION ulong InternetGetLastResponseInfoA( REF ulong lpdwError, REF string lpszBuffer, REF ulong lpdwBufferLength ) LIBRARY "wininet.dll"
//FUNCTION ulong InternetHangup( ulong dwConnection, ulong dwReserved ) LIBRARY "wininet.dll"
//FUNCTION ulong InternetQueryDataAvailable( ulong hFile, REF ulong lpdwBytesAvailable, ulong dwFlags, ulong dwContext ) LIBRARY "wininet.dll"
//FUNCTION ulong InternetReadFile( ulong hFile, REF string lpBuffer, ulong dwBytesToRead, REF ulong lpBytesRead ) LIBRARY "wininet.dll"

end prototypes

type variables
long		INTERNET_OPEN_TYPE_DIRECT 			= 1
long		INTERNET_FLAG_PASSIVE				= 134217728
long		INTERNET_INVALID_PORT_NUMBER		= 0
long		INTERNET_SERVICE_FTP					= 1
ulong 	INTERNET_FLAG_RELOAD 				= 2147483648
ulong 	INTERNET_FLAG_NO_CACHE_WRITE 		= 67108864
ulong 	INTERNET_FLAG_RAW_DATA				= 1073741824
uint 		DEFAULT_FTP_PORT	= 21

long		FTP_TRANSFER_TYPE_ASCII				= 1
long		FTP_TRANSFER_TYPE_BINARY			= 0

Integer  iTranferMode							= 0

string	FTP_UAgent 								= "CBASE"

string	sErrorText								= ""
string	sPassword								= ""
string	sServername								= ""
string	sUsername								= ""
string	sLocalpath								= ""
string	sIP										= ""
boolean	bConnected								= false
string	sCurrentDirectory						= ""
String	sFilePattern							= ""

ulong		lOpen										= 0
ulong		lConnection								= 0

//str_finddata	strFiles
ulong 	lLastError

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
end prototypes

public function long uf_put_file (string slocalfile);long 		lResult
string	sRemoteFile
integer	i

// ------------------------------------
// Datei $$HEX1$$fc00$$ENDHEX$$bertragen
// ------------------------------------
sRemoteFile = sLocalFile
For i = len(sLocalFile) to 1 step -1
	 If mid(sLocalFile,i,1)	= "\" Then	
		sRemoteFile = mid(sLocalFile, i + 1)
		Exit
	 End if	
Next

lResult = FtpPutFile(lConnection,sLocalFile,sRemoteFile,FTP_TRANSFER_TYPE_ASCII,0)
 
Return lResult

end function

public function boolean uf_disconnect ();// ------------------------------------
// Verbindung trennen
// ------------------------------------
InternetCloseHandle(lConnection)
InternetCloseHandle(lOpen)

this.sErrorText = ""
this.bConnected = false
return True


end function

public function long uf_set_directory (string spath);Long lResult

if sPath = "." then return 1

lResult = FtpSetCurrentDirectoryA(this.lConnection, sPath)

if lResult = 0 Then
	sErrorText = "Error changing directory"
	return -1
End if

// -----------------------
// lResult 1 = OK
// -----------------------
this.sCurrentDirectory = sPath

return lResult
end function

public function boolean uf_connect ();string		sNullString
long			lFlag
// ------------------------------------
// Verbindung aufbauen
// ------------------------------------
setnull(sNullString)
lOpen = InternetOpenA(FTP_UAgent,INTERNET_OPEN_TYPE_DIRECT,sNullString,sNullString,0)

If lOpen <> 0 Then
	// -------------------------------------------------
	// erstmal den connect via Servername probieren
	// -------------------------------------------------
	lConnection = InternetConnectA(lOpen,this.sServerName,DEFAULT_FTP_PORT,&
											this.sUsername, this.sPassword,INTERNET_SERVICE_FTP,0, 0)

	// --------------------------------------------------------
	// Wenns nicht geklappt dann nochmal mit der IP probieren
	// --------------------------------------------------------
	If lConnection = 0 Then
				
		lConnection = InternetConnectA(lOpen,this.sIP,DEFAULT_FTP_PORT,&
											this.sUsername, this.sPassword,INTERNET_SERVICE_FTP,0, 0)

		If lConnection = 0 Then
			sErrorText = "Error during InternetConnect"
			return False
		end if
		
	End if	
	
Else	
	sErrorText = "Error during InternetOpen"
	return False
End if

this.sLocalPath = uf_checknull(this.sLocalPath)

if this.sLocalPath   = "" then 
	this.sLocalPath = "."
end if


this.sFilePattern = uf_checknull(this.sFilePattern)

if this.sFilePattern   = "" then 
	this.sFilePattern = "*.*"
end if

this.sErrorText = "" 
this.bConnected   = True
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
lOpen = InternetOpenA(FTP_UAgent,INTERNET_OPEN_TYPE_DIRECT,sNullString,sNullString,0)

this.sServerName	= sServer
this.sUsername		= sUser
this.sPassword		= sPWD

If lOpen <> 0 Then
	
	lConnection = InternetConnectA(lOpen,this.sServerName,INTERNET_INVALID_PORT_NUMBER,&
											this.sUsername, this.sPassword,INTERNET_SERVICE_FTP,lFlag, 0)
	If lConnection = 0 Then
		sErrorText = "Error during InternetConnect"
		return False
	End if	
	
Else	
	sErrorText = "Error during InternetOpen"
	return False
End if

this.sLocalPath = uf_checknull(this.sLocalPath)

if this.sLocalPath   = "" then 
	this.sLocalPath = "."
end if

this.sErrorText = "" 
this.bConnected   = True
return True



return true
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
ulong				lReturn, lHandle
long				lNull
long				lPos
boolean			bFile
Date				dDate
Time				tTime

Integer I, iRet
String	sOut
String	sPattern
strDir	= strEmptyDir

lNull = 0


lHandle = FtpFindFirstFileA(this.lConnection, this.sFilePattern , strEmpty, INTERNET_FLAG_RAW_DATA, 0 ) 

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
	
	iRet = InternetFindNextFileA(lHandle, strEmpty)

	if iRet = 1 then
		bFile = true
	else
		bFile = false
		exit
	end if
	
	lPos = UpperBound(strDir) + 1
	strDir[lPos].sFilename =  uf_checknull(strEmpty.cFilename)
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

Integer I
String	sOut

sOut = ""
	
for I = 1 to Upperbound( strFile.cFilename)
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

public function string uf_get_directory ();Long lResult
String sPath
uLong		lLen 

sPath = Space(512)
lLen = len(sPath) + 1
lResult = FtpGetCurrentDirectoryA(this.lConnection, sPath, lLen)

return trim(uf_checknull(sPath))
end function

public function long uf_delete_file (string sfile);long 		lResult
string	sRemoteFile
integer	i

lResult = FtpDeleteFileA(this.lConnection, sFile)
 
Return lResult

end function

public function long uf_delete_directory (string sfile);long 		lResult
string	sRemoteFile
integer	i

lResult = FtpRemoveDirectoryA(this.lConnection, sFile)
 
Return lResult

end function

public function integer uf_get_file (string ssource, string starget);Integer	iRet

iRet = FtpGetFileA( this.lConnection , sSource , sTarget, FALSE, 0, iTranferMode, 0 )

if iRet <> 0 then
	return 0
else
	return -1
end if



end function

public function integer uf_rename_file (string ssource, string starget);ulong lRet

lRet = FtpRenameFileA(this.lConnection , sSource , sTarget)

return lRet


end function

public function long uf_mkdir (string sdir);long 		lResult
string	sRemoteFile
integer	i

lResult = FtpCreateDirectoryA(this.lConnection, sDir)
 
Return lResult

end function

on uo_wininet.create
end on

on uo_wininet.destroy
end on

