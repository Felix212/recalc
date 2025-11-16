HA$PBExportHeader$uo_xml_file_handler.sru
forward
global type uo_xml_file_handler from nonvisualobject
end type
end forward

global type uo_xml_file_handler from nonvisualobject
end type
global uo_xml_file_handler uo_xml_file_handler

type variables
PUBLIC:
uo_xml_node RootNode

// Properties
indirect string XML {set_xml(*value), get_xml()}

PRIVATE:
OLEObject ole_XML

string is_LastError = ""

end variables

forward prototypes
public function integer of_load (string as_filename)
public function string of_get_last_error ()
public function integer of_load_xml (string as_xmlstring)
private subroutine set_xml (string as_xml)
private function string get_xml ()
public function integer of_create_new (string as_root)
public function integer of_save (string as_filename)
private function integer of_cleanup ()
private function integer of_init ()
end prototypes

public function integer of_load (string as_filename);/*
* Objekt : uo_xml_file_handler
* Methode: of_load (Function)
* Autor  : Dirk Bunk
* Datum  : 17.06.2011
*
* Argument(e):
*   as_filename Der Dateiname der XML-Datei, die geladen werden soll.
*
* Beschreibung: L$$HEX1$$e400$$ENDHEX$$dt eine XML-Datei.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    17.06.2011    Erstellung
*   1.1        Dirk Bunk    10.04.2012    OCX Objekte vor dem Laden neu erzeugen
*
* Return: 
*   0: OK
*  -1: Fehler
*/

// Objekte initialisieren
of_init()

if IsValid(ole_xml) then
	// XML Datei laden
	if ole_xml.load(as_filename) = false then
		// Wenn etwas nicht geklappt hat, Fehlermeldung zusammensetzen
		string sCRLF = char(13) + char(10)
		is_LastError = "Load of XML file failed." + sCRLF + & 
							"ErrorCode: " + string(ole_XML.parseError.ErrorCode) + sCRLF + &
							"FilePosition: " + string(ole_XML.parseError.Filepos) + sCRLF + &
							"Line: " + string(ole_XML.parseError.Line) + sCRLF + &
							"LinePosition: " + string(ole_XML.parseError.Linepos) + sCRLF + &
							"Reason: " + Left(string(ole_XML.parseError.Reason),Len(string(ole_xml.parseError.Reason))-2) + sCRLF + &
							"SourceText: " + string(ole_XML.parseError.SrcText)
		return -1
	end if
else
	return -1
end if

// Root Node setzen
rootNode.xmlDoc = ole_XML
rootNode.nodeObject = ole_XML.documentElement

return 0
end function

public function string of_get_last_error ();/*
* Objekt : uo_xml_file_handler
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

public function integer of_load_xml (string as_xmlstring);/*
* Objekt : uo_xml_file_handler
* Methode: of_load_xml (Function)
* Autor  : Dirk Bunk
* Datum  : 29.07.2011
*
* Argument(e):
*   as_xmlstring Der XML-String, der geladen werden soll.
*
* Beschreibung: L$$HEX1$$e400$$ENDHEX$$dt einen XML-String.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    29.07.2011    Erstellung
*   1.1        Dirk Bunk    10.04.2012    OCX Objekte vor dem Laden neu erzeugen
*
* Return: 
*   0: OK
*  -1: Fehler
*/

// Objekte initialisieren
of_init()

if IsValid(ole_XML) then
	// XML String laden
	if ole_xml.loadXml(as_xmlstring) = false then
		// Wenn etwas nicht geklappt hat, Fehlermeldung zusammensetzen
		string sCRLF = char(13) + char(10)
		is_LastError = "Load of XML string failed." + sCRLF + & 
							"ErrorCode: " + string(ole_XML.parseError.ErrorCode) + sCRLF + &
							"FilePosition: " + string(ole_XML.parseError.Filepos) + sCRLF + &
							"Line: " + string(ole_XML.parseError.Line) + sCRLF + &
							"LinePosition: " + string(ole_XML.parseError.Linepos) + sCRLF + &
							"Reason: " + Left(string(ole_XML.parseError.Reason),Len(string(ole_xml.parseError.Reason))-2) + sCRLF + &
							"SourceText: " + string(ole_XML.parseError.SrcText)
		return -1
	end if
else
	return -1
end if

// Root Node setzen
rootNode.xmlDoc = ole_XML
rootNode.nodeObject = ole_XML.documentElement

return 0
end function

private subroutine set_xml (string as_xml);//EMPTY SETTER FUNCTION
end subroutine

private function string get_xml ();/*
* Objekt : uo_xml_file_handler
* Methode: get_xml (Getter Function)
* Autor  : Dirk Bunk
* Datum  : 07.11.2011
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt den gesamten XML-Inhalt zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    07.11.2011    Erstellung
*
* Return: 
*   Den XML-Inhalt.
*/

if isValid(ole_XML) then 
	return ole_XML.xml
else 
	return ""
end if
end function

public function integer of_create_new (string as_root);/*
* Objekt : of_create_new
* Methode: of_load (Function)
* Autor  : Dirk Bunk
* Datum  : 07.11.2011
*
* Argument(e):
*   as_root Der Name der Rootnode der XML-Datei.
*
* Beschreibung: Erstellt eine neue XML-Datei.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    07.11.2011    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

string sXML = ""

// XML-Header und Root-Name in einen String packen
sXML += "<?xml version=~"1.0~" encoding=~"UTF-8~" standalone=~"yes~"?>"
sXML += "<" + as_root + " xmlns:dt=~"urn:schemas-microsoft-com:datatypes~">"
sXML += "</" + as_root + ">"

// Den neuen XML-String laden
if of_load_xml(sXML) = 0 then
	return 0
else
	return -1
end if
end function

public function integer of_save (string as_filename);/*
* Objekt : uo_xml_file_handler
* Methode: of_save (Function)
* Autor  : Dirk Bunk
* Datum  : 01.08.2011
*
* Argument(e):
*   as_filename Der Dateiname unter dem die XML-Datei gespeichert werden soll.
*
* Beschreibung: Speichert die XML-Datei wieder ab.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    01.08.2011    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

if IsValid(ole_xml) then 
	ole_XML.save(as_filename)
	return 0
else
	return -1	
end if
end function

private function integer of_cleanup ();/*
* Objekt : uo_xml_file_handler
* Methode: of_cleanup (Function)
* Autor  : Dirk Bunk
* Datum  : 10.04.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Zerst$$HEX1$$f600$$ENDHEX$$rt instanzierte Objekte des XML Handlers.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.04.2012    Erstellung
*   1.1        Dirk Bunk    13.04.2012    GarbageCollect eingebaut
*   1.2        Dirk Bunk    11.07.2012    Bug beim Speicher aufr$$HEX1$$e400$$ENDHEX$$umen repariert
*   1.3        Dirk Bunk    16.10.2013    GarbageCollect + Yield wieder ausgebaut, da es mehr Probleme macht als es l$$HEX1$$f600$$ENDHEX$$st :/
*   1.4        Dirk Bunk    04.12.2013    Try..Catch-Block und R$$HEX1$$fc00$$ENDHEX$$ckgabewert hinzugef$$HEX1$$fc00$$ENDHEX$$gt / Destroy Aufrufe getauscht
*
* Return: 
*   0: OK
*  -1: Fehler beim Zerst$$HEX1$$f600$$ENDHEX$$ren von RootNode
*  -2: Fehler beim Zerst$$HEX1$$f600$$ENDHEX$$ren von ole_XML
*/
integer li_Return

// Defaults setzen
li_Return = 0

try
	if IsValid(RootNode) then DESTROY RootNode
catch (RuntimeError ex1)
	li_Return = -1
end try

try
	if IsValid(ole_XML) then
		ole_XML.DisconnectObject()
		DESTROY ole_XML
	end if
catch (RuntimeError ex2)
	li_Return = -2
end try

return li_Return
end function

private function integer of_init ();/*
* Objekt : uo_xml_file_handler
* Methode: of_init (Function)
* Autor  : Dirk Bunk
* Datum  : 10.04.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Erstellt Objekte des XML Handlers neu.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.04.2012    Erstellung
*   1.1        Dirk Bunk    04.12.2013    Try..Catch-Block und R$$HEX1$$fc00$$ENDHEX$$ckgabewert hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return: 
*   0: OK
*  <0: Fehler ist aufgetreten
*/

integer li_Return

// Defaults setzen
li_Return = 0

try
	// Aufr$$HEX1$$e400$$ENDHEX$$umen
	li_Return = of_cleanup()
	
	if li_Return = 0 then
		// OCX Objekt erzeugen
		ole_XML = CREATE OLEObject
		
		// Zur neusten Version des Microsoft XML DOMDocuments verbinden
		li_Return = ole_XML.ConnectToNewObject("MSXML2.DOMDocument.6.0")
			
		// Fallback auf $$HEX1$$e400$$ENDHEX$$ltere Versionen, falls erforderlich
		if li_Return <> 0 then li_Return = ole_XML.ConnectToNewObject("MSXML2.DOMDocument.5.0")
		if li_Return <> 0 then li_Return = ole_XML.ConnectToNewObject("MSXML2.DOMDocument.4.0")
		if li_Return <> 0 then li_Return = ole_XML.ConnectToNewObject("MSXML2.DOMDocument.3.0")
		
		// Wenn keine Version vorhanden ist, Fehler protokolieren
		if li_Return <> 0 then is_LastError = "Couldn't connect to object MSXML2.DOMDocument. Error code " + String(li_Return)
		
		// Rootnode erzeugen
		RootNode = CREATE uo_xml_node
	end if
catch (RuntimeError ex)
	li_Return = -1
end try

return li_Return
end function

on uo_xml_file_handler.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_xml_file_handler.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// Objekte initialisieren
return of_init()
end event

event destructor;// Aufr$$HEX1$$e400$$ENDHEX$$umen
return of_cleanup()
end event

