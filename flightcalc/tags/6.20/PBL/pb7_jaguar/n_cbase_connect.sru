HA$PBExportHeader$n_cbase_connect.sru
$PBExportComments$Generated Jaguar Connection Object
forward
global type n_cbase_connect from connection
end type
end forward

global type n_cbase_connect from connection
end type
global n_cbase_connect n_cbase_connect

type variables
String isServer
end variables

forward prototypes
public function integer of_getconnectioninfo (ref string as_server, ref string as_port, ref string as_logid, ref string as_password, ref string as_appl)
end prototypes

public function integer of_getconnectioninfo (ref string as_server, ref string as_port, ref string as_logid, ref string as_password, ref string as_appl);//*-----------------------------------------------------------------*/
//*    of_GetConnectionInfo:  Get the stored connection information
//*
//*    Note:
//*		The source of connection information can be changed by
//*		 altering the value of the 'is_connectfrom' variable.
//*-----------------------------------------------------------------*/
		
as_logid			= ProfileString ( s_App.sProfile, "Jaguar", "UserID",			"jagadmin")
as_password		= ProfileString ( s_App.sProfile, "Jaguar", "PassWord",		"")
as_server		= ProfileString ( s_App.sProfile, "Jaguar", "Server",			"lww.cbase.zb.lsg.fra.dlh.de") 
as_port			= ProfileString ( s_App.sProfile, "Jaguar", "Port",			"9000")
as_appl			= ProfileString ( s_App.sProfile, "Jaguar", "Application",	"cbase")

Return 1
end function

event constructor;//*--------------------------------------------------------*/
//*  Connection Information is obtained from either:
//*			- An INI File
//*			- The Windows Registry
//*			- Script
//*
//*  The source of connection information can be changed by
//*  altering the value of the 'is_connectfrom' variable.
//*--------------------------------------------------------*/
string ls_server, ls_port, ls_logid, ls_password, ls_appl

//If of_GetConnectionInfo ( ls_server, ls_port, ls_logid, ls_password, ls_appl ) = 1 Then
	
//	this.Application  = ls_appl
//  	this.Driver			= "jaguar"
//	this.UserID 		= ls_logid
//	this.Password 		= ls_password
//	this.Location 		= "iiop://" + ls_server + ":" + ls_port
//	this.isServer 		= ls_server
	
	
//	ls_server = "lww.cbase.zb.lsg.fra.dlh.de"
//	ls_server = "192.168.158.41"
	ls_server = "190.102.9.46"
	ls_port   = "9000"
	
	this.Application  = "cbase"
  	this.Driver			= "jaguar"
	this.UserID 		= "jaguar"
	this.Password 		= ""
	this.Location 		= "iiop://" + ls_server + ":" + ls_port
	this.isServer 		= ls_server
	
	
	
//End If
end event

on n_cbase_connect.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cbase_connect.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

