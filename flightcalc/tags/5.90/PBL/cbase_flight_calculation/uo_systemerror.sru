HA$PBExportHeader$uo_systemerror.sru
forward
global type uo_systemerror from nonvisualobject
end type
type str_email from structure within uo_systemerror
end type
type str_address from structure within uo_systemerror
end type
type str_attachment from structure within uo_systemerror
end type
type str_connectionparms from structure within uo_systemerror
end type
end forward

type str_email from structure
	long		smtpserver_key
	string		smtpserver
	unsignedinteger		smtpport
	string		smtpusername
	string		smtppassword
	boolean		smtpuseauth
	str_address		mailfrom
	string 			receivermaillist     // Entspricht mit Semikolon getrennter Liste aus mailto.email-Elementen 
	string 			receiverfullnamelist // Entspricht mit Semikolon getrennter Liste aus mailto.name-Elementen 
	str_address		mailto[]
	str_address		mailcc[]
	str_address		mailbcc[]
	string		subject
	string		body
	string		encryption
	str_attachment		attachmentlist[]
	boolean		ishtml
	boolean		returnreceipt
	string		priority
	integer		nprio
end type

type str_address from structure
	string		email
	string		name
end type

type str_attachment from structure
	string		filename
	blob		data
	boolean		inline
end type

type str_connectionparms from structure
	string		ls_DBMS 		
	string		ls_ServerName 	
	string		ls_DBParm 		
	string		ls_Database 	
	string		ls_ID			
	string		ls_PWD			
	boolean		lb_AutoCommit
	boolean 	lb_connectionparms_is_set
end type

global type uo_systemerror from nonvisualobject autoinstantiate
end type

type prototypes

FUNCTION int GetModuleFileName(ulong hinstModule,REF string lpszPath,ulong cchPath) LIBRARY "kernel32" alias for "GetModuleFileNameA;Ansi"
Function boolean GetComputerName (ref string lpBuffer, ref ulong nSize)  LIBRARY "kernel32.dll" alias for "GetComputerNameA;Ansi"
end prototypes

type variables
/*
######################################################################
Folgendes in den Systemevent eintragen:

	uo_systemerror uose
	uose.of_systemerror( gs_Version + "-" + gs_Build, sInstance, sProfile)
	//uose.of_systemerror( sVersion + "-" + sBuild, sInstance, sProfile)
	//uose.of_systemerror( s_app.sVersion, sInstance, s_app.sProfile)
	halt

######################################################################
Folgendes in den OPEN (nachdem Profile und LOGFILE-Variablen gesetzt sind) eintragen :

	// --------------------------------------------------------------------------------------------------------------------
	// Wir setzen ggf. in der INI die ben$$HEX1$$f600$$ENDHEX$$tigtenParameter f$$HEX1$$fc00$$ENDHEX$$r den Fall eines SYSTEMERROR
	// Anschlie$$HEX1$$df00$$ENDHEX$$end pr$$HEX1$$fc00$$ENDHEX$$fen wir, ob wir testweise einen SYSTEMFEHLER erzeugen sollen
	// --------------------------------------------------------------------------------------------------------------------
	uo_systemerror uose
	uose.is_Profile = sProfile
	
	if ProfileString("UO_SYSTEMERROR.INI", "SYSTEMERROR","TEST_SYSTEMERROR","") = "" then
		uose.of_init()
	end if
	
	uose.of_test_systemerror()
	
######################################################################
Folgendes im DBERROR-Event eines Datawindow/-stores eintragen

	uo_systemerror uose
	uose.of_dw_error(  gs_Version + "-" + gs_Build, sInstance, sProfile,sqldbcode , sqlerrtext, this.dataobject, "Error in row "+string( row) + " "+sqlsyntax)
	//uose.of_dw_error( sVersion + "-" + sBuild, sInstance, sProfile,sqldbcode , sqlerrtext, this.dataobject, "Error in row "+string( row) + " "+sqlsyntax)
	//uose.of_dw_error( s_app.sVersion, sInstance, s_app.sProfile,sqldbcode , sqlerrtext, this.dataobject, "Error in row "+string( row) + " "+sqlsyntax)
	
######################################################################
	Folgendes ans Ende vom f_connect eintragen
	
	uo_systemerror uose
	uose.of_init_db()
*/

PRIVATE:
// ### Bei $$HEX1$$c400$$ENDHEX$$nderungen an diesem Object, immer auch folgende Umgebungsvariabale anpassen
string is_systemerror_version = "1.11 vom 27.09.2019"
string is_CRLF = "~r~n"

string is_dbms, is_servername, is_dbparm, is_id, is_pwd
boolean ib_autocommit
string		is_apppath = ""

PUBLIC:
string 	is_app_name 
string 	is_app_server 
string		is_mail_adresses	= "heiko.rothenbach@lhind.dlh.de; klaus.foerster@lhind.dlh.de"
string		is_mail_names		= "Heiko Rothenbach; Klaus F$$HEX1$$f600$$ENDHEX$$rster"

string		is_from_mail		= "cbase_no_reply@lsgskychefs.com"
string		is_from_text			= "SYSTEMERROR "
string	 	is_DBServer			= "PCBASEDE"


// Fehlertext und Fehler-Datastore
String		is_ErrorMessage 	= ""

// Ini-Datei mit Profile
string is_Profile 				= "UO_SYSTEMERROR.INI"
string is_profile_section  		= "DATABASE" 

string				smessage, sreceiver, sreceiver_fullname, ssubject
string				is_service 	= ""

PROTECTED:

transaction		itr_email

// schalter: datenbank-anbindung aktiv
Boolean			ib_Connected = false



end variables

forward prototypes
public function integer of_connect ()
public function boolean of_is_connected ()
public function string of_get_executeable_name ()
public function integer of_sendmail ()
public subroutine of_test_systemerror ()
public function integer of_init ()
public function integer of_systemerror (string arg_versionbuild, string arg_instance, string arg_profile)
public function integer of_dw_error (string arg_versionbuild, string arg_instance, string arg_profile, long arg_sql_errcode, string arg_sql_errtext, string arg_datawindowobject, string arg_text)
public function integer of_init_db ()
public function string of_get_cen_setup (string arg_section, string arg_key, string arg_default)
public function integer of_send_mail (string arg_text, string arg_subject)
public function datetime of_datetime (string ls_datetime)
public function long of_dt_diff (datetime dt1, datetime dt2)
public function integer of_check_inifile ()
public subroutine of_get_app_path ()
end prototypes

public function integer of_connect ();// ----------------------------------
// wenn angemeldet, dann erstmal aufr$$HEX1$$e400$$ENDHEX$$umen
// ----------------------------------
if isValid(this.itr_email) then
	disconnect using this.itr_email;
	destroy(this.itr_email)
	this.itr_email = create transaction
end if

is_DBMS 				= ProfileString(is_Profile, is_profile_section, "DBMS", "ODBC")
is_DBParm 			= ProfileString(is_Profile, is_profile_section, "DBPARM", "")
is_ID					= ProfileString(is_Profile, is_profile_section, "LogID", "")
is_PWD				= ProfileString(is_Profile, is_profile_section, "LogPass", "")

is_ServerName = ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MAIL_DB", "")

// Falls der Server explizit angegeben wurde, dann $$HEX1$$fc00$$ENDHEX$$berschreiben
if is_ServerName = "" then 
	is_ServerName = "PCBASEDE"
	SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MAIL_DB", is_ServerName)
end if

// ----------------------------------
// Verbindung zu CBASE herstellen
// ----------------------------------
this.itr_email.DBMS 			= is_dbms	
this.itr_email.ServerName 	= is_servername
this.itr_email.DBParm			= is_dbparm
this.itr_email.LogId 			= is_id
this.itr_email.LogPass			= is_pwd
this.itr_email.AutoCommit 	= ib_autocommit

connect using this.itr_email;

if this.itr_email.SQLCode <> 0 then
	f_log2csv(0,2,"[uo_systemerror.of_connect] SQLCODE :" + string(itr_email.sqlcode)+ "   SQLDBCODE: "+  string(itr_email.sqldbcode)+"  SQLERRTEXT: "+ this.itr_email.sqlerrtext)

	this.ib_Connected = false
	return -1
else
	this.ib_Connected = true
	return 0
end if

return 0
end function

public function boolean of_is_connected ();
// --------------------------------------------------------------------------------
// Objekt : uo_send_email2
// Function: boolean of_is_connected ()
// Autor  : MHO
// --------------------------------------------------------------------------------
// Argument(e):	none
// --------------------------------------------------------------------------------
// Return: boolean : True : Connection hat geklappt
//  				 False : Fehler in is_ErrorMessage
// --------------------------------------------------------------------------------
//  Beschreibung: pr$$HEX1$$fc00$$ENDHEX$$fe die datenbank-anbindung 
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum         Version      Autor              Kommentar
// --------------------------------------------------------------------------------
//  2014-01-23    	1.0			MHO		   Erstellung			Vorlage: uo_sent_email_mm4
// --------------------------------------------------------------------------------

string ls_Dummy

if not isvalid(itr_email) then return false

select dummy into :ls_Dummy from dual using this.itr_email;
if this.itr_email.sqlcode <> 0 then
	//f_log2csv(0,2,"[uo_systemerror.of_is_connected] Check for IsConnected failed")
	return false
end if

return true

end function

public function string of_get_executeable_name ();string		sAppPath
string		sFullPath
string		sExe			= ""
integer	iRet
integer	iPos 			= 0

sFullpath 	= Space (1024)
iRet 			= GetModuleFileName (Handle (GetApplication()),sFullPath,1024)

if IRet > 0 then 
	
	do while (Pos (sFullPath, "\",iPos + 1) > 0)
		iPos = Pos (sFullPath, "\",iPos + 1)
	loop
	sAppPath	= Mid (sFullPath,1,iPos - 1)
	sExe		= Mid (sFullPath,iPos + 1)
end if

Return sExe
end function

public function integer of_sendmail ();
long 			llsequence
datetime 	dtnow
blob 			lBlob

this.is_ErrorMessage 	= ""

if of_is_connected() = false then
	if of_connect() = -1 then
		return 1
	end if
end if

//Wenn Umgebungsvariable IS_SERVICE gesetzt ist, dann geschickt wird diese Info auch mit
if is_service > " " then
	lBlob = blob(is_service+" on Database "+SQLCA.ServerName+char(10)+char(13)+ this.smessage)
else
	lBlob = blob( this.smessage)
end if

llSequence = f_sequence("seq_cen_email",itr_email)
		
if llSequence = -1 then
	this.is_ErrorMessage 	= "ERROR Getting seq_cen_email.nextval"
	return 1
end if
	
select sysdate into :dtnow from dual using itr_email;
		
INSERT INTO cen_email  
		( nem_nkey,   
		  nem_nems_nkey,   
		  nem_csendname,   
		  nem_csendemail,   
		  nem_cfromname,   
		  nem_cfromemail,   
		  nem_csubject,   
		  //nem_cbody,   
		  nem_nprio,   
		  nem_dcreate)  
  VALUES ( :llSequence,   
			  1000,   
			  :sreceiver_fullname,   
			  :sreceiver,   
			  :is_from_text,   
			  :is_from_mail,   
			  :ssubject,   
			  //:sMessage,   
			  1,   
			  :dtNow) 
	USING itr_email;
	
if itr_email.sqlcode = 0 then
	updateblob cen_email  
	           set nem_cbody 	=  :lBlob 
	       where nem_nkey 	=  :llSequence 
	       USING itr_email;
	
	if itr_email.sqlcode <> 0 then
		this.is_ErrorMessage 	= "ERROR Update Message: "+string(itr_email.sqlcode)+" "+itr_email.sqlerrtext
	end if	
	
	commit using itr_email;
	
	return 0
else
	this.is_ErrorMessage 	= "ERROR Insert E-Mail-Job: "+string(itr_email.sqlcode)+" "+itr_email.sqlerrtext
	rollback using itr_email;
	return 1
end if
end function

public subroutine of_test_systemerror ();integer i, j

if ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR","TEST_SYSTEMERROR","0") = "1" then

	SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR","TEST_SYSTEMERROR","0")
	j = 0
	i = 1 / j
	
end if
end subroutine

public function integer of_init ();
/* 
* Funktion:			of_init
* Beschreibung: 	(default-)parameter schreiben
* Besonderheit: 	keine
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 	Wer							Wann			Was und warum
*	1.0 		Heiko Rothenbach			xx.xx.xxxx	Erstellung
*	1.1 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel				08.08.2019	nur schreiben, wenn n$$HEX1$$f600$$ENDHEX$$tig, dazu (um timestamp zu sch$$HEX1$$fc00$$ENDHEX$$tzen und sperren zu vermeiden)
* 																Schalter USE_DEFAULT neu dazu
*
* Return Codes:
*	 0		immer
*
*/

of_check_inifile()

if ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "USE_DEFAULT","-1") = "-1" then
	SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "USE_DEFAULT","1")
end if

// nur schreiben, wenn die hier eingetragenen Defaults auch genommen werden sollen
if ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "USE_DEFAULT","1") = "1" then
	// default-parameter schreiben, ABER NUR WENN N$$HEX1$$d600$$ENDHEX$$TIG !!
	if ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MAIL_DB","") <> is_DBServer then
		SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MAIL_DB", is_DBServer)
	end if
	
	if ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MAIL_ADRESSES","") <> is_mail_adresses then
		SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MAIL_ADRESSES", is_mail_adresses)
	end if
	
	if ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MAIL_NAMES","") <> is_mail_names then
		SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR","MAIL_NAMES", is_mail_names)
	end if
	
	if ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "TEST_SYSTEMERROR","") = "" then
		SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR","TEST_SYSTEMERROR","0")
	end if
end if

return 0
end function

public function integer of_systemerror (string arg_versionbuild, string arg_instance, string arg_profile);Long 		lSequence
uLong 	lpnSize
datetime dtNow
string		ls_text, ls_exe, ls_db

//is_Profile = arg_profile

f_log2csv(0,2,'[uo_systemerror.of_systemerror] ')
f_log2csv(0,2,'[uo_systemerror.of_systemerror] ########################################################################')
f_log2csv(0,2,"[uo_systemerror.of_systemerror] Systemerror: ")
f_log2csv(0,2,"[uo_systemerror.of_systemerror] Error Number: "+String(error.number) + " / " + error.text)

is_app_name 	= of_get_executeable_name()
dtNow			= Datetime(Today(),Now())

lpnSize = 255
is_app_server = fill(" ", lpnSize)

if not GetComputerName(is_app_server, lpnSize) then
	is_app_server = "n\a"
end if

if isnull(is_app_server) then is_app_server = "n\a"
	
ls_exe = of_get_executeable_name()
is_servername	 = ProfileString(arg_profile,"Database","Server","")

ls_text =      "Rechner: " + is_app_server
if not isnull(ls_exe) then ls_text += "~r~nProgramm: " + ls_exe
if not isnull(ls_exe) then ls_text += "~r~nVersion: " + arg_versionbuild +" / uo_systemerror: " + is_systemerror_version
if arg_instance > " " then ls_text += "~r~nInstance: " + arg_instance
if not isnull(ls_exe) then ls_text += "~r~nDatenbank: " + is_servername
ls_text += "~r~nZeit: " + string(dtNow, "dd.mm.yyyy hh:mm:ss")
if not isnull(error.number) then ls_text += "~r~nError Number: " + string(error.number)
if not isnull(error.windowmenu) then ls_text += "~r~nWindowmenu: " + error.windowmenu
if not isnull(error.object) then ls_text += "~r~nObject: " + error.object
if not isnull(error.objectevent) then ls_text += "~r~nObjectevent: " + error.objectevent
if not isnull(error.line) then ls_text += "~r~nLine: " + string(error.line)
if not isnull(error.text) then ls_text += "~r~nFehlertext:~r~n" + error.text

if  ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR","MailOnSYSTEMERROR","1") = "1" then
	of_send_mail(ls_text, "Systemerror ")
end if

f_log2csv(0,2,'[uo_systemerror.of_systemerror] ########################################################################')
f_log2csv(0,2,'[uo_systemerror.of_systemerror]  ')

return 1
end function

public function integer of_dw_error (string arg_versionbuild, string arg_instance, string arg_profile, long arg_sql_errcode, string arg_sql_errtext, string arg_datawindowobject, string arg_text);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_systemerror
// Methode: of_dw_error (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_versionbuild
//  string arg_instance
//  string arg_profile
//  long arg_sql_errcode
//  string arg_sql_errtext
//  string arg_datawindowobject
//  string arg_text
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  31.08.2017	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

Long 		lSequence, ll_count
uLong 	lpnSize
datetime dtNow, dtLast
string		ls_text, ls_exe, ls_db, ls_mail

//is_Profile = arg_profile

ls_mail = ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR","MailOnDBERROR","-1")

if ls_mail = "-1" then
	ls_mail = "1"
	SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR","MailOnDBERROR", ls_mail)
end if

f_log2csv(0,2,'[uo_systemerror.of_dw_error] ')
f_log2csv(0,2,'[uo_systemerror.of_dw_error] ########################################################################')
f_log2csv(0,2,"[uo_systemerror.of_dw_error] of_dw_error: ")


is_app_name 	= of_get_executeable_name()
dtNow			= Datetime(Today(),Now())

lpnSize = 255
is_app_server = fill(" ", lpnSize)

if not GetComputerName(is_app_server, lpnSize) then
	is_app_server = "n\a"
end if

if isnull(is_app_server) then is_app_server = "n\a"
	
ls_exe = of_get_executeable_name()
is_servername	 = ProfileString(arg_profile, "Database", "Server","")

ls_text =      "Rechner: " + is_app_server
if not isnull(ls_exe) then ls_text += "~r~nProgramm: " + ls_exe
if not isnull(ls_exe) then ls_text += "~r~nVersion: " + arg_versionbuild +" / uo_systemerror: " + is_systemerror_version
if arg_instance > " " then ls_text += "~r~nInstance: " + arg_instance
if not isnull(ls_exe) then ls_text += "~r~nDatenbank: " + is_servername
ls_text += "~r~nZeit: " + string(dtNow, "dd.mm.yyyy hh:mm:ss")

f_log2csv(0,2,"[uo_systemerror.of_dw_error] Datawindow: " + arg_datawindowobject)
ls_text += "~r~nDatawindow: " + arg_datawindowobject
f_log2csv(0,2,"[uo_systemerror.of_dw_error] ORA-Fehler: "+string(arg_sql_errcode))
ls_text += "~r~nORA-Fehler: "+string(arg_sql_errcode)
f_log2csv(0,2,"[uo_systemerror.of_dw_error] ORA-Text: "+arg_sql_errtext)
ls_text += "~r~nORA-Text: "+arg_sql_errtext
f_log2csv(0,2,"[uo_systemerror.of_dw_error] Fehler: "+ arg_text)
ls_text += "~r~nFehler: "+ arg_text

if ls_mail = "1" then
	dtLast = of_datetime(ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", arg_instance, "ORA-" + string(arg_sql_errcode), "2001-01-01 00:00:00"))
	
	if of_dt_diff(dtLast, dtNow) > 600 then
		ll_count = long(ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", arg_instance, "ORA-" + string(arg_sql_errcode)+"_COUNT", "0"))
		
		if ll_count >0 then
			ls_text += "~r~n~r~n Dieser SQLErrorCode trat in den letzten 10 Minuten " + string( ll_count ) +" mal auf"	
		end if
		of_send_mail(ls_text, "Datawindow-Error ")
		SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", arg_instance, "ORA-" + string(arg_sql_errcode), string(dtNow, "yyyy-mm-dd hh:mm:ss"))
		SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", arg_instance, "ORA-" + string(arg_sql_errcode)+"_COUNT", "1")
	else
		ll_count = long(ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", arg_instance, "ORA-" + string(arg_sql_errcode)+"_COUNT", "0"))
		ll_count++
		SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", arg_instance, "ORA-" + string(arg_sql_errcode)+"_COUNT", string(ll_count))
		
		f_log2csv(0,2,"[uo_systemerror.of_dw_error] of_dw_error: No Mail send. Last Mail was send at "+string(dtLast, "dd.mm.yyyy hh:mm:ss"))
	end if
end if

f_log2csv(0,2,'[uo_systemerror.of_dw_error] ########################################################################')
f_log2csv(0,2,'[uo_systemerror.of_dw_error]  ')

return 1
end function

public function integer of_init_db ();
/* 
* Funktion:			of_init_db
* Beschreibung: 	parameter (mail-db, mail-adressen, mail-namen, schalter) aus aktueller DB auslesen und schreiben
* Besonderheit: 	keine
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 	Wer							Wann			Was und warum
*	1.0 		Heiko Rothenbach			xx.xx.xxxx	Erstellung
*	1.1 		Margret N$$HEX1$$fc00$$ENDHEX$$ndel				08.08.2019	nur schreiben, wenn n$$HEX1$$f600$$ENDHEX$$tig, dazu (um timestamp zu sch$$HEX1$$fc00$$ENDHEX$$tzen und sperren zu vermeiden)
* 																Schalter USE_DEFAULT neu dazu
*
* Return Codes:
*	 0		immer
*
*/


// hilfsvariable
string ls_sendmail_dw, ls_sendmail_se, a

of_check_inifile()

a = ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "DATABASE", "DBMS","")
if a <> sqlca.dbms then
	SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "DATABASE", "DBMS", sqlca.dbms)
end if

a = ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "DATABASE", "DBParm","")
if a <> sqlca.dbparm then
	SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "DATABASE", "DBParm", sqlca.dbparm)
end if

a = ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "DATABASE", "LogId","")
if a <> sqlca.logid then
	SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "DATABASE", "LogId", sqlca.logid)
end if

a = ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "DATABASE", "LogPass","")
if a <> sqlca.logpass then
	SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "DATABASE", "LogPass", sqlca.logpass)
end if

// nur lesen und Schreiben, wenn die hier eingetragenen Defaults auch genommen werden sollen
if ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "USE_DEFAULT","1") = "1" then

	// parameter aus DB auslesen
	is_DBServer 		= of_get_cen_setup("uo_systemerror", "db",							"PCBASEDE")
	is_mail_adresses 	= of_get_cen_setup("uo_systemerror", "mailadress",					"heiko.rothenbach@lhind.dlh.de; klaus.foerster@lhind.dlh.de")
	is_mail_names 		= of_get_cen_setup("uo_systemerror", "mailname",					"Heiko Rothenbach; Klaus F$$HEX1$$f600$$ENDHEX$$rster")
	ls_sendmail_dw	= of_get_cen_setup("uo_systemerror", "MailOnDBERROR",			"-1")
	ls_sendmail_se		= of_get_cen_setup("uo_systemerror", "MailOnSYSTEMERROR",	"-1")

	// parameter aus DB schreiben, ABER NUR WENN N$$HEX1$$d600$$ENDHEX$$TIG !!
	if ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MAIL_DB","") <> is_DBServer then
		SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MAIL_DB", is_DBServer)
	end if
	
	if ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MAIL_ADRESSES","") <> is_mail_adresses then
		SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MAIL_ADRESSES", is_mail_adresses)
	end if
	
	if ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MAIL_NAMES","") <> is_mail_names then
		SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR","MAIL_NAMES", is_mail_names)
	end if

	if ls_sendmail_dw <> "-1" then
		if ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MailOnDBERROR","") <> ls_sendmail_dw then
			SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MailOnDBERROR", ls_sendmail_dw)
		end if
	end if
	
	if ls_sendmail_se <> "-1" then
		if ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MailOnSYSTEMERROR","") <> ls_sendmail_se then
			SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MailOnSYSTEMERROR", ls_sendmail_se )
		end if
	end if
end if

return 0

end function

public function string of_get_cen_setup (string arg_section, string arg_key, string arg_default);
string	ls_Value, ls_Mandant

  SELECT cen_setup.cvalue
     INTO :ls_Value 
    FROM cen_setup,   
               sys_login  
   WHERE cen_setup.cclient = sys_login.cclient 
	    and upper(sys_login.cusername) = 'CBASE' 
	    and cSection = :arg_section		
	    and cKey = :arg_key ;
			
			
If sqlca.SQLCode = 100 Then
	//Wert nicht gefunden, dann default eintragen und zur$$HEX1$$fc00$$ENDHEX$$ckgeben
	ls_Value = arg_default
	
	select cclient
	into :ls_Mandant
	from sys_login
	where  upper(sys_login.cusername) = 'CBASE' ;
	
	INSERT INTO cen_setup  
				 (cclient,   
				  csection,   
				  ckey,   
				  cvalue )
   	VALUES ( :ls_Mandant,   
				 :arg_section,   
				 :arg_key,   
				 :arg_default) ;
 
End if

if isnull(ls_Value) then ls_Value = ""

return ls_Value


end function

public function integer of_send_mail (string arg_text, string arg_subject);

integer ln_ret = 0

IF Handle(GetApplication()) = 0 THEN
	f_Log2Csv(1,1, "[uo_systemerror.of_send_mail] No Mail while the development ");
	return 1
end if
if pos(arg_text, "function of_test_systemerror of object uo_systemerror")>0 then
	this.ssubject 				= left("[TEST] " +is_servername +": "+arg_subject + is_app_name, 90 )
else
	this.ssubject 				= left(is_servername +": "+arg_subject + is_app_name, 90 )
end if
this.smessage 				= arg_text + "~r~n~r~nUO_SYSTEMERROR-Version: "+is_systemerror_version
this.sreceiver				= ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MAIL_ADRESSES", is_mail_adresses)
this.sreceiver_fullname	= ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "SYSTEMERROR", "MAIL_NAMES", is_mail_names)

ln_ret = of_sendmail()

if ln_ret <> 0 then 
	f_Log2Csv(1,1, "[uo_systemerror.of_send_mail] Error sending email: " + is_ErrorMessage);
else
	f_Log2Csv(1,1, "[uo_systemerror.of_send_mail] Sending email: Successful");
end if

return 1
end function

public function datetime of_datetime (string ls_datetime);return datetime(date(left(ls_datetime, 10)), time(right(ls_datetime, 8)))
end function

public function long of_dt_diff (datetime dt1, datetime dt2);
long i,j

if date(dt1)=date(dt2) then
	i=secondsafter(time(dt1),time(dt2))	
elseif date(dt1)>date(dt2) then
	j=daysafter(date(dt2),date(dt1)) * 24 * 60 *60
	
	i=secondsafter(time(dt1),time(dt2))	- j
else
	j=daysafter(date(dt1),date(dt2)) * 24 * 60 *60
	i=secondsafter(time(dt1),time(dt2))	+ j
end if

return i

end function

public function integer of_check_inifile ();integer li_FileNum

if not fileexists(is_apppath+"\UO_SYSTEMERROR.INI") then

	li_FileNum = FileOpen(is_apppath +"\UO_SYSTEMERROR.INI",  LineMode!, Write!, LockWrite!, Replace!)
	if li_FileNum > 0 then
		
		filewrite(li_FileNum, "[DATABASE]")
		filewrite(li_FileNum, "DBMS   = O90 Oracle9i (9.0.1)")
		filewrite(li_FileNum, "DBParm ="+Char(34)+"DelimitIdentifier='No',PBDBMS=1,DisableBind=1,FormatArgsAsExp='No',DecimalSeparator=',',Timestamp=0"+CHAR(34))
		filewrite(li_FileNum, "LogId =CBASE_SERVICE")
		filewrite(li_FileNum, "LogPass =LSGservice01")
		filewrite(li_FileNum, " ")
		filewrite(li_FileNum, "[SYSTEMERROR]")
		filewrite(li_FileNum, "USE_DEFAULT=1")
		filewrite(li_FileNum, "MAIL_DB=PCBASEDE")
		filewrite(li_FileNum, "TEST_SYSTEMERROR=0")
		filewrite(li_FileNum, "MAIL_ADRESSES=heiko.rothenbach@lhind.dlh.de; klaus.foerster@lhind.dlh.de")
		filewrite(li_FileNum, "MAIL_NAMES=Heiko Rothenbach; Klaus F$$HEX1$$f600$$ENDHEX$$rster")
		filewrite(li_FileNum, "MailOnDBERROR=1")
		filewrite(li_FileNum, " ")
		
		fileclose(li_FileNum)
	end if
else
	if ProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "DATABASE", "DBMS","-1") = "-1" then
		SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "DATABASE", "DBMS","O90 Oracle9i (9.0.1)")
		SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "DATABASE", "DBParm", Char(34)+"DelimitIdentifier='No',PBDBMS=1,DisableBind=1,FormatArgsAsExp='No',DecimalSeparator=',',Timestamp=0"+CHAR(34))
		SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "DATABASE", "LogId","CBASE_SERVICE")
		SetProfileString(is_apppath + "\UO_SYSTEMERROR.INI", "DATABASE", "LogPass","LSGservice01")
	
	end if
end if

return 1
end function

public subroutine of_get_app_path ();
string	sFullPath
string	sExe			= ""
integer	iRet
integer	iPos 			= 0

sFullpath 	= Space (1024)
iRet 			= GetModuleFileName (Handle (GetApplication()),sFullPath,1024)

if IRet > 0 then 
	
	do while (Pos (sFullPath, "\",iPos + 1) > 0)
		iPos = Pos (sFullPath, "\",iPos + 1)
	loop
	is_AppPath	= Mid (sFullPath,1,iPos - 1)
	sExe			= Mid (sFullPath,iPos + 1)
end if

end subroutine

on uo_systemerror.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_systemerror.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;Boolean 	lb_Ret
integer 	li_FileNum

// ------------------------------------------
// UserObject hat eigenes TransObjekt
// ------------------------------------------
this.itr_email = Create Transaction

of_get_app_path()

of_check_inifile()
end event

event destructor;

// ------------------------------------------
// DB-anbindung aufr$$HEX1$$e400$$ENDHEX$$umen
// ------------------------------------------
if this.of_is_connected() then
	disconnect using this.itr_email;
	destroy itr_email
end if

return 0
end event

