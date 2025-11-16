HA$PBExportHeader$uo_drive_check.sru
forward
global type uo_drive_check from nonvisualobject
end type
end forward

global type uo_drive_check from nonvisualobject autoinstantiate
end type

type prototypes


FUNCTION long GetVolumeInformationA & 
  (string lpRootPathName, REF string lpVolumeNameBuffer, &
   long nVolumeNameSize, & 
   REF long lpVolumeSerialNumber, REF long lpMaximumComponentLength, & 
   REF long lpFileSystemFlags, REF string lpFileSystemNameBuffer, & 
   long nFileSystemNameSize) & 
   LIBRARY "Kernel32.dll" ALIAS FOR "GetVolumeInformationA"
	
	
		
	FUNCTION boolean GetVolumeInformation(ref string lpRootPathName,ref string lpVolumeNameBuffer,ulong nVolumeNameSize,ref ulong lpVolumeSerialNumber,ref ulong lpMaximumComponentLength,ref ulong lpFileSystemFlags,ref string lpFileSystemNameBuffer,ulong nFileSystemNameSize) Library "kernel32.dll"
	
	
	FUNCTION ulong WNetGetConnectionA  ( ref string drv, ref string unc, ref ulong buf )  LIBRARY "mpr.dll"



 Function long GetDriveTypeA (String drive) Library "kernel32.dll"

end prototypes

type variables


uo_files	iuo_files
end variables

forward prototypes
public function integer of_check_drives ()
public function integer of_log (string as_msg)
public function string of_get_unc (string as_path)
public function string of_zzz ()
public function integer of_xxxxxxxx ()
public function long of_dirlist (string as_spec, integer al_file_type, ref str_findresult rastr_result[])
public function integer of_check_drive (string as_letter)
public function integer of_map_drive (string as_share, string as_drive_letter, string as_user, string as_pwd)
end prototypes

public function integer of_check_drives ();

String ls_volbuffer, ls_fsname
uLong  ll_serial, ll_MaxCompLength, ll_FileSystemFlags
Boolean	ll_rtn
string	ls_LocalName
Long		ll_X, li_Counter_2
string	ls_RemoteName

string	ls_Drive_Spec
String	ls_MSG
String	ls_UNC
str_findresult	lstr_result[], lstr_result_empty[]

Integer	li_Type = 16400
ls_volbuffer = Space(255)
ls_fsname = Space(255)
ll_maxCompLength = 0
ll_FileSystemFlags = 0

integer li_Counter
Long	ll_Files
 int i_iX
 uint ui_cb

/*

$$HEX2$$b7000900$$ENDHEX$$
0 - Read/write files$$HEX2$$b7000900$$ENDHEX$$
1 - Read-only files$$HEX2$$b7000900$$ENDHEX$$
2 - Hidden files$$HEX2$$b7000900$$ENDHEX$$
4 - System files$$HEX2$$b7000900$$ENDHEX$$
16 - Subdirectories$$HEX2$$b7000900$$ENDHEX$$
32 - Archive (modified) files$$HEX2$$b7000900$$ENDHEX$$
16384 - Drives$$HEX2$$b7000900$$ENDHEX$$
32768 - Exclude read/write files from the list
To list several types, add the numbers associated with the types. 
For example, to list read-write files, subdirectories, and drives, use 0+16+16384 or 16400 for filetype.
*/

//of_xxxxxxxx()




	iuo_files = CREATE uo_files	


of_log("*************************************************************************")


  ls_Drive_Spec = ProfileString(sProfile, "Misc", "WebDocPath", "c:\temp\webdoc\")

//	ll_Files = of_dirlist(ls_Drive_Spec + "*.*" , li_type , lstr_result)
//
//	//ll_Files = of_dirlist("t:\*.*" )
//	
//	of_log("Checking Result " +  ls_Drive_Spec + "   " + String( ll_Files))
//
//WebDocPath=\\10.102.16.80\c$\Inetpub\wwwroot\Temp\


FOR li_Counter = 3 to 26
	lstr_result = lstr_result_empty
	
	ls_volbuffer = Space(255)
	ls_fsname = Space(255)
	ll_maxCompLength = 0
	ll_FileSystemFlags = 0

    ls_Drive_Spec = CharA(64 + li_Counter) + ":\"

		ll_Files = of_dirlist(ls_Drive_Spec + "*.*" , li_type , lstr_result)

	//ll_Files = of_dirlist("t:\*.*" )
	
	of_log("Check Result " +  ls_Drive_Spec + "   " + String( ll_Files))

	For li_Counter_2 = 1 to upperbound(lstr_result)
		If lstr_result[li_Counter_2].bsubdirectory OR lstr_result[li_Counter_2].bdrive Then
			of_log("Directory " +  ls_Drive_Spec + "   " + lstr_result[li_Counter_2].sfilename  )
		End If
	Next
Next

//of_zzz()

/*
GetVolumeInformation(
ref string lpRootPathName,
ref string lpVolumeNameBuffer,
ulong nVolumeNameSize,
ref ulong lpVolumeSerialNumber,
ref ulong lpMaximumComponentLength,
ref ulong lpFileSystemFlags,
ref string lpFileSystemNameBuffer,
ulong nFileSystemNameSize
) Library "kernel32.dll"
	*/


/*
 (string lpRootPathName, 
 REF string lpVolumeNameBuffer, &
   long nVolumeNameSize, & 
   REF long lpVolumeSerialNumber, 
	REF long lpMaximumComponentLength, & 
   REF long lpFileSystemFlags, 
	REF string lpFileSystemNameBuffer, & 
   long nFileSystemNameSize) & 
	*/

ulong	nVolumeNameSize = 255
ulong nFileSystemNameSize = 255
Long	lnVolumeNameSize
Long	lnFileSystemNameSize
Long	llFileSystemFlags, llMaxCompLength, llserial



of_log("*************************************************************************")


// ls_Drive_Spec = "T:"
//
//   ll_X = GetVolumeinformationA(ls_Drive_Spec, ls_volbuffer, lnVolumeNameSize, llserial, & 
//                 llMaxCompLength, llFileSystemFlags , ls_fsname, lnFileSystemNameSize)
//
////    ll_rtn = GetVolumeinformation(ls_Drive_Spec, ls_volbuffer, nVolumeNameSize, ll_serial, & 
////                 ll_MaxCompLength, ll_FileSystemFlags , ls_fsname, nFileSystemNameSize)
////
//	 
//	 ls_MSG = "ll_rtn=" + String(ll_rtn) + "  " + trim(ls_volbuffer) + "  ll_serial=" + String(ll_serial) + "  " + trim(ls_fsname)
//	 
//	 of_log(ls_MSG)
//
// ls_UNC = of_get_unc("T:")
//	 
//	  of_log(ls_UNC)
//	 
//FOR li_Counter = 3 to 26
//
//	ls_volbuffer = Space(255)
//	ls_fsname = Space(255)
//	ll_maxCompLength = 0
//	ll_FileSystemFlags = 0
//
//    ls_Drive_Spec = CharA(64 + li_Counter) + ":\"
//
//    ll_rtn = GetVolumeinformation(ls_Drive_Spec, ls_volbuffer, 255, ll_serial, & 
//                 ll_MaxCompLength, ll_FileSystemFlags , ls_fsname, 255)
//	 
//	 ls_MSG = "ll_rtn=" + String(ll_rtn) + "  " + trim(ls_volbuffer) + "  ll_serial=" + String(ll_serial) + "  " + trim(ls_fsname)
//	 
//	 of_log(ls_MSG)
//	 	 
//	 ls_UNC = of_get_unc(ls_Drive_Spec)
//	 
//	  of_log(ls_UNC)
//	 
////		ls_LocalName = char ( 64 + li_Counter) + ":"
////		ls_RemoteName = space(128)
////		ui_cb = 127
////		IF WNetGetConnectionA( ls_LocalName, ls_RemoteName, ui_cb ) = 0 THEN
////			  of_log ( ls_LocalName + "~t- " + ls_RemoteName )
////		ELSE
////			  IF ii_bShowNotConnected THEN
////					 of_log ( ls_LocalName + "~t- not connected" )
////			  END IF
////		END IF
//	 
//NEXT
//
//
////ls_volbuffer = Space(255)
////ls_fsname = Space(255)
////ll_maxCompLength = 0
////ll_FileSystemFlags = 0
////
////ll_rtn = GetVolumeinformation("C:\", ls_volbuffer, 255, ll_serial, & 
////                 ll_MaxCompLength, ll_FileSystemFlags , ls_fsname, 255)
////
//// ls volbuffer  - volume name
//// ll_serial     - hard disk serial number
//// ls_fsname     - file system name ex. NTFS
//
//
return 1
end function

public function integer of_log (string as_msg);integer iFile


iFile = FileOpen( sLogPath  + classname() + "_" + string(Today(), "yyyymmdd") + "_cbase_document_engine" +   ".log", LineMode!, Write!, Shared!)

FileWrite(iFile, "[" + string(today(), "dd.mm.yyyy") + "-" + string(now(), "hh:mm:ss") + "] " + as_Msg)
FileClose(iFile)

return 0


end function

public function string of_get_unc (string as_path);string    ls_tmp, ls_unc
Ulong     ll_rc, ll_size

ls_tmp = upper(left(as_path,2))
IF right(ls_tmp,1) <> ":" THEN RETURN as_path

ll_size = 255
ls_unc = Space(ll_size)

ll_rc = WNetGetConnectionA (ls_tmp, ls_unc, ll_size)
IF  ll_rc = 2250 THEN
    // prbably local drive
    RETURN as_path
END IF

IF ll_rc <> 0 THEN
   // MessageBox("UNC Error",  "Error " + string(ll_rc) + " retrieving UNC for " + ls_tmp)
    RETURN as_path
END IF

// Concat and return full path
IF len(as_path) > 2 THEN
   ls_unc = ls_unc + mid(as_path,3)
END IF

RETURN ls_unc
end function

public function string of_zzz ();

//function ulong WNetGetConnectionA( string szLocalPath, &
//   ref string szNameBuffer,  ref ulong lpBufferSize) Library "mpr"
//
//Then in your script you can call the API as follows:

Ulong lul_Max
Long ll_RC
String ls_Drive, ls_Volume

// hard coded for the f: drive
ls_Drive = 't:'
lul_Max = 2000

// pre allocate string to stop GPF
ls_Volume = Space( 2000 )

// call the API function, the share name
// will be in the ls_Volume variable
ll_RC = WNetGetConnectionA( ls_Drive, ls_Volume, lul_Max )
ls_Volume = Trim( ls_Volume )

return ls_Volume
end function

public function integer of_xxxxxxxx ();// Function Unit GetDriveTypeA (String drive) Library "kernel32.dll"

//1, said the unknown, 2 that the floppy drive, 3 that the local hard disk 4 that the network drive, that drive 5
//
//Parameters for a drive letter (such as "C:"), return value: 1, said the unknown, 2 that the floppy drive, 3 that the local hard disk
//
//, 4 that the network drive, that drive 5. Therefore the following code can be CD-ROM drive letter:
//
uint	i
For I = Asc ( 'C') to Asc ( 'Z')
//
/// / Enumerate all possible CDROM drive
//
	//If GetDriveTypeA (Char (i )+":") = 5 Then
	
	of_log("GetDriveTypeA for " + Char (i ) + ":    " + String(GetDriveTypeA (Char (i )+":")) )

/// / If found CDROM
//
//Messagebox ( "CDROM", Char (i )+":")
//
/// / Show the CD-ROM drive
//
//Exit / / exit the cycle
//
//End if
//
Next 


return 1
end function

public function long of_dirlist (string as_spec, integer al_file_type, ref str_findresult rastr_result[]);
Long		ll_Return


str_findresult	lstr_result[]

//16400

//ll_Return = iuo_files.of_dirlist("T:\*.*", 16400 , lstr_result)
ll_Return = iuo_files.of_dirlist(as_spec, al_file_type , rastr_result)


//ls_Drive_Spec = "T:"
//
//   ll_X = GetVolumeinformationA(ls_Drive_Spec, ls_volbuffer, lnVolumeNameSize, llserial, & 
//                 llMaxCompLength, llFileSystemFlags , ls_fsname, lnFileSystemNameSize)
//
////    ll_rtn = GetVolumeinformation(ls_Drive_Spec, ls_volbuffer, nVolumeNameSize, ll_serial, & 
////                 ll_MaxCompLength, ll_FileSystemFlags , ls_fsname, nFileSystemNameSize)
////
//	 
//	 ls_MSG = "ll_rtn=" + String(ll_rtn) + "  " + trim(ls_volbuffer) + "  ll_serial=" + String(ll_serial) + "  " + trim(ls_fsname)
//	 
//	 of_log(ls_MSG)


return ll_Return
end function

public function integer of_check_drive (string as_letter);

String ls_volbuffer, ls_fsname
uLong  ll_serial, ll_MaxCompLength, ll_FileSystemFlags
Boolean	ll_rtn
string	ls_LocalName
Long		ll_X, li_Counter_2
string	ls_RemoteName

string	ls_Drive_Spec
String	ls_MSG
String	ls_UNC
str_findresult	lstr_result[], lstr_result_empty[]

Integer	li_Type = 16400
ls_volbuffer = Space(255)
ls_fsname = Space(255)
ll_maxCompLength = 0
ll_FileSystemFlags = 0

//integer li_Counter
Long	ll_Files
 int i_iX
 uint ui_cb

/*
0 - Read/write files$$HEX2$$b7000900$$ENDHEX$$
1 - Read-only files$$HEX2$$b7000900$$ENDHEX$$
2 - Hidden files$$HEX2$$b7000900$$ENDHEX$$
4 - System files$$HEX2$$b7000900$$ENDHEX$$
16 - Subdirectories$$HEX2$$b7000900$$ENDHEX$$
32 - Archive (modified) files$$HEX2$$b7000900$$ENDHEX$$
16384 - Drives$$HEX2$$b7000900$$ENDHEX$$
32768 - Exclude read/write files from the list
To list several types, add the numbers associated with the types. 
For example, to list read-write files, subdirectories, and drives, use 0+16+16384 or 16400 for filetype.
*/

iuo_files = CREATE uo_files	

//of_log("*************************************************************************")

ls_Drive_Spec = ProfileString(sProfile, "Misc", "WebDocPath", "c:\temp\webdoc\")

//	ll_Files = of_dirlist(ls_Drive_Spec + "*.*" , li_type , lstr_result)
//
//	//ll_Files = of_dirlist("t:\*.*" )
//	
//	of_log("Checking Result " +  ls_Drive_Spec + "   " + String( ll_Files))
//
//WebDocPath=\\10.102.16.80\c$\Inetpub\wwwroot\Temp\


//FOR li_Counter = 3 to 26
lstr_result = lstr_result_empty

ls_volbuffer = Space(255)
ls_fsname = Space(255)
ll_maxCompLength = 0
ll_FileSystemFlags = 0

// ls_Drive_Spec = CharA(64 + li_Counter) + ":\"
ls_Drive_Spec = as_Letter + ":\"
ll_Files = of_dirlist(ls_Drive_Spec + "*.*" , li_type , lstr_result)
//ll_Files = of_dirlist("t:\*.*" )
of_log("Check Result " +  ls_Drive_Spec + "   " + String( ll_Files))

If ll_Files < 0 then
	return -1
End if

For li_Counter_2 = 1 to upperbound(lstr_result)
	If lstr_result[li_Counter_2].bsubdirectory OR lstr_result[li_Counter_2].bdrive Then
		of_log("Directory " +  ls_Drive_Spec + "   " + lstr_result[li_Counter_2].sfilename  )
	End If
Next

//ulong	nVolumeNameSize = 255
//ulong nFileSystemNameSize = 255
//Long	lnVolumeNameSize
//Long	lnFileSystemNameSize
//Long	llFileSystemFlags, llMaxCompLength, llserial
//of_log("*************************************************************************")

return 1
end function

public function integer of_map_drive (string as_share, string as_drive_letter, string as_user, string as_pwd);Integer	li_Succ 
//String	ls_Name
//String	ls_User
//String	ls_PWD
String	ls_Drive
String	ls_Error


uo_windows_networking_functions	lnv_Net_Func

lnv_Net_Func = CREATE uo_windows_networking_functions

//ls_Name	= "\\mlserver\c$"
//ls_User	= "U000000"
//ls_PWD	= "lsyas"
//ls_Drive	= "Q:"
ls_Drive    = Left(as_Drive_Letter, 1) + ":"


If lnv_Net_Func.of_map_network_drive(as_Share, ls_Drive, as_User, as_PWD, FALSE) = FALSE Then
	ls_Error = lnv_Net_Func.of_get_last_error( )
	//messagebox("MAP Failed", ls_Error)
	li_Succ = -1
End If

DESTROY lnv_Net_Func

Return li_Succ
end function

on uo_drive_check.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_drive_check.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;

DESTROY 	iuo_files
end event

