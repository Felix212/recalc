HA$PBExportHeader$uo_amyuni.sru
$PBExportComments$Wrapper f$$HEX1$$fc00$$ENDHEX$$r "Amyuni PDF Converter" Funktionen
forward
global type uo_amyuni from nonvisualobject
end type
end forward

global type uo_amyuni from nonvisualobject
end type
global uo_amyuni uo_amyuni

type prototypes
PRIVATE:

function boolean SetLicenseKey(string szCompany, string szLicKey) library "cdintf550.dll" alias for "SetLicenseKeyA;Ansi"
function integer Lock(long hPrinter, string szLockName) library "cdintf550.dll" alias for "Lock;Ansi"
function integer TestLock(long hPrinter, string szLockName) library "cdintf550.dll" alias for "TestLock;Ansi"
function integer Unlock(long hPrinter, string szLockName, long dwTimeout) library "cdintf550.dll" alias for "Unlock;Ansi"
function integer SetDocFileProps(long hPrinter, string szDocTitle, long lOptions, string szFileDir, string szFileName) library "cdintf550.dll" alias for "SetDocFileProps;Ansi"
function integer DocOpen(ref long pedhDocument, string szFileName, string szPassword) library "cdintf550.dll" alias for "DocOpenA;Ansi"
function integer DocSave(long edhDocument, string szFileName) library "cdintf550.dll" alias for "DocSaveA;Ansi"
function integer DocPrint(long edhDocument, string szPrinterName, long lStartPage, long lEndPage, long lCopies) library "cdintf550.dll" alias for "DocPrintA;Ansi"
function integer DocAppend(long edhDocument, long edhSource) library "cdintf550.dll" alias for "DocAppend;Ansi"
function integer DocMerge(long edhDocument, long edhSource, boolean fRepeat, boolean fAbove) library "cdintf550.dll" alias for "DocMerge;Ansi"
function integer DocClose(long edhDocument) library "cdintf550.dll" alias for "DocClose;Ansi"
function long DocSetTitle(long edhDocument, string szValue) library "cdintf550.dll" alias for "DocSetTitleA;Ansi"
function long SetWatermark(long hPrinter, string szWatermark, string szFont, integer fontSize, integer Orientation, ulong color, long xPos, long yPos, boolean bForeground) library "cdintf550.dll" alias for "SetWatermark;Ansi"
function long EnablePrinter(long hPrinter, string szCompany, string szCode) library "cdintf550.dll" alias for "EnablePrinter;Ansi"
function long DriverInit(string szPrinter) library "cdintf550.dll" alias for "DriverInit;Ansi"
//function integer DocOptimize(long edhDocument, integer iLevel) library "cdintf550.dll" alias for "DocOptimize;Ansi"
//function long BatchConvertEx(long hPrinter, string szFileName) library "cdintf550.dll" alias for "BatchConvertEx;Ansi"

subroutine DriverEnd(long hPrinter) library "cdintf550.dll" alias for "DriverEnd;Ansi"
subroutine GetLastErrorMsg(ref string Msg, long MaxMsg) library "cdintf550.dll" alias for "GetLastErrorMsg;Ansi"

// HINWEIS:
// DocOptimize macht leider Probleme, wenn es mehrmals aufgerufen wird (komischerweise geht es in der $$HEX1$$fc00$$ENDHEX$$bersetzten Version).
// Es k$$HEX1$$f600$$ENDHEX$$nnte allerdings m$$HEX1$$f600$$ENDHEX$$gliche Probleme mit PDF Dokumenten beheben, die nicht mit Amyuni erstellt wurden.
// Da es aber zur Zeit noch keinen Bedarf gibt, es zu verwenden, ist es auskommentiert.
//
// BatchConvertEx funktioniert leider nicht mit der neuen SetDocFileProps Funktion zusammen, mit der es m$$HEX1$$f600$$ENDHEX$$glich w$$HEX1$$e400$$ENDHEX$$re,
// mehrere Dateien gleichzeitig nach PDF zu konvertieren.
// Stattdessen m$$HEX1$$fc00$$ENDHEX$$ssen f$$HEX1$$fc00$$ENDHEX$$r jeden Auftrag Defaults f$$HEX1$$fc00$$ENDHEX$$r den PDF Drucker definiert werden, was keine gute Idee ist.
end prototypes

type variables
PUBLIC:
// Properties
indirect string LastError {set_last_error(*value), get_last_error()}
indirect string PrinterName {set_printer_name(*value), get_printer_name()}
indirect boolean ScaleToFit {set_scale_to_fit(*value), get_scale_to_fit()}

PROTECTED:
string is_LicenseCompany
string is_LicenseKey

string is_PDFCreatorOLE

PRIVATE:
string is_LastError
string is_PrinterName
string is_LockName

boolean ib_ScaleToFit = false

long il_PrinterHandle

// Die h$$HEX1$$f600$$ENDHEX$$chstm$$HEX1$$f600$$ENDHEX$$gliche Seitenanzahl 
constant long MAX_PAGES = 2147483647

// Die wichtigsten Optionen f$$HEX1$$fc00$$ENDHEX$$r den PDF Drucker.
// Mehr unter: http://www.amyuni.com/WebHelp/Amyuni_Document_Converter/Printer_Configuration/Properties/FileNameOptions,_FileNameOptionsEx.htm
constant long OPTION_NO_PROMPT						= 1			// Prevents the display of the file name dialog box.
constant long OPTION_USE_FILE_NAME					= 2			// Use the file name set by SetDefaultFileName as the output file name.
constant long OPTION_CONCATENATE					= 4			// Concatenate with existing file instead of overwriting. This is useful only if the NoPrompt option is set.
constant long OPTION_EMBED_FONTS					= 16			// Enable embedding of fonts used in the source document.
constant long OPTION_PRINT_WATERMARK				= 64			// Watermarks are printed on all printed pages.
constant long OPTION_MULTILINGUAL_SUPPORT		= 128			// Add supports for international character sets.
constant long OPTION_ENCRYPT_DOCUMENT			= 256			// Encrypt resulting document.
constant long OPTION_FULL_EMBED						= 512			// Embed full fonts as opposed to embedding the fonts partially.
constant long OPTION_LINEARIZE_FOR_WEB			= 32768		// Activate web optimization (Linearization) of PDF document.
constant long OPTION_COLORS_2_GRAY_SCALE		= 524288	// Replaces all colors by an equivalent gray scale value.
constant long OPTION_EMBED_STANDARD_FONTS	= 2097152	// Embed standard fonts such as Arial, Times, etc.
constant long OPTION_EMBED_LICENSED_FONTS		= 4194304	// Embed fonts requiring a license.
constant long OPTION_EMBED_SIMULATED_FONTS	= 16777216	// Embed Italic or Bold fonts that do not have an associated font file but are simulated by the system.

// Printing Attributes (f$$HEX1$$fc00$$ENDHEX$$r den Amyuni Creator)
// Mehr unter: https://www.amyuni.com/WebHelp/Developer_Documentation.htm#Amyuni_PDF_Creator_for_ACTIVE_X/Using_the_PDF_Creator_Control/Attributes/Document_Attributes.htm
constant uint AC_SCALE_NONE 			= 0
constant uint AC_SCALE_HORIZONTAL 	= 1
constant uint AC_SCALE_VERTICAL 		= 2
constant uint AC_SCALE_BOTH 			= 3
constant uint AC_SCALE_ROTATE_PAGE 	= 4
end variables

forward prototypes
private function string get_last_error ()
private subroutine set_printer_name (string as_value)
private subroutine set_last_error (string as_value)
private function string get_printer_name ()
public function integer of_concatenate (string as_inputfiles[], string as_output, boolean ab_delete)
public function integer of_print (string as_file, string as_printer, long al_start, long al_end)
public function integer of_print (string as_file, string as_printer)
public function integer of_merge (string as_source, string as_target, string as_output, boolean ab_repeat, boolean ab_above, boolean ab_delete)
private function string of_get_last_error ()
private function integer of_enable_printer ()
private function integer of_unlock ()
public function integer of_pdf_to_grayscale (string as_file, string as_output)
public function integer of_set_watermark (string as_text, string as_font, integer ai_size, integer ai_orientation, long al_color, long al_offset_x, long al_offset_y, boolean ab_above)
private function integer of_lock (string as_lockname)
public function integer of_prepare_printer (string as_output, string as_doctitle)
private function integer of_mask_lock_name (ref string as_lockname)
public function integer of_prepare_printer (string as_output, string as_doctitle, boolean ab_grayscale, boolean ab_watermark, boolean ab_encrypted)
public function integer of_set_title (string as_file, string as_title)
public function integer of_add_bookmark (string as_file, string as_output, string as_bookmark)
public function integer of_get_bookmarks (string as_file, ref string ras_bookmarks[])
public function integer of_get_bookmark_page (string as_file, string as_bookmark)
public function boolean get_scale_to_fit ()
private subroutine set_scale_to_fit (boolean ab_value)
end prototypes

private function string get_last_error ();/*
* Objekt : uo_amyuni
* Methode: get_last_error (Getter Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt den zuletzt aufgetretenen Fehler zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*
* Return: 
*   Der zuletzt aufgetretene Fehler.
*/

return is_LastError
end function

private subroutine set_printer_name (string as_value);/*
* Objekt : uo_amyuni
* Methode: set_printer_name (Setter Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   as_value Der Name des aktuell gew$$HEX1$$e400$$ENDHEX$$hlten Druckers.
*
* Beschreibung: Setzt den Namen des aktuell gew$$HEX1$$e400$$ENDHEX$$hlten Druckers und initialisiert ihn.	
*
*      Hinweis: Es sollten nat$$HEX1$$fc00$$ENDHEX$$rlich nur Amyuni Drucker gew$$HEX1$$e400$$ENDHEX$$hlt werden.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*
* Return: 
*   none
*/

integer li_ret = 0

// Evtl. bestehendes Handle beenden
try
	if il_PrinterHandle > 0 then DriverEnd(il_PrinterHandle)
catch (RuntimeError ex1)
	li_ret = -1
end try

// Den neuen Drucker initialisieren
try
	il_PrinterHandle = DriverInit(as_value)
catch (RuntimeError ex2)
	li_ret = -1
end try

// Wenn alles geklappt hat, den Namen des Druckers merken
if li_ret = 0 then 
	is_PrinterName = as_value
else
	is_LastError = of_get_last_error()
end if
end subroutine

private subroutine set_last_error (string as_value);// EMPTY SETTER FUNCTION
end subroutine

private function string get_printer_name ();/*
* Objekt : uo_amyuni
* Methode: get_printer_name (Getter Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt den Namen des aktuell gew$$HEX1$$e400$$ENDHEX$$hlten Druckers zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*
* Return: 
*   Der Name des aktuell gew$$HEX1$$e400$$ENDHEX$$hlten Druckers.
*/

return is_PrinterName
end function

public function integer of_concatenate (string as_inputfiles[], string as_output, boolean ab_delete);/*
* Objekt : uo_amyuni
* Methode: of_concatenate (Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   as_InputFiles[] String-Array mit Pfad+Dateinamen der PDF Dateien, die zusammengef$$HEX1$$fc00$$ENDHEX$$gt werden sollen.
*   as_Output       Pfad+Dateiname der Ausgabe PDF Datei.
*   ab_Delete       Boolean-Flag, das angibt, ob die Quelldateien anschlie$$HEX1$$df00$$ENDHEX$$end gel$$HEX1$$f600$$ENDHEX$$scht werden sollen.
*
* Beschreibung: Konkatiniert mehrere PDF Dateien zusammen zu einem Dokument.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*   1.1        Dirk Bunk    05.03.2013    Vor dem L$$HEX1$$f600$$ENDHEX$$schen nochmal pr$$HEX1$$fc00$$ENDHEX$$fen, ob das Dokument $$HEX1$$fc00$$ENDHEX$$berhaupt vorhanden ist
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_ret
long i, ll_DocHandle, ll_TempDocHandle

// Das erste Dokument der Liste $$HEX1$$f600$$ENDHEX$$ffnen
if UpperBound(as_InputFiles) > 0 then
	li_ret = DocOpen(ll_DocHandle, as_InputFiles[1], "")
	if li_ret <> 0 then is_LastError = "Failed to open document: " + as_InputFiles[1]
else
	is_LastError = "Not enough files to concatenate."
	li_ret = -1
end if

// Die restlichen Dokumente anh$$HEX1$$e400$$ENDHEX$$ngen
if li_ret = 0 then
	for i = 2 to UpperBound(as_InputFiles)
		// Das n$$HEX1$$e400$$ENDHEX$$chste Dokument $$HEX1$$f600$$ENDHEX$$ffnen...
		li_ret = DocOpen(ll_TempDocHandle, as_InputFiles[i], "")
		if li_ret <> 0 then is_LastError = "Failed to open document: " + as_InputFiles[i]
		
		// ...und an das Hauptdokument anh$$HEX1$$e400$$ENDHEX$$ngen
		if li_ret = 0 then
			li_ret = DocAppend(ll_DocHandle, ll_TempDocHandle)
			if li_ret <> 0 then is_LastError = "Failed to append document: " + as_InputFiles[i]
		end if
		
		// Das tempor$$HEX1$$e400$$ENDHEX$$re Dokument schlie$$HEX1$$df00$$ENDHEX$$en
		DocClose(ll_TempDocHandle)
		
		// Wenn etwas nicht geklappt hat, beenden wir den Vorgang
		if li_ret <> 0 then exit
	next
end if

// Das konkatinierte Dokument speichern
if li_ret = 0 then
	li_ret = DocSave(ll_DocHandle, as_Output)
	if li_ret <> 0 then is_LastError = "Failed to save document: " + as_Output
end if

// Das Hauptdokument schlie$$HEX1$$df00$$ENDHEX$$en
DocClose(ll_DocHandle)

// Evtl. noch die Quelldokumente l$$HEX1$$f600$$ENDHEX$$schen
if li_ret = 0 and ab_Delete then
	for i = 1 to UpperBound(as_InputFiles)
		// Vorher nochmal pr$$HEX1$$fc00$$ENDHEX$$fen, ob das Dokument $$HEX1$$fc00$$ENDHEX$$berhaupt vorhanden ist
		if not FileExists(as_InputFiles[i]) then continue
		
		// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob das L$$HEX1$$f600$$ENDHEX$$schen auch klappt
		if FileDelete(as_InputFiles[i]) = false then
			is_LastError = "Failed to delete document: " + as_InputFiles[i]
			li_ret = -1
		end if
	next
end if

return li_ret
end function

public function integer of_print (string as_file, string as_printer, long al_start, long al_end);/*
* Objekt : uo_amyuni
* Methode: of_print (Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   as_file    Pfad+Dateiname des Dokuments, welches gedruckt werden soll.
*   as_printer Der Name des Druckers, auf den gedruckt werden soll.
*   al_start   Die Nummer der ersten Seite, die gedruckt werden soll.
*   al_end     Die Nummer der letzten Seite, die gedruckt werden soll.
*
* Beschreibung: Druckt ein PDF Dokument auf einem beliebigen Drucker.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*   1.1		Dirk Bunk	11.07.2017	ScaleToFit Schalter ber$$HEX1$$fc00$$ENDHEX$$cksichtigt.        
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_ret
long i, ll_DocHandle, ll_page
OLEObject lole_pdf

// HINWEIS:
// Die ScaleToFit Option ist etwas experimentell, da sie nur $$HEX1$$fc00$$ENDHEX$$ber das OLE Objekt von Amyuni verf$$HEX1$$fc00$$ENDHEX$$gbar ist und daher ein anderes Handling braucht.
// Allerdings ist es bisher der einzige Workaround, der bei dem Ausrichtungsproblem hilft, das bei manchen Zebra-Druckern auftritt.
if ScaleToFit then
	lole_pdf = create OLEObject
	
	li_ret = lole_pdf.ConnectToNewObject(is_PDFCreatorOLE)
	if li_ret = 0 then
		// Das Dokument $$HEX1$$f600$$ENDHEX$$ffnen
		if lole_pdf.Open(as_file, "") then 
			// Lizenz aktivieren, damit mehr als eine Seite gedruckt wird
			lole_pdf.SetLicenseKey(is_LicenseCompany, is_LicenseKey)
			
			// Skalierung festlegen
			lole_pdf.ScaleToPrinter = AC_SCALE_BOTH
						
			// Druck starten
			lole_pdf.StartPrint(as_printer, 0)

			// Nummer der letzten Seite begrenzen
			if al_end > lole_pdf.PageCount then al_end = lole_pdf.PageCount

			// Drucken
			for ll_page = al_start to al_end
				lole_pdf.PrintPage(ll_page)
			next
	 
			// Druck beenden
	    		lole_pdf.EndPrint()
		else
			is_LastError = "Failed to open document: " + as_file
		end if
				
		lole_pdf.DisconnectObject()
	end if
	
	destroy lole_pdf
else
	// Das Dokument $$HEX1$$f600$$ENDHEX$$ffnen
	li_ret = DocOpen(ll_DocHandle, as_file, "")
	if li_ret <> 0 then is_LastError = "Failed to open document: " + as_file
	
	// Lizenz aktivieren, damit mehr als eine Seite gedruckt wird
	if li_ret = 0 then
		if SetLicenseKey(is_LicenseCompany, is_LicenseKey) = false then
			li_ret = -1
			is_LastError = "Failed to activate license!"
		end if
	end if
	
	// Das Dokument drucken
	if li_ret = 0 then
		li_ret = DocPrint(ll_DocHandle, as_printer, al_start, al_end, 1)
		if li_ret <> 0 then is_LastError = "Failed to print document: " + as_file
	end if
	
	// Das Dokument schlie$$HEX1$$df00$$ENDHEX$$en
	DocClose(ll_DocHandle)
end if

return li_ret
end function

public function integer of_print (string as_file, string as_printer);return of_print(as_file, as_printer, 1, MAX_PAGES)
end function

public function integer of_merge (string as_source, string as_target, string as_output, boolean ab_repeat, boolean ab_above, boolean ab_delete);/*
* Objekt : uo_amyuni
* Methode: of_merge (Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   as_source Pfad+Dateiname des Quelldokuments (Dieses wird $$HEX1$$fc00$$ENDHEX$$ber das Zieldokument gelegt).
*   as_target Pfad+Dateiname des Zieldokuments.
*   as_output Pfad+Dateiname des Ausgabedokuments.
*   ab_repeat Gibt an, ob das Quelldokument wiederholt werden soll, wenn das Zieldokument mehr Seiten hat.
*   ab_above  Gibt an, ob das Quelldokument $$HEX1$$fc00$$ENDHEX$$ber (true) oder unter (false) das Zieldokument gelegt wird.
*   ab_delete Gibt an, ob die Quell- u. Zieldokumente gel$$HEX1$$f600$$ENDHEX$$scht werden sollen, wenn alles fertig ist.
*
* Beschreibung: F$$HEX1$$fc00$$ENDHEX$$gt zwei PDF Dateien zusammen zu einem Dokument (Z.B. f$$HEX1$$fc00$$ENDHEX$$r Wasserzeichen).	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*   1.1        Dirk Bunk    05.03.2013    Vor dem L$$HEX1$$f600$$ENDHEX$$schen nochmal pr$$HEX1$$fc00$$ENDHEX$$fen, ob das Dokument $$HEX1$$fc00$$ENDHEX$$berhaupt vorhanden ist
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_ret
long i, ll_TargetDocHandle, ll_SourceDocHandle

// Das Zieldokument $$HEX1$$f600$$ENDHEX$$ffnen
li_ret = DocOpen(ll_TargetDocHandle, as_target, "")
if li_ret <> 0 then is_LastError = "Failed to open document: " + as_target

// Das Quelldokument $$HEX1$$f600$$ENDHEX$$ffnen (Dieses wird quasi mit dem Zieldokument gemischt)
if li_ret = 0 then
	li_ret = DocOpen(ll_SourceDocHandle, as_source, "")
	if li_ret <> 0 then is_LastError = "Failed to open document: " + as_source
end if

// Die beiden Dokumente $$HEX1$$fc00$$ENDHEX$$bereinanderlegen
if li_ret = 0 then
	li_ret = DocMerge(ll_TargetDocHandle, ll_SourceDocHandle, ab_repeat, ab_above)
	if li_ret <> 0 then is_LastError = "Failed to merge documents: " + as_target + " | " + as_source
end if

// Das gemischte Dokument speichern
if li_ret = 0 then
	li_ret = DocSave(ll_TargetDocHandle, as_output)
	if li_ret <> 0 then is_LastError = "Failed to save document: " + as_output
end if

// Dokumente schlie$$HEX1$$df00$$ENDHEX$$en
DocClose(ll_TargetDocHandle)
DocClose(ll_SourceDocHandle)

// Evtl. noch die Quelldokumente l$$HEX1$$f600$$ENDHEX$$schen
if li_ret = 0 and ab_delete then
	// Vorher nochmal pr$$HEX1$$fc00$$ENDHEX$$fen, ob das Dokument $$HEX1$$fc00$$ENDHEX$$berhaupt vorhanden ist
	if FileExists(as_target) then
		if FileDelete(as_target) = false then
			is_LastError = "Failed to delete document: " + as_target
			li_ret = -1
		end if
	end if
	
	// Vorher nochmal pr$$HEX1$$fc00$$ENDHEX$$fen, ob das Dokument $$HEX1$$fc00$$ENDHEX$$berhaupt vorhanden ist
	if FileExists(as_source) then
		if FileDelete(as_source) = false then
			is_LastError = "Failed to delete document: " + as_source
			li_ret = -1
		end if
	end if
end if

return li_ret
end function

private function string of_get_last_error ();/*
* Objekt : uo_amyuni
* Methode: of_get_last_error (Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt die zuletzt aufgetretene Fehlermeldung des PDF Converters zur$$HEX1$$fc00$$ENDHEX$$ck.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*
* Return: 
*   Die zuletzt aufgetretene Fehlermeldung des PDF Converters.
*/

string ls_msg

ls_msg = Space(1024)
GetLastErrorMsg(ls_msg, 1024)
ls_msg = Trim(String(Blob(ls_msg, EncodingUTF16LE!), EncodingANSI!))

return ls_msg
end function

private function integer of_enable_printer ();/*
* Objekt : uo_amyuni
* Methode: of_enable_printer (Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Aktiviert den PDF Drucker.
*   Siehe auch: http://www.amyuni.com/WebHelp/Amyuni_Document_Converter/Printer_Installation_and_Activation/Methods/EnablePrinter.htm
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_ret = 0

try
	if EnablePrinter(il_PrinterHandle, is_LicenseCompany, is_LicenseKey) <> 1 then li_ret = -1
catch (RuntimeError ex)
	li_ret = -1
end try

return li_ret
end function

private function integer of_unlock ();/*
* Objekt : uo_amyuni
* Methode: of_unlock (Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Hebt eine evtl. bestehende Sperre eines Dokuments auf.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/


integer li_ret = 0

try
	// Bestehendes Lock aufheben
	if il_PrinterHandle > 0 and is_LockName <> "" then
		li_ret = Unlock(il_PrinterHandle, is_LockName, 1000)
	else
		li_ret = -1
	end if
catch (RuntimeError ex)
	li_ret = -1
end try

return li_ret
end function

public function integer of_pdf_to_grayscale (string as_file, string as_output);/*
* Objekt : uo_amyuni
* Methode: of_pdf_to_grayscale (Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   as_file   Pfad+Dateiname des Quelldokuments.
*   as_output Pfad+Dateiname des Ausgabedokuments.
*
* Beschreibung: Wandelt ein PDF in Graustufen um.
*
*      WARNUNG: Die Funktion ist sehr experimentell, und funktioniert zur Zeit nur bedingt.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_ret = 0
long i, j, ll_PageCount
OLEObject lole_pdf
OLEObject objarray[]

constant integer OBJECT_TYPE_PICTURE = 7

lole_pdf = CREATE OLEObject

try
	li_ret = lole_pdf.ConnectToNewObject("PDFCreactiveX.PDFCreactiveX")
	
	if li_ret = 0 then
		lole_pdf.SetLicenseKey(is_LicenseCompany, is_LicenseKey)
		lole_pdf.Open(as_file, "")
		
		// Alle Seiten des Dokuments durchlaufen
		ll_PageCount = Long(lole_pdf.PageCount)
		for i = 1 to ll_PageCount
			objarray = lole_pdf.ObjectAttribute("Pages[" + String(i) + "]", "Objects")
			
			// Alle Objekte der Seite durchlaufen und Bilder auf Graustufen setzen (Funktioniert nicht bei jedem Bild o_0)
			for j = 1 to UpperBound(objarray)
				try
					if objarray[j].Attribute("ObjectType") = OBJECT_TYPE_PICTURE then
						objarray[j].Attribute("GrayScale", true)
					end if
				catch (RuntimeError ex2)
				end try
			next
		next
		
		lole_pdf.save(as_output, 0)
		lole_pdf.DisconnectObject()
	end if
catch (RuntimeError ex1)
	li_ret = -1
end try

DESTROY lole_pdf

return li_ret
end function

public function integer of_set_watermark (string as_text, string as_font, integer ai_size, integer ai_orientation, long al_color, long al_offset_x, long al_offset_y, boolean ab_above);/*
* Objekt : uo_amyuni
* Methode: of_set_watermark (Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   as_text        Der Text des Wasserzeichens.
*   as_font        Name der Schriftart des Wasserzeichens.
*   ai_size        Gr$$HEX2$$f600df00$$ENDHEX$$e der Schriftart des Wasserzeichens in 0.1 Inch Schritten.
*   ai_orientation Ausrichtung des Wasserzeichens in 0.1 Grad Schritten.
*   al_color       Farbe des Wasserzeichens.
*   al_offset_x    Versatz auf der X-Achse des Wasserzeichens.
*   al_offset_y    Versatz auf der Y-Achse des Wasserzeichens.
*   ab_above       Gibt an, ob das Wasserzeichen $$HEX1$$fc00$$ENDHEX$$ber- oder unterlegt werden soll.
*
* Beschreibung: Legt ein Wasserzeichen f$$HEX1$$fc00$$ENDHEX$$r den aktuellen Amyuni-Drucker fest.
*
*      Hinweis: Damit das Wasserzeichen auch gedruckt wird, muss beim Aufruf von
*               of_prepare_printer, das Flag ab_Watermark auf true gesetzt werden.
*
*      WARNUNG: Da das Wasserzeichen pro Drucker und nicht pro Druckauftrag gesetzt wird,
*               kann es theoretisch sein, dass ein anderer Prozess das Wasserzeichen $$HEX1$$e400$$ENDHEX$$ndert,
*               bevor der Druck ausgef$$HEX1$$fc00$$ENDHEX$$hrt wurde!
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*   1.1        Dirk Bunk    29.12.2012    Warnung hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_ret = 0

try
	if SetWatermark(il_PrinterHandle, as_text, as_font, ai_size, ai_orientation, al_color, al_offset_x, al_offset_y, ab_above) <> 1 then li_ret = -1
catch (RuntimeError ex)
	li_ret = -1
end try

return li_ret
end function

private function integer of_lock (string as_lockname);/*
* Objekt : uo_amyuni
* Methode: of_lock (Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   as_LockName Der Titel des Dokuments, das gesperrt werden soll.
*
* Beschreibung: Sperrt den Titel eines Dokuments, das gedruckt werden soll, um Probleme bei
*               gleichzeitigem Zugriff mehrerer Prozesse zu vermeiden.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

/* 
HINWEIS ZUR VERWENDUNG DER LOCK FUNKTION:

The Lock function can be used in multi-threading situations to avoid conflicts between multiple applications 
or multiple threads requesting simultaneous access the Converter products.
The CDIntf library uses the registry to interact with the printer drivers. 
When the Lock function is used, the output file name and options (all set functions) are set 
using the SetDocFileProps function and not from the SetDefaultFileName and SetFileNameOptions functions.

The Lock() function requires the developer to pass the function the document title that is going to be printed. 
This is same document title that will appear in the print spooler. 
When implementing the Locking mechanism one way to quickly check how your printing application is 
generating document titles is to first pause the PDF Converter and then print to it. 
In the print spooler you will see the document name to use. 
If the PDF Converter is generating an $$HEX1$$1c20$$ENDHEX$$Open filename$$HEX2$$1d202000$$ENDHEX$$dialog box when using the SetDocFileProps() function, 
this typically means that the incorrect document title is being passed to the Lock() function.
*/

integer li_ret = 0
string ls_LockName

try
	if il_PrinterHandle > 0 and as_LockName <> "" then
		// Bestehendes Lock aufheben
		of_unlock()
		
		// Den Locknamen maskieren
		ls_LockName = as_LockName
		of_mask_lock_name(ls_LockName)
		
		// Neues Lock erstellen
		li_ret = Lock(il_PrinterHandle, ls_LockName)
		if li_ret = 0 then
			li_ret = TestLock(il_PrinterHandle, ls_LockName)
			
			// Das neue Lock als LockName merken
			if li_ret = 0 then is_LockName = ls_LockName
		end if
		
		if li_ret <> 0 then
			Sleep(1)
			li_ret = of_lock(ls_LockName)
		end if
	else
		li_ret = -1
	end if
catch (RuntimeError ex)
	li_ret = -1
end try

return li_ret
end function

public function integer of_prepare_printer (string as_output, string as_doctitle);/*
* Objekt : uo_amyuni
* Methode: of_prepare_printer (Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   as_Output   Pfad+Dateiname des Ausgabedokuments, welches erstellt werden soll.
*   as_DocTitle Titel des Ausgabedokuments, dieser wird beim Druck angezeigt, und dient au$$HEX1$$df00$$ENDHEX$$erdem zum Sperren.
*
* Beschreibung: Bereitet den aktuellen Amyuni Drucker f$$HEX1$$fc00$$ENDHEX$$r den Druck eines Dokuments vor.
*
* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
* WICHTIG: 
* Der DocTitle MUSS dem "Dokumentnamen" entsprechen, der auch beim Drucken angezeigt wird.
* Ansonsten erscheint ein Dialog zur Eingabe eines Dateinamens!
* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

return of_prepare_printer(as_Output, as_DocTitle, false, false, false)
end function

private function integer of_mask_lock_name (ref string as_lockname);/*
* Objekt : uo_amyuni
* Methode: of_mask_lock_name (Function)
* Autor  : Dirk Bunk
* Datum  : 13.12.2012
*
* Argument(e):
*   as_LockName Der Lockname, der maskiert werden soll.
*
* Beschreibung: Alle b$$HEX1$$f600$$ENDHEX$$sen Zeichen des Locknamens durch einen Unterstrich ersetzen.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    13.12.2012    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

long i, ll_Pos
string ls_BadCharacters[]

// Liste der b$$HEX1$$f600$$ENDHEX$$sen Zeichen erstellen
ls_BadCharacters[UpperBound(ls_BadCharacters) + 1] = ":"
ls_BadCharacters[UpperBound(ls_BadCharacters) + 1] = "\"

// Alle b$$HEX1$$f600$$ENDHEX$$sen Zeichen des Locknamens durch einen Unterstrich ersetzen
for i = 1 to UpperBound(ls_BadCharacters)
	do
		ll_Pos = Pos(as_LockName, ls_BadCharacters[i])
		if ll_Pos > 0 then as_LockName = Replace(as_LockName, ll_Pos, 1, "_")
	loop until ll_Pos = 0
next

return 0
end function

public function integer of_prepare_printer (string as_output, string as_doctitle, boolean ab_grayscale, boolean ab_watermark, boolean ab_encrypted);/*
* Objekt : uo_amyuni
* Methode: of_prepare_printer (Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   as_Output       Pfad+Dateiname des Ausgabedokuments, welches erstellt werden soll.
*   as_DocTitle     Titel des Ausgabedokuments, dieser wird beim Druck angezeigt, und dient au$$HEX1$$df00$$ENDHEX$$erdem zum Sperren.
*   ab_Grayscale    Gibt an, ob der Export in Graustufen erfolgen soll.
*   ab_Watermark    Gibt an, ob f$$HEX1$$fc00$$ENDHEX$$r den Export das aktuell gesetzte Wasserzeichen verwendet werden soll.
*   ab_Encrypted    Gibt an, ob der Export verschl$$HEX1$$fc00$$ENDHEX$$sselt sein soll (schreibgesch$$HEX1$$fc00$$ENDHEX$$tzt).
*
* Beschreibung: Bereitet den aktuellen Amyuni Drucker f$$HEX1$$fc00$$ENDHEX$$r den Druck eines Dokuments vor.
*
* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
* WICHTIG: 
* Der DocTitle MUSS dem "Dokumentnamen" entsprechen, der auch beim Drucken angezeigt wird.
* Ansonsten erscheint ein Dialog zur Eingabe eines Dateinamens!
* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*   1.1        Dirk Bunk    20.12.2012    Flags direkt mit in die Funktion aufgenommen
*   1.2        Dirk Bunk    21.10.2014    Multilanguage-Support und Font-Embedding ist jetzt immer an
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_ret
long ll_Options
string ls_Path, ls_File

if il_PrinterHandle > 0 then	
	// Dateipfad und -namen und einen Namen zum Sperren ermitteln
	ls_Path = Mid(as_output, 0, LastPos(as_Output, "\"))
	ls_File = Mid(as_output, LastPos(as_Output, "\") + 1)
	
	// Die Datei sperren
	li_ret = of_lock(as_DocTitle)
	
	// Den Drucker aktivieren
	if li_ret = 0 then
		li_ret = of_enable_printer()
	end if
	
	// Druckeroptionen festlegen
	if li_ret = 0 then
		// HINWEIS:
		// Hier wird absichtlich die Option "OPTION_FULL_EMBED" anstatt "OPTION_EMBED_FONTS" verwendet, obwohl dadurch etwas gr$$HEX2$$f600df00$$ENDHEX$$ere
		// PDF Dateien erzeugt werden. Das nur teilweise einbetten der Schriftarten durch "OPTION_EMBED_FONTS" f$$HEX1$$fc00$$ENDHEX$$hrt leider
		// teilweise zu Darstellungsproblemen im Amyuni Viewer. Stichwort "kryptische Zeichen".
		ll_Options = OPTION_NO_PROMPT + OPTION_USE_FILE_NAME + OPTION_FULL_EMBED + OPTION_MULTILINGUAL_SUPPORT
		if ab_Watermark then ll_Options += OPTION_PRINT_WATERMARK
		if ab_GrayScale then ll_Options += OPTION_COLORS_2_GRAY_SCALE
		if ab_Encrypted then ll_Options += OPTION_ENCRYPT_DOCUMENT
		
		li_ret = SetDocFileProps(il_PrinterHandle, is_LockName, ll_Options, ls_Path, ls_Path + ls_File)
	end if
else
	li_ret = -1
end if

return li_ret
end function

public function integer of_set_title (string as_file, string as_title);/*
* Objekt : uo_amyuni
* Methode: of_set_title (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 25.06.2015
*
* Argument(e):
*   as_file    Pfad+Dateiname des Dokuments, f$$HEX1$$fc00$$ENDHEX$$r welches der Titel ge$$HEX1$$e400$$ENDHEX$$ndert werden soll.
*   as_title   Der neue Titel des Dokuments.
*
* Beschreibung: Druckt ein PDF Dokument auf einem beliebigen Drucker.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version		Wer			Wann				Was und warum
*   1.0			O.Hoefer	25.06.2015	Erstellung
*	1.1			Dirk Bunk	28.02.2017	Header / R$$HEX1$$fc00$$ENDHEX$$ckgabewert angepasst
*
* Return: 
*   0: OK
*  -1: Fehler
*/

boolean	lb_Succ
integer	li_Succ
string	ls_Temp
integer	li_ret
long		ll_DocHandle

ls_temp = Left(as_file, Len(as_file) -4) + "_ori.pdf" 
li_Succ = FileMove(as_file, ls_temp)

// Das Dokument $$HEX1$$f600$$ENDHEX$$ffnen
li_ret = DocOpen(ll_DocHandle, ls_temp, "")
if li_ret <> 0 then is_LastError = "Failed to open document: " + ls_temp

// Lizenz aktivieren
if li_ret = 0 then
	if SetLicenseKey(is_LicenseCompany, is_LicenseKey) = false then
		li_ret = -1
		is_LastError = "Failed to activate license!"
		
		DocClose(ll_DocHandle)
		
		li_Succ = FileMove(ls_temp, as_file)
		
		return -1
	end if
end if

li_ret = DocSetTitle(ll_DocHandle, as_title)
li_ret = DocSave(ll_DocHandle, as_file)

// Das Dokument schlie$$HEX1$$df00$$ENDHEX$$en
DocClose(ll_DocHandle)

lb_Succ = FileDelete(ls_temp)

return 0

end function

public function integer of_add_bookmark (string as_file, string as_output, string as_bookmark);
// --------------------------------------------------------------------------------
// Objekt : uo_amyuni
// Methode: of_add_bookmark (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 16.05.2017
//
// Argument(e):
// string as_file
//	 string as_output
//	 string as_bookmark
//
// Beschreibung:		Bookmark / Lesezeichen
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	16.05.2017		Erstellung
//
//
// Return: integer
//
// --------------------------------------------------------------------------------


integer	li_ret = 0
long		ll_PageCount
Long		ll_CurrentPage
Long		ll_temp
String	ls_temp
Long		ll_rootcount, ll_Counter
String	ls_BM
Long		ll_Result
OLEObject	lole_pdf
OLEObject	lole_rootbookmark
OLEObject	lole_parentbookmark


lole_pdf = CREATE OLEObject

try
	li_ret = lole_pdf.ConnectToNewObject("PDFCreactiveX.PDFCreactiveX")
	
	if li_ret = 0 then

		lole_pdf.SetLicenseKey(is_LicenseCompany, is_LicenseKey)
		lole_pdf.Open(as_file, "")
		
		ll_PageCount = Long(lole_pdf.PageCount)
		ll_currentPage = Long(lole_pdf.Currentpage)
		ll_rootcount = lole_pdf.RootBookmark.count
		
		lole_rootbookmark = lole_pdf.RootBookmark
		lole_rootbookmark.InsertChild(0, as_bookmark , "", lole_parentbookmark)

		lole_pdf.save(as_output, 0)
		lole_pdf.DisconnectObject()
	end if
catch (RuntimeError ex1)
	li_ret = -1
end try

DESTROY lole_pdf

return li_ret

end function

public function integer of_get_bookmarks (string as_file, ref string ras_bookmarks[]);/*
* Objekt : uo_amyuni
* Methode: of_get_bookmarks (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.05.2017
*
* Argument(e):
* string as_file
*	 ref string ras_bookmarks
*
* Beschreibung:		Extrahiere Root Bookmarks aus File
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.05.2017		Erstellung
*
*
* Return: integer
*
*/

integer	li_ret = 0
long		ll_PageCount
Long		ll_CurrentPage
Long		ll_temp
String	ls_temp
Long		ll_rootcount, ll_Counter
//String	ls_BM
Long		ll_Result
OLEObject lole_pdf
OLEObject lole_pageBookmark


OLEObject	lole_rootbookmark
OLEObject	lole_parentbookmark


lole_pdf = CREATE OLEObject

try
	li_ret = lole_pdf.ConnectToNewObject("PDFCreactiveX.PDFCreactiveX")
	if li_ret = 0 then
		lole_pdf.SetLicenseKey(is_LicenseCompany, is_LicenseKey)
		lole_pdf.Open(as_file, "")
		ll_PageCount = Long(lole_pdf.PageCount)
		ll_currentPage = Long(lole_pdf.Currentpage)
		////		Crew News PDF FCL
		//		ls_BM = "Crew News PDF FCL"
		//		ls_BM = "LC-TS-Labels WS-1"
		//		lole_pdf.reachbookmark(ls_BM)
		//		ll_currentPage = Long(lole_pdf.Currentpage)

		ll_rootcount = lole_pdf.RootBookmark.count
		lole_rootbookmark = lole_pdf.RootBookmark
		lole_parentbookmark = lole_pdf.RootBookmark.Child(0)
		ls_temp = lole_parentbookmark.Title	

		for ll_Counter = 1 to ll_rootcount
			lole_parentbookmark = lole_pdf.RootBookmark.Child(ll_Counter - 1)
			ls_temp = lole_parentbookmark.Title	
			
			// DB 06.07.2017: BITTE KEINE EXTERNEN ABH$$HEX1$$c400$$ENDHEX$$NGIGKEITEN ZU DEN API OBJEKTEN HINZUF$$HEX1$$dc00$$ENDHEX$$GEN!!!
			//f_trace("Bookmark: " + ls_temp)
			ras_Bookmarks[upperbound(ras_Bookmarks) + 1] = ls_temp
			
		Next

		lole_pdf.DisconnectObject()
	end if
catch (RuntimeError ex1)
	li_ret = -1
end try

DESTROY lole_pdf

return li_ret

end function

public function integer of_get_bookmark_page (string as_file, string as_bookmark);/*
* Objekt : uo_amyuni
* Methode: of_get_bookmark_page (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.05.2017
*
* Argument(e):
* string as_file
*	  string as_bookmark
*
* Beschreibung:		Bookmark aus File
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.05.2017		Erstellung
*
*
* Return: integer
*
*/

integer	li_ret = 0
long		ll_PageCount
Long		ll_CurrentPage
Long		ll_temp
String	ls_temp
Long		ll_rootcount, ll_Counter
Long		ll_Result
OLEObject lole_pdf


lole_pdf = CREATE OLEObject

try
	li_ret = lole_pdf.ConnectToNewObject("PDFCreactiveX.PDFCreactiveX")
	if li_ret = 0 then
		lole_pdf.SetLicenseKey(is_LicenseCompany, is_LicenseKey)
		lole_pdf.Open(as_file, "")
		ll_PageCount = Long(lole_pdf.PageCount)
		ll_currentPage = Long(lole_pdf.Currentpage)
		
		lole_pdf.reachbookmark(as_bookmark)
		
		ll_currentPage = Long(lole_pdf.Currentpage)
		lole_pdf.DisconnectObject()
	end if
catch (RuntimeError ex1)
	li_ret = -1
end try

DESTROY lole_pdf

return ll_currentPage

end function

public function boolean get_scale_to_fit ();/*
* Objekt : uo_amyuni
* Methode: get_scale_to_fit (Getter Function)
* Autor  : Dirk Bunk
* Datum  : 11.07.2017
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt ein Flag zur$$HEX1$$fc00$$ENDHEX$$ck, das angibt, ob das PDF beim Drucken auf die Papiergr$$HEX2$$f600df00$$ENDHEX$$e des Druckers skaliert werden soll.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    11.07.2017    Erstellung
*
* Return: 
*   Das ScaleToFit Flag.
*/

return ib_ScaleToFit
end function

private subroutine set_scale_to_fit (boolean ab_value);/*
* Objekt : uo_amyuni
* Methode: set_printer_name (Setter Function)
* Autor  : Dirk Bunk
* Datum  : 11.07.2017
*
* Argument(e):
*   ab_value Das ScaleToFit Flag
*
* Beschreibung: Setzt ein Flag, das angibt, ob das PDF beim Drucken auf die Papiergr$$HEX2$$f600df00$$ENDHEX$$e des Druckers skaliert werden soll.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    11.07.2017    Erstellung
*
* Return: 
*   none
*/

ib_ScaleToFit = ab_value
end subroutine

on uo_amyuni.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_amyuni.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// Lizenz festlegen
is_LicenseCompany = "LSG Sky Chefs"
is_LicenseKey = "07EFCDAB0100010054F8D2FC113CB30685B5B09B4FD592F24D3E54C766270EB6AF17AACAC4C103F4AE292D1570A8E3D4C361653480E8"

// PDF Creator OLE festlegen
is_PDFCreatorOLE = "PDFCreactiveX.PDFCreactiveX.5.5"

// Amyuni Drucker festlegen
PrinterName = "CBASE PDF CONVERTER"
end event

event destructor;of_unlock()

try
	if il_PrinterHandle > 0 then DriverEnd(il_PrinterHandle)
catch (RuntimeError ex)
end try
end event

