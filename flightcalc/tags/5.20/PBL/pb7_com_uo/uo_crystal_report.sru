HA$PBExportHeader$uo_crystal_report.sru
$PBExportComments$Crystal Reports Basisklasse zur Benutzung des Crystal Report OLEs
forward
global type uo_crystal_report from nonvisualobject
end type
end forward

global type uo_crystal_report from nonvisualobject
end type
global uo_crystal_report uo_crystal_report

type variables
/*******************************************PRIVATE VARIABLES******************************************/
PRIVATE:
OLEObject iole_CRApplication
OLEObject iole_CRConnectionInfo
OLEObject iole_CRReport

string is_ReportFile, &
       is_ReportTitle, &
       is_Error

boolean ib_ReportInProgress, &
        ib_OLEError
		  
// 27.01.2010 Ulrich Paudler [UP]
// Synchronisieren mit :uo_report_browser !!!
constant long TEXTPARAM             = 1
constant long LONGPARAM             = 2
constant long DATEPARAM             = 3
constant long DATETIMEPARAM         = 4
constant long WORKSTATIONLISTPARAM  = 10
constant long AIRLINEPARAM          = 11
constant long UNITPARAM             = 12
constant long RANGELISTPARAM        = 13
constant long AIRLINELISTPARAM      = 14
constant long UNITLISTPARAM         = 15
constant long ITEMLISTLEVELPARAM    = 16
constant long ITEMLISTTYPEPARAM     = 17
constant long FREETEXTLISTPARAM     = 18
constant long REPORTMASTERDATAPARAM = 19
constant long ITEMLISTPARAM	      = 20
constant long BREAKDOWNCODEPARAM    = 21
constant long ITEMLISTSINGLEPARAM   = 22
constant long SUPPLIERLISTPARAM     = 23
constant long TEXTOBJECT            = 31

// 14.08.2012, DB: CRExportFormat Types (Die Wichtigsten)
constant uint EXPORT_TYPE_COMMA_SEPARATED_VALUES = 5
constant uint EXPORT_TYPE_TEXT = 8
constant uint EXPORT_TYPE_WORD_FOR_WINDOWS = 14
constant uint EXPORT_TYPE_PORTABLE_DOC_FORMAT = 31
constant uint EXPORT_TYPE_EXCEL_97 = 36
constant uint EXPORT_TYPE_XML = 37

/*******************************************PUBLIC VARIABLES*******************************************/
PUBLIC:
// 30.11.2010, DB: Papier-Format und Ausrichtung
constant uint PAPER_SIZE_DEFAULT = 0
constant uint PAPER_SIZE_LETTER  = 1
constant uint PAPER_SIZE_DIN_A4  = 9

constant uint ORIENTATION_PORTRAIT  = 1
constant uint ORIENTATION_LANDSCAPE = 2

// 14.08.2012, DB: CRFieldValue Types (Die Wichtigsten)
constant uint FIELD_NUMBER   = 7
constant uint FIELD_BOOLEAN  = 9
constant uint FIELD_DATE     = 10
constant uint FIELD_TIME     = 11
constant uint FIELD_STRING   = 12
constant uint FIELD_DATETIME = 16
end variables

forward prototypes
public function long of_create_parameter_group (long al_parameters[])
public function string of_get_parameter_name (long al_index)
public function long of_get_parameter_count ()
public function boolean of_is_report_finished ()
public function integer of_load (string as_report)
public function string of_get_last_error ()
public subroutine of_retrieve ()
public function uint of_get_parameter_type (long al_index)
private function long of_string2array (string as_string, string as_separator, ref long al_outputarray[])
public function long of_create_parameter_group (string as_parameters[])
private function long of_string2array (string as_string, string as_separator, ref string as_outputarray[])
private function integer of_export (string as_filename, unsignedinteger ai_formattype)
public function integer of_export_pdf (string as_filename)
public function oleobject of_get_report_object ()
public function integer of_print (string as_printer)
public function integer of_load (string as_report, string as_title)
public subroutine of_set_report_title (string as_title)
public function string of_get_report_title ()
public function integer of_set_connection (string as_server, string as_database, string as_user, string as_pass)
private function integer of_get_printer_info (ref string as_printer, ref string as_driver, ref string as_port)
public function long of_set_parameter (string as_name, long al_type, string as_value)
public function long of_set_parameter (string as_name, date ad_value)
public function long of_set_parameter (string as_name, datetime adt_value)
public function long of_set_parameter (string as_name, long al_value)
public function long of_set_parameter (string as_name, long al_value[])
public function long of_set_parameter (string as_name, string as_value)
public function long of_set_parameter (string as_name, string as_value[])
public function integer of_set_paper_format (unsignedinteger ai_papersize)
public function unsignedinteger of_get_paper_format ()
public function integer of_export_csv (string as_filename)
public function integer of_export_xml (string as_filename)
public function integer of_export_xls (string as_filename)
public function integer of_export_doc (string as_filename)
public function integer of_export_txt (string as_filename)
end prototypes

public function long of_create_parameter_group (long al_parameters[]);/*
* Objekt : uo_crystal_report
* Methode: of_create_parameter_group
* Autor  : Dirk Bunk
* Datum  : 04.07.2012
*
* Argument(e):
*   al_parameters Array mit numerischen Parametern f$$HEX1$$fc00$$ENDHEX$$r einen Crystal Report
*
* Beschreibung: Speichert die Werte eines Arrays in die Tabelle cen_report_parameters.
*               Das hat den Vorteil, dass auch in Crystal Reports eine Gruppe von Parametern
*               benutzt werden kann, indem mit dem Gruppenschl$$HEX1$$fc00$$ENDHEX$$ssel in die Tabelle retrieved wird.
*
*               HINWEIS: Es gibt eine Kopie dieser Funktion mit einem String Array
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    04.07.2012    Erstellung
*
* Return: 
*   Der erzeugte Gruppenschl$$HEX1$$fc00$$ENDHEX$$ssel
*/

long i, ll_seq, ll_report_group_key, ll_ret

// Defaults setzen
ll_ret = 0
SetNull(ll_report_group_key)

// Alle Reportparameter l$$HEX1$$f600$$ENDHEX$$schen, die $$HEX1$$e400$$ENDHEX$$lter als 7 Tage sind
DELETE FROM cen_report_parameters WHERE dtimestamp < sysdate - 7;

// Alle Parameter aus dem Array lesen und in die Tabelle eintragen
for i = 1 to UpperBound(al_parameters)
	// Neue Sequence lesen
	SELECT seq_cen_report_parameters.nextval INTO :ll_seq FROM dual USING SQLCA;
	
	// Sequence $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen
	if ll_seq <= 0 then 
		ll_ret = -1
		exit
	end if
	
	// Falls noch kein Gruppenschl$$HEX1$$fc00$$ENDHEX$$ssel gesetzt wurde, tun wir das jetzt
	if IsNull(ll_report_group_key) then ll_report_group_key = ll_seq
	
	// Den Parameter in die Tabelle eintragen
	INSERT INTO cen_report_parameters (nparameter_id, nparameter_group, nvalue, dtimestamp)
	VALUES (:ll_seq, :ll_report_group_key, :al_parameters[i], sysdate) USING SQLCA;
next

// $$HEX1$$c400$$ENDHEX$$nderungen speichern, wenn alles geklappt hat
// oder verwerfen, falls ein Fehler aufgetreten ist
if ll_ret = 0 then
	COMMIT USING SQLCA;
else
	ROLLBACK USING SQLCA;
end if

// Den Gruppenschl$$HEX1$$fc00$$ENDHEX$$ssel der Parametergruppe zur$$HEX1$$fc00$$ENDHEX$$ckgeben
return ll_report_group_key
end function

public function string of_get_parameter_name (long al_index);/*
* Objekt : uo_crystal_report
* Methode: of_get_parameter_name
* Autor  : Ulrich Paudler
* Datum  : 25.11.2009
*
* Argument(e):
*   al_index Der Index des Parameters, dessen Name zur$$HEX1$$fc00$$ENDHEX$$ckgegeben werden soll.
*
* Beschreibung: Gibt den Namen eines Parameters zur$$HEX1$$fc00$$ENDHEX$$ck.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
* Version    Wer          Wann          Was und warum
* 1.0        U.Paudler    25.11.2009    Erstellung 
* 1.1        Dirk Bunk    07.11.2012    Zus$$HEX1$$e400$$ENDHEX$$tzliche Pr$$HEX1$$fc00$$ENDHEX$$fung
*
* Return: 
*   Der Name des Parameters
*/

string ls_Name 

try
	if al_Index < 1 then 
		ls_Name = ""
	else
		// Funktion liefert ${Name}
		ls_Name = Trim(iole_CRReport.ParameterFields.Item(al_Index).Name )
		
		if Len(ls_Name) > 0 then
			// ${ entfernen
			ls_Name = Right(ls_Name, Len(ls_Name) - 2)
		end if
		
		if Len(ls_Name) > 0 then
			// } entfernen
			ls_Name = Left(ls_Name, Len(ls_Name) - 1)
		end if
	end if
catch (RuntimeError ex)
	ls_Name = ""
end try

return ls_Name
end function

public function long of_get_parameter_count ();/*
* Objekt : uo_crystal_report
* Methode: of_get_parameter_count
* Autor  : Ulrich Paudler
* Datum  : 25.11.2009
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt die Anzahl der Parameter des Reports zur$$HEX1$$fc00$$ENDHEX$$ck.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
* Version    Wer          Wann          Was und warum
* 1.0        U.Paudler    25.11.2009    Erstellung 
* 1.1        Dirk Bunk    07.11.2012    Zus$$HEX1$$e400$$ENDHEX$$tzliche Pr$$HEX1$$fc00$$ENDHEX$$fung
*
* Return: 
*   Die Anzahl der Parameter oder -1 bei Fehler.
*/

long ll_Count

try
	ll_Count = iole_CRReport.ParameterFields.Count
catch (RuntimeError ex)
	ll_Count = -1
end try

return ll_Count
end function

public function boolean of_is_report_finished ();/*
* Objekt : uo_crystal_report
* Methode: of_is_report_finished
* Autor  : Ulrich Paudler
* Datum  : 04.01.2010
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt an, ob der Report vollst$$HEX1$$e400$$ENDHEX$$ndig geladen wurde.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        U.Paudler    04.01.2010    Erstellung
*
* Return: 
*   true: Alles ist fertig
*  false: Irgendwas l$$HEX1$$e400$$ENDHEX$$dt noch
*/

return not ib_ReportInProgress
end function

public function integer of_load (string as_report);// $$HEX1$$dc00$$ENDHEX$$berladene Funktion aufrufen
return of_load(as_report, "")
end function

public function string of_get_last_error ();/*
* Objekt : uo_crystal_report
* Methode: of_get_last_error
* Autor  : Dirk Bunk
* Datum  : 15.08.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt den zuletzt aufgetretenen Fehler zur$$HEX1$$fc00$$ENDHEX$$ck.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    15.08.2012    Erstellung
*
* Return: 
*   Der zuletzt aufgetretene Fehler.
*/

return is_Error
end function

public subroutine of_retrieve ();/*
* Objekt : uo_crystal_report
* Methode: of_retrieve
* Autor  : Dirk Bunk
* Datum  : 14.08.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Erzwingt das Retrieven des Reports.
*
* Hinweis: Normalerweise wird der Report retrieved, wenn gedruckt, exportiert oder 
*          der Report im Viewer angezeigt wird. Falls es doch mal n$$HEX1$$f600$$ENDHEX$$tig sein sollte,
*          den Report vorher zu retrieven, kann die Funktion benutzt werden.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    14.08.2012    Erstellung
*
* Return: 
*   nichts
*/

try
	if IsValid(iole_CRReport) then iole_CRReport.ReadRecords()
catch (RuntimeError ex)
end try
end subroutine

public function uint of_get_parameter_type (long al_index);/*
* Objekt : uo_crystal_report
* Methode: of_get_parameter_type
* Autor  : Dirk Bunk
* Datum  : 14.08.2012
*
* Argument(e):
*   al_index Der Index des Parameters, dessen Typ zur$$HEX1$$fc00$$ENDHEX$$ckgegeben werden soll.
*
* Beschreibung: Gibt den Typ eines Parameters zur$$HEX1$$fc00$$ENDHEX$$ck.
*               Siehe "CRFieldValue Types" in den Instanz-Variablen.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    07.11.2011    Erstellung
*
* Return: 
*   Der Typ des Parameters als "CRFieldValue Type" Konstante
*/

long ll_ValueType

try
	if al_index < 1 then 
		ll_ValueType = -1
	else
		ll_ValueType = iole_CRReport.ParameterFields.Item(al_index).ValueType
	end if
catch (RuntimeError ex)
	ll_ValueType = -1
end try

return ll_ValueType
end function

private function long of_string2array (string as_string, string as_separator, ref long al_outputarray[]);/*
* Objekt : uo_crystal_report
* Methode: of_string2array
* Autor  : Ulrich Paudler
* Datum  : 27.01.2010
*
* Argument(e):
*   as_string        Der String, der aufgeteilt werden soll
*   as_separator     Der Separator, anhand dessen der String aufgeteilt wird.
*   al_outputarray[] Das Array, in dem das Ergebnis landet.
*
* Beschreibung: Splittet einen String anhand eines $$HEX1$$fc00$$ENDHEX$$bergebenen Separators auf und
*               speichert das Ergebnis in einem Array.
*
* Hinweis: Diese Funktion geh$$HEX1$$f600$$ENDHEX$$rt eigentlich an eine allgemein verf$$HEX1$$fc00$$ENDHEX$$gbare Stelle
*          und sollte nicht nur an das Crystal Reports Objekt gebunden sein.
*          Wenn mal jemand nix zu tun hat...
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
* Version    Wer          Wann          Was und warum
* 1.0        U.Paudler    27.01.2010    Erstellung
* 1.1        Dirk Bunk    15.08.2012    Formatierung  
*
* Return: 
*   Die Anzahl der gesplitteten Eintr$$HEX1$$e400$$ENDHEX$$ge.
*/

long ll_PosEnd, ll_PosStart = 1, ll_SeparatorLen, ll_Counter = 1

if UpperBound(al_OutputArray) > 0 then al_OutputArray = {0}
ll_SeparatorLen = Len(as_Separator)

ll_PosEnd = Pos(as_String, as_Separator, 1)

do while ll_PosEnd > 0
     al_OutputArray[ll_Counter] = Long(Mid(as_String, ll_PosStart, ll_PosEnd - ll_PosStart))
     ll_PosStart = ll_PosEnd + ll_SeparatorLen
     ll_PosEnd = Pos(as_String, as_Separator, ll_PosStart)
     ll_Counter++
loop

al_OutputArray[ll_Counter] = Long(Right(as_String, Len(as_String) - ll_PosStart + 1))

return ll_Counter
end function

public function long of_create_parameter_group (string as_parameters[]);/*
* Objekt : uo_crystal_report
* Methode: of_create_parameter_group
* Autor  : Dirk Bunk
* Datum  : 04.07.2012
*
* Argument(e):
*   al_parameters Array mit numerischen Parametern f$$HEX1$$fc00$$ENDHEX$$r einen Crystal Report
*
* Beschreibung: Speichert die Werte eines Arrays in die Tabelle cen_report_parameters.
*               Das hat den Vorteil, dass auch in Crystal Reports eine Gruppe von Parametern
*               benutzt werden kann, indem mit dem Gruppenschl$$HEX1$$fc00$$ENDHEX$$ssel in die Tabelle retrieved wird.
*
*               HINWEIS: Es gibt eine Kopie dieser Funktion mit einem Long Array
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    04.07.2012    Erstellung
*
* Return: 
*   Der erzeugte Gruppenschl$$HEX1$$fc00$$ENDHEX$$ssel
*/

long i, ll_seq, ll_report_group_key, ll_ret

// Defaults setzen
ll_ret = 0
SetNull(ll_report_group_key)

// Alle Reportparameter l$$HEX1$$f600$$ENDHEX$$schen, die $$HEX1$$e400$$ENDHEX$$lter als 7 Tage sind
DELETE FROM cen_report_parameters WHERE dtimestamp < sysdate - 7;

// Alle Parameter aus dem Array lesen und in die Tabelle eintragen
for i = 1 to UpperBound(as_parameters)
	// Neue Sequence lesen
	SELECT seq_cen_report_parameters.nextval INTO :ll_seq FROM dual USING SQLCA;
	
	// Sequence $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen
	if ll_seq <= 0 then 
		ll_ret = -1
		exit
	end if
	
	// Falls noch kein Gruppenschl$$HEX1$$fc00$$ENDHEX$$ssel gesetzt wurde, tun wir das jetzt
	if IsNull(ll_report_group_key) then ll_report_group_key = ll_seq
	
	// Den Parameter in die Tabelle eintragen
	INSERT INTO cen_report_parameters (nparameter_id, nparameter_group, cvalue, dtimestamp)
	VALUES (:ll_seq, :ll_report_group_key, :as_parameters[i], sysdate) USING SQLCA;
next

// $$HEX1$$c400$$ENDHEX$$nderungen speichern, wenn alles geklappt hat
// oder verwerfen, falls ein Fehler aufgetreten ist
if ll_ret = 0 then
	COMMIT USING SQLCA;
else
	ROLLBACK USING SQLCA;
end if

// Den Gruppenschl$$HEX1$$fc00$$ENDHEX$$ssel der Parametergruppe zur$$HEX1$$fc00$$ENDHEX$$ckgeben
return ll_report_group_key
end function

private function long of_string2array (string as_string, string as_separator, ref string as_outputarray[]);/*
* Objekt : uo_crystal_report
* Methode: of_string2array
* Autor  : Ulrich Paudler
* Datum  : 27.01.2010
*
* Argument(e):
*   as_string        Der String, der aufgeteilt werden soll
*   as_separator     Der Separator, anhand dessen der String aufgeteilt wird.
*   as_outputarray[] Das Array, in dem das Ergebnis landet.
*
* Beschreibung: Splittet einen String anhand eines $$HEX1$$fc00$$ENDHEX$$bergebenen Separators auf und
*               speichert das Ergebnis in einem Array.
*
* Hinweis: Diese Funktion geh$$HEX1$$f600$$ENDHEX$$rt eigentlich an eine allgemein verf$$HEX1$$fc00$$ENDHEX$$gbare Stelle
*          und sollte nicht nur an das Crystal Reports Objekt gebunden sein.
*          Wenn mal jemand nix zu tun hat...
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
* Version    Wer          Wann          Was und warum
* 1.0        U.Paudler    27.01.2010    Erstellung
* 1.1        Dirk Bunk    15.08.2012    Formatierung  
*
* Return: 
*   Die Anzahl der gesplitteten Eintr$$HEX1$$e400$$ENDHEX$$ge.
*/

long ll_PosEnd, ll_PosStart = 1, ll_SeparatorLen, ll_Counter = 1

if UpperBound(as_OutputArray) > 0 then as_OutputArray = {""}
ll_SeparatorLen = Len(as_Separator)

ll_PosEnd = Pos(as_String, as_Separator, 1)

do while ll_PosEnd > 0
     as_OutputArray[ll_Counter] = Mid(as_String, ll_PosStart, ll_PosEnd - ll_PosStart)
     ll_PosStart = ll_PosEnd + ll_SeparatorLen
     ll_PosEnd = Pos(as_String, as_Separator, ll_PosStart)
     ll_Counter++
loop

as_OutputArray[ll_Counter] = Right(as_String, Len(as_String) - ll_PosStart + 1)

return ll_Counter
end function

private function integer of_export (string as_filename, unsignedinteger ai_formattype);/*
* Objekt : uo_crystal_report
* Methode: of_export
* Autor  : Dirk Bunk
* Datum  : 15.08.2012
*
* Argument(e):
*   as_filename   Zieldateiname
*   ai_formattype Numerischer Wert des Exportformats (Siehe CRExportFormat Types)
*
* Beschreibung: Exportiert den Report im angegebenen Format.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    15.08.2012    Erstellung
*
* Return: 
*   0: OK
*  <0: Fehler
*/

integer li_Ret = 0

try
	if IsValid(iole_CRReport) then
		iole_CRReport.ExportOptions.FormatType      = ai_FormatType
		iole_CRReport.ExportOptions.DiskFileName    = as_FileName
		iole_CRReport.ExportOptions.DestinationType = 1
		
		choose case ai_FormatType
			case EXPORT_TYPE_PORTABLE_DOC_FORMAT
				iole_CRReport.ExportOptions.PDFExportAllPages = true
		end choose
		
		iole_CRReport.Export(false)
	else
		is_Error = "Invalid report object. Load a report first."
		li_Ret = -1
	end if
catch (RuntimeError ex)
	is_Error = "Failed to export report."
	li_Ret = -2
end try

return li_Ret
end function

public function integer of_export_pdf (string as_filename);return of_export(as_FileName, EXPORT_TYPE_PORTABLE_DOC_FORMAT)
end function

public function oleobject of_get_report_object ();/*
* Objekt : uo_crystal_report
* Methode: of_get_report_object
* Autor  : Dirk Bunk
* Datum  : 15.08.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt das aktuelle Crystal Reports - Report OLE Objekt zur$$HEX1$$fc00$$ENDHEX$$ck.
*
* Hineweis: Diese Funktion wird nur von uo_display_crystal_report verwendet.
*           Im Normalfall hei$$HEX1$$df00$$ENDHEX$$t es hier: FINGER WEG VOM OLE OBJEKT!
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    15.08.2012    Erstellung
*
* Return: 
*   Den Crystal Report als Report OLE Objekt.
*/

return iole_CRReport
end function

public function integer of_print (string as_printer);/*
* Objekt : uo_crystal_report
* Methode: of_print
* Autor  : Dirk Bunk
* Datum  : 14.08.2012
*
* Argument(e):
*   as_printer Der Drucker, auf den gedruckt werden soll.
*
* Beschreibung: Druckt den geladenen Report auf den $$HEX1$$fc00$$ENDHEX$$bergebenen Drucker.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    14.08.2012    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

long ll_Orientation, ll_PaperSize
string ls_Printer, ls_Driver, ls_Port

try
	// Druckerinformationen auslesen
	ls_Printer = as_printer
	of_get_printer_info(ls_Printer, ls_Driver, ls_Port)
	
	// Druckparameter merken
	ll_Orientation = iole_CRReport.PaperOrientation
	ll_PaperSize = iole_CRReport.PaperSize
	
	// Versuch: direkt aus Crystal drucken, nicht aus pdf
	iole_CRReport.SelectPrinter(ls_Printer, ls_Printer, ls_Port) 
	
	// Nochmal Paramter setzen, sonst gehts nicht unter Citrix
	iole_CRReport.PaperOrientation = ll_Orientation 
	iole_CRReport.PaperSize = ll_PaperSize 
	iole_CRReport.PrinterDuplex = 0 
	iole_CRReport.PaperSource = 7

	// Hinweis: Im Debug Modus st$$HEX1$$fc00$$ENDHEX$$rzt dieser Aufruf st$$HEX1$$e400$$ENDHEX$$ndig ab o_0
	iole_CRReport.PrintOut(false, 1, false, 1, 9999)
catch (RuntimeError ex)
	return -1
end try
		
return 0
end function

public function integer of_load (string as_report, string as_title);/*
* Objekt : uo_crystal_report
* Methode: of_load
* Autor  : Ulrich Paudler
* Datum  : 26.11.2009
*
* Argument(e):
*   keine
*
* Beschreibung: L$$HEX1$$e400$$ENDHEX$$dt den Crystal Report, der vorher in sReportFile definiert wurde.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        U.Paudler    26.11.2009    Erstellung
*   1.1        U.Paudler    09.12.2009    Erweiterung
*   1.2        U.Paudler    05.01.2010    Pr$$HEX1$$fc00$$ENDHEX$$fung ob ein Report geladen wird
*   1.3        D.Bunk       30.11.2010    Papierformat des Reports setzen. Unabh$$HEX1$$e400$$ENDHEX$$ngig vom urspr$$HEX1$$fc00$$ENDHEX$$nglichen Format des Reports.
*   1.4        D.Bunk       14.08.2012    Formatierung/Vereinfachung
*   1.5        D.Bunk       31.01.2013    Auf versionsunabh$$HEX1$$e400$$ENDHEX$$ngigen Schl$$HEX1$$fc00$$ENDHEX$$ssel zur OLE Erstellung zugreifen
*
* Return: 
*   0: OK
*  -1: Fehler
*/

integer li_Return

is_ReportFile = as_Report
of_set_report_title(as_Title)

if is_ReportFile = "" then
	is_Error = "Report File not set!"
	return -1
end if 

if not FileExists(is_ReportFile) then
	is_Error = "Report File not found!"
	return - 1
end if

// Application OLE Objekt erstellen
iole_CRApplication = CREATE OLEObject

// 05.01.2010 Ulrich Paudler [UP] Report in Bearbeitung
if ib_ReportInProgress then return -1

ib_ReportInProgress = true

li_return = iole_CRApplication.ConnectToNewObject("CrystalRuntime.Application")

if li_return < 0 then
	is_Error = "Did NOT connect to Crystal Application Object"
	ib_ReportInProgress = false
	return -1
end if

// 26.11.2009 Ulrich Paudler [UP] Erst Pr$$HEX1$$fc00$$ENDHEX$$fen ob report ok ist
ib_OLEError = false
try
	iole_CRReport = iole_CRApplication.OpenReport(is_ReportFile, 1)
catch (RuntimeError ex)
	ib_OLEError = true
end try

if ib_OLEError then
	ib_ReportInProgress = false
	return -1
end if
	
// 25.05.2009 G. Brosch: Damit kein Popup zur Eingabe von database-Parametern hochpoppt!!!
iole_CRReport.EnableParameterPrompting = false

// TODO: Die Datenbankparameter m$$HEX1$$fc00$$ENDHEX$$sste man evtl. besser von au$$HEX1$$df00$$ENDHEX$$en setzen
of_set_connection(SQLCA.ServerName, SQLCA.DBMS, "SYS_PWD_CHANGE", "test")

// 05.01.2010 Ulrich Paudler [UP] Report in Bearbeitung
ib_ReportInProgress = false

return 0
end function

public subroutine of_set_report_title (string as_title);/*
* Objekt : uo_crystal_report
* Methode: of_set_report_title
* Autor  : Dirk Bunk
* Datum  : 14.08.2012
*
* Argument(e):
*   as_title Der Titel des Reports, der gesetzt werden soll.
*
* Beschreibung: Setzt einen Titel f$$HEX1$$fc00$$ENDHEX$$r den Report.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    14.08.2012    Erstellung
*
* Return: 
*   nichts
*/

is_ReportTitle = as_Title
end subroutine

public function string of_get_report_title ();/*
* Objekt : uo_crystal_report
* Methode: of_get_report_title
* Autor  : Dirk Bunk
* Datum  : 15.08.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt den aktuellen Titel des Reports zur$$HEX1$$fc00$$ENDHEX$$ck.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    15.08.2012    Erstellung
*
* Return: 
*   Der Titel des Reports.
*/

return is_ReportTitle
end function

public function integer of_set_connection (string as_server, string as_database, string as_user, string as_pass);/*
* Objekt:  uo_crystal_report
* Methode: of_set_connection (Function)
* Autor:   Dirk Bunk
* Datum:   30.08.2010
*
* Argument(e):
*  as_server   Datenbank-Servername
*  as_database Datenbankname
*  as_user     Benutzer
*  as_pass     Passwort
*
* Beschreibung: 
*  Verbindet den geladenen Report mit der Datenbank
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    30.08.2010    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

long i
integer li_Ret = 0

try
	if IsValid(iole_CRReport) then
		// 09.12.2009 Ulrich Paudler [UP] Connection f$$HEX1$$fc00$$ENDHEX$$r jeden Table gesondert setzen (strange!)
		for i = 1 to iole_CRReport.Database.Tables.Count
			iole_CRConnectionInfo = iole_CRReport.Database.Tables[i].ConnectionProperties
			iole_CRConnectionInfo.DeleteAll()
			iole_CRConnectionInfo.Add("Server", as_Server)
			iole_CRConnectionInfo.Add("Database", as_Database)
			iole_CRConnectionInfo.Add("User ID", as_User)
			iole_CRConnectionInfo.Add("Password", as_Pass)
		next
	else
		is_Error = "Invalid report object. Load a report first."
		li_Ret = -1
	end if
catch (RuntimeError ex)
	is_Error = "Failed to set connection!"
	li_Ret = -2
end try

return li_Ret
end function

private function integer of_get_printer_info (ref string as_printer, ref string as_driver, ref string as_port);/*
* Objekt : uo_crystal_report
* Methode: of_get_printer_info
* Autor  : Dirk Bunk
* Datum  : 17.02.2010
*
* Argument(e):
*   as_Printer Der Name des Druckers, dessen Informationen gelesen werden sollen.
*   as_Driver  Leerer String, in der Treibername des Druckers geschrieben wird.
*   as_Port    Leerer String, in der Port des Druckers geschrieben wird.
*
* Beschreibung: Liest Informationen wie Treiber und Port zu einem bestimmten Drucker aus.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
* Version    Wer          Wann          Was und warum
* 1.0        D.Bunk       14.08.2012    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

string ls_PrinterOld, ls_PrinterInfo

// Den zuletzt eingestellten Drucker merken
ls_PrinterOld = f_get_printer()

// Druckerinformationen des $$HEX1$$fc00$$ENDHEX$$bergebenen Druckers auslesen
f_set_printer(as_Printer)
ls_PrinterInfo = PrintGetPrinter()

// Druckername aus den Druckerinformationen lesen
as_Printer = Left(ls_PrinterInfo, Pos(ls_PrinterInfo, "~t") - 1)
ls_PrinterInfo = Mid(ls_PrinterInfo, Pos(ls_PrinterInfo, "~t") + 1)

// Treiber aus den Druckerinformationen lesen
as_Driver = Left(ls_PrinterInfo, Pos(ls_PrinterInfo, "~t") - 1)
ls_PrinterInfo = Mid(ls_PrinterInfo, Pos(ls_PrinterInfo, "~t") + 1)

// Port aus den Druckerinformationen lesen
as_Port = ls_PrinterInfo

// Den zuletzt eingestellten Drucker wieder setzen
f_set_printer(ls_PrinterOld)

return 0
end function

public function long of_set_parameter (string as_name, long al_type, string as_value);/*
* Objekt : uo_crystal_report
* Methode: of_set_parameter
* Autor  : Ulrich Paudler
* Datum  : 26.11.2009
*
* Argument(e):
*   as_name
*   al_type
*   as_value
*
* Beschreibung: Setzt Report Parameter.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer                 Wann          Was und warum
*   1.0        Ulrich Paudler      26.11.2009    Erstellung
*   1.1        Ulrich Paudler      27.01.2010    Neue Objekte verwalten
*   1.2        Oliver H$$HEX1$$f600$$ENDHEX$$fer        08.09.2010    Neue Typen ITEMLISTPARAM / FREETEXTLISTPARAM
*   1.3        Thomas Brackmann    28.03.2012    Supplierliste hinzu
*   1.4        Dirk Bunk           27.07.2012    Workstationliste hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return: 
*   0: Ok
*  <0: Fehler
*/

long ll_RetVal 
long	ll_Array[]
string ls_Array[]

// Wenn kein Reportparametername $$HEX1$$fc00$$ENDHEX$$bergeben wurde, raus
if trim(as_name) = "" then return -1

// 04.01.2010 Ulrich Paudler [UP] Report in Bearbeitung
if ib_ReportInProgress then return -1

choose case al_type
	case LONGPARAM, AIRLINEPARAM, REPORTMASTERDATAPARAM
		ll_RetVal = of_set_parameter(as_name, long(as_value))
	case DATEPARAM
		ll_RetVal = of_set_parameter(as_name, Date(as_value))
	case DATETIMEPARAM
		ll_RetVal = of_set_parameter(as_name, Datetime(as_value))
	// 27.01.2010 Ulrich Paudler [UP]
	case AIRLINELISTPARAM, ITEMLISTLEVELPARAM, ITEMLISTTYPEPARAM
		ll_RetVal = of_string2array(as_value,",",ll_Array)
		ll_RetVal = of_set_parameter(as_name, ll_Array)
	// 27.01.2010 Ulrich Paudler [UP]
	case RANGELISTPARAM,UNITLISTPARAM, REPORTMASTERDATAPARAM
		ll_RetVal = of_string2array(as_value,",",ls_Array)
		ll_RetVal = of_set_parameter(as_name, ls_Array)

	case ITEMLISTPARAM
		ll_RetVal = of_string2array(as_value,",",ls_Array)
		ll_RetVal = of_set_parameter(as_name, ls_Array)

	CASE FREETEXTLISTPARAM
		ll_RetVal = of_string2array(as_value,",",ls_Array)
		ll_RetVal = of_set_parameter(as_name, ls_Array)
		
	case BREAKDOWNCODEPARAM
		ll_RetVal = of_string2array(as_value,",",ls_Array)
		ll_RetVal = of_set_parameter(as_name, ls_Array)
		
	case ITEMLISTSINGLEPARAM
		ll_RetVal = of_set_parameter(as_name, long(as_value))
		
	case SUPPLIERLISTPARAM
		ll_RetVal = of_string2array(as_value,",",ll_Array)
		ll_RetVal = of_set_parameter(as_name, ll_Array)

	case WORKSTATIONLISTPARAM
		ll_RetVal = of_string2array(as_value,",",ll_Array)
		ll_RetVal = of_create_parameter_group(ll_Array)
		ll_RetVal = of_set_parameter(as_name, ll_RetVal)
	case else
		ll_RetVal = of_set_parameter(as_name, as_value)
end choose

return ll_RetVal
end function

public function long of_set_parameter (string as_name, date ad_value);/*
* Objekt : uo_crystal_report
* Methode: of_set_parameter
* Autor  : Ulrich Paudler
* Datum  : 26.11.2009
*
* Argument(e):
*   as_name
*   ad_value
*
* Beschreibung: Setzt Report Parameter.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer               Wann          Was und warum
*   1.0        Ulrich Paudler    26.11.2009    Erstellung
*   1.1        Dirk Bunk         16.08.2012    Zus$$HEX1$$e400$$ENDHEX$$tzliche Abfrage
*
* Return: 
*   0: Ok
*  <0: Fehler
*/

// Wenn kein Reportparametername $$HEX1$$fc00$$ENDHEX$$bergeben wurde, raus
if trim(as_name) = "" then return -1

// Wenn der Report ung$$HEX1$$fc00$$ENDHEX$$ltig ist, raus
if not IsValid(iole_CRReport) then return -1

// 04.01.2010 Ulrich Paudler [UP] Report in Bearbeitung
if ib_ReportInProgress then return -1

try
	iole_CRReport.ParameterFields.GetItemByName(as_name).ClearCurrentValueAndRange()
	iole_CRReport.ParameterFields.GetItemByName(as_name).AddCurrentValue(ad_value)
catch (RuntimeError ex)
	return -1
end try

return 0
end function

public function long of_set_parameter (string as_name, datetime adt_value);/*
* Objekt : uo_crystal_report
* Methode: of_set_parameter
* Autor  : Ulrich Paudler
* Datum  : 26.11.2009
*
* Argument(e):
*   as_name
*   adt_value
*
* Beschreibung: Setzt Report Parameter.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer               Wann          Was und warum
*   1.0        Ulrich Paudler    26.11.2009    Erstellung
*   1.1        Dirk Bunk         16.08.2012    Zus$$HEX1$$e400$$ENDHEX$$tzliche Abfrage
*
* Return: 
*   0: Ok
*  <0: Fehler
*/

// Wenn kein Reportparametername $$HEX1$$fc00$$ENDHEX$$bergeben wurde, raus
if trim(as_name) = "" then return -1

// Wenn der Report ung$$HEX1$$fc00$$ENDHEX$$ltig ist, raus
if not IsValid(iole_CRReport) then return -1

// 04.01.2010 Ulrich Paudler [UP] Report in Bearbeitung
if ib_ReportInProgress then return -1

try
	iole_CRReport.ParameterFields.GetItemByName(as_name).ClearCurrentValueAndRange()
	iole_CRReport.ParameterFields.GetItemByName(as_name).AddCurrentValue(adt_value)
catch (RuntimeError ex)
	return -1
end try

return 0
end function

public function long of_set_parameter (string as_name, long al_value);/*
* Objekt : uo_crystal_report
* Methode: of_set_parameter
* Autor  : Ulrich Paudler
* Datum  : 26.11.2009
*
* Argument(e):
*   as_name
*   al_value
*
* Beschreibung: Setzt Report Parameter.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer               Wann          Was und warum
*   1.0        Ulrich Paudler    26.11.2009    Erstellung
*   1.1        Dirk Bunk         16.08.2012    Zus$$HEX1$$e400$$ENDHEX$$tzliche Abfrage
*
* Return: 
*   0: Ok
*  <0: Fehler
*/

// Wenn kein Reportparametername $$HEX1$$fc00$$ENDHEX$$bergeben wurde, raus
if trim(as_name) = "" then return -1

// Wenn der Report ung$$HEX1$$fc00$$ENDHEX$$ltig ist, raus
if not IsValid(iole_CRReport) then return -1

// 04.01.2010 Ulrich Paudler [UP] Report in Bearbeitung
if ib_ReportInProgress then return -1

try
	iole_CRReport.ParameterFields.GetItemByName(as_name).ClearCurrentValueAndRange()
	iole_CRReport.ParameterFields.GetItemByName(as_name).AddCurrentValue(al_value)
catch (RuntimeError ex)
	return -1
end try

return 0
end function

public function long of_set_parameter (string as_name, long al_value[]);/*
* Objekt : uo_crystal_report
* Methode: of_set_parameter
* Autor  : Ulrich Paudler
* Datum  : 26.11.2009
*
* Argument(e):
*   as_name
*   al_value[]
*
* Beschreibung: Setzt Report Parameter.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer               Wann          Was und warum
*   1.0        Ulrich Paudler    26.11.2009    Erstellung
*   1.1        Dirk Bunk         16.08.2012    Zus$$HEX1$$e400$$ENDHEX$$tzliche Abfrage
*
* Return: 
*   0: Ok
*  <0: Fehler
*/

long i

// Wenn kein Reportparametername $$HEX1$$fc00$$ENDHEX$$bergeben wurde, raus
if trim(as_name) = "" then return -1

// Wenn der Report ung$$HEX1$$fc00$$ENDHEX$$ltig ist, raus
if not IsValid(iole_CRReport) then return -1

// 04.01.2010 Ulrich Paudler [UP] Report in Bearbeitung
if ib_ReportInProgress then return -1

try
	iole_CRReport.ParameterFields.GetItemByName(as_name).ClearCurrentValueAndRange()
	for i = 1 to UpperBound(al_value)
		iole_CRReport.ParameterFields.GetItemByName(as_name).AddCurrentValue(al_value[i])
	next
catch (RuntimeError ex)
	return -1
end try

return 0
end function

public function long of_set_parameter (string as_name, string as_value);/*
* Objekt : uo_crystal_report
* Methode: of_set_parameter
* Autor  : Ulrich Paudler
* Datum  : 26.11.2009
*
* Argument(e):
*   as_name
*   as_value
*
* Beschreibung: Setzt Report Parameter.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer               Wann          Was und warum
*   1.0        Ulrich Paudler    26.11.2009    Erstellung
*   1.1        Dirk Bunk         16.08.2012    Zus$$HEX1$$e400$$ENDHEX$$tzliche Abfrage
*
* Return: 
*   0: Ok
*  <0: Fehler
*/

// Wenn kein Reportparametername $$HEX1$$fc00$$ENDHEX$$bergeben wurde, raus
if trim(as_name) = "" then return -1

// Wenn der Report ung$$HEX1$$fc00$$ENDHEX$$ltig ist, raus
if not IsValid(iole_CRReport) then return -1

// 04.01.2010 Ulrich Paudler [UP] Report in Bearbeitung
if ib_ReportInProgress then return -1

try
	iole_CRReport.ParameterFields.GetItemByName(as_name).ClearCurrentValueAndRange()
	iole_CRReport.ParameterFields.GetItemByName(as_name).AddCurrentValue(as_value)
catch (RuntimeError ex)
	return -1
end try

return 0
end function

public function long of_set_parameter (string as_name, string as_value[]);/*
* Objekt : uo_crystal_report
* Methode: of_set_parameter
* Autor  : Ulrich Paudler
* Datum  : 26.11.2009
*
* Argument(e):
*   as_name
*   as_value[]
*
* Beschreibung: Setzt Report Parameter.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer               Wann          Was und warum
*   1.0        Ulrich Paudler    26.11.2009    Erstellung
*   1.1        Dirk Bunk         16.08.2012    Zus$$HEX1$$e400$$ENDHEX$$tzliche Abfrage
*
* Return: 
*   0: Ok
*  <0: Fehler
*/

long i

// Wenn kein Reportparametername $$HEX1$$fc00$$ENDHEX$$bergeben wurde, raus
if trim(as_name) = "" then return -1

// Wenn der Report ung$$HEX1$$fc00$$ENDHEX$$ltig ist, raus
if not IsValid(iole_CRReport) then return -1

// 04.01.2010 Ulrich Paudler [UP] Report in Bearbeitung
if ib_ReportInProgress then return -1

try
	iole_CRReport.ParameterFields.GetItemByName(as_name).ClearCurrentValueAndRange()
	for i = 1 to upperbound(as_value)
		iole_CRReport.ParameterFields.GetItemByName(as_name).AddCurrentValue(as_value[i])
	next
catch (RuntimeError ex)
	return -1
end try

return 0
end function

public function integer of_set_paper_format (unsignedinteger ai_papersize);integer li_Ret = 0

try
	if IsValid(iole_CRReport) then
		iole_CRReport.PaperSize = ai_PaperSize
	else
		is_Error = "Invalid report object. Load a report first."
		li_Ret = -1
	end if
catch (RuntimeError ex)
	is_Error = "Failed to set paper format!"
	li_Ret = -2
end try

return li_Ret
end function

public function unsignedinteger of_get_paper_format ();try
	if IsValid(iole_CRReport) then
		return iole_CRReport.PaperSize
	else
		is_Error = "Invalid report object. Load a report first."
		return 0
	end if
catch (RuntimeError ex)
	is_Error = "Failed to get paper format!"
	return 0
end try
end function

public function integer of_export_csv (string as_filename);return of_export(as_FileName, EXPORT_TYPE_COMMA_SEPARATED_VALUES)
end function

public function integer of_export_xml (string as_filename);return of_export(as_FileName, EXPORT_TYPE_XML)
end function

public function integer of_export_xls (string as_filename);return of_export(as_FileName, EXPORT_TYPE_EXCEL_97)
end function

public function integer of_export_doc (string as_filename);return of_export(as_FileName, EXPORT_TYPE_WORD_FOR_WINDOWS)
end function

public function integer of_export_txt (string as_filename);return of_export(as_FileName, EXPORT_TYPE_TEXT)
end function

on uo_crystal_report.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_crystal_report.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;/*************************************************************
* Objekt : uo_display_crystal_report
* Methode: destructor (Event)
* Autor  : Ulrich Paudler [UP]
* Datum  : 25.11.2009
* Argument(e):
* none
*
* Return: long
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  25.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

// ---------------------------------------------
// Crystal Reports Application object
// ---------------------------------------------
if IsValid (iole_CRApplication) then destroy iole_CRApplication  

// ---------------------------------------------
// Crystal Reports Report object
// ---------------------------------------------
if IsValid (iole_CRReport) then destroy iole_CRReport

// ---------------------------------------------
// Crystal Reports Connection properties
// ---------------------------------------------
if IsValid (iole_CRConnectionInfo) then destroy iole_CRConnectionInfo
end event

