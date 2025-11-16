HA$PBExportHeader$uo_distribution_container.sru
$PBExportComments$Bei der Mahlzeitenverteilung wird f$$HEX1$$fc00$$ENDHEX$$r jedem Stauort der Standardbeladung ein Objekt dieser Klasse angelegt.
forward
global type uo_distribution_container from nonvisualobject
end type
end forward

global type uo_distribution_container from nonvisualobject
end type
global uo_distribution_container uo_distribution_container

type variables
// ---------------------------
// Zeile im dsLoadingList
// im uo_distribution
// ---------------------------
Long 			lLoadRow

String		sClass1
String		sClass2
String		sClass3
String		sClass4
String		sClass5
String		sClass6
String		sUnit
String		sPackinglist
String		sStowage
String		sText1
String		sText2
String		sText3
String		sError
String		sWorkstation
Long			lRanking
Long			lRankingSPML
Long			lBelly
Long			lLabelTypeKey
Long			lSeparate = 0
Integer		iMultiLeg	= 0

Long			lDistributionMealKey		// Key der zugeordneten Mahlzeitenverteilroutine
Long			lDistributionAddKey		// Key der zugeordneten Extra Beladungsverteilroutine
Long			lGalleyKey
Long			lStowageKey
Long			lStowageSort
Long			lLimit
Long			lLimitSPML

Long			lDistributionGroup

Integer		iClassNumber
Integer		iUse
Integer		iMCD
Integer		iMultiClass
Long	 		ii_catering_legs = 0
// --------------------------------------------------------
// Schalter "Mischbeh$$HEX1$$e400$$ENDHEX$$ltnisse zuletzt verteilen"
// --------------------------------------------------------
integer	iMixed
// --------------------------------------------------------
// Schalter SPML's kummuliert verteilen
// --------------------------------------------------------
integer	iAccummulateSPML
// --------------------------------------------------------
// H$$HEX1$$f600$$ENDHEX$$hen und Tiefen der St$$HEX1$$fc00$$ENDHEX$$ckliste
// --------------------------------------------------------
datastore dsPackinglistSize
// --------------------------------------------------------
// der Inhalt des Stauortes
// --------------------------------------------------------
datastore dsContent
// --------------------------------------------------------
// Stauortgruppe
// --------------------------------------------------------
String	sStowageGroup	= ""




end variables

forward prototypes
public function integer of_fill_absolute_old (long lrow, ref datastore dscomponents, long lspml)
public function boolean of_is_empty ()
public function integer of_fill_splitted (s_distribution_split strsplit[])
public function integer of_fill_absolute (long lrow, ref datastore dscomponents, long lspml)
public function integer of_fill_stuffed (long lrow, ref datastore dscomponents, long lspml)
public function string of_checknull (string sString)
public function long of_availability (long lrow, datastore dscomponents)
public function integer of_init ()
public function long of_availability_old (long lrow, datastore dscomponents)
public function boolean of_multi_class ()
public function boolean of_utilise (string sclassname, long lpltype, string smealcontrolcode, string sstowgroup, integer ispml)
public function boolean of_valid_group (string sstowgroup)
end prototypes

public function integer of_fill_absolute_old (long lrow, ref datastore dscomponents, long lspml);// -------------------------------------------
// Den Beh$$HEX1$$e400$$ENDHEX$$lter voll machen
// -------------------------------------------
Long		lHeight, &
			lWidth, &
			lQuantity, &
			lPlType, &
			lMaxHeight, &
			lMaxWidth, &
			lMaxQuantity, &
			lFound, &
			I, &
			lValue, &
			a
				
String	sPackingListText, &
			sPLType, &
			sText, &
			sMealControlCode, &
			sClassName
			
lHeight				= dsComponents.GetItemNumber(lRow, "nheight")
lWidth				= dsComponents.GetItemNumber(lRow, "nwidth")
lQuantity			= dsComponents.GetItemNumber(lRow, "nquantity")
lPlType				= dsComponents.GetItemNumber(lRow, "npltype_key")
sPackingListText	= dsComponents.GetItemString(lRow, "cpackinglist")
sPLType				= dsComponents.GetItemString(lRow, "sys_packinglist_types_ctext")
sText					= dsComponents.GetItemString(lRow, "cproduction_text")
sMealControlCode	= dsComponents.GetItemString(lRow, "cmeal_control_code")
sClassName 			= dsComponents.GetItemString(lRow, "cclass")

if lQuantity = 0 then return 0

// ------------------------------------------------------------------
// Nachschau, wieviel von der Sorte in das Teil rein passen
// ------------------------------------------------------------------
this.dsContent.SetFilter("npltype_key = " + string(lPlType) + " and cmeal_control_code = '" + sMealControlCode + "'") 
this.dsContent.Filter()
// ------------------------------------------------------------------
// Wenn noch nix drin ist, dann das Maximum verwenden, ansonsten
// halt entsprechend runterrechnen
// ------------------------------------------------------------------
lFound = this.dsPackingListSize.Find("npltype_key = " + string(lPlType) + " and cmeal_control_code = '" + sMealControlCode + "'", 1, this.dsPackingListSize.RowCount()) 

if lFound <= 0 then
	// nicht m$$HEX1$$f600$$ENDHEX$$glich
	this.sError = "Error: " + this.sStowage + " = Couldn't get max values for: npltype_key = " + string(lPlType) + " and cmeal_control_code = '" + sMealControlCode + "'" 
	return -1
end if

lMaxQuantity 		= this.dsPackingListSize.GetItemNumber(lFound, "nlimit")
lMaxHeight 			= this.dsPackingListSize.GetItemNumber(lFound, "nheight")
lMaxWidth  			= this.dsPackingListSize.GetItemNumber(lFound, "nwidth")

if lMaxWidth = 0 or lWidth = 0 then
	//f_print_datastore(this.dsPackingListSize)
	this.sError = "Error: " + this.sStowage + " = lMaxWidth = " + string(lMaxWidth) +  " / lWidth = " + string(lWidth) + " PLType = " + string(lPlType) + " and cmeal_control_code = '" + sMealControlCode + "'" 
	return -1
end if

//if this.dsContent.RowCount() = 0 then
	
// ------------------------------------------------------------------
// So jetzt noch den Multiplikator ermitteln, falls der Platz mit
// z.B. 2 Trays belegt werden soll
// Bsp.:
// Beh$$HEX1$$e400$$ENDHEX$$lter hat H/T 14/6000 definiert, das Tablett kommt mit 1/300
// angerauscht
// ------------------------------------------------------------------
if lMaxWidth < lWidth then
	this.sError = "ERROR: Parent width = " + string(lMaxWidth) + " Item width = " + string(lWidth)
	return -1
end if

if lMaxHeight < lHeight then
	this.sError = "ERROR: Parent height = " + string(lMaxHeight) + " Item height = " + string(lheight)
	return -1
end if

if mod(lMaxWidth, lWidth) <> 0 then
	this.sError = "ERROR DIVISION: Parent height = " + string(lMaxHeight) + " Item height = " + string(lheight)
	return -1
else
	lValue = lMaxWidth / lWidth
end if	

lMaxHeight 		= lMaxHeight * lValue 
lMaxWidth		= lMaxWidth / lValue
lMaxQuantity 	= lMaxQuantity * lValue

if lQuantity > lMaxQuantity then
	lQuantity = lMaxQuantity
end if	

if lQuantity > 0 then

	dsComponents.SetItem(lRow, "nquantity", dsComponents.GetItemNumber(lRow, "nquantity") - lQuantity)
	
	a = this.dsContent.InsertRow(0)
	this.dsContent.SetItem(a, "nspml", lSPML)
	this.dsContent.SetItem(a, "cclass", sClassName)
	this.dsContent.SetItem(a, "nquantity", lQuantity)
	this.dsContent.SetItem(a, "cpackinglist", sPackingListText)
	this.dsContent.SetItem(a, "ctext", sText)
	this.dsContent.SetItem(a, "npltype_key", lPlType)
	this.dsContent.SetItem(a, "cpl_type", sPLType)
	this.dsContent.SetItem(a, "nheight", lHeight)
	this.dsContent.SetItem(a, "nwidth", lWidth)
	
end if
	
//end if

//f_print_datastore(dsComponents)

this.dsContent.SetFilter("") 
this.dsContent.Filter()


return 0
end function

public function boolean of_is_empty ();// --------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob schon was im Beh$$HEX1$$e400$$ENDHEX$$lter drinnen ist
// 
// Sind nur SPML's drin, dann gilt der Beh$$HEX1$$e400$$ENDHEX$$lter
// trotzdem als leer
// --------------------------------------------------------
Long lRow

if this.dsContent.RowCount() = 0 then return true

For lRow = 1 to this.dsContent.RowCount()
	if this.dsContent.GetItemNumber(lRow, "nspml") = 0 then 
		//if Mid(sStowage, 1, 5) = "02-05" then f_print_datastore(this.dsContent)
		return false
	end if
Next

return true
end function

public function integer of_fill_splitted (s_distribution_split strsplit[]);// -------------------------------------------
// Den Beh$$HEX1$$e400$$ENDHEX$$lter f$$HEX1$$fc00$$ENDHEX$$llen
//
// Vorher nachschaun, ob von der Packinglist
// schon was im Container ist, wenn ja
// dann den Wert hochz$$HEX1$$e400$$ENDHEX$$hlen
// -------------------------------------------
Long 		a, &
			lFound, &
			lQuantity, &
			i
			
String 	sPackingListToFind, &
			sText, &
			sFind, &
			sMealControlCode, &
			sRemark, &
			sDebug

For I = 1 to UpperBound(strSplit)
	
	if strSplit[i].lLoadQuantity = 0 then continue
	
	sPackingListToFind 	= Trim(strSplit[i].sPackingList)
	sText 					= Trim(strSplit[i].sProductiontext)
	sMealControlCode		= Trim(strSplit[i].sMealControlCode)
	sRemark					= this.of_checknull(Trim(strSplit[i].sRemark))
	
	sFind = "cpackinglist='" + sPackingListToFind + "' and ctext='" + sText + "' and cremark ='" + sRemark + "'"
	
	// ======================================================================
	// Legs nicht mischen
	// ======================================================================
	If lseparate =1 Then
		sFind += " and cmeal_control_code='" + sMealControlCode +  "'"
	else
		sFind += " and cmeal_control_code='" + sMealControlCode +  "'"
	End If
	
	lFound = this.dsContent.Find(sFind, 1, this.dsContent.RowCount())
	
	if lFound > 0 then
		
		lQuantity = this.dsContent.GetItemNumber(lFound, "nquantity")
		this.dsContent.SetItem(lFound, "nquantity", lQuantity + strSplit[i].lLoadQuantity)
		
	else
		
		a = this.dsContent.InsertRow(0)
		this.dsContent.SetItem(a, "nspml", strSplit[i].lSPML)
		this.dsContent.SetItem(a, "cclass", strSplit[i].sClass)
		this.dsContent.SetItem(a, "nclass_number", strSplit[i].lClassNumber)
		this.dsContent.SetItem(a, "nquantity", strSplit[i].lLoadQuantity)
		this.dsContent.SetItem(a, "cpackinglist", strSplit[i].sPackinglist)
		this.dsContent.SetItem(a, "ctext", trim(strSplit[i].sProductionText))
		this.dsContent.SetItem(a, "cremark", this.of_checknull(strSplit[i].sRemark))
		this.dsContent.SetItem(a, "npltype_key", strSplit[i].lPlType)
		this.dsContent.SetItem(a, "cpl_type", strSplit[i].sPLType)
		this.dsContent.SetItem(a, "nheight", strSplit[i].lHeight)
		this.dsContent.SetItem(a, "nwidth", strSplit[i].lWidth)
		this.dsContent.SetItem(a, "cmeal_control_code", sMealControlCode)
		
	end if

Next

return 0
end function

public function integer of_fill_absolute (long lrow, ref datastore dscomponents, long lspml);// -------------------------------------------
// Den Beh$$HEX1$$e400$$ENDHEX$$lter voll machen
// -------------------------------------------
Long		lHeight, &
			lWidth, &
			lQuantity, &
			lPlType, &
			lMaxHeight, &
			lMaxWidth, &
			lMaxQuantity, &
			lFound, &
			I, &
			lValue, &
			a, &
			lMax, &
			lNumber
				
String	sPackingListText, &
			sPLType, &
			sText, &
			sMealControlCode, &
			sClassName, &
			sRemark

lHeight				= dsComponents.GetItemNumber(lRow, "nheight")
lWidth				= dsComponents.GetItemNumber(lRow, "nwidth")
lQuantity			= dsComponents.GetItemNumber(lRow, "nquantity")
lPlType				= dsComponents.GetItemNumber(lRow, "npltype_key")
sPackingListText	= dsComponents.GetItemString(lRow, "cpackinglist")
sPLType				= dsComponents.GetItemString(lRow, "sys_packinglist_types_ctext")
sRemark				= this.of_checknull(dsComponents.GetItemString(lRow, "cremark"))
sText					= dsComponents.GetItemString(lRow, "cproduction_text")
sMealControlCode	= dsComponents.GetItemString(lRow, "cmeal_control_code")
sClassName 			= dsComponents.GetItemString(lRow, "cclass")
lNumber				= dsComponents.GetItemNumber(lRow, "nclass_number")

// ---------------------------------------------
// Sind wir leer ???
// ---------------------------------------------
if not this.of_is_empty() then 
	this.sError = "of_fill_absolute: " + string(sStowage) + " is not EMPTY for " + sPackingListText
	return -1
end if

// ---------------------------------------------
// Restkapazit$$HEX1$$e400$$ENDHEX$$t ermitteln
// ---------------------------------------------
lMax = this.of_availability(lRow, dscomponents)

if lMax <= 0 then
	return -1
end if

if lMax < lQuantity then
	lQuantity = lMax
end if

if lQuantity > 0 then

	dsComponents.SetItem(lRow, "nquantity", dsComponents.GetItemNumber(lRow, "nquantity") - lQuantity)
	
	a = this.dsContent.InsertRow(0)
	this.dsContent.SetItem(a, "nspml", lSPML)
	this.dsContent.SetItem(a, "cclass", sClassName)
	this.dsContent.SetItem(a, "nclass_number", lNumber)
	this.dsContent.SetItem(a, "nquantity", lQuantity)
	this.dsContent.SetItem(a, "cpackinglist", sPackingListText)
	this.dsContent.SetItem(a, "ctext", sText)
	this.dsContent.SetItem(a, "cremark", sRemark)
	this.dsContent.SetItem(a, "npltype_key", lPlType)
	this.dsContent.SetItem(a, "cpl_type", sPLType)
	this.dsContent.SetItem(a, "nheight", lHeight)
	this.dsContent.SetItem(a, "nwidth", lWidth)
	this.dsContent.SetItem(a, "cmeal_control_code", sMealControlCode)
	
end if
	
//end if

//f_print_datastore(dsComponents)

this.dsContent.SetFilter("") 
this.dsContent.Filter()


return 0
end function

public function integer of_fill_stuffed (long lrow, ref datastore dscomponents, long lspml);// -------------------------------------------
// Den Beh$$HEX1$$e400$$ENDHEX$$lter voll machen
// -------------------------------------------
Long		lHeight, &
			lWidth, &
			lQuantity, &
			lPlType, &
			lMaxHeight, &
			lMaxWidth, &
			lMaxQuantity, &
			lFound, &
			I, &
			lValue, &
			a, &
			lMax, &
			lNumber
				
String	sPackingListText, &
			sPLType, 			&
			sText, 				&
			sMealControlCode, &
			sClassName, 		&
			sRemark
			
lHeight				= dsComponents.GetItemNumber(lRow, "nheight")
lWidth				= dsComponents.GetItemNumber(lRow, "nwidth")
lQuantity			= dsComponents.GetItemNumber(lRow, "nquantity")
lPlType				= dsComponents.GetItemNumber(lRow, "npltype_key")
sPackingListText	= dsComponents.GetItemString(lRow, "cpackinglist")
sPLType				= dsComponents.GetItemString(lRow, "sys_packinglist_types_ctext")
sText					= dsComponents.GetItemString(lRow, "cproduction_text")
sRemark				= dsComponents.GetItemString(lRow, "cremark")
sMealControlCode	= dsComponents.GetItemString(lRow, "cmeal_control_code")
sClassName 			= dsComponents.GetItemString(lRow, "cclass")
lNumber				= dsComponents.GetItemNumber(lRow, "nclass_number")

lMax = this.of_availability(lRow, dscomponents)

//if sPackingListText = "5922870" then
//	Messagebox(sStowage + "                ", "Rest: " + String(lMax) + " Menge: " + string(lQuantity))
//end if

if lMax < lQuantity then
	lQuantity = lMax
end if

if lQuantity > 0 then

	// -------------------------------------------
	// Menge reduzieren
	// -------------------------------------------
	dsComponents.SetItem(lRow, "nquantity", dsComponents.GetItemNumber(lRow, "nquantity") - lQuantity)
	
	//Messagebox(this.sStowage + "     ", sText + " = " + string(lQuantity) + "~r~rNeue Menge: " + String(dsComponents.GetItemNumber(lRow, "nquantity")))
	// -------------------------------------------
	// 
	// -------------------------------------------
	a = this.dsContent.InsertRow(0)
	this.dsContent.SetItem(a, "nspml", lSPML)
	this.dsContent.SetItem(a, "cclass", sClassName)
	this.dsContent.SetItem(a, "nclass_number", lNumber)
	this.dsContent.SetItem(a, "nquantity", lQuantity)
	this.dsContent.SetItem(a, "cpackinglist", sPackingListText)
	this.dsContent.SetItem(a, "ctext", sText)
	this.dsContent.SetItem(a, "cremark", sRemark)
	this.dsContent.SetItem(a, "npltype_key", lPlType)
	this.dsContent.SetItem(a, "cpl_type", sPLType)
	this.dsContent.SetItem(a, "nheight", lHeight)
	this.dsContent.SetItem(a, "nwidth", lWidth)
	this.dsContent.SetItem(a, "cmeal_control_code", sMealControlCode)
	
end if

this.dsContent.SetFilter("") 
this.dsContent.Filter()

return 0
end function

public function string of_checknull (string sString);if isnull(sString) then return ""
return sString
end function

public function long of_availability (long lrow, datastore dscomponents);// -------------------------------------------
//
// Ermitteln wieviel Platz noch im Beh$$HEX1$$e400$$ENDHEX$$lter
// ist 
//
// -------------------------------------------
Long		lHeight, &
			lWidth, &
			lQuantity, &
			lPlType, &
			lMaxHeight, &
			lMaxWidth, &
			lMaxQuantity, &
			lFound, &
			I, &
			lValue, &
			a, &
			lPos,&
			lRest,&
			lMinWidth, &
			lMinHeight, &
			lLimitHeight, &
			lLimitWidth, &
			lAtomRest, &
			lSPML, &
			lLoaded, &
			lCount
			
			
String	sPLType, &
			sText, &
			sMealControlCode, &
			sMealControlCode2, &
			sCode1, &
			sCode2, &
			sOut, &
			sFilter, &
			sRet, &
			ls_find

Decimal	decRest , &
			decBlocked, &
			decFinal

s_distribution_max	strMax[]

sOut = ""			

lHeight				= dsComponents.GetItemNumber(lRow, "nheight")
lWidth				= dsComponents.GetItemNumber(lRow, "nwidth")
lPlType				= dsComponents.GetItemNumber(lRow, "npltype_key")
sMealControlCode	= dsComponents.GetItemString(lRow, "cmeal_control_code")
sOut 					= dsComponents.GetItemString(lRow, "cpackinglist")

if lHeight = 0 or lWidth = 0 then
	this.sError = "Cannot handle zero: " + sOut + " Height: " + string(lHeight) + " Width: " + String(lWidth)
	return -1
end if

// MTOM020010

// ------------------------------------------------------------------
// Nachschau, wieviel von der Sorte in das Teil rein passen bzw.
// reingelassen werden d$$HEX1$$fc00$$ENDHEX$$rfen 
// ------------------------------------------------------------------
// Kein MultiLeg oder MultiLeg mit geteilten Dimensionen !!
if this.iMultiLeg = 0 or (this.iMultiLeg = 1 and this.lSeparate = 1) then
	this.dsContent.SetFilter("npltype_key = " + string(lPlType) + " and cmeal_control_code = '" + sMealControlCode + "'") 
	
else // MultiLeg OHNE geteilten Dimensionen, das Leg im Mealcode bei der  !!

	sFilter = "npltype_key = " + string(lPlType) + " and (Mid(cmeal_control_code, 2) = '" + Mid(sMealControlCode, 2) + "')"
	this.dsContent.SetFilter(sFilter) 	

end if
	
this.dsContent.Filter()

if sOut = "5563963" then
	// this.dsContent.SetFilter("") 
	// this.dsContent.Filter()
	// messagebox("", this.dsContent.Describe("datawindow.table.filter"))
	// f_print_datastore(this.dsContent)
	// f_print_datastore(dsComponents)
end if

// ------------------------------------------------------------------
// Wenn noch nix drin ist, dann das Maximum verwenden, ansonsten
// halt entsprechend runterrechnen
// ------------------------------------------------------------------
// alt lFound = this.dsPackingListSize.Find("npltype_key = " + string(lPlType) + " and cmeal_control_code = '" + sMealControlCode + "'", 1, this.dsPackingListSize.RowCount()) 
ls_find = "npltype_key = " + string(lPlType) + " and (cmeal_control_code = '" + sMealControlCode + "' or " + &
														   "cmeal_control_code2 = '" + sMealControlCode + "' or " + &
														   "cmeal_control_code3 = '" + sMealControlCode + "' or " + &
														   "cmeal_control_code4 = '" + sMealControlCode + "' or " + &
														   "cmeal_control_code5 = '" + sMealControlCode + "' or " + &
														   "cmeal_control_code6 = '" + sMealControlCode + "' or " + &
														   "cmeal_control_code7 = '" + sMealControlCode + "' or " + &
														   "cmeal_control_code8 = '" + sMealControlCode + "' or " + &
														   "cmeal_control_code9 = '" + sMealControlCode + "')"

lFound = this.dsPackingListSize.Find(ls_find, 1, this.dsPackingListSize.RowCount()) 

if lFound <= 0 then
	// nicht m$$HEX1$$f600$$ENDHEX$$glich
	this.sError = "Error: " + this.sStowage + " = Couldn't get max values for: npltype_key = " + string(lPlType) + " and cmeal_control_code = '" + sMealControlCode + "'" 
	this.dsContent.SetFilter("") 
	this.dsContent.Filter()
	return -2
end if

lSPML = dsComponents.GetItemNumber(lRow, "nspml")
if isnull(lSPML) then lSPML = 0

if lSPML = 1 and lLimitSPML > 0 then // SPML Limit vorhanden
	// ------------------------------------------------------
	// SPML's z$$HEX1$$e400$$ENDHEX$$hlen, die schon geladen sind
	// ------------------------------------------------------	
	lLoaded = 0
	For I = 1 to dsContent.RowCount()
		if dsContent.GetItemNumber(I, "nspml") = 1 then
			lLoaded += dsContent.GetItemNumber(I, "nquantity")
		end if
	Next
	
	lMaxQuantity = lLimitSPML - lLoaded
	if lMaxQuantity <= 0 then 
		this.dsContent.SetFilter("") 
		this.dsContent.Filter()
		return 0
	else
		this.dsContent.SetFilter("") 
		this.dsContent.Filter()
		return lMaxQuantity
	end if
	
elseif lSPML = 0 and lLimit > 0 then // Limit vorhanden
	// ------------------------------------------------------
	// Normal Komponenten z$$HEX1$$e400$$ENDHEX$$hlen, die schon geladen sind
	// ------------------------------------------------------
	//Messagebox("", "Stowage: " + string(sStowage) + " hat ein limit von " + string(lLimit))
	
	lLoaded = 0
	For I = 1 to dsContent.RowCount()
		if dsContent.GetItemNumber(I, "nspml") = 0 then
			lLoaded += dsContent.GetItemNumber(I, "nquantity")
		end if
	Next
	
	lMaxQuantity = lLimit - lLoaded
	
	if lMaxQuantity <= 0 then 
		this.dsContent.SetFilter("") 
		this.dsContent.Filter()
		return 0
	else
		this.dsContent.SetFilter("") 
		this.dsContent.Filter()
		return lMaxQuantity
	end if
	
else
	lMaxQuantity 		= this.dsPackingListSize.GetItemNumber(lFound, "nlimit")
end if

lMaxHeight 			= this.dsPackingListSize.GetItemNumber(lFound, "nheight")
lMaxWidth  			= this.dsPackingListSize.GetItemNumber(lFound, "nwidth")

// ------------------------------------------------------------------
// Sicherstellen, dass hier nichts reingestaut wird, dass zu gross
// oder nicht teilbar ist.
// ------------------------------------------------------------------
if lMaxWidth < lWidth then
	this.sError = "ERROR of_availability: " + sOut + " - Parent width = " + string(lMaxWidth) + " Item width = " + string(lWidth)
	this.dsContent.SetFilter("") 
	this.dsContent.Filter()
	return -3
end if

if this.sStowage = "14-12 F" then
	lCount = this.dsContent.RowCount()
end if

// ------------------------------------------------------------------
// Wenn es einen Teilungsrest beider Tiefe gibt, dann nur den 
// ganzzahligen Wert als Tiefe f$$HEX1$$fc00$$ENDHEX$$r die Komponente annehmen
//
// Beispiel: Tablett hat Tiefe 2000
// 	       Stauort hat Tiefe 3000
// 											dann hat das Tablett f$$HEX1$$fc00$$ENDHEX$$r
//												die Berechnung die Tiefe 3000
// ------------------------------------------------------------------
if Mod(lMaxWidth, lWidth) <> 0 then

	lAtomRest = Truncate(lMaxWidth / lWidth, 0)
	lMaxWidth = lAtomRest * lWidth 
	
end if

if lMaxHeight < lHeight then
	this.sError = "ERROR of_availability: " + sOut + " - Parent height = " + string(lMaxHeight) + " Item height = " + string(lheight)
	this.dsContent.SetFilter("") 
	this.dsContent.Filter()
	return -4
end if

lWidth 	= lHeight * lWidth
lHeight 	= 1

// -------------------------------------------------------
// Was darf maximal reingestaut werden ???
// -------------------------------------------------------
lLimitHeight 		= lMaxQuantity
lLimitWidth  		= lMaxWidth

// -------------------------------------------------------
// Was soll rein ???
// -------------------------------------------------------
lPos = UpperBound(strMax) + 1
strMax[lPos].lHeight 		= lHeight
strMax[lPos].lWidth  		= lWidth
strMax[lPos].lQuantity		= 0
strMax[lPos].lCalculate		= 0
// -------------------------------------------------------
// Was ist schon drin ????
// -------------------------------------------------------
For I = 1 to this.dsContent.RowCount()
	lPos = UpperBound(strMax) + 1
	strMax[lPos].lHeight 		= this.dsContent.GetItemNumber(i, "nheight")
	strMax[lPos].lWidth  		= this.dsContent.GetItemNumber(i, "nwidth")
	strMax[lPos].lQuantity		= this.dsContent.GetItemNumber(i, "nquantity")
	strMax[lPos].lCalculate		= 1
Next

// ---------------------------------------------------
// Wir normieren 
// ---------------------------------------------------
// dazu erstmal den Tiefstwert ermitteln
// ---------------------------------------------------
lMinWidth = lLimitWidth
for I = 1 to UpperBound(strMax)
	if strMax[i].lWidth < lMinWidth then lMinWidth = strMax[i].lWidth
next
// ---------------------------------------------------
// dann alles in die gleichen Einheiten umrechnen
// ---------------------------------------------------
decimal decDiv

for I = 1 to UpperBound(strMax)
	
	if mod(strMax[i].lWidth , lMinWidth) <> 0 then
		
		decDiv = strMax[i].lWidth / lMinWidth
		lAtomRest = Truncate(strMax[i].lWidth / lMinWidth, 0)
		
		strMax[i].lWidth  = lAtomRest * lMinWidth 
		strMax[i].lQuantity 	= strMax[i].lQuantity * decDiv
		strMax[i].lBlocked	= strMax[i].lQuantity * strMax[i].lHeight
		
		//this.sError = "ERROR DIVISION recalculating of_availability: " + sOut + "Parent height = " + string(lMaxHeight) + " Item height = " + string(lheight)
		//this.dsContent.SetFilter("") 
		//this.dsContent.Filter()
		//return -5
		
	else
		
		lValue 					= strMax[i].lWidth / lMinWidth
		strMax[i].lWidth 		= strMax[i].lWidth / lValue
		strMax[i].lQuantity 	= strMax[i].lQuantity * lValue
		strMax[i].lBlocked	= strMax[i].lQuantity * strMax[i].lHeight
		
	end if
			
next

// ---------------------------------------------------
// Auch das Limit muss umgerechnet werden !!!!
// ---------------------------------------------------
decDiv 					= lLimitWidth / lMinWidth
lLimitHeight 			= lLimitHeight * decDiv
lLimitWidth 			= lLimitWidth / decDiv

// ---------------------------------------------------
// Alle umgerechneten Werte zusammenaddieren und 
// die Restkapazit$$HEX1$$e400$$ENDHEX$$t ermitteln
// ---------------------------------------------------
for I = 1 to UpperBound(strMax)
	if strMax[i].lCalculate = 1 then
		sOut += string(strMax[i].lBlocked) + char(9) + string(strMax[i].lheight) + char(9) + string(strMax[i].lWidth) + char(10)
		decBlocked += strMax[i].lBlocked
	end if
next

decFinal = lLimitHeight - decBlocked

// ---------------------------------------------------
// Da die Anfrage ggf f$$HEX1$$fc00$$ENDHEX$$r eine andere H$$HEX1$$f600$$ENDHEX$$he erfolgte
// den Rest wieder in die gew$$HEX1$$fc00$$ENDHEX$$nschte Gr$$HEX2$$f600df00$$ENDHEX$$e zur$$HEX1$$fc00$$ENDHEX$$ck
// rechnen
// ---------------------------------------------------
//lValue =  Long(lMaxWidth) / lMinWidth
//lLimitHeight 		= lLimitHeight / lValue
//lLimitWidth  		= lLimitWidth * lValue
decRest = Dec(lWidth / lMinWidth)
decRest  = Truncate(decFinal / decRest, 0)

this.dsContent.SetFilter("") 
this.dsContent.Filter()
return long(decRest)
end function

public function integer of_init ();Long lRow


//this.dsPackinglistSize.Modify("t_message.text='# [" + string(this.lLoadRow) + "] Stowage: " + of_checknull(sStowage) + " - Class: " + of_checknull(this.sClass1) + of_checknull(this.sClass2) + of_checknull(this.sClass3) + " - " + of_checknull(this.sPackinglist) + "'")
this.dsPackinglistSize.Modify("t_message.text='# [" + string(this.lLoadRow) + "] Stowage: " + of_checknull(sStowage) + " - Class: " + &
				of_checknull(this.sClass1) + of_checknull(this.sClass2) + of_checknull(this.sClass3) + of_checknull(this.sClass4)+ of_checknull(this.sClass5)+ of_checknull(this.sClass6) +&
				" - " + of_checknull(this.sPackinglist) + "'")

//this.dsContent.Modify("t_message.text='# [" + string(this.lLoadRow) + "] Stowage: " + of_checknull(sStowage) + " - Class: " + of_checknull(this.sClass1) + of_checknull(this.sClass2) + of_checknull(this.sClass3) + " - " + of_checknull(this.sPackinglist) + "'")
this.dsContent.Modify("t_message.text='# [" + string(this.lLoadRow) + "] Stowage: " + of_checknull(sStowage) + " - Class: " + of_checknull(this.sClass1) + &
of_checknull(this.sClass2) + of_checknull(this.sClass3) + of_checknull(this.sClass4) + of_checknull(this.sClass5) + of_checknull(this.sClass6)+ " - " + of_checknull(this.sPackinglist) + "'")

// ---------------------------------------------------
// Die Limit's vorbelegen, wenn keines vorhanden ist
// ---------------------------------------------------
For lRow = 1 to this.dsPackinglistSize.RowCount()
	
	if isnull(this.dsPackinglistSize.GetItemNumber(lRow, "nlimit")) or &
		this.dsPackinglistSize.GetItemNumber(lRow, "nlimit") = 0 then 
		
		this.dsPackinglistSize.SetItem(lRow, "nlimit", this.dsPackinglistSize.GetItemNumber(lRow, "compute_quantity"))
		
	end if 
	
	if isnull(this.dsPackinglistSize.GetItemNumber(lRow, "nlimit_spml")) or &
		this.dsPackinglistSize.GetItemNumber(lRow, "nlimit_spml") = 0 then 
		
		this.dsPackinglistSize.SetItem(lRow, "nlimit_spml", this.dsPackinglistSize.GetItemNumber(lRow, "compute_quantity"))
		
	end if 
	
Next

// ---------------------------------------------------
// Wenn mehr als eine Klasse zugewiesen ist, dann
// ein Flag daf$$HEX1$$fc00$$ENDHEX$$r setzen ..................
// ---------------------------------------------------
//if this.sClass1 <> "" and (this.sClass2 <> "" or this.sClass3 <> "") then
if this.sClass1 <> "" and (this.sClass2 <> "" or this.sClass3 <> "" or this.sClass4 <> "" or this.sClass5 <> "" or this.sClass6 <> "") then
	this.iMultiClass = 1
else
	this.iMultiClass = 0
end if
	


return 0
end function

public function long of_availability_old (long lrow, datastore dscomponents);// -------------------------------------------
//
// Ermitteln wieviel Platz noch im Beh$$HEX1$$e400$$ENDHEX$$lter
// ist 
//
// -------------------------------------------
Long		lHeight, &
			lWidth, &
			lQuantity, &
			lPlType, &
			lMaxHeight, &
			lMaxWidth, &
			lMaxQuantity, &
			lFound, &
			I, &
			lValue, &
			a, &
			lPos,&
			lRest,&
			lMinWidth, &
			lMinHeight, &
			lLimitHeight, &
			lLimitWidth, &
			lBlocked, &
			lAtomRest, &
			lSPML, &
			lLoaded, &
			lCount
			
			
String	sPLType, &
			sText, &
			sMealControlCode, &
			sOut

Decimal	decRest 

s_distribution_max	strMax[]

sOut = ""			

lHeight				= dsComponents.GetItemNumber(lRow, "nheight")
lWidth				= dsComponents.GetItemNumber(lRow, "nwidth")
lPlType				= dsComponents.GetItemNumber(lRow, "npltype_key")
sMealControlCode	= dsComponents.GetItemString(lRow, "cmeal_control_code")
sOut 					= dsComponents.GetItemString(lRow, "cpackinglist")

if lHeight = 0 or lWidth = 0 then
	this.sError = "Cannot handle zero: " + sOut + " Height: " + string(lHeight) + " Width: " + String(lWidth)
	return -1
end if

// ------------------------------------------------------------------
// Nachschau, wieviel von der Sorte in das Teil rein passen bzw.
// reingelassen werden d$$HEX1$$fc00$$ENDHEX$$rfen 
// ------------------------------------------------------------------
this.dsContent.SetFilter("npltype_key = " + string(lPlType) + " and cmeal_control_code = '" + sMealControlCode + "'") 
this.dsContent.Filter()

if this.sStowage = "14-12 F" then
	lCount = this.dsContent.RowCount()
end if

// ------------------------------------------------------------------
// Wenn noch nix drin ist, dann das Maximum verwenden, ansonsten
// halt entsprechend runterrechnen
// ------------------------------------------------------------------
// alt lFound = this.dsPackingListSize.Find("npltype_key = " + string(lPlType) + " and cmeal_control_code = '" + sMealControlCode + "'", 1, this.dsPackingListSize.RowCount()) 
lFound = this.dsPackingListSize.Find("npltype_key = " + string(lPlType) + " and (cmeal_control_code = '" + sMealControlCode + "' or cmeal_control_code2 = '" + sMealControlCode + "')", 1, this.dsPackingListSize.RowCount()) 

if lFound <= 0 then
	// nicht m$$HEX1$$f600$$ENDHEX$$glich
	this.sError = "Error: " + this.sStowage + " = Couldn't get max values for: npltype_key = " + string(lPlType) + " and cmeal_control_code = '" + sMealControlCode + "'" 
	this.dsContent.SetFilter("") 
	this.dsContent.Filter()
	return -2
end if

lSPML = dsComponents.GetItemNumber(lRow, "nspml")
if isnull(lSPML) then lSPML = 0

if lSPML = 1 and lLimitSPML > 0 then // SPML Limit vorhanden
	// ------------------------------------------------------
	// SPML's z$$HEX1$$e400$$ENDHEX$$hlen, die schon geladen sind
	// ------------------------------------------------------	
	lLoaded = 0
	For I = 1 to dsContent.RowCount()
		if dsContent.GetItemNumber(I, "nspml") = 1 then
			lLoaded += dsContent.GetItemNumber(I, "nquantity")
		end if
	Next
	
	lMaxQuantity = lLimitSPML - lLoaded
	if lMaxQuantity <= 0 then 
		return 0
	else
		return lMaxQuantity
	end if
	
elseif lSPML = 0 and lLimit > 0 then // Limit vorhanden
	// ------------------------------------------------------
	// Normal Komponenten z$$HEX1$$e400$$ENDHEX$$hlen, die schon geladen sind
	// ------------------------------------------------------
	//Messagebox("", "Stowage: " + string(sStowage) + " hat ein limit von " + string(lLimit))
	
	lLoaded = 0
	For I = 1 to dsContent.RowCount()
		if dsContent.GetItemNumber(I, "nspml") = 0 then
			lLoaded += dsContent.GetItemNumber(I, "nquantity")
		end if
	Next
	
	lMaxQuantity = lLimit - lLoaded
	
	if lMaxQuantity <= 0 then 
		return 0
	else
		return lMaxQuantity
	end if
	
else
	lMaxQuantity 		= this.dsPackingListSize.GetItemNumber(lFound, "nlimit")
end if

lMaxHeight 			= this.dsPackingListSize.GetItemNumber(lFound, "nheight")
lMaxWidth  			= this.dsPackingListSize.GetItemNumber(lFound, "nwidth")

// ------------------------------------------------------------------
// Sicherstellen, dass hier nichts reingestaut wird, dass zu gross
// oder nicht teilbar ist.
// ------------------------------------------------------------------
if lMaxWidth < lWidth then
	this.sError = "ERROR of_availability: " + sOut + " - Parent width = " + string(lMaxWidth) + " Item width = " + string(lWidth)
	this.dsContent.SetFilter("") 
	this.dsContent.Filter()
	return -3
end if

// ------------------------------------------------------------------
// Wenn es einen Teilungsrest beider Tiefe gibt, dann nur den 
// ganzzahligen Wert als Tiefe f$$HEX1$$fc00$$ENDHEX$$r die Komponente annehmen
//
// Beispiel: Tablett hat Tiefe 2000
// 	       Stauort hat Tiefe 3000
// 											dann hat das Tablett f$$HEX1$$fc00$$ENDHEX$$r
//												die Berechnung die Tiefe 3000
// ------------------------------------------------------------------
if Mod(lMaxWidth, lWidth) <> 0 then

	lAtomRest = Truncate(lMaxWidth / lWidth, 0)
	lMaxWidth = lAtomRest * lWidth 
	
end if

if lMaxHeight < lHeight then
	this.sError = "ERROR of_availability: " + sOut + " - Parent height = " + string(lMaxHeight) + " Item height = " + string(lheight)
	this.dsContent.SetFilter("") 
	this.dsContent.Filter()
	return -4
end if

lWidth 	= lHeight * lWidth
lHeight 	= 1

// -------------------------------------------------------
// Was darf maximal reingestaut werden ???
// -------------------------------------------------------
lLimitHeight 		= lMaxQuantity
lLimitWidth  		= lMaxWidth

// -------------------------------------------------------
// Was soll rein ???
// -------------------------------------------------------
lPos = UpperBound(strMax) + 1
strMax[lPos].lHeight 		= lHeight
strMax[lPos].lWidth  		= lWidth
strMax[lPos].lQuantity		= 0
strMax[lPos].lCalculate		= 0
// -------------------------------------------------------
// Was ist schon drin ????
// -------------------------------------------------------
For I = 1 to this.dsContent.RowCount()
	lPos = UpperBound(strMax) + 1
	strMax[lPos].lHeight 		= this.dsContent.GetItemNumber(i, "nheight")
	strMax[lPos].lWidth  		= this.dsContent.GetItemNumber(i, "nwidth")
	strMax[lPos].lQuantity		= this.dsContent.GetItemNumber(i, "nquantity")
	strMax[lPos].lCalculate		= 1
Next

// ---------------------------------------------------
// Wir normieren 
// ---------------------------------------------------
// dazu erstmal den Tiefstwert ermitteln
// ---------------------------------------------------
lMinWidth = lLimitWidth
for I = 1 to UpperBound(strMax)
	if strMax[i].lWidth < lMinWidth then lMinWidth = strMax[i].lWidth
next
// ---------------------------------------------------
// dann alles in die gleichen Einheiten umrechnen
// ---------------------------------------------------
for I = 1 to UpperBound(strMax)
	
	if mod(strMax[i].lWidth , lMinWidth) <> 0 then
		
		lAtomRest = Truncate(strMax[i].lWidth / lMinWidth, 0)
		strMax[i].lWidth  = lAtomRest * lMinWidth 
		
		//this.sError = "ERROR DIVISION recalculating of_availability: " + sOut + "Parent height = " + string(lMaxHeight) + " Item height = " + string(lheight)
		//this.dsContent.SetFilter("") 
		//this.dsContent.Filter()
		//return -5
		
	end if
	
	lValue 					= strMax[i].lWidth / lMinWidth
	strMax[i].lWidth 		= strMax[i].lWidth / lValue
	strMax[i].lQuantity 	= strMax[i].lQuantity * lValue
	strMax[i].lBlocked	= strMax[i].lQuantity * strMax[i].lHeight
		
next

// ---------------------------------------------------
// Auch das Limit muss umgerechnet werden !!!!
// ---------------------------------------------------
lValue 					= lLimitWidth / lMinWidth
lLimitHeight 			= lLimitHeight * lValue
lLimitWidth 			= lLimitWidth / lValue
// ---------------------------------------------------
// Alle umgerechneten Werte zusammenaddieren und 
// die Restkapazit$$HEX1$$e400$$ENDHEX$$t ermitteln
// ---------------------------------------------------
for I = 1 to UpperBound(strMax)
	if strMax[i].lCalculate = 1 then
		sOut += string(strMax[i].lBlocked) + char(9) + string(strMax[i].lheight) + char(9) + string(strMax[i].lWidth) + char(10)
		lBlocked += strMax[i].lBlocked
	end if
next

lRest = lLimitHeight - lBlocked

// ---------------------------------------------------
// Da die Anfrage ggf f$$HEX1$$fc00$$ENDHEX$$r eine andere H$$HEX1$$f600$$ENDHEX$$he erfolgte
// den Rest wieder in die gew$$HEX1$$fc00$$ENDHEX$$nschte Gr$$HEX2$$f600df00$$ENDHEX$$e zur$$HEX1$$fc00$$ENDHEX$$ck
// rechnen
// ---------------------------------------------------
lValue =  Long(lMaxWidth) / lMinWidth
lLimitHeight 		= lLimitHeight / lValue
lLimitWidth  		= lLimitWidth * lValue
decRest = Dec(lWidth / lMinWidth)
decRest  = Truncate(Dec(lRest) / decRest, 0)

this.dsContent.SetFilter("") 
this.dsContent.Filter()
return long(decRest)
end function

public function boolean of_multi_class ();// --------------------------------------------------
// 08.05.2006
// Wenn es ein Mehrklassenbeh$$HEX1$$e400$$ENDHEX$$ltnis ist, dann 
// wollen wir den Stautort nicht!!
// --------------------------------------------------
// iMixed ist der Schalter aus der Verteilerroutine
// 
// iMultiClass - wird bei Mehrklassigkeit in of_init
//               gesetzt
// --------------------------------------------------
if this.iMixed = 1 and this.iMultiClass = 1 then
	// Messagebox("", this.sStowage)
	return false
end if 	

return true
end function

public function boolean of_utilise (string sclassname, long lpltype, string smealcontrolcode, string sstowgroup, integer ispml);// --------------------------------------------------
//
// Ist die Komponente und der Stauort kompatibel?
//
// --------------------------------------------------
Long lFound
boolean bEmpty
string ls_find
// --------------------------------------------------
// Wenn die Stauortgruppe nicht passt, dann 
// gleich wieder retour. * wird von der Funktion
// of_distribution_errorlist $$HEX1$$fc00$$ENDHEX$$bergegen, um die
// Stauortgruppen auszuhebeln
// --------------------------------------------------
if sStowGroup <> "*" then
	if sStowGroup <> this.sStowageGroup then
		return false
	end if
end if

// --------------------------------------------------
// Wenn die Klasse nicht passt, dann gleich wieder
//	zur$$HEX1$$fc00$$ENDHEX$$ck (nur bei nicht MCD Verteilung)
// --------------------------------------------------
if sClassName <> this.sClass1 and &
   sClassName <> this.sClass2 and & 
   sClassName <> this.sClass3 and & 
   sClassName <> this.sClass4 and & 
   sClassName <> this.sClass5 and & 
	sClassName <> this.sClass6 and this.iMCD = 0 then 
	
	//Messagebox("", "Stauort:" + this.sClass1 + "/" + this.sClass2 + "/" + this.sClass3 + "~rKomponente: " + sClassName)
	return false
	
end if

// --------------------------------------------------
// St$$HEX1$$fc00$$ENDHEX$$cklistentype und Verteilerschl$$HEX1$$fc00$$ENDHEX$$ssel suchen
// --------------------------------------------------
ls_find = "npltype_key=" + string(lPLType) + &
   			" and (cmeal_control_code = '" + sMealControlCode + "' or " + &
				    "cmeal_control_code2 = '" + sMealControlCode + "' or " + &
				    "cmeal_control_code3 = '" + sMealControlCode + "' or " + &
				    "cmeal_control_code4 = '" + sMealControlCode + "' or " + &
				    "cmeal_control_code5 = '" + sMealControlCode + "' or " + &
				    "cmeal_control_code6 = '" + sMealControlCode +"' or " + &
				    "cmeal_control_code7 = '" + sMealControlCode + "' or " + &
				    "cmeal_control_code8 = '" + sMealControlCode + "' or " + &
				    "cmeal_control_code9 = '" + sMealControlCode +"') "

if this.dsPackinglistSize.Find(ls_find, 1, this.dsPackinglistSize.RowCount()) = 0 then
	
	return false
	
end if

return true
end function

public function boolean of_valid_group (string sstowgroup);// --------------------------------------------------
//
// Stimmt die Stauortgruppe?
//
// --------------------------------------------------
Long lFound
boolean bEmpty

if sStowGroup <> "*" then
	if sStowGroup <> this.sStowageGroup then
		return false
	end if
end if

return true
end function

on uo_distribution_container.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_distribution_container.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;dsPackinglistSize = create DataStore
dsPackinglistSize.dataobject = "dw_uo_packinglist_size"


dsContent = create datastore
dsContent.dataobject = "dw_uo_content"


end event

event destructor;Destroy(dsPackinglistSize)
Destroy(dsContent)


end event

