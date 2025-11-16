HA$PBExportHeader$uo_cryptologin.sru
forward
global type uo_cryptologin from nonvisualobject
end type
end forward

global type uo_cryptologin from nonvisualobject autoinstantiate
end type

type prototypes
Function ulong GetLastError( ) Library "kernel32.dll"

FUNCTION boolean CryptBinaryToString ( &
    Blob pbBinary, &
    ulong cbBinary, &
    ulong dwFlags, &
    Ref string pszString, &
    Ref ulong pcchString ) &
LIBRARY "crypt32.dll" ALIAS FOR "CryptBinaryToStringA"

FUNCTION boolean CryptStringToBinary ( &
    string pszString, &
    ulong cchString, &
    ulong dwFlags, &
    Ref blob pbBinary, &
    Ref ulong pcbBinary, &
    Ref ulong pdwSkip, &
    Ref ulong pdwFlags ) &
LIBRARY "crypt32.dll" ALIAS FOR "CryptStringToBinaryA"

Function ulong FormatMessage( &
	ulong dwFlags, &
	ulong lpSource, &
	ulong dwMessageId, &
	ulong dwLanguageId, &
	Ref string lpBuffer, &
	ulong nSize, &
	ulong Arguments &
	) Library "kernel32.dll" Alias For "FormatMessageW"

Function ulong CreateFile ( &
	string lpFileName, &
	ulong dwDesiredAccess, &
	ulong dwShareMode, &
	ulong lpSecurityAttributes, &
	ulong dwCreationDisposition, &
	ulong dwFlagsAndAttributes, &
	ulong hTemplateFile &
	) Library "kernel32.dll" Alias For "CreateFileW"

Function boolean CloseHandle ( &
	ulong hObject &
	) Library "kernel32.dll"

Function boolean ReadFile ( &
	ulong hFile, &
	Ref Blob lpBuffer, &
	ulong nNumberOfBytesToRead, &
	Ref ulong lpNumberOfBytesRead, &
	ulong lpOverlapped &
	) Library "kernel32.dll"

Function boolean WriteFile ( &
	ulong hFile, &
	blob lpBuffer, &
	ulong nNumberOfBytesToWrite, &
	Ref ulong lpNumberOfBytesWritten, &
	ulong lpOverlapped &
	) Library "kernel32.dll"

Function Boolean CryptAcquireContext ( &
	Ref ulong phProv, &
	string pszContainer, &
	string pszProvider, &
	ulong dwProvType, &
	ulong dwFlags &
	) Library "advapi32.dll" Alias For "CryptAcquireContextW"

Function Boolean CryptCreateHash ( &
	ulong hProv, &
	ulong Algid, &
	ulong hKey, &
	ulong dwFlags, &
	Ref ulong phHash &
	) Library "advapi32.dll" Alias For "CryptCreateHash"

Function Boolean CryptDecrypt ( &
	ulong hKey, &
	ulong hHash, &
	boolean Final, &
	ulong dwFlags, &
	Ref blob pbData, &
	Ref ulong pdwDataLen &
	) Library "advapi32.dll" Alias For "CryptDecrypt"

Function Boolean CryptDeriveKey ( &
	ulong hProv, &
	ulong Algid, &
	ulong hBaseData, &
	ulong dwFlags, &
	Ref ulong phKey &
	) Library "advapi32.dll" Alias For "CryptDeriveKey"

Function Boolean CryptDestroyHash ( &
	ulong hHash &
	) Library "advapi32.dll" Alias For "CryptDestroyHash"

Function Boolean CryptDestroyKey ( &
	ulong hKey &
	) Library "advapi32.dll" Alias For "CryptDestroyKey"

Function Boolean CryptEncrypt ( &
	ulong hKey, &
	ulong hHash, &
	boolean Final, &
	ulong dwFlags, &
	Ref blob pbData, &
	Ref ulong pdwDataLen, &
	ulong dwBufLen &
	) Library "advapi32.dll" Alias For "CryptEncrypt"

Function Boolean CryptHashData ( &
	ulong hHash, &
	string pbData, &
	ulong dwDataLen, &
	ulong dwFlags &
	) Library "advapi32.dll" Alias For "CryptHashData;Ansi"

Function Boolean CryptReleaseContext ( &
	ulong hProv, &
	ulong dwFlags &
	) Library "advapi32.dll" Alias For "CryptReleaseContext"

Function Boolean CryptGetDefaultProvider ( &
	ulong dwProvType, &
	ulong pdwReserved, &
	ulong dwFlags, &
	Ref string pszProvName, &
	Ref ulong pcbProvName &
	) Library "advapi32.dll" Alias For "CryptGetDefaultProviderW"

Function Boolean CryptEnumProviders ( &
	ulong dwIndex, &
	ulong pdwReserved, &
	ulong dwFlags, &
	Ref ulong pdwProvType, &
	Ref string pszProvName, &
	Ref ulong pcbProvName &
	) Library "advapi32.dll" Alias For "CryptEnumProvidersW"

Function Boolean CryptEnumProviders ( &
	ulong dwIndex, &
	ulong pdwReserved, &
	ulong dwFlags, &
	Ref ulong pdwProvType, &
	ulong pszProvName, &
	Ref ulong pcbProvName &
	) Library "advapi32.dll" Alias For "CryptEnumProvidersW"

end prototypes

type variables
Private:

// constants for CreateFile API function
Constant ULong INVALID_HANDLE_VALUE = -1
Constant ULong GENERIC_READ     = 2147483648
Constant ULong GENERIC_WRITE    = 1073741824
Constant ULong FILE_SHARE_READ  = 1
Constant ULong FILE_SHARE_WRITE = 2
Constant ULong CREATE_NEW			= 1
Constant ULong CREATE_ALWAYS		= 2
Constant ULong OPEN_EXISTING		= 3
Constant ULong OPEN_ALWAYS			= 4
Constant ULong TRUNCATE_EXISTING = 5

// constants for cypto api
Constant String KEY_CONTAINER 	= "MyKeyContainer"
Constant ULong CALG_MD5				= 32771
Constant ULong CALG_RC4				= 26625
Constant ULong ENCRYPT_ALGORITHM = CALG_RC4
Constant ULong CRYPT_NEWKEYSET   = 8
Constant ULong ERROR_MORE_DATA	= 234

// active Cryptographic service provider
String is_cryptoservice

// Passwortkey mit dem die Kennw$$HEX1$$f600$$ENDHEX$$rter verschl$$HEX1$$fc00$$ENDHEX$$sselt werden. (Darf nicht ge$$HEX1$$e400$$ENDHEX$$ndert werden)
Constant String is_crypto_key = "LSYcbaseCrypto2008"

// Verwendeter Treiber f$$HEX1$$fc00$$ENDHEX$$r die Verschl$$HEX1$$fc00$$ENDHEX$$sselung. (Darf nicht ge$$HEX1$$e400$$ENDHEX$$ndert werden)
Constant String is_cryptoprovider = "Microsoft Strong Cryptographic Provider"

//###################################################################################################
// Hier muss noch der Username und Passwort f$$HEX1$$fc00$$ENDHEX$$r den Testuser eingetragen werden, der dann auf jeder Instanze existieren muss.
//###################################################################################################
string is_pwd_user = "SYS_PWD_CHANGE"
string is_pwd_pwd = "test"
//###################################################################################################

//###################################################################################################
// 05.10.2010
// Constanten f$$HEX1$$fc00$$ENDHEX$$r decrypt / encrypt
//###################################################################################################
CONSTANT Ulong CRYPT_STRING_BASE64HEADER = 0
// Base64, without headers
CONSTANT Ulong CRYPT_STRING_BASE64 = 1
// Pure binary copy
CONSTANT Ulong CRYPT_STRING_BINARY = 2
// Base64, with request beginning and ending headers
CONSTANT Ulong CRYPT_STRING_BASE64REQUESTHEADER = 3
// Hexadecimal only
CONSTANT Ulong CRYPT_STRING_HEX = 4
//  Hexadecimal, with ASCII character display
CONSTANT Ulong CRYPT_STRING_HEXASCII = 5 
// Base64, with X.509 CRL beginning and ending headers
CONSTANT Ulong CRYPT_STRING_BASE64X509CRLHEADER = 9     
// Hexadecimal, with address display
CONSTANT Ulong CRYPT_STRING_HEXADDR = 10    
// Hexadecimal, with ASCII character and address display
CONSTANT Ulong CRYPT_STRING_HEXASCIIADDR = 11   
// A raw hex string. WinServer 2K3, WinXP:  This value is not supported.
CONSTANT Ulong CRYPT_STRING_HEXRAW = 12 


Public:
//######################################################
//Variablen f$$HEX1$$fc00$$ENDHEX$$r die Passwortpolicy
//######################################################

//Anzahl Tage, nach dem ein Initalpasswort ungueltig wird
integer	ii_days_for_change_initpwd = 30

//Anzahl Tage in denen ein Passwort ge$$HEX1$$e400$$ENDHEX$$ndert werden mu$$HEX1$$df00$$ENDHEX$$
integer 	ii_maxdays_for_change = 60

//Anzahl Fehlversuche bis AccountLock
integer  	ii_max_wrong_logins = 5

//Anzahl Passw$$HEX1$$f600$$ENDHEX$$rter in der Passworthistory
integer  	ii_max_reuse_paasword = 10

//Zeichenfolge der erlaubten Sonderzeichen
string is_allowed_symbols = "@$"

//Mindestpasswortl$$HEX1$$e400$$ENDHEX$$nge
integer ii_min_password_length = 7

//Maximale Anzahl an Versuchen nach Passwortablauf
integer ii_max_grace_Logins

//Feld CPASSWORD ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
integer ii_use_cpassword 

//Sperre nach x Tagen Inaktivit$$HEX1$$e400$$ENDHEX$$t
integer ii_lock_after_inactivity

//######################################################
// Provider Types
Constant ULong PROV_RSA_FULL			= 1
Constant ULong PROV_RSA_SIG			= 2
Constant ULong PROV_DSS					= 3
Constant ULong PROV_FORTEZZA			= 4
Constant ULong PROV_MS_EXCHANGE		= 5
Constant ULong PROV_SSL					= 6
Constant ULong PROV_RSA_SCHANNEL		= 12
Constant ULong PROV_DSS_DH				= 13
Constant ULong PROV_EC_ECDSA_SIG		= 14
Constant ULong PROV_EC_ECNRA_SIG		= 15
Constant ULong PROV_EC_ECDSA_FULL	= 16
Constant ULong PROV_EC_ECNRA_FULL	= 17
Constant ULong PROV_SPYRUS_LYNKS		= 20


// Logpath , if set then suppress messagebox
string is_LogPath =""
string is_error = ""
end variables

forward prototypes
public subroutine of_getlasterror (ref unsignedlong aul_error, ref string as_msgtext)
private function blob of_encryptdecrypt (blob ablob_data, string as_password, boolean ab_encrypt)
public function string of_getdefaultprovider ()
public function blob of_encrypt (blob ablob_data, string as_password)
public function blob of_decrypt (blob ablob_data, string as_password)
public function string of_encrypt (string as_data, string as_password, boolean ab_removebad)
public function string of_decrypt (string as_data, string as_password, boolean ab_removebad)
public function unsignedlong of_readfile (string as_filename, ref blob ablob_contents)
public function integer of_writefile (string as_filename, blob ablob_filedata)
public subroutine of_setprovider (string as_cryptoservice)
public function string of_encrypt (string as_data, string as_password)
public function string of_decrypt (string as_data, string as_password)
public function integer of_enumproviders (unsignedlong aul_dwtype, ref string as_provider[])
public function string of_encrypt (string as_data)
public function boolean of_wrong_pwd (string arg_user, string arg_cryptpwd, transaction arg_sqlca)
public subroutine of_lock_account (string arg_user, string arg_cryptpwd, transaction arg_sqlca)
public subroutine of_pwd_prot (string arg_user, string arg_cryptpwd, integer arg_was, transaction arg_sqlca)
public subroutine of_get_passwordrules (transaction arg_sqlca, string arg_mandant)
public function integer of_change_password (string arg_user, string arg_mandant, string arg_password)
public subroutine of_login_ok (string arg_user, string arg_pwd, string arg_cryptpwd, transaction arg_sqlca)
public function string of_decrypt (string as_data)
public subroutine of_set_passwordrules (transaction arg_sqlca, string arg_mandant)
public function integer of_grace_logins (string arg_user, string arg_pwd, string arg_cryptpwd, integer arg_grace_logins, transaction arg_sqlca)
public function integer outputmsg (string ssource, string stitle, string smsg)
public subroutine of_setlogpath (string as_path)
public function integer outputmsgtrans (string ssource, string stitle, string smsg)
public function integer of_check_pwd (string arg_user, string arg_pwd, string arg_server, ref string arg_retfehler)
public function integer of_check_pwd (string arg_user, string arg_pwd, ref transaction sqlca_temp, ref string arg_retfehler)
public function integer of_change_password (string arg_user, string arg_mandant, string arg_password, transaction arg_sqlca)
public function string of_encode_blob (blob arg_bblob)
end prototypes

public subroutine of_getlasterror (ref unsignedlong aul_error, ref string as_msgtext);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_GetLastError
//
// PURPOSE:    This function returns the most recent API error message.
//
// ARGUMENTS:  aul_error	- The error number ( by ref )
//					as_msgtext	- The error text ( by ref )
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Constant ULong FORMAT_MESSAGE_FROM_SYSTEM = 4096
Constant ULong LANG_NEUTRAL = 0
ULong lul_rtn

aul_error = GetLastError()

as_msgtext = Space(200)

lul_rtn = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, &
				aul_error, LANG_NEUTRAL, as_msgtext, 200, 0)

end subroutine

private function blob of_encryptdecrypt (blob ablob_data, string as_password, boolean ab_encrypt);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_EncryptDecrypt
//
// PURPOSE:    This function will encrypt/decrypt the blob passed to it. Both
//					encrypt/decrypt have the same api calls except one so they
//					are combined to save coding.
//
// ARGUMENTS:  ablob_data	- The blob to be decrypted
//					as_password	- The secret password
//
// RETURN:		Blob containing the decrypted data.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

ULong hCryptProv, hHash, hKey
ULong lul_datalen, lul_buflen, lul_error
Blob lblob_buffer, lblob_value
String ls_msgtext

// Get handle to CSP
If Not CryptAcquireContext(hCryptProv, &
				KEY_CONTAINER, is_cryptoservice, PROV_RSA_FULL, 0) Then
	If Not CryptAcquireContext(hCryptProv, &
					KEY_CONTAINER, is_cryptoservice, PROV_RSA_FULL, CRYPT_NEWKEYSET) Then
		of_GetLastError(lul_error, ls_msgtext)
		SignalError(lul_error, "CryptAcquireContext:~r~n~r~n" + ls_msgtext)
	End If
End If

// Create a hash object
If Not CryptCreateHash(hCryptProv, CALG_MD5, 0, 0, hHash) Then
	of_GetLastError(lul_error, ls_msgtext)
	SignalError(lul_error, &
		"CryptCreateHash:~r~n~r~n" + ls_msgtext)
End If

// Hash the password
If Not CryptHashData(hHash, as_password, Len(as_password), 0) Then
	of_GetLastError(lul_error, ls_msgtext)
	SignalError(lul_error, &
		"CryptHashData:~r~n~r~n" + ls_msgtext)
End If

// Derive a session key from the hash object
If Not CryptDeriveKey(hCryptProv, ENCRYPT_ALGORITHM, hHash, 0, hKey) Then
	of_GetLastError(lul_error, ls_msgtext)
	SignalError(lul_error, &
		"CryptDeriveKey:~r~n~r~n" + ls_msgtext)
End If

// allocate buffer space
lul_datalen = Len(ablob_data)
lblob_buffer = ablob_data + Blob(Space(8))
lul_buflen = Len(lblob_buffer)

If ab_encrypt Then
	// Encrypt data
	If CryptEncrypt(hKey, 0, True, 0, &
				lblob_buffer, lul_datalen, lul_buflen) Then
		lblob_value = BlobMid(lblob_buffer, 1, lul_datalen)
	Else
		of_GetLastError(lul_error, ls_msgtext)
		SignalError(lul_error, &
			"CryptEncrypt:~r~n~r~n" + ls_msgtext)
	End If
Else
	// Decrypt data
	If CryptDecrypt(hKey, 0, True, 0, lblob_buffer, lul_datalen) Then
		lblob_value = BlobMid(lblob_buffer, 1, lul_datalen)
	Else
		of_GetLastError(lul_error, ls_msgtext)
		SignalError(lul_error, &
			"CryptDecrypt:~r~n~r~n" + ls_msgtext)
	End If
End If

// Destroy session key
If hKey > 0 Then
	CryptDestroyKey(hKey)
End If

// Destroy hash object
If hHash > 0 Then
	CryptDestroyHash(hHash)
End If

// Release CSP handle
If hCryptProv > 0 Then
	CryptReleaseContext(hCryptProv, 0)
End If

Return lblob_value

end function

public function string of_getdefaultprovider ();// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_GetDefaultProvider
//
// PURPOSE:    This function will return the name of the default provider.
//
// RETURN:		String containing CSP name
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

String ls_provider, ls_msgtext
ULong lul_datalen = 256, lul_error
Constant ULong CRYPT_USER_DEFAULT = 2

ls_provider = Space(lul_datalen)

If Not CryptGetDefaultProvider(PROV_RSA_FULL, &
					0, CRYPT_USER_DEFAULT, ls_provider, lul_datalen) Then
	of_GetLastError(lul_error, ls_msgtext)
	SignalError(lul_error, &
		"CryptGetDefaultProvider:~r~n~r~n" + ls_msgtext)
End If

Return ls_provider

end function

public function blob of_encrypt (blob ablob_data, string as_password);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_Encrypt
//
// PURPOSE:    This function will encrypt the blob passed to it.
//
// ARGUMENTS:  ablob_data	- The blob to be encrypted
//					as_password	- The secret password
//
// RETURN:		Blob containing the encrypted data.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

// This function will encrypt the blob passed to it.

Blob lblob_encrypted

// encrypt the data
lblob_encrypted = this.of_EncryptDecrypt( &
								ablob_data, as_password, True)

Return lblob_encrypted

end function

public function blob of_decrypt (blob ablob_data, string as_password);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_Decrypt
//
// PURPOSE:    This function will decrypt the blob passed to it.
//
// ARGUMENTS:  ablob_data	- The blob to be decrypted
//					as_password	- The secret password
//
// RETURN:		Blob containing the decrypted data.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Blob lblob_decrypted

// decrypt the data
lblob_decrypted = this.of_EncryptDecrypt( &
								ablob_data, as_password, False)

Return lblob_decrypted

end function

public function string of_encrypt (string as_data, string as_password, boolean ab_removebad);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_Encrypt
//
// PURPOSE:    This function will encrypt the string passed to it.
//
// ARGUMENTS:  as_data			- The string to be decrypted
//					as_password		- The secret password
//					ab_removebad	- True = remove TAB, LF, CR from encrypted result
//										  by adding a number to the password and
//										  prepending it to the result.
//
// RETURN:		String containing the decrypted data.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Constant Char TAB = Char(9)	// Tab
Constant Char LF  = Char(10)	// Linefeed
Constant Char CR  = Char(13)	// Carriage Return
String ls_encrypted, ls_newpass, ls_msgtext
Blob lblob_data, lblob_encrypted
Integer li_count = 1

// encrypt the data
lblob_data = Blob(as_data, EncodingAnsi!)
lblob_encrypted = this.of_EncryptDecrypt( &
								lblob_data, as_password, True)
ls_encrypted = String(lblob_encrypted, EncodingAnsi!)

If ab_removebad Then
	// try again if result contains a bad character
	Do While Pos(ls_encrypted, LF,  1) > 0 &
			Or Pos(ls_encrypted, CR,  1) > 0 &
			Or Pos(ls_encrypted, TAB, 1) > 0 &
			Or Len(ls_encrypted) <> Len(as_data)
		// append counter to password
		If li_count = 1 Then
			li_count = 14
		Else
			If li_count = 255 Then
				ls_msgtext = "Unable to successfully encrypt this data"
				SignalError(999, &
					"of_EncryptData:~r~n~r~n" + ls_msgtext)
			Else
				li_count++
			End If
		End If
		ls_newpass = as_password + String(li_count)
		// try again to encrypt
		lblob_data = Blob(as_data, EncodingAnsi!)
		lblob_encrypted = this.of_EncryptDecrypt( &
										lblob_data, ls_newpass, True)
		ls_encrypted = String(lblob_encrypted, EncodingAnsi!)
	Loop
	// prepend attempt count
	If Len(ls_encrypted) > 0 Then
		ls_encrypted = Char(li_count) + ls_encrypted
	End If
End If

Return ls_encrypted

end function

public function string of_decrypt (string as_data, string as_password, boolean ab_removebad);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_Decrypt
//
// PURPOSE:    This function will decrypt the string passed to it.
//
// ARGUMENTS:  as_data			- The string to be decrypted
//					as_password		- The secret password
//					ab_removebad	- True = 1st character is a number to be
//										  added on to the password
//
// RETURN:		String containing the decrypted data.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

String ls_decrypted, ls_data, ls_newpass
Blob lblob_data, lblob_decrypted
Integer li_count

If ab_removebad Then
	// first char is attempt count
	ls_data = Mid(as_data, 2)
	// get attempt count
	li_count = Asc(Left(as_data, 1))
	If li_count = 1 Then
		// decrypt the data
		lblob_data = Blob(ls_data, EncodingAnsi!)
		lblob_decrypted = this.of_EncryptDecrypt( &
										lblob_data, as_password, False)
		ls_decrypted = String(lblob_decrypted, EncodingAnsi!)
	Else
		ls_newpass = as_password + String(li_count)
		// decrypt the data
		lblob_data = Blob(ls_data, EncodingAnsi!)
		lblob_decrypted = this.of_EncryptDecrypt( &
										lblob_data, ls_newpass, False)
		ls_decrypted = String(lblob_decrypted, EncodingAnsi!)
	End If
Else
	// decrypt the data
	lblob_data = Blob(as_data, EncodingAnsi!)
	lblob_decrypted = this.of_EncryptDecrypt( &
									lblob_data, as_password, False)
	ls_decrypted = String(lblob_decrypted, EncodingAnsi!)
End If

Return ls_decrypted

end function

public function unsignedlong of_readfile (string as_filename, ref blob ablob_contents);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_ReadFile
//
// PURPOSE:    This function reads a file from disk.
//
// ARGUMENTS:  as_filename		- Name of the file
//					ablob_contents	- File contents (by ref)
//
// RETURN:		>0		= Number of bytes read
//					-1		= Error occurred
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

ULong lul_file, lul_bytes, lul_length
Boolean lb_result

// get file length
lul_length = FileLength(as_filename)

// open file for read
lul_file = CreateFile(as_filename, GENERIC_READ, &
					FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0)
If lul_file = INVALID_HANDLE_VALUE Then
	Return -1
End If

// read the entire file contents in one shot
ablob_contents = Blob(Space(lul_length), EncodingAnsi!)
lb_result = ReadFile(lul_file, ablob_contents, &
					lul_length, lul_bytes, 0)

// close the file
CloseHandle(lul_file)

Return lul_bytes

end function

public function integer of_writefile (string as_filename, blob ablob_filedata);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_WriteFile
//
// PURPOSE:    This function writes a blob to a file on disk.
//
// ARGUMENTS:  as_filename		- The name of the file
//					ablob_filedata	- The blob data of the file
//
// RETURN:		0	= Success
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 05/01/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

ULong lul_file, lul_length, lul_written
Boolean lb_rtn

// open file for write
lul_file = CreateFile(as_filename, GENERIC_WRITE, &
					FILE_SHARE_WRITE, 0, CREATE_ALWAYS, 0, 0)
If lul_file = INVALID_HANDLE_VALUE Then
	Return -999
End If

// write file to disk
lul_length = Len(ablob_filedata)
lb_rtn = WriteFile(lul_file, ablob_filedata, &
					lul_length, lul_written, 0)

// close the file
CloseHandle(lul_file)

Return 0

end function

public subroutine of_setprovider (string as_cryptoservice);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_SetProvider
//
// PURPOSE:    This function sets the provider name.
//
// ARGUMENTS:  as_cryptoservice - Name of the provider
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

is_cryptoservice = as_cryptoservice

end subroutine

public function string of_encrypt (string as_data, string as_password);// encrypt string defaulting last argument
Return of_Encrypt(as_data, as_password, False)

end function

public function string of_decrypt (string as_data, string as_password);// decrypt string defaulting last argument
Return of_Decrypt(as_data, as_password, False)

end function

public function integer of_enumproviders (unsignedlong aul_dwtype, ref string as_provider[]);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_EnumProviders
//
// PURPOSE:    This function will return a list of providers
//
// ARGUMENTS:  aul_dwType	- The type of providers to return
//					as_Provider	- Array of providers ( by ref )
//
// RETURN:		The number of returned providers
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 05/01/2008	RolandS		Initial Coding
// -----------------------------------------------------------------------------

ULong lul_error, lul_dwIndex, lul_dwType, lul_cbName
String ls_provider, ls_msgtext
Integer li_index

lul_dwIndex = 0
do while CryptEnumProviders(lul_dwIndex, 0, 0, &
							lul_dwType, 0, lul_cbName)
	ls_provider = Space(lul_cbName)
	If CryptEnumProviders(lul_dwIndex, 0, 0, &
						lul_dwType, ls_provider, lul_cbName) Then
		If lul_dwType = aul_dwType Then
			li_index = UpperBound(as_provider) + 1
			as_Provider[li_index] = ls_provider
		End If
	Else
		of_GetLastError(lul_error, ls_msgtext)
		SignalError(lul_error, &
			"CryptEnumProviders:~r~n~r~n" + ls_msgtext)
	End If
	lul_dwIndex++
loop

Return UpperBound(as_provider)

end function

public function string of_encrypt (string as_data);// encrypt string defaulting last argument
Return of_Encrypt(as_data, is_crypto_key, False)

end function

public function boolean of_wrong_pwd (string arg_user, string arg_cryptpwd, transaction arg_sqlca);/* 
* Funktion/Event: of_wrong_pwd
* Beschreibung: 	Setzt bei einer Falscheingabe des Passwort den Z$$HEX1$$e400$$ENDHEX$$hler hoch und
* 						bei erreichen der max Fehlversuche wird der Account gesperrt
*
**
* Aenderungshistorie:
* 	Version 		Wer					Wann				Was und warum
*	1.0 			H. Rothenbach		07.10.2008		Erstellung
*
* Return Codes:
*	True		Account noch nicht gesperrt
*   False		Account gesperrt
*/

integer li_faild, li_locked


select nfailed_logins, naccount_locked 
   into :li_faild, :li_locked
	from sys_login
	where cusername = :arg_user
	using arg_sqlca;

if isnull(li_faild) then li_faild=0

//Fehler hochz$$HEX1$$e400$$ENDHEX$$hlen
li_faild ++

//Fehler h$$HEX1$$f600$$ENDHEX$$her maxfehler, dann countsperren
if li_faild > ii_max_wrong_logins then
	li_locked = 1
end if

update sys_login
	set nfailed_logins = :li_faild,
		naccount_locked = :li_locked
	where cusername = :arg_user
	using arg_sqlca;

commit using arg_sqlca;
		
if li_locked = 1 then
	of_pwd_prot(arg_user, arg_cryptpwd, 3, arg_sqlca)	
	return false
else
	of_pwd_prot(arg_user, arg_cryptpwd, 2, arg_sqlca)
	return true
end if
end function

public subroutine of_lock_account (string arg_user, string arg_cryptpwd, transaction arg_sqlca);/* 
* Funktion/Event: of_lock_account
* Beschreibung: 	Sperrt den Account nach zu langer Zeit 
*
**
* Aenderungshistorie:
* 	Version 		Wer					Wann				Was und warum
*	1.0 			H. Rothenbach		07.10.2008		Erstellung
*
*/

integer li_faild, li_locked

update sys_login
	set naccount_locked = 1
	where cusername = :arg_user
	using arg_sqlca;
		
//of_pwd_prot(arg_user, arg_cryptpwd, 4, arg_sqlca)

commit using arg_sqlca;
end subroutine

public subroutine of_pwd_prot (string arg_user, string arg_cryptpwd, integer arg_was, transaction arg_sqlca);/* 
* Funktion/Event: of_pwd_prot
* Beschreibung: 	Protokolliert die Fehler/$$HEX1$$c400$$ENDHEX$$nderungen in der History-Tabelle
*
**
* Aenderungshistorie:
* 	Version 		Wer					Wann				Was und warum
*	1.0 			H. Rothenbach		22.10.2008		Erstellung
*
* Return Codes:
*/

long ll_hist_key, ll_user_id
string ls_version
blob lb_pwd



//User-ID ermitteln
  SELECT sys_login.nuser_id  
    INTO :ll_user_id  
    FROM sys_login  
   WHERE sys_login.cusername = :arg_user 
	using arg_sqlca ;

//Fehler beim ermitteln der USER_ID dann zur$$HEX1$$fc00$$ENDHEX$$ck
if arg_sqlca.sqlcode <>0 then 
	outputMsg ("uo_cryptologin.of_pwd_prot()","Achtung","Error getting the User-ID")
	return
end if

//Variablen f$$HEX1$$fc00$$ENDHEX$$llen
ll_hist_key = f_sequence("SEQ_SYS_LOGIN_HISTORY",arg_sqlca)
ls_version = s_app.sVersion+"-"+s_app.sBuild	 

//Keine Sequence, dann zur$$HEX1$$fc00$$ENDHEX$$ck
if ll_hist_key< 1 then 
	outputMsg ("uo_cryptologin.of_pwd_prot()","Achtung","Error getting an Sequence for the protocol")
	return
end if

//Eintrag erzeugen

  INSERT INTO sys_login_history  
         ( nlogin_history_key,   
           nuser_id,   
           cusername,   
           dchange,   
           nlogin_histkind_key,   
           cchanged_by_user,   
           cipadress,   
           chostname,   
           cversion,   
           ruser_pwd )  
  VALUES ( :ll_hist_key,   
           :ll_user_id,   
           :arg_user,   
           sysdate,   
           :arg_was,   
           :s_app.sUser,   
           :s_app.sClientIP,   
           :s_app.sHost,   
           :ls_version,   
           :lb_pwd )  
  using arg_sqlca;

lb_pwd = blob(arg_cryptpwd)

updateblob sys_login_history
     	 set ruser_pwd 					= :lb_pwd,
	 where cusername 	= :arg_user 
	using arg_sqlca;


if arg_sqlca.sqlcode <>0 then 
	outputMsg ("uo_cryptologin.of_pwd_prot()","Achtung","Error writing the protocol")
end if

commit using arg_sqlca;

end subroutine

public subroutine of_get_passwordrules (transaction arg_sqlca, string arg_mandant);/* 
* Funktion/Event: of_get_passwordrules
* Beschreibung: 	Lesen aller f$$HEX1$$fc00$$ENDHEX$$r die Passwortpr$$HEX1$$fc00$$ENDHEX$$fung ben$$HEX1$$f600$$ENDHEX$$tigter Variablen
* Besonderheit: 	keine
*
* Argumente:
* 	Name				Beschreibung
* 	arg_sqlca		Transactionsobject, mit der gelesen werden soll
**
* Aenderungshistorie:
* 	Version 		Wer					Wann				Was und warum
*	1.0 			H.Rothenbach		29.10.2008		Erstellung
*
* Return Codes:
* None
*/

//Anzahl Tage, nach dem ein Initalpasswort ungueltig wird
ii_days_for_change_initpwd = integer(f_mandant_profilestring(arg_sqlca,arg_mandant, "Passwordrules","Initalpassortperiod","30"))

//Anzahl Tage in denen ein Passwort ge$$HEX1$$e400$$ENDHEX$$ndert werden mu$$HEX1$$df00$$ENDHEX$$
ii_maxdays_for_change =  integer(f_mandant_profilestring(arg_sqlca,arg_mandant, "Passwordrules","Passwordperiod","60"))

//Anzahl Fehlversuche bis AccountLock
ii_max_wrong_logins = integer(f_mandant_profilestring(arg_sqlca,arg_mandant, "Passwordrules","WrongPasswordTillLock","5"))

//Anzahl Passw$$HEX1$$f600$$ENDHEX$$rter in der Passworthistory
ii_max_reuse_paasword = integer(f_mandant_profilestring(arg_sqlca,arg_mandant, "Passwordrules","PasswordHistory","10"))

//Minimale Passwortl$$HEX1$$e400$$ENDHEX$$nge
ii_min_password_length = integer(f_mandant_profilestring(arg_sqlca,arg_mandant, "Passwordrules","MinPasswordLenght","8"))

//Erlaubte Sonderzeichen ermitteln
is_allowed_symbols=f_mandant_profilestring(arg_sqlca,arg_mandant, "Passwordrules","AllowedSymbols","$@")

//Anzahl GraceLogins 
ii_max_grace_Logins = integer(f_mandant_profilestring(arg_sqlca,arg_mandant, "Passwordrules","MaxGraceLogins","5"))

//Feld CPASSWORD ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
ii_use_cpassword  = integer(f_mandant_profilestring(arg_sqlca,arg_mandant, "Passwordrules","UseCpassword","1"))

//Sperre nach x Tagen Inaktivit$$HEX1$$e400$$ENDHEX$$t
ii_lock_after_inactivity = integer(f_mandant_profilestring(arg_sqlca,arg_mandant, "Passwordrules","LockAfterInactivity","60"))




end subroutine

public function integer of_change_password (string arg_user, string arg_mandant, string arg_password);/* 
* Funktion/Event: of_change_password
* Beschreibung: 	Speichert und $$HEX1$$e400$$ENDHEX$$ndert das Passwort, mit Policypr$$HEX1$$fc00$$ENDHEX$$fung und Protokolleintrag
* Besonderheit: 	keine
*
* Argumente:
* 	Name					Beschreibung
* 	arg_user				Userkennung
* 	arg_mandant		Mandant	
*  	arg_password		Passwort
**
* Aenderungshistorie:
* 	Version 		Wer					Wann				Was und warum
*	1.0 			H.Rothenbach		30.10.2008		Erstellung
*
* Return Codes:
*	 1		Alles OK
*	-1		Fehler ist aufgetreten
*   -2     Fehler beim $$HEX1$$c400$$ENDHEX$$ndern des Passworts
*  -3 	   Neues Passwort ist in der Negativeliste
*/

return this.of_change_password(arg_user, arg_mandant, arg_password, sqlca)


end function

public subroutine of_login_ok (string arg_user, string arg_pwd, string arg_cryptpwd, transaction arg_sqlca);/* 
* Funktion/Event: of_login_ok
* Beschreibung: 	Setzt nach erfolgreichem Login die Fehler zur$$HEX1$$fc00$$ENDHEX$$ck und die loginzeit
*
**
* Aenderungshistorie:
* 	Version 		Wer					Wann				Was und warum
*	1.0 			H. Rothenbach		07.10.2008		Erstellung
*
*/

string a
blob lb_pwd
string sChange

lb_pwd=blob(arg_cryptpwd)

a=string(today(),"dd.mm.yyyy")+" "+string(now(),"hh:mm:ss")

update sys_login
	set nfailed_logins = 0,
		clastlogin = :a,
		NGRACE_LOGINS= :ii_max_grace_Logins
	where cusername = :arg_user
	using arg_sqlca;

updateblob sys_login
     	 set ruser_pwd 					= :lb_pwd,
	 where cusername 	= :arg_user 
	using arg_sqlca;
	
	
if arg_sqlca.sqlcode<>0 then
	outputMsg ("uo_cryptologin.of_login_ok()","","Error saving the password "+arg_sqlca.sqlerrtext)
end if
	
sChange = "ALTER USER " + Upper(arg_user) + " IDENTIFIED BY "+char(34) + arg_pwd+char(34)
execute immediate :sChange using arg_sqlca ;

if arg_sqlca.sqlcode<>0 then
	outputMsg ("uo_cryptologin.of_login_ok()","","Error changing the Password "+arg_sqlca.sqlerrtext)
end if

commit using arg_sqlca;
end subroutine

public function string of_decrypt (string as_data);// decrypt string defaulting last argument
Return of_Decrypt(as_data, is_crypto_key, False)

end function

public subroutine of_set_passwordrules (transaction arg_sqlca, string arg_mandant);/* 
* Funktion/Event: of_set_passwordrules
* Beschreibung: 	Speichern aller f$$HEX1$$fc00$$ENDHEX$$r die Passwortpr$$HEX1$$fc00$$ENDHEX$$fung ben$$HEX1$$f600$$ENDHEX$$tigter Variablen
* Besonderheit: 	keine
*
* Argumente:
* 	Name				Beschreibung
* 	arg_sqlca		Transactionsobject, mit der gelesen werden soll
**
* Aenderungshistorie:
* 	Version 		Wer					Wann				Was und warum
*	1.0 			H.Rothenbach		10.11.2008		Erstellung
*
* Return Codes:
* None
*/

//Anzahl Tage, nach dem ein Initalpasswort ungueltig wird
f_mandant_setprofilestring(arg_sqlca,arg_mandant, "Passwordrules","Initalpassortperiod",string(ii_days_for_change_initpwd))

//Anzahl Tage in denen ein Passwort ge$$HEX1$$e400$$ENDHEX$$ndert werden mu$$HEX1$$df00$$ENDHEX$$
f_mandant_setprofilestring(arg_sqlca,arg_mandant, "Passwordrules","Passwordperiod",string(ii_maxdays_for_change ))

//Anzahl Fehlversuche bis AccountLock
f_mandant_setprofilestring(arg_sqlca,arg_mandant, "Passwordrules","WrongPasswordTillLock",string(ii_max_wrong_logins))

//Anzahl Passw$$HEX1$$f600$$ENDHEX$$rter in der Passworthistory
f_mandant_setprofilestring(arg_sqlca,arg_mandant, "Passwordrules","PasswordHistory",string(ii_max_reuse_paasword))

//Minimale Passwortl$$HEX1$$e400$$ENDHEX$$nge
f_mandant_setprofilestring(arg_sqlca,arg_mandant, "Passwordrules","MinPasswordLenght",string(ii_min_password_length))

//Erlaubte Sonderzeichen ermitteln
f_mandant_setprofilestring(arg_sqlca,arg_mandant, "Passwordrules","AllowedSymbols",is_allowed_symbols)

//Anzahl GraceLogins 
f_mandant_setprofilestring(arg_sqlca,arg_mandant, "Passwordrules","MaxGraceLogins",string(ii_max_grace_Logins))

//Feld CPASSWORD ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
f_mandant_setprofilestring(arg_sqlca,arg_mandant, "Passwordrules","UseCpassword",string(ii_use_cpassword))

//Sperre nach x Tagen Inaktivit$$HEX1$$e400$$ENDHEX$$t
f_mandant_setprofilestring(arg_sqlca,arg_mandant, "Passwordrules","LockAfterInactivity",string(ii_lock_after_inactivity))


end subroutine

public function integer of_grace_logins (string arg_user, string arg_pwd, string arg_cryptpwd, integer arg_grace_logins, transaction arg_sqlca);/* 
* Funktion/Event: of_grace_logins
* Beschreibung: 	Pr$$HEX1$$fc00$$ENDHEX$$ft bei abgelaufenem Passwort, ob der Anwender noch eine M$$HEX1$$f600$$ENDHEX$$glichkeit hat das Passwort zu $$HEX1$$e400$$ENDHEX$$ndern. 
*                         Wenn ja, dann wird der Anwender gefragt, ob er es jetzt $$HEX1$$e400$$ENDHEX$$ndern m$$HEX1$$f600$$ENDHEX$$chte. Bei Nein wird die Anmeldung normal fortgesetzt.
*
*
* Return-Werte:   1: Anwender m$$HEX1$$f600$$ENDHEX$$chte das Passwort noch nicht $$HEX1$$e400$$ENDHEX$$ndern
*						2: Anwender m$$HEX1$$f600$$ENDHEX$$chte bzw. muss das Passwort $$HEX1$$e400$$ENDHEX$$ndern
*
**
* Aenderungshistorie:
* 	Version 		Wer					Wann				Was und warum
*	1.0 			H. Rothenbach		11.10.2008		Erstellung
*
*/

string a
blob lb_pwd
string sChange
integer li_ret = 2

//Noch GraceLogins $$HEX1$$fc00$$ENDHEX$$brig?
if  is_logpath = ""  and arg_grace_logins > 0 then
//	if messagebox("","Your Password is expired. You habe "+string(arg_grace_logins)+" grace logins.~r~nWould you like to change it now?",QUESTION!,YESNO!)=2 then
//		// Anwender will Passwort noch nicht $$HEX1$$e400$$ENDHEX$$ndern, dann muss er es nocht nicht
//		li_ret = 1
//	end if
	f_log(arg_user, "arg_grace_logins "+  String(arg_grace_logins))
end if

lb_pwd=blob(arg_cryptpwd)

a=string(today(),"dd.mm.yyyy")+" "+string(now(),"hh:mm:ss")

update sys_login
	set NGRACE_LOGINS = :arg_grace_logins,
		clastlogin = :a
	where cusername = :arg_user
	using arg_sqlca;

updateblob sys_login
     	 set ruser_pwd 					= :lb_pwd,
	 where cusername 	= :arg_user 
	using arg_sqlca;
	
	
if arg_sqlca.sqlcode<>0 then
	outputMsg ("uo_cryptologin.of_grace_logins()","","Error saving the password "+arg_sqlca.sqlerrtext)
end if
	
sChange = "ALTER USER " + Upper(arg_user) + " IDENTIFIED BY " +char(34)+ arg_pwd+char(34)
execute immediate :sChange using arg_sqlca ;

if arg_sqlca.sqlcode<>0 then
	outputMsg ("uo_cryptologin.of_grace_logins()","","Error changing the Password "+arg_sqlca.sqlerrtext)
end if

commit using arg_sqlca;

return li_ret
end function

public function integer outputmsg (string ssource, string stitle, string smsg);// --------------------------------------------------------------------------------
// Objekt : uo_cryptologin
// Methode: outputMsg (Function)
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
//  02.03.2009	            Klaus F$$HEX1$$f600$$ENDHEX$$rster        Erstellung
//  30.06.2009			Rainer Hillebrand (Sybase) 	modified (switch between log and messagebox)
//
// --------------------------------------------------------------------------------

integer iFile
if is_LogPath = "" then 
	//Messagebox (stitle, smsg)
	
else
	iFile = FileOpen(is_LogPath + "CBASE_DOCUMENT_ENGINE_" + string(Today(), "yyyymmdd"+ ".log"), LineMode!, Write!, Shared!)
	FileWrite(iFile, "[" + string(today(), "dd.mm.yyyy") + "-" + string(now(), "hh:mm:ss") + "] " + ssource+": "+sMsg)
	FileClose(iFile)
end if 

return 0
end function

public subroutine of_setlogpath (string as_path);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_setLogPath
//
// PURPOSE:    This function set the directory  for a log file. 
//					for use in EAServer no messagebox are allowed , so the output is done in logfile
//					(use function outputMsg() instead of Messagebox()  )
//
// ARGUMENTS:  as_path		- The directory for the log file

//
// RETURN:		none
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 30.06.2009 R.Hillebrand	Initial Coding
// -----------------------------------------------------------------------------

is_logpath = as_path
end subroutine

public function integer outputmsgtrans (string ssource, string stitle, string smsg);// --------------------------------------------------------------------------------
// Objekt : uo_cryptologin
// Methode: outputMsgtrans (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------
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
//  18.08.2010	            Klaus F$$HEX1$$f600$$ENDHEX$$rster        Erstellung
// --------------------------------------------------------------------------------

integer iFile
if is_LogPath = "" then 
	uf.mbox(stitle,smsg)
else
	iFile = FileOpen(is_LogPath + "CBASE_DOCUMENT_ENGINE_" + string(Today(), "yyyymmdd"+ ".log"), LineMode!, Write!, Shared!)
	FileWrite(iFile, "[" + string(today(), "dd.mm.yyyy") + "-" + string(now(), "hh:mm:ss") + "] " + ssource+": "+sMsg)
	FileClose(iFile)
end if 

return 0
end function

public function integer of_check_pwd (string arg_user, string arg_pwd, string arg_server, ref string arg_retfehler);/* 
* Funktion/Event: of_check_pwd
* Beschreibung: 	Pr$$HEX1$$fc00$$ENDHEX$$froutine, ob das Passwort des Users richtig ist und ob es den betrieblichen belagen entspricht.
*
**
* Aenderungshistorie:
* 	Version 		Wer					Wann				Was und warum
*	1.0 			H. Rothenbach		02.10.2008		Erstellung
*   1.1             R.Hillebrand (Sybase)	30.06.2009	aufruf duplizierter Funktion mit Transaktionsobjekt als parameter um Redundanz zu vermeiden
*
* Return Codes:
*  1		Passwort OK
*  2		Passwort OK, aber Anwender muss Passwort $$HEX1$$e400$$ENDHEX$$ndern
* -1		Passwort falsch
* -2		Account locked		
* -3		Connect-Error
* -4		User not Found
* -5		Select-Error
*/


transaction sqlca_temp

// create transaction object
sqlca_temp = create transaction
sqlca_temp.DBMS 			= s_app.sDBMS
sqlca_temp.LogPass 		= is_pwd_pwd
sqlca_temp.LogId 			= is_pwd_user
sqlca_temp.ServerName = arg_server
sqlca_temp.AutoCommit 	= False
sqlca_temp.DBParm 		= s_app.sDbparm

// call function
return of_check_pwd (arg_user, arg_pwd,sqlca_temp,arg_retfehler)

end function

public function integer of_check_pwd (string arg_user, string arg_pwd, ref transaction sqlca_temp, ref string arg_retfehler);/* 
* Funktion/Event: of_check_pwd
* Beschreibung: 	Pr$$HEX1$$fc00$$ENDHEX$$froutine, ob das Passwort des Users richtig ist und ob es den betrieblichen belagen entspricht.
*
**
* Aenderungshistorie:
* 	Version 		Wer					Wann				Was und warum
*	1.0 			H. Rothenbach		02.10.2008		Erstellung
*   1.1             R.Hillebrand (Sybase)	30.06.2009	duplizierte Funktion mit Transaktionsobjekt als parameter f$$HEX1$$fc00$$ENDHEX$$r Verwendung im uo_webservice	
*
* Return Codes:
*  1		Passwort OK
*  2		Passwort OK, aber Anwender muss Passwort $$HEX1$$e400$$ENDHEX$$ndern
* -1		Passwort falsch
* -2		Account locked		
* -3		Connect-Error
* -4		User not Found
* -5		Select-Error
*/

//Variablen f$$HEX1$$fc00$$ENDHEX$$r die Datenbankinhalte
integer li_user_account_locked, li_user_techuser, li_user_pwd_is_init, li_user_gracelogin, li_ret
string ls_user_password, ls_user_pwddate, ls_user_cryppwd, ls_user_mandant
blob    lb_cryptpwd, lb_pwd
date ld_user_pwddate

//Lokale Variablen
string ls_cryptpwd, sChange

// 20.05.2009 HR: Fehlermeldung, die an die Loginmaske zur$$HEX1$$fc00$$ENDHEX$$ckgegeben wird
arg_retfehler =" "


if not isvalid (sqlca_temp ) then 
	// 20.05.2009 HR: Fehlermeldung, die an die Loginmaske zur$$HEX1$$fc00$$ENDHEX$$ckgegeben wird
	arg_retfehler = "connection object is not valid. check parameter!"
	return -3
end if 

// Connect zur Datenbank mit Tempor$$HEX1$$e400$$ENDHEX$$ren User zur Pr$$HEX1$$fc00$$ENDHEX$$fung der Daten
connect using sqlca_temp;

if sqlca_temp.sqlcode<>0 then
	// 20.05.2009 HR: Fehlermeldung, die an die Loginmaske zur$$HEX1$$fc00$$ENDHEX$$ckgegeben wird
	arg_retfehler = string(sqlca_temp.sqlcode)+" "+sqlca_temp.sqlerrtext
	destroy sqlca_temp
	return -3
end if



// Lesen der Userdaten (Cuserpassword, cpwd_date, cuserpwd, cpwd_init, ntechuser, npwd_is_init, naccount_locked)
// f$$HEX1$$fc00$$ENDHEX$$r die weitere Pr$$HEX1$$fc00$$ENDHEX$$fung

 SELECT 	sys_login.naccount_locked,   
         	sys_login.ntechuser,   
         	sys_login.npwd_is_init,   
         	sys_login.cuserpassword,   
         	sys_login.ruser_pwd,   
         	sys_login.cpwd_date,
			sys_login.dpwd_date,
			sys_login.cclient,
			sys_login.NGRACE_LOGINS
    INTO 	:li_user_account_locked,   
         	:li_user_techuser,   
         	:li_user_pwd_is_init,   
         	:ls_user_password,   
         	:lb_cryptpwd,   
         	:ls_user_pwddate,
			:ld_user_pwddate,
			:ls_user_mandant,
			:li_user_gracelogin
    FROM sys_login  
   WHERE sys_login.cusername = :arg_user   
    USING sqlca_temp;

if sqlca_temp.sqlcode=100 then
	disconnect using sqlca_temp;
	destroy sqlca_temp
	return -4
elseif sqlca_temp.sqlcode<>0 then
	// 20.05.2009 HR: Fehlermeldung, die an die Loginmaske zur$$HEX1$$fc00$$ENDHEX$$ckgegeben wird
	arg_retfehler = string(sqlca_temp.sqlcode)+" "+sqlca_temp.sqlerrtext
	disconnect using sqlca_temp;
	destroy sqlca_temp
	return -5
end if

// 24.04.2009 HR: Umwandlung des Datums in ein lokales Datumsformat 
choose case upper(f_dateformat())
	case "MM/DD/YYYY" //Amerika
		ls_user_pwddate= mid(ls_user_pwddate, 4,2)+"/"+left(ls_user_pwddate, 2)+"/"+right(ls_user_pwddate,4)
	case "M/D/YYYY"  //Amerika
		ls_user_pwddate= mid(ls_user_pwddate, 4,2)+"/"+left(ls_user_pwddate, 2)+"/"+right(ls_user_pwddate,4)
	case "MM/DD/YY" //Amerika
		ls_user_pwddate= mid(ls_user_pwddate, 4,2)+"/"+left(ls_user_pwddate, 2)+"/"+right(ls_user_pwddate,2)
end choose


of_get_passwordrules(sqlca_temp, ls_user_mandant)

ls_cryptpwd= of_encrypt(arg_pwd)

//Blob in String umwandeln
ls_user_cryppwd = string(lb_cryptpwd)

//Pr$$HEX1$$fc00$$ENDHEX$$fen, ob der Account gerlocked ist.
if li_user_account_locked = 1  then
	//Protokolleintrag erstellen
	of_pwd_prot(arg_user, ls_cryptpwd, 7, sqlca_temp)
	
	//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
	disconnect using sqlca_temp;
	destroy sqlca_temp
	
	//Account Locked melden
	return -2
end if

if  li_user_gracelogin < 1 then
	of_lock_account(arg_user, ls_cryptpwd, sqlca_temp)

	//Protokolleintrag erstellen
	of_pwd_prot(arg_user, ls_cryptpwd, 7, sqlca_temp)

	//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
	disconnect using sqlca_temp;
	destroy sqlca_temp
	
	//Account Locked melden
	return -2

end if

//Systemuser ?
if li_user_techuser=1 then
	//Noch kein Cryptopasswort?
	if isnull(ls_user_cryppwd) then
		//CPASSWORD wird nicht mehr verwendet
		if ii_use_cpassword=0 then
			//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
			disconnect using sqlca_temp;
			destroy sqlca_temp

			return -1
		else
			//Passwortvergleich mit normalen Passwort
			 if ls_user_password = arg_pwd then
				of_login_ok(arg_user, arg_pwd, ls_cryptpwd, sqlca_temp)
				
				//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
				disconnect using sqlca_temp;
				destroy sqlca_temp
	
				return 1
			else
				if of_wrong_pwd(arg_user, ls_cryptpwd, sqlca_temp) then
					//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
					disconnect using sqlca_temp;
					destroy sqlca_temp
	
					return -1
				else
					//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
					disconnect using sqlca_temp;
					destroy sqlca_temp
	
					return -2
				end if
			end if
		end if
	else
		// 28.01.2009 HR:	Falscher Vergleich ausgebaut //if ls_user_cryppwd = arg_pwd then
		if 	ls_user_cryppwd = ls_cryptpwd then
			of_login_ok(arg_user, arg_pwd, ls_cryptpwd, sqlca_temp)
			
			//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
			disconnect using sqlca_temp;
			destroy sqlca_temp

			return 1
		else
			//$$HEX1$$dc00$$ENDHEX$$bergangsm$$HEX2$$e400df00$$ENDHEX$$ig Passwortvergleich mit normalen Passwort
			 if ls_user_password = arg_pwd and ii_use_cpassword = 1 then
				of_login_ok(arg_user, arg_pwd, ls_cryptpwd, sqlca_temp)
				
				//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
				disconnect using sqlca_temp;
				destroy sqlca_temp

				return 1
			else
				if of_wrong_pwd(arg_user, ls_cryptpwd, sqlca_temp) then
					//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
					disconnect using sqlca_temp;
					destroy sqlca_temp

					return -1
				else
					//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
					disconnect using sqlca_temp;
					destroy sqlca_temp

					return -2
				end if
			end if
		end if
	end if
end if

//Normaler User, dann diverse Pr$$HEX1$$fc00$$ENDHEX$$fungen 

//	1) Passwortpr$$HEX1$$fc00$$ENDHEX$$fung. Bei falschem Passwort dieses zur$$HEX1$$fc00$$ENDHEX$$ckmelden
if isnull(ls_user_cryppwd) then
	//Passwortvergleich mit normalen Passwort
	 if ls_user_password <> arg_pwd then
		if of_wrong_pwd(arg_user, ls_cryptpwd, sqlca_temp) then
			//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
			disconnect using sqlca_temp;
			destroy sqlca_temp

			return -1
		else
			//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
			disconnect using sqlca_temp;
			destroy sqlca_temp

			return -2
		end if
	end if
else
	// 28.01.2009 HR:	Falscher Vergleich ausgebaut //if ls_user_cryppwd <> arg_pwd then
	if 	ls_user_cryppwd <> ls_cryptpwd then
		//$$HEX1$$dc00$$ENDHEX$$bergangsm$$HEX2$$e400df00$$ENDHEX$$ig Passwortvergleich mit normalen Passwort
		 if ls_user_password <> arg_pwd then
			if of_wrong_pwd(arg_user, ls_cryptpwd, sqlca_temp) then
				//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
				disconnect using sqlca_temp;
				destroy sqlca_temp

				return -1
			else
				//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
				disconnect using sqlca_temp;
				destroy sqlca_temp

				return -2
			end if
		end if
	end if
end if

//Passwortpr$$HEX1$$fc00$$ENDHEX$$fung erfolgreich, dann 
//2) Passwort ist ein Initialpasswort?
if li_user_pwd_is_init=1 then
	if  relativedate(date(ld_user_pwddate), ii_days_for_change_initpwd) >= today() then
		//Passwort ist Initalpasswort und kann noch ge$$HEX1$$e400$$ENDHEX$$ndert werden =>  R$$HEX1$$fc00$$ENDHEX$$ckmeldung Login OK ->PWD Change

		//Passwort des Users sicherheitshalber nochmal auf das Passwort in der Usertabelle setzten
		sChange = "ALTER USER " + Upper(arg_user) + " IDENTIFIED BY " +char(34)+ arg_pwd +char(34)
		execute immediate :sChange using sqlca_temp;

		//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
		disconnect using sqlca_temp;
		destroy sqlca_temp

		return 2
	else
		//Passwort ist Initalpasswort und kann nicht mehr ge$$HEX1$$e400$$ENDHEX$$ndert werden =>  R$$HEX1$$fc00$$ENDHEX$$ckmeldung AccountLocked

		//Account locken und Protokolleintrag erstellen
		of_lock_account(arg_user, ls_cryptpwd, sqlca_temp)
			
		//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
		disconnect using sqlca_temp;
		destroy sqlca_temp

		return -2
	end if
end if

if  relativedate(date(ld_user_pwddate), ii_maxdays_for_change) < today() then
	//Passwort ist abgelaufen zur $$HEX1$$c400$$ENDHEX$$nderung auffordern
	
	li_user_gracelogin --
	li_ret = of_grace_logins(arg_user, arg_pwd, ls_cryptpwd,li_user_gracelogin, sqlca_temp)
	
	//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
	disconnect using sqlca_temp;
	destroy sqlca_temp
	
	return li_ret
end if

//Protokolleintrag erstellen
of_login_ok(arg_user, arg_pwd, ls_cryptpwd, sqlca_temp)

//tempor$$HEX1$$e400$$ENDHEX$$re Verbindung trennen und Speicher freigeben
disconnect using sqlca_temp;
destroy sqlca_temp

//Erfolgreiche Anmeldung melden
return 1
end function

public function integer of_change_password (string arg_user, string arg_mandant, string arg_password, transaction arg_sqlca);/* 
* Funktion/Event: of_change_password
* Beschreibung: 	Speichert und $$HEX1$$e400$$ENDHEX$$ndert das Passwort, mit Policypr$$HEX1$$fc00$$ENDHEX$$fung und Protokolleintrag
* Besonderheit: 	keine
*
* Argumente:
* 	Name					Beschreibung
* 	arg_user				Userkennung
* 	arg_mandant		Mandant	
*  	arg_password		Passwort
**
* Aenderungshistorie:
* 	Version 		Wer					Wann				Was und warum
*	1.0 			H.Rothenbach		30.10.2008		Erstellung
*	1.1 			OH          		22.06.2011		cUnit aus where-clause entfernt (WEB-Problem)
*
* Return Codes:
*	 1		Alles OK
*	-1		Fehler ist aufgetreten
*   -2     Fehler beim $$HEX1$$c400$$ENDHEX$$ndern des Passworts
*  -3 	   Neues Passwort ist in der Negativeliste
*/

string ls_cryptpwd, ls_pwd, ls_dat, sChange
string ls_oldpwds[]
integer i
long ll_histkey
blob    lb_cryptpwd, lb_pwd
date  ld_date

// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob neues Passwort in der Negativeliste enthalten ist
// select count(*) into :i from sys_login_negativ where UPPER(cpassword) = UPPER(:arg_password);
select count(*) into :i from sys_login_negativ where instr ( UPPER(:arg_password), UPPER(cpassword) ,1,1)>0;

if i>0 then return -3

//Passwort verschl$$HEX1$$fc00$$ENDHEX$$sseln
ls_cryptpwd= of_encrypt(arg_password)

lb_cryptpwd = blob(ls_cryptpwd)

ls_dat = string(today(),"dd.mm.yyyy")
// 05.06.2009 HR:
ld_date = today()

//Holen der alte Passw$$HEX1$$f600$$ENDHEX$$rter der letzten $$HEX1$$c400$$ENDHEX$$nderungen vorbereiten
 DECLARE passwoerter CURSOR FOR  
  SELECT sys_login_history.nlogin_history_key
    FROM sys_login_history  
   WHERE ( sys_login_history.nlogin_histkind_key = 1 ) AND  
         ( sys_login_history.cusername = :arg_user )   
ORDER BY sys_login_history.dchange DESC  ;

open passwoerter;

i = 0 

//Passw$$HEX1$$f600$$ENDHEX$$rter holen (max letzten 10 Passw$$HEX1$$f600$$ENDHEX$$rter)
if sqlca.sqlcode=0 then
	do

		fetch passwoerter into :ll_histkey;
		if sqlca.sqlcode=0 then
			selectblob ruser_pwd into:lb_pwd from sys_login_history where nlogin_history_key = :ll_histkey;
			
			i++
			ls_oldpwds[i]=string(lb_pwd)
		end if
	loop until sqlca.sqlcode<>0 or i=10
	
	close passwoerter;
end if

//Wenn schon mal ein Passwort ge$$HEX1$$e400$$ENDHEX$$ndert wurde, dann pr$$HEX1$$fc00$$ENDHEX$$fen, ob das neu schon mal verwendet wurde
if i>0 then
	for i=1 to upperbound(ls_oldpwds)
		if ls_oldpwds[i]=ls_cryptpwd then return -1 //Passwort wurde schon verwendet, dann raus hier
	next
end if

//Passwort$$HEX1$$e400$$ENDHEX$$nderung speichern
if ii_use_cpassword = 1 then
	UPDATE sys_login  
		SET cuserpassword = :arg_password, 
			npwd_is_init = 0,
			cpwd_date = :ls_dat,
			dpwd_date = :ld_date,
			NGRACE_LOGINS= :ii_max_grace_Logins
	WHERE ( sys_login.cclient		= :s_app.sMandant ) AND  
			 ( sys_login.cusername 	= :arg_User )   ;

else
	UPDATE sys_login  
		SET cuserpassword = '..--..', 
			npwd_is_init = 0,
			cpwd_date = :ls_dat,
			dpwd_date = :ld_date,
			NGRACE_LOGINS= :ii_max_grace_Logins
	WHERE ( sys_login.cclient		= :s_app.sMandant ) AND  
			 ( sys_login.cusername 	= :arg_User )   ;
	
end if
If sqlca.sqlcode = 0 Then
	updateblob sys_login
			 set ruser_pwd 					= :lb_cryptpwd
		 where  sys_login.cusername 	= :arg_User 
			 using sqlca;
end if			 
If sqlca.sqlcode <> 0 Then
	outputmsgtrans("uo_cryptologin.of_change_password()", "Kennwort $$HEX1$$e400$$ENDHEX$$ndern","Kennwort konnte nicht gespeichert werden.~nFehlercode: ${" + string(sqlca.SQLCode)+"}")
	is_error = "Kennwort konnte nicht gespeichert werden.  Fehlercode: " + string(sqlca.SQLDBCode)+" "+sqlca.sqlerrtext
	return -2
End if	

// --------------------------------
// auch in der Datenbank
// --------------------------------				 

sChange = "ALTER USER " + Upper(arg_User) + " IDENTIFIED BY " +char(34)+ arg_password+char(34)

execute immediate :sChange using arg_sqlca;

If arg_sqlca.sqldbcode <> 0 Then
	outputmsgtrans("uo_cryptologin.of_change_password()", "Kennwort $$HEX1$$e400$$ENDHEX$$ndern","Kennwort konnte nicht ge$$HEX1$$e400$$ENDHEX$$ndert werden.~nFehlercode: ${" + string(arg_sqlca.SQLDBCode)+"}")
	is_error = "Kennwort konnte nicht ge$$HEX1$$e400$$ENDHEX$$ndert werden. Fehlercode: " + string(arg_sqlca.SQLDBCode)+" "+arg_sqlca.sqlerrtext
	rollback using arg_sqlca;
	return -2
End if

commit using arg_sqlca;

of_pwd_prot(arg_user, ls_cryptpwd, 1, sqlca)

return 1
end function

public function string of_encode_blob (blob arg_bblob);// -----------------------------------------------------------------------------
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

lul_len = Len(arg_bblob)
lul_buflen = lul_len * 2
ls_encoded = Space(lul_buflen)

lb_rtn = CryptBinaryToString(arg_bblob, &
                lul_len, CRYPT_STRING_BASE64, &
                ls_encoded, lul_buflen)

IF NOT lb_rtn THEN
    ls_encoded = "Encode error"
ELSE
    // remove the last two chr(0)!
    ls_encoded = left(ls_encoded, len(ls_encoded) - 2 )
END IF

return ls_encoded
end function

on uo_cryptologin.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cryptologin.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;String ls_provider, ls_Providers[]
Integer li_idx, li_max, li_ok=0

li_max = this.of_EnumProviders(this.PROV_RSA_FULL, ls_Providers)

For li_idx = 1 To li_max
	if ls_Providers[li_idx] = is_cryptoprovider then li_ok=1
Next

if li_ok=0 then
	outputMsg ("uo_cryptologin.constructor()","","The needet Cryptoengine '"+is_cryptoprovider+"' is not available.")
	is_cryptoservice = ""
else
	is_cryptoservice = is_cryptoprovider
end if

//-------------------------------------------------------------------------------------
// Parameter f$$HEX1$$fc00$$ENDHEX$$r Passwort-Policy lesen
//-------------------------------------------------------------------------------------

//Anzahl Tage, nach dem ein Initalpasswort ungueltig wird
ii_days_for_change_initpwd = 30

//Anzahl Tage in denen ein Passwort ge$$HEX1$$e400$$ENDHEX$$ndert werden mu$$HEX1$$df00$$ENDHEX$$
ii_maxdays_for_change = 60

//Anzahl Fehlversuche bis AccountLock
ii_max_wrong_logins = 5

end event

