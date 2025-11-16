HA$PBExportHeader$uo_generate_main.sru
forward
global type uo_generate_main from nonvisualobject
end type
end forward

global type uo_generate_main from nonvisualobject
end type
global uo_generate_main uo_generate_main

type variables
integer 		ii_generate_type
string 			sInstanceName
string			is_service_instance 	= "NONE"
boolean		ib_onetimegen_exit
end variables

forward prototypes
public function boolean of_start (date arg_generate_date)
public function integer of_checkconnection ()
public function integer of_service_alive ()
public function string of_checknull (string stext)
public function integer of_log_joblist (datastore arg_dw, long arg_row)
end prototypes

public function boolean of_start (date arg_generate_date);long 										i, lStart, lEnd, ll_airline_key, ll_job_type
string										sFilter
boolean  								lbUseNewJobOrder, lb_ret 
integer 									li_generate_jobtype, li_outstation
uo_generate_datastore 	ldsjobs2generate
uo_generate 	 					luo_job
uo_generate_outstation	luo_job_os

lbUseNewJobOrder 	= ( f_mandant_profilestring(sqlca, s_app.sMandant, "Generierung", "UseNewJobOrder", "0") = "1")

ldsjobs2generate							= Create uo_generate_datastore
ldsjobs2generate.DataObject		= "dw_jobs2generate_new"
ldsjobs2generate.SetTransObject(SQLCA)

ldsjobs2generate.Retrieve(ii_generate_type)

sFilter = "(upper(cinstance) = '" + upper(this.sInstanceName) + "' and (isNull(cassigned_instance) or trim(cassigned_instance)='' )) or" // Alle jobs f$$HEX1$$fc00$$ENDHEX$$r diese Instanz, die keiner anderen zugewiesen sind
sfilter = sfilter + "(upper(cassigned_instance) = '"+ upper(this.sInstanceName)+"')"  //Alle Jobs die manuell zugewiesen sind

ldsjobs2generate.SetFilter(sFilter)
ldsjobs2generate.Filter()

// 08.07.04: Aus aktuellem Anlass: nochmals die Reihenfolge sicherstellen	cclient A, cunit A, nprio A
// 24.08.04: Neue Sportierung: cclient A, cunit A, njob_type A
// 23.12.05: Neue Sportierung: njob_prio A, cclient A, cunit A, njob_type A
// 30.10.08: Neue Sportierung: njob_prio A, cclient A, cunit A, njob_type A, ndays_offset A, nairline_key A
// 30.10.10: Neue Sportierung: njob_kind A, njob_prio A, cclient A, cunit A, njob_type A, ndays_offset A, nairline_key A
// 13.02.12: Neue Sportierung: njob_kind A, njob_prio A, cclient A, cunit A, comp_njob_type A, ndays_offset A, nairline_key A
// 02.06.16: Neue Sportierung: njob_kind A, compute_sapjob A, njob_prio A, cclient A, cunit A, comp_njob_type A, ndays_offset A, nairline_key A
// 11.08.2021 HR:  #7982 change priority of generations (Priority, Date, CSC, Customer)
if lbUseNewJobOrder then
	if ii_generate_type <> 2 then
		ldsjobs2generate.SetSort("njob_kind A, compute_sapjob A, njob_prio A, ndays_offset A, cclient A, cunit A, nairline_key A, comp_njob_type A")
	else
		ldsjobs2generate.SetSort("njob_prio A, ndays_offset A, cclient A, cunit A, nairline_key A, comp_njob_type A")
	end if
else
	if ii_generate_type <> 2 then
		ldsjobs2generate.SetSort("njob_kind A, compute_sapjob A, njob_prio A, cclient A, cunit A, comp_njob_type A, ndays_offset A, nairline_key A")
	else
		// --------------------------------------------------------------------------------------------------------------------
		// 12.04.2013 HR: F$$HEX1$$fc00$$ENDHEX$$r reine Einmalereignisinstanzen ist eine andere Prio n$$HEX1$$f600$$ENDHEX$$tig
		// --------------------------------------------------------------------------------------------------------------------
		ldsjobs2generate.SetSort("njob_prio A, ndays_offset A, cclient A, cunit A, comp_njob_type A, nairline_key A")
	end if
end if

ldsjobs2generate.Sort()

guoLog.uf_allways("["+ this.classname( )+".of_start]  ")
guoLog.uf_allways("["+ this.classname( )+".of_start]  ")
guoLog.uf_allways("["+ this.classname( )+".of_start] #######################################################################################################")
guoLog.uf_allways("["+ this.classname( )+".of_start] Processing joblist for date " + String(arg_generate_date)+ "   Jobs in Queue: "+string(ldsjobs2generate.rowcount()))

if lbUseNewJobOrder then
	guoLog.uf_allways("["+ this.classname( )+".of_start] Process jobs in new Order (AlmID 7982) !!!")
end if

guoLog.uf_allways("["+ this.classname( )+".of_start] #######################################################################################################")

For i = 1 to ldsjobs2generate.rowcount()
	this.of_log_joblist( ldsjobs2generate, i )
Next 

For i = 1 to ldsjobs2generate.rowcount()
	guoLog.uf_allways("["+ this.classname( )+".of_start] Processing job   # " + String(i, "0000") + " of " + String(ldsjobs2generate.rowcount(), "0000") +" - start")
	
	lStart 								= CPU()
	
	if of_checkconnection() <> 0 then
		guoLog.uf_error("["+ this.classname( )+".of_start] We stop processing, due to dabase problems ")
		return false
	else
		guoLog.uf_debug("["+ this.classname( )+".of_start] Connection is active") 
	end if

	if of_service_alive() = 1 then
		guoLog.uf_info("["+ this.classname( )+".of_start] Service is paused by table SYS_SERVICES_ALIVE")
		return false
	else
		guoLog.uf_debug("["+ this.classname( )+".of_start] Service is alive") 
	end if
		
	gll_log_job_key			= ldsjobs2generate.Getitemnumber(i, "njob_key")
	li_generate_jobtype	= ldsJobs2Generate.Getitemnumber(i, "njob_kind")	
	li_outstation					= ldsJobs2Generate.Getitemnumber(i, "noutstation")
	ll_airline_key				= ldsJobs2Generate.Getitemnumber(i, "nairline_key")
	ll_job_type 					= ldsJobs2Generate.Getitemnumber(i, "njob_type")
	
	if li_outstation = 1 then
		// ########################################################
		// ## New Logic for Outstation Generation
		// ########################################################
		
		luo_job_os = create uo_generate_outstation			
		
		luo_job_os.iDebug_Level 				= s_app.iTrace
		luo_job_os.sProfile 							= s_app.sProfile
		luo_job_os.sTraceFile 						= f_gettemppath() + ProfileString ("cbase.ini", "TRACE", "LOGFILE", "trace_" + string( today(), "yyyy-mm-dd") + ".txt")
		luo_job_os.lAirlineParameter 			= ll_airline_key
		luo_job_os.lJobNumber					= gll_log_job_key
		luo_job_os.bExtendedLog				= false
		luo_job_os.ii_generate_jobtype		= ii_generate_type
		luo_job_os.sInstanceName				= is_service_instance
		luo_job_os.boutstation						= true
		
		guoLog.uf_debug("["+ this.classname( )+".of_start] Before  of_generate_jobs")
		lb_ret = luo_job_os.of_generate_jobs( today(), s_app.sMandant, s_app.sWerk, ll_job_type)
		guoLog.uf_debug("["+ this.classname( )+".of_start] After  of_generate_jobs returns " + string(lb_ret))
		
		destroy luo_job_os
		
	else
		// ########################################################
		// ## Old Logic for Standard Generation
		// ########################################################
		
		luo_job = create uo_generate
		
		luo_job.iDebug_Level 				= s_app.iTrace
		luo_job.sProfile 							= s_app.sProfile
		luo_job.sTraceFile 						= f_gettemppath() + ProfileString ("cbase.ini", "TRACE", "LOGFILE", "trace_" + string(today(), "yyyy-mm-dd") + ".txt")
		luo_job.lAirlineParameter 		= ll_airline_key
		luo_job.lJobNumber					= gll_log_job_key
		luo_job.bExtendedLog				= false
		luo_job.ii_generate_jobtype	= ii_generate_type
		luo_job.sInstanceName			= is_service_instance
		luo_job.boutstation					= false
		
		guoLog.uf_debug("["+ this.classname( )+".of_start] Before  of_generate_jobs")
		lb_ret = luo_job.of_generate_jobs( today(), s_app.sMandant, s_app.sWerk, ll_job_type)
		guoLog.uf_debug("["+ this.classname( )+".of_start] After  of_generate_jobs returns " + string(lb_ret))
		
		destroy luo_job
		
	end if
	lEnd = CPU()
		
	guoLog.uf_allways("["+ this.classname( )+".of_start] Processing job   # " + String(i, "0000") + " of " + String(ldsjobs2generate.rowcount(), "0000") + " -  took " + string((lEnd - lStart) / 1000, "0.00") + " seconds")
	
	if li_generate_jobtype=2 then
		// 19.12.2018 HR: issue #4476 One Time Generation Reload Joblist after everey Job
		ib_onetimegen_exit = true
		guoLog.uf_allways("["+ this.classname( )+".of_start] Exit Loop due to Onetimejob finsihed")
		exit 
	end if

Next

//10.06.2024 HR: Logging Job-Nr and Result_key to Graylog
gll_log_result_key	= 0
gll_log_job_key		= 0

destroy ldsjobs2generate

guoLog.uf_allways("["+ this.classname( )+".of_start] Finished")

return True
end function

public function integer of_checkconnection ();string sValue

select dummy into :sValue from dual;
	
if sqlca.sqlcode <> 0 then
	
	guoLog.uf_error("["+ this.classname( )+".of_checkconnection] " + SQLCA.ServerName +": ErrorCode = " + String(sqlca.sqlcode))
	guoLog.uf_error("["+ this.classname( )+".of_checkconnection] " + SQLCA.ServerName +": ErrorText = " + String(sqlca.sqlerrtext))

	return -1
	
end if

return 0

end function

public function integer of_service_alive ();datastore 	lds
integer		li_ret

if is_service_instance 	= "NONE" then return 0

lds = create datastore
lds.dataobject="dw_services_alive"
lds.settransobject(SQLCA)

lds.retrieve("cbase_service", is_service_instance)

if lds.rowcount()=0 then
	lds.insertrow(0)
	lds.setitem(1,"cservice", 						"cbase_service" )
	lds.setitem(1,"cinstance", 					is_service_instance )
	lds.setitem(1,"npause", 						0)
	lds.setitem(1,"nmaster", 						0)
	lds.setitem(1,"ngraylog_enabled", 	0)
end if

// --------------------------------------------------------------------------------------------------------------------
// 07.05.2020 HR: NMASTER=2 sind JAVA Services, daher muss die PB-Instance pausieren
// --------------------------------------------------------------------------------------------------------------------
if  lds.getitemnumber(1,"nmaster") = 2 then
	guoLog.uf_info("["+ this.classname( )+".of_checkconnection] Instance " + is_service_instance + " is configured as a JAVA service. PB service instance is paused")
	li_ret = 1
else
	lds.setitem(1, "cversion", 			s_app.sVersion)
	lds.setitem(1, "dlifesign", 			datetime(today(), now()))
	
	li_ret = lds.getitemnumber(1, "npause")
	
	if li_ret = 1 then 
		// Das Stoppen des Dienstes ist best$$HEX1$$e400$$ENDHEX$$tigt
		lds.setitem(1, "npause", 			2)	
		li_ret = 2
	end if
	
	lds.update()
	commit using sqlca;
	
end if

destroy lds
 
return li_ret
end function

public function string of_checknull (string stext);

if isnull(sText) then return ""

return sText
end function

public function integer of_log_joblist (datastore arg_dw, long arg_row);// -------------------------------------------------
// 22.11.2006
// Eine Zeile der Jobliste ins Protokoll schreiben
// -------------------------------------------------
String ls_Out

ls_Out = "[" + string(arg_row, "0000") + "] - "

if arg_dw.Getitemnumber(arg_row, "njob_kind")=2 then
   ls_Out +=    "Einmalereignis " + " - "
end if

ls_Out += this.of_checknull(arg_dw.Getitemstring(arg_row, "cairline")) + " - " 
ls_Out += this.of_checknull(arg_dw.Getitemstring(arg_row, "ctext")) + char(9)
ls_Out += this.of_checknull(arg_dw.Getitemstring(arg_row, "cclient")) + char(9)
ls_Out += this.of_checknull(arg_dw.Getitemstring(arg_row, "cunit")) + char(9)
ls_Out += this.of_checknull(String(arg_dw.GetitemNumber(arg_row, "ndays_offset"))) + char(9)
ls_Out += this.of_checknull(arg_dw.Getitemstring(arg_row,"cinstance")) 

guoLog.uf_trace("["+ this.classname( )+".of_log_joblist] "+ ls_Out)

return 0

end function

on uo_generate_main.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_generate_main.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

