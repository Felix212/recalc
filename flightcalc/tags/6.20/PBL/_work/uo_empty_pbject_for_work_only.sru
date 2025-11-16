HA$PBExportHeader$uo_empty_pbject_for_work_only.sru
forward
global type uo_empty_pbject_for_work_only from nonvisualobject
end type
end forward

global type uo_empty_pbject_for_work_only from nonvisualobject
end type
global uo_empty_pbject_for_work_only uo_empty_pbject_for_work_only

type variables
//
end variables
on uo_empty_pbject_for_work_only.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_empty_pbject_for_work_only.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

