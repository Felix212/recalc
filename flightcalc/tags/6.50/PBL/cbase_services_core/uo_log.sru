HA$PBExportHeader$uo_log.sru
forward
global type uo_log from nonvisualobject
end type
end forward

global type uo_log from nonvisualobject autoinstantiate
end type

type variables
/*
Version	: 1.9 
Date		: 05.06.2024 	

#**************************************************************
#Add to global Variables:
#**************************************************************
uo_log 	guoLog

#**************************************************************
#Add to open Event
#**************************************************************
guoLog.uf_init(s_app.is_Profile, s_app.is_Version +"-"+s_app.is_Build, s_app.is_Instance)
or 
guoLog.uf_init_direct( sPath, sFile, version, guoLog.OPT_error)

#**************************************************************
#Add to f_profile:
#**************************************************************
guoLog.uf_read_loglevel()

#**************************************************************
#Add to f_connect:
#**************************************************************
guoLog.uf_init_graylog()

#**************************************************************
#Now you can use to log:
#**************************************************************

guoLog.uf_fatal("["+ this.classname( )+".xFUNCTIONNAME] Test")
guoLog.uf_error("["+ this.classname( )+".xFUNCTIONNAME] Test")
guoLog.uf_warn("["+ this.classname( )+".xFUNCTIONNAME] Test")
guoLog.uf_info("["+ this.classname( )+".xFUNCTIONNAME] Test")
guoLog.uf_debug( "["+ this.classname( )+".xFUNCTIONNAME] Test")
guoLog.uf_trace("["+ this.classname( )+".xFUNCTIONNAME] Test")

guoLog.uf_allways("["+ this.classname( )+".xFUNCTIONNAME] Test")

*/

PUBLIC:

constant integer OPT_OFF 			= 0
constant integer OPT_FATAL 		= 1
constant integer OPT_ERROR 		= 2
constant integer OPT_WARN 		= 3
constant integer OPT_INFO 			= 4
constant integer OPT_DEBUG 		= 5
constant integer OPT_TRACE 		= 6
constant integer OPT_ALL 			= 7

// LOG Ever
constant integer OPT_ALWAYS 	= -1

PRIVATE:
string					is_profile = ""
string					is_instance = ""
string 				is_prg_version = ""
string					is_log_path
string					is_log_file
integer				ii_log_level

n_graylog_client 	invo_GrayLogClient
boolean				ib_GrayLogEnabled = false


end variables

forward prototypes
public function integer uf_log (integer arg_level, string arg_file_extension, string arg_msg)
private function integer uf_log2file (string arg_file_extension, string arg_msg)
public function integer uf_log (integer arg_level, string arg_msg)
public function integer uf_init (string arg_profile, string arg_version, string arg_instance)
public function integer uf_fatal (string arg_file_extension, string arg_msg)
public function integer uf_fatal (string arg_msg)
public function integer uf_error (string arg_file_extension, string arg_msg)
public function integer uf_error (string arg_msg)
public function integer uf_warn (string arg_file_extension, string arg_msg)
public function integer uf_warn (string arg_msg)
public function integer uf_info (string arg_file_extension, string arg_msg)
public function integer uf_info (string arg_msg)
public function integer uf_trace (string arg_file_extension, string arg_msg)
public function integer uf_trace (string arg_msg)
public function integer uf_debug (string arg_file_extension, string arg_msg)
public function integer uf_debug (string arg_msg)
public function integer uf_allways (string arg_file_extension, string arg_msg)
public function integer uf_allways (string arg_msg)
public function integer uf_init_direct (string arg_path, string arg_file, string arg_version, integer arg_loglevel)
public function integer uf_init (string arg_profile, string arg_version, string arg_instance, string arg_add_filename)
public function integer uf_get_loglevel ()
public subroutine uf_set_loglevel (integer arg_loglevel)
public function string uf_get_logfilename (string arg_file_extension)
public subroutine uf_send_to_graylog (unsignedinteger aui_messagetype, string as_message)
public function integer uf_init_graylog ()
public function integer uf_init_direct (string arg_pathfile, string arg_version, integer arg_loglevel)
public function integer uf_read_loglevel ()
end prototypes

public function integer uf_log (integer arg_level, string arg_file_extension, string arg_msg);string a

if arg_level > ii_log_level then return 1

a = ""
choose case arg_level
	case 1
		a = "[fatal] "
	case 2
		a = "[error] "
	case 3
		a = "[warn ] "
	case 4
		a = "[info ] "
	case 5
		a = "[debug] "
	case 6
		a = "[trace] "
	case else
		a = "        "
end choose

return uf_log2file(arg_file_extension, a + arg_msg)
end function

private function integer uf_log2file (string arg_file_extension, string arg_msg);string 	ls_LogMessage, ls_file, lsFileArchiv
integer 	iFile

if is_prg_version = "" then return 1

// ----------------------------------------------------
// Message verfeinern
// ----------------------------------------------------
ls_LogMessage = string(today(),"YYYY-MM-DD") + ", " + string(now(), "hh:mm:ss") + ", " +is_prg_version+", "+ arg_msg

ls_file =  uf_get_logfilename( arg_file_extension )

if FileLength(ls_file) > 50000000 then
	iFile 			= lastpos(ls_file, ".")
	lsFileArchiv 	= left(ls_file, iFile -1) + "-" + String(now(), "hhmmss") + mid(ls_file, iFile)
	
	if Filecopy(ls_file, lsFileArchiv, false) = 1 then
		if FileDelete(ls_file) then
			iFile = FileOpen(ls_file, LineMode!, Write!, LockWrite!, Append!)
			FileWrite(iFile, string(today(),"YYYY-MM-DD") + "," + string(now(), "hh:mm:ss") + ", File larger then Limit, Backup to " + lsFileArchiv)
			FileWrite(iFile, "################################################################# ")
			FileClose(iFile)
		end if
	end if
end if

iFile = FileOpen( ls_file, LineMode!, Write!, Shared!)
FileWrite(iFile, ls_LogMessage)
FileClose(iFile)

return 1
end function

public function integer uf_log (integer arg_level, string arg_msg);
return uf_log(arg_level, "", arg_msg)
end function

public function integer uf_init (string arg_profile, string arg_version, string arg_instance);
return uf_init(arg_profile, arg_version, arg_instance, "")
end function

public function integer uf_fatal (string arg_file_extension, string arg_msg);uf_send_to_graylog(OPT_FATAL, arg_msg)
return uf_log(OPT_FATAL, arg_file_extension, arg_msg)
end function

public function integer uf_fatal (string arg_msg);uf_send_to_graylog(OPT_FATAL, arg_msg)
return uf_log(OPT_FATAL, "", arg_msg)
end function

public function integer uf_error (string arg_file_extension, string arg_msg);uf_send_to_graylog(OPT_ERROR, arg_msg)
return uf_log(OPT_ERROR, arg_file_extension, arg_msg)
end function

public function integer uf_error (string arg_msg);uf_send_to_graylog(OPT_ERROR, arg_msg)
return uf_log(OPT_ERROR, "", arg_msg)
end function

public function integer uf_warn (string arg_file_extension, string arg_msg);uf_send_to_graylog(OPT_WARN, arg_msg)
return uf_log(OPT_WARN, arg_file_extension, arg_msg)
end function

public function integer uf_warn (string arg_msg);uf_send_to_graylog(OPT_WARN, arg_msg)
return uf_log(OPT_WARN, "", arg_msg)
end function

public function integer uf_info (string arg_file_extension, string arg_msg);uf_send_to_graylog(OPT_INFO, arg_msg)

return uf_log(OPT_INFO, arg_file_extension, arg_msg)
end function

public function integer uf_info (string arg_msg);uf_send_to_graylog(OPT_INFO, arg_msg)

return uf_log(OPT_INFO, "", arg_msg)
end function

public function integer uf_trace (string arg_file_extension, string arg_msg);
return uf_log(OPT_TRACE, arg_file_extension, arg_msg)
end function

public function integer uf_trace (string arg_msg);
return uf_log(OPT_TRACE, "", arg_msg)
end function

public function integer uf_debug (string arg_file_extension, string arg_msg);uf_send_to_graylog(OPT_DEBUG, arg_msg)
return uf_log(OPT_DEBUG, arg_file_extension, arg_msg)
end function

public function integer uf_debug (string arg_msg);uf_send_to_graylog(OPT_DEBUG, arg_msg)
return uf_log(OPT_DEBUG, "", arg_msg)
end function

public function integer uf_allways (string arg_file_extension, string arg_msg);uf_send_to_graylog(OPT_ALWAYS, arg_msg)
return uf_log(OPT_ALWAYS, arg_file_extension, arg_msg)
end function

public function integer uf_allways (string arg_msg);uf_send_to_graylog(OPT_ALWAYS, arg_msg)
return uf_log(OPT_ALWAYS, "", arg_msg)
end function

public function integer uf_init_direct (string arg_path, string arg_file, string arg_version, integer arg_loglevel);
is_prg_version = arg_version

is_log_path 		= arg_path

if right(is_log_path, 1 )<> "\" then is_log_path += "\"

is_log_file 		= arg_file

ii_log_level 		= arg_loglevel

return 1
end function

public function integer uf_init (string arg_profile, string arg_version, string arg_instance, string arg_add_filename);string ls_loglevel

is_prg_version = arg_version
is_profile 		= arg_profile
is_instance 		= arg_instance

is_log_path = f_Profile_String(arg_profile, "Log" , "Path", "c:\Temp\CBASE\")

if right(is_log_path, 1 )<> "\" then is_log_path += "\"

is_log_file = f_Profile_String(arg_profile, "Log" , "File", "LogFile")

if trim(arg_instance) > " " then
	is_log_file += "_" + trim(arg_instance)
end if

if trim(arg_add_filename) > " " then
	is_log_file += "_" + trim(arg_add_filename)
end if

ls_loglevel = f_Profile_String2(arg_profile, "Log" , "LogLevel", "4", "OFF=0; FATAL=1; ERROR=2; WARN=3; INFO=4; DEBUG=5; TRACE=6; ALL=7")

ls_loglevel = ProfileString(arg_profile, arg_instance, "LogLevel", ls_loglevel)

ii_log_level = integer(ls_loglevel)

return 1
end function

public function integer uf_get_loglevel ();return this.ii_log_level
end function

public subroutine uf_set_loglevel (integer arg_loglevel);this.ii_log_level = arg_loglevel
end subroutine

public function string uf_get_logfilename (string arg_file_extension);string ls_file

ls_file =  is_log_path + is_log_file + "_" + String(Today(), "yyyy-mm-dd") 
if trim(arg_file_extension) > " " then ls_file += "_" + arg_file_extension
ls_file += ".LOG"

return ls_file
end function

public subroutine uf_send_to_graylog (unsignedinteger aui_messagetype, string as_message);CONSTANT UInt MESSAGE_TYPE_SUCCESS = 0
CONSTANT UInt MESSAGE_TYPE_INFO = 1
CONSTANT UInt MESSAGE_TYPE_ERROR = 2
CONSTANT UInt MESSAGE_TYPE_SQL_ERROR = 3

if not ib_GrayLogEnabled then return

/*
CONSTANT UInt LOG_LEVEL_EMERGENCY = 0
CONSTANT UInt LOG_LEVEL_ALERT = 1
CONSTANT UInt LOG_LEVEL_CRITICAL = 2
CONSTANT UInt LOG_LEVEL_ERROR = 3
CONSTANT UInt LOG_LEVEL_WARNING = 4
CONSTANT UInt LOG_LEVEL_NOTICE = 5
CONSTANT UInt LOG_LEVEL_INFO = 6
CONSTANT UInt LOG_LEVEL_DEBUG = 7
*/

// Log to Graylog
Choose Case aui_MessageType
	Case OPT_FATAL
		invo_GrayLogClient.of_send(as_Message, invo_GrayLogClient.LOG_LEVEL_CRITICAL)
	Case OPT_ERROR
		invo_GrayLogClient.of_send(as_Message, invo_GrayLogClient.LOG_LEVEL_ERROR)
	Case OPT_WARN
		invo_GrayLogClient.of_send(as_Message, invo_GrayLogClient.LOG_LEVEL_WARNING)
	Case OPT_ALWAYS
		invo_GrayLogClient.of_send(as_Message, invo_GrayLogClient.LOG_LEVEL_NOTICE)
	case OPT_INFO
		invo_GrayLogClient.of_send(as_Message, invo_GrayLogClient.LOG_LEVEL_INFO)
	Case Else
		invo_GrayLogClient.of_send(as_Message, invo_GrayLogClient.LOG_LEVEL_DEBUG)
End Choose
end subroutine

public function integer uf_init_graylog ();string ls_temp

if f_profile_string(is_profile, "LOG", "NeverUseGraylog", "0") = "1" then
	uf_log(OPT_ALWAYS, "", "Graylog is disabled via INI")
	return 1
end if

  SELECT cen_setup.cValue  
   	   into :ls_temp
    FROM sys_login, cen_setup  
  WHERE sys_login.cclient = cen_setup.cclient
 		and cen_setup.cSection = 'GRAYLOG'
		and  cen_setup.cKey = 'USE'
		and upper(sys_login.cusername) = 'CBASE'   ;

if SQLCA.SQLCODE <> 0 then 
	uf_log(OPT_ALWAYS, "", "CEN_SETUP (GRAYLOG - USE) not set. Graylog is deactivated")
	ls_temp = "0"
end if

ib_GrayLogEnabled = ( ls_temp = "1" )

if not ib_GrayLogEnabled then
	if f_profile_string(is_profile, "LOG", "UseGraylog", "0") = "1" then
		uf_log(OPT_ALWAYS, "", "Graylog is activated via INI")
		ib_GrayLogEnabled = true
	end if
end if

if ib_GrayLogEnabled then

  SELECT cen_setup.cValue  
   	   into :ls_temp
    FROM sys_login, cen_setup  
  WHERE sys_login.cclient = cen_setup.cclient
 		and cen_setup.cSection = 'GRAYLOG'
		and  cen_setup.cKey = 'LogEndpoint'
		and upper(sys_login.cusername) = 'CBASE'   ;
		
	if SQLCA.SQLCODE <> 0 then 
		ib_GrayLogEnabled = false
		uf_log(OPT_ALWAYS, "", "CEN_SETUP (GRAYLOG - ENDPOINT) not set. Graylog is deactivated.")
		return 1
	end if
	
	invo_GrayLogClient = create n_graylog_client 	
	
	invo_GrayLogClient.of_init(ls_temp, lower(gs_servicename + "_" + is_instance), is_prg_version, is_log_path)
	
	uf_log(OPT_ALWAYS, "", "Graylogging is activated and sends to " + ls_temp)
end if

return 1
end function

public function integer uf_init_direct (string arg_pathfile, string arg_version, integer arg_loglevel);integer lpos

is_prg_version = arg_version

lpos = lastpos(arg_pathfile, "\")
is_log_path 		= left(arg_pathfile, lpos)

if right(is_log_path, 1 )<> "\" then is_log_path += "\"

is_log_file 		= mid(arg_pathfile, lpos +1)

ii_log_level 		= arg_loglevel

return 1
end function

public function integer uf_read_loglevel ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_log
// Methode: uf_read_loglevel (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Re-Read LogLevel from Profile
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  12.09.2022	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
string 	ls_loglevel

if trim(is_profile) > " " and trim(is_instance) > " " then

	ls_loglevel = f_Profile_String2(is_profile, "Log" , "LogLevel", "4", "OFF=0; FATAL=1; ERROR=2; WARN=3; INFO=4; DEBUG=5; TRACE=6; ALL=7")

	ls_loglevel = ProfileString(is_profile, is_instance, "LogLevel", ls_loglevel)
	
	ii_log_level = integer(ls_loglevel)
end if

return 1
end function

on uo_log.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_log.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;if isvalid(invo_GrayLogClient) then
	destroy invo_GrayLogClient
end if
end event

