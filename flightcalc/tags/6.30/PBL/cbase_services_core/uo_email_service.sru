HA$PBExportHeader$uo_email_service.sru
forward
global type uo_email_service from nonvisualobject
end type
end forward

global type uo_email_service from nonvisualobject autoinstantiate
end type

type variables
/*
	We need in this UO:
	- dw_email_servers
	- f_profile_string
	- f_profile_string2
	- f_sequence
	- f_file_to_blob
	
	and following Global variables:
	uo_log 				guoLog
	string					gs_servicename = "cbase_central"


To use this UO:


			uo_email_service luo_email

			luo_email.of_init( "INSTALL_LOCALParms.INI" )
			
			luo_email.of_sendmail( f_profile_string("INSTALL_LOCALParms.INI", "Mailing", "EMAIL_RECEIVERNAMELIST", "Heiko Rothenbach"),  &
											f_profile_string("INSTALL_LOCALParms.INI", "Mailing", "EMAIL_RECEIVERMAILLIST", "heiko.rothenbach@lhind.dlh.de"), &
											"CheckRunningServices",  &
											"Check Running Services", &
											ls_mail)
		


*/

PRIVATE:
transaction		itr_email
long				il_nems_nkey 			= 0
string				is_from_mail			= ""
string				is_profile					= ""


end variables

forward prototypes
public function integer of_split (string arg_sstring, string arg_sseparator, ref string arg_soutputarray[])
public function integer of_init (string arg_profile)
public function integer of_connect ()
public function integer of_disconnect ()
public function integer of_sendmail (string arg_to_name[], string arg_to_mail[], string arg_from_name, string arg_from_mail, string arg_subject, string arg_body)
public function string of_name_from_mail (string arg_mail)
public function integer of_sendmail (string arg_to_name[], string arg_to_mail[], string arg_from_name, string arg_from_mail, string arg_subject, string arg_body, string arg_attachments[])
public function integer of_sendmail (string arg_to_names, string arg_to_mails, string arg_from_name, string arg_subject, string arg_body)
public function integer of_sendmail (string arg_to_names, string arg_to_mails, string arg_from_name, string arg_from_mail, string arg_subject, string arg_body)
public function integer of_sendmail (string arg_to_name[], string arg_to_mail[], string arg_from_name, string arg_subject, string arg_body)
public function integer of_sendmail (string arg_to_name[], string arg_to_mail[], string arg_from_name, string arg_subject, string arg_body, string arg_attachments[])
public function integer of_sendmail (string arg_to_names, string arg_to_mails, string arg_from_name, string arg_subject, string arg_body, string arg_attachments[])
public function integer of_sendmail (string arg_to_names, string arg_to_mails, string arg_from_name, string arg_from_mail, string arg_subject, string arg_body, string arg_attachments[])
private function integer of_sendmail_intern (string arg_to_names, string arg_to_mails, string arg_from_name, string arg_from_mail, string arg_subject, string arg_body, string arg_attachments[])
public function string of_filename_from_fullpath (string arg_fullpath)
end prototypes

public function integer of_split (string arg_sstring, string arg_sseparator, ref string arg_soutputarray[]);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_split (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_sstring
//  string arg_sseparator
//  ref string arg_soutputarray[]
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
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

long lPosEnd, lPosStart = 1, lSeparatorLen, lCounter = 1

IF UpperBound(arg_sOutputArray) > 0 THEN arg_sOutputArray = {""}
lSeparatorLen = len(arg_sSeparator)

lPosEnd = Pos (arg_sString, arg_sSeparator, 1)

DO WHILE lPosEnd > 0
     arg_sOutputArray[lCounter] = trim(Mid (arg_sString, lPosStart, lPosEnd - lPosStart))
     lPosStart = lPosEnd + lSeparatorLen
     lPosEnd = Pos (arg_sString, arg_sSeparator, lPosStart)
     lCounter++
LOOP

arg_sOutputArray[lCounter] = trim(Right (arg_sString, Len(arg_sString) - lPosStart + 1))
RETURN lCounter
end function

public function integer of_init (string arg_profile);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_init (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_profile
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
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
string a

this.is_profile = arg_profile

a = f_profile_string( this.is_profile, "DATABASE", "Server", 		"NONE")
a = f_profile_string( this.is_profile, "DATABASE", "DBMS", 		"O10 Oracle10g (10.1.0)")
a = f_profile_string( this.is_profile, "DATABASE", "DBParm", 	"DelimitIdentifier='No',PBDBMS=1,FormatArgsAsExp='No',DisableBind=1,DecimalSeparator=',', timestamp=0")
a = f_profile_string( this.is_profile, "DATABASE", "LogId", 		"CBASE_SERVICE")
a = f_profile_string( this.is_profile, "DATABASE", "LogPass", 	"LSGservice01")

a = f_profile_string2( this.is_profile, "Mailing", "Server", f_profile_string( this.is_profile, "DATABASE", "Server", 		"NONE"), "Es k$$HEX1$$f600$$ENDHEX$$nnen mehrere Server eingetragen werden. z.B. TCBASEUS, PCBASEUS" )

return 0
end function

public function integer of_connect ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_connect (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
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
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

string 		a, ls_dbs[]
integer 		i
datastore 	lds_mail_servers
boolean 		lb_is_init					= false

this.itr_email 					= create transaction
this.itr_email.DBMS 			= f_profile_string( this.is_profile, "DATABASE", "DBMS", 		"O10 Oracle10g (10.1.0)")
this.itr_email.DBParm 		= f_profile_string( this.is_profile, "DATABASE", "DBParm", 	"DelimitIdentifier='No',PBDBMS=1,FormatArgsAsExp='No',DisableBind=1,DecimalSeparator=',', timestamp=0")
this.itr_email.LogId 			= f_profile_string( this.is_profile, "DATABASE", "LogId", 		"CBASE_SERVICE")
this.itr_email.LogPass 		= f_profile_string( this.is_profile, "DATABASE", "LogPass", 	"LSGservice01")
this.itr_email.AutoCommit 	= false

a = f_profile_string2( this.is_profile, "Mailing", "Server", f_profile_string( this.is_profile, "DATABASE", "Server", 		"NONE"), "Es k$$HEX1$$f600$$ENDHEX$$nnen mehrere Server eingetragen werden. z.B. TCBASEUS, PCBASEUS" )

this.of_split( a, ",", ls_dbs)

for i=1 to upperbound(ls_dbs)
	if ls_dbs[i] = "NONE" then
		guoLog.uf_error("["+ this.classname( )+".of_connect] Mail-Server not set" )
		continue
	end if
	
	// ----------------------------------
	// Verbindung zu CBASE herstellen
	// ----------------------------------
	this.itr_email.ServerName 	=  ls_dbs[i] 

	connect using this.itr_email;
	
	if this.itr_email.SQLCode = 0 then
		guoLog.uf_debug("["+ this.classname( )+".of_connect] Connected to " + ls_dbs[i] )
		lb_is_init = true
		exit
	else
		guoLog.uf_error("["+ this.classname( )+".of_connect] Error connect to " + this.itr_email.ServerName +": (" + string(this.itr_email.sqlcode)+") "+  this.itr_email.sqlerrtext )
	end if
next

if lb_is_init then
	lds_mail_servers 					= create datastore
	lds_mail_servers.dataobject 	= "dw_email_servers"

	lds_mail_servers.settransobject( this.itr_email )
	lds_mail_servers.retrieve()
	
	if lds_mail_servers.rowcount()>0 then
		il_nems_nkey 	= lds_mail_servers.getitemnumber(1, "nems_nkey")
		is_from_mail 	= lds_mail_servers.getitemstring(1, "nem_cfromemail")
		
		guoLog.uf_debug("["+ this.classname( )+".of_connect] il_nems_nkey=" + string(il_nems_nkey) )
		guoLog.uf_debug("["+ this.classname( )+".of_connect] is_from_mail="+is_from_mail)
		
		destroy lds_mail_servers
		return 0
	else
		guoLog.uf_error("["+ this.classname( )+".of_connect]  lds_mail_servers.rowcount() = 0 ")
		destroy lds_mail_servers
		
		il_nems_nkey 	= 0
		return -1
	end if
else
	guoLog.uf_error("["+ this.classname( )+".of_connect] No Connection possible")
	return -1
end if

end function

public function integer of_disconnect ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_disconnect (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
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
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
disconnect using itr_email;
destroy this.itr_email

return 1
end function

public function integer of_sendmail (string arg_to_name[], string arg_to_mail[], string arg_from_name, string arg_from_mail, string arg_subject, string arg_body);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_sendmail (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_to_name[]
//  string arg_to_mail[]
//  string arg_from_name
//  string arg_from_mail
//  string arg_subject
//  string arg_body
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
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

string 	ls_attach[] 
string 	ls_to_name,  ls_to_mail				
integer 	i

guoLog.uf_debug("["+ this.classname( )+".of_sendmail] 1")

ls_to_name 	= ""
ls_to_mail 	= ""

for i=1 to  upperbound(arg_to_mail)
	if ls_to_name > " " then
		ls_to_name += "; "
		ls_to_mail += "; "
	end if
	ls_to_mail += arg_to_mail[i]
	
	if i > upperbound(arg_to_name) then
		ls_to_name += of_name_from_mail( arg_to_mail[i] )
	else
		ls_to_name += arg_to_name[i]
	end if
	
next
	
return of_sendmail_intern(ls_to_name, ls_to_mail, arg_from_name, arg_from_mail, arg_subject, arg_body, ls_attach)

end function

public function string of_name_from_mail (string arg_mail);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_name_from_mail (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_mail
// --------------------------------------------------------------------------------------------------------------------
// Return: string
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
integer i

i = pos(arg_mail, "@")

return left(arg_mail, i -1)
end function

public function integer of_sendmail (string arg_to_name[], string arg_to_mail[], string arg_from_name, string arg_from_mail, string arg_subject, string arg_body, string arg_attachments[]);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_sendmail (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_to_name[]
//  string arg_to_mail[]
//  string arg_from_name
//  string arg_from_mail
//  string arg_subject
//  string arg_body
//  string arg_attachments[]
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
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

string 	ls_to_name,  ls_to_mail				
integer 	i

guoLog.uf_debug("["+ this.classname( )+".of_sendmail] 2")

ls_to_name 	= ""
ls_to_mail 	= ""

for i=1 to  upperbound(arg_to_mail)
	if ls_to_name > " " then
		ls_to_name += "; "
		ls_to_mail += "; "
	end if
	ls_to_mail += arg_to_mail[i]
	
	if i > upperbound(arg_to_name) then
		ls_to_name += of_name_from_mail( arg_to_mail[i] )
	else
		ls_to_name += arg_to_name[i]
	end if
	
next
	
return of_sendmail_intern(ls_to_name, ls_to_mail, arg_from_name, arg_from_mail, arg_subject, arg_body, arg_attachments)

end function

public function integer of_sendmail (string arg_to_names, string arg_to_mails, string arg_from_name, string arg_subject, string arg_body);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_sendmail (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_to_names
//  string arg_to_mails
//  string arg_from_name
//  string arg_subject
//  string arg_body
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
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

string ls_attach[]				

guoLog.uf_debug("["+ this.classname( )+".of_sendmail] 7")
	
return of_sendmail_intern(arg_to_names, arg_to_mails, arg_from_name, is_from_mail, arg_subject, arg_body, ls_attach)

end function

public function integer of_sendmail (string arg_to_names, string arg_to_mails, string arg_from_name, string arg_from_mail, string arg_subject, string arg_body);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_sendmail (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_to_names
//  string arg_to_mails
//  string arg_from_name
//  string arg_from_mail
//  string arg_subject
//  string arg_body
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
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

string ls_attach[]				

guoLog.uf_debug("["+ this.classname( )+".of_sendmail] 5")

	
return of_sendmail_intern(arg_to_names, arg_to_mails, arg_from_name, arg_from_mail, arg_subject, arg_body, ls_attach)

end function

public function integer of_sendmail (string arg_to_name[], string arg_to_mail[], string arg_from_name, string arg_subject, string arg_body);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_sendmail (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_to_name[]
//  string arg_to_mail[]
//  string arg_from_name
//  string arg_subject
//  string arg_body
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
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

guoLog.uf_debug("["+ this.classname( )+".of_sendmail] 3")

string 	ls_attach[] 
string 	ls_to_name,  ls_to_mail				
integer 	i

ls_to_name 	= ""
ls_to_mail 	= ""

for i=1 to  upperbound(arg_to_mail)
	if ls_to_name > " " then
		ls_to_name += "; "
		ls_to_mail += "; "
	end if
	ls_to_mail += arg_to_mail[i]
	
	if i > upperbound(arg_to_name) then
		ls_to_name += of_name_from_mail( arg_to_mail[i] )
	else
		ls_to_name += arg_to_name[i]
	end if
	
next
	
return of_sendmail_intern(ls_to_name, ls_to_mail, arg_from_name, is_from_mail, arg_subject, arg_body, ls_attach)

end function

public function integer of_sendmail (string arg_to_name[], string arg_to_mail[], string arg_from_name, string arg_subject, string arg_body, string arg_attachments[]);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_sendmail (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_to_name[]
//  string arg_to_mail[]
//  string arg_from_name
//  string arg_subject
//  string arg_body
//  string arg_attachments[]
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
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
guoLog.uf_debug("["+ this.classname( )+".of_sendmail] 4")

string 	ls_to_name,  ls_to_mail				
integer 	i

ls_to_name 	= ""
ls_to_mail 	= ""

for i=1 to  upperbound(arg_to_mail)
	if ls_to_name > " " then
		ls_to_name += "; "
		ls_to_mail += "; "
	end if
	ls_to_mail += arg_to_mail[i]
	
	if i > upperbound(arg_to_name) then
		ls_to_name += of_name_from_mail( arg_to_mail[i] )
	else
		ls_to_name += arg_to_name[i]
	end if
	
next
	
return of_sendmail_intern(ls_to_name, ls_to_mail, arg_from_name, is_from_mail, arg_subject, arg_body, arg_attachments)

end function

public function integer of_sendmail (string arg_to_names, string arg_to_mails, string arg_from_name, string arg_subject, string arg_body, string arg_attachments[]);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_sendmail (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_to_names
//  string arg_to_mails
//  string arg_from_name
//  string arg_subject
//  string arg_body
//  string arg_attachments[]
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
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

guoLog.uf_debug("["+ this.classname( )+".of_sendmail] 8")

return of_sendmail_intern(arg_to_names, arg_to_mails, arg_from_name, is_from_mail, arg_subject, arg_body, arg_attachments)
end function

public function integer of_sendmail (string arg_to_names, string arg_to_mails, string arg_from_name, string arg_from_mail, string arg_subject, string arg_body, string arg_attachments[]);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_sendmail (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_to_names
//  string arg_to_mails
//  string arg_from_name
//  string arg_from_mail
//  string arg_subject
//  string arg_body
//  string arg_attachments[]
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
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

guoLog.uf_debug("["+ this.classname( )+".of_sendmail] 6")

return of_sendmail_intern(arg_to_names, arg_to_mails, arg_from_name, arg_from_mail, arg_subject, arg_body, arg_attachments)

end function

private function integer of_sendmail_intern (string arg_to_names, string arg_to_mails, string arg_from_name, string arg_from_mail, string arg_subject, string arg_body, string arg_attachments[]);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_sendmail (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_to_names
//  string arg_to_mails
//  string arg_from_name
//  string arg_from_mail
//  string arg_subject
//  string arg_body
//  string arg_attachments[]
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
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

Datetime 	ldt_Now
Long			ll_Sequence,ll_return, ll_Seq_attachment
blob 			lblb_Blob
integer 		li_attach
string			ls_file, ls_host

if of_connect() <> 0 then
	return -1
end if

if trim(arg_to_names) = "" then
	guoLog.uf_error("["+ this.classname( )+".of_sendmail_intern] no To-Names are set")
	return -1
end if

if trim(arg_to_mails) = "" then
	guoLog.uf_error("["+ this.classname( )+".of_sendmail_intern] no To-Mailadresses are set")
	return -1
end if

if trim(arg_from_name) = "" then
	guoLog.uf_error("["+ this.classname( )+".of_sendmail_intern] no From-Name is set")
	return -1
end if

if trim(arg_from_mail) = "" then
	arg_from_mail = is_from_mail
	guoLog.uf_info("["+ this.classname( )+".of_sendmail_intern] From-Mail is set to " + is_from_mail)
end if

if len(arg_subject) > 100 then
	arg_subject = left(arg_subject, 99)	
	guoLog.uf_info("["+ this.classname( )+".of_sendmail_intern] Subject is shorten to 100 Chars")
end if

if trim(arg_body)="" or isnull(arg_body) then
	arg_body = "< Mailbody is empty >"
	guoLog.uf_error("["+ this.classname( )+".of_sendmail_intern] Mailbody is empty")
end if

ll_return = 0

select sysdate into :ldt_Now from dual using itr_email;
if itr_email.sqlcode <> 0 then
	ldt_Now = Datetime(today(), Now())	
end if

// neuen key holen...
ll_Sequence = f_sequence("seq_cen_email", itr_email)
if ll_Sequence = -1 then
	guoLog.uf_error("["+ this.classname( )+".of_sendmail_intern] ERROR Getting seq_cen_email.nextval")
	of_disconnect()
	return -3
end if

RegistryGet("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName", "ComputerName",RegString!,ls_Host)

if isvalid(SQLCA) then
	if SQLCA.ServerName > " " then
		lblb_Blob = blob(gs_servicename + " on Server "+ls_Host +" and Database " + SQLCA.ServerName+char(10)+char(13)+ arg_body)	
	else
		lblb_Blob = blob(gs_servicename + " on Server "+ls_Host +" and Database " +  f_profile_string( this.is_profile, "DATABASE", "Server", 		"NONE") +char(10)+char(13)+ arg_body)	
	end if
else
	lblb_Blob = blob(gs_servicename + " on Server "+ls_Host +" and Database " + f_profile_string( this.is_profile, "DATABASE", "Server", 		"NONE") +char(10)+char(13)+ arg_body)	
end if	



INSERT INTO cen_email  
		(	nem_nkey,   
			nem_nems_nkey,   
			nem_csendname,
			nem_csendemail,
			nem_cfromname,
			nem_cfromemail,
			nem_csubject,
			nem_dcreate)
	VALUES (:ll_Sequence,
				:il_nems_nkey ,
				:arg_to_names,
				:arg_to_mails,
				:arg_from_name,
				:arg_from_mail,
				:arg_subject,
				:ldt_Now) USING itr_email;
				
if itr_email.sqlcode = 0 then
	updateblob cen_email set nem_cbody = :lblb_Blob where nem_nkey = :ll_Sequence USING itr_email;

	if itr_email.sqlcode <> 0 then
		guoLog.uf_error("["+ this.classname( )+".of_sendmail_intern] ERROR updateblob cen_email set nem_cbody: (" + string(this.itr_email.sqlcode)+") "+  this.itr_email.sqlerrtext )
		ll_return = -8
	else
		// attachments eintragen
		if upperbound(arg_attachments) > 0 then
			for li_attach = 1 to upperbound(arg_attachments)
				if f_file_to_blob( arg_attachments[li_attach], lblb_Blob, true)> 0 then
					ls_file = of_filename_from_fullpath( arg_attachments[li_attach] ) 
					// neuen key holen...
					ll_Seq_attachment = f_sequence("seq_cen_email_attachments", itr_email)
					if ll_Seq_attachment = -1 then
						guoLog.uf_error("["+ this.classname( )+".of_sendmail_intern] ERROR Getting seq_cen_email_attachments.nextval")
						ll_return = -5
						exit // raus!
					end if

					INSERT INTO cen_email_attachments  
							(	nattachment_key,   
								nemail_key,   
								cfilename,
								ninline)
					VALUES ( :ll_Seq_attachment,
								:ll_Sequence,
								:ls_file,
								1) USING itr_email;

					if itr_email.sqlcode = 0 then
						UPDATEBLOB cen_email_attachments SET battachment_data = :lblb_Blob
								WHERE nattachment_key = :ll_Seq_attachment USING itr_email;
						if itr_email.sqlcode <> 0 then
							guoLog.uf_error("["+ this.classname( )+".of_sendmail_intern] ERROR UPDATEBLOB cen_email_attachments: (" + string(this.itr_email.sqlcode)+") "+  this.itr_email.sqlerrtext )
							ll_return = -7
							exit // raus!
						end if
					else
						guoLog.uf_error("["+ this.classname( )+".of_sendmail_intern] ERROR inserting new attachment row: (" + string(this.itr_email.sqlcode)+") "+  this.itr_email.sqlerrtext )
						ll_return = -6			
						exit // raus!
					end if
				end if
			next	
		end if // if ii_count_attachments > 0 then
	end if // updateblob cen_email set nem_cbody
else
	guoLog.uf_error("["+ this.classname( )+".of_sendmail_intern] ERROR inserting new email row: (" + string(this.itr_email.sqlcode)+") "+  this.itr_email.sqlerrtext )
	ll_return = -4
end if // if itr_email.sqlcode = 0 then

if ll_return = 0 then
	commit using itr_email;
else
	rollback using itr_email;
end if
				
of_disconnect()
	
return ll_return

end function

public function string of_filename_from_fullpath (string arg_fullpath);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_email_service
// Methode: of_filename_from_fullpath (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string arg_fullpath
// --------------------------------------------------------------------------------------------------------------------
// Return: string
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  13.02.2023	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
integer i

i = lastpos(arg_fullpath, "\")

return mid(arg_fullpath, i +1)
end function

on uo_email_service.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_email_service.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;
if isValid(this.itr_email) then 
	destroy(this.itr_email)
end if

end event

