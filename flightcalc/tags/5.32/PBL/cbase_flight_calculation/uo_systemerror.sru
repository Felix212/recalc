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

Folgendes in den Systemevent  eintragen

uo_systemerror uose
uose.of_systemerror( gs_Version + "-" + gs_Build, sProfile)

halt

*/

PUBLIC:
string 	is_app_name 
string 	is_app_server 
string		is_mail_adresses	= "heiko.rothenbach@lhind.dlh.de; klaus.foerster@lhind.dlh.de; matthias.barfknecht.sp@lhind.dlh.de"
string		is_mail_names		= "Heiko Rothenbach; Klaus F$$HEX1$$f600$$ENDHEX$$rster; Matthias Barfknecht"

string		is_from_mail		= "cbase_no_reply@lsgskychefs.com"
string		is_from_text			= "SYSTEMERROR "
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

PRIVATE:
string is_CRLF = "~r~n"

string is_dbms, is_servername, is_dbparm, is_id, is_pwd
boolean ib_autocommit
end variables
forward prototypes
public function integer of_connect ()
public function boolean of_is_connected ()
public function integer of_init (string assubject, string asreceiver, string asreceiver_fullname, string asmessage)
public function string of_get_executeable_name ()
public function integer of_send_mail (string arg_text)
public function integer of_systemerror (string arg_versionbuild, string arg_profile)
public function integer of_sendmail ()
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

is_ServerName = ProfileString(is_Profile,"Mailserver","Server","")

// Falls der Server explizit angegeben wurde, dann $$HEX1$$fc00$$ENDHEX$$berschreiben
if is_ServerName = "" then 
	is_ServerName = "PCBASEDE"
	SetProfileString(is_Profile,"Mailserver","Server",is_ServerName)
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
	f_log2csv(0,2,"SQLCODE :" + string(itr_email.sqlcode)+ "   SQLDBCODE: "+  string(itr_email.sqldbcode)+"  SQLERRTEXT: "+ this.itr_email.sqlerrtext)

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
	f_log2csv(0,2,"Check for IsConnected failed")
	return false
end if

return true

end function

public function integer of_init (string assubject, string asreceiver, string asreceiver_fullname, string asmessage);
this.ssubject 				= left(assubject, 90)
this.sreceiver 				= asreceiver
this.sreceiver_fullname 	= asreceiver_fullname
this.smessage 				= asmessage

return 0
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

public function integer of_send_mail (string arg_text);integer ln_ret = 0

of_init( "Systemerror "+is_app_name  , is_mail_adresses, is_mail_names, arg_text)

ln_ret = of_sendmail()

if ln_ret <> 0 then 
	f_Log2Csv(1,1, "[of_send_mail] Error sending email: " + is_ErrorMessage);
else
	f_Log2Csv(1,1, "[of_send_mail] Sending email: Successful");
end if

return 1
end function

public function integer of_systemerror (string arg_versionbuild, string arg_profile);Long 		lSequence
uLong 	lpnSize
datetime dtNow
string		ls_text

is_Profile = arg_profile

f_log2csv(0,2,' ')
f_log2csv(0,2,'########################################################################')
f_log2csv(0,2,"Systemerror: ")
f_log2csv(0,2,String(error.number) + " - " + error.text)

is_app_name 	= of_get_executeable_name()
dtNow			= Datetime(Today(),Now())

lpnSize = 255
is_app_server = fill(" ", lpnSize)

if not GetComputerName(is_app_server, lpnSize) then
	is_app_server = "n\a"
end if

ls_text =      "Rechner: " + is_app_server
ls_text += "~r~nProgramm: " + of_get_executeable_name()
ls_text += "~r~nVersion: " + arg_versionbuild
ls_text += "~r~nDatenbank: " +  ProfileString(is_Profile,"Database","Server","")
ls_text += "~r~nZeit: " + string(dtNow, "dd.mm.yyyy hh:mm:ss")
ls_text += "~r~nError Number: " + string(error.number)
ls_text += "~r~nWindowmenu: " + error.windowmenu
ls_text += "~r~nObject: " + error.object
ls_text += "~r~nObjectevent: " + error.objectevent
ls_text += "~r~nLine: " + string(error.line)
ls_text += "~r~nFehlertext:~r~n" + error.text

of_send_mail(ls_text)

f_log2csv(0,2,'########################################################################')
f_log2csv(0,2,' ')

return 1
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

