HA$PBExportHeader$uo_checknull.sru
$PBExportComments$container f$$HEX1$$fc00$$ENDHEX$$r checknull-funktionen f$$HEX1$$fc00$$ENDHEX$$r unterschiedliche formate
forward
global type uo_checknull from nonvisualobject
end type
end forward

global type uo_checknull from nonvisualobject autoinstantiate
end type

forward prototypes
public function integer of_checknull (integer aiinteger2check)
public function long of_checknull (long allong2check)
public function string of_checknull (string asstring2check)
public function date of_checknull (date addate2check)
public function datetime of_checknull (datetime adtdate2check)
public function decimal of_checknull (decimal adclong2check)
public function time of_checknull (time attime2check)
end prototypes

public function integer of_checknull (integer aiinteger2check);
/* 
* Function: 			of_checknull
* Beschreibung: 	wandelt null-value in einem integer in eine 0
* Besonderheit: 	
*
* Argumente:
* 	integer 		aiInteger2Check 	zu pr$$HEX1$$fc00$$ENDHEX$$fender wert
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		18.01.2011		Erstellung
*
* Return Codes:
*	 aiInteger2Check	wenn kein null-value
*	 0						wenn null-value
*/

// hilfsvariable
Integer 	liRet = 0

// wenn kein null-value, dann $$HEX1$$fc00$$ENDHEX$$bernehmen
if not IsNull(aiInteger2Check) then liRet = aiInteger2Check

return liRet

end function

public function long of_checknull (long allong2check);
/* 
* Function: 			of_checknull
* Beschreibung: 	wandelt null-value in einem long in eine 0
* Besonderheit: 	
*
* Argumente:
* 	long 		alLong2Check 	zu pr$$HEX1$$fc00$$ENDHEX$$fender wert
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		18.01.2011		Erstellung
*
* Return Codes:
*	 alLong2Check		wenn kein null-value
*	 0						wenn null-value
*/

// hilfsvariable
Long 	llRet = 0

// wenn kein null-value, dann $$HEX1$$fc00$$ENDHEX$$bernehmen
if not IsNull(alLong2Check) then llRet = alLong2Check

return llRet

end function

public function string of_checknull (string asstring2check);
/* 
* Function: 			of_checknull
* Beschreibung: 	wandelt null-value in einem string in einen leerstring
* Besonderheit: 	
*
* Argumente:
* 	string 		asString2Check 	zu pr$$HEX1$$fc00$$ENDHEX$$fender string
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		18.01.2011		Erstellung
*
* Return Codes:
*	 asString2Check	wenn kein null-value
*	 ""						wenn null-value
*/

// hilfsvariable
String 	lsRet = ""

// wenn kein null-value, dann $$HEX1$$fc00$$ENDHEX$$bernehmen
if not IsNull(asString2Check) then lsRet = asString2Check

return lsRet

end function

public function date of_checknull (date addate2check);
/* 
* Function: 			of_checknull
* Beschreibung: 	wandelt null-value in einem date in das tagesdatum
* Besonderheit: 	
*
* Argumente:
* 	date 		adDate2Check 		zu pr$$HEX1$$fc00$$ENDHEX$$fendes date
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		18.01.2011		Erstellung
*
* Return Codes:
*	 adDate2Check	wenn kein null-value
*	 heute			wenn null-value
*/

// hilfsvariable
Date 	ldRet = today()

// wenn kein null-value, dann $$HEX1$$fc00$$ENDHEX$$bernehmen
if not IsNull(adDate2Check) then ldRet = adDate2Check

return ldRet

end function

public function datetime of_checknull (datetime adtdate2check);
/* 
* Function: 			of_checknull
* Beschreibung: 	wandelt null-value in einem datetime in das tagesdatum plus aktuelle zeit
* Besonderheit: 	
*
* Argumente:
* 	datetime 		adtDate2Check 		zu pr$$HEX1$$fc00$$ENDHEX$$fendes datetime
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		18.01.2011		Erstellung
*
* Return Codes:
*	 adtDate2Check		wenn kein null-value
*	 heute + jetzt		wenn null-value
*/

// hilfsvariable
Datetime 	ldtRet = datetime(date(today()), time(now()))

// wenn kein null-value, dann $$HEX1$$fc00$$ENDHEX$$bernehmen
if not IsNull(adtDate2Check) then ldtRet = adtDate2Check

return ldtRet

end function

public function decimal of_checknull (decimal adclong2check);
/* 
* Function: 			of_checknull
* Beschreibung: 	wandelt null-value in einem long in eine 0
* Besonderheit: 	
*
* Argumente:
* 	decimal 		adcLong2Check 	zu pr$$HEX1$$fc00$$ENDHEX$$fender wert
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		18.01.2011		Erstellung
*
* Return Codes:
*	 alLong2Check		wenn kein null-value
*	 0						wenn null-value
*/

// hilfsvariable
Decimal 	ldcRet = 0.0

// wenn kein null-value, dann $$HEX1$$fc00$$ENDHEX$$bernehmen
if not IsNull(adcLong2Check) then ldcRet = adcLong2Check

return ldcRet

end function

public function time of_checknull (time attime2check);
/* 
* Function: 			of_checknull
* Beschreibung: 	wandelt null-value in einem long in eine 0
* Besonderheit: 	
*
* Argumente:
* 	time 		atTime2Check 	zu pr$$HEX1$$fc00$$ENDHEX$$fender wert
*
* Aenderungshistorie:
* 	Version 		Wer			Wann				Was und warum
*	1.0 			M.N$$HEX1$$fc00$$ENDHEX$$ndel		18.01.2011		Erstellung
*
* Return Codes:
*	 atTime2Check		wenn kein null-value
*	 0						wenn null-value
*/

// hilfsvariable
Time 	ltRet = now()

// wenn kein null-value, dann $$HEX1$$fc00$$ENDHEX$$bernehmen
if not IsNull(atTime2Check) then ltRet = atTime2Check

return ltRet

end function

on uo_checknull.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_checknull.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

