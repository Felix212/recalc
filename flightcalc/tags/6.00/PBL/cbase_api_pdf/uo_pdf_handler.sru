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
// Some references to a test function of different Amyuni versions (used to determine the latest installed Amyuni version)
function long DriverInit251(string szPrinter) library "cdintf251.dll" alias for "DriverInit;Ansi"
function long DriverInit450(string szPrinter) library "cdintf450.dll" alias for "DriverInit;Ansi"
function long DriverInit500(string szPrinter) library "cdintf500.dll" alias for "DriverInit;Ansi"
function long DriverInit550(string szPrinter) library "cdintf550.dll" alias for "DriverInit;Ansi"
function long DriverInit600(string szPrinter) library "cdintf600.dll" alias for "DriverInit;Ansi"
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
public function integer of_add_bookmark (string as_file, string as_bookmark)
public function integer of_print (string as_file, string as_printer, boolean ab_scaletofit)
public function uo_amyuni of_get_amyuni_instance ()
public function integer of_get_bookmark_page (string as_file, string as_bookmark)
public function integer of_get_bookmarks (string as_file, string ras_bookmarks[])
public function integer of_get_page_count (string as_file)
public function integer of_split (string as_file, string as_prefix)
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
	if Integer(dwo.Describe("datawindow.print.Orientation")) = 1 then
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
	if Integer(dwo.Describe("datawindow.print.Orientation")) = 1 then
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

public function integer of_add_bookmark (string as_file, string as_bookmark);/* 
* Funktion/Event:	of_add_bookmark()
* Beschreibung:	F$$HEX1$$fc00$$ENDHEX$$gt ein Lesezeichen zu einem Dokument hinzu
* Besonderheit:	keine
*
* Argumente:
* 	Name					Beschreibung
*	as_File				Das Dokument, dem das Lesezeichen hinzugef$$HEX1$$fc00$$ENDHEX$$gt werden soll.
*	as_Bookmark		Das Lesezeichen, das hinzugef$$HEX1$$fc00$$ENDHEX$$gt werden soll.
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			O.Hoefer		19.05.2017		Erstellung
*
* Return Codes:
*	0		Alles OK
*/

/*
* Objekt: 	uo_pdf_handler
* Methode: 	of_add_bookmark (Function)
* Autor: 		Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum: 	16.05.2017
*
* Argument(e):
*   as_file			Pfad+Dateiname des Dokuments, dem das Lesezeichen hinzugef$$HEX1$$fc00$$ENDHEX$$gt werden soll.
*	as_bookmark	Titel des Lesezeichens.
*
* Beschreibung: F$$HEX1$$fc00$$ENDHEX$$gt ein Lesezeichen zu einem Dokument hinzu.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*	Version	Wer			Wann				Was und warum
*	1.0		O.Hoefer		16.05.2017		Erstellung
*	1.1		Dirk Bunk		25.09.2020		Aufr$$HEX1$$e400$$ENDHEX$$umen / Formatieren
*
* Return: 
*   0: OK
*  -1: Fehler
*/

return iuo_Amyuni.of_add_bookmark(as_File, as_file, as_Bookmark)
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

public function uo_amyuni of_get_amyuni_instance ();// WARNING:
// Use this reference to the internal Amyuni object only if you know what you are doing!
// In the most cases you should be fine by using the wrapped functions from this class.

return iuo_Amyuni
end function

public function integer of_get_bookmark_page (string as_file, string as_bookmark);/*
* Objekt : 	uo_pdf_handler
* Methode: 	of_get_bookmark_page (Function)
* Autor: 		Dirk Bunk
* Datum: 	25.09.2020
*
* Argument(e):
*   as_file			Pfad+Dateiname des Quelldokuments.
*	as_bookmark	Titel des Lesezeichens, das gesucht werden soll.
*
* Beschreibung: Sucht ein Lesezeichen in einem Dokument und gibt die gefundene Seite zur$$HEX1$$fc00$$ENDHEX$$ck.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*	Version	Wer			Wann				Was und warum
*	1.0		O.Hoefer		16.05.2017		Erstellung
*	1.1		Dirk Bunk		25.09.2020		Aufr$$HEX1$$e400$$ENDHEX$$umen / Formatieren
*
* Return: 
*   >0:	Seite des Lesezeichens
*    -1: 	Fehler
*/

return iuo_Amyuni.of_get_bookmark_page(as_File, as_Bookmark)
end function

public function integer of_get_bookmarks (string as_file, string ras_bookmarks[]);/*
* Objekt : 	uo_pdf_handler
* Methode: 	of_get_bookmarks (Function)
* Autor: 		Dirk Bunk
* Datum: 	25.09.2020
*
* Argument(e):
*	as_file				Pfad+Dateiname des Quelldokuments.
* 	ras_bookmarks		Array mit den gefundenen Lesezeichen.
*
* Beschreibung: Sucht alle Lesezeichen in einem Dokument und bef$$HEX1$$fc00$$ENDHEX$$llt ein Ziel Array damit.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*	Version	Wer			Wann				Was und warum
*	1.0		O.Hoefer		16.05.2017		Erstellung
*	1.1		Dirk Bunk		25.09.2020		Aufr$$HEX1$$e400$$ENDHEX$$umen / Formatieren
*
* Return: 
*     0:	OK
*    -1: 	Fehler
*/

return iuo_Amyuni.of_get_bookmarks(as_File, ras_Bookmarks)
end function

public function integer of_get_page_count (string as_file);/*
* Objekt : uo_pdf_handler
* Methode: of_get_page_count (Function)
* Autor  : Dirk Bunk
* Datum  : 25.09.2020
*
* Argument(e):
*   as_file    Pfad+Dateiname des Dokuments, bei dem die Seitenzahl ausgelesen werden soll.
*
* Beschreibung: Liest die Seitenzahl eines Dokuments aus.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*	Version	Wer			Wann				Was und warum
*	1.0		Dirk Bunk		25.09.2020		Erstellung
*
* Return: 
*	Seitenzahl des Dokuments
*	0: H$$HEX1$$f600$$ENDHEX$$chstwahrscheinlich ein Fehler
*/

return iuo_Amyuni.of_get_page_count(as_File)
end function

public function integer of_split (string as_file, string as_prefix);/*
* Objekt : uo_pdf_handler
* Methode: of_split (Function)
* Autor  : Dirk Bunk
* Datum  : 25.09.2020
*
* Argument(e):
*   as_file		Pfad+Dateiname des Dokuments, das aufgeteilt werden soll.
*   as_prefix	Pfad+Prefix f$$HEX1$$fc00$$ENDHEX$$r die einzelnen Seiten (z.B.: test.pdf wird zu test1.pdf, test2.pdf, usw.).
*
* Beschreibung: Zerteilt ein Dokument in einzelne Seiten.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*	Version	Wer			Wann				Was und warum
*	1.0		Dirk Bunk		25.09.2020		Erstellung
*
* Return: 
*	  0	: Ok
*	<0	: Fehler
*/

return iuo_Amyuni.of_split(as_File, as_Prefix)
end function

public function integer of_set_title (string as_file, string as_title);/*
* Objekt:	uo_amyuni
* Methode:	of_set_title (Function)
* Autor:		Dirk Bunk
* Datum: 	25.09.2020
*
* Argument(e):
*   as_file    Pfad+Dateiname des Dokuments, f$$HEX1$$fc00$$ENDHEX$$r welches der Titel ge$$HEX1$$e400$$ENDHEX$$ndert werden soll.
*   as_title   Der neue Titel des Dokuments.
*
* Beschreibung: $$HEX1$$c400$$ENDHEX$$nder den Titel eines Dokuments.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*	Version	Wer			Wann				Was und warum
*	1.0		O.Hoefer		25.06.2015		Erstellung
*	1.1		Dirk Bunk		28.02.2017		Header / R$$HEX1$$fc00$$ENDHEX$$ckgabewert angepasst
*	1.2		Dirk Bunk		25.09.2020		Refactoring
*
* Return: 
*   0: OK
*  -1: Fehler
*/

return iuo_Amyuni.of_set_title(as_File, as_Title)
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

event constructor;// Trying to access Amyuni 6.00
If Not IsValid(iuo_Amyuni) Then
	Try
		DriverInit600("")
		iuo_Amyuni = CREATE uo_amyuni_600
	Catch(RuntimeError ex600)
	End Try
End If

// Trying to access Amyuni 5.50
If Not IsValid(iuo_Amyuni) Then
	Try
		DriverInit550("")
		iuo_Amyuni = CREATE uo_amyuni_550
	Catch(RuntimeError ex550)
	End Try
End If

// Trying to access Amyuni 5.00
If Not IsValid(iuo_Amyuni) Then
	Try
		DriverInit500("")
		iuo_Amyuni = CREATE uo_amyuni_500
	Catch(RuntimeError ex500)
	End Try
End If

// Trying to access Amyuni 4.50
If Not IsValid(iuo_Amyuni) Then
	Try
		DriverInit450("")
		iuo_Amyuni = CREATE uo_amyuni_450
	Catch(RuntimeError ex450)
	End Try
End If

// Trying to access Amyuni 2.51
If Not IsValid(iuo_Amyuni) Then
	Try
		DriverInit251("")
		iuo_Amyuni = CREATE uo_amyuni_251
	Catch(RuntimeError ex251)
	End Try
End If
end event

