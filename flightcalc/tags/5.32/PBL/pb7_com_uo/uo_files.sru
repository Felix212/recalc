HA$PBExportHeader$uo_files.sru
$PBExportComments$Userobjekt zur Bearbeitung der Dateiattribute
forward
global type uo_files from nonvisualobject
end type
end forward

global type uo_files from nonvisualobject
end type
global uo_files uo_files

type prototypes
//// Win32 calls for file date and time
//Function long OpenFile (ref string filename, ref os_fileopeninfo of_struct, ulong action) LIBRARY "KERNEL32.DLL"
//Function boolean CloseHandle (long file_hand) LIBRARY "KERNEL32.DLL"
//Function boolean GetFileTime(long hFile, ref os_filedatetime  lpCreationTime, ref os_filedatetime  lpLastAccessTime, ref os_filedatetime  lpLastWriteTime  )  library "KERNEL32.DLL"
Function boolean FileTimeToSystemTime(ref str_filedatetime lpFileTime, ref str_systemtime lpSystemTime) library "KERNEL32.DLL" alias for "FileTimeToSystemTime;Ansi"
Function boolean FileTimeToLocalFileTime(ref str_filedatetime lpFileTime, ref str_filedatetime lpLocalFileTime) library "KERNEL32.DLL" alias for "FileTimeToLocalFileTime;Ansi"
//Function boolean SetFileTime(long hFile, os_filedatetime  lpCreationTime, os_filedatetime  lpLastAccessTime, os_filedatetime  lpLastWriteTime  )  library "KERNEL32.DLL"
Function boolean SystemTimeToFileTime(str_systemtime lpSystemTime, ref str_filedatetime lpFileTime) library "KERNEL32.DLL" alias for "SystemTimeToFileTime;Ansi"
Function boolean LocalFileTimeToFileTime(ref str_filedatetime lpLocalFileTime, ref str_filedatetime lpFileTime) library "KERNEL32.DLL" alias for "LocalFileTimeToFileTime;Ansi"
Function long FindFirstFileA (ref string filename, ref str_finddata findfiledata) library "KERNEL32.DLL" alias for "FindFirstFileA;Ansi"
Function boolean FindNextFileA (long handle, ref str_finddata findfiledata) library "KERNEL32.DLL" alias for "FindNextFileA;Ansi"
Function boolean FindClose (long handle) library "KERNEL32.DLL"
end prototypes

type variables
PUBLIC:
string sErrorMessage

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
constant ulong FILE_TYPE_COMPRESSED =  2048 // Compressed files
constant ulong FILE_TYPE_DRIVE      = 16384 // Drives
constant ulong FILE_TYPE_EXCLUDE    = 32768 // Exclude read/write files from the list

constant ulong FILE_TYPE_ALL = FILE_TYPE_READWRITE + FILE_TYPE_READONLY + FILE_TYPE_HIDDEN + FILE_TYPE_SYSTEM &
									  + FILE_TYPE_DIRECTORY + FILE_TYPE_ARCHIVE + FILE_TYPE_NORMAL + FILE_TYPE_COMPRESSED
end variables

forward prototypes
public function boolean of_getbit (long lDecimal, unsignedinteger ibit)
public function boolean of_includefile (string sfilename, long lattribmask, unsignedlong ulfileattrib)
public function integer of_convertfiledatetimetopb (str_filedatetime strfiletime, ref date dfiledate, ref time tfiletime)
public function long of_dirlist (string sfilespec, long lfiletype, ref str_findresult strresult[])
public function long of_bitwiseand (long lvalue1, long lvalue2)
public function boolean of_zipfile (string sfilenames[], string sarchivename, boolean bdelete)
public function integer of_delete_dir (string as_dir)
end prototypes

public function boolean of_getbit (long lDecimal, unsignedinteger ibit);//	Arguments:
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

public function boolean of_includefile (string sfilename, long lattribmask, unsignedlong ulfileattrib);boolean				bReadWrite


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

public function integer of_convertfiledatetimetopb (str_filedatetime strfiletime, ref date dfiledate, ref time tfiletime);string				sTime
str_filedatetime	strLocalTime
str_systemtime		strSystemTime

If Not FileTimeToLocalFileTime(strFileTime, strLocalTime) Then Return -1

If Not FileTimeToSystemTime(strLocalTime, strSystemTime) Then Return -1

dFileDate = Date(strSystemTime.ui_wyear, strSystemTime.ui_WMonth, strSystemTime.ui_WDay)

sTime   = String(strSystemTime.ui_wHour) + ":" + &
			 String(strSystemTime.ui_wMinute) + ":" + &
			 String(strSystemTime.ui_wSecond) + ":" + &
			 String(strSystemTime.ui_wMilliseconds)
tFileTime = Time(sTime)

Return 1


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
str_finddata			strFindData
//n_cst_dirattrib		lnv_Empty[]
//n_cst_numerical		lnv_Numeric

// Empty the result array
//anv_DirList = lnv_Empty

// List the entries in the directory
lhandle = FindFirstFileA(sFileSpec, strFindData)

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
		of_ConvertFileDatetimeToPB(strFindData.ftcreationtime, strResult[lEntries].dCreationDate, &
													strResult[lEntries].tCreationTime)
													
		of_ConvertFileDatetimeToPB(strFindData.ftLastWriteTime, strResult[lEntries].dWriteDate, &
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

	bFound = FindNextFileA(lhandle, strFindData)
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

public function long of_bitwiseand (long lvalue1, long lvalue2);Integer		iCnt
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

public function boolean of_zipfile (string sfilenames[], string sarchivename, boolean bdelete);integer iRet
uo_zip uoZip
uoZip = CREATE uo_zip

iRet = uoZip.of_zip(sfilenames, sarchivename, bdelete, true, false)

DESTROY uo_zip

if iRet = 0 then 
	return true
else
	return false
end if
end function

public function integer of_delete_dir (string as_dir);/*
* Objekt : uo_files
* Methode: of_delete_dir (Function)
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
str_findresult strresult[]

//Aktuelles Verzeichnis merken
sCurDir = GetCurrentDirectory()
if ChangeDirectory(as_dir) = 1 then
	iRet = 0
else
	iRet = -1
end if

//Verzeichnis auslesen
of_dirlist(as_dir + "\*.*", FILE_TYPE_ALL, strresult)

//Dateiliste durchgehen
for i = 1 to UpperBound(strresult)
	//Bei Fehler abbruch
	if iRet <> 0 then exit
	
	//Das Root-Verzeichnis wird $$HEX1$$fc00$$ENDHEX$$bersprungen
	if(strresult[i].sFilename = "[..]") then continue
	
	//Wenn es sich um ein Unterverzeichnis handelt, rufen wir die Funktion rekursiv auf
	if(strresult[i].bSubdirectory) then
		sSubFolder = strresult[i].sFilename
		sSubFolder = f_replace(sSubFolder, "[", "")
		sSubFolder = f_replace(sSubFolder, "]", "")
		
		iRet = of_delete_dir(as_dir + "\" + sSubFolder)
	else
		//Normale Dateien l$$HEX1$$f600$$ENDHEX$$schen
		if FileDelete(as_dir + "\" + strresult[i].sFilename) = true then
			iRet = 0
		else
			iRet = -1
		end if
	end if
next

//Das Verzeichnis l$$HEX1$$f600$$ENDHEX$$schen (Muss leer sein und darf nicht das aktuelle Verzeichnis sein
if iRet = 0 then
	ChangeDirectory("..")
	if RemoveDirectory(as_dir) = 1 then
		iRet = 0
	else
		iRet = -1
	end if
end if

//Das Ursprungsverzeichnis wieder als aktuelles Verzeichnis setzen
ChangeDirectory(sCurDir)

return iRet
end function

on uo_files.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_files.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

