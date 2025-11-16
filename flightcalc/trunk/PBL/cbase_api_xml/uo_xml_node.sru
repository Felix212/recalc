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

// Properties
indirect string datatype {set_datatype(*value), get_datatype()}
indirect string name {set_name(*value), get_name()}
indirect string xml {set_xml(*value), get_xml()}
indirect any value {set_value(*value), get_value()}

PRIVATE:
// NodeTypes
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
private function any get_value ()
public function uo_xml_node_list of_find_nodes (string as_tagname)
public function string of_get_attribute (string as_name)
public function integer of_set_attribute (string as_name, string as_text)
private subroutine set_value (any aa_value)
public function uo_xml_node_list of_get_nodes (string as_tagname, boolean ab_recursive, string as_expression)
public function uo_xml_node_list of_get_nodes (string as_tagname, boolean ab_recursive)
public function uo_xml_node_list of_get_nodes_by_query (string as_query)
public function uo_xml_node of_get_node (string as_tagname, boolean ab_recursive, string as_expression)
public function uo_xml_node of_get_node (string as_tagname, boolean ab_recursive)
public function uo_xml_node of_get_node_by_query (string as_query)
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
* Beschreibung: F$$HEX1$$fc00$$ENDHEX$$gt ein neues Tag zu einer XML-Node zur$$HEX1$$fc00$$ENDHEX$$ck.	
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

uo_xml_node luo_NewNode

luo_NewNode = of_add_child(as_tagname)

if IsValid(luo_NewNode) then 
	if not IsNull(as_datatype) then luo_NewNode.datatype = as_datatype
end if

return luo_NewNode
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
* Beschreibung: F$$HEX1$$fc00$$ENDHEX$$gt ein neues Tag zu einer XML-Node zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    01.08.2011    Erstellung
*
* Return: 
*   Die neu hinzugef$$HEX1$$fc00$$ENDHEX$$gte XML-Node.
*/

OLEObject lole_NewElement
uo_xml_node luo_NewNode

luo_NewNode = CREATE uo_xml_node

if isValid(nodeObject) then
	lole_NewElement = xmlDoc.createElement(as_tagname)
	luo_NewNode.nodeObject = nodeObject.appendChild(lole_NewElement)
	luo_NewNode.xmlDoc = xmlDoc
end if

return luo_NewNode
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

if IsValid(nodeObject) then
	nodeObject.parentNode.removeChild(nodeObject)
	return 0
else
	return -1
end if
end function

private subroutine set_name (string as_name);// EMPTY SETTER FUNCTION
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
*   1.1        Dirk Bunk    21.10.2013    Pr$$HEX1$$fc00$$ENDHEX$$fung auf nodeObject.hasChildNodes() entfernt, 
*                                         damit auch die Namen leerer Nodes ausgelesen werden k$$HEX1$$f600$$ENDHEX$$nnen
*
* Return: 
*   Der Name der XML-Node
*/

string ls_Name = ""

if IsValid(nodeObject) then
	if nodeObject.nodeType = NODE_ELEMENT then
		if not IsNull(nodeObject.nodeName) then ls_Name = nodeObject.nodeName
	end if
end if

return ls_Name
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

if IsValid(nodeObject) then nodeObject.datatype = as_datatype
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

string ls_Datatype = ""

if IsValid(nodeObject) then 
	if not IsNull(nodeObject.datatype) then 
		ls_Datatype = nodeObject.datatype
	end if
end if

return ls_Datatype
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

uo_xml_node luo_Parent

luo_Parent = CREATE uo_xml_node

if IsValid(nodeObject) then
	luo_Parent.nodeObject = nodeObject.parentNode
	luo_Parent.xmlDoc = xmlDoc
end if

if IsValid(luo_Parent) then
	do until luo_Parent.name = as_tagname or not IsValid(luo_Parent.nodeObject.parentNode)
		luo_Parent.nodeObject = luo_Parent.nodeObject.parentNode
	loop
end if

return luo_Parent
end function

public function uo_xml_node_list of_get_nodes (string as_tagname);return of_get_nodes(as_Tagname, false, "")
end function

private subroutine set_xml (string as_xml);// EMPTY SETTER FUNCTION
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

string ls_Xml = ""

if IsValid(nodeObject) then 
	if not IsNull(nodeObject.xml) then ls_Xml = nodeObject.xml
end if

return ls_Xml
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

uo_xml_node_list luo_NodeList

luo_NodeList = CREATE uo_xml_node_list

if IsValid(nodeObject) then
	luo_NodeList.nodeListObject = nodeObject.childNodes
	luo_NodeList.xmlDoc = xmlDoc
end if

return luo_NodeList
end function

public function uo_xml_node of_get_node (string as_tagname);return of_get_node(as_Tagname, false, "")
end function

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

OLEObject lole_Node
any la_Value

SetNull(la_Value)

if IsValid(nodeObject) then 
	lole_Node = nodeObject.firstChild
	if IsValid(lole_Node) then

		// Wenn kein Datentyp, oder String angegeben wurde, 
		// k$$HEX1$$f600$$ENDHEX$$nnen wir den Wert direkt auslesen (ca. 2x schneller)
		if dataType = "string" or dataType = "" then
			la_Value = lole_Node.nodeValue
		else 
			if lole_Node.nodeType <> NODE_ELEMENT then la_Value = nodeObject.nodeTypedValue
		end if
		
	end if
end if 

if IsNull(la_Value) then la_Value = ""

return la_Value
end function

public function uo_xml_node_list of_find_nodes (string as_tagname);/*
Diese Funktion ist veraltet und sollte nicht mehr verwendet werden.
Stattdessen bitte einfach die Funktion of_get_nodes verwenden (so wie hier).
*/
return of_get_nodes(as_Tagname, true)
end function

public function string of_get_attribute (string as_name);/*
* Objekt : uo_xml_node
* Methode: of_get_attribute (Function)
* Autor  : Dirk Bunk
* Datum  : 19.09.2012
*
* Argument(e):
*   as_name Der Name des Attributs.
*
* Beschreibung: Liest ein Attribut einer XML-Node aus.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    19.09.2012    Erstellung
*
* Return: 
*   Der Wert des Attributs.
*/

OLEObject lole_Item
string ls_text = ""

if IsValid(nodeObject) then
	lole_Item = nodeObject.attributes.getNamedItem(as_name)
	if IsValid(lole_Item) then ls_text = lole_Item.text
end if

return ls_text
end function

public function integer of_set_attribute (string as_name, string as_text);/*
* Objekt : uo_xml_node
* Methode: of_set_attribute (Function)
* Autor  : Dirk Bunk
* Datum  : 19.09.2012
*
* Argument(e):
*   as_name Der Name des Attributs.
*   as_text Der Text des Attributs.
*
* Beschreibung: Setzt den Wert eines Attributs einer XML-Node.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    19.09.2012    Erstellung
*
* Return: 
*   0: OK
*  -1: Fehler
*/

OLEObject ole_Item
integer li_Ret = 0

if isValid(nodeObject) then
	ole_Item = xmlDoc.createAttribute(as_name);
   ole_Item.value = as_text;
	
	ole_Item = nodeObject.attributes.setNamedItem(ole_Item)
	if not IsValid(ole_Item) then li_Ret = -1
else 
	li_Ret = -1
end if

return li_Ret
end function

private subroutine set_value (any aa_value);/*
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

if IsValid(nodeObject) then nodeObject.nodeTypedValue = aa_value
end subroutine

public function uo_xml_node_list of_get_nodes (string as_tagname, boolean ab_recursive, string as_expression);/*
* Objekt : uo_xml_node
* Methode: of_get_nodes (Function)
* Autor  : Dirk Bunk
* Datum  : 17.06.2011
*
* Argument(e):
*   as_Tagname    Das Tag, nach dem gesucht werden soll.
*   ab_Recursive  Wenn true, werden auch s$$HEX1$$e400$$ENDHEX$$mtliche Unterknoten nach dem Tag durchsucht
*   ab_Expression Eine Zusatzbedingung f$$HEX1$$fc00$$ENDHEX$$r die Suche z.B.: "Price>35.00" oder "DocType='SpmlSheet'"
*
* Beschreibung: Gibt eine Liste von XML-Nodes zur$$HEX1$$fc00$$ENDHEX$$ck, die sich unter dieser Node befinden und den Suchkriterien entsprechen.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    17.06.2011    Erstellung
*   1.1        Dirk Bunk    13.06.2014    Erweitert um Recursive und Expression Parameter
*   1.2        Dirk Bunk    23.10.2014    Try..Catch f$$HEX1$$fc00$$ENDHEX$$r evtl. fehlerhafte Expression eingebaut
*
* Return: 
*   Die gefundenen XML-Nodes als uo_xml_node_list.
*/

string ls_Select = ""
uo_xml_node_list luo_NodeList

luo_NodeList = CREATE uo_xml_node_list

if IsValid(nodeObject) then
	if ab_Recursive then ls_Select += ".//"
	ls_Select += as_Tagname
	if as_Expression <> "" then ls_Select += "[" + as_Expression + "]"
	
	try
		luo_NodeList.nodeListObject = nodeObject.selectNodes(ls_Select)
	catch (RuntimeError ex)
	end try
	
	luo_NodeList.xmlDoc = xmlDoc
end if

return luo_NodeList
end function

public function uo_xml_node_list of_get_nodes (string as_tagname, boolean ab_recursive);return of_get_nodes(as_Tagname, ab_Recursive, "")
end function

public function uo_xml_node_list of_get_nodes_by_query (string as_query);/*
* Objekt : uo_xml_node
* Methode: of_get_nodes_by_query (Function)
* Autor  : Dirk Bunk
* Datum  : 13.06.2014
*
* Argument(e):
*   as_Query Ein Suchanfrage in Xpath Syntax (http://www.w3schools.com/XPath/xpath_syntax.asp)
*
* Beschreibung: Gibt eine Liste von XML-Nodes zur$$HEX1$$fc00$$ENDHEX$$ck, die den Suchkriterien entsprechen.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    13.06.2014    Erstellung
*   1.1        Dirk Bunk    23.10.2014    Try..Catch f$$HEX1$$fc00$$ENDHEX$$r evtl. fehlerhafte Expression eingebaut

*
* Return: 
*   Die gefundenen XML-Nodes als uo_xml_node_list.
*/

uo_xml_node_list luo_NodeList

luo_NodeList = CREATE uo_xml_node_list

if IsValid(nodeObject) then
	try
		luo_NodeList.nodeListObject = nodeObject.selectNodes(as_query)
	catch (RuntimeError ex)
	end try
	
	luo_NodeList.xmlDoc = xmlDoc
end if

return luo_NodeList
end function

public function uo_xml_node of_get_node (string as_tagname, boolean ab_recursive, string as_expression);/*
* Objekt : uo_xml_node
* Methode: of_get_node (Function)
* Autor  : Dirk Bunk
* Datum  : 10.04.2012
*
* Argument(e):
*   as_Tagname    Das Tag, nach dem gesucht werden soll.
*   ab_Recursive  Wenn true, werden auch s$$HEX1$$e400$$ENDHEX$$mtliche Unterknoten nach dem Tag durchsucht
*   ab_Expression Eine Zusatzbedingung f$$HEX1$$fc00$$ENDHEX$$r die Suche z.B.: "Price>35.00" oder "DocType='SpmlSheet'"
*
* Beschreibung: Gibt die erste XML-Node zur$$HEX1$$fc00$$ENDHEX$$ck, die sich unter dieser Node befindet und den Suchkriterien entspricht.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    10.04.2012    Erstellung
*   1.1        Dirk Bunk    13.06.2014    Erweitert um Recursive und Expression Parameter
*   1.2        Dirk Bunk    23.10.2014    Try..Catch f$$HEX1$$fc00$$ENDHEX$$r evtl. fehlerhafte Expression eingebaut
*
* Return: 
*   Die gefundene XML-Node als uo_xml_node.
*/

string ls_Select = ""
uo_xml_node luo_Node

luo_Node = CREATE uo_xml_node

if IsValid(nodeObject) then
	if ab_Recursive then ls_Select += ".//"
	ls_Select += as_Tagname
	if as_Expression <> "" then ls_Select += "[" + as_Expression + "]"
	
	try
		luo_Node.nodeObject = nodeObject.selectSingleNode(ls_Select)
	catch (RuntimeError ex)
	end try
	
	luo_Node.xmlDoc = xmlDoc
end if

return luo_Node
end function

public function uo_xml_node of_get_node (string as_tagname, boolean ab_recursive);return of_get_node(as_Tagname, ab_Recursive, "")
end function

public function uo_xml_node of_get_node_by_query (string as_query);/*
* Objekt : uo_xml_node
* Methode: of_get_node_by_query (Function)
* Autor  : Dirk Bunk
* Datum  : 13.06.2014
*
* Argument(e):
*   as_Query Ein Suchanfrage in Xpath Syntax (http://www.w3schools.com/XPath/xpath_syntax.asp)
*
* Beschreibung: Gibt die erste gefundene XML-Node zur$$HEX1$$fc00$$ENDHEX$$ck, die den Suchkriterien entsprechen.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    13.06.2014    Erstellung
*   1.1        Dirk Bunk    23.10.2014    Try..Catch f$$HEX1$$fc00$$ENDHEX$$r evtl. fehlerhafte Expression eingebaut
*
* Return: 
*   Die gefundene XML-Node als uo_xml_node.
*/

uo_xml_node luo_Node

luo_Node = CREATE uo_xml_node

if IsValid(nodeObject) then
	try
		luo_Node.nodeObject = nodeObject.selectSingleNode(as_query)
	catch (RuntimeError ex)
	end try
	
	luo_Node.xmlDoc = xmlDoc
end if

return luo_Node
end function

on uo_xml_node.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_xml_node.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;// Aufr$$HEX1$$e400$$ENDHEX$$umen
if IsValid(nodeObject) then 
	nodeObject.DisconnectObject()
	DESTROY nodeObject
end if
end event

