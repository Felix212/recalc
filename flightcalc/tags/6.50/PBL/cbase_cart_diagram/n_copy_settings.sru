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

integer iiRetryWaitSeconds 
end variables

forward prototypes
public function integer of_copy_file (string as_file, string as_target)
public function string of_remove_path (string as_source_file)
end prototypes

public function integer of_copy_file (string as_file, string as_target);
// --------------------------------------------------------------------------------
// Objekt : n_copy_settings
// Methode: of_copy_file (Function)
// Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
// Datum  : 28.03.2017
//
// Argument(e):
// string as_file
//	 string as_target
//
// Beschreibung:		Copy 
//
// Aenderungshistorie:
// Version 		Wer			Wann			Was und warum
// 1.0 			O.Hoefer	28.03.2017		Erstellung
// 1.1 			O.Hoefer	31.03.2017		Erstellung
//
//
// Return: integer
//
// --------------------------------------------------------------------------------

Integer	li_Succ, li_Move_Succ
String	ls_Archive_File
Long		ll_temp_tracelevel
Long		ll_FileSize_SRC, ll_FileSize_TRG


if not fileexists(as_file) then
	guoLog.uf_error("["+ this.classname( )+".of_copy_file] File Copy " + as_file + "  DOES NOT EXIST")
end if

if fileexists(as_file) then
	ll_FileSize_SRC = FileLength(as_file)
End If

li_Succ = FileCopy(as_file, as_target)
	
if li_Succ <> 1 Then
	If iiRetryWaitSeconds > 0 then
		guoLog.uf_error("["+ this.classname( )+".of_copy_file] File Copy " + String(li_Succ) + " failed , wait, retry ")
		Sleep(iiRetryWaitSeconds)
		li_Succ = FileCopy(as_file, as_target)
		if li_Succ <> 1 Then
			If iiRetryWaitSeconds > 0 then
				guoLog.uf_error("["+ this.classname( )+".of_copy_file] File Copy " + String(li_Succ) + " failed , wait, retry ")
				Sleep(iiRetryWaitSeconds)
				li_Succ = FileCopy(as_file, as_target)
			End If
		End If
	End If
End If
	
	
If li_Succ = 1 Then
	
	ll_FileSize_TRG = FileLength(as_target)
		
	guoLog.uf_allways("["+ this.classname( )+".of_copy_file] File Copy " + as_file + " (" + String(ll_FileSize_SRC) +") => " + as_target + " (" + String(ll_FileSize_TRG)+ ")")

	if ib_move_after_copy Then
		
		ls_Archive_File = of_remove_path(as_file)
		ls_Archive_File = is_Archive_Path + ls_Archive_File
		
		li_Move_Succ = FileMove ( as_file, ls_Archive_File )
		
	End If
Else
	guoLog.uf_error("["+ this.classname( )+".of_copy_file] File Copy FAILED " + as_file + " (" + String(ll_FileSize_SRC) +") => " + as_target )
	Return -1
End if

guoLog.uf_debug("["+ this.classname( )+".of_copy_file] File Copy " + as_file + " (" + String(ll_FileSize_SRC) +") => " + as_target + " (" + String(ll_FileSize_TRG)+ ")")

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

event constructor;//iiRetryWaitSeconds = integer( ProfileString(sProfile, "PARAMETERS", "RETRYSECONDS", "5"))
iiRetryWaitSeconds = integer( ProfileString(s_app.sProfile, "PARAMETERS", "RETRYSECONDS", "5"))

end event

