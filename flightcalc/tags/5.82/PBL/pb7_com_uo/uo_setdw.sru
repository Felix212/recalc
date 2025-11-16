HA$PBExportHeader$uo_setdw.sru
forward
global type uo_setdw from nonvisualobject
end type
end forward

global type uo_setdw from nonvisualobject
end type
global uo_setdw uo_setdw

type variables
Public:

Boolean bfilter
Boolean bfind
Boolean bsort
Boolean breadonly
Boolean bmail
Boolean bexcel
Boolean bdeletequery
long	  lX
long	  lY
Boolean bhardcopy

 
end variables

on uo_setdw.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_setdw.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

