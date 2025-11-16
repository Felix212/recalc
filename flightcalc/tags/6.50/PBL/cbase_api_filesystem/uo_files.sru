HA$PBExportHeader$uo_files.sru
$PBExportComments$Userobjekt zur Bearbeitung der Dateiattribute
forward
global type uo_files from nonvisualobject
end type
type ofstruct from structure within uo_files
end type
type filetime from structure within uo_files
end type
type win32_find_data from structure within uo_files
end type
type systemtime from structure within uo_files
end type
type findresult from structure within uo_files
end type
end forward

type ofstruct from structure
	long		cbyte
	long		ffixeddisk
	unsignedlong		nerrcode
	unsignedlong		reserved1
	unsignedlong		reserved2
	character		szpathname[128]
end type

type filetime from structure
	unsignedlong		dwlowdatetime
	unsignedlong		dwhighdatetime
end type

type win32_find_data from structure
	ulong		dwfileattributes
	filetime		ftcreationtime
	filetime		ftlastaccesstime
	filetime		ftlastwritetime
	ulong		nfilesizehigh
	ulong		nfilesizelow
	ulong		dwreserved0
	ulong		dwreserved1
	character		cfilename[260]
	character		calternatefilename[14]
end type

type systemtime from structure
	unsignedinteger		wyear
	unsignedinteger		wmonth
	unsignedinteger		wdayofweek
	unsignedinteger		wday
	unsignedinteger		whour
	unsignedinteger		wminute
	unsignedinteger		wsecond
	unsignedinteger		wmilliseconds
end type

type findresult from structure
	string		sfilename
	string		saltfilename
	long		lfilesize
	boolean		breadonly
	boolean		bhidden
	boolean		bsystem
	boolean		bsubdirectory
	boolean		barchive
	boolean		bdrive
	date		dcreationdate
	time		tcreationtime
	date		dwritedate
	time		twritetime
end type

global type uo_files from nonvisualobject
end type
global uo_files uo_files

type prototypes
PRIVATE:
// Win32 calls for file date and time
function long OpenFile (ref string lpFileName, ref ofstruct lpReOpenBuff, ulong uStyle) library "kernel32.dll" alias for "OpenFile;Ansi"
function boolean CloseHandle (long hObject) library "kernel32.dll"
function boolean GetFileTime (long hFile, ref filetime lpCreationTime, ref filetime lpLastAccessTime, ref filetime lpLastWriteTime) library "kernel32.dll"
function boolean SetFileTime (long hFile, filetime lpCreationTime, filetime lpLastAccessTime, filetime lpLastWriteTime) library "kernel32.dll"
function boolean FileTimeToLocalFileTime (ref filetime lpFileTime, ref filetime lpLocalFileTime) library "kernel32.dll" alias for "FileTimeToLocalFileTime"
function boolean LocalFileTimeToFileTime (ref filetime lpLocalFileTime, ref filetime lpFileTime) library "kernel32.dll" alias for "LocalFileTimeToFileTime"
function boolean FileTimeToSystemTime (ref filetime lpFileTime, ref systemtime lpSystemTime) library "kernel32.dll" alias for "FileTimeToSystemTime"
function boolean SystemTimeToFileTime (ref systemtime lpSystemTime, ref filetime lpFileTime) library "kernel32.dll" alias for "SystemTimeToFileTime"
function long FindFirstFile (ref string lpFileName, ref win32_find_data lpFindFileData) library "kernel32.dll" alias for "FindFirstFileA;Ansi"
function boolean FindNextFile (long hFindFile, ref win32_find_data lpFindFileData) library "kernel32.dll" alias for "FindNextFileA;Ansi"
function boolean FindClose (long hFindFile) library "kernel32.dll"
end prototypes

type variables
PUBLIC:
/************************************************************************************************************
06.03.2012, DB:
Konstanten f$$HEX1$$fc00$$ENDHEX$$r Dateitypen (Quelle PFC)

Anmerkung: 
Zum gr$$HEX2$$f600df00$$ENDHEX$$ten Teil sind das die Konstanten f$$HEX1$$fc00$$ENDHEX$$r Dateiattribute von Microsoft, allerdings nicht 100%ig identisch
--> http://msdn.microsoft.com/en-us/library/windows/desktop/gg258117%28v=vs.85%29.aspx
************************************************************************************************************/
constant ulong FILE_TYPE_READWRITE  =     0 // Read/write files
constant ulong FILE_TYPE_READONLY   =     1 // Read-only files
constant ulong FILE_TYPE_HIDDEN     =     2 // Hidden files
constant ulong FILE_TYPE_SYSTEM     =     4 // System files
constant ulong FILE_TYPE_DIRECTORY  =    16 // Subdirectories
constant ulong FILE_TYPE_ARCHIVE    =    32 // Archive (modified) files
constant ulong FILE_TYPE_NORMAL     =   128 // Normal files
constant ulong FILE_TYPE_TEMPORARY  =   256 // Temporary files
constant ulong FILE_TYPE_COMPRESSED =  2048 // Compressed files
constant ulong FILE_TYPE_DRIVE      = 16384 // Drives
constant ulong FILE_TYPE_EXCLUDE    = 32768 // Exclude read/write files from the list

constant ulong FILE_TYPE_ALL = FILE_TYPE_READWRITE + FILE_TYPE_READONLY + FILE_TYPE_HIDDEN + FILE_TYPE_SYSTEM &
									  + FILE_TYPE_DIRECTORY + FILE_TYPE_ARCHIVE + FILE_TYPE_NORMAL + FILE_TYPE_TEMPORARY &
									  + FILE_TYPE_COMPRESSED
									  
PRIVATE:
/************************************************************************************************************
Konstanten f$$HEX1$$fc00$$ENDHEX$$r den File Open Style.
Siehe dazu: http://msdn.microsoft.com/en-us/library/windows/desktop/aa365430%28v=vs.85%29.aspx
************************************************************************************************************/
constant ulong OPEN_STYLE_CANCEL           =  2048 // [0x00000800] Ignored. To produce a dialog box containing a Cancel button, use OF_PROMPT.
constant ulong OPEN_STYLE_CREATE           =  4096 // [0x00001000] Creates a new file. If the file exists, it is truncated to zero (0) length.
constant ulong OPEN_STYLE_DELETE           =   512 // [0x00000200] Deletes a file.
constant ulong OPEN_STYLE_EXIST            = 16384 // [0x00004000] Opens a file and then closes it. Use this to test for the existence of a file.
constant ulong OPEN_STYLE_PARSE            =   256 // [0x00000100] Fills the OFSTRUCT structure, but does not do anything else.
constant ulong OPEN_STYLE_PROMPT           =  8192 // [0x00002000] Displays a dialog box if a requested file does not exist. A dialog box informs a user that the system cannot find a file, and it contains Retry and Cancel buttons. The Cancel button directs OpenFile to return a file-not-found error message.
constant ulong OPEN_STYLE_READ             =     0 // [0x00000000] Opens a file for reading only.
constant ulong OPEN_STYLE_READWRITE        =     2 // [0x00000002] Opens a file with read/write permissions.
constant ulong OPEN_STYLE_REOPEN           = 32768 // [0x00008000] Opens a file by using information in the reopen buffer.
constant ulong OPEN_STYLE_SHARE_COMPAT     =     0 // [0x00000000] For MS-DOS$$HEX1$$1320$$ENDHEX$$based file systems, opens a file with compatibility mode, allows any process on a specified computer to open the file any number of times. Other efforts to open a file with other sharing modes fail. This flag is mapped to the FILE_SHARE_READ|FILE_SHARE_WRITE flags of the CreateFile function.
constant ulong OPEN_STYLE_SHARE_DENY_NONE  =    64 // [0x00000040] Opens a file without denying read or write access to other processes. On MS-DOS-based file systems, if the file has been opened in compatibility mode by any other process, the function fails. This flag is mapped to the FILE_SHARE_READ|FILE_SHARE_WRITE flags of the CreateFile function.
constant ulong OPEN_STYLE_SHARE_DENY_READ  =    48 // [0x00000030] Opens a file and denies read access to other processes. On MS-DOS-based file systems, if the file has been opened in compatibility mode, or for read access by any other process, the function fails. This flag is mapped to the FILE_SHARE_WRITE flag of the CreateFile function.
constant ulong OPEN_STYLE_SHARE_DENY_WRITE =    32 // [0x00000020] Opens a file and denies write access to other processes. On MS-DOS-based file systems, if a file has been opened in compatibility mode, or for write access by any other process, the function fails. This flag is mapped to the FILE_SHARE_READ flag of the CreateFile function.
constant ulong OPEN_STYLE_SHARE_EXCLUSIVE  =    16 // [0x00000010] Opens a file with exclusive mode, and denies both read/write access to other processes. If a file has been opened in any other mode for read/write access, even by the current process, the function fails.
constant ulong OPEN_STYLE_VERIFY           =  1024 // [0x00000400] Verifies that the date and time of a file are the same as when it was opened previously. This is useful as an extra check for read-only files.
constant ulong OPEN_STYLE_WRITE            =     1 // [0x00000001] Opens a file for write access only.

// Eigene Konstanten f$$HEX1$$fc00$$ENDHEX$$r die verschiedenen Arten des Dateizeitstempels
constant int FILE_TIME_TYPE_CREATE = 1
constant int FILE_TIME_TYPE_ACCESS = 2
constant int FILE_TIME_TYPE_WRITE = 3
end variables

forward prototypes
private function long of_bitwiseand (long lvalue1, long lvalue2)
private function boolean of_getbit (long ldecimal, unsignedinteger ibit)
private function boolean of_includefile (string sfilename, long lattribmask, unsignedlong ulfileattrib)
private function string of_replace_all (string as_oldstring, string as_findstr, string as_replace)
public function datetime of_get_file_creation_time (string as_file)
public function datetime of_get_file_last_access_time (string as_file)
public function datetime of_get_file_last_write_time (string as_file)
private function datetime of_get_file_time (string as_file, integer as_type)
private function integer of_convertfiletimetopb (filetime astr_filetime, ref date rd_filedate, ref time rt_filetime)
private function integer of_convertfiletimefrompb (ref filetime rstr_filetime, date ad_filedate, time at_filetime)
private function integer of_set_file_time (string as_file, datetime adt_newfiledatetime, integer as_type)
public function integer of_set_file_last_write_time (string as_file, datetime adt_newfiledatetime)
public function integer of_set_file_last_access_time (string as_file, datetime adt_newfiledatetime)
public function integer of_set_file_creation_time (string as_file, datetime adt_newfiledatetime)
public function integer of_delete_dir (string as_dir)
public function long of_dirlist (string sfilespec, long lfiletype, ref str_findresult strresult[])
public function long of_get_subfolders (string as_dir, ref string as_subfolders[])
end prototypes

private function long of_bitwiseand (long lvalue1, long lvalue2);Integer		iCnt
Long			lResult
Boolean		bValue1[32], bValue2[32]

// Check for nulls
If IsNull(lValue1) Or IsNull(lValue2) Then
	SetNull(lResult)
	Return lResult
End If

// Get all bits for both values
For iCnt = 1 To 32
	bValue1[iCnt] = of_getbit(lValue1, iCnt)
	bValue2[iCnt] = of_getbit(lValue2, iCnt)
Next

// And them together
For iCnt = 1 To 32
	If bValue1[iCnt] And bValue2[iCnt] Then
		lResult = lResult + (2^(iCnt - 1))
	End If
Next

Return lResult

end function

private function boolean of_getbit (long ldecimal, unsignedinteger ibit);//	Arguments:
//	lDecimal		Decimal value whose on/off value needs to be determined (e.g. 47).
//	iBit			Position bit from right to left on the Decimal value.

Boolean bNull

If IsNull(lDecimal) or IsNull(iBit) then
	SetNull(bNull)
	Return bNull
End If

If Int(Mod(lDecimal / (2 ^(iBit - 1)), 2)) > 0 Then
	Return True
End If

Return False

end function

private function boolean of_includefile (string sfilename, long lattribmask, unsignedlong ulfileattrib);boolean bReadWrite

// Never include the "[.]" directory entry
If sFileName = "." Then Return False

// If the mask is > 32768, then read/write files should be excluded
If lAttribMask >=32768 Then
	lAttribMask = lAttribMask - 32768
	bReadWrite = False
Else
	bReadWrite = True
End if

// If the type is > 16384, then a list of drives should be included
If lAttribMask >= 16384 Then lAttribMask = lAttribMask - 16384

// Include the file if lb_ReadWrite is true and the file is a read-write or
// read-only file (with or without the archive bit set)
// NTFS File Systems set Read/Write Files (FILE_ATTRIBUTE_NORMAL) = 128
If (bReadWrite And (ulFileAttrib = 0 Or &
							 	ulFileAttrib = 1 Or &
								ulFileAttrib = 32 Or &
								ulFileAttrib = 33 Or &
								ulFileAttrib = 128 )) Then Return True
			
//  Look for compressed files
If (bReadWrite And (ulFileAttrib = 0 + 2048 Or &
							 	ulFileAttrib = 1 + 2048 Or &
								ulFileAttrib = 32 + 2048 Or &
								ulFileAttrib = 33 + 2048 Or &
								ulFileAttrib = 128 + 2048 )) Then Return True

// Or include it if its attributes match the mask passed in (use bitwise AND).
If of_BitwiseAnd(ulFileAttrib, lAttribMask) > 0 Then Return True

Return False
end function

private function string of_replace_all (string as_oldstring, string as_findstr, string as_replace);/*
* Autor  : Dirk Bunk
* Datum  : 03.07.2013
*
* Argument(e):
*   as_oldstring    Der String, in dem gesucht und ersetzt werden soll
*   as_findstr      Der String, der gefunden werden soll
*   as_replace      Der String, der zum Ersetzen dienen soll
*
* Beschreibung: Ersetzt alle Vorkommnisse eines gesuchten Strings in einem String.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    03.07.2013    Erstellung
*
* Return: 
*   Der aktualisierte String
*/

string ls_newstring
long ll_findstr, ll_replace, ll_pos

// L$$HEX1$$e400$$ENDHEX$$nge der Strings ermitteln
ll_findstr = Len(as_findstr)
ll_replace = Len(as_replace)

// Das erste Vorkommen des gesuchten Strings ermitteln
ls_newstring = as_oldstring
ll_pos = Pos(ls_newstring, as_findstr)

do while ll_pos > 0
	// Den gesuchten Teil des Strings, durch den neuen Teil ersetzen
	ls_newstring = Replace(ls_newstring, ll_pos, ll_findstr, as_replace)
	// Das n$$HEX1$$e400$$ENDHEX$$chste Vorkommen des gesuchten Strings ermitteln
	ll_pos = Pos(ls_newstring, as_findstr, (ll_pos + ll_replace))
loop

return ls_newstring
end function

public function datetime of_get_file_creation_time (string as_file);return of_get_file_time(as_file, FILE_TIME_TYPE_CREATE)
end function

public function datetime of_get_file_last_access_time (string as_file);return of_get_file_time(as_file, FILE_TIME_TYPE_ACCESS)
end function

public function datetime of_get_file_last_write_time (string as_file);return of_get_file_time(as_file, FILE_TIME_TYPE_WRITE)
end function

private function datetime of_get_file_time (string as_file, integer as_type);/*
* Autor  : Dirk Bunk
* Datum  : 07.07.2014
*
* Argument(e):
*   as_File  Der Pfad + Dateiname der Datei, deren Zeitstempel ermittelt werden soll
*   as_Type  Die Art des Zeitstempels (Create, Access, Write), siehe Instanzvariablen
*
* Beschreibung: Hilfsfunktion zum Ermitteln des Zeitstempels einer Datei.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    07.07.2014    Erstellung
*
* Return: 
*  Der ermittelte Zeitstempel
*/

ofstruct lstr_OpenFile
filetime lstr_FileDateTime, lstr_FileDateTimeCreate, lstr_FileDateTimeAccess, lstr_FileDateTimeWrite
long ll_FileHandle, ll_Pos
string ls_OldDir, ls_Path, ls_Filename
date ld_FileDate
time lt_FileTime
datetime ldt_ResultDateTime

// Den Pfad und Dateinamen trennen
ll_Pos = LastPos(as_file, "\")
ls_Path = Mid(as_file, 1, ll_Pos)
ls_Filename = Mid(as_file, ll_Pos + 1)

// Das aktuelle Verzeichnis merken
ls_OldDir = GetCurrentDirectory()

// Das aktuelle Verzeichnis auf den Pfad der Datei festlegen
ChangeDirectory(ls_Path)

// Die Datei $$HEX1$$d600$$ENDHEX$$ffnen
ll_FileHandle = OpenFile(ls_FileName, lstr_OpenFile, OPEN_STYLE_READ)

// File Time der Datei ermitteln
if GetFileTime(ll_FileHandle, lstr_FileDateTimeCreate, lstr_FileDateTimeAccess, lstr_FileDateTimeWrite) then
	// File Time Variable je nach File Time Typ setzen
	choose case as_type
		case FILE_TIME_TYPE_CREATE
			lstr_FileDateTime = lstr_FileDateTimeCreate
		case FILE_TIME_TYPE_ACCESS
			lstr_FileDateTime = lstr_FileDateTimeAccess
		case FILE_TIME_TYPE_WRITE
			lstr_FileDateTime = lstr_FileDateTimeWrite
	end choose
	
	// File Time zu PB Date und Time umwandeln
	if of_ConvertFileTimeToPB(lstr_FileDateTime, ld_FileDate, lt_FileTime) = 0 then
		ldt_ResultDateTime = DateTime(ld_FileDate, lt_FileTime)
	end if
end if

// Datei Handle schlie$$HEX1$$df00$$ENDHEX$$en
CloseHandle(ll_FileHandle)

// Das urspr$$HEX1$$fc00$$ENDHEX$$ngliche Verzeichnis wieder herstellen
ChangeDirectory(ls_OldDir)

return ldt_ResultDateTime
end function

private function integer of_convertfiletimetopb (filetime astr_filetime, ref date rd_filedate, ref time rt_filetime);string ls_Time
filetime	lstr_LocalTime
systemtime lstr_SystemTime

if not FileTimeToLocalFileTime(astr_FileTime, lstr_LocalTime) then return -1
if not FileTimeToSystemTime(lstr_LocalTime, lstr_SystemTime) then return -1

rd_FileDate = Date(lstr_SystemTime.wYear, lstr_SystemTime.wMonth, lstr_SystemTime.wDay)

ls_Time = String(lstr_SystemTime.wHour) + ":" + &
			 String(lstr_SystemTime.wMinute) + ":" + &
			 String(lstr_SystemTime.wSecond) + ":" + &
			 String(lstr_SystemTime.wMilliseconds)
rt_FileTime = Time(ls_Time)

return 0
end function

private function integer of_convertfiletimefrompb (ref filetime rstr_filetime, date ad_filedate, time at_filetime);filetime	lstr_LocalTime
systemtime lstr_SystemTime

lstr_SystemTime.wYear = Year(ad_FileDate)
lstr_SystemTime.wMonth = Month(ad_FileDate)
lstr_SystemTime.wDayOfWeek = DayNumber(ad_FileDate)
lstr_SystemTime.wDay = Day(ad_FileDate)
lstr_SystemTime.wHour = Hour(at_filetime)
lstr_SystemTime.wMinute = Minute(at_filetime)
lstr_SystemTime.wSecond = Second(at_filetime)
lstr_SystemTime.wMilliseconds = 0

if not SystemTimeToFileTime(lstr_SystemTime, lstr_LocalTime) then return -1
if not LocalFileTimeToFileTime(lstr_LocalTime, rstr_FileTime) then return -1

return 0
end function

private function integer of_set_file_time (string as_file, datetime adt_newfiledatetime, integer as_type);/*
* Autor  : Dirk Bunk
* Datum  : 07.07.2014
*
* Argument(e):
*   as_File              Der Pfad + Dateiname der Datei, deren Zeitstempel ge$$HEX1$$e400$$ENDHEX$$ndert werden soll
*   adt_NewFileDateTime  Der neue Zeitstempel der gesetzt werden soll
*   as_Type              Die Art des Zeitstempels (Create, Access, Write), siehe Instanzvariablen
*
* Beschreibung: Hilfsfunktion zum $$HEX1$$c400$$ENDHEX$$ndern des Zeitstempels einer Datei.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    07.07.2014    Erstellung
*
* Return: 
*   0 Ok
*  -1 Fehler
*/

ofstruct lstr_OpenFile
filetime lstr_FileDateTimeCreate, lstr_FileDateTimeAccess, lstr_FileDateTimeWrite
long ll_FileHandle, ll_Pos
string ls_OldDir, ls_Path, ls_Filename

// Den Pfad und Dateinamen trennen
ll_Pos = LastPos(as_file, "\")
ls_Path = Mid(as_file, 1, ll_Pos)
ls_Filename = Mid(as_file, ll_Pos + 1)

// Das aktuelle Verzeichnis merken
ls_OldDir = GetCurrentDirectory()

// Das aktuelle Verzeichnis auf den Pfad der Datei festlegen
ChangeDirectory(ls_Path)

// Die Datei $$HEX1$$d600$$ENDHEX$$ffnen
ll_FileHandle = OpenFile(ls_FileName, lstr_OpenFile, OPEN_STYLE_READWRITE)

// File Time Variable je nach File Time Typ setzen
choose case as_type
	case FILE_TIME_TYPE_CREATE
		if of_ConvertFileTimeFromPB(lstr_FileDateTimeCreate, Date(adt_NewFileDateTime), Time(adt_NewFileDateTime)) <> 0 then return -1
	case FILE_TIME_TYPE_ACCESS
		if of_ConvertFileTimeFromPB(lstr_FileDateTimeAccess, Date(adt_NewFileDateTime), Time(adt_NewFileDateTime)) <> 0 then return -1
	case FILE_TIME_TYPE_WRITE
		if of_ConvertFileTimeFromPB(lstr_FileDateTimeWrite, Date(adt_NewFileDateTime), Time(adt_NewFileDateTime)) <> 0 then return -1
end choose

// File Time der Datei setzen
if not SetFileTime(ll_FileHandle, lstr_FileDateTimeCreate, lstr_FileDateTimeAccess, lstr_FileDateTimeWrite) then return -1

// Datei Handle schlie$$HEX1$$df00$$ENDHEX$$en
CloseHandle(ll_FileHandle)

// Das urspr$$HEX1$$fc00$$ENDHEX$$ngliche Verzeichnis wieder herstellen
ChangeDirectory(ls_OldDir)

return 0
end function

public function integer of_set_file_last_write_time (string as_file, datetime adt_newfiledatetime);return of_set_file_time(as_File, adt_NewFileDateTime, FILE_TIME_TYPE_WRITE)
end function

public function integer of_set_file_last_access_time (string as_file, datetime adt_newfiledatetime);return of_set_file_time(as_File, adt_NewFileDateTime, FILE_TIME_TYPE_ACCESS)
end function

public function integer of_set_file_creation_time (string as_file, datetime adt_newfiledatetime);return of_set_file_time(as_File, adt_NewFileDateTime, FILE_TIME_TYPE_CREATE)
end function

public function integer of_delete_dir (string as_dir);/*
* Autor  : Dirk Bunk
* Datum  : 28.06.2011
*
* Argument(e):
*   as_dir Das Verzeichnis (Pfad + Verzeichnisname), das gel$$HEX1$$f600$$ENDHEX$$scht werden soll
*
* Beschreibung: L$$HEX1$$f600$$ENDHEX$$scht ein Verzeichnis (Inklusive aller Unterordner und Dateien)	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    28.06.2011    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

string sSubFolder
string sCurDir
integer i
integer iRet
str_findresult strFindResult[]

// Aktuelles Verzeichnis merken
sCurDir = GetCurrentDirectory()
if ChangeDirectory(as_dir) = 1 then
	iRet = 0
else
	iRet = -1
end if

// Verzeichnis auslesen
of_dirlist(as_dir + "\*.*", FILE_TYPE_ALL, strFindResult)

// Dateiliste durchgehen
for i = 1 to UpperBound(strFindResult)
	// Bei Fehler abbruch
	if iRet <> 0 then exit
	
	// Das Root-Verzeichnis wird $$HEX1$$fc00$$ENDHEX$$bersprungen
	if(strFindResult[i].sFilename = "[..]") then continue
	
	// Wenn es sich um ein Unterverzeichnis handelt, rufen wir die Funktion rekursiv auf
	if(strFindResult[i].bSubdirectory) then
		sSubFolder = strFindResult[i].sFilename
		sSubFolder = of_replace_all(sSubFolder, "[", "")
		sSubFolder = of_replace_all(sSubFolder, "]", "")
		
		iRet = of_delete_dir(as_dir + "\" + sSubFolder)
	else
		// Normale Dateien l$$HEX1$$f600$$ENDHEX$$schen
		if FileDelete(as_dir + "\" + strFindResult[i].sFilename) = true then
			iRet = 0
		else
			iRet = -1
		end if
	end if
next

// Das Verzeichnis l$$HEX1$$f600$$ENDHEX$$schen (Muss leer sein und darf nicht das aktuelle Verzeichnis sein
if iRet = 0 then
	ChangeDirectory("..")
	if RemoveDirectory(as_dir) = 1 then
		iRet = 0
	else
		iRet = -1
	end if
end if

// Das Ursprungsverzeichnis wieder als aktuelles Verzeichnis setzen
ChangeDirectory(sCurDir)

return iRet
end function

public function long of_dirlist (string sfilespec, long lfiletype, ref str_findresult strresult[]);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  of_Dir
//	Arguments:		sFileSpec				The file spec. to list (including wildcards); an
//													absolute path may be specified or it will
//													be relative to the current working directory
//						lFileType				A number representing one or more types of files
//													to include in the list, see PowerBuilder Help on
//													the DirList listbox function for an explanation.
//						anv_DirList[]			An array of n_cst_dirattrib structure whichl will contain
//													the results, passed by reference.
//	Returns:			Long
//						The number of elements in anv_DirList if successful, -1 if an error occurrs.
//	Description:	List the contents of a directory (Name, Date, Time, and Size).
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	Version
//						5.0   		Initial version
//						5.0.03		Changed long variables to Ulong for NT4.0 compatibility
//						7.0			Changed return datatype from int to long
//									Changed li_Cnt, li_Entries from int to long
//						7.0.02 	Changed datatype of lul_handle to long lhandle
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
boolean					bFound
char					cDrive
long					lCnt, lEntries
long					lhandle
time					tTime
win32_find_data			strFindData
//n_cst_dirattrib		lnv_Empty[]
//n_cst_numerical		lnv_Numeric

// Empty the result array
//anv_DirList = lnv_Empty

// List the entries in the directory
lhandle = FindFirstFile(sFileSpec, strFindData)

If lhandle <= 0 Then Return -1

Do
	// Feststellen, on die Datei genommen werden soll
	If of_IncludeFile(String(strFindData.cfilename), lFileType, strFindData.dwFileAttributes) Then
		
		// In's Array damit
		lEntries ++
		strResult[lEntries].sFileName = strFindData.cfilename
		strResult[lEntries].sAltFileName = strFindData.calternatefilename
		If Trim(strResult[lEntries].sAltFileName) = "" Then
			strResult[lEntries].sAltFileName = strResult[lEntries].sFileName
		End If

		// -----------------------------------------------------
		// Datum und Uhrzeit ermitteln
		// -----------------------------------------------------
		of_ConvertFileTimeToPB(strFindData.ftcreationtime, strResult[lEntries].dCreationDate, &
		strResult[lEntries].tCreationTime)
													
		of_ConvertFileTimeToPB(strFindData.ftLastWriteTime, strResult[lEntries].dWriteDate, &
		strResult[lEntries].tWriteTime)

		// Calculate file size
		strResult[lEntries].lFileSize = (strFindData.nFileSizeHigh * (2.0 ^ 32))  + strFindData.nFileSizeLow
		
		// -----------------------------------------------------
		// Dateiattribute
		// -----------------------------------------------------
		strResult[lEntries].bReadOnly = of_getbit(strFindData.dwfileattributes, 1)
		strResult[lEntries].bHidden = of_getbit(strFindData.dwfileattributes, 2)
		strResult[lEntries].bSystem = of_getbit(strFindData.dwfileattributes, 3)
		strResult[lEntries].bSubDirectory = of_getbit(strFindData.dwfileattributes, 5)
		strResult[lEntries].bArchive = of_getbit(strFindData.dwfileattributes, 6)
		strResult[lEntries].bDrive = False
		// -----------------------------------------------------
		// Unterverzeichnisse markieren
		// -----------------------------------------------------
		If strResult[lEntries].bSubDirectory Then
			strResult[lEntries].sFileName = "[" + strResult[lEntries].sFileName + "]"
			strResult[lEntries].sAltFileName = "[" + strResult[lEntries].sAltFileName + "]"
		End If
	End If

	bFound = FindNextFile(lhandle, strFindData)
Loop Until Not bFound

FindClose(lhandle)

//
//// Add the drives if desired.
//// If the type is > 32768 this was to prevent read-write files from being included.
//If lFileType >=32768 Then lFileType = lFileType - 32768
//
//// If the type is > 16384, then a list of drives should be included
//If lFileType >= 16384 Then
//	For lCnt = 0 To 25
//		cDrive = Char(lCnt + 97)
//		If of_GetDriveType(cDrive) > 1 Then
//			lEntries ++
//			anv_DirList[lEntries].is_FileName = "[-" + cDrive + "-]"
//			anv_DirList[lEntries].is_AltFileName = anv_DirList[lEntries].is_FileName
//			anv_DirList[lEntries].ib_ReadOnly = False
//			anv_DirList[lEntries].ib_Hidden = False
//			anv_DirList[lEntries].ib_System = False
//			anv_DirList[lEntries].ib_SubDirectory = False
//			anv_DirList[lEntries].ib_Archive = False
//			anv_DirList[lEntries].ib_Drive = True
//		End if
//	Next
//End if

Return lEntries
end function

public function long of_get_subfolders (string as_dir, ref string as_subfolders[]);str_FindResult lstr_Folders[]
string ls_Empty[]
string ls_SubFolder
long i, ll_SubFolderCount

as_SubFolders = ls_Empty

If Right(as_dir, 1) <> "\" Then as_dir += "\"

If of_DirList(as_dir + "*", FILE_TYPE_DIRECTORY, lstr_Folders) > 0 Then
	For i = 1 To UpperBound(lstr_Folders)
		If lstr_Folders[i].bsubDirectory Then
			ls_SubFolder = lstr_Folders[i].sfileName
			
			// Folders will always be enclosed in brackets like this: [FOLDER]
			ls_SubFolder = Mid(ls_SubFolder, 2, Len(ls_SubFolder) - 2)
			
			If ls_SubFolder <> "." And ls_SubFolder <> ".." Then 
				as_SubFolders[UpperBound(as_SubFolders) + 1] = ls_SubFolder
				ll_SubFolderCount++
			End If
		End If
	Next
End If

Return ll_SubFolderCount
end function

on uo_files.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_files.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

