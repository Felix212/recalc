HA$PBExportHeader$uo_pdf_handler.sru
$PBExportComments$PDF Funktionalit$$HEX1$$e400$$ENDHEX$$t
forward
global type uo_pdf_handler from nonvisualobject
end type
end forward

global type uo_pdf_handler from nonvisualobject
end type
global uo_pdf_handler uo_pdf_handler

type variables
PRIVATE:
uo_amyuni iuo_Amyuni
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
public function integer of_set_title (string as_file, string as_title)
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

integer li_Return = 0

// PDF-File drucken
if not FileExists(as_File) then li_Return = -1
if li_Return = 0 then 
	li_Return = iuo_Amyuni.of_print(as_File, as_Printer)
end if

return li_Return	
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
if ab_AutoAdjustFormat then f_adjust_datastore_paperformat(ads_Data)

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
if ab_AutoAdjustFormat then f_adjust_datawindow_paperformat(adw_Data)

// Drucker vorbereiten
iuo_Amyuni.of_prepare_printer(as_Output, as_Title, ab_Grayscale, ab_Watermark, ab_Encrypted)

// Dokument drucken
if adw_Data.print(false) <> 1 then li_Return = -1

return li_Return
end function

public function integer of_set_title (string as_file, string as_title);
// --------------------------------------------------------------------------------
// Objekt : uo_pdf_handler
// Methode: of_set_title (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 25.06.2015
//
// Argument(e):
//	 string as_file
//	 string as_title
//
// Beschreibung:		Set Document Title
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	25.06.2015		Erstellung
//
//
// Return: integer
//
// --------------------------------------------------------------------------------


integer li_Return = 0

if not FileExists(as_File) then li_Return = -1

if li_Return = 0 then 

	li_Return = iuo_Amyuni.of_set_title( as_file, as_title) //   _print(as_File, as_Printer)
	
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
ls_SystemDir = f_get_system_dir()
if FileExists(ls_SystemDir + "\cdintf500.dll") then
	iuo_Amyuni = create uo_amyuni
elseif FileExists(ls_SystemDir + "\cdintf450.dll") then
	iuo_Amyuni = create uo_amyuni_450
elseif FileExists(ls_SystemDir + "\cdintf251.dll") then
	iuo_Amyuni = create uo_amyuni_251
end if
end event

