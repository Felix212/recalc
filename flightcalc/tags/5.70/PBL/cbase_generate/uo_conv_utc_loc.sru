HA$PBExportHeader$uo_conv_utc_loc.sru
forward
global type uo_conv_utc_loc from nonvisualobject
end type
end forward

global type uo_conv_utc_loc from nonvisualobject autoinstantiate
end type

type variables
// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_conv_utc_loc
// Methode:  (Declaration)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Objekt zur Berechnung der UTC oder Lokalzeit aus einer $$HEX1$$fc00$$ENDHEX$$bergebenen Zeit f$$HEX1$$fc00$$ENDHEX$$r ein Ort
//
//	Es wir das DW dw_generate_timezone ben$$HEX1$$f600$$ENDHEX$$tigt
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  18.02.2016	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
	
//Hier stehen dann die Ergebnisse drin
date		id_new_date
string		is_new_time
decimal	id_new_offset

end variables

forward prototypes
public function integer uf_utc2loc (string arg_tlc, date arg_date, string arg_time, decimal arg_offset)
private function decimal uf_get_offset (string arg_offset)
public function integer uf_loc2utc (string arg_tlc, date arg_date, string arg_time, decimal arg_offset)
end prototypes

public function integer uf_utc2loc (string arg_tlc, date arg_date, string arg_time, decimal arg_offset);datetime 	ldt1, ldt2, ldt_start, ldt_stop 
long			ll_timezone_key
decimal		ld_gmt

if not istime(arg_time) then
	is_new_time = ""
	return 0
end if

if arg_offset > 12 then
	  SELECT sys_three_letter_codes.ngmt,   
				sys_three_letter_codes.ntimezone_key  
		 INTO :ld_gmt,   
				:ll_timezone_key  
		 FROM sys_three_letter_codes  
		WHERE sys_three_letter_codes.ctlc = :arg_tlc   ;

	if sqlca.sqlcode<>0 then
		//Bei Fehlern (Not Found) geben wir die Ausgangsdaten zur$$HEX1$$fc00$$ENDHEX$$ck
		id_new_date = arg_date
		is_new_time = arg_time
		id_new_offset = 0
		
		return 0
	end if
	
	if ll_timezone_key = 999 then
		id_new_offset = ld_gmt
	else
		datastore lds
		
		lds = create datastore
		lds.dataobject = "dw_generate_timezone"
		lds.settransobject(SQLCA)
		lds.setfilter("sys_timezones_dlst_nyear = "+string(arg_date, "YYYY")+" or isnull( sys_timezones_dlst_nyear )")
		lds.retrieve(ll_timezone_key)
		
		if lds.rowcount()=0 then
			id_new_date = arg_date
			is_new_time = arg_time
			id_new_offset = 0

			destroy lds	
			
			return 0
		end if
		
		id_new_offset = uf_get_offset(lds.getitemstring(1, "sys_timezones_cgmt_offset"))
		
		if not isnull(lds.getitemnumber(1, "sys_timezones_dlst_nyear")) then
			ldt1 		= datetime(arg_date, time(arg_time))
			ldt2 		= f_dt_add(ldt1, id_new_offset * 60 * 60)
			
			ldt_start 	= datetime(date(lds.getitemdatetime(1, "sys_timezones_dlst_ddst_start_date")), time(lds.getitemstring(1, "sys_timezones_dlst_cdst_start_time")))
			ldt_stop 	= datetime(date(lds.getitemdatetime(1, "sys_timezones_dlst_ddst_end_date")), time(lds.getitemstring(1, "sys_timezones_dlst_cdst_end_time")))
			
          	if f_dt_diff(ldt_start, ldt2) > 0 and f_dt_diff(ldt2, ldt_stop) > 0 then
				id_new_offset = uf_get_offset(lds.getitemstring(1, "sys_timezones_dlst_cdst_offset"))
			end if
		end if
		
		destroy lds	

	end if
else
	id_new_offset = arg_offset
end if

ldt1 				= datetime(arg_date, time(arg_time))
ldt2 				= f_dt_add(ldt1, id_new_offset * 60 * 60)

id_new_date 	= date(ldt2)
is_new_time 	= string(ldt2, "hh:mm")

return 1
end function

private function decimal uf_get_offset (string arg_offset);decimal arg_ret


arg_ret = integer(mid(arg_offset, 2, 2))

arg_ret += integer(right(arg_offset, 2)) / 60

if left(arg_offset, 1)="-" then 
	arg_ret = arg_ret * (-1)
end if

return arg_ret

end function

public function integer uf_loc2utc (string arg_tlc, date arg_date, string arg_time, decimal arg_offset);datetime 	ldt1, ldt2, ldt_start, ldt_stop 
long			ll_timezone_key
decimal		ld_gmt

if not istime(arg_time) then
	is_new_time = ""
	return 0
end if

if arg_offset > 12 then
	  SELECT sys_three_letter_codes.ngmt,   
				sys_three_letter_codes.ntimezone_key  
		 INTO :ld_gmt,   
				:ll_timezone_key  
		 FROM sys_three_letter_codes  
		WHERE sys_three_letter_codes.ctlc = :arg_tlc   ;

	if sqlca.sqlcode<>0 then
		//Bei Fehlern (Not Found) geben wir die Ausgangsdaten zur$$HEX1$$fc00$$ENDHEX$$ck
		id_new_date = arg_date
		is_new_time = arg_time
		id_new_offset = 0
		
		return 0
	end if
	
	if ll_timezone_key = 999 then
		id_new_offset = ld_gmt
	else
		datastore lds
		
		lds = create datastore
		lds.dataobject = "dw_generate_timezone"
		lds.settransobject(SQLCA)
		lds.setfilter("sys_timezones_dlst_nyear = "+string(arg_date, "YYYY")+" or isnull( sys_timezones_dlst_nyear )")
		lds.retrieve(ll_timezone_key)
		
		if lds.rowcount()=0 then
			id_new_date = arg_date
			is_new_time = arg_time
			id_new_offset = 0

			destroy lds	
			
			return 0
		end if
		
		id_new_offset = uf_get_offset(lds.getitemstring(1, "sys_timezones_cgmt_offset"))
		
		if not isnull(lds.getitemnumber(1, "sys_timezones_dlst_nyear")) then
			ldt2 		= datetime(arg_date, time(arg_time))
			
			ldt_start 	= datetime(date(lds.getitemdatetime(1, "sys_timezones_dlst_ddst_start_date")), time(lds.getitemstring(1, "sys_timezones_dlst_cdst_start_time")))
			ldt_stop 	= datetime(date(lds.getitemdatetime(1, "sys_timezones_dlst_ddst_end_date")), time(lds.getitemstring(1, "sys_timezones_dlst_cdst_end_time")))
			
          	if f_dt_diff(ldt_start, ldt2) > 0 and f_dt_diff(ldt2, ldt_stop) > 0 then
				id_new_offset = uf_get_offset(lds.getitemstring(1, "sys_timezones_dlst_cdst_offset"))
			end if
		end if
		
		destroy lds	

	end if
else
	id_new_offset = arg_offset
end if

ldt1 				= datetime(arg_date, time(arg_time))
ldt2 				= f_dt_add(ldt1, (-1) * id_new_offset * 60 * 60)

id_new_date 	= date(ldt2)
is_new_time 	= string(ldt2, "hh:mm")

return 1
end function

on uo_conv_utc_loc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_conv_utc_loc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

