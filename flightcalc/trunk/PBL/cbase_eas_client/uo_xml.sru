HA$PBExportHeader$uo_xml.sru
$PBExportComments$COMCTL32 - Microsoft Common Control - StatusBar32
forward
global type uo_xml from nonvisualobject
end type
end forward

global type uo_xml from nonvisualobject
end type
global uo_xml uo_xml

type variables
Public:
OleObject		oleXML

String			sXMLPath
String			sXMLFile

String			sMasterTag

String			sErrormessage

Integer			iInit
end variables

forward prototypes
public function integer of_xml_init ()
public function s_xml_return of_get_items_raw (oleobject oroot, ref s_xml_data strvalues[])
public function s_xml_return of_xml_create_root_item (s_xml_data strxml)
public function s_xml_return of_xml_create_item (s_xml_data strxml, oleobject oletag)
private function string of_check_null (string sval)
public function s_xml_return of_get_items (oleobject oroot, ref s_xml_data strvalues[])
public function s_xml_return of_get_root_item ()
public function s_xml_return of_xml_create_node_item (s_xml_data strxml, oleobject oletag)
end prototypes

public function integer of_xml_init ();// ------------------------------------------
// 
// XML File mit Header erzeugen
//
// ------------------------------------------
String sXMLHeader
Integer iRet

// ------------------------------------------
// Ist der Dateiname gesetzt
// ------------------------------------------
if isnull(this.sXMLFile) or trim(this.sXMLFile) = "" then
	this.sErrorMessage = "Filename missing"
	return -1
end if

// ------------------------------------------
// Ist der Mastertag gesetzt
// ------------------------------------------
if isnull(this.sMasterTag) or trim(this.sMasterTag) = "" then
	this.sErrorMessage = "Mastertag missing"
	return -1
end if

// ------------------------------------------
// leeres XML - File erstellen
// ------------------------------------------
sXMLHeader = "<?xml version=~"1.0~" encoding=~"UTF-16~" standalone=~"yes~"?><" + this.sMasterTag + "/>"

if oleXML.LoadXML(sXMLHeader) Then
	oleXML.save(this.sXMLFile)
else
	this.sErrorMessage = "LoadXML failed"
	return -1
end if

return 0

end function

public function s_xml_return of_get_items_raw (oleobject oroot, ref s_xml_data strvalues[]);// --------------------------------------------
//
// Alle Childnodes eines Elements auslesen
//
// Die Werte der Nodes werden in die, per
// Referenz $$HEX1$$fc00$$ENDHEX$$bergebene, Struktur gepackt
// --------------------------------------------

OleObject		oleXMLNodes, oleXMLChildNode

Long				lNodes

String			sDatatype, sData, sValue

s_xml_return	strReturn

oleXMLNodes = oRoot.ChildNodes()



For lNodes = 0 TO (oleXMLNodes.length - 1)
	
	oleXMLChildNode 				    = oleXMLNodes.item(lNodes)
	
	sDatatype 							 = oleXMLChildNode.nodeTypeString
	sData	 							 	 = oleXMLChildNode.nodeTypedValue
	sValue								 = f_check_null(oleXMLChildNode.nodeValue)
	
	strValues[lNodes + 1].sTag		 = oleXMLChildNode.nodeName
	strValues[lNodes + 1].stype    = sDatatype
	strValues[lNodes + 1].oObject  = oleXMLChildNode
	
	Messagebox(string(oleXMLNodes.length), f_check_null(sData) + " - " + f_check_null(sDatatype))
	
//	Choose Case LOWER(sDatatype)
//			
//		case "int"
//			strValues[lNodes + 1].lNumber = oleXMLNodes.item[lNodes].nodeTypedValue
//	
//		case "string"
//			strValues[lNodes + 1].sString = oleXMLNodes.item[lNodes].nodeTypedValue
//	
//		case "boolean"
//			strValues[lNodes + 1].bBool = oleXMLNodes.item[lNodes].nodeTypedValue
//	
//		case "bin.base64"
//			strValues[lNodes + 1].bBlob = oleXMLNodes.item[lNodes].nodeTypedValue
//			
//		case else
//			strReturn.iStatus = -1
//			strReturn.sStatus = "Unknown datatype: " + sDatatype
//			return strReturn
//						
//	End Choose

Next

strReturn.iStatus = 0
strReturn.sStatus = ""

return strReturn

end function

public function s_xml_return of_xml_create_root_item (s_xml_data strxml);// ------------------------------------------
//
// XML-Root-Item erstellen
//
// ------------------------------------------

OleObject		oleNewItem
s_xml_return	strReturn

if isnull(strXML.sTag) or trim(strXML.sTag) = "" then
	strReturn.iStatus = -1
	strReturn.sStatus = "Tag not defined. "
	return strReturn
end if

oleNewItem = oleXML.CreateElement(strXML.sTag)
oleXML.documentElement.appendChild(oleNewItem)

strReturn.iStatus = 0
strReturn.sStatus = ""
strReturn.oObject = oleNewItem

return strReturn

end function

public function s_xml_return of_xml_create_item (s_xml_data strxml, oleobject oletag);// ------------------------------------------
//
// XML-Item erstellen
//
// ------------------------------------------

OleObject		oleNewItem
s_xml_return	strReturn

if isnull(strXML.sTag) or trim(strXML.sTag) = "" then
	strReturn.iStatus = -1
	strReturn.sStatus = "Tag not defined. "
	return strReturn
end if

choose case strXML.sType
	
	case "string"
		oleNewItem 						= oleXML.CreateElement(strXML.sTag)
		oleNewItem.dataType 			= "string"
		oleNewItem.nodeTypedValue  = this.of_check_null(strXML.sString)
		oleTag.appendChild(oleNewItem)
	
	case "boolean"
		oleNewItem 						= oleXML.CreateElement(strXML.sTag)
		oleNewItem.dataType 			= "boolean"
		oleNewItem.nodeTypedValue  = strXML.bBool
		oleTag.appendChild(oleNewItem)
		
	case "int"	
		oleNewItem 						= oleXML.CreateElement(strXML.sTag)
		oleNewItem.dataType 			= "int"
		oleNewItem.nodeTypedValue  = strXML.lNumber
		oleTag.appendChild(oleNewItem)
		
	case "bin.base64"
		oleNewItem 						= oleXML.CreateElement(strXML.sTag)
		oleNewItem.dataType 			= "bin.base64"
		oleNewItem.nodeTypedValue  = strXML.bBlob
		oleTag.appendChild(oleNewItem)
		
	case "node"
		oleNewItem = oleXML.CreateElement(strXML.sTag)
		oleTag.documentElement.appendChild(oleNewItem)
		
	case else
		strReturn.iStatus = -1
		strReturn.sStatus = "unknown datatype: " + strXML.sType
		return strReturn 		
end choose
		
oleXML.save(this.sXMLFile)

strReturn.iStatus = 0
strReturn.sStatus = ""
strReturn.oObject = oleNewItem

return strReturn

end function

private function string of_check_null (string sval);if isNull(sVal) then return ""
return sVal
end function

public function s_xml_return of_get_items (oleobject oroot, ref s_xml_data strvalues[]);// --------------------------------------------
//
// Alle Childnodes eines Elements auslesen
//
// Die Werte der Nodes werden in die, per
// Referenz $$HEX1$$fc00$$ENDHEX$$bergebene, Struktur gepackt
// --------------------------------------------

OleObject		oleXMLNodes

Long				lNodes

String			sDatatype

s_xml_return	strReturn

oleXMLNodes = oRoot.ChildNodes()



For lNodes = 0 TO (oleXMLNodes.length - 1)
	
	strValues[lNodes + 1].sTag		 = oleXMLNodes.item[lNodes].nodeName
	
	if isnull(oleXMLNodes.item[lNodes].dataType) then
		sDatatype = "node"
	else
		sDatatype = oleXMLNodes.item[lNodes].dataType
	end if
	
	strValues[lNodes + 1].stype = sDatatype
	strValues[lNodes + 1].oObject = oleXMLNodes.item[lNodes]
	
	//Messagebox(string(oleXMLNodes.length), strValues[lNodes + 1].sTag)
	
	Choose Case LOWER(sDatatype)
			
		case "int"
			strValues[lNodes + 1].lNumber = oleXMLNodes.item[lNodes].nodeTypedValue
	
		case "string"
			strValues[lNodes + 1].sString = oleXMLNodes.item[lNodes].nodeTypedValue
	
		case "boolean"
			strValues[lNodes + 1].bBool = oleXMLNodes.item[lNodes].nodeTypedValue
	
		case "bin.base64"
			strValues[lNodes + 1].bBlob = oleXMLNodes.item[lNodes].nodeTypedValue
		
		case "node"
			strValues[lNodes + 1].oObject = oleXMLNodes.item[lNodes]
			
		case else
			strReturn.iStatus = -1
			strReturn.sStatus = "Unknown datatype: " + sDatatype
			return strReturn
						
	End Choose

Next

strReturn.iStatus = 0
strReturn.sStatus = ""

return strReturn

end function

public function s_xml_return of_get_root_item ();// ------------------------------------------------------------
// 
// Das Root Item finden
//
// ------------------------------------------------------------

OleObject	oleXMLRoot

Long			lNodes, &
				lLabel = 0
String		sNodeName
Boolean		bLoaded

s_xml_return strReturn

oleXML.Load(sXMLFile)

bLoaded = oleXML.Load(this.sXMLFile)

IF bLoaded = false THEN
	 // --------------------------------------
    // Error parsen
	 // --------------------------------------
	 strReturn.iStatus =  -1
	 strReturn.sStatus = "Load of XML file: " + of_check_null(this.sXMLFile)  + " failed ~r" + &
	 						 + "ErrorCode: "+ string(oleXML.parseError.ErrorCode)   + "~r" + &
							 + "FilePosition: " + string(oleXML.parseError.Filepos) + "~r" + &
							 + "Line: " + string(oleXML.parseError.Line) 			  + "~r" + &
							 + "LinePosition: " + string(oleXML.parseError.Linepos) + "~r" + &
							 + "Reason: " + string(oleXML.parseError.Reason) + "~r" +  &
							 + "SourceText: " + string(oleXML.parseError.SrcText)
	
	 return strReturn
	 
END IF  

oleXMLRoot = oleXML.documentElement

if Not isValid(oleXMLRoot) Then
	strReturn.sStatus = "Root Element not found"
	strReturn.iStatus =  -1
	return strReturn
end if

strReturn.sStatus = ""
strReturn.iStatus = 0
strReturn.oObject	= oleXMLRoot

//
// ALT
//
//oleXMLRoot = oleXML.documentElement
//
//if Not isValid(oleXMLRoot) Then
//	strReturn.sStatus = "Root Element not found"
//	strReturn.iStatus =  -1
//	return strReturn
//end if
//
//strReturn.sStatus = ""
//strReturn.iStatus = 0
//strReturn.oObject	= oleXMLRoot
//


return strReturn

end function

public function s_xml_return of_xml_create_node_item (s_xml_data strxml, oleobject oletag);/*************************************************************
* Objekt : uo_xml
* Methode: of_xml_create_node_item (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 16.12.2009
* Argument(e):
* s_xml_data strxml
*  oleobject oletag
*
* Return: s_xml_return
*
*
*
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  16.12.2009	1.1           Ulrich Paudler     Parameterliste erweitert und appendchild ge$$HEX1$$e400$$ENDHEX$$ndert
*
*************************************************************/
// ------------------------------------------
//
// XML-Root-Item erstellen
//
// ------------------------------------------

OleObject		oleNewItem
s_xml_return	strReturn

if isnull(strXML.sTag) or trim(strXML.sTag) = "" then
	strReturn.iStatus = -1
	strReturn.sStatus = "Tag not defined. "
	return strReturn
end if

oleNewItem = oleXML.CreateElement(strXML.sTag)
// 16.12.2009 Ulrich Paudler [UP]
//oleXML.appendChild(oleNewItem)
oleTag.appendChild(oleNewItem)


strReturn.iStatus = 0
strReturn.sStatus = ""
strReturn.oObject = oleNewItem

return strReturn

end function

on uo_xml.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_xml.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;
DESTROY oleXML
end event

event constructor;Integer iRet

// ------------------------------------------
// OleObject erzeugen
// ------------------------------------------
oleXML 	= CREATE OleObject
iRet = oleXML.ConnectToNewObject("MSXML2.DOMDocument")

if iRet <> 0 then
	this.sErrorMessage = "ConnectToNewObject failed: " + String(iRet)
	this.iInit = -1
else
	this.iInit = 0
end if

end event

