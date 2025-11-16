HA$PBExportHeader$uo_zip_zlib.sru
$PBExportComments$Zip-Funktionalit$$HEX1$$e400$$ENDHEX$$ten (Nutzt Zlib)
forward
global type uo_zip_zlib from nonvisualobject
end type
type filetime from structure within uo_zip_zlib
end type
type win32_find_data from structure within uo_zip_zlib
end type
type systemtime from structure within uo_zip_zlib
end type
type tm_unz from structure within uo_zip_zlib
end type
type unz_fileinfo from structure within uo_zip_zlib
end type
type shfileinfo from structure within uo_zip_zlib
end type
type zip_fileinfo from structure within uo_zip_zlib
end type
type zip_directo from structure within uo_zip_zlib
end type
end forward

type filetime from structure
	unsignedlong		dwlowdatetime
	unsignedlong		dwhighdatetime
end type

type win32_find_data from structure
	unsignedlong		dwfileattributes
	filetime		ftcreationtime
	filetime		ftlastaccesstime
	filetime		ftlastwritetime
	unsignedlong		nfilesizehigh
	unsignedlong		nfilesizelow
	unsignedlong		dwreserved0
	unsignedlong		dwreserved1
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

type tm_unz from structure
	unsignedinteger		tm_sec
	unsignedinteger		tm_gap1
	unsignedinteger		tm_min
	unsignedinteger		tm_gap2
	unsignedinteger		tm_hour
	unsignedinteger		tm_gap3
	unsignedinteger		tm_mday
	unsignedinteger		tm_gap4
	unsignedinteger		tm_mon
	unsignedinteger		tm_gap5
	unsignedinteger		tm_year
	unsignedinteger		tm_gap6
end type

type unz_fileinfo from structure
	unsignedlong		version
	unsignedlong		version_needed
	unsignedlong		flag
	unsignedlong		compression_method
	unsignedlong		dosdate
	unsignedlong		crc
	unsignedlong		compressed_size
	unsignedlong		uncompressed_size
	unsignedlong		size_filename
	unsignedlong		size_file_extra
	unsignedlong		size_file_comment
	unsignedlong		disk_num_start
	unsignedlong		internal_fa
	unsignedlong		external_fa
	tm_unz		tmu_date
end type

type shfileinfo from structure
	long		hicon
	long		iicon
	long		dwattributes
	character		szdisplayname[260]
	character		sztypename[80]
end type

type zip_fileinfo from structure
	tm_unz		tmz_date
	unsignedlong		dos_date
	unsignedlong		internal_fa
	unsignedlong		external_fa
end type

global type uo_zip_zlib from nonvisualobject
end type
global uo_zip_zlib uo_zip_zlib

type prototypes
PRIVATE:
// ZLib API Funktionen
function ulong crc32 (ulong crc, ref blob buf, long len) library "zlibwapi.dll"
function string zlibVersion () library "zlibwapi.dll" alias for "zlibVersion;Ansi"
function ulong compressBound (ulong sourceLen) library "zlibwapi.dll"
function integer compress (ref blob dest, ref ulong destLen, ref blob src, ulong srcLen) library "zlibwapi.dll"
function integer compress2 (ref blob dest, ref ulong destLen, ref blob src, ulong srcLen, ulong level) library "zlibwapi.dll"
function integer uncompress (ref blob dest, ref ulong destLen, ref blob src, ulong srcLen) library "zlibwapi.dll"
function ulong unzOpen (string filename) library "zlibwapi.dll" alias for "unzOpen;Ansi"
function integer unzClose (ulong unzFile) library "zlibwapi.dll"
function integer unzGetGlobalComment (ulong unzFile, ref string szComment, ulong uSizeBuf) library "zlibwapi.dll" alias for "unzGetGlobalComment;Ansi"
function integer unzGoToFirstFile (ulong unzFile) library "zlibwapi.dll"
function integer unzGoToNextFile (ulong unzFile) library "zlibwapi.dll"
function integer unzGetCurrentFileInfo (ulong unzFile, ref unz_fileinfo file_info, ref string szFileName, ulong filenamesize, ref ulong extrafield, ulong extrasize, ref string comment, ulong cmtsize) library "zlibwapi.dll" alias for "unzGetCurrentFileInfo;Ansi"
function integer unzLocateFile (ulong unzFile, string szFileName, int iCase) library "zlibwapi.dll" alias for "unzLocateFile;Ansi"
function integer unzOpenCurrentFile (ulong unzFile) library "zlibwapi.dll"
function integer unzCloseCurrentFile (ulong unzFile) library "zlibwapi.dll"
function integer unzReadCurrentFile (ulong unzFile, ref blob data, ulong dataLen) library "zlibwapi.dll"
function integer unzOpenCurrentFilePassword (ulong unzFile, ref string password) library "zlibwapi.dll" alias for "unzOpenCurrentFilePassword;Ansi"
function ulong zipOpen (ref string filename, int append) library "zlibwapi.dll" alias for "zipOpen;Ansi"
function integer zipClose (ulong zipFile, ref string szComment) library "zlibwapi.dll" alias for "zipClose;Ansi"
function integer zipOpenNewFileInZip (ulong file, ref string filename, ref zip_fileinfo zipfi, ref ulong extrafield_local, uint size_extrafield_local, ref ulong extrafield_global, uint size_extrafield_global, ref string comment, int method, int level) library "zlibwapi.dll" alias for "zipOpenNewFileInZip;Ansi"
function integer zipOpenNewFileInZip3 (ulong file, ref string filename, ref zip_fileinfo zipfi, ref ulong extrafield_local, uint size_extrafield_local, ref ulong extrafield_global, uint size_extrafield_global, ref string comment, int method, int level, int raw, int windowBits, int memLevel, int strategy, ref string password, ulong crcForCrypting) library "zlibwapi.dll" alias for "zipOpenNewFileInZip3;Ansi"
function integer zipWriteInFileInZip (ulong zipFile, ref blob buffer, long uSizeBuf) library "zlibwapi.dll"
function integer zipCloseFileInZip (ulong zipFile) library "zlibwapi.dll"

// WIN API Funktionen
function boolean CreateDirectory(string lpPathName, ulong lpSecurityAttributes) library "kernel32.dll" alias for "CreateDirectoryW"
function long CreateFile (string lpFileName, ulong dwDesiredAccess, ulong dwShareMode, ulong lpSecurityAttributes, ulong dwCreationDisposition, ulong dwFlagsAndAttributes, ulong hTemplateFile) library "kernel32.dll" alias for "CreateFileW"
function boolean ReadFile (long hFile, ref blob lpBuffer, ulong nNumberOfBytesToRead, ref ulong lpNumberOfBytesRead, ulong lpOverlapped) library "kernel32.dll"
function boolean WriteFile (long hFile, blob lpBuffer, ulong nNumberOfBytesToWrite, ref ulong lpNumberOfBytesWritten, ulong lpOverlapped) library "kernel32.dll"
function boolean CloseHandle (long hObject) library "kernel32.dll"
function long FindFirstFile (ref string filename, ref win32_find_data findfiledata) library "kernel32.dll" alias for "FindFirstFileW"
function boolean FindNextFile (ulong handle, ref win32_find_data findfiledata) library "kernel32.dll" alias for "FindNextFileW"
function boolean FindClose (ulong handle) library "kernel32.dll" alias for "FindClose"
function boolean FileTimeToLocalFileTime (ref filetime lpFileTime, ref filetime lpLocalFileTime) library "kernel32.dll" alias for "FileTimeToLocalFileTime"
function boolean FileTimeToSystemTime (ref filetime lpFileTime, ref systemtime lpSystemTime) library "kernel32.dll" alias for "FileTimeToSystemTime"
subroutine CopyMemory (ref blob Destination, ulong Source, long Length) library  "kernel32.dll" alias for "RtlMoveMemory"
function long FindMimeFromData (ulong pBC, string pwzUrl, blob pBuffer, ulong cbSize, ulong pwzMimeProposed, ulong dwMimeFlags, ref ulong ppwzMimeOut, ulong dwReserved) library "urlmon.dll"
function ulong SHGetFileInfo (string pszPath, long dwFileAttributes, ref shfileinfo psfi, long cbFileInfo, long uFlags) library "shell32.dll" alias for "SHGetFileInfoW"
end prototypes

type variables
/////////////
// HINWEIS //
/////////////
//
// Diese Zip-Implementierung sollte nie direkt verwendet werden,
// sondern immer $$HEX1$$fc00$$ENDHEX$$ber die Wrapper-Klasse uo_zip.

////////////////////////////////////////////////////////////////////////////////////////
// Viele der verwendeten Konstanten sind zu finden unter: http://zlib.net/manual.html //
////////////////////////////////////////////////////////////////////////////////////////

PUBLIC:
// Komprimierungsstufen
constant integer Z_NO_COMPRESSION		= 0
constant integer Z_BEST_SPEED				= 1
constant integer Z_BEST_COMPRESSION		= 9
constant integer Z_DEFAULT_COMPRESSION	= -1

PRIVATE:
string is_LastError = ""
string is_Password = ""
integer ii_CompressionLevel = Z_DEFAULT_COMPRESSION

// Verschiedene ZipOpen Append-Konstanten
constant integer Z_APPEND_STATUS_CREATE      = 0
constant integer Z_APPEND_STATUS_CREATEAFTER = 1
constant integer Z_APPEND_STATUS_ADDINZIP    = 2

// R$$HEX1$$fc00$$ENDHEX$$ckgabewerte f$$HEX1$$fc00$$ENDHEX$$r die Komprimierungs/Dekomprimierungsfunktionen
constant integer Z_OK				= 0
constant integer Z_STREAM_END		= 1
constant integer Z_NEED_DICT		= 2
constant integer Z_ERRNO			= -1
constant integer Z_STREAM_ERROR	= -2
constant integer Z_DATA_ERROR		= -3
constant integer Z_MEM_ERROR		= -4
constant integer Z_BUF_ERROR		= -5
constant integer Z_VERSION_ERROR	= -6

// Komprimierungsstrategie
constant integer Z_FILTERED			= 1
constant integer Z_HUFFMAN_ONLY		= 2
constant integer Z_RLE					= 3
constant integer Z_FIXED				= 4
constant integer Z_DEFAULT_STRATEGY	= 0

// M$$HEX1$$f600$$ENDHEX$$gliche Werte des data_type Feldes
constant integer Z_BINARY	= 0
constant integer Z_TEXT		= 1
constant integer Z_ASCII	= Z_TEXT
constant integer Z_UNKNOWN	= 2

// Die "deflate" Komprimierungsmethode (Nur diese wird in dieser Version unterst$$HEX1$$fc00$$ENDHEX$$tzt)
constant integer Z_DEFLATED = 8

// Unzip Konstanten
constant integer UNZ_OK							= 0
constant integer UNZ_END_OF_LIST_OF_FILE	= -100
constant integer UNZ_ERRNO						= Z_ERRNO
constant integer UNZ_EOF						= 0
constant integer UNZ_PARAMERROR				= -102
constant integer UNZ_BADZIPFILE				= -103
constant integer UNZ_INTERNALERROR			= -104
constant integer UNZ_CRCERROR					= -105

// Zip Konstanten
constant integer ZIP_OK					= 0
constant integer ZIP_ERRNO				= Z_ERRNO
constant integer ZIP_PARAMERROR		= -102
constant integer ZIP_INTERNALERROR	= -104

// Utility Konstanten
constant integer DEF_MEM_LEVEL = 8
constant integer MAX_WBITS = 15

// Konstanten f$$HEX1$$fc00$$ENDHEX$$r die CreateFile API Funktion
constant long INVALID_HANDLE_VALUE = -1
constant ulong GENERIC_READ		= 2147483648
constant ulong GENERIC_WRITE		= 1073741824
constant ulong FILE_SHARE_READ	= 1
constant ulong FILE_SHARE_WRITE	= 2
constant ulong CREATE_NEW			= 1
constant ulong CREATE_ALWAYS		= 2
constant ulong OPEN_EXISTING		= 3
constant ulong OPEN_ALWAYS			= 4
constant ulong TRUNCATE_EXISTING = 5
end variables

forward prototypes
public function integer of_zip (string as_filenames[], string as_archivename, boolean ab_delete, boolean ab_preservepaths, boolean ab_processsubfolders)
public function integer of_unzip (string as_filenames[], string as_archivename, string as_targetpath, boolean ab_delete, boolean ab_preservepaths, boolean ab_processsubfolders)
public function string of_get_last_error ()
public subroutine of_set_password (string as_password)
public subroutine of_set_compression_level (integer ai_compressionlevel)
public function integer of_unzip_blob (ref blob ab_data)
public function integer of_zip_blob (ref blob ab_data)
private function integer of_internal_fa (string as_filename)
private function string of_zlib_version ()
private function integer of_zip_write_in_file_in_zip (unsignedlong aul_zipfile, ref blob ablob_data)
private function integer of_zip_open_new_file_in_zip (unsignedlong aul_zipfile, string as_filename, string as_nameinzip)
private function integer of_zip_close_file_in_zip (unsignedlong aul_zipfile)
private function integer of_import_file (unsignedlong aul_zipfile, string as_filename, string as_nameinzip)
private function string of_replace_all (string as_oldstring, string as_findstr, string as_replace)
private function boolean of_read_file (string as_filename, ref blob ablob_data)
private function unsignedlong of_get_file_crc (string as_filename)
private function string of_find_mime_from_data (string as_filename, ref blob ablob_data)
private function boolean of_check_bit (unsignedlong aul_number, unsignedinteger ai_bit)
private function integer of_create_folder (string as_path)
private function integer of_import_folder (unsignedlong aul_zipfile, string as_foldername, string as_nameinzip)
private subroutine of_collect_zip_content (ref string as_filestoprocess[], ref string as_folderstoprocess[], string as_folder, string as_pattern, boolean ab_processsubfolders)
private subroutine of_collect_unzip_content (unsignedlong aul_unzfile, ref string as_filestoprocess[], ref string as_folderstoprocess[], string as_folder, string as_pattern, boolean ab_processsubfolders)
private function string of_get_file_description (string as_filename)
private function integer of_unz_get_current_file_info (unsignedlong aul_unzfile, ref string as_fullname, ref string as_name, ref string as_path, ref unsignedlong aul_usize, ref unsignedlong aul_csize, ref datetime adt_datetime, ref boolean ab_password, ref boolean ab_readonly, ref boolean ab_hidden, ref boolean ab_system, ref boolean ab_subdir, ref boolean ab_archive)
private function integer of_unz_go_to_first_file (unsignedlong aul_unzfile)
private function integer of_unz_go_to_next_file (unsignedlong aul_unzfile)
private function integer of_extract_file (unsignedlong aul_unzfile, string as_filename, string as_nameinzip)
private function boolean of_current_file_has_password (unsignedlong aul_unzfile)
public function integer of_unzip (string as_archivename, string as_targetpath)
public function integer of_zip (string as_filenames[], string as_archivename)
public function string of_directory (string as_filename, boolean ab_subdir)
end prototypes

public function integer of_zip (string as_filenames[], string as_archivename, boolean ab_delete, boolean ab_preservepaths, boolean ab_processsubfolders);/*
* Objekt : uo_zip
* Methode: of_zip (Function)
* Autor  : Dirk Bunk
* Datum  : 16.06.2011
*
* Argument(e):
*   as_filenames[]          Ein Array mit Dateinamen, die gepackt werden sollen. (Wildcards sind m$$HEX1$$f600$$ENDHEX$$glich)
*   as_archivename          Der Name der Zip-Datei, die erstellt werden soll.
*   ab_delete               Gibt an, ob die Dateien nach dem packen gel$$HEX1$$f600$$ENDHEX$$scht werden sollen.
*   ab_preservepaths        Gibt an, ob die Verzeichnisstruktur beibehalten werden soll.
*   ab_processsubfolders    Gibt an, ob auch Unterverzeichnisse durchsucht werden sollen.
*
* Beschreibung: Packt Dateien in eine Zip-Datei.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    16.06.2011    Erstellung
*   1.1        Dirk Bunk    28.03.2012    Komprimierungsstufe setzen / Encryption Passwort setzen
*   1.2        Dirk Bunk    10.07.2013    F$$HEX1$$fc00$$ENDHEX$$r Zlib angepasst / Zippt jetzt auch leere Ordner
*   1.3        Dirk Bunk    12.07.2013    Ordner zum Zip-Archiv nur noch hinzuf$$HEX1$$fc00$$ENDHEX$$gen, wenn PreservePaths=true ist
*   1.4        Dirk Bunk    13.02.2014    Dateien zu bestehendem Zip-Archiv hinzuf$$HEX1$$fc00$$ENDHEX$$gen, anstatt es zu $$HEX1$$fc00$$ENDHEX$$berschreiben
*
* Return: 
*   -1  Fehler
*    0  OK
*/

/*
HINWEIS:
Wenn eine Datei zu einem bestehenden Zip-Archiv hinzugef$$HEX1$$fc00$$ENDHEX$$gt wird
und diese Datei bereits existiert, wird sie derzeit zus$$HEX1$$e400$$ENDHEX$$tzlich
eingef$$HEX1$$fc00$$ENDHEX$$gt, da es leider nicht ohne Weiteres m$$HEX1$$f600$$ENDHEX$$glich ist,
Dateien in Zip-Archiven zu ersetzen.
Als Workaround m$$HEX1$$fc00$$ENDHEX$$sste man alle Dateien tempor$$HEX1$$e400$$ENDHEX$$r entpacken und dann
nochmal ohne die doppelten Dateien zippen.
*/

string ls_Pattern, ls_Path, ls_Filename, lsFoldername, ls_Comment
string ls_FilesToProcess[], ls_FoldersToProcess[]
ulong lul_ArchiveHandle
long i
integer li_Ret = 0

// Dateinamen einsammeln
for i = 1 to UpperBound(as_filenames)	
	ls_Path = Mid(as_filenames[i], 0, LastPos(as_filenames[i], "\") - 1)
	ls_Pattern = Mid(as_filenames[i], LastPos(as_filenames[i], "\") + 1)
	of_collect_zip_content(ls_FilesToProcess, ls_FoldersToProcess, ls_Path, ls_Pattern, ab_ProcessSubFolders)
next

// Zip-Datei $$HEX1$$f600$$ENDHEX$$ffnen
if FileExists(as_archivename) then
	lul_ArchiveHandle = zipOpen(as_archivename, Z_APPEND_STATUS_ADDINZIP)
else
	lul_ArchiveHandle = zipOpen(as_archivename, Z_APPEND_STATUS_CREATE)
end if

if lul_ArchiveHandle > 0 then
	// Alle gefundenen Ordner durchgehen und diese zum Zip-Archiv hinzuf$$HEX1$$fc00$$ENDHEX$$gen, wenn gew$$HEX1$$fc00$$ENDHEX$$nscht
	if ab_PreservePaths then
		for i = 1 to UpperBound(ls_FoldersToProcess)
			lsFoldername = of_replace_all(ls_FoldersToProcess[i], ls_Path, "")
			lsFoldername = Mid(lsFoldername, Pos(lsFoldername, "\") + 1)
			
			// Ordner ins Zip-Archiv importieren
			if lsFoldername <> "" then
				if of_import_folder(lul_ArchiveHandle, ls_FoldersToProcess[i], lsFoldername) <> 0 then
					is_LastError = "Failed to import folder: " + lsFoldername
					li_Ret = -1
				end if
			end if
		next
	end if
	
	// Alle gefundenen Dateien durchgehen
	for i = 1 to UpperBound(ls_FilesToProcess)
		if ls_FilesToProcess[i] <> as_archivename then
			// Den Dateinamen, zum Importieren ins Zip-Archiv, anpassen
			if ab_PreservePaths then
				ls_Filename = of_replace_all(ls_FilesToProcess[i], ls_Path, "")
				ls_Filename = Mid(ls_Filename, Pos(ls_Filename, "\") + 1)
			else
				ls_Filename = Mid(ls_FilesToProcess[i], LastPos(ls_FilesToProcess[i], "\") + 1)
			end if
			
			// Datei ins Zip-Archiv importieren
			if ls_Filename <> "" then
				if of_import_file(lul_ArchiveHandle, ls_FilesToProcess[i], ls_Filename) <> 0 then
					is_LastError = "Failed to import file: " + ls_Filename
					li_Ret = -1
				end if
			end if
			
			// Evtl. Datei l$$HEX1$$f600$$ENDHEX$$schen
			if ab_delete then FileDelete(ls_FilesToProcess[i])
		end if
	next
		
	// Zip-Datei schlie$$HEX1$$df00$$ENDHEX$$en
	ls_Comment = "Zip archive created by CBASE!"
	zipClose(lul_ArchiveHandle, ls_Comment)
else
	li_Ret = -1
	is_LastError = "Error in of_zip: Failed to open archive."
end if

return li_Ret
end function

public function integer of_unzip (string as_filenames[], string as_archivename, string as_targetpath, boolean ab_delete, boolean ab_preservepaths, boolean ab_processsubfolders);/*
* Objekt : uo_zip
* Methode: of_unzip (Function)
* Autor  : Dirk Bunk
* Datum  : 16.06.2011
*
* Argument(e):
*   as_filenames[]          Ein Array mit Dateinamen, die entpackt werden sollen. (Wildcards sind m$$HEX1$$f600$$ENDHEX$$glich)
*   as_archivename          Der Pfad+Dateiname der Zip-Datei, die entpackt werden soll.
*   as_targetpath           Das Zielverzeichnis, in das die Dateien entpackt werden sollen.
*   ab_delete               Gibt an, ob die Zip-Datei nach dem entpacken gel$$HEX1$$f600$$ENDHEX$$scht werden soll.
*   ab_preservepaths        Gibt an, ob die Verzeichnisstruktur beibehalten werden soll.
*   ab_processsubfolders    Gibt an, ob auch Unterverzeichnisse durchsucht werden sollen.
*
* Beschreibung: Entpackt eine Zip-Datei in ein Verzeichnis.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    16.06.2011    Erstellung
*   1.1        Dirk Bunk    28.03.2012    Encryption Passwort setzen
*   1.2        Dirk Bunk    11.07.2013    F$$HEX1$$fc00$$ENDHEX$$r Zlib angepasst
*   1.3        Dirk Bunk    31.03.2020    Zielpfad normalisieren
*
* Return: 
*   -1  Fehler
*    0  OK
*/

integer li_Ret = 0
string ls_NameInZip, ls_Filename, ls_Path, ls_Pattern
string ls_FilesToProcess[], ls_FoldersToProcess[]
ulong lul_ArchiveHandle
long i
		
// Zip-Archiv $$HEX1$$f600$$ENDHEX$$ffnen
lul_ArchiveHandle = unzOpen(as_archivename)
If lul_ArchiveHandle > 0 Then
	// Zielpfad normalisieren
	do while (Right(as_targetpath, 1) = "\")
		as_targetpath = Left(as_targetpath, Len(as_targetpath) - 1)
	loop
	
	// Inhalte des Zip-Archivs auslesen
	for i = 1 to UpperBound(as_filenames)	
		ls_Path = Mid(as_Filenames[i], 0, LastPos(as_Filenames[i], "\") - 1)
		ls_Pattern = Mid(as_Filenames[i], LastPos(as_Filenames[i], "\") + 1)
		of_collect_unzip_content(lul_ArchiveHandle, ls_FilesToProcess, ls_FoldersToProcess, ls_Path, ls_Pattern, ab_ProcessSubFolders)
	next
	
	// Im Zip-Archiv enthaltene Ordner anlegen, falls die original Ordnerstruktur beibehalten werden soll
	if ab_preservepaths then
		for i = 1 to UpperBound(ls_FoldersToProcess)
			ls_Path = as_targetpath + "\" + of_replace_all(ls_FoldersToProcess[i], "/", "\")
			of_create_folder(ls_Path)
		next
	end if
	
	// Im Zip-Archiv enthaltene Dateien entpacken
	for i = 1 to UpperBound(ls_FilesToProcess)
		// Dateiname auslesen
		ls_Filename = as_targetpath + "\" + of_replace_all(ls_FilesToProcess[i], "/", "\")
		ls_NameInZip = ls_FilesToProcess[i]
		
		// Wenn die original Ordnerstruktur des Zip-Archivs ignoriert werden soll,
		// muss der Pfad nochmal angepasst werden
		if not ab_preservepaths then
			ls_Filename = as_targetpath + "\" + Mid(ls_Filename, LastPos(ls_Filename, "\") + 1)
		end if
		
		// Datei entpacken
		if of_extract_file(lul_ArchiveHandle, ls_Filename, ls_NameInZip) <> 0 then 
			li_Ret = -1
			is_LastError = "At least one file couldn't be unzipped from Zip-Archive."
		end if
	next
		
	// Zip-Archiv wieder schlie$$HEX1$$df00$$ENDHEX$$en
	unzClose(lul_ArchiveHandle)
	
	// Evtl. das Archiv l$$HEX1$$f600$$ENDHEX$$schen
	if ab_Delete then
		FileDelete(as_ArchiveName)
	end if
else
	li_Ret = -1
	is_LastError = "Error in of_unzip: Failed to open archive."
end If

return li_Ret
end function

public function string of_get_last_error ();/*
* Objekt : uo_zip
* Methode: of_get_last_error (Function)
* Autor  : Dirk Bunk
* Datum  : 17.06.2011
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt die letzte Fehlermeldung zur$$HEX1$$fc00$$ENDHEX$$ck, die aufgetreten ist.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    17.06.2011    Erstellung
*
* Return: 
*   Die letzte Fehlermeldung, die aufgetreten ist.
*/

return is_LastError
end function

public subroutine of_set_password (string as_password);/*
* Objekt : uo_zip
* Methode: of_set_password (Function)
* Autor  : Dirk Bunk
* Datum  : 28.03.2012
*
* Argument(e):
*   as_password    Das Passwort, das gesetzt werden soll
*
* Beschreibung: Setzt ein Passwort, das zum zippen und entzippen verwendet werden soll.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    28.03.2012    Erstellung
*
* Return: 
*   none
*/

is_Password = as_password
end subroutine

public subroutine of_set_compression_level (integer ai_compressionlevel);/*
* Objekt : uo_zip
* Methode: of_set_compression_level (Function)
* Autor  : Dirk Bunk
* Datum  : 03.07.2013
*
* Argument(e):
*   ai_compressionlevel    Die Komprimierungsstufe, die verwendet werden soll
*
* Beschreibung: Legt die St$$HEX1$$e400$$ENDHEX$$rke der Komprimierung fest.
*
* HINWEIS: M$$HEX1$$f600$$ENDHEX$$gliche Werte sind:
*          Z_NO_COMPRESSION
*          Z_BEST_SPEED
*          Z_BEST_COMPRESSION
*          Z_DEFAULT_COMPRESSION
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    03.07.2013    Erstellung
*
* Return: 
*   nichts
*/

ii_CompressionLevel = ai_CompressionLevel
end subroutine

public function integer of_unzip_blob (ref blob ab_data);/*
* Objekt : uo_zip
* Methode: of_unzip_blob (Function)
* Autor  : Dirk Bunk
* Datum  : 28.03.2012
*
* Argument(e):
*   ab_data    Blob, der dekomprimiert werden soll.
*
* Beschreibung: Dekomprimiert einen $$HEX1$$fc00$$ENDHEX$$bergebenen Blob "on the fly".	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    28.03.2012    Erstellung
*   1.1        Dirk Bunk    11.07.2013    F$$HEX1$$fc00$$ENDHEX$$r Zlib angepasst
*
* Return: 
*   -1  Fehler
*    0  OK
*/

integer li_Ret
ulong lul_SrcLen, lul_DestLen
blob lblob_Dest

// Puffer-Platz allokieren. Da wir nicht wissen wie gro$$HEX2$$df002000$$ENDHEX$$der entpackte Blob sein wird,
// nehmen wir erstmal die Eingangsgr$$HEX2$$f600df00$$ENDHEX$$e mal 3 und versuchen es damit
lul_SrcLen = Len(ab_Data)
lul_DestLen = lul_SrcLen * 3

// Den Blob entpacken.
// Wenn nicht gen$$HEX1$$fc00$$ENDHEX$$gend Platz im Zielblob vorhanden ist, 
// nochmal mit einem gr$$HEX2$$f600df00$$ENDHEX$$eren Blob versuchen.
do
	lblob_Dest = Blob(Space(lul_DestLen))
	li_Ret = uncompress(lblob_Dest, lul_DestLen, ab_Data, lul_SrcLen)
	if li_Ret = Z_BUF_ERROR then lul_DestLen += lul_SrcLen
loop while li_Ret = Z_BUF_ERROR

choose case li_Ret
	case Z_OK
		ab_Data = BlobMid(lblob_Dest, 1, lul_DestLen)
	case Z_MEM_ERROR
		is_LastError = "ZLib Error in of_unzip_blob: Not enough memory!"
	case Z_DATA_ERROR
		is_LastError = "ZLib Error in of_unzip_blob: The input data was corrupted!"
	case else
		is_LastError = "ZLib Error in of_unzip_blob: Undefined error: " + String(li_Ret)
end choose

return li_Ret
end function

public function integer of_zip_blob (ref blob ab_data);/*
* Objekt : uo_zip
* Methode: of_zip_blob (Function)
* Autor  : Dirk Bunk
* Datum  : 28.03.2012
*
* Argument(e):
*   ab_data    Blob, der komprimiert werden soll.
*
* Beschreibung: Komprimiert einen $$HEX1$$fc00$$ENDHEX$$bergebenen Blob "on the fly".	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    28.03.2012    Erstellung
*   1.1        Dirk Bunk    11.07.2013    F$$HEX1$$fc00$$ENDHEX$$r Zlib angepasst
*
* Return: 
*   -1  Fehler
*    0  OK
*/

integer li_Ret
ulong lul_SrcLen, lul_DestLen
blob lblob_Dest

// Puffer-Platz allokieren
lul_SrcLen  = Len(ab_data)
lul_DestLen = compressBound(lul_SrcLen)
lblob_Dest = Blob(Space(lul_DestLen))

// Den Blob komprimieren
li_Ret = compress2(lblob_Dest, lul_DestLen, ab_data, lul_SrcLen, ii_CompressionLevel)
choose case li_Ret
	case Z_OK
		ab_data = BlobMid(lblob_Dest, 1, lul_DestLen)
	case Z_MEM_ERROR
		is_LastError = "ZLib Error in of_zip_blob: Not enough memory!"
	case Z_BUF_ERROR
		is_LastError = "ZLib Error in of_zip_blob: Not enough room in the output buffer!"
	case else
		is_LastError = "ZLib Error in of_zip_blob: Undefined error: " + String(li_Ret)
end choose

return li_Ret
end function

private function integer of_internal_fa (string as_filename);/*
* Objekt : uo_zip
* Methode: of_internal_fa (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   as_filename    Der Pfad+Dateiname, der Datei
*
* Beschreibung: Ermittelt die Art einer Datei (Text oder Bin$$HEX1$$e400$$ENDHEX$$r).
*
* HINWEIS: Diese Information dient nur der Dokumentation innerhalb eines Zips.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Roland S.    21.08.2009    Den Dateityp des Dateihandles von ulong auf long ge$$HEX1$$e400$$ENDHEX$$ndert
*   1.2        Dirk Bunk    03.07.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*  2: Unbekannt
*  1: Text
*  0: Bin$$HEX1$$e400$$ENDHEX$$r
*/

long ll_file
ulong lul_bytes
string ls_mime
blob lblob_filedata
boolean lb_result

// Datei lesen $$HEX1$$f600$$ENDHEX$$ffnen
ll_file = CreateFile(as_filename, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0)
if ll_file = INVALID_HANDLE_VALUE then
	return 2
end if

// Puffer-Platz allokieren
lblob_filedata = Blob(Space(256), EncodingAnsi!)

// Die ersten 256 Byte der Datei lesen
lb_result = ReadFile(ll_file, lblob_filedata, 256, lul_bytes, 0)

// Die Datei schlie$$HEX1$$df00$$ENDHEX$$en
CloseHandle(ll_file)

// Den MIME-Type der Datei auslesen
ls_mime = of_find_mime_from_data(as_filename, lblob_filedata)

if Lower(Left(ls_mime, 4)) = "text" then
	return 1
end If

return 0
end function

private function string of_zlib_version ();/*
* Objekt : uo_zip
* Methode: of_zlib_version (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt die Versionsnummer der Zlib Bibliothek zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Dirk Bunk    16.06.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*   Version der Zlib Bibliothek
*/

string ls_version

ls_version = Space(20)
ls_version = zlibVersion()

return ls_version
end function

private function integer of_zip_write_in_file_in_zip (unsignedlong aul_zipfile, ref blob ablob_data);/*
* Objekt : uo_zip
* Methode: of_zip_write_in_file_in_zip (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   aul_ZipFile    Das Handle, des ge$$HEX1$$f600$$ENDHEX$$ffneten Zip-Archivs
*   ablob_Data     Die Daten, die in das Zip-Archiv geschrieben werden sollen
*
* Beschreibung: Schreibt Daten einer Datei in ein ge$$HEX1$$f600$$ENDHEX$$ffnetes Zip-Archiv.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Dirk Bunk    16.06.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_ret
long ll_sizebuf

ll_sizebuf = Len(ablob_data)
li_ret = zipWriteInFileInZip(aul_zipfile, ablob_data, ll_sizebuf)

return li_ret
end function

private function integer of_zip_open_new_file_in_zip (unsignedlong aul_zipfile, string as_filename, string as_nameinzip);/*
* Objekt : uo_zip
* Methode: of_zip_open_new_file_in_zip (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   aul_ZipFile    Das Handle, des ge$$HEX1$$f600$$ENDHEX$$ffneten Zip-Archivs
*   as_Filename    Der Pfad+Name der Datei, die im Zip-Archiv angelegt werden soll
*   as_NameInZip   Der Name der Datei, so wie sie im Zip-Archiv erscheinen soll
*
* Beschreibung: $$HEX1$$d600$$ENDHEX$$ffnet eine neue Datei in einem ge$$HEX1$$f600$$ENDHEX$$ffneten Zip-Archiv.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Roland S.    26.07.2009    Parameter as_NameInZip hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*   1.2        Dirk Bunk    16.06.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_Ret
ulong lul_Handle, lul_null, lul_crc
string ls_cmts, ls_filename
zip_fileinfo lstr_FileInfo
win32_find_data lstr_FindData
filetime lstr_FileTime
systemtime lstr_SystemTime

SetNull(ls_cmts)
SetNull(lul_null)

// Informationen der Datei auslesen
lul_Handle = FindFirstFile(as_filename, lstr_FindData)
if lul_Handle <= 0 then 
	li_Ret = -1
else
	li_Ret = 0
	FindClose(lul_Handle)
end if

if li_Ret = 0 then
	// Datei-Art herausfinden (0: Bin$$HEX1$$e400$$ENDHEX$$r, 1: Text)
	lstr_FileInfo.internal_fa = of_Internal_FA(as_filename)
	
	// Datei-Attribute auslesen (Read-Only, Hidden, System, Archive)
	lstr_FileInfo.external_fa = lstr_FindData.dwfileattributes

	// Datumsformat umrechnen
	FileTimeToLocalFileTime(lstr_FindData.ftlastwritetime, lstr_FileTime)
	FileTimeToSystemTime(lstr_FileTime, lstr_SystemTime)
	
	// Zeitinformationen in Struktur merken
	lstr_FileInfo.tmz_date.tm_mon = lstr_SystemTime.wMonth - 1
	lstr_FileInfo.tmz_date.tm_mday = lstr_SystemTime.wDay
	lstr_FileInfo.tmz_date.tm_year = lstr_SystemTime.wYear
	lstr_FileInfo.tmz_date.tm_hour = lstr_SystemTime.wHour
	lstr_FileInfo.tmz_date.tm_min = lstr_SystemTime.wMinute
	lstr_FileInfo.tmz_date.tm_sec = lstr_SystemTime.wSecond
	
	// Zip-Dateien erwarten "normale" Slashes
	ls_filename = of_replace_all(as_nameinzip, "\", "/")
	
	// Zlib-Funktion aufrufen
	if is_password = "" then
		li_ret = zipOpenNewFileInZip(aul_zipfile, ls_filename, lstr_FileInfo, lul_null, 0, lul_null, 0, &
											  ls_cmts, Z_DEFLATED, ii_CompressionLevel)
	else
		lul_crc = of_get_file_crc(as_filename)
		li_ret = zipOpenNewFileInZip3(aul_zipfile, ls_filename, lstr_FileInfo, lul_null, 0, lul_null, 0, &
												ls_cmts, Z_DEFLATED, ii_CompressionLevel, 0, -MAX_WBITS, DEF_MEM_LEVEL, &
												Z_DEFAULT_STRATEGY, is_password, lul_crc)
	end if
end if

return li_Ret
end function

private function integer of_zip_close_file_in_zip (unsignedlong aul_zipfile);/*
* Objekt : uo_zip
* Methode: of_zip_close_file_in_zip (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   aul_zipfile    Das Handle zum ge$$HEX1$$f600$$ENDHEX$$ffneten Zip-Archiv
*
* Beschreibung: Schlie$$HEX1$$df00$$ENDHEX$$t eine neue Datei in einem ge$$HEX1$$f600$$ENDHEX$$ffneten Zip-Archiv.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Dirk Bunk    16.06.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_ret

li_ret = zipCloseFileInZip(aul_zipfile)

return li_ret
end function

private function integer of_import_file (unsignedlong aul_zipfile, string as_filename, string as_nameinzip);/*
* Objekt : uo_zip
* Methode: of_import_file (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   aul_zipfile     Das Handle, des ge$$HEX1$$f600$$ENDHEX$$ffneten Zip-Archivs
*   as_filename     Der Pfad+Name, der Datei
*   as_nameinzip    Der Pfad+Name, der Datei innerhalb des Zip-Archivs
*
* Beschreibung: F$$HEX1$$fc00$$ENDHEX$$gt eine neue Datei zu einem ge$$HEX1$$f600$$ENDHEX$$ffneten Zip-Archiv hinzu.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Dirk Bunk    03.07.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*  0: OK
* -1: Fehler 
*/

integer li_ret, li_fnum
blob lblob_file

li_fnum = FileOpen(as_filename, StreamMode!, Read!, Shared!)
if li_fnum > 0 then
	li_ret = of_zip_open_new_file_in_zip(aul_zipFile, as_filename, as_nameinzip)
	if li_ret = 0 then
		do while FileRead(li_fnum, lblob_file) > 0
			li_ret = of_zip_write_in_file_in_zip(aul_zipFile, lblob_file)
		loop
		li_ret = of_zip_close_file_in_zip(aul_zipFile)
	end if
	FileClose(li_fnum)
else
	li_ret = -1
end if

return li_ret
end function

private function string of_replace_all (string as_oldstring, string as_findstr, string as_replace);/*
* Objekt : uo_zip
* Methode: of_replace_all (Function)
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

private function boolean of_read_file (string as_filename, ref blob ablob_data);/*
* Objekt : uo_zip
* Methode: of_read_file (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   as_filename    Der Pfad+Dateiname, der Datei
*   ablob_data     Der Inhalt der Datei als Blob (als Referenz $$HEX1$$fc00$$ENDHEX$$bergeben)
*
* Beschreibung: Liest den Inhalt einer Datei in eine Blob-Variable.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Roland S.    21.08.2009    Den Dateityp des Dateihandles von ulong auf long ge$$HEX1$$e400$$ENDHEX$$ndert
*   1.2        Dirk Bunk    03.07.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*    true: OK
*   false: Fehler
*/

long ll_file
ulong lul_bytes, lul_length
blob lblob_filedata
boolean lb_result

// Die Datei lesend $$HEX1$$f600$$ENDHEX$$ffnen
ll_file = CreateFile(as_filename, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0)
if ll_file = INVALID_HANDLE_VALUE then
	return false
end if

// Die Dateigr$$HEX2$$f600df00$$ENDHEX$$e ermitteln
lul_length = FileLength(as_filename)

// Den ben$$HEX1$$f600$$ENDHEX$$tigten Platz im Puffer allokieren
lblob_filedata = Blob(Space(lul_length), EncodingAnsi!)

// Den Inhalt der Datei einlesen
lb_result = ReadFile(ll_file, lblob_filedata, lul_length, lul_bytes, 0)

if lb_result then
	// Den Puffer in den Ausgabeblob kopieren
	ablob_data = BlobMid(lblob_filedata, 1, lul_length)
else
	SetNull(ablob_data)
end if

// Die Datei schlie$$HEX1$$df00$$ENDHEX$$en
CloseHandle(ll_file)

return lb_result
end function

private function unsignedlong of_get_file_crc (string as_filename);/*
* Objekt : uo_zip
* Methode: of_get_file_crc (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   as_filename     Der Pfad+Dateiname, der Datei
*
* Beschreibung: Berechnet den CRC32 Wert einer Datei.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Dirk Bunk    03.07.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*  0: Fehler
* >0: Der CRC32 Wert 
*/

ulong lul_crc, lul_length
blob lblob_buffer

lul_length = FileLength(as_filename)

if of_read_file(as_filename, lblob_buffer) then
	lul_crc = crc32(lul_crc, lblob_buffer, lul_length);
else
	lul_crc = 0
end if

return lul_crc
end function

private function string of_find_mime_from_data (string as_filename, ref blob ablob_data);/*
* Objekt : uo_zip
* Methode: of_find_mime_from_data (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   as_filename    Der Pfad+Dateiname, der Datei
*   ablob_data     Der Inhalt der Datei
*
* Beschreibung: Liest den MIME-Type einer Datei.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Dirk Bunk    03.07.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*   NULL: Fehler
* String: MIME-Type 
*/

string ls_MimeType
blob lblob_Mime
long ll_rtn
ulong lul_ptr

ll_rtn = FindMimeFromData(0, as_Filename, ablob_Data, Len(ablob_Data), 0, 0, lul_ptr, 0)

if ll_rtn = 0 then
	lblob_Mime = Blob(Space(255))
	CopyMemory(lblob_Mime, lul_ptr, 255)
	ls_MimeType = Trim(String(lblob_Mime))
else
	SetNull(ls_MimeType)
end if

return ls_MimeType
end function

private function boolean of_check_bit (unsignedlong aul_number, unsignedinteger ai_bit);/*
* Objekt : uo_zip
* Methode: of_check_bit (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 23.07.2009
*
* Argument(e):
*   aul_number    Die Zahl, die gepr$$HEX1$$fc00$$ENDHEX$$ft werden soll
*   ai_bit        Die Bit-Stelle (Beginnend bei 1)
*
* Beschreibung: Pr$$HEX1$$fc00$$ENDHEX$$ft, ob ein bestimmtes Bit einer Zahl an oder aus ist.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    23.07.2009    Erstellung
*   1.1        Dirk Bunk    03.07.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*  true: Das gesuchte Bit ist an
* false: Das gesuchte Bit ist aus
*/

if Int(Mod(aul_number / (2 ^(ai_bit - 1)), 2)) > 0 then
	return true
end if

return false

end function

private function integer of_create_folder (string as_path);/*
* Objekt : uo_zip
* Methode: of_create_folder (Function)
* Autor  : Dirk Bunk
* Datum  : 16.06.2013
*
* Argument(e):
*   as_Path     Das Verzeichnis mit vorangehendem Pfad, das angelegt werden soll
*
* Beschreibung: Legt ein neues Verzeichnis im angegebenen Pfad an. Falls ein Unterordner nicht vorhanden ist,
*               wird dieser ebenfalls angelegt.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.07.2013    Erstellung
*   1.1        Dirk Bunk    01.09.2014    CreateDirectory funktioniert jetzt auch f$$HEX1$$fc00$$ENDHEX$$r Netzlaufwerke
*
* Return: 
*  0: OK
* -1: Fehler
*/

string ls_Path
integer li_Ret = 0

ls_Path = Mid(as_Path, 1, LastPos(as_Path, "\") - 1)

if not DirectoryExists(ls_Path) then 
	li_Ret = of_create_folder(ls_Path)
end if

if li_Ret = 0 then
	// Pfaderweiterung verwenden (bei Netzlaufwerken hat dies eine andere Syntax)
	// http://msdn.microsoft.com/en-us/library/windows/desktop/aa365247%28v=vs.85%29.aspx#maxpath
	if Left(as_Path, 2) = "\\" then
		CreateDirectory("\\?\UNC\" + Mid(as_Path, 3), 0)
	else
		CreateDirectory("\\?\" + as_Path, 0)
	end if
end if

return li_Ret
end function

private function integer of_import_folder (unsignedlong aul_zipfile, string as_foldername, string as_nameinzip);/*
* Objekt : uo_zip
* Methode: of_import_folder (Function)
* Autor  : Dirk Bunk
* Datum  : 10.07.2013
*
* Argument(e):
*   aul_zipfile     Das Handle, des ge$$HEX1$$f600$$ENDHEX$$ffneten Zip-Archivs
*   as_foldername   Der Pfad+Name, des Ordners
*   as_nameinzip    Der Pfad+Name, des Ordners innerhalb des Zip-Archivs
*
* Beschreibung: F$$HEX1$$fc00$$ENDHEX$$gt einen neuen Ordner zu einem ge$$HEX1$$f600$$ENDHEX$$ffneten Zip-Archiv hinzu.
*
* HINWEIS: Die Funktion f$$HEX1$$fc00$$ENDHEX$$gt nur den Ordner hinzu, keine Dateien oder Unterordner, die sich in ihm befinden!
*          Das wird ben$$HEX1$$f600$$ENDHEX$$tigt, um einen leeren Ordner zum Zip-Archiv hinzuf$$HEX1$$fc00$$ENDHEX$$gen zu k$$HEX1$$f600$$ENDHEX$$nnen.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.07.2013    Erstellung
*
* Return: 
*  0: OK
* -1: Fehler 
*/

integer li_ret

li_ret = of_zip_open_new_file_in_zip(aul_zipFile, as_foldername, as_nameinzip)

return li_ret
end function

private subroutine of_collect_zip_content (ref string as_filestoprocess[], ref string as_folderstoprocess[], string as_folder, string as_pattern, boolean ab_processsubfolders);/*
* Objekt : uo_zip
* Methode: of_collect_zip_content (Function)
* Autor  : Dirk Bunk
* Datum  : 16.06.2013
*
* Argument(e):
*   as_FilesToProcess[]     Ein leeres Array, das mit den gefundenen Dateinamen gef$$HEX1$$fc00$$ENDHEX$$llt wird
*   as_FoldersToProcess[]   Ein leeres Array, das mit den gefundenen Ordnernamen gef$$HEX1$$fc00$$ENDHEX$$llt wird
*   as_folder               Das Verzeichnis, das durchsucht werden soll
*   as_pattern              Ein Pattern, das zum Suchen verwendet werden soll (z.B.: *.pdf)
*   ab_processsubfolders    Gibt an, ob Unterverzeichnisse auch durchsucht werden sollen
*
* Beschreibung: Sucht Dateien in einem Verzeichnis (+Unterverzeichnisse), die einem bestimmten Pattern folgen.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    16.06.2013    Erstellung
*   1.1        Dirk Bunk    04.07.2013    Durchsuchen der Unterverzeichnisse korrigiert
*   1.2        Dirk Bunk    10.07.2013    F$$HEX1$$fc00$$ENDHEX$$llt jetzt auch eine Liste mit Ordnernamen
*   1.3        Dirk Bunk    13.02.2014    Wenn Unterverzeichnisse vorhanden sind, diese auch auf jeden Fall durchsuchen
*
* Return: 
*  nichts
*/

win32_find_data lstr_fd
string ls_Filename
string ls_Subfolders[]
long i, ll_Handle
boolean lb_subdir, lb_AlreadyCollected

//////////////////////////////////////////////////
// Aktuelles Verzeichnis in die Liste aufnehmen //
//////////////////////////////////////////////////

// Pr$$HEX1$$fc00$$ENDHEX$$fen, dass das Verzeichnis nicht bereits eingesammelt wurde
lb_AlreadyCollected = false
for i = 1 to UpperBound(as_FoldersToProcess)
	if as_FoldersToProcess[i] = as_folder then 
		lb_AlreadyCollected = true
		exit
	end if
next

// Verzeichnis zur Liste hinzuf$$HEX1$$fc00$$ENDHEX$$gen
if not lb_AlreadyCollected then
	as_FoldersToProcess[UpperBound(as_FoldersToProcess) + 1] = as_folder
end if

///////////////////////////////////////////////
// Alle Unterverzeichnisse einsammeln,       //
// falls diese auch durchsucht werden sollen //
///////////////////////////////////////////////
if ab_ProcessSubFolders then
	// Alle Dateien des Ordners durchgehen
	ls_Filename = as_folder + "\*.*"
	ll_Handle = FindFirstFile(ls_Filename, lstr_fd)
	
	if ll_Handle > 0 then
		do
			// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob es sich bei dem gefundenen Dateinamen um ein Verzeichnis handelt
			lb_subdir = of_check_bit(lstr_fd.dwFileAttributes, 5)
			if not lb_subdir then continue
			
			// Unterverzeichnis in die Liste eintragen
			ls_Filename = String(lstr_fd.cFilename)
			if ls_Filename = "." or ls_Filename = ".." then continue
			ls_Subfolders[UpperBound(ls_Subfolders) + 1] = as_folder + "\" + ls_Filename
		loop until not FindNextFile(ll_Handle, lstr_fd)
	end if
end if

///////////////////////////////////////////
// Alle Dateien durchgehen,              //
// die dem gesuchten Pattern entsprechen //
///////////////////////////////////////////
ls_Filename = as_folder + "\" + as_pattern
ll_Handle = FindFirstFile(ls_Filename, lstr_fd)

if ll_Handle > 0 then
	do
		// Nur Dateien beachten, Unterverzeichnisse wurden schon eingesammelt
		lb_subdir = of_check_bit(lstr_fd.dwFileAttributes, 5)
		if lb_subdir then continue
		
		// Dateinamen ermitteln
		ls_Filename = String(lstr_fd.cFilename)
		ls_Filename = as_folder + "\" + ls_Filename
		
		// Pr$$HEX1$$fc00$$ENDHEX$$fen, dass die Datei nicht bereits eingesammelt wurde
		lb_AlreadyCollected = false
		for i = 1 to UpperBound(as_FilesToProcess)
			if as_FilesToProcess[i] = ls_Filename then 
				lb_AlreadyCollected = true
				exit
			end if
		next
		
		// Datei zur Liste hinzuf$$HEX1$$fc00$$ENDHEX$$gen
		if not lb_AlreadyCollected then
			as_FilesToProcess[UpperBound(as_FilesToProcess) + 1] = ls_Filename
		end if
	loop until not FindNextFile(ll_Handle, lstr_fd)
end if

// Wenn vorhanden, auch noch alle Unterverzeichnisse durchgehen
for i = 1 to UpperBound(ls_Subfolders)
	of_collect_zip_content(as_FilesToProcess, as_FoldersToProcess, ls_Subfolders[i], as_pattern, ab_ProcessSubFolders)
next
end subroutine

private subroutine of_collect_unzip_content (unsignedlong aul_unzfile, ref string as_filestoprocess[], ref string as_folderstoprocess[], string as_folder, string as_pattern, boolean ab_processsubfolders);/*
* Objekt : uo_zip
* Methode: of_collect_unzip_content (Function)
* Autor  : Dirk Bunk
* Datum  : 11.07.2013
*
* Argument(e):
*   aul_unzfile             Das Handle zum ge$$HEX1$$f600$$ENDHEX$$ffneten Zip-Archiv
*   as_FilesToProcess[]     Ein leeres Array, das mit den gefundenen Dateinamen gef$$HEX1$$fc00$$ENDHEX$$llt wird
*   as_FoldersToProcess[]   Ein leeres Array, das mit den gefundenen Ordnernamen gef$$HEX1$$fc00$$ENDHEX$$llt wird
*   as_folder               Das Verzeichnis im Zip-Archiv, das durchsucht werden soll
*   as_pattern              Ein Pattern, das zum Suchen verwendet werden soll (z.B.: *.pdf)
*   ab_processsubfolders    Gibt an, ob Unterverzeichnisse auch durchsucht werden sollen
*
* Beschreibung: Sucht Dateien innnerhalb eines Verzeichnisses, eines Zip-Archivs (+Unterverzeichnisse), 
*               die einem bestimmten Pattern folgen.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    11.07.2013    Erstellung
*
* Return: 
*   nichts
*/

datetime ldt_datetime
ulong lul_usize, lul_csize
string ls_fullname, ls_name, ls_path
string ls_Folders[], ls_Files[]
boolean lb_password, lb_readonly, lb_hidden, lb_system, lb_subdir, lb_archive, lb_AlreadyCollected
long i, j

// Pattern anpassen
as_pattern = of_replace_all(as_pattern, ".", "\.")
as_pattern = of_replace_all(as_pattern, "*", ".*")
as_pattern = Lower(as_pattern)

// Folder anpassen
if as_folder <> "" then as_folder = as_folder + "\"

/////////////////////////////////////////////////////////////
// Alle Dateien und Verzeichnisse des Zip-Archivs auslesen //
/////////////////////////////////////////////////////////////
if aul_unzFile > 0 then
	// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob das Zip-Archiv auch zumindest eine Datei beinhaltet
	if of_unz_go_to_first_file(aul_unzFile) = 0 then
		
		// Schleife $$HEX1$$fc00$$ENDHEX$$ber alle Dateien im Zip-Archiv
		do
			// Informationen zur aktuellen Datei ermitteln
			of_unz_get_current_file_info(aul_unzFile, ls_fullname, ls_name, ls_path, lul_usize, lul_csize, ldt_datetime, &
												  lb_password, lb_readonly, lb_hidden, lb_system, lb_subdir, lb_archive)
											 
			if lb_subdir then
				// Verzeichniss nur hinzuf$$HEX1$$fc00$$ENDHEX$$gen, wenn Unterverzeichnisse auch verarbeitet werden sollen
				if ab_ProcessSubFolders then
					ls_Folders[UpperBound(ls_Folders) + 1] = ls_fullname
				end if
			else
				// Wenn Unterverzeichnisse nicht verarbeitet werden sollen, muss sichergestellt werden, 
				// dass sich die Datei im gesuchten Verzeichnis befindet
				if not ab_ProcessSubFolders and ls_path <> as_folder then continue
				if Match(Lower(ls_fullname), as_pattern) then
					ls_Files[UpperBound(ls_Files) + 1] = ls_fullname
				end if
			end if
		loop while of_unz_go_to_next_file(aul_unzFile) = 0
		
	end if
end if

//////////////////////////////////////////////////////
// Ausgelesene Verzeichnisse in die Liste schreiben //
//////////////////////////////////////////////////////
for i = 1 to UpperBound(ls_Folders)
	// Pr$$HEX1$$fc00$$ENDHEX$$fen, dass das Verzeichnis nicht bereits eingesammelt wurde
	lb_AlreadyCollected = false
	for j = 1 to UpperBound(as_FoldersToProcess)
		if as_FoldersToProcess[j] = ls_Folders[i] then 
			lb_AlreadyCollected = true
			exit
		end if
	next
	
	// Verzeichnis zur Liste hinzuf$$HEX1$$fc00$$ENDHEX$$gen
	if not lb_AlreadyCollected then
		as_FoldersToProcess[UpperBound(as_FoldersToProcess) + 1] = ls_Folders[i]
	end if
next

////////////////////////////////////////////////
// Ausgelesene Dateien in die Liste schreiben //
////////////////////////////////////////////////
for i = 1 to UpperBound(ls_Files)
	// Pr$$HEX1$$fc00$$ENDHEX$$fen, dass die Datei nicht bereits eingesammelt wurde
	lb_AlreadyCollected = false
	for j = 1 to UpperBound(as_FilesToProcess)
		if as_FilesToProcess[j] = ls_Files[i] then 
			lb_AlreadyCollected = true
			exit
		end if
	next
	
	// Datei zur Liste hinzuf$$HEX1$$fc00$$ENDHEX$$gen
	if not lb_AlreadyCollected then
		as_FilesToProcess[UpperBound(as_FilesToProcess) + 1] = ls_Files[i]
	end if
next
end subroutine

private function string of_get_file_description (string as_filename);/*
* Objekt : uo_zip
* Methode: of_get_file_description (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   as_filename    Der Pfad+Dateiname, der Datei
*
* Beschreibung: Gibt die Beschreibung einer Datei zur$$HEX1$$fc00$$ENDHEX$$ck, so wie sie im Windows Explorer angezeigt wird.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Dirk Bunk    03.07.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*  Die Beschreibung der Datei
*/

constant long SHGFI_ICON = 256 
constant long SHGFI_DISPLAYNAME = 512
constant long SHGFI_TYPENAME = 1024
constant long SHGFI_USEFILEATTRIBUTES = 16

SHFILEINFO lstr_SFI
string ls_typename

if SHGetFileInfo(as_filename, 0, lstr_SFI, 352, SHGFI_TYPENAME + SHGFI_USEFILEATTRIBUTES) = 1 then
	ls_typename = String(lstr_SFI.szTypeName)
end if

return ls_typename
end function

private function integer of_unz_get_current_file_info (unsignedlong aul_unzfile, ref string as_fullname, ref string as_name, ref string as_path, ref unsignedlong aul_usize, ref unsignedlong aul_csize, ref datetime adt_datetime, ref boolean ab_password, ref boolean ab_readonly, ref boolean ab_hidden, ref boolean ab_system, ref boolean ab_subdir, ref boolean ab_archive);/*
* Objekt : uo_zip
* Methode: of_unz_get_current_file_info (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   aul_unzfile    Das Handle zur ge$$HEX1$$f600$$ENDHEX$$ffneten Datei im Zip-Archiv
*
* Beschreibung: Gibt diverse Informationen $$HEX1$$fc00$$ENDHEX$$ber eine Datei innerhalb eines Zip-Archivs zur$$HEX1$$fc00$$ENDHEX$$ck
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Roland S.    25.07.2009    R$$HEX1$$fc00$$ENDHEX$$ckgabewerte als Referenz-Parameter
*   1.2        Roland S.    29.12.2011    Die Art und Weise ge$$HEX1$$e400$$ENDHEX$$ndert, wie ein Passwort erkannt wird
*   1.3        Dirk Bunk    03.07.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*  0: OK
* -1: Fehler
*/

unz_fileinfo lstr_info
integer li_rc, li_pos
string ls_cmts, ls_temp
ulong lul_fname, lul_extraptr, lul_extra, lul_cmts
date ld_date
time lt_time

// Puffer initialisieren
lul_fname = 256
as_fullname = Space(lul_fname)
lul_cmts = 500
ls_cmts = Space(lul_cmts)

// Dateiinformation
li_rc = unzGetCurrentFileInfo(aul_unzfile, lstr_info, as_fullname, lul_fname, lul_extraptr, lul_extra, ls_cmts, lul_cmts)
if li_rc <> UNZ_OK then
	return li_rc
end If

// Dateiname und Pfad
ls_temp = "\" + of_replace_all(as_fullname, "/", "\")
if Right(ls_temp, 1) = "\" then
	ls_temp = Left(ls_temp, Len(ls_temp) - 1)
end if
li_pos = LastPos(ls_temp, "\")
as_name = Mid(ls_temp, li_pos + 1)
as_path = Mid(Left(ls_temp, li_pos), 2)

// Dateigr$$HEX2$$f600df00$$ENDHEX$$e
aul_usize = lstr_info.uncompressed_size
aul_csize = lstr_info.compressed_size

// Erstelldatum
ld_date = Date(lstr_info.tmu_date.tm_year, &
					lstr_info.tmu_date.tm_mon + 1, &
					lstr_info.tmu_date.tm_mday)
lt_time = Time(lstr_info.tmu_date.tm_hour, &
					lstr_info.tmu_date.tm_min, &
					lstr_info.tmu_date.tm_sec)
adt_datetime = DateTime(ld_date, lt_time)

// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob die Datei passwortgesch$$HEX1$$fc00$$ENDHEX$$tzt ist
ab_password = of_check_bit(lstr_info.flag, 1)

// Datei Attribute
ab_readonly = of_check_bit(lstr_info.external_fa, 1)
ab_hidden   = of_check_bit(lstr_info.external_fa, 2)
ab_system   = of_check_bit(lstr_info.external_fa, 3)
ab_subdir   = of_check_bit(lstr_info.external_fa, 5)
ab_archive  = of_check_bit(lstr_info.external_fa, 6)

return li_rc
end function

private function integer of_unz_go_to_first_file (unsignedlong aul_unzfile);/*
* Objekt : uo_zip
* Methode: of_unz_go_to_first_file (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   aul_unzfile    Das Handle zum ge$$HEX1$$f600$$ENDHEX$$ffneten Zip-Archiv
*
* Beschreibung: Macht die erste Datei innerhalb eines Zip-Archivs zur aktuellen Datei
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Dirk Bunk    03.07.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*  0: OK
* -1: Fehler
*/

integer li_Ret

li_Ret = unzGoToFirstFile(aul_unzfile)
choose case li_Ret
	case UNZ_PARAMERROR
		is_LastError = "ZLib Error in of_unz_goto_first_file: Parameter Error!"
	case UNZ_BADZIPFILE
		is_LastError = "ZLib Error in of_unz_goto_first_file: Bad zip file!"
	case UNZ_INTERNALERROR
		is_LastError = "ZLib Error in of_unz_goto_first_file: Internal Error!"
	case UNZ_CRCERROR
		is_LastError = "ZLib Error in of_unz_goto_first_file: CRC Error!"
end choose

return li_Ret
end function

private function integer of_unz_go_to_next_file (unsignedlong aul_unzfile);/*
* Objekt : uo_zip
* Methode: of_unz_go_to_first_file (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   aul_unzfile    Das Handle zum ge$$HEX1$$f600$$ENDHEX$$ffneten Zip-Archiv
*
* Beschreibung: Macht die n$$HEX1$$e400$$ENDHEX$$chste Datei innerhalb eines Zip-Archivs zur aktuellen Datei
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Dirk Bunk    03.07.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*  0: OK
* -1: Fehler
*/

integer li_Ret

li_Ret = unzGoToNextFile(aul_unzfile)
choose case li_Ret
	case UNZ_PARAMERROR
		is_LastError = "ZLib Error in of_unz_goto_next_file: Parameter Error!"
	case UNZ_BADZIPFILE
		is_LastError = "ZLib Error in of_unz_goto_next_file: Bad zip file!"
	case UNZ_INTERNALERROR
		is_LastError = "ZLib Error in of_unz_goto_next_file: Internal Error!"
	case UNZ_CRCERROR
		is_LastError = "ZLib Error in of_unz_goto_next_file: CRC Error!"
end choose

return li_Ret
end function

private function integer of_extract_file (unsignedlong aul_unzfile, string as_filename, string as_nameinzip);/*
* Objekt : uo_zip
* Methode: of_extract_file (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   aul_UnzFile    Das Handle des ge$$HEX1$$f600$$ENDHEX$$ffneten Zip-Archivs
*   as_Filename    Der Name der Datei, wie er im Dateisystem abgespeichert werden soll
*   as_nameInZip   Der Name der Datei, innerhalb des Zip-Archivs, die entpackt werden soll
*
* Beschreibung: Entpackt eine Datei aus einem ge$$HEX1$$f600$$ENDHEX$$ffneten Zip-Archiv.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Roland S.    23.01.2012    Fehlerhandling f$$HEX1$$fc00$$ENDHEX$$r das $$HEX1$$d600$$ENDHEX$$ffnen der Datei hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*   1.2        Dirk Bunk    03.07.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*   1.3        Dirk Bunk    10.07.2013    Legt jetzt ggf. auch Ordner an
*   1.4        Dirk Bunk    12.07.2013    Puffergr$$HEX2$$f600df00$$ENDHEX$$e von 8k auf 32k erh$$HEX1$$f600$$ENDHEX$$ht (bessere Performance)
*
* Return: 
*  0: OK
* -1: Fehler
*/

integer li_Ret, li_fnum, li_size
blob lblob_Data
ulong lul_DataLen

li_Ret = 0

// Die Datei innerhalb des Zip-Archivs finden
if li_Ret = 0 then
	if Len(as_Filename) > 0 then
		if unzLocateFile(aul_unzFile, as_NameInZip, 2) < 0 then
			is_LastError = "ZLib Error in of_extract_file: The file '" + as_NameInZip + "' could not be located within the archive!"
			li_Ret = -1
		end if
	end if
end if

// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob die Datei ein Passwort ben$$HEX1$$f600$$ENDHEX$$tigt, aber keines angegeben wurde
if li_Ret = 0 then
	if of_current_file_has_password(aul_unzFile) then
		if is_password = "" then
			is_LastError = "ZLib Error in of_extract_file: The file '" + as_NameInZip + "' requires a password!"
			li_Ret = -1
		end if
	end if
end if

// Die Datei (im Zip) $$HEX1$$f600$$ENDHEX$$ffnen
if li_Ret = 0 then
	if is_password = "" then
		if unzOpenCurrentFile(aul_unzFile) < 0 then
			is_LastError = "ZLib Error in of_extract_file: The file '" + as_NameInZip + "' could not be opened within the archive!"
			unzCloseCurrentFile(aul_unzFile)
			li_Ret = -1
		end if
	else
		if unzOpenCurrentFilePassword(aul_unzFile, is_Password) < 0 then
			is_LastError = "ZLib Error in of_extract_file: The password protected file '" + as_NameInZip + "' could not be opened within the archive!"
			unzCloseCurrentFile(aul_unzFile)
			li_Ret = -1
		end if
	end if
end if

// Die Datei extrahieren
if li_Ret = 0 then
	// Puffer allokieren
	lul_DataLen = 32765
	lblob_Data = Blob(Space(lul_DataLen))
	
	// Sicherstellen, dass der Zielordner vorhanden ist und evtl. neu anlegen
	of_create_folder(Mid(as_filename, 1, LastPos(as_filename, "\") - 1))
	
	// Neue Datei erstellen und $$HEX1$$f600$$ENDHEX$$ffnen
	li_fnum = FileOpen(as_filename, StreamMode!, Write!, LockReadWrite!, Replace!)
	if li_fnum > 0 then
		// Immer 32k Bytes auf einmal einlesen
		li_size = unzReadCurrentFile(aul_unzFile, lblob_Data, lul_DataLen)
		if li_size < 0 then
			is_LastError = "ZLib Error in of_extract_file: The file '" + as_NameInZip + "' could not be extracted from the archive!"
			li_Ret = -1
		end if
		
		do while li_size > 0
			// Daten zur Datei hinzuf$$HEX1$$fc00$$ENDHEX$$gen
			li_size = FileWrite(li_fnum, BlobMid(lblob_data, 1, li_size))
			
			// Die n$$HEX1$$e400$$ENDHEX$$chsten 32k Bytes lesen
			li_size = unzReadCurrentFile(aul_unzFile, lblob_Data, lul_DataLen)
		loop
		
		// Datei schlie$$HEX1$$df00$$ENDHEX$$en
		FileClose(li_fnum)
	else
		is_LastError = "ZLib Error in of_extract_file: Unable to open the output file!"
		li_Ret = -1
	end if
end if

// Die Datei (im Zip) wieder schlie$$HEX1$$df00$$ENDHEX$$en
if li_Ret = 0 then
	li_Ret = unzCloseCurrentFile(aul_unzFile)
end if

return li_Ret
end function

private function boolean of_current_file_has_password (unsignedlong aul_unzfile);/*
* Objekt : uo_zip
* Methode: of_current_file_has_password (Function)
* Autor  : Roland S. (http://www.topwizprogramming.com/freecode_zlibwapi.html)
* Datum  : 26.03.2008
*
* Argument(e):
*   aul_unzfile    Handle des ge$$HEX1$$f600$$ENDHEX$$ffnetes Zip-Archivs
*
* Beschreibung: Pr$$HEX1$$fc00$$ENDHEX$$ft, ob ein ge$$HEX1$$f600$$ENDHEX$$ffnetes Zip-Archiv passwortgesch$$HEX1$$fc00$$ENDHEX$$tzt ist.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    26.03.2008    Erstellung
*   1.1        Roland S.    29.12.2011    Die Art, wie das Passwort erkannt wird, ge$$HEX1$$e400$$ENDHEX$$ndert
*   1.2        Dirk Bunk    03.07.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*  true: Die Datei ist Passwortgesch$$HEX1$$fc00$$ENDHEX$$tzt
* false: Die Datei ist nicht Passwortgesch$$HEX1$$fc00$$ENDHEX$$tzt
*/

integer li_rc
ulong lul_fname, lul_extraptr, lul_extra, lul_cmts
string ls_fullname, ls_cmts
unz_fileinfo lstr_info

// Puffer initialisieren
lul_fname = 256
ls_fullname = Space(lul_fname)
lul_cmts  = 500
ls_cmts   = Space(lul_cmts)

// Dateiinformation auslesen
li_rc = unzGetCurrentFileInfo(aul_unzfile, lstr_info, ls_fullname, lul_fname, lul_extraptr, lul_extra, ls_cmts, lul_cmts)

// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob die Datei passwortgesch$$HEX1$$fc00$$ENDHEX$$tzt ist
return of_check_bit(lstr_info.flag, 1)
end function

public function integer of_unzip (string as_archivename, string as_targetpath);/*
* Objekt : uo_zip
* Methode: of_unzip (Function)
* Autor  : Dirk Bunk
* Datum  : 11.07.2013
*
* Argument(e):
*   as_archivename          Der Pfad+Dateiname der Zip-Datei, die entpackt werden soll.
*   as_targetpath           Das Zielverzeichnis, in das die Dateien entpackt werden sollen.
*
* Beschreibung: Entpackt eine Zip-Datei in ein Verzeichnis.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    11.07.2013    Erstellung
*
* Return: 
*   -1  Fehler
*    0  OK
*/

string ls_Filenames[]
ls_Filenames[1] = "*"

return of_unzip(ls_Filenames, as_ArchiveName, as_TargetPath, false, true, true)
end function

public function integer of_zip (string as_filenames[], string as_archivename);/*
* Objekt : uo_zip
* Methode: of_zip (Function)
* Autor  : Dirk Bunk
* Datum  : 11.07.2013
*
* Argument(e):
*   as_filenames[]          Ein Array mit Dateinamen, die gepackt werden sollen. (Wildcards sind m$$HEX1$$f600$$ENDHEX$$glich)
*   as_archivename          Der Name der Zip-Datei, die erstellt werden soll.
*
* Beschreibung: Packt Dateien in eine Zip-Datei.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    11.07.2013    Erstellung
*
* Return: 
*   -1  Fehler
*    0  OK
*/

return of_zip(as_filenames, as_archivename, false, true, true)
end function

public function string of_directory (string as_filename, boolean ab_subdir);/*
* Objekt : uo_zip
* Methode: of_directory (Function)
* Autor  : Roland S.
* Datum  : 03.26.2008
*
* Argument(e):
*   as_filename    Der Pfad+Dateiname des Zip-Archivs, deren Verzeichnis gelesen werden soll
*   ab_subdir      Gibt an, ob auch Unterverzeichnisse des Zip-Archivs gelesen werden sollen
*
* Beschreibung: Gibt den Verzeichnisinhalt eines Zip-Archivs in Form eines DataWindow Import Strings zur$$HEX1$$fc00$$ENDHEX$$ck.
*
* HINWEIS: Das Ziel-DataWindow muss folgende Spalten in exakt dieser Reihenfolge haben:
*          filename           string    64
*          filetype           string    64
*          filedate           datetime
*          uncompressed_size  number
*          compression_ratio  decimal    4
*          compressed_size    number
*          attributes         string     4
*          password           string     1
*          filepath           string   256
*          fullname           string   320
*          Dann kann der R$$HEX1$$fc00$$ENDHEX$$ckgabestring per DW.ImportString(ReturnValue), importiert werden.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Roland S.    03.26.2008    Erstellung
*   1.1        Roland S.    25.07.2009    Formatierung des DataWindow String passiert jetzt hier
*   1.2        Dirk Bunk    03.07.2013    $$HEX1$$dc00$$ENDHEX$$bersetzung/Formatierung
*
* Return: 
*   DataWindow Import String
*/

datetime ldt_DateTime
ulong lul_unzFile, lul_usize, lul_csize
string ls_DwData, ls_RowData, ls_Fullname, ls_Name, ls_Path, ls_Attrib
boolean lb_Password, lb_ReadOnly, lb_Hidden, lb_System, lb_SubDir, lb_Archive

// Zip-Archiv $$HEX1$$f600$$ENDHEX$$ffnen
lul_unzFile = unzOpen(as_Filename)
if lul_unzFile > 0 then
	// Jede Datei im Zip-Archiv durchgehen
	if of_unz_go_to_first_file(lul_unzFile) = 0 then
		do
			// Informationen $$HEX1$$fc00$$ENDHEX$$ber die Datei auslesen
			of_unz_get_current_file_info(lul_unzFile, ls_Fullname, ls_Name, ls_Path, lul_usize, lul_csize, ldt_DateTime, &
												  lb_Password, lb_ReadOnly, lb_Hidden, lb_System, lb_SubDir, lb_Archive)
						
			// Evtl. $$HEX1$$dc00$$ENDHEX$$berspringen, wenn keine Unterverzeichnisse ben$$HEX1$$f600$$ENDHEX$$tigt werden
			if lb_SubDir and not ab_subdir then continue

			// DataWindow Import String zusammenbauen
			// filename
			ls_RowData = Trim(ls_Name) + "~t"
			
			// filetype
			if lb_SubDir then
				ls_RowData += "Folder~t"
			else
				ls_RowData += of_get_file_description(ls_Name) + "~t"
			end if
			
			// filedate
			ls_RowData += String(ldt_DateTime) + "~t"
			
			// uncompressed_size
			ls_RowData += String(lul_usize) + "~t"
			
			// compression_ratio
			if lul_usize = 0 then
				ls_RowData += "0~t"
			else
				ls_RowData += String(lul_csize / lul_usize) + "~t"
			end if
			
			// compressed_size
			ls_RowData += String(lul_csize) + "~t"
			
			// attributes
			ls_Attrib = ""
			if lb_ReadOnly then
				ls_Attrib += "R"
			end if
			if lb_Hidden then
				ls_Attrib += "H"
			end if
			if lb_System then
				ls_Attrib += "S"
			end if
			if lb_Archive then
				ls_Attrib += "A"
			end if
			ls_RowData += ls_Attrib + "~t"
			
			// password
			If lb_Password then
				ls_RowData += "Y~t"
			else
				ls_RowData += "N~t"
			end if
			
			// filepath
			ls_RowData += ls_Path + "~t"
			
			// fullname
			ls_RowData += ls_Fullname + "~t"
			
			if Len(ls_DwData) = 0 then
				ls_DwData = ls_RowData
			else
				ls_DwData = ls_DwData + "~r~n" + ls_RowData
			end if
		loop while of_unz_go_to_next_file(lul_unzFile) = 0
	end if
	
	// Zip-Archiv wieder schlie$$HEX1$$df00$$ENDHEX$$en
	unzClose(lul_unzFile)
end if

return ls_DwData
end function

on uo_zip_zlib.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_zip_zlib.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

