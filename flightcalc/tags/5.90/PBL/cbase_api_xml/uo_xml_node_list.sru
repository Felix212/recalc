HA$PBExportHeader$uo_xml_node_list.sru
forward
global type uo_xml_node_list from nonvisualobject
end type
end forward

global type uo_xml_node_list from nonvisualobject
end type
global uo_xml_node_list uo_xml_node_list

type variables
PUBLIC:
OLEObject nodeListObject
OLEObject xmlDoc

//Properties
indirect long length {set_length(*value), get_length()}
indirect uo_xml_node firstNode {set_first_node(*value), get_first_node()}
indirect uo_xml_node lastNode {set_last_node(*value), get_last_node()}
end variables

forward prototypes
private subroutine set_length (long al_length)
private subroutine set_first_node (uo_xml_node auo_firstnode)
private function uo_xml_node get_first_node ()
public function uo_xml_node of_get_node (long al_index)
private subroutine set_last_node (uo_xml_node auo_firstnode)
private function uo_xml_node get_last_node ()
public function long get_length ()
end prototypes

private subroutine set_length (long al_length);// EMPTY SETTER FUNCTION
end subroutine

private subroutine set_first_node (uo_xml_node auo_firstnode);// EMPTY SETTER FUNCTION
end subroutine

private function uo_xml_node get_first_node ();/*
* Objekt : uo_xml_node_list
* Methode: get_first_node (Getter Function)
* Autor  : Dirk Bunk
* Datum  : 01.08.2011
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt die erste Node der XML-Node Liste zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    01.08.2011    Erstellung
*
* Return: 
*   Die erste Node der XML-Node Liste.
*/

return of_get_node(0)
end function

public function uo_xml_node of_get_node (long al_index);/*
* Objekt : uo_xml_node_list
* Methode: of_get_node (Function)
* Autor  : Dirk Bunk
* Datum  : 17.06.2011
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt die XML-Node des angegebenen Index zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    17.06.2011    Erstellung
*
* Return: 
*   Die gefundene XML-Node als uo_xml_node
*/

uo_xml_node luo_Node

luo_Node = CREATE uo_xml_node

if IsValid(nodeListObject) then
	luo_Node.nodeObject = nodeListObject.item(al_index)
	luo_Node.xmlDoc = xmlDoc
end if

return luo_Node
end function

private subroutine set_last_node (uo_xml_node auo_firstnode);// EMPTY SETTER FUNCTION
end subroutine

private function uo_xml_node get_last_node ();/*
* Objekt : uo_xml_node_list
* Methode: get_last_node (Getter Function)
* Autor  : Dirk Bunk
* Datum  : 10.04.2012
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt die letzte Node der XML-Node Liste zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    01.08.2011    Erstellung
*
* Return: 
*   Die letzte Node der XML-Node Liste.
*/

return of_get_node(length - 1)
end function

public function long get_length ();/*
* Objekt : uo_xml_node_list
* Methode: get_length (Getter Function)
* Autor  : Dirk Bunk
* Datum  : 01.08.2011
*
* Argument(e):
*   keine
*
* Beschreibung: Gibt die Anzahl der Elemente in der XML-Node Liste zur$$HEX1$$fc00$$ENDHEX$$ck.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    01.08.2011    Erstellung
*   1.1        Ulrich Paudler   19.02.2014    private->public fuer die Verwendung im SmartClient
*
* Return: 
*   Die Anzahl der Elemente der XML-Node Liste.
*/

if IsValid(nodeListObject) then
	return nodeListObject.length
else
	return 0
end if
end function

on uo_xml_node_list.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_xml_node_list.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;// Aufr$$HEX1$$e400$$ENDHEX$$umen
if IsValid(nodeListObject) then 
	nodeListObject.DisconnectObject()
	DESTROY nodeListObject
end if
end event

