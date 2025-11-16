HA$PBExportHeader$uo_format_mandant.sru
$PBExportComments$mandant-spezifische formatierungen
forward
global type uo_format_mandant from nonvisualobject
end type
end forward

global type uo_format_mandant from nonvisualobject autoinstantiate
end type

type variables


/* 
* object: 			uo_format_mandant
* Beschreibung: 	objekt zum umgang mit unterschiedlichen nachkomma-anzahlen f$$HEX1$$fc00$$ENDHEX$$r gleiche columns 
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		xx.08.2010		Erstellung
*
*
* das objekt kann intern ein array von column-namen, zugeh$$HEX1$$f600$$ENDHEX$$rigen formaten und zugeh$$HEX1$$f600$$ENDHEX$$rigen nachkomma-stellen f$$HEX1$$fc00$$ENDHEX$$hren,
* sodass nur noch das zu bearbeitende DW oder DS $$HEX1$$fc00$$ENDHEX$$bergeben werden muss  
* 
* ---------------------------------------------------------------------- 
* initialisierungsfunktionen:
* 
* - of_reset
* 		leert das komplette array
* 
* - of_add_format ( <column-name>, <format> )
* 		f$$HEX1$$fc00$$ENDHEX$$llt die angegebene column mit dem angegebenen format in das array
* - of_add_format_to_key ( <column-name>[, <mandant>], <key-name> )
* 		f$$HEX1$$fc00$$ENDHEX$$llt die angegebene column mit dem zum key gelesenen format in das array
* 
* - of_add_round ( <column-name>, <nachkomma-stellen> )
* 		f$$HEX1$$fc00$$ENDHEX$$llt die angegebene column mit der angegebenen anzahl nachkomma-stellen in das array
* - of_add_round_to_key ( <column-name>[, <mandant>], <key-name> )
* 		f$$HEX1$$fc00$$ENDHEX$$llt die angegebene column mit der zum key gelesenen anzahl nachkomma-stellen in das array
* 
* - of_add ( <column-name>, <format>, <nachkomma-stellen> )
* 		f$$HEX1$$fc00$$ENDHEX$$llt die angegebene column mit dem angegebenen format und der angegebenen anzahl nachkomma-stellen in das array
* - of_add_to_key ( <column-name>[, <mandant>], <key-name> )
* 		f$$HEX1$$fc00$$ENDHEX$$llt die angegebene column mit dem zum key gelesenen format und der zum key gelesenen anzahl nachkomma-stellen in das array
* 
* ---------------------------------------------------------------------- 
* formatierungsfunktionen:
* 
* - of_format ( <datawindow oder datastore> [, <column-name>, <format>])
* 		setzt das display und das edit-format f$$HEX1$$fc00$$ENDHEX$$r alle columns, die im array eingetragen sind und im DW oder DS gefunden werden
* 		setzt das display und das edit-format wie angegeben f$$HEX1$$fc00$$ENDHEX$$r die angegebene column im  DW oder DS
* 		Kein edit-format f$$HEX1$$fc00$$ENDHEX$$r compute-columns im  DW oder DS
* 
* 		of_format macht sinn im open/post_open direkt nach einem eventuellen uf_format_editstyle oder $$HEX1$$e400$$ENDHEX$$hnlichem 
* 
* 
* - of_round_value ( <datawindow oder datastore> [, <column-name>, <nachkomma-stellen>])
* 		betrachtet nur werte, wo ItemStatus != NotModified! gilt
* 		rundet den wert in allen vorhandenen zeilen und allen columns, die im array eingetragen sind und im DW oder DS gefunden werden
* 		rundet den wert wie angegeben f$$HEX1$$fc00$$ENDHEX$$r die angegebene column im  DW oder DS
* 		bei compute-columns im  DW oder DS wird ggf. die expression um den round erweitert, deshalb kann der round bereits bei der initialisierung sinnvoll sein
* 
* 		of_round_value geh$$HEX1$$f600$$ENDHEX$$rt direkt vor eventuelle update oder insert-aktivit$$HEX1$$e400$$ENDHEX$$ten, um sicherzustellen, 
* 			dass daten nur in der gew$$HEX1$$fc00$$ENDHEX$$nschten genauigkeit abgespeichert  werden
* 		es kann auch sinnvoll sein, es initial zusammen mit of_format einzusetzen, um compute-columns passend einzurichten
* 
* ---------------------------------------------------------------------- 
* 
*/

private:

// arrays, welche paare von column-namen, format-strings und nachkomma-anzahlen enthalten k$$HEX1$$f600$$ENDHEX$$nnen
String 	isColumnToSetArray[], isFormatToSetArray[]
Integer 	iiRoundArray[]

// arrays, welche die relevanten compute-columns eines DW oder DS enthalten
String 	isColumn[], isBand[], isColType[]
Boolean 	ibFilled = false


String 	isDisplaySection = "DisplayFormat"
String 	isDefaultFormat = "#,###,##0.00"
String 	isLeerFormat = "-1"


String 	isRoundSection = "RoundFormat"
Integer 	iiDefaultRound = 2
Integer 	iiLeerRound = -1

String 	isMandant = ""

end variables

forward prototypes
public function long of_format (datawindow adwtoformat)
public function long of_format (datastore adstoformat)
public function long of_reset ()
public function long of_add_format (string ascolumntoset, string asformattoset)
public function long of_format (datastore adstoformat, string ascolumntoset, string asformattoset)
public function long of_format (datawindow adwtoformat, string ascolumntoset, string asformattoset)
public function string of_mandant_profilestring (transaction arg_sqlca, string asmandant, string assection, string askey, string asdefault)
public function long of_add_format_for_key (string ascolumntoset, string askey)
public function long of_add_format_for_key (string ascolumntoset, string asmandant, string askey)
public function string of_mandant_profilestring_round (string askey)
public function string of_mandant_profilestring_round (string asmandant, string askey)
public function string of_mandant_profilestring_format (string askey)
public function string of_mandant_profilestring_format (string asmandant, string askey)
public function long of_add_round (string ascolumntoset, integer airoundtoset)
public function long of_add_round_for_key (string ascolumntoset, string askey)
public function long of_add_round_for_key (string ascolumntoset, string asmandant, string askey)
public function long of_round_value (datastore adstoformat, string ascolumntoset, integer alroundtoset)
public function long of_round_value (datawindow adwtoformat, string ascolumntoset, integer alroundtoset)
public function long of_round_value (datawindow adwtoformat)
public function long of_round_value (datastore adstoformat)
public function long of_add (string ascolumntoset, string asformattoset, integer airoundtoset)
public function long of_add_for_key (string ascolumntoset, string askey)
public function long of_add_for_key (string ascolumntoset, string asmandant, string askey)
public function long of_add_copy (string ascolumntoset, string ascolumntocopy)
public function long of_get_computes (datawindow adwtocheck)
public function long of_reset_computes ()
public function long of_get_computes (datastore adstocheck)
end prototypes

public function long of_format (datawindow adwtoformat);
/* 
* Funktion:			of_format
* Beschreibung: 	
* Besonderheit: 	keine
*
* Argumente:
* 	datawindow 	adwToFormat
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			10.08.2010	Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			09.09.2010	computed hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*	 0		erfolgreich
*	< 0	modify gescheitert
*
*/


// hilfsvariable
Long 		llRet = 0, llRow, llRowCompute

// computed columns feststellen
llRowCompute = of_get_computes(adwToFormat)
ibFilled = true

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle zu formatierenden columns
for llRow = 1 to UpperBound(this.isColumnToSetArray) step 1
	if this.isFormatToSetArray[llRow] <> this.isLeerFormat then
		llRet += this.of_format(adwToFormat, this.isColumnToSetArray[llRow], this.isFormatToSetArray[llRow])
	end if
next

// computed columns resetten
llRowCompute = of_reset_computes()
ibFilled = false

return llRet

end function

public function long of_format (datastore adstoformat);
/* 
* Funktion:			of_format
* Beschreibung: 	
* Besonderheit: 	keine
*
* Argumente:
* 	datastore 		adsToFormat
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			10.08.2010	Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			09.09.2010	computed hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*	 0		erfolgreich
*	< 0	modify gescheitert
*
*/


// hilfsvariable
Long 		llRet = 0, llRow, llRowCompute

// computed columns feststellen
llRowCompute = of_get_computes(adsToFormat)
ibFilled = true

for llRow = 1 to UpperBound(this.isColumnToSetArray) step 1
	if this.isFormatToSetArray[llRow] <> this.isLeerFormat then
		llRet += this.of_format(adsToFormat, this.isColumnToSetArray[llRow], this.isFormatToSetArray[llRow])
	end if
next

// computed columns resetten
llRowCompute = of_reset_computes()
ibFilled = false

return llRet

end function

public function long of_reset ();
/* 
* Funktion:			of_reset
* Beschreibung: 	
* Besonderheit: 	keine
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			10.08.2010	Erstellung
*
* Return Codes:
*	 0		erfolgreich
*
*/


// hilfsvariable
String 	lsEmpty[]
Integer 	liEmpty[]

this.isColumnToSetArray = lsEmpty
this.isFormatToSetArray = lsEmpty
this.iiRoundArray = liEmpty

return 0

end function

public function long of_add_format (string ascolumntoset, string asformattoset);
/* 
* Funktion:			of_add_format
* Beschreibung: 	aktualisiere das array
* Besonderheit: 	wenn column schon vorhanden, wird format $$HEX1$$fc00$$ENDHEX$$berschrieben, sonst wird ein neuer eintrag gemacht
*
* Argumente:
* 	string		 		asColumnToSet
* 	string		 		asFormatToSet
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			10.08.2010	Erstellung
*
* Return Codes:
*	 0		ersetzt
*	 1		zeile hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
*/


// hilfsvariable
Long 		llRet = 0, llRow
Boolean 	lbFound = false

// suchen, ob asColumnToSet schon eingetragen ist
for llRow = 1 to UpperBound(isColumnToSetArray) step 1
	if this.isColumnToSetArray[llRow] =  asColumnToSet then
		this.isFormatToSetArray[llRow] = asFormatToSet
		lbFound = true
	end if
next

if not lbFound then
	llRow = Upperbound(this.isColumnToSetArray) + 1
	this.isColumnToSetArray[llRow] = asColumnToSet
	this.isFormatToSetArray[llRow] = asFormatToSet
	this.iiRoundArray[llRow] = this.iiLeerRound
	llRet = 1
end if

return llRet

end function

public function long of_format (datastore adstoformat, string ascolumntoset, string asformattoset);
/* 
* Funktion:			of_format
* Beschreibung: 	
* Besonderheit: 	keine
*
* Argumente:
* 	datastore 		adsToFormat
* 	string		 		asColumnToSet
* 	string		 		asFormatToSet
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			10.08.2010	Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			09.09.2010	computed hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*	 0		erfolgreich
*	-1		modify gescheitert
*
*/


// hilfsvariable
Long 		llRet = 0
String 	lsRet
Long 		llColumnCount, llColumn, llComputeCount
String 	lsName

// kein format vorhanden
if asFormatToSet = this.isLeerFormat then return llRet

// computed columns feststellen
if not ibFilled then
	llComputeCount = of_get_computes(adsToFormat)
else
	llComputeCount = Upperbound(this.isColumn)
end if

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle columns des DSs
llColumnCount = long(adsToFormat.Object.DataWindow.Column.Count)
for llColumn = 1 to llColumnCount step 1
	if long(adsToFormat.Describe("#" + string(llColumn) + ".Width")) > 0 then
		lsName = lower(adsToFormat.Describe ("#" + string(llColumn) + ".Name"))
		if lower(lsName) = lower(asColumnToSet) then
			lsRet = adsToFormat.Modify("#" + string(llColumn) + ".Edit.Format='" + asFormatToSet + "'")
			if trim(lsRet) <> "" then llRet = -1 		// modify gescheitert
			lsRet = adsToFormat.Modify("#" + string(llColumn) + ".Format='" + asFormatToSet + "'")
			if trim(lsRet) <> "" then llRet = -1 		// modify gescheitert
			exit
		end if
	end if
next

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle computed des DWs
for llColumn = 1 to llComputeCount step 1
	if lower(this.isColumn[llColumn]) = lower(asColumnToSet) then
		lsRet = adsToFormat.Modify(asColumnToSet + ".Format='" + asFormatToSet + "'")
		if trim(lsRet) <> "" then llRet = -1 		// modify gescheitert
		exit
	end if
next

if not ibFilled then
	llComputeCount = of_reset_computes()
end if

return llRet

end function

public function long of_format (datawindow adwtoformat, string ascolumntoset, string asformattoset);
/* 
* Funktion:			of_format
* Beschreibung: 	
* Besonderheit: 	keine
*
* Argumente:
* 	datawindow 	adwToFormat
* 	string		 		asColumnToSet
* 	string		 		asFormatToSet
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			10.08.2010	Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			09.09.2010	computed hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*	 0		erfolgreich
*	-1		modify gescheitert
*
*/


// hilfsvariable
Long 		llRet = 0
String 	lsRet
Long 		llColumnCount, llColumn, llComputeCount
String 	lsName

// kein format vorhanden
if asFormatToSet = this.isLeerFormat then return llRet

// computed columns feststellen
if not ibFilled then
	llComputeCount = of_get_computes(adwToFormat)
else
	llComputeCount = Upperbound(this.isColumn)
end if

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle columns des DWs
llColumnCount = long(adwToFormat.Object.DataWindow.Column.Count)
for llColumn = 1 to llColumnCount step 1
	if long(adwToFormat.Describe("#" + string(llColumn) + ".Width")) > 0 then
		lsName = lower(adwToFormat.Describe ("#" + string(llColumn) + ".Name"))
		if lower(lsName) = lower(asColumnToSet) then
			lsRet = adwToFormat.Modify("#" + string(llColumn) + ".Edit.Format='" + asFormatToSet + "'")
			if trim(lsRet) <> "" then llRet = -1 		// modify gescheitert
			lsRet = adwToFormat.Modify("#" + string(llColumn) + ".Format='" + asFormatToSet + "'")
			if trim(lsRet) <> "" then llRet = -1 		// modify gescheitert
			exit
		end if
	end if
next

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle computed des DWs
for llColumn = 1 to llComputeCount step 1
	if lower(this.isColumn[llColumn]) = lower(asColumnToSet) then
		lsRet = adwToFormat.Modify(asColumnToSet + ".Format='" + asFormatToSet + "'")
		if trim(lsRet) <> "" then llRet = -1 		// modify gescheitert
		exit
	end if
next

if not ibFilled then
	llComputeCount = of_reset_computes()
end if

return llRet

end function

public function string of_mandant_profilestring (transaction arg_sqlca, string asmandant, string assection, string askey, string asdefault);
/* 
* Funktion:			of_mandant_profilestring
* Beschreibung: 	Lesen eines Wertes aus der cen_setup
* Besonderheit: 	keine
*
* Argumente:
* 	transaction 		arg_sqlca
* 	string 			asMandant
* 	string 			asSection
* 	string 			asKey
* 	string 			asDefault
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			H.Rothenbach	29.10.2008		Erstellung
*
* Return Codes: keine
*	 string mit wert kommt zur$$HEX1$$fc00$$ENDHEX$$ck
*
*/


// hilfsvariable
string		lsValue = ""

select cValue into :lsValue 
  from cen_setup
where cclient = :asMandant
   and cSection = :asSection
   and cKey = :asKey
using arg_sqlca;
			
// wert nicht gefunden:
if arg_sqlca.SQLCode = 100 then
	// eintragen
	INSERT INTO cen_setup  
				 (cclient,   
				  csection,   
				  ckey,   
				  cvalue )
   	VALUES ( :asMandant,   
				 :asSection,   
				 :asKey,   
				 :asDefault) 
 	using arg_sqlca;
	 
	// default zur$$HEX1$$fc00$$ENDHEX$$ckgeben
	lsValue = asDefault
 
end if

return lsValue

end function

public function long of_add_format_for_key (string ascolumntoset, string askey);
/* 
* Funktion:			of_add_format_for_key
* Beschreibung: 	aktualisiere das array zum Profile-Key
* Besonderheit: 	wenn column schon vorhanden, wird format $$HEX1$$fc00$$ENDHEX$$berschrieben, sonst wird ein neuer eintrag gemacht
*
* Argumente:
* 	string		 		asColumnToSet
* 	string		 		asKey
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			12.08.2010	Erstellung
*
* Return Codes:
*	 0		ersetzt
*	 1		zeile hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
*/


// hilfsvariable
String 	lsFormatToSet

// den formatstring holen
lsFormatToSet = this.of_mandant_profilestring_format(asKey)

return this.of_add_format(asColumnToSet, lsFormatToSet)

end function

public function long of_add_format_for_key (string ascolumntoset, string asmandant, string askey);
/* 
* Funktion:			of_add_format_for_key
* Beschreibung: 	aktualisiere das array zum Profile-Key
* Besonderheit: 	wenn column schon vorhanden, wird format $$HEX1$$fc00$$ENDHEX$$berschrieben, sonst wird ein neuer eintrag gemacht
*
* Argumente:
* 	string		 		asColumnToSet
* 	string 			asMandant
* 	string		 		asKey
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			10.08.2010	Erstellung
*
* Return Codes:
*	 0		ersetzt
*	 1		zeile hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
*/


// hilfsvariable
String 	lsFormatToSet

// den formatstring holen
lsFormatToSet = this.of_mandant_profilestring_format(asMandant, asKey)

return this.of_add_format(asColumnToSet, lsFormatToSet)

end function

public function string of_mandant_profilestring_round (string askey);
/* 
* Funktion:			of_mandant_profilestring_round
* Beschreibung: 	Lesen eines Wertes aus der cen_setup f$$HEX1$$fc00$$ENDHEX$$r rundungen
* Besonderheit: 	keine
*
* Argumente:
* 	string 			asKey
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel	 		01.09.2010	Erstellung
*
* Return Codes: keine
*	 string mit wert kommt zur$$HEX1$$fc00$$ENDHEX$$ck
*
*/

return this.of_mandant_profilestring(sqlca, this.isMandant, this.isRoundSection, asKey, string(this.iiDefaultRound))

end function

public function string of_mandant_profilestring_round (string asmandant, string askey);
/* 
* Funktion:			of_mandant_profilestring_round
* Beschreibung: 	Lesen eines Wertes aus der cen_setup f$$HEX1$$fc00$$ENDHEX$$r Rundungen
* Besonderheit: 	keine
*
* Argumente:
* 	string 			asMandant
* 	string 			asKey
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel	 		01.09.2010	Erstellung
*
* Return Codes: keine
*	 string mit wert kommt zur$$HEX1$$fc00$$ENDHEX$$ck
*
*/

// setze instanz
this.isMandant = asMandant

return this.of_mandant_profilestring(sqlca, this.isMandant, this.isRoundSection, asKey, string(this.iiDefaultRound))

end function

public function string of_mandant_profilestring_format (string askey);
/* 
* Funktion:			of_mandant_profilestring_format
* Beschreibung: 	Lesen eines Wertes aus der cen_setup
* Besonderheit: 	keine
*
* Argumente:
* 	string 			asKey
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			01.09.2010	Erstellung
*
* Return Codes: keine
*	 string mit wert kommt zur$$HEX1$$fc00$$ENDHEX$$ck
*
*/

return this.of_mandant_profilestring(sqlca, this.isMandant, this.isDisplaySection, asKey, this.isDefaultFormat)

end function

public function string of_mandant_profilestring_format (string asmandant, string askey);
/* 
* Funktion:			of_mandant_profilestring_format
* Beschreibung: 	Lesen eines Wertes aus der cen_setup
* Besonderheit: 	keine
*
* Argumente:
* 	string 			asMandant
* 	string 			asKey
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel	 		01.09.2010	Erstellung
*
* Return Codes: keine
*	 string mit wert kommt zur$$HEX1$$fc00$$ENDHEX$$ck
*
*/

// setze instanz
this.isMandant = asMandant

return this.of_mandant_profilestring(sqlca, this.isMandant, this.isDisplaySection, asKey, this.isDefaultFormat)

end function

public function long of_add_round (string ascolumntoset, integer airoundtoset);
/* 
* Funktion:			of_add_round
* Beschreibung: 	aktualisiere das array
* Besonderheit: 	wenn column schon vorhanden, wird anzahl nachkommastellen $$HEX1$$fc00$$ENDHEX$$berschrieben, sonst wird ein neuer eintrag gemacht
*
* Argumente:
* 	string		 		asColumnToSet
* 	integer		 	aiRoundToSet
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			01.09.2010	Erstellung
*
* Return Codes:
*	 0		ersetzt
*	 1		zeile hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
*/


// hilfsvariable
Long 		llRet = 0, llRow
Boolean 	lbFound = false

// suchen, ob asColumnToSet schon eingetragen ist
for llRow = 1 to UpperBound(isColumnToSetArray) step 1
	if this.isColumnToSetArray[llRow] =  asColumnToSet then
		this.iiRoundArray[llRow] = aiRoundToSet
		lbFound = true
	end if
next

if not lbFound then
	llRow = Upperbound(this.isColumnToSetArray) + 1
	this.isColumnToSetArray[llRow] = asColumnToSet
	this.iiRoundArray[llRow] = aiRoundToSet
	this.isFormatToSetArray[llRow] = this.isLeerFormat
	llRet = 1
end if

return llRet

end function

public function long of_add_round_for_key (string ascolumntoset, string askey);
/* 
* Funktion:			of_add_round_for_key
* Beschreibung: 	aktualisiere das array zum Profile-Key
* Besonderheit: 	wenn column schon vorhanden, wird anzahl nachkommastellen $$HEX1$$fc00$$ENDHEX$$berschrieben, sonst wird ein neuer eintrag gemacht
*
* Argumente:
* 	string		 		asColumnToSet
* 	string		 		asKey
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			01.09.2010	Erstellung
*
* Return Codes:
*	 0		ersetzt
*	 1		zeile hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
*/


// hilfsvariable
Integer 	liRoundToSet

// die anzahl nachkomma-stellen holen
liRoundToSet = Integer(this.of_mandant_profilestring_round(asKey))

return this.of_add_round(asColumnToSet, liRoundToSet)

end function

public function long of_add_round_for_key (string ascolumntoset, string asmandant, string askey);
/* 
* Funktion:			of_add_round_for_key
* Beschreibung: 	aktualisiere das array zum Profile-Key
* Besonderheit: 	wenn column schon vorhanden, wird anzahl nachkommastellen $$HEX1$$fc00$$ENDHEX$$berschrieben, sonst wird ein neuer eintrag gemacht
*
* Argumente:
* 	string		 		asColumnToSet
* 	string 			asMandant
* 	string		 		asKey
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			01.09.2010	Erstellung
*
* Return Codes:
*	 0		ersetzt
*	 1		zeile hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
*/


// hilfsvariable
Integer 	liRoundToSet

// die anzahl nachkomma-stellen holen
liRoundToSet = Integer(this.of_mandant_profilestring_round(asMandant, asKey))

return this.of_add_round(asColumnToSet, liRoundToSet)

end function

public function long of_round_value (datastore adstoformat, string ascolumntoset, integer alroundtoset);
/* 
* Funktion:			of_round_value
* Beschreibung: 	
* Besonderheit: 	keine
*
* Argumente:
* 	datastore 		adsToFormat
* 	string		 		asColumnToSet
* 	integer		 	alRoundToSet
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			02.09.2010	Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			09.09.2010	computed hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*	 0		erfolgreich
*	-1		setitem gescheitert
*
*/


// hilfsvariable
Long 		llRet = 0
String 	lsRet
Long 		llColumnCount, llColumn, llComputeCount, llRow
String 	lsDataType, lsName, lsExpression, lsRound1, lsRound2

// keine nachkommastellen eingestellt
if alRoundToSet = this.iiLeerRound then return llRet

// initialisieren
lsRound1 = "round("
lsRound2 = ", " + string(alRoundToSet) +")"

// computed columns feststellen
if not ibFilled then
	llComputeCount = of_get_computes(adsToFormat)
else
	llComputeCount = Upperbound(this.isColumn)
end if

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle columns des DWs
llColumnCount = long(adsToFormat.Object.DataWindow.Column.Count)
for llColumn = 1 to llColumnCount
	lsName = lower(adsToFormat.Describe ("#" + string(llColumn) + ".Name"))
	lsDataType 	= lower(adsToFormat.Describe ("#" + string(llColumn) + ".ColType"))
	// sicherstellen, dass es eine numerische column ist!		
	if (pos(lsDataType, "number") > 0 or pos(lsDataType, "decimal") > 0) &
	and lower(lsName) = lower(asColumnToSet) then
		// schleife $$HEX1$$fc00$$ENDHEX$$ber alle zeilen
		for llRow = 1 to adsToFormat.RowCount() step 1
			if adsToFormat.GetItemStatus(llRow, lsName, Primary!) <> NotModified! then
				if adsToFormat.SetItem(llRow, lsName, round(adsToFormat.GetItemNumber(llRow, lsName), alRoundToSet)) <> 1 then llRet = -1
			end if
		next
		exit
	end if
next

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle computed des DSs
for llColumn = 1 to llComputeCount step 1
	// sicherstellen, dass es eine numerische column ist!		
	if (pos(lower(this.isColtype[llColumn]), "number") > 0 or pos(lower(this.isColtype[llColumn]), "decimal") > 0) &
	and lower(this.isColumn[llColumn]) = lower(asColumnToSet) then
		lsExpression = adsToFormat.Describe(asColumnToSet + ".expression")
		if lsExpression <> "!" and lsExpression <> "?" then
			// schon mal gemacht ? dann nicht mehr!
			if not (left(lsExpression,len(lsRound1)) = lsRound1 and right(lsExpression, len(lsRound2)) = lsRound2) then
				lsRet = adsToFormat.Modify(asColumnToSet + ".expression='" + lsRound1 + lsExpression + lsRound2 +"'")
				if trim(lsRet) <> "" then
					MessageBox("of_round_value" + asColumnToSet, lsRet)
					llRet = -1 		// modify gescheitert
				end if
			end if
		end if
		exit
	end if
next

if not ibFilled then
	llComputeCount = of_reset_computes()
end if

return llRet

end function

public function long of_round_value (datawindow adwtoformat, string ascolumntoset, integer alroundtoset);
/* 
* Funktion:			of_round_value
* Beschreibung: 	
* Besonderheit: 	keine
*
* Argumente:
* 	datawindow 	adwToFormat
* 	string		 		asColumnToSet
* 	integer	 		alRoundToSet
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			02.09.2010	Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			09.09.2010	computed hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*	 0		erfolgreich
*	-1		setitem gescheitert
*
*/


// hilfsvariable
Long 		llRet = 0
String 	lsRet
Long 		llColumnCount, llColumn, llComputeCount, llRow
String 	lsDataType, lsName, lsExpression, lsRound1, lsRound2

// keine nachkommastellen eingestellt
if alRoundToSet = this.iiLeerRound then return llRet

// initialisieren
lsRound1 = "round("
lsRound2 = ", " + string(alRoundToSet) +")"

// computed columns feststellen
if not ibFilled then
	llComputeCount = of_get_computes(adwToFormat)
else
	llComputeCount = Upperbound(this.isColumn)
end if

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle columns des DWs
llColumnCount = long(adwToFormat.Object.DataWindow.Column.Count)
for llColumn = 1 to llColumnCount
	lsName = lower(adwToFormat.Describe ("#" + string(llColumn) + ".Name"))
	lsDataType 	= lower(adwToFormat.Describe ("#" + string(llColumn) + ".ColType"))
	// sicherstellen, dass es eine numerische column ist!		
	if (pos(lsDataType, "number") > 0 or pos(lsDataType, "decimal") > 0) &
	and lower(lsName) = lower(asColumnToSet) then
		// schleife $$HEX1$$fc00$$ENDHEX$$ber alle zeilen
		for llRow = 1 to adwToFormat.RowCount() step 1
			if adwToFormat.GetItemStatus(llRow, lsName, Primary!) <> NotModified! then
				if adwToFormat.SetItem(llRow, lsName, round(adwToFormat.GetItemNumber(llRow, lsName), alRoundToSet)) <> 1 then llRet = -1
			end if
		next
		exit
	end if
next

// schleife $$HEX1$$fc00$$ENDHEX$$ber alle computed des DWs
for llColumn = 1 to llComputeCount step 1
	// sicherstellen, dass es eine numerische column ist!		
	if (pos(lower(this.isColtype[llColumn]), "number") > 0 or pos(lower(this.isColtype[llColumn]), "decimal") > 0) &
	and lower(this.isColumn[llColumn]) = lower(asColumnToSet) then
		lsExpression = adwToFormat.Describe(asColumnToSet + ".expression")
		if lsExpression <> "!" and lsExpression <> "?" then
			// schon mal gemacht ? dann nicht mehr!
			if not (left(lsExpression,len(lsRound1)) = lsRound1 and right(lsExpression, len(lsRound2)) = lsRound2) then
				lsRet = adwToFormat.Modify(asColumnToSet + ".expression='" + lsRound1 + lsExpression + lsRound2 +"'")
				if trim(lsRet) <> "" then
					MessageBox("of_round_value" + asColumnToSet, lsRet)
					llRet = -1 		// modify gescheitert
				end if
			end if
		end if
		exit
	end if
next

if not ibFilled then
	llComputeCount = of_reset_computes()
end if

return llRet

end function

public function long of_round_value (datawindow adwtoformat);
/* 
* Funktion:			of_round_value
* Beschreibung: 	
* Besonderheit: 	keine
*
* Argumente:
* 	datawindow 	adwToFormat
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			02.09.2010	Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			09.09.2010	computed hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*	 0		erfolgreich
*	< 0	mindestens ein setitem gescheitert
*
*/


// hilfsvariable
Long 		llRet = 0, llRow, llRowCompute

// computed columns feststellen
llRowCompute = of_get_computes(adwToFormat)
ibFilled = true

for llRow = 1 to UpperBound(this.isColumnToSetArray) step 1
	if this.iiRoundArray[llRow] <> this.iiLeerRound then
		llRet += this.of_round_value(adwToFormat, this.isColumnToSetArray[llRow], this.iiRoundArray[llRow])
	end if
next

// computed columns resetten
llRowCompute = of_reset_computes()
ibFilled = false

return llRet

end function

public function long of_round_value (datastore adstoformat);
/* 
* Funktion:			of_round_value
* Beschreibung: 	
* Besonderheit: 	keine
*
* Argumente:
* 	datastore 		adsToFormat
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			02.09.2010	Erstellung
*	1.1 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			09.09.2010	computed hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return Codes:
*	 0		erfolgreich
*	< 0	modify gescheitert
*
*/


// hilfsvariable
Long 		llRet = 0, llRow, llRowCompute

// computed columns feststellen
llRowCompute = of_get_computes(adsToFormat)
ibFilled = true

for llRow = 1 to UpperBound(this.isColumnToSetArray) step 1
	if this.iiRoundArray[llRow] <> this.iiLeerRound then
		llRet += this.of_round_value(adsToFormat, this.isColumnToSetArray[llRow], this.iiRoundArray[llRow])
	end if
next

// computed columns resetten
llRowCompute = of_reset_computes()
ibFilled = false

return llRet

end function

public function long of_add (string ascolumntoset, string asformattoset, integer airoundtoset);
/* 
* Funktion:			of_add
* Beschreibung: 	aktualisiere das array
* Besonderheit: 	wenn column schon vorhanden, wird format und anzahl nachkommastellen $$HEX1$$fc00$$ENDHEX$$berschrieben, sonst wird ein neuer eintrag gemacht
*
* Argumente:
* 	string		 		asColumnToSet
* 	string		 		asFormatToSet
* 	integer		 	aiRoundToSet
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			02.09.2010	Erstellung
*
* Return Codes:
*	 0		ersetzt
*	 1		zeile hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
*/


// hilfsvariable
Long 		llRet = 0, llRow
Boolean 	lbFound = false

// suchen, ob asColumnToSet schon eingetragen ist
for llRow = 1 to UpperBound(isColumnToSetArray) step 1
	if this.isColumnToSetArray[llRow] =  asColumnToSet then
		this.isFormatToSetArray[llRow] = asFormatToSet
		this.iiRoundArray[llRow] = aiRoundToSet
		lbFound = true
	end if
next

if not lbFound then
	llRow = Upperbound(this.isColumnToSetArray) + 1
	this.isColumnToSetArray[llRow] = asColumnToSet
	this.isFormatToSetArray[llRow] = asFormatToSet
	this.iiRoundArray[llRow] = aiRoundToSet
	llRet = 1
end if

return llRet

end function

public function long of_add_for_key (string ascolumntoset, string askey);
/* 
* Funktion:			of_add_for_key
* Beschreibung: 	aktualisiere das array zum Profile-Key
* Besonderheit: 	wenn column schon vorhanden, wird format $$HEX1$$fc00$$ENDHEX$$berschrieben, sonst wird ein neuer eintrag gemacht
*
* Argumente:
* 	string		 		asColumnToSet
* 	string		 		asKey
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			02.09.2010	Erstellung
*
* Return Codes:
*	 0		ersetzt
*	 1		zeile hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
*/


// hilfsvariable
String 	lsFormatToSet
Integer 	liRoundToSet

// den formatstring holen
lsFormatToSet = this.of_mandant_profilestring_format(asKey)

// die anzahl nachkomma-stellen holen
liRoundToSet = Integer(this.of_mandant_profilestring_round(asKey))

return this.of_add(asColumnToSet, lsFormatToSet, liRoundToSet)

end function

public function long of_add_for_key (string ascolumntoset, string asmandant, string askey);
/* 
* Funktion:			of_add_for_key
* Beschreibung: 	aktualisiere das array zum Profile-Key
* Besonderheit: 	wenn column schon vorhanden, wird format $$HEX1$$fc00$$ENDHEX$$berschrieben, sonst wird ein neuer eintrag gemacht
*
* Argumente:
* 	string		 		asColumnToSet
* 	string 			asMandant
* 	string		 		asKey
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			02.09.2010	Erstellung
*
* Return Codes:
*	 0		ersetzt
*	 1		zeile hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
*/


// hilfsvariable
String 	lsFormatToSet
Integer 	liRoundToSet

// den formatstring holen
lsFormatToSet = this.of_mandant_profilestring_format(asMandant, asKey)

// die anzahl nachkomma-stellen holen
liRoundToSet = Integer(this.of_mandant_profilestring_round(asMandant, asKey))

return this.of_add(asColumnToSet, lsFormatToSet, liRoundToSet)

end function

public function long of_add_copy (string ascolumntoset, string ascolumntocopy);
/* 
* Funktion:			of_add_copy
* Beschreibung: 	aktualisiere das array durch kopieren der daten einer zeile in eine andere
* Besonderheit: 	wenn column schon vorhanden, wird format und anzahl nachkommastellen $$HEX1$$fc00$$ENDHEX$$berschrieben, sonst wird ein neuer eintrag gemacht
*
* Argumente:
* 	string		 		asColumnToSet
* 	string		 		asColumnToCopy
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			08.09.2010	Erstellung
*
* Return Codes:
*	-1		fehler: quelle nicht da
*	 0		ersetzt
*	 1		zeile hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
*/


// hilfsvariable
Long 		llRet = 0, llRow, llSource
Boolean 	lbFound = false

// Position von asColumnToCopy suchen
for llSource = 1 to UpperBound(isColumnToSetArray) step 1
	if this.isColumnToSetArray[llSource] =  asColumnToCopy then
		lbFound = true
		exit
	end if
next
if not lbFound then return -1

// suchen, ob asColumnToSet schon eingetragen ist
lbFound = false
for llRow = 1 to UpperBound(isColumnToSetArray) step 1
	if this.isColumnToSetArray[llRow] =  asColumnToSet then
		this.isFormatToSetArray[llRow] = this.isFormatToSetArray[llSource]
		this.iiRoundArray[llRow] = this.iiRoundArray[llSource]
		lbFound = true
	end if
next

if not lbFound then
	llRow = Upperbound(this.isColumnToSetArray) + 1
	this.isColumnToSetArray[llRow] = asColumnToSet
		this.isFormatToSetArray[llRow] = this.isFormatToSetArray[llSource]
		this.iiRoundArray[llRow] = this.iiRoundArray[llSource]
	llRet = 1
end if

return llRet

end function

public function long of_get_computes (datawindow adwtocheck);
/* 
* Funktion:			of_get_computes
* Beschreibung: 	
* Besonderheit: 	keine
*
* Argumente:
* 	datawindow 	adwToCheck
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			09.09.2010	Erstellung
*
* Return Codes:
*	 0		keine gefunden
*	> 0	anzahl gefundene computes
*
*/


// hilfsvariable
Long 		llRow, llLauf
String 	lsDWObjects, lsObject, lsEmpty[]

// erstmal das ziel leeren
this.isColumn = lsEmpty
this.isBand = lsEmpty
this.isColType = lsEmpty
llRow = 0

// alle datawindow-objecte holen
lsDWObjects = adwToCheck.Describe("datawindow.objects")
// den string in die einzelnen objects zerlegen
for llLauf = 1 to len(lsDWObjects)
	if Mid(lsDWObjects, llLauf, 1) <> char(9) then
		lsObject += Mid(lsDWObjects, llLauf, 1)
	else
		if adwToCheck.Describe(lsObject + ".type") = "compute" then
			llRow += 1
			this.isColumn[llRow] = lsObject
			this.isBand[llRow] = adwToCheck.Describe(lsObject + ".band")
			this.isColType[llRow] = adwToCheck.Describe(lsObject + ".Coltype")
		end if
		lsObject = ""
	end if	
next

return llRow

end function

public function long of_reset_computes ();
/* 
* Funktion:			of_reset_computes
* Beschreibung: 	
* Besonderheit: 	keine
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			09.09.2010	Erstellung
*
* Return Codes:
*	 0		immer
*
*/


// hilfsvariable
String 	lsEmpty[]

// erstmal das ziel leeren
this.isColumn = lsEmpty
this.isBand = lsEmpty
this.isColType = lsEmpty

return 0

end function

public function long of_get_computes (datastore adstocheck);
/* 
* Funktion:			of_get_computes
* Beschreibung: 	
* Besonderheit: 	keine
*
* Argumente:
* 	datastore 		adsToCheck
*
* Aenderungshistorie:
* 	Version 		Wer				Wann			Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel			09.09.2010	Erstellung
*
* Return Codes:
*	 0		keine gefunden
*	> 0	anzahl gefundene computes
*
*/


// hilfsvariable
Long 		llRow, llLauf
String 	lsDWObjects, lsObject, lsEmpty[]

// erstmal das ziel leeren
this.isColumn = lsEmpty
this.isBand = lsEmpty
this.isColType = lsEmpty
llRow = 0

// alle datawindow-objecte holen
lsDWObjects = adsToCheck.Describe("datawindow.objects")
// den string in die einzelnen objects zerlegen
for llLauf = 1 to len(lsDWObjects)
	if Mid(lsDWObjects, llLauf, 1) <> char(9) then
		lsObject += Mid(lsDWObjects, llLauf, 1)
	else
		if adsToCheck.Describe(lsObject + ".type") = "compute" then
			llRow += 1
			this.isColumn[llRow] = lsObject
			this.isBand[llRow] = adsToCheck.Describe(lsObject + ".band")
			this.isColType[llRow] = adsToCheck.Describe(lsObject + ".Coltype")
		end if
		lsObject = ""
	end if	
next

return llRow

end function

on uo_format_mandant.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_format_mandant.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

