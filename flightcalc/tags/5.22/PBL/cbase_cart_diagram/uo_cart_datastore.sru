HA$PBExportHeader$uo_cart_datastore.sru
$PBExportComments$Datastore mit Protokollfunktionen
forward
global type uo_cart_datastore from datastore
end type
end forward

global type uo_cart_datastore from datastore
end type
global uo_cart_datastore uo_cart_datastore

type variables
// --------------------------
// Logging
// --------------------------
protected string	is_LogFile, isIPAdress

datastore dsObjects

Integer iDebug = 0


end variables

forward prototypes
public function integer of_get_objects ()
public function long of_log (string smessage)
public subroutine of_set_log_file (string as_file)
end prototypes

public function integer of_get_objects ();//----------------------------------------------------
// Alle Objecte im DW analysieren
//----------------------------------------------------

long	 	i, &
			j, &
			iCount, &
			iPos, &
			iY
			
			
string 	sDWObjects, &
			sTemp, &
			sObjects[], &
			sValidObjects[], &
			sBand, &
			sSyntax, &
			sObject, &
			sType, &
			sColType, &
			lTaborder, &
			sTag

long 		lInsert, &
			lHeight

// ---------------------------------------
// Alle Objekte auslesen
// ---------------------------------------
 sDWObjects = this.describe("datawindow.objects")

// ---------------------------------------
// Den String zerhacken und alle Objekte
// ein Array schreiben
// ---------------------------------------

for i = 1 to len(sDWObjects)
	
	if Mid(sDWObjects, i, 1) <> char(9) then
		sTemp += Mid(sDWObjects, i, 1)
	else
				
		iCount ++
		sObjects[iCount] = sTemp
		sTemp = ""
		
	end if

next

if len(sTemp) > 0 then		
	iCount ++
	sObjects[iCount] = sTemp
end if

// ---------------------------------------
// Nun Pr$$HEX1$$fc00$$ENDHEX$$fen, ob die Objekte sichtbar
// im Detailband sind
// ---------------------------------------
for i = 1 to UpperBound(sObjects)
	
	sBand = this.Describe(sObjects[i] + ".band")
	sType = this.Describe(sObjects[i] + ".type")

	if sBand = "detail" and sType = "column" then
		
		lInsert = dsObjects.InsertRow(0)
		dsObjects.SetItem(lInsert, "scolumn", this.Describe(sObjects[i] + ".name"))
		
		sColType = UPPER(this.Describe(sObjects[i] + ".Coltype"))
		
		if mid(sColType, 1, 4) = "CHAR" then
			sColType = "CHAR"
		elseif mid(sColType, 1, 7) = "DECIMAL" then
			sColType = "DECIMAL"			
		end if
		
		dsObjects.SetItem(lInsert, "sdatatype", sColType)
		
	end if
		
Next

dsObjects.Sort()

return 0

end function

public function long of_log (string smessage);//----------------------------------------------------
// 
// Logging
//
//----------------------------------------------------
integer iFile
string  sPrefix

if isNull(this.isIPAdress) then this.isIPAdress = ""

sPrefix = "[" + this.isIPAdress + "] " + String(today(), "dd.mm") + " " + string(now(), "hh:mm:ss") + " [DATASTORE] [" + this.dataobject + "]: "

if isnull(this.is_LogFile) or this.is_LogFile = "" then
	return -1 
end if

iFile = FileOpen( this.is_LogFile, LineMode!, Write!, Shared!)
FileWrite(iFile,  sPrefix + sMessage)
FileClose(iFile)

return 0
end function

public subroutine of_set_log_file (string as_file);is_LogFile = as_File
end subroutine

event dberror;String 	sOut, sError, sValue, sColumn, sDataType, sTemp
Integer 	iPos 
Long 		lColumns

 
iPos = Pos(sqlerrtext, char(10))

if iPos > 0 then
	sError = Mid(sqlerrtext, 1, iPos - 1)
else
	sError = sqlerrtext
end if

sOut = "DB-Error: " + string(sqldbcode) + " DB-ErrorText: " + string(sError) 
of_log(sOut)




// --------------------------------------------------------------------
// Werte der Row, in der der Fehler entstanden ist, wegschreiben
// --------------------------------------------------------------------
of_get_objects()
sTemp = space(50)

of_log("--------------------------------------------------------------------")		

if row > 0 then

	for lColumns = 1 to dsObjects.RowCount()
		
		 sColumn 	= dsObjects.GetItemString(lColumns, "scolumn") 	
		 sDataType 	= dsObjects.GetItemString(lColumns, "sdatatype") 	
		 sValue     = ""
			 
		 choose case UPPER(sDataType)
			case "DATE"
				sValue = String(this.GetItemDate(row, sColumn))
				
			case "DATETIME"
				sValue = String(this.GetItemDateTime(row, sColumn))
				
			case "TIME"
				sValue = String(this.GetItemTime(row, sColumn))
				
			case "DECIMAL"
				sValue = String(this.GetItemDecimal(row, sColumn))
				
			case "INT", "LONG", "NUMBER", "REAL", "ULONG"
				sValue = String(this.GetItemNumber(row, sColumn))
				
			case "CHAR"
				sValue = String(this.GetItemString(row, sColumn))
							
		end choose	
				
		of_log(Right(sTemp + sColumn, 30) + ": " + sValue)		
		
	Next
	
end if

of_log("--------------------------------------------------------------------")		

return 0
end event

on uo_cart_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cart_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;dsObjects = create datastore
dsObjects.dataobject = "dw_uo_dwobjects"

this.is_LogFile = f_gettemppath() + "CBASE-Datastore.log"
this.of_get_objects()
end event

event destructor;destroy(dsObjects)
end event

event sqlpreview;//Messagebox("", sqlsyntax)

if iDebug = 1 then
	this.of_log(sqlsyntax)
	this.of_log("-----------------------------------------------------------------")
end if

//Messagebox(this.dataobject + "        ", sqlsyntax)
end event

