HA$PBExportHeader$cbase_flight_calculation.sra
$PBExportComments$Generated Application Object
forward
global type cbase_flight_calculation from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
String 			gs_instance_name = "SERVICE"			// 24.01.2020 HR: Neue Umgebungsvariable, die f$$HEX1$$fc00$$ENDHEX$$rs Logging von UO verwendet werden kann, um sie f$$HEX1$$fc00$$ENDHEX$$r Dienste dann schnell anzupassen

s_cbase	cbase // 04.04.2016 HR: Hier k$$HEX1$$f600$$ENDHEX$$nnen die Instanzvariablen desCBASE-Applikationsobjects eingebunden werden 

s_application 	s_app
uo_service		uf
encoding 		eEncoding
string				sXMLEncoding
integer			iNumberOfFlightToProcess

string				sProfile 					= "cbase_flight_calculation.ini"
string				sBackupLogPath 		= ""
string				sLogPath 				= ""
string				sLogFile 					= ""
string				sLogPathFileName		= ""
string				sServiceName			= ""
string				sProfileUnits				= "*"
long				lTraceLevel				= 3
integer			iLanguage				= 2

string				gs_path2mzvspawn
integer			gi_use_mzvspawn
integer 			gi_trace_mzvspawn

integer			gi_enable_secondary_distribution = 0


boolean			bInteractive
integer			idebuglevel				=0

datetime			dtJobDate
long				lInterVal
long				lLiveSign
boolean			bServiceRun
string				gsCommandParam
string				gs_Version
string				gs_Build
String				sInstance
string				sAcrobatPrinter
string 			sAPPCurrentDirectory
string 			gsFunction10ExcludeFlights

transaction		SQLCA_LOG
Transaction 		SecondSQLCA

// 22.04.2010 HR:
long 				zipoffset
string				gs_zip_instance

// 05.01.2011 HR:
long 				gl_maxlock

// HTML-Help
constant uint 	HH_DISPLAY_TOPIC 		= 0
constant uint 	HH_DISPLAY_TOC 			= 1
constant uint 	HH_DISPLAY_INDEX 		= 2
constant uint 	HH_DISPLAY_SEARCH 	= 3
constant uint 	HH_HELP_CONTEXT 		= 15

boolean 			gbMaster  // 19.03.2014 HR:
boolean			gbReadCenOut = false
integer			gi_max_jobs_to_distribute = 10 

integer			gi_del_offset_ok
integer			gi_del_offset_fehler
long 				gl_max_mzv_run

boolean			gb_wait_for_mzv = false // 08.11.2019 HR: Neuer Schalter, ob der Freeze auf eine MZV wartet
end variables

global type cbase_flight_calculation from application
string appname = "cbase_flight_calculation"
event ue_amyuni_init ( ref uo_amyuni ruo_amyuni )
event ue_crystal_report_init ( ref uo_crystal_report ruo_cr )
event ue_crystal_report_load_success ( uo_crystal_report ruo_cr )
end type
global cbase_flight_calculation cbase_flight_calculation

type prototypes
Function Long SetCurrentDirectory (ref String lpPathName) Library "kernel32" Alias For "SetCurrentDirectoryA;Ansi" 
Function ulong GetCurrentDirectoryA (ulong textlen, ref string dirtext) library "KERNEL32.DLL" alias for "GetCurrentDirectoryA;Ansi"
Function uint GetSystemDirectoryA (ref string dirtext, uint textlen) library "KERNEL32.DLL" alias for "GetSystemDirectoryA;Ansi"
FUNCTION boolean CopyFileA( String szExistingFileName, string szNewFileName, boolean bFailIfExists ) LIBRARY "kernel32.dll" alias for "CopyFileA;Ansi"
Function boolean sndPlaySoundA (string SoundName, uint Flags) Library "WINMM.DLL" alias for "sndPlaySoundA;Ansi"
Function uint waveOutGetNumDevs () Library "WINMM.DLL"
Function boolean HtmlHelp( ulong hwnd, string pszFile, uint uCommand, ulong dwData ) library "Hhctrl.ocx" alias for "HtmlHelpA;Ansi"
Function boolean HtmlHelp( ulong hwnd, string pszFile, uint uCommand, string dwData ) library "Hhctrl.ocx" alias for "HtmlHelpA;Ansi"

FUNCTION int GetModuleFileNameA(ulong hinstModule,REF string lpszPath,ulong cchPath) LIBRARY "kernel32" alias for "GetModuleFileNameA;Ansi"
// --------------------------------------------
// Funktionen f$$HEX1$$fc00$$ENDHEX$$r TEmp-Dateien
// --------------------------------------------
Function Long GetTempPath (LONG nBufferLength, REF STRING lpBuffer) LIBRARY "kernel32" Alias FOR "GetTempPathA;Ansi" 
Function LONG GetTempFileName (REF STRING lpszPath, &
										 REF STRING lpPrefixString, &
										 UnsignedLong wUnique, &
										 REF STRING lpTempFileName) Library "kernel32" Alias FOR "GetTempFileNameA;Ansi" 

// --------------------------------------------
// Verzeichnis
// --------------------------------------------
FUNCTION boolean CreateDirectoryA(String lpszPath,integer attr) LIBRARY "kernel32.DLL" alias for "CreateDirectoryA;Ansi"
FUNCTION ulong   GetFileAttributesA(ref string filepath) LIBRARY "kernel32.dll" alias for "GetFileAttributesA;Ansi"
//
// Ausgabe f$$HEX1$$fc00$$ENDHEX$$r DBMON.EXE (trace im Fenster)
//
SUBROUTINE OutputDebugStringA (String lpszOutputString) LIBRARY "kernel32.dll" alias for "OutputDebugStringA;Ansi"
FUNCTION ulong SetCapture(ulong a) LIBRARY "user32.dll"
FUNCTION boolean ReleaseCapture() LIBRARY "user32.dll"
Function ulong FindWindowA (ulong classname, string windowname) Library "USER32.DLL" alias for "FindWindowA;Ansi"

function long GetDC( long hWnd ) Library "user32"
function long ReleaseDC( long hWnd, long hDC ) Library "user32"


end prototypes

event ue_amyuni_init(ref uo_amyuni ruo_amyuni);/*
* This event is triggered from within the constructor of "uo_amyuni".
* You can use it to configure the newly created instance of the uo_amyuni object.
*/

string ls_temp

  SELECT cen_setup.cvalue  
     INTO :ls_temp
    FROM cen_setup,
	 		sys_login  
   WHERE cen_setup.cclient = sys_login.cclient 
	   AND cen_setup.csection = 'MULTILANGUAGE' 
	   AND cen_setup.ckey = 'PDF_MULTILINGUAL_SUPPORT' 
	   AND upper(sys_login.cusername) = 'CBASE';

if SQLCA.SQLCode = 0 then
	ruo_amyuni.MultilingualSupport = (ls_temp = "1")
else
	ruo_amyuni.MultilingualSupport =	false
end if

  SELECT cen_setup.cvalue  
     INTO :ls_temp
    FROM cen_setup,
	 		sys_login  
   WHERE cen_setup.cclient = sys_login.cclient 
	   AND cen_setup.csection = 'MULTILANGUAGE' 
	   AND cen_setup.ckey = 'PDF_FULL_EMBED' 
	   AND upper(sys_login.cusername) = 'CBASE';

if SQLCA.SQLCode = 0 then
	ruo_amyuni.FullEmbed = (ls_temp = "1") 
else
	ruo_amyuni.FullEmbed =	false
end if

// Set Amyuni to ServerMode if it is not started as an application
ruo_Amyuni.ServerMode = Not bInteractive
end event

event ue_crystal_report_init(ref uo_crystal_report ruo_cr);/*
* This event is triggered from within the constructor of "uo_crystal_report".
* You can use it to configure the newly created instance of the uo_crystal_report object.
*/

ruo_cr.of_show_progress_dialog(false)
end event

event ue_crystal_report_load_success(uo_crystal_report ruo_cr);/*
* This event is triggered from within the of_load function of "uo_crystal_report".
* You can use it to configure uo_crystal_report object after a report was loaded.
*/

// 30.11.2010, DB: Papierformat des Reports setzen. Unabh$$HEX1$$e400$$ENDHEX$$ngig vom urspr$$HEX1$$fc00$$ENDHEX$$nglichen Format des Reports.
if f_mandant_profilestring(sqlca, s_app.smandant, "PaperFormat", "UseLetterFormat", "0") = "1" then
	ruo_cr.of_set_paper_format(ruo_cr.PAPER_SIZE_LETTER)
else
	ruo_cr.of_set_paper_format(ruo_cr.PAPER_SIZE_DIN_A4)
end if

// Verbindungsparameter festlegen
if ruo_cr.of_set_connection(SQLCA.ServerName, "CBASE", "SYS_PWD_CHANGE", "test") <> 0 then
	f_db_error(SQLCA, "Error setting connection for report file")
end if
end event

on cbase_flight_calculation.create
appname="cbase_flight_calculation"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on cbase_flight_calculation.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event close;string	sText

sText = sInstance +" is going DOWN at " + string(today()) + " / " + string(now())
f_log2csv(0,2,sText)

disconnect using sqlca;
disconnect using sqlca_log;
end event

event open;
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Objekt : cbase_flight_calculation
// Methode: open (Event)
// Autor  :
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// string commandline
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Return: none
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version		Autor              			     Kommentar
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//  ??.??.????	??.??			???
//  19.09.2013	4.94			Thomas Brackmann		uo_flight_calculation.of_process_row: F$$HEX1$$fc00$$ENDHEX$$r Nachkalkulation ifunction von 10 auf 11 ge$$HEX1$$e400$$ENDHEX$$ndert
//  10.10.2013	4.94			Thomas Brackmann		uo_flight_calculation.of_recalc_set_differences: Initialisierung von	NULL-Values f$$HEX1$$fc00$$ENDHEX$$r Nachkalkulation
//  30.10.2013	4.94			Thomas Brackmann		Verschiedene Fehlerbeseitigungen im Zusammenhang mit Meal Overload Report
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

string sCommandParm, sfile
long lHandle, ireturn
uo_pdf_handler	iuo_PDF

sCommandParm 	= CommandParm()
gs_Version			= "5.90"
gs_Build				= "1004"

if  Handle(GetApplication()) = 0 then
	sCommandParm = "INSTANCE99"
end if 
// --------------------------------------------------------------------------------
// 06.11.2009 HR: Aufrufparameter hier schon auswerten, damit Logfile richtig gesetzt wird
// --------------------------------------------------------------------------------
If sCommandParm = "" then
	sInstance    =upper("Application")
else
	sInstance    = upper(sCommandParm)
end if

gs_instance_name = sInstance

// 04.04.2016 HR:
cbase.sApplicationName = "CBASE" 

// ------------------------------------------------------------
// Profile auslesen
// ------------------------------------------------------------	
f_profile()

// --------------------------------------------------------------------------------------------------------------------
// Wir setzen ggf. in der INI die ben$$HEX1$$f600$$ENDHEX$$tigtenParameter f$$HEX1$$fc00$$ENDHEX$$r den Fall eines SYSTEMERROR
// Anschlie$$HEX1$$df00$$ENDHEX$$end pr$$HEX1$$fc00$$ENDHEX$$fen wir, ob wir testweise einen SYSTEMFEHLER erzeugen sollen
// --------------------------------------------------------------------------------------------------------------------
uo_systemerror uose
uose.is_Profile = sProfile

if ProfileString(sProfile, "SYSTEMERROR","TEST_SYSTEMERROR","") = "" then
	uose.of_init()
end if

uose.of_test_systemerror()

sServiceName				= f_get_executable_name()
sAppCurrentDirectory		= GetCurrentDirectory()

//sCurrentDirectory		= GetCurrentDirectory()

if isNull(dtJobDate) then dtJobDate = datetime(today(),now())
uf = create uo_service

s_app.itrace 				= Integer(ProfileString(sProfile, "TRACE","TRACING","0"))
// 06.11.2009 HR: wird in f_profile gesetzt
//sFile							= ProfileString(sProfile, "TRACE","TRACEFILE","C:\TRACE_cbase_ml_billing")

s_app.iMessageMode 	= 1		// Tracefile, kein Messagebox Popup
s_app.iInvoicingType		= Integer(ProfileString(sProfile, "PARAMETERS", "InvoicingType", "1"))
// 06.11.2009 HR: wird in f_profile gesetzt
//sLogPathFilename = sLogPath + sLogFile + sInstance 

iuo_PDF = create uo_pdf_handler
s_app.uo_pdf	= iuo_PDF

f_Log2Csv(0,0," ")
f_Log2Csv(0,0," _____ ______  ___   _____ _____  ______ _ _       _     _            _      ")
f_Log2Csv(0,0,"/  __ \| ___ \/ _ \ /  ___|  ___| |  ___| (_)     | |   | |          | |     ")
f_Log2Csv(0,0,"| /  \/| |_/ / /_\ \\ `--.| |__   | |_  | |_  __ _| |__ | |_ ___ __ _| | ___ ")
f_Log2Csv(0,0,"| |    | ___ \  _  | `--. \  __|  |  _| | | |/ _` | '_ \| __/ __/ _` | |/ __|")
f_Log2Csv(0,0,"| \__/\| |_/ / | | |/\__/ / |___  | |   | | | (_| | | | | || (_| (_| | | (__ ")
f_Log2Csv(0,0," \____/\____/\_| |_/\____/\____/  \_|   |_|_|\__, |_| |_|\__\___\__,_|_|\___|")
f_Log2Csv(0,0,"                                              __/ |                          ")
f_Log2Csv(0,0,"                                             |___/                           ")
f_Log2Csv(0,0," ")

// ------------------------------------------------------------
// Modus ermitteln
// ------------------------------------------------------------
If sCommandParm = "" then
	bInteractive = True
	// 06.11.2009 HR: wird in f_profile gesetzt
	//s_app.sTraceFile = sFile  + "-" + sInstance + "-" + String(Today(), "yyyymmdd") + ".log"

	f_Log2Csv(0,0,"Application started as GUI: " + sServiceName + " Version: " + gs_Version + " Build: " + gs_Build)
	f_connect()
	f_connect_log()

	// --------------------------------------------------------------------------------------------------------------------
	// 24.07.2018 HR: Wir brauchen den Datastore f$$HEX1$$fc00$$ENDHEX$$r sp$$HEX1$$e400$$ENDHEX$$ter
	// --------------------------------------------------------------------------------------------------------------------
	s_app.dsProfile = create datastore
	s_app.dsProfile.dataobject = "dw_profile"
	s_app.dsProfile.Settransobject(SQLCA)
	s_app.dsProfile.retrieve(1)
	
	// ----------------------------
	// Translation auslesen
	// ----------------------------
	If uf.uf_create_datastore() = False Then
		// Messagebox("Translation","Could not read the translation data.",Stopsign!)
		s_app.ilanguage = 2
	End if
	s_app.ilanguage = 2
	// ----------------------------
	// Errormessages auslesen
	// ----------------------------
	uf.get_errormessages()
	
//	SetProfileString(sProfile, "PARAMETERS", "Locked", "0")
//	SetProfileString(sProfile, "PARAMETERS", "Instance", "")
//	SetProfileString(sProfile, "PARAMETERS", "TimeStamp", String(Now(), "hh:mm"))

	open(w_main_window)	
	w_main_window.title= "Service Flight Calculation "+gs_Version+" Build "+gs_Build+" ["+SQLCA.ServerName+"]"
Else
	
	bInteractive = False
	
	s_app.ilanguage = 2 // wird in f_profile ggf. $$HEX1$$fc00$$ENDHEX$$berschrieben
	f_Log2Csv(0,0,"Application started as service: " + sServiceName + " Version: " + gs_Version + " Build: " + gs_Build)
	
	f_loop()
	
End if
end event

event systemerror;
uo_systemerror uose
uose.of_systemerror( gs_Version + "-" + gs_Build, sInstance,  sProfile)

halt
end event

