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

end variables

global type cbase_flight_calculation from application
string appname = "cbase_flight_calculation"
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
gs_Version			= "5.20"
gs_Build				= "1028"
 
// --------------------------------------------------------------------------------
// 06.11.2009 HR: Aufrufparameter hier schon auswerten, damit Logfile richtig gesetzt wird
// --------------------------------------------------------------------------------
If sCommandParm = "" then
	sInstance    =upper("Application")
else
	sInstance    = upper(sCommandParm)
end if

// ------------------------------------------------------------
// Profile auslesen
// ------------------------------------------------------------	
f_profile()

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

event systemerror;string	sText

sText =String(error.number) + " - " + error.text
f_log2csv(0,2,' ')
f_log2csv(0,2,'########################################################################')
f_log2csv(0,2,"Systemerror: ")
f_log2csv(0,2,sText)
f_log2csv(0,2,'########################################################################')
f_log2csv(0,2,' ')

end event

