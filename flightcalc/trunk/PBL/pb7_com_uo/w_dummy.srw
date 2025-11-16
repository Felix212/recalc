HA$PBExportHeader$w_dummy.srw
$PBExportComments$Dummy Window (Font Calc)
forward
global type w_dummy from window
end type
end forward

global type w_dummy from window
boolean visible = false
integer width = 1074
integer height = 756
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
end type
global w_dummy w_dummy

on w_dummy.create
end on

on w_dummy.destroy
end on

event open;this.visible = false
end event

