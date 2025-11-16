HA$PBExportHeader$uo_pdf_handler.sru
$PBExportComments$PDF Funktionalit$$HEX1$$e400$$ENDHEX$$t
forward
global type uo_pdf_handler from nonvisualobject
end type
end forward

global type uo_pdf_handler from nonvisualobject
end type
global uo_pdf_handler uo_pdf_handler

type prototypes
PRIVATE:
Function uint GetSystemDirectoryA (ref string dirtext, uint textlen) library "KERNEL32.DLL" alias for "GetSystemDirectoryA;Ansi"
end prototypes

type variables
PUBLIC:
// Properties
indirect string UseLetterFormat {set_use_letter_format(*value), get_use_letter_format()}

PRIVATE:
uo_amyuni iuo_Amyuni
boolean ib_useLetterFormat = false
end variables

forward prototypes
public function integer of_print (string as_file, string as_printer)
public function integer of_concatenate (string as_files[], string as_output, boolean ab_delete)
public function integer of_convert (datawindow adw_data, string as_title, string as_output)
public function integer of_convert (datastore ads_data, string as_title, string as_output)
public function integer of_convert (datastore ads_data, string as_title, string as_output, boolean ab_autoadjustformat)
public function integer of_convert (datawindow adw_data, string as_title, string as_output, boolean ab_autoadjustformat)
public function string of_get_last_error ()
public function integer of_convert (datastore ads_data, string as_title, string as_output, boolean ab_autoadjustformat, boolean ab_grayscale, boolean ab_watermark, boolean ab_encrypt)
public function integer of_convert (datawindow adw_data, string as_title, string as_output, boolean ab_autoadjustformat, boolean ab_grayscale, boolean ab_watermark, boolean ab_encrypted)
private function integer of_adjust_datastore_paperformat (ref datastore dwo, boolean ab_useletterformat)
private function integer of_adjust_datawindow_paperformat (ref datawindow dwo, boolean ab_useletterformat)
private subroutine set_use_letter_format (boolean ab_useletterformat)
private function boolean get_use_letter_format ()
private function string of_get_system_dir ()
public function integer of_add_bookmark (string as_file, string as_bookmark)
public function integer of_print (string as_file, string as_printer, boolean ab_scaletofit)
end prototypes

public function integer of_print (string as_file, string as_printer);/*
* Objekt : uo_pdf_handler
* Methode: of_print (Function)
* Autor  : Dirk Bunk
* Datum  : 19.12.2012
*
* Argument(e):
*   as_File    Pfad+Dateiname der PDF Datei, die gedruckt werden soll.
*   as_Printer Der Name des Druckers, auf den gedruckt werden soll.
*
* Beschreibung: Druckt ein PDF auf einen beliebigen Drucker.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    19.12.2012    Erstellung
*   1.1        Dirk Bunk    14.08.2013    Abh$$HEX1$$e400$$ENDHEX$$ngigkeit zu uo_service Objekt entfernt
*
* Return: 
*   0: OK
*  -1: Fehler
*/

return of_print(as_File, as_Printer, false)
end function

public function integer of_concatenate (string as_files[], string as_output, boolean ab_delete);/*
* Objekt : uo_pdf_handler
* Methode: of_concatenate (Function)
* Autor  : Dirk Bunk
* Datum  : 19.12.2012
*
* Argument(e):
*   as_Files[] String Array mit Pfad+Dateinamen der PDF Dateien, die aneinander geh$$HEX1$$e400$$ENDHEX$$ngt werden sollen.
*   as_Output  Pfad+Dateiname der PDF Datei, die erzeugt werden soll.
*   ab_Delete  Boolean Flag, welches angibt, ob die Quelldateien nach Abschluss gel$$HEX1$$f600$$ENDHEX$$scht werden sollen.
*
* Beschreibung: H$$HEX1$$e400$$ENDHEX$$ngt eine Liste von PDFs aneinander und speichert das Ergebnis als neues PDF.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    19.12.2012    Erstellung
*   1.1        Dirk Bunk    14.08.2013    Abh$$HEX1$$e400$$ENDHEX$$ngigkeit zu uo_service Objekt entfernt
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_Return = 0
long i

for i = 1 to UpperBound(as_Files)
	 if not FileExists(as_Files[i]) then
		li_Return = -1
		exit
	end if
next

if iuo_Amyuni.of_concatenate(as_Files, as_Output, ab_Delete) = -1 then
	li_Return = -2
end if

return li_Return
end function

public function integer of_convert (datawindow adw_data, string as_title, string as_output);/*
* Objekt : uo_pdf_handler
* Methode: of_convert (Function)
* Autor  : Dirk Bunk
* Datum  : 19.12.2012
*
* Argument(e):
*   adw_Data  DataWindow, welches in ein PDF umgewandelt werden soll.
*   as_Title  Der Druckname des Dokuments.
*   as_Output Pfad+Dateiname der Ausgabedatei.
*
* Beschreibung: Wandelt ein DataWindow in ein PDF um.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    19.12.2012    Erstellung
*   1.1        Dirk Bunk    25.01.2013    Schalter zum Abstellen der automatischen Formatanpassung eingebaut
*
* Return: 
*   0: OK
*  -1: Fehler
*/

return of_convert(adw_Data, as_Title, as_Output, true)
end function

public function integer of_convert (datastore ads_data, string as_title, string as_output);/*
* Objekt : uo_pdf_handler
* Methode: of_convert (Function)
* Autor  : Dirk Bunk
* Datum  : 19.12.2012
*
* Argument(e):
*   ads_Data  DataStore, welches in ein PDF umgewandelt werden soll.
*   as_Title  Der Druckname des Dokuments.
*   as_Output Pfad+Dateiname der Ausgabedatei.
*
* Beschreibung: Wandelt ein DataStore in ein PDF um.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    19.12.2012    Erstellung
*   1.1        Dirk Bunk    25.01.2013    Schalter zum Abstellen der automatischen Formatanpassung eingebaut
*
* Return: 
*   0: OK
*  -1: Fehler
*/

return of_convert(ads_Data, as_Title, as_Output, true)
end function

public function integer of_convert (datastore ads_data, string as_title, string as_output, boolean ab_autoadjustformat);/*
* Objekt : uo_pdf_handler
* Methode: of_convert (Function)
* Autor  : Dirk Bunk
* Datum  : 25.01.2013
*
* Argument(e):
*   ads_Data            DataStore, welches in ein PDF umgewandelt werden soll.
*   as_Title            Der Druckname des Dokuments.
*   as_Output           Pfad+Dateiname der Ausgabedatei.
*   ab_AutoAdjustFormat Gibt an, ob das DataStore-Format automatisch angepasst werden soll oder nicht.
*
* Beschreibung: Wandelt ein DataStore in ein PDF um.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    25.01.2013    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

return of_convert(ads_Data, as_Title, as_Output, ab_AutoAdjustFormat, false, false, false)
end function

public function integer of_convert (datawindow adw_data, string as_title, string as_output, boolean ab_autoadjustformat);/*
* Objekt : uo_pdf_handler
* Methode: of_convert (Function)
* Autor  : Dirk Bunk
* Datum  : 25.01.2013
*
* Argument(e):
*   adw_Data            DataWindow, welches in ein PDF umgewandelt werden soll.
*   as_Title            Der Druckname des Dokuments.
*   as_Output           Pfad+Dateiname der Ausgabedatei.
*   ab_AutoAdjustFormat Gibt an, ob das DataWindow-Format automatisch angepasst werden soll oder nicht.
*
* Beschreibung: Wandelt ein DataWindow in ein PDF um.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    25.01.2013    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

return of_convert(adw_Data, as_Title, as_Output, ab_AutoAdjustFormat, false, false, false)
end function

public function string of_get_last_error ();/*
* Objekt : uo_pdf_handler
* Methode: of_get_last_error (Function)
* Autor  : Dirk Bunk
* Datum  : 14.08.2013
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt die letzte Fehlermeldung zur$$HEX1$$fc00$$ENDHEX$$ck, die aufgetreten ist.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    14.08.2013    Erstellung
*
* Return: 
*   Die letzte Fehlermeldung, die aufgetreten ist.
*/

return iuo_Amyuni.LastError
end function

public function integer of_convert (datastore ads_data, string as_title, string as_output, boolean ab_autoadjustformat, boolean ab_grayscale, boolean ab_watermark, boolean ab_encrypt);/*
* Objekt : uo_pdf_handler
* Methode: of_convert (Function)
* Autor  : Dirk Bunk
* Datum  : 19.12.2012
*
* Argument(e):
*   ads_Data            DataStore, welches in ein PDF umgewandelt werden soll.
*   as_Title            Der Druckname des Dokuments.
*   as_Output           Pfad+Dateiname der Ausgabedatei.
*   ab_AutoAdjustFormat Gibt an, ob das DataStore-Format automatisch angepasst werden soll oder nicht.
*   ab_Grayscale        Gibt an, ob der Export in Graustufen erfolgen soll.
*   ab_Watermark        Gibt an, ob f$$HEX1$$fc00$$ENDHEX$$r den Export das aktuell gesetzte Wasserzeichen verwendet werden soll.
*   ab_Encrypted        Gibt an, ob der Export verschl$$HEX1$$fc00$$ENDHEX$$sselt sein soll (schreibgesch$$HEX1$$fc00$$ENDHEX$$tzt).
*
* Beschreibung: Wandelt ein DataStore in ein PDF um.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    19.12.2012    Erstellung
*   1.1        Dirk Bunk    25.01.2013    Schalter zum Abstellen der automatischen Formatanpassung eingebaut
*   1.2        Dirk Bunk    21.10.2014    Multilanguage-Support und Font-Embedding ist jetzt immer an
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_Return = 0

// Dokumentenname und Drucker setzen
if IsNull(as_Title) then as_Title = "N/A"

// CPU-Zeit an den Dokumententitel h$$HEX1$$e400$$ENDHEX$$ngen, um m$$HEX1$$f600$$ENDHEX$$glichst hohe Eindeutigkeit zu garantieren 
as_Title += "_" + String(CPU())

ads_Data.Modify("datawindow.print.documentname = '" + as_Title + "'")
ads_Data.Modify("datawindow.printer='" + iuo_Amyuni.PrinterName + "'")

// Papierformat anpassen
if ab_AutoAdjustFormat then of_adjust_datastore_paperformat(ads_Data, UseLetterFormat)

// Drucker vorbereiten
iuo_Amyuni.of_prepare_printer(as_Output, as_Title, ab_Grayscale, ab_Watermark, ab_Encrypt)

// Dokument drucken
if ads_Data.print(false) <> 1 then li_Return = -1

return li_Return
end function

public function integer of_convert (datawindow adw_data, string as_title, string as_output, boolean ab_autoadjustformat, boolean ab_grayscale, boolean ab_watermark, boolean ab_encrypted);/*
* Objekt : uo_pdf_handler
* Methode: of_convert (Function)
* Autor  : Dirk Bunk
* Datum  : 19.12.2012
*
* Argument(e):
*   adw_Data            DataWindow, welches in ein PDF umgewandelt werden soll.
*   as_Title            Der Druckname des Dokuments.
*   as_Output           Pfad+Dateiname der Ausgabedatei.
*   ab_AutoAdjustFormat Gibt an, ob das DataWindow-Format automatisch angepasst werden soll oder nicht.
*   ab_Grayscale        Gibt an, ob der Export in Graustufen erfolgen soll.
*   ab_Watermark        Gibt an, ob f$$HEX1$$fc00$$ENDHEX$$r den Export das aktuell gesetzte Wasserzeichen verwendet werden soll.
*   ab_Encrypted        Gibt an, ob der Export verschl$$HEX1$$fc00$$ENDHEX$$sselt sein soll (schreibgesch$$HEX1$$fc00$$ENDHEX$$tzt).
*
* Beschreibung: Wandelt ein DataWindow in ein PDF um.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    19.12.2012    Erstellung
*   1.1        Dirk Bunk    25.01.2013    Schalter zum Abstellen der automatischen Formatanpassung eingebaut
*   1.2        Dirk Bunk    21.10.2014    Multilanguage-Support und Font-Embedding ist jetzt immer an
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_Return = 0

// Dokumentenname und Drucker setzen
if IsNull(as_Title) then as_Title = "N/A"

// CPU-Zeit an den Dokumententitel h$$HEX1$$e400$$ENDHEX$$ngen, um m$$HEX1$$f600$$ENDHEX$$glichst hohe Eindeutigkeit zu garantieren 
as_Title += "_" + String(CPU())

adw_Data.Modify("datawindow.print.documentname = '" + as_Title + "'")
adw_Data.Modify("datawindow.printer='" + iuo_Amyuni.PrinterName + "'")

// Papierformat anpassen
if ab_AutoAdjustFormat then of_adjust_datawindow_paperformat(adw_Data, UseLetterFormat)

// Drucker vorbereiten
iuo_Amyuni.of_prepare_printer(as_Output, as_Title, ab_Grayscale, ab_Watermark, ab_Encrypted)

// Dokument drucken
if adw_Data.print(false) <> 1 then li_Return = -1

return li_Return
end function

private function integer of_adjust_datastore_paperformat (ref datastore dwo, boolean ab_useletterformat);/* 
* Funktion/Event: of_adjust_datastore_paperformat
* Beschreibung: 	Formatiert einen CBASE Report f$$HEX1$$fc00$$ENDHEX$$r das eingestellte Papierformat
* Besonderheit: 	keine
*
* Argumente:
* 	Name						Beschreibung
*	dwo							Das DataStore, das formatiert werden soll
*	ab_useLetterFormat		Gibt an, ob das Papierformat "Letter" verwendet werden soll.
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			D.Bunk		03.02.09		Erstellung
*
* Return Codes:
*	0		Alles OK
*/	

integer 	li_LetterOffset = 65
integer 	li_Height

/*************************************************
Papierformat einstellen
		 DIN-A4: Paper.Size=9 / Zoom=100
Letter-Format: Paper.Size=1 / Zoom=94 (Querformat)
*************************************************/

if ab_useLetterFormat then
	
	// Welche Orientation ? 1 = Landscape	2 = Portrait
	if	Integer(dwo.Describe("datawindow.print.Orientation")) = 1 then
		//Den Platzgewinn durch Letterformat mitber$$HEX1$$fc00$$ENDHEX$$cksichtigen
		li_Height = Integer(dwo.Describe("r_detail.Height")) + li_LetterOffset
		dwo.Modify("r_detail.Height=" + String(li_Height))
		
		dwo.Modify("datawindow.print.paper.size=1")
		dwo.Modify("datawindow.zoom=94")
		
	elseif Integer(dwo.Describe("datawindow.print.Orientation")) = 2 then
		//Den Platzverlust durch Letterformat mitber$$HEX1$$fc00$$ENDHEX$$cksichtigen
		li_Height = Integer(dwo.Describe("r_detail.Height")) - li_LetterOffset
		dwo.Modify("r_detail.Height=" + String(li_Height))
		
		dwo.Modify("datawindow.print.paper.size=1")
		
	end if
end if

return 0
end function

private function integer of_adjust_datawindow_paperformat (ref datawindow dwo, boolean ab_useletterformat);/* 
* Funktion/Event: of_adjust_datawindow_paperformat
* Beschreibung: 	Formatiert einen CBASE Report f$$HEX1$$fc00$$ENDHEX$$r das eingestellte Papierformat
* Besonderheit: 	keine
*
* Argumente:
* 	Name						Beschreibung
*	dwo							Das DataStore, das formatiert werden soll
*	ab_useLetterFormat		Gibt an, ob das Papierformat "Letter" verwendet werden soll.
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			D.Bunk		03.02.09		Erstellung
*
* Return Codes:
*	0		Alles OK
*/	

integer 	li_LetterOffset = 65
integer 	li_Height

/*************************************************
Papierformat einstellen
		 DIN-A4: Paper.Size=9 / Zoom=100
Letter-Format: Paper.Size=1 / Zoom=94 (Querformat)
*************************************************/

if ab_useLetterFormat then
	
	// Welche Orientation ? 1 = Landscape	2 = Portrait
	if	Integer(dwo.Describe("datawindow.print.Orientation")) = 1 then
		//Den Platzgewinn durch Letterformat mitber$$HEX1$$fc00$$ENDHEX$$cksichtigen
		li_Height = Integer(dwo.Describe("r_detail.Height")) + li_LetterOffset
		dwo.Modify("r_detail.Height=" + String(li_Height))
		
		dwo.Modify("datawindow.print.paper.size=1")
		dwo.Modify("datawindow.zoom=94")
		
	elseif Integer(dwo.Describe("datawindow.print.Orientation")) = 2 then
		//Den Platzverlust durch Letterformat mitber$$HEX1$$fc00$$ENDHEX$$cksichtigen
		li_Height = Integer(dwo.Describe("r_detail.Height")) - li_LetterOffset
		dwo.Modify("r_detail.Height=" + String(li_Height))
		
		dwo.Modify("datawindow.print.paper.size=1")
		
	end if
end if

return 0
end function

private subroutine set_use_letter_format (boolean ab_useletterformat);ib_useLetterFormat = ab_useLetterFormat
end subroutine

private function boolean get_use_letter_format ();return ib_useLetterFormat
end function

private function string of_get_system_dir ();/*
* Objekt : of_get_system_dir
* Autor  : Dirk Bunk
* Datum  : 13.12.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt das aktuelle Systemverzeichnis zur$$HEX1$$fc00$$ENDHEX$$ck (Z.B. C:\Windows\System32).	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    13.12.2012    Erstellung
*
* Return: 
*   Das aktuelle Systemverzeichnis.
*/

string ls_SystemDir

try
	ls_SystemDir = Space(1024)
	GetSystemDirectoryA(ls_SystemDir, 1024)
	ls_SystemDir = Trim(ls_SystemDir)
catch (RuntimeError ex)
	ls_SystemDir = ""
end try

return ls_SystemDir
end function

public function integer of_add_bookmark (string as_file, string as_bookmark);
// --------------------------------------------------------------------------------
// Objekt : uo_pdf_handler
// Methode: of_add_bookmark (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 19.05.2017
//
// Argument(e):
//	 string as_file
//	 string as_bookmark
//
// Beschreibung:		Add Bookmark to File
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	19.05.2017		Erstellung
//
//
// Return: integer
//
// --------------------------------------------------------------------------------

Integer	li_Return


li_Return = iuo_amyuni.of_add_bookmark( as_file, as_file, as_bookmark )


return li_Return
end function

public function integer of_print (string as_file, string as_printer, boolean ab_scaletofit);/*
* Objekt : uo_pdf_handler
* Methode: of_print (Function)
* Autor  : Dirk Bunk
* Datum  : 19.12.2012
*
* Argument(e):
*   as_File    Pfad+Dateiname der PDF Datei, die gedruckt werden soll.
*   as_Printer Der Name des Druckers, auf den gedruckt werden soll.
*   ab_ScaleToFit Gibt an, ob das PDF Dokument, auf die Papiergr$$HEX2$$f600df00$$ENDHEX$$e des Druckers skaliert werden soll (experimenteller Workaround f$$HEX1$$fc00$$ENDHEX$$r bestimmte Zebra Drucker).
*
* Beschreibung: Druckt ein PDF auf einen beliebigen Drucker.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    19.12.2012    Erstellung
*   1.1        Dirk Bunk    14.08.2013    Abh$$HEX1$$e400$$ENDHEX$$ngigkeit zu uo_service Objekt entfernt
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_Return = 0

// PDF-File drucken
if not FileExists(as_File) then li_Return = -1
if li_Return = 0 then 
	iuo_Amyuni.ScaleToFit = ab_ScaleToFit
	li_Return = iuo_Amyuni.of_print(as_File, as_Printer)
end if

return li_Return	
end function

on uo_pdf_handler.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_pdf_handler.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;DESTROY iuo_Amyuni
end event

event constructor;string ls_SystemDir

// Wenn vorhanden, Amyuni 5.00 w$$HEX1$$e400$$ENDHEX$$hlen, sonst Amyuni 4.50 w$$HEX1$$e400$$ENDHEX$$hlen, sonst Amyuni 2.51
ls_SystemDir = of_get_system_dir()

if FileExists(ls_SystemDir + "\cdintf550.dll") then
	iuo_Amyuni = create uo_amyuni
elseif FileExists(ls_SystemDir + "\cdintf500.dll") then
	iuo_Amyuni = create uo_amyuni_500
elseif FileExists(ls_SystemDir + "\cdintf450.dll") then
	iuo_Amyuni = create uo_amyuni_450
elseif FileExists(ls_SystemDir + "\cdintf251.dll") then
	iuo_Amyuni = create uo_amyuni_251
end if
end event

