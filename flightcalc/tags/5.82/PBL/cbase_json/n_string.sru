HA$PBExportHeader$n_string.sru
$PBExportComments$Sammlung verschiedener Funktionen
forward
global type n_string from nonvisualobject
end type
end forward

global type n_string from nonvisualobject
end type
global n_string n_string

type prototypes
// crypt32.dll
FUNCTION boolean CryptBinaryToString(blob pbBinary, ulong cbBinary, ulong dwFlags, REF string pszString, REF ulong pcchString) LIBRARY "crypt32.dll" ALIAS FOR "CryptBinaryToStringA;Ansi"
FUNCTION boolean CryptStringToBinary(string pszString, ulong cchString, ulong dwFlags, REF blob pbBinary, REF ulong pcbBinary, REF ulong pdwSkip, REF ulong pdwFlags) LIBRARY "crypt32.dll" ALIAS FOR "CryptStringToBinaryA;Ansi"

end prototypes

type variables
Public:
// Konstanten f$$HEX1$$fc00$$ENDHEX$$r decrypt / encrypt
constant ulong CRYPT_STRING_BASE64HEADER        = 0  //Base64, with headers
constant ulong CRYPT_STRING_BASE64              = 1  //Base64, without headers
constant ulong CRYPT_STRING_BINARY              = 2  //Pure binary copy
constant ulong CRYPT_STRING_BASE64REQUESTHEADER = 3  //Base64, with request beginning and ending headers
constant ulong CRYPT_STRING_HEX                 = 4  //Hexadecimal only
constant ulong CRYPT_STRING_HEXASCII            = 5  //Hexadecimal, with ASCII character display
constant ulong CRYPT_STRING_BASE64X509CRLHEADER = 9  //Base64, with X.509 CRL beginning and ending headers  
constant ulong CRYPT_STRING_HEXADDR             = 10 //Hexadecimal, with address display
constant ulong CRYPT_STRING_HEXASCIIADDR        = 11 //Hexadecimal, with ASCII character and address display
constant ulong CRYPT_STRING_HEXRAW              = 12 //A raw hex string. WinServer 2K3, WinXP:  This value is not supported

end variables

forward prototypes
public subroutine of_split (string as_source, string as_delimiter, ref string as_target[])
public function string of_replaceall (string as_oldstring, string as_findstr, string as_replace)
public function integer of_find ()
public function integer of_merge (string as_values_1[], string as_values_2[], ref string rs_merged_values[])
public function integer of_match_index (string as_primary[], string as_match[], ref long rl_matched_index[])
public function long of_string2array (string as_string, string as_separator, ref long al_outputarray[])
public function long of_string2array (string as_string, string as_separator, ref string as_outputarray[])
public function integer of_get_arrayindex (string as_array[], string as_value)
end prototypes

public subroutine of_split (string as_source, string as_delimiter, ref string as_target[]);/*
* Objekt : uo_cbase_functions
* Methode: of_split (Function)
* Autor  : Dirk Bunk
* Datum  : 08.11.2011
*
* Argument(e):
*   as_source    Der String, der gesplittet werden soll.
*   as_delimiter Der Trenn-String, der f$$HEX1$$fc00$$ENDHEX$$rs Splitten benutzt werden soll.
*   as_target[]  Das Array, in das die Ergebnisse geschrieben werden sollen.
*
* Beschreibung: Splittet einen String anhand eines Trenn-Strings auf und f$$HEX1$$fc00$$ENDHEX$$llt ein $$HEX1$$fc00$$ENDHEX$$bergebenes Array.
*               Wird der Trenn-String nicht gefunden, steht im Array der komplette Ursprungs-String.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    08.11.2011    Formatierung
*
* Return: 
*   none
*/

string ls_empty[]
long ll_pos

// Das Ziel-Array leeren
as_target = ls_empty

// Den Ursprungs-String nach dem Trenn-String durchsuchen und die gefundenen Teile ins Array schreiben
do
	ll_pos = Pos(as_source, as_delimiter)
	
	if ll_pos > 0 then
		as_target[UpperBound(as_target) + 1] = Left(as_source, ll_pos - 1)
		as_source = Mid(as_source, ll_pos + Len(as_delimiter))
	else
		as_target[UpperBound(as_target) + 1] = as_source
	end if
loop while(ll_pos > 0)
end subroutine

public function string of_replaceall (string as_oldstring, string as_findstr, string as_replace);/*
* Objekt : uo_cbase_functions
* Methode: of_replaceall (Function)
* Autor  : ???
* Datum  : ???
*
* Argument(e):
*   as_oldstring    	Die Zeichenfolge, in der gesucht wird.
*   as_findstr    	Die Such-Zeichenfolge.
*   as_replace      	Die Ersetzungs-Zeichenfolge.
*
* Beschreibung: Ersetzt eine gesuchte Zeichenfolge in einer Zeichenfolge mit einer anderen Zeichenfolge.
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        ???          ???           Erstellung
*   1.1        Dirk Bunk    01.08.2011    Header hinzugef$$HEX1$$fc00$$ENDHEX$$gt
*
* Return: 
*   Die ge$$HEX1$$e400$$ENDHEX$$nderte Zeichenfolge
*/

String ls_newstring
Long ll_findstr, ll_replace, ll_pos

// get length of strings
ll_findstr = Len(as_findstr)
ll_replace = Len(as_replace)

// find first occurrence
ls_newstring = as_oldstring
ll_pos = Pos(ls_newstring, as_findstr)

Do While ll_pos > 0
	// replace old with new
	ls_newstring = Replace(ls_newstring, ll_pos, ll_findstr, as_replace)
	// find next occurrence
	ll_pos = Pos(ls_newstring, as_findstr, (ll_pos + ll_replace))
Loop

Return ls_newstring
end function

public function integer of_find ();/*************************************************************
* Objekt : n_string
* Methode: of_find (Function)
* Autor  : Alex Schaab [U524036]
* Datum  : 17.10.2013
*
* Argument(e):
* 	 none ~
*
* Beschreibung:
* 	 Liefert die Position und L$$HEX1$$e400$$ENDHEX$$nge des gesuchten Strings
*
* Return:
* 	 integer ~
*
*************************************************************
* Modifikationen:
* Datum				Version			Autor					Kommentar
*-----------------------------------------------------------------------------------------------
* 17.10.2013		1.0				Alex Schaab			Erstellung
*
*************************************************************/

return 0
end function

public function integer of_merge (string as_values_1[], string as_values_2[], ref string rs_merged_values[]);/*************************************************************
* Objekt : n_string
* Methode: of_merge
* Autor  : Alex Schaab [AS]
* Datum  : 14.08.2012
*
* Argument(e):
* none
*
* Beschreibung: Vergleicht beide String-Arrays und speichert alle Spalten, die beide Arrays beinhalten in die Referenz
*
* Return: integer
*
**************************************************************
*  Modifikationen:
*  Datum    		Version        Autor              Kommentar
* --------------------------------------------------------------------------------
* 14.08.2012	1.0          	Alex Schaab		Erstellung
*
*************************************************************/

long ll_cnt, ll_cnt2
String ls_null[]
rs_merged_values = ls_null


//Loop through the Arrays
for ll_cnt = 1 to Upperbound(as_values_1)
	for ll_cnt2 = 1 to Upperbound(as_values_2)
		if as_values_1[ll_cnt] = as_values_2[ll_cnt2] then rs_merged_values[Upperbound(rs_merged_values) + 1] = as_values_1[ll_cnt]
	Next
Next

return ll_cnt * ll_cnt2
end function

public function integer of_match_index (string as_primary[], string as_match[], ref long rl_matched_index[]);/*************************************************************
* Objekt : n_string
* Methode: of_merge
* Autor  : Alex Schaab [AS]
* Datum  : 14.08.2012
*
* Argument(e):
* none
*
* Beschreibung: Vergleicht beide String-Arrays und speichert alle Spalten-Indizes des ersten Arrays, die beide Arrays beinhalten in die Referenz
*
* Return: integer
*
**************************************************************
*  Modifikationen:
*  Datum    		Version        Autor              Kommentar
* --------------------------------------------------------------------------------
* 14.08.2012	1.0          	Alex Schaab		Erstellung
*
*************************************************************/

long ll_cnt, ll_cnt2
long ll_null[]
rl_matched_index = ll_null


//Loop through the Arrays
for ll_cnt = 1 to Upperbound(as_primary)
	for ll_cnt2 = 1 to Upperbound(as_match)
		if as_primary[ll_cnt] = as_match[ll_cnt2] then rl_matched_index[Upperbound(rl_matched_index) + 1] = ll_cnt
	Next
Next

return ll_cnt * ll_cnt2
end function

public function long of_string2array (string as_string, string as_separator, ref long al_outputarray[]);
/* 
* Function: 			of_string2array
* Beschreibung: 	Splittet den $$HEX1$$fc00$$ENDHEX$$bergebenen String in ein Array vom Typ Long
* Besonderheit: 	...
*
* Argumente:
* 		as_string			String, der gesplittet werden soll
*		as_separator	
*		al_outputarray	
*
* Aenderungshistorie:
* 	Version 	Wer							Wann				Was und warum
*	1.0 		Thomas Schaefer			21.02.2014		Erstellung ($$HEX1$$fc00$$ENDHEX$$bernommen aus CBASE)
*
* Return Codes:
*	 long		Anzahl der Array-Eintr$$HEX1$$e400$$ENDHEX$$ge
*/

Long ll_PosEnd, ll_PosStart = 1, ll_SeparatorLen, ll_Counter = 1

if UpperBound(al_OutputArray) > 0 then al_OutputArray = {0}
ll_SeparatorLen = Len(as_Separator)

ll_PosEnd = Pos(as_String, as_Separator, 1)

do while ll_PosEnd > 0
     al_OutputArray[ll_Counter] = Long(Mid(as_String, ll_PosStart, ll_PosEnd - ll_PosStart))
     ll_PosStart = ll_PosEnd + ll_SeparatorLen
     ll_PosEnd = Pos(as_String, as_Separator, ll_PosStart)
     ll_Counter++
loop

al_OutputArray[ll_Counter] = Long(Right(as_String, Len(as_String) - ll_PosStart + 1))

Return ll_Counter

end function

public function long of_string2array (string as_string, string as_separator, ref string as_outputarray[]);
/* 
* Function: 			of_string2array
* Beschreibung: 	Splittet den $$HEX1$$fc00$$ENDHEX$$bergebenen String in ein Array vom Typ Long
* Besonderheit: 	...
*
* Argumente:
* 		as_string			String, der gesplittet werden soll
*		as_separator	
*		al_outputarray	
*
* Aenderungshistorie:
* 	Version 	Wer							Wann				Was und warum
*	1.0 		Thomas Schaefer			21.02.2014		Erstellung ($$HEX1$$fc00$$ENDHEX$$bernommen aus CBASE)
*
* Return Codes:
*	 long		Anzahl der Array-Eintr$$HEX1$$e400$$ENDHEX$$ge
*/

long ll_PosEnd, ll_PosStart = 1, ll_SeparatorLen, ll_Counter = 1

if UpperBound(as_OutputArray) > 0 then as_OutputArray = {""}
ll_SeparatorLen = Len(as_Separator)

ll_PosEnd = Pos(as_String, as_Separator, 1)

do while ll_PosEnd > 0
     as_OutputArray[ll_Counter] = Mid(as_String, ll_PosStart, ll_PosEnd - ll_PosStart)
     ll_PosStart = ll_PosEnd + ll_SeparatorLen
     ll_PosEnd = Pos(as_String, as_Separator, ll_PosStart)
     ll_Counter++
loop

as_OutputArray[ll_Counter] = Right(as_String, Len(as_String) - ll_PosStart + 1)

return ll_Counter

end function

public function integer of_get_arrayindex (string as_array[], string as_value);/* 
* Function: 			of_get_arrayindex
* Beschreibung: 	gibt den ersten Index im Array zur$$HEX1$$fc00$$ENDHEX$$ck, an dem as_value gefunden wurde (oder -1, wenn nicht gefunden)
* Besonderheit: 	...
*
* Argumente:
* 		arg_name 	Beschreibung
*
* Aenderungshistorie:
* 	Version 	Wer						Wann				Was und warum
*	1.0 		Schaefer					20.01.2015		Erstellung
*
* Return Codes:
*	 ...
*/

Integer		li_i
Integer		li_return = -1

FOR li_i = 1 TO UpperBound(as_array)
	IF as_array[li_i] = as_value THEN
		li_return = li_i
		EXIT
	END IF
NEXT

Return li_return

end function

on n_string.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_string.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

