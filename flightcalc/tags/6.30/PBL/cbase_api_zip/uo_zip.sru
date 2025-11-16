HA$PBExportHeader$uo_zip.sru
$PBExportComments$Zip-Funktionalit$$HEX1$$e400$$ENDHEX$$ten (Wrapper Klasse)
forward
global type uo_zip from nonvisualobject
end type
end forward

global type uo_zip from nonvisualobject
end type
global uo_zip uo_zip

type prototypes
PRIVATE:
function string testZlib() library "zlibwapi.dll" alias for "zlibVersion"
end prototypes

type variables
/////////////
// HINWEIS //
/////////////
//
// Diese Klasse ist nunmehr lediglich ein Wrapper f$$HEX1$$fc00$$ENDHEX$$r die beiden Zip Varianten Xceed (uo_zip_xceed) und Zlib (uo_zip_zlib).
// Falls die ben$$HEX1$$f600$$ENDHEX$$tigte Zlib-DLL auf dem System gefunden wird, wird die ZLib-Variante verwendet.
// Als Fallback-Szenario wird nach der Xceed-DLL gesucht und ggf. die Xceed-Variante verwendet.
//
// Sollte die Zlib-DLL vollst$$HEX1$$e400$$ENDHEX$$ndig auf allen Zielsystemen vorhanden sein,
// kann diese Klasse und die Xceed-Implementierung gel$$HEX1$$f600$$ENDHEX$$scht werden,
// und die uo_zip_zlib nach uo_zip umbenannt werden.

PRIVATE:
uo_zip_xceed iuo_ZipXceed
uo_zip_zlib iuo_ZipZlib
end variables

forward prototypes
public function integer of_zip (string as_filenames[], string as_archivename, boolean ab_delete, boolean ab_preservepaths, boolean ab_processsubfolders)
public function integer of_unzip (string as_filenames[], string as_archivename, string as_targetpath, boolean ab_delete, boolean ab_preservepaths, boolean ab_processsubfolders)
public function string of_get_last_error ()
public function integer of_zip (string as_filenames[], string as_archivename, boolean ab_delete, boolean ab_preservepaths, boolean ab_processsubfolders)
public function integer of_unzip (string as_filenames[], string as_archivename, string as_targetpath, boolean ab_delete, boolean ab_preservepaths, boolean ab_processsubfolders)
public function string of_get_last_error ()
public subroutine of_set_password (string as_password)
public subroutine of_set_compression_level (integer ai_compressionlevel)
public function integer of_unzip_blob (ref blob ab_data)
public function integer of_zip_blob (ref blob ab_data)
public function string of_directory (string as_filename, boolean ab_subdir)
end prototypes

public function integer of_zip (string as_filenames[], string as_archivename, boolean ab_delete, boolean ab_preservepaths, boolean ab_processsubfolders);if IsValid(iuo_ZipZlib) then
	return iuo_ZipZlib.of_zip(as_filenames, as_archivename, ab_delete, ab_preservepaths, ab_processsubfolders)
elseif IsValid(iuo_ZipXceed) then
	return iuo_ZipXceed.of_zip(as_filenames, as_archivename, ab_delete, ab_preservepaths, ab_processsubfolders)
else
	return -1
end if
end function

public function integer of_unzip (string as_filenames[], string as_archivename, string as_targetpath, boolean ab_delete, boolean ab_preservepaths, boolean ab_processsubfolders);if IsValid(iuo_ZipZlib) then
	return iuo_ZipZlib.of_unzip(as_filenames, as_archivename, as_targetpath, ab_delete, ab_preservepaths, ab_processsubfolders)
elseif IsValid(iuo_ZipXceed) then
	return iuo_ZipXceed.of_unzip(as_filenames, as_archivename, as_targetpath, ab_delete, ab_preservepaths, ab_processsubfolders)
else
	return -1
end if
end function

public function string of_get_last_error ();if IsValid(iuo_ZipZlib) then
	return iuo_ZipZlib.of_get_last_error()
elseif IsValid(iuo_ZipXceed) then
	return iuo_ZipXceed.of_get_last_error()
else
	return "No Zip Module found!"
end if
end function

public subroutine of_set_password (string as_password);if IsValid(iuo_ZipZlib) then
	iuo_ZipZlib.of_set_password(as_password)
elseif IsValid(iuo_ZipXceed) then
	iuo_ZipXceed.of_set_password(as_password)
end if
end subroutine

public subroutine of_set_compression_level (integer ai_compressionlevel);if IsValid(iuo_ZipZlib) then
	iuo_ZipZlib.of_set_compression_level(ai_compressionlevel)
elseif IsValid(iuo_ZipXceed) then
	// Diese Funktion ist in der Xceed Zip Variante nicht implementiert
end if
end subroutine

public function integer of_unzip_blob (ref blob ab_data);if IsValid(iuo_ZipZlib) then
	return iuo_ZipZlib.of_unzip_blob(ab_data)
elseif IsValid(iuo_ZipXceed) then
	return iuo_ZipXceed.of_unzip_blob(ab_data)
else
	return -1
end if
end function

public function integer of_zip_blob (ref blob ab_data);if IsValid(iuo_ZipZlib) then
	return iuo_ZipZlib.of_zip_blob(ab_data)
elseif IsValid(iuo_ZipXceed) then
	return iuo_ZipXceed.of_zip_blob(ab_data)
else
	return -1
end if
end function

public function string of_directory (string as_filename, boolean ab_subdir);if IsValid(iuo_ZipZlib) then
	return iuo_ZipZlib.of_directory(as_filename, ab_subdir)
elseif IsValid(iuo_ZipXceed) then
	// Die Funktion ist in der Xceed Zip Variante nicht implementiert
	return ""
else
	return ""
end if
end function

on uo_zip.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_zip.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// Wenn vorhanden, Zlib initialisieren
Try
	testZlib()
	iuo_ZipZlib = CREATE uo_zip_zlib
Catch(RuntimeError ex1)
End Try

// Wenn vorhanden, XceedZip initialisieren (falls zlib nicht verf$$HEX1$$fc00$$ENDHEX$$gbar ist)
If Not IsValid(iuo_ZipZlib) Then
	OLEObject ole_XceedZip
	ole_XceedZip = CREATE OLEObject
	If ole_XceedZip.ConnectToNewObject("XceedSoftware.XceedZip") = 0 Then
		iuo_ZipXceed = CREATE uo_zip_xceed
	End If
	DESTROY ole_XceedZip
End If
end event

event destructor;DESTROY iuo_ZipZlib
DESTROY iuo_ZipXceed
end event

