HA$PBExportHeader$uo_zip_xceed.sru
$PBExportComments$Zip-Funktionalit$$HEX1$$e400$$ENDHEX$$ten (Nutzt Xceed Zip)
forward
global type uo_zip_xceed from nonvisualobject
end type
end forward

global type uo_zip_xceed from nonvisualobject
end type
global uo_zip_xceed uo_zip_xceed

type prototypes

end prototypes

type variables
/////////////
// HINWEIS //
/////////////
//
// Diese Zip-Implementierung sollte nie direkt verwendet werden,
// sondern immer $$HEX1$$fc00$$ENDHEX$$ber die Wrapper-Klasse uo_zip.

PRIVATE:

// Error Codes
constant integer ZIP_SUCCESS = 0
constant integer ZIP_WARNING = 526

// Compression Levels
constant uint ZIP_CL_NONE   = 0 // No compression. Files are stored in the zip file as raw data.
constant uint ZIP_CL_LOW    = 1 // Minimum compression. This setting takes the least amount of time to compress data.
constant uint ZIP_CL_MEDIUM = 6 // Normal compression. This is the best balance between the time it takes to compress data and the compression ratio achieved.
constant uint ZIP_CL_HIGH   = 9 // Maximum compression. This setting achieves the best compression ratios that the compression algorithm is capable of producing.

// OCX Objekte
OLEObject ole_zip
OLEObject ole_compression

// Sonstige Variablen
string isLicenseKey  = "1823BC7BDF1B877EEAEB773176EA13EC"
string isLastError   = ""
string isPassword    = ""
uint iuiCompressionLevel = ZIP_CL_HIGH
end variables

forward prototypes
public function integer of_zip (string as_filenames[], string as_archivename, boolean ab_delete, boolean ab_preservepaths, boolean ab_processsubfolders)
public function integer of_unzip (string as_filenames[], string as_archivename, string as_targetpath, boolean ab_delete, boolean ab_preservepaths, boolean ab_processsubfolders)
public function string of_get_last_error ()
public subroutine of_set_password (string as_password)
public function integer of_unzip_blob (ref blob ab_data)
public function integer of_zip_blob (ref blob ab_data)
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
*
* Return: 
*   -1  Fehler
*    0  OK
*/

string sFiles = ""
integer i
integer iRet

if not isNull(ole_zip) then
	// Dateinamen, die gezippt werden sollen zusammenbauen
	for i = 1 to Upperbound(as_Filenames)
		sFiles = sFiles + as_Filenames[i] + "|"
	next
	ole_zip.FilesToProcess(sFiles)
	
	// Komprimierungsstufe setzen
	ole_zip.CompressionLevel = iuiCompressionLevel
	
	// Encryption Passwort setzen
	ole_zip.EncryptionPassword = isPassword
	
	// Archivname setzen
	ole_zip.ZipFilename(as_ArchiveName)
	
	// Schalter setzen, ob die Dateipfade mit gezippt werden
	ole_zip.PreservePaths(ab_PreservePaths) 
	
	// Schalter setzen, ob auch Unterverzeichnisse durchsucht werden
	ole_zip.ProcessSubfolders(ab_ProcessSubfolders)
	
	// Dateien zippen
	iRet = ole_zip.Zip()
	if iRet <> ZIP_SUCCESS and iRet <> ZIP_WARNING then
		isLastError = "Couldn't create Zip-Archive.~rErrorcode: " + String(iRet) + "~r" + ole_zip.GetErrorDescription(0, iRet)
		return -1
	else
		// Evtl. Dateien l$$HEX1$$f600$$ENDHEX$$schen
		if ab_Delete then
			for i = 1 to Upperbound(as_Filenames)
				FileDelete(as_Filenames[i])
			next
		end if
	end if
else
	return -1
end if

return 0
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
*
* Return: 
*   -1  Fehler
*    0  OK
*/

string sFiles = ""
integer i
integer iRet

if not isNull(ole_zip) then
	// Dateinamen, die entzippt werden sollen zusammenbauen
	for i = 1 to Upperbound(as_Filenames)
		sFiles = sFiles + as_Filenames[i] + "|"
	next
	ole_zip.FilesToProcess(sFiles)
	
	// Encryption Passwort setzen
	ole_zip.EncryptionPassword = isPassword
	
	// Archivname setzen
	ole_zip.ZipFilename(as_ArchiveName)
	
	// Zielverzeichnis setzen
	ole_zip.UnzipToFolder(as_TargetPath)
	
	// Schalter setzen, ob die Dateipfade mit entzippt werden
	ole_zip.PreservePaths(ab_PreservePaths) 
	
	// Schalter setzen, ob auch Unterverzeichnisse durchsucht werden
	ole_zip.ProcessSubfolders(ab_ProcessSubfolders)
	
	// Dateien entzippen
	iRet = ole_zip.Unzip()
	if iRet <> ZIP_SUCCESS and iRet <> ZIP_WARNING then
		isLastError = "Couldn't unzip Zip-Archive.~rErrorcode: " + String(iRet) + "~r" + ole_zip.GetErrorDescription(0, iRet)
		return -1
	else
		// Evtl. das Archiv l$$HEX1$$f600$$ENDHEX$$schen
		if ab_Delete then
			FileDelete(as_ArchiveName)
		end if
	end if
else
	return -1
end if

return 0
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

return isLastError
end function

public subroutine of_set_password (string as_password);/*
* Objekt : uo_zip
* Methode: of_set_password (Function)
* Autor  : Dirk Bunk
* Datum  : 28.03.2012
*
* Argument(e):
*   as_password    Das Passwort, das gesetzt werden soll.
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

isPassword = as_password
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
*
* Return: 
*   -1  Fehler
*    0  OK
*/

integer iRet

if not isNull(ole_compression) then		
		// Encryption Passwort setzen
		ole_compression.EncryptionPassword = isPassword
		
		// Blob komprimieren
		iRet = ole_compression.Uncompress(ab_data, ref ab_data, true) 
		
		// Fehler abpr$$HEX1$$fc00$$ENDHEX$$fen
		if iRet <> ZIP_SUCCESS and iRet <> ZIP_WARNING then
			isLastError = "Couldn't unzip blob.~rErrorcode: " + String(iRet) + "~r" + ole_compression.GetErrorDescription(iRet)
			return -1
		end if
else
	return -1
end if

return 0
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
*
* Return: 
*   -1  Fehler
*    0  OK
*/

integer iRet

if not isNull(ole_compression) then
	   // Komprimierungsstufe setzen
		ole_compression.CompressionLevel = iuiCompressionLevel
		
		// Encryption Passwort setzen
		ole_compression.EncryptionPassword = isPassword
		
		// Blob komprimieren
		iRet = ole_compression.Compress(ab_data, ref ab_data, true) 
		
		// Fehler abpr$$HEX1$$fc00$$ENDHEX$$fen
		if iRet <> ZIP_SUCCESS and iRet <> ZIP_WARNING then
			isLastError = "Couldn't zip blob.~rErrorcode: " + String(iRet) + "~r" + ole_compression.GetErrorDescription(iRet)
			return -1
		end if
else
	return -1
end if

return 0
end function

on uo_zip_xceed.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_zip_xceed.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;integer iRet = 0

//OCX Objekte erzeugen
ole_zip = CREATE OLEObject
if iRet = 0 then
	iRet = ole_zip.ConnectToNewObject("XceedSoftware.XceedZip")
	if iRet <> 0 then
		isLastError = "Couldn't connect to object XceedSoftware.XceedZip Error code " + String(iRet)
	end if
end if

ole_compression = CREATE OLEObject
if iRet = 0 then
	iRet = ole_compression.ConnectToNewObject("XceedSoftware.XceedCompression")
	if iRet <> 0 then
		isLastError = "Couldn't connect to object XceedSoftware.XceedCompression. Error code " + String(iRet)
	end if
end if

//Lizenzschl$$HEX1$$fc00$$ENDHEX$$ssel setzen
if ole_zip.License(isLicenseKey) = false or ole_compression.License(isLicenseKey) = false then
	isLastError = "Zip ActiveX Library not licenced."
end if
end event

event destructor;//OCX Objekte zerst$$HEX1$$f600$$ENDHEX$$ren
ole_zip.DisconnectObject()
ole_compression.DisconnectObject()

DESTROY ole_zip
DESTROY ole_compression
end event

