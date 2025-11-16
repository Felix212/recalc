HA$PBExportHeader$uo_cryptologin.sru
forward
global type uo_cryptologin from nonvisualobject
end type
end forward

global type uo_cryptologin from nonvisualobject autoinstantiate
end type

type prototypes
Function ulong GetLastError( ) Library "kernel32.dll"

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

Function boolean CryptBinaryToString ( &
	Blob pbBinary, &
	ulong cbBinary, &
	ulong dwFlags, &
	Ref string pszString, &
	Ref ulong pcchString &
	) Library "crypt32.dll" Alias For "CryptBinaryToStringW"

Function boolean CryptStringToBinary ( &
	string pszString, &
	ulong cchString, &
	ulong dwFlags, &
	Ref blob pbBinary, &
	Ref ulong pcbBinary, &
	Ref ulong pdwSkip, &
	Ref ulong pdwFlags &
	) Library "crypt32.dll" Alias For "CryptStringToBinaryW"

end prototypes

type variables
//s_application 		s_app 	// Im Webservice aktivieren / in GUI auskommentieren

/*
Objekt gibt es in folgende Applicationen und muss dort auch aktuallisiert werden:
- CBASE-CLASSIC 
- CBASE-Terminal
- CBASE-WEB
- CBASE-Flightcheck
- SKYCOPE
*/

Private:
// general constants
Constant ULong CRYPT_STRING_BASE64		= 1073741825   

// constants for CreateFile API function
Constant ULong INVALID_HANDLE_VALUE 	= -1
Constant ULong GENERIC_READ     			= 2147483648
Constant ULong GENERIC_WRITE    			= 1073741824
Constant ULong FILE_SHARE_READ  			= 1
Constant ULong FILE_SHARE_WRITE 			= 2
Constant ULong CREATE_NEW					= 1
Constant ULong CREATE_ALWAYS				= 2
Constant ULong OPEN_EXISTING				= 3
Constant ULong OPEN_ALWAYS				= 4
Constant ULong TRUNCATE_EXISTING 		= 5

// constants for cypto api
Constant String KEY_CONTAINER 				= "MyKeyContainer"
Constant ULong CALG_MD5						= 32771
Constant ULong CALG_RC4						= 26625
Constant ULong ENCRYPT_ALGORITHM 		= CALG_RC4
Constant ULong CRYPT_NEWKEYSET   		= 8
Constant ULong ERROR_MORE_DATA			= 234

// active Cryptographic service provider
String is_cryptoservice

// Passwortkey mit dem die Kennw$$HEX1$$f600$$ENDHEX$$rter verschl$$HEX1$$fc00$$ENDHEX$$sselt werden. (Darf nicht ge$$HEX1$$e400$$ENDHEX$$ndert werden)
String is_crypto_key 									

// Verwendeter Treiber f$$HEX1$$fc00$$ENDHEX$$r die Verschl$$HEX1$$fc00$$ENDHEX$$sselung. (Darf nicht ge$$HEX1$$e400$$ENDHEX$$ndert werden)
Constant String is_cryptoprovider 				= "Microsoft Strong Cryptographic Provider"

//###################################################################################################
// Hier muss noch der Username und Passwort f$$HEX1$$fc00$$ENDHEX$$r den Testuser eingetragen werden, der dann auf jeder Instanze existieren muss.
//###################################################################################################
string is_pwd_user                                           
string is_pwd_pwd 
//###################################################################################################

Public:
//######################################################
//Variablen f$$HEX1$$fc00$$ENDHEX$$r die Passwortpolicy
//######################################################

integer	ii_days_for_change_initpwd 	= 30		//Anzahl Tage, nach dem ein Initalpasswort ungueltig wird
integer 	ii_maxdays_for_change 			= 60		//Anzahl Tage in denen ein Passwort ge$$HEX1$$e400$$ENDHEX$$ndert werden mu$$HEX1$$df00$$ENDHEX$$
integer  	ii_max_wrong_logins 				= 5		//Anzahl Fehlversuche bis AccountLock
integer  	ii_max_reuse_paasword 			= 10		//Anzahl Passw$$HEX1$$f600$$ENDHEX$$rter in der Passworthistory
string 	is_allowed_symbols 				= "@$"	//Zeichenfolge der erlaubten Sonderzeichen
integer 	ii_min_password_length 			= 7		//Mindestpasswortl$$HEX1$$e400$$ENDHEX$$nge
integer 	ii_max_grace_Logins							//Maximale Anzahl an Versuchen nach Passwortablauf
integer 	ii_use_cpassword 								//Feld CPASSWORD ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
integer 	ii_lock_after_inactivity							//Sperre nach x Tagen Inaktivit$$HEX1$$e400$$ENDHEX$$t
integer	ii_max_changes_per_day		= 3		// 22.03.2016 HR: Maximale $$HEX1$$c400$$ENDHEX$$nderungen an einem Tag

//######################################################
// Provider Types
Constant ULong PROV_RSA_FULL			= 1
Constant ULong PROV_RSA_SIG			= 2
Constant ULong PROV_DSS					= 3
Constant ULong PROV_FORTEZZA		= 4
Constant ULong PROV_MS_EXCHANGE	= 5
Constant ULong PROV_SSL					= 6
Constant ULong PROV_RSA_SCHANNEL	= 12
Constant ULong PROV_DSS_DH			= 13
Constant ULong PROV_EC_ECDSA_SIG	= 14
Constant ULong PROV_EC_ECNRA_SIG	= 15
Constant ULong PROV_EC_ECDSA_FULL	= 16
Constant ULong PROV_EC_ECNRA_FULL= 17
Constant ULong PROV_SPYRUS_LYNKS	= 20

// Logpath , if set then suppress messagebox
string 	is_LogPath 							= ""
string 	is_error 								= ""
Integer 	itrace 								= 0				// Im Webservice auf 1 setzen / in der GUI auf 0
string		is_prog_version					= "n/a"
boolean	ib_pwd_want_change			= false

string		is_pwd_crpt_temp					= ""
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
public subroutine of_lock_account (string arg_user, string arg_cryptpwd, transaction arg_sqlca)
public subroutine of_get_passwordrules (transaction arg_sqlca, string arg_mandant)
public function integer of_change_password (string arg_user, string arg_mandant, string arg_password)
public function string of_decrypt (string as_data)
public subroutine of_set_passwordrules (transaction arg_sqlca, string arg_mandant)
public function integer of_check_pwd (string arg_user, string arg_pwd, string arg_server, ref string arg_retfehler)
public function integer outputmsg (string ssource, string stitle, string smsg)
public subroutine of_setlogpath (string as_path)
public function integer of_check_pwd (string arg_user, string arg_pwd, ref transaction sqlca_temp, ref string arg_retfehler)
public function integer outputmsgtrans (string ssource, string stitle, string smsg)
public function string of_generatenewpassword (string as_mode, ref string as_error)
public function boolean of_pwd_basiccheck (string as_password, ref string as_error)
public function string of_replaceall (string as_oldstring, string as_findstr, string as_replace)
public function blob of_decode64 (string as_encoded)
public function string of_encode64 (blob ablob_data)
public function long of_get_testlogin (ref string arg_user, ref string arg_pwd)
public function boolean of_valid_password (string arg_pwd, ref string arg_returntext)
public function integer of_change_password (string arg_user, string arg_mandant, string arg_password, transaction arg_sqlca)
public function integer of_log (string smsg)
public function string of_dateformat ()
public function integer outputquestion (string ssource, string stitle, string smsg, integer ndefault)
public function boolean of_check_negativliste (string arg_password, transaction arg_sqlca)
public function string of_encrypt_base64 (string as_data, string as_password)
public subroutine of_login_ok (string arg_user, string arg_pwd, string arg_cryptpwd, string arg_cryptpwd_base64, transaction arg_sqlca)
public function boolean of_wrong_pwd (string arg_user, string arg_cryptpwd, string arg_cryptpwd_base64, transaction arg_sqlca)
public subroutine of_pwd_prot (string arg_user, string arg_cryptpwd, string arg_cryptpwd_base64, integer arg_was, transaction arg_sqlca)
public function integer of_grace_logins (string arg_user, string arg_pwd, string arg_cryptpwd, string arg_cryptpwd_base64, integer arg_grace_logins, transaction arg_sqlca)
public function string of_encrypt_base64 (string as_data)
public function string of_decrypt_base64 (string as_data)
public function string of_decrypt_base64 (string as_data, string as_password)
public subroutine of_init ()
end prototypes

public subroutine of_getlasterror (ref unsignedlong aul_error, ref string as_msgtext);
// -----------------------------------------------------------------------------
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

public function string of_getdefaultprovider ();
// -----------------------------------------------------------------------------
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

public function blob of_encrypt (blob ablob_data, string as_password);
// -----------------------------------------------------------------------------
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

public function blob of_decrypt (blob ablob_data, string as_password);
// -----------------------------------------------------------------------------
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

public function string of_encrypt (string as_data, string as_password, boolean ab_removebad);
// -----------------------------------------------------------------------------
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

public function string of_encrypt (string as_data);
// encrypt string defaulting last argument
Return of_Encrypt(as_data, is_crypto_key, False)

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

// 22.03.2016 HR: Maximale $$HEX1$$c400$$ENDHEX$$nderungen an einem Tag
ii_max_changes_per_day = integer(f_mandant_profilestring(arg_sqlca,arg_mandant, "Passwordrules","MaxChangesPerDay","3"))


end subroutine

public function integer of_change_password (string arg_user, string arg_mandant, string arg_password);
/* 
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
*  -3 	    Neues Passwort ist in der Negativeliste
*  -4      Heute zu oft ge$$HEX1$$e400$$ENDHEX$$ndert
*/

return this.of_change_password(arg_user, arg_mandant, arg_password, sqlca)
end function

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

// 22.03.2016 HR: Maximale $$HEX1$$c400$$ENDHEX$$nderungen an einem Tag
f_mandant_setprofilestring(arg_sqlca,arg_mandant, "Passwordrules","MaxChangesPerDay",string(ii_max_changes_per_day))

end subroutine

public function integer of_check_pwd (string arg_user, string arg_pwd, string arg_server, ref string arg_retfehler);
/* 
* Funktion/Event: of_check_pwd
* Beschreibung: 	Pr$$HEX1$$fc00$$ENDHEX$$froutine, ob das Passwort des Users richtig ist und ob es den betrieblichen belagen entspricht.
*
**
* Aenderungshistorie:
* 	Version    Wer					 Wann          Was und warum
*	1.0        H. Rothenbach    02.10.2008    Erstellung
*  1.1        R. Hillebrand    30.06.2009    Duplizierte Funktion mit Transaktionsobjekt als parameter f$$HEX1$$fc00$$ENDHEX$$r Verwendung im uo_webservice	
*  1.2        Dirk Bunk        21.03.2012    Pr$$HEX1$$fc00$$ENDHEX$$fen, ob der Datenbankbenutzer gesperrt oder abgelaufen ist
*
* Return Codes:
*  1    Passwort OK
*  2    Passwort OK, aber Anwender muss Passwort $$HEX1$$e400$$ENDHEX$$ndern
* -1    Passwort falsch
* -2    Account locked		
* -3    Connect-Error
* -4    User not Found
* -5    Select-Error
* -6    DB Account locked
* -7    DB Account expired
*/

transaction sqlca_temp
long ll_succ

// create transaction object
sqlca_temp 					= create transaction
sqlca_temp.DBMS 			= s_app.sDBMS

// Hier muss noch der Username und Passwort f$$HEX1$$fc00$$ENDHEX$$r den Testuser eingetragen werden, der dann auf jeder Instance existieren muss.
// MHO 2014-09-10: Ausgelagert in Funktion, weil dieser User auch anderswo benutzt werden soll/kann/will (z.B. Email-Senden bei PWD-$$HEX1$$c400$$ENDHEX$$nderung)
ll_succ = of_get_testlogin (ref sqlca_temp.LogId, ref sqlca_temp.LogPass)

sqlca_temp.ServerName = arg_server
sqlca_temp.AutoCommit 	= False
sqlca_temp.DBParm 		= s_app.sDbparm

// 22.06.2015 HR: Connect in die CBASE-Funktion umgezogen
// Connect zur Datenbank mit Tempor$$HEX1$$e400$$ENDHEX$$ren User zur Pr$$HEX1$$fc00$$ENDHEX$$fung der Daten
connect using sqlca_temp;

if sqlca_temp.sqlcode<>0 then
	// 20.05.2009 HR: Fehlermeldung, die an die Loginmaske zur$$HEX1$$fc00$$ENDHEX$$ckgegeben wird
	arg_retfehler = string(sqlca_temp.sqlcode)+" "+sqlca_temp.sqlerrtext
	destroy sqlca_temp
	return -3
end if

// call function
ll_succ = of_check_pwd (arg_user, arg_pwd,sqlca_temp,arg_retfehler)

// 22.06.2015 HR: Disconnect in die CBASE-Funktion umgezogen
disconnect using sqlca_temp;
destroy sqlca_temp

return ll_succ

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
	Messagebox (stitle, smsg)
else
	iFile = FileOpen(is_LogPath + "cbase_webservice_" + string(Today(), "yyyymmdd"+ ".log"), LineMode!, Write!, Shared!)
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

public function integer of_check_pwd (string arg_user, string arg_pwd, ref transaction sqlca_temp, ref string arg_retfehler);/* 
* Funktion/Event: of_check_pwd
* Beschreibung: 	Pr$$HEX1$$fc00$$ENDHEX$$froutine, ob das Passwort des Users richtig ist und ob es den betrieblichen belagen entspricht.
*
**
* Aenderungshistorie:
* 	Version    Wer					Wann           	Was und warum
*	1.0          H. Rothenbach  	02.10.2008    	Erstellung
*  1.1           R. Hillebrand   	30.06.2009    	Duplizierte Funktion mit Transaktionsobjekt als parameter f$$HEX1$$fc00$$ENDHEX$$r Verwendung im uo_webservice	
*  1.2           Dirk Bunk         	21.03.2012    	Pr$$HEX1$$fc00$$ENDHEX$$fen, ob der Datenbankbenutzer gesperrt oder abgelaufen ist
*  1.3           Klaus 				23.04.2012	   	Disconnect auf sqlca_temp entfernt
*  1.4      	 H. Rothenbach		22.03.2016		Neue Art der Speicherung des codierten Passworts
*
* Return Codes:
*  1    Passwort OK
*  2    Passwort OK, aber Anwender muss Passwort $$HEX1$$e400$$ENDHEX$$ndern
* -1    Passwort falsch
* -2    Account locked		
* -3    Connect-Error
* -4    User not Found
* -5    Select-Error
* -6    DB Account locked or expired
*/

//Variablen f$$HEX1$$fc00$$ENDHEX$$r die Datenbankinhalte
integer 	li_user_account_locked, li_user_techuser, li_user_pwd_is_init, li_user_gracelogin, li_ret
string 	ls_user_password, ls_user_pwddate, ls_user_cryppwd, ls_user_mandant, ls_account_status, ls_user_password_crypt
blob    	lb_cryptpwd, lb_pwd
date 		ld_user_pwddate, ld_user_lastlogin

//Lokale Variablen
string 	ls_cryptpwd, sChange, ls_cryptpwd64

// 20.05.2009 HR: Fehlermeldung, die an die Loginmaske zur$$HEX1$$fc00$$ENDHEX$$ckgegeben wird
arg_retfehler =" "

if not isvalid (sqlca_temp ) then 
	// 20.05.2009 HR: Fehlermeldung, die an die Loginmaske zur$$HEX1$$fc00$$ENDHEX$$ckgegeben wird
	arg_retfehler = "connection object is not valid. check parameter!"
	of_log("uo_cryptologin.of_check_pwd: " + arg_retfehler + " not isvalid (sqlca_temp)" )
	return -3
end if 

of_log("uo_cryptologin.of_check_pwd: VOR SELECT sys_login...")

// 21.03.12, DB: Pr$$HEX1$$fc00$$ENDHEX$$fen, ob der Datenbankbenutzer gesperrt oder abgelaufen ist
SELECT count(*), max(lower(account_status)) 
   INTO :li_ret, :ls_account_status 
  FROM dba_users 
 WHERE (account_status LIKE '%LOCKED%' OR account_status LIKE '%EXPIRED%') 
   AND lower(username) = :arg_user
 USING sqlca_temp;

if li_ret <> 0 then
	arg_retfehler = "DB account is " + ls_account_status + "!"
	return -6
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
			sys_login.NGRACE_LOGINS,
			sys_login.CUSER_PWD,
			sys_login.DLASTLOGIN
    INTO 	:li_user_account_locked,   
         	:li_user_techuser,   
         	:li_user_pwd_is_init,   
         	:ls_user_password,   
         	:lb_cryptpwd,   
         	:ls_user_pwddate,
			:ld_user_pwddate,
			:ls_user_mandant,
			:li_user_gracelogin,
			:ls_user_password_crypt,   
			:ld_user_lastlogin
    FROM sys_login  
   WHERE sys_login.cusername = :arg_user   
    USING sqlca_temp;

if sqlca_temp.sqlcode=100 then
	return -4
elseif sqlca_temp.sqlcode<>0 then
	// 20.05.2009 HR: Fehlermeldung, die an die Loginmaske zur$$HEX1$$fc00$$ENDHEX$$ckgegeben wird
	arg_retfehler = string(sqlca_temp.sqlcode)+" "+sqlca_temp.sqlerrtext
	return -5
end if

// 24.04.2009 HR: Umwandlung des Datums in ein lokales Datumsformat 
choose case upper(of_dateformat())
	case "MM/DD/YYYY" //Amerika
		ls_user_pwddate= mid(ls_user_pwddate, 4,2)+"/"+left(ls_user_pwddate, 2)+"/"+right(ls_user_pwddate,4)
	case "M/D/YYYY"  //Amerika
		ls_user_pwddate= mid(ls_user_pwddate, 4,2)+"/"+left(ls_user_pwddate, 2)+"/"+right(ls_user_pwddate,4)
	case "MM/DD/YY" //Amerika
		ls_user_pwddate= mid(ls_user_pwddate, 4,2)+"/"+left(ls_user_pwddate, 2)+"/"+right(ls_user_pwddate,2)
end choose

of_get_passwordrules(sqlca_temp, ls_user_mandant)

of_log("uo_cryptologin.of_check_pwd: VOR of_encrypt")

ls_cryptpwd= of_encrypt(arg_pwd)

// --------------------------------------------------------------------------------------------------------------------
// 22.03.2016 HR: Wir speichern das Passwort nicht mehr als Blob sondern als String, daher wandeln 
//                        wir das verschl$$HEX1$$fc00$$ENDHEX$$sselte Passwort mit BASE64 um
// --------------------------------------------------------------------------------------------------------------------
ls_cryptpwd64 = of_encrypt_base64(arg_pwd, is_crypto_key)

// --------------------------------------------------------------------------------------------------------------------
// 26.04.2016 HR: Wenn das unverschl$$HEX1$$fc00$$ENDHEX$$sselte Passwort noch verwendet wird, dann verschl$$HEX1$$fc00$$ENDHEX$$sseln wir 
//                        dies erst mal um es ggf dann noch mal in das neue Feld zu speichern
// --------------------------------------------------------------------------------------------------------------------
if ls_user_password = '..--..' then
	is_pwd_crpt_temp = ""
else
	is_pwd_crpt_temp = of_encrypt_base64(ls_user_password, is_crypto_key)
end if

//Blob in String umwandeln
ls_user_cryppwd = string(lb_cryptpwd)

//Pr$$HEX1$$fc00$$ENDHEX$$fen, ob der Account gerlocked ist.
if li_user_account_locked = 1  then
	//Protokolleintrag erstellen
	of_pwd_prot(arg_user, ls_cryptpwd, ls_cryptpwd64, 7, sqlca_temp)
	
	//Account Locked melden
	return -2
end if

if  li_user_gracelogin < 1 then
	of_lock_account(arg_user, ls_cryptpwd, sqlca_temp)

	//Protokolleintrag erstellen
	of_pwd_prot(arg_user, ls_cryptpwd, ls_cryptpwd64, 7, sqlca_temp)

	//Account Locked melden
	return -2

end if

of_log("uo_cryptologin.of_check_pwd: VOR li_user_techuser=1")

//Systemuser ?
if li_user_techuser=1 then
	//Noch kein Cryptopasswort?
	if isnull(ls_user_password_crypt) then
	//if isnull(ls_user_cryppwd) then
		//CPASSWORD wird nicht mehr verwendet
		if ii_use_cpassword=0 then
			// 22.03.2016 HR: Jetzt pr$$HEX1$$fc00$$ENDHEX$$fen wir gegen das alte Cryptpasswort
			if 	ls_user_cryppwd = ls_cryptpwd then
				of_login_ok(arg_user, arg_pwd, ls_cryptpwd, ls_cryptpwd64, sqlca_temp)
				
				return 1
			else
				return -1
			end if	
		else
			//Passwortvergleich mit normalen Passwort
			 if ls_user_password = arg_pwd then
				of_login_ok(arg_user, arg_pwd, ls_cryptpwd, ls_cryptpwd64, sqlca_temp)
				return 1
			else
				if of_wrong_pwd(arg_user, ls_cryptpwd, ls_cryptpwd64, sqlca_temp) then
					return -1
				else
					return -2
				end if
			end if
		end if
	else
		if ls_user_password_crypt = ls_cryptpwd64 then
			of_login_ok(arg_user, arg_pwd, ls_cryptpwd, ls_cryptpwd64, sqlca_temp)
			
			return 1
		else
			//$$HEX1$$dc00$$ENDHEX$$bergangsm$$HEX2$$e400df00$$ENDHEX$$ig Passwortvergleich mit normalen Passwort
			 if ls_user_password = arg_pwd and ii_use_cpassword = 1 then
				of_login_ok(arg_user, arg_pwd, ls_cryptpwd, ls_cryptpwd64, sqlca_temp)
				
				return 1
			else
				if of_wrong_pwd(arg_user, ls_cryptpwd, ls_cryptpwd64, sqlca_temp) then
					return -1
				else
					return -2
				end if
			end if
		end if
	end if
end if

//Normaler User, dann diverse Pr$$HEX1$$fc00$$ENDHEX$$fungen 
of_log("uo_cryptologin.of_check_pwd: VOR  isnull(ls_user_cryppwd)")

//	1) Passwortpr$$HEX1$$fc00$$ENDHEX$$fung. Bei falschem Passwort dieses zur$$HEX1$$fc00$$ENDHEX$$ckmelden
if isnull(ls_user_password_crypt) then
	if isnull(ls_user_cryppwd) then
		//Passwortvergleich mit normalen Passwort
		 if ls_user_password <> arg_pwd then
			if of_wrong_pwd(arg_user, ls_cryptpwd, ls_cryptpwd64, sqlca_temp) then
				return -1
			else
				return -2
			end if
		end if
	else
		if 	ls_user_cryppwd <> ls_cryptpwd then
			//$$HEX1$$dc00$$ENDHEX$$bergangsm$$HEX2$$e400df00$$ENDHEX$$ig Passwortvergleich mit normalen Passwort
			 if ls_user_password <> arg_pwd then
				if of_wrong_pwd(arg_user, ls_cryptpwd, ls_cryptpwd64, sqlca_temp) then
					return -1
				else
					return -2
				end if
			end if
		end if
	end if
else
	if ls_user_password_crypt <> ls_cryptpwd64 then
		//$$HEX1$$dc00$$ENDHEX$$bergangsm$$HEX2$$e400df00$$ENDHEX$$ig Passwortvergleich mit normalen Passwort
		 if ls_user_password <> arg_pwd then
			if of_wrong_pwd(arg_user, ls_cryptpwd, ls_cryptpwd64, sqlca_temp) then
				return -1
			else
				return -2
			end if
		end if
	end if
end if

//Passwortpr$$HEX1$$fc00$$ENDHEX$$fung erfolgreich, dann 
//2) Passwort ist ein Initialpasswort?
of_log("uo_cryptologin.of_check_pwd: VOR  li_user_pwd_is_init=1")

if li_user_pwd_is_init=1 then
	if  relativedate(date(ld_user_pwddate), ii_days_for_change_initpwd) >= today() then
		//Passwort ist Initalpasswort und kann noch ge$$HEX1$$e400$$ENDHEX$$ndert werden =>  R$$HEX1$$fc00$$ENDHEX$$ckmeldung Login OK ->PWD Change

		//Passwort des Users sicherheitshalber nochmal auf das Passwort in der Usertabelle setzten
		sChange = "ALTER USER " + Upper(arg_user) + " IDENTIFIED BY " +char(34)+ arg_pwd +char(34)
		execute immediate :sChange using sqlca_temp;

		return 2
	else
		//Passwort ist Initalpasswort und kann nicht mehr ge$$HEX1$$e400$$ENDHEX$$ndert werden =>  R$$HEX1$$fc00$$ENDHEX$$ckmeldung AccountLocked
		//Account locken und Protokolleintrag erstellen
		of_lock_account(arg_user, ls_cryptpwd, sqlca_temp)
			
		return -2
	end if
end if

if  relativedate(date(ld_user_pwddate), ii_maxdays_for_change) < today() then
	//Passwort ist abgelaufen zur $$HEX1$$c400$$ENDHEX$$nderung auffordern
	
	li_user_gracelogin --
	li_ret = of_grace_logins(arg_user, arg_pwd, ls_cryptpwd, ls_cryptpwd64, li_user_gracelogin, sqlca_temp)
	
	return li_ret
end if

of_log("uo_cryptologin.of_check_pwd: VOR  of_login_ok")

//Protokolleintrag erstellen
of_login_ok(arg_user, arg_pwd, ls_cryptpwd, ls_cryptpwd64, sqlca_temp)

//Erfolgreiche Anmeldung melden
return 1
end function

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
	uf.mbox(stitle,smsg)   	// Im Webservice auskommentieren / in GUI aktivieren
else
	iFile = FileOpen(is_LogPath + "cbase_webservice_" + string(Today(), "yyyymmdd"+ ".log"), LineMode!, Write!, Shared!)
	FileWrite(iFile, "[" + string(today(), "dd.mm.yyyy") + "-" + string(now(), "hh:mm:ss") + "] " + ssource+": "+sMsg)
	FileClose(iFile)
end if 

return 0
end function

public function string of_generatenewpassword (string as_mode, ref string as_error);
// --------------------------------------------------------------------------------
// Objekt : nur abh$$HEX1$$e400$$ENDHEX$$ngig von of_pwd_basiccheck()
// Methode: function generateNewPassword()
// Autor  : MHO
// --------------------------------------------------------------------------------
// Argument(e): 
// string as_mode : Modus ("WEB01")
// ref string as_error : Fehlermeldung oder Leerstring
// --------------------------------------------------------------------------------
// Return: string : Neues PWD oder leerstring bei Fehler
// --------------------------------------------------------------------------------
//  Beschreibung: Modi eingef$$HEX1$$fc00$$ENDHEX$$hrt, weil es sehr viele unterschiedliche 
//                       Passwort-Pr$$HEX1$$fc00$$ENDHEX$$froutinen gibt, die vielleicht dann doch einmal
//                       unter einem Hut zusammengefasst werden k$$HEX1$$f600$$ENDHEX$$nnen.
//  Modus "WEB01" : $$HEX1$$dc00$$ENDHEX$$bersetzung der javascript-Routine generateNewPassword()
//               von Dirk Bunk ohne Checkroutine, weil die generateRoutine schon alle 
//               Checkbedingungen f$$HEX1$$fc00$$ENDHEX$$r neue PW erf$$HEX1$$fc00$$ENDHEX$$llt.
//               Passwortroutine leicht angepasst, so dass das PWD nicht mit einer 
//               Ziffer beginnt.
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum         Version      Autor            Kommentar
// --------------------------------------------------------------------------------
//  2014-08-13     				MHO		   		Erstellung
// --------------------------------------------------------------------------------

string ls_genpass
string ls_charCode
integer li_index
integer li_charkind
integer li_exitcounter
integer li_exitcounter_max
string ls_error

as_error = ""

// Parametercheck
CHOOSE CASE as_mode
	CASE "WEB01"
		// OK
	CASE ELSE
		// Falscher Parameter
		as_error = "Wrong mode !"
		return ""		
END CHOOSE

randomize(0)

li_exitcounter=0
li_exitcounter_max = 2000

do while true
	li_exitcounter++
	ls_genpass = ""
	for li_index = 0 to 7
		li_charkind = Rand(3)
		if li_index = 0 and li_charkind = 1 then
			// Nicht mit einer Ziffer starten lassen ...
			li_charkind = 2
		end if
		
		CHOOSE CASE li_charkind 
			case 1
				 // Zuf$$HEX1$$e400$$ENDHEX$$llige Ziffer, aber keine 0 (Nullen machen nur Probleme durch Verwechslung mit "O")
				 ls_charCode = char(rand(9) + asc("1") - 1)
			case 2
                   // Zuf$$HEX1$$e400$$ENDHEX$$lliger Gro$$HEX1$$df00$$ENDHEX$$buchstabe				
				 ls_charCode = char(rand(26) + asc("A") - 1)	
			case 3
				 // Zuf$$HEX1$$e400$$ENDHEX$$lliger Kleinbuchstabe
				 ls_charCode = char(rand(26) + asc("a") - 1)
		END CHOOSE
		ls_genpass += ls_charCode	
	next

	if of_pwd_basiccheck(ls_genpass, ref ls_error) then
		// PWD pr$$HEX1$$fc00$$ENDHEX$$fen
		// Minimaler Check: Mindestens eine Ziffer, ein Gro$$HEX1$$df00$$ENDHEX$$buchstabe, ein Kleinbuchstabe und keine Ziffer am Anfang
		exit
	end if
	
	// Notausstieg gegen Endlosschleifchen
	if li_exitcounter > li_exitcounter_max then
		ls_genpass = ""
		as_error = "Was not able to generate a new valid password !"
		exit 
	end if	
loop

return ls_genpass 
end function

public function boolean of_pwd_basiccheck (string as_password, ref string as_error);
// --------------------------------------------------------------------------------
// Objekt : unabh$$HEX1$$e400$$ENDHEX$$ngig
// Methode: function boolean of_pwd_basiccheck (string as_genpass, ref string as_error)
// Autor  : MHO
// --------------------------------------------------------------------------------
// ACHTUNG: Dies ist eine statische Methode, die unabh$$HEX1$$e400$$ENDHEX$$ngig vom Rest des  
//                 Objekts genutzt werden kann.
// --------------------------------------------------------------------------------
// Argument(e): 
// string as_password : Das zu pr$$HEX1$$fc00$$ENDHEX$$fende Passwort
// ref string as_error : Fehlermeldung oder Leerstring
// --------------------------------------------------------------------------------
// Return: booelan : PWD ist OK oder nicht
// --------------------------------------------------------------------------------
//  Beschreibung: PWD pr$$HEX1$$fc00$$ENDHEX$$fen. Minimaler Check: Mindestens eine Ziffer, 
//                ein Gro$$HEX1$$df00$$ENDHEX$$buchstabe, ein Kleinbuchstabe und keine Ziffer am Anfang,
//                keine Nullen
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum         Version      Autor            Kommentar
// --------------------------------------------------------------------------------
//  2014-09-09     				MHO		   		Erstellung
// --------------------------------------------------------------------------------

boolean lb_return, lb_found
string ls_char
long ll_index

as_error = ""
lb_return  = true

ls_char = left(as_password, 1) 
if asc(ls_char) >= asc("0") and asc(ls_char) <= asc("9") then
	as_error = "Password starts with a digit!"
	lb_return  = false
end if

if lb_return then
	// Keine Nullen
	for ll_index = 1 to len(as_password)
		ls_char = mid(as_password, ll_index, 1)
		if ls_char = "0" then
			as_error = "Password contains digit zero!"
			lb_return =  false
			exit
		end if
	next
end if

if lb_return then
	// Ziffer vorhanden?
	lb_return =  false
	for ll_index = 1 to len(as_password)
		ls_char = mid(as_password, ll_index, 1)
		if asc(ls_char) >= asc("0") and asc(ls_char) <= asc("9") then
			lb_return =  true
			exit
		end if	
	next
	if not lb_return then
		as_error = "Password does not contain digits!"
	end if
end if

if lb_return then
	// Gro$$HEX1$$df00$$ENDHEX$$buchstaben vorhanden?
	lb_return =  false
	for ll_index = 1 to len(as_password)
		ls_char = mid(as_password, ll_index, 1)
		if asc(ls_char) >= asc("A") and asc(ls_char) <= asc("Z") then
			lb_return =  true
			exit
		end if	
	next
	if not lb_return then
		as_error = "Password does not contain upper case letters!"
	end if
end if

if lb_return then
	// Kleinbuchstaben vorhanden?
	lb_return =  false
	for ll_index = 1 to len(as_password)
		ls_char = mid(as_password, ll_index, 1)
		if asc(ls_char) >= asc("a") and asc(ls_char) <= asc("z") then
			lb_return =  true
			exit
		end if	
	next
	if not lb_return then
		as_error = "Password does not contain lower case letters!"
	end if
end if

if lb_return then
	if of_check_negativliste(as_password, sqlca) then
		as_error = "Password is on Blacklist!"
		lb_return = false
	end if
end if

return lb_return
end function

public function string of_replaceall (string as_oldstring, string as_findstr, string as_replace);
// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_ReplaceAll
//
// PURPOSE:    This function replaces all occurrences of a string in another.
//
// ARGUMENTS:  as_oldstring	- The string to update
//					as_findstr		- The string to look for
//					as_replace		- The string to replace with
//
// RETURN:     The updated string
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/18/2011	RolandS		Initial Coding
// -----------------------------------------------------------------------------

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

public function blob of_decode64 (string as_encoded);
// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_Decode64
//
// PURPOSE:    This function converts a Base64 encoded string to binary.
//
//					Note: Requires Windows XP or Server 2003
//
// ARGUMENTS:  as_encoded - String containing encoded data
//
// RETURN:     Blob containing decoded data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/18/2011	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Blob lblob_data
ULong lul_len, lul_buflen, lul_skip, lul_pflags
Boolean lb_rtn

lul_len = Len(as_encoded)
lul_buflen = lul_len
lblob_data = Blob(Space(lul_len))

lb_rtn = CryptStringToBinary(as_encoded, &
					lul_len, CRYPT_STRING_BASE64, lblob_data, &
					lul_buflen, lul_skip, lul_pflags)

Return BlobMid(lblob_data, 1, lul_buflen)

end function

public function string of_encode64 (blob ablob_data);
// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_Encode64
//
// PURPOSE:    This function converts binary data to a Base64 encoded string.
//
//					Note: Requires Windows XP or Server 2003
//
// ARGUMENTS:  ablob_data - Blob containing data
//
// RETURN:     String containing encoded data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/18/2011	RolandS		Initial Coding
// -----------------------------------------------------------------------------

String ls_encoded
ULong lul_len, lul_buflen
Boolean lb_rtn

lul_len = Len(ablob_data)

lul_buflen = lul_len * 2

ls_encoded = Space(lul_buflen)

lb_rtn = CryptBinaryToString(ablob_data, &
				lul_len, CRYPT_STRING_BASE64, &
				ls_encoded, lul_buflen)

If lb_rtn Then
	ls_encoded = of_ReplaceAll(ls_encoded, "~r~n", "")
Else
	ls_encoded = ""
End If

Return ls_encoded

end function

public function long of_get_testlogin (ref string arg_user, ref string arg_pwd);
// --------------------------------------------------------------------------------
// Objekt : 
// Methode: function long of_get_testlogin (ref string arg_user, ref string arg_pwd)
// Autor  : MHO
// --------------------------------------------------------------------------------
// Argument(e):
// 	ref string arg_user, ref string arg_pwd :  R$$HEX1$$fc00$$ENDHEX$$ckgabe User und PWD
// --------------------------------------------------------------------------------
// Return: 0
// --------------------------------------------------------------------------------
//  Beschreibung: Holt den hier hart kodierten User, der z.B. f$$HEX1$$fc00$$ENDHEX$$r die Login-Prozedur 
//                ben$$HEX1$$f600$$ENDHEX$$tigt wird zusammen mit seinem PWD.
//                Dieser User muss auf jeder Datenbank/Instance existieren.
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum         Version      Autor            Kommentar
// --------------------------------------------------------------------------------
//  2014-09-10     				MHO		   		Erstellung
// --------------------------------------------------------------------------------

arg_user = this.is_pwd_user
arg_pwd = this.is_pwd_pwd

return 0
end function

public function boolean of_valid_password (string arg_pwd, ref string arg_returntext);integer i, j

arg_returntext = ""

if len(arg_pwd) < this.ii_min_password_length then
	//uf.mbox("Passwortfehler",  "Passwort zu kurz")
	arg_returntext = "Passwort zu kurz"
	return false
end if

if not Match(arg_pwd, "[A-Z]") then
	//uf.mbox("Passwortfehler", "Passwort ohne Gro$$HEX1$$df00$$ENDHEX$$buchstabe nicht erlaubt")
	arg_returntext = "Passwort ohne Gro$$HEX1$$df00$$ENDHEX$$buchstabe nicht erlaubt"
	return false
end if

if not Match(arg_pwd, "[a-z]") then
	//uf.mbox("Passwortfehler", "Passwort ohne Kleinbuchstabe nicht erlaubt")
	arg_returntext = "Passwort ohne Kleinbuchstabe nicht erlaubt"
	return false
end if

j = 0
for i=1 to len(arg_pwd) 
	if pos(this.is_allowed_symbols, mid(arg_pwd, i, 1))>0 then 
		j=1
	elseif Match(mid(arg_pwd, i, 1), "[0-9]") then
		j=1
	elseif Match(mid(arg_pwd, i, 1), "[a-zA-Z]") then
		
	else
		//uf.mbox("Passwortfehler", "Zeichen >${"+mid(arg_pwd, i, 1)+"}< nicht erlaubt")
		arg_returntext = "Zeichen >${"+mid(arg_pwd, i, 1)+"}< nicht erlaubt"
		return false
	end if
next

if j=0 then
	//uf.mbox("Passwortfehler", "Passwort ohne Ziffer oder Sonderzeichen (${"+this.is_allowed_symbols+"}) ist nicht erlaubt")
	arg_returntext = "Passwort ohne Ziffer oder Sonderzeichen (${"+ this.is_allowed_symbols +"}) ist nicht erlaubt"
	return false
end if

select count(*) into :i from sys_login_negativ where instr ( UPPER(:arg_pwd) , UPPER(cpassword), 1, 1)>0;

if i>0 then 
	//uf.mbox("Passwortfehler", "Passwort ist in Negativliste enthalten")
	arg_returntext = "Passwort ist in Negativliste enthalten"
	
	return false
end if

return true

end function

public function integer of_change_password (string arg_user, string arg_mandant, string arg_password, transaction arg_sqlca);
/* 
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
*  -3 	    Neues Passwort ist in der Negativeliste
*  -4      Heute zu oft ge$$HEX1$$e400$$ENDHEX$$ndert
*/

string 	ls_cryptpwd, ls_pwd, ls_dat, sChange, ls_cryptpwd64
string 	ls_oldpwds[], ls_old[]
string 	ls_oldpwds64[], ls_old64[], ls_temp
integer 	i, ii_error
long 		ll_histkey
blob    	lb_cryptpwd, lb_pwd
date  		ld_date

// 13.10.2015 HR: Pr$$HEX1$$fc00$$ENDHEX$$fung Negativliste ausgelagert
if of_check_negativliste(arg_password, arg_sqlca) then
	return -3
end if

// --------------------------------------------------------------------------------------------------------------------
// 22.06.2015 HR: Es darf maximal dreimal am Tag das Passwort ge$$HEX1$$e400$$ENDHEX$$ndert werden
// 22.03.2016 HR: Auf Variable umgestellt
// --------------------------------------------------------------------------------------------------------------------
if ib_pwd_want_change then

	select count(*) into :i 
	 from sys_login_history slh, sys_login sl 
	where slh.nlogin_histkind_key	= 1 
		 and sl.cusername 			= :arg_user
		 and sl.nuser_id				= slh.nuser_id 
		 and trunc(slh.dchange)		= trunc(sysdate) 
	  using arg_sqlca;

	if i >= ii_max_changes_per_day then return -4
end if

//Passwort verschl$$HEX1$$fc00$$ENDHEX$$sseln
ls_cryptpwd= of_encrypt(arg_password)

// --------------------------------------------------------------------------------------------------------------------
// 22.03.2016 HR: Wir speichern das Passwort nicht mehr als Blob sondern als String, daher wandeln 
//                        wir das verschl$$HEX1$$fc00$$ENDHEX$$sselte Passwort mit BASE64 um
// --------------------------------------------------------------------------------------------------------------------
ls_cryptpwd64 			= of_encrypt_base64(arg_password, is_crypto_key)
is_pwd_crpt_temp 	= ls_cryptpwd64 // 26.04.2016 HR:

lb_cryptpwd = blob(ls_cryptpwd)

ls_dat = string(today(),"dd.mm.yyyy")
// 05.06.2009 HR:
ld_date = today()

//Holen der alte Passw$$HEX1$$f600$$ENDHEX$$rter der letzten $$HEX1$$c400$$ENDHEX$$nderungen vorbereiten
 DECLARE passwoerter CURSOR FOR  
  SELECT sys_login_history.nlogin_history_key, CUSER_PWD
    FROM sys_login_history  
   WHERE ( sys_login_history.nlogin_histkind_key 	= 1 ) 
	   AND ( sys_login_history.cusername 			= :arg_user )   
ORDER BY sys_login_history.dchange DESC 
 using arg_sqlca;

open passwoerter;

i = 0 

//Passw$$HEX1$$f600$$ENDHEX$$rter holen (max letzten 10 Passw$$HEX1$$f600$$ENDHEX$$rter)
if arg_sqlca.sqlcode=0 then
	do

		fetch passwoerter into :ll_histkey, :ls_temp;
		
		if arg_sqlca.sqlcode=0 then
			ii_error = 0
			
			if ls_temp > " " then
				ls_oldpwds64[ upperbound(ls_oldpwds64) + 1 ] = ls_temp
			end if
			
			selectblob ruser_pwd into:lb_pwd 
			       from sys_login_history 
		         where nlogin_history_key = :ll_histkey 
				  using arg_sqlca;
				  
			if arg_sqlca.sqlcode=0 then
				if not isnull(lb_pwd) then
					i++
					ls_oldpwds[i]=string(lb_pwd)
					ls_old[i]=of_decrypt(string(lb_pwd))
				end if
			else
				//outputMsg ("uo_cryptologin.of_change_password()","Achtung","SQL-ERROR"+string(arg_sqlca.sqlcode)+" "+arg_sqlca.sqlerrtext)
			end if
		else
			ii_error = 1
		end if
	loop until ii_error = 1 or i=10 or upperbound(ls_oldpwds64)=10
	
	close passwoerter;
end if

// 22.03.2016 HR: Wenn schon mal ein Passwort ge$$HEX1$$e400$$ENDHEX$$ndert wurde, dann pr$$HEX1$$fc00$$ENDHEX$$fen, ob das neu schon mal verwendet wurde. Zuerst gegen neues Feld
if upperbound(ls_oldpwds64) > 0 then
	for i=1 to upperbound(ls_oldpwds64)
		if ls_oldpwds64[i]=ls_cryptpwd64 then return -1 //Passwort wurde schon verwendet, dann raus hier
	next
else
	//Wenn schon mal ein Passwort ge$$HEX1$$e400$$ENDHEX$$ndert wurde, dann pr$$HEX1$$fc00$$ENDHEX$$fen, ob das neu schon mal verwendet wurde
	if i>0 then
		for i=1 to upperbound(ls_oldpwds)
			if ls_oldpwds[i]=ls_cryptpwd then return -1 //Passwort wurde schon verwendet, dann raus hier
		next
	end if
end if

//Passwort$$HEX1$$e400$$ENDHEX$$nderung speichern
if ii_use_cpassword = 1 then
	UPDATE sys_login  
		SET cuserpassword 			= :arg_password, 
			npwd_is_init 				= 0,
			cpwd_date 					= :ls_dat,
			dpwd_date 					= :ld_date,
			NGRACE_LOGINS			= :ii_max_grace_Logins,
			CUSER_PWD				= :ls_cryptpwd64
	WHERE ( sys_login.cclient		= :arg_mandant ) AND  
			 ( sys_login.cusername 	= :arg_user )  
      using arg_sqlca;

else
	UPDATE sys_login  
		SET cuserpassword 			= '..--..', 
			npwd_is_init 				= 0,
			cpwd_date 					= :ls_dat,
			dpwd_date 					= :ld_date,
			NGRACE_LOGINS			= :ii_max_grace_Logins,
			CUSER_PWD				= :ls_cryptpwd64
	WHERE ( sys_login.cclient		= :arg_mandant ) AND  
			 ( sys_login.cusername 	= :arg_user ) 
	 using arg_sqlca;
	
end if

If arg_sqlca.sqlcode = 0 Then
	updateblob sys_login
			 set ruser_pwd 			= :lb_cryptpwd
		 where ( sys_login.cclient	= :arg_mandant ) AND  
			 ( sys_login.cusername	= :arg_user )
			 using arg_sqlca;
end if	

If arg_sqlca.sqlcode <> 0 Then
//	uf.mbox("Kennwort $$HEX1$$e400$$ENDHEX$$ndern","Kennwort konnte nicht gespeichert werden.~nFehlercode: ${" + string(sqlca.SQLCode)+"}")
	outputmsgtrans("uo_cryptologin.of_change_password()", "Kennwort $$HEX1$$e400$$ENDHEX$$ndern","Kennwort konnte nicht gespeichert werden.~nFehlercode: ${" + string(arg_sqlca.SQLDBCode)+" "+arg_sqlca.sqlerrtext+"}")
	is_error = "Kennwort konnte nicht gespeichert werden.  Fehlercode: " + string(arg_sqlca.SQLDBCode)+" "+arg_sqlca.sqlerrtext
	return -2
End if	

// --------------------------------
// auch in der Datenbank
// --------------------------------				 
sChange = "ALTER USER " + Upper(arg_user) + " IDENTIFIED BY " +char(34)+ arg_password+char(34)

execute immediate :sChange using arg_sqlca;

If arg_sqlca.sqldbcode <> 0 Then
//	uf.mbox("Kennwort $$HEX1$$e400$$ENDHEX$$ndern","Kennwort konnte nicht ge$$HEX1$$e400$$ENDHEX$$ndert werden.~nFehlercode: ${" + string(sqlca.SQLDBCode)+"}")
	outputmsgtrans("uo_cryptologin.of_change_password()", "Kennwort $$HEX1$$e400$$ENDHEX$$ndern","Kennwort konnte nicht ge$$HEX1$$e400$$ENDHEX$$ndert werden.~nFehlercode: ${" + string(arg_sqlca.SQLDBCode)+" "+arg_sqlca.sqlerrtext+"}")
	is_error = "Kennwort konnte nicht ge$$HEX1$$e400$$ENDHEX$$ndert werden. Fehlercode: " + string(arg_sqlca.SQLDBCode)+" "+arg_sqlca.sqlerrtext
	rollback using arg_sqlca;
	return -2
End if

commit using arg_sqlca;

of_pwd_prot(arg_user, ls_cryptpwd, ls_cryptpwd64, 1, arg_sqlca)

return 1
end function

public function integer of_log (string smsg);// --------------------------------------------------------------------------------
// Objekt : uo_webservice
// Methode: of_log (Function)
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
//
// --------------------------------------------------------------------------------

integer iFile
String	sLogUser, sLogPath
sLogUser = "uo_crypto"

sLogPath = "c:\temp\cbase\"

if this.iTrace = 0 then return 0

iFile = FileOpen(sLogPath + "cbase_webservice_" + sLogUser + "_" + string(Today(), "yyyymmdd") + ".log", LineMode!, Write!, Shared!)
FileWrite(iFile, "[" + string(today(), "dd.mm.yyyy") + "-" + string(now(), "hh:mm:ss") + "] " + sMsg)
FileClose(iFile)

return 0
end function

public function string of_dateformat ();String	sRegKey, sMask, sCountry, sDateCheck
	
	sRegKey = "HKEY_CURRENT_USER\Control Panel\International"
	If RegistryGet(sRegKey, "sShortDate", RegString!, sMask) = -1 Then
		// ------------------------------------
		// Bei Fehler, deutsches Datumsformat
		// ------------------------------------
		
		//DB 05.02.2009: Globales CBASE-Shortdateformat setzen (Auf zwei Jahresstellen verk$$HEX1$$fc00$$ENDHEX$$rzt)
		s_app.sshortdateformat = "dd.mm.yy"
		
		//uf.mbox("Warnung","Das Datumsformat konnte nicht aus der Registry ermittelt werden,~nes wird das deutsche Datumsformat verwendet.")
		
		Return "dd.mm.yyyy"
		
	Else
		// -------------------------------------------------
		// OK, RegistryGet war in Ordnung nun die Pr$$HEX1$$fc00$$ENDHEX$$fung.
		// -------------------------------------------------
		
		//DB 30.01.2009: Pr$$HEX1$$fc00$$ENDHEX$$fung in Deutschland $$HEX1$$fc00$$ENDHEX$$ber ini zusachaltbar
		sDateCheck = profilestring(s_app.sProfile,"LocalSettings","CheckDateFormat","1")
		Setprofilestring(s_app.sProfile,"LocalSettings","CheckDateFormat",sDateCheck)
		
		If (len(sMask) < 10 and sDateCheck = "1" ) Then
		//	uf.mbox("Warnung","Cbase anywhere verwendet ein 10 stelliges Datumsformat,~ndie gegenwertige Rechnereinstellung entspicht nicht diesem Standard.")
			Return "error"
		End if
		
		//DB 05.02.2009: Globales CBASE-Shortdateformat setzen (Auf zwei Jahresstellen verk$$HEX1$$fc00$$ENDHEX$$rzt)
		s_app.sshortdateformat = Replace(sMask, Pos(lower(sMask), "yyyy"), 2, "")
		
		Return sMask
	End if	
end function

public function integer outputquestion (string ssource, string stitle, string smsg, integer ndefault);
integer iFile

if is_LogPath = "" then 
	iFile = Messagebox (stitle, smsg, question!, yesno!)
else
	iFile = ndefault
end if 

return iFile
end function

public function boolean of_check_negativliste (string arg_password, transaction arg_sqlca);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_cryptologin
// Methode: of_check_negativliste (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_password
//  transaction arg_sqlca
// --------------------------------------------------------------------------------------------------------------------
// Return: boolean
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  13.10.2015	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
integer i

//Pr$$HEX1$$fc00$$ENDHEX$$fen, ob neues Passwort in der Negativeliste enthalten ist
select count(*) into :i 
 from sys_login_negativ 
where instr ( UPPER(:arg_password) , UPPER(cpassword), 1, 1)>0 
 using arg_sqlca;

if arg_sqlca.sqlcode = 0 then
	if i>0 then
		return true
	else
		return false
	end if
else
	return false
end if
end function

public function string of_encrypt_base64 (string as_data, string as_password);String ls_encrypted//, ls_newpass, ls_msgtext
Blob lblob_data, lblob_encrypted
//Integer li_count = 1
//
// encrypt the data
lblob_data = Blob(as_data, EncodingAnsi!)
lblob_encrypted = this.of_EncryptDecrypt( &
								lblob_data, as_password, True)
ls_encrypted = of_encode64(lblob_encrypted)

Return ls_encrypted

end function

public subroutine of_login_ok (string arg_user, string arg_pwd, string arg_cryptpwd, string arg_cryptpwd_base64, transaction arg_sqlca);/* 
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

// --------------------------------------------------------------------------------------------------------------------
// 26.04.2016 HR: Wenn das verschl$$HEX1$$fc00$$ENDHEX$$sselte neue Passwort gesetzt ist, dann speichern wir es noch mal
// --------------------------------------------------------------------------------------------------------------------
if is_pwd_crpt_temp = "" then
	update sys_login
		set nfailed_logins 		= 0,
			clastlogin 			= :a,
			NGRACE_LOGINS	= :ii_max_grace_Logins
		where cusername 		= :arg_user
		using arg_sqlca;
else
	update sys_login
		set nfailed_logins 		= 0,
			clastlogin 			= :a,
			NGRACE_LOGINS	= :ii_max_grace_Logins,
			CUSER_PWD 		= :is_pwd_crpt_temp
		where cusername 		= :arg_user
		using arg_sqlca;
end if

updateblob sys_login
     	 set ruser_pwd 	= :lb_pwd,
	 where cusername 	= :arg_user 
	using arg_sqlca;
	
if arg_sqlca.sqlcode<>0 then
	outputMsg ("uo_cryptologin.of_login_ok()","","Error saving the password "+arg_sqlca.sqlerrtext)
end if
	
sChange = "ALTER USER " + Upper(arg_user) + " IDENTIFIED BY "+char(34) + arg_pwd+char(34)
execute immediate :sChange using arg_sqlca ;

if arg_sqlca.sqlcode<>0 then
	// 09.09.2010 HR: "ORA-28007: the password cannot be reused" nicht als Fehler ausgeben
	if arg_sqlca.sqldbcode<>28007 then
		outputMsg ("uo_cryptologin.of_login_ok()","","Error changing the Password "+arg_sqlca.sqlerrtext)
	end if
end if

commit using arg_sqlca;
end subroutine

public function boolean of_wrong_pwd (string arg_user, string arg_cryptpwd, string arg_cryptpwd_base64, transaction arg_sqlca);/* 
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


select nfailed_logins, 
		naccount_locked 
   into :li_faild, 
		:li_locked
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

// --------------------------------------------------------------------------------------------------------------------
// 26.04.2016 HR: Wenn das verschl$$HEX1$$fc00$$ENDHEX$$sselte neue Passwort gesetzt ist, dann speichern wir es noch mal
// --------------------------------------------------------------------------------------------------------------------
if is_pwd_crpt_temp = "" then
	update sys_login
		set nfailed_logins 		= :li_faild,
			naccount_locked 	= :li_locked
		where cusername 		= :arg_user
		using arg_sqlca;
else
	update sys_login
		set nfailed_logins 		= :li_faild,
			naccount_locked 	= :li_locked,
			CUSER_PWD 		= :is_pwd_crpt_temp
		where cusername 		= :arg_user
		using arg_sqlca;
end if

commit using arg_sqlca;
		
if li_locked = 1 then
	of_pwd_prot(arg_user, arg_cryptpwd, arg_cryptpwd_base64, 3, arg_sqlca)	
	return false
else
	of_pwd_prot(arg_user, arg_cryptpwd, arg_cryptpwd_base64, 2, arg_sqlca)
	return true
end if
end function

public subroutine of_pwd_prot (string arg_user, string arg_cryptpwd, string arg_cryptpwd_base64, integer arg_was, transaction arg_sqlca);/* 
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
blob lb_pwd

string ls_c_user, ls_c_ClientIP, ls_c_Host

if isnull(s_app.sUser)  or trim(s_app.sUser) = "" then
	ls_c_user = "n/a"
else
	ls_c_user = s_app.sUser
end if

if isnull(s_app.sClientIP)  or trim(s_app.sClientIP) = ""  then
	ls_c_ClientIP = "n/a"
else
	ls_c_ClientIP = s_app.sClientIP
end if

if isnull(s_app.sHost)  or trim(s_app.sHost) = ""  then
	ls_c_Host = "n/a"
else
	ls_c_Host = s_app.sHost
end if

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
		  CUSER_PWD )  
  VALUES ( :ll_hist_key,   
           :ll_user_id,   
           :arg_user,   
           sysdate,   
           :arg_was,   
           :ls_c_user,   
           :ls_c_ClientIP,   
           :ls_c_Host,   
           :is_prog_version,
		  :arg_cryptpwd_base64)  
  using arg_sqlca;

if arg_sqlca.sqlcode <>0 then 
	outputMsg ("uo_cryptologin.of_pwd_prot()","Achtung","Error insert the protocol")
end if

lb_pwd = blob(arg_cryptpwd)

updateblob sys_login_history
     	 set ruser_pwd 			= :lb_pwd,
	 where nlogin_history_key 	= :ll_hist_key 
	using arg_sqlca;

if arg_sqlca.sqlcode <>0 then 
	outputMsg ("uo_cryptologin.of_pwd_prot()","Achtung","Error Update PWD-BLOB")
end if

commit using arg_sqlca;

end subroutine

public function integer of_grace_logins (string arg_user, string arg_pwd, string arg_cryptpwd, string arg_cryptpwd_base64, integer arg_grace_logins, transaction arg_sqlca);/* 
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
if  arg_grace_logins > 0 then
	if outputquestion("", "","Your Password is expired. You have "+string(arg_grace_logins)+" grace logins.~r~nWould you like to change it now?", 1)=2 then
		// Anwender will Passwort noch nicht $$HEX1$$e400$$ENDHEX$$ndern, dann muss er es nocht nicht
		li_ret = 1
	end if
end if

lb_pwd=blob(arg_cryptpwd)

a=string(today(),"dd.mm.yyyy")+" "+string(now(),"hh:mm:ss")

// --------------------------------------------------------------------------------------------------------------------
// 26.04.2016 HR: Wenn das verschl$$HEX1$$fc00$$ENDHEX$$sselte neue Passwort gesetzt ist, dann speichern wir es noch mal
// --------------------------------------------------------------------------------------------------------------------
if is_pwd_crpt_temp = "" then
	update sys_login
		set  NGRACE_LOGINS = :arg_grace_logins,
			  clastlogin 			= :a
	where cusername 			= :arg_user
	using arg_sqlca;
else
	update sys_login
		set  NGRACE_LOGINS = :arg_grace_logins,
			  clastlogin 			= :a,
			  CUSER_PWD		= :is_pwd_crpt_temp
	where cusername 			= :arg_user
	using arg_sqlca;
end if

updateblob sys_login
     	 set ruser_pwd 	= :lb_pwd,
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

public function string of_encrypt_base64 (string as_data);Return of_encrypt_base64(as_data, is_crypto_key)

end function

public function string of_decrypt_base64 (string as_data);Return of_decrypt_base64(as_data, is_crypto_key)

end function

public function string of_decrypt_base64 (string as_data, string as_password);String ls_encrypted//, ls_newpass, ls_msgtext
Blob lblob_data, lblob_encrypted
//Integer li_count = 1
//
// encrypt the data
//lblob_data = Blob(as_data, EncodingAnsi!)

lblob_data = of_decode64(as_data)

lblob_encrypted = this.of_EncryptDecrypt( &
								lblob_data, as_password, false)

Return string(lblob_data, EncodingANSI!)

end function

public subroutine of_init ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_cryptologin
// Methode: of_init (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------------------------------------------
// Return: none
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:  Issues #3277 User und Passwort verstecken
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  15.01.2018	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

is_crypto_key 	= "L"
is_pwd_user 	= "S"
is_pwd_pwd 	= "t"

is_crypto_key 	+= "S"
is_pwd_user 	+= "Y"
is_pwd_pwd 	+= "e"

is_crypto_key 	+= "Y"
is_pwd_user 	+= "S"
is_pwd_pwd 	+= "s"

is_crypto_key 	+= "c"
is_pwd_user 	+= "_"
is_pwd_pwd 	+= "t"

is_crypto_key 	+= "b"
is_pwd_user 	+= "P"
is_pwd_pwd 	+= ""

is_crypto_key 	+= "a"
is_pwd_user 	+= "W"
is_pwd_pwd 	+= ""

is_crypto_key 	+= "s"
is_pwd_user 	+= "D"
is_pwd_pwd 	+= ""

is_crypto_key 	+= "e"
is_pwd_user 	+= "_"
is_pwd_pwd 	+= ""

is_crypto_key 	+= "C"
is_pwd_user 	+= "C"
is_pwd_pwd 	+= ""

is_crypto_key 	+= "r"
is_pwd_user 	+= "H"
is_pwd_pwd 	+= ""

is_crypto_key 	+= "y"
is_pwd_user 	+= "A"
is_pwd_pwd 	+= ""

is_crypto_key 	+= "p"
is_pwd_user 	+= "N"
is_pwd_pwd 	+= ""

is_crypto_key 	+= "t"
is_pwd_user 	+= "G"
is_pwd_pwd 	+= ""

is_crypto_key 	+= "o"
is_pwd_user 	+= "E"
is_pwd_pwd 	+= ""

is_crypto_key 	+= "2"
is_pwd_user 	+= ""
is_pwd_pwd 	+= ""

is_crypto_key 	+= "0"
is_pwd_user 	+= ""
is_pwd_pwd 	+= ""

is_crypto_key 	+= "0"
is_pwd_user 	+= ""
is_pwd_pwd 	+= ""

is_crypto_key 	+= "8"
is_pwd_user 	+= ""
is_pwd_pwd 	+= ""

end subroutine

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

// --------------------------------------------------------------------------------------------------------------------
// 15.01.2018 HR: Issues #3277 User und Passwort verstecken
// --------------------------------------------------------------------------------------------------------------------
of_init()


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
ii_maxdays_for_change 		= 60

//Anzahl Fehlversuche bis AccountLock
ii_max_wrong_logins 			= 5

// 23.06.2015 HR: Variable hier bef$$HEX1$$fc00$$ENDHEX$$llen, um es im WEB auskommentiern zu k$$HEX1$$f600$$ENDHEX$$nnen
is_prog_version 				= s_app.sVersion+"-"+s_app.sBuild	 
end event

