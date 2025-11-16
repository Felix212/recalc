HA$PBExportHeader$uo_crystal_report_viewer_interface.sru
$PBExportComments$Interface Objekt f$$HEX1$$fc00$$ENDHEX$$r die verschiedenen Crystal Report Viewer
forward
global type uo_crystal_report_viewer_interface from userobject
end type
end forward

global type uo_crystal_report_viewer_interface from userobject
integer width = 1449
integer height = 880
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type
global uo_crystal_report_viewer_interface uo_crystal_report_viewer_interface

type variables

end variables

forward prototypes
public function integer of_show (ref uo_crystal_report auo_cr)
public function integer of_print ()
public function integer of_export ()
end prototypes

public function integer of_show (ref uo_crystal_report auo_cr);// MUSS IMPLEMENTIERT WERDEN

return 0
end function

public function integer of_print ();// MUSS IMPLEMENTIERT WERDEN

return 0
end function

public function integer of_export ();// MUSS IMPLEMENTIERT WERDEN

return 0
end function

on uo_crystal_report_viewer_interface.create
end on

on uo_crystal_report_viewer_interface.destroy
end on

