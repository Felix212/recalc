HA$PBExportHeader$uo_xml_node.sru
forward
global type uo_xml_node from nonvisualobject
end type
end forward

global type uo_xml_node from nonvisualobject
end type
global uo_xml_node uo_xml_node

type variables
PUBLIC:
OLEObject nodeObject
OLEObject xmlDoc

//Properties
indirect string datatype {set_datatype(*value), get_datatype()}
indirect string name {set_name(*value), get_name()}
indirect string xml {set_xml(*value), get_xml()}
indirect any value {set_value(*value), get_value()}

PRIVATE:
//NodeTypes
constant uint NODE_ELEMENT                = 1
constant uint NODE_ATTRIBUTE              = 2
constant uint NODE_TEXT                   = 3
constant uint NODE_CDATA_SECTION          = 4
constant uint NODE_ENTITY_REFERENCE       = 5
constant uint NODE_PROCESSING_INSTRUCTION = 7
constant uint NODE_COMMENT                = 8
constant uint NODE_DOCUMENT               = 9
constant uint NODE_DOCUMENT_TYPE          = 10
constant uint NODE_DOCUMENT_FRAGMENT      = 11
constant uint NODE_NOTATION               = 12

//Helfer
uo_xml_node iuoEmptyNode
uo_xml_node_list iuoEmptyNodeList
OLEObject ioleTempNode
end variables

forward prototypes
public function uo_xml_node of_add_child (string as_tagname, string as_datatype)
public function uo_xml_node of_add_child (string as_tagname)
public function integer of_remove ()
private subroutine set_name (string as_name)
private function string get_name ()
private subroutine set_datatype (string as_datatype)
private function string get_datatype ()
public function uo_xml_node of_get_parent_until (string as_tagname)
public function uo_xml_node_list of_get_nodes (string as_tagname)
private subroutine set_xml (string as_xml)
private function string get_xml ()
public function uo_xml_node_list of_get_child_nodes ()
public function uo_xml_node of_get_node (string as_tagname)
private subroutine set_value (any a_value)
private function any get_value ()
public function uo_xml_node_list of_find_nodes (string as_tagname)
end prototypes

public function uo_xml_node of_add_child (string as_tagname, string as_datatype);/*
* Objekt : uo_xml_node
* Methode: of_add_child (Function)
* Autor  : Dirk Bunk
* Datum  : 01.08.2011
*
* Argument(e):
*   as_tagname  Der Name des neuen Tags.
*   as_datatype Der Datentyp des neuen Tags.
*
* Beschreibung: F$$HEX1$$fc00$$ENDHEX$$gt ein neues Tag zu einer einer XML-Node zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    01.08.2011    Erstellung
*
* Hinweis: M$$HEX1$$f600$$ENDHEX$$gliche Werte f$$HEX1$$fc00$$ENDHEX$$r den Datentyp sind zu finden unter: 
*          http://www.w3.org/TR/xmlschema-2/#built-in-datatypes
*
* Return: 
*   Die neu hinzugef$$HEX1$$fc00$$ENDHEX$$gte XML-Node.
*/

uo_xml_node uoNewNode

uoNewNode = of_add_child(as_tagname)

if isValid(uoNewNode) then 
	if not isNull(as_datatype) then uoNewNode.datatype = as_datatype
end if

return uoNewNode
end function

public function uo_xml_node of_add_child (string as_tagname);/*
* Objekt : uo_xml_node
* Methode: of_add_child (Function)
* Autor  : Dirk Bunk
* Datum  : 01.08.2011
*
* Argument(e):
*   as_tagname Der Name des neuen Tags.
*
* Beschreibung: F$$HEX1$$fc00$$ENDHEX$$gt ein neues Tag zu einer einer XML-Node zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    01.08.2011    Erstellung
*
* Return: 
*   Die neu hinzugef$$HEX1$$fc00$$ENDHEX$$gte XML-Node.
*/

OLEObject oleNewElement
uo_xml_node uoNewNode

if not isValid(iuoEmptyNode) then iuoEmptyNode = CREATE uo_xml_node
uoNewNode = iuoEmptyNode

if isValid(nodeObject) then
	oleNewElement = xmlDoc.createElement(as_tagname)
	uoNewNode.nodeObject = nodeObject.appendChild(oleNewElement)
	uoNewNode.xmlDoc = xmlDoc
end if

return uoNewNode
end function

public function integer of_remove ();/*
* Objekt : uo_xml_node
* Methode: of_remove (Function)
* Autor  : Dirk Bunk
* Datum  : 01.08.2011
*
* Argument(e):
*   keine
*
* Beschreibung: L$$HEX1$$f600$$ENDHEX$$scht diese XML-Node.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    01.08.2011    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

if isValid(nodeObject) then
	nodeObject.parentNode.removeChild(nodeObject)
	return 0
else
	return -1
end if
end function

private subroutine set_name (string as_name);//EMPTY SETTER FUNCTION
end subroutine

private function string get_name ();/*
* Objekt : uo_xml_node
* Methode: get_name (Getter Function)
* Autor  : Dirk Bunk
* Datum  : 17.06.2011
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt den Namen der XML-Node zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    17.06.2011    Erstellung
*
* Return: 
*   Der Name der XML-Node
*/

string sName = ""

if isValid(nodeObject) then
	if nodeObject.nodeType = NODE_ELEMENT and nodeObject.hasChildNodes() then
		if not isNull(nodeObject.nodeName) then sName = nodeObject.nodeName
	end if
end if

return sName
end function

private subroutine set_datatype (string as_datatype);/*
* Objekt : uo_xml_node
* Methode: set_datatype (Setter Function)
* Autor  : Dirk Bunk
* Datum  : 01.08.2011
*
* Argument(e):
*   keine
*
* Beschreibung: Setzt den Datentyp der XML-Node.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    01.08.2011    Erstellung
*
* Hinweis: M$$HEX1$$f600$$ENDHEX$$gliche Werte f$$HEX1$$fc00$$ENDHEX$$r den Datentyp sind zu finden unter: 
*          http://www.w3.org/TR/xmlschema-2/#built-in-datatypes
*
* Return: 
*   none
*/

if isValid(nodeObject) then nodeObject.datatype = as_datatype
end subroutine

private function string get_datatype ();/*
* Objekt : uo_xml_node
* Methode: get_datatype (Getter Function)
* Autor  : Dirk Bunk
* Datum  : 01.08.2011
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt den Datentyp der XML-Node zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    01.08.2011    Erstellung
*
* Hinweis: M$$HEX1$$f600$$ENDHEX$$gliche Werte f$$HEX1$$fc00$$ENDHEX$$r den Datentyp sind zu finden unter: 
*          http://www.w3.org/TR/xmlschema-2/#built-in-datatypes
*
* Return: 
*   Den Datentyp der XML-Node.
*/

string sDatatype = ""

if isValid(nodeObject) then 
	if not isNull(nodeObject.datatype) then 
		sDatatype = nodeObject.datatype
	end if
end if

return sDatatype
end function

public function uo_xml_node of_get_parent_until (string as_tagname);/*
* Objekt : uo_xml_node
* Methode: parent_until (Function)
* Autor  : Dirk Bunk
* Datum  : 17.06.2011
*
* Argument(e):
*   as_tagname Der Name des Elterntags, das gesucht ist.
*
* Beschreibung: Gibt die erste Eltern-XML-Node mit dem angegebenen Namen zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    17.06.2011    Erstellung
*
* Return: 
*   Die gefundene Eltern-XML-Node als uo_xml_node.
*/

uo_xml_node uoParent

if not isValid(iuoEmptyNode) then iuoEmptyNode = CREATE uo_xml_node
uoParent = iuoEmptyNode

if isValid(nodeObject) then
	uoParent.nodeObject = nodeObject.parentNode
	uoParent.xmlDoc = xmlDoc
end if

if isValid(uoParent) then
	do until uoParent.name = as_tagname or not isValid(uoParent.nodeObject.parentNode)
		uoParent.nodeObject = uoParent.nodeObject.parentNode
	loop
end if

return uoParent
end function

public function uo_xml_node_list of_get_nodes (string as_tagname);/*
* Objekt : uo_xml_node
* Methode: of_get_nodes (Function)
* Autor  : Dirk Bunk
* Datum  : 17.06.2011
*
* Argument(e):
*   as_tagname Das Tag in dem gesuch werden soll.
*
* Beschreibung: Gibt eine Liste von XML-Nodes zur$$HEX1$$fc00$$ENDHEX$$ck, die sich innerhalb eines Tags befinden.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    17.06.2011    Erstellung
*
* Return: 
*   Die gefundenen XML-Nodes als uo_xml_node_list.
*/

uo_xml_node_list nodeList

if not isValid(iuoEmptyNodeList) then iuoEmptyNodeList = CREATE uo_xml_node_list
nodeList = iuoEmptyNodeList

if isValid(nodeObject) then
	nodeList.nodeListObject = nodeObject.selectNodes(as_tagname)
	nodeList.xmlDoc = xmlDoc
end if

return nodeList
end function

private subroutine set_xml (string as_xml);//EMPTY SETTER FUNCTION
end subroutine

private function string get_xml ();/*
* Objekt : uo_xml_node
* Methode: get_xml (Getter Function)
* Autor  : Dirk Bunk
* Datum  : 01.08.2011
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt den XML-Inhalt der XML-Node zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    01.08.2011    Erstellung
*
* Return: 
*   Den XML-Inhalt einer XML-Node.
*/

string sXml = ""

if isValid(nodeObject) then 
	if not isNull(nodeObject.xml) then sXml = nodeObject.xml
end if

return sXml
end function

public function uo_xml_node_list of_get_child_nodes ();/*
* Objekt : uo_xml_node
* Methode: of_get_child_nodes (Function)
* Autor  : Dirk Bunk
* Datum  : 10.04.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt eine Liste von XML-Nodes zur$$HEX1$$fc00$$ENDHEX$$ck, die sich innerhalb dieser Node befinden.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.04.2012    Erstellung
*
* Return: 
*   Die gefundenen Child-Nodes als uo_xml_node_list.
*/

uo_xml_node_list uoNodeList

if not isValid(iuoEmptyNodeList) then iuoEmptyNodeList = CREATE uo_xml_node_list
uoNodeList = iuoEmptyNodeList	

if isValid(nodeObject) then
	uoNodeList.nodeListObject = nodeObject.childNodes
	uoNodeList.xmlDoc = xmlDoc
end if

return uoNodeList
end function

public function uo_xml_node of_get_node (string as_tagname);/*
* Objekt : uo_xml_node
* Methode: of_get_node (Function)
* Autor  : Dirk Bunk
* Datum  : 10.04.2012
*
* Argument(e):
*   as_tagname Das Tag in dem gesuch werden soll.
*
* Beschreibung: Gibt die erste Node zur$$HEX1$$fc00$$ENDHEX$$ck, die sich innerhalb eines Tags befindet.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.04.2012    Erstellung
*
* Return: 
*   Die gefundene XML-Node als uo_xml_node.
*/

uo_xml_node node

if not isValid(iuoEmptyNode) then iuoEmptyNode = CREATE uo_xml_node
node = iuoEmptyNode

if isValid(nodeObject) then
	node.nodeObject = nodeObject.selectSingleNode(as_tagname)
	node.xmlDoc = xmlDoc
end if

return node
end function

private subroutine set_value (any a_value);/*
* Objekt : uo_xml_node
* Methode: set_value (Setter Function)
* Autor  : Dirk Bunk
* Datum  : 01.08.2011
*
* Argument(e):
*   a_value  Der neue Wert der XML-Node
*
* Beschreibung: Setzt den Wert der XML-Node.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    01.08.2011    Erstellung
*
* Return: 
*   none
*/

if isValid(nodeObject) then nodeObject.nodeTypedValue = a_value
end subroutine

private function any get_value ();/*
* Objekt : uo_xml_node
* Methode: get_value (Getter Function)
* Autor  : Dirk Bunk
* Datum  : 17.06.2011
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt den Wert der XML-Node zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    17.06.2011    Erstellung
*   1.1        Dirk Bunk    28.07.2011    R$$HEX1$$fc00$$ENDHEX$$ckgabewert auf any ge$$HEX1$$e400$$ENDHEX$$ndert
*   1.2        Dirk Bunk    12.04.2012    Funktion zwecks besserer Performance angepasst
*
* Return: 
*   Der Wert der XML-Node als Any-Typ.
*/

any aValue
	
// Das tempor$$HEX1$$e400$$ENDHEX$$re Node Objekt wieder Null setzen, sonst l$$HEX1$$e400$$ENDHEX$$uft der Speicher voll
setNull(ioleTempNode)
setNull(aValue)

if isValid(nodeObject) then 
	ioleTempNode = nodeObject.firstChild
	if isValid(ioleTempNode) then

		// Wenn der kein Datentyp, oder String angegeben wurde, 
		// k$$HEX1$$f600$$ENDHEX$$nnen wir den Wert direkt auslesen (ca. 2x schneller)
		if dataType = "string" or dataType = "" then
			aValue = ioleTempNode.nodeValue
		else 
			if ioleTempNode.nodeType <> NODE_ELEMENT then aValue = nodeObject.nodeTypedValue
		end if
		
	end if
end if 

if isNull(aValue) then aValue = ""

return aValue
end function

public function uo_xml_node_list of_find_nodes (string as_tagname);/*
* Objekt : uo_xml_node
* Methode: of_find_nodes (Function)
* Autor  : Dirk Bunk
* Datum  : 13.04.2012
*
* Argument(e):
*   as_tagname Das Tag in dem gesuch werden soll.
*
* Beschreibung: Gibt eine Liste von XML-Nodes zur$$HEX1$$fc00$$ENDHEX$$ck, die sich innerhalb eines Tags befinden.
*               $$HEX1$$c400$$ENDHEX$$hnelt der Funktion of_get_nodes, durchsucht aber alle Unterebenen.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    13.04.2012    Erstellung
*
* Return: 
*   Die gefundenen XML-Nodes als uo_xml_node_list.
*/

uo_xml_node_list nodeList

if not isValid(iuoEmptyNodeList) then iuoEmptyNodeList = CREATE uo_xml_node_list
nodeList = iuoEmptyNodeList

if isValid(nodeObject) then
	nodeList.nodeListObject = nodeObject.getElementsByTagName(as_tagname)
	nodeList.xmlDoc = xmlDoc
end if

return nodeList
end function

on uo_xml_node.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_xml_node.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;if isValid(iuoEmptyNode) then DESTROY iuoEmptyNode
if isValid(iuoEmptyNodeList) then DESTROY iuoEmptyNodeList

if isValid(ioleTempNode) then 
	ioleTempNode.DisconnectObject()
	DESTROY ioleTempNode
end if

if isValid(nodeObject) then 
	nodeObject.DisconnectObject()
	DESTROY nodeObject
end if

if isValid(xmlDoc) then
	xmlDoc.DisconnectObject()
	DESTROY xmlDoc
end if
end event

