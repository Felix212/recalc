HA$PBExportHeader$uo_arg_filter.sru
forward
global type uo_arg_filter from nonvisualobject
end type
end forward

global type uo_arg_filter from nonvisualobject
end type
global uo_arg_filter uo_arg_filter

type variables
PUBLIC:

DataWindow oDW

String  filteredcolumn 
long	  lx
long	  ly
boolean bfilter
 
 
end variables

on uo_arg_filter.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_arg_filter.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

