HA$PBExportHeader$uo_cbase_functions.sru
$PBExportComments$Sammlung verschiedener Funktionen
forward
global type uo_cbase_functions from nonvisualobject
end type
end forward

global type uo_cbase_functions from nonvisualobject
end type
global uo_cbase_functions uo_cbase_functions

type prototypes
//Cryptfunktionen
FUNCTION boolean CryptBinaryToString(blob pbBinary, ulong cbBinary, ulong dwFlags, REF string pszString, REF ulong pcchString) LIBRARY "crypt32.dll" ALIAS FOR "CryptBinaryToStringA"
FUNCTION boolean CryptStringToBinary(string pszString, ulong cchString, ulong dwFlags, REF blob pbBinary, REF ulong pcbBinary, REF ulong pdwSkip, REF ulong pdwFlags) LIBRARY "crypt32.dll" ALIAS FOR "CryptStringToBinaryA"
end prototypes

type variables
//Konstanten f$$HEX1$$fc00$$ENDHEX$$r decrypt / encrypt
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
public function string of_decode_blob (blob ab_blob)
public function string of_get_temp_path ()
public function integer of_log (string arg_loguser, string arg_msg)
end prototypes

public function string of_decode_blob (blob ab_blob);// -----------------------------------------------------------------------------
// SCRIPT:    of_decode_blob
//
// PURPOSE:    Encode a blob to Base64 
//
// ARGUMENTS:  arg_bblob			- The blob to be decrypted

//
// RETURN:		String containing the decrypted data.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 05.10.2010	Klaus F$$HEX1$$f600$$ENDHEX$$rster		Initial Coding
// -----------------------------------------------------------------------------
String ls_return

String ls_encoded
ULong lul_len, lul_buflen
Boolean lb_rtn

lul_len = Len(ab_blob)
lul_buflen = lul_len * 2
ls_encoded = Space(lul_buflen)

lb_rtn = CryptBinaryToString(ab_blob, lul_len, CRYPT_STRING_BASE64, ls_encoded, lul_buflen)

IF NOT lb_rtn THEN
    ls_encoded = "Encode error"
ELSE
    // remove the last two chr(0)!
    ls_encoded = Left(ls_encoded, len(ls_encoded) - 2)
END IF

return ls_encoded
end function

public function string of_get_temp_path ();// -----------------------------------
// diese Funktion liefert das Temp-
// Verzeichnis
// -----------------------------------
String 	sTempPath, sBuffer
Long		lLen, lRet, I


// sTempPath = "c:\Temp\CBASE\"
sTempPath = ProfileString("CBASE_DOCUMENT_ENGINE.ini", "Misc", "TempPath", "c:\temp\cbase\")

return sTempPath	
end function

public function integer of_log (string arg_loguser, string arg_msg);// --------------------------------------------------------------------------------
// Methode: f_log (Function)
// Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
// --------------------------------------------------------------------------------
// Argument(e):
// string smsg
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung:
//
//			LogFile schreiben
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  26.10.2010	            Klaus F$$HEX1$$f600$$ENDHEX$$rster        Erstellung
//
// --------------------------------------------------------------------------------

integer iFile
String	lsLogPath

return 0

//lsLogPath = ProfileString("CBASE_DOCUMENT_ENGINE.ini", "Misc", "LogPath", "c:\temp\cbase\")
//
//If isnull(sinstance) or trim(sinstance) = "" then sinstance = "NOINSTANCE"
//iFile = FileOpen(lsLogPath + sinstance + "_" + string(Today(), "yyyymmdd") + "_" +  "cbase_document_engine" + ".log", LineMode!, Write!, Shared!)
//// sLogPath + sinstance + "_" + string(Today(), "yyyymmdd") + "_" +  "cbase_document_engine"  + ".log"
//FileWrite(iFile, "[" + string(today(), "dd.mm.yyyy") + "-" + string(now(), "hh:mm:ss") + "] " + arg_Msg)
//FileClose(iFile)

return 0
end function

on uo_cbase_functions.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cbase_functions.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

