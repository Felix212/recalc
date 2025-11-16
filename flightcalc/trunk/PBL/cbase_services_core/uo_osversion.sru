HA$PBExportHeader$uo_osversion.sru
forward
global type uo_osversion from nonvisualobject
end type
type osversioninfoex from structure within uo_osversion
end type
type system_info from structure within uo_osversion
end type
type langandcodepage from structure within uo_osversion
end type
type vs_fixedfileinfo from structure within uo_osversion
end type
end forward

type osversioninfoex from structure
	unsignedlong		dwosversioninfosize
	unsignedlong		dwmajorversion
	unsignedlong		dwminorversion
	unsignedlong		dwbuildnumber
	unsignedlong		dwplatformid
	character		szcsdversion[128]
	unsignedinteger		wservicepackmajor
	unsignedinteger		wservicepackminor
	unsignedinteger		wsuitemask
	unsignedinteger		wproducttype
end type

type system_info from structure
	integer		wprocessorarchitecture
	integer		wreserved
	long		dwpagesize
	long		lpminimumapplicationaddress
	long		lpmaximumapplicationaddress
	long		dwactiveprocessormask
	long		dwnumberofprocessors
	long		dwprocessortype
	long		dwallocationgranularity
	unsignedinteger		wprocessorlevel
	unsignedinteger		wprocessorrevsion
end type

type langandcodepage from structure
	integer		wlanguageid
	integer		wcharacterset
end type

type vs_fixedfileinfo from structure
	unsignedlong		dwsignature
	unsignedlong		dwstrucversion
	unsignedlong		dwfileversionms
	unsignedlong		dwfileversionls
	unsignedlong		dwproductversionms
	unsignedlong		dwproductversionls
	unsignedlong		dwfileflagsmask
	unsignedlong		dwfileflags
	unsignedlong		dwfileos
	unsignedlong		dwfiletype
	unsignedlong		dwfilesubtype
	unsignedlong		dwfiledatems
	unsignedlong		dwfiledatels
end type

global type uo_osversion from nonvisualobject autoinstantiate
end type

type prototypes
Function integer GetSystemMetrics ( &
	integer nIndex &
	) Library "user32.dll"

Function Boolean GetVersionEx ( &
	Ref OSVERSIONINFOEX lpVersionInformation &
	) Library "kernel32.dll" Alias For "GetVersionExW"

Function Boolean GetProductInfo ( &
	ulong dwOSMajorVersion, &
	ulong dwOSMinorVersion, &
	ulong dwSpMajorVersion, &
	ulong dwSpMinorVersion, &
	Ref ulong pdwReturnedProductType &
	) Library "kernel32.dll"

Subroutine GetNativeSystemInfo ( &
	Ref SYSTEM_INFO lpSystemInfo &
	) Library "kernel32.dll"

Subroutine GetSystemInfo ( &
	Ref SYSTEM_INFO lpSystemInfo &
	) Library "kernel32.dll"

Function Boolean IsWow64Process ( &
	long hProcess, &
	Ref boolean Wow64Process &
	) Library "kernel32.dll"

Function Long GetCurrentProcess ( &
	) Library "kernel32.dll"

Subroutine CopyMemory ( &
	Ref string Destination, &
	long Source, &
	long Length &
	) Library "kernel32.dll" Alias For "RtlMoveMemory"

Subroutine CopyMemory ( &
	Ref structure Destination, &
	long Source, &
	long Length &
	) Library 'kernel32.dll' Alias For "RtlMoveMemory"

Function long GetFileVersionInfoSize ( &
	string lptstrFilename, &
	Ref ulong lpdwHandle &
	) Library "version.dll" Alias For "GetFileVersionInfoSizeW"

Function boolean GetFileVersionInfo ( &
	string lptstrFilename, &
	long dwHandle, &
	long dwLen, &
	Ref blob lpData &
	) Library "version.dll" Alias For "GetFileVersionInfoW"

Function boolean VerQueryValue ( &
	Ref blob lpBlock, &
	string lpSubBlock, &
	Ref ulong lplpBuffer, &
	Ref uint puLen &
	) Library "version.dll" Alias For "VerQueryValueW"

FUNCTION int GetModuleFileNameA (&
      ulong hinstModule, &
	 REF string lpszPath, &
	 ulong cchPath &
	 ) LIBRARY "kernel32" alias for "GetModuleFileNameA;Ansi"
end prototypes

type variables
// -----------------------------------------------------------------------------
// Version 1.0 vom 17.06.2020
// -----------------------------------------------------------------------------

/*

// --------------------------------------------------------------------------------------------------------------------
// 17.06.2020 HR: Wir holen uns die Version aus der EXE
// --------------------------------------------------------------------------------------------------------------------
uo_osversion 	luo_osver
	
luo_osver.of_get_myfileversion( gs_Version , gs_Build )
//luo_osver.of_get_myfileversion( sVersion , sBuild )
//luo_osver.of_get_myfileversion( s_app.sVersion )

*/
String Comments
String CompanyName
String FileDescription
String FileVersion
String InternalName
String LegalCopyright
String LegalTrademarks
String OriginalFilename
String ProductName
String ProductVersion
String PrivateBuild
String SpecialBuild
String FixedProductVersion
String FixedFileVersion

Uint MajorVersion
Uint MinorVersion
Uint BuildNumber
Uint ServicePackMajor
Uint ServicePackMinor
Uint SuiteMask
Uint ProductType

end variables

forward prototypes
public function string of_pbvmname ()
public function string of_getproductinfo ()
public function boolean of_getosversion (ref string as_osversion, ref string as_osedition, ref string as_csdversion)
public function boolean of_getfileversioninfo (string as_filename)
public function integer of_getosbits ()
public function string of_hex (unsignedlong aul_decimal, integer ai_length)
public function string of_getfileversion (string arg_file)
public subroutine of_get_myfileversion (ref string arg_version, ref string arg_build)
public subroutine of_get_myfileversion (ref string arg_version)
end prototypes

public function string of_pbvmname ();// This function the name of the PowerBuilder VM file.

Environment le_env
String ls_vmname

GetEnvironment(le_env)

choose case le_env.PBMajorRevision
	case 10, 11, 12
		If le_env.PBMinorRevision = 5 Then
			ls_vmname = "pbvm" + String(le_env.PBMajorRevision) + "5.dll"
		Else
			ls_vmname = "pbvm" + String(le_env.PBMajorRevision) + "0.dll"
		End If
	case else
		ls_vmname = "pbvm" + String(le_env.PBMajorRevision) + "0.dll"
end choose

Return ls_vmname

end function

public function string of_getproductinfo ();// This function gets product info from Vista & Newer

String ls_info
ULong lul_ProductType
Boolean lb_rtn

lb_rtn = GetProductInfo(MajorVersion, MinorVersion, &
					ServicePackMajor, ServicePackMinor, lul_ProductType)

// this is just a few of the types
choose case lul_ProductType
	case 1
		ls_info = "Ultimate"
	case 28
		ls_info = "Ultimate N"
	case 6
		ls_info = "Business"
	case 16
		ls_info = "Business N"
	case 4
		ls_info = "Enterprise"
	case 27
		ls_info = "Enterprise N"
	case 2
		ls_info = "Home Basic"
	case 5
		ls_info = "Home Basic N"
	case 3
		ls_info = "Premium"
	case 26
		ls_info = "Premium N"
	case 48
		ls_info = "Professional"
	case 49
		ls_info = "Professional N"
	case 11
		ls_info = "Starter"
	case 7, 13
		ls_info = "Standard"
	case 8, 12
		ls_info = "Datacenter"
	case 10, 14
		ls_info = "Enterprise"
	case 17
		ls_info = "Web Server"
	case 15
		ls_info = "Enterprise IA64"
	case else
		ls_info = "dwReturnedProductType: " + String(lul_ProductType)
end choose

ls_info += " - " + String(of_GetOSBits()) + "bit"

Return ls_info

end function

public function boolean of_getosversion (ref string as_osversion, ref string as_osedition, ref string as_csdversion);// This function gets operating system version information.

OSVERSIONINFOEX lstr_ovi
Constant UInt VER_NT_SERVER = 3
Constant UInt VER_NT_WORKSTATION = 1
Constant Integer SM_SERVERR2 = 89

as_osversion  = ""
as_osedition  = ""
as_csdversion = ""

lstr_ovi.dwOSVersionInfoSize = 284

// call function
If Not GetVersionEx(lstr_ovi) Then Return False

// save values to instance variables
MajorVersion		= lstr_ovi.dwMajorVersion
MinorVersion		= lstr_ovi.dwMinorVersion
BuildNumber			= lstr_ovi.dwBuildNumber
ServicePackMajor	= lstr_ovi.wServicePackMajor
ServicePackMinor	= lstr_ovi.wServicePackMinor
SuiteMask			= lstr_ovi.wSuiteMask
ProductType			= lstr_ovi.wProductType

// populate by ref string arguments
choose case lstr_ovi.dwMajorVersion
	case 3
		as_osversion = "Windows NT 3.51"
	case 4
		as_osversion = "Windows NT 4"
		choose case lstr_ovi.wProductType
			case 1
				as_osedition = "Workstation"
			case 3
				If lstr_ovi.wSuiteMask = 2 Then
					as_osedition = "Server Enterprise"
				Else
					as_osedition = "Server Standard"
				End If
		end choose
	case 5
		as_csdversion = Trim(String(lstr_ovi.szCSDVersion))
		choose case lstr_ovi.dwMinorVersion
			case 0
				as_osversion = "Windows 2000"
				choose case lstr_ovi.wProductType
					case VER_NT_WORKSTATION
						as_osedition = "Professional"
					case VER_NT_SERVER
						as_osedition = "Server"
				end choose
			case 1
				as_osversion = "Windows XP"
				choose case lstr_ovi.wSuiteMask
					case 0, 256
						as_osedition = "Professional"
					case 64
						as_osedition = "Embedded"
					case 512, 768
						as_osedition = "Home Edition"
					case else
						as_osedition = "wSuiteMask:" + String(lstr_ovi.wSuiteMask)
				end choose
			case 2
				If GetSystemMetrics(SM_SERVERR2) = 0 Then
					as_osversion = "Windows Server 2003"
				Else
					as_osversion = "Windows Server 2003 R2"
				End If
				choose case lstr_ovi.wSuiteMask
					case 0, 16
						as_osedition = "Standard"
					case 2
						as_osedition = "Enterprise"
					case 128
						as_osedition = "Datacenter"
					case 1024
						as_osedition = "Web Edition"
					case else
						as_osedition = "wSuiteMask:" + String(lstr_ovi.wSuiteMask)
				end choose
			case else
				as_osversion = "Windows " + &
						String(lstr_ovi.dwMajorVersion) + String(lstr_ovi.dwMinorVersion) 
				as_osedition = "wSuiteMask:" + String(lstr_ovi.wSuiteMask)
		end choose
	case 6
		as_csdversion = Trim(String(lstr_ovi.szCSDVersion))
		choose case lstr_ovi.dwMinorVersion
			case 0
				choose case lstr_ovi.wProductType
					case VER_NT_WORKSTATION
						as_osversion = "Windows Vista"
						as_osedition = of_GetProductInfo()
					case VER_NT_SERVER
						as_osversion = "Windows Server 2008"
						as_osedition = of_GetProductInfo()
				end choose
			case 1
				choose case lstr_ovi.wProductType
					case VER_NT_WORKSTATION
						as_osversion = "Windows 7"
						as_osedition = of_GetProductInfo()
					case VER_NT_SERVER
						as_osversion = "Windows Server 2008 R2"
						as_osedition = of_GetProductInfo()
				end choose
		end choose
	case else
		as_csdversion = Trim(String(lstr_ovi.szCSDVersion))
		as_osversion = "Windows " + &
				String(lstr_ovi.dwMajorVersion) + String(lstr_ovi.dwMinorVersion) 
		as_osedition = "wSuiteMask:" + String(lstr_ovi.wSuiteMask)
end choose

Return True

end function

public function boolean of_getfileversioninfo (string as_filename);// This function gets version information strings from a file.

VS_FIXEDFILEINFO lstr_FixedInfo
LANGANDCODEPAGE lstr_Translate
String	ls_versionkeys[12] = { "Comments", &
					"CompanyName", "FileDescription", "FileVersion", &
					"InternalName", "LegalCopyright", "LegalTrademarks", &
					"OriginalFilename", "ProductName", "ProductVersion", &
					"PrivateBuild", "SpecialBuild" }
String	ls_versioninfo[12], ls_key, ls_language, ls_charset
Integer	li_part1, li_part2, li_part3, li_part4
ULong		dwHandle, dwLength, dwPointer
UInt		lui_length
Blob		lblob_Buffer
Integer	i

dwLength = GetFileVersionInfoSize(as_filename, dwHandle)
If dwLength <= 0 Then
	// No version information available
	Return False
End If

// Allocate version information buffer
lblob_Buffer = Blob(Space(dwLength/2))

// Get version information
If Not GetFileVersionInfo(as_filename, dwHandle, &
				dwLength, lblob_Buffer) Then
	Return False
End If

// Get Fixed File Info
If VerQueryValue(lblob_Buffer, "\", dwPointer, lui_length) Then
	// copy Fixed File Info to structure
	CopyMemory(lstr_FixedInfo, dwPointer, 52)
	// build FixedProductVersion
	If lstr_FixedInfo.dwProductVersionMS = 0 And &
		lstr_FixedInfo.dwProductVersionLS = 0 Then
		FixedProductVersion = ""
	Else
		li_part1 = IntHigh(lstr_FixedInfo.dwProductVersionMS)
		li_part2 = IntLow(lstr_FixedInfo.dwProductVersionMS)
		li_part3 = IntHigh(lstr_FixedInfo.dwProductVersionLS)
		li_part4 = IntLow(lstr_FixedInfo.dwProductVersionLS)
		FixedProductVersion = String(li_part1) + "." + &
					String(li_part2) + "." + String(li_part3) + &
					"." + String(li_part4)
	End If
	// build FixedFileVersion
	If lstr_FixedInfo.dwFileVersionMS = 0 And &
		lstr_FixedInfo.dwFileVersionLS = 0 Then
		FixedFileVersion = ""
	Else
		li_part1 = IntHigh(lstr_FixedInfo.dwFileVersionMS)
		li_part2 = IntLow(lstr_FixedInfo.dwFileVersionMS)
		li_part3 = IntHigh(lstr_FixedInfo.dwFileVersionLS)
		li_part4 = IntLow(lstr_FixedInfo.dwFileVersionLS)
		FixedFileVersion = String(li_part1) + "." + &
					String(li_part2) + "." + String(li_part3) + &
					"." + String(li_part4)
	End If
End If

// Get the structure language ID and character set
ls_key = "\VarFileInfo\Translation"
If Not VerQueryValue(lblob_Buffer, ls_key, dwPointer, lui_length) Then
	Return False
End If

// copy memory at dwPointer to structure
CopyMemory(lstr_Translate, dwPointer, lui_length)

// Convert the langid and char set into 4-digit hex value
ls_language = of_Hex(lstr_Translate.wLanguageId, 4)
ls_charset  = of_Hex(lstr_Translate.wCharacterSet, 4)

// for PB executables
If ls_charset = "1252" Then
	ls_charset = "04E4"
End If

// Query each of the version strings
For i = 1 To 12
	ls_key = "\StringFileInfo\" + ls_language + &
					ls_charset + "\" + ls_versionkeys[i]
	If Not VerQueryValue(lblob_Buffer, ls_key, dwPointer, lui_length) Or &
		lui_length <= 0 Then
		ls_versioninfo[i] = ""
	Else
		// copy memory at dwPointer to string array
		lui_length = lui_length * 2
		ls_versioninfo[i] = Space(lui_length)
		CopyMemory(ls_versioninfo[i], dwPointer, lui_length)
	End If
Next

// save values to instance variables
Comments				= ls_versioninfo[1]
CompanyName			= ls_versioninfo[2]
FileDescription	= ls_versioninfo[3]
FileVersion			= ls_versioninfo[4]
InternalName		= ls_versioninfo[5]
LegalCopyright		= ls_versioninfo[6]
LegalTrademarks	= ls_versioninfo[7]
OriginalFilename	= ls_versioninfo[8]
ProductName			= ls_versioninfo[9]
ProductVersion		= ls_versioninfo[10]
PrivateBuild		= ls_versioninfo[11]
SpecialBuild		= ls_versioninfo[12]

Return True

end function

public function integer of_getosbits ();// This function determines if OS is 32 bits or 64 bits.

Constant Long PROCESSOR_ARCHITECTURE_INTEL = 0
Constant Long PROCESSOR_ARCHITECTURE_AMD64 = 9
SYSTEM_INFO lstr_si
Integer li_bits
Boolean lb_IsWow64

IsWOW64Process(GetCurrentProcess(), lb_IsWow64)

If lb_IsWow64 Then
	GetNativeSystemInfo(lstr_si)
Else
	GetSystemInfo(lstr_si)
End If

If lstr_si.wProcessorArchitecture = PROCESSOR_ARCHITECTURE_AMD64 Then
	li_bits = 64
Else
	If lstr_si.wProcessorArchitecture = PROCESSOR_ARCHITECTURE_INTEL Then
		li_bits = 32
	End If
End If

Return li_bits

end function

public function string of_hex (unsignedlong aul_decimal, integer ai_length);// This function converts a number to a hex string.

String ls_hex
Char lch_hex[0 to 15] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', &
							'A', 'B', 'C', 'D', 'E', 'F'}

// convert to hexidecimal
Do 
	ls_hex = lch_hex[mod (aul_decimal, 16)] + ls_hex
	aul_decimal /= 16
Loop Until aul_decimal= 0

// add zeroes to front so that result is ai_length characters
ls_hex = Fill('0', ai_length) + ls_hex
ls_hex = Right(ls_hex, ai_length)

Return ls_hex

end function

public function string of_getfileversion (string arg_file);string ls_ret

If this.of_GetFileVersionInfo(arg_file) Then
	If this.FileVersion <> "" Then
		ls_ret = this.FileVersion
	elseif this.FixedFileVersion <> "" Then
		ls_ret = this.FixedFileVersion
	elseif this.ProductVersion <> "" Then
		ls_ret = this.ProductVersion
	elseif this.PrivateBuild <> "" Then
		ls_ret = this.PrivateBuild
	elseif this.SpecialBuild <> "" Then
		ls_ret = this.SpecialBuild
	else				
		ls_ret = "Empty"
	End If
else
	ls_ret = "Error"
end if

return ls_ret
end function

public subroutine of_get_myfileversion (ref string arg_version, ref string arg_build);
string	ls_version
string	sFullPath
integer	iRet
integer	iPos 			= 0

sFullpath 	= Space (1024)
iRet 			= GetModuleFileNameA (Handle (GetApplication()),sFullPath,1024)

if IRet > 0 then 
	iRet = lastpos(sFullpath, "\")
	if upper(left(mid(sFullpath, iRet + 1),  2)) <> "PB" then

		ls_version = of_getfileversion(sFullpath)	
		
		iPos = pos( ls_version, "-")
		if iPos > 0 then
			arg_version = left( ls_version, iPos -1 )
			arg_build 	= mid( ls_version, iPos +1 )
		else
			arg_version = ls_version
			arg_build 	= "0000"
		end if
	end if
end if


end subroutine

public subroutine of_get_myfileversion (ref string arg_version);
string	sFullPath
integer	iRet

sFullpath 	= Space (1024)
iRet 			= GetModuleFileNameA (Handle (GetApplication()),sFullPath,1024)

if IRet > 0 then 
	iRet = lastpos(sFullpath, "\")
	if upper(left(mid(sFullpath, iRet + 1), 2)) <> "PB" then
		arg_version = of_getfileversion(sFullpath)	
	end if
end if


end subroutine

on uo_osversion.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_osversion.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

