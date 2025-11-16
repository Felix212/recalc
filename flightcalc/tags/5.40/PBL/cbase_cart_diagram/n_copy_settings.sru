HA$PBExportHeader$n_copy_settings.sru
$PBExportComments$Settings for document generation (per Unit & Airline)
forward
global type n_copy_settings from nonvisualobject
end type
end forward

global type n_copy_settings from nonvisualobject autoinstantiate
end type

type variables


Boolean	ib_Copy_Activated = FALSE
Boolean	ib_Move_After_Copy = FALSE
Boolean	ib_Copy_Page = FALSE
String	is_Source_Path
String	is_Target_Path
String	is_Archive_Path
String	is_Single_Page_Path

end variables

forward prototypes
public function integer of_copy_file (string as_file, string as_target)
public function string of_remove_path (string as_source_file)
end prototypes

public function integer of_copy_file (string as_file, string as_target);
Integer	li_Succ, li_Move_Succ
String	ls_Archive_File

li_Succ = FileCopy(as_file, as_target)
	
If li_Succ = 1 Then
	if ib_move_after_copy Then
		
		ls_Archive_File = of_remove_path(as_file)
		ls_Archive_File = is_Archive_Path + ls_Archive_File
		
		li_Move_Succ = FileMove ( as_file, ls_Archive_File )
		
	End If
Else
	//f_log("FILE_COPY", "File Copy FAILED " + as_file + " => " + as_target)
End if

Return li_Succ


end function

public function string of_remove_path (string as_source_file);
Long		ll_pos

String	ls_Target_File


ll_pos = pos(as_Source_File, "\")
do while ll_pos > 0
	as_Source_File = mid(as_Source_File, ll_pos + 1)
	ll_pos = pos(as_Source_File, "\")
loop

ls_Target_File = as_Source_File

Return ls_Target_File
end function

on n_copy_settings.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_copy_settings.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

