HA$PBExportHeader$uo_files_zippen.sru
forward
global type uo_files_zippen from nonvisualobject
end type
type filetime from structure within uo_files_zippen
end type
type win32_find_data from structure within uo_files_zippen
end type
type systemtime from structure within uo_files_zippen
end type
type large_integer from structure within uo_files_zippen
end type
end forward

type filetime from structure
	unsignedlong		dwlowdatetime
	unsignedlong		dwhighdatetime
end type

type win32_find_data from structure
	unsignedlong		dwfileattributes
	filetime		ftcreationtime
	filetime		ftlastaccesstime
	filetime		ftlastwritetime
	unsignedlong		nfilesizehigh
	unsignedlong		nfilesizelow
	unsignedlong		dwreserved0
	unsignedlong		dwreserved1
	character		cfilename[260]
	character		calternatefilename[14]
end type

type systemtime from structure
	unsignedinteger		wyear
	unsignedinteger		wmonth
	unsignedinteger		wdayofweek
	unsignedinteger		wday
	unsignedinteger		whour
	unsignedinteger		wminute
	unsignedinteger		wsecond
	unsignedinteger		wmilliseconds
end type

type large_integer from structure
	unsignedlong		low_part
	unsignedlong		high_part
end type

global type uo_files_zippen from nonvisualobject
end type
global uo_files_zippen uo_files_zippen

type prototypes
Function ulong GetLogicalDrives ( &
	) Library "kernel32.dll" Alias For "GetLogicalDrives"

Function uint GetDriveType ( &
	string lpBuffer &
	) Library "kernel32.dll" Alias For "GetDriveTypeW"

Function ulong WNetGetConnection ( &
	string lpszLocalName, &
	ref string lpszRemoteName, &
	ref ulong buflen &
	) Library "mpr.dll" Alias For "WNetGetConnectionW"

Function ulong GetVolumeInformation( &
	Ref string lpRootPathName, &
   Ref string lpVolumeNameBuffer, &
	long nVolumeNameSize, &
	Ref string lpVolumeSerialNumber, &
   long lpMaximumComponentLength, &
	long lpFileSystemFlags, &
	Ref string lpFileSystemNameBuffer, &
   long nFileSystemNameSize &
	) Library "kernel32.dll" Alias For "GetVolumeInformationW"

Function long FindFirstFile ( &
	Ref string filename, &
	Ref win32_find_data findfiledata &
	) Library "kernel32.dll" Alias For "FindFirstFileW"

Function boolean FindNextFile ( &
	ulong handle, &
	Ref win32_find_data findfiledata &
	) Library "kernel32.dll" Alias For "FindNextFileW"

Function boolean FindClose ( &
	ulong handle &
	) Library "kernel32.dll" Alias For "FindClose"

Function boolean FileTimeToLocalFileTime ( &
	Ref filetime lpFileTime, &
	Ref filetime lpLocalFileTime &
	) Library "kernel32.dll" Alias For "FileTimeToLocalFileTime"

Function boolean FileTimeToSystemTime ( &
	Ref filetime lpFileTime, &
	Ref systemtime lpSystemTime &
	) Library "kernel32.dll" Alias For "FileTimeToSystemTime"

Function boolean GetDiskFreeSpaceEx ( &
	string lpDirectoryName, &
	Ref large_integer lpFreeBytesAvailable, &
	Ref large_integer lpTotalNumberOfBytes, &
	Ref large_integer lpTotalNumberOfFreeBytes &
	) Library "kernel32.dll" Alias For "GetDiskFreeSpaceExW"

Function int GetTempPath ( &
	int nBufferLength, &
	Ref string lpBuffer &
	) Library "kernel32.dll" Alias For "GetTempPathW"

Function boolean SetFileAttributes ( &
	string lpFileName, &
	ulong dwFileAttributes &
	) Library "kernel32.dll" Alias For "SetFileAttributesW"

Function long SHGetFolderPath ( &
	long hwndOwner, &
	long nFolder, &
	long hToken, &
	long dwFlags, &
	Ref string pszPath &
	) Library "shell32.dll" Alias For "SHGetFolderPathW"

end prototypes

type variables
string sErrorMessage
string is_dateFormat="YYYY-MM-DD"

// PROGRAMMAUFRUF:
//  Globale Variable:
// 	long zipoffset
//string				gs_zip_instance

// f_profile():
//zipoffset							= long(ProfileString(sProfile, "LOG","ZipOffset","-7"))
//SetProfileString(sProfile, "LOG","ZipOffset",string(zipoffset))
// 12.03.2015 HR: Da nicht immer die INSTANCE1 auf dem Server l$$HEX1$$e400$$ENDHEX$$uft (Verteilung), hier die ZipInstance festlegen
//gs_zip_instance = lower(ProfileString(sProfile, "LOG","ZipInstance","NONE"))
//if gs_zip_instance = "none" then
//	gs_zip_instance = "instance1"
//	SetProfileString(sProfile, "LOG","ZipInstance", gs_zip_instance)
//end if
//


// Ben$$HEX1$$f600$$ENDHEX$$tigte Variable:
//  uo_files_zippen uoZip

// --------------------------------------------------------------------------------------------------------------------
// 08.03.2010 HR: Logfiles zippen
// --------------------------------------------------------------------------------------------------------------------

//Bei Mehrzilindern:
//	if today()<>date(ProfileString(sProfile, "LOG", "LastZip", "01.01.2000")) and lower(sInstance) = gs_zip_instance then

//Bei normalen Services:
//if today()<>date(ProfileString(sProfile, "LOG", "LastZip", "01.01.2000")) then

//	uoZip = create uo_files_zippen
//	uoZip.is_dateFormat="YYYY-MM-DD"
//	uoZip.of_zip_log(sLogPath, sLogfile, relativedate(today(),zipoffset))
//	destroy uoZip
//	
//	SetProfileString(sProfile, "LOG", "LastZip", string(today()))
//end if


// ========================================================
// MHO 2014-04-24: Folgendes $$HEX1$$fc00$$ENDHEX$$bernommen von uo_zip_xceed
PRIVATE:
// Error Codes
constant integer ZIP_SUCCESS = 0
constant integer ZIP_WARNING = 526

// Compression Levels
constant uint ZIP_CL_NONE   = 0 // No compression. Files are stored in the zip file as raw data.
constant uint ZIP_CL_LOW    = 1 // Minimum compression. This setting takes the least amount of time to compress data.
constant uint ZIP_CL_MEDIUM = 6 // Normal compression. This is the best balance between the time it takes to compress data and the compression ratio achieved.
constant uint ZIP_CL_HIGH   = 9 // Maximum compression. This setting achieves the best compression ratios that the compression algorithm is capable of producing.

// Sonstige Variablen
string isLicenseKey  = "1823BC7BDF1B877EEAEB773176EA13EC"
string isLastError   = ""
string isPassword    = ""
uint iuiCompressionLevel = ZIP_CL_HIGH

end variables
forward prototypes
public function integer of_getdrivetype (string as_drive)
public function string of_getvolumelabel (string as_drive)
public function boolean of_checkbit (long al_number, unsignedinteger ai_bit)
public function datetime of_filedatetimetopb (filetime astr_filetime)
public function string of_wnetgetconnection (string as_drive)
public function integer of_getdrives (ref string as_drive[], ref integer ai_type[], ref string as_label[])
public function integer of_getfileattributes (string as_filename, ref boolean ab_readonly, ref boolean ab_hidden, ref boolean ab_system, ref boolean ab_subdir, ref boolean ab_archive)
public function boolean of_dirsexist (string as_filespec, boolean ab_hidden)
public function boolean of_filesexist (string as_filespec, boolean ab_hidden)
public function integer of_getfiles (string as_filespec, boolean ab_hidden, ref string as_name[], ref double ad_size[], ref datetime adt_writedate[], ref boolean ab_subdir[])
public subroutine of_getdiskfreespace (string as_drive, ref double adb_size, ref double adb_used, ref double adb_free)
public function string of_gettemppath ()
public function unsignedlong of_setfileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive)
private function unsignedlong of_calcfileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive)
public function string of_getfiledescription (string as_filename)
public function string of_getfolderpath (string as_folder)
public function integer of_getfiles (string as_filespec, ref string as_name[], ref boolean ab_subdir[])

public function boolean of_zipfile (string sfilenames[], string sarchivename, boolean bdelete)
public function boolean of_zipfile_ALT (string sfilenames[], string sarchivename, boolean bdelete)
public function integer of_zip (string as_filenames[], string as_archivename, boolean ab_delete, boolean ab_preservepaths, boolean ab_processsubfolders)

public function integer of_dirlist (string as_filespec, integer iattrib, ref str_findresult strfiles[])
public function integer of_dir (string sfilespec, ref str_findresult strfiles[])
public function boolean of_zip_log (string arg_path, string arg_filename, date arg_date)
end prototypes

public function integer of_getdrivetype (string as_drive);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_GetDriveType
//
// PURPOSE:    This function determines whether a disk drive is a
//					removable, fixed, CD-ROM, RAM disk, or network drive.
//
// ARGUMENTS:  as_drive	- Drive letter
//
// RETURN:		Drive type:
//
//		Type	Meaning
//		----	--------------------------------------------
//		0		The drive type cannot be determined.
//		1		The root path is invalid. For example, no
//				volume is mounted at the path.
//		2		The disk can be removed from the drive.
//		3		The disk cannot be removed from the drive.
//		4		The drive is a remote (network) drive.
//		5		The drive is a CD-ROM drive.
//		6		The drive is a RAM disk.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

UInt lui_type
String ls_drive

ls_drive = as_drive + ":\"

lui_type = GetDriveType(ls_drive)

Return lui_type

end function

public function string of_getvolumelabel (string as_drive);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_GetVolumeLabel
//
// PURPOSE:    This function returns the volume label for local files.
//
// ARGUMENTS:  as_drive	- Drive letter
//
// RETURN:		Volume label
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

String ls_path, ls_label
String ls_serial, ls_sysname
Long ll_size, ll_complen, ll_flags
ULong lul_rtncode

ls_path = as_drive + ":\"

ll_size = 50
ls_label   = Space(ll_size)
ls_serial  = Space(ll_size)
ls_sysname = Space(ll_size)

lul_rtncode = GetVolumeInformation(ls_path, &
		ls_label, ll_size, ls_serial, &
		ll_complen, ll_flags, ls_sysname, ll_size)

Return Trim(ls_label)

end function

public function boolean of_checkbit (long al_number, unsignedinteger ai_bit);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_Checkbit
//
// PURPOSE:    This function determines if a certain bit is on or off within
//					the number.
//
// ARGUMENTS:  al_number	- Number to check bits
//             ai_bit		- Bit number ( starting at 1 )
//
// RETURN:		True = On, False = Off
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

If Int(Mod(al_number / (2 ^(ai_bit - 1)), 2)) > 0 Then
	Return True
End If

Return False

end function

public function datetime of_filedatetimetopb (filetime astr_filetime);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_FileDateTimeToPB
//
// PURPOSE:    This function converts file system datetimes to a PB datetime.
//
// ARGUMENTS:  astr_filetime	- FILETIME structure
//
// RETURN:		Datetime for the file
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

DateTime ldt_filedate
FILETIME	lstr_localtime
SYSTEMTIME lstr_systime
String ls_time
Date ld_fdate
Time lt_ftime

SetNull(ldt_filedate)

If Not FileTimeToLocalFileTime(astr_FileTime, &
			lstr_localtime) Then Return ldt_filedate

If Not FileTimeToSystemTime(lstr_localtime, &
			lstr_systime) Then Return ldt_filedate

ld_fdate = Date(lstr_systime.wYear, &
					lstr_systime.wMonth, lstr_systime.wDay)

ls_time = String(lstr_systime.wHour) + ":" + &
			 String(lstr_systime.wMinute) + ":" + &
			 String(lstr_systime.wSecond) + ":" + &
			 String(lstr_systime.wMilliseconds)
lt_ftime = Time(ls_Time)

ldt_filedate = DateTime(ld_fdate, lt_ftime)

Return ldt_filedate

end function

public function string of_wnetgetconnection (string as_drive);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_WNetGetConnection
//
// PURPOSE:    This function retrieves the name of the network resource
//					associated with a local device.
//
// ARGUMENTS:  as_drive	- Drive letter
//
// RETURN:		Network path
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

CONSTANT ulong NO_ERROR = 0
String ls_connection, ls_drive, ls_msg
ULong lul_result, lul_buflen

lul_buflen = 260
ls_connection = Space(lul_buflen)
ls_drive = Upper(Left(as_drive,1)) + ":"

lul_result = WNetGetConnection(ls_drive, ls_connection, lul_buflen)

Return Trim(ls_connection)

end function

public function integer of_getdrives (ref string as_drive[], ref integer ai_type[], ref string as_label[]);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_GetDrives
//
// PURPOSE:    This function returns a list of disk drives with their type
//					and volume label.
//
// ARGUMENTS:  as_drive	- Drive letter array (By Ref)
//             ai_type	- Drive type array (By Ref)
//             as_label	- Volume label array (By Ref)
//
// RETURN:		Number of drives found
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Constant UInt DRIVE_UNKNOWN		= 0
Constant UInt DRIVE_NO_ROOT_DIR	= 1
Constant UInt DRIVE_REMOVABLE		= 2
Constant UInt DRIVE_FIXED			= 3
Constant UInt DRIVE_REMOTE			= 4
Constant UInt DRIVE_CDROM			= 5
Constant UInt DRIVE_RAMDISK		= 6

String ls_drive, ls_connection, ls_server, ls_share
Integer li_cnt, li_next, li_pos
UInt lui_type
ULong lul_drives
Boolean lb_exists

// get active drive letters
lul_drives = GetLogicalDrives()
For li_cnt = 1 To 26
	// check if drive exists
	lb_exists = of_checkbit(lul_drives, li_cnt)
	If lb_exists Then
		// convert drive number to letter
		ls_drive = Char(li_cnt + 64)
		// get drive type
		lui_type = this.of_GetDriveType(ls_drive)
		If lui_type = DRIVE_UNKNOWN Or &
			lui_type = DRIVE_NO_ROOT_DIR Then
		Else
			li_next = UpperBound(as_drive) + 1
			as_drive[li_next] = ls_drive
			ai_type[li_next] = lui_type
			// check for network drive
			If lui_type = DRIVE_REMOTE Then
				// get network server and share names
				ls_connection = this.of_WNetGetConnection(ls_drive)
				li_pos = LastPos(ls_connection, "\")
				ls_share = Mid(ls_connection, li_pos + 1)
				ls_server = Mid(Left(ls_connection, li_pos - 1), 3)
				If ls_share = Upper(ls_share) Then
					ls_share = WordCap(ls_share)
				End If
				If ls_server = Upper(ls_server) Then
					ls_server = WordCap(ls_server)
				End If
				as_label[li_next] = ls_share + " on '" + ls_server + "'"
			Else
				// get volume label from local drives
				as_label[li_next] = this.of_GetVolumeLabel(ls_drive)
				If as_label[li_next] = "" Then
					choose case lui_type
						case DRIVE_REMOVABLE
							as_label[li_next] = "3$$HEX2$$bd002000$$ENDHEX$$Floppy"
						case DRIVE_FIXED
							as_label[li_next] = "Local Disk"
						case DRIVE_CDROM
							as_label[li_next] = "CD Drive"
					end choose
				End If
			End If
		End if
	End If
Next

Return li_next

end function

public function integer of_getfileattributes (string as_filename, ref boolean ab_readonly, ref boolean ab_hidden, ref boolean ab_system, ref boolean ab_subdir, ref boolean ab_archive);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_GetFileAttributes
//
// PURPOSE:    This function returns attributes of the specified file.
//
// ARGUMENTS:  as_filename	- Name of the file
//             ab_readonly	- Read Only attribute (By Ref)
//             ab_hidden	- Hidden attribute (By Ref)
//             ab_system	- System attribute (By Ref)
//             ab_subdir	- Subdirectory attribute (By Ref)
//             ab_archive	- Archive attribute (By Ref)
//
// RETURN:		1 = Success, -1 = Error
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Long lul_Handle
win32_find_data lstr_fd

// Find the file
lul_Handle = FindFirstFile(as_filename, lstr_fd)
If lul_Handle <= 0 Then Return -1
FindClose(lul_Handle)

// Return file attributes in by reference arguments
ab_ReadOnly = this.of_checkbit(lstr_fd.dwFileAttributes, 1)
ab_Hidden   = this.of_checkbit(lstr_fd.dwFileAttributes, 2)
ab_System   = this.of_checkbit(lstr_fd.dwFileAttributes, 3)
ab_SubDir   = this.of_checkbit(lstr_fd.dwFileAttributes, 5)
ab_Archive  = this.of_checkbit(lstr_fd.dwFileAttributes, 6)

Return 1

end function

public function boolean of_dirsexist (string as_filespec, boolean ab_hidden);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_DirsExist
//
// PURPOSE:    This function determines if any directories exist with the
//					passed path.
//
// ARGUMENTS:  as_filespec	- File path
//             ab_hidden	- Whether hidden/system directories are reported
//
// RETURN:		True = Directories found, False = Directories not found
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Long ll_Handle
Boolean lb_found, lb_subdir, lb_hidden, lb_system
String ls_filename
win32_find_data lstr_fd

// append filename pattern
If Right(as_filespec, 1) = "\" Then
	as_filespec += "*.*"
Else
	as_filespec += "\*.*"
End If

// find first file
ll_Handle = FindFirstFile(as_filespec, lstr_fd)
If ll_Handle < 1 Then Return False

// loop through each file
Do
	// add file to array
	ls_filename = String(lstr_fd.cFilename)
	If ls_filename = "." Or ls_filename = ".." Then
	Else
		lb_subdir = of_checkbit(lstr_fd.dwFileAttributes, 5)
		If lb_subdir Then
			// check for hidden/system attributes
			lb_hidden = of_checkbit(lstr_fd.dwFileAttributes, 2)
			lb_system = of_checkbit(lstr_fd.dwFileAttributes, 3)
			If ( lb_hidden Or lb_system ) And &
				( ab_hidden = False ) Then
			Else
				// close find handle
				FindClose(ll_Handle)
				Return True
			End If
		End If
	End If
	// find next file
	lb_Found = FindNextFile(ll_Handle, lstr_fd)
Loop Until Not lb_Found

// close find handle
FindClose(ll_Handle)

Return False

end function

public function boolean of_filesexist (string as_filespec, boolean ab_hidden);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_FilesExist
//
// PURPOSE:    This function determines if any files exist with the
//					passed path.
//
// ARGUMENTS:  as_filespec	- File path
//             ab_hidden	- Whether hidden/system files are reported
//
// RETURN:		True = Files found, False = Files not found
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Long ll_Handle
Boolean lb_found, lb_hidden, lb_system
String ls_filename
win32_find_data lstr_fd

// append filename pattern
If Right(as_filespec, 1) = "\" Then
	as_filespec += "*.*"
Else
	as_filespec += "\*.*"
End If

// find first file
ll_Handle = FindFirstFile(as_filespec, lstr_fd)
If ll_Handle < 1 Then Return False

// loop through each file
Do
	// add file to array
	ls_filename = String(lstr_fd.cFilename)
	If ls_filename = "." Or ls_filename = ".." Then
	Else
		// check for hidden/system attributes
		lb_hidden = of_checkbit(lstr_fd.dwFileAttributes, 2)
		lb_system = of_checkbit(lstr_fd.dwFileAttributes, 3)
		If ( lb_hidden Or lb_system ) And &
			( ab_hidden = False ) Then
		Else
			// close find handle
			FindClose(ll_Handle)
			Return True
		End If
	End If
	// find next file
	lb_Found = FindNextFile(ll_Handle, lstr_fd)
Loop Until Not lb_Found

// close find handle
FindClose(ll_Handle)

Return False

end function

public function integer of_getfiles (string as_filespec, boolean ab_hidden, ref string as_name[], ref double ad_size[], ref datetime adt_writedate[], ref boolean ab_subdir[]);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_GetFiles
//
// PURPOSE:    This function returns a list of files with their size,
//					last write datetime and subdirectory flag.
//
// ARGUMENTS:  as_filespec		- File path
//             ab_hidden		- Whether hidden/system files are reported
//             as_name			- File Name array (By Ref)
//             ad_size			- File Size array (By Ref)
//             adt_writedate	- LastWrite Datetime array (By Ref)
//             ab_subdir		- Subdirectory flag (By Ref)
//
// RETURN:		Number of files found
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Integer li_file
Long ll_Handle
Boolean lb_found, lb_hidden, lb_system
String ls_filename
win32_find_data lstr_fd

// append filename pattern
If Right(as_filespec, 1) = "\" Then
	as_filespec += "*.*"
Else
	as_filespec += "\*.*"
End If

// find first file
ll_Handle = FindFirstFile(as_filespec, lstr_fd)
If ll_Handle < 1 Then Return -1

// loop through each file
Do
	// add file to array
	ls_filename = String(lstr_fd.cFilename)
	If ls_filename = "." Or ls_filename = ".." Then
	Else
		// check for hidden attrib
		lb_hidden = of_checkbit(lstr_fd.dwFileAttributes, 2)
		lb_system = of_checkbit(lstr_fd.dwFileAttributes, 3)
		If ( lb_hidden Or lb_system ) And &
			( ab_hidden = False ) Then
		Else
			// get file properties
			li_file++
			as_name[li_file]  = ls_filename
			ad_size[li_file] = (lstr_fd.nFileSizeHigh * (2.0 ^ 32)) + lstr_fd.nFileSizeLow
			adt_writedate[li_file] = of_filedatetimetopb(lstr_fd.ftlastwritetime)
			ab_subdir[li_file] = of_checkbit(lstr_fd.dwFileAttributes, 5)
		End If
	End If
	// find next file
	lb_Found = FindNextFile(ll_Handle, lstr_fd)
Loop Until Not lb_Found

// close find handle
FindClose(ll_Handle)

Return li_file

end function

public subroutine of_getdiskfreespace (string as_drive, ref double adb_size, ref double adb_used, ref double adb_free);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_GetDiskFreeSpace
//
// PURPOSE:    This function returns the amount of space on the drive.
//
// ARGUMENTS:  as_drive	- Drive letter
//             adb_size	- Total size in bytes of the drive (By Ref)
//             adb_used	- Total number of used bytes on the drive (By Ref)
//             adb_free	- Total number of free bytes on the drive (By Ref)
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Boolean lb_rtn
large_integer lstr_fb, lstr_tb, lstr_tf
String ls_drive

ls_drive = as_drive + ":"

lb_rtn = GetDiskFreeSpaceEx(ls_Drive, &
					lstr_fb, lstr_tb, lstr_tf)

adb_size = (lstr_tb.high_part * (2.0 ^ 32)) + lstr_tb.low_part
adb_free = (lstr_tf.high_part * (2.0 ^ 32)) + lstr_tf.low_part
adb_used = adb_size - adb_free

end subroutine

public function string of_gettemppath ();// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_GetTempPath
//
// PURPOSE:    This function returns the system temporary file directory.
//
// RETURN:		Temp directory
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

String ls_path
Integer li_buflen

li_buflen = 260
ls_path = Space(li_buflen)

GetTempPath(li_buflen, ls_path)

Return ls_path

end function

public function unsignedlong of_setfileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_SetFileAttributes
//
// PURPOSE:    This function determines if any files exist with the
//					passed path.
//
// ARGUMENTS:  as_filename	- Name of the file
//             ab_readonly	- Read Only attribute
//             ab_hidden	- Hidden attribute
//             ab_system	- System attribute
//             ab_archive	- Archive attribute
//
// RETURN:		1 = Success, -1 = Error
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Integer li_rc
ULong lul_attrib

// Calculate the new attribute byte for the file
lul_attrib = of_CalcFileAttributes(as_FileName, ab_ReadOnly, ab_Hidden, ab_System, ab_Archive)
If lul_attrib = -1 Then Return -1

If SetFileAttributes(as_FileName, lul_attrib) Then
	li_rc = 1
Else
	li_rc = -1
End If

Return li_rc

end function

private function unsignedlong of_calcfileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_CalcFileAttributes
//
// PURPOSE:    This function is called by of_SetFileAttributes to calculate
//             numeric attribute from the boolean values.
//
// ARGUMENTS:  as_filename	- Name of the file
//             ab_readonly	- Read Only attribute
//             ab_hidden	- Hidden attribute
//             ab_system	- System attribute
//             ab_archive	- Archive attribute
//
// RETURN:		Numeric attribute
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Boolean	lb_ReadOnly, lb_Hidden, lb_System, lb_Subdirectory, lb_Archive
ULong		lul_Attrib

// Get the current attribute values
If this.of_GetFileAttributes(as_FileName, lb_ReadOnly, lb_Hidden, &
		lb_System, lb_Subdirectory, lb_Archive) = -1 Then 
	Return -1
End If

// Preserve the Subdirectory attribute
If lb_Subdirectory Then
	lul_Attrib = 16
Else
	lul_Attrib = 0
End If

// Set Read-Only
If Not IsNull(ab_ReadOnly) Then
	If ab_ReadOnly Then lul_Attrib = lul_Attrib + 1
Else
	If lb_ReadOnly Then lul_Attrib = lul_Attrib + 1
End If

// Set Hidden
If Not IsNull(ab_Hidden) Then
	If ab_Hidden Then lul_Attrib = lul_Attrib + 2
Else
	If lb_Hidden Then lul_Attrib = lul_Attrib + 2
End If

// Set System
If Not IsNull(ab_System) Then
	If ab_System Then lul_Attrib = lul_Attrib + 4
Else
	If lb_System Then lul_Attrib = lul_Attrib + 4
End If

// Set Archive
If Not IsNull(ab_Archive) Then
	If ab_Archive Then lul_Attrib = lul_Attrib + 32
Else
	If lb_Archive Then lul_Attrib = lul_Attrib + 32
End If

Return lul_Attrib

end function

public function string of_getfiledescription (string as_filename);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_GetFileDescription
//
// PURPOSE:    This function gets a file's description from registry.
//
// ARGUMENTS:  as_filename	- Name of the file
//
// RETURN:		File Description
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

String ls_extn, ls_regkey, ls_regvalue, ls_desc
Long ll_pos

ll_pos = LastPos(as_filename, ".")
If ll_pos = 0 Then Return ""

ls_extn = Mid(as_filename, ll_pos)

ls_regkey = "HKEY_CLASSES_ROOT\" + ls_extn
RegistryGet(ls_regkey, "", ls_regvalue)

ls_regkey = "HKEY_CLASSES_ROOT\" + ls_regvalue
RegistryGet(ls_regkey, "", ls_desc)

If ls_desc = "" Then
	ls_desc = Upper(Mid(ls_extn,2)) + " File"
End If

Return ls_desc

end function

public function string of_getfolderpath (string as_folder);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_GetFolderPath
//
// PURPOSE:    This function returns the path to a shell folder.
//
// ARGUMENTS:  as_folder	- Name of the shell folder
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 05/10/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Constant Long SHGFP_TYPE_CURRENT = 0
Constant Long CSIDL_DESKTOP   = 0
Constant Long CSIDL_PROGRAMS  = 2
Constant Long CSIDL_PERSONAL  = 5
Constant Long CSIDL_FAVORITES = 6
Constant Long CSIDL_STARTUP   = 7
Constant Long CSIDL_RECENT    = 8
Constant Long CSIDL_BITBUCKET = 10
Constant Long CSIDL_APPDATA   = 26

String ls_path
Long ll_rc, ll_hWnd, ll_csidl

// set the CSIDL
choose case Upper(as_folder)
	case "DESKTOP"
		ll_csidl = CSIDL_DESKTOP
	case "PROGRAMS"
		ll_csidl = CSIDL_PROGRAMS
	case "PERSONAL"
		ll_csidl = CSIDL_PERSONAL
	case "FAVORITES"
		ll_csidl = CSIDL_FAVORITES
	case "STARTUP"
		ll_csidl = CSIDL_STARTUP
	case "RECENT"
		ll_csidl = CSIDL_RECENT
	case "BITBUCKET"
		ll_csidl = CSIDL_BITBUCKET
	case "APPDATA"
		ll_csidl = CSIDL_APPDATA
	case else
		Return ""
end choose

ll_hWnd = Handle(this)

ls_path = Space(256)

ll_rc = SHGetFolderPath(ll_hWnd, CSIDL_PERSONAL, &
				0, SHGFP_TYPE_CURRENT, ls_path)

Return ls_path

end function

public function integer of_getfiles (string as_filespec, ref string as_name[], ref boolean ab_subdir[]);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_GetFiles
//
// PURPOSE:    This function is a simplified version that only returns
//					filename and subdirectory flag.
//
// ARGUMENTS:  as_filespec		- File path
//             as_name			- File Name array (By Ref)
//             ab_subdir		- Subdirectory flag (By Ref)
//
// RETURN:		Number of files found
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/17/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Double ld_size[]
DateTime ldt_writedate[]

Return of_GetFiles(as_filespec, False, &
					as_name, ld_size, ldt_writedate, ab_subdir)

end function

public function boolean of_zipfile (string sfilenames[], string sarchivename, boolean bdelete);
// --------------------------------------------------------------------------------
// Objekt : uo_files_zippen
// Methode: function boolean of_zipfile (string sfilenames[], string sarchivename, boolean bdelete)
// Autor  : MHO 2014-04-24
// --------------------------------------------------------------------------------
// Argument(e):    Siehe auch of_zip(...)
//    as_filenames[]          Ein Array mit Dateinamen, die gepackt werden sollen. (Wildcards sind m$$HEX1$$f600$$ENDHEX$$glich)
//    as_archivename          Der Name der Zip-Datei, die erstellt werden soll.
//    ab_delete               Gibt an, ob die Dateien nach dem packen gel$$HEX1$$f600$$ENDHEX$$scht werden sollen.
// --------------------------------------------------------------------------------
// Return: boolean : TRUE = Erfolg, FALSE = Fehler
// --------------------------------------------------------------------------------
//  Beschreibung: Ersatz f$$HEX1$$fc00$$ENDHEX$$r die alte Funktion, die noch unter of_zipfile_ALT zum Vergleich zu finden ist.
//                Verweist jetzt auf die aus uo_zip_xceed $$HEX1$$fc00$$ENDHEX$$bernommene Funktion of_zip.
//                Dadurch auch Korrektur des Raussprungs bei Fehler, der in der alten Funktion nicht aufger$$HEX1$$e400$$ENDHEX$$umt hatte.
//                of_zip bietet dar$$HEX1$$fc00$$ENDHEX$$ber hinaus zwei weitere Parameter an (ben$$HEX1$$f600$$ENDHEX$$tigt wurde hier konkret das Weglassen der Pfade).
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum         Version      Autor              Kommentar
// --------------------------------------------------------------------------------
//  2014-04-24    MHO		   Erstellung
// --------------------------------------------------------------------------------
integer li_return
boolean lb_return

lb_return = FALSE

li_return = of_zip (sfilenames, sarchivename, bdelete, TRUE, FALSE)
if li_return < 0 then
	lb_return = FALSE
else
	lb_return = TRUE
end if

return lb_return

end function

public function boolean of_zipfile_ALT (string sfilenames[], string sarchivename, boolean bdelete);
long 			lSuccess
boolean		bSuccess
oleobject	ole_zip
integer 		i
string		sFiles
ole_zip = Create OleObject	

// ---------------------------------
// Connect to Object
// ---------------------------------
if ole_zip.ConnectToNewObject ("XceedSoftware.XceedZip.4") <> 0 Then
	this.sErrorMessage = "Could't connect Zip ActiveX Library."
	ole_zip.DisconnectObject()
	Destroy(ole_zip)
	return False
end if

// ---------------------------------
// Object License
// ---------------------------------
bSuccess	= ole_zip.License("1823BC7BDF1B877EEAEB773176EA13EC")
If not bSuccess Then
	this.sErrorMessage = "Zip ActiveX Library not licenced."
	ole_zip.DisconnectObject()
	Destroy(ole_zip)
	return False
End if	

// ---------------------------------
// Files to zip
// ---------------------------------
sFiles = ""
For i = 1 to Upperbound(sfilenames)
	sFiles = sFiles + sFilenames[i] + Char(13) + Char(10)
Next
ole_zip.FilesToProcess(sFiles)

// ---------------------------------
// Archiv Name
// ---------------------------------
ole_zip.ZipFilename(sArchiveName)
lSuccess = ole_zip.Zip()

If lSuccess <> 0 AND lSuccess <> 526 Then
	this.sErrorMessage = "Could't create Zip-Archiv. Errorcode:" + string(lSuccess)
	return False	
	ole_zip.DisconnectObject()
	Destroy(ole_zip)

End if

ole_zip.DisconnectObject()
Destroy(ole_zip)

// ---------------------------------
// Soll gel$$HEX1$$f600$$ENDHEX$$scht werden
// ---------------------------------
if bDelete then
	For i = 1 to Upperbound(sfilenames)
		FileDelete(sfilenames[i])
	Next
end if


return true

end function

public function integer of_zip (string as_filenames[], string as_archivename, boolean ab_delete, boolean ab_preservepaths, boolean ab_processsubfolders);
/*
* Objekt : uo_zip
* Methode: of_zip (Function)
* Autor  : Dirk Bunk
* Datum  : 16.06.2011
*
* Argument(e):
*   as_filenames[]          Ein Array mit Dateinamen, die gepackt werden sollen. (Wildcards sind m$$HEX1$$f600$$ENDHEX$$glich)
*   as_archivename          Der Name der Zip-Datei, die erstellt werden soll.
*   ab_delete               Gibt an, ob die Dateien nach dem packen gel$$HEX1$$f600$$ENDHEX$$scht werden sollen.
*   ab_preservepaths        Gibt an, ob die Verzeichnisstruktur beibehalten werden soll.
*   ab_processsubfolders    Gibt an, ob auch Unterverzeichnisse durchsucht werden sollen.
*
* Beschreibung: Packt Dateien in eine Zip-Datei.	
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        Dirk Bunk    16.06.2011    Erstellung
*   1.1        Dirk Bunk    28.03.2012    Komprimierungsstufe setzen / Encryption Passwort setzen
*   1.2        Martin Hofmann 24.04.2014  $$HEX1$$dc00$$ENDHEX$$bernommen aus CBASE:uo_zip_xceed, reduziert und angepasst
*
* Return: 
*   -1  Fehler
*    0  OK
*/

string sFiles = ""
integer i
integer iRet
oleobject	ole_zip
boolean		lb_Success

ole_zip = Create OleObject	
iRet = 0

// ---------------------------------
// Connect to Object
// ---------------------------------
if ole_zip.ConnectToNewObject ("XceedSoftware.XceedZip.4") <> 0 Then
	this.sErrorMessage = "Could't connect Zip ActiveX Library."
	iRet = -1
end if

// ---------------------------------
// Object License
// ---------------------------------
if iRet = 0 then
	lb_Success	= ole_zip.License(isLicenseKey)
	If not lb_Success Then
		this.sErrorMessage = "Zip ActiveX Library not licenced."
		iRet = -1
	End if	
end if // if iRet = 0 then

if isNull(ole_zip) then
	iRet = -1
End if	

if iRet = 0 then
	// Dateinamen, die gezippt werden sollen zusammenbauen
	for i = 1 to Upperbound(as_Filenames)
		sFiles = sFiles + as_Filenames[i] + "|"
	next
	ole_zip.FilesToProcess(sFiles)
	
	// Komprimierungsstufe setzen
	ole_zip.CompressionLevel = iuiCompressionLevel
	
	// Encryption Passwort setzen
	ole_zip.EncryptionPassword = isPassword
	
	// Archivname setzen
	ole_zip.ZipFilename(as_ArchiveName)
	
	// Schalter setzen, ob die Dateipfade mit gezippt werden
	ole_zip.PreservePaths(ab_PreservePaths) 
	
	// Schalter setzen, ob auch Unterverzeichnisse durchsucht werden
	ole_zip.ProcessSubfolders(ab_ProcessSubfolders)
	
	// Dateien zippen
	iRet = ole_zip.Zip()
	if iRet <> ZIP_SUCCESS and iRet <> ZIP_WARNING then
		this.sErrorMessage = "Couldn't create Zip-Archive.~rErrorcode: " + String(iRet) + "~r" + ole_zip.GetErrorDescription(0, iRet)
		iRet = -1
	else
		iRet = 0
	end if
end if // if iRet = 0 then

if iRet = 0 then
	// Evtl. Dateien l$$HEX1$$f600$$ENDHEX$$schen
	if ab_Delete then
		for i = 1 to Upperbound(as_Filenames)
			FileDelete(as_Filenames[i])
		next
	end if
end if // if iRet = 0 then

// --------------------
// Finalize
ole_zip.DisconnectObject()
Destroy(ole_zip)
return iRet

end function

public function integer of_dirlist (string as_filespec, integer iattrib, ref str_findresult strfiles[]);// -----------------------------------------------------------------------------
// SCRIPT:     n_filesys.of_dirlist
//
//
// ARGUMENTS:  as_filespec		- File path
//             iAttrib			- Not used
//             as_files			- File Name array (By Ref)
//
// RETURN:		Number of files found
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06.12.2007	KlausF		
// -----------------------------------------------------------------------------

Integer li_file
Long ll_Handle
Boolean lb_found, lb_hidden, lb_system
String ls_filename
win32_find_data lstr_fd
//str_findresult	strFiles[]
// append filename pattern
If Right(as_filespec, 1) = "\" Then
	as_filespec += "*.*"
Else
	as_filespec += "\*.*"
End If

// find first file
ll_Handle = FindFirstFile(as_filespec, lstr_fd)
If ll_Handle < 1 Then Return -1

// loop through each file
Do
	// add file to array
	ls_filename = String(lstr_fd.cFilename)
	If ls_filename = "." Or ls_filename = ".." Then
	Else
		// get file properties
		li_file++
		strFiles[li_file].sFilename  = ls_filename
	End If
	// find next file
	lb_Found = FindNextFile(ll_Handle, lstr_fd)
Loop Until Not lb_Found

// close find handle
FindClose(ll_Handle)

Return li_file

end function

public function integer of_dir (string sfilespec, ref str_findresult strfiles[]);/* ### Event: of_dir *************************************
 *
 * Beschreibung : Datailiste eines Verzeichnises erstellen
 *                	
 *
 * R$$HEX1$$fc00$$ENDHEX$$ckgabewert: 0: erfolgreich
 *
 * Aenderungshistorie
 *  Version  Wer                        		Wann        	Was und warum
 *   1.0     K.F$$HEX1$$f600$$ENDHEX$$rster					       07.12.2007  	Erstellung
 *
 * ### END Eventdoku ***************************************************
 */
window lw_1

listbox llb_1

int li_items, li_i

Open( lw_1 )

lw_1.openUserObject( llb_1 )

llb_1.DirList( sFileSpec, 0 )

li_items = llb_1.TotalItems()

For li_i = 1 to li_items
 
	strFiles[li_i].sFilename  = llb_1.Text(li_i)

Next

lw_1.closeUserObject( llb_1 )

Close( lw_1 )

return 0


end function

public function boolean of_zip_log (string arg_path, string arg_filename, date arg_date);string sArchiveFile
long lreturn, i, j
str_findresult	strXMLFiles[]
String			sFiles[]

if right(arg_path,1) <> "\" then arg_path += "\"
	
//Archivfilename zusammenstellen
sArchiveFile = arg_path + arg_filename +"_" + String(arg_date, is_dateFormat) + ".zip"

//Dateiliste der Exportfiles erstellen
lReturn =  of_dir(arg_path + "*"+string(arg_date, is_dateFormat)+"*.*",  strXMLFiles)

if UpperBound(strXMLFiles) = 0 then
	f_Log2Csv(0,2,"Service found no Files in directory " + arg_path + " for Date: " + string(arg_date, is_dateFormat))
	return false
end if

// Dateien aus der Struktur in ein Array
j=0
For i = 1 to UpperBound(strXMLFiles)
	if pos(upper(strXMLFiles[i].sFilename),".ZIP")>0 then continue
	j++
	sFiles[j] = arg_path + strXMLFiles[i].sFilename
Next

if upperbound(sFiles)=0 then return true

//Dateien zippen
if of_zipfile(sFiles, sArchiveFile, True) then
	f_Log2Csv(0,0,"Service has zipped: " + String(UpperBound(strXMLFiles)) + " files to file " + sArchiveFile +  " for Date: "  + string(arg_date, "yyyy-mm-dd"))
	return true
else
	f_Log2Csv(0,2,"Zipping has failed: " + sErrorMessage +  " for Date: "  + string(arg_date, "yyyy-mm-dd"))
	return false
end if
end function

on uo_files_zippen.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_files_zippen.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

