HA$PBExportHeader$uo_search.sru
forward
global type uo_search from uo_singlelineedit_with_history
end type
end forward

global type uo_search from uo_singlelineedit_with_history
integer width = 517
long backcolor = 16777215
end type
global uo_search uo_search

on uo_search.create
call super::create
end on

on uo_search.destroy
call super::destroy
end on

type vsb_scroll_hist from uo_singlelineedit_with_history`vsb_scroll_hist within uo_search
integer x = 434
end type

type p_seek from uo_singlelineedit_with_history`p_seek within uo_search
integer x = 416
string picturename = "..\Resource\seek_small_white.bmp"
end type

type p_corner from uo_singlelineedit_with_history`p_corner within uo_search
integer x = 448
integer y = 460
integer height = 104
end type

type sle_seek from uo_singlelineedit_with_history`sle_seek within uo_search
integer width = 416
end type

type st_seek_corner from uo_singlelineedit_with_history`st_seek_corner within uo_search
integer x = 434
end type

type dwhist from uo_singlelineedit_with_history`dwhist within uo_search
integer width = 503
end type

type r_1 from uo_singlelineedit_with_history`r_1 within uo_search
integer width = 512
end type

