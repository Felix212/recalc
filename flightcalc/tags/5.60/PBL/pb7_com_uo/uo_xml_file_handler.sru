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
uo_xml_node rootNode

//Properties
indirect string xml {set_xml(*value), get_xml()}

PRIVATE:
OLEObject ole_xml

DataStore idsEmptyDataStore

uo_xml_node iuoEmptyNode

string isLastError = ""
string isTagnames[]
end variables

forward prototypes
public function integer of_load (string as_filename)
public function string of_get_last_error ()
private function datastore of_create_datastore (string as_columns[])
private function integer of_get_tagnames (uo_xml_node auo_parentnode)
public function integer of_load_xml (string as_xmlstring)
private subroutine set_xml (string as_xml)
private function string get_xml ()
public function integer of_create_new (string as_root)
private subroutine of_cleanup ()
private subroutine of_init ()
public function integer of_save (string as_filename)
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

//Objekte initialisieren
of_init()

if isValid(ole_xml) then
	//XML Datei laden
	if ole_xml.load(as_filename) = false then
		//Wenn etwas nicht geklappt hat, Fehlermeldung zusammensetzen
		string sCRLF = char(13) + char(10)
		isLastError = "Load of XML file failed." + sCRLF + & 
							"ErrorCode: " + string(ole_xml.parseError.ErrorCode) + sCRLF + &
							"FilePosition: " + string(ole_xml.parseError.Filepos) + sCRLF + &
							"Line: " + string(ole_xml.parseError.Line) + sCRLF + &
							"LinePosition: " + string(ole_xml.parseError.Linepos) + sCRLF + &
							"Reason: " + Left(string(ole_xml.parseError.Reason),Len(string(ole_xml.parseError.Reason))-2) + sCRLF + &
							"SourceText: " + string(ole_xml.parseError.SrcText)
		return -1
	end if
else
	return -1
end if

//Root Node setzen
rootNode.xmlDoc = ole_xml
rootNode.nodeObject = ole_xml.documentElement

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

return isLastError
end function

private function datastore of_create_datastore (string as_columns[]);/*
* Objekt : uo_xml_file_handler
* Methode: of_create_datastore (Function)
* Autor  : Dirk Bunk
* Datum  : 22.06.2011
*
* Argument(e):
*   as_columns[] Stringarray mit Spaltennamen, die erzeugt werden sollen
*
* Beschreibung: Erzeugt dynamisch ein DataStore anhand einer Liste von Spaltennamen
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    22.06.2011    Erstellung
*
* Return: 
*   Das erzeugte DataStore
*/

DataStore ds
string syntax = ""
string columns = ""
integer i

//Columns zusammenbauen
for i=1 to UpperBound(as_columns)
	columns += "column=(type=char(32767) name=" + as_columns[i] + " dbname=~"" + as_columns[i] + "~")"
next

//Reduzierte Syntax zusammenbauen
syntax += "release 11.5;"
syntax += "table(" + columns + ")"

/*//Syntax zusammenbauen
syntax += "release 11.5;"
syntax += "datawindow ( units=0 timer_interval=0 processing=0 color=1073741824 brushmode=0 transparency=0 gradient.color=8421504 gradient.transparency=0 gradient.angle=0 gradient.repetition.mode=0 gradient.repetition.count=0 gradient.repetition.length=100 gradient.focus=0 gradient.scale=100 gradient.spread=100 picture.file=~"~"  picture.mode=0 picture.scale.x=100 picture.scale.y=100 picture.clip.left=0 picture.clip.right=0 picture.clip.top=0 picture.clip.bottom=0 picture.blur=0 picture.transparency=0 print.printername=~"~"  print.documentname=~"~"  print.orientation=0 print.margin.left=110 print.margin.right=110 print.margin.top=96 print.margin.bottom=96 print.paper.size=0 print.paper.source=0 print.canusedefaultprinter=yes selected.mouse=no hidegrayline=no showbackcoloronxp=no)"
syntax += "header(height=0 color=~"536870912~" transparency=~"0~" gradient.color=~"8421504~" gradient.transparency=~"0~" gradient.angle=~"0~" brushmode=~"0~" gradient.repetition.mode=~"0~" gradient.repetition.length=~"100~" gradient.repetition.count=~"0~" gradient.focus=~"0~" gradient.scale=~"100~" gradient.spread=~"100~" )"
syntax += "summary(height=0 color=~"536870912~" transparency=~"0~" gradient.color=~"8421504~" gradient.transparency=~"0~" gradient.angle=~"0~" brushmode=~"0~" gradient.repetition.mode=~"0~" gradient.repetition.length=~"100~" gradient.repetition.count=~"0~" gradient.focus=~"0~" gradient.scale=~"100~" gradient.spread=~"100~" )"
syntax += "footer(height=0 color=~"536870912~" transparency=~"0~" gradient.color=~"8421504~" gradient.transparency=~"0~" gradient.angle=~"0~" brushmode=~"0~" gradient.repetition.mode=~"0~" gradient.repetition.length=~"100~" gradient.repetition.count=~"0~" gradient.focus=~"0~" gradient.scale=~"100~" gradient.spread=~"100~" )"
syntax += "detail(height=0 color=~"536870912~" transparency=~"0~" gradient.color=~"8421504~" gradient.transparency=~"0~" gradient.angle=~"0~" brushmode=~"0~" gradient.repetition.mode=~"0~" gradient.repetition.length=~"100~" gradient.repetition.count=~"0~" gradient.focus=~"0~" gradient.scale=~"100~" gradient.spread=~"100~" )"
syntax += "table(" + columns + ")"
syntax += "htmltable(border=~"1~" )"
syntax += "htmlgen(clientComputedFields=~"1~" clientEvents=~"1~" clientFormatting=~"0~" clientScriptable=~"0~" clientValidation=~"1~" encodeSelfLinkArgs=~"1~" generateDDDWFrames=~"1~" generateJavaScript=~"1~" netscapeLayers=~"0~" pagingMethod=0 )"
syntax += "xhtmlgen() cssgen(sessionSpecific=~"0~" )"
syntax += "xmlgen(inline=~"0~" )"
syntax += "xsltgen()"
syntax += "jsgen()"
syntax += "export.xml(headGroups=~"1~" includewhitespace=~"0~" metadatatype=0 savemetadata=0 )"
syntax += "import.xml()"
syntax += "export.pdf(method=0 distill.customPostScript=~"0~" xslfop.print=~"0~" )"
syntax += "export.xhtml()"*/

//DataStore erzeugen
if not isValid(idsEmptyDataStore) then idsEmptyDataStore = CREATE DataStore
ds = idsEmptyDataStore
ds.Create(syntax)

//DataStore zur$$HEX1$$fc00$$ENDHEX$$ckgeben
return ds
end function

private function integer of_get_tagnames (uo_xml_node auo_parentnode);/*
* Objekt : uo_xml_file_handler
* Methode: of_get_tagnames (Function)
* Autor  : Dirk Bunk
* Datum  : 27.06.2011
*
* Argument(e):
*   auo_parentnode Die Eltern-Node (Beim ersten (nicht rekursiven) Aufruf sollte das die RootNode sein)
*
* Beschreibung: Liest alle Tagnamen aus der geladenen XML und schreibt sie in das Instanzarray isTagnames
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    27.06.2011    Erstellung
*
* Return: 
*  0: OK
* -1: Fehler
*/

long i
string sTagname
boolean bInList
uo_xml_node uoChildNode

sTagname = auo_parentnode.name
bInList = false

//Pr$$HEX1$$fc00$$ENDHEX$$fen, ob der Tagname bereits in der Liste ist
for i=1 to UpperBound(isTagnames)
	if isTagnames[i] = sTagname or sTagname = "" then 
		bInList = true
		exit
	end if
next

//Tagname zur Tagliste hinzuf$$HEX1$$fc00$$ENDHEX$$gen
if not bInList then isTagnames[UpperBound(isTagnames) + 1] = sTagname

//Childnodes durchgehen und dort auch den Tagnamen auslesen
for i=0 to auo_parentnode.nodeObject.childNodes.length - 1
	if not isValid(iuoEmptyNode) then iuoEmptyNode = CREATE uo_xml_node
	uoChildNode = iuoEmptyNode
	uoChildNode.nodeObject = auo_parentnode.nodeObject.childNodes.item(i)
	uoChildNode.xmlDoc = auo_parentnode.xmlDoc
	
	of_get_tagnames(uoChildNode)
next

return 0
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

//Objekte initialisieren
of_init()

if isValid(ole_xml) then
	//XML String laden
	if ole_xml.loadXml(as_xmlstring) = false then
		//Wenn etwas nicht geklappt hat, Fehlermeldung zusammensetzen
		string sCRLF = char(13) + char(10)
		isLastError = "Load of XML string failed." + sCRLF + & 
							"ErrorCode: " + string(ole_xml.parseError.ErrorCode) + sCRLF + &
							"FilePosition: " + string(ole_xml.parseError.Filepos) + sCRLF + &
							"Line: " + string(ole_xml.parseError.Line) + sCRLF + &
							"LinePosition: " + string(ole_xml.parseError.Linepos) + sCRLF + &
							"Reason: " + Left(string(ole_xml.parseError.Reason),Len(string(ole_xml.parseError.Reason))-2) + sCRLF + &
							"SourceText: " + string(ole_xml.parseError.SrcText)
		return -1
	end if
else
	return -1
end if

//Root Node setzen
rootNode.xmlDoc = ole_xml
rootNode.nodeObject = ole_xml.documentElement

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

if isValid(ole_xml) then 
	return ole_xml.xml
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

//XML-Header und Root-Name in einen String packen
sXML += "<?xml version=~"1.0~" encoding=~"UTF-8~" standalone=~"yes~"?>"
sXML += "<" + as_root + " xmlns:dt=~"urn:schemas-microsoft-com:datatypes~">"
sXML += "</" + as_root + ">"

//Den neuen XML-String laden
if of_load_xml(sXML) = 0 then
	return 0
else
	return -1
end if
end function

private subroutine of_cleanup ();/*
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
*
* Return: 
*   none
*/
uint i

if isValid(ole_xml) then
	ole_xml.DisconnectObject()
	DESTROY ole_xml
end if

if isValid(rootNode) then DESTROY rootNode
if isValid(idsEmptyDataStore) then DESTROY idsEmptyDataStore
if isValid(iuoEmptyNode) then DESTROY iuoEmptyNode

// Speicher aufr$$HEX1$$e400$$ENDHEX$$umen
//GarbageCollect()
for i = 0 to 999
	if not yield() then exit
next
end subroutine

private subroutine of_init ();/*
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
*
* Return: 
*   none
*/

integer iRet = 0

//Aufr$$HEX1$$e400$$ENDHEX$$umen
of_cleanup()

//OCX Objekt erzeugen
ole_xml = CREATE OLEObject

//Zur neusten Version des Microsoft XML DOMDocuments verbinden
iRet = ole_xml.ConnectToNewObject("MSXML2.DOMDocument.6.0")
	
//Fallback auf $$HEX1$$e400$$ENDHEX$$ltere Versionen, falls erforderlich
if iRet <> 0 then iRet = ole_xml.ConnectToNewObject("MSXML2.DOMDocument.5.0")
if iRet <> 0 then iRet = ole_xml.ConnectToNewObject("MSXML2.DOMDocument.4.0")
if iRet <> 0 then iRet = ole_xml.ConnectToNewObject("MSXML2.DOMDocument.3.0")

//Wenn keine Version vorhanden ist, Fehler protokolieren
if iRet <> 0 then isLastError = "Couldn't connect to object MSXML2.DOMDocument. Error code " + String(iRet)

//Rootnode erzeugen
rootNode = CREATE uo_xml_node 
end subroutine

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

if isValid(ole_xml) then 
	ole_xml.save(as_filename)
	return 0
else
	return -1	
end if
end function

on uo_xml_file_handler.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_xml_file_handler.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//Objekte initialisieren
of_init()
end event

event destructor;//Aufr$$HEX1$$e400$$ENDHEX$$umen
of_cleanup()
end event

