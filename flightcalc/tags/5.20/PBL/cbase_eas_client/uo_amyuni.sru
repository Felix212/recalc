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

function boolean SetLicenseKey(string szCompany, string szLicKey) library "cdintf450.dll" alias for "SetLicenseKeyA;Ansi"
function integer Lock(long hPrinter, string szLockName) library "cdintf450.dll" alias for "Lock;Ansi"
function integer TestLock(long hPrinter, string szLockName) library "cdintf450.dll" alias for "TestLock;Ansi"
function integer Unlock(long hPrinter, string szLockName, long dwTimeout) library "cdintf450.dll" alias for "Unlock;Ansi"
function integer SetDocFileProps(long hPrinter, string szDocTitle, long lOptions, string szFileDir, string szFileName) library "cdintf450.dll" alias for "SetDocFileProps;Ansi"
function integer DocOpen(ref long pedhDocument, string szFileName, string szPassword) library "cdintf450.dll" alias for "DocOpenA;Ansi"
function integer DocSave(long edhDocument, string szFileName) library "cdintf450.dll" alias for "DocSaveA;Ansi"
function integer DocPrint(long edhDocument, string szPrinterName, long lStartPage, long lEndPage, long lCopies) library "cdintf450.dll" alias for "DocPrintA;Ansi"
function integer DocAppend(long edhDocument, long edhSource) library "cdintf450.dll"
function integer DocMerge(long edhDocument, long edhSource, boolean fRepeat, boolean fAbove) library "cdintf450.dll"
function integer DocClose(long edhDocument) library "cdintf450.dll"
//function integer DocOptimize(long edhDocument, integer iLevel) library "cdintf450.dll"
function long SetWatermark(long hPrinter, string szWatermark, string szFont, integer fontSize, integer Orientation, ulong color, long xPos, long yPos, boolean bForeground) library "cdintf450.dll" alias for "SetWatermark;Ansi"
function long EnablePrinter(long hPrinter, string szCompany, string szCode) library "cdintf450.dll" alias for "EnablePrinter;Ansi"
function long DriverInit(string szPrinter) library "cdintf450.dll" alias for "DriverInit;Ansi"
subroutine DriverEnd(long hPrinter) library "cdintf450.dll"
subroutine GetLastErrorMsg(ref string Msg, long MaxMsg) library "cdintf450.dll"

// HINWEIS:
// DocOptimize macht leider Probleme, wenn es mehrmals aufgerufen wird (komischerweise geht es in der $$HEX1$$fc00$$ENDHEX$$bersetzten Version).
// Es k$$HEX1$$f600$$ENDHEX$$nnte allerdings m$$HEX1$$f600$$ENDHEX$$gliche Probleme mit PDF Dokumenten beheben, die nicht mit Amyuni erstellt wurden.
// Da es aber zur Zeit noch keinen Bedarf gibt, es zu verwenden, ist es auskommentiert.
end prototypes

type variables
PUBLIC:
// Properties
indirect string LastError {set_last_error(*value), get_last_error()}
indirect string PrinterName {set_printer_name(*value), get_printer_name()}

PROTECTED:
string is_LicenseCompany
string is_LicenseKey

PRIVATE:
string is_LastError
string is_PrinterName
string is_LockName

long il_PrinterHandle

// Die h$$HEX1$$f600$$ENDHEX$$chstm$$HEX1$$f600$$ENDHEX$$gliche Seitenanzahl 
constant long MAX_PAGES = 2147483647

// Die wichtigsten Optionen f$$HEX1$$fc00$$ENDHEX$$r den PDF Drucker.
// Mehr unter: http://www.amyuni.com/WebHelp/Amyuni_Document_Converter/Printer_Configuration/Properties/FileNameOptions,_FileNameOptionsEx.htm
constant long OPTION_NO_PROMPT             = 1        // Prevents the display of the file name dialog box.
constant long OPTION_USE_FILE_NAME         = 2        // Use the file name set by SetDefaultFileName as the output file name.
constant long OPTION_CONCATENATE           = 4        // Concatenate with existing file instead of overwriting. This is useful only if the NoPrompt option is set.
constant long OPTION_EMBED_FONTS           = 16       // Enable embedding of fonts used in the source document.
constant long OPTION_PRINT_WATERMARK       = 64       // Watermarks are printed on all printed pages.
constant long OPTION_MULTILINGUAL_SUPPORT  = 128      // Add supports for international character sets.
constant long OPTION_ENCRYPT_DOCUMENT      = 256      // Encrypt resulting document.
constant long OPTION_FULL_EMBED            = 512      // Embed full fonts as opposed to embedding the fonts partially.
constant long OPTION_COLORS_2_GRAY_SCALE   = 524288   // Replaces all colors by an equivalent gray scale value.
constant long OPTION_EMBED_STANDARD_FONTS  = 2097152  // Embed standard fonts such as Arial, Times, etc.
constant long OPTION_EMBED_LICENSED_FONTS  = 4194304  // Embed fonts requiring a license.
constant long OPTION_EMBED_SIMULATED_FONTS = 16777216 // Embed Italic or Bold fonts that do not have an associated font file but are simulated by the system.
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
public function integer of_prepare_printer (string as_output, string as_doctitle, boolean ab_multilingual, boolean ab_grayscale, boolean ab_watermark, boolean ab_embedfonts, boolean ab_encrypted)
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
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_ret
long i, ll_DocHandle

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
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

return of_prepare_printer(as_Output, as_DocTitle, false, false, false, false, false)
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

public function integer of_prepare_printer (string as_output, string as_doctitle, boolean ab_multilingual, boolean ab_grayscale, boolean ab_watermark, boolean ab_embedfonts, boolean ab_encrypted);/*
* Objekt : uo_amyuni
* Methode: of_prepare_printer (Function)
* Autor  : Dirk Bunk
* Datum  : 10.12.2012
*
* Argument(e):
*   as_Output       Pfad+Dateiname des Ausgabedokuments, welches erstellt werden soll.
*   as_DocTitle     Titel des Ausgabedokuments, dieser wird beim Druck angezeigt, und dient au$$HEX1$$df00$$ENDHEX$$erdem zum Sperren.
*   ab_Multilingual Gibt an, ob der Export mit internationalen Schrifts$$HEX1$$e400$$ENDHEX$$tzen erfolgen soll.
*   ab_Grayscale    Gibt an, ob der Export in Graustufen erfolgen soll.
*   ab_Watermark    Gibt an, ob f$$HEX1$$fc00$$ENDHEX$$r den Export das aktuell gesetzte Wasserzeichen verwendet werden soll.
*   ab_Embedfonts   Gibt an, ob die verwendeten Schriftarten mit exportiert werden sollen.
*   ab_Encrypted    Gibt an, ob der Export verschl$$HEX1$$fc00$$ENDHEX$$sselt sein soll (schreibgesch$$HEX1$$fc00$$ENDHEX$$tzt).
*
* Beschreibung: Bereitet den aktuellen Amyuni Drucker f$$HEX1$$fc00$$ENDHEX$$r den Druck eines Dokuments vor.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.12.2012    Erstellung
*   1.1        Dirk Bunk    20.12.2012    Flags direkt mit in die Funktion aufgenommen
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
		ll_Options = OPTION_NO_PROMPT + OPTION_USE_FILE_NAME
		if ab_Watermark then ll_Options += OPTION_PRINT_WATERMARK
		if ab_GrayScale then ll_Options += OPTION_COLORS_2_GRAY_SCALE
		if ab_EmbedFonts then ll_Options += OPTION_EMBED_FONTS + OPTION_EMBED_STANDARD_FONTS
		if ab_Multilingual then ll_Options += OPTION_MULTILINGUAL_SUPPORT
		if ab_Encrypted then ll_Options += OPTION_ENCRYPT_DOCUMENT
		
		li_ret = SetDocFileProps(il_PrinterHandle, is_LockName, ll_Options, ls_Path, ls_Path + ls_File)
	end if

else
	li_ret = -1
end if

return li_ret
end function

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

// Amyuni Drucker festlegen
PrinterName = "CBASE PDF CONVERTER"
end event

event destructor;of_unlock()

try
	if il_PrinterHandle > 0 then DriverEnd(il_PrinterHandle)
catch (RuntimeError ex)
end try
end event

