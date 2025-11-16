HA$PBExportHeader$uo_flight_calculation.sru
$PBExportComments$Generierung f$$HEX1$$fc00$$ENDHEX$$r ein Flugereignis
forward
global type uo_flight_calculation from nonvisualobject
end type
end forward

global type uo_flight_calculation from nonvisualobject
end type
global uo_flight_calculation uo_flight_calculation

type prototypes
 SUBROUTINE ZeroMemory( REF structure lpVoid, ulong dwSizeofStruct ) LIBRARY "kernel32" ALIAS FOR "RtlZeroMemory;Ansi"
 FUNCTION boolean GetDiskFreeSpaceExA( string lpDirName, REF ULARGE_INTEGER lpFreeBytesToCaller, REF ULARGE_INTEGER lpTotalBytes, REF ULARGE_INTEGER lpTotalFreeBytes ) LIBRARY "kernel32.dll" alias for "GetDiskFreeSpaceExA;Ansi" 

end prototypes

type variables
Public:
boolean									ib_check_jobstate		= true	// 09.10.2015 HR: Neuer Schalter, ob Jobstatus gepr$$HEX1$$fc00$$ENDHEX$$ft werden soll
long										il_maxlock 				= 60 		// 25.10.2011 HR: Auf Instancevariable umgestellt, damit Copy nach Webservice funktioniert

// ---------------------------------------------------
// Folgende Werte m$$HEX1$$fc00$$ENDHEX$$ssen von aussen gesetzt werden:
// ---------------------------------------------------
Integer									iProcessFunction[]				// Hier sind alle Funktionen hinterlegt, welche abgearbeitet werden sollen,
																				// wird nichts hinterlegt, so werden alle Funktionen verarbeitet
Integer									iNumberOfCalculationsToProcess // Anzahl S$$HEX1$$e400$$ENDHEX$$tze die in einem Varbeitungszyklus zu verarbeiten sind

Boolean 									bread_cen_out	= true		// liest cen_out mit nqueued_release_interface = 4/5/7(entsprechend 
																			// dem in sys_queued_fl_function hinterlegtem Wert je Funktion) und schreibt diese in die
																			// Tabelle sys_queued_flight_calc
Datetime									dCheckDate

String 									sService_Name = "cbase_flight_calculation"  	// Name mit dem in cen_out_changes protokolliert wird
String 									sUser_Name = ""  										// Usermit dem in cen_out_changes protokolliert wird

Boolean 									bDoAllwaysMealCalc = True // Bei True: es wird immer eine Mahlzeitengenerierung in uo_generate angestossen
																				// bei False: Anstoss nur bei $$HEX1$$c400$$ENDHEX$$nderungen an Paxen oder in Meal/Extra/Spml-Beladung
Boolean 									bWebservice = False			// Bei True finden bestimmte Pr$$HEX1$$fc00$$ENDHEX$$fungen nicht statt

// ---------------------------------------------------
// nur zu f$$HEX1$$fc00$$ENDHEX$$llen wenn nicht der Einstieg $$HEX1$$fc00$$ENDHEX$$ber of_start/of_process_row erfolgt
// ---------------------------------------------------
Long										lnew_queued_release_interface
Long										lnew_cen_out_nstatus
long										ilJobNr  	
String										sMandant
String 									sviewunit="0000"
Integer									ii_action
Integer									istation_entry

// ---------------------------------------------------
// Ergebnis / Fehlermeldung wird hier abgelegt
// ---------------------------------------------------
Integer									ireturn_error_status				// 0 = kein Fehler, -1 = Fehler
String										sreturn_error_message
String										sreturn_error_message_short
String   									is_web_message = ""   			// 01.03.2011 HR:


// ---------------------------------------------------
// sonstige Variable
// ---------------------------------------------------

long										lResultKeyCenOut
Long										lAirline
Long										lSupplier
Long										lPeriodCostKey
Long										lPeriodDoc

String 									cUnit
String 									cText
String 									cAirline
String									 	cAccount
String 									cClient
Integer									iLockStatus
Integer									iEnableHistory		// 1: es soll eine History geschrieben werden
string 									ssection = "MLBilling"
date										ddeparture
Long										lcounter_SuppUnit

constant integer						i_Status_Release_Pax = 5    	// Freigabe Paxe durch Station
constant integer						i_Status_Release_Flight = 10 	// Freigabe Flug  durch IFMS
Integer									iReleaseStatus			// Freigabestatus des Flugs
constant integer						i_Status_Queued_Release = 1    	// Warten auf Freigabe
constant integer						i_Status_Queued_Interface = 2 	// Warten auf Schnittstellenerstellung
constant integer						i_Status_Queued_Errors = 3 		// Warten auf Fehlerbehebung
constant integer						i_Status_Queued_Web_PaxCalc = 4			// Warten auf Neuberechnung nach Pax$$HEX1$$e400$$ENDHEX$$nderung aus Web
constant integer						i_Status_Queued_Web_MasterChange = 5	// Warten auf Neuberechnung nach Flug/AC-$$HEX1$$c400$$ENDHEX$$nderung aus Web
constant integer						i_Status_Queued_SPML_Load = 7			// Warten auf Neuberechnung nach SPML-$$HEX1$$c400$$ENDHEX$$nderung aus AMOS

// ---------------------------------------
// Datastores
// ---------------------------------------
//------------------------------------------------------------------
// Datastore mit allen Betrieben/Lieferanten-Daten mit den Kennzeichen
// $$HEX1$$fc00$$ENDHEX$$ber automatische Abrechnung und Freigabe (Station/IFMS) und Offset-Tagen
//------------------------------------------------------------------
datastore								dsSupplierUnits

//------------------------------------------------------------------
// Datastore zur Anzeige der relevanten Flug bzw. Periodenereignisse 
// f$$HEX1$$fc00$$ENDHEX$$r eine eine automatische Flugneuberechnung
//------------------------------------------------------------------
datastore								dsJobs
//------------------------------------------------------------------
// Datastore zur Anzeige der relevanten Flugereignisse
// welche auf eine Freigabe bzw. die Schnittstellenerstellung warten
//------------------------------------------------------------------
datastore								dsCenOut
//------------------------------------------------------------------
// Datastore zur Anzeige der relevanten Flugereignisse
// welche auf eine Freigabe bzw. die Schnittstellenerstellung warten
// Separates Datawindow zur Laufzeitoptimierung (eigener Index auf cen_out)
//------------------------------------------------------------------

datastore								dsCenOutheader
datastore								dsHandling
datastore								dsPax
datastore								dsMeals
datastore								dsAddLoading				
datastore								dsSPMLs		
datastore								dsSPMLHeader
datastore								dsText
datastore								dsDeliveryNote
datastore								dsLateOrder
datastore 								dsUserPls

uo_generate_datastore				dsCenOutHandlingNews
uo_generate_datastore				dsCenOutNewsExtra

// Die urspr$$HEX1$$fc00$$ENDHEX$$nglichen Mengen der Extrabeladung und der Mahlzeiten m$$HEX1$$fc00$$ENDHEX$$ssen gemerkt werden
uo_generate_datastore				dsExtraOld
uo_generate_datastore				dsMealOld
uo_generate_datastore				dsSPMLOld
uo_generate_datastore				dsPaxOld
uo_generate_datastore				dsSingleOld

datastore								dsSysQueueFlightPax				// Paxdaten zur Flugneuberechnung
datastore								dsSysQueueFlightACType		// Aircrafttypedaten zur Flugneuberechnung
datastore								dsSysQueueFlightSPML			// Spmldaten zur Flugneuberechnung
datastore								dsSysQueueFlightCalc				// Fl$$HEX1$$fc00$$ENDHEX$$ge zur Flugneuberechnung
																
string										sBillingAirlineCode						//	aktueller Abrechnungs-Airlinecode
string										sClient										// Mandant

uo_suppl_unit_status_release		uo_suppl_unit
//---------------------------------------------------------------
// Erzwingt Mahlzeitenkalkulation:
//---------------------------------------------------------------
Boolean									bForceMealCalculation = False

long										lCalculationCounter = 0			// Z$$HEX1$$e400$$ENDHEX$$hlt die Mahlzeitenkalk. je Transaktion
Boolean									bMealsCalculated
Long										lResultKey_Trace
Integer									iSaveAfterDeparture=1	// Speichern nach $$HEX1$$dc00$$ENDHEX$$berschreiten der Abflugzeit erm$$HEX1$$f600$$ENDHEX$$glichen
Long										lTransActionKey
Integer									iChangeStatus			// Produktionsstatus des Flugs: "Generierung" bis "Abgerechnet"
Integer									iFlightStatus			// Flugstatus: 0 = Scheduled, 1 = Cancelled, 2 = On Request
Boolean									bEnableCommit = true			// Instanz um alle Commit herum
																					// f$$HEX1$$fc00$$ENDHEX$$r Multileg-Change
boolean									bManualChanges = false
Boolean									bTextInfoEdit = false
// Eingabe SPML neue Zeile $$HEX1$$fc00$$ENDHEX$$bernimmt Klasse der vorherigen Zeile
long										lCurrentClassNumber

// 17.10.2005	Problematik: PAX wurde ge$$HEX1$$e400$$ENDHEX$$ndert, es wurde aber keine Neuberechnung durchgef$$HEX1$$fc00$$ENDHEX$$hrt
Boolean									bPaxModified

uo_get_aircraft_config 				uo_configurations

//---------------------------------------------------------------
// Aircraft-Change $$HEX1$$fc00$$ENDHEX$$ber mehrere Legs: Voreinstellungen je Leg
//---------------------------------------------------------------
Boolean									bChangeMultipleLegs = False	// Schalter f$$HEX1$$fc00$$ENDHEX$$r Multi-Leg-Changes
																					// wird in w_master_change gesetzt und veranlasst
																					// Sonderverarbeitung
s_change_multiple_legs 				strMultipleChange 
s_change_multiple_legs				strEmpty

// Eingabe Final Pax darf keinen Masterchange ausl$$HEX1$$f600$$ENDHEX$$sen
integer									iFinalPaxMode = 0
boolean									bAnychange = false

Integer									iUseSequenceForMeals = 1
Datastore								dsRatioCache
Long										lMasterStatus			// In welchem Status befindet sich selektierte Flug
long										lRow_dw_pax

s_handling_text							s_text[2]
String										sChangeType			= "Anwender"
//---------------------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$berwachung von User-Aktivit$$HEX1$$e400$$ENDHEX$$ten bis zum Speichern
//---------------------------------------------------------------
s_changes								strUserChangesEmpty
s_changes								strUserChanges


Boolean									bStatus
Boolean									bChoice
Boolean									bInAction
Boolean									bImportMode			= False		// Wenn externe Flugdaten importiert werden
Boolean									bChangeNoMeals		= False
Boolean									bChangeNoExtra		= False
Boolean									bNoSaving			= False
Boolean									bCancelAction		= False
Boolean									bNewspaperChange	= False
Boolean									bMealChange			= False
Boolean									bDoMealCalculation = False		// verhindert/erzwingt Neuberechnung von Mahlzeiten
Boolean									bMealBillingOnly	= False		// Falls $$HEX1$$c400$$ENDHEX$$nderungen nur Abrechnungsrelevant sind
Boolean									bSPMLBillingOnly	= False		//	Falls $$HEX1$$c400$$ENDHEX$$nderungen nur Abrechnungsrelevant sind
Boolean									bExtraBillingOnly	= False		// Falls $$HEX1$$c400$$ENDHEX$$nderungen nur Abrechnungsrelevant sind
Boolean									bInsertMode			= False		// Manuelle Eingabe von Mahlzeiten/Extras
Boolean									bSPMLInsertMode	= False		// Manuelle Eingabe von SPML

constant integer						i_isStationEntry = 1 // Kennung f$$HEX1$$fc00$$ENDHEX$$r cen_out_pax_cremark dass Erfassung durch Station

uo_generate_datastore			 	dw_single
uo_generate_datastore			 	dw_handling
uo_generate_datastore		 		dw_catering_order

uo_generate_datastore			 	dw_pax
uo_generate_datastore			 	dw_extra
uo_generate_datastore		 		dw_meal
uo_generate_datastore			 	dw_spml
uo_generate_datastore			 	dw_text_info
uo_generate_datastore				dw_text_infos_areas
uo_generate_datastore				dsSPMLDetail				// Aufgel$$HEX1$$f600$$ENDHEX$$ste SPML
uo_generate_datastore		 		dw_recalc_meal_recalc	// TLE 21.01.2010 zus$$HEX1$$e400$$ENDHEX$$tzliche Meals aus Nachkalkulation
uo_generate_datastore		 		dw_recalc_meal			// TLE 21.01.2010 cen_out_Meals, nur $$HEX1$$c400$$ENDHEX$$nderung Nachkalk.mengen
uo_generate_datastore		 		dw_recalc_extra_recalc	// TLE 21.01.2010 zus$$HEX1$$e400$$ENDHEX$$tzliche Meals aus Nachkalkulation
uo_generate_datastore		 		dw_recalc_extra			// TLE 21.01.2010 cen_out_Meals, nur $$HEX1$$c400$$ENDHEX$$nderung Nachkalk.mengen

Datastore								dsPackets					// 17.05.2011 HR:
Datastore								dsProtocolImport			// Das neue Import-Protokoll
Datastore								dsProtocolImportSPML
Datastore								dsProtocolImportSPMLText	// SPMLs mit Zusatztexten
Datastore								dsChangeInformation
Datastore								dsValidSPML				// g$$HEX1$$fc00$$ENDHEX$$ltige SPML je Airline
																			// gleichzeitig: erlaubte Klassen je Airline

Datastore								dsAircaftVersion
Datastore								dsAircaftCurrentVersion
Datastore								dsBillingStatus			// Abrechnungsstatistik (wird bei
																		// Flight-Closed gesetzt)

Datastore								dsValidSPMLDetail		// g$$HEX1$$fc00$$ENDHEX$$ltige SPML aufgrund ausgew$$HEX1$$e400$$ENDHEX$$hltem MZ-Baustein
Datastore								dsSysQueueFunctions	// g$$HEX1$$fc00$$ENDHEX$$ltige Funktionen
Datastore								dsClasses				// g$$HEX1$$fc00$$ENDHEX$$ltige Klassen

// Automatischer Abgleich der Rampen- und K$$HEX1$$fc00$$ENDHEX$$chenzeiten
integer									iTimeAdjustmentPl 
integer									iTimeAdjustmentP1 
integer									iTimeAdjustmentP2 
Long										lCountLegs					// Anzahl der Legs, die zum aktuellen Flug geh$$HEX1$$f600$$ENDHEX$$ren
Long 										lRoutingGroupKey			// RoutingGroupKey

Long										lResultKeyGroup			// Flug-Wechsel feststellen
Long										lLastResultKeyGroup
Long										lVersionGroupKey		// Der Version-Group-Key f$$HEX1$$fc00$$ENDHEX$$r aktuellen Flug

// Versionsabgleich f$$HEX1$$fc00$$ENDHEX$$r Passagierzahlen, Abh$$HEX1$$e400$$ENDHEX$$ngig vom Modus
integer									iVersionCheckPlanung	= 0
integer									iVersionCheckProd1	= 0
integer									iVersionCheckProd2	= 0
integer									iVersionCheckMBox		= 0 	// Soll zur Benachrichtigung 
																					//eine MessageBox aufpoppen?
Integer									iLateOrderComment = 1	// Fenster f$$HEX1$$fc00$$ENDHEX$$r Nachbestellbemerkung in Produktion 2
Boolean									bMultiLegError = false		// falls auf dem Weg etwas nicht klappt															

// ----------------------------------------------
// Registration-Pr$$HEX1$$fc00$$ENDHEX$$fung
// 0 = aus
// 1 = Warnung bei Falscheingabe
// 2 = Falscheigaben zur$$HEX1$$fc00$$ENDHEX$$ckweisen
// ----------------------------------------------
Integer									iRegCheck=0

String										sFlightText
String										sTypeText
// -------------------------------------------------
// Merken der zuletzt gelesenen Keys je datastore
// -------------------------------------------------
Boolean									bReadFromHistory

// --------------------------------------------------------------------------------------------------------------------
// 08.05.2013 HR: Variablen f$$HEX1$$fc00$$ENDHEX$$r die externe Mahlzeitenverteilung
// --------------------------------------------------------------------------------------------------------------------
integer									ii_NumberRunMZVSpawn
string										is_path2mzvspawn
integer									ii_use_mzvspawn
integer									ii_trace_mzvspawn

// --------------------------------------------------------------------------------------------------------------------
// 29.06.2015 HR: Neue Parameter zum L$$HEX1$$f600$$ENDHEX$$schen alter Auftr$$HEX1$$e400$$ENDHEX$$ge
// --------------------------------------------------------------------------------------------------------------------
integer									ii_del_offset_ok			= 7
integer									ii_del_offset_fehler	= 14


// #################################################################
// --------------------------------------------------------------------------------------------------------------------
// AB hier private Variablem
// --------------------------------------------------------------------------------------------------------------------
// #################################################################

private:
DateTime    								dtTimestampFromWeb	
String										isClient  			
integer									iiInvoicingType  
	
long										lCustomerKey
Long										lAircraftKeyCenOut
long										lCountry
String										sCustomer
String										sUnit
String										sError

Integer									iinternal_function
Long										lfunction_queued_release_interface
Integer									ifunction_pax_type
Integer									iFunction_use_as_pax_type
long										lstatus_after_process
long										lstatus_to_process
string										sSaveClass[]
Long										lSavePax[]
Integer									ifunction_actype
Integer									iFunction_use_as_actype
String										sSaveVersClass[]
Long										lSaveVers[]

constant integer						i_sys_sap_interface_key = 10			// Nummer mit der in sys_sap_protocol eingetragen wird

integer   									ii_fill_forecast 				// 10.11.2009 HR: Schalter, ob Forecastzahlen gef$$HEX1$$fc00$$ENDHEX$$llt werden sollen
integer   									ii_job_function 				// 09.06.2010 HR: Funktion des aktuellen Flugs
integer   									ii_actual_flight_status 	// 19.08.2010 HR: Flugstatus
integer   									ii_request_explosion = 0 	//04.03.2011 HR: Nur eine OnlineExplosion pro Flugberechnung
long										il_supplierkey				// 29.11.2011 HR:

uo_request_out 						iuo_request_out 			// 22.07.2013 HR: $$HEX1$$dc00$$ENDHEX$$bernahme aus Flugbrowser
long										lMasterAirlineKey			// 22.07.2013 HR: $$HEX1$$dc00$$ENDHEX$$bernahme aus Flugbrowser
long										lResultKey					// 22.07.2013 HR: $$HEX1$$dc00$$ENDHEX$$bernahme aus Flugbrowser
boolean									ibo_changed				// 22.07.2013 HR: $$HEX1$$dc00$$ENDHEX$$bernahme aus Flugbrowser

uo_message								uo_messages			// Steuerung der $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen

// --------------------------------------------------------------------------------------------------------------------
// 09.03.2015 HR: Anpassungen f$$HEX1$$fc00$$ENDHEX$$r Flightchecker Teil II
// --------------------------------------------------------------------------------------------------------------------
boolean  ib_checkpoint_acchange
boolean  ib_checkpoint_cx
boolean  ib_checkpoint_cx_undo

integer 	ii_log_info 					= 1
integer 	ii_log_fehler 				= 2
integer 	ii_log_warning 				= 3

// --------------------------------------------------------------------------------------------------------------------
// 29.02.2016 HR: CBASE-BRU-CR-2016-002
// --------------------------------------------------------------------------------------------------------------------
string 	is_set  
string 	is_AircraftVersionString 

// WAB
Boolean	ib_wab_send

Boolean	ib_create_docengine_job

datastore								dsSysQueueFlightBob
end variables

forward prototypes
public function integer of_retrieve_dssupplierunits ()
public function integer of_process_row (long lrow)
public function boolean of_lock_record (long arg_lrow)
public function integer of_start ()
public function integer of_write_history (datastore ods)
public function integer of_change_transaction ()
public function integer of_reset_new_flag (datastore ods)
public function integer of_init ()
public subroutine wf_chc_trace (integer iarg_level, string sarg_trace_text)
public function boolean wf_chc_master_change ()
public function integer wf_chc_validation ()
public function boolean wf_ml_rowscopy_pax (datastore dwsource, long lstartrow_source, long lendrow_source, datastore dwtarget, long lstartrow_target)
public function integer wf_chc_add_to_protocol (string arg_message)
public function boolean wf_chc_change_pax (uo_generate_datastore dspax2)
public function boolean wf_chc_change_spml (uo_generate_datastore dsspml)
public function boolean wf_chc_change_newspaper (uo_generate_datastore dschanged_handling, uo_generate_datastore dschanged_extra)
public function boolean wf_chc_change_handling (uo_generate_datastore dschanged)
public function boolean wf_chc_change_extra (uo_generate_datastore dsextra)
public function boolean wf_ml_superrowscopy (datastore dwsource, datastore dwtarget)
public function boolean wf_ml_rowscopy_single (datastore dwsource, long lstartrow_source, long lendrow_source, datastore dwtarget, long lstartrow_target)
public function integer wf_chc_set_old_values ()
public function boolean wf_chc_save ()
public function integer wf_chc_force_meal_calculation ()
public function boolean wf_chc_save_final_pax ()
public function boolean wf_chc_set_changed_status ()
public function long wf_chc_get_history_key ()
public function boolean wf_chc_changed_information ()
public function integer wf_chc_request_explosion ()
public function boolean wf_chc_check_loading_list ()
public subroutine wf_chc_check_loadinglist ()
public subroutine wf_chc_show_changes (datastore dw_changed, string scolumn, long lrow)
public function integer wf_chc_get_differences (long lresult_key)
public function integer w_chc_master_change_selection ()
public function long wf_chc_get_version_group_key ()
public function integer wf_chc_change_aircraft_version (long arg_versiongroupkey)
public function integer wf_chc_create_aircraft_version (long laircraftkey, boolean bmodified)
public function integer wf_chc_check_refund (long arg_customer, long arg_tlc_from, long arg_tlc_to)
public function boolean wf_chc_flight_closed (ref string smessage)
public function integer wf_chc_set_billing_status (long arg_customer)
public function integer wf_chc_validate_spml ()
public function integer of_get_sys_flight_pax (long ljobnr)
public function integer of_get_sys_flight_actype (long ljobnr)
public function integer of_get_sys_flight_spml (long ljobnr)
public function integer of_retrieve_dsjobs (datetime ddate)
public function integer of_lock ()
public function integer of_unlock ()
public function integer of_configuration_to_number (string stext, integer ino)
public function integer of_search_sys_queue_function (integer ifunction)
public function integer of_restore_pax_type ()
public function integer of_pax_type_transfer ()
public function integer of_restore_version ()
public function integer of_version_type_transfer ()
public function integer of_check_finals ()
public function boolean of_recalc_save ()
public function integer of_recalc_set_differences (long lresult_key)
public function boolean wf_ml_rowscopy_meal (datastore dwsource, long lstartrow_source, long lendrow_source, datastore dwtarget, long lstartrow_target)
public function integer of_change_transaction (datastore ad_ds, long al_transaction)
public function integer of_process_mealdistribution (long arg_lrow)
public function integer of_get_resultkeys (long arg_nresult_key, ref long arg_nresult_keys[])
public function boolean wf_transfer_jfe ()
public function integer wf_chc_retrieve_flight (long arg_lresultkey)
public function integer of_process_auto_web_calc_cen_out (long arg_lresult_key)
public subroutine wf_check_pax_comment_changed ()
public function integer wf_tailnumber_checkoff (long arg_nairline_key)
public function boolean of_check_do_aenderungsmitteilung ()
public function integer of_retrieve_dsjobs_new (datetime ddate)
public function integer of_log_jobstate (integer arg_mes_type, string arg_mes_text)
public function boolean wf_chc_check_against_old ()
public function integer of_check_save (boolean ab_oksave, long al_result_key)
public function integer wf_chc_multileg_change (ref string arg_message)
public function integer of_process_meals (long al_job_nr, long al_result_key)
public function boolean wf_chc_change_meals (uo_generate_datastore dsmeals2, uo_generate_datastore dscenmealsdetdeduction)
public function str_actype of_get_actype_structure (long lkey, ref string arg_config)
public function integer wf_regenerate_paclos ()
public function integer wf_wab_send_galleyweights (long al_resultkey)
public function boolean of_recalc_pax (long arg_lrow, ref string arg_sclassname[], ref integer arg_iseatversion[], ref integer arg_iforecast[], ref string arg_sconfiguration, ref long arg_laircraftkey, ref string arg_sregistration, integer arg_iclassnumberbooking[], long arg_lairlinekey)
public function long of_get_version_group_key ()
public function boolean of_recalc_pax_fc ()
public function integer of_process_new_flight (long arg_row)
public function integer wf_regenerate_paclos (date arg_ddeparture, string arg_cairline, long arg_nflight_number, string arg_csuffix, string arg_ctlc_from, string arg_ctlc_to, integer arg_nleg_number, long arg_nresult_key, long arg_nresult_key_group, long arg_nairline_key, date arg_dgeneration_date)
public function integer of_process_freeze (long al_job_nr, long al_result_key)
public function integer of_check_schedule_validity (date arg_ddeparture)
public function integer of_retrieve_bob_figures (long arg_lresult_key)
public function integer of_set_unit_language (string arg_cunit)
public function integer of_process_preprod_freeze (long al_job_nr, long al_result_key)
public function integer of_process_skyscope_copy (long al_result_key)
public function integer of_process_skyscope_refresh (long al_result_key)
end prototypes

public function integer of_retrieve_dssupplierunits ();// -----------------------------------------------------------------------
// Einlesen aller Betriebs/Lieferanten-Daten mit den Kennzeichen
// $$HEX1$$fc00$$ENDHEX$$ber automatische Abrechnung und Freigabe (Station/IFMS)
// -----------------------------------------------------------------------
long l

l=dsSupplierUnits.Retrieve()
lcounter_SuppUnit=dsSupplierUnits.RowCount()
dsSupplierUnits.setFilter("")
dsSupplierUnits.Filter()




return 0
end function

public function integer of_process_row (long lrow);// -----------------------------------------------------------
// Verarbeiten der Zeile(n) aus dsJob
//
// $$HEX1$$dc00$$ENDHEX$$bergeben wird die zu bearbeitende Zeile
// -----------------------------------------------------------
long 		lresult_key, lfound, lreturn
integer	itype, ifunction, istatus, iError, iReturn, iprocess_status
datetime dstart_computing, dt_null
string		a, ls_path

// 04.03.2011 HR: Neuer Flug, dann Schalter wieder zur$$HEX1$$fc00$$ENDHEX$$cksetzen
ii_request_explosion 	= 0

lresult_key     			= dsJobs.GetItemNumber(lrow, "nresult_key")
ifunction       			= dsJobs.GetItemNumber(lrow, "nfunction")
istatus         			= dsJobs.GetItemNumber(lrow, "nstatus")
ierror          			= dsJobs.GetItemNumber(lrow, "nerror")
iprocess_status 		= dsJobs.GetItemNumber(lrow, "nprocess_status") // 29.11.2011 HR:
is_set						= dsJobs.GetItemString(lrow, "cset") // 29.02.2016 HR:

this.ii_action  			= ifunction
this.sMandant   		= dsJobs.GetItemString(lrow, "cclient")
this.ddeparture 		= date(dsJobs.GetItemDateTime(lrow, "ddeparture"))

// 27.02.2019 HR: Wir setzen die Sprache des Betriebs f$$HEX1$$fc00$$ENDHEX$$r die Aufl$$HEX1$$f600$$ENDHEX$$sung
of_set_unit_language(dsJobs.GetItemString(lrow, "cunit"))

// 04.01.2011 HR:
setnull(dt_null)

// --------------------------------------------------------------------------------------------------------------------
// 30.11.2010 HR: Falls ein Flug mehrmals zur Neuberechnung angewiesen
//                wird, dann den Flugstatus aus der History holen oder auf 
//	               1 setzen.
// 17.04.2012, DB: Dies darf nicht bei der Nachkalkulation (ifunction 10) greifen, 
//                 da der Flug sonst wieder auf Update (3) zur$$HEX1$$fc00$$ENDHEX$$ck gesetzt wird, wenn
//                 der Status in der History Closed (6) ist.
// 19.09.2013, TBR: F$$HEX1$$fc00$$ENDHEX$$r Nachkalkulation ifunction von 10 auf 11 ge$$HEX1$$e400$$ENDHEX$$ndert
// --------------------------------------------------------------------------------------------------------------------
// if istatus = 0 and ifunction <> 10 then
if istatus = 0 then

	// --------------------------------------------------------------------------------------------------------------------
	// 11.12.2015 HR: F$$HEX1$$fc00$$ENDHEX$$r Function 11 ist der Status = 8
	// --------------------------------------------------------------------------------------------------------------------
	if  ifunction <> 11 then
		select nstatus 
		  into :istatus 
		  from cen_out_history 
		 where nresult_key = :lresult_key 
			and ntransaction in (select max(coh.ntransaction) 
										  from cen_out_history coh 
										 where nresult_key=:lresult_key 
											and nstatus<> 0);
		
		if sqlca.sqlcode <> 0 then istatus = 1
	else
		istatus = 8
	end if
end if

// 09.06.2010 HR: Funktion in der Instanzvariablen sichern
ii_job_function 								= ifunction

dstart_computing                   			= dsJobs.GetItemDateTime(lrow, "dstart_computing")
this.lnew_queued_release_interface 	= dsJobs.GetItemNumber(lrow, "sys_queue_flight_calc_nqueued_release_interface")
this.lnew_cen_out_nstatus          		= dsJobs.GetItemNumber(lrow, "nstatus")
this.sUser_Name                    			= dsJobs.GetItemString(lRow,"sys_queue_flight_calc_cuser")
this.istation_entry                			= dsJobs.GetItemNumber(lrow, "sys_queue_flight_calc_nstation_entry")
this.il_supplierkey                			= dsJobs.GetItemNumber(lrow, "sys_units_nsupplier_key") // 29.11.2011 HR:

		  
// --------------------------------------------------------------------------------------------------------------------
// 09.03.2015 HR: Anpassungen f$$HEX1$$fc00$$ENDHEX$$r Flightchecker Teil II
// --------------------------------------------------------------------------------------------------------------------
ib_checkpoint_acchange					= False
ib_checkpoint_cx							= False
ib_checkpoint_cx_undo					= False

// -----------------------------------------------------------
// Nur noch nicht verarbeitete S$$HEX1$$e400$$ENDHEX$$tze nehmen (nerror is NULL)
// -----------------------------------------------------------

//if isNull(iError) then
if iprocess_status = 1 or iprocess_status = 4 then // 29.11.2011 HR:		// TSC: ProcessStatus 4 = retry
	if ifunction = 18 or ifunction = 19 then
		// --------------------------------------------------------------------------------------------------------------------
		// 20.02.2020 HR: Alm-ID 5774: Neue Funktion f$$HEX1$$fc00$$ENDHEX$$r Copy/Refresh Skyscope Fl$$HEX1$$fc00$$ENDHEX$$ge 
		// --------------------------------------------------------------------------------------------------------------------
		this.dsJobs.SetItem(lRow, "dstart_computing", DateTime(Today(), Now()))
		this.ilJobNr 					= dsJobs.GetItemNumber(lrow, "njob_nr")
		
		if ifunction = 18 then
			lreturn = of_process_skyscope_copy(lresult_key)
		else
			lreturn = of_process_skyscope_refresh(lresult_key)
		end if
		
		if lreturn = 1 then
			dsJobs.SetItem(lRow, "nerror", 1)
			dsJobs.SetItem(lRow, "nprocess_status",3) 
		else
			dsJobs.SetItem(lRow, "nerror", 2)
			dsJobs.SetItem(lRow, "nprocess_status",9) 
		end if
		this.dsJobs.SetItem(lRow, "cerror", this.sreturn_error_message_short)
		this.dsJobs.SetItem(lRow, "dstop_computing", f_jetzt())
		this.dsJobs.update()
		commit;
	elseif ifunction = 14 then
		// --------------------------------------------------------------------------------------------------------------------
		// 30.05.2016 HR: F$$HEX1$$fc00$$ENDHEX$$r neu angelegte Fl$$HEX1$$fc00$$ENDHEX$$ge im Web werden hier die Daten dem Flug zugespielt
		// --------------------------------------------------------------------------------------------------------------------
		
		if of_process_new_flight( lrow) = 1 then
			// ------------------------------------------------------------------------
			// Doc Gen Queue (Einstellen Result Key in cen_doc_gen_queue)
			// ------------------------------------------------------------------------
			uo_doc_gen_queue luo_doc_gen_queue
			If ib_create_docengine_job = TRUE Then
				luo_doc_gen_queue = create uo_doc_gen_queue
				luo_doc_gen_queue.bCommit = bEnableCommit
				luo_doc_gen_queue.of_enqueue_flight(lresult_key)
				destroy luo_doc_gen_queue
			End if
			
			update cen_out 
				set nstatus=:istatus 
			where nstatus=0 and
					nresult_key = :lresult_key;
					
					
			if sqlca.sqlcode=0 then
				f_Log2Csv(0,2,"[of_process_row] Staus des Fluges von 0 auf "+string(istatus)+" gesetzt")

				dsJobs.SetItem(lRow, "nerror", 1)
				dsJobs.SetItem(lRow, "nprocess_status",3) 
				
				commit;
			else
				f_Log2Csv(0,2,"[of_process_row] Fehler Staus$$HEX1$$e400$$ENDHEX$$nderung des Fluges von 0 auf "+string(istatus)+": "+string(sqlca.sqlcode)+" "+sqlca.sqlerrtext)

				return 0
			end if							
		else
				dsJobs.SetItem(lRow, "nerror", 2)
				dsJobs.SetItem(lRow, "nprocess_status",9) 
		end if
		
	// -----------------------------------------------------------
	/* Funktionen:
		1/6: Alles rechnen in Abh. der Zusatz-Tabellen (PAX/SPML/ACTYPE)
		2: Web-Anstoss $$HEX1$$fc00$$ENDHEX$$ber nqueued_release_interface = 4 (Mit History)
		3: Web-Anstoss mit Aircraft-Change $$HEX1$$fc00$$ENDHEX$$ber nqueued_release_interface = 5 (Mit History)
		4: SPML-AMOS $$HEX1$$fc00$$ENDHEX$$ber nqueued_release_interface = 7 (Mit History)
		5: rechnen automat. Abrechn. ??? 
	*/  	
	// Ermittle interne Funktion zu Funktion
	// -----------------------------------------------------------
	elseif of_search_sys_queue_function(ifunction) = 0 then
		if this.iinternal_function = 1 or &
		  	this.iinternal_function = 2 or &
		 	this.iinternal_function = 3 or &
		 	this.iinternal_function = 4 or &
		 	ifunction = 12 or &
		 	ifunction = 15 or ifunction = 17 then

			if bReadFromHistory and  this.dsJobs.GetItemNumber(lRow, "sys_queue_flight_calc_nhistory")=0 then
				// --------------------------------------------------------------------------------------------------------------------
				// 13.06.2011 HR:
				// --------------------------------------------------------------------------------------------------------------------
				bReadFromHistory = False
				f_Log2Csv(0,2,"[of_process_row] bReadFromHistory is set to false")
			elseif not bReadFromHistory and  this.dsJobs.GetItemNumber(lRow, "sys_queue_flight_calc_nhistory")=1 then
				// --------------------------------------------------------------------------------------------------------------------
				// 02.04.2015 HR: Wenn im Jobauftrag gesagt wird, dass die History gelesen werden soll, dann machen wir das auch
				// --------------------------------------------------------------------------------------------------------------------
				bReadFromHistory = True
				f_Log2Csv(0,2,"[of_process_row] bReadFromHistory is set to true")
			end if
			
			this.dsJobs.SetItem(lRow, "dstart_computing", DateTime(Today(), Now()))
			// -----------------------------------------------------------
			// Wert in sys_queue_fl_function $$HEX1$$fc00$$ENDHEX$$berschreibt ggf. Ziel-nstatus-Wert
			// aus sys_queue_flight_calc
			// -----------------------------------------------------------
			if this.lstatus_after_process > 0 then
				lnew_cen_out_nstatus = this.lstatus_after_process 
			else
				// 17.12.2009 HR:
				lnew_cen_out_nstatus = istatus
			end if
			
			if isNull(dsJobs.GetItemNumber(lrow, "nflight_number")) then
				iReturn = -1
				this.sreturn_error_message = ": cen_out_result_key " + string(lresult_key) + " does not exist anymore"
				this.sreturn_error_message_short = "cen_out_result_key " + string(lresult_key) + " does not exist anymore"
	            	this.is_web_message = uf.translate("Flug nicht gefunden") //28.02.2011 HR: Fehlermeldung f$$HEX1$$fc00$$ENDHEX$$r WEBService
				
				of_log_jobstate(ii_log_fehler, this.is_web_message) // 12.03.2015 HR: Logging eingebaut
				
				this.ireturn_error_status = -1
			else
				iReturn = of_process_auto_web_calc_cen_out(lresult_key)
			end if
			
			if iReturn >= 0 then
				if ii_actual_flight_status=0 and this.ireturn_error_status = -1 then
					
					update cen_out 
						 set nstatus=:iChangeStatus 
					 where nstatus=0 and
						 	  nresult_key = :lresult_key;
							
					if sqlca.sqlcode=0 then
						f_Log2Csv(0,2,"[of_process_row] Staus des Fluges von 0 auf "+string(iChangeStatus)+" gesetzt")

						dsJobs.SetItem(lRow, "nerror", 1)
						dsJobs.SetItem(lRow, "nprocess_status",3) // 29.11.2011 HR:
						
						commit;
					else
						f_Log2Csv(0,2,"[of_process_row] Fehler Staus$$HEX1$$e400$$ENDHEX$$nderung des Fluges von 0 auf "+string(iChangeStatus)+": "+string(sqlca.sqlcode)+" "+sqlca.sqlerrtext)

						return 0
					end if
				else
					dsJobs.SetItem(lRow, "nerror", 1)
					dsJobs.SetItem(lRow, "nprocess_status",3) // 29.11.2011 HR:
				end if
			else
				// --------------------------------------------------------------------------------------------------------------------
				// 04.01.2011 HR: Falls der Flug gelocked ist, dann sp$$HEX1$$e400$$ENDHEX$$ter nochmal probieren
				// --------------------------------------------------------------------------------------------------------------------
				if iReturn = -10 then
					return 1
				else
					dsJobs.SetItem(lRow, "nerror", 2)
					dsJobs.SetItem(lRow, "nprocess_status",9) // 29.11.2011 HR:
				end if
			end if
			
			if this.ireturn_error_status = 0 then
				f_Log2Csv(0,1,"[of_process_row] "+ this.sreturn_error_message)
			else
				f_Log2Csv(0,2,"[of_process_row] "+ this.sreturn_error_message)
			end if	
	
			this.dsJobs.SetItem(lRow, "dstop_computing", DateTime(Today(), Now()))
			this.dsJobs.SetItem(lRow, "cmodified", "processed")

// 04.01.2011 HR:
//			this.dsJobs.SetItem(lRow, "cerror", this.sTypeText  +this.sreturn_error_message)
			this.dsJobs.SetItem(lRow, "cerror", this.sreturn_error_message_short)
		
		// --------------------------------------------------------------------------------------------------------------------
		// 28.05.2010 HR: Neue Funktion 8: Flug l$$HEX1$$f600$$ENDHEX$$schen
		// --------------------------------------------------------------------------------------------------------------------
		elseif ifunction=8 then
		
			this.dsJobs.SetItem(lRow, "dstart_computing", DateTime(Today(), Now()))
		
			delete from cen_out where nresult_key = :lresult_key;
			
			if sqlca.sqlcode=0 then
				this.sreturn_error_message = "Flight deleted"
	           	this.is_web_message = uf.translate("Flug gel$$HEX1$$f600$$ENDHEX$$scht") //28.02.2011 HR: Fehlermeldung f$$HEX1$$fc00$$ENDHEX$$r WEBService
				
				of_log_jobstate(ii_log_info, this.is_web_message) // 12.03.2015 HR: Logging eingebaut

				dsJobs.SetItem(lRow, "nerror", 1)
				dsJobs.SetItem(lRow, "nprocess_status",3) // 29.11.2011 HR:
			else
				this.sreturn_error_message = "Error "+string(sqlca.sqlcode)
 	            	this.is_web_message = "Error "+string(sqlca.sqlcode) //28.02.2011 HR: Fehlermeldung f$$HEX1$$fc00$$ENDHEX$$r WEBService
				
				of_log_jobstate(ii_log_fehler, this.is_web_message) // 12.03.2015 HR: Logging eingebaut

				dsJobs.SetItem(lRow, "nerror", 2)
				dsJobs.SetItem(lRow, "nprocess_status",9) // 29.11.2011 HR:
			end if
			// 04.01.2011 HR:
			this.sreturn_error_message_short = this.sreturn_error_message
			
			this.dsJobs.SetItem(lRow, "dstop_computing", DateTime(Today(), Now()))
			this.dsJobs.SetItem(lRow, "cmodified", "processed")
			this.dsJobs.SetItem(lRow, "cerror", this.sTypeText  +this.sreturn_error_message_short)
			
			f_Log2Csv(0,1,"[of_process_row] Flight Delete Result: "+this.sreturn_error_message )
			
			// 14.01.2013 HR: Beim L$$HEX1$$f600$$ENDHEX$$schen eines Fluges werden auch die Auftr$$HEX1$$e400$$ENDHEX$$ge aus der QUEUE gel$$HEX1$$f600$$ENDHEX$$scht, daher
			//                        darf dieser nicht versucht werden zu speichern
		
		//MB 20.08.2015: Gibt keinen Foreign Key mehr, daher m$$HEX1$$fc00$$ENDHEX$$ssen wir hier doch speichern:
		
		//	this.dsJobs.setitemstatus( lRow, 0, PRIMARY!, NotModified!) 
			
		// --------------------------------------------------------------------------------------------------------------------
		// 20.11.2012 HR: Neue Funktion 10: Mahlzeitenverteilung eines Fluges speichern
		// 19.09.2013, TBR: F$$HEX1$$fc00$$ENDHEX$$r Nachkalkulation ifunction von 10 auf 11 ge$$HEX1$$e400$$ENDHEX$$ndert		
		// 04.04.2016 HR: Wieder 10
		// --------------------------------------------------------------------------------------------------------------------
		elseif  ifunction=10 then
			select nstatus 
			  into :iChangeStatus 
			  from cen_out 
			 where nresult_key = :lresult_key ;
		
			if ii_use_mzvspawn=1 then
				
				// 17.01.2019 HR: Bereits gestartete nicht noch mal starten
				if this.dsJobs.GetItemNumber(lRow, "nprocess_status") = 2 then 
					// 17.06.2019 HR: Wenn Job l$$HEX1$$e400$$ENDHEX$$nger als gl_max_mzv_run Sekunden l$$HEX1$$e400$$ENDHEX$$uft, dann gehen wir davon aus, dass er nicht mehr fertig wird und setzen ihn auf Fehler
					if f_dt_diff(dsJobs.GetItemDateTime(lRow, "dstart_computing"), f_jetzt()) > gl_max_mzv_run then
						this.dsJobs.SetItem(lRow, "dstop_computing", f_jetzt())
						this.dsJobs.SetItem(lRow, "nprocess_status",10)
						this.dsJobs.update()
						commit;

						f_Log2Csv(0,1,"[of_process_row] Job set to ignore, because runtime of job is longer than "+string(gl_max_mzv_run)+" sec. Sent to cbase_mzv_spawn at " + string(dsJobs.GetItemDateTime(lRow, "dstart_computing")))
					else	
						f_Log2Csv(0,1,"[of_process_row] Job send to cbase_mzv_spawn at " + string(dsJobs.GetItemDateTime(lRow, "dstart_computing")))
					end if
					return 0
				end if
				
				// --------------------------------------------------------------------------------------------------------------------
				// 08.05.2013 HR: Neuer Versuch mit externem Programm
				// --------------------------------------------------------------------------------------------------------------------
				if fileexists(this.is_path2mzvspawn+"cbase_mzv_spawn.exe") then				
					if this.dsJobs.getitemnumber(lRow, "comp_sum_open_mlzspawn") < this.ii_numberrunmzvspawn then
						long ll_count
						
						select count(*) 
						   into :ll_count
						  from sys_queue_flight_calc
						where nresult_key = :lresult_key
						    and nfunction = 10
							and nprocess_status = 2;
					
						IF sqlca.sqlcode < 0 THEN
							f_Log2Csv(0,1,"[of_process_row] Error checking Flight Jobs: " + string(sqlca.sqlcode))
						elseif ll_count = 0 then
						
							ls_path			= ProfileString(sProfile, "PARAMETERS", "PathToINI", GetCurrentDirectory())
							if right(ls_path,1)<> "\" then ls_path+="\"
							SetProfileString(sProfile, "PARAMETERS", "PathToINI", ls_path)
							
							a = this.is_path2mzvspawn+"cbase_mzv_spawn"
							a += " /jobkey="+string(this.dsJobs.getitemnumber(lRow, "njob_nr"))
							a += " /profile="+ls_path+sProfile
							a += " /parm="+sInstance+"_"+string(this.dsJobs.getitemnumber(lRow, "njob_nr"))
							a += " /trace="+string(ii_trace_mzvspawn)
							
							if run(a) = 1 then
								this.dsJobs.SetItem(lRow, "dstart_computing", DateTime(Today(), Now()))
								this.dsJobs.SetItem(lRow, "nprocess_status",2)

								this.dsJobs.update()
								commit;
	
								f_Log2Csv(0,1,"[of_process_row] Mealdistributuion: Start  ("+string(this.dsJobs.getitemnumber(lRow, "comp_sum_open_mlzspawn")) +") "+a)
								sleep(2)
								yield()
								
							else
								f_Log2Csv(0,1,"[of_process_row] Mealdistributuion: Error while starting "+a)
								this.is_web_message = "Error start Mealdistribution"
		
								of_log_jobstate(ii_log_fehler, this.is_web_message) // 12.03.2015 HR: Logging eingebaut
		
								dsJobs.SetItem(lRow, "nerror", 2)
								dsJobs.SetItem(lRow, "nprocess_status",9)
								this.dsJobs.update()
								commit;
							end if
						else
							f_Log2Csv(0,1,"[of_process_row] Mealdistributuion: Job defered, because another MZV Spawn is running for this flight")
						end if
					else
						f_Log2Csv(0,1,"[of_process_row] Mealdistributuion: Still "+string(ii_numberrunmzvspawn) +" cbase_mzv_spawn processes running" )
					end if
				else
					f_Log2Csv(0,1,"[of_process_row] Mealdistributuion: File " + this.is_path2mzvspawn+"cbase_mzv_spawn.exe not found")
				end if
				return 0
			else
				// --------------------------------------------------------------------------------------------------------------------
				// 08.05.2013 HR: Alte Function
				// --------------------------------------------------------------------------------------------------------------------
	
				this.dsJobs.SetItem(lRow, "dstart_computing", DateTime(Today(), Now()))
				a = dsJobs.GetItemString(lRow, "cairline") + String(dsJobs.GetItemNumber(lRow, "nflight_number")) + ","
				
				if pos(gsFunction10ExcludeFlights, a)>0 then
					this.sreturn_error_message = "Flight in Exlusionlist"
					this.is_web_message = "Flight in Exclusionlist"

					of_log_jobstate(ii_log_warning, this.is_web_message) // 12.03.2015 HR: Logging eingebaut

					dsJobs.SetItem(lRow, "nerror", 2)
					dsJobs.SetItem(lRow, "nprocess_status",9)
	
				else
					if of_process_mealdistribution(lrow) = 1 then
						this.sreturn_error_message = "Mealdistribution saved"
						this.is_web_message = uf.translate("Mahlzeitenverteilung gespeichert")

						of_log_jobstate(ii_log_info, this.is_web_message) // 12.03.2015 HR: Logging eingebaut
						
						dsJobs.SetItem(lRow, "nerror", 1)
						dsJobs.SetItem(lRow, "nprocess_status",3)
					else
						//this.sreturn_error_message = "Error during Mealdistribution"
						this.is_web_message = "Error during Mealdistribution"

						of_log_jobstate(ii_log_fehler, this.is_web_message) // 12.03.2015 HR: Logging eingebaut

						dsJobs.SetItem(lRow, "nerror", 2)
						dsJobs.SetItem(lRow, "nprocess_status",9)
					end if
				end if			
				garbagecollect()
				
				this.sreturn_error_message_short = this.sreturn_error_message
				
				this.dsJobs.SetItem(lRow, "dstop_computing", DateTime(Today(), Now()))
				this.dsJobs.SetItem(lRow, "cmodified", "processed")
				this.dsJobs.SetItem(lRow, "cerror", this.sTypeText  +this.sreturn_error_message_short)
				
				f_Log2Csv(0,1,"[of_process_row] Mealdistributuion for Flight: "+this.sreturn_error_message )
				
				return 0
			end if
		else
			f_Log2Csv(0,2,"[of_process_row] Unknown internal function " + String(this.iinternal_function))
			dsJobs.SetItem(lRow, "nerror", 2)
			dsJobs.SetItem(lRow, "nprocess_status",9) // 29.11.2011 HR:
			this.dsJobs.SetItem(lRow, "cerror", this.sTypeText + ": Unknown internal function " + String(this.iinternal_function))

		end if
	else
			f_Log2Csv(0,2,"[of_process_row] function " + String(ifunction) + " not found in SYS_FLIGHT_FL_FUNCTION")
			dsJobs.SetItem(lRow, "nerror", 2)
			dsJobs.SetItem(lRow, "nprocess_status",9) // 29.11.2011 HR:
			
			this.dsJobs.SetItem(lRow, "cerror", this.sTypeText + ": function " + String(ifunction) + " not found in SYS_FLIGHT_FL_FUNCTION")

	end if
	
	if dstart_computing = dsJobs.GetItemDateTime(lrow, "dstart_computing") then
		this.dsJobs.SetItem(lRow, "cmodified", "ignored")
	end if
elseif dsJobs.GetItemNumber(lRow, "nprocess_status")=2 and ifunction=10 then
	// 17.06.2019 HR: Wenn Job l$$HEX1$$e400$$ENDHEX$$nger als gl_max_mzv_run Sekunden l$$HEX1$$e400$$ENDHEX$$uft, dann gehen wir davon aus, dass er nicht mehr fertig wird und setzen ihn auf Fehler
	if f_dt_diff(dsJobs.GetItemDateTime(lRow, "dstart_computing"), f_jetzt()) > gl_max_mzv_run then
		this.dsJobs.SetItem(lRow, "dstop_computing", f_jetzt())
		this.dsJobs.SetItem(lRow, "nprocess_status",10)
		this.dsJobs.update()
		commit;
	
		f_Log2Csv(0,1,"[of_process_row] Job set to ignore, because runtime of job is longer than "+string(gl_max_mzv_run)+" sec. Sent to cbase_mzv_spawn at " + string(dsJobs.GetItemDateTime(lRow, "dstart_computing")))
	else	
		f_Log2Csv(0,1,"[of_process_row] Job send to cbase_mzv_spawn at " + string(dsJobs.GetItemDateTime(lRow, "dstart_computing")))
	end if
end if	

return 0
end function

public function boolean of_lock_record (long arg_lrow);//==========================================================================================
//
// of_lock_record
//
// Versucht aktuellen Datensatz zu sperren
//
//==========================================================================================
long 		lUpdateKey
long 		lLockKey
datetime	dtTimeStamp

If arg_lrow <= 0 Then 
	iLockStatus = 0
	// -------------------------------------
	// Rekord-Lock aufheben
	// -------------------------------------
	commit;
	Return True
End if

// -------------------------------------
// Rekord-Lock aufheben
// -------------------------------------
commit;

// -------------------------------------
// Rekord-Lock erstellen
// -------------------------------------	
dtTimeStamp	= datetime(date(today()),time(now()))
lLockKey 	= arg_lrow
SELECT cen_out.nresult_key  
  INTO :lUpdateKey  
  FROM cen_out  
 WHERE cen_out.nresult_key = :lLockKey   
 For Update NOWAIT;

// -------------------------------------
// "ORA-0054 ERROR: resource is busy"
// -------------------------------------
If SQLCA.SQLCODE <> 0 Then
	iLockStatus = 1
//	uo_StatusBar.of_SetText( 0, 0, uf.translate("Flug ist von anderem Anwender gesperrt.")) 		
	return False
Else
	iLockStatus = 0
	return True
End if

return false

end function

public function integer of_start ();/* 
* Funktion:			of_start
* Beschreibung: 	 Einstiegsfunktion
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 	Wer					Wann			Was und warum
*	1.1		Thomas Schaefer	10.08.2016	Job Status 4 eingebaut
*
* Return Codes:
*	 -1		fehler
* 	1		sonst
*
*/

// -----------------------------------------------
//
// Einstiegsfunktion
// von hier aus alle Pr$$HEX1$$fc00$$ENDHEX$$fungen ausf$$HEX1$$fc00$$ENDHEX$$hren
//
// -----------------------------------------------
Long 		lRows, lreturn
String		sFlight
Long 		lStart, lStop
Integer  	iSuccess
Integer 	iFunction
Integer   ierror
String		serrortext


/* Funktionen:
1: Alles rechnen in Abh. der Zusatz-Tabellen (PAX/SPML/ACTYPE)
2: Web-Anstoss $$HEX1$$fc00$$ENDHEX$$ber nqueued_release_interface = 4 (Mit History)
3: Web-Anstoss mit Aircraft-Change $$HEX1$$fc00$$ENDHEX$$ber nqueued_release_interface = 5 (Mit History)
4: SPML-AMOS $$HEX1$$fc00$$ENDHEX$$ber nqueued_release_interface = 7 (Mit History)
5: rechnen automat. Abrechn. ??? 
*/  

lrows = dsJobs.RowCount()

// 20.03.2013 HR: Filter auf Instance Setzen
dsJobs.Setfilter("cinstance ='"+ sInstance+"'")
dsJobs.Filter()
dsJobs.sort()

// 26.04.2010 HR: Wenn nichts zu tun, dann Meldung
if lrows=0 then f_Log2Csv(0,5,"[of_start] No flights to calculate") 
	
For lRows = 1 to dsJobs.RowCount()
	if dsJobs.GetItemString(lrows, "cinstance") <> sInstance  then continue

	if iSuccess >= iNumberOfCalculationsToProcess then exit
	
	// -----------------------------------------------------------------
	// jobnummer identifizieren (nur zur protokollierung ben$$HEX1$$f600$$ENDHEX$$tigt) 
	// -----------------------------------------------------------------
	// -----------------------------------------------------------------
	// flug identifizieren
	// -----------------------------------------------------------------
	this.lResultKeyCenOut 	= dsJobs.GetItemNumber(lRows, "nresult_key")
	this.ilJobNr 					= dsJobs.GetItemNumber(lRows, "njob_nr")
	this.sFlightText 			= dsJobs.GetItemString(lRows, "cairline") + " " + String(dsJobs.GetItemNumber(lRows, "nflight_number"))   + &
										dsJobs.GetItemString(lRows, "csuffix") + "/" + &
										String(dsJobs.GetItemDatetime(lRows, "ddeparture"),"DD.MM.YYYY" ) +  "/" + &
										dsJobs.GetItemString(lRows, "cen_out_ctlc_from") + "-" + & 
										dsJobs.GetItemString(lRows, "cen_out_ctlc_to") + &
										"/" + dsJobs.GetItemString(lRows, "cunit") + "(" + String(this.lResultKeyCenOut ) + ")"   
	if isNull(this.sFlightText) then 
		this.sFlightText = ">> Flight not found for result_key " + String(this.lResultKeyCenOut ) + " <<"
	end if

	// 05.05.2017 HR: DocEngine-Job am Ende des Jobs erstellen 
	ib_create_docengine_job = ( dsJobs.GetItemNumber(lRows, "ncreatedocenginejob") = 1 )

	f_Log2Csv(0,99,"[of_start] -------------------------------------------------------------")
	f_Log2Csv(0,99,"[of_start]        S T A R T I N G   J O B -> " + string(this.ilJobNr) + " for flight " + sFlightText) 
	f_Log2Csv(0,99,"[of_start]        Function: " + string(dsJobs.GetItemNumber(lRows, "nfunction")))
	f_Log2Csv(0,99,"[of_start] -------------------------------------------------------------")

	//f_log2db(this.ilJobNr, this.lResultKeyCenOut,1,"Result_Key gefunden: " + string(this.lResultKeyCenOut), 5)
	f_log2csv(0,1,"[of_start] Result_Key "  + string(this.lResultKeyCenOut) + " in row " + string(lRows) + " of " + string(dsJobs.RowCount()))

	// 09.10.2015 HR: Wir pr$$HEX1$$fc00$$ENDHEX$$fen ggf. erst mal, ob der Job noch den richtigen Status hat 
	if ib_check_jobstate then
		iFunction = -1
		
		SELECT sys_queue_flight_calc.nprocess_status  
				INTO :iFunction  
			FROM sys_queue_flight_calc  
		 WHERE sys_queue_flight_calc.njob_nr = :this.ilJobNr;
		 
		if sqlca.sqlcode <> 0 then
			f_log2csv(0,1,"[of_start] Flight ignored: Error finding jobstate "  + string(sqlca.sqlcode) + " " + sqlca.sqlerrtext)
			continue
		elseif 	isnull(iFunction) or iFunction = -1 then
			f_log2csv(0,1,"[of_start] Flight ignored: State not found")
			continue
		elseif iFunction >= 3 and iFunction <> 4 then
			f_log2csv(0,1,"[of_start] Flight ignored: 	New State: "+ string(iFunction))
			continue
		end if
	end if
	
	// -----------------------------------------------------------------
	// Was f$$HEX1$$fc00$$ENDHEX$$r ein JobTyp steht an
	// -----------------------------------------------------------------
	iFunction = dsJobs.GetItemNumber(lRows, "nfunction")
	
	ii_fill_forecast = dsJobs.GetItemNumber(lRows, "sys_queue_flight_calc_nforecast")
	
	// -------------------------------------------------------------------------------------------------
	//  Neurechnung Flug
	// -------------------------------------------------------------------------------------------------
	lStart = CPU()
	lreturn = of_process_row(lrows)
	lStop  = CPU()	

	f_Log2Csv(0,1,"[of_start] Flight Calculation " + this.sFlightText + " took " + string((lStop - lStart) / 1000, "0.000") + " sec.")
	// -------------------------------------------------------------------------------------------------
	// Meldung $$HEX1$$fc00$$ENDHEX$$ber Ergebnis in Protokoll-Db schreiben
	// -------------------------------------------------------------------------------------------------
	if lTraceLevel >= 2 then
		ierror = 0
		serrortext = this.sTypeText + " processed ok for flight " + this.sflighttext + "(JobNr:" + String(this.ilJobNr) + " Instance:" + sInstance + ")"
		if this.ireturn_error_status <> 0 then
			ierror = 2
			serrortext = this.sTypeText + " Error occured for flight " + this.sflighttext + "(JobNr:" + String(this.ilJobNr) + " Instance:" + sInstance + " ErrorMsg: " + this.sreturn_error_message + ")"
		end if
		f_set_service_protocol(i_sys_sap_interface_key, ierror, this.sFlightText, serrortext)

	end if	

	if this.dsJobs.Update() <> 1 then
		f_set_service_protocol(i_sys_sap_interface_key, ierror, this.sFlightText, this.sTypeText + " Error[2] updating job list ")

		f_Log2Csv(0,1,"[of_start] Failed to update dsJobs for " +  sFlight + "(JobNr:" + String(this.ilJobNr) + " Instance:" + sInstance + ")")
		f_Log2Csv(0,1,"[of_start] Error: " + sqlca.sqlerrtext)
		rollback;
		continue;
	end if
		
	Commit;

	if lreturn = 0 then iSuccess ++
Next

// 20.03.2013 HR: Filter wieder l$$HEX1$$f600$$ENDHEX$$schen
dsJobs.Setfilter("")
dsJobs.Filter()




return 0
end function

public function integer of_write_history (datastore ods);// ---------------------------------------------------------
// History schreiben
// ---------------------------------------------------------

String	sTableName
Integer	i

if oDS.RowCount() = 0 then return 0

oDS.ResetUpdate()
sTableName	= oDS.Object.DataWindow.Table.UpdateTable

For i = 1 to oDS.Rowcount()
	oDS.Setitemstatus(i,0,Primary!,NewModified!)
Next
if  sTableName = "cen_out_period_detail" then

	oDS.Object.DataWindow.Table.UpdateTable = "cen_out_period_det_hist"
else
	oDS.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
end if

If oDS.update() = -1 Then
	rollback ;
	oDS.Object.DataWindow.Table.UpdateTable = sTableName
	return -1
Else
	oDS.Object.DataWindow.Table.UpdateTable = sTableName
End if

return 0
end function

public function integer of_change_transaction ();// --------------------------------------------------
// History schreiben vorbereiten
// --------------------------------------------------
// Wenn die History geschrieben werden soll, dann
// die Transaktionsnummmer hochz$$HEX1$$e400$$ENDHEX$$hlen und die ganzen 
// Datastores retrieven lassen, die daf$$HEX1$$fc00$$ENDHEX$$r gebraucht
// werden 
// --------------------------------------------------
Long I
Long lTransaction

lTransaction = f_Sequence ("seq_cen_out_history",sqlca)

If  lTransaction = -1 Then
//	 	uf.mbox ("Datenbankfehler", "Es konnte kein eindeutiger Schl$$HEX1$$fc00$$ENDHEX$$ssel (Sequence) ermittelt werden.~r~r" + &
//										 "Keine Neuanlage m$$HEX1$$f600$$ENDHEX$$glich.", StopSign!)
	 return -1
End if	
	
// --------------------------------------------------
// Der Kopfsatz
// --------------------------------------------------
dsCenOutheader.SetItem(1, "ntransaction", lTransaction)

// --------------------------------------------------
// Die Passagierzahlen
// --------------------------------------------------
for i = 1 to this.dsPax.RowCount()
	this.dsPax.SetItem(i, "ntransaction", lTransaction)
next

//  f_print_datastore(this.dsPax)

// --------------------------------------------------
// Das Handling
// --------------------------------------------------
for i = 1 to this.dsHandling.RowCount()
	this.dsHandling.SetItem(i, "ntransaction", lTransaction)
next

// --------------------------------------------------
// Die Meals
// --------------------------------------------------
for i = 1 to this.dsMeals.RowCount()
	this.dsMeals.SetItem(i, "ntransaction", lTransaction)
next

// --------------------------------------------------
// Die Extrabeladung
// --------------------------------------------------
for i = 1 to this.dsAddLoading.RowCount()
	this.dsAddLoading.SetItem(i, "ntransaction", lTransaction)
next

// --------------------------------------------------
// Die SPML's
// --------------------------------------------------
for i = 1 to this.dsSPMLHeader.RowCount()
	this.dsSPMLHeader.SetItem(i, "ntransaction", lTransaction)
next

for i = 1 to this.dsSPMLs.RowCount()
	this.dsSPMLs.SetItem(i, "ntransaction", lTransaction)
next

// --------------------------------------------------
// Die Textinfo
// --------------------------------------------------
for i = 1 to this.dsText.RowCount()
	this.dsText.SetItem(i, "ntransaction", lTransaction)
next

return 0

end function

public function integer of_reset_new_flag (datastore ods);// -------------------------------------------
// NewRow Flag nach dem Speichern resetten
// -------------------------------------------
Long I

for i = 1 to oDS.RowCount()
	
	oDS.SetItem(i, "nnew_row", 0)
	
next

return 0
end function

public function integer of_init ();// -----------------------------------------------------------
// Setzt alle M$$HEX1$$f600$$ENDHEX$$glichen Funktionen auf False
// -----------------------------------------------------------



return 0
end function

public subroutine wf_chc_trace (integer iarg_level, string sarg_trace_text);//==============================================================================================
//
// wf_chc_trace
//
// Protokolliert den Ablauf in Trace-File
//
//==============================================================================================
integer	iTraceFile

//
// Unwichtiges ignorieren
//
if iarg_level > s_app.iTrace then
	return
end if

// ---------------------------------------------------------
// 25.02.08, KF
// Wennd der Trace aktiviert ist, dann alles protokollieren
// ---------------------------------------------------------
if s_app.iTrace = 0 then
	return
end if

f_Log2Csv(0,0, sarg_trace_text)

//iTraceFile	= FileOpen(s_app.sTraceFile, LineMode!, Write!, LockWrite!, Append!)

//FileWrite(iTraceFile, String(Today())+"|"+String(Now(),"hh:mm:ss fff")+"|" + string(this.lResultKey_Trace) + "|" + sarg_trace_text)

//FileClose(iTraceFile)

return

end subroutine

public function boolean wf_chc_master_change ();//======================================================================================
//
// of_master_change
//
//======================================================================================
// Es wurden $$HEX1$$c400$$ENDHEX$$nderungen vorgenommen 
// Abflugdatum - Abflugzeit - Flugger$$HEX1$$e400$$ENDHEX$$t - Abfertigung - Passagier
// die eine $$HEX1$$dc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fung folgender Beladungen nach sich ziehen:
// Handling - Extrabeladung - Zeitungsbeladung - Mahlzeiten
//======================================================================================

integer						i
datetime						dtNow
uo_generate 	 			uo_change
s_change_flight			s_change
long							lStart, lStop
datastore                  dspackets_all

//MB 06.08.2013: Datstore f$$HEX1$$fc00$$ENDHEX$$r alle Packets der result_key_group
dspackets_all = create datastore
dspackets_all.dataobject = 'dw_view_packets_resultkey_group'
dspackets_all.settransobject(sqlca)

lStart = CPU()

dtNow = datetime(today(),now())
// ---------------------------------------------------------------------
// Anzahl Mahlzeitenkalkulationen innerhalb einer Transaktion erh$$HEX1$$f600$$ENDHEX$$hen
// ---------------------------------------------------------------------
lCalculationCounter++
// ---------------------------------------------------------------------
// (notwendige) Eingaben im Fenster m$$HEX1$$fc00$$ENDHEX$$ssen vollst$$HEX1$$e400$$ENDHEX$$ndig sein
// ---------------------------------------------------------------------
wf_chc_trace(10,"[wf_chc_master_change] Begin")

if wf_chc_validation() <> 0 then
	wf_chc_trace(10,"[wf_chc_master_change] wf_chc_validation returns <> 0")
	this.is_web_message = uf.translate("Daten unvollst$$HEX1$$e400$$ENDHEX$$ndig")

	destroy dspackets_all
	
	of_log_jobstate(ii_log_fehler, this.is_web_message) // 12.03.2015 HR: Logging eingebaut
	
	return false
end if
// ---------------------------------------------------------------------
// Ver$$HEX1$$e400$$ENDHEX$$nderungen werden mit dem Userobject uo_generate vorgenommen, also
// analog der Generierung.
// ---------------------------------------------------------------------

uo_change = create uo_generate
uo_change.idebug_level = s_app.iTrace
uo_change.sTraceFile = sLogPathFileName+"_"+ String(Today(), "yyyymmdd") // 09.03.2012 HR: LOGFILE-GEN sonst ohne Datum
uo_change.sInstanceName = sinstance
uo_change.dsRatioCache = dsRatioCache
uo_change.iUseSequenceForCenOutMeals = iUseSequenceForMeals
// ---------------------------------------------------------------------
// Keinen Ausz$$HEX1$$e400$$ENDHEX$$hldialog aktivieren, Ausz$$HEX1$$e400$$ENDHEX$$hlwerte werden vom Web bereits in npax_manual gesetzt
uo_change.bCallByWebService = True 

// 09.06.2010 HR: Bei Funktion BOB muss der Schalter im Generierungsobjekt gesetzt werden, damit die Mahlzeitencalculation das dann auch mitbekommt
// 28.03.2019 HR:
if ii_job_function = 9 or dsSysQueueFlightBob.rowcount()>0 then
	 uo_change.iImportBobValues = 1
end if		
		
// Ermittle Lieferanteneinstellungen
uo_suppl_unit.itype = 1 			// Flugereignis
uo_suppl_unit.dtdate =  dw_single.GetItemDatetime(dw_single.Getrow(),"ddeparture")
uo_suppl_unit.lCustomer =  dw_single.GetItemNumber(dw_single.Getrow(),"ncustomer_key") 
uo_suppl_unit.sUnit =  dw_single.GetItemString(dw_single.Getrow(),"cunit")	
uo_suppl_unit.dtToday = datetime(date(today()),time(now()))
uo_suppl_unit.of_retrieve_ds()
if uo_suppl_unit.i_suppl_interface_check_type = uo_suppl_unit.i_suppl_interface_check_type_2 and &
   s_app.iInvoicingType = 1 then	
		// f$$HEX1$$fc00$$ENDHEX$$r Monalisa-Auslandscaterer ist kein Handling notwendig
		uo_change.bNoHandlingNecessary = True 
end if
// ---------------------------------------------------------------------
// Vom Flugstatus abh$$HEX1$$e400$$ENDHEX$$ngige Parameter setzen
// ---------------------------------------------------------------------
if lMasterStatus <= 3 then
	s_change.iTimeAdjustment	= itimeadjustmentpl
elseif lMasterStatus = 4 then
	s_change.iTimeAdjustment	= itimeadjustmentp1
elseif lMasterStatus = 5 then
	s_change.iTimeAdjustment	= itimeadjustmentp2
end if
	
// ---------------------------------------------------------------------
// Wir nehmen auch die Datastores der Generierung
// ---------------------------------------------------------------------
s_change.dssingle								= Create uo_generate_datastore
s_change.dssingle.DataObject 				= "dw_change_cen_out"
s_change.dssingle.SetTransObject(SQLCA)
s_change.dspax									= Create uo_generate_datastore
s_change.dspax.DataObject 					= "dw_change_cen_out_passenger"
//s_change.dspax.DataObject 					= "dw_invoice_ml_cen_out_passenger"
s_change.dspax.SetTransObject(SQLCA)
s_change.dspriormeals						= Create uo_generate_datastore
s_change.dspriormeals.DataObject 		= "dw_change_cen_out_meals"
s_change.dspriormeals.SetTransObject(SQLCA)
s_change.dspriorextra						= Create uo_generate_datastore
s_change.dspriorextra.DataObject 		= "dw_change_cen_out_meals"
s_change.dspriorextra.SetTransObject(SQLCA)
s_change.dspriorspml							= Create uo_generate_datastore
s_change.dspriorspml.DataObject 			= "dw_change_cen_out_spml"
s_change.dspriorspml.SetTransObject(SQLCA)
s_change.dsPriorpax							= Create uo_generate_datastore
s_change.dsPriorpax.DataObject 			= "dw_change_cen_out_passenger"
//s_change.dsPriorpax.DataObject 			= "dw_invoice_ml_cen_out_passenger"
s_change.dsPriorpax.SetTransObject(SQLCA)

// --------------------------------------------------------------------------------------------------------------------
// 17.05.2011 HR:
// --------------------------------------------------------------------------------------------------------------------
s_change.dspackets							= Create uo_generate_datastore
s_change.dspackets.DataObject 			= dspackets.dataobject
s_change.dspackets.SetTransObject(SQLCA)

//
// Ergebnis-Datastores
//
s_change.dsnewmeals							= Create uo_generate_datastore
s_change.dsnewmeals.DataObject 			= "dw_change_cen_out_meals"
s_change.dsnewmeals.SetTransObject(SQLCA)
s_change.dsnewextra							= Create uo_generate_datastore
s_change.dsnewextra.DataObject 			= "dw_change_cen_out_meals"
s_change.dsnewextra.SetTransObject(SQLCA)
s_change.dsnewspml							= Create uo_generate_datastore
s_change.dsnewspml.DataObject 			= "dw_change_cen_out_spml"
s_change.dsnewspml.SetTransObject(SQLCA)
s_change.dsnewspmldetail					= Create uo_generate_datastore
s_change.dsnewspmldetail.DataObject 	= "dw_cen_out_spml_detail"
s_change.dsnewspmldetail.SetTransObject(SQLCA)
s_change.dsCurrentMeals							= Create uo_generate_datastore
s_change.dsCurrentMeals.DataObject 			= "dw_change_cen_out_meals"
s_change.dsCurrentMeals.SetTransObject(SQLCA)
s_change.dscurrentextra							= Create uo_generate_datastore
s_change.dscurrentextra.DataObject 			= "dw_change_cen_out_meals"
s_change.dscurrentextra.SetTransObject(SQLCA)
s_change.dsOldMeals								= Create uo_generate_datastore
s_change.dsOldMeals.DataObject 				= "dw_change_cen_out_meals"
s_change.dsOldMeals.SetTransObject(SQLCA)
s_change.dsOldExtra								= Create uo_generate_datastore
s_change.dsOldExtra.DataObject 				= "dw_change_cen_out_meals"
s_change.dsOldExtra.SetTransObject(SQLCA)

s_change.bmeals					= bChangeNoMeals		// Mahlzeiten werden nicht getauscht
																	// => Neuberechnung aufgrund der in cen_out_meals 
																	// 	gespeicherten Daten
s_change.bExtra					= bChangeNoExtra		// Extras werden nicht getauscht
																	// => Neuberechnung aufgrund der in cen_out_meals 
																	// 	gespeicherten Daten

s_change.bDoMealCalculation	= bDoMealCalculation	// verhindert ggf. eine Neuberechnung nach AC-Change

// ---------------------------------------------------------------------
// Die $$HEX1$$dc00$$ENDHEX$$bergabestruktur f$$HEX1$$fc00$$ENDHEX$$llen 
// ---------------------------------------------------------------------
s_change.ddeparture				= Date(dw_single.GetItemDateTime(dw_single.Getrow(),"dDeparture"))
s_change.lresultkey				= dw_single.GetItemNumber(dw_single.Getrow(), "nresult_key")

// --------------------------------------------------------------------------------------------------------------------
// 07.08.2015 HR: CBASE-DE-CR-2015-054
// --------------------------------------------------------------------------------------------------------------------
s_change.dscenmealsdetdeduction				= Create uo_generate_datastore
s_change.dscenmealsdetdeduction.dataobject	= "dw_exp_cen_meals_det_deduction"

// --------------------------------------------------------------------------------------------------------------------
// 12.05.2010 HR: Pr$$HEX1$$fc00$$ENDHEX$$fen, ob die G$$HEX1$$fc00$$ENDHEX$$ltigkeit der Beladedefinition noch pa$$HEX1$$df00$$ENDHEX$$t
// 07.02.2018 HR: In eigene Funktion ausgelagert
// --------------------------------------------------------------------------------------------------------------------

of_check_schedule_validity(s_change.ddeparture)
/*
long ll_tlc_from, ll_tlc_to, ll_routing_group_key, ll_routingdetail_key, ll_nroutingdetail_key_cp
long							llroutingplan_index_key, ll_airline_key, ll_flightnr, ll_legnr
  
 llroutingplan_index_key = dw_single.GetItemNumber(dw_single.Getrow(), "nroutingplan_index")
 ll_airline_key = dw_single.GetItemNumber(dw_single.Getrow(), "nairline_key")
 
SELECT count(*)  
 INTO :i  
 FROM cen_routingplan_definition  
WHERE ( nroutingplan_index = :llroutingplan_index_key ) AND  
		( nairline_key = :ll_airline_key ) AND  
		( :s_change.ddeparture between trunc(dvalid_from) and trunc(dvalid_to) )   ;

if i=0 then
	//G$$HEX1$$fc00$$ENDHEX$$ltigkeit der Beladedefinition wurde ver$$HEX1$$e400$$ENDHEX$$ndert und der Flugtag geh$$HEX1$$f600$$ENDHEX$$rt nicht mehr zur generierten G$$HEX1$$fc00$$ENDHEX$$ltigkeit
	//Dann m$$HEX1$$fc00$$ENDHEX$$ssen wir neue Schl$$HEX1$$fc00$$ENDHEX$$ssel holen
	
	SELECT  nroutingplan_index  
	     INTO :llroutingplan_index_key 
        FROM cen_routingplan_definition  
     WHERE ( nairline_key = :ll_airline_key ) AND  
			   ( :s_change.ddeparture between trunc(dvalid_from) and trunc(dvalid_to) )   ;
	
	if sqlca.sqlcode=100 then 
		//Keine g$$HEX1$$fc00$$ENDHEX$$ltige Beladedefinition
		ll_routingdetail_key =-1
		ll_nroutingdetail_key_cp =-1
	else
		ll_routingdetail_key =0
		ll_nroutingdetail_key_cp =0 

		//Kommen die Detail $$HEX1$$fc00$$ENDHEX$$ber die Flugnummer?
		if  dw_single.GetItemNumber(dw_single.Getrow(), "nroutingdetail_key") > 0 then
			ll_flightnr =  dw_single.GetItemNumber(dw_single.Getrow(), "nflight_number")
			ll_legnr	=  dw_single.GetItemNumber(dw_single.Getrow(), "nleg_number")
			ll_tlc_from	=  dw_single.GetItemNumber(dw_single.Getrow(), "ntlc_from")
			ll_tlc_to	=  dw_single.GetItemNumber(dw_single.Getrow(), "ntlc_to")
			ll_routing_group_key	=  dw_single.GetItemNumber(dw_single.Getrow(), "nrouting_group_key")
			
			  SELECT cen_routingplan.nroutingdetail_key  
				 INTO :ll_routingdetail_key  
				 FROM cen_routingplan  
				WHERE ( cen_routingplan.nroutingplan_index = :llroutingplan_index_key ) AND  
						( cen_routingplan.nairline_key = :ll_airline_key ) AND  
						( cen_routingplan.nflight_number = :ll_flightnr ) AND  
						( cen_routingplan.nleg_number = :ll_legnr ) AND  
						( cen_routingplan.nrouting_group_key = :ll_routing_group_key )   and 
						(cen_routingplan.ntlc_to = :ll_tlc_to )   and 
						(cen_routingplan.ntlc_from = :ll_tlc_from )   ;

			if sqlca.sqlcode<>0 then
				// --------------------------------------------------------------------------------------------------------------------
				// 08.10.2010 HR: Group-Key nicht gefunden, dann schauen wir nochmal, ob
				//						es den Flug mit einem anderen Groupkey gibt
				// --------------------------------------------------------------------------------------------------------------------
				SELECT min(cen_routingplan.nroutingdetail_key )
				 INTO :ll_routingdetail_key  
				 FROM cen_routingplan  
				WHERE ( cen_routingplan.nroutingplan_index = :llroutingplan_index_key ) AND  
						( cen_routingplan.nairline_key = :ll_airline_key ) AND  
						( cen_routingplan.nflight_number = :ll_flightnr ) AND  
						( cen_routingplan.nleg_number = :ll_legnr ) AND  
						(cen_routingplan.ntlc_to = :ll_tlc_to )   and 
						(cen_routingplan.ntlc_from = :ll_tlc_from )   ;
				
				if sqlca.sqlcode<>0 then
					ll_routingdetail_key = -1
				else
					select cen_routingplan.nrouting_group_key
					   into :ll_routing_group_key
					from cen_routingplan 
					where cen_routingplan.nroutingdetail_key = :ll_routingdetail_key ;
				end if
			end if
		end if
		
		//Kommen die Detail $$HEX1$$fc00$$ENDHEX$$ber Citypair?
		if  dw_single.GetItemNumber(dw_single.Getrow(), "nroutingdetail_key_cp") > 0 then
			ll_flightnr =  -1
			ll_tlc_from	=  dw_single.GetItemNumber(dw_single.Getrow(), "ntlc_from")
			ll_tlc_to	=  dw_single.GetItemNumber(dw_single.Getrow(), "ntlc_to")
			ll_routing_group_key	=  dw_single.GetItemNumber(dw_single.Getrow(), "nrouting_group_key_cp")
			
			  SELECT cen_routingplan.nroutingdetail_key 
				 INTO :ll_nroutingdetail_key_cp  
				 FROM cen_routingplan  
				WHERE ( cen_routingplan.nroutingplan_index = :llroutingplan_index_key ) AND  
						( cen_routingplan.nairline_key = :ll_airline_key ) AND  
						( cen_routingplan.nflight_number = :ll_flightnr ) AND  
						( cen_routingplan.nrouting_group_key = :ll_routing_group_key )   and 
						(cen_routingplan.ntlc_to = :ll_tlc_to )   and 
						(cen_routingplan.ntlc_from = :ll_tlc_from )   ;

			if sqlca.sqlcode<>0 then
				// --------------------------------------------------------------------------------------------------------------------
				// 08.10.2010 HR: Group-Key nicht gefunden, dann schauen wir nochmal, ob
				//						es den CityPair mit einem anderen Groupkey gibt
				// --------------------------------------------------------------------------------------------------------------------
				SELECT min(cen_routingplan.nroutingdetail_key)
				 INTO :ll_nroutingdetail_key_cp 
				 FROM cen_routingplan  
				WHERE ( cen_routingplan.nroutingplan_index = :llroutingplan_index_key ) AND  
						( cen_routingplan.nairline_key = :ll_airline_key ) AND  
						( cen_routingplan.nflight_number = :ll_flightnr ) AND  
						(cen_routingplan.ntlc_to = :ll_tlc_to )   and 
						(cen_routingplan.ntlc_from = :ll_tlc_from )   ;
				
				if sqlca.sqlcode<>0 then
					ll_nroutingdetail_key_cp = -1
				else
					select cen_routingplan.nrouting_group_key
					   into :ll_routing_group_key
					from cen_routingplan 
					where cen_routingplan.nroutingdetail_key = :ll_nroutingdetail_key_cp; 
				end if
			end if
		end if
		
	end if
	
	if ll_routingdetail_key =-1 or ll_nroutingdetail_key_cp =-1 then
		wf_chc_trace(1,"[wf_chc_master_change] Fehler beim Ermitteln der Flugschl$$HEX1$$fc00$$ENDHEX$$ssel, da die G$$HEX1$$fc00$$ENDHEX$$ltigkeit der Beladedefinition ge$$HEX1$$e400$$ENDHEX$$ndert wurde. Alte Werte werden weiter benutzt.")
	else
		dw_single.SetItem(dw_single.Getrow(), "nroutingdetail_key",ll_routingdetail_key) 
		dw_single.SetItem(dw_single.Getrow(), "nroutingdetail_key_cp",ll_nroutingdetail_key_cp)
		dw_single.SetItem(dw_single.Getrow(), "nroutingplan_index",llroutingplan_index_key)
		
		// 08.10.2010 HR: Auch den ggf. ge$$HEX1$$e400$$ENDHEX$$nderten GroupKey zur$$HEX1$$fc00$$ENDHEX$$ckschreiben
		dw_single.SetItem(dw_single.Getrow(), "nrouting_group_key",ll_routing_group_key )
	end if
end if
*/
//dw_single.RowsCopy(1,1,Primary!,s_change.dssingle,1,Primary!)
wf_ml_rowscopy_single(dw_single,1,1, s_change.dssingle,1)

//dw_pax.RowsCopy(1,dw_pax.rowcount(),Primary!,s_change.dspax,1,Primary!)
// Umsetzen dw_invoice_ml_cen_out_passenger auf Format von
//						 dw_change_cen_out_passenger 
integer j 
long lstatus, lpax
for j = 1 to dw_pax.rowcount()
	lpax = dw_pax.getitemnumber(j,"npax")
	lstatus =  dw_pax.getitemnumber(j,"status_npax")
next
wf_ml_rowscopy_pax(dw_pax,1,dw_pax.rowcount(), s_change.dspax,1)

for j = 1 to s_change.dspax.rowcount()
	lpax = s_change.dspax.getitemnumber(j,"npax")
	lstatus =  s_change.dspax.getitemnumber(j,"status_npax")
next

//
// "Prior-Zustand" immer aus Datastore
//
wf_ml_superrowscopy(dsMealOld,s_change.dspriormeals)
wf_ml_superrowscopy(dsExtraOld,s_change.dspriorextra)
wf_ml_superrowscopy(dsSPMLOld,s_change.dspriorspml)

//wf_ml_superrowscopy(dw_meal,s_change.dspriormeals)
//wf_ml_superrowscopy(dw_extra,s_change.dspriorextra)
//wf_ml_superrowscopy(dw_spml,s_change.dspriorspml)
	

	
//dsMealOld.RowsCopy(1,dsMealOld.rowcount(),Primary!,s_change.dspriormeals,s_change.dspriormeals.RowCount() + 1,Primary!)
//dsExtraOld.RowsCopy(1,dsExtraOld.rowcount(),Primary!,s_change.dspriorextra,s_change.dspriorextra.RowCount() + 1,Primary!)
//dsSPMLOld.RowsCopy(1,dsSPMLOld.rowcount(),Primary!,s_change.dspriorspml,s_change.dspriorspml.RowCount() + 1,Primary!)
//dsPaxOld.RowsCopy(1,dsPaxOld.rowcount(),Primary!,s_change.dsPriorpax,s_change.dsPriorpax.RowCount() + 1,Primary!)
wf_ml_rowscopy_pax(dsPaxOld,1,dsPaxOld.rowcount(), s_change.dsPriorpax,s_change.dsPriorpax.RowCount() + 1)
//
// Besonderheit SPML:
// Aktueller Zustand mu$$HEX2$$df002000$$ENDHEX$$ebenfalls $$HEX1$$fc00$$ENDHEX$$bertragen werden, da in uo_generate 
// die Aufl$$HEX1$$f600$$ENDHEX$$sung aufgrund der aktuellen Eingaben erfolgen mu$$HEX1$$df00$$ENDHEX$$!
//
if dw_SPML.RowsCopy(1,dw_SPML.rowcount(),Primary!,s_change.dsnewspml,s_change.dsnewspml.RowCount() + 1,Primary!) = -1 and dw_SPML.rowcount()>0 then
   f_Log2Csv(0,1,"[wf_chc_master_change] error rowscopy dw_spml to s_change.dsnewspml / Source: " + dw_SPML.dataobject + " / Target: " + s_change.dsnewspml.dataobject)
end if
//
// Test: aktuelle Mahlzeiten aus dw_meal w$$HEX1$$e400$$ENDHEX$$ren doch auch wichtig wegen m$$HEX1$$f600$$ENDHEX$$glicher $$HEX1$$c400$$ENDHEX$$nderung Reserven
//			s_change.dsCurrentMeals
//
if dw_meal.RowsCopy(1,dw_meal.rowcount(),Primary!,s_change.dsCurrentMeals,s_change.dsCurrentMeals.RowCount() + 1,Primary!) = -1 and dw_meal.rowcount()>0 then
   f_Log2Csv(0,1,"[wf_chc_master_change] error rowscopy dw_meal to s_change.dsCurrentMeals / Source: " + dw_meal.dataobject + " / Target: " + s_change.dsCurrentMeals.dataobject)
end if
if dw_extra.RowsCopy(1,dw_extra.rowcount(),Primary!,s_change.dscurrentextra,s_change.dscurrentextra.RowCount() + 1,Primary!) = -1 and dw_extra.rowcount()>0 then
   f_Log2Csv(0,1,"[wf_chc_master_change] error rowscopy dw_extra to s_change.dscurrentextra / Source: " + dw_extra.dataobject + " / Target: " + s_change.dscurrentextra.dataobject)
end if
//
// 13.07. separate $$HEX1$$dc00$$ENDHEX$$bertragung Meals und Extra
//
//dsMealOld.RowsCopy(1,dsMealOld.rowcount(),Primary!,s_change.dsOldMeals,s_change.dsOldMeals.RowCount() + 1,Primary!)
//dsExtraOld.RowsCopy(1,dsExtraOld.rowcount(),Primary!,s_change.dsOldExtra,s_change.dsOldExtra.RowCount() + 1,Primary!)
wf_ml_superrowscopy(dsMealOld,s_change.dsOldMeals)
wf_ml_superrowscopy(dsExtraOld,s_change.dsOldExtra)

// --------------------------------------------------------------------------------------------------------------------
// 24.11.2015 HR: CBASE-NAM-CR-15014 Die Packages/LOS neu einspielen
// --------------------------------------------------------------------------------------------------------------------
if ii_job_function = 13 then
	i = wf_regenerate_paclos()
end if

// 17.05.2011 HR: Auch die zugeordneten Packete $$HEX1$$fc00$$ENDHEX$$bertragen 09.09.2011 HR Fehler nur wenn rowcount>0
// 06.08.2013 MB: Die Packets aller Legs $$HEX1$$fc00$$ENDHEX$$bertragen, sonst funktioniert die SSL/ZBL Zuordnung $$HEX1$$fc00$$ENDHEX$$ber PAckets nicht richtig:
dspackets_all.retrieve(dw_single.getitemnumber(dw_single.getrow(),"nresult_key_group"))
if dspackets_all.RowsCopy(1,dspackets_all.rowcount(),Primary!,s_change.dspackets,s_change.dspackets.RowCount() + 1,Primary!) = -1 and dspackets_all.rowcount()>0 then
	wf_chc_trace(10,"[wf_chc_master_change] Fehler rowscopy dspackets")	
end if

If (ii_action = 2) Then 	// Aufruf erfolgt $$HEX1$$fc00$$ENDHEX$$ber Web
	s_change.dsOldExtra.reset()
	s_change.dspriorExtra.reset()
   	if s_change.dscurrentextra.rowscopy(1,s_change.dscurrentextra.rowcount(),primary!, s_change.dsOldExtra, 1, primary!)  = -1  and s_change.dscurrentextra.rowcount()>0 then
		f_Log2Csv(0,1,"[wf_chc_master_change] error rowscopy s_change.dscurrentextra to s_change.dsOldExtra / Source: " + s_change.dscurrentextra.dataobject + " / Target: " + s_change.dsOldExtra.dataobject)
	end if
	if s_change.dscurrentextra.rowscopy(1,s_change.dscurrentextra.rowcount(),primary!, s_change.dspriorExtra, 1, primary!) = -1 and s_change.dscurrentextra.rowcount()>0 then
		f_Log2Csv(0,1,"[wf_chc_master_change] error rowscopy  s_change.dscurrentextra to  s_change.dspriorExtra / Source: " + s_change.dscurrentextra.dataobject + " / Target: " +  s_change.dspriorExtra.dataobject)
	end if
end if


// ---------------------------------------------------------------------
//
// Neue Beladung erstellen
// Achtung: Nur wenn bDoMealCalculation = true, dann Mahlzeiten holen!!!
//
// ---------------------------------------------------------------------
s_change.dspriorextra.saveas("D:\dspriorextra.xls", EXCEL5!, true)
s_change.dscurrentextra.saveas("D:\dscurrentextra.xls", EXCEL5!, true)
s_change.dsOldExtra.saveas("D:\dsOldExtra.xls", EXCEL5!, true)

// Start = Now()
SetPointer(HourGlass!)
wf_chc_trace(10,"[wf_chc_master_change] Aufl$$HEX1$$f600$$ENDHEX$$sung Flug Begin")
s_change = uo_change.of_change_handling_objects(s_change)

if s_change.bsuccess  then
	wf_chc_trace(10,"[wf_chc_master_change] Aufl$$HEX1$$f600$$ENDHEX$$sung Flug erfolgreich")	
	of_log_jobstate(ii_log_info, uf.translate("Aufl$$HEX1$$f600$$ENDHEX$$sung Flug erfolgreich")) // 12.03.2015 HR: Logging eingebaut

	s_change.dsOldExtra.saveas("D:\dsnewextra.xls", EXCEL5!, true)

else
	wf_chc_trace(10,"[wf_chc_master_change] Aufl$$HEX1$$f600$$ENDHEX$$sung Flug mit Fehler abgeschlossen: "+s_change.sMessage)
	of_log_jobstate(ii_log_warning, uf.translate("Aufl$$HEX1$$f600$$ENDHEX$$sung Flug mit Fehler abgeschlossen:")+s_change.sMessage) // 12.03.2015 HR: Logging eingebaut
end if

SetPointer(Arrow!)
// Ende = Now()
// Messagebox(string(start),string(ende))

// ---------------------------------------------------------------------
// Nun sollten in uo_generate die entsprechenden Datastores gef$$HEX1$$fc00$$ENDHEX$$llt sein.
// ---------------------------------------------------------------------
If s_change.bSuccess = False Then
	if bImportMode then
		wf_chc_add_to_protocol(s_change.sMessage)
	else
		f_Log2Csv(0,2,"[wf_chc_master_change] Fehler: "+s_change.sMessage)
	end if

	this.is_web_message = s_change.sMessage // 01.03.2011 HR:
		
	bNoSaving 	= True
	
	destroy	dspackets_all 
	destroy	s_change.dsCurrentMeals
	destroy	s_change.dsOldMeals
	destroy	s_change.dsOldextra
	destroy	s_change.dscenmealsdetdeduction
	destroy	s_change.dscurrentextra
	destroy	s_change.dsnewextra
	destroy	s_change.dsnewmeals
	destroy	s_change.dsnewspml
	destroy	s_change.dsnewspmldetail
	destroy	s_change.dspackets
	destroy	s_change.dspax
	destroy	s_change.dspriorextra
	destroy	s_change.dspriormeals
	destroy	s_change.dspriorpax
	destroy	s_change.dspriorspml
	destroy	s_change.dssingle
	destroy	uo_change
	
	wf_chc_trace(10,"[wf_chc_master_change] s_change.bSuccess = False")
	return False
Else
	//
	// Ein weiterer Change k$$HEX1$$f600$$ENDHEX$$nnte alles wieder gut machen...
	//
	bNoSaving 	= False
End if

//	f_print_datastore(s_change.dssingle)

// ---------------------------------------------------------------------
// Abrechnungs-Infos aktualisieren
// ---------------------------------------------------------------------
if (s_change.dssingle.GetItemNumber(1,"ncustomer_key") <> dw_single.GetItemNumber(1,"ncustomer_key")) or &
	isnull(dw_single.GetItemString(1,"ccustomer")) then
	dw_single.SetItem(1,"ncustomer_key",s_change.dssingle.GetItemNumber(1,"ncustomer_key"))
	dw_single.SetItem(1,"ccustomer",s_change.dssingle.GetItemString(1,"ccustomer"))
	dw_single.SetItem(1,"status_ccustomer",1)
end if

//
// Kurz-Von-An f$$HEX1$$fc00$$ENDHEX$$r den Kopf eintragen!
//
dw_single.SetItem(1,"caccount",s_change.dssingle.GetItemString(1,"caccount"))
dw_single.SetItem(1,"naccount_key",s_change.dssingle.GetItemNumber(1,"naccount_key"))

// ---------------------------------------------------------------------
// 19.07.2013 HR: $$HEX1$$dc00$$ENDHEX$$bernahme aus CORE
// 28.06.2010 OH: Traffic Area wurde evtl. neu berechnet
// 06.12.2010 HR: Zuweisung aber nur bei $$HEX1$$c400$$ENDHEX$$nderung
// ---------------------------------------------------------------------
if dw_single.GetItemString(1,"CTRAFFIC_AREA")<>s_change.dssingle.GetItemString(1,"CTRAFFIC_AREA") then
	dw_single.SetItem(1,"CTRAFFIC_AREA",				s_change.dssingle.GetItemString(1,"CTRAFFIC_AREA"))
	dw_single.SetItem(1,"CTRAFFIC_AREA_SHORT",	s_change.dssingle.GetItemString(1,"CTRAFFIC_AREA_SHORT"))
end if

// ---------------------------------------------------------------------
// Rampen- und K$$HEX1$$fc00$$ENDHEX$$chenzeiten aktualisieren
// ---------------------------------------------------------------------
if (lMasterStatus <= 3 and itimeadjustmentpl = 1) or &
	(lMasterStatus = 4 and itimeadjustmentp1 = 1 ) or &
	(lMasterStatus = 5 and itimeadjustmentp2 = 1) then
	if bImportMode then
		if dw_single.GetItemString(1,"cramp_time") <> s_change.sRamptime then
			dw_single.SetItem(1,"cramp_time",s_change.sRamptime)
			dw_single.SetItem(1,"status_cramp_time",1)
		end if
		if dw_single.GetItemString(1,"ckitchen_time") <> s_change.sKitchenTime then
			dw_single.SetItem(1,"ckitchen_time",s_change.sKitchenTime)
			dw_single.SetItem(1,"status_ckitchen_time",1)
		end if
	else
		if dw_single.GetItemString(1,"cramp_time") <> s_change.sRamptime then
			 f_Log2Csv(0,2,"[wf_chc_master_change] Die errechnete Rampenzeit betr$$HEX1$$e400$$ENDHEX$$gt " + s_change.sRamptime + &
							", die vorhandene Rampenzeit " + dw_single.GetItemString(1,"cramp_time") )
				dw_single.SetItem(1,"cramp_time",s_change.sRamptime)
				dw_single.SetItem(1,"status_cramp_time",1)
			
		end if
		if dw_single.GetItemString(1,"ckitchen_time") <> s_change.sKitchenTime then
			 f_Log2Csv(0,2,"[wf_chc_master_change] Die errechnete K$$HEX1$$fc00$$ENDHEX$$chenzeit betr$$HEX1$$e400$$ENDHEX$$gt " + s_change.sKitchenTime + &
							", die vorhandene K$$HEX1$$fc00$$ENDHEX$$chenzeit " + dw_single.GetItemString(1,"ckitchen_time") )
				dw_single.SetItem(1,"ckitchen_time",s_change.sKitchenTime)
				dw_single.SetItem(1,"status_ckitchen_time",1)
			
		end if
	end if
end if

// ---------------------------------------------------------------------
// Pax-DW aktualisieren (mit Menge-alt)
// ---------------------------------------------------------------------
If wf_chc_change_pax(uo_change.dsCenOutPax) = False Then
	bNoSaving = True
	wf_chc_trace(10,"[wf_chc_master_change] wf_chc_change_pax(uo_change.dsCenOutPax) = False")
End if	

// ---------------------------------------------------------------------
// Ok, Handling (Loading List und Supplement Loadinglist) eintragen
// ---------------------------------------------------------------------
If wf_chc_change_handling(uo_change.dsCenOutHandling) = False Then
	bNoSaving = True
	wf_chc_trace(10,"[wf_chc_master_change] wf_chc_change_handling(uo_change.dsCenOutHandling) = False")
End if	

// ---------------------------------------------------------------------
// Ok, Zeitungsbeladung eintragen
// ---------------------------------------------------------------------
If wf_chc_change_newspaper(uo_change.dsCenOutHandlingNews,uo_change.dsCenOutNewsExtra) = False Then
	bNoSaving = True
	wf_chc_trace(10,"[wf_chc_master_change] wf_chc_change_newspaper(uo_change.dsCenOutHandlingNews,uo_change.dsCenOutNewsExtra) = False")
End if	
// ---------------------------------------------------------------------
// Ok, Stationsauftrag eintragen
// ---------------------------------------------------------------------
// wf_chc_change_qaq(uo_change.dsCenOutQaq)	
// ---------------------------------------------------------------------
// Mahlzeiten eintragen, bChangeNoMeals = False
// ---------------------------------------------------------------------
// Messagebox("", "9")

If wf_chc_change_meals(s_change.dsnewmeals, s_change.dscenmealsdetdeduction) = False Then
	bNoSaving = True
	wf_chc_trace(10,"[wf_chc_master_change] wf_chc_change_meals(s_change.dsnewmeals) = False")
End if

// Messagebox("", "10")
// f_print(dw_meal)
// ---------------------------------------------------------------------
// Ok, Extrabeladung eintragen, bChangeNoExtra	= False
// ---------------------------------------------------------------------
If wf_chc_change_extra(s_change.dsnewextra) = False Then
	bNoSaving = True
	wf_chc_trace(10,"[wf_chc_master_change] wf_chc_change_extra(s_change.dsnewextra) = False")
End if

// f_print(dw_meal)
// ---------------------------------------------------------------------
// SPML eintragen, bChangeNoExtra	= False
// ---------------------------------------------------------------------
If wf_chc_change_spml(s_change.dsnewspml) = False Then
	bNoSaving = True
	wf_chc_trace(10,"[wf_chc_master_change] wf_chc_change_spml(s_change.dsnewspml) = False")
End if	

// ---------------------------------------------------------------------
// SPML-Details zur$$HEX1$$fc00$$ENDHEX$$ckkopieren
// ---------------------------------------------------------------------
dsSPMLDetail.Reset()
if s_change.dsnewspmldetail.RowsCopy(1,s_change.dsnewspmldetail.rowcount(),Primary!,dsSPMLDetail,dsSPMLDetail.RowCount() + 1,Primary!)  = -1 and s_change.dsnewspmldetail.rowcount()>0 then
   f_Log2Csv(0,1,"[wf_chc_master_change] error rowscopy  s_change.dsnewspmldetail to dsSPMLDetail / Source: " + s_change.dsnewspmldetail.dataobject + " / Target: " + dsSPMLDetail.dataobject)
end if

//wf_chc_show_tab_picture()
// ------------------------------------------
// Header Datawindows mit Infos versorgen
// ------------------------------------------
//wf_chc_set_header_datawindows()

//	f_print_datastore(s_change.dspriormeals)
//	f_print_datastore(s_change.dsnewmeals)
//	f_print_datastore(s_change.dspriorextra)
//	f_print_datastore(s_change.dsnewextra)
//	f_print_datastore(s_change.dsnewspmldetail)

destroy	dspackets_all 
destroy	s_change.dsCurrentMeals
destroy	s_change.dsOldMeals
destroy	s_change.dsOldextra
destroy	s_change.dscenmealsdetdeduction
destroy	s_change.dscurrentextra
destroy	s_change.dsnewextra
destroy	s_change.dsnewmeals
destroy	s_change.dsnewspml
destroy	s_change.dsnewspmldetail
destroy	s_change.dspackets
destroy	s_change.dspax
destroy	s_change.dspriorextra
destroy	s_change.dspriormeals
destroy	s_change.dspriorpax
destroy	s_change.dspriorspml
destroy	s_change.dssingle
destroy	uo_change
// ------------------------------------------
// Nach dem MasterChange nicht nochmal...
// ------------------------------------------
bForceMealCalculation = False

// ------------------------------------------
// Timestamp
// ------------------------------------------
dw_single.SetItem(1,"dtimestamp",dtNow)

// ------------------------------------------
// 17.10.2005	Masterchange wurde ausgef$$HEX1$$fc00$$ENDHEX$$hrt
// ------------------------------------------
bMealsCalculated = true

// ------------------------------------------
// Timestamp
// ------------------------------------------

wf_chc_trace(10,"[wf_chc_master_change] Finish")
//wf_setmessage("Ready in " + string((lStop - lStart) / 1000, "00.000") + " seconds.")

//dw_meal.setRedraw(true)
//f_print(dw_meal)
//Messagebox("", "1")

lStop = CPU()

return True

end function

public function integer wf_chc_validation ();// ------------------------------------------------------------------------
//
// wf_chc_validation
//
// Letzte Pr$$HEX1$$fc00$$ENDHEX$$fung der Daten vor jedem Masterchange (und somit autom. auch 
// vor jedem Speichern)!
//
// ------------------------------------------------------------------------
long		i
string	sCheckString
integer	iret
/*
dw_pax.AcceptText()
dw_single.AcceptText()
dw_extra.AcceptText()
dw_meal.AcceptText()
dw_spml.AcceptText()
dw_handling.AcceptText()
*/
//
// Check SPML
//
iret = wf_chc_validate_spml()
if iret < 0 then
	wf_chc_trace(10,"[wf_chc_validation] wf_chc_validate_spml() returns " + string(iret))
	return 1
end if
/*
//
// Check Loadinglist
//
iret = wf_chc_validate_loadinglist()
if iret < 0 then
	wf_chc_trace(10,"[wf_chc_validation] wf_chc_validate_loadinglist() returns " + string(iret))
	return 1
end if
*/
return 0

end function

public function boolean wf_ml_rowscopy_pax (datastore dwsource, long lstartrow_source, long lendrow_source, datastore dwtarget, long lstartrow_target);//-------------------------------------------------------------------------------
// Kopieren zwischen den Formaten der Datawindows dw_change_cen_out_passenger
// und dw_invoice_ml_cen_out_passenger
// Erg$$HEX1$$e400$$ENDHEX$$nzen ggf. fehlender Informationen
//-------------------------------------------------------------------------------
Integer 	itype_source, itype_target
Integer i
datastore dw_format1, dw_format2, dw_format3
string	stext,stext2,stext3
Integer	li_result
String		ls_dataobject_source 
String		ls_dataobject_target 

dw_format1										= Create datastore
dw_format1.DataObject 							= "dw_change_cen_out_passenger"
//dw_format1							= dw_format11 // Format von "dw_change_cen_out_passenger"
dw_format1.SetTransObject(SQLCA)

dw_format3										= Create datastore
dw_format3.DataObject 							= "dw_uo_ml_out_cen_out_passenger_history"
														
//dw_format1							= dw_format11 // Format von "dw_change_cen_out_passenger"
dw_format3.SetTransObject(SQLCA)

dw_format2											= Create datastore
dw_format2.DataObject 							= "dw_invoice_ml_cen_out_passenger"

//dw_format2							= dw_format12  //Format von "dw_invoice_ml_cen_out_passenger"
dw_format2.SetTransObject(SQLCA)
stext = dwsource.DataObject 	
stext2 = dwtarget.DataObject 	
stext3 = dw_format3.DataObject 	


if dwsource.Dataobject = dw_format1.DataObject then
	itype_source = 1
elseif dwsource.Dataobject = dw_format2.DataObject  then
	itype_source = 2
elseif 	dwsource.Dataobject = dw_format3.DataObject then 
	itype_source = 3

else
	itype_source = 0
end if
if dwtarget.Dataobject = dw_format1.DataObject 	then

	itype_target = 1
elseif dwtarget.Dataobject = dw_format2.DataObject then
	itype_target = 2
elseif 	dwtarget.Dataobject = dw_format3.DataObject then
	itype_target = 3
else
	itype_target = 0
end if
if itype_target = 0 or itype_source = 0 then
	// 05.03.2010 HR: Destroy eingebaut, uf.mbox durch log ersetzt

	destroy dw_format1
	destroy dw_format2
	destroy dw_format3

	f_log2csv(0,2,"[wf_ml_rowscopy_pax] Achtung: Hallo Entwickler, unbekanntes Datawindow in wf_ml_rowscopy_pax!")
	
	return false
end if
if itype_target = itype_source then // Formate gleich

		IF	dwsource.RowCount() > 0 THEN
			ls_dataobject_source = 	dwsource.DataObject
			ls_dataobject_target 	= 	dwtarget.DataObject
			li_result = dwsource.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
			IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_pax - 1] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
		END IF

else // Formate ungleich 
	if itype_source = 1 then 	// Format 1: dw_change_cen_out_passenger

		IF	dwsource.RowCount() > 0 THEN
			ls_dataobject_source = 	dwsource.DataObject
			ls_dataobject_target 	= 	dw_format1.DataObject
			li_result = dwsource.Rowscopy(1, dwsource.rowcount(),Primary!,dw_format1,1,PRIMARY!)
			IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_pax - 1] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
		END IF
		
		if itype_target = 2 then
			wf_ml_superrowscopy(dw_format1, dw_format2)
			for i = 1 to dw_format2.rowcount()
				if dw_format2.getItemNumber(i,"nstationentry")  = i_isStationEntry then
					dw_format2.setItem(i,"npax_station", dw_format2.GetItemNumber(i,"npax"))
					dw_format2.setItem(i,"npax_spml_station", dw_format2.GetItemNumber(i,"npax_spml"))
				else
					dw_format2.setItem(i,"npax_caterer", dw_format2.GetItemNumber(i,"npax"))
					dw_format2.setItem(i,"npax_spml_caterer", dw_format2.GetItemNumber(i,"npax_spml"))
				end if
			next 

			IF	dw_format2.RowCount() > 0 THEN
				ls_dataobject_source = 	dw_format2.DataObject
				ls_dataobject_target 	= 	dwtarget.DataObject
				li_result = dw_format2.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_pax - 2] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
		end if
		if itype_target = 3 then
			wf_ml_superrowscopy(dw_format1, dw_format3)
			for i = 1 to dw_format3.rowcount()
				if dw_format3.getItemNumber(i,"nstationentry")  = i_isStationEntry then
					dw_format3.setItem(i,"npax_station", dw_format3.GetItemNumber(i,"npax"))
					dw_format3.setItem(i,"npax_spml_station", dw_format3.GetItemNumber(i,"npax_spml"))
				else
					dw_format3.setItem(i,"npax_caterer", dw_format3.GetItemNumber(i,"npax"))
					dw_format3.setItem(i,"npax_spml_caterer", dw_format3.GetItemNumber(i,"npax_spml"))
				end if
			next 

			IF	dw_format3.RowCount() > 0 THEN
				ls_dataobject_source = 	dw_format3.DataObject
				ls_dataobject_target 	= 	dwtarget.DataObject
				li_result = dw_format3.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_pax - 3] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
		end if
	elseif itype_source = 2 then  		// Format 2: dw_invoice_ml_cen_out_passenger
		if itype_target = 1 then

			IF	dwsource.RowCount() > 0 THEN
				ls_dataobject_source = 	dwsource.DataObject
				ls_dataobject_target 	= 	dw_format2.DataObject
				li_result = dwsource.Rowscopy(1, dwsource.rowcount(),Primary!,dw_format2,1,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_pax - 3] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
			wf_ml_superrowscopy(dw_format2, dw_format1)
			
			IF	dw_format1.RowCount() > 0 THEN
				ls_dataobject_source = 	dw_format1.DataObject
				ls_dataobject_target 	= 	dwtarget.DataObject
				li_result = dw_format1.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_pax - 4] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF

		end if
		if itype_target = 3 then

			IF	dwsource.RowCount() > 0 THEN
				ls_dataobject_source = 	dwsource.DataObject
				ls_dataobject_target 	= 	dw_format2.DataObject
				li_result = dwsource.Rowscopy(1, dwsource.rowcount(),Primary!,dw_format2,1,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_pax - 5] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
			wf_ml_superrowscopy(dw_format2, dw_format3)

			IF	dw_format3.RowCount() > 0 THEN
				ls_dataobject_source = 	dw_format3.DataObject
				ls_dataobject_target 	= 	dwtarget.DataObject
				li_result = dw_format3.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_pax - 6] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
		end if

	elseif itype_source = 3 then  		// Format 3: dw_invoice_ml_cen_out_passenger
		if itype_target = 1 then

			IF	dwsource.RowCount() > 0 THEN
				ls_dataobject_source = 	dwsource.DataObject
				ls_dataobject_target 	= 	dw_format3.DataObject
				li_result = dwsource.Rowscopy(1, dwsource.rowcount(),Primary!,dw_format3,1,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_pax - 7] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
			wf_ml_superrowscopy(dw_format3, dw_format1)
			
			IF	dw_format1.RowCount() > 0 THEN
				ls_dataobject_source = 	dw_format1.DataObject
				ls_dataobject_target 	= 	dwtarget.DataObject
				li_result = dw_format1.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_pax - 8] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
		end if
		if itype_target = 2 then

			IF	dwsource.RowCount() > 0 THEN
				ls_dataobject_source = 	dwsource.DataObject
				ls_dataobject_target 	= 	dw_format3.DataObject
				li_result = dwsource.Rowscopy(1, dwsource.rowcount(),Primary!,dw_format3,1,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_pax - 9] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
			wf_ml_superrowscopy(dw_format3, dw_format2)
			
			IF	dw_format2.RowCount() > 0 THEN
				ls_dataobject_source = 	dw_format2.DataObject
				ls_dataobject_target 	= 	dwtarget.DataObject
				li_result = dw_format2.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_pax - 10] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
		end if

	end if
		
end if

// 05.03.2010 HR: Destroy eingebaut
destroy dw_format1
destroy dw_format2
destroy dw_format3

return true



end function

public function integer wf_chc_add_to_protocol (string arg_message);// ----------------------------------------------------------------------
//
// wf_chc_add_to_protocol
//
// Neuer Report! (dsProtocolImport->dw_change_import_protocol)
//
// Message setzen bzw. anf$$HEX1$$fc00$$ENDHEX$$gen
// Anmerkung: Es gibt zweites Statusfeld: compute_status2
//
// ----------------------------------------------------------------------
long		lFind
string	sText

lFind = dsProtocolImport.Find("nresult_key = " + string(lResultKey_Trace),1,dsProtocolImport.RowCount())
if lFind > 0 then
	//
	// Die Message
	//
	sText = dsProtocolImport.GetItemString(lFind,"compute_status")
	if len(stext) > 0 or not isnull(stext) then
		sText = sText + ", " + arg_message
	else
		sText = arg_message
	end if
	dsProtocolImport.SetItem(lFind,"compute_status",sText)

	//nimport_status = 1 wenn ok
end if

f_Log2Csv(0,1,"add to protocol: "+arg_message)
	
return 0


end function

public function boolean wf_chc_change_pax (uo_generate_datastore dspax2);//=================================================================================================
//
// wf_chc_change_pax
//
// Besonderheit: 
// =============
// Alle Markierungen finden im UserObject statt!!!
//
//=================================================================================================
long		i

lRow_dw_pax = dw_pax.GetRow()

//dw_pax.SetRedraw(false)

//
// 01.04.2005:
// Aufgrund von Problemen mit leeren cen_out_pax-Fl$$HEX1$$fc00$$ENDHEX$$gen
// wird vor dem L$$HEX1$$f600$$ENDHEX$$schen gepr$$HEX1$$fc00$$ENDHEX$$ft, ob der zur$$HEX1$$fc00$$ENDHEX$$ck$$HEX1$$fc00$$ENDHEX$$bertragende Datastore nicht leer ist
//
if dspax2.RowCount() > 0 then
	//
	// Falls noch irgendetwas ge$$HEX1$$e400$$ENDHEX$$ndert werden mu$$HEX1$$df00$$ENDHEX$$,
	// bevor dw_spml vernichtet wird.
	//
	for i = dw_pax.RowCount() to 1 step -1
		dw_pax.deleteRow(i)
	next
	//
	// Ergebnisse zur$$HEX1$$fc00$$ENDHEX$$ckschreiben
	//
	//dspax2.RowsCopy(1,dspax2.RowCount(),Primary!,dw_pax,1,Primary!)
	wf_ml_rowscopy_pax(dspax2,1,dspax2.RowCount(), dw_pax,1)
	
	dw_pax.Sort()
	
	//dw_pax.ScrollToRow(lRow_dw_pax)
else
	//
	// Der Fehlerfall: return False setzt in wf_chc_master_change bNoSaving = True
	//
	wf_chc_trace(10,"[wf_chc_change_pax] dspax2.RowCount =0")
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_change_pax] Klasseninformationen sind fehlerhaft. $$HEX1$$c400$$ENDHEX$$nderungen k$$HEX1$$f600$$ENDHEX$$nnen nicht vorgenommen werden!")
	end if
//	dw_pax.SetRedraw(true)
	return false
end if

//dw_pax.SetRedraw(true)

return true

end function

public function boolean wf_chc_change_spml (uo_generate_datastore dsspml);//=================================================================================================
//
// wf_chc_change_spml
//
// $$HEX1$$dc00$$ENDHEX$$bertrag der ge$$HEX1$$e400$$ENDHEX$$nderten SPML nach dw_spml
//
// Besonderheit: 
// =============
// Alle Markierungen finden im UserObject statt!!!
//
//=================================================================================================
long		i
dwitemstatus ii
	

if bDoMealCalculation = true then
	//dw_spml.SetRedraw(false)
	//
	// Falls noch irgendetwas ge$$HEX1$$e400$$ENDHEX$$ndert werden mu$$HEX1$$df00$$ENDHEX$$,
	// bevor dw_spml vernichtet wird.
	//
	for i = dw_spml.RowCount() to 1 step -1
		ii = dw_spml.getitemstatus(i,0,PRIMARY!) 
		if ii = DataModified! or ii = NotModified! then 
			dw_spml.deleteRow(i)
		else
			dw_spml.RowsDiscard(i,i,Primary!)
		end if
	next
	//
	// Ergebnisse zur$$HEX1$$fc00$$ENDHEX$$ckschreiben
	//
	if dsSPML.RowsCopy(1,dsSPML.RowCount(),Primary!,dw_spml,1,Primary!) = -1 and dsSPML.RowCount()>0 then
		f_Log2Csv(0,1,"wf_chc_change_spml: error rowscopy  dsSPML to dw_spml / Source: " + dsSPML.dataobject + " / Target: " + dw_spml.dataobject)
	end if
	dw_spml.Sort()
	//dw_spml.SetRedraw(true)
	
	//
	// Zahlen formatieren
	//
	dw_spml.Modify("nquantity.Format='#,###,##0'")
	dw_spml.Modify("nquantity_old.Format='#,###,##0'")
	
end if

return true


end function

public function boolean wf_chc_change_newspaper (uo_generate_datastore dschanged_handling, uo_generate_datastore dschanged_extra);integer	iReturn
// ---------------------------------------------------
// Lesematerial Ver$$HEX1$$e400$$ENDHEX$$nderungen 
// ---------------------------------------------------
dsCenOutHandlingNews.Reset()
dsCenOutNewsExtra.Reset()
bNewspaperChange			= True

If dsChanged_Handling.rowcount()  > 0 Then
	iReturn = dsChanged_Handling.RowsCopy(1,dsChanged_Handling.rowcount(),Primary!,dsCenOutHandlingNews,1,Primary!)
	If iReturn <> 1 Then
		if bImportMode then
			wf_chc_add_to_protocol(uf.translate("Fehler beim Lesematerial!"))
		else
			f_Log2Csv(0,2,"[wf_chc_change_newspaper] Lesematerial-Beladung kann nicht eingetragen werden.")
		End if
		return False
	End if
End if

If dsChanged_Extra.rowcount()  > 0 Then
	iReturn = dsChanged_Extra.RowsCopy(1,dsChanged_Extra.rowcount(),Primary!,dsCenOutNewsExtra,1,Primary!)
	If iReturn <> 1 Then
		if bImportMode then
			wf_chc_add_to_protocol(uf.translate("Fehler beim Lesematerial!"))
		else
			f_Log2Csv(0,2,"[wf_chc_change_newspaper] Lesematerial-Extrabeladung kann nicht eingetragen werden.")
		End if
		return False
	End if
End if
	
return True

end function

public function boolean wf_chc_change_handling (uo_generate_datastore dschanged);// ---------------------------------------------------
// neu ermitteltes Handling in dw_handling eintragen
// 25.09.2006: Wenn manuelle $$HEX1$$c400$$ENDHEX$$nderungen vorgenommen wurden, 
//					dann ggf. nicht mehr neu ziehen
// ---------------------------------------------------
integer 	i
integer 	iReturn
long		lFound
String	sLoadinglist

if dw_handling.Find("nmanual_input = 1",1,dw_handling.Rowcount()) > 0 then
	if bImportMode then
		return true
	else
		// 18.07.2014 HR: CBASE-NAM-CR-14023web: F$$HEX1$$fc00$$ENDHEX$$r den FlightCalc werten wir den Schalter aus, um zu sehen, dass manuell ge$$HEX1$$e400$$ENDHEX$$ndert wurde

		if dw_single.getitemnumber(dw_single.getrow(), "nlock_loadinglist")=  1 then
			wf_chc_trace(10,"[wf_chc_change_handling] Es wurden manuelle $$HEX1$$c400$$ENDHEX$$nderungen an der Beladung vorgenommen, daher keine Neuberechnung")
			return true
		end if
	end if
end if

// ----------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fung was markiert werden muss
// und anschlie$$HEX1$$df00$$ENDHEX$$end die alten Handlings l$$HEX1$$f600$$ENDHEX$$schen.
// ----------------------------------------------------
For i = dw_handling.Rowcount() to 1 Step -1
	sLoadinglist 	= dw_handling.Getitemstring(i,"cloadinglist")
	lFound 			= dsChanged.find("cloadinglist = '" + sLoadinglist + "'",1,dsChanged.Rowcount())
	// ----------------------------------------------------
	// Dieses Handling ist Neu !
	// ----------------------------------------------------
	If lFound <= 0 Then
		dw_handling.deleterow(i)
	Else	 
		// ------------------------------------------
		// Dieses Handling ist nicht Neu
		// ------------------------------------------
		
		// --------------------------------------------------------------------------------------------------------------------
		// 09.05.2014 HR: 4.99-159: Falls sich die Abfertigung $$HEX1$$e400$$ENDHEX$$ndert, kann es sein das sich PRIO
		//                                       der LOADINGLIST $$HEX1$$e400$$ENDHEX$$ndert, daher muss diese ggf angepa$$HEX1$$df00$$ENDHEX$$t werden
		// --------------------------------------------------------------------------------------------------------------------
		if  dw_handling.Getitemnumber(i,"NPRIO") <>  dsChanged.Getitemnumber(lFound,"NPRIO") then
			 dw_handling.Setitem(i,"NPRIO",  dsChanged.Getitemnumber(lFound,"NPRIO"))
		end if
		
		// --------------------------------------------------------------------------------------------------------------------
		// 09.09.2011 HR: Wir $$HEX1$$fc00$$ENDHEX$$bertragen aber den ACCOUNT und ADDITIONALACCOUNT
		// --------------------------------------------------------------------------------------------------------------------
		dw_handling.setitem(i,"caccount",dsChanged.getitemstring(lFound,"caccount"))
		dw_handling.setitem(i,"naccount_key",dsChanged.getitemnumber(lFound,"naccount_key"))
		dw_handling.setitem(i,"cadditional_account",dsChanged.getitemstring(lFound,"cadditional_account"))
      		
		dsChanged.deleterow(lFound)
	End if	
Next

// -------------------------------------------
// und die neuen eintragen, vorher markieren
// -------------------------------------------
For i = 1 to dsChanged.Rowcount()
	dsChanged.Setitem(i,"status_cloadinglist",1)
Next	

If dsChanged.Rowcount() > 0 Then
	iReturn = dsChanged.RowsCopy(1,dsChanged.rowcount(),Primary!,dw_handling,1,Primary!)
	If iReturn <> 1 Then
		if bImportMode then
			wf_chc_add_to_protocol(uf.translate("Fehler beim Handling!"))
			return False
		else
			f_Log2Csv(0,2,"[wf_chc_change_handling] Handling kann nicht eingetragen werden.")
			return False
		end if
	end if
	
	// ---------------------------------
	// Refresh $$HEX1$$dc00$$ENDHEX$$berschriften
	// ---------------------------------
	For i = 1 to dw_handling.Rowcount()
		dw_handling.Setitem(i,"nposting_type",1)	// Belastung
		If dw_handling.Getitemnumber(i,"nhandling_id") = 1 Then
			dw_handling.Setitem(i,"sys_handling_id_ctext",s_text[1].stext)
			dw_handling.Setitem(i,"sys_handling_id_ctext1",s_text[1].stext1)
			dw_handling.Setitem(i,"sys_handling_id_ctext2",s_text[1].stext2)
			dw_handling.Setitem(i,"sys_handling_id_ctext3",s_text[1].stext3)
			dw_handling.Setitem(i,"sys_handling_id_ctext4",s_text[1].stext4)
		Else
			dw_handling.Setitem(i,"sys_handling_id_ctext",s_text[2].stext)
			dw_handling.Setitem(i,"sys_handling_id_ctext1",s_text[2].stext1)
			dw_handling.Setitem(i,"sys_handling_id_ctext2",s_text[2].stext2)
			dw_handling.Setitem(i,"sys_handling_id_ctext3",s_text[2].stext3)
			dw_handling.Setitem(i,"sys_handling_id_ctext4",s_text[2].stext4)
		End if
	Next	
	
	dw_handling.Sort()
	dw_handling.Groupcalc()
End if

return True

end function

public function boolean wf_chc_change_extra (uo_generate_datastore dsextra);//=================================================================================================
//
// wf_change_extra
//
// $$HEX1$$dc00$$ENDHEX$$bertrag der ge$$HEX1$$e400$$ENDHEX$$nderten Extrabeladung nach dw_meal
//
// Besonderheit: 
// =============
// Alle Markierungen finden im UserObject statt!!!
//
// Unterscheidung bInsertMode:
// ===========================
// Falls bInsertMode = true, dann wurde eine neue Zeile aufgenommen. In diesem Fall wird ein neu-
// aufbereiteter Datastore zur$$HEX1$$fc00$$ENDHEX$$ckgeliefert. Deshalb ist das alte DataWindow komplett zu l$$HEX1$$f600$$ENDHEX$$schen.
//
// Falls ein Masterchange zur$$HEX1$$fc00$$ENDHEX$$ckkommt (bInsertMode = False), also Extrabeladung neu kalkuliert wurde,
// dann d$$HEX1$$fc00$$ENDHEX$$rfen die vorher manuell aufgenommenen Extras nicht gel$$HEX1$$f600$$ENDHEX$$scht werden.
//
//=================================================================================================
long		i

if bDoMealCalculation = true then
	//dw_extra.SetRedraw(false)
	//
	// Falls noch irgendetwas ge$$HEX1$$e400$$ENDHEX$$ndert werden mu$$HEX1$$df00$$ENDHEX$$,
	// bevor dw_meal vernichtet wird.
	//
	for i = dw_extra.RowCount() to 1 step -1
		if bInsertMode then
			dw_extra.deleteRow(i)
		else
////			if dw_extra.GetItemNumber(i,"nmanual_processing") = 0 then
			if dw_extra.GetItemNumber(i,"nmanual_processing") < 2 then	// vorher  0 
//			if dw_extra.GetItemNumber(i,"nmanual_processing") = 0 then 
				//HR 26.11.2008. Pr$$HEX1$$fc00$$ENDHEX$$fung wieder auf =0 gesetzt, da 2 nur bei Mahlzeiten gesetzt wird 
				//HR 31.10.2011: CBASE-NAM-EM-11012: Doch wieder < 2, da Neu aufgenommene Komponenten mit Status 1 generiert werden und dann
				//                                                                  bei der n$$HEX1$$e400$$ENDHEX$$chsten Aufl$$HEX1$$f600$$ENDHEX$$sung mit 0 zur$$HEX1$$fc00$$ENDHEX$$ck kommen.
				dw_extra.deleteRow(i)
			elseif dw_single.getitemstring(1, "chandling_type_text")="REQ" then
			
				// --------------------------------------------------------------------------------------------------------------------
				// 07.10.2016 HR: ALM-ID #1675: Bei REQ soll auch manuell eingegebene Mengen auf 0 gesetzt werden
				// --------------------------------------------------------------------------------------------------------------------
				dw_extra.SetItem(i,"nquantity_old",dw_extra.GetItemNumber(i,"nquantity")) 
				dw_extra.SetItem(i,"nquantity",0)
				dw_extra.SetItem(i,"status_nquantity",1)
			end if
		end if
	next
	

	// --------------------------------------------------------------------------------------------------------------------
	// 12.02.2010 HR: Fehler LSY_2286: Doppelte Zeilen
	// Wenn Handlingobjecte manuell zugeordnet werden kann es vorkommen,
	// dass diese hier stehen bleiben und nochmals mit der Aufl$$HEX1$$f600$$ENDHEX$$sung mitkommen.
	// Daher pr$$HEX1$$fc00$$ENDHEX$$fen wir das und l$$HEX1$$f600$$ENDHEX$$schen dann die Zeile auch noch.
	// --------------------------------------------------------------------------------------------------------------------
	if dw_extra.rowcount()>0 and dsextra.rowcount() >0 then
		for i = dw_extra.RowCount() to 1 step -1
			if dsextra.find(" ndetail_key = "+string(dw_extra.getitemnumber(i,"ndetail_key")),1, dsextra.rowcount())>0 then 
				dw_extra.deleteRow(i)	
			end if
		next
	end if
	
	// Ergebnisse zur$$HEX1$$fc00$$ENDHEX$$ckschreiben
	if dsextra.RowsCopy(1,dsextra.RowCount(),Primary!,dw_extra,1,Primary!) = -1 and dsextra.RowCount()>0 then
		f_Log2Csv(0,1,"wf_chc_change_extra: error rowscopy  dsextra to dw_extra  / Source: " + dsextra.dataobject + " / Target: " + dw_extra.dataobject)
	end if	
	dw_extra.Sort()
//	dw_extra.SetRedraw(true)
end if

return true

end function

public function boolean wf_ml_superrowscopy (datastore dwsource, datastore dwtarget);//-------------------------------------------------------------------------------
// Modifiziertes superrowscopy
//-------------------------------------------------------------------------------

string	sobjectName, sExpr
string	sObjectsSource, sObjectsTarget
string	sSourceColumns[255,2]
string	sTargetColumns[255,2]

integer	i=1, j=1, iAnzSourceCol, iAnzTargetCol, k, iAnzTargetRows

string	sString
long 		lNumber
date		dDate
dateTime	dtDate
decimal	decDecimal

//trace("-------> Starte SuperRowsCopy <-------")

sObjectsSource = dwSource.Describe("DataWindow.Objects")
sObjectsTarget = dwTarget.Describe("DataWindow.Objects")

// Columns von Source
do while Len(sObjectsSource) > 0
	
	sobjectName = f_get_token( sObjectsSource, "~t")	
	
	If dwSource.Describe(sObjectName+".Type") = "column"  or  &
		dwSource.Describe(sObjectName+".Type") = "compute" Then
		sSourceColumns[i,1] = sObjectName
		sSourceColumns[i,2] = dwSource.Describe(sObjectName+".ColType")
		//trace("SourceDW: " + sSourceColumns[i,1] + ":" + sSourceColumns[i,2])
		i++
	End If
	iAnzSourceCol=i - 1
loop


// Columns von Target
do while Len(sObjectsTarget) > 0
	
	sobjectName = f_get_token( sObjectsTarget, "~t")	
	
	If dwTarget.Describe(sObjectName+".Type") = "column" or  &
		dwTarget.Describe(sObjectName+".Type") = "compute" Then
		sTargetColumns[j,1] = sObjectName
		sTargetColumns[j,2] = dwTarget.Describe(sObjectName+".ColType")
		//trace("TargetDW: " + sTargetColumns[j,1] + ":" + sTargetColumns[j,2])
		j++
	End If
	iAnzTargetCol=j - 1
loop

// was issen schon drin im Target???
//iAnzTargetRows = dwTarget.RowCount()
//trace("Rows bereits im Target: " + String(iAnzTargetRows))

// Rows in Target anlegen
for i = 1 to dwSource.RowCount()
	dwTarget.InsertRow(0)
next
//trace("Rows in Target eingefuegt: " + String(i))

// Kopiere Source in Target
for i=1 to iAnzSourceCol
	for j=1 to iAnzTargetCol
		// stimmt Column-Name und Column-Typ $$HEX1$$fc00$$ENDHEX$$berein?
		if sSourceColumns[i,1] = sTargetColumns[j,1] and sSourceColumns[i,2] = sTargetColumns[j,2] then
			sExpr=Left(sSourceColumns[i,2],5)
			Choose Case sExpr
				case "char("
					for k=1 to dwSource.RowCount()
						sString=dwSource.GetItemString(k,sSourceColumns[i,1])
						if dwTarget.SetItem(iAnzTargetRows+k,sSourceColumns[i,1],sString) = 1 then
							//trace(sSourceColumns[i,1] + ":" + sString)
						else
							//trace(sSourceColumns[i,1] + ":Fehler beim Einf$$HEX1$$fc00$$ENDHEX$$gen in TargetDataStore (string)")
						end if
					next
				case "long"
					for k=1 to dwSource.RowCount()
						lNumber=dwSource.GetItemNumber(k,sSourceColumns[i,1])
						if dwTarget.SetItem(iAnzTargetRows+k,sSourceColumns[i,1],lNumber) = 1 then
							//trace(sSourceColumns[i,1] + ":" + String(lNumber))
						else
							//trace(sSourceColumns[i,1] + ":Fehler beim Einf$$HEX1$$fc00$$ENDHEX$$gen in TargetDataStore (number)")
						end if
					next
				case "numbe" 
					for k=1 to dwSource.RowCount()
						lNumber=dwSource.GetItemNumber(k,sSourceColumns[i,1])
						if dwTarget.SetItem(iAnzTargetRows+k,sSourceColumns[i,1],lNumber) = 1 then
							//trace(sSourceColumns[i,1] + ":" + String(lNumber))
						else
							//trace(sSourceColumns[i,1] + ":Fehler beim Einf$$HEX1$$fc00$$ENDHEX$$gen in TargetDataStore (number)")
						end if
					next
				case "decim"
					for k=1 to dwSource.RowCount()
						decDecimal=dwSource.GetItemDecimal(k,sSourceColumns[i,1])
						if dwTarget.SetItem(iAnzTargetRows+k,sSourceColumns[i,1],decDecimal) = 1 then
							//trace(sSourceColumns[i,1] + ":" + String(lNumber))
						else
							//MessageBox("superrowscopy","Fehler Decimal")
							//trace(sSourceColumns[i,1] + ":Fehler beim Einf$$HEX1$$fc00$$ENDHEX$$gen in TargetDataStore (number)")
						end if
					next
				case "date"
					for k=1 to dwSource.RowCount()
						dDate=dwSource.GetItemDate(k,sSourceColumns[i,1])
						if dwTarget.SetItem(iAnzTargetRows+k,sSourceColumns[i,1],dDate) = 1 then
							//trace(sSourceColumns[i,1] + ":" + String(dDate))
						else
							//trace(sSourceColumns[i,1] + ":Fehler beim Einf$$HEX1$$fc00$$ENDHEX$$gen in TargetDataStore (date)")
						end if
					next
				case "datet"
					for k=1 to dwSource.RowCount()
						dtDate=dwSource.GetItemDateTime(k,sSourceColumns[i,1])
						if dwTarget.SetItem(iAnzTargetRows+k,sSourceColumns[i,1],dtDate) = 1 then
							//trace(sSourceColumns[i,1] + ":" + String(dtDate))
						else
							//trace(sSourceColumns[i,1] + ":Fehler beim Einf$$HEX1$$fc00$$ENDHEX$$gen in TargetDataStore (datetime)")
						end if
					next
			End Choose
		end if
	next
next

dwTarget.AcceptText()

//trace("Rows in Target total: " + String(dwTarget.RowCount()))

return True
end function

public function boolean wf_ml_rowscopy_single (datastore dwsource, long lstartrow_source, long lendrow_source, datastore dwtarget, long lstartrow_target);//-------------------------------------------------------------------------------
// Kopieren zwischen den Formaten der Datawindows dw_ml_change_cen_out
// und dw_change_cen_out
//-------------------------------------------------------------------------------
datastore dw_format2	

Integer	li_result
String		ls_dataobject_source 
String		ls_dataobject_target 

dw_format2											= Create datastore
dw_format2.DataObject 							= "dw_change_cen_out"
//dw_format2							= dw_format13  //Format von "dw_change_cen_out"
dw_format2.SetTransObject(SQLCA)

wf_ml_superrowscopy(dwsource, dw_format2)

IF	dw_format2.RowCount() > 0 THEN
	ls_dataobject_source = 	dw_format2.DataObject
	ls_dataobject_target 	= 	dwtarget.DataObject
	li_result = dw_format2.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
	IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_single] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
END IF



return true


end function

public function integer wf_chc_set_old_values ();// ---------------------------------------------------------------
//
// wf_chc_set_old_values
//
// Sichern des urspr. Zustands f$$HEX1$$fc00$$ENDHEX$$r Alt<->Neu-Ermittlung
// nach dem Speichern und w$$HEX1$$e400$$ENDHEX$$hrend des Retrieve-Detail
//
// ---------------------------------------------------------------
integer i

dsExtraOld.Reset()
dsMealOld.Reset()
dsSPMLOld.Reset()
dsPaxOld.Reset()

if not bReadFromHistory then
	if dw_pax.RowCount() > 0 then
		i=dw_pax.RowsCopy(1,dw_pax.RowCount(),Primary!,dsPaxOld,dsPaxOld.RowCount() + 1, Primary!)
		if i = -1 then f_Log2Csv(0,1,"[wf_chc_set_old_values] Error Rowscopy dw_pax  / Source: " + dw_pax.dataobject + " / Target: " + dsPaxOld.dataobject) //28.02.2011 HR: Fehlerpr$$HEX1$$fc00$$ENDHEX$$fung eingebaut
	end if

	if dw_extra.RowCount() > 0 then
		i=dw_extra.RowsCopy(1,dw_extra.RowCount(),Primary!,dsExtraOld,dsExtraOld.RowCount() + 1, Primary!)
		if i = -1 then f_Log2Csv(0,1,"[wf_chc_set_old_values] Error Rowscopy dw_extra  / Source: " + dw_extra.dataobject + " / Target: " + dsExtraOld.dataobject) //28.02.2011 HR: Fehlerpr$$HEX1$$fc00$$ENDHEX$$fung eingebaut
	end if

	if dw_meal.RowCount() > 0 then
		i=dw_meal.RowsCopy(1,dw_meal.RowCount(),Primary!,dsMealOld,dsMealOld.RowCount() + 1, Primary!)
		if i = -1 then f_Log2Csv(0,1,"[wf_chc_set_old_values] Error Rowscopy dw_meal  / Source: " + dw_meal.dataobject + " / Target: " + dsMealOld.dataobject) //28.02.2011 HR: Fehlerpr$$HEX1$$fc00$$ENDHEX$$fung eingebaut
	end if

	if dw_spml.RowCount() > 0 then
		i = dw_spml.RowsCopy(1,dw_spml.RowCount(),Primary!,dsSPMLOld,dsSPMLOld.RowCount() + 1, Primary!)
		if i = -1 then f_Log2Csv(0,1,"[wf_chc_set_old_values] Error Rowscopy dw_spml  / Source: " + dw_spml.dataobject + " / Target: " + dsSPMLOld.dataobject) //28.02.2011 HR: Fehlerpr$$HEX1$$fc00$$ENDHEX$$fung eingebaut
	end if

	//dw_single.RowsCopy(1,dw_single.RowCount(),Primary!,dsSingleOld,dsSingleOld.RowCount() + 1, Primary!)
	wf_ml_superrowscopy(dw_single, dssingleold)
end if

return 0


end function

public function boolean wf_chc_save ();//==============================================================================================
//
// wf_chc_save
//
// $$HEX1$$c400$$ENDHEX$$nderungen Speichern, History schreiben, $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen versenden
//
// F$$HEX1$$fc00$$ENDHEX$$r Monalisa Istdatenbrowser gilt : generell  keine $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen verschicken
//==============================================================================================

// ------------------------------------------------------------------------
// Es werden immer alle Datawindows gespeichert!
// Zeitungsbeladung nur bei Bedarf...
// ------------------------------------------------------------------------

long 				i, lFind
string				sTableName
decimal			dcQuantity
boolean			bSupressChanges		// keine $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen 
												// bei $$HEX1$$dc00$$ENDHEX$$berschreitung der Abflugzeit
integer			iLegNumber

long				lStart, lStop

lStart = CPU()

wf_chc_trace(10,"[wf_chc_save] Begin")

// 25.04.2014 HR: Auf den Anfang von WF_SAVE gesetzt (4.99-093)
//                        Wenn sich der Status ge$$HEX1$$e400$$ENDHEX$$ndert hat, dann ist es immer Wert, dass wir ggf. die 
//                        Daten an JFE $$HEX1$$fc00$$ENDHEX$$bertragen, auch wenn die Paxe gleich geblieben sind
if dw_single.GetItemStatus (dw_single.GetRow(),"nstatus", PRIMARY!) <> NotModified! then
	ibo_changed 	= 	TRUE
else
	ibo_changed 	= 	FALSE
end if

// ------------------------------------------------------------------
// Vorab-Pr$$HEX1$$fc00$$ENDHEX$$fung: Accepttext, SPML
// ------------------------------------------------------------------
if wf_chc_validation() <> 0 then
	wf_chc_trace(10,"[wf_chc_save] wf_chc_validation returns error")
	bInAction = false
	return false
end if

// ------------------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r die Dauer der Ausf$$HEX1$$fc00$$ENDHEX$$hrung keine Aktionen erlauben
// ------------------------------------------------------------------
bInAction = true

// ------------------------------------------------------------------
// Bei der Eingabe von Final Pax gibt es ein verk$$HEX1$$fc00$$ENDHEX$$rztes Verfahren
// ------------------------------------------------------------------

if iFinalPaxMode = 1 then
	wf_chc_save_final_pax()
	bInAction = false
	bforcemealcalculation = false
	bAnychange = false
	return true
end if

// ------------------------------------------------------------------
// Lagen inhaltliche Fehler vor? z.B. Kein Handling
// ------------------------------------------------------------------
If bNoSaving = True Then
	wf_chc_trace(10,"[wf_chc_save] bNoSaving = True")

	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Die aktuellen Ver$$HEX1$$e400$$ENDHEX$$nderungen lassen ein Speichern nicht zu.")
	end if
	bInAction = false
	bforcemealcalculation = false
	bAnychange = false
	return False
End if	
// ------------------------------------------------------------------
// Mu$$HEX2$$df002000$$ENDHEX$$noch eine Mahlzeitenberechnung ausgef$$HEX1$$fc00$$ENDHEX$$hrt werden?
// Ist die Reihenfolge hier ok?
// ------------------------------------------------------------------
//wf_setmessage("Beladung ermitteln")
if wf_chc_force_meal_calculation() = -1 then
	if bImportMode then
		wf_chc_add_to_protocol(uf.translate("Beladung fehlerhaft"))
	else
		f_Log2Csv(0,2,"[wf_chc_save] Die Erstellung der Beladung ist fehlgeschlagen.~rSpeichern ist nicht m$$HEX1$$f600$$ENDHEX$$glich")
	end if
	bInAction = false
	bforcemealcalculation = false
	bAnychange = false
	return False		
end if
Setpointer(HourGlass!)

// ------------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung, ob eine Matdispo angefordert werden mu$$HEX1$$df00$$ENDHEX$$.
// ------------------------------------------------------------------
if lCalculationCounter > 0 or &
	dw_meal.modifiedCount() > 0 or &
	dw_extra.modifiedCount() > 0 or &
	dw_spml.modifiedCount() > 0 then
	if wf_chc_request_explosion() <> 0 then
		bInAction = false
		bforcemealcalculation = false
		bAnychange = false
		return False		
	end if
end if
// ------------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung ob das Abflugdatum gr$$HEX2$$f600df00$$ENDHEX$$er Jetzt ist.
// ------------------------------------------------------------------
/*
If wf_chc_check_departure() = False Then
	if bImportMode then
		if iSaveAfterDeparture = 0 then
			wf_chc_add_to_protocol(uf.translate("Abflugzeit $$HEX1$$fc00$$ENDHEX$$berschritten"))
			bInAction = false
			bforcemealcalculation = false
			bAnychange = false

			//
			// Beim Einlesen m$$HEX1$$fc00$$ENDHEX$$ssen die Eingaben ein Reset erfahren, sonst Meldung
			// "M$$HEX1$$f600$$ENDHEX$$chten Sie speichern?"
			//
			wf_chc_reset_update()
			return False
		else
			bSupressChanges = true
		end if
	else
		if iSaveAfterDeparture = 0 then
			f_Log2Csv(0,2,"[wf_chc_save] Das aktuelle Tagesdatum-/zeit ist gr$$HEX2$$f600df00$$ENDHEX$$er als das Abflugsdatum-/zeit.~rSpeichern ist nicht m$$HEX1$$f600$$ENDHEX$$glich!",Stopsign!)
			bInAction = false
			bforcemealcalculation = false
			bAnychange = false
			return False		
		else
			//
			// 21.07.2005	Falls $$HEX1$$c400$$ENDHEX$$nderungen $$HEX1$$fc00$$ENDHEX$$ber Abflugzeit hinaus gehen, trotzdem
			// $$HEX1$$c400$$ENDHEX$$nderungen versenden
			//
			//f_Log2Csv(0,2,"[wf_chc_save] Das aktuelle Tagesdatum-/zeit ist gr$$HEX2$$f600df00$$ENDHEX$$er als das Abflugsdatum-/zeit.~rEs werden keine $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen erzeugt!",Information!)
	
			// F$$HEX1$$fc00$$ENDHEX$$r Monalisa Istdatenbrowser gilt : generell  keine $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen verschicken
		/*	if iForceTimeChange = 0 then
				if f_Log2Csv(0,2,"[wf_chc_save] Das aktuelle Tagesdatum-/zeit ist gr$$HEX2$$f600df00$$ENDHEX$$er als das Abflugsdatum-/zeit.~rBitte pr$$HEX1$$fc00$$ENDHEX$$fen Sie die Abflugzeit." + &
								"~r~rM$$HEX1$$f600$$ENDHEX$$chten Sie $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen versenden?",Question!,YesNo!,1) = 1 then
					bSupressChanges = false
				else
					bSupressChanges = true
				end if
			else
				// 24.08.2005: Betriebliches Setup entscheidet
				f_Log2Csv(0,2,"[wf_chc_save] Das aktuelle Tagesdatum-/zeit ist gr$$HEX2$$f600df00$$ENDHEX$$er als das Abflugsdatum-/zeit.~rEs werden keine $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen erzeugt!",Information!)
				bSupressChanges = true
			end if */ 
		end if
	end if
End if
*/



// F$$HEX1$$fc00$$ENDHEX$$r Monalisa Istdatenbrowser gilt : generell  keine $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen verschicken
//bSupressChanges = true

// 20.12.2013 HR: Neue Funktion f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen
bSupressChanges = of_check_do_aenderungsmitteilung()
//uo_messages.bDebug = true

// ------------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung, ob es eine Sammelst$$HEX1$$fc00$$ENDHEX$$ckliste gibt.
// ------------------------------------------------------------------

If wf_chc_check_loading_list() = False Then
	if bImportMode then
		wf_chc_add_to_protocol(uf.translate("keine Standardbeladung"))
		bInAction = false
		bforcemealcalculation = false
		bAnychange = false
		return False		
	else
		//
		// Ber$$HEX1$$fc00$$ENDHEX$$cksichtigung von REQ/CNX: Nur "normale" Fl$$HEX1$$fc00$$ENDHEX$$ge brauchen eine Standardbeladung!
		//
		if dw_single.GetItemNumber(dw_single.GetRow(),"nflight_status") = 0 then
			f_Log2Csv(0,2,"[wf_chc_save] Dieser Flug hat keine Standardbeladung.~rSpeichern ist nicht m$$HEX1$$f600$$ENDHEX$$glich!")
			bInAction = false
			bforcemealcalculation = false
			bAnychange = false
			return False		
		end if
	end if
End if
// ------------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung, ob es neue G$$HEX1$$fc00$$ENDHEX$$ltigkeiten f$$HEX1$$fc00$$ENDHEX$$r Sammelst$$HEX1$$fc00$$ENDHEX$$cklisten gibt.
// ------------------------------------------------------------------	
wf_chc_check_loadinglist()

// ------------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung, ob es neue G$$HEX1$$fc00$$ENDHEX$$ltigkeiten f$$HEX1$$fc00$$ENDHEX$$r Sammelst$$HEX1$$fc00$$ENDHEX$$cklisten gibt.
// ------------------------------------------------------------------	
for i = 1 to dw_handling.RowCount()
	if dw_handling.GetItemNumber(i,"new_row") = 1 then
		lFind = dw_handling.Find("new_row = 0 and cloadinglist = '" + dw_handling.GetItemString(i,"cloadinglist") + "'",1,dw_handling.RowCount())
		if lFind > 0 then
			if not bimportmode then
				f_Log2Csv(0,2,"[wf_chc_save] Sie d$$HEX1$$fc00$$ENDHEX$$rfen nicht mehrmals die gleiche Sammelst$$HEX1$$fc00$$ENDHEX$$ckliste verwenden!")
				bAnychange = false
				return false
			end if
		end if
	end if
next

// ------------------------------------------------------------------
// Status der Datawindows setzen und neuen lTransActionKey lesen
// ------------------------------------------------------------------
//wf_setmessage("Status setzen")
If not wf_chc_set_changed_status() Then
	bInAction = false
	bAnychange = false
	return False
End if
// ------------------------------------------------------------------------
// Detaillierte Informationen zu den $$HEX1$$c400$$ENDHEX$$nderungen 
// ------------------------------------------------------------------------
//wf_setmessage("$$HEX1$$c400$$ENDHEX$$nderungsinformationen setzen")
If not wf_chc_changed_information() Then
	bInAction = false
	bAnychange = false
	return False
End if
// ------------------------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fung, ob Flug eine Belegnummer hat 
// ------------------------------------------------------------------------
if isnull(dw_single.GetItemNumber(dw_single.GetRow(),"nbilling_key")) then
	dw_single.SetItem(dw_single.GetRow(),"nbilling_key",dw_single.GetItemNumber(dw_single.GetRow(),"nresult_key_group"))
end if
// ------------------------------------------------------------------------
// 22.04.05	Pr$$HEX1$$fc00$$ENDHEX$$fung, ob Flug eine Neuaufnahme war 
// ------------------------------------------------------------------------
if dw_single.GetItemNumber(dw_single.GetRow(),"nnew_flight") = 1 then
	dw_single.SetItem(dw_single.GetRow(),"nnew_flight",0)
end if
// ------------------------------------------------------------------------
// 17.10.05	Pr$$HEX1$$fc00$$ENDHEX$$fung, ob Passagiere ge$$HEX1$$e400$$ENDHEX$$ndert wurden und auch tats. neu be-
//				rechnet wurde
// ------------------------------------------------------------------------
if bPaxModified = true then
	if bMealsCalculated = false then
		if bImportMode then
			wf_chc_add_to_protocol(uf.translate("Keine Neuberechnung"))
		else
			f_Log2Csv(0,2,"[wf_chc_save] Es ist keine Neuberechnung der Mahlzeiten erfolgt.")
		end if
		bInAction = false
		bAnychange = false
		return False
	end if
end if

// --------------------------------------------------------------------------------------------------------------------
// 09.03.2015 HR: Anpassungen f$$HEX1$$fc00$$ENDHEX$$r Flightchecker Teil II
// --------------------------------------------------------------------------------------------------------------------
if ib_checkpoint_acchange then
	dw_single.SetItem(dw_single.GetRow(),"nhas_ac_change", 1)
end if

// ------------------------------------------------------------------------
// 30.11.05	Flug wurde in Flug-Browser ge$$HEX1$$e400$$ENDHEX$$ndert
// ------------------------------------------------------------------------
dw_single.SetItem(dw_single.GetRow(),"nadd_delivery",0)

dw_single.SetItem(dw_single.GetRow(),"nstatus",lnew_cen_out_nstatus)

// ------------------------------------------------------------------------
// Speichern von dw_single
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der Fluginformationen")
If dw_single.Update() <> 1 Then
	rollback ;
	if bImportMode then
		wf_chc_add_to_protocol(uf.translate("Speichern fehlgeschlagen"))
	else
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der Fluginformationen.")
	end if
	bInAction = false
	bAnychange = false
	return False
End if
// ------------------------------------------------------------------------
// Speichern von dw_single History
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der History Fluginformationen")
	dw_single.ResetUpdate()
sTableName	= dw_single.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_single.Rowcount()
		dw_single.Setitemstatus(i,0,Primary!,NewModified!)
Next

dw_single.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

If dw_single.update() = -1 Then
	rollback ;
	if bImportMode then
		wf_chc_add_to_protocol(uf.translate("History fehlgeschlagen"))
	else
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der History Fluginformationen.")
	end if
	dw_single.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	bAnychange = false
	return False
Else
	dw_single.Object.DataWindow.Table.UpdateTable = sTableName
End if
// ------------------------------------------------------------------------
// Speichern von dw_pax
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der Passagierinformationen")
// --------------------------------------------------------
// Falls andere Paxfelder anstelle anderer Felder genutzt werden sollen, so erfolgt hier ggf. die Umsetzung auf die Originalwerte
//
// --------------------------------------------------------

if this.ifunction_pax_type <>  this.ifunction_use_as_pax_type then
	 of_restore_pax_type()
end if

// --------------------------------------------------------
// Falls andere verisonsfelder anstelle anderer Felder genutzt werden sollen, so erfolgt hier ggf. die Umsetzung auf die Originalwerte
// --------------------------------------------------------
if this.ifunction_actype <>  this.ifunction_use_as_actype then
	 of_restore_version()
end if


If dw_pax.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der Passagierinformationen.")
	end if
	bInAction = false
	bAnychange = false
	return False
ELSE

	// --------------------------------------------------------------------------------------------------------------------
	// 22.07.2013 HR: $$HEX1$$dc00$$ENDHEX$$bernahme aus Flugbrowser
	// --------------------------------------------------------------------------------------------------------------------
	// Wurden Pax oder Comments ge$$HEX1$$e400$$ENDHEX$$ndert ?
	wf_check_pax_comment_changed()
	// Wenn Pax oder Comments ge$$HEX1$$e400$$ENDHEX$$ndert wurden ...
	IF 	ibo_changed THEN
		// Ggf. JFE-Daten (Journey Front End) transferieren
		wf_transfer_jfe()
	END IF
End if	

// ------------------------------------------------------------------------
// Speichern von dw_pax History
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der History Passagierinformationen")
	dw_pax.ResetUpdate()

sTableName	= dw_pax.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_pax.Rowcount()
		dw_pax.Setitemstatus(i,0,Primary!,NewModified!)

Next
dw_pax.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
If dw_pax.update() = -1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der History Passagierinformationen.")
	end if
	dw_pax.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	bAnychange = false
	return False
Else
	dw_pax.Object.DataWindow.Table.UpdateTable = sTableName
End if

// ------------------------------------------------------------------------
// Speichern von dw_handling
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der Handlinginformationen")
If dw_handling.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der Handlinginformationen.")
	end if
	bInAction = false
	bAnychange = false
	return False
End if
// ------------------------------------------------------------------------
// Speichern von dw_handling History
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der History Handlinginformationen")
	dw_handling.ResetUpdate()

sTableName	= dw_handling.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_handling.Rowcount()
		dw_handling.Setitemstatus(i,0,Primary!,NewModified!)
Next
dw_handling.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
If dw_handling.update() = -1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der History Passagierinformationen.")
	end if
	dw_handling.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	bAnychange = false
	return False
Else
	dw_handling.Object.DataWindow.Table.UpdateTable = sTableName
End if

// ------------------------------------------------------------------------
// Speichern von Textinformationen
// ------------------------------------------------------------------------
Integer iTextInfoSaved
/*
wf_setmessage("Speichern der Textinformationen")
If dw_text_info.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der Textinformationen.")
	end if
	bInAction = false
	return False
else
	iTextInfoSaved = 1
End if

If dw_text_infos_areas.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der Textinformationen f$$HEX1$$fc00$$ENDHEX$$r Bereiche.")
	end if
	bInAction = false
	return False
End if
// ------------------------------------------------------------------------
// Speichern von Textinformationen History
// ------------------------------------------------------------------------
wf_setmessage("Speichern der History Textinformationen")
dw_text_info.ResetUpdate()
sTableName	= dw_text_info.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_text_info.Rowcount()
	dw_text_info.Setitemstatus(i,0,Primary!,NewModified!)
Next
dw_text_info.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
If dw_text_info.update() = -1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der History Textinformationen.")
	end if
	dw_text_info.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dw_text_info.Object.DataWindow.Table.UpdateTable = sTableName
End if

dw_text_infos_areas.ResetUpdate()
sTableName	= dw_text_infos_areas.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_text_infos_areas.Rowcount()
	dw_text_infos_areas.Setitemstatus(i,0,Primary!,NewModified!)
Next
dw_text_infos_areas.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
If dw_text_infos_areas.update() = -1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der History Textinformationen f$$HEX1$$fc00$$ENDHEX$$r Bereiche.")
	end if
	dw_text_infos_areas.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dw_text_infos_areas.Object.DataWindow.Table.UpdateTable = sTableName
End if
*/
// ------------------------------------------------------------------------
// Speichern von dw_extra
// ------------------------------------------------------------------------

wf_chc_trace(10,"[wf_chc_save] Speichern der Extrabeladung Start")
//wf_setmessage("Speichern der Extrabeladung")
If dw_extra.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der Extrabeladung.")
	end if
	bInAction = false
	return False
End if
wf_chc_trace(10,"[wf_chc_save] Speichern der Extrabeladung Ende")
// ------------------------------------------------------------------------
// Speichern von dw_extra History
// ------------------------------------------------------------------------
wf_chc_trace(10,"[wf_chc_save] Speichern der History Extrabeladung Start")
//wf_setmessage("Speichern der History Extrabeladung.")

	dw_extra.ResetUpdate()
sTableName	= dw_extra.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_extra.Rowcount()
		dw_extra.Setitemstatus(i,0,Primary!,NewModified!)
Next
dw_extra.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
If dw_extra.update() = -1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der History Extrabeladung.")
	end if
	dw_extra.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dw_extra.Object.DataWindow.Table.UpdateTable = sTableName
End if

wf_chc_trace(10,"[wf_chc_save] Speichern der History Extrabeladung Ende")

// ------------------------------------------------------------------------
// Speichern von dw_meal
// ------------------------------------------------------------------------

wf_chc_trace(10,"[wf_chc_save] Speichern der Mahlzeitenbeladung Start")
//wf_setmessage("Speichern der Mahlzeitenbeladung")
i=dw_meal.Rowcount()
If dw_meal.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der Mahlzeitenbeladung.")
	end if
	bInAction = false
	return False
End if
wf_chc_trace(10,"[wf_chc_save] Speichern der Mahlzeitenbeladung Ende")
// ------------------------------------------------------------------------
// Speichern von dw_meal History
// ------------------------------------------------------------------------
wf_chc_trace(10,"[wf_chc_save] Speichern der History Mahlzeitenbeladung Start")
//wf_setmessage("Speichern der History Mahlzeitenbeladung.")
	dw_meal.ResetUpdate()
sTableName	= dw_meal.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_meal.Rowcount()
		dw_meal.Setitemstatus(i,0,Primary!,NewModified!)
Next
dw_meal.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
If dw_meal.update() = -1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der History Mahlzeitenbeladung.")
	end if
	dw_meal.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dw_meal.Object.DataWindow.Table.UpdateTable = sTableName
End if

wf_chc_trace(10,"[wf_chc_save] Speichern der History Mahlzeitenbeladung Ende")
// ------------------------------------------------------------------------
// Speichern von dw_spml
// ------------------------------------------------------------------------
wf_chc_trace(10,"[wf_chc_save] Speichern der Special Meal Start")

//wf_setmessage("Speichern der Special Meal")
//dwitemstatus ii, i2
//for i = 1 to dw_spml.rowcount()
//		ii = dw_spml.getitemstatus(i,0,PRIMARY!)
//		i2 = dw_spml.getitemstatus(i,0,DELETE!)
//next	
If dw_spml.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der Special Meal. "+dw_spml.sSQLErrorText)
	end if

	bInAction = false
	return False
End if

wf_chc_trace(10,"[wf_chc_save] Speichern der Special Meal Ende")

// ------------------------------------------------------------------------
// Speichern von dw_spml History
// ------------------------------------------------------------------------
wf_chc_trace(10,"[wf_chc_save] Speichern der Special Meal History Start")

//wf_setmessage("Speichern der History Special Meal.")
	dw_spml.ResetUpdate()

sTableName	= dw_spml.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_spml.Rowcount()
		dw_spml.Setitemstatus(i,0,Primary!,NewModified!)
Next
dw_spml.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
If dw_spml.update() = -1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der History Special Meal.")
	end if
	dw_spml.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dw_spml.Object.DataWindow.Table.UpdateTable = sTableName
End if
// ------------------------------------------------------------------------
// Speichern SPML-Details
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der Special Meal Details")
If dsSPMLDetail.update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der Special Meal Details.")
	end if
	//f_print_datastore(dsSPMLDetail)
	bInAction = false
	return False
End if
// ------------------------------------------------------------------------
// Speichern SPML-Details-History
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der History der Special Meal Details")

	dsSPMLDetail.ResetUpdate()
sTableName	= dsSPMLDetail.Object.DataWindow.Table.UpdateTable
For i = 1 to dsSPMLDetail.Rowcount()
			dsSPMLDetail.Setitemstatus(i,0,Primary!,NewModified!)
Next
dsSPMLDetail.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
//f_print_datastore(dsSPMLDetail)
If dsSPMLDetail.update() <> 1 Then
	rollback ;
	
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der Special Meal Details History.")
	end if
	//f_print_datastore(dsSPMLDetail)
	dsSPMLDetail.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dsSPMLDetail.Object.DataWindow.Table.UpdateTable = sTableName
End if
wf_chc_trace(10,"[wf_chc_save] Speichern der Special Meal History Ende")
// ------------------------------------------------------------------------
// Zeitungsbeladung
// ------------------------------------------------------------------------
If	bNewspaperChange = True Then
	// ------------------------------------------------------------------------
	// L$$HEX1$$f600$$ENDHEX$$schen der kompletten Zeitungsbeladung f$$HEX1$$fc00$$ENDHEX$$r diesen Flug
	// aber nur nach einem AC-Change, da dann das Lesematerial neu
	// ermittelt wurde
	// ------------------------------------------------------------------------
	delete from cen_out_news where nresult_key = :lResultKey_Trace;
	If SQLCA.SQLCODE <> 0 Then
		rollback ;
		if not bImportMode then
			f_Log2Csv(0,2,"[wf_chc_save] Fehler beim L$$HEX1$$f600$$ENDHEX$$schen der Lesematerial-Beladung.")
		end if
		bInAction = false
		return False
	End if

	delete from cen_out_news_extra where nresult_key = :lResultKey_Trace;
	If SQLCA.SQLCODE <> 0 Then
		rollback ;
		if not bImportMode then
			f_Log2Csv(0,2,"[wf_chc_save] Fehler beim L$$HEX1$$f600$$ENDHEX$$schen der Lesematerial-Extrabeladung.")
		end if
		bInAction = false
		return False
	End if
End if
// ------------------------------------------------------------------------
// Speichern von dsCenOutHandlingNews
// ------------------------------------------------------------------------
If dsCenOutHandlingNews.rowcount()  > 0 Then
	//wf_setmessage("Speichern der Lesematerial-Beladung")
	If dsCenOutHandlingNews.Update() <> 1 Then
		rollback ;
		if not bImportMode then
			f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der Lesematerial-Beladung.")
		end if
		bInAction = false
		return False
	End if
	// ------------------------------------------------------------------------
	// Speichern von dsCenOutHandlingNews History
	// ------------------------------------------------------------------------
//	wf_setmessage("Speichern der History Lesematerial-Beladung.")
	dsCenOutHandlingNews.ResetUpdate()
	sTableName	= dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutHandlingNews.Rowcount()
		dsCenOutHandlingNews.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
			
	If dsCenOutHandlingNews.update() = -1 Then
		rollback ;
		if not bImportMode then
			f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der History Lesematerial-Beladung.")
		end if
		dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable = sTableName
		bInAction = false
		return False
	Else
		dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable = sTableName
	End if
End if
// ------------------------------------------------------------------------
// Speichern von dsCenOutNewsExtra
// ------------------------------------------------------------------------
If dsCenOutNewsExtra.rowcount()  > 0 Then
	//wf_setmessage("Speichern der Lesematerial-Extrabeladung")
	If dsCenOutNewsExtra.Update() <> 1 Then
		rollback ;
		if not bImportMode then
			f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der Lesematerial-Extrabeladung.")
		end if
		bInAction = false
		return False
	End if
	// ------------------------------------------------------------------------
	// Speichern von dsCenOutNewsExtra History
	// ------------------------------------------------------------------------
	//wf_setmessage("Speichern der History Lesematerial-Extrabeladung.")
	dsCenOutNewsExtra.ResetUpdate()
	sTableName	= dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutNewsExtra.Rowcount()
		dsCenOutNewsExtra.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
	
	If dsCenOutNewsExtra.update() = -1 Then
		rollback ;
		if not bImportMode then
			f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der History Lesematerial-Extrabeladung.")
		end if
		dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable = sTableName
		bInAction = false
		return False
	Else
		dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable = sTableName
	End if
End if
// ------------------------------------------------------------------------
// Speichern von dsChangeInformation
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der $$HEX1$$c400$$ENDHEX$$nderungsinformationen")
If dsChangeInformation.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save] Fehler beim Speichern der $$HEX1$$c400$$ENDHEX$$nderungsinformationen.")
	end if
	bInAction = false
	return False
End if
// ------------------------------------------------------------------------
// Und nun der Commit, und Save Button aus
// ------------------------------------------------------------------------
if bEnableCommit then
	commit ;
end if
// WAB: Galleygewichte schicken
IF ib_wab_send THEN
	wf_wab_send_galleyweights(lResultKey)
END IF

// ------------------------------------------------------------------------
// Doc Gen Queue (Einstellen Result Key in cen_doc_gen_queue)
// 26.03.2013 HR: Aus Tag4.92 $$HEX1$$fc00$$ENDHEX$$bernommen
// ------------------------------------------------------------------------
uo_doc_gen_queue luo_doc_gen_queue
integer li_Succ
If integer(f_mandant_profilestring(sqlca, s_app.smandant, "DocumentEngine","EnableChangeCenterQueue","0")) = 1 Then
	luo_doc_gen_queue = create uo_doc_gen_queue
	
	luo_doc_gen_queue.bCommit = bEnableCommit
	li_Succ = luo_doc_gen_queue.of_enqueue_flight( lResultKeyCenOut)
	wf_chc_trace(1,"[wf_chc_save] Doc Gen Queue returns "+string(li_Succ))
	destroy luo_doc_gen_queue
else
	wf_chc_trace(10,"[wf_chc_save] No DocGenQueue")
End if

// --------------------------------------------------------------------------------------------------------------------
// 09.03.2015 HR: Anpassungen f$$HEX1$$fc00$$ENDHEX$$r Flightchecker Teil II
// --------------------------------------------------------------------------------------------------------------------
if ib_checkpoint_acchange or ib_checkpoint_cx or ib_checkpoint_cx_undo then
	uo_generate  uo_gen
	
	uo_gen = create uo_generate
	if ib_checkpoint_acchange then
		uo_gen.of_checkpoint_push( dw_single.getitemnumber(dw_single.getrow(),"nresult_key"), 1)
	end if
	
	if ib_checkpoint_cx then
		uo_gen.of_checkpoint_push( dw_single.getitemnumber(dw_single.getrow(),"nresult_key"), 2)
	end if
	
	if ib_checkpoint_cx_undo then
		uo_gen.of_checkpoint_push( dw_single.getitemnumber(dw_single.getrow(),"nresult_key"), 3)
	end if
	
	destroy uo_gen
end if

// ------------------------------------------------------------------------
// Alt-Neu-Berechnung
// ------------------------------------------------------------------------
//wf_chc_set_old_values()

for i = 1 to dw_extra.RowCount()
	dw_extra.SetItem(i,"edit_counter",0)
	dw_extra.SetItemStatus(i, 0, Primary!, NotModified!)	// Ganze Row auf NotModified!
next
for i = 1 to dw_meal.RowCount()
	dw_meal.SetItem(i,"edit_counter",0)
	dw_meal.SetItemStatus(i, 0, Primary!, NotModified!)	// Ganze Row auf NotModified!
next

// ------------------------------------------------------------------------
// Versenden der $$HEX1$$c400$$ENDHEX$$nderungen nach dem commit
// ------------------------------------------------------------------------
if not bSupressChanges then
//	wf_setmessage("Versende $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen.")

	iLegNumber = dw_single.GetItemNumber(1,"nleg_number")
	if not uo_messages.uf_generate_message(sViewUnit, lresultkey, ltransactionkey,iLegNumber) then
		wf_chc_trace(10,"[wf_chc_save] Fehler beim Versenden von $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen.")
		rollback ;
		bMultiLegError = true
	else
		wf_chc_trace(10,"[wf_chc_save] $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen erfolgreich gespeichert.")
		commit ;
	end if

end if
//pb_save.Enabled 	= False
// ------------------------------------------------------------------------
// Flug$$HEX1$$fc00$$ENDHEX$$bersicht erst nach Erfolg aktualisieren
// ------------------------------------------------------------------------
//if bCancelAction = true then
/*
dw_1.SetItem(dw_1.Getrow(),"ctlc_to",dw_single.GetItemString(dw_single.Getrow(),"ctlc_to"))
dw_1.SetItem(dw_1.Getrow(),"cregistration",dw_single.GetItemString(dw_single.Getrow(),"cregistration"))
dw_1.SetItem(dw_1.Getrow(),"nflight_status",dw_single.GetItemNumber(dw_single.Getrow(),"nflight_status"))
dw_1.SetItem(dw_1.Getrow(),"nflight_number",dw_single.GetItemNumber(dw_single.Getrow(),"nflight_number"))
dw_1.SetItem(dw_1.Getrow(),"csuffix",dw_single.GetItemString(dw_single.Getrow(),"csuffix"))
dw_1.SetItem(dw_1.Getrow(),"chandling_type_text",dw_single.GetItemString(dw_single.Getrow(),"chandling_type_text"))
dw_1.SetItem(dw_1.Getrow(),"cdeparture_time",dw_single.GetItemString(dw_single.Getrow(),"cdeparture_time"))
dw_1.SetItem(dw_1.Getrow(),"ckitchen_time",dw_single.GetItemString(dw_single.Getrow(),"ckitchen_time"))
dw_1.SetItem(dw_1.Getrow(),"cramp_time",dw_single.GetItemString(dw_single.Getrow(),"cramp_time"))
dw_1.SetItem(dw_1.Getrow(),"cairline_owner",dw_single.GetItemString(dw_single.Getrow(),"cairline_owner"))
dw_1.SetItem(dw_1.Getrow(),"cactype",dw_single.GetItemString(dw_single.Getrow(),"cactype"))
dw_1.SetItem(dw_1.Getrow(),"cconfiguration",dw_single.GetItemString(dw_single.Getrow(),"cconfiguration"))
dw_1.SetItem(dw_1.Getrow(),"dtimestamp",dw_single.GetItemDateTime(dw_single.Getrow(),"dtimestamp"))
*/
//end if
//	dw_1.reselectrow(dw_1.Getrow())	// l$$HEX1$$f600$$ENDHEX$$st wahrsch. retrieve-detail aus
// ------------------------------------------------------------------------
// Speicher Status und Annullierung Status Reset
// ------------------------------------------------------------------------
bNoSaving 			= False
bCancelAction		= False
bNewspaperChange	= False
bMealChange			= False
bManualChanges 	= false
// -------------------------------------------------------------------------
// Ist ein Flug im Modus 5 oder > 6 dann ist der Flug im Read only Modus
// -------------------------------------------------------------------------
//wf_chc_set_datawindow_modus()
bInAction = false
// -------------------------------------------------------------------------
// Jetzt noch ein Retrieve-Detail, um alle Statusfelder zu resetten
// (ist Notwendig f$$HEX1$$fc00$$ENDHEX$$r korrekte Eintragungen in cen_out_changes)
// -------------------------------------------------------------------------
//	wf_setmessage("Hole aktuelle Daten...")
//	wf_chc_retrieve_detail(lmasterrow)

// -------------------------------------------------------------------------
// Falls Aircraft-Change $$HEX1$$fc00$$ENDHEX$$ber mehrere Legs gew$$HEX1$$fc00$$ENDHEX$$nscht ist
// -------------------------------------------------------------------------
if not bImportMode then
	if bChangeMultipleLegs then
		//
		// Falls das letzte Leg gespeichert wurde, dann alles zur$$HEX1$$fc00$$ENDHEX$$cksetzen
		//
		if dw_single.GetItemNumber(1,"nleg_number") = strMultipleChange.lcountlegs	then
			bChangeMultipleLegs = false
			strMultipleChange = strEmpty
			bAnychange = false
			return true
		end if
	
//		wf_setmessage("Lese n$$HEX1$$e400$$ENDHEX$$chstes Leg...")
//		tab_1.Selectedtab = itab_1_flights
		yield()
		//
		// Registration nochmal checken
		//
		if dw_single.GetItemNumber(1,"nleg_number") = 1 then
			strMultipleChange.sregistration		= dw_single.GetitemString(dw_single.Getrow(),"cregistration")
		end if
	
		//
		// Vorher pr$$HEX1$$fc00$$ENDHEX$$fen, ob das "neu angesprungene" Leg zum bearbeiteten Flug geh$$HEX1$$f600$$ENDHEX$$rt
		//
//		if lMasterRow < dw_1.RowCount() then
//			dw_1.ScrollToRow(lMasterRow + 1)
//			tab_1.Selectedtab = itab_1_flight_single
			// Button Triggern
//			pb_cool.PostEvent("clicked")
//		end if
	
	end if
end if

// -------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungen zur$$HEX1$$fc00$$ENDHEX$$cksetzen
// -------------------------------------------------------------------------
strUserChanges	= strUserChangesEmpty

// -------------------------------------------------------------------------
// Speicher aufr$$HEX1$$e400$$ENDHEX$$umen
// -------------------------------------------------------------------------
//wf_setmessage("GarbageCollect")
wf_chc_trace(10,"[wf_chc_save] GarbageCollect")
GarbageCollect()

//wf_setmessage("Ready")
lStop = CPU()

if ((lStop - lStart) / 1000) > 7 then
	lStop -= 2000
end if

//Nochmal die Daten aus der Datenbank holen, damit PB 10 zufrieden ist.
//Ansonsten kommt ein SQL Fehler, wenn man 2mal den Textinhalt $$HEX1$$e400$$ENDHEX$$ndert
//wf_chc_retrieve_detail(lmasterrow)

/*if iTextInfoSaved = 1 then
	dw_text_info.Retrieve(lResultKey)
end if
*/
//wf_setmessage("Ready in " + string((lStop - lStart) / 1000, "00.000") + " seconds.")

wf_chc_trace(10,"[wf_chc_save] Fertig")

bAnychange = false

Return True

end function

public function integer wf_chc_force_meal_calculation ();//===================================================================================
//
// wf_chc_force_meal_calculation
//
// Abfrage ob Mahlzeitenberechnung notwendig ist und Ausf$$HEX1$$fc00$$ENDHEX$$hren eines Masterchanges
//
//===================================================================================
if bForceMealCalculation = true then
	if wf_chc_master_change() = false then
		//
		// Wenn's nicht klappt, dann braucht er es auch nicht mehr zu probieren
		//
		bForceMealCalculation = false
		bNoSaving = True		
		return -1
	end if
	bForceMealCalculation = false
end if

return 0
end function

public function boolean wf_chc_save_final_pax ();//
//
//
// 19.12.2007 Speichern Final Pax ohne Masterchange
//
string	sTableName
long	i, lstop, lstart

lStart = CPU()

// ------------------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r die Dauer der Ausf$$HEX1$$fc00$$ENDHEX$$hrung keine Aktionen erlauben
// ------------------------------------------------------------------
bInAction = true

// ------------------------------------------------------------------
// Lagen inhaltliche Fehler vor? z.B. Kein Handling
// ------------------------------------------------------------------
If bNoSaving = True Then
	wf_chc_trace(10,"[wf_chc_save_final_pax] bNoSaving = True")

	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Die aktuellen Ver$$HEX1$$e400$$ENDHEX$$nderungen lassen ein Speichern nicht zu.")
	end if
	bInAction = false
	bforcemealcalculation = false
	return false
End if	

// ------------------------------------------------------------------
// Status der Datawindows setzen und neuen lTransActionKey lesen
// ------------------------------------------------------------------
//wf_setmessage("Status setzen")
If not wf_chc_set_changed_status() Then
	bInAction = false
	return False
End if
// ------------------------------------------------------------------------
// Detaillierte Informationen zu den $$HEX1$$c400$$ENDHEX$$nderungen 
// ------------------------------------------------------------------------
//wf_setmessage("$$HEX1$$c400$$ENDHEX$$nderungsinformationen setzen")

If not wf_chc_changed_information() Then
	bInAction = false
	return False
End if
// ------------------------------------------------------------------------
// 30.11.05	Flug wurde in Flug-Browser ge$$HEX1$$e400$$ENDHEX$$ndert
// ------------------------------------------------------------------------
dw_single.SetItem(dw_single.GetRow(),"nadd_delivery",0)

// ------------------------------------------------------------------------
// Speichern von dw_single
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der Fluginformationen")
If dw_single.Update() <> 1 Then
	rollback ;
	if bImportMode then
		wf_chc_add_to_protocol(uf.translate("Speichern fehlgeschlagen"))
	else
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der Fluginformationen.")
	end if
	bInAction = false
	return False
End if
// ------------------------------------------------------------------------
// Speichern von dw_single History
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der History Fluginformationen")
dw_single.ResetUpdate()
sTableName	= dw_single.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_single.Rowcount()
	dw_single.Setitemstatus(i,0,Primary!,NewModified!)
Next

dw_single.Object.DataWindow.Table.UpdateTable = sTableName + "_history"

If dw_single.update() = -1 Then
	rollback ;
	if bImportMode then
		wf_chc_add_to_protocol(uf.translate("History fehlgeschlagen"))
	else
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der History Fluginformationen.")
	end if
	dw_single.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dw_single.Object.DataWindow.Table.UpdateTable = sTableName
End if
// ------------------------------------------------------------------------
// Speichern von dw_pax
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der Passagierinformationen")
If dw_pax.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der Passagierinformationen.")
	end if
	bInAction = false
	return False
End if
// ------------------------------------------------------------------------
// Speichern von dw_pax History
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der History Passagierinformationen")
dw_pax.ResetUpdate()
sTableName	= dw_pax.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_pax.Rowcount()
	dw_pax.Setitemstatus(i,0,Primary!,NewModified!)
Next
dw_pax.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
If dw_pax.update() = -1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der History Passagierinformationen.")
	end if
	dw_pax.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dw_pax.Object.DataWindow.Table.UpdateTable = sTableName
End if

// ------------------------------------------------------------------------
// Speichern von dw_handling
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der Handlinginformationen")
If dw_handling.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der Handlinginformationen.")
	end if
	bInAction = false
	return False
End if
// ------------------------------------------------------------------------
// Speichern von dw_handling History
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der History Handlinginformationen")
dw_handling.ResetUpdate()
sTableName	= dw_handling.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_handling.Rowcount()
	dw_handling.Setitemstatus(i,0,Primary!,NewModified!)
Next
dw_handling.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
If dw_handling.update() = -1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der History Passagierinformationen.")
	end if
	dw_handling.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dw_handling.Object.DataWindow.Table.UpdateTable = sTableName
End if

// ------------------------------------------------------------------------
// Speichern von Textinformationen
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der Textinformationen")
If dw_text_info.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der Textinformationen.")
	end if
	bInAction = false
	return False
End if
If dw_text_infos_areas.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der Textinformationen f$$HEX1$$fc00$$ENDHEX$$r Bereiche.")
	end if
	bInAction = false
	return False
End if
// ------------------------------------------------------------------------
// Speichern von Textinformationen History
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der History Textinformationen")
dw_text_info.ResetUpdate()
sTableName	= dw_text_info.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_text_info.Rowcount()
	dw_text_info.Setitemstatus(i,0,Primary!,NewModified!)
Next
dw_text_info.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
If dw_text_info.update() = -1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der History Textinformationen.")
	end if
	dw_text_info.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dw_text_info.Object.DataWindow.Table.UpdateTable = sTableName
End if

dw_text_infos_areas.ResetUpdate()
sTableName	= dw_text_infos_areas.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_text_infos_areas.Rowcount()
	dw_text_infos_areas.Setitemstatus(i,0,Primary!,NewModified!)
Next
dw_text_infos_areas.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
If dw_text_infos_areas.update() = -1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der History Textinformationen f$$HEX1$$fc00$$ENDHEX$$r Bereiche.")
	end if
	dw_text_infos_areas.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dw_text_infos_areas.Object.DataWindow.Table.UpdateTable = sTableName
End if

// ------------------------------------------------------------------------
// Speichern von dw_extra
// ------------------------------------------------------------------------

wf_chc_trace(10,"[wf_chc_save_final_pax] Speichern der Extrabeladung Start")
//wf_setmessage("Speichern der Extrabeladung")
If dw_extra.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der Extrabeladung.")
	end if
	bInAction = false
	return False
End if
wf_chc_trace(10,"[wf_chc_save_final_pax] Speichern der Extrabeladung Ende")
// ------------------------------------------------------------------------
// Speichern von dw_extra History
// ------------------------------------------------------------------------
wf_chc_trace(10,"[wf_chc_save_final_pax] Speichern der History Extrabeladung Start")
//wf_setmessage("Speichern der History Extrabeladung.")
dw_extra.ResetUpdate()
sTableName	= dw_extra.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_extra.Rowcount()
	dw_extra.Setitemstatus(i,0,Primary!,NewModified!)
Next
dw_extra.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
If dw_extra.update() = -1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der History Extrabeladung.")
	end if
	dw_extra.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dw_extra.Object.DataWindow.Table.UpdateTable = sTableName
End if

wf_chc_trace(10,"[wf_chc_save_final_pax] Speichern der History Extrabeladung Ende")

// ------------------------------------------------------------------------
// Speichern von dw_meal
// ------------------------------------------------------------------------

wf_chc_trace(10,"[wf_chc_save_final_pax] Speichern der Mahlzeitenbeladung Start")
//wf_setmessage("Speichern der Mahlzeitenbeladung")
If dw_meal.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der Mahlzeitenbeladung.")
	end if
	bInAction = false
	return False
End if
wf_chc_trace(10,"[wf_chc_save_final_pax] Speichern der Mahlzeitenbeladung Ende")
// ------------------------------------------------------------------------
// Speichern von dw_meal History
// ------------------------------------------------------------------------
wf_chc_trace(10,"[wf_chc_save_final_pax] Speichern der History Mahlzeitenbeladung Start")
//wf_setmessage("Speichern der History Mahlzeitenbeladung.")
dw_meal.ResetUpdate()
sTableName	= dw_meal.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_meal.Rowcount()
	dw_meal.Setitemstatus(i,0,Primary!,NewModified!)
Next
dw_meal.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
If dw_meal.update() = -1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der History Mahlzeitenbeladung.")
	end if
	dw_meal.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dw_meal.Object.DataWindow.Table.UpdateTable = sTableName
End if

wf_chc_trace(10,"[wf_chc_save_final_pax] Speichern der History Mahlzeitenbeladung Ende")
// ------------------------------------------------------------------------
// Speichern von dw_spml
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der Special Meal")
If dw_spml.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der Special Meal.")
	end if
	bInAction = false
	return False
End if
// ------------------------------------------------------------------------
// Speichern von dw_spml History
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der History Special Meal.")
dw_spml.ResetUpdate()
sTableName	= dw_spml.Object.DataWindow.Table.UpdateTable
For i = 1 to dw_spml.Rowcount()
	dw_spml.Setitemstatus(i,0,Primary!,NewModified!)
Next
dw_spml.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
If dw_spml.update() = -1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der History Special Meal.")
	end if
	dw_spml.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dw_spml.Object.DataWindow.Table.UpdateTable = sTableName
End if
// ------------------------------------------------------------------------
// Speichern SPML-Details
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der Special Meal Details")
If dsSPMLDetail.update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der Special Meal Details.")
	end if
	//f_print_datastore(dsSPMLDetail)
	bInAction = false
	return False
End if
// ------------------------------------------------------------------------
// Speichern SPML-Details-History
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der History der Special Meal Details")
dsSPMLDetail.ResetUpdate()
sTableName	= dsSPMLDetail.Object.DataWindow.Table.UpdateTable
For i = 1 to dsSPMLDetail.Rowcount()
	dsSPMLDetail.Setitemstatus(i,0,Primary!,NewModified!)
Next
dsSPMLDetail.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
//f_print_datastore(dsSPMLDetail)
If dsSPMLDetail.update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der Special Meal Details History.")
	end if
	//f_print_datastore(dsSPMLDetail)
	dsSPMLDetail.Object.DataWindow.Table.UpdateTable = sTableName
	bInAction = false
	return False
Else
	dsSPMLDetail.Object.DataWindow.Table.UpdateTable = sTableName
End if
// ------------------------------------------------------------------------
// Zeitungsbeladung
// ------------------------------------------------------------------------
If	bNewspaperChange = True Then
	// ------------------------------------------------------------------------
	// L$$HEX1$$f600$$ENDHEX$$schen der kompletten Zeitungsbeladung f$$HEX1$$fc00$$ENDHEX$$r diesen Flug
	// aber nur nach einem AC-Change, da dann das Lesematerial neu
	// ermittelt wurde
	// ------------------------------------------------------------------------
	delete from cen_out_news where nresult_key = :lResultKey_Trace;
	If SQLCA.SQLCODE <> 0 Then
		rollback ;
		if not bImportMode then
			f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim L$$HEX1$$f600$$ENDHEX$$schen der Lesematerial-Beladung.")
		end if
		bInAction = false
		return False
	End if

	delete from cen_out_news_extra where nresult_key = :lResultKey_Trace;
	If SQLCA.SQLCODE <> 0 Then
		rollback ;
		if not bImportMode then
			f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim L$$HEX1$$f600$$ENDHEX$$schen der Lesematerial-Extrabeladung.")
		end if
		bInAction = false
		return False
	End if
End if
// ------------------------------------------------------------------------
// Speichern von dsCenOutHandlingNews
// ------------------------------------------------------------------------
If dsCenOutHandlingNews.rowcount()  > 0 Then
//	wf_setmessage("Speichern der Lesematerial-Beladung")
	If dsCenOutHandlingNews.Update() <> 1 Then
		rollback ;
		if not bImportMode then
			f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der Lesematerial-Beladung.")
		end if
		bInAction = false
		return False
	End if
	// ------------------------------------------------------------------------
	// Speichern von dsCenOutHandlingNews History
	// ------------------------------------------------------------------------
//	wf_setmessage("Speichern der History Lesematerial-Beladung.")
	dsCenOutHandlingNews.ResetUpdate()
	sTableName	= dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutHandlingNews.Rowcount()
		dsCenOutHandlingNews.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
			
	If dsCenOutHandlingNews.update() = -1 Then
		rollback ;
		if not bImportMode then
			f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der History Lesematerial-Beladung.")
		end if
		dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable = sTableName
		bInAction = false
		return False
	Else
		dsCenOutHandlingNews.Object.DataWindow.Table.UpdateTable = sTableName
	End if
End if
// ------------------------------------------------------------------------
// Speichern von dsCenOutNewsExtra
// ------------------------------------------------------------------------
If dsCenOutNewsExtra.rowcount()  > 0 Then
//	wf_setmessage("Speichern der Lesematerial-Extrabeladung")
	If dsCenOutNewsExtra.Update() <> 1 Then
		rollback ;
		if not bImportMode then
			f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der Lesematerial-Extrabeladung.")
		end if
		bInAction = false
		return False
	End if
	// ------------------------------------------------------------------------
	// Speichern von dsCenOutNewsExtra History
	// ------------------------------------------------------------------------
//	wf_setmessage("Speichern der History Lesematerial-Extrabeladung.")
	dsCenOutNewsExtra.ResetUpdate()
	sTableName	= dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable
	For i = 1 to dsCenOutNewsExtra.Rowcount()
		dsCenOutNewsExtra.Setitemstatus(i,0,Primary!,NewModified!)
	Next
	dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable = sTableName + "_history"
	
	If dsCenOutNewsExtra.update() = -1 Then
		rollback ;
		if not bImportMode then
			f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der History Lesematerial-Extrabeladung.")
		end if
		dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable = sTableName
		bInAction = false
		return False
	Else
		dsCenOutNewsExtra.Object.DataWindow.Table.UpdateTable = sTableName
	End if
End if
// ------------------------------------------------------------------------
// Speichern von dsChangeInformation
// ------------------------------------------------------------------------
//wf_setmessage("Speichern der $$HEX1$$c400$$ENDHEX$$nderungsinformationen")
If dsChangeInformation.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[wf_chc_save_final_pax] Fehler beim Speichern der $$HEX1$$c400$$ENDHEX$$nderungsinformationen.")
	end if
	bInAction = false
	return False
End if
// ------------------------------------------------------------------------
// Und nun der Commit, und Save Button aus
// ------------------------------------------------------------------------
if bEnableCommit then
	commit ;
end if
//pb_save.Enabled 	= False

// ------------------------------------------------------------------------
// Speicher Status und Annullierung Status Reset
// ------------------------------------------------------------------------
bNoSaving 			= False
bCancelAction		= False
bNewspaperChange	= False
bMealChange			= False
bManualChanges 	= false
// -------------------------------------------------------------------------
// Ist ein Flug im Modus 5 oder > 6 dann ist der Flug im Read only Modus
// -------------------------------------------------------------------------
//wf_chc_set_datawindow_modus()
bInAction = false

// -------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungen zur$$HEX1$$fc00$$ENDHEX$$cksetzen
// -------------------------------------------------------------------------
strUserChanges	= strUserChangesEmpty

// -------------------------------------------------------------------------
// Speicher aufr$$HEX1$$e400$$ENDHEX$$umen
// -------------------------------------------------------------------------
//wf_setmessage("GarbageCollect")
wf_chc_trace(10,"[wf_chc_save_final_pax] GarbageCollect")
GarbageCollect()

//wf_chc_setmessage("Ready")
lStop = CPU()

if ((lStop - lStart) / 1000) > 7 then
	lStop -= 2000
end if

//Nochmal die Daten aus der Datenbank holen, damit PB 10 zufrieden ist.
//Ansonsten kommt ein SQL Fehler, wenn man 2mal den Textinhalt $$HEX1$$e400$$ENDHEX$$ndert
// wf_chc_retrieve_detail(lmasterrow)

//wf_setmessage("Ready in " + string((lStop - lStart) / 1000, "00.000") + " seconds.")

wf_chc_trace(10,"[wf_chc_save_final_pax] Rest")

bAnychange = false

return true

end function

public function boolean wf_chc_set_changed_status ();// ------------------------------------------------------------------
//
// 
//
// ------------------------------------------------------------------
	long 				i
	Datetime			dtChanged
	integer			iModified
// ------------------------------------------------------------------
// Ist der Status eines Fluges 1 oder 2 wird dieser beim ersten $$HEX1$$c400$$ENDHEX$$ndern 
// des Fluges auf 3 gesetzt. 
// 1.	Generierung
// 2.	Generierung Update
// 3.	Erste $$HEX1$$c400$$ENDHEX$$nderung im Change Browser
// 4.	Produktionsstatus 1, kann mit Funktion f$$HEX1$$fc00$$ENDHEX$$r ausgew$$HEX1$$e400$$ENDHEX$$hlte Fl$$HEX1$$fc00$$ENDHEX$$ge gesetzt werden.
// 5.	Produktionsstatus 2, kann mit Funktion f$$HEX1$$fc00$$ENDHEX$$r ausgew$$HEX1$$e400$$ENDHEX$$hlte Fl$$HEX1$$fc00$$ENDHEX$$ge gesetzt werden.
// 6.	Flight Closed
// 7.	Flug ist abgerechnet
//
// Zu dem Status, der den Workflow steuert, gibt es einen weiteren allgemeinen Flugstatus
// cen_out.nflight_status:
//
//	0	Scheduled
//	1	Cancelled
//	2	OnRequest
//
// ------------------------------------------------------------------
	If iChangeStatus <= 2 and ii_action <> 7 Then    // nicht bei AMOS-SPML-Update
		// 17.12.2009 HR: Auf Anforderung von IFMS soll der Status hier nicht auf 3 gesetzt werden, sondern so belieben
		//iChangeStatus = 3
		iChangeStatus = iChangeStatus

		dw_single.SetItem(dw_single.Getrow(),"status_nstatus",1)
	Else
		iChangeStatus = iChangeStatus
	End if
	
// ------------------------------------------------------------------
// Es werden immer alle Datawindos gespeichert !
// In dieser Funktion bekommen alle Datawindows ihren Status.
// ------------------------------------------------------------------
	dtChanged = Datetime(today(),now())
	lTransActionKey = wf_chc_get_history_key()
	If lTransActionKey = -1 Then
		if bImportMode then
			wf_chc_add_to_protocol(uf.translate("History fehler"))
		else
			f_Log2Csv(0,2,"[wf_chc_set_changed_status] Schl$$HEX1$$fc00$$ENDHEX$$ssel f$$HEX1$$fc00$$ENDHEX$$r History kann nicht ermittelt werden.")
		end if
		return False
	End if
	
// ------------------------------------------------------------------------
// Es werden immer alle Datawindos gespeichert !
// ------------------------------------------------------------------------
	dw_single.SetItem(dw_single.Getrow(),"NTRANSACTION",lTransActionKey)
	dw_single.SetItem(dw_single.Getrow(),"DTIMESTAMP",dtChanged)
	dw_single.SetItem(dw_single.Getrow(),"NSTATUS",iChangeStatus)
	//dw_1.SetItem(dw_1.Getrow(),"NSTATUS",iChangeStatus)
	// Sichern des Freigabestatus
	dw_single.SetItem(dw_single.Getrow(),"NSTATUS_RELEASE",iReleaseStatus)
	//dw_1.SetItem(dw_1.Getrow(),"NSTATUS_RELEASE",iReleaseStatus)
	//dw_1.SetItemStatus(dw_1.Getrow(),0,Primary!,NotModified!)
	
	iModified	= dw_single.GetItemNumber(dw_single.Getrow(),"nuser_modified")
	iModified ++
	// -------------------------------------------------------
	// 09.08.2006
	// Feld ist nur 2 stellig, bei Speicherung 100 gibts 
	// sonst ne Datenbankfehlermeldung
	// -------------------------------------------------------
	if iModified > 99 then iModified = 99
	
	dw_single.SetItem(dw_single.Getrow(),"nuser_modified",iModified)
	
	If dw_single.modifiedcount() + dw_single.DeletedCount( )  > 0 then
		dw_single.SetItem(1,"CDESCRIPTION","changed")
	Else
		dw_single.SetItem(1,"CDESCRIPTION","unchanged")
	End if
	dw_single.accepttext()
// -----------------------------------------
//	Passagierzahlen
// -----------------------------------------		
	For i = 1 to dw_pax.rowcount()
		if dw_pax.GetItemNumber(i,"status_npax") = 0 then
			dw_pax.SetItem(i,"CDESCRIPTION","unchanged")
		Else
			dw_pax.SetItem(i,"CDESCRIPTION","changed")
		End if
		dw_pax.SetItem(i,"NTRANSACTION",lTransActionKey)
		dw_pax.SetItem(i,"DTIMESTAMP",dtChanged)
		dw_pax.SetItem(i,"NSTATUS",iChangeStatus)
	Next	
	dw_pax.accepttext()
// -----------------------------------------
// Handlingbeladung
// -----------------------------------------	
	For i = 1 to dw_handling.rowcount()
		If dw_handling.GetItemStatus(i,0,Primary!) = NotModified!	Then
			dw_handling.SetItem(i,"CDESCRIPTION","unchanged")
		Else
			dw_handling.SetItem(i,"CDESCRIPTION","changed")
		End if
		dw_handling.SetItem(i,"NTRANSACTION",lTransActionKey)
		dw_handling.SetItem(i,"DTIMESTAMP",dtChanged)
		dw_handling.SetItem(i,"NSTATUS",iChangeStatus)
	Next	
	dw_handling.accepttext()
// -----------------------------------------
// Extrabeladung
// -----------------------------------------		
	For i = 1 to dw_extra.rowcount()
		If dw_extra.GetItemStatus(i,0,Primary!) = NotModified!	Then
			dw_extra.SetItem(i,"CDESCRIPTION","unchanged")
		Else
			dw_extra.SetItem(i,"CDESCRIPTION","changed")
		End if
		dw_extra.SetItem(i,"NTRANSACTION",lTransActionKey)
		dw_extra.SetItem(i,"DTIMESTAMP",dtChanged)
		dw_extra.SetItem(i,"NSTATUS",iChangeStatus)
	Next	
	dw_extra.accepttext()
// -----------------------------------------
// Mahlzeitenbeladung
// -----------------------------------------	
	For i = 1 to dw_meal.rowcount()
		If dw_meal.GetItemStatus(i,0,Primary!) = NotModified!	Then
			dw_meal.SetItem(i,"CDESCRIPTION","unchanged")
		Else
			dw_meal.SetItem(i,"CDESCRIPTION","changed")
		End if
		dw_meal.SetItem(i,"NTRANSACTION",lTransActionKey)
		dw_meal.SetItem(i,"DTIMESTAMP",dtChanged)
		dw_meal.SetItem(i,"NSTATUS",iChangeStatus)
	Next	
	dw_meal.accepttext()
// -----------------------------------------
// SPML
// -----------------------------------------	
	For i = 1 to dw_spml.rowcount()
		If dw_spml.GetItemStatus(i,0,Primary!) = NotModified!	Then
			dw_spml.SetItem(i,"CDESCRIPTION","unchanged")
		Else
			dw_spml.SetItem(i,"CDESCRIPTION","changed")
		End if
		dw_spml.SetItem(i,"NTRANSACTION",lTransActionKey)
		dw_spml.SetItem(i,"DTIMESTAMP",dtChanged)
		dw_spml.SetItem(i,"NSTATUS",iChangeStatus)
	Next	
	dw_spml.accepttext()
// -----------------------------------------
// SPML-Details
// -----------------------------------------	
	For i = 1 to dsSPMLDetail.rowcount()
		If dsSPMLDetail.GetItemStatus(i,0,Primary!) = NotModified!	Then
			dsSPMLDetail.SetItem(i,"CDESCRIPTION","unchanged")
		Else
			dsSPMLDetail.SetItem(i,"CDESCRIPTION","changed")
		End if
		dsSPMLDetail.SetItem(i,"NTRANSACTION",lTransActionKey)
		dsSPMLDetail.SetItem(i,"DTIMESTAMP",dtChanged)
		dsSPMLDetail.SetItem(i,"NSTATUS",iChangeStatus)
	Next	
	dsSPMLDetail.accepttext()
// -----------------------------------------
// Textinfo
// -----------------------------------------	
/*	For i = 1 to dw_text_info.rowcount()
		If dw_text_info.GetItemStatus(i,0,Primary!) = NotModified!	Then
			dw_text_info.SetItem(i,"CDESCRIPTION","unchanged")
		Else
			dw_text_info.SetItem(i,"CDESCRIPTION","changed")
		End if
		dw_text_info.SetItem(i,"NTRANSACTION",lTransActionKey)
		dw_text_info.SetItem(i,"DTIMESTAMP",dtChanged)
		dw_text_info.SetItem(i,"NSTATUS",iChangeStatus)
	Next	
	dw_text_info.accepttext()	
	For i = 1 to dw_text_infos_areas.rowcount()
		dw_text_infos_areas.SetItem(i,"NTRANSACTION",lTransActionKey)
	Next	
	dw_text_infos_areas.accepttext()
*/	
// -----------------------------------------
// Zeitungsbeladung
// -----------------------------------------
	For i = 1 to dsCenOutHandlingNews.rowcount()
		dsCenOutHandlingNews.SetItem(i,"CDESCRIPTION","changed")
		dsCenOutHandlingNews.SetItem(i,"NTRANSACTION",lTransActionKey)
		dsCenOutHandlingNews.SetItem(i,"DTIMESTAMP",dtChanged)
		dsCenOutHandlingNews.SetItem(i,"NSTATUS",iChangeStatus)
	Next	
	For i = 1 to dsCenOutNewsExtra.rowcount()
		dsCenOutNewsExtra.SetItem(i,"CDESCRIPTION","changed")
		dsCenOutNewsExtra.SetItem(i,"NTRANSACTION",lTransActionKey)
		dsCenOutNewsExtra.SetItem(i,"DTIMESTAMP",dtChanged)
		dsCenOutNewsExtra.SetItem(i,"NSTATUS",iChangeStatus)
	Next	
	

	Return True
end function

public function long wf_chc_get_history_key ();// ----------------------------------
// Key f$$HEX1$$fc00$$ENDHEX$$r History ermitteln
// ----------------------------------
	long lSequence
	lSequence = f_Sequence ("seq_cen_out_history",sqlca)
	If  lSequence = -1 Then
		 return -1
	End if	
	
	return lSequence
end function

public function boolean wf_chc_changed_information ();// --------------------------------------------------------------------------
//
// wf_chc_changed_information
//
// --------------------------------------------------------------------------
//
// F$$HEX1$$fc00$$ENDHEX$$llt Tabelle cen_out_changes
// 
// 15.07.2004
// Kombination aus Statusfelder und ModifiedCount als Ausl$$HEX1$$f600$$ENDHEX$$ser einer 
// $$HEX1$$c400$$ENDHEX$$nderung.
// Achtung: wf_chc_set_changed_status modifiziert bereits vorher die Bemerkungs-
//				felder.
//
// Zus$$HEX1$$e400$$ENDHEX$$tzlich wird strUserChanges-Struktur herangezogen (dort wo es n$$HEX1$$f600$$ENDHEX$$tig ist)!
//
// --------------------------------------------------------------------------
long 				i, j
long				lNewRow
integer 			iStatus

Datetime			dtChanged
integer			iModified
Decimal			dcQuantity

wf_chc_trace(10,"[wf_chc_changed_information] Begin")

// --------------------------------------------------------------------------------------------------------------------
// 02.04.2015 HR: Wenn Daten aus der History gelesen wurde, dann m$$HEX1$$fc00$$ENDHEX$$ssen wir diese auch mit der 
//                         History abgleichen
// --------------------------------------------------------------------------------------------------------------------
if this.breadfromhistory then
	wf_chc_check_against_old()
end if

// --------------------------------------------------------------------------
// Detaillierte Informationen zu den $$HEX1$$c400$$ENDHEX$$nderungen f$$HEX1$$fc00$$ENDHEX$$r Tabelle cen_out_changes
// --------------------------------------------------------------------------
dsChangeInformation.reset()
lNewRow = dsChangeInformation.insertrow(0)
dsChangeInformation.SetItem(lNewRow,"ntransaction",lTransActionKey)
dsChangeInformation.SetItem(lNewRow,"nresult_key",dw_single.Getitemnumber(dw_single.Getrow(),"nresult_key"))
dsChangeInformation.SetItem(lNewRow,"cusername",s_app.suser)
dsChangeInformation.SetItem(lNewRow,"cipaddress",s_app.shost)
dsChangeInformation.SetItem(lNewRow,"dtimestamp",Datetime(today(),now()))
dsChangeInformation.SetItem(lNewRow,"nstatus",iChangestatus)
dsChangeInformation.SetItem(lNewRow,"nflight_status",iFlightstatus)

// --------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderung wurde durch Anwender durchgef$$HEX1$$fc00$$ENDHEX$$hrt
// --------------------------------------------------------------------------
If sChangeType = "Anwender" Then
	dw_single.Setitem(dw_single.Getrow(),"nquery",0)
Else
	// wurde in wf_chc_read_flightdata gesetzt
End if

// --------------------------------------------------------------------------
// Dirty Master Change
// --------------------------------------------------------------------------
If bChangeNoMeals	= True Then
	dsChangeInformation.SetItem(lNewRow,"nchange_no_meals",1)
Else
	dsChangeInformation.SetItem(lNewRow,"nchange_no_meals",0)
End if

//	If bChangeNoNews	Then
//		dsChangeInformation.SetItem(lNewRow,"nchange_no_news",1)
//	Else
	dsChangeInformation.SetItem(lNewRow,"nchange_no_news",0)
//	End if

If bChangeNoExtra	Then
	dsChangeInformation.SetItem(lNewRow,"nchange_no_extra",1)
Else
	dsChangeInformation.SetItem(lNewRow,"nchange_no_extra",0)
End if
// --------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderung Stunden vor Abflug (nur innerhalb 24 Stunden)
// --------------------------------------------------------------------------	
//If Daysafter(date(dw_single.GetitemDateTime(dw_single.Getrow(),"ddeparture")),&
//	Date(Today())) <= 1 Then
If Daysafter(date(dw_single.GetitemDateTime(dw_single.Getrow(),"ddeparture")),&
	Date(Today())) = 0 Then
	dsChangeInformation.SetItem(lNewRow,"chours_before",&
	f_time_difference(string(now(),"hh:mm"),&
	dw_single.GetitemString(dw_single.Getrow(),"cdeparture_time")))
Else
	dsChangeInformation.SetItem(lNewRow,"chours_before","00:00")
End if
// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungsgruppe Flight
// ------------------------------------------------------------------------
iStatus = 0
If dw_single.GetItemStatus(dw_single.Getrow(),"cairline",Primary!) <> NotModified!	Then
	iStatus = 1
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"nflight_number",Primary!) <> NotModified!	Then
	iStatus = 1
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"csuffix",Primary!) <> NotModified!	Then
	iStatus = 1
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"nleg_number",Primary!) <> NotModified!	Then
	iStatus = 1
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"ctlc_from",Primary!) <> NotModified!	Then
	iStatus = 1
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"ctlc_to",Primary!) <> NotModified!	Then
	iStatus = 1
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"ccountry_from",Primary!) <> NotModified!	Then
	iStatus = 1
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"ccountry_to",Primary!) <> NotModified!	Then
	iStatus = 1
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"crouting",Primary!) <> NotModified!	Then
	iStatus = 1
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"ctraffic_area",Primary!) <> NotModified!	Then
	iStatus = 1
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"cheader1",Primary!) <> NotModified!	Then
	If s_app.sWerk = "0110" Then
		iStatus = 0
	Else	
		iStatus = 1
	End if	
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"cheader2",Primary!) <> NotModified!	Then
	If s_app.sWerk = "0110" Then
		iStatus = 0
	Else	
		iStatus = 1
	End if	
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"nstatus",Primary!) <> NotModified!	Then
	// -------------------------------------------------------------------------
	// Status f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$c400$$ENDHEX$$nderungsgruppe Flight wir nur gesetzt, wenn eine Annullierung
	// oder eine Annullierungsaufhebung vorlag.
	// -------------------------------------------------------------------------
	If bCancelAction = True Then
		iStatus = 1
	End if
End if
dsChangeInformation.Setitem(lNewRow,"nflight",iStatus)
// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungsgruppe Date-/Time
// ------------------------------------------------------------------------
iStatus = 0
If dw_single.GetItemStatus(dw_single.Getrow(),"ddeparture",Primary!) <> NotModified!	Then
	iStatus = 1
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"cdeparture_time",Primary!) <> NotModified!	Then
	iStatus = 1
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"cramp_time",Primary!) <> NotModified!	Then
	iStatus = 1
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"ckitchen_time",Primary!) <> NotModified!	Then
	iStatus = 1
End if
dsChangeInformation.Setitem(lNewRow,"ndate_time",iStatus)
// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungsgruppe Registration
// ------------------------------------------------------------------------
iStatus = 0
If dw_single.GetItemStatus(dw_single.Getrow(),"cregistration",Primary!) <> NotModified!	Then
	iStatus = 1
End if
dsChangeInformation.Setitem(lNewRow,"nregistration",iStatus)
// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungsgruppe Rampenbox
// ------------------------------------------------------------------------
iStatus = 0
If dw_single.GetItemStatus(dw_single.Getrow(),"cbox_from",Primary!) <> NotModified!	Then
	iStatus = 1
End if

If dw_single.GetItemStatus(dw_single.Getrow(),"cbox_to",Primary!) <> NotModified!	Then
	iStatus = 1
End if
dsChangeInformation.Setitem(lNewRow,"nrampbox",iStatus)	
// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungsgruppe Aircrafttype
// ------------------------------------------------------------------------
iStatus = 0
If dw_single.GetItemStatus(dw_single.Getrow(),"naircraft_key",Primary!) <> NotModified!	Then
	iStatus = 1
	ib_checkpoint_acchange = true// 14.04.2015 HR: 
	ib_wab_send = True		// TSC 15.08.2016: beim AC-Change Gewichte schicken
End if
dsChangeInformation.Setitem(lNewRow,"naircrafttype",iStatus)	
// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungsgruppe Version
// ------------------------------------------------------------------------
iStatus = 0
If dw_single.GetItemStatus(dw_single.Getrow(),"cconfiguration",Primary!) <> NotModified!	Then
	iStatus = 1
	ib_checkpoint_acchange = true// 14.04.2015 HR: 
	ib_wab_send = True		// TSC 15.08.2016: beim AC-Change Gewichte schicken
End if
dsChangeInformation.Setitem(lNewRow,"nversion",iStatus)		
// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungsgruppe Passagier
// ------------------------------------------------------------------------
iStatus = 0
For i = 1 to dw_pax.rowcount()
	if dw_pax.GetItemStatus(i,"npax",Primary!) <> NotModified! and &
		dw_pax.GetItemNumber(i,"status_npax") = 1 then
		iStatus = 1
		exit
	end if
Next	
dsChangeInformation.Setitem(lNewRow,"npassenger",iStatus)	
// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungsgruppe Handling
// ------------------------------------------------------------------------
iStatus = 0
If dw_single.GetItemStatus(dw_single.Getrow(),"nhandling_type_key",Primary!) <> NotModified!	Then
	iStatus = 1
End if
If dw_single.GetItemStatus(dw_single.Getrow(),"chandling_type_text",Primary!) <> NotModified!	Then
	iStatus = 1
End if
// 
// 11.05.: L$$HEX1$$f600$$ENDHEX$$schen erm$$HEX1$$f600$$ENDHEX$$glichen
//
If dw_handling.deletedcount() > 0 then
	iStatus = 1
End if
	
For i = 1 to dw_handling.rowcount()
	if dw_handling.GetItemNumber(i,"new_row") = 1 then
		iStatus = 1
		exit
	end if
Next	

dsChangeInformation.Setitem(lNewRow,"nhandling",iStatus)	
// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungsgruppe Handling Detail
// ------------------------------------------------------------------------	
If iStatus = 0 Then
	For i = 1 to dw_handling.rowcount()
		If dw_handling.GetItemStatus(i,"cloadinglist",Primary!) <> NotModified!	Then
			iStatus = 1
			exit
		End if
	Next
End if	
// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungsgruppe Extrabeladung
// ------------------------------------------------------------------------	
iStatus = 0
bExtraBillingOnly = true
For i = 1 to dw_extra.rowcount()
	//
	// Not-Modified ist nicht ausreichend, da Neuberechnung mit anschl. RowsCopy()
	//
	//		If dw_extra.GetItemStatus(i,"cpackinglist",Primary!) <> NotModified!	or &
	//			dw_extra.GetItemStatus(i,"nquantity",Primary!) <> NotModified! Then
	//			iStatus = 1
	//			if dw_extra.GetItemNumber(i,"nbilling_status") < 2 then
	//				bExtraBillingOnly = false
	//			end if
	//		End if
	If dw_extra.GetItemStatus(i,"cpackinglist",Primary!) 		<> NotModified!	or &
		dw_extra.GetItemStatus(i,"cremark",Primary!) 			<> NotModified!	or &
		dw_extra.GetItemStatus(i,"npax_manual",Primary!) 		<> NotModified!	or &
		dw_extra.GetItemStatus(i,"nreserve_quantity",Primary!)<> NotModified!	or &
		dw_extra.GetItemStatus(i,"ntopoff_quantity",Primary!) <> NotModified!	or &			
		dw_extra.GetItemStatus(i,"nquantity",Primary!) 			<> NotModified! Then
		
		if dw_extra.GetItemNumber(i,"status_nquantity") 		= 1 then
			if strUserChanges.bExtraChanged or strUserChanges.bPaxChanged then
				iStatus = 1
			end if
			//
			// Falls auch nur ein Produktionssatz vorhanden ist, kann man nicht mehr von
			// "Billing Only" reden:
			//
			if dw_extra.GetItemNumber(i,"nbilling_status") < 2 then
				bExtraBillingOnly = false
			end if
			//
			// Mengenabgleich, da bei manueller Eingabe die Mengen nicht angepasst wurden
			//
			if dw_extra.GetItemNumber(i,"nmanual_input") = 1 then
				dcQuantity = dw_extra.GetItemDecimal(i,"nquantity")
				if iChangestatus > 0 and iChangestatus < 8 then
					for j = iChangestatus to 7 
						dw_extra.SetItem(i,"nquantity" + string(j),dcQuantity)
					next
				end if
			end if
		end if
				
		// --------------------------------------------------------------------------------------------------------------------
		// 29.01.2014 HR: CBASE-F4-EM-13001: Generelses Problem, dass bei SL$$HEX1$$c400$$ENDHEX$$nderung diese nicht als $$HEX1$$c400$$ENDHEX$$nderung markiert werden
		// --------------------------------------------------------------------------------------------------------------------
		if dw_extra.GetItemNumber(i,"status_cpackinglist") = 1  then
			iStatus = 1
			
			// Falls auch nur ein Produktionssatz vorhanden ist, kann man nicht mehr von
			// "Billing Only" reden:
			if dw_extra.GetItemNumber(i,"nbilling_status") < 2 then
				bExtraBillingOnly = false
			end if

			// Mengenabgleich, da bei manueller Eingabe die Mengen nicht angepasst wurden
			if dw_extra.GetItemNumber(i,"nmanual_input") = 1 then
				dcQuantity = dw_extra.GetItemDecimal(i,"nquantity")
				if iChangestatus > 0 and iChangestatus < 8 then
					for j = iChangestatus to 7 
						dw_extra.SetItem(i,"nquantity" + string(j),dcQuantity)
					next
				end if
			end if
		end if

	End if
Next
//
// 26.07.2005: Sonderfall: Anzahl MZ alt <> MZ neu 
//					Dies ist immer eine $$HEX1$$c400$$ENDHEX$$nderungsmitteilung wert
//
if dw_extra.rowcount() <> dsExtraOld.rowcount() then
	for i = 1 to dw_extra.rowcount()
		if dw_extra.GetItemNumber(i,"nbilling_status") < 2 then
			bExtraBillingOnly = false
		end if
	next
	//
	// Nach neuer Regel wurde nichts mehr beladen...
	//
	if dw_extra.rowcount() = 0 then
		for i = 1 to dsExtraOld.rowcount()
			if dsExtraOld.GetItemNumber(i,"nbilling_status") < 2 then
				bExtraBillingOnly = false
			end if
		next
	end if
	iStatus = 1
end if

if bExtraBillingOnly and iStatus = 1 then 
	dsChangeInformation.Setitem(lNewRow,"nextra_billing",1)
else
	dsChangeInformation.Setitem(lNewRow,"nextra_billing",0)
end if
dsChangeInformation.Setitem(lNewRow,"nextra",iStatus)
// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungsgruppe Mahlzeiten
// ------------------------------------------------------------------------	
iStatus = 0
bMealBillingOnly = true
//		if dw_meal.modifiedcount() > 0 then	// Reicht nicht aus, da das DW durch wf_chc_set_changed_status
														// modifiziert wurde!
//
// Not-Modified ist nicht ausreichend, da Neuberechnung mit anschl. RowsCopy()
//
//		If dw_meal.GetItemStatus(i,"cpackinglist",Primary!) <> NotModified!	or &
//			dw_meal.GetItemStatus(i,"cremark",Primary!) <> NotModified!	or &
//			dw_meal.GetItemStatus(i,"npax_manual",Primary!) <> NotModified!	or &
//			dw_meal.GetItemStatus(i,"nreserve_quantity",Primary!) <> NotModified!	or &
//			dw_meal.GetItemStatus(i,"ntopoff_quantity",Primary!) <> NotModified!	or &			
//			dw_meal.GetItemStatus(i,"nquantity",Primary!) <> NotModified! Then
//			iStatus = 1
//			if dw_meal.GetItemNumber(i,"nbilling_status") < 2 then
//				bMealBillingOnly = false
//			end if
//		End if
For i = 1 to dw_meal.rowcount()
	If dw_meal.GetItemStatus(i,"cpackinglist",Primary!) 		<> NotModified!	or &
		dw_meal.GetItemStatus(i,"cremark",Primary!) 				<> NotModified!	or &
		dw_meal.GetItemStatus(i,"npax_manual",Primary!) 		<> NotModified!	or &
		dw_meal.GetItemStatus(i,"nreserve_quantity",Primary!) <> NotModified!	or &
		dw_meal.GetItemStatus(i,"ntopoff_quantity",Primary!) 	<> NotModified!	or &			
		dw_meal.GetItemStatus(i,"nquantity",Primary!) 			<> NotModified! Then
		
		if dw_meal.GetItemNumber(i,"status_nquantity") 			= 1 then
			iStatus = 1
			//
			// Falls auch nur ein Produktionssatz vorhanden ist, kann man nicht mehr von
			// "Billing Only" reden:
			//
			if dw_meal.GetItemNumber(i,"nbilling_status") < 2 then
				bMealBillingOnly = false
			end if
			//
			// Mengenabgleich, da bei manueller Eingabe die Mengen nicht angepasst wurden
			//
			if dw_meal.GetItemNumber(i,"nmanual_input") = 1 then
				dcQuantity = dw_meal.GetItemDecimal(i,"nquantity")
				if iChangestatus > 0 and iChangestatus < 8 then
					for j = iChangestatus to 7 
						dw_meal.SetItem(i,"nquantity" + string(j),dcQuantity)
					next
				end if
			end if
		end if
		
		// --------------------------------------------------------------------------------------------------------------------
		// 29.01.2014 HR: CBASE-F4-EM-13001: Generelses Problem, dass bei SL$$HEX1$$c400$$ENDHEX$$nderung diese nicht als $$HEX1$$c400$$ENDHEX$$nderung markiert werden
		// --------------------------------------------------------------------------------------------------------------------
		if dw_meal.GetItemNumber(i,"status_cpackinglist") = 1  then
			iStatus = 1
			
			// Falls auch nur ein Produktionssatz vorhanden ist, kann man nicht mehr von
			// "Billing Only" reden:
			if dw_meal.GetItemNumber(i,"nbilling_status") < 2 then
				bMealBillingOnly = false
			end if

			// Mengenabgleich, da bei manueller Eingabe die Mengen nicht angepasst wurden
			if dw_meal.GetItemNumber(i,"nmanual_input") = 1 then
				dcQuantity = dw_meal.GetItemDecimal(i,"nquantity")
				if iChangestatus > 0 and iChangestatus < 8 then
					for j = iChangestatus to 7 
						dw_meal.SetItem(i,"nquantity" + string(j),dcQuantity)
					next
				end if
			end if
			
		end if

	End if
Next
//
// 26.07.2005: Sonderfall: Anzahl MZ alt <> MZ neu 
//					Dies ist immer eine $$HEX1$$c400$$ENDHEX$$nderungsmitteilung wert
//					Darum genaue Suche nach produktionsrelevanten Infos
//
if dw_meal.rowcount() <> dsMealOld.rowcount() then
	for i = 1 to dw_meal.rowcount()
		if dw_meal.GetItemNumber(i,"nbilling_status") < 2 then
			bMealBillingOnly = false
		end if
	next
	//
	// Nach neuer Regel wurde nichts mehr beladen...
	//
	if dw_meal.rowcount() = 0 then
		for i = 1 to dsMealOld.rowcount()
			if dsMealOld.GetItemNumber(i,"nbilling_status") < 2 then
				bMealBillingOnly = false
			end if
		next
	end if
	iStatus = 1
end if

if bMealBillingOnly and iStatus = 1 then 
	dsChangeInformation.Setitem(lNewRow,"nmeal_billing",1)
else
	dsChangeInformation.Setitem(lNewRow,"nmeal_billing",0)
end if
dsChangeInformation.Setitem(lNewRow,"nmeal",iStatus)
// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungsgruppe SPML	
// ------------------------------------------------------------------------
iStatus = 0
if dw_spml.modifiedcount() > 0 then
	for i = 1 to dw_spml.rowcount()
		//
		// Not-Modified ist nicht ausreichend, da Neuberechnung mit anschl. RowsCopy()
		//
		//		if dw_spml.GetItemStatus(i,"cspml",Primary!) <> NotModified!	or &
		//			dw_spml.GetItemStatus(i,"cadd_text",Primary!) <> NotModified!	or &
		//			dw_spml.GetItemStatus(i,"cname",Primary!) <> NotModified!	or &
		//			dw_spml.GetItemStatus(i,"cremark",Primary!) <> NotModified!	or &
		//			dw_spml.GetItemStatus(i,"nquantity",Primary!) <> NotModified! Then
		//			iStatus = 1
		//		end if
		if dw_spml.GetItemStatus(i,"cspml",Primary!) 		<> NotModified!	or &
			dw_spml.GetItemStatus(i,"cadd_text",Primary!) 	<> NotModified!	or &
			dw_spml.GetItemStatus(i,"cname",Primary!) 		<> NotModified!	or &
			dw_spml.GetItemStatus(i,"cremark",Primary!) 		<> NotModified!	or &
			dw_spml.GetItemStatus(i,"nquantity",Primary!) 	<> NotModified! Then
			if dw_spml.GetItemNumber(i,"status_nquantity") 	= 1 or &
				dw_spml.GetItemNumber(i,"status_cadd_text") 	= 1 or & 
				dw_spml.GetItemNumber(i,"status_cname") 		= 1 or & 
				dw_spml.GetItemNumber(i,"status_cremark") 	= 1 then
				iStatus = 1
			end if
		end if
	next
end if
//
// 24.08.05	SPML k$$HEX1$$f600$$ENDHEX$$nnten gel$$HEX1$$f600$$ENDHEX$$scht worden sein
//
if dw_spml.rowcount() <> dsSPMLOld.rowcount() then
	iStatus = 1
end if

dsChangeInformation.Setitem(lNewRow,"nspml",iStatus)		
//
// Billing-Only ist zun$$HEX1$$e400$$ENDHEX$$chst kein Thema f$$HEX1$$fc00$$ENDHEX$$r SPML 
//	(geht nur in Kombination cen_out_spml + cen_out_spml_detail)
//
dsChangeInformation.Setitem(lNewRow,"nspml_billing",0)
// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungsgruppe Textinfo und Textinfo Area
// ------------------------------------------------------------------------	
iStatus = 0
/*If dw_text_info.GetItemStatus(dw_text_info.Getrow(),"ctextinfo",Primary!) <> NotModified!	Then
	iStatus = 1
End if
dsChangeInformation.Setitem(lNewRow,"ntextinfo",iStatus)	
If iStatus = 0 Then
	If dw_text_infos_areas.GetItemStatus(dw_text_infos_areas.Getrow(),"nsend",Primary!) <> NotModified!	Then
		iStatus = 1
	End if
	dsChangeInformation.Setitem(lNewRow,"ntextinfo",iStatus)	
End if
*/
// ------------------------------------------------------------------------
// 22.04.05	Bei Neuaufnahme werden $$HEX1$$c400$$ENDHEX$$nderungen erst hier erzeugt
// ------------------------------------------------------------------------	
if dw_single.GetItemNumber(dw_single.GetRow(),"nnew_flight") = 1 then
	dsChangeInformation.Setitem(lNewRow,"nflight",1)		
	dsChangeInformation.Setitem(lNewRow,"nnew_flight",1)
	// nflight_status = 2 ???
end if

// ------------------------------------------------------------------------
// 28.11.05 Auf keinen Fall ist dies eine $$HEX1$$c400$$ENDHEX$$nderung aus dem 
//				Nachfahrten-Browser
// ------------------------------------------------------------------------	
dsChangeInformation.Setitem(lNewRow,"nadd_delivery",0)		

wf_chc_trace(10,"[wf_chc_changed_information] Ende")

Return True	

end function

public function integer wf_chc_request_explosion ();//========================================================================================
//
// wf_chc_request_explosion
//
// Es wird eine aktuelle Mat-Dispo f$$HEX1$$fc00$$ENDHEX$$r den ver$$HEX1$$e400$$ENDHEX$$nderten Flug angefordert
// (nur bei Masterchange)
//
//========================================================================================
long		lSequence
datetime	dtCreated
time		tDepartureTime
datetime	dtDeparture
integer	icnx

// 04.03.2011 HR: Wenn schon eine Explosion, dann nicht nochmal
if ii_request_explosion=1 then return 0
wf_chc_trace(1,"[wf_chc_request_explosion] Create Job for FlightExplosion" )

//
// Cancel-Flag icnx f$$HEX1$$fc00$$ENDHEX$$r Matdispo: Falls gesetzt, dann werden Mengen auf 0 gesetzt
//
if dw_single.GetItemNumber(dw_single.Getrow(),"nflight_status") = 1 then
	icnx = 1
else
	icnx = 0
end if

// --------------------------------------------------------------------------------------------------------------------
// 25.02.2010 HR: F$$HEX1$$fc00$$ENDHEX$$r LCL-Fl$$HEX1$$fc00$$ENDHEX$$ge braucht keine St$$HEX1$$fc00$$ENDHEX$$cklistenaufl$$HEX1$$f600$$ENDHEX$$sung angesto$$HEX1$$df00$$ENDHEX$$en werden 
// --------------------------------------------------------------------------------------------------------------------
if dw_single.GetItemNumber(dw_single.Getrow(),"nlcl_mirror_flag")=1 then
	return 0
end if

dtCreated 		= datetime(today(),now())
tDepartureTime = time(dw_single.GetItemString(dw_single.GetRow(),"cdeparture_time"))
dtDeparture		= datetime(ddeparture,tDepartureTime)

lSequence = f_Sequence("seq_sys_explosion", sqlca)
If lSequence = -1 Then
	uf.MBox ("Datenbankfehler", "Es konnte kein eindeutiger Schl$$HEX1$$fc00$$ENDHEX$$ssel (Sequence) ermittelt werden.~r~r" + &
										 "Keine Neuanlage m$$HEX1$$f600$$ENDHEX$$glich.", StopSign!)
end if

insert into sys_explosion (njob_nr, nresult_key, ddeparture, dcreated, ncnx)
		values (:lSequence, :lresultkey_Trace, :dtDeparture, :dtCreated, :icnx);

if sqlca.sqlcode <> 0 then
	uf.MBox ("Datenbankfehler", "Es konnte kein Auftrag f$$HEX1$$fc00$$ENDHEX$$r die Materialdisposition angelegt werden.", StopSign!)
	return -1
end if

// 04.03.2011 HR: Nur einmal pro Flugberechnung
ii_request_explosion = 1

return 0

end function

public function boolean wf_chc_check_loading_list ();//=========================================================================================
//
// wf_chc_check_loading_list
//
// Eine Sammelst$$HEX1$$fc00$$ENDHEX$$ckliste ist Pflicht, zumindest f$$HEX1$$fc00$$ENDHEX$$r das erste Leg.
// Es sei denn, wir haben einen REQ-Flug (On Request) oder DLV oder SPC.
//
//=========================================================================================
if dw_handling.RowCount() = 0 and dw_single.GetItemNumber(dw_single.GetRow(),"nleg_number") = 1 then
	if dw_single.GetItemNumber(dw_single.GetRow(),"nflight_status") = 2 then
		//
		// On Request-Fl$$HEX1$$fc00$$ENDHEX$$ge brauchen keine Sammelst$$HEX1$$fc00$$ENDHEX$$ckliste
		//
		return true
	elseif dw_single.GetItemString(dw_single.Getrow(),"chandling_type_text") = "DLV" or &
			 dw_single.GetItemString(dw_single.Getrow(),"chandling_type_text") = "SPC" or &
			 dw_single.GetItemString(dw_single.Getrow(),"chandling_type_text") = "INT" then	
			 
		// 27.01.2016 Abfertigung INT CBASE-BRU-CR-2015-014	 
		//
		// Anlieferungs-Fl$$HEX1$$fc00$$ENDHEX$$ge brauchen keine Sammelst$$HEX1$$fc00$$ENDHEX$$ckliste
		//		
		return true
	else
				// Ermittle Lieferanteneinstellungen
			uo_suppl_unit.itype = 1 			// Flugereignis
			uo_suppl_unit.dtdate =  dw_single.GetItemDatetime(dw_single.Getrow(),"ddeparture")
			uo_suppl_unit.lCustomer =  dw_single.GetItemNumber(dw_single.Getrow(),"ncustomer_key") 
			uo_suppl_unit.sUnit =  dw_single.GetItemString(dw_single.Getrow(),"cunit")	
			uo_suppl_unit.dtToday = datetime(date(today()),time(now()))
			uo_suppl_unit.of_retrieve_ds()
			if uo_suppl_unit.i_suppl_interface_check_type = uo_suppl_unit.i_suppl_interface_check_type_2 and &
			   s_app.iInvoicingType = 1 then	
				// keine Pr$$HEX1$$fc00$$ENDHEX$$fung auf loading list bei Monalisa-Auslandscaterer
				return true
			else

				return false
			end if
		
	end if
end if

return true


end function

public subroutine wf_chc_check_loadinglist ();Long		lLoadinglistIndexKey1,lLoadinglistIndexKey2
String	sLoadingList,sLoadingListText
integer	i,iCheck
// ----------------------------------------------------------------------
// Gibt es vieleicht eine neue G$$HEX1$$fc00$$ENDHEX$$ltigkeit, dann m$$HEX1$$fc00$$ENDHEX$$ssen wir einen anderen
// nloadinglist_index_key nehmen.
// ----------------------------------------------------------------------
For i = 1 to dw_handling.Rowcount()
	sLoadingList 				= dw_handling.GetItemString(i,"cloadinglist")	
	lLoadinglistIndexKey1	= dw_handling.GetItemNumber(i,"nloadinglist_index_key")
	lLoadinglistIndexKey2	= -1
	
	SELECT nloadinglist_index_key,ctext 
	  INTO :lLoadinglistIndexKey2,:sLoadingListText 
	  FROM cen_loadinglist_index  
	 WHERE cloadinglist = :sLoadingList  AND  
			 cclient 		= :s_app.smandant  AND  
			 dvalid_from <= :dDeparture  AND  
			 dvalid_to   >= :dDeparture ; 
	If lLoadinglistIndexKey1 <> lLoadinglistIndexKey2 then
		iCheck ++
		dw_handling.SetItem(i,"nloadinglist_index_key",lLoadinglistIndexKey2)
		dw_handling.SetItem(i,"ctext",sLoadingListText)
	End if
Next

Return

end subroutine

public subroutine wf_chc_show_changes (datastore dw_changed, string scolumn, long lrow);// ----------------------------------------------------------------------
// Column als ge$$HEX1$$e400$$ENDHEX$$ndert hervorheben
// Setzt eine Computed Column 'status_" + aktueller Columnname voraus !
// ----------------------------------------------------------------------
	sColumn = "status_" + sColumn
	if pos(sColumn,"status_ctlc_to") > 0 then
		dw_changed.setitem(lrow,"status_ctlc",1)
	end if
   dw_changed.setitem(lrow,sColumn,1)
end subroutine

public function integer wf_chc_get_differences (long lresult_key);// 
// Setze $$HEX1$$c400$$ENDHEX$$nderungs-Kennzeichen analog Online-Client-$$HEX1$$c400$$ENDHEX$$nderung in Istdatenbrowser
//--------------------------------------------------------------------------------------------------
	long lEditCounter, lrow, lFind, lpax, lFound, lVersCheck
	long lClass_number, lmaster_key
	String	sFind, sData
	long	lNull
	
	setNull(lNull)
	
	bforceMealcalculation=false

	//-------------------------------------------------------------------------
	//  Ermittle $$HEX1$$c400$$ENDHEX$$nderungen in Pax-tabelle, setze $$HEX1$$c400$$ENDHEX$$nderungsstatus
	//-------------------------------------------------------------------------
	For lrow = 1 to dw_pax.rowcount()
	
		sFind="nclass_number = " + String(dw_pax.getItemNumber(lrow,"nclass_number"))
		lfind=dsPaxOld.Find(sFind,1, dspaxold.rowcount())
		
		if lfind <= 0 then
			dw_pax.SetItemStatus(lrow, 0, Primary!, DataModified!)
			wf_chc_trace(50,"[wf_chc_get_differences] dw_pax   | New entry class " + String(dw_pax.getItemNumber(lrow,"nclass_number")) + " npax "+ String(dw_pax.GetItemNumber(lrow,"npax")) )
		else
			if dw_pax.GetItemNumber(lrow,"npax") <> &
				 dsPaxOld.GetItemNumber(lfind,"npax") then
				
				wf_chc_trace(50,"[wf_chc_get_differences] dw_pax   |Changed - class " + String(dw_pax.getItemNumber(lrow,"nclass_number")) + " npax new: "+ String(dw_pax.GetItemNumber(lrow,"npax")) + " old: "+String(dsPaxOld.GetItemNumber(lfind,"npax") ))

				dw_pax.SetItemStatus(lrow, "npax", Primary!, DataModified!)
				
				lEditCounter = dsPaxOld.GetItemNumber(lfind,"edit_counter")
				dw_pax.SetItem(lrow,"edit_counter",lEditCounter + 1)
			
				lPax = dw_pax.GetItemNumber(lrow,"npax")
				dw_pax.SetItem(lrow,"npax_old",dsPaxOld.GetItemNumber(lfind,"npax"))
				bForceMealCalculation = true
				this.bDoMealCalculation = true
				strUserChanges.bPaxChanged = true
				wf_chc_show_changes(dw_pax,"npax",lrow)
			else
				wf_chc_trace(160,"[wf_chc_get_differences] dw_pax   |Unchanged - class " + String(dw_pax.getItemNumber(lrow,"nclass_number")) + " npax "+ String(dw_pax.GetItemNumber(lrow,"npax")) )

			end if
			
			if dw_pax.GetItemNumber(lrow,"npax_airline") <> &
				 dsPaxOld.GetItemNumber(lfind,"npax_airline") then
				 
				wf_chc_trace(50,"[wf_chc_get_differences] dw_pax   |Changed - class " + String(dw_pax.getItemNumber(lrow,"nclass_number")) + " npax_airline new: "+ String(dw_pax.GetItemNumber(lrow,"npax_airline")) + " old: "+String(dsPaxOld.GetItemNumber(lfind,"npax_airline") ))
				dw_pax.SetItemStatus(lrow, "npax_airline", Primary!, DataModified!)
				strUserChanges.bPaxChanged = true
				wf_chc_show_changes(dw_pax,"npax",lrow)
			else
				wf_chc_trace(160,"[wf_chc_get_differences] dw_pax   |Unchanged - class " + String(dw_pax.getItemNumber(lrow,"nclass_number")) + " npax_airline "+ String(dw_pax.GetItemNumber(lrow,"npax_airline")) )

			end if
			
			if dw_pax.GetItemNumber(lrow,"nstationentry") <> &
				 dsPaxOld.GetItemNumber(lfind,"nstationentry") then
				 
				dw_pax.SetItemStatus(lrow, "nstationentry", Primary!, DataModified!)
				strUserChanges.bPaxChanged = true
			end if

		end if
		
	next
		
	//-------------------------------------------------------------------------
	//  Ermittle $$HEX1$$c400$$ENDHEX$$nderungen in Meal-Tabelle, setze $$HEX1$$c400$$ENDHEX$$nderungsstatus
	//-------------------------------------------------------------------------
	For lrow = 1 to dw_meal.rowcount()
		sFind="nprio = " + String(dw_meal.getItemNumber(lrow,"nprio")) + &
				" and ncover_prio = " + String(dw_meal.getItemNumber(lrow,"ncover_prio")) + &
		  		" and nmodule_type =  0 " + &
		  		" and ndetail_key = " +  String(dw_meal.getItemNumber(lrow,"ndetail_key")) + &
				" and nclass_number = " + String(dw_meal.getItemNumber(lrow,"nclass_number")) 
			
		lfind=dsMealOld.Find(sFind,1, dsMealold.rowcount())
		
		if lfind <= 0 then
			dw_meal.SetItemStatus(lrow, 0, Primary!, DataModified!)
			 bAnychange = true
			 bManualChanges = true
		//	 wf_chc_trace(50,"[wf_chc_get_differences] dw_meal | New entry class " + String(dw_pax.getItemNumber(lrow,"nclass_number")) + " npax "+ String(dw_pax.GetItemNumber(lrow,"npax")) )

		else
			if dw_meal.GetItemNumber(lrow,"nquantity") <> &
				 dsMealOld.GetItemNumber(lfind,"nquantity") then
				 bAnychange = true
				bManualChanges = true
				dw_meal.SetItemStatus(lrow, "nquantity", Primary!, DataModified!)
				
				lEditCounter = dsMealOld.GetItemNumber(lfind,"edit_counter")
				dw_Meal.SetItem(lrow,"edit_counter",lEditCounter + 1)
			
				dw_Meal.SetItem(lrow,"nquantity_old",dsMealOld.GetItemNumber(lfind,"nquantity"))
		
				dw_meal.SetItem(lRow,"nmanual_input",1)
				// ----------------------------------------------
				// 27.03.2007, KF
				// ----------------------------------------------
				// Bei manueller $$HEX1$$c400$$ENDHEX$$nderung der Mengen die 
				// Berechnungsart auf "Feste Menge" setzen
				// damit die $$HEX1$$c400$$ENDHEX$$nderung bei der n$$HEX1$$e400$$ENDHEX$$chsten
				// Passagierzahlen$$HEX1$$e400$$ENDHEX$$nderung nicht wieder
				// zur$$HEX1$$fc00$$ENDHEX$$ckgesetzt wird. Die $$HEX1$$dc00$$ENDHEX$$bernahme der 
				// manuell ge$$HEX1$$e400$$ENDHEX$$nderten Mengen erfolgt in
				// uo_meal_calculation.uf_compare_new_current()
				// ----------------------------------------------
				dw_meal.SetItem(lRow,"ncalc_id",1)
				
						
				strUserChanges.bMealChanged  = true
				wf_chc_show_changes(dw_meal,"nquantity",lrow)
			end if
		// ---------------------------------------
		// Passagiere
		// Masterchange!
		// ---------------------------------------
			if dw_Meal.GetItemNumber(lrow,"npax_manual") <> &
				 dsMealOld.GetItemNumber(lfind,"npax_manual") then
				dw_Meal.SetItemStatus(lrow, "npax_manual", Primary!, DataModified!)
	
				dw_Meal.SetItem(lRow,"nmanual_input",1)
				bForceMealCalculation = true
			end if	
		// ---------------------------------------
		// Reserve
		// Masterchange!
		// ---------------------------------------
			if dw_Meal.GetItemNumber(lrow,"nreserve_quantity") <> &
			  dsMealOld.GetItemNumber(lfind,"nreserve_quantity") then
					dw_Meal.SetItemStatus(lrow, "nreserve_quantity", Primary!, DataModified!)
	
					dw_Meal.SetItem(lRow,"nmanual_input",1)
					//post wf_master_change()
					bForceMealCalculation = true
			end if	
		// ---------------------------------------
		// Topoff
		// Masterchange!
		// ---------------------------------------
			if dw_Meal.GetItemNumber(lrow,"ntopoff_quantity") <> &
			  dsMealOld.GetItemNumber(lfind,"ntopoff_quantity") then
					dw_Meal.SetItemStatus(lrow, "ntopoff_quantity", Primary!, DataModified!)
					dw_Meal.SetItem(lRow,"nmanual_input",1)
					//post wf_master_change()
					bForceMealCalculation = true
			end if	
	
	
		End if
		
	next
	
	//-------------------------------------------------------------------------
	//  Ermittle $$HEX1$$c400$$ENDHEX$$nderungen in Extra-Tabelle, setze $$HEX1$$c400$$ENDHEX$$nderungsstatus
	//-------------------------------------------------------------------------
	For lrow = 1 to dw_extra.rowcount()
		sFind="nprio = " + String(dw_extra.getItemNumber(lrow,"nprio")) + &
				" and ncover_prio = " + String(dw_extra.getItemNumber(lrow,"ncover_prio")) + &
 		 		" and ndetail_key = " +  String(dw_extra.getItemNumber(lrow,"ndetail_key")) + &
					" and nmodule_type =  1 " + &
				" and nclass_number = " + String(dw_extra.getItemNumber(lrow,"nclass_number")) 
			
		lfind=dsextraOld.Find(sFind,1, dsextraold.rowcount())
		
		if lfind <= 0 then
			dw_extra.SetItemStatus(lrow, 0, Primary!, DataModified!)
			 bAnychange = true
			 bManualChanges = true
		else
			if dw_extra.GetItemNumber(lrow,"nquantity") <> &
				 dsextraOld.GetItemNumber(lfind,"nquantity") then
				 bAnychange = true
				bManualChanges = true

				dw_extra.SetItemStatus(lrow, "nquantity", Primary!, DataModified!)
				
				lEditCounter = dsextraOld.GetItemNumber(lfind,"edit_counter")
				dw_extra.SetItem(lrow,"edit_counter",lEditCounter + 1)
			
				dw_extra.SetItem(lrow,"nquantity_old",dsextraOld.GetItemNumber(lfind,"nquantity"))
				dw_extra.SetItem(lRow,"nmanual_input",1)
	
				strUserChanges.bExtraChanged  = true
				wf_chc_show_changes(dw_extra,"nquantity",lrow)
			end if
		// ---------------------------------------
		// Passagiere
		// Masterchange!
		// ---------------------------------------
			if dw_extra.GetItemNumber(lrow,"npax_manual") <> &
				 dsextraOld.GetItemNumber(lfind,"npax_manual") then
				dw_extra.SetItemStatus(lrow, "npax_manual", Primary!, DataModified!)
	
				dw_extra.SetItem(lRow,"nmanual_input",1)
				bForceMealCalculation = true
			end if	
		// ---------------------------------------
		// Reserve
		// Masterchange!
		// ---------------------------------------
			if dw_extra.GetItemNumber(lrow,"nreserve_quantity") <> &
			  dsextraOld.GetItemNumber(lfind,"nreserve_quantity") then
					dw_extra.SetItemStatus(lrow, "nreserve_quantity", Primary!, DataModified!)
	
					dw_extra.SetItem(lRow,"nmanual_input",1)
					//post wf_master_change()
					bForceMealCalculation = true
			end if	
		// ---------------------------------------
		// Topoff
		// Masterchange!
		// ---------------------------------------
			if dw_extra.GetItemNumber(lrow,"ntopoff_quantity") <> &
			  dsextraOld.GetItemNumber(lfind,"ntopoff_quantity") then
					dw_extra.SetItemStatus(lrow, "ntopoff_quantity", Primary!, DataModified!)
					dw_extra.SetItem(lRow,"nmanual_input",1)
					//post wf_master_change()
					bForceMealCalculation = true
			end if	
	

		End if
		
	next

	//-------------------------------------------------------------------------
	//  Ermittle $$HEX1$$c400$$ENDHEX$$nderungen in SPML-Tabelle, setze $$HEX1$$c400$$ENDHEX$$nderungsstatus
	//-------------------------------------------------------------------------
	wf_chc_trace(50,"[wf_chc_get_differences] dw_spml | No of entries: new: " + String(dw_spml.rowcount() ) + " old: " + String(dsSpmlOld.rowcount()  ))
	if dw_spml.rowcount() <> dsSpmlold.rowcount() then
			 bAnychange = true
			 bManualChanges = true
		     bForceMealCalculation = true
			this.bDoMealCalculation = true
	end if
	For lrow = 1 to dw_spml.rowcount()
		sFind="nprio = " + String(dw_Spml.getItemNumber(lrow,"nprio")) + &
	 		" and nmaster_key = " +  String(dw_SPML.getItemNumber(lrow,"nmaster_key")) + &
					" and nclass_number = " + String(dw_Spml.getItemNumber(lrow,"nclass_number")) 
			
		lfind=dsSpmlOld.Find(sFind,1, dsSpmlold.rowcount())
		
		if lfind <= 0 then
			if bReadFromHistory then
					// --------------------------------------------------------------------------------------------------------------------
					// 22.11.2013 HR: Wir pr$$HEX1$$fc00$$ENDHEX$$fen sicherheitshalber noch mal, ob SPML in CEN_OUT_SPML vorhanden ist
					// --------------------------------------------------------------------------------------------------------------------
					lmaster_key = dw_SPML.getItemNumber(lrow,"nmaster_key")
					select count(*) into :lfind from cen_out_spml where nmaster_key = :lmaster_key;
					if lfind > 0 then
						dw_Spml.SetItemStatus(lrow, 0, Primary!, DataModified!)
					else
						dw_Spml.SetItemStatus(lrow, 0, Primary!, NewModified!)
					end if
			else
				// 11.11.2009 HR: Auskommentiert, da bei normaler Verarbeitung der Datensatz den richtigen Status hat
				//dw_Spml.SetItemStatus(lrow, 0, Primary!, NewModified!)
			end if
			 bAnychange = true
			 bManualChanges = true
		     bForceMealCalculation = true
			this.bDoMealCalculation = true
			wf_chc_trace(50,"[wf_chc_get_differences] dw_spml | New entry class " + String(dw_Spml.getItemNumber(lrow,"nclass_number")) + " cspml " + dw_Spml.getItemString(lrow,"cspml") + " nquantity "+ String( dw_Spml.GetItemNumber(lrow,"nquantity")) )

		else
			if dw_Spml.GetItemNumber(lrow,"nquantity") <> &
				 dsSpmlOld.GetItemNumber(lfind,"nquantity") then
				 //bAnychange = true
				//bManualChanges = true
				wf_chc_trace(50,"[wf_chc_get_differences] dw_spml | Changed class " + String(dw_Spml.getItemNumber(lrow,"nclass_number")) + " cspml " + dw_Spml.getItemString(lrow,"cspml") + " nquantity new: "+ String( dw_Spml.GetItemNumber(lrow,"nquantity")) + " old: " + String(dsSpmlOld.GetItemNumber(lfind,"nquantity")) )

				dw_Spml.SetItemStatus(lrow, "nquantity", Primary!, DataModified!)
				
				lEditCounter = dsSpmlOld.GetItemNumber(lfind,"edit_counter")
				dw_Spml.SetItem(lrow,"edit_counter",lEditCounter + 1)
			
				// 11.11.2009 HR: Wird in der F$$HEX1$$fc00$$ENDHEX$$llroutine gesetzt
				//dw_Spml.SetItem(lrow,"nquantity_old",dsSpmlOld.GetItemNumber(lfind,"nquantity"))
					//	
					// Achtung: compute_sum (Anzahl SPML je Klasse)
					//
				lclass_number = dw_Spml.GetItemNumber(lRow,"nclass_number")
				lFound = dw_pax.Find("nclass_number = " + string(lclass_number) + " and nbooking_class = 1",1,dw_pax.RowCount())
				if lFound > 0 then
						lVersCheck = dw_pax.GetItemNumber(lFound,"nversion")
						if lVersCheck < dw_Spml.GetItemNumber(lrow,"nquantity") then
							dw_Spml.SetItem(lrow, "nquantity", lVersCheck)
						end if
						//this.post event ue_set_spml(lRow,lFound)
				end if
				bForceMealCalculation = true
				this.bDoMealCalculation = true
				strUserChanges.bSpmlChanged  = true
				wf_chc_show_changes(dw_Spml,"nquantity",lrow)
	
			else
				wf_chc_trace(160,"[wf_chc_get_differences] dw_spml | Unchanged class " + String(dw_Spml.getItemNumber(lrow,"nclass_number")) + " cspml " + dw_Spml.getItemString(lrow,"cspml") + " nquantity "+ String( dw_Spml.GetItemNumber(lrow,"nquantity")) )

			end if
		// ---------------------------------------
		// Topoff
		// ---------------------------------------
			if dw_Spml.GetItemNumber(lrow,"ntopoff") <> &
			  dsSpmlOld.GetItemNumber(lfind,"ntopoff") then
					dw_SPML.SetItemStatus(lrow, "ntopoff", Primary!, DataModified!)
					bForceMealCalculation = true
				wf_chc_trace(50,"[wf_chc_get_differences] dw_spml | Changed class " + String(dw_Spml.getItemNumber(lrow,"nclass_number")) + " cspml " + dw_Spml.getItemString(lrow,"cspml") + " ntopoff new: "+ String( dw_Spml.GetItemNumber(lrow,"ntopoff")) + " old: " + String(dsSpmlOld.GetItemNumber(lfind,"ntopoff")) )

			end if	
		// ---------------------------------------
		// cadd_text
		// ---------------------------------------
		
			if dw_Spml.GetItemString(lrow,"cadd_text") <> &
			  dsSpmlOld.GetItemString(lfind,"cadd_text") then
				dw_Spml.SetItemStatus(lrow, "cadd_text", Primary!, DataModified!)
				wf_chc_trace(50,"[wf_chc_get_differences] dw_spml | Changed class " + String(dw_Spml.getItemNumber(lrow,"nclass_number")) + " cspml " + dw_Spml.getItemString(lrow,"cspml") + " cadd_text new: "+ dw_Spml.GetItemString(lrow,"cadd_text") + " old: " + dsSpmlOld.GetItemString(lfind,"cadd_text") )

				bForceMealCalculation = true
			end if

	// ---------------------------
	// Klasse
	// ---------------------------
			if dw_Spml.GetItemString(lrow,"cclass") <> &
			  dsSpmlOld.GetItemString(lfind,"cclass") then
	
		/*		lFound = dsValidSPML.Find("nairline_key = " + string(lAirline_Key) + " and cclass = '" + sData + "'" &
											,1,dsValidSPML.RowCount())
		if lFound > 0 then
			lclass_number = dsValidSPML.GetItemNumber(lFound,"nclass_number")
			this.SetItem(lrow, "nclass_number", lclass_number)
		else
			return 1
		end if
		//
		// $$HEX1$$c400$$ENDHEX$$nderungen f$$HEX1$$fc00$$ENDHEX$$r neue Zeile merken
		//
		lCurrentClassNumber 	= lclass_number
		sCurrentClassName		= sData
		*/
				wf_chc_trace(50,"[wf_chc_get_differences] dw_spml | Changed class " + String(dw_Spml.getItemNumber(lrow,"nclass_number")) + " cspml " + dw_Spml.getItemString(lrow,"cspml") + " cclass new: "+ dw_Spml.GetItemString(lrow,"cclass") + " old: " + dsSpmlOld.GetItemString(lfind,"cclass") )
				dw_Spml.SetItemStatus(lrow, "cclass", Primary!, DataModified!)
		
				bForceMealCalculation = true
			end if
	// ---------------------------
	// cspml
	// ---------------------------
			if dw_Spml.GetItemString(lrow,"cspml") <> &
			  dsSpmlOld.GetItemString(lfind,"cspml") then
			  	wf_chc_trace(50,"[wf_chc_get_differences] dw_spml | Changed class " + String(dw_Spml.getItemNumber(lrow,"nclass_number")) + " cspml " + dw_Spml.getItemString(lrow,"cspml") + " cspml new: "+ dw_Spml.GetItemString(lrow,"cspml") + " old: " + dsSpmlOld.GetItemString(lfind,"cspml") )

				dw_Spml.SetItemStatus(lrow, "cspml", Primary!, DataModified!)
				sData = dw_Spml.GetItemString(lrow,"cspml") 
//		lFound = dsValidSPML.Find("cspml = '" + sData + "' and nairline_key = " + string(lAirline_Key) &
//											,1,dsValidSPML.RowCount())
				sFind = "match(cspml,'^" + sData + "') and nairline_key = " + string(dw_single.GetItemNumber(dw_single.getRow(),"nairline_key"))
				lFound = dsValidSPML.Find(sFind,1,dsValidSPML.RowCount())
				if lFound <= 0 then
					wf_chc_trace(50,"[wf_chc_get_differences] dw_spml | Changed class " + String(dw_Spml.getItemNumber(lrow,"nclass_number")) + " > No Valid Spml-Key found ") 
					dw_spml.SetItem(lRow,"nspml_key",lNull)
			//	return 1
				else
					wf_chc_trace(50,"[wf_chc_get_differences] dw_spml | Changed class " + String(dw_Spml.getItemNumber(lrow,"nclass_number")) + " > Valid Spml-Key found: " +String( dsValidSPML.GetItemNumber(lFound,"nspml_key")) )

					dw_spml.SetItem(lrow, "cspml",  dsValidSPML.GetItemString(lFound,"cspml"))
					dw_spml.SetItem(lRow,"nspml_key",dsValidSPML.GetItemNumber(lFound,"nspml_key"))
				end if
		
					bForceMealCalculation = true
		
				//wf_chc_set_spml_deduction(lrow)
	
			end if
		End if
		
	next

	
	return 0
end function

public function integer w_chc_master_change_selection ();//======================================================================================
//
// w_master_change_selection
//
// Vorbereitung Masterchange: Dialog w_master_change $$HEX1$$f600$$ENDHEX$$ffnen und $$HEX1$$c400$$ENDHEX$$nderungen $$HEX1$$fc00$$ENDHEX$$bertragen
//
//======================================================================================
long							lReturn, i, lFind
lCountlegs = 1

s_change_aircrafttypes 	strChange
string							sCurrentRegistration

strChange.laircraftkey			= dw_single.GetitemNumber(dw_single.Getrow(),"naircraft_key")
strChange.lhandlingkey		= dw_single.GetitemNumber(dw_single.Getrow(),"nhandling_type_key")
strChange.lcountlegs			= lcountlegs	// Anzahl Legs
strChange.lGroupKey			= lRoutingGroupKey
strChange.dDeparture		= Date(dw_single.GetitemDateTime(dw_single.Getrow(),"ddeparture"))
strChange.sDeparture_Time	= dw_single.GetitemString(dw_single.Getrow(),"cdeparture_time")
strChange.lairlinekey			= dw_single.GetitemNumber(dw_single.Getrow(),"nairline_key")
strChange.sAirline				= dw_single.GetitemString(dw_single.Getrow(),"cairline")
strChange.lFlightnumber    	= dw_single.GetitemNumber(dw_single.Getrow(),"nflight_number")
strChange.sSuffix 				= dw_single.GetitemString(dw_single.Getrow(),"csuffix")
strChange.lresultkey			= dw_single.GetitemNumber(dw_single.Getrow(),"nresult_key")
strChange.bmeals 				= bChangeNoMeals	
strChange.bExtra 				= bChangeNoExtra
lVersionGroupKey				= wf_chc_get_version_group_key()
if lVersionGroupKey = - 1 then
	f_Log2Csv(0,2,"[w_chc_master_change_selection] Ung$$HEX1$$fc00$$ENDHEX$$ltige Sitzplatzversion f$$HEX1$$fc00$$ENDHEX$$r Flugger$$HEX1$$e400$$ENDHEX$$t!")
end if
strChange.lVersionGroupKey = lVersionGroupKey

strChange.laircraftkey			= dw_single.GetitemNumber(dw_single.Getrow(),"naircraft_key")
strChange.lhandlingkey		= dw_single.GetitemNumber(dw_single.Getrow(),"nhandling_type_key")
strChange.lcountlegs			= lcountlegs	// Anzahl Legs
strChange.lGroupKey			= lRoutingGroupKey
strChange.dDeparture		= Date(dw_single.GetitemDateTime(dw_single.Getrow(),"ddeparture"))
strChange.sDeparture_Time	= dw_single.GetitemString(dw_single.Getrow(),"cdeparture_time")
strChange.lairlinekey			= dw_single.GetitemNumber(dw_single.Getrow(),"nairline_key")
strChange.sAirline				= dw_single.GetitemString(dw_single.Getrow(),"cairline")
strChange.lFlightnumber    	= dw_single.GetitemNumber(dw_single.Getrow(),"nflight_number")
strChange.sSuffix 				= dw_single.GetitemString(dw_single.Getrow(),"csuffix")
strChange.lresultkey			= dw_single.GetitemNumber(dw_single.Getrow(),"nresult_key")
strChange.bmeals 				= bChangeNoMeals	
strChange.bExtra 				= bChangeNoExtra
lVersionGroupKey				= wf_chc_get_version_group_key()
if lVersionGroupKey = - 1 then
	f_Log2Csv(0,2,"[w_chc_master_change_selection] Ung$$HEX1$$fc00$$ENDHEX$$ltige Sitzplatzversion f$$HEX1$$fc00$$ENDHEX$$r Flugger$$HEX1$$e400$$ENDHEX$$t!")
end if
strChange.lVersionGroupKey = lVersionGroupKey
strChange.sOwner				= dw_single.GetItemString(dw_single.Getrow(),"cairline_owner")
strChange.llegnr				= dw_single.GetitemNumber(dw_single.Getrow(),"nleg_number")
strChange.sOriginalTime		= dw_single.GetitemString(dw_single.Getrow(),"coriginal_time")
strChange.sregistration		= dw_single.GetitemString(dw_single.Getrow(),"cregistration")
strChange.dreturn_date		= Date(dw_single.GetitemDateTime(dw_single.Getrow(),"dreturn_date"))

//
// Passagierzahlen $$HEX1$$fc00$$ENDHEX$$bergeben, da diese bereits ver$$HEX1$$e400$$ENDHEX$$ndert sein k$$HEX1$$f600$$ENDHEX$$nnen
//
strChange.dspax				= Create uo_generate_datastore
strChange.dspax.DataObject = "dw_change_cen_out_passenger"
//strChange.dspax.DataObject = "dw_invoice_ml_cen_out_passenger"
strChange.dspax.SetTransObject(SQLCA)
//dw_pax.RowsCopy(1,dw_pax.rowcount(),Primary!,strChange.dspax,1,Primary!)
// Umsetzen dw_invoice_ml_cen_out_passenger auf Format von
//						 dw_change_cen_out_passenger 
wf_ml_rowscopy_pax(dw_pax,1,dw_pax.rowcount(),strChange.dspax,1)
i=strChange.dspax.rowcount()


strChange.iStatus						= iChangeStatus
strChange.iflight_status			= iFlightStatus
strChange.iVersionCheckPlanung	= iVersionCheckPlanung
strChange.iVersionCheckProd1		= iVersionCheckProd1
strChange.iVersionCheckProd2		= iVersionCheckProd2
strChange.iVersionCheckMBox		= iVersionCheckMBox



// ---------------------------------------------------------------
// Sonderverarbeitung: Masterchange $$HEX1$$fc00$$ENDHEX$$ber mehrere Legs
// ---------------------------------------------------------------	
bChangeMultipleLegs	= strChange.bchangemultiplelegs
if bChangeMultipleLegs then
	strMultipleChange.laircraftkey 		= strChange.laircraftkey
	strMultipleChange.sowner 				= strChange.sowner
	strMultipleChange.sactype 				= strChange.sactype
	strMultipleChange.lownerkey 			= strChange.lownerkey
	strMultipleChange.sgalleyversion 	= strChange.sgalleyversion
	strMultipleChange.lVersionGroupKey 	= strChange.lVersionGroupKey
	strMultipleChange.llegnumber			= strChange.llegnr
	strMultipleChange.lcountlegs			= strChange.lcountlegs
	strMultipleChange.lhandlingkey		= strChange.lhandlingkey
	strMultipleChange.sdeparture_time	= strChange.sDeparture_Time
	//
	// Registration immer vom 1. Leg $$HEX1$$fc00$$ENDHEX$$bertragen
	//
	if strChange.llegnr = 1 then
		strMultipleChange.sregistration	= strChange.sregistration
	end if
else
	strMultipleChange = strEmpty
end if

// -------------------------------------------------
// Dirty Aircraft Change, True = keine Ver$$HEX1$$e400$$ENDHEX$$nderung
// -------------------------------------------------	
bChangeNoMeals		= strChange.bmeals
bChangeNoExtra		= strChange.bExtra

// ---------------------------------------------------------------
//
// Der Flug wird annulliert
//
// 20.05.05	Ab jetzt mit EGVV
//
// ---------------------------------------------------------------	
If iFlightStatus <> 1 and strChange.iFlight_Status = 1 then
	iFlightStatus = strChange.iFlight_Status
	dw_single.SetItem(dw_single.Getrow(),"nflight_status",strChange.iFlight_Status)
	dw_single.SetItem(dw_single.Getrow(),"cheader1",uf.translate("Annulliert") + " - " + string(today()) + " " + string(now()))
	dw_single.SetItem(dw_single.Getrow(),"nrefund",0)
	bCancelAction	= True
	lCalculationCounter++	// neu, denn CNX hat Auswirkungen auf Matdispo
	ib_checkpoint_cx = true // 09.03.2015 HR: Anpassungen f$$HEX1$$fc00$$ENDHEX$$r Flightchecker Teil II
	
	if isvalid(strChange.dspax) then destroy strChange.dspax
	
	return 0
ElseIf iFlightStatus = 1 and strChange.iFlight_Status <> 1 then
	// 
	// Der Flug war annulliert und wird wieder ins Rennen geschickt
	// mit dem alten Flugstatus.
	// 
	iFlightStatus = strChange.iFlight_Status
	dw_single.SetItem(dw_single.Getrow(),"nflight_status",strChange.iFlight_Status)
	dw_single.SetItem(dw_single.Getrow(),"cheader1",uf.translate("Annullierung aufgehoben"))
	dw_single.SetItem(dw_single.Getrow(),"nrefund", &
							wf_chc_check_refund(dw_single.GetitemNumber(dw_single.Getrow(),"nairline_key"),&
												dw_single.GetitemNumber(dw_single.Getrow(),"ntlc_from"), &
												dw_single.GetitemNumber(dw_single.Getrow(),"ntlc_to")))
	//
	// Ber$$HEX1$$fc00$$ENDHEX$$cksichtige REQ
	//
	if dw_single.GetItemString(dw_single.Getrow(),"chandling_type_text") = "REQ" then
		iFlightStatus = 2
		dw_single.SetItem(dw_single.Getrow(),"nflight_status",iFlightStatus)
	end if

	bCancelAction	= True
	ib_checkpoint_cx_undo = true // 09.03.2015 HR: Anpassungen f$$HEX1$$fc00$$ENDHEX$$r Flightchecker Teil II
End if

// ---------------------------------------------------------------
// Update Tag 7, das rote L$$HEX1$$e400$$ENDHEX$$mpchen ausschalten
// ---------------------------------------------------------------
If dw_single.GetItemNumber(dw_single.Getrow(),"nstatus_update7") = 2 Then
	dw_single.SetItem(dw_single.Getrow(),"nstatus_update7",1)
End if

// --------------------------------------------------------------
// Es wurden Paxe ver$$HEX1$$e400$$ENDHEX$$ndert bzw. Version verr$$HEX1$$fc00$$ENDHEX$$ckt
// --------------------------------------------------------------
if strChange.bdo_meal_calculation = true then
	bDoMealCalculation = true
else
	bDoMealCalculation = false
end if

// ----------------------------------------
// vorgezogen: 
// Passagierzahlen zur$$HEX1$$fc00$$ENDHEX$$ckkopieren
// Wichtig, da aufgrund der neuen Version
// der Zugriff auf dw_pax stattfindet
// ----------------------------------------	
for i = dw_pax.RowCount() to 1 step -1
	dw_pax.DeleteRow(i)
next
//strChange.dsPax.RowsCopy(1,strChange.dsPax.RowCount(),Primary!,dw_pax,1,Primary!)
wf_ml_rowscopy_pax(strChange.dsPax,1,strChange.dsPax.RowCount(), dw_pax,1)
/*if iEnterPaxData = 1 then // Station gibt ein
	for i =  1 to dw_pax.RowCount()
		 dw_pax.SetItem(i,"nstationentry",i_isStationEntry)
	next
end if */
// ----------------------------------------
// Flugger$$HEX1$$e400$$ENDHEX$$t
// ----------------------------------------	
If strChange.laircraftkey <> dw_single.GetItemNumber(dw_single.Getrow(),"naircraft_key") Then
	dw_single.SetItem(dw_single.Getrow(),"naircraft_key",strChange.laircraftkey)
	dw_single.SetItem(dw_single.Getrow(),"cairline_owner",strChange.sowner)	
	dw_single.SetItem(dw_single.Getrow(),"cactype",strChange.sactype)		
	dw_single.SetItem(dw_single.Getrow(),"nairline_owner_key",strChange.lownerkey)			
	dw_single.SetItem(dw_single.Getrow(),"cgalleyversion",strChange.sgalleyversion)
	if strChange.llegnr > 1 then
		dw_single.SetItem(dw_single.Getrow(),"cregistration",strMultipleChange.sregistration)
		wf_chc_show_changes(dw_single,"cregistration",dw_single.Getrow())
	end if
	// --------------------------------------------
	// Den neuen Versionsstring setzen
	// --------------------------------------------
	dw_single.SetItem(dw_single.Getrow(),"cconfiguration",strChange.sversionstring)
	// -------------------------------------------------------------------------
	// 15.04.05	G$$HEX1$$fc00$$ENDHEX$$ltige Sitzplatzversionen holen
	// -------------------------------------------------------------------------
	uo_configurations.uf_retrieve(strChange.laircraftkey)
	// --------------------------------------------
	// G$$HEX1$$fc00$$ENDHEX$$ltige Versionen holen und die neue Version in dw_pax eintragen
	// --------------------------------------------
	wf_chc_show_changes(dw_single,"cairline_owner",dw_single.Getrow())
	wf_chc_show_changes(dw_single,"cactype",dw_single.Getrow())
	wf_chc_show_changes(dw_single,"cgalleyversion",dw_single.Getrow())
	wf_chc_show_changes(dw_single,"cconfiguration",dw_single.Getrow())
End if
// ----------------------------------------
// Sitzplatzversion tauschen
// ----------------------------------------	
If strChange.lVersionGroupKey <> lVersionGroupKey Then
	dw_single.SetItem(dw_single.Getrow(),"cconfiguration",strChange.sversionstring)
	wf_chc_show_changes(dw_single,"cconfiguration",dw_single.Getrow())
End if

// ----------------------------------------
// Abflug
// ----------------------------------------
If strChange.dDeparture <> Date(dw_single.GetItemDateTime(dw_single.Getrow(),"ddeparture")) Then
	dw_single.SetItem(dw_single.Getrow(),"ddeparture",strChange.dDeparture)	
	dw_single.SetItem(dw_single.Getrow(),"doriginal_departure",strChange.dDeparture)	
	dw_single.SetItem(dw_single.Getrow(),"dreturn_date",strChange.dDeparture)	
	wf_chc_show_changes(dw_single,"ddeparture",dw_single.Getrow())
End if	

If strChange.sDeparture_Time <> dw_single.GetItemString(dw_single.Getrow(),"cdeparture_time") Then
	dw_single.SetItem(dw_single.Getrow(),"cdeparture_time",strChange.sDeparture_Time)
	dw_single.SetItem(dw_single.Getrow(),"csort_time",strChange.sDeparture_Time)
	// 09.07.: Auch bei Uhrzeit-$$HEX1$$c400$$ENDHEX$$nderung die Mahlzeiten neu holen
	bDoMealCalculation = true
	wf_chc_show_changes(dw_single,"cdeparture_time",dw_single.Getrow())
End if

If strChange.sOriginalTime <> dw_single.GetItemString(dw_single.Getrow(),"coriginal_time") Then
	dw_single.SetItem(dw_single.Getrow(),"coriginal_time",strChange.sOriginalTime)
	// 09.07.: Auch bei Uhrzeit-$$HEX1$$c400$$ENDHEX$$nderung die Mahlzeiten neu holen
	bDoMealCalculation = true
	wf_chc_show_changes(dw_single,"coriginal_time",dw_single.Getrow())
End if
//
// 21.04.05: Return-Date
//
If strChange.dreturn_date <> Date(dw_single.GetItemDateTime(dw_single.Getrow(),"dreturn_date")) Then
	dw_single.SetItem(dw_single.Getrow(),"dreturn_date",strChange.dreturn_date)	
End if	

// ----------------------------------------
// Handling
// ----------------------------------------	
If strChange.lhandlingkey <> dw_single.GetItemNumber(dw_single.Getrow(),"nhandling_type_key") Then
	dw_single.SetItem(dw_single.Getrow(),"nhandling_type_key",strChange.lhandlingkey)
	dw_single.SetItem(dw_single.Getrow(),"chandling_type_text",strChange.shandlingtext)
	dw_single.SetItem(dw_single.Getrow(),"chandling_type_description",strChange.shandlingdescription)
	wf_chc_show_changes(dw_single,"chandling_type_text",dw_single.Getrow())
	//
	// 29.03.05: Ber$$HEX1$$fc00$$ENDHEX$$cksichtige REQ
	//
	if strChange.shandlingtext = "REQ" then
		iFlightStatus = 2
		dw_single.SetItem(dw_single.Getrow(),"nflight_status",iFlightStatus)
	else
		if iFlightStatus <> 1 then
			iFlightStatus = 0
			dw_single.SetItem(dw_single.Getrow(),"nflight_status",iFlightStatus)
		end if
	end if
End if	
// ----------------------------------------
// Registration (07.03.2005)
// ----------------------------------------
sCurrentRegistration = dw_single.GetItemString(dw_single.Getrow(),"cregistration")
if isnull(sCurrentRegistration) then sCurrentRegistration = ""
If strChange.sregistration <> sCurrentRegistration Then
	dw_single.SetItem(dw_single.Getrow(),"cregistration",strChange.sregistration)
	wf_chc_show_changes(dw_single,"cregistration",dw_single.Getrow())
End if

// --------------------------------------------
// Die neue Beladung ermitteln
// --------------------------------------------

wf_chc_master_change()
//dw_single.Accepttext()

if isvalid(strChange.dspax) then destroy strChange.dspax

return 0
end function

public function long wf_chc_get_version_group_key ();//-----------------------------------------------------------------------------------
//
// wf_chc_get_version_group_key
//
// Holt den Version-Group-Key f$$HEX1$$fc00$$ENDHEX$$r dieses Flugger$$HEX1$$e400$$ENDHEX$$t
// und bezieht sich dabei auf die in dw_single angezeigten Daten!
//
//-----------------------------------------------------------------------------------
string	sAircraftOwner
string	sAircraftType
string	sClassName[]
integer	iSeatVersion[]
integer	iClassNumber[]
string	sMessage
long		i
long		lKey
long		lAirline_Key

uo_get_aircraft uo_get_ac

lKey = -1

//
// Initialisierung
//
sAircraftOwner	= dw_single.GetItemString(dw_single.GetRow(),"cairline_owner")
sAircraftType	= dw_single.GetItemString(dw_single.GetRow(),"cactype")
lAirline_Key	= dw_single.GetItemNumber(dw_single.GetRow(),"nairline_key")

for i = 1 to dw_pax.RowCount()
	if dw_pax.GetItemNumber(i,"nbooking_class") <> 1 then
		//
		// Klasse ist keine Buchungsklasse und zur Ermittlung der Version 
		// nicht geeignet
		//
		exit
	end if
	iSeatVersion[i] 			= dw_pax.GetItemNumber(i,"nversion")
	sClassName[i] 				= dw_pax.GetItemString(i,"cclass")
	iClassNumber[i] 			= dw_pax.GetItemNumber(i,"nclass_number")
next

//
// Abfrage
//
uo_get_ac = create uo_get_aircraft

uo_get_ac.sOwner 				= sAircraftOwner
uo_get_ac.sActype 			= sAircraftType
uo_get_ac.sClass[]			= sClassName[]
uo_get_ac.iVersion[]			= iSeatVersion[]
uo_get_ac.iClassNumber[]	= iClassNumber[]
uo_get_ac.lAirline_Key		= lAirline_Key

if uo_get_ac.of_get_aircraft() <> 0 then
	sMessage	= uf.translate("Flugdaten enthalten ein unbekanntes Flugger$$HEX1$$e400$$ENDHEX$$t.")
	destroy uo_get_ac
	return -1
end if

lKey	= uo_get_ac.lGroup_key

destroy uo_get_ac

return lKey

end function

public function integer wf_chc_change_aircraft_version (long arg_versiongroupkey);// -------------------------------------------------
// Version in dw_pax eintragen
// ------------------------------------------------
long		lChildRow
Long		lFindRow
Long		i
integer	iVersion
Long		lClassNumber

For i = 1 to dsAircaftVersion.Rowcount()
	If dsAircaftVersion.Getitemnumber(i,"ngroup_key") =  arg_versiongroupkey Then
		iVersion 		= dsAircaftVersion.Getitemnumber(i,"nversion")
		lClassNumber 	= dsAircaftVersion.Getitemnumber(i,"nclass_number")
		lFindRow 		= dw_pax.Find("nclass_number = " + string(lClassNumber),1,dw_pax.rowcount())
		If lFindRow > 0 Then
			dw_pax.Setitem(lFindRow,"nversion",iVersion)
			wf_chc_show_changes(dw_pax,"nversion",i)
		End if
	End if
Next



dw_pax.Sort()
dw_pax.Groupcalc()
Return 0

end function

public function integer wf_chc_create_aircraft_version (long laircraftkey, boolean bmodified);//-----------------------------------------------------------------------------------
//
// wf_chc_create_aircraft_version
//
// Holt alle g$$HEX1$$fc00$$ENDHEX$$ltigen Sitzplatz-Versionen je Flugger$$HEX1$$e400$$ENDHEX$$t
//
//-----------------------------------------------------------------------------------

// -------------------------------------------------
// Versionsstring f$$HEX1$$fc00$$ENDHEX$$r aktuelles Flugger$$HEX1$$e400$$ENDHEX$$t erstellen
// ------------------------------------------------
long		lRow

//If dw_1.Rowcount() <= 0 Then Return 0
// -------------------------------------------------
// Datastore dsAircaftCurrentVersion Reset
// ------------------------------------------------
dsAircaftCurrentVersion.Reset()
lRow = dsAircaftVersion.Retrieve(lAircraftKey)

Return lRow

end function

public function integer wf_chc_check_refund (long arg_customer, long arg_tlc_from, long arg_tlc_to);// ------------------------------------------------------------------------
//
// wf_chc_check_refund
//
// Ist ein Flug EG-Erstattungsf$$HEX1$$e400$$ENDHEX$$hig??
//
// ------------------------------------------------------------------------
long 		lRows
integer	iRefund

datastore dsTrafficAreas

dsTrafficAreas = create datastore
dsTrafficAreas.DataObject = "dw_change_traffic_areas"
dsTrafficAreas.SetTransObject(SQLCA)

lRows = dsTrafficAreas.Retrieve(arg_customer,ddeparture,arg_tlc_from,arg_tlc_to)
if lRows > 0 then
	iRefund = dsTrafficAreas.GetItemNumber(1,"nrefund")
	destroy dsTrafficAreas
	return iRefund
else
	destroy dsTrafficAreas
	return 0
end if


end function

public function boolean wf_chc_flight_closed (ref string smessage);//===================================================================================
//
// wf_chc_flight_closed
// 
//===================================================================================
//
// Aufruf aus wf_chc_action
// Flug soll Flight-Closed gesetzt werden
//
//===================================================================================
DateTime		dtCheckdate
long			lActCustomerKey

long			lCurrentLeg, lGroupKey
long			lFind
string			sRegistrationLeg1, sCurrentRegistration
integer		iFlightCloseOfCXwithoutReg

// --------------------------------------------
// Flight Closed Status 6 setzen
// --------------------------------------------
iChangeStatus	= 6
dtCheckdate		= DateTime(Date(dw_single.GetitemDateTime(dw_single.getrow(),"ddeparture")), + &
								  Time(dw_single.GetitemString(dw_single.getrow(),"cdeparture_time")))
								  

//
// Abflugzeit muss $$HEX1$$fc00$$ENDHEX$$berschritten sein
//
if isnull(sMessage) then sMessage = ""
f_Log2Csv(0,1,"wf_chc_flight_closed(" +sMessage  + "), ii_action = " + string(ii_action))
f_Log2Csv(0,1,"dw_single.getrow() = " + string(dw_single.getrow()))
f_Log2Csv(0,1,"dw_single.GetitemDateTime(dw_single.getrow(),dtimestamp) = " + string(dw_single.GetitemDateTime(dw_single.getrow(),"dtimestamp")))
f_Log2Csv(0,1,"dtCheckdate = " + string(dtCheckdate))

// 30.09.2013 HR: $$HEX1$$dc00$$ENDHEX$$bernahme aus TRUNK
iFlightCloseOfCXwithoutReg = integer(f_unitprofilestring("Default","FlightCloseOfCXwithoutReg","0", dw_single.GetItemString(dw_single.Getrow(),"cunit")) )

// 26.04.2010 HR: ii_action-Code von 5 auf 2 ge$$HEX1$$e400$$ENDHEX$$ndert
If (ii_action = 2) Then 	// Aufruf erfolgt $$HEX1$$fc00$$ENDHEX$$ber Web
	If isnull(dw_single.GetitemDateTime(dw_single.getrow(),"dtimestamp")) Then
		// Timestamp nicht gesetzt (verwende alte Logik, Abgleich gegen Server-Datum)
		f_Log2Csv(0,1,"dtimestamp is Null")
		If DateTime(Today(),Now()) < dtCheckdate Then
			sMessage = uf.translate("Flug hat Abflugzeit noch nicht erreicht.")
			
			return False
		End If
	Else
		// Timestamp gesetzt ( Abgleich gegen Client-Datum welches vom Web im Feld dtimestamp gesetzt wird)
		// TLE130309 dtimestamp kann ggf. bei Neurechnung Flug schon auf das Serverdatum gesetzt worden sein	
		//                  Nutzen des zuvor abgegriffenen Wertes
		IF isnull(dtTimestampFromWeb) then
			f_Log2Csv(0,1,"[wf_chc_flight_closed] dtimestampFromWeb is Null")
			If dw_single.GetitemDateTime(dw_single.getrow(),"dtimestamp") < dtCheckdate Then
				sMessage = uf.translate("Flug hat Abflugzeit noch nicht erreicht.")
				return False
			End if
		else
			f_Log2Csv(0,1,"[wf_chc_flight_closed] dtimestampFromWeb " + String(dtTimestampFromWeb))
			If dtTimestampFromWeb < dtCheckdate Then
				sMessage = uf.translate("Flug hat Abflugzeit noch nicht erreicht.")
				return False
			End if
		End If
	End If
		
Else
	If DateTime(Today(),Now()) < dtCheckdate Then
		sMessage = uf.translate("Flug hat Abflugzeit noch nicht erreicht.")
		return False
	End If
End if
//
// 20.04.2005	Jetzt auch bei FlightClosed: $$HEX1$$dc00$$ENDHEX$$bertrag der Registration vom ersten Leg
//
/*
if iKeepRegistration = 1 then
	lCurrentLeg = dw_1.GetItemNumber(lrow,"nleg_number")
	if lCurrentLeg > 1 then
		lGroupKey	= dw_1.GetItemNumber(lrow,"nresult_key_group")
		lFind = dw_1.Find("nresult_key_group = " + string(lGroupKey) + " and nleg_number = 1",1,dw_1.RowCount())
		if lFind > 0 then
			if iKeepRegistration = 1 then
				sRegistrationLeg1 = dw_1.GetItemString(lFind,"cregistration")
				//
				// 07.11.05	Nur setzen wenn ge$$HEX1$$e400$$ENDHEX$$ndert
				//
				sCurrentRegistration = dw_single.GetItemString(dw_single.GetRow(),"cregistration")
				if not isnull(sRegistrationLeg1) then
					if sCurrentRegistration <> sRegistrationLeg1 then
						//
						// 17.10.2005	Nur dann Registration vom 1. Leg setzen, wenn nicht null.
						//					Fr$$HEX1$$fc00$$ENDHEX$$her hatte die n$$HEX1$$e400$$ENDHEX$$chste Pr$$HEX1$$fc00$$ENDHEX$$fung daf$$HEX1$$fc00$$ENDHEX$$r gesorgt, dass die
						//					M$$HEX1$$f600$$ENDHEX$$chten Sie Speichern-Frage kam.
						//
						dw_1.Setitem(lRow,"cregistration",sRegistrationLeg1)
						dw_single.Setitem(dw_single.GetRow(),"cregistration",sRegistrationLeg1)
					end if
				end if
			end if
		end if
	end if
end if
*/

// Ermittle Lieferanteneinstellungen
uo_suppl_unit.itype = 1 			// Flugereignis
uo_suppl_unit.dtdate =  dw_single.GetItemDatetime(dw_single.Getrow(),"ddeparture")
uo_suppl_unit.lCustomer =  dw_single.GetItemNumber(dw_single.Getrow(),"ncustomer_key") 
uo_suppl_unit.sUnit =  dw_single.GetItemString(dw_single.Getrow(),"cunit")	
uo_suppl_unit.dtToday = datetime(date(today()),time(now()))
uo_suppl_unit.of_retrieve_ds()
if uo_suppl_unit.i_suppl_interface_check_type = uo_suppl_unit.i_suppl_interface_check_type_2 and &
   s_app.iInvoicingType = 1 then	
	// keine Pr$$HEX1$$fc00$$ENDHEX$$fung auf Registration bei Monalisa-Auslandscaterer
else
//
// Flug muss eine Registration haben!
// 26.04.05: Aber nur, wenn er nicht OnRequest oder CNX ist
//

//
// Flug muss eine Registration haben!
// 26.04.05: Aber nur, wenn er nicht OnRequest oder CNX ist
// 01.12.08: CBASE-UK-EM-4427
//                Schalter eingebaut, der bei CX Fl$$HEX1$$fc00$$ENDHEX$$gen ggf auch die Pr$$HEX1$$fc00$$ENDHEX$$fung auf eine eingegebene Registration durchf$$HEX1$$fc00$$ENDHEX$$hrt
// 25.09.2013 HR: CBASE-CR-NAM-12047
//                         Registration-Pr$$HEX1$$fc00$$ENDHEX$$fung nur wenn bei Airline per Schalter die Pr$$HEX1$$fc00$$ENDHEX$$fung nicht ausgeschaltet ist

if wf_tailnumber_checkoff(dw_single.GetItemNumber(dw_single.GetRow(),"nairline_key")) = 0 and &
   (dw_single.GetItemNumber(dw_single.GetRow(),"nflight_status") = 0 or &
   (iFlightCloseOfCXwithoutReg=1 and dw_single.GetItemNumber(dw_single.GetRow(),"nflight_status") = 1)) then
//	if dw_single.GetItemNumber(dw_single.GetRow(),"nflight_status") = 0 then
		If	isnull(dw_single.GetitemString(dw_single.GetRow(),"cregistration")) or &
			len(trim(dw_single.GetitemString(dw_single.GetRow(),"cregistration"))) = 0 Then 
			sMessage= uf.translate("Flug hat keine Registration.")
			return False
		End if
	end if
end if
//
// Flug darf nicht bereits in der Abrechnung sein
//
If	dw_single.GetitemNumber(dw_single.getRow(),"nstatus") > 6 Then 
	sMessage = uf.translate("Flugstatus l$$HEX1$$e400$$ENDHEX$$sst keine Ver$$HEX1$$e400$$ENDHEX$$nderung zu.")
	return False
End if

//
// 17.02.2006 Flight-Pricer setzen
//
long		lSequence
datetime	dtCreated
time		tDepartureTime
datetime	dtDeparture

dtCreated 		= datetime(today(),now())
tDepartureTime = time(dw_single.GetItemString(dw_single.GetRow(),"cdeparture_time"))
dtDeparture		= datetime(ddeparture,tDepartureTime)

lSequence = f_Sequence("seq_sys_flight_pricer", sqlca)
If lSequence = -1 Then
	sMessage = uf.translate("Flug konnte nicht korrekt auf Flight-Closed gesetzt werden")
	return False
end if

insert into sys_flight_pricer (njob_nr, nresult_key, ddeparture, dcreated, nstatus, nfunction)
		values (:lSequence, :lresultkey_trace, :dtDeparture, :dtCreated, 0, 1);

if sqlca.sqlcode <> 0 then
	sMessage = uf.translate("Flug konnte nicht korrekt auf Flight-Closed gesetzt werden")
	return False
end if



dw_single.Setitem(dw_single.GetRow(),"nstatus",iChangeStatus)

If not wf_chc_save() Then

	sMessage = uf.translate("$$HEX1$$c400$$ENDHEX$$nderungen konnten nicht gespeichert werden.")
	return False
Else
	
	sMessage = uf.translate("Flugstatus wurde ver$$HEX1$$e400$$ENDHEX$$ndert.")
	lActCustomerKey = dw_single.GetItemNumber(dw_single.GetRow(),"ncustomer_key")
	wf_chc_set_billing_status(lActCustomerKey)
	return True
End if		

end function

public function integer wf_chc_set_billing_status (long arg_customer);//==============================================================================================
//
// wf_chc_set_billing_status
//
//==============================================================================================
//
// Erstmaliges Anlegen der Fl$$HEX1$$fc00$$ENDHEX$$ge nach FlightClosed f$$HEX1$$fc00$$ENDHEX$$r die Abrechnungs-
// $$HEX1$$fc00$$ENDHEX$$bertragungsstatistik.
//
//==============================================================================================
long		lRows
decimal	dcQuantity
long		lTotal

lRows = dsBillingStatus.Retrieve(s_app.sMandant, sViewunit, arg_customer, dDeparture)
if lRows = 0 then
	//
	// Info muss neu angelegt werden
	//
	dsBillingStatus.InsertRow(0)
	dsBillingStatus.SetItem(1,"cclient",				s_app.sMandant)
	dsBillingStatus.SetItem(1,"cunit",					sViewunit)
	dsBillingStatus.SetItem(1,"ddeparture",			dDeparture)
	dsBillingStatus.SetItem(1,"ncustomer_key",		arg_customer)
	dsBillingStatus.SetItem(1,"nflights_total",		1)
	dsBillingStatus.SetItem(1,"nflights_billing",	0)
	dsBillingStatus.SetItem(1,"nflights_sent",		0)
	dsBillingStatus.SetItem(1,"nquantity_sent",		0)
else
	//
	// Info muss aktualisiert werden
	//
	lTotal 		= dsBillingStatus.GetItemNumber(1,"nflights_total")
	//
	// Flug in Abrechnung transferieren
	//
	lTotal ++
	dsBillingStatus.SetItem(1,"nflights_total",		lTotal)
end if

if dsBillingStatus.Update() = 1 then
	commit;
	return 0
else

	rollback;
	return -1
end if

return 0

end function

public function integer wf_chc_validate_spml ();// ------------------------------------------------------------------------
//
// wf_chc_validate_spml
//
// pr$$HEX1$$fc00$$ENDHEX$$ft ob das SPML in Kombination mit MZ-Definition zul$$HEX1$$e400$$ENDHEX$$ssig ist
//
// ------------------------------------------------------------------------
long		i, j, lAnzSpml
long		lFind, lFindDef
long		lhmealkey, lhmealkeyold

string	sFind
string	sSPML
string	sAddText
string	sName
string	sClass

//
// Doppelte SPML sind nur erlaubt, wenn sie sich in Zusatztext und/oder Benamung unterscheiden
//
for i = 1 to dw_spml.RowCount()
	sSPML			= dw_spml.GetItemString(i,"cspml")
	sAddText		= dw_spml.GetItemString(i,"cadd_text")
	sName			= dw_spml.GetItemString(i,"cname")
	sClass		= dw_spml.GetItemString(i,"cclass")
	//


//	sFind	= 	"cspml = '" + sSPML + "' and cadd_text = '" + sAddText + &
//				"' and cname = '" + sName + "' and cclass = '" + sClass + "'"

	//
	// Erlaubte SPML abh$$HEX1$$e400$$ENDHEX$$ngig vom MZ-Baustein ermitteln
	//
	lFindDef = 0
	lhmealkeyold = 0	// 27.06.06 ...damit nach ung$$HEX1$$fc00$$ENDHEX$$ltigen SPML Verarbeitung weiter geht
	for j = 1 to dw_meal.RowCount()
		if dw_meal.GetItemString(j,"cclass") = sClass then
			lhmealkey = dw_meal.GetItemNumber(j,"nhandling_meal_key")
			if lhmealkey <> lhmealkeyold then
				dsValidSPMLDetail.Retrieve(lhmealkey,ddeparture)
				lFindDef = dsValidSPMLDetail.Find("sys_spml_cspml = '" + sSPML + "'",1,dsValidSPMLDetail.RowCount())
				if lFindDef > 0 then
					exit
				end if
				lhmealkeyold = lhmealkey
			else
				//
				// falls gleich, Info ausgeben Trace 
				//
				wf_chc_trace(10,"[wf_chc_validate_spml] Spml " + sSpml + " ( " + sClass + ") " + &
				     " not allowed with nhandling_meal_key "  + String(lhmealkeyold) + "  dsvalidSpmlDetail.Rowcount " &
					  + String(dsValidSPMLDetail.RowCount()))

			end if
		end if
	next
	if lFindDef = 0 then
		//
		// Info ausgeben Trace 
		//

		wf_chc_trace(10,"[wf_chc_validate_spml] Cspml not allowed with meals " + sSpml+ " ( " + sClass + ") ")
	end if
next

// --------------------------------------------------------------------------------------------------------------------
// 17.12.2009 HR: Jetzt werden noch die Mengen der SPMLs in DW_PAX $$HEX1$$fc00$$ENDHEX$$bertragen
// --------------------------------------------------------------------------------------------------------------------
for i=1 to dw_pax.rowcount()
	sClass		= dw_pax.GetItemString(i,"cclass")	
	j = dw_spml.find("cclass = '"+sClass+"'",1,dw_spml.rowcount())
	
	
	if j>0 then
		lAnzSpml = dw_spml.getitemnumber(j,"compute_sum")
	else
		lAnzSpml = 0
	end if

	if this.ifunction_pax_type = 1 	then	
		dw_pax.setitem(i, "npax_spml", lAnzSpml) 
				
		if ii_fill_forecast=1 then
			dw_pax.setitem(i, "npax_spml_forecast", lAnzSpml) 
		end if 
		
	elseif this.ifunction_pax_type = 2	then	
		dw_pax.setitem(i, "npax_spml_airline", lAnzSpml) 
	elseif this.ifunction_pax_type = 3	then 

	end if

next

return 0

end function

public function integer of_get_sys_flight_pax (long ljobnr);// -----------------------------------------
// Ermittle alle Paxdaten zu lJobnr 
// und $$HEX1$$dc00$$ENDHEX$$bernehmen der Werte in dw_pax
// -----------------------------------------
Long 		i
Long		lFound
Long		lResult_key
Long		lpax
Integer	istatus_release, istatus
Long		lAirline_key
String		sClass
long 		lspml



istatus_release = dw_single.getitemnumber(dw_single.getrow(),"nstatus_release")
if isnull(istatus_release) then istatus_release = 0

istatus = dw_single.getitemnumber(dw_single.getrow(),"nstatus")
if isnull(istatus) then istatus = 0


if istatus_release > 0 then  // Freigabe hat bereits stattgefunden, verwende exist. Werte ???
	return 0
end if

// aktuelle Flugdaten ermitteln
lAirline_key = dw_single.getitemnumber(dw_single.getrow(),"nairline_key")
lResult_key= dw_single.getitemnumber(dw_single.getrow(),"nresult_key")
istation_entry= this.istation_entry
dsSysQueueFlightPax.Retrieve(lJobnr) 
if dsSysQueueFlightPax.RowCount() > 0 then
	// ------------------------------------------------------------------------------------
	// zu jedem Eintrag in dw_pax wird neuer Wert in dsSysQueuedFlightPax gesucht und ggf. $$HEX1$$fc00$$ENDHEX$$bernommen
	// ------------------------------------------------------------------------------------
	// !! Eintr$$HEX1$$e400$$ENDHEX$$ge mit Klassen die nicht in dw_pax vorhanden sind, werden auch nicht verarbeitet !!
	// ------------------------------------------------------------------------------------
	for i = 1 to  dw_Pax.RowCount() 
		
		sClass = dw_pax.getItemString(i,"cclass")

		lFound = dsSysQueueFlightPax.Find("sys_queue_flight_pax_cclass = '" + sClass + "'",1,dsSysQueueFlightPax.RowCount())
		if lFound > 0 then
			lpax = dsSysQueueFlightPax.getitemnumber(lfound,"sys_queue_flight_pax_npax")
				
			// 10.11.2009 HR: Auch SPML-Menge $$HEX1$$fc00$$ENDHEX$$bertragen
			lspml = dsSysQueueFlightPax.getitemnumber(lfound,"anz_spml") 
			if isnull(lspml) then lspml=0
			
			if this.ifunction_pax_type = 1 	then	// npax
				wf_chc_trace(50,"[of_get_sys_flight_pax] dw_pax   |class " + sClass + " npax new: "+ String(lpax) + " old: "+String(dw_Pax.GetItemNumber(i,"npax") ))
				wf_chc_trace(50,"[of_get_sys_flight_pax] dw_pax   |class " + sClass + " nspml new: "+ String(lspml) + " old: "+String(dw_Pax.GetItemNumber(i,"npax_spml") ))
				wf_chc_trace(50,"[of_get_sys_flight_pax] dw_pax   |class " + sClass + " nstationentry new: "+ String(istation_entry) + " old: "+String(dw_Pax.GetItemNumber(i,"nstationentry") ))
				// ------------------------------------------------------------------------------------
				// $$HEX1$$dc00$$ENDHEX$$bernehmen der Pax--Daten und Version auf den aktuellen Flug
				// ------------------------------------------------------------------------------------
				dw_pax.setitem(i, "npax", lpax)
				dw_pax.setitem(i, "nstationentry", istation_entry)
				dw_pax.setitem(i, "npax_spml", lspml) // 10.11.2009 HR: SPML speichern
				
				if ii_fill_forecast=1 then
					// --------------------------------------------------------------------------------
					// 10.11.2009 HR: Forecastzahlen sollen gef$$HEX1$$fc00$$ENDHEX$$llt werden
					// --------------------------------------------------------------------------------
					wf_chc_trace(50,"[of_get_sys_flight_pax] dw_pax   |class " + sClass + " Pax and SPML werden auch in Forecast-Felder geschrieben")
					dw_pax.setitem(i, "npax_forecast", lpax)
					dw_pax.setitem(i, "npax_spml_forecast", lspml) 
				end if 
				
			elseif this.ifunction_pax_type = 2	then	// npax_airline
				wf_chc_trace(50,"[of_get_sys_flight_pax] dw_pax   |class " + sClass + " npax_airline new: "+ String(lpax) + " old: "+String(dw_Pax.GetItemNumber(i,"npax_airline") ))
				wf_chc_trace(50,"[of_get_sys_flight_pax] dw_pax   |class " + sClass + " nstationentry new: "+ String(istation_entry) + " old: "+String(dw_Pax.GetItemNumber(i,"nstationentry") ))
				// ------------------------------------------------------------------------------------
				// $$HEX1$$dc00$$ENDHEX$$bernehmen der Pax-Airline-Daten und Version auf den aktuellen Flug
				// ------------------------------------------------------------------------------------
				dw_pax.setitem(i, "npax_airline", lpax)
				dw_pax.setitem(i, "nstationentry", istation_entry)
				dw_pax.setitem(i, "npax_spml_airline", lspml) // 10.11.2009 HR: SPML speichern
			elseif this.ifunction_pax_type = 3	then 	// npax_system_final
				wf_chc_trace(50,"[of_get_sys_flight_pax] dw_pax   |class " + sClass + " npax_system new: "+ String(lpax) + " old: "+String(dw_Pax.GetItemNumber(i,"npax_system_final") ))
				wf_chc_trace(50,"[of_get_sys_flight_pax] dw_pax   |class " + sClass + " nstationentry new: "+ String(istation_entry) + " old: "+String(dw_Pax.GetItemNumber(i,"nstationentry") ))
				// ------------------------------------------------------------------------------------
				// $$HEX1$$dc00$$ENDHEX$$bernehmen der Pax-System-Daten und Version auf den aktuellen Flug
				// ------------------------------------------------------------------------------------
				dw_pax.setitem(i, "npax_system_final", lpax)
				dw_pax.setitem(i, "nstationentry", istation_entry)
			else
				wf_chc_trace(50,"[of_get_sys_flight_pax] unbekannter Pax-typ: " + String (this.ifunction_pax_type))
			end if
		else
			if this.ifunction_pax_type = 1 	then		// npax
				wf_chc_trace(50,"[of_get_sys_flight_pax] dw_pax   |class " + sClass + " kein neuer Eintrag  old: " + String(dw_Pax.GetItemNumber(i,"npax") ))
			elseif this.ifunction_pax_type = 2	then	// npax_airline
				wf_chc_trace(50,"[of_get_sys_flight_pax] dw_pax   |class " + sClass + " kein neuer Eintrag  old: " + String(dw_Pax.GetItemNumber(i,"npax_airline") ))
			elseif this.ifunction_pax_type = 3	then	// npax_system_final
				wf_chc_trace(50,"[of_get_sys_flight_pax] dw_pax   |class " + sClass + " kein neuer Eintrag  old: " + String(dw_Pax.GetItemNumber(i,"npax_system_final") ))
			else
				wf_chc_trace(50,"[of_get_sys_flight_pax] unbekannter Pax-typ: " + String (this.ifunction_pax_type))
			end if
		end if
	next
	
else
	wf_chc_trace(50,"[of_get_sys_flight_pax] keine Eintr$$HEX1$$e400$$ENDHEX$$ge in sys_queued_flight_pax vorhanden ")

end if

// --------------------------------------------------------------------------------------------------------------------
// 29.02.2016 HR:
// --------------------------------------------------------------------------------------------------------------------
if is_set <> 'none' and  this.ifunction_pax_type = 1 then
	of_recalc_pax_fc()	
end if

return 0

end function

public function integer of_get_sys_flight_actype (long ljobnr);// -----------------------------------------
// Ermittle neuen Aircraft-typ zu Jobnr 
//
// 	Return -1 	Fehler
//	Return 0		Keine Ver$$HEX1$$e400$$ENDHEX$$nderung an Aircraft/Registration
///	Return 1		Ver$$HEX1$$e400$$ENDHEX$$nderung an Aircraft/Registration
///	Return 2		Ver$$HEX1$$e400$$ENDHEX$$nderung an Registration
// -----------------------------------------
Long 					i, i2
Long					lFound, lReturn
Long					lResult_key, lResult_key2
Long					lpax
Long					lClass_number
Boolean			 	bStationentryFound 	= false
Integer				istatus_release, istatus, ichanged
Long					lFlight_number, lAirline_key, lAircraft_key_New, lAircraft_key_Old, lversion_group_key_New
Long					lAirline_owner_key_New, lAirline_owner_key_Old
String					sSuffix, sTLC_From, sText, sTextNew
Date					ddeparture2
String					sConfigurationTemp
String					sAirlineOwner_new, sACType_new, sGalleyversion_new, sConfiguration_new, sRegistration_new
String					sAirlineOwner_old, sACType_old, sGalleyversion_old, sConfiguration_old, sRegistration_old
str_actype 			strRet
uo_get_aircraft 	uoGetAircraft

istatus_release = dw_single.getitemnumber(dw_single.getrow(),"nstatus_release")
if isnull(istatus_release) then istatus_release = 0

istatus = dw_single.getitemnumber(dw_single.getrow(),"nstatus")
if isnull(istatus) then istatus = 0

if istatus_release > 0 then  // Freigabe hat bereits stattgefunden, verwende exist. Werte
	return 0
end if

// aktuelle Flugdaten ermitteln
lAirline_key 		= dw_single.getitemnumber(dw_single.getrow(),"nairline_key")
lflight_number 	= dw_single.getitemnumber(dw_single.getrow(),"nflight_number")
sSuffix 			= dw_single.getitemString(dw_single.getrow(),"csuffix")
sTLC_From 		= dw_single.getitemString(dw_single.getrow(),"ctlc_from")
ddeparture2 	= Date(dw_single.getitemdatetime(dw_single.getrow(),"ddeparture"))

dsSysQueueFlightACType.Retrieve(lJobnr)

if dsSysQueueFlightACType.RowCount() > 0 then
	lfound 						= 1
	sAirlineOwner_new 		= dsSysQueueFlightACType.GetItemString(lFound,"sys_queue_flight_actype_cacowner") 
	sACType_new 		  		= dsSysQueueFlightACType.GetItemString(lFound,"sys_queue_flight_actype_ctype") 
	sGalleyversion_new 		= dsSysQueueFlightACType.GetItemString(lFound,"sys_queue_flight_actype_cgalvers")
	sConfiguration_new 		= dsSysQueueFlightACType.GetItemString(lFound,"sys_queue_flight_actype_cconfiguration") 
	sRegistration_new   		= dsSysQueueFlightACType.GetItemString(lFound,"sys_queue_flight_actype_cregistration")  
	lAircraft_Key_New   		= dsSysQueueFlightACType.GetItemNumber(lFound,"sys_queue_flight_actype_naircraft_key")  
	lAirline_owner_key_new	= f_get_airline_key(sAirlineOwner_new)
	 
	sAirlineOwner_old 		= dw_single.getItemString(dw_single.getrow(),"cairline_owner")
	sACType_old 				= dw_single.getItemString(dw_single.getrow(),"cactype") 
	sGalleyversion_old 		= dw_single.getItemString(dw_single.getrow(),"cgalleyversion")
	sConfiguration_old 		= dw_single.getItemString(dw_single.getrow(),"cconfiguration")
	sRegistration_old			= dw_single.getItemString(dw_single.getrow(),"cregistration")
	lAircraft_key_old			= dw_single.getItemNumber(dw_single.getrow(),"naircraft_key")
	lAirline_owner_key_old	= dw_single.getItemNumber(dw_single.getrow(),"nairline_owner_key")
		
	if isNull(lAircraft_key_New) then
			
		uoGetAircraft = create uo_get_aircraft	
		
		uoGetAircraft.lAirline_key 	= lAirline_owner_key_new
		uoGetAircraft.sOwner 		= sAirlineOwner_new 
		uoGetAircraft.sActype 		= sACType_new 
		dsClasses.Retrieve(lAirline_owner_key_new)

		i2 									= 0
		sConfigurationTemp 			= sConfiguration_new
		if dsClasses.RowCount() > 0 then
			For i = 1 to dsClasses.RowCount()
				if dsClasses.getitemNumber(i, "nbooking_class") = 1 then
					i2++
					uoGetAircraft.sClass[i2] 				= dsClasses.getitemString(i, "cclass") 
					uoGetAircraft.iClassNumber[i2] 	= dsClasses.getitemNumber(i, "nclass_number") 
					uoGetAircraft.iVersion[i2] 			= of_configuration_to_number(sConfigurationTemp, i2)
				end if
			Next
		end if
			
		lReturn = uoGetAircraft.of_get_aircraft()
		if lReturn = -1 or uoGetAircraft.lAircraft_key = -1 then
			wf_chc_trace(50,"[of_get_sys_flight_actype] dw_single |Aircraft key not found for " + &
									string(lAirline_owner_key_new) + " " + sACType_new)
			
			of_log_jobstate(ii_log_warning, uf.translate("Aircraft key not found for ")+ sAirlineOwner_new+" "+sACType_new) // 12.03.2015 HR: Logging eingebaut
			
			destroy uoGetAircraft
			
			return -1
		end if
		lAircraft_key_new 				= uoGetAircraft.lAircraft_key
		lversion_group_key_New 	= uoGetAircraft.lGroup_key
		sGalleyversion_new 			= uoGetAircraft.sGalleyversion
		destroy uoGetAircraft
		
	else
		// Aircraft_key wurde $$HEX1$$fc00$$ENDHEX$$bergeben, anhand des Aircraft-Keys die Daten ermitteln
		// 02.09.2015 HR: Wir brauchen hier die Funktion etwas abge$$HEX1$$e400$$ENDHEX$$ndert
		strRet = of_get_actype_structure(lAircraft_key_New, sConfiguration_new)
		if strRet.lowner <> -1 then
			lAirline_owner_key_new		= strRet.lowner 
			sAirlineOwner_new 			= f_get_airline_name(lAirline_owner_key_new)
			sACType_new					= strRet.cactype
			sGalleyversion_new 			= strRet.cgalleyversion
			// nur wenn nicht gef$$HEX1$$fc00$$ENDHEX$$llt, Standard-Configuration nehmen
			if isNull(sConfiguration_new) then
				sConfiguration_new = strRet.cconfig
			end if
		else
			wf_chc_trace(50,"[of_get_sys_flight_actype] dw_single |Aircraft  key not found: " + string(lAircraft_key_New) + " " + strRet.cactype)

			of_log_jobstate(ii_log_warning, uf.translate("Aircraft key not found for ")+ sAirlineOwner_new+" "+sACType_new) // 12.03.2015 HR: Logging eingebaut
			
			return -1
		end if
	end if
	
	sText = "AirlOwner:"
	if isnull(sAirlineOwner_new) then
		sText += "(NULL)"
		sAirlineOwner_new = sAirlineOwner_old 
	else
		sText += sAIrlineOwner_new
	end if
	
	sText += " ACType:"
	if isnull(sACType_new) then
		sText += " (NULL)"
		sACType_new = sACType_old
	else
		sText += " " + sACType_new
	end if
	
	sText += " Galvers:"
	if isnull(sGalleyversion_new) then
		sText += " (NULL)"
		sGalleyversion_new = sGalleyversion_old
	else
		sText += " " + sGalleyversion_new
	end if
	
	sText += " Config:"
	if isnull(sConfiguration_new) then
		sText += " (NULL)"
		sConfiguration_new = sConfiguration_old
	else
		sText += " " + sConfiguration_new
	end if
	
	sText += " Registr:"
	if isnull(sRegistration_new) then
		sText += " (NULL)"
		sRegistration_new = sRegistration_old
	else
		sText += " " + sRegistration_new
	end if
	
	sText += " Aircraft_key:"
	if isnull(lAircraft_key_new) then
		sText += " (NULL)"
		lAircraft_key_new = lAircraft_key_old
	else
		sText += " " + string(lAircraft_key_new)
	end if
	
	sText += " Airl_owner_key:"
	if isnull(lAirline_owner_key_new) then
		sText += " (NULL)"
		lAirline_owner_key_new = lAirline_owner_key_old
	else
		sText += " " + String(lAirline_owner_key_new)
	end if

	sTextNew = sText
	
	sText = "AirlOwner:"

	if isnull(sAirlineOwner_old) then
		sText += "(NULL)"
	else
		sText += sAIrlineOwner_old
	end if
	
	sText += " ACType:"
		
	if isnull(sACType_old) then
		sText += " (NULL)"
	else
		sText += " " + sACType_old
	end if
	
	sText += " Galvers:"
	if isnull(sGalleyversion_old) then
		sText += " (NULL)"
	else
		sText += " " + sGalleyversion_old
	end if
	
	sText += " Config:"
	if isnull(sConfiguration_old) then
		sText += " (NULL)"
	else
		sText += " " + sConfiguration_old
	end if
	
	sText += " Registr:"
	if isnull(sRegistration_old) then
		sText += " (NULL)"
	else
		sText += " " + sRegistration_old
	end if
	
	sText += " Aircraft_key:"
	if isnull(lAircraft_key_old) then
		sText += " (NULL)"
	else
		sText += " " + string(lAircraft_key_old)
	end if
	sText += " Airl_owner_key:"
	if isnull(lAirline_owner_key_old) then
		sText += " (NULL)"
	else
		sText += " " + String(lAirline_owner_key_old)
	end if

	wf_chc_trace(50,"[of_get_sys_flight_actype] dw_single |Aircraft  new: " + sTextNew)
	wf_chc_trace(50,"[of_get_sys_flight_actype] dw_single |Aircraft  old: " + sText)
	
	 if  (sAirlineOwner_new <>sAirlineOwner_old ) or &
		(sACType_new <> sACType_old) or &
		(sGalleyversion_new <> sGalleyversion_old) or &
		(lAircraft_key_new<> lAircraft_key_old) or &
		(lAirline_owner_key_new <> lAirline_owner_key_old) or &
		(sGalleyversion_new <> sGalleyversion_old) or &
		(sConfiguration_new <> sConfiguration_old) then			
		
		dw_single.setitem(dw_single.getrow(),"cactype",sACType_new)
		dw_single.setitem(dw_single.getrow(),"cgalleyversion",sGalleyversion_new)
		dw_single.setitem(dw_single.getrow(),"cconfiguration",sConfiguration_new)
		dw_single.setitem(dw_single.getrow(),"cairline_owner",sAirlineOwner_new)
		dw_single.setitem(dw_single.getrow(),"cregistration",sRegistration_new)
		dw_single.setitem(dw_single.getrow(),"naircraft_key",lAircraft_key_new)
		dw_single.setitem(dw_single.getrow(),"nairline_owner_key",lAirline_owner_key_new)
		wf_chc_trace(50,"[of_get_sys_flight_actype] dw_single |Aircraft changed " )

		// --------------------------------------------------------------------------------------------------------------------
		// 11.03.2015 HR: Wir m$$HEX1$$fc00$$ENDHEX$$ssen die Konfiguration auch in die Pax-Tabelle schreiben
		// --------------------------------------------------------------------------------------------------------------------
		string ls[]
		integer li_row
		f_string_to_array(sConfiguration_new, "-", ls)
		for li_row=1 to upperbound(ls)
			dw_pax.SetItem(li_row,"nversion", long(ls[li_row]))
		next		

		lreturn = 1

		of_log_jobstate(ii_log_info, uf.translate("Aircraftchange durchgef$$HEX1$$fc00$$ENDHEX$$hrt")) // 12.03.2015 HR: Logging eingebaut

	elseif	(isnull(sRegistration_old) and not isnull(sRegistration_new) ) or &
			(sRegistration_new <> sRegistration_old) then
		  	
			dw_single.setitem(dw_single.getrow(),"cregistration",sRegistration_new)
			wf_chc_trace(50,"[of_get_sys_flight_actype] dw_single |Registration changed " )
			
			of_log_jobstate(ii_log_info, uf.translate("Registration ge$$HEX1$$e400$$ENDHEX$$ndert"))
		  	
			lreturn = 2
	else
		  wf_chc_trace(50,"[of_get_sys_flight_actype] dw_single |Aircraft/Registr. unchanged" )
	end if		
end if		

return lreturn

end function

public function integer of_get_sys_flight_spml (long ljobnr);// -----------------------------------------
// Ermittle neue SPMLs zu Jobnr 
// und f$$HEX1$$fc00$$ENDHEX$$ge diese in dw_spml ein
// -----------------------------------------
Long 		i, lgeaendert
Long		lFound, lFound2
Long		lResult_key, lResult_key2
Long		lquantityOld, lquantityNew
Long		lClass_number, lSpml_key, lTopoffNew, lTopoffOld
Boolean 	bStationentryFound = false
Integer	istatus_release, istatus, istationentry
Long		lAirline_key, ltransaction, lSequence
String		sClass, sSpml, sName, sRemark, sAdd_text
String		sNameNew, sRemarkNew, sAdd_textNew, sSeat, sSeat_New
String		sSearch, sSearch2, sTraceTextold, sTraceTextNew, sTopoff
Date		ddeparture2

istatus_release = dw_single.getitemnumber(dw_single.getrow(),"nstatus_release")
if isnull(istatus_release) then istatus_release = 0

istatus = dw_single.getitemnumber(dw_single.getrow(),"nstatus")
if isnull(istatus) then istatus = 0

if istatus_release > 0 then  // Freigabe hat bereits stattgefunden, verwende exist. Werte
	return 0
end if

// aktuelle Flugdaten ermitteln
lAirline_key = dw_single.getitemnumber(dw_single.getrow(),"nairline_key")
lResult_key = dw_single.getitemnumber(dw_single.getrow(),"nresult_key")
ltransaction = dw_single.getitemnumber(dw_single.getrow(),"ntransaction")

istationentry= this.istation_entry
		
dsSysQueueFlightSpml.Retrieve(lJobnr)
if dsSysQueueFlightSpml.RowCount() > 0 then
	// ------------------------------------------------------------------------------------
	// alle Zeilen der bisherigen Eintr$$HEX1$$e400$$ENDHEX$$ge durchgehen und auf $$HEX1$$c400$$ENDHEX$$nderungen pr$$HEX1$$fc00$$ENDHEX$$fen
	// ------------------------------------------------------------------------------------
	for i = 1 to  dw_spml.RowCount() 
		lgeaendert 	= 0
		sClass 		= dw_spml.getItemString(i,"cclass")
		sSpml 		= dw_spml.getItemString(i,"cspml")
		sName 		= dw_spml.getItemString(i,"cname")
		sRemark 		= dw_spml.getItemString(i,"cremark")
		sAdd_Text 	= dw_spml.getItemString(i,"cadd_text")
		lquantityOld	= dw_spml.getItemNumber(i,"nquantity")
		ltopoffOld 	= dw_spml.getItemNumber(i,"ntopoff")
		sSeat			= dw_spml.getItemString(i,"cseat")			// 08.06.2011 HR:
		
		if isnull(sSeat) then sSeat = "(Null)"							// 08.06.2011 HR:
		if isnull(sName) then sName = "(Null)"
		if isnull(sRemark) then sRemark = "(Null)"
		if isnull(sAdd_Text ) then sAdd_Text  = "(Null)"
		if isnull(ltopoffOld) then 
			sTopoff = "(Null)"
		else
			sTopoff = String(lTopOffOld)
		end if
		sTraceTextOld = "old: class " + sClass + " cspml "+sSpml + " nquantity " + String(lquantityOld) + &
								" cname " + Sname + " cremark " + sRemark + " cadd_text " + sAdd_Text + " ntopoff " + sTopoff+ " sSeat "+sSeat
		
		sSearch = "sys_queue_flight_spml_cclass = '" + sClass + &
		                    "' and sys_queue_flight_spml_cspml = '" + sSpml + "'"
		sSearch2 = sSearch
		// ------------------------------------------------------------------------------------
		// vorrangige Suche mit Klasse, Spml, Name
		// ------------------------------------------------------------------------------------
		if not isNull(sName) then
			sSearch2 += " and sys_queue_flight_spml_cname = '" + sName + "'"
			lFound = dsSysQueueFlightSpml.Find(sSearch2, 1, dsSysQueueFlightSpml.RowCount())
		end if

		if lFound = 0 then
			// ------------------------------------------------------------------------------------
			// nachrangige Suche mit Klasse, Spml (nimmt dann den ersten)
			// ------------------------------------------------------------------------------------
			lFound = dsSysQueueFlightSpml.Find(sSearch, 1, dsSysQueueFlightSpml.RowCount())
		end if
				
		if lFound > 0 then 
			// ------------------------------------------------------------------------------------
			// SPML in neuer Tabelle gefunden, ggf. $$HEX1$$c400$$ENDHEX$$nderung $$HEX1$$fc00$$ENDHEX$$bernehmen
			// ------------------------------------------------------------------------------------
			sNameNew 		= dsSysQueueFlightSpml.getitemString(lfound,"sys_queue_flight_spml_cname")
			sRemarkNew 	= dsSysQueueFlightSpml.getitemString(lfound,"sys_queue_flight_spml_cremark")
			sAdd_TextNew 	= dsSysQueueFlightSpml.getitemString(lfound,"sys_queue_flight_spml_cadd_text")
			sSeat_New		= dsSysQueueFlightSpml.getItemString(lfound,"sys_queue_flight_spml_cseat")			// 08.06.2011 HR:
			if isnull(sSeat_New) then sSeat_New = "(Null)"																		// 08.06.2011 HR:
			if isnull(sNameNew) then sNameNew = "(Null)"
			if isnull(sRemarkNew) then sRemarkNew = "(Null)"
			if isnull(sAdd_TextNew ) then sAdd_TextNew  = "(Null)"
			if sNameNew <> sName then 
				dw_spml.setitem(i,"cname",dsSysQueueFlightSpml.getitemString(lfound,"sys_queue_flight_spml_cname"))
				lgeaendert = 1
			end if
			if sRemarkNew <> sRemark then 
				dw_spml.setitem(i,"cremark",dsSysQueueFlightSpml.getitemString(lfound,"sys_queue_flight_spml_cremark"))
				lgeaendert = 1
			end if
			if sAdd_TextNew <> sAdd_Text then 
				dw_spml.setitem(i,"cadd_text",dsSysQueueFlightSpml.getitemString(lfound,"sys_queue_flight_spml_cadd_text"))
				lgeaendert = 1
			end if
			
			// --------------------------------------------------------------------------------------------------------------------
			// 08.06.2011 HR:
			// --------------------------------------------------------------------------------------------------------------------
			if sSeat <> sSeat_New then 
				dw_spml.setitem(i,"cseat",dsSysQueueFlightSpml.getitemString(lfound,"sys_queue_flight_spml_cseat"))
				lgeaendert = 1
			end if
			
			lquantityNew = dsSysQueueFlightSpml.getitemNumber(lfound,"sys_queue_flight_spml_nquantity")
			lTopoffNew = dsSysQueueFlightSpml.getitemNumber(lfound,"sys_queue_flight_spml_ntopoff")
			
			if not isnull(lTopOffNew) then
				if lTopoffNew > 1 then
					wf_chc_trace(50,"[of_get_sys_flight_spml] dw_spml   |topoff ung$$HEX1$$fc00$$ENDHEX$$ltig -> auf 1 ge$$HEX1$$e400$$ENDHEX$$ndert von "+string(ltopoffNew) )
					lTopoffNew = 1
				end if
				dw_spml.setitem(i,"ntopoff",ltopoffNew)
				sTopoff = String(ltopoffNew)
			end if
	
			if isnull(lquantityNew) then lquantityNew = 1
			if lquantityNew <> lquantityOld then	
				dw_spml.setitem(i,"nquantity_old",lquantityOld )
				dw_spml.setitem(i,"nquantity",lquantityNew )
				lgeaendert = 1
			else
				dw_spml.setitem(i,"nquantity_old",lquantityOld )
			end if
			
			sClass = dw_spml.getItemString(i,"cclass") 
			sSpml = dw_spml.getItemString(i,"cspml") 
					
			sTraceTextNew = "new: class " + sClass + " cspml "+sSpml + " nquantity " + String(lquantityNew) + &
								" cname " + sNameNew + " cremark " + sRemarkNew + " cadd_text " + sAdd_TextNew + &
								" ntopoff " + sTopoff + " sSeat "+sSeat_New
								
			if lgeaendert = 1 then
				wf_chc_trace(50,"[of_get_sys_flight_spml] dw_spml   |" + sTraceTextOld )
				wf_chc_trace(50,"[of_get_sys_flight_spml] dw_spml   |" + sTraceTextNew + " >>> ge$$HEX1$$e400$$ENDHEX$$ndert")
			end if
			// ------------------------------------------------------------------------------------
			// den Satz rausnehmen, da verarbeitet
			// ------------------------------------------------------------------------------------
			dsSysQueueFlightSpml.deleteRow(lFound)
			
		else 
			// ------------------------------------------------------------------------------------
			// Satz nicht gefunden, l$$HEX1$$f600$$ENDHEX$$schen
			// ------------------------------------------------------------------------------------
			dw_spml.setitem(i,"cspml","l$$HEX1$$f600$$ENDHEX$$sch")
			wf_chc_trace(50,"[of_get_sys_flight_spml] dw_spml   |" + sTraceTextOld + " >>> wird gel$$HEX1$$f600$$ENDHEX$$scht")

		end if
			
	next
	// ------------------------------------------------------------------------------------
	// $$HEX1$$fc00$$ENDHEX$$berz$$HEX1$$e400$$ENDHEX$$hlige Zeilen l$$HEX1$$f600$$ENDHEX$$schen
	// ------------------------------------------------------------------------------------
	// 11.11.2009 HR:L$$HEX1$$f600$$ENDHEX$$schreihenfolge ge$$HEX1$$e400$$ENDHEX$$ndert
	for i =  dw_spml.RowCount() to 1 step -1 	
		if dw_spml.getItemString(i,"cspml") = "l$$HEX1$$f600$$ENDHEX$$sch" then
			dw_Spml.deleteRow(i)
		end if
	Next
	// ------------------------------------------------------------------------------------
	// noch nicht verarbeitete $$HEX1$$c400$$ENDHEX$$nderungss$$HEX1$$e400$$ENDHEX$$tze neu aufnehmen
	// ------------------------------------------------------------------------------------
	for lfound = 1 to  dsSysQueueFlightSpml.RowCount() 	
		
		sClass = dsSysQueueFlightSpml.getitemString(lfound,"sys_queue_flight_spml_cclass")
		sSpml = dsSysQueueFlightSpml.getitemString(lfound,"sys_queue_flight_spml_cspml")
		lquantityNew = dsSysQueueFlightSpml.getitemNumber(lfound,"sys_queue_flight_spml_nquantity")
		// ------------------------------------------------------------------------------------
		// Default-Menge ist 1
		// ------------------------------------------------------------------------------------
		if isnull(lquantityNew) then lquantityNew = 1
		lClass_number = f_get_class_key(sClass,lAirline_key)
		lSpml_key = f_get_spml_key(sSpml,lAirline_key)
		// ------------------------------------------------------------------------------------
		// die wichtigsten Felder m$$HEX1$$fc00$$ENDHEX$$ssen gef$$HEX1$$fc00$$ENDHEX$$llt und f$$HEX1$$fc00$$ENDHEX$$r die Airline zul$$HEX1$$e400$$ENDHEX$$ssig sein
		// ------------------------------------------------------------------------------------
		if 	not isNull(sClass) & 
			and not isNull(sSpml) & 
			and not isNull(lquantityNew) & 
			and lClass_number > 0 & 
			and lSpml_key > 0 then
		
			i=dw_Spml.InsertRow(0)
			
			if i > 0 then
				
				lSequence = f_Sequence("seq_cen_out_spml", sqlca)
				// -----------------------------------------
				// liefert -1 bei Fehler
				// -----------------------------------------
			end if
			If lSequence <> -1 and &
			    i > 0 then
				// -----------------------------------------
				// Felder setzen
				// -----------------------------------------
				dw_spml.setitem(i,"cname",dsSysQueueFlightSpml.getitemString(lfound,"sys_queue_flight_spml_cname"))
				dw_spml.setitem(i,"cremark",dsSysQueueFlightSpml.getitemString(lfound,"sys_queue_flight_spml_cremark"))
				dw_spml.setitem(i,"cadd_text",dsSysQueueFlightSpml.getitemString(lfound,"sys_queue_flight_spml_cadd_text"))
				dw_spml.setitem(i,"cseat",dsSysQueueFlightSpml.getitemString(lfound,"sys_queue_flight_spml_cseat"))			// 08.06.2011 HR:
				dw_spml.setitem(i,"nquantity",lquantitynew)
				dw_spml.setitem(i,"cclass",sClass)
				dw_spml.setitem(i,"cspml",sSpml)
				dw_spml.setitem(i,"nclass_number",lClass_number)
				dw_spml.setitem(i,"nspml_key",lSpml_key)
				dw_spml.setitem(i,"nclass_number",lClass_number)
				dw_spml.setitem(i,"ntransaction",ltransaction)
				dw_spml.setitem(i,"nresult_key",lResult_key)
				dw_spml.setitem(i,"nquantity_old",0)
				dw_spml.setitem(i,"nmanual_input",1) // 04.12.2013 HR: $$HEX1$$dc00$$ENDHEX$$bernahme aus CBASE
				dw_spml.setitem(i,"nstatus",istatus)
				dw_spml.setitem(i,"ndeduction",1)
				dw_spml.SetItem(i,"status_nquantity",	1)		
				lTopoffNew = dsSysQueueFlightSpml.getitemNumber(lfound,"sys_queue_flight_spml_ntopoff")
				if not isnull(lTopOffNew) then
					if lTopoffNew > 1 then
						wf_chc_trace(50,"[of_get_sys_flight_spml] dw_spml   |topoff ung$$HEX1$$fc00$$ENDHEX$$ltig -> auf 1 ge$$HEX1$$e400$$ENDHEX$$ndert von "+string(ltopoffNew) )
						lTopoffNew = 1
					end if
					dw_spml.setitem(i,"ntopoff",ltopoffNew)
					sTopoff = String(ltopoffNew)
				else
					sTopoff = "(Null)"
				end if
				
				dw_spml.setitem(i,"nstationentry",istationentry)
				dw_spml.setitem(i,"nmaster_key",lsequence)
				
				sName = dw_spml.getItemString(i,"cname")
				if isnull(sName) then sName = "(Null)"
				sRemark = dw_spml.getItemString(i,"cremark")
				if isnull(sRemark) then sRemark = "(Null)"
				sAdd_Text = dw_spml.getItemString(i,"cadd_text")
				if isnull(sAdd_Text ) then sAdd_Text  = "(Null)"
				sSeat			= dw_spml.getItemString(i,"cseat")			// 08.06.2011 HR:
				if isnull(sSeat) then sSeat = "(Null)"							// 08.06.2011 HR:

				sTraceTextNew = "new: class " + sClass + " cspml "+sSpml + " nquantity " + String(lquantityNew) + &
								" cname " + Sname + " cremark " + sRemark + " cadd_text " + sAdd_Text + " ntopoff " + sTopoff+ " sSeat "+sSeat
				wf_chc_trace(50,"[of_get_sys_flight_spml] dw_spml   |" + sTraceTextNew + " >>> eingef$$HEX1$$fc00$$ENDHEX$$gt")
			else
				if i = 0 then
					wf_chc_trace(50,"[of_get_sys_flight_spml] dw_spml   | Fehler insert row" +" class " + sClass + " cspml "+sSpml + " nquantity " + String(lquantityNew) + " >>> Satz nicht verarbeitet !!!")
				else
					wf_chc_trace(50,"[of_get_sys_flight_spml] dw_spml   | Fehler sequence seq_cen_out_spml " +" class " + sClass + " cspml "+sSpml + " nquantity " + String(lquantityNew) + " >>> Satz nicht verarbeitet !!! ")
				end if
			    f_Log2Csv(0,2,"[of_get_sys_flight_spml] fehlerhafte bei insert/sequence in dw_spml" + " class " + sClass + " cspml "+sSpml + " nquantity " + String(lquantityNew)  + " >>>  Satz nicht verarbeitet !!!")
				
					
			end if
		else
			if isnull(sclass) then sclass = "(Null)"
			if isnull(sSpml) then sSpml = "(Null)"
			wf_chc_trace(50,"[of_get_sys_flight_spml] dsSysQueueFlightSpml| fehlerhafte Schl$$HEX1$$fc00$$ENDHEX$$ssels$$HEX1$$e400$$ENDHEX$$tze" + " class " + sClass + " cspml "+sSpml + " nquantity " + String(lquantityNew)  + " >>>  Satz nicht verarbeitet !!!")
			f_Log2Csv(0,2,"[of_get_sys_flight_spml] fehlerhafte Schl$$HEX1$$fc00$$ENDHEX$$ssels$$HEX1$$e400$$ENDHEX$$tze" + " class " + sClass + " cspml "+sSpml + " nquantity " + String(lquantityNew)  + " >>>  Satz nicht verarbeitet !!!")
		end if
	Next
	// ------------------------------------------------------------------------------------
	// nprio neu vergeben
	// ------------------------------------------------------------------------------------
	dw_spml.Sort()
	for i = 1 to  dw_spml.RowCount() 	
		dw_spml.SetItem(i,"nprio",i)
		
	Next
end if


return 0

end function

public function integer of_retrieve_dsjobs (datetime ddate);/* 
* Funktion:			of_retrieve_dsjobs
* Beschreibung: 	 Einstiegsfunktion
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 		Wer				Wann				Was und warum
*	
*
* Return Codes:
*	 -1		fehler
* 	1		sonst
*
*/

// -----------------------------------------------
//
// Einstiegsfunktion
// von hier aus alle Pr$$HEX1$$fc00$$ENDHEX$$fungen ausf$$HEX1$$fc00$$ENDHEX$$hren
//
// -----------------------------------------------
Long 		lRows, lRow, lRow2
Long		lStatus[]
String		sFlight
Long 		lStart, lStop, lSequence, lqueued_release_interface, lstation_entry
Integer  	iSuccess
Integer 	iRet, i ,i1,i2, icount
Integer 	iFunction
DateTime dtNull, dtNow
Long		lNull, lfound
String		sNull, sRunning 

// --------------------------------------------------------------------------------------------------------------------
// 19.03.2014 HR: Wieder das alte DW zuweisen, damit der Aufruf aus dem Screen weiter funktioniert
// --------------------------------------------------------------------------------------------------------------------
dsJobs.DataObject 							= "dw_job_list_new"
dsJobs.settransobject(SQLCA)


setNull(dtNull)
setNull(sNull)
setNull(lNull)

//dw_job_instances

/* Funktionen:
1: Alles rechnen in Abh. der Zusatz-Tabellen (PAX/SPML/ACTYPE)
2: Web-Anstoss $$HEX1$$fc00$$ENDHEX$$ber nqueued_release_interface = 4 (Mit History)
3: Web-Anstoss mit Aircraft-Change $$HEX1$$fc00$$ENDHEX$$ber nqueued_release_interface = 5 (Mit History)
4: SPML-AMOS $$HEX1$$fc00$$ENDHEX$$ber nqueued_release_interface = 7 (Mit History)
5: rechnen automat. Abrechn. ??? 
6: LCL-Flug, Alles rechnen in Abh. der Zusatz-Tabellen (PAX/SPML/ACTYPE)

*/  

// ---------------------------------------------
// Nachschaun, ob wir arbeiten k$$HEX1$$f600$$ENDHEX$$nnen oder
// ob gerade eine andere Instanz am 
// machen ist
// ---------------------------------------------
if this.of_lock() = -1 then
	sRunning = ProfileString(sProfile, "PARAMETERS", "Instance", "N/A")
	f_Log2Csv(0,1,"[of_retrieve_dsjobs] Can't start: " + sRunning + " is working!!!")
	return -1
end if 

// -------------------------------------------------
// Einlesen der m$$HEX1$$f600$$ENDHEX$$glichen Funktionen und Zuordnung zur internen Verarbeitung
// -------------------------------------------------
dsSysQueueFunctions.retrieve()
if dsSysQueueFunctions.RowCount() <= 0 then
		// -------------------------------------------------
		// keine S$$HEX1$$e400$$ENDHEX$$tze vorhanden: Meldung ausgeben und Abbruch
		// -------------------------------------------------
		
		f_log2csv(0,2,"no functions in sys_queue_fl_functions found, no processing possible" )
		return -1
end if
	
dtNow = datetime(date(today()),time(now()))

// -------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fe ob S$$HEX1$$e400$$ENDHEX$$tze $$HEX1$$fc00$$ENDHEX$$ber cen_out_nqueued_release_interface zur Verarbeitung anstehen:
//   ggf. Eintrag in sys_queue_flight_calc zur zentralen Abarbeitung
// -------------------------------------------------
if 	this.bRead_cen_out then
	// -----------------------------------------------
	// Jobliste retrieven in Abh. von Datum und zugelassenen Funktionen
	// -----------------------------------------------
	this.dCheckDate = dDate	
	if upperbound( this.iProcessFunction[]) = 0 then 
		// -----------------------------------------------
		// Bei-1 wird keine Einschr$$HEX1$$e400$$ENDHEX$$nkung auf Funktion gemacht
		// -----------------------------------------------
		this.iProcessFunction[1] = -1
	end if
	
	this.dsJobs.Retrieve(this.iProcessFunction, sInstance)
	i = 1
	For I1 = 1 to  dsSysQueueFunctions.RowCount() 
		// -------------------------------------------------
		// Relevant sind nur Eintr$$HEX1$$e400$$ENDHEX$$ge mit interner Funktion 2
		// -------------------------------------------------
		if dsSysQueueFunctions.getItemNumber(I1, "ninternal_function") = 2 then
			lqueued_release_interface = dsSysQueueFunctions.getItemNumber(I1, "nqueued_release_interface")
			ifunction = dsSysQueueFunctions.getItemNumber(I1, "nfunction")
			lfound =0
			// -------------------------------------------------
			// Pr$$HEX1$$fc00$$ENDHEX$$fe ob Funktion hier ausgef$$HEX1$$fc00$$ENDHEX$$hrt werden soll.
			// gibt es keine Einschr$$HEX1$$e400$$ENDHEX$$nkung, werden alle m$$HEX1$$f600$$ENDHEX$$glichen Funktionen verarbeitet
			// -------------------------------------------------
			if upperbound( this.iProcessFunction[]) = 0 then 
				lfound = 1
			else
			
				For I2 = 1 to Upperbound(this.iProcessFunction)	
					if this.iProcessFunction[i2] = ifunction then
						lfound = 1
						exit
					end if
				Next
			end if
			if lfound = 1 and not isnull(lqueued_release_interface) then
				// -------------------------------------------------
				// in lStatus werden nqueued_release_interface - Werte abgelegt
				// -------------------------------------------------
		
				lStatus[i] = lqueued_release_interface
				i++
			end if
		end if
	Next
	
	if upperbound(lstatus) > 0 then
		// -------------------------------------------------
		// Einlesen aller CenOut-S$$HEX1$$e400$$ENDHEX$$tze zu Status
		// -------------------------------------------------	
		dsCenOut.Retrieve(lstatus[])
	
		lRows = dsCenOut.RowCount()
		for lrow = 1 to lrows
			// -------------------------------------------------
			// Pr$$HEX1$$fc00$$ENDHEX$$fe ob nresult_key bereits zur Abarbeitung ansteht
			// wenn ja, keine Aktion, sonst einf$$HEX1$$fc00$$ENDHEX$$gen
			// -------------------------------------------------
			lfound = dsJobs.Find("nresult_key = " + String(dsCenOut.GetItemNumber(lrow,"nresult_key")) + & 
						" and nfunction = " + String(ifunction) ,1,dsJobs.RowCount())
			if lfound = 0 then
				// -------------------------------------------------
				// Eintrag in sys_queue_flight_calc einf$$HEX1$$fc00$$ENDHEX$$gen
				// -------------------------------------------------
			
				lSequence = f_Sequence("seq_sys_queue_flight_calc", sqlca)
				If lSequence = -1 Then
					f_log2csv(0,2,"[of_retrieve_dsjobs] Sequence Error: seq_sys_queue_flight_calc")
				else
					lrow2=dsSysQueueFlightCalc.insertRow(0)
					dsSysQueueFlightCalc.SetItem(lrow2,"njob_nr",lsequence)
					dsSysQueueFlightCalc.SetItem(lrow2,"nresult_key",dsCenOut.GetItemNumber(lrow,"nresult_key"))
					dsSysQueueFlightCalc.SetItem(lrow2,"ddeparture",dsCenOut.GetItemDatetime(lrow,"ddeparture"))
					dsSysQueueFlightCalc.SetItem(lrow2,"dcreated",dtNow) 		
				//	dsSysQueueFlightCalc.SetItem(lrow2,"dstart_computing",dtNull)
				//	dsSysQueueFlightCalc.SetItem(lrow2,"dstop_computing",dtNull)
					dsSysQueueFlightCalc.SetItem(lrow2,"nstatus",lNull)
					dsSysQueueFlightCalc.setitem(1,"nprocess_status",0)    //28.11.2011 HR:
					
		
					lqueued_release_interface = dsCenOut.GetItemNumber(lrow,"nqueued_release_interface") 
					
					lfound =  dsSysQueueFunctions.find("nqueued_release_interface = " + String(lqueued_release_interface), 1, &
								dsSysQueueFunctions.RowCount())
								
					if lfound > 0 then
						ifunction = dsSysQueueFunctions.getItemNumber(lfound, "nfunction")
					else
						ifunction = 0
					end if
					
		 			dsSysQueueFlightCalc.SetItem(lrow2,"nfunction",ifunction)
					dsSysQueueFlightCalc.SetItem(lrow2,"nerror",lNull)
					dsSysQueueFlightCalc.SetItem(lrow2,"cerror",sNull)
					dsSysQueueFlightCalc.SetItem(lrow2,"cinstance",sNull)
					dsSysQueueFlightCalc.SetItem(lrow2,"cmodified",sNull)
					dsSysQueueFlightCalc.SetItem(lrow2,"cuser",sNull)
					dsSysQueueFlightCalc.SetItem(lrow2,"nqueued_release_interface",0)
					dsSysQueueFlightCalc.SetItem(lrow2,"nhistory",lNull)

					dw_pax.retrieve(dsCenOut.GetItemNumber(lrow,"nresult_key"))
					lstation_entry = 0
					if dw_pax.RowCount() > 0 then
						lstation_entry = dw_pax.GetItemNumber(1,"nstationentry") 
					end if

					dsSysQueueFlightCalc.SetItem(lrow2,"nstation_entry", lstation_entry)
		
					sFlight = dsCenOut.GetItemString(lrow, "cairline") +  String(dsCenOut.GetItemnumber(lrow, "nflight_number")) + &
					dsCenOut.GetItemString(lrow, "csuffix") + " vom " + String(dsCenout.GetItemDatetime(lrow, "ddeparture"),"DD.MM.YYYY" ) + &
						" / " + dsCenOut.GetItemString(lrow, "cunit") + "(" + String(dsCenOut.GetItemNumber(lrow, "nresult_key")) + ")" 
   	
					f_log2csv(0,2,"[of_retrieve_dsjobs] Insert into sys_queue_flight_calc job_id "  + string(lsequence) + "nfunction " + &
						String(ifunction) + " Flug " + sFlight + " (cen_out_nqueued_release_interface= " + String(lqueued_release_interface) +")")
				
				end if
		
			end if
		Next
		if lRows > 0 then
			If dsSysQueueFlightCalc.Update() <> 1 Then
				rollback ;
				f_log2csv(0,2,"[of_retrieve_dsjobs] Fehler beim Speichern in sys_queue_flight_calc aus cen_out  ")
			else
				f_log2csv(0,1,"[of_retrieve_dsjobs] Erfolgreiches Einf$$HEX1$$fc00$$ENDHEX$$gen in sys_queue_flight_calc job_id aus cen_out (" + String(lrows) + " S$$HEX1$$e400$$ENDHEX$$tze)" )	

			end if	
		else
			f_log2csv(0,1,"[of_retrieve_dsjobs] keine Daten in cen_out relevant  ")	
		end if
		commit;
	end if	
end if

// -----------------------------------------------
// Jobliste retrieven in Abh. von Datum und zugelassenen Funktionen
// -----------------------------------------------
this.dCheckDate = dDate	
if upperbound( this.iProcessFunction[]) = 0 then 
	// -----------------------------------------------
	// Bei-1 wird keine Einschr$$HEX1$$e400$$ENDHEX$$nkung auf Funktion gemacht
	// -----------------------------------------------
	this.iProcessFunction[1] = -1
end if
	
this.dsJobs.Retrieve( this.iProcessFunction, sInstance) // 28.11.2011 HR:

// -----------------------------------------------
// die ersten x (profile_Einstellung) S$$HEX1$$e400$$ENDHEX$$tze f$$HEX1$$fc00$$ENDHEX$$r diese Instanz markieren
// und mit einem Startdatum versehen, abspeichern und anschliessend abarbeiten
// -----------------------------------------------
if this.dsJobs.RowCount()>0 then
	iCount = dsJobs.GetItemNumber(1, "comp_bereitszugeordnet")
end if

if iCount < iNumberOfCalculationsToProcess then

	For i = 1 to dsjobs.RowCount()
		if dsJobs.GetItemNumber(i, "nprocess_status") = 1 then continue
	
		if dsJobs.GetItemNumber(i, "nfunction") <> 10 and ii_use_mzvspawn <> 1 then dsJobs.SetItem(i,"dstart_computing", dtNow) // 08.05.2013 HR: bei 10 wird das Datum beim Externen Programmstart gesetzt
		
		dsJobs.SetItem(i,"cinstance", sInstance )
		dsJobs.SetItem(i,"nprocess_status",1) // 28.11.2011 HR:
		
		// ------------------------------------------
		// nur soviele abstempeln, wie $$HEX1$$fc00$$ENDHEX$$ber das
		// Profile parametriert sind
		// ------------------------------------------
		iCount ++
		if iCount >= iNumberOfCalculationsToProcess then exit
	Next
end if
// -----------------------------------------------------------------
// Erst stempeln, dann speichern
// -----------------------------------------------------------------
If dsJobs.update() <> 1 Then
	rollback ;
	f_Log2Csv(this.ilJobNr,3,"[of_retrieve_dsjobs] Couldn't save stamped records")
	//	destroy	dsExplosion		
	this.of_unlock()
	Return -1
else
	Commit;
	this.of_unlock()
	
	f_Log2Csv(this.ilJobNr,1,"[of_retrieve_dsjobs] Stamped "+string(iCount)+" of "+string(dsjobs.RowCount())+" Rows")
	
	return 1
End if

end function

public function integer of_lock ();String 	sLock
String 	sTime
Long		lSecondsAfter
Time 		tNow

// -----------------------------------------------------------
// Pameter lesen
// -----------------------------------------------------------
sLock = ProfileString(sProfile, "PARAMETERS", "Locked", "1")
sTime = ProfileString(sProfile, "PARAMETERS", "TimeStamp", string(now()))

tNow = Now()

lSecondsAfter = SecondsAfter(Time(sTime), tNow)

// -----------------------------------------------------------
// Timestamp pr$$HEX1$$fc00$$ENDHEX$$fen:
// Ist der Zeitstempel $$HEX1$$e400$$ENDHEX$$lter als 60 Sekunden oder
// wird ein negativer Wert ermittelt (Datumswechsel) dann
// wird auf jeden Fall weitergemacht.
// -----------------------------------------------------------
if sLock = "1" and (lSecondsAfter < 0 or lSecondsAfter > il_maxlock ) then
	f_Log2Csv(0,0,"[of_lock] Lock value for more then: " + string(lSecondsAfter) + " not refreshed!")
	f_Log2Csv(0,0,"[of_lock] Lock value resetted (time1 = " + string(time(sTime)) + " time2 = " + string(tNow)+ ")")
	sLock = "0"
end if

// -----------------------------------------------------------
// Es steht ne 1 drin, also ist gerade eine andere Instanz 
// am arbeiten
// -----------------------------------------------------------
if sLock = "1" then
	return -1
end if

// -----------------------------------------------------------
// Keiner ist am arbeiten, also Schalter setzen
// -----------------------------------------------------------
if sLock = "0" then
	SetProfileString(sProfile, "PARAMETERS", "TimeStamp", String(Now(), "hh:mm:ss"))
	SetProfileString(sProfile, "PARAMETERS", "Instance", sInstance)
	SetProfileString(sProfile, "PARAMETERS", "Locked", "1")
	return 0
else
	f_Log2Csv(0,0,"[of_lock] Unknown return value : " + sLock)
	return -1
end if

Return 0

end function

public function integer of_unlock ();SetProfileString(sProfile, "PARAMETERS", "Locked", "0")

return 0
end function

public function integer of_configuration_to_number (string stext, integer ino);// Ermittelt die iNo. Zahl aus einem mit -/oder blank getrenntem String
Integer i,iret 
long	l

String sSearch, sNumber

sSearch = sText
For i = 1 to iNo 
	
	If pos(sText,"-",1) > 0 then  // mit - getrennte Felder
		sSearch = "-"
	elseif  pos(sText,"/",1) > 0 then  // mit / getrennte Felder
		sSearch = "/"
	elseif  pos(sText," ",1) > 0 then  // mit blank getrennte Felder	
		sSearch = " "
	end if
	l =  pos(sText,sSearch,1)
	if l > 0 then
		sNumber = mid(sText, 1, l - 1)
		sText = mid(sText, l +1,len(sText))
	else
		sNumber = sText
	end if
Next
	
if isNumber(sNumber) then
	iret = Integer(sNumber)
end if


return iret

	
end function

public function integer of_search_sys_queue_function (integer ifunction);// --------------------------------------------------------------------------------
// Objekt : uo_flight_calculation
// Methode: of_search_sys_queue_function (Function)
// Autor  : Thomas Leutner
// --------------------------------------------------------------------------------
// Argument(e): ifunction     Funktion zu der die Einstellungen ermittelt werden sollen
// 
// --------------------------------------------------------------------------------
// Return: 	0		Funktion gefunden
//				-1		Unbekannte Funktion
// --------------------------------------------------------------------------------
//  Beschreibung:
//
//  Setzt die Instanzvariable welche der Funktion $$HEX1$$fc00$$ENDHEX$$ber Tabelle sys_queue_fl_function
// zugeordnet sind
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  21.07.2009	            Thomas Leutner   Erstellung
//
// --------------------------------------------------------------------------------
long lfound

if this.dsSysQueueFunctions.RowCount() = 0 then
	this.dsSysQueueFunctions.Retrieve()
end if

lfound = this.dsSysQueueFunctions.Find("nfunction = " + String(ifunction), 1, this.dsSysQueueFunctions.RowCount())
if  lfound > 0 then
		// ---------------------------------------------------------------------------------------
		// Bei Amos/Webverarbeitung wurden die Daten in cen_out_... Tabellen abgelegt, 
		// Vergleich zur Vorversion $$HEX1$$fc00$$ENDHEX$$ber History, Steuerung erfolgt je Funktion in sys_queued_fl_function
		// ---------------------------------------------------------------------------------------
		this.bReadFromHistory = (dsSysQueueFunctions.getItemNumber(lfound,"nread_from_history") = 1)

		// ---------------------------------------------------------------------------------------
		// Setzen des Textes je Funktion f$$HEX1$$fc00$$ENDHEX$$r die Protokollierung
		// ---------------------------------------------------------------------------------------
		this.sTypeText = dsSysQueueFunctions.getItemString(lfound,"cprotocol_text")
		// ---------------------------------------------------------------------------------------
		// Setzen der internen Funktion:
		//   1 = Verarbeitung sys_queue_flight_calc und abh. Tabellen
		//   2 = Verarbeitung $$HEX1$$fc00$$ENDHEX$$ber cen_out, da diese im Vorfeld (of_retrieve_dsjobs) bereits in Eintr$$HEX1$$e400$$ENDHEX$$ge 
		//         f$$HEX1$$fc00$$ENDHEX$$r sys_queue_flight_calc und abh. Tabellen umgesetzt wurde, besteht ab hier keine Differenz zu 1
		//   3 = Verarbeitung wie 2 aber mit Aircraft-Change
		//         
		// ---------------------------------------------------------------------------------------
		this.iinternal_function = dsSysQueueFunctions.getItemNumber(lfound,"ninternal_function")
		this.lfunction_queued_release_interface =  dsSysQueueFunctions.getItemNumber(lfound,"nqueued_release_interface")
		this.ifunction_pax_type = dsSysQueueFunctions.getItemNumber(lfound,"npax_type")
		this.iFunction_use_as_pax_type =  dsSysQueueFunctions.getItemNumber(lfound,"nuse_as_pax_type")
		this.lstatus_after_process = dsSysQueueFunctions.getItemNumber(lfound,"nstatus_after_process")
		this.lstatus_to_process = dsSysQueueFunctions.getItemNumber(lfound,"nstatus_to_process")
		this.ifunction_actype = dsSysQueueFunctions.getItemNumber(lfound,"nactype")
		this.iFunction_use_as_actype =  dsSysQueueFunctions.getItemNumber(lfound,"nuse_as_actype")
		return 0
else
		// ---------------------------------------------------------------------------------------
		// unbekannte Funktion
		// ---------------------------------------------------------------------------------------
		return -1
end if


end function

public function integer of_restore_pax_type ();// -----------------------------------------
// Gesicherte Werte wieder in dw_pax zur$$HEX1$$fc00$$ENDHEX$$ckschreiben 
// -----------------------------------------
Long 		i, j
Long		lpax
String		sClass

	// ------------------------------------------------------------------------------------
	// zu jedem Eintrag in dw_pax wird der gesicherte Wert ermittelt und auf das Feld use_as_pax_type $$HEX1$$fc00$$ENDHEX$$bertragen
	// ------------------------------------------------------------------------------------
	for i = 1 to  dw_Pax.RowCount() 
		
		sClass = dw_pax.getItemString(i,"cclass")
		For j = 1 to upperbound(sSaveClass)
			if sClass = sSaveClass[j]  then
				lpax = lSavePax[j]
				
				if this.ifunction_use_as_pax_type = 1 	then	// npax
					dw_pax.setitem(i, "npax", lpax)
				elseif this.ifunction_use_as_pax_type = 2	then	// npax_airline
					dw_pax.setitem(i, "npax_airline", lpax)	
				elseif this.ifunction_use_as_pax_type = 3	then	// npax_system_final
					dw_pax.setitem(i, "npax_system_final", lpax)	
				else
					wf_chc_trace(50,"[of_restore_pax_type] unbekannter Use_as_Pax-typ: " + String (this.ifunction_use_as_pax_type))
					return -1
				end if
			end if
		next
	next


return 0

end function

public function integer of_pax_type_transfer ();// -----------------------------------------
// $$HEX1$$dc00$$ENDHEX$$bernehme Pax-Werte von einem Feld in ein anderes
// zuvor sichern der alten Werte
// -----------------------------------------
Long 		i
Long		lFound
Long		lpax, lpax2
String		sClass
Boolean 	bfinal_pax_station

// pr$$HEX1$$fc00$$ENDHEX$$fe ob Station pax_airline-Daten erfasst hat, dann werden diese verwendet
for i = 1 to  dw_Pax.RowCount() 
	lpax2 += dw_Pax.getitemnumber(i,"npax_airline")
next

if lpax2 > 0 then
	bfinal_pax_station = true
else
	bfinal_pax_station = false
end if
	

istation_entry= this.istation_entry
	// ------------------------------------------------------------------------------------
	// zu jedem Eintrag in dw_pax wird das Feld pax_type auf das Feld use_as_pax_type $$HEX1$$fc00$$ENDHEX$$bertragen
	// ------------------------------------------------------------------------------------
	for i = 1 to  dw_Pax.RowCount() 
		
		sClass = dw_pax.getItemString(i,"cclass")

		lFound = i
		
		if this.ifunction_pax_type = 1 	then	// npax
			lpax = dw_Pax.getitemnumber(lfound,"npax")
		elseif this.ifunction_pax_type = 2 	then	// npax_airline
			lpax = dw_Pax.getitemnumber(lfound,"npax_airline")
		elseif this.ifunction_pax_type = 3 	then	// npax_system_final
			lpax = dw_Pax.getitemnumber(lfound,"npax_system_final")
		else
			wf_chc_trace(50,"[of_pax_type_transfer] unbekannter Pax-typ: " + String (this.ifunction_pax_type))
			return -1
		end if

		if this.ifunction_use_as_pax_type = 1 	then	// npax
			lpax2 = dw_Pax.getitemnumber(lfound,"npax")
			dw_pax.setitem(i, "npax", lpax)
		elseif this.ifunction_use_as_pax_type = 2	then	// npax_airline
			lpax2 = dw_Pax.getitemnumber(lfound,"npax_airline")
			// kein $$HEX1$$fc00$$ENDHEX$$berschreiben, falls Station pax_airline-Daten erfasst hat
			if bfinal_pax_station = true then 
				lpax = lpax2
			end if
			dw_pax.setitem(i, "npax_airline", lpax)
			dw_pax.setitem(i, "npax", lpax)
		elseif this.ifunction_use_as_pax_type = 3	then	// npax_system_final
			lpax2 = dw_Pax.getitemnumber(lfound,"npax_system_final")
			dw_pax.setitem(i, "npax_system_final", lpax)	
		else
			wf_chc_trace(50,"[of_pax_type_transfer] unbekannter Use-as_Pax-typ: " + String (this.ifunction_use_as_pax_type))
			return -1
		end if
		// alten Stand sichern
		this.sSaveClass[i] = sClass
		this.lSavePax[i] = lpax2
		
	next


return 0

end function

public function integer of_restore_version ();// -----------------------------------------
// Gesicherte Werte nvers wieder in dw_pax zur$$HEX1$$fc00$$ENDHEX$$ckschreiben 
// -----------------------------------------
Long 		i, j
Long		lvers
String		sClass

	// ------------------------------------------------------------------------------------
	// zu jedem Eintrag in dw_pax wird der gesicherte Wert ermittelt und auf das Feld use_as_actype $$HEX1$$fc00$$ENDHEX$$bertragen
	// ------------------------------------------------------------------------------------
	for i = 1 to  dw_Pax.RowCount() 
		
		sClass = dw_pax.getItemString(i,"cclass")
		For j = 1 to upperbound(sSaveVersClass)
			if sClass = sSaveVersClass[j]  then
				lvers = lSaveVers[j]
				
				if this.ifunction_use_as_actype = 1 	then	// nversion
					dw_pax.setitem(i, "nversion", lvers)
				elseif this.ifunction_use_as_pax_type = 2	then	// nfinal_version
					dw_pax.setitem(i, "nfinal_version", lvers)	
				else
					wf_chc_trace(50,"[of_restore_version] unbekannter Use_as_actyp: " + String (this.ifunction_use_as_actype))
					return -1
				end if
			end if
		next
	next


return 0

end function

public function integer of_version_type_transfer ();// -----------------------------------------
// $$HEX1$$dc00$$ENDHEX$$bernehme Version-Werte von einem Feld in ein anderes
// zuvor sichern der alten Werte
// -----------------------------------------
Long 		i
Long		lFound
Long		lvers, lpax2
String		sClass
Boolean 	bfinal_pax_station

// pr$$HEX1$$fc00$$ENDHEX$$fe ob Station pax_airline-Daten erfasst hat, dann werden diese verwendet
for i = 1 to  dw_Pax.RowCount() 
	lpax2 += dw_Pax.getitemnumber(i,"npax_airline")
next

if lpax2 > 0 then
	bfinal_pax_station = true
else
	bfinal_pax_station = false
end if
	

istation_entry= this.istation_entry
	// ------------------------------------------------------------------------------------
	// zu jedem Eintrag in dw_pax wird das Feld pax_type auf das Feld use_as_pax_type $$HEX1$$fc00$$ENDHEX$$bertragen
	// ------------------------------------------------------------------------------------
	for i = 1 to  dw_Pax.RowCount() 
		
		sClass = dw_pax.getItemString(i,"cclass")

		lFound = i
		
		if this.ifunction_actype = 1 	then	// nversion
			lvers = dw_Pax.getitemnumber(lfound,"nversion")
		elseif this.ifunction_actype = 2 	then	// nfinal_version
			lvers = dw_Pax.getitemnumber(lfound,"nfinal_version")
		else
			wf_chc_trace(50,"[of_version_type_transfer] unbekannter Versiontyp: " + String (this.ifunction_actype))
			return -1
		end if

		if this.ifunction_use_as_actype = 1 	then	// nveriosn
			lpax2 = dw_Pax.getitemnumber(lfound,"nversion")
			// kein $$HEX1$$fc00$$ENDHEX$$berschreiben, falls Station pax_airline-Daten erfasst hat
			if bfinal_pax_station = true then 
					lvers = lpax2
			end if

			dw_pax.setitem(i, "nversion", lvers)
		elseif this.ifunction_use_as_actype = 2	then	// nfinal_version
			lpax2 = dw_Pax.getitemnumber(lfound,"nfinal_version")
			dw_pax.setitem(i, "nfinal_version", lvers)
		else
			wf_chc_trace(50,"[of_version_type_transfer] unbekannter Use-as_actyp: " + String (this.ifunction_use_as_actype))
			return -1
		end if
		// alten Stand sichern
		this.sSaveVersClass[i] = sClass
		this.lSaveVers[i] = lpax2
		
	next


return 0

end function

public function integer of_check_finals ();// --------------------------------------------------------------------------------
// Objekt : uo_flight_calculation
// Methode: of_check_finals (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor              Kommentar
// --------------------------------------------------------------------------------
//  12.11.2009	   1.0      Heiko Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------
long ll_pax, ll_version, i

ll_pax = 0
ll_version = 0

if this.ifunction_actype = 2 or this.ifunction_pax_type = 3 then 

	for i=1 to dw_pax.rowcount()
		ll_pax += dw_pax.getitemnumber(i,"npax_system_final")
		ll_version += dw_pax.getitemnumber(i,"nfinal_version")
	next

	if ll_version=0 and this.ifunction_actype = 2 then
		for i=1 to dw_pax.rowcount()
			 dw_pax.setitem(i,"nfinal_version",  dw_pax.getitemnumber(i,"nversion"))
		next
	end if
		
	if ll_pax=0 and this.ifunction_pax_type = 3 then
		for i=1 to dw_pax.rowcount()
			 dw_pax.setitem(i,"npax_system_final",  dw_pax.getitemnumber(i,"npax"))
		next
	end if
end if

return 1
end function

public function boolean of_recalc_save ();//==============================================================================================
//
// of_recalc_save
//
// $$HEX1$$c400$$ENDHEX$$nderungen in recalc-Feldern bzw. cen_out_meals_recalc speichern
//
//==============================================================================================


long 				i, lFind
string			sTableName
decimal			dcQuantity
boolean			bSupressChanges		// keine $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen 
												// bei $$HEX1$$dc00$$ENDHEX$$berschreitung der Abflugzeit
integer			iLegNumber
Integer 			li_nquantity
Long				ll_rownum
long				lStart, lStop
long				lnew_cen_out_nrecalc_status
Datetime			dtnew_drecalc_date

lStart = CPU()

wf_chc_trace(10,"[of_recalc_save] Begin")

// ------------------------------------------------------------------
// Vorab-Pr$$HEX1$$fc00$$ENDHEX$$fung: Accepttext, SPML
// ------------------------------------------------------------------
if wf_chc_validation() <> 0 then
	wf_chc_trace(10,"of_recalc_save|wf_chc_validation returns error")
	bInAction = false
	return false
end if

// ------------------------------------------------------------------
// F$$HEX1$$fc00$$ENDHEX$$r die Dauer der Ausf$$HEX1$$fc00$$ENDHEX$$hrung keine Aktionen erlauben
// ------------------------------------------------------------------
bInAction = true


// ------------------------------------------------------------------
// Lagen inhaltliche Fehler vor? z.B. Kein Handling
// ------------------------------------------------------------------
If bNoSaving = True Then
	wf_chc_trace(10,"[of_recalc_save] bNoSaving = True")

	if not bImportMode then
		f_Log2Csv(0,2,"[of_recalc_save] Die aktuellen Ver$$HEX1$$e400$$ENDHEX$$nderungen lassen ein Speichern nicht zu.")
	end if
	bInAction = false
	bforcemealcalculation = false
	bAnychange = false
	return False
End if	
// ------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungen in die Nachkalkulationsfelder setzen
// ------------------------------------------------------------------
of_recalc_set_differences(this.lResultKeyCenOut )


// F$$HEX1$$fc00$$ENDHEX$$r Monalisa Istdatenbrowser gilt : generell  keine $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen verschicken
bSupressChanges = true

// ------------------------------------------------------------------------
// neue  Werte setzen f$$HEX1$$fc00$$ENDHEX$$r cen_out
// ------------------------------------------------------------------------
lnew_cen_out_nrecalc_status = 2   // Menge nachkalkuliert
dtnew_drecalc_date = Datetime(Today(),Now())

update cen_out 
		set nrecalc_status = :lnew_cen_out_nrecalc_status,
			drecalc_date = :dtnew_drecalc_date
 where nresult_key = :this.lResultKeyCenOut;
			 
if sqlca.sqlcode <> 0 then
	rollback ;
	f_Log2Csv(0,2,"[of_recalc_save] Database error updating cen_out_recalc_status  SQLCODE: " + String(sqlca.sqlcode))
	bInAction = false
	return False
end if


// ------------------------------------------------------------------------
// Speichern von dw_recalc_extra
// ------------------------------------------------------------------------

wf_chc_trace(10,"[of_recalc_save] Speichern der Extrabeladung Start")
If dw_recalc_extra.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[of_recalc_save] Fehler beim Speichern der Extrabeladung.")
	end if
	bInAction = false
	return False
End if
wf_chc_trace(10,"[of_recalc_save] Speichern der Extrabeladung Ende")

// ------------------------------------------------------------------------
// Speichern von dw_recalc_meal
// ------------------------------------------------------------------------

wf_chc_trace(10,"[of_recalc_save] Speichern der Mahlzeitenbeladung Start")
//wf_setmessage("Speichern der Mahlzeitenbeladung")
If dw_recalc_meal.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[of_recalc_save] Fehler beim Speichern der Mahlzeitenbeladung.")
	end if
	bInAction = false
	return False
End if
wf_chc_trace(10,"[of_recalc_save] Speichern der Mahlzeitenbeladung Ende")
// ------------------------------------------------------------------------
// Speichern von dw_recalc_extra_recalc
// ------------------------------------------------------------------------

// Wg. ungekl$$HEX1$$e400$$ENDHEX$$rtem Fehler werden hier die bei nquantity 
// NULL-Werte zur$$HEX1$$fc00$$ENDHEX$$ckgesetzt

IF dw_recalc_extra_recalc.RowCount() > 0 THEN
	
	ll_rownum = 1
	
	DO
		li_nquantity = dw_recalc_extra_recalc.GetItemNumber(ll_rownum,"nquantity")
		
		IF IsNull(li_nquantity) THEN
			dw_recalc_extra_recalc.SetItem(ll_rownum,"nquantity",0)
		END IF
		
		ll_rownum = ll_rownum + 1
		
	LOOP UNTIL ll_rownum > dw_recalc_extra_recalc.RowCount()

END IF

wf_chc_trace(10,"[of_recalc_save] Speichern der Extrabeladung2 Start")
If dw_recalc_extra_recalc.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[of_recalc_save] Fehler beim Speichern der Extrabeladung2.")
	end if
	bInAction = false
	return False
End if
wf_chc_trace(10,"[of_recalc_save] Speichern der Extrabeladung Ende")

// ------------------------------------------------------------------------
// Speichern von dw_recalc_meal_recalc
// ------------------------------------------------------------------------

wf_chc_trace(10,"[of_recalc_save] Speichern der Mahlzeitenbeladung2 Start")
//wf_setmessage("Speichern der Mahlzeitenbeladung")
If dw_recalc_meal_recalc.Update() <> 1 Then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[of_recalc_save] Fehler beim Speichern der Mahlzeitenbeladung2.")
	end if
	bInAction = false
	return False
End if
wf_chc_trace(10,"[of_recalc_save] Speichern der Mahlzeitenbeladung Ende2")
//
//  Flight-Pricer setzen
//
long		lSequence
datetime	dtCreated
time		tDepartureTime
datetime	dtDeparture

dtCreated 		= datetime(today(),now())
tDepartureTime = time(dw_single.GetItemString(dw_single.GetRow(),"cdeparture_time"))
dtDeparture		= datetime(ddeparture,tDepartureTime)

lSequence = f_Sequence("seq_sys_flight_pricer", sqlca)
If lSequence = -1 Then
	rollback ;
	bInAction = false
	f_Log2Csv(0,2,"[of_recalc_save] Fehler bei Sequence f$$HEX1$$fc00$$ENDHEX$$r sys_flight_pricer.")
	return False
end if

insert into sys_flight_pricer (njob_nr, nresult_key, ddeparture, dcreated, nstatus, nfunction)
		values (:lSequence, :lresultkey_trace, :dtDeparture, :dtCreated, 0, 4);

if sqlca.sqlcode <> 0 then
	rollback ;
	if not bImportMode then
		f_Log2Csv(0,2,"[of_recalc_save] Fehler beim Speichern in sys_flight_pricer.")
	end if
	bInAction = false
	return False
end if


// ------------------------------------------------------------------------
// Und nun der Commit, und Save Button aus
// ------------------------------------------------------------------------
// if bEnableCommit then
	commit ;
// end if


// ------------------------------------------------------------------------
// Speicher Status und Annullierung Status Reset
// ------------------------------------------------------------------------
bNoSaving 			= False
bCancelAction		= False
bNewspaperChange	= False
bMealChange			= False
bManualChanges 	= false
bInAction = false
// -------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungen zur$$HEX1$$fc00$$ENDHEX$$cksetzen
// -------------------------------------------------------------------------
strUserChanges	= strUserChangesEmpty

// -------------------------------------------------------------------------
// Speicher aufr$$HEX1$$e400$$ENDHEX$$umen
// -------------------------------------------------------------------------
wf_chc_trace(10,"[of_recalc_save] GarbageCollect")
GarbageCollect()

lStop = CPU()

if ((lStop - lStart) / 1000) > 7 then
	lStop -= 2000
end if


wf_chc_trace(10,"[of_recalc_save] Fertig")

bAnychange = false

Return True

end function

public function integer of_recalc_set_differences (long lresult_key);// F$$HEX1$$fc00$$ENDHEX$$r Nachkalkulation
// Setzen der neuen Mengen aus Nachkalkulation in dw_recalc_meal und dw_recalc_extra
// Sollten neue Eintr$$HEX1$$e400$$ENDHEX$$ge vorhanden sein (andere St$$HEX1$$fc00$$ENDHEX$$ckliste), so werde diese in dw_recalc_meal_recalc/extra_recalc abgelegt
//--------------------------------------------------------------------------------------------------
	long lEditCounter, lrow, lFind, lpax, lFound, lVersCheck
	long lClass_number
	String	sFind, sData
	Integer	li_npax
	Integer	li_npax_manual
	Integer	li_ncalc_basis
	Integer	li_nquantity
	long	lNull, ltransaction
	String		ls_cclass

	setNull(lNull)
	ltransaction = dw_single.Getitemnumber(dw_single.getRow(),"ntransaction")
	bforceMealcalculation=false
	//-------------------------------------------------------------------------
	//  Datastores mit dem aktuellen Inhalt f$$HEX1$$fc00$$ENDHEX$$llen
	//-------------------------------------------------------------------------
	dw_recalc_extra.retrieve(lResult_Key,1)
	dw_recalc_meal.retrieve(lResult_Key,0)
	
	dw_recalc_extra_recalc.retrieve(lResult_Key,1)
	dw_recalc_meal_recalc.retrieve(lResult_Key,0)
	//-------------------------------------------------------------------------
	//  dw_recalc_meal_recalc-Zeilen l$$HEX1$$f600$$ENDHEX$$schen
	//-------------------------------------------------------------------------
	For lrow = 1 to dw_recalc_meal_recalc.rowcount()
		dw_recalc_meal_recalc.DeleteRow(1)
	Next
	//-------------------------------------------------------------------------
	//  dw_recalc_extra_recalc-Zeilen l$$HEX1$$f600$$ENDHEX$$schen
	//-------------------------------------------------------------------------
	For lrow = 1 to dw_recalc_extra_recalc.rowcount()
		dw_recalc_extra_recalc.DeleteRow(1)
	Next
	

	//-------------------------------------------------------------------------
	//  dw_recalc_meal   recalc-Werte initialisieren
	//-------------------------------------------------------------------------
	For lrow = 1 to dw_recalc_meal.rowcount()
		dw_recalc_meal.SetItem(lrow,"nquantity_recalc",0)
		dw_recalc_meal.SetItem(lrow,"ncalc_basis_recalc",dw_recalc_meal.GetItemNumber(lrow,"ncalc_basis"))
	Next
		
	//-------------------------------------------------------------------------
	//  Ermittle $$HEX1$$c400$$ENDHEX$$nderungen in Meal-Tabelle
	//-------------------------------------------------------------------------
	For lrow = 1 to dw_meal.rowcount()
		sFind="nprio = " + String(dw_meal.getItemNumber(lrow,"nprio")) + &
				" and ncover_prio = " + String(dw_meal.getItemNumber(lrow,"ncover_prio")) + &
		  		" and nmodule_type =  0 " + &
		  		" and ndetail_key = " +  String(dw_meal.getItemNumber(lrow,"ndetail_key")) + &
				" and nclass_number = " + String(dw_meal.getItemNumber(lrow,"nclass_number")) 
			
		lfind=dw_recalc_meal.Find(sFind,1, dw_recalc_meal.rowcount())
		
		if lfind <= 0 then
			//-------------------------------------------------------------------------
			// nicht gefunden, in cen_out_meals_recalc neu anlegen
			//-------------------------------------------------------------------------

			wf_ml_Rowscopy_meal(dw_meal, lrow, lrow,  dw_recalc_meal_recalc, dw_recalc_meal_recalc.Rowcount() + 1)
			dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"nquantity_recalc",dw_meal.GetItemNumber(lrow,"nquantity"))
			dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"ncalc_basis_recalc",dw_meal.GetItemNumber(lrow,"ncalc_basis"))
			dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"ntransaction",ltransaction )

			// TBR 28.10.2013 Initialisierung von NULL-Values ----------------------------------------------------------------------------------------------
			IF	dw_recalc_meal_recalc.Rowcount() > 0 THEN
				li_npax 	=	dw_recalc_meal_recalc.GetItemNumber(dw_recalc_meal_recalc.Rowcount(),"npax")
				IF 	IsNull(li_npax) THEN
					dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"npax",0)
				END IF				
				
				li_npax_manual 	=	dw_recalc_meal_recalc.GetItemNumber(dw_recalc_meal_recalc.Rowcount(),"npax_manual")
				IF 	IsNull(li_npax_manual) THEN
					dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"npax_manual",0)
				END IF				
	
				li_nquantity 	=	dw_recalc_meal_recalc.GetItemNumber(dw_recalc_meal_recalc.Rowcount(),"nquantity")
				IF 	IsNull(li_nquantity) THEN
					dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"nquantity",0)
				END IF				
	
				li_ncalc_basis 	=	dw_recalc_meal_recalc.GetItemNumber(dw_recalc_meal_recalc.Rowcount(),"ncalc_basis")
				IF 	IsNull(li_ncalc_basis) THEN
					dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"ncalc_basis",0)
				END IF				
				
				ls_cclass 	=	dw_recalc_meal_recalc.GetItemString(dw_recalc_meal_recalc.Rowcount(),"cclass")
				IF 	IsNull(ls_cclass) THEN
					dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"cclass"," ")
				END IF				
			END IF
			// TBR 28.10.2013 ----------------------------------------------------------------------------------------------------------------------------------

			bAnychange = true
			 bManualChanges = true

		else
			if dw_meal.GetItemNumber(lrow,"npackinglist_index_key") <> &
				 dw_recalc_meal.GetItemNumber(lfind,"npackinglist_index_key") then
				//-------------------------------------------------------------------------
				// andere St$$HEX1$$fc00$$ENDHEX$$ckliste, in cen_out_meals_recalc neu anlegen
				//-------------------------------------------------------------------------

  				wf_ml_Rowscopy_meal(dw_meal, lrow, lrow,  dw_recalc_meal_recalc, dw_recalc_meal_recalc.Rowcount() + 1)
				dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"nquantity_recalc",dw_meal.GetItemNumber(lrow,"nquantity"))
				dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"ncalc_basis_recalc",dw_meal.GetItemNumber(lrow,"ncalc_basis"))
				dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"ntransaction",ltransaction )

				// TBR 28.10.2013 Initialisierung von NULL-Values ----------------------------------------------------------------------------------------------
				IF	dw_recalc_meal_recalc.Rowcount() > 0 THEN
					li_npax 	=	dw_recalc_meal_recalc.GetItemNumber(dw_recalc_meal_recalc.Rowcount(),"npax")
					IF 	IsNull(li_npax) THEN
						dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"npax",0)
					END IF				
	
					li_npax_manual 	=	dw_recalc_meal_recalc.GetItemNumber(dw_recalc_meal_recalc.Rowcount(),"npax_manual")
					IF 	IsNull(li_npax_manual) THEN
						dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"npax_manual",0)
					END IF				
	
					li_nquantity 	=	dw_recalc_meal_recalc.GetItemNumber(dw_recalc_meal_recalc.Rowcount(),"nquantity")
					IF 	IsNull(li_nquantity) THEN
						dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"nquantity",0)
					END IF				
	
					li_ncalc_basis 	=	dw_recalc_meal_recalc.GetItemNumber(dw_recalc_meal_recalc.Rowcount(),"ncalc_basis")
					IF 	IsNull(li_ncalc_basis) THEN
						dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"ncalc_basis",0)
					END IF				
					
					ls_cclass 	=	dw_recalc_meal_recalc.GetItemString(dw_recalc_meal_recalc.Rowcount(),"cclass")
					IF 	IsNull(ls_cclass) THEN
						dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"cclass"," ")
					END IF				
				END IF
				// TBR 28.10.2013 ----------------------------------------------------------------------------------------------------------------------------------

				 bAnychange = true
				 bManualChanges = true
			else
				//-------------------------------------------------------------------------		
				// sonst  neue Menge und Kalkulationsbasis der Nachkalkulation setzen
				//-------------------------------------------------------------------------

				// TBR 28.10.2013 Initialisierung von NULL-Values ----------------------------------------------------------------------------------------------
				IF	dw_recalc_meal_recalc.Rowcount() > 0 THEN
					li_npax 	=	dw_recalc_meal_recalc.GetItemNumber(dw_recalc_meal_recalc.Rowcount(),"npax")
					IF 	IsNull(li_npax) THEN
						dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"npax",0)
					END IF				
	
					li_npax_manual 	=	dw_recalc_meal_recalc.GetItemNumber(dw_recalc_meal_recalc.Rowcount(),"npax_manual")
					IF 	IsNull(li_npax_manual) THEN
						dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"npax_manual",0)
					END IF				
				END IF
				// TBR 28.10.2013 ----------------------------------------------------------------------------------------------------------------------------------
				
				dw_recalc_meal.SetItem(lfind,"nquantity_recalc",dw_meal.GetItemNumber(lrow,"nquantity"))
				dw_recalc_meal.SetItem(lfind,"ncalc_basis_recalc",dw_meal.GetItemNumber(lrow,"ncalc_basis"))
				bAnychange = true
				bManualChanges = true

				// TBR 28.10.2013 Initialisierung von NULL-Values ----------------------------------------------------------------------------------------------
				IF	dw_recalc_meal_recalc.Rowcount() > 0 THEN
					li_nquantity 	=	dw_recalc_meal_recalc.GetItemNumber(dw_recalc_meal_recalc.Rowcount(),"nquantity_recalc")
					IF 	IsNull(li_nquantity) THEN
						dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"nquantity_recalc",0)
					END IF				
	
					li_ncalc_basis 	=	dw_recalc_meal_recalc.GetItemNumber(dw_recalc_meal_recalc.Rowcount(),"ncalc_basis")
					IF 	IsNull(li_ncalc_basis) THEN
						dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"ncalc_basis",0)
					END IF				
					
					ls_cclass 	=	dw_recalc_meal_recalc.GetItemString(dw_recalc_meal_recalc.Rowcount(),"cclass")
					IF 	IsNull(ls_cclass) THEN
						dw_recalc_meal_recalc.SetItem(dw_recalc_meal_recalc.Rowcount(),"cclass"," ")
					END IF				
				END IF
				// TBR 28.10.2013 ----------------------------------------------------------------------------------------------------------------------------------
					
				//dw_meal.SetItem(lRow,"nmanual_input",1)
					
			end if

		End if
		
	next
	
	//-------------------------------------------------------------------------
	//  dw_recalc_extra   recalc-Werte initialisieren
	//-------------------------------------------------------------------------
	For lrow = 1 to dw_recalc_extra.rowcount()
		dw_recalc_extra.SetItem(lrow,"nquantity_recalc",0)
		dw_recalc_extra.SetItem(lrow,"ncalc_basis_recalc",dw_recalc_extra.GetItemNumber(lrow,"ncalc_basis"))
	Next

	//-------------------------------------------------------------------------
	//  Ermittle $$HEX1$$c400$$ENDHEX$$nderungen in Extra-Tabelle
	//-------------------------------------------------------------------------
	For lrow = 1 to dw_extra.rowcount()
		sFind="nprio = " + String(dw_extra.getItemNumber(lrow,"nprio")) + &
				" and ncover_prio = " + String(dw_extra.getItemNumber(lrow,"ncover_prio")) + &
 		 		" and ndetail_key = " +  String(dw_extra.getItemNumber(lrow,"ndetail_key")) + &
					" and nmodule_type =  1 " + &
				" and nclass_number = " + String(dw_extra.getItemNumber(lrow,"nclass_number")) 
			
		lfind=dw_recalc_extra.Find(sFind,1, dw_recalc_extra.rowcount())
		
		if lfind <= 0 then
			//-------------------------------------------------------------------------
			// nicht gefunden, in cen_out_meals_recalc neu anlegen
			//-------------------------------------------------------------------------
			wf_ml_Rowscopy_meal(dw_extra, lrow, lrow,  dw_recalc_extra_recalc, dw_recalc_extra_recalc.Rowcount() + 1)

			// TBR 09.10.2013 Initialisierung von NULL-Values ----------------------------------------------------------------------------------------------
			IF	dw_recalc_extra_recalc.Rowcount() > 0 THEN
				li_npax 	=	dw_recalc_extra_recalc.GetItemNumber(dw_recalc_extra_recalc.Rowcount(),"npax")
				IF 	IsNull(li_npax) THEN
					dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"npax",0)
				END IF				
				li_npax_manual 	=	dw_recalc_extra_recalc.GetItemNumber(dw_recalc_extra_recalc.Rowcount(),"npax_manual")
				IF 	IsNull(li_npax_manual) THEN
					dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"npax_manual",0)
				END IF				
			END IF
			// TBR 09.10.2013 ----------------------------------------------------------------------------------------------------------------------------------

			dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"nquantity_recalc",dw_extra.GetItemNumber(lrow,"nquantity"))
			dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"ncalc_basis_recalc",dw_extra.GetItemNumber(lrow,"ncalc_basis"))

			// TBR 09.10.2013 Initialisierung von NULL-Values ----------------------------------------------------------------------------------------------
			IF dw_recalc_extra_recalc.Rowcount() > 0 THEN
				li_ncalc_basis 	=	dw_recalc_extra_recalc.GetItemNumber(dw_recalc_extra_recalc.Rowcount(),"ncalc_basis")
				IF 	IsNull(li_ncalc_basis) THEN
					dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"ncalc_basis",0)
				END IF				
				ls_cclass 	=	dw_recalc_extra_recalc.GetItemString(dw_recalc_extra_recalc.Rowcount(),"cclass")
				IF 	IsNull(ls_cclass) THEN
					dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"cclass"," ")
				END IF				
			END IF
			// TBR 09.10.2013 ----------------------------------------------------------------------------------------------------------------------------------

			dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"ntransaction",ltransaction )
				
			 bAnychange = true
			 bManualChanges = true

		else
			if dw_extra.GetItemNumber(lrow,"npackinglist_index_key") <> &
				 dw_recalc_extra.GetItemNumber(lfind,"npackinglist_index_key") then
				//-------------------------------------------------------------------------
				// andere St$$HEX1$$fc00$$ENDHEX$$ckliste, in cen_out_meals_recalc neu anlegen
				//-------------------------------------------------------------------------
				wf_ml_Rowscopy_meal(dw_extra, lrow, lrow,  dw_recalc_extra_recalc, dw_recalc_extra_recalc.Rowcount() + 1)

				// TBR 09.10.2013 Initialisierung von NULL-Values ----------------------------------------------------------------------------------------------
				IF	dw_recalc_extra_recalc.Rowcount() > 0 THEN
					li_npax 	=	dw_recalc_extra_recalc.GetItemNumber(dw_recalc_extra_recalc.Rowcount(),"npax")
					IF 	IsNull(li_npax) THEN
						dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"npax",0)
					END IF				
					li_npax_manual 	=	dw_recalc_extra_recalc.GetItemNumber(dw_recalc_extra_recalc.Rowcount(),"npax_manual")
					IF 	IsNull(li_npax_manual) THEN
						dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"npax_manual",0)
					END IF				
				END IF
				// TBR 09.10.2013 ----------------------------------------------------------------------------------------------------------------------------------

				dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"nquantity_recalc",dw_extra.GetItemNumber(lrow,"nquantity"))
				dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"ncalc_basis_recalc",dw_extra.GetItemNumber(lrow,"ncalc_basis"))

				// TBR 09.10.2013 Initialisierung von NULL-Values ----------------------------------------------------------------------------------------------
				IF	dw_recalc_extra_recalc.Rowcount() > 0 THEN
					li_ncalc_basis 	=	dw_recalc_extra_recalc.GetItemNumber(dw_recalc_extra_recalc.Rowcount(),"ncalc_basis")
					IF 	IsNull(li_ncalc_basis) THEN
						dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"ncalc_basis",0)
					END IF				
					ls_cclass 	=	dw_recalc_extra_recalc.GetItemString(dw_recalc_extra_recalc.Rowcount(),"cclass")
					IF 	IsNull(ls_cclass) THEN
						dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"cclass"," ")
					END IF				
				END IF
				// TBR 09.10.2013 ----------------------------------------------------------------------------------------------------------------------------------				
				
				dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"ntransaction",ltransaction )
				 bAnychange = true
				 bManualChanges = true
			else
				//-------------------------------------------------------------------------		
				// sonst  neue Menge und Kalkulationsbasis der Nachkalkulation setzen
				//-------------------------------------------------------------------------
				dw_recalc_extra.SetItem(lfind,"nquantity_recalc",dw_extra.GetItemNumber(lrow,"nquantity"))

				// TBR 09.10.2013 Initialisierung von NULL-Values ----------------------------------------------------------------------------------------------
				IF	dw_recalc_extra_recalc.Rowcount() > 0 THEN
					li_ncalc_basis 	=	dw_recalc_extra_recalc.GetItemNumber(dw_recalc_extra_recalc.Rowcount(),"ncalc_basis")
					IF 	IsNull(li_ncalc_basis) THEN
						dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"ncalc_basis",0)
					END IF				
					ls_cclass 	=	dw_recalc_extra_recalc.GetItemString(dw_recalc_extra_recalc.Rowcount(),"cclass")
					IF 	IsNull(ls_cclass) THEN
						dw_recalc_extra_recalc.SetItem(dw_recalc_extra_recalc.Rowcount(),"cclass"," ")
					END IF				
				END IF
				// TBR 09.10.2013 ----------------------------------------------------------------------------------------------------------------------------------				

				dw_recalc_extra.SetItem(lfind,"ncalc_basis_recalc",dw_extra.GetItemNumber(lrow,"ncalc_basis"))
				bAnychange = true
				bManualChanges = true
					
				//dw_extra.SetItem(lRow,"nmanual_input",1)
					
			end if

		End if
		
	next


	
	return 0
end function

public function boolean wf_ml_rowscopy_meal (datastore dwsource, long lstartrow_source, long lendrow_source, datastore dwtarget, long lstartrow_target);//-------------------------------------------------------------------------------
// Kopieren zwischen den Formaten der Datawindows dw_meal
// und dw_meal_recalc
// Erg$$HEX1$$e400$$ENDHEX$$nzen ggf. fehlender Informationen
//-------------------------------------------------------------------------------
Integer 	itype_source, itype_target
Integer i
datastore dw_format1, dw_format2, dw_format3
string	stext,stext2,stext3
Integer	li_result
String		ls_dataobject_source 
String		ls_dataobject_target 

dw_format1										= Create datastore
dw_format1.DataObject 							= "dw_change_cen_out_meals"
//dw_format1							= dw_format11 // Format von "dw_change_cen_out_passenger"
dw_format1.SetTransObject(SQLCA)

dw_format3										= Create datastore
dw_format3.DataObject 							= "dw_recalc_cen_out_meals"
														
//dw_format1							= dw_format11 // Format von "dw_change_cen_out_passenger"
dw_format3.SetTransObject(SQLCA)

dw_format2											= Create datastore
dw_format2.DataObject 							= "dw_recalc_cen_out_meals_recalc"

//dw_format2							= dw_format12  //Format von "dw_invoice_ml_cen_out_passenger"
dw_format2.SetTransObject(SQLCA)
stext = dwsource.DataObject 	
stext2 = dwtarget.DataObject 	
stext3 = dw_format3.DataObject 	


if dwsource.Dataobject = dw_format1.DataObject then
	itype_source = 1
elseif dwsource.Dataobject = dw_format2.DataObject  then
	itype_source = 2
elseif 	dwsource.Dataobject = dw_format3.DataObject then 
	itype_source = 3

else
	itype_source = 0
end if
if dwtarget.Dataobject = dw_format1.DataObject 	then

	itype_target = 1
elseif dwtarget.Dataobject = dw_format2.DataObject then
	itype_target = 2
elseif 	dwtarget.Dataobject = dw_format3.DataObject then
	itype_target = 3
else
	itype_target = 0
end if
if itype_target = 0 or itype_source = 0 then
	// 05.03.2010 HR: Destroy eingebaut, uf.mbox durch log ersetzt

	destroy dw_format1
	destroy dw_format2
	destroy dw_format3

	f_log2csv(0,2,"[wf_ml_rowscopy_meal] Achtung: Hallo Entwickler, unbekanntes Datawindow in wf_ml_rowscopy_meal!")
	
	return false
end if
if itype_target = itype_source then // Formate gleich
	
	IF	dwsource.RowCount() > 0 THEN
		ls_dataobject_source = 	dwsource.DataObject
		ls_dataobject_target 	= 	dwtarget.DataObject
		li_result = dwsource.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
		IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_meal - 0] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
	END IF
	
else // Formate ungleich 
	if itype_source = 1 then 	// Format 1: dw_change_cen_out_passenger

		IF	dwsource.RowCount() > 0 THEN
			ls_dataobject_source = 	dwsource.DataObject
			ls_dataobject_target 	= 	dw_format1.DataObject
			li_result = dwsource.Rowscopy(1, dwsource.rowcount(),Primary!,dw_format1,1,PRIMARY!)
			IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_meal - 1] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
		END IF
		
		if itype_target = 2 then
			wf_ml_superrowscopy(dw_format1, dw_format2)

			IF	dw_format2.RowCount() > 0 THEN
				ls_dataobject_source = 	dw_format2.DataObject
				ls_dataobject_target 	= 	dwtarget.DataObject
				li_result = dw_format2.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_meal - 2] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
		end if
		
		if itype_target = 3 then
			wf_ml_superrowscopy(dw_format1, dw_format3)

			IF	dw_format3.RowCount() > 0 THEN
				ls_dataobject_source = 	dw_format3.DataObject
				ls_dataobject_target 	= 	dwtarget.DataObject
				li_result = dw_format3.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_meal - 3] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
		
		end if
	elseif itype_source = 2 then  		// Format 2: dw_invoice_ml_cen_out_passenger
		if itype_target = 1 then

			IF	dwsource.RowCount() > 0 THEN
				ls_dataobject_source = 	dwsource.DataObject
				ls_dataobject_target 	= 	dw_format2.DataObject
				li_result = dwsource.Rowscopy(1, dwsource.rowcount(),Primary!,dw_format2,1,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_meal - 4] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF

			wf_ml_superrowscopy(dw_format2, dw_format1)
			
			IF	dw_format1.RowCount() > 0 THEN
				ls_dataobject_source = 	dw_format1.DataObject
				ls_dataobject_target 	= 	dwtarget.DataObject
				li_result = dw_format1.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_meal - 5] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
		end if
		if itype_target = 3 then

			IF	dwsource.RowCount() > 0 THEN
				ls_dataobject_source = 	dwsource.DataObject
				ls_dataobject_target 	= 	dw_format2.DataObject
				li_result = dwsource.Rowscopy(1, dwsource.rowcount(),Primary!,dw_format2,1,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_meal - 6] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF

			wf_ml_superrowscopy(dw_format2, dw_format3)
			
			IF	dw_format3.RowCount() > 0 THEN
				ls_dataobject_source = 	dw_format3.DataObject
				ls_dataobject_target 	= 	dwtarget.DataObject
				li_result = dw_format3.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_meal - 7] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
		end if

	elseif itype_source = 3 then  		// Format 3: dw_invoice_ml_cen_out_passenger
		if itype_target = 1 then
			
			IF	dwsource.RowCount() > 0 THEN
				ls_dataobject_source = 	dwsource.DataObject
				ls_dataobject_target 	= 	dw_format3.DataObject
				li_result = dwsource.Rowscopy(1, dwsource.rowcount(),Primary!,dw_format3,1,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_meal - 8] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
			wf_ml_superrowscopy(dw_format3, dw_format1)
			
			IF	dw_format1.RowCount() > 0 THEN
				ls_dataobject_source = 	dw_format1.DataObject
				ls_dataobject_target 	= 	dwtarget.DataObject
				li_result = dw_format1.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_meal - 9] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
		end if
		if itype_target = 2 then

			IF	dwsource.RowCount() > 0 THEN
				ls_dataobject_source = 	dwsource.DataObject
				ls_dataobject_target 	= 	dw_format3.DataObject
				li_result = dwsource.Rowscopy(1, dwsource.rowcount(),Primary!,dw_format3,1,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_meal - 10] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
			wf_ml_superrowscopy(dw_format3, dw_format2)
			
			IF	dw_format2.RowCount() > 0 THEN
				ls_dataobject_source = 	dw_format2.DataObject
				ls_dataobject_target 	= 	dwtarget.DataObject
				li_result = dw_format2.Rowscopy(lstartrow_source, lendrow_source,Primary!,dwtarget,lstartrow_target,PRIMARY!)
				IF li_result = -1 THEN f_Log2Csv(0,1,"[wf_ml_rowscopy_meal - 11] Error Rowscopy / Source: " + ls_dataobject_source + " / Target: " + ls_dataobject_target ) // 29.10.2013 TBR
			END IF
			
		end if

	end if
		
end if

// 05.03.2010 HR: Destroy eingebaut
destroy dw_format1
destroy dw_format2
destroy dw_format3


return true



end function

public function integer of_change_transaction (datastore ad_ds, long al_transaction);/*
* Objekt : uo_webservice
* Methode:of_change_transaction (Function)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 12.08..2011
*
* Argument(e):
*    datastore ad_ds
*    long   al_transaction
*
* --------------------------------------------------
* History schreiben vorbereiten
* --------------------------------------------------
* Wenn die History geschrieben werden soll, dann
* die Transaktionsnummmer hochz$$HEX1$$e400$$ENDHEX$$hlen und die ganzen 
* Datastores retrieven lassen, die daf$$HEX1$$fc00$$ENDHEX$$r gebraucht
* werden 
* --------------------------------------------------*
* Aenderungshistorie:
* Version       Wer         Wann         Was und warum
* 1.0             Klaus          12.08.2011   Erstellung
*
*
* Return: integer
*
*/
Long I

for i = 1 to ad_ds.RowCount()
   ad_ds.SetItem(i, "ntransaction", al_transaction)
next


return 0

end function

public function integer of_process_mealdistribution (long arg_lrow);long 					lResult_key, ltransaction
uo_client_label 		uoClientLabel

lResult_key 					= dsJobs.GetItemNumber(arg_lrow, "nresult_key")

uoClientLabel 				= create uo_client_label

uoClientLabel.lResultKey 	= lResult_key

if uoClientLabel.dsCenOut.Retrieve(lResult_key) = 0 then 
	this.sreturn_error_message= "Flight not found"
	f_Log2Csv(0,1,"[of_process_mealdistribution] Flug nicht gefunden!")	
	
	destroy uoClientLabel // 05.12.2012 HR:
	garbagecollect()
	
	return -1
end if


uoClientLabel.sUnit								= uoClientLabel.dsCenOut.getitemstring(1,"cunit")
uoClientLabel.ddeparture							= date(uoClientLabel.dsCenOut.getitemdatetime(1,"ddeparture"))

//uoClientLabel.slogpath 							= sLogPathFilename // 05.12.2012 HR: Logpath $$HEX1$$fc00$$ENDHEX$$bergeben

of_get_resultkeys( lResult_key, uoClientLabel.lResultKeys)

//uoClientLabel.iWebService
uoClientLabel.bLocationSheet					= false
uoClientLabel.bSPMLSummary					= false
uoClientLabel.bManuelDistribution				= false
uoClientLabel.bManuelDistributionOnError	= false
uoClientLabel.bCheckSheetOnlyUsed			= false
//uoClientLabel.iSPMLTextType				
//uoClientLabel.iAddLabelOption
uoClientLabel.uoPDF								= s_app.uo_pdf

// 07.11.2018 HR: Popups von Stauortverteilung deaktivieren (ALMID 2729)
uoClientLabel.iwebservice = 1

uoClientLabel.iUseExclusion 						= Integer(f_unitprofilestring("Default","LABEL_USE_EXCLUSION","0", uoClientLabel.sUnit))

if uoClientLabel.dsCenOut.GetItemString(1, "chandling_type_text") <> "DLV" then

	if uoClientLabel.of_get_standard_loading() <> 0 then
		this.sreturn_error_message = "Keine Standardbeladung gefunden"
		f_Log2Csv(0,1,"[of_process_mealdistribution] Keine Standardbeladung gefunden!")
			
		destroy uoClientLabel // 05.12.2012 HR:
		garbagecollect()

		return -1
	end if
else

	if uoClientLabel.of_get_local_standard_loading() <= 0 then
		this.sreturn_error_message = "Keine individuelle Standardbeladung"
		f_Log2Csv(0,1,"[of_process_mealdistribution] Keine individuelle Standardbeladung gefunden!")	
			
		destroy uoClientLabel // 05.12.2012 HR:
		garbagecollect()

		return -1
	end if
	
end if

f_Log2Csv(0,1,"[of_process_mealdistribution] uoClientLabel.of_set_labeltype()")
uoClientLabel.of_set_labeltype()

f_Log2Csv(0,1,"[of_process_mealdistribution] uoClientLabel.of_add_workstations()")
uoClientLabel.of_add_workstations()

f_Log2Csv(0,1,"[of_process_mealdistribution] uoClientLabel.of_distribution()")

if uoClientLabel.of_distribution() = -1000 then
	this.sreturn_error_message = "Fehler Verteilung "+uoClientLabel.sErrorMessage
	f_Log2Csv(0,1,"[of_process_mealdistribution] uoClientLabel.of_distribution() = -1000 "+uoClientLabel.sErrorMessage)
		
	destroy uoClientLabel // 05.12.2012 HR:
	garbagecollect()

	return -1000
else
	f_Log2Csv(0,1,"[of_process_mealdistribution] uoClientLabel.of_distribution() OK")
end if
f_Log2Csv(0,1,"[of_process_mealdistribution] uoClientLabel.of_create_cart_diagram()")	

uoClientLabel.ib_secondary_distribution_only = true

uo_documents luo_Product
integer 	li_Return

luo_Product = CREATE uo_documents

// --------------------------------------------------------------------------------------------------------------------
// 14.04.2016 HR:
// --------------------------------------------------------------------------------------------------------------------
uoClientLabel.ib_use_doc_gen_settings = TRUE
uoClientLabel.inv_doc_gen_settings.il_nenable_cart_distribution = 1
uoClientLabel.inv_doc_gen_settings.il_nenable_distribution = 1

if gi_enable_secondary_distribution = 1 then
	
	f_Log2Csv(0,1,"[of_process_mealdistribution] uoClientLabel.of_create_cart_diagram() start Secondary Distribtution")	
	
	li_Return = uoClientLabel.of_create_cart_diagram(lResult_key,  "", luo_Product, & 
													true, false, false, true, true, false, & 
													false, "", "")
	
	f_Log2Csv(0,1,"[of_process_mealdistribution] uoClientLabel.of_create_cart_diagram() end Secondary Distribtution Return: "+string(li_Return))	
End If

// --------------------------------------------------------------------------------------------------------------------
// 12.04.2018 HR: F$$HEX1$$fc00$$ENDHEX$$r UK Workorder wird eine neue  Secondary Distribtution ben$$HEX1$$f600$$ENDHEX$$tigt
// --------------------------------------------------------------------------------------------------------------------
If integer(f_mandant_profilestring(sqlca, s_app.smandant, "PPM","New2ndDistribution","0")) = 1 Then
	
	f_Log2Csv(0,1,"[of_process_mealdistribution] New Secondary Distribtution starts")
	
	ltransaction = uoClientLabel.dsCenOut.getitemnumber( 1, "ntransaction")
	
	DECLARE newDistribution PROCEDURE FOR cbase_distribution_2nd.pf_sd(:lResult_key,:ltransaction) USING sqlca;
	
	if sqlca.sqlcode < 0 then
		destroy uoClientLabel 
		destroy luo_Product
		
		f_Log2Csv(0,1,"[of_process_mealdistribution] Fehler beim Deklarieren der Funktion cbase_distribution_2nd.pf_sd: "+string(sqlca.sqlcode)+" "+f_check_null(sqlca.sqlerrtext))
		return 1
	end if
		
	EXECUTE newDistribution;
		
	if sqlca.sqlcode < 0 then
		destroy uoClientLabel 
		destroy luo_Product
		
		f_Log2Csv(0,1,"[of_process_mealdistribution] Fehler beim Ausf$$HEX1$$fc00$$ENDHEX$$hren der Funktion cbase_distribution_2nd.pf_sd: "+string(sqlca.sqlcode)+" "+f_check_null(sqlca.sqlerrtext))
		return 1
	end if
	
	close newDistribution;
	
	f_Log2Csv(0,1,"[of_process_mealdistribution] New Secondary Distribtution finished")
	
end if

f_Log2Csv(0,1,"[of_process_mealdistribution] End")	

destroy luo_Product // 15.11.2018 HR:
destroy uoClientLabel // 05.12.2012 HR:
garbagecollect()
 
return 1
end function

public function integer of_get_resultkeys (long arg_nresult_key, ref long arg_nresult_keys[]);long i, lkey

declare cenoutkeys CURSOR FOR  
  SELECT cen_out.nresult_key  
    FROM cen_out  
   WHERE cen_out.nresult_key_group in (  SELECT cen_out.nresult_key_group  
                                           FROM cen_out  
                                          WHERE cen_out.nresult_key = :arg_nresult_key
                                                 )   
ORDER BY cen_out.nleg_number ASC  ;

open cenoutkeys;

if sqlca.sqlcode<>0 then
	close cenoutkeys;
	arg_nresult_keys[1] = arg_nresult_key
	return -1
end if
i=0

do
	fetch 	cenoutkeys into :lkey;
	if sqlca.sqlcode=0 then
		i++
		arg_nresult_keys[i] =lkey
	end if
loop until sqlca.sqlcode<>0

close cenoutkeys;

return 1
end function

public function boolean wf_transfer_jfe ();
// -----------------------------------------------------------------------------------------------------------------------------------------
// Objekt : w_change_center
// Methode: wf_transfer_jfe (Function)
// Autor  :
// -----------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// -----------------------------------------------------------------------------------------------------------------------------------------
// Return: boolean
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Flugdaten in CEN_REQUEST_OUT zum JFE-Transfer
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version		Autor              			     Kommentar
// -----------------------------------------------------------------------------------------------------------------------------------------
//  04.07.2013	1.00			Thomas Brackmann		Erstellung
// -----------------------------------------------------------------------------------------------------------------------------------------

Integer			li_pos

String				ls_jfe_active
String 			ls_jfe_status_p		
String 			ls_jfe_status_p1	
String 			ls_jfe_status_p2 	
String 			ls_jfe_status_h 
String 			ls_jfe_number_h 
String				ls_cunit
String				ls_cairline
String				ls_jfe_cairlines
String				ls_jfe_cairlines_part
String				ls_cdeparture_time

DateTime		ldt_departure
DateTime		ldt_departure_diff
DateTime		ldt_now

Time				lti_departure_time
Time				lti_diff


Boolean			lbo_jfe_airline

long				ll_MasterStatus

// Basisparameter aus CEN_SETUP holen ...
ls_jfe_active 		= 	f_cen_profilestring("JFE_TRANSFER", "JFE Transfer active" ,"0")
ls_jfe_cairlines 		= 	f_cen_profilestring("JFE_TRANSFER", "Airlines" ," ")

// Wenn JFE-Transfer aktiviert und mindestens eine Airline erfasst ...
IF	Integer(ls_jfe_active) = 1 AND Len(trim(ls_jfe_cairlines)) > 0 THEN

	ls_cairline 			=  trim(	f_get_airline_name(lMasterAirlineKey))
	lbo_jfe_airline		=	FALSE

	// 25.03.2014 HR: einfachere suche
	if pos(ls_jfe_cairlines+",", ls_cairline+",")>0 then
		lbo_jfe_airline						=	TRUE
	else
		lbo_jfe_airline						=	FALSE
	end if
	
//	// Nur eine Airline ?
//	IF 	Pos(ls_jfe_cairlines,",") = 0 THEN
//	
//		// Check ob Airline dieses Fluges ...
//	
//		IF Upper(Trim(ls_jfe_cairlines)) 	= 	ls_cairline THEN
//			lbo_jfe_airline						=	TRUE
//		ELSE
//			lbo_jfe_airline						=	FALSE
//		END IF
//	
//	ELSE
//		
//		// => mehrere Airlines ...		
//		li_pos = 1
//		
//		DO UNTIL li_pos = 0 OR lbo_jfe_airline = TRUE
//	
//			// Trenner suchen ...
//			li_pos	=	Pos(ls_jfe_cairlines,",",1)
//		
//			// Gibt es einen Trenner (also noch mehr als eine Airline) ?
//			IF li_pos > 0 THEN
//	
//				// => Es gibt nur noch mehr als eine Airline ...
//				
//				// Airline ausschneiden ...
//				ls_jfe_cairlines_part =  Mid(ls_jfe_cairlines,1,li_pos -1)				
//				
//				// Wenn Airline die des Fluges -> Ok und raus ...
//				IF 	ls_cairline 		=	Upper(Trim(ls_jfe_cairlines_part)) THEN
//					lbo_jfe_airline	=	TRUE
//				ELSE
//					// Gefundene Airline aus String entfernen ...
//					ls_jfe_cairlines = Mid(ls_jfe_cairlines, li_pos + 1)				
//				END IF
//				
//			ELSE
//				
//				// Es gibt nur noch eine Airline ...
//				IF 	ls_cairline 		=	Upper(Trim(ls_jfe_cairlines)) THEN
//					lbo_jfe_airline	=	TRUE				
//				END IF
//				
//			END IF
//			
//		LOOP		
//				
//	END IF
//	
	// Wenn die Airline passt ...
	IF lbo_jfe_airline THEN
	
		ls_cunit 				= 	dw_single.GetItemString(1,"cunit")
		ll_MasterStatus		=  dw_single.GetItemNumber(1,"nstatus") // 22.07.2013 HR: Wir holen uns den aktuellen Status
		
		// ... sehen wir mal, ob auch der Status passt.
		ls_jfe_status_p		= 	f_unitprofilestring("Default","JFE_TRANSFER_P", "0", ls_cunit) 
		ls_jfe_status_p1	= 	f_unitprofilestring("Default","JFE_TRANSFER_P1","0", ls_cunit) 
		ls_jfe_status_p2 	= 	f_unitprofilestring("Default","JFE_TRANSFER_P2","0", ls_cunit) 
		ls_jfe_status_h 	= 	f_unitprofilestring("Default","JFE_TRANSFER_H",  "0", ls_cunit) 
		ls_jfe_number_h 	= 	f_unitprofilestring("Default","JFE_TRANSFER_H1","0", ls_cunit) 
		
// 22.07.2013 HR: lMasterStatus durch ll_MasterStatus ersetzt
//		IF 	(	lMasterStatus =	3	AND 	Integer(ls_jfe_status_p)		=	1	) 	OR 	&
//			(	lMasterStatus = 	4	AND	Integer(ls_jfe_status_p1) 	=	1	)	OR 	&
//			(	lMasterStatus = 	5	AND	Integer(ls_jfe_status_p2) 	=	1	)	THEN
		IF 	(	ll_MasterStatus =	3	AND 	Integer(ls_jfe_status_p)		=	1	) 	OR 	&
			(	ll_MasterStatus = 	4	AND	Integer(ls_jfe_status_p1) 	=	1	)	OR 	&
			(	ll_MasterStatus = 	5	AND	Integer(ls_jfe_status_p2) 	=	1	)	THEN	
			// Aktuelle Zeit in DateTime ...
			ldt_now					=	DateTime(Today(),Now())
			// Status stimmt auch, jetzt noch die Abflugszeit ...
			ls_cdeparture_time 	= 	dw_single.GetItemString(1,"cdeparture_time")
			lti_departure_time		=	Time(ls_cdeparture_time)
			// Abflugzeit lokal ...
			ldt_departure 			=	DateTime(ddeparture,Time(ls_cdeparture_time))
			
			// 22.07.2013 HR: Abzeit neu berechnet
			// Aktuelle Uhrzeit minus hinterlegte Stunden vor Abflug ...
			//lti_diff						=	RelativeTime ( lti_departure_time , Integer( ls_jfe_number_h ) * -3600)
			// ... ergibt DateTime
			//ldt_departure_diff		=	DateTime(Today(),lti_diff)			
			ldt_departure_diff 			= f_dt_add(ldt_departure, Integer( ls_jfe_number_h ) * -3600)
			
			// 22.07.2013 HR: So lange der Flugstatus noch nicht den obigen Pr$$HEX1$$fc00$$ENDHEX$$fungen entspricht ist die Pr$$HEX1$$fc00$$ENDHEX$$fung auf Eingabe vor Abflugszeit nicht relevant
			// Und wenn die Abfugzeit dann auch noch in dem Zeitraum liegt ...
//			IF 	ldt_now >= ldt_departure_diff	AND ldt_now <= ldt_departure THEN
			// 25.03.2014 HR: Wenn Schalter Zeiteinschr$$HEX1$$e400$$ENDHEX$$nkung aus, dann ist auch die Pr$$HEX1$$fc00$$ENDHEX$$fung unrelevant
			IF 	ldt_now >= ldt_departure_diff	 or ls_jfe_status_h ="0" THEN
				
				iuo_request_out = CREATE uo_request_out
	
				// ... dann schreiben wir Transferdaten!
				IF NOT iuo_request_out.uf_request_out_auto(lResultKey) THEN
					f_Log2Csv(0,2,"[wf_transfer_jfe] Fehler beim Transfer der JFE-Daten")
				END IF
				
				DESTROY iuo_request_out
				
			END IF
			
		END IF // IF 	( lMasterStatus = 3	...
		
	END IF // IF lbo_jfe_airline ...
		
END IF // IF	Integer(ls_jfe_active) = 1 AND Len(ls_jfe_cairlines) > 0 ...

RETURN TRUE

end function

public function integer wf_chc_retrieve_flight (long arg_lresultkey);// -----------------------------------------------------
// Zu Flugereignis
// Erstmal alle Datastores retrieven, dann 
// 
// -----------------------------------------------------
// 
long		lAircraftKey
long		lQueryID
integer	iModified
string	sQueryText

Long 		I
String	sType
// ---------------------------------------------------------------
// Reset bForceMealCalculation
// ---------------------------------------------------------------
bForceMealCalculation = false

strUserChanges	= strUserChangesEmpty

// ---------------------------------------------------------------
// Grunds$$HEX1$$e400$$ENDHEX$$tzlich mu$$HEX2$$df002000$$ENDHEX$$immer eine Mahlzeitenberechnung stattfinden,
// es sei denn, es ist ausdr$$HEX1$$fc00$$ENDHEX$$cklich unterbunden
// z.B. nach R$$HEX1$$fc00$$ENDHEX$$ckg$$HEX1$$e400$$ENDHEX$$ngigmachung einer Annullierung
// ---------------------------------------------------------------
bDoMealCalculation = true

dw_single.Reset()
dw_handling.Reset()
dw_catering_order.Reset()
dw_pax.Reset()
dw_extra	.Reset()
dw_meal	.Reset()
dw_spml.Reset()
dw_text_info.Reset()
dw_text_infos_areas.Reset()
dsSPMLDetail.Reset()
dsPackets.Reset()						// 17.05.2011 HR:

// ------------------------------------------------------------------
// Datastores zum Sichern der "alten" Mengen
// ------------------------------------------------------------------
dsExtraOld.Reset()
dsSPMLOld.Reset()
dsMealOld.Reset()
dsPaxOld	.Reset()
dsSingleOld.Reset()

// ---------------------------------------------------------------
// Retrieve
// ---------------------------------------------------------------
dw_single.retrieve(arg_lresultkey,s_app.iLanguage)
dw_handling.retrieve(arg_lresultkey,s_app.iLanguage)
dw_catering_order.Retrieve(arg_lresultkey)
dw_pax.retrieve(arg_lresultkey)
dsPackets.retrieve(arg_lresultkey)			// 17.05.2011 HR:

// ---------------------------------------------------------------
// Lesematerial wird zun$$HEX1$$e400$$ENDHEX$$chst nur im Datastore mitgef$$HEX1$$fc00$$ENDHEX$$hrt
// ---------------------------------------------------------------
//dsCenOutHandlingNews.Retrieve(arg_lresultkey)
//dsCenOutNewsExtra.Retrieve(arg_lresultkey)
// ---------------------------------------------------------------
// Extra und Mealbeladung stehen in der selben Tabellenstruktur
// nmodule_type = 1 Extrabeladung	nmodule_type = 0 Mealbeladung
// ---------------------------------------------------------------
dw_extra.retrieve(arg_lresultkey,1)
dw_meal.retrieve(arg_lresultkey,0)
dsCenOutHandlingNews.Retrieve(arg_lresultkey)
dsCenOutNewsExtra.Retrieve(arg_lresultkey)
// -------------------------------------------------------
// SPML
// -------------------------------------------------------	
dw_spml.retrieve(arg_lresultkey)
dsSPMLDetail.Reset()
// ---------------------------------------------------------------
// Sichern des urspr. Zustands f$$HEX1$$fc00$$ENDHEX$$r Alt<->Neu-Ermittlung
// ---------------------------------------------------------------
wf_chc_set_old_values()
// ---------------------------------------------------------------
// Web hat bereits in cen_out_pax die neuen Werte erfasst
// deshalb lesen der Altdaten aus Historie
// ---------------------------------------------------------------
if bReadFromHistory then
	dsPaxOld.Retrieve(arg_lresultkey)
	dsMealOld.Retrieve(arg_lresultkey,0)
	dsExtraOld.Retrieve(arg_lresultkey,1)
	dsSpmlOld.retrieve(arg_lresultkey)	
	dsSingleOld.retrieve(arg_lresultkey)	
end if
// -------------------------------------------------------
// Text Info
// -------------------------------------------------------	
dw_text_info.retrieve(arg_lresultkey)


//dw_meal.saveas("c:\temp\cbase\dw_meal.xls", Excel!, true)
//dsMealOld.saveas("c:\temp\cbase\dsMealOld.xls", Excel!, true)

// --------------------------------------------------
// 12.02.2009, KF: $$HEX1$$c400$$ENDHEX$$nderung f$$HEX1$$fc00$$ENDHEX$$r ML - Web
//					Stations-/Catererflag in den History
//					datastore $$HEX1$$fc00$$ENDHEX$$bertragen
// --------------------------------------------------
Long		lFound

For i = 1 to dw_meal.RowCount()
	lFound = dsMealOld.Find("ndetail_key=" + string(dw_meal.GetItemnumber(i, "ndetail_key")), 1, dsMealOld.RowCount() )
	
	if lFound > 0 then
		dsMealOld.SetItem(lFound, "nstationentry", dw_meal.GetItemnumber(i, "nstationentry"))
	end if 
	
Next


// --------------------------------------------------
// Retrieve Fl$$HEX1$$fc00$$ENDHEX$$ge und lokale Organisationsstruktur
// ---------------------------------------------------	
//If sViewUnit = "0000" Then
//	dw_text_infos_areas.reset()
//Else	
	dw_text_infos_areas.retrieve(arg_lresultkey)
//End if	
// ---------------------------------------------------------------
// Z$$HEX1$$e400$$ENDHEX$$hler f$$HEX1$$fc00$$ENDHEX$$r durchgef$$HEX1$$fc00$$ENDHEX$$hrte Mahlzeitenkalkulationen Resetten
// ---------------------------------------------------------------
lCalculationCounter = 0
// -------------------------------------------------------
// Query Period anzeigen
// -------------------------------------------------------	
If dw_single.Getrow() > 0 Then
	// 02.03.2006: iChangeStatus wurde nach flight-closed nicht zur$$HEX1$$fc00$$ENDHEX$$ckgesetzt
	iChangeStatus = dw_single.GetItemNumber(dw_single.Getrow(),"nstatus")
	iReleaseStatus = dw_single.GetItemNumber(dw_single.Getrow(),"nstatus_release")
	lQueryID		= dw_single.Getitemnumber(dw_single.Getrow(),"nquery")
	If lQueryID <> 0 Then
		sQueryText 	= f_get_pax_query_text(lQueryID)
		dw_single.Setitem(dw_single.Getrow(),"cquery_status",sQueryText)
		dw_single.SetItemStatus(dw_single.Getrow(),"cquery_status",Primary!,NotModified!)	
	Else
		dw_single.Setitem(dw_single.Getrow(),"cquery_status",uf.translate("Anwender"))
		//dw_single.Setitem(dw_single.Getrow(),"cquery_status","Anwender")
		dw_single.SetItemStatus(dw_single.Getrow(),"cquery_status",Primary!,NotModified!)	
	End if
End if	
// ------------------------------------------------------------------------
// Speicher Status und Annullierung Status Reset
// ------------------------------------------------------------------------
bNoSaving 			= false
bCancelAction		= false	
bNewspaperChange	= false
bTextInfoEdit 		= false
// -------------------------------------------------------------------------
// Infos zum Dirty Master Change
// -------------------------------------------------------------------------
//wf_chc_get_dirty_acchange()
//wf_chc_show_tab_picture()
// -------------------------------------------------------------------------
// Header Datwindows mit Infos versorgen
// -------------------------------------------------------------------------
//wf_chc_set_header_datawindows()
// -------------------------------------------------------------------------
// Weiterarbeit erlaubt
// -------------------------------------------------------------------------
//dw_1.enabled 	= true
//tab_1.enabled 	= true
bInAction		= false
// -------------------------------------------------------------------------
// Nachbestellbemerkung zur$$HEX1$$fc00$$ENDHEX$$cksetzen
// -------------------------------------------------------------------------
//sLateOrderComment = ""
lMasterStatus		= dw_single.GetItemNumber(1,"nstatus")

// -------------------------------------------------------------------------
// 15.04.05	G$$HEX1$$fc00$$ENDHEX$$ltige Sitzplatzversionen holen
//
// 20.10.06 Es gab eine Fehlermeldung auf diese Zeile Code 
//          mit invalid row/column specified, deshalb Abfrage
//          auf Getrow() > 0 eingebaut
// -------------------------------------------------------------------------
if dw_single.GetRow() > 0 then
	lAircraftKey	= dw_single.Getitemnumber(dw_single.Getrow(),"naircraft_key")
//	uo_configurations.uf_retrieve(lAircraftKey)
end if 

// -------------------------------------------------------------------------
// Klassenmerker f$$HEX1$$fc00$$ENDHEX$$r SPML-Eingabe zur$$HEX1$$fc00$$ENDHEX$$cksetzen
// -------------------------------------------------------------------------
lCurrentClassNumber = -1

// -------------------------------------------------------------------------
// 17.10.05	Passagiere 
// -------------------------------------------------------------------------
bPaxModified = false
bMealsCalculated = false
bManualChanges = false

Return 0

end function

public function integer of_process_auto_web_calc_cen_out (long arg_lresult_key);// ----------------------------------------------------------------------------------------
// Neuberechnung Mahlzeiten einzelnen Flug durchf$$HEX1$$fc00$$ENDHEX$$hren 
//
// Wird $$HEX1$$fc00$$ENDHEX$$ber sys_queued_flight_calc angestossen 
//   Bei interner Funktion 1 sind die neuen Daten noch nicht in den cen_out-Strukturen abgelegt
//   Bei interner Funktion 2/3 wurden neue Daten bereits in der cen_out_struktur abgelegt
//   Bei interner Funktion 3 ist ein Aircraft-Change gegeben
//   Bei interner Funktion 4 wird eine Nachkalkulation ausgef$$HEX1$$fc00$$ENDHEX$$hrt 
// 
// hier wird Historisierung und Neuberechnung der Mahlzeiten eines FLugs
// durchgef$$HEX1$$fc00$$ENDHEX$$hrt
// ----------------------------------------------------------------------------------------
long 		lCheck_nStatus, lCheck_nstatus_release, lCheck_nqueued_release_interface
String 	sFlight
long		lqueued_release_interface, lstat
String		sMessage, sType
long		l_nstatus_hist, l_nstatus_release_hist, ljob_nr, lreturn		
long 		lNull
Boolean 	bAircraftchange		
string 	sCurrentRegistration, sOldRegistration
boolean 	bOK, bOKSave
long 		lcount
	
this.ireturn_error_status  			= 0
this.sreturn_error_message 		= ""
this.sreturn_error_message_short = ""
this.is_web_message 				= "" 					//28.02.2011 HR: Fehlermeldung f$$HEX1$$fc00$$ENDHEX$$r WEBService
this.lresultkey_trace 					= arg_lresult_key
s_app.sHost 							= this.sService_Name
s_app.sMandant 						= this.sMandant

if isnull(this.sUser_Name)  then
	s_app.sUser 	= "User not filled"
else
	s_app.sUser 	= left(this.sUser_Name,15)
end if

bAircraftchange 	= False
sType 				= this.sTypeText

// --------------------------------------------------------
// Setze Aircraftchange bei Funktion 3
// --------------------------------------------------------
if this.iinternal_function = 3 then 
	bAircraftchange = True
end if
				
sFlight 							=  this.sFlightText 
lqueued_release_interface  	= this.lnew_queued_release_interface
ljob_nr 							= this.ilJobNr

if isnull(lqueued_release_interface) then lqueued_release_interface=0
	
wf_chc_trace(1,"[of_process_auto_web_calc_cen_out] ljob_nr: " + String (lJob_Nr) + " " + sFlight + " Funktion " + String(this.iinternal_function) )

of_log_jobstate(ii_log_info, uf.translate("Recalc Start")) // 12.03.2015 HR: Logging eingebaut
	
if of_lock_record(arg_lresult_key) = false then
	commit;
	this.ireturn_error_status  				= -1
	this.sreturn_error_message 			= "Flight ${" + sFlight + "} is actually locked by another user!"
	this.sreturn_error_message_short 	= "Flight is actually locked by another user!"
	this.is_web_message 					= uf.translate("Flug ist von anderem Anwender gesperrt") //28.02.2011 HR: Fehlermeldung f$$HEX1$$fc00$$ENDHEX$$r WEBService
		
	of_log_jobstate(ii_log_warning, this.is_web_message) // 12.03.2015 HR: Logging eingebaut

	f_Log2Csv(0,1,"[of_process_auto_web_calc_cen_out] "+this.sreturn_error_message)
	return -10
end if

wf_chc_retrieve_flight(arg_lresult_key)

of_retrieve_bob_figures(arg_lresult_key)

// --------------------------------------------------------------------------------------------------------------------
// 22.07.2013 HR: Variablen werden f$$HEX1$$fc00$$ENDHEX$$r JFE-Transfer ben$$HEX1$$f600$$ENDHEX$$tigt
// --------------------------------------------------------------------------------------------------------------------
lMasterAirlineKey	=  dw_single.GetItemNumber(dw_single.GetRow(), "nairline_key") 
lResultKey			=  dw_single.GetItemNumber(dw_single.GetRow(), "nresult_key") 

// 17.12.2009 HR: Mitgelieferter Status soll gesetzt werden
iChangeStatus 		= lnew_cen_out_nstatus

this.sViewUnit 		= dw_single.GetItemString(dw_single.GetRow(), "cunit")
// --------------------------------------------------------
// Merken aktuelle Werte
// --------------------------------------------------------
lCheck_nqueued_release_interface 	= dw_Single.GetItemNumber(dw_single.GetRow(),"nqueued_release_interface")
lCheck_nstatus 								= dw_Single.GetItemNumber(dw_Single.GetRow(),"nstatus")
lCheck_nstatus_release 					= dw_Single.GetItemNumber(dw_single.GetRow(),"nstatus_release")

// 19.08.2010 HR:
ii_actual_flight_status 					= lCheck_nstatus

// 09.06.2010 HR:
if isnull(lCheck_nqueued_release_interface) then lCheck_nqueued_release_interface=0

// --------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob nstatus des Flugs f$$HEX1$$fc00$$ENDHEX$$r die Verarbeitung relevant ist
// --------------------------------------------------------
if lCheck_nstatus > this.lstatus_to_process then
	
	IF	il_supplierkey = 1300 THEN // TBR 14.03.2014
		
		this.ireturn_error_status  = -1
		this.sreturn_error_message = "Flight  ${" + sFlight + "} has wrong status for processing: nstatus=" + &
							String(lCheck_nstatus) + ", sys_queue_fl_function allows until nstatus=" + String(this.lstatus_to_process)
							
		this.sreturn_error_message_short = "Flight has wrong status for processing: nstatus=" + &
							String(lCheck_nstatus) + ", sys_queue_fl_function allows until nstatus=" + String(this.lstatus_to_process)
		
		this.is_web_message = uf.translate("$$HEX1$$c400$$ENDHEX$$nderungen nicht m$$HEX1$$f600$$ENDHEX$$glich") //28.02.2011 HR: Fehlermeldung f$$HEX1$$fc00$$ENDHEX$$r WEBService
		
		of_log_jobstate(ii_log_fehler, this.is_web_message) // 12.03.2015 HR: Logging eingebaut
	
		return -1
		
	END IF
end if

// --------------------
// Hier meals
// --------------------
IF this.ii_action = 12 THEN
	of_process_meals(ljob_nr, arg_lresult_key)
	bOKSave = wf_chc_save() 
	of_check_save(bOKSave, arg_lresult_key)
	Return 1
END IF

// --------------------
// Hier freeze
// --------------------
IF this.ii_action = 15 THEN
	lreturn = of_process_freeze(ljob_nr, arg_lresult_key)
	IF lreturn = -1 THEN
		this.sreturn_error_message = ": Error freezing Flight ${" + this.sFlightText + "} !"
		this.sreturn_error_message_short = "Error freezing Flight!"
		this.is_web_message = uf.translate("Error freezing Flight")
	END IF
	Return lreturn
END IF

// --------------------
// Hier preprod-freeze
// --------------------
IF this.ii_action = 17 THEN
	lreturn = of_process_preprod_freeze(ljob_nr, arg_lresult_key)
	IF lreturn = -1 THEN
		this.sreturn_error_message = ": Error freezing preprod Flight ${" + this.sFlightText + "} !"
		this.sreturn_error_message_short = "Error freezing preprod Flight!"
		this.is_web_message = uf.translate("Error freezing preprod Flight")
	END IF
	Return lreturn
END IF

if (this.iinternal_function = 2 or this.iinternal_function = 3 ) then
	// --------------------------------------------------------
	// Pr$$HEX1$$fc00$$ENDHEX$$fen, ob nqueued_release_interface noch relevant ist
	// (bei Aufruf $$HEX1$$fc00$$ENDHEX$$ber Webservice wird dies nicht gepr$$HEX1$$fc00$$ENDHEX$$ft)
	// --------------------------------------------------------
	if not this.bWebservice then
	 	if lCheck_nqueued_release_interface <> this.lfunction_queued_release_interface then
			this.ireturn_error_status  = -1
			this.sreturn_error_message = "Value of nqueued_release_interface (" + String( lCheck_nqueued_release_interface) + &
							") for flight ${" + sFlight + "} has not the origin value! ("+ &
							String(this.lfunction_queued_release_interface ) + ")"
			this.sreturn_error_message_short = "Value of nqueued_release_interface (" + String( lCheck_nqueued_release_interface) + &
							") for flight has not the origin value! ("+ &
							String(this.lfunction_queued_release_interface ) + ")"

			is_web_message = "Flight  has not the origin value"
			
			of_log_jobstate(ii_log_fehler, this.is_web_message) // 12.03.2015 HR: Logging eingebaut
			
			return -1
		end if
 	end if
end if

// --------------------------------------------------------
// Merken Status aus Historie, zum zur$$HEX1$$fc00$$ENDHEX$$ckschreiben, bei Fehlern
// --------------------------------------------------------
if dsSingleOld.RowCount() > 0 then
	l_nstatus_hist 				= dsSingleOld.GetItemNumber(dsSingleOld.Getrow(), "nstatus")
	l_nstatus_release_hist 	= dsSingleOld.GetItemNumber(dsSingleOld.Getrow(), "nstatus_release")
else
	
	f_Log2Csv(0,1,"[of_process_auto_web_calc_cen_out] no history record found for {" + sFlight + "}, default used")
	l_nstatus_hist = 1
	l_nstatus_release_hist = 0
end if

// --------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fen ob in der Tabelle sys_queue_flight_pax Pax-$$HEX1$$c400$$ENDHEX$$nderungen $$HEX1$$fc00$$ENDHEX$$bergeben wurden
// $$HEX1$$c400$$ENDHEX$$nderungen werden in dw_pax eingearbeitet
// --------------------------------------------------------
if of_get_sys_flight_pax(ljob_nr) = -1 then
	 f_Log2Csv(0,1,"[of_process_auto_web_calc_cen_out] Error for flight " + sFlight + " in using pax data of of_get_sys_flight_pax!")
end if

// --------------------------------------------------------------------------------
// 12.11.2009 HR: Pr$$HEX1$$fc00$$ENDHEX$$fen, ob die Final fehlen
// --------------------------------------------------------------------------------
of_check_finals()

// --------------------------------------------------------
// Falls Pax-felder anstelle anderer Felder genutzt werden sollen, so erfolgt hier ggf. die Umsetzung
//
// --------------------------------------------------------
if this.ifunction_pax_type <>  this.ifunction_use_as_pax_type then
	 of_pax_type_transfer()
end if

// --------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fen ob in der Tabelle sys_queue_flight_actype Aircraft-$$HEX1$$c400$$ENDHEX$$nderungen $$HEX1$$fc00$$ENDHEX$$bergeben wurden
// $$HEX1$$c400$$ENDHEX$$nderungen werden in dw_single eingearbeitet
// --------------------------------------------------------
lreturn = of_get_sys_flight_actype(ljob_nr) 
if lreturn = -1 then
	 f_Log2Csv(0,1,"[of_process_auto_web_calc_cen_out] Error for flight " + sFlight + " in using aircraftdata of of_get_sys_flight_actype!")
else
	if lreturn = 1 then
		// --------------------------------------------------------
		// Setze Aircraftchange
		// --------------------------------------------------------
		if bAircraftchange = False then
			f_Log2Csv(0,1,"[of_process_auto_web_calc_cen_out] Set flight  " + sFlight + " to aircraft change due to changed aircraftdata")
			bAircraftchange = True
		end if
		
	elseif lreturn = 2 then
		// eine $$HEX1$$c400$$ENDHEX$$nderung der Registration erfolgte
	end if
end if

// --------------------------------------------------------
// Falls Versions-felder anstelle anderer Felder genutzt werden sollen, so erfolgt hier ggf. die Umsetzung
// --------------------------------------------------------
if this.ifunction_actype <>  this.ifunction_use_as_actype then
	 of_version_type_transfer()
end if

// --------------------------------------------------------------------------------------------------------------------
// 11.08.2014 HR: Webfehler 2013-50 - No History for Tailnumber
// --------------------------------------------------------------------------------------------------------------------
sCurrentRegistration = dw_single.GetItemString(dw_single.Getrow(),"cregistration")
if isnull(sCurrentRegistration) then sCurrentRegistration = ""

// 23.09.2014 HR:
if dssingleOld.Getrow() > 0 then
	sOldRegistration = dssingleold.GetItemString(dssingleOld.Getrow(),"cregistration")
else
	sOldRegistration = ""
end if

if isnull(sOldRegistration) then sOldRegistration = ""
If sOldRegistration <> sCurrentRegistration Then
	// Beim Registrationm Change immer Gewichte schicken. Wenn sich der AC-Type nicht ge$$HEX1$$e400$$ENDHEX$$ndert hat, haben sich zwar auch die Gewichte
	// nicht ge$$HEX1$$e400$$ENDHEX$$ndert, aber bei einem Regitration-Change schmeisst ALTEA seine Gewichtsdaten weg und hat dann keine mehr
	ib_wab_send = True
	wf_chc_show_changes(dw_single,"cregistration",dw_single.Getrow())
	dw_single.SetItemStatus(dw_single.Getrow(),"cregistration", primary!, DataModified!)
	f_Log2Csv(0,1,"[of_process_auto_web_calc_cen_out] Registration is changed.")
	of_log_jobstate(ii_log_info, uf.translate("Registration ge$$HEX1$$e400$$ENDHEX$$ndert")) // 12.03.2015 HR: Logging eingebaut
End if

// --------------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fen ob in der Tabelle sys_queue_flight_spml  Spml-$$HEX1$$c400$$ENDHEX$$nderungen $$HEX1$$fc00$$ENDHEX$$bergeben wurden
// $$HEX1$$c400$$ENDHEX$$nderungen werden in dw_spml eingearbeitet
// --------------------------------------------------------
if of_get_sys_flight_spml(ljob_nr) = -1 then
	 f_Log2Csv(0,1,"[of_process_auto_web_calc_cen_out] "+Stype + ": Error for flight " + sFlight + " in using SPML data of of_get_sys_flight_spml!")
end if

lResultKey_Trace 			= arg_lresult_key
ddeparture 					= date(dw_single.GetItemDatetime(dw_single.GetRow(), "ddeparture"))

// TLE130309 Merken des Timesstamps welcher von der Web-Applikation gesetzt wurde
dtTimestampFromWeb	=dw_single.GetitemDateTime(dw_single.getrow(),"dtimestamp")

// --------------------------------------------------------
// Verarbeitung Neuberechnung Mahlzeiten wegen ver$$HEX1$$e400$$ENDHEX$$nderter Pax/SPML-Daten
// --------------------------------------------------------
// 09.10.2015 HR: (#5.20 - 114) Wir m$$HEX1$$fc00$$ENDHEX$$ssen immer eine komplette Berechnung des Fluges durchf$$HEX1$$fc00$$ENDHEX$$hren
//if  not bAircraftchange  then // Flug-Neurechnung
if 1=1 then 
	wf_chc_trace(50,"[of_process_auto_web_calc_cen_out] Web processing for "+sFlight)
	wf_chc_get_differences(arg_lresult_key)

	//LT290708 Flug immer neu durchrechnen, falls Zuordnung zu cen_meals_detail nicht mehr passt.
	if not bForceMealCalculation then
		select count(*)  into :lcount
			from cen_out_meals 
			where nresult_key = :arg_lresult_key
				and nmodule_type = 0
				and not exists (select nhandling_detail_key 
									from cen_meals_detail
								where cen_meals_detail.nhandling_detail_key = cen_out_meals.nhandling_detail_key);	
		if sqlca.sqlcode = 0 then
			if  lcount > 0 then
				 f_Log2Csv(0,1,"[of_process_auto_web_calc_cen_out] Forced meal recalculation for flight " + sFlight + " due to invalid meal definiton references!")
				bForceMealCalculation = True
			end if
		else	
			f_Log2Csv(0,1,"[of_process_auto_web_calc_cen_out]  SQL-Error for selection of invalid meal definiton references for flight " + sFlight + " !"+String(sqlca.sqlcode))
	
		end if
	end if
	
	bOK =True
	if bDoAllwaysMealCalc then 
		 f_Log2Csv(0,1,"[of_process_auto_web_calc_cen_out]  Forced meal recalculation for flight " + sFlight + ", although there were no changes !")
			
		bForceMealCalculation = True
	end if
	
	if bForceMealCalculation then
		
			bOK = wf_chc_master_change() 
	end if
	
	if bOK then
		// ------------------------------------------------------------------
		// TLE 21.01.2010 Bei Nachkalkulation gibt es ein eigenes Verfahren
		// ------------------------------------------------------------------
		if   this.iinternal_function = 4 then		//Nachkalkulation
			bOKSave = of_recalc_save()
		else						
			bOKSave = wf_chc_save() 
		end if
		
		of_check_save(bOKSave, arg_lresult_key)
		
	else
			this.ireturn_error_status  = -1
			this.sreturn_error_message = ": Error for flight ${" + sFlight + "} in wf_chc_master_change "
			this.sreturn_error_message_short = ": Error in wf_chc_master_change "
			
			// --------------------------------------------------------------------------------------------------------------------
			// damit der Flug nicht immer wieder verarbeitet wird, auf Fehlerfall setzen
			// 29.11.2011 HR: Aber nur f$$HEX1$$fc00$$ENDHEX$$r ML-Fl$$HEX1$$fc00$$ENDHEX$$ge
			// --------------------------------------------------------------------------------------------------------------------
			if il_supplierkey <> 1300 then
				lstat = i_Status_Queued_Errors
				update cen_out 
					set nqueued_release_interface = :lstat,
									nstatus =  :l_nstatus_hist,
								nstatus_release = :l_nstatus_release_hist
				 where nresult_key = :arg_lresult_key; 
				 
				 if sqlca.sqlcode <> 0 then
						 this.sreturn_error_message += ": Database error: " + sqlca.sqlerrtext
						 this.sreturn_error_message_short += ": Database error: " + sqlca.sqlerrtext
				 end if
				
				// lcounter_processed_input_f ++
				commit;
			end if
	end if

// --------------------------------------------------------
// Verarbeitung A/C-Change im WEB
// --------------------------------------------------------
else  	 // Web_MasterChange
	
	// --------------------------------------------------------------------------------------------------------------------
	// 02.09.2015 HR: Der Teil hier hat keinen Multilegchange gemacht sondern nur versucht einen 
	//                        AC-Change f$$HEX1$$fc00$$ENDHEX$$r das aktuelles LEG durchzuf$$HEX1$$fc00$$ENDHEX$$hren (Fehlerhafte AC-Ermittlung). 
	//                        Die $$HEX1$$c400$$ENDHEX$$nderungen am AC-Type wurden aber bereits oben durchgef$$HEX1$$fc00$$ENDHEX$$hrt, daher reicht es, 
	//                        wenn wir hier nur speichern
	// --------------------------------------------------------------------------------------------------------------------
	
	bOKSave = wf_chc_save() 
	of_check_save(bOKSave, arg_lresult_key)
	Return 1

end if	

return 1

end function

public subroutine wf_check_pax_comment_changed ();
// -----------------------------------------------------------------------------------------------------------------------------------------
// Objekt : w_change_center
// Methode: wf_check_pax_comment_changed (Function)
// Autor  :
// -----------------------------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// -----------------------------------------------------------------------------------------------------------------------------------------
// Return: none
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Check, ob in dw_pax Paxzahlen und/oder Kommentare ge$$HEX1$$e400$$ENDHEX$$ndert wurden
// -----------------------------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    	     Version		Autor              			     Kommentar
// -----------------------------------------------------------------------------------------------------------------------------------------
//  09.07.2013	1.00			Thomas Brackmann		Erstellung
// -----------------------------------------------------------------------------------------------------------------------------------------

Long				ll_rownum

Integer			li_npax_old
Integer			li_npax

String				ls_ccomment_old
String				ls_ccomment

// 25.04.2014 HR: Wenn schon true (Statuschange), dann direkt wieder raus
if ibo_changed then return 

// Wurden $$HEX1$$fc00$$ENDHEX$$berhaupt Paxzahlen und/oder Kommentare ge$$HEX1$$e400$$ENDHEX$$ndert  ?
IF 	dw_pax.RowCount() > 0 THEN

	dw_pax.AcceptText()
	
// 25.04.2014 HR: Auf den Anfang von WF_SAVE gesetzt (4.99-093)
//	ibo_changed 	= 	FALSE
	ll_rownum 		= 	1
	
	DO
		// Alt-/Neu Vergleich ...(seltsamerweise bringt der GetItemNumber 
		// bei npax trotz "Primary!,TRUE" auch den neuen Wert)
		li_npax_old				=		dw_pax.GetItemNumber(ll_rownum,"npax_old")
		li_npax					=		dw_pax.GetItemNumber(ll_rownum,"npax")
		ls_ccomment_old		=		dw_pax.GetItemString(ll_rownum,"ccomment",Primary!,TRUE)
		ls_ccomment			=		dw_pax.GetItemString(ll_rownum,"ccomment",Primary!,FALSE)
		
		IF IsNull(ls_ccomment_old) 	THEN 	ls_ccomment_old = ""
		IF IsNull(ls_ccomment) 		THEN 	ls_ccomment = ""		
		
		// Wenn was ge$$HEX1$$e400$$ENDHEX$$ndert wurde -> Merker setzten und raus ...
		IF 	li_npax_old 			<> 	li_npax 			OR &
			ls_ccomment_old	<> 	ls_ccomment 	THEN
			ibo_changed 		 = 		TRUE
			EXIT
		END IF
		
		ll_rownum = ll_rownum + 1
		
	LOOP UNTIL ll_rownum > dw_pax.RowCOunt() 
	
END IF // IF 	dw_pax.RowCOunt() > 0

end subroutine

public function integer wf_tailnumber_checkoff (long arg_nairline_key);// --------------------------------------------------------------------------------------------------------------------
// Objekt : w_change_center
// Methode: wf_tailnumber_checkoff (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_nairline_key
// --------------------------------------------------------------------------------------------------------------------
// Return: integer 
//              1: Pr$$HEX1$$fc00$$ENDHEX$$fung der Registration bei FlightClosed ist ausgeschaltet
//              0: Die Registrationpr$$HEX1$$fc00$$ENDHEX$$fung bei FlightClosed ist aktiv
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: List aus den CEN_AIRLINES den Schalter NTAILNUMBER_CHECKOFF
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  25.09.2013	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------
integer li_ret

select NTAILNUMBER_CHECKOFF
into :li_ret
from cen_airlines
where nairline_key = :arg_nairline_key;

if sqlca.sqlcode=100 then
	li_ret =0
elseif sqlca.sqlcode<0 then
	li_ret =0
end if

return li_ret
end function

public function boolean of_check_do_aenderungsmitteilung ();string ls_cunit
long ll_supplier
DateTime			dtCheckdate


ls_cunit = dw_single.getitemstring(1,"cunit")

dtCheckdate		= DateTime(Date(dw_single.GetitemDateTime(1,"ddeparture")), + &
								  Time(dw_single.GetitemString(1,"cdeparture_time")))


// F$$HEX1$$fc00$$ENDHEX$$r Monalisa Istdatenbrowser gilt : generell  keine $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen verschicken
SELECT sys_units.nsupplier_key  
    INTO :ll_supplier  
    FROM cbase.sys_units  
   WHERE sys_units.cunit = :ls_cunit   ;

if ll_supplier <> 1300 then
	wf_chc_trace(10,"[of_check_do_aenderungsmitteilung] Keine $$HEX1$$c400$$ENDHEX$$nderungsmitteilung f$$HEX1$$fc00$$ENDHEX$$r ML-Fl$$HEX1$$fc00$$ENDHEX$$ge")
	
	of_log_jobstate(ii_log_warning, uf.translate("Keine $$HEX1$$c400$$ENDHEX$$nderungsmitteilung f$$HEX1$$fc00$$ENDHEX$$r ML-Fl$$HEX1$$fc00$$ENDHEX$$ge")) // 12.03.2015 HR: Logging eingebaut
	
	return true
end if

if DateTime(Today(),Now()) > dtCheckdate Then
	wf_chc_trace(10,"[of_check_do_aenderungsmitteilung] Keine $$HEX1$$c400$$ENDHEX$$nderungsmitteilung da nach Abflug")

	of_log_jobstate(ii_log_warning, uf.translate("Keine $$HEX1$$c400$$ENDHEX$$nderungsmitteilung da nach Abflug")) // 12.03.2015 HR: Logging eingebaut

	return true
end if


return false
end function

public function integer of_retrieve_dsjobs_new (datetime ddate);/* 
* Funktion:			of_retrieve_dsjobs
* Beschreibung: 	 Einstiegsfunktion
* Besonderheit: 	
*
* Argumente:
*
* Aenderungshistorie:
* 	Version 	Wer					Wann			Was und warum
*	2.0		Thomas Schaefer	08.08.2016	Neuer Process-Status 4 (=retry), also beim L$$HEX1$$f600$$ENDHEX$$schen auf >4 pr$$HEX1$$fc00$$ENDHEX$$fen anstatt >3
*
* Return Codes:
*	 -1		fehler
* 	1		sonst
*
*/

Long 			lRows, lRow, lRow2, llRow2
Long			lStatus[]
String			sFlight
Long 			lStart, lStop, lSequence, lqueued_release_interface, lstation_entry
Integer  		iSuccess
long	 		iRet, i ,i1,i2, icount, j
Integer 		iFunction
DateTime 	dtNow
Long			lNull, lfound
String			sNull, sRunning 
string 		sNO
datastore 	lds_jobs, lds_instances

// -------------------------------------------------
// Einlesen der m$$HEX1$$f600$$ENDHEX$$glichen Funktionen und Zuordnung zur internen Verarbeitung
// -------------------------------------------------
dsSysQueueFunctions.retrieve()
if dsSysQueueFunctions.RowCount() <= 0 then
		// -------------------------------------------------
		// keine S$$HEX1$$e400$$ENDHEX$$tze vorhanden: Meldung ausgeben und Abbruch
		// -------------------------------------------------
		
		f_log2csv(0,2,"[of_retrieve_dsjobs_new] no functions in sys_queue_fl_functions found, no processing possible" )
		return -1
end if

iNumberOfCalculationsToProcess = 10 * gi_max_jobs_to_distribute

dsJobs.DataObject = "dw_job_list_instance"
dsJobs.settransobject(SQLCA)

// --------------------------------------------------------------------------------------------------------------------
//  Wenn nicht Master, dann lesen wir nur die JOBS
// --------------------------------------------------------------------------------------------------------------------
if not gbMaster then
	dsJobs.retrieve(sInstance)

	return 1
end if

// --------------------------------------------------------------------------------------------------------------------
// 29.06.2015 HR: Wir l$$HEX1$$f600$$ENDHEX$$schen erledigte Auftr$$HEX1$$e400$$ENDHEX$$ge aus der QUEUE
// --------------------------------------------------------------------------------------------------------------------
  DELETE FROM sys_queue_flight_calc  
   WHERE ( sys_queue_flight_calc.dstop_computing < sysdate - :ii_del_offset_ok ) AND  
         ( sys_queue_flight_calc.nprocess_status = 3 ) AND  
         ( rownum <= 1000 );

f_log2csv(0,2,"[of_retrieve_dsjobs_new] Delete "+string(sqlca.sqlnrows)+" old Jobs older "+string(ii_del_offset_ok)+" days: "+string(sqlca.sqlcode) )

// --------------------------------------------------------------------------------------------------------------------
// 29.06.2015 HR: Wir l$$HEX1$$f600$$ENDHEX$$schen auch fehlerhafte Auftr$$HEX1$$e400$$ENDHEX$$ge aus der QUEUE
// --------------------------------------------------------------------------------------------------------------------
  DELETE FROM sys_queue_flight_calc  
   WHERE ( sys_queue_flight_calc.dstop_computing < sysdate - :ii_del_offset_fehler ) AND  
         ( sys_queue_flight_calc.nprocess_status > 4 ) AND  
         ( rownum <= 1000 );

f_log2csv(0,2,"[of_retrieve_dsjobs_new] Delete "+string(sqlca.sqlnrows)+" old Jobs with errors older "+string(ii_del_offset_fehler)+" days: "+string(sqlca.sqlcode) )

// --------------------------------------------------------------------------------------------------------------------
// 09.01.2017 HR: Wir l$$HEX1$$f600$$ENDHEX$$schen auch noch Auftr$$HEX1$$e400$$ENDHEX$$ge, die keinen CEN_OUT-Bezug mehr haben
// --------------------------------------------------------------------------------------------------------------------
delete from sys_queue_flight_calc where sys_queue_flight_calc.NJOB_NR in (
select FC.NJOB_NR from sys_queue_flight_calc fc left outer join cen_out co on FC.NRESULT_KEY = CO.NRESULT_KEY
where CO.NRESULT_KEY is null AND rownum <= 1000);

f_log2csv(0,2,"[of_retrieve_dsjobs_new] Delete "+string(sqlca.sqlnrows)+" Jobs without reference to CEN_OUT: "+string(sqlca.sqlcode) )

lds_instances 					= create datastore
lds_instances.dataobject 	= "dw_job_instances"
lds_instances.settransobject(SQLCA)
icount = lds_instances.retrieve()

lds_instances.setfilter("nanz < "+string(gi_max_jobs_to_distribute))
lds_instances.filter()

// --------------------------------------------------------------------------------------------------------------------
// 14.11.2018 HR: Wir pr$$HEX1$$fc00$$ENDHEX$$fen hier ob die Anzahl Instanzen noch korrekt ist, ansonsten speichern wir 
//                        den aktuellen Wert
// --------------------------------------------------------------------------------------------------------------------
string a
a = f_mandant_profilestring( sqlca, s_app.smandant, "FlightCalculator","AnzahlInstanzen", "6") 
if integer(a) <> icount then
	f_mandant_setprofilestring( sqlca, s_app.smandant, "FlightCalculator","AnzahlInstanzen", string(icount)) 
end if

if lds_instances.rowcount()=0 then
	destroy lds_instances
	
	f_log2csv(0,2,"[of_retrieve_dsjobs_new] No Instances with capacity found" )
	
	dsJobs.retrieve(sInstance)
	
	return 1
end if

/* Funktionen:
1: Alles rechnen in Abh. der Zusatz-Tabellen (PAX/SPML/ACTYPE)
2: Web-Anstoss $$HEX1$$fc00$$ENDHEX$$ber nqueued_release_interface = 4 (Mit History)
3: Web-Anstoss mit Aircraft-Change $$HEX1$$fc00$$ENDHEX$$ber nqueued_release_interface = 5 (Mit History)
4: SPML-AMOS $$HEX1$$fc00$$ENDHEX$$ber nqueued_release_interface = 7 (Mit History)
5: rechnen automat. Abrechn. ??? 
6: LCL-Flug, Alles rechnen in Abh. der Zusatz-Tabellen (PAX/SPML/ACTYPE)

*/  

setNull(sNull)
setNull(lNull)
	
dtNow = datetime(date(today()),time(now()))

// -------------------------------------------------
// Pr$$HEX1$$fc00$$ENDHEX$$fe ob S$$HEX1$$e400$$ENDHEX$$tze $$HEX1$$fc00$$ENDHEX$$ber cen_out_nqueued_release_interface zur Verarbeitung anstehen:
//   ggf. Eintrag in sys_queue_flight_calc zur zentralen Abarbeitung
// -------------------------------------------------
if 	gbReadCenOut then
	// -----------------------------------------------
	// Jobliste retrieven in Abh. von Datum und zugelassenen Funktionen
	// -----------------------------------------------
	this.dCheckDate = dDate	
	this.iProcessFunction[1] = -1
	
	this.dsJobs.Retrieve(this.iProcessFunction, sInstance)
	i = 1
	For I1 = 1 to  dsSysQueueFunctions.RowCount() 
		// -------------------------------------------------
		// Relevant sind nur Eintr$$HEX1$$e400$$ENDHEX$$ge mit interner Funktion 2
		// -------------------------------------------------
		if dsSysQueueFunctions.getItemNumber(I1, "ninternal_function") = 2 then
			lqueued_release_interface = dsSysQueueFunctions.getItemNumber(I1, "nqueued_release_interface")
			ifunction = dsSysQueueFunctions.getItemNumber(I1, "nfunction")

			if not isnull(lqueued_release_interface) then
				// -------------------------------------------------
				// in lStatus werden nqueued_release_interface - Werte abgelegt
				// -------------------------------------------------
		
				lStatus[i] = lqueued_release_interface
				i++
			end if
		end if
	Next
	
	if upperbound(lstatus) > 0 then
		// -------------------------------------------------
		// Einlesen aller CenOut-S$$HEX1$$e400$$ENDHEX$$tze zu Status
		// -------------------------------------------------	
		dsCenOut.Retrieve(lstatus[])
	
		lRows = dsCenOut.RowCount()
		for lrow = 1 to lrows
			// -------------------------------------------------
			// Pr$$HEX1$$fc00$$ENDHEX$$fe ob nresult_key bereits zur Abarbeitung ansteht
			// wenn ja, keine Aktion, sonst einf$$HEX1$$fc00$$ENDHEX$$gen
			// -------------------------------------------------
			lfound = dsJobs.Find("nresult_key = " + String(dsCenOut.GetItemNumber(lrow,"nresult_key")) + & 
						" and nfunction = " + String(ifunction) ,1,dsJobs.RowCount())
			if lfound = 0 then
				// -------------------------------------------------
				// Eintrag in sys_queue_flight_calc einf$$HEX1$$fc00$$ENDHEX$$gen
				// -------------------------------------------------
			
				lSequence = f_Sequence("seq_sys_queue_flight_calc", sqlca)
				If lSequence = -1 Then
					f_log2csv(0,2,"[of_retrieve_dsjobs_new] Sequence Error: seq_sys_queue_flight_calc")
				else
					lrow2=dsSysQueueFlightCalc.insertRow(0)
					dsSysQueueFlightCalc.SetItem(lrow2,"njob_nr",lsequence)
					dsSysQueueFlightCalc.SetItem(lrow2,"nresult_key",dsCenOut.GetItemNumber(lrow,"nresult_key"))
					dsSysQueueFlightCalc.SetItem(lrow2,"ddeparture",dsCenOut.GetItemDatetime(lrow,"ddeparture"))
					dsSysQueueFlightCalc.SetItem(lrow2,"dcreated",dtNow) 		
					dsSysQueueFlightCalc.SetItem(lrow2,"nstatus",lNull)
					dsSysQueueFlightCalc.setitem(1,"nprocess_status",0)    //28.11.2011 HR:
					
		
					lqueued_release_interface = dsCenOut.GetItemNumber(lrow,"nqueued_release_interface") 
					
					lfound =  dsSysQueueFunctions.find("nqueued_release_interface = " + String(lqueued_release_interface), 1, &
								dsSysQueueFunctions.RowCount())
								
					if lfound > 0 then
						ifunction = dsSysQueueFunctions.getItemNumber(lfound, "nfunction")
					else
						ifunction = 0
					end if
					
		 			dsSysQueueFlightCalc.SetItem(lrow2,"nfunction",ifunction)
					dsSysQueueFlightCalc.SetItem(lrow2,"nerror",lNull)
					dsSysQueueFlightCalc.SetItem(lrow2,"cerror",sNull)
					dsSysQueueFlightCalc.SetItem(lrow2,"cinstance",sNull)
					dsSysQueueFlightCalc.SetItem(lrow2,"cmodified",sNull)
					dsSysQueueFlightCalc.SetItem(lrow2,"cuser",sNull)
					dsSysQueueFlightCalc.SetItem(lrow2,"nqueued_release_interface",0)
					dsSysQueueFlightCalc.SetItem(lrow2,"nhistory",lNull)

					dw_pax.retrieve(dsCenOut.GetItemNumber(lrow,"nresult_key"))
					lstation_entry = 0
					if dw_pax.RowCount() > 0 then
						lstation_entry = dw_pax.GetItemNumber(1,"nstationentry") 
					end if

					dsSysQueueFlightCalc.SetItem(lrow2,"nstation_entry", lstation_entry)
		
					sFlight = dsCenOut.GetItemString(lrow, "cairline") +  String(dsCenOut.GetItemnumber(lrow, "nflight_number")) + &
					dsCenOut.GetItemString(lrow, "csuffix") + " vom " + String(dsCenout.GetItemDatetime(lrow, "ddeparture"),"DD.MM.YYYY" ) + &
						" / " + dsCenOut.GetItemString(lrow, "cunit") + "(" + String(dsCenOut.GetItemNumber(lrow, "nresult_key")) + ")" 
   	
					f_log2csv(0,2,"[of_retrieve_dsjobs_new] Insert into sys_queue_flight_calc job_id "  + string(lsequence) + "nfunction " + &
						String(ifunction) + " Flug " + sFlight + " (cen_out_nqueued_release_interface= " + String(lqueued_release_interface) +")")
				
				end if
		
			end if
		Next
		if lRows > 0 then
			If dsSysQueueFlightCalc.Update() <> 1 Then
				rollback ;
				f_log2csv(0,2,"[of_retrieve_dsjobs_new] Fehler beim Speichern in sys_queue_flight_calc aus cen_out  ")
			else
				f_log2csv(0,1,"[of_retrieve_dsjobs_new] Erfolgreiches Einf$$HEX1$$fc00$$ENDHEX$$gen in sys_queue_flight_calc job_id aus cen_out (" + String(lrows) + " S$$HEX1$$e400$$ENDHEX$$tze)" )	

			end if	
		else
			f_log2csv(0,1,"[of_retrieve_dsjobs_new] keine Daten in cen_out relevant  ")	
		end if
		commit;
	end if	
end if

lds_jobs 					= create datastore
lds_jobs.dataobject 	= "dw_job_list_open"
lds_jobs.settransobject(SQLCA)
lds_jobs.retrieve()

if lds_jobs.rowcount()=0 then
	destroy lds_instances
	destroy lds_jobs
	
	f_log2csv(0,2,"[of_retrieve_dsjobs_new] No open jobs to distribute found" )
	
	dsJobs.retrieve(sInstance)
	
	return 1
end if

f_log2csv(0,2,"[of_retrieve_dsjobs_new] Found "+string( lds_jobs.rowcount())+" open Jobs.")


iCount = 0
sNO = "nprocess_status = 0"
For i = 1 to lds_jobs.RowCount()
	// 09.11.2018 HR: Wenn schon zugeordnet, dann zum n$$HEX1$$e400$$ENDHEX$$chsten
	if lds_jobs.GetItemNumber(i,"nprocess_status") = 1 then continue
	
	if lds_instances.setfilter("nfunction"+string(lds_jobs.GetItemNumber(i, "nfunction"))+"=1 and  nanz < "+string(gi_max_jobs_to_distribute)) <> 1 then
		f_log2csv(this.ilJobNr,2,"[of_retrieve_dsjobs_new] Fehler Setfilter DW_JOB_INSTANCES (nfunction"+string(lds_jobs.GetItemNumber(i, "nfunction"))+"=1 and  nanz < "+string(gi_max_jobs_to_distribute)+")")
	end if
	
	lds_instances.filter()
	lds_instances.sort()

	if lds_instances.rowcount()=0 then
		
		// --------------------------------------------------------------------------------------------------------------------
		// 18.06.2018 HR: Optimierte Verteilung, wenn f$$HEX1$$fc00$$ENDHEX$$r eine Funktion keine Kapazit$$HEX1$$e400$$ENDHEX$$ten mehr verf$$HEX1$$fc00$$ENDHEX$$gbar sind,
		//                        dann k$$HEX1$$f600$$ENDHEX$$nnen wir alle Jobs dieser Funktion auch ausblenden
		// --------------------------------------------------------------------------------------------------------------------
		/*
		if sNO=""  or pos(sNO, " "+string(lds_jobs.GetItemNumber(i, "nfunction"))+",")=0 then
			f_log2csv(this.ilJobNr,2,"[of_retrieve_dsjobs_new] No more Instance with capacity for Function "+string(lds_jobs.GetItemNumber(i, "nfunction")) +" found")
			sNO +=  " "+string(lds_jobs.GetItemNumber(i, "nfunction"))+","
		end if
		continue
		*/

		sNO += " and nfunction <> " + string(lds_jobs.GetItemNumber(i, "nfunction"))
		
		f_log2csv(this.ilJobNr,2,"[of_retrieve_dsjobs_new] No more Instance with capacity for Function "+string(lds_jobs.GetItemNumber(i, "nfunction")) +" found")
			
		lds_jobs.setfilter(sNO)
		lds_jobs.filter()
		
		if lds_jobs.rowcount()=0 then
			f_log2csv(this.ilJobNr,2,"[of_retrieve_dsjobs_new] No more Jobs for Instances with capacity.")
			exit
		end if
		i = 0
		continue
	end if
	
	if lds_jobs.GetItemNumber(i, "nfunction") <> 10 and ii_use_mzvspawn <> 1 then lds_jobs.SetItem(i,"dstart_computing", dtNow) // 08.05.2013 HR: bei 10 wird das Datum beim Externen Programmstart gesetzt
	
	lds_jobs.SetItem(i,"cinstance", lds_instances.getitemstring(1, "cinstance") )
	lds_jobs.SetItem(i,"nprocess_status",1) // 28.11.2011 HR:

	llRow2 =  lds_instances.getitemnumber(1, "nanz")
	
	// Wenn Master-Instanz auch Jobs erh$$HEX1$$e400$$ENDHEX$$lt oder Instance beide Jobtypen macht, dann nur die H$$HEX1$$e400$$ENDHEX$$lfte der anderen, dass sie schneller wieder zuordnen kann
	if sinstance = 	lds_instances.getitemstring(1, "cinstance")  then 
		llRow2++
	end if
	
	if i < lds_jobs.rowcount() then
		// --------------------------------------------------------------------------------------------------------------------
		// 09.11.2018 HR: Wir schauen nach, ob es f$$HEX1$$fc00$$ENDHEX$$r den Flug noch einen Job gleichen Types gibt, dann setzen
		//                        wir ihn auf die gleiche Instanz
		// --------------------------------------------------------------------------------------------------------------------
		for j = i + 1 to lds_jobs.rowcount() 
			if lds_jobs.GetItemNumber(i,"nresult_key") =  lds_jobs.GetItemNumber(j,"nresult_key") AND lds_jobs.GetItemNumber(i,"nfunction") =  lds_jobs.GetItemNumber(j,"nfunction") then
				lds_jobs.SetItem(j,"cinstance", lds_instances.getitemstring(1, "cinstance") )
				lds_jobs.SetItem(j,"nprocess_status",1) 
				llRow2++
				iCount ++
			end if
		next
	end if
	
	lds_instances.setitem(1, "nanz", llRow2 +1)
	
	iCount ++
	
	lds_instances.setfilter("nanz < "+string(gi_max_jobs_to_distribute))
	lds_instances.filter()
	lds_instances.sort()

	if lds_instances.rowcount()=0 then exit
Next

lds_jobs.setfilter("")
lds_jobs.filter()
// -----------------------------------------------------------------
// Erst stempeln, dann speichern
// -----------------------------------------------------------------
If lds_jobs.update() <> 1 Then
	rollback ;
	f_Log2Csv(this.ilJobNr,3,"[of_retrieve_dsjobs_new] Couldn't save stamped records")

	iRet =  -1
else
	Commit;
	
	f_Log2Csv(this.ilJobNr,1,"[of_retrieve_dsjobs_new] Stamped "+string(iCount)+" of "+string(lds_jobs.RowCount())+" Rows")

	iRet = 1
End if

dsJobs.retrieve(sInstance)

destroy lds_instances
destroy lds_jobs

return iRet

end function

public function integer of_log_jobstate (integer arg_mes_type, string arg_mes_text);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_flight_calculation
// Methode: of_log_jobstate (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// integer arg_mes_type    1: Info 2: Fehler 3: Warnung
//  string arg_mes_text
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  12.03.2015	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

if isnull(arg_mes_text) or arg_mes_text="" then
   arg_mes_text = " "
   f_Log2Csv(0,2,"[of_log_jobstate] arg_mes_text is set to BLANK")
end if

INSERT INTO SYS_QUEUE_FLIGHT_LOG (NJOB_NR, NRESULT_KEY, NTYPE, CMESSAGE) 
VALUES ( :this.ilJobNr, :this.lResultKeyCenOut, :arg_mes_type, :arg_mes_text)
using SQLCA_LOG;

if SQLCA_LOG.SQLCODE <> 0 then
	f_Log2Csv(0,2,"[of_log_jobstate] Error Insert into SYS_QUEUE_FLIGHT_LOG("+string(arg_mes_type)+" "+arg_mes_text+")")
	f_Log2Csv(0,2,"[of_log_jobstate] Error: "+string(SQLCA_LOG.SQLCODE)+" "+SQLCA_LOG.SQLERRTEXT)
	rollback using SQLCA_LOG;
else
	
	commit using SQLCA_LOG;
end if

return 1
end function

public function boolean wf_chc_check_against_old ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_flight_calculation
// Methode: wf_chc_check_against_old (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------------------------------------------
// Return: boolean
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  02.04.2015	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

long 				i

wf_chc_trace(10,"[wf_chc_check_against_old] Begin")

if this.dssingleold.rowcount()=0 then
	wf_chc_trace(10,"[wf_chc_check_against_old] No old Flightdata")
	return true
end if

// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungen am Flug markieren
// ------------------------------------------------------------------------
If dw_single.GetItemString(dw_single.Getrow(),"cairline") <> dssingleold.GetItemString(1,"cairline")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"cairline",Primary!, DataModified!)
End if

If dw_single.GetItemNumber(dw_single.Getrow(),"nflight_number") <> dssingleold.GetItemNumber(1,"nflight_number")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"nflight_number",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"csuffix") <> dssingleold.GetItemString(1,"csuffix")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"csuffix",Primary!, DataModified!)
End if

If dw_single.GetItemNumber(dw_single.Getrow(),"nleg_number") <> dssingleold.GetItemNumber(1,"nleg_number")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"nleg_number",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"ctlc_from") <> dssingleold.GetItemString(1,"ctlc_from")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"ctlc_from",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"ctlc_to") <> dssingleold.GetItemString(1,"ctlc_to")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"ctlc_to",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"ccountry_from") <> dssingleold.GetItemString(1,"ccountry_from")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"ccountry_from",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"ccountry_to") <> dssingleold.GetItemString(1,"ccountry_to")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"ccountry_to",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"crouting") <> dssingleold.GetItemString(1,"crouting")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"crouting",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"ctraffic_area") <> dssingleold.GetItemString(1,"ctraffic_area")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"ctraffic_area",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"cheader1") <> dssingleold.GetItemString(1,"cheader1")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"cheader1",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"cheader2") <> dssingleold.GetItemString(1,"cheader2")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"cheader2",Primary!, DataModified!)
End if

If dw_single.GetItemNumber(dw_single.Getrow(),"nstatus") <> dssingleold.GetItemNumber(1,"nstatus")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"nstatus",Primary!, DataModified!)
End if

If dw_single.GetItemDatetime(dw_single.Getrow(),"ddeparture") <> dssingleold.GetItemDatetime(1,"ddeparture")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"ddeparture",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"cdeparture_time") <> dssingleold.GetItemString(1,"cdeparture_time")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"cdeparture_time",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"cramp_time") <> dssingleold.GetItemString(1,"cramp_time")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"cramp_time",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"ckitchen_time") <> dssingleold.GetItemString(1,"ckitchen_time")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"ckitchen_time",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"cregistration") <> dssingleold.GetItemString(1,"cregistration")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"cregistration",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"cbox_from") <> dssingleold.GetItemString(1,"cbox_from")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"cbox_from",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"cbox_to") <> dssingleold.GetItemString(1,"cbox_to")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"cbox_to",Primary!, DataModified!)
End if

If dw_single.GetItemNumber(dw_single.Getrow(),"naircraft_key") <> dssingleold.GetItemNumber(1,"naircraft_key")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"naircraft_key",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"cconfiguration") <> dssingleold.GetItemString(1,"cconfiguration")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"cconfiguration",Primary!, DataModified!)
End if

If dw_single.GetItemNumber(dw_single.Getrow(),"nhandling_type_key") <> dssingleold.GetItemNumber(1,"nhandling_type_key")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"nhandling_type_key",Primary!, DataModified!)
End if

If dw_single.GetItemString(dw_single.Getrow(),"chandling_type_text") <> dssingleold.GetItemString(1,"chandling_type_text")	Then
	dw_single.SetItemStatus(dw_single.Getrow(),"chandling_type_text",Primary!, DataModified!)
End if

// ------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungen Paxe
// ------------------------------------------------------------------------
if dw_pax.rowcount() <> dspaxold.rowcount() then
	wf_chc_trace(10,"[wf_chc_check_against_old] Different Rowcount dw_pax() - dspaxold")
else
	For i = 1 to dw_pax.rowcount()
		if dw_pax.GetItemnumber(i,"npax") <> dspaxold.GetItemnumber(i,"npax") then
			dw_pax.SetItemStatus(i,"npax",Primary!, DataModified!)
		end if
	Next	
end if

wf_chc_trace(10,"[wf_chc_check_against_old] Ende")

Return True	

end function

public function integer of_check_save (boolean ab_oksave, long al_result_key);/* 
* Function: 			of_check_save
* Beschreibung: 	pr$$HEX1$$fc00$$ENDHEX$$ft und save geklappt hat und handelt entsprechend.
*						Code wurde aus of_process_auto_web_calc_cen_out hierher ausgelagert, damit es dort $$HEX1$$fc00$$ENDHEX$$bersichtlicher wird und weil 
*						dieser Code mehrmals gebraucht wurde
* Besonderheit: 	...
*
* Argumente:
* 		arg_name 	Beschreibung
*
* Aenderungshistorie:
* 	Version 	Wer					Wann				Was und warum
*	1.0 		Thomas Schaefer	14.07.2015		Erstellung
*
* Return Codes:
*	 1
*/
Long		ll_queued_release_interface
Long		ll_null
String		ls_message

ll_queued_release_interface = this.lnew_queued_release_interface
if isnull(ll_queued_release_interface) then ll_queued_release_interface = 0

if not ab_OKSave then
	this.ireturn_error_status  = -1
	this.sreturn_error_message = ": Error for flight ${" + this.sFlightText + "} in wf_chc_save!"
	this.sreturn_error_message_short = " Error for flight in wf_chc_save!"
	this.is_web_message = uf.translate("Fehler beim Speichern")
	
	of_log_jobstate(ii_log_fehler, this.is_web_message) // 12.03.2015 HR: Logging eingebaut

	commit;

else
	// alles o.k.  Update erfolgte $$HEX1$$fc00$$ENDHEX$$ber wf_chc_save
	this.sreturn_error_message = ": Successful recalculation for Flight ${" + this.sFlightText + "} !"
	this.sreturn_error_message_short = "Successful recalculation for Flight!"
	this.is_web_message = uf.translate("Daten erfolgreich gespeichert") //28.02.2011 HR: Fehlermeldung f$$HEX1$$fc00$$ENDHEX$$r WEBService
	
	of_log_jobstate(ii_log_info, this.is_web_message) // 12.03.2015 HR: Logging eingebaut

	// --------------------------------------------------------------------------------------------------------------------
	// 26.11.2015 HR: NSTATUS mit in den UPDATE eingebaut
	// --------------------------------------------------------------------------------------------------------------------
	update cen_out 
		set nstatus = :iChangeStatus, 
			 nqueued_release_interface = :ll_queued_release_interface
	 where nresult_key = :al_result_key; 
	 
	// --------------------------------------------------------------------------------------------------------------------
	// 26.11.2015 HR: LOGGING angepa$$HEX1$$df00$$ENDHEX$$t
	// --------------------------------------------------------------------------------------------------------------------
	if sqlca.sqlcode <> 0 then
		f_Log2Csv(0,1,"[of_check_save] - Error Update CEN_OUT. nqueued_release_interface: " + string( sqlca.sqlcode) +  sqlca.sqlerrtext)		
		
		this.ireturn_error_status  = -1
		this.sreturn_error_message = ": Database error: " + sqlca.sqlerrtext
		this.sreturn_error_message_short = ": Database error: " + sqlca.sqlerrtext
	else
		 f_Log2Csv(0,99,"[of_check_save] - Update CEN_OUT.nstatus - " + string(dw_single.getitemNumber(dw_single.getrow(),"nstatus")) + " /  " + string(iChangeStatus))		
	end if
	 
	// lcounter_processed_input_f ++
	 commit;
	
	 if dw_single.getitemNumber(dw_single.getrow(),"nstatus") = 6 or &
		this.lnew_cen_out_nstatus = 6 then
		if not wf_chc_flight_closed(ref ls_message) then
			this.ireturn_error_status  = -1
			this.sreturn_error_message = ": Error in Flight closed for flight ${" + this.sFlightText + "} "+ls_message + " nstatus set to 3, nstatus_release set to Null"
			this.sreturn_error_message_short = ": Error in Flight closed nstatus set to 3, nstatus_release set to Null"
			this.is_web_message = ls_message //28.02.2011 HR: Fehlermeldung f$$HEX1$$fc00$$ENDHEX$$r WEBService
			
			of_log_jobstate(ii_log_fehler, this.is_web_message) // 12.03.2015 HR: Logging eingebaut

			SetNull(ll_null)
			
			update cen_out 
				set nstatus = 3,
					nstatus_release = :ll_null
			 where nresult_key = :al_result_key; 
			 
			if sqlca.sqlcode <> 0 then
				this.ireturn_error_status  = -1
				this.sreturn_error_message = ": Database error: " + sqlca.sqlerrtext
				this.sreturn_error_message_short = ": Database error: " + sqlca.sqlerrtext
				f_Log2Csv(0,1,"[of_check_save] - Error Update CEN_OUT. nstatus = 3, nstatus_release=NULL: " + string( sqlca.sqlcode) +  sqlca.sqlerrtext)		

			end if
			
			commit;
									
		else
			this.sreturn_error_message = ": Successful recalculation for Flight ${" + this.sFlightText + "} !"
			this.sreturn_error_message_short = ": Successful recalculation for Flight!"
				this.is_web_message = uf.translate("Daten erfolgreich gespeichert") //28.02.2011 HR: Fehlermeldung f$$HEX1$$fc00$$ENDHEX$$r WEBService

			of_log_jobstate(ii_log_info, this.is_web_message) // 12.03.2015 HR: Logging eingebaut

			update cen_out 
				set nqueued_release_interface = :ll_queued_release_interface
			 where nresult_key = :al_result_key; 
			 
			 if sqlca.sqlcode <> 0 then
				this.ireturn_error_status  = -1
				this.sreturn_error_message += ": Database error: " + sqlca.sqlerrtext
				this.sreturn_error_message_short += ": Database error: " + sqlca.sqlerrtext
				f_Log2Csv(0,1,"[of_check_save] - Error Update CEN_OUT. nstatus = 3, nstatus_release=NULL: " + string( sqlca.sqlcode) +  sqlca.sqlerrtext)		
				
			 end if
			// 	lcounter_processed_input_f ++
			 commit;
		end if
	end if
end if

Return 1

end function

public function integer wf_chc_multileg_change (ref string arg_message);//======================================================================================
//
// wf_chc_multileg_change
//
// Vorbereitung Masterchange $$HEX1$$fc00$$ENDHEX$$ber viele Legs
//
//======================================================================================
long							lReturn, i, lFind, j
long							lNewAircraftKey
long							lNewVersionGroupKey
long							lNewHandlingKey

string							sCurrentRegistration
integer						iPax
Boolean						bMasterCange	= false	// Merker f$$HEX1$$fc00$$ENDHEX$$r Masterchange
Boolean						bChange			= false	// Merker f$$HEX1$$fc00$$ENDHEX$$r $$HEX1$$c400$$ENDHEX$$nderung im allgemeinen
string							sNewConfiguration, sNewLocalTime
date							dNewReturndate
string							sNewFromDest, sNewToDest
string							sNewHandlingText, sNewHandllingDesc
integer						iret
integer						iFlight_Status_Old
integer						i2
uo_get_aircraft				uogetaircraft

// 14.07.2015 HR: Fehlermeldung setzen
arg_message = " "

// -----------------------------
// Alle Legs sperren
// ----------------------------- 
iFlightStatus = dw_single.getitemnumber(dw_single.getrow(),"nflight_status")
if dsSingleOld.RowCount() = 0 then
	//dw_single.RowsCopy(1,dw_single.rowcount(),Primary!,dsSingleOld,1,Primary!)
	//wf_ml_rowscopy_single(dw_single,1,1, dsSingleOld,1)
	
	wf_ml_superrowscopy(dw_single, dssingleold)

end if
iFlight_Status_Old = dsSingleOld.getitemnumber(dsSingleOld.getRow(),"nflight_status")

// Alle Commits aus
bEnableCommit 	= false
bMultiLegError 		= false

		i=dw_single.Getrow()
		
		//
		// Ge$$HEX1$$e400$$ENDHEX$$nderte Informationen auf Leg-Basis holen
		//
		sNewConfiguration 	= dw_single.GetItemString(i,"cconfiguration")
		sNewLocalTime			= dw_single.GetItemString(i,"coriginal_time")
		dNewReturndate		= Date(dw_single.GetItemDatetime(i,"dreturn_date"))
		sNewFromDest			= dw_single.GetItemString(i,"ctlc_from")
		sNewToDest				= dw_single.GetItemString(i,"ctlc_to")
		lNewHandlingKey		= dw_single.GetItemNumber(i,"nhandling_type_key")	
		sNewHandlingText		= dw_single.GetItemString(i,"chandling_type_text")
		sNewHandllingDesc	= f_handling_to_description(lNewHandlingKey)
		// -------------------------------------------------
		// Ermittlung GroupKey der Version
		// -------------------------------------------------
		uoGetAircraft 					= create uo_get_aircraft	

		// Initialisierung
		uoGetAircraft.lAirline_key 	= dw_single.GetItemNumber(dw_single.GetRow(),"nairline_owner_key")
		uoGetAircraft.sOwner 		= dw_single.GetItemString(dw_single.GetRow(),"cairline_owner")
		uoGetAircraft.sActype 		= dw_single.GetItemString(dw_single.GetRow(),"cactype")
		dsClasses.Retrieve(uoGetAircraft.lAirline_key)

			i2 = 0
			if dsClasses.RowCount() > 0 then
				For i = 1 to dsClasses.RowCount()
					
					if dsClasses.getitemNumber(i, "nbooking_class") = 1 then
						
						i2++
						uoGetAircraft.sClass[i2] 				= dsClasses.getitemString(i, "cclass") 
						uoGetAircraft.iClassNumber[i2] 	= dsClasses.getitemNumber(i, "nclass_number") 
				 		uoGetAircraft.iVersion[i2] 			= of_configuration_to_number(sNewConfiguration , i2)
						
					end if
				Next
			end if
			
			lReturn = uoGetAircraft.of_get_aircraft()
			if lReturn = -1 or uoGetAircraft.lAircraft_key = -1 then
            
					// 14.07.2015 HR: Fehlermeldung setzen
				arg_message = "Aircraft  key not found for " + string(uoGetAircraft.lAirline_key ) + " " + uoGetAircraft.sActype+": "+ uoGetAircraft.sstatustext
            
				f_Log2Csv(0,0,"[wf_chc_multileg_change] dw_single |Aircraft  key not found for " + &
						string(uoGetAircraft.lAirline_key ) + " " + uoGetAircraft.sActype+": "+ uoGetAircraft.sstatustext )
							
				rollback;
				
				destroy uoGetAircraft
				
				return 1
			end if
			
			lNewVersionGroupKey = uoGetAircraft.lGroup_key
			
			destroy uoGetAircraft
	
		// -------------------------------------------------
		//
		// Vorbereitung Masterchange
		//
		// -------------------------------------------------	
		
		// 
		// Dirty Aircraft Change, verliert an Bedeutung
		// True = keine Ver$$HEX1$$e400$$ENDHEX$$nderung
		// 	
		bChangeNoMeals		= false
		bChangeNoExtra		= false

			bDoMealCalculation = true
			bMasterCange = true
		
		//
		// Der Flug wird annulliert / Annullierung wird aufgehoben
		//
		
		If iFlightStatus = 1 and iFlight_Status_old <> 1 then
			dw_single.SetItem(dw_single.Getrow(),"cheader1",uf.translate("Annulliert") + " - " + string(today()) + " " + string(now()))
			dw_single.SetItem(dw_single.Getrow(),"nrefund",0)
			bCancelAction	= True
			lCalculationCounter++	// neu, denn CNX hat Auswirkungen auf Matdispo
			ib_checkpoint_cx = true // 09.03.2015 HR: Anpassungen f$$HEX1$$fc00$$ENDHEX$$r Flightchecker Teil II
		ElseIf iFlightStatus <> 1 and iFlight_Status_old  = 1 then
			// 
			// Der Flug war annulliert und wird wieder ins Rennen geschickt
			// mit dem alten Flugstatus.
			// 
			
			dw_single.SetItem(dw_single.Getrow(),"cheader1",uf.translate("Annullierung aufgehoben"))
			dw_single.SetItem(dw_single.Getrow(),"nrefund", &
									wf_chc_check_refund(dw_single.GetitemNumber(dw_single.Getrow(),"nairline_key"),&
														dw_single.GetitemNumber(dw_single.Getrow(),"ntlc_from"), &
														dw_single.GetitemNumber(dw_single.Getrow(),"ntlc_to")))
			//
			// Ber$$HEX1$$fc00$$ENDHEX$$cksichtige REQ
			//
			if dw_single.GetItemString(dw_single.Getrow(),"chandling_type_text") = "REQ" then
				iFlightStatus = 2
				dw_single.SetItem(dw_single.Getrow(),"nflight_status",iFlightStatus)
			end if
			bCancelAction	= True
			ib_checkpoint_cx_undo = true // 09.03.2015 HR: Anpassungen f$$HEX1$$fc00$$ENDHEX$$r Flightchecker Teil II
		End if
		
		// 
		// Das Flugger$$HEX1$$e400$$ENDHEX$$t hat sich ge$$HEX1$$e400$$ENDHEX$$ndert.
		// 
		If dw_single.GetitemNumber(dw_single.Getrow(),"naircraft_key") <> dssingleOld.GetitemNumber(dsSingleOld.Getrow(),"naircraft_key") Then
			bChange						= true
			bMasterCange				= True
			ib_checkpoint_acchange = true // 09.03.2015 HR: Anpassungen f$$HEX1$$fc00$$ENDHEX$$r Flightchecker Teil II
			ib_wab_send = True		// TSC 15.08.2016: beim AC-Change Gewichte schicken
			
			dw_single.SetItem(dw_single.Getrow(),"status_cairline_owner",1)	
			dw_single.SetItem(dw_single.Getrow(),"status_cactype",1)		
			dw_single.SetItem(dw_single.Getrow(),"status_cgalleyversion",1)
	
			// --------------------------------------------
			// Die g$$HEX1$$fc00$$ENDHEX$$ltigen Versionen holen
			// --------------------------------------------
			wf_chc_create_aircraft_version(dw_single.GetitemNumber(dw_single.Getrow(),"naircraft_key") ,True)	
			// --------------------------------------------
			// $$HEX1$$dc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fung Sitzplatzversion
			// --------------------------------------------
			dw_single.SetItem(dw_single.Getrow(),"cconfiguration",sNewConfiguration)
			dw_single.SetItem(dw_single.Getrow(),"status_cconfiguration",1)
			// --------------------------------------------
			// Die Version in dw_pax eintragen
			// --------------------------------------------
			wf_chc_change_aircraft_version(lNewVersionGroupKey)
		End if	
		
		// 
		// Das Flugger$$HEX1$$e400$$ENDHEX$$t hat sich nicht ge$$HEX1$$e400$$ENDHEX$$ndert, aber die Sitzplatzversion
		// 
		If dw_single.GetitemNumber(dw_single.Getrow(),"naircraft_key")  	= 	dssingleOld.GetitemNumber(dssingleOld.Getrow(),"naircraft_key") and &
			sNewConfiguration <> dsSingleOld.GetitemString(dsSingleOld.Getrow(),"cconfiguration") Then
			bChange				= true
			bMasterCange		= True
			// --------------------------------------------
			// $$HEX1$$dc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fung Sitzplatzversion
			// --------------------------------------------
			dw_single.Setitem(dw_single.getrow(),"cconfiguration",sNewConfiguration)
			dw_single.Setitem(dw_single.getrow(),"status_cconfiguration",1)
			// --------------------------------------------
			// Die g$$HEX1$$fc00$$ENDHEX$$ltigen Versionen holen
			// --------------------------------------------
			wf_chc_create_aircraft_version(dw_single.GetitemNumber(dw_single.Getrow(),"naircraft_key") ,True)	
			// --------------------------------------------
			// Die Version in dw_pax eintragen
			// --------------------------------------------
			wf_chc_change_aircraft_version(lNewVersionGroupKey)
		End if
		
				bMasterCange = true
				bDoMealCalculation = true
	
		// 
		// Registration $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen
		// 
		sCurrentRegistration = dssingleold.GetItemString(dssingleOld.Getrow(),"cregistration")
		if isnull(sCurrentRegistration) then sCurrentRegistration = ""
		If dw_single.GetitemString(dw_single.Getrow(),"cregistration") <> sCurrentRegistration Then
			wf_chc_show_changes(dw_single,"cregistration",dw_single.Getrow())
			bChange			= true
		End if
		
		// 
		// Handling $$HEX1$$fc00$$ENDHEX$$berpr$$HEX1$$fc00$$ENDHEX$$fen: jetzt Abfertigung je Leg ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
		// 	
		If lNewHandlingKey <> dw_single.GetItemNumber(dw_single.Getrow(),"nhandling_type_key") Then
			bChange			= true
			bMasterCange	= True
			dw_single.SetItem(dw_single.Getrow(),"nhandling_type_key",lNewHandlingKey)
			dw_single.SetItem(dw_single.Getrow(),"chandling_type_text",sNewHandlingText)
			dw_single.SetItem(dw_single.Getrow(),"chandling_type_description",sNewHandllingDesc)
			wf_chc_show_changes(dw_single,"chandling_type_text",dw_single.Getrow())
			//
			// Ber$$HEX1$$fc00$$ENDHEX$$cksichtige REQ
			//
			if sNewHandlingText = "REQ" then
				iFlightStatus = 2
				dw_single.SetItem(dw_single.Getrow(),"nflight_status",iFlightStatus)
			else
				if iFlightStatus <> 1 then
					iFlightStatus = 0
					dw_single.SetItem(dw_single.Getrow(),"nflight_status",iFlightStatus)
				end if
			end if
		End if
		// 
		// Abflug-Datum und Zeiten
		// 
		If Date(dw_single.GetItemDateTime(dw_single.Getrow(),"ddeparture")) <> Date(dssingleold.GetItemDateTime(dssingleold.Getrow(),"ddeparture")) Then
			wf_chc_show_changes(dw_single,"ddeparture",dw_single.Getrow())
			bMasterCange = true
		End if	
		
		If dw_single.GetItemString(dw_single.Getrow(),"cdeparture_time") <> dssingleold.GetItemString(dssingleold.Getrow(),"cdeparture_time") Then
		  	dw_single.SetItem(dw_single.Getrow(),"csort_time",dw_single.GetItemString(dw_single.Getrow(),"cdeparture_time"))
			// 09.07.: Auch bei Uhrzeit-$$HEX1$$c400$$ENDHEX$$nderung die Mahlzeiten neu holen
			bDoMealCalculation = true
			bMasterCange = true
			wf_chc_show_changes(dw_single,"cdeparture_time",dw_single.Getrow())
		End if
		
		If sNewLocalTime <> dw_single.GetItemString(dw_single.Getrow(),"coriginal_time") Then
			// 09.07.: Auch bei Uhrzeit-$$HEX1$$c400$$ENDHEX$$nderung die Mahlzeiten neu holen
			bDoMealCalculation = true
			bMasterCange = true
			wf_chc_show_changes(dw_single,"coriginal_time",dw_single.Getrow())
		End if
		
		If dNewReturndate <> Date(dw_single.GetItemDateTime(dw_single.Getrow(),"dreturn_date")) Then
			bMasterCange = true
		End if	
		
		// Routing wurde ge$$HEX1$$e400$$ENDHEX$$ndert
		If sNewFromDest <> dw_single.GetItemString(dw_single.Getrow(),"ctlc_from") Then
			dw_single.SetItem(dw_single.Getrow(),"ctlc_from",sNewFromDest)	
			dw_single.SetItem(dw_single.Getrow(),"ntlc_from",f_get_tlc_number(sNewFromDest))	
			dw_single.SetItem(dw_single.Getrow(),"status_ctlc",1)	
		End if	

		If sNewToDest <> dw_single.GetItemString(dw_single.Getrow(),"ctlc_to") Then
			dw_single.SetItem(dw_single.Getrow(),"ctlc_to",sNewToDest)	
			dw_single.SetItem(dw_single.Getrow(),"ntlc_to",f_get_tlc_number(sNewToDest))	
			dw_single.SetItem(dw_single.Getrow(),"status_ctlc",1)	
		End if	
		
		// -------------------------------------------------
		//
		// Masterchange
		//
		// -------------------------------------------------	
		if bMasterCange = true then
			wf_chc_master_change()
		end if

		
		// -------------------------------------------------
		//
		// Speichern ohne $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen
		//
		// -------------------------------------------------	
		if not wf_chc_save() Then
			// 14.07.2015 HR: Fehlermeldung setzen
			arg_message = uf.translate("$$HEX1$$c400$$ENDHEX$$nderungen f$$HEX1$$fc00$$ENDHEX$$r Leg $" + string(i) + " konnten nicht gespeichert werden!")

			f_Log2Csv(0,0,"[wf_chc_multileg_change] "+arg_message)
			bMultiLegError = true
		end if

		//
		// Neutralisieren der $$HEX1$$c400$$ENDHEX$$nderungen im Fenster (sonst MessageBox Speichern)
		//
		dw_single.ResetUpdate() 
		dw_pax.ResetUpdate() 
		dw_handling.ResetUpdate() 
		dw_extra.ResetUpdate() 
		dw_meal.ResetUpdate() 
		dw_spml.ResetUpdate() 
		dsCenOutHandlingNews.ResetUpdate() 
		dsCenOutNewsExtra.ResetUpdate()
		bNoSaving 				= False
		bCancelAction			= False
		bNewspaperChange	= False
		
// -------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen f$$HEX1$$fc00$$ENDHEX$$r alle n Legs auf einmal
// -------------------------------------------------	
iret=1
if bMultiLegError then
	// 14.07.2015 HR: Fehlermeldung setzen
	arg_message = uf.translate("Multileg-Change kann nicht durchgef$$HEX1$$fc00$$ENDHEX$$hrt werden!")
   
	rollback;
	f_Log2Csv(0,0,"[wf_chc_multileg_change] "+arg_message)
else
	iret=0
	commit;
end if

	
bEnableCommit 	= true
bMultiLegError 		= false

return iret

end function

public function integer of_process_meals (long al_job_nr, long al_result_key);
/* 
* Function: 			of_process_meals
* Beschreibung: 	...
* Besonderheit: 	...
*
* Argumente:
* 		arg_name 	Beschreibung
*
* Aenderungshistorie:
* 	Version 	Wer					Wann				Was und warum
*	1.0 		Schaefer				20.07.2015		Erstellung
*	1.1 		Thomas Schaefer	15.11.2016		$$HEX1$$c400$$ENDHEX$$nderungen f$$HEX1$$fc00$$ENDHEX$$r quantity_missing
*
* Return Codes:
*	 ...
*/

Integer		li_ret = 0
Integer		li_status
Integer		li_i
Integer		li_input_from_top_off
Date			ld_departure
Long			ll_detail_key
Long			ll_rowcount_details
Long			ll_jobrow
Long			ll_row
Long			ll_row_work
Long			ll_null
Long			ll_transaction
Long			ll_cover_prio
String			ls_customer_text
Long			ll_quant_mis

Datastore	lds_details					// DS f$$HEX1$$fc00$$ENDHEX$$r die in den Job Details eingestellten St$$HEX1$$fc00$$ENDHEX$$cklisten
uo_generate_datastore	ldw_work	// Hier reference auf dw_meal oder dw_extra speichern, je nachdem was gebraucht wird

IF Not IsValid(dsJobs) THEN Return -1

wf_chc_trace(1,"[of_process_meals] al_job_nr: " + String (al_job_nr))

// Init
lds_details = Create Datastore
lds_details.DataObject = "dw_sys_queue_flight_meals"
lds_details.SetTransObject(SQLCA)

SetNull(ll_null)

// n$$HEX1$$f600$$ENDHEX$$tige Daten aus Queue holen
ll_jobrow = dsJobs.Find("njob_nr = " + String(al_job_nr), 1, dsJobs.RowCount())
IF ll_jobrow < 1 THEN 
	destroy lds_details
	Return -1
end if
ld_departure = Date(dsJobs.GetItemDatetime(ll_jobrow, "ddeparture"))
li_status = dsJobs.GetItemNumber(ll_jobrow, "nstatus")
wf_chc_trace(1,"[of_process_meals] nstatus in queue: " + String (li_status))
// Details retrieven
ll_rowcount_details = lds_details.Retrieve(al_job_nr, ld_departure)
wf_chc_trace(1,"[of_process_meals] Number Details retrieved: " + String (ll_rowcount_details))

// Flugdaten holen
SELECT ntransaction INTO :ll_transaction FROM cen_out WHERE nresult_key = :al_result_key;

// Durch die Detail-Zeilen gehn
FOR ll_row = 1 TO ll_rowcount_details
	// Gibts die Zeile schon (also gibts den Detail-Key schon)? Erst in dw_meal suchen...
	ll_detail_key = lds_details.GetItemNumber(ll_row, "ndetail_key")
	ll_row_work = dw_meal.Find("ndetail_key = " + String(ll_detail_key), 1, dw_meal.Rowcount())
	IF ll_row_work > 0 THEN
		// Gefunden, also Meal
		ldw_work = dw_meal
	ELSE
		// Nicht gefunden, jetzt in dw_extra suchen
		ll_row_work = dw_extra.Find("ndetail_key = " + String(ll_detail_key), 1, dw_extra.Rowcount())
		IF ll_row_work > 0 THEN
			// Gefunden, also Extra
			ldw_work = dw_extra
		END IF
	END IF
	IF ll_row_work > 0 THEN
		// Zeile gabs schon
		// NQuantity oder nquantity_mis ge$$HEX1$$e400$$ENDHEX$$ndert? 
		IF Not IsNull(lds_details.GetItemNumber(ll_row, "nquantity")) THEN
			IF ldw_work.GetItemNumber(ll_row_work, "nquantity") <> lds_details.GetItemNumber(ll_row, "nquantity") OR ldw_work.GetItemNumber(ll_row_work, "nquantity_mis") <> lds_details.GetItemNumber(ll_row, "nquantity_mis") THEN
				IF ldw_work.GetItemNumber(ll_row_work, "nquantity") <> lds_details.GetItemNumber(ll_row, "nquantity") THEN
					ldw_work.SetItem(ll_row_work, "nquantity_old", ldw_work.GetItemNumber(ll_row_work, "nquantity"))
				END IF
				ldw_work.SetItem(ll_row_work, "nquantity", lds_details.GetItemNumber(ll_row, "nquantity"))
				// Zus$$HEX1$$e400$$ENDHEX$$tzliche Statusbezogene Quantity-Felder auch...
				FOR li_i = li_status TO 7
					ldw_work.SetItem(ll_row_work, "nquantity" + String(li_i), lds_details.GetItemNumber(ll_row, "nquantity"))
				NEXT
				// Calc Id setzen
				IF Not IsNull(lds_details.GetItemNumber(ll_row, "ncalc_id")) THEN
					ldw_work.SetItem(ll_row_work, "ncalc_id", lds_details.GetItemNumber(ll_row, "ncalc_id"))
				END IF
				// nmanual_input setzen
				IF Not IsNull(lds_details.GetItemNumber(ll_row, "nmanual_input")) THEN
					ldw_work.SetItem(ll_row_work, "nmanual_input", lds_details.GetItemNumber(ll_row, "nmanual_input"))
				END IF
				// ninput_from_top_off setzen
				IF Not IsNull(lds_details.GetItemNumber(ll_row, "ninput_from_top_off")) THEN
					ldw_work.SetItem(ll_row_work, "ninput_from_top_off", lds_details.GetItemNumber(ll_row, "ninput_from_top_off"))
				END IF
				// nquantity_mis setzen
				ll_quant_mis = lds_details.GetItemNumber(ll_row, "nquantity_mis")
				IF Not IsNull(lds_details.GetItemNumber(ll_row, "nquantity_mis")) THEN
					ldw_work.SetItem(ll_row_work, "nquantity_mis", lds_details.GetItemNumber(ll_row, "nquantity_mis"))
				END IF
			END IF
		END IF
	ELSE
		// Nicht gefunden, also Unterscheidung Meals oder Extra $$HEX1$$fc00$$ENDHEX$$ber Queue-Eintrag ...
		IF lds_details.GetItemNumber(ll_row, "nmodule_type") = 0 THEN
			ldw_work = dw_meal
		ELSE
			ldw_work = dw_extra
		END IF
		// Cover Prio ermitteln
		IF ldw_work.RowCount() > 0 THEN
			ll_cover_prio = ldw_work.GetItemNumber(ldw_work.RowCount(),"compute_max_cover") + 1
		ELSE
			ll_cover_prio = 1
		END IF
		// ... und neue Zeile einf$$HEX1$$fc00$$ENDHEX$$gen und f$$HEX1$$fc00$$ENDHEX$$llen
		ll_row_work = ldw_work.InsertRow(0)
		ldw_work.SetItem(ll_row_work, "ndetail_key", ll_detail_key)
		ldw_work.SetItem(ll_row_work, "nresult_key", al_result_key)
		ldw_work.SetItem(ll_row_work, "nhandling_detail_key", 0)
		ldw_work.SetItem(ll_row_work, "ntransaction", ll_transaction)
		ldw_work.SetItem(ll_row_work, "nhandling_key", 0)
		ldw_work.SetItem(ll_row_work, "chandling_text", "n/a")
		ldw_work.SetItem(ll_row_work, "ncover_key", 0)
		ldw_work.SetItem(ll_row_work, "ccover_text", "n/a")
		ldw_work.SetItem(ll_row_work, "ncover_prio", ll_cover_prio)
		ldw_work.SetItem(ll_row_work, "nhandling_meal_key",			0)
		ldw_work.SetItem(ll_row_work, "nclass_number", lds_details.GetItemNumber(ll_row, "nclass_number"))
		ldw_work.SetItem(ll_row_work, "cclass", lds_details.GetItemString(ll_row, "cclass"))
		ldw_work.SetItem(ll_row_work, "nreserve_quantity", 0)
		ldw_work.SetItem(ll_row_work, "nreserve_type", 0)
		ldw_work.SetItem(ll_row_work, "ntopoff_quantity", 0)
		ldw_work.SetItem(ll_row_work, "ntopoff_type", 0)
		ldw_work.SetItem(ll_row_work, "nrotation_key", 0)
		ldw_work.SetItem(ll_row_work, "nrotation_name_key", 0)
		ldw_work.SetItem(ll_row_work, "crotation", "none")
		ldw_work.SetItem(ll_row_work, "nmodule_type", lds_details.GetItemNumber(ll_row, "nmodule_type"))
		ldw_work.SetItem(ll_row_work, "nprio", 1)
		ldw_work.SetItem(ll_row_work, "npackinglist_index_key", lds_details.GetItemNumber(ll_row, "npackinglist_index_key"))
		ldw_work.SetItem(ll_row_work, "npackinglist_detail_key", lds_details.GetItemNumber(ll_row, "npackinglist_detail_key"))
		ldw_work.SetItem(ll_row_work, "cpackinglist", lds_details.GetItemString(ll_row, "cpackinglist"))
		ldw_work.SetItem(ll_row_work, "npl_kind_key", lds_details.GetItemNumber(ll_row, "npl_kind_key"))
		ldw_work.SetItem(ll_row_work, "npackinglist_key", lds_details.GetItemNumber(ll_row, "npackinglist_key"))
		ldw_work.SetItem(ll_row_work, "ctext", lds_details.GetItemString(ll_row, "ctext"))
		ldw_work.SetItem(ll_row_work, "nposting_type", lds_details.GetItemNumber(ll_row, "nposting_type"))
		ldw_work.SetItem(ll_row_work, "cmeal_control_code", "1111")
		ldw_work.SetItem(ll_row_work, "cproduction_text", lds_details.GetItemString(ll_row, "ctext"))
		ldw_work.SetItem(ll_row_work, "ncomponent_group", 1)
		ldw_work.SetItem(ll_row_work, "nforeign_object", ll_null)
		ldw_work.SetItem(ll_row_work, "nforeign_group", ll_null)
		ldw_work.SetItem(ll_row_work, "nask4passenger", 0)
		ldw_work.SetItem(ll_row_work, "cquestion_text",	 "none")
		ldw_work.SetItem(ll_row_work, "npassenger_group", 0)
		ldw_work.SetItem(ll_row_work, "nquantity_group", 0)
		ldw_work.SetItem(ll_row_work, "cremark", "")
		ldw_work.SetItem(ll_row_work, "naccount_key", lds_details.GetItemNumber(ll_row, "naccount_key"))
		ldw_work.SetItem(ll_row_work, "caccount", lds_details.GetItemString(ll_row, "caccount"))
		ldw_work.SetItem(ll_row_work, "nbilling_status", lds_details.GetItemNumber(ll_row, "nbilling_status"))
		ldw_work.SetItem(ll_row_work, "ncalc_id", lds_details.GetItemNumber(ll_row, "ncalc_id"))
		ldw_work.SetItem(ll_row_work, "ncalc_detail_key", ll_null)
		ldw_work.SetItem(ll_row_work, "npercentage", 0)
		ldw_work.SetItem(ll_row_work, "nvalue", 0)
		ldw_work.SetItem(ll_row_work, "nspml_deduction", 0)
		ldw_work.SetItem(ll_row_work, "nac_transfer", 0)
		ldw_work.SetItem(ll_row_work, "nquantity", lds_details.GetItemNumber(ll_row, "nquantity"))
		// Zus$$HEX1$$e400$$ENDHEX$$tzliche Statusbezogene Quantity-Felder auch...
		FOR li_i = 1 TO li_status - 1
			ldw_work.SetItem(ll_row_work, "nquantity" + String(li_i), 0)
		NEXT
		FOR li_i = li_status TO 7
			ldw_work.SetItem(ll_row_work, "nquantity" + String(li_i), lds_details.GetItemNumber(ll_row, "nquantity"))
		NEXT
		ldw_work.SetItem(ll_row_work, "nquantity_old", 0)
		ldw_work.SetItem(ll_row_work, "nmanual_input", lds_details.GetItemNumber(ll_row, "nmanual_input"))
		ldw_work.SetItem(ll_row_work, "nmanual_processing", lds_details.GetItemNumber(ll_row, "nmanual_processing"))
		ldw_work.SetItem(ll_row_work, "dtimestamp", DateTime(Today(), Now()))
		ldw_work.SetItem(ll_row_work, "nstatus", li_status)
		ldw_work.SetItem(ll_row_work, "cdescription", "")
		ldw_work.SetItem(ll_row_work, "cunit", lds_details.GetItemString(ll_row, "cunit"))
		ldw_work.SetItem(ll_row_work, "ncalc_basis", 0)
		ldw_work.SetItem(ll_row_work, "npax", 0)
		ldw_work.SetItem(ll_row_work, "npax_manual", 0)
		ldw_work.SetItem(ll_row_work, "nspml_quantity", 0)
		ldw_work.SetItem(ll_row_work, "ncontrolling", lds_details.GetItemNumber(ll_row, "ncontrolling"))
		ldw_work.SetItem(ll_row_work, "ndelivery_note", 1)
		ldw_work.SetItem(ll_row_work, "cdelivery_text", "")
		ldw_work.SetItem(ll_row_work, "cdelivery_snr", "")
		ldw_work.SetItem(ll_row_work, "ccustomer_pl", lds_details.GetItemString(ll_row, "ccustomer_pl"))
		ls_customer_text = lds_details.GetItemString(ll_row, "ccustomer_text")
		IF IsNull(ls_customer_text) THEN ls_customer_text = lds_details.GetItemString(ll_row, "ctext")
		ldw_work.SetItem(ll_row_work, "ccustomer_text", ls_customer_text)
		ldw_work.SetItem(ll_row_work, "ninput_from_top_off", lds_details.GetItemNumber(ll_row, "ninput_from_top_off"))
		ll_quant_mis = lds_details.GetItemNumber(ll_row, "nquantity_mis")
		IF IsNull(ll_quant_mis) THEN ll_quant_mis = 0
		ldw_work.SetItem(ll_row_work, "nquantity_mis", ll_quant_mis)
	END IF
NEXT

IF li_ret > -1 THEN
END IF

Destroy lds_details

Return li_ret

end function

public function boolean wf_chc_change_meals (uo_generate_datastore dsmeals2, uo_generate_datastore dscenmealsdetdeduction);//=================================================================================================
//
// wf_change_meals
//
// $$HEX1$$dc00$$ENDHEX$$bertrag der ge$$HEX1$$e400$$ENDHEX$$nderten Mahlzeiten nach dw_meal
//
// Besonderheit: 
// =============
// Alle Markierungen finden im UserObject statt!!!
//
// Falls nach einer r$$HEX1$$fc00$$ENDHEX$$ckg$$HEX1$$e400$$ENDHEX$$ngigen Annullierung keine Mahlzeiten$$HEX1$$e400$$ENDHEX$$nderungen stattfanden, dann darf diese 
// Funktion nicht ausgef$$HEX1$$fc00$$ENDHEX$$hrt werden, da sonst die Mahlzeiten gel$$HEX1$$f600$$ENDHEX$$scht werden!
//
// Unterscheidung bInsertMode:
// ===========================
// Falls bInsertMode = true, dann wurde eine neue Mahlzeit aufgenommen. In diesem Fall wird ein neu-
// aufbereiteter Datastore zur$$HEX1$$fc00$$ENDHEX$$ckgeliefert. Deshalb ist das alte DataWindow komplett zu l$$HEX1$$f600$$ENDHEX$$schen.
//
// Falls ein Masterchange zur$$HEX1$$fc00$$ENDHEX$$ckkommt (bInsertMode = False), also Mahlzeiten neu kalkuliert wurden,
// dann d$$HEX1$$fc00$$ENDHEX$$rfen die vorher manuell aufgenommenen Mahlzeiten nicht gel$$HEX1$$f600$$ENDHEX$$scht werden.
//
//=================================================================================================
//14.09.2015 Overload Korrektur - CBASE-HKG-EM-15001
//=================================================================================================


long		i
long		lFind, lFind1
string		sFind, sFind1
string		sPL
Integer	li_Succ
long		llocalObject, llocalComponentGroup
long		lQuantity, lNewQuantity, lOverload, lPercentage, lReduction, lReduce, lReductionCheck
long		lQuantityOld
long		lFindClassNumber
long		lSequence
long		lforeignMealKey
Long		ll_Dummy

if bDoMealCalculation = true then
//	dw_meal.SetRedraw(false)
	//
	// Neu: manuell aufgenommene Zeilen bekommen die Menge angepasst,
	//	falls diese von Passagierzahl abh$$HEX1$$e400$$ENDHEX$$ngen soll
	//
	for i = 1 to dw_meal.RowCount() 
		if dw_meal.GetItemNumber(i,"nmanual_processing") = 2 and &
			dw_meal.GetItemNumber(i,"ncalc_id") = 4 then
			lFindClassNumber = dw_meal.GetItemNumber(i,"nclass_number")
			lFind = dw_pax.find("nclass_number = " + string(lFindClassNumber),1,dw_pax.RowCount())
			if lFind > 0 then
				dw_meal.SetItem(i,"nquantity_old",dw_meal.GetItemNumber(i,"nquantity")) 
				dw_meal.SetItem(i,"nquantity",dw_pax.GetItemNumber(lFind,"npax"))
				dw_meal.SetItem(i,"status_nquantity",1)
			end if
		end if
	next

	//
	// Falls noch irgendetwas ge$$HEX1$$e400$$ENDHEX$$ndert werden mu$$HEX1$$df00$$ENDHEX$$,
	// bevor dw_meal vernichtet wird.
	// Achtung: Mahlzeiten mit nmanual_processing = 1 (neue Komponente) 
	//				und nmanual_processing = 2 (neue Zeile) werden nicht gel$$HEX1$$f600$$ENDHEX$$scht!
	//
	for i = dw_meal.RowCount() to 1 step -1
		if bInsertMode then
			dw_meal.deleteRow(i)
		else
			if dw_meal.GetItemNumber(i,"nmanual_processing") < 2 then	// vorher < 2, davor = 0 
				dw_meal.deleteRow(i)
			elseif dw_single.getitemstring(1, "chandling_type_text")="REQ" then
			
				// --------------------------------------------------------------------------------------------------------------------
				// 07.10.2016 HR: ALM-ID #1675: Bei REQ soll auch manuell eingegebene Mengen auf 0 gesetzt werden
				// --------------------------------------------------------------------------------------------------------------------
				dw_meal.SetItem(i,"nquantity_old",dw_meal.GetItemNumber(i,"nquantity")) 
				dw_meal.SetItem(i,"nquantity",0)
				dw_meal.SetItem(i,"status_nquantity",1)
			end if
		end if
	next
	
	//
	// Ergebnisse zur$$HEX1$$fc00$$ENDHEX$$ckschreiben
	//
	
	
	if dsmeals2.RowsCopy(1,dsmeals2.RowCount(),Primary!,dw_meal,1,Primary!)  = -1 and dsmeals2.RowCount()>0 then
		f_Log2Csv(0,1,"wf_chc_change_meals: error rowscopy  dsmeals2 to dw_meal  / Source: " + dsmeals2.dataobject + " / Target: " + dw_meal.dataobject)
	end if
	dw_meal.Sort()
	
	for i = 1 to dw_meal.RowCount() 
		ll_Dummy =  dw_meal.GetItemNumber(i,"noverload")
		If isnull(ll_Dummy) then
			dw_meal.SetItem(i,"noverload",0)
		End If
		ll_Dummy =  dw_meal.GetItemNumber(i,"nreduced")
		If isnull(ll_Dummy) then
			li_Succ = dw_meal.SetItem(i,"nreduced",0)
		End If
	Next
	
	// $$HEX1$$dc00$$ENDHEX$$berbeladungen reduzieren
	// (wurde aus UserObjekt ausgegliedert)
	long lcurrentDetailKey
	
	for i = 1 to dw_meal.RowCount()
		// 18.04.2006: Check doppelte Sequences
		// Der seltene Fall, dass Stammdaten ge$$HEX1$$e400$$ENDHEX$$ndert wurden und anschl. St$$HEX1$$fc00$$ENDHEX$$cklisten manuell
		// erfasst wurden. Dann haben diese St$$HEX1$$fc00$$ENDHEX$$cklisten keinen g$$HEX1$$fc00$$ENDHEX$$ltigen ndetail_key
		lcurrentDetailKey 	= dw_meal.GetItemNumber(i,"ndetail_key")
		sPL					= dw_meal.GetItemString(i,"cpackinglist")
		
		lfind = dw_meal.find("ndetail_key = " + string(lcurrentDetailKey),1,i)
		if lfind <> i then
			if lfind > 0 then
				lSequence = f_Sequence("seq_cen_out_meals", sqlca)
				dw_meal.SetItem(i,"ndetail_key",lSequence)
			end if
		end if
		lfind = dw_meal.find("ndetail_key = " + string(lcurrentDetailKey),i + 1,dw_meal.RowCount())
		if lfind <> i then
			if lfind > 0 then
				lSequence = f_Sequence("seq_cen_out_meals", sqlca)
				dw_meal.SetItem(i,"ndetail_key",lSequence)
			end if
		end if
		
		// $$HEX1$$dc00$$ENDHEX$$berbeladungen reduzieren
		llocalObject 					= dw_meal.GetItemNumber(i,"nhandling_meal_key")
		llocalComponentGroup	= dw_meal.GetItemNumber(i,"ncomponent_group")
		
		// 23.09.2015 HR: Filter wieder auf den alten Stand ge$$HEX1$$e400$$ENDHEX$$ndert (vor Overload Korrektur - CBASE-HKG-EM-15001)
		sFind1 =	"nforeign_object = " + string(llocalObject) + &
					" and nforeign_group = " + string(llocalComponentGroup)

//		sFind1	= 	"nforeign_object = " + string(llocalObject) + &
//					" and nforeign_group = " + string(llocalComponentGroup) + &
//					" and (noverload > nreduced OR (noverload > 0 AND isnull(nreduced) )) "
										
		dscenmealsdetdeduction.setfilter(sFind1)
		dscenmealsdetdeduction.filter()
		dscenmealsdetdeduction.sort()
		if dscenmealsdetdeduction.rowcount()>0 then
			// --------------------------------------------------------------------------------------------------------------------
			// 31.01.2014 HR: CBASE-DE-CR-2014-001: Mahlzeitenabzug $$HEX1$$fc00$$ENDHEX$$ber mehrere Klassen
			// --------------------------------------------------------------------------------------------------------------------
			lforeignMealKey = 0 

			for lFind1 = 1 to dscenmealsdetdeduction.rowcount()			
				if dscenmealsdetdeduction.getitemnumber(lFind1, "nhandling_meal_key") = lforeignMealKey then continue
				
				// 23.09.2015 HR: Hier muss die $$HEX1$$c400$$ENDHEX$$nderunge aber rein (Overload Korrektur - CBASE-HKG-EM-15001)
				// 10.10.2016 HR: ALM-ID #1687: Nur eingeschaltetem Abz$$HEX1$$fc00$$ENDHEX$$ge ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
				sFind = "noverload  > nreduced and nhandling_detail_key = "+string(dscenmealsdetdeduction.getitemnumber(lFind1, "nhandling_detail_key"))	 + " and nreduce = 1" 
				
				lFind = dw_meal.Find(sFind,1,dw_meal.RowCount())
				
				if lFind > 0 then
					lforeignMealKey =  dw_meal.GetItemNumber(lFind, "nhandling_meal_key")
	
					// Es wurde eine $$HEX1$$dc00$$ENDHEX$$berbeladung f$$HEX1$$fc00$$ENDHEX$$r diese Mahlzeitenkomponente gefunden
					lOverload	= dw_meal.GetItemNumber(lFind,"noverload")
					lReduction 	= dw_meal.GetItemNumber(lFind,"nreduced")	// das was schon reduziert wurde
					if isnull(lReduction) then lReduction = 0
		
					lPercentage 	= dw_meal.GetItemNumber(i,"npercentage")
					lQuantity 		= dw_meal.GetItemNumber(i,"nquantity")
					lQuantityOld 	= dw_meal.GetItemNumber(i,"nquantity_old")	// f$$HEX1$$fc00$$ENDHEX$$r den Abgleich
					
					if lPercentage = 0 or lPercentage = 100 then
						lReduce = lOverload
					else
						lReduce = ceiling(lOverload * lPercentage / 100)	// das was aktuell zu reduzieren ist
						if lReduce = 0 then 
							lReduce = 1 
							// Messagebox("", "lReduce = 0 ---> lReduce = 1" )
						end if
						lReductionCheck = lReduction + lReduce
					end if
		
					if lReductionCheck > lOverload then
						// falls mehr abgezogen werden soll, als noch vorhanden ist
						lNewQuantity = lQuantity - (lOverload - lReduction)
					else
						lNewQuantity = lQuantity - lReduce
						//Messagebox( "lNewQuantity = lQuantity - lReduce", sPL)
					end if
					
					if lNewQuantity < 0 then lNewQuantity = 0
					
					if lNewQuantity <> lQuantity then
						// Messagebox("lNewQuantity <> lQuantity Menge wird ge$$HEX1$$e400$$ENDHEX$$ndert", sPL)
						dw_meal.SetItem(i,"nquantity",lNewQuantity)
					end if
					
					// Markiererei
					if lNewQuantity <> lQuantityOld then
						dw_meal.SetItem(i,"status_nquantity",1)
					else
						// auf jeden Fall auch die Markierung zur$$HEX1$$fc00$$ENDHEX$$cksetzen
						dw_meal.SetItem(i,"status_nquantity",0)
					end if
					
					lReduction = lReduction + lReduce
					dw_meal.SetItem(lFind,"nreduced",lReduction)
					
				end if
			next
		end if
	next

	// Zahlen formatieren
	dw_meal.Modify("nquantity.Format='#,###,##0'")
	dw_meal.Modify("nquantity_old.Format='#,###,##0'")
//	wf_meal_marker(dw_meal)
//	dw_meal.SetRedraw(true)

//	f_print(dw_meal)

end if



return true


end function

public function str_actype of_get_actype_structure (long lkey, ref string arg_config);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_flight_calculation
// Methode: of_get_actype_structure (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long lkey
//  ref string arg_config
// --------------------------------------------------------------------------------------------------------------------
// Return: str_actype
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  02.09.2015	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

str_actype strRet
string			sACConfig

SELECT 	cen_aircraft.cactype,   
  			cbase_functions.pf_get_aircraft_config(:lkey , -1),   
         	cen_aircraft.cgalleyversion,
			cen_aircraft.nairline_owner_key,
         	cen_aircraft.cconfiguration
    INTO 	:strRet.cactype,   
         	:strRet.cconfig,   
         	:strRet.cgalleyversion,
			:strRet.lOwner,
			:sACConfig
    FROM cen_aircraft  
   WHERE cen_aircraft.naircraft_key = :lkey   ;

if sqlca.sqlcode = 100 then
	strRet.cactype        = "Not found"
	strRet.cconfig        = ""
	strRet.cgalleyversion = ""
	strRet.lOwner			 = -1
		
elseif sqlca.sqlcode <> 0 then
	strRet.cactype        = "ERROR"
	strRet.cconfig        = ""
	strRet.cgalleyversion = ""
	strRet.lOwner			 = -1	
	f_db_error(sqlca, "of_get_actype_structure() ")
else
	if isnull(arg_config) or arg_config = sACConfig then
		arg_config = strRet.cconfig
	end if
end if
	
return strRet
end function

public function integer wf_regenerate_paclos ();// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_flight_calculation
// Methode: wf_regenerate_paclos (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: CBASE-NAM-CR-15014: Es soll bei der Nachberechnung auch die Packages/LOS neu 
//                                                          lesen
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  24.11.2015	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

return wf_regenerate_paclos (date(dw_single.getitemdatetime(1,"dreturn_date")), &
                                             dw_single.getitemstring(1,"cairline"), &
									     dw_single.getitemnumber(1,"nflight_number"), &
										 dw_single.getitemstring(1,"csuffix"), &
										 dw_single.getitemstring(1,"ctlc_from"), &
										 dw_single.getitemstring(1,"ctlc_to"), &
										 dw_single.getitemnumber(1,"nleg_number"), &
										 dw_single.getitemnumber(1,"nresult_key"), &
										 dw_single.getitemnumber(1,"nresult_key_group"), &
										 dw_single.getitemnumber(1,"nairline_key"), &
										 date(dw_single.getitemdatetime(1,"ddeparture")))


end function

public function integer wf_wab_send_galleyweights (long al_resultkey);
/* 
* Function: 			wf_wab_send_galleyweights
* Beschreibung: 	Ermittelt die Galleygewichte f$$HEX1$$fc00$$ENDHEX$$r den Flug und schreibt in cen_request_out
* Besonderheit: 	...
*
* Argumente:
* 		arg_name 	Beschreibung
*
* Aenderungshistorie:
* 	Version 	Wer					Wann			Was und warum
*	1.0 		Thomas Schaefer	25.01.2016	Erstellung
*	1.1 		Thomas Schaefer	16.08.2016	Logging eingebaut
*
* Return Codes:
*	 ...
*/

String					ls_msg
uo_request_out		luo_request_out

luo_request_out = CREATE uo_request_out

IF NOT luo_request_out.uf_request_out_auto_wab(al_resultkey, ls_msg) THEN
	f_Log2Csv(0,1,"[wf_wab_send_galleyweights] Error sending weights for flight " + String(al_resultkey) + ": " + ls_msg)
ELSE
	f_Log2Csv(0,1,"[wf_wab_send_galleyweights] Send weights for flight " + String(al_resultkey) + ": " + ls_msg)
END IF

DESTROY luo_request_out

Return 1

end function

public function boolean of_recalc_pax (long arg_lrow, ref string arg_sclassname[], ref integer arg_iseatversion[], ref integer arg_iforecast[], ref string arg_sconfiguration, ref long arg_laircraftkey, ref string arg_sregistration, integer arg_iclassnumberbooking[], long arg_lairlinekey);// --------------------------------------------------------------------------------------------------------------------
// Objekt : w_change_center
// Methode: wf_recalc_pax (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// $$HEX1$$c400$$ENDHEX$$nderungen an dieser Funktion m$$HEX1$$fc00$$ENDHEX$$ssen auch in den Userobjekten
// - uo_generate.of_recalc_pax
// - uo_generate_ifms.of_recalc_pax
// - w_change_center.wf_recalc_pax
// nachgezogen werden 
// --------------------------------------------------------------------------------
// Argument(e):
// long arg_lrow
//  ref string arg_sclassname[]
//  ref integer arg_iseatversion[]
//  ref integer arg_iforecast[]
//  ref string arg_sconfiguration
//  ref long arg_laircraftkey
//  ref string arg_sregistration
// integer arg_iclassnumberbooking[]
// --------------------------------------------------------------------------------------------------------------------
// Return: boolean
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Hier werden die Regeln der Paxanpassungen 
//                          abgearbeitet
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  08.09.2009	   1.0      Heiko Rothenbach   Erstellung
//  02.06.2010	   1.1      H.Rothenbach   		Korrektur
//  28.06.2010	   1.2      Oliver H$$HEX1$$f600$$ENDHEX$$fer   		Korrektur CITP (Mail von HR)
//
// --------------------------------------------------------------------------------------------------------------------

datastore 	lds_adjust, lds_acsearch, lds_classes
string 		ls_cunit, ls_cairline, ls_ctl_from, ls_ctl_to, ls_crouteing, ls_flgnr, ls_cdeparture_time, ls_offset, ls_kind, ls_cclass, ls_upclass[], ls_filter, ls_version, ls_pax
string 		ls_ac_owner, ls_ac_type, ls_reg
long			ll_nflight_number, ll_nresult_key, ll_version, ll_naircraft_key 
long  			ll_pax_old, ll_pax_new, ll_found
integer 		li_overload[], li_upgrade[], li_findversion, li_red_add_delivery[], li_kind
integer 		i, li_check_version, j
date 			dGenerationDate
string 		ls_galley
Integer		li_seatversion_imp[]
String			ls_configuration_imp

wf_chc_trace(50,"[of_recalc_pax] Start")

li_seatversion_imp 	= arg_iseatversion
ls_configuration_imp 	= arg_sconfiguration
li_findversion 			= 0
li_check_version 		= 0

ls_cunit 					= dw_single.GetItemString(arg_lrow,"cunit")
dGenerationDate    	= date(dw_single.GetItemdatetime(arg_lrow,"ddeparture"))
ls_cairline				= dw_single.GetItemString(arg_lrow,"cairline")
ll_nflight_number 		= dw_single.GetItemNumber(arg_lrow,"nflight_number")
ls_ctl_from				= dw_single.GetItemString(arg_lrow,"ctlc_from")
ls_ctl_to					= dw_single.GetItemString(arg_lrow,"ctlc_to")
ls_crouteing				= dw_single.GetItemString(arg_lrow,"crouting")

ls_flgnr = ls_cunit + "-"+string(dGenerationDate, "dd.mm.yyyy")+"-"+ls_cairline+" "+string(ll_nflight_number,"0000")+ "-"
ls_flgnr = ls_flgnr +ls_ctl_from+"-"+ls_ctl_to	+"-"+ls_crouteing +": "

if is_set = "none" then 
	wf_chc_trace(50,"[of_recalc_pax] " + ls_flgnr + "Keine lokalen Anpassungen verwenden.")
	return true
end if

ll_nresult_key 			= dw_single.GetItemNumber(arg_lrow,"nresult_key")
ls_cdeparture_time	= dw_single.GetItemString(arg_lrow,"cdeparture_time")
ll_naircraft_key      	= dw_single.GetItemNumber(arg_lrow,"naircraft_key")
ls_ac_owner			= dw_single.GetItemString(arg_lrow,"cairline_owner")
ls_ac_type				= dw_single.GetItemString(arg_lrow,"cactype")
ls_reg 					= dw_single.GetItemString(arg_lrow,"cregistration")
ls_galley					= dw_single.GetItemString(arg_lrow,"cgalleyversion") 

lds_classes = create datastore
lds_classes.dataobject="dw_airline_classes"
lds_classes.settransobject(SQLCA)
lds_classes.retrieve(arg_lairlinekey)

lds_adjust = create datastore
lds_adjust.dataobject="dw_altea_local_adjustments_impbrowser"
lds_adjust.settransobject(SQLCA)

lds_adjust.setfilter("nfreq"+string(f_getfrequence(dGenerationDate))+"=1")
lds_adjust.retrieve(arg_lairlinekey, ls_cunit, dGenerationDate, ls_cairline, ll_nflight_number, ls_ctl_from, ls_ctl_to, ls_crouteing, ls_cdeparture_time, is_set)

wf_chc_trace(50,"[of_recalc_pax] " + ls_flgnr + "Anzahl m$$HEX1$$f600$$ENDHEX$$glicher Regeln f$$HEX1$$fc00$$ENDHEX$$r Set "+is_set+": "+string(lds_adjust.rowcount()))
of_log_jobstate(1, uf.translate("Anzahl m$$HEX1$$f600$$ENDHEX$$glicher Regeln f$$HEX1$$fc00$$ENDHEX$$r Set ")+is_set+": "+string(lds_adjust.rowcount()))
if lds_adjust.rowcount()=0 then 
	destroy lds_adjust
	destroy lds_classes
	
	return true
end if

// --------------------------------------------------------------------------------
//Paxe anpassen
// --------------------------------------------------------------------------------

for i=1 to upperbound(arg_sClassName)
	li_upgrade[i]				= 0
	li_red_add_delivery[i]		= 0
	li_overload[i]				= 0
	ls_upclass[i]					= "none"
	ls_cclass 					= arg_sClassName[i]

	if lds_classes.getitemnumber(i,"nbooking_class")=0 then continue 
	
	//Erste Suche: Gibt es f$$HEX1$$fc00$$ENDHEX$$r die Flugnummer und Klasse einem Eintrag
	ll_found = lds_adjust.find("nkind = 1 and cclass='"+ls_cclass+"'",1,lds_adjust.rowcount())
	
	if ll_found=0 then
		//Zweite Suche: Gibt es f$$HEX1$$fc00$$ENDHEX$$r das Citypair und Klasse einem Eintrag
		ll_found = lds_adjust.find("nkind = 2 and cclass='"+ls_cclass+"'",1,lds_adjust.rowcount())

		if ll_found=0 then
			//Dritte Suche: Gibt es f$$HEX1$$fc00$$ENDHEX$$r das Strecke und Klasse einem Eintrag
			ll_found = lds_adjust.find("nkind = 3 and cclass='"+ls_cclass+"'",1,lds_adjust.rowcount())

			if ll_found=0 then 	continue

			li_kind=3
			ls_kind=uf.translate("Strecke")
		else
			li_kind=2
			ls_kind=uf.translate("CityPair")
		end if
	else
		li_kind=1
		ls_kind=uf.translate("Flugnummer")
	end if
	
	//Allgemeine Parameter f$$HEX1$$fc00$$ENDHEX$$r sp$$HEX1$$e400$$ENDHEX$$ter merken
	li_overload[i] 		= lds_adjust.getitemnumber(ll_found,"noverload") 
	
	if lds_adjust.getitemnumber(ll_found,"nupgrade") >0 then 				li_upgrade[i] 				= lds_adjust.getitemnumber(ll_found,"nupgrade")
	if lds_adjust.getitemnumber(ll_found,"nfind_version") = 1 then 		li_findversion				= 1
	if lds_adjust.getitemnumber(ll_found,"nred_add_delivery") >0 then 	li_red_add_delivery[i] 	= lds_adjust.getitemnumber(ll_found,"nred_add_delivery")
	
	if isnull( lds_adjust.getitemstring(ll_found,"cclass_upgrade")) or trim( lds_adjust.getitemstring(ll_found,"cclass_upgrade"))="" then
		ls_upclass[i]		="none"
	else
		ls_upclass[i]		= lds_adjust.getitemstring(ll_found,"cclass_upgrade")
	end if
	
	//Paxe anpassen
	ll_pax_old 			= arg_iForecast[i]
	
	if lds_adjust.getitemnumber(ll_found,"npercent_pax") = 0 then
		//Paxoffset ist in Prozent
		ll_pax_new 	= ll_pax_old + (ll_pax_old * lds_adjust.getitemnumber(ll_found,"noffset") / 100) + .5
		ls_offset 		= string( lds_adjust.getitemnumber(ll_found,"noffset"))+"%"
	else
		//Paxoffset ist Absolut
		ll_pax_new 	= ll_pax_old + lds_adjust.getitemnumber(ll_found,"noffset")
		ls_offset 		= string( lds_adjust.getitemnumber(ll_found,"noffset"))
	end if
	
	if arg_iForecast[i] <>  ll_pax_new then
		arg_iForecast[i] 	=  ll_pax_new
		wf_chc_trace(50,"[of_recalc_pax] " + ls_flgnr + "Paxanpassung Klasse "+ls_cclass+" wegen "+ls_kind +"-Regel : Pax Alt: "+string(ll_pax_old)+" Pax Neu: "+string(ll_pax_new)+" Offset "+ls_offset)
		
		of_log_jobstate(1, uf.translate("Paxanpassung f$$HEX1$$fc00$$ENDHEX$$r Klasse ${"+ls_cclass+"} wegen ${"+ls_kind +"}-Regel : Pax Alt: ${"+string(ll_pax_old)+"} Pax Neu: ${"+string(ll_pax_new)+"} Offset ")+ls_offset)
	end if
next

// --------------------------------------------------------------------------------
//Version bestimmen
// --------------------------------------------------------------------------------
if li_findversion=1 then
	ll_found = 0
		
	for i=1 to  upperbound(arg_sClassName)
		if lds_classes.getitemnumber(i,"nbooking_class")=0 then continue //nur f$$HEX1$$fc00$$ENDHEX$$r buchungsklassen relevant

		if arg_iSeatVersion[i] < arg_iForecast[i] then
			ll_found=1
		end if
	next
	
	if ll_found=1 then
		// --------------------------------------------------------------------------------
		// Wenn Paxe nicht in Version  passen, dann passende Version suchen
		// --------------------------------------------------------------------------------
		lds_acsearch = create datastore
		lds_acsearch.dataobject="dw_aircraftversion_search"
		lds_acsearch.settransobject(SQLCA)
		
		lds_acsearch.retrieve(ll_naircraft_key)
	
		ls_filter		= ""
		ls_version 	= ""
		ls_pax 	  	= ""
		
		for i=1 to upperbound(arg_sClassName)
			if lds_classes.getitemnumber(i,"nbooking_class")=0 then continue //nur f$$HEX1$$fc00$$ENDHEX$$r buchungsklassen relevant
			
			ls_cclass = arg_sClassName[i]
			ll_pax_old = arg_iForecast[i]
			
			ll_found=lds_acsearch.find("nclass"+string(i)+" >= "+string(ll_pax_old), 1, lds_acsearch.rowcount())
			
			if ll_found=0 then 
				if lds_acsearch.rowcount()>0 then
					ll_found=lds_acsearch.rowcount()
				else
					wf_chc_trace(50,"[of_recalc_pax] " + ls_flgnr + "Versionsanpassung: kein Zeile mehr in lds_acsearch. Paxzeile "+ string(i)+"; ls_version: "+ls_version +";ls_pax: "+ls_pax)
					ll_found = -1
					exit
				end if
			end if
			
			ll_pax_new = lds_acsearch.getitemnumber(ll_found, "nclass"+string(i))
	
			lVersionGroupKey = lds_acsearch.GetItemNumber(ll_found,"ngroup_key")
			li_check_version = 0
	
			ls_version += string(ll_pax_new, "000")+"-"				
			ls_pax += string(ll_pax_old, "000")+"-"				
			
			arg_iSeatVersion[i] = ll_pax_new 
			
			if ls_filter="" then
				ls_filter = "nclass"+string(i)+" = "+string(ll_pax_new)
			else
				ls_filter += " and nclass"+string(i)+" = "+string(ll_pax_new)
			end if
			
			lds_acsearch.setfilter(ls_filter)
			lds_acsearch.filter()
		next
		
		if ll_found<> -1 then
			ls_version = left(ls_version, len(ls_version) -1)
			ls_pax = left(ls_pax, len(ls_pax) -1)
			
			if ls_version <>  dw_single.GetItemString(arg_lrow,"cconfiguration") then
				wf_chc_trace(50,"[of_recalc_pax] " + ls_flgnr + "Versionsanpassung: Alt: "+ dw_single.GetItemString(arg_lrow,"cconfiguration")+"; Pax: "+ls_pax +"; Neu: "+ls_version)
				of_log_jobstate(1, uf.translate("Versionsanpassung: Alt: ${"+ dw_single.GetItemString(arg_lrow,"cconfiguration")+"}; Pax: ${"+ls_pax +"}; Neu: ")+ls_version)
				
				arg_sconfiguration = ls_version
			end if
		else
			destroy lds_acsearch
			destroy lds_adjust
			destroy lds_classes
			
			garbagecollect()
			return false
		end if	
		destroy lds_acsearch
	end if
end if    

// --------------------------------------------------------------------------------
//$$HEX1$$dc00$$ENDHEX$$berbeladung abschneiden und ggf Upgraden
// --------------------------------------------------------------------------------
for i =  upperbound(arg_sClassName) to 1 step -1
	if lds_classes.getitemnumber(i,"nbooking_class")=0 then continue //nur f$$HEX1$$fc00$$ENDHEX$$r buchungsklassen relevant
	
	ls_cclass 	= arg_sClassName[i]
	ll_pax_old 	= arg_iForecast[i]
	ll_version 	= arg_iSeatVersion[i]

	if li_overload[i]=0 then
		if ll_pax_old > ll_version then
			ll_pax_new 			= ((ll_pax_old - ll_version) * li_upgrade[i] / 100 ) + .5
			arg_iForecast[i] 	= ll_version
			if ls_upclass[i]="none" then
				wf_chc_trace(50,"[of_recalc_pax] " + ls_flgnr + "Paxanpassung Klasse "+ls_cclass+", da $$HEX1$$dc00$$ENDHEX$$berbeladung abgeschnitten werden soll. Pax Alt: "+string(ll_pax_old)+" Pax Neu: "+string(ll_version)+" keine Upgradeklasse definiert")
				of_log_jobstate(1, uf.translate("Paxanpassung Klasse ${"+ls_cclass+"}, da $$HEX1$$dc00$$ENDHEX$$berbeladung abgeschnitten werden soll. Pax Alt: ${"+string(ll_pax_old)+"} Pax Neu: ${"+string(ll_version)+"} keine Upgradeklasse definiert"))
			else
				wf_chc_trace(50,"[of_recalc_pax] " + ls_flgnr + "Paxanpassung Klasse "+ls_cclass+", da $$HEX1$$dc00$$ENDHEX$$berbeladung abgeschnitten werden soll. Pax Alt: "+string(ll_pax_old)+" Pax Neu: "+string(ll_version)+" Upgrade "+string(ll_pax_new)+" Paxe ("+string( li_upgrade[i])+"%) nach "+ ls_upclass[i] )
				of_log_jobstate(1, uf.translate("Paxanpassung Klasse ${"+ls_cclass+"}, da $$HEX1$$dc00$$ENDHEX$$berbeladung abgeschnitten werden soll. Pax Alt: ${"+string(ll_pax_old)+"} Pax Neu: ${"+string(ll_version)+"} Upgrade ${"+string(ll_pax_new)+"} Paxe (${"+string( li_upgrade[i])+"}%) nach ")+ ls_upclass[i] )
				for ll_found = 1 to upperbound(arg_sClassName)
					if  ls_upclass[i] = arg_sClassName[ll_found] then
						ll_pax_old 					= arg_iForecast[ll_found]
						arg_iForecast[ll_found]	= ll_pax_old + ll_pax_new
						
						exit
					end if
				next
			end if
		end if
	elseif  ll_pax_old > ll_version then
		wf_chc_trace(50,"[of_recalc_pax] " + ls_flgnr + "keine Paxanpassung Klasse "+ls_cclass+", da $$HEX1$$dc00$$ENDHEX$$berbeladung gew$$HEX1$$fc00$$ENDHEX$$nscht")		
	end if
next

// --------------------------------------------------------------------------------
//Nachfahrten reduzieren
// --------------------------------------------------------------------------------
for i = 1 to  upperbound(arg_sClassName)
	if lds_classes.getitemnumber(i,"nbooking_class")=0 then continue //nur f$$HEX1$$fc00$$ENDHEX$$r buchungsklassen relevant
	
	ll_pax_old = arg_iForecast[i]
	ll_version = arg_iSeatVersion[i]
	ls_cclass = arg_sClassName[i]
	
	if ll_pax_old >= ll_version - li_red_add_delivery[i] and ll_pax_old < ll_version then
		arg_iForecast[i]  =  ll_version
		wf_chc_trace(50,"[of_recalc_pax] " + ls_flgnr + "Paxanpassung Nachfahrtenreduktion Klasse "+ls_cclass+" Pax old: "+string(ll_pax_old)+" Version: "+string(ll_version)+" FH ab "+string(ll_version - li_red_add_delivery[i])+" Paxe")
		of_log_jobstate(1, uf.translate("Paxanpassung wegen Nachfahrtenreduktion Klasse ${"+ls_cclass+"} Pax old: ${"+string(ll_pax_old)+"} Version: ${"+string(ll_version)+"} Fullhouse ab ${"+string(ll_version - li_red_add_delivery[i])+"} Paxe"))
	end if 
next
ls_version =""

for i=1 to upperbound(arg_iSeatVersion)
	if lds_classes.getitemnumber(i,"nbooking_class")=0 then continue //nur f$$HEX1$$fc00$$ENDHEX$$r buchungsklassen relevant
	
	ls_version += string(arg_iSeatVersion[i],"000") + "-"
next

arg_sconfiguration = left(ls_version, len(ls_version) -1)


destroy lds_adjust
destroy lds_classes

garbagecollect()

return true

end function

public function long of_get_version_group_key ();//-----------------------------------------------------------------------------------
//
// wf_get_version_group_key
//
// Holt den Version-Group-Key f$$HEX1$$fc00$$ENDHEX$$r dieses Flugger$$HEX1$$e400$$ENDHEX$$t
// und bezieht sich dabei auf die in dw_single angezeigten Daten!
//
//-----------------------------------------------------------------------------------
string	sAircraftOwner
string	sAircraftType
string	sClassName[]
integer	iSeatVersion[]
integer	iClassNumber[]
string	sMessage
long		i
long		lKey
long		lAirline_Key

uo_get_aircraft uo_get_ac

lKey = -1

//
// Initialisierung
//
sAircraftOwner	= dw_single.GetItemString(dw_single.GetRow(),"cairline_owner")
sAircraftType	= dw_single.GetItemString(dw_single.GetRow(),"cactype")
lAirline_Key	= dw_single.GetItemNumber(dw_single.GetRow(),"nairline_key")

for i = 1 to dw_pax.RowCount()
	if dw_pax.GetItemNumber(i,"nbooking_class") <> 1 then
		//
		// Klasse ist keine Buchungsklasse und zur Ermittlung der Version 
		// nicht geeignet
		//
		exit
	end if
	iSeatVersion[i] 			= dw_pax.GetItemNumber(i,"nversion")
	sClassName[i] 				= dw_pax.GetItemString(i,"cclass")
	iClassNumber[i] 			= dw_pax.GetItemNumber(i,"nclass_number")
next

//
// Abfrage
//
uo_get_ac = create uo_get_aircraft

uo_get_ac.sOwner 				= sAircraftOwner
uo_get_ac.sActype 			= sAircraftType
uo_get_ac.sClass[]			= sClassName[]
uo_get_ac.iVersion[]			= iSeatVersion[]
uo_get_ac.iClassNumber[]	= iClassNumber[]
uo_get_ac.lAirline_Key		= lAirline_Key

if uo_get_ac.of_get_aircraft() <> 0 then
	is_AircraftVersionString = ""
	sMessage	= uf.translate("Flugdaten enthalten ein unbekanntes Flugger$$HEX1$$e400$$ENDHEX$$t.")
	destroy uo_get_ac
	return -1
end if

lKey	= uo_get_ac.lGroup_key

// 13.01.2011 HR: Wir holen uns auch den Versionsstring
is_AircraftVersionString = uo_get_ac.sVersionString

destroy uo_get_ac

return lKey

end function

public function boolean of_recalc_pax_fc ();string			sClassNameBooking[], sImportConfiguration, sImportRegistration
integer		iSeatVersionBooking[], iForecast[], iClassNumberBooking[], i
long			lImportAircraftKey, lAirlinekey   

lAirlineKey				= dw_single.GetitemNumber(1,"nairline_key")
lImportAircraftKey		= dw_single.GetItemNumber(1,"naircraft_key")
sImportRegistration	= dw_single.GetItemString(1,"cregistration")
sImportConfiguration	= dw_single.GetItemString(1,"cconfiguration")

for i=1 to dw_pax.rowcount()
	sClassNameBooking[i] 	= dw_pax.getitemstring(i, "cclass")
	iSeatVersionBooking[i] 	= dw_pax.getitemnumber(i, "nversion")
	iForecast[i] 					= dw_pax.getitemnumber(i, "npax")
	iClassNumberBooking[i] 	= dw_pax.getitemnumber(i, "nclass_number")	
next

of_recalc_pax(1, sClassNameBooking, iSeatVersionBooking, iForecast, sImportConfiguration , lImportAircraftKey, sImportRegistration, iClassNumberBooking, lAirlineKey)

for i=1 to dw_pax.rowcount()
	if iSeatVersionBooking[i] <> dw_pax.getitemnumber(i, "nversion") then dw_pax.setitem(i, "nversion", iSeatVersionBooking[i])
	if iForecast[i] <> dw_pax.getitemnumber(i, "npax") then dw_pax.setitem(i, "npax", iForecast[i])
next

If sImportConfiguration <> dw_single.GetitemString(dw_single.Getrow(),"cconfiguration") Then
	dw_single.Setitem(dw_single.getrow(),"cconfiguration",sImportConfiguration)
	dw_single.Setitem(dw_single.getrow(),"status_cconfiguration",1)
End if

return true
end function

public function integer of_process_new_flight (long arg_row);uo_generate 	 			uo_change
long							ll_offset, ll_result_key_group, i, ll_opcode_key
s_city_pairs					strCP
datetime 					ldt_departure 
string							sFrequenz, sCode
integer 						lidel, liReturn, iStatus

uo_change 											= create uo_generate

uo_change.iJob_Type							= 11
uo_change.ii_generate_jobtype				= 3
uo_change.iPaxType								= 1
uo_change.lResultKey     						= dsJobs.GetItemNumber(arg_row, "nresult_key")
uo_change.sUnit									= dsJobs.GetItemString(arg_row, "cunit")

uo_change.idebug_level 						= s_app.iTrace
uo_change.sTraceFile 							= sLogPathFileName+"_"+ String(Today(), "yyyymmdd") // 09.03.2012 HR: LOGFILE-GEN sonst ohne Datum
uo_change.sInstanceName 						= sinstance
uo_change.dsRatioCache 						= dsRatioCache
uo_change.iUseSequenceForCenOutMeals 	= iUseSequenceForMeals
uo_change.bCallByWebService 				= True 

uo_change.dsCenOut.dataobject = "dw_change_cen_out"
uo_change.dsCenOut.settransobject( SQLCA)
uo_change.dsCenOut.retrieve( uo_change.lResultKey )

if uo_change.dsCenOut.rowcount() = 1 then
	uo_change.lRoutingPlanKey			= uo_change.dsCenOut.GetItemNumber(1, "NROUTINGPLAN_INDEX")
	uo_change.lAirlinekey					= uo_change.dsCenOut.GetItemNumber(1, "nairline_key")
	uo_change.lTlcFrom					= uo_change.dsCenOut.getitemnumber(1, "ntlc_from")
	uo_change.lTlcTo						= uo_change.dsCenOut.getitemnumber(1, "ntlc_to")
	uo_change.sTlcFrom					= uo_change.dsCenOut.GetItemString(1, "ctlc_from")
	uo_change.sTlcTo						= uo_change.dsCenOut.GetItemString(1, "ctlc_to")
	uo_change.lOwnerKey				= uo_change.dsCenOut.getitemnumber(1, "NAIRLINE_OWNER_KEY")
	uo_change.dNewGenerationDate 	= date(uo_change.dsCenOut.GetItemdatetime(1,"dreturn_date"))
	uo_change.dGenerationDate			= uo_change.dNewGenerationDate
	uo_change.lTransActionKey			= uo_change.dsCenOut.getitemnumber(1, "NTRANSACTION")
	uo_change.sAirline 					= uo_change.dsCenOut.GetItemString(1,"cairline")
	uo_change.sSuffix						= uo_change.dsCenOut.getitemstring(1, "CSUFFIX")
	uo_change.lFlightnumber			= uo_change.dsCenOut.getitemnumber(1, "NFLIGHT_NUMBER")
	uo_change.LRoutingId				= uo_change.dsCenOut.getitemnumber(1, "NROUTING_ID")
	uo_change.sDepartureTime			= uo_change.dsCenOut.getitemstring(1, "CDEPARTURE_TIME")
	iStatus									= uo_change.dsCenOut.getitemnumber(1, "nstatus")
	uo_change.lLegNumber				= uo_change.dsCenOut.getitemnumber(1, "NLEG_NUMBER")
	uo_change.lRoutingPlanDetailKey		= uo_change.dsCenOut.getitemnumber(1, "NROUTINGDETAIL_KEY")
	uo_change.lRoutingPlanDetailKey_CP	= uo_change.dsCenOut.getitemnumber(1, "NROUTINGDETAIL_KEY_CP")

	if uo_change.of_use_owner_for_trafficarea(this.smandant, uo_change.lAirlinekey	) then
		strCP = f_get_traffic_area_structure(uo_change.lTlcFrom, uo_change.lTlcTo, uo_change.lOwnerKey, uo_change.dNewGenerationDate)
	else
		strCP = f_get_traffic_area_structure(uo_change.lTlcFrom, uo_change.lTlcTo, uo_change.lAirlinekey	, uo_change.dNewGenerationDate)
	end if

	uo_change.dsCenOut.SetItem(1, "nrefund", strCP.iRefund)
	uo_change.dsCenOut.SetItem(1, "CTRAFFIC_AREA", strCP.sFullName)
	uo_change.dsCenOut.SetItem(1, "CTRAFFIC_AREA_SHORT", strCP.sName)

	uo_change.dsLocalTimes.Retrieve( this.smandant, uo_change.sUnit, uo_change.lAirlinekey	)	
	uo_change.dsLocalTimesFlights.Retrieve(this.smandant, uo_change.sUnit, uo_change.lAirlinekey	)	

	uo_change.of_set_internal_times() 

	uo_change.dsCenOut.setitem(1, "CRAMP_TIME", uo_change.sRampTime)
	uo_change.dsCenOut.setitem(1, "CKITCHEN_TIME", uo_change.sKitchenTime)

	uo_change.dsCenOut.setitem(1, "cflight_key", uo_change.of_create_cflightkey( uo_change.dNewGenerationDate,  uo_change.sAirline,  uo_change.lFlightnumber, &
																										 uo_change.sSuffix,  uo_change.sTlcFrom,  uo_change.sTlcTo))

	SELECT cen_airlines.ntb  
		 INTO :uo_change.ii_trainbusiness  
		 FROM cen_airlines  
		WHERE cen_airlines.nairline_key = :uo_change.lAirlinekey	;

	uo_change.dsCenOut.SetItem(1, "ntb", uo_change.ii_trainbusiness)

	ldt_departure = datetime(uo_change.dNewGenerationDate, time(uo_change.sDepartureTime))
	uo_change.dsCenOut.SetItem(1, "ddeparture_time_loc", ldt_departure)
	uo_change.dsCenOut.SetItem(1, "darrival_time_loc", f_dt_add(ldt_departure,600))
	
	select ngmt into :ll_offset from sys_three_letter_codes where ntlc_key=:uo_change.lTlcFrom;
	
	if sqlca.sqlcode=0 then
		ldt_departure = f_dt_add(ldt_departure, ll_offset * -3600  )
		uo_change.dsCenOut.SetItem(1, "ddeparture_time_utc", ldt_departure)
		uo_change.dsCenOut.SetItem(1, "noffset_dep", ll_offset)
		uo_change.dsCenOut.SetItem(1, "darrival_time_utc", f_dt_add(ldt_departure, 600))
	end if	

	uo_change.of_get_handling_joker()
	
	if uo_change.dsCenOut.GetitemNumber(1, "nresult_key")  <> uo_change.dsCenOut.GetitemNumber(1, "nresult_key_group") then
		ll_result_key_group = uo_change.dsCenOut.GetitemNumber(1,"nresult_key_group")
		
		select CDEPARTURE_TIME, DDEPARTURE,  CRAMP_TIME, CKITCHEN_TIME, NTLC_FROM
		into :uo_change.sFirstLegTime, :uo_change.dtFirstLegDeparture, :uo_change.sFirstLegRampTime, :uo_change.sFirstLegKitchenTime, :uo_change.lFirstLegTLC_From 
		from cen_out
		where nresult_key = :ll_result_key_group;
		
		if sqlca.sqlcode=0 then
			uo_change.dsCenOut.SetItem(1, "CDEPARTURE_TIME", uo_change.sFirstLegTime)
			uo_change.dsCenOut.SetItem(1, "CSORT_TIME", uo_change.sFirstLegTime)
			uo_change.dsCenOut.SetItem(1, "DDEPARTURE", uo_change.dtFirstLegDeparture)
			uo_change.dsCenOut.SetItem(1, "CRAMP_TIME", uo_change.sFirstLegRampTime)
			uo_change.dsCenOut.SetItem(1, "CKITCHEN_TIME", uo_change.sFirstLegKitchenTime)
			uo_change.dsCenOut.SetItem(1, "NPARENT_TLC_FROM", uo_change.lFirstLegTLC_From)
		end if
	else
		uo_change.dsCenOut.SetItem(1, "NPARENT_TLC_FROM", uo_change.lTlcFrom)
		uo_change.dsCenOut.SetItem(1, "CSORT_TIME", uo_change.sDepartureTime)
	end if
	
	uo_change.dsCentralForecast.Retrieve(uo_change.lAirlineKey,uo_change.dGenerationDate)		
	uo_change.dsLocalForecast.Retrieve(uo_change.lAirlineKey,uo_change.dGenerationDate)	
	
	sFrequenz 				= "nfreq" + string(f_getfrequence(uo_change.dNewGenerationDate)) + "=1"
	i = uo_change.dsHandlingObjects.retrieve(uo_change.lRoutingPlanDetailKey, uo_change.dNewGenerationDate, uo_change.sUnit)
	uo_change.dsHandlingObjects.SetFilter(sFrequenz)
	uo_change.dsHandlingObjects.Filter()

	i = uo_change.dsHandlingObjects_cp.retrieve(uo_change.lRoutingPlanDetailKey_CP, uo_change.dNewGenerationDate, uo_change.sUnit)
	uo_change.dsHandlingObjects_cp.SetFilter(sFrequenz)
	uo_change.dsHandlingObjects_cp.Filter()
	
	uo_change.dsAirlineClasses.retrieve(uo_change.lAirlinekey	)
	
	wf_regenerate_paclos (uo_change.dNewGenerationDate, &
                                              uo_change.sAirline, &
									     uo_change.lFlightnumber, &
										 uo_change.sSuffix, &
										 uo_change.sTlcFrom, &
										 uo_change.sTlcTo, &
										 uo_change.lLegNumber, &
										 uo_change.lResultKey, &
										 uo_change.dsCenOut.GetitemNumber(1, "nresult_key_group"), &
										 uo_change.lAirlinekey, &
										 uo_change.dNewGenerationDate)
	
	uo_change.dscenoutlos.retrieve(uo_change.dsCenOut.GetitemNumber(1, "nresult_key_group"))
	
	uo_change.dscenoutpackets.dataobject="dw_cen_out_packets_all_legs"
	uo_change.dscenoutpackets.settransobject( SQLCA)
	uo_change.dscenoutpackets.retrieve(uo_change.dsCenOut.GetitemNumber(1, "nresult_key_group"))
	
	// Jetzt Erstellen wir die Beladung
	uo_change.of_generate_handling_objects()
	
	select COPCODE, NOPCODE_KEY
	   into :sCode, :ll_opcode_key
	  from cen_airline_opcodes 
	where nairline_key = :uo_change.lAirlinekey 
	    and ndefault = 1;
	
	If SQLCA.SQLCode = 0 then
		If ll_opcode_key > 0 Then
			uo_change.dsCenOut.SetItem(1, "copcode", sCode) 
			uo_change.dsCenOut.SetItem(1, "nopcode_key",  ll_opcode_key)
		End if	
	End If

	uo_change.of_generate_qp()
	
	lidel =0

	for i = uo_change.dsCenOutQP.rowcount() to 1 step -1
		if f_dt_diff(datetime(today(),now()), uo_change.dsCenOutQP.getitemdatetime(i, "drun_at"))<0 then
			
			if  lidel =0 then
				 lidel =1
				 continue
			else
				uo_change.dsCenOutQP.deleterow(i)
			end if
		end if
	next

	if uo_change.of_checkpt_exists(uo_change.lAirlineKey, uo_change.sUnit)   then
		uo_change.of_create_checkpts()
	end if
	
	uo_change.dsCenOut.setitemstatus( 1, 0, primary!, New!)

	delete from cen_out_keys 
	where nresult_key = :uo_change.lResultKey;
	
	delete from cen_out_history 
	where nresult_key = :uo_change.lResultKey 
	    and ntransaction = :uo_change.lTransActionKey	;

	If not uo_change.of_update() Then
		liReturn = -1 
	End if

	if liReturn >= 0 then 
		If not  uo_change.of_update_history() Then
			liReturn = -1 
		End if
	end if

	if liReturn >= 0 then 
		uo_change.of_generate_explosionjobs(1)
	end if

	if liReturn >= 0 then 

		DateTime dtStamp
		String	sHoursBefore
		
		dtStamp 			= Datetime(Today(), Now())
		sHoursBefore 	= f_time_difference(string(now(),"hh:mm"), uo_change.dsCenOut.GetItemString(1, "csort_time"))

		INSERT INTO cen_out_changes ( nresult_key, ntransaction, nflight, ndate_time, nregistration, nrampbox, naircrafttype, nhandling, nversion,   
												 	npassenger, nmeal, nspml, nextra, ntextinfo, nnewspaper, nchange_no_meals, nchange_no_extra, nchange_no_news,   
													 nstatus, chours_before, cusername, cipaddress, dtimestamp, nflight_status, nmeal_billing, nspml_billing, nextra_billing,
													 nnew_flight, nadd_delivery)  
													  VALUES ( :uo_change.lResultKey, :uo_change.ltransactionkey, 1, 0, 0, 0, 0, 0, 0, 
													 0, 1, 0, 1, 0, 0, 0, 0, 0, 
													 :iStatus, :sHoursBefore, :s_app.sUser, :s_app.sHost, :dtStamp, 2, 0, 0, 0,
													 1, 0)  ;
		
		if sqlca.sqlcode <> 0 then
			liReturn = -1
		end if
	end if 

	if liReturn >= 0 then 
		if not uo_messages.uf_generate_message(uo_change.sUnit, uo_change.lResultKey, uo_change.lTransActionKey, uo_change.lLegNumber) then
			//uf.mbox("Achtung","Fehler beim Versenden von $$HEX1$$c400$$ENDHEX$$nderungsmitteilungen.", StopSign!)
	
			liReturn = -2
		else
			liReturn = 0 
		end if
	end if 

	Destroy(uo_change)


else
	Destroy(uo_change)

	return 0
end if

return 1
end function

public function integer wf_regenerate_paclos (date arg_ddeparture, string arg_cairline, long arg_nflight_number, string arg_csuffix, string arg_ctlc_from, string arg_ctlc_to, integer arg_nleg_number, long arg_nresult_key, long arg_nresult_key_group, long arg_nairline_key, date arg_dgeneration_date);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_flight_calculation
// Methode: wf_regenerate_paclos (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// date arg_ddeparture
//  string arg_cairline
//  long arg_nflight_number
//  string arg_csuffix
//  string arg_ctlc_from
//  string arg_ctlc_to
//  integer arg_nleg_number
//  long arg_nresult_key
//  long arg_nresult_key_group
//  long arg_nairline_key
//  date arg_dgeneration_date
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  01.06.2016	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------


uo_generate_datastore 	lds_CenOutPackets						
uo_generate_datastore 	lds_CenOutLOS							
datastore 					lds
long 							i
                  
lds_CenOutPackets = create uo_generate_datastore
lds_CenOutPackets.DataObject = "dw_cen_out_packets"
lds_CenOutPackets.SetTransObject(SQLCA)

lds_CenOutLOS = create uo_generate_datastore
lds_CenOutLOS.DataObject = "dw_cen_out_los"
lds_CenOutLOS.SetTransObject(SQLCA)

lds = create datastore

// --------------------------------------------------------------------------------------------------------------------
// Step 1: Packets
// --------------------------------------------------------------------------------------------------------------------
lds.dataobject="dw_cfs_flight_packets"
lds.settransobject(SQLCA)
lds.retrieve(arg_dgeneration_date, arg_ddeparture, arg_cairline, arg_nflight_number, arg_csuffix, arg_ctlc_from, arg_ctlc_to, arg_nleg_number, arg_nresult_key, arg_nresult_key_group, arg_nairline_key)

DELETE FROM cen_out_packets  
          WHERE cen_out_packets.nresult_key = :arg_nresult_key ;

f_Log2Csv(0,1,"[wf_regenerate_paclos] "+string(sqlca.sqlnrows )+" Packages deleted")

if lds.rowcount()> 0 then
	i =  lds.rowscopy(1,lds.rowcount(),primary!, lds_CenOutPackets, 1, primary!)	
	if i<>1 then
		f_Log2Csv(0,1,"[wf_regenerate_paclos] error copy "+string(lds.rowcount())+" cfs-packets to flight")
	else
		If lds_CenOutPackets.Update() <> 1 Then
			f_Log2Csv(0,1,"[wf_regenerate_paclos] Save Packages with error " + &
		 						"sqlcode : " + string( lds_CenOutPackets.lSQLErrorDBCode) + "~n" + lds_CenOutPackets.sSQLErrorText)
			rollback ;
			
			destroy lds
			destroy lds_CenOutPackets
			destroy lds_CenOutLOS

			return 0
		else		
			f_Log2Csv(0,1,"[wf_regenerate_paclos] "+string(lds.rowcount())+" Packages saved succesful")
		end if
	end if
end if

// --------------------------------------------------------------------------------------------------------------------
// Step 2: LOS
// --------------------------------------------------------------------------------------------------------------------
lds.dataobject="dw_cfs_flight_los"
lds.settransobject(SQLCA)
lds.retrieve(arg_dgeneration_date, arg_ddeparture, arg_cairline, arg_nflight_number, arg_csuffix, arg_ctlc_from, arg_ctlc_to, arg_nleg_number, arg_nresult_key, arg_nresult_key_group)

DELETE FROM cen_out_los  
          WHERE cen_out_los.nresult_key = :arg_nresult_key ;

f_Log2Csv(0,1,"[wf_regenerate_paclos] "+string(sqlca.sqlnrows )+" LOS deleted")

if lds.rowcount()> 0 then
	i =  lds.rowscopy(1,lds.rowcount(),primary!, lds_CenOutLOS, 1, primary!)	
	if i<>1 then
		f_Log2Csv(0,1,"[of_write_cen_out_packets_los] error copy "+string(lds.rowcount())+" cfs-los to flight")
	else
		If lds_CenOutLOS.update() <> 1 Then
			f_Log2Csv(0,1,"[wf_regenerate_paclos] Save LOS with error " + &
		 						"sqlcode : " + string( lds_CenOutLOS.lSQLErrorDBCode) + "~n" + lds_CenOutLOS.sSQLErrorText)
			rollback ;
			
			destroy lds
			destroy lds_CenOutPackets
			destroy lds_CenOutLOS

			return 0
		else		
			f_Log2Csv(0,1,"[wf_regenerate_paclos] "+string(lds.rowcount())+" LOS saved succesful")
		end if
	end if
end if

destroy lds
destroy lds_CenOutPackets
destroy lds_CenOutLOS

garbagecollect()

return 1

end function

public function integer of_process_freeze (long al_job_nr, long al_result_key);
/* 
* Function: 			of_process_freeze
* Beschreibung: 	...
* Besonderheit: 	...
*
* Argumente:
* 		arg_name 	Beschreibung
*
* Aenderungshistorie:
* 	Version 	Wer					Wann			Was und warum
*	1.0 		Thomas Schaefer	08.08.2016	Erstellung
*	1.1 		Thomas Schaefer	20.01.2017	ReturnCode Freeze-Sync Pr$$HEX1$$fc00$$ENDHEX$$fung eingebaut
*
* Return Codes:
*	 ...
*/

Integer		li_ret = 0
Integer		li_row
Long			ll_count
Long			ll_transaction
Long			ll_area
Long			ll_workstation
String			ls_msg
String			ls_msg2
Boolean		lb_sync

IF Not IsValid(dsJobs) THEN Return -1

wf_chc_trace(1,"[of_process_freeze] al_job_nr: " + String (al_job_nr))

// Checken, ob grad ne Online Explosion l$$HEX1$$e400$$ENDHEX$$uft fuer diesen Flug. Wenn ja, raus
select count(*) into :ll_count from sys_explosion where nresult_key = :al_result_key and nprocess_status < 3;
IF sqlca.sqlcode < 0 THEN
	Return -1
END IF
IF ll_count > 0 THEN
	// Online-Explosion l$$HEX1$$e400$$ENDHEX$$uft. Job-Status auf Retry setzen, damit der Job nachher nochmal ausgef$$HEX1$$fc00$$ENDHEX$$hrt werden kann.
	li_row = dsJobs.Find("njob_nr = " + String(al_job_nr), 1, dsJobs.RowCount())
	dsJobs.SetItem(li_row, "nprocess_status", 4)
	f_Log2Csv(0,1,"[of_process_freeze] Running Online-Explosion for nesult_key " + String(al_result_key) + ". Process Status set to 4 (retry).")
	this.sreturn_error_message = ": Running Online-Explosion for Flight ${" + this.sFlightText + "} !"
	this.sreturn_error_message_short = "Running Online-Explosion for Flight!"
	this.is_web_message = uf.translate("Running Online-Explosion for Flight")
	
	of_log_jobstate(ii_log_warning, uf.translate("Waiting for Online-Explosion")) // 11.11.2019 HR: Logging eingebaut
	
	Return -10		
END IF

// --------------------------------------------------------------------------------------------------------------------
// 25.10.2019 HR: Jetzt schauen wir, ob es auch noch offene MZVs gibt
// 08.11.2019 HR: Aber nur wenn der Schalter a ist
// --------------------------------------------------------------------------------------------------------------------
if gb_wait_for_mzv then
	select count(*) into :ll_count from sys_queue_flight_calc where nresult_key = :al_result_key and nprocess_status < 3 and nfunction = 10;
	IF sqlca.sqlcode < 0 THEN
		Return -1
	END IF
	IF ll_count > 0 THEN
		// MZV Jobs offen. Job-Status auf Retry setzen, damit der Job nachher nochmal ausgef$$HEX1$$fc00$$ENDHEX$$hrt werden kann.
		li_row = dsJobs.Find("njob_nr = " + String(al_job_nr), 1, dsJobs.RowCount())
		dsJobs.SetItem(li_row, "nprocess_status", 4)
		f_Log2Csv(0,1,"[of_process_freeze] Open MZV Jobs for nesult_key " + String(al_result_key) + ". Process Status set to 4 (retry).")
		this.sreturn_error_message = ": Open MZV Jobs for Flight ${" + this.sFlightText + "} !"
		this.sreturn_error_message_short = "Open MZV Jobs for Flight!"
		this.is_web_message = uf.translate("Open MZV Jobs for Flight")
		of_log_jobstate(ii_log_warning, uf.translate("Waiting for MZV")) // 11.11.2019 HR: Logging eingebaut

		Return -10		
	END IF
end if

// Transaction holen
SELECT ntransaction INTO :ll_transaction FROM cen_out WHERE nresult_key = :al_result_key;

// Freeze
ll_area			= -1 // Alle Bereiche
ll_workstation	= -1 // Alle Arbeitspl$$HEX1$$e400$$ENDHEX$$tze
DECLARE freeze_flight PROCEDURE FOR cbase_ppm.pf_freeze_flight(:al_result_key, :ll_transaction, :ll_area, :ll_workstation) USING SQLCA;
IF  SQLCA.sqlcode <> 0 THEN
	f_Log2Csv(0,1,"[of_process_freeze] Error DECLAREing Procedure cbase_ppm.pf_freeze_flight: " + SQLCA.SQLErrText)
	this.sreturn_error_message = ": Error during Freeze Flight"
	this.sreturn_error_message_short = "Error during Freeze Flight"
	this.is_web_message = uf.translate("Error during Freeze Flight")
	of_log_jobstate(ii_log_fehler, this.is_web_message)
	Return -1
END IF

EXECUTE freeze_flight;
IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
	ls_msg = "Fehler beim Flug (resultkey:"+string(al_result_key)+", transaction:"+string(ll_transaction)+") einfrieren. (EXECUTE) "+string( SQLCA.sqlcode) +" "+f_check_null(SQLCA.sqlerrtext)
	f_Log2Csv(0,1,"[of_process_freeze] " + ls_msg)
	this.sreturn_error_message = ": Error during Freeze Flight"
	this.sreturn_error_message_short = "Error during Freeze Flight"
	this.is_web_message = uf.translate("Error during Freeze Flight")
	of_log_jobstate(ii_log_fehler, this.is_web_message)
	Return -1
END IF

fetch freeze_flight into :ll_count;

 
// Unterscheidung Freeze oder Sync: Falls ein Sync lief, wurde auf den ReturnCode vom Sync 100.000 daufaddiert. D.h. 99.999 bedeutet dann: Fehler
// und alles > 99.999 ist die Anzahl an Rows, die der Sync inserted / updated hat
IF ll_count >= 99999 THEN
	lb_Sync = True
	ll_count = ll_count - 100000
END IF

IF ll_count > 0 THEN
	IF lb_sync THEN
		ls_msg = "Freeze-Daten wurden synchronisiert"
		ls_msg2 = "Freeze-Data synchronized"
	ELSE
		ls_msg = "Flug wurde eingefroren"
		ls_msg2 = "Successful freeze for Flight"
	END IF
	f_Log2Csv(0,1,"[of_process_freeze]" + ls_msg)
	this.sreturn_error_message = ": " +  + ls_msg2 + " ${" + this.sFlightText + "} !"
	this.sreturn_error_message_short = ls_msg2
	this.is_web_message = uf.translate(ls_msg)
	of_log_jobstate(ii_log_info, this.is_web_message)
ELSE
	IF lb_sync THEN
		ls_msg = "Freeze-Daten-Synchronisierung: keine $$HEX1$$c400$$ENDHEX$$nderungen n$$HEX1$$f600$$ENDHEX$$tig f$$HEX1$$fc00$$ENDHEX$$r Flug (resultkey:"+string(al_result_key)+", transaction:"+string(ll_transaction)+") "
		ls_msg2 = "Freeze-Daten-Synchronisierung: keine $$HEX1$$c400$$ENDHEX$$nderungen n$$HEX1$$f600$$ENDHEX$$tig"
	ELSE
		ls_msg = "Keine FREEZE-Daten f$$HEX1$$fc00$$ENDHEX$$r Flug (resultkey:"+string(al_result_key)+", transaction:"+string(ll_transaction)+") "
		ls_msg2 = "Keine FREEZE-Daten f$$HEX1$$fc00$$ENDHEX$$r Flug"
	END IF
	f_Log2Csv(0,1,"[of_process_freeze] " + ls_msg)
	this.sreturn_error_message = ": " + ls_msg2 + " ${" + this.sFlightText + "} !"
	this.sreturn_error_message_short = ls_msg2 + "!"
	this.is_web_message = uf.translate(ls_msg2)
	of_log_jobstate(ii_log_info, this.is_web_message)
END IF

CLOSE freeze_flight;

Return 1

end function

public function integer of_check_schedule_validity (date arg_ddeparture);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_flight_calculation
// Methode: of_check_schedule_validity (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// date arg_ddeparture
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Pr$$HEX1$$fc00$$ENDHEX$$fen, ob die Beladedefiniton f$$HEX1$$fc00$$ENDHEX$$r den Flug noch 
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  07.02.2018	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

long 	ll_tlc_from, ll_tlc_to, ll_routing_group_key, ll_routingdetail_key, ll_nroutingdetail_key_cp, i
long	llroutingplan_index_key, ll_airline_key, ll_flightnr, ll_legnr, ll_ncfs
  
 llroutingplan_index_key = dw_single.GetItemNumber(dw_single.Getrow(), "nroutingplan_index")
 ll_airline_key = dw_single.GetItemNumber(dw_single.Getrow(), "nairline_key")
 
SELECT count(*)  
 INTO :i  
 FROM cen_routingplan_definition  
WHERE ( nroutingplan_index = :llroutingplan_index_key ) AND  
		( nairline_key = :ll_airline_key ) AND  
		( :arg_ddeparture between trunc(dvalid_from) and trunc(dvalid_to) )   ;

if i=0 then
	//G$$HEX1$$fc00$$ENDHEX$$ltigkeit der Beladedefinition wurde ver$$HEX1$$e400$$ENDHEX$$ndert und der Flugtag geh$$HEX1$$f600$$ENDHEX$$rt nicht mehr zur generierten G$$HEX1$$fc00$$ENDHEX$$ltigkeit
	//Dann m$$HEX1$$fc00$$ENDHEX$$ssen wir neue Schl$$HEX1$$fc00$$ENDHEX$$ssel holen
	
	SELECT  nroutingplan_index, ncfs  
	     INTO :llroutingplan_index_key, :ll_ncfs 
        FROM cen_routingplan_definition  
     WHERE ( nairline_key = :ll_airline_key ) AND  
			   ( :arg_ddeparture between trunc(dvalid_from) and trunc(dvalid_to) )   ;
	
	if sqlca.sqlcode=100 then 
		//Keine g$$HEX1$$fc00$$ENDHEX$$ltige Beladedefinition
		ll_routingdetail_key 		= -1
		ll_nroutingdetail_key_cp 	= -1
	else
		ll_routingdetail_key 		= 0
		ll_nroutingdetail_key_cp 	= 0 

		//Kommen die Detail $$HEX1$$fc00$$ENDHEX$$ber die Flugnummer?
		if  dw_single.GetItemNumber(dw_single.Getrow(), "nroutingdetail_key") > 0 then
			ll_flightnr 				=  dw_single.GetItemNumber(dw_single.Getrow(), "nflight_number")
			ll_legnr					=  dw_single.GetItemNumber(dw_single.Getrow(), "nleg_number")
			ll_tlc_from				=  dw_single.GetItemNumber(dw_single.Getrow(), "ntlc_from")
			ll_tlc_to					=  dw_single.GetItemNumber(dw_single.Getrow(), "ntlc_to")
			ll_routing_group_key	=  dw_single.GetItemNumber(dw_single.Getrow(), "nrouting_group_key")
			
			if ll_ncfs = 0 then
				  SELECT cen_routingplan.nroutingdetail_key  
					 INTO :ll_routingdetail_key  
					 FROM cen_routingplan  
					WHERE ( cen_routingplan.nroutingplan_index = :llroutingplan_index_key ) AND  
								( cen_routingplan.nairline_key = :ll_airline_key ) AND  
								( cen_routingplan.nflight_number = :ll_flightnr ) AND  
								( cen_routingplan.nleg_number = :ll_legnr ) AND  
								( cen_routingplan.nrouting_group_key = :ll_routing_group_key )   and 
								(cen_routingplan.ntlc_to = :ll_tlc_to )   and 
								(cen_routingplan.ntlc_from = :ll_tlc_from )   ;
	
				if sqlca.sqlcode<>0 then
					// --------------------------------------------------------------------------------------------------------------------
					// 08.10.2010 HR: Group-Key nicht gefunden, dann schauen wir nochmal, ob
					//						es den Flug mit einem anderen Groupkey gibt
					// --------------------------------------------------------------------------------------------------------------------
					SELECT min(cen_routingplan.nroutingdetail_key )
					 INTO :ll_routingdetail_key  
					 FROM cen_routingplan  
					WHERE ( cen_routingplan.nroutingplan_index = :llroutingplan_index_key ) AND  
								( cen_routingplan.nairline_key = :ll_airline_key ) AND  
								( cen_routingplan.nflight_number = :ll_flightnr ) AND  
								( cen_routingplan.nleg_number = :ll_legnr ) AND  
								(cen_routingplan.ntlc_to = :ll_tlc_to )   and 
								(cen_routingplan.ntlc_from = :ll_tlc_from )   ;
					
					if sqlca.sqlcode<>0 then
						ll_routingdetail_key = -1
					else
						select cen_routingplan.nrouting_group_key
							into :ll_routing_group_key
						from cen_routingplan 
						where cen_routingplan.nroutingdetail_key = :ll_routingdetail_key ;
					end if
				end if
			else
				// Hier das ganze f$$HEX1$$fc00$$ENDHEX$$r CFS
				
				
			end if
		end if
		
		//Kommen die Detail $$HEX1$$fc00$$ENDHEX$$ber Citypair?
		if  dw_single.GetItemNumber(dw_single.Getrow(), "nroutingdetail_key_cp") > 0 then
			ll_flightnr 				= -1
			ll_tlc_from				= dw_single.GetItemNumber(dw_single.Getrow(), "ntlc_from")
			ll_tlc_to					= dw_single.GetItemNumber(dw_single.Getrow(), "ntlc_to")
			ll_routing_group_key	= dw_single.GetItemNumber(dw_single.Getrow(), "nrouting_group_key_cp")
			ll_legnr					= dw_single.GetItemNumber(dw_single.Getrow(), "nleg_number")
			
			if ll_ncfs = 0 then
				  SELECT cen_routingplan.nroutingdetail_key 
					 INTO :ll_nroutingdetail_key_cp  
					 FROM cen_routingplan  
					WHERE ( cen_routingplan.nroutingplan_index = :llroutingplan_index_key ) AND  
							( cen_routingplan.nairline_key = :ll_airline_key ) AND  
							( cen_routingplan.nflight_number = :ll_flightnr ) AND  
							( cen_routingplan.nrouting_group_key = :ll_routing_group_key )   and 
							(cen_routingplan.ntlc_to = :ll_tlc_to )   and 
							(cen_routingplan.ntlc_from = :ll_tlc_from )   ;
	
				if sqlca.sqlcode<>0 then
					// --------------------------------------------------------------------------------------------------------------------
					// 08.10.2010 HR: Group-Key nicht gefunden, dann schauen wir nochmal, ob
					//						es den CityPair mit einem anderen Groupkey gibt
					// --------------------------------------------------------------------------------------------------------------------
					SELECT min(cen_routingplan.nroutingdetail_key)
					 INTO :ll_nroutingdetail_key_cp 
					 FROM cen_routingplan  
					WHERE ( cen_routingplan.nroutingplan_index = :llroutingplan_index_key ) AND  
							( cen_routingplan.nairline_key = :ll_airline_key ) AND  
							( cen_routingplan.nflight_number = :ll_flightnr ) AND  
							(cen_routingplan.ntlc_to = :ll_tlc_to )   and 
							(cen_routingplan.ntlc_from = :ll_tlc_from )   ;
					
					if sqlca.sqlcode<>0 then
						ll_nroutingdetail_key_cp = -1
					else
						select cen_routingplan.nrouting_group_key
							into :ll_routing_group_key
						from cen_routingplan 
						where cen_routingplan.nroutingdetail_key = :ll_nroutingdetail_key_cp; 
					end if
				end if
			else
				// Hier das ganze f$$HEX1$$fc00$$ENDHEX$$r CFS
				
			end if
		end if
	end if

	if isnull(ll_routingdetail_key) then  ll_routingdetail_key =-1
	if isnull(ll_nroutingdetail_key_cp) then  ll_nroutingdetail_key_cp =-1
		
	if ll_routingdetail_key =-1 or ll_nroutingdetail_key_cp =-1 then
		wf_chc_trace(1,"[of_check_schedule_validity] Fehler beim Ermitteln der Flugschl$$HEX1$$fc00$$ENDHEX$$ssel, da die G$$HEX1$$fc00$$ENDHEX$$ltigkeit der Beladedefinition ge$$HEX1$$e400$$ENDHEX$$ndert wurde. Alte Werte werden weiter benutzt.")
	else
		dw_single.SetItem(dw_single.Getrow(), "nroutingdetail_key",ll_routingdetail_key) 
		dw_single.SetItem(dw_single.Getrow(), "nroutingdetail_key_cp",ll_nroutingdetail_key_cp)
		dw_single.SetItem(dw_single.Getrow(), "nroutingplan_index",llroutingplan_index_key)
		
		// 08.10.2010 HR: Auch den ggf. ge$$HEX1$$e400$$ENDHEX$$nderten GroupKey zur$$HEX1$$fc00$$ENDHEX$$ckschreiben
		dw_single.SetItem(dw_single.Getrow(), "nrouting_group_key",ll_routing_group_key )
	end if
end if

return 1
end function

public function integer of_retrieve_bob_figures (long arg_lresult_key);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_flight_calculation
// Methode: of_retrieve_bob_figures (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long arg_lresult_key
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung: Funktion zum $$HEX1$$dc00$$ENDHEX$$betragen den CITP BOB Zahlen in die BOB-Struktur zur weiteren
//                       Verarbeitung
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  26.02.2019	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

uo_generate_datastore				ldsBobSched
uo_generate_datastore				ldsBobPaxCount
long										ll_flight_key, ll_seq
integer									li_row, li_found
string										ls_find

dsSysQueueFlightBob.retrieve(ilJobNr, arg_lresult_key)

if dsSysQueueFlightBob.rowcount()=0 then return 1

ldsBobSched = create uo_generate_datastore
ldsBobSched.dataobject = "dw_bob_schedule"
ldsBobSched.settransobject( SQLCA)
ldsBobSched.retrieve(arg_lresult_key)

if ldsBobSched.rowcount()=0 then
	ll_flight_key = f_sequence("SEQ_CEN_BOB_SCHEDULE", SQLCA)
	
	if ll_flight_key = -1 then
		f_log2csv(0,0, "[of_retrieve_bob_figures] Fehler bei der Ermittlung der SEQ_CEN_BOB_SCHEDULE" )
		destroy ldsBobSched
		return 0
	end if		
	
	INSERT INTO cen_bob_schedule  ( nflight_key, nsystem_key, cclient, cairline, nflight_number, csuffix, ddeparture, ctlc_from, ctlc_to, dorder_time, dtimestamp, nairline_key, nsource )  
  			SELECT :ll_flight_key, 2, cen_out.cclient, cen_out.cairline, cen_out.nflight_number, cen_out.csuffix, cen_out.ddeparture, cen_out.ctlc_from, cen_out.ctlc_to, sysdate, sysdate, cen_out.nairline_key, 1  
                FROM cen_out  
              WHERE cen_out.nresult_key = :arg_lresult_key   ;

	if sqlca.sqlcode <> 0 then
		f_log2csv(0,0, "[of_retrieve_bob_figures] Fehler bei der Anlage cen_bob_schedule (" + string(sqlca.sqlcode)+") "+sqlca.sqlerrtext )
		destroy ldsBobSched
		return 0
	end if	
else
	ll_flight_key = ldsBobSched.getitemnumber(1, "nflight_key")
end if

ldsBobPaxCount = create uo_generate_datastore
ldsBobPaxCount.dataobject = "dw_bob_pax_counts"
ldsBobPaxCount.settransobject( SQLCA)
ldsBobPaxCount.retrieve(ll_flight_key, arg_lresult_key)

for li_row = 1 to dsSysQueueFlightBob.rowcount()
	
	ls_find = "nclass_number = " + string( dsSysQueueFlightBob.getitemnumber(li_row, "cen_out_pax_nclass_number") )
	ls_find += " and cpackinglist = '"+ dsSysQueueFlightBob.getitemstring(li_row, "cbob_type") + "' "
	
	li_found = ldsBobPaxCount.find(ls_find, 1, ldsBobPaxCount.rowcount())
	if li_found > 0 then
		ldsBobPaxCount.setitem(li_found, "nfound", 1)
	else
		ll_seq =  f_sequence("SEQ_CEN_BOB_PAX_COUNTS", SQLCA)
		if ll_seq = -1 then
			f_log2csv(0,0, "[of_retrieve_bob_figures] Fehler bei der Ermittlung der SEQ_CEN_BOB_PAX_COUNTS" )
			destroy ldsBobSched
			destroy ldsBobPaxCount
			return 0
		end if		
		
		li_found = ldsBobPaxCount.insertrow(0)
		ldsBobPaxCount.setitem(li_found, "npax_counts_key", ll_seq)
		ldsBobPaxCount.setitem(li_found, "nflight_key", ll_flight_key)
		ldsBobPaxCount.setitem(li_found, "ctext", dsSysQueueFlightBob.getitemstring(li_row, "cen_out_pax_cclass") )
		ldsBobPaxCount.setitem(li_found, "cclass", dsSysQueueFlightBob.getitemstring(li_row, "cen_out_pax_cclass"))
		ldsBobPaxCount.setitem(li_found, "nclass_number",  dsSysQueueFlightBob.getitemnumber(li_row, "cen_out_pax_nclass_number"))
		ldsBobPaxCount.setitem(li_found, "nbooking_class", dsSysQueueFlightBob.getitemnumber(li_row, "cen_out_pax_nbooking_class"))
		ldsBobPaxCount.setitem(li_found, "cpackinglist", dsSysQueueFlightBob.getitemstring(li_row, "cbob_type"))
	end if

	ldsBobPaxCount.setitem(li_found, "nfixed_qty",  dsSysQueueFlightBob.getitemnumber(li_row, "namount"))
	ldsBobPaxCount.setitem(li_found, "dtimestamp", f_jetzt())
	ldsBobPaxCount.setitem(li_found, "nfound", 1)
next
 
for li_row =  ldsBobPaxCount.rowcount() to 1 step -1
	if ldsBobPaxCount.getitemnumber(li_found, "nfound") = 1 then continue
	ldsBobPaxCount.deleterow(li_row)
next

ldsBobPaxCount.update()

destroy ldsBobSched
destroy ldsBobPaxCount


return 1

end function

public function integer of_set_unit_language (string arg_cunit);string ls_Setting
integer li_language
ls_Setting = f_mandant_profilestring(sqlca, s_app.sMandant, "General", "UseAddLanguage", "0")

If ls_Setting <> "1" Then 
	s_app.ipllanguage = 1
else
	select ndefault_pl_language
		into :li_language
		from sys_units 
		where cunit = :arg_cunit;
	
	If isnull(li_language) Then li_language = 1
	if li_language <= 0 Then li_language = 1		

	s_app.ipllanguage = li_language
end if

return 1
end function

public function integer of_process_preprod_freeze (long al_job_nr, long al_result_key);
/* 
* Function: 			of_process_preprod_freeze
* Beschreibung: 	...
* Besonderheit: 	...
*
* Argumente:
* 		arg_name 	Beschreibung
*
* Aenderungshistorie:
* 	Version 	Wer					Wann			Was und warum
*	1.0 		Thomas Schaefer	26.03.2019	Erstellung
*
* Return Codes:
*	 ...
*/

Long			ll_ret = 0
Integer		li_row
Long			ll_count
Long			ll_transaction
String			ls_msg
String			ls_msg2
Boolean		lb_sync

IF Not IsValid(dsJobs) THEN Return -1

wf_chc_trace(1,"[of_process_preprod_freeze] al_job_nr: " + String (al_job_nr))

// Checken, ob grad ne Online Explosion l$$HEX1$$e400$$ENDHEX$$uft fuer diesen Flug. Wenn ja, raus
select count(*) into :ll_count from sys_explosion where nresult_key = :al_result_key and nprocess_status < 3;
IF sqlca.sqlcode < 0 THEN
	Return -1
END IF
IF ll_count > 0 THEN
	// Online-Explosion l$$HEX1$$e400$$ENDHEX$$uft. Job-Status auf Retry setzen, damit der Job nachher nochmal ausgef$$HEX1$$fc00$$ENDHEX$$hrt werden kann.
	li_row = dsJobs.Find("njob_nr = " + String(al_job_nr), 1, dsJobs.RowCount())
	dsJobs.SetItem(li_row, "nprocess_status", 4)
	f_Log2Csv(0,1,"[of_process_preprod_freeze] Running Online-Explosion for nesult_key " + String(al_result_key) + ". Process Status set to 4 (retry).")
	this.sreturn_error_message = ": Running Online-Explosion for Flight ${" + this.sFlightText + "} !"
	this.sreturn_error_message_short = "Running Online-Explosion for Flight!"
	this.is_web_message = uf.translate("Running Online-Explosion for Flight")
	
	of_log_jobstate(ii_log_warning, uf.translate("Waiting for Online-Explosion")) // 11.11.2019 HR: Logging eingebaut

	Return -10		
END IF

// Transaction holen
SELECT ntransaction INTO :ll_transaction FROM cen_out WHERE nresult_key = :al_result_key;

// Freeze
DECLARE freeze_preprod PROCEDURE FOR cbase_ppm_preprod.pf_freeze_preprod(:al_result_key, :ll_transaction) USING SQLCA;
IF  SQLCA.sqlcode <> 0 THEN
	f_Log2Csv(0,1,"[of_process_preprod_freeze] Error DECLAREing Procedure cbase_ppm_preprod.pf_freeze_preprod: " + SQLCA.SQLErrText)
	this.sreturn_error_message = ": Error during Freeze Preprod"
	this.sreturn_error_message_short = "Error during Freeze Preprod"
	this.is_web_message = uf.translate("Error during Freeze Preprod")
	of_log_jobstate(ii_log_fehler, this.is_web_message)
	Return -1
END IF

EXECUTE freeze_preprod;
IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
	ls_msg = "Fehler beim Flug (resultkey:"+string(al_result_key)+", transaction:"+string(ll_transaction)+") Preproduktion einfrieren. (EXECUTE) "+string( SQLCA.sqlcode) +" "+f_check_null(SQLCA.sqlerrtext)
	f_Log2Csv(0,1,"[of_process_preprod_freeze] " + ls_msg)
	this.sreturn_error_message = ": Error during Freeze Preprod"
	this.sreturn_error_message_short = "Error during Freeze Preprod"
	this.is_web_message = uf.translate("Error during Freeze Preprod")
	of_log_jobstate(ii_log_fehler, this.is_web_message)
	Return -1
END IF

fetch freeze_preprod into :ll_ret;

IF ll_ret < 0 THEN
	ls_msg = "Fehler beim Flug (resultkey:"+string(al_result_key)+", transaction:"+string(ll_transaction)+") Preproduktion einfrieren. (EXECUTE) "+string( SQLCA.sqlcode) +" "+f_check_null(SQLCA.sqlerrtext)
	f_Log2Csv(0,1,"[of_process_preprod_freeze] " + ls_msg)
	this.sreturn_error_message = ": Error during Freeze Preprod"
	this.sreturn_error_message_short = "Error during Freeze Preprod"
	this.is_web_message = uf.translate("Error during Freeze Preprod")
	of_log_jobstate(ii_log_fehler, this.is_web_message)
ELSEIF ll_ret > 0 THEN
	ls_msg = "Flug Preproduktion wurde eingefroren"
	f_Log2Csv(0,1,"[of_process_preprod_freeze]" + ls_msg)
	this.sreturn_error_message = ": " +  + ls_msg2 + " ${" + this.sFlightText + "} !"
	this.sreturn_error_message_short = ls_msg2
	this.is_web_message = uf.translate(ls_msg)
	of_log_jobstate(ii_log_info, this.is_web_message)
ELSE
	ls_msg = "Keine Preprod-FREEZE-Daten f$$HEX1$$fc00$$ENDHEX$$r Flug (resultkey:"+string(al_result_key)+", transaction:"+string(ll_transaction)+") "
	ls_msg2 = "Keine Preprod-FREEZE-Daten f$$HEX1$$fc00$$ENDHEX$$r Flug"
	f_Log2Csv(0,1,"[of_process_preprod_freeze] " + ls_msg)
	this.sreturn_error_message = ": " + ls_msg2 + " ${" + this.sFlightText + "} !"
	this.sreturn_error_message_short = ls_msg2 + "!"
	this.is_web_message = uf.translate(ls_msg2)
	of_log_jobstate(ii_log_info, this.is_web_message)
END IF

CLOSE freeze_preprod;

Return 1

end function

public function integer of_process_skyscope_copy (long al_result_key);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_flight_calculation
// Methode: of_process_skyscope_copy (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long al_result_key
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  21.02.2020	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

String			ls_msg
integer		li_ret 

IF Not IsValid(dsJobs) THEN Return -1

wf_chc_trace(1,"[of_process_skyscope_copy] Start " )

DECLARE skyscope_copy PROCEDURE FOR CBASE_SKYSCOPE.pp_flight_transfer(:al_result_key, :ilJobNr) USING SQLCA;
IF  SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
	f_Log2Csv(0,1,"[of_process_skyscope_copy] Error DECLAREing Procedure CBASE_SKYSCOPE.pp_flight_transfer: " + SQLCA.SQLErrText)
	this.sreturn_error_message = ": Error during Skyscope Copy"
	this.sreturn_error_message_short = "Error during Skyscope Copy"
	this.is_web_message = uf.translate("Error during Skyscope Copy")
	of_log_jobstate(ii_log_fehler, this.is_web_message)
	Return -1
END IF

EXECUTE skyscope_copy;
IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
	ls_msg = "Fehler beim Skyscope Copy Flug (resultkey:"+string(al_result_key)+". (EXECUTE) "+string( SQLCA.sqlcode) +" "+f_check_null(SQLCA.sqlerrtext)
	f_Log2Csv(0,1,"[of_process_skyscope_copy] " + ls_msg)
	this.sreturn_error_message = ": Error during Skyscope Copy"
	this.sreturn_error_message_short = "Error during Skyscope Copy"
	this.is_web_message = uf.translate("Error during Skyscope Copy")
	of_log_jobstate(ii_log_fehler, this.is_web_message)
	CLOSE skyscope_copy;
	Return -1
END IF

fetch skyscope_copy into :li_ret, :ls_msg;
this.sreturn_error_message_short = ls_msg

CLOSE skyscope_copy;

wf_chc_trace(1,"[of_process_skyscope_copy] Finish with return code: " + string(li_ret) +" => " + this.sreturn_error_message_short)
of_log_jobstate(li_ret, 'Job finished' )

Return 1

end function

public function integer of_process_skyscope_refresh (long al_result_key);// --------------------------------------------------------------------------------------------------------------------
// Objekt : uo_flight_calculation
// Methode: of_process_skyscope_refresh (Function)
// Autor  : Heiko Rothenbach
// --------------------------------------------------------------------------------------------------------------------
// Argument(e):
// long al_result_key
// --------------------------------------------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------------------------------------------
//  Beschreibung:
//
//
// --------------------------------------------------------------------------------------------------------------------
//  Modifikationen:
//  Datum       Version  Autor          Kommentar
// --------------------------------------------------------------------------------------------------------------------
//  21.02.2020	   1.0      H.Rothenbach   Erstellung
//
// --------------------------------------------------------------------------------------------------------------------

String			ls_msg
integer		li_ret 

IF Not IsValid(dsJobs) THEN Return -1

wf_chc_trace(1,"[of_process_skyscope_refresh] Start " )

DECLARE skyscope_refresh PROCEDURE FOR CBASE_SKYSCOPE.pp_flight_refresh(:al_result_key, :ilJobNr) USING SQLCA;
IF  SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100  THEN
	f_Log2Csv(0,1,"[of_process_skyscope_refresh] Error DECLAREing Procedure CBASE_SKYSCOPE.pp_flight_refresh: " + SQLCA.SQLErrText)
	this.sreturn_error_message = ": Error during Skyscope Refresh"
	this.sreturn_error_message_short = "Error during Skyscope Refresh"
	this.is_web_message = uf.translate("Error during Skyscope Refresh")
	of_log_jobstate(ii_log_fehler, this.is_web_message)
	Return -1
END IF

EXECUTE skyscope_refresh;
IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
	ls_msg = "Fehler beim Skyscope Refresh Flug (resultkey:"+string(al_result_key)+". (EXECUTE) "+string( SQLCA.sqlcode) +" "+f_check_null(SQLCA.sqlerrtext)
	f_Log2Csv(0,1,"[of_process_skyscope_refresh] " + ls_msg)
	this.sreturn_error_message = ": Error during Skyscope Refresh"
	this.sreturn_error_message_short = "Error during Skyscope Refresh"
	this.is_web_message = uf.translate("Error during Skyscope Refresh")
	of_log_jobstate(ii_log_fehler, this.is_web_message)
	CLOSE skyscope_refresh;
	Return -1
END IF

fetch skyscope_refresh into :li_ret, :ls_msg;
this.sreturn_error_message_short = ls_msg

CLOSE skyscope_refresh;

wf_chc_trace(1,"[of_process_skyscope_refresh] Finish with return code: " + string(li_ret) +" => " + this.sreturn_error_message_short)
of_log_jobstate(li_ret, 'Job finished' )

Return 1

end function

on uo_flight_calculation.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_flight_calculation.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
long l 

dsSupplierUnits  									= create datastore
dsSupplierUnits.dataobject 						= "dw_uo_ml_auto_supp_unit"
l=dsSupplierUnits.settransobject(SQLCA)

dsCenOut											= Create datastore
dsCenOut.DataObject 							= "dw_uo_ml_auto_cen_out_rel_if"
dsCenOut.SetTransObject(SQLCA)

dsJobs											= Create datastore
//dsJobs.DataObject 							= "dw_job_list_new"
dsJobs.DataObject 							= "dw_job_list_instance" // 19.03.2014 HR: Offene Jobs einer Instance



/* dsCenOutPeriod									= Create datastore
dsCenOutPeriod.DataObject 					= "dw_uo_ml_auto_cen_out_period"
dsCenOutPeriod.SetTransObject(SQLCA) */


dsCenOutHeader		= create datastore
dsCenOutHeader.dataobject = "dw_uo_invoice_flight_header"
dsCenOutHeader.SetTransObject(sqlca)

dsHandling 		= create datastore
dsHandling.dataobject = "dw_uo_invoice_handling"
dsHandling.SetTransObject(sqlca)

dsMeals 			= create datastore	
dsMeals.dataobject = "dw_uo_invoice_meals"
dsMeals.SetTransObject(sqlca)

dsAddLoading 	= create datastore	
dsAddLoading.dataobject = "dw_uo_invoice_meals"
dsAddLoading.SetTransObject(sqlca)

dsSPMLs			= create datastore	
dsSPMLs.dataobject = "dw_uo_invoice_spml"
dsSPMLs.SetTransObject(sqlca)

dsSPMLHeader			= create datastore	
dsSPMLHeader.dataobject = "dw_uo_invoice_spml_header"
dsSPMLHeader.SetTransObject(sqlca)

dsPax			= create datastore	
dsPax.dataobject = "dw_invoice_ml_cen_out_passenger"
dsPax.SetTransObject(sqlca)

dsText			= create datastore	
dsText.dataobject = "dw_uo_invoice_text_info"
dsText.SetTransObject(sqlca)

dsLateOrder			= create datastore	
dsLateOrder.dataobject = "dw_invoice_late_order"
dsLateOrder.SetTransObject(sqlca)

dsDeliveryNote			= create datastore	
dsDeliveryNote.dataobject = "dw_invoice_catering_order"
dsDeliveryNote.SetTransObject(sqlca)

dsCenOutNewsExtra								= Create uo_generate_datastore
dsCenOutNewsExtra.DataObject 				= "dw_cen_out_handling_news_extra"
dsCenOutNewsExtra.SetTransObject(SQLCA)
dsCenOutNewsExtra.ii_LogToFile=1

dsCenOutHandlingNews							= Create uo_generate_datastore
dsCenOutHandlingNews.DataObject 			= "dw_cen_out_handling_news"
dsCenOutHandlingNews.SetTransObject(SQLCA)
dsCenOutHandlingNews.ii_LogToFile=1

dsChangeInformation							= Create DataStore
dsChangeInformation.DataObject 			= "dw_change_information"
dsChangeInformation.SetTransObject(SQLCA)

uo_configurations					= Create uo_get_aircraft_config

// ------------------------------------------------------------------
// Alle G$$HEX1$$fc00$$ENDHEX$$ltigen SPML und Klassen je Airline
// ------------------------------------------------------------------
dsValidSPML										= Create DataStore
dsValidSPML.DataObject 						= "dw_change_valid_spml"
dsValidSPML.SetTransObject(SQLCA)	
dsValidSPML.Retrieve(s_app.sMandant)

// ------------------------------------------------------------------
// Alle G$$HEX1$$fc00$$ENDHEX$$ltigen SPML je Mahlzeitenbaustein
// ------------------------------------------------------------------
dsValidSPMLDetail								= Create DataStore
dsValidSPMLDetail.DataObject 				= "dw_change_valid_spml_details"
dsValidSPMLDetail.SetTransObject(SQLCA)	

							
dsAircaftVersion								= Create DataStore
dsAircaftVersion.DataObject 				= "dw_change_aircraft_version"
dsAircaftVersion.SetTransObject(SQLCA)


dsAircaftCurrentVersion						= Create DataStore
dsAircaftCurrentVersion.DataObject 		= "dw_current_versions"
dsAircaftCurrentVersion.SetTransObject(SQLCA)


dw_single										= Create uo_generate_datastore
dw_single.DataObject 							= "dw_ml_change_cen_out"
dw_single.SetTransObject(sqlca)
dw_single.ii_LogToFile=1


dw_handling									= Create uo_generate_datastore
dw_handling.DataObject 						= "dw_change_cen_out_handling"
dw_handling.SetTransObject(sqlca)
dw_handling.ii_LogToFile=1

dw_catering_order									= Create uo_generate_datastore
dw_catering_order.DataObject 						= "dw_invoice_catering_order"
dw_catering_order.SetTransObject(sqlca)
dw_catering_order.ii_LogToFile=1

dw_pax										= Create uo_generate_datastore
dw_pax.DataObject 						= "dw_invoice_ml_cen_out_passenger"
dw_pax.SetTransObject(sqlca)
dw_pax.ii_LogToFile=1

dw_extra									= Create uo_generate_datastore
dw_extra.DataObject 						= "dw_change_cen_out_meals"
dw_extra.SetTransObject(sqlca)
dw_extra.ii_LogToFile=1

dw_meal									= Create uo_generate_datastore
dw_meal.DataObject 						= "dw_change_cen_out_meals"
dw_meal.SetTransObject(sqlca)
dw_meal.ii_LogToFile=1

dw_spml									= Create uo_generate_datastore
dw_spml.DataObject 						= "dw_change_cen_out_spml"
dw_spml.SetTransObject(sqlca)
dw_spml.ii_LogToFile=1

dw_text_info									= Create uo_generate_datastore
dw_text_info.DataObject 					= "dw_change_cen_out_text"
dw_text_info.SetTransObject(sqlca)
dw_text_info.ii_LogToFile=1

dw_text_infos_areas									= Create uo_generate_datastore
dw_text_infos_areas.DataObject 					= "dw_change_local_area"
dw_text_infos_areas.SetTransObject(sqlca)
dw_text_infos_areas.ii_LogToFile=1

dsSPMLDetail								= Create uo_generate_datastore
dsSPMLDetail.DataObject 					= "dw_cen_out_spml_detail"
dsSPMLDetail.SetTransObject(sqlca)
dsSPMLDetail.ii_LogToFile=1
// ------------------------------------------------------------------
// Datastores zum Sichern der "alten" Mengen
// ------------------------------------------------------------------

dsExtraOld									= Create uo_generate_datastore
//dsExtraOld.DataObject 					= "dw_change_cen_out_meals"
dsExtraOld.DataObject 					= "dw_uo_ml_change_cen_out_meals"
dsExtraOld.SetTransObject(sqlca)
dsExtraOld.ii_LogToFile=1

dsSPMLOld									= Create uo_generate_datastore
//dsSPMLOld.DataObject 					= "dw_change_cen_out_spml"
dsSPMLOld.DataObject 					= "dw_uo_ml_change_cen_out_spml"
dsSPMLOld.SetTransObject(sqlca)
dsSPMLOld.ii_LogToFile=1

dsMealOld									= Create uo_generate_datastore
//dsMealOld.DataObject 					= "dw_change_cen_out_meals"
dsMealOld.DataObject 					= "dw_uo_ml_change_cen_out_meals"
dsMealOld.SetTransObject(sqlca)
dsMealOld.ii_LogToFile=1

dsPaxOld									= Create uo_generate_datastore
dsPaxOld.DataObject 					= "dw_uo_ml_out_cen_out_passenger_history"
dsPaxOld.SetTransObject(sqlca)
dsPaxOld.ii_LogToFile=1

dsSingleOld										= Create uo_generate_datastore
dsSingleOld.DataObject 							= "dw_uo_ml_change_cen_out_history"
dsSingleOld.SetTransObject(sqlca)
dsSingleOld.ii_LogToFile=1

// ------------------------------------------------------------------
// $$HEX1$$dc00$$ENDHEX$$bertragene Datens$$HEX1$$e400$$ENDHEX$$tze ins Abrechnungssystem
// ------------------------------------------------------------------
dsBillingStatus								= Create DataStore
dsBillingStatus.DataObject 				= "dw_sys_billing_status_xml"
dsBillingStatus.SetTransObject(SQLCA)

dsSysQueueFlightPax									= Create DataStore
dsSysQueueFlightPax.DataObject 					= "dw_sys_queue_flight_pax"
dsSysQueueFlightPax.SetTransObject(SQLCA)

dsSysQueueFlightACType							= Create DataStore
dsSysQueueFlightACType.DataObject 			= "dw_sys_queue_flight_actype"
dsSysQueueFlightACType.SetTransObject(SQLCA)

dsSysQueueFlightSpml								= Create DataStore
dsSysQueueFlightSpml.DataObject 				= "dw_sys_queue_flight_spml"
dsSysQueueFlightSpml.SetTransObject(SQLCA)

dsSysQueueFlightCalc								= Create DataStore
dsSysQueueFlightCalc.DataObject 				= "dw_sys_queue_flight_calc"
dsSysQueueFlightCalc.SetTransObject(SQLCA)


dsSysQueueFunctions							= Create DataStore
dsSysQueueFunctions.DataObject 				= "dw_sys_queue_fl_functions"
dsSysQueueFunctions.SetTransObject(SQLCA)


dsClasses							= Create DataStore
dsClasses.DataObject 				= "dw_generate_classes"
dsClasses.SetTransObject(SQLCA)
			
uo_suppl_unit = create uo_suppl_unit_status_release	
//----------------------------------------------------------------------------
// TLE 21.01.2010 datastores f$$HEX1$$fc00$$ENDHEX$$r Nachkalkulation
//----------------------------------------------------------------------------
dw_recalc_meal_recalc									= Create uo_generate_datastore
dw_recalc_meal_recalc.DataObject 						= "dw_recalc_cen_out_meals_recalc"
dw_recalc_meal_recalc.SetTransObject(sqlca)
dw_recalc_meal_recalc.ii_LogToFile=1

dw_recalc_meal											= Create uo_generate_datastore
dw_recalc_meal.DataObject 									= "dw_recalc_cen_out_meals"
dw_recalc_meal.SetTransObject(sqlca)
dw_recalc_meal.ii_LogToFile=1

dw_recalc_extra_recalc									= Create uo_generate_datastore
dw_recalc_extra_recalc.DataObject 						= "dw_recalc_cen_out_meals_recalc"
dw_recalc_extra_recalc.SetTransObject(sqlca)
dw_recalc_extra_recalc.ii_LogToFile=1

dw_recalc_extra											= Create uo_generate_datastore
dw_recalc_extra.DataObject 									= "dw_recalc_cen_out_meals"
dw_recalc_extra.SetTransObject(sqlca)
dw_recalc_extra.ii_LogToFile=1

// --------------------------------------------------------------------------------------------------------------------
// 17.05.2011 HR:
// --------------------------------------------------------------------------------------------------------------------
dsPackets = create Datastore
dsPackets.dataobject="dw_view_packets"
dsPackets.settransobject(SQLCA)

// 20.12.2013 HR:
uo_messages = create uo_message
if s_app.iTrace  > 0 then
	uo_messages.bDebug = true
else
	uo_messages.bDebug = false
end if

// 26.02.2019 HR:
dsSysQueueFlightBob  = create Datastore
dsSysQueueFlightBob.dataobject = "dw_sys_queue_flight_bob"
dsSysQueueFlightBob.settransobject(SQLCA)


end event

event destructor;
Destroy	dsAddLoading 
Destroy	dsAircaftCurrentVersion
Destroy	dsAircaftVersion
Destroy	dsBillingStatus
Destroy	dsCenOut
Destroy	dsCenOutHandlingNews
Destroy	dsCenOutHeader
Destroy	dsCenOutNewsExtra
Destroy	dsChangeInformation
Destroy	dsClasses
Destroy	dsDeliveryNote
Destroy	dsExtraOld
Destroy	dsHandling 
Destroy	dsJobs
Destroy	dsLateOrder
Destroy	dsMealOld
Destroy	dsMeals 
Destroy	dsPackets 
Destroy	dsPax
Destroy	dsPaxOld
Destroy	dsSingleOld
Destroy	dsSPMLDetail
Destroy	dsSPMLHeader
Destroy	dsSPMLOld
Destroy	dsSPMLs
Destroy	dsSupplierUnits
Destroy	dsSysQueueFlightACType
Destroy	dsSysQueueFlightCalc
Destroy	dsSysQueueFlightPax
Destroy	dsSysQueueFlightSPML
Destroy	dsSysQueueFunctions
Destroy	dsText
Destroy	dsValidSPML
Destroy	dsValidSPMLDetail
Destroy	dw_catering_order
Destroy	dw_extra
Destroy	dw_handling
Destroy	dw_meal
Destroy	dw_pax
Destroy	dw_single
Destroy	dw_spml
Destroy	dw_text_info
Destroy	dw_text_infos_areas
Destroy	uo_configurations
Destroy	uo_suppl_unit

if isvalid(dw_recalc_meal) then Destroy dw_recalc_meal							//TLE 21.01.2010
if isvalid(dw_recalc_meal_recalc) then Destroy dw_recalc_meal_recalc		//TLE 21.01.2010
if isvalid(dw_recalc_extra) then Destroy dw_recalc_extra						//TLE 21.01.2010
if isvalid(dw_recalc_extra_recalc) then Destroy dw_recalc_extra_recalc		//TLE 21.01.2010

destroy uo_messages // 20.12.2013 HR:
destroy dsSysQueueFlightBob // 26.02.2019 HR:

garbagecollect()

end event

