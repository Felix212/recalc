HA$PBExportHeader$uo_label_return.sru
forward
global type uo_label_return from nonvisualobject
end type
end forward

global type uo_label_return from nonvisualobject
end type
global uo_label_return uo_label_return

type variables
Public:

blob 			bLabel
blob			bLocationSheet
blob			bDistributionErrors
Long 			lLabelType
String		sLabel
String		sLabelComment
String		sWorkstation
boolean		isBelly
Integer		iPrinterType
Integer		iLabelSort
Integer		iLabelPageBreak
String 		sGeneratedForPrinter

String		sEscapeBefore
String		sEscapeAfter



Private:
n_base64				nBase64
n_cbase				nCbase




end variables

forward prototypes
public subroutine writelog (string smsg)
public function blob of_generate_xml_fragment ()
public function blob of_encode (blob ab_string)
end prototypes

public subroutine writelog (string smsg);IF isValid(nCbase) THEN
	nCbase.writelog(sMsg)
END IF
end subroutine

public function blob of_generate_xml_fragment ();Blob		bXMLNode 
Long		lRet
Blob bEncoded, bDecoded

bXMLNode = Blob("")
// ------------------------------
// wir erzeugen ein XML-Fragment
// ------------------------------
//lRet = its_jag.CreateInstance(nBase64, "encoder/n_base64") 

if lRet = 0 Then
	bXMLNode = Blob(																									  &
			   "<Label>"																								+ &
					"<PrinterType dt:dt=~"int~">" + string(iPrinterType) + "</PrinterType>")			
	
	// ------------------------------
	// der Labeltyp (Name des Labels)
	// ------------------------------
	if Not isNull(sLabel) AND len(Trim(sLabel)) > 0 Then		
		bXMLNode = bXMLNode + Blob("<LabelType dt:dt=~"string~">" + sLabel + "</LabelType>")
	else
		bXMLNode = bXMLNode + Blob("<LabelType dt:dt=~"string~">Unknown</LabelType>")
	end if
	
	// ------------------------------
	// der Kommentar
	// ------------------------------	
	if Not isNull(sLabel) AND len(Trim(sLabel)) > 0 Then
		
		if iLabelSort = 1 and iLabelPageBreak = 1 then
			bXMLNode = bXMLNode + Blob("<Comment dt:dt=~"string~">" + sLabelComment + "</Comment>")
		elseif iLabelSort = 1 and iLabelPageBreak = 0 then
			bXMLNode = bXMLNode + Blob("<Comment dt:dt=~"string~">Sorted by Area</Comment>")
		elseif iLabelSort = 2 then
			bXMLNode = bXMLNode + Blob("<Comment dt:dt=~"string~">Sorted by Galley</Comment>")
		end if
	else
		bXMLNode = bXMLNode + Blob("<Comment dt:dt=~"string~"/>")
	end if

	// ------------------------------
	// Galley oder Belly Label
	// ------------------------------	
	if isBelly Then		
		bXMLNode = bXMLNode + Blob("<IsBelly dt:dt=~"boolean~">1</IsBelly>")
	else
		bXMLNode = bXMLNode + Blob("<IsBelly dt:dt=~"boolean~">0</IsBelly>")
	end if

	// ------------------------------
	// Before und AfterPrint
	// ------------------------------	
	if Not isNull(sEscapeBefore) AND len(Trim(sEscapeBefore)) > 0 Then		
		bXMLNode = bXMLNode + Blob("<PrintBefore dt:dt=~"string~">" + sEscapeBefore + "</PrintBefore>")
	else
		bXMLNode = bXMLNode + Blob("<PrintBefore dt:dt=~"string~"/>")
	end if
	if Not isNull(sEscapeAfter) AND len(Trim(sEscapeAfter)) > 0 Then		
		bXMLNode = bXMLNode + Blob("<PrintAfter dt:dt=~"string~">" + sEscapeAfter + "</PrintAfter>")
	else
		bXMLNode = bXMLNode + Blob("<PrintAfter dt:dt=~"string~"/>")
	end if
	
	// -----------------------------------
	// nun die Daten. Hierbei handelt
	// es sich um eine PSR-Datei. Diese
	// m$$HEX1$$fc00$$ENDHEX$$ssen wir aber in Base64 codieren
	// -----------------------------------	
	
	//f_blob_to_file("d:\sybase\label" + string(cpu())+ ".psr", this.bLabel)
		//f_blob_to_file("c:\temp\source.text",this.bLabel)
		bEncoded = of_encode(this.bLabel)
	//bEncoded = nBase64.base64encode (this.bLabel)
//	bDecoded = nBase64.base64decode (bEncoded)
// datastore dsTemp
//	dsTemp = create datastore
//	dsTemp.dataobject = "dw_loadinglist_result"
//	dsTemp.SetFullstate(bDecoded)
//	dsTemp.SaveAs("c:\temp\uo_label_return_" + string(cpu()) + ".xls", Excel5!, true)
	//bXMLNode = bXMLNode + Blob("<Data dt:dt=~"bin.base64~">") + nBase64.base64encode (bLabel) + Blob("</Data>")
	bXMLNode = bXMLNode + Blob("<Data dt:dt=~"bin.base64~">") + bEncoded + Blob("</Data>")
	bXMLNode = bXMLNode + Blob("</Label>")
else
	writelog("Error bei Generierung XML-Label-Fragment: Kann n_base64 nicht instanziieren Errorcode " + string(lRet))
end if

return bXMLNode

end function

public function blob of_encode (blob ab_string);
string sreturn,sempty
blob breturn,bhelp
long lfound
uo_xml uoXML
s_xml_return	strXMLReturn
s_xml_return    strXMLMaster
s_xml_data		strXMLData


uoXML 			= Create uo_xml
uoXML.sXMLFile = "Test"
uoXML.sMasterTag = "CBASE_XLS"

uoXML.of_xml_init()
strXMLMaster = uoXML.of_get_root_item()

strXMLData.sTag = "Label"
strXMLData.bblob = ab_string
strXMLData.sType = "bin.base64"
//f_blob_to_file("source.text",ab_string)
strXMLReturn 	= uoXML.of_xml_create_item(strXMLData, strXMLMaster.oObject)

sreturn = strXMLReturn.oobject.text
//Alle Linefeeds entfernen
lfound = Pos(sreturn,"~h0A",1)

	if lfound > 0 then
		//ersetzen und weitere Positionen suchen
		do while lfound <>0
		
		sreturn=Replace(sreturn,lfound,1,"")
		lfound = Pos(sreturn,"~h0A",lfound+1)
		
		loop
		
	end if
	


breturn = blob(sreturn)
//f_blob_to_file("test.text",breturn)

destroy(uoXml)
return breturn
end function

on uo_label_return.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_label_return.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;If isvalid(nBase64) then setnull(nBase64)
If isvalid(nCbase) then setnull(nCbase)

If not isnull(bLabel) then setnull(bLabel)
If not isnull(bLocationSheet) then setnull(bLabel)
If not isnull(bDistributionErrors) then setnull(bLabel)



end event

