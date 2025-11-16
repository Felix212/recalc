HA$PBExportHeader$uo_cbase_datastore.sru
$PBExportComments$Datastore mit Protokollfunktionen
forward
global type uo_cbase_datastore from datastore
end type
end forward

global type uo_cbase_datastore from datastore
end type
global uo_cbase_datastore uo_cbase_datastore

type variables

// --------------------------
// Logging
// --------------------------
string	is_LogFile, sIPAdress

datastore dsObjects


/* 
* object: 			uo_cbase_datastore
* Beschreibung: 	basis-object f$$HEX1$$fc00$$ENDHEX$$r datastores
* 						erm$$HEX1$$f600$$ENDHEX$$glicht das umfangreiche tracen speziell der datenbankzugriffe
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		12.06.2009		den hier beschriebenen bereich erg$$HEX1$$e400$$ENDHEX$$nzt
*
*
* das objekt kennt den schalter ibTrace ($$HEX1$$e400$$ENDHEX$$hnlich bDebug in s_application: trace ein/aus),
* den wert ilTracelevel (analog zu iTrace in s_application: alles, was kleiner als dieser wert ist, wird protokolliert),
* und den string isTracefile (analog zu sTracefile in s_application: das file, in das geschrieben werden soll)
* 
* Tracelevel wird derzeit nur $$HEX1$$fc00$$ENDHEX$$bernommen, aber nicht ausgewertet 
* 
*/



protected:

// soll trace-file geschrieben werden ? hier nur defaults, kann $$HEX1$$fc00$$ENDHEX$$ber init_trace von aussen gesetzt werden
Boolean	ibTrace = FALSE
String 	isTraceFile = "C:\Temp\CbaseTrace-" + String(Today(), "yyyy-mm-dd") + ".log"
Long 		ilTracelevel = 100

// damit der aktuelle name des objects, welches die ausgabe generiert, mit ausgegeben werden kann
// muss im open gesetzt werden
String 	isObjectname = "<obj>"

// Error-Informationen, werden im DB-Error gef$$HEX1$$fc00$$ENDHEX$$llt und k$$HEX1$$f600$$ENDHEX$$nnen per of_return_dberror abgeholt werden
Long 	il_SQLDBCode = 0
Long 	il_ErrorRow = 0
String is_SQLErrText = ""
String is_SQLSyntax = ""
dwBuffer 	idwb_Errorbuffer = Primary!


end variables

forward prototypes
public function integer of_get_objects ()
public function integer of_log (string smessage)
public function boolean of_set_displayformat_reports (boolean arg_boverride)
public function boolean of_set_displayformat_reports ()
protected function long of_log2file (string asmessage)
public function long of_init_trace (boolean abtrace, string astracefile, long altracelevel)
public function long of_init_trace (boolean abtrace, string astracefile)
public function boolean of_return_dberror (ref long al_sqldbcode, ref string as_sqlerrtext, ref string as_sqlsyntax, ref dwbuffer adwb_errorbuffer, ref long al_errorrow)
public function boolean of_return_dberror (ref long al_sqldbcode)
public function boolean of_return_dberror (ref long al_sqldbcode, ref long al_errorrow)
public function boolean of_return_dberror (ref long al_sqldbcode, ref string as_sqlerrtext, ref long al_errorrow)
end prototypes

public function integer of_get_objects ();
// ----------------------------------------------------
// Alle Objecte im DW analysieren
// ----------------------------------------------------

integer 	i, &
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
// Zieldatastore initialisieren
// ---------------------------------------
dsObjects.Reset()

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

public function integer of_log (string smessage);guolog.uf_allways("[DATASTORE] [" + this.dataobject + "]: " + sMessage)

return 0
end function

public function boolean of_set_displayformat_reports (boolean arg_boverride);
/* 
* Function: 			of_set_displayformat_reports
* Beschreibung: 	formatieren der felder f$$HEX1$$fc00$$ENDHEX$$r reports
* Besonderheit: 	
*
* Argumente:
* 	arg_bOverride	Schalter, ob vorhandene Formate $$HEX1$$fc00$$ENDHEX$$berschrieben werden sollen
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		04.08.2008		Erstellung
*
* Return Codes:
* 	TRUE 
*/


// hilfsvariable
Long 	llColumn
Long 	llNumberOfColumns
String 	lsColumnType, lsDataType, lsTag
String 	lsFormat

// wieviele columns gibt es ?
llNumberOfColumns = long(this.Object.DataWindow.Column.Count)
	
// -------------------------------
// Schleife $$HEX1$$fc00$$ENDHEX$$ber alle columns
// -------------------------------
for llColumn = 1 to llNumberOfColumns
	// wir betrachten nur columns, die eine width haben:
	if integer(this.Describe("#" + string(llColumn) + ".Width")) > 0 then
	
		// was f$$HEX1$$fc00$$ENDHEX$$r eine column haben wir hier ?
		lsColumnType = this.describe("#" + string(llColumn) + ".Edit.Style")
		lsDataType 	= lower(this.Describe ("#" + string(llColumn) + ".ColType"))
		lsTag			= lower(this.Describe ("#" + string(llColumn) + ".Tag"))
		
		// -------------------------------------------
		// datum, aber nicht "timestamp" im tag: formatieren
		// -------------------------------------------
		if Match (lsDataType, "date") and lsTag <> "timestamp" then
			this.Modify("#" + string(llColumn) + ".Edit.Format='" + s_app.sDateformat   + "'")
			this.Modify("#" + string(llColumn) + ".Format='" + s_app.sDateformat   + "'")
		end if

		// -------------------------------------------
		// decimal und nicht editmask: formatieren
		// erstmal nur bis zu 5 stellen
		// -------------------------------------------
		if lsColumnType <> "editmask" then
			lsFormat = this.Describe("#" + string(llColumn) + ".Format")
			if lsFormat = "[general]" or arg_bOverride then
			
				if Match (lsDataType, "decimal(1)") then
					this.Modify("#" + string(llColumn) + ".Format='#,###,##0.0'")
					this.Modify("#" + string(llColumn) + ".edit.format='#,###,##0.0'")
				end if
				if Match (lsDataType, "decimal(2)") then
					this.Modify("#" + string(llColumn) + ".Format='#,###,##0.00'")
					this.Modify("#" + string(llColumn) + ".edit.format='#,###,##0.00'")
				end if
				if Match (lsDataType, "decimal(3)") then
					this.Modify("#" + string(llColumn) + ".Format='#,###,##0.000'")
					this.Modify("#" + string(llColumn) + ".edit.format='#,###,##0.000'")
				end if
				if Match (lsDataType, "decimal(4)") then
					this.Modify("#" + string(llColumn) + ".Format='#,###,##0.0000'")
					this.Modify("#" + string(llColumn) + ".edit.format='#,###,##0.0000'")
				end if
				if Match (lsDataType, "decimal(5)") then
					this.Modify("#" + string(llColumn) + ".Format='#,###,##0.00000'")
					this.Modify("#" + string(llColumn) + ".edit.format='#,###,##0.00000'")
				end if
				
			end if
		end if
			
	end if	// end column hat width > 0
next

	
return true

end function

public function boolean of_set_displayformat_reports ();
/* 
* Function: 			of_set_displayformat_reports
* Beschreibung: 	formatieren der felder f$$HEX1$$fc00$$ENDHEX$$r reports
* Besonderheit: 	es wird true f$$HEX1$$fc00$$ENDHEX$$r override angenommen und weitergeleitet
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		04.07.2008		Erstellung
*
* Return Codes:
* 	TRUE (aus gerufener routine)
*/

return of_set_displayformat_reports(TRUE)

end function

protected function long of_log2file (string asmessage);
/* 
* Function: 			of_log2file
* Beschreibung: 	schreibt trace in datei
* Besonderheit: 	PROTECTED, nur zum internen gebrauch
*
* Argumente:
*	asMessage		Text, der weggeschrieben werden soll
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		09.06.2009		Erstellung
*
* Return Codes:
*	 0		immer
*/


guolog.uf_allways("[DATASTORE] [" + this.dataobject + "]: " + asMessage)
return 0

end function

public function long of_init_trace (boolean abtrace, string astracefile, long altracelevel);
/* 
* Function: 			of_init_trace
* Beschreibung: 	initialisiert trace-schalter und trace-file
* Besonderheit: 	
*
* Argumente:
*	abTrace			schalter, ob getraced werden soll ( = bDebug in s_app)
*	asTraceFile		name des tracefiles ( = bTracefile in s_app)
*	alTraceLevel	
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		12.06.2008		Erstellung
*
* Return Codes:
*	 0		immer
*/

// hilfsvariable
integer 	liFile

// null-values und leerstrings wollen wir hier nicht
if IsNull(asTraceFile) or trim(asTraceFile) = "" then asTraceFile = "C:\Temp\CbaseTrace-" + String(Today(), "yyyy-mm-dd") + ".log"
if IsNull(alTracelevel) then alTracelevel = 100

// daten $$HEX1$$fc00$$ENDHEX$$bernehmen
ibTrace = abTrace
isTraceFile = asTraceFile
ilTracelevel = alTracelevel

// daten testen
if ibTrace then
	liFile = FileOpen(isTraceFile, LineMode!, Write!, LockWrite!, Append!)
	if IsNull(liFile) or liFile < 0 then 
		isTraceFile = "C:\Temp\CbaseTrace-" + String(Today(), "yyyy-mm-dd") + ".log"
	else
		FileClose(liFile)
	end if
end if

return 0

end function

public function long of_init_trace (boolean abtrace, string astracefile);
/* 
* Function: 			of_init_trace
* Beschreibung: 	initialisiert trace-schalter und trace-file
* Besonderheit: 	Tracelevel 100 wird unterstellt und das ding wird weitergeleitet
*
* Argumente:
*	abTrace			schalter, ob getraced werden soll ( = bDebug in s_app)
*	asTraceFile		name des tracefiles ( = bTracefile in s_app)
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		12.06.2008		Erstellung
*
* Return Codes:
* 	aus der original-routine 
*/

return this.of_init_trace(abTrace, asTraceFile, 100)

end function

public function boolean of_return_dberror (ref long al_sqldbcode, ref string as_sqlerrtext, ref string as_sqlsyntax, ref dwbuffer adwb_errorbuffer, ref long al_errorrow);
/* 
* Function: 			of_return_dberror
* Beschreibung: 	gibt werte aus dberror-variablen zur$$HEX1$$fc00$$ENDHEX$$ck
* Besonderheit: 	
*
* Argumente:
*	al_SQLDBCode		der sqlcode aus der datenbank
*	as_SQLErrText		der sqlerrortext aus der datenbank
*	as_SQLSyntax		die syntax des sql-statements, welches den fehler verursacht hat
*	adwb_Errorbuffer	der buffer der zeile, welche den fehler verursacht hat
*	al_ErrorRow			die zeile, welche  den fehler verursacht hat
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		06.02.2012		Erstellung
*
* Return Codes:
* 	true 	immer 
*/

al_SQLDBCode = this.il_SQLDBCode
as_SQLErrText = this.is_SQLErrText
as_SQLSyntax = this.is_SQLSyntax
adwb_Errorbuffer = this.idwb_Errorbuffer
al_ErrorRow = this.il_ErrorRow

return true

end function

public function boolean of_return_dberror (ref long al_sqldbcode);
/* 
* Function: 			of_return_dberror
* Beschreibung: 	gibt werte aus dberror-variablen zur$$HEX1$$fc00$$ENDHEX$$ck
* Besonderheit: 	
*
* Argumente:
*	al_SQLDBCode		der sqlcode aus der datenbank
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		06.02.2012		Erstellung
*
* Return Codes:
* 	true 	immer 
*/

al_SQLDBCode = this.il_SQLDBCode

return true

end function

public function boolean of_return_dberror (ref long al_sqldbcode, ref long al_errorrow);
/* 
* Function: 			of_return_dberror
* Beschreibung: 	gibt werte aus dberror-variablen zur$$HEX1$$fc00$$ENDHEX$$ck
* Besonderheit: 	
*
* Argumente:
*	al_SQLDBCode		der sqlcode aus der datenbank
*	al_ErrorRow			die zeile, welche  den fehler verursacht hat
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		06.02.2012		Erstellung
*
* Return Codes:
* 	true 	immer 
*/

al_SQLDBCode = this.il_SQLDBCode
al_ErrorRow = this.il_ErrorRow

return true

end function

public function boolean of_return_dberror (ref long al_sqldbcode, ref string as_sqlerrtext, ref long al_errorrow);
/* 
* Function: 			of_return_dberror
* Beschreibung: 	gibt werte aus dberror-variablen zur$$HEX1$$fc00$$ENDHEX$$ck
* Besonderheit: 	
*
* Argumente:
*	al_SQLDBCode		der sqlcode aus der datenbank
*	as_SQLErrText		der sqlerrortext aus der datenbank
*	al_ErrorRow			die zeile, welche  den fehler verursacht hat
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		06.02.2012		Erstellung
*
* Return Codes:
* 	true 	immer 
*/

al_SQLDBCode = this.il_SQLDBCode
as_SQLErrText = this.is_SQLErrText
al_ErrorRow = this.il_ErrorRow

return true

end function

event dberror;
/* 
* Event: 				dberror
* Beschreibung: 	reaktion auf datenbank-fehler
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			???			??.??.????		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		06.02.2012		festhalten der original-daten erg$$HEX1$$e400$$ENDHEX$$nzt
*
* Return Codes:
* 	0  Continue processing (PB)
*
*/

String 	sOut, sError, sValue, sColumn, sDataType, sTemp
Integer 	iPos 
Long 		lColumns


// originale Error-Informationen festhalten, damit sie per of_return_dberror abgeholt werden k$$HEX1$$f600$$ENDHEX$$nnen, falls gewollt
this.il_SQLDBCode = sqldbcode
this.il_ErrorRow = row
this.is_SQLErrText = sqlerrtext
this.is_SQLSyntax = sqlsyntax
this.idwb_Errorbuffer = buffer

 
iPos = Pos(sqlerrtext, char(10))

if iPos > 0 then
	sError = Mid(sqlerrtext, 1, iPos - 1)
else
	sError = sqlerrtext
end if

sOut = "DB-Error: " + string(sqldbcode) + " DB-ErrorText: " + string(sError) 

uo_systemerror uose
uose.of_dw_error(gs_Version + "-" + gs_Build, sInstance,  sProfile, sqldbcode , sqlerrtext, this.dataobject, "Error in row "+string( row) + " "+sqlsyntax)

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

on uo_cbase_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cbase_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
/* 
* Event: 				constructor
* Beschreibung: 	initialisiert... hier den objectnamen setzen
* Besonderheit: 	extended stehen lassen f$$HEX1$$fc00$$ENDHEX$$r isObjectname (oder diese zeile kopieren)
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			???			??.??.????		Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		12.06.2009		isObjectname erg$$HEX1$$e400$$ENDHEX$$nzt
*
* Return Codes:
* 	0  Continue processing (PB)
*
*/

if not IsValid(dsObjects) then
	dsObjects = create datastore
	dsObjects.dataobject = "dw_uo_dwobjects"
end if

this.is_LogFile = f_gettemppath() + "CBASE-Datastore.log"
this.of_get_objects()

// damit der aktuelle name des objects, welches die ausgabe generiert, mit ausgegeben werden kann
isObjectname = this.Classname ( )

return 0

end event

event destructor;
/* 
* Event: 				destructor
* Beschreibung: 	aufr$$HEX1$$e400$$ENDHEX$$umen
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		12.06.2009		Erstellung
*
* Return Codes:
* 	0  Continue processing (PB)
*
*/

if IsValid(dsObjects) then destroy dsObjects

return 0

end event

event sqlpreview;
/* 
* Event: 				sqlpreview
* Beschreibung: 	datenbankzugriffe protokollieren, wenn gewollt
* Besonderheit: 	
*
* Argumente:
*	sqlpreviewfunction	request		ausl$$HEX1$$f600$$ENDHEX$$ser des zugriffs (PreviewFunctionRetrieve!, PreviewFunctionReselectRow!, PreviewFunctionUpdate!)
*	sqlpreviewtype		sqltype		art des zugriffs (PreviewSelect!	, PreviewInsert!, PreviewDelete!, PreviewUpdate!)
*	string 				sqlsyntax		syntax des zugriffs
*	dwbuffer 			buffer			der vom zugriff betroffene buffer (Primary!, Delete!, Filter!)
*	long 					row			die vom zugriff betroffene zeile
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		09.06.2009		Erstellung
*
* Return Codes:
* 	0  Continue processing (PB)
*
*/


if ibTrace then 
	this.of_log2file("--------------------------------------------------------------------")
	this.of_log2file(sqlsyntax)
	this.of_log2file("--------------------------------------------------------------------")
end if

return 0

end event

