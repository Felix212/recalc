HA$PBExportHeader$uo_amyuni_viewer_interface.sru
$PBExportComments$Interface Objekt f$$HEX1$$fc00$$ENDHEX$$r die verschiedenen Amyuni PDF Viewer
forward
global type uo_amyuni_viewer_interface from userobject
end type
end forward

global type uo_amyuni_viewer_interface from userobject
integer width = 1623
integer height = 912
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type
global uo_amyuni_viewer_interface uo_amyuni_viewer_interface

type variables

end variables

forward prototypes
public function integer of_open (string as_file)
public subroutine of_zoom (integer li_zoom)
public subroutine of_print (string as_printer)
public function integer of_get_page_count ()
public subroutine of_show_page (integer ai_page)
end prototypes

public function integer of_open (string as_file);// MUSS IMPLEMENTIERT WERDEN
return 0
end function

public subroutine of_zoom (integer li_zoom);// MUSS IMPLEMENTIERT WERDEN
end subroutine

public subroutine of_print (string as_printer);// MUSS IMPLEMENTIERT WERDEN
end subroutine

public function integer of_get_page_count ();// MUSS IMPLEMENTIERT WERDEN
return 0
end function

public subroutine of_show_page (integer ai_page);// MUSS IMPLEMENTIERT WERDEN
end subroutine

on uo_amyuni_viewer_interface.create
end on

on uo_amyuni_viewer_interface.destroy
end on

event constructor;// MUSS IMPLEMENTIERT WERDEN
end event

