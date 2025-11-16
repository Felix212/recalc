HA$PBExportHeader$uo_treeview_data.sru
forward
global type uo_treeview_data from nonvisualobject
end type
end forward

global type uo_treeview_data from nonvisualobject
end type
global uo_treeview_data uo_treeview_data

type variables
Public:

long		level
string	label
string	message_text
string	Search
string	data_1
string	data_2
string	data_3
string	data_4
long		data_5
long		handle
long		row
long		owner_id
string	owner_text
long		PictureIndex
long		SelectedPictureIndex
long		ExpandedPictureIndex
long		ExpandedSelectedPictureIndex
long		CollapsedPictureIndex
long		CollapsedSelectedPictureIndex
boolean	bChanges 
long		luo_pos
end variables

on uo_treeview_data.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_treeview_data.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

