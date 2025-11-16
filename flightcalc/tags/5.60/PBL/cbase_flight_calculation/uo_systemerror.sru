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
	
	if ProfileString(sProfile, "SYSTEMERROR","TEST_SYSTEMERROR","") = "" then
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
// ### Bei $$HEX1$$c400$$ENDHEX$$nderungen an diesem Object, immer auch folgende Umgebungsvaribale anpassen
string is_systemerror_version = "1.5 vom 27.09.2017"
string is_CRLF = "~r~n"

string is_dbms, is_servername, is_dbparm, is_id, is_pwd
boolean ib_autocommit

PUBLIC:
string 	is_app_name 
string 	is_app_server 
string		is_mail_adresses	= "heiko.rothenbach@lhind.dlh.de; klaus.foerster@lhind.dlh.de"
string		is_mail_names		= "Heiko Rothenbach; Klaus F$$HEX1$$f600$$ENDHEX$$rster"

string		is_from_mail			= "cbase_no_reply@lsgskychefs.com"
string		is_from_text		= "SYSTEMERROR "
string	 	is_DBServer			= "PCBASEDE"


// Fehlertext und Fehler-Datastore
String		is_ErrorMessage = ""

// Ini-Datei mit Profile
string is_Profile = ""
string is_profile_section  = "DATABASE" 

string				smessage, sreceiver, sreceiver_fullname, ssubject
string				is_service = ""

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
public function integer of_send_mail (string arg_text, string arg_suffix)
public function integer of_init_db ()
public function string of_get_cen_setup (string arg_section, string arg_key, string arg_default)
end prototypes

public function integer of_connect ();// ----------------------------------
// wenn angemeldet, dann erstmal aufr$$HEX1$$e400$$ENDHEX$$umen
// ----------------------------------
if isValid(this.itr_email) then
	disconnect using this.itr_email;
	destroy(this.itr_email)
	this.itr_email = create transaction
end if

is_DBMS 				= ProfileString(is_Profile,is_profile_section,"DBMS","ODBC")
is_DBParm 			= ProfileString(is_Profile,is_profile_section,"DBPARM","")
is_ID					= ProfileString(is_Profile,is_profile_section,"LogID","")
is_PWD				= ProfileString(is_Profile,is_profile_section,"LogPass","")

is_ServerName = ProfileString(is_Profile, "SYSTEMERROR","MAIL_DB","")

// Falls der Server explizit angegeben wurde, dann $$HEX1$$fc00$$ENDHEX$$berschreiben
if is_ServerName = "" then 
	is_ServerName = "PCBASEDE"
	SetProfileString(is_Profile,"SYSTEMERROR","MAIL_DB",is_ServerName)
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

public function integer of_sendmail ();long 			llsequence
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

if ProfileString(is_Profile, "SYSTEMERROR","TEST_SYSTEMERROR","0") = "1" then

	SetProfileString(is_Profile, "SYSTEMERROR","TEST_SYSTEMERROR","0")
	j = 0
	i = 1 / j
	
end if
end subroutine

public function integer of_init ();
SetProfileString(is_Profile, "SYSTEMERROR","TEST_SYSTEMERROR","0")
SetProfileString(is_Profile, "SYSTEMERROR","MAIL_ADRESSES",is_mail_adresses)
SetProfileString(is_Profile, "SYSTEMERROR","MAIL_NAMES", is_mail_names)
SetProfileString(is_Profile, "SYSTEMERROR","MAIL_DB", is_DBServer)

return 0
end function

public function integer of_systemerror (string arg_versionbuild, string arg_instance, string arg_profile);Long 		lSequence
uLong 	lpnSize
datetime dtNow
string		ls_text, ls_exe, ls_db

is_Profile = arg_profile

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
ls_db	 = ProfileString(is_Profile,"Database","Server","")

ls_text =      "Rechner: " + is_app_server
if not isnull(ls_exe) then ls_text += "~r~nProgramm: " + ls_exe
if not isnull(ls_exe) then ls_text += "~r~nVersion: " + arg_versionbuild +" / uo_systemerror: " + is_systemerror_version
if arg_instance > " " then ls_text += "~r~nInstance: " + arg_instance
if not isnull(ls_exe) then ls_text += "~r~nDatenbank: " + ls_db
ls_text += "~r~nZeit: " + string(dtNow, "dd.mm.yyyy hh:mm:ss")
if not isnull(error.number) then ls_text += "~r~nError Number: " + string(error.number)
if not isnull(error.windowmenu) then ls_text += "~r~nWindowmenu: " + error.windowmenu
if not isnull(error.object) then ls_text += "~r~nObject: " + error.object
if not isnull(error.objectevent) then ls_text += "~r~nObjectevent: " + error.objectevent
if not isnull(error.line) then ls_text += "~r~nLine: " + string(error.line)
if not isnull(error.text) then ls_text += "~r~nFehlertext:~r~n" + error.text

if  ProfileString(is_Profile, "SYSTEMERROR","MailOnSYSTEMERROR","1") = "1" then
	of_send_mail(ls_text, "")
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

Long 		lSequence
uLong 	lpnSize
datetime dtNow
string		ls_text, ls_exe, ls_db, ls_mail

is_Profile = arg_profile

ls_mail = ProfileString(is_Profile, "SYSTEMERROR","MailOnDBERROR","-1")

if ls_mail = "-1" then
	ls_mail = "1"
	SetProfileString(is_Profile, "SYSTEMERROR","MailOnDBERROR", ls_mail)
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
ls_db	 = ProfileString(is_Profile,"Database","Server","")

ls_text =      "Rechner: " + is_app_server
if not isnull(ls_exe) then ls_text += "~r~nProgramm: " + ls_exe
if not isnull(ls_exe) then ls_text += "~r~nVersion: " + arg_versionbuild +" / uo_systemerror: " + is_systemerror_version
if arg_instance > " " then ls_text += "~r~nInstance: " + arg_instance
if not isnull(ls_exe) then ls_text += "~r~nDatenbank: " + ls_db
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
	of_send_mail(ls_text, "(DW) ")
end if

f_log2csv(0,2,'[uo_systemerror.of_dw_error] ########################################################################')
f_log2csv(0,2,'[uo_systemerror.of_dw_error]  ')

return 1
end function

public function integer of_send_mail (string arg_text, string arg_suffix);integer ln_ret = 0

IF Handle(GetApplication()) = 0 THEN
	f_Log2Csv(1,1, "[uo_systemerror.of_send_mail] No Mail while the development ");
	return 1
end if

this.ssubject 				= left("Systemerror "+arg_suffix + is_app_name, 90)
this.smessage 				= arg_text
this.sreceiver				= ProfileString(is_Profile, "SYSTEMERROR", "MAIL_ADRESSES", is_mail_adresses)
this.sreceiver_fullname	= ProfileString(is_Profile, "SYSTEMERROR", "MAIL_NAMES", is_mail_names)

ln_ret = of_sendmail()

if ln_ret <> 0 then 
	f_Log2Csv(1,1, "[uo_systemerror.of_send_mail] Error sending email: " + is_ErrorMessage);
else
	f_Log2Csv(1,1, "[uo_systemerror.of_send_mail] Sending email: Successful");
end if

return 1
end function

public function integer of_init_db ();string ls_sendmail_dw, ls_sendmail_se

is_DBServer 		= of_get_cen_setup("uo_systemerror", "db",							"PCBASEDE")
is_mail_adresses 	= of_get_cen_setup("uo_systemerror", "mailadress",				"heiko.rothenbach@lhind.dlh.de; klaus.foerster@lhind.dlh.de")
is_mail_names 		= of_get_cen_setup("uo_systemerror", "mailname",					"Heiko Rothenbach; Klaus F$$HEX1$$f600$$ENDHEX$$rster")
ls_sendmail_dw		= of_get_cen_setup("uo_systemerror", "MailOnDBERROR",		"-1")
ls_sendmail_se		= of_get_cen_setup("uo_systemerror", "MailOnSYSTEMERROR",	"-1")

SetProfileString(is_Profile, "SYSTEMERROR", "MAIL_DB", is_DBServer)
SetProfileString(is_Profile, "SYSTEMERROR", "MAIL_ADRESSES", is_mail_adresses)
SetProfileString(is_Profile, "SYSTEMERROR","MAIL_NAMES", is_mail_names)

if ls_sendmail_dw <> "-1" then SetProfileString(is_Profile, "SYSTEMERROR","MailOnDBERROR", ls_sendmail_dw)

if ls_sendmail_se <> "-1" then SetProfileString(is_Profile, "SYSTEMERROR","MailOnSYSTEMERROR", ls_sendmail_se )

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

on uo_systemerror.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_systemerror.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// ------------------------------------------
// UserObject hat eigenes TransObjekt
// ------------------------------------------
this.itr_email = Create Transaction
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

